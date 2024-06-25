Return-Path: <netdev+bounces-106656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B722917216
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B30B1C26A51
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075D17D8B3;
	Tue, 25 Jun 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MIOkeoC9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC417D37E;
	Tue, 25 Jun 2024 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345556; cv=none; b=eYAC/rIsd5SGN75HEt3YlQ0kYwjAxB2d+uUKz85UbPyAOWQ4CcNtwiydUw6mnoXbaG9PIzh5hfjj7GTzm7cMFi/xj6+1jlKszD7auUuODo1cgjhuhRNu/365nSs9PJUmaxVyzz8hKmLOyFjbcIGuNK1C8jkEWq07hDvjNDqTm5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345556; c=relaxed/simple;
	bh=ZOz8lyWN2kgHyZJOCeL+C/MiTWY1XJbAbPRQYE6+Z3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y74ItxKhc28hLr6ZKbMlipv2thqONujTvbpLVLI/sGnQ/A5MMZTMRXn38HUN/nasGRSkpvtCIvVR6X2406yEyS/E1jtavn0oCpaSb8UZ5y/nYkPAF9135952JXW4Ot9nkjee/R244Fn+wmV9ppGl5Fl6+iYaeM8gc0jJHupSff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MIOkeoC9; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719345554; x=1750881554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kishX8nABOvSFBWLgjMLQIC7J+lezddID4sm2eyUYT8=;
  b=MIOkeoC9s64uk9I9T76vAnneNNmKOzOOu6kCISiu19Ti7ksMC4rzR3bU
   szJdp0wQ/WMKb9Dk20RTPD371pOBfl5OektvBoxyNE83AlaNjcG0oF5UV
   JKmsjo1M1V/kRdvrrPKajNjmD5AmR1zWs82XnIZJLgbaM6Q0lRrW1x+VA
   4=;
X-IronPort-AV: E=Sophos;i="6.08,264,1712620800"; 
   d="scan'208";a="99511191"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 19:59:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:40898]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.169:2525] with esmtp (Farcaster)
 id 758f2c13-0468-40bf-998a-3e3f37ff1949; Tue, 25 Jun 2024 19:59:12 +0000 (UTC)
X-Farcaster-Flow-ID: 758f2c13-0468-40bf-998a-3e3f37ff1949
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 19:59:12 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 19:59:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syoshida@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] af_unix: Fix uninit-value in __unix_walk_scc()
Date: Tue, 25 Jun 2024 12:58:48 -0700
Message-ID: <20240625195849.55006-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240625152713.1147650-1-syoshida@redhat.com>
References: <20240625152713.1147650-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Shigeru Yoshida <syoshida@redhat.com>
Date: Wed, 26 Jun 2024 00:27:13 +0900
> KMSAN reported uninit-value access in __unix_walk_scc() [1].
> 
> In the list_for_each_entry_reverse() loop, when the vertex's index equals
> it's scc_index, the loop uses the variable vertex as a temporary variable
> that points to a vertex in scc. And when the loop is finished, the variable
> vertex points to the list head, in this case scc, which is a local variable
> on the stack.

Thanks for the fix !

More precisely, it's not even scc and might underflow the call
stack of __unix_walk_scc():

  container_of(&scc, struct unix_vertex, scc_entry)


> 
> However, the variable vertex is used under the label prev_vertex. So if the
> edge_stack is not empty and the function jumps to the prev_vertex label,
> the function will access invalid data on the stack. This causes the
> uninit-value access issue.
> 
> Fix this by introducing a new temporary variable for the loop.
> 
> [1]
> BUG: KMSAN: uninit-value in __unix_walk_scc net/unix/garbage.c:478 [inline]
> BUG: KMSAN: uninit-value in unix_walk_scc net/unix/garbage.c:526 [inline]
> BUG: KMSAN: uninit-value in __unix_gc+0x2589/0x3c20 net/unix/garbage.c:584
>  __unix_walk_scc net/unix/garbage.c:478 [inline]

Could you validate the test case below without/with your patch
and post it within v2 with your SOB tag ?

I ran the test below and confrimed the bug with a manual WARN_ON()
but didn't see KMSAN splat, so what version of clang do you use ?

---8<---
From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Tue, 25 Jun 2024 19:46:59 +0000
Subject: [PATCH] selftest: af_unix: Add test case for backtrack after
 finalising SCC.

syzkaller reported a KMSAN splat in __unix_walk_scc() while backtracking
edge_stack after finalising SCC.

Let's add a test case exercising the path.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index 2bfed46e0b19..d66336256580 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -14,12 +14,12 @@
 
 FIXTURE(scm_rights)
 {
-	int fd[16];
+	int fd[32];
 };
 
 FIXTURE_VARIANT(scm_rights)
 {
-	char name[16];
+	char name[32];
 	int type;
 	int flags;
 	bool test_listener;
@@ -172,6 +172,8 @@ static void __create_sockets(struct __test_metadata *_metadata,
 			     const FIXTURE_VARIANT(scm_rights) *variant,
 			     int n)
 {
+	ASSERT_LE(n * 2, sizeof(self->fd) / sizeof(self->fd[0]));
+
 	if (variant->test_listener)
 		create_listeners(_metadata, self, n);
 	else
@@ -283,4 +285,23 @@ TEST_F(scm_rights, cross_edge)
 	close_sockets(8);
 }
 
+TEST_F(scm_rights, backtrack_from_scc)
+{
+	create_sockets(10);
+
+	send_fd(0, 1);
+	send_fd(0, 4);
+	send_fd(1, 2);
+	send_fd(2, 3);
+	send_fd(3, 1);
+
+	send_fd(5, 6);
+	send_fd(5, 9);
+	send_fd(6, 7);
+	send_fd(7, 8);
+	send_fd(8, 6);
+
+	close_sockets(10);
+}
+
 TEST_HARNESS_MAIN
---8<---

