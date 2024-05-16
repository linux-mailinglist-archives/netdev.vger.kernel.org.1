Return-Path: <netdev+bounces-96730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99EF8C7675
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 14:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA3B2821B0
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD98146009;
	Thu, 16 May 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hlgrh1to"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7A145FE7
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862742; cv=none; b=JehfA3D1tP8pB+fwggwiIwR+duqXeWRYCP6P6T905WBGvebBllKmmD+fYhU2Sq5aHezN2QAPZna3ayra1su8wV5w4yNXjunUaM1olyBa7f+etjbto0o6jtRVXIamwl1Qs6Sb+PcaWtktWyFPRQqzYl29qUC7mESNSSy2yUBRkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862742; c=relaxed/simple;
	bh=hn+7UqggRbHLGeK9tG32xru/Y6sh6O3c54rjilkwnH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5jlPGt7r9vi6dFSzVzLskSmJj3A6F0UdyY0vIH1b0x6ckMo5R63SSVb5W1Skn4Eo4KoclfO4Wip7vqFF3+9Q7OIFLfRaNxdRDCwjJ75XtrJ0mOl/zGlXq4nbejeoFJ4vvX0paJIOSMaTOqlhQWYHhxJrzFVpz58Cwd0v8CGx/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hlgrh1to; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715862741; x=1747398741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TrjzQ1k7xiLZn4Ptz7EhL5RB+ZZois0XDU3II4qxm+I=;
  b=hlgrh1toC6t664DJaC/308FUYN2bZ6qdSyQUv6EW6O2ySh37LeQZkJx9
   psNGnhD7+8j9YgQVC/Vl27c48GRc72ducGxkiYyg2Qxhtcu0eZXJ+mhX7
   kFogr7/ScuRW/GsHsz2iMLpKos/NBA8UChcP4cCWw3jaoTm+3ZdWzhmmm
   w=;
X-IronPort-AV: E=Sophos;i="6.08,164,1712620800"; 
   d="scan'208";a="654515514"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 12:32:18 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:41452]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.175:2525] with esmtp (Farcaster)
 id b2627827-c6e0-4cbc-b26a-c1a69c68ae0d; Thu, 16 May 2024 12:32:16 +0000 (UTC)
