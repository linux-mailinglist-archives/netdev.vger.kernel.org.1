Return-Path: <netdev+bounces-230288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4672EBE63AB
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 05:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC0DB4E4D6A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 03:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0333D2EB5B1;
	Fri, 17 Oct 2025 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cudKucXB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951112EAB7E
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672555; cv=none; b=asgQQPf9O/IKvTjpqML6Fj02i2ScH+Lz7qzOi9VNDfuSBPP18jLGr4uhcZ0I2TlrIEQ0bxUmxVALAToMFMEDwO+tR8Fz5IAFqBG+oj34F7gzJfzRLDezjSL2s9ACecTboxk8+7HlsFg/YILbHnusA0DG9/HJUZZQUCc06we6LuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672555; c=relaxed/simple;
	bh=tV3M89Ff/zXcbHcKpMVblXkE273el8N9v5UlDIDcdes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhcGcWrBmrB7QkvqF6jKT2PVrkkuUrV9mSaXR1X+LG4a1wLm69qE9U4buMQ6Zji2tt4Wp17p6n23R9qGDhr0KSq1JIUHGa7eRQ/5VBC2hZo5F59PuRZVXlfMONq7wag9LbEn2PRFuYHjkdAAwAaoJ5sja1P+0APtdNZRCVI2ITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cudKucXB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290c2b6a6c2so10143825ad.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760672554; x=1761277354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQCGU65zJTP7rbQY7IxDIXC/3gKQXrOHz6Nfdc2qF2Y=;
        b=cudKucXBvHIeRX1x915w+2C6GNvT5O21rrWck9ek9b4GZmUlmjJPzaElrefQMP0496
         oKfg30zgW6bDJG/XV+/5A5KmIqrV9Sd7eyHxd9CuuMvZ6jBJ6ptfGtZfN8HWgWD3c8qr
         nXyqdjxq7rrk2APky0Kphgflz57UPOjCYdswSwjr45WDy8jOFGnfTal0ZCfB0T69srsM
         hNJTqerrfx4w8d+S+4Lnza6iQHyUDchjscGZIpeUJNsRQqbvwk8C7dg6ghPdX4X1RQkD
         3XgPyFE/ApDrY72WrC5gYPYJFy4YG7JRcTXblFGKDHgW4GxSP+HM7gVlGR5eC1jee0FT
         ZAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760672554; x=1761277354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQCGU65zJTP7rbQY7IxDIXC/3gKQXrOHz6Nfdc2qF2Y=;
        b=goiaM9yWvGIWvLUIR9NzReSi6xRu9LbGRNmJUVpn7vGVjyoUIHwCOjSz6zLxKmuhxy
         5LLSuHuT3g6lan3R8x6NcUs03QlUeDgp+QXrIRejgkbq9xRQL18UVCQIpF6Jco0cnHwd
         sJWU3UW/BtgdcRmNjckAbPg3MlN5aCs2teee3N85RQAQvtlSKPrrgNIUXldKFFLvU3Lz
         I5CHGWU4haPTDJQQcgEFxl6JrOGyGw06zas2p4CjNtiuUQk+Rlaq0UAfEJlSsIm0Ft8U
         irureTKF3p4UQBedSTG6JKF0Y5UUrWGMO4MqZjzQA+XhTCIODJ5yqcyFrDSHLB1gUKUx
         DsnA==
X-Gm-Message-State: AOJu0YxZji/KesheaoyBYmzM7Z4c4Jon8L0eCvQX0R9ltjyDpZ7KQAr6
	BdpihyYU57AO38a/kUoGEM/lFqvqRTLVe9+0IFsC5EXGutdrkDdaA5wjNH7WGp4mUJ0=
