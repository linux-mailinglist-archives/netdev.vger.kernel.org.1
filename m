Return-Path: <netdev+bounces-239705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65491C6BB03
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25E4A4E2ACE
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3352F3C07;
	Tue, 18 Nov 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTBLdnBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7081DF261
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500212; cv=none; b=q5KJbHhaQQ/ngIuWrW8K/MDy+g4EnoyTr1IADZS0KrRv8zdVcvvJC/njqmKpzMCvY3mEZS3Z34Q1sz5WBX/eRhvd6OgFMlLyFND8p2OdqF9rMUdxJc/VrqcMIkpFv2ej/h34MbnKs5s1PRohpdFh8rn5Oegc62fWrOFZb8YOHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500212; c=relaxed/simple;
	bh=D5uJOHo+OfhQyleW150ammZYy3+R5ojMA0+UNXm17SY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CcfpZKGUr6/nDBccoPGV+BhvBLULzWiPFoNbvl2rVCnS7Fo3H/i8zJfedxv2m8d0QH+xiAQTDDsaHGI9gf1LME3bnmJcVb/Vvry3K/Llw7IVcwK/qFtj5PL+RnGFX62nDvvFl/tXzCKX5ifhfFZb5L1/RmX+cB7H5x9jJgwwRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTBLdnBJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297dc3e299bso58034535ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 13:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763500210; x=1764105010; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5uJOHo+OfhQyleW150ammZYy3+R5ojMA0+UNXm17SY=;
        b=fTBLdnBJLMBijVjapxYmAgZe8bsJX1l5u2levZ8BetbAuzBZGNFKLjUHB7/lkG/szC
         rEI8O7ElmoUqB4CdSouWZcDYALC4vyPojmIOr7MtXRE3kVWP0CYiFCCgcyZEAdRfDg3T
         CGciAbl7aOIlrBgRPSFcoZr5sbVDqhAMF1oQ3m9qI3tz6hR7nTAp/I/LW05INNysmczd
         N6tJOclRwCMdD48CrUEJ5n7AfYFsvVf8FFCmofJ3hur9fD20whr1K4BnXj9fJYN9t/ix
         RUSt4Cbg0pVoeEQFvzNi3gypXepmhc8xYjmePtaoTszW+pygqLiMlqHIlwHBgHvdkRV2
         TfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763500210; x=1764105010;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5uJOHo+OfhQyleW150ammZYy3+R5ojMA0+UNXm17SY=;
        b=A9FvSu6Pk9DkngYhnpvxtrjgqKVKHX4HUUnARb767NGvALT4IYTenB7Xp8+bjIcnqr
         roDpA5zVG5uhtCFP6WdQIxd7+nFr0/2U6/btmqdS38WFudU4LgV053AFenMwyEhpw6Mt
         hd7a3vPkuC4geBXHSZoWG+HGEehphAb/e9P97MGZ70fhjhVJjOSPXRO/K3mY5oIoHQdj
         Bt/YhxEauteqTa3Re4BEwqrfXmy2fwzGkd76Iz7uLf7LQhsNNJm9bGS2AEQ5WZpNvvqf
         FHGyVYKMHRLLZd9En/nm3vc/u/a6GTm63aPqo4bCej8nNrg7ruEqWzFCATKTyZZZ53ai
         qfzw==
X-Gm-Message-State: AOJu0YxcM8qYfk7ryeKNAL0SNuRMIiLZGL4C92BCIQ/n4W8FNoCDNJDQ
	iHao5K+k9sWpwHPPdL4I8ENT1Njh3IUsofaywkZASPPkOW1fYd0nLVoD
X-Gm-Gg: ASbGncth7IAyNv2M5kyFzwBdwFEe42ajQeLigHuLzXZ7ze81f5OMju+xXmr17xaMAOY
	MLOZW+bZW89vYm+kWfooKQhRp2FBPPuVdsB6Z+MjgXrIlxEqrUBQkcYCt1amUG8zDSLMxkY5HM6
	sX8ZeTuO3HKvHPnPRicOkRiRHnubSkwQ/5CgNlgjJ+CKJzHS9dSdq4wgI3Sgx7a6j5IsW4O/iGK
	UXCy07nizGFZ2oUs+unZot+cQTylp4J33gc2Zo8PX4TIK3aQtmP7UP3CE7kaVZyZOTVZy15h3OD
	O9u+R91734FReeKYWslcebqtkXEoFy26i2ZdBAPjdpqj1mwlWVtwFRLLZ1IALY50iBgqe3MYuuT
	68GCj+XkaYvHaXHl3GPOGE2+/2+bAcUy4UHyTX3V1o4mn+p3qqtN19v1aZIPpxB2IjKLMPMoYNw
	mj1fWTgm72qsRK3PTld5iMO+J1lGaen2RU9qw=
