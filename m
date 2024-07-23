Return-Path: <netdev+bounces-112599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE08293A202
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727BD1F2380C
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01FC15445D;
	Tue, 23 Jul 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="AbVi6VO/"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4224E15383C
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742715; cv=none; b=gcnyWRM9Whf+nhaDSnBKOTqBo6jyQZD0FOh8bpqRsu3Qk3JsXiR28qBBmsh7UghO/IkVkGpf5fQrlYHLqprOuGXc/EN9UyR19ipisM5bktN/7xNr8FMrX5IMDe109R3loe+MSX7/apgKje7tubzCfI97h3qY6ZA9An6TkHNLIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742715; c=relaxed/simple;
	bh=NkYocc87x4moEF9BT1w93mvfLi/41StZVb45qZQ7PAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKIS5bzGy7lV+wzOpnYK2HbEReGp6zBBaHw4zvYwmM67SzaMgdrrQ8yRzBGTiVyQsBpDXklzxccg2Mr6ud6//3J+4+fQ5xlwrBMi4bhUQ6BwXcpd5cAcBg1ugNibK5C1iYVP2AqEdz7hTTO/AhgCm579ddDF67x9543ogzD26V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=AbVi6VO/; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 354EC7DCF0;
	Tue, 23 Jul 2024 14:51:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742706; bh=NkYocc87x4moEF9BT1w93mvfLi/41StZVb45qZQ7PAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2009/15]=20l2tp:=20free=20sessions=20using=20rcu|Date:=20Tue,=2
	 023=20Jul=202024=2014:51:37=20+0100|Message-Id:=20<2cdcbbbbd84ce78
	 d3170750b8c8bf939353d20c1.1721733730.git.jchapman@katalix.com>|In-
	 Reply-To:=20<cover.1721733730.git.jchapman@katalix.com>|References
	 :=20<cover.1721733730.git.jchapman@katalix.com>|MIME-Version:=201.
	 0;
	b=AbVi6VO/YYf/qCjNk5AT+ULsNWqTJ2rwZWoaabir32D1u9Eqayb3mwggpX+lTqVLv
	 hzTwaxLzXHoX/u/9r/95MTVXuEP4sISetrkmFN+kCHmzc3uWbV13a7pNnMZ8d9PLbY
	 t5Kuaokjo8CFFVX+CsoQDgwlV+bCbVYbar9nHbZEpvriJzu8Me6oiPqBojJfWEqZEu
	 +qw0hkXH+NgyFGBpHxPrC5vA7K68IlN1hKIYSO2Da/JywtB8xsAnb6lznOeyiEYiah
	 K4jJK6w9otVAge/rS0aHmsvhfgMDlYvZlqEMIYnfmLNgS3zwAyJ3VVOxV/8n8emcYI
	 5cbRfMsF78okQ==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 09/15] l2tp: free sessions using rcu
Date: Tue, 23 Jul 2024 14:51:37 +0100
Message-Id: <2cdcbbbbd84ce78d3170750b8c8bf939353d20c1.1721733730.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721733730.git.jchapman@katalix.com>
References: <cover.1721733730.git.jchapman@katalix.com>
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


