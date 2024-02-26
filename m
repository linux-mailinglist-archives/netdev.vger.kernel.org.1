Return-Path: <netdev+bounces-75072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B003868135
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20DB1F222BF
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED52130E37;
	Mon, 26 Feb 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="trKABnXm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54407130AF0
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976431; cv=none; b=Ti2C6Ad5u1FrOOZ2WnzKdYeSuUe3sza6PUjoqCFZlVo6YIxeH3wwC3PYCm/zFOB7qf11pLoFMHBOKepqaYjVebXLQT+udKk8aGT5CTuLzuxRQSPlLcXgmDAzAqNHHgw7Y/FF6nm8PQrTpygySGbfEWktnyRTHetyKakO2/obwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976431; c=relaxed/simple;
	bh=zn8LEaSjNxaU50OcailwQKmQwS88jmdFVYLh4f1z9x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrzCu3ZUk0GMF00EVHc76o079/aQ7xUUSRtmKC1wgVIkXKP0DhNQkMxoXA1lBW0ZqNsGVtCFtl1MuKBopTlWArw+5XMWKXPEdZgaEldXcGhujVOqnBrIb+g+ovxiJy4391w6I0PHQymqMG1+pSvbOfRkAj4ZCPVpbA6FYGp9wkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=trKABnXm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so32a12.1
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708976424; x=1709581224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaCUhg0iw/jJnYGAwr5Ta1v43IvSijIxpUdzR3c3gNM=;
        b=trKABnXmoWdH+QlXZRJam5TfD4QbTch2k3WioWkpYyld0Kkwx8FHKlnix9UBx9RHMa
         l6dPCjQJl1XU5ENw8cfOIWxRUCdZPA8CcRVU6MBGVT6HcUDvBUfX6iq8PBcXX0PjwtHz
         bZ9YAMPB5Zy+wncGv5shXqM/R1Nf2uMlHGYyG0dhbR9SlRuh8+AeZ41W1GyxXYJZXUO4
         hYsCMqD5cpHt+GXeAXaonQD91hRjgX83q4/8zIdNMdmzLW9ARQEmZ0KP3J0aGznsQkvI
         duAvbg0ropVW9HyLl9gWFEsm0ErIfzGMwBgWjVuCkmpfGWxsMY38OubnRy13fq4ry7PE
         bILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976424; x=1709581224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaCUhg0iw/jJnYGAwr5Ta1v43IvSijIxpUdzR3c3gNM=;
        b=PtcxhZYG2EBJpqZuY1O2tbkQSLoJZNKa3LxDM2XU5rlldo+d4xS6K12D/mEXB1hmmz
         LcmNszGGyDSZyFpG3loK4OJ4NVrK4yqXjHBf0sFJD5UiceRroSMpEKGKK01EpsWAEki5
         5+xm2P0s0SgRYp67yVu6FCI/vRkDkcISBGBM6mkmzcOsyQSsFz2wGw4yiK5ekqw8qaUz
         RwJp6SWO/WOMJFK/mvqFY3x0NWvIXazcuXN8uht86rgqqAZ4VzTxdAMj4v3hhsP1wu1i
         CwysHi26WMJi3y2rR/B8GkTdjr69ONNmvA17PYOq0cZLAvXnhzsyMg8wh1cKtrX4mhBG
         AA0w==
X-Forwarded-Encrypted: i=1; AJvYcCWwROR9qc7kjua1qAO8Qp7k5P/7pZnf4ag1cJ/xx+ePfxovizpC0wTJThNR7+RR6diR3/QTnN4S0c+Ve8nDsCjS/yguo3Fb
X-Gm-Message-State: AOJu0YznkyhaRLJKt96m0lqAYcf3CI0CWWeK+MVHVEWSB+QG9wyXETs1
	IvI+Plg1FWf7fV16S7YE/jqB3O86wv/tw6toANsfhw/EqUVAj0eAkgH+oN3MiacRiGB9h/qgZvy
	FMom1MJ4FXuaQu6tth3WKiDr6HRowdV9tMaSh
X-Google-Smtp-Source: AGHT+IE6JywHFFZD3fR2P8dOv4akTE3O1cKNs8xd+7erQqlao00YI5Q/Mwq3tFN0arATrqp3NT1zqjqtewB1D9PGJNU=
X-Received: by 2002:a50:d490:0:b0:55f:8851:d03b with SMTP id
 s16-20020a50d490000000b0055f8851d03bmr18077edi.5.1708976423899; Mon, 26 Feb
 2024 11:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223182832.99661-1-kuniyu@amazon.com> <20240226191421.66834-1-kuniyu@amazon.com>
 <725e8196ad84a91fadcf8858422b20b13f71ca0c.camel@oracle.com>
