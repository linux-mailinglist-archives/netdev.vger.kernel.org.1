Return-Path: <netdev+bounces-242401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD42C90252
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290D83AA06F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F43631A7E6;
	Thu, 27 Nov 2025 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsilw5Za"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D074315D23
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276277; cv=none; b=HdP/ZA+gRUfinxS6NSF5WuQXKHwzpLuJgfJaExuXKWIhVhK7HIrFQkybN30G04gZfBYEG2WIFs2iP33galbmmDai7hbCQbuWllI2Yb/ZPDw1/7WZH5E6BaY+0R6IH2eZJp+PnB02jgMh+PNMad44dr7/hNcsz2mwFJCLAf4l9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276277; c=relaxed/simple;
	bh=YCXiESmxDru16OuSBpgWKD7MLSgAxyhCtNWm4oA5/Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7z6CjNhHSCX29iEmT0NoBAX7DLaQhhd8dc+KvKiFHMWfn+YCKU+00Gany4970MjLq5aOOBSTncSzX712nLxJlZHaArgD6x7OM47/zvC5Tmwo8+7/1Q664XAjopGFgQ4MIUlMt8yEwmtk2IIfT9UtHY1MRSFShbmYGDQYKPZtz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wsilw5Za; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso5046775e9.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764276273; x=1764881073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxF93ks89kapv2UHbHs6Gp6gp3EbwDOqDtHBuiudG8w=;
        b=Wsilw5Zal1PwTwqGdBy/ll/skI7gC66j41e12RvZYN1jEEMB1b8w+emjzdf1qSEiAb
         NLU6TFQCMCoqAJYP529iwMT/InyNiFJlsKMzZ1dY6CbCQ+f3wAco//3/HoJgL63ewSqC
         bXzohjdK6eGJxx1571k0RQ+4QEyqAAfRVHcyDaq/1AF5lk7xn01A/cleYxiMDcDfes+s
         RKE624d5ixtc/gb7FJ7xKBEezyrdCwszyFCDab7mh6GDNSIJCQyUuB6WnZf+wq1OxFdL
         e28L1CCYA59ryqWeTQA2sacgIOrTGtoujsJlvcqwDIJxUAmTDyLJxGrdxUz/Xd4amzPf
         jhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764276273; x=1764881073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wxF93ks89kapv2UHbHs6Gp6gp3EbwDOqDtHBuiudG8w=;
        b=K7lFpBm6crOgEyDZTa1TEG4w+wYz6NL+TXD/lMDuVPFgs5fmt43HetfwWuirOwZ3nk
         XowfVsDWnahK0vhZ8rdLwHWBW6vxLymFtoTz0BuSLySZxc6us8IHKMjdfF44yH5eG+6/
         NUpN+hbT/NNolJmwJphcpxb8GR7fLkc0KbOivD2Sndg9kxf5/rBcOZw4wAj3QLPQxqT2
         BwP3o49YpLnIEZTD1qOvFG0s+2kjnmcwO3MFzm0FAXJqwb4xyjrAGvAYtztoq/csZWmH
         tZME2eitdFvRviXLAdlI/brGvgmTFJPOT18MKjtEB0bgjaY4qdEfapkT9phIGohxkZbV
         qx4A==
X-Gm-Message-State: AOJu0Yx2B6fZ+cyCFE9048rtJTaMowoMKxk7IK2rWb2jZ2RpTpSNi7mS
	FGUvf/AjXku8Gpclyj+70kW7EZul1tvKna6rE1W0s+MshMzTxP7E/H1tvyB0mQ==
