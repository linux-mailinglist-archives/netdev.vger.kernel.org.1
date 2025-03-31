Return-Path: <netdev+bounces-178380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F18CA76C9F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3297D7A2422
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA87215178;
	Mon, 31 Mar 2025 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBk4co78"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381C214A82
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743442977; cv=none; b=gzMZcOCCLW+i/pMDFcaidIQnQTijhDalHQZKDiyuAcoXkEwttVjeIGD8Lx+zxqqUFA7DRmTilYDA/3cLipaiPV2YedjzEe7wCICHJYhqVZAxXPDrAfD87xJD/maigxW79Rr7VBoJsCpERwk86Zz7HBMGl4zd3c4/h3r7d63QK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743442977; c=relaxed/simple;
	bh=DjdZITVl1P+PGZS6GuULUNzMohmS5YvO2xYitU40iNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shbAbniMSWbzYx6XjC2366rlNLrwZvX1PcjUeNjpyi/M2JAoc8+oQTH2wegmSc69cruy+8ZJU30JWwhZA8DHAjPR3eo37pNEg2cq4eyZgf3NHGwH4QufhhdasS65f4vGo8FCPj/GwjalT4GxXAjnme+9383qnH9iaUqrTUoqk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBk4co78; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c55500cf80so377471985a.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743442975; x=1744047775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=My8uhixiibhggK7Xb+4LFtDtHM4swzPwMY30T/cp9Dw=;
        b=sBk4co78rc+KuGFAk3H3ryog0cWhKLBxtXb2iol48e6qLcm1Mk3WT42woiYGWOBuCB
         PzX3xQVejspbYuRCMDISB9ojQqLbxTPigV6YG6WTCi3LK70QG1sA7Ig6+dVG/gIw66gn
         f4yGTVwEarsNamM2hHDIWqcbj0VnyJ3g5baeMG+R4qL5AES8pyeL+GFhwukK1hqxwYLA
         uNSS02EV41qAyPH2sWQr1gmXKTQ/QtNEzVaRDgV2geEZ3+JucmZCfZkxSvZ5dQyerINg
         i+IP5B1Put8sgGgWvjRyu1sHDC5tUizgwBuTSLvBnetcIrt3cYRb+K8hDgdBnkgHL1ko
         kq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743442975; x=1744047775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=My8uhixiibhggK7Xb+4LFtDtHM4swzPwMY30T/cp9Dw=;
        b=F0NHcKS7u3xCnim4u7rDuWj0ksWx3mKjH4i6P6jzo5ApaY8FD+Tv1xXp45d1TD481D
         Ofadqj6VOZ4cuvrVLsSVIZq6HmBRcjtTKKbm+Tswbv8vmavGn5WWnx1NFQMzv1qhx2/w
         +n2pCUyy2hkWLherGQX6kMsNTTtbx0/btKEs5SJBw00QRrPyO8DVJpumgZMRH6RPON0B
         6+N2Fxg1HsWZd8+jEj1FR9hFWx+bi5fCQmdvobO62B1MSxPYFjD6KaIe0UO49QwwAgk+
         TjBbaN2AeFbFy3D6PB1sc7ED4rbb0u2QPE5+d59wiVa80yh2m6HbmYov7YZJ4CLVuqkL
         xZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHKgn4lg6utovwtZzl6ehxKqNhaXwSXG/gVpxayxGGIDAFhWjjxhFJYsYs283w+8Uy2nkcaeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAKBwh9EKg6CCSmluLaRQWaE8ROvSjC48fyp3s5q8WNI1xYe57
	iuqFUWxsWmGR/2Ga7+uQNN9/lNRGJ+kVuf1TyOwU6yKtuF27NJLp5byWEJr4v1xqFgOQQ+Bv0KR
	+M1qQh+jv8qbJqvi/0MUgDOqz1qwaO5kl9hWK
X-Gm-Gg: ASbGncuW+DEwzNzVmp9laYyaaGqs1ZnUwQGAp0yNbaFKlxx2s+Eumddg04pBNiehnPi
	6hpuAh+O2Jd4kh1Yc+rzL03mT7i4jyB+pOsVwD5TusTJHUdOtGGdbtulvJgB0Vy+6qAgKHkJ+1x
	cKSZykzYdgi6C+SeEKIFrVQOsX
X-Google-Smtp-Source: AGHT+IFVYeXdtz8CMmMU3r4guNsVjIFuRiY1o3vm/KhYGXO0UfVI67k7g7GlfbcLm9vxymX/IVsqshiItVdG+n6JtD0=
X-Received: by 2002:a05:620a:2483:b0:7c5:55be:7bff with SMTP id
 af79cd13be357-7c69087585fmr1356768685a.43.1743442974849; Mon, 31 Mar 2025
 10:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67e1fd15.050a0220.bc49a.766e@mx.google.com> <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com>
 <Z-Il69LWz6sIand0@Mac.home> <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux> <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux> <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>
 <Z-OPya5HoqbKmMGj@Mac.home> <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com> <Z-rQNzYRMTinrDSl@boqun-archlinux>
