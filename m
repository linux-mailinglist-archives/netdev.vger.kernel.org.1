Return-Path: <netdev+bounces-276050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDe8Klwk1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:35:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F073B11D4
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF71C305FC14
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CE23C13E5;
	Tue,  7 Apr 2026 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwdCSROP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B43BBA1F
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575888; cv=none; b=T551Q7FvABjOSbhoVlfrma6dVFSrmiyOv03s9kVU0fuiNLKKolYvMDN0Rf+MltfcwnIURzNilx0ymT1jZ1X1go6E4PoGCuW3RiSQorIa9laKnlPGtoJitde6zMSPomxWDRGtk8cDW3JDzghpQCcjGNBuViZDp4yrw6308aQXGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575888; c=relaxed/simple;
	bh=gm46CLN6s+dvk56gaJftAEi7JatZbiOFrpYV+hGLhq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD6sbsonUTYt7D69Wui2eutRHzV5eI8ezOfs/P8iEjRseoCrkLSXDK1NrDelMK6H0m9L54RJ9y8M2+wHxde4fKulwKIIVmFCcprjhT5ycAPnkDq97spM+bMLKXAszRNyegszHsdNQV5vJMvAGutsh1CKkYYtmI5ULWkfI8L+89k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwdCSROP; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so5063269a34.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575874; x=1776180674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBTvwwi7ny9+Qg5exTZaF6o4d0Tmwujc8jFOQlF1l08=;
        b=UwdCSROPm4cOP71DAp/gl+4gZNk1fxtX+pS0vFBgIQAb+HuQdaV9YzzaJ+nbKPOwCt
         wnO3DlT7nTeNIbfsRexDU633/OePrHdjmmIfhEC4wn1gy+1QrThXycBVjZvkY4Mqwo8o
         Bdvts0tO6Tqrd8Ygl+vZMLZF52hMnz9YV/Pvp9YiaYa2eHi0jVKikvoQ3aKizfwfeX7l
         6bLwG+kPeHoUsY4KDMb/z56K81EdlcRZsIcz7Du30hwVlHZe8iZxa83eVAIL/m6FOCRu
         NCdXywJYycNvtrS6DTVhpAEqUIUQDMZ1oT/OuNqLVbksEN0dz7wM5pT2MHngFAKSk7YC
         vamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575874; x=1776180674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tBTvwwi7ny9+Qg5exTZaF6o4d0Tmwujc8jFOQlF1l08=;
        b=W/EEOyWseC1bVDMTQhUgc20uRs+ulUNFPlZkU9joIXs+tUqazbvABBb2CurxtdVu9p
         kZGE1IGknrS47Fj2MUi9WTohDPepLDGXw2bWzZEIUg5fpcHn5712YXqpETs1xH3samR6
         rbXaYp3J1NZaQGj1lbjTzcVECX1xfkIValnsZec+P2leJxkB01f3DhGCsger7Eavq75x
         sLVZrX1d3xwlByrUBob9p9y/xLKNc2dB6Ybx6HmDhaHF73M7cH7wFJbZP2bE/FNtrsUJ
         TzADGgpH6q4kIHS3XC0uOAFJ+LAgRYP4gcoRtUgXfFaSnOmjUUv2AfgH9ZRHQFQkycO2
         W06w==
X-Gm-Message-State: AOJu0YzgbjbNm2S3ikKNmYSPuXfashrHH9Z1RCrV6YEWclfbXJuYDGk7
	s8zS0/jrwMJyNVhG4aH7YIr9TgYdBbWzGk+SGJ7EdFsuDjUqjMX01IAztR4rrF91sRM=
X-Gm-Gg: AeBDietpnE034D1bOtFUdgqKe3IDnMP7ZVcC+P9oeHFPaFaNz0bjCwdl4iePgiMXEqU
	9j4EBNq1ar1xP6dstB7BlnYWT+XP9EpMf1iM6fXYVujDmthMRes4dPIUdIblU7GKzp0mMqF4rsH
	XHb6BAQZwnDcnHk2BpYwGxCvjkaUTirc/2eJmIbPZ8XSESSrcYwJ1Um8sRANudWl2HiD6Oso5gG
	w647Th15vfoTBHq8PIKGbwqhfcgf3Cj/gdw0VYPe+BWe/+iXDTBTNWHYFtjW8gAdKenfeLzMF+S
	pHn1zarPiKAHAbCrHLR6bzgj9zc/6QTVhp9ReHvE5ZA/srFHkNIUA0t17t+Kw3co3z5PcVD4+lR
	Gz1ym9VeEONqo8deyaXp9PQ5Ixk547i11OxMymM1NFNVeNd/0m4YBSyFnXBJHhwaAr/fC+FkK1p
	lQO1q6xtkhPmHAFyhqkg==
X-Received: by 2002:a05:6830:3881:b0:7d7:570b:6800 with SMTP id 46e09a7af769-7dbb7157f12mr11294601a34.23.1775575872598;
        Tue, 07 Apr 2026 08:31:12 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbed6c3512sm2894424a34.4.2026.04.07.08.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:31:11 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v6 08/14] bnxt: use snapshot in bnxt_cfg_rx_mode
Date: Tue,  7 Apr 2026 08:30:55 -0700
Message-ID: <20260407153101.3694714-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407153101.3694714-1-sdf@fomichev.me>
References: <20260407153101.3694714-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-276050-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[fomichev.me:server fail,broadcom.com:server fail,sea.lore.kernel.org:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 06F073B11D4
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
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 29 ++++++++++++-----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 569c7de7c5e4..46a37ce6bebf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11034,7 +11034,7 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
 	return rc;
 }
 
-static int bnxt_cfg_rx_mode(struct bnxt *);
+static int bnxt_cfg_rx_mode(struct bnxt *, struct netdev_hw_addr_list *, bool);
 static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
 				 const struct netdev_hw_addr_list *);
 
@@ -11130,7 +11130,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		vnic->rx_mask |= mask;
 	}
 
-	rc = bnxt_cfg_rx_mode(bp);
+	rc = bnxt_cfg_rx_mode(bp, &bp->dev->uc, true);
 	if (rc)
 		goto err_out;
 
@@ -13614,21 +13614,17 @@ static void bnxt_set_rx_mode(struct net_device *dev,
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
@@ -13643,10 +13639,10 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
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
@@ -14604,6 +14600,7 @@ static void bnxt_ulp_restart(struct bnxt *bp)
 static void bnxt_sp_task(struct work_struct *work)
 {
 	struct bnxt *bp = container_of(work, struct bnxt, sp_task);
+	struct net_device *dev = bp->dev;
 
 	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 	smp_mb__after_atomic();
@@ -14617,9 +14614,6 @@ static void bnxt_sp_task(struct work_struct *work)
 		bnxt_reenable_sriov(bp);
 	}
 
-	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event))
-		bnxt_cfg_rx_mode(bp);
-
 	if (test_and_clear_bit(BNXT_RX_NTP_FLTR_SP_EVENT, &bp->sp_event))
 		bnxt_cfg_ntp_filters(bp);
 	if (test_and_clear_bit(BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT, &bp->sp_event))
@@ -14684,6 +14678,13 @@ static void bnxt_sp_task(struct work_struct *work)
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


