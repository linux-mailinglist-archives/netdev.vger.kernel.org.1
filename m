Return-Path: <netdev+bounces-74854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132BE866F29
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 10:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366E01C24C89
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E769A129A7D;
	Mon, 26 Feb 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innosonix-de.20230601.gappssmtp.com header.i=@innosonix-de.20230601.gappssmtp.com header.b="oF5JvOb2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE5129A67
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938919; cv=none; b=jmEnH3vuqbh1gTjZNZm6vqIo2Dpb94ijxD2cR6OikwRLcy7tOT/f2UnDKqn6oURgatlBzYome6LGqmFsXO5sNEoGwpl10lHWzJc6qRvaJfSt7e476UVkC6Cjttfai2/mNXua9UgMctjEyWdWp2kCTYkn9PSArKkOHNKToLM9hvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938919; c=relaxed/simple;
	bh=1nsO2sbgy7HnxuG5nHFX9lFzO6oldSfWF1CTUMJTGLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jzs0HI66otf9yWgT3aYmoomCHDdbZI+SsOcAUVHgx/eTgJ1htpC/tSfl8dOIj+n5hmZsx1cAJdR6XYHYBxSpiOHKECYTSbXxmlgPXH5dSPLBhiSOg2Fon5vmdYhyBl8LPUMkCsk31gSIxbUX2HIIeqtZP8VjOq+hxcZD0EZGaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=innosonix.de; spf=pass smtp.mailfrom=innosonix.de; dkim=pass (2048-bit key) header.d=innosonix-de.20230601.gappssmtp.com header.i=@innosonix-de.20230601.gappssmtp.com header.b=oF5JvOb2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=innosonix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innosonix.de
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5661703db3aso39275a12.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 01:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innosonix-de.20230601.gappssmtp.com; s=20230601; t=1708938916; x=1709543716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLITLxaZSB9SoVACx0xoHq4X5hT7/t8O6Nlq55OjBL0=;
        b=oF5JvOb28kOnU7siFrSLTZd//3MvSrD3uL77MuhhC1Assbla0msmyOQtoY/BwRt/g1
         M3PIMF2NyeqY2frO+oW/dZNJMDVym8P+16xjHDNOXfyFSTmaTWVQDdSgFDOGv7JiY6/Y
         VNypMh1MmZRtKLefadOXsvAIfsswo/DyUeCL4Jg+mpCo7YGFRME6U3G85goDPMXwswWm
         wKYMZkQHbdIMjRyDHlIg/D5+lyL2zUTRQ8RVh54WWv9A32KZcwzjXZTKA8Z3W/GO+e4S
         rjD5y+7hGrZRtSLFugTnk/qjt3RTNUVrhBAEdR1LsH/VnOGBNfht9pwWNKR7p0COdADQ
         dYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938916; x=1709543716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLITLxaZSB9SoVACx0xoHq4X5hT7/t8O6Nlq55OjBL0=;
        b=VWxEWFRpxl3CqMYTQvVzQVFRMOErdN59kJ7Cvla+0jA73FEWBot1PsrK7a2g1K5qjF
         vpgWeyEVkOV9DT7rkIqqKVvP2SkX8hwn+bKTjfszWVZiWs3WeQY3XYVAI36KukDREH0q
         e7KDIOuaHkskYn2J6Hk/Hw/bgPxK6M8gI/dif3lQerBw58pd1NDqADyPMI8+g5W380hd
         3Q5xYUpC2Y6OYbcrGLI4Jv18Sd1mNaVl6ntaMPD9aE3HlsyX3fUeBKTvLtp6KIaPkBzc
         A8s+kVs9BBPqn/X6YUEV9L0aaNAsH4qLwVCDdO72wrlllCAdLSvDsyuXUxgCw/GIpLZ1
         F1nA==
X-Forwarded-Encrypted: i=1; AJvYcCUMKQzFxww8NXlNcK/O92LjQJp3C+d/wFdOFYnvwV67kQ/F4R/cpcyxpEcr94eWKv3RPhD4SDTqUpTOaD/ZTpB8Z46Xggzz
X-Gm-Message-State: AOJu0YyzpIZfviaQAHrEfK+/giyzlrbeWsBsQEoe0QTaebunX5BdoHHs
	fqujR40tY+RRRXM+n7IpjVr3sZGU8BIfM7h42ILAMe4V8Vm2DmREwh0TqgPQ7mu47jezOEarD8N
	Lwm6PIPVYym1dRXJ+vnVVkESp+RFB9AQPj+gV893uqtSdlJs=