X-Google-Smtp-Source: AGHT+IH1DDrnnB7Ftv+Q8h6Qsi3yJtkTRG4vjZFMQa/0dJwQaTZCprGCTbk+ne0nQt3jHT+lV1uvQg==
X-Received: by 2002:a17:902:f68e:b0:296:217:33ff with SMTP id d9443c01a7336-2986a74b123mr211842395ad.48.1763500210419;
        Tue, 18 Nov 2025 13:10:10 -0800 (PST)
Received: from Sphinx.lan (58-6-247-80.tpgi.com.au. [58.6.247.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-299daf12fe9sm89578855ad.74.2025.11.18.13.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:10:09 -0800 (PST)
Message-ID: <de12662baa7219b4c8e376a9d571869675a9a631.camel@gmail.com>
Subject: Re: Bug: Realtek 8127 disappears from PCI bus after shutdown
From: Jason Lethbridge <lethbridgejason@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
Cc: netdev@vger.kernel.org
Date: Wed, 19 Nov 2025 08:09:52 +1100
In-Reply-To: <3a8e5e57-6a64-4245-ab92-87cb748926b5@gmail.com>
References: <6411b990f83316909a2b250bb3372596d7523ebb.camel@gmail.com>
	 <3a8e5e57-6a64-4245-ab92-87cb748926b5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


> - How is it after a suspend-to-ram / resume cycle?
This machine is having trouble resuming from suspend-to-ram. I doubt
that it's a problem relating to r8169 however since suspend-to-ram
doesn't work properly even with r8169 blacklisted.

> - Does enabling Wake-on-LAN work around the issue?
r8169 behaves the same regardless of if Wake-on-LAN is enable or
disabled in UEFI.

> - Issue also occurs with r8127 vendor driver?
The "10G Ethernet LINUX driver r8127 for kernel up to 6.15 11.015.00"
from 'https://www.realtek.com/Download/List?cate_id=3D584' builds and
runs flawlessly on 6.17.8. The issue is not occurring when the NICs are
driven by the r8127 module.

Drivers SHA-256:
ab21bf69368fb9de7f591b2e81cf1a815988bbf086ecbf41af7de9787b10594b=20
r8127-11.015.00.tar.bz2

On Tue, 2025-11-18 at 20:49 +0100, Heiner Kallweit wrote:
> On 11/18/2025 6:07 PM, Jason Lethbridge wrote:
> > Hi all,
> >=20
> > I=E2=80=99m reporting a reproducible issue with the r8169 driver on ker=
nel
> > 6.17.8.
> >=20
> > I recently got a Minisform MS-S1 which has two RTL8127 NICs built
> > in.
> > The r8169 driver works perfectly well with these on kernel 6.17.8
> > until
> > the device is powered off.
> >=20
> > If the device has not been disconnected from wall power then the
> > next
> > time it's turned on both NICs appear to stay powered down. There's
> > no
> > LED illuminated on the NIC or the switch they're connected to nor
> > are
> > they listed by lspci. The only way to recover the NICs from this
> > state
> > is to disconnect the power then plug it back in.
> >=20
> - How is it after a suspend-to-ram / resume cycle?
> - Does enabling Wake-on-LAN work around the issue?
> - Issue also occurs with r8127 vendor driver?
>=20
> > - The bug occurs after graceful shutdown
> > - The bug occurs after holding the power button to force off
> > - The bug occurs even if `modprobe -r r8169` is run before shutdown
> > - The bug does NOT occur when Linux is rebooting the machine
> > - The bug does NOT occur when the r8169 module is blacklisted
> > - The bug is indifferent to either NIC being connected or not
> > - The bug is indifferent to CONFIG_R8169 being in-built or a module
> > - The bug is indifferent to CONFIG_R8169_LEDS being set on or off
> >=20
> > Attachments include `dmesg`, `lspci -vvv`, and `/proc/config.gz`
> > from
> > the system exhibiting the bug.
> >=20
> > I'll be happy to try any patches if that helps.
> >=20
> > Thanks
> > -Jason

