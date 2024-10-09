Return-Path: <netdev+bounces-133854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D919973D7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABB21F26461
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923BF1E1C1A;
	Wed,  9 Oct 2024 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HzAndZ/d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA751E049A
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496524; cv=none; b=d3rrtoHA0fQRJdjyn+uNX7ETrZy70jkxvVCUkRdvP1k+nY4Zwjks6P+TRHIc7FuSwqCqv2Y0t5CyT3UVVxnOJvecyLJ2M82Sb4TF+U2odoD9b5CJxH9fYXXx28RfTAIcn1YnSTO6grfq1OI7tbTt6ZZ2pMezbwoPEzMyT7wbSoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496524; c=relaxed/simple;
	bh=1abjD/frGy62ltiWGFym0JBG2lFGEIQw0ergcNbY+TM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lmcIl9EhAZXKOS6oqDxUt85PxodaUYuVU/i1KH/nAeyKW5Q4xtPW7Z1nrcIYydZQiLNBf2C1Rv8K9a4Yh3LezVrVWwEoUtY8AHmjqT+lDHnhTWJzX9dWGxf1pCIYAYSLYry/JSovzayTyi8r7nZGwcmVtQD6XLmMmx6t1lfq/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HzAndZ/d; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e050190ddso100050b3a.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728496521; x=1729101321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbS/SuH7apsjdrpWIJvUFHB67kEkphI28+Y3pkQvXLw=;
        b=HzAndZ/dwvttCG0r8YaMuJFwkIBu7BFGmo+prGYWYCgb0MFiZ2yZeBp8xCqCrpQrN/
         ei1sArXgNSi/oqZJXNTzjgSbD9+wadcEx3xwZPtGHSNaTtUV93je3e7RAJymCVgEFQxA
         vAZIrayxRVfOQUWaOI3r7n7KBkcDe3tNlS7G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496521; x=1729101321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbS/SuH7apsjdrpWIJvUFHB67kEkphI28+Y3pkQvXLw=;
        b=Z0OSS6Q7P7y/k4ebkq0/HVJ8bUSHTm9SSjVOaahdXEf8kl8PkZc+bYYC2jRwX2+bV4
         1QaCRd/4RYJU73pY9uwnNrTW5K5ztI+o1Q0GEhKFyTW/1t/TiwcmFTZ0TqscRvsReWTM
         z6JpAAtjv3GxHEzekDBYeUByCnUtwwLfQ05NXA5pIpw2Dh8CBBNJ5um+teggoJii/03w
         uWwkQQ88jBleOORNFVQMn5HcQ6RkDMAhgI3OYM91NBgdq0nMHXN5TlvvPEQ/qyk1IjD4
         5R0qYlrVdGwIXVi5b/IE8qnEnlreOhxS6hhdJLge9S4NvKrb+ZY3Q5NkwlZNu4nkTAgS
         GtGg==
X-Gm-Message-State: AOJu0YzMxQaLjlyZk5dSlPP7s7g2HZiPrt+yDJUHa0vw946iPh+5l1XD
	w4EShMyMxycK7t4lkBZDR1p5eKMmEwVdao3iZymNABmGENdm44ONKagXsOptfP8DT+3ccunp6bB
	aLFCKmX6+dbeYvsDjz6cDYh3HfLiUfYj3VQDKX85kvQTwYYRYj/qtlfegpZpWeTD7NvPEMa8AUJ
	4ty7JWz6lq8UD45pUx2gXtwor2MIs3+lRUxnE=
X-Google-Smtp-Source: AGHT+IHJr828q1dctX10jkdC9YI/ok/HdtT7WM3qVf98YF6YrgHs288clcpTjimaKYDEvYCapDZXwA==
X-Received: by 2002:a05:6a00:8d3:b0:71e:cf8:d6f1 with SMTP id d2e1a72fcca58-71e1db88911mr4197877b3a.14.1728496521501;
        Wed, 09 Oct 2024 10:55:21 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbc86csm8044685b3a.27.2024.10.09.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:55:21 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Joe Damato <jdamato@fastly.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v4 2/2] tg3: Link queues to NAPIs
