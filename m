Return-Path: <netdev+bounces-186255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5ABA9DBF8
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 17:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D90D1B657E9
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95587254844;
	Sat, 26 Apr 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI59ce3a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC012E7F;
	Sat, 26 Apr 2025 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745682519; cv=none; b=MIPui0zELmzhiTZpWhkwQbeGDqD8/a+FY+HFcsHbJe2bG46M7X/ufoZWemFjusBAZ0+ISS64ESa5ZPmCmW4aNGkwbEe4aEMfDNiAQBBVDXywZNqvEJd5xZ7VawpZNsptCzsmdNDcpADiIY8MEU1nixrt8hE83giDJyfnBIQ5yTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745682519; c=relaxed/simple;
	bh=D7+BsCvwekffDanMZF2T90+GFeaexdP5au9UarnNoDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4HGvFMS7FeiD5oI0qon6ygYjIBV0V8ZZOOl/+ahDLHHBoj/4MzppOqjSIhMPQN6DulKiK396rYIl1pon47xgNS9cX0T9jWqHlsqhXLSf4qXINun5RtPwwWVFs8nAe4ipFFeKtbGPU2b9WBNdqhCKWSvgzNDxNFp89LICAi+Q1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI59ce3a; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fece18b3c8so28277537b3.3;
        Sat, 26 Apr 2025 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745682517; x=1746287317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNLsvAARwG2p4RnCwduiH3vXwFOFjsZWcE7ga0IQyik=;
        b=lI59ce3aB0oOMFjC5CI0YsrZbCKbUBS9l/rmOKTF/BFF4a46kvkcp4W721CEX9zKog
         Ih3Ph3kMiSAl5YGG0b4j6KigsZr7vB0uP/exUbbB3+wuwZAqjpKxCQaZ3u50LRDmjhZ6
         QjYk1Yb7ZLJMp6MwbKd8UsqJWKH40BkGr/2g/iZvDxi9Pr3eEAQ8kfjRMyDmiiV1MhgE
         9ZSQFPbGN3zLca9relTdvACEWQ9U6j4dbMpj2CQCdAcwiT1ibrT9VTDGItOp4nNqISbM
         3r68IwvfmFmWHh/2l7pKZYcSSWBE3AFNZhiXyGWL/dm8AqwgNJXkMHCjoLYVd0uDzXcr
         j3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745682517; x=1746287317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNLsvAARwG2p4RnCwduiH3vXwFOFjsZWcE7ga0IQyik=;
        b=Ws/f9iW1nWek6/GIrjnYChDNNwOn15tBJHnFUhpdR0W93c0cgpDu9aSCtzyztGOoUo
         j5eVRDyA47TjdgaSDClj6D0/bzLI3cd7GtHNrgHc7Aj1+o3EHvQXlqYh4CFzH7ZCbWeX
         GgEaglgW37iyGVBxOf8ZX3n/pVJGAWr20UvEsyMIKMwToiCD43UMV4vfJrEcoaias2R8
         y9HO3sBX7xznVMLNrKzzfhcDKbEN//FkKASBHOz5/i7hLA4p2IbaOwoR7O5IacTPI/Ws
         yjWdQ/8+3PFpqMYjgp9TwBKKD9kwp6ltZhnHVzqgpiw0FeRy6Nq3sxoN9eRrwAMtw+jH
         VLNw==
X-Forwarded-Encrypted: i=1; AJvYcCUdGmU2T0+1wnzge2ZU1LeYLn4YOyAYZN43ehfMFZOtKzrT0kat5ysUr81EiXGwQG88SRnNyIqN@vger.kernel.org, AJvYcCXwJmp5lJMfc+0C9Tef/6U2rnH9ktepxpuKNo3b8eG1c7u1gXktHiq+VRT7tW9MHFMvDSAYTr4sHGave4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkarl+/eIm+OBayRCtqU0+UvcdBNynyMARPoyTb6H8CJ0KUqRW
	XCVNCBBEtfTrqh4s7jJt21igIp/scXK5sUOhcPbjZ8FvIgeJ967cBVVQsnSxKexzNvW/9r4tFcq
	pzkMlFXkix0YX8N5QcJBl5rbX2VY=
