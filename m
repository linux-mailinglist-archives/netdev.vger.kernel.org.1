Return-Path: <netdev+bounces-55582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCE580B841
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 02:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF092B20AB4
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 01:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59C41369;
	Sun, 10 Dec 2023 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="2LaqxtRT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C910B
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 17:04:55 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35f3e4ce411so6587475ab.0
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 17:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702170294; x=1702775094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA4d9nyIn2ziQ9SblDQqTiSyrr25pUtyIEL1aLjRQfs=;
        b=2LaqxtRTco/B3qw9aRu73MzmWtMLfNoafZAzDK0ugGuyRxQLJrUDUVfpgpvU9r0y+C
         uUaD8R7D4iddnWqxR+Wz6r0JhQXEtfrJmbKgyPqVex+W69PouV7mH8h+Bh717OZb658t
         wliA8Svxsk5djGMihQceD41FNWAbMiysVXIC/+VFTnkHua6M4+0q5BKkvfAySHDsq+5H
         MmjX9LMi/G35Cue8NsGR0G2NmyGtarADsEWnCeNXdBWWLp6e10Hb/rZygP+5MSbR8LLK
         a03Yb6AVcxZF117LcHZouj2w/b2PSr6965Ox6zO9jdhFxOPrVys9baDVj/n1TbGU5E+F
         SYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702170294; x=1702775094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA4d9nyIn2ziQ9SblDQqTiSyrr25pUtyIEL1aLjRQfs=;
        b=WNdUV+TS1DzmGpAGzUmx+7wIhjqgcpkFVtN12baYojnqFVZAlPsV+KX8eESmJh1Y+x
         sDXpmVLl9OLOZNDlP/7AILhB+xffH8aL2WpBqwApqAr0DldEydreukx9drN7mHDPLLta
         vbqAWm3rNc2hYCpWR0lVq3UNPEriPql4cjXAk2Kw+sZj/C516dbBrvfwb+cKODU2D55j
         1hyPYCWvOmr7NsFHdkHPAnYxrHbgRpAsCPK60NpWhpf3yTrS/H5zTcS5/SwnBQuLp9L0
         H6cjc03ty89HU42J5s6JTiEHAHoGZHdKgaQZ6u6cXeZVDqdd/K8jG9pEMi5MzXvzEWTv
         G/PA==
X-Gm-Message-State: AOJu0YzHrLEFKbZEn3NsvjcSaFbfGYvFVMF7Mx9anSjBTGMTajDAXT4M
	HCwo6zo0zKLXz25BhDlZZGANEQ==
X-Google-Smtp-Source: AGHT+IGvVpM1zUIMlGm6ma9K+TKgNJGbud5iDdTA+ps7uKsYaldBJF05SmLrBzVnwfKTSxlPwHeznQ==
X-Received: by 2002:a05:6e02:1a89:b0:35d:5995:798d with SMTP id k9-20020a056e021a8900b0035d5995798dmr3837106ilv.39.1702170294775;
        Sat, 09 Dec 2023 17:04:54 -0800 (PST)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001d0695106c4sm3974840plw.105.2023.12.09.17.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 17:04:54 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 2/3] netdevsim: forward skbs from one connected port to another
Date: Sat,  9 Dec 2023 17:04:47 -0800
Message-Id: <20231210010448.816126-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231210010448.816126-1-dw@davidwei.uk>
References: <20231210010448.816126-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <davidhwei@meta.com>

Forward skbs sent from one netdevsim port to its connected netdevsim
port using dev_forward_skb, in a spirit similar to veth.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/netdev.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e290c54b0e70..c5f53b1dbdcc 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -29,19 +29,33 @@
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct netdevsim *peer_ns;
+	int ret = NETDEV_TX_OK;
 
+	rcu_read_lock();
 	if (!nsim_ipsec_tx(ns, skb))
-		goto out;
+		goto err;
 
 	u64_stats_update_begin(&ns->syncp);
 	ns->tx_packets++;
 	ns->tx_bytes += skb->len;
 	u64_stats_update_end(&ns->syncp);
 
-out:
-	dev_kfree_skb(skb);
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns)
+		goto err;
+
+	skb_tx_timestamp(skb);
+	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
+		ret = NET_XMIT_DROP;
 
-	return NETDEV_TX_OK;
+	rcu_read_unlock();
+	return ret;
+
+err:
+	rcu_read_unlock();
+	dev_kfree_skb(skb);
+	return ret;
 }
 
 static void nsim_set_rx_mode(struct net_device *dev)
@@ -302,7 +316,6 @@ static void nsim_setup(struct net_device *dev)
 	eth_hw_addr_random(dev);
 
 	dev->tx_queue_len = 0;
-	dev->flags |= IFF_NOARP;
 	dev->flags &= ~IFF_MULTICAST;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
 			   IFF_NO_QUEUE;
-- 
2.39.3


