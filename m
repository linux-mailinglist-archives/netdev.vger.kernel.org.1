Return-Path: <netdev+bounces-238068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E02CC53959
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 18:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF7623420E6
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D3B33CEA1;
	Wed, 12 Nov 2025 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="KEs9xKZg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BlmSJ+yg"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB6D2D73B0
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967375; cv=none; b=t7WoJooyPBeQyZbeEicsor6YZTueTTctgFx+IRw8l3Vla3LaeE1NFHWw//WVIFYgZ+v/gKNEdf+HsLy8DyJWdvoh/6ZdFEODITCk9KQo69hUDrnqZRVK+Qk1M13ePCO9mxPgMyH8GufmDKJpFw4u+R8pNPcW8w+DVGGeo0NdKxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967375; c=relaxed/simple;
	bh=fJmM4pH+7WfrVfLq2Ug6YWDZEY+6BJHk8gOcq1/vp6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsnGlYUrTm/syRHaG9y0XuGKOihIBlzuly5uDSQqvruAGQCypXpqzEudH0qKICEXVtZWbUJOkFCnyp+Y381yBTjgwz8s2HJ7VF+sMMc2+/UQIShvQucx9MUwpHdRRnLoCmjQr7GfJ/NxMCe/u9/VRDHZUcZK0WXHp+xQEsS5zkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=KEs9xKZg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BlmSJ+yg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E472EC0283;
	Wed, 12 Nov 2025 12:09:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Nov 2025 12:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762967371; x=
	1763053771; bh=WpZi8p9N9eL/UQ4TKzBKyCVQUWtponObs/7BuKrPrT8=; b=K
	Es9xKZgzavPSLFaH7Heolw2NCabYNSwFw06wpWDi6WfWvddphkvBuFKINgESH+Sq
	WgsKf3kEaRxKzLe5d3WOH9hWs+Bxbw1GWd2dJBLOYiIzTaZL6aZvqzpzw24A7AVR
	OZKexSWRIAsaRAYEF+u25UcE1SejKV3fvssD9771024SNSCJgAGD6EUeb9+rTj1x
	86O8aBkuqVmsZsZkbSVwUCibg7y5gk1y9yb9h+UIc7KGdyQUvHnJei5QOMa4eI5o
	eFWtOtay8M/MWKc0WybV9vpSzuNbwohVnOE+YBFSa5cwN7hCEbpVx0syInJuIWjX
	dNA7bqFITNLQH0C5XJokQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762967371; x=1763053771; bh=WpZi8p9N9eL/UQ4TKzBKyCVQUWtponObs/7
	BuKrPrT8=; b=BlmSJ+ygeMMsoNhnRQFHmjYjBHVmskqsSCOXUgdq0NnW1Q+wp7C
	cLUh7Z3pWxR/4WRuVi603hOUBXxZHQqotzD99l5nTJHIRXvLjEPbg58CAD7avws3
	sp9ANhWkjn2OfTkYAVMQAyRjWNd4LBcNJE8itXpewtqvNnbP7Un0ylot/wUIkuVm
	fx8DQLYWFJDZERkWPkzNDSspYNWvvmZD0+XwzK0GkrrfcQyLU/PB8LhU+qjrxhbD
	KY386sDrcULskSKi67zsxinQxHqTEEnkeRlWUv0KfYycpDRsY9q6soXioOBXGUjN
	lYUsMNh/NOmp2GbByWSz1rP/bKYGCPSWpfg==
X-ME-Sender: <xms:Sr8UaXEOlPtRVEsVCPnoeBIZDGRNvyeld5W5yi46pYGjcC3USXa1-g>
    <xme:Sr8UaYDtoGjKuff4kPOnQ45BhVKhhKzDc65-UdGYRDXPvMccLqVISmJOrOB48cZ6M
    WPY-TG3UUsRO_ZX97l8zovPnXz1u7cxUVhG6_iWl8mcgVuwx7b2w0U>
X-ME-Received: <xmr:Sr8UaS96qVzNdvug_cDgjc3lnHRRTM3ljfi2FxuONZF09Wjys1UzXtNfXP4_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhhmihgvthhusheljeeshigrhhhoohdrtghomhdprhgtphhtthhopegvughumhgriigv
    thesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Sr8UacCvMAEJyajBISEGIknGAAuJMLSlH4f-Z3DcT6XpuubDYA4ZJA>
    <xmx:Sr8UafQjFysWBAGxKvu-P0QJ04bfZEGmH1uRCeBQFeok5Cyz4COEHg>
    <xmx:Sr8UabulR2_ka9brRmObzbYyJg_MV7yljrEpZ8C7RWh-TCxtxXum2Q>
    <xmx:Sr8UaT0J1MAVePUQaIXAl5RZQ9RLN55lHqk5uVtcpYo0RwYfJDeYsw>
    <xmx:S78UaYIHye0apVftH-VmmR5MFtSE6vlhl2QLXyflRQ8aM4PLYFvd5dCH>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 12:09:30 -0500 (EST)
Date: Wed, 12 Nov 2025 18:09:28 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Marek Mietus <mmietus97@yahoo.com>, edumazet@google.com,
	pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 02/14] net: skb: use dstref for storing dst
 entry
Message-ID: <aRS_SEUbglrR_MeX@krikkit>
References: <20251112072720.5076-1-mmietus97@yahoo.com>
 <20251112072720.5076-3-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112072720.5076-3-mmietus97@yahoo.com>

2025-11-12, 08:27:08 +0100, Marek Mietus wrote:
> Use the newly introduced dstref object for storing the dst entry
> in skb instead of using _skb_refdst, and remove code related
> to _skb_refdst.

This is an important change to a very core part of networking. You
need to CC all the networking maintainers/reviewers for this series
(ask scripts/get_maintainer.pl).

> This is mostly a cosmetic improvement. It improves readability

That rename, and the rest of the changes in this series. is causing
some non-negligible churn and will take a while to review, to ensure
all the conversions are correct.

@Maintainers can I get some time to look at this in detail?


Also, I'm not sure how we ended up from the previous proposal ("some
tunnels are under RCU so they don't need a reference" [1]) to this.

[1] https://lore.kernel.org/netdev/20250922110622.10368-1-mmietus97@yahoo.com/

-- 
Sabrina

