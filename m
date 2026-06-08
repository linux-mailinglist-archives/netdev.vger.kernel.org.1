Return-Path: <netdev+bounces-296649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AwM1A9LnJmpymwIAu9opvQ
	(envelope-from <netdev+bounces-296649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:03:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F4065877A
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:03:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Zzgg5su/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296649-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296649-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFF9136FC9D2
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74663E7151;
	Mon,  8 Jun 2026 15:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16D3E6DC6
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933222; cv=none; b=EAsTNSsNKDPk7R1zdawjsl5V+D8JjGJvfochn4FWzDV/H89LxsfhF28kM6hwM2sIRUIeKhj92XAPCl0ecADfnq07e7ChZmdA6vuDyIBadILaA9jBuoc1qoDU2SGvU8wKy7uxLjSMnd0j69sVusOIXqoYC3lJCN2KmZM9NV2DiW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933222; c=relaxed/simple;
	bh=Sk5t69A0NsKjaJgPi0Dm9uLD8cbJxMb2E50MYcQ9K8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nu/A4Mfdygf8yY6lSThG0N0kFmdTqWtwkjf0+PcLijNfDweakQsPRmFNnc7k69nKfi8a0EBdZ7yhSJ4S2DeieWL71/Y6QOtY4rmmrPxEZKyFnSSGiHW6J4ivTKzAlbekDncJKIx/ZUgsHBXEacFxa9QUbmeIwdTveSQH/FNskes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zzgg5su/; arc=none smtp.client-ip=209.85.210.193
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-842307472d4so1411352b3a.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933221; x=1781538021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PQSUUr369qP40HbNZE8YmdPdco/pgXnDVzZ0VoLIYI=;
        b=Zzgg5su/+mfgeEZdMKi2S0/K0tgkecUS+zqI2HEeXyMQ3C2pM4yfEx8h9ubY/ucMEP
         G59MZ8b8XS+fOBZ93r8ior/oqqMq3ss5EKaBVv9r8sbfY82FoX6QNQYjiVdasvDvFeyL
         91nYySC4PrJbA+aiFLc37yNIgxduk5MV3tcm8gDlavVetKzHYhe3ewskYLIFigVcsDCx
         dsjNqab8vT8oKIS+6S2nOiKQS5UuiNdkkF/GCgrUSBWcs5CFIY/En9rYucvZ01lLq1z1
         WVD25NwdemT/T0XecDmArD6BXcvf8I+J4VO515U3TaljFjOwqnMT1AJw2KpoTqD7BtE/
         ZfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933221; x=1781538021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PQSUUr369qP40HbNZE8YmdPdco/pgXnDVzZ0VoLIYI=;
        b=P6vsZeJqLiHoURDaM1Y5mECruzwMxs6x5wm2vPy9TzdQDSPEKTtLTPkF2gMk2TaVbd
         +P/24VLzDB1t7s3ZRhrIHybY8UCoW2b5s6RBFn8+oADNOJ8kNx9qefRxZmcI6HEgdu1e
         WTvyqRtlUz8MzHlUSJJlCJ8JCbYmpra32D0jNBZ3lbFW2+vHW47Zp1axTAcfJZ1D1mAk
         CvjSmnU4ksAaAtOKL5sbOibsxGqku0ISt1OPdk9NH1OIXCk+nrGbhPFyIG+6/WAplefG
         4r0PKZVdIq9gvTSriDA5al7pFQwXH3wYoqPZyX3HgPS/6dQX0MUZUyhEIGNJ4TumYkqM
         ECLA==
X-Gm-Message-State: AOJu0Yw+1b+k50WXyKcbk6+5Fkq4/3A5qJxS3kBuosef1YGdi5L302Dx
	++LCtPjgYBR2KWetbrESH+BUegPmU9yWVKnx0UNnigyOHV3BxT9MLragV6VTGQYz
X-Gm-Gg: Acq92OHvyZBpVSj3OdmDh72A4eiQ9tmzGhsvqRkVNfhG76NKfIni46ep855137EUTZF
	bTT42wxe/jmH/Df9cw8i6P6sGF2GgL0vXP1B3YRx/A81TqOYAg8To7qWKe1DH+wKMjKe6WgokYQ
	V3EkvCKTPaimDZdfP7KDxr/EjQntztnGA3QDsbPGTiZ0BPQTMFpgQaFjepGBAeQ4+tT9jBYgRbi
	ximcYmmOVH6nFfrYOhPc3k8EddctKJSzm0oI8jvM9x2wgwntfBxo4lXYfxPKJjHWZWRFfqGpYa1
	yL5OObSF43LgFbte3eafvkAqNNz+zebZQms1Tj2HS5IfoN5xGIEFGAUyLTQj7wb4DsjCDQWZ2jp
	cpElyxmY6KhSc5rr9VPQsKVICAtC1aCKIyBvGe8GzsBdEM1OgbcAjpr7zDy4QuZODYztVefF27g
	82H/c8gFt3i/qJRKuPX8SmTHdhlU0=
X-Received: by 2002:a05:6a00:1819:b0:842:3841:fdba with SMTP id d2e1a72fcca58-842b0eadd19mr16900179b3a.6.1780933220692;
        Mon, 08 Jun 2026 08:40:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828fe634sm18504027b3a.52.2026.06.08.08.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:40:20 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v3 3/3] bnxt: convert to core rx_mode retry mechanism
