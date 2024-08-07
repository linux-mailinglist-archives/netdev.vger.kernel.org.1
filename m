Return-Path: <netdev+bounces-116573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2E94B029
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 20:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E17B237B3
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9F21419B5;
	Wed,  7 Aug 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4GJ7/iJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5C585654
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057161; cv=none; b=n3uDXVG7EidJS5C1Ov+/KXP7DDjSksHltVZp394cVgLYMdm7UTpNptOxHvT+o4P8ipyX/mYUlZp63659KCrJpoItI2z2GuuUKkpuK/a97Qpqsh+EoIuEVl+vZbdFpDA3OKRcBD2M2HQgfRMifYPyO7H2xcU8/U165BUOFCFamXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057161; c=relaxed/simple;
	bh=hIVvH2+pkzcMIYysNKzNwlFqVnhplPZAuQ4/Vw3FqaU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SGweLP9wq6zz7/9j656c5vABQX9yZqG/+Kom8gPrdKhjoQMcDMJc4CBVMWQJpi4LvifjMWN+oGBXxY6cViq89Fsj1XNQs2vGUurhmmkk0bWbkMijsr19M9y9TF0oxuEnnAKvikWc1sUx7N7cv+cW21qHQDpaEjYA0wMt1FBTlLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4GJ7/iJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d1c655141so183784b3a.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 11:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723057160; x=1723661960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NwA3//Ou6zwzrPvy2p6hCN4QlFE1pyGZu8UJO3gleZ0=;
        b=h4GJ7/iJ2EBu+0mVnQl6xTvT0BRXaVxdEQi5DtiU551oa+BDKpdXJ2ehfVz2VdrQQQ
         dcFhtuKqxQcEp1Ep92VKD6CKQAet5HTIHlSi5GJV0ZhcVv5HKWq/7cEhI/FPcBpXOVZP
         zdIHTfZxrs7tAWAbtgGz/ZzDwmugt4vNMTuOp2Qxbp7hHQk8cUD+8PiE/NSnLLdUatUp
         9JZ+TjQKf9PHXimy3NG5IBvIvgkAIP1c7VGOELTxtw1K05HhklB4hHyEEXJl85Wg0vp6
         2a/YW7b4fN8PbbJrKPupaKBQ2f0rhSLFG/dLYFXRPyQQ9StyGMyV77AwraZM9rapvZok
         gwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057160; x=1723661960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwA3//Ou6zwzrPvy2p6hCN4QlFE1pyGZu8UJO3gleZ0=;
        b=TVY/JsmfI20af8qSWsOllC1MrTStpN/cYHo9viLr1+v1Oh7JasWXBHqsV7K1ww1z6g
         VrFBZx8/a4GK+5T4Nu+3wF70Xx4DFCyfmbFln2AlQ2ibHMMW52cVAXd8UIdQivjgq3gD
         c+PE2rwRp/EhJIM+FpO8xNk5sr7R1Kokhd5ec9aa5abpcaCvFeFBX5x8asxLfyP1WgbN
         +dDLOSrNRSYnsDBA1c9BzxomdtaVW17A2/635+uBDttHMxPRPZ/YB2LyWCR4dgwufDqy
         lYjb2hJ1b/IhD86QORNq+A2QyOC6+Aefj8ZZo/t2oze5R/G6NFmLd1llaGGy/+Z1CEAN
         IZDQ==
X-Gm-Message-State: AOJu0YxXMQrrFrx99l4VnNogk2GdnPFVMJy/KlPLLpwh7Iejxy+90nil
	w0CkaDv70/RaqSPdGklcFBxAVfKBEZPSULch+gCaJn425Jiwe2633yEgog==
X-Google-Smtp-Source: AGHT+IFyXxodopox3nBjlB3YXGz2TXuDyzuuBDUpnc89Q49ZGmCGd58fUpUOYJRBL0nIXF8lxzrn/g==
X-Received: by 2002:a05:6a21:9181:b0:1c0:f648:8574 with SMTP id adf61e73a8af0-1c6995ab30amr20579291637.29.1723057159609;
        Wed, 07 Aug 2024 11:59:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905b3f3sm109550275ad.136.2024.08.07.11.59.19
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:59:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH] net: ag71xx: use phylink_mii_ioctl
Date: Wed,  7 Aug 2024 11:58:46 -0700
Message-ID: <20240807185918.5815-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f1294617d2f38bd2b9f6cce516b0326858b61182 removed the custom function for
ndo_eth_ioctl and used the standard phy_do_ioctl which calls
phy_mii_ioctl. However since then, this driver was ported to phylink
where it makes more sense to call phylink_mii_ioctl.

Bring back custom function that calls phylink_mii_ioctl.

Fixes: 892e09153fa3 ("net: ag71xx: port to phylink")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 6fc4996c8131..e252eca985b1 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -447,6 +447,13 @@ static void ag71xx_int_disable(struct ag71xx *ag, u32 ints)
 	ag71xx_cb(ag, AG71XX_REG_INT_ENABLE, ints);
 }
 
+static int ag71xx_do_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
+{
+	struct ag71xx *ag = netdev_priv(ndev);
+
+	return phylink_mii_ioctl(ag->phylink, ifr, cmd);
+}
+
 static void ag71xx_get_drvinfo(struct net_device *ndev,
 			       struct ethtool_drvinfo *info)
 {
@@ -1798,7 +1805,7 @@ static const struct net_device_ops ag71xx_netdev_ops = {
 	.ndo_open		= ag71xx_open,
 	.ndo_stop		= ag71xx_stop,
 	.ndo_start_xmit		= ag71xx_hard_start_xmit,
-	.ndo_eth_ioctl		= phy_do_ioctl,
+	.ndo_eth_ioctl		= ag71xx_do_ioctl,
 	.ndo_tx_timeout		= ag71xx_tx_timeout,
 	.ndo_change_mtu		= ag71xx_change_mtu,
 	.ndo_set_mac_address	= eth_mac_addr,
-- 
2.45.2


