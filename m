Return-Path: <netdev+bounces-154369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93F9FD738
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 20:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602203A24B2
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52CC1F5435;
	Fri, 27 Dec 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="gq0c/2l4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE4A35958
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735326428; cv=none; b=H0hFYLfCkS0nqi3trIBErEtnk/5a9zwmd8uAuZ8SzO1twy94JwL0chFiPLqLOblVsSBIkLR1UwJsuT7d9OdOpm+miREl9qtwWUibdrtcNRJ7bOzSJq64CAB59gzUikQbOeaJ3RSWSBcl/hTMDdnqhu6G4MXuwHKu2jhtqlh5ck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735326428; c=relaxed/simple;
	bh=b1IwhxxF3T7Rhb0b3OtFTqAMkiZfEqydtw41bsZ4Lqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WT3wiSDmOfwT8ldv+MC62mVerocjKl02Xzasyc56vuRkXZJD8UGGR6Dn9Z30tOA6iYwiEXny5toAwOpzY2HQVvp0PKLQmETgKagiDHZpm/BLBR3+EfAduPam7YCnH60l7+hroa+hOCUIWmz+Hpuuoak1vy/oEXDukhnpV6KACII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=gq0c/2l4; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so3556483276.3
        for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1735326426; x=1735931226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/XhvMxvS7Rk/9c90lnY/4uqRIvjF8tExSVlQeF5K0c=;
        b=gq0c/2l4idM18GstD1aRtYwMmJFqzXXfMihpLui4N/x2R/2ofE71jsdrBlBdEipnxL
         kM0eNJuZvFOSbhpS1XMmmNxPtRqqxo8fLANkyjj0pdKnLdgzFspidjlC3DtoIBaMkdFH
         /xcgmyc7fsM4ghy7sRumAHotkd5gqq4lEFqNuSsZ3GAtETYGX26uLDUopKiHtb6BADQk
         GIcA9b2eGXuFJK4g373a8lIJOdx2nOOXoYkV9zn3c72WyOKFvM0T3m1VYZn2u/5NdxVt
         XXgruXgC9sng90FZkRNyTWXuFdPs5e7xtzi9ezVTQiotV23owOInCSlgd6AVNfLclZ4Z
         vlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735326426; x=1735931226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/XhvMxvS7Rk/9c90lnY/4uqRIvjF8tExSVlQeF5K0c=;
        b=oQYhl71Ycp8OlYL5Dw4CkmoyUSo9T5ji6vu8A6rG8w8f1ciphEH1B4KBMt0AoqJGg6
         CNapufwXJ+j5jMtGXxSIc+iQEA/jGAepyfXRA9P8Jhpfs5pnC5k8aYbR99W/v+FFY2Nu
         OKAEVoYcPsZjaitpDIwSIN5OiaKooSSwtsmg6gsH9V9jvQ1Aduujl8R4Pz2J6+xjRLv/
         ttdnvXFUwmb6JWDn7T2jmVTlIdvVgbPQmBqIRuusGC9jHU4mGknquNz098E8mmbHDHqv
         VOdtqjOGegShe6dcDe3BbHrNkWBxf/41D6EXIsDIbZcdxkNZJu2ycJ9CTVmBY1tvr9IZ
         ZPhA==
X-Forwarded-Encrypted: i=1; AJvYcCX7hR0Kx1MhL2NGl5s75UrPrn7HsQX/wd8uyqveAmhAW5OGHDCGfWff44msgOmFlmDCrlUUWFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIicJpd4g3+84DLKRZOjos4ZlrZQ59dzqvpiYi5wBmy4wu/84
	SoRsy9GN1wdtekcGfsgqVukFhGBaFoxljAVmRveaa+3gUxneinJEkACAC4SWb4pqDp2adErPeHg
	jeah2XXa1hmR4ge3MsAW8u8iAXuAMOX3rJGadVw==
X-Gm-Gg: ASbGncuiEJGVO3x2a32VpTR4eAMOJOvM7CwT43D2KV/z/4GnozqViJVgRLHnDWEagC/
	EbzRigtF1HCKtaerKUlaZ5jPRvKb+2vMqu3zghA==
