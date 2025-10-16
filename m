Return-Path: <netdev+bounces-230085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA12BE3CF9
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903F25E00E4
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF23339B2D;
	Thu, 16 Oct 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="mg/vQ8BW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G23nErzP"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E032861F
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622792; cv=none; b=WN+25wQmczsstWT/mK1NQHRGSMnSgQI9bzZffpf22y8Ihu7nralAu9CvYqcAodUBrCvPyAYkPCHGS5bOdN8y5H1v34ejhdfXUDGA7cveZGY+AMk0+zLEevQ0+VftTQy71Niji4NSgZTg8KvCjpw+GiVUgXSHg7r9TnPs4WYd5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622792; c=relaxed/simple;
	bh=jyB3XOIgKME9GMRVN/IyZUE8KD/u+jyMQFbsp8NIwAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMh7D8P20DDJ1KW4TIHeYAF0ljdOy4m3nvsb8LN8yRw229mRPqoOtgf5GGTVb6NhXzgh+BCx7L+kpMSv5dH6LDJMB1U5ajrFTFtqOMGPyI493D0Y7ouMcD6xuVmaA5WybxYO0/dg5+TQikWq+UA1iAhJOHyHzr5eLHHnXPLV1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=mg/vQ8BW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G23nErzP; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 34FD87A0227;
	Thu, 16 Oct 2025 09:53:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 16 Oct 2025 09:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760622788; x=
	1760709188; bh=zLaMnltvr2muruRr11feAX2YFnYP6Ko3AidG6xfSepE=; b=m
	g/vQ8BWcRI6/6l+TvhOSz0zPmbww51J+TLVjx0oAm9Q4auztk0kuTHmuhMRjyrbr
	DQ4zQLqBTnSJG8W62K7P/Im52+E41f8vYCInvaqt57qy4obrwDnQ04VzmT/ALGwl
	Ych5Ew1frQcV8EWuVXQVvBxj+IqtjIg6ty7yshLXQIL1tYNLsRBbnq2VEpv0vUb6
	TO4NO2um9gjRkOzQTq3twz95UAktpQOlXY99LBWnReM8fL/K34g/I4mlUbcWSjw5
	Nmehe3ed0qJA+Y3T2IkYVis0sEF2V/cjzarcQDoMs/OdyiI27FukYXbAlsH/Ud9j
	PVADv0GyqlfCcFg5aCtig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760622788; x=1760709188; bh=zLaMnltvr2muruRr11feAX2YFnYP6Ko3Aid
	G6xfSepE=; b=G23nErzPAZU9e8KGxqE1e/SHBWP3oHA11MVeBnlIaNpQJZND531
	Zi+od0Gld5oyC9StkLGKoDq5hu1HqJDZp21nxtgcyXDcsakSeWD5YiSG22sYYhz1
	8ZscynPdkgNE+eIuocU44io88lOtGPqTykrEo3FfmTCNOZY+wfumg7CtaamCGMRB
	mix/87j9rnnJbgmrqfX1UID8/NFlxT10r/mGXRijlrNc3hUz5++Icf6CpjOkHRnU
	ZGggPv8ZL757/K1KP0XzYLbXTBA4tOnfxxlaModHT22eF9ajfdlrAzFixlmXrgLD
	Ri1stuaWTM5Q9vq+BF53biJPYnomTATeOTQ==
X-ME-Sender: <xms:w_jwaGYA4rPIFnIbJ-TeZSW2OBWblmFhiz7_XsuLMeBmQde5nJ1-mQ>
    <xme:w_jwaLrTa3Tj_zygyIbbmUnTEYLBwopWLLvTuTz-JpKLLPm2VN100NqYg9wDcD_zz
    HD3vifOaMlKJp3q6CRDiYTxLzN3difGYZ4LxB2UBQAInwq7FVw6Jcc>
X-ME-Received: <xmr:w_jwaDMe3tg-6hoRyuuBIyefYVCaVgZUAoHxab100S2CQ117E4z8_-zxzt9L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeigeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifod
    hnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhho
    fhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:w_jwaOobaIXDnLYUT47nS7dEZ2IJ_Xlo6xRnS2JT_cCUFYatTsefiA>
    <xmx:w_jwaAfz1EW013GJklRbajAlQAm5--K9uyyBwESjNjIxoJsNAItmbw>
    <xmx:w_jwaMQjxXxevOZYif1UIbtTx57VynkLaOy3Mx3rdfjk4OBpfJEaiQ>
    <xmx:w_jwaBaunKJkVdQ5590IdhEWJV7EPslU16ydPAbMyC34XqAmrK9BCQ>
    <xmx:xPjwaNNtpy4m9mcrcgx9-bFiVPzCBriPvSgJHdo2RNu-9pmvskAvBwSm>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 09:53:07 -0400 (EDT)
Date: Thu, 16 Oct 2025 15:53:05 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] netdevsim: add ipsec hw_features
Message-ID: <aPD4wax60CXXgwF_@krikkit>
References: <20251015083649.54744-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015083649.54744-1-liuhangbin@gmail.com>

2025-10-15, 08:36:49 +0000, Hangbin Liu wrote:
> Currently, netdevsim only sets dev->features, which makes the ESP features
> fixed. For example:
> 
>   # ethtool -k eni0np1 | grep esp
>   tx-esp-segmentation: on [fixed]
>   esp-hw-offload: on [fixed]
>   esp-tx-csum-hw-offload: on [fixed]
> 
> This patch adds the ESP features to hw_features, allowing them to be
> changed manually. For example:
> 
>   # ethtool -k eni0np1 | grep esp
>   tx-esp-segmentation: on
>   esp-hw-offload: on
>   esp-tx-csum-hw-offload: on
> 
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Hangbin.

-- 
Sabrina

