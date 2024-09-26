Return-Path: <netdev+bounces-129992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D595698773C
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 18:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1002E1C20AE6
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A95158550;
	Thu, 26 Sep 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjSHFzFV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576F158552;
	Thu, 26 Sep 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366724; cv=none; b=ZxUdQe/v+hYJTkgZIFwB9/19UuTi+2KFB1tuB44eNx+BSWy9JjR9uswxJPh3VhNfMrrYjE8E9EUjOFymM5u9zzlhL86GKLGM3RdSAlgY9dEUjIzteioTrTIoexqLzN+oiaa7BhWpIgWu+nImSv0smE8cZjBRMFM0QaFqKuW/jYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366724; c=relaxed/simple;
	bh=gknbzGZxjpw2CXS/PQNahlHmXMU1BTGcOerm6JEQ10A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lI6qT7tiHhzd5h7SGu4hCjjq/6jFHMNA7yfXfDAQdGsATmFH6ynvpLD3RT7kX50L2QIclMNVQ9aA35yR7QALIy/pH8qlCLBVrB93LbcBq7hQTNHof5TS48zpiZcXU2Ljz1DeXnnKZ1orrXsmoj5IefPvd08VoOkpEdSI5elT7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjSHFzFV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-205909afad3so11550465ad.2;
        Thu, 26 Sep 2024 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727366722; x=1727971522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2pa/TWuTtJPirDcDBc/YlDUH5VGKlyuUuv6pDARm7Hs=;
        b=KjSHFzFV5SfBbcMmqYOyBsQA/MaJMa283MBWuZvbOig230RfSXQ8zKCCcwEkjaYVyV
         ZHQRJ5D2PMTnG0mz+Wp4kuE/I4QW4LmjKdslmilaBEM3pA0iz8BiT67kst2zWZJtiomD
         7pEae+ccTxuzxiS74e/+5SZWqnl8VRSq4lzBGPLqHqI7FRIEKlyHWHjJgo9BYc+kJn3T
         RcY3qDjBYaU6X/4ajMBiZ6/dcIhJh3X0GAcryjOOzqBHCnhuBEgyXyc/64ks/W0a+4tV
         okcoLU5dkPVPupLLplc9TRlzJbYy7/sgQ0gp+WME0PaH00DD8aQFKR3miDzuMvaWVn20
         OuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727366722; x=1727971522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pa/TWuTtJPirDcDBc/YlDUH5VGKlyuUuv6pDARm7Hs=;
        b=a2eY/CiJDS+AciQlaBtCrub7Fgo/EW7nVZsyS682rL9T1zqWyOpOAlzDJMQOYhX/lC
         6HtBefQpPvOuMaL/4z4hIcrs2QlWLQZI/N/wEvHW/ZgQD6jQH10sWjOG+5CUmaVai5ya
         tuwOydIAvgi4/VJXTZ4Wd/QUTT5mqtA3ZyG+iU1wmI6cr/hkXKf5EE91xB/PPYsSJESk
         /YXwcew+rj4ft5df7rmgtLehg3r9DCSrJ+XfUOQHg8PsJhM+VQiU7ZJ0RrQaF4dIKDMT
         32b2lIeRrLv3DlCFgwvTwHuifgT4uVSvh0+ZNiw5h9wTW5TkRCD6rCilT5PfpHJFqX3W
         id6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkGo1cvQzWkyxh8HAiU1TfF98xHJSK13E48k8f8lXsFj6g3oe7ZYxGX90iFIJyJNQjM6P+bKkE5KhUViE=@vger.kernel.org, AJvYcCXVfMxw0PB4PI3+wKCJHtfWUhiTiZQrqo2HYDoGJc3PAA5uZITq8IkBFDMc6w3/9slDMaNuhd6J@vger.kernel.org
X-Gm-Message-State: AOJu0YxL8AHZUfDilyMYNHAsESqkrTOcw+7MtMSnLiPYpD88wRZ24pFQ
	eqjhzf6AgSdZyZqZ+IfTHsO/4DYpYMKwCIHxDV0aws/staLNV6eI
X-Google-Smtp-Source: AGHT+IE5QvZjfX4FN9dhLCk2nP5iL8ta9IysDy96i4ZfL3fey/npuCinZULm9eTYn8V2G8lVAJtBTg==
X-Received: by 2002:a17:902:eb8a:b0:206:adc8:2dcb with SMTP id d9443c01a7336-20b36ec98c9mr2523255ad.25.1727366721677;
        Thu, 26 Sep 2024 09:05:21 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e61e14sm224295ad.279.2024.09.26.09.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:05:19 -0700 (PDT)
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
Subject: [PATCH net v5] net: systemport: Add error pointer checks in bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
Date: Thu, 26 Sep 2024 16:05:12 +0000
Message-ID: <20240926160513.7252-1-kdipendra88@gmail.com>
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
v5: 
 -Removed extra parentheses
v4: https://lore.kernel.org/all/20240925152927.4579-1-kdipendra88@gmail.com/
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
+		return PTR_ERR(dp);
 
 	port = dp->index;
 
-- 
2.43.0


