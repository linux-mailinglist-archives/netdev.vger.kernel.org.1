Return-Path: <netdev+bounces-203597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 981CCAF67CA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741B73A7523
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC3F1E9B3D;
	Thu,  3 Jul 2025 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPv/EHZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680141D5CE5
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508765; cv=none; b=dhf0t3P7fcMN0tcLeYob9KQWWGuvfYrKmAfsN9fxEXnl/Hbqoyb79SY55e6ZMfuiN4vnKLPREWbnJgquw50pYYJqFrAp5CHS5gGDQ/VIfJSo/hWXeLygdCLF+wXL40sri4Ua0s2YKhpiK5OyeJQ0wxQEr7oDtpkBWiazzwXgI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508765; c=relaxed/simple;
	bh=lBg+2rfNaGnjS0hbzaYfp1CeUFtw5//muHuGCu2lNkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIVRpWCVuz/D7dn4o+sVS+J5KLklpFRYGywp88FNVMcTEDft4nHNtGesWe/f9hVVYUVY54hpgTWrAxnlUPd1/lBQKSF16B303ADj9IFBe7yMQiSVOJ1V2+mo8CHCifvYOMMldGWg+KtdJ2uIsA+Ys5MVLuqfprqsmPTF0jLH5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPv/EHZ6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso6395884a91.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 19:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751508764; x=1752113564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NO73RfR6Y3gr9CLEXQ/SnY7i03Uc20liAAl3u3Q+Dk=;
        b=DPv/EHZ656vNnmW1Bkn/Ws5mrldtenzkVYMOUvdDCDORnuZ/+tip6rJGDvLfgQ0A72
         8YRh51X+q9dPjOzWf1QDH2CmPEEnEtNOTntdYfhAacoCjYuN9s3/62iXKq32Jp6gPRiB
         hN781T7XX+7YOKsVj8pSPBQaUv4Qalsmh+mRbixMiYq9hubT0zKExpTlTb8pGOadVhDJ
         GFJfvu6uM+/CJUNYHkTt1k10IElrLsQFQi8TwKG2+mwupemHr4sD+rTW2Uz3eqxxbdJ+
         JItysBqbZ1Z1W6fEYwnErQmsnLYF1z/KWSZdnmBh4+rystKqd7fOykGL2ouV1XEDQ1WJ
         PsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751508764; x=1752113564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NO73RfR6Y3gr9CLEXQ/SnY7i03Uc20liAAl3u3Q+Dk=;
        b=W6gIoFx7DpK/0EUVBZkz4YA/CmEXx5A845t2LbGVuVHqCe50cN1UhZDt6hSAQQJzKS
         4jnFikjxFvn7HaClOCqy+RyByOiwtQs5/pp7dhaQoh9e0JvgaQN5CoSf0I85vpU+Iu+9
         vRdUsGX557n2fuUSeNKtOaGvL9D6k6+NwtVqAk+e/849xS9aMkuWCsPX0JztFvBOJ+oF
         3gIn6O/eZyMR9ou7fsflRB8XFzhH/Vs4z4hF0YnC+ExoHDzDz0YKls5jkgyp/fNEikPc
         jM5qUNYirZuFUZ74wYClMWLDE6npaFOwBJeNDRh2QoTvNeYYyVna31dwPPeJJGQSrfje
         dx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV53WNtvui8BvrRT5QnST7qItTRiNQMsKaZfLBvf55nrrsIpIno6rrYFiiS8+xdVR+wctnFoFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIHSSeJVBAu/m9vmAACtOT4TAI7o7M3gO2aY77NNFW66zEMdQ
	W3WHL7in+AhpPZZ6H4toGbZK2FzN+eFa4MqsLYqrKuLrEPUbqaIGFYwO0FtCf+jLqNamd78IPg0
	QdMUsHz7xf2UeewKw1adZmiLZjBsWielKJXaGyJ4C
