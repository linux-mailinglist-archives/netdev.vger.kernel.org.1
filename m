Return-Path: <netdev+bounces-282353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAExIr7k8WlZlAEAu9opvQ
	(envelope-from <netdev+bounces-282353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:00:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 150CB493488
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F0BF305FFF0
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E153EFD31;
	Wed, 29 Apr 2026 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwijJHAh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB13EFD25
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460090; cv=none; b=powyDxhTj7Lz6irYPLanc6oiT6I3LWQh3U8bvq4GyplcznoAkZvz2TSrRPI0k+DwkhJgLMmOwv1ILSa3HtEJjdO4vHR1nFptz62Erlk9vBR52N9YFoYLEuppk/JdHASAmvgCqPstfdk3OF5xyOB2zfd28rYqnx0hV85aYuaXUGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460090; c=relaxed/simple;
	bh=om1Fe7It+6J1z9grQKr36pV/sKz2OmpOHZfAVAT8vfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ooOrwv+ZmiL+y2VzYlmWjEmFdVfHBUawitdHsbf994yIDDgvBld0xMRwfGej9v5IqfWyXuO1RK6lv9qDJCi7rPp5dcKcObKgJu8adLML5/g8VV//vmop0t5B3h5C0tms4Q/iIJ1IB4C20co32pUsl1rD8L6CI89KH5j6dLrX+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwijJHAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52051C19425;
	Wed, 29 Apr 2026 10:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777460089;
	bh=om1Fe7It+6J1z9grQKr36pV/sKz2OmpOHZfAVAT8vfU=;
	h=From:Date:Subject:To:Cc:From;
	b=CwijJHAhARN5SzP09kYc9FoF7yhLEfR4u/L1YPM0Tx8xoT9ZNWwzmjVfrXl3waY2H
	 XZ3sybKb3+VU5sw9h5RQD0hE8o8OXW1umNXFCBW19kkynkuOtUO99k8PFuYOzjUqdW
	 8X7N7/8P7nP0cHS9pB/5FJJ7VqG0MMuCHbi+GAKnev6SuVcw/fuw/JR5Tn1U/7SL0f
	 mFegwc2neebWMSVFT9ULuWOMUH+AXmCqR7C0aPBbKaRImuuKrqu7eBXpFZERH5PzPO
	 yLYesYkvYfoesZOHiD4GnIpMXi5RBoNEeE6hAHbFgFiot56iDFh0rv1aO8Yn2XSLlU
	 Mb63Twzlwo0vQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 29 Apr 2026 12:54:32 +0200
Subject: [PATCH net-next v2] net: airoha: Introduce
 airoha_fe_get()/airoha_qdma_get() register read helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-airoha_fe_get-airoha_qdma_get-v2-1-909e791f1dc0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQqDMBBFryKzborGoNJV71FERp3o0DZpJyIW8
 e4Nge67fLzP+zsEEqYAl2wHoZUDexdBnzIYZnQTKR4jg851lRvdKGTxM3aWuomWH73HJyauMW9
 q1CWSNRAbLyHLW+rfwMWBo22BNpqZw+Llk47XIvk/P9ZCFaoabD9Sb3RtyuudxNHj7GWC9jiOL
 1izSnzVAAAA
X-Change-ID: 20260428-airoha_fe_get-airoha_qdma_get-7a087a23aef4
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 150CB493488
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-282353-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add airoha_fe_get() and airoha_qdma_get() as utility routines for reading
a masked field from a specified register.
This is a non-functional refactor, no logical changes are introduced to
the existing codebase.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Fix typo in airoha_qdma_get() definition.
- Link to v1: https://lore.kernel.org/r/20260428-airoha_fe_get-airoha_qdma_get-v1-1-6cfbdeb42743@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 13 ++++---------
 drivers/net/ethernet/airoha/airoha_eth.h |  4 ++++
 drivers/net/ethernet/airoha/airoha_ppe.c |  5 ++---
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 2bb0a3ff9810..40b7a00c7d95 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -201,15 +201,13 @@ static void airoha_fe_vip_setup(struct airoha_eth *eth)
 static u32 airoha_fe_get_pse_queue_rsv_pages(struct airoha_eth *eth,
 					     u32 port, u32 queue)
 {
-	u32 val;
-
 	airoha_fe_rmw(eth, REG_FE_PSE_QUEUE_CFG_WR,
 		      PSE_CFG_PORT_ID_MASK | PSE_CFG_QUEUE_ID_MASK,
 		      FIELD_PREP(PSE_CFG_PORT_ID_MASK, port) |
 		      FIELD_PREP(PSE_CFG_QUEUE_ID_MASK, queue));
-	val = airoha_fe_rr(eth, REG_FE_PSE_QUEUE_CFG_VAL);
 
-	return FIELD_GET(PSE_CFG_OQ_RSV_MASK, val);
+	return airoha_fe_get(eth, REG_FE_PSE_QUEUE_CFG_VAL,
+			     PSE_CFG_OQ_RSV_MASK);
 }
 
 static void airoha_fe_set_pse_queue_rsv_pages(struct airoha_eth *eth,
@@ -227,9 +225,7 @@ static void airoha_fe_set_pse_queue_rsv_pages(struct airoha_eth *eth,
 
 static u32 airoha_fe_get_pse_all_rsv(struct airoha_eth *eth)
 {
-	u32 val = airoha_fe_rr(eth, REG_FE_PSE_BUF_SET);
-
-	return FIELD_GET(PSE_ALLRSV_MASK, val);
+	return airoha_fe_get(eth, REG_FE_PSE_BUF_SET, PSE_ALLRSV_MASK);
 }
 
 static int airoha_fe_set_pse_oq_rsv(struct airoha_eth *eth,
@@ -247,8 +243,7 @@ static int airoha_fe_set_pse_oq_rsv(struct airoha_eth *eth,
 		      FIELD_PREP(PSE_ALLRSV_MASK, all_rsv));
 
 	/* modify hthd */
-	tmp = airoha_fe_rr(eth, PSE_FQ_CFG);
-	fq_limit = FIELD_GET(PSE_FQ_LIMIT_MASK, tmp);
+	fq_limit = airoha_fe_get(eth, PSE_FQ_CFG, PSE_FQ_LIMIT_MASK);
 	tmp = fq_limit - all_rsv - 0x20;
 	airoha_fe_rmw(eth, REG_PSE_SHARE_USED_THD,
 		      PSE_SHARE_USED_HTHD_MASK,
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index e389d2fe3b86..eda888593f94 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -619,6 +619,8 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 	airoha_rmw((eth)->fe_regs, (offset), 0, (val))
 #define airoha_fe_clear(eth, offset, val)			\
 	airoha_rmw((eth)->fe_regs, (offset), (val), 0)
+#define airoha_fe_get(eth, offset, mask)			\
+	FIELD_GET((mask), airoha_fe_rr((eth), (offset)))
 
 #define airoha_qdma_rr(qdma, offset)				\
 	airoha_rr((qdma)->regs, (offset))
@@ -630,6 +632,8 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 	airoha_rmw((qdma)->regs, (offset), 0, (val))
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
+#define airoha_qdma_get(qdma, offset, mask)			\
+	FIELD_GET((mask), airoha_qdma_rr((qdma), (offset)))
 
 static inline bool airoha_is_lan_gdm_port(struct airoha_gdm_port *port)
 {
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 5c9dff6bccd1..697af6fdd4c3 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -80,9 +80,8 @@ bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index)
 
 static u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe)
 {
-	u16 timestamp = airoha_fe_rr(ppe->eth, REG_FE_FOE_TS);
-
-	return FIELD_GET(AIROHA_FOE_IB1_BIND_TIMESTAMP, timestamp);
+	return airoha_fe_get(ppe->eth, REG_FE_FOE_TS,
+			     AIROHA_FOE_IB1_BIND_TIMESTAMP);
 }
 
 void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id, u8 fport)

---
base-commit: 09942ddedcb960f9e78fd817ec33f501d1040c5b
change-id: 20260428-airoha_fe_get-airoha_qdma_get-7a087a23aef4

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