X-Gm-Gg: ASbGnctgrBI1OPuYApR61fGrL4p6hxx9sQ4lw59aEoaKpKr2DnW0BhUy/8x3LaRp6l9
	PtCOezBoAzlo874wDvGoY1K4jWe4tnwDoC1HjNXKCEgwzWLKp4bAZke72c1h5uVEq/VlplSZBZ8
	OREiauuauamaDPevlVQSY=
X-Google-Smtp-Source: AGHT+IF9i1s//HyT5y2Lq2s5PQXDtgcR4yGyJ0+kGIxgLmhW/Q77TjeNFAQxxZk8r+VTfGANT/c/600+dYAwpfq7gec=
X-Received: by 2002:a05:690c:9b06:b0:6fe:abff:cb17 with SMTP id
 00721157ae682-708541c1140mr82741867b3.26.1745682517018; Sat, 26 Apr 2025
 08:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
 <cf0d5622-9b35-4a33-8680-2501d61f3cdf@redhat.com> <CAOiHx=mkuvuJOBFjmDRMAeSFByW=AZ=RTTOG6poEu53XGkWHbw@mail.gmail.com>
 <CAOiHx=m6Dqo4r9eaSSHDy5Zo8RxBY4DpE-qNeZXTjQRDAZMmaA@mail.gmail.com> <20250425075149.esoyz3upzxlnbygw@skbuf>
In-Reply-To: <20250425075149.esoyz3upzxlnbygw@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 26 Apr 2025 17:48:26 +0200
X-Gm-Features: ATxdqUGQmznP4hBMLQWmQXNnfaB1hJGHCxLwVyLrfmPsgeb0mkyIx7gwQ7tt0vw
Message-ID: <CAOiHx=keOAWqF4Atzqx4VZW+xAccO=WtWCOoVoEPR9iFrDf_zw@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling filtering
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 9:51=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Fri, Apr 25, 2025 at 09:30:17AM +0200, Jonas Gorski wrote:
> > After looking into it a bit more, netdev_update_features() does not
> > relay any success or failure, so there is no way for DSA to know if it
> > succeded or not. And there are places where we temporarily want to
> > undo all configured vlans, which makes it hard to do via
> > netdev_update_features().
> >
> > Not sure anymore if this is a good way forward, especially if it is
> > just meant to fix a corner case. @Vladimir, what do you think?
> >
> > I'd probably rather go forward with the current fix (+ apply it as
> > well for the vlan core code), and do the conversion to
> > netdev_update_features() at later time, since I see potential for
> > unexpected breakage.
> >
> > Best regards,
> > Jonas
>
> I see the inconsistency you're trying to fix, but I'm still wondering
> whether it is the fix that b53 requires, given the fact that it doesn't
> seem to otherwise depend on 8021q to set up or modify VID 0. I would say
> I don't yet have a fully developed opinion and I am waiting for you to
> provide the result of the modified bridge_vlan_aware selftest,
> specifically drop_untagged().

It does need a lot more fixes on top of that. With this patch applied:

TEST: Reception of 802.1p-tagged traffic                            [ OK ]
TEST: Dropping of untagged and 802.1p-tagged traffic with no PVID   [FAIL]
        802.1p-tagged reception succeeded, but should have failed

The latter is no surprise, since b53 does not handle non filtering
bridges correctly, or toggling filtering at runtime.

I fixed most issues I found in b53 and it now succeeds in WIP code I
have (and most other tests from there).

One thing I struggled a bit is that the second test tests four
different scenarios, but only has one generic failure message, so a
failure does not tell which of the four setups failed.

The issues I fixed so far locally:

1. b53 programs the vlan table based on bridge vlans regardless if
filtering is on or not
2. b53 allows vlan 0 to be modified from
dsa_switch_ops::port_vlan_{add,remove} for bridged ports
3. b53 adds vlan 0 to a port when it leaves a bridge, but does not
remove it on join
4. b53 does not handle switching a vlan from pvid to non-pvid
5. stp (and other reserved multicast) requires a PVID vlan.

This makes especially non-filtering bridges not work as expected, or
the switch in any way after adding and then removing a filtering
bridge.

Best regards,
Jonas

