Return-Path: <netdev+bounces-188367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A931AAAC7EF
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D3B7B0F34
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623972820BA;
	Tue,  6 May 2025 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JikliEeR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076C26C3AC;
	Tue,  6 May 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541666; cv=none; b=ieEsy/Rc8ht7USPPx+TuBc6S2CdFuhFKZa6hLFv3M1zpoGGJZJ/eqdGvXVtECqzJ9HB4NMnxIWcwhOe2D3URrN63RNhWYwB7WhFhXyrkVfw6CHFnj1sJqTHq2wqtouDysreJWvkUBjTvwK1+0yt7V+WrPCM7CC33NnxvaXG6+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541666; c=relaxed/simple;
	bh=aGUAfepQtMbtKlsKnuW42Rwy5glPfSZ3j+xSq5EKPWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcPNc1LFh2AtMNMMPAVmq07dr0XjNmY4lOSPeprKJKdhJ9M8EiHLBvA1atxUH3tWUchTe2/OqE2wBjwhNBnJTzntrQthRJSTt0/Uh98porKIzk7AfPWfEGcnyM2KoPkCOjZjPR8qmJeANZCGm+b1dzTZDjGnwNWsIxwOfWhZI0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JikliEeR; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e63a159525bso4647731276.2;
        Tue, 06 May 2025 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746541663; x=1747146463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGUAfepQtMbtKlsKnuW42Rwy5glPfSZ3j+xSq5EKPWY=;
        b=JikliEeRDDYinjUxaq4yUDorr+meHcDmed/VJGqf7c89cRQYbrGXXrVeBFYf5uj/0a
         tcDxA7S6TLdvb3awVUJXSSOWyd/k02ENmsXUbgZA+oyCTBFDbhfdHFTLkCvF6wDP1DY3
         CL/Vpdstr+R9MCg3jWfxCyz1m5PmDxzAcVkF2w4uQoP6yl0IqHXJBDyCC3t/LOyU0S4+
         m/gXGg6AQXJeSZ+yKH0cB5PWvs5TbelCezJGMC4jr4J+60Quaj9p4nu37UNljJZXpixy
         8C7PzOpdU3iIKhhLG+sNqj6qCHoihe4r3eidEV2IZLt6hNSanCOPy3TXmc5JKW5H2YxA
         4aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746541663; x=1747146463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGUAfepQtMbtKlsKnuW42Rwy5glPfSZ3j+xSq5EKPWY=;
        b=LWhawUUGiXEmAit8b4waGm1r1oOKyNGK6mHYtgWGyklULx7LyBZedxDQ4WY7iKioEq
         154MAbuJDZFDfx5yoB4MhbqY0kQgMvvvRRK9XXZLl/l6YeB7SulvxR+QHmY3tQjKqgw5
         gONJmGE/lIR/8WayRvNcwRHo30kZT28B6WPw9OcysVY4A/If2RPjQFcS0M4EC6E+/DZU
         R8pR0cl4sGWugUkdeXGXk1EDzuAJTrcKDlE7NTmWBNPii0SWK9rCkba9+Urdi4CdKNiv
         aUTr5LNcRBIsnlkuygqKCSiuiKmaLRtKD4HJIjE6bGiHI2WUtCImHzQ5IBEJOF3mkzkZ
         akVA==
X-Forwarded-Encrypted: i=1; AJvYcCUVELaWbK2lM7pF7hYDvWtePW/z+JhZwikFVPL/iDpeYL0z+RSbqpWKo8E4yqXs4AVbb/up9EYV@vger.kernel.org, AJvYcCVwkg9hE/QjotxykeamLZSxz/4RJPwLj8rd97qapuG2XzgmYHFSY7XaQk0JoZRwKoBQ0/kP4Fl08I+uSb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuQHKbypez6oIpaYJUr+nnzrrsq5UPzLZvfRjRWLVtM0nzZDae
	+FGkzpNi1E+EU7CHSdpwJ1+vnpRXErqk4dBsPQvfCEkuxzI3Cak7Ss3LXgP3sjaf8Y6zAn0unhT
	15XaQZ2F72C9W/FtQbKDheu9CQFI=
X-Gm-Gg: ASbGnct9gCrCTaMAdMTaP181pLrnSkGUkf/rq9rbiFxTBSW1DrioZJsJK1rLWniWXUH
	OuRjpipX3qJS1P3SqeCZHbyCyZZvJlCeEsiwFFdyLvxLNR4UG6ZhThq8un1FF77jZOmzV5nJr9L
	skNfP0H4qCYdSWRqYsSA+a
