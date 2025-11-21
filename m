Return-Path: <netdev+bounces-240878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48FC7BB38
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A803353F43
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6923302748;
	Fri, 21 Nov 2025 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFJ8GWOk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C441241CB7
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763758766; cv=none; b=gHi3cdCMLyBVQaZkGdktbi24dg/767CebozTL/sJpTNkRY98L5f8p8UVhhC3UidrmOSgAxlCrRBm50pqqHmNP/y4R+nENyrsooySpqfI4SIVcUEq5e6siSObtM2h0oBG/iTsSbITHGJCRzfvEBTGbbjYvnoJOu3TD+aIIXzyxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763758766; c=relaxed/simple;
	bh=bBtrX5EFPZEAZC522dfsiRzfYQSbHJajcuBGnynMbnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2x3LvScKeW4Rl66YtypBFjNMUX6qPwJMvFoF6h7iovrFvDKgF6oDdvTPzD4FB8iYn+hQwOPytvI1v6/KpZLwSX32FX5waA8a2Yjz2FkQmRazPNc0noc/eOO3Vj0rqAIW4l8oU7ulOuoyzsVQbWqCFLoPPa9EAzLCJ+o6/Xlvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFJ8GWOk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso1598099f8f.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763758762; x=1764363562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ompreuHERq3FUSzaEPD4bpaAyYj0ejhMujXL9v1zCZw=;
        b=fFJ8GWOkqO76wiHeLrfhi1R4l+ekOuSLspy9BonAi1ZLEf1F6cvleCrXa6MM1oC9vD
         qVu1uCWcFUnI0y+ehgxpf6DzkgPAjklBcmD4BdDOkxWmvqcTZeJwXTbnF9WdCH5y5MIn
         EH+sI4G0iDH4q36c41RmLpCN5cNbMFQdIv4wlUfuUmndm3ICLCJp3p+FpfVXrQV8A+Lb
         A+zgrJPMuHBgq5NmAmB0TQPBwVdtDeJo59j/1O/8Iuq+Mx6203/QE0thPBwI0nShwrsG
         Iof61ZQRulBH1GDiyANFiuxoycymqBbuUis3AmxoLRvRwKV0b8ItAMeLfOQfYc3dyPzA
         oHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763758762; x=1764363562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ompreuHERq3FUSzaEPD4bpaAyYj0ejhMujXL9v1zCZw=;
        b=morrmgTT9jaygP2RrI7n4ZmkKqjyshkhI7o+n+qlax8Pu5XGPTzNsQ24fyVkh6Obi/
         hUaUXYQwRCG43kibvFDu+C0AoxjMSNp1tapgtyhYyHw6+IwKgNp/3iHdSRpujr7AMAE5
         dOm6ytyrDQCRlzxMxFKtmcNR9kd2Rw5ktvps6Gkk/N8eHtKUjijvXgASU48cGP6DeEWn
         kvSUhjdMey5Nm+Q7ruTPqa77mbKaFin9O/MYRlPQotWVUJXslP+zYGF9qDNFx4UyFLD6
         7NKsfs0LZVKJh+XwKGyI9VuoRgQzvICPbomOT/z6DKbyKc9f67lTE0bPBEW9V20x1EyW
         8Gag==
X-Forwarded-Encrypted: i=1; AJvYcCVOxNKDkISRJzxEqmw1ASGm5VJoXmoIZ42EUqdz9rpbwUWSBrpnlYc+ONHk62bLNLhM+5eFV7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWtEYgnskgeURAFkad+Kzrpq1GRxYTX1Ur4ae2x5lCZPTKF3P
	7HQTgwu/bwQIy87KEGDWLo+UCOwRPqzQPS/k3AGQPSUGAo5D+CDapf91VfA97b7uHiXsZPyLLKR
	H8CzWuG1XIlIwd/rZm/q9xo/M8pq436Y=
X-Gm-Gg: ASbGncsvy1h6So+2+ztH8iJQnSL8qBx/iNlQHc6fFzAtSpCg6doBHppfTKJ5ewKwzMf
	DorUllTElZGLzafJjI9EKIpAhPbW6AbiRQim+gLNnMS4XFtc0ux0CVnKXkajktTD1Cf6KNtb6G6
	Chi5NW2gsTSZsgMMarXoTW85uWK6yI4vq0nVb+m4I9Ah1D2egpjbvC5YCGfc8ZU5fgWEHN4cLeX
	tOJ1dfRPnX5O/Zu1UWRmU8ezSJ2YQNCf2CxnzRiq9ljCpSKcJFbkAvqwcm9PZVvorjUHVGjcYqe
	xl7NSfOqbN8wMLyOLFBAX8EFZw1ltuNsH39m3bU=
X-Google-Smtp-Source: AGHT+IEJnYj9tzPgEsH3/YX9J7g70T3nquwHQesZI2rg877VbuY1O9Me5EFeMIoOkC9QXWw8tDigW182DhTgyFQOpFc=
X-Received: by 2002:a5d:5e01:0:b0:42b:3e20:f1b0 with SMTP id
 ffacd0b85a97d-42cc1ac9b39mr4097573f8f.7.1763758762231; Fri, 21 Nov 2025
 12:59:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251121193002.hzjuijrs6gtoibuv@skbuf>
In-Reply-To: <20251121193002.hzjuijrs6gtoibuv@skbuf>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Nov 2025 20:58:56 +0000
X-Gm-Features: AWmQ_bmUNeZEWkWbeRP4C_Eo6_UYOxEcRWlNLuxLNTPKm97Sw-9WbzKrfrrXu9I
Message-ID: <CA+V-a8sWzBsnO6vNFirPJCT=S=jMDO1uw5HhvN0kQ2PpvumJ-Q@mail.gmail.com>
Subject: Re: [PATCH net-next 03/11] net: dsa: Kconfig: Expand config
 description to cover RZ/T2H and RZ/N2H ETHSW
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

Thank you for the review.

On Fri, Nov 21, 2025 at 7:30=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Fri, Nov 21, 2025 at 11:35:29AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Update the Kconfig entry for the RZN1 A5PSW tag driver to reflect that
> > the same tagging format is also used by the ETHSW blocks found in Renes=
as
> > RZ/T2H and RZ/N2H SoCs.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  net/dsa/Kconfig | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> > index f86b30742122..a00eb3bdcd0f 100644
> > --- a/net/dsa/Kconfig
> > +++ b/net/dsa/Kconfig
> > @@ -159,11 +159,11 @@ config NET_DSA_TAG_RTL8_4
> >         switches with 8 byte protocol 4 tags, such as the Realtek RTL83=
65MB-VC.
> >
> >  config NET_DSA_TAG_RZN1_A5PSW
> > -     tristate "Tag driver for Renesas RZ/N1 A5PSW switch"
> > +     tristate "Tag driver for Renesas RZ/N1 A5PSW and RZ/{T2H,N2H} ETH=
SW switches"
> >       help
> >         Say Y or M if you want to enable support for tagging frames for
> > -       Renesas RZ/N1 embedded switch that uses an 8 byte tag located a=
fter
> > -       destination MAC address.
> > +       Renesas RZ/N1 A5PSW and RZ/{T2H,N2H} ETHSW embedded switches th=
at use
> > +       an 8-byte tag located after the destination MAC address.
>
> I think the device names are sufficiently strange with that forward
> slash in them, that you shouldn't make them worse with the {}, at least
> not in the full help text, and spell them out instead. It's hard for an
> unfamiliar reader to know which punctuation marks to take literally and
> which not to... (plus it makes it more difficult to find through grep)
>
Agreed, I will add the full device names.

Cheers,
Prabhakar

