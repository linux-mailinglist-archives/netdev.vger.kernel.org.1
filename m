Return-Path: <netdev+bounces-306423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HZj/Hj50UGoyzQIAu9opvQ
	(envelope-from <netdev+bounces-306423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCD0737201
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=emZa1GSy;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306423-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306423-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A139F302BA68
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7708D36CE1E;
	Fri, 10 Jul 2026 04:24:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0736CDE2
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:24:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657492; cv=none; b=djlNl0KP/7gg/iZuunwiHmZRE3M8JqnMD/QdWmtn9kgt0X9Q5zFWNUHVERjuwpR8xRlPHedQx8W2LVFXYtNL55oXI9mThDhOTWmd95AmXC729xKnp26tIdGzb7gMJV4BsQ7Px5K3wqoH0T4gcQVAHPfbX7fYcRkzMxpUf1jhxdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657492; c=relaxed/simple;
	bh=wV+Xwa228iGxrnR00GjJCAtekg+7yit11tNnckWQ+tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqbaZKKBKleLqIA9aX1ZNfAaax4Q1Z+ihCn4nR5dj2/s5vOO3e5mDCyYwNQDxjX3ASot7dGw/CzWPJYOnhEZ321dRLjjz7jviJhmejgj1ZJbp6YxfTDlmYihxQL+9Fjci3hIOb2EJDuVTKM/h/XrV48KZ5Nv1LhPvREP9tiVpyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=emZa1GSy; arc=none smtp.client-ip=209.85.215.227
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so487766a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657490; x=1784262290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=axRU/9+scQVzTl8cFLvnW5ZpuSGpaN6Z8GJqgmEW3cI=;
        b=OMOS7jml0lLUFrVSn+wg27K+46OvmZPArqyS9th+VZt7trJWPhjlXEyqnSpJA4IeeN
         Psie3h+HWiLSM9PZHn4QxyU5IIgVhW4qgjVzuuAq5hy3NP8II79PwmNAfWuBsrKCAFz0
         hcIeXgmPT0o0hz6WlFCYlGSZDWfwnN/dwBKA4lWM52MD1mFIuuoIlpr2YmxTrO7WZFP+
         z+0jMEnkJ/BAY2iu9BvQtVNAtkmNyF2u35MHreNOJZJ3CLmTnZV4p2rf7+u43MP8TTho
         xMNYTGRb/ReYFrK+ICZmY/Aj8e/57oMIgO8q0nbvmyUOr8OuWXseX1MPeizasRESPHQc
         ONOw==
X-Gm-Message-State: AOJu0YywRXv8hvjnur/blDrlWzcJArDuBgL5Bf0Iaj8zm19tUJ9FEdV4
	3/BXJ0rE9yWRx3T1xseoZffT9BfPXygKka7/gAm+uUahIpWY/PBWzw6SjueqkWWjeSZLzLFr9mt
	lw2l2H7hWHP8b4/JVEqcn8Cp7TqE1b73qkoLyIZV9oYxB1FYD70uGnUsLTLtGYFaGQCRoXu3GQ3
	RUG6BadjcNazW9O4pvCZLKVjIGwXAQ4F9tTCQ95rckl3HWTdl8P3PhceEkX4G3BmkOGTKIqC2ew
	LJ5jTmEFwc=
X-Gm-Gg: AfdE7cn/+d1xOMtrOxM3f2wkxUuCFW+dQCnsd+CSpY5wuA4wV5y3EUVZXBEc0cVO6US
	3S1pZj+3ocg9yk7niTFvt3cHCfBgnzvDyBRl+RcgkarY3m+0zeUOUBGETYG5lU+uGAauacu/0R+
	DrS9ipgdvvKa2q5v3VBvgYQmTa1ewKbidJnZi1Ei7pydFyRq6qL9qr8h0kV7EL7gNsLdGl+iYt3
	IIvNTI+RrNF/9LZz2KtNeUfGczv+9YtMzoAO6pGuK8tNqWL5zHw9WXUJXISqwggMRTCXZdl7zua
	28J6KtOrqzGUbiwk7pI7EHg9RVgUqgHteRxYX0PxzoIlA7l5h4FMLvDvQ0bF/qTNJmUmtkVnUbo
	DynZRu3CrTxftuFfLkqAVrxl0iiQTmB+j082uJkxdhXXXpZ8cPNUbjY5NZOd3+OJWnAHLUJZU6t
	P6KeW08olN8P8GaX2gxhSi/UpfvNk6wszN36NfIbollYbzUA==
X-Received: by 2002:a05:6a20:144f:b0:3bf:97e8:a044 with SMTP id adf61e73a8af0-3c0bcf162c4mr12755474637.13.1783657489826;
        Thu, 09 Jul 2026 21:24:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-31174a5883esm591425eec.24.2026.07.09.21.24.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:24:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dad28e86eso16763a91.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657487; x=1784262287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=axRU/9+scQVzTl8cFLvnW5ZpuSGpaN6Z8GJqgmEW3cI=;
        b=emZa1GSya7RLinDt5MLdSiznmlI2pUhsq0FtsxNIEOrnfAs9BkwVOEoN2QsJ/I3Moz
         sVreG3vDrr+tE8p66H/mQBIdOrsRM++JOZPit/SENY4fzEpaeocaSMuCuWg8aXo35r1J
         OJwC08YHpuMjjZfMy2Oy7E8V5GLKo4VQXKTp0=
X-Received: by 2002:a17:90b:3fc8:b0:384:a641:3fe with SMTP id 98e67ed59e1d1-38941cc4cffmr9470420a91.21.1783657487079;
        Thu, 09 Jul 2026 21:24:47 -0700 (PDT)
X-Received: by 2002:a17:90b:3fc8:b0:384:a641:3fe with SMTP id 98e67ed59e1d1-38941cc4cffmr9470402a91.21.1783657486653;
        Thu, 09 Jul 2026 21:24:46 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:24:46 -0700 (PDT)
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
Subject: [PATCH net-next v5 02/15] bnxt_en: Account for the MPC TX and CP rings
Date: Thu,  9 Jul 2026 21:23:47 -0700
Message-ID: <20260710042400.3996847-3-michael.chan@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-306423-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCCD0737201

Modify bnxt_cp_rings_in_use(), bnxt_get_max_func_cp_rings_for_en(),
and _bnxt_get_max_rings() to account for any TX rings and CP rings
used by MPCs.  Add a new helper bnxt_total_tx_rings() to include
MPC TX rings.  Ring reservations will now include the MPC rings.

Note that for bnxt_check_rings() that is called before we commit
the new rings requested by the user running ethtool -L, the next
patch will calculate the proposed MPC rings to be checked.

Note that only the newer FW APIs and the newer P5-plus chips
support MPC rings.  The MPC values will always be zero in the
non-P5 plus code paths.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v5:
Clarify in the commit log that kTLS, MPC rings are only supported on
P5_PLUS chips in response to some Sashiko comments.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 65 +++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 21 ++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 12 ++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  4 +-
 7 files changed, 90 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8faab85d66d1..519437d61298 100644
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
@@ -11515,14 +11534,15 @@ unsigned int bnxt_get_max_func_cp_rings(struct bnxt *bp)
 	return bp->hw_resc.max_cp_rings;
 }
 
