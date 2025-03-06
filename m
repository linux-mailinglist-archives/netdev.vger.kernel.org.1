Return-Path: <netdev+bounces-172658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC9A55A87
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917F318947A1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5C027D78D;
	Thu,  6 Mar 2025 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="IXIVWwc5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B9527D785
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302244; cv=none; b=AwUvvMhj/+79f+FhriJFLBnfuR7ImPIDDG06caEi0LG6Pc2805krN/2Fh8rAi/wNVYdKoX6WMyMLX5i0Yubg6LmetuucdFoFyC6WKVcl6iKQ+4bJ5SQYxOHax7JIlaqzmvuEeXTBe3IiDVebciRN6URY7RF0BOq7QzLgcJDIJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302244; c=relaxed/simple;
	bh=VHDaj2dFWf0huRfzMhshaU6/zQL7nlq4K/C8/Go+Zts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Udj2+RgDLmR/OlybuP9ZOzGU8yTfDQh4aoKTWK1tJu/m9tHndg/K54FRcu+eu6604t3T7qK9jyAy+xUeigA2V7mPBN73rIpBNs+OOwXhJIbDZIdqu8wRnWpo1/A/n6uvt/sfmxK0S+G19QE6u66YSWG2CM0XYrgNcBcQBxeKZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=IXIVWwc5; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so8382266d6.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 15:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302242; x=1741907042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+HMmIGPgvz4lBJFzaO8GeogBJftxbQ/ueBJRS3zwq0=;
        b=IXIVWwc5h1bHO3+9QP8seXn7UmnEYm6cXpdOiWYkCBr3P8Uy0oUWjm8I1K8mz/x9K7
         A8Mp+A9zermIXAkl0G3vQV2XWWUxw7LwMBRIe/O1e6bOzWOH9FnW0d3jLi/2RlW8jvR5
         IqAUIfjJ52hCUmnlKBjhQAB3Jg2s8qNHm7CWccj/ROqCRS6fkWr1AtgkiT0EDavhriNt
         CYMAhblB0Pa7RS7XQCGWdfW2bT7CmcdmcFqX7ZoNJB3sbLecziGidbxjJmo1U7/g7mrE
         j6lmkH0TPbD+BKuMfbSdPt+tKTSX6aeMbc/Ior8JyaoLN388an0uiTocWzeZRXVifPpw
         vgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302242; x=1741907042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+HMmIGPgvz4lBJFzaO8GeogBJftxbQ/ueBJRS3zwq0=;
        b=KqJkFEuwROTo5/pJZEo4gn8VsA6xENuVAydvtbYbLkMKUjhmn0kZq0Dis0yS77SPXT
         Xvc5Ae6TR86eZS4A2a0oqrg2bigA2D3Lp6cZIWfLFM2Gc7luB+sMbg3jAHbDkvPV5IjG
         dmsHZmYLIF9hRV3FhspN6Q0DjDJDpDEt9vJ5NuyAPf6Segj2TSpu75prskRoNAS/Amx1
         IZte+gm54G/kPFMQpgmUiANovUt5YeYlUHAabeVfhMDoi+3QoMT7at5xbX4C1DzDBElK
         hsejsIKTSZclcLFwp7eScXQGM3CYytNENkYRtbWL+RyvxTGQPCvjJo73EJr2kkxE18qD
         fOxw==
X-Gm-Message-State: AOJu0YwKfLPs3wStujj3Hk6494JyjHLjhH9UL6KWOuyxZKmkxqH5JxTO
	3KjN1Fc3ryO3zD53KND7qXGfYdLO+rsU6VD7UvAS5QiQQu8tENS0vd+bthfbUYDHw6Dpd7rTQn1
	x3vSH7SF1sKJzyvCXNiZxB4RalerY2mXHkfq33yOcDC3sr6z2IFQFbxPvGQDBreQLJBalRXsrmh
	eQaa7l8CHU4NkeG7CqFmgvuurFWKe/HuNEqi/KlOyy2Ug=
