Return-Path: <netdev+bounces-129879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004BF986B2C
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 05:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A870B1F230EE
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 03:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B8A187348;
	Thu, 26 Sep 2024 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="U9OP4OLN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58317185E6E
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727319649; cv=none; b=NM3gb7Z7jIrd3cNy45bboINcyuRe3MsNVd2qnyrZAZfxmXhp3KCG1xxvnSsFqRTTPsv9NDUfWO/J04OjRgK3XtSHe2Uq/BZO1z0ONyHi1ObKqqtB2mJNj32euEDxRQtzM1gSX/pusOtW/ksumVvLTmaci2kuFQZ/GydlDRtwlOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727319649; c=relaxed/simple;
	bh=fOP1RW8xaYXgo6UAKNyyCaNdqYpSFEzAXlb1gulSoCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2Z5ISrnzIOBZ+J+iTjc2A3KGYr/tCsSs57UZHlrSgBDW4Pun1mWIeCq9feSFC5YPPJIfO6utQ0nFvPKNfcUNeV9tJmq86qV+groV8YiKq2NaFI6j+AZsLHXVCz1LfqHi7zIymoE7oksv8oMQIV4pOYXOtjKAqtoOv2+GquwFO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=U9OP4OLN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71b0d9535c0so391448b3a.2
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727319647; x=1727924447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Go4TL5YXIlZZjrMduyK+IYQM3hDPDoYu1c/gM7Xg4NM=;
        b=U9OP4OLNmdPKBCZkhRLl1Y8pWLWiIM3gNP6ukhz+HMKlPan5/Pw9RFUN8T1mrqbUxP
         m4R5jJ9sy2BH3PTGb0JKnyB1hOr9hOtBnhhQzBL3kNfD/AoRwvxG7nCfn8qS3Tn7X/5H
         RTi+8i2BsqLVicmXWiHl3jXjMJbfN0AxoPEz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727319647; x=1727924447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Go4TL5YXIlZZjrMduyK+IYQM3hDPDoYu1c/gM7Xg4NM=;
        b=O3uNNIdQGOAAgPXeDIhVAwGpwCi92BQViwC1jsw7GzVwExTVAHKuX/YCDj6C+2gU6k
         e62O0UdkU0NbG3FY9AJY4BpDvSBl/RjoxPQPJWneR/Z8nlLtRolz6GoLcWWrfMWN4uR9
         kkAl2jGQ7aasMN/ce+nSM9bnWktdQPqiq5P48litTMLIp4+dpuXsxiAVleC+7ihnsBf3
         2Zi6XMHToY84Q/5awTvU77kd5N78ZpMIN6/2Gacd0kMzx1R3Xo8uTz5lSBuZOj2P4ZXt
         uP8SDGn24LvMhdEERkQ/PksggG3oQwUvIn28WYsl2tI+32GGP55HcW8hHcwOp5ir8Rdj
         wHvA==
X-Gm-Message-State: AOJu0YyClmYFSTe+C1ywQPWgDtBCJGMF4E9yUXtFDMK7csh8k7Ykuawn
	XXMFjd68JMYsj2zJrDdxAy8LL7YcN4hPmTJhriVWnaTjpSHTQEU6r1FS/fmEZ9+/HgGKJ9c2mx8
	2XzvWcFeaKIle8aBQJEXCjq+5D3c2cstBRWkFnGEyzSjpzJs6/75uYhmsyHX3onvHb0oQusFh/L
	w42jUtMtbUJoAWSo4YQjucjQ/9YiTcLDLnoUY=
X-Google-Smtp-Source: AGHT+IHo/QvXYlAQpeWJb8WEqJxzH+RaMo6+alDlGBaUSCq3IFim3Y3CWxECI4I1FBHAIyJCrPXsJw==
X-Received: by 2002:a05:6a00:174c:b0:718:d94b:4b with SMTP id d2e1a72fcca58-71b0aaa22ddmr6704494b3a.6.1727319647069;
        Wed, 25 Sep 2024 20:00:47 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97c2a8sm3354111b3a.163.2024.09.25.20.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 20:00:46 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 2/2] gve: Map NAPI instances to queues
Date: Thu, 26 Sep 2024 03:00:22 +0000
Message-Id: <20240926030025.226221-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926030025.226221-1-jdamato@fastly.com>
References: <20240926030025.226221-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the netdev-genl interface to map NAPI instances to queues so that
this information is accessible to user programs via netlink.

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
			 --dump queue-get --json='{"ifindex": 2}'

[{'id': 0, 'ifindex': 2, 'napi-id': 8313, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8314, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8315, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8316, 'type': 'rx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8317, 'type': 'rx'},
[...]
 {'id': 0, 'ifindex': 2, 'napi-id': 8297, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8298, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8299, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8300, 'type': 'tx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8301, 'type': 'tx'},
[...]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 661566db68c8..da811e90bdfa 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1875,6 +1875,9 @@ static void gve_turndown(struct gve_priv *priv)
 
 		if (!gve_tx_was_added_to_block(priv, idx))
 			continue;
+
+		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_TX,
+				     NULL);
 		napi_disable(&block->napi);
 	}
 	for (idx = 0; idx < priv->rx_cfg.num_queues; idx++) {
@@ -1883,6 +1886,9 @@ static void gve_turndown(struct gve_priv *priv)
 
 		if (!gve_rx_was_added_to_block(priv, idx))
 			continue;
+
+		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_RX,
+				     NULL);
 		napi_disable(&block->napi);
 	}
 
@@ -1909,6 +1915,9 @@ static void gve_turnup(struct gve_priv *priv)
 			continue;
 
 		napi_enable(&block->napi);
+		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_TX,
+				     &block->napi);
+
 		if (gve_is_gqi(priv)) {
 			iowrite32be(0, gve_irq_doorbell(priv, block));
 		} else {
@@ -1931,6 +1940,9 @@ static void gve_turnup(struct gve_priv *priv)
 			continue;
 
 		napi_enable(&block->napi);
+		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_RX,
+				     &block->napi);
+
 		if (gve_is_gqi(priv)) {
 			iowrite32be(0, gve_irq_doorbell(priv, block));
 		} else {
-- 
2.43.0


