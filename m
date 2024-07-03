Return-Path: <netdev+bounces-109018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD18D9268A1
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6DF1F210DC
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCDE187570;
	Wed,  3 Jul 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="pcseMG5l"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9543217DA02;
	Wed,  3 Jul 2024 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720032703; cv=none; b=AvrOUdYIQK8IsAnIkZM7j8+somlGIrf6PVi7//nJGb57SjdBDEbBf169YtdNLprvQMEgDmfZrkLisB6PNHrCvXiun7eKy0gz/fApds6ENdJh888RHnOSnhqyLQxH4RAbSQIoOeQvTb/u+EuvZ1Utgd02PWLSpT7W8cxHO1bK8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720032703; c=relaxed/simple;
	bh=usyYEl6aoJBeL0nIMgMejoTFHIpo52vrsasnARDQLqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d82hd7OZ/HTGhnM0se3NNhqNLhv+X9ev//Sr2qIL8iPIPFtxi6G0IVSGxzisTlr2YIskXJ/OUQwGkbeqQiC7jLevLF6yu9mZ3Fop/E2+zkGbR8x+AtXYtPoQeUzUgy38NxQ/FApbjiW9OM7OHqAW4FPrL1DBMB5w+iVuj/kuW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=pcseMG5l; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:ccf0:7211:42ee:b851])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 7392E7D57F;
	Wed,  3 Jul 2024 19:51:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1720032700; bh=usyYEl6aoJBeL0nIMgMejoTFHIpo52vrsasnARDQLqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09linux-kernel@vger.kernel.org,=
	 0D=0A=09pabeni@redhat.com,=0D=0A=09syzkaller-bugs@googlegroups.com
	 ,=0D=0A=09tparkin@katalix.com,=0D=0A=09James=20Chapman=20<jchapman
	 @katalix.com>,=0D=0A=09syzbot+b471b7c936301a59745b@syzkaller.appsp
	 otmail.com,=0D=0A=09syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotm
	 ail.com|Subject:=20[PATCH=20net-next]=20l2tp:=20fix=20possible=20U
	 AF=20when=20cleaning=20up=20tunnels|Date:=20Wed,=20=203=20Jul=2020
	 24=2019:51:08=20+0100|Message-Id:=20<20240703185108.1752795-1-jcha
	 pman@katalix.com>|MIME-Version:=201.0;
	b=pcseMG5lZi6Io+6cggrcGvoa4U9md33SwY+6jB9Jy6AG4uX7D0oD6pvh9PUU0rAgO
	 O6miGQbKGjbWlxg39AVP9qMppFZzVvzRxqMzePXOY6f5hkuouOtwiUxEE3lizlGvs7
	 JwfUYWCrC6dZ0kXHG+QYWLEjQ6UxAAUWR4J6oedYhUtatKWIamTLD51hwxcNk1WZGJ
	 7QLBF98NlqbI4BO6D4W2qsJHXW0jlGCML79DglsVrn7qE6SNck3r7fi4Cbjfkje0nw
	 xVLMcTJvTP7RuOBOdy0954FuM9zzuRD8SG56gKTBG/d43YYIR8DAVsjCHqNvD+xKYe
	 kRtjOyNxLBfug==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	tparkin@katalix.com,
	James Chapman <jchapman@katalix.com>,
	syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com,
	syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
Subject: [PATCH net-next] l2tp: fix possible UAF when cleaning up tunnels
Date: Wed,  3 Jul 2024 19:51:08 +0100
Message-Id: <20240703185108.1752795-1-jchapman@katalix.com>
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

Reported-by: syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com
Reported-by: syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
Fixes: d18d3f0a24f ("l2tp: replace hlist with simple list for per-tunnel session list")

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 64f446f0930b..afa180b7b428 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1290,13 +1290,14 @@ static void l2tp_session_unhash(struct l2tp_session *session)
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
 		list_del_init(&session->list);
 		spin_unlock_bh(&tunnel->list_lock);
 		l2tp_session_delete(session);
-- 
2.34.1


