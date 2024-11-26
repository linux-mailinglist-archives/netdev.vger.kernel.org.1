Return-Path: <netdev+bounces-147364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD79D94A5
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2266EB2CE5E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C001D27BB;
	Tue, 26 Nov 2024 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="c2PLDRGD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF081BD038
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613097; cv=none; b=CgNyRL/6Oja06vdbbSpBGXznn6WPC2K1iipGCX2q+oauBkz2rr2HqRtGCwhiJDuuUNnOKyjNTLCcRikYQOq/ka3FouVMwMF+ES6gCSFu/w5a1C53+nwhOOnEUJJjgwlLVC5IvLCZmJz5g9Xn2G0tgG9HqyBByTGVQAHoWcFKuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613097; c=relaxed/simple;
	bh=ctSrFoQbuRzkkWlPctBqOWCh6o7txINd0G4TiKlYcqw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ooOp8bvycll760e4XqJSbxYYmkgVVv+uUTyaGl6+faA5wVbMbZYcNkm24w6NrvblMuBXPfN0RVhTK6GHcLjcxiX6tQGOFrcui+MNfuWCwAnar9SjONqIc0LbLlQjmGzMD0x8I4bXwyc8rw+2L947nnJ+Pcd+B/9iwFH3zInGsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=c2PLDRGD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=el0rVY+c9CrkRzaGqbcKkhlZC6FhAlwE6EzSElpENZM=; b=c2PLDRGD9Ssf7ZkhiapQYuPPQS
	1ZD+o4FDtCpKZMI0SUXyUFVJKP5Ogvjyi22GEnxGLvO0sDt9H/xOKqq0sXVUWQJ4uftakUuC0MzOc
	zth8l3K944nGdgSpHcrGLg4lsgoBMqE8+gYwjh5g9/siPz6crxx+xPoYS960XDIGeEJvgwMTZHvCE
	5J2/vCaS7XRZo7/g95CpNu173tEzl04U14HmM4MM4R9FJBrFcibMNF+4/9JfUeiZEJbcfTQAZd3He
	eDTmvQmiFq26nr7vG8a9cRabNsjHwe0LwL93jUbHTX70bMlROERn58bIaNK3/TP97ZdZWg9hK3rml
	ejlf7Qyw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46098 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFroI-0006Sz-1A;
	Tue, 26 Nov 2024 09:24:43 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFroH-005xQ2-2v; Tue, 26 Nov 2024 09:24:41 +0000
In-Reply-To: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 05/16] net: phy: bcm84881: implement
 phy_inband_caps() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFroH-005xQ2-2v@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:24:41 +0000

BCM84881 has no support for inband signalling, so this is a trivial
implementation that returns no support for inband.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/bcm84881.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index 97da3aee4942..47405bded677 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -235,11 +235,21 @@ static int bcm84881_read_status(struct phy_device *phydev)
 	return genphy_c45_read_mdix(phydev);
 }
 
+/* The Broadcom BCM84881 in the Methode DM7052 is unable to provide a SGMII
+ * or 802.3z control word, so inband will not work.
+ */
+static unsigned int bcm84881_inband_caps(struct phy_device *phydev,
+					 phy_interface_t interface)
+{
+	return LINK_INBAND_DISABLE;
+}
+
 static struct phy_driver bcm84881_drivers[] = {
 	{
 		.phy_id		= 0xae025150,
 		.phy_id_mask	= 0xfffffff0,
 		.name		= "Broadcom BCM84881",
+		.inband_caps	= bcm84881_inband_caps,
 		.config_init	= bcm84881_config_init,
 		.probe		= bcm84881_probe,
 		.get_features	= bcm84881_get_features,
-- 
2.30.2


