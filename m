Return-Path: <netdev+bounces-92637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384758B82EB
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7B41C228C7
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4681C0DC3;
	Tue, 30 Apr 2024 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="faSwNBCX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB08B1BF6C0
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518878; cv=none; b=o9ysWDxCI7rWCBi3j14OOsEnhYgVuzD7e2HefqXo4Xo3eNsAKpazegGP9ELnC/+Wd5/FHXODzCcvQ6heLTfEq/gcYQIX9uh3L34knqhTPGTd1tuyGaQ9brFHWtWkwk8GaBJofOhNGiezSsPyOR8fZpZ+qlX9vsTGbas4olVF8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518878; c=relaxed/simple;
	bh=4xUUodiBIVxZkjvkbMI1u4kBI5P1wirbmcEa6D84Q7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gg0BR/GipD6/T80ZkEdF0mZkrQ54DAYS1w4WGsLblUhBQNTFoWi1BKBQU5xKoRqBPjlORYFuOgqb1Lv8oNSX1xTg0ia4sP1ccvE64quFRq3OKW0yMOP75bNVKqxYH4fOGt4Q/jMZeEfHsZGX8cTwGTQmrSaNU4g8V9V7EzcnJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=faSwNBCX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ee089eedb7so7684576b3a.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714518876; x=1715123676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7U+1J2EEWQ/RQ/ejFdIxlreAtu0YNhB+rfukR0B4WJM=;
        b=faSwNBCXo+gTIerb8HpAnRh7HKc7CM4QU4oXqgK9RgLjsUIXMlTY01+fLNB/ccFDOG
         xO1QyVK/zRSDHExyC0QW9MGX+OcMJSvq7bBGVNKXcfItCSgb6a/UjMoTEi5ixrikkEsS
         7Dslwlvx6YGFUAGCiJKaia74w2DNWg7tLbSv4oRjC9+26GLz5FygqGV2fTYxM5IQTrg9
         obhRrl46boqt5dKfrh3WE1SuAdHXEBbPbz5rNn4KP3+n0nMqmTPsqrzCOkSBEquKB7WO
         DjN4BL8Qzt6e44sHv0TwXGMBNjeE/kYliO50zyHOBjOif2P30fICE5CWUhEarWV3mY4w
         HXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714518876; x=1715123676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7U+1J2EEWQ/RQ/ejFdIxlreAtu0YNhB+rfukR0B4WJM=;
        b=DNYTx1WV3vC1MZBMxB58TwkLwIMMqn8QEEY3DbFwUtQ/hPBI83jnd0WcASaB9epIUs
         +6XZ77kuu2e2A8EnyUYO4rs5m06F5A+nidCvlGxDoklgK4SwHel51q+A32rAY+o+O+xS
         oiQyTbCuz3TkiK2cTGC3qvDZaVKme6wjc/wQyFaFgL/kfKOlevAZvUV+vCKRbKy3H1mk
         Z35WT9ctNS8LZZDI6mE2VIIwmXLG3UfQf8bZ60MjdcXGIuF7yodQJlGBUIZgdVjSB2BQ
         jJEK3n/4ijGe6pZdLtxaUekjz2XmGEYRJ5eaGkc0UVDGqlEGs9TDfTkhdSl7aIN+gaUL
         wYeA==
X-Gm-Message-State: AOJu0YzfI12dkEGbV1vO3/wqai4pSQRIwjOEdoYvK4oFKEDyqLubcVqA
	2AWJ8FWWm+dAcgQejeS88RUIyInAQQ3xrjvR8S6X0BwmmwQqjuTFEe2+rx+NDD6vpAbjzfxsJbt
	dG0Iy0mVBbCCOdXmWeqQrNHxAhRr8GdQf2xKnFqYsBJD9QAhMg5h8TeJoFKzOC8B6iKl2aJTivE
	WtvwuwBBMGaEHczS6xY6cKpB8lkxFFrYNsAegJBF6HIvY=
X-Google-Smtp-Source: AGHT+IE4/8Ok2uWNDlTbdDpD46w3TCSp/6bkhgIEeFrltdtr/VLk4si7h+tb6g5gnYzwgrAXm8WddqPE5vlcdw==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6a00:9392:b0:6f3:f447:57e1 with SMTP
 id ka18-20020a056a00939200b006f3f44757e1mr46865pfb.1.1714518875684; Tue, 30
 Apr 2024 16:14:35 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:14:10 +0000
In-Reply-To: <20240430231420.699177-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430231420.699177-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430231420.699177-2-shailend@google.com>
Subject: [PATCH net-next 01/10] queue_api: define queue api
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com, 
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
index c7ac4539eafc..04bb1318c6cc 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -87,6 +87,37 @@ struct netdev_stat_ops {
 			       struct netdev_queue_stats_tx *tx);
 };
 
+/**
+ * struct netdev_queue_mgmt_ops - netdev ops for queue management
+ *
+ * queue_mem_size: Size of the struct that describes a queue's memory.
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


