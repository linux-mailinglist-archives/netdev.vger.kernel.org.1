Return-Path: <netdev+bounces-140813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4739B854E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9690DB20CEB
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 21:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8B1CB521;
	Thu, 31 Oct 2024 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UEkYrWL7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436EC1C8FCF;
	Thu, 31 Oct 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410164; cv=none; b=KvYPB6CnH60cSjztDSfxO6ymtG9ZSqrXdLuu6dwaAvHZwB2sZ4YbyLu3aWbgcRHsIjoSlf9r/lwflwt0gQNbnE7fCKBGunX0aLguCDo9FwFl17TnXp9DbJ3YB8z7Krqz3/LpPKCaqA04CVtOj3BXGX9WEQexULF5MKGIEBlTU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410164; c=relaxed/simple;
	bh=BA7mKwb6fhLIyezq1tTdt6iVDL1a84xL9CmDyRMXGhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESXCwbGjlLuAjiYtsYff9WoTmOr1cXj9Fl3TT3NO2t35ZFFWYKcUVtaXdbwELaJAtDUKa0/tcmXhJrVmKriLLDYrpKv+/fVqs37n7gdazqP68zWn4BbHWQFjjHY5j4QI+wuFGBLM2WShgFveoijvdrFL10Q8JtFobzKYDJnY7Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UEkYrWL7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mS365H68vw5lonypZKzKALxD6gdEUDKqKwISeJ1jw4Q=; b=UEkYrWL7D2ruGGPOfNUmqYD9b3
	rBNsGr+ovflTpzYQjDhH6ALzZWY3Lrd8UgrpP6+NqjUfyqP2XfupXP+Vpz5YcVmZRciibRXV8Gh+2
	HNEXpmTEz+163n3s+9wr1Qw+vIRMXKq+GIrm0U3JVj8qrrHVqQnn1zQWa6aMEhxBjjCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6cj9-00BoxI-Sf; Thu, 31 Oct 2024 22:29:11 +0100
Date: Thu, 31 Oct 2024 22:29:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 06/18] net: ethtool: Add support for new
 PSE device index description
Message-ID: <bedeea0e-a64a-46e3-832e-aea51b09b459@lunn.ch>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
 <20241030-feature_poe_port_prio-v2-6-9559622ee47a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-feature_poe_port_prio-v2-6-9559622ee47a@bootlin.com>

On Wed, Oct 30, 2024 at 05:53:08PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add functionality to report the newly introduced PSE device index to
> the user, enabling better identification and management of PSE devices.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

