Return-Path: <netdev+bounces-72269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B03785755D
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 05:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9706BB2149B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 04:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DE18BF8;
	Fri, 16 Feb 2024 04:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9qFw0AU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F04D12E47
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 04:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708058534; cv=none; b=jeZa7csBvj+BEb4a/pn6xB6bsqpvISKNaJngzIZ85DwtrCg/lcXjNBOvmROlXmsswXEs66Tji5jdnwW2juKXJ3vw7A6lyxrBm8B/xRaiJz3HvIMhoOvnb8XOkwr4cBLrMil8hPEHQyniIqYkxxQS1poF0h3JpW4SG+FBfpJMvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708058534; c=relaxed/simple;
	bh=ftTyiemrMQVUiv9P3GHwFUpQyw8hGwFYLiL4tOjihJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ji8Dxz+mmYA70k6y6QC5/sGiQ2zm4/UjhD/YyOw0ByYrHQ6uYsD/etKmNz+kra7UiG/SzuZPgTN4ZqtV5kH3T9prj5EqKP0H10LhGGacJtPQFj873zhbc9vaK1Y6gVXZjoumjZIx3bx0mgT0aNYUewvR3tsTm5P8+5XExxrJut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9qFw0AU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso1484345a12.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 20:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708058530; x=1708663330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jetdylVErGYNoiU3y2Jz2qGdQXYmipmCWHCYh/4V5g=;
        b=R9qFw0AUPA8V/27h4oTYWyN832jONtTeyLknn3CjZAKdIVd8IXbgxrIPdChZxcLmN4
         TqV2cetAohXwHniJEdJh1cFmj1X0wPBbvBOqGj7I2ommn2YOTohwnxjZuRtFDZd7TpHI
         aSAE2MctABny47E+JXGa6GL0N37ysQRVA1ySMuYxSaIp89LfgsAyzCNglF0w46AVp1Bs
         Eup1VUuMq/Mmu5cWTblUD/z5Mpo4hZWNkOCSDRURJm6dmrqneGDZDYZu92JUeH1fSAKN
         vKdqwuJuJPqnPFBvm8BJKHUEM3NZlr0WhGXWNCl9HDbtR/QarLtdtxv4bF182Fw20Z9V
         kPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708058530; x=1708663330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jetdylVErGYNoiU3y2Jz2qGdQXYmipmCWHCYh/4V5g=;
        b=ipiL4ByyUdlLmyXXjajXYevkDTSJ98qGFvCYfdDMoZiuKSoRezvu6BSFDB/Kw/F0EK
         Vd2DCn6n8fnB1OmApjtt+gtf/NNajflFizRInjDoqejjmb+vYvSCcZt3Fxne1m8YjAD5
         z/l1S2lUvD+j+NsEO6X1I6EqoxtkoNALSWrQOD2pBlAapOBUGeuqBSMaGeZyueOEOtYQ
         l2G5PuUji0uiUX/L8OYCUvt3u2Q5sYO9j3aoIl+7YeW+Eks7d6XC8x65cC+FRdXfdzZJ
         vUAmMzG7J1G0s6xPCo5pgpm3dpOdmTnRST01F4wmHS8hOJZkCOIZ91ikC11ulMluMYcm
         szSA==
X-Forwarded-Encrypted: i=1; AJvYcCVQuEj/7equCWZz6514R5tTYEeWeV+6zRUmLfUilw1p1Acqa4F+PPSRCN//jjG0BdxVyKLTpePGEixaqJFonBn2mbpeSkwg
X-Gm-Message-State: AOJu0Yx8pqUFq5PqOQkjZDVcOHJP+UMLPA1XLcodu0NfRUWO6EAAX0IL
	6AAzUOjywSGrNJJ7DfNjq4E0+tDX2dPdzxmOn7egn1SDT3XAdKhJomWOe9Lrbm2BhLHnxAKeScC
	gt8XtTyyOE+cU4TWQaXuQn5dSeJA=
