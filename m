Return-Path: <netdev+bounces-183133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8B7A8B061
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 08:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95257A8B21
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAC1205513;
	Wed, 16 Apr 2025 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lccIlTEq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0914B08E;
	Wed, 16 Apr 2025 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785270; cv=none; b=oWp3GehJCY+PW4uJVwbTZWzZElszVN5keZh3OtIAJutFuaoeZFQP6aTn4Anl67SRw7Z7dLrvpCnWqmwdZdzI8bGvhvplvLQX+MaH5HJQHX9EswBdD4QPvMC0rPh2hsvKtlzYbenkW4cQe/vKOCCDAZKf1vPIiiVZsN+PXFdLCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785270; c=relaxed/simple;
	bh=YniLFe3UERRSSPUEw+oHySwXKfo1VLGe0HjWv5wozcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Si50AhMO8X+t6j8UWBWPos/UC71JRpqKlgj9pH/Y4OYBnLcP1agfNorBRaHmwBFpxMkwcR6hMuufsKnjpQaBkv7gdMG99jWK+NcXBK9NoNGqZRlHICfW+Odm+0FATvMrxCfguhF99rXgGdLQ6ceUlUrEFLgCpbzqVtFgcINKtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lccIlTEq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso6205803a12.1;
        Tue, 15 Apr 2025 23:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744785266; x=1745390066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYs2gPcGPRZ+Q14kdkf71kSs7E26vp36VxMzVUDqm8o=;
        b=lccIlTEqTxdmENPQ0bz1/jSDlQNc8MYvpR5BodbsnC4Q+otiao9xSlpV06nVBD/NEJ
         Ox+2PGEy1pBNgD41ZgekJnDvgzO9J4yTJ96Pei6hjEUiCRPntpJTd92GvtYZ/wF5iXZr
         mWWolw9kJaliDJyDhQfBLemgebHo5M6UTU08rzbvPdRKEH0lzr/I/gAIo0QDA01/M9yO
         oBHOV0/dtRQEw9TubZXAhorRm/kQdoI80+GtA04uhoZAK+2eApA9WBZvt16e4N1coI2H
         F4bT8iG4jh70iU79g3CyRP36I9aBkkQZfH0G6BlKfnQLUf68eD10EjOwQQfxjEjPnmci
         0VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785266; x=1745390066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYs2gPcGPRZ+Q14kdkf71kSs7E26vp36VxMzVUDqm8o=;
        b=LYExG92Hu64KXQYW4Tmsks9e05347Sag+YBMdbEZZT0/j+xYAdmUp0HA87k9GIFVhc
         5/wWTM/pjd5cpKiu3IoubNHx/I7/5aC6Cmh+0JYk6uUJEBke2mur2cF0SPQdkrX71K29
         6djCtUXoIILSJ0etAYIU0bztIC/1SsUTsnOHEapxqDuT7jnnffOMIdskhqjDX4RIb1DM
         CMOC/dVIPXGgNdhY9AlxEHp/pLrb/SoA0Krky6GQ836valtPMESVo3DV0ET9g//K+njD
         kpYm6fhu30W21hBeN94pEcXKZkMoX8iuCzGX0pfpPMvncKDccjws1e245/1fSTnLblKv
         lXLw==
X-Forwarded-Encrypted: i=1; AJvYcCVkUGDKXzssNPTY8mCUsY5OGSQnh7GHPG9BHicEHf1i/XeI7HqN/kh6OC0/pNNMSFo3S6OfEgwL@vger.kernel.org, AJvYcCXcpyjlz63Wab/nAurPCsAuiGxPtz1RMhDYvSLywfIeDj1Q0afA6iP/Th3OZnaWUWPF48CLMExqpJyU1gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLej1MQIVzjmmw2fleppGSdLosCTU6n4izRlu0JLwL/GQ2GdeJ
	frxI4o642IVl0fgUb5FsX7N+un7Jr364LB2UQ5eRDEHGrFUNwPyt0XagnEulJZh85AWWLuAFL5p
	62c+/He34nxf1I5HcpbjNgfjAzfc=
X-Gm-Gg: ASbGncvOMmTmK920z3gRyavK2e2Ehkb0m5wSZ20cQ2123B0vCzwlFzbN2TCil2dXc0Z
	OwtEaxJbYcyIegnxjyDMRZYJtMHlC0sxttMKdm0SsJirArYJ1polbiOWw7kV8CrAEGrl6LTiX7j
	30sFcgqbmNcyotGDqhRr7I
X-Google-Smtp-Source: AGHT+IFDnnRIdVqRrhnq8TxqAaaUPTetD0qCAC53fnCyZb+vwDu06NJo522yF+NVPwZe3sk2hRKWfUHThQUwEM9FJnQ=
X-Received: by 2002:a17:906:c107:b0:ac7:3918:752e with SMTP id
 a640c23a62f3a-acb42c75092mr38868566b.59.1744785266112; Tue, 15 Apr 2025
 23:34:26 -0700 (PDT)
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
 <44b67f86-ed27-49e8-9e15-917fa2b75a60@linux.dev>
