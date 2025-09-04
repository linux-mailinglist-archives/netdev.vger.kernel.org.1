Return-Path: <netdev+bounces-220131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD64AB44890
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E255AA106E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A0D2C21DB;
	Thu,  4 Sep 2025 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns1/vCyR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532842C0323;
	Thu,  4 Sep 2025 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021563; cv=none; b=hHb2fHotA/ATf8QyCKp/qq2bll5xSxqp59Vkic/kNtZwXOwLyiN09BSYjHcp7PGjdwiqr7e4AMhu6yeH/+9//VRj/sAZ4YrqlkAMLN+hwVgoRQaBIiz4E6qiY8G3gOFbXnesTE9edfrjsL9vtFAusaKtXSif8/8Xoi3f3wu5CJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021563; c=relaxed/simple;
	bh=as/j2XHQ4f2rCQN5MlrncBx0n6vH+w6Fk8YLrJUnd3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aO+OGPUn4Ld/SBiBAy4DNDSQHzemyqv9T/VvV98Vl16WEvNmAu6vx/jEL/TtToZDjk1mJYxy0K+RITTs6tRJkmISbEmzAb388etpFEG5ozPTwjVGYwtoDwMcxV0joifu1l4FuxRUwnmmow+uzCc0/qv9IbwGRLTENIfI/+ipjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns1/vCyR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7fe9eea0d21so151957385a.2;
        Thu, 04 Sep 2025 14:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757021561; x=1757626361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfJo2H6ZWSWCMA4g4gE9i482h+GrTxDw4eF5crseCrA=;
        b=ns1/vCyR8ao+uUFBButk+S+2aFDaqGDydPKEKl7ZWh93Zrfl5mqcZWlXDRZgAbbT7F
         F5xyikNUJye+VUh2nEC3ggCMdvqU0UxsK/8mBXiDUZLEvYH/pNI+9fWfKF+Mk8L9mlzu
         f1gGyULSKWCrHpriqfHwSUOb2vmdADZTHic+gLf3iVBDUXdBf5D2mkOGs9HjE2FJUaJI
         ZkKLVfI3zj+DDMggZ7LWRazwbejgUb6myQRYjLkK5Al+I6ZXnZJ6LSD3OUx5yG5W4xif
         EqOstni8rCtpR+kMsWJh8VN1dWPIyM5y0WXM4fVRITm4U+f+WvZx3cmybNtLhr7eBovi
         7Fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021561; x=1757626361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfJo2H6ZWSWCMA4g4gE9i482h+GrTxDw4eF5crseCrA=;
        b=vvXZjcDjlhrFtFhtlznd59dwtqMtvrmbZK6juMuq51vyj40VPGFI08rxl25IKPIPv6
         Fk0qHHcXQGCASVf6TP782+cnoL1tOvCfGtWr6JCVVmgPfUsuearSEY2PNblVxPHJgbJE
         AmzCUmz93x2jYI9y76MEEahqFmPIU19UxI/kmHoOkISEQUSAYmYfh9s1PREbChWQRamK
         WZ42uxNBR5KYmKZxD09H0a321yxvov50RjWwLF6UJsS9NyQ1e39aJ84WUW17Y+HWJIlj
         GJ0+znn6H1hj1fWVQa+vzmlXe3zX1IY8cbifOwnExmalw1Ie2JibLuRAjyEoBQfznW5+
         ig2g==
X-Forwarded-Encrypted: i=1; AJvYcCURi+9XvPz99Nq6wRZ6KIwk8PaMsblm0BCLVuAYiM+YuBBWzM/8cjI7aCMixy3pIXRNEOyvLV7wHsTGQ0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXq5YSJGh83OawG8XJoq7nKH3at0+Mz1QbXapuestrExUkJvN
	nnFtrFke1/iEJNLKX5MXU+jRHbD0E+jLgDY3XDjekWBz2TTBaIwRbLQ+e2gBHQ==
X-Gm-Gg: ASbGncu+aWT74+aw0YE16T69UVWX9hg6p9IJI3czJUarpAqwDb+yE6lropZaPeBqaFz
	NqOsOv5CxJ31D7VYpO5dKQv6zisR2xY4MXdgGdhSKY5h1HAdkRKYXAO+ZhR9Of4MaAf/jDUlJ9a
	fazqRSVsbb67hpMxdxgHgx0dLRqlyBZ2YUNREoLjIMAg/Crgz/U3L8XcRiY0mZ1Yf5XQfCTRfyx
	vwkC17m8JA172pRIQeTWFbkE9DCKWjO798svSdzc5CJDMU7Fu/3o6niMIdMxnQc2V+qT6r5BCJI
	jyGT/ZBYneAw6hY8qxrOQUbC+kj5hqFPp6ilyP6K4nHnkigeIsp5XjYc10Ovt/Vv8SCwuv/Zyyd
	cyqjFXO/Fm0r6b9omwR/QUkQ8nasxQLrIj7fU9yuMo165Mq2zEnTe5oqhVk/LXGI/zEZSXWdVcZ
	y7G6jEaw==
X-Google-Smtp-Source: AGHT+IEMDG3qKM9E64JDbZlvMNFIAoPif+QvGsq7rKH5NWkVKB/zLRQl4pUo2HCjzrKSkjRpxVTcMg==
X-Received: by 2002:a05:620a:a915:b0:800:e553:ba99 with SMTP id af79cd13be357-800e553c367mr2008621085a.11.1757021560966;
        Thu, 04 Sep 2025 14:32:40 -0700 (PDT)
Received: from archlinux ([2601:644:8200:acc7::9ec])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f635cbesm35473501cf.5.2025.09.04.14.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:32:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next 1/2] net: thunder_bgx: check for MAC probe defer
Date: Thu,  4 Sep 2025 14:32:27 -0700
Message-ID: <20250904213228.8866-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904213228.8866-1-rosenp@gmail.com>
References: <20250904213228.8866-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_mac_address supports NVMEM, which can load after the driver.
Check for it and defer in such a case.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 9efb60842ad1..a68dccb7c2da 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1471,6 +1471,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 	struct fwnode_handle *fwn;
 	struct device_node *node = NULL;
 	u8 lmac = 0;
+	int err;
 
 	device_for_each_child_node(&bgx->pdev->dev, fwn) {
 		struct phy_device *pd;
@@ -1483,7 +1484,9 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		if (!node)
 			break;
 
-		of_get_mac_address(node, bgx->lmac[lmac].mac);
+		err = of_get_mac_address(node, bgx->lmac[lmac].mac);
+		if (err == -EPROBE_DEFER)
+			goto defer;
 
 		SET_NETDEV_DEV(bgx->lmac[lmac].netdev, &bgx->pdev->dev);
 		bgx->lmac[lmac].lmacid = lmac;
-- 
2.51.0


