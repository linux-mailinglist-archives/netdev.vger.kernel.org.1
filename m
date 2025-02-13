Return-Path: <netdev+bounces-166048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC11A34183
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1BF1894DBA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39AC242914;
	Thu, 13 Feb 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGBtmAOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07324290F
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455618; cv=none; b=j6MI/Q1kbzIQAKHbgnWhtumM6omCaZkqNT40ivjBLdU9rTw/2sBG21Sehfxvsu8hKlTUHTcYzKw7ovkHk5ZwHFGC942EC0zcRZUwVpl4hO9Lci/Sk2AOViiDygs//zzsaYgY6Pzch5dRZXcIGC0SNR2EoEv4idRKNpRmcEcpSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455618; c=relaxed/simple;
	bh=RhLnZ4v0ULKWu0iDwJ0sh3qj5XEB/ULxdttsDFS1KZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nekIKxYsTb4C7uVgw8u46WUrNGnUNuEeOSpFQmpAms80FHN5YN85OBNzx7PcEeZPnse6KxdhWryS5Jc9nBIrrd246a4zM+8z/j97IZOcpfjinjCYwb5QwDfE2WBkZaI4vsRXvM2Op8YexYfILqW+vBi6yClbRsvqYOKG29j47Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGBtmAOT; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e573136107bso852743276.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 06:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739455616; x=1740060416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+s+afruOes/BeN3oETSozjf5b7KtJvFcnsAPWmxBXE=;
        b=jGBtmAOTh3l67r1MgaI3mBZy/RhqISfjGT4PcnhGD7V7Vf7uUlAsYY3BnrspP5G3XF
         KfV/QB4hnIfWYWxiOtPesPduvrR+/QeTRxenvXaSLxy/0v8Y1N8YHM7AxLAW+J6QmWZJ
         5fUIq0KZpViP9z+vPmUgIgFgXFxncPAhotgDBDKK9vIkA5YzZUC+FDECkbdI5Xl1dBRX
         fEY4l4rtSfJQx5guiKE/PayDqFnEf85lDaMFegEXBfCVyqZUyiI1ZEft5DQf5X2oGEIw
         B776jlUaDlmCxVStHNih5qLzHhjgD8G9tf6b9Jj5rlrNxbV0OYM8EFX8X6K/tOgXoZSk
         e04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739455616; x=1740060416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+s+afruOes/BeN3oETSozjf5b7KtJvFcnsAPWmxBXE=;
        b=Y8ewfjGb/a3eQJAx3cadWB2bo9d3UYjiG2PSSSYdPGqiktzZJcUwufLXsR1W5tx5ki
         Ipfq82dKdygla/LLqvNl+WFNxJwULfePFneXkUImY113oqye0dCgAYx9M1vEYsUWkfCk
         mmyfXg4xbM2+Ol9A7IqnoUS8mkHfaXiMrx08WD948qbYvOEfJMaitX9253dzTBBPwwIv
         1/3ri+ORtgTBZXNOAZVCiH0d+pT1tz7wLIWv/GE0mpMSPwcWoIb+iEGLCiolstkj/HB7
         fPLCNQVAH0xqIhFOGisn3CbrzcAiH1EPrOOt0eyXE0ur0GtEC8crMREt4RuZ1UJ2S8Nc
         2Vqg==
X-Forwarded-Encrypted: i=1; AJvYcCVebOUJOxfeOSX5Bld6MN6Si/Tvee3VbeQs0H55dweKyX/KGROCQUuL4ZUpQabAgxwQATK4k+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQAGsA4poV/8fF5wvWC0yRF7qerDvW6j1jD5lp8cmaz0oAG38
	vnG9gvCeAziKwKzTcCtVwz/dcRd1Ia9br0sb0AOMpM9SGIrgbYReDoJguQqlRs/AAyj5mPCrdnz
	vCQfoqad/pcWtqULrJx+7giVYOJ5y5ju6dHPj
X-Gm-Gg: ASbGncsp+W8U5MdYdkPQv3JGXO9LWKYwPT9+cTDM4tJA0FDmzFJjTSVaHdM6oiGZ7l0
	sGOiADEuGWF2ynUnphYusDenKDTMmMdabBOG5wwP7OazhSFWeDn2SeerzkciL/7j+d0Hfdw==
