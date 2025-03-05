Return-Path: <netdev+bounces-172100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62358A50387
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5735188B858
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AC91F5826;
	Wed,  5 Mar 2025 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rf/yN6+y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21E17BEC5
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188795; cv=none; b=SgPw8FX9ia9Kx2hjIHi5kKbpmb5xPf6H8eeKb0W+pgTd9yahOYLzTZDDbKH/nWlXKG7ypnTvIjhe58fuc2l3kndBimat7vl/RSCyfR2EbubB6oWMeTMNTh6MD3K6NRh9GxRiRsJnAXASIJrC5apiZTcPNWjvMKHXIhDH7olH6YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188795; c=relaxed/simple;
	bh=56NXGmtfQIYu6chK0Z2PSnPTGZHHuUotuG/Yx3BJrTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMnMaijCuwXk+GAM5mnPCt6PaObMw7ddkJbyXvLgdzl23jz3WwJ3UY0Sy0GYu63wcI4DqDz1ehCerbMwyrPf3X8JO4BcWTTn7ktc6ztr1HLyHjbVSgcO0ZR+eYUPmIHer4+FnBJ6+DSUGIdVxDunz3Bcb9spn50V7JDrnGnulC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Rf/yN6+y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0gDZLXtenXxHvyrOE4AuqysM9n6G5TRZFIcIdc1eMBc=; b=Rf/yN6+ybNiKu2n64wsB4A8L0Q
	Dt2fwxCnaI56Vf6/4/O5UYnwU4k7IXYVC3WWo40chiesMN+JkQzdDpvdPg/R7Dmcp/P6Ent/6Szza
	kAHl1V/+NDibA3T/PWaI6W1gJei0noUYQuU5wQgEpqa93vEmBEfDDiomzavbLeB+hqhc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpqkA-002W9v-C6; Wed, 05 Mar 2025 16:33:10 +0100
Date: Wed, 5 Mar 2025 16:33:10 +0100
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
Message-ID: <89b4ceae-c2c8-4a7b-9f1b-39b6bce17d34@lunn.ch>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-5-darinzon@amazon.com>
 <21fe01f0-7882-46b8-8e7c-8884f4e803f6@lunn.ch>
 <20250304145857.61a3bd6e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304145857.61a3bd6e@kernel.org>

On Tue, Mar 04, 2025 at 02:58:57PM -0800, Jakub Kicinski wrote:
> On Tue, 4 Mar 2025 22:07:39 +0100 Andrew Lunn wrote:
> > I've not been following previous versions of this patch, so i could be
> > repeating questions already asked....
> > 
> > ena_adapter represents a netdev?
> > 
> > /* adapter specific private data structure */
> > struct ena_adapter {
> > 	struct ena_com_dev *ena_dev;
> > 	/* OS defined structs */
> > 	struct net_device *netdev;
> > 
> > So why are you not using the usual statistics interface for a netdev?
> 
> I asked them to do this.
> They are using a PTP device as a pure clock. The netdev doesn't support
> any HW timestamping, so none of the stats are related to packets.

So how intertwined is the PHC with the network device? Can it be
separated into a different driver? Moved into drivers/ptp?

We have already been asked if this means network drivers can be
configured via sysfs. Clearly we don't want that, so we want to get
this code out of drivers/net if possible.

	Andrew

