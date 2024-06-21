Return-Path: <netdev+bounces-105492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6B79117D3
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 03:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3760B22391
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 01:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DF9625;
	Fri, 21 Jun 2024 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1HQXEdj/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26831366
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718931606; cv=none; b=Tif61i+kdj2vUlADLtG/+Vo6mPvRinrlhq5Pk30StWssxTD+pNmEAr1IslmlGTfcf7LcfSTonZC2wBCuQwWD70quNxv6h3b66pOvOgn9EizLweYmZ5tae0diDMmMEKgQow6vx0V7lZEBBs0tJEUhbZ/5a6HMaYZjZqNykbNp3Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718931606; c=relaxed/simple;
	bh=kw+eYQGgRg4X0hD3h4SBKL6XwmV5lhqetLa0UTja7Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd1ZcALsIBw6U6HWlTPDDYhAfHXswET9d/GCTQX5LCqGpicD0A09fLJkauGvl51TwLTBfRuZVrlndv+yaACteA6zF1LsVzCD8XVJmpesksiKOGhK6s/IBn8H6SQW1T6nUty3W0Oim/79FpivTdJgZgT1LXxte0DRGvER4Nj54AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1HQXEdj/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DBrRMr4AzhInte/iq97K/G3WrlZxOzAO2VL2ZU5m+vI=; b=1HQXEdj//4wVAFk5gDACE7vu7E
	7bOog1lPykjzi9kCpb2+4GST8RtUNKqcZ+AwK/SoGWKWjNVhYOh13u433qFVx8ffMN5MWNWQyoLoI
	+pHH6tF2tPN6O6FbfVIcgqq4JGEqutQNVuwmOWiYsbjbc1TkUAtCHrI4FHt/oga0dHHY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKSd8-000cSG-5G; Fri, 21 Jun 2024 02:59:54 +0200
Date: Fri, 21 Jun 2024 02:59:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Ziwei Xiao <ziweixiao@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/6] net: ethtool: perform pm duties outside of
 rtnl lock
Message-ID: <48ac02dc-001e-48e3-ba87-8c4397bf7430@lunn.ch>
References: <20240620114711.777046-1-edumazet@google.com>
 <20240620114711.777046-4-edumazet@google.com>
 <20240620172235.6e6fd7a5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620172235.6e6fd7a5@kernel.org>

> I also keep wondering whether we shouldn't use this as an opportunity
> to introduce a "netdev instance lock". I think you mentioned we should
> move away from rtnl for locking ethtool and ndos since most drivers
> don't care at all about global state. Doing that is a huge project, 
> but maybe this is where we start?

Is there much benefit to the average system?

Embedded systems typically have 1 or 2 netdevs. Laptops, desktops and
the like have one, maybe two netdevs. VMs typically have one netdev.
So we are talking about high end switches with lots of ports and
servers hosting lots of VMs. So of the around 500 netdev drivers we
have, only maybe a dozen drivers would benefit?

It seems unlikely those 500 drivers will be reviewed and declared safe
to not take RTNL. So maybe a better way forward is that struct
ethtool_ops gains a flag indicating its ops can be called without
first talking RTNL. Somebody can then look at those dozen drivers, and
we leave the other 490 alone and don't need to worry about
regressions.

	Andrew

