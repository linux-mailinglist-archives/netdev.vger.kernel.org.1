Return-Path: <netdev+bounces-237698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE571C4F188
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3909A3A6D20
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0683E3730E0;
	Tue, 11 Nov 2025 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoDvQlv9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KG+7d9nh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8C23730E1
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879343; cv=none; b=oylszwH80rz0K2puYgrX483x2aqBrrOa+IOFhJrB6COQXR4Tvh9urZgJQxOZRyEqfWynheFl/eTIJy2RNmWbI2dJPqW/QUxGcsYGUmAciLKVf3jwHd3zouZ3MM6T2iT3vfZ+SMR3fX3LIx12EPd4AsDpY46iaSW1ZSqZ0r6lQjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879343; c=relaxed/simple;
	bh=jzfjCBtadQtouwoSWvlKMEsIXS0Zzi7w4EqKxhfeXo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oJP9+5C1vE8F/m75P4FieabTbeny62NZMtUfUsRActDdDXGxSbVN4Z2+Fx+WMT6PsPf3nt2XZ5ocE1j+JlR4sYfz/w7laK62TLLHPLg6Z2L8ap7tRYN+oa6LZOldr8XKKd1E+YBxOsbtnsBi0vKOwYqbyGnNEIFubut+ZCzdBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BoDvQlv9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KG+7d9nh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762879335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gc+527YZ+/EQhvvSpiSw2wvEXc5HmQlrD8RceXlwXCU=;
	b=BoDvQlv9ROEdP0IAwxOtr7XwdQPOe5WwOvg6jg0FbgUMwnWzM9szVGsE3gqgsO2TSN2pWF
	XUT5wgqO6Pxi0VEcjMyqKd+McBmuB4zJv51eTwfkBqTOSOqKliLtuoFoqki7GF/R/JQa7S
	EiSFQ26DaMm4Mz08g5zmiNFAdb0lCMI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-FEaYQEsiORO5MMA8aWZgFA-1; Tue, 11 Nov 2025 11:42:13 -0500
X-MC-Unique: FEaYQEsiORO5MMA8aWZgFA-1
X-Mimecast-MFC-AGG-ID: FEaYQEsiORO5MMA8aWZgFA_1762879332
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b70be4f20e0so290778466b.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 08:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762879331; x=1763484131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gc+527YZ+/EQhvvSpiSw2wvEXc5HmQlrD8RceXlwXCU=;
        b=KG+7d9nhtNKDBqIkNfd8W0KYxlUGxsdUfE+qUGVEVssNnrpt2mv7mEv0wEk8dm88ZN
         gIC9ZxZHRPsQI813eTkDbIKkCjGT6E6UV0zhad+nIyPBYMYF1FNg79RH63aKGz8LmnJY
         l5RqIfOdpy8+gZALnVTbFESHxpM7mycHF8oMahK1oWmkPBcaxpVdy679W2Wp3BdTACCj
         xtpVEwgEW5aqsClQ4XXF6N+D1uTEynNy0FnrmLzRMqROfsLHjSWNHUB3Mq381jTSotXW
         /TvMg8Pm74eOisg9nsVYq0cbPkckADjWSRARZqLcuG892SxcZNLLcc9JjSEy0lYAvc2O
         V7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762879331; x=1763484131;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gc+527YZ+/EQhvvSpiSw2wvEXc5HmQlrD8RceXlwXCU=;
        b=WFI9Bak81XrV/ps328I1ReCoVOaxLkRfBwUjr6JllFj15bbGtDjQtQ80n77f8IWm7E
         kwmftjhx0hvLhEj5K+43LNamB03btTNpbSfBM3WJU9mIYwDvG1C1FAgDGwy82fCYX2ko
         StfG3ucOf/3frtXtHic6++bIOW+h6uqe03wGGk03zr/s1aXaYItWMdHavAK5E2XnoH3d
         qNHkESkBfeX3pkyHHYh8dekKl1w0JxN3SwLA/rBAi89Mqh4AUK/RIUJn9/aB5AWQsfI8
         l/rWKme7oheBSFJiAUd3Vf5Cil+MdxE53+pxrugMofKwYR011CUFZwwxsq0SA4EfNAz0
         zWzg==
X-Forwarded-Encrypted: i=1; AJvYcCW1heuUfIqBFpVRtp23XUDRS83ieZs2TsX6vJFGDYF1yYkHtdV0Guvd6VAY65vsW3V34WO81CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynzy+62ZeTuV0pXnSH077HF9XQwHyyP5McgG/i5TgACec21hV5
	VOI/Tt3LwrsGzhm844SqGpTAjrLnf0kxEs2cMF8LW/fzuF/0UeVlsolxSUTP9T5vcYPDugOCv0x
	Rj3TszFUHrbNZooBqFsQjfMEnY7DkrMs2q1JOM8NLZ6bDBzie++NpoLfeiQ==
