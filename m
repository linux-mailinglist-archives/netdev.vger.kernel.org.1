Return-Path: <netdev+bounces-86927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF488A0D26
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 12:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5A61C212DB
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 10:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7498145323;
	Thu, 11 Apr 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlB7w+A0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FFE2EAE5
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829650; cv=none; b=eYrvPotdc84Nq2Xl9F50yVaMp/L2pfC61iNSdFB1ppvSEuAXX2rG2ODbWg3xm3vU76v/i7BT/HzkD9lYwHggADD8k5hChEqLbTrk81u2cxVPgsqExXD6cTwP/H30ovOeI8dZR6Gd2enjVF+plkAwbiy1SjaQ3ak5gA0PrCsyGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829650; c=relaxed/simple;
	bh=3EmwNd2x+X34BSWGzOFdFW4U4J1q0hSXrmCHKXd9PRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRtFCVwLqaUMKIap2zc84nte7Gw1oAMsu7B+s8h/tikYODAbmGY814ePVyr14bUe01R9LH7FCHT71GQ3vpjWqnNhNQf8p1OMLRD0cYPuaq/+wGfw7T3v9b5xIByD7V4qq4qnPDpJ/FVXM0lW44aOf9XSkt/EsBke+S4QsROCjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlB7w+A0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so5806623a12.1
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 03:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712829647; x=1713434447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOdB4x8afbnVlYVCM2wbaCRzbxId+WgzI5n5to5Qn6M=;
        b=ZlB7w+A0r9tdNCuZIHqyMsiP3IMsk7LmGzbmmfA7pwcV42vNeybPSdKK/nikFnI8PF
         CesjvJkviK2/bOWJZIveBqaKTv0TV2eVUeoNr4yWPqwIu+QzhwvBs0haQwB9oirmMtYI
         1GQ9Zfwv8SYwO9jihxH00BSeH3XX9bhZ+BEsd/h/ox1dQi5NS1Q13dh365U1v/r1MOlf
         HkZurIKFZqDvXruttGh0mPNMBfM2tKnPtqNvyOunr5twHhoIWRxwJR23+KlgjYgvBxSd
         7pG8CDDMJ/Hwx3PLqyln7dWAsMwTmLYmM2jz40MxzP/Zp5fGj+WV/+Y4XTFFRXt0D/mI
         RwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712829647; x=1713434447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOdB4x8afbnVlYVCM2wbaCRzbxId+WgzI5n5to5Qn6M=;
        b=XWBdWmIrmLxM0nDgYd+Pfg+q585J5IshN5rlhPxAxNwsjhGN11VI+kqYPz3ysbqxwl
         zB+NWObbppVe1nB8QynvN/EnAIiTszhuCG4hXEjRKtdkW1BOTkmSxXN71mS38pZ8zMKb
         BY7ZQwtd3dHsqTYPco69mNLenccjg8tDB/HZEGs3VRc7MBULMvA/c9t1Sq8rwHaSlmKI
         1b627bpUyFbdj0eIoyHMwluOV+63w/5CJkEa8M24McvPk3UWRhz8hAvdlIrZ7F0oTqnl
         7/jwyXKa1GN44WC/HRlGVpJUaCOiTyfXJSs+e8bGeoZDtZa/xRlrYgFgCixy7RhH+JMN
         5wDw==
X-Forwarded-Encrypted: i=1; AJvYcCWbgxh6SvqiO/HIwxFAW7t3sBI4mCVrX+y9Kt9LADVAoXqO7l1efBVPSlv1FlMuQJD8FoDL/odyoKMld15yoPZOjLvEGHAD
X-Gm-Message-State: AOJu0YyYTwF0hJjUeEDBxKQH60Q+UrEwFoAeeMlvxt54xir8BVyKe4EW
	yPtIZ3GMXiVN8d0fvgqbuDXmy0JWsa1sjp1HFKS98Z0Ll1e9hg0gQqcMI1xZpi5ZqjSxnzG+A8K
	EVwEh9xh3cFWWG6h1PN1Ye5tJ3ME=
X-Google-Smtp-Source: AGHT+IGN5e1TtN3ujvsVdXPCw6YArdN4+GZpOAb428Jybeitg709LBNMDGHxcwQh6V07m3mXIDQ6gbTYbhMAmYbe0EQ=
X-Received: by 2002:a17:906:b2d8:b0:a4e:a7a:84e0 with SMTP id
 cf24-20020a170906b2d800b00a4e0a7a84e0mr3018903ejb.34.1712829646940; Thu, 11
 Apr 2024 03:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411032450.51649-1-kerneljasonxing@gmail.com>
 <CANn89i+2XdNxYHFNwC5LHupT3je1EaZXMxMJG9343ZO9vCzAsg@mail.gmail.com>
 <CAL+tcoC2FW2_xp==NKATKi_QW2N2ZTB1UVPadUyECgYxV9jXRQ@mail.gmail.com>
 <CANn89i+6gWXDpnwM9aFtP_d_oTfQRDJdu+VMoDtvVcDrzBM_JA@mail.gmail.com>
 <CAL+tcoAZYeFsoPEFvWSFUTezofpkvwzggJd9zp81yTAy4PVOpw@mail.gmail.com> <fe6f2325-7454-413e-acba-b3c5f3313dfe@intel.com>
