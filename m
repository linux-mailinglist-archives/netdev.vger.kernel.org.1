Return-Path: <netdev+bounces-249604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4B6D1B836
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5AEA300671F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37619350A0A;
	Tue, 13 Jan 2026 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wWdBfa9H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCE3033C1;
	Tue, 13 Jan 2026 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341696; cv=none; b=imsuNKBsIAZXvE0FOKbL2jWmIUBp9o2j2PKKZkJQDTOzTXIINVj1H3w9dmQPceaHEbJr51nzVty9r/QLynmClkcAEsqAgjNkW9HuEhP7+fxPCB2YkC3U8ueYkuKF0Fmifj9hCQFvtq+1npcMQrJzfXpgc4Kw4R72Cdse2LefLfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341696; c=relaxed/simple;
	bh=JvEbElP3uMxqSEOP3ISEuBtd+wigJtDEi+eNzvV65L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYYkxyiFlXQLku/BhmDsPs1/85eKSuT+YR7dIutlniUPRQ6fjSjMnxvQEyGsuYR3ni9Ko43K/uOBQNF0LPZhbIIKa14nnuEeL1erclCbO2cj4e8CyLJkJ+mgAso08rhY9jjtqNZfGbUx9x4/Vu6cvmenilb152OFbnXRLe6rxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wWdBfa9H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+/hmyK68GNYmzVLXF7pCpHn2vvi/9fuPFNsaXRo0bTQ=; b=wWdBfa9HE9yvd0cCqtqwFLpPfC
	BLDzE3FDZI7swPftVpAjvudlyibMHJqW9TY80mp4QYnFs5cusbCNmzEGkJZ41Z+euVNFnPi+dRLEz
	mGVy2K2KejoUfAxT6D6JhUoIgY1IGYygIwmoIpConwFVll5MYO38v/as9EAZ+Q4ckm4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vfmRy-002hKr-QO; Tue, 13 Jan 2026 23:01:18 +0100
Date: Tue, 13 Jan 2026 23:01:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: count tx_dropped when dropping skb
 on link down
Message-ID: <0d17b8bf-f8dc-4738-87bc-357d92768381@lunn.ch>
References: <20260106122350.21532-2-yyyynoom@gmail.com>
 <b6ff2078-86d7-4416-a914-e07ae13e2128@lunn.ch>
 <DFNFEBZPHG3I.1YEOOHK1BTI3N@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFNFEBZPHG3I.1YEOOHK1BTI3N@gmail.com>

On Tue, Jan 13, 2026 at 08:30:45PM +0900, Yeounsu Moon wrote:
> On Tue Jan 6, 2026 at 10:44 PM KST, Andrew Lunn wrote:
> > On Tue, Jan 06, 2026 at 09:23:51PM +0900, Yeounsu Moon wrote:
> >> Increment tx_dropped when dropping the skb due to link down.
> >> 
> >> Tested-on: D-Link DGE-550T Rev-A3
> >> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
> >> ---
> >>  drivers/net/ethernet/dlink/dl2k.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
> >> index 846d58c769ea..edc6cd64ac56 100644
> >> --- a/drivers/net/ethernet/dlink/dl2k.c
> >> +++ b/drivers/net/ethernet/dlink/dl2k.c
> >> @@ -733,6 +733,7 @@ start_xmit (struct sk_buff *skb, struct net_device *dev)
> >>  	u64 tfc_vlan_tag = 0;
> >>  
> >>  	if (np->link_status == 0) {	/* Link Down */
> >> +		dev->stats.tx_dropped++;
> >
> > Do you see this being hit very often? It should be that as soon as you
> > know the link is down, you tell the core, and it will stop calling
> > start_xmit. If you see this counter being incremented a lot, it
> > indicates there is a problem somewhere else.
> >
> > You might want to consider converting this driver to phylink.
> >
> > 	  Andrew
> 
> Sorry for the late reply. I recently started my first job and have been
> a bit busy settling in.
> 
> To answer your question: this path is hit extremely rarely. In practice,
> I only observed it in rather extreme cases, such as forcibly
> disconnecting the physical link (e.g. unplugging the Ethernet cable). I
> have not seen it occurring during normal operation.

In that case, i think this is fine. There is a race condition here
between indicating the carrier is down and the network stopping
passing packets, so this can happen, and incrementing the counter is
fine.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

