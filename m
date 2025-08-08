Return-Path: <netdev+bounces-212212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20DCB1EAEB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8208158733F
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FEA2877CF;
	Fri,  8 Aug 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuE86wtA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB92874F2;
	Fri,  8 Aug 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664843; cv=none; b=iNeX5fl8P8e3PG27hfe46WbMdPhqDA06oBiVRvln5HGDxRy0/uXqRskmQXFc3MFGnluK6PVqojFFwTgpVmYH0/+GW8ycXy0dgiLumtAIuuzzObCvfPZc6NGw8KRebuUpJ2KkojahlTt8dKGFShYdsvd++cr9YpmxCLLykdsu4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664843; c=relaxed/simple;
	bh=ADoALMUp7fRNmGA7whVIBu9VpV/nZGLKu0ACIB2JHMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQoElfm5LGOZbvESx2SoaORzLN1aqynJrAbzvDxQ0onDPBKy10ECVPpQ17j7G8fG7yk0The4zP48Enq4Q9w5zzdOTZHMcItQkH4zu7oiPPAfZMECVU1bMZLA6SEBiww4VBrHFfZmJ7MDiX9NNY0ltJW6KtHl4cXayLQAetz54R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuE86wtA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-458bdde7dedso15575205e9.0;
        Fri, 08 Aug 2025 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664840; x=1755269640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaV3RdlXTe3r7U2reA57SXP5kTrJY9JzfyGOVcNFU1E=;
        b=DuE86wtAjdVcngRKZAcgZwNzkEeMWr1oT1SvoX/JIgmNnujsMR4O0fWLFzQtMk5FhU
         NZrBPXRI4Aejs0kPRu+M2J5lkgPcPJFYMQS9oG/fgWiINHd231Y8Wuq67sANcpTApedp
         gXVQcvU1MCEDt3/+eg2okWT8QclS7P1X/9CeEdt+VSJX8kD27SqkPjSGCepV1/9ZaU7t
         AI56aT/KcDo2lOxufh57+vxlBjOWYCW+ydnDWnomJVZZyoNfjsF1BTMYW0VpomPmztVB
         eQKwK8Cxy9gJZ1AJw2i1HRoP+UHb9rntBFwtTTV8ZTPvEuY+PeS3ELzGHy9nUqDTL9tf
         pX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664840; x=1755269640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaV3RdlXTe3r7U2reA57SXP5kTrJY9JzfyGOVcNFU1E=;
        b=IbXXaiK7+gmkpJKxzgZDIq5w/VKAQCO37pV6GvTfJKvBq9X6TJbS26ZBSCdl2SdYYN
         +oC9xtm4XPCc8F5zOKnqzxo+M7qo8sH8g+BcOMa1YcWLhXNaa8tPyg5RPgfdVQVgpxaU
         enP25xNDJG4dGiPMr9xDGy7+qmzllthCo7xnDxn+3xeQcsc92/jlgZlGkqg0OeLvwExO
         an4kS4j91j+Oqgbucg+ZULvSm5dfR0/sordMqInREgMJbRhWDX9Ejs76ipp8VqvmTPtt
         udbQYgB2OQ3Ck0RiNE35h/6TQVqER7dWnUU3/yTHICpTkfohkmmigCXtzqFqLP51a3FM
         0RAA==
X-Forwarded-Encrypted: i=1; AJvYcCV+PQrt3e+HpXlgh598upRTWDpCNe16aXVzuNjP1XGmOh9vE3x4eeamJIrCfj2N9G03yZKXYHiot4vgjCM=@vger.kernel.org, AJvYcCXbAkVUUAeAunC2AwslH+yVXc+nb06h/LxZvW7FOJPk7IvKjZxIz82uUovA6IlQg44Itjo9+uS/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/exygA0MbVUkdzo4jSFYWGYkKO5rFQ/3ktyl00IewoUni2ILA
	0qKyuYaeNM3mFCW9Y+tZNhWMYa8jDAWquviDsKoSsIQsdkjZWDEjC5Ak
