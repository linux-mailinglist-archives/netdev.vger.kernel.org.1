Return-Path: <netdev+bounces-263285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIp5MvoBp2k7bgAAu9opvQ
	(envelope-from <netdev+bounces-263285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:44:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D731F2DEF
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57DF03029781
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8EF3822AE;
	Tue,  3 Mar 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="azFQesF/"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773AD390991;
	Tue,  3 Mar 2026 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552379; cv=none; b=nTVbSQU7S1v5qwo0EjsAPh0n43+DbTjJrA763V0u51HR6BQyFze1R+p6y8kd5qvBHgKp31n3YkuvMoyeqO6XVjltwHpBBXaYoRSp0HubitjnCe/4Z0czP1EVHyDLWc05ufl0ffVzz4S2zzZNrCv2V0bSpq1p2I5/lAzg33aRVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552379; c=relaxed/simple;
	bh=X4DEuRTMcYBBmg4ADb9KxDAkixz9RcQDpLYu82FOhI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NmL30Hln7lWMQUDKSj1H5enoH1/l2gLy/+7yXmZxrV6Sg2pwg/ZjSupTtZiI5/HT07PJy43nQk794U4kV4xciqzLV1QCgmX2E4fqz/D6FwyVhxsmyjEve/YN+GkU3TSdci8IDHEas+XBSN5Box1L7iXUx6FLBK64hCPA/b8r+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=azFQesF/; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CAD86A4F9F;
	Tue,  3 Mar 2026 16:39:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772552367; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=AodmNee/EBdtxzzezVlKmHaX6z5HN0ExASYg0+d4fIQ=;
	b=azFQesF/clKc390bKioI1qEaZ4sMmtmkk6Cz4ih47OOO+F/SW8QQeqypcyj3G9tMmEZyzt
	sd7HH04vx8/TINjM2SurbFlKBg77CqORyxBU1I+1Segk6OC9ggIr6MjKNbZUiWcibSt2mI
	UVgcTYCvogiWcUvdMASSJqPf93tT+mRR6BHWM2PhBO1MCNPpZYCZnlz7nujtie1lOtUCK1
	QsshzcBl3pbSadRRIq55yG3FCogIlImi07i3sagmPV1nOdvu2WvkGLkbyyv/tDB0ML9431
	/kgkd2JZl4VIm7jdB5k4hoLOOS3n0O6MwgnKuX/b0EJ+JyS7MOF81FseeaRhaQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net] net: bcmgenet: fix bcmgenet_get_eee() clobbered by phy_ethtool_get_eee()
Date: Tue,  3 Mar 2026 16:39:18 +0100
Message-ID: <20260303153918.538902-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 29D731F2DEF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263285-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Action: no action

bcmgenet_get_eee() sets the MAC-managed tx_lpi_enabled and tx_lpi_timer
fields, then calls phy_ethtool_get_eee() which internally calls
eeecfg_to_eee() — overwriting eee_enabled, tx_lpi_enabled and
tx_lpi_timer with the PHY's eee_cfg values.  For non-phylink MACs like
GENET, these PHY-level fields are never initialized (they are only set
by phylink via phy_support_eee()), so the ethtool report always shows
eee_enabled=false and tx_lpi_enabled=false regardless of the actual MAC
state.

Reorder the function to call phy_ethtool_get_eee() first, then restore
the MAC-managed fields from the driver's private state.

Fixes: fe0d4fd9285e ("net: phy: Keep track of EEE configuration")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index a71cd729fde6..33fece36a95e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1390,6 +1390,7 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct ethtool_keee *p = &priv->eee;
+	int ret;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
@@ -1397,10 +1398,19 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!dev->phydev)
 		return -ENODEV;
 
+	ret = phy_ethtool_get_eee(dev->phydev, e);
+	if (ret)
+		return ret;
+
+	/* Restore MAC-managed fields that phy_ethtool_get_eee() overwrites
+	 * with the PHY's eee_cfg (which is only set by phylink-managed MACs
+	 * via phy_support_eee()).
+	 */
+	e->eee_enabled = p->eee_enabled;
 	e->tx_lpi_enabled = p->tx_lpi_enabled;
 	e->tx_lpi_timer = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);
 
-	return phy_ethtool_get_eee(dev->phydev, e);
+	return 0;
 }
 
 static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
-- 
2.51.0