X-Farcaster-Flow-ID: b2627827-c6e0-4cbc-b26a-c1a69c68ae0d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 12:32:16 +0000
Received: from 88665a182662.ant.amazon.com.com (10.118.251.223) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 12:32:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net] af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
Date: Thu, 16 May 2024 21:31:21 +0900
Message-ID: <20240516123120.99486-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240516103049.1132040-1-mhal@rbox.co>
References: <20240516103049.1132040-1-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 16 May 2024 12:20:48 +0200
> GC attempts to explicitly drop oob_skb before purging the hit list.
> 
> The problem is with embryos: kfree_skb(u->oob_skb) is never called on an
> embryo socket, as those sockets are not directly stacked by the SCC walk.
> 
> The python script below [0] sends a listener's fd to its embryo as OOB
> data.  While GC does collect the embryo's queue, it fails to drop the OOB
> skb's refcount.  The skb which was in embryo's receive queue stays as
> unix_sk(sk)->oob_skb and keeps the listener's refcount [1].
> 
> Tell GC to dispose embryo's oob_skb.
> 
> [0]:
> from array import array
> from socket import *
> 
> addr = '\x00unix-oob'
> lis = socket(AF_UNIX, SOCK_STREAM)
> lis.bind(addr)
> lis.listen(1)
> 
> s = socket(AF_UNIX, SOCK_STREAM)
> s.connect(addr)
> scm = (SOL_SOCKET, SCM_RIGHTS, array('i', [lis.fileno()]))
> s.sendmsg([b'x'], [scm], MSG_OOB)
> lis.close()
> 
> [1]
> $ grep unix-oob /proc/net/unix
> $ ./unix-oob.py
> $ grep unix-oob /proc/net/unix
> 0000000000000000: 00000002 00000000 00000000 0001 02     0 @unix-oob
> 0000000000000000: 00000002 00000000 00010000 0001 01  6072 @unix-oob
> 
> Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  net/unix/garbage.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 1f8b8cdfcdc8..8e9431955ab7 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -342,6 +342,18 @@ enum unix_recv_queue_lock_class {
>  	U_RECVQ_LOCK_EMBRYO,
>  };
>  
> +static void unix_collect_queue(struct unix_sock *u, struct sk_buff_head *hitlist)
> +{
> +	skb_queue_splice_init(&u->sk.sk_receive_queue, hitlist);
> +
> +#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> +	if (u->oob_skb) {
> +		WARN_ON_ONCE(skb_unref(u->oob_skb));
> +		u->oob_skb = NULL;
> +	}
> +#endif
> +}
> +
>  static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
>  {
>  	struct unix_vertex *vertex;
> @@ -365,18 +377,11 @@ static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist
>  
>  				/* listener -> embryo order, the inversion never happens. */
>  				spin_lock_nested(&embryo_queue->lock, U_RECVQ_LOCK_EMBRYO);
> -				skb_queue_splice_init(embryo_queue, hitlist);
> +				unix_collect_queue(unix_sk(skb->sk), hitlist);
>  				spin_unlock(&embryo_queue->lock);
>  			}
>  		} else {
> -			skb_queue_splice_init(queue, hitlist);
> -
> -#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> -			if (u->oob_skb) {
> -				kfree_skb(u->oob_skb);
> -				u->oob_skb = NULL;
> -			}
> -#endif
> +			unix_collect_queue(u, hitlist);
>  		}
>  
>  		spin_unlock(&queue->lock);
> @@ -583,6 +588,8 @@ static void __unix_gc(struct work_struct *work)
>  	skb_queue_walk(&hitlist, skb) {
>  		if (UNIXCB(skb).fp)
>  			UNIXCB(skb).fp->dead = true;
> +
> +		WARN_ON_ONCE(refcount_read(&skb->users) != 1);

Given we will refactor OOB with no additional refcount, this will not
make sense.  Rather, I'd add a test case in a selftest to catch the
future regression.

And I noticed that I actually tried to catch this in

  tools/testing/selftests/net/af_unix/scm_rights.c

, and what is missing is... :S

---8<---
From f6f47b3cdd22e7c4ed48bf1de089babd09c606e0 Mon Sep 17 00:00:00 2001
From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Thu, 16 May 2024 12:10:45 +0000
Subject: [PATCH] selftest: af_unix: Make SCM_RIGHTS into OOB data.

scm_rights.c covers various test cases for inflight file descriptors
and garbage collector for AF_UNIX sockets.

Currently, SCM_RIGHTS messages are sent with 3-bytes string, and it's
not good for MSG_OOB cases, as SCM_RIGTS cmsg goes with the first 2-bytes,
which is non-OOB data.

Let's send SCM_RIGHTS messages with 1-byte character to pack SCM_RIGHTS
into OOB data.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index bab606c9f1eb..2bfed46e0b19 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -197,8 +197,8 @@ void __send_fd(struct __test_metadata *_metadata,
 	       const FIXTURE_VARIANT(scm_rights) *variant,
 	       int inflight, int receiver)
 {
-#define MSG "nop"
-#define MSGLEN 3
+#define MSG "x"
+#define MSGLEN 1
 	struct {
 		struct cmsghdr cmsghdr;
 		int fd[2];

---8<---


With this, we can catch the case properly,

#  RUN           scm_rights.stream_listener_oob.self_ref ...
# scm_rights.c:119:self_ref:Expected 0 (0) == ret (6)
# self_ref: Test terminated by assertion
#          FAIL  scm_rights.stream_listener_oob.self_ref
not ok 13 scm_rights.stream_listener_oob.self_ref
#  RUN           scm_rights.stream_listener_oob.triangle ...
# scm_rights.c:119:triangle:Expected 0 (0) == ret (18)
# triangle: Test terminated by assertion
#          FAIL  scm_rights.stream_listener_oob.triangle
not ok 14 scm_rights.stream_listener_oob.triangle
#  RUN           scm_rights.stream_listener_oob.cross_edge ...
# scm_rights.c:119:cross_edge:Expected 0 (0) == ret (24)
# cross_edge: Test terminated by assertion
#          FAIL  scm_rights.stream_listener_oob.cross_edge
not ok 15 scm_rights.stream_listener_oob.cross_edge
# FAILED: 12 / 15 tests passed.
# Totals: pass:12 fail:3 xfail:0 xpass:0 skip:0 error:0


And with your patch, all good !

#  RUN           scm_rights.stream_listener_oob.self_ref ...
#            OK  scm_rights.stream_listener_oob.self_ref
ok 13 scm_rights.stream_listener_oob.self_ref
#  RUN           scm_rights.stream_listener_oob.triangle ...
#            OK  scm_rights.stream_listener_oob.triangle
ok 14 scm_rights.stream_listener_oob.triangle
#  RUN           scm_rights.stream_listener_oob.cross_edge ...
#            OK  scm_rights.stream_listener_oob.cross_edge
ok 15 scm_rights.stream_listener_oob.cross_edge
# PASSED: 15 / 15 tests passed.
# Totals: pass:15 fail:0 xfail:0 xpass:0 skip:0 error:0


Could you remove the WARN_ON_ONCE() and repost with my patch
above ?

Thanks!

