Return-Path: <netdev+bounces-212214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50851B1EAEF
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D8AAA1ADE
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ED528850D;
	Fri,  8 Aug 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT7yq3oA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED172820CE;
	Fri,  8 Aug 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664847; cv=none; b=Dxt4SIUtJ9pxV7hmEEEXvUziJnQBK89qytvIZ2J+SWBmj+Yy6QayFNCQUD5dnuAQmlfAh+zBQ5+lFz0f+iJnH1f46Evc4oPUzECqmz6rlJvtNWjhoGZpc5XYmrO/y4xT4211LokxSv+Li1KxSrfnS1XqsQM7V9qp4TGphSOASW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664847; c=relaxed/simple;
	bh=p8nWPhP7vSQGzZCdW2ORmVS9hf1S6V9V2obgfTwR8cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvACuCFhSKg88S51ifIVR692zccKWeFMvCwvTkYpLI7BNS8uZeIuvexoyT4HiE55k0/YnZ22uE1vQX5y17PwRo0kZDCl1jdGKs1I+yaBRFzTMZf0IgIrDqXdK7NTAKltyF2MBi7Q8f3DSa5iuMGvWnD7EBlyvQBjI/AQBXzXd7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT7yq3oA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso14305055e9.3;
        Fri, 08 Aug 2025 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664844; x=1755269644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y3hrs0t+IeBjTTno+1QeKOa7o9IZ9oGKSKG1wJOxU8=;
        b=DT7yq3oAK9PurVv4ABNzVcYtaAdNYZbpFvopKVlPo6VEfyhbKj+/b6Ea44JFLSwHmo
         +8g/QYfvpBiEVH9l2BTP0S9k5w1fiegtQ4tZZ8jcsIRb44roYZQaGv2RusLQsSdH1Apm
         a941TfL6IdplmkY+jeI0BjPaOxIqXC1X2G/B7roIRJbu0QEEI52Q2XE93P39TLMJxsga
         PVZRvH0eaN3LJClL2oROgUQ6MmrfwbMfTDc9TYRddLpF4j90GIWqDcLfOB5Xguczqd4v
         8N4JradwOKM1E7mk1GUS0L15xHN09TnVbPdpmT26xLJ9TFo/U5A8jVmwpt5ZUP1tJaf0
         n6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664844; x=1755269644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Y3hrs0t+IeBjTTno+1QeKOa7o9IZ9oGKSKG1wJOxU8=;
        b=Lp0xQOy/uR/wf0ddeGoXAwZvl9Uo8GWOmxR9GFnwIzvtk2dKBbrrt+mjgYNuArxxEk
         Jk8ttDgzixAovuxA+JOK8rvNNkluRhO4Zg2i6Ff0rT9ZzTwFJcOzc30S9eqBMxhEdtqt
         r4tuOkd25MMO588evbD+5o0P2na23Llf/5xLErBRF4wEpdR3tqedI9GZzGZyTWyLrYm2
         Ci8ueVQZHfRoF8OFTnlmR/E2csHH6bJD+gUlQYITWePdO/NFd79aniI86letazb2LOjg
         upyw1WMbmXv7pOuwlbYFCU5fp3HhB89Ojdv1SaTAlm2f47XvEcg4dy3JGI0/LFzwwsw7
         2SGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWytKZIVxbDxDTWcgM4bFwF/9cZqbpJuZlMlTl1lWi21q7QCDdFhiTptcXNp9exYfOIa8teD03Rd3LC//o=@vger.kernel.org, AJvYcCX2pDBeQfYdqzm9Emc6wbumOpyYKO4iJHtP3oqzCHFG8bQACLXAkslZK8UelnzAqqB7XRpimryC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn3HRrEC3rLJwbrmIpx93sZwfpM9cNWZK2uGjQe/tBeE/UrbsL
	kDMujgMyA07P48dc3U/OTyQN08Cb1CHweWRuD9dTEgHgBLdUyKHU678q
X-Gm-Gg: ASbGnctCc6F6MRrW5EBOe8GQ915BC/gz6w2sz1+b+vztU1kEvMYdfOR+bmbVnSqj5mn
	ErbPr9cTYUKD11jvBppszihOHFzKO30UJRxV7dVUt4+jf1oFy8o5mkCiXjSB0hhj6RV57rhdkKu
	lGyLz2E0Smegz0aAP/LbymSg03n3TIzayzAoFlaa/wtE3ItXYrBxBvnJwXZVKABR4fcB56UD0HV
	x3ogYzwOMvQm+pSrlo/IM1VWeX3eTltiUIoXRI6IaU2XWWri76LO14WkIVR4G9xuUV/h7Zz4wOj
	S0bNhtIH22pDv2JzPXx45dBqVMex+1zNXofEP4ywhWd+UJbiGMEe4ga/bO9fy0lqtmWGvXjVbMD
	mIufPIQ==
X-Google-Smtp-Source: AGHT+IFrUEsfWh6aKgmoWToMGRNhtJ9yYTDd/x2IHauD7cQyRBTu7XZq2MhG/C4xkdI4YsRNaZqgeA==
X-Received: by 2002:a05:600c:19d2:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-459f4f04f66mr31428285e9.19.1754664844120;
        Fri, 08 Aug 2025 07:54:04 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:54:03 -0700 (PDT)
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
Subject: [RFC v2 21/24] eth: bnxt: support per queue configuration of rx-buf-len
Date: Fri,  8 Aug 2025 15:54:44 +0100
Message-ID: <08b823769e658571a185f64bdada5996f5231a0d.1754657711.git.asml.silence@gmail.com>
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

Now that the rx_buf_len is stored and validated per queue allow
it being set differently for different queues. Instead of copying
the device setting for each queue ask the core for the config
via netdev_queue_config().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 86cbeee2bd3c..8f4ae46de936 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4300,6 +4300,7 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
+		struct netdev_queue_config qcfg;
 		struct bnxt_ring_mem_info *rmem;
 		struct bnxt_cp_ring_info *cpr;
 		struct bnxt_rx_ring_info *rxr;
@@ -4322,7 +4323,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		if (!rxr)
 			goto skip_rx;
 
-		rxr->rx_page_size = bp->rx_page_size;
+		netdev_queue_config(bp->dev, i,	&qcfg);
+		rxr->rx_page_size = qcfg.rx_buf_len;
 
 		ring = &rxr->rx_ring_struct;
 		rmem = &ring->ring_mem;
@@ -15857,6 +15859,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	clone->rx_agg_prod = 0;
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
+	clone->rx_page_size = qcfg->rx_buf_len;
 	clone->need_head_pool = false;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
@@ -15963,6 +15966,8 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	src_ring = &src->rx_ring_struct;
 	src_rmem = &src_ring->ring_mem;
 
+	dst->rx_page_size = src->rx_page_size;
+
 	WARN_ON(dst_rmem->nr_pages != src_rmem->nr_pages);
 	WARN_ON(dst_rmem->page_size != src_rmem->page_size);
 	WARN_ON(dst_rmem->flags != src_rmem->flags);
@@ -16169,6 +16174,7 @@ bnxt_queue_cfg_defaults(struct net_device *dev, int idx,
 }
 
 static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
+	.supported_ring_params	= ETHTOOL_RING_USE_RX_BUF_LEN,
 	.ndo_queue_mem_size	= sizeof(struct bnxt_rx_ring_info),
 
 	.ndo_queue_cfg_defaults	= bnxt_queue_cfg_defaults,
-- 
2.49.0


