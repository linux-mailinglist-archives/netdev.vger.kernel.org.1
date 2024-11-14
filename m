Return-Path: <netdev+bounces-144851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F469C8920
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E211B28512
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0BD1F8935;
	Thu, 14 Nov 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CT/u12MC"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D471F9424;
	Thu, 14 Nov 2024 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583588; cv=none; b=LnMYimwYGpuPMooytkIpXmS+YHTtXRQmvTJ9ogjdNY5iJVL54VYhWIL2mY60a0pnTTScFp0qRFcFF6BuYAfvqP6sA2wgDlo9s6etzm8NwQvgJjijK4CeiMz0YVZ5ULfdMwOV5d7jSkyCIc26coW6UPXp9IJmbH5V61+jZeABz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583588; c=relaxed/simple;
	bh=lsGpQKM8frLFe7nCknwME+o1eqdXv5hBX5iiVZiRjrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYMswi1llMiiZGYiC1UYTEHhfhI4z98GQrfghhSG7SKERGKhCzXvbls4S1AGI1XX9CdoaqZuVUYbfK6iPb8ZZrKGm6KHCllgtWC2ZZIK9kvyp0xfQ1InAEduAeYFPpXqn3pOg/sHNqm55SLSMTK0+UJLVECZgelQA8fCsCwcS3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CT/u12MC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AEBQAxrC2914440, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731583570; bh=lsGpQKM8frLFe7nCknwME+o1eqdXv5hBX5iiVZiRjrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=CT/u12MCsrT2aDwlb9Axb8P39wQ2DG/xUVmEQ9ZG4StZ4ZCYOSk7u75zxUW1Sdjj5
	 eI854UE5nNprsbdQ46LXQ2dvq7WfJV9QeqeMpX6MaBN5pv/t7PVyXSRAoNFfx6wsjs
	 04JsZKtowISivqCjc2RFSavxAmTaVHnVTIKHXOa/x7PAkU3GSiyG+gWJShRGy2ULrX
	 mjKIn5iAgPkMtr8qz3d4BSnZIy7o8/L+cpTjP57W1PK7VtTd3+KpLG2+VDI7a0ZSDz
	 +dFjqAvhLv1LiOG6Jxu94y+yp52wRtXhB8I0tuRsGT5JfY/+2K6TxfCDIiyx6Yu3UY
	 wzGLtfFd4htLw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AEBQAxrC2914440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 19:26:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 19:26:10 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Nov
 2024 19:26:10 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next 1/2] rtase: Modify the name of the goto label
Date: Thu, 14 Nov 2024 19:25:48 +0800
Message-ID: <20241114112549.376101-2-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114112549.376101-1-justinlai0215@realtek.com>
References: <20241114112549.376101-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Modify the name of the goto label in rtase_init_one().

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index f8777b7663d3..874994d9ceb9 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2115,7 +2115,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 	ret = rtase_alloc_interrupt(pdev, tp);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "unable to alloc MSIX/MSI\n");
-		goto err_out_1;
+		goto err_out_del_napi;
 	}
 
 	rtase_init_netdev_ops(dev);
@@ -2148,7 +2148,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 					     GFP_KERNEL);
 	if (!tp->tally_vaddr) {
 		ret = -ENOMEM;
-		goto err_out;
+		goto err_out_free_dma;
 	}
 
 	rtase_tally_counter_clear(tp);
@@ -2159,13 +2159,13 @@ static int rtase_init_one(struct pci_dev *pdev,
 
 	ret = register_netdev(dev);
 	if (ret != 0)
-		goto err_out;
+		goto err_out_free_dma;
 
 	netdev_dbg(dev, "%pM, IRQ %d\n", dev->dev_addr, dev->irq);
 
 	return 0;
 
-err_out:
+err_out_free_dma:
 	if (tp->tally_vaddr) {
 		dma_free_coherent(&pdev->dev,
 				  sizeof(*tp->tally_vaddr),
@@ -2175,7 +2175,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 		tp->tally_vaddr = NULL;
 	}
 
-err_out_1:
+err_out_del_napi:
 	for (i = 0; i < tp->int_nums; i++) {
 		ivec = &tp->int_vector[i];
 		netif_napi_del(&ivec->napi);
-- 
2.34.1


