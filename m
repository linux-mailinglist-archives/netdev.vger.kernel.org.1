Return-Path: <netdev+bounces-202815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4321AEF1A1
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33474162E54
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBC923F26A;
	Tue,  1 Jul 2025 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GOII8MX7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698F15CD74
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359580; cv=none; b=KlNydgwlSBvheYnpG1BrwK9imXf3kSl8SnXoriOsLdk7cDO1yDXgbdPMAZQJKWcjQjgTY8zLqOrniR1VrFGT1OiTiM6NXApYNBJgqxWRdecqE1OhnCApCGeQ5MG7yoTHNvhJqgZrTl+cLkcjv3NTHw36Opi4VPxs9wfvJ7lPfrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359580; c=relaxed/simple;
	bh=XjhOVSl6ZeX/9qAW20Mw3SmTcJvvUzniC0v+3sHW62I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ad9hYcolaysdYUYSWDlKFXb3xI6n5Qm/iZBE0WLbT2E/+Ib80whEbOoD9WQD7gwSo5dZ0TpH5bQfx47eKROVGZz63zM3n6L7FcpSKWjCPdXnJvofTlMz8Cd87vO6Bp7fvYEJfq9AIBz/tVYFSkW59eE2CpMgoCtyfbpm3Kb4yYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GOII8MX7; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5F67C3F11B
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751359577;
	bh=3yZF0YBU8zea1BjIE7DIlZeylxXI2Bym2PIOgK7zI/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=GOII8MX7zl2L/LiCYXCFUrNrGlmCw0S81RqaH+UQ1XpX3aGcptI9Lnc7WEQM3NH9x
	 U9M7a2KN+X9Zw/Drc1mXX7kUbvCOXZWw+qUtHB43BSJqPmTrCS3kANRUvRnWMz6rgU
	 WxBngG3SLCAlJbK2ECJYYPoPgmhWwQg4nvKS3tzbSznjag0PmECj8qo8u2od7w+t8t
	 HwrB9oeoH8MuQqyQUMSjgsgeFby3FH/ExwNIk4qrVjxkzbroB6l8XptVwJG54iRN3o
	 hr935cyyJpcmwmRVnA2eqo8laYmaLl7nm921pqRuBEV+V6k+135QAZXdyzYkgVcBEJ
	 5uHtvJGFpiUMg==
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4e9ba1b473dso4515691137.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 01:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359576; x=1751964376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yZF0YBU8zea1BjIE7DIlZeylxXI2Bym2PIOgK7zI/4=;
        b=lnNTJemkHNrzxg8WcTUM5td1JxXXnO+AdzKB6K07VOvv4k+96fnijCGaHrL7xjhdKv
         q2U1PjnhwLh7DPmdJ1Ci37K894vT/mlcy8wMxlHnLzu+Qx/zbF+D+tNlaCAjYwbn5ZU6
         q6om9UIOOATP1jM0DA3zw8Ey7vajm3lZ6vg0qHVo16s082qjKlE0MdM4BUd7C09fOlCD
         XRtWAvCK/qK6r/TNpkPDJFeRNaMPcpi1dM+7tV0n8HQbmCejNRH1Fn24T83oBLwrjeWG
         3h7JHXqHTCa4t/pSAdzAFDNkV4O/P5mwlWTFegbALYzHi5fIzi2U2poWj3qJjz0nq4Uh
         FyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS5lZMFsj2vLbNxCv9B3I5VtMEkWhM+1bjiET+DANKbR03xFy42zs7Jkg+5n6K+4l+4osnuvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCahpbbzvNsWunMUjdKc6wnvOALqLjOarN7Gv5JEx80mbkWoA4
	qxCtWkn9neSOoP7ESbqTmpdT8eLPGK4iho/2m86h6vrdddL2P9Ldg/JihtjomGjkfQ5/Y16Tcai
	6M7TYxQBHr78WfNdUJT/qFexvYNGFM2ZOEalbh3FX7pJNBhQt4vSbNPoB+alox+NAM/wRxHMtOs
	v+E5ZvNOoNVTgJsRJrJKVIDFx2oXFpAqsfUS+jM6Ky8dw8ke2u
X-Gm-Gg: ASbGncumoVWqV2q22RG4OwWssf7eYJ6Yu1VQRdbu+b2tOsXpONSfnHyW//obzIXK1vA
	O5fafEsZqnoQtTdupRFj1Hc14fEjpRmoRuJMrr0Om3nne7vm2FkmP7uhmGDvYUfxXnfYLVQgfS9
	P9QJnU
