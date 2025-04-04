Return-Path: <netdev+bounces-179291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF30A7BB4F
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 13:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4822717B457
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C91B4139;
	Fri,  4 Apr 2025 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vExpEhH8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08333FD;
	Fri,  4 Apr 2025 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764510; cv=none; b=hBkTX+RdHDAwf5MW7QPrCuUDB8m4IzuJ5PZMAo0cMB/79OhtcdPgOiMb5fFZHOuuENdDb52lYjL9lzVYRcIvrNfnkBN8v340zueCIxo7WDtwt87XlW6uRJBCRtp0hdnBwbjYoisLNFveYo0ZezJH37IY78N2/M1G1iFhs+GHIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764510; c=relaxed/simple;
	bh=nZbF7HDCvYF9shcQGXSHz+DW6crvRRnm1i01Pc5CJus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8Lwsn3AlfJeMFSLalEH2Lc0wtvxeF0bM8Ne0IFYg93cgPwQSQMke9Z+GlAkbKM63DkpGs0d0UeDFQBfZzp7mOjGTHio1y1C3rQ0Uol5in0gYb/gzZWFtcKmHrC3HzY9DGWh4xilPtUrA31VU82aIntyqqSxCElQT2+CI1obvZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vExpEhH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C49DC4CEDD;
	Fri,  4 Apr 2025 11:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743764510;
	bh=nZbF7HDCvYF9shcQGXSHz+DW6crvRRnm1i01Pc5CJus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vExpEhH8C8DjZO7E9sN98mvlggVteKJAV41iaIVR/Q8ZLQH7VF/oDaKc1D2W6PQW2
	 kuJqhNLVnOvGTZJ91lcZH2SU8eJnj73S/weYKUeQv9WzSNrv7HAC03odYPlvDMAhz/
	 fBKfJx3qHcvHdjIh0yeZsJV59XWbxDtmZ8SGuZ308ajjcAYqlRTbrOL/A/BBaQpRQt
	 aJr2JvEl2Yb5ugZKCjTjWMOedMnXpOpDLp8aHUMVDr6rkz2eO22dpnPCV/o0zlycnW
	 MYtRp/hMQcK7J503qDf9iezCtFZ6YjztsluvFKDxRNQHprTAY+HipiXKhlS0wwGCj6
	 SS/OtDb14buDQ==
Date: Fri, 4 Apr 2025 12:01:45 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 7/7] net: hibmcge: fix multiple phy_stop() issue
Message-ID: <20250404110145.GF214849@horms.kernel.org>
References: <20250403135311.545633-1-shaojijie@huawei.com>
 <20250403135311.545633-8-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403135311.545633-8-shaojijie@huawei.com>

On Thu, Apr 03, 2025 at 09:53:11PM +0800, Jijie Shao wrote:
> After detecting the np_link_fail exception,
> the driver attempts to fix the exception by
> using phy_stop() and phy_start() in the scheduled task.
> 
> However, hbg_fix_np_link_fail() and .ndo_stop()
> may be concurrently executed. As a result,
> phy_stop() is executed twice, and the following Calltrace occurs:
> 
>  hibmcge 0000:84:00.2 enp132s0f2: Link is Down
>  hibmcge 0000:84:00.2: failed to link between MAC and PHY, try to fix...
>  ------------[ cut here ]------------
>  called from state HALTED
>  WARNING: CPU: 71 PID: 23391 at drivers/net/phy/phy.c:1503 phy_stop...
>  ...
>  pc : phy_stop+0x138/0x180
>  lr : phy_stop+0x138/0x180
>  sp : ffff8000c76bbd40
>  x29: ffff8000c76bbd40 x28: 0000000000000000 x27: 0000000000000000
>  x26: ffff2020047358c0 x25: ffff202004735940 x24: ffff20200000e405
>  x23: ffff2020060e5178 x22: ffff2020060e4000 x21: ffff2020060e49c0
>  x20: ffff2020060e5170 x19: ffff20202538e000 x18: 0000000000000020
>  x17: 0000000000000000 x16: ffffcede02e28f40 x15: ffffffffffffffff
>  x14: 0000000000000000 x13: 205d313933333254 x12: 5b5d393430303233
>  x11: ffffcede04555958 x10: ffffcede04495918 x9 : ffffcede0274fee0
>  x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 0000000000000001
>  x5 : 00000000002bffa8 x4 : 0000000000000000 x3 : 0000000000000000
>  x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff20202e429480
>  Call trace:
>   phy_stop+0x138/0x180
>   hbg_fix_np_link_fail+0x4c/0x90 [hibmcge]
>   hbg_service_task+0xfc/0x148 [hibmcge]
>   process_one_work+0x180/0x398
>   worker_thread+0x210/0x328
>   kthread+0xe0/0xf0
>   ret_from_fork+0x10/0x20
>  ---[ end trace 0000000000000000 ]---
> 
> This patch adds the rtnl_lock to hbg_fix_np_link_fail()
> to ensure that other operations are not performed concurrently.
> In addition, np_link_fail exception can be fixed
> only when the PHY is link.
> 
> Fixes: e0306637e85d ("net: hibmcge: Add support for mac link exception handling feature")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


