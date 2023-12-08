Return-Path: <netdev+bounces-55177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91978809B2F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 05:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324F21F21141
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 04:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF74C87;
	Fri,  8 Dec 2023 04:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZJI/Jh/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE60912E
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 20:51:49 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c690c3d113so1407936a12.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 20:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702011108; x=1702615908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0eOfB0tKM0JaOpVnqpzW1lSQC85X8TE4EuRnyccUbg=;
        b=LZJI/Jh/ySCGsBQclOZjvR4oPpfay/4pqN6zXh3xh+FzdiZUO2m7Ao2Iaq5QNQ66l6
         Ie+ehE+1HHuJag7gGCsACwBVz1Iv6OiFllS08QombKYk/Qw2wRGMWdOTwkDLjrHL9bbw
         fYUWA9mEY126E3X9sxKBDlYpAgQy0CAnnv17/27TEFqANTtMn6Nq5kcpzNEvRC1rE/0R
         0AtB74qKNHtIJ0WQoIrSzX/WyRE4tTDbjrSOmEIg1AiBlPXIgYTLYyu4AZlPCH6fQmtb
         +5Rb2Mm2VJ37NhlGs6DpTDxY3fuL3L9OBpm1nokYlWiTV1oynx9XHy+yvZyYkACyCcbB
         etCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702011108; x=1702615908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0eOfB0tKM0JaOpVnqpzW1lSQC85X8TE4EuRnyccUbg=;
        b=GyxM/0SWVPTyyVh0SPdYHBZY72AUNtFc+kMJjsTAfssSVLqj25nkxMUSlfNw8o7Fnv
         /AI3k9fL6gXahI5SDCVkVC4Jihp81JZDhOUahlnIzvoN5bL/jSneEiIc8BDSY2Cko3TA
         GomNtZrMEIqLEFtnwLV4ttMO8wC1QYZIT5qKVzyzHsnGH6ze7JE7Cwlq1i1y7W3Frvqj
         u87UhBhoI8SY/Ep6Y/fT4mNnEbvpOiSihtBJHwm6SZWmV/um24XI9aCuZhYhtnoXZ//f
         R3MNKMzfHeqFmCpvxHPOWzRo/9XZFHx+PuCw1IKaZuBUc6lUrd7BFZg9LoUVZgElQHzY
         MfIA==
X-Gm-Message-State: AOJu0Yw3dYHNp65oIHWjAElBSrDBynPsmvM+frBiQGCui/eQ9zadGb6g
	cTsVueDe9NXTiVQUM5DgFhc90B4f/sCezG3x
X-Google-Smtp-Source: AGHT+IEZ8ac1QH/jpF4haqvMomFDcSo8iZPE3X2QwxWDjVsQC2AOB6NJwOMPGEargmYoR2ii4k+MSA==
X-Received: by 2002:a05:6a20:840e:b0:189:bde9:9cb0 with SMTP id c14-20020a056a20840e00b00189bde99cb0mr4966326pzd.27.1702011108287;
        Thu, 07 Dec 2023 20:51:48 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id f18-20020a056a00229200b006cbae51f335sm657865pfe.144.2023.12.07.20.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 20:51:47 -0800 (PST)
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
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next 2/7] net: dsa: realtek: put of node after MDIO registration
Date: Fri,  8 Dec 2023 01:41:38 -0300
Message-ID: <20231208045054.27966-3-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208045054.27966-1-luizluca@gmail.com>
References: <20231208045054.27966-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we don't keep a reference to the OF node, we can put it right after
we use it during MDIO registration.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-smi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 755546ed8db6..ddcae546afbc 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -389,15 +389,15 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 	priv->user_mii_bus->write = realtek_smi_mdio_write;
 	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
 		 ds->index);
-	priv->user_mii_bus->dev.of_node = mdio_np;
 	priv->user_mii_bus->parent = priv->dev;
 	ds->user_mii_bus = priv->user_mii_bus;
 
 	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
+	of_node_put(mdio_np);
 	if (ret) {
 		dev_err(priv->dev, "unable to register MDIO bus %s\n",
 			priv->user_mii_bus->id);
-		goto err_put_node;
+		return ret;
 	}
 
 	return 0;
@@ -514,8 +514,6 @@ static void realtek_smi_remove(struct platform_device *pdev)
 		return;
 
 	dsa_unregister_switch(priv->ds);
-	if (priv->user_mii_bus)
-		of_node_put(priv->user_mii_bus->dev.of_node);
 
 	/* leave the device reset asserted */
 	if (priv->reset)
-- 
2.43.0


