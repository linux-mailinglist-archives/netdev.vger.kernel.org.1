Return-Path: <netdev+bounces-93346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2482C8BB3D7
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 21:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55C41F25871
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 19:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18F5158D6E;
	Fri,  3 May 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j25g307l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C7E158D62
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764070; cv=none; b=RnqZD3k/yrEalRA06YAmjq61AbfQt6+P9wx/+4nt5iqf5ou2jAdhugiedS9B9qy6oiCrBp9VgBeW8cijAqwklwvR/TGZPGVZM9FffaCZ23pXT4rgHCAITF6vK9r3Wh3wHrEHVmW17kYbXGimWIQjaddZFOBjV/GBRws3RzfCXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764070; c=relaxed/simple;
	bh=9inSIsYz7jeVuYDNCAdsbQnG65h01+pBIiNJcjCp5kA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IccNau/uHzODRnXbekMfsba4xz+c1fsc24vEhOj0dY4nGVmQjR36nYVAIgT1EdjcxHjvllMFWhPSpJxOx5+KSexb1rIfwyKbJYy1UTGPOHe/3VIukFEXSGp4W/EUOrNgtZzaEhArBYi9BYlu6w0t1NZtlROsiQ8ilBbBibPtrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j25g307l; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso72300276.1
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714764068; x=1715368868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cSZyZFAMTOLjqnKwjp5Wj0SARacf3WdqfjzifFZ+QaQ=;
        b=j25g307lHQRppeLvBXnmVJNt/NvODGi1EPDQ+JLsHpK0c+vdO1fkJ9OYC7o4xF4EUM
         g5bRXdRrVXkEccO9iA+ZrDo5/HymbebzOHmi+QU2x8QPh9BTh+E02a+OjIXDZqi5/w7b
         F6+dfzua8x0Ggr7PKYRYpevZuI9QjRSmHN2Z6evm/ycZDcRVWOr0N0VoYpY0Wh0jxRKm
         4eS6OUlCGzqH0TlR0jeqq3/N0R80icdMQTBRjN7q4Ymav+NgczJNlJFOM5Zom81QGkp7
         2g47bi5rdRD5dsC9uJp4a3WUJZ6UAKn47OzExoUtX7FstrRULS2q137D+vdb6trK2g6n
         vYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764068; x=1715368868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSZyZFAMTOLjqnKwjp5Wj0SARacf3WdqfjzifFZ+QaQ=;
        b=FU/fq+LhS7Jhb4td7AS2/YT7klwTiEagqKyCbn1nVeflMnxj3S4jSlBR6ZlfYjFbTm
         OSzz6lYaNbvoWnUZObK556exZ7Atem3FXrT+AWkEyCwDb7Iag3CVjWvlohLV8oELxION
         nVp0N7M2cjllRPmbFvIT9ql4rALL5V7lYINyP8KSnZApHCBFtyJelqrgVZoabydUISAR
         xCFNwyqZxQpIhxl3hR9Bz5z6/nmynmtC9RI4O1N73qrSzZ7TOLlGs7iMX+v9lxDsskg4
         /WsrZnBSjnd2KdTAYhNE5Eyvxrf2vkvKGUHYH0fezZ5ADk2CzVDbxgMeYHeKC5NALmgo
         C21A==
X-Gm-Message-State: AOJu0YymkMMKUu6ZUVPonXVHnlw3auFNDF8uCFlLTIZs1NHUTCGWFynn
	StUUib96/55cjNMylYNaQ6O72PQ+rsib7uJ39r+9hhGIX32QbRb8dz5AG0qQ5vM61qzNL5mO2jA
	8TtWgUNw3UQ==
X-Google-Smtp-Source: AGHT+IEtrHV8BnWhYkyXUVcGa8trQqFBZLBs9GJMmSz6K4mV/Cs4bDFfXuBcBzHN0U1XLTI91x5hPZF46pOXhg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1082:b0:dce:5218:c89b with SMTP
 id v2-20020a056902108200b00dce5218c89bmr477031ybu.5.1714764068410; Fri, 03
 May 2024 12:21:08 -0700 (PDT)
Date: Fri,  3 May 2024 19:20:56 +0000
In-Reply-To: <20240503192059.3884225-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503192059.3884225-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503192059.3884225-6-edumazet@google.com>
Subject: [PATCH net-next 5/8] rtnetlink: do not depend on RTNL for many attributes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following device fields can be read locklessly
in rtnl_fill_ifinfo() :

type, ifindex, operstate, link_mode, mtu, min_mtu, max_mtu, group,
promiscuity, allmulti, num_tx_queues, gso_max_segs, gso_max_size,
gro_max_size, gso_ipv4_max_size, gro_ipv4_max_size, tso_max_size,
tso_max_segs, num_rx_queues.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 51 +++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 77d14528bdefc8b655f5da37ed88d0b937f35a61..242c24e857ec4c799f0239be3371fd589a8ed191 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1603,7 +1603,8 @@ static int put_master_ifindex(struct sk_buff *skb, struct net_device *dev)
 
 	upper_dev = netdev_master_upper_dev_get_rcu(dev);
 	if (upper_dev)