X-Received: by 2002:a05:6102:688f:b0:4e7:dbd2:4605 with SMTP id ada2fe7eead31-4ee4f86445cmr9997031137.24.1751359576311;
        Tue, 01 Jul 2025 01:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9V8ciXaSmJI5TDipy6/UF9+JidVBFUeo9JMVaJfVoPueCHJ2kt2SYc0d07Q2iKJ9esvtoBNWRLiyKnA/AVCc=
X-Received: by 2002:a05:6102:688f:b0:4e7:dbd2:4605 with SMTP id
 ada2fe7eead31-4ee4f86445cmr9997022137.24.1751359575907; Tue, 01 Jul 2025
 01:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
 <20250629214449.14462-5-aleksandr.mikhalitsyn@canonical.com> <CAAVpQUD0_HcYQ-DBSFSgjdoQLAS2bjXkLhPfYpH8z+Rt17U_sQ@mail.gmail.com>
In-Reply-To: <CAAVpQUD0_HcYQ-DBSFSgjdoQLAS2bjXkLhPfYpH8z+Rt17U_sQ@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Tue, 1 Jul 2025 10:46:03 +0200
X-Gm-Features: Ac12FXwEZuOzRZgPNSo_QmJ6EjZc-NaJDt48kDde4Xlqt7W7HO8Vo8BjyAD36zY
Message-ID: <CAEivzxd3iUuM5iVCWEGweWpjhyhJ9TJHbHHeGYrL=EfPFprngw@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next 4/6] af_unix: stash pidfs dentry when needed
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:03=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Sun, Jun 29, 2025 at 2:45=E2=80=AFPM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > We need to ensure that pidfs dentry is allocated when we meet any
> > struct pid for the first time. This will allows us to open pidfd
> > even after the task it corresponds to is reaped.
> >
> > Basically, we need to identify all places where we fill skb/scm_cookie
> > with struct pid reference for the first time and call pidfs_register_pi=
d().
> >
> > Tricky thing here is that we have a few places where this happends
> > depending on what userspace is doing:
> > - [__scm_replace_pid()] explicitly sending an SCM_CREDENTIALS message
> >                         and specified pid in a numeric format
> > - [unix_maybe_add_creds()] enabled SO_PASSCRED/SO_PASSPIDFD but
> >                            didn't send SCM_CREDENTIALS explicitly
> > - [scm_send()] force_creds is true. Netlink case.
> >
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Kuniyuki Iwashima <kuniyu@google.com>
> > Cc: Lennart Poettering <mzxreary@0pointer.de>
> > Cc: Luca Boccassi <bluca@debian.org>
> > Cc: David Rheinsberg <david@readahead.eu>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  include/net/scm.h  | 35 ++++++++++++++++++++++++++++++-----
> >  net/unix/af_unix.c | 36 +++++++++++++++++++++++++++++++++---
> >  2 files changed, 63 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/net/scm.h b/include/net/scm.h
> > index 856eb3a380f6..d1ae0704f230 100644
> > --- a/include/net/scm.h
> > +++ b/include/net/scm.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/file.h>
> >  #include <linux/security.h>
> >  #include <linux/pid.h>
> > +#include <linux/pidfs.h>
> >  #include <linux/nsproxy.h>
> >  #include <linux/sched/signal.h>
> >  #include <net/compat.h>
> > @@ -66,19 +67,37 @@ static __inline__ void unix_get_peersec_dgram(struc=
t socket *sock, struct scm_co
> >  { }
> >  #endif /* CONFIG_SECURITY_NETWORK */
> >
> > -static __inline__ void scm_set_cred(struct scm_cookie *scm,
> > -                                   struct pid *pid, kuid_t uid, kgid_t=
 gid)
> > +static __inline__ int __scm_set_cred(struct scm_cookie *scm,
> > +                                    struct pid *pid, bool pidfs_regist=
er,
> > +                                    kuid_t uid, kgid_t gid)
>
> scm_set_cred() is only called from 3 places, and I think you can simply
> pass pidfd_register =3D=3D false from one of the places.

Hi Kuniyuki,

Thanks for such a fast review! ;-)

I've just sent a -v2 with all fixes you've suggested:
https://lore.kernel.org/netdev/20250701083922.97928-1-aleksandr.mikhalitsyn=
@canonical.com/#r

Kind regards,
Alex

>
> while at it, please replace s/__inline__/inline/

Have done ;)

