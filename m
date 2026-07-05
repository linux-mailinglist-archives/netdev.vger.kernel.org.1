Return-Path: <netdev+bounces-304798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y5BoNp6JSmr0EQEAu9opvQ
	(envelope-from <netdev+bounces-304798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:43:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E03E70A9A1
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:43:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sang-engineering.com header.s=k1 header.b=J7KNMk0k;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304798-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304798-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2971D3007899
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CB02E7374;
	Sun,  5 Jul 2026 16:43:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F898003D
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 16:43:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269786; cv=none; b=mCmS8rAPzZnG7HTuaRqA+c00tWO2ecgnwN1cOMMzjxxYkES/jkcxepC3P4vbXdiQHpXoqEuxlRX47apewAcJVdpGa1EPBbFY3msQMQ+RcarsCGoiLyeTtPkd8exJbLY3/l3EOmaJ5kpO042mI0bNAkCORTo/EDrhgS2RL1gnY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269786; c=relaxed/simple;
	bh=gYyKwV4JpN3uA5KQMgScFd1EP+GspcSck5WeMsOk1i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWyzQIFUBBnjI9mlRMJFLh3RwUXNLggW6QrUxmaHYBjOTClrd+X3ENieOXOcgG6mnITYLBqDtZlc3KBcm31LEs/3HK+hkes1IiHNmu0s8kVKZxMQvF2Hf0ZwWCqpwN2mnEj5921dsLKuvEaW/+RXfnvD+SW5K8IQSq/RlOqlLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=J7KNMk0k; arc=none smtp.client-ip=194.117.254.33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=sAwLMaDBVqVN0C
	bUuOcwihTDdG1LMgecEQPnGoaS2RA=; b=J7KNMk0kopIsLYdvWSPv+86XzVXSDY
	ezMyPb1DHRzovqWYOKH1JF/Id8X/iLubrKFny7KwLIwcxGSXMab9jZwhJbamznU8
	ctyixjk1u78zSrogA38wHpHEiNWjavStrwBO53h8QmVLWmNRoz2FYDeB/K+0tltG
	Isbtho/7hWt4PpGTWmZz/Of91tk8QsUQ28FAiWmAbgZzle6HNyeLV/ZhAylK6T+K
	C+IZqes3aIzFkAMzVrHAniyKqOMlI7CGdXiwexdLsQ1peE1ioJdNoM1/MM3a/CKU
	rCJk3eSbLs0fPDbAlpD810cEQRA503+iPX1/uWdAkOmtd8/lM3hHyrVQ==
Received: (qmail 2289212 invoked from network); 5 Jul 2026 18:43:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Jul 2026 18:43:02 +0200
X-UD-Smtp-Session: l3s3148p1@sxjn2d9VhW1tKjFj
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Luo Jie <jie.luo@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: qualcomm: remove unneeded 'fast_io' parameter in regmap_config
Date: Sun,  5 Jul 2026 18:41:59 +0200
Message-ID: <20260705164208.2184-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304798-lists,netdev=lfdr.de,renesas];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:wsa+renesas@sang-engineering.com,m:jie.luo@oss.qualcomm.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:wsa@sang-engineering.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sang-engineering.com];
	FORGED_SENDER(0.00)[wsa@sang-engineering.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sang-engineering.com:from_mime,sang-engineering.com:email,sang-engineering.com:mid,sang-engineering.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E03E70A9A1

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/net/ethernet/qualcomm/ppe/ppe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index be747510d947..3c301e609d3e 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -106,7 +106,6 @@ static const struct regmap_config regmap_config_ipq9574 = {
 	.rd_table = &ppe_reg_table,
 	.wr_table = &ppe_reg_table,
 	.max_register = 0xbef800,
-	.fast_io = true,
 };
 
 static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev)
-- 
2.51.0


