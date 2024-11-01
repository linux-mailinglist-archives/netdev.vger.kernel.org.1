Return-Path: <netdev+bounces-141133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9949B9B15
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 00:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570491C2106B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 23:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608F71D041B;
	Fri,  1 Nov 2024 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHz83Sbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E81607B4
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730502294; cv=none; b=O9ySsI5mgsb4MPxGpaxY0pa/C7zuCYsEOneTlWPLJprA5GL8H8uPPNvnwOCYVZrHWiPyvYc/HWz2ZqY4/HBl3dIm3TY5uHZElKWFZodwAPcjAoaygAfJkLjkJyjFRY/eBd5vTU8gtRezLp3SvdR+EzTYyNDRn8ICZM/wNMB/pa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730502294; c=relaxed/simple;
	bh=DixNhVF4jakrdr22GwfD2VcDsBiLU/pzh+zKxgtEml0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLh09ESMQW3c/OLq1OG1rvFUeS0FM7JhXawgwMO1wEP9QCMcHpyzz1cpNMQBx7RuDaXkPVgdKl4W6VExrDF7dha9h9vPT07UF/VMNZyCElLwYTdO85cDf2wNVL1JbaBhT5cNZBPmRtwymI7XSpHsBbajsB4DbqoY5g3asAcYg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHz83Sbj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so2163523b3a.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730502292; x=1731107092; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKZLu72Me7oUS7vdyW1rBBqfAQKAYGju/TDlZKaa54Y=;
        b=DHz83SbjuKuN9uSjEziueerzo8PNy97U7S0weAOyXRH++pyBYzk8WWmZsllBf2lJOd
         MhTnAK9TXSuwOfW10Nx2mcx9di94P/oVe4P39RtIbIDgYBkN7Z3rZuqIhS7EG8+GE1OK
         uUTK7NZ3zsPep0nIcl5ylmECfGhWIsxUpGshxcqXCRT79SAhfZVW9OSElDMuouJLEhM4
         uYKC0Tp9c7i9L2Zsuj93LefvbHORm7Q2FFUAoYC0ZbjIT9CDfZHGPY+ZU2PJ0M2RdbJS
         WWR1h9zkeaXoDMv14VwBfk2jqomg66KsjoXPPjEryanhMt+MB1NXMhx8n92IUzKJbMXp
         25iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730502292; x=1731107092;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKZLu72Me7oUS7vdyW1rBBqfAQKAYGju/TDlZKaa54Y=;
        b=eDkxPArxhx88LgY4E7s1Ua1sW3Pks98LaYFKrtRF8xUzLxjnOqahoSP2KOSwrjG5km
         hPIJ+yns4bsQOlTtHThlEihT3YqcRPS7Az/BUWVvSYMHqe496+Vk4lwKkOtLV4FzZtWJ
         tsydfwWxEeb/HjX3Pffq1Pcn7hC/t8M/NBmxsVOx+OtwzoEvvxaZ9eMSk3jvO0F05KBL
         e6WtkW2+Ns+tBZVlBJl8z9AmqHK6gyRj5gRwesB9Ohk7NqAm25xbmCoOQEK19ywVboW/
         XvyIZ2jzND8T9oVy5JearLVIVESRSWJMlRH6ptjn0F3uuQrWo8VcDJnVJBZzo8w4UOrf
         DIfw==
X-Gm-Message-State: AOJu0YwwTbiuGAgzueIKh2MQ9zzKBlnNzQddtQhycKoKUK4BRwPDXzhx
	Tsz2fOXEdaQsxmAz4aDwx8hhy3Cv3b59nYFc8A+xqeQjbM3lvHlw
X-Google-Smtp-Source: AGHT+IEbZr+5LQFn8LKL6YFQi1EimvZ6uUldokWK1o5LpC/9wspQ7R1Is5gUUzROx5ewmP1PcHM7OA==
X-Received: by 2002:a05:6a21:31c8:b0:1d9:a80:bcfe with SMTP id adf61e73a8af0-1dba552944cmr6172665637.41.1730502291970;
        Fri, 01 Nov 2024 16:04:51 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc31874bsm3171597b3a.213.2024.11.01.16.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 16:04:51 -0700 (PDT)
Message-ID: <7f4a7177f249c3906343afb74ecef76bd0479723.camel@gmail.com>
Subject: Re: [PATCH net-next v2] eth: fbnic: Add support to write TCE TCAM
 entries
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org, 
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com,  kernel-team@meta.com, sanmanpradhan@meta.com,
 sdf@fomichev.me,  vadim.fedorenko@linux.dev, hmohsin@meta.com
