Return-Path: <netdev+bounces-231130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11221BF58C2
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0A694E7A6E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881FE2E2F03;
	Tue, 21 Oct 2025 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDn0G5Am"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B728F948
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039525; cv=none; b=f6/9QMXAyziTfAHFZVXUXzvObvm37C0l+STPezTMJMK4+D7xkhAIuQ/eKZERjicVMstjgkOD/qtcMn0/XME0tO5w7m275eYIG/G9x57umUK47FvlGLKUePn9rsNFax8+pJfk7MAoL5E4itiznkKej4kIYYxXLBps9Wai6KEAKcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039525; c=relaxed/simple;
	bh=1jhsxDcrPTMn33f/fW0m2ck1tM2NNjIPKUg0Wc5mgUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koDxQt17J9aIM82y8NRTg7kBOiE7gqcw1NjzmPQFrGm4oiLlSVfYZiGsBNBHtCOfeodxTP7bnsknaJuZMtB/CJp+GruKpi1oltxXyekuJCnzU8k/o18tLXlmXhHND+BT67LL+fE1US+JdSJRgHCeNj0CnCF98Tici3IwuU8Lf5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDn0G5Am; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63e0fa0571fso5102398d50.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761039523; x=1761644323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1eeVQ9VeQ+8eDNx7wVtovhJZK8MyMI+d0uyJgtez2M=;
        b=bDn0G5AmodAsFCIPLJOzOUAm8duN7xSajTOAiZG9ToeUmZS32BBx8P9J3kd60qvj5H
         rflAmsfZVNlySGQ3VZQ10AU8GjpNdstpNkXoe+prXndYi/mxSwyIi6oUmQ5dzO2zkb1j
         7Bi2wFf5xkgMhsVQw+vsa8v/b+9wyAv/pfBrNrFmKTHZB8h6wc2zocizQrBhIQkw0ZdB
         S8KqEItn6tH7rGY2h4DTJqwe0Wk3CaFfay5ZR4IIb6fPMy7ZYwVyXdwqU/K4td2fJugF
         XunM+FpJZ6HSVzZfAzTL01YbgD2hrmoGnCZu0d+ENc0JNu4bk9JBfLOUsZyWZrDbXJJy
         gwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039523; x=1761644323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1eeVQ9VeQ+8eDNx7wVtovhJZK8MyMI+d0uyJgtez2M=;
        b=JOJwePs0Ok9zfKyHYt1LKJpJV4CIlYgXtcSE6l+1dljJ/yjtrUsLa9Wj07KknXx269
         Ba+SZY+3L/YIFpmQtajGnRs6nkbdIeoHl/Lv2XDzInR21CksFM4gZJJIUTZDWSsvhqjo
         JQYqifc8cNkzKbWvusqxI3GIeSN0/uu1eYyrImfeQ9qK5Djd3CArTxRTc6O7pEiRnC3Q
         uxzISPXLI38LwIOeiatEsc/S2o/c7z6fDYBCSNtz1oBGlZBSjMO+HWGEvb16UpWoNs6W
         zYvQkUZ+XsV05WvTjaj6hLkfWiQAzL9hZUIt0dK8ojb+CPCIRR9DYsInr2A1C0yk6fV9
         BuWA==
X-Forwarded-Encrypted: i=1; AJvYcCVugslRPXAw3tcVn8lQxtiMPfme11aU7G8aKqaIxzL3x9fMioqOYTUIjIs9iDG3dAS0jab0vWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygDy53m7q7ED8tbzF9pYJu9pZPJhG4GVjFOvu3FwSRMSIecl1L
	sDFTcBZ7fR0kRhkWluY61dnntIa/IQ+sc3EUnAv1IcXOcfScl4KlBgmT70LO6W6+Mij8PgZyMGz
	JD1O4j8yeLqgBj485bsPRa7oMLU2cTDA=
X-Gm-Gg: ASbGncurz2alN/rln9SuFCK4OC9OCLcq9kgoZT4Mv/PPdavZ5IcOPLwyo2GukpOTBe3
	SRvWd/fhOqhJs0wzLCxE5FoKWESJxfCQbSqZvD3WaNAwDx3u0+GD8epqPxq3vubu9LRNs0J/r1a
	lLdlH8MvyIKBZTfMjwJLNgfSZmE5ZHDiHjO/yv6+BcUV7HBuBHpF4dOLWmZDQeohdRb9Xl457Bc
	AEJc20kYC5rhgaR3cHUImfYKhaM4R3s8XDTuChm9rE6vCPamTY8w5EJg6I9pBnCb+0SvQ==