X-Gm-Gg: ASbGnctwtOi1Ggftsg4WOKSv1eNVrekmSp5i/w8vVTVEsdzfjvynYQqVL8Mk19wGyne
	9hEvSJ5maQBLYepp0Fb9JCDb6mkQJ48BqgEnAZiQYt4SWTfGITCsLXckpxsqLqpKwVyjmbRt3gi
	CLiPngarCGcfbTB1j2fpcfLPVWLJC6TrlDRovt+Ahnncl8/yAX8VOPq9E+KBACwOQ5SAxPe5KaZ
	vcrZGjZlMVPHoPQI2aiSOPS3eC4/q869oDydQ53HIDKSYWhhfgQxp3NiN1gZJRylnp/TgC4yM+g
	hOX2SbUOcJMuSClXCLay8wlxEQyPPYgcocwT0K3NoJc0vJ1OTbS918S4i9lS2aefPnBAJjJ/Kl9
	USs4fLQjRGKxZwl+09H7Bj9ismJbtLDjM4SCajXjc7lrr/OHbtmMECR2lEPnBMiAHD5OrL4jUQc
	1g/uZTVgWGWP+UYg==
X-Google-Smtp-Source: AGHT+IH1GkgX0eRSxmMDdZ7g/7AgTv8fnG0KEnbsq0aEMjYefG8hJDp/+kuxJRcP57+KR5Klf3SUYw==
X-Received: by 2002:a05:600c:1993:b0:477:9392:8557 with SMTP id 5b1f17b1804b1-477c01b495amr240147615e9.18.1764276273164;
        Thu, 27 Nov 2025 12:44:33 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d614asm5346105f8f.12.2025.11.27.12.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 12:44:32 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com
Subject: [PATCH net-next v6 3/8] net: let pp memory provider to specify rx buf len
Date: Thu, 27 Nov 2025 20:44:16 +0000
Message-ID: <9cd0f777a19d4b71bec1ee36d3cbcab89083ec47.1764264798.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764264798.git.asml.silence@gmail.com>
References: <cover.1764264798.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow memory providers to configure rx queues with a specific receive
buffer length. Pass it in struct pp_memory_provider_params, which is
copied into the queue, so it's preserved across queue restarts. It's an
opt-in feature for drivers, which they can enable by setting
NDO_QUEUE_RX_BUF_SIZE to their struct netdev_queue_mgmt_ops.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h   | 9 +++++++++
 include/net/page_pool/types.h | 1 +
 net/core/netdev_rx_queue.c    | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index cd00e0406cf4..2e6bcec1e1e3 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -111,6 +111,11 @@ void netdev_stat_queue_sum(struct net_device *netdev,
 			   int tx_start, int tx_end,
 			   struct netdev_queue_stats_tx *tx_sum);
 
+enum {
+	/* queue restart support custom rx buffer sizes */
+	NDO_QUEUE_RX_BUF_SIZE		= 0x1,
+};
+
 /**
  * struct netdev_queue_mgmt_ops - netdev ops for queue management
  *
@@ -130,6 +135,8 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
  *			   for this queue. Return NULL on error.
  *
+ * @supported_params: bitmask of supported features, see NDO_QUEUE_*
+ *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
  * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
  * be called for an interface which is open.
@@ -149,6 +156,8 @@ struct netdev_queue_mgmt_ops {
 						  int idx);
 	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
 							 int idx);
+
+	unsigned supported_params;
 };
 
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 1509a536cb85..be74e4aec7b5 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -161,6 +161,7 @@ struct memory_provider_ops;
 struct pp_memory_provider_params {
 	void *mp_priv;
 	const struct memory_provider_ops *mp_ops;
+	u32 rx_buf_len;
 };
 
 struct page_pool {
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index a0083f176a9c..09d6f97e910e 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -29,6 +29,10 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	    !qops->ndo_queue_mem_alloc || !qops->ndo_queue_start)
 		return -EOPNOTSUPP;
 
+	if (!(qops->supported_params & NDO_QUEUE_RX_BUF_SIZE) &&
+	    rxq->mp_params.rx_buf_len)
+		return -EOPNOTSUPP;
+
 	netdev_assert_locked(dev);
 
 	new_mem = kvzalloc(qops->ndo_queue_mem_size, GFP_KERNEL);
-- 
2.52.0


