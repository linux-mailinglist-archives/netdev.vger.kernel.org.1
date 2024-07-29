Return-Path: <netdev+bounces-113703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E57193F9A1
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF881C220EE
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36F15D5C1;
	Mon, 29 Jul 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="U/2zMNgJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8D158D92
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267499; cv=none; b=oFShUAi8q1Syd44OMmacqhJAEPW6NKzuT8vHch6Z3O2cnVwchAtYGTYoDPzKk2Trq0WsswIMYPG9itj+IEPl9MPecqN7VV0/NkwmtFu6MfpTKf+FlNmiK2DjScAbr7q+PdQKwSSEL41hCPuKTtSq4lZg0tThzHUzCsb8Ropp2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267499; c=relaxed/simple;
	bh=eg9F/FDiHVx3s1ThnwBiHWCoM9DAnG154rBPFm+q2NA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUexFWthGgGAbxlTfkkEgOWWmcn+qs4Z3jSKuqqfgsaKmvWpQDoiviV8HjgD+SKWBfHJ/JonOJCs0MGBBBsOoLNSmqFXdsCJi2YWqCv3ZpzvFs3XEtzNxaInqm+3rD4d8ABOlM5ljR5WGNj4wawhDa4s0obCZU9JRQ2MzguiVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=U/2zMNgJ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 1E6F47DCF9;
	Mon, 29 Jul 2024 16:38:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267496; bh=eg9F/FDiHVx3s1ThnwBiHWCoM9DAnG154rBPFm+q2NA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2009/15]=20l2tp:=20free=20sessions=20using=20rcu|Date:=20M
	 on,=2029=20Jul=202024=2016:38:08=20+0100|Message-Id:=20<1d9c903d17
	 d8ec6e1e4f8a674693526a14a904ee.1722265212.git.jchapman@katalix.com
	 >|In-Reply-To:=20<cover.1722265212.git.jchapman@katalix.com>|Refer
	 ences:=20<cover.1722265212.git.jchapman@katalix.com>|MIME-Version:
	 =201.0;
	b=U/2zMNgJO7RJY9YbIdtE1mYq9x1WUjbr2x1WDmBd/l7aQMl38NzaBckLpnikAaWor
	 kyYPBHtn1o0WqQGIjmybySEnD0CDx6BhHcOIbEADJ0jgSUQcT3Ff0eC7nsRhMeizkM
	 nyMC3aLOLCuL+9BAkHX/16DyrpUpX3mKIq2rc1EDfR71Y47o1n3hhcwD4MZsf5U7In
	 FwI1xIM/LKqQH52bbuIVlQqNz3yGhOp/P6EP/r7a1PcQwXZXRosa+UApz9gC6DNW9d
	 9Lfvm6+/oWQ7nGKgru4PYjXmnkMwy8bm4F2lxjBwZJckyJlNDkMfRL+TywzNVW25Nt
	 o4gkaHj0QzhDQ==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 09/15] l2tp: free sessions using rcu
Date: Mon, 29 Jul 2024 16:38:08 +0100
Message-Id: <1d9c903d17d8ec6e1e4f8a674693526a14a904ee.1722265212.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722265212.git.jchapman@katalix.com>
References: <cover.1722265212.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp sessions may be accessed under an rcu read lock. Have them freed
via rcu and remove the now unneeded synchronize_rcu when a session is
removed.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 4 +---
 net/l2tp/l2tp_core.h | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index f6ae18c180bf..4cf4aa271353 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -166,7 +166,7 @@ static void l2tp_session_free(struct l2tp_session *session)
 	trace_free_session(session);
 	if (session->tunnel)
 		l2tp_tunnel_dec_refcount(session->tunnel);
-	kfree(session);
+	kfree_rcu(session, rcu);
 }
 
 struct l2tp_tunnel *l2tp_sk_to_tunnel(const struct sock *sk)
@@ -1269,8 +1269,6 @@ static void l2tp_session_unhash(struct l2tp_session *session)
 
 		spin_unlock_bh(&pn->l2tp_session_idr_lock);
 		spin_unlock_bh(&tunnel->list_lock);
-
-		synchronize_rcu();
 	}
 }
 
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 8d7a589ccd2a..58d3977870de 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -66,6 +66,7 @@ struct l2tp_session_coll_list {
 struct l2tp_session {
 	int			magic;		/* should be L2TP_SESSION_MAGIC */
 	long			dead;
+	struct rcu_head		rcu;
 
 	struct l2tp_tunnel	*tunnel;	/* back pointer to tunnel context */
 	u32			session_id;
-- 
2.34.1


