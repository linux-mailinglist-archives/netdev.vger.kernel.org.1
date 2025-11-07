Return-Path: <netdev+bounces-236884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D59C41629
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 20:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F7BB4E0598
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 19:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB9299ABF;
	Fri,  7 Nov 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBOoZTIl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8278D2405F8
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542485; cv=none; b=kkoS5VhNJXcqa4Gn/XQApoTZbfmFfV7sLO22hdc+SZyMevgCOy9XovOxZpOuHnhuTyaeJlbsCm6Sjs5TIrX1yAPHoxfg4smc96HqUjph/zcYLXZEfrsLzP7vGn0tzPDAGX8QMtwIPB+JA/+wHRO1gVYCT9KCbTni6LOGy0tvCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542485; c=relaxed/simple;
	bh=MuBZP8MilDi4Gj2oBSNAsYRQG+qSraPH+CQlzY8+SX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExFzdTWXz39XIeHLl+oXBFKZbMpFadLBADGJkDKrxlMK3X6blorivN0j/aqbMwA5CRNaWH2673LIfBgnU4aAuzpv+zx+zO54pIACCH5EXfQWjkz8sM37YRSjK6Xmtk10xReDOh1IZ6fwcxysPu9AdDdTBFirmKpNPH/cxpd9pns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBOoZTIl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso802542f8f.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 11:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762542482; x=1763147282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98zvSpFCtfYwCinbIUvtgjWS4ALtY9Ez5M7RcM4hjuI=;
        b=KBOoZTIlt0sBXlcrgIFcBW3T/mCeiIHTuomyYB9F66PALpzgNoSilVBG7HHnkyDbNi
         w/n9ow+WBQFNV/lqJEgfqVM1uFSvkFLD5V2KWN4b7Cm/ah0IMmsCxboeEk1V/T1/uP7I
         O98+4ZjWnjkB7ky9mXO9E4YLaGpP6e79IShrYplD/UDnu9nsdZ3hXEEh3/cqhTMxBQXw
         zobx96IImIypPTH94H0hG4QCwxngxNw4XJ7BNTG2LyCYvZES17l4yNtgFLEymFXQiyer
         hXZlurfClMkqixTaU0T4wKrFlkQXteeMWB0kiIZlDgLQ/UwBiqBUAQeA1VNmUtrNJaC3
         p8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762542482; x=1763147282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=98zvSpFCtfYwCinbIUvtgjWS4ALtY9Ez5M7RcM4hjuI=;
        b=lpvc1GCerM7nEbfJBFt5aLRP1bb4/zmn7ghbOwhkzBDprDNmXNZrBoi76xUVCA8g/C
         FvCi1ZoTA9zWgQBvFZ2oRm4F11FNAKtc2VC6UWm61u8XNC9LN9ENts05x5X9fPcBXTox
         sqILkfz/0XisgmOIIenA5Z56RQ7mSq5Cw2nFZXBgrbkc9xP/rfPXhfTrLCBCLkKQuWhn
         Ng5XREGJv9pkq6LuFn8Yznu/5iXy2E8ESjlMKBPhuRdFeVJ5OrrGDj+scJFojsJaKlPg
         UF1NKMvJ3kcl99wqnUglxNYLoH3Zy24eQgRF9vgCjRtAZy8vGKLEpXRemuJ+BIDVAPpd
         5NgA==
X-Forwarded-Encrypted: i=1; AJvYcCXPpA00MNx5G6I6+6enm+Z1mtqMo0z9zFZ3aeWR+TfgwRzS4+uSlQ4fQVi1pBt3qhNZIN8/V/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuATszh0xmlzJwzeYEg/RHv48agVfzawkHhheC3MfDyIXeV+WP
	5LO9lQNZ66DOBgiXK4LCRZz/S3ne6NLsJdd/pZt8596C8alUNVe+K5SwxtYDOF0k6LKWttMBLuB
	Y70Tjy0i15HOKk8e2NnKafbzRxnWU0gw=
X-Gm-Gg: ASbGncviN4rXAgcMDsQ9MxSGCfTYKPoEwgZJLR8soreFoQb6C8ETdinBcwuLsx3ocoL
	MlyjkMXAkfmUgOeQddCqMlQwCcjTnqQE/CBLxm4qpODMJJ+GKTiISoX9PGkY0s2BkTSjwCTlHwS
	MZzdPeRoc4PemD9VmS5jYCVxWfD+Cb15zx8dMinJwXlc4sU1HGoqDmMkKBqgpZ2xYMb7aUuRHGL
	IDoz09OCFGk7qcu3156FqCNvb67xlTT4OI3sWuLkq9tDKYqnPYHq2BcMDZzm7pOeU6eD1c=
