Return-Path: <netdev+bounces-212210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C549B1EAEE
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA96C1C263F1
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDA12874F7;
	Fri,  8 Aug 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGXsSd1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605D728727D;
	Fri,  8 Aug 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664842; cv=none; b=ho7R5fDXRrPJYTrbdQ7+pbEByTpAAlhaw60Du4nC7WcNtzxG3oSyxTw/D2rtitlgAHWD4sgZmjmv8Y2CCfKMxX4DU1plthTYkdstK9WJ5yZIcE5rdlk3GKlFQ7oLjjKqhC/d49yX1BaPffscNSBCHoMJ1f2eTLuGZxigOfT4OL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664842; c=relaxed/simple;
	bh=hU/n/C5hEtTRHv/Bx1kXLtULllo0SCYznPG0s9DeCKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrMjf9fsvFc1+3jN9P/LznFWnHBp7G9F6SuGyZEVk6V4rLybAYromBKoTYb0GROTeq3nvhT+IBjZqVjR+HPMEbZo2017x+ohc5m02f1ETWIQYFRmODQJ+UHz5l3eIX693sH/ZN5EltlOi2yfkLpU4LvoDOja251KAVWXd3B2y3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGXsSd1X; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b8de193b60so1308036f8f.0;
        Fri, 08 Aug 2025 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664837; x=1755269637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jil9mHgC7mEIc2j5EJkmS13NrtxehQKBSwC+k2OfBs4=;
        b=aGXsSd1XQD768GROlPisgAvs4ie5NlbAB5KQhNnVqS5+XNDq13EUI7XawH3PR5di2o
         Shqw4yQVfGUBBqk/PjVBcf05rIqhRpwqMn/FJFzEttQW0dOs1GYi9EwTWkJExjvGff68
         aLh6kVFUNjvFUO2u+pAdnYkjeVgEzliLQQSwzPFaxzV488s51ry2orOJj6aVkkNSYgXC
         v82t4zcBydhtK8FT858K+3qLe+dlz5v3OVVrANg9y22usBW4HgTA0J8H+U4cT7YrPjSY
         1VChcYZ9TubIslXFLX+B2XPMP8vfwuNXfxmEBBVOelu/cTbFW1rVLTha25faZ5z+ydR2
         x+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664837; x=1755269637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jil9mHgC7mEIc2j5EJkmS13NrtxehQKBSwC+k2OfBs4=;
        b=gB2NgKA0+txxpboROy34fzMuyVL6ZgkJNKiX9kVhrpYeJF09eeZHjQOVFpJ/lksao2
         QtEUjLvwzJIFEOCvY8L6VwGywzz/2Xn8khqGmoqh/fgZEbgoR+hJcTVlPtivK1FJ8/BR
         Iw+uPnU9eQhZ51oxqQxR86H4181VMUxJKyidXCkchTc2b3WpNF5tSoGLP+tWcPJu2nwC
         ANNFv4wtBmzd6YSCEeQM2V6mVnMx+uWqRMNr6M9lh89fiGhJItjVorjucKIKnvRlEVsf
         Z0oYTLED7OXpUfzFyNKKwaEDDLRD1O8QoydnGOpb/AtL1h0ul7+EEJXwBV0yTCwYmp5x
         79lg==
X-Forwarded-Encrypted: i=1; AJvYcCWid26nrKx1cSGmYn/zIEo+t30YwAXUI5yUaR3NB0Em+bxpTqY7xUwV5W65l6TYvKM5AMFzZNds@vger.kernel.org, AJvYcCXjDaBjh1MWzR5c4Rpv3c6EXh/dbwTfjFc7FjpM1WroM8JUOBWJ75vkkaOEnHth7ZeSWTugSlzDfvnzw/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9kHAlxJNAAqgEIeyJo9LzbTdlzEEkvoqIK94ocfLEFsZXxx4
	jXDBo6GQHC8QSs3AMQFqFist0SyRAibhQy0r6MoCiJAiJrU9R2bxXom6
