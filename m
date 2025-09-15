Return-Path: <netdev+bounces-222998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3EDB5771D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E62B4E1BD2
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D7D304BB6;
	Mon, 15 Sep 2025 10:47:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544D303CBE
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933274; cv=none; b=J4elGXX2AdLLMvjF86KI4akrkmBD2XOh5MyO3BCxSz/+vegjXaf3JAxMzlGcKU/Gs+jcYXjSbBGbLgHTug+j5nc/xfrNAp+dRK+1aFA6LtWqKiRA4P3498Hoy+KtcrV4l4qWLYNJvHbxvbOtRW9diboXEIWlLWgiesGfKNbnA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933274; c=relaxed/simple;
	bh=XORibMK+HoTqfv4y9FVPPOq9ONbLbN3AR+BVl4Gb9Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9epZEK61aZ2KvXcIoGJ+ykOHkGDFITOxSwa0MuDhbT6avrpPTd7f1l8ZVa12cXMldv3pqf9DFtF3tFAtolnyQRDh2ZBInWLURJyOBzV23t2BaHulnbAtwF0aY7FekksqtP4fe/N/NdNCYjpjn9ntvW0uka/zfJGemLIDRH8XpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07e081d852so330629766b.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933271; x=1758538071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEFtILFHyV3cwaZ5irPCMUES0101pMsbpssc+ihdXEQ=;
        b=jwfjdmarh1FXTw21lQWpSCLNDPbs/On/iHg8xVdpJdERh50E77PNkrb/Ht4Z754gZs
         DmEoCGhCnONGwnr3Pc1qXZ//1Lo3XSTeGbuJr1NSfN9TAKLQJJ4hdxSrRfAW6NzedJZk
         wjEiq73eJqx1cuZfzl7xbHUTXSdOtbIEjEswRF3h2ZwOc9vfZMMR93Qau+sTToXSiD4R
         oqGl8LdHkJMEsH3JQJaIHZxew2gOoc5AouGzcQMdCnzysiBSH0izXz3NOJu//i/6t4dX
         69Sk3lR7DmVeU9Ad9FejQPWVrXcN0Df5zASA+FiEmkhuQaQHDU2GssCmBpnSFJa5aA6z
         5qJA==
X-Gm-Message-State: AOJu0YyO+/2zXEUkW1HzIlNQlTD8TJ6mdo4QVKne/P9BsOiBOd8C7RUM
	qTZtEVfDHoXMc+YXU0oCBTjdBFs5GVNACc791fNp7HV5/E+P4uegCuLA
X-Gm-Gg: ASbGncvkkKti/ZiRSXD5Q0z8cUGKPE0L2l4M225kbWZPn4nK8wCeem7goZpw/Eem0PH
	QhB9n9nPkAAyHyCp97X764nlcI9oWVa3B8AWgAEQuX5G6NVfzAfZwZ8UJDzBjHQbcRB8W+7g3+O
	AqjEnwmbfcRRdL9E4OJD+ZrI3XThsas/CdiVh9KgSqbmD/Fg3JGAEGKhf58Pzb4UuwH90tmJYYl
	meKTv0BQ9jEb4vx84T3rawEkElWjq6X/f4k3nAejbYImz0iGkJnPAvhp7EpsBfxIARGdu/VL48p
	9Ryh1Fprv25i9tnQJk70zH2pxDatC21LROf1BxgMPikiaJc+gObLloeypwkgSKMWZx00ZLjSxwH
	x3w5+J7tw2AqENYXbPnuJINI=
X-Google-Smtp-Source: AGHT+IF5+uiN5sa5sYRSXuXbbs7oJKleowLHu5cpGTRmFx/VXRwFkx7z/RvBypC9//fYJkMmWRQHyw==
X-Received: by 2002:a17:907:3c8b:b0:b0e:677c:d478 with SMTP id a640c23a62f3a-b0e679b61fbmr501433766b.19.1757933270605;
        Mon, 15 Sep 2025 03:47:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32ef574sm930111766b.73.2025.09.15.03.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:50 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:33 -0700
Subject: [PATCH net-next v3 8/8] net: virtio_net: add get_rxrings ethtool
 callback for RX ring queries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-8-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
In-Reply-To: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
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
 h=from:subject:message-id; bh=XORibMK+HoTqfv4y9FVPPOq9ONbLbN3AR+BVl4Gb9Yg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7Ha+vYd+sWCyL8VwwHbZu51WC2X9xdaW/wJ
 Jlp8e8BwJiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bVefEACYQzpDuHMK20qeGjvp9xI3L0p/CK3fhZQXXd0c2kdIerKJ7wW0ynIb4MkeF/NbJVeUgtK
 i22XWn/sWXXXTAm6+QHRBuzWb5AMhnwhPh5Mm0LSzf7vDDnNkQvv52UaI1uJuSQL0z8r4p7+e6s
 MWz79OSuL5KBLydsizzRc7IHcCtyipRjHOqGUaTDvYeaGQCovdF3b374+JyQaRifsTSZwecODft
 74HzX/lqOgp1PYvKWx251NQb2/HaXuMn8zJZuphVmikSeels7/+fDO1rm0jmIE2TptULnr8TfV2
 5gev9QSzwNG328eoo/oGFDP7vArQXiOJGjO8je+72OxvS+sXGH0s0YbdJhWSJOGYzegGqdzSOhZ
 +IlTmVzEz/AVmXQB2U97x6KuO11tezqqo5cvesMUfsH0rITk/o/mqfG7S31HfslBqdXlMrnPrwm
 AUjJPy1qQvV0RaJNTTboG0MNmOLfixX9E80VMFLAzlaLjeo7/FhiW2GokTGHARWIf3O4gmJ0UKh
 liJ97wftD3EEHnVdyTISbTqMfblm2jQBHomHBOT1129cO98D/sQEoz/1+i3YiIGmG3BzkMAZzsn
 zljywNgv+N5AS1UqmhXTwGF/8nGte7fsz7wEIRkFs4bkwEJBzFlfGJyNFLdBdIs1kYY0Zw1/t9h
 IOVI/rg3jXoSZWw==
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
index 06708c9a979e6..7da5a37917e92 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5609,20 +5609,11 @@ static int virtnet_set_rxfh(struct net_device *dev,
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
@@ -5650,7 +5641,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.set_rxfh = virtnet_set_rxfh,
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
-	.get_rxnfc = virtnet_get_rxnfc,
+	.get_rx_ring_count = virtnet_get_rx_ring_count,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,

-- 
2.47.3


