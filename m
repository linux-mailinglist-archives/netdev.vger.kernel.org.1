Return-Path: <netdev+bounces-302795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zHjKKni+QmrAAQoAu9opvQ
	(envelope-from <netdev+bounces-302795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:50:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 298306DE23D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:50:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=NcT6iNj2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302795-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302795-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFFA43045CB2
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D53DEAD3;
	Mon, 29 Jun 2026 18:50:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95A63C0A05
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:50:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759008; cv=none; b=bJqVpyOFgRwfqj3OkbLqDZ51No+AfOBBSS/cjEkRjqgtcbnT2eA/hDpiuffk1Rbry8iTGlnCDn46EBbWBxRKrYj9yXx+9UaYIjcUaxNqutiIdNvAjcAy73AcHYVHcz4IV+PGbkV9fwF5QWeEpKYEEyCOuQdveST73Jue+cQy8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759008; c=relaxed/simple;
	bh=EyuTZZYcAxCMBT9r13X/6H908N/pIZ7G+85Tz+GLjs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpepFytiV/j9Gp4H9O5hL/xcusWjGVAKT4Oduh8yt+hG77VUnbdE6tO1fU57bqS5vYirA39UUl9PtZbkoBEgx4IUhLF7H/CDjFcv/YLqtjZB9bLRY13+zJAwbqb/CHoOSFrQq4TStXfLxHbSP8ev+f0VHQFqSqcK4gY2+jYVrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NcT6iNj2; arc=none smtp.client-ip=74.125.82.99
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-139b914bab6so4996488c88.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759006; x=1783363806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opAf/UA8n9XFItoH++qU6HmIp4pQc09aYsMtLtMdtLc=;
        b=pbbr88ytmsmVDwBnF4G+7BtKk5059B9zYOuzdx2AVIZr1JQLeAx3zGl1P483BnMSVr
         GRTQFlOTg+98o+9/FZm6eetWvo8wiadvwU/9cdoKxQRFJvHr2HSRcTTuClBUeiYmL5J9
         Y1oRHSEYi4CEpgOfViSCfTSb5BJgI5sKMuCwGLUk+0JcNGcxNWyy+xPkayt4rAH4Ko4O
         BtlGhI32CLlNpGL96XUdlD8ZYvUPq2oOzzOvHR/NvKzheTh3ltqnLSJwO+iIWec0QiG7
         +b+2Sncm4Y4xxmgHGE2PU2OsHDg+BbcX934acYFKcufufjSNt8pEdwc30DwUXwzEd78v
         pdxQ==
X-Gm-Message-State: AOJu0Ywc1rBgv/fPJ0Oo5m4Q9/WxHHzJ7yg1riVCkcGNDDgPAqw0go9c
	e8vawOb7qvC3ANG//Z3p4LFY3bSzseIQ/7pxMG0z7e2y65T2hsYE9MSm9AdJCe7xwAZoT2S4ui7
	SaZQwI/gJRZ6raPJ3b8QFO0krN37fMwW9IIQwr0ItTXIQYdwRsRwMBhwZ1VuuyZLb0/f5E4O372
	F5El8SCHyEUHea43NrZwOk8vrNW6taqE2GiuBcBC/U933ek1kalTSD9f3n+3IR3nlCp8PJNBCKD
	iZY3jXxnt4=
X-Gm-Gg: AfdE7cnuO/iqeY7TyKYDqXJfL5AmA0wNIpfTSMrG+bvqWFZKRWtW7xXXSaZ0ohmQ1Cr
	RzClTeW0DcIJ2ekR8Sk0Udlft4+dY4263yEyLK/LtDwWuceHacHssspfTBfd82VTWG1KOyuNeke
	ZAbsqJejTZH0gBWDoPCKt599uB6iDBIOys8FfdN++sqtoc4n4uCTJX+0Fan1y/KchQNnSDB51rr
	pG2e0zeyf28Asgz7/mg4143BcIOsFO7WyD2Fz8CLnbFoTQck4V8TbQjVfYrlzisg2Weh1di0/oT
	+IbF087maBe+TccXAyXDP8YvfDVYrfHjqf8jEVSHcK1ByQT4gnHc/Ob/I0UoclIhvzSPxOIXshY
	f6I5i/ldlugFn8PIxgONcpJa3iiVHQNgdI6Gs4Cyc1AvaHLT9OwaooaxPG/AcFZZK0/cMnKss8y
	a4S2kVaBXKwLMpOd/7eg0kd9K2alPtSuhwd/O2vJe1aVB09muI
X-Received: by 2002:a05:7022:688e:b0:128:cf80:deea with SMTP id a92af1059eb24-13b2a13f5ebmr396087c88.1.1782759005796;
        Mon, 29 Jun 2026 11:50:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-13b2ab9445csm1720c88.6.2026.06.29.11.50.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:50:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517e054fe07so103396291cf.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782759004; x=1783363804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opAf/UA8n9XFItoH++qU6HmIp4pQc09aYsMtLtMdtLc=;
        b=NcT6iNj2gv0kdETBEvd0IxHCNrSZlxDsgYAMMPNyjUBEpsTeRofsWcd3QSi5Gt9HH7
         CLxrQzlvn6BwFqpk0DIAy0L5ttl+8H8db+cdXk/iin51A/Uaph2ja2EkmnmKa8bBYK5a
         TPRPvTIi0eQDihxREdZq74cXhpSZccvV6G9TU=
X-Received: by 2002:a05:622a:2c6:b0:51c:1ff:2512 with SMTP id d75a77b69052e-51c10814235mr6731691cf.33.1782759004240;
        Mon, 29 Jun 2026 11:50:04 -0700 (PDT)
X-Received: by 2002:a05:622a:2c6:b0:51c:1ff:2512 with SMTP id d75a77b69052e-51c10814235mr6731161cf.33.1782759003497;
        Mon, 29 Jun 2026 11:50:03 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c109ffbb3sm2176341cf.23.2026.06.29.11.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:50:02 -0700 (PDT)
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
Subject: [PATCH net-next v4 02/15] bnxt_en: Account for the MPC TX and CP rings
Date: Mon, 29 Jun 2026 11:49:08 -0700
Message-ID: <20260629184921.3496727-3-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302795-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 298306DE23D

Modify bnxt_cp_rings_in_use(), bnxt_get_max_func_cp_rings_for_en(),
and _bnxt_get_max_rings() to account for any TX rings and CP rings
used by MPCs.  Add a new helper bnxt_total_tx_rings() to include
MPC TX rings.  Ring reservations will now include the MPC rings.

Note that legacy FW using older HWRM APIs does not support MPC
rings.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 45 ++++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 21 +++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 12 +++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  6 +--
 5 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8faab85d66d1..2a737e7d7921 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7752,6 +7752,11 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 	}
 }
 
