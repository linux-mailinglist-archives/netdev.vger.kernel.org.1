Return-Path: <netdev+bounces-232256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2A2C036C5
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 22:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3579D1A66CFF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB97D2036ED;
	Thu, 23 Oct 2025 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXh4rRyd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F41204C36
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252517; cv=none; b=r2orFomv4sX2cEID4C3M9nx7l6nM/61aY+sFxT5i41OjoD2iPpE0WPPAJS6BYn/Yg5Da2ZQI8JPC1B06aqMUV9hoEpoijC495it1SfFTDWnNgcC76B8dN5CfNqstNcLY9Vzm0WvpC9buATsCZ9d0gPKb57fxf9Ygm6TrwjMuW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252517; c=relaxed/simple;
	bh=Gcbh/YawGpk8Uqsjpz5jKAi49+g+99/ZQNLFOFIGsS8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ShQnacrb0/QL66jpLLm62WDOO7YIxdm/riBDYGxG4eNN2Goc5IBIcKvJFnjcd1c6dl59RRUI8UMNb/Pq3lkKz5uPVV4woKwAd8RE9940apWQU5bgw5Bac6hGPFJVcnP8i4MRzQBbMVH0fXNZly75RXMxjHkGhm7v2ZgGV/mqAzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXh4rRyd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befc08so3010488a91.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761252515; x=1761857315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrtlZBKd+kIqtNVYDS4i1ykdfiM+0pD/T3vPILs72m4=;
        b=NXh4rRydmN9gClW+IfU4K+phz/jYry+ETysY8iHTXlAApUMX0UXYmqGp/KXyewz6Js
         y2xUd5LLCfkxfBjcJswExMq/uKdEQqxu1cWQROQME5f+DB6tQiMkZ5kof8eOHXfEBvWl
         evK54tyLDJUeqnF7K7tYGQC+fCBgK6/hjePD6uCKc1qOrxvnMnFDXPRSVP07Xv1wu/W3
         +nSIiqpJVcIghR8i0kCvFKJBmnxboUwRewDppebBin0O72e4zFXl0jYQ1eyI+MBwuqvP
         Gk0fH3Bo9NqEFRIxgizIkZvEgGCcRsDLXr4BVynu4ffgx3xv39HJhZ40S4JsqMR4yqsp
         H74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252515; x=1761857315;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hrtlZBKd+kIqtNVYDS4i1ykdfiM+0pD/T3vPILs72m4=;
        b=BWnRqCUXERBZ4K3bqRuUh5YJ8Vxr1b0WLzi8YqcOXaszDRZvlRnMjqlruX1N7eFed7
         aR2HI/KJNmTfsOapHm+hgdzZohcbw9CTa9w6b7ufTn1I321exkT/9e4BqO2I9Agy+TPM
         7UzFlSNSI6BRYw4Kib87TuV7qnzPCH3U6aoID0vWeQkSkNj4hiGAHE+ZdvtWD+BVVr0k
         9dvhjxXpa7/2JF3GNy+RY/huoPvGoFYretSQ0OXpqveI20bzE4RoHDHoaAPwqtnNYvKC
         7bH5HpwDYPKf3q+lbDZXkNHIrLwNkj1Ek9FFe+bRBvKRCvWgDyk2lyXl6GjNCwToLlY+
         1gJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaU1fgneVAfLh6KDemhXmuKR3n8ygRVlaZDnGwyhuH3soKCUTiloQGrIt/SG6ktj9JVUXoAeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD9yZuHa6j/3UHZjYIdIArM6dDbh/b8/ZsqaCLGI0sZIv5fKPv
	QM/9Hsx8j92W3dI0q2O2zv/szFNHtcU8F2LYB/P5GsTutxg55novX15MTCaxHPCbuDE0f/XHkwk
	+fdgGwA==
