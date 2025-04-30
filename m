Return-Path: <netdev+bounces-186962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46362AA45CD
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8932C188D39A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F70219E8C;
	Wed, 30 Apr 2025 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmiWafS3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A02192E3;
	Wed, 30 Apr 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002635; cv=none; b=VP8QAp/EzBYqCTM67kOZtiZUZtPR0Z/nd+/evpN89f9+jg0d/mEuDg4LY8LMi10muYw8L3U8p03AWvxWE2uCeVphkPjBTu6PSm4/HiZADwYeEuq8mVm3TSjvruXq8k3v1B+wDkrNcrtLx4CMQxpf8vPPl6g2hNszr+6j85jMKa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002635; c=relaxed/simple;
	bh=uCbpG3QrjrqIEpeYmGwYvqptFCLTfdx524GgbmyrHrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWbBOURzvNn1J8wBnE7fapfUlykssKlr8nulk03waErAUMbxzG4GmuYYgj+n8Ou+P0+Z0CBsp9wdlMZntjQlE0ls2GGTX3hTV//P21Qbe83hbvyvN9tJUSi/KYl4whQVjZHRG28+64HAu50rWIkFoJBRuGmJ6mxTv4twcBcpd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmiWafS3; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e63a159525bso5874348276.2;
        Wed, 30 Apr 2025 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746002631; x=1746607431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCbpG3QrjrqIEpeYmGwYvqptFCLTfdx524GgbmyrHrc=;
        b=GmiWafS3V7c8bjXlbk4OxAgBNgMdMDRL4V0Vw+CPlm5DNTXxIcss9IxS8NzF0tjYnj
         9iqxKJh3IZfR9VFEZVfrw+jC6bIVJby0N506XXM/QiWSUTCKAM9OKM3bfLQM/VKdVH48
         NyTyUH3MNiczNSx6BoEU2aNnJgyhNmoADQIG2ITsmP+uOl/yPCznPExhvJnh1zOvKkQF
         gP6dfMQJBop2vdSldCvpKxIdQ99KCYSdgRqipz2Wiwru7PUIIXgfNE0y0NXhiJbSpbWM
         jFARAN0JdouirBgMlFe6nB090TgqQyYAqcuEjW6QKe1lnPP4hfhfXBj7qjM+Mxk/kwi4
         1eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746002631; x=1746607431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCbpG3QrjrqIEpeYmGwYvqptFCLTfdx524GgbmyrHrc=;
        b=i6WgjYscued8SlUcFxRfM0BpmqPOJCo1fNCVNUEOu/7jrhFZM96eDA+rR3G01/7xwI
         sK7yaj+WkWpVmL6SaV9qkLSZrW8P9L7CnEyLDaGYM7cFHw04JUL2f93Te5gLdvkqmc/J
         ySjuz6qK9nBIsdhRT6R6w1YJsR/OdHyieoIbi3U9G05HMk9yaKromfYax/FXi+Mv9JEE
         3DF2jBqqQJpIuuwS21HDgKo83rJ21wWDjZMAlXmTJL0vTHH02UfjWXuHfM8LzoxPCqM9
         0R3oK2TTF+eITyrHyNYEOmY3tmiPuxkogB7ECnUp/xXS3upQ0jX9TZLu3sjxO94rfWTK
         Zfug==
X-Forwarded-Encrypted: i=1; AJvYcCV5EjUD5/8tJMBqYyCiHWVuyr6oibeOIhpsOanUrQrgpDRt01BdrPOwUZmkXFnJIsPccx+IJ/qu@vger.kernel.org, AJvYcCVXCmj4KE3bseheJIAZH7j0iD2QsIDUAgSF8N+8RE1/kW4+IJSQ+Be4rZPncdhyqz6Qo7bjSFJiRO3GyOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9kLQGf+e2FwoyZBORxOD7eThievN0pZW58ftwY/vRprY45z1b
	NVkRfx46lKVNjPtFEz8QFPLM/wL86y3NNtLN/Wc9frO9rkL00yDLD78aiOb11YXDp6Gd+ohNZCt
	CjGHfVsimp+nMVXfXvtkFYUhCIBY=
X-Gm-Gg: ASbGncvEUssB0Frz6ztSerWXM+164AMVPCkc7RhE6J5ttM/rnL83JlWUkySXu+Zk6uE
	+8EIjfCGkFsKm5qFhS/8uMXhwlPLaXkZpG/H98n8sOmGRrhFLW3eTvpOBdeA+gmvdRjYTauD42b
	8kODWEd33gQuI8NCHoUyw=
X-Google-Smtp-Source: AGHT+IEhkfAwWL8fVju4Lkb0QFOaKJJL8P4xY667SzVOwX2PIzzJstixARlzcso7JHOoO0ZjEw+VVPDctr4hEApCZ3s=
X-Received: by 2002:a05:6902:a86:b0:e73:91a:9311 with SMTP id
 3f1490d57ef6-e73ea21119cmr2996051276.6.1746002631281; Wed, 30 Apr 2025
 01:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429201710.330937-1-jonas.gorski@gmail.com> <52f4039a-0b7e-4486-ad99-0a65fac3ae70@broadcom.com>