X-Gm-Gg: ASbGncu0tgUe5kKlTGbH5vWKAwGz7WsNfuVlCouQXNvQMSF4wJ6WGhyG6MpaQtCuljH
	tlqBSjGkrUAyfa5ZdD8IvvfadSKsgQXUujMmk6MZ44lVhUlfktolZrq+G/vuv8oBe8ta9IPR/bs
	J8I92O8YD2y/ILMRg2aGLwfJEpIoLf1bFgMYNjitSNXO1/lQup8TYTzin514VGlYNn578fgdinm
	G8lRb6yeTV2OcQ=
X-Google-Smtp-Source: AGHT+IEfk5Evrrn1hWvkFobuV0tS0uqK20Nkb4L5h50gd31HYQ14M5AinIcG/AgD9Ggo+cNn9dNRqqkwceDxacax1UY=
X-Received: by 2002:a17:90b:53ce:b0:311:c5d9:2c7c with SMTP id
 98e67ed59e1d1-31a9df94759mr1241067a91.23.1751508763578; Wed, 02 Jul 2025
 19:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com> <20250701083922.97928-7-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250701083922.97928-7-aleksandr.mikhalitsyn@canonical.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Jul 2025 19:12:31 -0700
X-Gm-Features: Ac12FXxZ3hrF9DXpmcOwKNJ_VHMmv3IGoCk3Oxc0vEHSANkYmmlrMbUy8AXWM1A
Message-ID: <CAAVpQUAXwWE6ssHYwaA4Wi4U0j_VOQ0vPD6oTAEhEV3q92fPnQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] af_unix: introduce and use
 __scm_replace_pid() helper
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Lennart Poettering <mzxreary@0pointer.de>, 
	Luca Boccassi <bluca@debian.org>, David Rheinsberg <david@readahead.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:41=E2=80=AFAM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Existing logic in __scm_send() related to filling an struct scm_cookie
> with a proper struct pid reference is already pretty tricky. Let's
> simplify it a bit by introducing a new helper. This helper will be
> extended in one of the next patches.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
> v2:
>         - don't do get_pid() in __scm_replace_pid() [ as Kuniyuki suggest=
ed ]
>         - move __scm_replace_pid() from scm.h to scm.c [ as Kuniyuki sugg=
ested ]
> ---
>  net/core/scm.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 0225bd94170f..68441c024dd8 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -145,6 +145,16 @@ void __scm_destroy(struct scm_cookie *scm)
>  }
>  EXPORT_SYMBOL(__scm_destroy);
>
> +static inline int __scm_replace_pid(struct scm_cookie *scm, struct pid *=
pid)

As you will need v3, I'd remove "__" because there's no-prefix-version.


> +{
> +       /* drop all previous references */
> +       scm_destroy_cred(scm);
> +
> +       scm->pid =3D pid;
> +       scm->creds.pid =3D pid_vnr(pid);
> +       return 0;
> +}
> +
>  int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cooki=
e *p)
>  {
>         const struct proto_ops *ops =3D READ_ONCE(sock->ops);
> @@ -189,15 +199,21 @@ int __scm_send(struct socket *sock, struct msghdr *=
msg, struct scm_cookie *p)
>                         if (err)
>                                 goto error;
>
> -                       p->creds.pid =3D creds.pid;
>                         if (!p->pid || pid_vnr(p->pid) !=3D creds.pid) {
>                                 struct pid *pid;
>                                 err =3D -ESRCH;
>                                 pid =3D find_get_pid(creds.pid);
>                                 if (!pid)
>                                         goto error;
> -                               put_pid(p->pid);
> -                               p->pid =3D pid;
> +
> +                               /* pass a struct pid reference from
> +                                * find_get_pid() to __scm_replace_pid().
> +                                */
> +                               err =3D __scm_replace_pid(p, pid);
> +                               if (err) {
> +                                       put_pid(pid);
> +                                       goto error;
> +                               }
>                         }
>
>                         err =3D -EINVAL;
> --
> 2.43.0
>

