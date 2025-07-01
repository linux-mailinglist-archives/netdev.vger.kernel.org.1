Return-Path: <netdev+bounces-202818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC5CAEF1B7
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15347A4CDB
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E9226CFF;
	Tue,  1 Jul 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GL01WiMu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5FD1E7C12
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359741; cv=none; b=Y6ambyQ9Cu4OwxsXsAe5+cUa5zCIfxEvFgQaY35TwCSPXm7kF+ErgkNIZFQsjB02ujuNI+vep257CZL+Bv6gomFYtRG6TDHoc1vXny4X4hW6FpW2A0fY7TehmlZId/AuOhVpbbi9+90m5XkKbdsvqdmSVeBNt3YY85Q2IqAjv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359741; c=relaxed/simple;
	bh=pJ00oNrvEGyadyhWFNRrhEHBgZ2RjqEsbNxRM369CVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUFs+V4w2A3W0e2BMrzsDrNsr1v8hNZbg7xTRMMF0Mw1ma+oV+d+r7ZzvE46Rq12I302s6HPDcWa91Me0TEsxaWWof89Fx7F1ljAqScX29K14ciRRBtJRkMneEwklry5HjeiYzaC9peo/fr/y47sUGwhVpaT6NcLl/EwaMRDr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GL01WiMu; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D94923F69A
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751359737;
	bh=Ru9xbF0j60vErx4HggEKCJR6kAv4e8ygDHAGpa7xZ+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=GL01WiMuldSLAWq+3YWmSy30++1DyEany0zBbNFP3Uoe6oeX5q67jUoG4A/l/v6cp
	 EGd6JY3/fLgFl5gDmWDEsF9jrAKlR6jqpYY9F3CpjWChQJXTzZWNKcK8h/Hz0fKO11
	 toXgZca91YZBs8ShZ7v8ffD71LmST3kt/2LDRtJDaLaY8hDPVWRnU24NQAeb7PDOYn
	 g3ze4dd2upopeUFBbBnQiiG8034kwPI3xtpCk+nMMNeI1X4kIBKakUeg7zbEcwWZP1
	 tmoFW/lZYOfb84kIJ4pNWWuVO9xL5cE+ZQghiYFzYx3fZkdHYVq1UUEWCpBK6UFPy+
	 nW22KbooHMzog==
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-53322160310so729051e0c.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 01:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359737; x=1751964537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ru9xbF0j60vErx4HggEKCJR6kAv4e8ygDHAGpa7xZ+0=;
        b=S48JApSY6uKItaU68pkelKvGx9Wcz+FxG7C3w25F7ETi214aH+HH1lnOalIm7Jxuy7
         0pMXejJ6NwKqGvNAjD+swTgmO/t7tO4nlmscWYqSB6D9B4Hj8DscFMGGFQnzy8NYhMXs
         84sdvG1ZlIefQQ+YKOJWZApZHFheBdtSFtupZO38XIm3gIcHOA7/0ks/OIqK5DlgLkpI
         81eFWannthe5Q69aXzKWfjo1lINQvhzG/R16jrveNsFJn64O7l2T+ROB2siGNCApvZgR
         2v0sOZA7OrDqVXo+UWiuncb0/nFNgjCQS3na1jVa3or/M63R8g/s3k9jgZqmzo7p8xyl
         exdw==
X-Forwarded-Encrypted: i=1; AJvYcCVsPjGj4xlbCpQ2nsuhTM552rZE0hW7Mcv6rp4G00wDzfvDXPZCtqLV7vNuWiLpWQmwM85b+98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjq8WwZhusr6qcEkbSk8lvbpUecn5Ran3XedU/vUXHFcCR6ahX
	H858wXAWdpekyee03Jw4OkuvLuCBqG9wYMRQgVrdT2ncP2FH/zf6+vi9Q7PRIQHBPEk/v+qboCf
	pHiQJokA7B6DJaYwx1PnVgGGT0mNYtThsmwzlGaqkM+4cBMtXjfLFOIofwiWrUjF3b035TW46M2
	LOIBERtrCBs0bVkvStrXMeC4mnoNhGVSi4hTc7NwWvon8+4Ka/
X-Gm-Gg: ASbGnct5C78iDMahbM8Mr0/9Wu+2BxRd/gKv+OVv13WQLLo31PuczxFh7INNhpl+RBs
	yRhZJnlbsxiG/BGd+/PW/ldljsvPTQfZkACcKPUD87pQrDtYtZy7tQ7U3Lq1h9F7emLOaFozOry
	A6cWTO
