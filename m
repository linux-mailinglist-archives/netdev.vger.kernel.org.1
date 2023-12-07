Return-Path: <netdev+bounces-54904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF572808E80
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9047DB20AF8
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116B49F86;
	Thu,  7 Dec 2023 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NyaSdnJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6702C1710
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 09:21:33 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d05199f34dso8801075ad.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 09:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1701969693; x=1702574493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gahfqE4ym5/ZFoex4VO8iYbRYCUAR6PpiEFdkfxKNPg=;
        b=NyaSdnJDvqHxL0/p+j0DTO6DGuKKsNPZ67Zsg9pN5Bw7wibW1HV2ZAP+fq+uOtMiQF
         db7Wobc+AqznNO2yFAxZ+0SffaDcKYyrVmZqo06BBKiHlH9u4E4A4RX7lRmPuOI/N60O
         p7jI83yZJBd0/1YCdrEmXLXPnhkz1I/5A/wgcPtWe+CafBDrFOT4LFrHqQuKw/AADEgv
         iNXOcAowwLXpYtJ1PyAeveILjzKbikrBxpAaMktC8LR795XUEnJeYYHu1Gt0aB8+Rl0I
         3sNOcCuy+3LhjG3ClcaZdOOt3o7mmRY3wjL8/UB6MnazX4CZmJuagn3ucYUvEog4S7QT
         aO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969693; x=1702574493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gahfqE4ym5/ZFoex4VO8iYbRYCUAR6PpiEFdkfxKNPg=;
        b=Hee0AP0digzPs6/IMkX8U2NysmT80hSUZ4aTGQG4NYHIjF/MLjJOEZoR88NYkpU6UP
         b7h316AEJH+6/a0li2z/kA+0D1RP/MLjJh2qcS6TDbPGE4oUtqQd/QFkCon8oBWk5BAm
         G9dtbhMozZJ6Ga1EAei1vKcM1GA6n/cvMqK8WvNVdirWE+fq0jRchM2f593KhuUKOvqE
         Br/q97wqpHHswvEz88u3C26NStO3RclieOFPLOX60+MQUI7VFmCQx+Bya6g3cfx9i9J6
         KlSgEzvGfGlIIYaCfv/+LUNfdGYCOaSQBD3Qy3zzUSyRax5HYNp3zVBhGuHYynLMiM78
         Q8bA==
X-Gm-Message-State: AOJu0YxQwsp4+m5PN8yBBomysSxQpP59nn2KnGXXf6jhyXwu1PGcY8LT
	HWBRFlsxI7PP9wR7YAM8V6ytbw==
X-Google-Smtp-Source: AGHT+IE0MO3FU0aMdQASCBQ/zJQ9SHwQf5XgFAegg87v9xGbNQUCMY5EzRUGJy4AuUcG16RJMDY/6w==
X-Received: by 2002:a17:902:b195:b0:1d0:6ffd:6e6e with SMTP id s21-20020a170902b19500b001d06ffd6e6emr2747878plr.102.1701969692868;
        Thu, 07 Dec 2023 09:21:32 -0800 (PST)
Received: from localhost (fwdproxy-prn-022.fbsv.net. [2a03:2880:ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902728100b001d087820175sm64098pll.40.2023.12.07.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:21:32 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/3] netdevsim: forward skbs from one connected
Date: Thu,  7 Dec 2023 09:21:16 -0800
Message-Id: <20231207172117.3671183-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231207172117.3671183-1-dw@davidwei.uk>
References: <20231207172117.3671183-1-dw@davidwei.uk>
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
 drivers/net/netdevsim/netdev.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 1abdcd470f21..698819072c4f 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -29,19 +29,30 @@
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct netdevsim *peer_ns;
+	int ret = NETDEV_TX_OK;
 
 	if (!nsim_ipsec_tx(ns, skb))
-		goto out;
+		goto err;
 
 	u64_stats_update_begin(&ns->syncp);
 	ns->tx_packets++;
 	ns->tx_bytes += skb->len;
 	u64_stats_update_end(&ns->syncp);
 
-out:
-	dev_kfree_skb(skb);
+	peer_ns = ns->peer;
+	if (!peer_ns)
+		goto err;
+
+	skb_tx_timestamp(skb);
+	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
+		ret = NET_XMIT_DROP;
 
-	return NETDEV_TX_OK;
+	return ret;
+
+err:
+	dev_kfree_skb(skb);
+	return ret;
 }
 
 static void nsim_set_rx_mode(struct net_device *dev)
@@ -302,7 +313,6 @@ static void nsim_setup(struct net_device *dev)
 	eth_hw_addr_random(dev);
 
 	dev->tx_queue_len = 0;
-	dev->flags |= IFF_NOARP;
 	dev->flags &= ~IFF_MULTICAST;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
 			   IFF_NO_QUEUE;
-- 
2.39.3


