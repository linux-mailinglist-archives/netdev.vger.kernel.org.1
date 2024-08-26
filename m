Return-Path: <netdev+bounces-121816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D3895ED0B
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97F51F219CE
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 09:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BFE13D63E;
	Mon, 26 Aug 2024 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h48WR/xa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32A13A88D
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664375; cv=none; b=kwDLWDQcHTdwt/ZJ4jS7I/AAUeC/6jMMF3SoQLW6jh99sZwqO1QTW6Qp8Kb6rEeDrgRwSHT31nA17hKrbfg98uWLu49JduykVvbJ4U6YD8Fxo8V8Xy1KY7kwq/uE4BWEcJHcL0Gfp5OAGGkk2Y0S6vKiws+pHErRsD2JXV/W4l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664375; c=relaxed/simple;
	bh=Y+SCpwLCjMQIT/9/ruceV9kGAxqkFRg3bdbv+qg2fe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQhXdhDWfgRqsKwG/vT6YwqL/7/tM0WejTVDmxvVV5Pe0uPHA54zjUWSvfBT8T/X5DwuuakRy7Tu02iAyHg7oDKKmlMQ4b9tSohf6Id+YsV1QANx0fnFqwsICrTkwi254/Hk0zh9ykfShKBx2EfJgHFqo85P6IRUWopdkrcTuCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h48WR/xa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86883231b4so522455066b.3
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724664371; x=1725269171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvjHfLtkcdDqOOMH6gy28+rAw+JW40FMUdLrnoLzmi0=;
        b=h48WR/xauOsionhWwepJ29DyPOV3QB1JOcBaeXJaNBAoJnzC1oHK7hswHp86RpMo56
         diVG3maWab4Bc6570y451J/ThQJKUNHoSpbeLJYZM/A2NUXRLyfdqpO7wzfwwhDxHTf8
         TGtB22X4viI2j226K/KL0GcLz/L14vCDAKGSGeXb0AzbX2TVnCqkz/Hh6+OEnXBR7IU3
         J1Sg98ZzsPoATl+nlUbHsGIb4WZ3JQSh27DoC8Kwqtxbroq3deWv2wDUrSWK3XONzZZL
         XONlSJKp4OY1KLi71csoYIxUmm6mHzrvJs8TUFulrProbeFbsQeh01gxhjZLFeuP7uAJ
         ySSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724664371; x=1725269171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvjHfLtkcdDqOOMH6gy28+rAw+JW40FMUdLrnoLzmi0=;
        b=vyEYchFRowq6Y07ur49Xlf8QsZudd4kF4n0rt4ccOYdi4EowohXC+N/80BiXCgCYeq
         h3i8q5uVNStGdauVmfKFKszZ7poped0BuWh9nBcdB6NPuHAlH5wwKLrLgyoAFkJbLkcr
         ob2DagN2zB1//sOFiS6FV/HT/pnYpQGsCseyN+lAPgjpdysXNzYvM5u6Aqie7HwZBQuX
         GBybajLT8+xKAK6XNBIvyX8HJKaWEoohK0nc4v0dSDDvJllSQ0DTIYzRdxSUJgFQ+oud
         fVyQc9qZoFkmt8gcRivFyk/jGHmahvstBGRDgjVtHuiWb2I/Fx4eApT1Gq3d7fVKXxcE
         j4gA==
X-Forwarded-Encrypted: i=1; AJvYcCV0dzRH8HSuH5e243UNKIzykymgq6Gn4kC8hKaN5qxJ3qPH9UMvxaZp3+yfbzTJ4uXoCHAihJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAY1wubRCJmmoTE9cPc69zttbn1Bv8s65vkrIX51D0KyLzmlR
	qKs5mNfIV9j+6B+GBB3Erfaq9sfi91HJVWfkZwj0zHJvnDtUl43D2e7Qal/d9KR2L0fLwMBALC1
	9wkBGf9MWdISpyurmmbCnDshnk06slC7TJBP6
