Return-Path: <netdev+bounces-116334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E7394A125
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4072C28C318
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DB1B8E9D;
	Wed,  7 Aug 2024 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="FiXywVmA"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0771B1428
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013696; cv=none; b=leiGJ8wh9OkMib/0ViNbySfhbIhLwydnca1mmddxOA80Z5iAvHWwYITt6f3LaWygn3N3/BO5HKUzc1ZlCYTJ4NS+Pgg2Ap7gFqvlAV9hBOe75//U/6Cu5e78tAjayEMZ040+vvJZOzlbGVgTH9+p2suyj3HmmUIt7xGt/xzXUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013696; c=relaxed/simple;
	bh=sJM7Ijj5QE+0ztqGsHqa1lfSYOZfE8BVi2tpK235XOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=agM/v6f40hkTXKE1gmAVRuS1mltJ0zQ3cRihCNe4tlqhXn7Rl0RfT4Clo+YC/CitCSWBhQUnaMqpFP9UhAnTNPwiziIfvzPNvgJTZpaRsPz5OpI/S0xULprvWGS4sQ7vzHJjwbblFqio7Z0ETy/ZfgUpr1LzsmVCTaR+H+0a82g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=FiXywVmA; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:9ea4:d72e:1b25:b4bf])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id B6EDD7DD05;
	Wed,  7 Aug 2024 07:54:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723013694; bh=sJM7Ijj5QE+0ztqGsHqa1lfSYOZfE8BVi2tpK235XOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09horms@kernel
	 .org|Subject:=20[PATCH=20v2=20net-next=204/9]=20l2tp:=20handle=20h
	 ash=20key=20collisions=20in=20l2tp_v3_session_get|Date:=20Wed,=20=
	 207=20Aug=202024=2007:54:47=20+0100|Message-Id:=20<eae2f69427371bc
	 679626f4d794f2ed59e4bdc86.1723011569.git.jchapman@katalix.com>|In-
	 Reply-To:=20<cover.1723011569.git.jchapman@katalix.com>|References
	 :=20<cover.1723011569.git.jchapman@katalix.com>|MIME-Version:=201.
	 0;
	b=FiXywVmARDd9JAABdrSYBBSrrLlYmn12t1yXLfk9pUVvGWouw9e5qd38gnqsDSta0
	 NZfL4mpgSU7RUhP2ryZviRJAWI4sd5jufPTWeD+QZ53NSII5yBU0lg4VRNnxBQL5TL
	 nqRFeDRnxQxvnE4QmYM6YBQDZiA68gFNzZVnGbaxoPRE+YtclE2azx9dKyjHrCbtdu
	 lhFH6k17wKed8Mqt3heQ8bF3y0Uk47OtSyc3mhiqRhWUaMZW8XdmPmmf1ZFSIURHhN
	 s5HGy3XkEfB3LHyfR+Ccft60okHNb/FnmiM+JiE9Ykf+1G8sitflMuE5E/opV/Abeq
	 p2FJjL9tpd2/Q==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	horms@kernel.org
Subject: [PATCH v2 net-next 4/9] l2tp: handle hash key collisions in l2tp_v3_session_get
Date: Wed,  7 Aug 2024 07:54:47 +0100
Message-Id: <eae2f69427371bc679626f4d794f2ed59e4bdc86.1723011569.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723011569.git.jchapman@katalix.com>
References: <cover.1723011569.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To handle colliding l2tpv3 session IDs, l2tp_v3_session_get searches a
hashed list keyed by ID and sk. Although unlikely, if hash keys
collide, it is possible that hash_for_each_possible loops over a
session which doesn't have the ID that we are searching for. So check
for session ID match when looping over possible hash key matches.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 608a7beda9d5..28e6367f2483 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -286,7 +286,8 @@ struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk,
 			 */
 			struct l2tp_tunnel *tunnel = READ_ONCE(session->tunnel);
 
-			if (tunnel && tunnel->sock == sk &&
+			if (session->session_id == session_id &&
+			    tunnel && tunnel->sock == sk &&
 			    refcount_inc_not_zero(&session->ref_count)) {
 				rcu_read_unlock_bh();
 				return session;
-- 
2.34.1


