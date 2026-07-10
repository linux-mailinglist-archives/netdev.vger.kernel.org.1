Return-Path: <netdev+bounces-306432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gx0sNfl0UGpZzQIAu9opvQ
	(envelope-from <netdev+bounces-306432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:28:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A33737222
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:28:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=bpTPzm01;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306432-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306432-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AB2A304B294
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E198536CDE2;
	Fri, 10 Jul 2026 04:25:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688EC36C5AC
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:25:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657505; cv=none; b=ZFj2MhXU2O/70joHneu9JsfL0beXlyZeyplIvgcXTXuOfpUkF2BNfwsZdCuYw5HEIl8r/Rsa0yF+Ti17cxxOj96yu0ckXZYGsL0boP9GSq+zoX30QE+DEYMIb6LS2oYYX9dUYp3q4tkfS3xGt8DyxWxMzYUsxUiSSW6IbWpaD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657505; c=relaxed/simple;
	bh=xeDQKyTw0zjxfrPPZfU3Y1LiYjbp2/tDGPXgQ4YMyFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeVAhE/+SQj81GNRTNHAHl37O6esR59HWJHKO4vCHJncmrCceqNCcZjwPqi0DNkVlJCMLDQ02QSHDJPCbVra52CiIbISfKq0xDFqAtWsQy13k3tezoxj7trlkmNFYNNggWat39K4l8QO0C3oA0J6eu2aYd7rUeSco0Jw3Ypifr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bpTPzm01; arc=none smtp.client-ip=209.85.221.226
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5bf8a2932a3so230016e0c.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657502; x=1784262302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gB10DzJdqUeLaylih2t4hNF6tYlwSqhiGRvauXxMUbg=;
        b=Bl1Tzdt3GQfHASpp41BIbSsGfrX7jOlpXK1JLM7DUzRRJ9zXWJ2c5Yz8ei8ODOCNZv
         ZEjleK1oboMz65GYQhQzQG/wu1JJLLttrAH0+a8I46RzDdpZHs5vE9AF0Xn6SNoUheGQ
         aoluK8TUIEA6VvNJjLldpzxXMatyoARy5tLMws6DtA2SyZjlA+iTIFvmARS3NirhJ5RM
         MkASpsYajOU5FsulxnC5t3RTd/CLcv7bA8va+4ltTgw7ehVFdEtVQ2gJZ3RKTbr+GIm9
         4nALlE4fndyYMe6Tmp1DPHgaRhlejQd1rt7z4TUVTjtD8MjysWyh1U2zGwalNStt807l
         pIuA==
X-Gm-Message-State: AOJu0YxtXJxkpSY4YeWxnCPo57sVYiO3QmO4LgFJ90iDODDbz4BLoOQL
	Q1Wahi10+SlGEL8d6UThKxd+k9Fy62DmdY/XRP+ekj2zcDWfftt8pCHIFwVXYuCZJq933ppifs6
	8N35XBJ+lb7V9b+neQzHKQeuC/GRD89zFtT4nR0kaug6F8QDVSbtoOTILBy/pmz1hfjRgIk4KuO
	V56OTFruQDOrzr2+vYsUq/+zW9Yqf1vjrHgoXgkEl38iycbCF4pZTIuIDpPm/m62/KQPjf41+wt
	01SCSKny6I=
X-Gm-Gg: AfdE7ckujdmzZDtKqsJLxg4xSqSv2oDPmchrpZ/JpLBC7nkel8D+Fl3uTcMT1C3WJcM
	txpgQlL9yQ/YUc0Y7xDBD6x/ILtkvdd7jUT1awrbydzQAhVaWStVddoL1UZL+pGDL+E0xzGil8M
	GEwuPsl1zjYPL/MnMbytotyHLrvuvKPa41wZ6v8JaNedqLCvO4CGZ8tXU7TnuOlw7Nig0d88vHl
	TzrIhxw3KtI3SrGfR8RUr8/4g5BeIux0r2oEcofyGZ0X9OgiWtK6ymk3MBhK5Jnmpeooxcw4Qxl
	qR1ZQDQ1vh9jJQeAUxDM+GaSM7pWdK2VlH03pPeoatyof33TFPTIvMJLiqD+t6dWwr6BXfZB/YH
	EtB1cCh9gZ/lRWhpF5TEeVl3DROwGFDTt1JwGsKGVljqY3uuJqopFgt6ELXShFagx2+toliU0Om
	T9nLolwuhRgD490N2K+nYYdJSGmMpNvhZPEOo2GXVdyFOSjQ==
X-Received: by 2002:a05:6122:c86:b0:5bd:881c:f68e with SMTP id 71dfb90a1353d-5bf75e9a8fdmr6273272e0c.9.1783657502347;
        Thu, 09 Jul 2026 21:25:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5bf6f589340sm720229e0c.2.2026.07.09.21.25.01
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:25:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c9d5a5b63c5so782538a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657501; x=1784262301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gB10DzJdqUeLaylih2t4hNF6tYlwSqhiGRvauXxMUbg=;
        b=bpTPzm01WHb/lczRLOOV5WBv3ARJiqRbeOQSqHU4oL8GzMVLaRFOhAZS9wcRg2THpl
         Im85gU7ZQNfLZ3bBzn6ucCXXE3tC2k5lPYPAStFbaTtyK4qFypBlL/GmJCAk52pge86w
         FWfdKtaNlekSff0SitPUXUzR4o+342QmwRzzU=
X-Received: by 2002:a05:6a20:cc0a:b0:3bf:9142:ba3a with SMTP id adf61e73a8af0-3c0bced4657mr11451589637.26.1783657500541;
        Thu, 09 Jul 2026 21:25:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:cc0a:b0:3bf:9142:ba3a with SMTP id adf61e73a8af0-3c0bced4657mr11451557637.26.1783657499974;
        Thu, 09 Jul 2026 21:24:59 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:24:59 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v5 11/15] bnxt_en: Add crypto MPC transmit/completion infrastructure
