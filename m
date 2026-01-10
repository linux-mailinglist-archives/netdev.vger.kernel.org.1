Return-Path: <netdev+bounces-248749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 493AFD0DE1C
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFAB3014BF9
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CD02BEFFE;
	Sat, 10 Jan 2026 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI0epgdr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="em68i5sH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C32989BC
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768080572; cv=none; b=b7fTPRK2q2jYPI9LY9hZakbtyWcYye+xYXuZzuNvhE0OmU3H+JSgCAPrjUPXWi29FW+RN0aq65viGsIV2iOhCUU9TuhTQwngoFqmymu3EmMevJd9VV+hOBEjHArU9Cb6NncdBfw1TRNHGUmVpqte5VbqhlB8PqbDNm5AE+Rcp5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768080572; c=relaxed/simple;
	bh=J7dbUPHbaST+GPjSqooeXuPPmnp9TEtru6bY2L/1Vh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fr8coYFJ66DvJBxm4SUZ1wPDjfp+9Yq1qejPvF8FGujkW5AGXjTj0sDlMb+3X6gVtq+3c4dBIpm4gR2TaW3W30FyOfjMlG+K7J+7wegPBHeNmWuf9wBAR3l9g0yv5jMfWV33pu46Dhy4RgM9TqJ5+GRlk9NPpEDF4NHz1Vm88xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hI0epgdr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=em68i5sH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768080569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkE+iVeStS9ap0ZdCuIewxyxpQ7WymUQDmHJWd1A0aI=;
	b=hI0epgdrDszfCDjlLs1qGluWl+V4JhfpabNWwONDPullRMeDz1IUBMWqYNkCcTnKjbBAlJ
	43yEW+1rfAvEXM3UQiOMi5p5FXIO0OGdGdyr/CFJpdzCNnC+LixEuCMOBC8xWwXVTb81r+
	dVGMUSSU8Cyo/wzcs2mYi4YOjfioynE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-4ym0DEU3Pc6SIU2yF--onQ-1; Sat, 10 Jan 2026 16:29:28 -0500
X-MC-Unique: 4ym0DEU3Pc6SIU2yF--onQ-1
X-Mimecast-MFC-AGG-ID: 4ym0DEU3Pc6SIU2yF--onQ_1768080567
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65b31ec93e7so12540367eaf.3
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 13:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768080567; x=1768685367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkE+iVeStS9ap0ZdCuIewxyxpQ7WymUQDmHJWd1A0aI=;
        b=em68i5sHgxyHfucAHkS1qh4/4I3VVKBxbauW3R1hyav+yTWsJS/bsO7p/n1vkpPtew
         kdXG99647wwFZveAWGb1Z6X+6EGtKnAA7El607JKyRwKyuqkJTXEZph6pbjweLIYtPwb
         FrOvq5RvgL198PFxYhf8XWWVPL6Mm3r1Str+/TxoBJiTIUx3uX/oT2P8+08CaYSBMfF6
         Y1GlfCLKLDp2JRW/7/HNT8xkX8o0bKoAfqM4BSG93+r2FNO22uj2qUgXJPP47rPusYff
         GXCAFaD3LlIFMqMhimXQBYd/JqJAJZiGx91ohsJ9ZdPm2hRjiFrLdMyAnMrlNDzRTjHk
         1GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768080567; x=1768685367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BkE+iVeStS9ap0ZdCuIewxyxpQ7WymUQDmHJWd1A0aI=;
        b=n7Msl876zSQNm5RKZPSvJkZp605U0pOuQfI0LUoJciTpQKE62dsIoGRIoJLZEE5Rv2
         Wu7mHZC4dhRB/Ss4jAliLdQkQnHTlIQ2AeFCKC8+H8UpCuxkEbzdniwri/apGuZZ0jKv
         O55B89pH2EJ5e8pFT0el5toi8IvuicQlas/p49C4O9A2KoVin4m8D7zK36efq7iYUd2U
         dEGz3sP9KuWoVsnsaen486/sNxNMnZb8RkPBrRzITMlpI3dU9X2zuVTwTPiGk68YjSVw
         2vZ0+EojpIq0Tk7cAwqCubg8/wOmcT7p3usErR16yWaGGs2wGsCZdNYsOjQT5z1TR5cq
         aYsA==
