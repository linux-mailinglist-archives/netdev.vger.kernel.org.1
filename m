Return-Path: <netdev+bounces-107704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D8091BFEF
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 15:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1DB1C20C41
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0949E15B98D;
	Fri, 28 Jun 2024 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZWVSCkG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2108155CAE
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582553; cv=none; b=WCKvczZ9+64HiJRx33wymMBIMfLjN/vQ2FLQHHEEt8LErWKIFgspN0wn1M2P1EW7cKesheGHKTpD003OzFTSu1XG3R6hb3vZzi2l37YIsDq7cFoMnO8wFvfYGJFrpdcPl/zpv/dd0P0hTs1sxYEDQ7KQ5Omh856dM+iG21XeBzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582553; c=relaxed/simple;
	bh=FK71NqbAWSH2AAmcWOWt/E0/+ASk2QsRfQOo0BiuHbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WolBNWYN6w8m4dZJfUdKToLirZz0SrX9dUdCTSdNqXNsUMaW0sn2url3qBBDSej/cshbcDofs1Y++XDWCUybsq35AOBPHywFQ+qlXlDA9WpAdI2eBK5bEoYc0FalG5PyQ5/tyOIaAf0JdRRRcKp2/Qx5LnNgpyrP9WjsWJQJimk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZWVSCkG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-706638d392cso27629b3a.1
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 06:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719582552; x=1720187352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YA5RqSQLCvr6hDzMBQtvwJ4PZ6M98OsInhZdtLy+VY=;
        b=CZWVSCkGNz15Rtxfuk+MR5l88qLGgXMVs+tOMemo8yMIxzXuVCdAVGP1S8VZjmpEfg
         M7WBdtuWq1FTnoyT9S4/72VOtchREWmGncbCtpsmhq873AEV+VQnFXYt3scVOJfBBHyK
         CZiiDnDnteVunYBMeGYfvRxPF2o2m9a8XZxtWL6W6y9+9DN8iXqqPowRFSqAC7It9fXy
         yNOtVIFh/OqlQEf2VubCXR5T4CctJnwWOaTFUYIN9B4lozbvmzToZAM7uABqGFJS/O5F
         qcarsHFlKP7kAtxCzHj7hqAIMgh+pLRUhUe+juG73pO+aCPpDxNlg4yi1gDqh2qz7jn8
         9fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719582552; x=1720187352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YA5RqSQLCvr6hDzMBQtvwJ4PZ6M98OsInhZdtLy+VY=;
        b=kU935HSk/kOwOnt1m22YTE5t8vA7ejTOfgxeyJ+P5NPOKGJdRU5l3bKY4QoX5KC6yP
         KUJo7Wd6PxhBf+YRXzRo2Os+AenZEm80Fli4TyGmVqD0KoaWgqPuM4pRG8AVZTRASLGA
         vt4dgGNZ/TJqggWzEJDCZ/erMGnw13iInjiVgI8n6JaVSeAvLb4A2JiOm1cjX8WPuShF
         LMIpLSjp5cEZ08qaj3m+VCZRlzKGjVoi/+QWPC+RoeUQ4oov4MD9POwqltj2dcXGTkOl
         /a30Tupte/71WGK9S2CP/MGDZnu4t2fPylNbVpJQhkzh0rqU3+v1Xjl0xaS+zOmI6CFG
         wq9A==
X-Gm-Message-State: AOJu0YxMkdD/sV+0SW/KqOmEK5WY21oZpXNoExNwy8vUr8x0A1FSdqvw
	a33z0YXty821v6oL1vsexAIcvLWWiP4SOG8YZanBP8rVyjU8foF+8NoNKnXi
X-Google-Smtp-Source: AGHT+IGT07931c2HORKXtvuiVjr+hXA3oClaICFSvIWFV8xh1uqQLwDQrW8R1OLHdWvt9GP2fNGrwA==
X-Received: by 2002:a05:6a20:9188:b0:1be:4c5a:eef4 with SMTP id adf61e73a8af0-1be4c5af607mr9340824637.3.1719582551715;
        Fri, 28 Jun 2024 06:49:11 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf8e4sm1593547b3a.133.2024.06.28.06.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 06:49:11 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	linux@armlinux.org.uk
Subject: [PATCH net-next] net: tn40xx: add initial ethtool_ops support
Date: Fri, 28 Jun 2024 22:41:16 +0900
Message-Id: <20240628134116.120209-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call phylink_ethtool_ksettings_get() for get_link_ksettings method and
ethtool_op_get_link() for get_link method.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/ethernet/tehuti/tn40.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index 11db9fde11fe..565b72537efa 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1571,6 +1571,19 @@ static const struct net_device_ops tn40_netdev_ops = {
 	.ndo_vlan_rx_kill_vid = tn40_vlan_rx_kill_vid,
 };
 
+static int tn40_ethtool_get_link_ksettings(struct net_device *ndev,
+					   struct ethtool_link_ksettings *cmd)
+{
+	struct tn40_priv *priv = netdev_priv(ndev);
+
+	return phylink_ethtool_ksettings_get(priv->phylink, cmd);
+}
+
+static const struct ethtool_ops tn40_ethtool_ops = {
+	.get_link		= ethtool_op_get_link,
+	.get_link_ksettings	= tn40_ethtool_get_link_ksettings,
+};
+
 static int tn40_priv_init(struct tn40_priv *priv)
 {
 	int ret;
@@ -1599,6 +1612,7 @@ static struct net_device *tn40_netdev_alloc(struct pci_dev *pdev)
 	if (!ndev)
 		return NULL;
 	ndev->netdev_ops = &tn40_netdev_ops;
+	ndev->ethtool_ops = &tn40_ethtool_ops;
 	ndev->tx_queue_len = TN40_NDEV_TXQ_LEN;
 	ndev->mem_start = pci_resource_start(pdev, 0);
 	ndev->mem_end = pci_resource_end(pdev, 0);

base-commit: 94833addfaba89d12e5dbd82e350a692c00648ab
-- 
2.34.1


