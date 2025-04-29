Return-Path: <netdev+bounces-186688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD819AA05FC
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2435E4A0632
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 08:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AB228B51F;
	Tue, 29 Apr 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnOQ1nkc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE52512E6;
	Tue, 29 Apr 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916153; cv=none; b=c869JkDec4IGOMA6WdEbZyx0M/uV4kaJM2lWUecJENkV7NtCvzA2B8m+ZGDbFu+u8tbVW6VY+pehycu0ZQkB1RRRvdMap2U0JM19qUaeQLf6Rr09MVMbuPPGj6NaaegyLdwpnynBnRbw4d9ZnRHlFN3aJN1mezvItkGBgD4K8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916153; c=relaxed/simple;
	bh=CXbPy436EifD5EG3lHLWxpZF845jKZCutFVoT2XFuf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/THnaLBIudmAkXWPQkJ5RECAkgysAlSNuhw0ZnuSJx+wh5iVJLsehflV1g1QA8Dvv4RnDsrA+0zLP/HhlYHcoF03JWdSgq1wrffRO0+gFXo+ZxLrRkksiFiq5yJiEtQPGJKduClb7xzoGCg/hk3eYpqWqyY18AS1+fgWLM1vjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnOQ1nkc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac3b12e8518so963524666b.0;
        Tue, 29 Apr 2025 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745916149; x=1746520949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToMiRGUzkQ1Ik/gxaxy5aFixXwQGUH4mfGg/aR/GNTA=;
        b=TnOQ1nkcJmSxI5DfGneOp1gNUDXirDe/Y93T5bF3Sh6QVeuYzOMZ08s8kUFt9A4tfE
         YOzBz7GlMxv/KcHDFLiX13n5WlMRAzYdhBgZ/aLv6OnFGOHiVUgTO1fpuKlZJ/MNfHWq
         8KpdL8OhdV/n+Bl14zKaMSQIQgsuX2mZosxKOw5/n6sqXzeuZFiKCYJSd9npLpvnU9Qg
         6aAja9Vc7y1K74vz2+2zOdAHdAEiN6QppdqSZ3v1DDcbAH34LfrP5Ox/vBuqb8rGDcIk
         FUY1x6KdM02pDDWTaU7JJNXIKvYx4qcUoyyKq6LDg1ufcwx5bHMENYYrQa6CG/ieN9c1
         CpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745916149; x=1746520949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToMiRGUzkQ1Ik/gxaxy5aFixXwQGUH4mfGg/aR/GNTA=;
        b=bEGfdNDS2g73nsJObT8LQzEgjEeP8CSb4E5lgwKA/ZMJfybXiTenfR8Qq+cBqIC7Z4
         aVTo5O/2jSbvLthuZH8K8aYl6HGXGwEoEZw8F7FtWlYGI3rhCjie1tbEV9Od1wY0gmUX
         cgFpw3+rdx5tTeFWd0KZfbZIMx7m1CGgbwv7fNJua0RDS3oJCJ5/QM9A2AXnm5hM3NFf
         GSUVDuAfp/KAMJzwpRZaCAzRDiNjxqxdLuPhenc13hoa1laxuTxtCKWjvuCAi7h4faEP
         vbUSsx2PbO8QY2c0Uwu5RsmJlxSyvuYnVHZG4Gh8wJN4hO7V16ePCwD6dDHK6lfm9puZ
         SomQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFeoSF2wuv5lW7E+okq4Uf2W5RhXsTzjNFJNU8QaxBrUciI/iJObAN0LfX+94JMYyE7X+R1gd1@vger.kernel.org, AJvYcCWqboz0ChFsiwrKLozC9HKSxCZMif3BSRR+zCpIl+7bTEQ/d/saZwcii9APzekaT+/5Q7OkJWa1ZgZ0gos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxktR9xKkW0z9XqSZDR7I5jEhZytkya26NO2bd7Ec0SFccxPomX
	GBrfe/rx38Q//hX80tTbECfJLGsgN9ZGXmeFpHKJgHqJNzo1lc4pQq4StSlh/YssDHza9DZpuwi
	ntH/GDchplO9RxDkAEFb2nKacgoI=
X-Gm-Gg: ASbGncsHAZlSER4fQR8W/CsySR2b1GzjJzu6HMqDp+iNn72wDCpYZouVv7jy3zkPCoN
	cyhqXXekr7QLr2Eh+/t9o/3xfTy3nQI2N+PllCnDUwsEOnAsNde6ySWgiPRijnVqldWyQZbU1nx
	B11ACJkwK7lJHi/c8t/WOU
