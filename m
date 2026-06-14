Return-Path: <netdev+bounces-299165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pkw1AMVXLmrptgQAu9opvQ
	(envelope-from <netdev+bounces-299165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:27:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0496808E9
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:27:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=KJFkB1SU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299165-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299165-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 923733031120
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1BA392C57;
	Sun, 14 Jun 2026 07:25:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A751F392C52
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:25:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421932; cv=none; b=rA5WDC0+5egQ3LoUTyCxJMlBTgs0Gend4V8w6scfRUqthsn8+ojfZzmARq9QRqjwLkANv88JGGR5BMLBuFDWuoRI8n/R/Ykk6L61UUrKCbc00Hmhjfmc5hqNNPfHKXpnIkuN/I6az1MoXy1PLoe0dMYdYnlaChs+oU5AiPf8fT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421932; c=relaxed/simple;
	bh=0V8kGIn1NtpjSC9CzDRN8IFo+AtDCGOOW5RSMF4QiNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXrU5+eg38Qo0Kx5tj85nM3M2qGILpgyQj/jwQk15Uj6sMGHHH8Sh9voNeK3Vk9hXIli+9d3FokmhItQTQDsdz6rUqyL70+MDeDOSa9MYABrAz3SCE3iTeDjCKNjH5z2rlPdx5wKVHXzI6jEgRFIXl3l0fPtK3nHowpfLdJFmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KJFkB1SU; arc=none smtp.client-ip=209.85.221.226
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-59f967189e7so937079e0c.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421929; x=1782026729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgp12Nbx7NWHfhnS258QRd/gLhsObXHUpDN1CbChKqg=;
        b=k8EUZUB0tqitr63H+74k7rPqW+obFL/S36NR9zHfagt769ziUkLixbN7Xz0reXa4kF
         2xYYqIZq5vGfT89LNgoxvbqJICuYaHTuyscq+yDv7SZeOSBtOnYDxTcWpLMOeUn99P16
         W/kDbcdVUOvwRKRScSdwEai3bc4nrel2978Hz8SMi03sWefHSNfjJGDiTdyhJIigmHnj
         SA89iJcCd910ZwK1sSslV5Ie/oZCKGkFozTHUP+Ajila4BbsiXBHofX+oztjRQD7U8kX
         6paPjRRWgQejn2+pGXZbdxOL7YxdczMPCp8SdGzxJfaiydoaIt97Zgk7QecxWUVuglJj
         kJKQ==
X-Gm-Message-State: AOJu0YzCGssSs/9pwS6Th5qeYnKHNZyqgjxsQaSeFzUvClQ9s3pmMXUG
	TrOMQH1T7fhfWwdE+nhX6nrD4MrH3fiD45EIQ3rhmUjbcdfMBMV4vP+NBWVgHy4fjRaT+TTnCGx
	kSMCzsQst6W0hT70ebz8bLSnwsBNZg0R3YFAQOY5tG3vku88C5hMtVe6eyF2UCgbqgv/JNHZOn4
	bnVbj00/iovcRvS8783RqCIkLYAQ994WWFnq5LwLk3+rfc6+wY5aMMV85fWsY7wnSMSr8pcsVcS
	oDVlyDn+o8=
X-Gm-Gg: Acq92OHN9RFsd+14hizIMtMEvTLl0iI13SCb4PDSqcmELfBNXlJDpPc9K/OJMRWFhBj
	7axCoBmMSyD+FTi3zi5HZ2OBG1/KbDLV65DSdc086rmEucu9lrz/+7AExOB3iRK0YhesKN0CyWN
	FqCCAYBowyZ3HkPd1QTlN5U6Kt7cQoqt4w6YKz5WjbumHgEqJDNBi5JDUdiRwKq+EANOdRmML4A
	elnw6Ch9ZN9gZQpzfK7jHK0GSUp/T1TC9U2RhppYBMHb6w5VSCt/hvJpZ2Op3d5FiEnmqUppUsg
	4YLivvReC42l0V1jLfuJO4Jb5EYRqdiBMs/ghUopQEixlzStMiWyk6cQ+lwSCijWTn4ntH5Had5
	bju+BJ//loD/Kq5ab3qphB207wr+Tg7pwN2AsyzAGYMKmisQat2zKsPSXZlneqdb0/WcVU1aVDZ
	7Ar93iBdD/y/DMKDQF7YK0eIj2q+gkNZlKZGc2YVvx0fLAlTwMjmj7fCT6qiU=
X-Received: by 2002:a05:6102:801d:b0:6a2:b2a1:f16a with SMTP id ada2fe7eead31-71e88acea75mr5111921137.2.1781421929430;
        Sun, 14 Jun 2026 00:25:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5bb9012d534sm77189e0c.5.2026.06.14.00.25.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 00:25:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304dd917645so4969274eec.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781421928; x=1782026728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgp12Nbx7NWHfhnS258QRd/gLhsObXHUpDN1CbChKqg=;
        b=KJFkB1SU1kwwIeF3/2BsilgybNBQ89/W2xIT0kTd1yuaLM8U5FqxfKTIq7pRnYFO8Z
         BQyHiW6LNiAKgpNVa7JCraqR8NE2Pb5/+gCZMjSrPTY4SIFpGFwfS88BdIwUPx4Z32FV
         eaEeamG8KtkUILIwkBP6PgO2xshxffuN5hb98=
X-Received: by 2002:a05:7300:7306:b0:304:e6f8:7cc9 with SMTP id 5a478bee46e88-3082005fd53mr5433817eec.20.1781421927515;
        Sun, 14 Jun 2026 00:25:27 -0700 (PDT)
X-Received: by 2002:a05:7300:7306:b0:304:e6f8:7cc9 with SMTP id 5a478bee46e88-3082005fd53mr5433807eec.20.1781421926907;
        Sun, 14 Jun 2026 00:25:26 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43bc7sm10043280eec.22.2026.06.14.00.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:25:25 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 07/15] bnxt_en: Allocate crypto structure and backing store
