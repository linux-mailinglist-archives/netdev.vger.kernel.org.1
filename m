Return-Path: <netdev+bounces-294671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ezEKCg/fH2ocrgAAu9opvQ
	(envelope-from <netdev+bounces-294671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:00:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B62E63572B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:00:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=HmtZXX4n;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294671-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294671-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 352A3309C9C7
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CC940628A;
	Wed,  3 Jun 2026 07:57:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F179405C4D;
	Wed,  3 Jun 2026 07:57:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473476; cv=none; b=T8IdIqNz/8zYTthQy4miMp/5pRfwoKx+ub3s4/DVUy8i575VWMig5LdbNTlb9PgCx1waSa/jOmYS+zerffRPgdDt8KplZY/AoWVCvDLes6dorK9LBmcgBBJ+L19g97sQXQM5zFteQl8cCFUeB8cKN8/k5zZtQs/RWkss6sF3plw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473476; c=relaxed/simple;
	bh=+v78t5r+l4tSJyQHu8/3diPfqLNUodw+CjqVIQcnaYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rbd57DqFmLp2yA28PAC0vxcFBS/eiRHSaFiy+fSw02Vqwz1rW1O+ChIe8AZ3nVR7CNihpSqgt3u5DMVTMJ9+tS9SgEuAJ9DBsVDX0xY6Y1Qwv/m2VaYq0lWD1s3Bsxpvzin/zSz7E86T05KZE17BF9fSCbRhi2OpUpAcGAF72iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmtZXX4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A878CC2BCC7;
	Wed,  3 Jun 2026 07:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780473475;
	bh=+v78t5r+l4tSJyQHu8/3diPfqLNUodw+CjqVIQcnaYI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HmtZXX4nKUHGrM0wbAbEoRhunyuD5nFzcHDNef4poEIjKQ9rfvAyCUZjLeKoAfUOJ
	 6Q62lm01TKyshWB2+HSCE73P6IuyMKuXD69NQQCN+vzRI/pd33JJgGwz4xq+b82Erj
	 /sj5h21Lm8KQPxYCP7iXoEovZ8FTzlLQ5/uLjwBrC3+OkPb3sjKGvteAqx1bI6/aDZ
	 eYYMbplax8sKWCV1MrYgykvZfpwFN0+R6ZhUnQQO8jKE04lRMDOdmkY7aHvzy7trwj
	 8d526tySMTouHa8UtvW/qoQMcaMi3Mz6s53yc3zZcV2LgBayqWboCUvGk7N0E4s+xo
	 tlRETiGVlNHxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9045DCD6E64;
	Wed,  3 Jun 2026 07:57:55 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 03 Jun 2026 11:57:39 +0400
Subject: [PATCH next-next] net: dsa: qca8k: Add support for force mode for
 fixed link topology
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-qca8337-force-mode-v1-1-caf7670ffab3@outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MMQ6EIBAAv2K2vk0QlNP7irFAXLwtBAVjTIx/F
 20mmWLmhESRKcGvOCHSzomDz1J+CrB/4ydCHrODFFILLRSu1jRKfdGFaAnnMBK6wQ6mlq2uKg0
 5XCI5Pt5pB56ODR9Af1038ubuu28AAAA=
X-Change-ID: 20260603-qca8337-force-mode-fbcba5296446
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780473474; l=1952;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=kxqS2bqjt6+ouza+vz/puCI2oc93WI/rb8uky+fmGoQ=;
 b=5fbNiQpDmiLWqNtCEftWZ+N3nuB7FW5BbnHHC7D4Do5MPkWYC9NnnMxRf1e83dHAmQ61uv8/z
 wg2uxmINcW0CtoyPAhqd9FBTaMhTNVrs9PDVccIbV1RoP76WdH2wz1k
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:george.moussalem@outlook.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294671-lists,netdev=lfdr.de,george.moussalem.outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[george.moussalem@outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,outlook.com:mid,outlook.com:email,outlook.com:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B62E63572B

From: George Moussalem <george.moussalem@outlook.com>

A fixed link topology is commonly used to connect this switch (on port
0 or 6) to a SoC's MAC over SGMII. When inband negotiation is not used,
the switch needs to be configured to operate in force mode. As such,
enable support for force mode.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 6 +++++-
 drivers/net/dsa/qca/qca8k.h      | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index a36b8b07030e..3dbd18ab8638 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1611,10 +1611,14 @@ static int qca8k_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	if (priv->ports_config.sgmii_tx_clk_falling_edge)
 		val |= QCA8K_PORT0_PAD_SGMII_TXCLK_FALLING_EDGE;
 
+	if (neg_mode == PHYLINK_PCS_NEG_OUTBAND)
+		val |= QCA8K_PORT_PAD_SGMII_FORCE_MODE;
+
 	if (val)
 		ret = qca8k_rmw(priv, reg,
 				QCA8K_PORT0_PAD_SGMII_RXCLK_FALLING_EDGE |
-				QCA8K_PORT0_PAD_SGMII_TXCLK_FALLING_EDGE,
+				QCA8K_PORT0_PAD_SGMII_TXCLK_FALLING_EDGE |
+				QCA8K_PORT_PAD_SGMII_FORCE_MODE,
 				val);
 
 	return 0;
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 1a00e2f62fef..956338893032 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -58,6 +58,7 @@
 #define	  QCA8K_PORT_PAD_RGMII_TX_DELAY_EN		BIT(25)
 #define   QCA8K_PORT_PAD_RGMII_RX_DELAY_EN		BIT(24)
 #define   QCA8K_PORT_PAD_SGMII_EN			BIT(7)
+#define   QCA8K_PORT_PAD_SGMII_FORCE_MODE		BIT(3)
 #define QCA8K_REG_PWS					0x010
 #define   QCA8K_PWS_POWER_ON_SEL			BIT(31)
 /* This reg is only valid for QCA832x and toggle the package

---
base-commit: b7bee4ca5688e30ca50fbc87b1b8f7eed7006c17
change-id: 20260603-qca8337-force-mode-fbcba5296446

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



