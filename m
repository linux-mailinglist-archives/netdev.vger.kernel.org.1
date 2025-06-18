Return-Path: <netdev+bounces-199098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE8ADEED4
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5C73BC5C7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA342EAB86;
	Wed, 18 Jun 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHIzePg9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2255285417
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255731; cv=none; b=noulLqVyjL9LhwQRi9cBDf4FhuHnSurJODLnnM7NVopkyWGXoEBDn7ndQ5IL0MoHA/tWzRWgXe/2n8PCzPblnN8x9STzF8iJqV71XsHM7B1kOgFf3UrpJz/4ODGeAoSy/inlMBvTPitdFYzgFaBHPbvyY+J/46sL1QqbB1mGnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255731; c=relaxed/simple;
	bh=ZT7qhFHJR+cFJrqhoomgkT9D4jcjgiajLVwgy5Wuckc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rUoZeQ241YC8zrxKCQpb07IlHGog2MTAdzsvCB/615wXfU9rhuB0lCxB52k2lmqLqQUK9AkYF5cljQkEGZdY0QoCfqF7eNz287TNim7I5k/xDbFx7Pgiyv5n+3C2yRj8qJ1a0Wnd0MkV3iBFHbFswzr+wHr6W7e2qkFPZyDoLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NHIzePg9; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7d3d3f6471cso596115185a.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750255728; x=1750860528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CMRMYchdnhHCNNMgVN/cSEcYAAi4vjyCEc537+i+NU0=;
        b=NHIzePg9Ocu99N2FBf6gKfqGRyJ8L/QKs6+62lJXchXuidl0Qq/sTWmJ7zPdKDJIyO
         bD71c5hy57klBodwqfZ/dbCO/iGTiNdLsLs4OfKVXYScHXIHNi6Dhn2LNq9UfyGzLz25
         VQOdvtcVUwHkt4tsBSyMiJAkmYCqbrNLvJbSmMGpnt3luemn19bo7LEwnkMjDuXawd7f
         X98hjA0T8mpY5vir0rHzlmD9XPURFeDd9ZYc/G+IVtE9dk8YgxibKDx3ByO5W0djs302
         z11DIIsTeTZTcs466bPw6ryxp5wJEKIrwblj1XWpreWiVsh9m93U8K0THR4joy6oyRLD
         tyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750255728; x=1750860528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMRMYchdnhHCNNMgVN/cSEcYAAi4vjyCEc537+i+NU0=;
        b=Ai3KkAC1ECTk/IVPuLo0poIfeXfOHTxj2zYUZxGlwv0boBDEMOTOWB5rXbEvz9C7cz
         D50V4bHFqsZ0r6hOmQkyDRdoQO2HkRNUHWao8WcXHR36vXB+RjeZyoK/BdnhbZGVIQ5l
         nw4fFJuvv0uFzbbc62hirY5cRBKFqt4JuInxbDlyj97q4tcr40r+Q+HmfFCIWtXPemiY
         Ml6YrD8yB9tkuGBprr/zDgxkizwvgTHOBouMZUaF+Bk/amWvafyphaAEgYKqMVm+DvUf
         9K4fzcpeYSX3GwAVx9azumWEgMQp1oolSdCKSbrcRP0CklqDfc14+ZMdIwUYIWYYqjSQ
         q/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWVI6YRLk8pk7pZrUrKTOaG1FGNsLcTgRkh1TVNv9stiI8rBe6oB4aM6WJKdqO6KyzDf1dQSh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo8b9evi6MxrA1i1+y2QgMzhDkFKS2SRDrvV4WiM4r+UKNMGWR
	9JLNFWze5vPuZGAmwxpfbtel+2jlHlMd4nBa2+TG9uTJrY5AdV8vTTgRiHHqLJ6uKkJZV1BBYmi
	5SNoHwbGcrFQUWg==
X-Google-Smtp-Source: AGHT+IHrgC1wwbyrU+jRlldU7pMt7hXbyBVnQbLXFavqsrgcLJdv0JGBgwoyaey0SEsT9iSMeMaPtMwmz70K6w==
X-Received: from qknpb8.prod.google.com ([2002:a05:620a:8388:b0:7d3:8fcb:3424])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:269a:b0:7c5:5670:bd6f with SMTP id af79cd13be357-7d3c6d0bcefmr2614212185a.53.1750255728622;
 Wed, 18 Jun 2025 07:08:48 -0700 (PDT)
Date: Wed, 18 Jun 2025 14:08:43 +0000
In-Reply-To: <20250618140844.1686882-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618140844.1686882-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250618140844.1686882-2-edumazet@google.com>
Subject: [PATCH net 1/2] net: atm: add lec_mutex
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+8b64dec3affaed7b3af5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot found its way in net/atm/lec.c, and found an error path
in lecd_attach() could leave a dangling pointer in dev_lec[].

Add a mutex to protect dev_lecp[] uses from lecd_attach(),
lec_vcc_attach() and lec_mcast_attach().

Following patch will use this mutex for /proc/net/atm/lec.

BUG: KASAN: slab-use-after-free in lecd_attach net/atm/lec.c:751 [inline]
BUG: KASAN: slab-use-after-free in lane_ioctl+0x2224/0x23e0 net/atm/lec.c:1008
Read of size 8 at addr ffff88807c7b8e68 by task syz.1.17/6142

