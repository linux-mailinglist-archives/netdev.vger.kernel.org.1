Return-Path: <netdev+bounces-250493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB73AD2F186
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 10:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 092B830109B1
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE93587A2;
	Fri, 16 Jan 2026 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NQoBm6ze"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E13587AB;
	Fri, 16 Jan 2026 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557230; cv=none; b=cclw57stiN1gDFDNbZNdzXqvbq9sa7rnFrNsWo0Srq1VoJ4J9XsW8EC9eqlrPn5TY0Pr2eFTFx8vKlcIal5IhXxgxcuDA5DJPpIL02WqU73qGvCbTiYcM2qK5pp8FGdgkAyJAHRgxLEpVKrywH+LskOCjZQWWA6Xt4UMgXSh8xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557230; c=relaxed/simple;
	bh=M478kraDJ8FL55aN/XsX6V+BvP/0Bl0eTfRT3Xhsvr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AJST5M0mtoDGsYvfeL6S6u+opx6W3fXdyprqSDjmDhCB2/cgtUkAaweC/jZcKT5KGaNMlWTQ5d4JbTvpw03u/RNd91P7O+bQGtEAx021W/DqU3uxkHo/cwOqQjkv6eiSWdbS0034nNFfZs4IXJr+SHJZtI+6bMrvVolm7mRHlS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NQoBm6ze; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=IG
	6FEphT3FP53L2a4lJ/nrcd7qTikV/7NmIBtVw2U3A=; b=NQoBm6zev1XEsStA4b
	dYVevbg6JaeT+v3NGkkPB/epp0bt9bVjDOg2PvrVWvdNGodFbqVw5h//BQn5r3lz
	VT2UiTZiG15t75pmEvyahPdiiB9S0N1UbzJWfvjWg52jAv5FUfPLK12zx9RN4ut1
	LewCiJpmYHErmTw4ch+3iUUrQ=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3LJiECmppTp7dNA--.35890S2;
	Fri, 16 Jan 2026 17:53:09 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netdevsim: fix a race issue related to the operation on bpf_bound_progs list
Date: Fri, 16 Jan 2026 17:53:08 +0800
Message-ID: <20260116095308.11441-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3LJiECmppTp7dNA--.35890S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFW3ZF1rJF1xuw43uw4fAFb_yoW7Cr47pa
	90qa4YkrWrXw17tw48Aw4j9rna9F1qyFW29ry7CryruFyDXryjyr15Kay5Xrs0grWUWF1S
	q3WDCr1aqr45AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrYFAUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wWYZ2lqCoUwGwAA32

From: Yun Lu <luyun@kylinos.cn>

The netdevsim driver lacks a protection mechanism for operations on the
bpf_bound_progs list. When the nsim_bpf_create_prog() performs
list_add_tail, it is possible that nsim_bpf_destroy_prog() is
simultaneously performs list_del. Concurrent operations on the list may
lead to list corruption and trigger a kernel crash as follows:

[  417.290971] kernel BUG at lib/list_debug.c:62!
[  417.290983] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  417.290992] CPU: 10 PID: 168 Comm: kworker/10:1 Kdump: loaded Not tainted 6.19.0-rc5 #1
[  417.291003] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  417.291007] Workqueue: events bpf_prog_free_deferred
[  417.291021] RIP: 0010:__list_del_entry_valid_or_report+0xa7/0xc0
[  417.291034] Code: a8 ff 0f 0b 48 89 fe 48 89 ca 48 c7 c7 48 a1 eb ae e8 ed fb a8 ff 0f 0b 48 89 fe 48 89 c2 48 c7 c7 80 a1 eb ae e8 d9 fb a8 ff <0f> 0b 48 89 d1 48 c7 c7 d0 a1 eb ae 48 89 f2 48 89 c6 e8 c2 fb a8
[  417.291040] RSP: 0018:ffffb16a40807df8 EFLAGS: 00010246
[  417.291046] RAX: 000000000000006d RBX: ffff8e589866f500 RCX: 0000000000000000
[  417.291051] RDX: 0000000000000000 RSI: ffff8e59f7b23180 RDI: ffff8e59f7b23180
[  417.291055] RBP: ffffb16a412c9000 R08: 0000000000000000 R09: 0000000000000003
[  417.291059] R10: ffffb16a40807c80 R11: ffffffffaf9edce8 R12: ffff8e594427ac20
[  417.291063] R13: ffff8e59f7b44780 R14: ffff8e58800b7a05 R15: 0000000000000000
[  417.291074] FS:  0000000000000000(0000) GS:ffff8e59f7b00000(0000) knlGS:0000000000000000
[  417.291079] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  417.291083] CR2: 00007fc4083efe08 CR3: 00000001c3626006 CR4: 0000000000770ee0
[  417.291088] PKRU: 55555554
[  417.291091] Call Trace:
[  417.291096]  <TASK>
[  417.291103]  nsim_bpf_destroy_prog+0x31/0x80 [netdevsim]
[  417.291154]  __bpf_prog_offload_destroy+0x2a/0x80
[  417.291163]  bpf_prog_dev_bound_destroy+0x6f/0xb0
[  417.291171]  bpf_prog_free_deferred+0x18e/0x1a0
[  417.291178]  process_one_work+0x18a/0x3a0
[  417.291188]  worker_thread+0x27b/0x3a0
[  417.291197]  ? __pfx_worker_thread+0x10/0x10
[  417.291207]  kthread+0xe5/0x120
[  417.291214]  ? __pfx_kthread+0x10/0x10
[  417.291221]  ret_from_fork+0x31/0x50
[  417.291230]  ? __pfx_kthread+0x10/0x10
[  417.291236]  ret_from_fork_asm+0x1a/0x30
[  417.291246]  </TASK>

