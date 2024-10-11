Return-Path: <netdev+bounces-134685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B6F99AD2B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74091F22D0E
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9521D1E77;
	Fri, 11 Oct 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d98HJkim"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386541D1730;
	Fri, 11 Oct 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676589; cv=none; b=Cvn16xQHsd3KCjd11eeVM59vTTHf7r/DNvrWc3q7yzoa2nry4LPXfIr9M1kO6D6kSq+BRGOrPoFWLJ9dzRQq3fzMULHeOvqTS4kqeDCyD65hlQhsOvsm8kVlbgHZUYX++rGCSStF9igQuRRnG/3kHxqQna0tURr84fL+lOK24hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676589; c=relaxed/simple;
	bh=TMU4bAQ+d2GOR7cncoUYvItGThGrkyP690zABMBRGBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qw6lJi+CcJKy4vOPgLZk9/vN/HY+FDnp2yTclr/PiLwG2/044p6+RVZ/BJXDK5Jh6OBbU8/CBOApr3OG0hHDByGOTa+UFgPxa/5OZfSOdeCmJuAVlfFCOxShWUSCaqBR1YhLz7pwg9O4+mI5tXhkUnEP2iL4mpWjsHNaYsQI8Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d98HJkim; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso1083274a91.3;
        Fri, 11 Oct 2024 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676586; x=1729281386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlSmsxsN2AWmmxqltlUVL5filzfCnO6lBSiOTP1+mQc=;
        b=d98HJkimO9q0xzBVd1f81e0KTAZ6AiCZ/dbXXOTutbFn+9e/tJEhvxvh2oykObpP3h
         Db+1mO/qxMaAu4+C2uf/dFRXXx9PI5dzweNjfLTKhXPXsrJXY7ZJWkujq1cnW+7WeyCc
         ET3X7IR//15jD8kFcf0BfziU0wxqnZih0d4+Tu+AZ5ZU4ZcIVGfSBcsLgzSHNdvoLdQM
         sYtPTmGcUIy5bzzqxS/JHZAu9/iRK1k3ut2JyMYZ1fHAntyY6lTuIZ67k2JByaNQtDlo
         IV+JV5FH7JK4UmSgUnPSBUGjbvdieWstnhIs7XdmobLUCyEVNd+bL68qiu3WaJ5c8rzo
         VeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676586; x=1729281386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlSmsxsN2AWmmxqltlUVL5filzfCnO6lBSiOTP1+mQc=;
        b=w2AemUMNVFyMv+AviIz82pOp+VwCbi8tjl2gln7nqmDOtYMW9jHN07NS14ASl5BbGk
         gJf1OGlEVPVZOCzB8bX9C/nKUk5QjjWJcrhlT9p1O+7s+4t/YsaVIUe28IuefbtWbE5o
         r80xIjmprTLoQi5HcKDYWhvXk695RneFXOTi+w15azD9Zxvp1mI5pH0P7BB2gUA36WuI
         ojRU42QHlooLLtHa08CDahjj9txpZjDcXnJ6xOETvoiTPtuwgGrrISsdomE3Cqbh+ppf
         uNA7VR06hgNXYYvc9MLvYlDeGSwX6td7hSSjFELrUh+UY4lNHwbLtoKAFpE3wr9I3hLM
         rUXw==
X-Forwarded-Encrypted: i=1; AJvYcCXzgxnbTl1+zY/GCVzFbwoX5Wxj539vZYNytwE68bApWygSFO2htX4jtlmiFVgsd2ULcfASRP2dWu8NOQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOowhwyiJLgaLx7V89kX52h5h56d74ih9SO4PdstCyQFn0Hyis
	cqJpqlgjBYu/xJ1/+pDlqGAk/RRW1mB+2ffXkNQSt5T3L2+fyswDRaJJ5C9+
X-Google-Smtp-Source: AGHT+IFK2UZLLbkwCtsTuKVufWcy+Xi2ShsDG5ulCqv+ehFoTuFQIKQRMpGP3UOi/yqoPtQEdLDeBg==
X-Received: by 2002:a17:90b:4a08:b0:2c9:6a38:54e4 with SMTP id 98e67ed59e1d1-2e2f0dd81efmr4583993a91.41.1728676586249;
        Fri, 11 Oct 2024 12:56:26 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44907ea9sm2846025a12.40.2024.10.11.12.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:56:25 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv6 net-next 1/7] net: ibm: emac: use netif_receive_skb_list
Date: Fri, 11 Oct 2024 12:56:16 -0700
Message-ID: <20241011195622.6349-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011195622.6349-1-rosenp@gmail.com>
References: <20241011195622.6349-1-rosenp@gmail.com>
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
2.47.0


