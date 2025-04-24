Return-Path: <netdev+bounces-185581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4326FA9AFF4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FB71B625A3
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289A4189916;
	Thu, 24 Apr 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBTDBoPs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157981922E7;
	Thu, 24 Apr 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503145; cv=none; b=rlglJT4zbSeV6I7q1hel8+t3ykXojud1tuXt3JdkPWJgiSPlNaJxPlXwPIBkrewjr+b/BMRjJ9xUUzVku+5agJZJSDuPMXW2gfVczxkQhM3RVUu5N8BDznfNs5JaMf+PDrB2VULD8XSoT6ti76Jog30OjKvN5mkaKSv2FZ0EEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503145; c=relaxed/simple;
	bh=/wS2qyfeKJ1g5QmVsC2qtA6t6KVTFxjhV6QUtMMGuSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+vqshbuAA+B6s2ZitplPg7PcSSJgu+W7rhS/7Ic/iBLeOkvTSDgv0ngPM/F/3AqMunjl7hODQQTYpLk/Ia8DT04UwRCB2YHadMChfv1aLvMRgCyeSV53beVyK5r9wLnYOQq2H0E/57ZdB0q4aeqk7a5TPzZb/GfWh0G9xDdPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBTDBoPs; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7082e46880eso10981857b3.1;
        Thu, 24 Apr 2025 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745503142; x=1746107942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO12YFKzi4KoiVvc7xW76x/LCsQTlzuhTcAROt1KEG0=;
        b=IBTDBoPsjOyGWcTlLp5U+fbqnYKLxTQNNnjRE0eBxjjgTGnNgGBPInJWjUKUbe+dZa
         R1c1E/VI+hbz/RMo/H6wEasgoEl/qay4B6hZpgu1Npt/qoA7T1gp6MrHNNklOBy5cgmx
         1L3nebbg+Hl49vFNIuW9Rr7W3KL+ojSy0TminPp+238hXB9qFYM2JoXlCFlu8jTObVh/
         o+1mKm9ds9ESs4GIeo3ifBIY51LQwfWnF+2yo5Zyhy8jN5VfKzSsu81Xd1rFFYj0d217
         mNwoZcyrC6Vo7ZHq4YspDM7AGykoXNOt46o+rfAvmsswcbnApiP58OZm3/ilgp5dPBZ7
         zgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503142; x=1746107942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZO12YFKzi4KoiVvc7xW76x/LCsQTlzuhTcAROt1KEG0=;
        b=eb8mu0LFSdMkjQ1/95YQmVa/HgmaZCeUvTk9Tte/TVHGlOIEfoWuBDOmdaJT++eTeG
         HKEdp+fNf/1BVfAdSNw4UnFEhubZnlW9pOzNTdh2v+I6gwjIFz3fIVZ604nGMaub38Nu
         8EqanctzDJS81UrWFinUVxNUiwnja+Dd1F9VhSh1JdFuiVXTok2L73ie8O+JtYJ07MTi
         YPr/NXWZI6reNRXCLalr2MZHQOmEivw+dBQQ+hXCBQXxZE6VRtupP40U2itJKUI3NXza
         nCqkyGg2Etq3uRfhEWdH+pSsfR4RvCH6RhrYhZCIqnqIrpVTXUBQhHqsONUcfFdeVkOm
         10Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX/nwF/cEXFUcb6sU5kVf0ksCnhPa+U5sW8d6FZd3YISE2ckFMQwjRZjwv+bh3BVoW9jwX14TuL+MafwxI=@vger.kernel.org, AJvYcCXLB3bD20csF79Eb/a4tTP8RIVWwxp26kpAz+9blbdwL1hklMnHFSpig71BtK19nBZtKuZGe1uw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt0KOwDcD4aun1k7a9miBUnEQ+ns/eMmFrGVNcYCAiJXtj8xxv
	OaAHK+U5/JQTrcGEx5QLSZoL0rbpcpNhmCnd481UT1jLflIV4twoqz66c++iTHoAlXWtr7z6DtC
	BlsomRObofQFhSqN8MT2E62+dx6g=
X-Gm-Gg: ASbGnctRUwc7JJk5N4ZVgoPB852gAdWjj8p6ouNgTUDM6rd2rGZYkMtt8rLkNjLM+XS
	FEiLQaFSlXA6HiCnWd87CJ7SWGns85Mw4hZ+WuPliGBM7K+iniKHqi5ztRVQqYgjNTWc02fzVaV
	hx8LWJCeLhnOaWE8+IQmE=
X-Google-Smtp-Source: AGHT+IHwqpgOt9Q26PQFQWtRKmrYV8P1gwnc5VvyJ5FcB0TIN01J8+K9ePxG06lYnAm+fqtwRLaYCH3Rpl74fZ4E9Sw=
X-Received: by 2002:a05:690c:488a:b0:705:750d:c359 with SMTP id
 00721157ae682-7083eda4894mr44030517b3.32.1745503141818; Thu, 24 Apr 2025
 06:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
 <20250424102509.65u5zmxhbjsd5vun@skbuf> <04ac4aec-e6cd-4432-a31d-73088e762565@gmail.com>
