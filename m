Return-Path: <netdev+bounces-131451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510F598E853
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEC12880DB
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8AB199B9;
	Thu,  3 Oct 2024 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em+JAY4b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C220E13A24A;
	Thu,  3 Oct 2024 02:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921517; cv=none; b=mRqouVnSlpY+oFZ1rTf0FloihishUjZ8hkhEQZgGNSHwYze46CtL2QOR52YvYdOtGJ2cRhiFSCTIcaoQXnJFOiy8XseHHwq6Wgni+KUCbRP9JkrbWATw8ol9Sctzpc7tKIr9AvJ27e13q6xzB15CkD+IN+CEMJ4FXkYutkRoOK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921517; c=relaxed/simple;
	bh=/JFQ1f+yHsjb5Zt6+gt8OydljzAA9ds8/yUsrr7/NQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qygNkwvaZremgK/pb+es5ydafCumxAFkLxbXyFzXF+/yHv9+hqYIeCxAhtrsLyqTATCHBW86QsMoXPaNc4iM7jWoWLJ8qDZ/2zB62Un/rE76A1MVdxyjnIDQRcvdadlzr7QB5KA64PSyEbhPwfgyLfqqWRLZ0COrcWnbQ+He8Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em+JAY4b; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718d6ad6050so458141b3a.0;
        Wed, 02 Oct 2024 19:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921515; x=1728526315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLSo4Y+RlvJE8rHN+xUYDaCM/v2W+3AtNr9b9F2/l8E=;
        b=em+JAY4b8HYPK2PHujkPJrIdG5whHjjtkx9+nCZcON5F3Yi8d0+jMytQx59WL4B4hL
         By+b8OuFvGixz4Kt2D22E9aT9nbnJdqASJC0qaT5kM7Jen5mgTSRPkrnMvJEr1wSAJGU
         VxMpwlYhx7+RTdbIiB3GAGSsz7zq/+9k9myHB4AybkzphCTTebi5T4cVVmGZmaV5xx3E
         x+pNcD4G2+r9uoSCGlqzRkmg+ll6KkvSEjV9obIfgjiRZGmu4Ozt+/OF+JODHHBmeRGT
         7ACHahbZFX4c7MEGcCZE1oDDl9Cx20mBP9B3CReuL/YAeMIjM7///BBqkT78aVFZlWgx
         rtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921515; x=1728526315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLSo4Y+RlvJE8rHN+xUYDaCM/v2W+3AtNr9b9F2/l8E=;
        b=OmOfRAyS/+CgTVD5R4crgIYGENrib0EQlX090Fboz3WFYTG4Pj5N5bWFcLX38nqxAI
         zpXKTEClJfIoIzaQwKpEP8WKyzqRH/hLZnnOw1KziLbT+SEJyvJoaTQDk1hII36/N4KQ
         O7oZ6o1xL/grOl9zNGGrRstiKdsIV4eLlg/B1rtWVMd/wJMpNa7GGT1nRZMEZVy2/RDK
         C9CH7SYy6C9gwIbq9FtI/xzfC7W8KIhgYxmMkIkjyYDUotNlXEjZrpsGW9/hCLvjGhNO
         zDkvs7Z+wpi1RGeT/HHgqRslv1i/EADvRMUyf35ks1cCmp8iFCcIti13kOjCsSCZ7X1a
         aJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/Soev4dhWWQCfCVa4lzjipFAezp4c2Bys8ngbGcHsInKlibFLlhO+Thn+xnhOxuVB/4FImU3gng+nbU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/TKvDWkJgar89SRRCAjkd8E4/abOFOVfvx09S6g4Mn6e7EZV
	rz7+HtjEcg0yjRyKfOI9NIgcJENTpL5OVgPg+ME7Iy6+KlI8RFYcAPRfjQI8
X-Google-Smtp-Source: AGHT+IEB434KDWI/81wHGhJ4XAzv4k2sXRaQ7ctNzjo5e/1oo8U66w4sDbNvm4jOl3o6b1EC6x+Pzw==
X-Received: by 2002:a05:6a21:3116:b0:1d3:eb6:c79b with SMTP id adf61e73a8af0-1d5db104fd1mr8355968637.9.1727921515003;
        Wed, 02 Oct 2024 19:11:55 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next v3 12/17] net: ibm: emac: zmii: devm_platform_get_resource
Date: Wed,  2 Oct 2024 19:11:30 -0700
Message-ID: <20241003021135.1952928-13-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the probe function by a bit and allows removing the _remove
function such that devm now handles all cleanup.

printk gets converted to dev_err as np is now gone.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/zmii.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index c38eb6b3173e..abe14f4a8ea6 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -232,9 +232,7 @@ void *zmii_dump_regs(struct platform_device *ofdev, void *buf)
 
 static int zmii_probe(struct platform_device *ofdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
 	struct zmii_instance *dev;
-	struct resource regs;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct zmii_instance),
 			   GFP_KERNEL);
@@ -245,16 +243,10 @@ static int zmii_probe(struct platform_device *ofdev)
 	dev->ofdev = ofdev;
 	dev->mode = PHY_INTERFACE_MODE_NA;
 
-	if (of_address_to_resource(np, 0, &regs)) {
-		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		return -ENXIO;
-	}
-
-	dev->base = (struct zmii_regs __iomem *)ioremap(regs.start,
-						sizeof(struct zmii_regs));
-	if (!dev->base) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		return -ENOMEM;
+	dev->base = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->base)) {
+		dev_err(&ofdev->dev, "can't map device registers");
+		return PTR_ERR(dev->base);
 	}
 
 	/* We may need FER value for autodetection later */
@@ -270,15 +262,6 @@ static int zmii_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static void zmii_remove(struct platform_device *ofdev)
-{
-	struct zmii_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-}
-
 static const struct of_device_id zmii_match[] =
 {
 	{
@@ -297,7 +280,6 @@ static struct platform_driver zmii_driver = {
 		.of_match_table = zmii_match,
 	},
 	.probe = zmii_probe,
-	.remove_new = zmii_remove,
 };
 
 module_platform_driver(zmii_driver);
-- 
2.46.2


