Return-Path: <netdev+bounces-259943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPxdIwUWnGkq/gMAu9opvQ
	(envelope-from <netdev+bounces-259943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:55:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1636173561
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2189301FAAD
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752B834D903;
	Mon, 23 Feb 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Wl/algA3"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71D34DB59;
	Mon, 23 Feb 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836928; cv=none; b=X76zZgMnLcdmzuXdmQ8FveUZFp2Z7q0x+SLHVvSoPp3eQcnlPuZoPuxKXAbpq4hw88aDiJxq8vPBXUR2d8R6oCcFGbtrIPtbOKkHbiAIuqj6tJCj2Sfqt7u+ZLnVWlV/qBOoZX/Owf1Gctugi4cRTMvZELlZa+2O+s2ObFJXl9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836928; c=relaxed/simple;
	bh=ZzEDcJRcTp7f+irbi5h36BguC6lX6oTQyXuhoXgjY+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gU6nBbI80T7o2Km2RhkPPpclg2R8wfqKmiIwW3krv9nt1GkcSjxfC+2G+OM2ZKlzj/BwRjE82aDviHI2Tc66UlPBAJJ0k3KAZmG2c897v+jCtBd5P4hM9f6vVFNjGgh54E2T2dSx/3L/P2uh/JKv2R3TdZzvFQsEkm5cpqE70p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Wl/algA3; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB49FA02E5;
	Mon, 23 Feb 2026 09:55:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771836916; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=pCJoFEal8tJ3i46WcikENP1f/excTslKdDBJyw5ZBpo=;
	b=Wl/algA3DmZsyYgxW9Fk/S1gZda8/tDarXqxtrwIlJNKNWR8eYCswubEgYSuUL4j48RCpC
	bMihuOjQvrFFMPK//qOiFyOb/P9mvR0Va5w1Vx1iuPpFjjnXeQ/tYqV8yp45vnJmNKDEMv
	/4ylYlKBexeeEJEhgC2JlWXwcue5idj5O7vc9B7Vwn/UQT5I37Rvie6ugUzxExmrWfZfwO
	WuOcL7aXRUjbLj6idsR1nEShHge5ogiMXHp6DztDTZghymrHDoxC3Bltv9MH8GJZaYGdo/
	W2Ouu5IDg8zm5aETQCK0HhTB6QUWokjNiUJS1zrmuzrDfYl3hdNNkMvwumO79A==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	Russel King <rmk+kernel@armlinux.org.uk>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: microchip: lan743x: add ethtool nway_reset support
Date: Mon, 23 Feb 2026 09:54:42 +0100
Message-Id: <20260223085442.42852-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259943-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email,armlinux.org.uk:email]
X-Rspamd-Queue-Id: A1636173561
X-Rspamd-Action: no action

Wire phylink_ethtool_nway_reset() as the .nway_reset ethtool operation,
allowing userspace to restart PHY autonegotiation via 'ethtool -r'.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Russel King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/microchip/lan743x_ethtool.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 8a3c1ecc7866..9195419ecee0 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1079,6 +1079,13 @@ static int lan743x_ethtool_set_eee(struct net_device *netdev,
 	return phylink_ethtool_set_eee(adapter->phylink, eee);
 }
 
+static int lan743x_ethtool_nway_reset(struct net_device *netdev)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	return phylink_ethtool_nway_reset(adapter->phylink);
+}
+
 static int
 lan743x_ethtool_set_link_ksettings(struct net_device *netdev,
 				   const struct ethtool_link_ksettings *cmd)
@@ -1369,6 +1376,7 @@ const struct ethtool_ops lan743x_ethtool_ops = {
 	.set_rxfh = lan743x_ethtool_set_rxfh,
 	.get_rxfh_fields = lan743x_ethtool_get_rxfh_fields,
 	.get_ts_info = lan743x_ethtool_get_ts_info,
+	.nway_reset = lan743x_ethtool_nway_reset,
 	.get_eee = lan743x_ethtool_get_eee,
 	.set_eee = lan743x_ethtool_set_eee,
 	.get_link_ksettings = lan743x_ethtool_get_link_ksettings,
-- 
2.39.5


