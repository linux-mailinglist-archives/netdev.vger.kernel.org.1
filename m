Return-Path: <netdev+bounces-72266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1828857405
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 04:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A75E1F2295C
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 03:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DBAFBEB;
	Fri, 16 Feb 2024 03:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhfmTwRX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555CC10940
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708055486; cv=none; b=MoLrdCUAQiayFqyTj5OtkWLbUFfnDLij3QX6dWybYko/QaJdcmKefWHUFozodC5GRg7yu0PWe/CKNHzwLJI0M8q9HVsLnpPVxMEzJ3itBgtGJO+pgc9F2Jf83sLtEGMESzN/JVXV8y+7uRulcl0VBPtfEFf3g+QJzfH+n5Q8ccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708055486; c=relaxed/simple;
	bh=5BpKlHlW8btPc/Oijlg3XDgktTXv3fBx5XwC+P0hQDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAIp2HNjflfXKAwXKlGWwIsLLjljdXWyHzQhvYCHThDhpP8Mtk1NU1ZCeifWT2vEw/2/vLbwwJn5rA8MjdKt60e93xJIyeUh9dHXQjnviIhRsbEJgb/RmCVVybKnlDUMDXYMwWLvAtaX7je2SMlUgHii1ds6AW/Nrkv92G3C+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhfmTwRX; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d109e7bed2so20835331fa.2
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 19:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708055482; x=1708660282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAe8oTPs9fnN2IRayRcB/z7KUUNpWb5CStN+U8Ojlt8=;
        b=mhfmTwRXNZ1lWDt8pAOjll/1q9uUkqOmYRA3CM2O+MNYYV7A3KbtuWengs+tsB/eIv
         Eu8GxHBCI1PDDFlEHy2lo4CWnmUlnNOwIH4/n40GXtmfCgDKs1jA/n+6yUWXs1NzWU0n
         9kv92k/6bCcMK4o/ac0IDKKFqDT3/TPQp1dS2gwC2fjQOain/96N8U+frRdVD8AzStdL
         p7fVAaP5neK8mNAJqlELECYnNG0SiEwaKjuD6L/FL0O0+tVEQRGhCzkKe2sRSYGp3yMa
         4D0W+4jJ5d57n7SURx+VyHh6dy2DIqJQtqJPy8cme8s+RR/ZEgO63KWRArAw4r9OWwvU
         KMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708055482; x=1708660282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAe8oTPs9fnN2IRayRcB/z7KUUNpWb5CStN+U8Ojlt8=;
        b=lRV6w+90sGAocOC5Ybdewwn7t7KJy7PREPoF5vyTUmIfSllBX2EqLTxCODWc5iINGc
         PYphDqM8nIUbZCTLEYN8GZ5+Nb0xFJCKx359fFU6qrqYIuTBcWZR+FRzY2iXO65973kv
         uf6ABYA7BCAu7wNJKp5iTrHH8mlAR7svYoZlMn+rKyTxtryDrD70qRGsvZs+Tm43Ka3x
         bbu1xN0yA4Uw/LXkofMClZVZ8FBtDwH3WR9AYBOrNBWbEapbExPdegbPk29BBXn4wTu/
         1qiSMr8RqWrEW/7NpsTp9ckXGJ73Nj556p1eg6WdJdM9zmKMl/Cdwmb1JuROVMxsROnw
         OpfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzkdEegHXPfMgiarb5LM9nET+a/H+N9WghjFrCIqr0ciRm5pQ237g/32iZLgYe8JZfZdhlD6UQZ466+kqLLpKua+GwqojM
X-Gm-Message-State: AOJu0YxoKsFWTmYoUm6SYWS0cXtQJJ/M9ex5RPZAw4aR3nypDS37af+i
	SOpg4g80BOFxQqWe+4CYM5WpCRrO39CKxK8RCVNaUT4OS71/S9l/wylp5VaoCaa3rV/VziQ+eQf
	TPX5pvf3Kn5RHiLeulUh3s78xz7qMQRjpGH1Y6w==
X-Google-Smtp-Source: AGHT+IGpuiV8WjvIm86JF9WCjiV5f7J2ZLkhUUudf1yVa6xboKMzmt5lf55P+Y3aPZ0+20lLyUwDCSYWrYzA/3TvRKo=
X-Received: by 2002:a2e:2201:0:b0:2d0:9bd4:c6c5 with SMTP id
 i1-20020a2e2201000000b002d09bd4c6c5mr2521654lji.42.1708055482046; Thu, 15 Feb
 2024 19:51:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDCOJCX8NerEpu_0gxhdPCABADRKSpBAJEXohTXBBqTSQ@mail.gmail.com>
 <20240216030311.54629-1-kuniyu@amazon.com>