X-Gm-Gg: ASbGncvIExCifVjZ4ePtQaU7h04QPvmo85syuAm9b/pUPLbjsUvTEyBxS3DrBcXYsYu
	tSUXilvV/d0K0F3WbsfzJZwJJ0a7MA4Y7HIH5xhH9bWWkwfBgCF14BEWvyTtwOv62dHm7JoMrM5
	wcxrXmets/PBXPgkmoRcczoS9bcbORCWqpNgqLOraPxMsWy6hoY0p3SHziKCuZolGR9GZ8FrgmA
	RNG3q4xrNRxrXP0t9zA7mTEtDfF0HMXusYGN7g34xZt2SJKL3FOmYjwzcitL32pble+qfpUeO5D
	Nyc3Dsh2e/sy9VOMc/7imPVUQ4W6LLWSzI5VIIAs+YAshu7d31dCiy5PLmnVa3Xp8Tyd
X-Google-Smtp-Source: AGHT+IElZaiOv/FIthqpFAMu6jcbTAo/35EvxhNrODQalY6dTWOVJZ786VW8xHepZXH+ATJpRyowxQ==
X-Received: by 2002:ad4:5aaf:0:b0:6e8:ea29:fdd1 with SMTP id 6a1803df08f44-6e9005d4500mr16521666d6.3.1741302241684;
        Thu, 06 Mar 2025 15:04:01 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:04:01 -0800 (PST)
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
To: netdev@vger.kernel.org
Cc: shrijeet@enfabrica.net,
	alex.badea@keysight.com,
	eric.davis@broadcom.com,
	rip.sohan@amd.com,
	dsahern@kernel.org,
	bmt@zurich.ibm.com,
	roland@enfabrica.net,
	nikolay@enfabrica.net,
	winston.liu@keysight.com,
	dan.mihailescu@keysight.com,
	kheib@redhat.com,
	parth.v.parikh@keysight.com,
	davem@redhat.com,
	ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com,
	welch@hpe.com,
	rakhahari.bhunia@keysight.com,
	kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 02/13] drivers: ultraeth: add context support
Date: Fri,  7 Mar 2025 01:01:52 +0200
Message-ID: <20250306230203.1550314-3-nikolay@enfabrica.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306230203.1550314-1-nikolay@enfabrica.net>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ultra ethernet context is at the root and must be created first. UET
contexts are identified by host unique assigned ids on creation and are
protected by a ref counter.

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 drivers/ultraeth/Makefile          |   2 +-
 drivers/ultraeth/uet_context.c     | 149 +++++++++++++++++++++++++++++
 drivers/ultraeth/uet_main.c        |   2 +
 include/net/ultraeth/uet_context.h |  27 ++++++
 4 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ultraeth/uet_context.c
 create mode 100644 include/net/ultraeth/uet_context.h

diff --git a/drivers/ultraeth/Makefile b/drivers/ultraeth/Makefile
index e30373d4b5dc..dc0c07eeef65 100644
--- a/drivers/ultraeth/Makefile
+++ b/drivers/ultraeth/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_ULTRAETH) += ultraeth.o
 
