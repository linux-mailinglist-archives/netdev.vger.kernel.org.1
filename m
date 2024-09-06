Return-Path: <netdev+bounces-126009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB8E96F90C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 18:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57798285921
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5731B1D365D;
	Fri,  6 Sep 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LxkFVC/c"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A2A1D0496;
	Fri,  6 Sep 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639082; cv=none; b=uJfOqeShAj8pe2xUQ8zMfgB25hzkeGbTQGv64z5HpaWpudD+kc7MYkB/UdqM75KIKFmFFha4tz5NHFBxlC5FxCBD6GTp5uZjsAQk0iRM01ob1urQkKGBUuPmoFhXtbHf53WH+3zNJZegelfy85m3t3CaCReRrts28KkdeiJ3Jfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639082; c=relaxed/simple;
	bh=5vz75h1/GiMmeUcEyJMnBZgtNnvg5MEjTECmV0PW1Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJbhYHAz3pfR8aMPT9I/SJRt7iPN8sT1iNUoBcf0ldDSAqi/vgxhXBTciYL0mVuPFQVBWA9IPnHJFgd8RiCnRwWY3IqAPId1okHAghvMNVlbChcDKp3oq8l3k4jtjhejU9BB1yrvCz/OVloPzBN2YICDRjDg8ynfRNK3R8Sstc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LxkFVC/c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CMRPbNPaGuvjB3ufaJfCswX417vVrfg/cRPMziQD1og=; b=LxkFVC/cLRlsFJeSVOG6YPZIHH
	QgZeTcU9ZI4KuWV9ULo1IQ/qLRB/iazdbbvh+ERpyRWuULqHsm8scVvOsf1GVku+jbDl8UHt5J2dZ
	UVEDnGNqFsX3GnUKaSuu3bNEKaWYQ1xMddqXCXq+qMTJnDzuL1MS4QSRUmr6a7JiAtn4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smbYF-006qLw-EG; Fri, 06 Sep 2024 18:11:11 +0200
Date: Fri, 6 Sep 2024 18:11:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: net: ethernet-phy: Add
 forced-master/slave properties for SPE PHYs
Message-ID: <fde0f28d-3147-4a69-8be5-98e1d578a133@lunn.ch>
References: <20240906144905.591508-1-o.rempel@pengutronix.de>
 <c08ac9b7-08e1-4cde-979c-ed66d4a252f1@lunn.ch>
 <20240906175430.389cf208@device-28.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906175430.389cf208@device-28.home>

> > 10Base-T1 often does not have autoneg, so preferred-master &
> > preferred-slave make non sense in this context, but i wounder if
> > somebody will want these later. An Ethernet switch is generally
> > preferred-master for example, but the client is preferred-slave.
> > 
> > Maybe make the property a string with supported values 'forced-master'
> > and 'forced-slave', leaving it open for the other two to be added
> > later.
> 
> My two cents, don't take it as a nack or any strong disagreement, my
> experience with SPE is still limited. I agree that for SPE, it's
> required that PHYs get their role assigned as early as possible,
> otherwise the link can't establish. I don't see any other place but DT
> to put that info, as this would be required for say, booting over the
> network. This to me falls under 'HW representation', as we could do the
> same with straps.
> 
> However for preferred-master / preferred-slave, wouldn't we be crossing
> the blurry line of "HW description => system configuration in the DT" ?

Yes, we are somewhere near the blurry line. This is why i gave the
example of an Ethernet switch, vs a client. Again, it could be done
with straps, so following your argument, it could be considered HW
representation. But if it is set wrong, it probably does not matter,
auto-neg should still work. Except for a very small number of PHYs
whos random numbers are not random...

But this is also something we don't actually need to resolve now. The
design allows for it, but we don't really need to decided if it is
acceptable until somebody actually posts a patch.

	Andrew

