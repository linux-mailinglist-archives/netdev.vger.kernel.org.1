Return-Path: <netdev+bounces-153207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C839F72C9
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0737B1891595
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719AA146D6B;
	Thu, 19 Dec 2024 02:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="D4KhuwMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8F08633C
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734576089; cv=none; b=K9xhr1VBr7BW3E7nevpJdo49IQWVYeZ8vAL03atbrHcNmL0IzKVp1HaVsKwIK9NNKzhivhuahuTC/+bzM/Py029c6g9kjmpbDN9CnXtHwUf8kcTdDSARM/V9u/ukpQhtMDYT7looGHl0aAWMe6ykJn8KsB2zFjN+xFmRy+yi3Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734576089; c=relaxed/simple;
	bh=/4MTAvUtI+j2NCFXL7PQSk546LG10ZUfqFA76u345QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JDi6+fOIm+m9YzFVQwQlotU9xTZH+ztCjKFqTqOHe8okeCPtmQrwA+67iPy2kVfvHz8HcwL5cxmham5sL0F1AOpyQzD11M7TOEtfukBlreOdagrwUPg8LA8sQMzkQJ/TjUiXK7c99+cxTc31wUujti/kay8YdiQSCtI4T/jspHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=D4KhuwMZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21644aca3a0so3550685ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 18:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734576086; x=1735180886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I9DRavtsou8O4F8YROWlZTTFFjJ6hMgUQx0QlXTX+xg=;
        b=D4KhuwMZiX7vye9dwyLlzFzXFf5OD2z0gIlD3DntZ7m9Qb60IHY+HI4J7AAsKuxr2E
         f4CRk1MsAUF1IjF0pFuIBxOfmxnJZfMifn0YWDApp64dm+xS1AP7HcquUAoIVRgdx4au
         CJ6x2VrasvdVgDlceeDIZsqPDXZBN7DdHk3w3c2k1kB6Tjd2q6YPtsI3wOGeyEEXazuD
         e9maB2pAUdj/H8yuw3xo6PXzrNDhjLrxmImcIyq4d82ZYrTg9IUcd/9UqD00U+MItyOT
         L81i/n9I4dggqWCBVBkvQMxAn8VLTJDcXRk2PxWSNiZslRami08QfjXv6W1mLSn5votN
         RIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734576086; x=1735180886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9DRavtsou8O4F8YROWlZTTFFjJ6hMgUQx0QlXTX+xg=;
        b=H1sK/9+/9ZGlhQJkBrZcSB3waztIMfLg0SCXTzpaZtUxT8Qdyp3aipBkAqJfcw+pgO
         IacLYsUJCjD20Hj1zhW5i96MCRCTb/+Wf4P1IyHtrOWsu/8h/9rlmW2BBnWbEvZE/0y+
         fD5m7n070+Ug9+gl9Ft+psM6e+pcdDgYPPWeRHR3JyiXN4gnASTi8+UWh/MX6QbIbp/u
         8usCkNSjhADB+mVk3yFJsSEb7kvsOrc4Akrb5KCRbwdtwdW3M4t4mm2irhjOdp+Ald0w
         PIKy+QsiwPGvURJK+5V02Li25wtYFXkDsKVT0H3AQlRY9HniNoEfe2CE9WN/7e5SQ/if
         K0JA==
X-Gm-Message-State: AOJu0YxP74tcLtFSbVmztTeNJXjY+zV7j56L5gnqRt3y8deXfE7UyTOU
	yI5VCmQUtZxbRchdpQi8UKIkpV9eLz1npM0Pda5nFEuxmhD0ICHNve2tks8zSQY=
X-Gm-Gg: ASbGncu4SCnRRGWpRFrE21HJdddtjOhvvCRYW4JfQbtbt0NSrjLGqH6W0vugjI2yQV4
	4wBLNoQzgbqVjjA8ou2CLtqK2qo9GnNeiOnvoWdJx1R0miHa2mIDwA+wtH0UO2Ho9O8NUHE+mbt
	peEbJqJApHYLLMpkRiC3zVyIyxLjrtFLKKPIND2HgzZ/+uchUKPK6l81bEmHGuwHNhXGq0GJ4Pj
	CbbkTfWA4XFv2qtSCzKe+iDjslw0ew402RIdtXgb3vTuBNWLq+kJztk4oNeIBNE5nHpYNFot1tJ
	tSc1k8jiu/igB/mBPB/t/axE54nV9gBbWxyMQJJgNIA=