Date: Wed,  9 Oct 2024 17:55:09 +0000
Message-Id: <20241009175509.31753-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009175509.31753-1-jdamato@fastly.com>
References: <20241009175509.31753-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link queues to NAPIs using the netdev-genl API so this information is
queryable.

First, test with the default setting on my tg3 NIC at boot with 1 TX
queue:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'

[{'id': 0, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'}]

Now, adjust the number of TX queues to be 4 via ethtool:

$ sudo ethtool -L eth0 tx 4
$ sudo ethtool -l eth0 | tail -5
Current hardware settings:
RX:		4
TX:		4
Other:		n/a
Combined:	n/a

Despite "Combined: n/a" in the ethtool output, /proc/interrupts shows
the tg3 has renamed the IRQs to be combined:

343: [...] eth0-0
344: [...] eth0-txrx-1
345: [...] eth0-txrx-2
346: [...] eth0-txrx-3
347: [...] eth0-txrx-4

Now query this via netlink to ensure the queues are linked properly to
their NAPIs:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8960, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8961, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8962, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8963, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8960, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8961, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8962, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8963, 'type': 'tx'}]

As you can see above, id 0 for both TX and RX share a NAPI, NAPI ID
8960, and so on for each queue index up to 3.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v4:
   - Switch the if ... else if to two ifs as suggested by Michael Chan
     to handle the case where tg3 might use combined queues
   - Updated the commit message to test both the default and combined
     queue cases to ensure correctness

 rfcv3:
   - Added running counters for numbering the rx and tx queue IDs to
     tg3_napi_enable and tg3_napi_disable

 drivers/net/ethernet/broadcom/tg3.c | 39 ++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 6564072b47ba..c4bce6493afa 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7395,18 +7395,49 @@ static int tg3_poll(struct napi_struct *napi, int budget)
 
 static void tg3_napi_disable(struct tg3 *tp)
 {
+	int txq_idx = tp->txq_cnt - 1;
+	int rxq_idx = tp->rxq_cnt - 1;
+	struct tg3_napi *tnapi;
 	int i;
 
-	for (i = tp->irq_cnt - 1; i >= 0; i--)
-		napi_disable(&tp->napi[i].napi);
+	for (i = tp->irq_cnt - 1; i >= 0; i--) {
+		tnapi = &tp->napi[i];
+		if (tnapi->tx_buffers) {
+			netif_queue_set_napi(tp->dev, txq_idx,
+					     NETDEV_QUEUE_TYPE_TX, NULL);
+			txq_idx--;
+		}
+		if (tnapi->rx_rcb) {
+			netif_queue_set_napi(tp->dev, rxq_idx,
+					     NETDEV_QUEUE_TYPE_RX, NULL);
+			rxq_idx--;
+		}
+		napi_disable(&tnapi->napi);
+	}
 }
 
 static void tg3_napi_enable(struct tg3 *tp)
 {
+	int txq_idx = 0, rxq_idx = 0;
+	struct tg3_napi *tnapi;
 	int i;
 
-	for (i = 0; i < tp->irq_cnt; i++)
-		napi_enable(&tp->napi[i].napi);
+	for (i = 0; i < tp->irq_cnt; i++) {
+		tnapi = &tp->napi[i];
+		napi_enable(&tnapi->napi);
+		if (tnapi->tx_buffers) {
+			netif_queue_set_napi(tp->dev, txq_idx,
+					     NETDEV_QUEUE_TYPE_TX,
+					     &tnapi->napi);
+			txq_idx++;
+		}
+		if (tnapi->rx_rcb) {
+			netif_queue_set_napi(tp->dev, rxq_idx,
+					     NETDEV_QUEUE_TYPE_RX,
+					     &tnapi->napi);
+			rxq_idx++;
+		}
+	}
 }
 
 static void tg3_napi_init(struct tg3 *tp)
-- 
2.25.1


