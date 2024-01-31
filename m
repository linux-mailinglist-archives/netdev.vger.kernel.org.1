Return-Path: <netdev+bounces-67432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3491843637
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 06:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD1E28ADCF
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 05:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F42917BC8;
	Wed, 31 Jan 2024 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAkwwoW7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF63D993
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680262; cv=none; b=Vdq1XBOspN5igm0qXAgMa8Lhjx2FP0Hc1iFdiHtTRjPEotii9VPXFbt3Mk7sFcJOeYhmWx2HrI4ZEl6dw+6wihunGoOYqc3bfP12ryyAWKTktoqVkkMHUn2e7gkwnTXIXNn1EstenXYyT/VcW93o27UKHPr26CNjVTidRShHb38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680262; c=relaxed/simple;
	bh=KCEYRxaW7LgDoVooIEDy4x5qQykkv5+g07a+4kjdiBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaLMb8rhcMGWuZdkjAyfmwbgF3Cz09z32FuRfCZ44Icf4xUvMH1DzpW673x/bd724e0ba9cA3qVWiRMCppPnzU9Vzjhm8LNdzvtkvKhSn15uzCSSGdPKB6bLs0fYPgRk/R8bTwCdyIvFNLXmEXQ4gwZr8MsJfanoLceW3kAOiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAkwwoW7; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6a631a90dso1125923276.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 21:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706680259; x=1707285059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n+tB8ymIuc8RamlUDmXRrewDyPxJulXwL9EERYeP0A=;
        b=DAkwwoW7JxDiKcp5pN4kVEnSK6py7VqAHdKh3Kvv/clUoABXXyUxi+8bEW7hnxfwGa
         UUw6WikmDwWom9ICE0STI8LS4cBmTL/bin6sD2HIbElCyNqBt0fuc7iAaLF0FInQjl6D
         HSryYiu9YD2h5CuInZ5J7jWvwllZ4dkIpoZCkrkZgtUECWXRORlwSZOADRO9Px5n4rjX
         OcHRWdQT02Y7dxgi3X2rORDN/GGVCk6fwOcKHiydpMtFt7DpStgw4RBPiHUCZtTZJbEV
         G6g94pql8AW57SsK7q0SivYntmDUD2Ghfi2jufJAp6QedvMHJ/cgrGRU8xJsfPkVfrdR
         X8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706680259; x=1707285059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2n+tB8ymIuc8RamlUDmXRrewDyPxJulXwL9EERYeP0A=;
        b=BDQKS5tW8nPWTZWJDjNpimOFtAuC78nuSbSMdCRhS4s9PWx5m6n6ML/pBYKLhI/Uau
         KW/QsnmJkdWA+ftqz1jKVk4mXtqUhxTjPvdcnOU0DTs8OWJ1OirKdUk173zuiu6KT9D2
         VHnzWAyCN+4El04yP69/y4JmUDL6H2KfNADtP52XGwOmDHouO9LFlegk3IvjixPkhOFJ
         Hyym/ZcA3E1CE9qc6GvT4n4cRQd4ZymBbnVnvZMbPAcK4LN68ycg4nxX/O02ai4VnDUM
         r+VxVJkwG8zZHLLZGgdSOi8MYHxXPHkGKg3ZRLjoT6W1b10/lPYc0nanJDkkpt30fliH
         Hufg==
X-Gm-Message-State: AOJu0Yzrk2QrdArrDzxUIgSF0teD7z9aO8+kOSfwmM8rOKtBswLOCdbX
	rlQ94fwRNy3IqGnA5iNMdjnKhMG0tHSbtjOU3Jhbxn+LRePQdz379VqZ/9I7euzzVVUnx1/jwsi
	xWVtNqXLGnWSxmPnNxX3/vJlf5SE=
X-Google-Smtp-Source: AGHT+IFohLYOPObHhK/R+8wgT+d//p0AsSBesf2Wjre9grqlBf3azRjcjSdvhW1eN8S4V4aBKffOpk8Q5qlOd4hg3mc=
X-Received: by 2002:a25:ad4b:0:b0:dc6:b121:d00c with SMTP id
 l11-20020a25ad4b000000b00dc6b121d00cmr784866ybe.16.1706680259579; Tue, 30 Jan
 2024 21:50:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125035710.32118-1-alexhenrie24@gmail.com> <2c2e4c0e5c0413c9697b8924d6ccae8fe357ee74.camel@redhat.com>
