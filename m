Return-Path: <netdev+bounces-193476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FDDAC42C8
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 18:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364D3177063
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A846A2147FB;
	Mon, 26 May 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="rFoDf7iY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c1GdfdU5"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A41474CC
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748275852; cv=none; b=Bj1w/HycUP+nlrQUjQXZveZ4T/3hYiYX0oWK2t8RIC2x/CFhzaV0vvXg3rM+yjhsRc3phZPdvgLOkXXe6aWF5UV8wxx73iypuz8A86USyR/Um3EQJT7bsEjOwUghXIl2CchxsSGvGyk/8rruWVis7GSxFcP3AJPnpFuV4Q2wDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748275852; c=relaxed/simple;
	bh=9BpwBPirthPntr6DI9GoR8/FDU4LiMuOjD5U+ORmvmM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fHD9q3oI1LYX1n9yyLfp0mxDIU3k9CBekPQfjtfwXu0Efwxe0IYnAsLy51xrbtGO4PBNrC571QDhwQWGfm+eGaAzHPT2oUSRbIN+bnKn4CT6pqzpCs6lsY25VoZ++tAcRktnP/tJTI09NKbgDvafmay/U+TUipt6yNHHfvZFQLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=rFoDf7iY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c1GdfdU5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D472C1140189;
	Mon, 26 May 2025 12:10:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 26 May 2025 12:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748275848;
	 x=1748362248; bh=9BpwBPirthPntr6DI9GoR8/FDU4LiMuOjD5U+ORmvmM=; b=
	rFoDf7iYudPhc11no8IyALdfqnGUqhSJ8zE3R4vZxDZvaFRR58Aam7y6JUbtrfbM
	3nsYUDbsWUAQFoxk1pOOTqWzMnAQi0aT9+a6QPL6nkTnmi6klTZyiKaNUE2humrn
	LlzePXIPL4iQtND6OLH08BdDN7g8Tyg6edT5gHqI9HxAb2DfwUQLWEOJsSu29lv+
	2daaJnRITx67zWEqjVEh1QRxHJefSIJRop7FgTXzSkJPLYVa2+HwQPeaS4VZFnp3
	7YHNEYo/WA/ISgOaR+KGfBZuqI4uYhHnH9+6YjWqH8Uf5UqH/qXpsEpQmzk+X8Xm
	HMdl8ojSdJScrmouadQP1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748275848; x=
	1748362248; bh=9BpwBPirthPntr6DI9GoR8/FDU4LiMuOjD5U+ORmvmM=; b=c
	1GdfdU5pjk5OLrlWA3uEB0dGP/0ynzm48vdDOL8m/cD/nlEWA4j9VMZWyhcq58cy
	TeJm06bPDRlLbFA2uohJbls5Yo9MHCFsQKwa/MX6O0fwOgArrW0xOGwTrykHl4eJ
	w6yLMiogkXFQnpWFTLhoSUX9P9W1EMYdSgstxqogisQMrezNGPnpi6NCre+Lh6Wu
	9hqQxSudQChXDMGw/yahMW2P338drgavKDjJhs9QHR/ldKyn0vVBvn4hlxcqhgCD
	nJrUCY9+tBYG2x2KtGi34dbxEM6xS2F4+9DNdBK65UCSyFsTrV6Jg7bKeNxFwoMI
	0prDv5MvzJnZy0uBnMy8g==
X-ME-Sender: <xms:h5I0aOXqROMOwCsjdVOkgU_JmbHOnI1IkF9LGbZa0Y1I5zaxlSQRKg>
    <xme:h5I0aKndcxh-9Tbwe8IQMneE2LlDfn-WDPwFyIm-Z-klKl-Cl0F0VzH-HWVrgGSlJ
    keEq8088nW124FIycU>
X-ME-Received: <xmr:h5I0aCaPp19Qn2yjWG3McnhlLlCK5gtzOjfxHNxscKI_3q1duHrjDFuL5qLtWftqc7Hkwtpr35KhswA1g14xhtoQMaMmYNLR5LaFomopEizflg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeelieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfuhfgjffev
    gffkfhfvofesthejmhdthhdtvdenucfhrhhomheptfhitggrrhguuceuvghjrghrrghnoh
    cuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnhepvdev
    vdehffehleelgfejhfeitdelfeeuvddttdfgiefgvedtgffgkeejgeffffetnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhitggrrhgusegs
    vghjrghrrghnohdrihhopdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghl
    rdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhhitghhrggvlhdrjhgrmhgvthesihhnthgvlhdrtghomhdprhgtphht
    thhopeihvghhvgiikhgvlhhshhgssehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnug
    hrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghv
    vghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:h5I0aFWD33SeUNZ66GFOTRs74KbgaWW2lvAxrF6svmJ5BZpHjsvrpw>
    <xmx:h5I0aIkNyZc3VX0gC-mUYa_KSw4bOzIXdSylFqvpkUpSW4amO_HeXA>
    <xmx:h5I0aKd19gtPrBEATWCWetL3o-qSBuJgOHKl2op5wEe21d3WtAt1BA>
    <xmx:h5I0aKGzNUABpzrm-ap3BtBZiHHUcaZAPk8rALhE78LenrFc8Cmrwg>
    <xmx:iJI0aB0hWCPy8exYqx_M__BiJrU2WunbhxDZEwHlKaDNsdYjeDopeuM2>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 12:10:46 -0400 (EDT)
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
In-Reply-To: <20250526120413.GQ88033@black.fi.intel.com>
Date: Mon, 26 May 2025 18:10:44 +0200
Cc: netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: 7bit
Message-Id: <55F20E80-6382-43EA-91E0-C3B2237D79B7@bejarano.io>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <20250526120413.GQ88033@black.fi.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

> Yes but you are adding things into the mix. I'm trying to understand if
> there is something in the drivers I maintain that I need to look. I'm not
> networking maintainer so I cannot help in generic networking related
> issues.

Right, thanks for clarifying. My bad.

> Do you see that asymmetry with only single link? E.g with two (just two)
> hosts? If yes can you provide full dmesg of the both sides?

No. You can see that in [4.6.1a] and [4.6.1a]. When red and blue talk to each
other directly, speed is ~9Gbps both ways.

Thanks,
Ricard Bejarano

