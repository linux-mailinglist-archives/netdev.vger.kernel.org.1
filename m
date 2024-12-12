Return-Path: <netdev+bounces-151449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4A39EF5D5
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6FC177E1B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14F7222D66;
	Thu, 12 Dec 2024 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMrHWH9A"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A45231A42
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022328; cv=none; b=AMAjp116T9BhVwT+LL+Nvg3o97JopfccBv3gLOFZkvUgutNzrAkFsDbSi7X/B1n1LbAW22K/H4C3UJZ9SEtc0amsCkJDSLjuOLsahTt0C0BUR/qDEJjQ7UIPU4g41ZeimWHYfH5MAEMpH94lPUO7yve+AKxxOK8uCKvljuPJPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022328; c=relaxed/simple;
	bh=7qYvNSeXoWkdvA5eZJ8O8ibDKaD+r5FO0pBlFK/OHUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/qNwWNY7uK2xwAudz+uZl8Ct41MQOitqxJY/tLMMuqaiNtM5yCCMSWuAreCZxJr3FGi5F8vJNe7/CMyfPBPRipSXjLC5Nttvqs/hVmnCUWMrICOheMIXhB1gT8JRGe/Rm0L8VO+R36i0py5IQNIEYYB5LZhTo5GrKTZlK++2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hMrHWH9A; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5D1E1140113;
	Thu, 12 Dec 2024 11:52:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Dec 2024 11:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734022325; x=1734108725; bh=GeXD2sSmBBV8R1v1RtzrEUtehrOoDSHPWlO
	D+g/SP4Y=; b=hMrHWH9A2cIrYMmo7jCGDpwb+kp06K/thiw/oDuAhP9n6fgfRnH
	plw5R60cqc9zo30OSYB7t5gg/9OtJjekJAJkuY1pPfqnKlz6uOH7ZUhmgZlqP5LR
	GjLjt0SJ81p2Ilqqyuf0KJba+hLU+RIcDRZSHgBWvlIJYYknQvV9pnlq9mJOlENn
	MbrEeho5OLatr1N6aAWyGMnuNu/w8mbxC6q9scrrEdWOCkQa1B/nWiwZFQhslpJC
	zJFvM+fqA04VaJq+bBH8YMec7DDSINnU7lUJe4uazpKSaCx/M+KlbwU1fsxot1fU
	lqLImhDrgWDco0ImhT1SEKK0+pBvbCZ/Sjw==
X-ME-Sender: <xms:tRRbZ4yX9-0OrBxmr4T7jTWFi4Lek__bCpgnPpVon9KopSuyYFktCQ>
    <xme:tRRbZ8RqmSk3LHNk4JIm-pxhOVpGvdLDlWN-Ry2Ma3DexWLB1mvbaeA4AvTFcZp2y
    KnzWsW1rhhQJKg>
X-ME-Received: <xmr:tRRbZ6XlTuhA7cx7FYvmarecn-_h1gi4_eRtyPVyjHe2skXsk8tYckhps-JhYDk58E-tLmBP3UCv4dFl7YXuQItkbgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefg
    leekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthho
    pedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgriihorhessghlrggtkh
    ifrghllhdrohhrghdprhgtphhtthhopehrrhgvnhguvggtsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehrohhophgrsehnvhhiughirgdrtghomhdprhgtphhtthhopegsrhhiug
    hgvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    khhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:tRRbZ2hx6doe9veCPR_nmu4XyDQpVCp3rDH7yX9WX8pAB-mRr50LAw>
    <xmx:tRRbZ6B9bOnzgp-IdL1BUQU2Hmvq5nv_pN5uviAUTonAhr1aD5SwAg>
    <xmx:tRRbZ3LZdexVebspHzeCVhxuyWHabY5fgvyZO0nfRldrzlzQcH-48A>
    <xmx:tRRbZxCTP1Ncnl552Is2Q0V0nX5zkgXBpkRBj-xx4fjiQRuGUfyvew>
    <xmx:tRRbZyu8Xei8Z79IDJy2d_NVYN9l-hOw-m1jnHnTM03byK8HvRi8i_mf>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 11:52:04 -0500 (EST)
