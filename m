Return-Path: <netdev+bounces-179775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5123A7E810
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A10B17667E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B77215F6C;
	Mon,  7 Apr 2025 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoCVB0Qy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA66216399
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046531; cv=none; b=bpO4VVrKpii3MycoL//a6tF7gO5pFtO7C3FKqtxdK/qU+Xod1/kcKNmAikxO9ehZxaO4VdCwYgjhQT6GGwBJRQCMSgqpwrm1w8g7DA/M7mJZrYAQ7Y8paEnk3/mXNnomQQAVuu6X9m+ftR0NRRrDgW8BWO2u7LDHJ06636HgvaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046531; c=relaxed/simple;
	bh=8oeH2eTN/SsR6cjtxPQTBFplLu4gegab9TFpU/zkbvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiZx4psOe6bUaKUSmkoUf/DFuwTXTV5aWfiDi3DVns+Gq94jFaO4OZR8GD8UTDpdwJgazdG4m6WVzmZ5VzsLOg1RILZkIcGDDLufgRACUdSEcb8gQ6Xf/jjdKs3bfY0rIjZnYeKZTZpviufXxNLvx3lq5IaplJSkCHq0AjRvzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoCVB0Qy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso50713495e9.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744046527; x=1744651327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1IZVqO/gI0/m4wokh/WGCWMOC6QAdPUriLi7mi3EUs=;
        b=HoCVB0QymXQq2N6ii+yAFYicWzPupXa2T40tZ2P3ZEnr1R7qE30jdFs4N4QKDDpwOR
         FPdNVP7VJrXxPD+arNuBU9QQvm4sSFFYK6mOO8EbJRkKWBW7sx46hBNpASolBc7mhvhk
         vLthuo6PCJcBFKu9xfe/g0C0XjThAnviyW6hjhchVaeHy4MoJGrWvAREzzxoSp4EgiEn
         v/g0puQo9cAesJl8fBlhSGFu4Voh0SkqoXR42/J3RIDhXLf5tzKaiRKxNQcVRUuCSYX+
         uYgNCfM0KIHVH4xZSX5+T6RwaE/LKC/PB06GDjhUMxILKzI/fUPVknYd4S+3TPUvS7ca
         /SXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046527; x=1744651327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1IZVqO/gI0/m4wokh/WGCWMOC6QAdPUriLi7mi3EUs=;
        b=d7yc7hXmYCL57WLaE1w1FaM5z3KyGMVKelGKefh1v82hBKMvyC1z/jl3gOOYaWwrvq
         q5+o1wopncXg5KfrJ3j3Vzq4YIFwdFQ/vDIOZ+GMuR/ZTeNsY/wdRfZ58yrUWJ4YV9wa
         5wC3A6GYWULf3ab9yGk6Mv5QuNfWvRWtrS2QgaGTSQtAFsPn4xkdcp8xv+PPtUD3Gltt
         KhNEkHFGTtcIokujmZl4l4f69LLkeRBpBGkLX362RwQUwRKGnql8rGNDwqH27jxh/LU7
         YJcSUvYOW24eUF3fbzza64DiL/pI6SoaGNP6LonX3EsFi3yAF0r67PymZKlqjmT1JHhz
         +lVQ==
X-Gm-Message-State: AOJu0Yw4sWZOdeH+r14EeUm2WbF/mhvgu2XluqbtwE3qcpz2EDK4UIFz
	g4/iXYsM4MwLsotjme7sF32EtS4CTxchymA6O63k+Ib60k+TFL44JmVSRQbO
X-Gm-Gg: ASbGnct44uOiA8XbeF8VqHQSX+B0EA5lMz0j8uNd2FaP8Ew91czZ/ogSLN5fZVrrjG/
	HCO5dHNwP42FOPR5/SEXgZ7U3ZNRxebkjVCrUa0v0iMuOQGiLIbQk8JNr3dzobAW87o7+2YmZL8
	JdBDbfPGiZdgGy6JJwUL5hHhGM3dYS5joIVBEK75ZNRigKZVUky14UTjVZgzJKsBCJsKZg8GyOm
	n+klxRM0Av6Twl0lmO5m5finY58vrHmRJBzASj+4yhwWqNkhvaPpRz5vokAFA8lUKBOp2FK8Qe8
	fZi279kIrbIDnsM+yr3a2LB8CoZmLP4mwlsbRkNRoCo=
