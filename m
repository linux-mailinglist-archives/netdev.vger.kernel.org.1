Return-Path: <netdev+bounces-177137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76929A6E059
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C58188A09D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0AC2641DC;
	Mon, 24 Mar 2025 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gdz8rqnf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D415263F32;
	Mon, 24 Mar 2025 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835458; cv=none; b=DPefcdEypyhNRu8stkThVrxUw0WV0BH1/1Psk1HjDw7pnvJpvr1xoULTqQduj2kNj8w1NvQA4AhTwr6F18WeLxV5g7f5AZpS2xCtoaKn/CG3myZaAdKk9l4K98MxEoQjjzWAAaBYdH4wEHGqthyLlaftpDtYp/bepWxz4mYkLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835458; c=relaxed/simple;
	bh=jq6KD5dap90lJjDbFAXTSsraPhA8AgZwRfwkBkYFXd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2zbPoiM/rBdJ60wSZ3MvNbTjt0vuoIeUYk6BeqiC67uCf3oJOrISk4CG7Z18dSCwJowj+oNJCSwMopmbQ1HqAHDi1mZga8XtNlXSsMyo2X0swIAhi2GTfmLoiPQe76eIm29y6UjF2IgoRCxeZifGGxkIArhFQsnxCIxttGLzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gdz8rqnf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uZpqntUszdnsbmO2CLvPIRMBPHQt2FjCDjhNfY3enx8=; b=gdz8rqnflfUQmNqlW8cugrADyx
	tR0ieqeTXjdBctwFTHy6WtN9lCNOB/Q2ykM7uh3n0xFCfTcaDUK6MJBXp24tl5CvfAPK1r6CfTNpZ
	IWH3u5184nub6oajbyn2fHFVZZ0xcXYO8KLDfUFoAvg5mdL6mf/btK38yCAusTk5QGT56Wcu2XsQH
	p9KUyUW1uSrloC02ZEwL1LHPwhJnH73GQKO2Sc9SpSWX61MAQTDQSP94Qy9SQsQogCq/n6GyhbfJJ
	dSNydzi/EnFXdSsjz0mIARU+rbisaTNIHfhaX2Xt9GXR6nWe9iXSf4gPu77KF8KR2ScYmqgRXvAhc
	01ol2dsw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55898)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1twl77-0003ph-2z;
	Mon, 24 Mar 2025 16:57:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1twl74-0002PR-18;
	Mon, 24 Mar 2025 16:57:22 +0000
Date: Mon, 24 Mar 2025 16:57:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jim Liu <jim.t90615@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, JJLIU0@nuvoton.com,
	andrew@lunn.ch, hkallweit1@gmail.com, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	giulio.benetti+tekvox@benettiengineering.com,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [v2,net] net: phy: broadcom: Correct BCM5221 PHY model detection
 failure
Message-ID: <Z-GO8iFP7TRPPdql@shell.armlinux.org.uk>
References: <20250317063452.3072784-1-JJLIU0@nuvoton.com>
 <Z9f4W86z90PgtkBc@shell.armlinux.org.uk>
 <9391fb55-11c4-4fa9-b38f-500cb1ae325c@broadcom.com>
 <Z9gjylMFV5zFG-i5@shell.armlinux.org.uk>
 <CAKUZ0+GV1J0VxU8Eycv2eCNs2yKvJ9YTob27n+G4Jy-TJhhLZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUZ0+GV1J0VxU8Eycv2eCNs2yKvJ9YTob27n+G4Jy-TJhhLZQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 18, 2025 at 11:15:09AM +0800, Jim Liu wrote:
> Maybe i can add this modify in patch
> 
> #define BRCM_PHY_MODEL(phydev) \
> -       ((phydev)->drv->phy_id & (phydev)->drv->phy_id_mask)
> +       ((phydev)->phy_id & (phydev)->drv->phy_id_mask)

I would suggest that this becomes merely:

#define BRCM_PHY_MODEL(phydev)	((phydev))->drv->phy_id)

because the constants that are being used to check against this are the
constants used to initialise that member.

Or even get rid of BRCM_PHY_MODEL() altogether, thus the tests become
(e.g.):

        /* Unmask events we are interested in and mask interrupts globally. */
-       if (phydev->phy_id == PHY_ID_BCM5221)
+       if (phydev->drv->phy_id == PHY_ID_BCM5221)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