X-Google-Smtp-Source: AGHT+IGHbSIJzX4Mr1Bjm9Od7R3e92oMRdMdkut8jusgrbOwNM2Hfl4/TRv8of9Dw8Lr8j8T8OigRYWj/rU=
X-Received: from pjvm7.prod.google.com ([2002:a17:90a:de07:b0:332:a4e1:42ec])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2789:b0:32b:cb05:849a
 with SMTP id 98e67ed59e1d1-33bcf8fe212mr29423575a91.29.1761252515296; Thu, 23
 Oct 2025 13:48:35 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:48:27 +0000
In-Reply-To: <CADvbK_eGSkXO1F168tCKd37hNqTVhPLprWpXOM-Z3KN29dB=Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CADvbK_eGSkXO1F168tCKd37hNqTVhPLprWpXOM-Z3KN29dB=Zg@mail.gmail.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023204833.3749214-1-kuniyu@google.com>
Subject: Re: [PATCH v2 net-next 4/8] net: Add sk_clone().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: lucien.xin@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, 
	linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 23 Oct 2025 15:55:57 -0400
> On Thu, Oct 23, 2025 at 3:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > On Thu, Oct 23, 2025 at 12:08=E2=80=AFPM Xin Long <lucien.xin@gmail.com=
> wrote:
> > >
> > > On Wed, Oct 22, 2025 at 6:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 3:04=E2=80=AFPM Xin Long <lucien.xin@gmail.=
com> wrote:
> > > > >
> > > > > On Wed, Oct 22, 2025 at 5:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu=
@google.com> wrote:
> > > > > >
> > > > > > sctp_accept() will use sk_clone_lock(), but it will be called
> > > > > > with the parent socket locked, and sctp_migrate() acquires the
> > > > > > child lock later.
> > > > > >
> > > > > > Let's add no lock version of sk_clone_lock().
> > > > > >
> > > > > > Note that lockdep complains if we simply use bh_lock_sock_neste=
d().
> > > > > >
> > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > ---
> > > > > >  include/net/sock.h |  7 ++++++-
> > > > > >  net/core/sock.c    | 21 ++++++++++++++-------
> > > > > >  2 files changed, 20 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > > > index 01ce231603db..c7e58b8e8a90 100644
> > > > > > --- a/include/net/sock.h
> > > > > > +++ b/include/net/sock.h
> > > > > > @@ -1822,7 +1822,12 @@ struct sock *sk_alloc(struct net *net, i=
nt family, gfp_t priority,
> > > > > >  void sk_free(struct sock *sk);
> > > > > >  void sk_net_refcnt_upgrade(struct sock *sk);
> > > > > >  void sk_destruct(struct sock *sk);
> > > > > > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t =
priority);
> > > > > > +struct sock *sk_clone(const struct sock *sk, const gfp_t prior=
ity, bool lock);
> > > > > > +
> > > > > > +static inline struct sock *sk_clone_lock(const struct sock *sk=
, const gfp_t priority)
> > > > > > +{
> > > > > > +       return sk_clone(sk, priority, true);
> > > > > > +}
> > > > > >
> > > > > >  struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long si=
ze, int force,
> > > > > >                              gfp_t priority);
> > > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > > index a99132cc0965..0a3021f8f8c1 100644
> > > > > > --- a/net/core/sock.c
> > > > > > +++ b/net/core/sock.c
> > > > > > @@ -2462,13 +2462,16 @@ static void sk_init_common(struct sock =
*sk)
> > > > > >  }
> > > > > >
> > > > > >  /**
> > > > > > - *     sk_clone_lock - clone a socket, and lock its clone
> > > > > > - *     @sk: the socket to clone
> > > > > > - *     @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, et=
c)
> > > > > > + * sk_clone - clone a socket
> > > > > > + * @sk: the socket to clone
> > > > > > + * @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> > > > > > + * @lock: if true, lock the cloned sk
> > > > > >   *
> > > > > > - *     Caller must unlock socket even in error path (bh_unlock=
_sock(newsk))
> > > > > > + * If @lock is true, the clone is locked by bh_lock_sock(), an=
d
> > > > > > + * caller must unlock socket even in error path by bh_unlock_s=
ock().
> > > > > >   */
> > > > > > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t =
priority)
> > > > > > +struct sock *sk_clone(const struct sock *sk, const gfp_t prior=
ity,
> > > > > > +                     bool lock)
> > > > > >  {
> > > > > >         struct proto *prot =3D READ_ONCE(sk->sk_prot);
> > > > > >         struct sk_filter *filter;
> > > > > > @@ -2497,9 +2500,13 @@ struct sock *sk_clone_lock(const struct =
sock *sk, const gfp_t priority)
> > > > > >                 __netns_tracker_alloc(sock_net(newsk), &newsk->=
ns_tracker,
> > > > > >                                       false, priority);
> > > > > >         }
> > > > > > +
> > > > > >         sk_node_init(&newsk->sk_node);
> > > > > >         sock_lock_init(newsk);
> > > > > > -       bh_lock_sock(newsk);
> > > > > > +
> > > > > > +       if (lock)
> > > > > > +               bh_lock_sock(newsk);
> > > > > > +
> > > > > does it really need bh_lock_sock() that early, if not, maybe we c=
an move
> > > > > it out of sk_clone_lock(), and names sk_clone_lock() back to sk_c=
lone()?
> > > >
> > > > I think sk_clone_lock() and leaf functions do not have
> > > > lockdep_sock_is_held(), and probably the closest one is
> > > > security_inet_csk_clone() which requires lock_sock() for
> > > > bpf_setsockopt(), this can be easily adjusted though.
> > > > (see bpf_lsm_locked_sockopt_hooks)
> > > >
> > > Right.
> > >
> > > > Only concern would be moving bh_lock_sock() there will
> > > > introduce one cache line miss.
> > > I think it=E2=80=99s negligible, and it=E2=80=99s not even on the dat=
a path, though others
> > > may have different opinions.
> >
> > For SCTP, yes, but I'd avoid it for TCP.
> Okay, not a problem, just doesn't look common to pass such a parameter.

