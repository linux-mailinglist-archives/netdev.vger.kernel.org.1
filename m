Return-Path: <netdev+bounces-270656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cONxJnGDwWnATgQAu9opvQ
	(envelope-from <netdev+bounces-270656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:16:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BD42FB1C3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43A643029A90
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7353BED70;
	Mon, 23 Mar 2026 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCKhBtcG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125BA3B8BDB
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289362; cv=none; b=poF2MtJ24OGFwhbyy487WwWfworFAAydL/ejZiqCttPtiJLWCjCMLPAqsODYI3re/HEz89WE/yTm8Fi4wlBciR09L3yUj6neTo/i0zdrdayLtZvcsK9VXNaW4MiYWHhNtAtzk96mGfB0BTpCEWgCfoUliHJ+8YRowAM9beDyQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289362; c=relaxed/simple;
	bh=3YaXuT5Zo2/D6qsiT4OFYcTOpHZh3AJ/wSnHsmU9yjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQMxWTV5RGfiuQcDpaPd/uGo1BRd1Iv7ngXVKaZKwdhVENV1rT2BG3dApt+CMk4Nm/Q5JqEb4kmadKrkbnz5NoBA6E1W6IUiJ7FheSdzq6lwwDsNxlTo0za9yPR8TCMUZFeOvF/WqQ4ovFwzeGWxMqubvJ3HKqc8ixHV9QnoeQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCKhBtcG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso37476825e9.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774289359; x=1774894159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YO72kODuEVvczmG2KdWF/y/765rWDtdAol6d5uBPwpU=;
        b=TCKhBtcGZvZdoN/CkW2MdCQd5yPB99O2WU3Krj9zS9VRF0HFznmiI/LbB2pqUuwl/4
         7BuzLvgPvC6MjGA0hMukvGjIXF+BLYDGki9mVzJeLE1zXPgFiBuYtSP8acPrSZ2F93Wv
         sty8sLRZppiD67YcPls78sDTogK5XqhOAn/2OTpCVqKUUt7K8Zt72oqssSBh63Foibvr
         we9J0tsXF96h3LbXuaA3fg3YSkxrz2+Ztv8wb/QGU51P6i2/g3nx2yKc3H9X7wzAFHQ8
         Po986fE2NmGvHRVe2O+C0QgKhYjnk00asyu9RM3C51J+6V7YGcEtzoCmrpxjpt6BTxL7
         WgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774289359; x=1774894159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO72kODuEVvczmG2KdWF/y/765rWDtdAol6d5uBPwpU=;
        b=kssHjsDm87sxd5jQWkNY8MLPkIFpavvXSgkwpqiuO0DlQM/TZaZOcRp5LwnAH+rTDw
         TvtFhPmh+37nvNkI7fLj95sB+Flu2fNiXT3jjV8pyFmnsId3A1/YuBa1FLnB9s1HX0Na
         K2pxWp/+442F5FdKrZtGbFYxlT5o1acaobydzUsG7xBQgGBB2IthPp3THysErko1VNp1
         dg0mdUPTYuFfd+/g5zetKzVx6AIhMscqkoa62yj6p/MvigdqeHQO9XYUUF9P5FdzjMBw
         K0+YqJqLQtP/RwjuIdDazJzIZDi2efNVep5s8AlpgA98QSdj0QTDQsJ0sqdFeFHjA+a0
         ZhZg==
X-Forwarded-Encrypted: i=1; AJvYcCVNoOC34YwpLU2ivcfFII4UFuztSQku21DG6SOOYtzRqtVCfeDESuPafdwGXuzD0rjcghw2YWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQAsPQ27T7S6NBcSic/Jefq5BJUrg/muTQA+pcFQtEIrqQp4U
	KSAyoLLK5QkpmCgAdh2elYIv5z0sq2/6UtmmPbtI5AYEDUZ6l0n/cOed
X-Gm-Gg: ATEYQzz3EQ0rDcmtsmKNnK6wdHxUAWfWmgoSrnIvdQ5Yfz/ySUIqP3nNf/BYPkpc/Uv
	swjMMmyITdV9PYm66Jwos4yTpmx+rVWy/WpF/0pBBSQhRM/cQbQ/nJAupb1LIzSXM/RIkcIUY+X
	GhE4JzWoaz2QHHEAy0es5SqpCiR2ev3Ma0JoiHyRoaWSKVJV4mDI/EXGMluXzsr29/7rtavqsms
	rwJGdfqIFv9m7+pDrlaVX4lNU3wsb1X2318HzyS3j/um5mRkbC1C/IBgf3+9SrpYPgJTCwYqMTj
	zcnyaqvmOoJ4jl3Y8aPNxBz4KEX/ydhNUtysCvUhsQQIMv/kJILDGctUu9W7Dz2E42hkSccOGnB
	dYYBzQbvB27epkS8V7wSjyjMrg7PxYUi8x3pPi9xBkUoyQTx4oc+04MspyozGZfWAxg2y7MWZeM
	yDqtySM5sdhqjzGrA6Rif19bJBu10Vxera8k5q9pkDBK/APlU=
X-Received: by 2002:a05:600c:a085:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-486fedcc6e7mr187658175e9.15.1774289359183;
        Mon, 23 Mar 2026 11:09:19 -0700 (PDT)
Received: from localhost.localdomain ([151.47.115.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe6d9896sm317479415e9.2.2026.03.23.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:09:18 -0700 (PDT)
From: Adriano Vero <litaliano00.contact@gmail.com>
To: michael.chan@broadcom.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Adriano Vero <litaliano00.contact@gmail.com>
Subject: [PATCH] net: broadcom: b44: Add missing dma_mapping_error in b44_start_xmit
Date: Mon, 23 Mar 2026 19:09:13 +0100
Message-ID: <20260323180913.188434-1-litaliano00.contact@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270656-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[litaliano00contact@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84BD42FB1C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The b44 driver calls dma_map_single() in the transmit path but fails to
check the return value for errors using dma_mapping_error(). If the DMA
mapping fails under memory pressure, it can lead to memory corruption.

Add the missing check, drop the skb, and return NETDEV_TX_OK to prevent
ring corruption.

Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
---
 drivers/net/ethernet/broadcom/b44.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 90df02e00..280ea6dbe 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -964,8 +964,14 @@ static netdev_tx_t b44_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	mapping = dma_map_single(bp->sdev->dma_dev, skb->data, len, DMA_TO_DEVICE);
-	if (dma_mapping_error(bp->sdev->dma_dev, mapping) || mapping + len > DMA_BIT_MASK(30)) {
-		struct sk_buff *bounce_skb;
+    
+    if (dma_mapping_error(bp->sdev->dma_dev, mapping)) {
+        dev_kfree_skb_any(skb);
+        return NETDEV_TX_OK;
+    }
+
+    if (mapping + len > DMA_BIT_MASK(30)) {
+        struct sk_buff *bounce_skb;
 
 		/* Chip can't handle DMA to/from >1GB, use bounce buffer */
 		if (!dma_mapping_error(bp->sdev->dma_dev, mapping))
-- 
2.47.3