Add a mutex lock, to prevent simultaneous addition and deletion operations
on the list.

Fixes: 31d3ad832948 ("netdevsim: add bpf offload support")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 drivers/net/netdevsim/bpf.c       | 6 ++++++
 drivers/net/netdevsim/dev.c       | 2 ++
 drivers/net/netdevsim/netdevsim.h | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index 49537d3c4120..5f17f68f3c08 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -244,7 +244,9 @@ static int nsim_bpf_create_prog(struct nsim_dev *nsim_dev,
 			    &state->state, &nsim_bpf_string_fops);
 	debugfs_create_bool("loaded", 0400, state->ddir, &state->is_loaded);
 
+	mutex_lock(&nsim_dev->progs_list_lock);
 	list_add_tail(&state->l, &nsim_dev->bpf_bound_progs);
+	mutex_unlock(&nsim_dev->progs_list_lock);
 
 	prog->aux->offload->dev_priv = state;
 
@@ -273,12 +275,16 @@ static int nsim_bpf_translate(struct bpf_prog *prog)
 static void nsim_bpf_destroy_prog(struct bpf_prog *prog)
 {
 	struct nsim_bpf_bound_prog *state;
+	struct nsim_dev *nsim_dev;
 
 	state = prog->aux->offload->dev_priv;
+	nsim_dev = state->nsim_dev;
 	WARN(state->is_loaded,
 	     "offload state destroyed while program still bound");
 	debugfs_remove_recursive(state->ddir);
+	mutex_lock(&nsim_dev->progs_list_lock);
 	list_del(&state->l);
+	mutex_unlock(&nsim_dev->progs_list_lock);
 	kfree(state);
 }
 
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 2683a989873e..dfd571b22107 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1647,6 +1647,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 	nsim_dev->test1 = NSIM_DEV_TEST1_DEFAULT;
 	nsim_dev->test2 = NSIM_DEV_TEST2_DEFAULT;
 	spin_lock_init(&nsim_dev->fa_cookie_lock);
+	mutex_init(&nsim_dev->progs_list_lock);
 
 	dev_set_drvdata(&nsim_bus_dev->dev, nsim_dev);
 
@@ -1785,6 +1786,7 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
 	devl_unregister(devlink);
 	kfree(nsim_dev->vfconfigs);
 	kfree(nsim_dev->fa_cookie);
+	mutex_destroy(&nsim_dev->progs_list_lock);
 	devl_unlock(devlink);
 	devlink_free(devlink);
 	dev_set_drvdata(&nsim_bus_dev->dev, NULL);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index d1a941e2b18f..46c67983c517 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -324,6 +324,7 @@ struct nsim_dev {
 	u32 prog_id_gen;
 	struct list_head bpf_bound_progs;
 	struct list_head bpf_bound_maps;
+	struct mutex progs_list_lock;
 	struct netdev_phys_item_id switch_id;
 	struct list_head port_list;
 	bool fw_update_status;
-- 
2.43.0


