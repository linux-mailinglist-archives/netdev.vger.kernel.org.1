Return-Path: <netdev+bounces-261257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG8pJ/cNoGnbfQQAu9opvQ
	(envelope-from <netdev+bounces-261257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:10:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9CE1A32D6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89AFD30F52F4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B54399029;
	Thu, 26 Feb 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="g83q9yol"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311FC395269
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096798; cv=none; b=SXPIwdQifKE3IkV9l4eZfZkn3I6LevmExTL4GdL3KqxfiIU6ldAnkXF9Jw2JQ0hr0QzXaPxx/32qoyFyc3IdUWFrmb9gCwTT6b9KMFmgmXH0RWDsTgcZl1TIEBmD/SVaboqyym+ohgTF7KOGiyDgVgno9pZEEgrC0xMqR2JG0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096798; c=relaxed/simple;
	bh=n63b4Ffnhv2zySw/JD2R+cxH18bBKNVk4LRD0T3ivOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EO8NhfJhZ9EkODu7usreHbVg7PC13tyRI6BBzNkfdxK4ak24MDOQLsSly6ORHUaZNKBeOmGZrc4w1Z4W+eiVKdOUsexUaiDrVR9AwtggkMgBbb3oEgtNgjPlRTPN4bbeBWDFCyiWF/80HefuCyQTsbotXVLx+vyYsXPup1jQhkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=g83q9yol; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 289D2A445D;
	Thu, 26 Feb 2026 10:06:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772096794; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OL7oERbZT9pmoVyR3ii4qa+x/vINl0XE5iozDnBkiGU=;
	b=g83q9yoloaVfxYhLeHcAp9o3hOlnmXLMBWn4pAiE+FKVWr1lNtrgjNjt6VKX6soAVbkY8W
	KebErq6ehKAIYQLC5Q8nGHXgEDRRj8NaqGDb1/60kRkif0LeXG5Ghg3kUUYZN3BK2R/PCq
	Ng7rPBraDkW+r0ZkZRuxk5VttfNEXzulU9VawwKl+H4pSfQ1UnVDWCy9i0YzGO1AnSGor1
	lyaAqhSSMdu2CZ8aIY7If5gzZ7uh1CQ9vsj4MaguQYSx8WY7I2HmdryiBs2GtHjGZT2oz7
	Ib3Ys5gA4/lh8F9qF30DBSZuBq+yy01Actm/PZ8O7OAT/G7Dya7r49tlTFzSUQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	theo.lebrun@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v4 3/4] net: cadence: macb: add ethtool EEE support
Date: Thu, 26 Feb 2026 10:06:07 +0100
Message-Id: <20260226090608.54802-4-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260226090608.54802-1-nb@tipi-net.de>
References: <20260226090608.54802-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261257-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: DC9CE1A32D6
X-Rspamd-Action: no action

Implement get_eee and set_eee ethtool ops for GEM, delegating to
phylink_ethtool_get_eee() and phylink_ethtool_set_eee(). Both
handlers return -EOPNOTSUPP when MACB_CAPS_EEE is absent, keeping
the ops safe to register unconditionally in gem_ethtool_ops.

Phylink owns the full EEE lifecycle: PHY advertisement, link
partner negotiation, timer management and ethtool state; the MAC
driver only provides the mac_enable_tx_lpi / mac_disable_tx_lpi
callbacks wired up in the previous patch.

Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6b9c63195970..a7e00b99e9a8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4034,6 +4034,26 @@ static const struct ethtool_ops macb_ethtool_ops = {
 	.set_ringparam		= macb_set_ringparam,
 };
 
+static int macb_get_eee(struct net_device *dev, struct ethtool_keee *eee)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	if (!(bp->caps & MACB_CAPS_EEE))
+		return -EOPNOTSUPP;
+
+	return phylink_ethtool_get_eee(bp->phylink, eee);
+}
+
+static int macb_set_eee(struct net_device *dev, struct ethtool_keee *eee)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	if (!(bp->caps & MACB_CAPS_EEE))
+		return -EOPNOTSUPP;
+
+	return phylink_ethtool_set_eee(bp->phylink, eee);
+}
+
 static const struct ethtool_ops gem_ethtool_ops = {
 	.get_regs_len		= macb_get_regs_len,
 	.get_regs		= macb_get_regs,
@@ -4055,6 +4075,8 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.get_rxnfc			= gem_get_rxnfc,
 	.set_rxnfc			= gem_set_rxnfc,
 	.get_rx_ring_count		= gem_get_rx_ring_count,
+	.get_eee		= macb_get_eee,
+	.set_eee		= macb_set_eee,
 };
 
 static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
2.51.0


