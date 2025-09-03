Return-Path: <netdev+bounces-219430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E62B41488
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072485426C1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 05:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8582D2D3A75;
	Wed,  3 Sep 2025 05:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVG27D3a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91F420EB
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756878533; cv=none; b=jOgezMVbIL7d/HO6Wlx5Puerhe/ICOknu2vEhasIiE6sW7cSKw+ZbbSW2vT84t2LTXUoVlmckjXKIwvS/xh6cRoP0zHHWTHLD2NzccUMC6Pazb2Fwsm28AEqZCef1A2gm1Ntt4Aohzt9ROjZp2WDuFqPXq53ZldHpA+sdLaHwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756878533; c=relaxed/simple;
	bh=P29/hUvtfmngsYKe9sFiSxCme71KO+tZ//APrhmWcqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1UhoSdp/v5u2IKSHVKWuxAr9EHKbMS4qmWRIZZWEa/1HS248bwKj2X+YVmjr3bSBjWvRC9HCDHVuvuLTw5EoBNOulWTZKcbw3ZNwPXQ85xXGLcT5y8PK8HGG9ut0rBeQ4AGpCuaykUxiEo/FJCdHiy43gP025FUFaJKB/HZNJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVG27D3a; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-772627dd50aso678696b3a.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 22:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756878531; x=1757483331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWNtOWjoWu1hFCQ7mzKzkzXVkr6pinoXVR6Y+Qq/u/8=;
        b=WVG27D3apfQtFErd02cmSWOUrC0GTleG9R6jPZlYa+05FH3WOqY7YJfHe/luhP7bUm
         yvwDyZJu3vxvqKNZ5VEzxX6e8w/iYrH9bOXFO5cKbHJ3VPYVl7fl35WAo5NJ+XVN3/Na
         lymbwNtgDK8mq99WwkgRwwIhq4iblw9080YnpHXqfgvtcWDYUD/gWWUPn/aB6FF085Pj
         SmCXiB9lLinhj5N9v3qaHwlIKlb1i5+DmWXymGSsyMmD4vzDVNqdXessXYJDCisVaQR6
         MXmxE8Pyiu8EaEAY+mjQro/cfAuXGvD6NC+1j+808Uv0QKKOPSoX3JjsWIVRo+tlc45g
         s52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756878531; x=1757483331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWNtOWjoWu1hFCQ7mzKzkzXVkr6pinoXVR6Y+Qq/u/8=;
        b=ClDcM4hSsb+j/uqTM6CTWOMqwmtw/VuQjFNIBMuNCLwz30lVsZ0wkJ4cM4x4jaPYjF
         kBGWZwUbl9OrozfyrFbmUE8RI1RSE4/ljfVn5Rt6DozaFrVzEFEEdU44oITJTt4Ws6bf
         Pt7LMoeIiGugo2F1Scq83HCbDLByqsQIx2VDAIZBKFK743yAyFGTc/AybRTdF2EtMpAl
         Oh7LRQGjRsKfnKiQgrjzr+092w9r/tjIOgR5O6+g6YxskSYQ6QKOaOoz12T1/J21b+tE
         Q64IB+Pmfv4nj95iWec1miNsmiV/m8Zlu2Rou7i9MLMQBJgnk9gBKrYgpNsmMmXO3Lu3
         zCxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbv8D2QtB+4oE7pRAtCNACRg8F7etexTQkbFoeshvKuXOhCNUsGI4bj1v9FMp0h8jExVqSFoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2iIkxmS8BdpGnLe/cF94IUPiMC1XWwP4/0nssuNiephwOCbB
	UEykxnrgSDfTarV1XhbToDJUjRECHqHcje1tRnlC6aEaRhb26nVh/L9uQyjlrzrCwQtZo6pUr3N
	NyvqYsqK9BWXm1fruQ/ooAihxYJXGcqgmcSbOnbV4
X-Gm-Gg: ASbGncssaoqsIZFIEv/zMNfbqz8yumlzQUz8X302YqxAYc8CUs0PsJZjL/1R5xafX4Q
	OooxMwx4TzDNThsSzi7vMFu7BC6GichA7eLQ1SGJ+FyvknfgQM3JwvAv8xabRNytOLhoJ0huq8w
	CXPvquPmf3sNLnMYmmIpZkgHcDutnElSa5Gi5EG7YuXsqyAgTzsiwD0BBqhE75w4J23YiN1bARi
	/FDP7UOHxoGcqvsPj0K3AYrHh1FnwUULtc1OyuLnfHVvD5WAPQotpWt5p/sd329GleUIOgGx1OM
	Sg==
X-Google-Smtp-Source: AGHT+IGjfiai4bO062h7HkwbbcAYqfycwh71PciC8ZkLKwqKJSoO5mFGDsW3/19paAbypLpPbkCqRxU2i3UxOGBn648=
X-Received: by 2002:a05:6a20:3d05:b0:246:273:1c67 with SMTP id
 adf61e73a8af0-24602731fc5mr5071965637.18.1756878530807; Tue, 02 Sep 2025
 22:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903024406.2418362-1-xuanqiang.luo@linux.dev> <CAAVpQUCKDi0aZcraeZaMY4ebuoBoB_Ymdy1RGb1247JznArTJg@mail.gmail.com>
