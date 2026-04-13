Return-Path: <netdev+bounces-278146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPtuKGMp3WmVaQkAu9opvQ
	(envelope-from <netdev+bounces-278146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:35:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E0A3F18D8
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3BCC30B3007
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FDF34AB00;
	Mon, 13 Apr 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti1Cu83e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4991A348875
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100303; cv=none; b=hhmPgt6xwLpB1CobxeYfpgRImtlC+xKrcomFjbxSQulAMa5AlIf8VLFsdq2mhBX2ANBnZwkGEv82zGVY09ctyqxNXqlTELOmGloLphENYTtPxKfqqflAR3m9z3GErLtuOMuqaayZ5sTT23qNay1JfWr1c5C3lVUj9Q/XJE3SfBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100303; c=relaxed/simple;
	bh=EEDXHZiHb2Tnx69qzCOJu+fuAX9dsbQBci8llxnGNk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMzs2YgUE06DATmAEuwHsLV0fsfMi0B1DxumfZ2gBFVNw/NFsGVVtfYD42fRHly0gc6jGrULlPAzuAZaKSEIdalGotU7rN/h+FSb6M5us86z0ZW4GpuFL2kjKt8w7Xl3Qoa7kaK/uVf1uUkSa8efdYlC/HqFeCslUHoRg28k3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti1Cu83e; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-47018d341f8so2957156b6e.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100301; x=1776705101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+psz3tHhP8xlWckTG70XGtzIV2en6+j0YXkooi4mGgY=;
        b=Ti1Cu83eEHqC2K6PYFbp1J12Pe4GtJ0yp6pun+4hc72+Dz05FBjW3uX7qLOI0FT/yz
         l9JWWdEDHjpA7f2XQgfxyR9ESyJjWq5LiFGVMYSxJ4CYBLdNsqVdhVNjVMjNbWtB8b38
         MNWFzgHZkN98Rlr1p2jlXZdf8cmh7irs0W/BYBxH7U8xd8xOPyj96umTEQsqJBUeNR1n
         Rs7ts2Zqzl8Xrk0qpPn3GOEU9lsKMDrrC7XrVOXwCHsOGYuhTAFfGAm8o1iWCrB9Cpd2
         FIuy1op3Qh5SlN9w2ixOBJK2tIHbLA0JzqMdH84VOHPDyUfQic114yxk2m5LWYgnEQue
         cZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100301; x=1776705101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+psz3tHhP8xlWckTG70XGtzIV2en6+j0YXkooi4mGgY=;
        b=At/lbKfFv1Ix5j7MMMyfIF+ccMYfXZbDnO55JJT38+N9C4KNxkLt3d/qJiTWohE1x9
         e9DJaOmyh7gGmMp4RVF1HZ9vy5GPZhmwyOqz4oECtl+umTXLdwP1XXTCO8ScBET5cKEt
         weK9l1kfB34CNb6Xnw3oVIEoNQyKgsYMoT/DEjoeUvD1mjvPY/QoEwTn1X1hwh5+G5hT
         qwHPed4hrTTEzJgy6yaJEM32kIf5b3SA9OFqLmuVDjM9DwsGTtaa5BlMMV487Cslk/ao
         R5sD0HIWS7B1KjqVADzMZZdethYlHOhrTSNDKSV0jxgcobGftAGTDzu8xoemIFV15RNg
         NJ1w==
X-Gm-Message-State: AOJu0Ywx8Dk+v0MBRMAp7OiQ/bIcrxP1r9K+e9yZYuLUeK9uexaeA6Iw
	N2Bf/HE71XKIbGeA67anEOvwp93f3pOS2kI5e526yiWBbqiwQGWlEe7ijAD+3ax6
X-Gm-Gg: AeBDievuj9jQHfYpBAznCO/P5HauHjrF8e2OLzEWfUd3LA5cmWUBwogN2Jp6USAt9J7
	/WytZ7NNZmYXKYD5g8wDxMnnRKmPYlEFng/0M1PNx/ADMSeTaP42lmD+bdkEy9vaHw9OaR4UJ49
	pYsxVnMet9Rlnkebcumoi8ffa9/YazUPExfHDwTfpvN6CsFfgd6mSUQslCNdow+FiNbrlG1iKvZ
	qk08DbKL1Xs4f4S3g5Tx/ugsJlFxCxRvwtO7nQNb8PO2X0/gWXp+zvpcD4kTny3jwN1mA2XMPMo
	ZCnZeCWsU7VyrFLWCpLYJkMNP+kVCd0+jz3kJ08QqOexJVXLUTbdBvzog0+wrnvBEkenQ1TLhuE
	+vzGCkiEZ/GGTARaJLfrq2qyjw0Xr9jSxWYCzTli1M+jp660nDEomdM6hyM2ZXY+VMMcMBPWcxR
	eOH+n1ewjhTcakrPofg1tyHiOPBBU=
X-Received: by 2002:a05:6808:6a83:b0:46a:d8b7:1101 with SMTP id 5614622812f47-478a0307b3emr8101742b6e.41.1776100301027;
        Mon, 13 Apr 2026 10:11:41 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddcf0376sm9349018fac.18.2026.04.13.10.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:40 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v7 08/15] bnxt: use snapshot in bnxt_cfg_rx_mode
