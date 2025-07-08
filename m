Return-Path: <netdev+bounces-205109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62942AFD6B6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 20:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F511C2040C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E262E266B;
	Tue,  8 Jul 2025 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vwc677cZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9812DFF2E
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000624; cv=none; b=WI/q2jCD8omFd0b91qy5VodKY4fmlNG581Ac08gRiicV1Z9soiUhCo4Cp86K4dUjO5bPNoY/8kGEqpOZg1dvxS/wEous7HPUpiklHE4fxAxlpDYqUiunC4Rt8CfjMV7dYOQb1g4dtS/IBoOPXkj2mcnbyOtQ3LoW7TH3+Z4rdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000624; c=relaxed/simple;
	bh=9HxWJqHT9FN9BzCRLaRYdlMRRGWtCYNO2daX30sv49Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUJrJ1vCOYH7002b/vekL9OvwdfibFra8P3fOZ8lUn9Nnh5TqxQ/EYvQUoTvpWrpVP/C3AcNHanhSUhQST0jbvdQYJ3kYEGawGCS+nOQPgU6hqLfh0iF5BULFhbKm/XNtukc0v+/qbJDU7cLbODaPu44iTzTgNWk3oc7Sn1I3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=vwc677cZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so4203208b3a.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 11:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1752000622; x=1752605422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Muy8WUBD0m7A3Mb9SG99jx7LlhEhh7RdDHtxo6VshJA=;
        b=vwc677cZdxTJgnHHcF2I2Gw8B8R3TQTgq/9rR6hfiY8sCTFHDNrLEKT6+7P/PiVuGW
         TkrJfwBV/XqrBn6zd3E9kWg947gdNGL3BPQbH+h05xN266RxRu6vvOHE62IyMgcuD1q4
         9i6+VpulEVHz0TBkdeQ+exrSO9tLOrU0ApTWv94Xpn5EtFEY9a23QWG+AFrwxL9pJtLf
         2duRGVtUcUz9v8Sg/Hre5Ng+vrF5DftfA6lsj9ZhbZhRtp1UOs4lLOrpTc3oehJWwNKa
         nh3A6cPh0w8j6EnjBqx6HgqQMY4ZvFmdFuEvoVEUamuLgeRx2v6QmYwnzc9ztiHLF0Mv
         Zl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752000622; x=1752605422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Muy8WUBD0m7A3Mb9SG99jx7LlhEhh7RdDHtxo6VshJA=;
        b=nSMLhXgMPOkZrSMhMl01wKO8iMfRcB292Xofy7c6g7sBM077Xzkx5ZFqwmEAqWendi
         knLE2dvy2KE4bckXkrtuYY6gVSStlBvZe/qCylBEYXn+R70P6wJGnutnGAQO+h5gY/SA
         R4jeJkUvL83jAy33C2qyvvxipOgndXK/pv0mzLJR9wE0g3JWKENNz99rDW+CHt9jZFI1
         itxCBYvVRw64Kn6xnqXykP76EAadDCcr2b1c4k+Umq8Y2sRAsTgHouMlev7wUB7QXYER
         yvgg7SZsD2c3PXEy5LAxyzDJRLQhIF0PviCZqGjAn4lAQV/gqbfhjSqLcV7JG7syQIpx
         KXLg==
X-Gm-Message-State: AOJu0YxVaA/+7VAWO9LSS79rtQlZfbwS7A9Lx3Zux6bRlMsTZEQI6UN7
	POCBdxQ/sXp/9Mg/7iwNiVlYsJkSOxcbg27iTL5n0th2GA61pgE0dHmDqsIurnO36Bdvpd4VKb8
	Pilvl0tgzJhoODxNMU/Qv/39JEZ07szO+bUzB9MfB
X-Gm-Gg: ASbGncsW+/EHt5w/PL8YmixyYUt3njvUQbeXfK6AlHPN60e/7K1MGImZZizacxlFbw1
	Au9/j5M8Rb031hHO7rZOyxcjICtQ+Qd9t5kbAaF9QNSy2iu5fvAgLmFRsI6SWkQt42lvvdiU2Mi
	f5u/pqkZCMOnJwrdTjn0HHJ7OmA/d9Gp0+AVXxo6fXUo7COjPbPY/k
X-Google-Smtp-Source: AGHT+IFKNwhSvpz/mOzq+MBlxZzCgErWgoggMVNzOcpu0XC3sUt+2qWAsuDmG7INVfSUjV1SLlwNzn5LTp6cL+NroWw=
X-Received: by 2002:a05:6a00:3923:b0:748:3964:6177 with SMTP id
 d2e1a72fcca58-74e4ab8f91emr623530b3a.19.1752000621945; Tue, 08 Jul 2025
 11:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708164141.875402-1-will@willsroot.io>
