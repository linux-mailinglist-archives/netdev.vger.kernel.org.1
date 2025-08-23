Return-Path: <netdev+bounces-216249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F00A1B32C07
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 22:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992C51BC2AC7
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768C52EB842;
	Sat, 23 Aug 2025 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WFcp2+Fb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5C139D1B;
	Sat, 23 Aug 2025 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755981905; cv=none; b=iYnN0YyL2Z98RdhQF84+PtDn6YqZEyvLL561QPgynQgUlt7UnXEZ3H4btPZ0uSp7XU93mcNJt4CJhMWoat8Q7B1BQIkl3UmcWMY8CQ8IbB73gs6DgQphR0ChJixvzlFug/rvn/YiT6iqmL+jtAg7ZLZhsFbauUhBMyTZKDfrSbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755981905; c=relaxed/simple;
	bh=Lz/itQu15WOHv8ZkqCfprkKScKbd1iovBaBdU56kUdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7imm4IUGrlJp2ku1NCc6Bm3rW3REhgSxOiEuqOaFPibTfnOLK6jIdYKjryopKegqY8POYAJpWT2snMya9FCbooBXTglo3IGzH2MktLZ8MuU9y1j1+lDCxC8AISX6rLmkOJOGf4pXn5wF4MR5J7chtDcF4j6zXjVaBNZhal5h5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WFcp2+Fb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SU9Q7/QpbjEwWIIzO9nafPQJVFuc0izZcPw9A/vfSgY=; b=WFcp2+FbxHUb4wGI8GHUH4l0ZS
	on2ytA1ldC89QPrVO6ZYlLrij5tPYnTPsNWYjmXpu0YE7GVzfR51qbaug8TIQWaMWlL59KXdQiIX8
	sFmbxgrDYXOBGbnMUeTh3VJTH3MGdHjWW8jdZqj9XQDH/6hjlkdVbpNyGsfuFPSpUm2A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upv6W-005mP3-Ks; Sat, 23 Aug 2025 22:44:48 +0200
Date: Sat, 23 Aug 2025 22:44:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 net-next 5/5] net: fec: enable the Jumbo frame support
 for i.MX8QM
Message-ID: <6c40ae63-fc9a-4738-9091-fa459771591d@lunn.ch>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-6-shenwei.wang@nxp.com>
 <fd9af170-fb59-43fa-9eea-ff147f4a84a7@lunn.ch>
 <PAXPR04MB9185AAF36A7FB42C4D00CBDE893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9185AAF36A7FB42C4D00CBDE893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>

> > > -             /* enable ENET store and forward mode */
> > > -             writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
> > > +
> > > +             /* When Jumbo Frame is enabled, the FIFO may not be large enough
> > > +              * to hold an entire frame. In this case, configure the interface
> > > +              * to operate in cut-through mode, triggered by the FIFO threshold.
> > > +              * Otherwise, enable the ENET store-and-forward mode.
> > > +              */
> > > +             if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
> > > +                     writel(0xF, fep->hwp + FEC_X_WMRK);
> > 
> > The quirk indicates the hardware is capable of jumbo frames, not that jumbo
> > frames are enabled. Don't you need to compare the mtu with ETH_FRAME_LEN +
> > ETH_FCS_LEN to say jumbo is enabled?
> > 
> 
> The comments here do have some confusion. The goal is to enable cut-through mode 
> when the hardware supports Jumbo frames.  But we can limit the scope to enable it
> only when MTU is less than 2k bytes. 

That would be good. I've no idea how many embedded systems actually
use jumbo packets. Maybe your marketing people can tell you. 1%? 5%?
But you are changing this for 100% of your customers, which might
cause regressions. So it would be better to only enable this when
needed.

> > Is there a counter or other indication that the FIFO experienced an underflow?
> > 
> 
> There is a Underrun bit in the status field in the TX buffer descriptor. The hardware 
> supports retransmit frames if high memory latency is encountered due to other 
> high-priority bus masters.

So this:
                        if (status & BD_ENET_TX_UN)  /* Underrun */
                                ndev->stats.tx_fifo_errors++;

Good to see there is a counter for it.

	Andrew

