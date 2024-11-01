Return-Path: <netdev+bounces-141124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A939B9A67
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 22:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F601F23E07
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6A31F4FDD;
	Fri,  1 Nov 2024 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVtAlPPt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F031E8836;
	Fri,  1 Nov 2024 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497716; cv=none; b=ZBXd0mNYSHEq3zdgbzXFQVVa02BXqINhRUcixwUotIR88rztFrt8pF/hLJcTGcK/RrY5sfrWL949EjzNzfl5zFFE+XWNdqbwbn4CM+nxnZjFRskFc/Ry//9xevIveutldQt+s0SLWLl4KnlijUyUCERB7s9qnMWgsTrQHlE3xWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497716; c=relaxed/simple;
	bh=8sXedxHOlW4bDTZN6PpOHgHvpLJs9HJzgWaAyncbOys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2BMpL4ciVhn1vyusYvT63a3tmmympj9PgUuemzxvIYk3fIz4pkbpnM9kTwuqZx+eo8sAk8teytp8YZhtFj85teGJzjU46e48Ht1RnqZllNolIq5lvaSNIFpJMTEt2JFCp6R+0ospztwLGUEFndavgoNVMtWaGMoRgNg/JkGYvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVtAlPPt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e3d523a24dso1943367a91.0;
        Fri, 01 Nov 2024 14:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730497714; x=1731102514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR67c2FO6ibNJTIwnm+5i2JwWxhhER/sw1jRuBJAxf4=;
        b=JVtAlPPteyywim0l2R5A33Scgz4pvzqGMizMP0cwTIXUrfIyExgEvja2B+eU9vBJR6
         entra85TWAn93JKSjiN3JSijQ3cmzzKZUcQ4a1An5nXYAgtIt8kw99f/loJ6qv4GvhHp
         HMtmHjcleEPy5oxZOzi82KxJGthtzptS9xStCJjc/mqgIv+/OQJTgECH89eb6m+Tf/dt
         xBG/SAr1vT45dX3seHxXFCxR2f7Spkjz5XDFdNdBz4nUWmH66f982U3mewjtBULNmZcu
         FXcPhwx5WzucemkCB2ChH8ZoG7Rf7JMJi9MmtYDdOodG5SyJ1IROQhQ4T56/HweFGilJ
         GFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730497714; x=1731102514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GR67c2FO6ibNJTIwnm+5i2JwWxhhER/sw1jRuBJAxf4=;
        b=FGjXs9/SnFm9dced+rRGoNrHShCylOhlhfd5IAxq+jQolW5kmQe0vGtABBPLt5QQvT
         XQ0rD25ymOfv4G6bKCCk+YjRhatFjIvSWdeSbgnvAHEtiVK96O1qDYk7gY8g5uuvo4vZ
         0QWIO4EGT/ttCeqUz/I5fAD/pIrm8pBOI1tdloZvEefwlStb+vYydGNGiHHDQZbTnC/z
         G70gRwwNvCNVq/b31EFGqBHMp8C9jzRZ1Kkdb/PMM2/pHFSzXI7Dt5bCvfDsHKueiCWp
         +nc3GiGqJMjcK3mBy9erLX4fwV+xAlIjFPUuBzufRH0g3XZTOeCMOIJgXT4e5HN/yaw7
         6t5A==
X-Forwarded-Encrypted: i=1; AJvYcCUctaKxB6hTrrUwsJbgtw2ARKCLNL/MRuryBnxuoFmNgc8c85EW4E2/FRqPVcOpu3E0YNj8UawOd8FbHt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47v+uxiyu0/J9EsCsunqLM1U1aL9Qd1qJ0Cmm0Vj/IinnkM+J
	WaoRUlaLJBFRW3D+Bd6wNR3jqdx768N9wqJ0dOec+XlfZg39TmCmGA0wgLkn
X-Google-Smtp-Source: AGHT+IG+Tpr9D9Z5FljOzVS3fMUx6zOGqMt4YAjpCfoDMRjEQO5vIjLgvCHtBA/MI9+sXWU6IRAmwQ==
X-Received: by 2002:a17:90b:17cb:b0:2e2:c835:bc31 with SMTP id 98e67ed59e1d1-2e8f104ca34mr26742401a91.7.1730497713706;
        Fri, 01 Nov 2024 14:48:33 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057cf273sm25120155ad.239.2024.11.01.14.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 14:48:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] net: ena: remove devm from ethtool
Date: Fri,  1 Nov 2024 14:48:27 -0700
Message-ID: <20241101214828.289752-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101214828.289752-1-rosenp@gmail.com>
References: <20241101214828.289752-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need for devm bloat here. In addition, these are freed right
before the function exits.

Also swapped kcalloc order for consistency.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index e1c622b40a27..fa9d7b8ec00d 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -1128,22 +1128,18 @@ static void ena_dump_stats_ex(struct ena_adapter *adapter, u8 *buf)
 		return;
 	}
 
-	strings_buf = devm_kcalloc(&adapter->pdev->dev,
-				   ETH_GSTRING_LEN, strings_num,
-				   GFP_ATOMIC);
+	strings_buf = kcalloc(strings_num, ETH_GSTRING_LEN, GFP_ATOMIC);
 	if (!strings_buf) {
 		netif_err(adapter, drv, netdev,
 			  "Failed to allocate strings_buf\n");
 		return;
 	}
 
-	data_buf = devm_kcalloc(&adapter->pdev->dev,
-				strings_num, sizeof(u64),
-				GFP_ATOMIC);
+	data_buf = kcalloc(strings_num, sizeof(u64), GFP_ATOMIC);
 	if (!data_buf) {
 		netif_err(adapter, drv, netdev,
 			  "Failed to allocate data buf\n");
-		devm_kfree(&adapter->pdev->dev, strings_buf);
+		kfree(strings_buf);
 		return;
 	}
 
@@ -1165,8 +1161,8 @@ static void ena_dump_stats_ex(struct ena_adapter *adapter, u8 *buf)
 				  strings_buf + i * ETH_GSTRING_LEN,
 				  data_buf[i]);
 
-	devm_kfree(&adapter->pdev->dev, strings_buf);
-	devm_kfree(&adapter->pdev->dev, data_buf);
+	kfree(strings_buf);
+	kfree(data_buf);
 }
 
 void ena_dump_stats_to_buf(struct ena_adapter *adapter, u8 *buf)
-- 
2.47.0


