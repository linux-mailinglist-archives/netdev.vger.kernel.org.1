Return-Path: <netdev+bounces-147855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1179DE6D5
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 14:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF168282623
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 13:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E3219E830;
	Fri, 29 Nov 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MXbyhe5A"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EAD19E826;
	Fri, 29 Nov 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885166; cv=none; b=QzHmCkpo1dLpZHu0ZJPtMK+IIBB+CymzDkrDV8mrlo//4yaaI/co2BlUrc91g5k/QVnyPlm+Z1Vmv0Y53FP5cK0hciEw+fmqWx7O964y1VhuGZWPnx1fanIb9hslcTJhv6uCuOkZVRTB7kTIMeSTgRD4WetlTwyilj0sDGg/K7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885166; c=relaxed/simple;
	bh=S8gYZA1lf0QfDrBwvaQjuVwwNCyxR9f+zhHMjMaL+KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMBeEqOWLPyduB+EsS+xfe16PpboPPPk+ZpVuQWwglNBdY+506ETc3p8LbA3Am7b9xl6rrA3kCmHwK+cAhm0tcC8McZwhklK0nbRYWhNRCEf28C9iTmD4Pg9f9lol3UVhQ3wAQxPYwKhiQ98jndIzQ0SaQ/9VXI9j6GC7dnh8ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MXbyhe5A; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD261240008;
	Fri, 29 Nov 2024 12:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732885161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6/gF1M4D5vI9QsQxw31ksKS61JRuGAPL5A9hcfPi0E=;
	b=MXbyhe5AePWsOTmc5MMa1I89c1AYBxclenJekWOkeahAg88uSpkU3kWaFkbEZsaten0dzD
	t6XPa2WWS5l6QtKA6ntIhGVFQGlQNuGTXG6EDJzEhFOFJUebVIqCDdVMJg9RnmB/r/NPxD
	lVJtkLMFK0J4upS/TH9kouky0TcmssP6mKYmFjauDh9fn8cgtQLY+gP0NCbng30k4Ei0WJ
	L5+fKyvfdv/lp0aG/pjEEM0Xcq4GoEc2II370J1CTfzJl6Bfm4+sXTJpHF5LJuWVgXyWzN
	f/hv1bjQrhem+97QSQMfS6ff3S16xTFjGeCz03TN+w/yJbroOFFUBl2fV8ZegQ==
Date: Fri, 29 Nov 2024 13:59:19 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: <Tristram.Ha@microchip.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
 <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port
 support to KSZ9477 switch
Message-ID: <20241129135919.57d59c90@fedora.home>
In-Reply-To: <20241109015633.82638-3-Tristram.Ha@microchip.com>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
	<20241109015633.82638-3-Tristram.Ha@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Tristram,

On Fri, 8 Nov 2024 17:56:33 -0800
<Tristram.Ha@microchip.com> wrote:

> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> connect, 1 for 1000BaseT/1000BaseX SFP, and 2 for 10/100/1000BaseT SFP.
> 
> SFP is typically used so the default is 1.  The driver can detect
> 10/100/1000BaseT SFP and change the mode to 2.  For direct connect the
> device tree can use fixed-link for the SGMII port as this link will
> never be disconnected.
> 
> The SGMII module can only support basic link status of the SFP, so the
> port can be simulated as having a regular internal PHY when SFP cage
> logic is not used.
> 
> One issue for the 1000BaseX SFP is there is no link down interrupt, so
> the driver has to use polling to detect link off when the link is up.
> 
> Note the SGMII interrupt cannot be masked in hardware.  Also the module
> is not reset when the switch is reset.  It is important to reset the
> module properly to make sure interrupt is not triggered prematurely.
> 
> A PCS driver for the SGMII port is added to accommodate the SFP cage
> logic used in the phylink code.  It is used to confirm the link is up
> and process the SGMII interrupt.

I'm currently working on a product on which I need the SGMII/1000BaseX
port to work on KSZ9477, so I gave that series a try.

I seems that this PCS is actually a Designware XPCS, reading the
registers 0x2/3 returns 0x7996ced0, which is the PHY id for the
Designware XPCS. Looking at the register definitions, they are
indeed very very similar. Andrew already pointed out that the SGMII
acccessors in the series (port_sgmii_r/w) look like C45 MDIO accessors.

So, you could move forward by implementing an mdio bus for the PCS with
the C45 accessors mentionned above, and then plumb that to the XPCS
driver with the xpcs_create_mdiodev(). I'm still figuring out if the
KSZ9477 needs some extra bits of configuration to get that port fully
operationnal though.

I'm currently integrating such a solution on a 6.6 kernel, I would be
very happy to test any further version of this patchset.

Thanks,

Maxime

