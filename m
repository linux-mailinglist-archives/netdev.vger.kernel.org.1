Return-Path: <netdev+bounces-177728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD76A716FF
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 13:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EFBE7A1D3D
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F61E1E0E;
	Wed, 26 Mar 2025 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="nkgU++pT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MUrGBGmD"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD51E505;
	Wed, 26 Mar 2025 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993862; cv=none; b=kTue2w5U7uQncawKToqJTtD8v0z/dhkjfn53s6xOwlsArRyfMRnvQxZeZF3STpJDwlkVbG4CoJTBnKKnBUSId0weZqMfQ1jdgPIpQipSCw0y8muSNNFqeuSdPABBDCxhDzxot7B/EvBJz+4D42wZ5NCmsAINac5u7B6YwX8ie5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993862; c=relaxed/simple;
	bh=bHXC3fXWuum1FoL9zvTiL1eryoAtkD94lq5aJl7xK+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPIHpT8d3Qdsil/4nTSkhQRn8lC7QTzV8dR5hAGzIppJHv9MIwt8rLUcqWLV91S/rVoJHwQzlrcnP30f41O1LdVKt6cf3xDmuTgPeWpxciIbWJiUgJ9CpwolbljVrEhwkyQAXH6SJ3vny4iQ0Nw9v2Lccb24+DLcZ6DgT10BSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=nkgU++pT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MUrGBGmD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69B441140114;
	Wed, 26 Mar 2025 08:57:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 26 Mar 2025 08:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742993857; x=
	1743080257; bh=NAlqLH3kwcPC2CJDpUxLUmmxOvp3Wd9C6S24VbRA/0Q=; b=n
	kgU++pTI+DRP6wPoVBNl14Gl+Vt26pSU9GJ7VMcr0nKES1/JdMEckN3kOFEmlY1A
	H6N/9uMHxsYLVWlE1nHCBLiWedNX2/9FJp6hTnBOg3wRRsamDq9Y2dSKClpU60mv
	EeRms+5z6MKxZnPIu2QbhVRs38uQ4KgWyrrYzBrSR2ArsEHIgX5gsZoSH6rK2BZU
	KtM3Z6Oxt1YI8GdpKAdlfnnKMiCAckIeDBPx/YQlBn/ySNGo1W246HBItlNRch6t
	Ki93u2cIgvAQr0HnmMtJKwBPrWse2WljKRGX4z+L7SkpQFLQsYAMjX4VgSKJDEiO
	bbGnXRCdxGtISgN9rKwcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742993857; x=1743080257; bh=NAlqLH3kwcPC2CJDpUxLUmmxOvp3Wd9C6S2
	4VbRA/0Q=; b=MUrGBGmDmcb55nJGHAEGycJC6ifRqDRh6iuFHDwmvXpu8yvNYlM
	FghbhppplFPo/n70YG4LfwJOvuga7U/Yi2GNJbVV9nSS2zKsFwMbUS/aAui2YI9m
	7IeR+1mMR47H+6VF//0w59yjpfVwlCwDqTYK46xP2b/l27pnVwDI3DxDFER8FJXR
	2kDQcLMULRDydIgjwmuNyV9jpuhzCLfYjDTFwsqSgH6RYZwowz/6Qnu9wIO60Hxi
	DC9DWmzpW3jD6OxnO37X6ecxlxTWBoUnbPiJW/BWoTQ1Tl2JiXS0R6jhshNksYzW
	VcLE3EfVyJMvU39ln3Bj917GuOm3vunwA5Q==
X-ME-Sender: <xms:wfnjZ5cUF4Rpzzol7SK7PN-DT2RyF6bx0ay9VpBtNgNbT_dORSqWVQ>
    <xme:wfnjZ3OKfS_87ntSKVm8lUOVrKFvsFHpccNCK67p-equMD5yfNd7nSMb2UB0r-e79
    5roTYhlbth_hVs2-1U>
X-ME-Received: <xmr:wfnjZyidO1ZXzHiZJsyNjE-tI36RZpBUKv7e2YJOnzj7LnM8w8AA6F58omdq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpuhhrvh
    grhigvshhhihehhedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggr
    vhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wfnjZy9GVxwB7SzXoeofemHgrGglut-6hDUUnKNBhtGciJwjUCjb1Q>
    <xmx:wfnjZ1vgzivMMOuN6MXo2absrlKTyCb4juWjpS_SXbo5NGvNtOQUSQ>
    <xmx:wfnjZxHlccPKhjIt_ISGXK3JpVu8qAriWoDzre9R3JF1jhlA7ip2wg>
    <xmx:wfnjZ8NfleetIkJ02qKgvT_qBCRoV0Ar_JYfu-IaN55HSW3uyld7Xw>
    <xmx:wfnjZ7JQFmvV8RB_SyBDgflWCq6Yr2-vbsFrKznQpMKmn3hWL0uFuNEN>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 08:57:36 -0400 (EDT)
Date: Wed, 26 Mar 2025 13:57:34 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv6: Fix NULL dereference in ipv6_route_check_nh
Message-ID: <Z-P5vvrdA5MHMW_o@krikkit>
References: <20250326105215.23853-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326105215.23853-1-purvayeshi550@gmail.com>

2025-03-26, 16:22:15 +0530, Purva Yeshi wrote:
> Fix Smatch-detected error:
> net/ipv6/route.c:3427 ip6_route_check_nh() error:
> we previously assumed '_dev' could be null

I don't think this can actually happen. ip6_route_check_nh only gets
called via fib6_nh_init -> ip6_validate_gw -> ip6_route_check_nh, and
ip6_validate_gw unconditionally does dev = *_dev. Which is fine,
because its only caller (fib6_nh_init) passes &dev, so that can't be
NULL (and same for idev).

> Ensure _dev and idev are checked for NULL before dereferencing in
> ip6_route_check_nh. Assign NULL explicitly when fib_nh_dev is NULL
> to prevent unintended dereferences.

That's a separate issue (if it's really possible - I haven't checked)
than the smatch report you're quoting above. And if it is, it would
deserve a Fixes tag for the commit introducing this code.

> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>  net/ipv6/route.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index ef2d23a1e3d5..ad5b3098eba0 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3424,9 +3424,20 @@ static int ip6_route_check_nh(struct net *net,
>  		if (dev != res.nh->fib_nh_dev)
>  			err = -EHOSTUNREACH;
>  	} else {
> -		*_dev = dev = res.nh->fib_nh_dev;
> -		netdev_hold(dev, dev_tracker, GFP_ATOMIC);
> -		*idev = in6_dev_get(dev);
> +		if (res.nh->fib_nh_dev) {  /* Ensure fib_nh_dev is valid */

I don't think any of these comments are particularly helpful. It's
pretty clear that you're checking for NULL/setting NULL in all those
cases.

> +			dev = res.nh->fib_nh_dev;
> +
> +			if (_dev)  /* Only assign if _dev is not NULL */
> +				*_dev = dev;
> +
> +			netdev_hold(dev, dev_tracker, GFP_ATOMIC);
> +			*idev = in6_dev_get(dev);
> +		} else {
> +			if (_dev)
> +				*_dev = NULL;  /* Explicitly set NULL */
> +			if (idev)
> +				*idev = NULL;  /* Explicitly set NULL */
> +		}
>  	}
>  
>  	return err;

-- 
Sabrina

