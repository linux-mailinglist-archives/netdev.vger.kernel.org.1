Return-Path: <netdev+bounces-259354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOOSGqIZlmkSaAIAu9opvQ
	(envelope-from <netdev+bounces-259354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 20:57:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04223159470
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 20:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72226301C6F7
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CD134846C;
	Wed, 18 Feb 2026 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Kogft3yF"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C66345741;
	Wed, 18 Feb 2026 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444637; cv=none; b=cHuzNXP8+AdwO7yjgLL+6n+pMPTeVrROihmwu8Rj04urBKj35z2LTnUQvaFlOGQpRESpw0yf9SRPKLme5tKpEeVXpacE555M1BktGyCGkBKvIKUbDwx8MCsK4NcbnV0Jmjli2iCzRdH1AuzNY5Yn/TJZUCqG+R9o1RcrcoVtR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444637; c=relaxed/simple;
	bh=h2BiBz+DfieSHe3tI/Njgc7TA1kWLssBIRP/12PL2iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SqUhDcDV+hdAi5QXUrw7fSebhTH3F9mEhHpzMGpZpLv7hs7z3X9cpNwzxhscxZMhPGc0CrA5PQbNmPHwZMa1DUn2oUaDUctyQm0xgeuRQT+jhWnpEB663dxuA1wh7JQ7FhF4g3FL2t7yvHC0B74GxKYSMfCjUDlYg4z8ChJxH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Kogft3yF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9810BA034E;
	Wed, 18 Feb 2026 20:57:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771444633; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=pR6GVLXGqByomxqwQ5CVsKqzX3AIx0j3FQbyTqkfcRc=;
	b=Kogft3yFxdoI3G3kUVfJTZ7vQOv13v1oZkmAai548h2iHUJ2RiYgdTfRhNalh6Y41Bnl8V
	1b8KIZnCZlEXUpXrHP2etdXMqDN9pIPv44MHgINkeeRhQLSJK3jbMRCOOi1Sr3swRT7BZS
	ssf+AqjlukeaPJtP316EL3z5mOCuCT6npzjCiwnTfEhckGX8jM3TBb8IlxYfQkr1FDPyqL
	friaQBJ0n408F/bT3GqW2ESoPpqqcfbI3YszZFqc/HtrofCChNrO5mbbEu2ZiLawDg1SGi
	r6WSI4PZcxpmtkEb2dMaz/DLchs2FFJVGnhvoUBKH2OqFoTY2hRIC5p4vbZrqw==
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
Subject: [PATCH] net: cadence: macb: add ethtool nway_reset support
Date: Wed, 18 Feb 2026 20:57:04 +0100
Message-Id: <20260218195704.25769-1-nb@tipi-net.de>
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
	TAGGED_FROM(0.00)[bounces-259354-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email]
X-Rspamd-Queue-Id: 04223159470
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
+	.nway_reset		= phy_ethtool_nway_reset,
 };
 
 static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
2.39.5


