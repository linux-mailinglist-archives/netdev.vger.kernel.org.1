Return-Path: <netdev+bounces-250278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 733C6D26A3A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BEE930F0C6D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA983C1981;
	Thu, 15 Jan 2026 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiXAIC4n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kLi09DsE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735453BF2E4
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497951; cv=none; b=nF4obrM1UfAxZtPWWhs3qaGWvdxYVBQAjcaXAF0OA2mfclp9UETdsQxOCYLIs20DXJhJqe8Pd/DglwVFo6lm7y38+hmngjgCkapBRNAe2yAQka7tWQOTVxrYBeRJD9p16R7pxYdemKZJf9T4445K0vNg/rWuTAf1IP6erbcfXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497951; c=relaxed/simple;
	bh=oSBFNW2mTecRGoM6XA9w2Awj3F5k7y7FE24BbFg4xTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3xEjhmmWD4/VwGTbBXugsw83KNRWicSRyJN3B00C3gZuWEi5vuPqKaF1A1BSZMfcSeAlO43Q3R0qbS6km9/+JaDrkpPgCzkOqWWkAHg+bzdQ7Sla0hGhR8IJ/INYwAJ3IL/jkl/Bz9yJy27DtlkgTB6VRNCqiAWTwCfTYV3ij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiXAIC4n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kLi09DsE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768497948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHSZznzjMl1NMOULsgdEoAOMKAaAnonqU4bzQ6AGE0A=;
	b=GiXAIC4n00hMi4uC1vF/W5rR0yKPuDeCfHDtnn7//59frmP7oKQ8C2ApedioEK9TMXfQhf
	RpOaloXlKudPoj5aozNjeMitCb98FCMKD9QgUg0shLWZwterU/7FvBWERftj+7pHRF8518
	5s8pSQWhKMz6MdTj7Q83yNHO0sZaXRQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-UM7CoTw0MpKDR6NCz_BD8w-1; Thu, 15 Jan 2026 12:25:47 -0500
X-MC-Unique: UM7CoTw0MpKDR6NCz_BD8w-1
X-Mimecast-MFC-AGG-ID: UM7CoTw0MpKDR6NCz_BD8w_1768497946
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-45a684d8f6aso5296821b6e.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768497946; x=1769102746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHSZznzjMl1NMOULsgdEoAOMKAaAnonqU4bzQ6AGE0A=;
        b=kLi09DsEqY6ZrovUk3p4FbuODyNatAr3Cc3sBJqlWnYa9DYd4nTYoLEqmMQxX4wms1
         hzEM64V0HEjAnLaw2XaH3JbLi6THObkIn2bS5HVghqqL4vJd0MliyihKXooUYdtlsCt+
         8IHuv/0p7RryifoCuekCFWJY/FZ8IFdMzV7IQaL4BAExif9KHoJ59rh3gdfc1whWHOSd
         pSII9S8IYK3m35yPaOpGSkwQUllzj6Qqb0V0eh10XAEn7a1eqRxp2WoiW7aYheHGeHXa
         bk4r1H3eS+kfOaTm08/Kf4cMC2oJ3974IMlkhqhTmJ9KHUAdV8oNNAp0A9ciDsx+lud5
         WG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497946; x=1769102746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lHSZznzjMl1NMOULsgdEoAOMKAaAnonqU4bzQ6AGE0A=;
        b=q/zM6dqPjw1Gg8xc5+ykw1trFS8H7h8I+LiKFxAbQwWoLZ7uH9PNmiJhLAI1NHVoxA
         uRscYPVoMPaFlzsojqBvYHLfugoMDkRDTgCNL24TrCnksPlsqz/E/ETtgn0ZBDx/arqZ
         igBjiEcykVcnHYqDjmu2LuhBNI8cgUWL9qa71HwAt0dMA2I+2flnJrkER2xKqXS0aq4K
         YNuuGvTgmoXPXivd4KXfaSfOE2+60AKd91GhCBKM7MC3kzYg1v8qBcnLAzieQCKncfSX
         rtrTAFiTlL9Aihw9Zc0O1jVyAlfFC1b37tDbQkFii7kv45MZYHDcSezvptY2TrKpdcGJ
         Z+mA==
