Return-Path: <netdev+bounces-13998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BED73E4C5
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BA5280DE7
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B6D111B9;
	Mon, 26 Jun 2023 16:18:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C10DDD6
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 16:18:09 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C92421A
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687796262; x=1719332262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NcKGNZEeegx/XWD4EmSNQ84ptypc4fdf+HNCUJPYbWg=;
  b=uXj45IDAe9Cigjxsa0R9C7oH22mMbW3gON0Jlm061/rwwJw9LxKMlV/X
   IK8DJ1sKOq2IOCOBNp/q0ccYcsEOMumSY4o4oJFqdOLzJz1G1MNkHzOW5
   N4c+FCPgVjE8MNsB2is5A/NTQOTfPNYt3lfcne48aFfVKeUueWEniqVAM
   g=;
X-IronPort-AV: E=Sophos;i="6.01,159,1684800000"; 
   d="scan'208";a="341052479"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 16:17:03 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id A899846AC2;
	Mon, 26 Jun 2023 16:17:01 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 16:16:52 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 26 Jun 2023 16:16:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com>
Subject: Re: [PATCH v1 net] netlink: Add sock_i_ino_irqsaved() for __netlink_diag_dump().
Date: Mon, 26 Jun 2023 09:16:42 -0700
Message-ID: <20230626161642.48464-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iL0n5Prem6Cjc6jkdAq6jm5AOYXWgn=i80UPsnNZE6WQw@mail.gmail.com>
References: <CANn89iL0n5Prem6Cjc6jkdAq6jm5AOYXWgn=i80UPsnNZE6WQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.187.170.15]
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jun 2023 09:21:30 +0200
> On Sun, Jun 25, 2023 at 6:14 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > syzbot reported a warning in __local_bh_enable_ip(). [0]
> >
> > Commit 8d61f926d420 ("netlink: fix potential deadlock in
> > netlink_set_err()") converted read_lock(&nl_table_lock) to
> > read_lock_irqsave() in __netlink_diag_dump() to prevent a deadlock.
> >
> > However, __netlink_diag_dump() calls sock_i_ino() that uses
> > read_lock_bh() and read_unlock_bh().  read_unlock_bh() finally
> > enables BH even though it should stay disabled until the following
> > read_unlock_irqrestore().
> >
> > Using read_lock() in sock_i_ino() would trigger a lockdep splat
> > in another place that was fixed in commit f064af1e500a ("net: fix
> > a lockdep splat"), so let's add another function that would be safe
> > to use under BH disabled.
> >
> > [0]:
> >
> > Fixes: 8d61f926d420 ("netlink: fix potential deadlock in netlink_set_err()")
> > Reported-by: syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=5da61cf6a9bc1902d422
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >
> 
> Hi Kuniyuki, thanks for the fix, I mistakenly released this syzbot
> bug/report the other day ;)
> 
> I wonder if we could use __sock_i_ino() instead of sock_i_ino_bh_disabled(),
> and perhaps something like the following to have less copy/pasted code ?

Ah, that's much cleaner and nice name :)
Will post v2 with the diff.

Thanks, Eric!


> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 6e5662ca00fe5638881db11c71c46169d59a2746..146a83c50c5d329fee2e833c4f2ba29e896d7766
> 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2550,13 +2550,25 @@ kuid_t sock_i_uid(struct sock *sk)
>  }
>  EXPORT_SYMBOL(sock_i_uid);
> 
> -unsigned long sock_i_ino(struct sock *sk)
> +/* Must be called while interrupts are disabled. */
> +unsigned long __sock_i_ino(struct sock *sk)
>  {
>         unsigned long ino;
> 
> -       read_lock_bh(&sk->sk_callback_lock);
> +       read_lock(&sk->sk_callback_lock);
>         ino = sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_ino : 0;
> -       read_unlock_bh(&sk->sk_callback_lock);
> +       read_unlock(&sk->sk_callback_lock);
> +       return ino;
> +}
> +EXPORT_SYMBOL(__sock_i_ino);
> +
> +unsigned long sock_i_ino(struct sock *sk)
> +{
> +       unsigned long ino;
> +
> +       local_bh_disable();
> +       ino = __sock_i_ino(sk);
> +       local_bh_enable();
>         return ino;
>  }
>  EXPORT_SYMBOL(sock_i_ino);

