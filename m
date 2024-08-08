Return-Path: <netdev+bounces-116879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410B494BF17
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0046286D49
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B518E050;
	Thu,  8 Aug 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtrCXRAw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02A63D
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125913; cv=none; b=Xw0tPYrfNvDxDHGQBAU8hL1LB7F+2menWAOAb0uz9tWC2mMQjuY4L3cCFDYNp3kt8UQN4N3C5+7bUhSGP+WaAd7zhcS8sMR2yGh2/Sh1GvgAj+Aj5VKQ84F0d5I22SgV8QBjruvhcTYaO/t+QlDfR7m/iIihLr7adalHWoyuk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125913; c=relaxed/simple;
	bh=LCdx5ycQgmEabKNLbBhfWFpkDr6rEAaDHXROwzdmL+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMACJwGYU6Kaqhg3FPhy+N2gsXqtW8O7nZGoZFE6ktaY52q+6MplObtx4WYXQs4C1UbkqvSmBGr7x6AMJLOzb7BAarH6roVQGORnx42T4KiARdll3GOZLcwV/rgjXleiwHHC2LOm0DX2RtsbzRdBRqTSrHpDwCaopXf+10Az6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtrCXRAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99418C32782;
	Thu,  8 Aug 2024 14:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723125913;
	bh=LCdx5ycQgmEabKNLbBhfWFpkDr6rEAaDHXROwzdmL+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WtrCXRAw66YK6ZjDphkQjntXRLFxGS4xaERbVfVIGLaaYXv3pdLYy2+/Ew0fubDMD
	 gKHJl54ak0PtiKI1o5sUyszoUfjGch0mzkb3zDTnOpWS+dZN1DtGAT6QzDr2VN5Ma4
	 JRrBwgPXBJKAZGsucFO4LFfIiOa7qLgQulUTfnO6UYa8gUvBJZ3GwN9ZRnQ+tNnQlY
	 ZuPmQymGrQ9NuFgpbd4mTMQegDOLDkaF+cRAbaRViA4YgBZ8cZ0egaqGGpvQ7LVHZQ
	 6kIFBKg19ywjwDKQL+y2Shhfb58UMg5e4LzB9hLMHVeTZPPiL8qiXiWhTdh80zSRKT
	 lzIDxk2Chf09Q==
Date: Thu, 8 Aug 2024 07:05:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yonglong Liu <liuyonglong@huawei.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
Message-ID: <20240808070511.0befbdde@kernel.org>
In-Reply-To: <977c3d82-e2f0-4466-9100-7ea781e91ce1@huawei.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
	<523894ab-2d38-415f-8306-c0d1abd911ec@huawei.com>
	<20240807072908.1da91994@kernel.org>
	<977c3d82-e2f0-4466-9100-7ea781e91ce1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 20:52:52 +0800 Yonglong Liu wrote:
> I hooks the netdev to the page pool, and run with this patch for a 
> while, then get
> 
> the following messages, and the vf can not disable:

> [ 1950.137586] hns3 0000:7d:01.0 eno1v0: link up
> [ 1950.137671] hns3 0000:7d:01.0 eno1v0: net open
> [ 1950.147098] 8021q: adding VLAN 0 to HW filter on device eno1v0
> [ 1974.287476] hns3 0000:7d:01.0 eno1v0: net stop
> [ 1974.294359] hns3 0000:7d:01.0 eno1v0: link down
> [ 1975.596916] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
> release stalling device unregister
> [ 1976.744947] hns3 0000:7d:01.0 eno1v0 (unregistered): page pool 
> release stalling device unregister

So.. the patch works? :) We may want to add this to get the info prints
back:

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2abe6e919224..26bc1618de7c 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1021,11 +1021,12 @@ static void page_pool_release_retry(struct work_struct *wq)
 	/* Periodic warning for page pools the user can't see */
 	netdev = READ_ONCE(pool->slow.netdev);
 	if (time_after_eq(jiffies, pool->defer_warn) &&
-	    (!netdev || netdev == NET_PTR_POISON)) {
+	    (!netdev || netdev == NET_PTR_POISON || netdev->pp_unreg_pending)) {
 		int sec = (s32)((u32)jiffies - (u32)pool->defer_start) / HZ;
 
-		pr_warn("%s() stalled pool shutdown: id %u, %d inflight %d sec\n",
-			__func__, pool->user.id, inflight, sec);
+		pr_warn("%s(): %s stalled pool shutdown: id %u, %d inflight %d sec (hold netdev: %d)\n",
+			__func__, netdev ? netdev_name(netdev) : "",
+			pool->user.id, inflight, sec, pool->defer_warn);
 		pool->defer_warn = jiffies + DEFER_WARN_INTERVAL;
 	}
 

> I install drgn, but don't know how to find out the using pages, would 
> you guide me on how to use it?

You can use this sample as a starting point:

https://github.com/osandov/drgn/blob/main/contrib/tcp_sock.py

but if the pages are actually leaked (rather than sitting in a socket),
you'll have to scan pages, not sockets. And figure out how they got leaked.
Somehow...

