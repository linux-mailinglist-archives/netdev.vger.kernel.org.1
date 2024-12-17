Return-Path: <netdev+bounces-152729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC7E9F5968
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 23:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3C37A353B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABA31F9F6F;
	Tue, 17 Dec 2024 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dtkcv8Dm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D17C6E6
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 22:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734473602; cv=none; b=L4J9FwTYHj1F2yiU9MbWbJqWPGGyVa23v6BwaHxG72TBO2gI0O4BCvZEK1LMp0q1TkJSNBO30raX7tzb09TuPO4fQE2k0P1rNa4Vyw2qFDHKdHAO23ROjjoRSAFgvOuQ+zfGqUyKuFN416IunPpwwAhnVkPAR6yESP+QDHm4lcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734473602; c=relaxed/simple;
	bh=x/KLuUSNbbqJ7YIu94h9RPG2gDjw1fSsjYx4Refwaoc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R9Pv0lvwfNV3ZyGX/x4fzNfdsitnuHI3niyuANOjTAR6Ark8UnKzMKI1VajF4EXpjzoaLk0cxiU4KbLCgg8aUtkJ8qXUEZzqtM3dv90iiL2tI0J4AFEv8P2ZEhEtqtYPPhgZMwkMMAaxPhswfeLGR3NHksx4ePb+beL3X1OqkpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dtkcv8Dm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725cab4d72bso4453493b3a.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 14:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734473599; x=1735078399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nk1ptDRLEJiAS3q/c25SsjSlvHD7/gtjwNCRUciNV/Y=;
        b=Dtkcv8DmrXOx3aFPUDMmBie8Pu0QE1sUuWNjyAowOI+cflc5OfdWd+E37dh7TUSiFs
         slZgRrDCqy3px+PHi9dNoMEdkBw0Q8Ty5xTJIr4QMNIaXudN0aNCnQBxEvdJ/+aTPj71
         aDmqTUPwTV3hmA234fjU82LmGvCZ+RzIGQRkIsr1vMZFlLbHH2+rIxCRXtZ9BMfqYJgV
         dR4OB+5vIxOapm/MYc2UL27ZlKZT8Jlb0KujU8PU1Xjm5bv45cqMZs9TqLJejfXTVHdg
         qPhZB+i5dKvSGoIyJSSdg/t5iUFYJtAwEn0ZFS15hMbp5e/5NOevHeXvfCdVs7mL5rH3
         X0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734473599; x=1735078399;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nk1ptDRLEJiAS3q/c25SsjSlvHD7/gtjwNCRUciNV/Y=;
        b=Q7Yx1hLvnDPdgdosANAV+0WZ+LsTngPSFQWQTt8Mawyte7JQ9n81xMVH1iMo3UADj+
         C1aJ/D1P6p0WuJ5/tChsAZgvrjVTce5Sl4UgtcBmK18GUsVXU6lIduUERVYtdfqigi2Q
         8ttg26wkp4vR20u70dWu0YNOsBJl+xoGffGbxl8zJnpyMI3tW5QyvV8bvodnONQPkdkB
         qwt+sInYhtQgKAPaRmTzgBWRR7Z76Ny2dIRIiUhhUdLjoW/euf1G8wUIfktJsHNFG+id
         xTHWuPesgLsEnEI1W/8CYwnteOfWINl1Ih73YKV1y9EgkxUcf/LmxDrd3a5EA1MWV5eq
         G1xA==
X-Forwarded-Encrypted: i=1; AJvYcCVed7KnKuyQ4asfB7BMrNSLeJDD5zwzk60y27H/Ol/hS5onYxHgEccgmASoEY4qVkx2goQ2Vvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrdkVdO6SvmhmAkxkBK6RqVow7T+gkw8tc7AW/ohPXOyHFzAGR
	E6dMqi8e/5sLYdIcZIDlzmBCDAV6yjh7TPnqSOk3rYnPU2Uo/HK7PK6nL9OEGjOKeFImQ40cstz
	yCNAGGdYhtw==
X-Google-Smtp-Source: AGHT+IHBer4r9UGBFvkFDyecnLFhRXKfdLZ5WB4NGbPNpDI6qff41GDS3WudrKSPegURONVwd9j50+nWdZQjrw==
X-Received: from pfva18.prod.google.com ([2002:a05:6a00:c92:b0:725:d9ab:3f2e])
 (user=zhuyifei job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:888c:0:b0:725:ef4b:de21 with SMTP id d2e1a72fcca58-72a8d2c4800mr1049462b3a.20.1734473599629;
 Tue, 17 Dec 2024 14:13:19 -0800 (PST)
Date: Tue, 17 Dec 2024 22:13:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217221302.1697291-1-zhuyifei@google.com>
Subject: [PATCH net-next] sfc: Use netdev refcount tracking in struct efx_async_filter_insertion
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
 drivers/net/ethernet/sfc/net_driver.h       | 1 +
 drivers/net/ethernet/sfc/rx_common.c        | 4 ++--
 drivers/net/ethernet/sfc/siena/net_driver.h | 1 +
 drivers/net/ethernet/sfc/siena/rx_common.c  | 4 ++--
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 620ba6ef3514b..8c831b66c78b9 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -838,6 +838,7 @@ struct efx_arfs_rule {
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
index 9785eff10607b..332449bb94580 100644
--- a/drivers/net/ethernet/sfc/siena/net_driver.h
+++ b/drivers/net/ethernet/sfc/siena/net_driver.h
@@ -760,6 +760,7 @@ struct efx_arfs_rule {
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


