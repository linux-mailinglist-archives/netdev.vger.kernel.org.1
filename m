Return-Path: <netdev+bounces-175104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD557A634CA
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 10:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17CE188F9FE
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D2A199924;
	Sun, 16 Mar 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GB7YlObx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD3154BFE;
	Sun, 16 Mar 2025 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742117774; cv=none; b=qCD+3Ru2/YUga+ECvnhfEV3litPSe5VwmJP6PahlJk7K0hcZQi3b3nBZbOuITIUT4V1xUNbDDezYSCbZ9xANqsrHwCqBiYZz/wJLMfduJonWe253cRK8GlNGz3KCYASqchSRIWMFHw4qg9Dszu0ZlIhYGSb6vXt2B1sUz/cOEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742117774; c=relaxed/simple;
	bh=LVekSPC4tbY22UW1dDWAse4ZEgBTOWX4eA/pSifjpIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4MRgDrN37d0tDISpfe7iZsK/N2hEmp6l/V+yY+8aRFV8Q98UthBNMYjawEqtyixNUuGrZMISYgfGLN46ed+xkr5kDVpAsmRO1kwIRdOGIkCpEOsFG7ForoPHVxMU21bs0A0Ysafx2NaG2WicnFUEVnR8s1451JrVQYkP1us81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GB7YlObx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Lu3jfBowXcNKmWJRvXxOXbWwGK56d3FuE8cYfDCWXoc=; b=GB7YlObxapexaEV8qZh4lDiG+Z
	uQslsIY2gJcculrRiGb51NrFpvpqwjz+Ckq3lO8OBL1ZixbLpOlsMipYXD+XAG0B09jUZR+uvk91Z
	xMnZzti96UVkbUfuxORNBwSuVZtGAaL+xnMIigx+8glZ77O37bHDwXUPzC0oAIptSRSCC6Vf464P4
	H/QsdPN2XZigYldGYEXjwChME9NdpcJqVhb6D5PaA34zhIFNjgLUlhzVI8KciDbk2Zhx+M7ijrBiY
	Pjf02OPNsgXJCNQnkE+EZKfEWe6ngluAHtIGNJhYMiNMA0TRbxpYLUgRAHSSw8dgXa+qWo/RqD+QI
	6ZlP0PCQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54080)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ttkPc-0002KR-2U;
	Sun, 16 Mar 2025 09:36:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ttkPZ-0002Q3-2Z;
	Sun, 16 Mar 2025 09:36:01 +0000
Date: Sun, 16 Mar 2025 09:36:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ihor Matushchak <ihor.matushchak@foobox.net>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: phy_interface_t: Fix RGMII_TXID code comment
Message-ID: <Z9abgWJRtZ62S8ck@shell.armlinux.org.uk>
References: <20250316071551.9794-1-ihor.matushchak@foobox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316071551.9794-1-ihor.matushchak@foobox.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 16, 2025 at 08:15:51AM +0100, Ihor Matushchak wrote:
> Fix copy-paste error in the code comment for Interface Mode definitions.
> The code refers to Internal TX delay, not Internal RX delay. It was likely
> copied from the line above this one.
> 
> Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

