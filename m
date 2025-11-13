Return-Path: <netdev+bounces-238387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB0C5805A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F9663548F4
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2035C275AE8;
	Thu, 13 Nov 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVIpqsSv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A9274B53
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045149; cv=none; b=aaUN7QyQUot3O0UPrwtAvL+5HT+dIrw+BVb3RJdEin/fQfkE6kxdvlhedDNgTN558BkXiVaLhsJ5eEk0m+h4Q4614jy8Rvj5spXGtfgeDeNDnIxi2HcE4AyKCmKPmppObb8+OyBNOH4km57IHKUKNknegwdzsZbnxqm9OGJ1bZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045149; c=relaxed/simple;
	bh=wkSkDdoPDv5abLWccGMVUsi8SiiC/MW5NOpVlGRUPZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjJkL2swZETaxN4hxEe9d/4yK6z+aA+KYjV6tvTwM/qPcOHK/upv48JKsXKiv7A5+hLPooJJueOdFAiS/4ELw6Vs30g7xdMw6iI9SkBjayeBhaUq1uSOqtBAQiakH77DQratfS9MbFrdNZ+9115M9BeJ6evRNb2AweSU/TNdI0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVIpqsSv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b312a089fso541655f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 06:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763045146; x=1763649946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcRSJSxeIXWTFrXDIzup6ZeaZadWQ/5Lk5RiitzeLH4=;
        b=BVIpqsSvB50OcnCbWraQraDCbbOhVax6pDyqrYc4XFvWXjw/xRSUej7kIZ9U5YMWoK
         NYecwgrGAaBowAUPvzsqIBFS66OLswZutjtZ3naz1XDiy0rEnma6DL+8bE8j7ZE791zz
         ytj8sDAfy3bv8vkjzQMBMQnNhsDsDvGIVdi2Plvlq7/t3R7TSlF8O3IvE18kBSXBCiwZ
         q2sQwHCHsf/xEXkMmFpFx/xHvpTUfGGTj5xkqx9kv0WxLHMtKua1KZ0P1Iszm69/iv2j
         X2MuLriCKfqRiBgP8b6j2OEc/gPgzmHQ8bxcGTZvJecJmu3E7N8AXP6icE2Hsf7Tp+Sz
         WiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763045146; x=1763649946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcRSJSxeIXWTFrXDIzup6ZeaZadWQ/5Lk5RiitzeLH4=;
        b=DpE7v0YrmfoaIsEThEs/QLoKRTZpVHoWCaW8ViUgWYTn16CRf/p7shmRp1EoG3S5C7
         CgbxfelZOaIrvgh2Fcv2sQd+tuXXScCMyHinglXtfTGiaPneIyE2eaOyemK5kJ+mADSI
         /T6vCNcrSWUeMA7sv8UzxUeL2vg6u4ZS24K0BKfFKQeDxN02URtdaSQUtV3rtR2vrso7
         jg3SYGcMQLW2qgFol4ZPnB/UUIRPV8SZa253jcp9YRe+PKmSrrQc2Fo4nj1la00P5cdI
         OTS80ju/J7vUfOwAPJDrI0LNObrcc5eukCGURWbzD6hBRdhhlp7x4YhrBXe2vmgiRuBN
         eqhw==
X-Forwarded-Encrypted: i=1; AJvYcCUTnbwxaxPjMnjpENG8Zu0D9Uwz7VKVRzhtDCD7MbHd7tOiGaIiC9fSxcQa3gK9K0A4paIG+sE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7BRffWV+/JtGcC4B1Bv/wq6hB5DzmnuZEIggDFxhXgT2LHpc0
	mP8FKa1gLsjTUn8trmOtbVPv7QWxK7y4y3zlqgdyVVCWtXF2PF52lUBp8Tb2Wm+dLLSBAAqPmMc
	jJDpcFvD4DSWz52jck32aHVHOj1PZs0A=
X-Gm-Gg: ASbGncvaKwRs8dTSGFKRxrjP9EzrsZhzTW02d6qw1kh1mmnozckIayNMSQhLAv3D2E3
	RB7l5S1Dy0n7kfVL+WiIgtfOHvIt9hZgs4I4WXaZKydLVuUIkHNDjKQKXzF/bOm4PqVxaXzVvJV
	DfQwiw/M69SW0m8wJ4gCJbj5bn5TIfmwU/DhOy9onY5ksZt6q3idJ2lB9YvpE5/E986SZ6Zdf/k
	AaGkzUS/htYtlzHIHkTSNmkGsy3wAIECfskA+bibt7BH4xR/ZX8dkBO5QirszQejQ9L6SMsDGCU
	B0Bfkfk=
X-Google-Smtp-Source: AGHT+IHqzyBfuyBH24NabztQ2ac7uK3iOL3WFKk1OzQ++QqYz3fMB5HSm7GretKLA+fjTkvrDt20ETT5xK536jmvZdo=
X-Received: by 2002:a05:6000:240b:b0:42b:3131:5433 with SMTP id
 ffacd0b85a97d-42b4bb9464amr7328317f8f.26.1763045145342; Thu, 13 Nov 2025
 06:45:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112201937.1336854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251112201937.1336854-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <aRTwz5QHq9U5QbQ-@ninjato>
In-Reply-To: <aRTwz5QHq9U5QbQ-@ninjato>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 13 Nov 2025 14:45:18 +0000
X-Gm-Features: AWmQ_bm1n4yocnFoXMuN117YgsRe_Rw2NkyCDDLKQDlHn-tEP1dQHcHiTprnds4
Message-ID: <CA+V-a8s5fg02ZQT4tubJ46iBFtNXJRvTPp2DLJgeFnb3eMQPfg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: pcs: renesas,rzn1-miic:
 Add renesas,miic-phylink-active-low property
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Wed, Nov 12, 2025 at 8:40=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Prabhakar,
>
> > Add the boolean DT property `renesas,miic-phylink-active-low` to the RZ=
N1
>
> Hmm, we already have "renesas,ether-link-active-low" in
> renesas,ether.yaml and renesas,etheravb.yaml. Can't we reuse that?
>
On the RZ/N1x we have the below architecture

                                                      +----> Ethernet Switc=
h
                                                      |           |
                                                      |           v
    MII Converter ----------------------+      GMAC (Synopsys IP)
                                                      |
                                                      +----> EtherCAT
Slave Controller
                                                      |
                                                      +----> SERCOS
Controller

Each of these IPs has its own link status pin as an input to the SoC:

SWITCH_MII_LINK: Switch PHY link status input
S3_MII_LINKP: SERCOS III link status from PHY
CAT_MII_LINK: EtherCAT link status from PHY

The property "renesas,ether-link-active-low" is specific to the AVB
IP. The MII converter enables connections between these IPs, and the
register for controlling the link status signal is part of the MII
converter block, so this property needs to be part of the MII
converter.

If I have misunderstood you, did you mean to rename the property to
"renesas,ether-link-active-low"?

Cheers,
Prabhakar

