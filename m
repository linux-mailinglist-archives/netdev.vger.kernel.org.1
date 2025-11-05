Return-Path: <netdev+bounces-235934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BADC374A8
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 19:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FEE24E550C
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D831B290D81;
	Wed,  5 Nov 2025 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MysywdKE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDEE286881
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367183; cv=none; b=rQILIbegQN2x3FBESBt2VoIoBkCS1ycAbaOotI+2DdMIRbmgvj2YHa/Xbw8yMFAq3kDmpMPFDlJKWJ2HyiBSOoihtcCWDxcNcxo30jS4axspKLkBTf7YgSV285FVdddj1hOzEjTchpBxVNy0L43Z6gYXRucONvZrsV6gJHLljQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367183; c=relaxed/simple;
	bh=rJGRHWAw0edvIBlzvTnGcUWjgsNkrWVvco4sn4GFUuM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=giIMzWIYuUqT/clA75dbHym8EAjaNFPkgHCS6awt/D586oPn5AwHGHKy1F0NUIRTc3oYUVD3fpjex0GsMjyA+r4hbUKptLbew8RS9BUbVmiGGyZDuXfy+MoHV95x8tAIfZVLdHtJwk2dYX5hqNHo5vMWbA8m879majnWFzxBh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MysywdKE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7aee84f1defso189999b3a.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 10:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762367180; x=1762971980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PHiMaZBRjUMMIyxTQ9TaBFQC4zXrsr5pfK2PGieJdE0=;
        b=MysywdKE+zD+D5ah9nRHBWwbFrSgodhyeX3q23Z8RiGT/T56LR61za7Xk8Ylr8hQEC
         BsvRaqmUXroA0wBzG4Mg8crCu8AYWfa9iT3c4bHKJ4IsTy/dczL5CfZp2FM9qjAqo+i7
         u9KpRzAZ6nB9R1rpKDHHxidYNL7qNMs9yFfiyu3u2Jkl/Zb0MXfsAgHeAgavKXE+XgY8
         UdlTx1q/vuggHin62bQXGMRYJZPzTZuNzC3kNHiClTIOEAhV8jCCv5lklch8XP1kQMJ0
         V1Jc+sWPVyuXhQ1TdTU7edDNbOs9fR0mN0273J/nLed3pqnKYWacI9x3bS+O0b0RpK2p
         bcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367180; x=1762971980;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHiMaZBRjUMMIyxTQ9TaBFQC4zXrsr5pfK2PGieJdE0=;
        b=GZtlCm7ajIgd8O1sJ7yDqDft11xnMUhfTq68tHAn6zMrzHLqP6KbHsaetQQjD6V5Eh
         YNE2F9y2ji7ZZpYyAcgd4/VTiT7zT94V6blwyYqdRHcPZznQp+J/GT+rss9FSv679oaX
         97RJ+FJtjpAzEK0Ix5wwc0bozx/QMBCeEXGF5W9zYTzqlrKShRJf6TRUobcVa8neAMDn
         mSQaEZyxBHqdrcxr4X+dZPz4WtaEvnuZVW87DO4sjKnqzKrPl6P2/f3BI4E2+NKbpuiR
         NAQ+A9OSxF4bCjC7t0amhqHtfr1tZdqZ8SAy7jmMdgOQT9e1cNl5lWVaWh/tFcd8yKru
         oXvw==
X-Gm-Message-State: AOJu0YzrMnakFCzpYqfgMXuJwcH+JB5OkuyoF8GWhIsb78QkY/KNKcqZ
	ojgUualaiIRZxP0HNkfwhoH79+s3eSiVahFDSzg3PogA8iYnDbTCoexD+Op6uXGpGVLHRrJJMAg
	lLmBwREM/QNbgdDbss49Gg689F2a1XpVa1sFf+q+VFj8GJbO8mEput/jIuY/EAgyRxtfHNA1ShW
	+E2+wsWzoGUCjzunLJxq9lLvlBIRCBmyYVYaPBfBJzw4rVmpY=
