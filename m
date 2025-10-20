Return-Path: <netdev+bounces-230920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F6ABF1B89
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 16:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C445B422DFD
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE3C320CAA;
	Mon, 20 Oct 2025 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lmukVkr5"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D63203AA;
	Mon, 20 Oct 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969190; cv=none; b=RTBgRA7J/X7B1L4VyqqB2es8pahg2ekbsUZIrD+ec63sHSSTVMFw7pCY77d60Fmhk/XsLojbCCUY4XiaLPz6Tr8PCxB3Mir9WS3h4FwxiZjZiLQmRouUwI7++PI0pP2ko/uyHBvGW357nVFYaaVGBp/4ZVhsLlbuahqMEu7lIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969190; c=relaxed/simple;
	bh=WyrvcJ5Dim/Le6wvDha2V0XjNhv/RlSVUnyt4KG3XE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWuiOBngX+eHJk+atbiaRYJ3K/54qERobSxlou7SzciFqOu6+m1CLZ6vRH8dc9355l9kkdkdxuFJQHFCptFzB7CVCh2Il0bjW9a04gKUImfB6mYzJkmS+e85fZsd77s1OmciBdGmu+TPs5z4xTDN+WxcYSIisdNfYomizZLGu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lmukVkr5; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 7AB271D000CD;
	Mon, 20 Oct 2025 10:06:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 20 Oct 2025 10:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760969186; x=
	1761055586; bh=L2vhqj6LN2Z+N6Hcnl0Dbm5DCmODv4qd3WME6aChiWs=; b=l
	mukVkr5njN7HG71m+LXOpsvm+1yoOeQsb4MtLdABlpypCxrqMPvyZPBfyf2YRc1b
	z8UVXg6hHoGt2y/m+MMNWbFlcz5ewI8t6dA8P85sr5gZCgMyLgTIFjSkYlNBx7YR
	Q826lS5pPHv0Bm4vUt4dVcgjMd3D2tDU9U/TNXcpgyg/7FeOucHqrhnb+ssuw59R
	eqJ9Zw9XvLq799mx68XOHxas/ZAlUYi3nwYbG41WRX/pgA+qkpIgnpCa7M6RVlFQ
	cudDb7Daw2/O9meYpI5MPQfHTPRSqaonJ03ZYLLkxZoMcZAkFqMYOrQvxj9G6+9t
	ofRqPhOTrY6Qscz3k651g==
X-ME-Sender: <xms:4UH2aFuT85Tai-wRfA9tjUt8YOKEwyw1k-SSiPjP1S9Ra4JBw4phew>
    <xme:4UH2aDY1ihHvQE-PgcKoPfQ7063tUI_eYHaWK50ds9D5PC94eCFb-khyvYFWbf93v
    e6W0-VWPGhmxN32gpoLWA82M10BCfc55RP-ZREs9WZGbBau7qQ>
X-ME-Received: <xmr:4UH2aNBb7wbgV5i-hu8Yzryaa-HU7l3ttakJT4YToVjXwkWCLiW06502>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeektddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiugho
    shgthhdrohhrgheqnecuggftrfgrthhtvghrnhepudelvdejjeehgfdvteehfeehteejje
    efteejveeijefgueejffelffegkeffueeinecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgrdhgohhllhgvrhesphhrohigmhhogidrtghomhdprh
    gtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepughs
    rghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhsse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:4UH2aL-tyBUEhFzsQTkB9tRUPRI7sstkRiy5UjHtXwO_HL-OyzrSeg>
    <xmx:4UH2aJSQpil6IkfZCvW5nnANdhc4n5MlafwMPRoJDJszjquV4g3PQQ>
    <xmx:4UH2aPVtDHp6xqa47Ovgog8iUPXIcmyctr48Fv9_Ybzyd4INX2ivIg>
    <xmx:4UH2aDQol2m_oyK4-qcEtPyD0LPjd7pdHmqxzhF7lvn-4fyKot_zcg>
    <xmx:4kH2aLCc2NQgEIN7Nlh0qvU73c5EbKhcFGX8-P-wDwtgVMXsR53BTk9o>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 10:06:25 -0400 (EDT)