X-Gm-Gg: ASbGncvDc2asWor3+0pKf3T/VszplCRSDHdj9IFXUqi5qigzO+/Q25Gejxl5RL6tSZe
	0UYamHx9bZNgSf+R1SMTHblACqO07LMC9LC+LGRj6GSRC6BnB30SBCes+vdw8taWr/E/A6gMViU
	NNwLIpswoMtKlm/2A3K46RbqCnkis4w9Lj1u7CkArRp8vf/ZkTWKPmymKgJebSzCXLpWQ0x5sNo
	dQ9Gha+JaVTAi2jUz63oqcWOxh0IrOct6VYU9CsbvosOJ+4HLSMsQ03PQpIEZLLplvu8VpHaV7r
	tn5r8sopKSmYmqOAkWhxHk3dlNDzXed0S3rPJB6vmTA6wzW7YCm6L0ZMOxfH70o8JSn1ca/42RG
	Kvhp1OA==
X-Google-Smtp-Source: AGHT+IEDIXRId+jzuDrvYhOv+oqA4vxPWex8ME0953a7G2wnDFYPfZn2fn8yxOTU0MEN69fp7fa67A==
X-Received: by 2002:a05:6000:1ac7:b0:3b8:d3b4:2c4a with SMTP id ffacd0b85a97d-3b90094025dmr2776340f8f.17.1754664837234;
        Fri, 08 Aug 2025 07:53:57 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:56 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 17/24] eth: bnxt: adjust the fill level of agg queues with larger buffers
Date: Fri,  8 Aug 2025 15:54:40 +0100
Message-ID: <0a4a4b58fa469dffea76535411c188429138cc81.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

The driver tries to provision more agg buffers than header buffers
since multiple agg segments can reuse the same header. The calculation
/ heuristic tries to provide enough pages for 65k of data for each header
(or 4 frags per header if the result is too big). This calculation is
currently global to the adapter. If we increase the buffer sizes 8x
we don't want 8x the amount of memory sitting on the rings.
Luckily we don't have to fill the rings completely, adjust
the fill level dynamically in case particular queue has buffers
larger than the global size.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: rebase on top of agg_size_fac, assert agg_size_fac]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 27 +++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 40cfc48cd439..a00c2a829b6b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3805,16 +3805,33 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 	}
 }
 
+static int bnxt_rx_agg_ring_fill_level(struct bnxt *bp,
+				       struct bnxt_rx_ring_info *rxr)
+{
+	/* User may have chosen larger than default rx_page_size,
+	 * we keep the ring sizes uniform and also want uniform amount
+	 * of bytes consumed per ring, so cap how much of the rings we fill.
+	 */
+	int fill_level = bp->rx_agg_ring_size;
+
+	if (rxr->rx_page_size > bp->rx_page_size)
+		fill_level /= rxr->rx_page_size / bp->rx_page_size;
+
+	return fill_level;
+}
+
 static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 				   struct bnxt_rx_ring_info *rxr,
 				   int numa_node)
 {
-	const unsigned int agg_size_fac = PAGE_SIZE / BNXT_RX_PAGE_SIZE;
+	const unsigned int agg_size_fac = rxr->rx_page_size / BNXT_RX_PAGE_SIZE;
 	const unsigned int rx_size_fac = PAGE_SIZE / SZ_4K;
 	struct page_pool_params pp = { 0 };
 	struct page_pool *pool;
 
-	pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;
+	WARN_ON_ONCE(agg_size_fac == 0);
+
+	pp.pool_size = bnxt_rx_agg_ring_fill_level(bp, rxr) / agg_size_fac;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
 
@@ -4384,11 +4401,13 @@ static void bnxt_alloc_one_rx_ring_netmem(struct bnxt *bp,
 					  struct bnxt_rx_ring_info *rxr,
 					  int ring_nr)
 {
+	int fill_level, i;
 	u32 prod;
-	int i;
+
+	fill_level = bnxt_rx_agg_ring_fill_level(bp, rxr);
 
 	prod = rxr->rx_agg_prod;
-	for (i = 0; i < bp->rx_agg_ring_size; i++) {
+	for (i = 0; i < fill_level; i++) {
 		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
 				    ring_nr, i, bp->rx_ring_size);
-- 
2.49.0