X-Google-Smtp-Source: AGHT+IGR/hhm8kQ8T7xobR/7dN0L2JFTuFdSjq7zQfGs1721fNzUxASpyPMN2eoEyxQJpNrS01tKlm8Oj9bWZVn0mYs=
X-Received: by 2002:a05:690c:6487:b0:6ef:6d37:181d with SMTP id
 00721157ae682-6f3f80d59b9mr220264427b3.8.1735326425931; Fri, 27 Dec 2024
 11:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212215132.3111392-1-tharvey@gateworks.com>
 <20241213000023.jkrxbogcws4azh4w@skbuf> <CAJ+vNU2WQ2n588vOcofJ5Ga76hsyff51EW-e6T8PbYFY_4xu0A@mail.gmail.com>
 <20241213011405.ogogu5rvbjimuqji@skbuf>
In-Reply-To: <20241213011405.ogogu5rvbjimuqji@skbuf>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 27 Dec 2024 11:06:54 -0800
Message-ID: <CAJ+vNU3pWA9jV=qAGxFbE4JY+TLMSzUS4R0vJcoAJjwUA7Z+LA@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
To: Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:14=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Thu, Dec 12, 2024 at 04:32:28PM -0800, Tim Harvey wrote:
> > > >  - forward to all but cpu port:
> > >
> > > Why would you not forward packets to the CPU port as a hardcoded conf=
iguration?
> > > What if the KSZ ports are bridged together with a foreign interface
> > > (different NIC, WLAN, tunnel etc), how should the packets reach that?
> >
> > If that is the correct thing to do I can certainly do that. I was
> > assuming that the default policy above must be somewhat standard. This
> > patch leaves the policy that was created by the default table
> > configuration and just updates the port configuration based on the dt
> > definition of the user vs host ports.
>
> I think you misunderstood my comment which you've quoted here, it was:
> "why would you hardcode a configuration which can't be changed and which
> doesn't include _at least_ the CPU port in the list of destination
> ports?! isn't that needed for so many reasons?"
>
> This particular paragraph did not contain any suggestion of the form
> "the correct thing to do is ...", just an observation that the choice
> you've made is most likely wrong.
>
> > > >    group 4 (01-80-C2-00)-00-20 (GMRP)
> > > >    group 5 (01-80-C2-00)-00-21 (GVRP)
> > > >    group 7 (01-80-C2-00)-00-11 - (01-80-C2-00)-00-1F,
> > > >            (01-80-C2-00)-00-22 - (01-80-C2-00)-00-2F
> > >
> > > Don't you want to forgo the (odd) hardware defaults for the Reserved =
Multicast
> > > table, and instead follow what the Linux bridge does in br_handle_fra=
me()?
> > > Which is to trap all is_link_local_ether_addr() addresses to the CPU,=
 do
