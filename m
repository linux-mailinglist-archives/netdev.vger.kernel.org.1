Return-Path: <netdev+bounces-90895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C848B0A5E
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087311F22179
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FB5143891;
	Wed, 24 Apr 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbwbmKPR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222681598E2
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963900; cv=none; b=dZand/nIM+OzrNiTUqMSYI7awqdLsianmjlcAgFoZOgtiNyDa5ALytXWh2wWMqudckMcprp37avC05s4JmGh+XHtHlpBPDJ8VMIn1sDs2daVNYAAlqKB1OxmZc3A0sfwvABJ0jXjv7VH+rJPynlvZ7eIJZkYUBPiJ9FloFaxcjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963900; c=relaxed/simple;
	bh=f3MLZEO5naEt6j6/yq4U9GkWyhfKi7mllIqauPUhpUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nON6AEgv0J0PaC41cQ9YTYkKZQoPKtrV1ind3pCZpmJi6e6NMTkStx0OzQlXT42Bn/E7gdvuS13nUfVH+7KGR+xdyugkoELOuWdEQWFijd+5cnoQFXAZ6lPR+iONdi1UODSamDAZd7ia62rZWE1M9QVkH6whSxi7qKSKG8or+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbwbmKPR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so15871a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713963893; x=1714568693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hme3kpY2Mp7Ui7TVydLmT8xKEwM5nnVlToFi3L8M68I=;
        b=dbwbmKPRRPfmzRCniC9KJ+F9pr/0LDUMkYNs8Ey1SS7AjZu2AbsIncaBcf1zQFG3QT
         RhNsfsXf3qCqofpPC4OngCrRVqf3AFsoeU3Au4bgV0dBLf4qAiSK8Jtr4ZGiJG/StxNo
         ZUWhj2kXdm3G8HDEubkXBykMBG/VpvkDFOUSMznoNe7qXem4144nqNy2sHEbciPGgfbd
         tMw82gUSm8re2OjsBnh4Ox/8/Rkyi3Iwxt1HtQgawwHKVNoVcpge5vZT96TN0WZyUIqw
         bquCa+F8zLO7WH/Z5iBpDLGNqTtBspBksGsVeLP0TcPGSgZt6r5PpdV33ICWLt1RVM8q
         3pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963893; x=1714568693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hme3kpY2Mp7Ui7TVydLmT8xKEwM5nnVlToFi3L8M68I=;
        b=iCBoSF067MmuLQIN5jWuGkYQ/XSQNHwoKglps+aTcyDlv+mHFqk1YmRpu9ssR8p6hn
         Xbjln5/OKVAaEIOnfwVUqi1YwXoSUEBhMfv4UBid7FOtfFohUhm7okWAVv3qkJXvkWFT
         qhFr3nsSitpxT5CVME51rZ9/a8X2DYRJvqN6TJgeWeDf/zmrJXyxQPuR0yfnvRpzZpQK
         07Np9RR4udyunnI/r8a68Av4TiaXZcO1SjNkqln2NthVndcmdHYH/xN7aG1Ndqw0Iq0A
         ZgChU3Y3A8rErqlcspHyncOsnKBszc7Ebrxz31suk/EKYUmgHWp+r0nkIIktD+LvvQ7P
         lxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5QzR+OT9NX65BQ5L9qdH6Yl+E1UbDViojrpPrb1NbPmE6zcTmi70rwq3L3XYl5HmVWjMvqQBwi3+niVkgLrelgBuClvXl
X-Gm-Message-State: AOJu0YzhlWhE9shjSehnSHPAViKln2hONU5d5S3A50mCx2xZwHQpFDxD
	2da6IqAnz3wXtHqcAA+5AFbNWT3NPrvPIOqp4n39cs+1KRdyRbnzOlEGZWLBEJW7P9EldZMOZEI
	Ich+3Zg0AVyeIP8Gr01K6Urw244B6Z7HVLXmp
