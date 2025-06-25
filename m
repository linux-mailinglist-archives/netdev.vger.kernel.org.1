Return-Path: <netdev+bounces-201184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E444AE8581
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F3816A1C5
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD1F264A77;
	Wed, 25 Jun 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="SItyvB5H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862C2869E
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860193; cv=none; b=hAuQ8bunMBgrqnjwQPSDDD+7iAvE7AUGWqqcYKLP9JLPqLLef3Noaff7OM2xxBVnnIOTPNwz8fGdQGnUTuGEz+/UTj3N90H+pkOlu+xdTLzHWYVZsXgyQ3wa5oYFhpglEAS9vGwjpzGiJexZEo+BPEVpWZWjpRrU3qX+4xn9GlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860193; c=relaxed/simple;
	bh=QPuLvV1ipLVWy2JE1H+AdJDs/yFB16ymVVD0N+TO7Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlEakhzNifH/pgtQ2mAZI1XGWPO6+xJQu//qYdwI9g8qUVEfPRNV8Y3VWlmNkeED1KmxxapR6IMiTWakaFRJZtjyZXCcNiUgblXMdjvbZvSpKmrzzEDTPz5qm0OMnjztrXeOjkmZLr7Q3M/SWT9NRI7DniygLFg+Qds4liPbQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=SItyvB5H; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so2089193a12.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1750860189; x=1751464989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msdV/0BC0fr/e03nLfudvaJmHbDNFn4BvnRHsf9Y1b4=;
        b=SItyvB5H9WgPdPuuA9JReugasdPPFH1RTLFzrjgmDuEw7FXR8sgnWM33atIl6jCsJm
         OpFCgW0rJKTemYv9jtWFCkxMESTReA2k+drHup05X3oe9D00GTB+dnsUBhbVaan93by1
         LU5I9rXANExBKZNYSUkVpcmN8vGDrCZxDXN077A4e16Fd1K0ekw6P0Wfokkyf2/NTlXB
         NHxiAbsZh+i5uge0o2yQStUtAd67PECXcGLYCZEsa9pJx63GWLvTvXJOrAiMHnyToPI1
         v0PTLEVvrEf5w16KDnMbUZfgtIH7vBYAXCK/ztWxnSkJuf4b8QnmzMTfSVOimtS2uHdJ
         4XQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750860189; x=1751464989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msdV/0BC0fr/e03nLfudvaJmHbDNFn4BvnRHsf9Y1b4=;
        b=wdsIgcf/BzhMaDf5bMmWqChBvcOZxjwQCcyn1+s9udqduzMDv26NOiJeSFbiQPq5j/
         9aTtB9b8nRAhuYpZRqvriWLpFPsjIK0s+8eMvFykeSL2N5uA7DouWXynVDVKbOzN/iFE
         edhqHZ78de497eLeo4kjhEB1NiO7tQezFJIGKdGQm+x+FEoxLRNNiacrEMYR7SWAywjO
         JY+ZGA+qgPiPSMUq4N0CxdXn14gG+LINKz3Xf9UJpEV+L7M++VTum2ZF0O0Jb2EfkYdy
         BdIOM0xlwdgHJI2xIdldfOtGHNBkfd5vicPBUJwJspfts/9W0n6lnY+sPoGWwUgIavwQ
         2ZdA==
X-Gm-Message-State: AOJu0Yz4y6GKwgi6ecY4+2Y5Nk7NM3s0Lv9G3+9osUXa5sErI35RyCOU
	nCeyVzCBXBvMmWmmb1FGMRZFbUr2/WU7wtp8oGMJ1+oAUZkVs0P+ncPjY/ddlGzURjgnHcmtRbg
	bw5GLHWm6b9fgAIBJ0IyJCOcMcm8P2cPz42XZx1/r
X-Gm-Gg: ASbGncvX1l5Er6wHKCB9bGbMJ80E2NLVCpiGDdsLDb/2MlY7oLzCCBmdk1fEeIMks4v
	8BGNcx7JdQKgi7LXP8K49GhdN3ghGYGCuTnOBQz3lAqw3aDeXk5VM3z7AS5YO8xmkJQyBu4fvJG
	23qqSXtlXkWzDBRX6PZOiz2jCf1qBpnRkjNdAiSE3cZQ==
X-Google-Smtp-Source: AGHT+IHcISAn2cr6X08eWdlQLc0T8r0NsAsIajNP7cgaCIo0pbpERfHesspTRk9aO//lp41tTAdPyrIXCswvWkDVhK8=
X-Received: by 2002:a17:90b:17c3:b0:311:da03:3437 with SMTP id
 98e67ed59e1d1-315f268d07fmr4776995a91.27.1750860188632; Wed, 25 Jun 2025
 07:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624055537.531731-1-will@willsroot.io>
In-Reply-To: <20250624055537.531731-1-will@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 25 Jun 2025 10:02:57 -0400
X-Gm-Features: Ac12FXz4TnFxuLDDHfM4Hld3fRd1l8LhNaKKHP8oR4tPMKUJ1A5ZXDmLQSCPC84
Message-ID: <CAM0EoM=rkxR0OuDm8E8NMbHwxp2CknxGH=Mwz=iaPfn6nHRnsA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, victor@mojatatu.com, 
	pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, 
	stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please, just wait maybe a day or two next time if you get feedback
before sending an updated version.

On Tue, Jun 24, 2025 at 1:57=E2=80=AFAM William Liu <will@willsroot.io> wro=
te:
>
> netem_enqueue's duplication prevention logic breaks when a netem
> resides in a qdisc tree with other netems - this can lead to a
> soft lockup and OOM loop in netem_dequeue as seen in [1].
> Since we do not want to add bits to sk_buff for tracking
> duplication metadata for this one specific case, we have to ensure
> that a duplicating netem cannot exist in a tree with other netems.

I think what is useful is to describe the discussions we had, off top
of my head:
1) you had the skb bits initially - to which i pointed out that it is
politically incorrect solution to add more metadata bits to the skb. I
posted some url, include that url from lwn
2) you then added skb cb state, to which i pointed that it can be
overwritten defeating the purpose.
3) we then went to using a similar approach as mirred loop-avoidance
and found out that it wont work for netem dequeu (and i cant remember
what else) with stopping the loop
4) is this solution which makes it illegal to have more than one netem
in a hierarchy; i.e we are identifying that as an "illegal" hierarchy.

cheers,
jamal

> Technically, this check is only required on the ancestral path,
> but filters and actions can change a packet's path in the
> qdisc tree and require us to apply the restriction over the tree.
>
> [1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilx=
sEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@wi=
llsroot.io/
>
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Reported-by: William Liu <will@willsroot.io>
> Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> Signed-off-by: William Liu <will@willsroot.io>
> Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
> ---
> v2 -> v3:
>   - Clarify reasoning for approach in changelog
>   - Removed has_duplication
> v1 -> v2: https://lore.kernel.org/all/20250622190344.446090-1-will@willsr=
oot.io/
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