In-Reply-To: <44b67f86-ed27-49e8-9e15-917fa2b75a60@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Wed, 16 Apr 2025 09:33:59 +0300
X-Gm-Features: ATxdqUH6zgZGl0b6dnlbFt0uUyYObIAxMavb3nCUMbkigZVUffcoUNaiQwo9jVg
Message-ID: <CAMuE1bFk=LFTWfu8RFJeSoPtjO8ieJDdEHhHpKYr4QxqB-7BBg@mail.gmail.com>
Subject: Re: [PATCH v1] ptp: ocp: fix NULL deref in _signal_summary_show
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: jonathan.lemon@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 4:55=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 14/04/2025 14:43, Sagi Maimon wrote:
> > On Mon, Apr 14, 2025 at 4:01=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 14/04/2025 12:38, Sagi Maimon wrote:
> >>> On Mon, Apr 14, 2025 at 2:09=E2=80=AFPM Vadim Fedorenko
> >>> <vadim.fedorenko@linux.dev> wrote:
> >>>>
> >>>> On 14/04/2025 11:56, Sagi Maimon wrote:
> >>>>> On Mon, Apr 14, 2025 at 12:37=E2=80=AFPM Vadim Fedorenko
> >>>>> <vadim.fedorenko@linux.dev> wrote:
> >>>>>>
> >>>>>> On 14/04/2025 09:54, Sagi Maimon wrote:
> >>>>>>> Sysfs signal show operations can invoke _signal_summary_show befo=
re
> >>>>>>> signal_out array elements are initialized, causing a NULL pointer
> >>>>>>> dereference. Add NULL checks for signal_out elements to prevent k=
ernel
> >>>>>>> crashes.
> >>>>>>>
> >>>>>>> Fixes: b325af3cfab9 ("ptp: ocp: Add signal generators and update =
sysfs nodes")
> >>>>>>> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> >>>>>>> ---
> >>>>>>>      drivers/ptp/ptp_ocp.c | 3 +++
> >>>>>>>      1 file changed, 3 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> >>>>>>> index 7945c6be1f7c..4c7893539cec 100644
> >>>>>>> --- a/drivers/ptp/ptp_ocp.c
> >>>>>>> +++ b/drivers/ptp/ptp_ocp.c
> >>>>>>> @@ -3963,6 +3963,9 @@ _signal_summary_show(struct seq_file *s, st=
ruct ptp_ocp *bp, int nr)
> >>>>>>>          bool on;
> >>>>>>>          u32 val;
> >>>>>>>
> >>>>>>> +     if (!bp->signal_out[nr])
> >>>>>>> +             return;
> >>>>>>> +
> >>>>>>>          on =3D signal->running;
> >>>>>>>          sprintf(label, "GEN%d", nr + 1);
> >>>>>>>          seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu=
 pol:%d",
> >>>>>>
> >>>>>> That's not correct, the dereference of bp->signal_out[nr] happens =
before
> >>>>>> the check. But I just wonder how can that even happen?
> >>>>>>
> >>>>> The scenario (our case): on ptp_ocp_adva_board_init we
> >>>>> initiate only signals 0 and 1 so 2 and 3 are NULL.
> >>>>> Later ptp_ocp_summary_show runs on all 4 signals and calls _signal_=
summary_show
> >>>>> when calling signal 2 or 3  the dereference occurs.
> >>>>> can you please explain: " the dereference of bp->signal_out[nr] hap=
pens before
> >>>>> the check", where exactly? do you mean in those lines:
> >>>>> struct signal_reg __iomem *reg =3D bp->signal_out[nr]->mem;
> >>>>       ^^^
> >>>> yes, this is the line which dereferences the pointer.
> >>>>
> >>>> but in case you have only 2 pins to configure, why the driver expose=
s 4
> >>>> SMAs? You can simply adjust the attributes (adva_timecard_attrs).
> >>>>
> >>> I can (and will) expose only 2 sma in adva_timecard_attrs, but still
> >>> ptp_ocp_summary_show runs
> >>> on all 4 signals and not only on the on that exposed, is it not a bug=
?
> >>
> >> Yeah, it's a bug, but different one, and we have to fix it other way.
> >>
> > Do you want to instruct me how to fix it , or will you fix it?
>
> well, the original device structure was not designed to have the amount
> of SMAs less than 4. We have to introduce another field to store actual
> amount of SMAs to work with, and adjust the code to check the value. The
> best solution would be to keep maximum amount of 4 SMAs in the structure
> but create a helper which will init new field and will have
> BUILD_BUG_ON() to prevent having more SMAs than fixed size array for
> them. That will solve your problem, but I will need to check it on the
> HW we run.
>
just to be clear you will write the fix and test it on your HW, so you
don't want me to write the fix?
> >>>>> struct ptp_ocp_signal *signal =3D &bp->signal[nr];
> >>>>>> I believe the proper fix is to move ptp_ocp_attr_group_add() close=
r to
> >>>>>> the end of ptp_ocp_adva_board_init() like it's done for other boar=
ds.
> >>>>>>
> >>>>>> --
> >>>>>> pw-bot: cr
> >>>>
> >>
>

