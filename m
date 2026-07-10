Return-Path: <netdev+bounces-306422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0HP/Hy90UGouzQIAu9opvQ
	(envelope-from <netdev+bounces-306422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4315F7371F8
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=X2oXQj7v;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306422-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306422-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D84143026F39
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD036B04E;
	Fri, 10 Jul 2026 04:24:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7D36B046
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:24:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657491; cv=none; b=jYnT5MLnZOfXs1yhTt38zpab3bmFFSZlTEn7qoRWFc82WHA84zF5fpOlC5eOAtbqJllN/tQ5/6xSz1JHfn8hKAWafGFzhzHdzduxPTMkQe+vNy7y/Hr8R3bEJg2/PfbdrlDjKWWY/4rIu04p4NmXjAx9jz4WH4iuPY3IJqmtpuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657491; c=relaxed/simple;
	bh=N9phANCuLzO7ILq2T/Sh69NM4wAQSM8C1G4EDiU+hlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNjREROB7HIIEeGKu7oU1wfp/mGIndeZoHZM+y1UBfoY4vAAZTPYCKIqWAl8cjRlbaCYabB8Use3BFPvUe+mi0L3hpRmPQDheY5NmjFLghR+6tQuu+ItHeOlsbLcEcEDFCXKbrw+GGBVEZbU/pin6AQJkDjdOWtLwSXwt776vYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X2oXQj7v; arc=none smtp.client-ip=209.85.221.227
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5bf9466867cso156158e0c.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657488; x=1784262288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDTeO85AST2V8EHIEyHEFUN5UtWmoFmyT5msHpaa+ug=;
        b=Gp2DcPwuaFMmfiUs48PDm8HDjjPGs0HnfTOPTrTYsuH2Y1zEMKElF+BKm+MajDPmnE
         99/QyQI3gnpMf/1TMCB272eDoMvKn7xOnpXwHtJ/77og+TfyT2c47MHHfT/sm3ejlye3
         esUKQj2yozY3hbTIu3IAcmKn8CgciRl75LrEsB27Eo4jgueAgxggsQVG2V5TsMQkOqYO
         AGBtXnzbGE7XlfQSfM5Brl5PPISDS8XicJjpDo3Yshk+63PMA68khscowiKvSt2cp6zE
         g9GeVR//D9K45xIXuRqcwfQWx+Y8weCJq94gVABjI+hD8KpZB3b3FuWCdje1YuIQlLBb
         6+CQ==
X-Gm-Message-State: AOJu0Yyhq/RZBCz8nnZcfRbPgT9tHVi7Fcds+qAzmi0hYh/U9qH1wCwI
	95W52a4CI1DU8qNXCliXswfiSYoXKvjqptjizqn9UvP0Sst9Fj7uuTeZGg2p6AijRhvKaF4slSD
	vfCEVvkNtfy7a2GevJD557V+0vWW4TkilRn8wHPhyvq37iuaBcWRQ7zGeogLYBKXlDUWNok2j0+
	mP5VMUcbES7drPBRr3YNfPHvD9qwdbLcjtq9fPKw8hO0YWrzNfEzLCHOT+LvB4x3xK4zKwgeUWa
	UYRZ5OENv4=
X-Gm-Gg: AfdE7cnMKsY+kStCvr8iMvohzLzOhexhcyc2rBPcwrl5ofZJ1Gq7tLK7yzzqeZkNHM3
	qB0S0wVUFg9uXNXyOlw7jL87AIgQreV19QJYboXgWJg3c0d0WhULM3iXMgWx9F4I+lyLf8Qt1V7
	rcCRh45eBWwVNXMC5XOZTUtoRXyzipFmixCviK5Zcwt+yZJ6VW1//rU1rQKuj2XEe+wwdcWtpw9
	J8HBAo7H727rOzKY+x1HleOhyodnQJscIZlFITincezK3L5qScLg/RysvcUqOj9EnSjEG/c9mmu
	1JX2urMxRtI0Kenz122WJGaBoI44ZgwFTpTG3CPsQGBLJTdJVJrVuQ7UOZ5mPyDE8tBc8iC02pb
	kTOmMMjdE9H2sn69ZTarIKRn8bf3p7XwgbpjYajfpbrvf3l7ZVgor2n6V9llgJ9+gJBigL+Ru59
	v//nzXNMmO1TqldLYSns/s2GJQIy1VnY/XQf23vdVLGujIDw==
X-Received: by 2002:a05:6122:ca2:b0:5a1:fbbd:6bd0 with SMTP id 71dfb90a1353d-5bf75d23296mr5200964e0c.5.1783657488405;
        Thu, 09 Jul 2026 21:24:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5bf6f822c20sm834860e0c.7.2026.07.09.21.24.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:24:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381e93bfcacso1466216a91.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657486; x=1784262286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iDTeO85AST2V8EHIEyHEFUN5UtWmoFmyT5msHpaa+ug=;
        b=X2oXQj7v7ySJJXslRKcJ73DWzdGEciku1aCz+Fjw5wHb9qKSvT7M3FMNEVdF4YJIxm
         Q/iV44r+0+dgsnE//etWE6OKzezmQjWFrHzyXIWdfiOOV1Pww3ddRETtj5tVB9RUukdK
         oeh5gH3ZodczJJEo3vfx2m2MHVYxH/3t/JWgM=
X-Received: by 2002:a05:6a21:512:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3c0bcfea433mr12129010637.21.1783657486005;
        Thu, 09 Jul 2026 21:24:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:512:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3c0bcfea433mr12128978637.21.1783657485552;
        Thu, 09 Jul 2026 21:24:45 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:24:44 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v5 01/15] bnxt_en: Add Midpath channel information
