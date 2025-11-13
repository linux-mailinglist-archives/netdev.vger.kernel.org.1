Return-Path: <netdev+bounces-238517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8613C5A4F8
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1543AA63C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AFE322C81;
	Thu, 13 Nov 2025 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9VuonaA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7EE3164D0
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763072739; cv=none; b=LF4jGZu8k30mhHJoO2QX8mdysSfDuWX9B7dOnyDeQ3i/x26AoTo7JtRGO/SpjPvDk0YLLyFjwd0gykHg9UDoP5LY+3ac48vI42ZFTP5JBT+20ACd2RKrq5Vn7E/qlzi5lykceX1Rpo8t59vZr9qwPln5sjIJHfcmoYwk0uBSZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763072739; c=relaxed/simple;
	bh=WhZzjCsCiP+lP02ZIg7TyhiKLFFCm/hE22VIkpCg36g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=max543FlsqDHNGAInxMjzZ0adSCd6Zf09OFhzuF7c5ANjKZc98f6ZbuI7HSn9HNvkCyFL6xryceHGGhYRFqBbGYrKZ7+Jr/DDVoDUvnr61Oyg5OnxwC4lTrsBJ/XycOGFMytywKESPBILz+vMjUgTs+ri999EsN16uCTKlvaMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9VuonaA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5942e61f001so1292362e87.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763072735; x=1763677535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MsyHjBQ/sNpIDi92HakG3FIDgiJ4Qjc+nddIim0FQDY=;
        b=e9VuonaA9d4E9fajoRPljddioXadmoY7SO+a1e3UrIXSK8DNBoD4xuT973TI9VKyEI
         ZeAzb3uPSSkAEbN4zw4AbfxadZeHvdRMIBCuuL4I5+xxAYvPuSXNZWtrhWuTuehL3tfU
         LX/QYtvya99vWhC9l3FdRrmfHdIG8Gc+TzlrkLd4z6yxaXTfBQjWF9jFLz9WAJlBWcru
         e3/h2QWH4YTWGDLV5UmKSpNkjARDaqJW8M9NIHfUEbtFzc8hYiLv8lIXJR+2VI3fa3uC
         GOxIKrXtZZCfwMr24Xit9yOvQc1Ux4WGzsTX6lDSU4NrJ1Q9G6kZUQR2v/SdU850m9N5
         fPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763072735; x=1763677535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsyHjBQ/sNpIDi92HakG3FIDgiJ4Qjc+nddIim0FQDY=;
        b=dyWzKxXQ1G2IxB8VAFiMAF5fo0KZ6kaHOo7ApDj+ek4GIyzK0NoF1qgNGp7mXwXRuW
         AJLm0LaVFquxUJTa/LC8tmST2/BzIlktCm9vRFWucZmJndVvShop9SWdUMwa8ZjbjbdQ
         V+WujPvOHNECatvmwCY029H7PKF/IqDlRLBdGtMESPEFVc2+ccEPAW9IbAgEcQr1Ljw4
         RDu4qthWTJVfRrgoth5z7TTo9KS0Bio6C5deYqkL23xYmPtCWc/i9jgYbWpp6uDftfnE
         1a9rhph1ur4QGQ7quEMYhSRzlKaZN4aaE2TH75pUeGKqvKGZfNYF7bwY5aWNK2t/2pg0
         AhyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZkzn7Ryi80FFrJVW5hZbDLs7zMz/aRPzXIpDdxZsKe6EJks/mDTv/s7MrBZXHsSejgXjMNd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwjWeImcvzh9AjX5Uwo36OpXKR0cx/lJgZfHB0vFXgd8OsHmdE
	GvXKN/VoXVugm4S5tRk1Mvkpk68VtviYQHkmbxPpgUST/FznxkhPAGuAcxA8bUHZjp0g8FGQ7hq
	7qC1LmZiMfrOIYOcVovwrMy9xxhMCbxE=
X-Gm-Gg: ASbGncvTo9a9WjoDeMGtz3+P5WutD0RMYdVKPnh9/GDpvPyFWG/PAoEkEbYI7LbSocT
	XI8tKWdAf61/d69RWa9wXgO6fQzy28Jo4DZbfTpfQccU+lJQJx6vmO977gCUAoy2SpCiquPJhx0
	bS4/Q5zMWE12o9TQ4qTpK/0dUztB00yGeLBbcTBiLBDZHv3iVmfQdsmoh3bisuqPG8Pq4w+R4Zh
	u5jgZUFaaemeiilgZfSVhEjcXRJPIgIvdzOpBaSgErxOeMz22PmE99ERGuM55zcdwF0AhVGAs6h
	JbRX+cFDTYKxUtrmBdg76KY92Xk=
X-Google-Smtp-Source: AGHT+IHWwP9AV6voBvgHqtexBYCUUy0vQtA3T1SBv453SYhYy2sjdPJKmiQT7mUEVwc4iPJ5OCW3CvwVsNnE1GcxJKU=
X-Received: by 2002:a05:6512:3404:b0:591:ec0d:3014 with SMTP id
 2adb3069b0e04-59584217888mr336586e87.48.1763072735089; Thu, 13 Nov 2025
 14:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 13 Nov 2025 19:25:23 -0300
X-Gm-Features: AWmQ_bm3d1dQcPNOuUuHy2m2NobTdGKVXAJkY38q3vV1BcHvSC8Sboppw_gCd0U
Message-ID: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
Subject: LAN8720: RX errors / packet loss when using smsc PHY driver on i.MX6Q
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: edumazet <edumazet@google.com>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On a custom i.MX6Q-based board using a LAN8720 PHY, we are observing
consistent packet loss when the LAN8720-specific PHY driver
(drivers/net/phy/smsc.c) is in use.

Kernel versions tested: 6.18-rc4 and 6.12
MAC driver: FEC (i.MX6)
PHY: LAN8720 (RMII) providing the 50 MHz ENET_REF clock to the SoC.

Behavior:

- Packet loss occurs when the LAN8720 is bound to the smsc PHY driver.

- No packet loss when using the generic PHY driver.

- No packet loss when the smsc driver is used and the link is forced
to 10 Mbps using ethtool.

The issue is easily reproduced with:

ping -c 1000 -i 0.2 -s 1300 <board-ip>

The board=E2=80=99s relevant DT fragment:

&fec {
    status =3D "okay";
    pinctrl-names =3D "default";
    pinctrl-0 =3D <&pinctrl_fec>;

    /* FEC ENET REF clock comes from LAN8720 */
    clocks =3D <&clks IMX6QDL_CLK_ENET>,
             <&clks IMX6QDL_CLK_ENET>,
             <&clks IMX6QDL_CLK_ENET>,
             <&clks IMX6QDL_CLK_ENET_REF>;
    clock-names =3D "ipg", "ahb", "ptp", "enet_out";

    phy-mode =3D "rmii";
    phy-reset-gpios =3D <&gpio2 4 GPIO_ACTIVE_LOW>;
    phy-reset-duration =3D <100>;
    phy-handle =3D <&ethphy0>;

    mdio {
        #address-cells =3D <1>;
        #size-cells =3D <0>;
        status =3D "okay";

        ethphy0: ethernet-phy@0 {
            reg =3D <0>;
            compatible =3D "ethernet-phy-ieee802.3-c22";
            max-speed =3D <100>;
            smsc,disable-energy-detect;
        };
    };
};

Has anyone seen similar behavior with LAN8720 or the smsc PHY driver
on i.MX platforms?
Any guidance on how to further debug this or what additional
information would be useful is appreciated.

Thanks,

Fabio Estevam

