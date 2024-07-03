Return-Path: <netdev+bounces-108950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7EA926555
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B7B2825C0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02235180A73;
	Wed,  3 Jul 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="ZWnpA0W1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC717995
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022195; cv=none; b=m87c4k14UGtg+yR8X2LX9sOrOeB4jydxKPLY+3G/cXerdylm8q/wToBBW0ESc3C2akVShhWpHsI2IZOFWRF/J0vQob420ec67zWOQSeOsLYXXLmqcLCZcQ39Z75l1maLvS4E/Hmsc6DG6Yd2FYpuOxBFriufqe72vuA9TbI+Ps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022195; c=relaxed/simple;
	bh=b7b3ChY7fLDdQjDHDmI4MweWVvWIStxsLUCdG/eJ7Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Shwq/Y+7onRnz2wY14zLkdIjNRkR0pkBkRfZNsVybpPRAunfenObiaKY8SsFZMsLgBZjotoa7C1mBrxdA77sXXROpIigqRqnB8WZp5rVNKRnJp+pqM4INerAhpMbDPG/gPPvisUGPfIchUPu1ozvc6H+J3MZJHIdUkHBLnqV8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=ZWnpA0W1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so3585284a12.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720022192; x=1720626992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ett/R1hY+Pi1TBBkmfPzpg2IBjH4+ALsPeUiojlvVcY=;
        b=ZWnpA0W1c8gpQHQa5j2XXomabY0YBWoc5LikM5Zi1vuYUA7dSDZn1HCciwdBbIDhTL
         CI02OmF7UCx1iWDZHhSeEv42ziWdcrGivqMhYufP3DcTlqQjn8l2fl/EF0UbSLqIiOCs
         GBhZTKZk7EYkXbtl6VIlx+t07mivhku3JFzYUgclBsWhRrZmuylZsTucJMptld5gf4H4
         6VuJmBf1ZcV3C2BzcoyPpY93/Gsbn3SArna4f3tB73rUdKT+0vXxahCL50eitIrWvQ+R
         fYLiJAf6icGO9arPuR4k6LK8UIsFPGDakyLk7R12EZWdyKnRUWxghyfWpoyfwRBF8/LJ
         qszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720022192; x=1720626992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ett/R1hY+Pi1TBBkmfPzpg2IBjH4+ALsPeUiojlvVcY=;
        b=Cy3BLEo/2X89Zmwq5w2MjoxNpY45fGGNnweOgO3xsRGoy4sTEoRPWiyoDL+GA/7kXs
         mZ9NQP+v+L6Pi3m9TPcZd1OJiA6Oe16vs5uJ5bnCzu6X5VXB752YNtWg/if9Hq3+IzE1
         LI25+We5XyIBMzmEmSZW8p/g1nybAmqoKyMGkethdVnn2cEbjAnmhF0B/ZiGRRN8pYN6
         M7HDvKLh9XGtJN1IqrvTB7uMworcNhvCVTYmMBxv6GTaQduH5VnLaLnLj08BWzOtgSy5
         lbICOGTPG5l2ajJ/2mbcexicJDIQyiBaxawqylktwA1tHyc6bVq6U4IIyIq0TZ86IAP9
         /BMA==
X-Forwarded-Encrypted: i=1; AJvYcCUHDUNjghyOikznndbWM+fzaBaXuIguGBKceqIoQhClH0OFoAX0XMbEeQfClNrnn6wswyEJN7unUOrYr7TK18YjqaZrFgfM
X-Gm-Message-State: AOJu0Yy/BwrQfxtgzdyhoA/bX8VqONnM8fa05X8JzG6QnC/cQj34Ip3g
	SRxPp+XNEx50N+Dc2K5AhGhHEA+ZqpzFdMhkwft/v/ZOByrfTp2RYE3LIf/2OqzWZFYKiAkhMy6
	4DPU++HKYn4dJpaQ6n39qDH0rQEpP8HfYpUlD
