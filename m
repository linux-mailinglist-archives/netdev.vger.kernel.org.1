Return-Path: <netdev+bounces-183324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F6DA905AC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8FF16A680
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C722156A;
	Wed, 16 Apr 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZdym7W6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEF71FF1C7;
	Wed, 16 Apr 2025 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812006; cv=none; b=TdoVWMcuLu528EeDdCJ8CKom1XNOIfi9ATt5X1ll+GFHbj9IoVs530BKR76yS5FaBezRUolrk8mK+lnzi+2FbltNFkNVtKXGGQYJ8OKJ4IQO7revJ3RxOy3BOL771Qjpr8maSGiaNLCcU7K4e4lZHozO7Roe+E1Flp0n95sodT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812006; c=relaxed/simple;
	bh=luuZwnA57py/IT0wbmPZ1ZWYUmQInFWtDeYolOtf3Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnOOq9qrPizMPl4MgpDNadxUi+ktoCMRe6Mqmi4PKO/yvI+VKQhUUfues+o1ogb8YGO0VnIGobhYMw8bDwijmdbHHHrj2sT9ADAGsUt19ZZLr3k4L82Uq8sP1ziCiQMZNV5uj6XEJ0K/EZJ9goO+yF835RiALMxNZOZttmTm12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZdym7W6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so11825691a12.0;
        Wed, 16 Apr 2025 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744812002; x=1745416802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUgvm+DiPpmDjC2mORrvt+5jPl+d2nrcr0fpozEFS0o=;
        b=AZdym7W6Je0cYSGQ5CDVv9gjbcqfNwb/w8VNxxPhsYpi8o9t68xIDw5ya2xFpCcw8v
         llUEMIweqKhqAVNr47RQkOxhuCokp0UwOu8Z3EdffpsVbgK3Xb0scaQHHkAqVQ9YkCkM
         ESY70AxFIRJwns4HorI9ju8GYoalH0+ytjNfQP5FVZEwrAR0fok9fEeiOWbG6GsXzw4l
         eQB92/2P2AtlkY/h6z3OCKrrduOo24nEN/UVHhYldnDBvTzMswym2TeWy2Hi1z1zG6NY
         frBKlBf8uhAjiUfsdctssdk1Db+3LsqayXhpiZzbNBWyHxezp+VSsIuoKSTFBJdCrE3T
         iZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744812002; x=1745416802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUgvm+DiPpmDjC2mORrvt+5jPl+d2nrcr0fpozEFS0o=;
        b=vu/lJQaPJOTbyfm58LEImWy5aNDNU6JjpZO/MIIA5g+lcb2yK71i6NjCEgHc/+0P1v
         SdCZnuSnGpBKA1GIdnaFCyZY8vemotwlfdtFlK9YkFZpY/S4FyBVRyxEOb2uAHGXGuV8
         VtOjLYUHHKRcE/SyyRpxz2JyJXwPakqjMW1UQI02EqWAI8OG9RkF3vIFH1wM5cC7OqTk
         wY8KOc3nNG4AFDzZb2LafOAvXmrttyz7nTqLWL5mUAiCNX3xYxaIiaZVNll/33dlxVFB
         lGtIL6fb6u7Im2xJ/Yc6WpEi2jdfdDaQ1CJ+tdTNX/I4AacyxHYWr9m0bKLdWayB+J4a
         9nAw==
X-Forwarded-Encrypted: i=1; AJvYcCUdvaObVQB8qbqUIw5i6LvOncKL6XGZ2ApkuzVcHimIM6OIBryF1vSNkm4y22vShEmWR9NxkSHn@vger.kernel.org, AJvYcCXgCmqk3hjNM6nxJ30QnfyYhJgN97pUwy9yewOCepTMxZuwCs1YnLTWbrRRgSoIdO6s8j8j1ooo50bubeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISnh+pJEdNWqukeapcxHT8pRqLtO71jkDoDIS4IEUjwolIvjS
	Oeg2cwlu9+tk7igpsjfMM+NJp1QNtbG9qSFWx5UCwRzSOUBO428GB24P9TDp/SHDAYKCTSbSr69
	p4+JMapfqHlSIeuetNW2eatYoUIs=
X-Gm-Gg: ASbGncv5Rg2aNzOlD6RV5d76hVhQ2tTUNlWpICmd0EexmmA+sONxQAM9NivzZ/wRfHW
	IQvFkiH2Wr1McwYGepGAf+zm3usgCKnheidCTsm3AJ78CcSPp00xTqT/Xjoa/bgZKRbMEJhNWkV
	Fi7I8KVjDfGwwVmxXoS2HA
X-Google-Smtp-Source: AGHT+IFybF67oGA69tGhjx227ggX9ZUR73/3iBTjwBDtuR4eg/2zNDJZjb1T1t5XXyD0pv+unM3x1++ujHfZ4rHc6yY=
X-Received: by 2002:a17:907:7b87:b0:ac7:f2b9:ec3b with SMTP id
 a640c23a62f3a-acb428748d0mr160511966b.4.1744812002038; Wed, 16 Apr 2025
 07:00:02 -0700 (PDT)
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
 <507eb775-d7df-4dd2-a7d1-626d5a51c1de@linux.dev>
