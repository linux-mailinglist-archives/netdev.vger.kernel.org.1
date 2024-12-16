Return-Path: <netdev+bounces-152202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FB79F3161
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EAD6163A6F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4C6204C0C;
	Mon, 16 Dec 2024 13:20:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B1204684
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355200; cv=none; b=TVoS8b0dCxXHSX2RDKwAjgEncN7v9SlFgOO0mj+SeCVbe+i8zIMRBBbMfdreNOKYO+3DGt1ZVmzf2nBUI2K6aGqU16CXXJvfSm3+N19MORUaoN9nLuSBGRmfZPedfhebkO/8JDF0ImaMn76dBWvfRcw566fAn+Kxm8Yb8630bZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355200; c=relaxed/simple;
	bh=l5YhrR+CX9lbYsE/9OheTAC/N4CRxTnq2ihla+kxOiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mso1xf5XCfq4wV+hmyuGS9lScPGjIK8S4YvnJ1J7pnMmhcNQVwNYC71VYVzP7sSe7P4dF1fqAUgsVEgpKFgxR/A2Tkn31Ljr5eM8Hb05w1k5zQIF7o5ux0GcFHx+0RDD+41HmFQLl7QbHKIEgy3x+n9X94LQTm59CYmjn/YsWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tNB0m-0000Fi-Fk; Mon, 16 Dec 2024 14:19:48 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tNB0k-003hfY-0Z;
	Mon, 16 Dec 2024 14:19:46 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tNB0k-002bbw-2i;
	Mon, 16 Dec 2024 14:19:46 +0100
Date: Mon, 16 Dec 2024 14:19:46 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 1/6] net: usb: lan78xx: Add error handling to
 lan78xx_get_regs
Message-ID: <Z2Ao8r3gJRnQLq_I@pengutronix.de>
References: <20241216120941.1690908-1-o.rempel@pengutronix.de>
 <20241216120941.1690908-2-o.rempel@pengutronix.de>
 <c7ddac7d-debc-44eb-9c43-7746ad3edb55@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7ddac7d-debc-44eb-9c43-7746ad3edb55@intel.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Dec 16, 2024 at 02:07:37PM +0100, Mateusz Polchlopek wrote:
> 
> 
> On 12/16/2024 1:09 PM, Oleksij Rempel wrote:
> >   	if (!netdev->phydev)
> >   		return;
> >   	/* Read PHY registers */
> > -	for (j = 0; j < 32; i++, j++)
> > -		data[i] = phy_read(netdev->phydev, j);
> > +	for (j = 0; j < 32; i++, j++) {
> 
> Maybe during this refactor is it worth to add some #define with
> number of registers to be read?

I prefer to remove this part. Please see patch 5

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

