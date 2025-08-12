Return-Path: <netdev+bounces-212796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD20B22010
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB361AA825E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0122DECD8;
	Tue, 12 Aug 2025 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmlxCPXn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA02E0B5E
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985321; cv=none; b=qB+LICoxcLiB2MA2u9yF5m/8UcOBXfxKf0oKSmBdJmQNvVjiBVm2yNeshYGIlZIZl3FVKj7XrCslHML854cHKo/pLBj4HifK75XNpzB1t1L89A21jXvhpzFh3FIrqY1QNH9sy+q/DsF9GkomuFoPMdWOnik8Ks42w6JvVw34yVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985321; c=relaxed/simple;
	bh=xzb152yZjViKkwBMZtJTkzhXiC841oDBIT/+Vp4B5dA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3XCHP3KCqJf2p3eLTN5IaPOqyJqwqFRFQ7g0R4EWtTRnEgrq4NO3w/W/GY2mA8KGRJBuux4RZmb3PCk49XbiDKz6kac3ytJrlnRiZyP9y17Y8t5Cnxwo6RDt8KpzEDgA8l+Dti7kb0OxClO8XivVOwzStKqi6+vx5NZ9/LTUNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmlxCPXn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bd041c431so4546511b3a.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754985318; x=1755590118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nleqg4wIqtXmBZB8Yo+HYH0XMGVxYzqd4mlNWFMzMgY=;
        b=PmlxCPXnXrbOUa4tG/4mrqmXK0CJSGFsEi0DG96hxroGqXW397HACq3wBcjLEiyQE9
         A+CyW/NXqPMTPZYcTdodAMss/L2+wmioSE0xR4DlysByN7AjgIDX9ZG2K87XKWuxHz58
         POPvUy8EoBleTl2NsEjAqsajBXKFxqHzMQRVVUe4jn08J7rXqPtZTtfwPl6WXVW1R9T/
         80+K6ccQmc3Tz2dhxFKCNWRUNyA19bpbpUveFGMeb0q1tFpW0qvZ5PM9xOPVC6RUcZSP
         mKd6iKFct5Fk1AAXL0TV7SvivRgtKvnV9D7N98+1loprtUD9ycMZzxThoo8CMn14O3gU
         6Oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754985318; x=1755590118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nleqg4wIqtXmBZB8Yo+HYH0XMGVxYzqd4mlNWFMzMgY=;
        b=eYsE59x7QBHyOutpuy9sqwoJyHpQU0rn7AHVETgdRjLgncXxY8RBEwV3v8x1upsuIO
         2hKUb7TIXy4cBm2kub0urlbZgXBnRUHYW0iIArGzRauxAqi/E0IBnoribtkJUdDLkP5I
         s57O6u/d1ZXBQiuMGmo4sIwBrj2d4SE0sZ7h/paCIlGYEnFx7xVESF1j+W7Ee+N5JadM
         P3emXFFshPsVMW/I3FIvoyLPrl1klDI/fZizeT7vDNiwmtiBEBYuzAxBHUxTaLsJ54Ia
         P/edQvSJWeA4frsRvFEHsekuN6lK6awcJo5UBeNjQEXyVQTrf6fR9JFfKNyCKizVVdms
         A1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXJh6UtfRxKH0E79EZvMSxjEdLRcYestqdqtj1zHftUnT7mSxTx2ooZsdc2onknXlyvRhgAP1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+zycynw2WmUC533WvMgjIjfOWHqTL33jNprvgwrSb8OoWSQc
	vU789uo9W9N4Z3uWnQfIB8fZXe4/ribzULpa8vnUuo+rv22izKZt441A
