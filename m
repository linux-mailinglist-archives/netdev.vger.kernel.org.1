Return-Path: <netdev+bounces-250328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3B1D28FFE
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4B703010508
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EA4327BEC;
	Thu, 15 Jan 2026 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skT/3Fo1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C86320A1A
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515822; cv=none; b=LJLPPv0EirTE1jVZGG7VdzeTif1iaC61QT+ZdBWatYVCxMu3zhrSWKPWH18XGAgipFOG4LefaBYewxp/gfshn5ClQNtLmKAc3L9T1r3H3sop+4+2TzXNsPZO0B4l8jgMSSmQ0RgZVAvYd2IFE8NyZPMH1BCIh0Ve+TGLtv9ScbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515822; c=relaxed/simple;
	bh=40F/2n0Y5ytzoXl0ovDTL1vt3bextte+3RoFWfnFZ+s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iURtj90F8OgR8R7Fncsupk/a0hNGtTDGQbPb6bnFWgb9mgpwNE192X3nLCF5oBz5eGliSviJzzvhk2JOyf9GVKcz0oI+qFFWpb6jGE66rUt0J5ZOOP9m/l1AZw4ONhZXtVaVBpgzOUlMGzwv9njJkK7RYYpqczrSzTnyps2wzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skT/3Fo1; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-644790187b7so1724015d50.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768515819; x=1769120619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NQL2qVsBcu8DDV8qfU3/tw3Owv0TZxitHyc9kCEjxgc=;
        b=skT/3Fo1VVUBzx5Jd0WMHoOcKhB8jy5mmC017GlQVso+qI1obEOMILe+BuYLqOq7W/
         sW3Jp4fHD3wLFY/1xeJwVjU23HmsjfhcUmbuPnbgoKaZQsQ6sO2df1xlKU2peKFZvnBh
         OxEFIaQejjry07Dggph+HZMkT6c1a509PMJoLjw7WtJy5bJOacaZ+t7+RJMhvU6b/V2j
         Y9XcGk2O4puZrzSKjp8y3bINr2jf28NDwl6NCobXUT0AJwamyPhVIiog5R9QNbZU2IaI
         OLJSkfXqIyzWQXVNEVt7q9+V+xFkNPlNM0N61Szz1JDIO2RII0HAttwAFjz19qndjcLW
         ZJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515819; x=1769120619;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQL2qVsBcu8DDV8qfU3/tw3Owv0TZxitHyc9kCEjxgc=;
        b=gKfj4IVFbFIBJzOiTXz/CwE2NMcs1aqSkxOczXQbURv2cSIv1hitkNoRFz7S+sVdtF
         CW1bWwLb+iHTmVirzH58mv/1REGBJQsxZUO+kNBKhUj9nX8R+xjw3z9Z9+5ngSn2qN3+
         INanSnB33U6wtHD2hoJFUEyy4JAQkACF0VAa7ErxguVsSbeuCX/uEaxR38frJAd/wt3d
         uzqMQf7lglhY9IFq8IcU88oImTJ1urqVQDOa1PNoBdtzdPJvGwyEB3O58sdJO14zie2K
         jZUkEKGC30OG6LvOk+rV3zhx4xt4DUcrIU1SXjkgOuQC5XqnjepOgAcSJz7yUe3f+YdS
         ffMQ==
X-Gm-Message-State: AOJu0YxTZUVTTIS3F81HfeSkoR7YZl2X3XcVz3pEebD0uQeLpfxRFW78
	uF/cnREQoP/Yan5hP1O0VaK7quJP8fN4WBYffDXRHuV/mG1epv0mgxrez+yOGsfDW1ZFjg==
