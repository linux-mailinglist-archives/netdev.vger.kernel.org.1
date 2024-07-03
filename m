Return-Path: <netdev+bounces-108778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B78925642
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85C91F27706
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 09:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D3813BAE5;
	Wed,  3 Jul 2024 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQjCJc/q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A013440A
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998239; cv=none; b=GrfsqglbqIDV6Ya8TnnRKKdVzyZQEOZkA97CM2XAcNiGFUh/XMtGoO6TpJ/wajQ6P5/EfQoBW2hs64YTP2uHaZf3kk/WTZuZGt2Q0MS6uVJeHolcPe621ZRnXgcFZ4WqRZwLgjPMLk3mEABz1AnszjJBFmz8qygIiO5hfoQFIyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998239; c=relaxed/simple;
	bh=wS7lzFAGRGSUQzBCLpUo66s379++n6EjhtsAvlkoypo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJySCv+eFbbojpqVcZ+scAnacAxNcYQLLSRowYXZ0apa5ZfLGnPTOTmnwzXALHsj69jqhJHWmbR2cjqnR1nurhMTyG1z5vNHwrUw5SW+bhndzWBUjzevIO+Y0ML7DwLQ+Eyl4kUfPS+Kon+mUqpNbFE5Am/16/xDKLmtrDHQMRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQjCJc/q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719998236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nDRjbFmP01KxOsB0eGxpZsCd+/+50ehZGov31ZZvomA=;
	b=JQjCJc/qEfpIZurxWrcolY2DMkNqSVcop560FuFkUskIJLikL9MTqmYhK6XKestU7SICSO
	iOHvi2CQXUNjah3iC9DSmMFtTg1P8t4Wfsnnj05r3EldH1ZvWBHj08wEmHFVqEeoB4dpXJ
	Oe3qZA0WvWV9hxzgYMOMJ2w12ToB7e0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-TrGHmh-JP328ILSRUMtjlw-1; Wed, 03 Jul 2024 05:17:15 -0400
X-MC-Unique: TrGHmh-JP328ILSRUMtjlw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-700cd15a90cso5705710a34.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 02:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719998235; x=1720603035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDRjbFmP01KxOsB0eGxpZsCd+/+50ehZGov31ZZvomA=;
        b=YBlNVco15WIGhwR4hvZLJ4ES06/qYxEcUI2+RQPe35TPvcdqynvjS1PmR98Fh3MuqL
         Le2u4RTs0pp6sZxcCoFpMaqlprW9C3BsJRWzuHpF/HG7Z+9O1QKFglzc6chLioZtsiGd
         JCkyr7ZqeiazRtKQPP0sV9YiXY7vpCUBMcM+JCOLFT7JfadTZgSunhaMcaGzO1bbhx4J
         4wnwhTQKw20mCRTxgAmgBTxL/DhZHb/+GJi1aCnHYQibhaXkAZ9VDECzXthnK8EkpZ+T
         kRK7JHFvl1xCkLIMCPFST/WNuvD/nzoKllqjYzNuE0jbrkX1Qr3plCTn7RlKSHg1BPcL
         CZ6w==
X-Gm-Message-State: AOJu0YzjmGSLwNpGz6idPCF6J+JYI1hlRFL+IgzMmMT/m09Gs5i2WJWB
	ttLgxK+YDezNIkxa7N8n6lP/+JNOPdOs/mVyAhH7t0LvWsmwZ4oQ00HAfJ6ncyeR4cUm9MmELxB
	tj7VXRQknsSfvdryuKLDXByTtZQ8ay8eOBqhzmVDd2aLomNXivZNzSg==
X-Received: by 2002:a05:6870:1493:b0:25d:5024:4fae with SMTP id 586e51a60fabf-25db35c0336mr10443997fac.45.1719998234666;
        Wed, 03 Jul 2024 02:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEplzfCQnzMujnj6tcN/ISofTFNlDfMRPdQLw63q83nhzqBWn2jkHc0Ih43zLVejope70KeaQ==
X-Received: by 2002:a05:6870:1493:b0:25d:5024:4fae with SMTP id 586e51a60fabf-25db35c0336mr10443982fac.45.1719998234343;
        Wed, 03 Jul 2024 02:17:14 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:ca7f:54ff:fe01:979d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080205a180sm10257626b3a.18.2024.07.03.02.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 02:17:14 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH net] inet_diag: Initialize pad field in struct inet_diag_req_v2
Date: Wed,  3 Jul 2024 18:16:49 +0900
Message-ID: <20240703091649.111773-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported uninit-value access in raw_lookup() [1]. Diag for raw
sockets uses the pad field in struct inet_diag_req_v2 for the
underlying protocol. This field corresponds to the sdiag_raw_protocol
field in struct inet_diag_req_raw.

