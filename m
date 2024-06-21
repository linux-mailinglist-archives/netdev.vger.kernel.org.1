Return-Path: <netdev+bounces-105787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03192912D57
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC981282C15
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF8517B514;
	Fri, 21 Jun 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPNXpIwq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C646D17B4FA
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995222; cv=none; b=sAV/XhtO7joAbPwIlAmH0fwTo8ggAUhEIpam05zzU0cvDZaoXV7jQCvGQxM9TxLWqAGmNVvDaERuP+cWHvgAOyF+sEjZMktEmqHGbLzYWvmW/nXGOFUNX2DNHl9aRDC70+i5M1aMIBbonlUtVQJxhbjaKECBkQppwfR+QfefKuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995222; c=relaxed/simple;
	bh=i5I8aG+aYcWEncWeF56dW54t1OzqXvJqCOlfAieN1cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ap59YniIp6VLFcphrOvKFSsJ4VS1Qg14IdL+6KmoISrEXGBwcuzuJWAfa55Yh3kmRGZ7rt7CP/iOyqjycrSCJeKM5GsbxC6yusfS1BKBmXMKU4luXWWrouwgQ6UQyJX/UwfBHvS/WoXXjCfpSowNbsQ6cAYmga6GwTUbXeiILSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPNXpIwq; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3761f8d689fso9490655ab.3
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995219; x=1719600019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSOLAIhMr7ucmgYUhEqNv7YbAkTdXAs1lqXyxcdm0Hs=;
        b=gPNXpIwqjXeNy3/JGgTqMUotkXuIx0zfhAiX9WqHA0EMVFyNryiHDSmZV2k8jYuWso
         nXqhYbOjDMxPok99rmJiieX5X0S5bukOHfBqvFei7gXDc83xXQeR7rvkBTPbwl5VisJc
         OIwracxBkoTvs9g9QHSnr2m92nx6FA1D0faSYH8HKYviMzUmS71ypIRdTl42pasa6exM
         ccQYccNKmVpw3dYHRoSXE8GdONdFR0Yf02cG0LsaEP/TmAAG9DD3Jcv6g+tQz8Pzkky7
         bw3yOq+/UQcZemifqSZWhRgq7/+Sl6mm0sHj3bCcaS5Lum0mJzkla7y/JGP0hAnNrbfP
         IhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995219; x=1719600019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSOLAIhMr7ucmgYUhEqNv7YbAkTdXAs1lqXyxcdm0Hs=;
        b=EHOon1/JIcjW8tHAOjgSIvOB+qCJE6vl7h8JMmc7R2iZVjjOzJyA6g1rb+FdzVTXK5
         iuz+7OSpw/qbwZtiHij8DuTuqk6QxgShmWE/sE/IcG9fkB5aPgHpnz+rySrwFkwhym89
         TrL4FyiSbxkVUfOBWtsa8C8Knq6xtQHNTynab74dmYvJdxLOtIiRx/aDPu8m32BbxA2k
         cumaiEeFN3UphXfjF/qsyM4ijw5eZZIsfc/khPH6pZDz/BejjGcOutCd23cRnRzD6puf
         jVKCRobJJNJd3dlGlf8tZNbr6s/bKgo159disCm2WFLbiqaDw33W9CDSsFnczk3v6AfM
         v2eQ==
X-Gm-Message-State: AOJu0YyBjJ2KIjWdxUVLC3UtTEAaRMtrlHw0Cff14lD7XnuMDkEGkBsT
	KbocENHUtb64cTMtNjvj+I1DrYxHi67G9I91LfEvmxMHRKyrVjprVGfgYA==
X-Google-Smtp-Source: AGHT+IH7mtiH7zn+G37BGLbxfFz2j1dHcyalO6XbKa8S55ubu2WiXL3zNAkydnoxGh6wkV6PbM2kbQ==
X-Received: by 2002:a92:c241:0:b0:376:11d9:8ee6 with SMTP id e9e14a558f8ab-3761d4bd67cmr105014065ab.0.1718995218771;
        Fri, 21 Jun 2024 11:40:18 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:18 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 06/15] net: octeon: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:38 -0700
Message-Id: <20240621183947.4105278-7-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621183947.4105278-1-allen.lkml@gmail.com>
References: <20240621183947.4105278-1-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate tasklet APIs to the new bottom half workqueue mechanism. It
replaces all occurrences of tasklet usage with the appropriate workqueue
APIs throughout the cavium/octeon driver. This transition ensures
compatibility with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
index 744f2434f7fa..0db993c1cc36 100644
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -13,6 +13,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
+#include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <linux/if_vlan.h>
 #include <linux/of_mdio.h>
@@ -144,7 +145,7 @@ struct octeon_mgmt {
 	unsigned int last_speed;
 	struct device *dev;
 	struct napi_struct napi;
-	struct tasklet_struct tx_clean_tasklet;
+	struct work_struct tx_clean_bh_work;
 	struct device_node *phy_np;
 	resource_size_t mix_phys;
 	resource_size_t mix_size;
@@ -315,9 +316,9 @@ static void octeon_mgmt_clean_tx_buffers(struct octeon_mgmt *p)
 		netif_wake_queue(p->netdev);
 }
 
-static void octeon_mgmt_clean_tx_tasklet(struct tasklet_struct *t)
+static void octeon_mgmt_clean_tx_bh_work(struct work_struct *work)
 {
-	struct octeon_mgmt *p = from_tasklet(p, t, tx_clean_tasklet);
+	struct octeon_mgmt *p = from_work(p, work, tx_clean_bh_work);
 	octeon_mgmt_clean_tx_buffers(p);
 	octeon_mgmt_enable_tx_irq(p);
 }
@@ -684,7 +685,7 @@ static irqreturn_t octeon_mgmt_interrupt(int cpl, void *dev_id)
 	}
 	if (mixx_isr.s.orthresh) {
 		octeon_mgmt_disable_tx_irq(p);
-		tasklet_schedule(&p->tx_clean_tasklet);
+		queue_work(system_bh_wq, &p->tx_clean_bh_work);
 	}
 
 	return IRQ_HANDLED;
@@ -1487,8 +1488,8 @@ static int octeon_mgmt_probe(struct platform_device *pdev)
 
 	skb_queue_head_init(&p->tx_list);
 	skb_queue_head_init(&p->rx_list);
-	tasklet_setup(&p->tx_clean_tasklet,
-		      octeon_mgmt_clean_tx_tasklet);
+	INIT_WORK(&p->tx_clean_bh_work,
+		  octeon_mgmt_clean_tx_bh_work);
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 
-- 
2.34.1


