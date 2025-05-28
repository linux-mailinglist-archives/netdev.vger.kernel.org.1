Return-Path: <netdev+bounces-193877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B75AC6214
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410091BC252B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 06:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E814243378;
	Wed, 28 May 2025 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="mbT4iY58";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cfe8hJUW"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE91C8616
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414317; cv=none; b=oq+EMsUTOoiJiHrkv3GdR1q0w4378VtJpBzLwdX81LN63PjVn0DY/5ZBudRaFt52+Tk7azTbaBxED+mbykKVU8ecHpGZU/bg5jaVb7clxMnPkygAqMOTounNyJDB5v1pgVFDILU45deGK+udmNBJ/yPgyQqIkOBG6Wl0Zr06EZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414317; c=relaxed/simple;
	bh=2EK7pEWD7LcOXhaxDrXIhJsCO5dW/c6KOUeCW0JGUt4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RlLqZP9Vnk/yhIcB9zt6IBl8cIE/6JVBlfwyF9QP6k9c4R4n0/PJhCw8b0tXIm7QbpMXQ9K2GBRUDvoG+6gqLHDRcY1ecqf+2qjYyWtfRLLIs05UtjGigR2s/6+mMIhTPMBPFit+2Q9zEZTZtgCdQyjWts3pQWEYdNOD07NPYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=mbT4iY58; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cfe8hJUW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16F43114014F;
	Wed, 28 May 2025 02:38:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 28 May 2025 02:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748414314;
	 x=1748500714; bh=2EK7pEWD7LcOXhaxDrXIhJsCO5dW/c6KOUeCW0JGUt4=; b=
	mbT4iY58jiMU00AV9OqDt6CHvdeuKxpUYQMA0KGc2XgU5CYVMR22F9pALvwrV3x/
	nUHDHWCyJwBQ+KfKHOTugv2TOqIeu18hvlTbEYEVCXhcDvfNzXjYKARNqMImipS0
	JIqurohLYq8g9j3LWHShKTrL/l8KC/u6iL/L36VCcfRjfWLLfKyPS18bTs+FVlfq
	zFYvluEPlxun3MdrHuHZwIIiRm8Cs93y6WA7JAAb6E5uiggzLQafbY4WvEPzdBKH
	sox/nqyQ018VIS+j/dg5nsavESsI/yHqq5VtfjxWrRvUBiQb8ViLBDDxIjmDNq4B
	plE2p+8RZYYQ0STNREAJMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748414314; x=
	1748500714; bh=2EK7pEWD7LcOXhaxDrXIhJsCO5dW/c6KOUeCW0JGUt4=; b=C
	fe8hJUWGpmLaP1vCqMlfBc7ebzibcRYe3awuDMuYBlGrDOrfmblSEKpFzfpG/2Y9
	R4w+UwLLZM95pPYeYs2a8IBHZaYfRlKleZUqBOGs0bEO3NoL0XFE6llgqd6jspjT
	/Z01rbeFrkfCjOXx1Ss3saomRjbBX+AuD882fFL7mztLex3lt+feuS+/JqBhTpWR
	QytXR1gl/0BIByQsXnPJAc7C7BtupmUy+Lyj6lY4rOg2M6vgswNhpKopDLtHHp7H
	bLzr/wLgUrstHbQkTCfhwWgNmUvF1GfIiVcerqa62nc8J3j1gpOQG08NcvGH+pOH
	Zd1mTSf2c3Z9yapd/PoMQ==
X-ME-Sender: <xms:aa82aFDFHkcFlCLU0woYEkcd40XM_y25J65he_9Gqiw81CnSFd7yjA>
    <xme:aa82aDj_FXs3QJiWbFupLvTu-Hc42X1mPIs0-3QVSEoMgRsXF4i39kQ5RLgJKidh8
    XrRIJy2B7V0l3qoP48>
X-ME-Received: <xmr:aa82aAlTqvoG4eZEKr_j_Y9_UNzzft8ZTkQ4L8ZTKk0TfghXYTnttnSFE3pvLnn3rBnnb0J8CQuAJ2hzaoXT38Le2II-97J8Rhtx8uMmF0sabg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdehjeculddtuddrgeefvddrtd
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
X-ME-Proxy: <xmx:aa82aPzcTmBcvIYRw0QxQ9FH51SFmAbd1slBq9Y2XSVoIoPJbjKJzQ>
    <xmx:aa82aKRDsli134eOZCvmMZ1f-HGaZhDFQJiw_SC-CGN0tIi159j1JQ>
    <xmx:aa82aCbBwgCmru7oFiu9p_unxTPgtq9hCi_0tkX_FZpTNK4raD7l4g>
    <xmx:aa82aLTyGcI_lG7t52-j_x4vhVlnlovekphGxuBAM1Akhk5d6HJbig>
    <xmx:aq82aMa_JOQ-pPeCTyZ_vA4_rJVnBt1BqbOcYbb2QPW5C_p2Cb0yJmHp>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 02:38:31 -0400 (EDT)
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
In-Reply-To: <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
Date: Wed, 28 May 2025 08:38:29 +0200
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
Message-Id: <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>
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
 <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

This impacts performance so much that I can't even test it.

iperf3 doesn't even start and ping shows >1s latency:

root@red:~# ping 10.0.0.2
PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=1041 ms
64 bytes from 10.0.0.2: icmp_seq=2 ttl=64 time=1024 ms
64 bytes from 10.0.0.2: icmp_seq=3 ttl=64 time=1025 ms

I'm looking where else we can put this that's not as intrusive.

Thanks,
RB

