Return-Path: <netdev+bounces-250047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28001D234EE
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97671301FD05
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DB933F361;
	Thu, 15 Jan 2026 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHTSFoiA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNlfSuRe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163633A6EB
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467490; cv=none; b=ZFbSFRMtiqg0JWK7Xt/twxiPSTQtlsmISQPaEX1eCSMpITD2eb2hNCBATtTp3MUqnuvgEcXktZlmhEZn/CsdsrtlQ2bNdmxvFndzzEnPv50BgvS/Ogee/RnW1uTsjwQKU8cFWVSIfal8Wu0EEAcNA3VyIIa4Q6Q09LJ3dkGxt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467490; c=relaxed/simple;
	bh=a1Xb74epBoiF26GtYYturswnNknIceQZZvdMkCDEo38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhAF1qukeoWo7qwqLBjF2Ir35MVJS5TDzzUo9VY6HrDt7agk/85mlT1SuVLM1BhKSVcyh2za8BTsV0jzjOdfmE2oLlvs0E2yvvmqulc8H6uV9ZvZFNTBj+D1eba78J/2IpbH8igwSrWMwZW7Xh0QbDCBEsXLwDBU5ZHmkVeOuV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHTSFoiA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNlfSuRe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768467488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxJnA8ESHNGloyx98rY09AuEzCkDTn54NDk73Ig9am8=;
	b=hHTSFoiAY8ydIc6ZkgSObsF8tZVFsh0KVmx6Uzp41GyhDOO/2tx8cMoDM7BYt8nGBeQ422
	7CG3xPdH4yZzuK5GU7d4LNznMxCr+tcNOkxUWNXHdaFuXzJ+jVcMdO9E2kYcZOrT7RJD4t
	pe+GXipogDBpQm+UD97Lx2bwQl5lb5c=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-mG7auoosNSubfkc1zsg3uQ-1; Thu, 15 Jan 2026 03:58:06 -0500
X-MC-Unique: mG7auoosNSubfkc1zsg3uQ-1
X-Mimecast-MFC-AGG-ID: mG7auoosNSubfkc1zsg3uQ_1768467486
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4511a6fde00so4194194b6e.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 00:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768467486; x=1769072286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxJnA8ESHNGloyx98rY09AuEzCkDTn54NDk73Ig9am8=;
        b=PNlfSuRe8wBYZuv7eudp1PXrK9cCIX878v8dZEYPTEExpyYyIOvtWBJnDCwgpt8e2/
         f4NRkHZQZm4/kHzV9lyOaiBww7E1cOEfE68Rh1CFaS97tO3dREdPxskjzjeDePsHRVfE
         oTheVxBc0s5RapnSPGFT2OMvycxVRlC4vFmkCcFmGDGpE+DQUsnnWOn3MESgRPM+PMWq
         bws6aFa/SlV5RUtWlc8aaHy8v5JsfaCQKZkYnyQJQPAPXXlG0ND1O9fPxyTnoXTomz/5
         7B6jc+nX9i/wR/3Bzb9V7fI4xvm1WYCa6GnT3/LEucyadvDSTWj/YspvosWQv+MMGFRX
         a/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768467486; x=1769072286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LxJnA8ESHNGloyx98rY09AuEzCkDTn54NDk73Ig9am8=;
        b=RuPc9WWLhFCFxMjEEjZm9h0gp3qYPWo0H3kSkW4AZqrdiQZF9//6y3+3PJkYypdAJO
         i+tMUdCHxwqCAx4lObS2E1ZJo5tYjI2nGwYd4XB0tuLk6u/6+dC6oE8aqoF7JHGC+kLy
         JaWLXrQzFkNirblOQVvagbTJBsWHHn4fn0dvjl+HW1xnFBv5nAhYAPuFHq4t5ZuNBYqp
         kOrlbCiURWcCrfAN650M4MXVLbaCJ3B8S+sJpw1vyZa7U6bR/2RO8/dPDyFyO+6zeEpY
         vcEXVw2fmEvPHvHodVsoBeuRYQR4FOEd1ClCUALOYWt1mU43fvg2K9fZyTZ5q8teHhuL
         tx9w==
