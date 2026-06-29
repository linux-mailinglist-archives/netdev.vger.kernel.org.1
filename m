Return-Path: <netdev+bounces-302800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KG6cEpi+QmrCAQoAu9opvQ
	(envelope-from <netdev+bounces-302800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:51:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 415BC6DE245
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:51:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=KC2NHiLV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302800-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302800-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 538F7300B816
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8363E41C2F2;
	Mon, 29 Jun 2026 18:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA008421A13
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:50:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759021; cv=none; b=Zp/HppVAa/yCKwg+DS2rL6wTx/FRuI/5ACcLqkmVgLtZSFu5vy+igx50OiobQwZYaMa0sxOmFpyjlulFsKxMFClVIF4Qwkyk+FC+I1phohxhvx959c4xgj0vH1S9Zx2PR8vyrDTi4VW85YU9fnJFsqxU7Y6xjGcMkP5wEGSvBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759021; c=relaxed/simple;
	bh=zV6Jv9JdC5kcxbwt6MRdDMNmj1Ggv3auOvGvPgHIUGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVk9DmxwGMj4moWtD5s2I/8B4oupcaQNCsuHIAHvFRM8yfI1FztfC3z0B5PihB+CMDLxXVmkTbU8bKTwMHpsfsTDkfJsj/dX+tsVq41bKt3bxIHM6ARNHWMBA5HcRDRTjtjo/Q7ox5TPk6Lte5kbofMFLjtg7VS4hBACFYukUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KC2NHiLV; arc=none smtp.client-ip=209.85.210.227
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-8478fe07ebbso753676b3a.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759019; x=1783363819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7goMqokE1bUnGQ5aEPzC5Pygjmk0u2SV8aNQKy7yT4Q=;
        b=oN1gS75nWJ3dLKeSjz1ut/EOSyVLqqWlQUxPD974qifo4wmg5+NBOxc52sB9764G2a
         haIgKdyL9/mqZ0fpGuSJe1D96MHJCzM0/yzOI6m+UtT2QaXklwQAlAPY9farMFb9Q/yt
         6V4IWmZ/XIpcXSvzJLYHlGWsj2xAwNyjfcL7DcCav5sAw+0ZEDF+wfhClb/nDGK2cXM+
         M5hNa54JFX3VO9FFTbBe9ObXQbQ469B345lWlYfs17KjZ0JkdYU+fmu5whe/86EBNHto
         CY6SxlFvCSkdlUzO3NPSEWczYAdXr1Z8UoEfzeotUIiPOUBdXcsHLggHGV/OnLyQKtRT
         NfCQ==
X-Gm-Message-State: AOJu0YzpELrxhHO1NVuY9srbsZiND24pDjEZq3+4SrdpFYZn/TdhZ5XG
	bYCjQ8S6Jk7KshWBMM4x8vdXIgFmt/O9I4TJ2h+0s+n1vnLX1XMcRQPYtvpnv4kXsgG5mmHiCvd
	6cajmZULnlHWHj5ScO0WXmMBs0xL+/6q/WC8mFvz2g/VPtBQAfI1KAQ/U7mYCoPwWTdNdOQO9X+
	zkm9y8uq+uUhnMpWUz0SVlN2tEfuGQqqzj25eziUh3VDh6QlFKVXqQMdkgSwjDtg3hyuj2KzpMa
	ll8+fbpuOE=
X-Gm-Gg: AfdE7ckRrFvfBACo/J9GpJXfz9J2eMbeHkE7bz2dXinqpuhE8Hp0qMROqVg5CjtT5ZB
	zKr6CP/GCW0N0gZldim+3x/AOKxyMHj18gOfmM80fYjVLg/cd6il/caMaKR8ZUe14fdF1xlNDRb
	XbkUQ8lwA89WgwYUrmUAODxx9y/MUu3jSNM7YESCOHcuZlTK6Umpn9jC3Zbr6XtDHJLKZavLM4J
	saCpTFMDoJS8YOHMjtM7ceHoSPdvyC+CxAXpducGX223dQbAE5aYfYuT0OkNYf/ZbOuqbH68HIu
	zWrHDPrFgb4aTAKxajjtdYAE0gfaNyUDY8hptrIrMxkeOteIDt3VoeHmHNASkWsfXC/VeU0YTmA
	Rv2/TUFiA0o7uaelVyQYN/OXOqnBcURBsoFJa5TDTzmxC9Up+7mi3hny2UapvIb8Dz9LkMljKAQ
	SubfMYrWzWhc7GEvrEsp/dThe59Tj8sigzt9EAjLPMOqv4aj3W
X-Received: by 2002:a05:6a00:27a8:b0:847:7cf2:a8ff with SMTP id d2e1a72fcca58-8479ff2be9bmr299849b3a.30.1782759018892;
        Mon, 29 Jun 2026 11:50:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8479ffd16fcsm29013b3a.2.2026.06.29.11.50.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:50:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51a88357129so56994741cf.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782759016; x=1783363816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7goMqokE1bUnGQ5aEPzC5Pygjmk0u2SV8aNQKy7yT4Q=;
        b=KC2NHiLV7INRnyCxHW//p14GeEZgfqBWgxV7suzEnENZRE5vHlKIqjpDvPo8BtO5km
         A77vEMXg9N+tBHf5YCbh4zbCkae2tNr7AraVaoVRo7zpA1eUCSonKmBVof+iZLXWPe2B
         twH3AQj/8aZ1UbB+deFuMzFbD35jpW9Uqb0VY=
X-Received: by 2002:ac8:4dd1:0:b0:51c:ca9:7cdf with SMTP id d75a77b69052e-51c10a4df1fmr4546601cf.2.1782759016225;
        Mon, 29 Jun 2026 11:50:16 -0700 (PDT)
X-Received: by 2002:ac8:4dd1:0:b0:51c:ca9:7cdf with SMTP id d75a77b69052e-51c10a4df1fmr4545841cf.2.1782759015022;
        Mon, 29 Jun 2026 11:50:15 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c109ffbb3sm2176341cf.23.2026.06.29.11.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:50:14 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v4 07/15] bnxt_en: Allocate crypto structure and backing store
