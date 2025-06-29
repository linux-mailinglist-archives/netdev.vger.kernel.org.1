Return-Path: <netdev+bounces-202223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5616BAECC54
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 13:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65FA47A74F8
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 11:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C8B219A7D;
	Sun, 29 Jun 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAQHjXXt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A488D1D5CDE;
	Sun, 29 Jun 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751197300; cv=none; b=WNKQ2lZvpA2mnETI+hAg9gEfndgkuhrRe1nCnof5eZh5yjFe/m95g/u31jwXoD3C2620IroCAz0k285Td537gasVCAY94MPGXZIacNOjvel3kQqqd7cQnB9CZHLwdB6P329JghOooffNbdI7Y4rWL+TbwctnPQQ+PGLg5pnzqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751197300; c=relaxed/simple;
	bh=xo+cE6dhnfLcIh4Q/q6l5x/0ikukQ6FU0Brm4xgXsNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aks1ZTnVE9rJWgc1J3CjqOih6dzudXgTWxuVb9IFhhrzOwJgvw8EdaS/oZRW3QRvoo3yoJ+uTFDN7MvebsNdM67+Ls3Qsfym5XAXMYitjcRIq6QCWo8gc10B/To0KnnalKAx0nUW0KgdrtzbT92mcgO/aXUIK7gtMGXeGLOnuOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAQHjXXt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-747fba9f962so3363560b3a.0;
        Sun, 29 Jun 2025 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751197295; x=1751802095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2KT37wcC3DUtcQacKWLIK0DWCImai66iv9l2EUEALl0=;
        b=FAQHjXXtKtCPVZKDspqLrukg7lh5KtbeOrAuhiH8IPV/XsAROxdUS8+4RRahaeVdNQ
         t+TXURXUNmF1ZjHRUvcS0MuEImZk2cMSdI+B5AOmCS/JKHWkvjOC1Zsk2zCm0iWcTSnE
         vjq+7hWe2pnxoaoGzBhHqgM547RGP4OcdazYMubVnb9vMKgrMIEH8jd1q++0/nAdAigm
         9b7h2Hr88HNuEwPU9rueH09R8OdWJINhlwZhpMr0qrWF8z8avcBIt4C9ajfvSqPQc3Lm
         XM6RnVaSO1AQ9wfjaPpi1aqRmG8cuknk0OoqcMLoGEDtAIO+smLQH7XKmOZBcC6tSPnn
         mU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751197295; x=1751802095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KT37wcC3DUtcQacKWLIK0DWCImai66iv9l2EUEALl0=;
        b=fgyD/HOSFjFLPUwjJjPTQlOehD2Ioy0jbaB0ede9rk0NpziQ8Ile30PRTxNNPAyj7K
         vtC0IkMCwV+95eSFVfb4GXWHRfuzGyAv6prqdz2MigRMKfO0SF3k0/xXQ+FkzxqcYsQ2
         M2SDk+SrBJ9VLyWzsW1of/Kq3OOtLeSg/TTe05BmCYWl5E3SWCBhsM+De8gUTYOFbA+H
         xbqcoJvuvTBcxyLhmkV65urCM1KIIueYdJDFADkHC4FWMfn+h+2Gd9s2ZoKy3N6/tViO
         bPWt8lZUWX8tqlcV2mEzIbmzhD4+cieIPsPjBxukKLqpI25TAuoW4mxRo5zBGO4/12uy
         pLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9ssidN7/nhB/GdEv0udFEtvCLA02Q2stAv6Q+RmtbMAJRtjUVrfzS0hBiUdhufYsNXmLhj8n5IRGNwkw=@vger.kernel.org, AJvYcCW5eOWNgBeXjJcp7suoyFnlFEZSaAPOKug5xhqUvXf++PKf0jH6HBSHAZDgBP7y2r4vdCIJeTIo@vger.kernel.org
X-Gm-Message-State: AOJu0YywZ35ahdLpm2qJb4/tcmZh2+XfEBgsAEJ5IZvkM3epmxheO+6V
	WG0t/nel92LGn5Oh+TdkFQ6pA5Z2uLCEaowk95EEBnqxvgZIgSp46SXoHcU1/g==
X-Gm-Gg: ASbGncuEJwPV+ynfhC+T/facRHPnOnrmFjjyhEl7L1cCXb1NpJbw23MTGgDIV4JRvor
	wpvZzZABcKCWVf4J8gohtVa9faozsWFULsCZjHYQ4MpsZP5G+cMk9As4hpJoegpZIrrAnYqLjWk
	+f5E0l6YIJGUcm6o0mIeTk8eqfORasTENgvX6sEnqi3U+L4Stx1aXdSyPM8xfQ2TUI9nyjBZr6c
	HqoOcQpPM4UGx/Vkv+hbbe3NggJV4lLZEk39RlwwS/dwHHj2iUjdIMRcEFmv72R3o9tIMNXxMQE
	d2u+txp7Dfi1ROPjdxt+F0WEqw5iuAzXdAG+g6NPfxqNfGLSRzCSJM/0R1dzgWhRT1wkdfyzDoO
	Sf02I5Puz42ngl3HViGpRfWjQM3ZSIlQ=
X-Google-Smtp-Source: AGHT+IF4SrNgBPN3p9v+l9IK0AEucqKpF30tPhgsH6XgBwd7QBtloy4FOTv8y8Cfl9PYT9njUD8rQw==
X-Received: by 2002:a05:6a20:7344:b0:21f:4ecc:119d with SMTP id adf61e73a8af0-220a08dc772mr15266870637.7.1751197294620;
        Sun, 29 Jun 2025 04:41:34 -0700 (PDT)
Received: from fedora.. (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5573e71sm6907760b3a.98.2025.06.29.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 04:41:34 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	zakkemble@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH] net: bcmgenet: Initialize u64 stats seq counter
Date: Sun, 29 Jun 2025 11:41:09 +0000
Message-ID: <20250629114109.214057-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.47.1
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
Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 2444305dd..dc1d42c25 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -4116,6 +4116,12 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		priv->rx_rings[i].rx_coalesce_usecs = 50;
 	}
 
+	/* Initialize u64 stats seq counter for 32bit machines */
+	for (i = 0; i <= priv->hw_params->rx_queues; i++)
+		u64_stats_init(&priv->rx_rings[i].stats64.syncp);
+	for (i = 0; i <= priv->hw_params->tx_queues; i++)
+		u64_stats_init(&priv->tx_rings[i].stats64.syncp);
+
 	/* libphy will determine the link state */
 	netif_carrier_off(dev);
 
-- 
2.47.1


