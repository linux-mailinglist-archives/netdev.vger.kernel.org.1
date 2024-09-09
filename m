Return-Path: <netdev+bounces-126387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD125970F9E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8882C2833A0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FBF1B1404;
	Mon,  9 Sep 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaybSFZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98441B1401;
	Mon,  9 Sep 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866624; cv=none; b=mjlnJtElsHX/KnhGecDYBFmPMzLrk4l/0nDVKzQZx/LG91xabKjymg9yYZpyAWz0a8YCxHXXr7X0YUQxWOpiUTFwBo9y7vZPQ0ZEWrKfiuSCwEYCbLGh22OgFdxvERybW+n7EjlcK0gEDcjNIz/BjGgicv70pK9G0ZQvvkckZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866624; c=relaxed/simple;
	bh=xX6LjIMGAR+rjMFZMHvfPgfVPXeBb697cR8npOHoeXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QltA02DEWcMmmEsdXlea6x9/1K0juLySnN6lh2V/3UTM3/QNr/j8MgtCoTfEAd7v/7+LoUBt4WsGRLUiOIWOK1Jb06TF4p/19NhE+3e329NvfVjUV9c+3zW6JxVu69qboGk0kGz1Uf8J8smDIH/l/iu5pCL1JYwJzm/xrnLRr8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaybSFZU; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso2210572b3a.3;
        Mon, 09 Sep 2024 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866622; x=1726471422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhzebvioE/S+RtKNos7CT8rVCz+51LAcKnC+aoJ/JjE=;
        b=KaybSFZUs7kJ0lk2TYqW55d38GEpb3i+YzYJ8/b5XIFWU+Pg6qBNZS8kr2ZEI1IIF3
         8mKz14kGlYdFKsZSS/NRQfxV628SGlDd8Rjodt6BPGRqfTWm6eoNiGyE5L92fBNr3wiP
         aii4QZrrLf3gBhG2zoZ8NFKolnRr1+ET41DlKY7w4tItz6KWuSw+JE5hGScnAOcdV+CL
         LdNRfKqbIEFjKXGeOazh4Yzk7xSbAXj8Rf4ZTTgze76vsOnYxSRf6xn8gucwgbyUQu9J
         78BbJOW4ch5vxe6SUxrsyHDE0260mM3mNOoHbzMZIdLb0UtyC6mWH9oPbhwBaUpADU8X
         TxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866622; x=1726471422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhzebvioE/S+RtKNos7CT8rVCz+51LAcKnC+aoJ/JjE=;
        b=AOZ6vtUCAWifLW99MOHx/vtt523QP4jplkwLJGSG5udrUuvexlNcueygrdH8I1Uy2/
         C9NmuzgLR3gejgaMCvRko2fa5BlJ/+G6wpAhXPrOX95Bui9NvByHkEDPvEaQJeZmhmgp
         LpWwXgOEiHNdOZIU+LcNDXkL7JV+DlHK84vVDWopaPX8PeZSSIi8aXCWLuLBudR+56LZ
         JXzbRh3yKfYYVMr4TfRfoXD2xXM0OlRArvT+b7COBD3mYqW7v8ZYmjmBJx9vo5iiFWwZ
         cLhx7l7ho4C+5MoIiSXM+k74jKDShMUPhrMsVFfCqjGhURflxiEEujLPULSSFrEf5AT1
         HYKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcbqPgi15re0Z5Py17nV5LZeSDfrrYURyWnQaSh8qkrH0guxtyPcLQL7rGwI69xQLitoceXMLiyvvmJ38=@vger.kernel.org, AJvYcCWtmj4AS4DgnH9oSsAXA7nKQYNdSr5BGde2mmaNz3rrKyy/TtZCVzD1muWdIge1nwWOgwpIsJl7@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDCR9bkGX878QrOzFhp3enXrZTQe1A6S6aCnW3/6/Ji4IPqse
	7VFE7ZlSkZ2Px3yiefIckAt9lZ5ImsTCUFu8ULQiB/zhc3b43A18
X-Google-Smtp-Source: AGHT+IF2U93dDIx7KyH+rvbOjHbgHgSnrPnN3W9nHoTVZV10gqk9dA8rkI5/BKcHH+fdts//xLP1jg==
X-Received: by 2002:a05:6a21:1796:b0:1c8:b255:486a with SMTP id adf61e73a8af0-1cf2ad2a4bbmr9593904637.35.1725866621822;
        Mon, 09 Sep 2024 00:23:41 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58965bdsm2962094b3a.29.2024.09.09.00.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:23:41 -0700 (PDT)
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
Subject: [PATCH net-next v3 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
Date: Mon,  9 Sep 2024 15:16:48 +0800
Message-Id: <20240909071652.3349294-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
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
/* txinfo is missed in "external" mode */
SKB_DROP_REASON_TUNNEL_TXINFO

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- move the drop reason "TXINFO" from vxlan to core
- rename VXLAN_DROP_REMOTE to VXLAN_DROP_NO_REMOTE
---
 drivers/net/vxlan/vxlan_core.c | 6 +++---
 include/net/dropreason-core.h  | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 6fe5b75220df..6f35448fbf3c 100644
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
index 38f9d567f501..03dd53a8c2ab 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -96,7 +96,9 @@
 	FN(VXLAN_VNI_NOT_FOUND)		\
 	FN(VXLAN_INVALID_SMAC)		\
 	FN(VXLAN_ENTRY_EXISTS)		\
+	FN(VXLAN_NO_REMOTE)		\
 	FN(IP_TUNNEL_ECN)		\
+	FN(TUNNEL_TXINFO)		\
 	FN(LOCAL_MAC)			\
 	FNe(MAX)
 
@@ -439,11 +441,15 @@ enum skb_drop_reason {
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
+	/** @SKB_DROP_REASON_TUNNEL_TXINFO: tx info for tunnel is missed */
+	SKB_DROP_REASON_TUNNEL_TXINFO,
 	/**
 	 * @SKB_DROP_REASON_LOCAL_MAC: the source mac address is equal to
 	 * the mac of the local netdev.
-- 
2.39.2


