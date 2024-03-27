Return-Path: <netdev+bounces-82399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743D588D8B3
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 09:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B3AB2408C
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9463B2CCA7;
	Wed, 27 Mar 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj5N5Azm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C412C1BA
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527711; cv=none; b=ujHM0ocx6Sm5jGHh2wX1QN05cTNTAFjcXEEX8Y7TcW1k6H+J9jALqk6cq+8AY7XwTzqYdeRie57jm0IzqEYR3wdbqAUPB8xL4S+3QTWkaXawf1XQ40v+zLm2VAawCzQf6cI6FDv6rVOJx6s1J37Xyq8Qii8EyMo2UQPvpztPr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527711; c=relaxed/simple;
	bh=MZFowP40Q10Tr9VKk4xRyaZqtN+DllCdyZdKFDEQgUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgBuykxr9WQ13D82zblLAk30jB7GlLcqwA92uuR+xIPZFziEB3q6EAq55mGQjK6V09cSPHID0k0XCKA8lTzmoYox51Uf4vktt70GljC3CdSPsczrnveTKK2HcfqPEyLMk46JtcxaLZj3726DdQFdKQw0Dvn/AhkrpmvbhoHYeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj5N5Azm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ea7b38f773so747126b3a.0
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711527709; x=1712132509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f67ZtaJ8AkKsr4HgNrS910pATa/e8tKgin9DWtXpqJk=;
        b=Wj5N5AzmPRsxuRVqRX5ENi6r8RV3BYU082jq1zKpEoYdJgg0+PUcRY1iKaSPYPeOL9
         d1sPc+qEp7R47ACuaKyhl0rl47gL1t+WsBLCIFWMbakJneW8MnS7fIhs7qsnXZphbUJq
         9cKtb68iVBzRFD3zFf0qvcZB/B9sHFsbwngLlcwVAimTgGEirwVPNKFT7Ku5DPrfTs2u
         CVo8EN5lUjuH2xjKNTaCECBGMIlb9cBXYC53WCpeG5kBtzUa/Rxczgm/7W/v4dzDos/A
         rLFLs2Bbn26ymujAqLMz1L+eha+U/Oul4+RfBM0pE4cg0Wg5iPQgKLNg65Lf1T96PANF
         CMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527709; x=1712132509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f67ZtaJ8AkKsr4HgNrS910pATa/e8tKgin9DWtXpqJk=;
        b=awBki2HQZLyO2Eah1edrKhGCl0jxZPy5k54DYNpVNawyunOYrNGg2f76pIzxfE3l/5
         A6iNNSxHy9gCDr50wCFa33itvLsRcTpZuialK+MjjmXLLiOE04RRCujgncdvd84SV76D
         3hvEWgqaPdHghqtu9a7xCI3bsXWCTQ1nGEY7j5P6MRrNzaZz+A3p3WtyYPfdzeUa2FPo
         WuBQt1mHCjnQBKdkvYGuDT0Gd/dqvaLkk9q9RRF4ysxcXUJyDS7oq8gbFvs4Z0HiwRp1
         f+GLYIV4E7z8za/sgn20PccBNFF2dJgJvbaTuHQORg45E68Kf1ah/gKTj65HcrT/nJ3L
         ouEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJyfor0f/z4QweECEt/uBA0VUIpX1ASrxjUQ0lvwZTWS1VwA9LhuTiZWLZO72DWpB6vjFMZrL3qcKSW62tXSmmbwRTkLwW
X-Gm-Message-State: AOJu0Yy43Vz1JuMIMrFbrqYMiW3eEoiRiyKlJj42J0OMmmlbmyH3WGJL
	1y6brYvGqb7KgMDZQsN9yFmk+QHlblUI7tFdo7gIM6oyFecPGa3+4W1qPLM/ZNM=
X-Google-Smtp-Source: AGHT+IGS8ac20YFLkSxAWsdhO53XQrM4DVEDeeMqycMdVoYmPA938/W62IGRGFhhemwwLQzJbD/JqQ==
X-Received: by 2002:a17:903:50b:b0:1dc:82bc:c072 with SMTP id jn11-20020a170903050b00b001dc82bcc072mr13354220plb.1.1711527709243;
        Wed, 27 Mar 2024 01:21:49 -0700 (PDT)
Received: from mi.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090311d000b001e0ea87739dsm3211260plh.14.2024.03.27.01.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:21:48 -0700 (PDT)
From: Jian Wen <wenjianhn@gmail.com>
X-Google-Original-From: Jian Wen <wenjian1@xiaomi.com>
To: jiri@mellanox.com,
	aleksander.lobakin@intel.com,
	edumazet@google.com,
	davem@davemloft.net
Cc: Jian Wen <wenjian1@xiaomi.com>,
	netdev@vger.kernel.org,
	wenjianhn@gmail.com
Subject: [PATCH net-next v2] devlink: use kvzalloc() to allocate devlink instance resources
Date: Wed, 27 Mar 2024 16:21:28 +0800
Message-Id: <20240327082128.942818-1-wenjian1@xiaomi.com>
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

Changes since v1:
- Use struct_size(devlink, priv, priv_size) as suggested by Alexander Lobakin

Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
---
 net/devlink/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 7f0b093208d7..f49cd83f1955 100644
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
+	devlink = kvzalloc(struct_size(devlink, priv, priv_size), GFP_KERNEL);
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


