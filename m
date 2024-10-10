Return-Path: <netdev+bounces-134353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5616C998E9F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E351628114F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7541CBEA8;
	Thu, 10 Oct 2024 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPRhq7R2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2819E1C7B70;
	Thu, 10 Oct 2024 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582270; cv=none; b=l+Y73wWd/B3UEjez5e8HbwpPsV81tjxqRYke+Lo1l91vNINcK2urtJDf2O5wv233Rk4ZG9mXKM7hIBtN4MhVFxpdbPKJ4Ezos3TBv3UORCzi8XckFT9tP8r6P6pxzuo+nfnQyAXN0c4DvGNLCVYHMyZAAhVQrfLTW6XodsKAy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582270; c=relaxed/simple;
	bh=Qxsoz51VZJyHMDxqxqNVqB+2m7V5J27IuxQi+7VCcME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRwheJ5vKGQQ4Fyj98w7w6/oyjUU7H0N0G05D3gxvUAYR8Jh8qs4ZL9z+9HImLsYiYYvPvBJYdXfMs+wYOgGUQnQDRp9Breju5j8tuzlzE+QJE3frzuYQjZL4Aa5x9ZGITg3YvmVLTckwliq4KdJKSvsHo1EhvO7Qse20QjRFto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPRhq7R2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c8c50fdd9so5697375ad.0;
        Thu, 10 Oct 2024 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728582268; x=1729187068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TP8WQ67T+F83vpCMppV7EVGcd0m/hdO1rsD5cKr0SlQ=;
        b=RPRhq7R22QMA0dvwTYkeOnZWVTJwVs09CGqeFgfnGe4SQzmR3tJ8HhF4u2ZDA/BuHN
         ygSg6C+6xJcKjk3XCrJENteB12S1+lcRQVo6ZPrCsA0azc5olzZ2e/jUM01yRSjftJYG
         jDEBAqlJ6g0kge8ihbWiefzyTnpL3LDNTH2sm6KTKntY2h5j08hDsM9YiDTF+zfappjv
         DFKnNZRZ2/Wp+FeV4FbE1JED4kaQOAjUVaqPz5AwkDImy6DmFg4pgFQrAC9xpAQToBVT
         d70My5KdWi8cEy0vuAcGGJvzRT9NLlBQo19w1DpO1t0MjGOcqIILnUAAtQo0gp64aoiG
         1PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582268; x=1729187068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TP8WQ67T+F83vpCMppV7EVGcd0m/hdO1rsD5cKr0SlQ=;
        b=t8qq1KZTp/SOXVIDRe8B9y0NeXcml/2SC9fngKEoNIIdHxcSSHMGlYsakRw5ycbn6D
         uThNInTcv7YkXcnvBjXzaNWiWDt7Rl678C17nUlNdHrblVkKpSlvTT/u8nq8T3nWjTD9
         CgZR0UEgIFa3v5WnLu73nxOSzOKao+GPzIlt3BeeU37p58OpOap0uqECzWY2+55nSa/t
         w1dg7y2z2KZDeqIFKWiPebPh0u+qMWXDMI9sO5PA8JU2cBWS0duLgRjDtqwR4qg6IX4y
         31xuZmAAjRkN59Qs0OK66WDeYhANhUGBKXs2j6GcqXuvpAeaS/FHGPPWQJoV8UXD2HdQ
         v/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWMyTID/+xdZAzkjK37OjnhX8COL//FABwaSWobYKWqUr2koOV44kZNy+94tfJ591YTBWwGYKt7NM71go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx4d8wdAQapZeGFnVoPZxVFo3h80aFFcvXNg+0RAUhv06CQxa7
	zZiADRTPNeLfM7ifHCwhFh2oWaSZjG6r5lLuX79hZCzxU9VzQ+dTrzZQj0g7
X-Google-Smtp-Source: AGHT+IF+FoqglhO6Mx7gcwyh9QZV6BDUFuDOzK17THaRC+xlIs7NAYMohoVyzBKavc4wADKsttMk5Q==
X-Received: by 2002:a17:903:32d2:b0:20c:7509:d958 with SMTP id d9443c01a7336-20c8047c240mr62944145ad.5.1728582268224;
        Thu, 10 Oct 2024 10:44:28 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb470sm11826495ad.126.2024.10.10.10.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:44:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv5 net-next 1/7] net: ibm: emac: use netif_receive_skb_list
