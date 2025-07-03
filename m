Return-Path: <netdev+bounces-203589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA5CAF6793
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A331C4745E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECADC217F3D;
	Thu,  3 Jul 2025 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yk80RK1S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88D1A2545
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 01:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507616; cv=none; b=Upf+p4l7l20eclFiz6pKFsQ4YRzDgD11y4NmclFSqjUp0/wbfJejOn470Jn3QAzunx4wpgUGXrpvAByuen5ELt1bTl3KT3IUjiIzngvgfb//RIQQwkwgWw+/BeDfuql+dpug8MR1IF1w1pLklhSmjd3jdOtomvzgeSh8UGYHfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507616; c=relaxed/simple;
	bh=yJ+U7oGcF61QTjGZ97rEFlXbvX/Glgbaedvp4h74bE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsAPV/cvmmsNgiBGy60ukTXCRhnmp4S9VMmUDnsOOPHXzZb+huQBVpDpa+s4P5Y7UUiiD3EH+Vor5SToXHNue2ucgYSKOVFQg0mcU/Y3MFT39qOsAxlFNvRr86yXYvczQBy08aiS/rur/g+x2EWKPcsrpnKcwqthMrOJiGrnxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yk80RK1S; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b31c84b8052so8836800a12.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 18:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751507613; x=1752112413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fm8Gpzeema4ttu+gBieWjUgVngRGliuxzJUQN6YXW84=;
        b=Yk80RK1SirrQCzbUJqGOxrK6esYxyhUfn+TPu4OAPoNcY6ggk6OYNFfpZhrJ48Jcgx
         mzwdWUSGYRvQ5ExU9W0J/ykhI/tnRcO+DF/LZd/QYmoJpLVI1El2S3AzkIbqCPznY/Ei
         WHERwhX7iTHCxsG+HdQWt76Gk7caYFdekfCorLhw61EbAo3P0CdKEbUGo8rCWG1SBnXZ
         HqNV6EZltyKZu9pC5jARk9DrTSCPkrHpiePg6ppb/zQZpgKErQ1nIngig5iE7fYcmuc7
         NiWg12dpU4z0v6LgSHXUPlcO+6NebkCEaTiEWQZSbwMFinRvhYbX1Eu+7/qs0jRCX1NB
         DOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751507613; x=1752112413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fm8Gpzeema4ttu+gBieWjUgVngRGliuxzJUQN6YXW84=;
        b=Drc2xyT466txwpFFDeBHcSDYZ3b4O/1LgVxaqQdCQEPgwEHzFEyvngdj5Ydce5tXah
         ES7e4zZl2NfvhNovyEsV4w1bHpQknP41oa7ze163vG9scr5z+ZFT7q7sOCSvX0OPPu7B
         l08BWPQN5FHDaNXZjyeolkSXNIFy5VHLmwhDkuyE6wPpB+d+wnnz8+g22CFu4QPckSg2
         bvbjt7B4KOhzI4T86trjAsk1Y1A61gRvVvleeeuPBjO0mWOVhd3lt4O5tt4SksHgKla+
         mE9fZy8MeP0QKGo5YZdFzvXHzSMe2Q4paELbnZfqvx5r7GuTfON7sodtFmZR+bXL67D3
         7CnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+mJPD8vTRlGc5nS2xZ6XNW+UoTDJWss8nqvvobtDr3yf/NXu1ynAkLywOdvw17foK24CATZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv912+58xbyQZn29lW0cs0QIF9tlwwknfY1hlIYlmzKZK5lGqP
	tzWrIGfqquZ7TSUzBbcw2SkbXi/v+qhFhABKvNWR4nWq7ncKD6kUMujxB1e1dzpCWIu5CqrTcpG
	IuudU3Mi0YwD3XBmWBBQHUuMR6iRSmBgELhXaN1IMMTWfF8cZd+I6px7GvZk=
