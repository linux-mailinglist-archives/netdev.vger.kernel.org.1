Return-Path: <netdev+bounces-117543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2DE94E3C1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 01:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BC81F2200D
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 23:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970EA53364;
	Sun, 11 Aug 2024 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HD4CSSOr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C8917552;
	Sun, 11 Aug 2024 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723417248; cv=none; b=oNyjZ3Ys2nZ9ND8Hn4SMdC+pnkHFsmR/HVwpFri6sibwgY0XDgz9lL61PIGvM70xC3C3Di4GET9CLBZW/p2AZuR2EeJFJGGm4Kz4a4le6WuZLzhaIAH7X1/9ECPAYyLSLVIDy2g2OTkoAGgfHdtZjNTiO0UHhoccV96XxLtG1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723417248; c=relaxed/simple;
	bh=1SG0oL+fFkkSf6fiyBr0QOTU3FisSS50V0y9u8f6qWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaOXpxQUkBlnBAb586XYMqNoj6Blp8b3QU/CkibLsS4wM4wAX7lmaMBpF4Iz5EV0GhnYFBFKgtSkdPsSNQHL+psM7WEAGipsrsvwVPydJC7UssCIlW5s4Wbpu8YS8JfY53cM03+DMuCSK+dE/dIhze3JkuzsiE/qm/fdz6du9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HD4CSSOr; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723417247; x=1754953247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lsxGgT51BT4VyDCWRD+pINrSeNPX9m35c4vtOptq55Q=;
  b=HD4CSSOr6DspleeFljtXaSz9E9qIA1zJm3zRzC5f+4cdhyhuOCKnSQTu
   oc0peS/ErKrwRY/QmvVIG6Wyka/WYDvHtRBs2JnGXvQG8lFu52V46meZu
   mFXkUr3hnCkc3p0HhYxfUrX5lXIc3DFkIYHGAplgRgWOQiXfTnbvuCZ0l
   Y=;
X-IronPort-AV: E=Sophos;i="6.09,282,1716249600"; 
   d="scan'208";a="361711681"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 23:00:40 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:24658]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.82:2525] with esmtp (Farcaster)
 id bfee8be0-3c1e-4bca-bb8d-eddb13ec5211; Sun, 11 Aug 2024 23:00:40 +0000 (UTC)
X-Farcaster-Flow-ID: bfee8be0-3c1e-4bca-bb8d-eddb13ec5211
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 11 Aug 2024 23:00:39 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 11 Aug 2024 23:00:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <fw@strlen.de>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
Date: Sun, 11 Aug 2024 16:00:29 -0700
Message-ID: <20240811230029.95258-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240811162850.GE13736@breakpoint.cc>
References: <20240811162850.GE13736@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Florian Westphal <fw@strlen.de>
Date: Sun, 11 Aug 2024 18:28:50 +0200
> Florian Westphal <fw@strlen.de> wrote:
> > https://syzkaller.appspot.com/x/log.txt?x=117f3182980000
> > 
> > ... shows at two cores racing:
> > 
> > [ 3127.234402][ T1396] CPU: 3 PID: 1396 Comm: syz-executor.3 Not
> > and
> > [ 3127.257864][   T13] CPU: 1 PID: 13 Comm: kworker/u32:1 Not tainted 6.9.0-syzkalle (netns cleanup net).
> > 
> > 
> > first splat backtrace shows invocation of tcp_sk_exit_batch() from
> > netns error unwinding code.
> > 
> > Second one lacks backtrace, but its also in tcp_sk_exit_batch(),
> 
> ... which doesn't work.  Does this look like a plausible
> theory/exlanation?

Yes!  The problem here is that inet_twsk_purge() operates on twsk
not in net_exit_list, but I think such a check is overkill and we
can work around it in another way.


> 
> Given:
> 1 exiting netns, has >= 1 tw sk.
> 1 (unrelated) netns that failed in setup_net
> 
> ... we run into following race:
> 
> exiting netns, from cleanup wq, calls tcp_sk_exit_batch(), which calls
> inet_twsk_purge(&tcp_hashinfo).
> 
> At same time, from error unwinding code, we also call tcp_sk_exit_batch().
> 
> Both threads walk tcp_hashinfo ehash buckets.
> 
> From work queue (normal netns exit path), we hit
> 
> 303                         if (state == TCP_TIME_WAIT) {
> 304                                 inet_twsk_deschedule_put(inet_twsk(sk));
> 
> Because both threads operate on tcp_hashinfo, the unrelated
> struct net (exiting net) is also visible to error-unwinding thread.
> 
> So, error unwinding code will call
> 
> 303                         if (state == TCP_TIME_WAIT) {
> 304                                 inet_twsk_deschedule_put(inet_twsk(sk));
> 
> for the same tw sk and both threads do
> 
> 218 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
> 219 {
> 220         if (del_timer_sync(&tw->tw_timer))
> 221                 inet_twsk_kill(tw);
> 
> Error unwind path cancel timer, calls inet_twsk_kill, while
> work queue sees timer as already shut-down so it ends up
> returning to tcp_sk_exit_batch(), where it will WARN here:
> 
>   WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
> 
> ... because the supposedly-last tw_refcount decrement did not drop
> it down to 0.
> 
> Meanwhile, error unwiding thread calls refcount_dec() on
> tw_refcount, which now drops down to 0 instead of 1, which
> provides another warn splat.
> 
> I'll ponder on ways to fix this tomorrow unless someone
> else already has better theory/solution.

We need to sync two inet_twsk_kill(), so maybe give up one
if twsk is not hashed ?

---8<---
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 337390ba85b4..51889567274b 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -52,7 +52,10 @@ static void inet_twsk_kill(struct inet_timewait_sock *tw)
 	struct inet_bind_hashbucket *bhead, *bhead2;
 
 	spin_lock(lock);
-	sk_nulls_del_node_init_rcu((struct sock *)tw);
+	if (!sk_nulls_del_node_init_rcu((struct sock *)tw)) {
+		spin_unlock(lock);
+		return false;
+	}
 	spin_unlock(lock);
 
 	/* Disassociate with bind bucket. */
---8<---

