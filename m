Return-Path: <netdev+bounces-214365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15392B29253
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 10:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237757A5926
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 08:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E2B212B28;
	Sun, 17 Aug 2025 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9sbp/kO"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78F3176EE
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755420296; cv=none; b=i2cNnHLS+8cAS1/kS2wkY65RD5n8v0MVlmR0VXPNIIy3W19YqBxqLzNUkHCA0iGEnQv40bsT222DaJKogFOWjKeQTnqck7GJVMEF4Ev+e1dSfTM6O6pPBrKFfZgWM6Rqq5csOExcF5buOJP94xFtdCWD+MzxlKsxXFHjEogN5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755420296; c=relaxed/simple;
	bh=L4s4Aa9UdqoaVVskxKz6IDw0OtXLpgn4iBe8OmMLQF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISjJBk4M0fJByVeSZhgkXQEq3X2IEfZMLo2QrIkRcgeQbL5gtIcj1uA3Ik3f6/XgPh6954tbVkvhLEVQWu79syMA1WzZEYPBRhLiipr4Rzv7+mI7Xo0XncU5C5FUTHfrgRsgNlPz5TRlNibbEDI47h3r+X3KZ5TN3AMdmHczyr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L9sbp/kO; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A39F2140006C;
	Sun, 17 Aug 2025 04:44:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 17 Aug 2025 04:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755420293; x=1755506693; bh=g+n3WJMsKy9+1RAakcertpu7zbO188yRbWR
	jkmIXLQw=; b=L9sbp/kOVtalZ/ykLwIzT5AcSJJQCwJma4afIxZnEvLrHXbcVJG
	bctO1nu79JBbWNg5eV94zTPjWHVLeet+v9v8kbl0xBZpU23eJEhs+5/t1Iox7ekx
	V8rhV5DvFnm1EfWdJoHI2UXvvrkMOtZ/Tk2KoMmIcWJcAQSRLIENShM3Xl5v65Ff
	MDw9uHVCILJl9PXrJtM+XZIBiWRnBAPmIMcuar8LZzohf/42aBcguq22QDkKjk4x
	5Owx0/rlIA0YX8d3y6vxgq5n276oDmNdJdlwSqd1sB5jFqYKpR85GIe+WdVTSq7Y
	lzusSDW6izJ0RlCUVnsCFHQb2899vqkLvlA==
X-ME-Sender: <xms:hZahaM2EJ_eN-4nZrMO5sexd6roHDCQ2npbxj4D4kBrOnSQj_68CkA>
    <xme:hZahaD-OPXdRka57yFNNvqhMQY69zBcSjs28g2RvMD95818oM8QGygCWLHl5Gx-po
    tzZLZacWVWwSLk>
X-ME-Received: <xmr:hZahaErgouRruxNkBhnLEBI_4waVj4lfiSVj_EoaTNRJsFFaCgHXNGMxPSTj0mtOr0PmwDsnO0V3qg2vTuOS3j-2RdME4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeelvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptghprggrshgthhesohhpvghnrghirdgtohhmpdhrtghpth
    htohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgriihorhes
    sghlrggtkhifrghllhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhise
    hrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hZahaFQrlCD6dZKYLxFwl_y0Z4i0knYWgRGcfNNYICn2IeL5njhW2Q>
    <xmx:hZahaPOgFdm8jIlEFxbJYgZgsdBLf3PgTh0Swt2_Ey6BadWtuzs2xw>
    <xmx:hZahaLjV2r8rnG-K0HVQWKfrUt10CD2v3jm9uNGbiDses5RyeXIrvA>
    <xmx:hZahaEk2nFn4SNSFOydZvX5vnMhaO0Bx8qIUoxC8LBBRR_FY59CybA>
    <xmx:hZahaFbgWvvfB0XhlwMBUrNmU2ssiWb3sNd9nxHg1HQDmptfnI0gMEai>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Aug 2025 04:44:52 -0400 (EDT)
Date: Sun, 17 Aug 2025 11:44:51 +0300
From: Ido Schimmel <idosch@idosch.org>
To: cpaasch@openai.com
Cc: David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: When removing nexthops, don't call
 synchronize_net if it is not necessary
Message-ID: <aKGWg7tmkEAC9Wu0@shredder>
References: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
 <20250816-nexthop_dump-v2-2-491da3462118@openai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816-nexthop_dump-v2-2-491da3462118@openai.com>

On Sat, Aug 16, 2025 at 04:12:49PM -0700, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> When removing a nexthop, commit
> 90f33bffa382 ("nexthops: don't modify published nexthop groups") added a
> call to synchronize_rcu() (later changed to _net()) to make sure
> everyone sees the new nexthop-group before the rtnl-lock is released.
> 
> When one wants to delete a large number of groups and nexthops, it is
> fastest to first flush the groups (ip nexthop flush groups) and then
> flush the nexthops themselves (ip -6 nexthop flush). As that way the
> groups don't need to be rebalanced.
> 
> However, `ip -6 nexthop flush` will still take a long time if there is
> a very large number of nexthops because of the call to
> synchronize_net(). Now, if there are no more groups, there is no point
> in calling synchronize_net(). So, let's skip that entirely by checking
> if nh->grp_list is empty.

[...]

> Signed-off-by: Christoph Paasch <cpaasch@openai.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

