Return-Path: <netdev+bounces-129796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B455986472
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 18:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADA06B242B4
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 15:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F734DA04;
	Wed, 25 Sep 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6sXXIIn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18A4965C;
	Wed, 25 Sep 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278176; cv=none; b=QFRKTYPBIO8AO7YKvvRow+ihSqQY16f51d084+X2vSP9mzPbusTjC7Q3PCtwVhjguDr04HK+1nzvvR9JL+9ddPYQKkJiGIDkYB6Va33jbAIS6sPbxDAeME18N0/2CjPZCXEtn3TaimUuVr6s0ysFmSk7dtY5tQ4KuAkoe02tXuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278176; c=relaxed/simple;
	bh=ZPCIQyJa4hUS29owAoNSLS+PtPd2BaRoOny2y7TOmyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rrgVXUW0JT1IgOsbvmN0evM1JJLMmK/qiSC7B7Qiw92TpZBZfZJhWLe8qYcfAeJha49/j4q8LT/EJZt+pgGu88ChYeywclYwF7m/XZ/DDR/u8sjybMQGgJa7v0T8DMsh3Gz/kIUHAE8O1LG1uWuDBLUjyD7e7cPeLXfVd5Wja8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6sXXIIn; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e08085596eso10477a91.3;
        Wed, 25 Sep 2024 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727278175; x=1727882975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjOFFlZfms+DGD3ltRjSZJdWHLDREDpgJKaPRQrx/p4=;
        b=M6sXXIInkKUM0wyafR6RTpvwv9NuIudRZWFCYnGwOmE1Ss2xOoB9Tj08GxtgNqoIZV
         ZancwvxD8Ai4hZt/6kk+Pu2BP2kHFUIDXEl+PFe+mua/8e/2EKg5zAtWDczvMVGmZcu+
         rZPKbSnoaQQXtIRKVve6Cqwk+aGdoTOOx6miKMWycjBTejQFb7sNYFCkhd6wW2sZdrHL
         jcxkL5pT8+vuq7D+/Ee1QD5XxgHRfO7GYbqolaLewSGkTsmRwarr2iewxxC7T1lxb7IY
         dEp13KMqmLo2ChNElApT6NWF/VUPsE5IXO52QYPhsENIgCjlqVs4lhOnLuUi32YershT
         HSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278175; x=1727882975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjOFFlZfms+DGD3ltRjSZJdWHLDREDpgJKaPRQrx/p4=;
        b=Wcr4KH08QTQ5b0qUYhezNj1p1kU4PtZD5w3271uxKtzNNX9JZ5nlywWx73sYKeeU9b
         L8srKg5r0AShYEmTCDvswXdxieJaY2dm9jwnjvh2azCsP3ye/2EgEkp8Q3I6dSBOkEyi
         rN+cuo7Z2Omf+/5BaFCl/qdhTz0o0L1V0+QK1k2AnIgNbQlkUSgyBnSdQemEjO08OzTT
         y3G5yOs/rPV3xQ5OZF85gPpGZvTXZAzY/s3PrGVDk7n0GSuv9i8zzzRZbFphuU9z8eol
         /FYNGBk21KQG3T+C5KJbC1qDuQoKFZi2VTqJ5gU00S5LB1xmCIbDGKNSyOd3YlsT6T0Y
         8Wvg==
X-Forwarded-Encrypted: i=1; AJvYcCV2cDByzTaVsr3pFXRu7dndQySv84Im8yGqgXLB6pE7HGrLyS9mL7Byr6NglIWG9XmBakpv/gSCsJQc8Fo=@vger.kernel.org, AJvYcCW5pVxwg+NdZyOKyH3J6KEYNm57TZKVKnHt+W0YKPglYHxx5VZ0FiWCOrO/yJ4FmrMZn2tgyaj1@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+/l89mYMfVfCi5QXnVxgStLOfG9UWNcmSUu0jDwHuCSEupTI
	cop0R7AszdUfNi4w8l0MYQqiZ4DA2Ffem7GFt9ad7d5vDY7mQ/CE
X-Google-Smtp-Source: AGHT+IF2n/pZzuJf3ILJ/wFDngHMPon+mXfqXiSpi5nf+X5DKMiNt7n69hH0g31Ve+jUSMiq95Vw8w==
X-Received: by 2002:a17:90a:2f45:b0:2c9:321:1bf1 with SMTP id 98e67ed59e1d1-2e06afebdd0mr3671689a91.39.1727278174669;
        Wed, 25 Sep 2024 08:29:34 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e2d7001sm1651580a91.44.2024.09.25.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:29:34 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	horms@kernel.org
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4] net: systemport: Add error pointer checks in bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
Date: Wed, 25 Sep 2024 15:29:26 +0000
Message-ID: <20240925152927.4579-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error pointer checks in bcm_sysport_map_queues() and
bcm_sysport_unmap_queues() after calling dsa_port_from_netdev().

Fixes: 1593cd40d785 ("net: systemport: use standard netdevice notifier to detect DSA presence")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v4:
 - Removed wrong and used correct Fixes: tag
v3: https://lore.kernel.org/all/20240924185634.2358-1-kdipendra88@gmail.com/
 - Updated patch subject
 - Updated patch description
 - Added Fixes: tags
 - Fixed typo from PRT_ERR to PTR_ERR
 - Error is checked just after  assignment
v2: https://lore.kernel.org/all/20240923053900.1310-1-kdipendra88@gmail.com/
 - Change the subject of the patch to net
v1: https://lore.kernel.org/all/20240922181739.50056-1-kdipendra88@gmail.com/
 drivers/net/ethernet/broadcom/bcmsysport.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index c9faa8540859..a7ad829f11d4 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2331,11 +2331,15 @@ static const struct net_device_ops bcm_sysport_netdev_ops = {
 static int bcm_sysport_map_queues(struct net_device *dev,
 				  struct net_device *slave_dev)
 {
-	struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
 	struct bcm_sysport_tx_ring *ring;
 	unsigned int num_tx_queues;
 	unsigned int q, qp, port;
+	struct dsa_port *dp;
+
+	dp = dsa_port_from_netdev(slave_dev);
+	if (IS_ERR(dp))
+		return PTR_ERR(dp);
 
 	/* We can't be setting up queue inspection for non directly attached
 	 * switches
@@ -2386,11 +2390,15 @@ static int bcm_sysport_map_queues(struct net_device *dev,
 static int bcm_sysport_unmap_queues(struct net_device *dev,
 				    struct net_device *slave_dev)
 {
-	struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
 	struct bcm_sysport_tx_ring *ring;
 	unsigned int num_tx_queues;
 	unsigned int q, qp, port;
+	struct dsa_port *dp;
+
+	dp = dsa_port_from_netdev(slave_dev);
+	if (IS_ERR(dp))
+		return PTR_ERR(dp));
 
 	port = dp->index;
 
-- 
2.43.0


