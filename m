Return-Path: <netdev+bounces-166911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B887BA37D98
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756B41721D7
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E85B1A3175;
	Mon, 17 Feb 2025 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZPhg4LMJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E01A4F21
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782516; cv=none; b=rSVLz+FpammVqxVGhvqeFzsP5MN4lQ2RFAe+ngiA4bK0rQlJokwrfcxjY5uz1zggrvpgMDMlav/eKtwVvb08nUZ1mMfaN4VeYxW/FnReN3b3JXTBTCQu51iH32YUjubXt1wVXh09DGddeD0eAjB2gCPTOQsIlfSTeIJKF++BMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782516; c=relaxed/simple;
	bh=7seGtLkPtmgZx8kHMI0xtMquDYwABepJmdcYMPCRG50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFJsX5RppgnxdIpk2BhZqx0faiRjMqU/cXP4PjXXXOZDrGkGwn/0aDZ+NrlJnOM3LlSSmrl2NMRk5zKTblhxTImnYi3bs/6OOsZoZoy+G4M5a90Kq6dlw3EfnJvwdyvjEWdH1w+AoB8Qj1opWiIN/h+s2K4SOPX0nbXhCXbAA5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZPhg4LMJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4wDwaA1xwlfLLN7WiSFY8wEqpN8NX5sLWpKu45UpXdc=; b=ZPhg4LMJ3XbKkJwul4TzR6umjs
	wOOm455SOXWmfUSnj/jZ1Woef0C7etaSvuM1BUX5Hwiy5Noq089yFnTIza7SpugcEeQtf2Xhh8WzP
	TNBj7ya3EAvRyGcH4bHU8oQEYYpARIgwMlcdpOCo0vlG+usDekCH18gkwFbq8U4X3T9yk4bLfqnmh
	gs9xTd9k2xbABdW9zx1DP+pZeSQVlNr5VVLwzpGt3wQjfmEOB12VDEIaMf6zwJLRIPxHfh0FIloCk
	VIwbuE8nmdpGMPzz4XbZFyfck+Jvml9XnvNFUxT+emrUjUmbt1ZuOjeP7kkvgOQGXQgFr8KlhfbQe
	gs/jz2gg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40876)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tjwuD-0005sO-1g;
	Mon, 17 Feb 2025 08:55:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tjwuC-00064z-1F;
	Mon, 17 Feb 2025 08:55:08 +0000
Date: Mon, 17 Feb 2025 08:55:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 4/6] net: phy: c45: Don't silently remove
 disabled EEE modes any longer when writing advertisement register
Message-ID: <Z7L5bGZA8f06WLvo@shell.armlinux.org.uk>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
 <e95b9dad-24a7-4e3e-9af9-6f0770cf1520@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e95b9dad-24a7-4e3e-9af9-6f0770cf1520@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 16, 2025 at 10:18:42PM +0100, Heiner Kallweit wrote:
> advertising_eee is adjusted now whenever an EEE mode gets disabled.
> Therefore we can remove the silent removal of disabled EEE modes here.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

