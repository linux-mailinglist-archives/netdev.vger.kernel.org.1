Return-Path: <netdev+bounces-118544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63067951F63
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 18:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B647BB298E8
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5401B580C;
	Wed, 14 Aug 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cAJCRHYy"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF831B4C4F
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651388; cv=none; b=cruKNbGGa6G08uxJIdRmqhLeNQlzWIWTcLqbAhOcm+A7kEqxjMwCC52c+iAEy6Ayj0pwvwLWVTegereeRRQyBeBqTG8S0tE46DJjaO6naHP9jadNS9Cw2v7l1wqL8lxD1dimLR1mdqGxjDjTTLveHHqyLSCDXLmXQSlRw39qezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651388; c=relaxed/simple;
	bh=AtuxwTJ48j37Ui652IE4fPlwG9AMNLsN4mxcDczrPy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmC22fHJc+dOqF+LLRH8Uhmh1GB0tY+Bi9AL4sptfvYMu6TfTmbNB2Y1jFxXRi9uquV/TgQld2HPkoYCGrKUqZydco946HVh+optTy/rLj30xqYuncD79tzGsjehZzIutzFnWiOhzxox7etUbxJnf6b1A35AMAZ3YGvr1fMTkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cAJCRHYy; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B8A6A114AB26;
	Wed, 14 Aug 2024 12:03:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 12:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723651385; x=1723737785; bh=7mc5o9AorVLa5vRzSU6jTlYBHJnU
	KSlennIco1jEoBM=; b=cAJCRHYy4xykpGmGSfwiSEsKxZgHKMf/z9lKUiHlW1P+
	O0tNz7TZHo3g19K0Bv+50p3o4MCLO8kQeWJCjH+s05WQ+Tg5fKsJ7ClExVgExqYp
	2HYBktg7TISFLulkrbTadW8C2R6439UtkkxipnSwr8415Is7y8h8WdgveYYPGy4s
	AlYFShHaSyJQp4RVehdwdFmxacHlMQ58pm8IAQxzeYO9QwOcgFT6qOCf/sTpGGsw
	RY+WgbqxrPmpaSzI7EuvQVt7y0j7IbiQZa4fDuF/gOvdINIAM+E+DQK7KkGY5JSq
	po1f0VNPcrZmJR2RcgX4zXK9UGq/lzwvoukHyFw8jA==
X-ME-Sender: <xms:ONW8Zr-oITvgDeGKhHxEFCjp3SVUyASwjXFrIkHLa_LPZq44OdMoiw>
    <xme:ONW8ZnuP-uQvv6EF_hyTQzWCbRPpHzw_zEx72n5HESrg2q9-lUf9Ial3I4gPG61m9
    DoiKDk-5cAYmL0>
X-ME-Received: <xmr:ONW8ZpDxW4JZtuPa7dkSczCyp_TdvmNqHC_amKtiHWkP8UvOfgZ1gY3Ypf67vsrRx5DUuedfn1wa42EzI31wJyjF925czQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhifrghtvghrmhgrnhesvh
    hulhhtrhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdroh
    hrghdprhgtphhtthhopegugihlugesuggrrhhksghogigvugdrohhrghdprhgtphhtthho
    pegushgrhhgvrhhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OdW8Znem0PH8BGbqmBbkQw8-t_7f8541n-678YRBNAncyIR1oMg9RQ>
    <xmx:OdW8ZgOPXU-5W8as854EFE-QP8AHUjPDZpD9GwVwcIwsxjLMQZSQUg>
    <xmx:OdW8Zpky_cpW0RsF8auOEjxzDRD7-rSxVrGJiodnNIzgWXefS2C0fw>
    <xmx:OdW8ZquS7a6Dxuyx2aTDwAD15Vtr5ipmlNlAEN7PcNNGuk5Umohg9w>
    <xmx:OdW8ZtqrYNfgl2O28-R92detpQhNodiC0o2GX4gBLqwPLjgzvJw-1bDJ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 12:03:04 -0400 (EDT)
Date: Wed, 14 Aug 2024 19:03:01 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Mike Waterman <mwaterman@vultr.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	Daniel =?iso-8859-1?Q?Gr=F6ber?= <dxld@darkboxed.org>,
	dsahern@gmail.com
Subject: Re: Add `auto` VRF table ID option in iproute2
Message-ID: <ZrzVNV7Ap230Lx4h@shredder.mtl.com>
References: <CABmay2CxFPpsgzSx6wCxyDzjw2cqwAAKs6YjiArR1A2UPLpgJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABmay2CxFPpsgzSx6wCxyDzjw2cqwAAKs6YjiArR1A2UPLpgJA@mail.gmail.com>

On Wed, Aug 14, 2024 at 09:28:00AM -0400, Mike Waterman wrote:
> Hello,
> 
> Package: iproute2
> Version: 5.10.0-4
> 
> Feature request: Add an `auto` option for VRF table ID management like
> in Cumulus Linux. I believe it'd be the iproute2 package on Debian
> (11/12).

I checked with the Cumulus team and they do not have an "auto" option
for VRF in iproute2. It does exists in ifupdown2, but that is an
interface manager, unlike iproute2.

> 
> Example: Instead of specifying, say, 1001 for a table ID, we'd do the
> following with the `auto` option:
> 
> ```
> auto vrfexample
> iface vrfexample
>     vrf-table auto
> ```
> 
> Or:
> 
> ```
> ip link add vrfexample type vrf table auto
> ```

AFAICT in ifupdown2 they have a table that keeps track of allocate IDs
and they simply pick the next available one. Unlike ifupdown2, iproute2
does not have state and it will need to query this information from the
kernel which you can do yourself in a script before calling this
command.

Overall I don't really see the benefit in something like that in
iproute2 and I don't recall other iproute2 commands that work like that.

Also note that ifupdown2 reorders the FIB rules so that the l3mdev rule
is before the local rule. This is something that iproute2 does not (and
should not) do.

Adding David who might have a different opinion.

> 
> (I'm new to the list and this is my first request. I tried to be brief
> to respect time. Please ask any follow-ups as needed.)

It would be good to explain the motivation

> 
> Thanks!
> 
> Best,
> Mike Waterman
> 

