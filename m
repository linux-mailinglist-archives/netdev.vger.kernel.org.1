Return-Path: <netdev+bounces-151984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83609F23BC
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 13:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4594D1885628
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E082161320;
	Sun, 15 Dec 2024 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="act5TLKY"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46D160884
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266027; cv=none; b=FtroKJy5lMeC10Cr/nho63m/6LC9go8YGMYPoPACWSiUzYPwBL8dSRKmPqPgZMM588Fy83pu4g7HzWfPGodcb8BFpE+IBM/nbXpgN6Z88AGZi1B0TRTA8uGJjexgUIBTnv58O/IR5ulM/+ENSXLXltbuS097/n5RLqp/eV+i5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266027; c=relaxed/simple;
	bh=zlNIAH1vOoF5TgVyc/IxBA+tuFz9FIjxEualz/XzgWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAMs53xWpi3pnr4qQZl2cpQ351yZdtk4s82HKk8SK1B+UaGm7v9jSIbxcdCM/2Zle+0ysq1Qdm0HmZUmgLomgHlPC7VVbUgutqZu7hSdHW7ACB3RfolpDLYMFuQic1F91VIfLumg/0hDiJ01CAvoMdgN4d3gdyqFxVEerS8XYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=act5TLKY; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 545AD2540073;
	Sun, 15 Dec 2024 07:33:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 15 Dec 2024 07:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734266024; x=
	1734352424; bh=Jl0v0XhcapACQOaaZSTntj4zbNZ+NcuJ80tAfZHkifk=; b=a
	ct5TLKY54kU0KCY2YdyZVMCPKa173yfCUvfWQWAdisncNlnFxre1rQTXZ/ph8jgm
	8+yaW+Ad+SGQLgWgdS5ZsVKTX/1BtGdj3BF6QrP6aOVsjL1HmL5MUO4llNoDP4Kp
	HVYwChbZ4L+HBzRm2sH+5URSKp7S9Au/8B7FkBKS1m57BV1zmLBdxItvvucSu9Q5
	8vvhv639lSUuJq6blHmofvCX4iz6BTud8WMwiisZgbuVT6GUmSUT5xLleNSg0QgZ
	tDbe04QnADaTzrzPxVi8BKTZ1PE5YCyLi/XHxwIZuU0EQcLy4VeN4+UOYxProYAI
	aycezt/Yyt5LJDF81HCOg==
X-ME-Sender: <xms:p8xeZ5lEZuCfrSSQ_nOOViezZADjdpMa5SLloL4Y5XEdwLRuUj37vA>
    <xme:p8xeZ03HLqDZxLXDNsuPCFR8SUeyXz7TyMy7D1gDe2_jsbyeiRoS2TIRF1-c2lOEI
    AQ1MgMNwJssXNs>
X-ME-Received: <xmr:p8xeZ_phVrNEn3vpHHXypuJss7hjbM3EqRgzkDOwSkZ5dXjwgZKZK-iobfIv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtuden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepleetgeeggeeivdegjeelffdufeegjeeugeduudei
    vdevueefieefteeufeelvdeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhes
    ihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprhhrvghnuggvtgesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    rhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtphhtthhopehrohhophgrsehnvh
    hiughirgdrtghomhdprhgtphhtthhopegsrhhiughgvgeslhhishhtshdrlhhinhhugidr
    uggvvhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghn
    ihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:p8xeZ5m_KVsgrFVRVoHvAxLSkdeg0FoyGGcfw1gn15o4kDbsdDAZbg>
    <xmx:p8xeZ33OOd4a4AlA8rI4lH9btDHMb0AOViQuHcgzxOFuBR1HgUNpzw>
    <xmx:p8xeZ4vVQ9DDR0yaC1L4coR7yrKU2YPH8BBGocqB68mawnlcqkT0Yg>
    <xmx:p8xeZ7VffnctL-MpftU-6O3UPtJjS8zYhutDXYPzWBtOMmmSRgj-rg>
    <xmx:qMxeZ5z4gcew3Fqdv0I6bd2vhubvAjwdnnzYAHA-Xp4LywUFgDfz3nDA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Dec 2024 07:33:42 -0500 (EST)
Date: Sun, 15 Dec 2024 14:33:40 +0200
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
Message-ID: <Z17MpOdRsUjBt4Hi@shredder>
References: <20241208221805.1543107-1-rrendec@redhat.com>
 <Z1sLyqZQCjbcCOde@shredder>
 <84e3d3e998f1a02dd742727c2e18b7c364c36389.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84e3d3e998f1a02dd742727c2e18b7c364c36389.camel@redhat.com>

On Fri, Dec 13, 2024 at 03:44:49PM -0500, Radu Rendec wrote:
> On Thu, 2024-12-12 at 18:14 +0200, Ido Schimmel wrote:
> > On Sun, Dec 08, 2024 at 05:18:05PM -0500, Radu Rendec wrote:
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
> > 
> > IMO, dropping pause frames is not among "the most common drop points".
> > Are you planning on reusing this reason in other modules? If not, then I
> > prefer removing it. My understanding is that we should not try to
> > document every obscure drop with these reasons.
> 
> Fair enough. I don't have an immediate plan to reuse this reason, and
> to be honest, I'm not that familiar with the networking stack to be
> able to tell off hand if it's likely to be useful elsewhere.
> 
> Would you prefer to stick to not specifying a drop reason at all at
> that particular drop point, or to reuse an existing reason? Two
> existing reasons that could be used (although they are not entirely
> accurate) are:
> SKB_DROP_REASON_UNHANDLED_PROTO
> SKB_DROP_REASON_MAC_INVALID_SOURCE

Both aren't really applicable in this case and I doubt users are hitting
this drop point in practice, but I feel like I don't have a good
argument against adding 'SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL', so maybe
just keep it ^o^