>
> >  {
> > -       scm->pid  =3D get_pid(pid);
> > +       if (pidfs_register) {
> > +               int err;
> > +
> > +               err =3D pidfs_register_pid(pid);
>
> nit: int err =3D pidfs_...();

Fixed!

>
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       scm->pid =3D get_pid(pid);
> > +
> >         scm->creds.pid =3D pid_vnr(pid);
> >         scm->creds.uid =3D uid;
> >         scm->creds.gid =3D gid;
> > +       return 0;
> > +}
> > +
> > +static __inline__ void scm_set_cred(struct scm_cookie *scm,
> > +                                   struct pid *pid, kuid_t uid, kgid_t=
 gid)
> > +{
> > +       /* __scm_set_cred() can't fail when pidfs_register =3D=3D false=
 */
> > +       (void) __scm_set_cred(scm, pid, false, uid, gid);
>
> I think this (void) style is unnecessary for recent compilers.

+

>
> >  }
> >
> >  static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
> >  {
> >         put_pid(scm->pid);
> > -       scm->pid  =3D NULL;
> > +       scm->pid =3D NULL;
> >  }
> >
> >  static __inline__ void scm_destroy(struct scm_cookie *scm)
> > @@ -90,9 +109,15 @@ static __inline__ void scm_destroy(struct scm_cooki=
e *scm)
> >
> >  static __inline__ int __scm_replace_pid(struct scm_cookie *scm, struct=
 pid *pid)
> >  {
> > +       int err;
> > +
> >         /* drop all previous references */
> >         scm_destroy_cred(scm);
> >
> > +       err =3D pidfs_register_pid(pid);
> > +       if (err)
> > +               return err;
> > +
> >         scm->pid =3D get_pid(pid);
> >         scm->creds.pid =3D pid_vnr(pid);
> >         return 0;
> > @@ -105,7 +130,7 @@ static __inline__ int scm_send(struct socket *sock,=
 struct msghdr *msg,
> >         scm->creds.uid =3D INVALID_UID;
> >         scm->creds.gid =3D INVALID_GID;
> >         if (forcecreds)
> > -               scm_set_cred(scm, task_tgid(current), current_uid(), cu=
rrent_gid());
> > +               __scm_set_cred(scm, task_tgid(current), true, current_u=
id(), current_gid());
> >         unix_get_peersec_dgram(sock, scm);
> >         if (msg->msg_controllen <=3D 0)
> >                 return 0;
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 5efe6e44abdf..1f4a5fe8a1f7 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -1924,12 +1924,34 @@ static void unix_peek_fds(struct scm_cookie *sc=
m, struct sk_buff *skb)
> >         scm->fp =3D scm_fp_dup(UNIXCB(skb).fp);
> >  }
> >
> > +static int __skb_set_pid(struct sk_buff *skb, struct pid *pid, bool pi=
dfs_register)
>
> unix_set_pid_to_skb ?

+

>
> > +{
> > +       if (pidfs_register) {
> > +               int err;
> > +
> > +               err =3D pidfs_register_pid(pid);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       UNIXCB(skb).pid =3D get_pid(pid);
> > +       return 0;
> > +}
> > +
> >  static void unix_destruct_scm(struct sk_buff *skb)
> >  {
> >         struct scm_cookie scm;
> >
> >         memset(&scm, 0, sizeof(scm));
> > -       scm.pid  =3D UNIXCB(skb).pid;
> > +
> > +       /* Pass ownership of struct pid from skb to scm cookie.
> > +        *
> > +        * We rely on scm_destroy() -> scm_destroy_cred() to properly
> > +        * release everything.
> > +        */
> > +       scm.pid =3D UNIXCB(skb).pid;
> > +       UNIXCB(skb).pid =3D NULL;
>
> The skb is under destruction and we no longer touch it, so
> this chunk is not needed.
>

+

>
> > +
> >         if (UNIXCB(skb).fp)
> >                 unix_detach_fds(&scm, skb);
> >
> > @@ -1943,7 +1965,10 @@ static int unix_scm_to_skb(struct scm_cookie *sc=
m, struct sk_buff *skb, bool sen
> >  {
> >         int err =3D 0;
> >
> > -       UNIXCB(skb).pid =3D get_pid(scm->pid);
> > +       err =3D __skb_set_pid(skb, scm->pid, false);
> > +       if (unlikely(err))
> > +               return err;
> > +
> >         UNIXCB(skb).uid =3D scm->creds.uid;
> >         UNIXCB(skb).gid =3D scm->creds.gid;
> >         UNIXCB(skb).fp =3D NULL;
> > @@ -1976,7 +2001,12 @@ static int unix_maybe_add_creds(struct sk_buff *=
skb, const struct sock *sk,
> >                 return 0;
> >
> >         if (unix_may_passcred(sk) || unix_may_passcred(other)) {
> > -               UNIXCB(skb).pid =3D get_pid(task_tgid(current));
> > +               int err;
> > +
> > +               err =3D __skb_set_pid(skb, task_tgid(current), true);
> > +               if (unlikely(err))
> > +                       return err;
> > +
> >                 current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
> >         }
> >
> > --
> > 2.43.0
> >

