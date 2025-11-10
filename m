Return-Path: <netdev+bounces-237280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B955C485F7
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0986A3AF7BB
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DD12D8362;
	Mon, 10 Nov 2025 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcTQObbn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F232C1590
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796081; cv=none; b=bN+kbwIA5LK/XlR1PxsnZtEdWfkIfiG1reKu+8S+A7rECUcIHvTwfBjgJ/JU+hiNrrPnrfKepHzZh0R+CUOZL4/TQNISiCX+xS44f0axXU64GwVnka/uUsAl18xT7pLiBdvK1fPNrDOK5SGJtv+r9ZxFTS748/TKOaVUiDkGTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796081; c=relaxed/simple;
	bh=8ElGai7rVF/Xe1RH0thn8BQx3AysEMxTBF+UBRspc3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYSkkPfY2stMklGne+COYj7cs2JrVUZdY020fNE1APKKICRO+383nWovR7SNRFCr80uA+VC5K2RPYVnn4yPHMoAQKhiI4IZnoSdSpL2d6LM4CYq68yUueCKY9ZmLxAXjTF36dTRM2hIlXIhDSvdnZlaKShKs6FCl8DMzutV9fxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcTQObbn; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-787e7aa1631so14962987b3.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762796079; x=1763400879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEpOXr9BkKL7aaBPtofBixyR49G3f6rqELGQHiBWHcQ=;
        b=ZcTQObbn9eoUN9GFKmmqafO/PCGeVY4lb/FdxHfqmJQa3W4c6eX7X3NDhz3np+HP1s
         pjBwQClLN9YbD3WYeOFnqCw3pLIIcUEPXAQ55Q7j+K5Qs7DB996ojY8D25oI9EYb4UEM
         VNi2WlggE1oJoS2KMZnkkPOiKgzi7yeWruPpCQxQDhjJqG/EMKYGilxJQgpSJNDQYd+X
         Aknt4ikctdn0hGpU37F4T73Zem8vHmJs3I163YBJ/s+5r9EYuv8p1a/ONK0kYKI/siMN
         rJQgcy5PzGu4Pte/NzV8tkjgBUGeELgmoAW56CBXu0Yw5M3r/mSf4RzBp0+m5gC80BQh
         qLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796079; x=1763400879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GEpOXr9BkKL7aaBPtofBixyR49G3f6rqELGQHiBWHcQ=;
        b=t5aiiC5lS/z9ix5Hbbco9UpINFV4FLrgqt6/3vmuUE3VeG0NFokCmVV3kPNRfYSDdh
         o+UOkYSVSYS2bHINXQcnA9iSaCrprD0A47o6puEdlQEnhOPIt+S4grMNzR7vw8n26ZhA
         P8bl6Udi7j5jUKJBcejcusaD/QIfwUIOSgMA6ewI2giL1aAqmvOnHj0qWbqTOsceKYPr
         hektOAfTlLSuw3QId5yFtpiAvqbBq8P9yhsYreojIVADCPC4HjbnyWrbKku/CFW8xO9B
         9QzAtUHbVa9lIg1qUrU95AlFGQfpCLS8JW2/V+LMGdaPC4zoWB1zuZtfTDQ4qdc5ifyi
         YkKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdPnIfeHrfwuOAxvaV8bi6na54AE8JNK1hg/GrJ1OhwjAstOAAUO6Tz1V4zDJUASEbDza+y/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQAmElblG+jCd8DN2oDtFR789fHvGdiZAlIq/XoEwvJ/klazU
	WIwlB83wnnHfLlLUlXJF5RdarlecO5UKYAVJg5JQe+U8P5tASrt4neg9CNY5V/pE3otEpAmqZPj
	tp0HyBqSB9V74ej8NRPf+qxW8pUyqBKbSu4QxT5F7
X-Gm-Gg: ASbGncvarVh4bZ3Na+a8DQ42xIWmaq/2jEY/yAgnfFq6w6YutpnONha4QU09Wt8sXjm
	iLcrTA1PcgqLaDyP6HMgJE4A+g1ghUOQcJyScH5MNaWndMbZ90w+plBoaN7MW6mLZYngSVNqppN
	hZ1W3UEXl9D5x1vQ+DL/KDXIVs0qJ9bxAgI4P5RIuVZOy0Y/xU69HowgUYgRq/+3pg+XpkPw06n
	NPVnlJCOnjDC1FF2EnYgZ1Aoep2FjKgm0PStsh3tYsBWshyfAd3DaBURvXM
