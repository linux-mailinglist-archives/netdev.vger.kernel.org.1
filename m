Return-Path: <netdev+bounces-130624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513198AEDE
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D898A1F2144A
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C6B1A2C12;
	Mon, 30 Sep 2024 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jwdGHszC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F01A254E
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730479; cv=none; b=EC2MONxrsMAXWHKeVhJmrsSWvva9JryKSCcXcKTxPqRv0cDng+Qu9+XZ43YscBlKXmxCCH2TBO2FmpGyQOxb5pmnTyYnYXCJuXlh2V8WdvNOY9V2NJP9bOauAufBZ3H1dXcTRS0FFCImnBoqInwa7e/f7gTQkwS+eQr0+ofMDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730479; c=relaxed/simple;
	bh=5pEd4BRaR9Lunjg0fDKMGKtOehrFlWLLxYni9JjSKGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJLBQHDtxrJtq/Ia9v4Gq9s/By8T4ltzRW/8khL6cJSm6YceEiWQUx3uHbZfU8HSaGdsPYOyGWTbVoEMzG6pBqTXFJ4MTH432TrUxZCLwu+hlTYeioaYDaxoZAK2b/ub4O3BayIxR/NKg9qbYBrK5iK4WloZ/AU77N2w4QnHpek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jwdGHszC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e137183587so1002980a91.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727730476; x=1728335276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qhy/eIcYUU/FYB8Yva0fnrqDzEaqYHdkFo8c9EaozE=;
        b=jwdGHszC087tOTQT6519bxEiz856IjJ9cigfGgLCzsr0RRaao3t3xAqmB6Un+OrAtM
         +NEhywNrcpNkRPR6GwLx+Q9XmbuIpjtdCBgAi8uyjHi3tjq06nXpZX7IyAPb3ros0Pt0
         fY5zC4w26pAbobG1YC76HE3n9R/7oHCK5wAlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727730476; x=1728335276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qhy/eIcYUU/FYB8Yva0fnrqDzEaqYHdkFo8c9EaozE=;
        b=ZJUaSfnHTzCBnvCAND5Ig4lY4uv9w67kHvZSezTX/ZCkw0wkOHcUR9kEfyIZCVW4+O
         zYOG/qbh2Dl5ZGJvQMcFulIE69rbS9vKeKFFXYJToAyRgICJ5sWUfPcOkJmotUliaZXm
         UMJQtLK6Si3ckPW9IgBGvYnFpai992php6+Nu+Vv6sz2U/NbvNScIG21XGuIOzjWT1eF
         +AUoEc1OgPAI6gHmDgBV0+B0CyDz3+ew+IRiF1pA/3vSsq088/V8mk8hB4H1YTLdJ2Wa
         QCzGL6X2WllT6LJv2ytDTTQUQ8TLrs+6CC+64cI2lmCXmBpslhQDjvb2heasUhKQ0bnW
         EUPw==
X-Gm-Message-State: AOJu0Yxj7ENBLbHT4ovLdv5jZ4UMypcycREYDevxHTUUiQKuwJx2oM0T
	FdjZcXd8lljXX1ZTqgnIc9THIjLO5CEhU8JcsVbXwhwdsqlUZovNvH+4fmYDgO2bcKluwAnZu5k
	xroQCWxrIjZ76WEDLoze6QEm5XbxhX5G4K/PlzPqwQGHX29azx7BAMevCN1kVXqABzElg8gqUT3
	wjuxfaClnBq8QF/tyGveZQwEHzQ6Oqvo4EHcrSaA==
X-Google-Smtp-Source: AGHT+IH12d57PmNt5MTcpHoZ629eFxcezgIbQ+59xZVEm0Nj3wdAa46Bm1xaik8a9mc6BNhrGvWnJw==
X-Received: by 2002:a17:90a:df0e:b0:2e0:a508:77f2 with SMTP id 98e67ed59e1d1-2e0b8e97ec3mr15745448a91.25.1727730476275;
        Mon, 30 Sep 2024 14:07:56 -0700 (PDT)
Received: from jdamato-dev.c.c-development.internal (74.96.235.35.bc.googleusercontent.com. [35.235.96.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bcddsm8427642a91.4.2024.09.30.14.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:07:55 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pkaligineedi@google.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 2/2] gve: Map NAPI instances to queues
Date: Mon, 30 Sep 2024 21:07:08 +0000
Message-ID: <20240930210731.1629-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930210731.1629-1-jdamato@fastly.com>
References: <20240930210731.1629-1-jdamato@fastly.com>
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
 v2:
   - Check that idx < priv->tx_cfg.num_queues in both gve_turnup and
     gve_turndown as suggested by Praveen Kaligineedi

 drivers/net/ethernet/google/gve/gve_main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 661566db68c8..294ddcd0bf6c 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1875,6 +1875,11 @@ static void gve_turndown(struct gve_priv *priv)
 
 		if (!gve_tx_was_added_to_block(priv, idx))
 			continue;
+
+		if (idx < priv->tx_cfg.num_queues)
+			netif_queue_set_napi(priv->dev, idx,
+					     NETDEV_QUEUE_TYPE_TX, NULL);
+
 		napi_disable(&block->napi);
 	}
 	for (idx = 0; idx < priv->rx_cfg.num_queues; idx++) {
@@ -1883,6 +1888,9 @@ static void gve_turndown(struct gve_priv *priv)
 
 		if (!gve_rx_was_added_to_block(priv, idx))
 			continue;
+
+		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_RX,
+				     NULL);
 		napi_disable(&block->napi);
 	}
 
@@ -1909,6 +1917,12 @@ static void gve_turnup(struct gve_priv *priv)
 			continue;
 
 		napi_enable(&block->napi);
+
+		if (idx < priv->tx_cfg.num_queues)
+			netif_queue_set_napi(priv->dev, idx,
+					     NETDEV_QUEUE_TYPE_TX,
+					     &block->napi);
+
 		if (gve_is_gqi(priv)) {
 			iowrite32be(0, gve_irq_doorbell(priv, block));
 		} else {
@@ -1931,6 +1945,9 @@ static void gve_turnup(struct gve_priv *priv)
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


