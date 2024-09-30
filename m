Return-Path: <netdev+bounces-130615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB4698AE8F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C831F23EC0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107FD1A2632;
	Mon, 30 Sep 2024 20:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa7ljYPA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341B1A0BF2;
	Mon, 30 Sep 2024 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728722; cv=none; b=Yu9DGwwPBVtH0dMbpk/ZzoZSpT3wO139ciSIE034M7emdghb7CalOIobVoQhIk5KZypjL4zGmiMdkwupqXC5f3L1kGdhTuvOiGmQ16NYzyramqQ0iLbcD67Y9knU9UdvVk1w85Oks9rAJl6yHxvpbNuJLU3NR/qpkQxmGOCBK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728722; c=relaxed/simple;
	bh=lhqM/tDLilNDAvkZ6CHklg9+gI1AjLbN06Lfvf4DrMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K/vH/MhFgp6dKU7MecpybsID6k8AZmIjbWMd6/MI2RozMSh2/VW/Xr8l9zLGYzsUlXwTT3xTx5d2Sh2ktc8NdjuKISWdhBPl1H3qrJRBajULfyY6Rfw00u+QtAFx6RrOUBKMFFI22yq6Xc4NsxLpAl0bXGS7GLsYEFoRi62jyuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa7ljYPA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c876ed9c93so4765417a12.2;
        Mon, 30 Sep 2024 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727728719; x=1728333519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWhma+jLayTPmmZHGcFdQytW18t1cDxz6kIrXu2ao2w=;
        b=Oa7ljYPAYnVRPPsrv1ynkiL5onfm//PmUiK4v4zYlzfqev1HIE/ZmdeH+5BgDF6GzN
         rJGwlVWp+ZxLTPNGDeAUprEhvA6ij2bcroojXzWaIRCZ+7AtySNG47Kf7Qr4v3K3n93H
         bzBFi839uu3xQHU27/LgOudr7ResrlB8J7pjFNbYFqpZRrEMCJ/+OkbzgzORX/L93czk
         aP/vXQ6ZCVG7nOyFSrv8LmIuWnG8aA9UeiauRoGNCFI8PMne10ZKQOE0yaQXCc2zYked
         6E+R2B4nxbvIcpJyUqLl1nMYLLQj4hyCKjmsqmwpYfFRGli/nFfuRhwFrokaKBoFjkye
         j7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728719; x=1728333519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWhma+jLayTPmmZHGcFdQytW18t1cDxz6kIrXu2ao2w=;
        b=L4Ptmcn9b2DMge5EwxttyRe3uk2DAHY7CHp0RnCyZ+tkegT5vh7ChYWsdWBY3/oRkM
         NVR/cBn0ItITVcHteTyZ/Cw4WGwCpp8yN86Vm8r+oBhkjnhcrYsACCFyMvRKiT221hLP
         SCyoTjN2OzRS4h/YwzKkuW4LPP+fx/3E9+7tf0umFEaMOZf91o9IZfXUYMEdF5xgkGVL
         Wn9T4i46Q78mpLigM/ytM7obtX7XbvVblU2QyfNbtjenMSty72D4s3c40H7R+JT3Jjdq
         Px+AGkSLbWApMWT03iLHQomn6SdJQVWwDnriCwmlLFRFBa867Cy6qn7irk5fh19etG1K
         0qCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAsNF86h/5dxQQLTriTJCdjVzxpfM3f+ufpsGcGrkoiVwvTYHYaGKj9HtUB+we57nr3FmCLIAD3ukOEVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXG2H/q/ZAv/Wsm4HueUZbzFZEdZ/sTAknQUTJNXYtUskbZcfG
	zGCRZlNmXcGlLE464Bugf2SvepNeiFp4uItU2BFgQdA/GCtk7iv0
X-Google-Smtp-Source: AGHT+IGop0m+RggjK1JOxzT4f9vzcCe1sZPUOGuzSl8pHEqUbxt0f22lqUcYx5bB2PiZqnyPr+ueFw==
X-Received: by 2002:a17:907:3eaa:b0:a8a:9054:8391 with SMTP id a640c23a62f3a-a93c48f8884mr1414236466b.5.1727728718475;
        Mon, 30 Sep 2024 13:38:38 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c7184sm581377566b.83.2024.09.30.13.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:38:38 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 30 Sep 2024 22:38:26 +0200
Subject: [PATCH net-next v2 2/2] net: hns: hisilicon: hns_dsaf_mac: switch
 to scoped device_for_each_child_node()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-net-device_for_each_child_node_scoped-v2-2-35f09333c1d7@gmail.com>
References: <20240930-net-device_for_each_child_node_scoped-v2-0-35f09333c1d7@gmail.com>
In-Reply-To: <20240930-net-device_for_each_child_node_scoped-v2-0-35f09333c1d7@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727728713; l=1663;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=lhqM/tDLilNDAvkZ6CHklg9+gI1AjLbN06Lfvf4DrMk=;
 b=daRt46UBO70zpJYenBxG6RCxSAqWcHCbVboNXmKJYvZn2ABhVBQriAltnyDCgldASb7Oq0Z+Z
 JJYhnxX2SUQBCQv+/HkxvkIv4W5lCgRRuXhtkXT4mhq/hiuf6KCXWrg
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use device_for_each_child_node_scoped() to simplify the code by removing
the need for explicit calls to fwnode_handle_put() in every error path.
This approach also accounts for any error path that could be added.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 58baac7103b3..5fa9b2eeb929 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -1090,28 +1090,24 @@ int hns_mac_init(struct dsaf_device *dsaf_dev)
 	u32 port_id;
 	int max_port_num = hns_mac_get_max_port_num(dsaf_dev);
 	struct hns_mac_cb *mac_cb;
-	struct fwnode_handle *child;
 
-	device_for_each_child_node(dsaf_dev->dev, child) {
+	device_for_each_child_node_scoped(dsaf_dev->dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &port_id);
 		if (ret) {
-			fwnode_handle_put(child);
 			dev_err(dsaf_dev->dev,
 				"get reg fail, ret=%d!\n", ret);
 			return ret;
 		}
 		if (port_id >= max_port_num) {
-			fwnode_handle_put(child);
 			dev_err(dsaf_dev->dev,
 				"reg(%u) out of range!\n", port_id);
 			return -EINVAL;
 		}
 		mac_cb = devm_kzalloc(dsaf_dev->dev, sizeof(*mac_cb),
 				      GFP_KERNEL);
-		if (!mac_cb) {
-			fwnode_handle_put(child);
+		if (!mac_cb)
 			return -ENOMEM;
-		}
+
 		mac_cb->fw_port = child;
 		mac_cb->mac_id = (u8)port_id;
 		dsaf_dev->mac_cb[port_id] = mac_cb;

-- 
2.43.0


