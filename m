Return-Path: <netdev+bounces-145777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3649D0B5E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF704282968
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1141714B7;
	Mon, 18 Nov 2024 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mC/SRVKG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cI17NtaH"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00882907;
	Mon, 18 Nov 2024 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920712; cv=none; b=UtG261GJ+IQE0NSdnn7SffsoJtCcIJeRqRHhF61Fv+p8B0oSk1G0kJgzBU4ImMnUHxD9tAZD/H4TrHbR8RT1+3xVk2trO4b9rGAm8XYb4S9Vo97nY0vcgtMoJLNGRAAl99GGM6cdQtcRipR3ofd3+jr+SriZE09N/j7n1WBhwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920712; c=relaxed/simple;
	bh=+s588WJ4gk9wbw75TVV+RheBWqaKRkOZn+a+pEIAwX4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eJ2nNorpJvDhtSAnhk4lxQ8elvFaB6+M7fyKO5BQD6hZyyFF5VZ6T+XvIQRDMwKKASjd/FAsySSPapG1XVPvZsvs2OhgmXSR2HRgvtjfgCwcPdjNpRYxv0OQhImgSX7GrK43IlXY4f6Dnt4CM80qG/HF6z/UGHMXh7rg1ldGDx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mC/SRVKG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cI17NtaH; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C9979138070D;
	Mon, 18 Nov 2024 04:05:08 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 18 Nov 2024 04:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731920708;
	 x=1732007108; bh=gf4HA4MAdbhLcSvM8TnDWCU5nuBOYRd+UnKEWXA6Tls=; b=
	mC/SRVKGvsslm21o20Z5VIyi1gQ6PypC3svwUI6xeYW3iBshmejaNdekK5xf0/Hn
	Vr54P/doV/GkiRhEEtYSJFqDjZc2gspn9wYVX9Bmc+HNfwhvP/8oiHRa+bjEP6vP
	2TAZGQ1UY59Ede2j6zhrawLwgUZyk6mGE23etSPEhLns9gdw/6ZgPAcn/zt6uYgf
	LIq/Y6R44EquJh9i58G2fElo0IIMfKIm7jMsPbuIb/+5svyd1ctq/YyRtx55PfUW
	i1lGekmsHlK1MREs6NlkZoXLN0IRYvZMXcTuE/BOtU+oWhtT+YOfarKiXceWQO1e
	XR7rz8tiMxqV6yU+DCJkQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731920708; x=1732007108; bh=g
	f4HA4MAdbhLcSvM8TnDWCU5nuBOYRd+UnKEWXA6Tls=; b=cI17NtaHx6pDVnb06
	SUikQtCpalUARm7oJK3+za00Xv2XSAbc6nbQWUhSEMzT4JhfXKSZxQ+W5phg9F4S
	Jgu6zIdVKibt4rTiDHcGQxfOqgGoMhKKel6c4pRYY9XK3C2igRwFSJQPKrxjFmST
	jI8jc0zJ1sj6ddvxC4PaFY99re+xaNg6xHkRcpVxfxIiekQAW6ql/56VChx3Enzj
	1GTllnaXt1pib6qhIsEk7jL4Ece6F8M9pgmaHy5oOC6Zi0VxLKmFQIk4X2Cze1Aw
	EwK4w3ZvIIyT4NrHiz7q2VJn1fZvyVeeig1iBH5CU9cR+u7OaEgAYVd+RCNihMgl
	n5lSw==
X-ME-Sender: <xms:QwM7Z5e-BLKlUy6vneE6wXTvk0vIZrY5PNL9yM_KIpmsFJqg64Q8qQ>
    <xme:QwM7Z3PsavxoblcxLEK8JGlXkzl_wz4nHSEtibptCih1YXZJHFqfXRME2Hsh0Vcey
    zt2J39BHSLm1m9rto4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhkeeltdfffefhgffhteetheeuhffgteeghfdtueef
    udeuleetgfehtdejieffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghkhigptghhohhusegrshhpvg
    gvughtvggthhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhn
    vghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgu
    theskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughr
    vgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehprdiirggsvghlsehpvg
    hnghhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:QwM7ZyhXWjWwuzAyeJhvSyzkoOA9KW09C6TAiJUyJmpq5GdwXGQjHg>
    <xmx:QwM7Zy94iC8McJYeioPwCoyzH8mqayiLyLatgUEmeE31BZGLpXdKAA>
    <xmx:QwM7Z1sqraKGDKRBfuMwShDVaI7ZOyyVKAhENwLGNp4syP0f7G2j_A>
    <xmx:QwM7ZxFnk07XbJDlrGWBqTPWGtCc7c4unC4UDac_HbYXhv6efCTdBA>
    <xmx:RAM7Z-Gwjz9sEbnLXhN_Ic0w5Iv_U9X5XxsEh8XfQlBlN5ZUJOSLJjNU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 77F842220071; Mon, 18 Nov 2024 04:05:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 10:04:37 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jacky Chou" <jacky_chou@aspeedtech.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, Netdev <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <e0ad34dc-cc11-428e-8bf0-c764612452e0@app.fastmail.com>
In-Reply-To: 
 <SEYPR06MB51341859052E393D404F4E519D272@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
 <20241118060207.141048-6-jacky_chou@aspeedtech.com>
 <4b1a9090-4134-4f77-a380-5ead03fd8ba8@app.fastmail.com>
 <SEYPR06MB51341859052E393D404F4E519D272@SEYPR06MB5134.apcprd06.prod.outlook.com>
Subject: Re: [net-next v2 5/7] net: ftgmac100: add pin strap configuration for AST2700
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 18, 2024, at 08:51, Jacky Chou wrote:
 
>> Is there a way to probe the presence of 64-bit addressing from hardware
>> registers? That would be nicer than triggering it from the compatible string,
>> given that any future SoC is likely also 64-bit.

I just realized I replied to the wrong email, I meant to send
my question as a reply to patch 4/7. The patch for the pin strap
looks fine.

> There is no register indicated about 64-bit address support in the 
> ftgmac100 of Aspeed 7th generation. Therefore, we use the compatible
> to configure pin strap and DMA mask.

Later in the series you just unconditionally write the 64-bit
address, so it appears that the ftgmac100 can actually do
64-bti addressing all along, and this doesn't have to be
conditional at all, the call to dma_set_mask_and_coherent()
only tells the kernel that the device can do it, which should
work on all of them. Since the other devices won't have a
larger "dma-ranges" configuration in DT, and no RAM above
32-bit addressing, it should have no effect.

Just make that part in patch 5 unconditional.

     Arnd

