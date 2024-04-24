Return-Path: <netdev+bounces-90892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DFD8B0A4B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE8A2880A8
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636F15ADA0;
	Wed, 24 Apr 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qr64gVWo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFC315A4B0
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963696; cv=none; b=c2le81mRc0UNbHEGae88qbTNBYlGG3X4RGRd4DHm1HCqWtHaKsE6QxJFyk1ATrd/VaciQaeb4ndboUz67vHCnTkh1RIAszKPjyuhncYRZdIbQIKnvuMkz++JnBBbVzkRTiO4CFH8I35FKfKAVw87Y6vTK+XwNLAIBI2onGA2zdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963696; c=relaxed/simple;
	bh=2Qk+6Zvlgyj0FJeGQnL9t2fIEKB1rnoTiVdw1W4ef1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKCoWMScVggz/mHahkVLT09268kEfHxvWUaiLilJBti+EJZ6SUAuHq4D5Sgp18P+zLONMFrdmLvi6l4oYT2FRN21x0DOh/W7OjRaz2g5l6XtzMwZX2+VF832DXRRaLSkpyTLlfbIC1bSzdrfMfjEwN/R9OI7gEtFouFyJVdw8AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qr64gVWo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so15769a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 06:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713963693; x=1714568493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxhLPZtO6qFiS/NH2Oc0pcWp/Kz1XHNewxF3PwTepBY=;
        b=qr64gVWoe+N8TDiyF2qw3vkJFI79ZFqR/zwjUW4HVGqMsJg5DzC2pE+5KFhbbcuG2H
         hkPuCi+9/008ggh5hZCD1DZmQsLo7FtvyyauBzy7aCGJvFXWiBsEXFjckMF/lgN2hm61
         iqNkH9qOoJYZB0osv3LjuWqc6WkTGVOkLoTHR9Jj2+3jpqktAXz4MGy25WkpwReHYlnj
         /nuqpEoGWEjm5Z/KCnWAhcut0nEMajEa+cTeHRZDm3XOThwXV/bbE2OV9/zH6ON+1XUM
         NZS1/c0nEuuIBkwjW4FCdg7gHzhYaLUNAdeLZk+8NC7JAu0p8sPey0M19J5w3gifnAym
         r7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963693; x=1714568493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxhLPZtO6qFiS/NH2Oc0pcWp/Kz1XHNewxF3PwTepBY=;
        b=u9cDPdQzYaeCY67j5H1tjiTN98cKcgkoR+Mpj2vBzibmcvNXTwJF92nU1amAFroMcX
         4WlaYp1BTA9y82K7NCzoj7QzQFmBn4OEKr7RzZLb7+xsd9qKapAhDTxojU7+j4t10idq
         iO+OSHQSJAixB7oBTZFZyqN60bGutIafm9PQ6W3dl9k5Rq/aJeq3LAXJvwJqIvSVIob2
         1d9+D1SAb7Zph7ZU101/Qisgf/cWCparlA0NXlo7DsbsYhNKu5yPbhJ+IiUPeEc4tkf3
         yxVZIHdUHp44erikpAb7UD+LOYJMkr4EXILp/NZwzDqUOpb2SqwUbeVW5M6XKMSCMav4
         einw==
X-Forwarded-Encrypted: i=1; AJvYcCUA75bngogBMBZ4GKe1vmQKax/QBslYBUuWUIHqwuLa6gBNVsNak2RF/zs5HHQcJ/uEk07C1xQXuY0GQdScFy4q2zJouPZf
X-Gm-Message-State: AOJu0YyDs1BKKzQ2I8Prdd0/z4jVY8/IorlU0Ts8ghwIq0QLwxQPh2LG
	BJ7boCkT8EoW8mDebyVa11BPPUEXfexSh78NzKI/qyMK705GDnPM7jeR0tdW1CFOMXwN8jYJbLf
	MWmVAmIRQbULuhP+vMfj5v3UcCCGPbKWzocIX
X-Google-Smtp-Source: AGHT+IH5zeoTt6dcVisKPqiT22cRDiUcOPynV/tr0ZuYfbplTRwCQ/RoHTbTNADdJmXrE5KP/K6C3swe3v2hI/0WvwE=
X-Received: by 2002:a05:6402:12d7:b0:572:25bc:6cac with SMTP id
 k23-20020a05640212d700b0057225bc6cacmr137826edx.6.1713963692835; Wed, 24 Apr
 2024 06:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423205408.39632-1-edumazet@google.com> <77b16b5ffdc932a924ef8e6759e615658cdbc11b.camel@redhat.com>
In-Reply-To: <77b16b5ffdc932a924ef8e6759e615658cdbc11b.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Apr 2024 15:01:18 +0200
Message-ID: <CANn89iJJEp9MiRrxzwkd7w-nHK7iQ42qGco3e3QhrOZmOaa7RA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add two more call_rcu_hurry()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Joel Fernandes <joel@joelfernandes.org>, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Paolo

On Wed, Apr 24, 2024 at 10:01=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Tue, 2024-04-23 at 20:54 +0000, Eric Dumazet wrote:
> > I had failures with pmtu.sh selftests lately,
> > with netns dismantles firing ref_tracking alerts [1].
> >
> > After much debugging, I found that some queued
> > rcu callbacks were delayed by minutes, because
> > of CONFIG_RCU_LAZY=3Dy option.
> >
> > Joel Fernandes had a similar issue in the past,
> > fixed with commit 483c26ff63f4 ("net: Use call_rcu_hurry()
> > for dst_release()")
> >
> > In this commit, I make sure nexthop_free_rcu()
> > and free_fib_info_rcu() are not delayed too much
> > because they both can release device references.
>
> Great debugging!
>
> I'm wondering how many other similar situations we have out there???

I think there is another candidate for inet_free_ifa()

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 7592f242336b7fdf67e79dbd75407cf03e841cfc..cd2f0af7240899795abff008773=
0db2bb755c36e
100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -231,7 +231,7 @@ static void inet_rcu_free_ifa(struct rcu_head *head)

 static void inet_free_ifa(struct in_ifaddr *ifa)
 {
-       call_rcu(&ifa->rcu_head, inet_rcu_free_ifa);
+       call_rcu_hurry(&ifa->rcu_head, inet_rcu_free_ifa);
 }


>
> Have you considered instead adding a synchronize_rcu() alongside the
> rcu_barrier() in netdev_wait_allrefs_any()? If I read correctly commit
> 483c26ff63f4, That should kick all the possibly pending lazy rcu
> operation.

synchronize_rcu() could return very fast, even if queued rcu items are
still lingering.

I tried the following patch, this does not help.

Were you thinking of something else ?

diff --git a/net/core/dev.c b/net/core/dev.c
index 8bdc59074b29c287e432c73fffbe93c63d539ad2..a727290011693081b13ac6065e2=
ff2810bb5739d
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10559,6 +10559,7 @@ static struct net_device
*netdev_wait_allrefs_any(struct list_head *list)
                        rebroadcast_time =3D jiffies;
                }

+               synchronize_rcu_expedited();
                if (!wait) {
                        rcu_barrier();
                        wait =3D WAIT_REFS_MIN_MSECS;






>
> The patch LGTM, I'm just "thinking aloud".
>
> Thanks,
>
> Paolo
>

