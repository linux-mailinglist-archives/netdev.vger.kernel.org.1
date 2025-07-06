Return-Path: <netdev+bounces-204441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0911AFA771
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 21:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E3A1898A44
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 19:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927971F463F;
	Sun,  6 Jul 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkK5jTfk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1236617A309
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751829679; cv=none; b=OmOVKYpSZ4lVYox3mEuFeSYNiLXDaBCS6ttbFAbogc9wPqoh7s8/t65zMmdsLtzYNXKMgW+tvZmm2Ug6EGXcbD3rf6yQlJc5lsfD2NiFbjSQCrciSAC7l+oOmsmAuk7/Vt3fAiGfTvG6AOXvEuxBguyNmHKf0acJ14ONeRpxjyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751829679; c=relaxed/simple;
	bh=0OKj2CuAxo5PE3lgiAI0emXC0RhoMOS67STyWIJ5Yu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apcHcATvN5Ize8cUrWbEDqorR0M7ujXJO+TmSz75wj/c1pLcfbOmILx30kibx8M2CPSb5eXglTMg/0jlxz/w7GLfSUD8SLncrGYDEbbnBcudz8zTOxQndgED+I8FUJWtn2Vc6hBExkaan6CB3hBaKXK1aKeR4RT6mk8aZCBTk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkK5jTfk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313a001d781so1850705a91.3
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751829677; x=1752434477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VGRc7y2RCJf8zHE4Lxpl+ymRedBL4YGuUrOObcVcUY=;
        b=JkK5jTfkYA8mpeaNB+eK6+mgf7TCOEYgr545imZs4gNUHsEAYCDBcN5fnYgMn35t6Y
         x/OBIbiFfPvMUZ/O5ZVAAjlXVCkZC02II6FJShluDTQTICg66Xv0OzwmKUEtIiDscG4x
         BmtpsKFXCZ5LzMjlJSGVZK2YC1ozX5549lb66JW8+q0DQIaREZPLA+EC7mpw+xR5DgFg
         +M5qqYM8EJFLMuGHrnt71drqEl5sFYFcjRe07czCpKAntQzd6vMMl6FgwYgKD6Gln+1l
         pmS12jRf8CpY3BsqbgwVHURMyfTFQMKzIYCN6sfQFa/eSBQ9+bhXjcDDd4lSU+gN/LaK
         EIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751829677; x=1752434477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VGRc7y2RCJf8zHE4Lxpl+ymRedBL4YGuUrOObcVcUY=;
        b=TIcL2mEAFy6ULmK91TbpmXr/XBbZa737L9Ld8OBeIbYSW0COTRf6BmXHcLBNsqDFjT
         CCGM7Zn5F1FtPs01NopKsD8VXU1Kn1kbmPa/qAKrU9VeftxmOS0jxfSBc1jtrfoi5IN3
         VrPulW1pE5MrPlEWx3dl8EerSa+G3TfVkGwfsXqi6HSkdyWS9ZW46M75SHhwv/0+5kPq
         vbH3xsjrz4DSklmLSkKooCqr0fDjz/8FF63cGVdnKMID/zaSpfCyeqq3XKMuV7UeIbVi
         kMj0xLdMssS54rAxoSeiGITZFnN3/F7p7LpY7TSfXa6yjjN24gI8q2xhFYkb3s+EpvfY
         6ywg==
X-Forwarded-Encrypted: i=1; AJvYcCW7ndkO7tu0l6E30eZ34VhCDSTcyikLlFn+90R2C9i/JDt22bYvP+1RZcsBiCzwyqQsTaG6Is0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7grluXzyoLKsYYP2F6ztJmoTPMAtfLnzqEYqL7dKGZzySzIw
	iRtZWoJDfuLcPSmGasFfJELdCXtCAXnTwDfxZ3X8f7CO1q3gk8e52zBF5vLp7xra+6ZYK0ScLL/
	8jEWv6gpfh72PwpVGOL5ZnOAAyBxDtlGp8lo8UjWH
