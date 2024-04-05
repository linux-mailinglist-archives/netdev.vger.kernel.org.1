Return-Path: <netdev+bounces-85356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E603189A5D8
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 22:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856F21F22409
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 20:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D248174EE8;
	Fri,  5 Apr 2024 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n3zaY+u3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA593172BBF
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712350220; cv=none; b=YwHS+98Yb+G0wHrwgAiURGgrdAXTn6+dNPS3ed+lP0K4VhdW9MIuU9S+mrOALvF7whr1p2aXjQ6gpK0L7HhYJfzSAdEZtc5TkcWJshJqGL8yAVWTNHbez8Svw3etPXdCE40NycO7BfhbbEFGOLzPRkdO2Lh8HcGSJxiheGS7P4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712350220; c=relaxed/simple;
	bh=HE032LmlRAdi/APNcZhvThYOK59h8399YPdW1D7N5Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVTpD97WRUVyOvhEV11hhfYTcMg+TQP/33dzmA1LIIOfIA+LiJnM6phlPq3dAppIYeD7r5qm1IiMDVwW1/mGOTlLw9gxqCGIEXOyyBmKYgwSWiHXTUoixQHXKMbWFn15iEJwZ0+efNWrkM4cyp5pEhCVy3fU1Ul4zPUnQzCIB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n3zaY+u3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J/cE33OBdOTsemMeSpHAhERQCzZ6V3HX2sTK1fJ2+i8=; b=n3zaY+u3Zq215MaOmDIDuyxyHc
	cBu1Ff3NnDcmwC5gPoq5mmomES6l2BSCG9411eqWc/BObFxxmFG5zuGVPgMI9Ten0we/Hsfk9nI0K
	/EQcjYBr2Betfwle1FGCkL43TYMjR+5xg6h7SPO+FEOidnGO8Mp8o3+Bc//eqt6F74jE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsqVc-00CKm2-Nn; Fri, 05 Apr 2024 22:50:00 +0200
Date: Fri, 5 Apr 2024 22:50:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Lukas Wunner <lukas@wunner.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
Message-ID: <7cfb1af7-3270-447a-a2cf-16c2af02ec29@lunn.ch>
References: <bbcdbc1b-44bc-4cf8-86ef-6e6af2b009c3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbcdbc1b-44bc-4cf8-86ef-6e6af2b009c3@gmail.com>

On Fri, Apr 05, 2024 at 10:29:15PM +0200, Heiner Kallweit wrote:
> Binding devm_led_classdev_register() to the netdev is problematic
> because on module removal we get a RTNL-related deadlock. Fix this
> by using the parent device instead for device-managed resources.
> This is cleaner anyway because then all device-managed resources in
> the driver use the same device (the one belonging to the PCI device).

I've been thinking a bit about devm for LEDs. At what point do the
entries in /sys/class/led disappears? When is the netdev trigger
removed? I think it is after the netdev has gone?

static int rtl8168_led_hw_control_set(struct led_classdev *led_cdev,
				      unsigned long flags)
{
	struct r8169_led_classdev *ldev = lcdev_to_r8169_ldev(led_cdev);
	struct rtl8169_private *tp = netdev_priv(ldev->ndev);

Is this safe? I think the LED will only be destroyed after
rtl_remove_one() has completed.

I think to be safe, we cannot use devm_led_classdev_register(). The
LEDs need to be added and explicitly removed within the life cycle of
the netdev.

    Andrew

