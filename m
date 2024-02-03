Return-Path: <netdev+bounces-68843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DE98487FA
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 18:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E60E2857DA
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8A85F878;
	Sat,  3 Feb 2024 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iNlniZ56"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6362A5F86A
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706982070; cv=none; b=pgvvbnzD81cHnxom566HUi4yGAPKH3qp+cCZCWaXpbFd/d1tvB8jXRhuJk6bsabOgn9owSgJqovjW6UwutSU1gQt/qmazls33zLuRUlBkYd+cVFjBBSVKoTQAUMxvZzbrphI/X+5/5DtWpWQL1qgLa4CL+6ZkMTTIdx35ko7YnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706982070; c=relaxed/simple;
	bh=ahNSL88JkpmTJaNN9Ir/IqpAXiIcOc6MGjPADsMCVtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJ6HL+7w1CWNoPugIksWXyCbIzJ9/xcpOhBOBr0kJmBlhQX+5N2vs2us5O9e/Ia52yrkAdjg5UxCsC6nXUvfZ43Iz9NZpYidr8X9q/cx+1UVvp4DdZztPiBSX9AGDnm487LbcfGZonLfJsGmvbdlr3qsLabBPVoUjlfaTpwNuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iNlniZ56; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706982068; x=1738518068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6PH7AVdlD530iP0YZ8d6QXQNVjTyVY6LTlT9K9LY3z0=;
  b=iNlniZ56paw/1zkzz5+xHZBkBh94+JO9fPKsMkQo4cJ9NqcKG6kQi4m+
   kCIk236P2eaxCymcx6Kf6RzjZ/UFpMiaYxgp0BqOG+zFrqhYb8QEipuH/
   gbJrHN52gbvUaDq48XBOf6Kqq3K11yVSIMqokC4fkcGKMbB6P8wQYPDG6
   k=;
X-IronPort-AV: E=Sophos;i="6.05,240,1701129600"; 
   d="scan'208";a="63449910"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 17:41:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:11929]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.177:2525] with esmtp (Farcaster)
 id 72f3a758-4fd0-40e9-8094-8370b1fd4b95; Sat, 3 Feb 2024 17:41:06 +0000 (UTC)
X-Farcaster-Flow-ID: 72f3a758-4fd0-40e9-8094-8370b1fd4b95
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 17:41:06 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 17:41:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com>
Subject: Re: [PATCH v1 net] af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
Date: Sat, 3 Feb 2024 09:40:54 -0800
Message-ID: <20240203174054.58609-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89i+1Uvtx+6v_ZNm6dx1zdOTeT1i=8k0b0FdcTvNHJJFmFA@mail.gmail.com>
References: <CANn89i+1Uvtx+6v_ZNm6dx1zdOTeT1i=8k0b0FdcTvNHJJFmFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sat, 3 Feb 2024 12:42:12 +0100
> On Sat, Feb 3, 2024 at 10:15 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Eric Dumazet <edumazet@google.com>
> > Date: Sat, 3 Feb 2024 10:01:04 +0100
> > > On Sat, Feb 3, 2024 at 9:33 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > >
> > > > syzbot reported a warning [0] in __unix_gc() with a repro, which
> > > > creates a socketpair and sends one socket's fd to itself using the
> > > > peer.
> > > >
> > > >   socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
> > > >   sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\360", iov_len=1}],
> > > >           msg_iovlen=1, msg_control=[{cmsg_len=20, cmsg_level=SOL_SOCKET,
> > > >                                       cmsg_type=SCM_RIGHTS, cmsg_data=[3]}],
> > > >           msg_controllen=24, msg_flags=0}, MSG_OOB|MSG_PROBE|MSG_DONTWAIT|MSG_ZEROCOPY) = 1
> > > >
> > > > This forms a self-cyclic reference that GC should finally untangle
> > > > but does not due to lack of MSG_OOB handling, resulting in memory
> > > > leak.
> > > >
> > > > Recently, commit 11498715f266 ("af_unix: Remove io_uring code for
> > > > GC.") removed io_uring's dead code in GC and revealed the problem.
> > > >
> > > > The code was executed at the final stage of GC and unconditionally
> > > > moved all GC candidates from gc_candidates to gc_inflight_list.
> > > > That papered over the reported problem by always making the following
> > > > WARN_ON_ONCE(!list_empty(&gc_candidates)) false.
> > > >
> > > > The problem has been there since commit 2aab4b969002 ("af_unix: fix
> > > > struct pid leaks in OOB support") added full scm support for MSG_OOB
> > > > while fixing another bug.
> > > >
> > > > To fix this problem, we must call kfree_skb() for unix_sk(sk)->oob_skb
> > > > if the socket still exists in gc_candidates after purging collected skb.
> > > >
> > > > Note that the leaked socket remained being linked to a global list, so
> > > > kmemleak also could not detect it.  We need to check /proc/net/protocol
> > > > to notice the unfreed socket.
> > > >
> > > > [
> > > > Reported-by: syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=fa3ef895554bdbfd1183
> > > > Fixes: 2aab4b969002 ("af_unix: fix struct pid leaks in OOB support")
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > > Given the commit disabling SCM_RIGHTS w/ io_uring was backporeted to
> > > > stable trees, we can backport this patch without commit 11498715f266,
> > > > so targeting net tree.
> > > > ---
> > > >  net/unix/garbage.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > > > index 2405f0f9af31..61f313d4a5dd 100644
> > > > --- a/net/unix/garbage.c
> > > > +++ b/net/unix/garbage.c
> > > > @@ -314,6 +314,15 @@ void unix_gc(void)
> > > >         /* Here we are. Hitlist is filled. Die. */
> > > >         __skb_queue_purge(&hitlist);
> > > >
> > > > +       list_for_each_entry_safe(u, next, &gc_candidates, link) {
> > > > +               struct sk_buff *skb = u->oob_skb;
> > > > +
> > > > +               if (skb) {
> > > > +                       u->oob_skb = NULL;
> > > > +                       kfree_skb(skb);
> > > > +               }
> > > > +       }
> > > > +
> > >
> > > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > >
> > > Note there is already a 'struct sk_buff *skb;" variable in scope.
> > >
> > > This could be rewritten
> > >
> > > list_for_each_entry_safe(u, next, &gc_candidates, link) {
> > >         kfree_skb(u->oob_skb);
> > >         u->oob_skb = NULL;
> > > }
> >
> > I wrote that in the inital fix but noticed that this
> > kfree_skb() triggers fput(), and later in unix_release_sock()
> > we will call the duplicate kfree_skb().
> >
> >         if (u->oob_skb) {
> >                 kfree_skb(u->oob_skb);
> >                 u->oob_skb = NULL;
> >         }
> >
> > So, we need to set NULL before kfree_skb() in __unix_gc().
> 
> Okay...
> 
> But we probably need :
> 
> #if IS_ENABLED(CONFIG_AF_UNIX_OOB)

Ah exactly, thanks for catching!

will fix in v2.

