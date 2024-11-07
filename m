Return-Path: <netdev+bounces-142963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51149C0CEF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BBC1C2335E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F13217313;
	Thu,  7 Nov 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="a8KmyxpO"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C42170DA
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000698; cv=none; b=n5dUnuYBDfqSpvzfrBYUE8RIa6j6tau0R2V1TgGvSTfK/jFdEXbd+dbz2gtEKxz/H1ET6hO86tTTW9xwO80pYcY3loUAxCDG749b8RLA3y5CoLiUAWVeA7L6/7I8YvQNS6MKKX6QoKVLZprqyANR+lIKkL22m1rERuWmbJKB1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000698; c=relaxed/simple;
	bh=3qUhmyXsWhOp4uPJK3LUQsILliDUbyESwCBxGC1pFYw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Qn7v0pYpwJyEPr0lwT/asxeMMdbXW2YFqVitQdT9oDMKesziuYta5w1qijD87fc15vBqhvNkGHQ/cwlbXP7SSi/OeYcTwH3WByMLJJLwaBzS7gbzztQzpx8I1Cq5mAIEf+7C/i+dm7fTodujKiooy9COruJxk4YXhzwn2fQhU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=a8KmyxpO; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:643c:df37:334d:83f7])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id F072E7DAB8
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 17:31:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1731000695; bh=3qUhmyXsWhOp4uPJK3LUQsILliDUbyESwCBxGC1pFYw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Subject:=20[PATCH=20RFC]=20l2tp:=20fix=20warning=20in
	 =20l2tp_exit_net=20found=20by=20syzbot|Date:=20Thu,=20=207=20Nov=2
	 02024=2017:31:34=20+0000|Message-Id:=20<20241107173134.542802-1-jc
	 hapman@katalix.com>|MIME-Version:=201.0;
	b=a8KmyxpORMV9dc8om8uD1e05vBDjIc5zl+49G+MkLL4IUqkBdNw6av6lFjtATpPr4
	 AJMxC3J1cxL5gYuKh7MNDt5UtfJLHGm9BRqv7yEMa1REowCIJvj7pOotWWauVXsFp2
	 uKVWZk9zMZcZ11yZqTxLY7sVChDdWav9yCpI4CD82+4FXh5XTBG2YPC/msYZcr6Vey
	 Kj1LF4fDl+38q0P9+YnJFElq2gJPN+xV2YbSbHpRZUzxRH80bQMVS4GDlfPPMHCpGx
	 bhH7IvUi030Zu3v2Dq7OzYZzsHMxXv9pl1l8j7T4WFE24gK4oT0oSIbxV+KlCvZPX3
	 HLXixXZqFDdmg==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Subject: [PATCH RFC] l2tp: fix warning in l2tp_exit_net found by syzbot
Date: Thu,  7 Nov 2024 17:31:34 +0000
Message-Id: <20241107173134.542802-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following patch fixes a WARN_ON in l2tp found by syzbot but I am
not confident that it's the right approach, hence this RFC.

In l2tp's net exit handler, we check that an IDR is empty before
destroying it:

	WARN_ON_ONCE(!idr_is_empty(&pn->l2tp_tunnel_idr));
	idr_destroy(&pn->l2tp_tunnel_idr);

However, syzbot is able to provoke a condition where idr_is_empty
returns false despite there being no items in the IDR. This turns out
to be because the radix tree of the IDR contains one or more internal
radix-tree nodes and these cause idr_is_empty to return false. These
internal nodes are cleaned by idr_destroy.

Using idr_for_each to check that the IDR is empty instead of
idr_is_empty, as per the included patch, avoids the problem. But the
idr_is_empty pattern is used in other code too,
e.g. drivers/net/ethernet/mellanox/mlxsw/spectrum_pgt.c

Should idr_is_empty be returning false if the radix tree contains only
internal nodes?

Ref: https://syzkaller.appspot.com/bug?extid=332fe1e67018625f63c9

---
 net/l2tp/l2tp_core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 3eec23ac5ab1..369a2f2e459c 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1870,15 +1870,31 @@ static __net_exit void l2tp_pre_exit_net(struct net *net)
 	}
 }
 
+static int l2tp_idr_item_unexpected(int id, void *p, void *data)
+{
+	const char *idr_name = data;
+
+	pr_err("l2tp: %s IDR not empty at net %d exit\n", idr_name, id);
+	WARN_ON_ONCE(1);
+	return 1;
+}
+
 static __net_exit void l2tp_exit_net(struct net *net)
 {
 	struct l2tp_net *pn = l2tp_pernet(net);
 
-	WARN_ON_ONCE(!idr_is_empty(&pn->l2tp_v2_session_idr));
+	/* Our per-net IDRs should be empty. Check that is so, to
+	 * help catch cleanup races or refcnt leaks.
+	 */
+	idr_for_each(&pn->l2tp_v2_session_idr, l2tp_idr_item_unexpected,
+		     "v2_session");
+	idr_for_each(&pn->l2tp_v3_session_idr, l2tp_idr_item_unexpected,
+		     "v3_session");
+	idr_for_each(&pn->l2tp_tunnel_idr, l2tp_idr_item_unexpected,
+		     "tunnel");
+
 	idr_destroy(&pn->l2tp_v2_session_idr);
-	WARN_ON_ONCE(!idr_is_empty(&pn->l2tp_v3_session_idr));
 	idr_destroy(&pn->l2tp_v3_session_idr);
-	WARN_ON_ONCE(!idr_is_empty(&pn->l2tp_tunnel_idr));
 	idr_destroy(&pn->l2tp_tunnel_idr);
 }
 
-- 
2.34.1