X-Google-Smtp-Source: AGHT+IEvfLqcc8ru7CbJhe5bpTLPK1r6RUB5UZkahrUSZgZKx9gkUjRpdsRHB3J65JOus7TSE0YCOA==
X-Received: by 2002:a05:600c:1e0f:b0:43c:f332:7038 with SMTP id 5b1f17b1804b1-43ee0769282mr67485385e9.21.1744046527300;
        Mon, 07 Apr 2025 10:22:07 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:50::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec3429f67sm141702765e9.7.2025.04.07.10.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 10:22:06 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	suhui@nfschina.com,
	sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next 1/5] eth: fbnic: add locking support for hw stats
Date: Mon,  7 Apr 2025 10:21:47 -0700
Message-ID: <20250407172151.3802893-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250407172151.3802893-1-mohsin.bashr@gmail.com>
References: <20250407172151.3802893-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds lock protection for the hardware statistics for fbnic.
The hardware statistics access via ndo_get_stats64 is not protected by
the rtnl_lock(). Since these stats can be accessed from different places
in the code such as service task, ethtool, Q-API, and net_device_ops, a
lock-less approach can lead to races.

Note that this patch is not a fix rather, just a prep for the subsequent
changes in this series.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h          |  3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c | 16 +++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c      |  1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 4ca7b99ef131..80d54edaac55 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -81,6 +81,9 @@ struct fbnic_dev {
 
 	/* Local copy of hardware statistics */
 	struct fbnic_hw_stats hw_stats;
+
+	/* Lock protecting access to hw_stats */
+	spinlock_t hw_stats_lock;
 };
 
 /* Reserve entry 0 in the MSI-X "others" array until we have filled all
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 89ac6bc8c7fc..957138cb841e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -203,18 +203,28 @@ static void fbnic_get_pcie_stats_asic64(struct fbnic_dev *fbd,
 
 void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 {
+	spin_lock(&fbd->hw_stats_lock);
 	fbnic_reset_rpc_stats(fbd, &fbd->hw_stats.rpc);
 	fbnic_reset_pcie_stats_asic(fbd, &fbd->hw_stats.pcie);
+	spin_unlock(&fbd->hw_stats_lock);
 }
 
-void fbnic_get_hw_stats32(struct fbnic_dev *fbd)
+static void __fbnic_get_hw_stats32(struct fbnic_dev *fbd)
 {
 	fbnic_get_rpc_stats32(fbd, &fbd->hw_stats.rpc);
 }
 
-void fbnic_get_hw_stats(struct fbnic_dev *fbd)
+void fbnic_get_hw_stats32(struct fbnic_dev *fbd)
 {
-	fbnic_get_hw_stats32(fbd);
+	spin_lock(&fbd->hw_stats_lock);
+	__fbnic_get_hw_stats32(fbd);
+	spin_unlock(&fbd->hw_stats_lock);
+}
 
+void fbnic_get_hw_stats(struct fbnic_dev *fbd)
+{
+	spin_lock(&fbd->hw_stats_lock);
+	__fbnic_get_hw_stats32(fbd);
 	fbnic_get_pcie_stats_asic64(fbd, &fbd->hw_stats.pcie);
+	spin_unlock(&fbd->hw_stats_lock);
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 6cbbc2ee3e1f..1f76ebdd6ad1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -292,6 +292,7 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	fbnic_devlink_register(fbd);
 	fbnic_dbg_fbd_init(fbd);
+	spin_lock_init(&fbd->hw_stats_lock);
 
 	/* Capture snapshot of hardware stats so netdev can calculate delta */
 	fbnic_reset_hw_stats(fbd);
-- 
2.47.1


