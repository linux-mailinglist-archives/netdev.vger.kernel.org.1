Return-Path: <netdev+bounces-92282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC2B8B672A
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB311F244C9
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 01:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F055205E2C;
	Tue, 30 Apr 2024 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="M4+/UcfH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8381843
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439261; cv=none; b=aEPI9F9DQOCy/Fp576BmTLHfug5W2pHco1kKbJqqn0ja9ZVhxWFuA0AOhmcByVBiHrUHoBn1dyMGkwxY3CPV2XrVKEyaLn2dfk+PSv/Bam9HBzDtlSm1NXhAUVB5d4efkOXmKxlc4fy5PubuYiRxuwGaKmYZa6FvvSeZVDtbRXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439261; c=relaxed/simple;
	bh=hRahC05qUcU+0m0eSOW1zph58fnDiIqsApDhJ09ygIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpun5QzT1Iu0BlO8YLsOCmet0XitKx3MT1cyl6ux5CXr5z1+DLnf3UmdLf4IFl7kycUHbUZo3bUkGPE9FvZzWyaU59uKvO4mohq86Y1Ir9gKk2qMeMCb6QXnUDzbeK1Br3cyO87Cnylms3RtlxB0ERlV9JUFLaVY4pJ0nuDwgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=M4+/UcfH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e834159f40so41235785ad.2
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 18:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714439259; x=1715044059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA3wBji6kXO1gvhc5WiOn2jpTbW1Zi3NyOiJx7qmGsk=;
        b=M4+/UcfH2Y26qd7/gSc5OIbAyKr+LeFsDKxCj7cvd6b6ZZ/KMUZIj6mVbd39KO7aL8
         fwqKSRb5E4kHPejLWN4rTn2cCT+1cN5mQK0k7O9QzIxy5wGP79h8dPKA6HMqWt3/1p4w
         uLESFImQAK1e/CymQU+zC0MVVJUsvZGjZEpkYCGLMBqpuyPz7DbuV8Jhs57Y04oC4mVo
         0Lth2jOi1ddZjBXw9MMqs/1WMI1kPHm452MDrhkJpcBmF5ZGkbmGOXhPlZTcb6KGkWSg
         R2luTVGCyl+y4VfY5wldHWmACDRH2JHGF8x4zoUd5jIHfHCLiczUIqDwDtIxIP4waFwF
         jm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714439259; x=1715044059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA3wBji6kXO1gvhc5WiOn2jpTbW1Zi3NyOiJx7qmGsk=;
        b=E4p/Z7JbH3vEpOwcsuboR+H2PvD9xMezGCu+0F6m8KtLjkB3W7Gglchv+Kd75rGoVP
         gHCspnRFXnM9NrXtWcw3LhGbka8WXfNYYc3znzVGuyjNgaRgODfHMOTAIdj8xnl7M8Of
         dDItXi1cyNbz9yEB/yJjzVNcGh9nOxRdGqxoHiQVVvFwntkr6igTvKXRxRdaohj3L1El
         RcwoVoHy1vTkk4XYYNTzSN9RX5yL3LGRJsT1KAf5LOX3VNYPV1iNG4n8ArEd6Ef18rY9
         xRBTg5pYjnTEKjg/9Ovk8iQ5yjicj+1d5bx5aSkWY6aFavfSH1cIYrDA4Svfqd3EVqB0
         p5VQ==
X-Gm-Message-State: AOJu0YzUU9QVF0fNJNUKTuK7sk2Bt2aqPrCmAZZZEVOaKb0uSyeGW9O3
	Tm9x2U6JrN1XzEQFRReB4bz37vCmgBt4MHU3jfL9y7AdV1A36Uj8zG3EOXHZLM61P7DNDfvtuNZ
	s
X-Google-Smtp-Source: AGHT+IHvZ7DWhklwvAxckgSO5ZRgSBHSojBB/VU2p5qCjEBq2UGy6fi0XzL+qOItblFmB+8E6ycg7g==
X-Received: by 2002:a17:903:1249:b0:1e4:b1eb:7dee with SMTP id u9-20020a170903124900b001e4b1eb7deemr14339108plh.47.1714439258962;
        Mon, 29 Apr 2024 18:07:38 -0700 (PDT)
Received: from localhost (fwdproxy-prn-017.fbsv.net. [2a03:2880:ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001e853d9bb42sm4973225plg.196.2024.04.29.18.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 18:07:38 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next v1 1/3] queue_api: define queue api
Date: Mon, 29 Apr 2024 18:07:30 -0700
Message-ID: <20240430010732.666512-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430010732.666512-1-dw@davidwei.uk>
References: <20240430010732.666512-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mina Almasry <almasrymina@google.com>

This API enables the net stack to reset the queues used for devmem TCP.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/linux/netdevice.h   |  3 +++
 include/net/netdev_queues.h | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f849e7d110ed..6a58ec73c5e8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1957,6 +1957,7 @@ enum netdev_reg_state {
  *	@sysfs_rx_queue_group:	Space for optional per-rx queue attributes
  *	@rtnl_link_ops:	Rtnl_link_ops
  *	@stat_ops:	Optional ops for queue-aware statistics
+ *	@queue_mgmt_ops:	Optional ops for queue management
  *
  *	@gso_max_size:	Maximum size of generic segmentation offload
  *	@tso_max_size:	Device (as in HW) limit on the max TSO request size
@@ -2340,6 +2341,8 @@ struct net_device {
 
 	const struct netdev_stat_ops *stat_ops;
 
+	const struct netdev_queue_mgmt_ops *queue_mgmt_ops;
+
 	/* for setting kernel sock attribute on TCP connection setup */
 #define GSO_MAX_SEGS		65535u
 #define GSO_LEGACY_MAX_SIZE	65536u
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 1ec408585373..337df0860ae6 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -60,6 +60,33 @@ struct netdev_stat_ops {
 			       struct netdev_queue_stats_tx *tx);
 };
 
+/**
+ * struct netdev_queue_mgmt_ops - netdev ops for queue management
+ *
+ * @ndo_queue_mem_alloc: Allocate memory for an RX queue. The memory returned
+ *			 in the form of a void* can be passed to
+ *			 ndo_queue_mem_free() for freeing or to ndo_queue_start
+ *			 to create an RX queue with this memory.
+ *
+ * @ndo_queue_mem_free:	Free memory from an RX queue.
+ *
+ * @ndo_queue_start:	Start an RX queue at the specified index.
+ *
+ * @ndo_queue_stop:	Stop the RX queue at the specified index.
+ */
+struct netdev_queue_mgmt_ops {
+	void *			(*ndo_queue_mem_alloc)(struct net_device *dev,
+						       int idx);
+	void			(*ndo_queue_mem_free)(struct net_device *dev,
+						      void *queue_mem);
+	int			(*ndo_queue_start)(struct net_device *dev,
+						   int idx,
+						   void *queue_mem);
+	int			(*ndo_queue_stop)(struct net_device *dev,
+						  int idx,
+						  void **out_queue_mem);
+};
+
 /**
  * DOC: Lockless queue stopping / waking helpers.
  *
-- 
2.43.0


