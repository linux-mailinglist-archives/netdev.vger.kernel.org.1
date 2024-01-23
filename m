Return-Path: <netdev+bounces-65232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48122839B55
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4F91C213D6
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63C482D0;
	Tue, 23 Jan 2024 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2ub8z9F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446ED38F9E
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046300; cv=none; b=k3qa266Yxfiy/lq8gw3xR326e1sa3ht4xkx32jpW6lDShIPxQVrYHQyjfyNtBeS6/W7wrJFvPqfbOEf1DRPFY7EDtatSKSf31nSh4fX878AzYr0qUv/ZU6382bMLcHrIswaAQmagJnOzUQT+KMMNNmrxVuXClTK+pJf1QtXwAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046300; c=relaxed/simple;
	bh=qWeXnCBQSx9ijJmNkUoRa2Lf4+X7HfzKD4B4uSdXYsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzdyKh57zIywP2PoufGIg39GKqv4N20zuoezhYjw1wBRXeDzqAkZY+tfER4YF9pxnBcQOz8JY9rl4tFBUmwJLXUAMjwxvsuSVHCeqdkCfdz7DgRUMdz/lg4EdA6AGdGUOaV2dLXWUc4X4dpqnAbV7vC8b4QcPaTH0VTiAHnBlEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2ub8z9F; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d731314e67so14623055ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046298; x=1706651098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpzISrELLh4FOhQZGr6OH/1pWfA/oXb4P+4EgI1bf+k=;
        b=D2ub8z9FtefRZflVHK1BL/MVJlDCVY98Hrt53o/HZCx2pcCO3Hcv40X+7oT+qyu4vX
         5wn1lOr+0QM+uN9HcFRjj4oZLYCN+4J3S5+qh1giIJRQ07DyBkZUWQSwXLHAXNPvD/4D
         gW6xzs2oPxeRa/XvpB8hYL8+8J12AbMMyBdVZ8U1MOT90t0JpjBrJYZwp/YkUCniGpjF
         WAEGfxTgz21BanvVCi7adnWdwniaYEzD63CU9fFz761hnVTiUoj8NLjL5UeQ146yJum+
         gMnBQeWdfEviarn0fezxROmCLoadoMVg+fi+djEEmILW5y11yDl8nLZSD7VUEhN6coN6
         5rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046298; x=1706651098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpzISrELLh4FOhQZGr6OH/1pWfA/oXb4P+4EgI1bf+k=;
        b=MCwLgai4s3s20Jxy8rGsrE0sPnHydQ5u1tA0dz6/Qi/ilK+rzQOnOrY8O5Gh+tZrjw
         xtCAEdKw9sE7FemaUbFpOwaf3z3uago8GV2uIQDPRy5JBvI2OrT5+xZUF7CnKFH24C9H
         Gl0t+LE/1Bhe4+gBmfGmHymD8MElNWX9MEqm4GUUa351I33JHZtxDDePTlldGu4QuPwL
         UG1XUT+uTprZ4yqymlyw+uS1JsBkBWn/vGDryUu3daPpTuqZqTgKWf7PwtNYHKVK3FA8
         FwYsE3DnJJ3KGGGT+TM/Zg+j1soTXuD0CYCAuIR6ItaycPfkiUC7Kfm4Yut8QWwzfwG9
         roNQ==
X-Gm-Message-State: AOJu0Yw0yWI4ijix7vi5ZGROwkPyt8KHopdZLf3jvXQg0z9lJMPqQB7c
	Ss1UevUUzdEBbd4tzOdB3Q+zf4Wq5DE+GYMLgjj1OJFEEB4CHL3F0UC0/rlfuKA=
X-Google-Smtp-Source: AGHT+IEMP9hL0weuIWrWslnxpHJ/CS8zHRzK71B/JhNo6LdDoAc7W2QUYxclCNA0VSwe6ShfuxfRdA==
X-Received: by 2002:a17:903:2450:b0:1d4:b60f:1de5 with SMTP id l16-20020a170903245000b001d4b60f1de5mr4533912pls.26.1706046297697;
        Tue, 23 Jan 2024 13:44:57 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8108858plz.176.2024.01.23.13.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:44:57 -0800 (PST)
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
Subject: [PATCH 07/11] net: dsa: realtek: get internal MDIO node by name
Date: Tue, 23 Jan 2024 18:44:15 -0300
Message-ID: <20240123214420.25716-8-luizluca@gmail.com>
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