Date: Sun, 14 Jun 2026 00:23:59 -0700
Message-ID: <20260614072407.2761092-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260614072407.2761092-1-michael.chan@broadcom.com>
References: <20260614072407.2761092-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-299165-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C0496808E9

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
v3:
bp->crypto_info and bp->ktls_info now stay persistent for the driver's
lifetime.  max keys are refreshed after re-init.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-8-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/Makefile   |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 82 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  | 47 +++++++++++
 include/linux/bnxt/hsi.h                      | 37 +++++++++
 6 files changed, 192 insertions(+), 1 deletion(-)
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
index 0d6d4bb7fd6f..dd8b3e09fd2d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -77,6 +77,7 @@
 #include "bnxt_gso.h"
 #include <net/tso.h>
 #include "bnxt_mpc.h"
+#include "bnxt_crypto.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -9370,6 +9371,7 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 
 static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 {
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
 	struct bnxt_mpc_info *mpc = bp->mpc_info;
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem_type *ctxm;
@@ -9377,6 +9379,19 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
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
@@ -9919,6 +9934,10 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_BACKING_STORE_V2;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_TX_COAL_CMPL_CAP)
 		bp->flags |= BNXT_FLAG_TX_COAL_CMPL;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_KTLS_SUPPORTED)
+		bnxt_alloc_crypto_info(bp, resp);
+	else
+		bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
 
 	flags_ext2 = le32_to_cpu(resp->flags_ext2);
 	if (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_RX_ALL_PKTS_TIMESTAMPS_SUPPORTED)
@@ -16559,6 +16578,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->ptp_cfg = NULL;
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_crypto_info(bp);
 	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
@@ -17238,6 +17258,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_ethtool_free(bp);
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_crypto_info(bp);
 	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f875f130f070..954c679e0290 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2460,6 +2460,7 @@ struct bnxt {
 	u8			tph_mode;
 
 	struct bnxt_mpc_info	*mpc_info;
+	struct bnxt_crypto_info	*crypto_info;
 
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
@@ -2547,6 +2548,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
 	#define BNXT_FW_CAP_MIRROR_ON_ROCE		BIT_ULL(43)
 	#define BNXT_FW_CAP_PTP_PTM			BIT_ULL(44)
+	#define BNXT_FW_CAP_KTLS			BIT_ULL(45)
 
 	u32			fw_dbg_cap;
 
@@ -2572,6 +2574,8 @@ struct bnxt {
 	((bp)->fw_cap & BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS)
 #define BNXT_MIRROR_ON_ROCE_CAP(bp)	\
 	((bp)->fw_cap & BNXT_FW_CAP_MIRROR_ON_ROCE)
+#define BNXT_SUPPORTS_KTLS(bp)	\
+	((bp)->fw_cap & BNXT_FW_CAP_KTLS)
 
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
new file mode 100644
index 000000000000..0777a26600f5
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -0,0 +1,82 @@
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


