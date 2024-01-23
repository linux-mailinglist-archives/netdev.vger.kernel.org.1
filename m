Return-Path: <netdev+bounces-65229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AEB839B52
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B7328609A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D7348CDD;
	Tue, 23 Jan 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNiG96RU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130D3FB3E
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046287; cv=none; b=OFOMgUyIp9IIaUyXtUFW0G45rh+D5wHeeHwUptlkQ/NXPI4ql8MaGMYXFZPL6SbGMB7W4NUHQ78KE1TtUVvjZK2U5vPtDk27IRMqjj+zKkOE3yoz9sIKHpffB13b1aF6OKCRlkxIVMpmuSIpkFZSTXtEAEPBRKP/CEq8WH+Ht3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046287; c=relaxed/simple;
	bh=vmYSQ06z2z9jiayeX1kvZ5B4z6AIoWWtEQhcjBq46Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/LGKeL1GP0It4AUgdgwyV8dFS0z+JTZjZ9qk/AIOcAi6/z+iuAO0fOEQzCPJi8hzp4tt86K4WdA3Vzt/FINY8aDbGAIsqmYxQKGNAXyyrle8pE0AG0tMwXP/cFARrBidE8mJeEbhqxcMCKyrWu89amCTmXoUv3vfPirYiq5A+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNiG96RU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71c844811so24047825ad.3
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046285; x=1706651085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX9ADtJkoKGNgdaN0isjkP2bY8ZIr+bXaw3HXIowkks=;
        b=bNiG96RU52iRpOr/kb1+5P8gel5Ij/7uO9fNiJJepB2HxsgSVr1NnH/gN+VGwy/qHu
         bXybxxKncDkgmnsniiuJAkQOx+5TLj2mrDiRRh/IiGo18lQOx6y5v0zYL0ljeBnm0JC1
         9tQ1oPl2ZDrhT34TrysD2q1c/UCbC0iA4s7XubHiL8ll9rY4zkyBUSzrCa07ABe5CboW
         ditYSdliLusVt63P26f6zEJibL/jghC0X5lzlJRt1I2UPI1j1qcmWBmAsBRAcCbpbDwg
         bkxBh8UlqMYlAyVRJ+wKk+SLAcc11DYSBnEo6Wm0J1tOcC/YYsCWsHT3N3pe85NdUl1J
         CTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046285; x=1706651085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX9ADtJkoKGNgdaN0isjkP2bY8ZIr+bXaw3HXIowkks=;
        b=pObwwBjHPQURWQN8vSAINJ6JYuAhIyOlRNT9jbEftpoWA+lZsFpcJK6/2mVn9vynTs
         SEJ++GAbv16hxGio8yLqEAyFyj6g87NH9XABf2REY6ASO7m958ecfIcZR+eDanoKDufZ
         oslJUJaBoeo5JWOSWbRv7aSIEebPjs0Y0dQj9xbZCA7gNoBCu/R/ru9wigu7hgibei9I
         6SdxRQxy9de2enbhHCe0cVxhOdgKGaIrP0aGCa2cD7fY1Kk8RCH0okWSpeC8chtWDI80
         TXvC1WuvWurRVi6nSiji/RgIGMyOJbcwMahpptV6bMabalmMH074f6RelxrZuUoaiRt8
         rL8Q==
X-Gm-Message-State: AOJu0YwYz90o2XtjHMAUG9EN9Vf/kXYyDFz+g2uCaHikl3esqB+ljfg9
	6dfgENPq/74kanYCesZMgRT5EQeRx+Rza8I5oKff8Vm1uY3WNMxUps9cNFWIZvU=
X-Google-Smtp-Source: AGHT+IEGRrb4ch/UvxwrUY/ti5jt49T7hUoVs7MWUiiytB/SHFhHhzpPOeP3FlYB8HCBu4X00fuCcw==
X-Received: by 2002:a17:903:120b:b0:1d4:e0e6:693 with SMTP id l11-20020a170903120b00b001d4e0e60693mr4910833plh.35.1706046284906;
        Tue, 23 Jan 2024 13:44:44 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8108858plz.176.2024.01.23.13.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:44:44 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	ansuelsmth@gmail.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH 04/11] net: dsa: realtek: keep variant reference in realtek_priv
Date: Tue, 23 Jan 2024 18:44:12 -0300
Message-ID: <20240123214420.25716-5-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123214420.25716-1-luizluca@gmail.com>
References: <20240123214420.25716-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of copying values from the variant, we can keep a reference in
realtek_priv.

This is a preliminary change for sharing code betwen interfaces. It will
allow to move most of the probe into a common module while still allow
code specific to each interface to read variant fields.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-mdio.c |  4 +---
 drivers/net/dsa/realtek/realtek-smi.c  | 10 ++++------
 drivers/net/dsa/realtek/realtek.h      |  5 ++---
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 22a63f41e3f2..57bd5d8814c2 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -197,9 +197,7 @@ int realtek_mdio_probe(struct mdio_device *mdiodev)
 	priv->dev = &mdiodev->dev;
 	priv->chip_data = (void *)priv + sizeof(*priv);
 
-	priv->clk_delay = var->clk_delay;
-	priv->cmd_read = var->cmd_read;
-	priv->cmd_write = var->cmd_write;
+	priv->variant = var;
 	priv->ops = var->ops;
 
 	priv->write_reg_noack = realtek_mdio_write;
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 618547befa13..274dd96b099c 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -46,7 +46,7 @@
 
 static inline void realtek_smi_clk_delay(struct realtek_priv *priv)
 {
-	ndelay(priv->clk_delay);
+	ndelay(priv->variant->clk_delay);
 }
 
 static void realtek_smi_start(struct realtek_priv *priv)
@@ -209,7 +209,7 @@ static int realtek_smi_read_reg(struct realtek_priv *priv, u32 addr, u32 *data)
 	realtek_smi_start(priv);
 
 	/* Send READ command */
-	ret = realtek_smi_write_byte(priv, priv->cmd_read);
+	ret = realtek_smi_write_byte(priv, priv->variant->cmd_read);
 	if (ret)
 		goto out;
 
@@ -250,7 +250,7 @@ static int realtek_smi_write_reg(struct realtek_priv *priv,
 	realtek_smi_start(priv);
 
 	/* Send WRITE command */
-	ret = realtek_smi_write_byte(priv, priv->cmd_write);
+	ret = realtek_smi_write_byte(priv, priv->variant->cmd_write);
 	if (ret)
 		goto out;
 
@@ -460,9 +460,7 @@ int realtek_smi_probe(struct platform_device *pdev)
 
 	/* Link forward and backward */
 	priv->dev = dev;
-	priv->clk_delay = var->clk_delay;
-	priv->cmd_read = var->cmd_read;
-	priv->cmd_write = var->cmd_write;
+	priv->variant = var;
 	priv->ops = var->ops;
 
 	priv->setup_interface = realtek_smi_setup_mdio;
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index e9ee778665b2..0c51b5132c61 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -58,9 +58,6 @@ struct realtek_priv {
 	struct mii_bus		*bus;
 	int			mdio_addr;
 
-	unsigned int		clk_delay;
-	u8			cmd_read;
-	u8			cmd_write;
 	spinlock_t		lock; /* Locks around command writes */
 	struct dsa_switch	*ds;
 	struct irq_domain	*irqdomain;
@@ -79,6 +76,8 @@ struct realtek_priv {
 	int			vlan_enabled;
 	int			vlan4k_enabled;
 
+	const struct realtek_variant *variant;
+
 	char			buf[4096];
 	void			*chip_data; /* Per-chip extra variant data */
 };
-- 
2.43.0


