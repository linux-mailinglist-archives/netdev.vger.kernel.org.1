Return-Path: <netdev+bounces-61607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBBD82464D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4ACD1C220E2
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544F924B31;
	Thu,  4 Jan 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAd11jz3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9931250E8
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdb5c2b1beso717017276.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 08:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704386195; x=1704990995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wg5CCp6THbBknTnS/4xF57GTxChOMOipU2hBpvXhl48=;
        b=mAd11jz3f+lB2AHbe81uEIjt+fMm957LKj4n/vLJ0s0AzVRdbwrpKhifYkYNe0HkZW
         19ySCWwwbDjnkXslcCsgIrJ5NGJ+0fiYktEV/bwxdt+T6AYj92tk9yt0X/d9QACcxNS/
         rROVcYwDwrRytIG9Y2XsKfj/6Zkhdcri8OyshQrLbsuHeTAAOkjST8p6Y4jdx0cJ/anU
         TX2oBB5Za5QyyxBI2AfacZO4zGaSyR4qTN9qGo6bEXHOm1oX7qaa7EYSjvj6+BT1d1mJ
         rZZSSxV0X3XVsf5QjsKLbv7NTYtQfZwdXHi5SGx0TCDnfP/Se4iEdMJKMTfOKD6tiBO5
         cqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386195; x=1704990995;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg5CCp6THbBknTnS/4xF57GTxChOMOipU2hBpvXhl48=;
        b=IAX5nW1GXpt2LvABshZyTRhLsyu7+wgin1j/wRLbdWlzC7iHsBLc00EBKZvI0F/WWI
         fsJZpL3dvZVAE6jMHiaTLdWjuriD1UtyAd5sNHUeRIny6oRQ3fxxysuzbBCWcc1ytkXk
         X9Ro3uUh7iUM3iYgFdp1ZYG5QfOY4/UddjRR0OdHbzrp5fHTclfQkI3LMnhdAXNyKmIu
         fiK0AWH6nuH2a4HnLeU/fHLjpJwEoU4DDeEnRWG00sO+aYkN70uS95kILvOQpNHo8dyf
         o+WJi4hm4mXzcsQccjhDbFV02G9k1DG9eCt9w1bp8b34aUgIDpF2Kj6f4ZYSHRStE7FQ
         kq3g==
X-Gm-Message-State: AOJu0Yw7YPadW4xN98zGfRVDQli+WimVOytS1voBBdvKQuvk0SGY5Tt/
	uMwsv2Vadph/y7/HnMlnp2ta8j6cqTNXuS3PlvmQ
X-Google-Smtp-Source: AGHT+IErZ0gSt8+2c40m9m/ZBwu0oXirpt1MMlKv90ATGBbZeceeZmq5wkboezjB0z0+UjR0B+d6DA1VvXroeQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:6809:0:b0:dbd:c33f:4642 with SMTP id
 d9-20020a256809000000b00dbdc33f4642mr274894ybc.3.1704386194760; Thu, 04 Jan
 2024 08:36:34 -0800 (PST)
Date: Thu,  4 Jan 2024 16:36:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240104163633.2070538-1-edumazet@google.com>
Subject: [PATCH net-next] geneve: use DEV_STATS_INC()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

geneve updates dev->stats fields locklessly.

Adopt DEV_STATS_INC() to avoid races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/geneve.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index acd9c615d1f4f78cce348dbd42541de241ca8180..32c51c244153bd760b9f58001906c04c8b0f37ff 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -234,7 +234,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 					 vni_to_tunnel_id(gnvh->vni),
 					 gnvh->opt_len * 4);
 		if (!tun_dst) {
-			geneve->dev->stats.rx_dropped++;
+			DEV_STATS_INC(geneve->dev, rx_dropped);
 			goto drop;
 		}
 		/* Update tunnel dst according to Geneve options. */
@@ -246,8 +246,8 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 		 * since we don't support any...
 		 */
 		if (gnvh->critical) {
-			geneve->dev->stats.rx_frame_errors++;
-			geneve->dev->stats.rx_errors++;
+			DEV_STATS_INC(geneve->dev, rx_frame_errors);
+			DEV_STATS_INC(geneve->dev, rx_errors);
 			goto drop;
 		}
 	}
@@ -263,7 +263,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 		/* Ignore packet loops (and multicast echo) */
 		if (ether_addr_equal(eth_hdr(skb)->h_source,
 				     geneve->dev->dev_addr)) {
-			geneve->dev->stats.rx_errors++;
+			DEV_STATS_INC(geneve->dev, rx_errors);
 			goto drop;
 		}
 	} else {
@@ -296,8 +296,8 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 #endif
 		}
 		if (err > 1) {
-			++geneve->dev->stats.rx_frame_errors;
-			++geneve->dev->stats.rx_errors;
+			DEV_STATS_INC(geneve->dev, rx_frame_errors);
+			DEV_STATS_INC(geneve->dev, rx_errors);
 			goto drop;
 		}
 	}
@@ -377,14 +377,14 @@ static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely((!geneve->cfg.inner_proto_inherit &&
 		      inner_proto != htons(ETH_P_TEB)))) {
-		geneve->dev->stats.rx_dropped++;
+		DEV_STATS_INC(geneve->dev, rx_dropped);
 		goto drop;
 	}
 
 	opts_len = geneveh->opt_len * 4;
 	if (iptunnel_pull_header(skb, GENEVE_BASE_HLEN + opts_len, inner_proto,
 				 !net_eq(geneve->net, dev_net(geneve->dev)))) {
-		geneve->dev->stats.rx_dropped++;
+		DEV_STATS_INC(geneve->dev, rx_dropped);
 		goto drop;
 	}
 
@@ -1007,7 +1007,7 @@ static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (unlikely(!info || !(info->mode & IP_TUNNEL_INFO_TX))) {
 			netdev_dbg(dev, "no tunnel metadata\n");
 			dev_kfree_skb(skb);
-			dev->stats.tx_dropped++;
+			DEV_STATS_INC(dev, tx_dropped);
 			return NETDEV_TX_OK;
 		}
 	} else {
@@ -1030,11 +1030,11 @@ static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *dev)
 		dev_kfree_skb(skb);
 
 	if (err == -ELOOP)
-		dev->stats.collisions++;
+		DEV_STATS_INC(dev, collisions);
 	else if (err == -ENETUNREACH)
-		dev->stats.tx_carrier_errors++;
+		DEV_STATS_INC(dev, tx_carrier_errors);
 
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	return NETDEV_TX_OK;
 }
 
-- 
2.43.0.472.g3155946c3a-goog


