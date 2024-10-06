Return-Path: <netdev+bounces-132452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EC7991C14
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AA1281FD0
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCE6175D4B;
	Sun,  6 Oct 2024 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWQwdOrP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D3175D2C;
	Sun,  6 Oct 2024 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181738; cv=none; b=SdOMZu5PK+oX6SlCT+F9BP+af69noyqjn5VTc/N0F4vIYEySZ1lU4Txz/L7clGv1CBVfnTvL6Ie2JmsJZirX73jcVXGEPnBe16fCgv3CtvePy0HVf2JGSqvh1gtlZUnZjBXDTskmVRHR/88y4Qfw16RXUXGegAgjeA6W1MzFwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181738; c=relaxed/simple;
	bh=jcEPPiC20NiN9gN9PQRjLJGI4IFmPIwO1pV6PvaDEDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2UvYsL+KSn8HNbKBgoHgPs5l31I3cyAQ6qU0oa+yDioCbmRuHCJO8i2pefYJnaRVWhOoR1t3Wgc/OD0O0PGXpXgXUBRX3CVDcmj0MR8Wf8sCvxbGihnInPcPO2w2E1QfbxaZUj1nX6/HVsBaf8Q3J34hWh3om2JxTytmulbfDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWQwdOrP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71df2b0a2f7so745586b3a.3;
        Sat, 05 Oct 2024 19:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181736; x=1728786536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5PeKEFZjGrSAzWG8C4rr3WYbWfyAh6vUs2OEDpSIRE=;
        b=bWQwdOrPqrWxkv5a5HDBoQsyDe2268+j2W/Es4k46SHMbnL2xxXIrq/AT33kraUynh
         2df4LhXJ5eEqGBhsSpmfGz+RPZL0yLNsvnv8Rnq+MRq/vsfa+G6hYCy/tXRoTMOCmf1U
         vJfN2wpN5Wvkve170HAzSPBfvmCxRdCoM735h9y1fpMHVMLCBIrm+OZHn8nnrAxa0AXX
         mmcC3w80ipKColuSjsS2gnKhY/Q/XnhHHbxFXUTir/cwewx7WVtzogfAIwnkNAnBytd1
         tvCAWmouGU7pBAO8aokvt5vWNS0Hl7Y6f+2/WZXPFuWN9cWuwPfBopwEAnEg3u8VdAKK
         Ov3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181736; x=1728786536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5PeKEFZjGrSAzWG8C4rr3WYbWfyAh6vUs2OEDpSIRE=;
        b=ExPJlM69+rP4t6J7+UJCBech5sFdTkDXFJlx9Nm3mtMdSc9RdKKImfRXugLxHtW12K
         IqQ8oNjKW2IOZzQ7FGIKVsK93koukAYMYRvNdEgIcQJ/PZgCnGCqW5SL8r44lM+unkGE
         iJMgK+y6AxHq+6w9hJQTqYGPBiDTOG9qwPgnZSpgBwQ3g4OJgyAC5nVhyaU3Zom/w91I
         453q3o9LyJAp8Rcis4m6KFfadvT9KyTpRyvgpntxMuMwzzzx+yq0e8Ha1ivGDDhF6Pzg
         Z3Hd7r4RRoOZz21JJjwQUP78omHHPX/uyVZJrawH0D2NqzzC1aRs6kIvV3fZWW9dN09c
         tvsg==
X-Forwarded-Encrypted: i=1; AJvYcCUV0E8YtLy2MtE40W/XrEG75DD6lgnbOSGShdCdrQ8Wpw5c8n0PRpOGILErYsVIqLJ/Q0CMy5iD3m/oIWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybMO/+1k/AdDwSTEW+nb83DsBpsG7gLe3Xo4QW4+8y1SpgGwDs
	XuUwY0FpL4hYVeP4gZjQIfeIwoTevNGQ3qBz2exy/1cE9UGRu1NZJMRSOw==
X-Google-Smtp-Source: AGHT+IHYr7uR7Xq4KpE5L4tixlUeuHwcMNjFvprFNaUiOJxHWcpkvI7z2o4wUGZjPsIvybsJTORI8w==
X-Received: by 2002:a05:6a20:bc8a:b0:1d6:f623:1798 with SMTP id adf61e73a8af0-1d6f62317d7mr1374928637.14.1728181736625;
        Sat, 05 Oct 2024 19:28:56 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:28:56 -0700 (PDT)
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
Subject: [PATCH net-next 07/14] net: ibm: emac: zmii: use devm for kzalloc
Date: Sat,  5 Oct 2024 19:28:37 -0700
Message-ID: <20241006022844.1041039-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006022844.1041039-1-rosenp@gmail.com>
References: <20241006022844.1041039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the probe function by removing gotos.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/zmii.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index 97cea64abe55..c38eb6b3173e 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -235,29 +235,26 @@ static int zmii_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct zmii_instance *dev;
 	struct resource regs;
-	int rc;
 
-	rc = -ENOMEM;
-	dev = kzalloc(sizeof(struct zmii_instance), GFP_KERNEL);
-	if (dev == NULL)
-		goto err_gone;
+	dev = devm_kzalloc(&ofdev->dev, sizeof(struct zmii_instance),
+			   GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 
 	mutex_init(&dev->lock);
 	dev->ofdev = ofdev;
 	dev->mode = PHY_INTERFACE_MODE_NA;
 
-	rc = -ENXIO;
 	if (of_address_to_resource(np, 0, &regs)) {
 		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		goto err_free;
+		return -ENXIO;
 	}
 
-	rc = -ENOMEM;
 	dev->base = (struct zmii_regs __iomem *)ioremap(regs.start,
 						sizeof(struct zmii_regs));
-	if (dev->base == NULL) {
+	if (!dev->base) {
 		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		goto err_free;
+		return -ENOMEM;
 	}
 
 	/* We may need FER value for autodetection later */
@@ -271,11 +268,6 @@ static int zmii_probe(struct platform_device *ofdev)
 	platform_set_drvdata(ofdev, dev);
 
 	return 0;
-
- err_free:
-	kfree(dev);
- err_gone:
-	return rc;
 }
 
 static void zmii_remove(struct platform_device *ofdev)
@@ -285,7 +277,6 @@ static void zmii_remove(struct platform_device *ofdev)
 	WARN_ON(dev->users != 0);
 
 	iounmap(dev->base);
-	kfree(dev);
 }
 
 static const struct of_device_id zmii_match[] =
-- 
2.46.2


