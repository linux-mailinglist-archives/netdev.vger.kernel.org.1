Return-Path: <netdev+bounces-198167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A32ADB76F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4B2167CD8
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E0028851B;
	Mon, 16 Jun 2025 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4Xka8YI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733F266B50;
	Mon, 16 Jun 2025 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750093020; cv=none; b=iB3++DjhEIOBUC1n2uGuO1fBLk4WsHDlKuMt66+dAZd04l24BUCZbCylMR32s9krJ/E+ZboNGgJLuaReCyLSFRhQoTzoI/YvXDyCQfdrmWwGEqKbDMzhY8PyMSwiIGUUCHcwK6lBpBrsa+1nD4m41q20J6WFoV/K5KexTwmSxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750093020; c=relaxed/simple;
	bh=Khzz5JdxVrHoZB8y+ap9I08Otfgug9OhgIRTN6KzQvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzOUXhYMkfVMD5GzeM1JHEvkULA6/oTMy7rBoljQgdPNA2OsjRqANXip8KJlDxnLyNRG/hYt82++EL/60H6BuiaGEjXL2ozpfUqHg8Xbd7kAaIA2wRPc3CFDAi9xVnOy0WLfty486+EsqpwvNFMir9yENOs5nn0CDDN/zXJq6Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4Xka8YI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36609C4CEEA;
	Mon, 16 Jun 2025 16:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750093020;
	bh=Khzz5JdxVrHoZB8y+ap9I08Otfgug9OhgIRTN6KzQvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G4Xka8YI6AbRnNR7ypeU8g7pkFWw3b45ZH3cUXjdeeFXg+MVqiT+bcCC7J00cnxkR
	 LVMI4z6KrU1W2k8gXxnTUJepeyukLDRnm85auZjGhgLnNZpPQgDFbaggjOGQe0gbob
	 2/UhLiMPHpMyuQUwNL2h1rVnwlgqLsZa4kxRAXYDQIwG/YCtnTwXFvDUylp5RTogvO
	 xQWJINri+TTqK0jHdjmhZpiTdAMpM732K9Dmz+qqa8GFSyng876viBigUbDhRNimWb
	 MLcHL7WzZ6uHcUW4TfiAFn4Sf/Em4JgXOYCopAmwawfxocpYKpaQAqCC/oh0eVy/XQ
	 N8xcNPehb2fwg==
Date: Mon, 16 Jun 2025 09:56:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v13 07/13] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250616095658.323847a9@kernel.org>
In-Reply-To: <20250616151437.221a4aef@kmaincent-XPS-13-7390>
References: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
	<20250610-feature_poe_port_prio-v13-7-c5edc16b9ee2@bootlin.com>
	<20250614123311.49c6bcbf@kernel.org>
	<20250616151437.221a4aef@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 15:14:37 +0200 Kory Maincent wrote:
> > On Tue, 10 Jun 2025 10:11:41 +0200 Kory Maincent wrote:  
> > > +static bool
> > > +pse_pi_is_admin_enable_not_applied(struct pse_controller_dev *pcdev,
> > > +				   int id)    
> > 
> > the only caller of this function seems to negate the return value:
> > 
> > drivers/net/pse-pd/pse_core.c:369:              if
> > (!pse_pi_is_admin_enable_not_applied(pcdev, i))
> > 
> > let's avoid the double negation ?  
> 
> I thought it was better for comprehension.
> If we inverse the behavior we would have a function name like that:
> pse_pi_is_admin_disable_not_detected_or_applied()
> 
> Do you have a better proposition?

Would pse_pi_is_admin_enable_pending() work?

