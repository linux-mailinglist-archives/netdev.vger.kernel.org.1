Return-Path: <netdev+bounces-192660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454C9AC0BA3
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C4A3B967E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83371E485;
	Thu, 22 May 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0WUd+RSj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A5381BA
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917245; cv=none; b=oFYikv48fZw6sMeRdFlT3Ohv7h7WJEq8g831SfnNP++WDLjPyBcL25XsLSS2eD5v0MpHwOKrBr5YGjPEXF7QCwA/hD/y79pRBWkxqBivKOj7ooyTKXlwIQgw+Tj+l8DTvaptK3uaHZigXJYyWAwtgmTzWW9VAkVv+Gm3AUFAFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917245; c=relaxed/simple;
	bh=wltlSCroMeUOORJiPsst0BFz/6pts/MfbaS9SQi1/zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X89KwN0pt1/BGKbdMOFBWmaiXRHUyS/RJPP5WFc10dqOcMDQv+LOgv6GgikbWgRtXT6b70G8G7DjXXap2YM12nkKUNxeVGuo9ubB124Uv1Esg1kaM41Ae/7X2syH5iwToHUiyS4WR9mC6X7g+AkM6yl4zRixwaLBRCBBhYOf1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=0WUd+RSj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74019695377so5868085b3a.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1747917243; x=1748522043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wltlSCroMeUOORJiPsst0BFz/6pts/MfbaS9SQi1/zg=;
        b=0WUd+RSjrlA8KD57v8j7xC/QbTpBF6gZ5dTH7hUSzFsx9wCj+bxcfrESRoKBqGBtmM
         gkYdH6XgvzGD3M6LFn9OfB3OKk/ZPvR5qJFX4CEayAz+nji96+43sS7z1mMZiSMQzLMy
         vyWScXzUlIZpYZCqhJJV3NuKMcIjY5VxNoDnEl2sXd9lDeiXH0qdrnlBmn0uOtTLA/Zp
         gR+iOwLsJ0IzkvsXkVctXpAGwHZ4SqbnjeSdIPf4XGVVJTmVS4YH+eDYge9YSdJL5/ec
         z1VNv5TgfQ0H5Hl2OO69V07QHu4SXrW83FmamA7HYYxrP6aLooAxJApHjh2JrsBn7FSl
         1jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747917243; x=1748522043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wltlSCroMeUOORJiPsst0BFz/6pts/MfbaS9SQi1/zg=;
        b=A6aId7L0yNk2TUgdTMx/LsPoFwt0DGeW3V1VhQjzTrVlRJfN7aaHJvIxfqut5qkSRQ
         QqTf87fHLgyP/Nk0FORzT8OK6aQs65PR6+IKfvOfc1jRFOrT2Qx5winr8jZ0+zcB6183
         vgP8qM4c+t/p9zeUGSsuynItOSfQZJpa3eZeCcNti7b40KuNNgEUOLaODFznaGPBMyBx
         CV0mC2gqFsbASKtqMPUdNe/UFV1cX3vCoESzkSCw7jrtdn7fckvfqOI89jRieXiUV9Ok
         Su3kS+Gu0uZwdOo0sBQf50f7hrnYB2AoECHhiX7DnIvwxSDowztRnlePsR6yJLTijTqC
         ybNw==
X-Gm-Message-State: AOJu0Yx+Xa1gDJ0iz1AhhyIkzFIpUXjx8iK0zIRBc7WgocCEx2asqhju
	SLvG9Muftf3QhaYCIgwyhN9Up3BLeq8vk6wMnY/FhIKrzfkWA8R7DFp6w9tThsG5dowCdYkbpEb
	L6g5t0B1UcK0zxxRfFoxkLfyB5RK/z75nPTEtJntD
X-Gm-Gg: ASbGncvqQjykMafwZg8M81KOGJqvF4Gd0WQQJtW/TgCSpBsObwul7I3QCeakzs07FLZ
	rx123IcMeae3jWuZOO05cG0XEK6uAECrFWYPfLlD3TZnTxkfTGOPDI1wlwCjlv0apMfs4CHlG/u
	dEoO51aYQfnal++0VdmMmf1mNs7gd232k=
