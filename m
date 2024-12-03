Return-Path: <netdev+bounces-148476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4608A9E1CCF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AEB7160346
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970831EBA0C;
	Tue,  3 Dec 2024 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKGZJ4Cn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110651E47BC;
	Tue,  3 Dec 2024 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230483; cv=none; b=peb8hcV6blJ/cDktIV07GxKNsBsieBLXuf9L0EmpdIvVXrQ7r5eMizyMUx3mIkAi/+jeAGT/iXpe1iArxZzhZS17vgz0C9wwNXbweDC7NIleCk7fEfEKh+VL+DbBHYdtnJXNrcOMxEGEe96UIriu7hcU5hsu7+PbzIPyaj+1zU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230483; c=relaxed/simple;
	bh=0/fhiMWG79N4KhH5bKYcGYuR6NMHVODFbh3Ja/rsepQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sOzWWHoyz1bzSR/cFH9lc1tb6/mENXIZeFRT+MKQGtUaZtVB+3CfXTfvaOr+JQBnxXIcUYtFwt4GCxSVhivYwMHTZnbYcicfxlOZ7QNKJ5wgykUPsMlhq4mfKi1b4IRChPKLVfWq191IWbAS1H74DegZl6FQT1Lb1wxsDmn2o5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKGZJ4Cn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7257b5736f2so63205b3a.3;
        Tue, 03 Dec 2024 04:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733230481; x=1733835281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VzF7LXwlE6d2xweHfxZk/Dl9G8oUniKTz7ZkBliProo=;
        b=bKGZJ4CnAgjeRYBae/c/0HK/St+CJ+MR4hmogvYysn4Qxj2uq8fEegCI65AgZpfrLT
         lvOcLYihPwMCRjkB5OgJx25CAK6iGQI2JqkAtBXbriazWdXyPpJNEQHSYxh1NFEUJY+H
         ORvPy8v01oHddt6IS9Ad9W5Rl4vNVtbdLA853QKPvincleDY4ucyAh0RCqjiYvfCM9v9
         Ru/KuhRrhv7YCXMZEQs6rN7bn6v0dE7KZu7W3ZZSjnLQkdyZAPrkzCcanoC62RVNUWYR
         6pNx8zvzRxV0tautSulbiI38IKnBsGmgdNMQGIMdB0Rt4Z99I8BlDw3ASzHxAuHh31rw
         uR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733230481; x=1733835281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzF7LXwlE6d2xweHfxZk/Dl9G8oUniKTz7ZkBliProo=;
        b=sf0XkOXhgyD4SoxpwB+V5NWGQ5gB7VH7cYY2zILHxLMrWF4NifXkpNaXqXkLfSeJno
         hPPuilrFMAJ8uFBSwQIySTbZitZZ4cnzbzZeo8HOlr3AWLVrGPRa31W358k9ZCrDWurI
         CLbjdmPA9WV7n/zPFhMMm0hSaw3+EY5H0vz5VBiX/13oyjgK3KvT0fPAuVHzgNs2sYr/
         BSppCT8BR7OkbS+zPCAkkm2xcBJBLylVLgbbWrZUDi5yL8L008agE3IjFCxra3MmfskG
         6OWXRwcRjJd/ZgO23CZGCIDmI7txr+Sp/BAkgFL4XDe+d2pRViJRChLUMVrBGGKmeizo
         Fxpw==
X-Forwarded-Encrypted: i=1; AJvYcCVhGoqhoVkJiRII/3v8MeSBpTnG9DzdQItfzCOe0W8NsIyf4zDTdRZq/u8slHkwXuaWgO4MZETS@vger.kernel.org, AJvYcCXMpuCqw0qMn+99jrR67n5ozyHxAauEAkfkgigDgM7/RPR4+CF4VuGX24ESsP3lz0VcT1TSj5EXEhyEJ/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgM/X7dL9GICcWLDZjwk1hne+SvS45WLmgswqTjmqla79+oqLO
	aa91sk4U645j+Cy+7Vm/C8Kqd1IB8JU7hNOvw30QjR6jAR4Pb8pd