X-Gm-Gg: ASbGnct3XqEFedndQTEKFhB2Xi00ZFq5Oud30XkoCPRki08dmcKdeNBX7Eo+Zf+ZUaS
	22o6YG+HpMFdhJUzJeRzkBEcrdp3HbmXQgHb/aitCLoITA2+3CAhmwkAoVm6466pGUwvCbT//kl
	IjIuH7JWdkmG7mp7HYMrzrBU6ohXAemhL+viNr20iUD6gYBusPzla71N9dImFjNG8Ve5qOjSgal
	0VB
X-Google-Smtp-Source: AGHT+IGLEi8Ql17Lm/5wwAMceK5HwCFYMkPYSR5SWZdp+dy3YWrrM4bgmWNMiMRZzMaCav1yyeQavdzIOlSrpN4wU+E=
X-Received: by 2002:a17:90a:c2cb:b0:312:ec:412f with SMTP id
 98e67ed59e1d1-31aac44cc39mr16702693a91.14.1751829677204; Sun, 06 Jul 2025
 12:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702223606.1054680-1-kuniyu@google.com> <20250702223606.1054680-7-kuniyu@google.com>
 <686a81f1ec754_3aa65429440@willemb.c.googlers.com.notmuch>
In-Reply-To: <686a81f1ec754_3aa65429440@willemb.c.googlers.com.notmuch>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 6 Jul 2025 12:21:05 -0700
X-Gm-Features: Ac12FXzYg6AUW5KRd7_n0C_sTyOx5WPYNW9r59VWQkqtj4AqOrJ2jQCa7Q1eXcU
Message-ID: <CAAVpQUD1Exoz6iY-Bzst5EWD6Oh0z_adQ_R4QdUjad+WykWfiA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 6/7] af_unix: Introduce SO_INQ.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 7:02=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Kuniyuki Iwashima wrote:
> > We have an application that uses almost the same code for TCP and
> > AF_UNIX (SOCK_STREAM).
> >
> > TCP can use TCP_INQ, but AF_UNIX doesn't have it and requires an
> > extra syscall, ioctl(SIOCINQ) or getsockopt(SO_MEMINFO) as an
> > alternative.
> >
> > Let's introduce the generic version of TCP_INQ.
> >
> > If SO_INQ is enabled, recvmsg() will put a cmsg of SCM_INQ that
> > contains the exact value of ioctl(SIOCINQ).  The cmsg is also
> > included when msg->msg_get_inq is non-zero to make sockets
> > io_uring-friendly.
> >
> > Note that SOCK_CUSTOM_SOCKOPT is flagged only for SOCK_STREAM to
> > override setsockopt() for SOL_SOCKET.
> >
> > By having the flag in struct unix_sock, instead of struct sock, we
> > can later add SO_INQ support for TCP and reuse tcp_sk(sk)->recvmsg_inq.
> >
> > Note also that supporting custom getsockopt() for SOL_SOCKET will need
> > preparation for other SOCK_CUSTOM_SOCKOPT users (UDP, vsock, MPTCP).
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> > +static int unix_setsockopt(struct socket *sock, int level, int optname=
,
> > +                        sockptr_t optval, unsigned int optlen)
> > +{
> > +     struct unix_sock *u =3D unix_sk(sock->sk);
> > +     struct sock *sk =3D sock->sk;
> > +     int val;
> > +
> > +     if (level !=3D SOL_SOCKET)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (!unix_custom_sockopt(optname))
> > +             return sock_setsockopt(sock, level, optname, optval, optl=
en);
> > +
> > +     if (optlen !=3D sizeof(int))
> > +             return -EINVAL;
> > +
> > +     if (copy_from_sockptr(&val, optval, sizeof(val)))
> > +             return -EFAULT;
> > +
> > +     switch (optname) {
> > +     case SO_INQ:
> > +             if (sk->sk_type !=3D SOCK_STREAM)
> > +                     return -EINVAL;
>
> Sanity check, but technically not needed as SOCK_CUSTOM_SOCKOPT is
> only set for SOCK_STREAM?

Yes, I planned to move other AF_UNIX specific options and reuse
unix_setsockopt() for DGRAM and SEQPACKET.


>
> > +
> > +             if (val > 1 || val < 0)
> > +                     return -EINVAL;
> > +
> > +             WRITE_ONCE(u->recvmsg_inq, val);
> > +             break;
> > +     default:
> > +             return -ENOPROTOOPT;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
>

