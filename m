Return-Path: <netdev+bounces-180475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99D9A816D9
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B85C3AC4CD
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0062528E9;
	Tue,  8 Apr 2025 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJzz7Sro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35247244195
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744144069; cv=none; b=YGE0OkxyDsPX/Y8lUk4I83BqGN5W5SKAlDNpQVL0SP6rI7w+a0jdZ2+Ums7VsdVLzsa7SmJPM8rIHfccCKjO8jbhWLgndSU1SLXAN2GN6rkehjR4NZOkynXbPGmmhkttSpo1zId88GxB84Q2pT/LJlMKz6e1HG9SnR8ipLB9mTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744144069; c=relaxed/simple;
	bh=qZgABreuvQIsetdsWRpO+ez5x3ZbCGHktQxtFzLbKzM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BxBGIHcvKq+svkMWL/vaTlYGAj1AFGfad7CweeZTRgvSVtO8Ad+JogApEU5/Df34Bvhhh10Bip8HitDbXk5MF0FWx7K11eOCnOvYn81TjwpqaGKiEB+cn6qxhnu1iXUAhGZoqK1vneMBfA0Fji3jdaSV6yhTGN2Ttm7DsytMQYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJzz7Sro; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e91a184588so177275816d6.2
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744144067; x=1744748867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ObztBV5Yi4ZXehN6mjOmpxvnHijoXGi0BfPBHgq47Q0=;
        b=bJzz7Sro7Gmd24ZSQDEOGFoeOhCLKMewEod9niOz5JUfqEWqGbVAqTKl70AyBaivMx
         nVLl+8rs6ZCLeUnSU2j0rnAMr+CFus0P4K53FYmG8gBqEhi7oscxurSKN43CYaaPeIuV
         RpfxYdqrNG8dF5Ob5xKHLAqAmgOiMTkauDrR675/uG4ZgAv9aI39XvlWlvc+0PF6RbCs
         qz9DP+dE0tbVSWqU8RusbSi/CLuy82bMkJCGn2bpg7vXX8MGQNODWKdF8JWIEe3Aduf/
         oV+NSzJpRl6xes3tij7zlQrTEZjgrsLKWVqdbuO5+yua6S4cq/Mumk5G2uauagdNGUEb
         G+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744144067; x=1744748867;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObztBV5Yi4ZXehN6mjOmpxvnHijoXGi0BfPBHgq47Q0=;
        b=q9Sr608Xsh4HTthjD57aDj+8NLk1Y/3a/+wOgX71CXFGph0VZZiFtPEv5Nu3AQu0ul
         ogdmo9znH3XFaU76Ot+eA81OlpYoHvFn7qMsfELXHVUHQzR3xNCBun8vgD66KRSHZfNI
         Vv+v2hyE8IRIeeQn3uwRTkdwfgc2lXGQUWU/EJDt5ThDusjUVKNj+i0bAw165Uxz8s4R
         6UFSXE+l4Y3eb7ZczDIv04jO/O9zJ94LV2MOIhZ3vK5lVTxZSoHg5aUa4hjrt7acL7Fy
         Sj2SzktcTInq5wcRfrVC7a/y176Ea2MYIwxwknmdmpvBHPAibstin2Cfp2v1BbKBr8oo
         hb1A==
X-Forwarded-Encrypted: i=1; AJvYcCX7hdaGXrqpA6dgVgtadF7XXFGoEl4HmoF4RJmzfgf7LMWnyhXSobkZxflJjKouUZGncufKvVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJJ83AQkrqv0vJVg4peMy4ADo2ugr25onChova8WSNcm/d5n1
	Fvkp3jBB4cZn5+b6/aWrrX2UmKEdDCvXDLDF5kfiHUh4UX5AQTWJf8K7PrW/UQjM2PGFHb8uNMk
	EDPT6rnd6/w==
X-Google-Smtp-Source: AGHT+IHw4CoGHECamELU4fnKeNJCcL80CjewmcweZC6MAX617W6Ee02DSvXqO1JQt/xmct+mFuH0rKMPa+B59A==
X-Received: from qvb1.prod.google.com ([2002:a05:6214:6001:b0:6eb:2b16:6854])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1c81:b0:6e8:9021:9090 with SMTP id 6a1803df08f44-6f0dbc11248mr8324856d6.26.1744144067053;
 Tue, 08 Apr 2025 13:27:47 -0700 (PDT)
Date: Tue,  8 Apr 2025 20:27:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408202742.2145516-1-edumazet@google.com>
Subject: [PATCH net-next] net: remove cpu stall in txq_trans_update()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

txq_trans_update() currently uses txq->xmit_lock_owner
to conditionally update txq->trans_start.

For regular devices, txq->xmit_lock_owner is updated
from HARD_TX_LOCK() and HARD_TX_UNLOCK(), and this apparently
causes cpu stalls.

Using dev->lltx, which sits in a read-mostly cache-line,
and already used in HARD_TX_LOCK() and HARD_TX_UNLOCK()
helps cpu prediction.

On an AMD EPYC 7B12 dual socket server, tcp_rr with 128 threads
and 30,000 flows gets a 5 % increase in throughput.

As explained in commit 95ecba62e2fd ("net: fix races in
netdev_tx_sent_queue()/dev_watchdog()") I am planning
to no longer update txq->trans_start in the fast path
in a followup patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 include/linux/netdevice.h                | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index c9fd34787c9986946c06e3d8d9de693c4438ab6a..e78de79a5d78c2e673809841e5c6d2dc35c754a1 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -427,7 +427,7 @@ static void am65_cpsw_nuss_ndo_host_tx_timeout(struct net_device *ndev,
 
 	if (netif_tx_queue_stopped(netif_txq)) {
 		/* try recover if stopped by us */
-		txq_trans_update(netif_txq);
+		txq_trans_update(ndev, netif_txq);
 		netif_tx_wake_queue(netif_txq);
 	}
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf3b6445817bb9d3a142da10549ade1c49659313..0b703f0aa2043e537b7f74a4532f89f1f2890b08 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4688,9 +4688,10 @@ static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)
 /*
  * txq->trans_start can be read locklessly from dev_watchdog()
  */
-static inline void txq_trans_update(struct netdev_queue *txq)
+static inline void txq_trans_update(const struct net_device *dev,
+				    struct netdev_queue *txq)
 {
-	if (txq->xmit_lock_owner != -1)
+	if (!dev->lltx)
 		WRITE_ONCE(txq->trans_start, jiffies);
 }
 
@@ -5209,7 +5210,7 @@ static inline netdev_tx_t netdev_start_xmit(struct sk_buff *skb, struct net_devi
 
 	rc = __netdev_start_xmit(ops, skb, dev, more);
 	if (rc == NETDEV_TX_OK)
-		txq_trans_update(txq);
+		txq_trans_update(dev, txq);
 
 	return rc;
 }
-- 
2.49.0.504.g3bcea36a83-goog


