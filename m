Return-Path: <netdev+bounces-234991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13112C2AD78
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 10:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8EC3B15EC
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D414D2EF66E;
	Mon,  3 Nov 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Ri413WmE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K4t0bIfW"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4982EFD9C
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163327; cv=none; b=AnhrO4oMRlpTaixKXTTmjMLynhkFgzggUgPW6wk1zRoZFYGTI/Xr/ADS+67vvsor+GP4qm3vggEdwBj+P+kB3R5pzy33Qjyniep17bq3lziPnciJcEmuTgwzDjWz6xFijmQMe2INzV6Y6RD8tXu+cUG1oRuHZ1+Zi5zIi+ap7wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163327; c=relaxed/simple;
	bh=zm00mBKzh6yr1bPyguW0ZhNzawn6mKn/TcJu8P9YQg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igvqdtIHbyKygbx8/btYt5dZ7QUbu1DpgxHMbM26HVAPEeRhheYHUZtY76RGdTW3TpVQ6GCGXRehWLTw+ucGA2OdFYK8i01NqaaMBjV+8NJUSWbcS1qczwO8Zs20aCLRYxp8vsul387Kcd+Ejy1v27STwmghX4Ab9iwQ6NPbgyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Ri413WmE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K4t0bIfW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5C62140015F;
	Mon,  3 Nov 2025 04:48:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 03 Nov 2025 04:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762163323; x=
	1762249723; bh=8oVSbxL8/Vl46OPdbAdFkjiGGou6Oh572MSQXitvA4A=; b=R
	i413WmEAQorC9lg5+yo2tWvz5aLWv/fiwOPwwi2MHBGHMsxu1h1N4V8xn4FtkbXF
	SakMh7EqYvlz+LEj4J8UouH94y3PrqAoj+yghbtEbpNl0m3HDTPl37gDD2XpSCHB
	d9HRLE8e0Z+KLCEywi/K1tQoPCv6pHRYMEIz/zPX0RRni6cyIS4y8lDz3gIYfREc
	W9GcPZBkT0v71ThoknB3fIRLqzIZrx8uSIgfF37wGPNNieIgSyFXCcBaFQYzO8rA
	jq3OBm70zLMvrn0wIiFMsN7QF2s72fODH7PYn9BrrUYAWv4ZE84oOhE7McsLrjFD
	q63u4Jl2/vG+zC5oE3s1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762163323; x=1762249723; bh=8oVSbxL8/Vl46OPdbAdFkjiGGou6Oh572MS
	QXitvA4A=; b=K4t0bIfWISoCTA4t1a0ruZ8P8apjVIsT2NG7SOAUHAxLOKHiYae
	CQQbbtdoFG5/HB98l01fq244ZMCbYIhfgKjNOA+M3sazU8/QTm2q9IMnQKvomkcb
	rAr+b1Vtx6oI2ZA0p8km7cv3fah6tQu3xZaC6JySH02C/8SpyCjwRqZSZYDLNPTR
	T1xJuDVgkp52Zc4GFm5eCJir2Dj6ZLJhxj4pWSjBJaQzA9DcABfYgCPG5jXFfJLv
	oEw8wKwNH1/aDpk1VTqnKds5/P2I2IH6LL3OyzS9I7IjAiKnmycvQsISD6zO2AtF
	f8dR0jQrn4ItWwEbzB+5j2/Em1sScnJiToQ==
X-ME-Sender: <xms:e3oIaTMs0driaLIYLAZDuSnn06cJcYr-RBrsT_Q-984Mv3QRIWVvyQ>
    <xme:e3oIaU9k-HRA7dmnhNJkC9Fj9Kp2_f56wQ6KDhElUyeyd3QRyyBOvS9kxUkuXS0wG
    t3MdhkFW_7L5IUv8v38LHSxwUs2JAQrcBEsrQORfn7OssxMBIvOEKmB>
X-ME-Received: <xmr:e3oIaXS9n2AKk4zNav4Eb8-UBvvlyH2mzEWhR3a1rLdXbEpMKu65Y7-HWEI2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejkeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:e3oIaWnwScBSC1fCd-_Z481gUIZTBlBN-y7805XxOHG5jOr2oKIZrA>
    <xmx:e3oIaXTohqnGH6NM5-On8ATnvoCCn8zYcnrqDFVw-o7hAxisHhoLyA>
    <xmx:e3oIaUN_z5RFBlUetzBApsLPmUwMfUamsMpVxz_-LjK2OStr1PpPNA>
    <xmx:e3oIaQV1XrweOWBWezh45ccblddbYd1qZjjY1vq3c4mFBbTLt1RMzw>
    <xmx:e3oIaQ-O_JaKr337AnlQbSRMmw5v_YgvBNlRHKvvW6ShTCkexzJi38NR>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 04:48:42 -0500 (EST)
Date: Mon, 3 Nov 2025 10:48:41 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH iproute2-next] ip-xfrm: add pcpu-num support
Message-ID: <aQh6ed8g8CUjPG4o@krikkit>
References: <2623d62913de4f0e5e1d6a8b8cbcab4a9508c324.1761735750.git.sd@queasysnail.net>
 <20251030090615.28552eeb@phoenix>
 <aQP6Ev_21Z45JuG9@krikkit>
 <bfdd7558-31d8-4d83-8532-40f2371dfe34@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfdd7558-31d8-4d83-8532-40f2371dfe34@kernel.org>

2025-10-30, 19:32:10 -0600, David Ahern wrote:
> On 10/30/25 5:51 PM, Sabrina Dubroca wrote:
> > With the netlink specs project, it's also maybe less attractive?
> > (netlink spec for ipsec is also on my todo list and I've given
> > it a look, ipxfrm conversion is probably easier)
> > 
> 
> That is an interesting question. I guess it depends on the long term
> expectations for the tooling. There is a lot to like about the specs.
> Does Red Hat include the commands in recent RHEL releases? ie., do we
> know of it gaining traction in the more "popular" OS releases?

Yes, it's present in the latest RHEL release and recent Fedoras.
(no idea what Debian and Ubuntu do)

-- 
Sabrina

