Return-Path: <netdev+bounces-203670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D99CDAF6BCD
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0785F1C4650D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16742980AF;
	Thu,  3 Jul 2025 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czuYXEUL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F16224AF3;
	Thu,  3 Jul 2025 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528559; cv=none; b=n3ojLzMAlVzJkShS5ZhBIT0JU1fNrEKtMniQogOuzKi8jsiP8d9BGy9Eo3pb1J/K6E/2Nqm6gI16qKoHmwL9al5z2prt/NkEWPh9gk1q99sW9/mzmpaM5+ZsXlOKlGImhtPgHpktCqC9OkNjwMrRV0uOAonHIE6hSRffesA7r4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528559; c=relaxed/simple;
	bh=7JguKXSUW49wIt9EBmEjrE1JrwCA0VvHpJRgj+Q4Nc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I70DbNUaCBxQaCT4ezEzQSQVZLsi4NG2X8EK2BroQelJ8kWsXfh2Jzv8iGJPsDoPAs/OHZrOs5M2rs+m9Cb8VsyOiXsAhXP/LZoc2fLP31TeD1OcaP875PGMiTXOPymtFrggBpOisAMGbDxzJB0xPGlw+0sB0PNh/MBs50/sobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czuYXEUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75E3C4CEE3;
	Thu,  3 Jul 2025 07:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751528559;
	bh=7JguKXSUW49wIt9EBmEjrE1JrwCA0VvHpJRgj+Q4Nc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czuYXEULKfuh7qBbX2vkVwxQoxFyB8BcEscwi6nvFfCF1HlptgB/3MXusedQNZJz5
	 Ok2qqUPhYjgS5QhdjyzILt7nZ+RBcv/z5pU5+vADvjo8ZVYdfwROpzBZ+IIrleuNl7
	 qkNzo73h94wCAvdjWzfx8JFnuaBdMp9ibCOGR3i9vNfLGjiPmJzqoKlvd7QwyswfrS
	 oB17ek1Y7cizwy/pK+ddZHzWECgZ403XrmUNQHzBQvL/RAa5IjP8cXvV1jDi3tzr2I
	 /TjdZn1vGmj/ko4YUEpmgHDPczvllohIpA345JZKkPPaKHojureGabC9cP9RnQtB+r
	 Utn85+3Rjkbdg==
Date: Thu, 3 Jul 2025 09:42:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2 4/6] af_unix: stash pidfs dentry when needed
Message-ID: <20250703-brenzlig-bibliothek-b65bf4b52609@brauner>
References: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
 <20250701083922.97928-9-aleksandr.mikhalitsyn@canonical.com>
 <CAAVpQUDFzPBJmCeawhaHL5Twjxk8obLZW9UPH0HfD_5BYpjh_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUDFzPBJmCeawhaHL5Twjxk8obLZW9UPH0HfD_5BYpjh_w@mail.gmail.com>

