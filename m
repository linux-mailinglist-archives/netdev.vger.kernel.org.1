Return-Path: <netdev+bounces-123556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC5F965500
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5801C22A58
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E3A14EC75;
	Fri, 30 Aug 2024 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blMFAUmG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA1914EC48;
	Fri, 30 Aug 2024 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983376; cv=none; b=FPPp9+7H+6T+J+G+z8ZtRap+czCPHrtrG51QJUPGP2ElvZZ3Sz1StM+O/LifKlAQiYRHLaNGb9XGTfOF3xq6wkBn9VZuSW11KleT6PR8wnqG49aY4MOSQBoA5GZWv7czVh7jaovwSJxeLEgf9BEQMoXg9GyC4sjpriSCFJ1rGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983376; c=relaxed/simple;
	bh=el+4PdY80DKzb3LKERekQ9J2SM6HRznhUExf+x3X8FM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oXjDtPSvxtIbiRtwMr5/NJRniZwqHYBgRcq4tjBxB7USO9RtC623wxHQUUC6gbDgeQ/vb5TAxjBvw+QXWrtAaJJrvwn1unw8G+MDP0orzIu1vTZtZyFdpxyGKiIeo4fPNyYHxmb7fhRZIjOlSQfg82/9QaDrLNUgmR9dR8qlmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blMFAUmG; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7142448aaf9so946298b3a.1;
        Thu, 29 Aug 2024 19:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983374; x=1725588174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28Zad+V2vcstpXEFS5Vp943wu1V9ZiKrLymEzef3eY8=;
        b=blMFAUmGr0O4Lrs98gN2JULCJt3LLZLv2Of7b5RHWUazwEHf1RMTE2Qb/easG+MJ82
         7L7GU9lr4xzh2fUVKZrmedRIZoGQK5wDyAebHW3J65Dl8s1m2jnFa4GCKYtcIL6ZsQUo
         UeUk2qo/E+DS91eZtOfE2o39iNNW8hKrQlTFYb1k7yRS5e0JV6qdNZJg94hZzKxLkolE
         KZCRNEeh4MYZeLDZi9+ateuKEjFslsy2oMe8lbJMbA/FEfo17e/GmaMpWSpEoD4Am+82
         I/o2gtQ6tPmfTuCz3dEc0jS37AF5w90drYY5LWEyuuZW9Uqs4/vIS/SBlK/SUGKndGop
         9o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983374; x=1725588174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28Zad+V2vcstpXEFS5Vp943wu1V9ZiKrLymEzef3eY8=;
        b=KZJuc/NvyoJd6sAHkkPMpySgOPGc1fPslvhVcLMFvvVbGnsKXkhAmS+xFiLnFFQQ3z
         PBhA8gB6gMtRr6s4PpBk3t8GtmiQhVdDVfSQIwT0CbsDLXQPy+gLQUaABTyMggzarqi/
         7NA7/XsIz4WcdT39lQNwsvbKGR8O1RO9MrciygQF19EFhv2/4M80uopIPJ1Q2wTK9Bql
         XgxyM2aeywG1w7dvAJaLr6c+Ss/vTbBXMxBi2nY9HCcHQgzTDR27EDHTCrxfhOoA7AW2
         6o5JBl6NX+mE6yEPMjcxvVwBced/o4B1tMKL2mKUSIQXgwqZ8yFTL3F52TKC5p6+PJeA
         pIEA==
X-Forwarded-Encrypted: i=1; AJvYcCUdraoFUaLA0CgeLbONxpORqmDHxxogiY6sYolwPyolr6n+Ubd1iatieIlIAM5G4U1iujimMMQL@vger.kernel.org, AJvYcCX1PiYfa4O97PSgoXsPE27G3A4M1ekF/fDmAwD5YDpeFzVZ9u4nfK32wLntsain8bhEg4bErJPr8X1+ACY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAf+Rda13JVPwSkX2x6c6Sr4uTML4cxJuiv5auMwkxbY58ViMC
	zDZKPDmBpVNDITvW62FSsNxJhawUeDTlIhNswn/V6YYu1Jtq6ffz
