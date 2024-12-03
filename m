Return-Path: <netdev+bounces-148333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C229E1267
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 05:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 436D3B21EB6
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42041146A69;
	Tue,  3 Dec 2024 04:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtleUhES"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C886D2BD1D;
	Tue,  3 Dec 2024 04:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733200003; cv=none; b=bxxqikP+0D/9zPW8/DSRI6y8MUKn5e3YzwjV2MiWCZTKJ2/i1QHabC5JCd4fNp0WPPBwg0uMbXp04o92AIjHYGRtYTwtKtWGtL+yNG7HqE9H8pIlTD2hlTrrszCJ3GC8YSK3b0lv57FbhuN0v+jA12SAgZ//m99T/gtSOQ/D9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733200003; c=relaxed/simple;
	bh=K1Vu1L0HLzL1ggJymF4GIWCvoKHTnpnZvrRz8i5oRc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7Kjc2jhquRNdlg8yi94KRvMCE6fGWRcWygBYp/Mk3JW0f35BxYuEzmE2F7XzV6g72C1MlzRFbKmfA4Jmw9eada2D+NoQ1h030kJ14ZcFmz+THdVwVr0g/b045xaML20jOdiAmouQqC0HAW6aIGGl5SIbVcPh1NLh6esuJJPs0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtleUhES; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2154d8df140so4299075ad.3;
        Mon, 02 Dec 2024 20:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733200001; x=1733804801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt0eqAzlepSF0XS40uHuceUpxcC/1vIW2KGLShCrnRY=;
        b=DtleUhESofzrT3BGzACLMRtZIEdUNCq3p0DH55Wo0bnjIJpckV+XyysCWZFyEa3bmq
         UArQfXQXT+IbcNYrAyFSG0wDjWhtCsQEqackF47Wgqk7IaNw63zfxoO6rKjzUftDZxTT
         dNgAXSOG9zZfA6B58OeHSAKmHggd2x/JY4RIlMCtig1w7JA4X4E1GbhOJ/9Pn/viRg1k
         50m9xZMEX6aY3ZBnvNBz9stbMJiwES/jcEoZRp/Z4inOxAL0q0awPgX6sXSVO2qxE2X3
         0c+wJxUpYIQB/wx9K0uAaw0I5lWtaX6Tm342DCjsP7dZIf0Bm27WZx/CtXTaNuQqZt74
         yLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733200001; x=1733804801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yt0eqAzlepSF0XS40uHuceUpxcC/1vIW2KGLShCrnRY=;
        b=QGHzk9KUUEaZM+q9Qxd7cMiQh6eIJxcUTC/P+OoFvR8CzkmAcidS5Ljoa58B1DfDZH
         dgdHcl0NW2hAJMlxjxHMn5ADBW5qm4aoaxw2xJH2dGDnZ3jUghTpnJEXlQYh9XmUUd6c
         fXfZp/OI8BZY/aVWzeZagtIpQE5DFAeF0xkjTqSlQMlH++ThMQKVCDznhWbevyVsUPXy
         rHq097LLD8CvIdTdUF+NXkXSjj+5qXjNPZ+n8aZjldN+/ZqsSwzAfgp0rLiwNTtJnzKd
         2FRKPMzpVLvfQ0pM9992BKFL7A3RgcKZd3wZ+mSDPJoCMTX0gCRYM6Anxt/nBWrqS7Gw
         gddw==
X-Forwarded-Encrypted: i=1; AJvYcCUNceRUeA4FkbOwsnLMhwFpp8nQ05xYCHwy/z+CL6yd62Agf64pmwtIMf2Glf2xexuh99Fu+o+K@vger.kernel.org, AJvYcCUtRygQRLYzQMKo9LcTlHs8C98n9MJwdC3UTg1UA4ipYfuQ/TKMWBSIYlTVbdo8ml2qMc1s9og1ymsSyoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+wdYz5gKVZi63LXH8rGbonbDiP10lYa1cHUbO4sX3s51Hdukx
	hg955+l/vt66ZBU4OUULZC6Q/6zOLYbXiT/Rj/bmPoiimn08+ScGz38lq5/Rt9G+lw==
X-Gm-Gg: ASbGncsAJtI2K7FMtud1/l16wk6d++aIp0ErX3+u+mDbFSLGK4v5SNHm9PXTZ6yJIbF
	NbiqE1SvfPIsgHXTr1sFA6vIRg2u/JPl9+j9Id6Xt6YjEOB1CBs8PtAakyVAv6a+r/gjaJZ8fL8
	0ZpNn3OYIlMQbe1pZ/5MlsrXHiS9LEqInDJpcS7ceHLTOaiRMZBgrbdDiFKVcenVhpGBzLnQskH
	koIV5FAQsXc9rokJtXyvAUqVuMS23mT45FfiP5OpsOlbausUs9tCRgBEAuR
X-Google-Smtp-Source: AGHT+IE3nK/M7cJqpQVJlVYGk8slh7WMLKkCFhcvzABTJpf+voMAAc8Q5Kx3WUuAbOVvTgny1XeiXA==
X-Received: by 2002:a17:902:f607:b0:20c:c482:1d6d with SMTP id d9443c01a7336-215bfb0c0aamr4082105ad.8.1733200001049;
        Mon, 02 Dec 2024 20:26:41 -0800 (PST)
Received: from nas-server.i.2e4.me ([156.251.176.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbf52sm9365311b3a.119.2024.12.02.20.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:26:40 -0800 (PST)
From: Zhiyuan Wan <kmlinuxm@gmail.com>
To: andrew@lunn.ch
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy.liu@realtek.com,
	Zhiyuan Wan <kmlinuxm@gmail.com>,
	Yuki Lee <febrieac@outlook.com>
Subject: [PATCH v3 1/2] net: phy: realtek: disable broadcast address feature of rtl8211f
Date: Tue,  3 Dec 2024 12:26:31 +0800
Message-Id: <20241203042631.2061737-1-kmlinuxm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cb8b5a36-fe5c-4b10-ac28-5f31f95262ab@lunn.ch>
References: <cb8b5a36-fe5c-4b10-ac28-5f31f95262ab@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This feature is enabled defaultly after a reset of this transceiver.
When this feature is enabled, the phy not only responds to the
configuration PHY address by pin states on board, but also responds
to address 0, the optional broadcast address of the MDIO bus.

But some MDIO device like mt7530 switch chip (integrated in mt7621
SoC), also use address 0 to configure a specific port, when use
mt7530 and rtl8211f together, it usually causes address conflict,
leads to the port of RTL8211FS stops working.

This patch disables broadcast address feature of rtl8211f, and
returns -ENODEV if using broadcast address (0) as phy address.

Reviewed-by: Yuki Lee <febrieac@outlook.com>
Signed-off-by: Zhiyuan Wan <kmlinuxm@gmail.com>
---
 drivers/net/phy/realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index f65d7f1f3..8a38b02ad 100644
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
+	ret = phy_modify_paged_changed(phydev, 0xa43, RTL8211F_PHYCR1,
+				       RTL8211F_PHYAD0_EN, 0);
+	if (ret < 0) {
+		dev_err(dev, "disabling MDIO address 0 failed: %pe\n",
+			ERR_PTR(ret));
+	}
+	/* Don't allow using broadcast address as PHY address */
+	if (phydev->mdio.addr == 0)
+		return -ENODEV;
+
 	ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
 	if (ret < 0)
 		return ret;
-- 
2.30.2


