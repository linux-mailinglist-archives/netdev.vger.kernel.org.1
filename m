Return-Path: <netdev+bounces-250364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F41D296AF
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B481301146A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D872FABE7;
	Fri, 16 Jan 2026 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRu3+yX8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF361E0B9C
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768523520; cv=none; b=I6Ac2Q2lMk8+CKh8vtWcZRh7pEQW/DUUeRpJC4uXrC6SX7SDIBSRwe/sPCr54ktt8hhFI1R94qlYOKD0o8zm20rMDL4KBYxbrLuhwYrtLNOPydBbpwksmkQop7QtxSOuLDnQFinENAVm7Tpa7V90cSFbufu3lRJWVb1Z0ZyOfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768523520; c=relaxed/simple;
	bh=rJO87xfkyFtWUxU4oZC6QGw58jHCE4tTEXdOG3x6dSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uv7lByAGLgeuXWeKmfSPEvLCLYpJIwB6GLwBMigshYFGpiQ3+Ek3sY0Unhrt+lp3JNxhwu3AToWmj3+DlMbJnGURCDEGnmB5+rUcpCOcugS/fXNfFkIN/SGzxF3YAvdr9u4jnZ/CGkqWjkdOxHVraWqGa7WYrQ3YWydqccinhaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRu3+yX8; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b05fe2bf14so3311698eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 16:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768523518; x=1769128318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x1pHaIXvJMGgJtXRxcfBLUJYd85Jy5r23UW4kbJOj2w=;
        b=lRu3+yX8uPaicOIPDEYp8HmmVPc67T/jLvUS9cyImym+k21777JHVWXQzbMB3kY3eH
         tMTqJIYMotAProgUX7yoILf1rkzlC0EWLIprXHjCvYITzrQfaATuBiwuxUC7Z46e4gAg
         2EEVZQkBQ5qunpWYeLvsv6ZfPU2X0/CpPsLlRuP2a+SAxSC6vApfpLozOe/0hWgx7caQ
         j4lITAsBpmLV69uQF9TVJnMdYIIsOwbESW8aPvmMB7Uq9/5ic0DnoAb/eei+qHDAY0SG
         GcK4GJvnay37O0iCE3W0+psm98O8RixQJMxlRzaX2NT8H5OudamfU2Gbe/B53qMybyBo
         SSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768523518; x=1769128318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1pHaIXvJMGgJtXRxcfBLUJYd85Jy5r23UW4kbJOj2w=;
        b=D9sUlkg2NnfkqzEaBjUM9ccjK7QYHpeao9OwOHpxVV/LYN6DIQ/27/LZuPSAw4Eeam
         KZtmd75fOblksecIB0QHHXiEJ83QaS1AlEmfiNCKoDDXqI6EAJ5GRTfVAqcOEEmYEFwV
         9IxxfrdAo1E1xxj2glQENFZIe7jNZeXpXk4e/umvrCn/L1zIeGYu4I9K96DYd37Qcsem
         08xMDySII297OamCUsapr55DL+hWn+2qze6bpUYAKMWxhB3OrnLrHAxNRWaxSFf69R8u
         R/JMTPx0ygxJDloaJb1ZOPd/Cn/3eu9qnbqlUWUY3bxnJS0LP2kykOiPgZPgfwhVUpN8
         V6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVQqzGH1fdVNDwTtMMykW1HoZgfif4cGH0A8p/+YvoWfbfoZJ3GrWVPBpwAyyER3drrKqRUAFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCD66CpS8PhmXG5dkGIMvq57XyCY+5Z2EOM2/90wF62vyjlA+C
	jnXoYvHsxlboxNtP1nCnbm+wUoA5+u5ZFovBPU7na83qWa7wXom2J2jm
X-Gm-Gg: AY/fxX6n9hLITbjHuytWDwnfOfECra/vywGlq6K9uK+oN1SK80vmDGiGAzK+1HtD8li
	i4ChUfJw0fpX+GReTO3OGFiuy67AizcqRaqO2tqvWyTMvL9hZ0n9QWc4DyJ44a8qZYadQJyk3S5
	if9HTbJm3tpIHF0BC1Aarsgz+R0Il53iYPDcLddGJSvp4aVZ1RGe1vZG3cwKKfsEJscasjAhYJ6
	JTtfQRtjjLyAgJUTGmrWzONAdp5OQSphZn+CTZKp/4Mf8taet2wZE4QMzK6xmONgtTqo4gdFm3z
	B9Nsr6K4SpzD9ig4GePQADJdGqvP7wTBrWy37WBw97zKIxm929at+Y5TX+RSavoZKK1D+aRaqOt
	K2RifXwUbuoEpT2IATzjfOsYCnfGSJ9oL/1nke0Xx1sFez71u1L/j5MoJPq5awEH19moCk8QLk5
	FJa4Ulfy1u+g==
X-Received: by 2002:a05:7300:6d15:b0:2b0:5609:a58c with SMTP id 5a478bee46e88-2b6b4119739mr1608456eec.32.1768523516110;
        Thu, 15 Jan 2026 16:31:56 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11dasm1041106eec.2.2026.01.15.16.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 16:31:55 -0800 (PST)
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
Subject: [PATCH net-next] net: ethernet: litex: use devm_register_netdev() to register netdev
Date: Fri, 16 Jan 2026 08:31:50 +0800
Message-ID: <20260116003150.183070-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
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
 drivers/net/ethernet/litex/litex_liteeth.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index 829a4b828f8e..0de166528641 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -232,12 +232,13 @@ static void liteeth_setup_slots(struct liteeth *priv)
 
 static int liteeth_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct net_device *netdev;
 	void __iomem *buf_base;
 	struct liteeth *priv;
 	int irq, err;
 
-	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
+	netdev = devm_alloc_etherdev(dev, sizeof(*priv));
 	if (!netdev)
 		return -ENOMEM;
 
@@ -248,7 +249,7 @@ static int liteeth_probe(struct platform_device *pdev)
 	priv->netdev = netdev;
 	priv->dev = &pdev->dev;
 
-	netdev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
+	netdev->tstats = devm_netdev_alloc_pcpu_stats(dev,
 						      struct pcpu_sw_netstats);
 	if (!netdev->tstats)
 		return -ENOMEM;
@@ -276,15 +277,15 @@ static int liteeth_probe(struct platform_device *pdev)
 	priv->tx_base = buf_base + priv->num_rx_slots * priv->slot_size;
 	priv->tx_slot = 0;
 
-	err = of_get_ethdev_address(pdev->dev.of_node, netdev);
+	err = of_get_ethdev_address(dev->of_node, netdev);
 	if (err)
 		eth_hw_addr_random(netdev);
 
 	netdev->netdev_ops = &liteeth_netdev_ops;
 
-	err = register_netdev(netdev);
+	err = devm_register_netdev(dev, netdev);
 	if (err) {
-		dev_err(&pdev->dev, "Failed to register netdev %d\n", err);
+		dev_err(dev, "Failed to register netdev %d\n", err);
 		return err;
 	}
 
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


