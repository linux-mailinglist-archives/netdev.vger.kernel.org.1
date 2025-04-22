Return-Path: <netdev+bounces-184733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA98A97109
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AD7171D4F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043402900A2;
	Tue, 22 Apr 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5gc9M+o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69C28EA70
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335852; cv=none; b=X28p7unLCtFYVpVut5OzED8X6RTx9GbX7xjuG+n1sW00VSUTIRhlXowofM4jl8jruPWlUbRasTGf8Np/KVSEmyTcLcQp/kQ6l3x3TZTurJ3sPrG6BIPn1kPY/ow4KEvv07I3lOu5rwLT9oTDTXOP3S2aF+AhpZoUo9PqCuQayGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335852; c=relaxed/simple;
	bh=+OvsY1d3PdvOVmMiFmZddCCPR7P4L6JvxjgeVDNmD6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cvz42IxCtZ91e2WgtVzNsV+jiJuIWAP717PoO+HnScha9n3n7NlyBkfA0rw2Xe7zH7eNqf70tF9St6yIJwCyZXLjWzScA+HHzZJQjx9db2x9kEuQ16RXPRSvtcJW1p96GFkY2TfhM811ts9sR1DB1iVTSueP3G94BefSGO5GcBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5gc9M+o; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso3303911f8f.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745335847; x=1745940647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ez6aomwW6id2TUHs9dDfREfGhTdjxaPrlaI1YNUUCeg=;
        b=H5gc9M+oCGR//vtJNAKlbWZQfBOYV2j80tEzHg1iDFy+UnyeofVcri5FszaDmR+ka5
         PopQiJ3lY5m4qqnCPJTijtlX77K9rKIXo6ai24N1XV19e1R1phtTAzkd5PD6KZSqABZJ
         54rb+2VhZUR12EZ379XZh19MnIOrTQi0pJJNd/ywmAeuZhlxagi2zsL2Bn8RsBYrXsiP
         wXnxAtVUlduTjaKXoOl35GJYyieed/+fbQxcIYQ2JNE6/pMSbSOoZ6Oyq5uHkjxN4qL+
         n7W0hg2mAPK7atDgXwMJ0j3kQwWkoMRyXXEMfa35Vb6b0sltzeCRQddP60OaH+/JFz8n
         U9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745335847; x=1745940647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ez6aomwW6id2TUHs9dDfREfGhTdjxaPrlaI1YNUUCeg=;
        b=u0IIP3r0vz1I0KxH9m3Oxmg+47MOcjCI8lpAPMGUsDMnFbg/VDFlZU4lWNjU5MwNd9
         GmmJFiccsHXwUGsc/zbMelCXa3MySmoaaT99pnILc7NsXYW1b8r0U5ePe1UYoJb2QdLl
         NHZj9q98Tc9oCjVNOnTEMSOOQK/qR77VWqP9shthlBDXEUL6dfGaUQDTaYWw+jjOxpLK
         2zf4ewYMd+f87xLZZjF1undGeXstd98BBh+V53BwqlAk6+vsiL9Bby/nQGak97yrTJSS
         JSHp7XzlfLF1q06Ws28E+v4ox6wN/btCCVUZpyM+kAgNowIF3a7PH4L59NOg6+P1/F1Q
         ACxw==
X-Forwarded-Encrypted: i=1; AJvYcCWHTeViDzMzELP+fSUhkdEU1f2Cgb663wjF1QUUmH1H0DcL9EaFqgbAU19CeAha1SyUJc5a45s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmgF8LTQTuk3busTu0od0VlktgYFqYJgBKVmKCFZUP6oJM8KuF
	AljP6NNlQJvnaQPQgp1Q66Ew16UCzu5jRT5t8VKWWJxqJtOCt0xKA7u9OldK96uCRAzoOftjadU
	5WfTZFEsiSGxVZkoHyaAeFlHBKuM=
X-Gm-Gg: ASbGncuCrGYU4JkJZuE9SOXd1EOk1hmh3kyX9hdNhN81BpTD00crvjDmrYiHSjpgdx5
	ivxH3xw1ph2pzWC3a4yx8xHN0wzx9oHrmIfC6AvNB33kmvSrqK2syTjnwqUlqda9UYQqNEtULdx
	RVK0NVs+KtawSsAAFK6ExKI10/4lO7q5qJBbK6bFpcKwPNylyNQYVzfow=
