Return-Path: <netdev+bounces-237686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 230FDC4EC8E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE9164E45FF
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173E534250F;
	Tue, 11 Nov 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnr41e1e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F333355033
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874761; cv=none; b=fnsqhfb0y4sRHHNq33AVOdlVN/mzPBCyYZmKVC8FP5JbV4SBv1qTbvGFX58E4RXhXMsXZnTN9t4Sye6Gzv6HFfdSgklmagKu22fDNksaN1jP23M7ihgClo9nSK/0L+pgjE/+QQOAB+VU0KNyIdhEcnrznHKVtDahlx1yRQFCU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874761; c=relaxed/simple;
	bh=GFL/z+mAMfM+rN6KRMvwtyrqWMuq/0oUqc7eMK13QvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHFy2e82mCFIUcs6UmMLLeperM3T591NVDcVnJhzk/NFWDofceWq0LnBIIVj7Y2XLWBMRs/Kn8mHmGdHFrCTBP9YlDDbcQiHzKYdlY9AcVPVzqJftScs7lbFwvRf2R/58NPn2CG6qLkw+h5S2Ioj5aPqizEIVajXRHDOOMz6HGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnr41e1e; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4775895d69cso22693915e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762874757; x=1763479557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eIlBlRtrd1p+0MZfDvGmwpPkD/U37bHYUkIvdxe1/E=;
        b=dnr41e1eoXKAK7vbQ4+LuEwBMwsxpqRCK2O9L61dJ0oBeVBN5uSFZ6+TiK21D7fqbW
         73caZyMBgnW/jjQHqKHf2LvSVrGq4UljdzGvsdO2q5s/vpvNu3rKoX3QtFyDbW9twwm7
         tYIGwmKqFILuL7soI1Kc3vq70p0TKZFyP7LgcrJdQcm+kkK4qsOrKq1qosQZk1tjm/pG
         qJ7Z0xyGFrlcqDAUuZlQacpyMlecYjXFd279PwXlov8oh24/UFKWYBy2i9cXHel4s3hu
         8k6QK0bEeqTHoG9TTTqdInZ+2xmpz3/r3WGas7v44jJF4dwa9iA3LpWoNZCwKDCqOaRk
         QqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874757; x=1763479557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+eIlBlRtrd1p+0MZfDvGmwpPkD/U37bHYUkIvdxe1/E=;
        b=aX42u5qrv0JFlG8vwU1sXQgeJZ2Aiw3mHPUP0vK0JchSd4GO0Gz/BOYAjnC7KU6nVN
         eQcV7w7DtLtHwBBwVlucI3GfiiHX0jUQORTspEWgaaJ0Cqyf6jslglGT/IrUHd9cdAlW
         pmnOnqunmfGcwsrCUAVBhunHyEcmIq0OefCbssq6HKmBrHM/ZR86PSVvaMbWd9ENymX/
         F7Zy8siP/xtIRh7xS2Kb0XMOK1Jorz4VofS+nt58fAiD+TaAzCeWpjbibyQ/FmDJbI5N
         bBlmLPUNs/7vnp/Ts0eD++38zqmBAPERuTXevd91xYwgQYlyaTPJ25xM8Xcb+BUQ6g8g
         AErg==
X-Forwarded-Encrypted: i=1; AJvYcCUq2tjB2hd+TaVMiF8Cq9MDnQIvQMDpxtp0ZI6NkAmIUhtMbYoWWVB6s0NEmVTxfCzaCxKX+Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYV70/6IkAmshtWkgdYY16uVRdCUKMPQdI8Vl67wCqRmzlGJ3
	imc7PGG0F3aTV+nGqLrMXPN6if5ZkEHPqrnwRZAZqPbh5la/MkeftI//1w7ZmkVGFH7EhYTvxan
	CdycY7DXwFNWb6xavwBVZBCrtx5nSPrI=
