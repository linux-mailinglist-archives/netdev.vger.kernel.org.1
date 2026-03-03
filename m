Return-Path: <netdev+bounces-263301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PG8BpwHp2k7bgAAu9opvQ
	(envelope-from <netdev+bounces-263301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:09:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E41B1F350B
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30DD9308A42B
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A4A494A04;
	Tue,  3 Mar 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="TnFojP2S"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FAE39D6F1;
	Tue,  3 Mar 2026 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553776; cv=none; b=k4Io2gIMOA53BDrvu0Gh4mE34WhIUZbFQa7mOcbAfa89wm/1rc/Ie8gDvP1mjdayg7raeY/EP7SsjcJTo5tc+LLqtQ6uv36Hw/aosYJ/0uSRppFB+Zdr9J5dTgT3jHrqUxrViW4lg2Da9iyhqEnI8zVE6pW94z2j8Nzt4YFu81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553776; c=relaxed/simple;
	bh=KvHTEmnr7gWbV+0Xz3UVbTSHm6tZc9l8y2DGDFuMnVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DV4nj1SWgZ396EDmVTm7KASiOjLQ8gkYw8wn/Zf4gNPBWDfDA8XFqz9WY+OXpZegceQv42oQn5r8U/y1Q0d8MszYefYitX7A5Vu47fQ99cfL0G3W32LOX00dwiB3FwML1KhcyZbEgp7SVmOla2vuLO/0NBqan56/WhSyU/vG0uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=TnFojP2S; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C003BA5067;
	Tue,  3 Mar 2026 17:02:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772553768; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=XsV1jm103adERM5w5wXGl8b43osRl+o5icPW4EqXFOI=;
	b=TnFojP2SiLCfBg6gOwEIMoii/hv/WOSrsvHqGr8pnZlc/oghLUhpZIidIqndRIFSo+fPNB
	rfqf3yJYP750A1iaiJNmih2ZdHs5ryJInCTcNKZWTkGr7LQ5PmGAVvg5bTVjOUFJd/5sXG
	kwlNwfwJ80fq6VxcQKEukzetqfiznMDGVhuQXACJoqtsBEa7XaFxOC0ey9/I1MEGdzP22T
	/KzMbwJ/qcv3RY0pKDyfOlBOuNCCZptOh86SD+W5RmEOukQRE9D5XyQSvStnkipmnEfAc2
	l2ioFUIsYf5ZTldnVbw5sa7Gl82/U7jTexSdZ5BNCJ4ptQV0Nrt+nyyMbCR75Q==
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
Subject: [PATCH net-next] net: bcmgenet: enable EEE TX LPI by default
Date: Tue,  3 Mar 2026 17:02:25 +0100
Message-ID: <20260303160225.542613-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 6E41B1F350B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263301-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tipi-net.de];
	FREEMAIL_TO(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

GENET never initializes priv->eee.eee_enabled or
priv->eee.tx_lpi_enabled to true, so the link-change callback in
bcmgenet_mac_config() always calls bcmgenet_eee_enable_set() with
enable=false.  The result is that EEE is negotiated at the PHY level
but the MAC never enters Low Power Idle, wasting the power savings
that EEE is designed to provide.

Users can work around this with 'ethtool --set-eee eth0 eee on tx-lpi
on tx-timer 250', but the MAC should enable TX LPI out of the box when
the hardware supports it, consistent with how phylink-managed MACs
behave (phylink calls phy_support_eee() which sets eee_enabled=true and
tx_lpi_enabled=true by default).

Initialize EEE software state during bcmgenet_open() on GENET v2+ so
that the link-change path activates EEE in hardware once the PHY
negotiates it.  Use an LPI timer of 250 us, matching the default used
by other MAC drivers (mvneta, mvpp2).

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 33fece36a95e..00ce93b8a6fa 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3375,6 +3375,16 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_phy_pause_set(dev, priv->rx_pause, priv->tx_pause);
 
+	/* Enable EEE by default on hardware that supports it.  This sets the
+	 * software state so that the link-change callback will activate EEE
+	 * in hardware once EEE is negotiated with the link partner.
+	 */
+	if (!GENET_IS_V1(priv)) {
+		priv->eee.eee_enabled = true;
+		priv->eee.tx_lpi_enabled = true;
+		bcmgenet_umac_writel(priv, 250, UMAC_EEE_LPI_TIMER);
+	}
+
 	bcmgenet_netif_start(dev);
 
 	netif_tx_start_all_queues(dev);
-- 
2.51.0


