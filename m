Return-Path: <netdev+bounces-149725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5E99E6EF4
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F6C282B78
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBE1205AC7;
	Fri,  6 Dec 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="dNkl5ynu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0DD206F33
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490586; cv=none; b=G+iJgEVoqUOvHZMI1DaJ8Dtwg2yQdjiP3jJYCx+45NLd3ANMtJCLAMNd296PY+k61SbVaEFR2oDd/m9YEy1PgKAXE4LKs0LLFAzNP8hO8e8r8MQev8mCskxlIjLw/nvgZg7eKLYKBMcAGnUxBzZEGdqB9mgrid2pzeP3MkqJY30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490586; c=relaxed/simple;
	bh=CbzA0ebUpgodKBCOzJODVN++NbuW1U0YDdgtoYEfYpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtRy+tTvFgerYCeuHKmW434PH/t962X5ok7kEKlqzucls6CQWP8Q+Pczb96EFgxwtMYb5YBXUHPd0JdHVpFgd8HdO7ediHfSVxosWTkSYSR55ZglLBvYcat9dyE2FXRZZZVPwuLXm2KevACYmS7J48+BRUYuukIVUURG/wfe6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=dNkl5ynu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffb5b131d0so19992471fa.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 05:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1733490583; x=1734095383; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MVYDwDZ41knrDBuiD+vu8AjdcCDrx177r0ASKL3mDEQ=;
        b=dNkl5ynuGVeAe5TvFHFUxGg4SORug8K/d73TQ+50SigS5CC0V4aPGe5OXbYXO47KUb
         CZTKxdwnvGNbNOhzItQz9C0L/1H2cFK2hBce4EY9y7kE+FUYbON5GdG7QlAo9uhPKUPo
         oZ+1j8mCaNCLudNrHGfa4TrAjNCe8F+dVYiHXp20/Nd/g9hjzq3hd/FBoMyYjlzzEuU/
         NNDoEyxAps81b8aI5FiYQ9gKRJ9xr7SF6uvRvrOpARiul57rXlRRcfgzJ5ioaCs8fG0z
         /yOrHwIrwNGvHANRj9ocw8/YOCjDWBrZojKgYL/q1xgK7hamPsLBeISd6lJ39ZJGQkCf
         yDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733490583; x=1734095383;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVYDwDZ41knrDBuiD+vu8AjdcCDrx177r0ASKL3mDEQ=;
        b=hJWBEDyBon0ant6fa64YdkahyHV2zCWjvOq+x72GMkoX/r3tNn8vfVxejBDnLCXWKJ
         Z6QEgT8inBQ7FCSGCtDLxL/4vGGweHQw51NYpglGHMDk1Y6S30ri5UFZcEuy+vMWkjXK
         GOHxL+2W9zRLp2K25WQuzb4Q9QEz0rHoOlaTAV9eo8z6f9sWMMsizgZ0yjni4EfZYYcR
         BHAj6FaoNTDYPs+g03xJThE7Z+QzB+Fr3UzmgST/PtItbOyw+ddfhsIqoRxwq8vdd5oX
         BSCfK4IF6zmm4KEGX/2OC2Vt/6CKWZQrdwes8ue8+/M5NLUv5TP1SnShBf7YDK9rftHn
         sG4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLH8ZS2ii3/+++OTKiLp6ojcma7J8l4QI7ozcEQ7Ps4Avyuvrn3HOBX9uuS3ODvCkaGG9R+bA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyo2Cm9j/KUUqEgUUt+b4cLhRM+zKbP4rMloRvQQ9V4382AIlf
	PbQT8eUVnLtVGIj4n58nkYjzBmLVIp4T580sx8gvFQPFDJQwr67dYAdZZNig9so=
X-Gm-Gg: ASbGncszMiKD2pNnNbIxQoMQ4bUTo+KX1Ppv9Ezwab/VEcL30PY/bIxKILnLWhs/+qa
	nCkWQ7THoRmOp7YLkcdfTI1QlsrBgKspGJ0v8GLfu+SsaN3dpb3R6i09Im7szaaKSXJWYWBEFLc
	TXL8XRhOscGaRnZB+/mIvkua/z+LGqtRi6xtE46nPQhmhOc6STUTMdlePe8JHJ2jg4T6sIkZGEk
	isYwtPIYcksi4vVmRJI8rKA+KKUaVWyDefpmYoVuuZgsjXSxh29PhCCBkOERODyI0vUbLESMHlJ
	dZ2/IF16KQ==
