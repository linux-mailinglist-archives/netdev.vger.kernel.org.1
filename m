Return-Path: <netdev+bounces-128673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAF797AD9B
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 11:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6B81C217F7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5029015B551;
	Tue, 17 Sep 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i/okB5hp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B93146A69;
	Tue, 17 Sep 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564287; cv=none; b=dt3zAZt59sW21WoAf9fu/uW8Jh3ia55ibYzyM21GLyg729XTwpt2kA8WEaLW4Y/QCWZsxMpsF2tRUvL4JOP3fBruUmN86rA7sKpMyQIdtWaAmrK7/zZdPpQBjP10Y2M5E4pDdmWR5J2HXZyBPPO7UAuJU+W9EvbNGZXG53EKA1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564287; c=relaxed/simple;
	bh=/bcneZc/Oh8H9i2vgkzVtn/cy+RLi1pifCKFElLWdF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2sJHp+CXlB+5fd6Q6maflrUu8brkvgtcJ86V/8h1wkrkHGf9lom2jTo3od0p0f+HrpEC1IL9RsH9jEf1dbH+QSvq5yLyrXwdOE5lynVnualzxn3X0edE2nTRrvToLRz5zAM9qL0Wwj4uvCwWQC7saLTiX8/42FS/pZ6zaTJ9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i/okB5hp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0jZ4zCvDYMFilkK8UmjZolNeKopNB0TODO3PgZAi9XM=; b=i/okB5hp8JcMMS+UjY8J+wf/sn
	sgfCPkqfEPmxREuSN7vJLU7UYyieN6qWp/GT6pR3AjTJqFLknvBK2totvC9vYfzJIKIYhKiO3cpa6
	k/bK5KZMhF36xbF4OQpApJnAPUWTR455xWQosC0BycxZESNULtIcIz8FUDAa2E81DSzGK1k0Usum8
	n7TdaICcLdM4mRXS2IL2zdOpXTON3VA2+dJzG/HA15xh0GPl4Ke65u8zbxRVByCxh1mT1GU1Gmt0k
	hmxK3SUy2+eXsq8x7U8puw/Io/T90crXrpIXgJW7atX7nNlVaXDwI+6++XUcV0/GBPz52cZp4/5XQ
	utcjUWXw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41350)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqUEm-0006lk-1J;
	Tue, 17 Sep 2024 10:11:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqUEi-0007rB-0d;
	Tue, 17 Sep 2024 10:11:04 +0100
Date: Tue, 17 Sep 2024 10:11:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Message-ID: <ZulHp9IBvptenuRa@shell.armlinux.org.uk>
References: <20240913084022.3343903-1-o.rempel@pengutronix.de>
 <20240913084022.3343903-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913084022.3343903-2-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Sep 13, 2024 at 10:40:21AM +0200, Oleksij Rempel wrote:
> This patch introduces a new `timing-role` property in the device tree
> bindings for configuring the master/slave role of PHYs. This is
> essential for scenarios where hardware strap pins are unavailable or
> incorrectly configured.
> 
> The `timing-role` property supports the following values:
> - `force-master`: Forces the PHY to operate as a master (clock source).
> - `force-slave`: Forces the PHY to operate as a slave (clock receiver).
> - `prefer-master`: Prefers the PHY to be master but allows negotiation.
> - `prefer-slave`: Prefers the PHY to be slave but allows negotiation.
> 
> The terms "master" and "slave" are retained in this context to align
> with the IEEE 802.3 standards, where they are used to describe the roles
> of PHY devices in managing clock signals for data transmission. In
> particular, the terms are used in specifications for 1000Base-T and
> MultiGBASE-T PHYs, among others. Although there is an effort to adopt
> more inclusive terminology, replacing these terms could create
> discrepancies between the Linux kernel and the established standards,
> documentation, and existing hardware interfaces.

Does this provide the boot-time default that userspace is subsequently
allowed to change through ethtool, or does it provide a fixed
configuration?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

