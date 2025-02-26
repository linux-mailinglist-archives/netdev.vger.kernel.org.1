Return-Path: <netdev+bounces-169833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A677AA45DDC
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97DE1629BE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1454D218ABB;
	Wed, 26 Feb 2025 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkyro3sW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB921858F
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570762; cv=none; b=emJ2DExWl3ysAUe1kFZubZccxatCWx+2ELIJ+pN4BFYT5oKKa1i9ebOonFh3a24/oHeOeGEuIelmr7Naz85aYFBi7uBXkgpJr8kjpgwJE6TY4RUDzdCeY/ZJcllAT37jrMW/5qHBtrWRtm38wp+wyYqQN2FZ36qoVYhaiheuEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570762; c=relaxed/simple;
	bh=yLPiWqE9QPO2riHPtNReAM0TbvEal4LS9jQrPP5fdq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3botproanWXyBPFzkL5+dpQyoQpZlOh1mX0VYWvxWkQY1OBuWpM7kiqMwM2Vj6jeshSJruAAx9hVw/f9QysBSQQoOUn/D4LND5ueo75R5+UPL/NzhR3guZjRErKjjZsW7t77+lakg1mCTIschhuWyd3TDkswxU+nNTixfC4vVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkyro3sW; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-869440f201eso3797011241.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740570759; x=1741175559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdNokA8Z5Jtxar8CduigoWJVr6S32/u/GA6MTVyW8vg=;
        b=lkyro3sWLENfo3zffNaz60ZYWNinbxOjsnhOsfxS/TWuUugaKc85wbzPfTur3Q2niV
         8/23KC6gkKnSfPey0TViEsukwHrENr5uqZSGzIugx8xcLPT2Rbw/oVgb39zoB6G+LQA/
         P2ZrFybSoHplMhen2LUqKBjNDywgeBnTR3u8kY1FXt+AexueUJHCBbzsWSDDgSI7aEqS
         faj35fWKUXXwM5rdOD6MA6wFEm6JXhjqElugvebzAkjkHvc4llQtgJgS5v6oW1xrsTPS
         rmYtsfFBjnAowDEjtvfHOHDSw5fsvKZ4H9Vd7o9m+2r4UjGGNNwPTzjRjA4GQ71KEQHH
         PjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740570759; x=1741175559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdNokA8Z5Jtxar8CduigoWJVr6S32/u/GA6MTVyW8vg=;
        b=rbfOwHOwmHp1dM2OdBlNCtqOdhfwybHlFnsRDkyjgnddchDcarXqqG2AsfKQthPN5n
         +JuJEEXZcJfJyGuVFoZ+Xk8mrOPM8LeGTa8ipo0SBT61l2M2zynWfMMBUbDq6fl1F8vg
         9N/VtCFPsPCSn65GjXBuXXpFnT6XUJsYYz/oueZclj9NWvZk7rY23C4wklUZsibGM73m
         QgcGCHiF/Xtp6VUYpTcNGoC4exNW1qmm12ZdTYF8iUUNmNfGqgrLsbp7ri18btN1aC2N
         klYHVfPnwa5h8tmQ9f+nNBSERLMh9u+JiyVAsNEvIIvj8HrFEgInTaZX8oh+KIQKwlUf
         Bceg==
X-Forwarded-Encrypted: i=1; AJvYcCVqPF76izPXEtW8nO5+TfLwrU+5rzIk7AFf7jELlJdbjCdFY0c7y2Mt/iBV/x8AHenUhTWepyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7bq4HrlaUnuxmpA9Bzs8Zy+8YIos8U4b/5Ni8e4P+gVOLCyTi
	ejgWfl281dUle5WLqvXmuOih0gSCf/ToY8wfy4sdb7P58wNG7bYZLhs2YB5XpwfBEGXW8uJacm9
	IJogZvJ5kLUv49ko5SWhmX22d1wAB5QUw
X-Gm-Gg: ASbGncvO9WAbnnSalPhfEwG5UHLJuURV7mjWT8UVR+auIpTxmBUq82nQ4CU2c4P0Jon
	vykHfKtgWf7DvthIjtoE9rMvP9N6s/H1CBco2yRn3gPowj7aKJicof5nxG52tF6QSK11r6ZnAuk
	BoxdZYOg==