Date: Thu,  9 Jul 2026 21:23:56 -0700
Message-ID: <20260710042400.3996847-12-michael.chan@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-306432-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28A33737222

Add infrastructure to support sending crypto commands using the
midpath channels (MPCs).  bnxt_xmit_crypto_cmd() is used to send a
crypto command and sleep with timeout until the completion is received.
If it times out, we recover by resetting the MPC.  The reset is
deferred to bnxt_sp_task() similar to other resets to prevent
deadlock with a concurent close.  The concurrent close may have
acquired the netdev_lock and waiting for the MPC operation to
finish.

The next patch will use this infrastructure to offload kTLS connections.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v5:
Defer the MPC ring reset to bnxt_sp_task() just like other resets to
avoid any possibility od deadlock.

Add more comments to explain the MPC ring disable, stop, start.

v4:
https://lore.kernel.org/netdev/20260629184921.3496727-12-michael.chan@broadcom.com/

Clear MPC entries in bnxt_mpc_ring_reset() if device is going down.

Only clear MPC handle in bnxt_mpc_cmp() if the ring is in normal state to
ensure proper ref counting during reset.

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-12-michael.chan@broadcom.com/

Multiple improvements for the MPC timeout logic, including the use of
refcount to terminate the timeout instead of the arbitrary 200msec poll
wait, add synchronize_net().

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-12-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  16 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 138 +++++++++++-
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  |  95 ++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 208 +++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h |  14 ++
 6 files changed, 470 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d8b9c39dda5c..316733299e23 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -394,7 +394,7 @@ static void __bnxt_queue_sp_work(struct bnxt *bp)
 		schedule_work(&bp->sp_task);
 }
 