X-Google-Smtp-Source: AGHT+IFLsCfh75pCbkNJ2ktkNSm+j6j2CYTe3tpyg2XxV5Qcx4NDMUBYTRpHgHlhBDfNlBdcbULWaQ==
X-Received: by 2002:a05:651c:19a5:b0:2fb:2f7c:28dd with SMTP id 38308e7fff4ca-3002f8da8a3mr10646121fa.18.1733490582853;
        Fri, 06 Dec 2024 05:09:42 -0800 (PST)
Received: from wkz-x13.. (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e21704sm4527401fa.90.2024.12.06.05.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:09:41 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz
Subject: [PATCH net 4/4] net: dsa: mv88e6xxx: Limit rsvd2cpu policy to user ports on 6393X
Date: Fri,  6 Dec 2024 14:07:36 +0100
Message-ID: <20241206130824.3784213-5-tobias@waldekranz.com>
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

For packets with a DA in the IEEE reserved L2 group range, originating
from a CPU, forward it as normal, rather than classifying it as
management.

Example use-case:

     bridge (group_fwd_mask 0x4000)
     / |  \
 swp1 swp2 tap0
   \   /
(mv88e6xxx)

We've created a bridge with a non-zero group_fwd_mask (allowing LLDP
in this example) containing a set of ports managed by mv88e6xxx and
some foreign interface (e.g. an L2 VPN tunnel).

Since an LLDP packet coming in to the bridge from the other side of
tap0 is eligable for tx forward offloading, a FORWARD frame destined
for swp1 and swp2 would be send to the conduit interface.

Before this change, due to rsvd2cpu being enabled on the CPU port, the
switch would try to trap it back to the CPU. Given that the CPU is
trusted, instead assume that it indeed meant for the packet to be
forwarded like any other.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/port.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 56ed2f57fef8..bf6d558c112c 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1416,6 +1416,23 @@ static int mv88e6393x_port_policy_write_all(struct mv88e6xxx_chip *chip,
 	return 0;
 }
 
+static int mv88e6393x_port_policy_write_user(struct mv88e6xxx_chip *chip,
+					     u16 pointer, u8 data)
+{
+	int err, port;
+
+	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+
+		err = mv88e6393x_port_policy_write(chip, port, pointer, data);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 int mv88e6393x_set_egress_port(struct mv88e6xxx_chip *chip,
 			       enum mv88e6xxx_egress_direction direction,
 			       int port)
@@ -1457,26 +1474,28 @@ int mv88e6393x_port_mgmt_rsvd2cpu(struct mv88e6xxx_chip *chip)
 	int err;
 
 	/* Consider the frames with reserved multicast destination
-	 * addresses matching 01:80:c2:00:00:00 and
-	 * 01:80:c2:00:00:02 as MGMT.
+	 * addresses matching 01:80:c2:00:00:00 and 01:80:c2:00:00:02
+	 * as MGMT when received on user ports. Forward as normal on
+	 * CPU/DSA ports, to support bridges with non-zero
+	 * group_fwd_masks.
 	 */
 	ptr = MV88E6393X_PORT_POLICY_MGMT_CTL_PTR_01C280000000XLO;
-	err = mv88e6393x_port_policy_write_all(chip, ptr, 0xff);
+	err = mv88e6393x_port_policy_write_user(chip, ptr, 0xff);
 	if (err)
 		return err;
 
 	ptr = MV88E6393X_PORT_POLICY_MGMT_CTL_PTR_01C280000000XHI;
-	err = mv88e6393x_port_policy_write_all(chip, ptr, 0xff);
+	err = mv88e6393x_port_policy_write_user(chip, ptr, 0xff);
 	if (err)
 		return err;
 
 	ptr = MV88E6393X_PORT_POLICY_MGMT_CTL_PTR_01C280000002XLO;
-	err = mv88e6393x_port_policy_write_all(chip, ptr, 0xff);
+	err = mv88e6393x_port_policy_write_user(chip, ptr, 0xff);
 	if (err)
 		return err;
 
 	ptr = MV88E6393X_PORT_POLICY_MGMT_CTL_PTR_01C280000002XHI;
-	err = mv88e6393x_port_policy_write_all(chip, ptr, 0xff);
+	err = mv88e6393x_port_policy_write_user(chip, ptr, 0xff);
 	if (err)
 		return err;
 
-- 
2.43.0


