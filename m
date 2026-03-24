Return-Path: <netdev+bounces-271187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EP5L2XCwmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:57:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D53197FF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 999323053BBC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494D03EF0BA;
	Tue, 24 Mar 2026 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/kJTgvU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261413DCDB0
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371325; cv=none; b=H+EepRlcyAcZ82DyVqR2hXO6CAW2otW8urThFqcKdlizkQigenRIEpIMyzF6bz4inotPHUL2JiSug0z+qYLaCE/wQ1fXK6C6SyLeQR2+xpnGIt1IbzbzvEs3nkLUee6zDugWRGFvTa1FOA2xMFUyRSu0c5/5P/t77lU8b4Eiqlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371325; c=relaxed/simple;
	bh=5r1QnMw+vkFTIcuRXJoKO+7ZYkPN9lBP+lg9RoD/6+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ThiG/WRZ9WaV79Vp71Heag9txvHAzOrITcvsQ/Pg9jZ5rrAUm+1kUAH+aTVSI5Gxmx3zCZLCKs+N1rRRtSw8GEAExgSC5G1dtMHcJqZGH0oo/hl1NCGoqaLri7Aq8XDkimIIbHzlQM1cIvkMGe2uBnhKP5FUL/funz8iOHRln44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/kJTgvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1F9C19424;
	Tue, 24 Mar 2026 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774371324;
	bh=5r1QnMw+vkFTIcuRXJoKO+7ZYkPN9lBP+lg9RoD/6+Q=;
	h=From:Date:Subject:To:Cc:From;
	b=D/kJTgvUz5mozx+5jbyi1MlCtHBa4WEuewqhAmz9RmsYoxATT+Kbn+6fsG5HBSdzd
	 0rdqiRd/JBd5bH64ACfjWJ3Z1KvsqRXUTfnDUo9wrBQWvZDeNg22/aQdqFf4zmCrMu
	 H8EZvPuM3Y4NnwnRh1yl6gOtO1XiUez5reaFcAXdXfpTTsIxXVvv0eC4tgDEmGRRt/
	 ikFb7MjHJsltALhzwuL021lajda81fyZlvkRx8uGF27zymG7IOeHwFIHL5g0iuyzIy
	 Bt5X90OaSMZYYoKvFD7HZ/ieWG/uW1L9CT5h4ejBpfVD3+mLrHRlVwLBEPO1Qx1OAO
	 NH2gy30SJpFxQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 24 Mar 2026 17:54:45 +0100
Subject: [PATCH net-next] net: airoha: Grab flow_offload_mutex running
 airoha_register_gdm_devices()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-airoha-regiser-race-fix-v1-1-6014df55886b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAzAviI9W9imTvEr4mFot/Wi0oEIw79bP
 CaQVCgkTAXmpoLQzYXPQ8G2DWw5HImQd2VwxnnTOYuB5cwBhRJrihI2wsgPRpqGPnq7j96A1pe
 Q6v+8rO/7Abp+PClpAAAA
X-Change-ID: 20260321-airoha-regiser-race-fix-fe854f61d760
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271187-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A56D53197FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Netfilter flowtable can theoretically try offload flower rules as soon
as a net-device is registered while not all the other ones are
registered/initialized, triggering a possible NULL pointer dereferencing
of qdma pointer in airoha_ppe_set_cpu_port routine. In order to avoid any
possible race, grab the flow_offload_mutex running
airoha_register_gdm_devices().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 15 +++++++++++----
 drivers/net/ethernet/airoha/airoha_eth.h |  2 ++
 drivers/net/ethernet/airoha/airoha_ppe.c |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 82e53c60f561f6314fbf201ba8bc8711e40edc68..c1476032f78cbac95c9813bbeae6bec2c9c0a685 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2943,21 +2943,28 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 
 static int airoha_register_gdm_devices(struct airoha_eth *eth)
 {
-	int i;
+	int i, err = 0;
+
+	/* Netfilter flowtable can try offload flower rules while not all
+	 * the net-devices are registered/initialized. Grab flow_offload_mutex
+	 * to avoid any possible race.
+	 */
+	mutex_lock(&flow_offload_mutex);
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
-		int err;
 
 		if (!port)
 			continue;
 
 		err = register_netdev(port->dev);
 		if (err)
-			return err;
+			break;
 	}
 
-	return 0;
+	mutex_unlock(&flow_offload_mutex);
+
+	return err;
 }
 
 static int airoha_probe(struct platform_device *pdev)
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 7df4dbcd8861856c54c2a38bc89c69180ac2f6dc..9d97a54dbfdf9107a10bdb09cf144e5cf1ac9bdb 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -548,6 +548,8 @@ struct airoha_gdm_port {
 	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
 };
 
+extern struct mutex flow_offload_mutex;
+
 #define AIROHA_RXD4_PPE_CPU_REASON	GENMASK(20, 16)
 #define AIROHA_RXD4_FOE_ENTRY		GENMASK(15, 0)
 
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 7666b1d2f4f6ea758683181ab90d6fffb7bcd19d..96d092f7214ee3e80843a14528df66cabf79bc58 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -15,7 +15,7 @@
 #include "airoha_regs.h"
 #include "airoha_eth.h"
 
-static DEFINE_MUTEX(flow_offload_mutex);
+DEFINE_MUTEX(flow_offload_mutex);
 static DEFINE_SPINLOCK(ppe_lock);
 
 static const struct rhashtable_params airoha_flow_table_params = {

---
base-commit: b1c803d5c8167026791abfaed96fd3e6a1fcd750
change-id: 20260321-airoha-regiser-race-fix-fe854f61d760

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


