Return-Path: <netdev+bounces-292048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCXSIGJMFmrZkQcAu9opvQ
	(envelope-from <netdev+bounces-292048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:44:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9E55DE566
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B631307F494
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD10532AABD;
	Wed, 27 May 2026 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqlFi0SP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B5233134
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846083; cv=none; b=OfXi3ghwrcEgu/tjJG3/wJ+WstI30bpg7IuO1YgbyAFxE/uZMPBl1zD2625wkRwWigC0IC1+BTfNB/op91ezD6zRasxWukhdQQMumSapR7Dit3ahNdKkZionr6Qjbu+17Fnq2zI+9wo7ewfbMg9iMbqdfjr41rqp3hNmhkMGfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846083; c=relaxed/simple;
	bh=CNWW4remKqeDQitFYlFGmPkKomMCfcQ6+mnDtc+ErHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGS04qoqScZmysIrlPhWJtCHXl5gEXBI5B7ESJLLhtsFSdeccuR9NUS6ajqbbi+VcOEeoiNCmS47VDGVI7LJxhZw0vLkYWz+mcdQ7cTpehX3WKAWp5pC6a4ZqID4rrliYg9M7+qxR8C27MCp1kAvCM4dZxhCxJ4zZmVBKoZH4tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqlFi0SP; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2bc763e2ba8so56750125ad.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 18:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779846081; x=1780450881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xL0f/mOyd/xxbGC1ZakKovT0Q/B0WOE1XCsqCWuALw=;
        b=LqlFi0SPuqGzjUQWruNCFvrFFrM2Y2YdCXNBBwJ+JRedJtVUO5lagMeB6bQUHiNmjt
         Rkxn+/pPqwQ74ccDcLa8coctfuWC6Omh8yh/ZyvZ9CvJJvKTC2obUHA/CSa9RDvMqRX3
         0crqzYyDytdhtMuMR9ZFQijS/Fkm0hmxfVWr5kRWXS4YlBe5pY0xETx8Pysupb0tNa/H
         EIHCCuHkte+6KCMJfS6opLj8xgHhaSc6hRIBoSTfWfHEphHGlVo7NuHDJk4j1ukZ1QaX
         DwAZdgPd3VtSySpByEzTnkqjE0nL8habfCVA04jer20xgfQ0CBVspdwVwt8n1xJ5h3+B
         EOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846081; x=1780450881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2xL0f/mOyd/xxbGC1ZakKovT0Q/B0WOE1XCsqCWuALw=;
        b=oTrpa/OBWIBguvPP2tmfr1ns6I4jG0kVPsbBDgiC3Ad4gdfZmkMOazAcR5E3SMCFgc
         F5mt1NznWMgkpEE9qTXGO6FhxdKGGGKMAcZv08zgaAtN+ZMkBhwaXOqVSM9r8xSbB1jW
         za3dPD932LHX/5RLVNgTkcWTFRkhntmHQjmvLBMlGjW3nu36dSJkR88Gti2HcZWt2YzX
         /WHWcRt+h1mxhYsxjAgN30zoYqJz74LokuOf1QlPOLswIKFCBOlGPNqCTXJJFVKshNRW
         B1hCs3/PiViCfbtqqFxTxBB8p6ouqLyT+d+BHFBveRIpWA8yt1QU7a2qjZqxaR/WxqZT
         qzag==
X-Gm-Message-State: AOJu0YwwavoNGhB63m8ZZx5a5u7oal3ZXFNJkd6X6RaRyQhqfrxj8m2P
	GdD2Hifo2CsU/+upNGIwIBSAjv4cNeYh7c0WN8yAa3DsBCxqEljlZBaKPKMrxkre
X-Gm-Gg: Acq92OEAQp5hWAtesrsboIzNd7Uuhuq+rkRsFrL40kbad46kUYsvUFjYcFXC0CIW1QX
	rwXcaE3zjmzNzt00fhejbIALhh7++nMtcX9EgtvL/y618O8gEI6wFTtCDJJvBPSEHCzz2+n+62h
	BzlN1rb1VuE3yu9OYAa2t3Ywp2+Alls/WFMJpRsXzdgWA2M0tQrcthXZkFLqz0a57O/0pFuk5rm
	9GOI8ikHcn2te6iBwLxlJWuvFGbTs/ZCFUdY22jPVTLiE0ZbaOPkplmqbQVtoIDSqco3QZv5148
	Y26c/k/DyrWzgAUVKyLET1s9vLl2MqsoIqvP6PZ9r96FeWw5kC9Z357l4Y5GFydE/6iE7I4/4yI
	sSiN9olqdkkUmWIIVUojJWrPStMhE6suaBOLPsrG2GUJA2XE8sRpcfqChzxGn8ueS38yh6wdm7u
	o8ApVLfbHr/B04vme7
X-Received: by 2002:a17:902:e542:b0:2bd:b585:55f5 with SMTP id d9443c01a7336-2beb069c13dmr231533365ad.8.1779846081526;
        Tue, 26 May 2026 18:41:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58fd888sm141587205ad.73.2026.05.26.18.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 18:41:21 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 3/3] bnxt: convert to core rx_mode retry mechanism