X-Google-Smtp-Source: AGHT+IHp4oKPpDwKn7fG2TZzfyhaRjClxyo44F1t8DHE32SHPkpBM0l/RG3OXzwrkmmXl3IBHPn6cwzhD7yCo0ce5l0=
X-Received: by 2002:a05:6902:168c:b0:e5d:a934:701e with SMTP id
 3f1490d57ef6-e5da9347252mr2175525276.45.1739455615450; Thu, 13 Feb 2025
 06:06:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021352-dairy-whomever-f8bd@gregkh> <CADg1FFdez0OdNDPRFPFxNHL_JcKmHE6KNxnYvt4sK7i+Uw6opA@mail.gmail.com>
 <2025021347-washboard-slashed-5d08@gregkh> <CADg1FFdbKx3z+SPWFmY4+xZmewh0MnnZp_gmYEdY0z-mxutmEw@mail.gmail.com>
 <2025021318-regretful-factsheet-79a1@gregkh>
In-Reply-To: <2025021318-regretful-factsheet-79a1@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 13 Feb 2025 22:06:28 +0800
X-Gm-Features: AWEUYZk7KS1Z1NcVHtfdSpQsvsw9_eZGxVqxrJuVNvRinHaH1zuC1_kaAxufDe4
Message-ID: <CADg1FFf5hGrMM8fxiKFF5ZqEMZbsJzByp6+VuaXjJZnDPN2oUg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] Bluetooth: Fix possible race with userspace of
 sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 9:45=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 13, 2025 at 09:33:34PM +0800, Hsin-chen Chuang wrote:
> > On Thu, Feb 13, 2025 at 8:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > A: http://en.wikipedia.org/wiki/Top_post
> > > Q: Were do I find info about this thing called top-posting?
> > > A: Because it messes up the order in which people normally read text.
> > > Q: Why is top-posting such a bad thing?
> > > A: Top-posting.
> > > Q: What is the most annoying thing in e-mail?
> > >
> > > A: No.
> > > Q: Should I include quotations after my reply?
> > >
> > > http://daringfireball.net/2007/07/on_top
> > >
> > > On Thu, Feb 13, 2025 at 07:57:15PM +0800, Hsin-chen Chuang wrote:
> > > > The btusb driver data is allocated by devm_kzalloc and is
> > > > automatically freed on driver detach, so I guess we don't have
> > > > anything to do here.
> > >
> > > What?  A struct device should NEVER be allocated with devm_kzalloc.
> > > That's just not going to work at all.
> >
> > Noted. Perhaps that needs to be refactored together.
> >
> > >
> > > > Or perhaps we should move btusb_disconnect's content here? Luiz, wh=
at
> > > > do you think?
> > >
> > > I think something is really wrong here.  Why are you adding a new str=
uct
> > > device to the system?  What requires that?  What is this new device
> > > going to be used for?
> >
> > The new device is only for exposing a new sysfs attribute.
>
> That feels crazy.
>
> > So originally we had a device called hci_dev, indicating the
> > implementation of the Bluetooth HCI layer. hci_dev is directly the
> > child of the usb_interface (the Bluetooth chip connected through USB).
> > Now I would like to add an attribute for something that's not defined
> > in the HCI layer, but lower layer only in Bluetooth USB.
> > Thus we want to rephrase the structure: usb_interface -> btusb (new
> > device) -> hci_dev, and then we could place the new attribute in the
> > new device.
> >
> > Basically I kept the memory management in btusb unchanged in this
> > patch, as the new device is only used for a new attribute.
> > Would you suggest we revise the memory management since we added a
> > device in this module?
>
> If you add a new device in the tree, it HAS to work properly with the
> driver core (i.e. life cycles are unique, you can't have empty release
> functions, etc.)  Put it on the proper bus it belongs to, bind the
> needed drivers to it, and have it work that way, don't make a "fake"
> device for no good reason.

Got it. Thanks for the info.

Hi Luiz, I will work on v5 to make btusb resources managed by device.
Any concern?

>
> thanks,

>
> greg k-h

--
Best Regards,
Hsin-chen

