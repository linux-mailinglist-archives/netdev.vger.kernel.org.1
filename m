Return-Path: <netdev+bounces-164300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD559A2D53E
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 10:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD96A3AA532
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CF21AF0B5;
	Sat,  8 Feb 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQh6VzFL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6141A00F2;
	Sat,  8 Feb 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739006861; cv=none; b=Oa2L6P5VC4CnQIZRiP+S1D0TFGA/G/V9oSkehIV6kFbcgVbsBs/wcH1NnSZQAxR2faca4ec0A6P22nJc8Pd2BePxTTSqXrPv6ru4Y6fwDKp6+tGzVuXAhWMMPyZKt3ACvbV0T9C8UBS6pTGmgtuS6mvvw4LGRh5MnjFWqUuhfbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739006861; c=relaxed/simple;
	bh=eVg8DFIOZ5ZbXNOUMIMaVaFslz0upoYFCRQIgYkwSoA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qgGI3BpyoMqVtZknWsHneewJyy1XGFBWImdGz21DmXVNUnGW6188qkwRIAjI6+DL3RdFmHpx1/oVIgdKZpSDcSLXwhQxBFjPshBiPSGlSE6Xqoh+IQsjQgqCfzUHJXsdKl3+cBpyAIBQFmyI2EexwPRSVR0GsxHmdccvVe/yI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQh6VzFL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f6a47d617so6494095ad.2;
        Sat, 08 Feb 2025 01:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739006859; x=1739611659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tutg1hcgzbwWFewfp7lGkOiAHY/GORMI4dIKinVdgRA=;
        b=QQh6VzFLEgiu21e8g+lg/cQAIZca1vuE0KL99/C2UiGAvMUyp9OYrcpSkbc7os/BGJ
         1L4mHPdC9lkPsTwtZinIlCxuXk4s4ceLaL3tPB84CRQlC3qDJQNA425OejbqJ7+Nauqi
         YWi/c5IyFBGHHrfbzh4sZmYSQqjrbPBQrjrxrQyuQ9CK4FR26+J268cCAXxtGzZZ2FZO
         BLbF5zbCHesdmh0kart9+K0uXrLL8TuPYq5jt+/kxMji8tum/LrVn71fDWSt+0WqHqPT
         tmJ24QFuNk1pD1TOh2jnbH3yMozyx4v5giRh5YuS772TokCmm6axyPOwrJqqkFz87leU
         SgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739006859; x=1739611659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tutg1hcgzbwWFewfp7lGkOiAHY/GORMI4dIKinVdgRA=;
        b=vmm+7S020AfXlk9gjM3mzLAvYxHPM3o9DJqdhaagM3eCxIYYpsze248CxNEY6A6Bwx
         HdIbLRGJCsmy9oA50deUBtvz8bDPwOYPNeiIzPBUZ/iWrHiAL2eepaZx6Gkqs/2V+GwC
         2C+TeRqDvCHGeS2SfeoWcAKgY6K6ELLbYD14tZ0JBQ7F9b+ECzNb6bIasodqhq70wtNS
         Y28JHnmet3KG4KzSPMxniGVyK2GBwmijWlvfYWpJOifRbZyKmWe2kPMparVPWLiB+wSw
         iEZhwDAk4x55xwq7lAZQSZb1YerpHjYA0XmckzAqQGeDVwPSP38iqUGPHgtv8s61IP+v
         yTXg==
X-Forwarded-Encrypted: i=1; AJvYcCXDnZLnUVaNckIfWFrZtuDZrsN1PPF1xu295uGUPghdNriLUQApSSNYCny0vaOpmtlPFVuEJPDN@vger.kernel.org, AJvYcCXGDzpd8q3sbbCuQKP2egKHJ0f1oFb+ACmrtSUyd6ekT7MFO5QPHSFgtTaMEjqV/bu+U+Bulv/qkXcibNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVx9ILLsQ0YdHdR8f9bgbsdVMj/rUfmxnI6T38aCspVF5K/ZS8
	fwb+/pI0Nsf/JfUonOm+F4x4Bt2ss0Uy4p0bBkMBU/0lMJXMmNl4puGhoKNQw7E=
X-Gm-Gg: ASbGnctF3vGSF/nwQ8kLnRPjAFKJvtcXkkr2wReKs6XswCrj5hrt9L3VnRYp1PujU/u
	vSsLQf/g63jJvwRjq9/rtJByE7GB2P5bc0FfrVOIjI4G6kEVzM66JgHHwceGgbsGoXugMIKN6Pf
	SJiZMRYou3pJXIzq4Gaa3RxWL5MUeNSQfKUW1iHFjtbaJHvqsoNKKjg+3scECsjPBCJwfIp7XRv
	EzyGgMp6XFRQEm6f+7285DjU8ZdqxDKq9XCWOcXtfGKn7Y2vckIG6z1EzpBmGc/HWIxwL/R5KNy
	ng2iLRuM
X-Google-Smtp-Source: AGHT+IHaE1Pny20tOKsmxWPGT7N00vpoT1tCqZ7Msc5rofLkOL2NuLDdaQthdI8Xp7AeEGAoSmQtVQ==
X-Received: by 2002:a17:902:ecc7:b0:21f:6c82:1119 with SMTP id d9443c01a7336-21f6c821252mr24670645ad.18.1739006858778;
        Sat, 08 Feb 2025 01:27:38 -0800 (PST)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687edb3sm43554845ad.184.2025.02.08.01.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 01:27:38 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: ethernet: mediatek: add ethtool EEE callbacks
Date: Sat,  8 Feb 2025 17:27:32 +0800
Message-ID: <20250208092732.3136629-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow users to adjust the EEE settings of an attached PHY.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 53485142938c..014de2c2624b 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4474,6 +4474,20 @@ static int mtk_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam
 	return phylink_ethtool_set_pauseparam(mac->phylink, pause);
 }
 
+static int mtk_get_eee(struct net_device *dev, struct ethtool_keee *edata)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+
+	return phylink_ethtool_get_eee(mac->phylink, edata);
+}
+
+static int mtk_set_eee(struct net_device *dev, struct ethtool_keee *edata)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+
+	return phylink_ethtool_set_eee(mac->phylink, edata);
+}
+
 static u16 mtk_select_queue(struct net_device *dev, struct sk_buff *skb,
 			    struct net_device *sb_dev)
 {
@@ -4506,6 +4520,8 @@ static const struct ethtool_ops mtk_ethtool_ops = {
 	.set_pauseparam		= mtk_set_pauseparam,
 	.get_rxnfc		= mtk_get_rxnfc,
 	.set_rxnfc		= mtk_set_rxnfc,
+	.get_eee		= mtk_get_eee,
+	.set_eee		= mtk_set_eee,
 };
 
 static const struct net_device_ops mtk_netdev_ops = {
-- 
2.43.0


