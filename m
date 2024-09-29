Return-Path: <netdev+bounces-130209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8874D9892B6
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 04:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D310281C58
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 02:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9C918643;
	Sun, 29 Sep 2024 02:37:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A117580;
	Sun, 29 Sep 2024 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727577461; cv=none; b=gmOnCSE4WUBae3MdhAb3HSEvysduYalJUTaRAPhG71YH4fd7xPT25fEXUAkBkJlIdzECK7FsnZ8nl1xdfBJONXrV8iZT4K7zSY9mWfZVYf+5wnAcIMRgmEqyT3ECoGUsNTPxh6sxBvPAuDNOHI0MT/xjGFrg8qs8eiDmQm+FEwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727577461; c=relaxed/simple;
	bh=BC5G+eTcM5dQ2qI4tRZTbc6C1HLgSCR8KsMitCrqfnM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=roerI+y9M53azF7Wc4vvVEZahClGaoEun00OG88hD53kqf/Q1nxGkldWxrmaAwpCmyC/GyYOxb/j5T3WM4bKaPvsDkT9PdzYcuVNLnXXaaWwuvw70Pv/SAsjMXqpw77SeyxSzzBrcdmFVc82NEbwsSjGgR87N2ew2clWyAl7H6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id ZBO00025;
        Sun, 29 Sep 2024 10:37:25 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201623.home.langchao.com (10.100.2.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 10:37:24 +0800
Received: from localhost.localdomain (10.94.12.73) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 10:37:24 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <m.grzeschik@pengutronix.de>, <davem@davemloft.net>
CC: <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] arcnet: com20020-pci: Add check devm_kasprintf() returned value
Date: Sun, 29 Sep 2024 10:37:21 +0800
Message-ID: <20240929023721.17338-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2024929103725add1256462f350b8bb3094b565fe72b7
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure but this
returned value in com20020pci_probe() is not checked.

Fixes: 8890624a4e8c ("arcnet: com20020-pci: add led trigger support")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/net/arcnet/com20020-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index c5e571ec94c9..6639ee11a7f8 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -254,6 +254,8 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:green:tx:%d-%d",
 							dev->dev_id, i);
+			if (!card->tx_led.default_trigger || !card->tx_led.name)
+				return -ENOMEM;
 
 			card->tx_led.dev = &dev->dev;
 			card->recon_led.brightness_set = led_recon_set;
@@ -263,6 +265,9 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:red:recon:%d-%d",
 							dev->dev_id, i);
+			if (!card->recon_led.default_trigger || !card->recon_led.name)
+				return -ENOMEM;
+
 			card->recon_led.dev = &dev->dev;
 
 			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
-- 
2.31.1