X-Google-Smtp-Source: AGHT+IGNYglFYgW+bVTIh5WVRFflW9Jw5wpKJDLjpiHSo42rh4qRDkZuA4zTmY17JUG9ucBfb4FoyAQma9UFWQ==
X-Received: from pfef14.prod.google.com ([2002:a05:6a00:228e:b0:7ae:55f2:2f4a])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d10:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-7ae1fc7d8b0mr5726508b3a.32.1762367180312;
 Wed, 05 Nov 2025 10:26:20 -0800 (PST)
Date: Wed,  5 Nov 2025 10:26:01 -0800
In-Reply-To: <20251105182603.1223474-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251105182603.1223474-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251105182603.1223474-3-joshwash@google.com>
Subject: [PATCH net-next v2 2/4] gve: Use extack to log xdp config
 verification errors
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	John Fraker <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit Garg <nktgrg@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Plumb extack as it allows us to send more detailed error messages back
and append 'gve' suffix to method name per convention.

NL_SET_ERR_MSG_FMT_MOD doesn't support format string longer than 80
chars so keeping netdev warning with actual queue count details.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v2:
* Add this patch to the series for RX buffer length management
  (Jakub Kicinski)
---
 drivers/net/ethernet/google/gve/gve_main.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 453e40a..c1d9916 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1707,18 +1707,21 @@ static int gve_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 	return 0;
 }
 
-static int verify_xdp_configuration(struct net_device *dev)
+static int gve_verify_xdp_configuration(struct net_device *dev,
+					struct netlink_ext_ack *extack)
 {
 	struct gve_priv *priv = netdev_priv(dev);
 	u16 max_xdp_mtu;
 
 	if (dev->features & NETIF_F_LRO) {
-		netdev_warn(dev, "XDP is not supported when LRO is on.\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "XDP is not supported when LRO is on.\n");
 		return -EOPNOTSUPP;
 	}
 
 	if (priv->header_split_enabled) {
-		netdev_warn(dev, "XDP is not supported when header-data split is enabled.\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "XDP is not supported when header-data split is enabled.\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -1727,17 +1730,20 @@ static int verify_xdp_configuration(struct net_device *dev)
 		max_xdp_mtu -= GVE_RX_PAD;
 
 	if (dev->mtu > max_xdp_mtu) {
-		netdev_warn(dev, "XDP is not supported for mtu %d.\n",
-			    dev->mtu);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "XDP is not supported for mtu %d.\n",
+				       dev->mtu);
 		return -EOPNOTSUPP;
 	}
 
 	if (priv->rx_cfg.num_queues != priv->tx_cfg.num_queues ||
 	    (2 * priv->tx_cfg.num_queues > priv->tx_cfg.max_queues)) {
-		netdev_warn(dev, "XDP load failed: The number of configured RX queues %d should be equal to the number of configured TX queues %d and the number of configured RX/TX queues should be less than or equal to half the maximum number of RX/TX queues %d",
-			    priv->rx_cfg.num_queues,
-			    priv->tx_cfg.num_queues,
+		netdev_warn(dev,
+			    "XDP load failed: The number of configured RX queues %d should be equal to the number of configured TX queues %d and the number of configured RX/TX queues should be less than or equal to half the maximum number of RX/TX queues %d",
+			    priv->rx_cfg.num_queues, priv->tx_cfg.num_queues,
 			    priv->tx_cfg.max_queues);
+		NL_SET_ERR_MSG_MOD(extack,
+				   "XDP load failed: The number of configured RX queues should be equal to the number of configured TX queues and the number of configured RX/TX queues should be less than or equal to half the maximum number of RX/TX queues");
 		return -EINVAL;
 	}
 	return 0;
@@ -1748,7 +1754,7 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
-	err = verify_xdp_configuration(dev);
+	err = gve_verify_xdp_configuration(dev, xdp->extack);
 	if (err)
 		return err;
 	switch (xdp->command) {
-- 
2.51.2.997.g839fc31de9-goog


