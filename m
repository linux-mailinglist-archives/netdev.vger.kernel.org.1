Return-Path: <netdev+bounces-166111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0282BA348A3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7BB188616C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36A919C54A;
	Thu, 13 Feb 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGQR2TWq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCEA15665C;
	Thu, 13 Feb 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462222; cv=none; b=DPgGxQ2MNpMnUcmQ7CRiGW7eiyASbdylY4NzdwaYUFRH34fY8HHxKj8CFPFRriS+i+N4hzC9Li22Uy6WvN4ncYfwlVZ14Oe2QIQfW92b0oQo62rWDXnT/VBc2BX+PDYzGP+PV3W1iT/1OpM0kF9E8/pjrqN/G03hnL9C1jech98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462222; c=relaxed/simple;
	bh=CPsLn0bAxRskox7Zk4+Jnqf4gQ19tw4HDvMfHr6jss4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWIY9WNB07YzmxCosUZ+PyrNWrWVVYF1m48PKKMp5p2YCPT3RyMkLU0FRCQt449eW3GIoCzHS1tS7LNfvQsE79dX/7jUxx2JvH9gro5+j2I1qPl5z9cYHovOWVEbtUTiRZFpiWK1JDRh85pWoSV8k/zVKFdywpi1deTnvSJRXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGQR2TWq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-308dfea77e4so11757221fa.1;
        Thu, 13 Feb 2025 07:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739462219; x=1740067019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wohe1kiU/4SHBHGO2JoWHLQq2uQTYRBlzz7SDmQrnVw=;
        b=XGQR2TWqbdYczDGDoSKijSZwv9Bbhi40kAfHu4of+/CPJrA9LJkUqGBtGe/5cov4im
         BAw31sglwstuOniCfs7f1DLnbSGcnAg9a95WaPLdNbUKEE7UIv3koDoAA2h9vsp3kwG9
         i30OuJWsPfrriGtA/yuufEDI67C/Df9NvXhkdTvisY2nOAAuAkGBiM30t9jcaeJlWIAr
         K3CKec66Uf3K1AgJ3MAuebJfzcgAkQlogGkhtV8HmOkGqKxjZ0SKV3R5Xm9cOiN28dg3
         LD7tAOyGgiUCP1fO82OkHNF+nh6mEyDPTABtuXCmeFWf+4EihqZ72+gQjRz3JoNUaDeu
         Ilhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462219; x=1740067019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wohe1kiU/4SHBHGO2JoWHLQq2uQTYRBlzz7SDmQrnVw=;
        b=oJ2XQlYBkkk8xUpBFL/4XWuD3Zcwkgvz6JLiR68tfWcBETfn4jbmkS+JAc0V/0XUlX
         4idP8ZDYZVWEgqXh1Z44duQe8REQZwa184Rp6ivB+mwYGdwfKRGaGuTF/wSM7Ljpge9G
         LdMVzm3SRec2ekp6uf7nrwEOytO+2KuflLY7eIXZOhFJKO99qlccoTsCifquncDJxx2w
         XKbvmddQHNkh/CKJkGne+zRuLKnGyGqt7fnXFLEQQQagTVF1d3rqCG+jWJGT6szqhy0P
         tAY+0+qbiaA1YYE0oLH6e7OmYqZd+QSprutbMbtrd/4GO8BTLcAy0V78rcDio4EflGFe
         azUg==
X-Forwarded-Encrypted: i=1; AJvYcCUb6Pa1BAxe2GehGqa4rvVot+ZsKhMfxwfH31WZ6zPgMcs0gLNoFnB3nbGrfZhdlsxtkQxErcgj@vger.kernel.org, AJvYcCUtROBk3VrhKdKbk9RC5uvj1ixvuEzv1HswXDrVCBbL5w2Lm1SQUna2+8glZt+bsEy1YrhfcgccZl9TIneh@vger.kernel.org, AJvYcCV5HQ7NXFVXzdhQbhKRgpv6t6CPGAwU/0iHgwyYicdqLPGxgcr0FcWObO2mYBpGmfdcTOgS8ulgenKMnqg46LU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0sq45ILapWFCOiZ8OfNx0NJQSj0NFMO90ApyfWNhYbsqABsYN
	FhOknwosek6vj7zWSri8THdJNY5rp4IDU+cpQa+61irm2rjJhjIXE7Wuj8Rhvg/Azgz/S25cYdb
	93EjMfRjJUeo3B5EhzhZEoLtmxiI=
X-Gm-Gg: ASbGnct2kXhrkjAqeeNb6ikYgxhbX5iu0KnxACWvOi0P+EWSPZub+LQlSu0KNQrlzNW
	k3JK2Njl8rhNlck15z3ZDrLHV5fRzUpRAywDVSUe/bnG/+2hTf/fFLwJVYtkMRnp1rf23WRgX/w
	==
