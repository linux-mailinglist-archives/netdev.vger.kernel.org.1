Return-Path: <netdev+bounces-102337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ECC90281C
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4611A1F23674
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6E014900C;
	Mon, 10 Jun 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beB7Leg9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370614884F;
	Mon, 10 Jun 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042239; cv=none; b=JaC6nY4a4gunl1AYhwLnFTWTT0MmwO8bL1CGqbPj8DOaMRfhEMQNeb58/DUuJMUv4YVuqoAW0w7yjw2zsHGV98pyFzHK70MuFUdMH2mzCjc1Ldq9UJd3PE7jlrrnUvrssvl+FeR9WteBuZAn0BfCC7U8Qpq55twDfL3aceS+op0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042239; c=relaxed/simple;
	bh=GZC/MhALX/ksEhs5BxScLGoQ+046shv8SpsC0EqMARY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGpN2MOtKMC/SWM7/3atywKVYgjT5CSGsQdsNYBwTRhlsX679l4U7vlvJqm0f3Dhh6mChcLI8Yd8/Aonqzw6BgbVSewaFR+W7UoZYOg/ocgZNqD0+QaqDp5qxkkv8P+Urf/Ml9K3/Mmy7Akx1sBOO8MUE3T/7ArZz3GUJWiiaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beB7Leg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF3BC2BBFC;
	Mon, 10 Jun 2024 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718042238;
	bh=GZC/MhALX/ksEhs5BxScLGoQ+046shv8SpsC0EqMARY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=beB7Leg9SzkHdfN7Z2QeocrQ2JIiqE5Ycn2YNDrMMgxdSGYqIhmZEaWcr6MiuQQ6Z
	 lg2buWpJPgyaG5gwAak0YNTpIt+C/4TZ3QnyV20KYtBlC3tSnDUMhH6TyqqSWfuIjX
	 PM3hSRL8TYzLvdceUAiclepegzIQDwa6sXlz8BIQsYUkU6HEyNc1bqweN5zrQoPnBv
	 vNVwuYzH4/8Bnuve/6zkzmhMgsYwABjRFQuYAIdJB/lXjllPlY9gJhwtMQeIPPKYzE
	 Cd7RbUVf4LOJlKUepZLNN5BXHlOx1U0Ev3zQ7Yif7+b4q5rrUdZYqbc/WFVvzyl2qH
	 RHGOeZesWwDXw==
Date: Mon, 10 Jun 2024 10:57:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Dan Jurgens <danielj@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
 <xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240610105717.7fbb1caa@kernel.org>
In-Reply-To: <CAL+tcoDkpZva=aStFKWTO6_8VK2iu9CeSeW2aeC+2QTXR2nD=Q@mail.gmail.com>
References: <20240130142521.18593-1-danielj@nvidia.com>
	<20240130095645-mutt-send-email-mst@kernel.org>
	<CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<20240130104107-mutt-send-email-mst@kernel.org>
	<CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<20240130105246-mutt-send-email-mst@kernel.org>
	<CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
	<20240201202106.25d6dc93@kernel.org>
	<CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
	<20240202080126.72598eef@kernel.org>
	<CH0PR12MB858044D0E5AB3AC651AE0987C9422@CH0PR12MB8580.namprd12.prod.outlook.com>
	<CAL+tcoBXB97rCp2ghvVGkZAuC+2a4mnMnjsywRLK+nL0+n+s2A@mail.gmail.com>
	<CH0PR12MB85804D451A889448D3427132C9FB2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<CAL+tcoDkpZva=aStFKWTO6_8VK2iu9CeSeW2aeC+2QTXR2nD=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Jun 2024 08:41:44 +0800 Jason Xing wrote:
> > > Sorry to revive this thread. I wonder why not use this patch like mlnx driver
> > > does instead of adding statistics into the yaml file? Are we gradually using or
> > > adding more fields into the yaml file to replace the 'ethtool -S' command?
> > >  
> >
> > It's trivial to have the stats in ethtool as well. But I noticed
> > the stats series intentionally removed some stats from ethtool. So
> > I didn't put it both places.  
> 
> Thank you for the reply. I thought there was some particular reason
> :-)

Yes, we don't want duplication. We have a long standing (and
documented) policy against duplicating normal stats in custom stat
APIs, otherwise vendors pile everything into the custom stats.

