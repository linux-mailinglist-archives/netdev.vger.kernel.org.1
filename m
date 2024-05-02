Return-Path: <netdev+bounces-92891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AED8B93F8
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 06:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BBEB21ED2
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D11E1CD2D;
	Thu,  2 May 2024 04:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="KZPeEJzH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325D71C2AF
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625659; cv=none; b=YdM3zhji2q3i2XBdALM+KWaVA5MFmKD+kNrrvjdixXCi9kBebql9TaWK3aADXld8Zi90sgJ1iw+/FbElMez4yO9jHPC/vz7vssaTeLoCRO8BxJalEnyKDasDxc6zzDikk4+aL3l6QfjwmENm6cupHl/rvMpCViSax671FgjpU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625659; c=relaxed/simple;
	bh=65/iGdiJmESR6Y+bbIicl/WBzYNXyKpyKTLjRzyDAyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSlx4bUpWGa9dXJBQHhsS7lmpYUhP5k6z54I5u40Pim9Y7I1sV7kPj7UqLkQrBypPGq4oldBLyW/dk0PaEQIajiabhTQLpPABrfbqM8nyurjhafLdqXqk+bh8BFvulxmUYu6hSoDlmvuzPPz9uVmrFtQoJNF6iF8AgJsdvwEG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=KZPeEJzH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e65a1370b7so69865165ad.3
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 21:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714625657; x=1715230457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSsbakNpU8SVJbOYsOnVPvnpJ6qrM0BD4y0o4BP6NEs=;
        b=KZPeEJzHIjqZ3NGW04I6MiSgs26noLKna2jusqDcwyVc4W7dHSamHDeng9Ald4+Ghv
         Spu1mj8Pub3G2MqEnpJDpLrytGfpw3qpe+JPyCT31vWlRmCUIKttr7b3Cp0hIR0s+tcr
         CjlRF2tzQG77c+fnyzghjVyKk2ljx1h1IA81PR6TJfmruSJ8iPT4njBX1LZho/LpqUYi
         ZJmRPczTeXEbwq0GFuhfuluFA/146cwZfO//EfGRSGCIx7mKNSlKKPHeoezyDO/y7lkW
         WGUspfriQ1fWdyYtMRP2wk3YSMwrrZG7L/Sj9L/S5RUd/gyMVbsw1xAAmlbIkYAdg3oC
         G0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625657; x=1715230457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSsbakNpU8SVJbOYsOnVPvnpJ6qrM0BD4y0o4BP6NEs=;
        b=kc44aOQPhxX9p9jc6kDnMaCgOnepQsHrpmS9adeRW2C06VWj6uDHPdqGZwgpokUB+F
         LGpGLnf/6/xYv9uU3yQJZz8e0y5NzeEeh922ozBjrv8OMudTxO2itvBzxoGO1iK0yQfA
         3/qF4jSpYkj0UHKf5Xx4bwc3Qq+cc5IT9SGGhph4piSesxqprbFtJOKuOYtVW/7XmKbd
         gJu5fG4ml+OuJ+5o6t3gN1h5RGDEfWcLth2xcSMYY3qHwYkAC+sGsp+CSaYU2HliQkxn
         /7pWujMVuAjhjXr9izziMF0iC7E/b+s6gXcj1oxmz44iYl9liR+VME+scnBMtILyPeMa
         2lWQ==
X-Gm-Message-State: AOJu0YxflXtNfIwasZHf7UHyzWzqqLYrt8LIudZimMDMSx7NZzFNCSfH
	Eod07ChdTMs9DdhmYZHHMGsAVgzA3CBhdVZLAdv8gTftPJOAd4JrJl35BQugKCatMYHroBcv9FF
	v
X-Google-Smtp-Source: AGHT+IF1VuzemZitQ3fVfKfdvXvo06YjOrksixJiB3+ocq60Am01w4GNNdtkGH9gCNDSDRVwf2xPhg==
X-Received: by 2002:a17:902:e9d5:b0:1e0:b689:950b with SMTP id 21-20020a170902e9d500b001e0b689950bmr964242plk.16.1714625657223;
        Wed, 01 May 2024 21:54:17 -0700 (PDT)
Received: from localhost (fwdproxy-prn-013.fbsv.net. [2a03:2880:ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id kw4-20020a170902f90400b001e47972a2casm248949plb.96.2024.05.01.21.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:16 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next v2 1/9] queue_api: define queue api
Date: Wed,  1 May 2024 21:54:02 -0700
Message-ID: <20240502045410.3524155-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502045410.3524155-1-dw@davidwei.uk>
References: <20240502045410.3524155-1-dw@davidwei.uk>
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
index 1ec408585373..58042957c39f 100644
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
+       void *                  (*ndo_queue_mem_alloc)(struct net_device *dev,
+                                                      int idx);
+       void                    (*ndo_queue_mem_free)(struct net_device *dev,
+                                                     void *queue_mem);
+       int                     (*ndo_queue_start)(struct net_device *dev,
+                                                  int idx,
+                                                  void *queue_mem);
+       int                     (*ndo_queue_stop)(struct net_device *dev,
+                                                 int idx,
+                                                 void **out_queue_mem);
+};
+
 /**
  * DOC: Lockless queue stopping / waking helpers.
  *
-- 
2.43.0


