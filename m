Return-Path: <netdev+bounces-178068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B52A74555
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 09:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00EB1B603DD
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E98212B39;
	Fri, 28 Mar 2025 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="16WTuBUb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029618DB2B;
	Fri, 28 Mar 2025 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743150309; cv=none; b=ufyuAMKxx0zt1FuuP1B0C2yFb8qS+f6NIHHa86N/6dsVWNMMamgUXf23MlMlxXX4NejQKYdRGbVWu7EKEw97hrWAtgnCa5rT4DCN2x6u610CfYZKS7BC+B1ZiXzVgeQcZzA78K8oKvdHhksggJjz16tUu3VA9TEwUHW1+kws1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743150309; c=relaxed/simple;
	bh=l6ChTbG9Qhsc98nwnwWgm9s9uTeB3u4h5qNXJ1yunOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYMWPgncqhvJnrOteVgZdKspuFCs0ud+Ujz33+3q+G4WaM7esvRIemekDLnemBD45EHx9X7y7rT9+g+CLTQLa6QbZ+XorPyD7YEpTenLPE361/VXJDVdoe5NQWSYK6I6UrpOVK3LJCxY3h+kCgodNIVmgK/7zxxNsFRAGR1uP7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=16WTuBUb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZtSWqFwAavuSWx2kZ4KZ73onSPNyQ8d79/hfLcfS0lI=; b=16WTuBUbF7ZTFB1iaHRfiOEFY1
	5eQ3ShAn2l+G12XISCztGiYHraIycIzVrOM4Ny5P/lsvdgzlBVDLd9StsApvXlSBkNcxohbWi1bhZ
	4lQLx1hPTa0Xp7c7cljwgDFUeE9mz3YnuiUaf6MjPpYPKpshdS3ObhOgHRFIYgQQQhkKXfQCRGhuP
	CQVHOR3g5Aps/R0ly9hl383SHuVPuKMv2xNJaxMTA5JSbfeh/BjNLB5x5e59kbai33ujsImSuqM/4
	ykZd5+8N1reK71j5nI/Cpc6jPjeywybzLPFnmBjHylrDhgHdjEcGYQeqscdRRn7AVS6M5AD8VFVlf
	A/c0dk5g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59108)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ty51G-0008BV-1s;
	Fri, 28 Mar 2025 08:24:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ty51A-00072E-1d;
	Fri, 28 Mar 2025 08:24:44 +0000
Date: Fri, 28 Mar 2025 08:24:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v4 1/6] net: phy: pass PHY driver to
 .match_phy_device OP
Message-ID: <Z-ZczBztZbnc8XPa@shell.armlinux.org.uk>
References: <20250327224529.814-1-ansuelsmth@gmail.com>
 <20250327224529.814-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327224529.814-2-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 27, 2025 at 11:45:12PM +0100, Christian Marangi wrote:
> Pass PHY driver pointer to .match_phy_device OP in addition to phydev.
> Having access to the PHY driver struct might be useful to check the
> PHY ID of the driver is being matched for in case the PHY ID scanned in
> the phydev is not consistent.
> 
> A scenario for this is a PHY that change PHY ID after a firmware is
> loaded, in such case, the PHY ID stored in PHY device struct is not
> valid anymore and PHY will manually scan the ID in the match_phy_device
> function.
> 
> Having the PHY driver info is also useful for those PHY driver that
> implement multiple simple .match_phy_device OP to match specific MMD PHY
> ID. With this extra info if the parsing logic is the same, the matching
> function can be generalized by using the phy_id in the PHY driver
> instead of hardcoding.
> 
> Suggested-by: Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Too much copy'n'pasting?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

