Return-Path: <netdev+bounces-242853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDDDC9569F
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 00:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29693A283D
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 23:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578DE301010;
	Sun, 30 Nov 2025 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOK7YvSz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0FC2E542A
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764545742; cv=none; b=pwdCLZUexZvrf3Xh8w+dU8hmJOOCG/7FhTj7VRNNuMm4rW2Z3oYq2xyWAilIq6guQazPRkc5+Uo1qPunYhi8sBqWJQDKkfTQwXLYQRpxdQWJB9E/OcrzK0ElIpKu7ScVGXzIWsPjEbMMKntNfFXuBzutB4fe1Nh4JrVp8lDPyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764545742; c=relaxed/simple;
	bh=OGKzBuKu9HnGjv3V2KIOUMpBLQDNN5wbAGzT3ICtN0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vbk/pjTaG7WUWS6O0I4g7B0PT2bSL0WZYMXyewvuwMQ4b7zBzxM5ffOJgtMfVQkFOW31v8gpiszizvwx76vHLjZSsIuci/FNdYk4e/nQ6PjO964Dvq3lJkXs7uKXEru9hA85GIeQM0l3UfP8Cp0Rp0zoHyq/jFafr3bXGHQi20A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOK7YvSz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so31107235e9.1
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 15:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764545738; x=1765150538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Etzl3qXtEXxRUk5ZEMYr8GzSvCBjbQ/vWysP4cG19PU=;
        b=QOK7YvSzRpIM3bmocDTZSTJZ+AT8aIuEJ68zb/9IfM3EH8n+V3khm6fZ54vC6Yeg/d
         k27s32TTV9aqixkwBGJzPzJAgPR5m+Ln06/MJXEfNWwAP2xsMAPJaPngIyRIbYmUhSoF
         yhqSGo5Yw/mUTf1bO0IsrT1NapU8git1uef7ourInA0Zjb56atcsEq7D2tRD1syPvo7V
         ZQIZ84sAONRc5byf3x4m5Vfkgjx76wb/k3cuP5/N/nhBS7thhug/gLRKyVycUBxiSjOm
         67tCPQtPsZinagA6YJzGB5kInMI1PRxiTCe886LOiKyTD5xeniNRwhInzQnPKeVL6ei/
         ZwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764545738; x=1765150538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Etzl3qXtEXxRUk5ZEMYr8GzSvCBjbQ/vWysP4cG19PU=;
        b=lsJkCoRa6rzCmGjbSL9N4K3MvYJiVvxnSgjm+fKZ3RFM2vaFkDQxPJVQZsW4rhCGCT
         ter5FoMK0ifY8IuZQXLRNwwu0H899EyU/0GeIkYsS/7pPtuH+F0Ar/XRLl7RwLA3d8Ct
         G/jbdbuEmUQcSaJHuTT1w1rlcwX+SvgB2DVQhv0oV4S8EA3nz3C2dtrZQMHaelPiAiO6
         DPXo7cx+P4m+4gvRm+mSTc20acCwM9iNEvevCjKQMt95U3WpVhR8Fl6HleSSc7gam5OU
         LbdwwzZFVUD+SotTYAv7My0Tyxoz5tdQ7rB5bLSQiWFoIe7+zEcEJLU0ceLImEaGlK4Y
         i9aA==
X-Gm-Message-State: AOJu0Yyd3VYjYeGWJp/FxdBkcqTjpBFA7k+hye/EW9HjEPWg23a0cFZk
	wCakjKo+leZ0AsN/i0gNHL9fp2habJRsRXWYSKr0emQIzpPWKaukvAHeG/wJYA==
X-Gm-Gg: ASbGncvj3ajXBIHF9nTuHUVTD48W2chFRnGDrETbKDJVC0AHS2KydcznWCXAOSDBuw+
	rXHNHDrCYa6hJa3D90H7ihYOjIDzNwGNj5I2sywl6sTYePlQY3Q7SR0l0tv42NBJER/fE3Y8UZy
	0QOUKMQy3hNePSfv9b4WMQz5JmZraL4A5s9EMT2yWywPRUdUbRLZFfNbAdcow+DePGDeY8N1MmE
	hY2LAjQq63iTBC/yGJ0p6rEc7ViIQfep1OFoHfw23V06/N/bJaa2G25s7XDyPpWOFmP7ipRgLXB
	JBtqrTDCC3GaZLJc/pmx/ux6a9af7SPU8hfAv1o6cb1tNRqf8BIK3SOc4WUd6Q8B1a6fD2xf72p
	BZerGp0ea2R06tnIiOzy/sUPRIwkUkslCK8MnvIbrM++eRgvhZ2wDDpZ/PMn6s737Edb4215eCA
	/W1SDq/FvxA/OElzLyxWUUrgB9Ic5clwDvRzBU+GeR4pmz2bjFfbmMkfREFD6bnvgxqAfLe5rS2
	R7z4Iss24Sy3vMM
X-Google-Smtp-Source: AGHT+IGIUBkKFTjVVCw8JO88WO04GjOPBXSs8x48lo+BhVoIg3ql1cUd33a7wo+Dz7e5cUTvz/0ZMw==
X-Received: by 2002:a05:600c:1c1b:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-47904aebebdmr257224895e9.14.1764545737736;
        Sun, 30 Nov 2025 15:35:37 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040b3092sm142722075e9.1.2025.11.30.15.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 15:35:36 -0800 (PST)
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
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	David Wei <dw@davidwei.uk>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com
Subject: [PATCH net-next v7 4/9] net: let pp memory provider to specify rx buf len
Date: Sun, 30 Nov 2025 23:35:19 +0000
Message-ID: <0364ec97cc65b7b7b7376b98438c2630fa2e003c.1764542851.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764542851.git.asml.silence@gmail.com>
References: <cover.1764542851.git.asml.silence@gmail.com>
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
index cd00e0406cf4..45c1d198f5bf 100644
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
+	unsigned int supported_params;
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


