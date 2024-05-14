Return-Path: <netdev+bounces-96329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F728C519B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB6F1F22679
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAFC13A410;
	Tue, 14 May 2024 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orLD7FKA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6D54903
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684772; cv=none; b=pYUPd9S1TOojclaQE3BKmV77L2B3APwjSUXPIwgoDv+fhni0JT4WeRaiz6GZ/SLOs4Y8C6FpYTdmajFbE4Xmz2kDrUmH477GUu02umlK5pIEDgB3voRMJmYhrriGbj9z23n04/1HtDrpsVPqI83kVSi5hqTzYk+n/A28Pyy4aSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684772; c=relaxed/simple;
	bh=f1wGa5NT1c7hGMlirdU3cDizJuHelfjw3OMTCt8SoG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edoLt1fAD5ZZrznp06NS8+lxKvsDwRtApxmWFiegNrnXH1a9sZKGAcnBNGbmHlR2jxAJ0CD/DvsNM9ppDdLGRVoqRVXSWGjQF0RyP2XzJCYD2BqhUMDfWpBslI0zLqDotIesMuDQAk620rDEY01rRhd0r83rP2/ptIDVghj+Xmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=orLD7FKA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso8857a12.1
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715684769; x=1716289569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKnTerFEn+Wos0ATvUe45uW0pD+tSOcbATEmfcCvxP8=;
        b=orLD7FKA8S5QpRgbK9o4y0z8eg01+CzTMMayZveew6LB3NQIqvj6c2bg9K7jCPMB3c
         Qo0couefG06yadPQIgCYuQFSwbwKFi8sN7rO7/oU4AWh4A16VXpNRExQE6iV+7VfTp01
         FkqbVBpp7LqYC+oF4yGCh+uxZf+2IY+1ynIUqQOwUJ4uXtgn6kYw4bLiL2XXigpmbORY
         4190bzDpqnPmxPni7ilMWxE/VgRHHUIiwep9d6KlCz/G2X9VXXvsy4WpPxBf46dm8TEJ
         pk++z+AJeJQy5NvAcxqa7O6amV61nlXDhrUpbhIJtPTrZ+NFMUF0xLVp9A55dLT6XTPY
         8saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715684769; x=1716289569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKnTerFEn+Wos0ATvUe45uW0pD+tSOcbATEmfcCvxP8=;
        b=YzK2i3sI18Liks1bIQvpF8kzu+GY76x4bCapx0B9NQn8XtBDEmDPwGW2j10emlUTm/
         8oPGRiUx/2ks5d+FxACJU+g9fY9DrwYj2LRUKrY58idea6/rs6CBynF6KXAlCMWOuUp7
         JeQi3/KGs2k3ZEoX9ku3F0AzCRDKvDG19Pm8gCaDglK0gqWTYKNN52gyDhhSCbe0bWei
         LFBYOwJHCmZwTpPZi1khcRVETevVP/NtmZ2uOq82bxx1IwDQRSWpU2LXCwvwsjgTKqUT
         6a+Cxe1krwA9E+mrAl9gi7Cu8r/GEZZnUrxSGDD+YsmVgUB/VGnXLolxjYsyUqgeV9ek
         +ITA==
X-Forwarded-Encrypted: i=1; AJvYcCUoav5cK+FeNqEsqX6/AcMenHkSqfA8rP7YDbDId6fLlwJQDy9nciFlNDHdUQmmhW6m//ni9s/0EZfeyFhKMHYz1Trhh14U
X-Gm-Message-State: AOJu0Yx5fNuudolhDihoBwx6/krX4Fz/IqlJSQJAbtM7XpaT8tTKoAya
	6WbLR1m5rq2gAuH2BkeylFXKvDnPht8tOFwkzadORFkWjzztT9VFEoSzypzqEaehrbhWnk5x0wC
	ycD9JHpYLk2NK1rlyYcwyKdrll3AwgKtozCX6
X-Google-Smtp-Source: AGHT+IFT0SS7UZOVhXRm4IgRepygooS5WXIhEgKkYrcmn3Rpfxvi8bvmZb99whT4pCsh4mE83I9tk3rQ8iH7NdU04vw=
X-Received: by 2002:a50:cac7:0:b0:572:a23b:1d81 with SMTP id
 4fb4d7f45d1cf-574ae574b9dmr453540a12.5.1715684769295; Tue, 14 May 2024
 04:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
 <ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com> <CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
 <e8f548f8-6d16-4a30-9408-80e4212afe9c@intel.com>
