Return-Path: <netdev+bounces-231900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B4EBFE625
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF573A9BF6
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3034305E0D;
	Wed, 22 Oct 2025 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="hyezpTns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VdTtwvAz"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB942F83B4
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171088; cv=none; b=ibE7ovyn0pPJxHDyy5oOiKX2SLFdnGvNvBLYM0qgcnfNJsPaU5Erqw2WZfkaxovt8+qybOIah60z1K2fXn6i5OjnYimjsPAECTqkOK7A29cm913WWAIf+0XY8dB8TWRXb4zzLF/2NieCGek9hpD1256O0L2Snq8feJ7fh+CA88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171088; c=relaxed/simple;
	bh=YWSQ2GSfWdXGk7ualW/p5/OJetKeZjmFlGOjlfVpFA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Udd60pJldHqZmu59DeZCHnTgNzlT+stVH0OpGrIc/sf0oBPUd/nTQgtC3cQDbWyMO0Tq56WJiKnd53xI/EfMBnmxS397JwEL7kaJWBTcjuilcrcMozLtpHjXVsU0HnY2Dwt3VMgwCt8FSuI9jCczN55tB1MKTciDdpxOng9iuuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=hyezpTns; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VdTtwvAz; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C26C7A001C;
	Wed, 22 Oct 2025 18:11:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 22 Oct 2025 18:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761171084; x=
	1761257484; bh=sJ9gGZJ8+b/G5Bg7LhH8kJO167GNDh4hEeZ6Uq59l3k=; b=h
	yezpTnscDTvihjquLv3hNRobup5uPzibNmQMG/lTFgcDlAAu+faSkRNyg9r56XvX
	9OEkUMQcUVNrqsXL9L9GMb63EK1e5GujWHfW+UuoICWlyM4jVZcds1fz1KA/XbfP
	CuBeGDn9RrPz+U+DfU3Qtt7h7R226F190A6aq4KOKB3xFco9X7j8P6rY7uAn7Tiq
	+C/clKpop0uR8TaTDPRfJv9HIxLYmQ5sDXplTiA4Cigri5szj2sg2VKjr1zkKn6M
	AjmhBAC6soj/sp5WRh+FGVgPwMG3/wV1KfniJbwkSZTiCKYODPgeplJTE3lttSpk
	sPSGaHlHPwmPDvV15Y68A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761171084; x=1761257484; bh=sJ9gGZJ8+b/G5Bg7LhH8kJO167GNDh4hEeZ
	6Uq59l3k=; b=VdTtwvAzHqXDKzQwxwKqyQT9fYYWQAh6U/ojYj49ZF1cFrC+M1i
	xGFiph4XF1lB7smJvx7n3LaBY3b/NbNAbz+pE6HdK0/siVGFUdBQnP+2uXmCFA4G
	S+VYjTehXHEG0IV68RmPjpubgIVRFmlzUWRjlBmscIMW3Dy+Zj77ZW1VLc4IqX5S
	RlOR9NU9D9BGexQgptUNN1w3HMeIzWHP4SnZ7q9kG37D7+CKLzWpneb6rha9aiTb
	0fFHFQ7NuqVCl7PHP71VFUGrcM0aHx8rEGwGe7/kYvAzp7ResAxi9q3Z8lkujGI+
	y2cT1HomNwKCAX9MQbIjp7SnkVk4PnL5+Ug==
X-ME-Sender: <xms:iVb5aNqTwN8C_71V1OJAqJqMbRWASSuL6DfVKk3vk8GmWta2rNbmdg>
    <xme:iVb5aLiisZlpMb6auiTi_lhfoDjeQc1CVmXHlPvUzARsdRcWQB8whjOn2ShDg8gwH
    ab3JmNEkKzAyY7lhKMyxVWiIdswZu3zXxi2-QiXklL29Hr18Pk0Z6E>
X-ME-Received: <xmr:iVb5aHOzPmrbbtDiZqsv56RiooNF38Ld7fr13O7GDkH_uioP2BnrW6v-b-34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtse
    hsvggtuhhnvghtrdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgr
    phgrnhgrrdhorhhgrdgruhdprhgtphhtthhopehprghulhesnhhohhgrthhsrdgtrgdprh
    gtphhtthhopegrnhgurhgvrghsrdhsthgvfhhfvghnsehsthhrohhnghhsfigrnhdrohhr
    ghdprhgtphhtthhopehtohgsihgrshesshhtrhhonhhgshifrghnrdhorhhgpdhrtghpth
    htoheprghnthhonhihsehphhgvnhhomhgvrdhorhhgpdhrtghpthhtohepthhishesfhho
    ohgsrghrrdhfihdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpd
    hrtghpthhtohepfhifsehsthhrlhgvnhdruggv
X-ME-Proxy: <xmx:iVb5aNwkIXc2-u9AAv6vM4pS3C23Jy9_-u5Nb6GJTjmoMjL6CHtBAQ>
    <xmx:iVb5aBqTWwsXfmXgZwyzZ6lIbTp9ooduQsObnr5x95bUVPm-jJAHZg>
    <xmx:iVb5aFM7zXbzDbt6IaBikQmC0cLxU42U-fHVhHWVR0zYmuVCi-W90A>
    <xmx:iVb5aNdqvem-d6BlUppeWAicNEgD7fabXfjFMqgkcLEcOXNb9DJBPA>
    <xmx:jFb5aI6iWvzKZ4hO-Q97T_bo457bvpY27OxAC-Gg9kaLv892h9n4FOwh>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 18:11:20 -0400 (EDT)
Date: Thu, 23 Oct 2025 00:11:19 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Paul Wouters <paul@nohats.ca>,
	Andreas Steffen <andreas.steffen@strongswan.org>,
	Tobias Brunner <tobias@strongswan.org>,
	Antony Antony <antony@phenome.org>, Tuomo Soini <tis@foobar.fi>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next] pfkey: Deprecate pfkey
Message-ID: <aPlWh6mBAmRINhfp@krikkit>
References: <aPh1a1LeC5hZZEZG@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPh1a1LeC5hZZEZG@secunet.com>

2025-10-22, 08:10:51 +0200, Steffen Klassert wrote:
> The pfkey user configuration interface was replaced by the netlink
> user configuration interface more than a decade ago. In between
> all maintained IKE implementations moved to the netlink interface.
> So let config NET_KEY default to no in Kconfig. The pfkey code
> will be remoced in a secomd step.

nit: typos: s/remoced/removed/ and s/secomd/second/

> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Acked-by: Antony Antony <antony.antony@secunet.com>
> Acked-by: Tobias Brunner <tobias@strongswan.org>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

The deprecation/removal plan sounds good to me.

-- 
Sabrina

