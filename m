Return-Path: <netdev+bounces-249490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E58D19DE0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D63843007923
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B56838BDD0;
	Tue, 13 Jan 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RRnQjIO8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C936A02C
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317310; cv=none; b=H39y3LuIk7gVgo2nXi8qXeig97I+8t/h38kPk8axX478480lIxFvdlmOz2YCU6F3vgHLJWOJrVan/sVPEKiWjPdQ6upYKuCHoXqZNb8i8jAtgqL+vMcZKY/HPDYclaPGlbmzzUukDrxWEJriMWNOjZtnX9Tl0DTYGz2y+RbyXvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317310; c=relaxed/simple;
	bh=bcTVOO8/vCiYePb7Vu2f2AXRb9HXnGsAyAA8X84cJaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N4bjdjERgpWdmooP18hRFlxtdR9mG9DOlFHQcBh4MkEBBsT9C39X0uxblVo8+36rwLX+HV8N7Hav3hJ2+IxurnronCjNA68dsyuRKMupk9lx25Ppg/uu+OhuzaMwLQki2ApelIB3htY38jQo4D+y42CLBrQYFfM2q0hyvBVOGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RRnQjIO8; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so73657505e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 07:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768317307; x=1768922107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bEMT98k8iq5R+rKSzDQS7NpiqCNwYDuIMcmag2sytXM=;
        b=RRnQjIO8Z1+XjEcVl1fxSeSv3ORCXtw+ddsSGhqGPG/Tl8aoRjUZ5P4aQJS9WrQUGH
         CMIlRPfN0dU2CSnAcSwmk5Ft09j7HMV3BSJyokPrS+T2+TXN2YUDA7Qe41y9TCnJRP8w
         Se2Boq3nhNp0s0YDojPnaDsGiLpqmrkb+CsbL3sG0EbQn/vDYLLyQzHzu5/1MhyaCKNq
         bLsf820XI4eamsnYsdH+jtJh37V8X6lHizHGd2+i6OhwHaCJa+6enezAilUCxXvB8CVw
         nskTJnWvnQerJVNI3J4zvtMxtAOC0Bs9XlmUc4Sv6NfSJ9LC+yusx7IZtdFUf67P1Xyl
         CBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768317307; x=1768922107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEMT98k8iq5R+rKSzDQS7NpiqCNwYDuIMcmag2sytXM=;
        b=ivaLxq3jQV5ZlhHvN2Jz+cCxcV0nW9cV3YAoepGLV6+M9tC/8ic+S8ukoPINzeQRqU
         HvcjQfAS7UXQNTLQ6hLxg035EpcD2GchpPWkAOb3yeEXW7+F01/JAfJU0bwZax8CRDTA
         iufCkwdsVf+jsxrUZHEXFiiME5PRldQpt5o+Jr2zPM/uxw48qCjBBTKQzsHTaLSJ1zlQ
         IdFUvFNBxd2PzF2dhjQAS8KUsglLBORz/WnfvCPnNbmNlwBSgLrbpRbtRySy9Q/ZiZ4s
         ze9zTs4mSH/KrLralZH8hUFWU69ALogn5CTKFaFX2yUAPt4tC1VhIN6d7pSgdqO6ajiv
         OfDg==
X-Forwarded-Encrypted: i=1; AJvYcCWSlIVUJRnld6ORXF5mo+ELgZXkTefGUkoCjlKnLUypLufKSNQOXJ29nrpJGRsNiW7f2WqKKSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykFLw7/c+PG3HiT15wCC3RcfGxhcAH6U5JiBOH7V/3QZjo4uLj
	N7Yih6b9hHcf6N05DjI16XBhx7FbDkHr+dN8DGp1VXk82n+RrENn7GUjC1ALxGRcO80=
X-Gm-Gg: AY/fxX5VlxgONAYE3Ag5WGtH9SFo6tWd497iC1h6jOMb5YXlRWG3JtqQyyDhBUOVJKw
	G1eZ3rCOfPphikTpPclWEZ748FayBG/xarAuYZ+oIkjg70JHcwgef7kt/98mAxyHP3tSkbEnfyU
	kBULYGuzX3pE7dX+4J2OjOylAmkM7dovyO82Q6YpR4/zfeAvuVLGUPuHNR7h/oTQO1gSdQhCRm5
	ybESmIFLpt2sqFzaeLP3jYFFPTMPKDgBDpjlTjUC8VauGFxGNfsvJsbDPzHmtGJLri2FMbcAVYW
	rxlhW6f0Lx+guwALE8aa5GC9V/IgSyIdF9V+BA4vh2xtgQZA5i1ASZDjMMhCY12CuLZ3nKaflTC
	DCildW1l8mLkF2QdL2UsBVdim//Y6hmdjLcifswWz9LO/fzBNI7ZfkJTwTyKKn9AN5ZlvKXwYak
	j6u6Yijq6mh9XiMNoAsT97Z0b5zylZ1+4vAh0=
X-Google-Smtp-Source: AGHT+IHzLadLrCzJ0IARYGYOL/uQU0nIwi5HkbDAdynsruHgRkEKv8POOYNOWEncAXJ9lrsUEtZCiQ==
X-Received: by 2002:a05:600c:4685:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-47d84b41bcbmr256430415e9.29.1768317306872;
        Tue, 13 Jan 2026 07:15:06 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm44713407f8f.29.2026.01.13.07.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:15:06 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Fan Gong <gongfan1@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] hinic3: add WQ_PERCPU to alloc_workqueue users
Date: Tue, 13 Jan 2026 16:14:33 +0100
Message-ID: <20260113151433.257320-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

In order to keep alloc_workqueue() behavior identical, explicitly request
WQ_PERCPU.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c   | 2 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
index 01686472985b..1ecc2aca1e35 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
@@ -655,7 +655,7 @@ int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
 	hwdev->aeqs = aeqs;
 	aeqs->hwdev = hwdev;
 	aeqs->num_aeqs = num_aeqs;
-	aeqs->workq = alloc_workqueue(HINIC3_EQS_WQ_NAME, WQ_MEM_RECLAIM,
+	aeqs->workq = alloc_workqueue(HINIC3_EQS_WQ_NAME, WQ_MEM_RECLAIM | WQ_PERCPU,
 				      HINIC3_MAX_AEQS);
 	if (!aeqs->workq) {
 		dev_err(hwdev->dev, "Failed to initialize aeq workqueue\n");
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index 95a213133be9..3696ab3f1a1b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -472,7 +472,7 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 		goto err_free_hwdev;
 	}
 
-	hwdev->workq = alloc_workqueue(HINIC3_HWDEV_WQ_NAME, WQ_MEM_RECLAIM,
+	hwdev->workq = alloc_workqueue(HINIC3_HWDEV_WQ_NAME, WQ_MEM_RECLAIM | WQ_PERCPU,
 				       HINIC3_WQ_MAX_REQ);
 	if (!hwdev->workq) {
 		dev_err(hwdev->dev, "Failed to alloc hardware workq\n");
-- 
2.52.0