In-Reply-To: <507eb775-d7df-4dd2-a7d1-626d5a51c1de@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Wed, 16 Apr 2025 16:59:33 +0300
X-Gm-Features: ATxdqUFIjnpeuKHyLdCEt5PwV7Ym-YP21Nq8a5H3aqMI-LdF0ngvFWyHmxIZvzM
Message-ID: <CAMuE1bFLB24ELFOSG=v+0hxJ+a+KGNWc8=Z3=kbXOs03PtLFOA@mail.gmail.com>
Subject: Re: [PATCH v1] ptp: ocp: fix NULL deref in _signal_summary_show
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: jonathan.lemon@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 1:35=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 16/04/2025 07:33, Sagi Maimon wrote:
> > On Mon, Apr 14, 2025 at 4:55=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 14/04/2025 14:43, Sagi Maimon wrote:
> >>> On Mon, Apr 14, 2025 at 4:01=E2=80=AFPM Vadim Fedorenko
> >>> <vadim.fedorenko@linux.dev> wrote:
> >>>>
> >>>> On 14/04/2025 12:38, Sagi Maimon wrote:
> >>>>> On Mon, Apr 14, 2025 at 2:09=E2=80=AFPM Vadim Fedorenko
> >>>>> <vadim.fedorenko@linux.dev> wrote:
> >>>>>>
> >>>>>> On 14/04/2025 11:56, Sagi Maimon wrote:
> >>>>>>> On Mon, Apr 14, 2025 at 12:37=E2=80=AFPM Vadim Fedorenko
> >>>>>>> <vadim.fedorenko@linux.dev> wrote:
> >>>>>>>>
> >>>>>>>> On 14/04/2025 09:54, Sagi Maimon wrote:
> >>>>>>>>> Sysfs signal show operations can invoke _signal_summary_show be=
fore
> >>>>>>>>> signal_out array elements are initialized, causing a NULL point=
er
> >>>>>>>>> dereference. Add NULL checks for signal_out elements to prevent=
 kernel
> >>>>>>>>> crashes.
> >>>>>>>>>
> >>>>>>>>> Fixes: b325af3cfab9 ("ptp: ocp: Add signal generators and updat=
e sysfs nodes")
> >>>>>>>>> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> >>>>>>>>> ---
> >>>>>>>>>       drivers/ptp/ptp_ocp.c | 3 +++
> >>>>>>>>>       1 file changed, 3 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> >>>>>>>>> index 7945c6be1f7c..4c7893539cec 100644
> >>>>>>>>> --- a/drivers/ptp/ptp_ocp.c
> >>>>>>>>> +++ b/drivers/ptp/ptp_ocp.c
> >>>>>>>>> @@ -3963,6 +3963,9 @@ _signal_summary_show(struct seq_file *s, =
struct ptp_ocp *bp, int nr)
> >>>>>>>>>           bool on;
> >>>>>>>>>           u32 val;
> >>>>>>>>>
> >>>>>>>>> +     if (!bp->signal_out[nr])
> >>>>>>>>> +             return;
> >>>>>>>>> +
> >>>>>>>>>           on =3D signal->running;
> >>>>>>>>>           sprintf(label, "GEN%d", nr + 1);
> >>>>>>>>>           seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%=
llu pol:%d",
> >>>>>>>>
> >>>>>>>> That's not correct, the dereference of bp->signal_out[nr] happen=
s before
> >>>>>>>> the check. But I just wonder how can that even happen?
> >>>>>>>>
> >>>>>>> The scenario (our case): on ptp_ocp_adva_board_init we
> >>>>>>> initiate only signals 0 and 1 so 2 and 3 are NULL.
> >>>>>>> Later ptp_ocp_summary_show runs on all 4 signals and calls _signa=
l_summary_show
> >>>>>>> when calling signal 2 or 3  the dereference occurs.
> >>>>>>> can you please explain: " the dereference of bp->signal_out[nr] h=
appens before
> >>>>>>> the check", where exactly? do you mean in those lines:
> >>>>>>> struct signal_reg __iomem *reg =3D bp->signal_out[nr]->mem;
> >>>>>>        ^^^
> >>>>>> yes, this is the line which dereferences the pointer.
> >>>>>>
> >>>>>> but in case you have only 2 pins to configure, why the driver expo=
ses 4
> >>>>>> SMAs? You can simply adjust the attributes (adva_timecard_attrs).
> >>>>>>
> >>>>> I can (and will) expose only 2 sma in adva_timecard_attrs, but stil=
l
> >>>>> ptp_ocp_summary_show runs
> >>>>> on all 4 signals and not only on the on that exposed, is it not a b=
ug?
> >>>>
> >>>> Yeah, it's a bug, but different one, and we have to fix it other way=
.
> >>>>
> >>> Do you want to instruct me how to fix it , or will you fix it?
> >>
> >> well, the original device structure was not designed to have the amoun=
t
> >> of SMAs less than 4. We have to introduce another field to store actua=
l
> >> amount of SMAs to work with, and adjust the code to check the value. T=
he
> >> best solution would be to keep maximum amount of 4 SMAs in the structu=
re
> >> but create a helper which will init new field and will have
> >> BUILD_BUG_ON() to prevent having more SMAs than fixed size array for
> >> them. That will solve your problem, but I will need to check it on the
> >> HW we run.
> >>
> > just to be clear you will write the fix and test it on your HW, so you
> > don't want me to write the fix?
>
> Well, it would be great if you can write the code which will make SMA
> functions flexible to the amount of pin the HW has. All our HW has fixed
> amount of 4 pins that's why the driver was coded with constants. Now
> your hardware has slightly different amount of pins, so it needs
> adjustments to the driver to work properly. I just want to be sure that
> any adjustments will not break my HW - that's what I meant saying I'll
> test it.
>
Just to be clear (correct me please if I am wrong):
I will write the code, then create a patch and upstream to the vanilla
you will test my change on your HW and only then approve the patch
> >>>>>>> struct ptp_ocp_signal *signal =3D &bp->signal[nr];
> >>>>>>>> I believe the proper fix is to move ptp_ocp_attr_group_add() clo=
ser to
> >>>>>>>> the end of ptp_ocp_adva_board_init() like it's done for other bo=
ards.
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> pw-bot: cr
> >>>>>>
> >>>>
> >>
>

