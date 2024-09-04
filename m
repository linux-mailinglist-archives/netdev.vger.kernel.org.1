Return-Path: <netdev+bounces-124905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B037796B5A7
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0001F21054
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395CC199EB2;
	Wed,  4 Sep 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y8GuF0NS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F811922CF
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440324; cv=none; b=bGbAMrIboqonHDoLYnEKgMl3D2+cyzmAPzSaEM/HxQ82twvJO3Lvi5O8gopXqq1YMKRjL/oUztzF5ySi0kuIE6fLWsnXLTOPDEjTuR1gcPsF648NBQnU8l7M3EkJALPbEnf2Itia6mOBpPe8IZRy9S9sQ79I8qLbnKkubYyBqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440324; c=relaxed/simple;
	bh=XfKP8unbbPBjVgS+QzaKOcNAm22jNvgAVhT2scaF0BM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lrs4wErvH/91lb6nd+aRh6NzXOnsnAukKfKyzSKxZ8c+yWu+F2M6Yy9aAxhXHrnU/Zlw0UBRxctPKeg5qh4XrspWd2sgaeLGMcfdKFLO+uLwzsxt5OEaT/AoaMNXgXYMdt7HhFkiR+CFSIya74jMzkoBXhKAJxFi5LdevGcItkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y8GuF0NS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so384127a91.1
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 01:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725440322; x=1726045122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+t37x9TLIsk4O4gRZ6eWG8xD3/DMOHyXQXhYkfg2vsc=;
        b=Y8GuF0NSsdSHACS7Q/mkauqMuX05ZgV25nN1B4HNzRu2+GFybYITqEWLZ1Z1TTkaUl
         vOb0DcMtfeq5PUM01rNcPpLw1TehXRzJ16l5L7wx2Bq9mZ6XUZF1hs+NlElKNlhwFxNh
         xb6rlPeQqo8N1/fMydbdGSH6qoVvwyHx4UCzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440322; x=1726045122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+t37x9TLIsk4O4gRZ6eWG8xD3/DMOHyXQXhYkfg2vsc=;
        b=RNVbFPgfK/5E3x9V7FBisvYVgxXacHQBPHt+TTZ8ViouNxx+z2Ju5gSSizOhHYVfxL
         a+2tG7obQuCi5BHsfsrH/g5LhN7U/v2Jh9LAt0+NP24el9YEKvLRG8UDIz/xevGhZ8oY
         sOho096TCliUquAHwicK1jignSoCecU2rCDykWpSzL4vQDHL23z8BCc9AkNsn2NpFDzC
         Z3dFBB/eZjyrhvHeBd1VWKROaqkd6yrcGL5FwhHiF6kjQYnh3L1r0GaC3TPEXBA0tkn2
         yIj9ZwgYaWnleZE9aB6OPG6vI4NsOquWFK5fJH4OXA2D+Wxo1SHLFmVzE67TazCWxQIm
         ubdw==
X-Forwarded-Encrypted: i=1; AJvYcCV/TuLeOw+vZ46YRfehKCyFhaUh5hL2E910x4T1JVoml5/sTOssZ/2AXKsIDTBPIih0SYChFDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylqEzsdRW50cC5yeJFeftD7lv1NtZ9omczCd+0K1A/7eSIyimo
	kbD8uVYHJ8mv3WChgHzZa5lUNXqpZWvh1Pi7Qaapozg0Q0WMNWPq9DqFGXP+OQ==
X-Google-Smtp-Source: AGHT+IGhKGqxiqy44JngHWHRLAJzqxdbahk1woNkmt3+2VUIw1+4M6eU68DZSnvt573TLX01XI6S5w==
X-Received: by 2002:a17:90a:bc9:b0:2da:50e6:5ab with SMTP id 98e67ed59e1d1-2da8f3028b9mr2329713a91.18.1725440321498;
        Wed, 04 Sep 2024 01:58:41 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da6fb086cfsm2813801a91.24.2024.09.04.01.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:58:41 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Breno Leitao <leitao@debian.org>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.6] virtio_net: Fix napi_skb_cache_put warning
Date: Wed,  4 Sep 2024 01:58:29 -0700
Message-Id: <20240904085829.14684-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit f8321fa75102246d7415a6af441872f6637c93ab ]

After the commit bdacf3e34945 ("net: Use nested-BH locking for
napi_alloc_cache.") was merged, the following warning began to appear:

	WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0

	  __warn+0x12f/0x340
	  napi_skb_cache_put+0x82/0x4b0
	  napi_skb_cache_put+0x82/0x4b0
	  report_bug+0x165/0x370
	  handle_bug+0x3d/0x80
	  exc_invalid_op+0x1a/0x50
	  asm_exc_invalid_op+0x1a/0x20
	  __free_old_xmit+0x1c8/0x510
	  napi_skb_cache_put+0x82/0x4b0
	  __free_old_xmit+0x1c8/0x510
	  __free_old_xmit+0x1c8/0x510
	  __pfx___free_old_xmit+0x10/0x10

The issue arises because virtio is assuming it's running in NAPI context
even when it's not, such as in the netpoll case.

To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
is available. Same for virtnet_poll_cleantx(), which always assumed that
it was in a NAPI context.

Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Link: https://patch.msgid.link/20240712115325.54175-1-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on v6.6.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 51ade909c84f..bc01f2dafa94 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2140,7 +2140,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	return packets;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -2158,7 +2158,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit_skbs(sq, true);
+			free_old_xmit_skbs(sq, !!budget);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
@@ -2177,7 +2177,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 
@@ -2280,7 +2280,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(sq, !!budget);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
-- 
2.39.4


