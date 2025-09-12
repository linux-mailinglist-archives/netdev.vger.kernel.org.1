Return-Path: <netdev+bounces-222658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3AEB5545A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051B7AA20AA
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7A2327A0C;
	Fri, 12 Sep 2025 15:59:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AF322DCB
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692782; cv=none; b=h1WPadSB9/e9cUZQOu6OKFh+3q3fsF4GR/adNLxgwqh52n1uaTJL+wlYVpC9Kd9enGUmsXMcZAOGRYAVvOqTv5TYV8Vpk/w3bG2ukO9G1cIIqM7sqAPPg+U4JCtB1bqFCiz1MvZLyOPHR01mN6No+PvHP4xJLb1wyHjjxrCsUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692782; c=relaxed/simple;
	bh=Y2hXfnHzSfKGpkRV/+ZGUekIkr1Gt4/QOQoMmnAXviE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ia1krQ8ix8kKQ7TSYlCXjplj67Q1JAABzbExMxuGFo3xikkVncMiZvfd1NKhTewBlEQaxwYUreEgmO1g+nVa/9lFfgW9oW7VlOz72S5vDlXBdqrlUbolBbsQBK5EKlPcdzPFCOLvK8HFNWUZbh93l01/GLS4AbIm+/wST93zKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b042eb09948so443691266b.3
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692779; x=1758297579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0gIuHH4FHMvq9oSF/Jigf17pZ9LbJklvlGco8PAXnY=;
        b=RSSMvghxJuoaETgy2zorVypektYDvistlY52G4C2jPUZkbxgjZa/8qFw7RlxvgfOCB
         YRHJ6ErQdyO+w12OPd971LterA2/hgkHYKDefEzMFbVnGLqLH60GnlMhSe6RG9RJeTf1
         t17lPXFeL6K+OYi3LitpNXi9BuFs8I9yh+itroU+m8F71fWSOYXTOvh/NJ5i6T2wN9aM
         V1dU6CR6uWmWqagzP/NytEJltacNHROeBWYDdep2M2wEsg/p+v7ufg9paeHUrXBPp87V
         osTa9OeGPEmaF4bE9ja4SZP/hhDW+rkD/+TxdfD33B1Xve0h1SSV4uxqT0iE0s1XgCqC
         XBTw==
X-Gm-Message-State: AOJu0YwJNDpdra+ciy4bBpMf3eInRxWsS4accy/L8ecqCoCwWhipaFam
	3FU2oNhJVANvh6Rc0+mtDspYlmKT2/V+V6XWC/R0dTTRW6r2ANs+2d21
X-Gm-Gg: ASbGncuzjMePeiIceuezZzp+cRZFtCkGS5a5kLmNmmPkPPzmPr3f/6CcwFfdFkMsJpe
	Fam6rd2SFiyaQ5O+93J70RpbCqPoG1Hk+aDqHlX8DrTXFEfZtgbJtipKBOOXjsV4CQKlbMmHf+h
	yyKiYPc4wsis4wjmXlwYOMwl1HV0DeeLYkxQTQrn18sNmGFP6QtMXiG3tCauTlOOIfZSseR8L8X
	48Z7u5anYeBglOC/keJ4sWv2pKtTHpolkbaKqSTiP2/fWOEWPTAywh5L2mk5zckZvRskrTrKeYE
	D9so6FmxmWvvDaZNS9nVDCdtwq+HDEawHC9woMmf/UteOp/xmwSocVlYgrE4MEKkfeM0httEu2D
	igzlLtNI4QaihZKkoeYJA1dWv
X-Google-Smtp-Source: AGHT+IENc4Ma8V5tCc/liKhp+02LKc2RicXHgsiwshsnplPzDX12vx98CIJbx90/d9q+6PULUumo8Q==
X-Received: by 2002:a17:907:3f18:b0:b04:45e1:5929 with SMTP id a640c23a62f3a-b07c35cd746mr359576666b.28.1757692778573;
        Fri, 12 Sep 2025 08:59:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33f3c01sm3584285a12.34.2025.09.12.08.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:38 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:16 -0700
Subject: [PATCH net-next v2 7/7] net: virtio_net: add get_rxrings ethtool
 callback for RX ring queries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-7-3c7a60bbeebf@debian.org>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
In-Reply-To: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=leitao@debian.org;
 h=from:subject:message-id; bh=Y2hXfnHzSfKGpkRV/+ZGUekIkr1Gt4/QOQoMmnAXviE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENeBFGi6WpdTS8dpLji/97clvQfo2zMjVoNE
 56PFE2cZluJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXgAKCRA1o5Of/Hh3
 bdEVD/0XB2Bl57L+rLumfG+of0zBhpBmxvs79I7Bx+mXlU0xsci+hGJzDcx3G5qMnEWiIYYrDMg
 ENU+pkKPyT7wLQ6HhaeQH5su1B19HWA35aqAhkbbJaF/GDSl1bhrAxMQ2760HBmXo4FAErMzz9L
 2x6DIxi70oHcK8swT6751x0MXxqot89K1pzgh2D7xgBBGENxY6AXvdT7zzWOJT6c63v2gH8Rsrk
 CjjfqojfPIP0aPVE8NbnmUQ42KigZXuJdNnitjTE1ok7ymYN2wZbRUMOrzSmuyJ5v4PEIa966KL
 HLzQ5BMb09bn+gX0W4U5XwZznEAEVgIbjY7OAvuKXsUrarYZ5IPyJY/2oc11MhFM2MaA36uDjmU
 zRpmLtt51vHyuUls0x0yU3Plx4WQP8RWMzZRG5KDKpdJMvQJKmKCuhtKFDsX7mF85FxPAKf72l4
 VoEcAUwIci3bBZdZ9wFU3CzpeY1Qlc+SC493uQcoYy7VR//qHNz4aUbO8rOaKzlermR9c6ChYdm
 8MDXoMyIVKGmmb6T0ayHbpF+1x7aUK6+5y1Dle0bu77fnCmGYI4A6Rn8hveuQNNPMou3SxPtPxk
 4ShbNEvs8CF0KN9N+RsYNfTLgvsmQpH4pzF99CTHrj8hUPcbKyuBSbw6PddAMO3Xhw5lzWVnBFo
 wp4FunMO4VxPSwg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace the existing virtnet_get_rxnfc callback with a dedicated
virtnet_get_rxrings implementation to provide the number of RX rings
directly via the new ethtool_ops get_rx_ring_count pointer.

This simplifies the RX ring count retrieval and aligns virtio_net with
the new ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 975bdc5dab84b..e35b6ef015c05 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5610,20 +5610,11 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	return 0;
 }
 
-static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int rc = 0;
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = vi->curr_queue_pairs;
-		break;
-	default:
-		rc = -EOPNOTSUPP;
-	}
-
-	return rc;
+	return vi->curr_queue_pairs;
 }
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
@@ -5651,7 +5642,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.set_rxfh = virtnet_set_rxfh,
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
-	.get_rxnfc = virtnet_get_rxnfc,
+	.get_rx_ring_count = virtnet_get_rx_ring_count,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,

-- 
2.47.3


