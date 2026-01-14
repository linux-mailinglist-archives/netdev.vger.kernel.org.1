Return-Path: <netdev+bounces-249816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C1FD1E819
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3242308CDE3
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2973238BDD4;
	Wed, 14 Jan 2026 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKvG8uiz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pQy3sV4k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E4B395241
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390738; cv=none; b=dD+he0FZik+MT3EgKlRI2XZmhRXQXi5C5p4MtlezSGl8lYdjfq+IAmBadSSgIDnmJxUV2QsSInrjxy60NX3/4ITN1iQepozoNxAKSZ4ejvU/McUgEsAqAMNwnmgTNdGognm531ENRj6ZdCKZfIl/ubuc7k2nxBzEMxwfgPej+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390738; c=relaxed/simple;
	bh=Yn88Pg0vMcc66C9CMonnkVjgM+Kw8NPXkajKjHvUqMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pA8lm/htBxQL5hevTp1fSFjBHsjdE6eOCAlwzC2qo9sjVSWTVDR6ExAuLqgNQiNlJ0mpa0RA21ldLEK1W/UoRr1rFyfJf1Xmkjl/gnmSH2E32MKj6w7MaDGzHrnffYj1ebUWzk0uZCNqMLMgX3ucetbdBvG+D4zg4JD7YLjTiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKvG8uiz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pQy3sV4k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768390735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0h6NKVbWVYP+F+luUS4YFm9OAqVWQtYmKRMMyGnW+Nw=;
	b=EKvG8uizTbHws/bY3f2WsDPiDleyPhqW4x2keSEqhl0OypX1HM1f7DpzypiZFylznty6Cd
	xQAtCUsrjrZ0E88XR4j7tKAfI8xDg7liKe3SY74KxjSgQltOF8hc7TBSeCy5HjeXUHzzx0
	yD3uAmMEb+E5EiBWUovTfHgPnmFqLUU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-_c0-RvXzPYCxAWAJwPW67w-1; Wed, 14 Jan 2026 06:38:53 -0500
X-MC-Unique: _c0-RvXzPYCxAWAJwPW67w-1
X-Mimecast-MFC-AGG-ID: _c0-RvXzPYCxAWAJwPW67w_1768390733
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45a20cdf2acso18021896b6e.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768390733; x=1768995533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h6NKVbWVYP+F+luUS4YFm9OAqVWQtYmKRMMyGnW+Nw=;
        b=pQy3sV4k7ciVTQ2LE6nhoSQo6cq5zgPiOQbDtKD+ySBBBV7LNqRKdpkxc+e0B5EL8e
         oaXbqjWxdLDPQRqyJn1sjOYedhzVahRY6N6HrAWrwW6lUfme8cbbBMsE330t2yCR9ZsD
         MVScOPHQTA4r3KZjrbAvIObDP6W615kVr8KQM0MWl0rc+ddEORpw8fE7RoOKXogUPywW
         uL1XbXLCGTvm0U6WxCM/0pHu/3CSP+Ced1En7eOxXXbhi/oS7O788PMaqc94OLbCZXCt
         j2eOf3p2qlvKkk7HWsHGweeBK5stMVCxZTDT1yIGd6r67dCXFVt7T71k+pLuroBLseYQ
         U/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768390733; x=1768995533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0h6NKVbWVYP+F+luUS4YFm9OAqVWQtYmKRMMyGnW+Nw=;
        b=iZi4kdvUGwaJ4QULFXtGioH1IGxcRVceQ+YgOPcAOCOrVwgo3ocIbg4Ysu8eSjfNqX
         LCetF2wYAUbS8CPkzZwVU5cPAqYDYl+EheZUUrb7e3yt887e21RKkY+WR6BkT+3rjwQ6
         izRj+NYUJ6LJ74c/S7WNAJncFhx3/cI4GpZcBt0U5/e/wH9eh02urdIL/LVR2fCrztq9
         mYkurzgYsThYi8DDDQaJxNKWA3h0DE7/rgad53SGhbCyo8yVIyfzgpF0oOZz7L4om9DR
         dJS2kIJlXE6HTs4vM0dER7RkXkNJ4DU9StsXf5GTmz5VRhVX7M6IqcZtQHDbiZzi8dxz
         Qggg==
X-Forwarded-Encrypted: i=1; AJvYcCUShEIE02AhG7y+5CcDjj92YGmxfjtaRTEMmzTYbk0bJiURSC6lyzu3b3pS+/udUuil+sUfLf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf+1uk2CYicWKDoOx4wANFfY8PvEqhWsCP4sw5ZOzK1BRr8SDo
	ceb1nSbvwdg0lqSy5c9WhbsDEJ26GitgjKu7rjdWd/hXrTjm8GnkCSHohivh4uM1+9Smq3ytiH/
	M7AOrwL6oBTqGaAReWDkjyLA8drCYdzcV2nUyap1KTXZ2v63rX1cNituNoTAVLeezVehn528val
	g9BPSwAuYcur2OGNTS13RvZ3gZcxr41/N7