X-Google-Smtp-Source: AGHT+IGHKcGcrdvzRqsGId1F7jVfZZU7cxDU5VPxrcPGbB90f48DL8pCoo1eX9y3XgOzD8Yn0IbgAny2IkSSu0h2/QE=
X-Received: by 2002:a17:907:3ea2:b0:a7a:9144:e242 with SMTP id
 a640c23a62f3a-a86a52b5ccfmr597495966b.27.1724664370630; Mon, 26 Aug 2024
 02:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817163400.2616134-1-mrzhang97@gmail.com> <20240817163400.2616134-2-mrzhang97@gmail.com>
 <CANn89iKwN8vCH4Dx0mYvLJexWEmz5TWkfvCFnxmqKGgTTzeraQ@mail.gmail.com>
 <573e24dc-81c7-471f-bdbf-2c6eb2dd488d@gmail.com> <CANn89i+yoe=GJXUO57V84WM3FHqQBOKsvEN3+9cdp_UKKbT4Mw@mail.gmail.com>
 <cf64e6ab-7a2b-4436-8fe2-1f381ead2862@gmail.com>
In-Reply-To: <cf64e6ab-7a2b-4436-8fe2-1f381ead2862@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Aug 2024 11:25:59 +0200
Message-ID: <CANn89iL1g3VQHDfru2yZrHD8EDgKCKGL7-AjYNw+oCdeBQLfow@mail.gmail.com>
Subject: Re: [PATCH net v4 1/3] tcp_cubic: fix to run bictcp_update() at least
 once per RTT
To: Mingrui Zhang <mrzhang97@gmail.com>
Cc: davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org, 
	Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 7:47=E2=80=AFPM Mingrui Zhang <mrzhang97@gmail.com>=
 wrote:
