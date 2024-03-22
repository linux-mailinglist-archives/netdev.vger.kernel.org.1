Return-Path: <netdev+bounces-81155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64FA8864F4
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 02:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6A31F20EC6
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 01:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC1410F2;
	Fri, 22 Mar 2024 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNKzUvDh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15DC65C
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711072710; cv=none; b=rN7XUajvB5+tLufUDWyDTdC+ufkLh3thCM+BJQAW0C6VdR+zY7oGI+eUd7LH2mhY94MxnML15HeejenFuZJT6hBC7m8vWoADvTS2JesuOex2UJsQ+Q85eAzHDFk04lFjfGXbntuDNx+zjdXSg89BdbXKrIdD6ACnjTFxGSYD1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711072710; c=relaxed/simple;
	bh=ngH8lT7DEtQfJx7i58W6MUmYXOVaqg5Y3IxTJEgP5wY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qy/zz0LrS1v7+XzpSJ9HzlMyc9hQNSIs7Mm3XBwnmXccaVOuAHeepfjTP8oDoqQCHQGLscYPsAbW+FkOmHqZM3Rvzy+p8shdS7gmePIKlQIeinMQ4d0NBT+0vkXJLeL3RyUM28eghwcWAHqIap7uvkZPnInFf44o8YQGo6jvBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNKzUvDh; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a47680a806so425917eaf.0
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711072708; x=1711677508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/i6lUIEiWEP7sn9GLxZRfB669zySrVDrJPgLY87//64=;
        b=QNKzUvDhpMF5kMiV3LIGmIgYeTsJ9j+IjchqLMGvOk/b3b3kCBitCe0T6QwW5q8Itg
         h++M9Ydwy2j0tysrAbEzgpAlC54+pwiqiMr3/qgFJJMoBeFMnGZk+c9t++Gsr16fmuL6
         UewYolCcTZCDtkr98TgrhQl9iWPM/G3NsGywKOXJqA9Jihol8bea5dlgP1cUf557/6NX
         CKZ+v6/jt3MFjYol9EmpDJOWbbGrZpSE/jx42tWq6+aPsxLTmtYsKZMpHH/WOUbDy3nY
         DZh2enJDF/WeM+lxFtv8Q4OWl9lfWRwfHsyPaQKOyg+6pMNoowB7JkczyVqJzoD4xB3q
         76Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711072708; x=1711677508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/i6lUIEiWEP7sn9GLxZRfB669zySrVDrJPgLY87//64=;
        b=ZwU37wUzPVSB919rRmaFWeE9Ms9B8Edtv3Q5bYUjYj2V2kZO9iTEoRCT/tz404oNyP
         NCjtCVuRbJ/py6gFDhwqqGvfwZ7ifWcGhz2+2bKIOnLzPhUpF3IkiGiqoxz3hclk9R7J
         QqsDPaa89A9hA3KKDyr5U6WiJI5GL61xV8Ictd1bqD05Pv+B4cZG4qzAnWKkbg0C4QQh
         2fKacMGEsDgrZ096+AiZpgO+qvg0nl+pTpYKbi3XK1933H6SkeXc3/bDzEgX4WRo7Wft
         zXoPTqmiKtqdXZwH1ATRrFCgmalkqwuwihqnYG5dGXnQhSaiHcJRDSNRC71hbhYsPJqH
         89Fg==
X-Forwarded-Encrypted: i=1; AJvYcCV5ideMXyBqz6Tp9YS06MS3JAitDoZxakt2RwaWOK8S4AyDPmDDEB11Qpgv5b4UCL4N7W8EG+y/4+TdOhv/pA4CExExZkKv
X-Gm-Message-State: AOJu0YwWkX/247q5w9gYJRoMSMFuJFTvWXmXkaodPGUv++YjAQ21d7zk
	Hr4E3X+ihDi8jvwvNB3geA97zQ8F67sWT3yaVuIVQbMft7DIGnxn
X-Google-Smtp-Source: AGHT+IGaTZqhUfyZm3FgjeHDBwteusj3ThERYAtuQdtbpe2BNXObpaxgxp6Y+3vWu3fki3aGh3x8+w==
X-Received: by 2002:a05:6808:2082:b0:3c3:86a0:6df3 with SMTP id s2-20020a056808208200b003c386a06df3mr597685oiw.5.1711072707969;
        Thu, 21 Mar 2024 18:58:27 -0700 (PDT)
