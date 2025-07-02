Return-Path: <netdev+bounces-203249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB889AF0FE1
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15B2481C45
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE9A246BD2;
	Wed,  2 Jul 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOpdSGgE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E7B242D6A;
	Wed,  2 Jul 2025 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448281; cv=none; b=oHm0IiSik6bzBzac6P8ZAVzaSqOGgwC843/AIhBAVOLGesZRw+A7a+xliSHxySlGBxOlixH0a2nRgd9lRNGbRCEiLaHbiAUtmRZEctulg/O8zy1ONx59Iw9SMpv8eBFotVrH2tlU1l6Ev/jZvW9KHDxA/Geeg51foqXxiMZp5iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448281; c=relaxed/simple;
	bh=uozv7cNUaahlahiBDNW7AVlln5pZNYvHzH6rHGccePU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=exe+0KGeZpkitK3p/F92et+sWcfbVMSAP4UQYoLpp4tnBy3K8Il1Wx3Y54SObbSJfdXTYlU8TKuSpBjQ7EFEm8HO/wfb4ghWW7euykFyGH0/BOEruRwXk/qHto0kcTHHbsdrk+8Dt8VGVOD90/9cAkT9bG/L1m6ZapgNWJ8PQto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOpdSGgE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73972a54919so4042934b3a.3;
        Wed, 02 Jul 2025 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751448279; x=1752053079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZE6N4nGmdiPtxY4XuyNyLw3/3gBYqPRvNDO2zBmApA=;
        b=hOpdSGgETya6jP5+IKFxM/MA1FvpAx56snokjHT6szJqM7MKK8mtCLlG3IgirtRc2w
         8VUPZSIzuhsSsZkDFV9pkFVf8asX/VdPNEC6QQNyWbVCtCAroRoNw0a/JxFYkBg7mO3h
         q/MZQ82xHBPgt1AgKNRAo/tsl7ONOI8XCt+bVzYgLKZy6RhmaaYonVW0hK4VuRrVxgnl
         BanFF4TiN+dZxBiTDpCty9UD7p/HiRXZZsU0FUS6MmWF2MJd0ZaN3o87yQK4RycWrVIq
         SsU0EgHjIj4DXlsRzCwGchffqHlLgeem8dCNnGwIMpoo1tzuAiIWFDqDWXU5Qpa22EPi
         lZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751448279; x=1752053079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZE6N4nGmdiPtxY4XuyNyLw3/3gBYqPRvNDO2zBmApA=;
        b=qDsnyca1zprFfWVz+a+nkubgPzQutt9O7mXBXJks3bvd+EJqi1RTprD0FwBmFJbr3J
         4F2RkRu7/pjeertSZoqYsRnx3OqVlBLrmc7gYvQEZ+rqrVZsAE/fUC6bzCBrVxKz1MJI
         9EBsEh7dal8xPf5Doz8W3bPzJBicRCkGSlz/EJnsqWrZr8y591mj2eLFQKB7kelz2Jhn
         AdrN9tCPcdz57qeTvrB75NMfjk03uvpVAcW2I0TE7J+vjQN7SPqBJQ2++ZLwrtQfHA+v
         d6rIfZO/2Yk8PyVRwXpPxEuVL/4fyIQuyzJFnk1f4mYj+n65rfATM8JBvzPND64JL4dt
         OsDw==
X-Forwarded-Encrypted: i=1; AJvYcCV/oGZtoaJ9Vshv30jO16gD2aZDZuwqVu6IR1X9YwxmJp7vG7lz2QcQqDOEBMx3kw/o/7BuYuPP@vger.kernel.org, AJvYcCVsb5220Sz/paxcJblLaXbP8fEzH/Tpox5DIlsiB+Lp+C4brCvKFw860SN5vVyKQ4h1vh3WVZVr2/HbmyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzPqgsC0DM659QK9ARodpUaEzUZMMfi4pSth8kOqxKsPHlvBV
	XkmLd5hkCXhFvfZu0FvuZ7xGr3Em4YumvaGcOZH9bnTymNDoLLU9pZ+J
X-Gm-Gg: ASbGnctCWazUiha6YCyi9/ye3TaNw5ay57tr3yOChr+lAF4a/cCXRrz5bGyPAbWN0Pk
	A6cXMjHccXnRCH1rqAz4OF9hE/Nj5UIHipMEtlewz7X2M16KCcnFkAw5zTJry2+3DTDIm/55/Ei
	5chnrQW862g4jUtmtN4BO58nztlhsHaZwRgjnpsizkiaJz/1uy3z1SUXEQJz65Y1b2H1djCI0GU
	rzfLfwGfEkbHK5hIwJ5wXUK4WN9D1tVF7t1y2OrWglouFHhQlrZqhNhbs7oMDsImHMCZ/joJp5h
	2c7ixpazAzfdQVz63hNcl3EZylzZ4ilEugAg6jZgY5g1kqmvvfWX+Ncm5FYmbSdG166Yfl3liML
	Go9IKqhMMP8LVH23i/kWmQsiF+/DaCTfN
