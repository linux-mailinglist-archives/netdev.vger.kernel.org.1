Return-Path: <netdev+bounces-180460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1673A81618
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8543A1BA7B48
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A32500C5;
	Tue,  8 Apr 2025 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VEfVeKuN"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7656253B72
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142079; cv=none; b=aUljAhQR7SwcvkbXvqEBVcdD258GLbbYRckAnqGYYZmgByMEJOufDh60g5k/dBzePwatj2mMYT/ryQoYzaZMrBam8Sqej7zZf99rs2v3B7QMkKz2NX5KEK93XnxS9rB/5RB/ob/OSlLZfGQMBY/KagB/l8FFpDIio0CMAgbnUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142079; c=relaxed/simple;
	bh=t1XTG3RfzJWt6roSkFFyK9kUCPKqAOBN9uZVCwicFdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXzYkLq71sCRX4VVFlLtQtvQVoL7Oaacr7EVhFPM1SQDN/NdMJOl4BU0hchB0X3qT3IJBC3R5u/4QdDDy+/9dMlsMFRuvooRVGzeFX58mmp5Fd9uVsBnJLTMNP6lhhnCjrVB+9xl28hKV2gyWb7diag9MJf+VRk1wnkdDFA7LZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VEfVeKuN; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF0421140132;
	Tue,  8 Apr 2025 15:54:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 08 Apr 2025 15:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744142076; x=1744228476; bh=x/aVEEg5fuDPoQxP3+M+yzVZzNamqW860AZ
	cH6pmTao=; b=VEfVeKuNE2jSf/W7FLWnU/ZLriAg9Xid1/poth9FsPilhh3t0Ue
	6NSDMktfESHMJiif9KtjEBiEJ06554zOm9nRcUer8b/6r7RYYcNbwHQkJjkBowYT
	ALKqFf5gsqhrlkN89C0meotRi90aHcVwx3hovLskpdw0erWZUZ4i4vGOWxfohvkq
	B5zsldQq/2N+agZjtGg1rVEO0BZrknTdTsT9gyPs9ybsl/YnpXgA5P+cDi+JqTi8
	ftvEkKUQikt7n1tl6cZoaBRcOld0E20OpDWXAn0qSMcjiaAlPpIua1Abueb8oife
	HLKfYT0myMExlkdz+ulMM8mzQ34Ns7gDpSg==
X-ME-Sender: <xms:_H71Z9rPynWIzgzMBQbos1LzQI1iR6xXYHGhbz_jVtuD7ZqPZtrQxg>
    <xme:_H71Z_p3Bk8gfTpyP-QSyTd0_HxFiYGZ94bTcX9LJ4UzW1um8pPPOT-_83-GdQDqs
    S5clnM3zIfzvUA>
X-ME-Received: <xmr:_H71Z6MJZNMxF7UVfM6tz1oEmPnPtXPb1iqFsmzgbPxrhuykh0hgI7EOknRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdefleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgv
    lhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvud
    efveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesih
    guohhstghhrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehhrghnhhhuihhhuhhiheeshhhurgifvghirdgtohhmpdhrtghpthhtoh
    epughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:_H71Z474Z2PDx5LYKJoWUPTi7MtTPF5pHocH_Oic5NKnmF10RyaB9g>
    <xmx:_H71Z84swD_QiID01khpDu3rL-whdyAPi-Tfw1Zj2dPEvgjq-Xv4KA>
    <xmx:_H71ZwjE4j8XRQbVlWsPr5gqLbS5DQd1dPrDjhLi8A_7ZbpZHdcKrQ>
    <xmx:_H71Z-44qgl0Zyi4r1PrkaSH_DvgU1JEpHspdZBdB-aaCeTN0lguKA>
    <xmx:_H71Z8L01FmwJU-WxRDJJ-XMgFLJghm56xw__OeNsB6nF75mzWjo4SKz>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 15:54:35 -0400 (EDT)
Date: Tue, 8 Apr 2025 22:54:33 +0300
From: Ido Schimmel <idosch@idosch.org>
To: hanhuihui <hanhuihui5@huawei.com>
Cc: dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org
Subject: Re: VRF Routing Rule Matching Issue: oif Rules Not Working After
 Commit 40867d74c374
Message-ID: <Z_V--XONvQZaFCJ8@shredder>
References: <Z_OMzrUFJawqfYe5@shredder>
 <20250408161756.422830-1-hanhuihui5@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408161756.422830-1-hanhuihui5@huawei.com>

