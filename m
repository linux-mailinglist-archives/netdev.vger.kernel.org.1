Return-Path: <netdev+bounces-194657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E122ACBBDC
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 103607AB4D6
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5CF22D795;
	Mon,  2 Jun 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj0V2lnB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D5822B8D5;
	Mon,  2 Jun 2025 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893208; cv=none; b=ky/d9PChMVMYQGVS/Q6l7DLD3U7tJ66hdjEwhVIEIPpdOJVCSDLFIcEuk6d3zYAPRaO216Z37vh+ehmCtCY5JvzyKU7rIxRmjmmZonaGNy4mOPngA+woZ1jCoCJ9iw/Ap8lsBHZCcajwkDBNow2pMc9wsNBjp9mHLt2jm+WOtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893208; c=relaxed/simple;
	bh=W5lvTQJx8Rg2GZ2MP+aKOXYOVUr4A7PTN2EZRYjapYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRFvDTZHTT6f4Oo9R2wQISXCxNuXAXylcjJi7DWDY3eXYPQf3+MWaRKOf4O5FpwE08wYCM/Nga7nRjcdByZvXxbZmBf7h/Mxu+8ZdnqcHmkYLz/jYcsp3VuQM5HqtK+6k/mnSTWJu49y7TXhoMjSIhX6fQOa++4qWL99u8A/2j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj0V2lnB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad89ee255easo883048166b.3;
        Mon, 02 Jun 2025 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748893205; x=1749498005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BTL5MAqEteMn2C6CJSs7Xxb84R1E6RDMzhMA/qaLVA=;
        b=Pj0V2lnBYvoGTPyZEzwGz6BaInBDqGEgAWOmMUb4Ye9bSpM0lEmRobvrNWARwYWDqB
         P/1gNjpxakg3U6WkUWBHp+cNQlNLzK2Loz/9ip9OoKaJ+8EamOf84UJEUdu/ss1YdCnK
         BxaKsn4/Jm3VoGBQy8Zu8pNOH95ieutLe5hS4y5MIW9sbvCqWEZo0BXUVJVXsvvz5/kO
         b8n4dCIcDptaPIZkQoY7YqjEWxqdDVzejhwLIFIygjQlm49ppQWW72Vga9UznUaZwHe/
         8IgP8L9nNOloRB2t6XpkW4vX5pOGrwmOWVcRHG9+SblWVh+3AuzTEGiw7x/IkS2L64xD
         arqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748893205; x=1749498005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BTL5MAqEteMn2C6CJSs7Xxb84R1E6RDMzhMA/qaLVA=;
        b=pj3HyeGG1d7cxVG+zsWqFKWOmHrZzdPpURdZYSm3h74uFfH7j8R4KUca9H3vERzXFc
         XN073N7fQihxOIM7PnHfhacGMxkSzlnGw6j/MPYufFte9vb4RhTCk5ZfI+AzcXWK3U0L
         hteYqF5agjKqIN5fLuBQMhXhaJ+gjctjQNNG1RkZ2IVabhvKx3G/7AJJ5weO0Biv3zlA
         ubOuMl0bpc75+uoLTcCb/Yf1PhIr9kBlNG1qaMeuOPIfXKIhzfMDdmD3tolZ9onN0Z41
         g5nRfZkUfg/+N4sX0Wa6AdbxgSaoIANFlrtfeEr4YDw2EwG09Mot8yl2GRxJBj1GyDac
         1hMw==
X-Forwarded-Encrypted: i=1; AJvYcCVchPVU8Elz2EAPFgKZ26FqOcRh5BkSCCgDIXlJB1htfWgDlag4LSTxcq/pIToLb4fg9DlIW+py@vger.kernel.org, AJvYcCX7Gd/RVrTxUthq3Zi1euAK6qJxOnGTEpuecQF5WnpkQUOu1zBNkaVyoHq84KocWHhJn3zUQLdhLOKunqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykeVwbaRrztmXXQd+nv3NMZYsifhnlvmRZoqdc87b/u19N25B4
	nbTf0aYDspCHoDmuh2vdIwyMe92LrzF+NOeE/nLec8kdVOuWKwFqzDvJ