X-Google-Smtp-Source: AGHT+IFN3YDTDwqQKkD/sKXlt6vzIzhBmNbrFZFsuJje52d/BFFIeJBNSdwhKV3Gnes7n1kskpVmZJbhAcXdulFLtWE=
X-Received: by 2002:a05:6102:508b:b0:4bc:82f:b4c8 with SMTP id
 ada2fe7eead31-4bfc28ed65fmr11201582137.18.1740570759042; Wed, 26 Feb 2025
 03:52:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZveppNgEVa_FD+qhOMtG_AavK9_mFiU+jWrMtXmwqefGA@mail.gmail.com>
 <CAA85sZuv3kqb1B-=UP0m2i-a0kfebNZy-994Dw_v5hd-PrxEGw@mail.gmail.com>
 <20250225170545.315d896c@kernel.org> <CAA85sZuYbXDKAEHpXxcDvntSjtkDEBGxU-FbXevZ+YH+eL6bEQ@mail.gmail.com>
 <CAA85sZswKt7cvogeze4FQH_h5EuibF0Zc7=OAS18FxXCiEki-g@mail.gmail.com> <a6753983-df29-4d79-a25c-e1339816bd02@blackwall.org>
In-Reply-To: <a6753983-df29-4d79-a25c-e1339816bd02@blackwall.org>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Wed, 26 Feb 2025 12:52:28 +0100
X-Gm-Features: AQ5f1JrYX-xbPpxl-GxGO4qO_DGxSpiVa6SUHwyFzN0y02tl88DFDHlyNdO8NT8
Message-ID: <CAA85sZsSTod+-tS1CuB+iZSfAjCS0g+jx+1iCEWxh2=9y-M7oQ@mail.gmail.com>
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 11:33=E2=80=AFAM Nikolay Aleksandrov
<razor@blackwall.org> wrote:
>
> On 2/26/25 11:55, Ian Kumlien wrote:
> > On Wed, Feb 26, 2025 at 10:24=E2=80=AFAM Ian Kumlien <ian.kumlien@gmail=
.com> wrote:
> >>
> >> On Wed, Feb 26, 2025 at 2:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> >>>
> >>> On Tue, 25 Feb 2025 11:13:47 +0100 Ian Kumlien wrote:
> >>>> Same thing happens in 6.13.4, FYI
> >>>
> >>> Could you do a minor bisection? Does it not happen with 6.11?
> >>> Nothing jumps out at quick look.
> >>
> >> I have to admint that i haven't been tracking it too closely until it
> >> turned out to be an issue
> >> (makes network traffic over wireguard, through that node very slow)
> >>
> >> But i'm pretty sure it was ok in early 6.12.x - I'll try to do a bisec=
t though
> >> (it's a gw to reach a internal server network in the basement, so not
> >> the best setup for this)
> >
> > Since i'm at work i decided to check if i could find all the boot
> > logs, which is actually done nicely by systemd
> > first known bad: 6.11.7-300.fc41.x86_64
> > last known ok: 6.11.6-200.fc40.x86_64
> >
> > Narrows the field for a bisect at least, =3D)
> >
>
> Saw bridge, took a look. :)
>
> I think there are multiple issues with benet's be_ndo_bridge_getlink()
> because it calls be_cmd_get_hsw_config() which can sleep in multiple
> places, e.g. the most obvious is the mutex_lock() in the beginning of
> be_cmd_get_hsw_config(), then we have the call trace here which is:
> be_cmd_get_hsw_config -> be_mcc_notify_wait -> be_mcc_wait_compl -> uslee=
p_range()
>
> Maybe you updated some tool that calls down that path along with the kern=
el and system
> so you started seeing it in Fedora 41?

Could be but it's pretty barebones

> IMO this has been problematic for a very long time, but obviously it depe=
nds on the
> chip type. Could you share your benet chip type to confirm the path?

I don't know how to find the actual chip information but it's identified as=
:
Emulex Corporation OneConnect NIC (Skyhawk) (rev 10)

> For the blamed commit I'd go with:
>  commit b71724147e73
>  Author: Sathya Perla <sathya.perla@broadcom.com>
>  Date:   Wed Jul 27 05:26:18 2016 -0400
>
>      be2net: replace polling with sleeping in the FW completion path
>
> This one changed the udelay() (which is safe) to usleep_range() and the s=
pinlock
> to a mutex.

So, first try will be to try without that patch then, =3D)

> Cheers,
>  Nik
>

