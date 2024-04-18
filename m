Return-Path: <netdev+bounces-89398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16C58AA387
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171271F2428B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648CE181B90;
	Thu, 18 Apr 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2aDGmts"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE63D62
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469941; cv=none; b=SdnYFZAkcDr7rH9pN+MTN05pOzaYeRGdkMy6MlMjSWcp8AWVbv7QBbqmIc4B5UdutlZ1UqodkbWqknLeSWeQoXcR9zlc4yhitwPfM2D48nzYkyA26W9mcb1lFMtEUN0hOgRKjx4JgQsU0iv7ZGoX+sW7sMzniwwN6tC9MZAYWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469941; c=relaxed/simple;
	bh=Dx8QnO5TPwrgAAgJCm68WgpENI+3+pQLJKpgLtJndFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jyK3kPP1e+B2Qln0nB2EptLNC7coDupfUOspv2vdInZiOBvjCDDQ+H0F+o6fAbSSSCI3OxUSGGWtcTz4FHsnFLnIsrKJz7QbwJ4ttx2A8mKzw24b3x7kQFjqqBpJuYsDd1zIsvGVWon1UdT9s0ZRAmWocX70X6fAc65YMQYE/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r2aDGmts; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so2246955276.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713469939; x=1714074739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C53GdnEbw3pBn26StGn2aGR2iLy/WiM1yH1OeFkVh28=;
        b=r2aDGmtszE9pUqpoD87k8p1Qd7pYEkMYEiF2cFL2C3wIW4R5fYqoxUoVbWcieC/zON
         mN2IipX3EafNRja/zg0BflglxW8W+QqvGsAj/fcolGr17TGMFcicORlXADQYdFm9CUm0
         27kt8KqwJlvsh6vuOfKzobjKdNcU0SmNNbKOoNCAPycxqFuoZOmf+8m1lkrMmfyInDOf
         zs9BCitGLcJA4S0pDVi788F78TIBsnhRJ6uk3uuqocJzRI4/Zu/gjLiKqwECIyXqdM6L
         sqKpTPPvfMC4fGHVYGr5g3u/rnWDs1NgfwHL0KkC5WrYwHZDsNs5poHEHvvP0l7trNcY
         DuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469939; x=1714074739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C53GdnEbw3pBn26StGn2aGR2iLy/WiM1yH1OeFkVh28=;
        b=kB7mK/7V44Pqrx4kddUDIVCdmeBbia4y/e4QaB+BVLrs432aP8nIpGoXEkp4Cfp/91
         5CAsZma8vWUBMOzNxh87fJ7drSp+RqtnTxLcw3D4RoPyE0HoylvIaq+L26gOq+9TNHE3
         YSupxvifgA114b1q7swOHBg/tFPEkaBY0GMbgBAwNmoKLFyP+8BqrwBZZsTqQpDs3PAH
         iHtuF6aXc0/ICYD60eZ/3OucTG+kLLnmT8DybkAOWWLOI/2fugpvddLJVuwYYu3usQj5
         tjv5OmCthN653KMC3s3X0r90N+W/UQD4Vfny7FfE1tk511rqcx/xcJ9Z5xHQ5iyqFLFK
         WR6w==
X-Gm-Message-State: AOJu0YyyPsWqX/PbcLEtIZgveVTedlohK3VrkPUYPQsnXIkQ8d+nQVe/
	HLqHxNnMze9oczUyY7GL7QQFRQmoYLExgb1hyUAMNULYivjGF23whwAoieAsEXHCoWG3iwAxOYe
	L009zvVDySLW+jdWcyxXV06lLa3doZdsoDj4JBQPO48t/bwQGR4AORxv7gx21JsY4I98sR/jB4+
	l9OUj8yQhmQ2Xne72LAcKDwquBYsOIsuMhnqWacY69kQ8=
X-Google-Smtp-Source: AGHT+IE/bVmEhXdYPeElrQE+Dhd7tjWS9wJQIw6JVkZTVF6Jrsn95QjLJA7Cft6Hh1vy6F6bgEUXNaqkDG1Ogw==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:114b:b0:dc6:e647:3fae with SMTP
 id p11-20020a056902114b00b00dc6e6473faemr402685ybu.2.1713469938687; Thu, 18
 Apr 2024 12:52:18 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:51:51 +0000
In-Reply-To: <20240418195159.3461151-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418195159.3461151-2-shailend@google.com>
Subject: [RFC PATCH net-next 1/9] queue_api: define queue api
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"

From: Mina Almasry <almasrymina@google.com>

This API enables the net stack to reset the queues used for devmem TCP.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/netdevice.h   |  3 +++
 include/net/netdev_queues.h | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d45f330d083d..5b67dee39818 100644
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
2.44.0.769.g3c40516874-goog


