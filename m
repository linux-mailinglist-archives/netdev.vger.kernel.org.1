Return-Path: <netdev+bounces-179531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8BBA7D7DA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC27E18923FA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E6225761;
	Mon,  7 Apr 2025 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JN/h/ccI"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE0820F087
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014549; cv=none; b=dhpRrT10v+QGo9d5pjagJR9vdI6oWYDjk65Mr7n3zB8f+gEmq3GIeCUNFe3BPDwgEs4fsPn3IsIXEoXykDDw/HueUD5xRcfLQQ+ovSswhfyVEbONjp+BeiAVI8iyqJXKKeSaUBao6wVy1s4qRlmyT9lOHg1hZzkRGcmmFZ5MJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014549; c=relaxed/simple;
	bh=j1zFHOO3QXQlmSvCN0nGa7ycLvrc/A5/JbaW6VhwDRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3zkkmc20Rdcn/LHRwptmZEwYOXqkMH9mRt9iDBGRKXAoDskATBYMnoMp8KAw4UCerYP9/g7aAcPi68qFpw/tmJC6PGlWvOupZ7vCHjt5ZxAM2tp0RoqBYWkSnvMOHErEb3r8f0VaWvcONwLtSBKp4Cp00OVhJeE1XpLN8/gZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JN/h/ccI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 57914138022D;
	Mon,  7 Apr 2025 04:29:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 07 Apr 2025 04:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744014545; x=1744100945; bh=jE9JC2RQOuxKMxEEUTFOhvA/zfEeLfzNlDf
	udeKS0wM=; b=JN/h/ccIROHMCvw5sSfkfeqJAL9KkUsZ2cetBgVx4fhAg0kBonO
	HeFoPOE0QeoG7vlahPnrRIypacGrtwsk+G0Cg60zmfetF/QPrUP6iBnH4M/vYYR/
	gnX6O1R3uxF1yH9eGKTcjISNk2NhHbRgrni8zpANjHBH0Mzdksi5jce7LD/gzjhh
	A2DhnssZOAeErEzGvI1vlyeLsPFf4L55l+p40fWURR9RX3qC2ESRRu7deQjyFBsQ
	LUMskuwa5aCSHinaP7OyQAevmJMb6v8RKBkNER6rtoVttyMPOp1wSQCHw/zcZYQU
	+WbB1ci8yZzmqOrhH0PQMpWzKFlOdGwciyA==
X-ME-Sender: <xms:0IzzZ8sylz2Pe5lf9R8FfqJMppbRc-to_AnL3gmD4-YTlN5Y_6ay3g>
    <xme:0IzzZ5ceHTakXgWzzoNCQmvT66DyJBrgrOIlLAooUItTLjpC0OGiW40K4dsJb9N_e
    n1IbdE0LgfNzz4>
X-ME-Received: <xmr:0IzzZ3wIdlAEUqbN-jfxj2YcfFKkIaxbScXmhnrATLuXeWU_qog6Q0LI6DF7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgv
    lhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvud
    efveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesih
    guohhstghhrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehhrghnhhhuihhhuhhiheeshhhurgifvghirdgtohhmpdhrtghpthhtoh
    epnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughsrghh
    vghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:0IzzZ_NwFO3kc6Kw7de64BJYCMUHk2VqTNZjq2EIiKIIGXhc35BTJw>
    <xmx:0IzzZ88tdmWNrKlkuxIlKObvAPwyL3Tu6ZCEBwXLmKlmGFRUqoCC1w>
    <xmx:0IzzZ3UXNJ764vmlwkscWr443D_8SksReSRbpNnoEl3B8EG6rhMeFw>
    <xmx:0IzzZ1esurFuOw8kGX8phpEO8ezFVP4_xVjx5vuThjKOG3UnNOWF4A>
    <xmx:0YzzZyfamB4ZKlUdDCFSq4aAaCl9nknR3-9u0L1Nda36hTMYWdHuZr-p>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 04:29:04 -0400 (EDT)
Date: Mon, 7 Apr 2025 11:29:02 +0300
From: Ido Schimmel <idosch@idosch.org>
To: hanhuihui <hanhuihui5@huawei.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: VRF Routing Rule Matching Issue: oif Rules Not Working After
 Commit 40867d74c374
Message-ID: <Z_OMzrUFJawqfYe5@shredder>
References: <ec671c4f821a4d63904d0da15d604b75@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec671c4f821a4d63904d0da15d604b75@huawei.com>

On Thu, Apr 03, 2025 at 01:58:46AM +0000, hanhuihui wrote:
> Dear Kernel Community and Network Maintainers,
> I am analyzing the issue, and I am very happy for any replies.
> After the application committed 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices"), we noticed an unexpected change in VRF routing rule matching behavior. We hereby submit a problem report to confirm whether this is the expected behavior.
> 
> Problem Description:
> When interfaces bound to multiple VRFs share the same IP address, the OIF (output interface) routing rule is no longer matched after being committed. As a result, traffic incorrectly matches the low-priority rule.
> Here are our configuration steps:
> ip address add 11.47.3.130/16 dev enp4s0
> ip address add 11.47.3.130/16 dev enp5s0
> 
> ip link add name vrf-srv-1 type vrf table 10
> ip link set dev vrf-srv-1 up
> ip link set dev enp4s0 master vrf-srv-1
> 
> ip link add name vrf-srv type vrf table 20
> ip link set dev vrf-srv up
> ip link set dev enp5s0 master vrf-srv
> 
> ip rule add from 11.47.3.130 oif vrf-srv-1 table 10 prio 0
> ip rule add from 11.47.3.130 iif vrf-srv-1 table 10 prio 0
> ip rule add from 11.47.3.130 table 20 prio 997
> 
> 
> In this configuration, when the following commands are executed:
> ip vrf exec vrf-srv-1 ping "11.47.9.250" -I 11.47.3.130
> Expected behavior: The traffic should match the oif vrf-srv-1 rule of prio 0. Table 10 is used.
> Actual behavior: The traffic skips the oif rule and matches the default rule of prio 997 (Table 20), causing the ping to fail.
> 
> Is this the expected behavior?
> The submission description mentions "avoid oif reset of port devices". Does this change the matching logic of oif in VRF scenarios?
> If this change is intentional, how should the VRF configuration be adjusted to ensure that oif rules are matched first? Is it necessary to introduce a new mechanism?

Can you try replacing the first two rules with:

ip rule add from 11.47.3.130 l3mdev prio 0

And see if it helps?

It's not exactly equivalent to your two rules, but it says "if source
address is 11.47.3.130 and flow is associated with a L3 master device,
then direct the FIB lookup to the table associated with the L3 master
device"

The commit you referenced added the index of the L3 master device to the
flow structure, but I don't believe we have an explicit way to match on
it using FIB rules. It would be useful to add a new keyword (e.g.,
l3mdevif) and then your rules can become:

ip rule add from 11.47.3.130 l3mdevif vrf-srv-1 table 10 prio 0
ip rule add from 11.47.3.130 table 20 prio 997

But it requires kernel changes.

