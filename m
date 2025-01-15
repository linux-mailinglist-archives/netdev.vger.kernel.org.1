Return-Path: <netdev+bounces-158635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A093BA12CCD
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2BAD1889468
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005DD1D88BE;
	Wed, 15 Jan 2025 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QRYnrT6t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5F1DC9B3
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973596; cv=none; b=KGfItottsywzEhEjAwURZoD0Hbq39vZ7CdE6+omNgP77khMwqcDTS3J9k6PnBsMjzDffnkSEmpMnFaDmSYGNAKt+UV0Z7K+4gFFbgoOmsDyoPc7JRTtLM3PdkH2psxEQc+5wnyEZSQOHB/51PyT3AKWlNPPSWNEAxEWudpn3kPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973596; c=relaxed/simple;
	bh=0U+WdmrcGoX+2GDiVHap8V6ikJGwwsUi+S2MGMhBqsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKfNBdV4IGFVdzd51KGUnkgf6IwFKTuUq6BmtJK3vTnLvjGGhbybz7qvh0C2oXbWgaRWzxMRp7Rzp4ysXbcFkUyIF7NPzoHkp0WdM2DfKzYgnDBXSgZWODoUeJPa0zysG/wMXjdZso49UPFkSbv+mcTS7EotHN+c4m6R+3VInB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QRYnrT6t; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161eb94cceso1303285ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736973594; x=1737578394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpSxMGZKuuwfwCy7eG2/ooQQTFo9sFOtmBMODSSN0ZI=;
        b=QRYnrT6t1I1MQYUQf+gXK28eOTu8vYlvMzKSSqvKuoiE70tEzZcZ5xy91W6d1P85+G
         cQ9enj69OBCwgvWkAdWG+tPIDeCxreHbwZGZs1l2uENwHbf1gJgEAlfFmJZS9j3Fn2mq
         adX0ZOzX5o5mTJDouT6K84XY/tRDbOOlqDlb4I2whF6AHeEq0YFrttTwkbYwbojiKOwP
         i4+jkcQpSanq19UQ1f5r5i9DRKddVjuqQLo0frGUv8jidjRmNtdxeofC3BY/XmCX9x85
         lF7oBQpLw2x7SK+5G0mDsWKrD4EMx7sS7jHcvZp1qU6D//fmb/6ft1haHg2mFfz5MISY
         QqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736973594; x=1737578394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpSxMGZKuuwfwCy7eG2/ooQQTFo9sFOtmBMODSSN0ZI=;
        b=nfHrpYrjapVMadvpEOH1EFODRTGV0RwdRXp+3mEwFAFYakwwW+33xytdkndXXBj/zj
         WD1jvyAWmfSCF+Y5P3MyWpfLAf4LWx+6COwOD9Xu7v3GZSMEOQ7pTviKQGeZ6oGVKGnY
         FHhLAP3fi0Y9uFdcZBNINL/ByKYrvsSKdap/sfqGcXk3KLsAsZjRi8BoWmwRC7OIRKIx
         O22G9JBDzAyQ3Iu4Vf6+tXBS854oWWyQZ6FcYod66CpmBY/gaHCk9keqa3kS9ez8BG0S
         RBibtvug1yQL0RKI6r1/vwumicoAoTavnsY1cXZRx29Um6VtVPAkN6067G3MhjyKLt5H
         eHsA==
X-Gm-Message-State: AOJu0YwzrYajCLMCZncW744ejLUeKe12aLG4f/RK5G4MEQ4yCw9Ptl75
	K3la4MkP0ov6pvMhGPHsqHw0otcF3G2r/JfKQzEVIpAFBkWe8qzRfsplfeNWCfgJofXtp3KIRtV
	9hO8sBd6DSvlZFDu9F+e12hTu8L4U2uPynRrB