X-Google-Smtp-Source: AGHT+IHcZjG52ZcVkhPfs06cSn/vReWWxCNcDSwd7u0a1wuitv3fOUM9x8zkVRpLlLa9TSrqaK4LM6KfTyYqg6zHD0Y=
X-Received: by 2002:a05:690c:f89:b0:787:d09e:88fa with SMTP id
 00721157ae682-7880361ba5cmr1706457b3.21.1762796078311; Mon, 10 Nov 2025
 09:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145416.829707-1-edumazet@google.com> <20251013145416.829707-6-edumazet@google.com>
 <877bw1ooa7.fsf@toke.dk> <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
 <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com>
 <CANn89iLQ3G6ffTN+=98+DDRhOzw8TNDqFd_YmYn168Qxyi4ucA@mail.gmail.com>
 <CANn89iLqUtGkgXj0BgrXJD8ckqrHkMriapKpwHNcMP06V_fAGQ@mail.gmail.com>
 <871pm7np2w.fsf@toke.dk> <ef601e55-16a0-4d3e-bd0d-536ed9dd29cd@tu-berlin.de>
 <CANn89iKDx52BnKZhw=hpCCG1dHtXOGx8pbynDoFRE0h_+a7JhQ@mail.gmail.com>
 <CANn89iKhPJZGWUBD0-szseVyU6-UpLWP11ZG0=bmqtpgVGpQaw@mail.gmail.com>
 <CANn89iL9XR=NA=_Bm-CkQh7KqOgC4f+pjCp+AiZ8B7zeiczcsA@mail.gmail.com>
 <87seemm8eb.fsf@toke.dk> <CANn89iLWsYDErNJNVhTOk7PfmMjV53kLa720RYXOBCu3gjvS=w@mail.gmail.com>
 <87ms4ulz7q.fsf@toke.dk>
In-Reply-To: <87ms4ulz7q.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Nov 2025 09:34:26 -0800
X-Gm-Features: AWmQ_bl8a7lDionHmOEKTrbpJNn0VxDtPq1WHSi-1LM_cod4RlYrCU24Qr1TXIo
Message-ID: <CANn89i+dL6JUpbZgJ9DEGeVWpmrfv9q=Y_daFvHAPM4ZsjinQg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 6:49=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > I can work on a patch today.
>
> This sounds like an excellent idea in any case - thanks! :)

The following (on top of my last series) seems to work for me

 include/net/pkt_sched.h   |    5 +++--
 include/net/sch_generic.h |   24 +++++++++++++++++++++++-
 net/core/dev.c            |   33 +++++++++++++++++++--------------
 net/sched/sch_cake.c      |    4 +++-
 4 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 4678db45832a1e3bf7b8a07756fb89ab868bd5d2..e703c507d0daa97ae7c3bf131e3=
22b1eafcc5664
100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -114,12 +114,13 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qdis=
c *q,

 void __qdisc_run(struct Qdisc *q);

-static inline void qdisc_run(struct Qdisc *q)
+static inline struct sk_buff *qdisc_run(struct Qdisc *q)
 {
        if (qdisc_run_begin(q)) {
                __qdisc_run(q);
-               qdisc_run_end(q);
+               return qdisc_run_end(q);
        }
+       return NULL;
 }

 extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 79501499dafba56271b9ebd97a8f379ffdc83cac..19cd2bc13bdba48f941b1599f89=
6c15c8c7860ae
100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -88,6 +88,8 @@ struct Qdisc {
 #define TCQ_F_INVISIBLE                0x80 /* invisible by default in dum=
p */
 #define TCQ_F_NOLOCK           0x100 /* qdisc does not require locking */
 #define TCQ_F_OFFLOADED                0x200 /* qdisc is offloaded to HW *=
/
+#define TCQ_F_DEQUEUE_DROPS    0x400 /* ->dequeue() can drop packets
in q->to_free */
+
        u32                     limit;
        const struct Qdisc_ops  *ops;
        struct qdisc_size_table __rcu *stab;
@@ -119,6 +121,8 @@ struct Qdisc {

                /* Note : we only change qstats.backlog in fast path. */
                struct gnet_stats_queue qstats;
+
+               struct sk_buff          *to_free;
        __cacheline_group_end(Qdisc_write);


@@ -218,8 +222,15 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc=
)
        return true;
 }

-static inline void qdisc_run_end(struct Qdisc *qdisc)
+static inline struct sk_buff *qdisc_run_end(struct Qdisc *qdisc)
 {
+       struct sk_buff *to_free =3D NULL;
+
+       if (qdisc->flags & TCQ_F_DEQUEUE_DROPS) {
+               to_free =3D qdisc->to_free;
+               if (to_free)
+                       qdisc->to_free =3D NULL;
+       }
        if (qdisc->flags & TCQ_F_NOLOCK) {
                spin_unlock(&qdisc->seqlock);

@@ -235,6 +246,7 @@ static inline void qdisc_run_end(struct Qdisc *qdisc)
        } else {
                WRITE_ONCE(qdisc->running, false);
        }
+       return to_free;
 }

 static inline bool qdisc_may_bulk(const struct Qdisc *qdisc)
@@ -1105,6 +1117,16 @@ static inline void tcf_set_drop_reason(const
struct sk_buff *skb,
        tc_skb_cb(skb)->drop_reason =3D reason;
 }

