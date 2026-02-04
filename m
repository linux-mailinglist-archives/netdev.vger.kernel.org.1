Return-Path: <netdev+bounces-256560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BgXOabPgmk8cAMAu9opvQ
	(envelope-from <netdev+bounces-256560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 05:48:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51905E19A6
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 05:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A27A300D446
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 04:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D2C34DB56;
	Wed,  4 Feb 2026 04:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG8DyhSj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7DF215055
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 04:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770180515; cv=none; b=Hg2k2bE9ny9CsByQIEr6pOIp3HCe7XA+EsTNqA99pL4HMsIlI7vlnwGgTlLB+m4YHHZCbXSVuVPoAxlKeUI1hbVsXB7JdaRh9rqMYUA/BqwXgXcEggMqnmfJKXCnbFmPlQ4yqwdrq+FfNZ8y4mu6Db5L/GAw9WxzRTMcRgdVYvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770180515; c=relaxed/simple;
	bh=d2PrAAugKOvjohQLQ0kRYqr9Ix9J5GuNTH3BD6g+OBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jYJvjrfT3K0KHqG8Lgu6hcdOBDu059rmSMtObK+3nkJzMAkNwkuN+qQg57PmiTid1RaSVDQLHBvc7EUFf3coFibhiDUAATXOJw0IJDdAF8tmhNtBski4EiqwZZLWqnTOtinCznyVU8RRVmzL9pWPAj4Juv+jmyHlgaKS+dvHxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG8DyhSj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a79998d35aso2895265ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 20:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770180515; x=1770785315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z2IM4Z35Vn6qnneQ2FOXC3Xxl6YzIbYQR2DMfu8vCY=;
        b=bG8DyhSj1tIOOS8OsDdOWV7GXRQZkOgG/E5+av/7ml9i4gYMuzqGpmqs++dYyAay3D
         hf6ed9deokW2Xn3J2LFamIzXyhpqwXmDFAuLpTK4x/mjZ2NtPs0lsxB6jN98A2mMu17D
         q+lYPn2tYB0PKOYSyGJ60KPvKtRbiezAH1L+fJ8coKEWqa7T0jDbpYEE/FwPNscxcfrm
         USLkcylyTthQpoKTvcjK+EgshE//+Ty/bYOjCZk/AYXRjytqZq6hw21A1PHuTz5ERdaB
         BGbrQyU3OYXSLCl7NG5fy4pkD0vKnpqdYC0dj2Di/mkeDpRyVe9Wo3tmZ/1awnGWb6lP
         DZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770180515; x=1770785315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z2IM4Z35Vn6qnneQ2FOXC3Xxl6YzIbYQR2DMfu8vCY=;
        b=chCjd6dF4Gju4wQedf7LC1+7fm2+G60f1cm9hR9XHBGoSAF1ebVve+0CxhrMrAdtb7
         dKCjnRaHz5Rarpcguf7NDF/axegmC2rzonId9KdjGUJAh6eu1u3BVjGU712Pb0muxrQ5
         YG8KuUsxRHc8tsEqkUZzK9z4rZMY9iF2XcnHiggZSyLFEC3I0hKARv9jgrDS8ceq7+M/
         it0KYr1E8yMyv2+ApGbL40MxaNn5kLb9bkU0+yb6oLhTRr7KS1pK9EZaaf1olYNVcDUs
         Twk0A3ZqbkEcb2ChC9unMNwbHLOFMtLyh9hGyoeguwXLkJTF4XXT8z466MJuDeUoYI1V
         ZcLw==
X-Gm-Message-State: AOJu0Yw3A8t9c43JJ1PGG+gjtjDmZF820X0pPxNndtnAnxBTPYUEAOjy
	05iP5OdEVfUfz5J6uDB4D/HCE96JzGQ/ATFcxHvnFcxSnZJwUOiBWy1cAKGDmtTE
X-Gm-Gg: AZuq6aKgnzrWDKz15EsvEeCxYQMWatTqD+KIdGtn3wg3ZlDbKqoQl7IL0h5wNT3UP2T
	ovbhxmfR/lRKrbe7uFuoXj3SkXjeTxPByiF9/GP+MiMfBZ3lO588FLiTWfIYr8Vm85nT8xTrq1/
	yupGasOXP6SfpUILs88ruV0Lhaa44qoP5DHir1mEEEe2EEZtr5lz2PfiUBYTViQX/dsCzbCLiRR
	SIEVzbmYhGsZw0aAJd3E/dVvprecCMPvqjQlPXIAUjTZpwKYki+OgHc5y/fCtWGKUYqO8kyrXfF
	FPcP0ktNtMaL0vyH9DT0qixkn/Dz1IbH2TL35zjGDCqDXHpSJ+nUy7XG8aHkXbMdfYqCJYkiEwJ
	970ZARE215BFsP4cQiULu29xiQVXx96+pJtl2Lw6wLcBWU9ACvfzB3zuIA13IbPwGstxi2dTihb
	nInwR+HVLpFj8Ix7zDrEtFVwRiK8rtd+zDzx/oh4T+cTofBnsz+AW6GuIChYSVvwb3vj/kaAwR
X-Received: by 2002:a17:902:e54c:b0:29e:facd:7c02 with SMTP id d9443c01a7336-2a933e68cf0mr20042835ad.28.1770180514780;
        Tue, 03 Feb 2026 20:48:34 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933977e8bsm9503835ad.85.2026.02.03.20.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 20:48:34 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Keita Morisaki <kmta1236@gmail.com>
Subject: [PATCH] ice: fix race condition in TX timestamp ring cleanup
Date: Wed,  4 Feb 2026 13:48:22 +0900
Message-Id: <20260204044822.2754803-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256560-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmta1236@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51905E19A6
X-Rspamd-Action: no action

Fix a race condition between ice_free_tx_tstamp_ring() and ice_tx_map()
that can cause a NULL pointer dereference.

ice_free_tx_tstamp_ring currently clears the ICE_TX_FLAGS_TXTIME flag
after NULLing the tstamp_ring. This could allow a concurrent ice_tx_map
call on another CPU to dereference the tstamp_ring, which could lead to
a NULL pointer dereference.

  CPU A:ice_free_tx_tstamp_ring() | CPU B:ice_tx_map()
  --------------------------------|---------------------------------
  tx_ring->tstamp_ring = NULL     |
                                  | ice_is_txtime_cfg() -> true
                                  | tstamp_ring = tx_ring->tstamp_ring
                                  | tstamp_ring->count  // NULL deref!
  flags &= ~ICE_TX_FLAGS_TXTIME   |

Fix by
1. ice_free_tx_tstamp_ring: Clear the flag before NULLing the pointer.
   Use WRITE_ONCE() to prevent store tearing, and smp_wmb() to
   prevent re-ordering.
2. ice_tx_map: Add smp_rmb() after the flag check to order the flag
   read before the pointer read, use READ_ONCE() for the pointer, and
   add a NULL check. If tstamp_ring is NULL, fall through to the
   regular TX ring kick to avoid leaving packets stuck in the ring.

Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload support")
Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index ad76768a42323..d48740f2b626a 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -190,9 +190,10 @@ void ice_free_tstamp_ring(struct ice_tx_ring *tx_ring)
 void ice_free_tx_tstamp_ring(struct ice_tx_ring *tx_ring)
 {
 	ice_free_tstamp_ring(tx_ring);
+	WRITE_ONCE(tx_ring->flags, tx_ring->flags & ~ICE_TX_FLAGS_TXTIME);
+	smp_wmb();	/* order flag clear before pointer NULL; pairs with ice_tx_map() */
 	kfree_rcu(tx_ring->tstamp_ring, rcu);
-	tx_ring->tstamp_ring = NULL;
-	tx_ring->flags &= ~ICE_TX_FLAGS_TXTIME;
+	WRITE_ONCE(tx_ring->tstamp_ring, NULL);
 }
 
 /**
@@ -1519,13 +1520,20 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 		return;
 
 	if (ice_is_txtime_cfg(tx_ring)) {
-		struct ice_tstamp_ring *tstamp_ring = tx_ring->tstamp_ring;
-		u32 tstamp_count = tstamp_ring->count;
-		u32 j = tstamp_ring->next_to_use;
+		struct ice_tstamp_ring *tstamp_ring;
+		u32 tstamp_count, j;
 		struct ice_ts_desc *ts_desc;
 		struct timespec64 ts;
 		u32 tstamp;
 
+		smp_rmb();	/* order flag read before pointer read */
+		tstamp_ring = READ_ONCE(tx_ring->tstamp_ring);
+		if (unlikely(!tstamp_ring))
+			goto ring_kick;
+
+		tstamp_count = tstamp_ring->count;
+		j = tstamp_ring->next_to_use;
+
 		ts = ktime_to_timespec64(first->skb->tstamp);
 		tstamp = ts.tv_nsec >> ICE_TXTIME_CTX_RESOLUTION_128NS;
 
@@ -1553,6 +1561,7 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 		tstamp_ring->next_to_use = j;
 		writel_relaxed(j, tstamp_ring->tail);
 	} else {
+ring_kick:
 		writel_relaxed(i, tx_ring->tail);
 	}
 	return;

base-commit: 18f7fcd5e69a04df57b563360b88be72471d6b62
-- 
2.34.1


