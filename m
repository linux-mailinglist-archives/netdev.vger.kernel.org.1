Return-Path: <netdev+bounces-235468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4216AC311CD
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 14:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B82A84E5722
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 13:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1902EDD60;
	Tue,  4 Nov 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="B/gPhuaQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r9go7fvT"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E83A2EF673
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261593; cv=none; b=FLJyNwGazPUSezKT8rvurDEvpZGTOB2vcsXvARxqtsXH0G78uxaXjzUGdcmJhGiYCzRFbhwDtAzn6EUzZp7aTurY8Gnz0Gqb7NENEQGqDpr61zcZOHO9GNIrrO4AIcq92Q3b6PtSnq3tbwDK5jhqTEA1PgtmHy2D1rB2kvQQQdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261593; c=relaxed/simple;
	bh=N5i0G9es6ZPdEIUdkAOy469147POAtJKLyrNKXj2Dig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S95M/ZLldbTeFbt49mAuvN8UrOBWFBfUxuAN3tc/w6quTYoPkC9XcfoDjXNriGMG25QbSGR3HyjshdeCw/aOt1K5PQ3GDf5Gd5batCaYzDEJAH8ThQdAFJX0vSZ8clS7eb/UuRhQfZDmHad+Sr6HrmHUHBPLuAjpjt6zidQG1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=B/gPhuaQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r9go7fvT; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E837D140008D;
	Tue,  4 Nov 2025 08:06:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 04 Nov 2025 08:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762261588; x=
	1762347988; bh=Md/gptcmWfqaz7Ki3U+MPXBhkdFklc+v0RNkKyUNsrA=; b=B
	/gPhuaQKpdPwOxGYpTX1AEtBgIZfAWKD0BcPUVsBIrdw1HqNfcNk3FfG5kEY/3MD
	x3LiltFam1W0zIBAkCsqgxcC4OiyjhOp3vgiI+xM3t5hCuAjZ69IapTnG3WI18oK
	PUh90htVI2DVqn92rex2mJY2hp8WwS1ism11EjzC0c8Zmpar7gdMa5KArOijtRQO
	m97eGekSYLUy2cU4qfdOJ72In7F5MuMYbCHO8l9V/0jVRzDSWq0VWEv+4sDBspC4
	LiwBEN/eWSOaSk3C9vtZ9jXLlvU0u4myOFfK9HXMSALzysoHwd+StCoX7OLow+8j
	KARiXxn1mj1ed9O2L7ZUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762261588; x=1762347988; bh=Md/gptcmWfqaz7Ki3U+MPXBhkdFklc+v0RN
	kKyUNsrA=; b=r9go7fvT8JeML+N850XzrnFfBfQNbCF+PMuTFCdtFaeBcEjG/yx
	f+uiPi6JrVu+Uyq124j8WrZIaenDFHfx4YCVkd1IQJh/3HI3IzZ0rnytLXl09fKL
	47pf9LBPEBtxlbrBaVUMRZgux+MV2ZshsA5iXrYruzGLxVhkZVTIbWJRC3ErwELU
	j1+IJqAoZUFqqgrpA/JwZsAdeNoxdBPP1HHAEeirvTK7CkhkBQBkXD0m3MFya1v+
	FtuG+e8iff61/gPJM5RJDe3zm7+SoWBLPMkEFa7sWhHfkRxMiGLv7rAV7GLAuh+K
	wH6nQUvq310COFYKFpBNzf+tm1DjS6fiLcA==
X-ME-Sender: <xms:VPoJabvzxt-ohINQ5qQA4VgbZszjCZyz02fNgD7vlPL1w6JAKb5Gsw>
    <xme:VPoJaTeJQkRJwNKqnwM5xiJoIGtbofxxoAjbjv4pT0JPQBEATkd-FOW7ucu4NlhYs
    rdUpliQVv0kzqYixQQqUftB_-UZHRgW-5BVu0mRUMyVVOsX_A_IDw>
X-ME-Received: <xmr:VPoJaTzkOXZOVNDRhotMNTYQJl9xNH3EWNbn9Q9L0UCyYdvYnqXf6_lq5Jgq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedutdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdp
    rhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomh
X-ME-Proxy: <xmx:VPoJaZEjJKLgHCY3YwWLZYKc5xOKXFleYfS35thHVbcUD2qafjy1Fg>
    <xmx:VPoJaXygRLZAeXBf7p28_zMDWLMAXEZ6IJekRgyWlRI1jiS94Njwjg>
    <xmx:VPoJaasKTgxjXRI7kVrtoNMdlzS1hKw4S8QoA1bWh0ZBfQeL1CLUyg>
    <xmx:VPoJaU1AXwKLwD4MDEMCK0quQzwkWJ-X3D7ss9l68BD-Rw9uOo6YSw>
    <xmx:VPoJaRfZgl5X7A0gK7-d7lDOs6oXLZ1K1kgPTJzcoGmJGhLOfcgRO2dJ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 08:06:27 -0500 (EST)
Date: Tue, 4 Nov 2025 14:06:25 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH iproute2-next] ip-xfrm: add pcpu-num support
Message-ID: <aQn6UT13b4kfLcwy@krikkit>
References: <2623d62913de4f0e5e1d6a8b8cbcab4a9508c324.1761735750.git.sd@queasysnail.net>
 <20251030090615.28552eeb@phoenix>
 <aQP6Ev_21Z45JuG9@krikkit>
 <bfdd7558-31d8-4d83-8532-40f2371dfe34@kernel.org>
 <aQh6ed8g8CUjPG4o@krikkit>
 <a0d03ce2-eccf-4818-ade7-5be737145aa3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0d03ce2-eccf-4818-ade7-5be737145aa3@kernel.org>

2025-11-03, 09:36:28 -0700, David Ahern wrote:
> On 11/3/25 2:48 AM, Sabrina Dubroca wrote:
> > 2025-10-30, 19:32:10 -0600, David Ahern wrote:
> >> On 10/30/25 5:51 PM, Sabrina Dubroca wrote:
> >>> With the netlink specs project, it's also maybe less attractive?
> >>> (netlink spec for ipsec is also on my todo list and I've given
> >>> it a look, ipxfrm conversion is probably easier)
> >>>
> >>
> >> That is an interesting question. I guess it depends on the long term
> >> expectations for the tooling. There is a lot to like about the specs.
> >> Does Red Hat include the commands in recent RHEL releases? ie., do we
> >> know of it gaining traction in the more "popular" OS releases?
> > 
> > Yes, it's present in the latest RHEL release and recent Fedoras.
> > (no idea what Debian and Ubuntu do)
> > 
> 
> That's a start. From there we need to figure out adoption rate. The
> legacy arp and ifconfig tools are still widely used despite requests to
> move to ip meaning habits are to break.

Ugh :/

> I would give the netlink spec priority.

Ok. I may end up doing the ipxfrm json conversion alongside
anyway. For the macsec spec I've been working on (still WIP), I've
used the json output of iproute to create some tests that compare it
to the ynl output (with some massaging required because the json
objects end up with slightly different names), which pointed out some
mistakes in the spec.  So I'll likely do the same kind of testing for
xfrm specs when I get to that stage.

-- 
Sabrina