X-Google-Smtp-Source: AGHT+IF/AdNXmqjRCf5ZVtcuhNrf8mWBPencRZ9HbeSRVvTPHvcGXGYDXJtZOUgoErHf9bDIfN+Exyx/NtWdbsw2XhE=
X-Received: by 2002:a05:6a21:3384:b0:1f5:769a:a4bf with SMTP id
 adf61e73a8af0-21621a23f5fmr41392215637.36.1747917243480; Thu, 22 May 2025
 05:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <CAM0EoMmKL68r_b1T4zHJTmdZPdCwS69F-Hh+0_ev+-5xPGy2=w@mail.gmail.com>
 <DglTO9NHmtFTRrCJf07R16_tYUUqoTV7M0hID_k-ryn5mAhe4ADq1mBpAuxNK24ZTnzIPaPq4x1woAtqZGXgAQS4k64C4SGRCfupe3H3dRs=@willsroot.io>
 <CAM0EoMmQau9+uXVm-vpuWqYjh=51a_CCS6orS6VrK6qBdddxrQ@mail.gmail.com>
 <iEqzQsC-O2kAXqH1_58I59DIhBjRgebyGym2ZqyMEI3DaMtgsKSYR0KUsbxj5xqvfzf-4XzpM8dXvATHJhVVw3NedRdL3j1FJaqiXPlNWeE=@willsroot.io>
 <ggSxq-NP-LDpev4N-rvkgs0Rrd0qOrbwtGRjcu4j4y3SuZth9k5RxTg2tFvhriQu4w_GxRPYjnkKN6VqFP6Q6FCyqWudz7_5iuOV06IEzgY=@willsroot.io>
In-Reply-To: <ggSxq-NP-LDpev4N-rvkgs0Rrd0qOrbwtGRjcu4j4y3SuZth9k5RxTg2tFvhriQu4w_GxRPYjnkKN6VqFP6Q6FCyqWudz7_5iuOV06IEzgY=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 22 May 2025 08:33:51 -0400
X-Gm-Features: AX0GCFu4Z_QCYdXdTVxuwZ-ZgF3SLVgMCxGrqXET5xavn_UgMvqvn1yWbk-7cVc
Message-ID: <CAM0EoMkd87-6ZJ5PWsV8K+Pn+dVNEOP9NcfGAjXVrzAH70F4YA@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 11:38=E2=80=AFAM William Liu <will@willsroot.io> wr=
ote:
>
> On Wednesday, May 21st, 2025 at 2:03 PM, William Liu <will@willsroot.io> =
wrote:
>
> >
> >
> > On Wednesday, May 21st, 2025 at 11:06 AM, Jamal Hadi Salim jhs@mojatatu=
.com wrote:
> >
> > > I am afraid using bits on the skb will not go well around here - and
> > > zero chance if you are using those bits for a one-off like netem.
> > > Take a look at net/sched/act_mirred.c for a more "acceptable"
> > > solution, see use of mirred_nest_level.
> >
> >
> > Ah ok, thank you for the suggestion. We will take a look at that then.
> >
> > > Not that it matters but I dont understand why you moved the skb2 chec=
k
> > > around. Was that resolving anything meaningful?
> > >
> > > cheers,
> > > jamal
> >
> >
> > Yes - otherwise the limit value of the qdisc isn't properly respected a=
nd can go over by one due to duplication. The limit check happens before bo=
th the duplication and the skb enqueue, so after duplication, that limit ch=
eck would be stale for the original enqueue.
> >
> > Best,
> > Will
>
> Hi Jamal,
>
> If we do a per cpu global variable approach like in act_mirred.c to track=
 nesting, then wouldn't this break in the case of having multiple normal qd=
isc setups run in parallel across multiple interfaces?

A single skb cannot enter netem via multiple cpus. You can have
multiple cpus entering the netem but they would be different skbs - am
i missing something? Note mirred uses per-cpu counter which should
suffice for being per skb counters.

> We also considered adding a nesting tracker within netem_sched_data itsel=
f (to increment and decrement in the prologue and epilogue netem_enqueue), =
but that would break upon having multiple netems with duplication enabled i=
n the qdisc hierarchy. If we aren't going to track it in sk_buff, I am not =
sure if this approach is viable.
>

As long as it's per-cpu, not sure where the breakage is.

> This brings us back to the approach where we don't allow duplication in n=
etem if a parent qdisc is a netem with duplication enabled. However, one is=
sue we are worried about is in regards to qdisc_replace. This means this ch=
eck would have to happen everytime we want to duplicate something in enqueu=
e right? That isn't ideal either, but let me know if you know of a better p=
lace to add the check.
>

I didnt follow - can you be more specific?

cheers,
jamal


> Will
> Savy

