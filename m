Return-Path: <netdev+bounces-115742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596F4947A70
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A92B1C21364
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED676156997;
	Mon,  5 Aug 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="Q/96CiWE"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59114155C90
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857743; cv=none; b=q3Lh0kjeJOlZKtYh+ybqrzlzuPdHrqghoIaNgXiCMu7OIsVkkAE5wSjxufBDZyiluSMwvim+I8jIRjH3jY5nqhDdCiANnQ0HywDp2Pxf5IdPAFzTAVfrJIlNkyjt7it8REGt1hc1f9M9SJ3ucsZGpVIeEmOoN0LKfVpjjwB1gzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857743; c=relaxed/simple;
	bh=5hgTcL/A6HqhGNgk5e/v8k91hOU4s5moyhJip8rnLW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uu1li0R48yKlg94lBTPDF+kvWI4MNQu21cOjqrl0leJ95fU6Je4Kszd3WtwqxoSlyk/vRFKbCApDvy0jhAyQ/s7Xi92eZZJY8RKp6cONtYDf+vYM5sUdorKljM5q+/grNhA27lfYJhxuNeh/SQu5emOOyHfieQ0QTZpbJAEtxGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=Q/96CiWE; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:326:9405:f27f:a659])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 3AE547DCE4;
	Mon,  5 Aug 2024 12:35:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722857735; bh=5hgTcL/A6HqhGNgk5e/v8k91hOU4s5moyhJip8rnLW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=203/9]=20l2tp:=20fix=20handling=20of=20hash=20key=20collis
	 ions=20in=20l2tp_v3_session_get|Date:=20Mon,=20=205=20Aug=202024=2
	 012:35:27=20+0100|Message-Id:=20<fbc3d1e3d57c644b97a238168a200c79a
	 2ec8c98.1722856576.git.jchapman@katalix.com>|In-Reply-To:=20<cover
	 .1722856576.git.jchapman@katalix.com>|References:=20<cover.1722856
	 576.git.jchapman@katalix.com>|MIME-Version:=201.0;
	b=Q/96CiWEDv1OU5tMZW24Kyp/u56VLX5oN8umDThFKOib23Xgi/vuvkxxw3K+bBXj6
	 BnZb8a4Za4/8E8bdmXlTa5pEWJrA1n38xHSA6j63bIILVcE7SvWoabG5T4VPJsHO5M
	 IGu8xuICtYfWnvq3HEP/0z0G90FIu87SwZI1AGMuz3tDj+Mk0rrs2R+fGBFk4Jv2HH
	 EmPFR60FOb8s+FjogDteuk8hvFLGeVD1dGp4XWGnvv1LLuQ15f/OkxelxbPmEdDII0
	 y7CqujATvb88ITpMhQVNH4nyh8dEvFqgNItkiz32aflzQDlQB3dY3Y7dJkEPea6sbt
	 l3YZUYLksEPMw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 3/9] l2tp: fix handling of hash key collisions in l2tp_v3_session_get
Date: Mon,  5 Aug 2024 12:35:27 +0100
Message-Id: <fbc3d1e3d57c644b97a238168a200c79a2ec8c98.1722856576.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722856576.git.jchapman@katalix.com>
References: <cover.1722856576.git.jchapman@katalix.com>
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

Fixes: aa5e17e1f5ec ("l2tp: store l2tpv3 sessions in per-net IDR")
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 5d2068b6c778..0c661d499a6f 100644
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