In-Reply-To: <20250708164141.875402-1-will@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 8 Jul 2025 14:50:11 -0400
X-Gm-Features: Ac12FXwJ0Ggu4JmVSpWv4PvNr2yFD7cl08t-ymUM1BFMaZ6oXo2Sap_Da-jmt4U
Message-ID: <CAM0EoMkm9VHbgMW7E07rrc37__2ViXJb=AMLwuCfG2jhcB75=Q@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, victor@mojatatu.com, 
	pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, 
	stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 12:43=E2=80=AFPM William Liu <will@willsroot.io> wro=
te:
>
> netem_enqueue's duplication prevention logic breaks when a netem
> resides in a qdisc tree with other netems - this can lead to a
> soft lockup and OOM loop in netem_dequeue, as seen in [1].
> Ensure that a duplicating netem cannot exist in a tree with other
> netems.
>
> Previous approaches suggested in discussions in chronological order:
>
> 1) Track duplication status or ttl in the sk_buff struct. Considered
> too specific a use case to extend such a struct, though this would
> be a resilient fix and address other previous and potential future
> DOS bugs like the one described in loopy fun [2].
>
> 2) Restrict netem_enqueue recursion depth like in act_mirred with a
> per cpu variable. However, netem_dequeue can call enqueue on its
> child, and the depth restriction could be bypassed if the child is a
> netem.
>
> 3) Use the same approach as in 2, but add metadata in netem_skb_cb
> to handle the netem_dequeue case and track a packet's involvement
> in duplication. This is an overly complex approach, and Jamal
> notes that the skb cb can be overwritten to circumvent this
> safeguard.
>
> 4) Prevent the addition of a netem to a qdisc tree if its ancestral
> path contains a netem. However, filters and actions can cause a
> packet to change paths when re-enqueued to the root from netem
> duplication, leading us to the current solution: prevent a
> duplicating netem from inhabiting the same tree as other netems.
>
> [1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilx=
sEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@wi=
llsroot.io/
> [2] https://lwn.net/Articles/719297/
>
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Reported-by: William Liu <will@willsroot.io>
> Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> Signed-off-by: William Liu <will@willsroot.io>
> Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> v4 -> v5: no changes, reposting per Jakub's request
> v3 -> v4:
>   - Clarify changelog with chronological order of attempted solutions
> v2 -> v3:
>   - Clarify reasoning for approach in changelog
>   - Removed has_duplication
> v1 -> v2:
>   - Renamed only_duplicating to duplicates and invert logic for clarity
> ---
>  net/sched/sch_netem.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..eafc316ae319 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -973,6 +973,41 @@ static int parse_attr(struct nlattr *tb[], int maxty=
pe, struct nlattr *nla,
>         return 0;
>  }
>
> +static const struct Qdisc_class_ops netem_class_ops;
> +
> +static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
> +                              struct netlink_ext_ack *extack)
> +{
> +       struct Qdisc *root, *q;
> +       unsigned int i;
> +
> +       root =3D qdisc_root_sleeping(sch);
> +
> +       if (sch !=3D root && root->ops->cl_ops =3D=3D &netem_class_ops) {
> +               if (duplicates ||
> +                   ((struct netem_sched_data *)qdisc_priv(root))->duplic=
ate)
> +                       goto err;
> +       }
> +
> +       if (!qdisc_dev(root))
> +               return 0;
> +
> +       hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
> +               if (sch !=3D q && q->ops->cl_ops =3D=3D &netem_class_ops)=
 {
> +                       if (duplicates ||
> +                           ((struct netem_sched_data *)qdisc_priv(q))->d=
uplicate)
> +                               goto err;
> +               }
> +       }
> +
> +       return 0;
> +
> +err:
> +       NL_SET_ERR_MSG(extack,
> +                      "netem: cannot mix duplicating netems with other n=
etems in tree");
> +       return -EINVAL;
> +}
> +
>  /* Parse netlink message to set options */
>  static int netem_change(struct Qdisc *sch, struct nlattr *opt,
>                         struct netlink_ext_ack *extack)
> @@ -1031,6 +1066,11 @@ static int netem_change(struct Qdisc *sch, struct =
nlattr *opt,
>         q->gap =3D qopt->gap;
>         q->counter =3D 0;
>         q->loss =3D qopt->loss;
> +
> +       ret =3D check_netem_in_tree(sch, qopt->duplicate, extack);
> +       if (ret)
> +               goto unlock;
> +
>         q->duplicate =3D qopt->duplicate;
>
>         /* for compatibility with earlier versions.
> --
> 2.43.0
>
>

