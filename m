Return-Path: <netdev+bounces-148214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FB49E0DBC
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07F2282640
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9021DFD9A;
	Mon,  2 Dec 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpNSlh/V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0E1DF974;
	Mon,  2 Dec 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174619; cv=none; b=aBM3qdoctt1ssiBS+66twRG/0d0MwogzmT+70ZAjm9rt+PqJY2ePcEIVb6OAiEwxOqqu/McJcmlVgE21wkgZb4OAbBbqpn4v78FzQ81QUeTHnSp84lVSZDM4i3lrygb99xlNPtliOBLscQesV9YMnoMk5y2M0GSipncXFfYGtX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174619; c=relaxed/simple;
	bh=UEe+01wXcA/6Vp2tXaLjKWUBpnQy8abf4E5ymq4FAlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcPdSaVOdpIa2xPeytfQjzkZyRmNqCtdkT/x86libvKLIZ7jOOARi8pcrxRO8wAbOkKh66pNrr4XileDIx+CHbCouphV2OemAuhlPpAlH/Cu35icf3hB6LRTSWJ5iAnXieTtw+wVEI/BwWclgku85pFJbox9FAqXs4bBfOC2Mp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpNSlh/V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21145812538so38297065ad.0;
        Mon, 02 Dec 2024 13:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174617; x=1733779417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCzzR8j2iKtf3UdeUk+5jPhNrUS+V0xjiwUoH7xZuyk=;
        b=kpNSlh/VDIeEe9yBJOor9nDRSU/yqWWdpHmKuynyymYCKuPfm/7qYa8ktDiB2g9eTi
         9r+NFooOAyplpXVXaFtO668KmXCm/oVqkVt0eg44+O51Ot0J8/IudI56SGYoJKjoh4cH
         BDJ6lXAwkrCnQ0IijE+SzISoFsC3pNtcMOzmHuBcaPAC1BZQV+H70A/JtXUx8NYW0dkX
         tL7WT1vPqKlSXpyBzBjecW5CiqPU/4ODzj+dHXqxmKVoxNmLwNrl1yI8wF5XnFsl7pAU
         oTIifxWRSmSTXK0l3LEBwl32tFcLMJdPAYtDknEC/tfsllC2la5rebDQJK4FzG/uRAOG
         HwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174617; x=1733779417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCzzR8j2iKtf3UdeUk+5jPhNrUS+V0xjiwUoH7xZuyk=;
        b=sm5lY2it41IEYWhTsMv3LsiBA6/yCeds3XCwEEGKL9CUGai5w3ixEoer2PlmoIR9HM
         CuJT9mCexH95QUqw75229WHWKxw0uTHzGeaC3NZ6WaHv/d5KZmVEvgtHeIrv/0aranC/
         V8XV/X3MxNSAP8CazHbJ9IVPkWqxTiAmuFE8bxMJglGZeLgwU3l7FPu5tCmq+/kJjxtG
         HCwqdPZn/1u9yiPdulbnzXVRaCps1w2jsgz+o4UcSZ/Xl37dn18qK1r6fptx3VFvyX6N
         oTWSMDBibXBtm4vj+qAo9RkRgggOYfcDrEKRIT5DwYN3hRr0/5BtMavbvzXrfcs7GTms
         KiBw==
X-Forwarded-Encrypted: i=1; AJvYcCUpKQ4cu+ZXSBmkfF2mXVMNiRfmSRd5uJG8I0vg8FVEiuW6LUE6WEI7B6w9aO/jZkUpWavepY2/YGZI7AI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvjddhgdhxl7wf5q5ogjuTTUXnSCu1brJRET/KPPyqtGDrW2Y8
	4MU/byBHO/AeFlevYBo77uzv/vUEAi73a+CWk3thDL/x7mn2qbF1lEnYADMO
X-Gm-Gg: ASbGncsuqzr+hBbxcNc40rXTSBG2f/ewEYZJEHCoFAn5ROSQUY1sOs4GWho5dwBlQ3L
	G7igZq/rPKPrbXUotknO2dJWepv8nYzJ9xcbecteDWIRM4zObPzkc/NInbrMMXxc415LL/GgqjA
	bxkwvbFLlGcU1YawK/hUHyWy409ramXeV2WLJOcDrdnDzKeKwzcaxAd43kmI4VlO2ZrG21PkNNm
	/2dw3LsEi7J4WAvl0poMOq3Ug==
X-Google-Smtp-Source: AGHT+IE4lBI6lzn4RyCfB1wFHwD7sFSecH49TpJcGomfAcAWTV1f9q4iLVA0yjhRU/LwrGSu6p1yig==
X-Received: by 2002:a17:902:cec7:b0:215:3661:747e with SMTP id d9443c01a7336-215bcfc5c76mr608535ad.8.1733174617312;
        Mon, 02 Dec 2024 13:23:37 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21598f3281fsm20729515ad.279.2024.12.02.13.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:23:36 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 03/11] net: fsl_pq_mdio: use platform_get_resource
Date: Mon,  2 Dec 2024 13:23:23 -0800
Message-ID: <20241202212331.7238-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202212331.7238-1-rosenp@gmail.com>
References: <20241202212331.7238-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace of_address_to_resource with platform_get_resource. No need to
use the of_node when the pdev is sufficient.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index d7f9d99fe782..f14607555f33 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -414,7 +414,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	struct device_node *tbi;
 	struct mii_bus *new_bus;
 	struct device_node *np;
-	struct resource res;
+	struct resource *res;
 	int err;
 
 	data = device_get_match_data(dev);
@@ -433,15 +433,15 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	new_bus->write = &fsl_pq_mdio_write;
 	new_bus->reset = &fsl_pq_mdio_reset;
 
-	np = dev->of_node;
-	err = of_address_to_resource(np, 0, &res);
-	if (err < 0) {
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
 		dev_err(dev, "could not obtain address information\n");
-		return err;
+		return -ENOMEM;
 	}
 
+	np = dev->of_node;
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%pOFn@%llx", np,
-		 (unsigned long long)res.start);
+		 (unsigned long long)res->start);
 
 	priv->map = of_iomap(np, 0);
 	if (!priv->map)
@@ -453,7 +453,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	 * contains the offset of the MII registers inside the mapped register
 	 * space.
 	 */
-	if (data->mii_offset > resource_size(&res)) {
+	if (data->mii_offset > resource_size(res)) {
 		dev_err(dev, "invalid register map\n");
 		err = -EINVAL;
 		goto error;
@@ -480,13 +480,12 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 				err = -EBUSY;
 				goto error;
 			}
-			set_tbipa(*prop, pdev,
-				  data->get_tbipa, priv->map, &res);
+			set_tbipa(*prop, pdev, data->get_tbipa, priv->map, res);
 		}
 	}
 
 	if (data->ucc_configure)
-		data->ucc_configure(res.start, res.end);
+		data->ucc_configure(res->start, res->end);
 
 	err = of_mdiobus_register(new_bus, np);
 	if (err) {
-- 
2.47.0


