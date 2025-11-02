Return-Path: <netdev+bounces-234888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C10C28CFC
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 11:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40752188F4F4
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C92925DCE0;
	Sun,  2 Nov 2025 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulh8MNM1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C717BA1
	for <netdev@vger.kernel.org>; Sun,  2 Nov 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762078093; cv=none; b=faeLwjHI4tWAAsmlae0MEwVWFqVv6WAjm42khSWc4c/K3JfgJlMYrKGh588JkzjqVfLO6fRcdKaytOpS+P5wJTdRSmiMSArzWMcnFHkR0O+4MnXX6X05ejhtIhj7Sh+QFiAVaOuozvZ/H+MitZ7c4QEdOo1y0bT0mjUwzDJVzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762078093; c=relaxed/simple;
	bh=tA3WamGkzxLnaTBxEpR7Afe/4Mdf0Y+TETGijAd6X3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFbjT5Ol4XwV+7A38Ury6dqdDvDOYDFe/+IhPjJJhNqjqkMBkTFZAnn3QuxV3cDrvuEOY7Q1vP6GZjTBLxKfd2+2cmFunYWkoXo0N12LPpb9o7Ubzuojr1oO0pQ2ufx/bPGOLgoRMkTldwdEjlLnd7GZ3rKYPKtPS2aet2zgDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ulh8MNM1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d6984a5baso629689666b.3
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 02:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762078090; x=1762682890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aStBH8TctGPHxEfq/a3r8j8mNWuMDrDthcxYNhkb9VY=;
        b=Ulh8MNM1wo2zRPmJ6tJv0d8o55TBZXxc16eCP4y6E05SWh7sXjOZ1jEzBIGp5G82St
         fzGDzqvlGvUloXyzh7WwuEYNwUHLLyWmBOmjhNyxM6j6uobnA2UV6USHSU9xiMAZZmvv
         whQ2nLS5mzH6RjUmg8nEGwemJZToqHvJcpAtT1X9pyeo4CFtvRipaWfdyOm5gjpg9Q+W
         OlS9TkKrBy6ohwlq1PVlYKatWXRGDujsV4J/HFuG18zrRI4Szz1c+a01epWsC63oxVRV
         kd9j8f70jc2pv3FQU5Kv9aR45teXYYLlhK0thPL0JFceoll51yYjoQR2QBNdhwaDBXNj
         wunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762078090; x=1762682890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aStBH8TctGPHxEfq/a3r8j8mNWuMDrDthcxYNhkb9VY=;
        b=WuMZ634kKkom9fBaq3ZdxbdO2P8vN522ecAdnLhMssRejzCk0F1DCwSRCt4CdLP/Mw
         GBmq+yotF+KKeyiIivym0L0/tw/jmMCzNHx6BOGBncdsbE77l7CQV75q/vxIklIaWEs6
         Zi5lQ0Kx9YedYtgHIVZK8Qhz/CQhBBJhVnn3JZOdFZQJFwy5reGvAWD8GerVpgtGHfFE
         Md4nVyqDxnDj4WQGDFLNtcDIJX9ybo+EdLYvH3J+cykZUu45BEbZZHKXlTaGfbx6ERIz
         XBvEvtCre0Ges7swsJ43sqwa9Jk+yAKZdmEe96RKDplB5v9GGromDJvEZ37WOh3oBuI1
         8AUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp3lD1wbcOclb2DCy2KZIgjeFOSrsa6EilaI9l0jViOGTXmXGH73y/VC0FSPPzFrY6kCk2T30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcxXH8BLD01JZUDA2uNAJDFpv4o60TZCh+NecFO/aKKjKxcdUz
	f3i58Jmu9XLGslhUC1sTGwhChM6g54DMqgWREyGsEmsH9df4+Lr7YQeg
X-Gm-Gg: ASbGncudYVUAoJs6itFxEJpmi3snYSF5T3osyKW1Plxsp/xOZxLxjAncf1nx0TyYpIA
	/bJIzWMqRpwWUtEbaAxq7V158obXPPRlhtH0WmUyzEF1QMeMTrQOaB9DIhf9i1M00Ed3DiwVkSz
	QgUX8bl7mOKB1uOCrkEPfZJfi8UKYSd+6UKLNU2QoPvveHxPgmzHjICUibo+dGTvo3C9TxQyd8l
	Pi94JLUkPx+BnXbNF0Df11L2diUjVEdQRYHmZXmQVBnIvmWGT69Ums4PfQDuEV2MaV0kwe/QX71
	yX59DY/7igOcaaJIaKmFuyGVTmTtGuKb9IMz5u65SkO5IVxVpfXzSREqvSlFQTeJb4LLPsRM1MH
	8n6hZaKmZbcYFqesSiXG6dVRxlQ3aoL5XteaMx05CYSUh1ttypPJ2JsxAbSZwXPaUun99pZ0xES
	QXilyYRafFMsYErLmo+TmYkLkPcQGd52ridEY5ztkJtnY68kK4XWiWITh7WjPB28jAfieAkT6Jy
	YRLog==
X-Google-Smtp-Source: AGHT+IG+eEnbIVIr3VFTaiiIEVBICkxTvYmwrL5KabaROTdtYo6BQDIRH4CfNWGQGBfJK2kGkaj3aw==
X-Received: by 2002:a17:907:1b10:b0:b4e:a47f:715d with SMTP id a640c23a62f3a-b7070133963mr987837166b.17.1762078089780;
        Sun, 02 Nov 2025 02:08:09 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077d18d59sm687901766b.75.2025.11.02.02.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:08:09 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: dsa: b53: fix enabling ip multicast
Date: Sun,  2 Nov 2025 11:07:56 +0100
Message-ID: <20251102100758.28352-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251102100758.28352-1-jonas.gorski@gmail.com>
References: <20251102100758.28352-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the New Control register bit 1 is either reserved, or has a different
function:

    Out of Range Error Discard

    When enabled, the ingress port discards any frames
    if the Length field is between 1500 and 1536
    (excluding 1500 and 1536) and with good CRC.

The actual bit for enabling IP multicast is bit 0, which was only
explicitly enabled for BCM5325 so far.

For older switch chips, this bit defaults to 0, so we want to enable it
as well, while newer switch chips default to 1, and their documentation
says "It is illegal to set this bit to zero."

So drop the wrong B53_IPMC_FWD_EN define, enable the IP multicast bit
also for other switch chips. While at it, rename it to (B53_)IP_MC as
that is how it is called in Broadcom code.

Fixes: 63cc54a6f073 ("net: dsa: b53: Fix egress flooding settings")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++--
 drivers/net/dsa/b53/b53_regs.h   | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 2f846381d5a7..77571a46311e 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -371,11 +371,11 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
 		 * frames should be flooded or not.
 		 */
 		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
-		mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
+		mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IP_MC;
 		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
 	} else {
 		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
-		mgmt |= B53_IP_MCAST_25;
+		mgmt |= B53_IP_MC;
 		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
 	}
 }
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 309fe0e46dad..8ce1ce72e938 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -111,8 +111,7 @@
 
 /* IP Multicast control (8 bit) */
 #define B53_IP_MULTICAST_CTRL		0x21
-#define  B53_IP_MCAST_25		BIT(0)
-#define  B53_IPMC_FWD_EN		BIT(1)
+#define  B53_IP_MC			BIT(0)
 #define  B53_UC_FWD_EN			BIT(6)
 #define  B53_MC_FWD_EN			BIT(7)
 
-- 
2.43.0


