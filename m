Return-Path: <netdev+bounces-202324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E193AED592
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AE83A22CC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B381E8837;
	Mon, 30 Jun 2025 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="rjqoRYZj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ica2msM5"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9546BFC0
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268534; cv=none; b=Pqr2rEYm5Awm7VaouzyrvikrnT0WN0D+qN3O+N4kGqGuHk1wL6TvwCiVY0oEZdbi6SkeXR4YnjKNWODw+yKwYM+0oB+mljNbAuKncDOqnliAqmKtCuPa2fiNGtgG5nFIuAK/dkefHW9pkd+BD7oQDYRaJO2alkAKGbcZzyt5NnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268534; c=relaxed/simple;
	bh=/HeYORDbnwv9uocdNHaTYwmHFIVPh31As669ZseDT1k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Bu6+AuDR2TqtCjunvVPfHM8DgfpRZDCb7ENS+DUijMNqcGHTM65QdCm3w+aEr7I45plDktM8OeoNdoxvjvuBm/ER9jvIrffB2/dk1a10soe+Doh2t6peqiSjqgWTe7pB1P8P/UGDsDR5aYrN7k1hHXqHhnSGaQT13axN2SlsYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=rjqoRYZj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ica2msM5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A310FEC0204;
	Mon, 30 Jun 2025 03:28:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 30 Jun 2025 03:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751268531;
	 x=1751354931; bh=/HeYORDbnwv9uocdNHaTYwmHFIVPh31As669ZseDT1k=; b=
	rjqoRYZjQJss50eW8Vk4DKaHslgsOZ3zi7XHlRTBUUB2g7s4nG/AKAVbAuIjRrCh
	ZhGN1NRxmojDZ9YseDIDAVGyvyz0t73NXIcfm2DlTptYF9XitNYL8DUKJLC1XcEk
	nASF8C/yyEFRCZ4X1M9Y5yweFyqFgmG5ogGkUg67wi3vdBRvaTVxQQptqV/1WGlt
	A2ZDFfDlR6uy4wz7yQsMJ3xmA2AKfnBHebnY7nS9pNmqnEs7l/CnmFzrPtyBKZJc
	djXw+xpGUtPOy4pXJKnl4SW/VYYx0t2XpruwCCExFooJ3syUQKM82tUOoIGU+fxp
	fynRTG55eUeO7fJzIWNrPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751268531; x=
	1751354931; bh=/HeYORDbnwv9uocdNHaTYwmHFIVPh31As669ZseDT1k=; b=I
	ca2msM506cj6vrXVtAv8hpzfSpkF51YSRHUbm5kpSUuyVW2nfKHoAINRNoo7uuEi
	LW1/TPWV97d0gJTx8jTm2xdRdHYwQVdkaTFYoDByh9rdZFS1n89AnJoEDf/TGh5C
	Qy+ei0l/mOH5kf7ZM8GgpvxzhD77gqEkinYmKKEuTpxViYqxR1/ihxoraAeAC+8L
	xO+wquccwjDkq+09dHJwtcipQE26jPJbcQx/eQFGdHW0W5g4G01Wg1gbgqTa8W57
	ZGTEOxOmFtUVX/4ApxukuNaKLryCQyDrhaF6Nhk72/+15SoeklGIjQRGOpgjwrhj
	Q5qdSpiNxTG4ZV9iI3XVg==
X-ME-Sender: <xms:szxiaLhAWQhDeePjJDkl0oIGEXk084Gexu7nTDZB4INPjomGkh6MCw>
    <xme:szxiaID6uz-9Z_3NBaT0vqGhAXMSe4nzCkBKBfDfW5NNLUgFOly7Y2WKirA_cXo61
    Z5VOym2Mqeb9NQprE4>
X-ME-Received: <xmr:szxiaLEAeeunEytcAu4YYeiDuLBxm6tr0iTYo8bIMp4pBXIAcUb5Av93Lcb1WBWc7t0QQkR0XB4Anqb4sfpLpFhY8e1eVmPbuZ9AGfaO2y9udw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddutdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:szxiaIS9M1_quG28ZtHRN_xixC3PTJ9jmFDHVtCXrEfQM3OPEbbAUg>
    <xmx:szxiaIwNQG_j1sKmmDE-SdN5X0aEVjhdZnwX3d9cte6AHYqGR1Ilsg>
    <xmx:szxiaO4oaFBVisODhJkePYH7zd8fN8S1Ad2I68QZdM8DGXP0Sq-5oQ>
    <xmx:szxiaNzSJGP9qw4c5cPVuk9zUotzDmrn47x4gwDkaf2BkuV_rn4_3g>
    <xmx:szxiaC41DDk0KE0I-c8cvZDMIByqJMsg6LbqwRHAaTKuLF4DfpnOajuU>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 03:28:49 -0400 (EDT)
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
In-Reply-To: <F42DF57F-114A-4250-8008-97933F9EE5D0@bejarano.io>
Date: Mon, 30 Jun 2025 09:28:48 +0200
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
Message-Id: <0925F705-A611-4897-9F62-1F565213FE24@bejarano.io>
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
 <F42DF57F-114A-4250-8008-97933F9EE5D0@bejarano.io>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Pinging this to the top of your inbox again.

Sorry,
RB