-static void bnxt_queue_sp_work(struct bnxt *bp, unsigned int event)
+void bnxt_queue_sp_work(struct bnxt *bp, unsigned int event)
 {
 	set_bit(event, &bp->sp_event);
 	__bnxt_queue_sp_work(bp);
@@ -7720,7 +7720,7 @@ void bnxt_hwrm_cp_ring_free(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 }
 
-static void bnxt_clear_one_cp_ring(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
+void bnxt_clear_one_cp_ring(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 {
 	struct bnxt_ring_struct *ring = &cpr->cp_ring_struct;
 	int i, size = ring->ring_mem.page_size;
@@ -14424,7 +14424,7 @@ static int bnxt_hwrm_rx_ring_reset(struct bnxt *bp, int ring_nr)
 	return hwrm_req_send_silent(bp, req);
 }
 
-static void bnxt_reset_task(struct bnxt *bp, bool silent)
+void bnxt_reset_task(struct bnxt *bp, bool silent)
 {
 	if (!silent)
 		bnxt_dbg_dump_states(bp);
@@ -14873,6 +14873,13 @@ static void bnxt_ulp_restart(struct bnxt *bp)
 	bnxt_ulp_start(bp);
 }
 
+static void bnxt_mpc_ring_reset_sp(struct bnxt *bp)
+{
+	bnxt_rtnl_lock_sp(bp);
+	bnxt_mpc_ring_reset_task(bp);
+	bnxt_rtnl_unlock_sp(bp);
+}
+
 static void bnxt_sp_task(struct work_struct *work)
 {
 	struct bnxt *bp = container_of(work, struct bnxt, sp_task);
@@ -14965,6 +14972,9 @@ static void bnxt_sp_task(struct work_struct *work)
 	if (test_and_clear_bit(BNXT_RST_RING_SP_EVENT, &bp->sp_event))
 		bnxt_rx_ring_reset(bp);
 
+	if (test_and_clear_bit(BNXT_MPC_RESET_SP_EVENT, &bp->sp_event))
+		bnxt_mpc_ring_reset_sp(bp);
+
 	if (test_and_clear_bit(BNXT_FW_RESET_NOTIFY_SP_EVENT, &bp->sp_event)) {
 		if (test_bit(BNXT_STATE_FW_FATAL_COND, &bp->state) ||
 		    test_bit(BNXT_STATE_FW_NON_FATAL_COND, &bp->state))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e62b856e78f9..b65538fda3bd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2672,6 +2672,7 @@ struct bnxt {
 #define BNXT_THERMAL_THRESHOLD_SP_EVENT	22
 #define BNXT_FW_ECHO_REQUEST_SP_EVENT	23
 #define BNXT_RESTART_ULP_SP_EVENT	24
+#define BNXT_MPC_RESET_SP_EVENT		25
 
 	struct delayed_work	fw_reset_task;
 	int			fw_reset_state;
@@ -2984,6 +2985,7 @@ static inline enum pkt_hash_types bnxt_rss_ext_op(struct bnxt *bp,
 extern const u16 bnxt_bstore_to_trace[];
 extern const u16 bnxt_lhint_arr[];
 
+void bnxt_queue_sp_work(struct bnxt *bp, unsigned int event);
 int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		       u16 prod, gfp_t gfp);
 void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data);
@@ -3025,6 +3027,7 @@ int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 void bnxt_hwrm_tx_ring_free(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			    bool close_path);
 void bnxt_hwrm_cp_ring_free(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
+void bnxt_clear_one_cp_ring(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
 int bnxt_total_tx_rings(struct bnxt *bp);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
@@ -3071,6 +3074,7 @@ void bnxt_sync_ring_stats(struct bnxt *bp);
 bool bnxt_rfs_capable(struct bnxt *bp, bool new_rss_ctx);
 int bnxt_dbg_hwrm_rd_reg(struct bnxt *bp, u32 reg_off, u16 num_words,
 			 u32 *reg_buf);
+void bnxt_reset_task(struct bnxt *bp, bool silent);
 void bnxt_fw_exception(struct bnxt *bp);
 void bnxt_fw_reset(struct bnxt *bp);
 int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index 72927c32bf0c..27a61173dd7c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -5,10 +5,12 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #include <linux/bnxt/hsi.h>
 
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
+#include "bnxt_mpc.h"
 #include "bnxt_crypto.h"
 
 static u32 bnxt_get_max_crypto_key_ctx(struct bnxt *bp, int key_type)
@@ -42,6 +44,7 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 	u16 max_keys = le16_to_cpu(resp->max_key_ctxs_alloc);
 	struct bnxt_crypto_info *crypto = bp->crypto_info;
 	struct bnxt_kctx *kctx;
+	char name[64];
 	int i;
 
 	if (BNXT_VF(bp))
@@ -53,6 +56,15 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 				    "Unable to allocate crypto info\n");
 			return;
 		}
+		snprintf(name, sizeof(name), "bnxt_crypto-%s",
+			 dev_name(&bp->pdev->dev));
+		crypto->mpc_cache =
+			kmem_cache_create(name,
+					  sizeof(struct bnxt_crypto_cmd_ctx),
+					  0, SLAB_HWCACHE_ALIGN, NULL);
+		if (!crypto->mpc_cache)
+			goto alloc_err;
+
 		for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
 			kctx = &crypto->kctx[i];
 			kctx->type = i;
@@ -69,6 +81,10 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 	}
 	crypto->max_key_ctxs_alloc = max_keys;
 	bp->fw_cap |= BNXT_FW_CAP_KTLS;
+	return;
+
+alloc_err:
+	kfree(crypto);
 }
 
 /**
@@ -119,8 +135,13 @@ void bnxt_clear_crypto(struct bnxt *bp)
  */
 void bnxt_free_crypto_info(struct bnxt *bp)
 {
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+
+	if (!crypto)
+		return;
 	bnxt_clear_crypto(bp);
-	kfree(bp->crypto_info);
+	kmem_cache_destroy(crypto->mpc_cache);
+	kfree(crypto);
 	bp->crypto_info = NULL;
 	bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
 }
@@ -369,6 +390,82 @@ int bnxt_key_ctx_alloc_one(struct bnxt *bp, struct bnxt_kctx *kctx, u8 kind,
 	return -EAGAIN;
 }
 
+#define BNXT_XMIT_CRYPTO_RETRY_MAX	10
+#define BNXT_XMIT_CRYPTO_MIN_TMO	100
+#define BNXT_XMIT_CRYPTO_MAX_TMO	150
+
+int bnxt_xmit_crypto_cmd(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			 void *cmd, unsigned int len, unsigned int tmo)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_crypto_cmd_ctx *ctx = NULL;
+	unsigned long tmo_left, handle = 0;
+	int rc, retry = 0;
+
+	if (tmo) {
+		u32 kid = CE_CMD_KID(cmd);
+
+		ctx = kmem_cache_alloc(crypto->mpc_cache, GFP_KERNEL);
+		if (!ctx)
+			return -ENOMEM;
+		init_completion(&ctx->cmp);
+		handle = (unsigned long)ctx;
+		ctx->kid = kid;
+		ctx->client = txr->tx_ring_struct.mpc_chnl_type;
+		ctx->status = 0;
+		/* One reference for this caller, one for the handle stored in
+		 * the TX buf ring.  The latter is dropped by
+		 * bnxt_crypto_mpc_cmp() when the command is completed normally
+		 * or after timeout.
+		 */
+		refcount_set(&ctx->refcnt, 2);
+		retry = BNXT_XMIT_CRYPTO_RETRY_MAX;
+		might_sleep();
+	}
+	do {
+		spin_lock_bh(&txr->tx_lock);
+		rc = bnxt_start_xmit_mpc(bp, txr, cmd, len, handle);
+		spin_unlock_bh(&txr->tx_lock);
+		if (rc == -EBUSY && tmo && retry)
+			usleep_range(BNXT_XMIT_CRYPTO_MIN_TMO,
+				     BNXT_XMIT_CRYPTO_MAX_TMO);
+		else
+			break;
+	} while (retry--);
+	if (rc || !tmo) {
+		/* The completion will never arrive, drop one reference */
+		if (ctx)
+			refcount_dec(&ctx->refcnt);
+		goto xmit_done;
+	}
+
+	tmo_left = wait_for_completion_timeout(&ctx->cmp, msecs_to_jiffies(tmo));
+	if (!tmo_left) {
+		netdev_warn(bp->dev, "crypto MP cmd %08x timed out\n",
+			    *((u32 *)cmd));
+		bnxt_mpc_timeout(bp, txr);
+		rc = -ETIMEDOUT;
+		goto xmit_done;
+	}
+	if (ctx->status == BNXT_CMD_CTX_COMPLETED &&
+	    CE_CMPL_STATUS(&ctx->ce_cmp) == CE_CMPL_STATUS_OK)
+		rc = 0;
+	else
+		rc = -EIO;
+xmit_done:
+	if (rc) {
+		u8 status = ctx ? ctx->status : 0;
+
+		netdev_warn(bp->dev,
+			    "MPC transmit failed, ring idx %d, op 0x%x, kid 0x%x, status 0x%x\n",
+			    txr->bnapi->index, CE_CMD_OP(cmd), CE_CMD_KID(cmd),
+			    status);
+	}
+	if (ctx && refcount_dec_and_test(&ctx->refcnt))
+		kmem_cache_free(crypto->mpc_cache, ctx);
+	return rc;
+}
+
 int bnxt_crypto_init(struct bnxt *bp)
 {
 	struct bnxt_crypto_info *crypto = bp->crypto_info;
@@ -398,3 +495,42 @@ int bnxt_crypto_init(struct bnxt *bp)
 
 	return 0;
 }
+
+void bnxt_crypto_mpc_cmp(struct bnxt *bp, u32 client, unsigned long handle,
+			 struct bnxt_cmpl_entry cmpl[], u32 entries)
+{
+	struct bnxt_crypto_cmd_ctx *ctx;
+	struct ce_cmpl *cmp = NULL;
+	u32 len, kid;
+
+	if (likely(cmpl))
+		cmp = cmpl[0].cmpl;
+	if (!handle || entries != 1) {
+		if (entries != 1 && cmpl) {
+			netdev_warn(bp->dev, "Invalid entries %d with handle %lx cmpl %08x in %s()\n",
+				    entries, handle, *(u32 *)cmp, __func__);
+		}
+		if (!handle)
+			return;
+	}
+	ctx = (void *)handle;
+	ctx->status = BNXT_CMD_CTX_COMPLETED;
+	if (unlikely(!cmpl)) {
+		ctx->status |= BNXT_CMD_CTX_RESET;
+		goto cmp_done;
+	}
+	kid = CE_CMPL_KID(cmp);
+	if (ctx->kid != kid || ctx->client != client || entries != 1) {
+		netdev_warn(bp->dev,
+			    "Invalid CE cmpl 0x%08x with entries %d for client %d with status 0x%x, expected kid 0x%x and client %d\n",
+			    *(u32 *)cmp, entries, client, ctx->status, ctx->kid,
+			    ctx->client);
+		ctx->status |= BNXT_CMD_CTX_ERROR;
+	}
+	len = min_t(u32, cmpl[0].len, sizeof(ctx->ce_cmp));
+	memcpy(&ctx->ce_cmp, cmpl[0].cmpl, len);
+cmp_done:
+	complete(&ctx->cmp);
+	if (refcount_dec_and_test(&ctx->refcnt))
+		kmem_cache_free(bp->crypto_info->mpc_cache, ctx);
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
index f88aa410efdd..8a2cbb7603a8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -4,6 +4,8 @@
 #ifndef BNXT_CRYPTO_H
 #define BNXT_CRYPTO_H
 
+#include <linux/refcount.h>
+
 #define BNXT_MAX_TX_CRYPTO_KEYS		204800
 #define BNXT_MAX_RX_CRYPTO_KEYS		204800
 
@@ -61,6 +63,80 @@ struct bnxt_crypto_info {
 	u16			max_key_ctxs_alloc;
 
 	struct bnxt_kctx	kctx[BNXT_MAX_CRYPTO_KEY_TYPE];
+
+	struct kmem_cache	*mpc_cache;
+};
+
+struct ce_delete_cmd {
+	__le32  ctx_kind_kid_opcode;
+	#define CE_DELETE_CMD_OPCODE_MASK		0xfUL
+	#define CE_DELETE_CMD_OPCODE_SFT		0
+	#define CE_DELETE_CMD_OPCODE_DEL		 0x2UL
+	#define CE_DELETE_CMD_KID_MASK			0xfffff0UL
+	#define CE_DELETE_CMD_KID_SFT			4
+	#define CE_DELETE_CMD_CTX_KIND_MASK		0x1f000000UL
+	#define CE_DELETE_CMD_CTX_KIND_SFT		24
+	#define CE_DELETE_CMD_CTX_KIND_CK_TX		 (0x11UL << 24)
+	#define CE_DELETE_CMD_CTX_KIND_CK_RX		 (0x12UL << 24)
+};
+
+#define CE_CMD_OP_MASK			0x00000fU
+#define CE_CMD_KID_MASK			0xfffff0U
+#define CE_CMD_KID_SFT			4
+
+#define CE_CMD_OP(cmd_p)					\
+	(le32_to_cpu(*(__le32 *)(cmd_p)) & CE_CMD_OP_MASK)
+
+#define CE_CMD_KID(cmd_p)					\
+	((le32_to_cpu(*(__le32 *)(cmd_p)) & CE_CMD_KID_MASK) >> CE_CMD_KID_SFT)
+
+struct ce_cmpl {
+	__le16	client_subtype_type;
+	#define CE_CMPL_TYPE_MASK			0x3fUL
+	#define CE_CMPL_TYPE_SFT			0
+	#define CE_CMPL_TYPE_MID_PATH_SHORT		 0x1eUL
+	#define CE_CMPL_SUBTYPE_MASK			0xf00UL
+	#define CE_CMPL_SUBTYPE_SFT			8
+	#define CE_CMPL_SUBTYPE_SOLICITED		 (0x0UL << 8)
+	#define CE_CMPL_SUBTYPE_ERR			 (0x1UL << 8)
+	#define CE_CMPL_SUBTYPE_RESYNC			 (0x2UL << 8)
+	#define CE_CMPL_MP_CLIENT_MASK			0xf000UL
+	#define CE_CMPL_MP_CLIENT_SFT			12
+	#define CE_CMPL_MP_CLIENT_TCE			 (0x0UL << 12)
+	#define CE_CMPL_MP_CLIENT_RCE			 (0x1UL << 12)
+	__le16	status;
+	#define CE_CMPL_STATUS_MASK			0xfUL
+	#define CE_CMPL_STATUS_SFT			0
+	#define CE_CMPL_STATUS_OK			 0x0UL
+	#define CE_CMPL_STATUS_CTX_LD_ERR		 0x1UL
+	#define CE_CMPL_STATUS_FID_CHK_ERR		 0x2UL
+	#define CE_CMPL_STATUS_CTX_VER_ERR		 0x3UL
+	#define CE_CMPL_STATUS_DST_ID_ERR		 0x4UL
+	#define CE_CMPL_STATUS_MP_CMD_ERR		 0x5UL
+	u32	opaque;
+	__le32	v;
+	#define CE_CMPL_V           0x1UL
+	__le32	kid;
+	#define CE_CMPL_KID_MASK    0xfffffUL
+	#define CE_CMPL_KID_SFT     0
+};
+
+#define CE_CMPL_STATUS(ce_cmpl)						\
+	(le16_to_cpu((ce_cmpl)->status) & CE_CMPL_STATUS_MASK)
+
+#define CE_CMPL_KID(ce_cmpl)						\
+	(le32_to_cpu((ce_cmpl)->kid) & CE_CMPL_KID_MASK)
+
+struct bnxt_crypto_cmd_ctx {
+	struct completion cmp;
+	struct ce_cmpl ce_cmp;
+	refcount_t refcnt;
+	u32 kid;
+	u16 client;
+	u8 status;
+#define BNXT_CMD_CTX_COMPLETED	0x1
+#define BNXT_CMD_CTX_ERROR	0x2
+#define BNXT_CMD_CTX_RESET	0x4
 };
 
 #define BNXT_TCK(crypto)	((crypto)->kctx[BNXT_TX_CRYPTO_KEY_TYPE])
@@ -80,7 +156,11 @@ bool bnxt_kid_valid(struct bnxt_kctx *kctx, u32 id);
 void bnxt_free_one_kctx(struct bnxt_kctx *kctx, u32 id);
 int bnxt_key_ctx_alloc_one(struct bnxt *bp, struct bnxt_kctx *kctx, u8 kind,
 			   u32 *id);
+int bnxt_xmit_crypto_cmd(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			 void *cmd, unsigned int len, unsigned int tmo);
 int bnxt_crypto_init(struct bnxt *bp);
+void bnxt_crypto_mpc_cmp(struct bnxt *bp, u32 client, unsigned long handle,
+			 struct bnxt_cmpl_entry cmpl[], u32 entries);
 #else
 static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
 					  struct hwrm_func_qcaps_output *resp)
@@ -116,9 +196,24 @@ static inline int bnxt_key_ctx_alloc_one(struct bnxt *bp,
 	return -EOPNOTSUPP;
 }
 
+static inline int bnxt_xmit_crypto_cmd(struct bnxt *bp,
+				       struct bnxt_tx_ring_info *txr,
+				       void *cmd, unsigned int len,
+				       unsigned int tmo)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int bnxt_crypto_init(struct bnxt *bp)
 {
 	return 0;
 }
+
+static inline void bnxt_crypto_mpc_cmp(struct bnxt *bp, u32 client,
+				       unsigned long handle,
+				       struct bnxt_cmpl_entry cmpl[],
+				       u32 entries)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_CRYPTO_H */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index a8d757712b38..71ebeb6ff33a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -9,6 +9,7 @@
 
 #include "bnxt.h"
 #include "bnxt_mpc.h"
+#include "bnxt_crypto.h"
 
 void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -501,6 +502,206 @@ int bnxt_start_xmit_mpc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	return 0;
 }
 
+/* Returns true if the ring is successfully marked as closing.  It
+ * means that there will be no more MPC transmissions and NAPI will now
+ * complete any MPC completions on the completion ring with NULL handles
+ * to signal abort.
+ */
+static bool bnxt_disable_mpc_ring(struct bnxt_mpc_info *mpc, int mpc_ring)
+{
+	struct bnxt_tx_ring_info *txr;
+	bool disabled = false;
+	int i;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		if (mpc_ring >= mpc->mpc_ring_count[i])
+			continue;
+		txr = &mpc->mpc_rings[i][mpc_ring];
+		spin_lock_bh(&txr->tx_lock);
+		if (!READ_ONCE(txr->dev_state)) {
+			disabled = true;
+			WRITE_ONCE(txr->dev_state, BNXT_DEV_STATE_CLOSING);
+		}
+		spin_unlock_bh(&txr->tx_lock);
+		if (!disabled)
+			break;
+	}
+	/* Make sure napi polls see @dev_state change */
+	if (disabled)
+		synchronize_net();
+	return disabled;
+}
+
+static void bnxt_enable_mpc_ring(struct bnxt_mpc_info *mpc, int mpc_ring)
+{
+	struct bnxt_tx_ring_info *txr;
+	int i;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		if (mpc_ring >= mpc->mpc_ring_count[i])
+			continue;
+		txr = &mpc->mpc_rings[i][mpc_ring];
+		WRITE_ONCE(txr->dev_state, 0);
+	}
+}
+
+static void bnxt_clear_one_mpc_entries(struct bnxt *bp,
+				       struct bnxt_tx_ring_info *txr)
+{
+	struct bnxt_sw_mpc_tx_bd *tx_buf;
+	unsigned long handle;
+	int i, max_idx;
+	u32 client;
+
+	max_idx = bp->tx_nr_pages * TX_DESC_CNT;
+
+	for (i = 0; i < max_idx; i++) {
+		tx_buf = &txr->tx_mpc_buf_ring[i];
+		handle = tx_buf->handle;
+		if (handle) {
+			client = txr->tx_ring_struct.mpc_chnl_type;
+			bnxt_crypto_mpc_cmp(bp, client, handle, NULL, 0);
+			tx_buf->handle = 0;
+		}
+	}
+}
+
+static void bnxt_mpc_ring_stop(struct bnxt *bp, struct bnxt_mpc_info *mpc,
+			       int mpc_ring)
+{
+	struct bnxt_tx_ring_info *txr;
+	struct bnxt_cp_ring_info *cpr;
+	int i;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		if (mpc->mpc_ring_count[i] > mpc_ring) {
+			txr = &mpc->mpc_rings[i][mpc_ring];
+			bnxt_hwrm_tx_ring_free(bp, txr, true);
+		}
+	}
+	/* CP ring must be freed at the end to guarantee that the HWRM_DONE
+	 * responses for HWRM_RING_FREE can still be seen on the CP ring.
+	 */
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		if (mpc->mpc_ring_count[i] > mpc_ring) {
+			txr = &mpc->mpc_rings[i][mpc_ring];
+			cpr = txr->tx_cpr;
+			if (cpr)
+				bnxt_hwrm_cp_ring_free(bp, cpr);
+		}
+	}
+	/* No new DMA to the CP ring at this point, but we need to wait
+	 * for any in-flight NAPI poll to finish before we zero the
+	 * completion entries in the CP ring.
+	 */
+	synchronize_net();
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		if (mpc->mpc_ring_count[i] > mpc_ring) {
+			txr = &mpc->mpc_rings[i][mpc_ring];
+			cpr = txr->tx_cpr;
+			if (cpr)
+				bnxt_clear_one_cp_ring(bp, cpr);
+			bnxt_clear_one_mpc_entries(bp, txr);
+		}
+	}
+}
+
+static int bnxt_mpc_ring_start(struct bnxt *bp, struct bnxt_mpc_info *mpc,
+			       int mpc_ring)
+{
+	struct bnxt_tx_ring_info *txr;
+	int i, rc;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		if (mpc->mpc_ring_count[i] > mpc_ring) {
+			txr = &mpc->mpc_rings[i][mpc_ring];
+			txr->tx_prod = 0;
+			txr->tx_cons = 0;
+			txr->tx_hw_cons = 0;
+			rc = bnxt_hwrm_one_mpc_ring_alloc(bp, txr);
+			if (rc)
+				return rc;
+		}
+	}
+	return 0;
+}
+
+/* Called from bnxt_sp_task() with netdev_lock held.  If the device is not
+ * open there is nothing to do: the open path will re-allocate and
+ * re-initialize all MPC rings.
+ */
+void bnxt_mpc_ring_reset_task(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	struct bnxt_tx_ring_info *txr;
+	int i, j;
+
+	if (!mpc || !test_bit(BNXT_STATE_OPEN, &bp->state))
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		for (j = 0; j < mpc->mpc_ring_count[i]; j++) {
+			txr = &mpc->mpc_rings[i][j];
+			if (READ_ONCE(txr->dev_state) != BNXT_DEV_STATE_CLOSING)
+				continue;
+
+			/* Resets the whole ring (both types) */
+			netdev_warn(bp->dev, "Resetting MPC ring %d\n", j);
+			bnxt_mpc_ring_stop(bp, mpc, j);
+			if (bnxt_mpc_ring_start(bp, mpc, j)) {
+				netdev_err(bp->dev, "Error starting MPC ring %d, resetting device\n",
+					   j);
+				bnxt_mpc_ring_stop(bp, mpc, j);
+				bnxt_reset_task(bp, true);
+				/* bnxt_reset_task() will clear everything */
+				return;
+			}
+			bnxt_enable_mpc_ring(mpc, j);
+		}
+	}
+}
+
+static int bnxt_mpc_ring_reset(struct bnxt *bp, int mpc_ring)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	struct bnxt_tx_ring_info *txr;
+	int i;
+
+	if (!mpc)
+		return 0;
+	if (mpc_ring >= mpc->mpc_cp_rings)
+		return -EINVAL;
+
+	if (!bnxt_disable_mpc_ring(mpc, mpc_ring))
+		return 0;
+
+	/* Completion handles will no longer be processed at this point
+	 * from NAPI, so we can complete the outstanding commands and
+	 * release the command contexts.
+	 */
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		if (mpc->mpc_ring_count[i] > mpc_ring) {
+			txr = &mpc->mpc_rings[i][mpc_ring];
+			bnxt_clear_one_mpc_entries(bp, txr);
+		}
+	}
+
+	/* If the device is going down, the reopen will re-allocate and
+	 * re-initialize all MPC rings.  Otherwise defer the reset to
+	 * bnxt_sp_task() to safely hold the netdev_lock.
+	 */
+	if (test_bit(BNXT_STATE_OPEN, &bp->state))
+		bnxt_queue_sp_work(bp, BNXT_MPC_RESET_SP_EVENT);
+	return 0;
+}
+
+int bnxt_mpc_timeout(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
+{
+	if (txr->tx_ring_struct.queue_id == BNXT_MPC_QUEUE_ID)
+		return bnxt_mpc_ring_reset(bp, txr->txq_index);
+	return -EINVAL;
+}
+
 static bool bnxt_mpc_unsolicit(struct mpc_cmp *mpcmp)
 {
 	u32 client = MPC_CMP_CLIENT_TYPE(mpcmp);
@@ -517,6 +718,7 @@ int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons)
 	u16 cons = RING_CMP(*raw_cons);
 	struct mpc_cmp *mpcmp, *mpcmp1;
 	u32 tmp_raw_cons = *raw_cons;
+	unsigned long handle = 0;
 	u32 client, cmpl_num;
 	u8 type;
 
@@ -565,11 +767,15 @@ int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons)
 			goto cmp_done;
 		}
 		mpc_buf = &txr->tx_mpc_buf_ring[RING_TX(bp, tx_cons)];
