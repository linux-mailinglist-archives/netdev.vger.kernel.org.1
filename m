Return-Path: <netdev+bounces-149723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C69E6EF2
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E4281C06
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9B206F35;
	Fri,  6 Dec 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="fKOSxBX5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C671EE02E
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490580; cv=none; b=lqFWuiOImlrth9c1iE/aEcbP7P7tBCI124TjgTuZW5vfWFSludQBRNi7Hy2tsioq15SlrRbPRaP1/H644dxG7SVGU6HXkTDZWlu833caSVJKge3LsQVrMJXCjpVCN4mFy1BOyjp7+tUflNAgUwc4sVOSf70q38TxAGsmJx8dHYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490580; c=relaxed/simple;
	bh=FKO1yTpCxcxBhtBAips3l/holB9+UDZ+2V1hv302F1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BH3nWoDytIs6Y4Tv2fhxcM6SddwzPd2iCjxg5nI6YJjWJcjpoSVSYuqjaxqTl3lJMS5Crj6xATWwZ0reZBJdcGcTneaxzjJOjbA0uFRmW+SdwLXpqDmGjP1EjoxFiUVlslNH8AaupInVIqHN+Ht6UhoUux8magoRzaTCaH6XsCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=fKOSxBX5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc80318c9so17648151fa.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 05:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1733490576; x=1734095376; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qCZZqWJYXyTrAZAPIAwDCKjjcnwn+ysQvEOzOvXeE28=;
        b=fKOSxBX5aVlFdpfxn20ognKyC3mtKbDrzyZr59vKRLCzFZslnmkSwNX3IQElR0NquX
         Z8qB+yyucMYg1WSG5aD9ob8cCwvxsFBDcaG1SVOFpFGpATqRhmF2OE3J3Lvgm28NAxRF
         oTcAnJiVcnmo0jbpbl80X8Zq5rfjgAiQawpU56TOC3ax7xfPQeMlQL8s/7h6SQVLw2OW
         pU4+rHjDrrQ27z3Ujg/aD7rKB+isgiVNgsMPWd10F9MtYs/IUV4SabGmd2tsMf3rb1jV
         ILeOuKL7UO0b4DcIeOsZvVVcpnWI4+kpVzNhESysWd/WDLXB5LlwlrPGVyJc1ap8/5sx
         21vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733490576; x=1734095376;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCZZqWJYXyTrAZAPIAwDCKjjcnwn+ysQvEOzOvXeE28=;
        b=J/Tz72ovKGGzq7DBaJrifkSCwFHFmcQifZhiMHgv+a88Tmqei8uUl7YJZi6QnVy3H7
         ZhFywGXIIgTGcwXU/Si93+JMD4tu9YnE/gr8SdXjw+tsj1BA1O4aNZ63xgDSS4p0xzCH
         FAkEH41jCI8JfXRXIGCMhEc2usSeeES2fQ1lxv2HOKP2acQzYh1AAVDjR4yh01sZRpnj
         q+Rf01SxGFP3Kds+HaRxR7+bf8F7Pj6hlyDz2eMLAr2b4Fr/DBrNPri1hdmz+cI6d8yZ
         j4tgr4dg3Vzy0aDxsBInsBCXPnoRPam/fFx+sRgaXYQKVm4dP0EuU2LuT4kYo95hZZTZ
         Nrug==
X-Forwarded-Encrypted: i=1; AJvYcCVwO6IlewNSbcuAShsEJheFBpaKdqwmgzxWEB+b8aea4EysHf+tokpbBjrLsPPjrjnDx5d1pCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaoj0iVsp0DZoCKNwh0I5GbfGH2YG1q7e7PL//aaWQVnzmllhG
	ULwWD2ZGZLbyP5KxHzJebTbXnmLJid7ncLZhW52O4Toa7OKZ7efjGNo6p3hmJ5afousVVgcJjNe
	b
