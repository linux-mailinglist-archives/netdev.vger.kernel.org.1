Return-Path: <netdev+bounces-203398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009E4AF5C36
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958FC3A855B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8D92E54D1;
	Wed,  2 Jul 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="x7kV1SJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAC2D0C85
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468799; cv=none; b=OZQhkDGWN0MOtCSkdxICqwgdUy4Odxh9ynn6XYt7p2qCG4DykyfMEHol8OUPqNE22RWQYEtL3hOsuhER8sO7WmhzLVsI3T8g3Rclrqw+Sw3Uxrgvl6JAVXdaQLLXfgCw3ISw+NLkrHur7h6UQj0QyPiHzqmWAIV7E2y5vjhTBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468799; c=relaxed/simple;
	bh=SCc0OqURD76WYaan1/p22Jt8QGLAyhE9AODV8OW2yV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0cyeJKVosukNwWQst1M7iX23HzUgy11Lw86mLbF+KVX9QZhwnt/JuK2Fwsp9Fmc51W0yl4pgyU5bVpawGzWpKNrKtpUIjw7sFUhSZcYthKmsUaRzppXgeCCsXZ9rag3LU4h7RzmKBSaduezHhiLuJByIGhj6oWrBZETBVu/tTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=x7kV1SJD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748d982e97cso4598409b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751468797; x=1752073597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fIf82vxzsvEwspd3FnCkMVHZBXtyvBHx+PEzrq7NaE=;
        b=x7kV1SJDMBxas+8oK1ZLkFICszhluWP4jDOV+ZeBDAoVLHthgaqtlSkMGMqiiFwCDb
         rvbrpj8McypI0+0XUtthtsp0I/tCV42kg0oNXWY+6Se3B0OktwEeQCNU60Y0TaN8/YMp
         9yP17yC5zhLg1FO3WtHZHPqj2PXkcYosvWqbxh3yyhLEC3rHFqq/wz4sOGkMQ0Jwsljg
         tUW6ka//crfoNxqRlqaMr1X9XxcfKuVgEoOdl3Kr8oB2lTRwHCW4oaZJxAghpZdjRLOI
         r36XKNiG8J7/Ul0F9/v38B7lP1Ajk+YiTnBi8wdFr28eoVUW7edpz6vQRKJ37pAsS05k
         jMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468797; x=1752073597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fIf82vxzsvEwspd3FnCkMVHZBXtyvBHx+PEzrq7NaE=;
        b=wSbD1fqC9si23eZJzblo6qXOwf/0EFqkhAMhoG4FAPblL5Qv8YlmZSVhyJvZiw7PeO
         v+7QQxBlHW2k36g7DXxo5e6BUZLrpuZ0DdMVPnTKqwA2j2EofjzjDzp178P5403bxOwH
         UEgYu5A2HxKXdndJiEwYcDHeUii/OrugnqY9srqBd6Gb5hiy7/fic6NLNM3ly+6NYbED
         ///C4nm95Qqi9MI09/pDq+lk0UycM6WHMrbSew03sLiK02tRNxt2YEMDFN32N3b6GHC9
         hfEivj9CXMFLuq69IHTfsXve3SQm4IDxpUgjqoTPlUX6FVAKhpqlfffZbI5az7fdtTYQ
         raFQ==
X-Gm-Message-State: AOJu0YxnhNt0zpytl/ssieZVAwG2613GnleU5oq9AwNjrFy0rY43QgLL
	bTV7vJH9ZzQo9FMxhBO2PVJM7+SdViZ1tHvqQb6eOGYFcZOINV2OI8FAdWKG6WbJpamk2LVbCSq
	JtMD/eoV8nJLJrb13JGypNmiTc3kQfQoVu4bg6ke1
X-Gm-Gg: ASbGncty2Xmf0PIMEHdqv1yyxttGM3cpIfhHY173u/FjMt1okJRNKZ8tBKoyT6ty5Sc
	1NgKBOUPmkzEo4/ZycQqFq/42xT4m3x7MbNtbn3bsF5W7IBUJIWhPdezZm0pml/4cosuHccNZaf
	J46JT26c2ARbpe7/2gY1yDZXDCbXPbifNPeWmgvkb17g==
X-Google-Smtp-Source: AGHT+IH5s4lwSsFTldt+dXDMSKByvRxHx3zxyLmB61mFHIIoEKtY8K+M9lAp6KtlPOGZ8bgu/IWJW35ST9oT0XPqTww=
X-Received: by 2002:a05:6a20:a111:b0:215:cf53:c35 with SMTP id
 adf61e73a8af0-222d7ef7963mr6480943637.31.1751468796751; Wed, 02 Jul 2025
 08:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
 <20250701231306.376762-2-xiyou.wangcong@gmail.com> <aGSSF7K/M81Pjbyz@pop-os.localdomain>
 <CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com> <CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com>
In-Reply-To: <CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 2 Jul 2025 11:06:25 -0400
X-Gm-Features: Ac12FXxt_PrzBh_npYHtW7VFgc4muwcxZkqJQRGXi0MUwy2NJA7lcs_Jb3_zWsw
Message-ID: <CAM0EoM=CwJczYjCOYZzNJsjxz_dwaei5mTHyREYbS4iaE3drSg@mail.gmail.com>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, will@willsroot.io, stephen@networkplumber.org, 
	Savino Dicanosa <savy@syst3mfailure.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 11:04=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Jul 2, 2025 at 10:12=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Tue, Jul 1, 2025 at 9:57=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.=
com> wrote:
> > >
> > > On Tue, Jul 01, 2025 at 04:13:05PM -0700, Cong Wang wrote:
> > > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > > index fdd79d3ccd8c..33de9c3e4d1b 100644
> > > > --- a/net/sched/sch_netem.c
> > > > +++ b/net/sched/sch_netem.c
> > > > @@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *skb, s=
truct Qdisc *sch,
> > > >       skb->prev =3D NULL;
> > > >
> > > >       /* Random duplication */
> > > > -     if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor=
, &q->prng))
> > > > +     if (tc_skb_cb(skb)->duplicate &&
> > >
> > > Oops, this is clearly should be !duplicate... It was lost during my
> > > stupid copy-n-paste... Sorry for this mistake.
> > >
> >
> > I understood you earlier, Cong. My view still stands:
> > You are adding logic to a common data structure for a use case that
> > really makes no sense. The ROI is not good.
> > BTW: I am almost certain you will hit other issues when this goes out
> > or when you actually start to test and then you will have to fix more
> > spots.
> >
> Here's an example that breaks it:
>
> sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0 0
> sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
> netem_bug_test.o sec classifier/pass classid 1:1
> sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 10=
0%
> sudo tc qdisc add dev lo parent 10: handle 30: netem gap 1 limit 4
> duplicate 100% delay 1us reorder 100%
>
> And the ping 127.0.0.1 -c 1
> I had to fix your patch for correctness (attached)
>
>
> the ebpf prog is trivial - make it just return the classid or even zero.
>
> William, as a middle ground can you take a crack at using cb_ext -
> take a look for example at struct tc_skb_ext_alloc in cls_api.c (that
> one is safe to extend).
>
>
Meant: struct tc_skb_ext *ex

If you need help ping me privately - some latency will be involved..

cheers,
jamal

