Return-Path: <netdev+bounces-199959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B669CAE28B4
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 13:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C103179BAC
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FB61E570D;
	Sat, 21 Jun 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="HrdZ2ruX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iaLMhipq"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676D84D34
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750503639; cv=none; b=XgdqTyd7MgLvbuiLTzekTvc1trSJo8D65LWe0gPrGE6IAWDL21xN7MK+XsEd3JcxwwzYo1m1PDDcxMFLjiiuEiogqUuyn9KXnPEv/u8UZNT/sUKvIObgAkN89vwT50+ZqmsY+km4jAbp7js7XK2XIwVXPRYoA/YYeSdleRPBeiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750503639; c=relaxed/simple;
	bh=oJvHsWspQ6RPTkuT+waLiNWoEwAStjWVpBbDAzYjCHo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ohNPDXhSJXEvWXYKk966GKo5IlmkOLMXe8Hc8UiGYrs0IYTD0VIAe8XwmplwiEcXC29sN5WNmZ21V7Qz01rJdt6lVsgR01s8+2+sCXU21HSkgL7Vb4MSqu6Unlec3ni12347Lax2BuJOTiDcXrfJMIJ9MzwNf0Pp4kCK6zSlNx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=HrdZ2ruX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iaLMhipq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 75EA41140151;
	Sat, 21 Jun 2025 07:00:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 21 Jun 2025 07:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750503635;
	 x=1750590035; bh=oJvHsWspQ6RPTkuT+waLiNWoEwAStjWVpBbDAzYjCHo=; b=
	HrdZ2ruXBAVUWogJuCzfp7lmRk5b3e0v+TFfj3Osi1hsopAl6SOpRP1yIg1347pz
	uaRcE5pyx4BI3oxB1N61nU9OpWmO/V9rUc7pjrkDk8s770SjNF0c+0RljlbzlKcO
	ELFYXbts9d/fYgnZjPbCAS+CZCMu+tq0Qi9zVjI70Y3DnPNB/VTRd/xonu18E1zd
	pXEmEG6BmcD8Rk4iQn88kRCKGvm0ZfsUGleLN+KKsvx3HQuzKmvgUkvAuOF16CdE
	cVQq00PE1cjZ3zDpHjqaj2saqgog+wHr9cRh+uoPW2mIz2AofqbCWbfFc5nwAxDF
	bMYxrDZtoJNq/FaCFnaQMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750503635; x=
	1750590035; bh=oJvHsWspQ6RPTkuT+waLiNWoEwAStjWVpBbDAzYjCHo=; b=i
	aLMhipqACK+JiPedHgGlxdnTevytKVVVOLR+g5tWG3t360bNee21inUqjr87cIDE
	AOUzCfWPsH7XR9yInHC32k06SMbTQ2bxrii+4Wp4faiG+yrOLdPgzE6xbCKf9wg9
	8gTpNQyflkvxEiaU9G6J79pRsLtA1JjFdspMZBiZZM30uyBvjEh1JH8UGzsmNSHg
	R94frA0g3YIwOPDG8W8Phbos9xlSSsBPn3yuWt39uCojjlBH+EzhSiXnaCT96ASS
	z6Z6oRse5Py0bZaVUr8K8LYTDg44Xbo+kLzd+ZnyCCyKzJm1e2SLJHoO6MCyfcKK
	GcvZj5w3pyvySxXi33rZQ==
X-ME-Sender: <xms:0pBWaA8hZrGOyB9fAGya2J4f7LW-z0M6srU-ABq4pHGeYiKxn6qWCg>
    <xme:0pBWaIup-Q0KoNHWSiJ8vV71d36Jk1gURwVSKHGOZmSJGIQrAy6wdq9DsAjnTOhfq
    0565aEau_SFoC3HJtk>
X-ME-Received: <xmr:0pBWaGBqJA9U7EJ4grvFDXA9gRmRjKFsIvg-zqYQNYudIUDIgVkPmSYr7k0v6ztqFa3ylF8s6PDd7OVoDMeAOT1JDOkS3wf16gJapx0nHIwUsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtggfuhfgjffevgffkfhfvofesthejmhdthhdtvdenucfhrhhomheptfhitggrrhgu
    uceuvghjrghrrghnohcuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrf
    grthhtvghrnhepvdevvdehffehleelgfejhfeitdelfeeuvddttdfgiefgvedtgffgkeej
    geffffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprhhitggrrhgusegsvghjrghrrghnohdrihhopdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtg
    hpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtgho
    mhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmihgthhgrvghlrdhjrghmvghtsehinhhtvghlrdgtohhmpdhrtghpthhtohep
    higvhhgviihkvghlshhhsgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfi
    donhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0pBWaAf3dr8w--EmkkyJ7O0YKF_hT1z-7c_8igl3G_BZUIUDc5AW-Q>
    <xmx:0pBWaFM8T3D_HD6V-d8KZeE83wv6-JGub843iNrwn4k5Sbk2KCCqvw>
    <xmx:0pBWaKndWRkaMEhpAGX9X_HJqsorXT6JUj9gkYqO9eHS278Z8e21hg>
    <xmx:0pBWaHvI0uCeG_P7faGpnkKoYxpWCxanUeIBBMVKj4qkGt59co1hQg>
    <xmx:05BWaEW3Q3RRvvpIBietbtK0cOO1bK207vkxlwG5Ms8TXm4Lxt0owrBx>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Jun 2025 07:00:32 -0400 (EDT)
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
In-Reply-To: <ae3d25c9-f548-44f3-916e-c9a5b4769f36@lunn.ch>
Date: Sat, 21 Jun 2025 13:00:30 +0200
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
Message-Id: <F42DF57F-114A-4250-8008-97933F9EE5D0@bejarano.io>
References: <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
 <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
 <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
 <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
 <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>
 <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
 <A206060D-C73B-49B9-9969-45BF15A500A1@bejarano.io>
 <71C2308A-0E9C-4AD3-837A-03CE8EA4CA1D@bejarano.io>
 <b033e79d-17bc-495d-959c-21ddc7f061e4@app.fastmail.com>
 <ae3d25c9-f548-44f3-916e-c9a5b4769f36@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Anything we could further test?

RB

