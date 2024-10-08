Return-Path: <netdev+bounces-133209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AF39954DD
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2CC1F22CE5
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F1B1E0DD0;
	Tue,  8 Oct 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DcLvbgT9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C461DF99E;
	Tue,  8 Oct 2024 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406239; cv=none; b=Py0VwS74oXuLqzUd0d5VQpQdGLsKw+y+cmexq29Pn8hBrtlGq7wO/Rc7gHSDt7zLu0DY/FPyd+8ZC92MiwoeGGt7WeU4wdEESxwwC6F1o32JAR+yzdsnfqxsfQBJDCJ+6jj08R2Jk4krctzACvBWK8YL2Rc5t1Z1BkOkmaSKK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406239; c=relaxed/simple;
	bh=BgyXmf6zEyxkxO+cjJxaCCtJenDh4Xbm3I5QIsbwQHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRGEs6iCPLUK7BkyJx0Jjfq2hZjH6H+HSe/aT1BcAl1fCr6kksjAXD27u1ygTkAP+H5cHrCtjkhlegU/b379D5PG6ioPaS2mj5QFDDRXD8BCT7JLIOYDWIaycj5m/m8SQvNuNsS+ALjerSfCaVFKZaZ+mZ6TluB9CdYgcd5A5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DcLvbgT9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Sl2qPQjpGBKxhwKX5wyycG+e5KNisfELcsljXkGSeJc=; b=Dc
	LvbgT9s4djJwtGwzAdCH4C3LJ6B/aZTMxjwo1myzJe0XNNSXry0TcmmA1MO9g8xGWdshpd2qVj+Jx
	2Q0xxVbXpvKeDPgK7pcfmD/By6jETeJvQaMgOiflE7K9kkYzkbzrPIa3tSkKYznxxFrCAE+YQIdBB
	Gt9BF2uUrYGwX64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syDPl-009OSd-L1; Tue, 08 Oct 2024 18:50:25 +0200
Date: Tue, 8 Oct 2024 18:50:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 08/12] net: pse-pd: pd692x0: Add support for PSE
 PI priority feature
Message-ID: <9c77d97e-6494-4f86-9510-498d93156788@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-8-787054f74ed5@bootlin.com>
 <1e9cdab6-f15e-4569-9c71-eb540e94b2fe@lunn.ch>
 <ZwU6QuGSbWF36hhF@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwU6QuGSbWF36hhF@pengutronix.de>

On Tue, Oct 08, 2024 at 03:57:22PM +0200, Oleksij Rempel wrote:
> On Thu, Oct 03, 2024 at 01:41:02AM +0200, Andrew Lunn wrote:
> > > +	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
> > > +	msg.sub[2] = id;
> > > +	/* Controller priority from 1 to 3 */
> > > +	msg.data[4] = prio + 1;
> > 
> > Does 0 have a meaning? It just seems an odd design if it does not.
> 
> 0 is not documented. But there are sub-priority which are not directly
> configured by user, but affect the system behavior.
> 
> Priority#: Critical – 1; high – 2; low – 3
>  For ports with the same priority, the PoE Controller sets the
>  sub-priority according to the logic port number. (Lower number gets
>  higher priority).

With less priorities than ports, there is always going to be something
like this.

> 
> Port priority affects:
> 1. Power-up order: After a reset, the ports are powered up according to
>  their priority, highest to lowest, highest priority will power up first.
> 2. Shutdown order: When exceeding the power budget, lowest priority
>  ports will turn off first.
> 
> Should we return sub priorities on the prio get request?

I should be optional, since we might not actually know what a
particular device is doing. It could pick at random, it could pick a
port which is consuming just enough to cover the shortfall if it was
turned off, it could pick the highest consumer of the lowest priority
etc. Some of these conditions are not going to be easy to describe
even if we do know it.

	Andrew

