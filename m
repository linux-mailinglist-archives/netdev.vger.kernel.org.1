Return-Path: <netdev+bounces-172486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4EA54F57
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A039118851AD
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5D1A08A6;
	Thu,  6 Mar 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RXpJpZEb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9241714CF
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275662; cv=none; b=h9Zp+hiDjLPPviJdbtWv406q5cMegioSm8SgyeE37zb8eZXfmXFNPXHPDqhW+HpEsRBpmsGhefCPcsYefo+D9oJXOUGgEfMUtu+BANQZHR0zm+JM5aIlMulhyWI43g7X11iCGwvU50cnifk7XJVv4Lwkx+UfNhEHJdZ3PWJx9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275662; c=relaxed/simple;
	bh=ZQLuwbFhbi0smCrC2wfjjyR8VAPyLu4roSJBDhPRYEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQca8qnrdVMqq1HTjZKWcR3TeX++z/pSjub6U5BGPqxRcitE6YvtvvqsOXQRa1fubuWesTiclLcymDrDd8qTfdC8bB8UueKybtQTsDlvaZ0+4p630qz3/lOzePM661316Oo4sUgCZKQJfadm4D6OI1Vy69BMHIfvdBlGY+S0QXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RXpJpZEb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b87sEP6a0Gf2QToPUSiwklAqQDeMoHXu0wjio8Y2Ccs=; b=RXpJpZEbe6ZAf9qdE6rqf93TET
	7jQImFewncXzu5AmtAA7S3M1+f6eEtTQnvpCuSYVfORDd+smwEGvlZkIJTefB9YZ7oja5hF1DV4Q9
	mzMg4T//TAwmWSUzJNMZoZWto146Y84IgnWnyTgnwFsTjmUVpmxsBoKuqjQJ4dEA3LPU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqDLD-002qBX-I2; Thu, 06 Mar 2025 16:40:55 +0100
Date: Thu, 6 Mar 2025 16:40:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
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
Message-ID: <ed0fb5d8-5cd7-446a-9637-493224af4fb3@lunn.ch>
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

mtd devices have been doing this for decades. And the auxiliary bus
seems to be a reinvention of the mtd concepts.

As i said, it comes down to how intertwined the PHC is with the
network device.

	Andrew

