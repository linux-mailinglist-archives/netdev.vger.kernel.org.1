Return-Path: <netdev+bounces-194182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416DBAC7B8F
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 12:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5603BF0BB
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 10:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9692192FC;
	Thu, 29 May 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="Vy/UBudZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpXCFFNd"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313FC126BFA
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748513213; cv=none; b=AvCTIDsjiVazGSlc2LIfUJPKJ3gBPA9UX2QLgIjgTznO9ho2+xCl0ncuYE4RBNJd3Ri+61xQXcJSkql7vdt2gJL6ghkcl6oUXKpy1ZtlKg9IoiSChNCJMqQlwChTcoAf5Oi9LRK+l/X5a5M3PwC7N+SgINb5Iwomab5YsZxpttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748513213; c=relaxed/simple;
	bh=0G/ILYB2PqMFDGErO2U9mjJXhAorxEsFDGkVKcaJvJ8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q8PF39kXkjmBKdkLxb1x6H2u/LgAuQHC/lCbOoyPvhPUqOotQ4ZjNd9lSGVF5wWbeACHdL35UimbPwnnh5uQADKbGrffpXafzoX/eOj6oAN+jVSwftfSfThdNc9HswHp4hdVVmxilJ1FgscTwY9HeKlPtsfikIQW6qU2T6MFDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=Vy/UBudZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpXCFFNd; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D2F712540123;
	Thu, 29 May 2025 06:06:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 May 2025 06:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748513209;
	 x=1748599609; bh=NkIXmjzuG7XBINeCIJ1Liayu2reOgNOH0xcQA7X0zbk=; b=
	Vy/UBudZWyc6c7E5/IiWs2/8LblKg03se0xQyE9pmRsTv0ftloA42Olll7HB/LhG
	rtyq7tsG/K28zCCdb26cmqBfz/GqB+xwJ4EF1ROParzP95uOdBSuymmqXs/Fki4n
	lKW/2zKwowJAMKRPt8HzQqv0uo2dXi+m0BlPUE+QSRlzI44MmEf3QoXp/sJe6flR
	QCx2sT6qATtC+StZ73POsGEsSdo3/FDFQrnDFO6PcdQM0T9s1nUaGyTjKt+eA1EN
	uGv+D2PIkQ4KiTRBHMUzzYhbamAOW94mVuM80Uek91PycnKcwfVZOosrN+qU2dJ3
	8DA5uoD7rEJRVjUbQO0OFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748513209; x=
	1748599609; bh=NkIXmjzuG7XBINeCIJ1Liayu2reOgNOH0xcQA7X0zbk=; b=N
	pXCFFNdQgAqwo8rPNqK79G9AkkmXwB7T7cB0APOcArUdbclygqjQPO9t0ZuuZTKZ
	/rZCJclqo1CwX/bXsXL+KjwIq2qAodRD9MkfYIelLe0cYxTEEoAZZmzzyA9N+RPn
	SobXYtF8ZKRP4NUf9uFqmTy6H2zN73oQ1Dw4riebUFjsaTck+ZRcBft+cIgi2sl0
	paxUm71rv3BQLnHOBn3S8dipc93YI6tUl7Fu3JkbDsGWXQW3DbB4xhlXBnntZd1A
	9m1OJiaWFvW1m0Mj43V6bo7jMFtWEdug41Xm3nJneX0Py66Bm3DdpKbNlVDvnp5K
	TtM0sZ6i4KTOsFLnBlpsw==
X-ME-Sender: <xms:uTE4aKUoq3xNz4s9HIweJWmP_yTQRRS1LeHJAgZQgvZdk_y1kkVxHw>
    <xme:uTE4aGmodrGgP3Jg4Vf9qMGK2ZnRTPP803FxWo8XmWI54b5UaJsDfQ8n5H8PDvqg3
    cY9mc2o-Tuzf1AnD7w>
X-ME-Received: <xmr:uTE4aOZiAHFFcYzUhiVHJXByHycZSIz71Q-ToJEPZ_ZCv1aiE7OEfwohWBCgGg9vWjzLHRLEYp4Wkk0Das6gOs81-aSBJhvEHWxyLUckp6cI3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvheekheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfuhfgjffev
    gffkfhfvofesthhqmhdthhdtvdenucfhrhhomheptfhitggrrhguuceuvghjrghrrghnoh
    cuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnheptefh
    leekteffhedtgeekudeivefhgfevtedvgedtjefhffejteelgeethfevhfdunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhitggrrhgusegs
    vghjrghrrghnohdrihhopdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepmhhikhgr
    rdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgr
    vghlrdhjrghmvghtsehinhhtvghlrdgtohhmpdhrtghpthhtohephigvhhgviihkvghlsh
    hhsgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehl
    uhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprh
    gtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uTE4aBUs8FoZpKaMf-C4eUJNAG8Y2yq5SbprcdeufzDy6NRq5NG0OA>
    <xmx:uTE4aElnfZWPfXNmQMEbCg557y5bKcCa274LXyXOX4xRlbvVwSruSg>
    <xmx:uTE4aGcsY1edgPgv8xk63s_hPo1AkfVBv3e5hvLlj5Rm9yiYDn8FRA>
    <xmx:uTE4aGEDsALlSRckp_PkHmX4yl609HzS5BvZKgB4QtOTGmNq2SO-dA>
    <xmx:uTE4aFvcg-E8MS6Pw-g7N_-LDIwBVo_8HVFXHWwZzt8Y_dGoWocRTrGW>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 06:06:47 -0400 (EDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Poor thunderbolt-net interface performance when bridged
From: Ricard Bejarano <ricard@bejarano.io>
In-Reply-To: <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
Date: Thu, 29 May 2025 12:06:45 +0200
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <48EE4097-8685-47D1-8C20-EE18A147A020@bejarano.io>
References: <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
 <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
 <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
 <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
 <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
 <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
 <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
 <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>
 <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

So here's what I've observed about tbnet_xmit_csum_and_map after =
sprinkling
counters all over it and running various tests:

1. skb->ip_summed is never !=3D CHECKSUM_PARTIAL, so we never execute =
L1004-L1014.

2. protocol is always =3D=3D htons(ETH_P_IP), so we:
     2.1. Never execute L1021-L1027.
     2.2. Always execute L1036-L1051. And specifically, we execute L1045 =
N+1
          times per iperf3 test (where N is the total packets sent as =
reported
          by iperf3), meaning those are ip_hdr(skb)->protocol =3D=3D =
IPPROTO_UDP;
          and L1043 a total of 14 times (2 times 7, interesting), =
meaning those
          are ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP. =46rom other =
iperf3 UDP test
          packet captures I'm confident these 14 TCP packets are iperf3 =
control
          plane things, like the cookie, a couple JSONs with test =
metadata, etc.
     2.3. Never execute L1052-L1064.

3. Once again, both lossless and lossy tests share the same execution =
pattern.
   There's not a single logic branch of tbnet_xmit_csum_and_map that is =
only
   executed when there's loss.

It's interesting, however, that the number of TCP packets is exactly =
twice that
of the number of non-linear sk_buffs we saw in tbnet_start_xmit. Not =
that it's
suspicious, if anything (and because we see those TCP packets in blue) =
it tells
us that the handling of non-linear skbs is not the problem in =
tbnet_start_xmit.
But why twice? Or is this a red herring?


I'm running out of ideas, tbnet_xmit_csum_and_map looks good to me, and =
so do
tbnet_kmap_frag and tbnet_start_xmit. I'm going to explore a bit of the =
Rx side
instead.

Any suggestions?

Thanks,
RB


