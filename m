Return-Path: <netdev+bounces-123046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FB4963886
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83C41F237EF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946CD3A1BA;
	Thu, 29 Aug 2024 03:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iMR0n2aN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70F84A00;
	Thu, 29 Aug 2024 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724900567; cv=none; b=HVEwTx6cmy1ZYF8ePVNDvlhT/kRQzbiutUP42g61aQ2mvX/E4G7box5ll/dBef7gPWCrHIlcjT80mGM2/bpJdEXNU65ErGUyHq5cZ6YgC87KJ4HLc+ZuwmBwS03qaJkGRdn4UDP3vpjeD5WBJQp+0v0E7gT6tj7Xqs4+OhWoc4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724900567; c=relaxed/simple;
	bh=GjPcLNDDJTQMknl+sqVgf/3sEl4EHnPF1vNJwr9tB+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIYOsoZuqw1EjeAwAZ9yyWcxg+gzr7DI0SHv6/YF/cgRqpLPq8UNqaO9nv64JDMuxiaT75rYBu/N5KBKlNQvvfQZ/Yw/nLO4XOx7p293jKolYxgzYhxJWsdZIg09XoSL21jezH9ffFn8dn+Pbs/RwOm9kpUcanvT1ChelBopb+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iMR0n2aN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1j3bdbN9JHjiXWSJGuIMAruuQdmR37hBFILRH7ucLxI=; b=iMR0n2aNLh5MWE9KuLNm5e0pHH
	Nvi1h2ZN0uo7X4uK2tolGBpbUz3haHfPkrL8u5MTFgyMxB3kZnpMBQVyOREzW12U9PBefHdsONdWj
	nHJGCIEXj0D1Y4++nCqUGxiulvIPYLN/Cx8XNJLCiPyCThEx/eyqNvnfyIROYxBMon9c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjVQb-005zcb-JI; Thu, 29 Aug 2024 05:02:29 +0200
Date: Thu, 29 Aug 2024 05:02:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 net-next 06/11] net: hibmcge: Implement
 .ndo_start_xmit function
Message-ID: <83dce3bb-28c6-4021-a343-cff2410a463f@lunn.ch>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
 <20240827131455.2919051-7-shaojijie@huawei.com>
 <20240828184120.07102a2f@kernel.org>
 <df861206-0a7a-4744-98f6-6335303d29ef@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df861206-0a7a-4744-98f6-6335303d29ef@huawei.com>

On Thu, Aug 29, 2024 at 10:32:33AM +0800, Jijie Shao wrote:
> 
> on 2024/8/29 9:41, Jakub Kicinski wrote:
> > On Tue, 27 Aug 2024 21:14:50 +0800 Jijie Shao wrote:
> > > @@ -111,6 +135,14 @@ static int hbg_init(struct hbg_priv *priv)
> > >   	if (ret)
> > >   		return ret;
> > > +	ret = hbg_txrx_init(priv);
> > > +	if (ret)
> > > +		return ret;
> > You allocate buffers on the probe path?
> > The queues and all the memory will be sitting allocated but unused if
> > admin does ip link set dev $eth0 down?
> 
> The network port has only one queue and
> the TX queue depth is 64, RX queue depth is 127.
> so it doesn't take up much memory.
> 
> Also, I plan to add the self_test feature in a future patch.
> If I don't allocate buffers on the probe path,
> I won't be able to do a loopback test if the network port goes down unexpectedly.

When you come to implement ethtool --set-ring, you will need to
allocate and free the ring buffers outside of probe.

	Andrew

