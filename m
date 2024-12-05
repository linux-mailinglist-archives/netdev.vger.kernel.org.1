Return-Path: <netdev+bounces-149381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAEA9E55A8
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2CD18834C0
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB78218837;
	Thu,  5 Dec 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Z4wio/5U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E938217F3A
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402432; cv=none; b=L3XDjU03Kcki+UgiML3xjfZS0I1JInOO87EmYDiOxodjU4rYbR14unpWCVXR+KL07JiMj0wFmaTbqJNFjdg4bjAzlk8TXOpChortnl5cymHMtckG96VwKiVrXYlgDHiBma/r2iX38XPkPrqtGZmRtOK9C9PAr+WCjsvr0Qeh5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402432; c=relaxed/simple;
	bh=8teM+tYFKC3gz+lI+q7ZDVC3v8srrnlmFPP4pk5HH+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jz3JmVqDtLuRMJKU1pXEECr77dAUc5kYAg6GCwMQLHGXjfuHwVF6OR2/7g3JPEzGHy39hsc2eI9KP7bQ/l+BpR4kk22BSMtaSct4JTyBzYn2CRbOM1buD06T6sJcxLpLlG+cvqhnpS5hTu2vXDI7Yex3zGvL+Slh3MKU0lZq9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Z4wio/5U; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so730981a12.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 04:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1733402429; x=1734007229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3Rr39nApyxiB7ik1EiA3DIS+dkPqrRM18nbLw6gT9E=;
        b=Z4wio/5U5p3+5wYKFSuAv0BRP4K47pAIeKdBsLZssXbWmxS/zc7kGiVt9a7b30kU87
         z5xqA0eBAdvrSvuY475wSeT7x+vmnvN5ddgpwzk5z/WewypGun5ATitI3UOC/c39MVhX
         fFuPpmYuS/iPlRk8BBuxETl+2fdPKMP8K+dfMkXjX7RbOAksnH1N8RZ2JkY+vSFmCYAF
         gD9M1TkNF8oJZcu1hUk2tBJ31B3uCb850KEDyR/t3UZv/t0Qa3CPJX37Jv298HidR76R
         Sjbwllm39ftGdrHx5bOIl7EGt5CJC7Qvhy3ABmszmihhvz5H9qEY+pIx9tLS9AN94Zx5
         eNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733402429; x=1734007229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3Rr39nApyxiB7ik1EiA3DIS+dkPqrRM18nbLw6gT9E=;
        b=P1S3RDgTQPtj9Wn1yBlGLQXZKYDMEsR3ZeUB6rTvGFQ9ucggmHe0xww0wkSm5b8ywz
         Nzq2sY7HBq0o5a0HmjDolC1r8x8p35eSxQUzmJZuYdg8FHg2ZBg9UFfgFW87xL/Mwg1V
         chpKEY2vBNYsMfkRIl9G12T3liIwnDtcvdXXCnL6M5vZEMFsanlr8mGNhVv8IuL+CkJs
         kYcQVVWofrPOu9LRJOBm8iCOIas3aQG1xcaH7aQf3RHb2TcFqHbtLSHHUoLHpt5BUdAh
         Y1JrZCxdKBkyaxGPGEvEGocmv2T/IeEzL2kSbe4zhclvBsiN22RcwX8A4oBSGQH2VADG
         tB8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUblciiaFdI2wwdO9V+F8AbQluf/R3vw8zwIgOTmvZOKllQTNGzai1nQvKo6RJIzks0il6ynoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8qkjG6wLwRcKDatXxBb5gqpCO46n8Yolbx+hM4LrD+UYZVTb
	c6FGEhFimPkxj32BCcIEcVN8OmL97IaGQ3FKGFTrqS6G0rrSyj3hM7zd0kPcYWUS3BtCdI+4k/t
	ttyTdjzuEx5xNWnH7PmnErE6lUFZ7wnCxqrBg