In-Reply-To: <52f4039a-0b7e-4486-ad99-0a65fac3ae70@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 30 Apr 2025 10:43:40 +0200
X-Gm-Features: ATxdqUFI7CkDXiAPdAxAFb4q56LGJGrb1AR7EqNZNEXKnpODFXQ2kT5IcrZ2LP8
Message-ID: <CAOiHx=n_f9CXZf_x1Rd36Fm5ELFd03a9vbLe+wUqWajfaSY5jg@mail.gmail.com>
Subject: Re: [PATCH net 00/11] net: dsa: b53: accumulated fixes
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 10:07=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
>
>
> On 4/29/2025 10:16 PM, Jonas Gorski wrote:
> > This patchset aims at fixing most issues observed while running the
> > vlan_unaware_bridge, vlan_aware_bridge and local_termination selftests.
> >
> > Most tests succeed with these patches on BCM53115, connected to a
> > BCM6368.
> >
> > It took me a while to figure out that a lot of tests will fail if all
> > ports have the same MAC address, as the switches drop any frames with
> > DA =3D=3D SA. Luckily BCM63XX boards often have enough MACs allocated f=
or
> > all ports, so I just needed to assign them.
> >
> > The still failing tests are:
> >
> > FDB learning, both vlan aware aware and unaware:
> >
> > This is expected, as b53 currently does not implement changing the
> > ageing time, and both the bridge code and DSA ignore that, so the
> > learned entries don't age out as expected.
> >
> > ping and ping6 in vlan unaware:
> >
> > These fail because of the now fixed learning, the switch trying to
> > forward packet ingressing on one of the standalone ports to the learned
> > port of the mac address when the packets ingressed on the bridged port.
>
> Sorry not quite getting that part, can you expand a bit more?

The ping test uses four network ports, where two pairs are linked via
a network cable. So the setup is

sw1p1 <- cable -> sw1p2 <- bridge -> sw1p3 <- cable ->sw1p4

And it tries to ping from sw1p1 to sw1p4.

In the vlan_aware test, the bridge uses VLAN 1 pvid untagged, so it
learns in VLAN 1, while the standalone ports use VLAN 0. Different
FIDs, so no issue.

In the vlan_unaware test, untagged traffic uses VLAN 0 everywhere, so
the following happens:

- switch learns swp1p's MAC at sw1p2
- switch learns sw1p4's MAC at sw1p3

when sw1p1 sends a unicast to sw1p4' mac it egresses on swp1p3 and
then ingresses on sw1p4 again. The switch see's sw1p2's MAC as DA and
then ARL lookup says "sw1p3", but the port VLAN mask disallows sending
from sw1p4 to sw1p3, so it gets dropped.

Without learning, all packets are flooded, so connectivity works, as
the standalone ports are always part of the flood masks.

> > The port VLAN masks only prevent forwarding to other ports, but the ARL
> > lookup will still happen, and the packet gets dropped because the port
> > isn't allowed to forward there.
>
> OK.
>
> >
> > I have a fix/workaround for that, but as it is a bit more controversial
> > and makes use of an unrelated feature, I decided to hold off from that
> > and post it later.
>
> Can you expand on the fix/workaround you have?

It's setting EAP mode to simplified on standalone ports, where it
redirects all frames to the CPU port where there is no matching ARL
entry for that SA and port. That should work on everything semi recent
(including BCM63XX), and should work regardless of VLAN. It might
cause more traffic than expected to be sent to the switch, as I'm not
sure if multicast filtering would still work (not that I'm sure that
it currently works lol).

At first I moved standalone ports to VID 4095 for untagged traffic,
but that only fixed the issue for untagged traffic, and you would have
had the same issue again when using VLAN uppers. And VLAN uppers have
the same issue on vlan aware bridges, so the above would be a more
complete workaround.

> > This wasn't noticed so far, because learning was never working in VLAN
> > unaware mode, so the traffic was always broadcast (which sidesteps the
> > issue).
> >
> > Finally some of the multicast tests from local_termination fail, where
> > the reception worked except it shouldn't. This doesn't seem to me as a
> > super serious issue, so I didn't attempt to debug/fix these yet.
> >
> > I'm not super confident I didn't break sf2 along the way, but I did
> > compile test and tried to find ways it cause issues (I failed to find
> > any). I hope Florian will tell me.
>
> I am currently out of the office but intend to test your patch series at
> some point in the next few days. Let's gather some review feedback in
> the meantime, thanks for submitting those fixes!

If you are awake at this hour I guess your are back "home" ;-)

Sure thing, take your time! All I wanted to implement is MST support,
but then I noticed some things not working as expected, and then I
became aware of the selftests, and then I suddenly had accumulated a
lot of fixes trying to make everything say "Okay" (and sometimes
wondering why other stuff broke when I fixed things, like the learning
in unaware mode).

Best regards,
Jonas