X-Gm-Gg: ASbGncs6Frn3o7N6j+vVsirVFGDAvNAOJzAQ8ZTisRN+j8CXyVT/GiSx1zVr9BseALu
	bPuvp01b7J493AS/8WzwEO4MIcfNSxJMu4Brz2071QBrriJOTdKk5CZ1wrMhwh0n1ZNDQ57g6Gu
	FFLgxyGSw2poCIyXTARO6QhGtXOiYyR3W+uR3woOh1Cy75YgdmAKdv6G1SZDZh4sRARgGse46Vy
	h2xGNtSBlX8V/XkuVgcKNJCR5pY3RRPfF45asCfCfHGx30CYM3s+O9gHxcJE+bgaNQKXrksWcdF
	HtcRRNWxakqGCjE7cbw33U/GAdUYhU2TC6mxhfEGfgj0eyvdvjExuI0/74tiYsjl3/lH8LY8ciN
	dMZ+YYu0CXxurys0HhnWwNd11DI3mDKoInAzVHAiQcSF1C/yWMBVjhUm7/OGMj6xOAsSvsg==
X-Google-Smtp-Source: AGHT+IG1yyYLPVdu9foVfbMCgoIRld9kjxqBO6uHQeaB5B9/mt7khlx+nrKnTwkjDrs05ntBXzMYeA==
X-Received: by 2002:a05:6a20:7d9d:b0:240:2473:57b7 with SMTP id adf61e73a8af0-2409a890d57mr4215339637.8.1754985318376;
        Tue, 12 Aug 2025 00:55:18 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac12d4sm24651320a12.32.2025.08.12.00.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 00:55:17 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	sdf@fomichev.me,
	larysa.zaremba@intel.com,
	maciej.fijalkowski@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH iwl-net v2 2/3] ixgbe: xsk: use ixgbe_desc_unused as the budget in ixgbe_xmit_zc
Date: Tue, 12 Aug 2025 15:55:03 +0800
Message-Id: <20250812075504.60498-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250812075504.60498-1-kerneljasonxing@gmail.com>
References: <20250812075504.60498-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

- Adjust ixgbe_desc_unused as the budget value.
- Avoid checking desc_unused over and over again in the loop.

The patch makes ixgbe follow i40e driver that was done in commit
1fd972ebe523 ("i40e: move check of full Tx ring to outside of send loop").
[ Note that the above i40e patch has problem when ixgbe_desc_unused(tx_ring)
returns zero. The zero value as the budget value means we don't have any
possible descs to be sent, so it should return true instead to tell the
napi poll not to launch another poll to handle tx packets. Even though
that patch behaves correctly by returning true in this case, it happens
because of the unexpected underflow of the budget. Taking the current
version of i40e_xmit_zc() as an example, it returns true as expected. ]
Hence, this patch adds a standalone if statement of zero budget in front
of ixgbe_xmit_zc() as explained before.

Use ixgbe_desc_unused to replace the original fixed budget with the number
of available slots in the Tx ring. It can gain some performance.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
In this version, I keep it as is (please see the following link)
https://lore.kernel.org/intel-wired-lan/CAL+tcoAUW_J62aw3aGBru+0GmaTjoom1qu8Y=aiSc9EGU09Nww@mail.gmail.com/
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index a463c5ac9c7c..f3d3f5c1cdc7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -393,17 +393,14 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 	struct xsk_buff_pool *pool = xdp_ring->xsk_pool;
 	union ixgbe_adv_tx_desc *tx_desc = NULL;
 	struct ixgbe_tx_buffer *tx_bi;
-	bool work_done = true;
 	struct xdp_desc desc;
 	dma_addr_t dma;
 	u32 cmd_type;
 
-	while (likely(budget)) {
-		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
-			work_done = false;
-			break;
-		}
+	if (!budget)
+		return true;
 
+	while (likely(budget)) {
 		if (!netif_carrier_ok(xdp_ring->netdev))
 			break;
 
@@ -442,7 +439,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 		xsk_tx_release(pool);
 	}
 
-	return !!budget && work_done;
+	return !!budget;
 }
 
 static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
@@ -505,7 +502,7 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
 	if (xsk_uses_need_wakeup(pool))
 		xsk_set_tx_need_wakeup(pool);
 
-	return ixgbe_xmit_zc(tx_ring, q_vector->tx.work_limit);
+	return ixgbe_xmit_zc(tx_ring, ixgbe_desc_unused(tx_ring));
 }
 
 int ixgbe_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
-- 
2.41.3


