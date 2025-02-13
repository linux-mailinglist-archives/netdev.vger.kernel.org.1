Return-Path: <netdev+bounces-166051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D36F3A341DE
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5B7188FF72
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD483281360;
	Thu, 13 Feb 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj3dfVsd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669E281346;
	Thu, 13 Feb 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456565; cv=none; b=eBE11aZVQWYTwPkLiXHxBUdUzpOAafC3+XH1UShMaEydnm7n/PVgdlaSHUNXvApRoKpwpI7goO6o5ZMiGWdvCF2nTxnYY9oLLG5mIVKj9Pv7re81ckvK/TwA3fjn+A/Qr1f8erjRVtDspTYXc+XZwOi10oQOWtKJT++XBhzurV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456565; c=relaxed/simple;
	bh=gp/dO/Ps7kKSFA+bpO1ArTJtw3cZrvtuU4i1UR7bb88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKYGu99q9iPIMOFVtmJslJ25f9D4zAIZuGrAzsPmfXrphwgLhjGhkUr+KGUJdjep1/5riTSKRoECVS1NNxix/KJe52LqNeUMz0B/FvVR2sV8icB2ppZEz42d9pHzneFpg2SmzaRswQuko2o9+0IykiY9jJ4lIdAjMg2tyXirgLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj3dfVsd; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-308e9ff235bso8366371fa.2;
        Thu, 13 Feb 2025 06:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739456561; x=1740061361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZmWSiUWpnRK0ksjdmL98E8SgC5cSifduv2jJAfiEPY=;
        b=Jj3dfVsd4tqZmupytHtEHUVB/6pmOt+DNsrKxewTBR5DYXQ1QWEKswTaT9Hsb3145o
         rJhBFkOnLK/wfk75i7u6XkmyDLIM20UdhOSIVz6VBwtWP0FPdnBBWVlwUsGp7sJfrwsO
         Tu9CGh9uVgX6BGhXlUcrLgYZ4EAdYERbcgPcq+8+p2uQDyfaR2X4wGhrvhRkypMQYEAv
         yrqhOrSceRQTGdxAkilC5ybDMVoCti1fw0sQ9TInyogWHtTMMHQdy4MSN7mJruBJLjBx
         z1rNa2nqu+nwXd/uLARTIvX9B8GaYWCeChfW56oiiw3EMnDEYxz0RxBACmPAAVjHnGQN
         TJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456561; x=1740061361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZmWSiUWpnRK0ksjdmL98E8SgC5cSifduv2jJAfiEPY=;
        b=D7gyJhArTtDgSg33wSzuXR+XAxKdL/ejsttTIJ6/9h9f3r3ra4bSuXNKyHaHmSP5xu
         6/CvLULbiZGby2Bw/65d0lRQGLf93IAWkmjrIHxasrIv79Xumcta3EvOz5qcodZWpuML
         41MDVCs29m+8C3FVKbnQ+2HYU/IZfqUoTbwnXPIDRShwcysVRDaH6Ww7HQdw17LpQD4N
         eVvdq0Qjr3A/Vge1xTplSZGiG5M3CdA8/vo3SfuxKSsKXJWbtMk8n1/E+d47yzHfKuwI
         fPgroUd2ZJBf6uN980D2pgOoM1ANxr5H/0+T9n1Ky66GTXsZGkmuBLyOVSuLPbTaBWB3
         n+sw==
X-Forwarded-Encrypted: i=1; AJvYcCVlPHAil7KEznDtKCEntwMLhtcGlG4c55S9nX/wKSGB2YpLrg8Pas+xnD0JJnRTfVYV2fFkS3fjrn474hKg@vger.kernel.org, AJvYcCXKEL0hDlqDFUQMWOteU194aRT1AVnU56a5jB6HBrYpPnvI8Crso1+jZrGaguMNbJXt0DEKURVVk763kHpQ/40=@vger.kernel.org, AJvYcCXdW5vLrPeU8G/AIq35MJskk0evhC55qmmO/iOmGTksBbImCbQOKh7KdS9g+9pkWT+hw9lKypa7@vger.kernel.org
X-Gm-Message-State: AOJu0YzZx6/33/gJ/vEMb6cM0qsYb/R7E93jOEInXxaFecnSUIaeDi1K
	hOjeMFXGHQFA8aAJrsnNLMvmO5R8Huw878Hz2wQTK0xh6DPXdWQ/gbkRoPR+PZhyt7rQLPQZcN5
	oyoqqewpA4f8UluXaUOxWD4ztq3E=
X-Gm-Gg: ASbGncuu2LpY3ihRTHGpm7IZkXq2c/9XI9ylwFul2eTmQBxnjgps1UZHfFyUPsEXIzu
	FURhALoV4l55ZdKRgNdBv7XpXZEPHuf0eeEdvaB8umKeXP2yft4/pLOcwYD7lNVeDlfZvyMA=
X-Google-Smtp-Source: AGHT+IE1Ui4s9arYtwU9tac297UTOfK+baxbi60/IuRWMEIkYSnWEjH6X0OJlTlu0WS7f8Bynj5q63KuRkpdg8b3Lsw=
X-Received: by 2002:a05:651c:1507:b0:307:5879:e7d8 with SMTP id
 38308e7fff4ca-309036d7adcmr28642701fa.30.1739456560967; Thu, 13 Feb 2025
 06:22:40 -0800 (PST)
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
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 13 Feb 2025 09:22:28 -0500
X-Gm-Features: AWEUYZnlhlrfRU7G4FrgTrcb9H-dsDkPENLIZdLh14jFn2kgy6dsYsfxDnsDfjg
Message-ID: <CABBYNZL4tEBTT3Hrf3JUGNuseLg1SNLmazo88EitmMfhUWUQxw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] Bluetooth: Fix possible race with userspace of
 sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Hsin-chen Chuang <chharry@google.com>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, Feb 13, 2025 at 8:45=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
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

Well we could just introduce it to USB device, since alternate setting
is a concept that is coming from there, but apparently the likes of
/sys/bus/usb/devices/usbX/bAlternateSetting is read-only, some
Bluetooth profiles (HFP) requires switching the alternate setting and
because Google is switching to handle this via userspace thus why
there was this request to add a new sysfs to control it.

--=20
Luiz Augusto von Dentz

