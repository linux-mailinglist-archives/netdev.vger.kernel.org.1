Return-Path: <netdev+bounces-130568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D4C98AD9D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1402C1C21C73
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312CF19F139;
	Mon, 30 Sep 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="yRg+imbU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C91A01DB
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726195; cv=none; b=nM5POtMetuD8o9PmgzCM+34HobBqUG+nZhkBlsCyUqM/U/1ZOtOjPZ7GXcoKUxtZllM+Loi9h2ZegG9dCAWoXBjfIP+3JVFFnXtLVU5fIG6MH2WA4oWv5tffgn1WWsbGJNjPEL0i2XsgLrgb3q6TVE1QT9XxO93dOMGnNhVev18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726195; c=relaxed/simple;
	bh=UA0m3VMYAwf7VZLj3wNgsyeHamH7xUAmp8+jviHGxUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlev4WBxJVxwnQlcjSBzcDWioZf6g8qWbYMKSmq92d3ZXv+Uzc1Wl6xnE3XpkPiBEUbEFYYz9OWR4FyTvUZ8cxVUumd3A7AjGgji1ts6t4T/eJo//wtgFsp6HMK6TEGA+mQ/Y4zVxN4MQQubeoRg2VkFMCRCI4sPwQEkldRmt4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=yRg+imbU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d606726cso3394923b3a.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727726192; x=1728330992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxtv2lrF1kOetNp7xi3WglFSuTqjxy0uNajfsDkNvuU=;
        b=yRg+imbUi7bGSZneMP0cJqGUe6lYG0H3ejIn3qalyl/5b67WeQk5LWEoPRDfZUkQPC
         QYauuwVtpF2KelD25JqqmdOM11bzJb++6w4K9vyzkaBY/SnUhywbcDugSD+/El95FBV3
         RVqciJ63OMQltvkALlxuMvFjGdppsvS69h6iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726192; x=1728330992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxtv2lrF1kOetNp7xi3WglFSuTqjxy0uNajfsDkNvuU=;
        b=aSWu1FdApWhxzwxoBip/bJppi5jHwjFgNTzEYfYVVKMH8YX4uVSwwMBTAGaxO82NkK
         EWEkPAq/CCHBcGUmR4SFUhasI3LTcDjZKNdEOSUiHSc+6p6+U9aFKiVuP4HnjscCTJqx
         h61wzSVCYWwneAe96eDmSkviqNxd28Ch1ye2pB1jNsDkmmr0SqcGYPfoN3Zh3lEgB8H7
         IVxpkPf8ObCe3OECK1hQAsLcd0pAlmjsGBb1aL1wjjihzmMFVjDebYPZ7+6Y4dpR7RSp
         6o+POAN7pjluPZxCO3+NbgFpgFmI6ey3lGV16LdkTBgFvrF1jU7Ar2FzVcDP/u1XVL1y
         aPeg==
X-Gm-Message-State: AOJu0YwsAomMXhOiRNquinwS3Bd1Jzo5fB0dX+HLCljb317QuBqSYX3+
	PUdVFfc6xmwkUIDm3UtCIMh/9dZTAI1htmiSXaa0pq4xlxucp5+pdoq3Al16N5NnPx2L7lxkbrK
	bFEuOwkpQD69NNGpq5qsYYcCC9zz4IqSiZ3tp+vM3h566EfKY2tOsRWM8j6Eeiegw+1PIKfaKiC
	B7IJnjBCYOE8z91kNrp4iDgoFwcTQ0rB5P/fU=
X-Google-Smtp-Source: AGHT+IHYMQgS9wxg2iL/t0osMPTamKqFGShjRfad8poeTcxLS0lYKsFnK8dQ6emauZeBXHfOlaTwiQ==
X-Received: by 2002:a05:6a00:cc4:b0:706:58ef:613 with SMTP id d2e1a72fcca58-71b2607ae1bmr16336872b3a.27.1727726192145;
        Mon, 30 Sep 2024 12:56:32 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649a2cesm6604450b3a.43.2024.09.30.12.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:56:31 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next 2/2] ena: Link queues to NAPIs
Date: Mon, 30 Sep 2024 19:56:13 +0000
Message-Id: <20240930195617.37369-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930195617.37369-1-jdamato@fastly.com>
References: <20240930195617.37369-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link queues to NAPIs using the netdev-genl API so this information is
queryable.

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'

[{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8205, 'type': 'rx'},
 {'id': 5, 'ifindex': 2, 'napi-id': 8206, 'type': 'rx'},
 {'id': 6, 'ifindex': 2, 'napi-id': 8207, 'type': 'rx'},
 {'id': 7, 'ifindex': 2, 'napi-id': 8208, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8205, 'type': 'tx'},
 {'id': 5, 'ifindex': 2, 'napi-id': 8206, 'type': 'tx'},
 {'id': 6, 'ifindex': 2, 'napi-id': 8207, 'type': 'tx'},
 {'id': 7, 'ifindex': 2, 'napi-id': 8208, 'type': 'tx'}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 26 +++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index e88de5e426ef..1c59aedaa5d5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1821,20 +1821,38 @@ static void ena_napi_disable_in_range(struct ena_adapter *adapter,
 				      int first_index,
 				      int count)
 {
+	struct napi_struct *napi;
 	int i;
 
-	for (i = first_index; i < first_index + count; i++)
-		napi_disable(&adapter->ena_napi[i].napi);
+	for (i = first_index; i < first_index + count; i++) {
+		napi = &adapter->ena_napi[i].napi;
+		if (!ENA_IS_XDP_INDEX(adapter, i)) {
+			netif_queue_set_napi(adapter->netdev, i,
+					     NETDEV_QUEUE_TYPE_TX, NULL);
+			netif_queue_set_napi(adapter->netdev, i,
+					     NETDEV_QUEUE_TYPE_RX, NULL);
+		}
+		napi_disable(napi);
+	}
 }
 
 static void ena_napi_enable_in_range(struct ena_adapter *adapter,
 				     int first_index,
 				     int count)
 {
+	struct napi_struct *napi;
 	int i;
 
-	for (i = first_index; i < first_index + count; i++)
-		napi_enable(&adapter->ena_napi[i].napi);
+	for (i = first_index; i < first_index + count; i++) {
+		napi = &adapter->ena_napi[i].napi;
+		napi_enable(napi);
+		if (!ENA_IS_XDP_INDEX(adapter, i)) {
+			netif_queue_set_napi(adapter->netdev, i,
+					     NETDEV_QUEUE_TYPE_RX, napi);
+			netif_queue_set_napi(adapter->netdev, i,
+					     NETDEV_QUEUE_TYPE_TX, napi);
+		}
+	}
 }
 
 /* Configure the Rx forwarding */
-- 
2.43.0