On Wed, Jul 02, 2025 at 06:53:21PM -0700, Kuniyuki Iwashima wrote:
> On Tue, Jul 1, 2025 at 1:41 AM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > We need to ensure that pidfs dentry is allocated when we meet any
> > struct pid for the first time. This will allows us to open pidfd
> > even after the task it corresponds to is reaped.
> >
> > Basically, we need to identify all places where we fill skb/scm_cookie
> > with struct pid reference for the first time and call pidfs_register_pid().
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
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > ---
> > v2:
> >         - renamed __skb_set_pid() -> unix_set_pid_to_skb() [ as Kuniyuki suggested ]
> >         - get rid of extra helper (__scm_set_cred()) I've introduced before [ as Kuniyuki suggested ]
> >         - s/__inline__/inline/ for functions I touched [ as Kuniyuki suggested ]
> >         - get rid of chunk in unix_destruct_scm() with NULLifying UNIXCB(skb).pid [ as Kuniyuki suggested ]
> >         - added proper error handling in scm_send() for scm_set_cred() return value [ found by me during rework ]
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
> > @@ -66,19 +67,28 @@ static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_co
> >  { }
> >  #endif /* CONFIG_SECURITY_NETWORK */
> >
> > -static __inline__ void scm_set_cred(struct scm_cookie *scm,
> > -                                   struct pid *pid, kuid_t uid, kgid_t gid)
> > +static inline int scm_set_cred(struct scm_cookie *scm,
> > +                              struct pid *pid, bool pidfs_register,
> > +                              kuid_t uid, kgid_t gid)
> >  {
> > -       scm->pid  = get_pid(pid);
> > +       if (pidfs_register) {
> > +               int err = pidfs_register_pid(pid);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       scm->pid = get_pid(pid);
> > +
> >         scm->creds.pid = pid_vnr(pid);
> >         scm->creds.uid = uid;
> >         scm->creds.gid = gid;
> > +       return 0;
> >  }
> >
> >  static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
> >  {
> >         put_pid(scm->pid);
> > -       scm->pid  = NULL;
> > +       scm->pid = NULL;
> 
> Could you split these double-space changes to another
> patch to make review easier ?
> 
> 
> >  }
> >
> >  static __inline__ void scm_destroy(struct scm_cookie *scm)
> > @@ -88,14 +98,20 @@ static __inline__ void scm_destroy(struct scm_cookie *scm)
> >                 __scm_destroy(scm);
> >  }
> >
> > -static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
> > -                              struct scm_cookie *scm, bool forcecreds)
> > +static inline int scm_send(struct socket *sock, struct msghdr *msg,
> > +                          struct scm_cookie *scm, bool forcecreds)
> >  {
> >         memset(scm, 0, sizeof(*scm));
> >         scm->creds.uid = INVALID_UID;
> >         scm->creds.gid = INVALID_GID;
> > -       if (forcecreds)
> > -               scm_set_cred(scm, task_tgid(current), current_uid(), current_gid());
> > +
> > +       if (forcecreds) {
> > +               int err = scm_set_cred(scm, task_tgid(current), true,
> > +                                      current_uid(), current_gid());
> 
> Do we need to pass true here ?
> 
> Given this series affects scm_pidfd_recv(), we don't need to
> touch netlink path that is not allowed to call scm_recv_unix() ?
> 
> Then, all callers pass false to scm_set_cred() and
> pidfs_register_pid() there will be unnecessary.
> 
> 
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> >         unix_get_peersec_dgram(sock, scm);
> >         if (msg->msg_controllen <= 0)
> >                 return 0;
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index 68441c024dd8..50dfec6f8a2b 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -147,9 +147,15 @@ EXPORT_SYMBOL(__scm_destroy);
> >
> >  static inline int __scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
> >  {
> > +       int err;
> > +
> >         /* drop all previous references */
> >         scm_destroy_cred(scm);
> >
> > +       err = pidfs_register_pid(pid);
> > +       if (err)
> > +               return err;
> > +
> >         scm->pid = pid;
> >         scm->creds.pid = pid_vnr(pid);
> >         return 0;
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index df2174d9904d..18c677683ddc 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -1924,12 +1924,27 @@ static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
> >         scm->fp = scm_fp_dup(UNIXCB(skb).fp);
> >  }
> >
> > +static int unix_set_pid_to_skb(struct sk_buff *skb, struct pid *pid, bool pidfs_register)
> > +{
> > +       if (pidfs_register) {
> > +               int err;
> > +
> > +               err = pidfs_register_pid(pid);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       UNIXCB(skb).pid = get_pid(pid);
> > +       return 0;
> > +}
> > +
> >  static void unix_destruct_scm(struct sk_buff *skb)
> >  {
> >         struct scm_cookie scm;
> >
> >         memset(&scm, 0, sizeof(scm));
> > -       scm.pid  = UNIXCB(skb).pid;
> > +       scm.pid = UNIXCB(skb).pid;
> > +
> >         if (UNIXCB(skb).fp)
> >                 unix_detach_fds(&scm, skb);
> >
> > @@ -1943,7 +1958,10 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
> >  {
> >         int err = 0;
> >
> > -       UNIXCB(skb).pid = get_pid(scm->pid);
> > +       err = unix_set_pid_to_skb(skb, scm->pid, false);
> > +       if (unlikely(err))
> 
> This does not fail too.
> 
> Perhaps keep get_pid() here and move pidfs_register_pid()
> to unix_maybe_add_creds(), that will look simpler.
> 
> 
> > +               return err;
> > +
> >         UNIXCB(skb).uid = scm->creds.uid;
> >         UNIXCB(skb).gid = scm->creds.gid;
> >         UNIXCB(skb).fp = NULL;
> > @@ -1957,7 +1975,8 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
> >
> >  static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
> >  {
> > -       scm_set_cred(scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
> > +       /* scm_set_cred() can't fail when pidfs_register == false */
> > +       scm_set_cred(scm, UNIXCB(skb).pid, false, UNIXCB(skb).uid, UNIXCB(skb).gid);
> >         unix_set_secdata(scm, skb);
> >  }
> >
> > @@ -1971,6 +1990,7 @@ static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
> >   * We include credentials if source or destination socket
> >   * asserted SOCK_PASSCRED.
> >   *
> > + * Context: May sleep.
> >   * Return: On success zero, on error a negative error code is returned.
> >   */
> >  static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
> > @@ -1980,7 +2000,12 @@ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
> >                 return 0;
> >
> >         if (unix_may_passcred(sk) || unix_may_passcred(other)) {
> 
> I forgot to mention that this part will conflict with net-next.
> 
> I guess Christian will take this series via vfs tree ?

I'll just grab it and take care of the merge conflict.
Thanks for all the reviews. This will be a really helpful extension.
I really really like that we're pushing the envelope on secure client
authentication quite a bit with the recent work in this area!