Date: Mon, 20 Oct 2025 17:06:23 +0300
From: Ido Schimmel <idosch@idosch.org>
To: g.goller@proxmox.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Wrong source address selection in arp_solicit for forwarded
 packets
Message-ID: <aPZB33C-C1t1z7Dk@shredder>
References: <eykjh3y2bse2tmhn5rn2uvztoepkbnxpb7n2pvwq62pjetdu7o@r46lgxf4azz7>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eykjh3y2bse2tmhn5rn2uvztoepkbnxpb7n2pvwq62pjetdu7o@r46lgxf4azz7>

On Fri, Oct 17, 2025 at 04:47:27PM +0200, Gabriel Goller wrote:
> Hi,
> I have a question about the arp solicit behavior:
> 
> I have the following simple infrastructure with linux hosts where the ip
> addresses are configured on dummy interfaces and all other interfaces are
> unnumbered:
> 
>   ┌────────┐     ┌────────┐     ┌────────┐    │ node1  ├─────┤ node2
> ├─────┤ node3  │    │10.0.1.1│     │10.0.1.2│     │10.0.1.3│    └────────┘
> └────────┘     └────────┘

The diagram looks mangled. At least I don't understand it.

> 
> All nodes have routes configured and can ping each other. ipv4 forwarding is
> enabled on all nodes, so pinging from node1 to node3 should work. However, I'm
> encountering an issue where node2 does not send correct arp solicitation
> packets when forwarding icmp packets from node1 to node3.

I believe ICMP is irrelevant here.

> 
> For example, when pinging from node1 to node3, node2 sends out the
> following arp packet:
> 
> 13:57:43.198959 bc:24:11:a4:f6:cd > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100),
> length 46: vlan 300, p 0, ethertype ARP (0x0806), Ethernet (len 6),
> IPv4 (len 4), Request who-has 10.0.1.3 tell 172.16.0.102, length 28
> 
> Here, 172.16.0.102 is an ip address configured on a different interface on
> node2. This request will never receive a response because `rp_filter=2`.
> 
> node2 has the following (correct) routes installed:
> 
> 10.0.1.3 nhid 18 via 10.0.1.3 dev ens22 proto openfabric src 10.0.1.2 metric 20 onlink
> 
> Since arp_announce is set to 0 (the default), arp_solicit selects the first
> interface with an ip address (inet_select_addr), which results in
> selecting the wrong source address (172.16.0.102) for the arp request.
> Because rp_filter is set to 2, we won't receive an answer to this arp
> packet, and the ping will fail unless we explicitly ping from node2 to
> node3.
> 
> I'm wondering if it would be possible (and correct) to modify arp_solicit to
> perform a fib lookup to check if there's a route with an explicit source
> address (e.g., the route above using src 10.0.1.2) and use that address as the
> source address for the arp packet. Of course, this wouldn't be backward
> compatible, as some users might rely on the current interface ordering behavior
> (or the loopback interface being selected first), so it would need to be
> controlled via a sysctl configuration flag. Perhaps I'm missing something
> obvious here though.

This would probably entail adding a new arp_announce level, but nobody
added a new level in at least 20 years, so you will need to explain why
your setup is special and why the same functionality cannot be achieved
in a different way that does not require kernel changes.

A few things you can consider:

1. You wrote that the router interfaces are unnumbered. Modern
unnumbered networks usually assign IPv6 link-local addresses to these
interfaces. These addresses are only used for neighbour resolution and
can be used as the nexthop address for IPv4 routes. For example:

ip route add 192.0.2.1/32 nexthop via inet6 fe80::1 dev dummy1

Or using nexthop objects:

ip nexthop add id 1 via fe80::1 dev dummy1
ip route add 192.0.2.1/32 nhid 1

2. If you have interfaces whose addresses should not be considered as
source addresses when generating IP/ARP packets out of other interfaces,
then you can try placing them in a different VRF if it's viable.

3. Requires some work and I didn't look too much into it, but I believe
it should be possible to derive the preferred source address and rewrite
it in ARP packets using tc-bpf on egress. See:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dab4e1f06cabb6834de14264394ccab197007302

