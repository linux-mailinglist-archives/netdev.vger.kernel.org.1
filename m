Return-Path: <netdev+bounces-151986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E149F23E4
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 13:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88A0188620F
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF2C16D9C2;
	Sun, 15 Dec 2024 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lWAp+Zkb"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E7A14B976
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266942; cv=none; b=FVBKZjAZppn/Q9qKBEUTywDf7+MVaYjpoaFIOzkQ+gstPZCeNloPqktm2rklKWfQS/XVL6bpe5veh5GwPQ2ezOxQGmRSRKlQ/ZfzPpvIgv2uPlbQ7JhQIsCYz+qoCJuwkdfFLlUTWT00Jy1nywJeJ9fHVmboVIFHCz7MjWBMrcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266942; c=relaxed/simple;
	bh=6gjXi03VzQLWObYmgnjFOGcg+wmb7YKY5spjRE7B4/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJnKqp9Tmmj1zZbX/mfsAHJDIUKLY6gMGv/VXsHG9ROsp6uyqmdgCkyui0W7YyQTzZXK2o1VEIWkGJaKf2slz8qIeD0z+1haqIjasmThoUDwAJitSDynRg4X6uepg7TgDr5p/zrYDdB7e6TkL4k6+L2f4Oyd9LqQ+SaRhUK3v5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lWAp+Zkb; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 75B0025400D7;
	Sun, 15 Dec 2024 07:48:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 15 Dec 2024 07:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734266939; x=
	1734353339; bh=qnnJCzKHM35SV1xUzaj9DWVuLknJVmqhok1wVx72BIY=; b=l
	WAp+ZkbC+Mn7ewl+LTRCTggBWGaf5yRRPMXyxo0mUd8r98/KJreDym8zyIw2szd2
	bi2jxD1yfGe+iHfPMAQTScjX0npu8U54vJGp4SNYphA7u+wtKbY/ZRDZu5fQiYmK
	VLI4tgWX1t775RexuvPb35URNYzmldtBEf6w76KOyS0s2PdZJaXsNceDJiVllH+j
	IsgaiwGHmItq/SDMApSoBlUygKx/aFEuoGafHE/a4iQpOBwmaHDiXqDchuz/j8li
	UpJcaphIlVjAumSL5pz1ptUm8Gk3Sg4Jwu0ygLDW4rUQsQM4biN+xXa+MZDKh02k
	1g4FOYSwb5poGCpoQxaKA==
X-ME-Sender: <xms:OtBeZx7yhUrMe53N0dqOwWohz5TkES-zQwid2ukARX4jwVnCtPXCtQ>
    <xme:OtBeZ-4mLZI3RA_fwSwZjmdGDJaKrU_UgHR4wdYZYE6Mugf75B92of1lEpwtE4Gzn
    Rk7wsxSEPatt4s>
X-ME-Received: <xmr:OtBeZ4e_-wyu3Ac0tCLrRohd4h1723gIipfF_NQCSHiLLp6e5Lz4nzRvp0Y0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledugdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtuden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepleeigfdtteehvdegteetgeegudeikeetkeeguddu
    hfeiueevtefgfefffeefteeknecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddtpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrhgvnhguvggtsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpth
    htoheprhhoohhprgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghrihgughgvsehl
    ihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdr
    tghomh
X-ME-Proxy: <xmx:OtBeZ6JCm5wX5DZuk-83pgyCCkTMkUIPT4MKauJXnMpOGffynaqzJw>
    <xmx:OtBeZ1KvlFH0Gz-J9QddhSmAhr_pQC1Sdd4ADx9Wzpsf0ej5J9tEZQ>
    <xmx:OtBeZzzuUI7_z7aN_wyamSv8I8xXUmOYW-aze5FZhndsCNhkPicjIg>
    <xmx:OtBeZxLpbGgz7I--rR8XNb5YVoIXI3jI_3Sc7F4BCr-RPYB7fIm3sw>
    <xmx:O9BeZ-VPbgj5rr6NxFgXsujLEXG_hcHp-xxdAbtRALjuS_S44ofx6ea3>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Dec 2024 07:48:58 -0500 (EST)
Date: Sun, 15 Dec 2024 14:48:56 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Radu Rendec <rrendec@redhat.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next] net/bridge: Add skb drop reasons to the most
 common drop points
Message-ID: <Z17QOJZ1DMzoc5Cj@shredder>
References: <20241208221805.1543107-1-rrendec@redhat.com>
 <2283799b-e1fe-42c2-aecc-50c4ae1f9afa@blackwall.org>
 <c8ab80bb8e3735d301104f29d7f04275ad054214.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8ab80bb8e3735d301104f29d7f04275ad054214.camel@redhat.com>

