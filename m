Return-Path: <netdev+bounces-166036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81BCA3406F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC631667BA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A4227EA3;
	Thu, 13 Feb 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9zWcLC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0322154A
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453644; cv=none; b=P7eRxsq7WOBVSqBNFeNVHzhU4g39JwXmaa86SnpITcJuMqJGYnxQrcIv/a//N101Wk+0ZN55zsry8dBUx0MW0Eq8ZY7nD2+5wroBBJ5HJ8tT29+Pc2RREe/qOR4NUnT/uyl5nayuNngsIYz3tQLxYXLiSjSyt785FvTzNCH3R90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453644; c=relaxed/simple;
	bh=1Zo/b2fnH+KRJJ+uyJsBTTf+jevAOBBplgRMa6qKklE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+SawP5FfF+NP6ybKVYrfG6OQERY/dSrPrIytCOeUj7y6fLwogUKBPzfuq4SthfZcJ7xMPbuvZtpNl5CZxivKa4weMoC4XrAzx4KR8KQawd3222YzJoGTjW4a7OikV5V8gROt/9VH6rJ1zgY5xcr2w2Io83kC4H1aKnXwUV4w20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q9zWcLC5; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f9cc6fefa8so5969367b3.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 05:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739453642; x=1740058442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRxuVvwSNDjMnXgRSeSCG5b6A90Xszx88z8fNg1clK0=;
        b=Q9zWcLC5MOx55iLr+RiiOPTjRTERPPm4EWn/zqn2wlrkxZnS6VXwKq1pH2VLIwFJ1r
         w5VyxYwXWSHYbEEXMf8guc0ASjNIMgR8lBkJ8ceRF5jW0ZGL10eFRYOuPNqKidKrQZ1u
         RhtYaYOyCXpGvrlO4p+AHgPB8cDGvlg6DOJ6DJLlTIwKcsUVQpMTc6Fl3gH1l+4uzOUD
         npjEhZDmLQ7gNQ0jN6adx3moD3WpPZcODqwnxcuR1FhqjuEGNvf+Jqvxh9iltVHlVm6a
         z55KGMtEOhvunWUcq3enTH+KtfxpXbvVon0pbki5rOxjpwXD5gmOvdsge+mq50Ew2qHF
         i8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739453642; x=1740058442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRxuVvwSNDjMnXgRSeSCG5b6A90Xszx88z8fNg1clK0=;
        b=LfyJhE7AXndI6aNe9k21oLVA3DfnIKkZq1QxvZRnTWtUPNUWNltBXVTmQzKgv1BRVq
         ylGd9lbDYqtWmq5Yqqdm/HGPwQpIUOz/VPmve0V3dj7De7PG0/d4Gk1N3PUs2rTb+F3N
         YFeO+zF4lUtw443cyzNd24mcIOgNsRYO2UG8DRpfLwV67lRk1k46nHyABD2yRLjgc9BZ
         6R00Zj10N8z9OanNuoAzdTAY2Jnjy4mPKFsUpG+rSswTHgw8cTUFKMTFQiIGjIDo/WWN
         F3i5X0WZJHKYpbfRCnLlXzHE1i/9qaw+Iw+zIPeeXWPALfZDA2QP/JxZY3vrz4GHk2dz
         qCNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo3Qmjqs/u10YhTJJLAI8u43ADoPp6ivgRl1B9NRiPGp8Df1kx0GWkFYKGlqcEormEOaNdTSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvbIRHf+bujgd/7ZdxAH0cAEY+dhutXczWpByOZLAK+vGOjxo
	/sWQ3qM9dkSAU0szUsT9ZdaftSbQ4QC2BfKWk41tvoGbKOqTVEaFTvFx2ui7kZBP9M6A5+4qKAh
	3l+Yu5Q69sBPNDp/paBTpjfeADeyFD60ifHpSwUFet5F3uxGRly39CX0=
X-Gm-Gg: ASbGnculBcHnnWgAXZvlyK3EWRTc0k116D2YEOwrsxP+YD+/m2mwxeVDILfjQ7+NPuZ
	xR9ux9FGlSSt2UIWuWVWlzAz5+iEBhMYQDhW2GIHtNE5VK36Wt8sO79VJb4SITeKASRamQQ==
X-Google-Smtp-Source: AGHT+IF30ZkMMq8IrQ1Se84n4sKD0GvX5J7aA84qCQbXLCMSoSpfvD+rGWf1JdZYduPjA+px3O11cfkJuPs60tUkK7k=
X-Received: by 2002:a05:690c:9a05:b0:6f7:50b7:8fe0 with SMTP id
 00721157ae682-6fb1f171ef9mr76470707b3.1.1739453641740; Thu, 13 Feb 2025
 05:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021352-dairy-whomever-f8bd@gregkh> <CADg1FFdez0OdNDPRFPFxNHL_JcKmHE6KNxnYvt4sK7i+Uw6opA@mail.gmail.com>
 <2025021347-washboard-slashed-5d08@gregkh>
In-Reply-To: <2025021347-washboard-slashed-5d08@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 13 Feb 2025 21:33:34 +0800
X-Gm-Features: AWEUYZm_SnsYMtD42yF00_gIA0hMGPrnexms2cvVn9JmpgVsDbzt-5pObZIgJMo
Message-ID: <CADg1FFdbKx3z+SPWFmY4+xZmewh0MnnZp_gmYEdY0z-mxutmEw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] Bluetooth: Fix possible race with userspace of
 sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Thu, Feb 13, 2025 at 07:57:15PM +0800, Hsin-chen Chuang wrote:
> > The btusb driver data is allocated by devm_kzalloc and is
> > automatically freed on driver detach, so I guess we don't have
> > anything to do here.
>
> What?  A struct device should NEVER be allocated with devm_kzalloc.
> That's just not going to work at all.

Noted. Perhaps that needs to be refactored together.

>
> > Or perhaps we should move btusb_disconnect's content here? Luiz, what
> > do you think?
>
> I think something is really wrong here.  Why are you adding a new struct
> device to the system?  What requires that?  What is this new device
> going to be used for?

The new device is only for exposing a new sysfs attribute.

So originally we had a device called hci_dev, indicating the
implementation of the Bluetooth HCI layer. hci_dev is directly the
child of the usb_interface (the Bluetooth chip connected through USB).
Now I would like to add an attribute for something that's not defined
in the HCI layer, but lower layer only in Bluetooth USB.
Thus we want to rephrase the structure: usb_interface -> btusb (new
device) -> hci_dev, and then we could place the new attribute in the
new device.

Basically I kept the memory management in btusb unchanged in this
patch, as the new device is only used for a new attribute.
Would you suggest we revise the memory management since we added a
device in this module?

>
> confused,
>
>
> greg k-h

--=20
Best Regards,
Hsin-chen