In-Reply-To: <Z-rQNzYRMTinrDSl@boqun-archlinux>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 31 Mar 2025 19:42:43 +0200
X-Gm-Features: AQ5f1JoLvOmmtYvJq2bkf46RVtrKhW7rLor1IMlgcRlpTIfmTPZnYqRALBM5hWk
Message-ID: <CANn89iLvu_ijSV+FnrZ6qei_Ty2c9V-RjwLMk24+oOS91bNjaQ@mail.gmail.com>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <llong@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, aeh@meta.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com, 
	kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 7:26=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Mar 26, 2025 at 11:39:49AM -0400, Waiman Long wrote:
> [...]
> > > > Anyway, that may work. The only problem that I see is the issue of =
nesting
> > > > of an interrupt context on top of a task context. It is possible th=
at the
> > > > first use of a raw_spinlock may happen in an interrupt context. If =
the
> > > > interrupt happens when the task has set the hazard pointer and iter=
ating the
> > > > hash list, the value of the hazard pointer may be overwritten. Alte=
rnatively
> > > > we could have multiple slots for the hazard pointer, but that will =
make the
> > > > code more complicated. Or we could disable interrupt before setting=
 the
> > > > hazard pointer.
> > > Or we can use lockdep_recursion:
> > >
> > >     preempt_disable();
> > >     lockdep_recursion_inc();
> > >     barrier();
> > >
> > >     WRITE_ONCE(*hazptr, ...);
> > >
> > > , it should prevent the re-entrant of lockdep in irq.
> > That will probably work. Or we can disable irq. I am fine with both.
>
> Disabling irq may not work in this case, because an NMI can also happen
> and call register_lock_class().
>
> I'm experimenting a new idea here, it might be better (for general
> cases), and this has the similar spirit that we could move the
> protection scope of a hazard pointer from a key to a hash_list: we can
> introduce a wildcard address, and whenever we do a synchronize_hazptr(),
> if the hazptr slot equal to wildcard, we treat as it matches to any ptr,
> hence synchronize_hazptr() will still wait until it's zero'd. Not only
> this could help in the nesting case, it can also be used if the users
> want to protect multiple things with this simple hazard pointer
> implementation.

For the record this was my suggestion.

Breno, what do you think ? Feel free to grab, test, add comments and a
nice changelog, thanks !

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 67964dc4db952ea11d4b88554383ea0ec5946ef9..fb56bcb887ca163525f003cb788=
0c76511d166e7
100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -117,7 +117,12 @@ do {
         \
 } while (0)

 extern void lockdep_register_key(struct lock_class_key *key);
-extern void lockdep_unregister_key(struct lock_class_key *key);
+
+extern void __lockdep_unregister_key(struct lock_class_key *key, bool sync=
);
+static inline void lockdep_unregister_key(struct lock_class_key *key)
+{
+       return __lockdep_unregister_key(key, true);
+}

 /*
  * These methods are used by specific locking variants (spinlocks,
@@ -372,8 +377,12 @@ static inline void lockdep_register_key(struct
lock_class_key *key)
 {
 }

+static inline void __lockdep_unregister_key(struct lock_class_key
*key, bool sync)
+{
+}
 static inline void lockdep_unregister_key(struct lock_class_key *key)
 {
+       return __lockdep_unregister_key(key, true);
 }

 #define lockdep_depth(tsk)     (0)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b15757e6362615aeecb1629f8e60375e13a87e6d..3b754c7fdaf19887734b1ee37f7=
c058f8f751a4e
100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6574,7 +6574,7 @@ void lockdep_reset_lock(struct lockdep_map *lock)
  * key irrespective of debug_locks to avoid potential invalid access to fr=
eed
  * memory in lock_class entry.
  */
-void lockdep_unregister_key(struct lock_class_key *key)
+void lockdep_unregister_key(struct lock_class_key *key, bool sync)
 {
        struct hlist_head *hash_head =3D keyhashentry(key);
        struct lock_class_key *k;
@@ -6610,8 +6610,11 @@ void lockdep_unregister_key(struct lock_class_key *k=
ey)
        if (need_callback)
                call_rcu(&delayed_free.rcu_head, free_zapped_rcu);

-       /* Wait until is_dynamic_key() has finished accessing k->hash_entry=
. */
-       synchronize_rcu();
+       /* Wait until is_dynamic_key() has finished accessing k->hash_entry=
.
+        * @sync is false for callers dealing with the sync themselves.
+        */
+       if (sync)
+               synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(lockdep_unregister_key);

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 14ab2f4c190a1e201dd1788b413a06e799a829f2..9affef187237a13559642d435e1=
a196a909f75f9
100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -988,8 +988,8 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queu=
e,

        return sch;
 errout1:
-       lockdep_unregister_key(&sch->root_lock_key);
-       kfree(sch);
+       __lockdep_unregister_key(&sch->root_lock_key, false);
+       kfree_rcu(sch, rcu);
 errout:
        return ERR_PTR(err);
 }
@@ -1077,7 +1077,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
        if (ops->destroy)
                ops->destroy(qdisc);

-       lockdep_unregister_key(&qdisc->root_lock_key);
+       __lockdep_unregister_key(&qdisc->root_lock_key, false);
        module_put(ops->owner);
        netdev_put(dev, &qdisc->dev_tracker);

