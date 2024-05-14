Return-Path: <netdev+bounces-96374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF738C57E5
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DFD28196F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39551144D0D;
	Tue, 14 May 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NptKQzql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E71144D0B
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696845; cv=none; b=EqsmrecUUu8dgSSnwc245YhhjRbjSbPobOYfCIYZ1nDNELI8uXSbD3dQwWZalVzdxiOOjjOM67CI/I3OI9TLDS5FC7u4VtypOL4vMQ7X3GpdtnvX7DY7MolIGSCReVApjK6RObzfjlEo2g+GG2Rw/bp0kWJz9njf7zsCMlcvWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696845; c=relaxed/simple;
	bh=tvjYoDii/CT/NWLq1pFNfvbNan0Tvk+tQ1tKxI1i4l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a82DaKNeo3wU8C5Z7USvproMsZ3fQKxm+AXhupXHCEDtSg+62bg1D9HmOJ6yMmvQNkdJF57NgUS5ZKqcMCxRxb9vVTC591IXWHH+UVBv+7tSx8EwDOGXd1GWkZOd/HnuxmQtsu/r18IH/en29AcNkDXmwkOBt2z0DBSRdwiI15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NptKQzql; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso11301a12.1
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715696842; x=1716301642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLJRRPkOIqx81oYQZLAGpU8I7pBO8rz+kK0CzoxcsAE=;
        b=NptKQzqlnYwfORkr3r+RvPFhgOolfXkqQUDnZWOpyouZtfSfsGVTNv4DUQKpj6lQv8
         wB5L8UUlTeS3A2bQPF1bu60gt9oRR45wk+8DVitKlPb9uRsDw1ApLJuX/RbCFoYPTZmC
         QJKyWdYh2YcGBFRTVI5FKeGs7zSDfQOkZPMVx6sKEW/Uz1v7yVVD1ppnXW1yNl40CW9s
         jx2M9rBCnY8+14OItYuR24RV/tNOZG8iMCzJWWydKgkZTvisXBZ8aTbuNtWnHtcZkF+j
         +q07RRmqqIRN1OrMurGm3oD1xA5ge3fD8gcNfMwuJ2fPFCRgWOGVGJAXy4OqGPzZv3LD
         DAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715696842; x=1716301642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLJRRPkOIqx81oYQZLAGpU8I7pBO8rz+kK0CzoxcsAE=;
        b=OottBPgdpuKVmpn1kmeSCgQf3xlLgIr3ljNMiiT1ZzX0rNatWNNG6F8AnyQzGovmse
         Rkrxk8MMwtEL2Aaq0t06fT/hAslM66L41PTSW7tWUzwydK5LQGwEDwXVuwisqqcPrGaq
         EI781kGCEuh+9K7JNvDC3/dqOge5VP6K9MqkoxNVPJazMlXag6+A10o9GVtu8MG1DuI1
         4CJm443qW9Tz0Hb7A1iysdXkmVQgXnr9w/zzOmnubg2tSVMlfTFIUU9mFfkk3LlI+w9s
         CN3U2YxlP539pyxSKgPvAuQy6b28K+tr9+I39V2vE5dPEO7aXxrU4CJvt6MaaKBITK1d
         xLLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlFxtMv9rDfMH4qX5RW7fydu+IlDfPqqM3cHVicGDrTA12JrCLjBnuZH8ElqBv0l4v+0rsWEY/JqHhCCgE2Zi8rrUGDQEg
X-Gm-Message-State: AOJu0YzR/gg1O8Iy27lReX75/9W+zk0fsSwMtJ2pUWI6qbqZMp8aRJqJ
	ermGXSk1Hio0nWFk3QV7lbi93xzNSQFV+Yz5vw8mG+RsJKhagxI1aEvPPDE/auFLOyRE97raYWP
	Y56+i4opjfeYPJtSc0KOiw9A5CpJBPWXAyd9/
X-Google-Smtp-Source: AGHT+IFZBVyJIO3FUr1aqlMPVgL+tstkO+6JpmTthh5YcCMXuBh8mZRoGoWooIMJTXQYPo8VC5cXQ0vHhCfvgf1A/A8=
X-Received: by 2002:a50:c943:0:b0:573:4a04:619 with SMTP id
 4fb4d7f45d1cf-57443d30f6cmr548888a12.4.1715696841458; Tue, 14 May 2024
 07:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
 <ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com> <CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
 <e8f548f8-6d16-4a30-9408-80e4212afe9c@intel.com> <CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
 <e7e6cbde-8f66-454b-b417-64581cc3896c@intel.com>
In-Reply-To: <e7e6cbde-8f66-454b-b417-64581cc3896c@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 May 2024 16:27:07 +0200
Message-ID: <CANn89iKHuaMsUq1Os9+eEpbovphiauchggjsei3ki8gggiPQtA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for GRO-scheduled NAPI
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
	Realtek linux nic maintainers <nic_swsd@realtek.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Ken Milmore <ken.milmore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 1:18=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Tue, 14 May 2024 13:05:55 +0200
