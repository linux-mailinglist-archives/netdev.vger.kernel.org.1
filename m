Return-Path: <netdev+bounces-110860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1C92EA0C
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513E6B20DE1
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BC615FD01;
	Thu, 11 Jul 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c898+ChK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314015F3E0;
	Thu, 11 Jul 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706273; cv=none; b=TENYEW9gWRxwuU6L56dsMNpstWW2SMS8+NUp9tLCczvd0W/EQccVvbfzQ78ZXeQYkusLMWDRTMdfN+LwkzPVjT9GujO3NYmwn6cou3q4Mbc2BBd8QGW6Wx812z/gMe7DWSFr7PAlPg3J5IDe0xEvO3l3rhHQ2c7Z9oRe9v6HhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706273; c=relaxed/simple;
	bh=FHjXagEOOatSTXHhRfY7EqmXYum8oi62qXxXqpjMlDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXqwFcMjAYkcTMZRZ77lxan7cx6OZJFEEMuky/M/rb5vhJRR1YJrDILLpwYDumZ0vF5gIQ2IGcSfmdqnv6aSPCa4SbbH3mVNGrkObUzwPckBxiT+/VGXH4mEzh+33wdVdRUMYhVjAqYF38V+0Lpb1zHcRSvdOe0iIyAg2hNn4HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c898+ChK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fl5kx1AxQh8VD4yRJOY5bQMMZzHh+JbSzPl/YALeKdY=; b=c898+ChKR6Hz9ZFTBjyIOPuwEG
	BldMiz/OukbdVJJ3ar56/30vBPMUdKjT1/xx9zLVoOVcO69JEcMYbjVERODW0CghjSBeMclNiyKSm
	LZnFW6yt/Kjkf6SNmjTUQfalWcBLqeYD7katX9IzaDyYK37N66ksYqeiWiC8L9M0by8w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sRuIn-002K0F-RA; Thu, 11 Jul 2024 15:57:41 +0200
Date: Thu, 11 Jul 2024 15:57:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 1/2] net: pse-pd: Do not return EOPNOSUPP if config is
 null
Message-ID: <45632fed-1669-4d75-bdcd-16d79275e50e@lunn.ch>
References: <20240710114232.257190-1-kory.maincent@bootlin.com>
 <20240711084300.GA8788@kernel.org>
 <20240711105326.1a5b6b0b@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711105326.1a5b6b0b@kmaincent-XPS-13-7390>

> > 1. As fixes, with fixes tags (good!), this patchset seems like it is
> >    appropriate for net rather than net-next. And indeed it applies
> >    to net but not net-next. However, the absence of a target tree
> >    confuses our CI which failed to apply the patchset to net-next.
> > 
> >    Probably this means it should be reposted, targeted at net.
> > 
> >    Subject: [Patch v3 net x/y] ...
> > 
> >    See: https://docs.kernel.org/process/maintainer-netdev.html
> 
> Oops indeed sorry, forgot to add the net prefix.

B4 is nice with this:

b4 prep --set-prefixes net

And it should then remember for all versions of the patchset.

    Andrew