X-Forwarded-Encrypted: i=1; AJvYcCXYJQQO8XzFTw92h652aoI14j249/BwiRjVvvCBTjh/JOdjcsYIcs9ebQ6d86gVRbzfDvNYoBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1tBdRfhXth3/lmRnpD3fFpZEfdbHhVMy37GiUybZc7IlAzlmp
	Ozy75zvc/k+X8SzZUdnrsgCk8yQAVYCE6BeYZeKY2vgFfB7+vhnH58YhuMiZGOrP7NQ+/Rh+sbC
	naOQDv3kZewq2LW2xDC+YTjV5nVMYL5DvhMxbGvGZVPuT/TO241ykGfVY14sLi01Sd18+CTj07e
	a69u2wQLvVRzSKgqV6x/BZ4Dfc52s1HrPO
X-Gm-Gg: AY/fxX4fdSTgtWwZmW1+wRMcdh3k2Le02m1NgbeMTQkYQK1HBISocfmWAvWTMTHdLyp
	TO7hC0tjfON7zmUNMxVGKLOzgI+Zd9wMd5eJeMLyA2ckNVMxayG3AojgrGrR/AUUNnBB/M1sH2y
	GIa+SDOZjd9lXq2q1rCucBbpVlHgbyomxh3NTfAKUpFy5aOtxFyLJXC+oomPZ6Ly2s
X-Received: by 2002:a05:6808:23c6:b0:450:89ee:922b with SMTP id 5614622812f47-45c8808d2ffmr1705716b6e.22.1768467485994;
        Thu, 15 Jan 2026 00:58:05 -0800 (PST)
X-Received: by 2002:a05:6808:23c6:b0:450:89ee:922b with SMTP id
 5614622812f47-45c8808d2ffmr1705703b6e.22.1768467485610; Thu, 15 Jan 2026
 00:58:05 -0800 (PST)
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
 <CACLnSDhEQVJ5piUKp6bddxvOff88qj5X6Y8zbqAH8Kf5a7a_Zg@mail.gmail.com> <LV4PR11MB9491B0E591D66E4AEDE9B1329B8FA@LV4PR11MB9491.namprd11.prod.outlook.com>
In-Reply-To: <LV4PR11MB9491B0E591D66E4AEDE9B1329B8FA@LV4PR11MB9491.namprd11.prod.outlook.com>
From: Vitaly Grinberg <vgrinber@redhat.com>
Date: Thu, 15 Jan 2026 10:57:49 +0200
X-Gm-Features: AZwV_QijwZUQitFksicMP9ueDYXoIsh6EMNIvOTnPt4NWgLOWM54f4CZgNSuas0
Message-ID: <CACLnSDggQLQMFdT3VLxm+GNNad6xy43nh6D+UzbW-u9Wwg+WOw@mail.gmail.com>
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
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Zoltan Fodor <zoltan.fodor@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

, the ea

On Wed, Jan 14, 2026 at 3:32=E2=80=AFPM Kubalewski, Arkadiusz
<arkadiusz.kubalewski@intel.com> wrote:
>
> >From: Vitaly Grinberg <vgrinber@redhat.com>
> >Sent: Wednesday, January 14, 2026 12:39 PM
> >
>
> [..]
>
> >> >
> >> >I see a few challenges for the user here. The biggest one is that the
> >> >application can't tell the difference between a device that will repo=
rt
> >> >phase offsets and this unmanaged device that never will.
> >> >A possible way forward would be adding a capability flag to the DPLL =
API
> >> >so
> >> >users don't have to guess.
> >>
> >> There is no phase-offset field as pointed in the above example.
> >> No 'phase-offset' attribute -> no such capability.
> >> Why isn=E2=80=99t that enough?
> >
> >Pin reply does not contain phase offset, so no change notifications
> >are expected?
> >Could there be devices that don't report phase offset, but report state
> >changes?
> >Is this the intended use of the phase offset API to be interpreted as
> >a general pin
> >notification capability flag?
> >
>
> Sorry, this is not what I meant.
>
> The E810 produces notifications not only for the pin's phase offset but
> also for other pin attribute changes. When it comes to the E810 pins,
> notifications generated by phase offset changes are quite frequent.
> However, it wasn't intention to produce them every second; this is simply
> the result of frequent phase offset changes.
>
> Typically, the pin state changes for the pin, but for E830, the unmanaged
> mode means that the state of the pin never changes, resulting in no pin
> notifications being produced in the end.
>
> Hope that clears things up.

