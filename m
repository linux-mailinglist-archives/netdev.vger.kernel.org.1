Return-Path: <netdev+bounces-126557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5B1971D09
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821B4B22D13
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EE31BAEFD;
	Mon,  9 Sep 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hGSUexYc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FCE1B81D8;
	Mon,  9 Sep 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893328; cv=none; b=GBaFv6vJA2Ovfjr07mohxoqZWIFNKKGajA8G3L2RD8mezbJNxQ6P4eANHmKH5iKRN3ALKV0Eh7JTOu5jrGSLn5fDZ2zvuhSpeVGXh/9Xd5ycWqqoq5X5HBbPEApwDUZv9Euiz/lRWsB26R2IvL0F9ynkJS7ftrB/wb5lqzdtZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893328; c=relaxed/simple;
	bh=c9Hm/3zSlzuUxpB7pXyFXiCPLd00AzAQrXA5c12PEZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwLkO6jLS+FgyAII5NcL8Yopaou1U1Mw+aFtSeEFJZc5eZsrMmDbw38W/7sXocCUiEztPt9RXCAR6WgzryBbuRSnjdQr2oh8r/0h2AQYsfUieSzU3lGCrmS2gMAsSrsqIlsDO5z3u53AAPBttnyRzfgghO9sKz75zz3MhGib7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hGSUexYc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MgRCqs/Q+pHFW7qR5f/uHj6Sf4Hn8eXOok4j/wQZW7k=; b=hGSUexYckTv9g3Za+Bp/id3v5t
	mUgAkjKHHK+Aqw1ImkwBnEyb1Rr4aG5A2znmarVpqd9PXHKRWR0gAMdlAuPhgWMRfIuTPju0xxftN
	Rvd/Lgv5CCMEk1CnfnuolY8nvCgMhcVwrc/OGs/YWR5eR4gy/cuD47Ff0MvzIvWvEfgw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1snfgv-0071Ao-Dw; Mon, 09 Sep 2024 16:48:33 +0200
Date: Mon, 9 Sep 2024 16:48:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, zhuyuan@huawei.com,
	forest.zhouchang@huawei.com, jdamato@fastly.com, horms@kernel.org,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 net-next 05/11] net: hibmcge: Implement some .ndo
 functions
Message-ID: <49166f60-bf25-4313-bacb-496103086d40@lunn.ch>
References: <20240909023141.3234567-1-shaojijie@huawei.com>
 <20240909023141.3234567-6-shaojijie@huawei.com>
 <CAH-L+nOxj1_wHdSacC5R9WG5GeMswEQDXa4xgVFxyLHM7xjycg@mail.gmail.com>
 <116bff77-f12f-43f0-8325-b513a6779a55@huawei.com>
 <fec0a530-64d9-401c-bb43-4c5670587909@lunn.ch>
 <1a7746a7-af17-43f9-805f-fd1cbd24e607@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a7746a7-af17-43f9-805f-fd1cbd24e607@huawei.com>

> No, HBG_NIC_STATE_OPEN is not intended to ensure that hbg_net_open() and
> hbg_net_stop() are mutually exclusive.
> 
> Actually, when the driver do reset or self-test(ethtool -t or ethtool --reset or FLR).
> We hope that no other data is transmitted or received at this time.

That is an invalid assumption. You could be receiving line rate
broadcast traffic for example, because there is a broadcast storm
happening.

I assume for testing, you are configuring a loopback somewhere? PHY
loopback or PCS loopback? I've seen some PHYs do 'broken' loopback
where egress traffic is looped back, but ingress traffic is also still
received. Is this true for your hardware? Is this why you make this
assumption?

What is your use case for ethtool --reset? Are you working around
hardware bugs? Why not simply return -EBUSY if the user tries to use
--reset when the interface is admin up. You then know the interface is
down, you don't need open/close to be re-entrant safe.

Same for testing. Return -ENETDOWN if the user tries to do self test
on an interface which is admin down.

	Andrew