In-Reply-To: <04ac4aec-e6cd-4432-a31d-73088e762565@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 24 Apr 2025 15:58:50 +0200
X-Gm-Features: ATxdqUGxE8RDK8LuHitstkRn3GpB3QidAJNNw7_xvXz_vuRnG-LEtKIfyuVz_5Y
Message-ID: <CAOiHx==5p2O6wVa42YtR-d=Sufbb2Ljy64mFSHavX2bguVXPWg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling filtering
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 2:34=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
>
>
> On 4/24/2025 12:25 PM, Vladimir Oltean wrote:
> > On Tue, Apr 22, 2025 at 08:49:13PM +0200, Jonas Gorski wrote:
> >> When a net device has NETIF_F_HW_VLAN_CTAG_FILTER set, the 8021q code
> >> will add VLAN 0 when enabling the device, and remove it on disabling i=
t
> >> again.
> >>
> >> But since we are changing NETIF_F_HW_VLAN_CTAG_FILTER during runtime i=
n
> >> dsa_user_manage_vlan_filtering(), user ports that are already enabled
> >> may end up with no VLAN 0 configured, or VLAN 0 left configured.
> >>
> >> E.g.the following sequence would leave sw1p1 without VLAN 0 configured=
:
> >>
> >> $ ip link add br0 type bridge vlan_filtering 1
> >> $ ip link set br0 up
> >> $ ip link set sw1p1 up (filtering is 0, so no HW filter added)
> >> $ ip link set sw1p1 master br0 (filtering gets set to 1, but already u=
p)
> >>
> >> while the following sequence would work:
> >>
> >> $ ip link add br0 type bridge vlan_filtering 1
> >> $ ip link set br0 up
> >> $ ip link set sw1p1 master br0 (filtering gets set to 1)
> >> $ ip link set sw1p1 up (filtering is 1, HW filter is added)
> >>
> >> Likewise, the following sequence would leave sw1p2 with a VLAN 0 filte=
r
> >> enabled on a vlan_filtering_is_global dsa switch:
> >>
> >> $ ip link add br0 type bridge vlan_filtering 1
> >> $ ip link set br0 up
> >> $ ip link set sw1p1 master br0 (filtering set to 1 for all devices)
> >> $ ip link set sw1p2 up (filtering is 1, so VLAN 0 filter is added)
> >> $ ip link set sw1p1 nomaster (filtering is reset to 0 again)
> >> $ ip link set sw1p2 down (VLAN 0 filter is left configured)
> >>
> >> This even causes untagged traffic to break on b53 after undoing the
> >> bridge (though this is partially caused by b53's own doing).
> >>
> >> Fix this by emulating 8021q's vlan_device_event() behavior when changi=
ng
> >> the NETIF_F_HW_VLAN_CTAG_FILTER flag, including the printk, so that th=
e
> >> absence of it doesn't become a red herring.
> >>
> >> While vlan_vid_add() has a return value, vlan_device_event() does not
> >> check its return value, so let us do the same.
> >>
> >> Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when =
not needed")
> >> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> >> ---
> >
> > Why does the b53 driver depend on VID 0? CONFIG_VLAN_8021Q can be
> > disabled or be an unloaded module, how does it work in that case?
>
> This is explained in this commit:
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D64a81b24487f0d2fba0f033029eec2abc7d82cee
>
> however the case of starting up with CONFIG_VLAN_8021Q and then loading
> the 8021q module was not thought about, arguably I am not sure what sort
> of notification or event we can hook onto in order to react properly to
> that module being loaded. Do you know?

config BRIDGE_VLAN_FILTERING
        bool "VLAN filtering"
        depends on BRIDGE
        depends on VLAN_8021Q

without 8021Q there is no vlan filtering bridge, so filtering can
never be 1, so NETIF_F_HW_VLAN_CTAG_FILTER is never set, so HW filters
for VLAN 0 are never installed or removed, therefore the issue can
never happen.

The issue is only if a vlan filtering bridge was there, and now isn't
anymore, and a previously VLAN 0 HW filter is left intact. This causes
an incomplete vlan entry left programmed in the vlan table of the chip
with just this port as a member, which breaks forwarding for that
VLAN, which is incidentally also the VLAN used for untagged traffic in
the non filtering case.

There are a several issues currently in how b53 handles VLANs,
especially on non filtering bridges. E.g. switchdev.rst says all vlan
configuration should be ignored, but currently it isn't, as b53
dutifully configures any vlans to the hardware passed on from DSA. I
will attempt to fix at a later time, but first I wanted to make sure
that switchdev/dsa/vlan/etc subsystems are working correctly.

Best regards,
Jonas

