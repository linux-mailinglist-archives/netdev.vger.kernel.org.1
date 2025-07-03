Return-Path: <netdev+bounces-203933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C16EAF82B3
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 23:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548F83B1CDD
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 21:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3E12BE7A2;
	Thu,  3 Jul 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oa/idDJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BF7190679
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751578569; cv=none; b=sYOXzPdXOkZ9RFl7qTZ28BJ39zxQIRnOeBDGeI1J8H72dtd1ZjD3elghjxl1pc8f8lGrOxbDs0XUFkr06WMa5lx4x/4yapmKMSABDZ1FBRgUgREqwO/GjCwJ2Rhem/xC0l1IRtxdeNy+Y+pJzMfwm/fb3IUMnQZ2K9x2UKfjxk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751578569; c=relaxed/simple;
	bh=lMjmIbbrKCapHNvacndT3CYesc+OgdSuDb/BnQRGjRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amuXJrYhJl9G0PmpWSRJgteX5zwHG9DeAoq9vAtYr8uYFoM4KhJ5LQ3vPC9/3XsYOh5TcsKOxypga9yWsxcYrWTv9Z2U4FwTTIpvoZYuPmdLLvpaR5lY+h8QVsxzZbwu/rzpFM/8YB+wsSo5t5WFxPaE79/xKwiNeYWjpJbXafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oa/idDJA; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4283D3F84A
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 21:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751578558;
	bh=bWTBBR3tcfcCVwCDO6Z84tS0/UdOmqTNNcVmWEaK54c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=oa/idDJAap/AXBGXzn51KUAiKdU4FQ4oy4CVpcnO6zr/gbwxfdTE2ArsOOfGU8sWg
	 +z2F+Kqh501YFEAjG2Rxe0FxFS0aBQ+vuM5QvKuB48rZtWjm2IXYlB+deHP/YvjcJL
	 V8kPkCEnJjGu+rAt9/MY7OC5KmeRpoH/avFs/snjFM4FlxT5ool+ARD3ZbbMFfZ4Ye
	 zRRxc1hMLz54dMuUsqrDvQH4fZPh6BI0uuMErOm+FVbnd/luVfLcytJDTtqbwlOTKH
	 aLaj5Fzfi0q1N8glXQAc3xWTB0sBkAKxYPoDvOFKdSwa+O7CgsLie7Bn4e8JsQo7Jv
	 7moVbdu3SKT6w==
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4f1dbe8f605so54631137.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 14:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751578557; x=1752183357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWTBBR3tcfcCVwCDO6Z84tS0/UdOmqTNNcVmWEaK54c=;
        b=DGfFKFpjG4Skfb8oK5uxW/A6ylkBF6P+EXtN+2B40LsG8ngI47PwO4vEN6ANbFt+Ah
         1hbCLjPTEGhuJNvC0VGJY1wwdRAZZQoBccyvNKQ2mClMFWgljNDhE2cI+6hf1ANlNeNT
         gzdG2lOc6pwspM0YhSYQoLu+GihDBiMzPAchtFEXtTXtoZ71nLnFy3dLK3ToeqnsVHro
         C3DweCpOZ2zXoacx1rOehtmThCQVk0io/nuFhvHXSL9ChU1FWqdIlZVoGm6tOydRUJfN
         c4+b1o94M2Y+Ku3yD4z/z4AVdafIXmSzedJy2hGuJS45xdfNMRLA/30iFwXOBG6OQAOd
         kFdw==
X-Forwarded-Encrypted: i=1; AJvYcCXgbIUde2gUFLDdF+NZXxrEV43eM9V1MUeB+HxfQneXWKgpFCul3ErvrWa6hRyfKOgkYR1i6nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBhoi92p8saTw2MJdwJmnEWiYWiu5tmEckS3ej6DkgxFv3ZFo
	X1NU1TyMT6P3eQktaf5f0RqxJTPQzTeWy4XbiAMcNZvotn/S7Caweo7whSodE4ioDLTtuivIDxb
	BNgeVwwQOXRRyjv6i7BdMmP3+zKSBS6bbjwnoKNj2UDU3wmfY9qqaBW185Y/Fa5hoC8017/TeO4
	vyQNkhJqZVF3cu0anKj/VhgzdjFzoss3IQg14C3FjeU49BM7Pl
X-Gm-Gg: ASbGncvtuOSm5TLuEmIVCLPyfaTk5pfUvb+fLYFNJd3XkJsPraxLvNaala9e3DIX6zp
	I/rOZpHupjaS0xh+7Dn+WfNgTtMp5MTSuNn69p+xQOJPGZ5f5hdvIT2IH1wu29vVRMFf/JQa3a5
	GZvG8E
