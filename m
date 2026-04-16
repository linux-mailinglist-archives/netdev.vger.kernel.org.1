Return-Path: <netdev+bounces-279122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKFVAXkx4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:59:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 538DB413EDB
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D72A530E3B8C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E87934AB17;
	Thu, 16 Apr 2026 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC5f1L9U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E876349B0D
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365844; cv=none; b=gTd+JYlMKi6fZqozJ7DAJStLl5BtAeFnib+fCK9UpIm7zQXz0EW9nP2TA504ECfOapJTbocMRqBGvWUK2q02TpHdlBfTH8F9ij+c8aLQBgFeH5E/rFJ41mJHJVw5wvrZacv6CWg3ebulqVFIFwaXkQ6stkJyPxrxEeJF7y6xPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365844; c=relaxed/simple;
	bh=EEDXHZiHb2Tnx69qzCOJu+fuAX9dsbQBci8llxnGNk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ir8lBh7iXV0mM6rnGb1P74V9OnqU6sqjVsp5WqqcPlhywKzSqCUrMtjsFnKzd8NiWikkeIR5wVKqeISsjsaQZWP4n5sN2dkAWTAZfJlcFAXmQUaC+x+a4PSLPUH9bUzuHYW3yb0rjOn6Vh/mkk3IFO/7F0lJjul3yiPZOK3pG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC5f1L9U; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-47938ef848cso2527845b6e.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365842; x=1776970642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+psz3tHhP8xlWckTG70XGtzIV2en6+j0YXkooi4mGgY=;
        b=EC5f1L9UW5JrV6FalbEXURmHozv9TubgnnAm5RSYyoB7K7KrZBgZJSw7/e13Wmdnx+
         a76KkZXxOmactaRNjpfxPRPLWZMkwZiScwweI4IM8tN2YnjcQl5pdEQI/OisMUDjdqfi
         kmfp7rN9ZeRWjlaxSOq/I/Wd+YsJfRDPVG84taivZK7pt0FiZvPYM/Lbp+FZyamavbbc
         aslbT1iWEzw+RoLRQlHvWbQZTA76ycv0zrTYxvJM4TDlSr/L+5OSUsmWZebyGMPqDhNy
         gFFPd3NXmm4YeS03PniUb7NvRlhNNcJ6yGpYJHe3j+wHYQQhTmfZC9sTbM3rTzWGSExc
         Dzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365842; x=1776970642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+psz3tHhP8xlWckTG70XGtzIV2en6+j0YXkooi4mGgY=;
        b=sAjCXvxNm9USZtb3BYOmeoNxp6zbIGguGlBY38RJHbuMfDN1HRDv2XUEWp8oT2abrE
         DmFsekqLpPLzAXyO8ERh2UJD+IScGxkIdjI04FZ7Yqvm7cWZcY6PbR6podQsidreGB7T
         B0gwbE0Cr+2Et2EIyWZH4YIoeB1Xe6VZPl4S6pmGGvtpNy7nLXRJfyJBKn9nVLwtkr7L
         FrbZRytGlbtNcEfhU/5EZeTy9wTjTrtnAmOx8E1jBmzTy5iW1kYC227Ca77JwkEM2dIX
         KSVomKNjz+AB0EqyBjCAGSUPyaJV9fhb+EYwX8WCKiYyd4VpWbiMa0OGD5nz5x7vCdtO
         4tIg==
X-Gm-Message-State: AOJu0Yxszt4Ac+7KNBWwyC0wWJTOX7+/vvGkJJUK/5vcwvPoMNDOX8Av
	P0XPH2/BPOCjXjCn+yW9K0HuypAyGBrQxzH+kWKKlhXU0iIjWCOTvZcHJggR/Ks6
X-Gm-Gg: AeBDievXrwbMvknhY75GvNhbMnTS/tcQu78EiUOveVQdF5GSKde8rc9gAu1nyDDfK4k
	HRTCHWAFHCNVPPDkWWo6CAk9IUlJTMZXQ7k0Jax/BDns+ME7x6weDGQruitxsfC3Lo9SJNM0uBQ
	FD6/WuF7t5QgdOfD/MQUj1HrvQlIWyFLoByAZHRs75QJBkXo0ozJYqyFClYIM3ndRjK2DVJRjsJ
	4eQiKhE/7AciX9wk09/oNZFJnnAs9e9Swp8s5sJYVmxbmHL32hworvWdCH03/C9kQfciulDqWEF
	4TlLCFXp4fx1AYPO5xJ0iL7DurXxrrWsdD7d83bLeFzHO38zPhoDaKnxH2OfaeVIFj1uZ1rrA0E
	UG2hCSNPY/zfLgTQwfJkpaBqxTADNokOdfXW6cn3E7IDSkwL8yFN82O4NMHSiQlfLTK1n5zWxOl
	UIM3fE9W4lESK+tReOOZaWRjmGT5Ny/5xfSn4+Uvo=
X-Received: by 2002:a05:6808:319a:b0:472:9c39:49c9 with SMTP id 5614622812f47-4799a26e5b1mr84562b6e.26.1776365841995;
        Thu, 16 Apr 2026 11:57:21 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:40::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47997dcef2dsm498295b6e.7.2026.04.16.11.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:57:21 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net v8 08/15] bnxt: use snapshot in bnxt_cfg_rx_mode
Date: Thu, 16 Apr 2026 11:57:05 -0700
Message-ID: <20260416185712.2155425-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416185712.2155425-1-sdf@fomichev.me>
References: <20260416185712.2155425-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279122-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:mid,fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 538DB413EDB
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


