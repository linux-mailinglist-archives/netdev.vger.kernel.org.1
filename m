Return-Path: <netdev+bounces-132459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23691991C22
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B72B224CB
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E5717DFFE;
	Sun,  6 Oct 2024 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAEACb6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BECD17C9BA;
	Sun,  6 Oct 2024 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181750; cv=none; b=iE/u4nFW1bqL4eYIgU1tt/WmmpS6ZAAPXzpazg02M4nD3O5FNNK0ruMLMIXyISdrbRtMCD930lmGcwo6MycvOiD8L/VmieszlJSmXK1GY/OxIzs/d4BSXwQFcx7Pwn0lVqFk04vmdSUPo+T5khe2xUHmAGMLM83R1A7PA/MmSno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181750; c=relaxed/simple;
	bh=xkMQUJ+a/seJ+Y5YjIAKxVPqeaNfl7Neu2vo2r4t7VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWu0pZtl2yZb6ePrlndxIeREhFtuljFJIg8/jJmHSvD25eAPmioZyacE9KGtPJfWXzKJ5XpRranJ0caY8NTZtg+sDIoZiSfcmeu2TRMMT0ucgsD7RY9BTOczTHrM3va/A3G9+uu6xnZ49xJPg2p6jUQI0wWPDv21i9+gAoNGiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAEACb6p; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71dea49e808so1536445b3a.1;
        Sat, 05 Oct 2024 19:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181748; x=1728786548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KWs0i5ENfOJtknzBiWTETb7i51VBhlSos8aop6cLiw=;
        b=hAEACb6p3wbx6N9CcunzPDsaM2x5TTzT7hEe4j3IqH++IYZlSPcV6eP+Iq5683/0pJ
         Q7ccZ+heggQru4QAyByOJ0KS6nGCAlOKDC/Tpr9uMsOnPnMlPjgyZslbPT+wMGRrhv2i
         IUIypQhLI5db++Q/odzd6Wp2XuunMYCfvnerBTck79mvsE1gsOLRP/5YetUnaULe3XfV
         gySor7oNKAqZ1FTNNARTIOSRDFk8UmRgs/Q5T7rPSPiR092OYINmWwO4pCJl5j4zQ/Wr
         CPGe+kfcTipccQ/6wcrr0glcPI75EgUf8alGaHQmXdeS0Rh1b9v965OFqImkev8h4D0I
         dOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181748; x=1728786548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KWs0i5ENfOJtknzBiWTETb7i51VBhlSos8aop6cLiw=;
        b=hkBGbGvZeaYcNaCO8qQTNrQpdLMjucYbcxPxh/PLkKgi1ZphimIWcUU1oaMXIVZYbX
         UXLy9yOEJOPoEd1OIYMDiFvJ3X72gylGVpCLIy3mDyd7ZDGfgmifEQGGnw6mN7OKmxVx
         7VQj5ZeSV5BKSkJ1gFk/T5ovqyzjKCaUQgfD1nfjXmXjyMFBg7YlDV6umzvMTFTZ3qjA
         vCNnrbeZIsHkBFFs7MGW17sNS3cUxf8RQ9jfgYyWpFsT91BjF+EA6VmKV0P/HDY65Swr
         7VIWyTCeNs+eS4rktwL6Vw5nz1besWj7h1yusrRcd5mV5KAkfTCT1sKhjDE6SjuXWMYC
         ihMA==
X-Forwarded-Encrypted: i=1; AJvYcCXHNdzsL5v/fO11wBB5n5Kvk1ZnQDPfUYr7pNq5tW/UUqlLIpwN/8yuzQyZpRmGlYR2Y1D2SBpOqmRz084=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnvHOyQn/hnozv4HxS1xudv4O3P1U4QpKRd9bNrsevGumM9PN3
	cPm+OLdgqzEYRcYfzfUeim1bucK+t8ulnAsgK5DHpQY4CjUOCyn6cZDNMw==
X-Google-Smtp-Source: AGHT+IEvmSdDdZF870VA1Mm/Ta9tCFiOKOs1rkOxDioNknv6DcvQtKxwQ+yoE3VfC9AU1hqVk/n3vw==
X-Received: by 2002:a05:6a00:190a:b0:706:74be:686e with SMTP id d2e1a72fcca58-71de2474d77mr12085555b3a.26.1728181747820;
        Sat, 05 Oct 2024 19:29:07 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:29:07 -0700 (PDT)
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
Subject: [PATCH net-next 14/14] net: ibm: emac: mal: move dcr map down
Date: Sat,  5 Oct 2024 19:28:44 -0700
Message-ID: <20241006022844.1041039-15-rosenp@gmail.com>
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

There's actually a bug above where it returns instead of calling goto.
Instead of calling goto, move dcr_map and friends down as they're used
right after the spinlock in mal_reset.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 4f58a38f4b32..e6354843d856 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -553,6 +553,18 @@ static int mal_probe(struct platform_device *ofdev)
 	}
 	mal->num_rx_chans = prop[0];
 
+	if (of_device_is_compatible(ofdev->dev.of_node, "ibm,mcmal-405ez")) {
+#if defined(CONFIG_IBM_EMAC_MAL_CLR_ICINTSTAT) && \
+		defined(CONFIG_IBM_EMAC_MAL_COMMON_ERR)
+		mal->features |= (MAL_FTR_CLEAR_ICINTSTAT |
+				MAL_FTR_COMMON_ERR_INT);
+#else
+		printk(KERN_ERR "%pOF: Support for 405EZ not enabled!\n",
+				ofdev->dev.of_node);
+		return -ENODEV;
+#endif
+	}
+
 	dcr_base = dcr_resource_start(ofdev->dev.of_node, 0);
 	if (dcr_base == 0) {
 		printk(KERN_ERR
@@ -566,18 +578,6 @@ static int mal_probe(struct platform_device *ofdev)
 		return -ENODEV;
 	}
 
-	if (of_device_is_compatible(ofdev->dev.of_node, "ibm,mcmal-405ez")) {
-#if defined(CONFIG_IBM_EMAC_MAL_CLR_ICINTSTAT) && \
-		defined(CONFIG_IBM_EMAC_MAL_COMMON_ERR)
-		mal->features |= (MAL_FTR_CLEAR_ICINTSTAT |
-				MAL_FTR_COMMON_ERR_INT);
-#else
-		printk(KERN_ERR "%pOF: Support for 405EZ not enabled!\n",
-				ofdev->dev.of_node);
-		return -ENODEV;
-#endif
-	}
-
 	INIT_LIST_HEAD(&mal->poll_list);
 	INIT_LIST_HEAD(&mal->list);
 	spin_lock_init(&mal->lock);
-- 
2.46.2