In-Reply-To: <e8f548f8-6d16-4a30-9408-80e4212afe9c@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 May 2024 13:05:55 +0200
Message-ID: <CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for GRO-scheduled NAPI
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
	Realtek linux nic maintainers <nic_swsd@realtek.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Ken Milmore <ken.milmore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 12:53=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Tue, 14 May 2024 11:45:05 +0200
>
> > On Tue, May 14, 2024 at 8:52=E2=80=AFAM Heiner Kallweit <hkallweit1@gma=
il.com> wrote:
> >>
> >> Ken reported that RTL8125b can lock up if gro_flush_timeout has the
> >> default value of 20000 and napi_defer_hard_irqs is set to 0.
> >> In this scenario device interrupts aren't disabled, what seems to
> >> trigger some silicon bug under heavy load. I was able to reproduce thi=
s
> >> behavior on RTL8168h.
> >> Disabling device interrupts if NAPI is scheduled from a place other th=
an
> >> the driver's interrupt handler is a necessity in r8169, for other
> >> drivers it may still be a performance optimization.
> >>
> >> Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI i=
s scheduled already")
> >> Reported-by: Ken Milmore <ken.milmore@gmail.com>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/e=
thernet/realtek/r8169_main.c
> >> index e5ea827a2..01f0ca53d 100644
> >> --- a/drivers/net/ethernet/realtek/r8169_main.c
> >> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> >> @@ -4639,6 +4639,7 @@ static irqreturn_t rtl8169_interrupt(int irq, vo=
id *dev_instance)
> >>  {
> >>         struct rtl8169_private *tp =3D dev_instance;
> >>         u32 status =3D rtl_get_events(tp);
> >> +       int ret;
> >>
> >>         if ((status & 0xffff) =3D=3D 0xffff || !(status & tp->irq_mask=
))
> >>                 return IRQ_NONE;
> >> @@ -4657,10 +4658,11 @@ static irqreturn_t rtl8169_interrupt(int irq, =
void *dev_instance)
> >>                 rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
> >>         }
> >>
> >> -       if (napi_schedule_prep(&tp->napi)) {
> >> +       ret =3D __napi_schedule_prep(&tp->napi);
> >> +       if (ret >=3D 0)
> >>                 rtl_irq_disable(tp);
> >> +       if (ret > 0)
> >>                 __napi_schedule(&tp->napi);
> >> -       }
> >>  out:
> >>         rtl_ack_events(tp, status);
> >>
> >
> > I do not understand this patch.
> >
> > __napi_schedule_prep() would only return -1 if NAPIF_STATE_DISABLE was =
set,
> > but this should not happen under normal operations ?
>
> Without this patch, napi_schedule_prep() returns false if it's either
> scheduled already OR it's disabled. Drivers disable interrupts only if
> it returns true, which means they don't do that if it's already scheduled=
.
> With this patch, __napi_schedule_prep() returns -1 if it's disabled and
> 0 if it was already scheduled. Which means we can disable interrupts
> when the result is >=3D 0, i.e. regardless if it was scheduled before the
> call or within the call.
>
> IIUC, this addresses such situations:
>
> napi_schedule()         // we disabled interrupts
> napi_poll()             // we polled < budget frames
> napi_complete_done()    // reenable the interrupts, no repoll
>   hrtimer_start()       // GRO flush is queued
>     napi_schedule()
>       napi_poll()       // GRO flush, BUT interrupts are enabled
>
> On r8169, this seems to cause issues. On other drivers, it seems to be
> okay, but with this new helper, you can save some cycles.
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Rephrasing the changelog is not really helping.

Consider myself as a network maintainer, not as a casual patch reviewer.

"This seems to cause issues" is rather weak.

I would simply revert the faulty commit, because the interrupts are
going to be disabled no matter what.

Old logic was very simple and rock solid. A revert is a clear stable candid=
ate.

rtl_irq_disable(tp);
napi_schedule(&tp->napi);

If this is still broken, we might have similar issues in old/legacy drivers=
.