+static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb=
,
+                                     enum skb_drop_reason reason)
+{
+       DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
+
+       tcf_set_drop_reason(skb, reason);
+       skb->next =3D q->to_free;
+       q->to_free =3D skb;
+}
+
 /* Instead of calling kfree_skb() while root qdisc lock is held,
  * queue the skb for future freeing at end of __dev_xmit_skb()
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index ac994974e2a81889fcc0a2e664edcdb7cfd0496d..18cfcd765b1b3e4af1c5339e36d=
f517e7abc914f
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4141,7 +4141,7 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
                                 struct net_device *dev,
                                 struct netdev_queue *txq)
 {
-       struct sk_buff *next, *to_free =3D NULL;
+       struct sk_buff *next, *to_free =3D NULL, *to_free2 =3D NULL;
        spinlock_t *root_lock =3D qdisc_lock(q);
        struct llist_node *ll_list, *first_n;
        unsigned long defer_count =3D 0;
@@ -4160,9 +4160,9 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
                        if (unlikely(!nolock_qdisc_is_empty(q))) {
                                rc =3D dev_qdisc_enqueue(skb, q, &to_free, =
txq);
                                __qdisc_run(q);
-                               qdisc_run_end(q);
+                               to_free2 =3D qdisc_run_end(q);

-                               goto no_lock_out;
+                               goto free_out;
                        }

                        qdisc_bstats_cpu_update(q, skb);
@@ -4170,18 +4170,15 @@ static inline int __dev_xmit_skb(struct
sk_buff *skb, struct Qdisc *q,
                            !nolock_qdisc_is_empty(q))
                                __qdisc_run(q);

-                       qdisc_run_end(q);
-                       return NET_XMIT_SUCCESS;
+                       to_free2 =3D qdisc_run_end(q);
+                       rc =3D NET_XMIT_SUCCESS;
+                       goto free_out;
                }

                rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
-               qdisc_run(q);
+               to_free2 =3D qdisc_run(q);

-no_lock_out:
-               if (unlikely(to_free))
-                       kfree_skb_list_reason(to_free,
-                                             tcf_get_drop_reason(to_free))=
;
-               return rc;
+               goto free_out;
        }

        /* Open code llist_add(&skb->ll_node, &q->defer_list) + queue limit=
.
@@ -4239,7 +4236,7 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
                qdisc_bstats_update(q, skb);
                if (sch_direct_xmit(skb, q, dev, txq, root_lock, true))
                        __qdisc_run(q);
-               qdisc_run_end(q);
+               to_free2 =3D qdisc_run_end(q);
                rc =3D NET_XMIT_SUCCESS;
        } else {
                int count =3D 0;
@@ -4251,15 +4248,19 @@ static inline int __dev_xmit_skb(struct
sk_buff *skb, struct Qdisc *q,
                        rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
                        count++;
                }
-               qdisc_run(q);
+               to_free2 =3D qdisc_run(q);
                if (count !=3D 1)
                        rc =3D NET_XMIT_SUCCESS;
        }
 unlock:
        spin_unlock(root_lock);
+free_out:
        if (unlikely(to_free))
                kfree_skb_list_reason(to_free,
                                      tcf_get_drop_reason(to_free));
+       if (unlikely(to_free2))
+               kfree_skb_list_reason(to_free2,
+                                     tcf_get_drop_reason(to_free2));
        return rc;
 }

@@ -5741,6 +5742,7 @@ static __latent_entropy void net_tx_action(void)
        }

        if (sd->output_queue) {
+               struct sk_buff *to_free;
                struct Qdisc *head;

                local_irq_disable();
@@ -5780,9 +5782,12 @@ static __latent_entropy void net_tx_action(void)
                        }

                        clear_bit(__QDISC_STATE_SCHED, &q->state);
-                       qdisc_run(q);
+                       to_free =3D qdisc_run(q);
                        if (root_lock)
                                spin_unlock(root_lock);
+                       if (unlikely(to_free))
+                               kfree_skb_list_reason(to_free,
+                                             tcf_get_drop_reason(to_free))=
;
                }

                rcu_read_unlock();
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 312f5b000ffb67d74faf70f26d808e26315b4ab8..a717cc4e0606e80123ec9c76331=
d454dad699b69
100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2183,7 +2183,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch=
)
                b->tin_dropped++;
                qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
                qdisc_qstats_drop(sch);
-               kfree_skb_reason(skb, reason);
+               qdisc_dequeue_drop(sch, skb, reason);
                if (q->rate_flags & CAKE_FLAG_INGRESS)
                        goto retry;
        }
@@ -2569,6 +2569,8 @@ static void cake_reconfigure(struct Qdisc *sch)

        sch->flags &=3D ~TCQ_F_CAN_BYPASS;

+       sch->flags |=3D TCQ_F_DEQUEUE_DROPS;
+
        q->buffer_limit =3D min(q->buffer_limit,
                              max(sch->limit * psched_mtu(qdisc_dev(sch)),
                                  q->buffer_config_limit));

