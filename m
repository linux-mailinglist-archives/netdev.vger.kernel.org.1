Return-Path: <netdev+bounces-106559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D306916D11
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920C01F2D72B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA23173322;
	Tue, 25 Jun 2024 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1uwt3oB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E5171E5E
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329245; cv=none; b=o2Uv1w63MkF7LLv6SpCmzVTNFxnYA1jsGXGHwehBo9mWIXoQ89oyfgrJYGvlX3TOjsYwzXLnezyvfPPXfH5mwvpqY7bqt5jNTQMuyR+Q0NYpOUW6GlmdGSU7s3J3jdsHJl8U2FIVbLIY55mRQhL/VPSGwZnzehpyN+QtuA3tmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329245; c=relaxed/simple;
	bh=+WcVSL0KKA9CcFOhOuMupHGjeLaj4MZCLJftxM4a44g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AjIaQi6b8u4oKRHMFUkSBJ36x9xyKzgqjzzuFZUu00ja1SzMDMhBmhLVE6j/HQBRdLTsZuJIh3rvTSyCf/rxJBP+CZdKJ853Za7iWbX0UJcgnSwh4OObvHSuc4o5TAbijw1VYZVuonpDuiMJQtNCvyP82Wz+JUpvjPQ+JB5Uric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1uwt3oB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719329241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zfintl4xFi3jkqndN7lZYEgLqOaNrHDfejqkWw4zv+c=;
	b=I1uwt3oBSRWX+Slq6pz6PgDPDKQTcqbLGQp2wscED9fGLyY4zcWpxWLkwRw8F2rhnQ1W3E
	Ne0n3GOeHSaWal5rdpxH62PgbS+yiPQ6ar05GU4hqV8TKPk9wmpFWScopCchxM77eqNAlx
	IokFtt1RAsCbrmq0D9L3Za+sUMRzFuU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-4IRvVCGAMSOK7S9QQ8W4EA-1; Tue, 25 Jun 2024 11:27:20 -0400
X-MC-Unique: 4IRvVCGAMSOK7S9QQ8W4EA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1f9ae96e9a0so67709445ad.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719329239; x=1719934039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zfintl4xFi3jkqndN7lZYEgLqOaNrHDfejqkWw4zv+c=;
        b=mdsoHqEYF/APtZUlMr6DZ5DHVBn+K9YLoO7u0eZwwVWMqGwTkduc6WHFlS4AB8R2gG
         4zcblkajgmu4MFXAASRikFeXelyzcxKWXO5ochzW8MLdhO9cek7uK6vPAXULcID3EyAq
         bNPqrnganhPw0Sh4jUCDlHOZZAojxwfwHRL28+McqBO/UJ6ci5y3iJW9/pezReQi7CKy
         xEc+TfQoj+Jw6yLjqe5AELK60ujM2aIy67xaNESAX/qc6BpN0Q7ftH7pdghBL/pSKWl8
         fy/7ZMLVpsd/nbSOsfXHSuAQJxSWSKJs+K/DNdlutYCzYLuSWBJbnf6DGjQ6puICSezs
         qCcw==
X-Forwarded-Encrypted: i=1; AJvYcCX8urzsE2IWZ4eVyPo8sh8jZ2PLdjTlPBRYN993rNNweDuj11aGULsw5rBCwZb3KFrllHNutNOj/8y/fqNYlvt1QVdu9ABG
X-Gm-Message-State: AOJu0YxWFDUxAVrvfO4hRjGGhtU9Fotyk6rtxYCxXsoX7LupWIMKo5RA
	PRKHZRxvHztCFT1/arRNFJqerMrs/MrAiviS7mRK6GjaQ3AdGfHJ3+RYMKLfAA5eVipxATuUY0B
	Ok0R67yXLXhixYmtbGmvMocgyWCaLFCsU4uhudXuoYfKea2P/dKomEw==
X-Received: by 2002:a17:902:db07:b0:1fa:e0c:8bd4 with SMTP id d9443c01a7336-1fa23f07142mr84236525ad.68.1719329238928;
        Tue, 25 Jun 2024 08:27:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYL4K9lr+/kOK9LeAB7zMklWaQ0azia43FX4KTSvwEG54+aSOPaoMnbQlhVYUQux1KXh9BFg==
