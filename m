Return-Path: <netdev+bounces-145850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E0F9D12BA
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B199B283619
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4797119B5A9;
	Mon, 18 Nov 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="FUltMNtW"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832131991C6;
	Mon, 18 Nov 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939261; cv=none; b=Is15TfuYAcvOBdBnE0wraYDxjTVJ2lcqJ9XmwVIl8RKKEmOqe8w4L+OdmFPULBU/NeI/GhmmXFRGSUYc7l18tsNz1AfO4WvqrmE5y+9PeKztErk4PfTLqBN9/RsLYYnxwXb1CcGci7Yiv9Lj3tekrYS0bOVzM+OXfHmFhT4oRLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939261; c=relaxed/simple;
	bh=xF4ztao5+Y+7uUJATeyzm2Km8pJHEPLfPs6TcMj2k0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DfQ+63TlxKY4reFRsYCI+Bo8SisweEhWMo64kLJz/+ILX21vLqqmCf3bhZJJ0kmyt28TLAy5k3cZao79wlR0neX0aEicaaD+6ph335GzKA4xVjoabUpgVkPVnuwElMipSkRFZWP2TQHAa63t5lIawsbOBIcpR6sF+mgmWfzc7OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=FUltMNtW; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:c02c:fe13:9a85:43d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 018CE7D9B6;
	Mon, 18 Nov 2024 14:04:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1731938652; bh=xF4ztao5+Y+7uUJATeyzm2Km8pJHEPLfPs6TcMj2k0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09guohui.study@gmail.com,=0D=0A=09horms@kernel.org,=0D=0A
	 =09kuba@kernel.org,=0D=0A=09linux-kernel@vger.kernel.org,=0D=0A=09
	 pabeni@redhat.com,=0D=0A=09syzkaller-bugs@googlegroups.com,=0D=0A=
	 09syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com,=0D=0A=09t
	 parkin@katalix.com|Subject:=20[PATCH=20net]=20net/l2tp:=20fix=20wa
	 rning=20in=20l2tp_exit_net=20found=20by=20syzbot|Date:=20Mon,=2018
	 =20Nov=202024=2014:04:11=20+0000|Message-Id:=20<20241118140411.158
	 2555-1-jchapman@katalix.com>|MIME-Version:=201.0;
	b=FUltMNtWCgl+Xdjzj5hJsQi4jSz1+Du1YXN+P7Ie6whANgQOmUpoJHCgoXfYhABQ3
	 TjFYE7ZhEEgvB4MNhE3NFW3FZ+1uM8u6ZucOHa7h2q3EA9ARdTnRpOncnA7uGRtRzV
	 Ax22wNzjuUbDIFl0s66Whtu8kS5FfQ4P5veTcXg+tyAIDuY3p5qMHq8PduKm/RoZwY
	 wbCiunrq2d9ZhXTGCwFJeGXa52E9E+oK/mOZS+d9oCV8wMDSbudN4wVaaTFy7LuHhQ
	 /U/HAeNaPQtni3ESCoRGw7Ey/z+VqADGzdRLpwJqdQrZhD/Rn4FMbN34LdkF8gxKDj
	 5YAdKIipz3ypA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	guohui.study@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com,
	tparkin@katalix.com
Subject: [PATCH net] net/l2tp: fix warning in l2tp_exit_net found by syzbot
Date: Mon, 18 Nov 2024 14:04:11 +0000
Message-Id: <20241118140411.1582555-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In l2tp's net exit handler, we check that an IDR is empty before
destroying it:

	WARN_ON_ONCE(!idr_is_empty(&pn->l2tp_tunnel_idr));
	idr_destroy(&pn->l2tp_tunnel_idr);

By forcing memory allocation failures in idr_alloc_32, syzbot is able
to provoke a condition where idr_is_empty returns false despite there
being no items in the IDR. This turns out to be because the radix tree
of the IDR contains only internal radix-tree nodes and it is this that
causes idr_is_empty to return false. The internal nodes are cleaned by
idr_destroy.

Use idr_for_each to check that the IDR is empty instead of
idr_is_empty to avoid the problem.

Reported-by: syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=332fe1e67018625f63c9
Fixes: 73d33bd063c4 ("l2tp: avoid using drain_workqueue in l2tp_pre_exit_net")
Signed-off-by: James Chapman <jchapman@katalix.com>
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


