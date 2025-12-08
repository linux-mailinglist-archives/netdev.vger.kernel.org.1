Return-Path: <netdev+bounces-244003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CC9CAD322
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 13:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9124C3015101
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4322F657C;
	Mon,  8 Dec 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N+tjsn0C"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA34E2E9EA1;
	Mon,  8 Dec 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765198092; cv=none; b=lKy5TTLJALHlWokhP2Sy3sxGaM938Mn0OV6P31QfxwRpMyV5wRO5Czqj79slK1GMvJAC7Foix+zm/XM8WZjc5XlZmTcyynguXx/XCByJdQTJoeFFYLw2IjIIt4WCYq9+qeHCi8DReucVkQLCIHh+OlOX9arP9en5AuGXD4gr1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765198092; c=relaxed/simple;
	bh=BZn1jFSstaaIHBr+3rFAL7v28AXTQzLy3o20BxjP4N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDY1dFAgrhP20QVi2B4hjpuX+CPVEOevVprvGijXntG6lD4F9REcWgtGztl8O7BWNqYO1p+LudxpBAfchsmKwOGZsSYbvS7rRy8sgaiyAZrtOaBmBAywBtkZQjav9H/aU3zigHVAHyQKvVXhfRvo1+UV4+29tbqMAaDIJoU2Nrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N+tjsn0C; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vGVcVp1Q00fpfPBPhRwGD3DGTaedV+wJixuN3NTlU5g=; b=N+tjsn0C0dYMzudgnLOOICCMtW
	QAE6QmOSujqyvmHiYmnABbwIjkzx2S030AaSYrZIGylUo9Egy7uhkJRK6nKJi7FchXvRBZrHjb9bx
	3VgqmfoNrlHE98s1xzgmHrtiEMp8Vue1PSowHMt/tdKkdgf+CDCKggM1EYBKRKkpI2EC8vqTlDBrk
	3VSjknZRHd+YfkcY+LLJy5zUP7SFbGGH6JYiY4xpgqsGxu6TRdGsEPCPHbtTjCvnGH9+NpZ1BRp1z
	yrRW1Gmtwnz6T4UNn0QcAQfhylb+CKdaCeWpqO8cyBWS+Ad2i9QIfiQ87R0yUeoQDr7o/qDjzj2jm
	SzDuFPdg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44476)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vSaej-000000007kp-2s7Q;
	Mon, 08 Dec 2025 12:47:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vSaed-0000000052h-2k6v;
	Mon, 08 Dec 2025 12:47:51 +0000
Date: Mon, 8 Dec 2025 12:47:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net v3] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <aTbI99uWvg08wgV9@shell.armlinux.org.uk>
References: <c28947688b5fc90abe1a5ead6cfd78e128027447.1765156305.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c28947688b5fc90abe1a5ead6cfd78e128027447.1765156305.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 08, 2025 at 01:27:04AM +0000, Daniel Golle wrote:
>  static void gsw1xx_remove(struct mdio_device *mdiodev)
>  {
>  	struct gswip_priv *priv = dev_get_drvdata(&mdiodev->dev);
> +	struct gsw1xx_priv *gsw1xx_priv;
>  
>  	if (!priv)
>  		return;
>  
> +	gsw1xx_priv = container_of(priv, struct gsw1xx_priv, gswip);
> +	cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);
> +
>  	gswip_disable_switch(priv);
>  
>  	dsa_unregister_switch(priv->ds);

Can we please pay attention to ->remove methods, and code them properly
please?

There are two golden rules of driver programming.

1. Do not publish the device during probe until hardware setup is
   complete. If you publish before hardware setup is complete, userspace
   is free to race with the hardware setup and start using the device.
   This is especially true of recent systems which use hotplug events
   via udev and systemd to do stuff.

2. Do not start tearing down a device until the user interfaces have
   been unpublished. Similar to (1), while the user interface is
   published, uesrspace is completely free to interact with the device
   in any way it sees fit.

In this case, what I'm concerned with is the call above to
cancel_delayed_work_sync() before dsa_unregister_switch(). While
cancel_delayed_work_sync() will stop this work and wait for the handler
to finish running before returning (which is safe) there is a window
between this call and dsa_unregister_switch() where the user _could_
issue a badly timed ethtool command which invokes
gsw1xx_pcs_an_restart(), which would re-schedule the delayed work,
thus undoing the cancel_delayed_work_sync() effect in this path.

So please, always unpublish and then tear-down.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

