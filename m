Return-Path: <netdev+bounces-250961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D55D39D50
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 05:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BC5330019FE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 04:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F973128AE;
	Mon, 19 Jan 2026 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDW0RiOV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE932FA2A
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768795505; cv=none; b=MIfSRAGRgZqLxJTGdiM8aPhn8IOskI/tGGV9LBT5T7Jw03qBgIkl26bSenvkk9aos6LUM2GWYUUgGQ0mX1lHna+oNvPSGCFU9hxJFJHPIkOp61Q0kbQ5P5hNbcF+vEI6aHgtsn3XgycRmmOAxfVr3QuH3vUgcuqF4ltNVR2i8Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768795505; c=relaxed/simple;
	bh=DP9HAMMwIYto+P5rMnIHFSuOC/aVeMGzuMoS/A+qAX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNdMvf8vwIFAoyKvhbDBBrdHkzz8GL0lhi03ot8yhgePLRuHV9f0BLTY1efB5OKL5BHDWIdqsubNaizlz7UZfEs/gmECA9FcdfNCdIsBxRQPm8aOlG+rgnQ74BIWrLmDUpqTSdVFYckw3T2nrewlDtqKm8MMOSRzMP5S8w9kOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDW0RiOV; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso8489524eec.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 20:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768795500; x=1769400300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VRBT4LITV3AyG+vNWtghFdo8qraq6nhI75e8iz5bbQ=;
        b=XDW0RiOVMXvo8p1X2wIhbSxpApXlgExegB+tnvKLupPLk/KcQA3K/mz9BTkyFisFwb
         ib1Bo/S6jbjN6C6Lo4Nu9oMfB+CA2O1wdo+EeHiC2vI+/QnjSzsU6ysHakpZjPW3U0UV
         tvab1Zgc/bNHr+wEjuOkNX/xQcnUPs98lN7MHTffYl7U+Em6Gaw0VW5oiI5r2n5q5L7n
         YVUWZC/2/AcgT0ZttxFgMClA9ueSWOVk6AujXqdXSQvjsWu7fDt2YkSV+9nl7rNOWZ6+
         9Kl4t2LAakELTkhL457D1T3J1LOX02tJu225PrSkZYqO/MB93ieNYDQWyR9vC2LJrGEn
         YLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768795500; x=1769400300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5VRBT4LITV3AyG+vNWtghFdo8qraq6nhI75e8iz5bbQ=;
        b=ZhKx7/rL7JFSTE63gBtUb3LV6TWVOUxcL35v01XvFWsgZEcwCUTxgHplIsMxut1DHD
         TT9oBPKVZxuv3DKln05xXBr1kzX4L8iYYpOuTbIJW2TFutbZ3ewGK4fVm/fmfLlfx+wZ
         T0DQHxbjm207DUxHAo7vZkbZw4r1/Smnz5mLphFXc7Ic91AKhRzFmnuabMk/aP/oEORl
         w1UOEFAgREke3tPUPC4IeCevx8xH6lfLdahXBAf+u+kH46ZEQqW6Wmv67jwrSC/AXeSN
         29xKAIVzecyxhHIGYaXfgvN16Vh0+LKs8T+8ripBAGQI8exUOxtX4n9sc/kBP/gCkClu
         qRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0ixBJgYQbXNhxqCj8LvB29YqKvrsmdr5CF92VWAR6gV970OkPMyWlQ6z+QWWig4wVRxK9hAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSgQvTs52R3dzIdE3jakO3Or9edgVRbxZavbmPkcGPN93Frb6T
	lvzrm7i0g34uSSKSOIvZeWP2EcpTmwvLz374As0fNvSkAEsCd8oCRKP6
X-Gm-Gg: AY/fxX6t49GGvcbIdLaWg8Q9cjLwu0Op7F96EE251QPkPW8XVBAKkPKkNvFodnB7uIn
	CbjHY2vGu51q3NWxUYJw4g+fExbM9udAwSJBPsa2bM3DIW2kegzGiH6Q+RwHCqMWEAy07KFZUw8
	ax3uNkJXhKPzMbtAJjMyQHq5ug+5DHgvaCPjBDPvnibbW1zFtz5+hQYqLGbBKx2x9Tb45CpGd1Q
	GWETeD617n6rJ+SKjzr+HpKbP3Exu7tNAC1Xh1831CYHhnm6jYMJU05L2KSAWdn0TjHq29kYy6t
	pAYeLJGSejJUyBZlrePN1lYbooJx3LDheGMNwCsZL4kjMYcNV/oaAbONbRjHJHqDuY/E9WHWlvB
	eHvpr0uf18p21YVyNCyrJV5rztfQY5DvvSgImVjwAY5KJFJFQIgzS8DtmvqUStWduCdiQYeiWL8
	k5HVf7UvDrrA==
X-Received: by 2002:a05:7300:8c9f:b0:2b4:5153:42c4 with SMTP id 5a478bee46e88-2b6b411576dmr9318510eec.27.1768795499700;
        Sun, 18 Jan 2026 20:04:59 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6bd8e7cd9sm10406493eec.16.2026.01.18.20.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 20:04:59 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v2 1/2] net: ethernet: litex: use devm_register_netdev() to register netdev
Date: Mon, 19 Jan 2026 12:04:44 +0800
Message-ID: <20260119040446.741970-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119040446.741970-1-inochiama@gmail.com>
References: <20260119040446.741970-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_register_netdev to avoid unnecessary remove() callback in
platform_driver structure.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/litex/litex_liteeth.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index 829a4b828f8e..67ad1058c2ab 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -232,6 +232,7 @@ static void liteeth_setup_slots(struct liteeth *priv)
 
 static int liteeth_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct net_device *netdev;
 	void __iomem *buf_base;
 	struct liteeth *priv;
@@ -282,7 +283,7 @@ static int liteeth_probe(struct platform_device *pdev)
 
 	netdev->netdev_ops = &liteeth_netdev_ops;
 
-	err = register_netdev(netdev);
+	err = devm_register_netdev(dev, netdev);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to register netdev %d\n", err);
 		return err;
@@ -294,13 +295,6 @@ static int liteeth_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void liteeth_remove(struct platform_device *pdev)
-{
-	struct net_device *netdev = platform_get_drvdata(pdev);
-
-	unregister_netdev(netdev);
-}
-
 static const struct of_device_id liteeth_of_match[] = {
 	{ .compatible = "litex,liteeth" },
 	{ }
@@ -309,7 +303,6 @@ MODULE_DEVICE_TABLE(of, liteeth_of_match);
 
 static struct platform_driver liteeth_driver = {
 	.probe = liteeth_probe,
-	.remove = liteeth_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = liteeth_of_match,
-- 
2.52.0