Date: Fri, 01 Nov 2024 16:04:50 -0700
In-Reply-To: <61830f21-f943-4d84-82c1-fce0e2659ac7@lunn.ch>
References: <20241024223135.310733-1-mohsin.bashr@gmail.com>
	 <757b4a24-f849-4dae-9615-27c86f094a2e@lunn.ch>
	 <97383310-c846-493a-a023-4d8033c5680b@gmail.com>
	 <4bc30e2c-a0ba-4ccb-baf6-c76425b7995b@lunn.ch>
	 <e2c12a98-acf3-46df-8831-4b898387bfa0@gmail.com>
	 <61830f21-f943-4d84-82c1-fce0e2659ac7@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-01 at 13:33 +0100, Andrew Lunn wrote:
> On Thu, Oct 31, 2024 at 03:13:40PM -0700, Mohsin Bashir wrote:
> > On 10/31/24 5:43 AM, Andrew Lunn wrote:
> > > On Wed, Oct 30, 2024 at 05:51:53PM -0700, Mohsin Bashir wrote:
> > > > Hi Andrew,
> > > >=20
> > >=20
> > > > Basically, in addition to the RX TCAM (RPC) that you mentioned, we
> > > > also have a TCAM on the TX path that enables traffic redirection fo=
r
> > > > BMC. Unlike other NICs where BMC diversion is typically handled by
> > > > firmware, FBNIC firmware does not touch anything host-related. In
> > > > this patch, we are writing MACDA entries from the RPC (Rx Parser an=
d
> > > > Classifier) to the TX TCAM, allowing us to reroute any host traffic
> > > > destined for BMC.
> > >=20
> > > Two TCAMs, that makes a bit more sense.
> > >=20
> > > But why is this hooked into set_rx_mode? It is nothing to do with RX.
> >=20
> > We are trying to maintain a single central function to handle MAC updat=
es.
>=20
> So you plan to call set_rx_mode() for any change to the TCAM, for any
> reason? When IGMP snooping asks you to add an multicast entry due to
> snooping?  ethtool --config-ntuple? Some TC actions? i assume you are
> going to call it yourself, not rely on the stack call set_rx_mode()
> for you?
>=20

What the set_rx_mode function is doing is taking in all the MAC
addresses from all the various lists, unicast, multicast, BMC, and then
updating the TCAM as needed. We are keeping a copy of the TCAM in
software so if we call set_rx_mode with no change there is no change to
the hardware setup.

I think the TCE TCAM may be the only exception to that as it might
shift up or down as we are just parsing the list for BMC addresses and
writing them top down, or bottom up in order to preserve the entries in
the case of one being added or removed. So the table may shift if there
is no change, but the contents should stay the same.

Basically the BMC makes it so that we have to modify the ACT_TCAM rules
if we add/remove the BMC addresses, or if we toggle the ALL_MULTI flag
since the BMC can force us to have to place that rule at either entry
24 in the MACDA TCAM, or if it isn't present we place it at entry 31.

For the --config-ntuple we don't call it as the assumption is that we
aren't going to be modifying the multicast or unicast promiscuous flags
due to the rule addition. Instead that does a subset where it will use
fbnic_write_macda to update the MACDA TCAM if there is a new MAC
destination address added.

> > > I assume you have some mechanism to get the MAC address of the BMC. I
> > > would of thought you need to write one entry into the TCAM during
> > > probe, and you are done?
> > >=20
> > > 	Andrew
> >=20
> > Actually, we may need to write entries in other cases as well. The fact=
 that
> > the BMC can come and go independently of the host would result in firmw=
are
> > notifying the host of the resulting change. Consequently, the host woul=
d
> > need to make some changes that will be added in the following patch(es)=
.
>=20
> And the MAC address changes when the firmware goes away and comes back
> again? It is not burned into an OTP/EEPROM? What triggers
> set_rx_mode() being called in this condition?
>=20
> 	Andrew

So there are BMC addresses that are passed in via the Firmware
Capabilities Response message. Unfortunately we have to deal with BMCs
that will bail on us and force us to remove the entries for it as soon
as they see the link go down and come back as soon as they see the link
come up. In addition the NCSI spec basically makes it so that we have
to support the BMC deciding to change the config or enable/disable the
channel on a whim.

In such a case we have to go through and take care of several items
including pointing our TCE TCAM at the BMC addresses, and then sending
a message to the firmware with the list of our unicast MAC addresses so
that it can send the BMC packets back to us if it is sending to our
unicast addresses. Unfortunately the BMC also tends to enjoy running in
multicast promiscuous so we don't have any way of knowing what
mutlicast entries it has so we normally will just have it send us all
it's multicast traffic and likewise all our multicast traffic will be
routed to it. It simplifies the handling a bit, but also is kind of
sloppy as far as I am concerned.

- Alex

