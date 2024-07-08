Return-Path: <netdev+bounces-109807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0CB929F67
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528F028C1BE
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2E76EB56;
	Mon,  8 Jul 2024 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EM9TIXub"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923F6BFBA
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431610; cv=none; b=TXPBB2Qt3BnUFKosaOD/S9hAthvL14L+k66ur6jSm5jjol1nLAXkINVeD00CA/6LxsbMGZdWgTIlKO+U0t+JEZgk+sQRt5NDvLiRB3Z5ltFRLZftKRYw6esIPpGjAyKQiPq5P7DKjZv9Cf5hvfS9AwkA5/j01WhvpoXkx0YnLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431610; c=relaxed/simple;
	bh=WaFvJOB3LuiYAl5tSbw8XBeRtas3+9eoV/NljR6xXu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gdl5yu9EpORrOGFrlLjYtnIF8GIgLBxNweZMMRhGUgGJYS3OT26f1xIvrVVkbqWcYlpbD85ChkvFfpa+BAiHZBrOUSCbWPO/N8/9sYpBm+jifS1KaOQ4bUsoi1GbUTMDIzucWFBFTy1vgjTplncNLOCwCymb1dRCT2MpinjmVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EM9TIXub; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C23BD41336
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720431604;
	bh=7ei+RMDKGt0qavUEnbUSXeg6e8zBixhaGO9TYuEP2Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=EM9TIXub4wFcjpqpznt2+8+EGz0P7X23PJyf6wMAy7gvMpJrrm0WyIIPCq0n9H5sn
	 HvGve1E2S+tozhYnMPZgMr3iUdxM57C+0PAYwIc7dFOxg/5JffvcCg4CSJ2DzC3NeU
	 kF3m1jHaFf8PljSVpx7r3xU3wRLDtQysOcM09Bw2S0L+QoMTiJGJX4pwv1jpwwjbfO
	 YzbxjwWmhettWL/utXvRUvt+z1cEuwJ+H0l+24/DXjxyR2GCC2145nQcJ7wSCHbHLe
	 LRKvwkX18Y+gJDQ8DLHVEjDc00IMs5Ruhz4MLKpAjrgWuGFuLBxV9yE0Q8vd1tAVl0
	 dNGMzy+VxQS4w==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a77cba34cd0so191869666b.2
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 02:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720431602; x=1721036402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ei+RMDKGt0qavUEnbUSXeg6e8zBixhaGO9TYuEP2Ck=;
        b=NsxYjAIiZce3SFpCuQ/KaS0iUIP+IFVpEXFT4/70xlKSfL7r+kyjVPNF+qxdndksSq
         d7sqcIAb2nHVD334hiQAav/Pk4FXjaFTo4UKpQ8tZMGeVKzJ9jH0KvLijC3ea+aJsStD
         omHrqDSWugaJiymlte22IxSP9YtJqjW8UykNazGPTJ9T8MmU6Cr28ohgtnIAsuUrqaWP
         RS3nPGUCIU3QzFZbTrAAKVwr/AQV1Jybeuwtrwc2PyXsx+dzqOt4XEnmXMxRsZEkGJiE
         7Nhfiu/W8qqR83P1PKCl49IxTxLMPJAXMALLP+iQXXezsJyXYiIdG8DcpooE+l8z3tzb
         9iZw==
X-Forwarded-Encrypted: i=1; AJvYcCW5GmaPuYeD7bysOfeHFuAhsQYxmv+moB2KMcKsx+DRO//i7ZJpNjyfUHdVFb7mnlrwec0+cDYqciwVnsEIVHDxqfUqwNwN
X-Gm-Message-State: AOJu0Yyxv52NAOH+FkWdtpufZsatLyIBDUmsYrFOhCTKQnzQn+XIGzy9
	HRPlzehLmX8q6YmztaiFSoz1dnVyoxmjyNp67ZeHkUnYJC+y1Y7tvMGgcjFt4jxHYiwSRKZksiF
	6irkovtqAAcFDdTbIV4chxVZ8ebkfCk2ZieW7dhjhwf7MSvOjMfEpTIN+vtDc+Gv22jPW6ffIrQ
	JF5O9sgYGSQTE6mvHiHcRAltTIEtacUF1oh96UagX/OuXa
X-Received: by 2002:a17:907:9620:b0:a77:b54f:c25e with SMTP id a640c23a62f3a-a77ba7097c7mr844317666b.53.1720431602394;
        Mon, 08 Jul 2024 02:40:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY8/evpdBw/IfUE6NzTQP9L4Tw6quV4206So53Zy4ouW7JYhzgqtmgj/ZFwKu+7dYfhWhJqGqDKpcGa/fQFQc=