In-Reply-To: <CAAVpQUCKDi0aZcraeZaMY4ebuoBoB_Ymdy1RGb1247JznArTJg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Sep 2025 22:48:39 -0700
X-Gm-Features: Ac12FXypT0KtkDow4x8mQK-4RkoW1j2N2q4RwFyYORlJOmucgs1eq6pRAvY14ys
Message-ID: <CAAVpQUDZFCYNMQ08uRLu388cmggckzPeP=N7WncFyxN-_hgaMw@mail.gmail.com>
Subject: Re: [PATCH net] inet: Avoid established lookup missing active sk
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org, 
	kernelxing@tencent.com, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 10:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Sep 2, 2025 at 7:45=E2=80=AFPM Xuanqiang Luo <xuanqiang.luo@linux=
.dev> wrote:
> >
> > From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >
> > Since the lookup of sk in ehash is lockless, when one CPU is performing=
 a
> > lookup while another CPU is executing delete and insert operations
> > (deleting reqsk and inserting sk), the lookup CPU may miss either of
> > them, if sk cannot be found, an RST may be sent.
> >
> > The call trace map is drawn as follows:
> >    CPU 0                           CPU 1
> >    -----                           -----
> >                                 spin_lock()
> >                                 sk_nulls_del_node_init_rcu(osk)
> > __inet_lookup_established()
> >                                 __sk_nulls_add_node_rcu(sk, list)
> >                                 spin_unlock()
>
> This usually does not happen except for local communication, and
> retrying on the client side is much better than penalising all lookups
> for SYN.
>
> >
> > We can try using spin_lock()/spin_unlock() to wait for ehash updates
> > (ensuring all deletions and insertions are completed) after a failed
> > lookup in ehash, then lookup sk again after the update. Since the sk
> > expected to be found is unlikely to encounter the aforementioned scenar=
io
> > multiple times consecutively, we only need one update.
> >
> > Similarly, an issue occurs in tw hashdance. Try adjusting the order in
> > which it operates on ehash: remove sk first, then add tw. If sk is miss=
ed
> > during lookup, it will likewise wait for the update to find tw, without
> > worrying about the skc_refcnt issue that would arise if tw were found
> > first.
> >
> > Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / =
hlist_nulls")
> > Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > ---
> >  net/ipv4/inet_hashtables.c    | 12 ++++++++++++
> >  net/ipv4/inet_timewait_sock.c |  9 ++++-----
> >  2 files changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index ceeeec9b7290..4eb3a55b855b 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -505,6 +505,7 @@ struct sock *__inet_lookup_established(const struct=
 net *net,
> >         unsigned int hash =3D inet_ehashfn(net, daddr, hnum, saddr, spo=
rt);
> >         unsigned int slot =3D hash & hashinfo->ehash_mask;
> >         struct inet_ehash_bucket *head =3D &hashinfo->ehash[slot];
> > +       bool try_lock =3D true;
> >
> >  begin:
> >         sk_nulls_for_each_rcu(sk, node, &head->chain) {
> > @@ -528,6 +529,17 @@ struct sock *__inet_lookup_established(const struc=
t net *net,
> >          */
> >         if (get_nulls_value(node) !=3D slot)
> >                 goto begin;
> > +
> > +       if (try_lock) {
> > +               spinlock_t *lock =3D inet_ehash_lockp(hashinfo, hash);
> > +
> > +               try_lock =3D false;
> > +               spin_lock(lock);
> > +               /* Ensure ehash ops under spinlock complete. */
> > +               spin_unlock(lock);
> > +               goto begin;
> > +       }
> > +
> >  out:
> >         sk =3D NULL;
> >  found:
> > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_soc=
k.c
> > index 875ff923a8ed..a91e02e19c53 100644
> > --- a/net/ipv4/inet_timewait_sock.c
> > +++ b/net/ipv4/inet_timewait_sock.c
> > @@ -139,14 +139,10 @@ void inet_twsk_hashdance_schedule(struct inet_tim=
ewait_sock *tw,
> >
> >         spin_lock(lock);
> >
> > -       /* Step 2: Hash TW into tcp ehash chain */
> > -       inet_twsk_add_node_rcu(tw, &ehead->chain);
>
> You are adding a new RST scenario where the corresponding
> socket is not found and a listener or no socket is found.
>
> The try_lock part is not guaranteed to happen after twsk
> insertion below.

Oh no, spin_lock() dance sychronises the threads but I still
think this is rather harmful for normal cases; now sending
an unmatched packet can trigger lock dance, which is easily
abused for DDoS.


>
>
> > -
> > -       /* Step 3: Remove SK from hash chain */
> > +       /* Step 2: Remove SK from hash chain */
> >         if (__sk_nulls_del_node_init_rcu(sk))
> >                 sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> >
> > -
> >         /* Ensure above writes are committed into memory before updatin=
g the
> >          * refcount.
> >          * Provides ordering vs later refcount_inc().
> > @@ -161,6 +157,9 @@ void inet_twsk_hashdance_schedule(struct inet_timew=
ait_sock *tw,
> >          */
> >         refcount_set(&tw->tw_refcnt, 3);
> >
> > +       /* Step 3: Hash TW into tcp ehash chain */
> > +       inet_twsk_add_node_rcu(tw, &ehead->chain);
> > +
> >         inet_twsk_schedule(tw, timeo);
> >
> >         spin_unlock(lock);
> > --
> > 2.25.1
> >

