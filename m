Return-Path: <netdev+bounces-200294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E4BAE4721
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63083AD6B7
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D125DD15;
	Mon, 23 Jun 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="aOhlCrwP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819625DCFF
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689224; cv=none; b=LQAwse5DxJJEpl1bKiWFqlzz57SxiHuymYgIgosBcL3x6uU+awkBnv9DMG+DPUUSKwEJpuRagdFtlDcf2aQGa4UZAFcfe+VtAgI7Klhx2Dmy+Z+LYDCBupb7LEBThy74dZH5uB4ax6CiFDydNfM/lloNr0OTP1J+FyKE8rW4FcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689224; c=relaxed/simple;
	bh=EcxKuGKNfVZ+d0Aj4MVYmkJcdXcTDRUNylk17S/Sskk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8uBZMNHQmZNUMRFEeM3vuerLXOFhPq9fokXwHPDwll4U/AX5nKD4awKuFNNuKyxbx/OASA73Nn/jy24c10gd3+DDxldhQSUVyRtQs1Bno2g7u6skGWWg1ZsKt3od3VoNq1SvKQDJ34YPol9XG1uz0IxqgYOj85ntWIwD7CCkMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=aOhlCrwP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7426c44e014so3685372b3a.3
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1750689220; x=1751294020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bO6a7MvTRxsGzMY08eCCV9bV0GUTOWwZgysb2r/QUSM=;
        b=aOhlCrwPoXcrlcXeHTF9duHFiD5g8MksH51bTWSVhAEpWjMQX6iBik4uIQsDAVALVO
         0XRyPDLpfzqbe8B1Rr5NT6X5B7PcGqfU4n/BtTwvRunsOtElcwfPHBkDxxZwfNS7Lj81
         SsCwbQMnkh0T4s30QiHz7uSgIJM8tx8kLFrTs1hfzt2FeL+o5l1FDrGgoEq15ZJAksEe
         /NFd0pGbfE6FhU5YYI1WlMctjOyGAOucMyg+hpft/XZ9Z4BWif2sG+11BkB61b+1wLG5
         LqaZiR3sNt+hq862kuiuLhEqoFz0IVyIBivWfe9ofy42POlh8uQRE0ZvzDQyMN19E9J6
         gkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750689220; x=1751294020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bO6a7MvTRxsGzMY08eCCV9bV0GUTOWwZgysb2r/QUSM=;
        b=l9ytjMKC3q0b2Y8Hse451bEmkCWyyu6AoZc9m9VQScNhw2nCUq5EqL+apMFPyiWh9r
         Cyv80J1H/fQu9AEhVTkWFNWoH2mu75HH9zUUo3xzm0b1DCTvqduMSvqoTh6nbSkHOLaA
         uSs7fllbMHHeD378k/nYFTI9621Bvp/6IauLGYzMdNsPxDbNFfP0EHzZcoIzsaKee7yP
         LyjWuFTkqMRh0hC99ILf+2OBO/spPTNE/jVL/QQ5AqWFDNJ35BTehJmc2bOtGRT5Z5oO
         w/nZrr7mWvNZX4FXs/qlCbr0NHBS3jtRn/pf4VlGwrqjU6RFQw+yLCcshkO3wiFbiOth
         DgkA==
X-Gm-Message-State: AOJu0YwJXHqmlc3/l36yiv5+U+V96BsFMgrY11KviJyi8Ui1FTm5l/UA
	ErqifInX6vt3e9HHzGpd4L3PCbc0dgwa05Ivh95ISi0rWuTf6ByvqvJhQqxb2CVG563ZWqVtpwY
	vJu6HFP/P8H4i0TC3Yds4Ob0Lu5zIRAzZhP9p/3eg
X-Gm-Gg: ASbGncsS1es8AajXdsxnOlG3oHhc3GCY2WgHsYW9fDlX/NiTHXZJfg4bCKKRGGco4qI
	pvS7V1VImyaA6KKytWJnv8/EGfqa10oDdlCsBQHSX6nP01YyIyuddOAF9YVdut+9H5fkyfxt/6i
	NX1RYt8gOCqpA/CRViJhqbSoKshiDtiP6OhJ2aHBd8Zw==
X-Google-Smtp-Source: AGHT+IE8rLjRJrkN0I64VCKoHQJW2Hx7L/19ic1yWpRInz1Zl4jW/5WXvdcgMks1b+s20zkN4IlDassnlN/FXO3kPVQ=
X-Received: by 2002:a05:6a21:1707:b0:21f:e92d:8e20 with SMTP id
 adf61e73a8af0-22026e6f2dfmr26612499637.31.1750689220402; Mon, 23 Jun 2025
 07:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622190344.446090-1-will@willsroot.io>
In-Reply-To: <20250622190344.446090-1-will@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 23 Jun 2025 10:33:29 -0400
X-Gm-Features: AX0GCFtsk5Nd8rw3VRhSCwc5ktSguH0sPNqG9CfPFX8eX89EtJwUo8x5pdCpTWc
Message-ID: <CAM0EoMmbcudme6=ogcUdQ1qt9MThChqy=37Ck1vhnw-4VuKmNw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, victor@mojatatu.com, 
	pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, 
	stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

BTW, you did fail to test tdc like i asked you to do. It was a trap
question - if you did run it you would have caught the issue Jakub
just pointed out. Maybe i shouldnt have been so coy/evil..
Please run tdc fully..

On Sun, Jun 22, 2025 at 3:05=E2=80=AFPM William Liu <will@willsroot.io> wro=
te:
>
> netem_enqueue's duplication prevention logic breaks when a netem
> resides in a qdisc tree with other netems - this can lead to a
> soft lockup and OOM loop in netem_dequeue as seen in [1].
> Ensure that a duplicating netem cannot exist in a tree with other
> netems.
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
>  net/sched/sch_netem.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..308ce6629d7e 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -973,6 +973,46 @@ static int parse_attr(struct nlattr *tb[], int maxty=
pe, struct nlattr *nla,
>         return 0;
>  }
>
> +static const struct Qdisc_class_ops netem_class_ops;
> +
> +static inline bool has_duplication(struct Qdisc *sch)
> +{
> +       struct netem_sched_data *q =3D qdisc_priv(sch);
> +
> +       return q->duplicate !=3D 0;

return q->duplicate not good enough?

> +}
> +
> +static int check_netem_in_tree(struct Qdisc *sch, bool only_duplicating,
> +                              struct netlink_ext_ack *extack)
> +{
> +       struct Qdisc *root, *q;
> +       unsigned int i;
> +

"only_duplicating" is very confusing. Why not "duplicates"?

> +       root =3D qdisc_root_sleeping(sch);
> +
> +       if (sch !=3D root && root->ops->cl_ops =3D=3D &netem_class_ops) {
> +               if (!only_duplicating || has_duplication(root))
> +                       goto err;
> +       }
> +
> +       if (!qdisc_dev(root))
> +               return 0;
> +
> +       hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
> +               if (sch !=3D q && q->ops->cl_ops =3D=3D &netem_class_ops)=
 {
> +                       if (!only_duplicating || has_duplication(q))

if (duplicates || has_duplication)

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
> @@ -1031,6 +1071,11 @@ static int netem_change(struct Qdisc *sch, struct =
nlattr *opt,
>         q->gap =3D qopt->gap;
>         q->counter =3D 0;
>         q->loss =3D qopt->loss;
> +
> +       ret =3D check_netem_in_tree(sch, qopt->duplicate =3D=3D 0, extack=
);

check_netem_in_tree(sch, qopt->duplicate, extack) ?


cheers,
jamal

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

