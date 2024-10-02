Return-Path: <netdev+bounces-131104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E2A98CA13
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 02:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19BB286872
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F96B677;
	Wed,  2 Oct 2024 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="sLldTGhJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7ACB661
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 00:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829258; cv=none; b=ZOR11vh4ZL/HXcxNeJyzCzsCvkOFsn9zwNb1Ipx90ghYVXl5LNRQa137X0RyCECavRxNOy1Rh27YTMbVoHSIw1uu1fF5Epd3+BJnUVsv72mNr337INglRoSizXtAZ9gxcKY7lCqL65+QytPh3WmP+V8jylKi2YIN5FWxJpqYLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829258; c=relaxed/simple;
	bh=yStr/6PJPenHSI7D8HokTLRUj51fig9mf3TfmVYcCLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTbFYwcYEzYngYJHkU+g20cQ0Q6qNwl5RuWwpJQJ3QVaV5t1ytc6n8UqdRhELNfM/AGX1fAdDxLHLcWZb66Ev1qeV9iiuRYzjhgvnnOnkyToVqzT+lM2IJ7aOr5kquZiYQSujQuabAVL3epURdKJn5HzAv9P57CIHnJ7lLTr4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=sLldTGhJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-207115e3056so54266005ad.2
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 17:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727829255; x=1728434055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSZqwRLg8/VfUGa/yJh0BLiOqFcBWWUlHrlyk3W8pCU=;
        b=sLldTGhJzHsCqhdRcsHu5fpCh2Mo9E9kyNkcK4ycJKIxXVz+A8vZpNthUtQuBRfEPW
         vWcms+ZXSNcdxphJwdPc4OkVJDZHZzCjmKmElgbpChjmalyIym8JrZkHaQirTExyUPFl
         /lERu5OR6o2bHL9FEo3XZ4mWJO+VG97uRNkhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727829255; x=1728434055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSZqwRLg8/VfUGa/yJh0BLiOqFcBWWUlHrlyk3W8pCU=;
        b=UlbAqOL5SeuLZgK8Fd23pcf2o/BBgbrsUYPoFqslBGaWXvcjyAuSndPAkFBMxwSYRt
         HI4aV87kSJFp6ZaG7Wr2daTVXTwraQ9FmOC4kmhAy0wqwj1csCU40OgFWmMN01mVeBZY
         palnxLgc1S2lmR6LT2dEq6ROrvjQNRROby/thRDCKBOikSkUpwBji+ydQTt9ZwHd5WZE
         +75qvvszoe8l5V1VLUmMa6grQT7eoWsPLHnDFI6nS/LqE8kRQCL9be5oErQFKYqq2c7r
         iLxcQBfyXTSumEthLFuKojuCqJg2orpXfeYdkbMXQxERJAfi5YRvnzoLa/IovXEJc3YR
         zMXA==
X-Gm-Message-State: AOJu0YzYy8g4MlycJpPRcZTFRVoEGsqffFCVfK3LaqRI4DeDPZJsFnG+
	04VlVStEwueTWJG2B3umjdzkjB6KueH5S/ekWqAcrKb50xUBjGydWHruckVLwUWXyiKjFhsbRDj
	liG1nMU3uQlMCq/W7asHbhKDaYmx5i3gxU16n3hSheR3Gs4R8BYU0+WQDpljPai0ceJRfgtGu6G
	PNupOTJ69KrBAzIBZa0xKxXCHltkG7/4F59U4=
X-Google-Smtp-Source: AGHT+IEqTtOYAZ0xs5mg5rdotEr2lEo3d5tqrafo4yS/vRO6Ol5mizZCFWULpLfJsb7blCc8Mpf/bA==
X-Received: by 2002:a17:902:e80c:b0:20b:51c2:d789 with SMTP id d9443c01a7336-20bc59e6496mr20807085ad.16.1727829255450;
        Tue, 01 Oct 2024 17:34:15 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5ecc1sm75521295ad.268.2024.10.01.17.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 17:34:14 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: darinzon@amazon.com,
	Joe Damato <jdamato@fastly.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 2/2] ena: Link queues to NAPIs
Date: Wed,  2 Oct 2024 00:13:28 +0000
Message-Id: <20241002001331.65444-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241002001331.65444-1-jdamato@fastly.com>
References: <20241002001331.65444-1-jdamato@fastly.com>
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
 v2:
   - Comments added to ena_napi_disable_in_range and
     ena_napi_enable_in_range
   - No functional changes

 drivers/net/ethernet/amazon/ena/ena_netdev.c | 28 +++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 74ce9fa45cf8..96df20854eb9 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1821,20 +1821,40 @@ static void ena_napi_disable_in_range(struct ena_adapter *adapter,
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
+			/* This API is supported for non-XDP queues only */
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
+			/* This API is supported for non-XDP queues only */
+			netif_queue_set_napi(adapter->netdev, i,
+					     NETDEV_QUEUE_TYPE_RX, napi);
+			netif_queue_set_napi(adapter->netdev, i,
+					     NETDEV_QUEUE_TYPE_TX, napi);
+		}
+	}
 }
 
 /* Configure the Rx forwarding */
-- 
2.25.1


