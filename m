Return-Path: <netdev+bounces-81046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFED885937
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 13:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7F42814D3
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2857F7D9;
	Thu, 21 Mar 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUHSUz/7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD679B8E
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024692; cv=none; b=X2r/TjB88kF+motNHpbH9gwRtLKNFOMRNmlIXvZClI3efH3JeiK0t3rR+EZlHBJfp3gYU6NDrMAfx5ZLufr+erXzKNVCizDpJJGZe4BhN/535YwoXc+qwwWxqzyGQ+GV/q2RhoMXjCQO8UhE6nltUvDxucNcJQaF3rLJOFXxonQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024692; c=relaxed/simple;
	bh=ngH8lT7DEtQfJx7i58W6MUmYXOVaqg5Y3IxTJEgP5wY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fVxcMBJ0b2ORNeSP5gAqpr8lLCvpsdDTgE6xUu1IRoQhOGfR8bk3MHTDQ+WHKwbV4G2r3rKRt1kxDpK2XAxCxzasviIq8FsdXe3gogPcY3QC/jV+vuN0QCfrlX8dauM3EIFTGbiAlc/ouq//KP7nOW1jxfRMVz/CGQAIbGL1NNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUHSUz/7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6ca65edc9so271195b3a.0
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711024690; x=1711629490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/i6lUIEiWEP7sn9GLxZRfB669zySrVDrJPgLY87//64=;
        b=DUHSUz/7cUcCtY0pH2sc47qDngmNzCMRlB6yFplzDrif7v7A/SSBFUsgArGb1hH0yv
         r7Ghct1d7fssP8nLXBW8TtS5fLrAZjhklHCoiLSysT3sSg+cYwwb27oJAcdVQt8ivmrC
         UEyPJK1f4CnFVlJgcM2HDnkHdMhyJJUZ9H1vobYfgCOzLalwjlA4oRmlekpmgRpwT+AK
         nK102dWD3DqrzeirGcGxJS1qahE1Ks1i8WWLefK4beOVYpUY5htmN+eH5I/+takeGls8
         8BT1UJs/ifLMRj1d0LwJcpi8RTPEiCIuhunus45I3W1NM2tIQYtpxLr6SkzdIfojgDwf
         10dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711024690; x=1711629490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/i6lUIEiWEP7sn9GLxZRfB669zySrVDrJPgLY87//64=;
        b=kWR9E3OVlcSEj7Dvrtd2y5hpajaDymw3iuRzISNXK+FQv92If1gqu9LyEEuz/N77uh
         Zf35UkXvS7j8NCpF8X7TAAvvlNitZ3577rrjULn1NrcpfcuBFa3CTZ6N9/QlzAAUITgq
         61XonZ2N+78lLb0II6EMe764qnwNrH1Mi3grHjOKxl92qTr3m0XdnkAarUt9XNhfNDWg
         TDiXjK+iue3qDTMaE2S+Ka2G1MZXF12u76TaXSCMIzzSt6MmsQSvaL/ZQE2Y1gkUob6A
         DRro5wUpIG0oU1fri2VWGm9B4ULwvdWQXO/gtQrUve5EidRr5C/uG0ZNZKnB0S0M/NDP
         KPqw==
X-Forwarded-Encrypted: i=1; AJvYcCXmg/TzXqRYuqVkFJUdCKAm8SKKItCV6XpDmgHtCwwoJOzb0eqFamZCiLyye/i23HR2GYDo6NtzYTgIPqw63Go1mf8tNRFj
X-Gm-Message-State: AOJu0YxGnNxk0We+vLJNyNwepyclsjuBr4tOsDwNaovp0aQERMJC5QXY
	BpHzRyJk70YY3rkpjzr01MVLoPVIqL+Umc3NOUkjxAQGzOC4dcL0
X-Google-Smtp-Source: AGHT+IFomSMlfEIsagmLf7Jv6WZB7d2kkBc6cteajhX0+li+IZ+A1RMHQfm9Wpu2VRJEAUEBJ/iqvg==
X-Received: by 2002:a05:6a00:938f:b0:6e6:3b49:c4d with SMTP id ka15-20020a056a00938f00b006e63b490c4dmr4813726pfb.2.1711024690290;
        Thu, 21 Mar 2024 05:38:10 -0700 (PDT)
Received: from mi.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id p24-20020aa78618000000b006e4f311f61bsm13361093pfn.103.2024.03.21.05.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 05:38:09 -0700 (PDT)
From: Jian Wen <wenjianhn@gmail.com>
X-Google-Original-From: Jian Wen <wenjian1@xiaomi.com>
To: edumazet@google.com,
	davem@davemloft.net
Cc: Jian Wen <wenjian1@xiaomi.com>,
	netdev@vger.kernel.org,
	wenjianhn@gmail.com
Subject: [PATCH net] devlink: use kvzalloc() to allocate devlink instance resources
Date: Thu, 21 Mar 2024 20:36:11 +0800
Message-Id: <20240321123611.380158-1-wenjian1@xiaomi.com>
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


