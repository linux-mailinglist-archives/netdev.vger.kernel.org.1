Return-Path: <netdev+bounces-152736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526239F59D4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 23:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4C8189357E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F571F8EFD;
	Tue, 17 Dec 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGjTWuB0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639F1D45FC
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734475643; cv=none; b=l274hkrsIzif+D0JHZ4iiZ8UC5vkTGhARiDQDInU83dCKLoRPFyhNvEIemKW3yXIktq2cv4pihK1Pb/5ge1G92HLiqEtJegT8lTaXO1pQgeIKOHf4gaWXWmzgwbcVvgp4PU9Qkjcp3lxKm6FZs1lgAQhZiwY68CEAyEJWEiwV+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734475643; c=relaxed/simple;
	bh=LhGrtUh9EL+yVqH7x3n1x57X7dh4IWsZCAzxDPYq+Dk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b1P/SSkwaeIdzNS3FQxvTSizraatKsAFjWb1KjfrQji7IDapjOOC1F7LV/s0/aC7hUJTXhO94F0Of2G4f/1TBuJaGiPK6o1ST+fr/v2fGcMyC7tI5XItf26nHkidLO49JvyF90Cy+FUAD6KbwM/wYQr2gYR19zKrbw7Us1BE5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PGjTWuB0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725e87a142dso7568109b3a.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 14:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734475641; x=1735080441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ix/VGR59KlP3EshxD6fgl+RyiTaFhUwEpEx25Tnp0/A=;
        b=PGjTWuB0w4CUUgRq7qSJML21s3nUawXI1aHCfXGix5645GAQE9jvtgU32Ve3cBGpGy
         qecCcZdSg9+8URNpEoi7uwW9Xiczw+f7NuPcn4k5DJVybhp8DASfV6gUo+93EmLwPBB4
         RyVuiiNzIes3a+4QNPt4zZ88x6dOyonatrUImq69A7dQafb88VbN8Sy4vyZ1zAvbG7lp
         eI1G6FIKwmk9xMItqyhVHBRoOcuaQU8xZbMjp/wNjv77G5jzRQ+puwXrhbsxQcfxqA2/
         JPk2j2hv3OiRwnT0I+A5tOGzA8oKD2ta+dTyZNps0BtmhutO96KLUIHF4I7wvwyYFPTj
         ng+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734475641; x=1735080441;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ix/VGR59KlP3EshxD6fgl+RyiTaFhUwEpEx25Tnp0/A=;
        b=aReXtSSWDdH58OT5oyzSSPUfQngRE0TNFwUzDcjz46L5aCAYiljC75WpbJQHdG3weu
         KIgOOj6hY/t5/peZR+wvsH6Tx7ER1iaJDS7Ehifx9of/mZqTP1zn95e6Bak7CHNLxQTw
         DX0qTfh6t1zRnPCmYXqSo88x5VjQZhaR+s7rDWSNdfrPSmEXagQ/+urPhaLh4KACgwkA
         s3nxgizVqrzFeHszKIoxPhjZwkDOTIzHWxqVVIkHPJnj5jpwuDCtyrFRYB/+6iiGsHk3
         X35dB4N0k9JWYX0uKZzzyX9D2+x3L+Q/fh7NU93nlti5liU6QGlk2E5xz8IclcArHhDz
         RHbg==
X-Forwarded-Encrypted: i=1; AJvYcCVu+No5nnOgl4iDZVuBAZv5IOWyt1VHUPf/UxSbrlpr5gGwh+xjXk+cUZAREVRgUID9Sno5D3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWwBtRUpbUWXneh9lBbyQiAYVgxmAoL3kwTCDkfmeYAZiivlpw
	hv48yfw0pYoR5VEj308X+HkEstIWwhKIMiDv5hX9f1yxCQQrmu9QQzEyKSJn6XUBaG8hI4JrO5x
	TjcxeehCiPw==
