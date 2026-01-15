Return-Path: <netdev+bounces-250265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6A5D264D9
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FC37303A488
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B674C3BFE5D;
	Thu, 15 Jan 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSozIh62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66463BF319
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497151; cv=none; b=S9sd4cN/s7djbY4qjTgs55MmP5c3mPuWjiy3s1Nh4Axhm23r1uYAMJkSebHAQ+drImO/9xaCEbnMQy+fAI7vhFmiUHI2NW3J8rk/mzWGC92PDpFqP7zdNZoqVZ/97UVO8YOMDus3F9fCOXIg/gRLowJkUJ6ZPAIuEDe9f1vhWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497151; c=relaxed/simple;
	bh=42xckaESf3j1/c9BstDJDSEUMXBt7iNWBkDF/+HLvPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9EL1eMAGRM/nRe3yukQ8N/Wg6CwOOdVd0lhpdZQmNyxc4a9KYrTg/eQZiMFbQjtwVYFzTHdgJaVewIb1OMMDST6wKFuV6AQLVptpaMPU9E+4EpBU62cgZmCcNHUdj7Iv5CVFdKpYbPKQ9BAoDmLcif8w6cxOc8e+HgsU2r65LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSozIh62; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edffe5540so12299375e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497147; x=1769101947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzXTN5GPRXX9JktaEoAXzWi3s9VynOdluwYCuvOxVM0=;
        b=BSozIh62kZ+spfzWRT6eykR7HFH56OVNcsqeNDIdtpTNdnNiv+AwKekWffGvnKsAHV
         qggO678RCgaNXagQijZLaJXcvjglgpgq7Y1jMFOGQSQzPT5sc9PVXZiDbYtyzMM5fo0C
         tecW0jtMBzVUmgNZ0kilpejk/Kf79dYApfsz8p6CxEj4vEGyUVtiai/B5KC75TqtFEVI
         /dKyl/tXjKdiYRbYWWDIl17LI6eOPiqEV/sWWFlCHF1LO9Z8vSXyqNWG+ujyPfDeEZhL
         NA+I+XmH1rfLO+qBltZ3oEy4pCx2t6yk2SBEJ3P7jR6Vv7kzjv2Imae9gW/NU3Wlvuyi
         3CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497147; x=1769101947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZzXTN5GPRXX9JktaEoAXzWi3s9VynOdluwYCuvOxVM0=;
        b=jWXJHsvyMO7xTbpF8lnNXtH0VKPI7IBrJK4EKyJASTR2ESYUY35JAcuTles//J7e/Z
         A6gmkUP0fa11e/lHqgjMgtj2j+2/cSLMlt0ZvL3GIPj6Vy4n9Xvi07FIZ46mpZCs/psk
         VsLcmC0XxcJMQIAz3RbAWYJzRIPGBCfVQogTaY5gK+ZKGhaSDxsWk0vT5g3x8jkrilT8
         MX5uHYDCeQmMKvKPKqcsahyn9MioRv0OcEc6pIfKjUMmKbSgvGkfZB1Vqkl1buYdBP/o
         ZCT+P9TaM5j/8bcYsVeb4jB959BV4YD6lcjQ/OeqPp84NnlKydgfIQdUqjCdGJzzbRMM
         3xAw==
X-Gm-Message-State: AOJu0YyK78EfsIg6uISvnD/zy6N6TmiQWwWpZ0OMyBLuDp2FGcUj0Cd+
	SE/VhiYrYty7Wp7JtNMY273TZd0H4oIPlSMAHWJbziJJP06l3ju0u71BLLoO9Q==
X-Gm-Gg: AY/fxX6x+Cr01nXI4kbGYGDUs+uknC3wnzXfzlYitXf9WBzFOF2GegvAKAZ6YRRpUHg
	MeyvlV8zZRz2MTR6GOoGv1cBg+2fJpLwZrz18ThbwrNw2bJSVLzJlzS7PdXc+byimHUZRj75SEM
	Kh3C9ylKH61NRyWECjdqKqhmobpZGWMQGHfGhKQOGWUZz+++e0zUkXSkQU/QCkEMdbAMj1ZUnjG
	uiL39nkSxetdyvwksTTtQvwlutQ6uA1bb0gKSF11qW9se5I4JRFT5dXu0vQ28kx/F1CpVnuAdjg
	wHUvarj4WsUl9yrsw3deKw9RZYBEPMJGv36Tu6eDPVAZYmD4x+DStOFtVgW+feW1MqEjb10L7+I
	3WUAoAizd+udRbs/SV1wVSkBZts1Ffzc3pJV8tRHAwXObSsfd9ZlW05zd7XsiFOekyJmCSLUeE+
	HFILEToRC08pj4QsW4os7ypY3TJ7ynGW/HcOKnY66tL71IC9Ieup+JrX78oq+bGC8nGAOyEwEyw
	bRqpkJZQ2NEhoy+sMk8RN6eSC5d
X-Received: by 2002:a05:600c:3504:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-4801e2a95fcmr6718835e9.0.1768497146951;
        Thu, 15 Jan 2026 09:12:26 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:25 -0800 (PST)
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
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	kernel-team@meta.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v9 2/9] net: reduce indent of struct netdev_queue_mgmt_ops members
Date: Thu, 15 Jan 2026 17:11:55 +0000
Message-ID: <92d76cf96dcbc3c58daa84dbbf71a3ca8d9de53d.1768493907.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768493907.git.asml.silence@gmail.com>
References: <cover.1768493907.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Trivial change, reduce the indent. I think the original is copied
from real NDOs. It's unnecessarily deep, makes passing struct args
problematic.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index cd00e0406cf4..541e7d9853b1 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -135,20 +135,20 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  * be called for an interface which is open.
  */
 struct netdev_queue_mgmt_ops {
-	size_t			ndo_queue_mem_size;
-	int			(*ndo_queue_mem_alloc)(struct net_device *dev,
-						       void *per_queue_mem,
-						       int idx);
-	void			(*ndo_queue_mem_free)(struct net_device *dev,
-						      void *per_queue_mem);
-	int			(*ndo_queue_start)(struct net_device *dev,
-						   void *per_queue_mem,
-						   int idx);
-	int			(*ndo_queue_stop)(struct net_device *dev,
-						  void *per_queue_mem,
-						  int idx);
-	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
-							 int idx);
+	size_t	ndo_queue_mem_size;
+	int	(*ndo_queue_mem_alloc)(struct net_device *dev,
+				       void *per_queue_mem,
+				       int idx);
+	void	(*ndo_queue_mem_free)(struct net_device *dev,
+				      void *per_queue_mem);
+	int	(*ndo_queue_start)(struct net_device *dev,
+				   void *per_queue_mem,
+				   int idx);
+	int	(*ndo_queue_stop)(struct net_device *dev,
+				  void *per_queue_mem,
+				  int idx);
+	struct device *	(*ndo_queue_get_dma_dev)(struct net_device *dev,
+						 int idx);
 };
 
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
-- 
2.52.0


