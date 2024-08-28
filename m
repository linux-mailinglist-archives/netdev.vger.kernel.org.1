Return-Path: <netdev+bounces-122744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A180B962696
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AD81C21645
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C877173320;
	Wed, 28 Aug 2024 12:10:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818A115B968
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847009; cv=none; b=bGUtTS30Xp6mlUPxkNpxo7Q876jcRnnNZrt9IHBXeJ8Zcu23Nzhhd3Jrs91uhCFYWxG1nWZ0AplXYrETQo2Mi/t97smgvq07iTvPDno1f4PMjRdFiFovg/qU7B5F622qjp0brDUxpcyC6/xT6WyE4xBrZ+GfdCm5H5UGp1fdIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847009; c=relaxed/simple;
	bh=TVxlMOxfZeXzh+JckA5xNDVlRlAR+18Ef4uQq/nLEJo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X+31amDjHUBSeiQvASZQqnVcjwGwzAvdICNnLR+zDcCAmfmk9pToaDdjnqjRxXDL7YrimSK0+UR9fRQSWOwebrBcJfBR+xmrkGglc5ELV+LuIMJh0FXg2rm0ScONcGl2l5M4+N+QnVhcvmodOaG+S6/fNbyyrLA2jwaxM2Ndsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wv3BT63F1z1j7Qs;
	Wed, 28 Aug 2024 20:09:53 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 132301401F2;
	Wed, 28 Aug 2024 20:10:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 20:10:04 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <linus.walleij@linaro.org>, <alsi@bang-olufsen.dk>, <andrew@lunn.ch>,
	<f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH net-next] net: dsa: realtek: make use of dev_err_cast_probe()
Date: Wed, 28 Aug 2024 20:18:05 +0800
Message-ID: <20240828121805.3696631-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Using dev_err_cast_probe() to simplify the code.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/net/dsa/realtek/rtl83xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 35709a1756ae..3c5018d5e1f9 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -185,11 +185,9 @@ rtl83xx_probe(struct device *dev,
 
 	/* TODO: if power is software controlled, set up any regulators here */
 	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
-	if (IS_ERR(priv->reset_ctl)) {
-		ret = PTR_ERR(priv->reset_ctl);
-		dev_err_probe(dev, ret, "failed to get reset control\n");
-		return ERR_CAST(priv->reset_ctl);
-	}
+	if (IS_ERR(priv->reset_ctl))
+		return dev_err_cast_probe(dev, priv->reset_ctl,
+					  "failed to get reset control\n");
 
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->reset)) {
-- 
2.34.1