X-Google-Smtp-Source: AGHT+IErF8ODf8iEKAIwk1rmA9mjYpI9PaRwo0wbjTotLSVd98Q/JuF1sx1xiNVK7aA8M+gjfu1zYSlM4ClCPbJdbqw=
X-Received: by 2002:a05:6902:1b92:b0:e72:74a9:18d with SMTP id
 3f1490d57ef6-e75c09e29c0mr4108623276.42.1746541663335; Tue, 06 May 2025
 07:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
 <52f4039a-0b7e-4486-ad99-0a65fac3ae70@broadcom.com> <CAOiHx=n_f9CXZf_x1Rd36Fm5ELFd03a9vbLe+wUqWajfaSY5jg@mail.gmail.com>
 <20250506134252.y3y2rqjxp44u74m2@skbuf>
In-Reply-To: <20250506134252.y3y2rqjxp44u74m2@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 6 May 2025 16:27:32 +0200
X-Gm-Features: ATxdqUHLGqUX_wSZA0RhCQf_LFjTh7IzEt8yJfg26j_V6hYMZT5ICQ5ldPFdXcg
Message-ID: <CAOiHx=kFhH-fB0b-nHPhEzgs1M_vBnzPZN48ZCzOs8iW7YTJzA@mail.gmail.com>
Subject: Re: [PATCH net 00/11] net: dsa: b53: accumulated fixes
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 3:42=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:
>
> / unrelated to patches /
>
> On Wed, Apr 30, 2025 at 10:43:40AM +0200, Jonas Gorski wrote:
> > > > I have a fix/workaround for that, but as it is a bit more controver=
sial
> > > > and makes use of an unrelated feature, I decided to hold off from t=
hat
> > > > and post it later.
> > >
> > > Can you expand on the fix/workaround you have?
> >
> > It's setting EAP mode to simplified on standalone ports, where it
> > redirects all frames to the CPU port where there is no matching ARL
> > entry for that SA and port. That should work on everything semi recent
> > (including BCM63XX), and should work regardless of VLAN. It might
> > cause more traffic than expected to be sent to the switch, as I'm not
> > sure if multicast filtering would still work (not that I'm sure that
> > it currently works lol).
> >
> > At first I moved standalone ports to VID 4095 for untagged traffic,
> > but that only fixed the issue for untagged traffic, and you would have
> > had the same issue again when using VLAN uppers. And VLAN uppers have
> > the same issue on vlan aware bridges, so the above would be a more
> > complete workaround.
>
> I don't understand the logic, can you explain "you would have had the
> same issue again when using VLAN uppers"? The original issue, as you
> presented it, is with bridges with vlan_filtering=3D0, and does not exist
> with vlan_filtering=3D1 bridges. In the problematic mode, VLAN uppers are
> not committed to hardware RX filters. And bridges with mixed
> vlan_filtering values are not permitted by dsa_port_can_apply_vlan_filter=
ing().
> So I don't see how making VID 4095 be the PVID of just standalone ports
> (leaving VLAN-unaware bridge ports with a different VID) would not be
> sufficient for the presented problem.

The issue isn't the vlan filtering, it's the (missing) FDB isolation
on the ASIC.

In general if a MAC is learned on one of the bridged ports, the ASIC
will try to forward any traffic ingressing for that MAC to the port
according to the internal FDB regardless if the source port is bridged
or not. The private VLAN masks used to isolate ports is only applied
*after* the forwarding lookup was done (this is how the hardware
works), and will then cause traffic to be dropped on standalone ports.

So for vlan_aware=3D0, the bridge learns on the FDB for VID 0, which is
also used for untagged traffic on stand alone ports, so the issue
happens.

For vlan_aware=3D1, untagged traffic is assigned to a VLAN !=3D 0 on the
bridge, so the FDBs are different. Therefore no issue.

But once using VLAN uppers, the FDB will be the same again on the
bridged ports and tagged traffic on the standalone ports, so it
happens again. And this would be true regardless of vlan_aware or not.

Therefore using VID 4095 would only avoid the issue for vlan_aware=3D0
and untagged, but not the VLAN upper scenario.

Unfortunately there is no bit to disable FDB lookups for standalone
ports, only learning (at least I haven't found one).

> That being said, trapping to CPU all packets on standalone ports is not
> uncontroversial, as long as it works correctly for the hardware
> controlled by this driver. You seem concerned about losing RX filtering,
> but if you look at dsa_switch_supports_uc_filtering() and
> dsa_switch_supports_mc_filtering() you'll see b53 never had it - it
> depends, among other things, on ds->fdb_isolation =3D=3D true and
> ds->vlan_filtering_is_global =3D=3D false. Here you're working on improvi=
ng
> the fdb_isolation requirements, but there is still no support in the
> core for devices where VLAN filtering is a global setting.

Aha, so I don't need to care about this, since fdb_isolation is not
supported and filtering is always global. Good to know.

I'm mostly concerned if using the security feature for that has any
side effects I'm not aware of (e.g. dropping of some traffic), or if
it would prevent using it for its intended use, i.e. locked ports and
MAB. I don't trust it yet, feels a bit too easy of a solution ;-).
Will need to double/triple check (and read the docs).

Also it's not supported by all b53 supported ASICs, so maybe there is
a solution that works for all (but most probably there is not).

Best regards,
Jonas