On Wed, Apr 09, 2025 at 12:17:56AM +0800, hanhuihui wrote:
> On Mon, 7 Apr 2025 11:29:02 +0300, Ido Schimmel wrote:
> >On Thu, Apr 03, 2025 at 01:58:46AM +0000, hanhuihui wrote:
> >> Dear Kernel Community and Network Maintainers,
> >> I am analyzing the issue, and I am very happy for any replies.
> >> After the application committed 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices"), we noticed an unexpected change in VRF routing rule matching behavior. We hereby submit a problem report to confirm whether this is the expected behavior.
> >> 
> >> Problem Description:
> >> When interfaces bound to multiple VRFs share the same IP address, the OIF (output interface) routing rule is no longer matched after being committed. As a result, traffic incorrectly matches the low-priority rule.
> >> Here are our configuration steps:
> >> ip address add 11.47.3.130/16 dev enp4s0
> >> ip address add 11.47.3.130/16 dev enp5s0
> >> 
> >> ip link add name vrf-srv-1 type vrf table 10
> >> ip link set dev vrf-srv-1 up
> >> ip link set dev enp4s0 master vrf-srv-1
> >> 
> >> ip link add name vrf-srv type vrf table 20
> >> ip link set dev vrf-srv up
> >> ip link set dev enp5s0 master vrf-srv
> >> 
> >> ip rule add from 11.47.3.130 oif vrf-srv-1 table 10 prio 0
> >> ip rule add from 11.47.3.130 iif vrf-srv-1 table 10 prio 0
> >> ip rule add from 11.47.3.130 table 20 prio 997
> >> 
> >> 
> >> In this configuration, when the following commands are executed:
> >> ip vrf exec vrf-srv-1 ping "11.47.9.250" -I 11.47.3.130
> >> Expected behavior: The traffic should match the oif vrf-srv-1 rule of prio 0. Table 10 is used.
> >> Actual behavior: The traffic skips the oif rule and matches the default rule of prio 997 (Table 20), causing the ping to fail.
> >> 
> >> Is this the expected behavior?
> >> The submission description mentions "avoid oif reset of port devices". Does this change the matching logic of oif in VRF scenarios?
> >> If this change is intentional, how should the VRF configuration be adjusted to ensure that oif rules are matched first? Is it necessary to introduce a new mechanism?
> >
> >Can you try replacing the first two rules with:
> >
> >ip rule add from 11.47.3.130 l3mdev prio 0
> >
> 
> This does not work in scenarios where the routing table specified by the oif/iif is not in the l3mdev-table.

You mean when "oif" / "iif" points to a VRF and "table" specifies a
table different than the one associated with the VRF? Then, yes, it
won't work, but in your example "vrf-srv-1" is associated with table
"10".

> 
> >And see if it helps?
> >
> >It's not exactly equivalent to your two rules, but it says "if source
> >address is 11.47.3.130 and flow is associated with a L3 master device,
> >then direct the FIB lookup to the table associated with the L3 master
> >device"
> >
> >The commit you referenced added the index of the L3 master device to the
> >flow structure, but I don't believe we have an explicit way to match on
> >it using FIB rules. It would be useful to add a new keyword (e.g.,
> >l3mdevif) and then your rules can become:
> >
> >ip rule add from 11.47.3.130 l3mdevif vrf-srv-1 table 10 prio 0
> >ip rule add from 11.47.3.130 table 20 prio 997
> >
> >But it requires kernel changes.
> 
> Before the patch is installed, oif/iif rules can be configured for traffic from the VRF and traffic can be forwarded normally. 
> However, in this patch, traffic from the VRF resets fl->flowi_oif in l3mdev_update_flow. As a result, the 'rule->oifindex != fl->flowi_oif' 
> condition in fib_rule_match cannot be met, the oif rule cannot be matched. The patch also mentions "oif set to L3mdev directs lookup to its table; 
> reset to avoid oif match in fib_lookup" in the modification, which seems to be intentional. I'm rather confused about this. Does the modification 
> ignore the scenario where the oif/iif rule is configured on the VRF, or is the usage of the oif/iif rule no longer supported by the community after 
> the patch is installed, or is the usage of the oif/iif rule incorrectly used?
> Any reply would be greatly appreciated.

Before 40867d74c374 you couldn't match with FIB rules on oif/iif being a
VRF slave because these fields in the flow structure were reset to the
index of the VRF device in l3mdev_update_flow().

I will try to check if we can interpret FIB rules with "oif" / "iif"
pointing to a VRF as matching on "fl->flowi_l3mdev" rather than
"fl->flowi_oif" / "fl->flowi_iif".

