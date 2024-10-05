Return-Path: <netdev+bounces-132347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD05991510
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 09:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C5E1F2385E
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 07:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC713213E;
	Sat,  5 Oct 2024 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnmyLUAS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F634CC4
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728113105; cv=none; b=SFufHcA4rvNa2lZ3v4VI86UjfhzCxJN+HGBGlVJQh2eqEVqAAdJ1fS3uxPoCAgsjj9EKSZJnQyM6TNJmLKEckLo2zYLyS2O6zirNq14AwvahjXvX8QrjGgxaTodVPrtWzZZAyRlHzIAYqTeTjrwPk0+S5cnWDJHQFfbN28zS8Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728113105; c=relaxed/simple;
	bh=LZP3cKWhrMtVWggYSaZ5lPkhhsFQoozJYP5JsxhK/ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFIntU+NckrkAtiMRhJug2+goY6HsZ9wqTxOn0oJnHA5bGcJmByu1tGt5DOi3Mquyd9605mZyzn1a1AhyTKH+fpXo1UKaYQUCOjxjIkJ6qtSdU+iKawyE6g1ZFn2y/89vlcX+wdwdNY7DWO9BFCBP6zC6mfDCH0mSeEFoQhr5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DnmyLUAS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c718bb04a3so3600488a12.3
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728113101; x=1728717901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ikQ40FBna1IlLDCWeyjwiV3mN+L8sM+RPl/YRXKiU4=;
        b=DnmyLUASRzRM6rexYpA9uyCS0zu/1aPGh1ko27H+2ilt0HqKhxIjhUMqI2cim0vPY9
         UoJjxcykt9BT6K9EzU+29pN4blumIpn3qyKFsBQk+4qx52bYPn8rVfos0k0I8qPBz5mR
         uYRBAaDuLdUHVjin5djtoVpeLwfMyrnqCinJpXf5ACCigSb1/BQzCv8sopGwilUi25bN
         SlqqyCiYFm3VLeewM9tKXPh7WLlv7FXPeqEEe3MlUXePGrYQ5zRniqwXsALPXimiB5JK
         sRh/jeP2evnPMM1IxVuDhDa+c9C2JLCIZneLR5iUKGzOe/JbH3u01By/UDhUccBdzCqV
         Eq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728113101; x=1728717901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ikQ40FBna1IlLDCWeyjwiV3mN+L8sM+RPl/YRXKiU4=;
        b=L8Zre6fLJrlKf1gOKTWB0hSDlGAe5KlJ+DDMOWSmpM0fvsq59C3y1FpVVMamRzz0jp
         ZuUrHWIjrTqs8Vj3cPG6Wvcj3UrLW/tNgjqJYoyFafFgdxLyXYFotuqshEj7Eo/V+ASk
         4kG1SRt/sYbEpErIdqVgYkZ4uni0xhC+MLhQ1fiYlCuVVUuZXQyv3MCkT93apfQGL+Aq
         lyh+NUdOeUPEudGOPN7Xz+M0LBfLB7uBR2aCxpzaIEWaMJJ/rrw0pX84QqnSh6Axd31r
         wQZlxRmzOCUVulPmGelt72ibFLxqP5EfY8Jyx535H0A+7+edBjmjYy6/dgq+odbmyVFI
         EbjA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Ig87DGIEkF8HsrefKZQllj4wWXyBlrcI47w2LIiUlKRtOmKtlhLg0Fc+sbViaeBaEogvoFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcc6c8C2F1xGEQ7+tV2/8VdikRFOtePnOThzyDHNWvV0Yogi9L
	0zGAqm3yoWIELX1zMQFdNz7LKLyfDGfLU9d0sEn0Pdxpu91r0jbq4qeuJlZ4FT75tju+EnJD3eX
	qIQAarC5e1NhuuZq1IJCOCY7Y1rgRpO3jNrzz
X-Google-Smtp-Source: AGHT+IEQKa1JryxdMCVct2cTTMuXcaAPe8j51D5Dn7yAGDshcgihBva2hIqdYPSyOKDbek9Apj+LguKnUJFkN2NS0PE=
X-Received: by 2002:a05:6402:4486:b0:5c8:79fa:2e4f with SMTP id
 4fb4d7f45d1cf-5c8d2e9e7bdmr4262712a12.32.1728113100579; Sat, 05 Oct 2024
 00:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005045411.118720-1-danielyangkang@gmail.com>
In-Reply-To: <20241005045411.118720-1-danielyangkang@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 5 Oct 2024 09:24:48 +0200
Message-ID: <CANn89iKk8TOvzD4cAanACtD0-x2pciEoSJbk9mF97wxNzxmUCg@mail.gmail.com>
Subject: Re: [PATCH v2] resolve gtp possible deadlock warning
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 6:54=E2=80=AFAM Daniel Yang <danielyangkang@gmail.co=
m> wrote:
>
> Fixes deadlock described in this bug:
> https://syzkaller.appspot.com/bug?extid=3De953a8f3071f5c0a28fd.
> Specific crash report here:
> https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D14670e07980000.
>
> This bug is a false positive lockdep warning since gtp and smc use
> completely different socket protocols.
>
> Lockdep thinks that lock_sock() in smc will deadlock with gtp's
> lock_sock() acquisition. Adding a function that initializes lockdep
> labels for smc socks resolved the false positives in lockdep upon
> testing. Since smc uses AF_SMC and SOCKSTREAM, two labels are created to
> distinguish between proper smc socks and non smc socks incorrectly
> input into the function.
>
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
> ---
> v1->v2: Add lockdep annotations instead of changing locking order
>  net/smc/af_smc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 0316217b7..4de70bfd5 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -16,6 +16,8 @@
>   *              based on prototype from Frank Blaschka
>   */
>
> +#include "linux/lockdep_types.h"
> +#include "linux/socket.h"
>  #define KMSG_COMPONENT "smc"
>  #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
>
> @@ -2755,6 +2757,24 @@ int smc_getname(struct socket *sock, struct sockad=
dr *addr,
>         return smc->clcsock->ops->getname(smc->clcsock, addr, peer);
>  }
>
> +static struct lock_class_key smc_slock_key[2];
> +static struct lock_class_key smc_key[2];
> +
> +static inline void smc_sock_lock_init(struct sock *sk)
> +{
> +       bool is_smc =3D (sk->sk_family =3D=3D AF_SMC) && sk_is_tcp(sk);
> +
> +       sock_lock_init_class_and_name(sk,
> +                                     is_smc ?
> +                                     "smc_lock-AF_SMC_SOCKSTREAM" :
> +                                     "smc_lock-INVALID",
> +                                     &smc_slock_key[is_smc],
> +                                     is_smc ?
> +                                     "smc_sk_lock-AF_SMC_SOCKSTREAM" :
> +                                     "smc_sk_lock-INVALID",
> +                                     &smc_key[is_smc]);
> +}
> +
>  int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  {
>         struct sock *sk =3D sock->sk;
> @@ -2762,6 +2782,7 @@ int smc_sendmsg(struct socket *sock, struct msghdr =
*msg, size_t len)
>         int rc;
>
>         smc =3D smc_sk(sk);
> +       smc_sock_lock_init(sk);
>         lock_sock(sk);
>
>         /* SMC does not support connect with fastopen */
> --
> 2.39.2
>

sock_lock_init_class_and_name() is not meant to be repeatedly called,
from sendmsg()

Find a way to do this once, perhaps in smc_create_clcsk(), but I will
let SMC experts chime in.

