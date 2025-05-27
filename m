Return-Path: <netdev+bounces-193740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983ADAC5A8D
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318F68A6399
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D92868A6;
	Tue, 27 May 2025 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="e0mYc2QI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D9qqSx+z"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34B28642A
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748373473; cv=none; b=J2haQuOYOzAErfsUrGLBdWlwfAYB/USnH47kNYaUJpTEi65J9FcfvmSzC4Qzozy0vMVOfTq5UYQIhuZBvrRRztXPgz65xZf/kL8MvLbhUQfw4M+stytrZc7n8mrEMdkt8L1hlUUm5H12W3naUTmb3HVFiro2EBbFOMrIcG5bvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748373473; c=relaxed/simple;
	bh=25tpI+G7zxaVDqba9mEfmGiDjXFbaC+SAXmjbdkpyoM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=D0l7/zU/OIiq+8Il/ZlRL3V3ip+EV+c3GQc3ZPm4InZTqIKKa3RwqwmARwzXT5mdAQuuyEKZB0Z0ekIKlC754AS0epNiCQq2LGxlhjhG0ijNnqFCbwo+vlJcDFqvfPW/PXk2TQFA1IKibEAlV3x72mo1tIsqj4pl7Khy9qz05PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=e0mYc2QI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D9qqSx+z; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D9AC114017A;
	Tue, 27 May 2025 15:17:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 27 May 2025 15:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748373470;
	 x=1748459870; bh=6FUP4OVzop2Z24pkmfHjCKQpouz2rCJPZ5qqu5FDfOo=; b=
	e0mYc2QI78buxOj8HWdF74s2oCMTsBUWwPqS5FcBfIEUVD5SfP12t2TWJk3cAwoW
	La+U7nP+88m0ULS9MJyTIjUu0tLKi3AN0NAu4+/aL8G2NACAka/hGQd8BMOpPQRC
	GO6dBa67DO/I0wSZHMKXXtyGnARJ16zENh6GwQmqW/Y9Ysq1tnpfh291jq1GVdZd
	zZy7VCqoGxpEvOyofR/vzfWib+v4sldQBymYa8L5yBxgjQb8bY1giFYlrnYptNYc
	EDR+OoJR8bvhh3Mgz2pZGNj1JSd9k9augrBLDI+bOf4J2GKw/a118T3T4mymwOIr
	6/53QT5RCmhCNERpsUs6Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748373470; x=
	1748459870; bh=6FUP4OVzop2Z24pkmfHjCKQpouz2rCJPZ5qqu5FDfOo=; b=D
	9qqSx+zms4Ad2Vx5OWrwhwo0tXvhgfs1K4WBvjf76rlqtY5C6DTcyioYnvcTCjXo
	XoHqL7eXJcSG6YphSGzGHKN8QjNiKxvfvL6oFqUIA3CN1aH7jdELMo3rkB1BEmo+
	xf+prSYECXO5bXIJd6C/RBhuqk3SvnQibx4bcaoT4eVC8dOpaVwlzBxeEPCaTJLK
	VpROGM/SK+TeqD/xa37aoYoJBCIy43eAIDSqksTjw2PsZsDBNUZq93E2sBzWDruK
	qv9ImEE4Ip7AQ9jbEceBfHLknyr9IXurE+5rjXtR+fatc9LAcKDSHDBIFkqxIPZc
	/HElwMr/UNMMbCUFaUqlQ==
X-ME-Sender: <xms:3g82aKY3qDDO0fIFTO-x9kNWIg8T8i1-YXLruRCwhy2fTOlGIrvB-A>
    <xme:3g82aNbxnGJibaR_aM2nylmjr7JlCcNM8ufKwJEr89HegH-RANozH3aAdcLQO8pSF
    4_VHLWmR9DT4VLBr8A>
X-ME-Received: <xmr:3g82aE-UwXqvsROZUmUgzlwGTRwfFcbo44VzTvRbnJRC7Opd2uA_DFllKXY8qWwsImWICB0aW0IBRfd1tOeQSporp8gFejfwl3OJGWdXjr3T_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvuddvtdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfuhfgjffev
    gffkfhfvofesthejmhdthhdtvdenucfhrhhomheptfhitggrrhguuceuvghjrghrrghnoh
    cuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnhepvdev
    vdehffehleelgfejhfeitdelfeeuvddttdfgiefgvedtgffgkeejgeffffetnecuvehluh
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
X-ME-Proxy: <xmx:3g82aMqLYq8YuqD2dKZCv9hZ_5letzxlheDQKGFViHom0RYGSRl05g>
    <xmx:3g82aFrFCH1K3xMekb_8H5qR28L_HkYwOWyx0V60ywAHGp9mu9einQ>
    <xmx:3g82aKR_6ZlTvf41VSfCKU1OVu8qw8L57H4Nm1V8nldi4LJhnta2yg>
    <xmx:3g82aFpC5qZZu12iYZZms_r43xtMjEWU9BjYBz6bIbqKC0cdhgS2IQ>
    <xmx:3g82aJz_Suv9nxQ-YHsXSWDriN0q5uPz_8I0k-w2Cezet5IsDlarjMNz>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 15:17:48 -0400 (EDT)
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
In-Reply-To: <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
Date: Tue, 27 May 2025 21:17:47 +0200
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: 7bit
Message-Id: <AB7F8F0D-7D56-4CF9-BCE9-690A61EDED74@bejarano.io>
References: <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
 <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
 <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
 <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
 <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
 <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
 <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

> So, another idea, just to see if skb with frags are an
> issue. Somewhere need the beginning of tbnet_start_xmit() add:
> 
>   if (skb_is_nonlinear(skb))
>     skb = skb_linearize(skb);
> 
> That should convert an skb with fragments to a skb without
> fragments. It will be bad for performance, so if it does work it is
> not a fix, but it will confirm we are in the right area.

That would be on the tx side, right? On red, not blue.

RB