X-Gm-Gg: AY/fxX6E46epUWRBvsxhzclNtjrGINYOytb6SlNaY8LKxQiOL/onkifWNInW4sdL088
	dwXxHC+sqbGpXaQoDJYiXDfecVYats6igsWiL2bWiyKEoghm2kYnatKVKJxawTdathTpUkxlFII
	adNKCPPPdaIyXpzUzjBw7aBAUhpSZ7kdmemYprr1Ey2haN7ImousXy1ky/Fg203m5vwRk=
X-Received: by 2002:a05:6808:690a:b0:453:860a:fed with SMTP id 5614622812f47-45c7153cddfmr1353854b6e.36.1768390732978;
        Wed, 14 Jan 2026 03:38:52 -0800 (PST)
X-Received: by 2002:a05:6808:690a:b0:453:860a:fed with SMTP id
 5614622812f47-45c7153cddfmr1353841b6e.36.1768390732559; Wed, 14 Jan 2026
 03:38:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120105208.2291441-1-grzegorz.nitka@intel.com>
 <20251216144154.15172-1-vgrinber@redhat.com> <IA1PR11MB621913F389165EE4D7CCFF2D9284A@IA1PR11MB6219.namprd11.prod.outlook.com>
 <CACLnSDikAToGRvfZAhTcT0NCtMj+N9z-GGzRQ5qmpHsvCr2QSA@mail.gmail.com> <LV4PR11MB9491EB644FC83676522107669B8FA@LV4PR11MB9491.namprd11.prod.outlook.com>
In-Reply-To: <LV4PR11MB9491EB644FC83676522107669B8FA@LV4PR11MB9491.namprd11.prod.outlook.com>
From: Vitaly Grinberg <vgrinber@redhat.com>
Date: Wed, 14 Jan 2026 13:38:36 +0200
X-Gm-Features: AZwV_QhMnX5vuJC2sC36pYCBqaNsIqpLqRK16xJXdk4kL6u-XItifBTye6cYGWk
Message-ID: <CACLnSDhEQVJ5piUKp6bddxvOff88qj5X6Y8zbqAH8Kf5a7a_Zg@mail.gmail.com>
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
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 12:23=E2=80=AFPM Kubalewski, Arkadiusz
<arkadiusz.kubalewski@intel.com> wrote:
>
> >From: Vitaly Grinberg <vgrinber@redhat.com>
> >Sent: Saturday, January 10, 2026 10:29 PM
> >
> >Hi Grzegors,
> >Thanks very much for your reply! Added some clarifications inline.
> >
> >On Wed, Jan 7, 2026 at 11:33=E2=80=AFPM Nitka, Grzegorz <grzegorz.nitka@=
intel.com>
> >wrote:
> >>
> >> > -----Original Message-----
> >> > From: Vitaly Grinberg <vgrinber@redhat.com>
> >> > Sent: Tuesday, December 16, 2025 3:42 PM
> >> > To: Nitka, Grzegorz <grzegorz.nitka@intel.com>
> >> > Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Nguyen,
> >> > Anthony L <anthony.l.nguyen@intel.com>; Kubalewski, Arkadiusz
> >> > <arkadiusz.kubalewski@intel.com>; horms@kernel.org; intel-wired-
> >> > lan@lists.osuosl.org; linux-doc@vger.kernel.org; linux-
> >> > kernel@vger.kernel.org; netdev@vger.kernel.org;
> >> > pmenzel@molgen.mpg.de; Kitszel, Przemyslaw
> >> > <przemyslaw.kitszel@intel.com>
> >> > Subject: Re:[Intel-wired-lan] [PATCH v5 iwl-next] ice: add support
> >> > for unmanaged DPLL on E830 NIC
> >> >
> >> > Will a notification be provided when the lock is re-acquired?
> >> >
> >>
> >> Hi Vitaly, thanks for your comments.
> >> We discussed it offline already, but I think I need more clarification=
s.
> >>
> >> Regarding above question ... yes, 'lock' recovery shall be reported in
> >>the same way.
> >> Maybe the name of health status is a little bit misleading
> >> (ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK),
> >> However health_info struct contains the current lock status (either
> >>'locked' or 'unlocked').
> >
> >Great, thanks for clarifying this!
> >
> >> > Another concern is the absence of periodical pin notifications. With
> >> > the E810, users received the active pin notifications every 1
> >> > second. However, the unmanaged DPLL appears to lack this
> >> > functionality. User implementations currently rely on these
> >> > periodical notifications to derive the overall clock state, metrics
> >> > and events from the phase offset. It seems that unmanaged DPLL users
> >> > will be forced to support two distinct types of DPLLs: one that
> >> > sends periodical pin notifications and one that does not. Crucially,
> >> > this difference does not appear to be reflected in the device
> >> > capabilities, meaning users cannot know in advance whether to expect
> >> > these notifications.
> >>
> >> After reading it one more time, I'm not sure if I get it right in the
> >> first place.
> >> With this patch implementation, there is dpll change notification
> >> applied.
> >> By dpll notification I mean calling dpll_device_change_ntf function.
> >> Isn't it what you're looking for?
> >> Notification is triggered only in case when lock status has changed.
> >> It's unmanaged DPLL so the implementation is a little bit simplified,
> >> based on FW notification.
> >> There is no need for polling thread like it's done for E810.
> >> But even in case of E810, where polling is applied (2 samples per
> >> second), notification is triggered only in case of dpll/pin status
> >> change, not every 1 second.
> >> So please clarify, so either I don't understand the question (please
> >> note, I'm only covering the main author) or notification mechanism, at
> >> least about dpll lock state, is already implemented.
> >>
> >
> >Yes, device lock status change notification is definitely what we are
> >looking for, but there is more. Let me clarify the user perspective.
> >The e810-based telco system relies on both device and pin notifications.
> >Phase offset included in pin notifications is critical because the e810
> >DPLL "Locked" state is too coarse for Telco requirements.
> >It is true that pin notifications are only sent on change; however, sinc=
e
> >the phase offset varies slightly with every measurement, the driver dete=
cts
> >a change every second. This effectively turns the event-driven notificat=
ion
> >into a periodic one. The e810-based application strongly relies on the f=
act
> >that phase offset notifications are unsolicited and the driver sends the=
m
> >from time to time.
> >Now, with the unmanaged DPLL, no pin notification will be sent. Last tim=
e I
> >checked, the device and pin information looked like this:
> >Device:
> > {'clock-id': 1165870453030569040,
> >  'id': 4,
> >  'lock-status': 'locked',
> >  'mode': 'automatic',
> >  'mode-supported': ['automatic'],
> >  'module-name': 'ice',
> >  'type': 'eec'},
> >
> >Input pin:
> >{
> >  "id": 17,
> >  "module-name": "ice",
> >  "clock-id": 1165870453030569040,
> >  "board-label": "1588-TIME_SYNC",
> >  "type": "ext",
> >  "capabilities": [],
> >  "frequency": 10000000,
> >  "phase-adjust-min": 0,
> >  "phase-adjust-max": 0,
> >  "parent-device": [
> >    {
> >      "parent-id": 4,
> >      "state": "connected",
> >      "direction": "input"
> >    }
> >  ]
> >}
> >
> >I see a few challenges for the user here. The biggest one is that the
> >application can't tell the difference between a device that will report
> >phase offsets and this unmanaged device that never will.
> >A possible way forward would be adding a capability flag to the DPLL API=
 so
