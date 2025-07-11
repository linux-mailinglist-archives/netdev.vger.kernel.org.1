Return-Path: <netdev+bounces-206233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EE0B02413
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 20:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2046A44C00
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 18:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E6E1D618C;
	Fri, 11 Jul 2025 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjLj5C+6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F613D8B1
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259705; cv=none; b=bzCJTlgoKEgdpBQ3Xft0pfmW1BMMXCCmEyJuf6c6YefAjuC0PgUJTfUcwHCx6JG7pl5IQrLjo59YlU/1T8KVJ0W+7kr5xC/Y4wQMIivUU/crtLszGHjL+7tx6FFO0j+pgpGKJ5jcihzYkLTOn8alJ9Lzxbo7DdFYCzitreBd+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259705; c=relaxed/simple;
	bh=r37EzJre/F+UARjxLexlkyRLA39J845PhD7ndTKy0yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUlqvnusrNWW4do+r9AchnaVWn+aXwg3WXg0CmXxzCyRnHi/kfOT02Ul6BOyPgWbIBHWHcsmjti1xmBFaUtOwx2zs29nrqBw8ADspytuERN9WW/VQ6XFNWh8rwPhzkWsnO/RxEE2YXGgiRQzwg0kRzMRA7+SUwAg4G+LN2V0JHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjLj5C+6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235f9ea8d08so22994885ad.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752259703; x=1752864503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du46U7U/k4388ixVUFT5bGkMKaJOkdKF1Fe07pgVSQA=;
        b=pjLj5C+66L8Sh36wVFkMPOaTKZm4gZ5BO7GbuM0H4XmtXa6Cf1duc1aUVi8j1IzNfy
         OIu7D+Cyb1K8czcCar37oTTwkIWOc5Ihlu3k4Zon6neaKvcHjnqLzmwXgf6s9TaCFsX6
         I8QQvqbjifEiu1mVc6q81R67qlndB4axPeB01OdBT1pR2bIg+ucfEPQJI0hnGb39WtcJ
         0/WVxT/DwdpvGOD/OA87hb5of0fEaJXfmsrcweP6WedyuOu+tp8leLwyoh9a5crGbiOD
         G/IScNPgGJBhkj2Fzuvq4PiIm1QDIrPZy4FokEQ2ve5kJu89QVE1yhVxOr5KXLU+xOvn
         QS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259703; x=1752864503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du46U7U/k4388ixVUFT5bGkMKaJOkdKF1Fe07pgVSQA=;
        b=SIFb8rnqzCJGRXqDDqxl6KJbwD5Qzr8PlRJYw83VFR4frtf8x8g/NHpE82Pm07xgRb
         aOdWSiTfAi1THgNZ5vDNmvZCTzBBoYAb6NhXjF74+AFhguv9xIS0wofHg9i4YhpnrrrF
         uv+suiDMadf+hAQl0HDgtFLmyNwtoh+1vthC9F16WkZ5r1f71BOYZJ9Bwr4usz+F2mQl
         JcftWSKHfTJ0O4kVAiOEbH+xxLsYudgckllkXZHCb2p9rHrkqx20FrLKXLf/rKnlX5Mu
         MA9xVF3+wdMnT4t4jwGzgmFxOCVVYQQjX4SJbXQ2EnL/PHdM13EdnjRSeGqFhNZVZqSB
         Z7bg==
X-Forwarded-Encrypted: i=1; AJvYcCVzUQmbaACoMN/b4yQJ4sZLwC2cUXSF1kRr9i24+52ZgiNCxTGJOoL5Cm9GWxW3vkUj0Sq770U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwlQsjZiTQ5hEHl0GcV5Ug6TbGlDYkOW++P4JkbO9ZNpPu/Dq
	DSDdWEZa6Z/xiT8INJ52r0v+FzeDKm6l4vb1Dqgs3COFGek6Az1pz/CCplhAeZYAAC+dw3sEs54
	vrGL9FB+teAtWJrVqtki27Bhi6BGGestggF6YQefr
X-Gm-Gg: ASbGncuW3ciWrz9qBs0kbZ9VblsizDMwMANM+ynv22m9Y3IRPWqjbfg7nkAt+20b73o
	UtCiUAX7WoeUjWvWGCPajuX4BG/I38nYk25/i+rHk0DCNMFl5LfS1LzMkf9rbjtS7z+jhF7lDpD
	j2yFifm9mTEfB//3ucGKKIdblZh4njqzFIYms2RjZwhYjYSMFU47uS9ug2ZElX6tOHiwI3eVkQ2
	QKXsTjYGSNAk6TgVhvWCdrpxlhaukaSVnIpsO3Z
