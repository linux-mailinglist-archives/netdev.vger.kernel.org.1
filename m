Return-Path: <netdev+bounces-67351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7031B842EC5
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 22:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E42288C95
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4CB78B7B;
	Tue, 30 Jan 2024 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="UEglOstB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5478B64
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651186; cv=none; b=NUkyM+rNXa2FsibFljYaSJobP7LQo9A7GPYD2zTYYciEqagFAmSGrvFUfjMtkVN0/w8KjVggFEAcIum0FWU27qrmmf215osvpSKYVDshYnReh1pjt8k0TGT+Gj8bXgfV9dj7cOsQG2+c9cGZ/DWXHaCllmApNuseEZEG1ILzn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651186; c=relaxed/simple;
	bh=h51+PMqZFUSDKkzp81ib67kRObLqTDNvlePciKrb3JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Potlvj01mCeOkxG/Coxvtuhsxe1Un5XSOqhRr+MkgeVdnW4QSn75fNeeaQjj7OeuAnExQUmRxPEa+SUyEye42JwoFxEnQEYJgaBmq0Ui47TKGX/Rwl2YwKABMdW1QRGS3TwTRIkiaH2PKq2mOh6l9xuNLqAO+oW25Cr1trslprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=UEglOstB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so2533936a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706651184; x=1707255984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFu9jZ6gCjRApzlGzx5kepfS3dicxZhx266q2+xXoLY=;
        b=UEglOstBckEyDgvwPqQbCQTP112y5YGEXyJHLxWBWobyCHxUSbPMvMjQ1k4gOJaipy
         tAEs0w4nTv2wsTMCr686op5nyQ6M21J2gJJBvU5mlFUtZn2DKR+jkyb1zRVkWbciT833
         O2ebaBCiPxEUYRCR7CV7pKiJKhNyz39wBLfLf/AGB5Or+xBYc83N8KV9kYCRtxv8jHJl
         RzF5xYQltMw8H0MrF561ATPL9EkBnZwKnvBgYgjfZyiaWsgVZ64Dqmivgijt5tAVDN5t
         Vsp3M7FeOFLxHi9PXdVrswrbc6DfVo3i8QPzkRe63RTkHJgZcd4Plnk1KZP5oXWMvBp6
         ePSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651184; x=1707255984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFu9jZ6gCjRApzlGzx5kepfS3dicxZhx266q2+xXoLY=;
        b=ZV8WeeTbgUFJNU3+DDF5erW3EVX1lLzK0nUSbbcaIQbk9fpHtohPxcuxb1JvA1TZmm
         vRAvPEUP0yFXMpFEIRU4jdGOOzPyvNIwYdGbRylM8jNXZUXzWrqcRy/6AzBmBkDwescx
         RosupGLs5ECDxfl9I2+jZdGqowBX3DqN1NdLyTaLGKpCFymXfwT9NX84PW8J3dt6vglz
         llWJ9eGH8lQH1imz2+2lNJzpcuE9LbES8fuME10ppVoikoZh+UGXc+pstYBX4H+A6+Ik
         gCuqYPqMrsGzpJwIYcQ1mrn2Sv8AiCInHpr0B8kY2ZK7WXgnuLjXf8siZSZefVpZI+Kx
         dcLw==
X-Gm-Message-State: AOJu0YysvgV+Kch2fW+s9rRt/Q+cIA4mY7guyMlK6r8qhWc+VHYYd1UG
	5WIGOrJ6M+yMWjjP/Hrmu7JDaY7wXtU6v/+QK3QmBVO/tG0aHPVEuNutRrqDQHtcqp8eUvAZcP4
	o
X-Google-Smtp-Source: AGHT+IHQCizHs2WqjmUQmbOIag5fWIlf8k5Of3Eq7sH8M9Atk0j5kD4F/ub/7kHHdwtyXRbJNIyekw==
X-Received: by 2002:a05:6a21:394b:b0:19c:9f4e:b122 with SMTP id ac11-20020a056a21394b00b0019c9f4eb122mr6352655pzc.20.1706651184304;
        Tue, 30 Jan 2024 13:46:24 -0800 (PST)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id t19-20020a62d153000000b006dddd685bbesm8686024pfl.122.2024.01.30.13.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:46:24 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v8 2/4] netdevsim: forward skbs from one connected port to another
Date: Tue, 30 Jan 2024 13:46:18 -0800
Message-Id: <20240130214620.3722189-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130214620.3722189-1-dw@davidwei.uk>
References: <20240130214620.3722189-1-dw@davidwei.uk>
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

The codepath to nsim_destroy() and nsim_create() takes both the newly
added nsim_dev_list_lock and rtnl_lock. This makes it safe with
concurrent calls to linking two netdevsims together.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/netdev.c    | 28 +++++++++++++++++++++++-----
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 57883773e4fb..fd6bf789ff70 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -29,19 +29,37 @@
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	unsigned int len = skb->len;
+	struct netdevsim *peer_ns;
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
-	ns->tx_packets++;
-	ns->tx_bytes += skb->len;
+	if (ret == NET_XMIT_DROP) {
+		ns->tx_dropped++;
+	} else {
+		ns->tx_packets++;
+		ns->tx_bytes += len;
+	}
 	u64_stats_update_end(&ns->syncp);
+	return ret;
 
 out:
 	dev_kfree_skb(skb);
-
-	return NETDEV_TX_OK;
+	return ret;
 }
 
 static void nsim_set_rx_mode(struct net_device *dev)
@@ -70,6 +88,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		start = u64_stats_fetch_begin(&ns->syncp);
 		stats->tx_bytes = ns->tx_bytes;
 		stats->tx_packets = ns->tx_packets;
+		stats->tx_dropped = ns->tx_dropped;
 	} while (u64_stats_fetch_retry(&ns->syncp, start));
 }
 
@@ -302,7 +321,6 @@ static void nsim_setup(struct net_device *dev)
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