X-Gm-Gg: ASbGnct+vNTRhh65cME+0RtCr7lf3NhlNvd4GOPvAX+wieVdENH+nQoWjAFcW7B/I1y
	520SIpWbuTG7Ug9CzArod4oWdJ9m27QOZuoaLsYGU6bxmd38HXjI/0Zx+LgE91xUPB8XHZm2R2I
	D3Qmv8X66FWpi3YhzJWTQQbvMUM1aOtn8C005ul8ZK3WiCGKZ/snah7gnxYbxjQ5lzBjYityG+h
	G/C3/dqL84T8PHMU8DwGovjeGBiLV8oyBy77eiSX7dty/WANh4DowA5yCXAQKTn+aJCGFO4v+v6
	T8cinNqV
X-Google-Smtp-Source: AGHT+IFNVrHlhP0Ql13bgsDdcB8lXgcsY0rs+9SGgl/ejSJ1whACt+m7DGFiuz1nodGFp4dmMelD/JHxBtIkiat016o=
X-Received: by 2002:a05:600c:3552:b0:477:fcb:226b with SMTP id
 5b1f17b1804b1-47773230abbmr107163815e9.2.1762874757383; Tue, 11 Nov 2025
 07:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251111091047.831005-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <40e744b5-cc17-4b33-8d0b-1e9987eece7c@microchip.com> <CA+V-a8t5Ac_pb3iUGsQSEiJ_Ji-TrKGr-E6xCJEcx_cK2nKeFA@mail.gmail.com>
 <59e68865-fc18-4180-8e18-91ba78b40118@lunn.ch>
In-Reply-To: <59e68865-fc18-4180-8e18-91ba78b40118@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 11 Nov 2025 15:25:30 +0000
X-Gm-Features: AWmQ_bkAJ4OwXXVvGDL_HW-K6Mcyz8rG5DPp2DppCygHFFbqMH6e7uWDQGK-CEo
Message-ID: <CA+V-a8u1V=vEZz0FVVK6mtN9HyVaDkwdQ7fzFVsoxcbCnLMS0g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: phy: mscc: Consolidate probe
 functions into a common helper
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parthiban.Veerasooran@microchip.com, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Horatiu.Vultur@microchip.com, 
	geert+renesas@glider.be, vladimir.oltean@nxp.com, vadim.fedorenko@linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
	fabrizio.castro.jz@renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Nov 11, 2025 at 1:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Nov 11, 2025 at 09:56:12AM +0000, Lad, Prabhakar wrote:
> > Hi Parthiban,
> >
> > Thank you for the review.
> >
> > On Tue, Nov 11, 2025 at 9:50=E2=80=AFAM <Parthiban.Veerasooran@microchi=
p.com> wrote:
> > >
> > > Hi,
> > >
> > > On 11/11/25 2:40 pm, Prabhakar wrote:
> > > > +static int vsc85xx_probe_common(struct phy_device *phydev,
> > > > +                               const struct vsc85xx_probe_config *=
cfg,
> > > > +                               const u32 *default_led_mode)
> > > > +{
> > > > +       struct vsc8531_private *vsc8531;
> > > > +       int ret;
> > > > +
> > > > +       vsc8531 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531=
), GFP_KERNEL);
> > > > +       if (!vsc8531)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       phydev->priv =3D vsc8531;
> > > > +
> > > > +       /* Check rate magic if needed (only for non-package PHYs) *=
/
> > > > +       if (cfg->check_rate_magic) {
> > > > +               ret =3D vsc85xx_edge_rate_magic_get(phydev);
> > > > +               if (ret < 0)
> > > > +                       return ret;
> > > > +
> > > > +               vsc8531->rate_magic =3D ret;
> > > > +       }
> > > > +
> > > > +       /* Set up package if needed */
> > > > +       if (cfg->use_package) {
> > > > +               vsc8584_get_base_addr(phydev);
> > > > +               devm_phy_package_join(&phydev->mdio.dev, phydev,
> > > > +                                     vsc8531->base_addr, cfg->shar=
ed_size);
> > > Don't you need to check the return value here?
> > >
> > Good point. The orignal code didn't check the return value. Would you
> > prefer a separate patch on top of this series or fix it in this
> > consolidation patch itself?
>
> When refactoring, it is best to not make changed, keep the code
> logically the same. Then add additions afterwards. If something
> breaks, a git bisect then tells you if it was the refactor or the
> additions that broke it.
>
Agreed, I will add a patch on top of this patch (as you have already
reviewed it)

Cheers,
Prabhakar