X-Forwarded-Encrypted: i=1; AJvYcCWNRobmGYGifad0PkCCPR+1COhlmiD3CBjhMoMHNKkHbJJdu+Nr5f2yLaW1n3rz0/y+kdJX2+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1cCUhZFZkKNbP/EEDlVZ596v0ilRXchtHnIM8ZxBv18Q0j6K
	5OAY72BmqwGDIybg0JW3vZ/EJF1L0k3hFB0IRPSkq9qS0rW9HR3Im8wnnF4sOoLWxw1YV2jWHaf
	GfqgMFQiLGKvRQeI06CHDNh7uGSzGlIU/ZQhq0BeHDOrWEKL5+dclZG+8P3iZcnWGcCUjBhG4Ik
	4lgneJowGJ4OV6rAeeG1/R1/A/Lrd/xyfl
X-Gm-Gg: AY/fxX53bW/bibhJ4IGeXuwKU1YjeO4WZEPMvoB6A/Iup3PTk81EehX1Yu2XWtD6SU+
	FhLy6M/yEGV/Uc+qsFTYs9yCYkRQTUNZAaW8Oed51qum4+Yh12SsyksqX33Q4kfO3pgBEqE6+u1
	sboncNkS0O5ziUXqkKF572b5H3EtWYJOlsaKTTZ6Yl1ALrMrXnUmKUathi96lKsoH8
X-Received: by 2002:a05:6808:4fcc:b0:450:b92c:aaa2 with SMTP id 5614622812f47-45c880ffcdcmr2381766b6e.18.1768497946450;
        Thu, 15 Jan 2026 09:25:46 -0800 (PST)
X-Received: by 2002:a05:6808:4fcc:b0:450:b92c:aaa2 with SMTP id
 5614622812f47-45c880ffcdcmr2381749b6e.18.1768497946072; Thu, 15 Jan 2026
 09:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120105208.2291441-1-grzegorz.nitka@intel.com>
 <20251216144154.15172-1-vgrinber@redhat.com> <IA1PR11MB621913F389165EE4D7CCFF2D9284A@IA1PR11MB6219.namprd11.prod.outlook.com>
 <CACLnSDikAToGRvfZAhTcT0NCtMj+N9z-GGzRQ5qmpHsvCr2QSA@mail.gmail.com>
 <LV4PR11MB9491EB644FC83676522107669B8FA@LV4PR11MB9491.namprd11.prod.outlook.com>
 <CACLnSDhEQVJ5piUKp6bddxvOff88qj5X6Y8zbqAH8Kf5a7a_Zg@mail.gmail.com>
 <LV4PR11MB9491B0E591D66E4AEDE9B1329B8FA@LV4PR11MB9491.namprd11.prod.outlook.com>
 <CACLnSDggQLQMFdT3VLxm+GNNad6xy43nh6D+UzbW-u9Wwg+WOw@mail.gmail.com> <LV4PR11MB9491C8288A84379A1199DC409B8CA@LV4PR11MB9491.namprd11.prod.outlook.com>
