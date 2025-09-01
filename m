Return-Path: <netdev+bounces-218840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B429AB3EC43
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B37D207FFE
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01B321507F;
	Mon,  1 Sep 2025 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="KoHc54Vx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A8232F763
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744543; cv=none; b=pubR2wbh3muEAK0ZSIhvRdk7pNuawLPDFzpkWcaozhoEiFHOFkEAv+tNZJKYVoHabklZ+c2qovxqcur7o9bOAxY78JZgqiO7THYhdmjMxbtiYj84a6LqfDSjLfUbrBZPgy8hhwyazOOhNBekKFCiJcPH0XexVDTc36+B3Oye4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744543; c=relaxed/simple;
	bh=2FRKcPt97t164JUd9NF4InNOTZKOLiy/tfqHAwg6JYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNS+jhteRf8ysX4NWO4MhgL6/OpPS8IwlAwW22sNE2HRD4BrBhT+GOKycfK+Xk7eNlh82Q1lgdF4DzVrhzi5fhrIpAMe/Ae2L/osTr1YH0YxRcuMvy4pmN8SyAQWQxGTvUGWAwNiTDExIYz7Ck0jlwQ3bjTZGOsDQThnAFvMh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=KoHc54Vx; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VrjorLP1egFmKSG+GBXtIzwkkGz+arOYKjunNVzKPBI=; t=1756744542; x=1757608542; 
	b=KoHc54VxMYX/jjSNIE1gfQ2FwbR4pKcloXnePgc0bhyzZqDgsiQEUur3zPyJyambvbIpmGEnVzx
	tAeF7Fkmd+j3/jPXwiO/o2B1Wnk2lrtu2SgsCUO4AZtUYxEihik4stSqTunsSV2dduG7LKHDbaX+/
	OuiimMKgUKKR9R76oRfumw5clD8XsEKKzTsBjNGofUSnurUP5Y0cS7SVt3w9oV2qf8Fhe3pMbv0k8
	0T7h4VP2/UB8rlCCYPlpYreSn81R5jYOLd6z/GEto4duKdamPacsldslaTqce9PseeSmdEMIxdtyC
	B8GbgtOwSruTNJOQJW1gNuLZqhmsxLVNTkGA==;
Received: from mail-ot1-f43.google.com ([209.85.210.43]:48455)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1ut7VM-0005Cq-W4
	for netdev@vger.kernel.org; Mon, 01 Sep 2025 09:35:41 -0700
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7452b1964f3so3551358a34.1
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 09:35:40 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz9jwkEQNS/2+HQoD382wng7J+Dibi5xo6DasltQdLum1idBTDv
	DrlZA3lA80XxqvjQqu2/g4PvneOGuRxb5fMpeeeIWRAiSuQLLnA76tsrerZ5tw0KEO58w7gt42I
	La9vNtwiyxzc/W33GnR5SQ/PW4Zj5Q4M=
X-Google-Smtp-Source: AGHT+IFJP6zDw7ZepR8c78Ncup/jg5Gq6+RKqbF6uSl8KdV5mCngHaFJWjwzujGOraDgefRodtc74p4DTZUmfddptPE=
X-Received: by 2002:a05:6808:bc4:b0:433:fe9c:686d with SMTP id
 5614622812f47-437f7d016d5mr3311403b6e.21.1756744540379; Mon, 01 Sep 2025
 09:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-9-ouster@cs.stanford.edu>
 <3b432e20-cca3-4163-b7ac-139efe6a8427@redhat.com>
In-Reply-To: <3b432e20-cca3-4163-b7ac-139efe6a8427@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 1 Sep 2025 09:35:04 -0700
X-Gmail-Original-Message-ID: <CAGXJAmz50OiZM65sB43k5Gh34nZ6TAx7_1Bx0XDPrpJ-uWUj4w@mail.gmail.com>
X-Gm-Features: Ac12FXykTI4SGGkhnkNWqsMGZA5EKZqLOtQCuVVsvlcZRAJR74O-2f8m-w2Z82A
Message-ID: <CAGXJAmz50OiZM65sB43k5Gh34nZ6TAx7_1Bx0XDPrpJ-uWUj4w@mail.gmail.com>
Subject: Re: [PATCH net-next v15 08/15] net: homa: create homa_pacer.h and homa_pacer.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 3134a374f3853b94094f80bd9e2b84a0

On Tue, Aug 26, 2025 at 3:54=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/18/25 10:55 PM, John Ousterhout wrote:
> > +/**
> > + * homa_pacer_alloc() - Allocate and initialize a new pacer object, wh=
ich
> > + * will hold pacer-related information for @homa.
> > + * @homa:   Homa transport that the pacer will be associated with.
> > + * Return:  A pointer to the new struct pacer, or a negative errno.
> > + */
> > +struct homa_pacer *homa_pacer_alloc(struct homa *homa)
> > +{
> > +     struct homa_pacer *pacer;
> > +     int err;
> > +
> > +     pacer =3D kzalloc(sizeof(*pacer), GFP_KERNEL);
> > +     if (!pacer)
> > +             return ERR_PTR(-ENOMEM);
> > +     pacer->homa =3D homa;
> > +     spin_lock_init(&pacer->mutex);
> > +     pacer->fifo_count =3D 1000;
> > +     spin_lock_init(&pacer->throttle_lock);
> > +     INIT_LIST_HEAD_RCU(&pacer->throttled_rpcs);
> > +     pacer->fifo_fraction =3D 50;
> > +     pacer->max_nic_queue_ns =3D 5000;
> > +     pacer->throttle_min_bytes =3D 1000;
> > +     init_waitqueue_head(&pacer->wait_queue);
> > +     pacer->kthread =3D kthread_run(homa_pacer_main, pacer, "homa_pace=
r");
> > +     if (IS_ERR(pacer->kthread)) {
> > +             err =3D PTR_ERR(pacer->kthread);
> > +             pr_err("Homa couldn't create pacer thread: error %d\n", e=
rr);
> > +             goto error;
> > +     }
> > +     atomic64_set(&pacer->link_idle_time, homa_clock());
> > +
> > +     homa_pacer_update_sysctl_deps(pacer);
>
> IMHO this does not fit mergeable status:
> - the static init (@25Gbs)
> - never updated on link changes
> - assumes a single link in the whole system
>
> I think it's better to split the pacer part out of this series, or the
> above points should be addressed and it would be difficult fitting a
> reasonable series size.

I have removed the pacer from the patch series.

-John-

