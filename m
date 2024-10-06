Return-Path: <netdev+bounces-132437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80721991BF2
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC16A1F21F2E
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A16B16A382;
	Sun,  6 Oct 2024 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETsUxyKd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8E54279;
	Sun,  6 Oct 2024 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728180383; cv=none; b=NGt0a1ka+CgyghftkOEs8g5YPdh8kbblGVcWT924iCIyKmRSgmYIlebWZLy23fCbJWcV5icQm1ZPH0HqN5a0p9X9dyCYqqf/i7ssPvhDBrdLtU18VQubZeXFO9uKuOssFLFGdlMx8rXeG4WFf2opeHazajbSfPG+hJb3PJJZ00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728180383; c=relaxed/simple;
	bh=VLHNOJVF2xYI9xFz0sdYpst/JrodikRXh5fZnHMPKUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nj6CTddLQL4fyfp/sktr0EMJ0f8qEPamjCXwkF+4tBYxxlLSqh4ee7uqmNGPaAt2WPptU6jEQOAkR263GQF80wY+eD+K2zZQ33esoH93j3Fs6myFHlaQoFFZjPg9cENuWnbPizwLb1/aZPHHBlOml5zzWowI4bBWISoWxZ4kCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETsUxyKd; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e9f8d67df9so644133a12.1;
        Sat, 05 Oct 2024 19:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728180381; x=1728785181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTFOaXTef0G9oTg4z249QNFPMYARm/rD0bt+cP8X3Pw=;
        b=ETsUxyKdXeKCN4lMlqEz9M5uOmAKlN5iUzm6ZcA3utt3jLfM8whlRVvqxiuqjHvAeA
         etDJASqA5+nviPVtHi/+gg6TNVh5c70KLnkmFprZx8PYYeciw33mmCNUyVo9EOsDYil8
         B5IZRkEvUxAX+Xa83hfyEB8T4CWaDxtWfRA8A3Hy/VN5BZACtj4An2UzvJeaUPrs0eU1
         daYBbdAR93yZ9i7lryERfJhos9Q2WYKCIEdMd/KtUyP8vwyaGYC1NDSPJ5WibiPCkzl5
         c2ZGP1IkB0+3vKoOXXdnjSkJhzOf1iiqmWQd2BpVresTk2zT+sVkAIQT0OqXfwBROuRK
         JjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728180381; x=1728785181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTFOaXTef0G9oTg4z249QNFPMYARm/rD0bt+cP8X3Pw=;
        b=In0IZ6DclniVNXEGzNIQ0D1s7GRjA7hTi80jVKjMms9xiLSbSsWfRC5szjiUoxN4JX
         Tv5tMiJnmakVRB/uqTBEQnRN2YtfU7dbZAvC9zGRuIIlAO+9yDZOOS7JpHbFC2JNAaZH
         xhDBuYtiwyORD091NwxFA+ytfTlNlOlTQCYf3qTCmcEIBzsogYyoYrCEY8TpKsEC/RFj
         yvXqyvvSsE9OvWVJYQ0T20UMNBCanRcArmPpEWzn+vaSS09eQdGSqiE5SmUo3oASAD+e
         dmUUFuZcMcF9tYyaR8Ziz3/QJUTzc98GJrJ1P+BJpCuMokNvc7XeJBm3U+eG6SNx7wph
         VxWg==
X-Forwarded-Encrypted: i=1; AJvYcCU0pX+F6DhZ0eEVUGrME3GYHaiQ29vWdYVrH66lM5I8P7ZMhZkW2A2yzBJBUejs7uJMcha/xMpjOySHEOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+nDzijXY1K/Of7lNhNfx4fM6pFCXLCz2x/wHTn4p1stzG1Qoy
	6ESjo5Ci7zm24CjnEc0pww15aZeMIXHdtzYvkvqcoMstphUyqLC8furOqA==
X-Google-Smtp-Source: AGHT+IFV/YLn8XmzNejfUy4gdSvSwG+Zgf4OOBR/2Hh5w97aKvTT6kEjftoGYA1zEf2uFp4Bk6LYHA==
X-Received: by 2002:a05:6a21:9204:b0:1d6:97f2:4c11 with SMTP id adf61e73a8af0-1d6dfa23bd7mr11474133637.5.1728180380568;
        Sat, 05 Oct 2024 19:06:20 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f683153asm2034212a12.50.2024.10.05.19.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:06:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv4 net-next 1/8] net: ibm: emac: use netif_receive_skb_list
Date: Sat,  5 Oct 2024 19:06:09 -0700
Message-ID: <20241006020616.951543-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006020616.951543-1-rosenp@gmail.com>
References: <20241006020616.951543-1-rosenp@gmail.com>
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
index dac570f3c110..d476844bae3e 100644
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