Date: Thu,  9 Jul 2026 21:23:46 -0700
Message-ID: <20260710042400.3996847-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710042400.3996847-1-michael.chan@broadcom.com>
References: <20260710042400.3996847-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306422-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:ajit.khaparde@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4315F7371F8

Midpath channels (MPCs) are rings for hardware control paths.  These
control paths are used to offload kTLS directly to the hardware
without going through firmware.  This patch adds the basic information
structures for these MPCs.

An MPC is basically a TX and completion ring pair with a HW TLS block
as the destination.  Two MPC channel types are used to offload
connections to the TX crypto engine (TCE) and the RX crypto
engine (RCE) respectively.  In the driver, we re-use the
bnxt_tx_ring_info and bnxt_cp_ring_info control structs for the MPCs.

This patch also adds the CONFIG_BNXT_TLS Kconfig option to conditionally
include the MPC logic.  The first few patches in the series add the MPC
support.  kTLS support will be added later in the series.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/Kconfig         |  9 ++++
 drivers/net/ethernet/broadcom/bnxt/Makefile   |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  8 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 26 ++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 47 +++++++++++++++++++
 6 files changed, 93 insertions(+)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index f0bac0dd1439..b33b66f038b8 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -255,6 +255,15 @@ config BNXT_HWMON
 	  Say Y if you want to expose the thermal sensor data on NetXtreme-C/E
 	  devices, via the hwmon sysfs interface.
 
+config BNXT_TLS
+	bool "Broadcom NetXtreme-C/E TLS offload support"
+	default y
+	depends on BNXT && TLS_DEVICE
+	depends on TLS=y || BNXT=m
+	help
+	  Say Y if you want to enable Transport Layer Security (TLS) hardware
+	  encryption and decryption offload on supported NetXtreme-C/E devices.
+
 config BNGE
 	tristate "Broadcom ThorUltra Ethernet device support"
 	depends on PCI
diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index debef78c8b6d..0506574c007a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -5,3 +5,4 @@ bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
 bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
+bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7513618793da..8faab85d66d1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -76,6 +76,7 @@
 #include "bnxt_hwmon.h"
 #include "bnxt_gso.h"
 #include <net/tso.h>
+#include "bnxt_mpc.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -9943,6 +9944,11 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	}
 	bp->tso_max_segs = le16_to_cpu(resp->max_tso_segs);
 
+	if (resp->mpc_chnls_cap)
+		bnxt_alloc_mpc_info(bp, resp->mpc_chnls_cap);
+	else
+		bnxt_free_mpc_info(bp);
+
 hwrm_func_qcaps_exit:
 	hwrm_req_drop(bp, req);
 	return rc;
@@ -16547,6 +16553,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->ptp_cfg = NULL;
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
@@ -17218,6 +17225,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_ethtool_free(bp);
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6335dfc14c98..77b1748d12d1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2452,6 +2452,8 @@ struct bnxt {
 
 	u8			tph_mode;
 
+	struct bnxt_mpc_info	*mpc_info;
+
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
new file mode 100644
index 000000000000..86087e538550
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/bnxt/hsi.h>
+
+#include "bnxt.h"
+#include "bnxt_mpc.h"
+
+void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
+{
+	if (!bp->mpc_info)
+		bp->mpc_info = kzalloc_obj(*bp->mpc_info);
+	if (bp->mpc_info)
+		bp->mpc_info->mpc_chnls_cap = mpc_chnls_cap;
+	else
+		netdev_warn(bp->dev, "Unable to allocate MPC info\n");
+}
+
+void bnxt_free_mpc_info(struct bnxt *bp)
+{
+	kfree(bp->mpc_info);
+	bp->mpc_info = NULL;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
new file mode 100644
index 000000000000..cd3f268a3a29
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#ifndef BNXT_MPC_H
+#define BNXT_MPC_H
+
+/* Mid path channel (MPC) definitions.  An MPC is special TX/completion
+ * ring pair to send/receive control plane data to the TCE and RCE
+ * (Transmit/Receive Crypto Engine) HW blocks.
+ */
+
+enum bnxt_mpc_type {
+	BNXT_MPC_TCE_TYPE = RING_ALLOC_REQ_MPC_CHNLS_TYPE_TCE,
+	BNXT_MPC_RCE_TYPE = RING_ALLOC_REQ_MPC_CHNLS_TYPE_RCE,
+	BNXT_MPC_TYPE_MAX,
+};
+
+#define BNXT_MAX_MPC		8
+
+struct bnxt_mpc_info {
+	u8			mpc_chnls_cap;
+	u8			mpc_cp_rings;
+	u8			mpc_ring_count[BNXT_MPC_TYPE_MAX];
+	struct bnxt_tx_ring_info *mpc_rings[BNXT_MPC_TYPE_MAX];
+};
+
+#define BNXT_MPC_CRYPTO_CAP    \
+	(FUNC_QCAPS_RESP_MPC_CHNLS_CAP_TCE | FUNC_QCAPS_RESP_MPC_CHNLS_CAP_RCE)
+
+#define BNXT_MPC_CRYPTO_CAPABLE(bp)					\
+	((bp)->mpc_info ?						\
+	 ((bp)->mpc_info->mpc_chnls_cap & BNXT_MPC_CRYPTO_CAP) ==	\
+	  BNXT_MPC_CRYPTO_CAP : false)
+
+#ifdef CONFIG_BNXT_TLS
+void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
+void bnxt_free_mpc_info(struct bnxt *bp);
+#else
+static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
+{
+}
+
+static inline void bnxt_free_mpc_info(struct bnxt *bp)
+{
+}
+#endif	/* CONFIG_BNXT_TLS */
+#endif	/* BNXT_MPC_H */
-- 
2.51.0


