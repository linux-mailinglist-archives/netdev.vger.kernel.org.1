Return-Path: <netdev+bounces-92852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D738B9252
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765A41C212F0
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E10A168B17;
	Wed,  1 May 2024 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4qL8gts"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020FE168B05
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605961; cv=none; b=Jr/Dq5RE6EQ7EnCCVQrxE6Of2IOEYZVwX8IvqyzNELy90jaGtmUA/U2TkOXs8T1iGjyYnlDhIHwh2revckL+xrLs1YUSKTq3blYYVYwK+mPeb5o/FXkSXS29bVg0lOkB6qPM8IpsXR8nx0A/9pwefZzTNNejzmgZ61dkUacN7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605961; c=relaxed/simple;
	bh=SsI8/LWGAq5J+40FM/vo85o3bCod9M5fAtck8S2h3A4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PZZVq6Q2QaJ7/Atwif42wRjCW1BdUynQhrUwezPTTQ1TqE6mq4tCu1+4HFFr2YNQB9lDGoavqPTSAXtd92toY8zXhInddqLuPl2ucdTz57bCFUd7PR1og+jP+eIbOQBYajENl+9nHF/2WgBdG8TdUaC4mB6UQUtFrWnL5fHVZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4qL8gts; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b2ef746c9so138634417b3.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605959; x=1715210759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbbzxHFUlKrWVd7s5EnZ5ZCZfe3o+RIcd0TaZmFEmCw=;
        b=T4qL8gtsOrJtbll+zo05cs8lclAqiti6MaiqATuTBjApdm8bSgxg3VxyijVnYrAtSO
         EuhZ3yD7J1YrYrE1Valgm00P3Hz6gCyuf786TWA8vzx3d0QjskxDQIOtd7X17/L8S3vu
         Byou7KvsyJSJRoM6aau5ZrsgtEbzlHCLOLMYImhqq4BdOi4SY4D4naHZ/TE3zG36K/qX
         Idn+HnY41qGaN7S+Fhnz776aqZGuYplor2cSZ+9y+/hGzWQOZWb61JAA+lhXrCic2D5N
         8Y5E6ylPt5Y2ZU+l+5mqWHFOLv3yhnoz2WY/32nqE5duU9zK5pxRVase0Fm2BBHEdzVX
         dMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605959; x=1715210759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbbzxHFUlKrWVd7s5EnZ5ZCZfe3o+RIcd0TaZmFEmCw=;
        b=JLMbHyTKfk7lJbR9+i69EhFDM2RFFwtzEGCmD18UfPvBl9W5+J+YgceePzkjHDviIa
         IpC5l/1CCdiF7ctRsTY1TJKFggZzJNq01X9bbeHQbQAyw5NGCu5PcQkadc6svWlEFABv
         TMk/F1e6XdW69O/ihrFdIS7EXHe9WR+ve5Ugke3I6s58fX5r8H2NqDV1zROwlrTmsvir
         +LQEP2RcOEoHD/CeiUYVq7JZVcxNhX6bLLj83pz5963v3ZZ/0HdxAMX4CJkgWewNzb7P
         Eh0HhSrdHlnUGP6JrbGufIX5FirpqH49ZgZCxG8AHrDHmdKtFqYC4MBhNniBjk/hcZDC
         +f3Q==
X-Gm-Message-State: AOJu0YyygVYNZe1sF0XhbvhZ8xR1XyJ6AclStgXv+T5lhiHyM8cqJvgG
	rdnhwIF93GKzdzWMnSZkVQ4PTQPTlCbGcAfZVQU0fYFZLvLunybs9vy0q+VZslPIxFljvghsK8T
	W1mpeA2Rm8tq0199X2Qfhx1HTXEzgmAaz2Zx0SPZZhPC8nuQSMHvv5YrfBNcBd6rR2JslS+t77j
	d8dlmp7KEK4csVHmFcWFPHq3oI8+XPZUVxrMttkmmTMLg=
X-Google-Smtp-Source: AGHT+IF0kkQ3K5h+U5uzpwLhLAVyVgElFElcKTiYsj4ptdEiGd3bNUJq8rh9vzGZU6J95XwpNOzbQ1c8zVdk2w==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a0d:d447:0:b0:61b:e3e2:b5b5 with SMTP id
 w68-20020a0dd447000000b0061be3e2b5b5mr86291ywd.9.1714605958818; Wed, 01 May
 2024 16:25:58 -0700 (PDT)
Date: Wed,  1 May 2024 23:25:40 +0000
In-Reply-To: <20240501232549.1327174-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501232549.1327174-2-shailend@google.com>
Subject: [PATCH net-next v2 01/10] queue_api: define queue api
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com, 
	willemb@google.com, ziweixiao@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Mina Almasry <almasrymina@google.com>

This API enables the net stack to reset the queues used for devmem TCP.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Shailend Chand <shailend@google.com>
---
 include/linux/netdevice.h   |  3 +++
 include/net/netdev_queues.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

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
index c7ac4539eafc..e7b84f018cee 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -87,6 +87,37 @@ struct netdev_stat_ops {
 			       struct netdev_queue_stats_tx *tx);
 };
 
+/**
+ * struct netdev_queue_mgmt_ops - netdev ops for queue management
+ *
+ * @ndo_queue_mem_size: Size of the struct that describes a queue's memory.
+ *
+ * @ndo_queue_mem_alloc: Allocate memory for an RX queue at the specified index.
+ *			 The new memory is written at the specified address.
+ *
+ * @ndo_queue_mem_free:	Free memory from an RX queue.
+ *
+ * @ndo_queue_start:	Start an RX queue with the specified memory and at the
+ *			specified index.
+ *
+ * @ndo_queue_stop:	Stop the RX queue at the specified index. The stopped
+ *			queue's memory is written at the specified address.
+ */
+struct netdev_queue_mgmt_ops {
+	size_t			ndo_queue_mem_size;
+	int			(*ndo_queue_mem_alloc)(struct net_device *dev,
+						       void *per_queue_mem,
+						       int idx);
+	void			(*ndo_queue_mem_free)(struct net_device *dev,
+						      void *per_queue_mem);
+	int			(*ndo_queue_start)(struct net_device *dev,
+						   void *per_queue_mem,
+						   int idx);
+	int			(*ndo_queue_stop)(struct net_device *dev,
+						  void *per_queue_mem,
+						  int idx);
+};
+
 /**
  * DOC: Lockless queue stopping / waking helpers.
  *
-- 
2.45.0.rc0.197.gbae5840b3b-goog


