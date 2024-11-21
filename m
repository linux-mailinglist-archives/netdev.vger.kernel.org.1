Return-Path: <netdev+bounces-146710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BFA9D5372
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 20:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEE21F232C8
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8847719F410;
	Thu, 21 Nov 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCjcgf+O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4891BF58;
	Thu, 21 Nov 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732217517; cv=none; b=SzlTr/uCeQY2DTk/nJ70/1tIuNg8JcuCPVx0wsKYAyGHIValjbmCDtSfW+aqYPPUctKMOrU9H7CXl+By9Pv7zV1Wntb+WNXwgWHrzn9/8uMVRdEI+6zPGShlZlBCN4x/2S4BmIxwUt3uzZHwQpbI3w/ghLbhVVlbzzkKnwba/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732217517; c=relaxed/simple;
	bh=MvaNu37j0qKgIdAmvES0uyYJ5DZz+30ysiV3IVhWAbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1+Al03S1P17XxUF6IUUIEb2mz2g5rEu8gWWNzonre2NocQXzUBYuwvIHCssXdkFu4/Jg/ixq8WFllnRZzAeIN8vvcBvYl6wbZW1hjhjubI1xja51bVtcUbZwM9/q+GlnrKjB+LSk4iwe+LVYdPESX4KPgWgHAarPpPW7TsPadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCjcgf+O; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so1119760a12.0;
        Thu, 21 Nov 2024 11:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732217515; x=1732822315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNIhcxypDnsIbc6yQ4fJxnMOmRFIClqOWVZXvMP8PUs=;
        b=gCjcgf+OJobADR7ksmxmbEhh0l6qLfurmmKUVbWSqVLprIR4RD79TOrwYfXUnhUv/D
         gDM2bgj9CdAi84LMobFmoHipHJNZ2DAw3TQZ0hRA50cr8jt3qf4vCj8XRjEbgxNaLoJP
         pIvHQx7QI4js6WZuCrRyPeUV9caAOIbvhuj0FN8nHPlzCjXuQnG6nXF40IuP0IGVtFDn
         CdO2i+Vw/wCNGBVTMgPBOjcvualMiJ2nm+q9lCqKgvvZQutPqCzBwVSldsnCBFNAuSV5
         sWi/eO8iQX6VE1St2ZMdheCnMe48wvAWJfBMxFzSfhowFO/No6ewEFyTafV77Ro0rqkQ
         9YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732217515; x=1732822315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNIhcxypDnsIbc6yQ4fJxnMOmRFIClqOWVZXvMP8PUs=;
        b=k/ZVmMmd9MGjA1wxKnUKNKtzCPdvcFpexIbbQR8gfsL+Y4PGIltQlK3QtCzQGmbDVO
         l7L2/F9xpdaWn7K4ZUslr/QDDdV7hgP1dnfQg6zRxKavYDXJU2nygmtXhfbnzGOIQebQ
         hfCw/r7lH6HUumde+3Id/uIwlb4/nwI7dgdJeQ+GqVS3GeGmt40d8rbrfV8n26CG07p4
         cQTYM9Cg7D1clBONdJXQDWoZQey5d3cH270mR957SaXLCGPw3lwKvt8KwFobVnsSPokN
         g4pWDtEh6pjhbvD7pQqU/DhpQKk+KFMa+NtiKqO9XHh6hd+XvujV4Ko6YQHmjWtKRzXI
         +n+A==
X-Forwarded-Encrypted: i=1; AJvYcCWrHYhhd0Uo8rg7F+K9tGY1H0q12LqzzPK/LJxgQY3zgXaOoUIVpIARW572wUVHAjTcAisLdyuTNaqERp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywDoEY1I5o+9cN/JsIqR0AG5DttILvA54EwvBANU1Vw2t2cKe6
	cuNP0iFyhzZtKHrNClD+Oj88hIiU6DHkV+xYTyhYhANpsLTcC7dR6g0Yag==
X-Gm-Gg: ASbGncv1NK8i4BEsfY1EAKcd76Xt5JPRUpY5XmIn+Tzs0K9x+Ran9jm+s+J/5Ul7PVo
	fW7TxJIYc6Kk9HCI5nIN16qRYPdAXKmslbTYEUHPm41QhX420cgJrxhd0iRwzf7UCg5nGEqfg3G
	hdDwc75npmPb161Wt0zHxvo7B/qgcbVmNvM+8k9PGf0pjXnHoi8pHC+figCe1EA96k9ghfkV+lR
	sOpLfa8Lr9g2VOxTyF1wmLfoQ==
X-Google-Smtp-Source: AGHT+IHiPJr8ZRhSElM3gWtkAT9jnA/lg4I23bV1+e+T27Y3cXMLZvsbrEU3xomvpNrUGOuzlTO+1Q==
X-Received: by 2002:a17:90b:3c52:b0:2ea:88d4:a0cb with SMTP id 98e67ed59e1d1-2eb0e22d76fmr25984a91.16.1732217515161;
        Thu, 21 Nov 2024 11:31:55 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02ea680sm3647247a91.8.2024.11.21.11.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 11:31:54 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net] net: mdio-ipq4019: add missing error check
Date: Thu, 21 Nov 2024 11:31:52 -0800
Message-ID: <20241121193152.8966-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an optional resource is found but fails to remap, return on failure.
Avoids any potential problems when using the iomapped resource as the
assumption is that it's available.

Fixes: 23a890d493e3 ("net: mdio: Add the reset function for IPQ MDIO driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: reword and return on error instead.
 drivers/net/mdio/mdio-ipq4019.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index dd3ed2d6430b..d9a94df482d9 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -352,8 +352,11 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 	/* The platform resource is provided on the chipset IPQ5018 */
 	/* This resource is optional */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (res)
+	if (res) {
 		priv->eth_ldo_rdy = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(priv->eth_ldo_rdy))
+			return PTR_ERR(priv->eth_ldo_rdy);
+	}
 
 	bus->name = "ipq4019_mdio";
 	bus->read = ipq4019_mdio_read_c22;
-- 
2.47.0