> > > _not_ call dsa_default_offload_fwd_mark() for those packets (aka let =
the
> > > bridge know that they haven't been forwarded in hardware, and if they
> > > should reach other bridge ports, this must be done in software), and =
let the
> > > user choose, via the bridge group_fwd_mask, if they should be forward=
ed
> > > to other bridge ports or not?
> >
> > Again, I really don't know what the 'right' thing to do is for
> > multicast packets but the enabling of the reserved multicast table
> > done in commit 331d64f752bb ("net: dsa: microchip: add the
> > enable_stp_addr pointer in ksz_dev_ops") breaks forwarding of all
> > multicast packets that are not sent to 01-80-C2-00-00-00
>
> Yes, because prior to that commit, this table wasn't consulted by the
> data path of the switch.
>
> > > > Datasheets:
> > > > [1] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9897S-Data-=
Sheet-DS00002394C.pdf
> > > > [2] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9896C-Data-=
Sheet-DS00002390C.pdf
> > > > [3] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9893R-Data-=
Sheet-DS00002420D.pdf
> > > > [4] https://ww1.microchip.com/downloads/en/DeviceDoc/00002330B.pdf
> > > > [5] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-=
Sheet-DS00002419D.pdf
> > > > [6] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/=
ProductDocuments/DataSheets/KSZ9567R-Data-Sheet-DS00002329.pdf
> > > > [7] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/=
ProductDocuments/DataSheets/KSZ9567R-Data-Sheet-DS00002329.pdf
> > >
> > > [6] and [7] are the same.
> > >
> > > Also, you'd better specify in the commit message what's with these da=
tasheet
> > > links, which to me and I suppose all other non-expert readers, are pa=
sted here
> > > out of the blue, with no context.
> > >
> > > Like for example: "KSZ9897, ..., have arbitrary CPU port assignments,=
 as
> > > can be seen in the driver's ksz_chip_data :: cpu_ports entries for th=
ese
> > > families, and the CPU port selection on a certain board rarely coinci=
des
> > > with the default host port selection in the Reserved Multicast addres=
s
> > > table".
> >
> > I was just trying to be thorough. I took the time to look up the
> > datasheets for all the switches that the ksz9447 driver supports to
> > ensure they all had the same default configuration policy and same
> > configuration method/registers so I thought I would include them in
> > the message. I can drop the datasheet links if they add no value. I
> > was also expecting perhaps the commit message was confusing so I
> > wanted to show where the information came from.
>
> They do add value, just guide the reader towards what they should be
> looking at, rather than throwing 6 books at them. I gave my own
> interpretation above of what I think should be the takeaway, after
> spending more than 1 hour studying, and I still might have not seen the
> same things as you. Just don't expect everybody to spend the same amount
> of time.
>
> > What you're suggesting above regarding trapping all
> > is_link_local_ether_addr() addresses to the CPU and not calling
> > dsa_default_offload_fwd_mark() is beyond my understanding.
> > If the behavior of the reserved multicast address table is non-standard
>
> The behavior of that table is customizable, in fact, and can be brought
> into compliance with the Linux network stack's expectations.
>
> Other network stacks might be different, but in Linux, the easiest way
> to achieve configurability of the group forwarding would be to let
> software do it. The bridge group_fwd_mask is a bit mask of reserved
> multicast groups (group X in 01-80-C2-00-00-0X). For example, setting
> bit 14 (0xe) (aka set group_fwd_mask to 0x4000) would mean "let group
> 01-80-C2-00-00-0E be forwarded on all bridge ports, and all other groups
> be just trapped".
>
> Conceivably, even in Linux there might be other ways to do it, like
> reprogram the hardware tables according to the group_fwd_mask value
> communicated through switchdev. But that infrastructure doesn't exist.
>
> > then it should be disabled and the content of ksz9477_enable_stp_addr()
> > removed.
>
> I wouldn't jump the gun so soon.
>
> > However based on Arun's commit message it seems that prior to
> > that patch STP BPDU packets were not being forwarded to the CPU so
> > it's unclear to me what the default behavior was for multicast without
> > the reserved muticast address table being enabled. I know that if the
> > table is disabled by removing the call to ksz9477_enable_stp_addr then
> > LLDP packets are forwarded to the cpu port like they were before that
> > patch.
>
> Reading the commit message: "In order to transmit the STP BPDU packet to
> the CPU port, the STP address (...) has to be added to static alu table",
> I think the correct key in which it should be interpreted is:
>
> "In order to transmit the STP BPDU packets [just] to the CPU port
> [rather than flood them towards all ports], the STP address has to ...".
>
> I will give it to you that it is quite a stretch to interpret it in this
> way, and it is also frustrating to me to have to extract technically
> valid information from loose formulations like these. Plus, unlike both
> you and Arun, no access to this hardware. But at least, this is the only
> interpretation with which I see no contradictions.
>
> I will let Arun confirm that the commit message should be interpreted in
> this way and not in another. But at the same time, you could also
> confirm that when the Reserved Multicast address table lookup is disabled=
,
> they are treated just like any other multicast traffic with no hit in
> the address table: aka broadcast.

Arun,

Can you confirm that prior to commit 331d64f752bb ("net: dsa:
microchip: add the enable_stp_addr pointer in ksz_dev_ops") that
packets in the bridge group were being forwarded to all ports and that
the intention of the patch was to limit them to only go to 'only' the
cpu port?

Do you have any comments on this patch with regards to how the other
packet groups should be configured?

Best Regards,

Tim

