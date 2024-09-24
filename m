Return-Path: <netdev+bounces-129600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9AD984B5D
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 20:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A763F285432
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66A1ACDF2;
	Tue, 24 Sep 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QexDgS69"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8131AC89B;
	Tue, 24 Sep 2024 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727204205; cv=none; b=MR4zMWoB0ejKnlU5Of7Z+Hy3nrYZeXUZn/HD4CbfCVGyL93sbX9EVZXkUEUtiuAEYpoPsANNwNTiO80kGgO/oKLw2Dt9+okg1fR1WHxtmE3WfQ6mwgrOiaw3Zjz0/xwOMchXBLg7dwE9pUIdeEVZHxAFk+bx7uv8t9gJ2nuHJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727204205; c=relaxed/simple;
	bh=wFLt9rc4O/7yY6+mfWRmtwX1ysyWg5T6O/LDi8DovNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=maArkmfH+NxTRkRvJDXT/G8pZ+Pu7SsxaQSG+xRWNmuCl4MqcQFoTupWJimBoO6tOcQqwgzUyJ9f+k2nHfEBxrKimeKbljW2uHio+T2k+E3v6ur70ZMCIM11NBXtGrYVnBhUR7Tssecn0rTFk2lIX/BZHlJp+rQ22MgcX6Z5VCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QexDgS69; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so118044b3a.1;
        Tue, 24 Sep 2024 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727204203; x=1727809003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGWBFebmpJmV+R26c0gSC6KtxYqFu9ytlyo4h+InHl8=;
        b=QexDgS69Im07CYh/WUtXev26TUh0jKhmYenGBHBhdPxlJbnmK53oeGykhyCzNbllsq
         zXWC2sVI3FqqrRD50c5++9cTYOp1D3K1MJHkeX7uAZxurelvaF2cPFVRgsaEzCDQlIhR
         reoxsLf7k/1K78iVUakGetuGM/G8HW0Ha08atjrTPZMLHkN/B8NyIVdmgiML5EOXwfUX
         3xV+NhKZtK1evtiEJy4wIUVvlyzbfm2qEr9pfuC3xOA5/CNy/LMFPl8OrY8HnV2lGeb1
         SH8HNFdK8yBFiIrILwMQRVew0ACS8jy0fLuzK/9L2fSg5zTWZJEKKukvnKH2PalQySgP
         vM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727204203; x=1727809003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGWBFebmpJmV+R26c0gSC6KtxYqFu9ytlyo4h+InHl8=;
        b=i73Hy3sLwvNp17tvbs9vUHcPBfkcgWHN+OZ+7zqBp+UHTFTemJojIqCna/O3dTBN6J
         NKqX1ZMdok+JKiBLnfAmDeOA5A4XJSScwJck72o4BVXB+QeN33o/U6cyoMBy0S6OHzHD
         iz3PmwqwivgR6GKSn80WrtIqeYlJKWB1NlaAq2djkKefwvjIWJJB8KNC0FtO9FlKJu4A
         07gMLhhzgHSvEoE8jj2BmpQOvy8ic9dLxwS+9DvyVeWNyHToBbyrVSbXUvN+qpS4/d1X
         tytHdBcQO8QvsfN6mx0xpbjG1H+4UpGRiYdlDL4i0Ay5MmzHLeQgp+wJq3gt34g5blG/
         Lp6g==
X-Forwarded-Encrypted: i=1; AJvYcCUCM0Ckm271I4EtoGWCkGOjYUgctIytu6DJWXwOcLpi+OcxRuGZVsR56LqXeL+XoBMvkaY0ysUo@vger.kernel.org, AJvYcCVHcdtru0wB7weS6mw1jXH9cd3kh2msiAxFdY+xt/9nCj+7Tf9FPi06Zxkpsr9tyQA9XCPYBY69NzJn3eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbD5rj3HR2unIaSZuTZxmHAowtOajdtXFsPglFTkxji5ppSEb
	qMkPHpdXuFkwg31YQDQcYDeUJPsq0H9pM7nPXTM48iJIXKwEsM8S3lBoAvaN
X-Google-Smtp-Source: AGHT+IHAB1e9ZwWeTlYKqtVjDZLTkjbvhds4k0Z9YHj5Zj2Cdr3K0pjtv7WpkeDr4Kk4HYrI/Ey3xA==
X-Received: by 2002:a05:6a00:17a1:b0:706:aa39:d5c1 with SMTP id d2e1a72fcca58-71b0b21dda5mr288843b3a.8.1727204202824;
        Tue, 24 Sep 2024 11:56:42 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97c1f7sm1481932b3a.156.2024.09.24.11.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 11:56:42 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	f.fainelli@gmail.com,
	horms@kernel.org
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net] net: systemport: Add error pointer checks in bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
Date: Tue, 24 Sep 2024 18:56:33 +0000
Message-ID: <20240924185634.2358-1-kdipendra88@gmail.com>
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

Fixes: d156576362c0 ("net: systemport: Establish lower/upper queue mapping")
Fixes: da106a140f9c ("net: systemport: Unmap queues upon DSA unregister event")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v3:
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
index c9faa8540859..493702fdabc3 100644
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
+		return PTR_ERR(dp);
 
 	port = dp->index;
 
-- 
2.43.0


