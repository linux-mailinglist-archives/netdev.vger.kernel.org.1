Return-Path: <netdev+bounces-130571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 151F698ADB5
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41FF1F23E06
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0100E1A2560;
	Mon, 30 Sep 2024 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5vLZMUC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D531A2541;
	Mon, 30 Sep 2024 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726622; cv=none; b=mdSyP2B85M13+nE3v8VYw3w9hp18HrDH5HMeRtLkMNVNtgSEzmBiiR0Otg8usJ1iNpeGG6lkWvGdq4AB4SnpT0ZT5PQ+GVXT5qB8/fvRHMLH2jcPK9VIqP/xYGHseqg3K8JsMf/NZbf3Rur9AAyYgSjZ6LugZ95B9OuYkrGhHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726622; c=relaxed/simple;
	bh=lhqM/tDLilNDAvkZ6CHklg9+gI1AjLbN06Lfvf4DrMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dTeWEn9ge2YJFRR8uFCi9dP51YYQwsFJAFW4xI2wjix/qIVli+iQoE4YJUQtzMAGqQDoNmH8taph9Qj1g7+Xx7DPo+T/QeF2s/isz6DRy/5Plq/GVYpZ4vfFjuDks9SNAgXXszHXQHdkffmMiPB61jxvAk6EbKbLqFnWKGBeXm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5vLZMUC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so46087025e9.0;
        Mon, 30 Sep 2024 13:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727726619; x=1728331419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWhma+jLayTPmmZHGcFdQytW18t1cDxz6kIrXu2ao2w=;
        b=h5vLZMUC+WmrSOn86mSr74dz42o+tSBxTPswz+9O+XOLFRIRxGoAKdV1lsb4Ss7PBD
         sDhiS1l8U8+1OssknTuFDoGfTKdtA2XJZOhXUvrhvNSYmRhG1TA3+RnzRQUPbvgZ1sfc
         AogVHo0bgRn5MT/SgQCVZ24VIKi7LZmq04BfZJ0LCfon8NFSO2ifK9PWT0Q36nL372bR
         RYV3VvZgrc+3j+YBQikfmq7ujDfpRvUFia1p1jdXOi5grw8Xjou328S7Mj3nDXcQ9Rj1
         +SWmFPgKgyotvVQ2284/h+Vz8Tj0/QcKUHYG4nkntQeeZGMoM5NlQ8leJrkE/CAESlBy
         a9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726619; x=1728331419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWhma+jLayTPmmZHGcFdQytW18t1cDxz6kIrXu2ao2w=;
        b=WBHzpRx09FvTpKam3vRzd5THb7pL2OeyCksiLdc/SN4u9QLjp0IlbUu5y0EQocLXsv
         v4P7BIM/Q6HvMr+EaAjXG938GG5o4qTVxnM0TU9K1oSSPfX5d8WaWcIOanYOUDfdvRq5
         EPyaHlKNqfyVOgqzfnTFVN0ygoO275Wz2Fme7aIff2hX/EDFlfYLsI6DGg+46N+EwxRp
         ciTz7tEgGpXVR5srglVI6CJYhX2vRCcz+zkoQ9m8diK3h6lY3waJ0SmcrjmxOGp2Ex1c
         Y88fUoLBRd9xK4JPqrcBbEKatW7ctTBhBXbUybiNOJxftCZowe+a5yjILZWo+FDyfO0+
         YeVg==
X-Forwarded-Encrypted: i=1; AJvYcCWEbTo4EAqXmtsnZc+fKzs+7CNJjzRVevKfi52qJ+XYX/SmaQW7k1VPRr6vukW8KQkKuWX9cxaxjY6jgws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2e38DxUB27e/a4Gm1pEW4+c71l9/pBmuA9ZLCt2NWT9KMx52B
	T/dub5E1ALg5NSj3Jg1ZVB29D3htyYePYyWnbJj2RYF82BRoAruj
X-Google-Smtp-Source: AGHT+IEqUNBMAM3S1zFrByHB/nKIWJkUcqU5zIeZF7O146DmV4ScmkcieTQGp1+z4zKu48Fsgo7Inw==
X-Received: by 2002:a05:600c:45ce:b0:42e:d4a2:ce67 with SMTP id 5b1f17b1804b1-42f5844ab22mr99664855e9.17.1727726619321;
        Mon, 30 Sep 2024 13:03:39 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36760sm162591215e9.30.2024.09.30.13.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:03:37 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 30 Sep 2024 22:03:30 +0200
Subject: [PATCH 2/2] net: hns: switch to scoped
 device_for_each_child_node()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-net-device_for_each_child_node_scoped-v1-2-bbdd7f9fd649@gmail.com>
References: <20240930-net-device_for_each_child_node_scoped-v1-0-bbdd7f9fd649@gmail.com>
In-Reply-To: <20240930-net-device_for_each_child_node_scoped-v1-0-bbdd7f9fd649@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727726610; l=1663;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=lhqM/tDLilNDAvkZ6CHklg9+gI1AjLbN06Lfvf4DrMk=;
 b=XK7yYIBeqRmZgZ24U7zhUudEoYaOhqyYZ/954XABAmgrtJE0aSA9NZu5MXlngRSSOMCalfeXj
 76ua2dduXuNCLezFXqOuqykMLSaJGE1wS5fx3F6Sxj/wGpId1E66ne0
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


