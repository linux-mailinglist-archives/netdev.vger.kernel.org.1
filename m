Return-Path: <netdev+bounces-165321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70BAA31A21
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A29C188A48A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5228C360;
	Wed, 12 Feb 2025 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxorvcSi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB271367
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318828; cv=none; b=K+dgYrjrF8oQRl2Ykmi+k8SXbqLQz4/HlG9b6RI5RYY2/36oqYKoelU4i+EuEM6KFPYzXknTcYeNRGZb/3q1+a3X2Y7MS2ANMZQU/rO/iqz1P9/XcPsFT24hcUED77tW4MtfTtJhN/7/FAHuTlPn8QxTqgM+saIK09O8a9eGVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318828; c=relaxed/simple;
	bh=Y1kcsBg8+MlBO2UhW4Hk1ANhPoO8PeuNAm+HB6190l8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eq4/1vb0PwsHcqjRBrtBLeIIIBIv4zZdDLxVWjENGfbLsYUpfbOtNdjtD52EvajDdQbcw3ZPsSDJTtnjq1azqR6S9/pHvsUGTN8TKsGVkXiY5/HCofkETpqB9TG2zN35PQNfY+bt98Khkbv6Rmatai3aqSUE5mjK0OB0stonyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxorvcSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C745C4CEDD;
	Wed, 12 Feb 2025 00:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739318827;
	bh=Y1kcsBg8+MlBO2UhW4Hk1ANhPoO8PeuNAm+HB6190l8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dxorvcSiu9SeXqvQrjodytCIYxeed65Ryld4kBMwO2dbPiyM4TbACUkXCh5Qw1a/S
	 UsATE6O13JT1rIsyNLYDjE7cfcjohHaYAZ1xiuXU1z42LoWxcb43yHJ7V62qyMGCxJ
	 uYAL5hANeRjbxvm8xM4Xpn9LQG0H+VmZ7mj/MnTCPUJKMAepUTkXpTGBE4n31YJbKv
	 FC4jaMtqYEtVikzLHQPJCUjvU7r7r6LCqfbWEBIoIY1IeYeCY78Pho6vRoztfDUXyl
	 /ZZx48HPnsGU7ViO/Q/UhpHTRmyYRbL3kgZzcBop2b3T7xsOEvzL3hh5ojVriylHTw
	 FOGgYS4J8V9tA==
Date: Tue, 11 Feb 2025 16:07:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
 vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v6 1/4] net: wangxun: Add support for PTP clock
Message-ID: <20250211160706.15eb0d2a@kernel.org>
In-Reply-To: <20250208031348.4368-2-jiawenwu@trustnetic.com>
References: <20250208031348.4368-1-jiawenwu@trustnetic.com>
	<20250208031348.4368-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Feb 2025 11:13:45 +0800 Jiawen Wu wrote:
> + * wx_ptp_tx_hwtstamp_work
> + * @work: pointer to the work struct
> + *
> + * This work item polls TSC_1588_CTL valid bit to determine when a Tx hardware
> + * timestamp has been taken for the current skb. It is necessary, because the
> + * descriptor's "done" bit does not correlate with the timestamp event.

Why not use the aux_work for this?
IIUC aux_work often has lower latency since it's a dedicated thread.

