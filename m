Return-Path: <netdev+bounces-195033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F510ACD95A
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 10:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB331885CE7
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 08:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAB3288522;
	Wed,  4 Jun 2025 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IGlr3/M+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB028137A;
	Wed,  4 Jun 2025 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749024480; cv=none; b=Yj3k1uA9TnYvRp23DZ0zVl5RZLpNbnEPvS/zl2wq0gJnM+pDaQMYPNcffFNWQEoS3zOKj2RcXuRelVCZ5SMDfqej/pmOjXDabFqRrx8qYRz1bLTFxGq8ZB8BAbphPw8Yce5YfcqH3FhwOxzJpNEbxnmmotahgPYGPS0Pf2uy0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749024480; c=relaxed/simple;
	bh=/7JQPneGSdMcZBQxQyUWbhwLUGRX3LY+MRtNfc1CRS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgOE+8UVR9UVmUDychEwsHtV8KPem23o2N6Fz/UB6/s1qOM9Y3TXgjLu/Gwit0Db6CU1DiD8mAH+zRT7ZuUENLbDII7Ok8cdZ7YXRxMWrwJq+sMgBsbT3oemdB4lcVzfUbm5WNS3k4N1nlp00EesM2fx968IDzb3F5vGDnzpCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IGlr3/M+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Bpzrm16WN6oSaQuwLtYmFyc8WV8CsH8T7lwcJTKxAw=; b=IGlr3/M+u/1r5P2aqJThWvquCu
	OsYWJPLLVhBzFkejTLaGHl9pQ1vnUJdE1iFdHuXwSrfbOYpRboncUFhLXX8GBAeA+S9RvLwS0G/TI
	0A/UTF0d70Wz1+73Y2wmlgfdGo3xjl0/CcDpNl8G6OlH3mbelHmy0Pw9Bg4XC6PqQBZHy4g7dyOnJ
	HHc+wck/2Jrvohq4949FEKby8MA4dcuJNoWdZdEmm0vSgpJ0Shl2NotOp0OcdzSZfjmj6qTsBqOvp
	J0bnLbe8glPR+f7Woe9wfHLBIPIqOnCfjgG0GJAwCo3kuNMnZ698xO2CHQ3oTtzUFSe93/mlAl635
	7VRjuxWg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46960)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uMj9v-0006xS-2n;
	Wed, 04 Jun 2025 09:07:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uMj9o-00010z-2v;
	Wed, 04 Jun 2025 09:07:32 +0100
Date: Wed, 4 Jun 2025 09:07:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wei Fang <wei.fang@nxp.com>
Cc: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"xiaolei.wang@windriver.com" <xiaolei.wang@windriver.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
Message-ID: <aD_-xLBCswtemwee@shell.armlinux.org.uk>
References: <20250523083759.3741168-1-wei.fang@nxp.com>
 <8b947cec-f559-40b4-a0e0-7a506fd89341@gmail.com>
 <d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com>
 <PAXPR04MB85107D8AB628CC9814C9B230886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85107D8AB628CC9814C9B230886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 04, 2025 at 06:00:54AM +0000, Wei Fang wrote:
> I think this issue is also introduced by the commit bc66fa87d4fd
> ("net: phy: Add link between phy dev and mac dev"). I suggested
> to change the DL_FLAG_STATELESS flag to
> DL_FLAG_AUTOREMOVE_SUPPLIER to solve this issue, so that
> the consumer (MAC controller) driver will be automatically removed
> when the link is removed. The changes are as follows.

I suspect this still has problems. This is fine if the PHY device is
going away and as you say device_del() is called.

However, you need to consider the case where a MAC driver attaches the
PHY during .ndo_open and releases it during .ndo_release. These will
happen multiple times.

Each time the MAC driver attaches to the PHY via .ndo_open, we will
call device_link_add(), but the device link will not be removed when
.ndo_release is called.

Either device_link_add() will fail, or we will eat memory each time
the device is closed and re-opened.

If that is correct, then we're trading one problem for another.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

