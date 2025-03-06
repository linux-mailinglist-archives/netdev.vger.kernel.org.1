Return-Path: <netdev+bounces-172320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A194A5436F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F9718952EA
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D3D1A83EE;
	Thu,  6 Mar 2025 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+fze49d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7011A2567
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245317; cv=none; b=geLknsc1Ttf6Llzi299H7jQ3apaUJZicmdFlAuVVDy68lgHYccaLpgSOQhY5L9FTCyuYGyXE1k1pOMn7upXYCyLk1kSi38LW5jSKMHiB6kGMrsTxQ2f98hwivLh267zTE1VCz5WmxKqkVl5mOxvk0fol4is//T+3QRGjDLwKCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245317; c=relaxed/simple;
	bh=R4RmrGbauNXthzQkd+yMXMqsfyZpAbM9F5rByWS0Pss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/p7FlFkzv67gtCpJGoSi1g8eYX9wFgsmTVpobbdgIZXqctM+pDGP/tbV7vspfViMhjIWX3mrimiWwdf9ldKT2foqZu8MHx6GjXPLsWJ4v+a1pRQF2QyAY3ZOVFWrafYF8NEJ0ZveExuR6SDYIG2bXngpG9vxOrEO08rOE4eLnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+fze49d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC43C4CEE8;
	Thu,  6 Mar 2025 07:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741245316;
	bh=R4RmrGbauNXthzQkd+yMXMqsfyZpAbM9F5rByWS0Pss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+fze49dvw+jNnRPdfpRKAouWpMfPLXS6rY6sovexKJYJMVcoTGPvL2jvJAxxS39H
	 5LrgmDw/veg/xdtHeso6MP6qIW46X8CIyoz1Usq8kwidLdMKG5zK1qZfdlKjIjZTGG
	 xbZQ0QDJx8mQDREeaUKXJ3LWue+TWC9H9OYXSjth7d55YXKyeXs/i1l1/C+TZCClds
	 imESrxFZu4s8ie7+kQ1swz01lUCoN/80/euvXA+jMla6Q/xuJYyKg4zFh3OMom48+V
	 xbtGCJBGP6QFYWGU1cOeUURK0AmbWhC5pqI5GTwNHR6/lWtcQLGi368nRucXNXZ1J5
	 tksVa4QDsLkJg==
Date: Thu, 6 Mar 2025 09:15:11 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, David Arinzon <darinzon@amazon.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v8 net-next 4/5] net: ena: PHC stats through sysfs
Message-ID: <20250306071511.GP1955273@unreal>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-5-darinzon@amazon.com>
 <21fe01f0-7882-46b8-8e7c-8884f4e803f6@lunn.ch>
 <20250304145857.61a3bd6e@kernel.org>
 <89b4ceae-c2c8-4a7b-9f1b-39b6bce17d34@lunn.ch>
 <20250305183637.2e0f6a9f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305183637.2e0f6a9f@kernel.org>

On Wed, Mar 05, 2025 at 06:36:37PM -0800, Jakub Kicinski wrote:
> On Wed, 5 Mar 2025 16:33:10 +0100 Andrew Lunn wrote:
> > > I asked them to do this.
> > > They are using a PTP device as a pure clock. The netdev doesn't support
> > > any HW timestamping, so none of the stats are related to packets.  
> > 
> > So how intertwined is the PHC with the network device? Can it be
> > separated into a different driver? Moved into drivers/ptp?
> > 
> > We have already been asked if this means network drivers can be
> > configured via sysfs. Clearly we don't want that, so we want to get
> > this code out of drivers/net if possible.
> 
> Is it good enough to move the relevant code to a ptp/ or phc/ dir
> under ...thernet/amazon/ena/ ? Moving it to ptp/ proper would require
> some weird abstractions, not sure if it's warranted? 

In normal world, where linux kernel driver model is respected, one will write
separate driver for PTP and place it under drivers/ptp. This current series
doesn't belong to netdev at all.

Thanks

> 

