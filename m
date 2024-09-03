Return-Path: <netdev+bounces-124698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A6C96A79D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A527F1C23D30
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AF31D5CCA;
	Tue,  3 Sep 2024 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3B7Cexf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55AF1D7E2B;
	Tue,  3 Sep 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392598; cv=none; b=r8Ih+1j0mhGWMU4EYGflvFHD9qTXx0NDqT5CJfDTao2u26t0w5Unx378wfTfOQPPOazwGfopZndsk6NCVlHnsvdj9Fdd0eQz6B9HQWEh9Wdl8pYLGQIGfKzikuUgiHe1f+jhM/+sNploKr1zp9OoaY6DA02esxIgotJ6EETzIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392598; c=relaxed/simple;
	bh=aZNu7iiv/TYq0BlMH229d2ccbsF2mWev0TPm5aNKaTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYaWDo5WqxypiKxD2NV7gsf+YU/oL+R9CImc2PVAKVXeUt8WU55CZo+qTDO/Ssvt5Cb2+GGDjDbQ2I+meMsvmGfw1q48GIEWlO2UGKsxrOLlki2keJjh6gBbFUHs2Nnd1nhm+/HgtU78RObR0msqwIFR4smfgGNkdp66oBq60c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3B7Cexf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20551eeba95so23133785ad.2;
        Tue, 03 Sep 2024 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725392596; x=1725997396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltddfl1/seB86FuPt28B0OUAnAVJMcJpdwKzmOTOXTQ=;
        b=A3B7Cexfrez0CwVe83viCgaWxN7QeUTGg6jSLdyjYFjPuzWMh47m2ooXF4OGNzbdM8
         lGVubgwDhTlknU3KtkCDUpubrQYt1By3d1ZDcSA4YZmcrbzcMSdubvHAQOgv/wZipCtm
         ptZGiunhAjcniDZ7XTwpEAllOtMStF1XPEfoTo9JoDjWhR4SkIhxrhm0jQ5wXrNdHRHE
         WyzNh64Chk5AISKhLOj1NdlryOwfmhpLXanxPuFq8PXyXofyfc2iqpno4x+m9fzcl0IA
         hp57dIneGnN8zyLMdXfngjmY5YVwwa2NOdBSgNh+XxYFZ835sffXbK+ICd6tTEeclabh
         pHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392596; x=1725997396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltddfl1/seB86FuPt28B0OUAnAVJMcJpdwKzmOTOXTQ=;
        b=n4eCjMdk2pRqvi26VBMg5dsjxERLfaJRDcM6uACtW3jG/vDDmTGiXjcj0Ak/uHHKhm
         tueG7ywZYBDGF6THVptTCy4hxFBiPIL7ahtkhe9q0b+bf+u4A1Sk/1belCW9n8BBSIfm
         Rdp1xizIk9n2KJTjtTeCiRMYIbaNGOaxoKdQSQf2ARcV/yzWxuTvGCBAU/UrYb2vFPI4
         Bj3xAll2k0WGZb83B8IZ0ec47sthMVSccRcC20woq3GTwXqDuiI8mrPvgbnWOoKCXbtx
         ksvV4dKR+8I2dpMTiszpeSWV4UcV/sRYS+NBFzTCOVmZ2zy1v6UbwjQ06G3TUL/AmNVE
         WfYw==
X-Forwarded-Encrypted: i=1; AJvYcCVrY7E+dhQgVsEY/x34XCZSdGCGZEHjM58MzG3EIbgmlJvUyIt56zOhJq1juGOaTEfiYm4IE5RmP84UUxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQHCtu9iDrs5t9WoPAU7QZAmZaM7ijt1wLXDWp0pOAAIcx/6Gu
	KePdYpOwX8+48WPumCrE874/qxVDaqr61/CvAsFvXZSG/U0O2um3hUaHSbd/
X-Google-Smtp-Source: AGHT+IHp86QFiMJKp6BMRbcXJOAvjw+IVpWWxd1HmQ0ZMRL7Nb4gdLwROUNn6cYHJ1sGHYEblzPmQA==
X-Received: by 2002:a17:902:e550:b0:202:311c:1a59 with SMTP id d9443c01a7336-2054bcf1e9amr82892235ad.27.1725392595852;
        Tue, 03 Sep 2024 12:43:15 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea52a8asm1979505ad.182.2024.09.03.12.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:43:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv2 net-next 1/8] net: ibm: emac: use devm for alloc_etherdev
Date: Tue,  3 Sep 2024 12:42:37 -0700
Message-ID: <20240903194312.12718-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903194312.12718-1-rosenp@gmail.com>
References: <20240903194312.12718-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows to simplify the code slightly. This is safe to do as free_netdev
gets called last.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index a19d098f2e2b..348702f462bd 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3053,7 +3053,7 @@ static int emac_probe(struct platform_device *ofdev)
 
 	/* Allocate our net_device structure */
 	err = -ENOMEM;
-	ndev = alloc_etherdev(sizeof(struct emac_instance));
+	ndev = devm_alloc_etherdev(&ofdev->dev, sizeof(struct emac_instance));
 	if (!ndev)
 		goto err_gone;
 
@@ -3072,7 +3072,7 @@ static int emac_probe(struct platform_device *ofdev)
 	/* Init various config data based on device-tree */
 	err = emac_init_config(dev);
 	if (err)
-		goto err_free;
+		goto err_gone;
 
 	/* Get interrupts. EMAC irq is mandatory, WOL irq is optional */
 	dev->emac_irq = irq_of_parse_and_map(np, 0);
@@ -3080,7 +3080,7 @@ static int emac_probe(struct platform_device *ofdev)
 	if (!dev->emac_irq) {
 		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
 		err = -ENODEV;
-		goto err_free;
+		goto err_gone;
 	}
 	ndev->irq = dev->emac_irq;
 
@@ -3239,8 +3239,6 @@ static int emac_probe(struct platform_device *ofdev)
 		irq_dispose_mapping(dev->wol_irq);
 	if (dev->emac_irq)
 		irq_dispose_mapping(dev->emac_irq);
- err_free:
-	free_netdev(ndev);
  err_gone:
 	/* if we were on the bootlist, remove us as we won't show up and
 	 * wake up all waiters to notify them in case they were waiting
@@ -3289,7 +3287,6 @@ static void emac_remove(struct platform_device *ofdev)
 	if (dev->emac_irq)
 		irq_dispose_mapping(dev->emac_irq);
 
-	free_netdev(dev->ndev);
 }
 
 /* XXX Features in here should be replaced by properties... */
-- 
2.46.0


