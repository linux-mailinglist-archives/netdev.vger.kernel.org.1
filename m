Return-Path: <netdev+bounces-132477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06D8991CDA
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65482282CB7
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994B21714A8;
	Sun,  6 Oct 2024 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecEXfm0L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C481714A9;
	Sun,  6 Oct 2024 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197861; cv=none; b=P77ggtjkbsz5aab8gyZRQo19jDXIJalwyc8BTln/SJpK2buG3YogHXHBuf5PWJTIPs5rmt05lQzuBG0gVtzJlzFtxWA7cuD/NXqL7SPBRSPzaKGFUctgxBW0yZZNFRYN6U2tge+g9B15BpHLBYJiG6VR88A1DZSMdZQ5gMSO2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197861; c=relaxed/simple;
	bh=ujpeecq6Ku1eQ+HNfJbhwy7VJNkiDsWGKEoWWfvU/Hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QcBh5xR1ALJMoslD8lv5pHP/w+Bl/mSf3HlMaboYuXqvwRhL9YkEaWCnQrJtg+XS6dgWYrjMfosCv7BED53rjGCy2zPiccE4zEWD4pJJteSpPL4uTiFPyF8GBYGV18XaWZ7Va3PTfd41XmtdyR7GXPU9cfXZh26Vc6SuKoPKaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecEXfm0L; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7163489149eso3029781a12.1;
        Sat, 05 Oct 2024 23:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197859; x=1728802659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bAbTH4w6YKghRfLGkeXQEpG0Ld8teD6Vf5NXy7dGPs=;
        b=ecEXfm0Ltddk8W09t4hlqqK/3ccpwRN89LO7h9ww/emXfoH1TePIRf08ch9f4IpV2G
         SoiriuvZhoMvuDh5+101teC2pihgRZgMbdb28Oip7WxzBKxWZ/DAlSI6BTELKqMNN7hn
         oGJ6TZQApr7MC0D4WmaVfBmxmgw+2iaXPfETwMdmeKbl+ENC/eNOzI0YWuUt+s7f3E5W
         gYte4Umswcy1QYQ0lDwTtA7pyS2sDO1kttDyn0V8abmkBMVm7UIZ+LjXA98Bx53EK8vi
         goyTi9r/rSiegBMCBH483/ZBKbae8V+UA6jWWFC4V/SgeuHquiHelimpoSthqDxCXCl+
         zT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197859; x=1728802659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bAbTH4w6YKghRfLGkeXQEpG0Ld8teD6Vf5NXy7dGPs=;
        b=iDCk1AiR+Pjc94t8bg+i/C7uyjKTbsBUh/yLpzTYuqcR11Et8Q6UsXMEQcGDSazPHi
         eWi4JQ9IQgoseIp0W+g2J8MAXrlSNHCKgNP2eEIq0Kg8sMwgUY1rEyBx1wGkWYE0Fmwj
         Am2A4vHbEKe/uKqXMYfUt1upILN+ftFBv5gr9y1h5efkRJHyFBkcT6F5cco1EIh5X4qF
         UVcB5/3070ucl/J7Nq7hVWQ28VGiWa6N880x+Yk7LG3YEdLN8w6VeibifOULsU9thxjz
         ojXemHH2UHuagvDAeCeA1zJJ0xQzEN7bO27019LzTTC0z1W0DicXykHKfL9jbH6ccw2v
         H5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWPdaj4S7vPoINQUDnSZKjkNkNIp+ZjKB6pcw1NGMlv+FykycLYSSRGi2X5Kq3olbHO41W2zLdhwqx55Jg=@vger.kernel.org, AJvYcCWnuOdGg7yjlVUBFTQhxF/WRvufrhghchaOhr28Ivkljqp8r2U0awxokkt7s5Q6YTyodADoQzLF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1UCmYIgH4EyBA6Gwcaa6LcGulnrgPfxgVr8pFHwYDI93ccgKo
	Tzu8XcVFwSCTWvEFTHzHtw6qRp6lXsDeQeFgnoz6A7iHfz35j4SS
X-Google-Smtp-Source: AGHT+IH1Ox+K2vHP8nFXzXw0QCiDhOcMNq+9qZlLSXdzdW9b3hdDzBWJDiZv48lYw6z21h70HAkYyg==
X-Received: by 2002:a17:902:e551:b0:20b:4875:2c51 with SMTP id d9443c01a7336-20bfe024d5cmr137922685ad.27.1728197859311;
        Sat, 05 Oct 2024 23:57:39 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af813sm21749865ad.9.2024.10.05.23.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 23:57:38 -0700 (PDT)
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
Subject: [PATCH net-next v5 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
Date: Sun,  6 Oct 2024 14:56:12 +0800
Message-Id: <20241006065616.2563243-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
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
/* packet without necessary metatdata reached a device is in "eternal"
 * mode.
 */
SKB_DROP_REASON_TUNNEL_TXINFO

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v5:
- modify the document for SKB_DROP_REASON_TUNNEL_TXINFO
v2:
- move the drop reason "TXINFO" from vxlan to core
- rename VXLAN_DROP_REMOTE to VXLAN_DROP_NO_REMOTE
---
 drivers/net/vxlan/vxlan_core.c | 6 +++---
 include/net/dropreason-core.h  | 8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

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
index fbf92d442c1b..0a2407e7e93f 100644
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
 
@@ -439,11 +441,17 @@ enum skb_drop_reason {
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
+	/** @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary metatdata
+	 * reached a device is in "eternal" mode.
+	 */
+	SKB_DROP_REASON_TUNNEL_TXINFO,
 	/**
 	 * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
 	 * the MAC address of the local netdev.
-- 
2.39.5


