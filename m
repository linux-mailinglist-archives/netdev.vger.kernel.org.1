Return-Path: <netdev+bounces-283138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCFhMBNb9GlVAwIAu9opvQ
	(envelope-from <netdev+bounces-283138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:49:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E334AB064
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6FF430058C4
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 07:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F33033E6;
	Fri,  1 May 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYoVQCOo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13C21CC5C
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777621777; cv=none; b=JfqkC5kKnS8IVoHx9h6u31X2uI+fjllXjHQgMnEA1sL4rVu8MfzFquYO/cjHDt1YjvIY5dbds0AL5PmCTGN2k+TWpw8fAX7CmyHmV0rjS8zw8KtUdQH1YzilZNLVbmg++TuMaEoKOfR+Rmknbh8V2qLKsVqd1v2rVF8YZfJhXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777621777; c=relaxed/simple;
	bh=IF6Qkm1znumajmpa4JitsCIudUdROPQnTF0ZJbhGhxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F39lg8yz8GrcDa4BDJ11hx9eKxn16uvI3yF3RB/AWXqmwDWeLQoGQb8Kr30oROYXMy3nbAReY1FI+kcm/dFfX7YK95cIONfrym/BkLdBMTHi4OwC8lDs9Q8TMLlUAh5m3s6K8tw1RRNgzQakqmQD29HJRAiVXDbUD3HRjb+VM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYoVQCOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89B1C2BCB4;
	Fri,  1 May 2026 07:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777621777;
	bh=IF6Qkm1znumajmpa4JitsCIudUdROPQnTF0ZJbhGhxw=;
	h=From:Date:Subject:To:Cc:From;
	b=YYoVQCOoYiSdLOGdLoJapWnJA3cD+GJznzxKlJocvBGm6CtV7/IzEeUV07YQEIqlD
	 TosWc6hmwgbk8T4+eRJ6MpHOHKGThcN2vKahoVm95LZfyvT/OAmkfttCG+VptZibMa
	 Rt8bCcbP36yazCWxugRJRKbZCeBjs16qCvprYDc5yFyqtUL0fx8v3M81SpG4ItOHcG
	 lFR37lIJqwpoag7KaIGZULdHXWlImXxTUqEqBgEPoH2N1Jka0jY/I/tYbjvZzmaBkD
	 +Ljd4b1giepxxt9CIf6QO9FtN5sAFSLdxY4fShKl+NHrH9PtO0TC2X8YQ7w9gp7/cH
	 5PCZurZpw02lw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 01 May 2026 09:49:11 +0200
Subject: [PATCH net-next v3] net: airoha: Introduce
 airoha_fe_get()/airoha_qdma_get() register read helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-airoha_fe_get-airoha_qdma_get-v3-1-126c6f647ccb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43N0QrCIBTG8VcZXmeokzm76j0ihpvHTSotHbIYe
 /dECOqqLv98h99ZUYRgIaJDtaIAyUbrXY56V6FhUm4EbHVuxAhrCGctVjb4SXUGuhHmdz30TZU
 WirRCsVqB4Sgb9wDGLsU/IZcPHCwzOudlsnH24VkeJ1r2P38kiiluBtNr6DkTvD5eIDi47n0YC
 53YJyd/cSxzkkgQkhqqB/LFbdv2Aix3ydokAQAA
X-Change-ID: 20260428-airoha_fe_get-airoha_qdma_get-7a087a23aef4
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 49E334AB064
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283138-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Add airoha_fe_get() and airoha_qdma_get() as utility routines for reading
a masked field from a specified register.
This is a non-functional refactor, no logical changes are introduced to
the existing codebase.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v3:
- Rebase on top of net-next main branch.
- Link to v2: https://lore.kernel.org/r/20260429-airoha_fe_get-airoha_qdma_get-v2-1-909e791f1dc0@kernel.org

Changes in v2:
- Fix typo in airoha_qdma_get() definition.
- Link to v1: https://lore.kernel.org/r/20260428-airoha_fe_get-airoha_qdma_get-v1-1-6cfbdeb42743@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 13 ++++---------
 drivers/net/ethernet/airoha/airoha_eth.h |  4 ++++
 drivers/net/ethernet/airoha/airoha_ppe.c |  5 ++---
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index e9e1645e8f9b..4222de6878d2 100644
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
index 717e4a7c59dd..58530d096de7 100644
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
 
 static inline u16 airoha_qdma_get_txq(struct airoha_qdma *qdma, u16 qid)
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
base-commit: edf4bee4215a173c0534d1851d7523d827149f9e
change-id: 20260428-airoha_fe_get-airoha_qdma_get-7a087a23aef4

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


