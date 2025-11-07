Return-Path: <netdev+bounces-236767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10016C3FBB0
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7E4D4F0C1C
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585DC3218B3;
	Fri,  7 Nov 2025 11:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D40320CD5;
	Fri,  7 Nov 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514786; cv=none; b=b6l22yx6ACmMAs7MO5gEBKAiSotn58OMEPHfSjHyOAlcjPQpH4gUIhQQAa4moc9ZjOkV6JqDOJwUdWju+Izb3jxN+JJrJMwtWtu6GsR4Nc5Afv0ZNm7Io3XsiuPU+/fNKtAngEi2zeQWryIjAHftKDzxcMceeWs5LNtVGE44ORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514786; c=relaxed/simple;
	bh=FGIF3AoxOcgxBzxbbyfwHFNHYIATq7p/8YSXNS1LfD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HLfWH5/M6eyqWeSUCR+Bmp6lg4zi1ESQblunXXf55L4AwPWzKalirQSldopq62DqnWSDiCfkGyuhXvf0Q+fgzd/0NrnqnH6e46lJnm+K0OezPegQW8ut9EFrzveXqPDwqByuGBjBoFYgVW42XhybyZNYJhh31oI9sKnBAamVOjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d2xZp4wr4zHnHB0;
	Fri,  7 Nov 2025 19:26:10 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id C878C1401DC;
	Fri,  7 Nov 2025 19:26:19 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 14:26:19 +0300
Message-ID: <1d2b1281-3ac5-4bf0-88d9-6b88e5d42d66@huawei.com>
Date: Fri, 7 Nov 2025 14:26:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/14] ipvlan: Support GSO for port -> ipvlan
To: Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
 <20251105161450.1730216-7-skorodumov.dmitry@huawei.com>
 <CANn89i+iq3PVz6_maSeGJT4DxcYfP8sN0_v=DTkin+AMhV-BNA@mail.gmail.com>
 <dfad18c7-0721-486a-bd6e-75107bb54920@huawei.com>
 <bd0da59d-153f-4930-851a-68117dbcc2de@huawei.com>
 <CANn89iKioXqA3vdKdpL9iZYVU0qOPGCKxYiStc=WNWQ3+ARP_w@mail.gmail.com>
Content-Language: en-US
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
In-Reply-To: <CANn89iKioXqA3vdKdpL9iZYVU0qOPGCKxYiStc=WNWQ3+ARP_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

>> I see that currently there is no any tests for this ipvlan module (may be I missed something).. Do you have any ideas about tests? I'm a bit  confused at the moment: designing tests from scratch - this might be a bit tricky.
>>
>> Or it is enough just describe test-cases I checked manually (in some of the patches of the series)?
> I have some hard time to figure out why you are changing ipvlan, with
> some features that seem quite unrelated.
Sorry! I had to sent a more descriptive cover letter with CC to all maintainers
> ipvlan is heavily used by Google, I am quite reluctant to see a huge
> chunk of changes that I do not understand, without spending hours on
> it.
>
> The MAC-NAT keyword seems more related to a bridge.
>
I tried to make all the new functionality to not affect any existing code. The only place that changes behavior - is "[patch 2] Send mcasts out directly in ipvlan_xmit_mode_l2". May be I should spend some time and invent a way to not change behavior at all. All other places should be under "if (ipvlan_is_macnat(port))".

Now I'd also want to implement some tests, and try to ensure, that existing functionality continues work well. I hope that after review and tests, there will be no bugs.

> The MAC-NAT keyword seems more related to a bridge.

At start of work on this feature, I saw options: 1) Modify IPVLan 2) Modify net/bridge 3) clone IPVLan to new module and extend it

But net/bridge is already overbloated, and I believe it is better not touch it. And IPVlan already has all the required infrastructure functions. Actually, all new functionality - is about 600 lines of diff (patches 1 and 4). The IPVLan is essentially "bridge" in its functionality.. extending it to learn IPs and do mac-nat - is easy. All other diffs - are just improvements (like improve handling IP conflicts, refactor validator/address events handling)

And... i saw a lot of people are already using IPVLan to bridge to WiFi - though with a lot of limitations and troubles.

Here is a bit rewritten documentation (AI also suggests server-case scenarios, but I'm skeptical about it):

+4.4 L2_MACNAT mode:
+-------------------
+
+This mode extends the L2 mode and is primarily designed for desktop virtual
+machines that need to bridge to wireless interfaces. In standard L2 mode,
+you must configure IP addresses on slave interfaces to enable frame
+multiplexing between slaves and the master.
+
+In L2_MACNAT mode, IPVLAN automatically learns IPv4/IPv6 and MAC addresses
+from outgoing packets. For transmitted packets, the source MAC address
+is replaced with the MAC address of the main interface. Received packets
+are routed to the interface that previously used the destination address,
+and the destination MAC is replaced with the learned MAC address.
+
+This enables slave interfaces to automatically obtain IP addresses
+via DHCP and IPv6 autoconfiguration.
+
+Additionally, dev_add_pack() is configured on the master interface to capture
+outgoing frames and multiplex them to slave interfaces when necessary.

Dmitry



