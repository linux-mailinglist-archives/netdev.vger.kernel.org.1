Return-Path: <netdev+bounces-219818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6598AB4322F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9271668A9
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F8259CBD;
	Thu,  4 Sep 2025 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIH072QM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6959C2417D4
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966786; cv=none; b=nU1xlIAKlVC+Gv5OjinC7lABQxy6niZvYo4fSdptWOFgC1Q600cH7zwysDjnr5tvHIV+HhJqsJoFB/azJK0NKGKEUqTOiUaB1230V/xskOTB/sdTjRzZUcYyHh8AlD2oxHRtBb7E0S73fw6RZlWjspohy+PBREwgABW/pZsoCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966786; c=relaxed/simple;
	bh=sEv0vVkJRS2KUdMsNq+q9ROY+kL0WtoO4W828p76puk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQBHQhf6T4/YqKkSNJZ4NJCKkjwbLaEvu6z7LGLlIhGkbUTaiupG09/3ZLrBrUtpIkasglRSbNXDBntqdB5ILW6JNdbBYwRYa92sYF2nGKs513Kv6yay4gsPGv9CQoK6qqzn3WBDTeI0XNdO2NlSs+HS5sDNYqAWTkOwc6m6oe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIH072QM; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3f663225a2bso5499035ab.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 23:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756966784; x=1757571584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b44M1LvapLMYobQZ5mgV9Bk/DD4mzHbNf8HQ7pWMx1o=;
        b=HIH072QMleU49lrXFOYyLfY+umC2agPI82ukMTzOBitaLhZ+QxFv8A81uBetAvLnEq
         l2oJw2oEx+LP2jS+zORrxYEsUWQerU2LRP1s7afXj1ZGueLg7WF8S0G05C3curUuKZS6
         g2ksUN4x7QR0nmza0BeHyTkIsftwEdD3xjyz9AuoXmm9nCJ3NgimxRzDBKYch6wFPJ+y
         zKOLkGsgsdfKPs1FsUuqwFctv+CQLr1TVDNIhFdREGqEKizNHYLzDzvi9qLoax7UmNi9
         r56WK5hsnauORESdGmIBm3NmMCCJ+Yo6UEaiHoymkXhojAEboCj5isW+fvWcCJfn5G61
         XSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756966784; x=1757571584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b44M1LvapLMYobQZ5mgV9Bk/DD4mzHbNf8HQ7pWMx1o=;
        b=hYOdYVavu6JuzAdAF39nSLpJSxcmpcRQwRygFko/N7CKkY9kasC8XPcS1CeFcgwqqb
         HtYLgl0OffYXwXhN+80C3vXIwPmPkTrAPYYE6DZt1B7NcY9dJNgQHmobEp6TSxACGAOm
         GNJqhP1xz+iE9KqZFXaCg7Ftnx0PGrTqBOO7ghHpIxaVB6E0pL8ZSBNx6ZKnYroxGnp+
         RVKj5kd0NGk7bqYdxa9zOsZB9QS5pURlfXJG1t9lnEjxTY3mlMBLGJCf2sAMvTh5qXDo
         yMctEM8mUK56JAF0GQtpai3Ks3UeiRhHkaPy4LXd5av6jLdHw/6qztJ/nsadtsEcfgQf
         16kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyHPLmZjm+giiYYknHdxv11Z99ZRb3HOHmskivgYbdEuoa7lYH5S9VPHYfPprunRXM9Okkdj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws6fzm18iWtMl3kD/GUS9cOSFZM0Gb+eIiVSLXZZQMV4LiFbDj
	rRZMTR14jtv6wPnRoHhzJMeShQP2+0pPCmins0doXZb/txhDv2Xa0tn1HBY6v4OQV6u8FFHCJ0c
	hwPzg6eKscAIEkIYMHMdlUjyQlOXiOTU=
X-Gm-Gg: ASbGncs0ZJd3yNYMveiqu6jp6wNjqTCCcrKyPO955rZh1sNuCK0p4AoIXj1bf9fciDp
	GO9GMfPrIBdrl7zEzBhLmENwPDn3JZ4i9vK5wTxwArpu7twUnnpHa0a8X8FVQMSkMRGSMYFWRIQ
	1rWvRAHLhTzHRwpdk0o8nGYJBosWdR5DRx047Efu5b/EG5TIpofr3BU1J0Je0S6TUwQ3PV7ht8h
	UnJBBk=