Date: Mon, 29 Jun 2026 11:49:13 -0700
Message-ID: <20260629184921.3496727-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629184921.3496727-1-michael.chan@broadcom.com>
References: <20260629184921.3496727-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-302800-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 415BC6DE245

If the chip and firmware support crypto (TLS) offload, allocate a
bp->crypto_info software structure and backing store to support the RX
and TX contexts.  Each offloaded TLS connection requires a backing
store context for each direction.

bp->crypto_info will stay persistent even if kTLS is no longer
supported after a FW reset.  This makes it easier to avoid NULL
dereference of bp->crypto_info during FW reset and kTLS offload
race conditions.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v4:
Clear BNXT_FW_CAP_KTLS in bnxt_free_cryto_info()

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-8-michael.chan@broadcom.com/

bp->crypto_info and bp->ktls_info now stay persistent for the driver's
lifetime.  max keys are refreshed after re-init.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-8-michael.chan@broadcom.
com/
---
 drivers/net/ethernet/broadcom/bnxt/Makefile   |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 83 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  | 47 +++++++++++
 include/linux/bnxt/hsi.h                      | 37 +++++++++
 6 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h

diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index 0506574c007a..3acdb81fa958 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -5,4 +5,4 @@ bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
 bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
-bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o
+bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o bnxt_crypto.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 67a8b2729cc3..d1b546301742 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -77,6 +77,7 @@
 #include "bnxt_gso.h"
 #include <net/tso.h>
 #include "bnxt_mpc.h"
+#include "bnxt_crypto.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -9376,6 +9377,7 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 
 static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 {
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
 	struct bnxt_mpc_info *mpc = bp->mpc_info;
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem_type *ctxm;
@@ -9383,6 +9385,19 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 	int rc = 0;
 	u16 type;
 
+	if (BNXT_SUPPORTS_KTLS(bp)) {
+		ctxm = &ctx->ctx_arr[BNXT_CTX_TCK];
+		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm,
+					     BNXT_TCK(crypto).max_ctx, 1);
+		if (rc)
+			return rc;
+		ctxm = &ctx->ctx_arr[BNXT_CTX_RCK];
+		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm,
+					     BNXT_RCK(crypto).max_ctx, 1);
+		if (rc)
+			return rc;
+		last_type = BNXT_CTX_RCK;
+	}
 	if (mpc && mpc->mpc_chnls_cap) {
 		ctxm = &ctx->ctx_arr[BNXT_CTX_MTQM];
 		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, ctxm->max_entries, 1);
