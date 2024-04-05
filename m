Return-Path: <netdev+bounces-85364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB54889A6BF
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 23:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BD528209D
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 21:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C4D17557A;
	Fri,  5 Apr 2024 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lENJVxzK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316CF17555E
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354067; cv=none; b=uzUOHHlTWWTOU50WefTt7s2UToKzaLQnPWMsjewkur1QjeSRsBZQxQY3EYto4PMlnDJdDRAzpRoNYsMVtQIWdB14FDr2pU6pRHKjPsNDGDpOYEX/FHPVlxc28XSCWdCN2smeRQeADS4vAhojZidDdzf6O0VGemNNMH8GrS7/8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354067; c=relaxed/simple;
	bh=rA0q7lifVuanAbFMHthR4KC4LFogaeTCQok4owBtBxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yh9GCDd7oJm5p3LJ65r4dR/1X79VcQjgoOvAHWlLhFumwk/c50ukzg/JIKLMa/6eRqrseePdzE9WBY/AQoQ2mb+C/DwwWByVVbM6Kx4ixbN8oeyXLh4DOPX7fm/aZ+YGHWKUIQnEHHdLk9YQ+n48mNBUCyGZfQ1aeAviG21JKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lENJVxzK; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712354063; x=1743890063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Gs696ywQX0DQGe3dCex1qCd93QBj+kAIDdvAsdmlgo=;
  b=lENJVxzKbkVjjeQ0lurfgTAP6P1wM/QH5CxhgAyVhUSMkFMuUXk0s7RM
   Z9ZH+141cpBeyCN+utrLYBRuqnJiov/K6y0CBzLHaUcm+PMdvsnow+HQz
   PqbaeFt5Cd1OQOmmqSHKJMrM5fhuK9g2/aEEWxmKB1685wztim8pspn5r
   8=;
X-IronPort-AV: E=Sophos;i="6.07,182,1708387200"; 
   d="scan'208";a="392965675"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 21:54:20 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:62105]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.222:2525] with esmtp (Farcaster)
 id a257b5c3-db51-4e0c-81ca-0a0b9f763e93; Fri, 5 Apr 2024 21:54:19 +0000 (UTC)
X-Farcaster-Flow-ID: a257b5c3-db51-4e0c-81ca-0a0b9f763e93
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 5 Apr 2024 21:54:19 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 5 Apr 2024 21:54:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<rao.shoaib@oracle.com>,
	<syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
Subject: Re: [PATCH v1 net] af_unix: Clear stale u->oob_skb.
Date: Fri, 5 Apr 2024 14:54:08 -0700
Message-ID: <20240405215408.1007-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iK=9PVZ9y0Oh6sWiQn0OdohGBX0_vf=OdT3_0ULaFcgrA@mail.gmail.com>
References: <CANn89iK=9PVZ9y0Oh6sWiQn0OdohGBX0_vf=OdT3_0ULaFcgrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 23:06:32 +0200
> On Fri, Apr 5, 2024 at 10:42 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > syzkaller started to report deadlock of unix_gc_lock after commit
> > 4090fa373f0e ("af_unix: Replace garbage collection algorithm."), but
> > it just uncovers the bug that has been there since commit 314001f0bf92
> > ("af_unix: Add OOB support").
> >
> > The repro basically does the following.
> >
> >   from socket import *
> >   from array import array
> >
> >   c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
> >   c1.sendmsg([b'a'], [(SOL_SOCKET, SCM_RIGHTS, array("i", [c2.fileno()]))], MSG_OOB)
> >   c2.recv(1)  # blocked as no normal data in recv queue
> >
> >   c2.close()  # done async and unblock recv()
> >   c1.close()  # done async and trigger GC
> >
> > A socket sends its file descriptor to itself as OOB data and tries to
> > receive normal data, but finally recv() fails due to async close().
> >
> > The problem here is wrong handling of OOB skb in manage_oob().  When
> > recvmsg() is called without MSG_OOB, manage_oob() is called to check
> > if the peeked skb is OOB skb.  In such a case, manage_oob() pops it
> > out of the receive queue but does not clear unix_sock(sk)->oob_skb.
> > This is wrong in terms of uAPI.
> >
> > Let's say we send "hello" with MSG_OOB, and "world" without MSG_OOB.
> > The 'o' is handled as OOB data.  When recv() is called twice without
> > MSG_OOB, the OOB data should be lost.
> >
> >   >>> from socket import *
> >   >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM, 0)
> >   >>> c1.send(b'hello', MSG_OOB)  # 'o' is OOB data
> >   5
> >   >>> c1.send(b'world')
> >   5
> >   >>> c2.recv(5)  # OOB data is not received
> >   b'hell'
> >   >>> c2.recv(5)  # OOB date is skippeed
> >   b'world'
> >   >>> c2.recv(5, MSG_OOB)  # This should return an error
> >   b'o'
> >
> > In the same situation, TCP actually returns -EINVAL for the last
> > recv().
> >
> > Also, if we do not clear unix_sk(sk)->oob_skb, unix_poll() always set
> > EPOLLPRI even though the data has passed through by previous recv().
> >
> > To avoid these issues, we must clear unix_sk(sk)->oob_skb when dequeuing
> > it from recv queue.
> >
> > The reason why the old GC did not trigger the deadlock is because the
> > old GC relied on the receive queue to detect the loop.
> >
> > When it is triggered, the socket with OOB data is marked as GC candidate
> > because file refcount == inflight count (1).  However, after traversing
> > all inflight sockets, the socket still has a positive inflight count (1),
> > thus the socket is excluded from candidates.  Then, the old GC lose the
> > chance to garbage-collect the socket.
> >
> > With the old GC, the repro continues to create true garbage that will
> > never be freed nor detected by kmemleak as it's linked to the global
> > inflight list.  That's why we couldn't even notice the issue.
> >
> > Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> > Reported-by: syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=7f7f201cc2668a8fd169
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/unix/af_unix.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 5b41e2321209..8f105cf535be 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2665,7 +2665,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >                                 }
> >                         } else if (!(flags & MSG_PEEK)) {
> >                                 skb_unlink(skb, &sk->sk_receive_queue);
> > -                               consume_skb(skb);
> > +                               WRITE_ONCE(u->oob_skb, NULL);
> > +                               kfree_skb(skb);
> 
> I dunno, this duplicate kfree_skb() is quite unusual and would deserve
> a comment.
> 
> I would perhaps use
> 
>    if (!WARN_ON_ONCE(skb_unref(skb))
>       kfree_skb(skb);
>

Ah, this is what I wanted..!  Somehow I was wondering if I should use
either kfree_skb() or refcount_dec() directly :S

Will post v2, thanks!

