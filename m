Return-Path: <netdev+bounces-108553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28C92432E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523E1B260A1
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06001BD016;
	Tue,  2 Jul 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqK076EE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A116131A
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936368; cv=none; b=Vdln1gf0cZr177VEoI8aMN91mkbIG0iyFF1S/9DmXSHD0HefbHPOt+2JK4tGj+DHu1eIO6MyHFd04+ZwboRtx7IuWMtuUcPlTR7VxrUOnP90hQ/MSpVWVaZCoTaoCOrKLPprKCitHlIA8uEBgqlvGijT77YeXLseb5mBi3AJSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936368; c=relaxed/simple;
	bh=4dzETbi9Y/b084FicibKmVea7ZM5e5Sg03XoJbguRug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ms+Brxno6VA/SCvC7W3ltO4jQaAO1aYHvJZdw3q2WH05peUgGcYvIkNYYRWDoa7S5ncoaJXc1m7+sTicK121YlQ+8lqZRb2STdElSYcTolqDaZ3BKGIVDUofMhqGrw4U5sKopFrhTv31hDqZysZa3Xx7GfFszlFhjyYh1gDhaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqK076EE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719936365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mjj83sWED4E39rMUhKU3CbXImDWJ5adzZW0P/Iuo6cg=;
	b=SqK076EEOEsKc9nBgKIsYY/7//1Qd5tJ/P1pdusfvKw1RyakKzTdeKuA7DWOv+OjJ4bUEe
	FIw+XZ4kDw9BdUpMrp2RsX1Pp8AUHx4QkrM7ymY77pcmyi5VaeAb3Ever3YAa6jtkj/ee6
	DPMi8GZbqXX9xxuwZi/+SEq4XVT09qU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-nYBUGwRyPxa3M9xpWsOu8Q-1; Tue, 02 Jul 2024 12:06:04 -0400
X-MC-Unique: nYBUGwRyPxa3M9xpWsOu8Q-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-704d99cb97aso2843258a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 09:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719936363; x=1720541163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mjj83sWED4E39rMUhKU3CbXImDWJ5adzZW0P/Iuo6cg=;
        b=g27W9EIpXITJIx9w64UGg9eECSCPD+ie6yLyNvn7HqIjcmy4yCNYvL82UY5EuAWI37
         1zOb5fUvggiG3A5XOer5hdMQUmVf0CqoVrQosgsuWY/ZmxBngSC8qTF4jboDxuYAlXHq
         0SI8S7e7cvssS7FEtTwWDedDFVjFBvuZK60utGmLqUMSlaHnaVvMDuZGyMtVmuxvu/yv
         EU8TLMXtZR6miyXmU9NDNiY4z4GhP0MCCP8SysihWGGPfG2Dqr4unyYQaIKingwirBMJ
         CkrUyD5JCrJ4Gfln8rFwiVXFxOJl1GaxvJc/i76BMEeNZitJNWyqrvboCaxziljzscJk
         n9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfSFz9FscqYpCEKnC/2C3kPlJJ/c+JWtDGythzrKbTBFu7y7FXnWbptraDL6llQNszqO8ac2fOxfaxizPW8wS5c5Ul2nPb
X-Gm-Message-State: AOJu0YxYGgsYovlvfKGnrQSRLUe8nWhL58mF6FYtna7ZF9Ixv+Gw7ng5
	21Ts+BODnYMgASMzbgTAR4rlHjJrkwLB4KdGRbUxVgsH09I79pKj1tkih760rOoh6FFykA5wPNX
	4ErKOO3jXMS1xzTxWMClqsRJRXUTakq3DXfhJXqxnCiKpL71xo6RlAA==
X-Received: by 2002:a17:902:f545:b0:1f7:11c8:bdd3 with SMTP id d9443c01a7336-1fadbc95462mr61872635ad.29.1719936363107;
        Tue, 02 Jul 2024 09:06:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdwWP/5Xu3XpRWOahLnmgTsWWlEmtfBhnw9Oooenlhz1CzdwiplFFIvm2iazLql9A9mmRvUw==
X-Received: by 2002:a17:902:f545:b0:1f7:11c8:bdd3 with SMTP id d9443c01a7336-1fadbc95462mr61872425ad.29.1719936362728;
        Tue, 02 Jul 2024 09:06:02 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:ca7f:54ff:fe01:979d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac156903bsm85565195ad.208.2024.07.02.09.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 09:06:02 -0700 (PDT)
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
Subject: [PATCH net 1/2] af_unix: Fix uninit-value in __unix_walk_scc()
Date: Wed,  3 Jul 2024 01:04:27 +0900
Message-ID: <20240702160428.10153-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported uninit-value access in __unix_walk_scc() [1].

In the list_for_each_entry_reverse() loop, when the vertex's index
equals it's scc_index, the loop uses the variable vertex as a
temporary variable that points to a vertex in scc. And when the loop
is finished, the variable vertex points to the list head, in this case
scc, which is a local variable on the stack (more precisely, it's not
even scc and might underflow the call stack of __unix_walk_scc():
container_of(&scc, struct unix_vertex, scc_entry)).

However, the variable vertex is used under the label prev_vertex. So
if the edge_stack is not empty and the function jumps to the
prev_vertex label, the function will access invalid data on the
stack. This causes the uninit-value access issue.

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
v1->v2: https://lore.kernel.org/all/20240625152713.1147650-1-syoshida@redhat.com/
- A bit of elaboration on the commit message, as suggested by Iwashima-san.
- Bundle a selftest written by Iwashima-san.
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