-		mpc_buf->handle = 0;
+		if (!READ_ONCE(txr->dev_state)) {
+			handle = mpc_buf->handle;
+			mpc_buf->handle = 0;
+		}
 		tx_cons += mpc_buf->inline_bds;
 		WRITE_ONCE(txr->tx_cons, tx_cons);
 		txr->tx_hw_cons = RING_TX(bp, tx_cons);
 	}
+	bnxt_crypto_mpc_cmp(bp, client, handle, cmpl_entry_arr, cmpl_num);
 
 cmp_done:
 	*raw_cons = tmp_raw_cons;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index 91fb27ba8090..b0b1e783cdc7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -22,6 +22,8 @@ enum bnxt_mpc_type {
 #define BNXT_DFLT_MPC_TCE	BNXT_MAX_MPC
 #define BNXT_DFLT_MPC_RCE	BNXT_MAX_MPC
 
+#define BNXT_MPC_TMO_MSECS      1000
+
 struct bnxt_mpc_info {
 	u8			mpc_chnls_cap;
 	u8			mpc_cp_rings;
@@ -109,6 +111,8 @@ void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path);
 struct bnxt_tx_ring_info *bnxt_select_mpc_ring(struct bnxt *bp, int ring_type);
 int bnxt_start_xmit_mpc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			void *data, unsigned int len, unsigned long handle);
+void bnxt_mpc_ring_reset_task(struct bnxt *bp);
+int bnxt_mpc_timeout(struct bnxt *bp, struct bnxt_tx_ring_info *txr);
 int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
@@ -204,6 +208,16 @@ static inline int bnxt_start_xmit_mpc(struct bnxt *bp,
 	return -EOPNOTSUPP;
 }
 
+static inline void bnxt_mpc_ring_reset_task(struct bnxt *bp)
+{
+}
+
+static inline int bnxt_mpc_timeout(struct bnxt *bp,
+				   struct bnxt_tx_ring_info *txr)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			       u32 *raw_cons)
 {
-- 
2.51.0