Date: Thu, 10 Oct 2024 10:44:18 -0700
Message-ID: <20241010174424.7310-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010174424.7310-1-rosenp@gmail.com>
References: <20241010174424.7310-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small rx improvement. Would use napi_gro_receive instead but that's a
lot more involved than netif_receive_skb_list because of how the
function is implemented.

Before:

> iperf -c 192.168.1.1
------------------------------------------------------------
Client connecting to 192.168.1.1, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 192.168.1.101 port 51556 connected with 192.168.1.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  1] 0.00-10.04 sec   559 MBytes   467 Mbits/sec
> iperf -c 192.168.1.1
------------------------------------------------------------
Client connecting to 192.168.1.1, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 192.168.1.101 port 48228 connected with 192.168.1.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  1] 0.00-10.03 sec   558 MBytes   467 Mbits/sec
> iperf -c 192.168.1.1
------------------------------------------------------------
Client connecting to 192.168.1.1, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 192.168.1.101 port 47600 connected with 192.168.1.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  1] 0.00-10.04 sec   557 MBytes   466 Mbits/sec
> iperf -c 192.168.1.1
------------------------------------------------------------
Client connecting to 192.168.1.1, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 192.168.1.101 port 37252 connected with 192.168.1.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  1] 0.00-10.05 sec   559 MBytes   467 Mbits/sec

After:

> iperf -c 192.168.1.1
------------------------------------------------------------
Client connecting to 192.168.1.1, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 192.168.1.101 port 40786 connected with 192.168.1.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  1] 0.00-10.05 sec   572 MBytes   478 Mbits/sec
> iperf -c 192.168.1.1
------------------------------------------------------------
Client connecting to 192.168.1.1, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 192.168.1.101 port 52482 connected with 192.168.1.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  1] 0.00-10.04 sec   571 MBytes   477 Mbits/sec
> iperf -c 192.168.1.1
------------------------------------------------------------
Client connecting to 192.168.1.1, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 192.168.1.101 port 48370 connected with 192.168.1.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  1] 0.00-10.04 sec   572 MBytes   478 Mbits/sec
> iperf -c 192.168.1.1
------------------------------------------------------------
Client connecting to 192.168.1.1, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 192.168.1.101 port 46086 connected with 192.168.1.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  1] 0.00-10.05 sec   571 MBytes   476 Mbits/sec
> iperf -c 192.168.1.1
------------------------------------------------------------
Client connecting to 192.168.1.1, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 192.168.1.101 port 46062 connected with 192.168.1.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  1] 0.00-10.04 sec   572 MBytes   478 Mbits/sec

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index dadd987efb6b..0edcb435e62f 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1727,6 +1727,7 @@ static inline int emac_rx_sg_append(struct emac_instance *dev, int slot)
 /* NAPI poll context */
 static int emac_poll_rx(void *param, int budget)
 {
+	LIST_HEAD(rx_list);
 	struct emac_instance *dev = param;
 	int slot = dev->rx_slot, received = 0;
 
@@ -1783,8 +1784,7 @@ static int emac_poll_rx(void *param, int budget)
 		skb->protocol = eth_type_trans(skb, dev->ndev);
 		emac_rx_csum(dev, skb, ctrl);
 
-		if (unlikely(netif_receive_skb(skb) == NET_RX_DROP))
-			++dev->estats.rx_dropped_stack;
+		list_add_tail(&skb->list, &rx_list);
 	next:
 		++dev->stats.rx_packets;
 	skip:
@@ -1828,6 +1828,8 @@ static int emac_poll_rx(void *param, int budget)
 		goto next;
 	}
 
+	netif_receive_skb_list(&rx_list);
+
 	if (received) {
 		DBG2(dev, "rx %d BDs" NL, received);
 		dev->rx_slot = slot;
-- 
2.46.2