X-Google-Smtp-Source: AGHT+IE3Rr/v64th8kfLDeU7CBbUXsOc9NaH0qizZKpujNqRWK49QELtYasp2HnzTNVmUj6gUI1kIDUQStIt9C033fQ=
X-Received: by 2002:a92:c24d:0:b0:3f0:bd1b:8b2f with SMTP id
 e9e14a558f8ab-3f3d410e14dmr370038955ab.3.1756966784404; Wed, 03 Sep 2025
 23:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-2-edumazet@google.com>
 <CAL+tcoCqey97QW=7n_S8V9t-haSe=mu9iE1sAaDmPPJ+1BkysA@mail.gmail.com> <CAAVpQUBgCyC+y+2M7=WKJVk=sivgeZtE2kwCxDLFCrgezycjZg@mail.gmail.com>
In-Reply-To: <CAAVpQUBgCyC+y+2M7=WKJVk=sivgeZtE2kwCxDLFCrgezycjZg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 4 Sep 2025 14:19:08 +0800
X-Gm-Features: Ac12FXxqxjZSqYJLeR1zupdhxnAVDivn1ee2TcX_wPxuhjNtVZbkPy3Hiy86vOM
Message-ID: <CAL+tcoBJxe6GkosVCS5Vzwk_z8W1WmxqLFELzXNwCRSYkQUyHw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp: fix __tcp_close() to only send RST when required
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 1:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Wed, Sep 3, 2025 at 10:04=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Wed, Sep 3, 2025 at 4:47=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > If the receive queue contains payload that was already
> > > received, __tcp_close() can send an unexpected RST.
> > >
> > > Refine the code to take tp->copied_seq into account,
> > > as we already do in tcp recvmsg().
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >
> > Sorry, Eric. I might be wrong, and I don't think it's a bugfix for now.
> >
> > IIUC, it's not possible that one skb stays in the receive queue and
> > all of the data has been consumed in tcp_recvmsg() unless it's
> > MSG_PEEK mode. So my understanding is that the patch tries to cover
> > the case where partial data of skb is read by applications and the
> > whole skb has not been unlinked from the receive queue yet. Sure, as
> > we can learn from tcp_sendsmg(), skb can be partially read.
>
> You can find a clear example in patch 2 that this patch fixes.

Oh, great, a very interesting corner case: resending data with FIN....
I just wasn't able to read the second patch in time...

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

>
> Without patch 1, the test fails:
>
> # ./ksft_runner.sh tcp_close_no_rst.pkt
> ...
> tcp_close_no_rst.pkt:32: error handling packet: live packet field
> tcp_fin: expected: 1 (0x1) vs actual: 0 (0x0)
> script packet:  0.140854 F. 1:1(0) ack 1002
> actual packet:  0.140844 R. 1:1(0) ack 1002 win 65535
> not ok 1 ipv4
>
>
> >
> > As long as 'TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq' has data
> > len, and the skb still exists in the receive queue, it can directly
> > means some part of skb hasn't been read yet. We can call it the unread
> > data case then, so the logic before this patch is right.
> >
> > Two conditions (1. skb still stays in the queue, 2. skb has data) make
> > sure that the data unread case can be detected and then sends an RST.
> > No need to replace it with copied_seq, I wonder? At least, it's not a
> > bug.
> >
> > Thanks,
> > Jason
> >
> >
> >
> >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/ipv4/tcp.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 40b774b4f587..39eb03f6d07f 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -3099,8 +3099,8 @@ bool tcp_check_oom(const struct sock *sk, int s=
hift)
> > >
> > >  void __tcp_close(struct sock *sk, long timeout)
> > >  {
> > > +       bool data_was_unread =3D false;
> > >         struct sk_buff *skb;
> > > -       int data_was_unread =3D 0;
> > >         int state;
> > >
> > >         WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
> > > @@ -3119,11 +3119,12 @@ void __tcp_close(struct sock *sk, long timeou=
t)
> > >          *  reader process may not have drained the data yet!
> > >          */
> > >         while ((skb =3D __skb_dequeue(&sk->sk_receive_queue)) !=3D NU=
LL) {
> > > -               u32 len =3D TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb=
)->seq;
> > > +               u32 end_seq =3D TCP_SKB_CB(skb)->end_seq;
> > >
> > >                 if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
> > > -                       len--;
> > > -               data_was_unread +=3D len;
> > > +                       end_seq--;
> > > +               if (after(end_seq, tcp_sk(sk)->copied_seq))
> > > +                       data_was_unread =3D true;
> > >                 __kfree_skb(skb);
> > >         }
> > >
> > > --
> > > 2.51.0.338.gd7d06c2dae-goog
> > >
> > >