X-Gm-Gg: ASbGncsoZbacwvz7XHJ81w0q5v/E6u4PzNCIi1v1igqKVgHBIQz1Gl8bH9ke4vrn9HQ
	GD+ofpi1Q5nRuT4E0dauBR5I3RzsfAy58lc41owGRcPcN0tSYF5Nggtp5z8/1+QhyBhz6ZSpJCE
	oFeaYGOGq9L4pulNOvYfFL2hc6IYVZ5KFzoEcT1Cz9pORKwrGPrYnJzLOl/6Bl0zIsU5IgUVVk0
	LrMR4SHKn1jmMY=
X-Google-Smtp-Source: AGHT+IHow209Uc3fjWQzn9aKUfsgLPs3aCHPapfLAKy6OIlxWSVPSS3hVjolrnQY1XrprecCfBKN3L9kCL+0sf6Y+gA=
X-Received: by 2002:a17:90b:5408:b0:312:959:dc3c with SMTP id
 98e67ed59e1d1-31a90b2ade1mr7656256a91.10.1751507612991; Wed, 02 Jul 2025
 18:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com> <20250701083922.97928-9-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250701083922.97928-9-aleksandr.mikhalitsyn@canonical.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Jul 2025 18:53:21 -0700
X-Gm-Features: Ac12FXxAbYbkEnnb8aswFlGVfvCrj3uf2ybZZJVnzb4KilKyyYVbRlTwcj812SM
Message-ID: <CAAVpQUDFzPBJmCeawhaHL5Twjxk8obLZW9UPH0HfD_5BYpjh_w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/6] af_unix: stash pidfs dentry when needed
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:41=E2=80=AFAM Alexander Mikhalitsyn
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
> v2:
>         - renamed __skb_set_pid() -> unix_set_pid_to_skb() [ as Kuniyuki =
suggested ]
>         - get rid of extra helper (__scm_set_cred()) I've introduced befo=
re [ as Kuniyuki suggested ]
>         - s/__inline__/inline/ for functions I touched [ as Kuniyuki sugg=
ested ]
>         - get rid of chunk in unix_destruct_scm() with NULLifying UNIXCB(=
skb).pid [ as Kuniyuki suggested ]
>         - added proper error handling in scm_send() for scm_set_cred() re=
turn value [ found by me during rework ]
> ---
>  include/net/scm.h  | 32 ++++++++++++++++++++++++--------
>  net/core/scm.c     |  6 ++++++
>  net/unix/af_unix.c | 33 +++++++++++++++++++++++++++++----
>  3 files changed, 59 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 84c4707e78a5..597a40779269 100644
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
> @@ -66,19 +67,28 @@ static __inline__ void unix_get_peersec_dgram(struct =
socket *sock, struct scm_co
>  { }
>  #endif /* CONFIG_SECURITY_NETWORK */
>
> -static __inline__ void scm_set_cred(struct scm_cookie *scm,
> -                                   struct pid *pid, kuid_t uid, kgid_t g=
id)
> +static inline int scm_set_cred(struct scm_cookie *scm,
> +                              struct pid *pid, bool pidfs_register,
> +                              kuid_t uid, kgid_t gid)
>  {
> -       scm->pid  =3D get_pid(pid);
> +       if (pidfs_register) {
> +               int err =3D pidfs_register_pid(pid);
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
>  }
>
>  static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
>  {
>         put_pid(scm->pid);
> -       scm->pid  =3D NULL;
> +       scm->pid =3D NULL;

Could you split these double-space changes to another
patch to make review easier ?


>  }
>
>  static __inline__ void scm_destroy(struct scm_cookie *scm)
> @@ -88,14 +98,20 @@ static __inline__ void scm_destroy(struct scm_cookie =
*scm)
>                 __scm_destroy(scm);
>  }
>
> -static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
> -                              struct scm_cookie *scm, bool forcecreds)
> +static inline int scm_send(struct socket *sock, struct msghdr *msg,
> +                          struct scm_cookie *scm, bool forcecreds)
>  {
>         memset(scm, 0, sizeof(*scm));
>         scm->creds.uid =3D INVALID_UID;
>         scm->creds.gid =3D INVALID_GID;
> -       if (forcecreds)
> -               scm_set_cred(scm, task_tgid(current), current_uid(), curr=
ent_gid());
> +
> +       if (forcecreds) {
> +               int err =3D scm_set_cred(scm, task_tgid(current), true,
> +                                      current_uid(), current_gid());

Do we need to pass true here ?

Given this series affects scm_pidfd_recv(), we don't need to
touch netlink path that is not allowed to call scm_recv_unix() ?

Then, all callers pass false to scm_set_cred() and
pidfs_register_pid() there will be unnecessary.


> +               if (err)
> +                       return err;
> +       }
> +
>         unix_get_peersec_dgram(sock, scm);
>         if (msg->msg_controllen <=3D 0)
>                 return 0;
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 68441c024dd8..50dfec6f8a2b 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -147,9 +147,15 @@ EXPORT_SYMBOL(__scm_destroy);
>
>  static inline int __scm_replace_pid(struct scm_cookie *scm, struct pid *=
pid)
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
>         scm->pid =3D pid;
>         scm->creds.pid =3D pid_vnr(pid);
>         return 0;
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index df2174d9904d..18c677683ddc 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1924,12 +1924,27 @@ static void unix_peek_fds(struct scm_cookie *scm,=
 struct sk_buff *skb)
>         scm->fp =3D scm_fp_dup(UNIXCB(skb).fp);
>  }
>
> +static int unix_set_pid_to_skb(struct sk_buff *skb, struct pid *pid, boo=
l pidfs_register)
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
> +       scm.pid =3D UNIXCB(skb).pid;
> +
>         if (UNIXCB(skb).fp)
>                 unix_detach_fds(&scm, skb);
>
> @@ -1943,7 +1958,10 @@ static int unix_scm_to_skb(struct scm_cookie *scm,=
 struct sk_buff *skb, bool sen
>  {
>         int err =3D 0;
>
> -       UNIXCB(skb).pid =3D get_pid(scm->pid);
> +       err =3D unix_set_pid_to_skb(skb, scm->pid, false);
> +       if (unlikely(err))

This does not fail too.

Perhaps keep get_pid() here and move pidfs_register_pid()
to unix_maybe_add_creds(), that will look simpler.


> +               return err;
> +
>         UNIXCB(skb).uid =3D scm->creds.uid;
>         UNIXCB(skb).gid =3D scm->creds.gid;
>         UNIXCB(skb).fp =3D NULL;
> @@ -1957,7 +1975,8 @@ static int unix_scm_to_skb(struct scm_cookie *scm, =
struct sk_buff *skb, bool sen
>
>  static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
>  {
> -       scm_set_cred(scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).g=
id);
> +       /* scm_set_cred() can't fail when pidfs_register =3D=3D false */
> +       scm_set_cred(scm, UNIXCB(skb).pid, false, UNIXCB(skb).uid, UNIXCB=
(skb).gid);
>         unix_set_secdata(scm, skb);
>  }
>
> @@ -1971,6 +1990,7 @@ static void unix_skb_to_scm(struct sk_buff *skb, st=
ruct scm_cookie *scm)
>   * We include credentials if source or destination socket
>   * asserted SOCK_PASSCRED.
>   *
> + * Context: May sleep.
>   * Return: On success zero, on error a negative error code is returned.
>   */
>  static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *=
sk,
> @@ -1980,7 +2000,12 @@ static int unix_maybe_add_creds(struct sk_buff *sk=
b, const struct sock *sk,
>                 return 0;
>
>         if (unix_may_passcred(sk) || unix_may_passcred(other)) {

I forgot to mention that this part will conflict with net-next.

I guess Christian will take this series via vfs tree ?


> -               UNIXCB(skb).pid =3D get_pid(task_tgid(current));
> +               int err;
> +
> +               err =3D unix_set_pid_to_skb(skb, task_tgid(current), true=
);
> +               if (unlikely(err))
> +                       return err;
> +
>                 current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
>         }
>
> --
> 2.43.0
>