X-Google-Smtp-Source: AGHT+IGOeW62X9I69SYZfskDOdHgpA7Jnk7OkSGL2Ro00eQTtaO9J3l6ga+zGQeDilB+yMy+neblUsK/dfzI9MYrAq0=
X-Received: by 2002:a05:6402:12d7:b0:572:25bc:6cac with SMTP id
 k23-20020a05640212d700b0057225bc6cacmr138653edx.6.1713963893049; Wed, 24 Apr
 2024 06:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423205408.39632-1-edumazet@google.com> <77b16b5ffdc932a924ef8e6759e615658cdbc11b.camel@redhat.com>
 <CANn89iJJEp9MiRrxzwkd7w-nHK7iQ42qGco3e3QhrOZmOaa7RA@mail.gmail.com>
In-Reply-To: <CANn89iJJEp9MiRrxzwkd7w-nHK7iQ42qGco3e3QhrOZmOaa7RA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Apr 2024 15:04:41 +0200
Message-ID: <CANn89i+OkamE==5FPU=1+NcgsqkyLW2FbfP21HiEq1TsjZVA+Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add two more call_rcu_hurry()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Joel Fernandes <joel@joelfernandes.org>, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:01=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
>  Hi Paolo
>
> On Wed, Apr 24, 2024 at 10:01=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > On Tue, 2024-04-23 at 20:54 +0000, Eric Dumazet wrote:
> > > I had failures with pmtu.sh selftests lately,
> > > with netns dismantles firing ref_tracking alerts [1].
> > >
> > > After much debugging, I found that some queued
> > > rcu callbacks were delayed by minutes, because
> > > of CONFIG_RCU_LAZY=3Dy option.
> > >
> > > Joel Fernandes had a similar issue in the past,
> > > fixed with commit 483c26ff63f4 ("net: Use call_rcu_hurry()
> > > for dst_release()")
> > >
> > > In this commit, I make sure nexthop_free_rcu()
> > > and free_fib_info_rcu() are not delayed too much
> > > because they both can release device references.
> >
> > Great debugging!
> >
> > I'm wondering how many other similar situations we have out there???
>
> I think there is another candidate for inet_free_ifa()
>
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 7592f242336b7fdf67e79dbd75407cf03e841cfc..cd2f0af7240899795abff0087=
730db2bb755c36e
> 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -231,7 +231,7 @@ static void inet_rcu_free_ifa(struct rcu_head *head)
>
>  static void inet_free_ifa(struct in_ifaddr *ifa)
>  {
> -       call_rcu(&ifa->rcu_head, inet_rcu_free_ifa);
> +       call_rcu_hurry(&ifa->rcu_head, inet_rcu_free_ifa);
>  }
>
>
> >
> > Have you considered instead adding a synchronize_rcu() alongside the
> > rcu_barrier() in netdev_wait_allrefs_any()? If I read correctly commit
> > 483c26ff63f4, That should kick all the possibly pending lazy rcu
> > operation.
>
> synchronize_rcu() could return very fast, even if queued rcu items are
> still lingering.
>
> I tried the following patch, this does not help.
>
> Were you thinking of something else ?
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 8bdc59074b29c287e432c73fffbe93c63d539ad2..a727290011693081b13ac6065=
e2ff2810bb5739d
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10559,6 +10559,7 @@ static struct net_device
> *netdev_wait_allrefs_any(struct list_head *list)
>                         rebroadcast_time =3D jiffies;
>                 }
>
> +               synchronize_rcu_expedited();
>                 if (!wait) {
>                         rcu_barrier();
>                         wait =3D WAIT_REFS_MIN_MSECS;
>
>

Note that if we are in this part of the code, we are already in some
trouble, so the call_rcu_hurry() would avoid this.

I will try ::

diff --git a/net/core/dev.c b/net/core/dev.c
index 8bdc59074b29c287e432c73fffbe93c63d539ad2..b4aa5b7070897edbe8a26fbb51d=
23e85a7a09dc4
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10559,8 +10559,8 @@ static struct net_device
*netdev_wait_allrefs_any(struct list_head *list)
                        rebroadcast_time =3D jiffies;
                }

+               rcu_barrier();
                if (!wait) {
-                       rcu_barrier();
                        wait =3D WAIT_REFS_MIN_MSECS;
                } else {
                        msleep(wait);