In-Reply-To: <fe6f2325-7454-413e-acba-b3c5f3313dfe@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 11 Apr 2024 18:00:09 +0800
Message-ID: <CAL+tcoAf1FyqEsM-u-shGaE2FUQO_di6e63md_DYmFLWxXe3ew@mail.gmail.com>
Subject: Re: [PATCH net-next] net: save some cycles when doing skb_attempt_defer_free()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, pablo@netfilter.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:13=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 11 Apr 2024 15:31:23 +0800
>
> > On Thu, Apr 11, 2024 at 3:12=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> >>
> >> On Thu, Apr 11, 2024 at 8:33=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> >>>
> >>> On Thu, Apr 11, 2024 at 1:27=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> >>>>
> >>>> On Thu, Apr 11, 2024 at 5:25=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> >>>>>
> >>>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>>
> >>>>> Normally, we don't face these two exceptions very often meanwhile
> >>>>> we have some chance to meet the condition where the current cpu id
> >>>>> is the same as skb->alloc_cpu.
> >>>>>
> >>>>> One simple test that can help us see the frequency of this statemen=
t
> >>>>> 'cpu =3D=3D raw_smp_processor_id()':
> >>>>> 1. running iperf -s and iperf -c [ip] -P [MAX CPU]
> >>>>> 2. using BPF to capture skb_attempt_defer_free()
> >>>>>
> >>>>> I can see around 4% chance that happens to satisfy the statement.
> >>>>> So moving this statement at the beginning can save some cycles in
> >>>>> most cases.
> >>>>>
> >>>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >>>>> ---
> >>>>>  net/core/skbuff.c | 4 ++--
> >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >>>>> index ab970ded8a7b..b4f252dc91fb 100644
> >>>>> --- a/net/core/skbuff.c
> >>>>> +++ b/net/core/skbuff.c
> >>>>> @@ -7002,9 +7002,9 @@ void skb_attempt_defer_free(struct sk_buff *s=
kb)
> >>>>>         unsigned int defer_max;
> >>>>>         bool kick;
> >>>>>
> >>>>> -       if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
> >>>>> +       if (cpu =3D=3D raw_smp_processor_id() ||
> >>>>>             !cpu_online(cpu) ||
> >>>>> -           cpu =3D=3D raw_smp_processor_id()) {
> >>>>> +           WARN_ON_ONCE(cpu >=3D nr_cpu_ids)) {
> >>>>>  nodefer:       kfree_skb_napi_cache(skb);
> >>>>>                 return;
> >>>>>         }
> >>>>
> >>>> Wrong patch.
> >>>>
> >>>> cpu_online(X) is undefined and might crash if X is out of bounds on =
CONFIG_SMP=3Dy
> >>>
> >>> Even if skb->alloc_cpu is larger than nr_cpu_ids, I don't know why th=
e
> >>> integer test statement could cause crashing the kernel. It's just a
> >>> simple comparison. And if the statement is true,
> >>> raw_smp_processor_id() can guarantee the validation, right?
> >>
> >> Please read again the code you wrote, or run it with skb->alloc_cpu
> >> being set to 45000 on a full DEBUG kernel.
> >>
> >> You are focusing on skb->alloc_cpu =3D=3D raw_smp_processor_id(), I am
> >> focusing on what happens
> >> when this condition is not true.
> >
> > Sorry. My bad. I put the wrong order of '!cpu_online(cpu)' and 'cpu >=
=3D
> > nr_cpu_ids'. I didn't consider the out-of-bound issue. I should have
> > done more checks :(
> >
> > The correct patch should be:
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index ab970ded8a7b..6dc577a3ea6a 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -7002,9 +7002,9 @@ void skb_attempt_defer_free(struct sk_buff *skb)
> >         unsigned int defer_max;
> >         bool kick;
> >
> > -       if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
> > -           !cpu_online(cpu) ||
> > -           cpu =3D=3D raw_smp_processor_id()) {
> > +       if (cpu =3D=3D raw_smp_processor_id() ||
> > +           WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
> > +           !cpu_online(cpu)) {
>
> This one looks good to me.
> Feel free to add
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>
> To your v2 before sending.

Thanks! I will:)