Date: Tue, 26 May 2026 18:41:17 -0700
Message-ID: <20260527014117.1401809-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527014117.1401809-1-sdf@fomichev.me>
References: <20260527014117.1401809-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292048-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Queue-Id: DD9E55DE566
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the driver-specific BNXT_STATE_L2_FILTER_RETRY + timer + sp_task
retry mechanism and rely on the core stack's ndo_set_rx_mode_async retry
instead.

bnxt_cfg_rx_mode() now returns errors (including -ENODEV when the VF
cannot reach the PF), allowing the core stack to schedule retries with
exponential backoff.

Call core's netif_rx_mode_schedule_retry during reset to handle
VF reopen.

Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++---------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 --
 2 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8459a21cf0a9..3186fdaa1fd0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11232,8 +11232,14 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 	}
 
 	rc = bnxt_cfg_rx_mode(bp, &bp->dev->uc, true);
-	if (rc)
-		goto err_out;
+	if (rc) {
+		if (BNXT_VF(bp) && rc == -ENODEV) {
+			netif_rx_mode_schedule_retry(bp->dev);
+			rc = 0;
+		} else {
+			goto err_out;
+		}
+	}
 
 skip_rx_mask:
 	rc = bnxt_hwrm_set_coal(bp);
@@ -13716,7 +13722,7 @@ static int bnxt_set_rx_mode(struct net_device *dev,
 	if (mask != vnic->rx_mask || uc_update || mc_update) {
 		vnic->rx_mask = mask;
 
-		bnxt_cfg_rx_mode(bp, uc, uc_update);
+		return bnxt_cfg_rx_mode(bp, uc, uc_update);
 	}
 
 	return 0;
@@ -13757,21 +13763,14 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
 	for (i = 1, off = 0; i < vnic->uc_filter_count; i++, off += ETH_ALEN) {
 		rc = bnxt_hwrm_set_vnic_filter(bp, 0, i, vnic->uc_list + off);
 		if (rc) {
-			if (BNXT_VF(bp) && rc == -ENODEV) {
-				if (!test_and_set_bit(BNXT_STATE_L2_FILTER_RETRY, &bp->state))
-					netdev_warn(bp->dev, "Cannot configure L2 filters while PF is unavailable, will retry\n");
-				else
-					netdev_dbg(bp->dev, "PF still unavailable while configuring L2 filters.\n");
-				rc = 0;
-			} else {
+			if (BNXT_VF(bp) && rc == -ENODEV)
+				netdev_warn(bp->dev, "Cannot configure L2 filters while PF is unavailable, will retry\n");
+			else
 				netdev_err(bp->dev, "HWRM vnic filter failure rc: %x\n", rc);
-			}
 			vnic->uc_filter_count = i;
 			return rc;
 		}
 	}
-	if (test_and_clear_bit(BNXT_STATE_L2_FILTER_RETRY, &bp->state))
-		netdev_notice(bp->dev, "Retry of L2 filter configuration successful.\n");
 
 skip_uc:
 	if ((vnic->rx_mask & CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS) &&
@@ -14362,9 +14361,6 @@ static void bnxt_timer(struct timer_list *t)
 		}
 	}
 
-	if (test_bit(BNXT_STATE_L2_FILTER_RETRY, &bp->state))
-		bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
-
 	if ((BNXT_CHIP_P5(bp)) && !bp->chip_rev && netif_carrier_ok(dev))
 		bnxt_queue_sp_work(bp, BNXT_RING_COAL_NOW_SP_EVENT);
 
@@ -14712,7 +14708,6 @@ static void bnxt_ulp_restart(struct bnxt *bp)
 static void bnxt_sp_task(struct work_struct *work)
 {
 	struct bnxt *bp = container_of(work, struct bnxt, sp_task);
-	struct net_device *dev = bp->dev;
 
 	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 	smp_mb__after_atomic();
@@ -14790,13 +14785,6 @@ static void bnxt_sp_task(struct work_struct *work)
 	/* These functions below will clear BNXT_STATE_IN_SP_TASK.  They
 	 * must be the last functions to be called before exiting.
 	 */
-	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event)) {
-		bnxt_lock_sp(bp);
-		if (test_bit(BNXT_STATE_OPEN, &bp->state))
-			bnxt_cfg_rx_mode(bp, &dev->uc, true);
-		bnxt_unlock_sp(bp);
-	}
-
 	if (test_and_clear_bit(BNXT_RESET_TASK_SP_EVENT, &bp->sp_event))
 		bnxt_reset(bp, false);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 61c847b36b9f..c089afdb186d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2467,7 +2467,6 @@ struct bnxt {
 #define BNXT_STATE_DRV_REGISTERED	7
 #define BNXT_STATE_PCI_CHANNEL_IO_FROZEN	8
 #define BNXT_STATE_NAPI_DISABLED	9
-#define BNXT_STATE_L2_FILTER_RETRY	10
 #define BNXT_STATE_FW_ACTIVATE		11
 #define BNXT_STATE_RECOVER		12
 #define BNXT_STATE_FW_NON_FATAL_COND	13
@@ -2622,7 +2621,6 @@ struct bnxt {
 
 	struct work_struct	sp_task;
 	unsigned long		sp_event;
-#define BNXT_RX_MASK_SP_EVENT		0
 #define BNXT_RX_NTP_FLTR_SP_EVENT	1
 #define BNXT_LINK_CHNG_SP_EVENT		2
 #define BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT	3
-- 
2.53.0-Meta