X-Google-Smtp-Source: AGHT+IFkpImNQ+ENf+lHWAdfVlmue8xFw0t6+WPIUUGDmSJ9l9WexB4Itn9UbxJwX4y4nvUBlKGxc+BeKh42hr2kxiY=
X-Received: by 2002:a5d:47cb:0:b0:391:4674:b136 with SMTP id
 ffacd0b85a97d-39efba5c519mr11463025f8f.29.1745335847205; Tue, 22 Apr 2025
 08:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z__URcfITnra19xy@shell.armlinux.org.uk> <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
 <9910f0885c4ee48878569d3e286072228088137a.camel@gmail.com>
 <aAERy1qnTyTGT-_w@shell.armlinux.org.uk> <aAEc3HZbSZTiWB8s@shell.armlinux.org.uk>
 <CAKgT0Uf2a48D7O_OSFV8W7j3DJjn_patFbjRbvktazt9UTKoLQ@mail.gmail.com>
 <aAE59VOdtyOwv0Rv@shell.armlinux.org.uk> <CAKgT0Uc_O_5wMQOG66PS2Dc2Bn3WZ_vtw2tZV8He=EU9m5LsjQ@mail.gmail.com>
 <aAdmhIcBDDIskr3J@shell.armlinux.org.uk>
In-Reply-To: <aAdmhIcBDDIskr3J@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 22 Apr 2025 08:30:10 -0700
X-Gm-Features: ATxdqUF-NT3dyTTkFhIUSjGwQz1aQY7z9mZg047eWD1fEDR-YoOaHeMmauGWbA0
Message-ID: <CAKgT0Uei=6GABwke2vv0D-dY=03uSnkVN4KnKuDR_DNfem2tWg@mail.gmail.com>
Subject: Re: [PATCH net] net: phylink: fix suspend/resume with WoL enabled and
 link down
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 2:51=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Apr 17, 2025 at 12:49:07PM -0700, Alexander Duyck wrote:

...

> > Sorry, mentioning it didn't occur to me as I have been dealing with
> > the "rolling start" since the beginning. In mac_prepare I deal with
> > this. Specifically the code in mac_prepare will check to see if the
> > link state is currently up with the desired configuration already or
> > not. If it is, it sets a flag that will keep us from doing any changes
> > that would be destructive to the link. If the link is down it
> > basically clears the way for a full reinitialization.
>
> I would much rather avoid any of the "setup" calls (that means
> mac_prepare(), mac_config(), mac_finish(), pcs_config() etc) and
> mac_link_up() if we're going to add support for "rolling start" to
> phylink.

It would be fine by me, at least in the case where the link is already
up and in the correct mode. For the other cases we would still want to
do this in case there is some incomplete setup or something like that.
We would essentially just pull the block out of mac_prepare and place
it wherever is needed to get things up and running.

> That basically means that the MAC needs to be fully configured to
> process packets before phylink_start() or phylink_resume() is called.
>
> This, however, makes me wonder why you'd even want to use phylink in
> this situation, as phylink will be doing virtually nothing for fbnic.

It wasn't that we had wanted to initially, it was more that we were
told that we must use it during the early driver review. I couldn't
really argue against it as our setup fits the model since we have a
MAC/PCS/FEC/PMA/PMD/AN and such. A good example is that I am pretty
certain we will end up using the XPCS driver eventually, however to do
so we must update it as it supports more than XLGMII which is why
somebody added those speeds without adding the correct interfaces.
There are 25G, 50G, and 100G modes that are likely supported if I am
not mistaken. Can't blame them though as that is essentially the state
we are in right now for fbnic. However I was holding off on enabling
the PCS until we can get the MAC pieces sorted out.

For us to fit we are going to have to expand things quite a bit as we
need to add support for higher speeds, QSFP, QSFP-DD, FEC, BMC, and
multi-host type behavior at a minimum. I had more-or-less assumed
there was a desire to push the interface support up to 100G or more
and that was one motivation for pushing us into phylink. By pushing us
in it was a way to get there with us as the lead test/development
vehicle since we are one of the first high speed NICs to actually
expose most of the hardware and not hide it behind firmware.

That said,  I have come to see some of the advantages for us as well.
Things like the QSFP support seems like it should be a light lift as I
just have to add support for basic SFF-8636, which isn't too
dissimilar to SFF-8472, and the rest seems to mostly fall in place
with the device picking up the interface mode from the QSFP module as
there isn't much needed for a DA cable.