X-Google-Smtp-Source: AGHT+IGeu/C5nKxUEoqKP5CHhmYruwz+Zclh/0ohVNpebUeE+OB52cvd+J6tlYQsRrJkRSHRmix1kjqDzuIObLwa6pU=
X-Received: by 2002:a5d:598b:0:b0:429:ca7f:8d5b with SMTP id
 ffacd0b85a97d-42b2c6722a4mr481943f8f.14.1762542481691; Fri, 07 Nov 2025
 11:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106200309.1096131-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ee6a79ae-4857-44e4-b8e9-29cdd80d828f@lunn.ch> <CA+V-a8vFEHr+3yR7=JAki3YDe==dAUv3m4PrD-nWhVg8hXgJcQ@mail.gmail.com>
 <2dabb0d5-f28f-4fdc-abeb-54119ab1f2cf@lunn.ch> <CA+V-a8uk-9pUrpXF3GDjwuDJBxpASpW8g5pHNBkd44JhF8AEew@mail.gmail.com>
 <caef6e6e-b81e-45d7-ac92-ed6adc652aa2@lunn.ch>
In-Reply-To: <caef6e6e-b81e-45d7-ac92-ed6adc652aa2@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 7 Nov 2025 19:07:34 +0000
X-Gm-Features: AWmQ_bk5YqHCcSmLZVSPz9ezwcQ4t-xeg_QDOZGrptN0Qnu8s-fuKHyuOslw6UI
Message-ID: <CA+V-a8vj7d1wsTVYMrh2KpAoOjvF+1-WPNijsOLQ--DwPQG-og@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: mscc: Add support for PHY LEDs on VSC8541
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Nov 7, 2025 at 7:01=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Certainly the probes can be simplified into a single function. I'll
> > create a patch for this.
>
> Please do make sure of each device having its own .probe
> pointer. Don't have one probe function with lots of if/else
> clauses. Put what is device specific into a device specific probe, and
> what is common into helpers.
>
I was thinking of having a cfg struct  for common probe, something
like below and each phy would populate its config and pass it to
vsc85xx_probe_common().

struct vsc85xx_probe_config {
    const struct vsc85xx_hw_stat *hw_stats;
    u8 nleds;
    u16 supp_led_modes;
    size_t nstats;
    bool use_package;
    size_t shared_size;
    bool has_ptp;
    bool check_rate_magic;
};

static int vsc85xx_probe_common(struct phy_device *phydev,
                const struct vsc85xx_probe_config *cfg,
                const u32 *default_led_mode)
{
    struct vsc8531_private *vsc8531;
    int ret;

    /* Check rate magic if needed (only for non-package PHYs) */
    if (cfg->check_rate_magic) {
        ret =3D vsc85xx_edge_rate_magic_get(phydev);
        if (ret < 0)
            return ret;
    }

    vsc8531 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNE=
L);
    if (!vsc8531)
        return -ENOMEM;

    phydev->priv =3D vsc8531;

    /* Store rate magic if it was checked */
    if (cfg->check_rate_magic)
        vsc8531->rate_magic =3D ret;

    /* Set up package if needed */
    if (cfg->use_package) {
        vsc8584_get_base_addr(phydev);
        devm_phy_package_join(&phydev->mdio.dev, phydev,
                      vsc8531->base_addr, cfg->shared_size);
    }

    /* Configure LED settings */
    vsc8531->nleds =3D cfg->nleds;
    vsc8531->supp_led_modes =3D cfg->supp_led_modes;

    /* Configure hardware stats */
    vsc8531->hw_stats =3D cfg->hw_stats;
    vsc8531->nstats =3D cfg->nstats;
    vsc8531->stats =3D devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
                      sizeof(u64), GFP_KERNEL);
    if (!vsc8531->stats)
        return -ENOMEM;

    /* PTP setup for VSC8584 */
    if (cfg->has_ptp) {
        if (phy_package_probe_once(phydev)) {
            ret =3D vsc8584_ptp_probe_once(phydev);
            if (ret)
                return ret;
        }

        ret =3D vsc8584_ptp_probe(phydev);
        if (ret)
            return ret;
    }

    /* Parse LED modes from device tree */
    return vsc85xx_dt_led_modes_get(phydev, default_led_mode);
}

> > > Also, is the LED handling you are adding here specific to the 8541? I=
f
> > > you look at the datasheets for the other devices, are any the same?
> > >
> > Looking at the below datasheets the LED handlings seem to be the same.
>
> That is common. So yes, please add it to them all. It does not matter
> if you can only test one device.
>
Ok, thanks.

Cheers,
Prabhakar

