Return-Path: <netdev+bounces-131440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F798E83D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6A82880F5
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73881B95B;
	Thu,  3 Oct 2024 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai76wE8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B94117991;
	Thu,  3 Oct 2024 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921501; cv=none; b=ccv6Ryc3hmbgX88mag7OWEuUuwLK+My2NwpO7YhZmLCjDCiqpc/uOHtMmnnjcESoBTZaAFj94D7ZzZ5EjBHd/dbuGhV0logt4ZtgDwqqoYG0xLbnGQm6fQcSFAoPSx0O9RFjRr3iXjRiUGwIi+mozMFSQgxA1AW7MwrDzuMRfJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921501; c=relaxed/simple;
	bh=VLHNOJVF2xYI9xFz0sdYpst/JrodikRXh5fZnHMPKUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOeKnwyafdNMUDJ2q399tvZNH3aIMtSHdqEaXPVX0682Uabswt/FioPvt2ybshNs+6dbJYCLqoBpA6MCNcbInxwxhb38ls6u9I/b0Wov+QvqVfwP5aqIVDXgw2eAZ9i0N4883Wc/gkw+H50a6MxFBeujOcHf4Ei4v/nfn/cWBkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai76wE8/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d91eef2eso340605b3a.1;
        Wed, 02 Oct 2024 19:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921499; x=1728526299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTFOaXTef0G9oTg4z249QNFPMYARm/rD0bt+cP8X3Pw=;
        b=Ai76wE8/GO3zj4eE1LgUsTUkQWnCylp8rTReFLvXriJr3yHlyYFkWEYstelBcON/xL
         iDr+wtIc+nUY13IGF5mzM2c55H61KDKKV0ZbyHq1TiUsOPZgCyLpeu8FONvsMnGilQFw
         ytQ2V9FygUeMGMs7yjqTACXprgRBL72rD1hERmoBThwGqlNaAMjHwFk+O6Lg0JH8fwwa
         I8bcUlPF6cgur/CDFVINJfJ36ByTtaNs2ERgjseS8ZQrewW2OyCqpazdPCTCVjpFl1QP
         J//1bT8aaiTYzFooKTapCe5pkmIGYJwiYLzOcVVSwDLwNwH1iUmKy4DCmXQCaY5+am8e
         7cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921499; x=1728526299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTFOaXTef0G9oTg4z249QNFPMYARm/rD0bt+cP8X3Pw=;
        b=OhClQKiI/IJxG8dkgxRVraZT5YP2vb4o9XS8U+4MFYtIyBQfIqdjsSu9pEth0A7OYj
         R3hAbvnBvgK7GXWkVHKnytNak8Xg0oiFrMGG2selNHPELBpF8XMYh2nHZoSfGGI8i/bx
         C70B6deAgJGSmkglz3FiWSwXvR6Yp4U0ZuuZoPEsWmzgYJTJZr09pd8gcCeegatrLay9
         Y/BvykCN5QvPf47yoaVuRQd627posld8a9GeZcLsGp6IzOvnKZGsSPUYm+QQYpyWsfEu
         uZZ7LZSeXGW9fhYRpQIle3nQRsA0EIn+TLGPMI4qT1Oi4hN3QSP4Cu+aAiXeibswZcc2
         jdiw==
X-Forwarded-Encrypted: i=1; AJvYcCVRohZLRtDx1bIDf4CFZqp3EC/ZjlAbl2pE38D/qyQlAJ9Cy8fCVcFEFXBZglshIZDZcO5UIwztb+9Knxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEajzZbVLXf0qODOMSyKlNdZez2xgSmCmBZ5xBj8jyIKVUWYy
	ts+Ap8GLuvvUL+ALfg+WD+bKo+GoQuluzTbolBmFKEo7DDHQBjclDJOQWpRw
X-Google-Smtp-Source: AGHT+IGnF/vG6j6X2Sjz4JiYV+crJcihzLxUtpZHSZY4a/DvTIWBbDqKNLhC4ChLNNckFej06MJ3Mw==
X-Received: by 2002:aa7:93bb:0:b0:718:dda3:d7fe with SMTP id d2e1a72fcca58-71dd5b6949emr2148105b3a.12.1727921499336;
        Wed, 02 Oct 2024 19:11:39 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:39 -0700 (PDT)
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
Subject: [PATCH net-next v3 01/17] net: ibm: emac: use netif_receive_skb_list
Date: Wed,  2 Oct 2024 19:11:19 -0700
Message-ID: <20241003021135.1952928-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
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


