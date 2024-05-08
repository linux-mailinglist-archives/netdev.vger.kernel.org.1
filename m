Return-Path: <netdev+bounces-94424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C973D8BF712
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C24EB22239
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E90374C1;
	Wed,  8 May 2024 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b="CncpDfTr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6228DC0
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153428; cv=none; b=pqzFllnRYw8kBSguPGz4aMSL34XwjLqKhlBiT0dNL997iOtJZr1CcIpqK9HPBJbUy8XO7fwkG1M4EkNmPPs6bwk8dSjchYR7XrQrxLVicmWaus7YttC9Ar4xBtTLPp8Xz4cs0jLwGDbSwcfbBxwlf+f6kQ0DdL8E6/lcZS2+DT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153428; c=relaxed/simple;
	bh=HkLTXlvLqPcM1G9r5TuQ/k6k+kIB8Kh6veaRJgAeLuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVpNMljSz1lZ00jDPb+/kXxdsakKTt09JyjnJOlFHMkMrvYo0sh4JhK4zfWC8oGZLSRI9YcWIP2usdsK5ym1Ur4deNn/goQGlq3I1xbAXem79WaSySotIdoilukRyAOGDe4y0FB7o+MmvAuzIbhOFiUNL+MMaKKCnsGmKHJC0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innosonix.de; spf=pass smtp.mailfrom=innosonix.de; dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b=CncpDfTr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innosonix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innosonix.de
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a599b74fd49so100123366b.2
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innosonix.de; s=google; t=1715153425; x=1715758225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VYVvd11hV7rJunixQLWGyRIvzoAkWZceNjuLWyDIro=;
        b=CncpDfTrHUfZw6dPg0Q43fIfcyNbLPSpT0yl+p/WWlFiSrNf/ue+abrPSlPlJUrzNg
         bQc7RkPFAkE9tOGs2mi8fRYcCFsVZ/tLKRtMQGu/dk4h9gjbeEY6jDyQcq5C5bHiDay6
         CU4AAqg0fy9XUy6T1gvhkG0zaVapZU5ITd2nTLiiyngmPxRnfCX8KzCtBZ0L6BqAa8DB
         2qShFxanfwqwn72fVGyFlmO79FLkXGqUhrCls3/59cK1D9tzU3RFcV+cMBJYYLFC0bqQ
         AHoak4ESm1XkK5e/4bY7Jott7Dpx+zRxMJApnioSE/uB2WJeyt691VE4wgz4KfLnn+Z2
         QCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715153425; x=1715758225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VYVvd11hV7rJunixQLWGyRIvzoAkWZceNjuLWyDIro=;
        b=GuXPiq9vX/SGaBkuZBfcg7/Al6gBYxfNI9QY5sU9uvNuB2Xs89wHmKksZo2KJvr3yX
         8uWgP9x0tinuoKfgUhX9HXzerZboK2JRlM7KR1cuSN7Mcy41SphvRDMQVZbv/7sEzFYy
         kfPxvGaipgolHIvagIBUKMwf4fv1DsSNSyQS5WzQHrPjVSnozAR/TJx4aTw97On/dzRM
         Zmi8Xy1GoVMUimvEQDz/Jok+qe8XGe2/Fm6VFws8D4xFRICB0skmy1QkqhISayGYXXSJ
         LmvCdcaTpYkOwLU2zvbhjes12Ge+CuHJXio0Qt2ElB2B5juH5iL7m9XCR5oq76drqEBK
         M/SA==
X-Forwarded-Encrypted: i=1; AJvYcCUYapVqdkocOGtx6Hdd4u1G2QOGis6DrZczYJr3dsob1YvN7BEsDFpK+ZGF79qsDRCsEQItKyzc3I9ubYSkCTW2K4/Fn234
X-Gm-Message-State: AOJu0Yw2tIatnbGZIPDnUmxWqxbWP+wA5HvO4kqflAqpT5E28GPx/VNR
	9Pshv4U+fABotT6O7NN21Lm0jEmXrATjsrPdLMzwZUQok3d7V/IA7s1hOcwqJS6P/X9LrmmuxhI
	eWrIMqt4sI6j9MMImWW9LGw3ZVfXn/RzuS8bm6zEWBncwn9A=
X-Google-Smtp-Source: AGHT+IESY233JbBjfnq6GMLDZnMM4NG31o9T4zlVFMeCCFSjl3lZjwhguOSXqQjmzu92DOiPMrJUMA==
X-Received: by 2002:a17:906:df14:b0:a59:bce9:8454 with SMTP id a640c23a62f3a-a59fb94f6d3mr109682366b.1.1715153425329;
        Wed, 08 May 2024 00:30:25 -0700 (PDT)
Received: from localhost.localdomain ([24.134.20.169])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090648cc00b00a59a874136fsm5212358ejt.214.2024.05.08.00.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:30:24 -0700 (PDT)
From: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>
To: 
Cc: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Fabio Estevam <festevam@gmail.com>,
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
Subject: [PATCH v2 net 2/2] net: dsa: mv88e6xxx: read cmode on mv88e6320/21 serdes only ports
Date: Wed,  8 May 2024 09:29:44 +0200
Message-Id: <20240508072944.54880-3-steffen@innosonix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508072944.54880-1-steffen@innosonix.de>
References: <20240508072944.54880-1-steffen@innosonix.de>
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
number since the register set of the 6352 is equal on the 6320/21.

Signed-off-by: Steffen B=C3=A4tz <steffen@innosonix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

Changes since v1:
- Collected Reviewed-by tags from Andrew and Fabio
---
 drivers/net/dsa/mv88e6xxx/chip.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/c=
hip.c
index bd58190853c7..6780e8c36b1f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -637,12 +637,12 @@ static void mv88e6351_phylink_get_caps(struct mv88e6x=
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
@@ -651,16 +651,16 @@ static int mv88e6352_get_port4_serdes_cmode(struct mv=
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
@@ -688,7 +688,7 @@ static void mv88e6352_phylink_get_caps(struct mv88e6xxx=
_chip *chip, int port,
 		if (err <=3D 0)
 			return;
=20
-		cmode =3D mv88e6352_get_port4_serdes_cmode(chip);
+		cmode =3D mv88e63xx_get_port_serdes_cmode(chip, port);
 		if (cmode < 0)
 			dev_err(chip->dev, "p%d: failed to read serdes cmode\n",
 				port);
@@ -701,12 +701,23 @@ static void mv88e632x_phylink_get_caps(struct mv88e6x=
xx_chip *chip, int port,
 				       struct phylink_config *config)
 {
 	unsigned long *supported =3D config->supported_interfaces;
+	int cmode;
=20
 	/* Translate the default cmode */
 	mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
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


