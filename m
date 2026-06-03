Return-Path: <netdev+bounces-294956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wHQZKw2tIGpW6gAAu9opvQ
	(envelope-from <netdev+bounces-294956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:39:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB063BA02
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:39:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QtpUrRSR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294956-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294956-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 096EE305908E
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4B64A3418;
	Wed,  3 Jun 2026 22:35:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2174D8DB9
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:35:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526144; cv=none; b=EpgZoOB5irlY3pKGTvxxfZDO8GltoZZU82qxfuI7dg1opOlYmJ3RZQC1jqa0b813kisKLs77Z6gm9IXEiqi0u81KaOomB0wFkwPMzEdEPhMvpjIvb9jHn8Te8oFIPi7LP4gbs0pP1EI0iiUFO+xUaRCIhjkOuG1ZI7SZjNEGx3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526144; c=relaxed/simple;
	bh=Fpkq+FwrxtI9780Ajxb1JYPH36QrMlXtnq3wSNqlfao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHMESp2Z5SnVoICjbWJRVOFicTebtyN6X6Wr8j/5eApB13aomNowTTXXDPkUDhdb0mOK093Enn28vlks7rnG/AJ//RCKmuonDKYOAv+RyALAPJlgeMgNA3tE6LOl7wi0JwZNCQz+YmWcef+7NWT2aGLlqmM/H5tR+WSBefbD5Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtpUrRSR; arc=none smtp.client-ip=209.85.210.193
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-8419ab3a297so17112b3a.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780526139; x=1781130939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzVdF2RlffrS2ZqSBbYd2gU95Ed8YGO6Pjo4hD5xUKs=;
        b=QtpUrRSReSDunH5l1MjLJWK8xSnKq/g6HGrCxuIjQEklBDZfFxEvFirO4haxwFsYQh
         fHEtcsS/IY5qwYrWgCVwAVj6Rga09gv1XjbGGngZOEvuiZgW935C0HPKDvRqvuyRlrgU
         l4UVhDjFyP/l44YLKfyUCZoFM1M957+UiEAodkKrqzwRVSEggCO3fdHKtJqp12MC7QhW
         LJvg6/ffTmN2wZIPPGF3sINGKbt8ZKInCvPNAPZhteR0Nc0Cp9FKX/OcwqKUzzjqDTz0
         d604+52zhdFmg0+s8wAfoMbFVXXcT2/6fsUoT+rV3w+KSoGdopBuyCDYda8Ise/iTKB/
         EJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780526139; x=1781130939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CzVdF2RlffrS2ZqSBbYd2gU95Ed8YGO6Pjo4hD5xUKs=;
        b=mGsEWDEv3fqOO32GFJo+RsgnPu2MKaQvGhI0kb8NnhRZPYcV7inr6z+o5GYpu1OGrM
         dJaltp5w7s+YPN/ntwvrY1KuqIW2CD/KlJTY6EdsZAnMNZICmy89tiCUEthNdM3DuyIK
         kll+mK/9Y18ct/HwAYtipjbG7SqbBglMAJviGN99UfkB4c3dUTeVHL4cD/jBeX9PCICN
         BClJNhK+twgtLarNhQ6QJl+aBlojvUQUgAvlwSVc88xdxlC8ZA47hMTX8OiAZy+JxITO
         i9/6w3NRmByWqxYN/qA7ar5/eUbNOklJtdFYV0UAME75KC4senu970t1HyaX2lQo1es2
         47Ww==
X-Gm-Message-State: AOJu0YwYnrnGa7SKLjLpGEi+ygpmswLi4wDmPhn6Bn/g4iXLP5d5DmXc
	02cXhCZJhPvDR1w5JKMrisKBX/vooGTDQumdFUNgmvpE1uN60BvgSzYOL0YavPdl
X-Gm-Gg: Acq92OH/q74uELFpzcTncSUL43A/u5mc3NPT1pr/oReSXULgE323V3B2UVICgiwvxB7
	zViaJv8v7nDkMo/xZfV+X4dWxVwwTPHgctW12mAMv9FUsLr7T2Tz+ggzYgBkLoMXq0PqNQGz9+S
	iksZZUBPmSNpHWM10th2jZK94CNLfFHgATjhCx5nt678aHaF6i9vPAIdt6cWBU8YQsA7+l0tHdD
	8kpZvEDVom0hIHqi/GrI9umos3fn7QQqLb9eBMxcDbS+LaBybfzZvd7hXtOE/UTx81k7XWqDx62
	dXHoW9WV2T5V+GY/RJE7UfaK7Z7ULNIiKFC5Eeu/JjYw4xI3WF8ZlQmAy6RWxbKrB78fvbOea4H
	WY63gxIcRhjQwV3PHggSqx95zeqEHdZ0MD3ZIN1Wmf5NUBbFiRMS2oBiNUHvAR8Y9i8IQvND8wY
	agKaaTt2vlUvyBtY68X7TayZhj2nI=
X-Received: by 2002:a05:6a00:ab8f:b0:842:6004:3fb9 with SMTP id d2e1a72fcca58-84284e932f5mr5348403b3a.25.1780526139409;
        Wed, 03 Jun 2026 15:35:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221c3e4sm4165334b3a.5.2026.06.03.15.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 15:35:39 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v2 3/3] bnxt: convert to core rx_mode retry mechanism
Date: Wed,  3 Jun 2026 15:35:35 -0700
Message-ID: <20260603223535.2504695-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603223535.2504695-1-sdf@fomichev.me>
References: <20260603223535.2504695-1-sdf@fomichev.me>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294956-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:mid,fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DDB063BA02

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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 +++++++----------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 --
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8459a21cf0a9..c3e6ae7186fd 100644
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
@@ -13758,11 +13762,8 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
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
 			} else {
 				netdev_err(bp->dev, "HWRM vnic filter failure rc: %x\n", rc);
 			}
@@ -13770,8 +13771,6 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
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


