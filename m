Return-Path: <netdev+bounces-133143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D1995219
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E4B2EB83
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E791E102D;
	Tue,  8 Oct 2024 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibf6ABGG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB5A1E4B0;
	Tue,  8 Oct 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397492; cv=none; b=gu2ziA+UV87PsRQhq4tnn0zBouf0GbsR6JYGXOw+9kvbiTgfjSS9QXDkc8maFuViw98/Usq7yI6/n7iadbqDH9Qh2+8qwdbwcN2fatixKMJ9qhiuR6n+pgt147xrf89U8QCD1qWHc03oqehdhke2I12Hs5yish+9nqVh15REniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397492; c=relaxed/simple;
	bh=XjVl5IC6KWGOO7eYiGVH450BK2nGVegv1T2ce52dkmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rbDddtJ8UhkE4WEVRm8NYEfVpP3SV5Nrss6ZAiolVL4hsdMP+MFUWbkr5t5Yc1pwMe9eBTRANbsYAnc+p+uo2lWRG3BCpyH94u72UTG3U0lZKP0srq3qQbZq98D7L4BRw3duOWqfEDx+ChD7Q3nw7ZYifvaWzlBTvfd874ubpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ibf6ABGG; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2e18293a5efso3919208a91.3;
        Tue, 08 Oct 2024 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397490; x=1729002290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/EXl6VMGsRbhKEY09CR1uoI7UwqjG6M9KgbLt7Z5gU=;
        b=Ibf6ABGGC43pUykDxXpnv3Aa+yDZDAhWgiCBczI45E2Pky/Bgn9yQ8KJOqWGlq9MRw
         p3mPn8TQn3ezHlJkcQd0rtw6a/ZibE/wtDCuQr8ZP7embvunR3mBHfnZYN6BOIt4ikfP
         Ihdukp/4GhJGoXpqsEqImMvW9jec3KAkLniKDK/jLMEaKl3KPQs4OdPZ1SSdBKiFUPaR
         HBrznwOQJb3QUt46b8gvbsrDVSuVx2Cw3GZh5J5rECL2XTrIyBTXWYtdWDnojTalyCiW
         TQdE3jxD8jaYJOtyogomYuh6WnGvumURXrAl91Mwm8RIn6ZrSi6aBYikzcZtGdRY8AeT
         2baQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397490; x=1729002290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/EXl6VMGsRbhKEY09CR1uoI7UwqjG6M9KgbLt7Z5gU=;
        b=JQqS7W9nI687FyKfGQBVAq40+IJx+I8gYtQT6fC5BALVNF30M1Fl8vfTnY/FVpLYa8
         kHROWKgSz9w9GhsoX2jVBCFR3zdbKXfO1uih77xuOyIQaojXwG9QSJlxxz6oJvHYEyyC
         i53nbL/9QjWoTm0gDpTcc8CRU3fsfKCGMhMd/fAGL8ZkhCtl91zOV/kbO/JRUyjkS0sZ
         yWhxi2k2wMs4grJZXbviEq9M3gvJKj7kGQZV5HRBcezxxmpt8qERzfcbeklJVDhdKQrA
         0rOxQaHycR5AEs4urclMf92FekkOjJjjp6tgdfb6KkQsYQevgOPjC5u1hT2Zn/5uLo6x
         GD3g==
X-Forwarded-Encrypted: i=1; AJvYcCU2fGQ5EV/DKs32ZW1Hhl+qtOiasDipNfanQobCY1iNuYzAeovUwJDFyVQK653C1RaxIhi+OhcNwS5anWQ=@vger.kernel.org, AJvYcCUfZpDcOKS/HIhGTCZSo49o7lN1CFUGs7thSkKBcG/OdKIdq3VHSqFWdS9xtGvtAa9YL+BMZj68@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYgWoNVbvMZGmM7dXRpzQY3IOf/lmVJCGcnGMJoZJlmUXYs6A
	jtxc4k//UtwimHyWS/NWfVVdKIFfMeyftfpRNsRTeQUALN8BU84a
X-Google-Smtp-Source: AGHT+IEm/TFqbQj0kW7XFjlJYySvYq39X+CUWmAvwGlqSwYNlNGQ5xOM4bcOFH2Go4jUOcbYtZ142A==
X-Received: by 2002:a17:90a:be13:b0:2e2:9314:2785 with SMTP id 98e67ed59e1d1-2e29314289fmr1249936a91.5.1728397490416;
        Tue, 08 Oct 2024 07:24:50 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f68a8sm7675987a91.36.2024.10.08.07.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:24:50 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
Date: Tue,  8 Oct 2024 22:22:56 +0800
Message-Id: <20241008142300.236781-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008142300.236781-1-dongml2@chinatelecom.cn>
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Following
new skb drop reasons are introduced for vxlan:

/* no remote found for xmit */
SKB_DROP_REASON_VXLAN_NO_REMOTE
/* packet without necessary metadata reached a device which is in
 * "eternal" mode
 */
SKB_DROP_REASON_TUNNEL_TXINFO

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v6:
- fix some typos in the document for SKB_DROP_REASON_TUNNEL_TXINFO
v5:
- modify the document for SKB_DROP_REASON_TUNNEL_TXINFO
v2:
- move the drop reason "TXINFO" from vxlan to core
- rename VXLAN_DROP_REMOTE to VXLAN_DROP_NO_REMOTE
---
 drivers/net/vxlan/vxlan_core.c | 6 +++---
 include/net/dropreason-core.h  | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 41191a28252a..b677ec901807 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2730,7 +2730,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			if (info && info->mode & IP_TUNNEL_INFO_TX)
 				vxlan_xmit_one(skb, dev, vni, NULL, false);
 			else
-				kfree_skb(skb);
+				kfree_skb_reason(skb, SKB_DROP_REASON_TUNNEL_TXINFO);
 			return NETDEV_TX_OK;
 		}
 	}
@@ -2793,7 +2793,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			dev_core_stats_tx_dropped_inc(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
 			return NETDEV_TX_OK;
 		}
 	}
@@ -2816,7 +2816,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (fdst)
 			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
 		else
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
 	}
 
 	return NETDEV_TX_OK;
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index fbf92d442c1b..59c87b2a1ab9 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -96,7 +96,9 @@
 	FN(VXLAN_VNI_NOT_FOUND)		\
 	FN(MAC_INVALID_SOURCE)		\
 	FN(VXLAN_ENTRY_EXISTS)		\
+	FN(VXLAN_NO_REMOTE)		\
 	FN(IP_TUNNEL_ECN)		\
+	FN(TUNNEL_TXINFO)		\
 	FN(LOCAL_MAC)			\
 	FNe(MAX)
 
@@ -439,11 +441,18 @@ enum skb_drop_reason {
 	 * entry or an entry pointing to a nexthop.
 	 */
 	SKB_DROP_REASON_VXLAN_ENTRY_EXISTS,
+	/** @SKB_DROP_REASON_VXLAN_NO_REMOTE: no remote found for xmit */
+	SKB_DROP_REASON_VXLAN_NO_REMOTE,
 	/**
 	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
 	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
 	 */
 	SKB_DROP_REASON_IP_TUNNEL_ECN,
+	/**
+	 * @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary metadata
+	 * reached a device which is in "eternal" mode.
+	 */
+	SKB_DROP_REASON_TUNNEL_TXINFO,
 	/**
 	 * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
 	 * the MAC address of the local netdev.
-- 
2.39.5


