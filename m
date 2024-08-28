Return-Path: <netdev+bounces-122625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B5961F97
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 08:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214681F2404A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 06:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124C5158D80;
	Wed, 28 Aug 2024 06:20:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E43A8D0;
	Wed, 28 Aug 2024 06:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826002; cv=none; b=u8N6ZulGmCcQ3KdqqQpS7McBZTGXCqS1cdsg7xF8iIsx2ZS6m7EBXR5W7G8y1TGu7IJqLsIwpK46M58wxoKBTSYoEemWjaLBAO37qzGCypCwUBFeCzne3JF+XIxSNURcrvkVnkmdQxiORKY+wohFc3S+19uUH9jqB3ZeMw9nxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826002; c=relaxed/simple;
	bh=xgqcKqyRtsAkM7aclFs0DsgCwOLSxK2usNJJ5fikuOY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PFnoSVH8mT+1IHz++QyoPFx6wBNlH93sagIXFfGFVJ0c47JI1zKKYIYxMemrYHjIf5NSltWlflNVYIv1M+olKjVeHvE9QzxJMqdOp/tEz1YSQnItE/odxx6gdj7ANbRyCB5K8o8mLyuMQiqHc3maUFFgStpt2Y7gNNLdoOE1asQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id YEV00145;
        Wed, 28 Aug 2024 14:19:45 +0800
Received: from localhost.localdomain (10.94.16.18) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 28 Aug 2024 14:19:44 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <m.grzeschik@pengutronix.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyanming@ieisystem.com>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] arcnet: com20020-pci:Check devm_kasprintf() returned value
Date: Wed, 28 Aug 2024 14:19:41 +0800
Message-ID: <20240828061941.8173-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 202482814194520dc3504598d31dbe689e8f61db04a77
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure but this returned
value is not checked.

Fix this lack and check the returned value.

Fixes: 8890624a4e8c ("arcnet: com20020-pci: add led trigger support")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/net/arcnet/com20020-pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index c5e571ec94c9..ca393f9658e9 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -254,6 +254,10 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:green:tx:%d-%d",
 							dev->dev_id, i);
+			if (!card->tx_led.default_trigger || !card->tx_led.name) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 
 			card->tx_led.dev = &dev->dev;
 			card->recon_led.brightness_set = led_recon_set;
@@ -263,6 +267,11 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:red:recon:%d-%d",
 							dev->dev_id, i);
+			if (!card->recon_led.default_trigger || !card->recon_led.name) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
+
 			card->recon_led.dev = &dev->dev;
 
 			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
-- 
2.31.1


