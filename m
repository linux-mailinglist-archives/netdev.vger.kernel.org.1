Return-Path: <netdev+bounces-224602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB55B86C16
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 21:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EE216260C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01672D322C;
	Thu, 18 Sep 2025 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rwbRPg1T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8117E0;
	Thu, 18 Sep 2025 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224925; cv=none; b=u9rz2T5970afcwVX9rrdQvuKq8CsgwtozOY879QtqPa4/4nmV1+WpzvcpuQ9WEafaLqoRjZcytD8ysHVbAPv18kQjUOHPqbyIJuK7fKafr53E7WS+kMvOM7yN5i4lbsjQSHWBV7YY9yT+WchimJ6mrwiN4ayETqis6eOJFoyLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224925; c=relaxed/simple;
	bh=b8O9accht9zlMjkeiSVfUoiyThYZxQ8pzWQazD2pCPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjutTRNe8FRFji/EOIPhgxYDerSHx8E/gB1j9yD0G9Hy54FkAXfYXbTZSDC/tjvZ2+BPMUc94Q8LjJveeYFsOR72gs4Wiz+F5wkc+vBj3ihfaJO+L/82xUui7mRb42HwJqLd8Mhm+6Zx6ogWQ+ptqgKa55eYHkUlCFWXXSR3kMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rwbRPg1T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w594/w6qwUYib2E14Uwus1v5HGGT/dcJmGxuZGLJuOQ=; b=rwbRPg1TDsbphsGucFCh6g3N2M
	1F9JzhlVibz7jSnAhUlf9w8YHDnH5xICd0LTknt+ZkQS1NuL/vl3452Dv2CUBEico+k3TD+dM9uWC
	pVLndRcUG/mBxgd8Np9ZMWntIoLyoI6xhPBUmFbJH0I/2FexKR2L3Gd4JAE4WhLlJeC4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzKcL-008s4v-Im; Thu, 18 Sep 2025 21:48:33 +0200
Date: Thu, 18 Sep 2025 21:48:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH net v4 0/3] net: phy: smsc: use IRQ + relaxed polling to
 fix missed link-up
Message-ID: <a873e8e3-e1c9-4e82-b3e8-4b1cc8052a73@lunn.ch>
References: <20250714095240.2807202-1-o.rempel@pengutronix.de>
 <657997b5-1c20-4008-8b70-dc7a7f56c352@lunn.ch>
 <aMqw4LuoTTRspqfA@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMqw4LuoTTRspqfA@pengutronix.de>

> How about a minimal change instead: conditionally call
> phy_queue_state_machine() from lan87xx_config_aneg()? That would trigger
> a poll in the broken mode without touching phydev->irq or core teardown
> paths. Seems less intrusive than rewriting IRQ handling.

It is currently a static function, so that would have to change.

Or it might be better to add phy_trigger_machine_soon(), using the
default 1 second delay? And i would document it as only to be used by
broken PHYs, to try to stop it being abused. Anybody using it needs to
acknowledge their PHY is broken.

	Andrew