X-Google-Smtp-Source: AGHT+IFPeyRpr1Gwp7SzSPeokThxt/IhqN/VY2tQrCy3U0dagvU8irgnuVESP+j3TK97VNyJZfHY5oJ58529t7Z6jF0=
X-Received: by 2002:a50:fc12:0:b0:562:9e4f:6bd1 with SMTP id
 i18-20020a50fc12000000b005629e4f6bd1mr2459879edr.9.1708058530087; Thu, 15 Feb
 2024 20:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoCrqUbHp1k9giaJL5AmGtsumVpMYDdcaXuNqpyKihLbkg@mail.gmail.com>
 <20240216041136.60555-1-kuniyu@amazon.com>
In-Reply-To: <20240216041136.60555-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 Feb 2024 12:41:33 +0800
Message-ID: <CAL+tcoAF=U7GQO=GVDvxEG-piOmmBg8vfvZ=ms3mH0Qkevm1rw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/11] tcp: use drop reasons in cookie check
 for ipv4
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 12:11=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Fri, 16 Feb 2024 11:50:45 +0800
> > On Fri, Feb 16, 2024 at 11:03=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amaz=
on.com> wrote:
> > >
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > Date: Fri, 16 Feb 2024 09:28:26 +0800
> > > > On Fri, Feb 16, 2024 at 5:09=E2=80=AFAM Kuniyuki Iwashima <kuniyu@a=
mazon.com> wrote:
> > > > >
> > > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > > Date: Thu, 15 Feb 2024 09:20:19 +0800
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > Now it's time to use the prepared definitions to refine this pa=
rt.
> > > > > > Four reasons used might enough for now, I think.
> > > > > >
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > --
> > > > > > v5:
> > > > > > Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=
=3DJkneEEM=3DnAj-28eNtcOCkwQjw@mail.gmail.com/
> > > > > > Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d=
545a6c6b6c@kernel.org/
> > > > > > 1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a =
new one (Eric, David)
> > > > > > 2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request soc=
ket allocation (Eric)
> > > > > > 3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> > > > > > ---
> > > > > >  net/ipv4/syncookies.c | 18 +++++++++++++-----
> > > > > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > > > > > index 38f331da6677..aeb61c880fbd 100644
> > > > > > --- a/net/ipv4/syncookies.c
> > > > > > +++ b/net/ipv4/syncookies.c
> > > > > > @@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *=
sk, struct sk_buff *skb)
> > > > > >               if (IS_ERR(req))
> > > > > >                       goto out;
> > >
> > > I noticed in this case (ret =3D=3D sk) we can set drop reason in
> > > tcp_v4_do_rcv() as INVALID_COOKIE or something else.
> >
> > If cookie_v4_check() returns the sk which is the same as the first
> > parameter of its caller (tcp_v4_do_rcv()), then we cannot directly
> > drop it
>
> No, I meant we can just set drop reason, not calling kfree_skb_reason()
> just after cookie_v4_check().
>
> Then, in tcp_v4_do_rcv(), the default reason is NOT_SPECIFIED, but
> INVALID_COOKIE only when cookie_v4_check() returns the listener.
>
> ---8<---
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 0c50c5a32b84..05cd697a7c07 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1923,6 +1923,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *=
skb)
>                         }
>                         return 0;
>                 }
> +
> +               reason =3D SKB_DROP_REASON_INVALID_COOKIE;
>         } else
>                 sock_rps_save_rxhash(sk, skb);

After this, it will go into 'reason =3D tcp_rcv_state_process()' which
will replace INVALID_COOKIE reason if the kernel is shipped with this
series.

