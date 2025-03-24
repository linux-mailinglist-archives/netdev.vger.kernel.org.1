Return-Path: <netdev+bounces-177041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B313A6D78A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829DF16CA63
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8790A25DAE0;
	Mon, 24 Mar 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ktuWKOXE"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C251C6FF9
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808911; cv=none; b=c3EozUp1Bk5Mk+3whIjr6UEdEQKmq/Lk15KzZYFZvqNXCMOoXmgfyyhEmXNpkv84LsM9v1bQGP9J0LJHCZOjKhqfYJ7rzKozBY/bK25qnd/5+p3CtF/yZVvdvxtURzSZawVdZgujcNJpMfr4MWg7JaGYCwaFTzGgsWyw6t/h0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808911; c=relaxed/simple;
	bh=jSU19BeucDcYo3HzTNNxDytTn9Z32hX9nE3otE+Fgxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYqOvRxg+DyxDQNvV9aOJiwqr1RO5BZqfUNWMwSbBZjYdDSc1P3mDntpresAG32kEiXUXOc0mx4CNxRIlWgC3Wn0iJatrze41a4Ze1V6f8x0FEmyEA31j7ClKVShoal363FbclzEnNCNocPezcfXThjI25rbj76MX1PjZ5yXe0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ktuWKOXE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40CF811400FB;
	Mon, 24 Mar 2025 05:35:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 24 Mar 2025 05:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742808908; x=1742895308; bh=a5TN8a4rNTRr80PY8zrG1BOD1E35FSGN3v+
	EJlyPxI0=; b=ktuWKOXEGlZA3zm/lEeiVFrEX7QAfWJxj+q7zpy0yOwVL8bCWkD
	VWelUJ5OHxA4C0CsdSxpWtRKKblKeA63+Gyp8L4ZARbso50oe8WWWOr6X9V4hOk2
	Pztc4JTcnFO4iffl1icOpCqVmeQ12KhelP+nVufiZoc14soxlT7etCNYvBXOFTDm
	9Y9acY37nGPQ2t8+HYGdyMw0eyrqtX3g4Jr+ID0WqmoI4ijiR3TXR9gSSGsBuXFN
	EQDT+yWjQdLa588cuO39f0Zi0ovietP2yPa8k10nh0cU1FO1d9iMCCF/nCPlEMjn
	pAtXhCvZxm4JjrBiWVhp6EjE1W2AV7DEp1g==
X-ME-Sender: <xms:TCfhZ7qnegB5xzLWngwI89cOkYlw1XPWurm4urJM_kZO89XeJeQ3NA>
    <xme:TCfhZ1qiWJpm0RWLQXQQKZh-GcBDYxPKpC6VOnV-99cLtuuUKn_Egl8M1PvdQoO2H
    OOsqbr7ouqVH50>
X-ME-Received: <xmr:TCfhZ4NU8gd_BEV-HN4kdOvvB7qI-caSb77vVp_st9MEI1QrvRIBzGPvBnSe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifedu
    ieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhnihihuhesrg
    hmrgiiohhnrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhope
    gvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhiudek
    gedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:TCfhZ-4Zw-E6HqZl4O1yDazswjsK07qaSSeM8aCC_X4VHy1LV9KGpQ>
    <xmx:TCfhZ66iCfFKShisBZuAwR42Jfwkwo5Yl4JD842QI7W0NYyreD2aZw>
    <xmx:TCfhZ2g0kaaV49pvNDUM32gGTU8IlPpwDK2QXdK6yDTABgZF9L0c6A>
    <xmx:TCfhZ85RZlP2bHZtl5Gg-bbxCXwgzyU7UcrjWVes5TrWh1WsjyfsoA>
    <xmx:TCfhZzGSqvWIC3N8zqVaBqSn2WNv_TcDdKPFbzgr76Xn1-Rulz_TTlFv>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 05:35:07 -0400 (EDT)
Date: Mon, 24 Mar 2025 11:35:04 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	petrm@nvidia.com
Subject: Re: [PATCH v2 net-next 0/7] nexthop: Convert RTM_{NEW,DEL}NEXTHOP to
 per-netns RTNL.
Message-ID: <Z-EnSBUR8IM70wmg@shredder>
References: <20250319230743.65267-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319230743.65267-1-kuniyu@amazon.com>

On Wed, Mar 19, 2025 at 04:06:45PM -0700, Kuniyuki Iwashima wrote:
> Patch 1 - 5 move some validation for RTM_NEWNEXTHOP so that it can be
> called without RTNL.
> 
> Patch 6 & 7 converts RTM_NEWNEXTHOP and RTM_DELNEXTHOP to per-netns RTNL.
> 
> Note that RTM_GETNEXTHOP and RTM_GETNEXTHOPBUCKET are not touched in
> this series.
> 
> rtm_get_nexthop() can be easily converted to RCU, but rtm_dump_nexthop()
> needs more work due to the left-to-right rbtree walk, which looks prone
> to node deletion and tree rotation without a retry mechanism.

Thanks for the series, looks good, but note that dump/get can block when
fetching hardware statistics:

rtm_get_nexthop
    nh_fill_node
        nla_put_nh_group
	    nla_put_nh_group_stats
	        nh_grp_hw_stats_update
		    blocking_notifier_call_chain

