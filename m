Return-Path: <netdev+bounces-68376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DAC846C13
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859CA1C234B4
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606A7A709;
	Fri,  2 Feb 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o9aTOCOt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C08779F1
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866427; cv=none; b=sGdniWNSNRSfztWshOcziYyjpph6paV3W32pys9IJo0ZebQ1D4fKDl/T1yaAjl4338axkV8Nj4S37NTHBeS6ZXbSXK6gkI/IwpYK3R2OXmGvduVlU1I1iYdv4fSj4Fej57Q+MWXwE6XPWhzkdhn4DNxRmb/ED7R6wwgIyZaQhoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866427; c=relaxed/simple;
	bh=iAEV6/CWfMPXtFsFV0NrWYl5Je7Z7IiH9PymvfyunMI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lh9W/4b7qK5cdJ4pKHayc52+7kW8EyoC8cSlmOPycyyMS0lJrcy+H5nHfYHlZu2ZwbnJDzT9ia4YIydhGue9v9x2BnezHt7An5cBWEktWxPG6Uv4gaU50ojAsANnRUIhKs6u5A/wkvyGo/VYIjSyZ5d90y72FM8WQyVhy2JS558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=o9aTOCOt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H88J5TUA4kjzKrM8edavWO7CzzGR5hnVTyCFR8jMm6M=; b=o9aTOCOtnDglVLzDJl90mCnXEN
	icDDEyJnZAKHU6F6Z0n7hw86O6lijLfhhn0Der1BSHRrKuL1iag/1Rcvb2iAelSvuSy18iq4wysbt
	7J2+B1pjzUtSvlAU9LFrLIGCyiA7GNdpAQylKRxYWzx5iiYeXxBSvYx8rwbyMnS3A5GgBrT+6APE7
	u0uXNPrqs4RmJGLmUp4Zdfkgjz4Ln8JZTMVsZvWlwL8pRAvd8l/lmITm4OT09Eyf6UmhIoXSRp7m9
	VF7nPSWlXvhS/SllW+bgXY4iiOuuUda6p40zpe0PMdeu75LPf8SWwvUs9mZbOQDyvRGx17oap5uXR
	pMHpZEAg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37008)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVpvN-0005hy-1I;
	Fri, 02 Feb 2024 09:33:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVpvE-0008D5-T5; Fri, 02 Feb 2024 09:33:20 +0000
Date: Fri, 2 Feb 2024 09:33:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>, Wei Fang <wei.fang@nxp.com>
Subject: [PATCH net-next 0/6] net: eee network driver cleanups
Message-ID: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Since commit d1420bb99515 ("net: phy: improve generic EEE ethtool
functions") changed phylib to set eee->eee_active and eee->eee_enabled,
overriding anything that drivers have set these to prior to calling
phy_ethtool_get_eee().

Therefore, drivers setting these members becomes redundant, since
phylib overwrites the values they set. This series finishes off
Heiner's work in the referenced commit by removing these redundant
writes in various drivers and any associated code or structure members
that become unnecessary.

 drivers/net/dsa/b53/b53_common.c                     | 6 ------
 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c  | 4 ----
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c     | 5 +++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.c       | 8 +++-----
 drivers/net/ethernet/broadcom/genet/bcmmii.c         | 5 +++--
 drivers/net/ethernet/freescale/fec_main.c            | 3 ---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h    | 1 -
 drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c   | 2 --
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c      | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 --
 10 files changed, 9 insertions(+), 28 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