-static unsigned int bnxt_get_max_func_cp_rings_for_en(struct bnxt *bp)
+static unsigned int bnxt_get_max_func_cp_rings_for_en(struct bnxt *bp,
+						      unsigned int mpc_cp)
 {
 	unsigned int cp = bp->hw_resc.max_cp_rings;
 
 	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		cp -= bnxt_get_ulp_msix_num(bp);
 
-	return cp;
+	return mpc_cp >= cp ? 0 : cp - mpc_cp;
 }
 
 static unsigned int bnxt_get_max_func_irqs(struct bnxt *bp)
@@ -11544,7 +11564,7 @@ unsigned int bnxt_get_avail_cp_rings_for_en(struct bnxt *bp)
 {
 	unsigned int cp;
 
-	cp = bnxt_get_max_func_cp_rings_for_en(bp);
+	cp = bnxt_get_max_func_cp_rings_for_en(bp, bnxt_mpc_cp_rings_in_use(bp));
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return cp - bp->rx_nr_rings - bp->tx_nr_rings;
 	else
@@ -14884,11 +14904,11 @@ static void bnxt_sp_task(struct work_struct *work)
 }
 
 static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
-				int *max_cp);
+				int *max_cp, int mpc_tx, int mpc_cp);
 
 /* Under netdev instance lock */
 int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
-		     int tx_xdp)
+		     int tx_xdp, int mpc_tx, int mpc_cp)
 {
 	int max_rx, max_tx, max_cp, tx_sets = 1, tx_cp;
 	struct bnxt_hw_rings hwr = {0};
@@ -14898,7 +14918,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 	if (tcs)
 		tx_sets = tcs;
 
-	_bnxt_get_max_rings(bp, &max_rx, &max_tx, &max_cp);
+	_bnxt_get_max_rings(bp, &max_rx, &max_tx, &max_cp, mpc_tx, mpc_cp);
 
 	if (max_rx < rx_rings)
 		return -ENOMEM;
@@ -14924,8 +14944,10 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		hwr.grp = rx;
 		hwr.rss_ctx = bnxt_get_total_rss_ctxs(bp, &hwr);
 	}
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-		hwr.cp_p5 = hwr.tx + rx;
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+		hwr.cp_p5 = hwr.tx + rx + mpc_cp;
+		hwr.tx += mpc_tx;
+	}
 	rc = bnxt_hwrm_check_rings(bp, &hwr);
 	if (!rc && pci_msix_can_alloc_dyn(bp->pdev)) {
 		if (!bnxt_ulp_registered(bp->edev[BNXT_AUXDEV_RDMA])) {
@@ -15646,7 +15668,9 @@ int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
 		sh = true;
 
 	rc = bnxt_check_rings(bp, bp->tx_nr_rings_per_tc, bp->rx_nr_rings,
-			      sh, tc, bp->tx_nr_rings_xdp);
+			      sh, tc, bp->tx_nr_rings_xdp,
+			      bnxt_mpc_tx_rings_in_use(bp),
+			      bnxt_mpc_cp_rings_in_use(bp));
 	if (rc)
 		return rc;
 
@@ -16618,14 +16642,14 @@ static int bnxt_get_max_irq(struct pci_dev *pdev)
 }
 
 static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
