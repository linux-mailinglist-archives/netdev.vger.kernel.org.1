Return-Path: <netdev+bounces-193951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50674AC68B0
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F8A4E2EE9
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 11:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028F3284674;
	Wed, 28 May 2025 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADsZGmb5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F84283FCD;
	Wed, 28 May 2025 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748433472; cv=none; b=ZU89BykBW5YpSGqAJN4TV0GOeaCQRDfmkWdHUTmYIXXhOaNVJf36ZMckKq3bY5h5Va/8iXKn+1KsmO3Q5RxinH9QR8mOtuV+BPGpyCsireMEmftLbXScn6h01TJiBnxiO+NE6hbfzYPRZZ3wDByDfpAIbqujF1NipIt/sDGPYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748433472; c=relaxed/simple;
	bh=DM2QbUzIiVq1oAO1zYgkeLSN01UQu1uYF+2linnaY0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZH8p2wpy3yTJsXCfu3wmVsMK1mmxMAA+CzwJj1cL1jEt8dKuSkJ9UjzgSV+xm9/kJHs+Z/ZOqtOGNqYfwxQqvIwBQ0xu3z/8VY53wgyJ8he+v/4WlMsl+8iE1xopMqyDL4a4FPO+NkAZpu6FTRXrQMZvX7EKnRyatjh6cwKNMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADsZGmb5; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e282b9a2b9so584422137.1;
        Wed, 28 May 2025 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748433470; x=1749038270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DM2QbUzIiVq1oAO1zYgkeLSN01UQu1uYF+2linnaY0w=;
        b=ADsZGmb5TfzP2K3Bs3iGTuT4VigoVV3nofBzLaDtMpbKDek8OJwpMJGIZYnOdobAC8
         nLSe9h9dQ9nNqgOiq4p1oTmLBc/B3n+Rm1is14K+GfBsk86CoXywv99UB4sGzpUO4ZDp
         ntM4vgCYsjBK+/+uzh5f4n1HBNey95evKd3U3ehSqUeyY5bPZ/9jEE4rK6KmaBg+l/RZ
         8kkXuv5H5BYfqWzaR5upM9z8qMK1sPN8hDSjOGbtlwQe6IS/vNqm+TyK8G/x+pILj5iq
         wkh/jehU5VdwZkcR+dklAf6YyVWCy8eVOh4cM8nXmV4TYVIwUKedcbfbhUPMzFt+NJ6P
         TD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748433470; x=1749038270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DM2QbUzIiVq1oAO1zYgkeLSN01UQu1uYF+2linnaY0w=;
        b=HaBf3Ys3vCtNFGDeSrMwmxHfpvABXAwzcye6D/QzGj7J7cu6D5+33Avvy3ZxeMX5dU
         KlEQtX6ZEs0vRlQIFGryf2jG/U5VtgxPnNMvR7Z4DOlNIiF/UxlEkb9Fg324estvHAnI
         MvDxSqAFFph3E6B3VV+2UnCKVhuvczJeUBABQmkYOWsWscArOc3FAlfWT0YH+s4Kf0Mi
         /oK0v7B86u9bA5MLDkO/4ojEy3ar0ue3VHyTn1NhP4Nnh3+kOCWB5/e1q9w3r+seSvRh
         9gBw/E5o2FTfqrN8NMDl0iKQC9Gne8qttlbTTmj5QspOeSHc5G0WHJQjTjc6LF8cAjxR
         dbvw==
X-Forwarded-Encrypted: i=1; AJvYcCVPDpy0XMCoiVgnxFAm4MbfxGc3HZwNflAjSFWidfIWN2bbRMsno+OUYnLH1reD3583bM8P4tB1@vger.kernel.org, AJvYcCWiqVYu7ovhxBek3XBGRaOxSIeR3v62Rk1XJanitP73Td3t08CT9y8C+nIXKcspypeiLH8oWzqcnYeACRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzs2X8k/EJcXVC5QY2geXltZd9LesxC3ae/yFrmM8Kl5tzXjC5
	EillFyErOjO3v4GuWBJFofUIO4H+w9f+Cni2AXsdJiBcug+F0xzfRzjQdX+JOo7xWvseAnseS1K
	oxKwkQ9fLjpkvGhv4SAYB/9G/hQdNjrw=
