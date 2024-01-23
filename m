Return-Path: <netdev+bounces-65243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC02C839B8F
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53404286E7A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518D2495E4;
	Tue, 23 Jan 2024 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFHtSZGC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F54E1CB
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047029; cv=none; b=MjTqeu3meWdM3ccSuLs2HhlAQ3G5bu0bQx7qhWXj+3TSbapsyn0bqDKmAwSlFkrcdk83VHvfGlokxGZ6lK5k0mpb+fkBB9Uuo3Wm16lAU+AMZLJ9RKTnWEokHY8IChO9NVRC+tu6HN4fzpFuy+DhIqNaZ859dmXAWd6Vcs4Ki2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047029; c=relaxed/simple;
	bh=vmYSQ06z2z9jiayeX1kvZ5B4z6AIoWWtEQhcjBq46Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+o57VUNg8Qf5JLeqXI9mcFLewoCskT5bcIrahlxuEpV9uybCZUmXg1nX010vbUp9GT4wMuy7WkE9rh98M6P5yE5Bp1JkTyUeMIVDyaSh3VaDpikGUH/iBPJCsiPKHx8lzLiuum9dXOMVRo/UPtKIqnJcIgiRmw/cMGi3s9SyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFHtSZGC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6dd7c194bb2so770531b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706047026; x=1706651826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX9ADtJkoKGNgdaN0isjkP2bY8ZIr+bXaw3HXIowkks=;
        b=DFHtSZGC16yW3DPAhUT64AEZyf92jlYrjmniYoucsJLky9oKoLIU7PdmRA2H64S4Pl
         i2GP1T/NvlBCXpGmI2A/GZxhmb1tw6UCI38Yn3y7zPAXqFaYCMBvnP6nSgx2fctLvurZ
         rX4kAK8X1b5nrj0rQGIJML9LW30EpYFVImaLMsemo5Tugz5J/herG2Qb8xYynK2BlRLh
         7a07MLyPWMmeOrAPbLC/03sDh3lr11NZQSHMyyAISrEvQMVGsQOAHWqR5yzU7EH7XvfP
         0HPLxGvbXSIzc3e3nfu119qLg4Tqyv+MHXi7tbZjnOmicjxbzhoyLGBToeUIBcCrTt0T
         MXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047026; x=1706651826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX9ADtJkoKGNgdaN0isjkP2bY8ZIr+bXaw3HXIowkks=;
        b=qFEC7u8fxnev8PKcPtCxT18eammbOtlDd/Z1DQnWq6ETaD3Ul6WxreYf5DA2BuxvGh
         4FcMvy2QFSo/BCtxW5nJDpyd4rMhrGH3DmWurX0LxkCLZMZMjBSfYoT/C92ffh3vzL5o
         B1grmDSuKjNeBYlcbEPtTStRMbNsKm5rgV1rYjD+ec+ZsjA37fPHgK8zoCwRUL/4Yg6M
         DraiUKD0+edPTMDRfIM6ER8MQtWhwFQBM3m9uI5kMCIR2DOo4gfbp8nnbmzlgbcpy97O
         ZaS9Ja6sNSBNOrBSt702TVxvSV402nYsa0G0DW58KAFXKdMmoBizc361LJBLI/io8kPs
         imdg==
X-Gm-Message-State: AOJu0YwV5AEhadzUFmXxyj/QUH7j+0DITDA9j+eze4I2nXVGExQgmbxz
	WrXfWtKcLVmSZO4HMDRSZzMgLrdKFqMARc1pD0Y4SDyitEx5BF928lsygE5+LDE=
X-Google-Smtp-Source: AGHT+IH8dmMlFzjy4F/190hMOtYk2XuqQDSRLoqw+p0FTmQLImbniafiylG0YtFVS4yR8pFh3HxWfw==
X-Received: by 2002:aa7:8885:0:b0:6db:d5b9:7b4c with SMTP id z5-20020aa78885000000b006dbd5b97b4cmr295782pfe.25.1706047026080;
        Tue, 23 Jan 2024 13:57:06 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id q17-20020a637511000000b005d43d5a9678sm693738pgc.35.2024.01.23.13.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:57:05 -0800 (PST)
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
Subject: [PATCH net-next v4 04/11] net: dsa: realtek: keep variant reference in realtek_priv
Date: Tue, 23 Jan 2024 18:55:56 -0300
Message-ID: <20240123215606.26716-5-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123215606.26716-1-luizluca@gmail.com>
References: <20240123215606.26716-1-luizluca@gmail.com>
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


