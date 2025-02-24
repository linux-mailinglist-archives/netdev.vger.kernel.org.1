Return-Path: <netdev+bounces-169085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A749A42845
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A401894199
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAB5262D10;
	Mon, 24 Feb 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hSOMAMi9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C3261593
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415806; cv=none; b=NGmnGwD1iSx7BSCHRrQt71Y61tPKDXejs2luwl+qoHWnDFKUaW8+SgxIgAt2FpYDi2W1oWbs4tgeeq2mJiYR2rnt1kflrBipnn0F4SAmGhxAf8jxIJuyoC8XBi2wtAKVCHA71KJ/OPReJy2msiaMA39hqBbCael8ansMcuC+fAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415806; c=relaxed/simple;
	bh=ILU8bWKcokWDvIEhMlgHkISsvtiYy9HbZ016Gnz7fdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBhWYQxrGoA7Tz5J5VZwvaOtyLOKi08mA53dp6dTMDxjqPSdVAyI143jJtaU164nAT+slaH7QtayedgAT2PyVvpmHkbbzmARa48eslFkprPqKbrRUgCu2MI8oPw7Yt3XvAeZGgpAAXMsDLWq+w9celIEtfQFN9PjH8vsZj5q+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hSOMAMi9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=prs4XZf+LQU37XZYihXYMGUtI4UK9gIDbyzuWPk6b1E=; b=hSOMAMi9NWkbX+qi46VgOYrtHj
	0FIRcy3jMwJHS5h0X7nTJhRshYOj7P1iQ9S3NN14gjB10MDLPMt20tG5OxmlFWEv+Ir8EtI+PXKSO
	0BrL4bPpgcFnwWXHgDoynSFy8DbAzrJkf1LxfkcwmlahEqMs0b5UmkqL/n7iIOHGdWXEKcQuoUFsl
	EGDOfS9FzdbLp6nX8flr5mj4XDI2H1PBi3Po4MMXjsZLldXe30ESJeADGlsmy9cix9S0riSdY1Mr5
	YdX9Mezq+Bj8KU9f+tjMhYaWB7DGJxAugpfVyP8lFSXtbAABEERdGvPGxHf4ljz3Zd4IAt0dOv4tr
	mwilkKsw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41954)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmbeU-0006zA-1n;
	Mon, 24 Feb 2025 16:49:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmbeR-0005AB-0I;
	Mon, 24 Feb 2025 16:49:51 +0000
Date: Mon, 24 Feb 2025 16:49:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwc-qos: clean up clock
 initialisation
Message-ID: <Z7yjLjfNq89vPnOd@shell.armlinux.org.uk>
References: <Z7yGdNuX2mYph8X8@shell.armlinux.org.uk>
 <E1tmZjr-004uJP-82@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tmZjr-004uJP-82@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 24, 2025 at 02:47:19PM +0000, Russell King (Oracle) wrote:
> Clean up the clock initialisation by providing a helper to find a
> named clock in the bulk clocks, and provide the name of the stmmac
> clock in match data so we can locate the stmmac clock in generic
> code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Yet more warnings and errors from NIPA, yet this patch passes my local
build tests.

As no one looked at v1, I don't see the point of waiting 24h before
posting v3... no one is probably looking at v2.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