>
> On 8/20/24 07:53, Eric Dumazet wrote:
> > On Mon, Aug 19, 2024 at 10:36=E2=80=AFPM Mingrui Zhang <mrzhang97@gmail=
.com> wrote:
> >> On 8/19/24 04:00, Eric Dumazet wrote:
> >>> On Sat, Aug 17, 2024 at 6:35=E2=80=AFPM Mingrui Zhang <mrzhang97@gmai=
l.com> wrote:
> >>>> The original code bypasses bictcp_update() under certain conditions
> >>>> to reduce the CPU overhead. Intuitively, when last_cwnd=3D=3Dcwnd,
> >>>> bictcp_update() is executed 32 times per second. As a result,
> >>>> it is possible that bictcp_update() is not executed for several
> >>>> RTTs when RTT is short (specifically < 1/32 second =3D 31 ms and
> >>>> last_cwnd=3D=3Dcwnd which may happen in small-BDP networks),
> >>>> thus leading to low throughput in these RTTs.
> >>>>
> >>>> The patched code executes bictcp_update() 32 times per second
> >>>> if RTT > 31 ms or every RTT if RTT < 31 ms, when last_cwnd=3D=3Dcwnd=
.
> >>>>
> >>>> Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
> >>>> Fixes: ac35f562203a ("tcp: bic, cubic: use tcp_jiffies32 instead of =
tcp_time_stamp")
> >>> I do not understand this Fixes: tag ?
> >>>
> >>> Commit  ac35f562203a was essentially a nop at that time...
> >>>
> >> I may misunderstood the use of Fixes tag and choose the latest commit =
of that line.
> >>
> >> Shall it supposed to be the very first commit with that behavior?
> >> That is, the very first commit (df3271f3361b ("[TCP] BIC: CUBIC window=
 growth (2.0)")) when the code was first introduced?
> > I was referring to this line : Fixes: ac35f562203a ("tcp: bic, cubic:
> > use tcp_jiffies32 instead of tcp_time_stamp")
> >
> > Commit ac35f562203a did not change the behavior at all.
> >
> > I see no particular reason to mention it, this is confusing.
> >
> >
> >>>> Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
> >>>> Signed-off-by: Lisong Xu <xu@unl.edu>
> >>>> ---
> >>>> v3->v4: Replace min() with min_t()
> >>>> v2->v3: Correct the "Fixes:" footer content
> >>>> v1->v2: Separate patches
> >>>>
> >>>>  net/ipv4/tcp_cubic.c | 6 +++++-
> >>>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> >>>> index 5dbed91c6178..00da7d592032 100644
> >>>> --- a/net/ipv4/tcp_cubic.c
> >>>> +++ b/net/ipv4/tcp_cubic.c
> >>>> @@ -218,8 +218,12 @@ static inline void bictcp_update(struct bictcp =
*ca, u32 cwnd, u32 acked)
> >>>>
> >>>>         ca->ack_cnt +=3D acked;   /* count the number of ACKed packe=
ts */
> >>>>
> >>>> +       /* Update 32 times per second if RTT > 1/32 second,
> >>>> +        * or every RTT if RTT < 1/32 second even when last_cwnd =3D=
=3D cwnd
> >>>> +        */
> >>>>         if (ca->last_cwnd =3D=3D cwnd &&
> >>>> -           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
> >>>> +           (s32)(tcp_jiffies32 - ca->last_time) <=3D
> >>>> +           min_t(s32, HZ / 32, usecs_to_jiffies(ca->delay_min)))
> >>> This looks convoluted to me and still limited if HZ=3D250 (some distr=
os
> >>> still use 250 jiffies per second :/ )
> >>>
> >>> I would suggest switching to usec right away.
> >> Thank you for the suggestion, however, I may need more time to discuss=
 with another author for this revision. :)
> >> Thank you
> > No problem, there is no hurry.
>
> Thank you, Eric, for your suggestion (switching ca->last_time from jiffie=
s to usec)!
> We thought about it and feel that it is more complicated and beyond the s=
cope of this patch.
>
> There are two blocks of code in bictcp_update().
> * Block 1: cubic calculation, which is computationally intensive.
> * Block 2: tcp friendliness, which emulates RENO.
>
> There are two if statements to control how often these two blocks are cal=
led to reduce CPU overhead.
>  * If statement 1:  if the condition is true, none of the two blocks are =
called.
> if (ca->last_cwnd =3D=3D cwnd &&
>                     (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
>                                 return;
>
> * If statement 2: If the condition is true, block 1 is not called. Intuit=
ively, block 1 is called at most once per jiffy.
> if (ca->epoch_start && tcp_jiffies32 =3D=3D ca->last_time)
>                                 goto tcp_friendliness;
>
>
> This patch changes only the first if statement. If we switch ca->last_tim=
e from jiffies to usec,
> we need to change not only the first if statement but also the second if =
statement, as well as block 1.
> * change the first if statement from jiffies to usec.
> * change the second if statement from jiffies to usec. Need to determine =
how often (in usec) block 1 is called
> * change block 1 from jiffies to usec. Should be fine, but need to make s=
ure no calculation overflow.

No problem, I can take care of the jiffies -> usec conversion, you can
then send your patch on top of it.

>
> Therefore, it might be better to keep the current patch as it is, and add=
ress the switch from jiffies to usec in future patches.

I prefer you rebase your patch after mine is merged.

There is a common misconception with jiffies.
It can change in less than 20 nsec.
Assuming that delta(jiffies) =3D=3D 1 means that 1ms has elapsed is plain w=
rong.
In the old days, linux TCP only could rely on jiffies and we had to
accept its limits.
We now can switch to high resolution clocks, without extra costs,
because we already cache in tcp->tcp_mstamp
the usec timestamp for the current time.

Some distros are using CONFIG_HZ_250=3Dy or CONFIG_HZ_100=3Dy, this means
current logic in cubic is more fuzzy for them.

Without ca->last_time conversion to jiffies, your patch would still be
limited to jiffies resolution:
usecs_to_jiffies(ca->delay_min) would round up to much bigger values
for DC communications.