-		ret = nla_put_u32(skb, IFLA_MASTER, upper_dev->ifindex);
+		ret = nla_put_u32(skb, IFLA_MASTER,
+				  READ_ONCE(upper_dev->ifindex));
 
 	rcu_read_unlock();
 	return ret;
@@ -1825,8 +1826,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	ifm = nlmsg_data(nlh);
 	ifm->ifi_family = AF_UNSPEC;
 	ifm->__ifi_pad = 0;
-	ifm->ifi_type = dev->type;
-	ifm->ifi_index = dev->ifindex;
+	ifm->ifi_type = READ_ONCE(dev->type);
+	ifm->ifi_index = READ_ONCE(dev->ifindex);
 	ifm->ifi_flags = dev_get_flags(dev);
 	ifm->ifi_change = change;
 
@@ -1839,24 +1840,34 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 
 	if (nla_put_u32(skb, IFLA_TXQLEN, READ_ONCE(dev->tx_queue_len)) ||
 	    nla_put_u8(skb, IFLA_OPERSTATE,
-		       netif_running(dev) ? dev->operstate : IF_OPER_DOWN) ||
-	    nla_put_u8(skb, IFLA_LINKMODE, dev->link_mode) ||
-	    nla_put_u32(skb, IFLA_MTU, dev->mtu) ||
-	    nla_put_u32(skb, IFLA_MIN_MTU, dev->min_mtu) ||
-	    nla_put_u32(skb, IFLA_MAX_MTU, dev->max_mtu) ||
-	    nla_put_u32(skb, IFLA_GROUP, dev->group) ||
-	    nla_put_u32(skb, IFLA_PROMISCUITY, dev->promiscuity) ||
-	    nla_put_u32(skb, IFLA_ALLMULTI, dev->allmulti) ||
-	    nla_put_u32(skb, IFLA_NUM_TX_QUEUES, dev->num_tx_queues) ||
-	    nla_put_u32(skb, IFLA_GSO_MAX_SEGS, dev->gso_max_segs) ||
-	    nla_put_u32(skb, IFLA_GSO_MAX_SIZE, dev->gso_max_size) ||
-	    nla_put_u32(skb, IFLA_GRO_MAX_SIZE, dev->gro_max_size) ||
-	    nla_put_u32(skb, IFLA_GSO_IPV4_MAX_SIZE, dev->gso_ipv4_max_size) ||
-	    nla_put_u32(skb, IFLA_GRO_IPV4_MAX_SIZE, dev->gro_ipv4_max_size) ||
-	    nla_put_u32(skb, IFLA_TSO_MAX_SIZE, dev->tso_max_size) ||
-	    nla_put_u32(skb, IFLA_TSO_MAX_SEGS, dev->tso_max_segs) ||
+		       netif_running(dev) ? READ_ONCE(dev->operstate) :
+					    IF_OPER_DOWN) ||
+	    nla_put_u8(skb, IFLA_LINKMODE, READ_ONCE(dev->link_mode)) ||
+	    nla_put_u32(skb, IFLA_MTU, READ_ONCE(dev->mtu)) ||
+	    nla_put_u32(skb, IFLA_MIN_MTU, READ_ONCE(dev->min_mtu)) ||
+	    nla_put_u32(skb, IFLA_MAX_MTU, READ_ONCE(dev->max_mtu)) ||
+	    nla_put_u32(skb, IFLA_GROUP, READ_ONCE(dev->group)) ||
+	    nla_put_u32(skb, IFLA_PROMISCUITY, READ_ONCE(dev->promiscuity)) ||
+	    nla_put_u32(skb, IFLA_ALLMULTI, READ_ONCE(dev->allmulti)) ||
+	    nla_put_u32(skb, IFLA_NUM_TX_QUEUES,
+			READ_ONCE(dev->num_tx_queues)) ||
+	    nla_put_u32(skb, IFLA_GSO_MAX_SEGS,
+			READ_ONCE(dev->gso_max_segs)) ||
+	    nla_put_u32(skb, IFLA_GSO_MAX_SIZE,
+			READ_ONCE(dev->gso_max_size)) ||
+	    nla_put_u32(skb, IFLA_GRO_MAX_SIZE,
+			READ_ONCE(dev->gro_max_size)) ||
+	    nla_put_u32(skb, IFLA_GSO_IPV4_MAX_SIZE,
+			READ_ONCE(dev->gso_ipv4_max_size)) ||
+	    nla_put_u32(skb, IFLA_GRO_IPV4_MAX_SIZE,
+			READ_ONCE(dev->gro_ipv4_max_size)) ||
+	    nla_put_u32(skb, IFLA_TSO_MAX_SIZE,
+			READ_ONCE(dev->tso_max_size)) ||
+	    nla_put_u32(skb, IFLA_TSO_MAX_SEGS,
+			READ_ONCE(dev->tso_max_segs)) ||
 #ifdef CONFIG_RPS
-	    nla_put_u32(skb, IFLA_NUM_RX_QUEUES, dev->num_rx_queues) ||
+	    nla_put_u32(skb, IFLA_NUM_RX_QUEUES,
+			READ_ONCE(dev->num_rx_queues)) ||
 #endif
 	    put_master_ifindex(skb, dev) ||
 	    nla_put_u8(skb, IFLA_CARRIER, netif_carrier_ok(dev)) ||
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