X-Gm-Gg: ASbGncuSuuNqY+2pIqVgQpGtAc+rX387hsNQ1P4/w31v3Hzp96pNOeZCJKB5N3dNx83
	KqgOD52q/JGZ10aZZO+yxs2Qdxam40wr4MxE5kFweRDrKHKE4h+L6z2aQ0wx62m+5E/0dNq+VpW
	DLue0TBcl/RGrEBJbV5aMNQJ38K5grgeYG4Ps/BBLFOmlMwYYLxBLLGAhX9UYQ9HdArYCvD+YQh
	DWoJv5QEMOyln/3TGB5Y57terRuVAuI+9JW/u02hHhtUL7CrCwHJGt7O6YmmUt+Yu3dlpqZcaNL
	XLtSGb6YtiHyHD0mMeHL/fbiHxJH9B9evg4BtX6lCsVctFUsMsZj6u67Zp9via4hoOHRmdAzQxr
	jlZ9qpA03bmUn1tG6eGMVFXBFgIbzaZg=
X-Google-Smtp-Source: AGHT+IEqz3Qmt4vvH+dy3OjSllvjqINR9VvmuImfx9Uc2G1BzrLLX4CcXXU1AXe+rWU4Oad0XWPB7A==
X-Received: by 2002:a17:906:c143:b0:ad8:9428:6a3b with SMTP id a640c23a62f3a-adb36b05316mr1286729866b.5.1748893204835;
        Mon, 02 Jun 2025 12:40:04 -0700 (PDT)
Received: from localhost (dslb-002-205-016-252.002.205.pools.vodafone-ip.de. [2.205.16.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6a76csm832322866b.165.2025.06.02.12.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 12:40:04 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 5/5] net: dsa: b53: do not touch DLL_IQQD on bcm53115
Date: Mon,  2 Jun 2025 21:39:53 +0200
Message-ID: <20250602193953.1010487-6-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602193953.1010487-1-jonas.gorski@gmail.com>
References: <20250602193953.1010487-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to OpenMDK, bit 2 of the RGMII register has a different
meaning for BCM53115 [1]:

"DLL_IQQD         1: In the IDDQ mode, power is down0: Normal function
                  mode"

Configuring RGMII delay works without setting this bit, so let's keep it
at the default. For other chips, we always set it, so not clearing it
is not an issue.

One would assume BCM53118 works the same, but OpenMDK is not quite sure
what this bit actually means [2]:

"BYPASS_IMP_2NS_DEL #1: In the IDDQ mode, power is down#0: Normal
                    function mode1: Bypass dll65_2ns_del IP0: Use
                    dll65_2ns_del IP"

So lets keep setting it for now.

[1] https://github.com/Broadcom-Network-Switching-Software/OpenMDK/blob/master/cdk/PKG/chip/bcm53115/bcm53115_a0_defs.h#L19871
[2] https://github.com/Broadcom-Network-Switching-Software/OpenMDK/blob/master/cdk/PKG/chip/bcm53118/bcm53118_a0_defs.h#L14392

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* new patch

 drivers/net/dsa/b53/b53_common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index be4493b769f4..862bdccb7439 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1354,8 +1354,7 @@ static void b53_adjust_531x5_rgmii(struct dsa_switch *ds, int port,
 	 * tx_clk aligned timing (restoring to reset defaults)
 	 */
 	b53_read8(dev, B53_CTRL_PAGE, off, &rgmii_ctrl);
-	rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC |
-			RGMII_CTRL_TIMING_SEL);
+	rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
 
 	/* PHY_INTERFACE_MODE_RGMII_TXID means TX internal delay, make
 	 * sure that we enable the port TX clock internal delay to
@@ -1375,7 +1374,10 @@ static void b53_adjust_531x5_rgmii(struct dsa_switch *ds, int port,
 		rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
 	if (interface == PHY_INTERFACE_MODE_RGMII)
 		rgmii_ctrl |= RGMII_CTRL_DLL_TXC | RGMII_CTRL_DLL_RXC;
-	rgmii_ctrl |= RGMII_CTRL_TIMING_SEL;
+
+	if (dev->chip_id != BCM53115_DEVICE_ID)
+		rgmii_ctrl |= RGMII_CTRL_TIMING_SEL;
+
 	b53_write8(dev, B53_CTRL_PAGE, off, rgmii_ctrl);
 
 	dev_info(ds->dev, "Configured port %d for %s\n", port,
-- 
2.43.0


