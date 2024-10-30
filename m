Return-Path: <netdev+bounces-140511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683709B6ABC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D166282BFC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CB221B44B;
	Wed, 30 Oct 2024 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UBnTduMG"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0992219CBE
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308319; cv=none; b=tg9cYNFdsumH7y54meYSL5GABOw2dM8PgNlpYa0EnmxN94WKRLZK67qsZflRy/CIv4G3Zfssq8YCkDhvc1+iYyTucpu3FpbocJsh67nnlTFPZ3Bkaz1A1opciOwaWgnvLt3zJ8L7ZWil8eb5aYDvXizOq+ZsBsVCnfnt2FBqueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308319; c=relaxed/simple;
	bh=pA2V7PdpOBC6l12MBWBFMseAks1YG0XdXba9jmONdd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m780kRNUEMjSKw4JtQqKkT1m9ed6GC+63WISi/UWOuBynfl+gq0+MB9cQ8DjUYPa8xjeNqFbddoZCEk8bTfV9A8g/e6IB57NLx59wlm2CtP6MLOnN1BLr5koXpCcdEocLYOIQI8QYOClHnXlGka7cn3Qg2T3XCRzweUqzUVcLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UBnTduMG; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CBB9A1140142;
	Wed, 30 Oct 2024 13:11:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 30 Oct 2024 13:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730308315; x=1730394715; bh=3jFAWeuYBAaw6UhjVx0Jv7AwBsnl1vmFLru
	nIUgu+Ik=; b=UBnTduMGHUKSNIPGpMDaGOS3T9iN0T1QOrOFbCz+8GBBp9Q31S1
	QeudNj7dyYO+SoejnUdLk/21fTnPUXmT93OlT+opef8FlKwW1tErKJpW6BI4jQPc
	t80gQbApTgH2WcmLWk8NtzQNErDkjpsJFn0hZ1nzx0rmgR1LEcpoS1l662PXSBQ3
	tnJJXa1p5r4SC8oPPkj6sgmGXyWxEjskm6ryxKvJshk/Nes88Xo6n57WDB+ZZ9xR
	2FaORPFpU+o0yc9CLRtAA29Ex262r/YidnJ0wuCUT//TsA5jpUCCIF0sq6koEzsF
	eZt4uKnwmx1mqKS0FpiV3RZDiMdX00L4PKA==
X-ME-Sender: <xms:2mgiZ3cKqVaOc33GKin-Ug4OKrysLGXKBQpogRXBhHSAGYQnog0iHQ>
    <xme:2mgiZ9N6CuUiNTXVw5Ksfez77MxkVnzAQER0J8lSWQ28gOWeQkP8ck4pPH1qzRVhi
    ailcN6Clppky7g>
X-ME-Received: <xmr:2mgiZwg2tBtedUYklgW9EvhdzJZnRG8KuTJbs8fXJIaAFVf7uRp1wxxKgi0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughsrghhvghrnheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepuggvlhhirhgrnhesvhgvrhguihgtthdrghhgpdhr
    tghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
X-ME-Proxy: <xmx:2mgiZ4-dibhyxZ_A1UvVsbrKqsAuam4gB96A5m8VoRj8mbpLnlJW-Q>
    <xmx:2mgiZztUPrThHn6PH2FYtbXT3vS-jOXBCNF4NeO-e2sy5suuGvMesA>
    <xmx:2mgiZ3F7gQ9zKDLBEXX4A2-R73JyM6zsM9f4CZwLN1D5bgssNmkrrg>
    <xmx:2mgiZ6Om0ivfOzY8Db1U6ZfzLBU9R_OB8vvjZ32Q7bQ0keh8_vGgyA>
    <xmx:22giZzJ-WVdHN5HpwTINAyrHFZOw6HxbZ6lY5xvdKyL2eBBzziZnoplZ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 13:11:54 -0400 (EDT)
Date: Wed, 30 Oct 2024 19:11:51 +0200
From: Ido Schimmel <idosch@idosch.org>
To: David Ahern <dsahern@kernel.org>
Cc: Vladimir Vdovin <deliran@verdict.gg>, netdev@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH] net: ipv4: Cache pmtu for all packet paths if multipath
 enabled
Message-ID: <ZyJo1561ADF_e2GO@shredder.mtl.com>
References: <20241029152206.303004-1-deliran@verdict.gg>
 <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>

On Tue, Oct 29, 2024 at 05:22:23PM -0600, David Ahern wrote:
> On 10/29/24 9:21 AM, Vladimir Vdovin wrote:
> > Check number of paths by fib_info_num_path(),
> > and update_or_create_fnhe() for every path.
> > Problem is that pmtu is cached only for the oif
> > that has received icmp message "need to frag",
> > other oifs will still try to use "default" iface mtu.
> > 
> > An example topology showing the problem:
> > 
> >                     |  host1
> >                 +---------+
> >                 |  dummy0 | 10.179.20.18/32  mtu9000
> >                 +---------+
> >         +-----------+----------------+
> >     +---------+                     +---------+
> >     | ens17f0 |  10.179.2.141/31    | ens17f1 |  10.179.2.13/31
> >     +---------+                     +---------+
> >         |    (all here have mtu 9000)    |
> >     +------+                         +------+
> >     | ro1  |  10.179.2.140/31        | ro2  |  10.179.2.12/31
> >     +------+                         +------+
> >         |                                |
> > ---------+------------+-------------------+------
> >                         |
> >                     +-----+
> >                     | ro3 | 10.10.10.10  mtu1500
> >                     +-----+
> >                         |
> >     ========================================
> >                 some networks
> >     ========================================
> >                         |
> >                     +-----+
> >                     | eth0| 10.10.30.30  mtu9000
> >                     +-----+
> >                         |  host2
> > 
> > host1 have enabled multipath and
> > sysctl net.ipv4.fib_multipath_hash_policy = 1:
> > 
> > default proto static src 10.179.20.18
> >         nexthop via 10.179.2.12 dev ens17f1 weight 1
> >         nexthop via 10.179.2.140 dev ens17f0 weight 1
> > 
> > When host1 tries to do pmtud from 10.179.20.18/32 to host2,
> > host1 receives at ens17f1 iface an icmp packet from ro3 that ro3 mtu=1500.
> > And host1 caches it in nexthop exceptions cache.
> > 
> > Problem is that it is cached only for the iface that has received icmp,
> > and there is no way that ro3 will send icmp msg to host1 via another path.
> > 
> > Host1 now have this routes to host2:
> > 
> > ip r g 10.10.30.30 sport 30000 dport 443
> > 10.10.30.30 via 10.179.2.12 dev ens17f1 src 10.179.20.18 uid 0
> >     cache expires 521sec mtu 1500
> > 
> > ip r g 10.10.30.30 sport 30033 dport 443
> > 10.10.30.30 via 10.179.2.140 dev ens17f0 src 10.179.20.18 uid 0
> >     cache
> > 
> 
> well known problem, and years ago I meant to send a similar patch.

Doesn't IPv6 suffer from a similar problem?

> 
> Can you add a test case under selftests; you will see many pmtu,
> redirect and multipath tests.
> 
> > So when host1 tries again to reach host2 with mtu>1500,
> > if packet flow is lucky enough to be hashed with oif=ens17f1 its ok,
> > if oif=ens17f0 it blackholes and still gets icmp msgs from ro3 to ens17f1,
> > until lucky day when ro3 will send it through another flow to ens17f0.
> > 
> > Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>

Thanks for the detailed commit message