In-Reply-To: <LV4PR11MB9491C8288A84379A1199DC409B8CA@LV4PR11MB9491.namprd11.prod.outlook.com>
From: Vitaly Grinberg <vgrinber@redhat.com>
Date: Thu, 15 Jan 2026 19:25:30 +0200
X-Gm-Features: AZwV_QiR68c78dzt7Vs78QLCFnBcBYytsRuzF6J0pDE4rljbQKo80nDKshRpZkg
Message-ID: <CACLnSDgy+mxqgy+fShC1kre05zF54tCfttqQTzzFkBt4f9UYog@mail.gmail.com>
Subject: Re: Re:[Intel-wired-lan] [PATCH v5 iwl-next] ice: add support for
 unmanaged DPLL on E830 NIC
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, 
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Fodor, Zoltan" <zoltan.fodor@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 5:30=E2=80=AFPM Kubalewski, Arkadiusz
<arkadiusz.kubalewski@intel.com> wrote:
>
> >From: Vitaly Grinberg <vgrinber@redhat.com>
> >Sent: Thursday, January 15, 2026 9:58 AM
> >
> >, the ea
> >
> >On Wed, Jan 14, 2026 at 3:32=E2=80=AFPM Kubalewski, Arkadiusz
> ><arkadiusz.kubalewski@intel.com> wrote:
> >>
> >> >From: Vitaly Grinberg <vgrinber@redhat.com>
> >> >Sent: Wednesday, January 14, 2026 12:39 PM
> >> >
> >>
> >> [..]
> >>
> >> >> >
> >> >> >I see a few challenges for the user here. The biggest one is that
> >> >> >the
> >> >> >application can't tell the difference between a device that will
> >> >> >report
> >> >> >phase offsets and this unmanaged device that never will.
> >> >> >A possible way forward would be adding a capability flag to the DP=
LL
> >> >> >API
> >> >> >so
> >> >> >users don't have to guess.
> >> >>
> >> >> There is no phase-offset field as pointed in the above example.
> >> >> No 'phase-offset' attribute -> no such capability.
> >> >> Why isn=E2=80=99t that enough?
> >> >
> >> >Pin reply does not contain phase offset, so no change notifications
> >> >are expected?
> >> >Could there be devices that don't report phase offset, but report sta=
te
> >> >changes?
> >> >Is this the intended use of the phase offset API to be interpreted as
> >> >a general pin
> >> >notification capability flag?
> >> >
> >>
> >> Sorry, this is not what I meant.
> >>
> >> The E810 produces notifications not only for the pin's phase offset bu=
t
> >> also for other pin attribute changes. When it comes to the E810 pins,
> >> notifications generated by phase offset changes are quite frequent.
> >> However, it wasn't intention to produce them every second; this is
> >simply
> >> the result of frequent phase offset changes.
> >>
> >> Typically, the pin state changes for the pin, but for E830, the
> >> unmanaged
> >> mode means that the state of the pin never changes, resulting in no pi=
n
> >> notifications being produced in the end.
> >>
> >> Hope that clears things up.
> >
> >Will the reported pin state remain "connected" even if I disconnect
> >the input signal?
> >Is there any information in DPLL or pin replies that can tell the user
> >"this DPLL is unmanaged type, it behaves differently"?
>
> You really cannot disconnect anything there, it is always connected,
> and no one can change it. It only shows the user actual physical
> connections hardwired into the NIC/dpll. There is no SW handled config
> possible on those. As provided in the commit message, the pins have empty
> capabilities set: 'capabilities': set(), thus not possible to change stat=
e
> by the user.
>

Got it, thanks for clarification!