X-Gm-Gg: ASbGnctCZXNHv6qqJ9GF98TXb64ex1v4KE7qGFz3VaO/SwPHoAO3hesOGjTGHlJyGls
	1rMtJUuCgyn4afDO5yhnqObVrGolfHqnuFCe+21lW2CeijbC+9vQvHQU3Y+rxUDwdn/VbGJw6EE
	Os4agVXr+rNrvFQxWKzsdKYcFL3ADBoiM91ej3Z48FCCpUvqbYJpagcdgDtyC5LxJQpkSYln7hB
	I1iM8nfJ5uY2KML+P5gb/M246goFKQkXAvYqmwAH8OIyUglAAluJo0LfdrgmUYtGOWEBau0qYS7
	kmsNhxQ00g==
X-Google-Smtp-Source: AGHT+IGq4fxmo1GEb+TViIER5G0ld3v0DW/rLfop51z2NEWIAHSR9rhipecNsBEutje7Yd3XFLpd/A==
X-Received: by 2002:a05:651c:505:b0:300:1cdb:6652 with SMTP id 38308e7fff4ca-3002fcec2a4mr8356021fa.31.1733490576419;
        Fri, 06 Dec 2024 05:09:36 -0800 (PST)
Received: from wkz-x13.. (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e21704sm4527401fa.90.2024.12.06.05.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:09:34 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz
Subject: [PATCH net 2/4] net: dsa: mv88e6xxx: Give chips more time to activate their PPUs
Date: Fri,  6 Dec 2024 14:07:34 +0100
Message-ID: <20241206130824.3784213-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206130824.3784213-1-tobias@waldekranz.com>
References: <20241206130824.3784213-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

In a daisy-chain of three 6393X devices, delays of up to 750ms are
sometimes observed before completion of PPU initialization (Global 1,
register 0, bit 15) is signaled. Therefore, allow chips more time
before giving up.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    |  4 ++--
 drivers/net/dsa/mv88e6xxx/chip.h    |  2 ++
 drivers/net/dsa/mv88e6xxx/global1.c | 19 ++++++++++++++++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 16fc9a21dc59..20cd25fb4b75 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -145,8 +145,8 @@ int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
 	return err;
 }
 
-static int _mv88e6xxx_wait_bit(struct mv88e6xxx_chip *chip, int addr, int reg,
-			       int bit, int val, u16 *last)
+int _mv88e6xxx_wait_bit(struct mv88e6xxx_chip *chip, int addr, int reg,
+			int bit, int val, u16 *last)
 {
 	return _mv88e6xxx_wait_mask(chip, addr, reg, BIT(bit),
 				   val ? BIT(bit) : 0x0000, last);
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 9fe8e8a7856b..dfdb0380e664 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -824,6 +824,8 @@ int mv88e6xxx_read(struct mv88e6xxx_chip *chip, int addr, int reg, u16 *val);
 int mv88e6xxx_write(struct mv88e6xxx_chip *chip, int addr, int reg, u16 val);
 int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
 			u16 mask, u16 val);
+int _mv88e6xxx_wait_bit(struct mv88e6xxx_chip *chip, int addr, int reg,
+			int bit, int val, u16 *last);
 int mv88e6xxx_wait_bit(struct mv88e6xxx_chip *chip, int addr, int reg,
 		       int bit, int val);
 struct mii_bus *mv88e6xxx_default_mdio_bus(struct mv88e6xxx_chip *chip);
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 9820cd596757..27e98e729563 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -60,8 +60,25 @@ static int mv88e6185_g1_wait_ppu_polling(struct mv88e6xxx_chip *chip)
 static int mv88e6352_g1_wait_ppu_polling(struct mv88e6xxx_chip *chip)
 {
 	int bit = __bf_shf(MV88E6352_G1_STS_PPU_STATE);
+	int err, i;
 
-	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
+	for (i = 0; i < 20; i++) {
+		err = _mv88e6xxx_wait_bit(chip, chip->info->global1_addr,
+					  MV88E6XXX_G1_STS, bit, 1, NULL);
+		if (err != -ETIMEDOUT)
+			break;
+	}
+
+	if (err) {
+		dev_err(chip->dev, "PPU did not come online: %d\n", err);
+		return err;
+	}
+
+	if (i)
+		dev_warn(chip->dev,
+			 "PPU was slow to come online, retried %d times\n", i);
+
+	return 0;
 }
 
 static int mv88e6xxx_g1_wait_init_ready(struct mv88e6xxx_chip *chip)
-- 
2.43.0