X-Received: from yxtq15.prod.google.com ([2002:a53:bb8f:0:b0:645:517e:89fb])
 (user=yyd job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:1883:b0:63f:9d50:fdfe
 with SMTP id 956f58d0204a3-64917722d10mr559322d50.56.1768515819459; Thu, 15
 Jan 2026 14:23:39 -0800 (PST)
Date: Thu, 15 Jan 2026 22:22:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115222300.1116386-1-yyd@google.com>
Subject: [PATCH net-next 1/2] net: extend ndo_get_tstamp for other timestamp types
From: Kevin Yang <yyd@google.com>
To: Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Joshua Washington <joshwash@google.com>, Gerhard Engleder <gerhard@engleder-embedded.com>, 
	Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, yyd@google.com
Content-Type: text/plain; charset="UTF-8"

Network device hardware timestamps (hwtstamps) and the system's
clock (ktime) often originate from different clock domains.
This makes it hard to directly calculate the duration between
a hardware-timestamped event and a system-time event by simple
subtraction.

This patch extends ndo_get_tstamp to allow a netdev to provide
a hwtstamp into the system's CLOCK_REALTIME domain. This allows a
driver to either perform a conversion by estimating or, if the
clocks are kept synchronized, return the original timestamp directly.
Other clock domains, e.g. CLOCK_MONOTONIC_RAW can also be added when
a use surfaces.

This is useful for features that need to measure the delay between
a packet's hardware arrival/departure and a later software event.
For example, the TCP stack can use this to measure precise
packet receive delays, which is a requirement for the upcoming
TCP Swift [1] congestion control algorithm.

[1] Kumar, Gautam, et al. "Swift: Delay is simple and effective
for congestion control in the datacenter." Proceedings of the
Annual conference of the ACM Special Interest Group on Data
Communication on the applications, technologies, architectures,
and protocols for computer communication. 2020.

Signed-off-by: Kevin Yang <yyd@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c |  8 +++++---
 drivers/net/ethernet/intel/igc/igc_main.c  |  8 +++++---
 include/linux/netdevice.h                  | 21 ++++++++++++++-------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index b118407c30e87..7ae697fe51cf6 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -2275,15 +2275,17 @@ static int tsnep_netdev_set_features(struct net_device *netdev,
 
 static ktime_t tsnep_netdev_get_tstamp(struct net_device *netdev,
 				       const struct skb_shared_hwtstamps *hwtstamps,
-				       bool cycles)
+				       enum netdev_tstamp_type type)
 {
 	struct tsnep_rx_inline *rx_inline = hwtstamps->netdev_data;
 	u64 timestamp;
 
-	if (cycles)
+	if (type == NETDEV_TSTAMP_CYCLE)
 		timestamp = __le64_to_cpu(rx_inline->counter);
-	else
+	else if (type == NETDEV_TSTAMP_RAW)
 		timestamp = __le64_to_cpu(rx_inline->timestamp);
+	else
+		return 0;
 
 	return ns_to_ktime(timestamp);
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7aafa60ba0c86..c233e78f474f1 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6947,7 +6947,7 @@ int igc_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 
 static ktime_t igc_get_tstamp(struct net_device *dev,
 			      const struct skb_shared_hwtstamps *hwtstamps,
-			      bool cycles)
+			      enum netdev_tstamp_type type)
 {
 	struct igc_adapter *adapter = netdev_priv(dev);
 	struct igc_inline_rx_tstamps *tstamp;
@@ -6955,10 +6955,12 @@ static ktime_t igc_get_tstamp(struct net_device *dev,
 
 	tstamp = hwtstamps->netdev_data;
 
-	if (cycles)
+	if (type == NETDEV_TSTAMP_CYCLE)
 		timestamp = igc_ptp_rx_pktstamp(adapter, tstamp->timer1);
-	else
+	else if (type == NETDEV_TSTAMP_RAW)
 		timestamp = igc_ptp_rx_pktstamp(adapter, tstamp->timer0);
+	else
+		return 0;
 
 	return timestamp;
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d99b0fbc1942a..1c1c7dcb8e801 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1062,6 +1062,12 @@ struct netdev_net_notifier {
 	struct notifier_block *nb;
 };
 
+enum netdev_tstamp_type {
+	NETDEV_TSTAMP_RAW = 0,
+	NETDEV_TSTAMP_CYCLE,
+	NETDEV_TSTAMP_REALTIME,
+};
+
 /*
  * This structure defines the management hooks for network devices.
  * The following hooks can be defined; unless noted otherwise, they are
@@ -1406,11 +1412,10 @@ struct netdev_net_notifier {
  *     Get the forwarding path to reach the real device from the HW destination address
  * ktime_t (*ndo_get_tstamp)(struct net_device *dev,
  *			     const struct skb_shared_hwtstamps *hwtstamps,
- *			     bool cycles);
- *	Get hardware timestamp based on normal/adjustable time or free running
- *	cycle counter. This function is required if physical clock supports a
- *	free running cycle counter.
- *
+ *			     enum netdev_tstamp_type type);
+ *	Get hardware timestamp based on the type requested, or return 0 if the
+ *	requested type is not supported. This function is required if physical
+ *	clock supports a free running cycle counter.
  * int (*ndo_hwtstamp_get)(struct net_device *dev,
  *			   struct kernel_hwtstamp_config *kernel_config);
  *	Get the currently configured hardware timestamping parameters for the
@@ -1661,7 +1666,7 @@ struct net_device_ops {
                                                          struct net_device_path *path);
 	ktime_t			(*ndo_get_tstamp)(struct net_device *dev,
 						  const struct skb_shared_hwtstamps *hwtstamps,
-						  bool cycles);
+						  enum netdev_tstamp_type type);
 	int			(*ndo_hwtstamp_get)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config);
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
@@ -5236,9 +5241,11 @@ static inline ktime_t netdev_get_tstamp(struct net_device *dev,
 					bool cycles)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	enum netdev_tstamp_type type = cycles ? NETDEV_TSTAMP_CYCLE :
+						NETDEV_TSTAMP_RAW;
 
 	if (ops->ndo_get_tstamp)
-		return ops->ndo_get_tstamp(dev, hwtstamps, cycles);
+		return ops->ndo_get_tstamp(dev, hwtstamps, type);
 
 	return hwtstamps->hwtstamp;
 }
-- 
2.52.0.457.g6b5491de43-goog


