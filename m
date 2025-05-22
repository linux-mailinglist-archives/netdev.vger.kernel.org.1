Return-Path: <netdev+bounces-192671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FD7AC0C8A
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6882C9E6CAE
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA29728B40E;
	Thu, 22 May 2025 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjfADYlM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37827274FD3
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919865; cv=none; b=P9bKFRmSi1vAH7Gt71p6ZMiW3DbhEeumR9FeidvtDp1R4mULmTE2MwQnXnRcvlZW0ozBp8Ut/Q7vsTxokQPliu242LSOHqRoxb05+y8gPe7Kvyvp02Lx1uKh9t0NQi96l3/sAJtfEyQ+wagVgchMf1la1vyq+ak9cgOq7q/U+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919865; c=relaxed/simple;
	bh=hsA9wqAd1ucAxNTa/fcFMGcI7cI9PQ766zwolOibG6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Af5VPWR/C+mtKMzU9Un5DNK5VPLSUf2frftSMNytLUhVe9cKE6XC+c7/rSv3k2nmFaCvBzW9uK0hsRgs0QIVj/HgGyMoNpUidLGojegZ0kNsmYsWhn7j8KXg1QgOTAjzEClp+N8TsXFsUb3Gwm5jAiR1aEeurqP76IYF7K/k9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjfADYlM; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476af5479feso85282231cf.2
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747919863; x=1748524663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G66T9zee0WlVxxJ/q383i5uTLYKxN4hquv3ll5INKI=;
        b=qjfADYlMPEey1NQE8Ssuq6i6BtPsPuj2/qha207Se9Im0GF5sYMPQQne8e/iW8edNH
         YPR8srs3bXfRpylDn6oXRDMflIflIZwpNVYj4GEvwbzuT54DwJIz8hqdMSvbOvaF9VHg
         noLCkbktpk90klOmP7B2RN4hH/dhCPU+rRvThXgAboBP/kN6AcD+HocoIv7+K4i9CbJT
         p4AIWYjJQJuCvG6VLm//Yvaq+3C8BxEZWAulV2AWEtR7mKDpqoinP/umGNugnzd+hdJw
         M+MQhyvM89Rw5l0YibwYj4AGy6KVLKB1bBj7DXqqPYL/fIrUxrbxaw+QeMMJiy16CtkP
         w8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747919863; x=1748524663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G66T9zee0WlVxxJ/q383i5uTLYKxN4hquv3ll5INKI=;
        b=HNWiJQU9BUuvOhdJORR1W631hGJDGbhr3xItWltR+0Tn4hi99Sg11c3rjDSeCmMaiJ
         D1MqsBAylotFqJKtnc9ohKx6cajYP3shgCfHJMSjA15lJStkr1scAGgG0QvHk9ghta4c
         38KeVfgB98NEOMbV4tjj07Bxb0CHr4/LWnKon1Mgd0jx39xuIsiuD0uO+ymR2DBN4c3G
         MJMT0oBJDMKqmEdYrHSHtm8pLPKbesXcwmBke0tt7rVckYawN3IPcWceoptA0E+HZUPE
         WXSrUC0Gk5OIxOCN9Pa0OXT4FcLAy/W+BeENnFoMao2xuxnwlNNnCtR2cTOfgFKtK1jR
         VBRQ==
X-Gm-Message-State: AOJu0Yw8YYmeQN21duakSf9dCdivyk7Lh5Lj5YzYrkztBITxT2/bZbTj
	EaN03fsZgK6HqlE6JwLna2EJTwHAusRSMaazh7a7rJMBG4Lth2orGqbNyXkSRyGUnd2lpn3TIC7
	BdWCzKJJ7lXRRkw5edLZsUOSY0ydjM0DeiYFGQXeBqfoYrQVy8G3wmORo
X-Gm-Gg: ASbGncue0C7gOW+lKLJsdqTwqJjObD0wRBUKjGdWyW8elvtD4Q2uhHRx2Mf6qGAQYEv
	OFSxIGuUijpPflH8Wm+8l+BFdVZNC6NVnkKSsTl1G30lSpgQBZwCOjjVGDBoqOQsZMF7obUCBmY
	Xtc0GFDN6bDKu5efSQ736nRwRhsAwN4iGWAniMzbFU