+int bnxt_total_tx_rings(struct bnxt *bp)
+{
+	return bp->tx_nr_rings + bnxt_mpc_tx_rings_in_use(bp);
+}
+
 static int __bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 			     bool shared);
 static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
@@ -7792,19 +7797,28 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
 		stats = le16_to_cpu(resp->alloc_stat_ctx);
 		hw_resc->resv_irqs = cp;
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+			int mpc_tx = bnxt_mpc_tx_rings_in_use(bp);
+			int mpc_cp = bnxt_mpc_cp_rings_in_use(bp);
 			int rx = hw_resc->resv_rx_rings;
 			int tx = hw_resc->resv_tx_rings;
+			int cp_p5;
 
+			if (tx <= mpc_tx || cp <= mpc_cp) {
+				rc = -ENOMEM;
+				goto get_rings_exit;
+			}
+			tx -= mpc_tx;
+			cp_p5 = cp - mpc_cp;
 			if (bp->flags & BNXT_FLAG_AGG_RINGS)
 				rx >>= 1;
-			if (cp < (rx + tx)) {
-				rc = __bnxt_trim_rings(bp, &rx, &tx, cp, false);
+			if (cp_p5 < (rx + tx)) {
+				rc = __bnxt_trim_rings(bp, &rx, &tx, cp_p5, false);
 				if (rc)
 					goto get_rings_exit;
 				if (bp->flags & BNXT_FLAG_AGG_RINGS)
 					rx <<= 1;
 				hw_resc->resv_rx_rings = rx;
-				hw_resc->resv_tx_rings = tx;
+				hw_resc->resv_tx_rings = tx + mpc_tx;
 			}
 			hw_resc->resv_irqs = le16_to_cpu(resp->alloc_msix);
 			hw_resc->resv_hw_ring_grps = rx;
@@ -7996,7 +8010,7 @@ static int bnxt_cp_rings_in_use(struct bnxt *bp)
 		return bnxt_nq_rings_in_use(bp);
 
 	cp = bp->tx_nr_rings + bp->rx_nr_rings;
-	return cp;
+	return cp + bnxt_mpc_cp_rings_in_use(bp);
 }
 
 static int bnxt_get_func_stat_ctxs(struct bnxt *bp)