X-Gm-Gg: ASbGncu48FjeUUFdoqQ4vvNDMpBFX8pvV+hD3cKFOF6fq+7YwM9LBcI2Rc+M3IEusrt
	gcbxNwWQl2NANSuENQPMURlhp3sLuCFKo9/Dg
X-Google-Smtp-Source: AGHT+IEaJjEW0MEYjng5rR2glqaHLzWA4Hbxv9qrYwBJYgxX1HDNkQPjGdAfRKLMur/nRtNXj/wZKDqmKnszCGFzsF0=
X-Received: by 2002:a05:6a00:4c14:b0:726:64a5:5f67 with SMTP id
 d2e1a72fcca58-72d21fea927mr39739025b3a.12.1736973594364; Wed, 15 Jan 2025
 12:39:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111151455.75480-1-jhs@mojatatu.com> <20250114172620.7e7e97b4@kernel.org>
 <CAM0EoMnYi3JBPS7KyPoW5-St-xAaJ8Xa1tEp8JH9483Z5k8cLg@mail.gmail.com>
 <20250115063655.21be5c74@kernel.org> <CAM0EoMk0rKe=AqoD_vNZNj2dz9eKSQpgS0Cc7Bi+FQwqpyHXaw@mail.gmail.com>
 <20250115075154.528eee8a@kernel.org>
In-Reply-To: <20250115075154.528eee8a@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 15 Jan 2025 15:39:43 -0500
X-Gm-Features: AbW1kvYg1gdEKGWE3FzIyTUPoBZU2X5KGk_sryd50yfDlJsib_LHQfFSUV9UhGY
Message-ID: <CAM0EoM=zzidXbUNYUfnV-P5vVU7KOYZJPw7bdfKt4+nSdyWCvw@mail.gmail.com>
Subject: Re: [PATCH net 1/1 v3] net: sched: Disallow replacing of child qdisc
 from one parent to another
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, security@kernel.org, 
	nnamrec@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 15 Jan 2025 09:53:27 -0500 Jamal Hadi Salim wrote:
> > > > I may be missing something - what does TC_H_MAJ() provide?
> > > > The 3:1 and 1:3 in that example are both descendants of the same
> > > > parent. It could have been 1:3 vs 1:2 and the same rules would appl=
y.
> > >
> > > Let me flip the question. What qdisc movement / grafts are you intend=
ing
> > > to still support?
> > >
> >
> > Grafting essentially boils down to a del/add of a qdisc. The
> > ambiguities: Does it mean deleting it from one hierachy point and
> > adding it to another point? Or does it mean not deleting it from the
> > first location but making it available in the other one?
> >
> > > From the report it sounds like we don't want to support _any_ movemen=
t
> > > of existing qdiscs within the hierarchy. Only purpose of graft would
> > > be to install a new / fresh qdisc as a child.
> >
> > That sounded like the safest approach. If there is a practical use for
> > moving queues around (I am not aware of any, doesnt mean there is no
> > practical use) then we can do the much bigger surgery.
>
> So coming back to the code I would have expected the patch to look
> something along the lines of:
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 300430b8c4d2..fac9c946a4c7 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1664,6 +1664,10 @@ static int tc_modify_qdisc(struct sk_buff *skb, st=
ruct nlmsghdr *n,
>                                 q =3D qdisc_lookup(dev, tcm->tcm_handle);
>                                 if (!q)
>                                         goto create_n_graft;
> +                               if (q->parent !=3D tcm->tcm_parent) {
> +                                       NL_SET_ERR_MSG(extack, "Cannot mo=
ve an existing qdisc to a different parent");
> +                                       return -EINVAL;
> +                               }

Yes, this should work as well - doesnt have to save the leaf_q, so more opt=
imal.
Please send the patch.

cheers,
jamal
>                                 if (n->nlmsg_flags & NLM_F_EXCL) {
>                                         NL_SET_ERR_MSG(extack, "Exclusivi=
ty flag on, cannot override");
>                                         return -EEXIST;
>
>
> Whether a real (non-default) leaf already existed in that spot
> is not important..