Received: from mi.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id v1-20020a62a501000000b006e5808b472esm522328pfm.95.2024.03.21.18.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 18:58:27 -0700 (PDT)
From: Jian Wen <wenjianhn@gmail.com>
X-Google-Original-From: Jian Wen <wenjian1@xiaomi.com>
To: jiri@mellanox.com,
	edumazet@google.com,
	davem@davemloft.net
Cc: Jian Wen <wenjian1@xiaomi.com>,
	netdev@vger.kernel.org,
	wenjianhn@gmail.com
Subject: [PATCH net-next] devlink: use kvzalloc() to allocate devlink instance resources
Date: Fri, 22 Mar 2024 09:58:14 +0800
Message-Id: <20240322015814.425050-1-wenjian1@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During live migration of a virtual machine, the SR-IOV VF need to be
re-registered. It may fail when the memory is badly fragmented.

The related log is as follows.

Mar  1 18:54:12  kernel: hv_netvsc 6045bdaa-c0d1-6045-bdaa-c0d16045bdaa eth0: VF slot 1 added
...
Mar  1 18:54:13  kernel: kworker/0:0: page allocation failure: order:7, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
Mar  1 18:54:13  kernel: CPU: 0 PID: 24006 Comm: kworker/0:0 Tainted: G            E     5.4...x86_64 #1
Mar  1 18:54:13  kernel: Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
Mar  1 18:54:13  kernel: Workqueue: events work_for_cpu_fn
Mar  1 18:54:13  kernel: Call Trace:
Mar  1 18:54:13  kernel: dump_stack+0x8b/0xc8
Mar  1 18:54:13  kernel: warn_alloc+0xff/0x170
Mar  1 18:54:13  kernel: __alloc_pages_slowpath+0x92c/0xb2b
Mar  1 18:54:13  kernel: ? get_page_from_freelist+0x1d4/0x1140
Mar  1 18:54:13  kernel: __alloc_pages_nodemask+0x2f9/0x320
Mar  1 18:54:13  kernel: alloc_pages_current+0x6a/0xb0
Mar  1 18:54:13  kernel: kmalloc_order+0x1e/0x70
Mar  1 18:54:13  kernel: kmalloc_order_trace+0x26/0xb0
Mar  1 18:54:13  kernel: ? __switch_to_asm+0x34/0x70
Mar  1 18:54:13  kernel: __kmalloc+0x276/0x280
Mar  1 18:54:13  kernel: ? _raw_spin_unlock_irqrestore+0x1e/0x40
Mar  1 18:54:13  kernel: devlink_alloc+0x29/0x110
Mar  1 18:54:13  kernel: mlx5_devlink_alloc+0x1a/0x20 [mlx5_core]
Mar  1 18:54:13  kernel: init_one+0x1d/0x650 [mlx5_core]
Mar  1 18:54:13  kernel: local_pci_probe+0x46/0x90
Mar  1 18:54:13  kernel: work_for_cpu_fn+0x1a/0x30
Mar  1 18:54:13  kernel: process_one_work+0x16d/0x390
Mar  1 18:54:13  kernel: worker_thread+0x1d3/0x3f0
Mar  1 18:54:13  kernel: kthread+0x105/0x140
Mar  1 18:54:13  kernel: ? max_active_store+0x80/0x80
Mar  1 18:54:13  kernel: ? kthread_bind+0x20/0x20
Mar  1 18:54:13  kernel: ret_from_fork+0x3a/0x50

Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
---
 net/devlink/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 7f0b093208d7..ffbac42918d7 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -314,7 +314,7 @@ static void devlink_release(struct work_struct *work)
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
 	put_device(devlink->dev);
-	kfree(devlink);
+	kvfree(devlink);
 }
 
 void devlink_put(struct devlink *devlink)
@@ -420,7 +420,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	if (!devlink_reload_actions_valid(ops))
 		return NULL;
 
-	devlink = kzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
+	devlink = kvzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
 	if (!devlink)
 		return NULL;
 
@@ -455,7 +455,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	return devlink;
 
 err_xa_alloc:
-	kfree(devlink);
+	kvfree(devlink);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(devlink_alloc_ns);
-- 
2.34.1


