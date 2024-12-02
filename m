Return-Path: <netdev+bounces-148212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8D39E0DB7
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5902827B6
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98661DF739;
	Mon,  2 Dec 2024 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRWf2WUS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FED21DF26D;
	Mon,  2 Dec 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174616; cv=none; b=SPzBFJixvAaK52kY2Hv72N/dXMTcpMKCRP95jbhfExQmlwm4fMSMqbOCI98QWZn0gTLxcKvNS2eGLGRNe/tIFMobfxRc646pERrwe8vagXhCdrQqqT8ySNoPpSMoFIia09x7Aqw3phLigFtP6darZEu/y+sXWrDtv93WLqi17vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174616; c=relaxed/simple;
	bh=pu3JL68bu1cSv6fdM/I/ECn8R8R6/lc6ICYA0qYjMkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rc7wUrLtnbuI/42vDUSCD5iuBQDV4DqOcqIPydC08SAvi4EDqA7PxL1Ic1IWgWbDFAqaLm7hPBOh7/npzyrB+2PAlP/bsgj1KBvtMoPgUnS7FbnQ2oDdeUSXws/gkutnjVeD0F4797qpgNWWrDik82RajRMOjx1fbZ5JtfcIxYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRWf2WUS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2153e642114so32538905ad.0;
        Mon, 02 Dec 2024 13:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174615; x=1733779415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYLEpqANoyEmd5NTjy3oJeHuyxF++RP3Dua5hSNSzO4=;
        b=XRWf2WUSLR9HOlUN5XoUGEDLRGL0YR99vZUR47kED5NVDsPd+GxbHhjlGWm4KNEHv/
         0/XE/g+MR6B3CiTGwpqGz2oo5udEkoaeiGysscvZCAlsHCOaxpbTqi9xOuFhBA74MEfm
         FjX9yzeImtukRTqHSSHpqBhJk76aL0ti3N4K4Ez+55cCR12OMp+CkB5z/N88SjwIzdfr
         pozhOXBsL9dyJgdHykrHi9YG2ucbH1R1avIggq/QXtsZfJ3aUthVYjl8CRLmxtqnI25M
         KEHmtd0CK1HV0wzC1DZvnnnqxb2Po57YLKVpR7xOUElhaDwtH9m2LjqmPNMhHo55JZrE
         dXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174615; x=1733779415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYLEpqANoyEmd5NTjy3oJeHuyxF++RP3Dua5hSNSzO4=;
        b=arlmFpB2dFak2NJ+1KhwlgaWATbwsyXORDZsY5Jh1X7ZAmTTsBXQF4L2b8aGkrj4tV
         QJSWM7lgPRclnhIRtYFuNQC5zsBf6Hi2bmzEz9a3Zz6fwKBwUW+5knIyzXKbIE8V1Y18
         GqHUz9gZmZlSQyJaUTk1VoDwSctysF6kKxFdMiJ19SEj2IdqVCK9BO9bn9eqyl/qd01C
         uh2dt9visGmrc4AzgfSGIDAAX4CeulEhfrtnZChw/I2ny2QgiOXoYupZQGF5RD+03OvT
         efLbIIkg4uWUfIDCIstRptRXqZjZCgX1DxZ12bSla2WUuYHaNCQCQLodqCF4sufqs9jS
         muDw==
X-Forwarded-Encrypted: i=1; AJvYcCUCyhOytCdSiMxaPprfktWHZ/YzWQNKGwfP4U8iYMAh4zIrUsoIrGyaDbMN6aq/jgc7JaFqWEJ8QlXOcFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkkFQqYM8lI6q9X5QVWDBl6dinet2rlp/5/7ATCzHSULosldA
	EnF0aa+Z0ADe+7mC7ajeH+ie+I+gbjCXefdH6NEjDxXoRfddsgMEsBtJK9gH