X-Google-Smtp-Source: AGHT+IEWpgpqJdsRF9ih3zjdIFzfAfQPzFsJhbg+0ImDYAHYTWECYya6OB1vp1qJrCa5S83y4Y5NyGT7qtn1GtJ3AMM=
X-Received: by 2002:ac8:5c94:0:b0:476:9e28:ce49 with SMTP id
 d75a77b69052e-494b095de5fmr447616781cf.43.1747919862788; Thu, 22 May 2025
 06:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521205351.1395206-1-pctammela@mojatatu.com>
In-Reply-To: <20250521205351.1395206-1-pctammela@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 May 2025 06:17:31 -0700
X-Gm-Features: AX0GCFthkaxFkEvA5NoRo371_b0nf24E5zDimXyAeDstgdQGBtiCdw3SdOdXAV0
Message-ID: <CANn89iKhivLw7e1YQsZORXZuSUqnTD8830K=X6=5h8vvogZ-uQ@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: hfsc: Address reentrant enqueue adding
 class to eltree twice
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, Savy <savy@syst3mfailure.io>, Will <will@willsroot.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 1:54=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> Savy says:
>     "We are writing to report that this recent patch
>     (141d34391abbb315d68556b7c67ad97885407547) [1]
>     can be bypassed, and a UAF can still occur when HFSC is utilized with
>     NETEM.
>
>     The patch only checks the cl->cl_nactive field to determine whether
>     it is the first insertion or not [2], but this field is only
>     incremented by init_vf [3].
>
>     By using HFSC_RSC (which uses init_ed) [4], it is possible to bypass =
the
>     check and insert the class twice in the eltree.
>     Under normal conditions, this would lead to an infinite loop in
>     hfsc_dequeue for the reasons we already explained in this report [5].
>
>     However, if TBF is added as root qdisc and it is configured with a
>     very low rate,
>     it can be utilized to prevent packets from being dequeued.
>     This behavior can be exploited to perform subsequent insertions in th=
e
>     HFSC eltree and cause a UAF."
>
> To fix both the UAF and the inifinite loop, with netem as an hfsc child,
> check explicitly in hfsc_enqueue whether the class is already in the eltr=
ee
> whenever the HFSC_RSC flag is set.
>
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D141d34391abbb315d68556b7c67ad97885407547
> [2] https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.=
c#L1572
> [3] https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.=
c#L677
> [4] https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.=
c#L1574
> [5] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilx=
sEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@wi=
llsroot.io/T/#u
>
> Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdisc=
s")
> Reported-by: Savy <savy@syst3mfailure.io>
> Reported-by: Will <will@willsroot.io>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  net/sched/sch_hfsc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index cb8c525ea..1c4067bec 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -175,6 +175,11 @@ struct hfsc_sched {
>
>  #define        HT_INFINITY     0xffffffffffffffffULL   /* infinite time =
value */
>
> +static bool cl_in_el_or_vttree(struct hfsc_class *cl)
> +{
> +       return ((cl->cl_flags & HFSC_FSC) && cl->cl_nactive) ||
> +               ((cl->cl_flags & HFSC_RSC) && !RB_EMPTY_NODE(&cl->el_node=
));
> +}
>
>  /*
>   * eligible tree holds backlogged classes being sorted by their eligible=
 times.
> @@ -1089,6 +1094,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u=
32 parentid,
>                 qdisc_purge_queue(parent->qdisc);
>         hfsc_adjust_levels(parent);
>         sch_tree_unlock(sch);
> +       RB_CLEAR_NODE(&cl->el_node);

Is it safe doing this operation without qdisc lock held ?

I would perform this operation sooner (around line 1043).

>
>         qdisc_class_hash_grow(sch, &q->clhash);
>
> @@ -1569,7 +1575,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch=
, struct sk_buff **to_free)
>                 return err;
>         }
>
> -       if (first && !cl->cl_nactive) {
> +       if (first && !cl_in_el_or_vttree(cl)) {
>                 if (cl->cl_flags & HFSC_RSC)
>                         init_ed(cl, len);
>                 if (cl->cl_flags & HFSC_FSC)
> --
> 2.43.0
>

