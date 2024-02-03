Return-Path: <netdev+bounces-68806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CC384855A
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 12:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A660AB23A65
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105BB5D8F3;
	Sat,  3 Feb 2024 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdtW8ERg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D112E51
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706960550; cv=none; b=fsNSNB3Mqry9ysJofi8o6mHSFBKpZgIyMyaK9k6mBgL5beb+hO3sBI4xzPBrvst5aTqwfjUJ9mIodnHOXcLfMFjgt6IccNI4pHgebpt5eEdW7vffspz4AX6pCozjk0gNlE3bCdUuUe0JwR+AMCHrLWPztO1A6QoCzbY+prgObSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706960550; c=relaxed/simple;
	bh=qscmBWYItm1OYK+aYkRANbjPwGBAK2rPM53g5vl7fTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8fokdxYyiLuvqzjlrtLx8WjIlRrKqMKZHwmPQ9pwMBE/wm6qLLgG4cAg8HwK8NQqqZjgowN0mHTWS4UCiEEB7dpuDy7mFnQrmTw+HMH44fi76X1OK7wEYjG4UmHPACSgCi1p4Uk9Ft884NbDa0HaIgskBVIIvoD2iUDBLHBB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdtW8ERg; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55f63fd3dd8so5672a12.0
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 03:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706960547; x=1707565347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpPCcDDznDCgjjCp36XnjNmSQNTppQ4Bwn5kv3pK/LM=;
        b=TdtW8ERgEvXl5Y3YYpVWrWPj8JmLlu0X1RRUizgnPtrN9lVt6I4yWh4AoB0dPtB/lX
         zvK6qTMj+UdPXi8kvll9ySs2RMmBd2RrYmOYxpKrwTjgkHKHLpeJIFZb3wFK9NIStAdM
         ojELCRrq68Ntj3JXYUZJ9G8gcAdDkfacgMFxlYibxiVt5cnb8inwrooIIf5/xkhoorAT
         2UXYEXZnpEWgLthTpRBesbLXpYhyCwRZTuCtLki/Cg/QkDBfLcsBIwb6Lo60F85gNK9+
         MXkwP/h3H5XPpYjX+2L3hvvragYncrCjLTdD85WTxuA0VRrcGXuw0BfSsxChE2rMy52T
         O1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706960547; x=1707565347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpPCcDDznDCgjjCp36XnjNmSQNTppQ4Bwn5kv3pK/LM=;
        b=hXvHi+yMi9v0WZfHRwXXX21OqnuVoxlzyeqrgHsbHjxWRElc+Wxcw404A1aZ167y/j
         WMsLu9y/DHvskL4rbOpAxHqA+N4SaOS2UF+QR4LkROTKBU1d+ApLf1a2iLAKc/NRWA9Z
         hisY+cyAKUmwKawnTlw1H3IpiTRQMDcpV/jE15hEg4ueK1f/X2UEwaoFKWJZgxQ6S8qG
         j2jvF3e4yG05cPc1D/JSlf/9MVuhRRB5cL2mfk2l3n87HXRGNvZttsVHsRePIaau8B4Y
         XUB1vknk7t8z+xn8MDKnsIL3GbejDwK+hniwUbTk8DmsNVaRqiXcH7PD2Yz8jz9/2HCA
         3OCw==
X-Gm-Message-State: AOJu0Yyj5I8RbjxPrw2n8hMRtKhZp9X+lSMZrsAhfZEtIwK4/pOzZWn1
	MPc1AOl7ND/X1mvmLCh+8E5nOPSctaXSKSSqMA5fekcQUVsVHXTZ2cW9/e6Ph7Db8VL+MsSbEzk
	9YWiXS7W8saMqi6FY/Php/oUysaNBDJVtHTmd
X-Google-Smtp-Source: AGHT+IFA0FWCVxrX58Hi9/M2syD7ndkkZnh5qiORx6beWDSHi0f14ggXQX5Y0oCu2BAQg71YvZrZURJfPWGo++uFGOY=
X-Received: by 2002:a50:9fa9:0:b0:560:2a2:37f7 with SMTP id
 c38-20020a509fa9000000b0056002a237f7mr73080edf.1.1706960546689; Sat, 03 Feb
 2024 03:42:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iL+BHiqZko-X0YWTdv9BCYXNY5w8rJsHf=X3NS9W+jkiA@mail.gmail.com>
 <20240203091459.9066-1-kuniyu@amazon.com>
In-Reply-To: <20240203091459.9066-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 3 Feb 2024 12:42:12 +0100
Message-ID: <CANn89i+1Uvtx+6v_ZNm6dx1zdOTeT1i=8k0b0FdcTvNHJJFmFA@mail.gmail.com>
Subject: Re: [PATCH v1 net] af_unix: Call kfree_skb() for dead
 unix_(sk)->oob_skb in GC.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, kuni1840@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 10:15=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Sat, 3 Feb 2024 10:01:04 +0100
