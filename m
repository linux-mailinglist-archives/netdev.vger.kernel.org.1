Return-Path: <netdev+bounces-133429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE30E995DD0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21701C21753
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348D914B970;
	Wed,  9 Oct 2024 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4EgHiFL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDF71714A4;
	Wed,  9 Oct 2024 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440992; cv=none; b=Cek7jK+Kn4ICqRYhcExibw8a9a7jv83bQsfBUYstxqY8uPfJ+oUhSxYaqz+GaNGtvCmGXarfhCCRoHpjA4m9CJyF0/boYOMlflBoiIp912Dn4bDLdiWCM/QGeKDPuMn+cYhzoDUZ5/ZJ+HJti1Mrj/wfOAHePuebBQrlfQ9sZms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440992; c=relaxed/simple;
	bh=ZAosg6sRSO83NLhdq2XSdXeuJvr4vRDwWp0MpG86sgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeYTvRxsobe0PaNaq1QesVMTGojjP9Tw7d8utpA4TC7f4QXoMFUoPQX6ARxK77NwLPTqzOT6QlZ55NscJtCDka4L4VijH0UAo32Ycb8m4CkRnd3CyZmZFpXndNntWPY4iCOLxnF+sT2u9ic92jfP5gJGSXF6tD2+M9eTcts8Lqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4EgHiFL; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2e18293a5efso4354442a91.3;
        Tue, 08 Oct 2024 19:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440989; x=1729045789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACzfDnBPZ2zKMK1LA1OtfcN5HTpxaKXpt8zIEOrq06Y=;
        b=P4EgHiFLNF7WMLg8PSBK9kRAkxQQ32O/wqv6vcqdGsp0Z7rK28Gw+WsU1t52YMV6qW
         0auO2ovWsEuH0+7WH70BY3QRTCMLj2FcSYK/Z5EzUBUiL7eLGpGWlLA7UoOIm6S9IVyJ
         7usWB+pE/rsb+yviwfJ1b34wHbSqH7kQfcIwIRrQzDNAf+KZlpYGsNIjYmt20j0Fp3aA
         +R1OdBwXi4Q9zwHUgJV+tWtBEVhmha2sPovGpwkxpr+REL0ZZMCqLlGF6KWm/TKfeVWc
         aqN9Yn8ElLZDJ4rCM2BsVCdZ4KsubwLLVHNNqD3C8hhf5TbUmon6M2EfEb/Wl1wn/4fs
         +pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440989; x=1729045789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACzfDnBPZ2zKMK1LA1OtfcN5HTpxaKXpt8zIEOrq06Y=;
        b=WtYvYKRFeFijIh7hXO9Kc2jq0GeG9QgUaajBv5P4fTmImkxZYuc+5XD9sSkwZak/vu
         gweXRW42VoiePLDF7y8ogXTT2gxfbWN11oxLmFESRjP/M3+XdpFxuCJQhEYe+mPXkIoU
         4pKusAH17CizsWPJnst3gHnfq6gNekXRhoeI8VttwCzs2AKuaH0j8+rM6MwQGK91LEAM
         zNnNF61WSasC14Z1YQoQ4qhDtey4AWwONeSErkiJGGQTxLWH3UTcw9wgJWWGqLHcoeDV
         pL+jr03VgfMX+0HpEvkdcNgVVoHFy/Fi1yBejMvoJKsoaG2NqxEOHmddImPfZmcT53pF
         etAw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Yp5XvLNe440PrGMyq/j390mPTArOagRxmzbr7ONTPzXcig4visybHRpwfamuysu+DKrLZG5GM+9J3EQ=@vger.kernel.org, AJvYcCW8Z/C6ttRrUdVF2P2HdbF3zWiSf2c5EAOn8SOfb0tt7Q/Iy35bXw7i3YDJvBfVjXw5f12QACBh@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSb/9GBLFEgaBR1idIf2kM1W7OoZ1CPePd9eo7qw9Hq9jUKuc
	4+nsUqL8u+7bZj8K6XId0O6Jcu8Gf33/Ss4wAR+7xLu/I1LJ+xYA
X-Google-Smtp-Source: AGHT+IH2HkD13szisgeE038Q7wOZH06A/YQxPXdL8g0hH/xvkHd36kJIorLKFigLqtRRu5rgK9tmcQ==
X-Received: by 2002:a17:90a:1b86:b0:2e2:af53:9326 with SMTP id 98e67ed59e1d1-2e2af539345mr156947a91.30.1728440988736;
        Tue, 08 Oct 2024 19:29:48 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:29:48 -0700 (PDT)
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
Subject: [PATCH net-next v7 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
Date: Wed,  9 Oct 2024 10:28:26 +0800
Message-Id: <20241009022830.83949-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009022830.83949-1-dongml2@chinatelecom.cn>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
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
/* packet without necessary metadata reached a device which is
 * in "external" mode
 */
SKB_DROP_REASON_TUNNEL_TXINFO

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v7:
- fix some typos in the document for SKB_DROP_REASON_TUNNEL_TXINFO
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
index fbf92d442c1b..d59bb96c5a02 100644
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
+	 * reached a device which is in "external" mode.
+	 */
+	SKB_DROP_REASON_TUNNEL_TXINFO,
 	/**
 	 * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
 	 * the MAC address of the local netdev.
-- 
2.39.5