-				int *max_cp)
+				int *max_cp, int mpc_tx, int mpc_cp)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 	int max_ring_grps = 0, max_irq;
 
-	*max_tx = hw_resc->max_tx_rings;
+	*max_tx = max(0, (int)hw_resc->max_tx_rings - mpc_tx);
 	*max_rx = hw_resc->max_rx_rings;
-	*max_cp = bnxt_get_max_func_cp_rings_for_en(bp);
+	*max_cp = bnxt_get_max_func_cp_rings_for_en(bp, mpc_cp);
 	max_irq = min_t(int, bnxt_get_max_func_irqs(bp) -
 			bnxt_get_ulp_msix_num_in_use(bp),
 			hw_resc->max_stat_ctxs -
@@ -16657,7 +16681,8 @@ int bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx, bool shared)
 {
 	int rx, tx, cp;
 
-	_bnxt_get_max_rings(bp, &rx, &tx, &cp);
+	_bnxt_get_max_rings(bp, &rx, &tx, &cp, bnxt_mpc_tx_rings_in_use(bp),
+			    bnxt_mpc_cp_rings_in_use(bp));
 	*max_rx = rx;
 	*max_tx = tx;
 	if (!rx || !tx || !cp)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 77b1748d12d1..fec88d40a606 100644
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
@@ -3040,7 +3041,7 @@ int bnxt_dbg_hwrm_rd_reg(struct bnxt *bp, u32 reg_off, u16 num_words,
 void bnxt_fw_exception(struct bnxt *bp);
 void bnxt_fw_reset(struct bnxt *bp);
 int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
-		     int tx_xdp);
+		     int tx_xdp, int mpc_tx, int mpc_cp);
 int bnxt_fw_init_one(struct bnxt *bp);
 bool bnxt_hwrm_reset_permitted(struct bnxt *bp);
 void bnxt_set_cp_rings(struct bnxt *bp, bool sh);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 62bc9cae613c..88d879a27820 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -37,6 +37,7 @@
 #include "bnxt_nvm_defs.h"	/* NVRAM content constant and structure defs */
 #include "bnxt_fw_hdr.h"	/* Firmware hdr constant and structure defs */
 #include "bnxt_coredump.h"
+#include "bnxt_mpc.h"
 
 #define BNXT_NVM_ERR_MSG(dev, extack, msg)			\
 	do {							\
@@ -959,6 +960,7 @@ static int bnxt_set_channels(struct net_device *dev,
 	struct bnxt *bp = netdev_priv(dev);
 	int req_tx_rings, req_rx_rings, tcs;
 	u32 new_tbl_size = 0, old_tbl_size;
+	int mpc_per_type = 0, mpc_cp = 0;
 	bool sh = false;
 	int tx_xdp = 0;
 	int rc = 0;
@@ -993,7 +995,8 @@ static int bnxt_set_channels(struct net_device *dev,
 		tx_xdp = req_rx_rings;
 	}
 
-	rc = bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, tx_xdp);
+	rc = bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, tx_xdp,
+			      mpc_per_type * BNXT_MPC_TYPE_MAX, mpc_cp);
 	if (rc) {
 		netdev_warn(dev, "Unable to allocate the requested rings\n");
 		return rc;
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
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 9e5009be8e98..b485e4d9b26f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -19,6 +19,7 @@
 #include <net/page_pool/helpers.h>
 #include <linux/bnxt/hsi.h>
 #include "bnxt.h"
+#include "bnxt_mpc.h"
 #include "bnxt_xdp.h"
 
 DEFINE_STATIC_KEY_FALSE(bnxt_xdp_locking_key);
@@ -410,7 +411,8 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	if (!tc)
 		tc = 1;
 	rc = bnxt_check_rings(bp, bp->tx_nr_rings_per_tc, bp->rx_nr_rings,
-			      true, tc, tx_xdp);
+			      true, tc, tx_xdp, bnxt_mpc_tx_rings_in_use(bp),
+			      bnxt_mpc_cp_rings_in_use(bp));
 	if (rc) {
 		netdev_warn(dev, "Unable to reserve enough TX rings to support XDP.\n");
 		return rc;
-- 
2.51.0


