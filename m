Return-Path: <netdev+bounces-66067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587D583D203
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 02:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B616928EB80
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 01:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771934416;
	Fri, 26 Jan 2024 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="dRLuWRH0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA19610E9
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 01:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232244; cv=none; b=XRyi+c2HgftLJPO9m5xv4CTmYG3N+pDi0qNzy1AmKuBrNxcon09BgJcFJ44kmTomFZqLu2N75krS3O2c4331th7Z+60iAMnpmD7EAA5Dke1C3tE9zyI3P4m79R/6sRULVaZHff7wzcyL50dI7GGlyBxnF3HTqlMrqBw0TQMEqjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232244; c=relaxed/simple;
	bh=0dEbDzAhv1TUAkHSGAvsgLdeAUMn6bqVB7CmvYmsqUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bm96aBu5Zf4Ui7jBfxsbe76LIdK5bLuPvNDPmypw5rXTCCej8G9eJMjdHC142J7SZyE8MpMXkWrmjcSOLOvzJr2mc/moOcnzve6ASiG2yg8/QMS9nSKH3sCq0ry1RAM6Ej0u7fzRxkwrFM6R4Yh60R1i+QOw0CvXwdUBo/mzLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=dRLuWRH0; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd7c15a745so49486b6e.2
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 17:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706232242; x=1706837042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85fyyKTHxy6LvDMpMXtf8guHa2fdoQiZVPwGGnMfL70=;
        b=dRLuWRH0qsnQG1w87ntdOQ+xiGSHTNwBezaOkgb9QtVnGue0VpyOmpVEZCk/YDNQEm
         X15hToofRo15a93yf7xUkWbAeFCQk8KfMRzKnwdesMTYIfU2BWS3dhMAiA9BluUA1C9c
         IzNEJeOHJHaoI8UXIH5t9A5mqTAiW4JyMHKPD9VdApblIsj59+IShYK3w69UvdjNcoi5
         5eUQH4FvwnOmo3vopMpLcUnHhBd5Ly02Pi+w2f2W+GfRd7rVIilbbrx+hoeXt5RCT1En
         I1M9iTbYvVvckynjAKotmRZZvyc/FB//kXtgc6PsqZnbviO8g7Mp9wuoaVkp9An7BKgC
         vw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706232242; x=1706837042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85fyyKTHxy6LvDMpMXtf8guHa2fdoQiZVPwGGnMfL70=;
        b=Zo90IDXPy3rGrVCCUS8oVOL9M8oVf0X22D7eNsvm8QOeL+FcSS3BONFOopFpC2zBOI
         96KlmKKe/7X94V7bfhQCsP8GH9DD38lBWjWsqr6Z33+rNHqP9J2J4WebU91eziuhjl8O
         n7PdNkY1C8pi/Hm12PgzMD/E2IL96wr1ct076Ab5s43l7MrKtDELTtQEeNrovHKl/lF5
         YznKm7sweOIxUnyPZp5xEIrRNcrqiMmHisoxWLdz6IKRu6xSTeWre02PHvCZCWdwqyKW
         Pzc3WrF54FNd57DBh9Lntv+PGruEzqMfH8r4H0QZ7Nch+aarcYzemEmlaxHZlAYJ53o9
         8r4A==
X-Gm-Message-State: AOJu0YzM2Z/NItdKYn85oVDwXa1RWlzW92SgMlDjAogeI9ElmdjN6hj/
	EluBRT9N9h/dJwE19ZwhPK+0yvT3lf+0YwRy5XtVi3lkLf1420NrR4Bu8gpuUvk=
X-Google-Smtp-Source: AGHT+IFCo5SjhiHa2lT+gQo5jz9r2WPt435kfZKoZh1Kg+P+KG6X0Fb+RuoEO26EW5dS1CYQis7iJg==
X-Received: by 2002:a05:6808:6545:b0:3bd:a590:8a00 with SMTP id fn5-20020a056808654500b003bda5908a00mr671597oib.85.1706232241869;
        Thu, 25 Jan 2024 17:24:01 -0800 (PST)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id q21-20020a62e115000000b006ddd22b79f6sm152247pfh.120.2024.01.25.17.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 17:24:01 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v6 2/4] netdevsim: forward skbs from one connected port to another
Date: Thu, 25 Jan 2024 17:23:55 -0800
Message-Id: <20240126012357.535494-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240126012357.535494-1-dw@davidwei.uk>
References: <20240126012357.535494-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forward skbs sent from one netdevsim port to its connected netdevsim
port using dev_forward_skb, in a spirit similar to veth.

Add a tx_dropped variable to struct netdevsim, tracking the number of
skbs that could not be forwarded using dev_forward_skb().

The xmit() function accessing the peer ptr is protected by an RCU read
critical section. The rcu_read_lock() is functionally redundant as since
v5.0 all softirqs are implicitly RCU read critical sections; but it is
useful for human readers.

If another CPU is concurrently in nsim_destroy(), then it will first set
the peer ptr to NULL. This does not affect any existing readers that
dereferenced a non-NULL peer. Then, in unregister_netdevice(), there is
a synchronize_rcu() before the netdev is actually unregistered and
freed. This ensures that any readers i.e. xmit() that got a non-NULL
peer will complete before the netdev is freed.

Any readers after the RCU_INIT_POINTER() but before synchronize_rcu()
will dereference NULL, making it safe.

The codepath to nsim_destroy() and nsim_create() takes rtnl_lock, making
it safe with concurrent calls to linking two netdevsims together.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/netdev.c    | 24 ++++++++++++++++++++----
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 969248ffeca8..978c34334018 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -29,19 +29,35 @@
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct netdevsim *peer_ns;
+	unsigned int len = skb->len;
+	int ret = NETDEV_TX_OK;
 
 	if (!nsim_ipsec_tx(ns, skb))
 		goto out;
 
+	rcu_read_lock();
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns)
+		goto out_stats;
+
+	skb_tx_timestamp(skb);
+	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
+		ret = NET_XMIT_DROP;
+
+out_stats:
+	rcu_read_unlock();
 	u64_stats_update_begin(&ns->syncp);
 	ns->tx_packets++;
-	ns->tx_bytes += skb->len;
+	ns->tx_bytes += len;
+	if (ret == NET_XMIT_DROP)
+		ns->tx_dropped++;
 	u64_stats_update_end(&ns->syncp);
+	return ret;
 
 out:
 	dev_kfree_skb(skb);
-
-	return NETDEV_TX_OK;
+	return ret;
 }
 
 static void nsim_set_rx_mode(struct net_device *dev)
@@ -70,6 +86,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		start = u64_stats_fetch_begin(&ns->syncp);
 		stats->tx_bytes = ns->tx_bytes;
 		stats->tx_packets = ns->tx_packets;
+		stats->tx_dropped = ns->tx_dropped;
 	} while (u64_stats_fetch_retry(&ns->syncp, start));
 }
 
@@ -302,7 +319,6 @@ static void nsim_setup(struct net_device *dev)
 	eth_hw_addr_random(dev);
 
 	dev->tx_queue_len = 0;
-	dev->flags |= IFF_NOARP;
 	dev->flags &= ~IFF_MULTICAST;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
 			   IFF_NO_QUEUE;
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index c8b45b0d955e..553c4b9b4f63 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -98,6 +98,7 @@ struct netdevsim {
 
 	u64 tx_packets;
 	u64 tx_bytes;
+	u64 tx_dropped;
 	struct u64_stats_sync syncp;
 
 	struct nsim_bus_dev *nsim_bus_dev;
-- 
2.39.3


