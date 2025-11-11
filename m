Return-Path: <netdev+bounces-237527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0270C4CDA2
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CE714E88FC
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC40E2EDD72;
	Tue, 11 Nov 2025 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUKPSIUM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0FE25D527
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855002; cv=none; b=SK1gI8ro5Ap8oqn6NcR5qkoqMUwXBQNmKOqDnR994pxVVwB4/jcq+6nE8x8r+eK+zNKfOomMpMAoETMJN8muRVW/75/takkYCXBNfFCVfYaqQppYnV8Qc7+8f6Ee4a1rqV4ihw0/tH3VRFwzx8vVyvSMwWDnxM3fOzJu1OdOXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855002; c=relaxed/simple;
	bh=jkgc5+vd53UiZCxhNe3hI/jvAtzcUQj3f4ZwiPIU3CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6QZaVKBDorurPQu4JedVvHW7u2Aa8UGcUti6J4Vs32ehfnPL8TPoP6AE6xl2hh1gd5BxE2Rau9mGnDhh+rtnLxfgqnUFZKZwIt2echqQGPD6m5gQNbe5KRrS5E5cBZPRhKS1LQd227rMAZWz5nHmhpWIa+KW+qXwOYYSgEjK5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUKPSIUM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso18250215e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854999; x=1763459799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=old4NHpZNRQlq5F/NJ7Wd36OkosNtO/noel5lfu80nM=;
        b=iUKPSIUMbkcVBQ6J9sWiyhEhXn0A4LRUn8lWuQymCcLXcgqBqAxpWaOc5h8AUvmZht
         VcJAs88YIQYae9CXNl14OFoKW8gbFe/J5AXZhB5pZ7sUf9WNKbyCqJ+KsIj9L+qIjqMT
         RMuhxV+3qxWr6kZOHNZsVNhmltHE1U/0PGx9G6aqG1SyHI1wsuhCtDGcDcrhvQhxim3S
         z8m9GdunEecY3xzehoiDUCpN8VUfb1KSD13yiqBxrmsRjwX/NnL6Qmt1252+FOEJ+6n9
         UmP2kWLq97X0tBR7w/0tn28CV8dwK7EZ7OAbGPRwdAfSyW5SCO+lrDnoVeED9ZWFS3aD
         iCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854999; x=1763459799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=old4NHpZNRQlq5F/NJ7Wd36OkosNtO/noel5lfu80nM=;
        b=hPVk5ftVHHpkLW0UQopTnhQnNn0fVqlpMAgjC/0zGweZn62jrQGnA15ukX4vYrF2hV
         sIlBw52/UI3XA4WT2yNSwajZULNo7WB3piccJV/RehdpZo6Sw2fXGLRBSQ5sANYpxJKT
         NmJzgk3HYrEwL+toGmmUtHPB6HONxtHbvjuRC30VAo4P0/PZaNzwe1Ko4S0qM+6SZSRO
         addnlwmRliNM29e1NVN4e67NluXaJJkCqHQSRb06QBw4E3RqIj0wap2JDHbKnZzPhCFp
         ODP+T+dxmlxwvDIdqoJeRkSYaTl14vSv9nhPujRukiesPIEtyRTBnRt5THTusnDm0NKh
         Bhjw==
X-Forwarded-Encrypted: i=1; AJvYcCVSt1vIiOt5pzlKyXjxu1q2L6JN3lHBapH++8brQ+y+SisjAoioGvKnJ0xUT25ZBKGDalvUDw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCvJInZxWlHXGvMwOXq/w3q1SMwd/MKFryKZtAppFVbQv+Y0iS
	p7NFplbxTURYxJomfbyQ9T+/v0ezkYuME5yMii0pYVRT8gaLBUeu5wTdooopgACTk04LKfLBMzr
	bHuOEuL1k/Y52tUm0ICxsrTg1ZFdK0lM=
X-Gm-Gg: ASbGnctcO7L+LhhR4b3ZuTb3iSIlhwj+Y9qzGzEcX0Hnm8F1N2w9wqyz9pXBLehP5UR
	7Sv4LBJV0W8NeD6NTbceNZFhElEdWduu5HDv+hliUOn4+OtJP8x9k6jkgFF9Kb+GZmWzzSTt0CL
	CSn0wbP61Yj1GhK9rjDoBySnYN/IGSoE9GTyXSx9IK5vyY3bwLUDCelH/Wbs6s9fy33aOFMBBXi
	8253JRWRkC2zbjHklQG87Jj2CYqG2LngYFgB/relYcx8perqSaNfHhqZX5D+gWoJwzNZ5/K
X-Google-Smtp-Source: AGHT+IF7qpKo+MsmIWpLUty6mew6BjAdPBm9lIre8k2/Jvv5ZucJOwY+zC+wLimhZNmUnrg5eMJyJxNj/dIokpZI+F0=
X-Received: by 2002:a05:600c:1f1a:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-4777f4a496bmr40099395e9.1.1762854999316; Tue, 11 Nov 2025
 01:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251111091047.831005-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <40e744b5-cc17-4b33-8d0b-1e9987eece7c@microchip.com>
In-Reply-To: <40e744b5-cc17-4b33-8d0b-1e9987eece7c@microchip.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 11 Nov 2025 09:56:12 +0000
X-Gm-Features: AWmQ_bluZAgbO3v-1VvKVux1F4V0OMKz7MOCbUQ70QEf8OgOn18rDwQSq7RXXHM
Message-ID: <CA+V-a8t5Ac_pb3iUGsQSEiJ_Ji-TrKGr-E6xCJEcx_cK2nKeFA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: phy: mscc: Consolidate probe
 functions into a common helper
To: Parthiban.Veerasooran@microchip.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Horatiu.Vultur@microchip.com, geert+renesas@glider.be, 
	vladimir.oltean@nxp.com, vadim.fedorenko@linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Parthiban,

Thank you for the review.

On Tue, Nov 11, 2025 at 9:50=E2=80=AFAM <Parthiban.Veerasooran@microchip.co=
m> wrote:
>
> Hi,
>
> On 11/11/25 2:40 pm, Prabhakar wrote:
> > +static int vsc85xx_probe_common(struct phy_device *phydev,
> > +                               const struct vsc85xx_probe_config *cfg,
> > +                               const u32 *default_led_mode)
> > +{
> > +       struct vsc8531_private *vsc8531;
> > +       int ret;
> > +
> > +       vsc8531 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), G=
FP_KERNEL);
> > +       if (!vsc8531)
> > +               return -ENOMEM;
> > +
> > +       phydev->priv =3D vsc8531;
> > +
> > +       /* Check rate magic if needed (only for non-package PHYs) */
> > +       if (cfg->check_rate_magic) {
> > +               ret =3D vsc85xx_edge_rate_magic_get(phydev);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               vsc8531->rate_magic =3D ret;
> > +       }
> > +
> > +       /* Set up package if needed */
> > +       if (cfg->use_package) {
> > +               vsc8584_get_base_addr(phydev);
> > +               devm_phy_package_join(&phydev->mdio.dev, phydev,
> > +                                     vsc8531->base_addr, cfg->shared_s=
ize);
> Don't you need to check the return value here?
>
Good point. The orignal code didn't check the return value. Would you
prefer a separate patch on top of this series or fix it in this
consolidation patch itself?

Cheers,
Prabhakar