X-Google-Smtp-Source: AGHT+IHUXlvcJkx900HQTsgDMIdKlW/ZeeL9afbnQyPHkTJ6qnwBtdIUCFzf6ooEyTr9qZEbAXaN9dzXcKgKJYwPH+o=
X-Received: by 2002:a17:907:3ea3:b0:ac6:b729:9285 with SMTP id
 a640c23a62f3a-ace84b55b08mr1089871666b.55.1745916149347; Tue, 29 Apr 2025
 01:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414085412.117120-1-maimon.sagi@gmail.com>
 <b6aea926-ebb6-48fe-a1be-6f428a648eae@linux.dev> <CAMuE1bG_+qj++Q0OXfBe3Z_aA-zFj3nmzr9CHCuKJ_Jr19oWEg@mail.gmail.com>
 <aa9a1485-0a0b-442b-b126-a00ee5d4801c@linux.dev> <CAMuE1bETL1+sGo9wq46O=Ad-_aa8xNLK0kWC63Mm5rTFdebp=w@mail.gmail.com>
 <39839bcb-90e9-4886-913d-311c75c92ad8@linux.dev> <CAMuE1bHsPeaokc-_qR4Ai8o=b3Qpbosv6MiR5_XufyRTtE4QFQ@mail.gmail.com>
 <44b67f86-ed27-49e8-9e15-917fa2b75a60@linux.dev> <CAMuE1bFk=LFTWfu8RFJeSoPtjO8ieJDdEHhHpKYr4QxqB-7BBg@mail.gmail.com>
 <507eb775-d7df-4dd2-a7d1-626d5a51c1de@linux.dev> <CAMuE1bFLB24ELFOSG=v+0hxJ+a+KGNWc8=Z3=kbXOs03PtLFOA@mail.gmail.com>
 <fd813f14-ea75-4f5a-a99e-d2925c25ccd2@linux.dev>
