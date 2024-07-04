Return-Path: <netdev+bounces-109270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B749279FC
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE3C1C252D5
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE121B120C;
	Thu,  4 Jul 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="ClkXZoOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B1B1EB36;
	Thu,  4 Jul 2024 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106728; cv=none; b=ES7MOYdFPEpboqyYXBYLRazSJfUt6dzPX+0+J1N/lXPhwqvCACe2+2y+zjS0abN9TjjconV6UiqiS84ZDNkzhalxhSnJnB55lZfBgrZQIewVkO6/3Qt7laQX4/5UJe86zKG+tHPPsRvH2+kEZilw7oAmvb3b3SCOW6yxU1p4ZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106728; c=relaxed/simple;
	bh=xG+nvshkdwMpnM0jeUWG8AY2Qk2520+BbWVIqSKAHwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wl9vgqHZn6hF97ZkG2Gwhp7UZt3BWZFfXEhylTCOd6M9N4uAEou4xHjvEJbetHU/rqaKY9fEay5md7aalqMqzQyOxyFy5sFCyilwKc0lVatYauLo4Y/BNcIsZISBVVnBY/iwtpdtH7y63qu0ynWNF9KXqQEunNRaXVD+Y3mtbL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=ClkXZoOT; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:70d8:f4bb:e372:f774])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 5550E7D57F;
	Thu,  4 Jul 2024 16:25:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1720106725; bh=xG+nvshkdwMpnM0jeUWG8AY2Qk2520+BbWVIqSKAHwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09linux-kernel@vger.kernel.org,=
	 0D=0A=09pabeni@redhat.com,=0D=0A=09syzkaller-bugs@googlegroups.com
	 ,=0D=0A=09tparkin@katalix.com,=0D=0A=09hdanton@sina.com,=0D=0A=09J
	 ames=20Chapman=20<jchapman@katalix.com>,=0D=0A=09syzbot+b471b7c936
	 301a59745b@syzkaller.appspotmail.com,=0D=0A=09syzbot+c041b4ce3a6df
	 d1e63e2@syzkaller.appspotmail.com|Subject:=20[PATCH=20net-next=20v
	 2]=20l2tp:=20fix=20possible=20UAF=20when=20cleaning=20up=20tunnels
	 |Date:=20Thu,=20=204=20Jul=202024=2016:25:08=20+0100|Message-Id:=2
	 0<20240704152508.1923908-1-jchapman@katalix.com>|MIME-Version:=201
	 .0;
	b=ClkXZoOTb8KeZ4EnCMOk8/M3+xoSu6jUGr77BUdNXuN0vpiwYMK1a7BPESIze5Hku
	 3YacDnfJx5RU+6ybYV8scDEnRiUsXnrREOMG5Rw6EQ6JtA3Bq10pdGrQdz0vb0RKN9
	 Pb71/1pGPzgj9iIDrtevjVm3BWnwO7en5YVhVVdaw8fuPX3T/MJFkDPT5wrb+h8hRZ
	 XnwCD1lGb9ONrnMmwWR+kAjAUzA7PlDycphlGtsLglHLXeDGcv6MNfhKCxtGSLD572
	 /i0ICbF/mGT593/Z8a2XxNavDdrOSo1wLASMaAQmJlZbDjMLuCw5PaHq2CMCGee2Gy
	 9Qzs8QLuxB2jw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	tparkin@katalix.com,
	hdanton@sina.com,
	James Chapman <jchapman@katalix.com>,
	syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com,
	syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
Subject: [PATCH net-next v2] l2tp: fix possible UAF when cleaning up tunnels
Date: Thu,  4 Jul 2024 16:25:08 +0100
Message-Id: <20240704152508.1923908-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a UAF caused by a race when the L2TP work queue closes a
tunnel at the same time as a userspace thread closes a session in that
tunnel.

Tunnel cleanup is handled by a work queue which iterates through the
sessions contained within a tunnel, and closes them in turn.