X-Google-Smtp-Source: AGHT+IFfK1ZIQLrVVoKDCORhQzgUNGbdJTm6tK7OahCEF8HPDXuvx1opnbcX5YzI5M48BewroW1Q6DPGAjgS6SYnJNA=
X-Received: by 2002:a05:6402:78e:b0:58b:9df0:f9f0 with SMTP id
 4fb4d7f45d1cf-58b9df0fb22mr2682905a12.39.1720022192074; Wed, 03 Jul 2024
 08:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701195507.256374-1-tom@herbertland.com> <ab3e6312-cf67-47bb-b30f-d425f7914053@intel.com>
 <91496a94-1648-b69d-e014-65868aca3a78@intel.com> <CALx6S35zhg8HAUj9_1=Zm=nV0mzSe-Batdo5qpjz6Zd4G8T17g@mail.gmail.com>
 <d362d083-e0b2-44fe-8bbb-5a0286ace230@intel.com>
In-Reply-To: <d362d083-e0b2-44fe-8bbb-5a0286ace230@intel.com>
From: Tom Herbert <tom@herbertland.com>
Date: Wed, 3 Jul 2024 08:56:20 -0700
Message-ID: <CALx6S34mS=v3A4mmuHeKoeyjYLb0wJfMe=ZrZ9-BF=ntu1kmTw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] drivers: Fix drivers doing TX csum
 offload with EH
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "Greenwalt, Paul" <paul.greenwalt@intel.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>, cai.huoqing@linux.dev, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Felipe Magno de Almeida <felipe@sipanda.io>, 
	Justin Iurman <justin.iurman@uliege.be>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 8:03=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 7/3/24 16:38, Tom Herbert wrote:
> >
> >
> > On Wed, Jul 3, 2024, 7:20=E2=80=AFAM Greenwalt, Paul <paul.greenwalt@in=
tel.com
> > <mailto:paul.greenwalt@intel.com>> wrote:
> >
> >
> >
> >     On 7/2/2024 3:31 AM, Przemek Kitszel wrote:
> >      > On 7/1/24 21:55, Tom Herbert wrote:
> >      >> Several NICs would seem to support protocol specific TX checksu=
m
> >     offload
> >      >> and allow for cases where an IPv6 packet contains extension hea=
ders.
> >      >> When deciding whether to offload a packet, ipv6_skip_exthdr is
> >     called
> >      >> to skip extension headers. The problem is that if a packet
> >     contains an
> >      >> IPv6 Routing Header then protocol specific checksum offload
> >     can't work,
> >      >> the destination IP address in the IPv6 header is not the same
> >     one that
> >      >> is used in the pseudo header for TCP or UDP. The correct addres=
s is
> >      >> derived from the last segment in the routing list (which itself
> >     might
> >      >> be obfuscated so that a device could even read it).
> >      >
> >      > feels like there is a missing "not" after "could" - with it
> >     added, reads
> >      > fine (not a request to change, just being verbose about assumpti=
ons)
> >      >
> >      >>
> >      >> This patch set adds a new function ipv6_skip_exthdr_no_rthdr to=
 be
> >      >> called in lieu of ipv6_skip_exthdr. If a routing header is
> >     present in
> >      >> a packet then ipv6_skip_exthdr_no_rthdr returns a value less th=
an
> >      >> zero, this is an indication to the driver that TX checksum offl=
oad
> >      >> is not viable and it should call skb_checksum_help instead of
> >      >> offloading the checksum.
> >      >>
> >      >> The i40e, iavf, ice, idpf, hinic, and fm10k are updated accordi=
ngly
> >      >> to call ipv6_skip_exthdr_no_rthdr.
> >      >>
> >      >> Testing: The code compiles, but is otherwise untested due to la=
ck of
> >      >> NIC hardware. It would be appreciated if someone with access to=
 the
> >      >> hardware could test.
> >      >
> >      > we could test intel ones (except fm10k) via @Tony's tree
> >
> >
> > Awesome! If you need any help let me know.
> >
> >      >
> >      >>
> >      >> v2: Fixed uninitialized variable in exthdrs_core.c
> >      >>
> >      >> Tom Herbert (7):
> >      >>    ipv6: Add ipv6_skip_exthdr_no_rthdr
> >      >>    i40e: Don't do TX csum offload with routing header present
> >      >>    iavf: Don't do TX csum offload with routing header present
> >      >>    ice: Don't do TX csum offload with routing header present
> >      >
> >      > sidenote:
> >      > our HW is supporting (among others) a GCO check-summing mode
> >     described
> >      > as: "Checksum 16bit (TCP/UDP) with no pseudo Header", but we hav=
e not
> >      > yet provided patches for that, and I don't even know if this mod=
e
> >      > will be used (CC @Paul)
> >      >
> >
> >     We will be adding support for GCO "Checksum 16 with pseudo Headers"=
 to