X-Received: by 2002:a17:902:db07:b0:1fa:e0c:8bd4 with SMTP id d9443c01a7336-1fa23f07142mr84236305ad.68.1719329238553;
        Tue, 25 Jun 2024 08:27:18 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:ca7f:54ff:fe01:979d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5a87sm82525395ad.203.2024.06.25.08.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 08:27:18 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@amazon.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH net] af_unix: Fix uninit-value in __unix_walk_scc()
Date: Wed, 26 Jun 2024 00:27:13 +0900
Message-ID: <20240625152713.1147650-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported uninit-value access in __unix_walk_scc() [1].

In the list_for_each_entry_reverse() loop, when the vertex's index equals
it's scc_index, the loop uses the variable vertex as a temporary variable
that points to a vertex in scc. And when the loop is finished, the variable
vertex points to the list head, in this case scc, which is a local variable
on the stack.

However, the variable vertex is used under the label prev_vertex. So if the
edge_stack is not empty and the function jumps to the prev_vertex label,
the function will access invalid data on the stack. This causes the
uninit-value access issue.

Fix this by introducing a new temporary variable for the loop.

[1]
BUG: KMSAN: uninit-value in __unix_walk_scc net/unix/garbage.c:478 [inline]
BUG: KMSAN: uninit-value in unix_walk_scc net/unix/garbage.c:526 [inline]
BUG: KMSAN: uninit-value in __unix_gc+0x2589/0x3c20 net/unix/garbage.c:584
 __unix_walk_scc net/unix/garbage.c:478 [inline]
 unix_walk_scc net/unix/garbage.c:526 [inline]
 __unix_gc+0x2589/0x3c20 net/unix/garbage.c:584
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xade/0x1bf0 kernel/workqueue.c:3312
 worker_thread+0xeb6/0x15b0 kernel/workqueue.c:3393
 kthread+0x3c4/0x530 kernel/kthread.c:389
 ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 unix_walk_scc net/unix/garbage.c:526 [inline]
 __unix_gc+0x2adf/0x3c20 net/unix/garbage.c:584
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xade/0x1bf0 kernel/workqueue.c:3312
 worker_thread+0xeb6/0x15b0 kernel/workqueue.c:3393
 kthread+0x3c4/0x530 kernel/kthread.c:389
 ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable entries created at:
 ref_tracker_free+0x48/0xf30 lib/ref_tracker.c:222
 netdev_tracker_free include/linux/netdevice.h:4058 [inline]
 netdev_put include/linux/netdevice.h:4075 [inline]
 dev_put include/linux/netdevice.h:4101 [inline]
 update_gid_event_work_handler+0xaa/0x1b0 drivers/infiniband/core/roce_gid_mgmt.c:813

CPU: 1 PID: 12763 Comm: kworker/u8:31 Not tainted 6.10.0-rc4-00217-g35bb670d65fc #32
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
Workqueue: events_unbound __unix_gc

Fixes: 3484f063172d ("af_unix: Detect Strongly Connected Components.")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/unix/garbage.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index dfe94a90ece4..23efb78fe9ef 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -476,6 +476,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 	}
 
 	if (vertex->index == vertex->scc_index) {
+		struct unix_vertex *v;
 		struct list_head scc;
 		bool scc_dead = true;
 
@@ -486,15 +487,15 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 		 */
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
+		list_for_each_entry_reverse(v, &scc, scc_entry) {
 			/* Don't restart DFS from this vertex in unix_walk_scc(). */
-			list_move_tail(&vertex->entry, &unix_visited_vertices);
+			list_move_tail(&v->entry, &unix_visited_vertices);
 
 			/* Mark vertex as off-stack. */
-			vertex->index = unix_vertex_grouped_index;
+			v->index = unix_vertex_grouped_index;
 
 			if (scc_dead)
-				scc_dead = unix_vertex_dead(vertex);
+				scc_dead = unix_vertex_dead(v);
 		}
 
 		if (scc_dead)
-- 
2.45.2