X-Google-Smtp-Source: AGHT+IHkKpbZCqodh34vjnigOw8aWudpn8lKFX/JMUhFn4B3kLN8ezmVMiTUWNIAvT9dGTIP6zELJQ==
X-Received: by 2002:a50:d7c4:0:b0:565:dac5:3ef8 with SMTP id m4-20020a50d7c4000000b00565dac53ef8mr1968223edj.1.1708938916229;
        Mon, 26 Feb 2024 01:15:16 -0800 (PST)
Received: from localhost.localdomain (p549da391.dip0.t-ipconnect.de. [84.157.163.145])
        by smtp.gmail.com with ESMTPSA id bm17-20020a0564020b1100b00564c7454bf3sm2163206edb.8.2024.02.26.01.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:15:15 -0800 (PST)
From: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>
To: 
Cc: Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: dsa: mv88e6xxx: 6320/21 read cmode on serdes ports
Date: Mon, 26 Feb 2024 10:13:24 +0100
Message-Id: <20240226091325.53986-2-steffen@innosonix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226091325.53986-1-steffen@innosonix.de>
References: <20240226091325.53986-1-steffen@innosonix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On the mv88e6320 and 6321 switch family, port 0/1 are serdes only ports.
Modified the mv88e6352_get_port4_serdes_cmode function to pass a port
number since the register set of the 6352 is equal on the 6320/21 families.

Signed-off-by: Steffen B=C3=A4tz <steffen@innosonix.de>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/c=
hip.c
index 32b927b7c221..2d7361852d7e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -589,12 +589,12 @@ static void mv88e6351_phylink_get_caps(struct mv88e6x=
xx_chip *chip, int port,
 				   MAC_1000FD;
 }
=20
-static int mv88e6352_get_port4_serdes_cmode(struct mv88e6xxx_chip *chip)
+static int mv88e63xx_get_port_serdes_cmode(struct mv88e6xxx_chip *chip, in=
t port)
 {
 	u16 reg, val;
 	int err;
=20
-	err =3D mv88e6xxx_port_read(chip, 4, MV88E6XXX_PORT_STS, &reg);
+	err =3D mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &reg);
 	if (err)
 		return err;
=20
@@ -603,16 +603,16 @@ static int mv88e6352_get_port4_serdes_cmode(struct mv=
88e6xxx_chip *chip)
 		return 0xf;
=20
 	val =3D reg & ~MV88E6XXX_PORT_STS_PHY_DETECT;
-	err =3D mv88e6xxx_port_write(chip, 4, MV88E6XXX_PORT_STS, val);
+	err =3D mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_STS, val);
 	if (err)
 		return err;
=20
-	err =3D mv88e6xxx_port_read(chip, 4, MV88E6XXX_PORT_STS, &val);
+	err =3D mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &val);
 	if (err)
 		return err;
=20
 	/* Restore PHY_DETECT value */
-	err =3D mv88e6xxx_port_write(chip, 4, MV88E6XXX_PORT_STS, reg);
+	err =3D mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_STS, reg);
 	if (err)
 		return err;
=20
@@ -640,7 +640,7 @@ static void mv88e6352_phylink_get_caps(struct mv88e6xxx=
_chip *chip, int port,
 		if (err <=3D 0)
 			return;
=20
-		cmode =3D mv88e6352_get_port4_serdes_cmode(chip);
+		cmode =3D mv88e63xx_get_port_serdes_cmode(chip, port);
 		if (cmode < 0)
 			dev_err(chip->dev, "p%d: failed to read serdes cmode\n",
 				port);
@@ -660,6 +660,16 @@ static void mv88e632x_phylink_get_caps(struct mv88e6xx=
x_chip *chip, int port,
=20
 	config->mac_capabilities =3D MAC_SYM_PAUSE | MAC_10 | MAC_100 |
 				   MAC_1000FD;
+
+	/* Port 0/1 are serdes only ports */
+	if (port =3D=3D 0 || port =3D=3D 1) {
+		cmode =3D mv88e63xx_get_port_serdes_cmode(chip, port);
+		if (cmode < 0)
+			dev_err(chip->dev, "p%d: failed to read serdes cmode\n",
+				port);
+		else
+			mv88e6xxx_translate_cmode(cmode, supported);
+	}
 }
=20
 static void mv88e6341_phylink_get_caps(struct mv88e6xxx_chip *chip, int po=
rt,
--=20
2.34.1


--=20


*innosonix GmbH*
Hauptstr. 35
96482 Ahorn
central: +49 9561 7459980
www.innosonix.de <http://www.innosonix.de>

innosonix GmbH
Gesch=C3=A4ftsf=C3=BChrer:=20
Markus B=C3=A4tz, Steffen B=C3=A4tz
USt.-IdNr / VAT-Nr.: DE266020313
EORI-Nr.:=20
DE240121536680271
HRB 5192 Coburg
WEEE-Reg.-Nr. DE88021242

--=20