Date: Mon, 13 Apr 2026 10:11:24 -0700
Message-ID: <20260413171131.550126-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171131.550126-1-sdf@fomichev.me>
References: <20260413171131.550126-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-278146-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 06E0A3F18D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With the introduction of ndo_set_rx_mode_async (as discussed in [1])
we can call bnxt_cfg_rx_mode directly. Convert bnxt_cfg_rx_mode to
use uc/mc snapshots and move its call in bnxt_sp_task to the
section that resets BNXT_STATE_IN_SP_TASK. Switch to direct call in
bnxt_set_rx_mode.

Link: https://lore.kernel.org/netdev/CACKFLi=5vj8hPqEUKDd8RTw3au5G+zRgQEqjF+6NZnyoNm90KA@mail.gmail.com/ [1]

Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 29 ++++++++++++-----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 61d4a9911413..79e286621a28 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11131,7 +11131,7 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
 	return rc;
 }
 
-static int bnxt_cfg_rx_mode(struct bnxt *);
+static int bnxt_cfg_rx_mode(struct bnxt *, struct netdev_hw_addr_list *, bool);
 static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
 				 const struct netdev_hw_addr_list *);
 
@@ -11227,7 +11227,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		vnic->rx_mask |= mask;
 	}
 
-	rc = bnxt_cfg_rx_mode(bp);
+	rc = bnxt_cfg_rx_mode(bp, &bp->dev->uc, true);
 	if (rc)
 		goto err_out;
 
@@ -13711,21 +13711,17 @@ static void bnxt_set_rx_mode(struct net_device *dev,
 	if (mask != vnic->rx_mask || uc_update || mc_update) {
 		vnic->rx_mask = mask;
 
-		bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
+		bnxt_cfg_rx_mode(bp, uc, uc_update);
 	}
 }
 
-static int bnxt_cfg_rx_mode(struct bnxt *bp)
+static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
+			    bool uc_update)
 {
 	struct net_device *dev = bp->dev;
 	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	struct netdev_hw_addr *ha;
 	int i, off = 0, rc;
-	bool uc_update;
-
-	netif_addr_lock_bh(dev);
-	uc_update = bnxt_uc_list_updated(bp, &dev->uc);
-	netif_addr_unlock_bh(dev);
 
 	if (!uc_update)
 		goto skip_uc;
@@ -13740,10 +13736,10 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
 	vnic->uc_filter_count = 1;
 
 	netif_addr_lock_bh(dev);
-	if (netdev_uc_count(dev) > (BNXT_MAX_UC_ADDRS - 1)) {
+	if (netdev_hw_addr_list_count(uc) > (BNXT_MAX_UC_ADDRS - 1)) {
 		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 	} else {
-		netdev_for_each_uc_addr(ha, dev) {
+		netdev_hw_addr_list_for_each(ha, uc) {
 			memcpy(vnic->uc_list + off, ha->addr, ETH_ALEN);
 			off += ETH_ALEN;
 			vnic->uc_filter_count++;
@@ -14709,6 +14705,7 @@ static void bnxt_ulp_restart(struct bnxt *bp)
 static void bnxt_sp_task(struct work_struct *work)
 {
 	struct bnxt *bp = container_of(work, struct bnxt, sp_task);
+	struct net_device *dev = bp->dev;
 
 	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 	smp_mb__after_atomic();
@@ -14722,9 +14719,6 @@ static void bnxt_sp_task(struct work_struct *work)
 		bnxt_reenable_sriov(bp);
 	}
 
-	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event))
-		bnxt_cfg_rx_mode(bp);
-
 	if (test_and_clear_bit(BNXT_RX_NTP_FLTR_SP_EVENT, &bp->sp_event))
 		bnxt_cfg_ntp_filters(bp);
 	if (test_and_clear_bit(BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT, &bp->sp_event))
@@ -14789,6 +14783,13 @@ static void bnxt_sp_task(struct work_struct *work)
 	/* These functions below will clear BNXT_STATE_IN_SP_TASK.  They
 	 * must be the last functions to be called before exiting.
 	 */
+	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event)) {
+		bnxt_lock_sp(bp);
+		if (test_bit(BNXT_STATE_OPEN, &bp->state))
+			bnxt_cfg_rx_mode(bp, &dev->uc, true);
+		bnxt_unlock_sp(bp);
+	}
+
 	if (test_and_clear_bit(BNXT_RESET_TASK_SP_EVENT, &bp->sp_event))
 		bnxt_reset(bp, false);
 
-- 
2.52.0


