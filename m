Return-Path: <netdev+bounces-57666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BECF813C8C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 22:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5AA4B20CC2
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A66D1D4;
	Thu, 14 Dec 2023 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="nyRKneGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998846A34D
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so52743935ad.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 13:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702589095; x=1703193895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3foAg4FsvwtEbfkJJ5e/Q650NfAxHXH88hs23zYw8ys=;
        b=nyRKneGrabCI5a/XdTxvTODFaRyyOQGxf3X+SfnRLgic8NFqH0utve/CuWcgM/3aDx
         YJ6d4/5Qyhh3g8YR5CWfnxtkFKxX0/yvOYt/WMG49J98WpMdc20J/FX3vIH+U+MfELm8
         Qx7Cf+MBZoJYib3lsQv0+w5xf+zKjoXKXB8LIpyjM05++BqW7M71+Pf4abiW1kGPJBsn
         NTdzqmMDk98MvVKariYHhG7ohyhgiBgXe1tH5fotA+Uw9HmvEQif0hrZirN5jUH/0bnw
         HX1wlSkJWyLeF3+L1Y9HTMeXw1N7FAIwL+yxb/mqZsjWQqWBMMxUi+4Jk/+sstn+yfbd
         EW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702589095; x=1703193895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3foAg4FsvwtEbfkJJ5e/Q650NfAxHXH88hs23zYw8ys=;
        b=ji1FI5GwUDYopMUJjB06F+573ygzgetCwpPU5TsDJ5ekBuMIeHztzEf2rrLXsXswGF
         JhjoxS9uSjldOQTzSA5wB/zRN2VzIJvE2zJA4Ga7zMODEZo9RVEATpiOJodtQ9+Xlb/y
         LdQufm0EslSGXTWz6R/E0Ndem1gNHXW/m8W1+kUUEzemNua7y215dzx70/3JgUVs7LjA
         uXl3xMjeZS17IdTtd73bZ5ePXK9CEWyoZClf9k70n2LJjVFbw7OjGdtE1EUzZwNNegbu
         d48MCcMQER2i14mESz2u2KMHAoNLYwArEOVSu+lRSfE67UmjbruCXXVyfv8DguguK7J5
         7rmQ==
X-Gm-Message-State: AOJu0YyhnTR0b6A3DwytTu0ZheAarTT3L2BlXYz+s20c7CYpjUSmxm3L
	7fjikBIQfqlpAriKHD9GRM5jYg==
X-Google-Smtp-Source: AGHT+IExf7RtGyLo+Dgp5MVDXfE0p99qrWWuz1Qu//T5ZXqk4ex2NWm9TzKURRXVcMHEHx6P4qJl8A==
X-Received: by 2002:a17:902:728e:b0:1d0:a35b:8cf0 with SMTP id d14-20020a170902728e00b001d0a35b8cf0mr5662225pll.132.1702589094693;
        Thu, 14 Dec 2023 13:24:54 -0800 (PST)
Received: from localhost (fwdproxy-prn-012.fbsv.net. [2a03:2880:ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902848200b001d09c539c96sm1388102plo.229.2023.12.14.13.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:24:54 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 2/4] netdevsim: forward skbs from one connected port to another
Date: Thu, 14 Dec 2023 13:24:41 -0800
Message-Id: <20231214212443.3638210-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231214212443.3638210-1-dw@davidwei.uk>
References: <20231214212443.3638210-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