Another option would be add a check like this ?

---8<---
diff --git a/include/net/sock.h b/include/net/sock.h
index c7e58b8e8a90..e708b70b04da 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2904,6 +2904,12 @@ static inline bool sk_is_inet(const struct sock *sk)
 	return family =3D=3D AF_INET || family =3D=3D AF_INET6;
 }
=20
+static inline bool sk_is_sctp(const struct sock *sk)
+{
+	return IS_ENABLED(CONFIG_SCTP) &&
+		sk->sk_protocol =3D=3D IPPROTO_SCTP;
+}
+
 static inline bool sk_is_tcp(const struct sock *sk)
 {
 	return sk_is_inet(sk) &&
diff --git a/net/core/sock.c b/net/core/sock.c
index 0a3021f8f8c1..ed5f36c6f33e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2470,10 +2470,10 @@ static void sk_init_common(struct sock *sk)
  * If @lock is true, the clone is locked by bh_lock_sock(), and
  * caller must unlock socket even in error path by bh_unlock_sock().
  */
-struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
-		      bool lock)
+struct sock *sk_clone(const struct sock *sk, const gfp_t priority)
 {
 	struct proto *prot =3D READ_ONCE(sk->sk_prot);
+	bool lock =3D !sk_is_sctp(sk);
 	struct sk_filter *filter;
 	bool is_charged =3D true;
 	struct sock *newsk;
@@ -2597,7 +2597,8 @@ struct sock *sk_clone(const struct sock *sk, const gf=
p_t priority,
 	 * destructor and make plain sk_free()
 	 */
 	newsk->sk_destruct =3D NULL;
-	bh_unlock_sock(newsk);
+	if (lock)
+		bh_unlock_sock(newsk);
 	sk_free(newsk);
 	newsk =3D NULL;
 	goto out;
---8<---


>=20
> There is also bh_unlock_sock(newsk) in the free path in sk_clone(),
> does it also need a 'if (lock)' check?

Good catch.  Will fix it in v3.

Thanks!