X-Google-Smtp-Source: AGHT+IH6z+Uvt15KHxpuJ7DdB1+v/KELYnNeddXRRbM1teH55lsuB7xzY/zM0UM7XOZVuNAt2n7DqQcXEcyu3g==
X-Received: from pfbll25.prod.google.com ([2002:a05:6a00:7299:b0:725:c7de:e052])
 (user=zhuyifei job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:32c7:b0:725:db34:6a8c with SMTP id d2e1a72fcca58-72a8d23f4b1mr1141110b3a.13.1734475641184;
 Tue, 17 Dec 2024 14:47:21 -0800 (PST)
Date: Tue, 17 Dec 2024 22:47:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217224717.1711626-1-zhuyifei@google.com>
Subject: [PATCH v2 net-next] sfc: Use netdev refcount tracking in struct efx_async_filter_insertion
From: YiFei Zhu <zhuyifei@google.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-net-drivers@amd.com, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

I was debugging some netdev refcount issues in OpenOnload, and one
of the places I was looking at was in the sfc driver. Only
struct efx_async_filter_insertion was not using netdev refcount tracker,
so add it here. GFP_ATOMIC because this code path is called by
ndo_rx_flow_steer which holds RCU.

This patch should be a no-op if !CONFIG_NET_DEV_REFCNT_TRACKER

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
v1 -> v2:
- Documented the added field of @net_dev_tracker in the struct
---
 drivers/net/ethernet/sfc/net_driver.h       | 2 ++
 drivers/net/ethernet/sfc/rx_common.c        | 4 ++--
 drivers/net/ethernet/sfc/siena/net_driver.h | 2 ++
 drivers/net/ethernet/sfc/siena/rx_common.c  | 4 ++--
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 620ba6ef3514b..f70a7b7d6345c 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -831,6 +831,7 @@ struct efx_arfs_rule {
 /**
  * struct efx_async_filter_insertion - Request to asynchronously insert a filter
  * @net_dev: Reference to the netdevice
+ * @net_dev_tracker: reference tracker entry for @net_dev
  * @spec: The filter to insert
  * @work: Workitem for this request
  * @rxq_index: Identifies the channel for which this request was made
@@ -838,6 +839,7 @@ struct efx_arfs_rule {
  */
 struct efx_async_filter_insertion {
 	struct net_device *net_dev;
+	netdevice_tracker net_dev_tracker;
 	struct efx_filter_spec spec;
 	struct work_struct work;
 	u16 rxq_index;
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index ab358fe13e1df..cb0a98469f099 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -897,7 +897,7 @@ static void efx_filter_rfs_work(struct work_struct *data)
 
 	/* Release references */
 	clear_bit(slot_idx, &efx->rps_slot_map);
-	dev_put(req->net_dev);
+	netdev_put(req->net_dev, &req->net_dev_tracker);
 }
 
 int efx_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
@@ -989,7 +989,7 @@ int efx_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	}
 
 	/* Queue the request */
-	dev_hold(req->net_dev = net_dev);
+	netdev_hold(req->net_dev = net_dev, &req->net_dev_tracker, GFP_ATOMIC);
 	INIT_WORK(&req->work, efx_filter_rfs_work);
 	req->rxq_index = rxq_index;
 	req->flow_id = flow_id;
diff --git a/drivers/net/ethernet/sfc/siena/net_driver.h b/drivers/net/ethernet/sfc/siena/net_driver.h
index 9785eff10607b..2be3bad3c9933 100644
--- a/drivers/net/ethernet/sfc/siena/net_driver.h
+++ b/drivers/net/ethernet/sfc/siena/net_driver.h
@@ -753,6 +753,7 @@ struct efx_arfs_rule {
 /**
  * struct efx_async_filter_insertion - Request to asynchronously insert a filter
  * @net_dev: Reference to the netdevice
+ * @net_dev_tracker: reference tracker entry for @net_dev
  * @spec: The filter to insert
  * @work: Workitem for this request
  * @rxq_index: Identifies the channel for which this request was made
@@ -760,6 +761,7 @@ struct efx_arfs_rule {
  */
 struct efx_async_filter_insertion {
 	struct net_device *net_dev;
+	netdevice_tracker net_dev_tracker;
 	struct efx_filter_spec spec;
 	struct work_struct work;
 	u16 rxq_index;
diff --git a/drivers/net/ethernet/sfc/siena/rx_common.c b/drivers/net/ethernet/sfc/siena/rx_common.c
index 082e35c6caaae..450e6d435d5e1 100644
--- a/drivers/net/ethernet/sfc/siena/rx_common.c
+++ b/drivers/net/ethernet/sfc/siena/rx_common.c
@@ -888,7 +888,7 @@ static void efx_filter_rfs_work(struct work_struct *data)
 
 	/* Release references */
 	clear_bit(slot_idx, &efx->rps_slot_map);
-	dev_put(req->net_dev);
+	netdev_put(req->net_dev, &req->net_dev_tracker);
 }
 
 int efx_siena_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
@@ -980,7 +980,7 @@ int efx_siena_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	}
 
 	/* Queue the request */
-	dev_hold(req->net_dev = net_dev);
+	netdev_hold(req->net_dev = net_dev, &req->net_dev_tracker, GFP_ATOMIC);
 	INIT_WORK(&req->work, efx_filter_rfs_work);
 	req->rxq_index = rxq_index;
 	req->flow_id = flow_id;
-- 
2.47.1.613.gc27f4b7a9f-goog


