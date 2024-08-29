Return-Path: <netdev+bounces-123015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BAE963708
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AD21F24D08
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DC5A92D;
	Thu, 29 Aug 2024 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoKNl0qm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E8C101C4
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724892561; cv=none; b=mg/Ffe0rg9S3+n+/0donjPA06NUU/o3qddArhbufgh20CFiES0X9d0FdPMd+MufuQDO5SlZ4s6DxBvTujbDC395+2WPeZPjJZznk70JSgCgPgU4vPsjnxjw4qOxkIFilKF/r6/olptM8oMcLTUXyK97Nc281kI/I9y/B4VD8d5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724892561; c=relaxed/simple;
	bh=uQP14bhlIxRqTaN+xpZ7u87VLRhHPfjMPW8mr4GvZY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dotWnjsSIEz4ZVIsmCS7ElIWMWmv8NpW6BCke+9n2z4rs/g2HKU2qX0n6Q2fG94qmA5rkEAf/HAXOEFHWJxV5l6jECNlBKK758HlS+pTSkqNiLghWFq1bZHUADUnw/wPRe8ajVHumx6xTmUe66R0ivsLkXptwxE4ZnK6qTRIbyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoKNl0qm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766E5C4CEC0;
	Thu, 29 Aug 2024 00:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724892560;
	bh=uQP14bhlIxRqTaN+xpZ7u87VLRhHPfjMPW8mr4GvZY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KoKNl0qmxwiXXlwH5IkgqEem6c+yl9FG9VTxF1h3JJJ5QBx5L/oi6+kgN5jwLGCzx
	 ETXR0/NBqB8QLSGxNtrLYqCObRA7xgB4H8F6DCyyXuRPD8bovCKnwWv95MqNLRbFpf
	 aIwmAU8cKseYdLiMtWRPdvEnVJrMZMTPlnEQ1XqFtRNOZ0gaer5oNcL5SreubZjzxX
	 PWMXOPge113faPtCqMpLsMnl6sjdOtWMyOLEAvkjqx2GQlAvqjni4c3qT/wZgKkTjH
	 ujigVXKtB3ol+un4PkVtsaGnsbP1FgWUQCByo9tHKc8FI3kynJMKgGTUfp3TNqRsXN
	 z313HMlV/AsNw==
Date: Wed, 28 Aug 2024 17:49:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <edward.cree@amd.com>, <linux-net-drivers@amd.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>, Edward
 Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 6/6] sfc: add per-queue RX and TX bytes stats
Message-ID: <20240828174919.19069460@kernel.org>
In-Reply-To: <97d55f4e-606a-4882-b977-be0df851baa9@intel.com>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
	<9695a02a3f50cf7d4c1a6321cd42a0538fc686be.1724852597.git.ecree.xilinx@gmail.com>
	<97d55f4e-606a-4882-b977-be0df851baa9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 15:25:59 -0700 Jacob Keller wrote:
> Ah, the broken self tests from the early commit get fixed here. Ok.

+1 :)

