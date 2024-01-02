Return-Path: <netdev+bounces-60924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF35821DCA
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B12A1F22A7F
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0567F111A5;
	Tue,  2 Jan 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVX4Zr9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1E511718
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso3479635a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 06:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704206286; x=1704811086; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaCf1bVys3JfzwCvSEkXX/9JBhqyL9AY3m8awYnU7BM=;
        b=UVX4Zr9nl3UlN0DGihg/ZTF3N2bNpW6A63OPH6CvoPBwOc7MMFQytr0Yr2HYFdSO76
         R7nb6uOUfI0P8Pooythghr5KwA2+hkoONFlvDJsdRz+htG6oy3Dy5JVwonj5V/uWpofE
         IV8/74Sf4qof5hDOsYLPktFPbzmPgn9qwcOUkHjGwZyATkHsFg4ldktwKpd+DSUs4/dg
         /mM+/zB/Z8z+Qbh2wFxYkdGXdSme6eGmsvfwjjShVBUdzW3l6e1NRGenXtWy3y+8nwFx
         wExrvwhxAiYpoIwcsIOjOB0MiHekiUvByof1ZNINxaYbDKYaRgmp3R2U1C5NlMFgrrfR
         WnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704206286; x=1704811086;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaCf1bVys3JfzwCvSEkXX/9JBhqyL9AY3m8awYnU7BM=;
        b=XjEeIhMC5IyBeKuV7BhpBME/eGmce2zS20pc4+dvrFQjN4Msm3ijJWM2q0XLONSquE
         7A/NKKZNbk06mUo/7EASEv2/B+rIaPVVZ55hx1R23LtgW8wWM27o55ut7ngiit3pp270
         ZmzN8PqYiBQn5jXUG/divYWTEOwfvn6vLG1xAS7KGQFaiI6xirQrgzOPFfgTDI7rEFZH
         KzTCbw/q3KWjwChUqVhMisQVteBFvgd4J5l63z47AD6VqKsKnINuIOu7zdGornY9jXxL
         ApEvmzjBKXZ65FYKhh+bcw4QCqbmhjS+QSPo5bbHrI6UWNdvFePaZg/o8VSvOGlXh/0L
         dyZQ==
X-Gm-Message-State: AOJu0YynX7EIZbRmyAhZXy/fC0PKuFJCt/QzlmFG2VMKR74+p7tpLbXR
	/0uhccxq3huDSJn7yJu2vg8=
X-Google-Smtp-Source: AGHT+IGLzphuqTAK2h3K8mjAK5qGTdnm3GmJ8v6kSj+kqiL74n30moOM7PMsQOSg4abypu4J1MRlBA==
X-Received: by 2002:a17:906:2bd9:b0:a27:5f87:4d5d with SMTP id n25-20020a1709062bd900b00a275f874d5dmr3695743ejg.103.1704206285587;
        Tue, 02 Jan 2024 06:38:05 -0800 (PST)
Received: from ?IPV6:2a01:c23:c1df:9400:2dfa:6a98:a1f2:c23c? (dynamic-2a01-0c23-c1df-9400-2dfa-6a98-a1f2-c23c.c23.pool.telefonica.de. [2a01:c23:c1df:9400:2dfa:6a98:a1f2:c23c])
        by smtp.googlemail.com with ESMTPSA id kk25-20020a170907767900b00a278953ea71sm4253570ejc.91.2024.01.02.06.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 06:38:05 -0800 (PST)
Message-ID: <c379276f-2276-4c15-b483-7379b16031f7@gmail.com>
Date: Tue, 2 Jan 2024 15:38:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RFC] net: mdio_bus: make check in mdiobus_prevent_c45_scan
 more granular
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Matching on OUI level is a quite big hammer. So let's make matching
more granular.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
This is what I'm thinking of. Maybe the problem of misbehaving
on c45 access affects certain groups of PHY's only.
Then we don't have to blacklist all PHY's from this vendor.
What do you think?
---
 drivers/net/phy/mdio_bus.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 6cf73c156..848d5d2d6 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -621,19 +621,27 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
  */
 static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
 {
-	int i;
+	const struct {
+		u32 phy_id;
+		u32 phy_id_mask;
+	} id_list[] = {
+		{ MICREL_OUI << 10, GENMASK(31, 10) },
+	};
+	int i, j;
 
 	for (i = 0; i < PHY_MAX_ADDR; i++) {
 		struct phy_device *phydev;
-		u32 oui;
 
 		phydev = mdiobus_get_phy(bus, i);
 		if (!phydev)
 			continue;
-		oui = phydev->phy_id >> 10;
 
-		if (oui == MICREL_OUI)
-			return true;
+		for (j = 0; j < ARRAY_SIZE(id_list); j++) {
+			u32 mask = id_list[j].phy_id_mask;
+
+			if ((phydev->phy_id & mask) == (id_list[j].phy_id & mask))
+				return true;
+		}
 	}
 	return false;
 }
-- 
2.43.0


