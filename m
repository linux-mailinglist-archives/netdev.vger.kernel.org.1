Return-Path: <netdev+bounces-141950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D4E9BCC53
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32001F2259C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB41D3590;
	Tue,  5 Nov 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+58TR5e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351A1420A8
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808337; cv=none; b=Oze4x6+VVPyU96CiInlMAzyoq+NPyuZBKF/40a1KfgaBDRHbHD8xYJv3/bTntdd/Uy0ZVYh28DeOIKvQUlBr9qAYOuySfNlbcXQP6oNEJ82JqAbJ76sTN28NSN995j9VUn3jK8WCEjD0Ov5D2ZnUuD9zh6MIq6+7gvTbp1IEm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808337; c=relaxed/simple;
	bh=1o1hL7u8t3knUwr6QN9CBxlQ7s8tpURff1KLnwqTZJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjuG/InJtW1Yr8JayX1q/SIOEyy/j+slyxBi+fDwirH3IhtOupXPurfLKar2DWrOxiBTV7UJRYMCWPUY/BXOrtVM8cBLMHubxKrPUXPy2c2ngz/4d+CrYXMzDTo2hj7IDJEbKzrIvxpJKdEhKE4rvVydOhiDXskJL4vcfJgpAP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R+58TR5e; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cb74434bc5so6407801a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 04:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730808334; x=1731413134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF3hwYD23ug7VZfZqHJ0XCjhnmDAoHBN/jSAW6GSbDM=;
        b=R+58TR5eh9QF3H+v7QplmrnGH3EzCdTotFBMe9hTQo8NuZgmfOvvOBm8zrwAkNJhZL
         fzM1hF2eCrSwYaa4+s8kc0dR9qfOsECSulbni125mZUTfcoYKhs5tgTA+tN3F1ZTAOvs
         NmhoxV4KrHjjphkNiamLh1sWEmRk1IKqdH5hOnkTY84IM3m0ZrlYtTK0j6bBcE2CM6+k
         JleK11cYuVfUKiagjUteZC7QbQaadz29i3CDl0oGX+WZKWw/M+a5/8sg8jdWsN4stCEh
         xhBEmoaMpkhZaQa0n4Jn829ImJ0JmXC5QzgWg2VK/YMLm/gOg5kF7dz3s46DJmzPgNdi
         mSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730808334; x=1731413134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FF3hwYD23ug7VZfZqHJ0XCjhnmDAoHBN/jSAW6GSbDM=;
        b=Uj0yUzIfwx+l01EWOvpGS+N7VdJyNQ0gQhgANYeHrdGaTEZRpl54ix321o7rgK5seQ
         39irc621ZX0qCq1Y40ryy02XnCoKNASjZKohbKK8NE6tXKGe3VQafPCM1iU6g4CAuXUs
         UPZDyntMWyhnwWE3E3y28vZpPTcysUZJrSjqhehsdK0+F0qVobZWjN1t6Y6PDJSnzUac
         0Vp9zqIL7X2jZ2rxCsfVpVyeSUNGPE0yE0LIeX1r4ALL/6gMV2ItmDlLip055w/vgWG1
         KsfRNYn2DKPul5rreBV7l+JLXWNENz+ZgQkPhFfTeTQ2EE0rbfvRlmgUVEvAaRf7vhW5
         HXEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3Eg06wsg5PEWWE1omnAe6rcdowAA1kwz+UqcOJbZI6e/s92ZAiftwyPnd9pNOFY3yPdwRVLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweND8R/Gv82i4azgbzehHiTJyHKjrKpi6gX9K1HXYpDkaxCoSP
	E56LFjm5FOYyZJ0wP2faM6NRAEzGm9Qhgv37DuGYEP5zO++a0t4XoZTmH96IYepKG0aXsZqYe8f
	IYLkwvtPDR9roXLt3mTLF9b14CVn+aR6VSKZI
X-Google-Smtp-Source: AGHT+IFLvNlim71LLo6Kdt/lnGcW1D2y5GJ9cztTDnAmK2US9BCsS5zEDvIOxpDKrBrzO0dVNMIj9a7RwqYpgU2f8XA=
X-Received: by 2002:a05:6402:358f:b0:5ce:d6a0:be32 with SMTP id
 4fb4d7f45d1cf-5ced6a0c1bamr5035974a12.1.1730808333773; Tue, 05 Nov 2024
 04:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104152622.3580037-1-edumazet@google.com> <D2067CE4-F300-4DED-8012-9718FD6AB67F@remlab.net>
In-Reply-To: <D2067CE4-F300-4DED-8012-9718FD6AB67F@remlab.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 13:05:22 +0100
Message-ID: <CANn89iKN2HsFRYiboWn38zfptAsFRiRo89p7EGHFQu90=-O+3w@mail.gmail.com>
Subject: Re: [PATCH net-next] phonet: do not call synchronize_rcu() from phonet_route_del()
To: =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Remi Denis-Courmont <courmisch@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 12:05=E2=80=AFPM R=C3=A9mi Denis-Courmont <remi@reml=
ab.net> wrote:
>
>
>
> Le 4 novembre 2024 17:26:22 GMT+02:00, Eric Dumazet <edumazet@google.com>=
 a =C3=A9crit :
