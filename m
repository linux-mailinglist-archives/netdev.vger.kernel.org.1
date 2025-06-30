Return-Path: <netdev+bounces-202654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18815AEE7E7
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 22:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CAA1785FE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCDF1DB125;
	Mon, 30 Jun 2025 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wmlw2H9K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC398C0B
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751313797; cv=none; b=dGHIMRr8Ilk+ke9IJh6Mh4bLEVx2Ztr9jmMDvqeFUbdnaTFItLtZgVUMTM3Hjt2yqSlsjuQPTx0FszP31bFLu60p+6ph+z2UQGW3j9qKUszEgrFM8hZQaiozdkOLGys2jEGo2P2ZcM4/gGSVhA376ItStZN5sAhWt1r23/is814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751313797; c=relaxed/simple;
	bh=tc2/CY30+WQ0GQaPSkxHMOOSP7nL34U4xOYcQqcJLKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbuX91rM6OT7qSs/H4KTsIJJwrkROkqz2GdMLyT6hW0kzIyeFuNDL3Z7WWOKua0TDleBFe1TggmxB+AKcol+ZjDZuCq0fLMA2eeQwDWFloGwZzLYBEW+nPNMJQFeGVujp246PW48NR/WNBwRyuG+7DNK2mAqPCVHrs8lHq2OyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wmlw2H9K; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234c5b57557so23170775ad.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751313795; x=1751918595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eqa+cWKwP/5ITYlS+q2fI743OuEkJnUTonzPltQGs2Y=;
        b=wmlw2H9KMK384nuHGpcNSqWvm644zD0V9d1nqBzmw55ISzg3LEQPNTQDZ9uXq35K2j
         /YiWwtp4GX200shb80Dy4anbUQcaMjhD+eSljrzwvxFHfhB9ilPlOtsGUe95fFkvtH/U
         SPgfNnn5aGAYGTrLrQVVoTzNVO14efv96zSv/kZ690FaL/Aqtpl+i5cCOhrzmifiZ8rR
         gpmH4rnZagOkl6CkLDJ2uVIR6DC7wMP0EWRzhA+/ViEx7edwe01vcDi8ZqkL1rCD9gLf
         KqLK1gF1lTgBSE6UlMapF0IrPlNCe/R+iK7tfu1EOq3plGUygLxa7OJ56mumQBCa+GeZ
         6rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751313795; x=1751918595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eqa+cWKwP/5ITYlS+q2fI743OuEkJnUTonzPltQGs2Y=;
        b=U5uitXa/4VNtnHaF5CPoojupU1iuOFzQvBYq6JZL2jy6iYqPD1OSH0gF2CodjiEU9B
         a1cSLLvzNqqO9rqCuR6JQ5c5VMLPGBO9AM0r5nwkaRgyXtEdSxDlbqQ5J5lo1jRW3H8x
         f0U+tTIbNp5qeOWgK7CSjt/FyjD9ohOHFXC2x96/OGAV24ZdfU28BK/l5eT4QEmS8K0R
         xYXfNop6p2xoSV1+/uvcNnvA92WSHH7kHbwuP33FW1qeQonY9eaG3j2ezewBgvRV1aEH
         RbgPJeJNUX4HxCcZyS9sUTLIV8XKXL1aAX3Mx4Hd0Pdte7TFDYfMNP9L8sNJADz1eClH
         Q7UA==
X-Forwarded-Encrypted: i=1; AJvYcCVRmm4AE/YleU6lyq7s16zvS7y9pvd2ThGMkLfIHk3rZfQZIP8zflRdyAy63DmnVuJZeypDnlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBI3CmX/f1uXR/JDYBaFmTz035eAiEP1J0ufl//zt+GoOhIBP
	FtiBnIzAxu76WoCNtm3aLOIwTz8J00BFjRk4TxPSLdHsR6nun1e1uKx532SbU1rrnx0MDEJmEnA
	rvPOHSVr8uwR+3TJYf3If0jGBk8hLkwwP5IHfGrCFk8wESIMQI/3mJFpSl6w=
