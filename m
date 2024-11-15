Return-Path: <netdev+bounces-145141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2CB9CD561
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299921F22527
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212F1442F4;
	Fri, 15 Nov 2024 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1e4b6SE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74165228;
	Fri, 15 Nov 2024 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637671; cv=none; b=Vjb+zYYuJiv3m8u1pLh/OgxxiR3Mpd8iHmS75YZxVd3PCqTXB8tB5QFzXFtnhJnyxT/16mheglfkB51f8CvbOQoLsGbnVN7coQfBe8IOIIKGsCOQ9PaJUfdiqdWV4ix8p2ofUCV6UX2UI8Azl9J0qj0Zt/cRYJk1M2xPXMJuVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637671; c=relaxed/simple;
	bh=ciicWdUUqTmxlP2H/Q6z1OjXe00ZOD7vnXdIMmppkls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHZvMBMioHE7Y0ZBP2fXVqi/rW/O4dp0rMPJgBgmTAOwmRoTrUCAWpkqTIf/p/tVpR3Svv85UpjiUNkjaLAS2z0xE27utK8RjKtyvfV1awBTvtSAmhyksNQ0vGOqqUTx7UdDmVRYPyYN2TvYfOxtBa2kqhwKj1hpIIsg7B1gCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1e4b6SE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F8CC4CECD;
	Fri, 15 Nov 2024 02:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731637671;
	bh=ciicWdUUqTmxlP2H/Q6z1OjXe00ZOD7vnXdIMmppkls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G1e4b6SE4TrViFB8tk+bUlBAZWA+VVON01VT87nCGi4nLVIFA2n38XKx9TEv1b9SL
	 JL6/QN6T902v1Cklm/tlvH5y9hyuL6v4nhjBpJtX1/ePepoGarjN8xEjmK8dwS3tCn
	 S6KLyy2OUjLfC7Wa7bRr0B+OI4HdFos40C0GyNADoQQEiJmqhpBvniepS2gSLeWe32
	 0jGSdQKqMtlmkHNNGZbywCiO1oG0Uoyn+1GpR8ill2ck/Nru4FDlFOWBkFkIh6b9MA
	 HknCcUGKmNgnqA/gFTQvQ0qQoljszierDY8gLHZmZIl0hFVy5th4ZARrU1QuhTa/HM
	 kIXvqUNgwAhdQ==
Date: Thu, 14 Nov 2024 18:27:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ttoukan.linux@gmail.com, gal@nvidia.com, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via
 rx_fifo_errors
Message-ID: <20241114182750.0678f9ed@kernel.org>
In-Reply-To: <20241114021711.5691-1-laoar.shao@gmail.com>
References: <20241114021711.5691-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 10:17:11 +0800 Yafang Shao wrote:
> - *   Not recommended for use in drivers for high speed interfaces.

I thought I suggested we provide clear guidance on this counter being
related to processing pipeline being to slow, vs host backpressure.
Just deleting the line that says "don't use" is not going to cut it :|
-- 
pw-bot: cr