X-Google-Smtp-Source: AGHT+IGmC8N331fe5jVaEv6w7pRFwAgiWayB9yjYnjFrL9DBCBLv7feOVZmYQ6B8zOtNxJpOBxgF6liVGjfSnVir1Ss=
X-Received: by 2002:a05:651c:210e:b0:308:f52c:7698 with SMTP id
 38308e7fff4ca-3090f24961dmr15957711fa.13.1739462218458; Thu, 13 Feb 2025
 07:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021352-dairy-whomever-f8bd@gregkh> <CADg1FFdez0OdNDPRFPFxNHL_JcKmHE6KNxnYvt4sK7i+Uw6opA@mail.gmail.com>
 <2025021347-washboard-slashed-5d08@gregkh> <CADg1FFdbKx3z+SPWFmY4+xZmewh0MnnZp_gmYEdY0z-mxutmEw@mail.gmail.com>
 <2025021318-regretful-factsheet-79a1@gregkh> <CABBYNZL4tEBTT3Hrf3JUGNuseLg1SNLmazo88EitmMfhUWUQxw@mail.gmail.com>
 <2025021347-exalted-calculate-b313@gregkh>
In-Reply-To: <2025021347-exalted-calculate-b313@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 13 Feb 2025 10:56:46 -0500
X-Gm-Features: AWEUYZlH41IYZTDQ5gWQZLNhQxsq-PhbEYweyOqHDZOfOQdgQJZzI1fD332TiCo
Message-ID: <CABBYNZJSwQJ-KWacoXDGVJ5gni260FTi=XEpNw3ER2CJhpVrKg@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 10:39=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Feb 13, 2025 at 09:22:28AM -0500, Luiz Augusto von Dentz wrote:
> > Hi Greg,
> >
> > On Thu, Feb 13, 2025 at 8:45=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Thu, Feb 13, 2025 at 09:33:34PM +0800, Hsin-chen Chuang wrote:
> > > > On Thu, Feb 13, 2025 at 8:10=E2=80=AFPM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > A: http://en.wikipedia.org/wiki/Top_post
> > > > > Q: Were do I find info about this thing called top-posting?
> > > > > A: Because it messes up the order in which people normally read t=
ext.
> > > > > Q: Why is top-posting such a bad thing?
> > > > > A: Top-posting.
> > > > > Q: What is the most annoying thing in e-mail?
> > > > >
> > > > > A: No.
> > > > > Q: Should I include quotations after my reply?
> > > > >
> > > > > http://daringfireball.net/2007/07/on_top
> > > > >
> > > > > On Thu, Feb 13, 2025 at 07:57:15PM +0800, Hsin-chen Chuang wrote:
> > > > > > The btusb driver data is allocated by devm_kzalloc and is
> > > > > > automatically freed on driver detach, so I guess we don't have
> > > > > > anything to do here.
> > > > >
> > > > > What?  A struct device should NEVER be allocated with devm_kzallo=
c.
> > > > > That's just not going to work at all.
> > > >
> > > > Noted. Perhaps that needs to be refactored together.
> > > >
> > > > >
> > > > > > Or perhaps we should move btusb_disconnect's content here? Luiz=
, what
> > > > > > do you think?
> > > > >
> > > > > I think something is really wrong here.  Why are you adding a new=
 struct
> > > > > device to the system?  What requires that?  What is this new devi=
ce
> > > > > going to be used for?
> > > >
> > > > The new device is only for exposing a new sysfs attribute.
> > >
> > > That feels crazy.
> > >
> > > > So originally we had a device called hci_dev, indicating the
> > > > implementation of the Bluetooth HCI layer. hci_dev is directly the
> > > > child of the usb_interface (the Bluetooth chip connected through US=
B).
> > > > Now I would like to add an attribute for something that's not defin=
ed
> > > > in the HCI layer, but lower layer only in Bluetooth USB.
> > > > Thus we want to rephrase the structure: usb_interface -> btusb (new
> > > > device) -> hci_dev, and then we could place the new attribute in th=
e
> > > > new device.
> > > >
> > > > Basically I kept the memory management in btusb unchanged in this
> > > > patch, as the new device is only used for a new attribute.
> > > > Would you suggest we revise the memory management since we added a
> > > > device in this module?
> > >
> > > If you add a new device in the tree, it HAS to work properly with the
> > > driver core (i.e. life cycles are unique, you can't have empty releas=
e
> > > functions, etc.)  Put it on the proper bus it belongs to, bind the
> > > needed drivers to it, and have it work that way, don't make a "fake"
> > > device for no good reason.
> >
> > Well we could just introduce it to USB device, since alternate setting
> > is a concept that is coming from there, but apparently the likes of
> > /sys/bus/usb/devices/usbX/bAlternateSetting is read-only, some
> > Bluetooth profiles (HFP) requires switching the alternate setting and
> > because Google is switching to handle this via userspace thus why
> > there was this request to add a new sysfs to control it.
>
> That's fine, just don't add devices where there shouldn't be devices, or
> if you do, make them actually work properly (i.e. do NOT have empty
> release callbacks...)
>
> If you want to switch alternate settings in a USB device, do it the
> normal way from userspace that has been there for decades!  Don't make
> up some other random sysfs file for this please, that would be crazy,
> and wrong.
>
> So what's wrong with the current api we have today that doesn't work for
> bluetooth devices?

Perhaps it is just lack of knowledge then, how userspace can request
to switch alternate settings? If I recall correctly Hsin-chen tried
with libusb, or something like that, but it didn't work for some
reason.

@Hsin-chen Chuang I hope you can fill in the details since for the
most part this is not a BlueZ feature. I'm just explaining what you
guys are after but ultimately it is up to Google to drive this.

--=20
Luiz Augusto von Dentz

