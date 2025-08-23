Return-Path: <netdev+bounces-216223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6683BB32A34
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 18:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA32A1C2452E
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDFA2EBDFD;
	Sat, 23 Aug 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXzPEmz3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627F2EBDD7;
	Sat, 23 Aug 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964840; cv=none; b=s1MOez6qc+zCyjot6Hyv4hK0aOqu1DMq6/ryxGP8t/Q3lvbpNnIG6XFE+lnjmWEDzLw+5CbAnmMTavzM5QkyefdEdjJbAB0bSbC4eLwfF9hP3FcQ0ku5pD3/0iL+BVudeyl6u3lsuDG9B2duCzi8pdNAGhrwKyqUvzFPKGIwe90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964840; c=relaxed/simple;
	bh=iO8Ut6aq0eYMHUnd4gxlenxyD0LxRDw24+ofb0GRSAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQ32psTxPdjZsXw0sCxh9wimI3Nbc4pgtEqCMYhIJcXlVQfpUDo/hbXh5kBDpY4iskGr3c+CX+iBqmkEuS3c80i6qRYMdjVcWvi/Oo9NOowd0p5/U8cHjaMX78pfILPO26o09u8U55maj+BWseuGRVcpVTtyXJw3IVDQHB40Qn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXzPEmz3; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e953b4c88e5so8070276.3;
        Sat, 23 Aug 2025 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755964837; x=1756569637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iO8Ut6aq0eYMHUnd4gxlenxyD0LxRDw24+ofb0GRSAk=;
        b=PXzPEmz3jv0KrzbgaFbB8VKAyM45Jgcp++yQW9eb570yT80h2gx8+tUG7CEK8AxfRM
         3j6dkCENy4TitbabI2cNzWgmZPsesu6ac5lJH81DVIDPYKUt9KgjK0y8htjqTxyr1+3o
         azm7tNB0vMu+cqJoeqLsMT/izCO4C1leGBnBzLQzPRdTq03oHL1hL6rZkVNB2Ump/hjn
         a0OFYTJK7vJgVrWr3tlICkTnzQvmU6CyT2o1NYm4LQblsLokxEyhRF5t6tDa+zWSOYjE
         HSK+zEwVdSAYXkE6eY9CeEFGEfHw/bRP2ywPOVCYqycaQ6wqpFAqQUve0OAEND0M8Gnk
         ktsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964837; x=1756569637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iO8Ut6aq0eYMHUnd4gxlenxyD0LxRDw24+ofb0GRSAk=;
        b=IveZQX7DDLwqmRPA5cKmcuN5VUlRfgN6X/xGOXjpHSvr9UdX+drTKdulE0Q0wnjdeN
         68+eDwzQPB795Y8KPhC9qr6VwQx8nkWqqi0CM/27e3YCdaDT7kAW0gm/g2f7uGBlxPa7
         4UZhYY+XRNgCTA/h7qFclm47YnpEhWMDKdApDRhqB5NxhiT4n7G8au/THSyEoWCGjOmv
         VdHexREK4KVn1gdaLwl9USBqxWLsBhS+IrtijZ25M8EFA9KVQYNI6MsBvWVBDrqphMe4
         rLNbHXu/zC0pRY7dMWNWzk8jrthKYv08EWYmq1+QHE7RhHi8smvajNNsfMQrkeA1r8nd
         Bmkg==
X-Forwarded-Encrypted: i=1; AJvYcCWyg5HZCnkAurQ+yrJSx+pmhpyV5t1cbzCXkXlqAtQUwf/yy5/wZCiJCdPfpJww3B+qD8FZSWSO@vger.kernel.org, AJvYcCXUzNMZH3Ne47aHgaSvEIJ2oqa+urUPXuVrYPRxpxVqL4pLU2IMgYd+3RCfEhhLvm/p8//Zf5g0qmNtiPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfeHkIDZmmZpowQf+vjP8CUaT33V15EYO3L6S6c6LOvvNqC8Ur
	6OOuvy7uOR9NJcov4vJ9/aQmAODb7fEHGkfsbuMbbToRfck8Rd9MWmaxEIZmBbXPzLnBMIaduwP
	yM11+Mut4Hh/1vjz9Lyg+AWD9wrrVQJs=