>
> > On Tue, May 14, 2024 at 12:53=E2=80=AFPM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Eric Dumazet <edumazet@google.com>
> >> Date: Tue, 14 May 2024 11:45:05 +0200
> >>
> >>> On Tue, May 14, 2024 at 8:52=E2=80=AFAM Heiner Kallweit <hkallweit1@g=
mail.com> wrote:
> >>>>
> >>>> Ken reported that RTL8125b can lock up if gro_flush_timeout has the
> >>>> default value of 20000 and napi_defer_hard_irqs is set to 0.
> >>>> In this scenario device interrupts aren't disabled, what seems to
> >>>> trigger some silicon bug under heavy load. I was able to reproduce t=
his
> >>>> behavior on RTL8168h.
> >>>> Disabling device interrupts if NAPI is scheduled from a place other =
than
> >>>> the driver's interrupt handler is a necessity in r8169, for other
> >>>> drivers it may still be a performance optimization.
> >>>>
> >>>> Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI=
 is scheduled already")
> >>>> Reported-by: Ken Milmore <ken.milmore@gmail.com>
> >>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >>>> ---
> >>>>  drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
> >>>>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net=
/ethernet/realtek/r8169_main.c
> >>>> index e5ea827a2..01f0ca53d 100644
> >>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
> >>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> >>>> @@ -4639,6 +4639,7 @@ static irqreturn_t rtl8169_interrupt(int irq, =
void *dev_instance)
> >>>>  {
> >>>>         struct rtl8169_private *tp =3D dev_instance;
> >>>>         u32 status =3D rtl_get_events(tp);
> >>>> +       int ret;
> >>>>
> >>>>         if ((status & 0xffff) =3D=3D 0xffff || !(status & tp->irq_ma=
sk))
> >>>>                 return IRQ_NONE;
> >>>> @@ -4657,10 +4658,11 @@ static irqreturn_t rtl8169_interrupt(int irq=
, void *dev_instance)
> >>>>                 rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
> >>>>         }
> >>>>
> >>>> -       if (napi_schedule_prep(&tp->napi)) {
> >>>> +       ret =3D __napi_schedule_prep(&tp->napi);
> >>>> +       if (ret >=3D 0)
> >>>>                 rtl_irq_disable(tp);
> >>>> +       if (ret > 0)
> >>>>                 __napi_schedule(&tp->napi);
> >>>> -       }
> >>>>  out:
> >>>>         rtl_ack_events(tp, status);
> >>>>
> >>>
> >>> I do not understand this patch.
> >>>
> >>> __napi_schedule_prep() would only return -1 if NAPIF_STATE_DISABLE wa=
s set,
> >>> but this should not happen under normal operations ?
> >>
> >> Without this patch, napi_schedule_prep() returns false if it's either
> >> scheduled already OR it's disabled. Drivers disable interrupts only if
> >> it returns true, which means they don't do that if it's already schedu=
led.
> >> With this patch, __napi_schedule_prep() returns -1 if it's disabled an=
d
> >> 0 if it was already scheduled. Which means we can disable interrupts
> >> when the result is >=3D 0, i.e. regardless if it was scheduled before =
the
> >> call or within the call.
> >>
> >> IIUC, this addresses such situations:
> >>
> >> napi_schedule()         // we disabled interrupts
> >> napi_poll()             // we polled < budget frames
> >> napi_complete_done()    // reenable the interrupts, no repoll
> >>   hrtimer_start()       // GRO flush is queued
> >>     napi_schedule()
> >>       napi_poll()       // GRO flush, BUT interrupts are enabled
> >>
> >> On r8169, this seems to cause issues. On other drivers, it seems to be
> >> okay, but with this new helper, you can save some cycles.
> >>
> >> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >
> > Rephrasing the changelog is not really helping.
> >
> > Consider myself as a network maintainer, not as a casual patch reviewer=
.
>
> And?
>
> >
> > "This seems to cause issues" is rather weak.
>
> It has "Reported-by", so it really causes issues.

And ?

Revert ?

>
> >
> > I would simply revert the faulty commit, because the interrupts are
> > going to be disabled no matter what.
> >
> > Old logic was very simple and rock solid. A revert is a clear stable ca=
ndidate.
> >
> > rtl_irq_disable(tp);
> > napi_schedule(&tp->napi);
> >
> > If this is still broken, we might have similar issues in old/legacy dri=
vers.
>
> I might agree that we could just revert the mentioned commit for stable,
> but for the next net-next, avoid unnecessary
> scheduling/enabling/disabling interrupts makes sense, not only for
> "old/legacy" drivers.
> "Very simple and rock solid" is not an argument for avoiding improvements=
.

I explained that I failed to see the 'so called' improvement there.

You explained nothing really, just that you like some approach that I
think is for net-next.