X-Gm-Gg: ASbGnctA71K6czm7HrmX1G9Kg0LEim1hHhUX70H4Lm0+BhJ+Qz1dV7tgCb+G0YONd7m
	Jstt9L1iLLwsUmtl0E3P+UxWA23ex9kTM64uURZxxyxwMUq+Hj+MavtuJlNyCIgkkLCBzagaDG/
	vp/FG0Au10tKkIBvM1D6CLtluUAgfz8RGtmy659uBYA8VY6/HsBJyWM7tXlt6LJR6kQgtN9kwL+
	0fSBZffp0q08gVov6WAwJ9HwMLWbH8nwpZvBRwxiQZL3pQo+N0G8fkZcPbR
X-Google-Smtp-Source: AGHT+IHjnOlm+fJco/YyIPKGG5M4Tap1AmzYTMbe2McRmt0xHTs5Gf+13ljQ3AqWC5BlEA1RoawTVw==
X-Received: by 2002:a05:6a00:2d20:b0:725:1257:bbc with SMTP id d2e1a72fcca58-7257fcdd318mr1473227b3a.7.1733230481252;
        Tue, 03 Dec 2024 04:54:41 -0800 (PST)
Received: from nas-server.i.2e4.me ([156.251.176.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f159sm10349342b3a.47.2024.12.03.04.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:54:40 -0800 (PST)
From: Zhiyuan Wan <kmlinuxm@gmail.com>
To: andrew@lunn.ch
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy.liu@realtek.com,
	Zhiyuan Wan <kmlinuxm@gmail.com>
Subject: [PATCH net-next] net: phy: realtek: disable broadcast address feature of rtl8211f
Date: Tue,  3 Dec 2024 20:54:30 +0800
Message-Id: <20241203125430.2078090-1-kmlinuxm@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This feature is automatically enabled after a reset of this
transceiver. When this feature is enabled, the phy not only
responds to the configured PHY address by pin states on board,
but also responds to address 0, the optional broadcast address
of the MDIO bus.

But some MDIO device like mt7530 switch chip (integrated in mt7621
SoC), also use address 0 to configure a specific port, when use
mt7530 and rtl8211f together, it usually causes address conflict,
leads to the port of rtl8211f stops working.

This patch disables broadcast address feature of rtl8211f, and
returns -ENODEV if using broadcast address (0) as phy address.

Hardware design hint:
This PHY only support address 1-7, and DO NOT tie all PHYAD pins
ground when you connect more than one PHY on a MDIO bus.
If you do that, this PHY will automatically take the first address
appeared on the MDIO bus as it's address, causing address conflict.

Signed-off-by: Zhiyuan Wan <kmlinuxm@gmail.com>
---
 drivers/net/phy/realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index f65d7f1f3..0ef636d7b 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -31,6 +31,7 @@
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_INSR				0x1d
+#define RTL8211F_PHYAD0_EN			BIT(13)
 
 #define RTL8211F_LEDCR				0x10
 #define RTL8211F_LEDCR_MODE			BIT(15)
@@ -139,6 +140,17 @@ static int rtl821x_probe(struct phy_device *phydev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to get phy clock\n");
 
+	dev_dbg(dev, "disabling MDIO address 0 for this phy");
+	ret = phy_modify_paged(phydev, 0xa43, RTL8211F_PHYCR1,
+				       RTL8211F_PHYAD0_EN, 0);
+	if (ret < 0) {
+		return dev_err_probe(dev, PTR_ERR(ret),
+				     "disabling MDIO address 0 failed\n");
+	}
+	/* Deny broadcast address as PHY address */
+	if (phydev->mdio.addr == 0)
+		return -ENODEV;
+
 	ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
 	if (ret < 0)
 		return ret;
-- 
2.30.2


