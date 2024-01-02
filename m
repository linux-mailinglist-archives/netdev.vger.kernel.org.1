Return-Path: <netdev+bounces-60945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBD5821F64
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 17:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1617B1F22D9F
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A940B14F6C;
	Tue,  2 Jan 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPf7usSN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB7614F65
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e73e6a17d5so172712417b3.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 08:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704212542; x=1704817342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W1qqWwI3nJ9JHj6KQAZOfa3AzJkGoktZ1DTfqQ6WGWc=;
        b=cPf7usSNFxuWHWuz8ubq3F0kHanDzeGgo42vtJXtsm47Jf6Ey/f9aU3ZmnWB1YVuZX
         BJV2O3VkSw4SymyRFBolpVS5dBT80RiWRkKIyRh8MO0CK3CRvZ+/dov1zYaJUFJ5yCDC
         gWoHVjhhztUaMfxJUFZMybyGr55j/FrZC9JaLuqFFPG2VtqIZ0LpMk/N09pQPPyqc/Kz
         6Nwxb9/xY8lqKKsFuf7KWCMtllA0ucCNP0tS2mrQkgWV5nTYbrZq+bIINz6njU/yQVVk
         vD2e1vqez5+m3McLvI+ozh4M0CRTYjAnvh6d/HAPzaj1bkcifC5heSNcJ9oYFnGz2p0o
         8lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704212542; x=1704817342;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1qqWwI3nJ9JHj6KQAZOfa3AzJkGoktZ1DTfqQ6WGWc=;
        b=ju7ixWFUW/gjvs0EQcqXl3LVQ/ROmAESWHCXrltjpLEtnCKp7DCbOa3maXfsHaseB0
         i9CPwh82U6VYThQ5cl8klmCIoFJecHExyRTeV+0qxI57rU1xSzhcbowAOjagrs9ap+oD
         UfUDDhUmK8oi4dZ0ea5ZlwjDTlfLnmd8m+GqBAQATRZIXYOTRh+qbMLWbp7yRgtOYJdB
         1fNmSmxe4AnNrtv5NBBexb3QEgf3cyflu1Xt4xSgJ33u6DcVg+Dn2ECJPRalc5hSMXD/
         v0gmBFqgjopAXM+GNVhB9G+wRVA25vV+uExUFgcvWnzm6tBbVuAb05qnp99h+qCAcupa
         Krhg==
X-Gm-Message-State: AOJu0YzelcQjooC20P29inXPV+uo9UyEZ+N5X6rPnSpQbswMl7HVVJtK
	dQtb84sNXiDLHx0ImdjKZmEsj4iHHTKo/1GAhaLY
X-Google-Smtp-Source: AGHT+IHQXLX17wyTXyVjzQeptJxpGwB+H4AyuieT+HuVMs+LpEqMDf8iYjlz48LTj6uH3VdswKsTXhN8/vQ9MA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:3510:b0:5d8:4274:bae2 with SMTP
 id fq16-20020a05690c351000b005d84274bae2mr9201389ywb.6.1704212542158; Tue, 02
 Jan 2024 08:22:22 -0800 (PST)
Date: Tue,  2 Jan 2024 16:22:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240102162220.750823-1-edumazet@google.com>
Subject: [PATCH net-next] net-device: move xdp_prog to net_device_read_rx
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Coco Li <lixiaoyan@google.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

xdp_prog is used in receive path, both from XDP enabled drivers
and from netif_elide_gro().

This patch also removes two 4-bytes holes.

Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path variables")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Coco Li <lixiaoyan@google.com>
Cc: Simon Horman <horms@kernel.org>
---
 Documentation/networking/net_cachelines/net_device.rst | 2 +-
 include/linux/netdevice.h                              | 2 +-
 net/core/dev.c                                         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 2dd8d8f20da2558fddcc341f3a8a27da3c4a1796..e75a53593bb9606f1c0595d8f7227881ec932b9c 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -96,7 +96,7 @@ unsigned_char*                      dev_addr
 struct_netdev_queue*                _rx                     read_mostly         -                   netdev_get_rx_queue(rx)
 unsigned_int                        num_rx_queues                                                   
 unsigned_int                        real_num_rx_queues      -                   read_mostly         get_rps_cpu
-struct_bpf_prog*                    xdp_prog                                                        
+struct_bpf_prog*                    xdp_prog                -                   read_mostly         netif_elide_gro()
 unsigned_long                       gro_flush_timeout       -                   read_mostly         napi_complete_done
 int                                 napi_defer_hard_irqs    -                   read_mostly         napi_complete_done
 unsigned_int                        gro_max_size            -                   read_mostly         skb_gro_receive
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d59db9adcc96e72272d4e981253fd4ee6e4e356a..e265aa1f21699ad567fe3af8e748be51cb7be7d6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2150,6 +2150,7 @@ struct net_device {
 
 	/* RX read-mostly hotpath */
 	__cacheline_group_begin(net_device_read_rx);
+	struct bpf_prog __rcu	*xdp_prog;
 	struct list_head	ptype_specific;
 	int			ifindex;
 	unsigned int		real_num_rx_queues;
@@ -2325,7 +2326,6 @@ struct net_device {
 	const unsigned char	*dev_addr;
 
 	unsigned int		num_rx_queues;
-	struct bpf_prog __rcu	*xdp_prog;
 #define GRO_LEGACY_MAX_SIZE	65536u
 /* TCP minimal MSS is 8 (TCP_MIN_GSO_SIZE),
  * and shinfo->gso_segs is a 16bit field.
diff --git a/net/core/dev.c b/net/core/dev.c
index 31588a50b7573c7f71ddf64b7b25ea5033bb5c97..bc4ac49d4643a557d034ec7cad7194e152a4b9c5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11670,7 +11670,7 @@ static void __init net_dev_struct_check(void)
 #ifdef CONFIG_NET_XGRESS
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
 #endif
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 96);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 104);
 }
 
 /*
-- 
2.43.0.472.g3155946c3a-goog