X-Google-Smtp-Source: AGHT+IGOtg1lP0lTwk2tR464ubbW1oOPSOtDHggyRTkzkjzQQWzhD7RngmDcTAvFTLFO+wnBujfBSQ==
X-Received: by 2002:a05:6a21:62c1:b0:216:6108:788f with SMTP id adf61e73a8af0-222d7f146f4mr4599239637.35.1751448278792;
        Wed, 02 Jul 2025 02:24:38 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5409d62sm13176949b3a.27.2025.07.02.02.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:24:38 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: horms@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	florian.fainelli@broadcom.com,
	kuba@kernel.org,
	opendmb@gmail.com,
	pabeni@redhat.com,
	zakkemble@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH net v2] net: bcmgenet: Initialize u64 stats seq counter
Date: Wed,  2 Jul 2025 18:24:17 +0900
Message-Id: <20250702092417.46486-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize u64 stats as it uses seq counter on 32bit machines
as suggested by lockdep below.

[    1.830953][    T1] INFO: trying to register non-static key.
[    1.830993][    T1] The code is fine but needs lockdep annotation, or maybe
[    1.831027][    T1] you didn't initialize this object before use?
[    1.831057][    T1] turning off the locking correctness validator.
[    1.831090][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.16.0-rc2-v7l+ #1 PREEMPT
[    1.831097][    T1] Tainted: [W]=WARN
[    1.831099][    T1] Hardware name: BCM2711
[    1.831101][    T1] Call trace:
[    1.831104][    T1]  unwind_backtrace from show_stack+0x18/0x1c
[    1.831120][    T1]  show_stack from dump_stack_lvl+0x8c/0xcc
[    1.831129][    T1]  dump_stack_lvl from register_lock_class+0x9e8/0x9fc
[    1.831141][    T1]  register_lock_class from __lock_acquire+0x420/0x22c0
[    1.831154][    T1]  __lock_acquire from lock_acquire+0x130/0x3f8
[    1.831166][    T1]  lock_acquire from bcmgenet_get_stats64+0x4a4/0x4c8
[    1.831176][    T1]  bcmgenet_get_stats64 from dev_get_stats+0x4c/0x408
[    1.831184][    T1]  dev_get_stats from rtnl_fill_stats+0x38/0x120
[    1.831193][    T1]  rtnl_fill_stats from rtnl_fill_ifinfo+0x7f8/0x1890
[    1.831203][    T1]  rtnl_fill_ifinfo from rtmsg_ifinfo_build_skb+0xd0/0x138
[    1.831214][    T1]  rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x48/0x8c
[    1.831225][    T1]  rtmsg_ifinfo from register_netdevice+0x8c0/0x95c
[    1.831237][    T1]  register_netdevice from register_netdev+0x28/0x40
[    1.831247][    T1]  register_netdev from bcmgenet_probe+0x690/0x6bc
[    1.831255][    T1]  bcmgenet_probe from platform_probe+0x64/0xbc
[    1.831263][    T1]  platform_probe from really_probe+0xd0/0x2d4
[    1.831269][    T1]  really_probe from __driver_probe_device+0x90/0x1a4
[    1.831273][    T1]  __driver_probe_device from driver_probe_device+0x38/0x11c
[    1.831278][    T1]  driver_probe_device from __driver_attach+0x9c/0x18c
[    1.831282][    T1]  __driver_attach from bus_for_each_dev+0x84/0xd4
[    1.831291][    T1]  bus_for_each_dev from bus_add_driver+0xd4/0x1f4
[    1.831303][    T1]  bus_add_driver from driver_register+0x88/0x120
[    1.831312][    T1]  driver_register from do_one_initcall+0x78/0x360
[    1.831320][    T1]  do_one_initcall from kernel_init_freeable+0x2bc/0x314
[    1.831331][    T1]  kernel_init_freeable from kernel_init+0x1c/0x144
[    1.831339][    T1]  kernel_init from ret_from_fork+0x14/0x20
[    1.831344][    T1] Exception stack(0xf082dfb0 to 0xf082dff8)
[    1.831349][    T1] dfa0:                                     00000000 00000000 00000000 00000000
[    1.831353][    T1] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.831356][    T1] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000

Fixes: 59aa6e3072aa ("net: bcmgenet: switch to use 64bit statistics")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
---

Changes since v1:
[0] https://lore.kernel.org/netdev/20250629114109.214057-1-ryotkkr98@gmail.com/

- Rebased on the net tree.
- Add <Reviewed-by> by Florian. Thank you Florian!

---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index fa0077bc67b7..97585c160de3 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -4092,6 +4092,12 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	for (i = 0; i <= priv->hw_params->rx_queues; i++)
 		priv->rx_rings[i].rx_max_coalesced_frames = 1;
 
+	/* Initialize u64 stats seq counter for 32bit machines */
+	for (i = 0; i <= priv->hw_params->rx_queues; i++)
+		u64_stats_init(&priv->rx_rings[i].stats64.syncp);
+	for (i = 0; i <= priv->hw_params->tx_queues; i++)
+		u64_stats_init(&priv->tx_rings[i].stats64.syncp);
+
 	/* libphy will determine the link state */
 	netif_carrier_off(dev);
 
-- 
2.34.1