In-Reply-To: <fd813f14-ea75-4f5a-a99e-d2925c25ccd2@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:02 +0300
X-Gm-Features: ATxdqUEks4OZsBQ5J835aP-TOiJX7VYVAqgJmn1uDnVwMEsfZ95mbQCzlsHZYVo
Message-ID: <CAMuE1bEH0e+GAsCumED0TdXihtsmYV4T5uRLmz7_pePt8RNQzQ@mail.gmail.com>
Subject: Re: [PATCH v1] ptp: ocp: fix NULL deref in _signal_summary_show
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: jonathan.lemon@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 5:45=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 16/04/2025 14:59, Sagi Maimon wrote:
> > On Wed, Apr 16, 2025 at 1:35=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 16/04/2025 07:33, Sagi Maimon wrote:
> >>> On Mon, Apr 14, 2025 at 4:55=E2=80=AFPM Vadim Fedorenko
> >>> <vadim.fedorenko@linux.dev> wrote:
> >>>>
> >>>> On 14/04/2025 14:43, Sagi Maimon wrote:
> >>>>> On Mon, Apr 14, 2025 at 4:01=E2=80=AFPM Vadim Fedorenko
> >>>>> <vadim.fedorenko@linux.dev> wrote:
> >>>>>>
> >>>>>> On 14/04/2025 12:38, Sagi Maimon wrote:
> >>>>>>> On Mon, Apr 14, 2025 at 2:09=E2=80=AFPM Vadim Fedorenko
> >>>>>>> <vadim.fedorenko@linux.dev> wrote:
> >>>>>>>>
> >>>>>>>> On 14/04/2025 11:56, Sagi Maimon wrote:
> >>>>>>>>> On Mon, Apr 14, 2025 at 12:37=E2=80=AFPM Vadim Fedorenko
> >>>>>>>>> <vadim.fedorenko@linux.dev> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 14/04/2025 09:54, Sagi Maimon wrote:
> >>>>>>>>>>> Sysfs signal show operations can invoke _signal_summary_show =
before
> >>>>>>>>>>> signal_out array elements are initialized, causing a NULL poi=
nter
> >>>>>>>>>>> dereference. Add NULL checks for signal_out elements to preve=
nt kernel
> >>>>>>>>>>> crashes.
> >>>>>>>>>>>
> >>>>>>>>>>> Fixes: b325af3cfab9 ("ptp: ocp: Add signal generators and upd=
ate sysfs nodes")
> >>>>>>>>>>> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>        drivers/ptp/ptp_ocp.c | 3 +++
> >>>>>>>>>>>        1 file changed, 3 insertions(+)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> >>>>>>>>>>> index 7945c6be1f7c..4c7893539cec 100644
> >>>>>>>>>>> --- a/drivers/ptp/ptp_ocp.c
> >>>>>>>>>>> +++ b/drivers/ptp/ptp_ocp.c
> >>>>>>>>>>> @@ -3963,6 +3963,9 @@ _signal_summary_show(struct seq_file *s=
, struct ptp_ocp *bp, int nr)
> >>>>>>>>>>>            bool on;
> >>>>>>>>>>>            u32 val;
> >>>>>>>>>>>
> >>>>>>>>>>> +     if (!bp->signal_out[nr])
> >>>>>>>>>>> +             return;
> >>>>>>>>>>> +
> >>>>>>>>>>>            on =3D signal->running;
> >>>>>>>>>>>            sprintf(label, "GEN%d", nr + 1);
> >>>>>>>>>>>            seq_printf(s, "%7s: %s, period:%llu duty:%d%% phas=
e:%llu pol:%d",
> >>>>>>>>>>
> >>>>>>>>>> That's not correct, the dereference of bp->signal_out[nr] happ=
ens before
> >>>>>>>>>> the check. But I just wonder how can that even happen?
> >>>>>>>>>>
> >>>>>>>>> The scenario (our case): on ptp_ocp_adva_board_init we
> >>>>>>>>> initiate only signals 0 and 1 so 2 and 3 are NULL.
> >>>>>>>>> Later ptp_ocp_summary_show runs on all 4 signals and calls _sig=
nal_summary_show
> >>>>>>>>> when calling signal 2 or 3  the dereference occurs.
> >>>>>>>>> can you please explain: " the dereference of bp->signal_out[nr]=
 happens before
> >>>>>>>>> the check", where exactly? do you mean in those lines:
> >>>>>>>>> struct signal_reg __iomem *reg =3D bp->signal_out[nr]->mem;
> >>>>>>>>         ^^^
> >>>>>>>> yes, this is the line which dereferences the pointer.
> >>>>>>>>
> >>>>>>>> but in case you have only 2 pins to configure, why the driver ex=
poses 4
> >>>>>>>> SMAs? You can simply adjust the attributes (adva_timecard_attrs)=
.
> >>>>>>>>
> >>>>>>> I can (and will) expose only 2 sma in adva_timecard_attrs, but st=
ill
> >>>>>>> ptp_ocp_summary_show runs
> >>>>>>> on all 4 signals and not only on the on that exposed, is it not a=
 bug?
> >>>>>>
> >>>>>> Yeah, it's a bug, but different one, and we have to fix it other w=
ay.
> >>>>>>
> >>>>> Do you want to instruct me how to fix it , or will you fix it?
> >>>>
> >>>> well, the original device structure was not designed to have the amo=
unt
> >>>> of SMAs less than 4. We have to introduce another field to store act=
ual
> >>>> amount of SMAs to work with, and adjust the code to check the value.=
 The
> >>>> best solution would be to keep maximum amount of 4 SMAs in the struc=
ture
> >>>> but create a helper which will init new field and will have
> >>>> BUILD_BUG_ON() to prevent having more SMAs than fixed size array for
> >>>> them. That will solve your problem, but I will need to check it on t=
he
> >>>> HW we run.
> >>>>
> >>> just to be clear you will write the fix and test it on your HW, so yo=
u
> >>> don't want me to write the fix?
> >>
> >> Well, it would be great if you can write the code which will make SMA
> >> functions flexible to the amount of pin the HW has. All our HW has fix=
ed
> >> amount of 4 pins that's why the driver was coded with constants. Now
> >> your hardware has slightly different amount of pins, so it needs
> >> adjustments to the driver to work properly. I just want to be sure tha=
t
> >> any adjustments will not break my HW - that's what I meant saying I'll
> >> test it.
> >>
> > Just to be clear (correct me please if I am wrong):
> > I will write the code, then create a patch and upstream to the vanilla
> > you will test my change on your HW and only then approve the patch
>
> Yes, that's correct
>
On altera we have implemented 2 signals and 4 SMAs (does not make sense, bu=
t...)
The original fix is regarding struct ptp_ocp_signal signal[4], but on
your fix suggestion
you mension SMAs.
So what to do? fix the SMA array or signal array or both?
and if both should we establish some connection between the two
meaning if we have only
two SMAs then we can initiate only two signals?
please advise
> >>>>>>>>> struct ptp_ocp_signal *signal =3D &bp->signal[nr];
> >>>>>>>>>> I believe the proper fix is to move ptp_ocp_attr_group_add() c=
loser to
> >>>>>>>>>> the end of ptp_ocp_adva_board_init() like it's done for other =
boards.
> >>>>>>>>>>
> >>>>>>>>>> --
> >>>>>>>>>> pw-bot: cr
> >>>>>>>>
> >>>>>>
> >>>>
> >>
>