X-Gm-Gg: ASbGncvVo1wiKnMbxJeS6BnybFyz630f8f4+UPnBj3v+EJMThX7QDMyuPHi8/YEoVFy
	t0HYq+ygyGYahVA9RMD9UVBo7U7rRWbM07hIQR7DPkbh4IHWfvX6WK2u9dnmrRYcYlAPieMbkyD
	QU9OchwAytWSBSzMAyMh9KZNYfpFBUj9NgYTO5DPeaVbSDC8XClY4uXvWEteO7mdCgI2to0mMNU
	w==
X-Google-Smtp-Source: AGHT+IF6iVcyvQjj2ld6N8UoG4ykSX9aDn1bYdC40Iledyddo74UK6tAqLO/YIb80svJEBjHYnqen4lxC/AUpi7EOf8=
X-Received: by 2002:a17:902:e84a:b0:234:8f5d:e3a4 with SMTP id
 d9443c01a7336-23ac3817878mr246272035ad.2.1751313794880; Mon, 30 Jun 2025
 13:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com> <20250629214449.14462-5-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250629214449.14462-5-aleksandr.mikhalitsyn@canonical.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 30 Jun 2025 13:03:03 -0700
X-Gm-Features: Ac12FXw0qkm9zmzcyDd_siUWWPQolY0UkEUyAzMbFXyy0LUDcdpbCwLpUNcaFzM
Message-ID: <CAAVpQUD0_HcYQ-DBSFSgjdoQLAS2bjXkLhPfYpH8z+Rt17U_sQ@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next 4/6] af_unix: stash pidfs dentry when needed
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 2:45=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> We need to ensure that pidfs dentry is allocated when we meet any
> struct pid for the first time. This will allows us to open pidfd
> even after the task it corresponds to is reaped.
>
> Basically, we need to identify all places where we fill skb/scm_cookie
> with struct pid reference for the first time and call pidfs_register_pid(=
).
>
> Tricky thing here is that we have a few places where this happends
> depending on what userspace is doing:
> - [__scm_replace_pid()] explicitly sending an SCM_CREDENTIALS message
>                         and specified pid in a numeric format
> - [unix_maybe_add_creds()] enabled SO_PASSCRED/SO_PASSPIDFD but
>                            didn't send SCM_CREDENTIALS explicitly
> - [scm_send()] force_creds is true. Netlink case.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
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
>  include/net/scm.h  | 35 ++++++++++++++++++++++++++++++-----
>  net/unix/af_unix.c | 36 +++++++++++++++++++++++++++++++++---
>  2 files changed, 63 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 856eb3a380f6..d1ae0704f230 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -8,6 +8,7 @@
>  #include <linux/file.h>
>  #include <linux/security.h>
>  #include <linux/pid.h>
> +#include <linux/pidfs.h>
>  #include <linux/nsproxy.h>
>  #include <linux/sched/signal.h>
>  #include <net/compat.h>
> @@ -66,19 +67,37 @@ static __inline__ void unix_get_peersec_dgram(struct =
socket *sock, struct scm_co
>  { }
>  #endif /* CONFIG_SECURITY_NETWORK */
>
> -static __inline__ void scm_set_cred(struct scm_cookie *scm,
> -                                   struct pid *pid, kuid_t uid, kgid_t g=
id)
> +static __inline__ int __scm_set_cred(struct scm_cookie *scm,
> +                                    struct pid *pid, bool pidfs_register=
,
> +                                    kuid_t uid, kgid_t gid)

scm_set_cred() is only called from 3 places, and I think you can simply
pass pidfd_register =3D=3D false from one of the places.

while at it, please replace s/__inline__/inline/

>  {
> -       scm->pid  =3D get_pid(pid);
> +       if (pidfs_register) {
> +               int err;
> +
> +               err =3D pidfs_register_pid(pid);

nit: int err =3D pidfs_...();

> +               if (err)
> +                       return err;
> +       }
> +
> +       scm->pid =3D get_pid(pid);
> +
>         scm->creds.pid =3D pid_vnr(pid);
>         scm->creds.uid =3D uid;
>         scm->creds.gid =3D gid;
> +       return 0;
> +}
> +
> +static __inline__ void scm_set_cred(struct scm_cookie *scm,
> +                                   struct pid *pid, kuid_t uid, kgid_t g=
id)
> +{
> +       /* __scm_set_cred() can't fail when pidfs_register =3D=3D false *=
/
> +       (void) __scm_set_cred(scm, pid, false, uid, gid);

I think this (void) style is unnecessary for recent compilers.

>  }
>
>  static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
>  {
>         put_pid(scm->pid);
> -       scm->pid  =3D NULL;
> +       scm->pid =3D NULL;
>  }
>
>  static __inline__ void scm_destroy(struct scm_cookie *scm)
> @@ -90,9 +109,15 @@ static __inline__ void scm_destroy(struct scm_cookie =
*scm)
>
>  static __inline__ int __scm_replace_pid(struct scm_cookie *scm, struct p=
id *pid)
>  {
> +       int err;
> +
>         /* drop all previous references */
>         scm_destroy_cred(scm);
>
> +       err =3D pidfs_register_pid(pid);
> +       if (err)
> +               return err;
> +
>         scm->pid =3D get_pid(pid);
>         scm->creds.pid =3D pid_vnr(pid);
>         return 0;
> @@ -105,7 +130,7 @@ static __inline__ int scm_send(struct socket *sock, s=
truct msghdr *msg,
>         scm->creds.uid =3D INVALID_UID;
>         scm->creds.gid =3D INVALID_GID;
>         if (forcecreds)
> -               scm_set_cred(scm, task_tgid(current), current_uid(), curr=
ent_gid());
> +               __scm_set_cred(scm, task_tgid(current), true, current_uid=
(), current_gid());
>         unix_get_peersec_dgram(sock, scm);
>         if (msg->msg_controllen <=3D 0)
>                 return 0;
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 5efe6e44abdf..1f4a5fe8a1f7 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1924,12 +1924,34 @@ static void unix_peek_fds(struct scm_cookie *scm,=
 struct sk_buff *skb)
>         scm->fp =3D scm_fp_dup(UNIXCB(skb).fp);
>  }
>
> +static int __skb_set_pid(struct sk_buff *skb, struct pid *pid, bool pidf=
s_register)

unix_set_pid_to_skb ?

> +{
> +       if (pidfs_register) {
> +               int err;
> +
> +               err =3D pidfs_register_pid(pid);
> +               if (err)
> +                       return err;
> +       }
> +
> +       UNIXCB(skb).pid =3D get_pid(pid);
> +       return 0;
> +}
> +
>  static void unix_destruct_scm(struct sk_buff *skb)
>  {
>         struct scm_cookie scm;
>
>         memset(&scm, 0, sizeof(scm));
> -       scm.pid  =3D UNIXCB(skb).pid;
> +
> +       /* Pass ownership of struct pid from skb to scm cookie.
> +        *
> +        * We rely on scm_destroy() -> scm_destroy_cred() to properly
> +        * release everything.
> +        */
> +       scm.pid =3D UNIXCB(skb).pid;
> +       UNIXCB(skb).pid =3D NULL;

The skb is under destruction and we no longer touch it, so
this chunk is not needed.


> +
>         if (UNIXCB(skb).fp)
>                 unix_detach_fds(&scm, skb);
>
> @@ -1943,7 +1965,10 @@ static int unix_scm_to_skb(struct scm_cookie *scm,=
 struct sk_buff *skb, bool sen
>  {
>         int err =3D 0;
>
> -       UNIXCB(skb).pid =3D get_pid(scm->pid);
> +       err =3D __skb_set_pid(skb, scm->pid, false);
> +       if (unlikely(err))
> +               return err;
> +
>         UNIXCB(skb).uid =3D scm->creds.uid;
>         UNIXCB(skb).gid =3D scm->creds.gid;
>         UNIXCB(skb).fp =3D NULL;
> @@ -1976,7 +2001,12 @@ static int unix_maybe_add_creds(struct sk_buff *sk=
b, const struct sock *sk,
>                 return 0;
>
>         if (unix_may_passcred(sk) || unix_may_passcred(other)) {
> -               UNIXCB(skb).pid =3D get_pid(task_tgid(current));
> +               int err;
> +
> +               err =3D __skb_set_pid(skb, task_tgid(current), true);
> +               if (unlikely(err))
> +                       return err;
> +
>                 current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
>         }
>
> --
> 2.43.0
>

