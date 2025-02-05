Return-Path: <netdev+bounces-162875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D4FA28413
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FC21887977
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 06:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8D4223330;
	Wed,  5 Feb 2025 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MNWe77ck"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233A122258F;
	Wed,  5 Feb 2025 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735670; cv=none; b=UDuZu0hNStFxJRK81j8XJu7F4tjZQJq2oBd/agnnZvcaJLmxqTppKBRPFhRREAgdBRemiGgbsQmcIuoLo1OhvR+e+OQ+vL2r0q3nOTS1WYancDrMFKXmhX+npDKW7w3k9LTBbtd+Zp7kZODwfwejj91JqIdb/tW3t9HQ4v/vj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735670; c=relaxed/simple;
	bh=vuiNeo/kxIvbiBmOLGNin/sHZ4nn2HUxVjuSc2BsOXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D5ut4z6x0w5yk4VBEwNmkDpXTFXka2u/FTK3wdIaBMDFEsYK7L4UnSJT52+oC1Gc0ZCs+iYLyrNZxtIab4hwHMbSG4XjnfCGKWluuHAteyRIRaoKUtahDlczLrbYXRkZ2VCObIhYZUjnPxOJFusGcqgO98Nkvz2JqBRvcyMCHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MNWe77ck; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TLtyA
	406mG64Rk1PzL/7eISF7Nj0Vg+LArG5IeYSEVw=; b=MNWe77ckShbhIPygDM8FF
	nzJ99a9CFm1ovzKHQqAvzwAzdhhRmRt7hFJOSWV/lzEBw+fWaT3wklG/qzJb/eWc
	wDJyKX4RqqHvMJgaelEhjYyt1HkecWA1NkABs+BjbjUnUB4nMhwpBaQCdcb0diBl
	sIEeeu4Pzobgg9/xp6dY1s=
Received: from hello.company.local (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHaIQEAKNnd1cQJw--.41655S2;
	Wed, 05 Feb 2025 14:07:01 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>
Subject: [PATCH net-next] af_unix: Refine UNIX domain sockets autobind identifier length
Date: Wed,  5 Feb 2025 14:06:53 +0800
Message-Id: <20250205060653.2221165-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHaIQEAKNnd1cQJw--.41655S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFykJw1kGF4kKFy5Gw43Awb_yoW5Aw45pF
	4Yk34DZrs5Jrsrur1xJaykArs3tayrtF17GrZ2g3WS9FsxWr10kF1vgF4jv3s8WrW8Jw1f
	XF40gr4qv34DAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jb9N3UUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbiNgbqIGei-2AKoAAAsK

From: Liang Jie <liangjie@lixiang.com>

Refines autobind identifier length for UNIX domain sockets, addressing
issues of memory waste and code readability.

The previous implementation in the unix_autobind function of UNIX domain
sockets used hardcoded values such as 16, 6, and 5 for memory allocation
and setting the length of the autobind identifier, which was not only
inflexible but also led to reduced code clarity. Additionally, allocating
16 bytes of memory for the autobind path was excessive, given that only 6
bytes were ultimately used.

To mitigate these issues, introduces the following changes:
 - A new macro AUTOBIND_LEN is defined to clearly represent the total
   length of the autobind identifier, which improves code readability and
   maintainability. It is set to 6 bytes to accommodate the unique autobind
   process identifier.
 - Memory allocation for the autobind path is now precisely based on
   AUTOBIND_LEN, thereby preventing memory waste.
 - The sprintf() function call is updated to dynamically format the
   autobind identifier according to the defined length, further enhancing
   code consistency and readability.

The modifications result in a leaner memory footprint and elevated code
quality, ensuring that the functional aspect of autobind behavior in UNIX
domain sockets remains intact.

Signed-off-by: Liang Jie <liangjie@lixiang.com>
---
 net/unix/af_unix.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 34945de1fb1f..5dcc55f2e3a1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1186,6 +1186,13 @@ static struct sock *unix_find_other(struct net *net,
 	return sk;
 }
 
+/*
+ * Define the total length of the autobind identifier for UNIX domain sockets.
+ * - The first byte distinguishes abstract sockets from filesystem-based sockets.
+ * - The subsequent five bytes store a unique identifier for the autobinding process.
+ */
+#define AUTOBIND_LEN 6
+
 static int unix_autobind(struct sock *sk)
 {
 	struct unix_sock *u = unix_sk(sk);
@@ -1204,11 +1211,11 @@ static int unix_autobind(struct sock *sk)
 
 	err = -ENOMEM;
 	addr = kzalloc(sizeof(*addr) +
-		       offsetof(struct sockaddr_un, sun_path) + 16, GFP_KERNEL);
+		       offsetof(struct sockaddr_un, sun_path) + AUTOBIND_LEN, GFP_KERNEL);
 	if (!addr)
 		goto out;
 
-	addr->len = offsetof(struct sockaddr_un, sun_path) + 6;
+	addr->len = offsetof(struct sockaddr_un, sun_path) + AUTOBIND_LEN;
 	addr->name->sun_family = AF_UNIX;
 	refcount_set(&addr->refcnt, 1);
 
@@ -1217,7 +1224,7 @@ static int unix_autobind(struct sock *sk)
 	lastnum = ordernum & 0xFFFFF;
 retry:
 	ordernum = (ordernum + 1) & 0xFFFFF;
-	sprintf(addr->name->sun_path + 1, "%05x", ordernum);
+	sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);
 
 	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
 	unix_table_double_lock(net, old_hash, new_hash);
-- 
2.25.1