> >     the ice driver. It will be off by default.
> >
> >
> > I'm not sure what that means.
>
> IPv6 Routing Headers render (simple?) HW-offloaded checksumming wrong,
> but not for the "no pseudo Header"-checksum. I have no idea how such
> checksum will be useful, and we don't have plans to implement it, so
> this is not much relevant. But that is just one mode that you could
> config our (new) HW.
>
> > Can ICE just provide checksum-complete?
> > It's by far the simplest, most robust method with the most flexibility
> > for users. :-)
>
> sorry, could you please elaborate?
>
> Paul will implement GCO for ice and otherwise my understanding was that
> our checksum is fine. Is there a room for improvement?

Przemek,

No, there's plenty of room for improvement :-). This is protocol
specific checksum offload versus protocol agnostic checksum offload,
and the opinion of the community has been clear for a long time:
protocol agnostic checksum offload is the preferred method and
protocol specific checksum offload is deprecated. This is true for
both transmit and receive checksum offload. For background see Dave
Miller's presentation on this from 2016:
https://www.youtube.com/watch?v=3D6VgmazGwL_Y.

Protocol agnostic checksum offload isn't just a to have, it addresses
many bugs in protocol specific checksum offload. This patch set
addresses one obvious bug, but there are others. For instance, in IETF
there is a proposal in spring WG to do SRv6 without a routing header
that would make the checksum incorrect on the wire. This will break
protocol specific TX checksum offload and there's nothing to key on in
the packet like an RH  so that a driver would know the offload will
fail. I'm really not sure how we could fix this without major surgery
in the stack. Use protocol agnostic checksum offload and it "just
works" (the proposal to purposely send a bad checksum on the wire
without a RH is a bad idea in general, but I'm not sure we'll be able
to stop it in IETF).

And not to pick on the ICE driver, but please take a look at the
function ice_tx_csum. This function is called on every packet just to
evaluate whether the device is going to be able to offload the packet.
Basically, it parses the packet on transmit to make sure that the
device will be able to parse the packet (this is where we need to call
ipv6_skip_exthdr_no_rthdr). This function is 180 LOC! If the device
properly supports protocol agnostic checksum offload all that is
needed is to write the start offset and checksum offset into the
receive descriptor. Maybe there's some checks on the offset values,
but I can't see that needing more than ten LOC--  it's much less
susceptible to bugs, more robust, and works with a much wider set of
protocol combinations.

BTW, this patch set is the first in a series to formally deprecate and
remove protocol specific checksum offloads from the core kernel. IMO,
we've waited long enough! My intent is to remove CHECKSUM_UNNECESSARY,
NETIF_F_IP_CSUM, and NETIF_F_IPV6_CSUM. (note comment in skbuff.h "New
devices should use %NETIF_F_HW_CSUM to indicate checksum offload
capability."). Helper functions will be provided to support legacy
devices.

Tom

>
> >
> > Tom
> >
> >
> >      >>    idpf: Don't do TX csum offload with routing header present
> >      >>    hinic: Don't do TX csum offload with routing header present
> >      >>    fm10k: Don't do TX csum offload with routing header present
> >      >>
> >      >>   drivers/net/ethernet/huawei/hinic/hinic_tx.c  | 23 ++++++++++=
+----
> >      >>   drivers/net/ethernet/intel/fm10k/fm10k_main.c |  9 ++++--
> >      >>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 22 ++++++----=
-----
> >      >>   drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 20 ++++++----=
---
> >      >>   drivers/net/ethernet/intel/ice/ice_txrx.c     | 22 ++++++----=
-----
> >      >>   .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 28
> >     +++++++++----------
> >      >>   include/net/ipv6.h                            | 17 +++++++++-=
-
> >      >>   net/ipv6/exthdrs_core.c                       | 25
> >     ++++++++++++-----
> >      >>   8 files changed, 98 insertions(+), 68 deletions(-)
> >      >>
> >      >
> >      > I have reviewed the patches and they conform to commit
> >     message/intent,
> >      > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com
> >     <mailto:przemyslaw.kitszel@intel.com>>
> >      > (for the series)
> >
>