> >Calling synchronize_rcu() while holding rcu_read_lock() is not
> >permitted [1]
> >
> >Move the synchronize_rcu() to route_doit().
> >
> >[1]
> >WARNING: suspicious RCU usage
> >6.12.0-rc5-syzkaller-01056-gf07a6e6ceb05 #0 Not tainted
> >-----------------------------
> >kernel/rcu/tree.c:4092 Illegal synchronize_rcu() in RCU read-side critic=
al section!
> >
> >other info that might help us debug this:
> >
> >rcu_scheduler_active =3D 2, debug_locks =3D 1
> >1 lock held by syz-executor427/5840:
> >  #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire=
 include/linux/rcupdate.h:337 [inline]
> >  #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock in=
clude/linux/rcupdate.h:849 [inline]
> >  #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: route_doit+0x3d6=
/0x640 net/phonet/pn_netlink.c:264
> >
> >stack backtrace:
> >CPU: 1 UID: 0 PID: 5840 Comm: syz-executor427 Not tainted 6.12.0-rc5-syz=
kaller-01056-gf07a6e6ceb05 #0
> >Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 09/13/2024
> >Call Trace:
> > <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  lockdep_rcu_suspicious+0x226/0x340 kernel/locking/lockdep.c:6821
> >  synchronize_rcu+0xea/0x360 kernel/rcu/tree.c:4089
> >  phonet_route_del+0xc6/0x140 net/phonet/pn_dev.c:409
> >  route_doit+0x514/0x640 net/phonet/pn_netlink.c:275
> >  rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6790
> >  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
> >  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
> >  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
> >  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
> >  sock_sendmsg_nosec net/socket.c:729 [inline]
> >  __sock_sendmsg+0x221/0x270 net/socket.c:744
> >  sock_write_iter+0x2d7/0x3f0 net/socket.c:1165
> >  new_sync_write fs/read_write.c:590 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:683
> >  ksys_write+0x183/0x2b0 fs/read_write.c:736
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >Fixes: 17a1ac0018ae ("phonet: Don't hold RTNL for route_doit().")
> >Reported-by: syzbot <syzkaller@googlegroups.com>
> >Signed-off-by: Eric Dumazet <edumazet@google.com>
> >Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> >Cc: Remi Denis-Courmont <courmisch@gmail.com>
> >---
> > net/phonet/pn_dev.c     |  4 +++-
> > net/phonet/pn_netlink.c | 10 ++++++++--
> > 2 files changed, 11 insertions(+), 3 deletions(-)
> >
> >diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
> >index 19234d664c4fb537eba0267266efbb226cf103c3..578d935f2b11694fd1004c5f=
854ec344b846eeb2 100644
> >--- a/net/phonet/pn_dev.c
> >+++ b/net/phonet/pn_dev.c
> >@@ -406,7 +406,9 @@ int phonet_route_del(struct net_device *dev, u8 dadd=
r)
> >
> >       if (!dev)
> >               return -ENOENT;
> >-      synchronize_rcu();
> >+
> >+      /* Note : our caller must call synchronize_rcu() */
> >+
> >       dev_put(dev);
> >       return 0;
> > }
> >diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
> >index ca1f04e4a2d9eb3b2a6d6cc5b299aee28d569b08..24930733ac572ed3ec5fd142=
d347c115346a28fa 100644
> >--- a/net/phonet/pn_netlink.c
> >+++ b/net/phonet/pn_netlink.c
> >@@ -233,6 +233,7 @@ static int route_doit(struct sk_buff *skb, struct nl=
msghdr *nlh,
> > {
> >       struct net *net =3D sock_net(skb->sk);
> >       struct nlattr *tb[RTA_MAX+1];
> >+      bool sync_needed =3D false;
> >       struct net_device *dev;
> >       struct rtmsg *rtm;
> >       u32 ifindex;
> >@@ -269,16 +270,21 @@ static int route_doit(struct sk_buff *skb, struct =
nlmsghdr *nlh,
> >               return -ENODEV;
> >       }
> >
> >-      if (nlh->nlmsg_type =3D=3D RTM_NEWROUTE)
> >+      if (nlh->nlmsg_type =3D=3D RTM_NEWROUTE) {
> >               err =3D phonet_route_add(dev, dst);
> >-      else
> >+      } else {
> >               err =3D phonet_route_del(dev, dst);
> >+              if (!err)
> >+                      sync_needed =3D true;
> >+      }
> >
> >       rcu_read_unlock();
> >
> >       if (!err)
> >               rtm_phonet_notify(net, nlh->nlmsg_type, ifindex, dst);
> >
> >+      if (sync_needed)
> >+              synchronize_rcu();
>
> Synchronising after sending notifications sounds a bit iffy. Whatever a g=
iven notification is about should be fully committed so we don't create a u=
ser-visible race here.
>
> Can't we reorder here?

Fair enough, I will move dev_put() here in V2.