In-Reply-To: <20240216030311.54629-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 Feb 2024 11:50:45 +0800
Message-ID: <CAL+tcoCrqUbHp1k9giaJL5AmGtsumVpMYDdcaXuNqpyKihLbkg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/11] tcp: use drop reasons in cookie check
 for ipv4
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:03=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Fri, 16 Feb 2024 09:28:26 +0800
> > On Fri, Feb 16, 2024 at 5:09=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > Date: Thu, 15 Feb 2024 09:20:19 +0800
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Now it's time to use the prepared definitions to refine this part.
> > > > Four reasons used might enough for now, I think.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > --
> > > > v5:
> > > > Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=3DJk=
neEEM=3DnAj-28eNtcOCkwQjw@mail.gmail.com/
> > > > Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a=
6c6b6c@kernel.org/
> > > > 1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new =
one (Eric, David)
> > > > 2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket =
allocation (Eric)
> > > > 3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> > > > ---
> > > >  net/ipv4/syncookies.c | 18 +++++++++++++-----
> > > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > > > index 38f331da6677..aeb61c880fbd 100644
> > > > --- a/net/ipv4/syncookies.c
> > > > +++ b/net/ipv4/syncookies.c
> > > > @@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, =
struct sk_buff *skb)
> > > >               if (IS_ERR(req))
> > > >                       goto out;
>
> I noticed in this case (ret =3D=3D sk) we can set drop reason in
> tcp_v4_do_rcv() as INVALID_COOKIE or something else.

If cookie_v4_check() returns the sk which is the same as the first
parameter of its caller (tcp_v4_do_rcv()), then we cannot directly
drop it because it is against old behaviours and causes errors. It
should go into tcp_rcv_state_process() later. The similar mistake I
made was reported by Paolo in the patch [0/11] (see link[1] as below).

link[1]: https://lore.kernel.org/netdev/c987d2c79e4a4655166eb8eafef473384ed=
b37fb.camel@redhat.com/

>
>
> > > >       }
> > > > -     if (!req)
> > > > +     if (!req) {
> > > > +             SKB_DR_SET(reason, NOMEM);
> > >
> > > NOMEM is not appropriate when mptcp_subflow_init_cookie_req() fails.
> >
> > Thanks for your careful check. It's true. I didn't check the MPTCP
> > path about how to handle it.
> >
> > It also means that what I did to the cookie_v6_check() is also wrong.
>
> Yes, same for the v6 change.
>
>
> >
> > [...]
> > > >       /* Try to redo what tcp_v4_send_synack did. */
> > > >       req->rsk_window_clamp =3D tp->window_clamp ? :dst_metric(&rt-=
>dst, RTAX_WINDOW);
> > > > @@ -476,10 +482,12 @@ struct sock *cookie_v4_check(struct sock *sk,=
 struct sk_buff *skb)
> > > >       /* ip_queue_xmit() depends on our flow being setup
> > > >        * Normal sockets get it right from inet_csk_route_child_sock=
()
> > > >        */
> > > > -     if (ret)
> > > > +     if (ret) {
> > > >               inet_sk(ret)->cork.fl.u.ip4 =3D fl4;
> > > > -     else
> > > > +     } else {
> > > > +             SKB_DR_SET(reason, NO_SOCKET);
> > >
> > > This also seems wrong to me.
> > >
> > > e.g. syn_recv_sock() could fail with sk_acceptq_is_full(sk),
> > > then the listener is actually found.
> >
> > Initially I thought using a not-that-clear name could be helpfull,
> > though. NO_SOCKET here means no child socket can be used if I add a
> > new description to SKB_DROP_REASON_NO_SOCKET.
>
> Currently, NO_SOCKET is used only when sk lookup fails.  Mixing
> different reasons sounds like pushing it back to NOT_SPECIFIED.
> We could distinguish them by the caller IP though.

It makes some sense, but I still think NO_SOCKET is just a mixture of
three kinds of cases (no sk during lookup process, no child sk, no
reqsk).
Let me think about it.

>
>
> >
> > If the idea is proper, how about using NO_SOCKET for the first point
> > you said to explain that there is no request socket that can be used?
> >
> > If not, for both of the points you mentioned, it seems I have to add
> > back those two new reasons (perhaps with a better name updated)?
> > 1. Using SKB_DROP_REASON_REQSK_ALLOC for the first point (request
> > socket allocation in cookie_v4/6_check())
> > 2. Using SKB_DROP_REASON_GET_SOCK for the second point (child socket
> > fetching in cookie_v4/6_check())
> >
> > Now I'm struggling with the name and whether I should introduce some
> > new reasons like what I did in the old version of the series :S
>
> Why naming is hard would be because there are multiple reasons of
> failure.  One way to be more specific is moving kfree_skb_reason()
> into callee as you did in patch 2.
>
>
> > If someone comes up with a good name or a good way to explain them,
> > please tell me, thanks!
>
> For 1. no idea :p
>
> For 2. Maybe VALID_COOKIE ?  we drop the valid cookie in the same
> function, but due to LSM or L3 layer, so the reason could be said
> as L4-specific ?

Thanks for your idea :)

For 2, if we're on the same page and talk about how to handle
tcp_get_cookie_sock(), the name is not that appropriate because as you
said in your previous email it could fail due to full of accept queue
instead of cookie problem.

If we're talking about cookie_tcp_check(), the name is also not that
good because the drop reason could be no memory which is unrelated to
cookie, right?

COOKIE, it seems, cannot be the keyword/generic reason to conclude all
the reasons for either of them...

Thanks,
Jason

>
>
> >
> > also cc Eric, David
> >
> > Thanks,
> > Jason
> >

