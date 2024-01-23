Return-Path: <netdev+bounces-65246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2720839B96
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FD128A0EC
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A7C4A987;
	Tue, 23 Jan 2024 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF3AOsqw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16C48CCF
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047042; cv=none; b=ZOSRaP8lQf6Ro8zco31tJQIr4FlEXIO8cH5GEyGyLs6FkXJ2ENtL2iUto/YTm7iRAwsGCf02u1Coq9xa+b1PEgvPmpGA+caQn/dK1O0vP3f1lHW+QBCKxgDgtjWEW/wSUPqFE01WT7U4vQxQEdZjVP2/LJbnS8iJP1hfNqy36P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047042; c=relaxed/simple;
	bh=qWeXnCBQSx9ijJmNkUoRa2Lf4+X7HfzKD4B4uSdXYsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deGXk4G8N2kQslmgWanynCN2OeJ1lEqwCE8EGctkr7eNtysHtTgQWWb3bAVWTmeu8P2auNc86g1OriYY6k0it1yj0ybD2YQc5Umttw2prLxR7fXIOT2O/9Bcme327WUpr3KLeUVgxeiIXpt0osz5K8CJTMO1Fs7jD6gxJgkzFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF3AOsqw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5c66b093b86so4192886a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706047040; x=1706651840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpzISrELLh4FOhQZGr6OH/1pWfA/oXb4P+4EgI1bf+k=;
        b=SF3AOsqwkfBt9urIMlTJtVQf82zGlEbc4txQyXOXiVrV9gAkOVloKvOFBGcTq6JQA3
         n5gIVZi3Jf9O3y4jfE6HdsgeHD45w5tNewgZjvvi1S1lbqVb+si2oS3/lqpqHmG3E85N
         yGdRwwrHeJRMqzIyTiASgUSHF6GbO/4S8kR9NqATK1GGNFPOuFSk5iA59YwFHHj/ybz0
         1QrbOhFNkZHCrOvnd7Ki6cvT4/T/jIU0iT6aB6Soac/YyzGHnu3nooDAcCGx5S/inAs2
         /Bk0OAyjQJjbzr8RJJauNY5sD0ub2Uk1spsa7QDAHILSxCsGNaGsEaE/ZvPSLUQvOYkh
         j0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047040; x=1706651840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpzISrELLh4FOhQZGr6OH/1pWfA/oXb4P+4EgI1bf+k=;
        b=E2ZoMJhgreutuHpnNc7+wA90Ps6mkxTuckzY+2ejnwa6BVvmKxvgpat5eToXu3J2PS
         JCHlpi6riQeyCJUwmxp6PU2l8uC4i9z0ne633rWH5OQmLxZ93ioGB+ydKmMom45E3c00
         mHWv2D1Zgsa5NnVpGApfGbZn3bubIEP7PUf6avN+0fAHz+iHjkajX9LAc3+ZOYVp0R/j
         QVfnSSBGidx+M2VV1ub7/jTbfLT4ewDeyV3VWXr7OiTt8XzWs3syij36Fe6bnmRkBu2I
         1jSWn4OeJxPWY1oL0v6Zt0XUEXwlFpQmfDgxmiDJMkkhxniBqLkS8JMZKfj0Ct0N3sa6
         BANA==
X-Gm-Message-State: AOJu0Yw9tMwpB6u9o7ZOT8ei+tjPwB4/g2+XyECwVcVWctvxyEOSmL0z
	QJrG6QK17udu9GcBBuuVH5j/YXwA13kPArm5zXQQd2KEptO28wbRdtCcL8b0ZJQ=
X-Google-Smtp-Source: AGHT+IG6LEKhsDUjB73EyQXEAgb1kTw1tlyyrnCReGpDjvFG84vojMcvnfVi2NusiybZrQxiNkW0JA==
X-Received: by 2002:a05:6a20:9192:b0:199:29c4:b4b2 with SMTP id v18-20020a056a20919200b0019929c4b4b2mr308044pzd.29.1706047039967;
        Tue, 23 Jan 2024 13:57:19 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id q17-20020a637511000000b005d43d5a9678sm693738pgc.35.2024.01.23.13.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:57:19 -0800 (PST)
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
Subject: [PATCH net-next v4 07/11] net: dsa: realtek: get internal MDIO node by name
Date: Tue, 23 Jan 2024 18:55:59 -0300
Message-ID: <20240123215606.26716-8-luizluca@gmail.com>
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

The binding docs requires for SMI-connected devices that the switch
must have a child node named "mdio" and with a compatible string of
"realtek,smi-mdio". Meanwile, for MDIO-connected switches, the binding
docs only requires a child node named "mdio".

This patch changes the driver to use the common denominator for both
interfaces, looking for the MDIO node by name, ignoring the compatible
string.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/realtek/realtek-smi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 5533b79d67f5..0ccb2a6059a6 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -333,7 +333,7 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 	struct device_node *mdio_np;
 	int ret;
 
-	mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
+	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
 	if (!mdio_np) {
 		dev_err(priv->dev, "no MDIO bus node\n");
 		return -ENODEV;
-- 
2.43.0


