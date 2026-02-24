Return-Path: <netdev+bounces-260555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFAiNGm9nWnzRgQAu9opvQ
	(envelope-from <netdev+bounces-260555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:02:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7B4188C5D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D0930A3B0E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A5B3A0E8B;
	Tue, 24 Feb 2026 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="LfVyMaBz"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731103806A6;
	Tue, 24 Feb 2026 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945063; cv=none; b=RtPobJQUgA6Z36eKTjSJJ2hro5OXJ2Mz92I0dgPRx0WesEmR13AnaUYfWkYVmQteBsbHB8PhwrXI6THKlL22wyrNOwxrzXDGwbPm/dB5gn9ebL/4LkfEnLtSq/DD8vCoYDOtoxyH2TQXKPvwmx63FEVDG7pT7PiS4cf+nIb08u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945063; c=relaxed/simple;
	bh=l9vnZ2N4ndNRsyJ2Ypz6h53gBR793pMOJKd23O4KQ9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q5QS22VX0C0lLsiBsoIyc1fxpeKeADus8b+c9lNEWJgNGrih3f21qPtw4RT1oOpY2i9/A3YxQegNrAklBi9YEuI4Adn4z7zp6sC7gW3CS0AupYst91VxjLzc7RkIPogHXDAvRckx017jYQWmpDZBmM5SjO8y5i7w3Mf3p3idZ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=LfVyMaBz; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28F66A0364;
	Tue, 24 Feb 2026 15:57:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771945057; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=pR6GVLXGqByomxqwQ5CVsKqzX3AIx0j3FQbyTqkfcRc=;
	b=LfVyMaBz7KYLqahA3Q4TOw1ggLPF2HnKT63TSycsXvXwpt/XW41Xe0JhegVX6PfaU91BJ9
	PY+rjSwv0+w/6q2uGTWNXpOO+f6vwhFPyaN1u0mDjxzGIEac8fHSdbXgghencgMOSf+edW
	8K5U9uUgtsf7B+dnnFyvadT2HVCAO8lJj628tRQYB85twD0oGJrFFd/5R2ojxsMVHp2ubU
	tPF3vscVqWZEoFai9Tfanab+AHi2wuKOngevBiyIyzyCsg0xY192EVNuK6G4W8Y61R3OjB
	f3l9YYiBpm/FXYkarN+Nqj5zgHwsTlrQkikcmx65DykwmP1FCkYpvV6PmASWng==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: cadence: macb: add ethtool nway_reset support
Date: Tue, 24 Feb 2026 15:57:23 +0100
Message-Id: <20260224145723.49450-1-nb@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260555-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_URIBL_FAIL(0.00)[tipi-net.de:query timed out];
	DMARC_NA(0.00)[tipi-net.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[nb.tipi-net.de:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F7B4188C5D
X-Rspamd-Action: no action

Wire phy_ethtool_nway_reset() as the .nway_reset ethtool operation,
allowing userspace to restart PHY autonegotiation via 'ethtool -r'.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..47fd85cd9613 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3945,6 +3945,7 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.get_rxnfc			= gem_get_rxnfc,
 	.set_rxnfc			= gem_set_rxnfc,
 	.get_rx_ring_count		= gem_get_rx_ring_count,
+	.nway_reset			= phy_ethtool_nway_reset,
 };
 
 static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
2.39.5


