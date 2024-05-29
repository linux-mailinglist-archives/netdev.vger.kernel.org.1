Return-Path: <netdev+bounces-99073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5835D8D39AB
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C350C1F24F68
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A0817B50C;
	Wed, 29 May 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VX9HRYLF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E6915AAD5
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994027; cv=none; b=Po0S05VTUAmnZATmvzXfeOB07cXhs9/Ov4kPkWsL1CEomdKtQp2Kucg+hJ/O6SBxwUNPaTX0tm8DdXmpgDx4ZnRpZBILpZGVnjuYeqrtwuodGAe9tr18RZvhvu9cPjwQ5NDjLDQFjTIT9ZnUNsuSdhDKI1E4q6MAPB9l1DfZDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994027; c=relaxed/simple;
	bh=cCP/YSy/Er/6cQQCPCDbUe7s7VAwcIqRn5fxh7Dq1VA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uwmPvZE4wKk9lstCr0mHQ1PERAXk8XHwH9qQbeGlMnGMZdVpU5bjx4ajUxwYSD3reDjAF9B2T78ubryO+c1WVdxbfhn2enx9gyNmiFZJYBP1GmES4YKT7tl6k35k1S3B0SLCcZSJb1cgK2gce9uQNUHKkWb5lruvNSl+K9qQVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VX9HRYLF; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1716994026; x=1748530026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=94wUGKSh1nU/w2ERf0j5VQUIccu6U4GdwDR8Yv8wyQI=;
  b=VX9HRYLFPw3rDlMghZrvOcjCAvAznWnPD2e4RcK8Us4VXKhlTbRpjPzL
   xDYRtyOi+64MN/GUH50ls9S9bTjj10HjTziiAJHMkBXgu9mWBacU0gJo+
   HeDR6+lbEYdhk+XtWLHFVl2wRK/GdznAICudoH7VHNXaxB2p2ccv05MKE
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,198,1712620800"; 
   d="scan'208";a="409946504"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 14:47:02 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:4144]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.45:2525] with esmtp (Farcaster)
 id af0bd93b-714a-4e8c-a7a3-012a7a4e3119; Wed, 29 May 2024 14:47:01 +0000 (UTC)
X-Farcaster-Flow-ID: af0bd93b-714a-4e8c-a7a3-012a7a4e3119
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 29 May 2024 14:47:01 +0000
Received: from 88665a182662.ant.amazon.com (10.142.172.119) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 29 May 2024 14:46:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] af_unix: Remove dead code in unix_stream_read_generic().
Date: Wed, 29 May 2024 07:46:48 -0700
Message-ID: <20240529144648.68591-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When splice() support was added in commit 2b514574f7e8 ("net:
af_unix: implement splice for stream af_unix sockets"), we had
to release unix_sk(sk)->readlock (current iolock) before calling
splice_to_pipe().

Due to the unlock, commit 73ed5d25dce0 ("af-unix: fix use-after-free
with concurrent readers while splicing") added a safeguard in
unix_stream_read_generic(); we had to bump the skb refcount before
calling ->recv_actor() and then check if the skb was consumed by a
concurrent reader.

However, the pipe side locking was refactored, and since commit
25869262ef7a ("skb_splice_bits(): get rid of callback"), we can
call splice_to_pipe() without releasing unix_sk(sk)->iolock.

Now, the skb is always alive after the ->recv_actor() callback,
so let's remove the unnecessary drop_skb logic.

This is mostly the revert of commit 73ed5d25dce0 ("af-unix: fix
use-after-free with concurrent readers while splicing").

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 902148212ad3..f4cc8b9bf82d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -654,8 +654,8 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
 		if (state == TCP_LISTEN)
 			unix_release_sock(skb->sk, 1);
+
 		/* passed fds are erased in the kfree_skb hook	      */
-		UNIXCB(skb).consumed = skb->len;
 		kfree_skb(skb);
 	}
 
@@ -2704,9 +2704,8 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	skip = max(sk_peek_offset(sk, flags), 0);
 
 	do {
-		int chunk;
-		bool drop_skb;
 		struct sk_buff *skb, *last;
+		int chunk;
 
 redo:
 		unix_state_lock(sk);
@@ -2802,11 +2801,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		}
 
 		chunk = min_t(unsigned int, unix_skb_len(skb) - skip, size);
-		skb_get(skb);
 		chunk = state->recv_actor(skb, skip, chunk, state);
-		drop_skb = !unix_skb_len(skb);
-		/* skb is only safe to use if !drop_skb */
-		consume_skb(skb);
 		if (chunk < 0) {
 			if (copied == 0)
 				copied = -EFAULT;
@@ -2815,18 +2810,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		copied += chunk;
 		size -= chunk;
 
-		if (drop_skb) {
-			/* the skb was touched by a concurrent reader;
-			 * we should not expect anything from this skb
-			 * anymore and assume it invalid - we can be
-			 * sure it was dropped from the socket queue
-			 *
-			 * let's report a short read
-			 */
-			err = 0;
-			break;
-		}
-
 		/* Mark read part of skb as used */
 		if (!(flags & MSG_PEEK)) {
 			UNIXCB(skb).consumed += chunk;
-- 
2.30.2