X-Gm-Gg: ASbGncuRGPJVg8jCUtGeE0Kbg+ktM6ukK5fagTbjlnekTKbgE6oBOSpoFvtdBB9R35p
	KZWgoC4Svbw9VhbK+OMaoqIhMYPKU7hsVMNXID7DekCzqECIJcmOh7hb6fnEdDfHenLFBKKOoq5
	KXKz/rs+yWPbYcHhPQT5wvpOsdR1TZTvL6fKzmkvh/yckL0eNkaf7dZwLJLpJs/YHjWKT+XFwhe
	kFxEA==
X-Google-Smtp-Source: AGHT+IES5ihDGjqAR0RRt3hF8QgCHXA+ZIjUzFa+DEVMA0B4xc/+RMPiK2gyU3CMD3MqULp5IJtN7L+EbjIGKUsJDXo=
X-Received: by 2002:a05:690c:968f:b0:71e:719c:491c with SMTP id
 00721157ae682-71fdc2e6c75mr73920927b3.18.1755964836651; Sat, 23 Aug 2025
 09:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823090617.15329-1-jonas.gorski@gmail.com>
 <4469d2cd-5927-4344-acb0-bc7d35925bb1@lunn.ch> <CAOiHx=nC5f9-2-XPCKBVuVsh93NSrmbSQJp8RqF3EObbEq+OOw@mail.gmail.com>
 <a0e637f9-e612-4651-8b12-8cb82dd23c55@lunn.ch>
In-Reply-To: <a0e637f9-e612-4651-8b12-8cb82dd23c55@lunn.ch>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 23 Aug 2025 18:00:25 +0200
X-Gm-Features: Ac12FXy130jNTN6ZhiMK4cPK4U_24XPWcgZUHx7vEHaACavZpynUZkQEhvW7kSM
Message-ID: <CAOiHx=mnXYmSsYzHQYDAnBg6vKzo0oj07hbiCJBVBegDbv4NAQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: fix ageing time for BCM53101
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 5:31=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Aug 23, 2025 at 05:27:02PM +0200, Jonas Gorski wrote:
> > Hi,
> >
> > On Sat, Aug 23, 2025 at 5:00=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > On Sat, Aug 23, 2025 at 11:06:16AM +0200, Jonas Gorski wrote:
> > > > For some reason Broadcom decided that BCM53101 uses 0.5s increments=
 for
> > > > the ageing time register, but kept the field width the same [1]. Du=
e to
> > > > this, the actual ageing time was always half of what was configured=
.
> > > >
> > > > Fix this by adapting the limits and value calculation for BCM53101.
> > > >
> > > > [1] https://github.com/Broadcom-Network-Switching-Software/OpenMDK/=
blob/master/cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h#L28966
> > >
> > > Is line 28966 correct? In order to find a reference to age, i needed
> > > to search further in the file.
> >
> > Hm, indeed, it's #30768. Not sure where that original line came from,
> > maybe I miss-clicked before copying the link in the address bar.
>
> Or a new version has been dumped there, changing all the line numbers?
> I've not looked, is there a tag you can use instead of master?

Uh, indeed the repository was updated. I didn't expect that, since its
was unchanged since its creation in 2020 with a single commit, so I
assumed Broadcom abandoned it like they did with a lot of other
repositories, and treated it as a static code dump.

Though they force pushed a new master. Well, "new". master is now
v2.10.9, and was previously v2.11.0. Don't ask me. But at least they
also added tags for the two versions.

So https://github.com/Broadcom/OpenMDK/blob/v2.11.0/cdk/PKG/chip/bcm53101/b=
cm53101_a0_defs.h#L28966
is what the link should now be (they also moved the repository).

That's not the first time I saw Broadcom force pushing to a public
(SDK) repository, so that link might also break eventually anyway.

Best regards,
Jonas