-ultraeth-objs := uet_main.o
+ultraeth-objs := uet_main.o uet_context.o
diff --git a/drivers/ultraeth/uet_context.c b/drivers/ultraeth/uet_context.c
new file mode 100644
index 000000000000..1c74cd8bbd56
--- /dev/null
+++ b/drivers/ultraeth/uet_context.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+#include <net/ultraeth/uet_context.h>
+
+#define MAX_CONTEXT_ID 256
+static DECLARE_BITMAP(uet_context_ids, MAX_CONTEXT_ID);
+static LIST_HEAD(uet_context_list);
+static DEFINE_MUTEX(uet_context_lock);
+
+static int uet_context_get_new_id(int id)
+{
+	if (WARN_ON(id < -1 || id >= MAX_CONTEXT_ID))
+		return -EINVAL;
+
+	mutex_lock(&uet_context_lock);
+	if (id == -1)
+		id = find_first_zero_bit(uet_context_ids, MAX_CONTEXT_ID);
+	if (id < MAX_CONTEXT_ID) {
+		if (test_and_set_bit(id, uet_context_ids))
+			id = -EBUSY;
+	} else {
+		id = -ENOSPC;
+	}
+	mutex_unlock(&uet_context_lock);
+
+	return id;
+}
+
+static void uet_context_put_id(struct uet_context *ctx)
+{
+	clear_bit(ctx->id, uet_context_ids);
+}
+
+static void uet_context_link(struct uet_context *ctx)
+{
+	WARN_ON(!list_empty(&ctx->list));
+	list_add(&ctx->list, &uet_context_list);
+}
+
+static void uet_context_unlink(struct uet_context *ctx)
+{
+	list_del_init(&ctx->list);
+	if (refcount_dec_and_test(&ctx->refcnt))
+		return;
+
+	mutex_unlock(&uet_context_lock);
+	wait_event(ctx->refcnt_wait, refcount_read(&ctx->refcnt) == 0);
+	mutex_lock(&uet_context_lock);
+	WARN_ON(refcount_read(&ctx->refcnt) > 0);
+}
+
+static struct uet_context *uet_context_find(int id)
+{
+	struct uet_context *ctx;
+
+	if (!test_bit(id, uet_context_ids))
+		return NULL;
+
+	list_for_each_entry(ctx, &uet_context_list, list)
+		if (ctx->id == id)
+			return ctx;
+
+	return NULL;
+}
+
+struct uet_context *uet_context_get_by_id(int id)
+{
+	struct uet_context *ctx;
+
+	mutex_lock(&uet_context_lock);
+	ctx = uet_context_find(id);
+	if (ctx)
+		refcount_inc(&ctx->refcnt);
+	mutex_unlock(&uet_context_lock);
+
+	return ctx;
+}
+
+void uet_context_put(struct uet_context *ctx)
+{
+	if (refcount_dec_and_test(&ctx->refcnt))
+		wake_up(&ctx->refcnt_wait);
+}
+
+int uet_context_create(int id)
+{
+	struct uet_context *ctx;
+	int err = -ENOMEM;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return err;
+
+	INIT_LIST_HEAD(&ctx->list);
+	init_waitqueue_head(&ctx->refcnt_wait);
+	refcount_set(&ctx->refcnt, 1);
+
+	ctx->id = uet_context_get_new_id(id);
+	if (ctx->id < 0) {
+		err = ctx->id;
+		goto ctx_id_err;
+	}
+
+	uet_context_link(ctx);
+
+	return 0;
+
+ctx_id_err:
+	kfree(ctx);
+
+	return err;
+}
+
+static void __uet_context_destroy(struct uet_context *ctx)
+{
+	uet_context_unlink(ctx);
+	uet_context_put_id(ctx);
+	kfree(ctx);
+}
+
+bool uet_context_destroy(int id)
+{
+	struct uet_context *ctx;
+	bool found = false;
+
+	mutex_lock(&uet_context_lock);
+	ctx = uet_context_find(id);
+	if (ctx) {
+		__uet_context_destroy(ctx);
+		found = true;
+	}
+	mutex_unlock(&uet_context_lock);
+
+	return found;
+}
+
+void uet_context_destroy_all(void)
+{
+	struct uet_context *ctx;
+
+	mutex_lock(&uet_context_lock);
+	while ((ctx = list_first_entry_or_null(&uet_context_list,
+						 struct uet_context,
+						 list)))
+		__uet_context_destroy(ctx);
+
+	WARN_ON(!list_empty(&uet_context_list));
+	mutex_unlock(&uet_context_lock);
+}
diff --git a/drivers/ultraeth/uet_main.c b/drivers/ultraeth/uet_main.c
index 0d74175fc047..0f8383c6aba0 100644
--- a/drivers/ultraeth/uet_main.c
+++ b/drivers/ultraeth/uet_main.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <net/ultraeth/uet_context.h>
 
 static int __init uet_init(void)
 {
@@ -11,6 +12,7 @@ static int __init uet_init(void)
 
 static void __exit uet_exit(void)
 {
+	uet_context_destroy_all();
 }
 
 module_init(uet_init);
diff --git a/include/net/ultraeth/uet_context.h b/include/net/ultraeth/uet_context.h
new file mode 100644
index 000000000000..150ad2c9b456
--- /dev/null
+++ b/include/net/ultraeth/uet_context.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+#ifndef _UET_CONTEXT_H
+#define _UET_CONTEXT_H
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+#include <linux/wait.h>
+
+struct uet_context {
+	int id;
+	refcount_t refcnt;
+	wait_queue_head_t refcnt_wait;
+	struct list_head list;
+};
+
+struct uet_context *uet_context_get_by_id(int id);
+void uet_context_put(struct uet_context *ses_pl);
+
+int uet_context_create(int id);
+bool uet_context_destroy(int id);
+void uet_context_destroy_all(void);
+
+#endif /* _UET_CONTEXT_H */
-- 
2.48.1