> > On Sat, Feb 3, 2024 at 9:33=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > >
> > > syzbot reported a warning [0] in __unix_gc() with a repro, which
> > > creates a socketpair and sends one socket's fd to itself using the
> > > peer.
> > >
> > >   socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) =3D 0
> > >   sendmsg(4, {msg_name=3DNULL, msg_namelen=3D0, msg_iov=3D[{iov_base=
=3D"\360", iov_len=3D1}],
> > >           msg_iovlen=3D1, msg_control=3D[{cmsg_len=3D20, cmsg_level=
=3DSOL_SOCKET,
> > >                                       cmsg_type=3DSCM_RIGHTS, cmsg_da=
ta=3D[3]}],
> > >           msg_controllen=3D24, msg_flags=3D0}, MSG_OOB|MSG_PROBE|MSG_=
DONTWAIT|MSG_ZEROCOPY) =3D 1
> > >
> > > This forms a self-cyclic reference that GC should finally untangle
> > > but does not due to lack of MSG_OOB handling, resulting in memory
> > > leak.
> > >
> > > Recently, commit 11498715f266 ("af_unix: Remove io_uring code for
> > > GC.") removed io_uring's dead code in GC and revealed the problem.
> > >
> > > The code was executed at the final stage of GC and unconditionally
> > > moved all GC candidates from gc_candidates to gc_inflight_list.
> > > That papered over the reported problem by always making the following
> > > WARN_ON_ONCE(!list_empty(&gc_candidates)) false.
> > >
> > > The problem has been there since commit 2aab4b969002 ("af_unix: fix
> > > struct pid leaks in OOB support") added full scm support for MSG_OOB
> > > while fixing another bug.
> > >
> > > To fix this problem, we must call kfree_skb() for unix_sk(sk)->oob_sk=
b
> > > if the socket still exists in gc_candidates after purging collected s=
kb.
> > >
> > > Note that the leaked socket remained being linked to a global list, s=
o
> > > kmemleak also could not detect it.  We need to check /proc/net/protoc=
ol
> > > to notice the unfreed socket.
> > >
> > > [
> > > Reported-by: syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3Dfa3ef895554bdbfd118=
3
> > > Fixes: 2aab4b969002 ("af_unix: fix struct pid leaks in OOB support")
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > > Given the commit disabling SCM_RIGHTS w/ io_uring was backporeted to
> > > stable trees, we can backport this patch without commit 11498715f266,
> > > so targeting net tree.
> > > ---
> > >  net/unix/garbage.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > > index 2405f0f9af31..61f313d4a5dd 100644
> > > --- a/net/unix/garbage.c
> > > +++ b/net/unix/garbage.c
> > > @@ -314,6 +314,15 @@ void unix_gc(void)
> > >         /* Here we are. Hitlist is filled. Die. */
> > >         __skb_queue_purge(&hitlist);
> > >
> > > +       list_for_each_entry_safe(u, next, &gc_candidates, link) {
> > > +               struct sk_buff *skb =3D u->oob_skb;
> > > +
> > > +               if (skb) {
> > > +                       u->oob_skb =3D NULL;
> > > +                       kfree_skb(skb);
> > > +               }
> > > +       }
> > > +
> >
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> >
> > Note there is already a 'struct sk_buff *skb;" variable in scope.
> >
> > This could be rewritten
> >
> > list_for_each_entry_safe(u, next, &gc_candidates, link) {
> >         kfree_skb(u->oob_skb);
> >         u->oob_skb =3D NULL;
> > }
>
> I wrote that in the inital fix but noticed that this
> kfree_skb() triggers fput(), and later in unix_release_sock()
> we will call the duplicate kfree_skb().
>
>         if (u->oob_skb) {
>                 kfree_skb(u->oob_skb);
>                 u->oob_skb =3D NULL;
>         }
>
> So, we need to set NULL before kfree_skb() in __unix_gc().

Okay...

But we probably need :

#if IS_ENABLED(CONFIG_AF_UNIX_OOB)


>
>
> >
> > Also we probably can send this later:
>
> Yes, I changed as such in a new GC implementation, this needs
> respin for MSG_OOB support though...
> https://lore.kernel.org/netdev/20240203030058.60750-14-kuniyu@amazon.com/
>
> Thanks!
>
> >
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index 2405f0f9af31c0ccefe2aa404002cfab8583c090..02466224445c9ec9b125946=
8d30c89fc5e905a6b
> > 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -283,7 +283,7 @@ void unix_gc(void)
> >          * inflight counters for these as well, and remove the skbuffs
> >          * which are creating the cycle(s).
> >          */
> > -       skb_queue_head_init(&hitlist);
> > +       __skb_queue_head_init(&hitlist);
> >         list_for_each_entry(u, &gc_candidates, link)
> >                 scan_children(&u->sk, inc_inflight, &hitlist);