Date: Mon,  8 Jun 2026 08:40:14 -0700
Message-ID: <20260608154014.227538-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608154014.227538-1-sdf@fomichev.me>
References: <20260608154014.227538-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296649-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64F4065877A

Remove the driver-specific BNXT_STATE_L2_FILTER_RETRY + timer + sp_task
retry mechanism and rely on the core stack's ndo_set_rx_mode_async retry
instead.

bnxt_cfg_rx_mode() now returns errors instead of swallowing them. The
PF-unavailable case (-ENODEV from HWRM on a VF) is normalized to
-EAGAIN at the boundary so callers can match on a single "retry me"
errno without re-implementing the VF/-ENODEV check. Other errors
propagate unchanged.

This removes:
- BNXT_STATE_L2_FILTER_RETRY state bit
- BNXT_RX_MASK_SP_EVENT sp_event bit
- Retry trigger from bnxt_timer()
- BNXT_RX_MASK_SP_EVENT handling from bnxt_sp_task()

bnxt_init_chip() still calls bnxt_cfg_rx_mode() directly during open.
On a fresh open dev->uc is empty and the call effectively cannot fail
on the unicast path. But on FW reset reopen (bnxt_fw_reset_task ->
bnxt_open) a VF may have a populated dev->uc and the PF may be
transiently unavailable; since that path doesn't go through
__dev_open(), the follow-up rx_mode call that would otherwise drive
the core retry doesn't fire. On -EAGAIN, swallow the error and call
netif_rx_mode_schedule_retry() explicitly. The unicast filter loop
truncates vnic->uc_filter_count on failure, so the retry's delta check
sees pending work and reinstalls.

Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 30 ++++++++---------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 --
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f3c76ffaa1ca..1eb214e4b511 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11232,8 +11232,12 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 	}
 
 	rc = bnxt_cfg_rx_mode(bp, &bp->dev->uc, true);
-	if (rc)
+	if (rc == -EAGAIN) {
+		netif_rx_mode_schedule_retry(bp->dev);
+		rc = 0;
+	} else if (rc) {
 		goto err_out;
+	}
 
 skip_rx_mask:
 	rc = bnxt_hwrm_set_coal(bp);
@@ -13716,7 +13720,7 @@ static int bnxt_set_rx_mode(struct net_device *dev,
 	if (mask != vnic->rx_mask || uc_update || mc_update) {
 		vnic->rx_mask = mask;
 
-		bnxt_cfg_rx_mode(bp, uc, uc_update);
+		return bnxt_cfg_rx_mode(bp, uc, uc_update);
 	}
 
 	return 0;
@@ -13758,11 +13762,10 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
 		rc = bnxt_hwrm_set_vnic_filter(bp, 0, i, vnic->uc_list + off);
 		if (rc) {
 			if (BNXT_VF(bp) && rc == -ENODEV) {
-				if (!test_and_set_bit(BNXT_STATE_L2_FILTER_RETRY, &bp->state))
-					netdev_warn(bp->dev, "Cannot configure L2 filters while PF is unavailable, will retry\n");
-				else
-					netdev_dbg(bp->dev, "PF still unavailable while configuring L2 filters.\n");
-				rc = 0;
+				netdev_warn(bp->dev, "Cannot configure L2 filters while PF is unavailable, will retry\n");
+				rc = -EAGAIN;
+			} else if (rc == -EAGAIN) {
+				netdev_warn(bp->dev, "FW busy while setting vnic filter, will retry\n");
 			} else {
 				netdev_err(bp->dev, "HWRM vnic filter failure rc: %x\n", rc);
 			}
@@ -13770,8 +13773,6 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
 			return rc;
 		}
 	}
-	if (test_and_clear_bit(BNXT_STATE_L2_FILTER_RETRY, &bp->state))
-		netdev_notice(bp->dev, "Retry of L2 filter configuration successful.\n");
 
 skip_uc:
 	if ((vnic->rx_mask & CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS) &&
@@ -14362,9 +14363,6 @@ static void bnxt_timer(struct timer_list *t)
 		}
 	}
 
-	if (test_bit(BNXT_STATE_L2_FILTER_RETRY, &bp->state))
-		bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
-
 	if ((BNXT_CHIP_P5(bp)) && !bp->chip_rev && netif_carrier_ok(dev))
 		bnxt_queue_sp_work(bp, BNXT_RING_COAL_NOW_SP_EVENT);
 
@@ -14727,7 +14725,6 @@ static void bnxt_ulp_restart(struct bnxt *bp)
 static void bnxt_sp_task(struct work_struct *work)
 {
 	struct bnxt *bp = container_of(work, struct bnxt, sp_task);
-	struct net_device *dev = bp->dev;
 
 	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 	smp_mb__after_atomic();
@@ -14805,13 +14802,6 @@ static void bnxt_sp_task(struct work_struct *work)
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
index 1920a161841e..29ff5a584d16 100644
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