X-Gm-Gg: ASbGncssvmGQ89yua0pYpwuK/fDjKMZNNsJVKfXpeIwZpUQZb0n2s3SOeqgZDPck62i
	xhkdNkHldWkWN8RhmoShHLQ75UY1/qfoQhXLjrNfoGNyeHZel/TT/C4QD0aAUOCCjtouutguNun
	8vgo6Ddo/lnySP0olCh3oUGX8ZDBFqfla75uO7thywgkasdq7w/1XcpmHJyRjL+yXZo9plLhAaj
	RT5wMFHX2S8ehkw5yhLlTv0xyucP1kfXI6PJq2qVKT6JwoqfnEhmQnF5n8tp2Q3SihiZ0yGop/A
	lVSaq4MnTUR/aBM8Z3JVnowCSnoGtGmJtmeL96k3mtpAQQoXbdoj+4Z8kSo35ck65fo7oBJryjb
	QHTh/vg==
X-Google-Smtp-Source: AGHT+IFD7ZsmtJWlFZtRBXjllQqaAnv6JmGIuTLPYErHs8aEV8uLdL+NONIxlndsItLX06tqkVfUWg==
X-Received: by 2002:a05:6000:230f:b0:3b8:d1a4:bacb with SMTP id ffacd0b85a97d-3b900b5118emr2786143f8f.42.1754664840226;
        Fri, 08 Aug 2025 07:54:00 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:59 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 19/24] net: wipe the setting of deactived queues
Date: Fri,  8 Aug 2025 15:54:42 +0100
Message-ID: <e4c628552e9d19c7cd8553e5031db64bb046eee9.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Clear out all settings of deactived queues when user changes
the number of channels. We already perform similar cleanup
for shapers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/dev.c           |  5 +++++
 net/core/dev.h           |  2 ++
 net/core/netdev_config.c | 13 +++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8e9af8469421..01264c284c84 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3188,6 +3188,8 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 		if (dev->num_tc)
 			netif_setup_tc(dev, txq);
 
+		netdev_queue_config_update_cnt(dev, txq,
+					       dev->real_num_rx_queues);
 		net_shaper_set_real_num_tx_queues(dev, txq);
 
 		dev_qdisc_change_real_num_tx(dev, txq);
@@ -3233,6 +3235,9 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 						  rxq);
 		if (rc)
 			return rc;
+
+		netdev_queue_config_update_cnt(dev, dev->real_num_tx_queues,
+					       rxq);
 	}
 
 	dev->real_num_rx_queues = rxq;
diff --git a/net/core/dev.h b/net/core/dev.h
index f51b66403466..a33d8a507bed 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -101,6 +101,8 @@ void __netdev_queue_config(struct net_device *dev, int rxq,
 			   struct netdev_queue_config *qcfg, bool pending);
 int netdev_queue_config_revalidate(struct net_device *dev,
 				   struct netlink_ext_ack *extack);
+void netdev_queue_config_update_cnt(struct net_device *dev, unsigned int txq,
+				    unsigned int rxq);
 
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index ede02b77470e..c5ae39e76f40 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -64,6 +64,19 @@ int netdev_reconfig_start(struct net_device *dev)
 	return -ENOMEM;
 }
 
+void netdev_queue_config_update_cnt(struct net_device *dev, unsigned int txq,
+				    unsigned int rxq)
+{
+	size_t len;
+
+	if (rxq < dev->real_num_rx_queues) {
+		len = (dev->real_num_rx_queues - rxq) * sizeof(*dev->cfg->qcfg);
+
+		memset(&dev->cfg->qcfg[rxq], 0, len);
+		memset(&dev->cfg_pending->qcfg[rxq], 0, len);
+	}
+}
+
 void __netdev_queue_config(struct net_device *dev, int rxq,
 			   struct netdev_queue_config *qcfg, bool pending)
 {
-- 
2.49.0


