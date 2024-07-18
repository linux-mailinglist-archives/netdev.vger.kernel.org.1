Return-Path: <netdev+bounces-112093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C6A934E92
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED77282427
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220E113C687;
	Thu, 18 Jul 2024 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="zPdp3I/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF939457
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310743; cv=none; b=Mtmnz625zChqqnFy3/+iqipjyMsJTqsMh5HX2Y/aTk7Z1QgYubgQ6eV5kwjX4hWf6Pf1ICshmUsKnyGPRNPHUtl8foE45MGnH/l+CBEMxZVk7ib9s0+tueu0RvfSnEiE9o6D88NVblYvBGLPHuWTU8xTU3C1e67b5mAa84bO7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310743; c=relaxed/simple;
	bh=KyafeX6Zj0O7ykGwQOPEE7L+gVDCNoouBR3aL6Zr7Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o+VFPMEGaxI1eufmaBEGhSht4MR2WsWm80txpq38uOFQvdYqcwttC97/nHjvkMc7TuLViZIJ+9SI+f/27BDbCA6RZ8gJNEV7Hr5n+GrUc/9ypxQGFqYfVBNDRMfn0r8VJP5AoB7bAV4uKoWp7pCYh2lwhnIFqatG7VFpE7PUpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=zPdp3I/z; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:5998:706d:17c6:d75a])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 592957DA4E;
	Thu, 18 Jul 2024 14:43:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721310228; bh=KyafeX6Zj0O7ykGwQOPEE7L+gVDCNoouBR3aL6Zr7Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09tpa
	 rkin@katalix.com,=0D=0A=09samuel.thibault@ens-lyon.org,=0D=0A=09th
	 orsten.blum@toblux.com|Subject:=20[PATCH=20net]=20l2tp:=20make=20s
	 ession=20IDR=20and=20tunnel=20session=20list=20coherent|Date:=20Th
	 u,=2018=20Jul=202024=2014:43:48=20+0100|Message-Id:=20<20240718134
	 348.289865-1-jchapman@katalix.com>|MIME-Version:=201.0;
	b=zPdp3I/zPqTe8hR+AbtGZAkdndzN1y6LmBtAwOCD8s9JzbWIdP8wl/LW1Wx8WXfg3
	 +LogKgWNom7PRGypEWAik94lbB0zcM3ZvwHXU8fjZhLk+MLvgWj9+0lUsNUMRIhr4G
	 3hhMGsre4KwV1PFiX+ddCFsZaakb8wUsoC1cqA2i2/I3s4j3ionL2Q50KzWUrl8o+T
	 /wwYRmhTDeuOQkRmyx357wE6HJD9MSrqxMLy1vXJT7idLC0Bgq6+N+d5OWiyS9f4I6
	 tlN+LTZIZJyPWsUn3pSUzbqXFooAsjGgYyfIcHHburPyCQniQzlxDt7WhREqwS/MBT
	 mbtWXrv3An/Hg==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tparkin@katalix.com,
	samuel.thibault@ens-lyon.org,
	thorsten.blum@toblux.com
Subject: [PATCH net] l2tp: make session IDR and tunnel session list coherent
Date: Thu, 18 Jul 2024 14:43:48 +0100
Message-Id: <20240718134348.289865-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify l2tp_session_register and l2tp_session_unhash so that the
session IDR and tunnel session lists remain coherent. To do so, hold
the session IDR lock and the tunnel's session list lock when making
any changes to either list.