>
> ---8<---
>
>
> > because it is against old behaviours and causes errors. It
> > should go into tcp_rcv_state_process() later. The similar mistake I
> > made was reported by Paolo in the patch [0/11] (see link[1] as below).
> >
> > link[1]: https://lore.kernel.org/netdev/c987d2c79e4a4655166eb8eafef4733=
84edb37fb.camel@redhat.com/
> >
> > >
> > >
> > > > > >       }
> > > > > > -     if (!req)
> > > > > > +     if (!req) {
> > > > > > +             SKB_DR_SET(reason, NOMEM);
> > > > >
> > > > > NOMEM is not appropriate when mptcp_subflow_init_cookie_req() fai=
ls.
> > > >
> > > > Thanks for your careful check. It's true. I didn't check the MPTCP
> > > > path about how to handle it.
> > > >
> > > > It also means that what I did to the cookie_v6_check() is also wron=
g.
> > >
> > > Yes, same for the v6 change.
> > >
> > >
> > > >
> > > > [...]
> > > > > >       /* Try to redo what tcp_v4_send_synack did. */
> > > > > >       req->rsk_window_clamp =3D tp->window_clamp ? :dst_metric(=
&rt->dst, RTAX_WINDOW);
> > > > > > @@ -476,10 +482,12 @@ struct sock *cookie_v4_check(struct sock =
*sk, struct sk_buff *skb)
> > > > > >       /* ip_queue_xmit() depends on our flow being setup
> > > > > >        * Normal sockets get it right from inet_csk_route_child_=
sock()
> > > > > >        */
> > > > > > -     if (ret)
> > > > > > +     if (ret) {
> > > > > >               inet_sk(ret)->cork.fl.u.ip4 =3D fl4;
> > > > > > -     else
> > > > > > +     } else {
> > > > > > +             SKB_DR_SET(reason, NO_SOCKET);
> > > > >
> > > > > This also seems wrong to me.
> > > > >
> > > > > e.g. syn_recv_sock() could fail with sk_acceptq_is_full(sk),
> > > > > then the listener is actually found.
> > > >
> > > > Initially I thought using a not-that-clear name could be helpfull,
> > > > though. NO_SOCKET here means no child socket can be used if I add a
> > > > new description to SKB_DROP_REASON_NO_SOCKET.
> > >
> > > Currently, NO_SOCKET is used only when sk lookup fails.  Mixing
> > > different reasons sounds like pushing it back to NOT_SPECIFIED.
> > > We could distinguish them by the caller IP though.
> >
> > It makes some sense, but I still think NO_SOCKET is just a mixture of
> > three kinds of cases (no sk during lookup process, no child sk, no
> > reqsk).
> > Let me think about it.
> >
> > >
> > >
> > > >
> > > > If the idea is proper, how about using NO_SOCKET for the first poin=
t
> > > > you said to explain that there is no request socket that can be use=
d?
> > > >
> > > > If not, for both of the points you mentioned, it seems I have to ad=
d
> > > > back those two new reasons (perhaps with a better name updated)?
> > > > 1. Using SKB_DROP_REASON_REQSK_ALLOC for the first point (request
> > > > socket allocation in cookie_v4/6_check())
> > > > 2. Using SKB_DROP_REASON_GET_SOCK for the second point (child socke=
t
> > > > fetching in cookie_v4/6_check())
> > > >
> > > > Now I'm struggling with the name and whether I should introduce som=
e
> > > > new reasons like what I did in the old version of the series :S
> > >
> > > Why naming is hard would be because there are multiple reasons of
> > > failure.  One way to be more specific is moving kfree_skb_reason()
> > > into callee as you did in patch 2.
> > >
> > >
> > > > If someone comes up with a good name or a good way to explain them,
> > > > please tell me, thanks!
> > >
> > > For 1. no idea :p
> > >
> > > For 2. Maybe VALID_COOKIE ?  we drop the valid cookie in the same
> > > function, but due to LSM or L3 layer, so the reason could be said
> > > as L4-specific ?
> >
> > Thanks for your idea :)
> >
> > For 2, if we're on the same page and talk about how to handle
> > tcp_get_cookie_sock(), the name is not that appropriate because as you
> > said in your previous email it could fail due to full of accept queue
> > instead of cookie problem.
>
> That's why I wrote _VALID_ COOKIE.  Here we know the cookie was valid
> but somehow 3WHS failed.  If we want to be more specific, what is not
> appropriate would be the place where we set the reason or call kfree_skb(=
).

Ah, I see. It does make sense if we use __VALID__. Let us hear more
voices, then I can accurately update the changes in the next version
:)

Really hope it can be done soon. It almost killed me :(

Thanks,
Jason

>
>
> >
> > If we're talking about cookie_tcp_check(), the name is also not that
> > good because the drop reason could be no memory which is unrelated to
> > cookie, right?
> >
> > COOKIE, it seems, cannot be the keyword/generic reason to conclude all
> > the reasons for either of them...
> >
> > Thanks,
> > Jason
> >
> > >
> > >
> > > >
> > > > also cc Eric, David
> > > >
> > > > Thanks,
> > > > Jason
> > > >