X-Gm-Gg: ASbGnctTNyppSSurucXKjcVwJ0JfgeNduVhz1thdRVI6wkcXuUWDA8XxRtLrGZUtLmh
	2VlUMimZJcqcwz+F+aRE6hPkDI6JDC8AEU/1K+eS92IEOdmz0o/4hYYEDZsDueuEzUB2eQ5YiY7
	BLj1yv8puLq8uV5NJEOJohoUingkWcvXsU5A==
X-Google-Smtp-Source: AGHT+IHccZ6u3wYBlr61chnbgjUWRM+9FVRKkSPAvmULH6YUlgEgMZxUk6AOBWwMA6JVLhM/7o4896YpQLK4HFLW4VU=
X-Received: by 2002:a67:e70d:0:b0:4e4:1d6d:56cc with SMTP id
 ada2fe7eead31-4e597dee6afmr4608606137.12.1748433470075; Wed, 28 May 2025
 04:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
 <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch> <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch> <CADvTj4qRmjUQJnhamkWNpHGNAtvFyOJnbaQ5RZ6NYYqSNhxshA@mail.gmail.com>
 <014d8d63-bfb1-4911-9ea6-6f4cdabc46e5@lunn.ch> <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
 <aDbA5l5iXNntTN6n@shell.armlinux.org.uk>
In-Reply-To: <aDbA5l5iXNntTN6n@shell.armlinux.org.uk>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 28 May 2025 05:57:38 -0600
X-Gm-Features: AX0GCFvRg1G8o6RHpRasEA3gbglv1Max4m9hoMAbkTOqRd30AqyfzVMQn3V1-wU
Message-ID: <CADvTj4qP_enKCG-xpNG44ddMOJj42c+yiuMjV_N9LPJPMJqyOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Furong Xu <0x1207@gmail.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 1:53=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, May 27, 2025 at 02:37:03PM -0600, James Hilliard wrote:
> > On Tue, May 27, 2025 at 2:30=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > Sure, that may make sense to do as well, but I still don't see
> > > > how that impacts the need to runtime select the PHY which
> > > > is configured for the correct MFD.
> > >
> > > If you know what variant you have, you only include the one PHY you
> > > actually have, and phy-handle points to it, just as normal. No runtim=
e
> > > selection.
> >
> > Oh, so here's the issue, we have both PHY variants, older hardware
> > generally has AC200 PHY's while newer ships AC300 PHY's, but
> > when I surveyed our deployed hardware using these boards many
> > systems of similar age would randomly mix AC200 and AC300 PHY's.
> >
> > It appears there was a fairly long transition period where both variant=
s
> > were being shipped.
>
> Given that DT is supposed to describe the hardware that is being run on,
> it should _describe_ _the_ _hardware_ that the kernel is being run on.
>
> That means not enumerating all possibilities in DT and then having magic
> in the kernel to select the right variant. That means having a correct
> description in DT for the kernel to use.

The approach I'm using is IMO quite similar to say other hardware
variant runtime detection DT features like this:
https://github.com/torvalds/linux/commit/157ce8f381efe264933e9366db828d845b=
ade3a1

There's already a good bit of mdio autodetection code like
that which scans mdio buses for PHY ID's in stmmac. To me
this is just allowing for device specific autodetection logic, it's
not like we don't already have a good bit of generic PHY auto
detection code in the kernel already.

> I don't think that abusing "phys" is a good idea.
>
> It's quite normal for the boot loader to fix up the device tree
> according to the hardware - for example, adding the actual memory
> location and sizes that are present, adding reserved memory regions,
> etc. I don't see why you couldn't detect the differences and have
> the boot loader patch the device tree appropriately.

I mean, sure, that's technically possible, it just seems like it's
not the best fit option here since there seems to be no real
reason this sort of autodetection can't be handled in the
kernel itself.