X-Google-Smtp-Source: AGHT+IEyK2wwSaiULcKcma8O5dNetn8dtgfJEaPlQ1eAUWHokQvcwvaPZcWg/zzgCe+dFmH8iEHNiw==
X-Received: by 2002:a17:902:c951:b0:215:773a:c168 with SMTP id d9443c01a7336-219d965c5ecmr31236205ad.1.1734576086178;
        Wed, 18 Dec 2024 18:41:26 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde50sm2255995ad.154.2024.12.18.18.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 18:41:25 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org,
	dan.carpenter@linaro.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v3] net: stmmac: restructure the error path of stmmac_probe_config_dt()
Date: Thu, 19 Dec 2024 11:41:19 +0900
Message-Id: <20241219024119.2017012-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of stmmac_probe_config_dt() does not release the
OF node reference obtained by of_parse_phandle() in some error paths.
The problem is that some error paths call stmmac_remove_config_dt() to
clean up but others use and unwind ladder.  These two types of error
handling have not kept in sync and have been a recurring source of bugs.
Re-write the error handling in stmmac_probe_config_dt() to use an unwind
ladder. Consequently, stmmac_remove_config_dt() is not needed anymore,
thus remove it.

This bug was found by an experimental verification tool that I am
developing.

Fixes: 4838a5405028 ("net: stmmac: Fix wrapper drivers not detecting PHY")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v3:
- Switch to the unwind ladder and remove stmmac_remove_config_dt().
- Merge the patches into one.

Changes in v2:
- Call of_node_put() instead of stmmac_remove_config_dt() when
  stmmac_mdio_setup() fails.
- Split the patch into two.
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 43 ++++++++-----------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3ac32444e492..dc9884130b91 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -405,22 +405,6 @@ static int stmmac_of_get_mac_mode(struct device_node *np)
 	return -ENODEV;
 }
 
-/**
- * stmmac_remove_config_dt - undo the effects of stmmac_probe_config_dt()
- * @pdev: platform_device structure
- * @plat: driver data platform structure
- *
- * Release resources claimed by stmmac_probe_config_dt().
- */
-static void stmmac_remove_config_dt(struct platform_device *pdev,
-				    struct plat_stmmacenet_data *plat)
-{
-	clk_disable_unprepare(plat->stmmac_clk);
-	clk_disable_unprepare(plat->pclk);
-	of_node_put(plat->phy_node);
-	of_node_put(plat->mdio_node);
-}
-
 /**
  * stmmac_probe_config_dt - parse device-tree driver parameters
  * @pdev: platform_device structure
@@ -490,8 +474,10 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
 
 	rc = stmmac_mdio_setup(plat, np, &pdev->dev);
-	if (rc)
-		return ERR_PTR(rc);
+	if (rc) {
+		ret = ERR_PTR(rc);
+		goto error_put_phy;
+	}
 
 	of_property_read_u32(np, "tx-fifo-depth", &plat->tx_fifo_size);
 
@@ -581,8 +567,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
 			       GFP_KERNEL);
 	if (!dma_cfg) {
-		stmmac_remove_config_dt(pdev, plat);
-		return ERR_PTR(-ENOMEM);
+		ret = ERR_PTR(-ENOMEM);
+		goto error_put_mdio;
 	}
 	plat->dma_cfg = dma_cfg;
 
@@ -610,8 +596,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 
 	rc = stmmac_mtl_setup(pdev, plat);
 	if (rc) {
-		stmmac_remove_config_dt(pdev, plat);
-		return ERR_PTR(rc);
+		ret = ERR_PTR(rc);
+		goto error_put_mdio;
 	}
 
 	/* clock setup */
@@ -663,6 +649,10 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	clk_disable_unprepare(plat->pclk);
 error_pclk_get:
 	clk_disable_unprepare(plat->stmmac_clk);
+error_put_mdio:
+	of_node_put(plat->mdio_node);
+error_put_phy:
+	of_node_put(plat->phy_node);
 
 	return ret;
 }
@@ -671,16 +661,17 @@ static void devm_stmmac_remove_config_dt(void *data)
 {
 	struct plat_stmmacenet_data *plat = data;
 
-	/* Platform data argument is unused */
-	stmmac_remove_config_dt(NULL, plat);
+	clk_disable_unprepare(plat->stmmac_clk);
+	clk_disable_unprepare(plat->pclk);
+	of_node_put(plat->mdio_node);
+	of_node_put(plat->phy_node);
 }
 
 /**
  * devm_stmmac_probe_config_dt
  * @pdev: platform_device structure
  * @mac: MAC address to use
- * Description: Devres variant of stmmac_probe_config_dt(). Does not require
- * the user to call stmmac_remove_config_dt() at driver detach.
+ * Description: Devres variant of stmmac_probe_config_dt().
  */
 struct plat_stmmacenet_data *
 devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
-- 
2.34.1