Meanwhile, a userspace thread may arbitrarily close a session via
either netlink command or by closing the pppox socket in the case of
l2tp_ppp.

The race condition may occur when l2tp_tunnel_closeall walks the list
of sessions in the tunnel and deletes each one.  Currently this is
implemented using list_for_each_safe, but because the list spinlock is
dropped in the loop body it's possible for other threads to manipulate
the list during list_for_each_safe's list walk.  This can lead to the
list iterator being corrupted, leading to list_for_each_safe spinning.
One sequence of events which may lead to this is as follows:

 * A tunnel is created, containing two sessions A and B.
 * A thread closes the tunnel, triggering tunnel cleanup via the work
   queue.
 * l2tp_tunnel_closeall runs in the context of the work queue.  It
   removes session A from the tunnel session list, then drops the list
   lock.  At this point the list_for_each_safe temporary variable is
   pointing to the other session on the list, which is session B, and
   the list can be manipulated by other threads since the list lock has
   been released.
 * Userspace closes session B, which removes the session from its parent
   tunnel via l2tp_session_delete.  Since l2tp_tunnel_closeall has
   released the tunnel list lock, l2tp_session_delete is able to call
   list_del_init on the session B list node.
 * Back on the work queue, l2tp_tunnel_closeall resumes execution and
   will now spin forever on the same list entry until the underlying
   session structure is freed, at which point UAF occurs.

The solution is to iterate over the tunnel's session list using
list_first_entry_not_null to avoid the possibility of the list
iterator pointing at a list item which may be removed during the walk.

Also, have l2tp_tunnel_closeall ref each session while it processes it
to prevent another thread from freeing it.

	cpu1				cpu2
	---				---
					pppol2tp_release()

	spin_lock_bh(&tunnel->list_lock);
	for (;;) {
		session = list_first_entry_or_null(&tunnel->session_list,
						   struct l2tp_session, list);
		if (!session)
			break;
		list_del_init(&session->list);
		spin_unlock_bh(&tunnel->list_lock);

 					l2tp_session_delete(session);

		l2tp_session_delete(session);
		spin_lock_bh(&tunnel->list_lock);
	}
	spin_unlock_bh(&tunnel->list_lock);

Calling l2tp_session_delete on the same session twice isn't a problem
per-se, but if cpu2 manages to destruct the socket and unref the
session to zero before cpu1 progresses then it would lead to UAF.

Reported-by: syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com
Reported-by: syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
Fixes: d18d3f0a24fc ("l2tp: replace hlist with simple list for per-tunnel session list")

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>

---
v2:
  - hold session ref when processing tunnel close (Hillf Danton)
v1: https://lore.kernel.org/netdev/20240703185108.1752795-1-jchapman@katalix.com/
---
 net/l2tp/l2tp_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 64f446f0930b..2790a51e59e3 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1290,17 +1290,20 @@ static void l2tp_session_unhash(struct l2tp_session *session)
 static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
 {
 	struct l2tp_session *session;
-	struct list_head *pos;
-	struct list_head *tmp;
 
 	spin_lock_bh(&tunnel->list_lock);
 	tunnel->acpt_newsess = false;
-	list_for_each_safe(pos, tmp, &tunnel->session_list) {
-		session = list_entry(pos, struct l2tp_session, list);
+	for (;;) {
+		session = list_first_entry_or_null(&tunnel->session_list,
+						   struct l2tp_session, list);
+		if (!session)
+			break;
+		l2tp_session_inc_refcount(session);
 		list_del_init(&session->list);
 		spin_unlock_bh(&tunnel->list_lock);
 		l2tp_session_delete(session);
 		spin_lock_bh(&tunnel->list_lock);
+		l2tp_session_dec_refcount(session);
 	}
 	spin_unlock_bh(&tunnel->list_lock);
 }
-- 
2.34.1