X-Gm-Gg: ASbGncvhQEkEU4/QLwIJspWPpFWCZjOigbuqCV7ftDSz8XL6qpO3FEe5N7dvTJT1Tc8
	mFUl3TthypuocrdGgaAsjp7b48jLB0w==
X-Google-Smtp-Source: AGHT+IE0sx1c3w3bHsB7XeDnk6EsrFSpfu/VUPUGIjz9glqTFeQY3gehshIFrU8Snd0DouWY3r5xw5RRlhOvpqyCX9w=
X-Received: by 2002:a05:6a20:7485:b0:1d9:2ba5:912b with SMTP id
 adf61e73a8af0-1e1653f3db9mr15920950637.36.1733402429294; Thu, 05 Dec 2024
 04:40:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202191312.3d3c8097@kernel.org> <20241204122929.3492005-1-martin.ottens@fau.de>
In-Reply-To: <20241204122929.3492005-1-martin.ottens@fau.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 5 Dec 2024 07:40:17 -0500
Message-ID: <CAM0EoMnTTQ-BtS0EBqB-5yNAAmvk9r67oX7n7S0Ywhc23s49EQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: netem: account for backlog updates from
 child qdisc
To: Martin Ottens <martin.ottens@fau.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 7:29=E2=80=AFAM Martin Ottens <martin.ottens@fau.de>=
 wrote:
>
> In general, 'qlen' of any classful qdisc should keep track of the
> number of packets that the qdisc itself and all of its children holds.
> In case of netem, 'qlen' only accounts for the packets in its internal
> tfifo. When netem is used with a child qdisc, the child qdisc can use
> 'qdisc_tree_reduce_backlog' to inform its parent, netem, about created
> or dropped SKBs. This function updates 'qlen' and the backlog statistics
> of netem, but netem does not account for changes made by a child qdisc.
> 'qlen' then indicates the wrong number of packets in the tfifo.
> If a child qdisc creates new SKBs during enqueue and informs its parent
> about this, netem's 'qlen' value is increased. When netem dequeues the
> newly created SKBs from the child, the 'qlen' in netem is not updated.
> If 'qlen' reaches the configured sch->limit, the enqueue function stops
> working, even though the tfifo is not full.
>
> Reproduce the bug:
> Ensure that the sender machine has GSO enabled. Configure netem as root
> qdisc and tbf as its child on the outgoing interface of the machine
> as follows:
> $ tc qdisc add dev <oif> root handle 1: netem delay 100ms limit 100
> $ tc qdisc add dev <oif> parent 1:0 tbf rate 50Mbit burst 1542 latency 50=
ms
>
> Send bulk TCP traffic out via this interface, e.g., by running an iPerf3
> client on the machine. Check the qdisc statistics:
> $ tc -s qdisc show dev <oif>
>
> tbf segments the GSO SKBs (tbf_segment) and updates the netem's 'qlen'.
> The interface fully stops transferring packets and "locks". In this case,
> the child qdisc and tfifo are empty, but 'qlen' indicates the tfifo is at
> its limit and no more packets are accepted.
>

Would be nice to see the before and after (your change) output of the
stats to illustrate

> This patch adds a counter for the entries in the tfifo. Netem's 'qlen' is
> only decreased when a packet is returned by its dequeue function, and not
> during enqueuing into the child qdisc. External updates to 'qlen' are thu=
s
> accounted for and only the behavior of the backlog statistics changes. As
> in other qdiscs, 'qlen' then keeps track of  how many packets are held in
> netem and all of its children. As before, sch->limit remains as the
> maximum number of packets in the tfifo. The same applies to netem's
> backlog statistics.
> (Note: the 'backlog' byte-statistic of netem is incorrect in the example
> above even after the patch is applied due to a bug in tbf. See my
> previous patch ([PATCH] net/sched: tbf: correct backlog statistic for
> GSO packets)).
>
> Signed-off-by: Martin Ottens <martin.ottens@fau.de>

Fixes missing - probably since 2.6.x. Stephen?