inet_diag_get_exact_compat() converts inet_diag_req to
inet_diag_req_v2, but leaves the pad field uninitialized. So the issue
occurs when raw_lookup() accesses the sdiag_raw_protocol field.

Fix this by initializing the pad field in
inet_diag_get_exact_compat(). Also, do the same fix in
inet_diag_dump_compat() to avoid the similar issue in the future.

[1]
BUG: KMSAN: uninit-value in raw_lookup net/ipv4/raw_diag.c:49 [inline]
BUG: KMSAN: uninit-value in raw_sock_get+0x657/0x800 net/ipv4/raw_diag.c:71
 raw_lookup net/ipv4/raw_diag.c:49 [inline]
 raw_sock_get+0x657/0x800 net/ipv4/raw_diag.c:71
 raw_diag_dump_one+0xa1/0x660 net/ipv4/raw_diag.c:99
 inet_diag_cmd_exact+0x7d9/0x980
 inet_diag_get_exact_compat net/ipv4/inet_diag.c:1404 [inline]
 inet_diag_rcv_msg_compat+0x469/0x530 net/ipv4/inet_diag.c:1426
 sock_diag_rcv_msg+0x23d/0x740 net/core/sock_diag.c:282
 netlink_rcv_skb+0x537/0x670 net/netlink/af_netlink.c:2564
 sock_diag_rcv+0x35/0x40 net/core/sock_diag.c:297
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0xe74/0x1240 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x10c6/0x1260 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x332/0x3d0 net/socket.c:745
 ____sys_sendmsg+0x7f0/0xb70 net/socket.c:2585
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2639
 __sys_sendmsg net/socket.c:2668 [inline]
 __do_sys_sendmsg net/socket.c:2677 [inline]
 __se_sys_sendmsg net/socket.c:2675 [inline]
 __x64_sys_sendmsg+0x27e/0x4a0 net/socket.c:2675
 x64_sys_call+0x135e/0x3ce0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd9/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 raw_sock_get+0x650/0x800 net/ipv4/raw_diag.c:71
 raw_diag_dump_one+0xa1/0x660 net/ipv4/raw_diag.c:99
 inet_diag_cmd_exact+0x7d9/0x980
 inet_diag_get_exact_compat net/ipv4/inet_diag.c:1404 [inline]
 inet_diag_rcv_msg_compat+0x469/0x530 net/ipv4/inet_diag.c:1426
 sock_diag_rcv_msg+0x23d/0x740 net/core/sock_diag.c:282
 netlink_rcv_skb+0x537/0x670 net/netlink/af_netlink.c:2564
 sock_diag_rcv+0x35/0x40 net/core/sock_diag.c:297
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0xe74/0x1240 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x10c6/0x1260 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x332/0x3d0 net/socket.c:745
 ____sys_sendmsg+0x7f0/0xb70 net/socket.c:2585
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2639
 __sys_sendmsg net/socket.c:2668 [inline]
 __do_sys_sendmsg net/socket.c:2677 [inline]
 __se_sys_sendmsg net/socket.c:2675 [inline]
 __x64_sys_sendmsg+0x27e/0x4a0 net/socket.c:2675
 x64_sys_call+0x135e/0x3ce0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd9/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable req.i created at:
 inet_diag_get_exact_compat net/ipv4/inet_diag.c:1396 [inline]
 inet_diag_rcv_msg_compat+0x2a6/0x530 net/ipv4/inet_diag.c:1426
 sock_diag_rcv_msg+0x23d/0x740 net/core/sock_diag.c:282

CPU: 1 PID: 8888 Comm: syz-executor.6 Not tainted 6.10.0-rc4-00217-g35bb670d65fc #32
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014

Fixes: 432490f9d455 ("net: ip, diag -- Add diag interface for raw sockets")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/ipv4/inet_diag.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 7adace541fe2..9712cdb8087c 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1383,6 +1383,7 @@ static int inet_diag_dump_compat(struct sk_buff *skb,
 	req.sdiag_family = AF_UNSPEC; /* compatibility */
 	req.sdiag_protocol = inet_diag_type2proto(cb->nlh->nlmsg_type);
 	req.idiag_ext = rc->idiag_ext;
+	req.pad = 0;
 	req.idiag_states = rc->idiag_states;
 	req.id = rc->id;
 
@@ -1398,6 +1399,7 @@ static int inet_diag_get_exact_compat(struct sk_buff *in_skb,
 	req.sdiag_family = rc->idiag_family;
 	req.sdiag_protocol = inet_diag_type2proto(nlh->nlmsg_type);
 	req.idiag_ext = rc->idiag_ext;
+	req.pad = 0;
 	req.idiag_states = rc->idiag_states;
 	req.id = rc->id;
 
-- 
2.45.2