CPU: 1 UID: 0 PID: 6142 Comm: syz.1.17 Not tainted 6.16.0-rc1-syzkaller-00239-g08215f5486ec #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
  print_address_description mm/kasan/report.c:408 [inline]
  print_report+0xcd/0x680 mm/kasan/report.c:521
  kasan_report+0xe0/0x110 mm/kasan/report.c:634
  lecd_attach net/atm/lec.c:751 [inline]
  lane_ioctl+0x2224/0x23e0 net/atm/lec.c:1008
  do_vcc_ioctl+0x12c/0x930 net/atm/ioctl.c:159
  sock_do_ioctl+0x118/0x280 net/socket.c:1190
  sock_ioctl+0x227/0x6b0 net/socket.c:1311
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:907 [inline]
  __se_sys_ioctl fs/ioctl.c:893 [inline]
  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Allocated by task 6132:
  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
  kasan_kmalloc include/linux/kasan.h:260 [inline]
  __do_kmalloc_node mm/slub.c:4328 [inline]
  __kvmalloc_node_noprof+0x27b/0x620 mm/slub.c:5015
  alloc_netdev_mqs+0xd2/0x1570 net/core/dev.c:11711
  lecd_attach net/atm/lec.c:737 [inline]
  lane_ioctl+0x17db/0x23e0 net/atm/lec.c:1008
  do_vcc_ioctl+0x12c/0x930 net/atm/ioctl.c:159
  sock_do_ioctl+0x118/0x280 net/socket.c:1190
  sock_ioctl+0x227/0x6b0 net/socket.c:1311
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:907 [inline]
  __se_sys_ioctl fs/ioctl.c:893 [inline]
  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6132:
  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
  poison_slab_object mm/kasan/common.c:247 [inline]
  __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
  kasan_slab_free include/linux/kasan.h:233 [inline]
  slab_free_hook mm/slub.c:2381 [inline]
  slab_free mm/slub.c:4643 [inline]
  kfree+0x2b4/0x4d0 mm/slub.c:4842
  free_netdev+0x6c5/0x910 net/core/dev.c:11892
  lecd_attach net/atm/lec.c:744 [inline]
  lane_ioctl+0x1ce8/0x23e0 net/atm/lec.c:1008
  do_vcc_ioctl+0x12c/0x930 net/atm/ioctl.c:159
  sock_do_ioctl+0x118/0x280 net/socket.c:1190
  sock_ioctl+0x227/0x6b0 net/socket.c:1311
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:907 [inline]
  __se_sys_ioctl fs/ioctl.c:893 [inline]
  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893

Fixes: da177e4c3f41 ("Linux-2.6.12-rc2")
Reported-by: syzbot+8b64dec3affaed7b3af5@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6852c6f6.050a0220.216029.0018.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/atm/lec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index acef984f3367094ec6d30419166b8462c88181b3..1e1f3eb0e2ba3cc1caa52e49327cecb8d18250e7 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -124,6 +124,7 @@ static unsigned char bus_mac[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
 /* Device structures */
 static struct net_device *dev_lec[MAX_LEC_ITF];
+static DEFINE_MUTEX(lec_mutex);
 
 #if IS_ENABLED(CONFIG_BRIDGE)
 static void lec_handle_bridge(struct sk_buff *skb, struct net_device *dev)
@@ -685,6 +686,7 @@ static int lec_vcc_attach(struct atm_vcc *vcc, void __user *arg)
 	int bytes_left;
 	struct atmlec_ioc ioc_data;
 
+	lockdep_assert_held(&lec_mutex);
 	/* Lecd must be up in this case */
 	bytes_left = copy_from_user(&ioc_data, arg, sizeof(struct atmlec_ioc));
 	if (bytes_left != 0)
@@ -710,6 +712,7 @@ static int lec_vcc_attach(struct atm_vcc *vcc, void __user *arg)
 
 static int lec_mcast_attach(struct atm_vcc *vcc, int arg)
 {
+	lockdep_assert_held(&lec_mutex);
 	if (arg < 0 || arg >= MAX_LEC_ITF)
 		return -EINVAL;
 	arg = array_index_nospec(arg, MAX_LEC_ITF);
@@ -725,6 +728,7 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
 	int i;
 	struct lec_priv *priv;
 
+	lockdep_assert_held(&lec_mutex);
 	if (arg < 0)
 		arg = 0;
 	if (arg >= MAX_LEC_ITF)
@@ -742,6 +746,7 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
 		snprintf(dev_lec[i]->name, IFNAMSIZ, "lec%d", i);
 		if (register_netdev(dev_lec[i])) {
 			free_netdev(dev_lec[i]);
+			dev_lec[i] = NULL;
 			return -EINVAL;
 		}
 
@@ -1003,6 +1008,7 @@ static int lane_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		return -ENOIOCTLCMD;
 	}
 
+	mutex_lock(&lec_mutex);
 	switch (cmd) {
 	case ATMLEC_CTRL:
 		err = lecd_attach(vcc, (int)arg);
@@ -1017,6 +1023,7 @@ static int lane_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		break;
 	}
 
+	mutex_unlock(&lec_mutex);
 	return err;
 }
 
-- 
2.50.0.rc2.696.g1fc2a0284f-goog


