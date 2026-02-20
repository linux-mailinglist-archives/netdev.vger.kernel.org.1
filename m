Return-Path: <netdev+bounces-259715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF4oFBJimGkVHgMAu9opvQ
	(envelope-from <netdev+bounces-259715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:30:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C10DD167D2F
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E1C93009B15
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B8345758;
	Fri, 20 Feb 2026 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE0R/bhm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE252C0F72
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594222; cv=none; b=kLs95PYjX+YMIGkovCC2DCMkSqFQmijOzcKPJQbFOkkotcdcntJxD58GVcGTs7hsvrtTmtbPtlmG9NKg3dTMXxWcDlduaCMN+YrILCNsdGnquiKzYShkIPoGhBl+KZm3vnQ5GX2f5mqlJHtqdiOBDwm7JzzM1tuFqFAFqlbRWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594222; c=relaxed/simple;
	bh=nPqQOyiFzTlXiYNAb5exQIcg4IDOla/WqgYdhuL7PK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9fO3Ga88JXMdEXy/aYoSVbJ1aTVZPEMy9KM6EL6b/hip7sjTZ+lfB3GgRB/N5R3hL2NywllKsyev+DaxCrqvmiQGS9I1RK4nIk+HfF6VxIZMWx7iJEvT9e1PMEb+4tb8j2lIbIcoc6zpZFZ67E8HPEmcd7vyRZfMLv3Lp89Vys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE0R/bhm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48371bb515eso27077425e9.1
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 05:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771594219; x=1772199019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RVgLjQbi44HVML4e8mSGGXGhwfni+MNe1KovCjgG0z4=;
        b=HE0R/bhm9NJ8dpvm8e4gRmfMC3VpV94+XOzy5TnKNFt/6xc7cZmFfEUzplP+0vOFb8
         EJXDMmRqxjZIu5yG+7/NVigvvwp3LX8Coq0LumZG4xirR9jcA47cQmKqa6LvZQsquGxI
         GwTUZWmNQ/9QSNt831//fC4IBbll1QizpaqOo3UmxFhG0R6JGEOgQd7AR0CJtDmGW/at
         wtfHfteEnd/86iCBwiq+f+fwMGr6egLbmLkhHHiwyjeJsUKseU2pigWenhDNNKZzi20J
         iw53oxHd7n2yU3N7vKOOi6X3buqrBlzRS38h3bMLTOWMB2ZSi0cyNoGWpA/n3W0TmOFU
         V7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771594219; x=1772199019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVgLjQbi44HVML4e8mSGGXGhwfni+MNe1KovCjgG0z4=;
        b=UmE1iQusLbVnCu69wxOfQCEMxDxWtqwQlF28xckpORxY/UGIfVEt9Sb+RU1ccPpEsY
         8jCXOJFwYLzkei5CFsZLeagKqHEj1MrJeXORRHsTS4bAgh3+8cJNHIs0+cRoWTw7OFAS
         XEOH645DaTuxwokB4uQQEG4oORqJaUdsObo+ASSNhsbfDM8qkpW6C71n3Jq+A/zyv0tM
         wwUuvdWO5YPsx4EVKAYIa6h5E1Qwfw3EtvrxU3isZkTGraYyocvYJ47NEmhZUEmZ7bmm
         bKAO/8+DgDPMm0pRvGk+suqAhQiVazZdiLZG8o+fn/akncDouAvIeleRlz4EoQ1JyZe6
         SImA==
X-Forwarded-Encrypted: i=1; AJvYcCVsqQuy0gLNA82RB2nDRDr5uF3LEsjPEjBmxBd4I4984tC+0f1U6aw92VO+ZIyT6ivlFevKYBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJOuq2U9NVIflOeeqe21fHYuJUz0dAgQjGzKTQ78IGNlnLtc1W
	l2clTS3Hmn8/FzyNzMrespAOtLioMXf4XuTzI79pe+tLmuSGuRopZ/5EVt32+Q==
X-Gm-Gg: AZuq6aJ9UDbv6QUQboPO4FrSC2kWSr08YmDbsOYpStQOHUYk20S2UOU2Du7ClUxlFXk
	0rqL2L1Zrl0UAKyyDPPDxTPzChL3dCSCscgcGc4qEIvtne8uw0yduI0yRsIQaHg9McQWRIwaWwF
	tWuZyNhwLOnuJgqgIxLvx4sKgUH0tryQS/x5y1OGTNlWCwMBzECprddqD8xA00m1MQDjI+anEy3
	qVEGYQK8Qg9kWYtPXGjiuG4d720s/8aVaWzXozuQnuoHxqrypdZayP92t9Ciwa59yRRp1TDdtyF
	7DOg8S2hSa5yvBMlaYZqOt61AAWoB+IxAVM9U0sJNu6Ld5dLYZSjJSRGvypMJjPD+V09tATiG+s
	nsJA+DHDIKz+yFtjdzNwkr/Upcc4lamwKrSBzap2pRnXcB2BDPBxFeXckkBr5mXLhWmdh3w9Eml
	HCregx1Sf1j8NxZzo3ClgAcYoHS/rIJn2/f7XJuzi/a+jPZa7c159y9RwCf56crAZ2CPQH46B8f
	3p3dgFSSEBjDg==
X-Received: by 2002:a05:600c:a09:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-48398a67950mr164652925e9.7.1771594218770;
        Fri, 20 Feb 2026 05:30:18 -0800 (PST)
Received: from zefir-PC.neratec.com (80-218-237-147.dclient.hispeed.ch. [80.218.237.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31ff4d7sm74307935e9.15.2026.02.20.05.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 05:30:18 -0800 (PST)
From: Zefir Kurtisi <zefir.kurtisi@gmail.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>
Subject: [PATCH] net: enetc: fix sirq-storm by clearing IDR registers
Date: Fri, 20 Feb 2026 14:29:30 +0100
Message-ID: <20260220132930.2521155-1-zefir.kurtisi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259715-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zefirkurtisi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,westermo.com:email]
X-Rspamd-Queue-Id: C10DD167D2F
X-Rspamd-Action: no action

From: Zefir Kurtisi <zefir.kurtisi@westermo.com>

The fsl_enetc driver experiences soft-IRQ storms on LS1028A systems
where up to 500k interrupts/sec are generated, completely saturating
one CPU core. When running with a single core, this causes watchdog
timeouts and system reboots.

Root cause:
The driver was writing to SITXIDR/SIRXIDR (Station Interface summary
registers) to acknowledge interrupts, but these are W1C registers that
only provide a summary view. According to the LS1028A Reference Manual
(Rev. 0, Chapter 16.3):

- TBaIDR/RBaIDR (per-ring, offset 0xa4): RO, "Reading will
  automatically clear all events"
- SITXIDR/SIRXIDR (summary, offset 0xa18/0xa28): W1C, "provides a
  non-destructive read access"

The actual interrupt sources are the per-ring TBaIDR/RBaIDR registers.
The summary registers merely reflect their combined state. Writing to
SITXIDR/SIRXIDR does not clear the underlying per-ring sources, causing
the hardware to immediately re-assert the interrupt.

Fix:
1. Point ring->idr to per-ring TBaIDR/RBaIDR instead of summary
   registers
2. Remove per-packet writes to SITXIDR/SIRXIDR from packet processing
3. Read TBaIDR/RBaIDR once per NAPI poll (in enetc_poll) before
   re-enabling interrupts

This properly acknowledges interrupts at the hardware level and
eliminates the interrupt storm. The optimization of clearing once per
NAPI poll rather than per packet also reduces register access overhead.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Tested-on: LS1028A (NXP Layerscape), Linux 6.6.93
Signed-off-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 18 +++++++++---------
 drivers/net/ethernet/freescale/enetc/enetc.h |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e380a4f39855..8442e87b9b86 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1291,9 +1291,6 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 		/* BD iteration loop end */
 		if (is_eof) {
 			tx_frm_cnt++;
-			/* re-arm interrupt source */
-			enetc_wr_reg_hot(tx_ring->idr, BIT(tx_ring->index) |
-					 BIT(16 + tx_ring->index));
 		}
 
 		if (unlikely(!bds_to_clean))
@@ -1620,7 +1617,6 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 		if (!bd_status)
 			break;
 
-		enetc_wr_reg_hot(rx_ring->idr, BIT(rx_ring->index));
 		dma_rmb(); /* for reading other rxbd fields */
 
 		if (enetc_check_bd_errors_and_consume(rx_ring, bd_status,
@@ -1977,7 +1973,6 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 		if (!bd_status)
 			break;
 
-		enetc_wr_reg_hot(rx_ring->idr, BIT(rx_ring->index));
 		dma_rmb(); /* for reading other rxbd fields */
 
 		if (enetc_check_bd_errors_and_consume(rx_ring, bd_status,
@@ -2143,12 +2138,16 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	v->rx_napi_work = false;
 
 	enetc_lock_mdio();
-	/* enable interrupts */
+	/* Read RBaIDR to acknowledge interrupt (RO, read-to-clear) */
+	enetc_rd_reg_hot(rx_ring->idr);
 	enetc_wr_reg_hot(v->rbier, ENETC_RBIER_RXTIE);
 
-	for_each_set_bit(i, &v->tx_rings_map, ENETC_MAX_NUM_TXQS)
+	for_each_set_bit(i, &v->tx_rings_map, ENETC_MAX_NUM_TXQS) {
+		/* Read TBaIDR to acknowledge interrupt (RO, read-to-clear) */
+		enetc_rd_reg_hot(v->tbidr_base + ENETC_BDR_OFF(i));
 		enetc_wr_reg_hot(v->tbier_base + ENETC_BDR_OFF(i),
 				 ENETC_TBIER_TXTIE);
+	}
 
 	enetc_unlock_mdio();
 
@@ -2608,7 +2607,7 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 
 	tx_ring->tpir = hw->reg + ENETC_BDR(TX, idx, ENETC_TBPIR);
 	tx_ring->tcir = hw->reg + ENETC_BDR(TX, idx, ENETC_TBCIR);
-	tx_ring->idr = hw->reg + ENETC_SITXIDR;
+	tx_ring->idr = hw->reg + ENETC_BDR(TX, idx, ENETC_TBIDR);
 }
 
 static void enetc_setup_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring,
@@ -2650,7 +2649,7 @@ static void enetc_setup_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring,
 		rbmr |= ENETC_RBMR_VTE;
 
 	rx_ring->rcir = hw->reg + ENETC_BDR(RX, idx, ENETC_RBCIR);
-	rx_ring->idr = hw->reg + ENETC_SIRXIDR;
+	rx_ring->idr = hw->reg + ENETC_BDR(RX, idx, ENETC_RBIDR);
 
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
@@ -2793,6 +2792,7 @@ static int enetc_setup_irqs(struct enetc_ndev_priv *priv)
 		}
 
 		v->tbier_base = hw->reg + ENETC_BDR(TX, 0, ENETC_TBIER);
+		v->tbidr_base = hw->reg + ENETC_BDR(TX, 0, ENETC_TBIDR);
 		v->rbier = hw->reg + ENETC_BDR(RX, i, ENETC_RBIER);
 		v->ricr1 = hw->reg + ENETC_BDR(RX, i, ENETC_RBICR1);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index aecd40aeef9c..2b4b052e43c8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -374,6 +374,7 @@ static inline bool enetc_is_pseudo_mac(struct enetc_si *si)
 struct enetc_int_vector {
 	void __iomem *rbier;
 	void __iomem *tbier_base;
+	void __iomem *tbidr_base;
 	void __iomem *ricr1;
 	unsigned long tx_rings_map;
 	int count_tx_rings;
-- 
2.43.0


