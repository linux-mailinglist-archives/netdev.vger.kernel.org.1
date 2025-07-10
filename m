Return-Path: <netdev+bounces-205969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621E9B00FC5
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984901752D7
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9DB28B418;
	Thu, 10 Jul 2025 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KiokvW+P"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A292D1F6B
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190429; cv=none; b=PGszSMIiREepDryx0yG6xLFtOQVhfX+Y/7gmBPzFKWVnjtN6nDbuCIaE/p3v9fpKNIghV5zpYOoMLD1O9BIsaucnuLosqKkXTs/c4KDuLg629YankTUbqVFaj2fjsm7vHYUXCbc3R34MoRGTJdMP2en1O8U+I47iy339XFGY4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190429; c=relaxed/simple;
	bh=dtPz/XI2WLDkkmhN4o9qZwKlGMgRjn9DeM++FyTDK8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=amzkqemU63LDhnel1zqHYFO3eiN6trhMuZU+aNdRzYzXP1bFiAWziG+7P4s5/yfWRxHIPblon44dxlCqbMe59mD1WI3NwYZP0TKT4HmCXo4AhVN71ycqHpDbSknJFPyjKw4BUEhZh8FUyhlaYmYaz0Ea3SyLj8GBGOwZRLN+B28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KiokvW+P; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250710233344euoutp015a9c5e37d08591a284dd666e900fb0b3~RB_hFgLgB0219302193euoutp01O
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 23:33:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250710233344euoutp015a9c5e37d08591a284dd666e900fb0b3~RB_hFgLgB0219302193euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752190424;
	bh=hvyOUZiHenD13Ps6W5aJRdt6FMV1WmjmYGUROioPBGg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=KiokvW+PnCTK5sASPo4lwqgsx5aV1kzB8a08lWIJJEmGyTa+rgF0g1zxGMCsHqxIp
	 lG2Y8O/N6PNs3HcfsXen/X22iNd0PFe/Akg0nkAvngftIqZWfgt5idiy4Wkokb6gPg
	 ZC75FOJAyIe2c4+3auWqr4nFMH8PTRzJmPaIgD2Y=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250710233342eucas1p2c694f757f87ddefbba65cb808f967872~RB_fuIP_B1089110891eucas1p26;
	Thu, 10 Jul 2025 23:33:42 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250710233341eusmtip1bf3d9344a4d6a021b3d7f08e7a7d4918~RB_eryI4I1880618806eusmtip1D;
	Thu, 10 Jul 2025 23:33:41 +0000 (GMT)
Message-ID: <649b0ba9-ff82-49d7-8dbf-f17424d9d9eb@samsung.com>
Date: Fri, 11 Jul 2025 01:33:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, netdev@vger.kernel.org, Jason Baron
	<jbaron@akamai.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250710124357.25ab8da1@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250710233342eucas1p2c694f757f87ddefbba65cb808f967872
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250710083401eucas1p1d18e23791e1f22c0c0aaf823a35526a2
X-EPHeader: CA
X-CMS-RootMailID: 20250710083401eucas1p1d18e23791e1f22c0c0aaf823a35526a2
References: <20250704054824.1580222-1-kuniyu@google.com>
	<CGME20250710083401eucas1p1d18e23791e1f22c0c0aaf823a35526a2@eucas1p1.samsung.com>
	<9794af18-4905-46c6-b12c-365ea2f05858@samsung.com>
	<20250710124357.25ab8da1@kernel.org>

On 10.07.2025 21:43, Jakub Kicinski wrote:
> On Thu, 10 Jul 2025 10:34:00 +0200 Marek Szyprowski wrote:
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Reported-by: Jason Baron <jbaron@akamai.com>
>>> Closes: https://lore.kernel.org/netdev/cover.1750285100.git.jbaron@akamai.com/
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>> This patch landed recently in linux-next as commit ae8f160e7eb2
>> ("netlink: Fix wraparounds of sk->sk_rmem_alloc."). In my tests I found
>> that it breaks wifi drivers operation on my tests boards (various ARM
>> 32bit and 64bit ones). Reverting it on top of next-20250709 fixes this
>> issue. Here is the log from the failure observed on the Samsung
>> Peach-Pit Chromebook:
>>
>> # dmesg | grep wifi
>> [   16.174311] mwifiex_sdio mmc2:0001:1: WLAN is not the winner! Skip FW
>> dnld
>> [   16.503969] mwifiex_sdio mmc2:0001:1: WLAN FW is active
>> [   16.574635] mwifiex_sdio mmc2:0001:1: host_mlme: disable, key_api: 2
>> [   16.586152] mwifiex_sdio mmc2:0001:1: CMD_RESP: cmd 0x242 error,
>> result=0x2
>> [   16.641184] mwifiex_sdio mmc2:0001:1: info: MWIFIEX VERSION: mwifiex
>> 1.0 (15.68.7.p87)
>> [   16.649474] mwifiex_sdio mmc2:0001:1: driver_version = mwifiex 1.0
>> (15.68.7.p87)
>> [   25.953285] mwifiex_sdio mmc2:0001:1 wlan0: renamed from mlan0
>> # ifconfig wlan0 up
>> # iw wlan0 scan
>> command failed: No buffer space available (-105)
>> #
>>
>> Let me know if You need more information to debug this issue.
> Thanks a lot for the report! I don't see any obvious bugs.
> Would you be able to test this?
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 79fbaf7333ce..aeb05d99e016 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2258,11 +2258,11 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
>   	struct netlink_ext_ack extack = {};
>   	struct netlink_callback *cb;
>   	struct sk_buff *skb = NULL;
> +	unsigned int rmem, rcvbuf;
>   	size_t max_recvmsg_len;
>   	struct module *module;
>   	int err = -ENOBUFS;
>   	int alloc_min_size;
> -	unsigned int rmem;
>   	int alloc_size;
>   
>   	if (!lock_taken)
> @@ -2294,8 +2294,9 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
>   	if (!skb)
>   		goto errout_skb;
>   
> +	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
>   	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
> -	if (rmem >= READ_ONCE(sk->sk_rcvbuf)) {
> +	if (rmem != skb->truesize && rmem >= rcvbuf) {
>   		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
>   		goto errout_skb;
>   	}
>
The above change fixes my issue. Thanks! Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


