Return-Path: <netdev+bounces-128824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF6297BD49
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 15:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E45284D9D
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC3F18950C;
	Wed, 18 Sep 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gWooirFS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D476618A959
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667260; cv=none; b=f1X49Mk0TeJQxxe2cIOB7z2pUdHwz5DID3WodZzStD97o4DZ+LJoVE/bVtJxIQTPRCtIcb3yI25nAwE/+ZeykvAJy21n7Pl9quRUX30dEXm78RHWfx3Ox9oGyBevk+H4+PAnGpphv833SL/QK2biUCjBBWGoel9qBgl16Se6SYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667260; c=relaxed/simple;
	bh=WgumiD65fo5l17857WWRaf6jznU5Ga6baT32V7gaWwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k76S0D2gSZxDXr7nflJbifmF4/HtznRBSavSvZFYusu/tWjrf/nUOVTCck85URBAdN+ATV7ocUhqio7OY5LcDhJgTMR4mNqhollznbCiFTm87iFD7LO1Xr6hN8feZHe59Dqn1LS9cpp0s6FyrzcbeC09aaD60BX0Th6h6t3DeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gWooirFS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tL5pwoEKmQ61U3KKwHmXXF1v9nlBX/dOvsaCbKOKrSY=; b=gWooirFSNCjJYu4Sqkj7EoeJgh
	cqkCcDWlOtCTD4brRQ1aZ7nP3GpBbZ2YuWhfR+yQb83aWlrnL2tRgRV6vtD2UWUfbecQ7/HJhnMQy
	RkZhTGfEEDCREE7GMNdBfFrPwKcgJ/h4iqhcDrV5MEwPP9ZZr8+Gp0qtUOI/yZVrgRraetOVHBORK
	DjQf7C47+XwpgKOBxbNI8Npoaiqca8lQLPZKFV7yRdz1nyCTpCLtBEtlSj7lzSYwC/q1zilkUBGMx
	jWMQ4C4S/8qWL0yyeEq6mDUOs66CQOXQ3d71Xsp27VHYL6diTR5MlNPn8m4x8hzI73OY/nhEyTsZZ
	jxSNVY9g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56748)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqv1o-000802-2Y;
	Wed, 18 Sep 2024 14:47:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqv1m-0000bQ-1D;
	Wed, 18 Sep 2024 14:47:30 +0100
Date: Wed, 18 Sep 2024 14:47:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Saravana Kannan <saravanak@google.com>, netdev@vger.kernel.org
Subject: Re: Component API not right for DSA?
Message-ID: <ZurZ8sj4N9b0yUtx@shell.armlinux.org.uk>
References: <20240918111008.uzvzkcjg7wfj5foa@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918111008.uzvzkcjg7wfj5foa@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 18, 2024 at 02:10:08PM +0300, Vladimir Oltean wrote:
> This is all great, but then I realized that, for addressing issue #2,
> it is no better than what we currently have. Namely, by default the tree
> looks like this:
> 
...
> 
> but after this operation:
> 
> $ echo d0032004.mdio-mii:11 > /sys/bus/mdio_bus/devices/d0032004.mdio-mii\:11/driver/unbind
> $ cat /sys/kernel/debug/device_component/dsa_tree.0.auto
> aggregate_device name                                  status
> -------------------------------------------------------------
> dsa_tree.0.auto                                     not bound
> 
> device name                                            status
> -------------------------------------------------------------
> (unknown)                                      not registered
> d0032004.mdio-mii:10                                not bound
> d0032004.mdio-mii:12                                not bound
> 
> the tree (component master) is unbound, its unbind() method calls
> component_unbind_all(), and this also unbinds the other switches.

Correct. As author of the component helper... The component helper was
designed for an overall device that is made up of multiple component
devices that are themselves drivers, and _all_ need to be present in
order for the overall device to be functional. It is not intended to
address cases where an overall device has optional components.

The helper was originally written to address that problem for the
Freescale i.MX IPU, which had been sitting in staging for considerable
time, and was blocked from being moved out because of issues with this
that weren't solvable at the time (we didn't have device links back
then, which probably could've been used instead.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

