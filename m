Return-Path: <netdev+bounces-168043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD42A3D2D6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0B4189B8B6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563391EBA0D;
	Thu, 20 Feb 2025 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0zLB135"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801CC1EB1BE;
	Thu, 20 Feb 2025 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039089; cv=none; b=IEalLc+0ytAdYnD2SsEaW8PT/lrpz+Xg5uw6rjha4R865Ka1DjjmgIHcjeuAzf8ceQE1xiBSLze0TuUS3HxDcEo23x+OhnzpX6iW5QNVTikN8YnM9idVKXEtUWsLGtGsK7nYf7yRamPmzbLsl6TPdVEEkP+CyUF+R4Z08DEGpWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039089; c=relaxed/simple;
	bh=9pfFTAEw5xRe7qd2RZMPcVj1+s1NyMA2SsmkU7YZllY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfSa0t+zu83XFuHcpbyYtp1bTbU8mVy7+4/GjDch/uIOt4p/9NpUBlyJGbxVW0pgyDR8hI5Y88z5y0aJsAt6a1X36mReRgxZaXlVZrs/EXobT9N0AyYo2U3SK6wKu9zAO1hbX1yu8scTZLPUr5xS/u27+2hueraWF5GnfBmCdoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0zLB135; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so1057173a12.3;
        Thu, 20 Feb 2025 00:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740039086; x=1740643886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gORQdWcxjjeK6bAaehY1vON9E7DkN1S+hDpTXfC6an4=;
        b=Z0zLB135SnJU48lvaRDPRwSAU01hL6swHP22jk0RphNsHMWRzgsrzoZoQ1hWkgc3kz
         KhCc/tEUoU2cAgf4mN85CIRG6LFzk/CvPnJFGoKKxLWZkkLLUxBknvRLsG1s9nFzVtIb
         NxvkJ8UHOVhjC6nF9fDjcFAWPhhU67xGOwK8otUr0wnz8xqHfZOC0ivsQejDbJapiwxN
         I+0zuuIbiQsbhoNqqJOjFdXr89UNxomg5zLF/RejgUunYmv7TeuuMm4+UHE1sDuQ03Ru
         y/DXuXBHiomc6AsA/289AxCFi2k+bXjPxquZhMx42bTQ9HgxKnMXtwpccRqKFdW/mQbk
         QNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740039086; x=1740643886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gORQdWcxjjeK6bAaehY1vON9E7DkN1S+hDpTXfC6an4=;
        b=kHF3+0a8qmHn5JJJqpajcYNEOmDGklBBoGeApOj3UYrEKg+buUW80sLh/Gdrq/ZO96
         7mjnEMokYkZCxgnMoOisU891H0sDhkjm0/O7EcX8t1GCLOiupiUz8sPfwBMQtE67u5ls
         Gt/rHN6K1hTKN2bPVSYadj3mS5viZPW6p+vbflZuWzW3pBdBHaoWTSqtn9IrN8NyoILf
         ctK+QVRe9HDV39dTycQzhEJG81B8d9dHXSD5Yicalt0v48Kq/IwlgOrg9+4AUdil7qW/
         DfRLzuhHgbV8mdA77ir0WW82n1CTVDXJ+NymlwrQauW2JP+0tgulVDXGtHQUGeOT0Ttm
         lLdw==
X-Forwarded-Encrypted: i=1; AJvYcCXHpO3yU6ObQ6/WDoRXfbVvL5CQG3223TYFWiRBRJPp5SQcZMJHOrbU9SvmmlrBY9dnGJ6J4NAny1K082E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwVtGlpvD1+8wBUm4+zK4a/GayrUzBYjrT6ZGqaSVgfbZvvBdn
	aApKpb/y10OyIbYJKowa3FMACqQhuG6KPj48QbH/YwU71SbWVk4J
X-Gm-Gg: ASbGncuJqTA0bpsEWXvE0HrxQqvR/Jo+kH8JLJb38hfjDg36MpPWpSuZVoyYiT7VuA8
	UzqdUODgF57T6PvtlWI4OYGxJs6C4pVppuU9UIqE+twJG8h4AF+Nf3PjzQunhhr2yRgAuZvpqbY
	Osrn5XOmf8pl5lSyEzunR1UDzdgxAAmPoO9KiFy/pBsRLrgU2Tho1x5Pmcu+WdxKV6d1aIjDGwV
	00WW+sgsXZD6L4SREDsJAcUip00Gojk0claZdxbCaFFr62qfHCoZewpIcNRqrMautYwxo0OunA/
	SZpiEup9enGRl0VkUQE=
X-Google-Smtp-Source: AGHT+IHQL4G1sEuXWxgbgH9kDqBZvrmRjg3l77gCr3Rt1IgGFRlCL/kA2hdAaY5j4Jq/YALaP1ohzQ==
X-Received: by 2002:a05:6402:51ce:b0:5e0:8261:ebb2 with SMTP id 4fb4d7f45d1cf-5e08950c0aamr6468527a12.12.1740039085543;
        Thu, 20 Feb 2025 00:11:25 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:604:ea00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270967sm11636298a12.55.2025.02.20.00.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:11:24 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Thu, 20 Feb 2025 09:11:12 +0100
Subject: [PATCH net-next v2 2/2] net: phy: marvell-88q2xxx: Prevent hwmon
 access with asserted reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-2-78b2838a62da@gmail.com>
References: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com>
In-Reply-To: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

If the PHYs reset is asserted it returns 0xffff for any read operation.
This might happen if the user admins down the interface and wants to read
the temperature. Prevent reading the temperature in this case and return
with an network is down error. Write operations are ignored by the device
when reset is asserted, still return a network is down error in this
case to make the user aware of the operation gone wrong.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 342a909a12a2785ad579656eb369c69acaace9d1..ea9a2a923146bf432a33ff46b606c08debb69a4f 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -698,6 +698,12 @@ static int mv88q2xxx_hwmon_read(struct device *dev,
 	struct phy_device *phydev = dev_get_drvdata(dev);
 	int ret;
 
+	/* If the PHYs reset is asserted it returns 0xffff for any read
+	 * operation. Return with an network is down error in this case.
+	 */
+	if (phydev->mdio.reset_state == 1)
+		return -ENETDOWN;
+
 	switch (attr) {
 	case hwmon_temp_input:
 		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
@@ -737,6 +743,14 @@ static int mv88q2xxx_hwmon_write(struct device *dev,
 {
 	struct phy_device *phydev = dev_get_drvdata(dev);
 
+	/* If the PHYs reset is asserted it ignores any write operation, return
+	 * with an network is down error in this case. Without returning an
+	 * error the user would not know that writing the temperature threshold
+	 * has gone wrong.
+	 */
+	if (phydev->mdio.reset_state == 1)
+		return -ENETDOWN;
+
 	switch (attr) {
 	case hwmon_temp_max:
 		clamp_val(val, -75000, 180000);

-- 
2.39.5


