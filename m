Return-Path: <netdev+bounces-150696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4E59EB303
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABCC5188CB1E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F0C1ABED8;
	Tue, 10 Dec 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A84AYt4u"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0F1B85C2
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840340; cv=none; b=h3A/SGL8FGPCSPtpUxqad1hTLbQ6izxV1b68fUzKDG2dcIhud12Zm5CeJG+kldjOeVBsV13TInSqas2TcWVPmLUessDbTFy8H8C6IuLAJ9tBz2DaIKpOmQA/jX9wG8cQfKy9WXnPdbWtNbtHUBxUvtk5+eNMdXpLXPW0djtz2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840340; c=relaxed/simple;
	bh=Xhsz7wuoLR+x+XF6AZLs8r75mK36sEFmhNdDiP71pRs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uCbiOEBnYub/5lcnudOceDlpHVc0ZnISJB3N9DbRpqfRQfSHlzWYbDNeTtNHuOXoIY2vG/TlhjaSBGGwwU21DZs6piR+/Z/rIVg0WWNi1L2ywtlNmRY4kmC6sbM8M4sOWdx3r2obEBy20IOVeqhYEJ1MF/H+tycwimjNuS/9y4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A84AYt4u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0S0cdLQ9gUnRSIENZJ0gUiEWIZ50LEfX82jm6x9CLLw=; b=A84AYt4uGPMNGxvKBUST7flKVc
	WKcwVi/grcRjRuZJaBYQU/pFvxNQSLp+8YQ7A90c+++ZId80t7jy8/Sit/JZOTpHICPJGbBHfzZiZ
	nks5fJ98btK3MSyOes/pH2yUnSemSmjjh55kpZnf1GV4houJfHVbZ9SS+W+aNnRa0rKddWQgkPKQo
	+hToZ54IlMBETqapm3OtHk2kMcfl6IK8SGNbcbOS33l5oqPhf3MOfZi/KvimqhQvZ2hoc6coIVjXj
	qBYByUOiJrfQxR87NfKyhwzyr6hkzox+q0X5pT2LucvmyoDdj04oVH9ZqMaezUBuA+5UCXskcf0uW
	MjZrBW+Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34132 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL14a-0002Uq-27;
	Tue, 10 Dec 2024 14:18:49 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL14Z-006cZs-6o; Tue, 10 Dec 2024 14:18:47 +0000
In-Reply-To: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next 8/9] net: dsa: ksz: implement .support_eee() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL14Z-006cZs-6o@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:18:47 +0000

Implement the .support_eee() method by reusing the ksz_validate_eee()
method as a template, renaming the function, changing the return type
and values, and removing it from the ksz_set_mac_eee() and
ksz_get_mac_eee() methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/microchip/ksz_common.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index f5822c57be32..94f9aa983ff6 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3454,12 +3454,12 @@ static int ksz_max_mtu(struct dsa_switch *ds, int port)
 	return -EOPNOTSUPP;
 }
 
-static int ksz_validate_eee(struct dsa_switch *ds, int port)
+static bool ksz_support_eee(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
 
 	if (!dev->info->internal_phy[port])
-		return -EOPNOTSUPP;
+		return false;
 
 	switch (dev->chip_id) {
 	case KSZ8563_CHIP_ID:
@@ -3471,21 +3471,15 @@ static int ksz_validate_eee(struct dsa_switch *ds, int port)
 	case KSZ9896_CHIP_ID:
 	case KSZ9897_CHIP_ID:
 	case LAN9646_CHIP_ID:
-		return 0;
+		return true;
 	}
 
-	return -EOPNOTSUPP;
+	return false;
 }
 
 static int ksz_get_mac_eee(struct dsa_switch *ds, int port,
 			   struct ethtool_keee *e)
 {
-	int ret;
-
-	ret = ksz_validate_eee(ds, port);
-	if (ret)
-		return ret;
-
 	/* There is no documented control of Tx LPI configuration. */
 	e->tx_lpi_enabled = true;
 
@@ -3501,11 +3495,6 @@ static int ksz_set_mac_eee(struct dsa_switch *ds, int port,
 			   struct ethtool_keee *e)
 {
 	struct ksz_device *dev = ds->priv;
-	int ret;
-
-	ret = ksz_validate_eee(ds, port);
-	if (ret)
-		return ret;
 
 	if (!e->tx_lpi_enabled) {
 		dev_err(dev->dev, "Disabling EEE Tx LPI is not supported\n");
@@ -4651,6 +4640,7 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.cls_flower_add		= ksz_cls_flower_add,
 	.cls_flower_del		= ksz_cls_flower_del,
 	.port_setup_tc		= ksz_setup_tc,
+	.support_eee		= ksz_support_eee,
 	.get_mac_eee		= ksz_get_mac_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
-- 
2.30.2