X-Google-Smtp-Source: AGHT+IGOsCe6FSMMG65dm+WSBFBATv+MW2aJsrHTUa7DzJFZJIB38LTplp9ccmoF6A9NavwdNMUmAw==
X-Received: by 2002:a05:6a00:2e97:b0:712:7195:265d with SMTP id d2e1a72fcca58-716f20916c8mr1162112b3a.0.1724983373950;
        Thu, 29 Aug 2024 19:02:53 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:02:53 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
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
Subject: [PATCH net-next v2 08/12] net: vxlan: use vxlan_kfree_skb() in vxlan_xmit()
Date: Fri, 30 Aug 2024 09:59:57 +0800
Message-Id: <20240830020001.79377-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830020001.79377-1-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb() with vxlan_kfree_skb() in vxlan_xmit(). Following
new skb drop reasons are introduced for vxlan:

/* no remote found */
VXLAN_DROP_NO_REMOTE

And following drop reason is introduced to dropreason-core:

/* txinfo is missed in "external" mode */
SKB_DROP_REASON_TUNNEL_TXINFO

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- move the drop reason "TXINFO" from vxlan to core
- rename VXLAN_DROP_REMOTE to VXLAN_DROP_NO_REMOTE
---
 drivers/net/vxlan/drop.h       | 3 +++
 drivers/net/vxlan/vxlan_core.c | 6 +++---
 include/net/dropreason-core.h  | 3 +++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
index 416532633881..a8ad96e0a502 100644
--- a/drivers/net/vxlan/drop.h
+++ b/drivers/net/vxlan/drop.h
@@ -13,6 +13,7 @@
 	R(VXLAN_DROP_ENTRY_EXISTS)		\
 	R(VXLAN_DROP_INVALID_HDR)		\
 	R(VXLAN_DROP_VNI_NOT_FOUND)		\
+	R(VXLAN_DROP_NO_REMOTE)			\
 	/* deliberate comment for trailing \ */
 
 enum vxlan_drop_reason {
@@ -33,6 +34,8 @@ enum vxlan_drop_reason {
 	VXLAN_DROP_INVALID_HDR,
 	/** @VXLAN_DROP_VNI_NOT_FOUND: no vxlan device found for the vni */
 	VXLAN_DROP_VNI_NOT_FOUND,
+	/** @VXLAN_DROP_NO_REMOTE: no remote found to transmit the packet */
+	VXLAN_DROP_NO_REMOTE,
 };
 
 static inline void
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ab1c14a807f2..c3bdac6834d4 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2728,7 +2728,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			if (info && info->mode & IP_TUNNEL_INFO_TX)
 				vxlan_xmit_one(skb, dev, vni, NULL, false);
 			else
-				kfree_skb(skb);
+				kfree_skb_reason(skb, SKB_DROP_REASON_TUNNEL_TXINFO);
 			return NETDEV_TX_OK;
 		}
 	}
@@ -2791,7 +2791,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			dev_core_stats_tx_dropped_inc(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
-			kfree_skb(skb);
+			vxlan_kfree_skb(skb, VXLAN_DROP_NO_REMOTE);
 			return NETDEV_TX_OK;
 		}
 	}
@@ -2814,7 +2814,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (fdst)
 			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
 		else
-			kfree_skb(skb);
+			vxlan_kfree_skb(skb, VXLAN_DROP_NO_REMOTE);
 	}
 
 	return NETDEV_TX_OK;
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index d38371f33e2b..77bd92f507d8 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -93,6 +93,7 @@
 	FN(TC_CHAIN_NOTFOUND)		\
 	FN(TC_RECLASSIFY_LOOP)		\
 	FN(IP_TUNNEL_ECN)		\
+	FN(TUNNEL_TXINFO)		\
 	FNe(MAX)
 
 /**
@@ -424,6 +425,8 @@ enum skb_drop_reason {
 	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
 	 */
 	SKB_DROP_REASON_IP_TUNNEL_ECN,
+	/** @SKB_DROP_REASON_TUNNEL_TXINFO: tx info for tunnel is missed */
+	SKB_DROP_REASON_TUNNEL_TXINFO,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
-- 
2.39.2