Date: Thu, 12 Dec 2024 18:52:01 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Radu Rendec <rrendec@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next] net/bridge: Add skb drop reasons to the most
 common drop points
Message-ID: <Z1sUsSFfBC9GoiIA@shredder>
References: <20241208221805.1543107-1-rrendec@redhat.com>
 <2283799b-e1fe-42c2-aecc-50c4ae1f9afa@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2283799b-e1fe-42c2-aecc-50c4ae1f9afa@blackwall.org>

On Tue, Dec 10, 2024 at 11:18:06AM +0200, Nikolay Aleksandrov wrote:
> On 12/9/24 00:18, Radu Rendec wrote:
> > +	/**
> > +	 * SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT: no eligible egress port was
> > +	 * found while attempting to flood the frame.
> > +	 */
> > +	SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT,
> >  	/**
> >  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
> >  	 * shouldn't be used as a real 'reason' - only for tracing code gen
> > diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> > index e19b583ff2c6..e33e2f4fc3d9 100644
> > --- a/net/bridge/br_forward.c
> > +++ b/net/bridge/br_forward.c
> > @@ -249,7 +249,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
> >  
> >  out:
> >  	if (!local_rcv)
> > -		kfree_skb(skb);
> > +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);
> 
> This is not entirely correct, we can get here if we had an error forwarding
> the packet to some port, but it may already have been forwarded to others.
> The reason should distinguish between those two cases.

Regarding 'SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT', there is a similar
reason in VXLAN called 'SKB_DROP_REASON_VXLAN_NO_REMOTE' which basically
means the same thing. Maybe we can rename it to
'SKB_DROP_REASON_NO_TX_TARGET' (or something similar) and reuse it here?

> 
> >  }
> >  
> >  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> > @@ -349,6 +349,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
> >  
> >  out:
> >  	if (!local_rcv)
> > -		kfree_skb(skb);
> > +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);
> 
> Same comment as above (br_flood).
> 
> >  }
> >  #endif
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index ceaa5a89b947..fc00e172e1e1 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -96,8 +96,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
> >  	if (br_mst_is_enabled(br)) {
> >  		state = BR_STATE_FORWARDING;
> >  	} else {
> > -		if (p->state == BR_STATE_DISABLED)
> > -			goto drop;
> > +		if (p->state == BR_STATE_DISABLED) {
> > +			kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> > +			return 0;
> > +		}
> >  
> >  		state = p->state;
> >  	}
> > @@ -155,8 +157,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
> >  		}
> >  	}
> >  
> > -	if (state == BR_STATE_LEARNING)
> > -		goto drop;
> > +	if (state == BR_STATE_LEARNING) {
> > +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> > +		return 0;
> > +	}>  
> >  	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
> >  	BR_INPUT_SKB_CB(skb)->src_port_isolated = !!(p->flags & BR_ISOLATED);
> > @@ -331,8 +335,10 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
> >  	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
> >  		return RX_HANDLER_PASS;
> >  
> > -	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> > -		goto drop;
> > +	if (!is_valid_ether_addr(eth_hdr(skb)->h_source)) {
> > +		kfree_skb_reason(skb, SKB_DROP_REASON_MAC_INVALID_SOURCE);
> > +		return RX_HANDLER_CONSUMED;
> > +	}
> >  
> >  	skb = skb_share_check(skb, GFP_ATOMIC);
> >  	if (!skb)
> > @@ -374,7 +380,8 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
> >  			return RX_HANDLER_PASS;
> >  
> >  		case 0x01:	/* IEEE MAC (Pause) */
> > -			goto drop;
> > +			kfree_skb_reason(skb, SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL);
> > +			return RX_HANDLER_CONSUMED;
> >  
> >  		case 0x0E:	/* 802.1AB LLDP */
> >  			fwd_mask |= p->br->group_fwd_mask;
> > @@ -423,8 +430,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
> >  
> >  		return nf_hook_bridge_pre(skb, pskb);
> >  	default:
> > -drop:
> > -		kfree_skb(skb);
> > +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> >  	}
> >  	return RX_HANDLER_CONSUMED;
> >  }
> 
> Cheers,
>  Nik
> 
> 