Your fix seems reasonable but I am curious: does this only happen with
TCP? If yes, perhaps the
GSO handling maybe contributing?
Can you run iperf with udp and see if the issue shows up again? Or
ping -f with size 1024.
You can slow down tbf for example with something like: tbf rate 20kbit
buffer 1600 limit 3000

cheers,
jamal


> ---
>  net/sched/sch_netem.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fe6fed291a7b..71ec9986ed37 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -79,6 +79,8 @@ struct netem_sched_data {
>         struct sk_buff  *t_head;
>         struct sk_buff  *t_tail;
>
> +       u32 t_len;
> +
>         /* optional qdisc for classful handling (NULL at netem init) */
>         struct Qdisc    *qdisc;
>
> @@ -383,6 +385,7 @@ static void tfifo_reset(struct Qdisc *sch)
>         rtnl_kfree_skbs(q->t_head, q->t_tail);
>         q->t_head =3D NULL;
>         q->t_tail =3D NULL;
> +       q->t_len =3D 0;
>  }
>
>  static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
> @@ -412,6 +415,7 @@ static void tfifo_enqueue(struct sk_buff *nskb, struc=
t Qdisc *sch)
>                 rb_link_node(&nskb->rbnode, parent, p);
>                 rb_insert_color(&nskb->rbnode, &q->t_root);
>         }
> +       q->t_len++;
>         sch->q.qlen++;
>  }
>
> @@ -518,7 +522,7 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
>                         1<<get_random_u32_below(8);
>         }
>
> -       if (unlikely(sch->q.qlen >=3D sch->limit)) {
> +       if (unlikely(q->t_len >=3D sch->limit)) {
>                 /* re-link segs, so that qdisc_drop_all() frees them all =
*/
>                 skb->next =3D segs;
>                 qdisc_drop_all(skb, sch, to_free);
> @@ -702,8 +706,8 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sc=
h)
>  tfifo_dequeue:
>         skb =3D __qdisc_dequeue_head(&sch->q);
>         if (skb) {
> -               qdisc_qstats_backlog_dec(sch, skb);
>  deliver:
> +               qdisc_qstats_backlog_dec(sch, skb);
>                 qdisc_bstats_update(sch, skb);
>                 return skb;
>         }
> @@ -719,8 +723,7 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sc=
h)
>
>                 if (time_to_send <=3D now && q->slot.slot_next <=3D now) =
{
>                         netem_erase_head(q, skb);
> -                       sch->q.qlen--;
> -                       qdisc_qstats_backlog_dec(sch, skb);
> +                       q->t_len--;
>                         skb->next =3D NULL;
>                         skb->prev =3D NULL;
>                         /* skb->dev shares skb->rbnode area,
> @@ -747,16 +750,21 @@ static struct sk_buff *netem_dequeue(struct Qdisc *=
sch)
>                                         if (net_xmit_drop_count(err))
>                                                 qdisc_qstats_drop(sch);
>                                         qdisc_tree_reduce_backlog(sch, 1,=
 pkt_len);
> +                                       sch->qstats.backlog -=3D pkt_len;
> +                                       sch->q.qlen--;
>                                 }
>                                 goto tfifo_dequeue;
>                         }
> +                       sch->q.qlen--;
>                         goto deliver;
>                 }
>
>                 if (q->qdisc) {
>                         skb =3D q->qdisc->ops->dequeue(q->qdisc);
> -                       if (skb)
> +                       if (skb) {
> +                               sch->q.qlen--;
>                                 goto deliver;
> +                       }
>                 }
>
>                 qdisc_watchdog_schedule_ns(&q->watchdog,
> @@ -766,8 +774,10 @@ static struct sk_buff *netem_dequeue(struct Qdisc *s=
ch)
>
>         if (q->qdisc) {
>                 skb =3D q->qdisc->ops->dequeue(q->qdisc);
> -               if (skb)
> +               if (skb) {
> +                       sch->q.qlen--;
>                         goto deliver;
> +               }
>         }
>         return NULL;
>  }
> --
> 2.39.5
>