X-Gm-Gg: ASbGncvM/1QWv3B/5CdYwkoeUBhABERFRIwzYGSnMtWRBF78+EoD22WGHWFZsZgnUbo
	UMRT/izVChdKd/hdT3NBlzoWtiqMky9bVyyEwD7BRQusvG6x5uLFRd7BHlBfD3i8uATRop4+dom
	zgyRML9TpON3kaLDRAQZl48gAglXnubQhZ2IUpxK5WpNXjjoHsyhRsSZs8J05EQ3T2Ix0mAczHO
	LbJe3XrKkHCY9rHkvR1hm5+IVPc0j4049LvAeNeXXrJIinmrClbMREagepPNmgeycwrD+2OJLEL
	3bV7274YthhRTXDySnxuGZzGW3vrVx7/V7QZt4pCbmGSUaBd6UBRlwI3enF8yKsmcJ0P1IASLza
	g6e/qws/meDD8uuYCwRW8kixTaw==
X-Received: by 2002:a17:907:6e8f:b0:b6f:9da9:4b46 with SMTP id a640c23a62f3a-b72e056cc6dmr1342946066b.43.1762879331169;
        Tue, 11 Nov 2025 08:42:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUf5dsvwS2p2ABR6EtsAqkFw/UInERQfoM07boh+nqyhYAhq82UiKp7qk9Q6B5hNCxCfvAEA==
X-Received: by 2002:a17:907:6e8f:b0:b6f:9da9:4b46 with SMTP id a640c23a62f3a-b72e056cc6dmr1342941266b.43.1762879330657;
        Tue, 11 Nov 2025 08:42:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcea81sm1372306466b.13.2025.11.11.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 08:42:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3967532960F; Tue, 11 Nov 2025 17:42:07 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, Eric Dumazet
 <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki
 Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
In-Reply-To: <99ba3114-10a3-4df2-b49e-63ce8687836d@tu-berlin.de>
References: <20251013145416.829707-1-edumazet@google.com>
 <20251013145416.829707-6-edumazet@google.com> <877bw1ooa7.fsf@toke.dk>
 <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
 <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com>
 <CANn89iLQ3G6ffTN+=98+DDRhOzw8TNDqFd_YmYn168Qxyi4ucA@mail.gmail.com>
 <CANn89iLqUtGkgXj0BgrXJD8ckqrHkMriapKpwHNcMP06V_fAGQ@mail.gmail.com>
 <871pm7np2w.fsf@toke.dk>
 <ef601e55-16a0-4d3e-bd0d-536ed9dd29cd@tu-berlin.de>
 <CANn89iKDx52BnKZhw=hpCCG1dHtXOGx8pbynDoFRE0h_+a7JhQ@mail.gmail.com>
 <CANn89iKhPJZGWUBD0-szseVyU6-UpLWP11ZG0=bmqtpgVGpQaw@mail.gmail.com>
 <CANn89iL9XR=NA=_Bm-CkQh7KqOgC4f+pjCp+AiZ8B7zeiczcsA@mail.gmail.com>
 <87seemm8eb.fsf@toke.dk>
 <CANn89iLWsYDErNJNVhTOk7PfmMjV53kLa720RYXOBCu3gjvS=w@mail.gmail.com>
 <87ms4ulz7q.fsf@toke.dk>
 <CANn89i+dL6JUpbZgJ9DEGeVWpmrfv9q=Y_daFvHAPM4ZsjinQg@mail.gmail.com>
 <99ba3114-10a3-4df2-b49e-63ce8687836d@tu-berlin.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 11 Nov 2025 17:42:07 +0100
Message-ID: <87ms4sldwg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de> writes:

> On 11/10/25 18:34, Eric Dumazet wrote:
>> On Mon, Nov 10, 2025 at 6:49=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
>>> Eric Dumazet <edumazet@google.com> writes:
>>>
>>>> I can work on a patch today.
>>> This sounds like an excellent idea in any case - thanks! :)
>> The following (on top of my last series) seems to work for me
>>
>>   include/net/pkt_sched.h   |    5 +++--
>>   include/net/sch_generic.h |   24 +++++++++++++++++++++++-
>>   net/core/dev.c            |   33 +++++++++++++++++++--------------
>>   net/sched/sch_cake.c      |    4 +++-
>>   4 files changed, 48 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
>> index 4678db45832a1e3bf7b8a07756fb89ab868bd5d2..e703c507d0daa97ae7c3bf13=
1e322b1eafcc5664
>> 100644
>> --- a/include/net/pkt_sched.h
>> +++ b/include/net/pkt_sched.h
>> @@ -114,12 +114,13 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Q=
disc *q,
>>
>>   void __qdisc_run(struct Qdisc *q);
>>
>> -static inline void qdisc_run(struct Qdisc *q)
>> +static inline struct sk_buff *qdisc_run(struct Qdisc *q)
>>   {
>>          if (qdisc_run_begin(q)) {
>>                  __qdisc_run(q);
>> -               qdisc_run_end(q);
>> +               return qdisc_run_end(q);
>>          }
>> +       return NULL;
>>   }
>>
>>   extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>> index 79501499dafba56271b9ebd97a8f379ffdc83cac..19cd2bc13bdba48f941b1599=
f896c15c8c7860ae
>> 100644
>> --- a/include/net/sch_generic.h
>> +++ b/include/net/sch_generic.h
>> @@ -88,6 +88,8 @@ struct Qdisc {
>>   #define TCQ_F_INVISIBLE                0x80 /* invisible by default in=
 dump */
>>   #define TCQ_F_NOLOCK           0x100 /* qdisc does not require locking=
 */
>>   #define TCQ_F_OFFLOADED                0x200 /* qdisc is offloaded to =
HW */
>> +#define TCQ_F_DEQUEUE_DROPS    0x400 /* ->dequeue() can drop packets
>> in q->to_free */
>> +
>>          u32                     limit;
>>          const struct Qdisc_ops  *ops;
>>          struct qdisc_size_table __rcu *stab;
>> @@ -119,6 +121,8 @@ struct Qdisc {
>>
>>                  /* Note : we only change qstats.backlog in fast path. */
>>                  struct gnet_stats_queue qstats;
>> +
>> +               struct sk_buff          *to_free;
>>          __cacheline_group_end(Qdisc_write);
>>
>>
>> @@ -218,8 +222,15 @@ static inline bool qdisc_run_begin(struct Qdisc *qd=
isc)
>>          return true;
>>   }
>>
>> -static inline void qdisc_run_end(struct Qdisc *qdisc)
>> +static inline struct sk_buff *qdisc_run_end(struct Qdisc *qdisc)
>>   {
>> +       struct sk_buff *to_free =3D NULL;
>> +
>> +       if (qdisc->flags & TCQ_F_DEQUEUE_DROPS) {
>> +               to_free =3D qdisc->to_free;
>> +               if (to_free)
>> +                       qdisc->to_free =3D NULL;
>> +       }
>>          if (qdisc->flags & TCQ_F_NOLOCK) {
>>                  spin_unlock(&qdisc->seqlock);
>>
>> @@ -235,6 +246,7 @@ static inline void qdisc_run_end(struct Qdisc *qdisc)
>>          } else {
>>                  WRITE_ONCE(qdisc->running, false);
>>          }
>> +       return to_free;
>>   }
>>
>>   static inline bool qdisc_may_bulk(const struct Qdisc *qdisc)
>> @@ -1105,6 +1117,16 @@ static inline void tcf_set_drop_reason(const
>> struct sk_buff *skb,
>>          tc_skb_cb(skb)->drop_reason =3D reason;
>>   }
>>
>> +static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *=
skb,
>> +                                     enum skb_drop_reason reason)
>> +{
>> +       DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
>> +
>> +       tcf_set_drop_reason(skb, reason);
>> +       skb->next =3D q->to_free;
>> +       q->to_free =3D skb;
>> +}
>> +
>>   /* Instead of calling kfree_skb() while root qdisc lock is held,
>>    * queue the skb for future freeing at end of __dev_xmit_skb()
>>    */
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index ac994974e2a81889fcc0a2e664edcdb7cfd0496d..18cfcd765b1b3e4af1c5339e=
36df517e7abc914f
>> 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -4141,7 +4141,7 @@ static inline int __dev_xmit_skb(struct sk_buff
>> *skb, struct Qdisc *q,
>>                                   struct net_device *dev,
>>                                   struct netdev_queue *txq)
>>   {
>> -       struct sk_buff *next, *to_free =3D NULL;
>> +       struct sk_buff *next, *to_free =3D NULL, *to_free2 =3D NULL;
>>          spinlock_t *root_lock =3D qdisc_lock(q);
>>          struct llist_node *ll_list, *first_n;
>>          unsigned long defer_count =3D 0;
>> @@ -4160,9 +4160,9 @@ static inline int __dev_xmit_skb(struct sk_buff
>> *skb, struct Qdisc *q,
>>                          if (unlikely(!nolock_qdisc_is_empty(q))) {
>>                                  rc =3D dev_qdisc_enqueue(skb, q, &to_fr=
ee, txq);
>>                                  __qdisc_run(q);
>> -                               qdisc_run_end(q);
>> +                               to_free2 =3D qdisc_run_end(q);
>>
>> -                               goto no_lock_out;
>> +                               goto free_out;
>>                          }
>>
>>                          qdisc_bstats_cpu_update(q, skb);
>> @@ -4170,18 +4170,15 @@ static inline int __dev_xmit_skb(struct
>> sk_buff *skb, struct Qdisc *q,
>>                              !nolock_qdisc_is_empty(q))
>>                                  __qdisc_run(q);
>>
>> -                       qdisc_run_end(q);
>> -                       return NET_XMIT_SUCCESS;
>> +                       to_free2 =3D qdisc_run_end(q);
>> +                       rc =3D NET_XMIT_SUCCESS;
>> +                       goto free_out;
>>                  }
>>
>>                  rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
>> -               qdisc_run(q);
>> +               to_free2 =3D qdisc_run(q);
>>
>> -no_lock_out:
>> -               if (unlikely(to_free))
>> -                       kfree_skb_list_reason(to_free,
>> -                                             tcf_get_drop_reason(to_fre=
e));
>> -               return rc;
>> +               goto free_out;
>>          }
>>
>>          /* Open code llist_add(&skb->ll_node, &q->defer_list) + queue l=
imit.
>> @@ -4239,7 +4236,7 @@ static inline int __dev_xmit_skb(struct sk_buff
>> *skb, struct Qdisc *q,
>>                  qdisc_bstats_update(q, skb);
>>                  if (sch_direct_xmit(skb, q, dev, txq, root_lock, true))
>>                          __qdisc_run(q);
>> -               qdisc_run_end(q);
>> +               to_free2 =3D qdisc_run_end(q);
>>                  rc =3D NET_XMIT_SUCCESS;
>>          } else {
>>                  int count =3D 0;
>> @@ -4251,15 +4248,19 @@ static inline int __dev_xmit_skb(struct
>> sk_buff *skb, struct Qdisc *q,
>>                          rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
>>                          count++;
>>                  }
>> -               qdisc_run(q);
>> +               to_free2 =3D qdisc_run(q);
>>                  if (count !=3D 1)
>>                          rc =3D NET_XMIT_SUCCESS;
>>          }
>>   unlock:
>>          spin_unlock(root_lock);
>> +free_out:
>>          if (unlikely(to_free))
>>                  kfree_skb_list_reason(to_free,
>>                                        tcf_get_drop_reason(to_free));
>> +       if (unlikely(to_free2))
>> +               kfree_skb_list_reason(to_free2,
>> +                                     tcf_get_drop_reason(to_free2));
>>          return rc;
>>   }
>>
>> @@ -5741,6 +5742,7 @@ static __latent_entropy void net_tx_action(void)
>>          }
>>
>>          if (sd->output_queue) {
>> +               struct sk_buff *to_free;
>>                  struct Qdisc *head;
>>
>>                  local_irq_disable();
>> @@ -5780,9 +5782,12 @@ static __latent_entropy void net_tx_action(void)
>>                          }
>>
>>                          clear_bit(__QDISC_STATE_SCHED, &q->state);
>> -                       qdisc_run(q);
>> +                       to_free =3D qdisc_run(q);
>>                          if (root_lock)
>>                                  spin_unlock(root_lock);
>> +                       if (unlikely(to_free))
>> +                               kfree_skb_list_reason(to_free,
>> +                                             tcf_get_drop_reason(to_fre=
e));
>>                  }
>>
>>                  rcu_read_unlock();
>> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
>> index 312f5b000ffb67d74faf70f26d808e26315b4ab8..a717cc4e0606e80123ec9c76=
331d454dad699b69
>> 100644
>> --- a/net/sched/sch_cake.c
>> +++ b/net/sched/sch_cake.c
>> @@ -2183,7 +2183,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *=
sch)
>>                  b->tin_dropped++;
>>                  qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
>>                  qdisc_qstats_drop(sch);
>> -               kfree_skb_reason(skb, reason);
>> +               qdisc_dequeue_drop(sch, skb, reason);
>>                  if (q->rate_flags & CAKE_FLAG_INGRESS)
>>                          goto retry;
>>          }
>> @@ -2569,6 +2569,8 @@ static void cake_reconfigure(struct Qdisc *sch)
>>
>>          sch->flags &=3D ~TCQ_F_CAN_BYPASS;
>>
>> +       sch->flags |=3D TCQ_F_DEQUEUE_DROPS;
>> +
>>          q->buffer_limit =3D min(q->buffer_limit,
>>                                max(sch->limit * psched_mtu(qdisc_dev(sch=
)),
>>                                    q->buffer_config_limit));
>
> Thanks for the patches. I experimented with these patches and these are t=
he results:
> Running UDP flood (~21 Mpps load) over 2 minutes.
> pre-patch (baseline):
>  =C2=A0 cake achieves stable packet rate of 0.476 Mpps
>
>  =C2=A0 =C2=A0 qdisc cake 8001: dev enp7s0np1 root refcnt 33 bandwidth un=
limited
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 besteffort flows nonat nowash no-ack-filter =
split-gso rtt 100ms
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 noatm overhead 18 mpu 64
>  =C2=A0 =C2=A0 =C2=A0 Sent 3593552166 bytes 56149224 pkt (dropped 2183, o=
verlimits 0
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 requeues 311)
>  =C2=A0 =C2=A0 =C2=A0 backlog 0b 0p requeues 311
>  =C2=A0 =C2=A0 =C2=A0 memory used: 15503616b of 15140Kb
>
> net-next/main:
>  =C2=A0 cake throughput drops from 0.61 Mpps to 0.15 Mpps (the expected c=
ollapse
>  =C2=A0 we've seen before)
>
>  =C2=A0 =C2=A0 qdisc cake 8001: dev enp7s0np1 root refcnt 33 bandwidth un=
limited
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 besteffort flows nonat nowash no-ack-filter =
split-gso rtt 100ms
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 noatm overhead 18 mpu 64
>  =C2=A0 =C2=A0 =C2=A0 Sent 1166199994 bytes 18221827 pkt (dropped 7131777=
3, overlimits 0
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 requeues 1914)
>  =C2=A0 =C2=A0 =C2=A0 backlog 0b 0p requeues 1914
>  =C2=A0 =C2=A0 =C2=A0 memory used: 15504576b of 15140Kb
>
> net-next/main + this dequeue patch:
>  =C2=A0 cake throughput drops in the first 6 seconds from 0.65 Mpps  and =
then
>    oscillates between=C2=A00.27=E2=80=930.36 Mpps
>
>  =C2=A0 =C2=A0 qdisc cake 8001: dev enp7s0np1 root refcnt 33 bandwidth un=
limited
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 besteffort flows nonat nowash no-ack-filter =
split-gso rtt 100ms
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 noatm overhead 18 mpu 64
>  =C2=A0 =C2=A0 =C2=A0 Sent 2627464378 bytes 41054083 pkt (dropped 5010210=
8, overlimits 0
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 requeues 1008)
>  =C2=A0 =C2=A0 =C2=A0 backlog 0b 0p requeues 1008
>  =C2=A0 =C2=A0 =C2=A0 memory used: 15503616b of 15140Kb
>
> net-next/main + this dequeue patch + limiting the number of deferred pack=
ets:
>  =C2=A0 cake throughput drops in the first 6 seconds from 0.65 Mpps  and =
then
>    oscillates between=C2=A00.35=E2=80=930.43 Mpps
>
>  =C2=A0 =C2=A0 qdisc cake 8001: dev enp7s0np1 root refcnt 33 bandwidth un=
limited
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 besteffort flows nonat nowash no-ack-filter =
split-gso rtt 100ms
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 noatm overhead 18 mpu 64
>  =C2=A0 =C2=A0 =C2=A0 Sent 2969529126 bytes 46398843 pkt (dropped 4361891=
9, overlimits 0
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 requeues 814)
>  =C2=A0 =C2=A0 =C2=A0 backlog 0b 0p requeues 814
>  =C2=A0 =C2=A0 =C2=A0 memory used: 15503616b of 15140Kb
>
> I can provide the full throughput traces if needed.
> So the last patches definitely mitigate cake's performance degradation.

I also did a series of test runs with the variant in Eric's v2 patch set
that includes the dequeue side improvement, and it definitely helps, to
the point where I can now get up to 50% higher PPS with a cake instance
serving multiple flows.

However, it's unstable: if I add enough flows I end up back in a state
where throughput collapses to a dozen Kpps. The exact number of flows
where this happens varies a bit, but it's quite distinct when it does.

The number of flows it takes before things break down varies a bit; I
have not found a definite cause for this yet, but I'll keep looking.

-Toke

[0] https://lore.kernel.org/r/20251111093204.1432437-1-edumazet@google.com