On Fri, Dec 13, 2024 at 03:33:44PM -0500, Radu Rendec wrote:
> On Tue, 2024-12-10 at 11:18 +0200, Nikolay Aleksandrov wrote:
> > On 12/9/24 00:18, Radu Rendec wrote:
> > > The bridge input code may drop frames for various reasons and at various
> > > points in the ingress handling logic. Currently kfree_skb() is used
> > > everywhere, and therefore no drop reason is specified. Add drop reasons
> > > to the most common drop points.
> > > 
> > > The purpose of this patch is to address the most common drop points on
> > > the bridge ingress path. It does not exhaustively add drop reasons to
> > > the entire bridge code. The intention here is to incrementally add drop
> > > reasons to the rest of the bridge code in follow up patches.
> > > 
> > > Most of the skb drop points that are addressed in this patch can be
> > > easily tested by sending crafted packets. The diagram below shows a
> > > simple test configuration, and some examples using `packit`(*) are
> > > also included. The bridge is set up with STP disabled.
> > > (*) https://github.com/resurrecting-open-source-projects/packit
> > > 
> > > The following changes were *not* tested:
> > > * SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT in br_multicast_flood(). I could
> > >   not find an easy way to make a crafted packet get there.
> > > * SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD in br_handle_frame_finish()
> > >   when the port state is BR_STATE_DISABLED, because in that case the
> > >   frame is already dropped in the switch/case block at the end of
> > >   br_handle_frame().
> > > 
> > >     +---+---+
> > >     |  br0  |
> > >     +---+---+
> > >         |
> > >     +---+---+  veth pair  +-------+
> > >     | veth0 +-------------+ xeth0 |
> > >     +-------+             +-------+
> > > 
> > > SKB_DROP_REASON_MAC_INVALID_SOURCE - br_handle_frame()
> > > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > >   -e 01:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
> > >   -p '0x de ad be ef' -i xeth0
> > > 
> > > SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL - br_handle_frame()
> > > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > >   -e 02:22:33:44:55:66 -E 01:80:c2:00:00:01 -c 1 \
> > >   -p '0x de ad be ef' -i xeth0
> > > 
> > > SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD - br_handle_frame()
> > > bridge link set dev veth0 state 0 # disabled
> > > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > >   -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
> > >   -p '0x de ad be ef' -i xeth0
> > > 
> > > SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD - br_handle_frame_finish()
> > > bridge link set dev veth0 state 2 # learning
> > > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > >   -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
> > >   -p '0x de ad be ef' -i xeth0
> > > 
> > > SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT - br_flood()
> > > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > >   -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
> > >   -p '0x de ad be ef' -i xeth0
> > > 
> > > Signed-off-by: Radu Rendec <rrendec@redhat.com>
> > > ---
> > >  include/net/dropreason-core.h | 18 ++++++++++++++++++
> > >  net/bridge/br_forward.c       |  4 ++--
> > >  net/bridge/br_input.c         | 24 +++++++++++++++---------
> > >  3 files changed, 35 insertions(+), 11 deletions(-)
> > > 
> > 
> > Hi,
> > Thanks for working on this, a few comments below.
> 
> Sure, thanks for reviewing! Please see my comments below.
> 
> > > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> > > index c29282fabae6..1f2ae5b387c1 100644
> > > --- a/include/net/dropreason-core.h
> > > +++ b/include/net/dropreason-core.h
> > > @@ -108,6 +108,9 @@
> > >  	FN(TUNNEL_TXINFO)		\
> > >  	FN(LOCAL_MAC)			\
> > >  	FN(ARP_PVLAN_DISABLE)		\
> > > +	FN(MAC_IEEE_MAC_CONTROL)	\
> > > +	FN(BRIDGE_INGRESS_PORT_NFWD)	\
> > > +	FN(BRIDGE_NO_EGRESS_PORT)	\
> > >  	FNe(MAX)
> > >  
> > >  /**
> > > @@ -502,6 +505,21 @@ enum skb_drop_reason {
> > >  	 * enabled.
> > >  	 */
> > >  	SKB_DROP_REASON_ARP_PVLAN_DISABLE,
> > > +	/**
> > > +	 * @SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL: the destination MAC address
> > > +	 * is an IEEE MAC Control address.
> > > +	 */
> > > +	SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL,
> > > +	/**
> > > +	 * @SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD: the STP state of the
> > > +	 * ingress bridge port does not allow frames to be forwarded.
> > > +	 */
> > > +	SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD,
> > 
> > Since this is used only when the port state causes the packet to drop, why not
> > rename it to something that suggests it was the state?
> 
> Yes, Ido had a similar suggestion [1], so it's clear that it must be
> renamed. I will go with SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE in the
> next version, unless you have a better idea.
> 
> > > +	/**
> > > +	 * SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT: no eligible egress port was
> > > +	 * found while attempting to flood the frame.
> > > +	 */
> > > +	SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT,
> > >  	/**
> > >  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
> > >  	 * shouldn't be used as a real 'reason' - only for tracing code gen
> > > diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> > > index e19b583ff2c6..e33e2f4fc3d9 100644
> > > --- a/net/bridge/br_forward.c
> > > +++ b/net/bridge/br_forward.c
> > > @@ -249,7 +249,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
> > >  
> > >  out:
> > >  	if (!local_rcv)
> > > -		kfree_skb(skb);
> > > +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);
> > 
> > This is not entirely correct, we can get here if we had an error forwarding
> > the packet to some port, but it may already have been forwarded to others.
> > The reason should distinguish between those two cases.
> 
> I will follow Ido's suggestion [2] and rename SKB_DROP_REASON_VXLAN_NO_REMOTE
> to SKB_DROP_REASON_NO_TX_TARGET, and then use that.
> 
> But it will only cover the case when there are no errors, so I still
> need a different reason for the error case. I looked, and I couldn't
> find an existing one that's close enough, so I think I should create a
> new one. How about SKB_DROP_REASON_TX_ERROR? I would not use "BRIDGE"
> in the name because I'm thinking it may be reused elsewhere, outside
> the bridge module.

AFAICT the only possible error is skb_clone() failure and this is
supposed to be covered by 'SKB_DROP_REASON_NOMEM'.

> 
> > >  }
> > >  
> > >  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> > > @@ -349,6 +349,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
> > >  
> > >  out:
> > >  	if (!local_rcv)
> > > -		kfree_skb(skb);
> > > +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);
> > 
> > Same comment as above (br_flood).
> > 
> > >  }
> > >  #endif
> > > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > > index ceaa5a89b947..fc00e172e1e1 100644
> > > --- a/net/bridge/br_input.c
> > > +++ b/net/bridge/br_input.c
> > > @@ -96,8 +96,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
> > >  	if (br_mst_is_enabled(br)) {
> > >  		state = BR_STATE_FORWARDING;
> > >  	} else {
> > > -		if (p->state == BR_STATE_DISABLED)
> > > -			goto drop;
> > > +		if (p->state == BR_STATE_DISABLED) {
> > > +			kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> > > +			return 0;
> > > +		}
> > >  
> > >  		state = p->state;
> > >  	}
> > > @@ -155,8 +157,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
> > >  		}
> > >  	}
> > >  
> > > -	if (state == BR_STATE_LEARNING)
> > > -		goto drop;
> > > +	if (state == BR_STATE_LEARNING) {
> > > +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> > > +		return 0;
> > > +	}>  
> > >  	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
> > >  	BR_INPUT_SKB_CB(skb)->src_port_isolated = !!(p->flags & BR_ISOLATED);
> > > @@ -331,8 +335,10 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
> > >  	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
> > >  		return RX_HANDLER_PASS;
> > >  
> > > -	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> > > -		goto drop;
> > > +	if (!is_valid_ether_addr(eth_hdr(skb)->h_source)) {
> > > +		kfree_skb_reason(skb, SKB_DROP_REASON_MAC_INVALID_SOURCE);
> > > +		return RX_HANDLER_CONSUMED;
> > > +	}
> > >  
> > >  	skb = skb_share_check(skb, GFP_ATOMIC);
> > >  	if (!skb)
> > > @@ -374,7 +380,8 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
> > >  			return RX_HANDLER_PASS;
> > >  
> > >  		case 0x01:	/* IEEE MAC (Pause) */
> > > -			goto drop;
> > > +			kfree_skb_reason(skb, SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL);
> > > +			return RX_HANDLER_CONSUMED;
> > >  
> > >  		case 0x0E:	/* 802.1AB LLDP */
> > >  			fwd_mask |= p->br->group_fwd_mask;
> > > @@ -423,8 +430,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
> > >  
> > >  		return nf_hook_bridge_pre(skb, pskb);
> > >  	default:
> > > -drop:
> > > -		kfree_skb(skb);
> > > +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> > >  	}
> > >  	return RX_HANDLER_CONSUMED;
> > >  }
> 
> [1] https://lore.kernel.org/bridge/Z1sLyqZQCjbcCOde@shredder/
> [2] https://lore.kernel.org/bridge/Z1sUsSFfBC9GoiIA@shredder/
> 
> --
> Best regards,
> Radu
> 

