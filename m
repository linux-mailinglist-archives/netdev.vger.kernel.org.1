Return-Path: <netdev+bounces-172281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F47A540BB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BFC1892D2D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 02:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AEC1624C7;
	Thu,  6 Mar 2025 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9HYCa7I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D51BE46
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228599; cv=none; b=mzgjx5LvacC2ipEt8unfO6NasyjGzgDz0TI8/YXniXU7tgBjPv3bCYnJkMSILJXeFfUL8Z5ekyFZHXV7oe273Vf18GQ8ihjGQ+YTRNbPhljoMaVg+r5N337/VPRcQdyaBgS17ODkvAYFF/iAEO1H8NeOWnqUVg1yMC0YZSItDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228599; c=relaxed/simple;
	bh=D0qc89t9gIi76dwLBdSLrDmIMozrmVL6e569T3Tqf/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GalSMV+ssE/75g/KN4mq3ZT1WwOllHAxPrp3GYLat7QsV3/mLG71vgTZ0deClOsylA5ij+OCjodNtfbBf4Ts+2SUFO4GzAzll89xBiq2E8NAd8Yr3AcXpOte0gI+IyaEAi5JiZSBHwHcxFKxs6LRqRzKQbzjkJGS4Qb6cGKVUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9HYCa7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B360C4CED1;
	Thu,  6 Mar 2025 02:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741228598;
	bh=D0qc89t9gIi76dwLBdSLrDmIMozrmVL6e569T3Tqf/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V9HYCa7IIIQODbpRjt2McKTn7g7gXviMlzbQ0ej3ZWMm/wS1mcT0XvtdkA76wAPJG
	 xtAJe9ixt9qg6M9WGK6kH14kssAIdRtW8JV9KfFCHGQHNZccgaiqmd+1vr8tOMMyC1
	 uoSw+sd5nS4pJuJaPj0ug7H0jfXYZOzVTIj/sPPLjvcfz054js4JQmeLpL+VVG8UJe
	 EqZjJgXf6z47sDwwV0tirxlw+M3wfSp4+SYJY0cg2om03dxwlBfss39YwimaCiNAr3
	 a79OgSh8MhImXY4CcuYff9XbRYEW90NzWdBR7m9pv350oVXTbk/QRSCYu8ShNJgiqC
	 IZDnEz46CVSBg==
Date: Wed, 5 Mar 2025 18:36:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>,
 "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
 <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
 <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
 "Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
 <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
 <amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v8 net-next 4/5] net: ena: PHC stats through sysfs
Message-ID: <20250305183637.2e0f6a9f@kernel.org>
In-Reply-To: <89b4ceae-c2c8-4a7b-9f1b-39b6bce17d34@lunn.ch>
References: <20250304190504.3743-1-darinzon@amazon.com>
	<20250304190504.3743-5-darinzon@amazon.com>
	<21fe01f0-7882-46b8-8e7c-8884f4e803f6@lunn.ch>
	<20250304145857.61a3bd6e@kernel.org>
	<89b4ceae-c2c8-4a7b-9f1b-39b6bce17d34@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 16:33:10 +0100 Andrew Lunn wrote:
> > I asked them to do this.
> > They are using a PTP device as a pure clock. The netdev doesn't support
> > any HW timestamping, so none of the stats are related to packets.  
> 
> So how intertwined is the PHC with the network device? Can it be
> separated into a different driver? Moved into drivers/ptp?
> 
> We have already been asked if this means network drivers can be
> configured via sysfs. Clearly we don't want that, so we want to get
> this code out of drivers/net if possible.

Is it good enough to move the relevant code to a ptp/ or phc/ dir
under ...thernet/amazon/ena/ ? Moving it to ptp/ proper would require
some weird abstractions, not sure if it's warranted? 

