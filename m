Return-Path: <netdev+bounces-243450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB882CA1855
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 21:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A8363006A7D
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228BB29BDBD;
	Wed,  3 Dec 2025 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+N2dYNd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2CB21CC5B;
	Wed,  3 Dec 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764792567; cv=none; b=dZp0uMeLRKM3zllZ0VYG/rwfjXnqlEAfeIoV4LCbE5M+L0RfYsILoAiNE1lOIWmUGnZAcIgmqyWJ6XSPDMdO7D2t91QReXZXtsy3fQYxqvfImsVUdNR8pQ90vY1iNL67ypeSIGgViF0I2aJ2HzpX3Ig4iI3a/Mfc/UsRjhjIggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764792567; c=relaxed/simple;
	bh=Tkpa3ZDNlIFMTNN72l1+UBz8f+B42zjoI6nZRZ7cyAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrRkLd6U4gcTCpcx/jkuxySFgP2A2KdTglf9m062jOm5to/q5VC+vbGBwaOepLdFIzeh0YFa2wd8TwQHyKw9sAJNPxGTtn7ntT2OxMUnPFVeqgRcMyGXq0jO+Aft/HxcHipvlucxM0P8TcgwOxwycL0HWyPanQTYDTMDvG3CcR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+N2dYNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48219C4CEF5;
	Wed,  3 Dec 2025 20:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764792566;
	bh=Tkpa3ZDNlIFMTNN72l1+UBz8f+B42zjoI6nZRZ7cyAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+N2dYNdWknkStyxm2NNptErFpk/W5s8hw2mcAx/uGf5oIDOSdqrb7iPzz1cO3+9W
	 or1w2Ay27WCW76L84UTmg9Me4TgoZMy035CPJdigK3FVdQRS6MhC6swbsLfcmX320R
	 JoEAf7Xugy4vs7Asx5VNgPGbKBh43kNyP2a7CeqmhhnNxxbYG5a9rwcHLda99OlQfJ
	 s7ijNGRSr4IwykLUu0KVyvWJYm5Z9OOl9M9SULx3XJyFiNDuGORTIx/6HdvjrK3nfS
	 P1c2IKeC8pprirIb15cn16JfFFcLEncjPQekCBDdNfA+ZnzxkjYsA0VVt3zCDbzpAq
	 IVZymug4blqgw==
Date: Wed, 3 Dec 2025 20:09:21 +0000
From: Simon Horman <horms@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
	Chris Mason <clm@meta.com>
Subject: Re: [PATCH net-next v13 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <aTCY8ZlV8Zw8_7FD@horms.kernel.org>
References: <20251126193539.7791-1-danielj@nvidia.com>
 <20251126193539.7791-12-danielj@nvidia.com>
 <aS8L--z0ezhkywT_@horms.kernel.org>
 <20251203083305-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203083305-mutt-send-email-mst@kernel.org>

+ Chris

On Wed, Dec 03, 2025 at 08:33:53AM -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 02, 2025 at 03:55:39PM +0000, Simon Horman wrote:
> > On Wed, Nov 26, 2025 at 01:35:38PM -0600, Daniel Jurgens wrote:
> > 
> > ...
> > 
> > > @@ -6005,6 +6085,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> > >  		mask->tos = l3_mask->tos;
> > >  		key->tos = l3_val->tos;
> > >  	}
> > > +
> > > +	if (l3_mask->proto) {
> > > +		mask->protocol = l3_mask->proto;
> > > +		key->protocol = l3_val->proto;
> > > +	}
> > >  }
> > 
> > Hi Daniel,
> > 
> > Claude Code with review-prompts flags an issue here,
> > which I can't convince myself is not the case.
> > 
> > If parse_ip4() is called for a IP_USER_FLOW, which use ethtool_usrip4_spec,
> > as does this function, then all is well.
> > 
> > However, it seems that it may also be called for TCP_V4_FLOW and UDP_V4_FLOW
> > flows, in which case accessing .proto will overrun the mask and key which
> > are actually struct ethtool_tcpip4_spec.
> > 
> > https://netdev-ai.bots.linux.dev/ai-review.html?id=51d97b85-5ca3-4cb8-a96a-0d6eab5e7196#patch-10
> 
> 
> Oh I didn't know about this one. Is there any data on how does it work?
> Which model/prompt/etc?

Hi Michael,

I believe these prompts are used:

https://github.com/masoncl/review-prompts/

...

