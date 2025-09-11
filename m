Return-Path: <netdev+bounces-222164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85401B53562
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67CEB7A8C8A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE02633CE9F;
	Thu, 11 Sep 2025 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cJaArH8P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B96922259B
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601086; cv=none; b=gZSCEm3SFEcdm//PgJi6ppxacoBIdAMSKnC4Fq+t+tjiC4AMOenwv7gKevucSSmoRHIK8EIgU+WvjhN5RDftNqESMFwhRjeDNOPHwQqG8qho7/lRK5ksR/VQ+85sls8IewdM933PGxGlg3/EXv6u4RYviyxW7O2ggkIQxf69qxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601086; c=relaxed/simple;
	bh=6ma+cl262W0HOhzRwYfR1aR/CVAjYPEcGocXblETyzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3bCbTuXv88XmE3pBCr0ukN+rV9Gg+hC9WBg9O+RydC/iHCsks5BlXIORnPc15gk6gakqed5Sj4RbtCbwHRj55LcMHE8q6yKmkxNOabOGc7EuS7ECeZ8xusPjuCtLpOFV29dE8PHyslQhMq0B3vy5CpYcM5kA4auEOiIdWUQIL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cJaArH8P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24cca557085so166175ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757601084; x=1758205884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+/LB7TOsdLbBMJk6npIyPR6m3jK/ROCWosphCpm/n4=;
        b=cJaArH8PpthXTebf62XTeZTuY75g4DLunWfczurLwHZgRSRwYv3lMeOJ2wLNOhAv1f
         MyE8tr58qyvNrjRl3F93rx7o1//r8gmnjHG2cUJkZ6Oy+dFLyM0wkpafN24jXSeljZ4C
         p0T/CQ/F0JmQU0UQdmH073myHq8ROl+mpv4aipQcWdGJ33KWSm1TxLoPrRZ9uQ9NBNz+
         CEpCVIsZxp8b+tEbo/6l18X2rw71BpaeeqVLThZo9y8pQfN68WcueEOOk5LidqISWwKK
         KNepyGd2hgg/Nj0Y59mgzhdRCiw7etn+KZoU0A6n9sxA65+cLAtE2b5aim4B4z5iGsI1
         U0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601084; x=1758205884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+/LB7TOsdLbBMJk6npIyPR6m3jK/ROCWosphCpm/n4=;
        b=mRKdcskkQ0prvA/2rQtnfBgSAQlV+oO7Y7B4mV660xRUC/cvhreGoJR5gzHiFIxlY/
         Mj1Fr/gP/PxeVXRZeG5srjfPuuoWK/XvW+nZQTuxnoqlqquD5guzQHDkvK58qYMXIjvL
         /iHuuZDXLJT1z0me0lDp8QCZRVUA91KzBA0h50aUIvzQxi8Qei4pa4DJif1p7zSQId2V
         N1M4i5nEwoDXdOJ+o/+b1VCxyYhzMCrLv+9qSQrihojdn1fxXRxfuuxWcuIH29zI4mgW
         Mc9kY7w5hvk45saxQfaFXir7i+hZXxx8lwmoBrZaprSFL7rH3vVzkZdN/9rzGUWnLms2
         lMOg==
X-Forwarded-Encrypted: i=1; AJvYcCVodWme6lVPUe4IsLF5HORa6jiqj36OmCnOapBJZ/vKUZsAd8WYCtqzcyP69xGrgMzxlJIlpq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pnwGj0BZ4rmo93oPJFOsmSqz8avIiexF1FoBGd8mWL9AAQSL
	PhvJVohXskShqxNB67Mu8zy1MV6+GHqKot1DbaUpVNNmIkcIjPmpjzyoqpIYpIWPPlMo6savLrv
	4rsJczhA39XVMIQ+0VICMya8IAfrCznC8haWcIMoH
X-Gm-Gg: ASbGncvbyJN/lnP/D93g/CdqthBx9VUe1fy9y0AYBpA2fjMxPHrBPQ9NgSkL7JErDKS
	LydudDO28YDodJE9/R/EZ8JCEq7XdXk4ElwXHoSPEyR+fHOhppGeDMbl+EqtyHC8iLWpJr51prQ
	U4jchcn+8KTTOiKhuGRGsKbSuiwj4qyH58Jw/HF+uaWa7+tpiCeP8ZVs+miiyBMFsKcxyrrgBm3
	qpUnSztpS7M4zloMuGgyh/7PKhwQ8XBemY+PcS1yCFtSg==