@@ -8054,7 +8068,7 @@ static void bnxt_get_total_resources(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	hwr->cp_p5 = 0;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		hwr->cp_p5 = bnxt_cp_rings_in_use(bp);
-	hwr->tx = bp->tx_nr_rings;
+	hwr->tx = bnxt_total_tx_rings(bp);
 	hwr->rx = bp->rx_nr_rings;
 	hwr->grp = hwr->rx;
 	hwr->vnic = bnxt_get_total_vnics(bp, hwr->rx);
@@ -8160,8 +8174,10 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	hwr.rx = bp->rx_nr_rings;
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
 		sh = true;
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-		hwr.cp_p5 = hwr.rx + hwr.tx;
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+		hwr.cp_p5 = hwr.rx + hwr.tx + bnxt_mpc_cp_rings_in_use(bp);
+		hwr.tx += bnxt_mpc_tx_rings_in_use(bp);
+	}
 
 	hwr.vnic = bnxt_get_total_vnics(bp, hwr.rx);
 
@@ -8198,6 +8214,9 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	if (bnxt_ulp_registered(edev) && hwr.stat > bnxt_get_ulp_stat_ctxs(bp))
 		hwr.stat -= bnxt_get_ulp_stat_ctxs(bp);
 	hwr.cp = min_t(int, hwr.cp, hwr.stat);
+	hwr.tx -= bnxt_mpc_tx_rings_in_use(bp);
+	if (hwr.tx < 0)
+		return -ENOMEM;
 	rc = bnxt_trim_rings(bp, &rx_rings, &hwr.tx, hwr.cp, sh);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		hwr.rx = rx_rings << 1;
@@ -11517,12 +11536,13 @@ unsigned int bnxt_get_max_func_cp_rings(struct bnxt *bp)
 
 static unsigned int bnxt_get_max_func_cp_rings_for_en(struct bnxt *bp)
 {
+	unsigned int mpc_cp = (unsigned int)bnxt_mpc_cp_rings_in_use(bp);
 	unsigned int cp = bp->hw_resc.max_cp_rings;
 
 	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		cp -= bnxt_get_ulp_msix_num(bp);
 
-	return cp;
+	return mpc_cp >= cp ? 0 : cp - mpc_cp;
 }
 
 static unsigned int bnxt_get_max_func_irqs(struct bnxt *bp)