X-Google-Smtp-Source: AGHT+IGqiD2lub9DPwk6ogX29lyJVqz9TNz4jwzdJMUWMUHiYsVaFpYKiWsObxgOL/LwPbT+zDk71Xu/zaEGPfNwdkQ=
X-Received: by 2002:a17:902:fc8e:b0:234:d679:72e3 with SMTP id
 d9443c01a7336-23dede876aemr53488455ad.42.1752259702821; Fri, 11 Jul 2025
 11:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
 <20250709-sockmap-splice-v3-1-b23f345a67fc@datadoghq.com> <20250711172711.qe2tgvwckswzgedh@gmail.com>
In-Reply-To: <20250711172711.qe2tgvwckswzgedh@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 11 Jul 2025 11:48:11 -0700
X-Gm-Features: Ac12FXxCwXBZVOhNYnh0NX65W2Q8QawPjHf55ooW4JsnpDcP11FGyyKXDxfTK8M
Message-ID: <CAAVpQUBjwcpDYAafhoVA9jch5M0WVu3eUudnr3w5S=bjgDaXbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] net: Add splice_read to prot
To: John Fastabend <john.fastabend@gmail.com>
Cc: vincent.whitchurch@datadoghq.comy, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 10:27=E2=80=AFAM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> On 2025-07-09 14:47:57, Vincent Whitchurch via B4 Relay wrote:
> > From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> >
> > The TCP BPF code will need to override splice_read(), so add it to prot=
.
> >
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> > ---
> >  include/net/inet_common.h |  3 +++
> >  include/net/sock.h        |  3 +++
> >  net/ipv4/af_inet.c        | 13 ++++++++++++-
> >  net/ipv4/tcp_ipv4.c       |  1 +
> >  net/ipv6/af_inet6.c       |  2 +-
> >  net/ipv6/tcp_ipv6.c       |  1 +
> >  6 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/inet_common.h b/include/net/inet_common.h
> > index c17a6585d0b0..2a6480d0d575 100644
> > --- a/include/net/inet_common.h
> > +++ b/include/net/inet_common.h
> > @@ -35,6 +35,9 @@ void __inet_accept(struct socket *sock, struct socket=
 *newsock,
> >                  struct sock *newsk);
> >  int inet_send_prepare(struct sock *sk);
> >  int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)=
;
> > +ssize_t inet_splice_read(struct socket *sk, loff_t *ppos,
> > +                      struct pipe_inode_info *pipe, size_t len,
> > +                      unsigned int flags);
> >  void inet_splice_eof(struct socket *sock);
> >  int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
> >                int flags);
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 4c37015b7cf7..4bdebcbcca38 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1280,6 +1280,9 @@ struct proto {
> >                                          size_t len);
> >       int                     (*recvmsg)(struct sock *sk, struct msghdr=
 *msg,
> >                                          size_t len, int flags, int *ad=
dr_len);
> > +     ssize_t                 (*splice_read)(struct socket *sock,  loff=
_t *ppos,
> > +                                            struct pipe_inode_info *pi=
pe, size_t len,
> > +                                            unsigned int flags);
> >       void                    (*splice_eof)(struct socket *sock);
> >       int                     (*bind)(struct sock *sk,
> >                                       struct sockaddr *addr, int addr_l=
en);
> > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > index 76e38092cd8a..9c521d252f66 100644
> > --- a/net/ipv4/af_inet.c
> > +++ b/net/ipv4/af_inet.c
> > @@ -868,6 +868,17 @@ void inet_splice_eof(struct socket *sock)
> >  }
> >  EXPORT_SYMBOL_GPL(inet_splice_eof);
> >
> > +ssize_t inet_splice_read(struct socket *sock, loff_t *ppos,
> > +                      struct pipe_inode_info *pipe, size_t len,
> > +                      unsigned int flags)
> > +{
> > +     struct sock *sk =3D sock->sk;
> > +
> > +     return INDIRECT_CALL_1(sk->sk_prot->splice_read, tcp_splice_read,=
 sock,
> > +                            ppos, pipe, len, flags);
> > +}
>
> Could we do a indirect_call_2 here?  something like this?
>
>   INDIRECT_CALL_2(sk->sk_prot->splice_read, tcp_splice_read ...
>
> Otherwise the series looks reasonable to me.

What's the second candidate ?
I think we should specify the built-in one and cannot use bpf one.

