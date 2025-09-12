Return-Path: <netdev+bounces-222614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66963B55036
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44EC175883
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803C230F555;
	Fri, 12 Sep 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D6vIG2fI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB515624B
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685710; cv=none; b=oE85kezcCwkLpPpSAQ8iHmnvaGSo1DgOni6SxDc59l+NUKXLruDJjoqz2y93E3ZybsXcWlpiPzp5ijMF2xSECqhqTH+r6j73d+q1BOCIdmzfGLvT7BVtROUje6LlG7KQ+HY4vHsX82YoN6+gnDUpc5OHraubVSNT4ys14gKdUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685710; c=relaxed/simple;
	bh=sTOimKal0OOupS0ld0czPYaXJXBqN6bh9JEXfgay0oY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L0SZ+Xb38rz/ivfKEiZvME9/RJafWVgUvQ+jfZiIQrfT5teVJIwsjZK9nRXqscFsZrCWt5QpoeQJ5bNg9bgDY6zz7mgmcnFpmUmsQwOms4Zv/zQo9x+yoAc3Ug4h7soevTxASaVzuHCRUqfokOqa4Tcf2YefoRroVr+Bo4/tX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D6vIG2fI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32de096bf8aso1473905a91.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757685707; x=1758290507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zo2y5SuH7T8OLSqI5px4qVfoaEsoGvOPtgjER3NygYk=;
        b=D6vIG2fIP5D46A/Uwj42zxfH1Kv/KdqoQN9RNsmGk/5tSyq5UHGG+inD4q708C4KqL
         dZTws4mwU+aQ7Tqt+Y55NB9XcAvrqC2cnlY7DOmd8CmSSER05l/FopJBt4KmHv3lFhFN
         wuuYTvu74mFYPN6Kfzad9VH2r7UdKibxDXQlJxbogWoViGs5UiS+en2CTx1OiAorx8rJ
         tkCiSB7ap0EFYR0GLq+RjOOy5nOXdmWAaccfEa8ZfwALWxF8KzNTAmHECID27oc3Ufvy
         ZjM07KJmErdxnDUTSf7JjNWwlo2HPYt+UVLQEkNvCMyZj6zTI5h7cw96MtPAUv3nVU+L
         YsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757685708; x=1758290508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zo2y5SuH7T8OLSqI5px4qVfoaEsoGvOPtgjER3NygYk=;
        b=WT3CYkL2Hv9o1qcw5EpE1jW30rnuhVGB2dM6Fgr0amEn/kXdeDS/BXQ5CUbUhTe41x
         2qrdC1vfaDi6zFlxLRwKPWokhnoZq7Ugxy8eGRoWeemuLvIeXuozkPVSnKHxeeW3oZjj
         9B6LypLMuMH1KoLPOnlsleFoqW0lUCTTk6+G1eOGtKvhAPCCb7jIGmORx4XlcYVnU3VR
         uunSuPWFcIVyQGrNkfHiHXDqjzrZ82L24oCutAZ5k5bQFJveEAGYXML1F93yrZB+XNNg
         Vhj1VwwvKGwQz72LSFpNrlOZJ3T50XVj0/RVkuHLQ2big3Et7ry+IjSCnsXWeVOFPEye
         1Q1g==
X-Gm-Message-State: AOJu0YzPE17+cWZTN/NacPLuAsiqtZYzjrGWbxo2JoMrbInUTnzs9Azo
	gbWTDvCZQu1Zd9gTt42LkVsvml6tVQWMh0VGJ8/nUFRh3KcTWX9SuXSa0KG15R/yAYU=
X-Gm-Gg: ASbGncsD1tDpyTJ1WidktJ1wuvCfBQBgO/zlimk82GFhBQGvin3cRglwva59Xe56xjc
	yPGrA7qTy5J4GgLFyPwmznffxMmBM+rO2Wm+Z35Jfzi8Xm9BopljcRlf2J8NxxAhfG4Sc7L0B/X
	Wquyslvm8uzMJr3rFiT/p2pvFW3UItOqiJapxOeqgEm5zvXEbzWS1ovfiNpvb4pbB+91prLzUYN
	n3RIz7N7XKVsAsq52wWFm1WwG7ypDKD2pCWfUPTIxz/N/OH7lrfg9LWF5RPBvdS1zypq2RT7lzv
	4PZa2Ke0kKPSENErHE7pfKEK8hAtfjNHI0o/jNhM+YOv2I+I1VrdnCZk5r+aoYZ9nD1gGL/t8Hv
	EI/qHECnNvij0cPQJyy7AG0q0hwWiPM0/X5n0Wgkja0qxMbkrqaGwoRtc1Ay3RcC/Hb4kjcUUbW
	uHjoE=
X-Google-Smtp-Source: AGHT+IGlwh2at04jRE6M2RZ6OHTL1b2HeV6Knx2fVNeRz/Ss7Jdcb7XmGTwDAoceA2g0QWjt2DGjgw==
X-Received: by 2002:a17:90b:3849:b0:32d:f315:7b64 with SMTP id 98e67ed59e1d1-32df3157da6mr1404877a91.31.1757685705728;
        Fri, 12 Sep 2025 07:01:45 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd632692bsm6515374a91.25.2025.09.12.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:01:45 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	almasrymina@google.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.co,
	mbloch@nvidia.com,
	leon@kernel.org,
	andrew+netdev@lunn.ch,
	dtatulea@nvidia.com
Cc: netdev@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH net-next] io_uring/zcrx: fix ifq->if_rxq is -1, get dma_dev is NULL
Date: Fri, 12 Sep 2025 22:01:33 +0800
Message-Id: <20250912140133.97741-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

ifq->if_rxq has not been assigned, is -1, the correct value is
in reg.if_rxq.

Fixes: 59b8b32ac8d469958936fcea781c7f58e3d64742 ("io_uring/zcrx: add support for custom DMA devices")
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 319eddfd30e0..3639283c87ca 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -600,7 +600,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		goto err;
 	}
 
-	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, ifq->if_rxq);
+	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, reg.if_rxq);
 	if (!ifq->dev) {
 		ret = -EOPNOTSUPP;
 		goto err;
-- 
2.30.2