X-Received: by 2002:a17:907:9620:b0:a77:b54f:c25e with SMTP id
 a640c23a62f3a-a77ba7097c7mr844316066b.53.1720431602031; Mon, 08 Jul 2024
 02:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705025056.12712-1-chengen.du@canonical.com>
 <ZoetDiKtWnPT8VTD@localhost.localdomain> <20240705093525.GA30758@breakpoint.cc>
 <CAPza5qdAzt7ztcA=8sBhLZiiGp2THZF+1yFcbsm3+Ed8pDYSHg@mail.gmail.com> <ZoukPaoTJKefF1g+@localhost.localdomain>
In-Reply-To: <ZoukPaoTJKefF1g+@localhost.localdomain>
From: Chengen Du <chengen.du@canonical.com>
Date: Mon, 8 Jul 2024 17:39:51 +0800
Message-ID: <CAPza5qc0J7QaEjxJBW=AyHOpiSUN9nkhOor_K2dMcpC_kg0cPg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: Fix UAF when resolving a clash
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Florian Westphal <fw@strlen.de>, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ozsh@nvidia.com, paulb@nvidia.com, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gerald Yang <gerald.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 4:33=E2=80=AFPM Michal Kubiak <michal.kubiak@intel.c=
om> wrote:
>
> On Sat, Jul 06, 2024 at 09:42:00AM +0800, Chengen Du wrote:
>
> [...]
>
> > >
> > > > > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > > > > index 2a96d9c1db65..6f41796115e3 100644
> > > > > --- a/net/sched/act_ct.c
> > > > > +++ b/net/sched/act_ct.c
> > > > > @@ -1077,6 +1077,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk=
_buff *skb, const struct tc_action *a,
> > > > >              */
> > > > >             if (nf_conntrack_confirm(skb) !=3D NF_ACCEPT)
> > > > >                     goto drop;
> > > > > +
> > > > > +           /* The ct may be dropped if a clash has been resolved=
,
> > > > > +            * so it's necessary to retrieve it from skb again to
> > > > > +            * prevent UAF.
> > > > > +            */
> > > > > +           ct =3D nf_ct_get(skb, &ctinfo);
> > > > > +           if (!ct)
> > > > > +                   goto drop;
> > > >
> > > > After taking a closer look at this change, I have a question: Why d=
o we
> > > > need to change an action returned by "nf_conntrack_confirm()"
> > > > (NF_ACCEPT) and actually perform the flow for NF_DROP?
> > > >
> > > > From the commit message I understand that you only want to prevent
> > > > calling "tcf_ct_flow_table_process_conn()". But for such reason we =
have
> > > > a bool variable: "skip_add".
> > > > Shouldn't we just set "skip_add" to true to prevent the UAF?
> > > > Would the following example code make sense in this case?
> > > >
> > > >       ct =3D nf_ct_get(skb, &ctinfo);
> > > >       if (!ct)
> > > >               skip_add =3D true;
> >
> > The fix is followed by the KASAN analysis. The ct is freed while
> > resolving a clash in the __nf_ct_resolve_clash function, but it is
> > still accessed in the tcf_ct_flow_table_process_conn function. If I
> > understand correctly, the original logic still adds the ct to the flow
> > table after resolving a clash once the skip_add is false. The chance
> > of encountering a drop case is rare because the skb's ct is already
> > substituted into the hashes one. However, if we still encounter a NULL
> > ct, the situation is unusual and might warrant dropping it as a
> > precaution. I am not an expert in this area and might have some
> > misunderstandings. Please share your opinions if you have any
> > concerns.
> >
>
> I'm also not an expert in this part of code. I understand the scenario
> of UAF found by KASAN analysis.
> My only concern is that the patch changes the flow of the function:
> in case of NF_ACCEPT we will go to "drop" instead of performing a normal
> flow.
>
> For example, if "nf_conntrack_confirm()" returns NF_ACCEPT, (even after
> the clash resolving), I would not expect calling "goto drop".
> That is why I suggested a less invasive solution which is just blocking
> calling "tcf_ct_flow_table_process_conn()" where there is a risk of UAF.
> So, I asked if such solution would work in case of this function.

Thank you for expressing your concerns in detail.

In my humble opinion, skipping the addition of an entry in the flow
table is controlled by other logic and may not be suitable to mix with
error handling. If nf_conntrack_confirm returns NF_ACCEPT, I believe
there is no reason for nf_ct_get to fail. The nf_ct_get function
simply converts skb->_nfct into a struct nf_conn type. The only
instance it might fail is when CONFIG_NF_CONNTRACK is disabled. The
CONFIG_NET_ACT_CT depends on this configuration and determines whether
act_ct.c needs to be compiled. Actually, the "goto drop" logic is
included for completeness and might only be relevant if the memory is
corrupted. Perhaps we could wrap the judgment with "unlikely" to
emphasize this point?

>
> Thanks,
> Michal
>
> > >
> > > It depends on what tc wants do to here.
> > >
> > > For netfilter, the skb is not dropped and continues passing
> > > through the stack. Its up to user to decide what to do with it,
> > > e.g. doing "ct state invalid drop".