X-Gm-Gg: ASbGncseBXeWY2/xEWlKGu17/6pg7CmHNKABgpwd4P2DW1P6B6K0B9SWfUxol+pPwAX
	nM2Idlt0J1Wp8SC3oxJLFETDLRsQU7rZeSv1GGdhCrf8miLtbyB4VJPH5AR7HMD31rZ0Ae/4CRv
	nYTaQzpJEWwPKJOv0+8n2BMOTAuh8fivRYbAb6muMK+/sJRWwAXqtDCpzK6i20Zlznhdxvj+Ifl
	y6EiIZ3YX0UUIRsiCq8OQWcyX8JHvmQRHD83iaG3Dq2Ho3SAsYiI+K+4hQfM50LEjQKbN3Lh0sw
	MKR8PW4Wp23mwxoYPytZ2LaFt7nDV4osiWCDtUtJWajwRavxDA9+n92d1/N7LVdVSNDDFVAmRAG
	qShcfEePTQVbum7GyA+SbUDhEOKXu8TX6u/ZLkzkHP9kdzk+z7001J8UOUpDXv3mD9wSZReGdJr
	kVikOha8WS9RXIi5I=
X-Google-Smtp-Source: AGHT+IHhDudOgwPiLKIoaxZSVvQ0j+dKBJIIPws+2V0xXyqsjbJmCNxXruj71qD8aVFtDr66ZboV5A==
X-Received: by 2002:a17:903:98b:b0:263:3e96:8c1b with SMTP id d9443c01a7336-290caf83188mr25695835ad.33.1760672553736;
        Thu, 16 Oct 2025 20:42:33 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab4715sm46695165ad.93.2025.10.16.20.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:42:33 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next 4/4] net: bridge: use common function to compute the features
Date: Fri, 17 Oct 2025 03:41:55 +0000
Message-ID: <20251017034155.61990-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251017034155.61990-1-liuhangbin@gmail.com>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, bridge ignored all features propagation and DST retention,
only handling explicitly the GSO limits.

By switching to the new helper netdev_compute_master_upper_features(), the bridge
now expose additional features, depending on the lowers capabilities.

Since br_set_gso_limits() is already covered by the helper, it can be
removed safely.

Bridge has it's own way to update needed_headroom. So we don't need to
update it in the helper.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_if.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 98c5b9c3145f..a6d4c44890fd 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -525,20 +525,6 @@ void br_mtu_auto_adjust(struct net_bridge *br)
 	br_opt_toggle(br, BROPT_MTU_SET_BY_USER, false);
 }
 
-static void br_set_gso_limits(struct net_bridge *br)
-{
-	unsigned int tso_max_size = TSO_MAX_SIZE;
-	const struct net_bridge_port *p;
-	u16 tso_max_segs = TSO_MAX_SEGS;
-
-	list_for_each_entry(p, &br->port_list, list) {
-		tso_max_size = min(tso_max_size, p->dev->tso_max_size);
-		tso_max_segs = min(tso_max_segs, p->dev->tso_max_segs);
-	}
-	netif_set_tso_max_size(br->dev, tso_max_size);
-	netif_set_tso_max_segs(br->dev, tso_max_segs);
-}
-
 /*
  * Recomputes features using slave's features
  */
@@ -652,8 +638,6 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 			netdev_err(dev, "failed to sync bridge static fdb addresses to this port\n");
 	}
 
-	netdev_update_features(br->dev);
-
 	br_hr = br->dev->needed_headroom;
 	dev_hr = netdev_get_fwd_headroom(dev);
 	if (br_hr < dev_hr)
@@ -694,7 +678,8 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
 
 	br_mtu_auto_adjust(br);
-	br_set_gso_limits(br);
+
+	netdev_compute_master_upper_features(br->dev, false);
 
 	kobject_uevent(&p->kobj, KOBJ_ADD);
 
@@ -740,7 +725,6 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	del_nbp(p);
 
 	br_mtu_auto_adjust(br);
-	br_set_gso_limits(br);
 
 	spin_lock_bh(&br->lock);
 	changed_addr = br_stp_recalculate_bridge_id(br);
@@ -749,7 +733,7 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	if (changed_addr)
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
 
-	netdev_update_features(br->dev);
+	netdev_compute_master_upper_features(br->dev, false);
 
 	return 0;
 }
-- 
2.50.1