X-Received: by 2002:a05:6102:c93:b0:4e5:a9b7:df with SMTP id ada2fe7eead31-4ee4f7af5b1mr9380652137.13.1751359736817;
        Tue, 01 Jul 2025 01:48:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFyUbj1GUDb5g+hKD5+DHrT9WQqS/TMA8ECPBck/wJ1zI1joUFRB4wCh+x7lbN1KPUvT41r2N96PQfGhhlMMI=
X-Received: by 2002:a05:6102:c93:b0:4e5:a9b7:df with SMTP id
 ada2fe7eead31-4ee4f7af5b1mr9380645137.13.1751359736523; Tue, 01 Jul 2025
 01:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
 <20250629214449.14462-4-aleksandr.mikhalitsyn@canonical.com> <CAAVpQUAG+=PP67sCFSYJ6zubsEODUt+1Tf-2KtiPUcJTYAF_EQ@mail.gmail.com>
In-Reply-To: <CAAVpQUAG+=PP67sCFSYJ6zubsEODUt+1Tf-2KtiPUcJTYAF_EQ@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Tue, 1 Jul 2025 10:48:45 +0200
X-Gm-Features: Ac12FXw8CPUv9ouBEe_onHdCuhOzV39ayQ7McYrz2eqRXOlnBnZmM5HuIYvbWJI
Message-ID: <CAEivzxdEWRsP83X3PLNtLXMZMWGdXaPb8YtduB=cQcXE55e7Mg@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next 3/6] af_unix: introduce and use
 __scm_replace_pid() helper
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Lennart Poettering <mzxreary@0pointer.de>, 
	Luca Boccassi <bluca@debian.org>, David Rheinsberg <david@readahead.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 9:46=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> [dropped my previous email address]
>
> On Sun, Jun 29, 2025 at 2:45=E2=80=AFPM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > Existing logic in __scm_send() related to filling an struct scm_cookie
> > with a proper struct pid reference is already pretty tricky. Let's
> > simplify it a bit by introducing a new helper. This helper will be
> > extended in one of the next patches.
> >
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Willem de Bruijn <willemb@google.com>
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
> >  include/net/scm.h | 10 ++++++++++
> >  net/core/scm.c    | 11 ++++++++---
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/scm.h b/include/net/scm.h
> > index 84c4707e78a5..856eb3a380f6 100644
> > --- a/include/net/scm.h
> > +++ b/include/net/scm.h
> > @@ -88,6 +88,16 @@ static __inline__ void scm_destroy(struct scm_cookie=
 *scm)
> >                 __scm_destroy(scm);
> >  }
> >
> > +static __inline__ int __scm_replace_pid(struct scm_cookie *scm, struct=
 pid *pid)
>
> It seems this function is only called from __scm_send() so this should
> be moved to .c (and inlined ?).

sure!

>
> > +{
> > +       /* drop all previous references */
> > +       scm_destroy_cred(scm);
> > +
> > +       scm->pid =3D get_pid(pid);
>
> This looks redundant.  Maybe move the put_pid() under if (error)
> in __scm_send().

yep, fixed in v2.

>
> > +       scm->creds.pid =3D pid_vnr(pid);
> > +       return 0;
> > +}
> > +
> >  static __inline__ int scm_send(struct socket *sock, struct msghdr *msg=
,
> >                                struct scm_cookie *scm, bool forcecreds)
> >  {
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index 0225bd94170f..0e71d5a249a1 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -189,15 +189,20 @@ int __scm_send(struct socket *sock, struct msghdr=
 *msg, struct scm_cookie *p)
> >                         if (err)
> >                                 goto error;
> >
> > -                       p->creds.pid =3D creds.pid;
> >                         if (!p->pid || pid_vnr(p->pid) !=3D creds.pid) =
{
> >                                 struct pid *pid;
> >                                 err =3D -ESRCH;
> >                                 pid =3D find_get_pid(creds.pid);
> >                                 if (!pid)
> >                                         goto error;
> > -                               put_pid(p->pid);
> > -                               p->pid =3D pid;
> > +
> > +                               err =3D __scm_replace_pid(p, pid);
> > +                               /* Release what we get from find_get_pi=
d() as
> > +                                * __scm_replace_pid() takes all necess=
ary refcounts.
> > +                                */
> > +                               put_pid(pid);
> > +                               if (err)
> > +                                       goto error;
> >                         }
> >
> >                         err =3D -EINVAL;
> > --
> > 2.43.0
> >

