Return-Path: <netdev+bounces-147162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F16E9D7ACA
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 05:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA67E162BB8
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 04:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1313AD39;
	Mon, 25 Nov 2024 04:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="PdLn3mhM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B8B126BE6
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 04:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732508683; cv=none; b=i98jds60mRHOwJIKVZg9dqCPN5FxlbWiIMXThqmbuCLO9AwlVn3IEWpWveNAI4R5Y4X6507rhwSr1KA6EYM5Ft89rEM830uFaGG5dIipXvW6PYmHIo5giMoGoJLpJRe3V9qCp6i89vctNtn8M/o7gdRkWiDOsvpm5i6Ee7fQ3SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732508683; c=relaxed/simple;
	bh=R7VVcEB/ACB9Vm87ojF8QMVwkxdpWkG4u5cetirHGJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EM0TYOW+coCnngiV5/pgjwCv0X3AKXcn9huNE91XdKjcc8w9HHY41VENf15oKSaYYwQPrKkcH5FrLgKJRnq4KvhpXDWaURfs7YNxuD0Io+XbRy4aQHnmx6o0Pdu+Fyd83zH4JO+m/Bf2veqVDu0MG2LNVANpM2Qyr2Vb0kuHJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=PdLn3mhM; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a777fd574bso15746015ab.1
        for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 20:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732508680; x=1733113480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQjnbbFgDIbEaXSjfbh2VAjnMh+slcPpcp0gUhtK9TU=;
        b=PdLn3mhMy0uVt2wFVKI7EKntnTJW5rEo3e7MKVWO4FdcHN33oFFC3kjDF9i/D1pEYl
         FRylUjJkXIKly5RsB4aKkwNwiLPNcbor3zdReKwAYNNNT3J/ykEGPUljT11YFAYhG58c
         amL+AAVQ66tUsNImxX88Sw8iF/E7fmQ000NklK+g0UpiCcXSwrNheadkDyNjGLgnf7/n
         OxCfB5qUWKzW+eBLnMz9i8eDB/AEq69nPBQFAjR8yyA0AVt/fd3GmiqlarUx5qSv4a/K
         3jdipLROTc6smY7nUEGEHy5CCPagBbnQ3xOIaCp5V/Ks2SZ9fglHPQpwfCx6WQVkgms0
         UNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732508680; x=1733113480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQjnbbFgDIbEaXSjfbh2VAjnMh+slcPpcp0gUhtK9TU=;
        b=HXj27xw2fShHORFcbJH1aU5Kc3gOi+RqyDfSaeh3pfByXYZ/l2vvFpsqEUcQ0TYFjU
         AQOPgnBxMrSqO0AfBujZzHqoYUD+uo+h4zV187EyzJ+DRz2nzjpMMi0udRIIVO8DZL9/
         1RCGW3+t54AocIHhB5mn9iM9R9TmFMwcCpensMyPoxeS17KKiW8Pf9CdnJ43xvReb9HQ
         ens4AcYG1k5BJ77Rc/nB59ckFJJTvxhP+EZ15Ghd5uQN5T8XQi62ws4i9bBvSwuaLcIv
         r0M2pEGyAcznMXEhAIrWCgIxYHHKBZ9oXJIU430t+d/quLRIcPZHmykY3tlqbUYj/w3k
         9NoQ==
X-Gm-Message-State: AOJu0Yx3w2/pwmVLBWozAysqrwmEOCfqAnf5bqVL1nLbAgOcRhoetj1k
	A54hm1X9E0Ux/r/GtnVhsaUXZDxPaLfCrsRYMwiGOQejvvfuKtv8LS4Nou5r4h33ih5FiP+GzMG
	f
X-Gm-Gg: ASbGncuhyxGjb8I+rcO5Yfpq0a7/yVj4LF0RI4sD3pLSze2vVHg5cACRe7NDK+iSDas
	YeS7i/zqwpqvBzfRMIXo5OBkZVR+bXXOR+7NFHIOHlVKwoKPLHt/g64IltZtjuW+6FwHANVSGdT
	K1FfPabMFbmv7NGa05L5lqKqLVpaLc/QeiHiFdBCJcLY3MjUTB52T0PH3a0s1wOrZDEcgQ3S3Uv
	IQeUyE/Nj6+5/yBWBrBtN+onI1CqNlrWIA=
X-Google-Smtp-Source: AGHT+IHOrDM+tDKNLbmiMRISyvp2HOoeg/lDMdOU3s6xReaXNY99jBRUuDUDIJNXaCglhRmwAHK9mQ==
X-Received: by 2002:a05:6e02:184f:b0:3a7:783d:93d7 with SMTP id e9e14a558f8ab-3a79acdff2dmr95321475ab.4.1732508679913;
        Sun, 24 Nov 2024 20:24:39 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc2598d7a2sm2218747a12.24.2024.11.24.20.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 20:24:39 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net v1 2/3] bnxt_en: refactor bnxt_alloc_rx_rings() to call bnxt_alloc_rx_agg_bmap()
Date: Sun, 24 Nov 2024 20:24:11 -0800
Message-ID: <20241125042412.2865764-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125042412.2865764-1-dw@davidwei.uk>
References: <20241125042412.2865764-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor bnxt_alloc_rx_rings() to call bnxt_alloc_rx_agg_bmap() for
allocating rx_agg_bmap.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++++-------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b2cc8df22241..294d21cdaeb7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3768,6 +3768,19 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	return PTR_ERR(pool);
 }
 
+static int bnxt_alloc_rx_agg_bmap(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
+{
+	u16 mem_size;
+
+	rxr->rx_agg_bmap_size = bp->rx_agg_ring_mask + 1;
+	mem_size = rxr->rx_agg_bmap_size / 8;
+	rxr->rx_agg_bmap = kzalloc(mem_size, GFP_KERNEL);
+	if (!rxr->rx_agg_bmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int bnxt_alloc_rx_rings(struct bnxt *bp)
 {
 	int numa_node = dev_to_node(&bp->pdev->dev);
@@ -3812,19 +3825,15 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
 
 		ring->grp_idx = i;
 		if (agg_rings) {
-			u16 mem_size;
-
 			ring = &rxr->rx_agg_ring_struct;
 			rc = bnxt_alloc_ring(bp, &ring->ring_mem);
 			if (rc)
 				return rc;
 
 			ring->grp_idx = i;
-			rxr->rx_agg_bmap_size = bp->rx_agg_ring_mask + 1;
-			mem_size = rxr->rx_agg_bmap_size / 8;
-			rxr->rx_agg_bmap = kzalloc(mem_size, GFP_KERNEL);
-			if (!rxr->rx_agg_bmap)
-				return -ENOMEM;
+			rc = bnxt_alloc_rx_agg_bmap(bp, rxr);
+			if (rc)
+				return rc;
 		}
 	}
 	if (bp->flags & BNXT_FLAG_TPA)
@@ -15321,19 +15330,6 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
-static int bnxt_alloc_rx_agg_bmap(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
-{
-	u16 mem_size;
-
-	rxr->rx_agg_bmap_size = bp->rx_agg_ring_mask + 1;
-	mem_size = rxr->rx_agg_bmap_size / 8;
-	rxr->rx_agg_bmap = kzalloc(mem_size, GFP_KERNEL);
-	if (!rxr->rx_agg_bmap)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt_rx_ring_info *rxr, *clone;
-- 
2.43.5