X-Gm-Gg: ASbGncs+qNmk5wfnqhtp3tJJHKcLGnV41mDVIy7j5rKGAFy1EmQcfK5VPRRW69+i1eO
	8Rr31slymMiZvy1AUkYpI/zDebLJH89dzT9b+GQDmCSl2ZyycvBm4E7r2Kuue65/RwcuBa/lDnj
	ib4TheNztJzm0udnw0nfeTib0CuB9THfErx6Es1uzs12nDDvF5p1S1H3mmL+lh6xTpMmho1x4WI
	3/wsf2KXMyLHAIzm8lziENYbA==
X-Google-Smtp-Source: AGHT+IHFfS3IU2Gj69V4BiMoyDgoz3RJ/anNr/fXp6LjBWwKcyPZQCzA9WannTWRwJSGYwqzHwoUlw==
X-Received: by 2002:a17:902:e5d0:b0:215:5a53:eded with SMTP id d9443c01a7336-2155a53eff1mr175456915ad.39.1733174614781;
        Mon, 02 Dec 2024 13:23:34 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21598f3281fsm20729515ad.279.2024.12.02.13.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:23:34 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 01/11] net: fsl_pq_mdio: use dev variable in _probe
Date: Mon,  2 Dec 2024 13:23:21 -0800
Message-ID: <20241202212331.7238-2-rosenp@gmail.com>
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

Moving &pdev->dev to its own variable makes the code slightly more
readable.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 56d2f79fb7e3..108e760c7a5f 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -409,16 +409,17 @@ static void set_tbipa(const u32 tbipa_val, struct platform_device *pdev,
 static int fsl_pq_mdio_probe(struct platform_device *pdev)
 {
 	const struct fsl_pq_mdio_data *data;
-	struct device_node *np = pdev->dev.of_node;
-	struct resource res;
-	struct device_node *tbi;
+	struct device *dev = &pdev->dev;
 	struct fsl_pq_mdio_priv *priv;
+	struct device_node *tbi;
 	struct mii_bus *new_bus;
+	struct device_node *np;
+	struct resource res;
 	int err;
 
-	data = device_get_match_data(&pdev->dev);
+	data = device_get_match_data(dev);
 	if (!data) {
-		dev_err(&pdev->dev, "Failed to match device\n");
+		dev_err(dev, "Failed to match device\n");
 		return -ENODEV;
 	}
 
@@ -432,9 +433,10 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	new_bus->write = &fsl_pq_mdio_write;
 	new_bus->reset = &fsl_pq_mdio_reset;
 
+	np = dev->of_node;
 	err = of_address_to_resource(np, 0, &res);
 	if (err < 0) {
-		dev_err(&pdev->dev, "could not obtain address information\n");
+		dev_err(dev, "could not obtain address information\n");
 		goto error;
 	}
 
@@ -454,20 +456,19 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	 * space.
 	 */
 	if (data->mii_offset > resource_size(&res)) {
-		dev_err(&pdev->dev, "invalid register map\n");
+		dev_err(dev, "invalid register map\n");
 		err = -EINVAL;
 		goto error;
 	}
 	priv->regs = priv->map + data->mii_offset;
 
-	new_bus->parent = &pdev->dev;
+	new_bus->parent = dev;
 	platform_set_drvdata(pdev, new_bus);
 
 	if (data->get_tbipa) {
 		for_each_child_of_node(np, tbi) {
 			if (of_node_is_type(tbi, "tbi-phy")) {
-				dev_dbg(&pdev->dev, "found TBI PHY node %pOFP\n",
-					tbi);
+				dev_dbg(dev, "found TBI PHY node %pOFP\n", tbi);
 				break;
 			}
 		}
@@ -475,7 +476,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 		if (tbi) {
 			const u32 *prop = of_get_property(tbi, "reg", NULL);
 			if (!prop) {
-				dev_err(&pdev->dev,
+				dev_err(dev,
 					"missing 'reg' property in node %pOF\n",
 					tbi);
 				err = -EBUSY;
@@ -491,8 +492,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 
 	err = of_mdiobus_register(new_bus, np);
 	if (err) {
-		dev_err(&pdev->dev, "cannot register %s as MDIO bus\n",
-			new_bus->name);
+		dev_err(dev, "cannot register %s as MDIO bus\n", new_bus->name);
 		goto error;
 	}
 
-- 
2.47.0


