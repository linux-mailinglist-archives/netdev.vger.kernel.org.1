Return-Path: <netdev+bounces-154910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D103A004C8
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6113F3A39EC
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122621C07DE;
	Fri,  3 Jan 2025 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJjFwdzS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107C91C2304
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735888165; cv=none; b=YAw3p56uDmOzVmlYONw6yIEYFs3V476Lrpe+sD4dR04zLNq7UyLxSroGSCKi0iPYpTKViwbewnisIi1CfsTyQWNr+MbEBbvIpIToijlkLNty5QcgMX90GHvqdzEaMk+WBvruyryl8PQ0c2l2bMKwpF/CexHOI8FXwSXayg6+NY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735888165; c=relaxed/simple;
	bh=HSJ0ZEy2DPmuDpX6eoSbaBlR6OxYz878S/dQpamUN9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pHHwJgcGpLiAh1rIsRWM6X3HIQX7Y/Iad4x60O2Ydrq5YZxFPNPut4fSU99STZwwI0bMIPq99x598yhRF8c/0Nwn/T3O3rSC5Z9mfIV8hNFAJvFj1ueTwsXWgfmfYc2at9O6WgsT8wiwzhBJ6WlOPirlMs5SpATRYaFW7E6rEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJjFwdzS; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e3167b90dso6148839a34.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 23:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735888159; x=1736492959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6OEzrzuscE4oPpkRFpo2jIt2k/CSdnlVciljdUj3mw=;
        b=SJjFwdzSQw2x6WcT0Baem+CW3rcSw+Xvn1Hp9FBCXAtAsGlma7NM6synua/Ss9fRsy
         G9ZwPnv6p92CJDhArKBPHSRzL7dNZQtKrK/SHS+m/obiGzsGoQEnPeCKa5pcmsidkX3C
         VMV0PB8y5Rk4vwele5D9ol+23f+9O0el6E3m5vcDfFvYEbrHLO/aifPFZ2+lrKs+aF05
         /wUCzZoLVNdG5zBzdKoclODQB2qvwOxZSf9LmcJNDNXLVUunXbZoN/pngK0WCjF/ELkq
         wPR5aEpunF6JpD0mNlooCm0VQSh5UaPtzMKJZxWTw2eH62Z8VjcTT9kbPt1/nDiXIXrY
         RDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735888159; x=1736492959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6OEzrzuscE4oPpkRFpo2jIt2k/CSdnlVciljdUj3mw=;
        b=AsZKTL1pyUZ9zVEDejgRqrxjBd1dlqz75S2AvOsSJhZcLIDYjO1mpWtCCe5SIzj7kx
         8b+xvQD6tsIww+XbLwE1WwXRY8k3tkthYWZL46+/DEsUSxyB0ogt5TzbbSfAaXYHEMJd
         +oAbFSEbJzy65ql/Sqizmn8NN3fEHjwjvjvVtbyABxNQboUDx13sjtqrfCLXopAMYsXn
         QWqLBY2EYk6wsh4BW0JztT7uFMK6UswaoHjzaz/YwYZZPVEPbxQzGf5JxYkTL+UzDL+f
         BDQlZ3epheJbzf2r51Pmgo6Wzrgr4mVwN3bzJjVRN2kNb9Rh0REHlAktsce3NeJ3THBS
         H5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWXDfuFR84C82fa5QqtK8MBB6PzFiao3G5gNpLw/nCRtivI2qeyjl6sp1tDx8/1ee2nkDSiBYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+GnzNbOrrLdQp9i4vzd8KloCjaglCG9ACDBJEks9KK85mIC9
	1es97ZnGKXQ6Ngn5AEl58UyfLqzqcBPHrucq6Gji4bKrXqin7hI=
X-Gm-Gg: ASbGncvH0/9wyJKKCOAl73/YkOLPbUfx4zPsfsKdG9s9HRU4Agc0QXMzDuJMhVBu/QU
	wnOXWz78MxDz0+n4a5LCUxKwYFsQy6tGj7R1E2xCIiRmC2+LIPRKEw8xHb3LnVSatf1BUC2F/z6
	9fOFHBR/Ur5cgXMYEoU1mMP17QKIXzCRWeGO4zlkfs7Hh0f2h0WzDkzhJrOJ7tE4yd6WWQsNDQe
	0n5pyc6Ox3xIaBZniso08joenVwLElgKhJDpbKpcXXe7jEw8GcNAHcsJa4=
X-Google-Smtp-Source: AGHT+IFy12YVHNrc3sT1XyiJQzbsl5UqyT5hOiKulsVvIHKxiXliUZkbrkTUbzTsPMumIoPv0UOK+g==
X-Received: by 2002:a05:6830:2701:b0:71e:1ff9:e91b with SMTP id 46e09a7af769-720ff8f34a3mr29302221a34.27.1735888158994;
        Thu, 02 Jan 2025 23:09:18 -0800 (PST)
Received: from ted-dallas.. ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc998e59csm7896109a34.55.2025.01.02.23.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 23:09:18 -0800 (PST)
From: Ted Chen <znscnchen@gmail.com>
To: roopa@nvidia.com,
	razor@blackwall.org
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Ted Chen <znscnchen@gmail.com>
Subject: [PATCH] bridge: Make br_is_nd_neigh_msg() accept pointer to "const struct sk_buff"
Date: Fri,  3 Jan 2025 15:09:00 +0800
Message-Id: <20250103070900.70014-1-znscnchen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb_buff struct in br_is_nd_neigh_msg() is never modified. Mark it as const.

Signed-off-by: Ted Chen <znscnchen@gmail.com>
---
 net/bridge/br_arp_nd_proxy.c | 2 +-
 net/bridge/br_private.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index c7869a286df4..115a23054a58 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -229,7 +229,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 #endif
 
 #if IS_ENABLED(CONFIG_IPV6)
-struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *msg)
+struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
 {
 	struct nd_msg *m;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9853cfbb9d14..3fe432babfdf 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2290,6 +2290,6 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			      u16 vid, struct net_bridge_port *p);
 void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
-struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *m);
+struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *m);
 bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
 #endif
-- 
2.39.2


