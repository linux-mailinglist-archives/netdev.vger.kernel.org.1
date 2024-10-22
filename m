Return-Path: <netdev+bounces-137680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77829A94E1
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 02:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1386B1F21080
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A91136345;
	Tue, 22 Oct 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X58qno0c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C4A1CFB6;
	Tue, 22 Oct 2024 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556572; cv=none; b=P8ALW6d5/7/eTyY+uVK0dU7ExjcRDDuT03tFAyWpWpvJy24Jq62SbzJPRJnEov9JXoqZavlREypZR6O+sGXhRoG6koCkB1zCFUnB7IAOGeiQC69Lb3LIOxfe/4u1vyzdgpwhoinVKAmW+sH6Ys/ynPrCd3jpkyt0AoBWuNtbaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556572; c=relaxed/simple;
	bh=MpPzqbf3QaeIL408JP0EEziCl+Tb8FH98+72eTKTBUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PV5F6SwTK/8/rKVaFZMZ6k9uMVulwi0u1gvVBAcknGmHnEsW2qCT3kGhBv3W0zKsBJV4eir8qZFIHc6dsT+xf3Cfxwp4ouqNnEGUSTqfCjgZgXBHVur5ZV+ppIeSeLNZzmc/Ty1AHQGWDfBc7Tkv5UmV4Kiea0uXR4wMA79KJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X58qno0c; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71ec12160f6so1298188b3a.3;
        Mon, 21 Oct 2024 17:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729556569; x=1730161369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Skv/FwWiqOmJCmi289YOKQkgyeCp5KZu2TwCeimUcA=;
        b=X58qno0cIBfW/Spmv3wA8eyXOz0AuW3XfKG0qkvJlXY8+KTKnjsfElnKshIf4XKeja
         n5l7g6Ni3SSUYGqM6jcv5TZ8LYUWVMxl/KSsHlvtgbJEi5zuQFIECbOB1NeAw1mGRYkp
         /Uud0+WcDCMsAtJVTL2OAGF4m0cvMuivQewfPyhjYMCBSIxbX9JaWSBu5JuqGSFQNpbB
         c42RngxSQ3ZqFp6/yqYqxELqwTnVfzaudI+hprEDYR/rOuWaq9ovAg0f3XM/jaU0cIyy
         unO0BnhwU+kXnt3ETrQuxXu6X7Btl/DgQEpoK9vyCTcXGC8ekAe7VODEWYcEFonY8OaA
         OzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729556569; x=1730161369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Skv/FwWiqOmJCmi289YOKQkgyeCp5KZu2TwCeimUcA=;
        b=V3TOyV45RiVMksMXGmBgTYsni63pEDxhlU03MuzV9xJPKNcIgefakcV9XgQsQ2ZpcG
         0JBd5J3a7ZfmWXIY1fE1YNwwg8LnfoqkRMQgU3yJuMY7gXrhaNie0MCkCcyqtWpozA2Z
         jn4aTx89SX34EBpzyTwqEzvAysJavmwVjlouDK9ny+5F2IdXFEDyMRaLyuH5qbOaaV66
         9WRXwb+rqxjRxN9HXp0V37fiJ7aWHezubfb7gWXtiZBFl7b8zCsMvrVQNmUYWaVgS1C8
         bZsf4+UM1VfPJwv0k4qWo58AYUhlW+MDH/+yPRAejz1+IlU/iiH1pAXfAXr9eb2m+cxD
         GGuw==
X-Forwarded-Encrypted: i=1; AJvYcCXOfx9WXaChyq5MTNoTwFrPhQ5fNPQ0mt9eciD9OyxPSJ09k+xZZ8svWiZcAWBnV1ziTKSC+Tg68m5k9QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJdPbb6+FsHobK07OXNWmw03nPbF+0flq81uhhobcsn7QyuFU
	RA+W1pZ4JtNP05q78QxgY5FACFRLPZyiyNlZRYNMrP3gzdUKlFH8ws0Aclr6
X-Google-Smtp-Source: AGHT+IEZCV220ex4o5I0jhspxnJlBg6n8DKBkOiTuABBWCzFR79Srw8grPPiz4Vcuxk4duFmZ7Pfew==
X-Received: by 2002:a05:6a21:394c:b0:1d9:aa1:23e3 with SMTP id adf61e73a8af0-1d92c589108mr18727550637.32.1729556569408;
        Mon, 21 Oct 2024 17:22:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3515828b3a.46.2024.10.21.17.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 17:22:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv8 net-next 1/5] net: ibm: emac: use netif_receive_skb_list
Date: Mon, 21 Oct 2024 17:22:41 -0700
Message-ID: <20241022002245.843242-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022002245.843242-1-rosenp@gmail.com>
References: <20241022002245.843242-1-rosenp@gmail.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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