@@ -9925,6 +9940,10 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_BACKING_STORE_V2;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_TX_COAL_CMPL_CAP)
 		bp->flags |= BNXT_FLAG_TX_COAL_CMPL;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_KTLS_SUPPORTED)
+		bnxt_alloc_crypto_info(bp, resp);
+	else
+		bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
 
 	flags_ext2 = le32_to_cpu(resp->flags_ext2);
 	if (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_RX_ALL_PKTS_TIMESTAMPS_SUPPORTED)
@@ -16611,6 +16630,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->ptp_cfg = NULL;
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_crypto_info(bp);
 	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
@@ -17290,6 +17310,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_ethtool_free(bp);
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_crypto_info(bp);
 	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e7e2657d58b9..501f8379427a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2461,6 +2461,7 @@ struct bnxt {
 	u8			tph_mode;
 
 	struct bnxt_mpc_info	*mpc_info;
+	struct bnxt_crypto_info	*crypto_info;
 
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
@@ -2548,6 +2549,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
 	#define BNXT_FW_CAP_MIRROR_ON_ROCE		BIT_ULL(43)
 	#define BNXT_FW_CAP_PTP_PTM			BIT_ULL(44)
+	#define BNXT_FW_CAP_KTLS			BIT_ULL(45)
 
 	u32			fw_dbg_cap;
 
@@ -2573,6 +2575,8 @@ struct bnxt {
 	((bp)->fw_cap & BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS)
 #define BNXT_MIRROR_ON_ROCE_CAP(bp)	\
 	((bp)->fw_cap & BNXT_FW_CAP_MIRROR_ON_ROCE)
+#define BNXT_SUPPORTS_KTLS(bp)	\
+	((bp)->fw_cap & BNXT_FW_CAP_KTLS)
 
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
new file mode 100644
index 000000000000..5bc31ee8d7fd
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/bnxt/hsi.h>
+
+#include "bnxt.h"
+#include "bnxt_crypto.h"
+
+static u32 bnxt_get_max_crypto_key_ctx(struct bnxt *bp, int key_type)
+{
+	u32 fw_maj = BNXT_FW_MAJ(bp);
+
+	if (key_type == BNXT_TX_CRYPTO_KEY_TYPE)
+		return (fw_maj < 233) ? BNXT_MAX_TX_CRYPTO_KEYS_PRE_233FW :
+		       BNXT_MAX_TX_CRYPTO_KEYS;
+
+	return (fw_maj < 233) ? BNXT_MAX_RX_CRYPTO_KEYS_PRE_233FW :
+	       BNXT_MAX_RX_CRYPTO_KEYS;
+}
+
+/**
+ * bnxt_alloc_crypto_info - Allocate and initialize crypto offload context
+ * @bp: pointer to bnxt device
+ * @resp: pointer to firmware capability response
+ *
+ * Allocates the main crypto info structure
+ *
+ * This function is called during device initialization when firmware
+ * reports crypto offload capability. If allocation fails, crypto offload
+ * will not be available but the device will still function.
+ *
+ * Context: Process context
+ */
+void bnxt_alloc_crypto_info(struct bnxt *bp,
+			    struct hwrm_func_qcaps_output *resp)
+{
+	u16 max_keys = le16_to_cpu(resp->max_key_ctxs_alloc);
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_kctx *kctx;
+	int i;
+
+	if (BNXT_VF(bp))
+		return;
+	if (!crypto) {
+		crypto = kzalloc_obj(*crypto);
+		if (!crypto) {
+			netdev_warn(bp->dev,
+				    "Unable to allocate crypto info\n");
+			return;
+		}
+		for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+			kctx = &crypto->kctx[i];
+			kctx->type = i;
+		}
+		bp->crypto_info = crypto;
+	}
+	for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+		kctx = &crypto->kctx[i];
+		kctx->max_ctx = bnxt_get_max_crypto_key_ctx(bp, i);
+	}
+	crypto->max_key_ctxs_alloc = max_keys;
+	bp->fw_cap |= BNXT_FW_CAP_KTLS;
+}
+
+/**
+ * bnxt_free_crypto_info - Free crypto offload resources
+ * @bp: pointer to bnxt device
+ *
+ * Frees all resources associated with crypto offload.  Call this function
+ * only when it is idle with nothing in-flight.
+ *
+ * Context: Process context during device shutdown/removal
+ */
+void bnxt_free_crypto_info(struct bnxt *bp)
+{
+	kfree(bp->crypto_info);
+	bp->crypto_info = NULL;
+	bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
new file mode 100644
index 000000000000..629388fe1e6d
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#ifndef BNXT_CRYPTO_H
+#define BNXT_CRYPTO_H
+
+#define BNXT_MAX_TX_CRYPTO_KEYS		204800
+#define BNXT_MAX_RX_CRYPTO_KEYS		204800
+
+#define BNXT_MAX_TX_CRYPTO_KEYS_PRE_233FW	65535
+#define BNXT_MAX_RX_CRYPTO_KEYS_PRE_233FW	65535
+
+enum bnxt_crypto_type {
+	BNXT_TX_CRYPTO_KEY_TYPE = FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_TX,
+	BNXT_RX_CRYPTO_KEY_TYPE = FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_RX,
+	BNXT_MAX_CRYPTO_KEY_TYPE,
+};
+
+struct bnxt_kctx {
+	u8			type;
+	u32			max_ctx;
+};
+
+struct bnxt_crypto_info {
+	u16			max_key_ctxs_alloc;
+
+	struct bnxt_kctx	kctx[BNXT_MAX_CRYPTO_KEY_TYPE];
+};
+
+#define BNXT_TCK(crypto)	((crypto)->kctx[BNXT_TX_CRYPTO_KEY_TYPE])
+#define BNXT_RCK(crypto)	((crypto)->kctx[BNXT_RX_CRYPTO_KEY_TYPE])
+
+#ifdef CONFIG_BNXT_TLS
+void bnxt_alloc_crypto_info(struct bnxt *bp,
+			    struct hwrm_func_qcaps_output *resp);
+void bnxt_free_crypto_info(struct bnxt *bp);
+#else
+static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
+					  struct hwrm_func_qcaps_output *resp)
+{
+}
+
+static inline void bnxt_free_crypto_info(struct bnxt *bp)
+{
+}
+#endif	/* CONFIG_BNXT_TLS */
+#endif	/* BNXT_CRYPTO_H */
diff --git a/include/linux/bnxt/hsi.h b/include/linux/bnxt/hsi.h
index 74a6bf278d88..03444b81beb0 100644
--- a/include/linux/bnxt/hsi.h
+++ b/include/linux/bnxt/hsi.h
@@ -3837,6 +3837,43 @@ struct hwrm_func_ptp_ext_qcfg_output {
 	u8	valid;
 };
 
+/* hwrm_func_key_ctx_alloc_input (size:384b/48B) */
+struct hwrm_func_key_ctx_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	__le16	num_key_ctxs;
+	__le32	dma_bufr_size_bytes;
+	u8	key_ctx_type;
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_TX      0x0UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_RX      0x1UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_QUIC_TX 0x2UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_QUIC_RX 0x3UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_LAST   FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_QUIC_RX
+	u8	unused_0[7];
+	__le64	host_dma_addr;
+	__le32	partition_start_xid;
+	u8	unused_1[4];
+};
+
+/* hwrm_func_key_ctx_alloc_output (size:192b/24B) */
+struct hwrm_func_key_ctx_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	num_key_ctxs_allocated;
+	u8	flags;
+	#define FUNC_KEY_CTX_ALLOC_RESP_FLAGS_KEY_CTXS_CONTIGUOUS     0x1UL
+	u8	unused_0;
+	__le32	partition_start_xid;
+	u8	unused_1[7];
+	u8	valid;
+};
+
 /* hwrm_func_backing_store_cfg_v2_input (size:512b/64B) */
 struct hwrm_func_backing_store_cfg_v2_input {
 	__le16	req_type;
-- 
2.51.0


