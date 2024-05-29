Return-Path: <netdev+bounces-99120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E6F8D3BD9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA82E1F249CA
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5532F181D1D;
	Wed, 29 May 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nOkzWmVk"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C9417DE14;
	Wed, 29 May 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998765; cv=none; b=hCf5BRdB+VZfJbqeElApTHhZdUQBv6KPlhvKL+OmmXD29Uy53/PZlIMiwzkckhWYu+xxSDzeHLAeD/ZjUuGrjKstl0jgn6f9Aoc57uHkTkYZNEnsa2nXS32r7ysEtSPmWP/S6Z0FQJPSahuw924o+L9wG5gDTjsz8hbL/5DluEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998765; c=relaxed/simple;
	bh=CK8OAPbBbXSoOWPUjOyns04q5VfwYNuBKWySKS482EI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsyGa+U7oIRuQ3/oSY8hvrlZy2k6LiZqsFpLHQfyeaOnbL9xIkgMsiTw85+1lZKvyEwP9U0/6DdASwgflVvKqmgGKtYPU5KUQolXDuxlPrClTukM5DHldASN3dCLZOGakx5jMeqaTY1RNBjsdIHzQCjkcDbnzpVbPAoKHWXGViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nOkzWmVk; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84BBB60005;
	Wed, 29 May 2024 16:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716998759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=seDn1vi/ugGwlftgDNRlK7URLt36H1AKmJnfJmt6SmQ=;
	b=nOkzWmVkHiv5suXZbHQNJKWlM24kofPWPIRmyjduQrM9+ukK4C/yJY9l0/nTT0dAU1ZrSl
	OCcAcu3TnwA2iohmkJfkHAHcrVGPo97acCokRvBoUlVyhPBcFnwaZsOxfex4pbuXyEMEO1
	Pz27VosTUyOwdWuC3djd10lUeGrLSJl5NwKpV7aweNF3QdS3ciYHigwbFo02TRw8TuXV0P
	Bebp65AInAGdRbwoECQOrz8yMmd+11GkyShRCaY8Q3BsgJMBmWAvGZ1vLlhO3YKyM5uwxa
	ongV+jkwxhSJUEJesYbgzFLhN5aC+IedJBJIK+hf54hqHAncfw3qGyubDfgm7g==
Date: Wed, 29 May 2024 18:05:56 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v13 09/14] net: Add the possibility to support
 a selected hwtstamp in netdevice
Message-ID: <20240529180556.0e500675@windsurf>
In-Reply-To: <20240529175032.54070c60@kmaincent-XPS-13-7390>
References: <20240529-feature_ptp_netnext-v13-0-6eda4d40fa4f@bootlin.com>
	<20240529-feature_ptp_netnext-v13-9-6eda4d40fa4f@bootlin.com>
	<20240529082111.1a1cbf1e@kernel.org>
	<20240529175032.54070c60@kmaincent-XPS-13-7390>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.petazzoni@bootlin.com

On Wed, 29 May 2024 17:50:32 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> > ERROR: modpost: "ptp_clock_phydev" [drivers/net/phy/libphy.ko] undefined!  
> 
> Thanks for the report.
> Weird, it should be in builtin code.

Right, but you don't have an EXPORT_SYMBOL() for it, as far as I can see.

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com