Without this change, a rare race condition could hit the WARN_ON_ONCE
in l2tp_session_unhash if a thread replaced the IDR entry while
another thread was registering the same ID.

 [ 7126.151795][T17511] WARNING: CPU: 3 PID: 17511 at net/l2tp/l2tp_core.c:1282 l2tp_session_delete.part.0+0x87e/0xbc0
 [ 7126.163754][T17511]  ? show_regs+0x93/0xa0
 [ 7126.164157][T17511]  ? __warn+0xe5/0x3c0
 [ 7126.164536][T17511]  ? l2tp_session_delete.part.0+0x87e/0xbc0
 [ 7126.165070][T17511]  ? report_bug+0x2e1/0x500
 [ 7126.165486][T17511]  ? l2tp_session_delete.part.0+0x87e/0xbc0
 [ 7126.166013][T17511]  ? handle_bug+0x99/0x130
 [ 7126.166428][T17511]  ? exc_invalid_op+0x35/0x80
 [ 7126.166890][T17511]  ? asm_exc_invalid_op+0x1a/0x20
 [ 7126.167372][T17511]  ? l2tp_session_delete.part.0+0x87d/0xbc0
 [ 7126.167900][T17511]  ? l2tp_session_delete.part.0+0x87e/0xbc0
 [ 7126.168429][T17511]  ? __local_bh_enable_ip+0xa4/0x120
 [ 7126.168917][T17511]  l2tp_session_delete+0x40/0x50
 [ 7126.169369][T17511]  pppol2tp_release+0x1a1/0x3f0
 [ 7126.169817][T17511]  __sock_release+0xb3/0x270
 [ 7126.170247][T17511]  ? __pfx_sock_close+0x10/0x10
 [ 7126.170697][T17511]  sock_close+0x1c/0x30
 [ 7126.171087][T17511]  __fput+0x40b/0xb90
 [ 7126.171470][T17511]  task_work_run+0x16c/0x260
 [ 7126.171897][T17511]  ? __pfx_task_work_run+0x10/0x10
 [ 7126.172362][T17511]  ? srso_alias_return_thunk+0x5/0xfbef5
 [ 7126.172863][T17511]  ? do_raw_spin_unlock+0x174/0x230
 [ 7126.173348][T17511]  do_exit+0xaae/0x2b40
 [ 7126.173730][T17511]  ? srso_alias_return_thunk+0x5/0xfbef5
 [ 7126.174235][T17511]  ? __pfx_lock_release+0x10/0x10
 [ 7126.174690][T17511]  ? srso_alias_return_thunk+0x5/0xfbef5
 [ 7126.175190][T17511]  ? do_raw_spin_lock+0x12c/0x2b0
 [ 7126.175650][T17511]  ? __pfx_do_exit+0x10/0x10
 [ 7126.176072][T17511]  ? _raw_spin_unlock_irq+0x23/0x50
 [ 7126.176543][T17511]  do_group_exit+0xd3/0x2a0
 [ 7126.176990][T17511]  __x64_sys_exit_group+0x3e/0x50
 [ 7126.177456][T17511]  x64_sys_call+0x1821/0x1830
 [ 7126.177895][T17511]  do_syscall_64+0xcb/0x250
 [ 7126.178317][T17511]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: aa5e17e1f5ec ("l2tp: store l2tpv3 sessions in per-net IDR")
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 1c1decce7f06..c80ab3f26084 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -441,14 +441,15 @@ int l2tp_session_register(struct l2tp_session *session,
 	int err;
 
 	spin_lock_bh(&tunnel->list_lock);
+	spin_lock_bh(&pn->l2tp_session_idr_lock);
+
 	if (!tunnel->acpt_newsess) {
 		err = -ENODEV;
-		goto err_tlock;
+		goto out;
 	}
 
 	if (tunnel->version == L2TP_HDR_VER_3) {
 		session_key = session->session_id;
-		spin_lock_bh(&pn->l2tp_session_idr_lock);
 		err = idr_alloc_u32(&pn->l2tp_v3_session_idr, NULL,
 				    &session_key, session_key, GFP_ATOMIC);
 		/* IP encap expects session IDs to be globally unique, while
@@ -462,43 +463,36 @@ int l2tp_session_register(struct l2tp_session *session,
 			err = l2tp_session_collision_add(pn, session,
 							 other_session);
 		}
-		spin_unlock_bh(&pn->l2tp_session_idr_lock);
 	} else {
 		session_key = l2tp_v2_session_key(tunnel->tunnel_id,
 						  session->session_id);
-		spin_lock_bh(&pn->l2tp_session_idr_lock);
 		err = idr_alloc_u32(&pn->l2tp_v2_session_idr, NULL,
 				    &session_key, session_key, GFP_ATOMIC);
-		spin_unlock_bh(&pn->l2tp_session_idr_lock);
 	}
 
 	if (err) {
 		if (err == -ENOSPC)
 			err = -EEXIST;
-		goto err_tlock;
+		goto out;
 	}
 
 	l2tp_tunnel_inc_refcount(tunnel);
-
 	list_add(&session->list, &tunnel->session_list);
-	spin_unlock_bh(&tunnel->list_lock);
 
-	spin_lock_bh(&pn->l2tp_session_idr_lock);
 	if (tunnel->version == L2TP_HDR_VER_3) {
 		if (!other_session)
 			idr_replace(&pn->l2tp_v3_session_idr, session, session_key);
 	} else {
 		idr_replace(&pn->l2tp_v2_session_idr, session, session_key);
 	}
-	spin_unlock_bh(&pn->l2tp_session_idr_lock);
-
-	trace_register_session(session);
 
-	return 0;
-
-err_tlock:
+out:
+	spin_unlock_bh(&pn->l2tp_session_idr_lock);
 	spin_unlock_bh(&tunnel->list_lock);
 
+	if (!err)
+		trace_register_session(session);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(l2tp_session_register);
@@ -1260,13 +1254,13 @@ static void l2tp_session_unhash(struct l2tp_session *session)
 		struct l2tp_net *pn = l2tp_pernet(tunnel->l2tp_net);
 		struct l2tp_session *removed = session;
 
-		/* Remove from the per-tunnel list */
 		spin_lock_bh(&tunnel->list_lock);
+		spin_lock_bh(&pn->l2tp_session_idr_lock);
+
+		/* Remove from the per-tunnel list */
 		list_del_init(&session->list);
-		spin_unlock_bh(&tunnel->list_lock);
 
 		/* Remove from per-net IDR */
-		spin_lock_bh(&pn->l2tp_session_idr_lock);
 		if (tunnel->version == L2TP_HDR_VER_3) {
 			if (hash_hashed(&session->hlist))
 				l2tp_session_collision_del(pn, session);
@@ -1280,7 +1274,9 @@ static void l2tp_session_unhash(struct l2tp_session *session)
 					     session_key);
 		}
 		WARN_ON_ONCE(removed && removed != session);
+
 		spin_unlock_bh(&pn->l2tp_session_idr_lock);
+		spin_unlock_bh(&tunnel->list_lock);
 
 		synchronize_rcu();
 	}
-- 
2.34.1