> >
> >>
> >> >>
> >> >> >However, the preferred solution would be to simply mirror the E810
> >> >> >behavior
> >> >> >(sending phase offset). This preserves the existing API contract a=
nd
> >> >> >prevents users, who have already built applications for this
> >> >> >interface,
> >> >> >from needing to implement special handling for a new hardware
> >> >> >variant
> >> >> >that
> >> >> >behaves differently.
> >> >>
> >> >> This is not currently possible from driver perspective.
> >> >> We miss the FW API for it.
> >> >>
> >> >> >There are additional inconsistencies in the existing structure I
> >> >> >wanted
> >> >> >to
> >> >> >bring to your attention.
> >> >> >1. I'm not entirely sure how a 1588-TIME_SYNC pin can have a paren=
t
> >> >> >device
> >> >> >of type "eec". EEC is all about frequency synchronization, and yet
> >> >> >the
> >> >> >pin
> >> >> >named 1588-TIME_SYNC is clearly a phase pin. This also doesn't pla=
y
> >> >> >well
> >> >> >with existing implementations, where EEC circuits deal with
> >> >> >frequency,
> >> >> >PPS
> >> >> >circuits deal with phase, and there is clear distinction between t=
he
> >> >> >two
> >> >> >with regard to the meaning of "being locked".
> >> >>
> >> >> This dpll device type was established based on the main purpose of
> >> >> >dpll
> >> >> device which is to drive the network ports phy clocks with it.
> >> >
> >> >What is the physical meaning of this indication (lock-status':
> >> >'locked')? Locked on what?
> >>
> >> Lock status is dpll device property.
> >>
> >> But full picture has to be determined from the list of pins, for this
> >> particular case, one input provided from host through pci-e pin, 10MHz
> >> bandwidth frequency and 1 PPS sync pulses.
> >>
> >> As already pointed the type of dpll shall let user know the purpose of
> >> the dpll existence instead of particular input properties.
> >> Input properties are determined with the pin's attributes.
> >>
> >> >As a user of this circuit I want to know that the device is locked on
> >> >the phase of the input signal with a certain precision.
> >> >Is this the meaning of "locked" here? Can an EEC device be locked on
> >> >the Phase of the input signal?
> >>
> >> Well I don't have any data on the precision of such, but AFAIK it can.
> >> EEC dpll shall be producing stable signal, the input it uses is only
> >> part of the full dpll device picture.
> >>
> >> >Users of other devices (e810, zl3073x) may have implemented logic to
> >> >determine the phase lock by
> >> >enforcing the pin parent device type as PPS. How should they change i=
t
> >> >to determine phase lock (and why)?
> >> >
> >>
> >> I am Sorry, I don't understand the example above, could you please
> >> Elaborate on details of such setup?
> >
> >Yep, gladly!
> >Telco customers rely on the Phase being locked on the reference with a
> >certain precision. In E810 and zl3073x the equation is simple:
> >1. "eec locked" means synTonization achieved - frequency locked
> >2. "pps locked" means synChronization achieved - phase locked
> >The T-BC application checks the reported device type. If the device
> >type is "pps", the report is processed by the synchronization state
> >decision logic. Otherwise, the report doesn't have any meaning within
> >"T-BC without SyncE" context and is discarded.
> >
> >Since this patch is going to create eec reports only, they are all
> >going to be discarded, and this is a compatibility issue I'm trying to
> >address.
> >
>
> I see. From this angle the PPS type looks like a superset of EEC.
> It makes sense to me. We had also some discussion and agreed to propose
> new patch with the PPS type, as we don't want the underlying SW to be
> troubled with such issue.

Thanks very much for considering this!

> >Could you please answer my question above:
> >What is the physical meaning of this indication
> >(lock-status':'locked') in this report?
> >
>
> It means that dpll is locked/synchronized with the esync 10MHz/1PPS,
> a signal provided through pcie pin.
>
> Thank you!
> Arkadiusz
>
> >Thanks!
> >VG
> >
> >> Thank you!
> >> Arkadiusz
> >>
> >> >>
> >> >> >2. Since it is also an external embedded sync input pin, could it =
be
> >> >> >possible to expose this information and include `esync-frequency`
> >> >> >and
> >> >> >`esync-pulse`? That could be useful for configuring the leading DP=
LL
> >> >> >that
> >> >> >drives the unmanaged one.
> >> >>
> >> >> Sure, esync caps should be provided, as the commit message example
> >> >> >shown:
> >> >> +    'esync-frequency': 1,
> >> >> +    'esync-frequency-supported': [{'frequency-max': 1, 'frequency-
> >> >> >min':
> >> >>1}],
> >> >> +    'esync-pulse': 25,
> >> >>
> >> >
> >> >Oh, I must have missed that.
> >> >Thanks!
> >> >Vitaly
> >> >
> >> >> Thank you!
> >> >> Arkadiusz
> >>
>