> >users don't have to guess.
>
> There is no phase-offset field as pointed in the above example.
> No 'phase-offset' attribute -> no such capability.
> Why isn=E2=80=99t that enough?

Pin reply does not contain phase offset, so no change notifications
are expected?
Could there be devices that don't report phase offset, but report state cha=
nges?
Is this the intended use of the phase offset API to be interpreted as
a general pin
notification capability flag?

>
> >However, the preferred solution would be to simply mirror the E810 behav=
ior
> >(sending phase offset). This preserves the existing API contract and
> >prevents users, who have already built applications for this interface,
> >from needing to implement special handling for a new hardware variant th=
at
> >behaves differently.
>
> This is not currently possible from driver perspective.
> We miss the FW API for it.
>
> >There are additional inconsistencies in the existing structure I wanted =
to
> >bring to your attention.
> >1. I'm not entirely sure how a 1588-TIME_SYNC pin can have a parent devi=
ce
> >of type "eec". EEC is all about frequency synchronization, and yet the p=
in
> >named 1588-TIME_SYNC is clearly a phase pin. This also doesn't play well
> >with existing implementations, where EEC circuits deal with frequency, P=
PS
> >circuits deal with phase, and there is clear distinction between the two
> >with regard to the meaning of "being locked".
>
> This dpll device type was established based on the main purpose of dpll
> device which is to drive the network ports phy clocks with it.

What is the physical meaning of this indication (lock-status':
'locked')? Locked on what?
As a user of this circuit I want to know that the device is locked on
the phase of the input signal with a certain precision.
Is this the meaning of "locked" here? Can an EEC device be locked on
the Phase of the input signal?
Users of other devices (e810, zl3073x) may have implemented logic to
determine the phase lock by
enforcing the pin parent device type as PPS. How should they change it
to determine phase lock (and why)?

>
> >2. Since it is also an external embedded sync input pin, could it be
> >possible to expose this information and include `esync-frequency` and
> >`esync-pulse`? That could be useful for configuring the leading DPLL tha=
t
> >drives the unmanaged one.
>
> Sure, esync caps should be provided, as the commit message example shown:
> +    'esync-frequency': 1,
> +    'esync-frequency-supported': [{'frequency-max': 1, 'frequency-min': =
1}],
> +    'esync-pulse': 25,
>

Oh, I must have missed that.
Thanks!
Vitaly

> Thank you!
> Arkadiusz


