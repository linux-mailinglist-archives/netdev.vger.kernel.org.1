Return-Path: <netdev+bounces-165645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2314CA32ED0
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964E33A1E56
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADED925E450;
	Wed, 12 Feb 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZeDkEOC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F525A622
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385570; cv=none; b=jhtw3eJ5HVD4Rr6dAfwwo9ZjTsVNVdgugBea150CW5LqK6zWEw1WGZoQYkMCCpP0qJxAvDib03gxlZ86xtyN29lFmkB+HpAxHqw53Gk6QLu267UpIhxvYikaqpvaXl2f0iycJmGX2trd+SZFpUlJCko36WCiIbfXVl1RkW/+2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385570; c=relaxed/simple;
	bh=+EN8DheoioUJ/RRQampsy3d8JTjHNk0i6Rt5pvnHAnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEkK9DOXKQ6FVokrdoXpoZu2CdBK0u1oTbtrARz46W2QqUqNvvyc6pl9f+/P698njKAAjbYr9IhRM/9UhNIRJaFZ7rjYnArAwoqgGQGtQn5pLYZax1RV8Q3TeFD/UAR8T6Cop85kCTu62w3uI1rhPlmSvkC9FmHz814oO7ul8vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZeDkEOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5696C4CEDF;
	Wed, 12 Feb 2025 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739385570;
	bh=+EN8DheoioUJ/RRQampsy3d8JTjHNk0i6Rt5pvnHAnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UZeDkEOCKTvbHRtLsqleSqx8Oq51axMsAOQK4+NHMfeZUk6k3uD0t89aJLUFwRRXr
	 ca4tPUDKreUbjNWCv/5PJ/KWOtdkQj4XiXmjmNfnudWf7sGVWjiVmx56T6qdlnNHwl
	 MJ6lvA1Txo2VkTukkFBHh6sAvYkYeAS2Iwy0t6WkstMhQnG07XUSRthy3lMNczJVvF
	 hkzNrVYpJ2s2fiZot/hSUWnGDu++sORyufVUjbE8BGmzP5iIZlhvLC87D1Mzw7ZPXB
	 s9A9ivLK3VleUxMYLgwsm8CWl8WuNIV40BJTUAUx3hRS2605MbWEebA8IThpjAK/D7
	 b1FVNU2oXs0FQ==
Date: Wed, 12 Feb 2025 10:39:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 1/7] net: ethtool: prevent flow steering to RSS
 contexts which don't exist
Message-ID: <20250212103929.5363f2cf@kernel.org>
In-Reply-To: <de4a2a8a-1eb9-4fa8-af87-7526e58218e9@nvidia.com>
References: <20250206235334.1425329-1-kuba@kernel.org>
	<20250206235334.1425329-2-kuba@kernel.org>
	<de4a2a8a-1eb9-4fa8-af87-7526e58218e9@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 10:17:30 +0200 Gal Pressman wrote:
> >  	/* Nonzero ring with RSS only makes sense if NIC adds them together */  
> 
> This comment should be moved inside the if statement.

Will follow up, sorry.

> > -	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS &&
> > -	    !ops->cap_rss_rxnfc_adds &&
> > -	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
> > -		return -EINVAL;
> > +	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS) {
> > +		if (!ops->cap_rss_rxnfc_adds &&
> > +		    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
> > +			return -EINVAL;
> > +
> > +		if (!xa_load(&dev->ethtool->rss_ctx, info.rss_context))  
> 
> Accessing rss_ctx without rss_lock?

Yes, same as ethtool_get_max_rxnfc_channel(). Since we'd have to drop
the lock instantly after the check the whole rule addition wouldn't 
be atomic under that lock, anyway. IOW the xa_load() access is safe
in itself, and I couldn't think of practical use for taking the rss
lock.

