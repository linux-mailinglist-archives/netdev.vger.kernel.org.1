Return-Path: <netdev+bounces-229678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7A2BDFA31
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F2814E8E53
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A58A3375AB;
	Wed, 15 Oct 2025 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAOl7XQD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6826B764
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545487; cv=none; b=XdhRfXLFQ0r4YmQxagdoLA5IEzWJpk2VZke+fH2pDfgxVeN+kNuZwXm/RsrdoGW4Dy9+XpzyVDmBlZ5dyrIkQoZfAa84+GyN6eOjVsV/ylLYwaI8qVpD9G/f5ehx3T0qeJlrU6FLUdRxQdMeBn3sZ8lB3eZ/JCXCawqk2OSXd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545487; c=relaxed/simple;
	bh=5dmSHYaCSlL5DE484eUuB+gCCkzOeT/39M3pRYLgteA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOD8QCqM2cyiqX2WzpEcmDxsXAfqSVkx5J6w2d7rbpxY+TaUqhfiPOqNbViCEBf7dwGTpL8Qa0EKQ1vgcUAIJRW0ySEXcRPXoeXqy6AjRTeB7/OUp7os8hNiS2tzUErUtcxbvjQsXx+yvRI/JyGwXfxrinUHoVSKOTJIWMlxYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAOl7XQD; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-633be3be1e6so1764721d50.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760545485; x=1761150285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oca03mfHwwbupYnaH4z5NUyICPNpnwdM0yH9k7Bfwcg=;
        b=MAOl7XQDi3AWkwANc8dyL7U63h+UtqUWw8xFTDn7nJByDOsiDC4vQrxN5yA3wpRwsp
         JMvLV5Dr4aZ2EA854j0X5ESnKYySJOFknY+t7frXKP6Emyc45N20Vk5azF2OPjLSfFHS
         q0bWJmyr2WcACk3aKQWXsj4+pZCNAJuxpod1b79XP+EgmrX0i+Md8vRWYGk3xdHDWAmY
         0hRp9fN2dbtNBXj8r2bWksC7Utm6DbSZ1DIeXE0fNV5oHIph5LIn7I6AK7tveXN7pPWC
         kioGNGVe6ChXPg38lnMUw8GpSobvYFa6HRuN3Vf0xkYxMxLoMxrZjSOmOr+4SKhG7SZa
         bf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760545485; x=1761150285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oca03mfHwwbupYnaH4z5NUyICPNpnwdM0yH9k7Bfwcg=;
        b=jeMVdIwRlay6jhwcdoQqi97k6R+xipKMdMhyLuXbmICoFuyxhwQQ773ZIpLwU5VZBN
         dUMhRv+QCLGkZnUJkw45+8OxkDdr4zGfb8dkUgK2D49f2lY2EbyzVUl2tKpbz0fq9fNi
         i5aXbrKWNwXnBRpa4oyS77Vo0jROcgSSq8Y32FAS/TX8mpwMnkt5hrZg8uV5hJttm+bO
         VJMDiMwrF8aVWt3f3fJ2UQ8vD9s2Fn+0jkiO2/Jh10nsUDsMTITfV5jtfnbb+a9U5ACk
         yRZkS9KweROsNFw6Q06CzAHRtMEW5kQtFWJRtyzqarLAVM5hIGa+2L4Z55pyiGgZ0TN5
         o8qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe/BfgueJ0KgwhznSEBT2zFH+cJH9DpR2Rcp1hfGCGokazuKvrv83N3fhQ1b+sWxujgbTtzF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSX11MW22Gwc0x8hUbabAf1yi8Ie8iNv1S4uvL7Obskv11ydLB
	nUvJqajpqYRGbS5IwmgRlNKIaRJySBwuckG9ETjOXa0ALaKF8NPEVBFIRA4xXOuUmU6FZAH2Doo
	pZ7zxaB6f/P7V8+W7u/q9Wj0Un7p/wD1AowLl
X-Gm-Gg: ASbGnctTq3+CClsByUgpIl8wtXgg9YqciFmzAr7GFqvuZZ4cZ9Xc8zJ/4ZU/czq4+GP
	8tGL3NyMrOOTxh5USkSGmqNRgYQb/CKlBTFdlRmN6YzZoNj8AZ44h/vs7cMXYxqdqqhBLuU0NNL
	tGDy3mD8UeMa5RVUSSptdP3gTelpWO8nYtAy+AXi4MjTJUsza6beTehwCSsU8qU8McROExr2Cn2
	o0oWGPwRKRFhjVQ6GOtC++a
X-Google-Smtp-Source: AGHT+IFfqn8fLPcF2mb1gVi+G41RV2YT7DE1gzY6TrJFfSruChGkTvfZPHEqftOuvKHznTZtaSaFI1V7ACaXcJIiywE=
X-Received: by 2002:a05:690e:108e:b0:5f3:317e:40af with SMTP id
 956f58d0204a3-63e08fd5e43mr308137d50.19.1760545484844; Wed, 15 Oct 2025
 09:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015070854.36281-1-jonas.gorski@gmail.com> <aO_H6187Oahh24IX@horms.kernel.org>
In-Reply-To: <aO_H6187Oahh24IX@horms.kernel.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 15 Oct 2025 18:24:33 +0200
X-Gm-Features: AS18NWB5lthoC5h8fYZc_CEg6WuMBx-FRcGPGIiwRRyZzUYMwsRaOF117HRUBPs
Message-ID: <CAOiHx=nbRAkFW2KMHwFoF3u6yoN28_LbMrar1BoF37SA=Mz4gg@mail.gmail.com>
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

On Wed, Oct 15, 2025 at 6:12=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Oct 15, 2025 at 09:08:54AM +0200, Jonas Gorski wrote:
> > The internal switch on BCM63XX SoCs will unconditionally add 802.1Q VLA=
N
> > tags on egress to CPU when 802.1Q mode is enabled. We do this
> > unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configure
> > VLANs while not filtering").
> >
> > This is fine for VLAN aware bridges, but for standalone ports and vlan
> > unaware bridges this means all packets are tagged with the default VID,
> > which is 0.
> >
> > While the kernel will treat that like untagged, this can break userspac=
e
> > applications processing raw packets, expecting untagged traffic, like
> > STP daemons.
> >
> > This also breaks several bridge tests, where the tcpdump output then
> > does not match the expected output anymore.
> >
> > Since 0 isn't a valid VID, just strip out the VLAN tag if we encounter
> > it, unless the priority field is set, since that would be a valid tag
> > again.
> >
> > Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
>
> ...
>
> > @@ -237,8 +239,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_=
buff *skb,
> >       if (!skb->dev)
> >               return NULL;
> >
> > -     /* VLAN tag is added by BCM63xx internal switch */
> > -     if (netdev_uses_dsa(skb->dev))
> > +     /* The internal switch in BCM63XX SoCs will add a 802.1Q VLAN tag=
 on
> > +      * egress to the CPU port for all packets, regardless of the unta=
g bit
> > +      * in the VLAN table.  VID 0 is used for untagged traffic on unbr=
idged
> > +      * ports and vlan unaware bridges. If we encounter a VID 0 tagged
> > +      * packet, we know it is supposed to be untagged, so strip the VL=
AN
> > +      * tag as well in that case.
>
> Maybe it isn't important, but here it is a TCI 0 that is being checked:
> VID 0, PCP 0, and DEI 0.

Right, that is intentional (I tried to convey it in the commit
message, though should probably also extend it here).

If any of the fields is non-zero, then the tag is meaningful, and we
don't want to strip it (e.g. 802.1p tagged packets).

Best regards,
Jonas