@@ -14924,8 +14944,10 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		hwr.grp = rx;
 		hwr.rss_ctx = bnxt_get_total_rss_ctxs(bp, &hwr);
 	}
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-		hwr.cp_p5 = hwr.tx + rx;
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+		hwr.cp_p5 = hwr.tx + rx + bnxt_mpc_cp_rings_in_use(bp);
+		hwr.tx += bnxt_mpc_tx_rings_in_use(bp);
+	}
 	rc = bnxt_hwrm_check_rings(bp, &hwr);
 	if (!rc && pci_msix_can_alloc_dyn(bp->pdev)) {
 		if (!bnxt_ulp_registered(bp->edev[BNXT_AUXDEV_RDMA])) {
@@ -16623,7 +16645,8 @@ static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 	int max_ring_grps = 0, max_irq;
 
-	*max_tx = hw_resc->max_tx_rings;
+	*max_tx = max(0, (int)hw_resc->max_tx_rings -
+			 bnxt_mpc_tx_rings_in_use(bp));
 	*max_rx = hw_resc->max_rx_rings;
 	*max_cp = bnxt_get_max_func_cp_rings_for_en(bp);
 	max_irq = min_t(int, bnxt_get_max_func_irqs(bp) -
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 77b1748d12d1..ea32b8bd6600 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2992,6 +2992,7 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 			 unsigned int start_rx_ring_idx,
 			 unsigned int nr_rings);
+int bnxt_total_tx_rings(struct bnxt *bp);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
 int bnxt_hwrm_set_coal(struct bnxt *);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 86087e538550..9859a5f86268 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -24,3 +24,24 @@ void bnxt_free_mpc_info(struct bnxt *bp)
 	kfree(bp->mpc_info);
 	bp->mpc_info = NULL;
 }
+
+int bnxt_mpc_tx_rings_in_use(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, mpc_tx = 0;
+
+	if (!mpc)
+		return 0;
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++)
+		mpc_tx += mpc->mpc_ring_count[i];
+	return mpc_tx;
+}
+
+int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+
+	if (!mpc)
+		return 0;
+	return mpc->mpc_cp_rings;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index cd3f268a3a29..7a7d81197ea6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -35,6 +35,8 @@ struct bnxt_mpc_info {
 #ifdef CONFIG_BNXT_TLS
 void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
 void bnxt_free_mpc_info(struct bnxt *bp);
+int bnxt_mpc_tx_rings_in_use(struct bnxt *bp);
+int bnxt_mpc_cp_rings_in_use(struct bnxt *bp);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -43,5 +45,15 @@ static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 static inline void bnxt_free_mpc_info(struct bnxt *bp)
 {
 }
+
+static inline int bnxt_mpc_tx_rings_in_use(struct bnxt *bp)
+{
+	return 0;
+}
+
+static inline int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
+{
+	return 0;
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index edcc002e4ca3..d57059722f5b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -640,7 +640,7 @@ static int bnxt_hwrm_func_vf_resc_cfg(struct bnxt *bp, int num_vfs, bool reset)
 		vf_rx_rings = hw_resc->max_rx_rings - bp->rx_nr_rings * 2;
 	else
 		vf_rx_rings = hw_resc->max_rx_rings - bp->rx_nr_rings;
-	vf_tx_rings = hw_resc->max_tx_rings - bp->tx_nr_rings;
+	vf_tx_rings = hw_resc->max_tx_rings - bnxt_total_tx_rings(bp);
 	vf_vnics = hw_resc->max_vnics - bp->nr_vnics;
 	vf_rss = hw_resc->max_rsscos_ctxs - bp->rsscos_nr_ctxs;
 
@@ -903,8 +903,8 @@ static int bnxt_sriov_enable(struct bnxt *bp, int *num_vfs)
 		    avail_cp < min_rx_rings)
 			rx_ok = 0;
 
-		if (hw_resc->max_tx_rings - bp->tx_nr_rings >= min_tx_rings &&
-		    avail_cp >= min_tx_rings)
+		if (hw_resc->max_tx_rings - bnxt_total_tx_rings(bp) >=
+		    min_tx_rings && avail_cp >= min_tx_rings)
 			tx_ok = 1;
 
 		if (hw_resc->max_rsscos_ctxs - bp->rsscos_nr_ctxs >=
-- 
2.51.0