X-Forwarded-Encrypted: i=1; AJvYcCWXsTOUVrn3g64FcmIyZ/QrbYUM69ae6u69yZeZKP7UWmTFBODoK0lGE7JcYhJPbdjL2aydif4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmz9Ay0clPOo+O8upLBEZHA8MPjhmt+BJfYp6enYQVugqeI+TE
	9sNBxL6juLEfPQTBc2eMU2k3aovvxHtT3uCBFSFK5eGy/iYKmCm5Bfp37cV45nTHZZ/WesA499V
	FxNcD1PM4taESssxsOsHNgOKMjfzXJilQ04T26zoxy3SlB6xFLeblJ1Nxt7Z2SvNKrpm919LV+O
	cmeAbSqXodz0EJodPxEzcfr6GM04AcNolO
X-Gm-Gg: AY/fxX5HPUzXk2ZZI+nyzgCj80uzK1cF2a5ZeTJGLeL54fNiB4PWL0c3vnnIOyK5bkD
	fy0lmriG6DGmNu/pEY6qhjISVA0dXjOJXpO0S/FAiUM4zY8ENqXcCjAhYqpezJX1saGJUGHWuvA
	vpzWlzxZqbdivUp4v0DYi0rS2xXnfQiXb7zcRNG8dpgWJXPQi6rJiUehI3+tXRhN1vZMI=
X-Received: by 2002:a05:6820:22a7:b0:65b:3bd8:a75b with SMTP id 006d021491bc7-65f550bc142mr6987823eaf.72.1768080567488;
        Sat, 10 Jan 2026 13:29:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpyjnhS5jcpniHuaklJ+T3KGnZiN96XIuwq9ire6t4KN0lmKgSW0u9SpewvA8rcsxnswYJlGQzjtE9HD0XJYM=
X-Received: by 2002:a05:6820:22a7:b0:65b:3bd8:a75b with SMTP id
 006d021491bc7-65f550bc142mr6987818eaf.72.1768080567120; Sat, 10 Jan 2026
 13:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120105208.2291441-1-grzegorz.nitka@intel.com>
 <20251216144154.15172-1-vgrinber@redhat.com> <IA1PR11MB621913F389165EE4D7CCFF2D9284A@IA1PR11MB6219.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB621913F389165EE4D7CCFF2D9284A@IA1PR11MB6219.namprd11.prod.outlook.com>
From: Vitaly Grinberg <vgrinber@redhat.com>
Date: Sat, 10 Jan 2026 23:29:16 +0200
X-Gm-Features: AZwV_QiG9tsTWyQKEuQ2eM2JGegyP9OgXPzgej6rvWd8OC-c8f-x0zTbTbP3QMk
Message-ID: <CACLnSDikAToGRvfZAhTcT0NCtMj+N9z-GGzRQ5qmpHsvCr2QSA@mail.gmail.com>
Subject: Re: Re:[Intel-wired-lan] [PATCH v5 iwl-next] ice: add support for
 unmanaged DPLL on E830 NIC
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, "horms@kernel.org" <horms@kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Grzegors,
Thanks very much for your reply! Added some clarifications inline.

