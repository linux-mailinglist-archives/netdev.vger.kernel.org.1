Return-Path: <netdev+bounces-188598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366CAAADCB9
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6DF3AA300
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 10:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A561ACEDF;
	Wed,  7 May 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="t7Wq+7a7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4BD19D092
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746614782; cv=none; b=XIr0IoEP5PiLbbcbi9TfUa5XS4OJcHfNx98UP2brUuQWt778y5tC+YD4Eibv8/zcGaYgyK6Xw/AupVJ7c/lrLTJylDILD2EYw5JE//biTi0lcDOkVwk9qpz47bYc1xT6iRVR/3pKlAVcxK27DMDTp4rX3GTCmmXFc6nc0ItewNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746614782; c=relaxed/simple;
	bh=tVUHt4u5BtEeZoLMejAqvaVl3urAiuFNBSxKLm7hY8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI0ZZDJZhuulvOd4HYMC+Cqm8uM5aZSWM0f/ocfoVIxgnHEBIZ1uCM3vksQawVc2HjRRR4K4jwB7Pghc8E/PtSZur/yOawZUeSh0DhHGtXKPmo9UklKTJSvluOFBjIvngUG0Cvrk1cBsTpJR8/u+mT01os0Thqs0KBhotzy8W7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=t7Wq+7a7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9/KxYK0r5mOPS2j4c9eNdJXVJKdT84YmFWg2UIuE8cw=; b=t7Wq+7a7EWTU8I19wQAewgxjvC
	3spMT9R6iZe1uDjX0a7A3zhgGjNZHHxH7GuCUV1kcqUzprhK2fJJ72Hc6VSwXIybocSKp2EB5e5UN
	K4hmCGllRpAUjRKxldC6xuE1SM8DSnaWp8Srrn/ssj97/TRKsf+l0TbUHJfuOdmqCyXI0W3VN+e7g
	J0WarNJBTuhAkcNuxIYJwV4BGjLS7SxgqwsrtY98M0EizXhjY/YBwckmvSnwQaPKMNWBnr5/x8pwT
	oWlXsqAGmSQZmNL3TVOeS4g4JSvbZ7KzSBnCP4y1pkhRarvtF0oDUmjIjKdWQo8xEsk+R/EGQgDxy
	t0tjl7Wg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49032)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uCcHy-0007PV-2E;
	Wed, 07 May 2025 11:46:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uCcHw-0005ik-18;
	Wed, 07 May 2025 11:46:08 +0100
Date: Wed, 7 May 2025 11:46:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH net-next] net: phy: remove Kconfig symbol MDIO_DEVRES
Message-ID: <aBs58BUtVAHeMPip@shell.armlinux.org.uk>
References: <9c2df2f8-6248-4a06-81ef-f873e5a31921@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c2df2f8-6248-4a06-81ef-f873e5a31921@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 07, 2025 at 08:17:17AM +0200, Heiner Kallweit wrote:
> MDIO_DEVRES is only set where PHYLIB/PHYLINK are set which
> select MDIO_DEVRES. So we can remove this symbol.

Does it make sense for mdio_devres to be a separate module from libphy?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