In-Reply-To: <725e8196ad84a91fadcf8858422b20b13f71ca0c.camel@oracle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Feb 2024 20:40:10 +0100
Message-ID: <CANn89iJb-TeMKZCAzhfXhhzQ2FkYYZd9DqyHCwRoOn5KV4+Z5A@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "kuniyu@amazon.com" <kuniyu@amazon.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"sowmini.varadhan@oracle.com" <sowmini.varadhan@oracle.com>, 
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, "kuni1840@gmail.com" <kuni1840@gmail.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:22=E2=80=AFPM Allison Henderson
<allison.henderson@oracle.com> wrote:
>
> On Mon, 2024-02-26 at 11:14 -0800, Kuniyuki Iwashima wrote:
> > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Date: Fri, 23 Feb 2024 10:28:32 -0800
> > > From: Eric Dumazet <edumazet@google.com>
> > > Date: Fri, 23 Feb 2024 19:09:27 +0100
> > > > On Fri, Feb 23, 2024 at 6:26=E2=80=AFPM Kuniyuki Iwashima
> > > > <kuniyu@amazon.com> wrote:
> > > > >
> > > > > syzkaller reported a warning of netns tracker [0] followed by
> > > > > KASAN
> > > > > splat [1] and another ref tracker warning [1].
> > > > >
> > > > > syzkaller could not find a repro, but in the log, the only
> > > > > suspicious
> > > > > sequence was as follows:
> > > > >
> > > > >   18:26:22 executing program 1:
> > > > >   r0 =3D socket$inet6_mptcp(0xa, 0x1, 0x106)
> > > > >   ...
> > > > >   connect$inet6(r0, &(0x7f0000000080)=3D{0xa, 0x4001, 0x0,
> > > > > @loopback}, 0x1c) (async)
> > > > >
> > > > > The notable thing here is 0x4001 in connect(), which is
> > > > > RDS_TCP_PORT.
> > > > >
> > > > > So, the scenario would be:
> > > > >
> > > > >   1. unshare(CLONE_NEWNET) creates a per netns tcp listener in
> > > > >       rds_tcp_listen_init().
> > > > >   2. syz-executor connect()s to it and creates a reqsk.
> > > > >   3. syz-executor exit()s immediately.
> > > > >   4. netns is dismantled.  [0]
> > > > >   5. reqsk timer is fired, and UAF happens while freeing
> > > > > reqsk.  [1]
> > > > >   6. listener is freed after RCU grace period.  [2]
> > > > >
> > > > > Basically, reqsk assumes that the listener guarantees netns
> > > > > safety
> > > > > until all reqsk timers are expired by holding the listener's
> > > > > refcount.
> > > > > However, this was not the case for kernel sockets.
> > > > >
> > > > > Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
> > > > > inet_twsk_purge()") fixed this issue only for per-netns ehash,
> > > > > but
> > > > > the issue still exists for the global ehash.
> > > > >
> > > > > We can apply the same fix, but this issue is specific to RDS.
> > > > >
> > > > > Instead of iterating potentially large ehash and purging reqsk
> > > > > during
> > > > > netns dismantle, let's hold netns refcount for the kernel TCP
> > > > > listener.
> > > > >
> > > > >
> > > > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > > > Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen
> > > > > endpoints, one per netns.")
> > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > > ---
> > > > >  net/rds/tcp_listen.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> > > > > index 05008ce5c421..4f7863932df7 100644
> > > > > --- a/net/rds/tcp_listen.c
> > > > > +++ b/net/rds/tcp_listen.c
> > > > > @@ -282,6 +282,11 @@ struct socket *rds_tcp_listen_init(struct
> > > > > net *net, bool isv6)
> > > > >                 goto out;
> > > > >         }
> > > > >
> > > > > +       __netns_tracker_free(net, &sock->sk->ns_tracker,
> > > > > false);
> > > > > +       sock->sk->sk_net_refcnt =3D 1;
> > > > > +       get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> > > > > +       sock_inuse_add(net, 1);
> > > > > +
> > > >
> > > > Why using sock_create_kern() then later 'convert' this kernel
> > > > socket
> > > > to a user one ?
> > > >
> > > > Would using __sock_create() avoid this ?
> > >
> > > I think yes, but LSM would see kern=3D0 in pre/post socket() hooks.
> > >
> > > Probably we can use __sock_create() in net-next and see if someone
> > > complains.
> >
> > I noticed the patchwork status is Changes Requested.
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/netdev=
bpf/list/?series=3D829213&state=3D*__;Kg!!ACWV5N9M2RV99hQ!KHKUQKUDnNCdiEcb4=
ZK1VBiYSitarEb-CAWeSJvaeK04fgW4cuWePg3Ac2HmIAPUHuqeCwgt466fHEKAAdfa$
> >
> >
> > Should we use __sock_create() for RDS or add another parameter
> > to __sock_create(..., kern=3Dtrue/false, netref=3Dtrue/false) and
> > fix other similar uses (MPTCP, SMC, Netlink) altogether ?
> >
> > Thanks!
>
> Hi all,
>
> Thank you for looking at this.  I've been doing a little investigation
> in the area to better understand the issue and this fix.  While I
> understand what this patch is trying to do here, I'd like to do a
> little more digging as to why 740ea3c4a0b2 didnt work for rds, or what
> else rds may not be doing correctly that the other sockets are.  I'm
> not quite sure about setting the kern parameter to 0 for socket_create.
> While it seems like it would have a similar effect, this looks
> incorrect since this is not a user space socket.
>
> I'll do a little more diging myself too.  If you had another idea about
> adding parameters to __sock_create, I'd be happy to take a look.  Thank
> you!

I wonder if the following change would help ?

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9e85f2a0bddd4978b1bde6add1efc6aad351db8b..0ecc7311dc6ceedd8ada7b99b14=
41a562a6be4d6
100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -398,10 +398,6 @@ void tcp_twsk_purge(struct list_head
*net_exit_list, int family)
                        /* Even if tw_refcount =3D=3D 1, we must clean up
kernel reqsk */

inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo, family);
                } else if (!purged_once) {
-                       /* The last refcount is decremented in
tcp_sk_exit_batch() */
-                       if
(refcount_read(&net->ipv4.tcp_death_row.tw_refcount) =3D=3D 1)
-                               continue;
-
                        inet_twsk_purge(&tcp_hashinfo, family);
                        purged_once =3D true;
                }