X-Received: by 2002:a05:6102:8016:b0:4e6:d995:94f9 with SMTP id ada2fe7eead31-4f2ee1ab3a4mr527034137.12.1751578557042;
        Thu, 03 Jul 2025 14:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs8JP0V1kADGywsst8bal2/wb6N1RrkMLmV2Gjw43MXO4S6TS4rzjt/nP4+sUjYqQWdRkeW6U5Q5+FItLuA88=
X-Received: by 2002:a05:6102:8016:b0:4e6:d995:94f9 with SMTP id
 ada2fe7eead31-4f2ee1ab3a4mr527022137.12.1751578556645; Thu, 03 Jul 2025
 14:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
 <20250701083922.97928-9-aleksandr.mikhalitsyn@canonical.com> <CAAVpQUDFzPBJmCeawhaHL5Twjxk8obLZW9UPH0HfD_5BYpjh_w@mail.gmail.com>
In-Reply-To: <CAAVpQUDFzPBJmCeawhaHL5Twjxk8obLZW9UPH0HfD_5BYpjh_w@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 3 Jul 2025 23:35:45 +0200
X-Gm-Features: Ac12FXyeeJVA73E3LrFMGuvn0EDeHuAYD44eCvPPXqmKAveYKS08quI8ryvRj9s
Message-ID: <CAEivzxc_CxQ5AS8KaFS9LEsHhzzyLyuEgqcp--JQJ6X6Rj-s+A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/6] af_unix: stash pidfs dentry when needed
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 3:53=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Tue, Jul 1, 2025 at 1:41=E2=80=AFAM Alexander Mikhalitsyn
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
> > v2:
> >         - renamed __skb_set_pid() -> unix_set_pid_to_skb() [ as Kuniyuk=
i suggested ]
> >         - get rid of extra helper (__scm_set_cred()) I've introduced be=
fore [ as Kuniyuki suggested ]
> >         - s/__inline__/inline/ for functions I touched [ as Kuniyuki su=
ggested ]
> >         - get rid of chunk in unix_destruct_scm() with NULLifying UNIXC=
B(skb).pid [ as Kuniyuki suggested ]
> >         - added proper error handling in scm_send() for scm_set_cred() =
return value [ found by me during rework ]
> > ---
> >  include/net/scm.h  | 32 ++++++++++++++++++++++++--------
> >  net/core/scm.c     |  6 ++++++
> >  net/unix/af_unix.c | 33 +++++++++++++++++++++++++++++----
> >  3 files changed, 59 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/net/scm.h b/include/net/scm.h
> > index 84c4707e78a5..597a40779269 100644
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
> > @@ -66,19 +67,28 @@ static __inline__ void unix_get_peersec_dgram(struc=
t socket *sock, struct scm_co
> >  { }
> >  #endif /* CONFIG_SECURITY_NETWORK */
> >
> > -static __inline__ void scm_set_cred(struct scm_cookie *scm,
> > -                                   struct pid *pid, kuid_t uid, kgid_t=
 gid)
> > +static inline int scm_set_cred(struct scm_cookie *scm,
> > +                              struct pid *pid, bool pidfs_register,
> > +                              kuid_t uid, kgid_t gid)
> >  {
> > -       scm->pid  =3D get_pid(pid);
> > +       if (pidfs_register) {
> > +               int err =3D pidfs_register_pid(pid);
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
> >  }
> >
> >  static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
> >  {
> >         put_pid(scm->pid);
> > -       scm->pid  =3D NULL;
> > +       scm->pid =3D NULL;
>
> Could you split these double-space changes to another
> patch to make review easier ?

Hi Kuniyuki,

Sure, will do!

>
>
> >  }
> >
> >  static __inline__ void scm_destroy(struct scm_cookie *scm)
> > @@ -88,14 +98,20 @@ static __inline__ void scm_destroy(struct scm_cooki=
e *scm)
> >                 __scm_destroy(scm);
> >  }
> >
> > -static __inline__ int scm_send(struct socket *sock, struct msghdr *msg=
,
> > -                              struct scm_cookie *scm, bool forcecreds)
> > +static inline int scm_send(struct socket *sock, struct msghdr *msg,
> > +                          struct scm_cookie *scm, bool forcecreds)
> >  {
> >         memset(scm, 0, sizeof(*scm));
> >         scm->creds.uid =3D INVALID_UID;
> >         scm->creds.gid =3D INVALID_GID;
> > -       if (forcecreds)
> > -               scm_set_cred(scm, task_tgid(current), current_uid(), cu=
rrent_gid());
> > +
> > +       if (forcecreds) {
> > +               int err =3D scm_set_cred(scm, task_tgid(current), true,
> > +                                      current_uid(), current_gid());
>
> Do we need to pass true here ?
>
> Given this series affects scm_pidfd_recv(), we don't need to
> touch netlink path that is not allowed to call scm_recv_unix() ?
>
> Then, all callers pass false to scm_set_cred() and
> pidfs_register_pid() there will be unnecessary.

I agree. While it is safe to call pidfd_register_pid() for the netlink
case too (and get pidfs dentry allocated),
it is not really useful. Thanks for noticing this!

>
>
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> >         unix_get_peersec_dgram(sock, scm);
> >         if (msg->msg_controllen <=3D 0)
> >                 return 0;
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index 68441c024dd8..50dfec6f8a2b 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -147,9 +147,15 @@ EXPORT_SYMBOL(__scm_destroy);
> >
> >  static inline int __scm_replace_pid(struct scm_cookie *scm, struct pid=
 *pid)
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
> >         scm->pid =3D pid;
> >         scm->creds.pid =3D pid_vnr(pid);
> >         return 0;
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index df2174d9904d..18c677683ddc 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -1924,12 +1924,27 @@ static void unix_peek_fds(struct scm_cookie *sc=
m, struct sk_buff *skb)
> >         scm->fp =3D scm_fp_dup(UNIXCB(skb).fp);
> >  }
> >
> > +static int unix_set_pid_to_skb(struct sk_buff *skb, struct pid *pid, b=
ool pidfs_register)
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
> > +       scm.pid =3D UNIXCB(skb).pid;
> > +
> >         if (UNIXCB(skb).fp)
> >                 unix_detach_fds(&scm, skb);
> >
> > @@ -1943,7 +1958,10 @@ static int unix_scm_to_skb(struct scm_cookie *sc=
m, struct sk_buff *skb, bool sen
> >  {
> >         int err =3D 0;
> >
> > -       UNIXCB(skb).pid =3D get_pid(scm->pid);
> > +       err =3D unix_set_pid_to_skb(skb, scm->pid, false);
> > +       if (unlikely(err))
>
> This does not fail too.
>
> Perhaps keep get_pid() here and move pidfs_register_pid()
> to unix_maybe_add_creds(), that will look simpler.

You are absolutely right. Thanks for pointing this out!
Actually, this was really useful when pidfs_get_pid()/pidfs_put_pid()
API was a thing [1],
because in unix_set_pid_to_skb() we would call pidfs_get_pid() *or*
pidfs_register_pid().

But now, when lifetime rules for pidfs dentries are changed we don't
have pidfs_get_pid()/pidfs_put_pid() API
and we don't need this unix_set_pid_to_skb() helper anymore. So,
basically it's post-vfs-rebase leftovers.

[1] https://github.com/mihalicyn/linux/commit/6a80e241feeea40e9068922eac045=
2566deccc61#diff-0553d076c243e06ae312480cb8cb52f1cebe1d80fc099d3842593e12c9=
e0d4f3R1920-R1930

Kind regards,
Alex

>
>
> > +               return err;
> > +
> >         UNIXCB(skb).uid =3D scm->creds.uid;
> >         UNIXCB(skb).gid =3D scm->creds.gid;
> >         UNIXCB(skb).fp =3D NULL;
> > @@ -1957,7 +1975,8 @@ static int unix_scm_to_skb(struct scm_cookie *scm=
, struct sk_buff *skb, bool sen
> >
> >  static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *sc=
m)
> >  {
> > -       scm_set_cred(scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb)=
.gid);
> > +       /* scm_set_cred() can't fail when pidfs_register =3D=3D false *=
/
> > +       scm_set_cred(scm, UNIXCB(skb).pid, false, UNIXCB(skb).uid, UNIX=
CB(skb).gid);
> >         unix_set_secdata(scm, skb);
> >  }
> >
> > @@ -1971,6 +1990,7 @@ static void unix_skb_to_scm(struct sk_buff *skb, =
struct scm_cookie *scm)
> >   * We include credentials if source or destination socket
> >   * asserted SOCK_PASSCRED.
> >   *
> > + * Context: May sleep.
> >   * Return: On success zero, on error a negative error code is returned=
.
> >   */
> >  static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock=
 *sk,
> > @@ -1980,7 +2000,12 @@ static int unix_maybe_add_creds(struct sk_buff *=
skb, const struct sock *sk,
> >                 return 0;
> >
> >         if (unix_may_passcred(sk) || unix_may_passcred(other)) {
>
> I forgot to mention that this part will conflict with net-next.
>
> I guess Christian will take this series via vfs tree ?
>
>
> > -               UNIXCB(skb).pid =3D get_pid(task_tgid(current));
> > +               int err;
> > +
> > +               err =3D unix_set_pid_to_skb(skb, task_tgid(current), tr=
ue);
> > +               if (unlikely(err))
> > +                       return err;
> > +
> >                 current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
> >         }
> >
> > --
> > 2.43.0
> >

