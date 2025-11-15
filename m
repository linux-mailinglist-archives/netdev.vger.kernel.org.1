Return-Path: <netdev+bounces-238890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF96C60BAB
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 22:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BCEB35A8B4
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 21:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5272F6188;
	Sat, 15 Nov 2025 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/RX29eu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CDD2BE7BB
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763240513; cv=none; b=P08Hy0xGI+d0vmqPbexR3kE5e6briHYp3Q/FNW8SMdyenFd6OKrOJCcHdmOfr2zrir4N6LHJW0swEh/RKBmbjn1N2FQo2W7XeVm5AwC8e5dEOtvdnaEu8KCDUCVcx/h8+lWVpkwXZEb3+mK67OMKcX39qAJVflzoMyYFjhjGxfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763240513; c=relaxed/simple;
	bh=vg3gbestzVXx0SThS5/X0QDmDfhe6au3myuFItq7V7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKmS7aWE0w/nGe28pyBIp/hm9GDFZGXz9pBJoyz+xR95LDEXopJC9/tRdQ3aHdm+0euvPGFQ8gVAxUNqWNVif6M0OxKypFDsWSMDDHcxfKldbtElL2EHOgXiNxsYPK5wE5rs7CVTVB+/BzTwvSlpwfGJT1AuJeTtCMoANhDEJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/RX29eu; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5958aa58d25so671245e87.2
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 13:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763240510; x=1763845310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eOqhJe7V67LuZ9x4q+dQgJYcSjs+Um3FJGGzYuOEgg=;
        b=A/RX29euQY6B4Tof0D1fw1PAaFDw9/IZY2XF2LzyasNIuidqRiFH6Djxe2+dXm4eJh
         OecqcGX0TBlnL/KmqyPZ6jm6VMIVXUGxz0Woe7ivQqYl8OXIAD8ATOgUIZT3FcQrn/FP
         6/S+WKAgrpVR0PpI2N5CObd2vVGjm7Js6hIN19kk6zJjODflERv/LVXBd52p6nlQYkPC
         xa9RWgzRYubnkAMm89bp47TmyaxChwZAIQ20SSBUsL1PxisuyzGY3rsgp7rcJcbib6/W
         1p7v2d249pnIcSVFZYA1B4HsmU6AoPK36Dbd+TiZ2czOp56FFwwk8oxxB/JGAdv6OPhT
         QmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763240510; x=1763845310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0eOqhJe7V67LuZ9x4q+dQgJYcSjs+Um3FJGGzYuOEgg=;
        b=WYo97aJy/MoPnzlVS8oCd6Ui/lS5ehAR6v1t0xX3TVWbplWGQ7Srg0XU8s0ODerawY
         uSBbp9rMBt9o5HEVdSxiF7TT0pdptwDafz+aP19hx6sgiTsZXnkAyGuC7XWvmOdGVbcH
         M4wUlMmqbGjLE+05Y88I1Aj1mQ0zUbHt+tSwi9kbANCX7hHhzaOIIUkuJyX0zjm5tLCK
         DCQ8GddcpVXLZrR2eIwHTwtBgN1qXtu29u6PkeX8ACrdq6FoGiOe7JcwkycslAUdCOZR
         rIq+G0bLh8r++L07Ti6hgjhCaXtlzsYd7b36CdW1QATfGSPzqxzgMKR3TVViQBoYGdCO
         fBxw==
X-Forwarded-Encrypted: i=1; AJvYcCW00oBPNwy741o73hB8GuCGCssNbRgQogC9/dxL5Ao5scWt/SKPaWdEANc4jXAOxmz3m7+a/IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQW1KyvbhNAFm71GC2dmvECe0nwpiTKYG9s3eSajiXokHcTx0
	uHkLV9InDJj1e2KBDi+Vg2ckuOAuP37y8dGufFEyV0thuCZ03leVgTBxykxKwqrJ9JQvGGrJPvI
	d8dECNyh5uHIl9aQ/sITWhzk0Gl1sFXE=
X-Gm-Gg: ASbGnctjvbXiGSRRUhqrDDvQvIkJK4Hx3cKQmfOqSxzhZImw6hvPTAha4LOerVMMAEp
	Kegnsj6clWon8iFqjF0wDWVcK7V3qk+SwRN2C/Ju4ANYAK0C8w9BT1NTM4NtT/nWiSzlaOrQ+rF
	3WcpB4P9DJ1G0tzAPYhNl7ukqejDZa6Gcgg41d/ripNaOYCSUaXzOQHxp2yfLZFBSKP0j5boY/h
	5Zy2X0U4bj6RzwpClQcRoc1MaPBlFKyfwjGmLRn3bamPz+13oKZca54oWMYkEom2GvB3y6s4b3f
	tZe1q9Dt7j0RSoVArC4ick85geUtUgnAN0KWZQ==
X-Google-Smtp-Source: AGHT+IFub9Izja/SggOJpABtW81ImrYhzmA+2yy2M1jQsIXepddbCF3gmailhZ4ArAV3zr86xGQE3AQ+yz5WzUGUB2k=
X-Received: by 2002:a05:6512:3da0:b0:594:282d:f42a with SMTP id
 2adb3069b0e04-595841bb263mr2309504e87.22.1763240509957; Sat, 15 Nov 2025
 13:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch> <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
 <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com>
In-Reply-To: <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 15 Nov 2025 18:01:38 -0300
X-Gm-Features: AWmQ_bktASDloQZH9539LTWjwPB8uS5ZQ7vMeUetJjpcvEjJ-M2gAV4JbWS7pnA
Message-ID: <CAOMZO5CbNEspuYTUVfMysNkzzMXgTZaRxCTKSXfT0=WmoK=i5Q@mail.gmail.com>
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on i.MX6Q
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, edumazet <edumazet@google.com>, 
	netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

On Fri, Nov 14, 2025 at 6:33=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:

> The smsc PHY driver for LAN8720 has a number of callbacks and flags.
> Try commenting them out one after the other until it works.
>
> .read_status    =3D lan87xx_read_status,
> .config_init    =3D smsc_phy_config_init,
> .soft_reset     =3D smsc_phy_reset,
> .config_aneg    =3D lan95xx_config_aneg_ext,
> .suspend        =3D genphy_suspend,
> .resume         =3D genphy_resume,
> .flags          =3D PHY_RST_AFTER_CLK_EN,
>
> All of them are optional. If all are commented out, you should have
> the behavior of the genphy driver.
>
> Once we know which callback is problematic, we have a starting point.

Thanks for the suggestion.

After removing the '.soft_reset =3D smsc_phy_reset,' line, there is no
packet loss anymore.

If you have any other suggestions regarding smsc_phy_reset(), please
let me know.

Thanks