In-Reply-To: <2c2e4c0e5c0413c9697b8924d6ccae8fe357ee74.camel@redhat.com>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Tue, 30 Jan 2024 22:50:00 -0700
Message-ID: <CAMMLpeT_19VjoUZ=zAogPcXU0-auUOn43YMnN=XCfvHQL60QsA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ipv6/addrconf: make regen_advance
 independent of retrans time
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, dan@danm.net, bagasdotme@gmail.com, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	jikos@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 3:46=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2024-01-24 at 20:57 -0700, Alex Henrie wrote:
> > In RFC 4941, REGEN_ADVANCE is a constant value of 5 seconds, and the RF=
C
> > does not permit the creation of temporary addresses with lifetimes
> > shorter than that:
> >
> > > When processing a Router Advertisement with a Prefix
> > > Information option carrying a global scope prefix for the purposes of
> > > address autoconfiguration (i.e., the A bit is set), the node MUST
> > > perform the following steps:
> >
> > > 5.  A temporary address is created only if this calculated Preferred
> > >     Lifetime is greater than REGEN_ADVANCE time units.
> >
> > Moreover, using a non-constant regen_advance has undesirable side
> > effects. If regen_advance swelled above temp_prefered_lft,
> > ipv6_create_tempaddr would error out without creating any new address.
>
> RFC 4941 has been obsoleted by RFC 8981, which in turns makes
> REGEN_ADVANCE non constant:
>
> 3.8. Defined Protocol Parameters and Configuration Variables
>
> REGEN_ADVANCE
>    2 + (TEMP_IDGEN_RETRIES * DupAddrDetectTransmits * RetransTimer /
>    1000)

Ah, so that's where Linux's regen_advance formula came from! Thank you
very much for pointing me to the updated RFC.

However, according to the formula defined in RFC 8981, even though
REGEN_ADVANCE is not a constant, it still must not be less than 2
seconds. So unfortunately, it still seems that Linux's current
implementation is technically in violation of the spec because it
doesn't add the 2.

> > On my machine and network, this error happened immediately with the
> > preferred lifetime set to 1 second, after a few minutes with the
> > preferred lifetime set to 4 seconds, and not at all with the preferred
> > lifetime set to 5 seconds. During my investigation, I found a Stack
> > Exchange post from another person who seems to have had the same
> > problem: They stopped getting new addresses if they lowered the
> > preferred lifetime below 3 seconds, and they didn't really know why.
> >
> > Some users want to change their IPv6 address as frequently as possible
> > regardless of the RFC's arbitrary minimum lifetime. For the benefit of
> > those users, add a regen_advance sysctl parameter that can be set to
> > below or above 5 seconds.
>
> I guess we can't accommodate every user desire while speaking the same
> protocol.

Linux already allows the user to reduce regen_advance to 0 by
disabling duplicate address detection (setting
/proc/sys/net/ipv6/conf/*/dad_transmits to 0). Disabling DAD might be
a protocol violation, and setting regen_advance to 0 probably is too,
but I didn't want to make it impossible because I can see people
having good reasons to do both of those things.

The bug I'm trying to fix is a different scenario: It happens when the
user wants to rotate their IPv6 address as frequently as the protocol
allows, but not so frequently as to break things like duplicate
address detection.

> Perhaps emitting a kernel message when user settings do not allow the
> address regeneration could be a better option?

The fundamental problem with emitting a warning is that when the
network parameters are set, the kernel might not know that there's
going to be a problem. The network could work fine for hours or days
and then have a period of merely a few seconds when regen_advance
swells above prefered_lft, at which point the kernel just gives up on
temporary addresses. The kernel could print a warning then, but even
if the user is knowledgeable enough to look at dmesg and understand
the problem, unless they disable DAD to make regen_advance zero or set
prefered_lft to an excessively large value, there's no way for them to
pick a value for prefered_lft that is guaranteed to always be greater
than regen_advance.

The fact that regen_advance does not have to be a constant and there
is no hard minimum means that my original patch that was in 6.7-rc1
[1] and reverted in 6.7-rc8 [2] was essentially correct, it just needs
to be fixed to respect the maximums that are checked earlier in the
function.[3] But if we want to add a 2-second minimum as well, I think
I need to send three new patches:

1. Move the calculation of regen_advance to a helper function and add
2 to the calculated value

2. Add a regen_advance sysctl that corresponds to the number 2 in the
formula, to allow changing it back to 0 or to any other value

3. Clamp preferred_lft to the minimum required as originally intended

Thanks very much for the feedback and please let me know if you have
any more thoughts before I get cracking.

-Alex

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D629df6701c8a9172f4274af6de9dfa99e2c7ac56
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D8cdafdd94654ba418648d039c48e7a90508c1982
[3] https://lore.kernel.org/netdev/20231222234237.44823-2-alexhenrie24@gmai=
l.com/