X-Google-Smtp-Source: AGHT+IFz8xZwydVmNj/TCSyMRnVEbcbJWu9Ym6Id+aYRdcCUbHyds3ytSGmbdU0cQBCvOCLLDzUcDsEaxAdV8+G4B18=
X-Received: by 2002:a05:690e:1406:b0:63e:4927:72ff with SMTP id
 956f58d0204a3-63e492777b9mr2222613d50.17.1761039522747; Tue, 21 Oct 2025
 02:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015070854.36281-1-jonas.gorski@gmail.com>
 <aO_H6187Oahh24IX@horms.kernel.org> <CAOiHx=nbRAkFW2KMHwFoF3u6yoN28_LbMrar1BoF37SA=Mz4gg@mail.gmail.com>
 <aO_PMWQlv0DhHukm@horms.kernel.org>
In-Reply-To: <aO_PMWQlv0DhHukm@horms.kernel.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 21 Oct 2025 11:38:31 +0200
X-Gm-Features: AS18NWAt-sNEZKvoBVjhcEcyf8gYc14VQDS_M46xD0Xr09bsTyEc-j3O-PJtf70
Message-ID: <CAOiHx=mbd-JND4XR9FkARa0b6gGS0BXJwuAKSP_gVO48m00ZWg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 6:43=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Oct 15, 2025 at 06:24:33PM +0200, Jonas Gorski wrote:
> > On Wed, Oct 15, 2025 at 6:12=E2=80=AFPM Simon Horman <horms@kernel.org>=
 wrote:
> > >
> > > On Wed, Oct 15, 2025 at 09:08:54AM +0200, Jonas Gorski wrote:
> > > > The internal switch on BCM63XX SoCs will unconditionally add 802.1Q=
 VLAN
> > > > tags on egress to CPU when 802.1Q mode is enabled. We do this
> > > > unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configur=
e
> > > > VLANs while not filtering").
> > > >
> > > > This is fine for VLAN aware bridges, but for standalone ports and v=
lan
> > > > unaware bridges this means all packets are tagged with the default =
VID,
> > > > which is 0.
> > > >
> > > > While the kernel will treat that like untagged, this can break user=
space
> > > > applications processing raw packets, expecting untagged traffic, li=
ke
> > > > STP daemons.
> > > >
> > > > This also breaks several bridge tests, where the tcpdump output the=
n
> > > > does not match the expected output anymore.
> > > >
> > > > Since 0 isn't a valid VID, just strip out the VLAN tag if we encoun=
ter
> > > > it, unless the priority field is set, since that would be a valid t=
ag
> > > > again.
> > > >
> > > > Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy ta=
gs")
> > > > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > >
> > > ...
> > >
> > > > @@ -237,8 +239,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct=
 sk_buff *skb,
> > > >       if (!skb->dev)
> > > >               return NULL;
> > > >
> > > > -     /* VLAN tag is added by BCM63xx internal switch */
> > > > -     if (netdev_uses_dsa(skb->dev))
> > > > +     /* The internal switch in BCM63XX SoCs will add a 802.1Q VLAN=
 tag on
> > > > +      * egress to the CPU port for all packets, regardless of the =
untag bit
> > > > +      * in the VLAN table.  VID 0 is used for untagged traffic on =
unbridged
> > > > +      * ports and vlan unaware bridges. If we encounter a VID 0 ta=
gged
> > > > +      * packet, we know it is supposed to be untagged, so strip th=
e VLAN
> > > > +      * tag as well in that case.
> > >
> > > Maybe it isn't important, but here it is a TCI 0 that is being checke=
d:
> > > VID 0, PCP 0, and DEI 0.
> >
> > Right, that is intentional (I tried to convey it in the commit
> > message, though should probably also extend it here).
>
> Thanks, I see that more clearly now.
>
> > If any of the fields is non-zero, then the tag is meaningful, and we
> > don't want to strip it (e.g. 802.1p tagged packets).
>
> I guess there are already a lot of words there. But, FWIIW, I would lean
> to wards tightening up the comment a bit.

While I can't send patches, I can at least send emails at work:

How about:

"The internal switch in BCM63XX SoCs ignores the CPU port's egress
untag bit. We use VID 0 internally for untagged traffic, so it becomes
tagged with VID 0. Fix this up by removing the tag if the TCI field is
all 0, and keep it otherwise."

Best regards,
Jonas