Will the reported pin state remain "connected" even if I disconnect
the input signal?
Is there any information in DPLL or pin replies that can tell the user
"this DPLL is unmanaged type, it behaves differently"?

>
> >>
> >> >However, the preferred solution would be to simply mirror the E810
> >> >behavior
> >> >(sending phase offset). This preserves the existing API contract and
> >> >prevents users, who have already built applications for this interfac=
e,
> >> >from needing to implement special handling for a new hardware variant
> >> >that
> >> >behaves differently.
> >>
> >> This is not currently possible from driver perspective.
> >> We miss the FW API for it.
> >>
> >> >There are additional inconsistencies in the existing structure I want=
ed
> >> >to
> >> >bring to your attention.
> >> >1. I'm not entirely sure how a 1588-TIME_SYNC pin can have a parent
> >> >device
> >> >of type "eec". EEC is all about frequency synchronization, and yet th=
e
> >> >pin
> >> >named 1588-TIME_SYNC is clearly a phase pin. This also doesn't play w=
ell
> >> >with existing implementations, where EEC circuits deal with frequency=
,
> >> >PPS
> >> >circuits deal with phase, and there is clear distinction between the =
two
> >> >with regard to the meaning of "being locked".
> >>
> >> This dpll device type was established based on the main purpose of dpl=
l
> >> device which is to drive the network ports phy clocks with it.
> >
> >What is the physical meaning of this indication (lock-status':
> >'locked')? Locked on what?
>
> Lock status is dpll device property.
>
> But full picture has to be determined from the list of pins, for this
> particular case, one input provided from host through pci-e pin, 10MHz
> bandwidth frequency and 1 PPS sync pulses.
>
> As already pointed the type of dpll shall let user know the purpose of
> the dpll existence instead of particular input properties.
> Input properties are determined with the pin's attributes.
>
> >As a user of this circuit I want to know that the device is locked on
> >the phase of the input signal with a certain precision.
> >Is this the meaning of "locked" here? Can an EEC device be locked on
> >the Phase of the input signal?
>
> Well I don't have any data on the precision of such, but AFAIK it can.
> EEC dpll shall be producing stable signal, the input it uses is only
> part of the full dpll device picture.
>
> >Users of other devices (e810, zl3073x) may have implemented logic to
> >determine the phase lock by
> >enforcing the pin parent device type as PPS. How should they change it
> >to determine phase lock (and why)?
> >
>
> I am Sorry, I don't understand the example above, could you please
> Elaborate on details of such setup?

Yep, gladly!
Telco customers rely on the Phase being locked on the reference with a
certain precision. In E810 and zl3073x the equation is simple:
1. "eec locked" means synTonization achieved - frequency locked
2. "pps locked" means synChronization achieved - phase locked
The T-BC application checks the reported device type. If the device
type is "pps", the report is processed by the synchronization state
decision logic. Otherwise, the report doesn't have any meaning within
"T-BC without SyncE" context and is discarded.

Since this patch is going to create eec reports only, they are all
going to be discarded, and this is a compatibility issue I'm trying to
address.

Could you please answer my question above:
What is the physical meaning of this indication
(lock-status':'locked') in this report?

Thanks!
VG

> Thank you!
> Arkadiusz
>
> >>
> >> >2. Since it is also an external embedded sync input pin, could it be
> >> >possible to expose this information and include `esync-frequency` and
> >> >`esync-pulse`? That could be useful for configuring the leading DPLL
> >> >that
> >> >drives the unmanaged one.
> >>
> >> Sure, esync caps should be provided, as the commit message example sho=
wn:
> >> +    'esync-frequency': 1,
> >> +    'esync-frequency-supported': [{'frequency-max': 1, 'frequency-min=
':
> >>1}],
> >> +    'esync-pulse': 25,
> >>
> >
> >Oh, I must have missed that.
> >Thanks!
> >Vitaly
> >
> >> Thank you!
> >> Arkadiusz
>


