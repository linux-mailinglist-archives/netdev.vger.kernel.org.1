Return-Path: <netdev+bounces-216469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40665B33F2C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539FB1A8220D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2B91482E8;
	Mon, 25 Aug 2025 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1bbrj53F"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4AC72639;
	Mon, 25 Aug 2025 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124319; cv=none; b=TxA8X8iO1ZzWVugSsKk0nT2pVaL5z2FNNhByhLqAUeKaIB15Jy89Q0QmRduffXM+I+VL5CfdFaQ4icuw/9HFUe878obM4uVemMBDGiTqZY5L/86bmuLQJwCeckijqWNcyx15zgl6zmavQrRxYeUBw+G5J31zyaqM3cg6SXPCMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124319; c=relaxed/simple;
	bh=M0pDfGH7FaVEP+YSqPwNfp8XXrPzugzum9BDhZdsdv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8mWlHQWCyyu3BUMuB5743vDohAtFrwl6guOyLudcg7+0PV0Wfin6ZvO5PK/JVZZGdzt+By6zFcBXpHK78ui3BkcD7fgI5SV8KirwnyG+67SrC46s5+TOSLdDdQjbq3WMZEd3xd0sBSZSYttZIG4zeBNF9khlOCezowZZnrK9NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1bbrj53F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=woWbdSWv2hCeQ8dbDxzkAVy11qYfSWwmpcaisbchnWg=; b=1bbrj53Fmarp8+/CEKiUfQOSwM
	GXO0JUBvX2BHOKUwy7xRRBsBcR8nMyKneTmPlIpFyV/bERqZAZ1PI5qEsSMTOvkPVLP5d3qHO6Qu4
	o6zUqEWrxtEl0C3rl2fl6p8QTvXcsiIFv28KDI8M7VOPXFS+hcKg11anWA3OtgLPdzfc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqW9Z-005wEl-KX; Mon, 25 Aug 2025 14:18:25 +0200
Date: Mon, 25 Aug 2025 14:18:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de,
	Dent Project <dentproject@linuxfoundation.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: pd692x0: Add sysfs interface
 for configuration save/reset
Message-ID: <6317ad1e-7507-4a61-92d0-865c52736b1a@lunn.ch>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
 <20250822-feature_poe_permanent_conf-v1-2-dcd41290254d@bootlin.com>
 <d4bc2c95-7e25-4d76-994f-b68f1ead8119@lunn.ch>
 <20250825104721.28f127a2@kmaincent-XPS-13-7390>
 <aKwpW-c-nZidEBe0@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKwpW-c-nZidEBe0@pengutronix.de>

On Mon, Aug 25, 2025 at 11:14:03AM +0200, Oleksij Rempel wrote:
> Hello Kory,
> 
> On Mon, Aug 25, 2025 at 10:47:21AM +0200, Kory Maincent wrote:
> > > I've not looked at the sysfs documentation. Are there other examples
> > > of such a property?
> > 
> > Not sure for that particular save/reset configuration case.
> > Have you another implementation idea in mind?
> 
> My personal preference would be to use devlink (netlink based)
> interface.

Yes, devlink also crossed my mind, probably devlink params. Although
saving the current configuration to non-volatile memory is more a meta
parameter.

	Andrew


