Return-Path: <netdev+bounces-238912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B022C60EFB
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 03:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA3AE356DBF
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 02:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388061F09A5;
	Sun, 16 Nov 2025 02:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnVAVyE7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840F6FBF
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763259290; cv=none; b=i8kX6Sh+9TJ+fsrX0gsG7fPFGD2BfQukX7Kg3KX8Mfn1+KWB9FQNXBBi03YG06YG0ULX3p8o0/eIWUhhA/D0v/+2hdvFekMjIPs0/jcThksdAybwEHevXb56psvQDNjW2mLRxB2cBTnqzjZ0z4qU7My1sO2HkomytAaOHwRerwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763259290; c=relaxed/simple;
	bh=B/MJBi3NPcXDXg9y480eqM1+Y3TugTAyQ0MgwBe1E5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txD9JjI8JtASRVw3lhKBODNajwLxkburAMG2sThNKwK4lnO3xXJby0daBYzHQxtwECQ3bbP8vKR61OdC/YkGpNFLx9zeYp6WOeS6Dh6gRBVotBac7PsiCsASfCflOz48g4bbaxFvcL/k4q2n8V6hLpGSRVK7dhWqsKZ8U/eRS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnVAVyE7; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37ba5af5951so26117901fa.1
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 18:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763259285; x=1763864085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcbfEA0EIHao7wwi1BiEGdxGD5XeuyBbz4LavhxtBeE=;
        b=gnVAVyE7J5T+V2i1N4Huk2oBGw0F5u7ycAvznCrgG/rlxUNLEFXJedXR1IRdhM5ki0
         yGc26k6Ko2CAlXbfZizDdgW/QjqodyAEEAoKyGFYTAWgGF8RwxiIMl2lDS5GNm2//+q7
         LXaqh8/5C7Vk/XxNI3S7fz9y5NAGBhNrohbNy521TMlfNOIjnXDn3YS84LKT3Kq2vy3C
         My9q9nnar6A87ZZtw64DnkqYxTEVXd/r8aQWjOr3ufEZzKfIzNw1BwoinR+T8qRbuHtJ
         Ijl3we7EkwNPcRed/keOb1oy70oAWp7+gMo1AgCM1r6/Hkb7k64aMbeFlbKnvVvgL/Cl
         wFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763259285; x=1763864085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xcbfEA0EIHao7wwi1BiEGdxGD5XeuyBbz4LavhxtBeE=;
        b=VcH8tM9IxpLzuee6HatugsDhhoNUubP1yrTbqkMs7Cq9s6KQ5lLJanyiGcW3pusTVM
         Tkh5cNuL61QFcBo2NsVh0QpIOSnvoIA+j2MqtFgVwwIFHbFtlmI+YVzio6VhjNKjsSxZ
         NgI1bKFkKimz3Pjexb+IHUZ0B2sVzZdFUx4PKk3iiAheqzOsnW0YAkW3WxoEymRC+0Ix
         HWgHhRH8U+qHPe3YdKEHLsZuon+KsEb56I+zhdvkymLusQeWYptEqTH9l5hDpCmlg+vW
         +ruQ0aT+0Hyq7GifevVCt2pEasXUwZBOdMSBwULQtZwDrJ6OKrWKHLn5LCs95xLBjW53
         FhHw==
X-Forwarded-Encrypted: i=1; AJvYcCXJT65eAa1hBfoFs8XNA2nHO+4cHSmGfxT6T4bmoWwwEC7NPEvyXLeFanN9g9ogC/QZE1SF3go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl7b3PYvQkbLEExZngKQ24ZUKP8VpB4lLL3M2es1wGfv7FQkCQ
	aG9vd3/CwTDRQZkHfwwps5g/I5pFqqUBLGWhyK99CzboSrg5wJGpkqzQdPkPG9dGMWL35dOhlZ8
	Pss0mwNVwgtrf9+KCgrWgcxmmKgQ48wk=
X-Gm-Gg: ASbGncuDKVzq2744TkxKc7Jq/SiUJ709uZW0/sg5lRwNBGgTdfjOKkZnaoI28se5xGR
	YeE9qOKkm+hWIclkcGw/4BsV1IwoFW26lOLwr3PL5jvIX00nA8NU/He8tAjdpdwEggBKIjtcowH
	d4icpiMTaFWbcTtv++3qzNAPAAOo4Q0NCx14cinTw++KD5jYsDaFfPSP3cveJvCZDRgObVZDVcE
	kboFiVxkfTdQZr5CGtZ/cjsJHq3DThpR2Dvft0T/9FLmZaijUXOE/cBWhSbyqagQgWxiSS2uqoU
	KyTRJyE8hXPhf2Vys4K+X8IOS8M=
X-Google-Smtp-Source: AGHT+IFgLyjnvtXaFwWd+Mzv447naSQvAMGcZkotQc3AATNukJD0ZA2GsQ9dFDhx369ultzOp/5sy23SfWT7hd8prdI=
X-Received: by 2002:a05:6512:108e:b0:595:831d:22ff with SMTP id
 2adb3069b0e04-595841b4e6emr2397643e87.21.1763259285181; Sat, 15 Nov 2025
 18:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch> <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
 <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com> <CAOMZO5CbNEspuYTUVfMysNkzzMXgTZaRxCTKSXfT0=WmoK=i5Q@mail.gmail.com>
 <aRjytF103DHLnmEQ@shell.armlinux.org.uk> <CAOMZO5DfK1kxhtbYR3bDbwinpCKotBgHnY-B+YUknnHivUPYDA@mail.gmail.com>
In-Reply-To: <CAOMZO5DfK1kxhtbYR3bDbwinpCKotBgHnY-B+YUknnHivUPYDA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 15 Nov 2025 23:14:33 -0300
X-Gm-Features: AWmQ_bnrEa5tuKurS7sxqVHAHKLZ_7Oj_VpfSoR_HH5NNxC55v5-3Z4yOYjg7O0
Message-ID: <CAOMZO5BgfiM13hc=jYiouFSe5D_d71kFrr=66-CjLE-xuffHPw@mail.gmail.com>
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on i.MX6Q
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, edumazet <edumazet@google.com>, 
	netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 9:57=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> I have also tried describing it inside the ethernet-phy node with:
> reset-assert-us; reset-deassert-us; and reset-gpios, but it did not help.

Ok, what do you think about the change below?

It will work when reset-gpios is described inside the ethernet-phy node.

It will not work when the reset GPIO is specified within the FEC node
via the phy-reset-gpios property.

This is OK as 'phy-reset-gpios' is marked as deprecated in
Documentation/devicetree/bindings/net/fsl, fec.yaml.

--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -147,9 +147,19 @@ static int smsc_phy_reset(struct phy_device *phydev)
                /* set "all capable" mode */
                rc |=3D MII_LAN83C185_MODE_ALL;
                phy_write(phydev, MII_LAN83C185_SPECIAL_MODES, rc);
+               /* reset the phy */
+               return genphy_soft_reset(phydev);
        }

-       /* reset the phy */
+       /*
+        * If the reset-gpios property exists, a hardware reset will be
+        * performed by the PHY core, so do NOT issue a soft reset here.
+        */
+       if (phydev->mdio.dev.of_node &&
+           of_property_present(phydev->mdio.dev.of_node, "reset-gpios"))
+               return 0;
+
+       /* No reset GPIO: fall back to soft reset */
        return genphy_soft_reset(phydev);
 }