X-Google-Smtp-Source: AGHT+IEQM9f2Dyt3TQOqXdrxYPTfou5Lro9mRuZJdA3vkjkx3/Ee5dW7Ob8Tw599b6dfVGSZGT1HRHZxdUkRFOP0+jc=
X-Received: by 2002:a17:902:ea0c:b0:248:7b22:dfb4 with SMTP id
 d9443c01a7336-25a563b578cmr9585285ad.16.1757601083513; Thu, 11 Sep 2025
 07:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910203716.1016546-1-skhawaja@google.com> <20250911064021.026ad6f2@kernel.org>
 <CAAywjhTkX3N5CY8+DCEu-DD_0y+Ts0SEkkVphKam1vScMRWdgA@mail.gmail.com>
In-Reply-To: <CAAywjhTkX3N5CY8+DCEu-DD_0y+Ts0SEkkVphKam1vScMRWdgA@mail.gmail.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 11 Sep 2025 07:31:11 -0700
X-Gm-Features: Ac12FXwZPY67B1ND9AjSUHdV0L1G3UazFaGrfFoULeuz5MWpavkb261EPubiQwA
Message-ID: <CAAywjhQZ=4hYaCrO6Uue+cfB4xyyPDMbRTtucEQ4vvxozqxKEQ@mail.gmail.com>
Subject: Re: [PATCH net] net: Use NAPI_* in test_bit when stopping napi kthread
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, willemb@google.com, netdev@vger.kernel.org, 
	mkarsten@uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:10=E2=80=AFAM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Thu, Sep 11, 2025 at 6:40=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 10 Sep 2025 20:37:16 +0000 Samiullah Khawaja wrote:
> > > napi_stop_kthread waits for the NAPI_STATE_SCHED_THREADED to be unset
> > > before stopping the kthread. But it uses test_bit with the
> > > NAPIF_STATE_SCHED_THREADED and that might stop the kthread early befo=
re
> > > the flag is unset.
> > >
> > > Use the NAPI_* variant of the NAPI state bits in test_bit instead.
> > >
> > > Tested:
> > >  ./tools/testing/selftests/net/nl_netdev.py
> > >  TAP version 13
> > >  1..7
> > >  ok 1 nl_netdev.empty_check
> > >  ok 2 nl_netdev.lo_check
> > >  ok 3 nl_netdev.page_pool_check
> > >  ok 4 nl_netdev.napi_list_check
> > >  ok 5 nl_netdev.dev_set_threaded
> > >  ok 6 nl_netdev.napi_set_threaded
> > >  ok 7 nl_netdev.nsim_rxq_reset_down
> > >  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
> > >
> > >  ./tools/testing/selftests/drivers/net/napi_threaded.py
> > >  TAP version 13
> > >  1..2
> > >  ok 1 napi_threaded.change_num_queues
> > >  ok 2 napi_threaded.enable_dev_threaded_disable_napi_threaded
> > >  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> > >
> > > Fixes: 689883de94dd ("net: stop napi kthreads when THREADED napi is d=
isabled")
> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> >
> > Is this basically addressing the bug that Martin run into?
> Not really. That one was because the busy polling bit remained set
> during kthread stop. Basically in this function when we unset
> STATE_THREADED, we also needed to unset STATE_THREADED_BUSY_POLL.
>
> @@ -7000,7 +7002,8 @@ static void napi_stop_kthread(struct napi_struct *n=
api)
>                  */
>                 if ((val & NAPIF_STATE_SCHED_THREADED) ||
>                     !(val & NAPIF_STATE_SCHED)) {
> -                       new =3D val & (~NAPIF_STATE_THREADED);
> +                       new =3D val & (~(NAPIF_STATE_THREADED |
> +                                      NAPIF_STATE_THREADED_BUSY_POLL));
>
Just to add to my last email: I did find this test_bit issue while
working on the fix for that other problem.
> >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 93a25d87b86b..8d49b2198d07 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -6965,7 +6965,7 @@ static void napi_stop_kthread(struct napi_struc=
t *napi)
> > >        * the kthread.
> > >        */
> > >       while (true) {
> > > -             if (!test_bit(NAPIF_STATE_SCHED_THREADED, &napi->state)=
)
> > > +             if (!test_bit(NAPI_STATE_SCHED_THREADED, &napi->state))
> > >                       break;
> > >
> > >               msleep(20);
> >

