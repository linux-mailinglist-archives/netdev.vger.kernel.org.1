Return-Path: <netdev+bounces-231332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABE1BF7879
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97DD4200A9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA83446D0;
	Tue, 21 Oct 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m7rFIcep"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8ED3431FF;
	Tue, 21 Oct 2025 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062219; cv=none; b=pMELcuQALiZFln4FXYbcP2kccBxC7e1/zDe9FMlld5L3F7lFtkpDXIYhti/RdX/GRjVt2yI/xW8LGWThq+MgO5z2fB91V8QJ7EPTXyGfgi0oQdbBbgyd8XdlxeNmaAd9niYu+bst0wJGWI+n+Ja/K42NtTSLNRMfT/SHrsmb5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062219; c=relaxed/simple;
	bh=k+3GyVKvPrng59do5wtL6iKnaaTY7D3oNShC+ZnxHvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1ubPZrRYYAzGFALkPo3XwazKsKAK7Ri37/1mgLY5HoRT/zRPDh/JB8GmlSPzzBCZJWASiKomrx3HzA97m6uCHWVbdMe2ZTQW8ieCqvkOoN72CX2EDZo8VsR89Oq1o4n+8PPTzWIOc2x1Hgqw6I5qhwxViZgiUyhA8Ds5EfYChw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m7rFIcep; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 96E4BEC01E4;
	Tue, 21 Oct 2025 11:56:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Oct 2025 11:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761062214; x=1761148614; bh=byUZFd3/ULJFsBc0eWzLiJYFp2wANAnzYMV
	PhIjh5lI=; b=m7rFIcepIqc+6/tV6SraQVonhWmLDebiNF7108dZrUcw0BkNv/V
	MBbPphflf4WEps66EItdkOybUd2EuNv+/JlIR/w9+uNSDy1JEUABh4ulOVFBRdZL
	dR6weaVqq3duqpNUi7dSLAbUtPaBq9/b//ukA3PTPibHrq1gQSPhvOdpMSQLEK/Z
	IrOI6liPBYRimcxfSjmJWbVRhP4O9he1hf6HZp7ZsYnQFAQoikTZeky/utdd2UGo
	+zhu4j+ejxqH0hvNpcWvLeWFrvZ3iCD35URl/3HEepVLXkaLIek7lwa/LZg4q8Ja
	PoLEa4tEfrzBvECj37aB+DUSdQRkt6F3FrA==
X-ME-Sender: <xms:Ra33aHFBaoyMX7VV1jgDksgZgklpWvDx5c1-cUYCQGc1MLllpo-n4g>
    <xme:Ra33aJQYwp8sF_YGyfSbTjYktxR8WafP6HyaDc2qnBPPFSXY6GCmFSeEEfJNjgUN2
    kzV2mTlJkNLUSzpH8-5vmPeo-BZPFp0OSBC9LtCK8WC6BOCIi0>
X-ME-Received: <xmr:Ra33aNaeqel13dPGbnheQ5HRyJJUNUPVkHgRelO8t_Fu_z8swqOdUuXW99cBO7N0hlgXn8_cUTvGrwhbmoP31708U69Juw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhs
    tghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduie
    efudeifefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprh
    gtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrdhgohhllhgv
    rhesphhrohigmhhogidrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvg
    htuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Rq33aE2b1vSc7oLVj0kC1Zv8vdzxls0_HFs-jbj5g0BxOhhkj2PVKQ>
    <xmx:Rq33aApK6shnWLjaEHaFLdTX1qsQ3JKBjiPlunWqh243mIg13UUZuQ>
    <xmx:Rq33aDNpSm9TKgzwVEQfsVKmNLMIdNvFEpl7DVlO4bVaEnYT92osQg>
    <xmx:Rq33aJrV3OUyJNvP0hs7Cyp7EqDb2ghaKJuWHC83qqT8AI3GsMn-VQ>
    <xmx:Rq33aEaCV1pTZYpqkpH8Oia96fR1tDMG1IQ85MhJEfABcKBUQkFANKu6>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 11:56:53 -0400 (EDT)
Date: Tue, 21 Oct 2025 18:56:51 +0300
From: Ido Schimmel <idosch@idosch.org>
To: g.goller@proxmox.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Wrong source address selection in arp_solicit for forwarded
 packets
Message-ID: <aPetQ3LZo0Uikke5@shredder>
References: <eykjh3y2bse2tmhn5rn2uvztoepkbnxpb7n2pvwq62pjetdu7o@r46lgxf4azz7>
 <aPZB33C-C1t1z7Dk@shredder>
 <76z4ckbvjimtrf2foaislezs4vlru5upxn3i5ysu4au2m2pfei@slgxispho2iv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76z4ckbvjimtrf2foaislezs4vlru5upxn3i5ysu4au2m2pfei@slgxispho2iv>

On Tue, Oct 21, 2025 at 02:31:51PM +0200, Gabriel Goller wrote:
> Hmm I don't know how this would help? There is a link-local address set
> on the interface, but we would have to add a ipv6 source address to the
> arp packet which wouldn't be right?

There are no ARP packets. Neighbour resolution is performed via IPv6
NA/NS messages. The script below [1] replicates your setup as I
understand, but it uses IPv6 link-local addresses for the nexthops.

[1]
#!/bin/bash

cleanup() {
	for i in {1..3}; do
		ip netns del node${i} &> /dev/null
	done
}

trap cleanup EXIT

cleanup

for i in {1..3}; do
	ip netns add node${i}
	ip netns exec node${i} sysctl -wq net.ipv4.conf.all.forwarding=1
	ip netns exec node${i} sysctl -wq net.ipv4.conf.all.rp_filter=2
	ip -n node${i} link set dev lo up
	ip -n node${i} link add name dummy up type dummy
	ip -n node${i} address add 10.0.1.${i}/32 dev dummy
done

ip -n node1 link add name veth1 type veth peer name veth2 netns node2
ip -n node2 link add name veth3 type veth peer name veth4 netns node3

ip -n node1 link set dev veth1 up
ip -n node2 link set dev veth2 up
ip -n node2 link set dev veth3 up
ip -n node3 link set dev veth4 up

ip -n node1 address add fe80::1/64 dev veth1 nodad
ip -n node2 address add fe80::2/64 dev veth2 nodad
ip -n node2 address add fe80::3/64 dev veth3 nodad
ip -n node3 address add fe80::4/64 dev veth4 nodad

ip -n node1 route add 10.0.1.2/32 src 10.0.1.1 nexthop via inet6 fe80::2 dev veth1
ip -n node1 route add 10.0.1.3/32 src 10.0.1.1 nexthop via inet6 fe80::2 dev veth1
ip -n node2 route add 10.0.1.1/32 src 10.0.1.2 nexthop via inet6 fe80::1 dev veth2
ip -n node2 route add 10.0.1.3/32 src 10.0.1.2 nexthop via inet6 fe80::4 dev veth3
ip -n node3 route add 10.0.1.1/32 src 10.0.1.3 nexthop via inet6 fe80::3 dev veth4
ip -n node3 route add 10.0.1.2/32 src 10.0.1.3 nexthop via inet6 fe80::3 dev veth4

ip netns exec node1 ping 10.0.1.3 -c 5
ip netns exec node1 ping 10.0.1.2 -c 5