On Wed, Jan 7, 2026 at 11:33=E2=80=AFPM Nitka, Grzegorz
<grzegorz.nitka@intel.com> wrote:
>
> > -----Original Message-----
> > From: Vitaly Grinberg <vgrinber@redhat.com>
> > Sent: Tuesday, December 16, 2025 3:42 PM
> > To: Nitka, Grzegorz <grzegorz.nitka@intel.com>
> > Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Nguyen,
> > Anthony L <anthony.l.nguyen@intel.com>; Kubalewski, Arkadiusz
> > <arkadiusz.kubalewski@intel.com>; horms@kernel.org; intel-wired-
> > lan@lists.osuosl.org; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; netdev@vger.kernel.org;
> > pmenzel@molgen.mpg.de; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>
> > Subject: Re:[Intel-wired-lan] [PATCH v5 iwl-next] ice: add support for
> > unmanaged DPLL on E830 NIC
> >
> > Will a notification be provided when the lock is re-acquired?
> >
>
> Hi Vitaly, thanks for your comments.
> We discussed it offline already, but I think I need more clarifications.
>
> Regarding above question ... yes, 'lock' recovery shall be reported in th=
e same way.
> Maybe the name of health status is a little bit misleading (ICE_AQC_HEALT=
H_STATUS_INFO_LOSS_OF_LOCK),
> However health_info struct contains the current lock status (either 'lock=
ed' or 'unlocked').

Great, thanks for clarifying this!

> > Another concern is the absence of periodical pin notifications. With th=
e E810,
> > users received the active pin notifications every 1 second. However, th=
e
> > unmanaged DPLL appears to lack this functionality. User implementations
> > currently rely on these periodical notifications to derive the overall =
clock
> > state, metrics and events from the phase offset. It seems that unmanage=
d
> > DPLL users will be forced to support two distinct types of DPLLs: one t=
hat
> > sends periodical pin notifications and one that does not. Crucially, th=
is
> > difference does not appear to be reflected in the device capabilities,
> > meaning users cannot know in advance whether to expect these
> > notifications.
>
> After reading it one more time, I'm not sure if I get it right in the fir=
st place.
> With this patch implementation, there is dpll change notification applied=
.
> By dpll notification I mean calling dpll_device_change_ntf function.
> Isn't it what you're looking for?
> Notification is triggered only in case when lock status has changed.
> It's unmanaged DPLL so the implementation is a little bit simplified, bas=
ed on FW notification.
> There is no need for polling thread like it's done for E810.
> But even in case of E810, where polling is applied (2 samples per second)=
, notification is triggered only in case of
> dpll/pin status change, not every 1 second.
> So please clarify, so either I don't understand the question (please note=
, I'm only covering the main author)
> or notification mechanism, at least about dpll lock state, is already imp=
lemented.
>

Yes, device lock status change notification is definitely what we are
looking for, but there is more. Let me clarify the user perspective.
The e810-based telco system relies on both device and pin
notifications. Phase offset included in pin notifications is critical
because the e810 DPLL "Locked" state is too coarse for Telco
requirements.
It is true that pin notifications are only sent on change; however,
since the phase offset varies slightly with every measurement, the
driver detects a change every second. This effectively turns the
event-driven notification into a periodic one. The e810-based
application strongly relies on the fact that phase offset
notifications are unsolicited and the driver sends them from time to
time.
Now, with the unmanaged DPLL, no pin notification will be sent. Last
time I checked, the device and pin information looked like this:
Device:
 {'clock-id': 1165870453030569040,
  'id': 4,
  'lock-status': 'locked',
  'mode': 'automatic',
  'mode-supported': ['automatic'],
  'module-name': 'ice',
  'type': 'eec'},

Input pin:
{
  "id": 17,
  "module-name": "ice",
  "clock-id": 1165870453030569040,
  "board-label": "1588-TIME_SYNC",
  "type": "ext",
  "capabilities": [],
  "frequency": 10000000,
  "phase-adjust-min": 0,
  "phase-adjust-max": 0,
  "parent-device": [
    {
      "parent-id": 4,
      "state": "connected",
      "direction": "input"
    }
  ]
}

I see a few challenges for the user here. The biggest one is that the
application can't tell the difference between a device that will
report phase offsets and this unmanaged device that never will.
A possible way forward would be adding a capability flag to the DPLL
API so users don't have to guess.
However, the preferred solution would be to simply mirror the E810
behavior (sending phase offset). This preserves the existing API
contract and prevents users, who have already built applications for
this interface, from needing to implement special handling for a new
hardware variant that behaves differently.
There are additional inconsistencies in the existing structure I
wanted to bring to your attention.
1. I'm not entirely sure how a 1588-TIME_SYNC pin can have a parent
device of type "eec". EEC is all about frequency synchronization, and
yet the pin named 1588-TIME_SYNC is clearly a phase pin. This also
doesn't play well with existing implementations, where EEC circuits
deal with frequency, PPS circuits deal with phase, and there is clear
distinction between the two with regard to the meaning of "being
locked".
2. Since it is also an external embedded sync input pin, could it be
possible to expose this information and include `esync-frequency` and
`esync-pulse`? That could be useful for configuring the leading DPLL
that drives the unmanaged one.


