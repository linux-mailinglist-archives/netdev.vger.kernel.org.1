Return-Path: <netdev+bounces-115933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE849486E7
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 03:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B2E2839E5
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 01:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397EE63D5;
	Tue,  6 Aug 2024 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="mjmcjfip"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984C6FBF
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 01:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906843; cv=none; b=LuqIfZ1xZkM5vRAkBJpN9X5mOTUUOCBnPEQN+o+NjLfj5OUxBMiOiqSNVmvj/11FAZAb9x2y1HzaAjSBDas+sQ6430p8WrjbfEXsiz2FvaZakW91g+KMwscK0E2b7nac/pQaZTs7S5kVHcAUwn4ryBdWOmJY2N79vGlq066+/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906843; c=relaxed/simple;
	bh=VhOpaUB++nSS8JaN1KKzR/SOFXteJzmkPDgJvfcxzJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oslkfRwlv/y9OMxBCVMmr+QDWrvuPpBLJSG97fD7rVULXLBvgZqbKQjSqvKvtuZmQQhfRql0hxX+1WlEg5FLe2iR5v58UWswnOsnxPJVv7ez1uQf0XS0qarjFHQoKQ0lAyxul04QIxv3dPnP02wqy0C9+p0g/qHrJgRTfi4ocxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=mjmcjfip; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d9e13ef8edso7173b6e.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 18:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1722906840; x=1723511640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AcP/ndjRlzAp+Mjtn/zIgfE1/PAubr4JGIESnJdralo=;
        b=mjmcjfipuwthLoJQpEeeeBqgCzWf9HUV/UZp0cPbLjsfmnITm5nSdwLDzvJl7nu62f
         AO6ozOCt1oBZeYMP2Ckg+/5H2sXcWaQ1/Zr5y49nhOpAksNvP8QrWKTU0y3zKppXRlff
         rbrVNzc4ssmb5WR82fC+WSrUiNo44PrCeb9ThzqcSbCUx84Wz92W5zEntUaZKV+5MqBe
         h7PjC/0ZcjPN6sLytddN6L45HPwDvkYrXbGomxlkEDHrk+oC30/NSl71QGBptDKScqqH
         58MYNnQazt3GWBQMivrxK5nF2mt4uAlC5Wl/H3Q3S+BPlFRyLl6p8/RbzsGC7U6cQLr5
         P/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906840; x=1723511640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcP/ndjRlzAp+Mjtn/zIgfE1/PAubr4JGIESnJdralo=;
        b=IfePHlspibobmJLTfhCwX6BWzoqCJt3fO2sAYN9za6KVVtJljlpBHjAMiV3xwJW5AE
         kKap2qV5T1XbOUkSM1+kBi0BNh/lo9iT3b1oWJtQTsPxA/G2EUdPEvKB0Oz4ppAWCSb9
         VR9InmNbUhOgd92ev5NU0XdfB5luWzSqxTDeqvnWBm94iAZZQSiWY/nwMdfJfiq3/CgW
         LRmvPmgSLYux8jYrcwstxFdurUNm/ES0Lxgu9qJaCtzaFCPpCCFIfefWCXuBZtjwOnBJ
         7cq2mb5sD2p9O6XwK3Ax1Cg+5CP5BPNN4/O8TDizLfU+c9VpDbsPsI7UjU6hVDfmwgWT
         8QdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpLjNv3Kbbcs2zW3zR+yEqUvZ1BZuFzpcdsyBGjLFh8XuO4Zv2PnCxHYSv1dZchNhc6U56nWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbXljN7zZkRA5R7CbIFcaQGCFL0VkDxOSQJf1igS/HgBi3lwOX
	o9uYx0Daj30FXBnj51plBmsPCxZBc5loH8GtB+tvDorOHCgIfSC4/p1EnngMk8c=
X-Google-Smtp-Source: AGHT+IGumus0X8RT7dPenHfw3+Bwaxk8Eq/hghdfXqTKFrXe8YIsKd7n4qBIHjulQ5aQt5HmQpoDXg==
X-Received: by 2002:a05:6808:301e:b0:3da:a032:24c5 with SMTP id 5614622812f47-3db5580dd35mr14499433b6e.22.1722906839847;
        Mon, 05 Aug 2024 18:13:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:f70:2520:9500:a63a:9060:e0f5:20f7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763a3fa2asm6083546a12.50.2024.08.05.18.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 18:13:59 -0700 (PDT)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: f.fainelli@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2] net: dsa: bcm_sf2: Fix a possible memory leak in bcm_sf2_mdio_register()
Date: Tue,  6 Aug 2024 10:13:27 +0900
Message-Id: <20240806011327.3817861-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcm_sf2_mdio_register() calls of_phy_find_device() and then
phy_device_remove() in a loop to remove existing PHY devices.
of_phy_find_device() eventually calls bus_find_device(), which calls
get_device() on the returned struct device * to increment the refcount.
The current implementation does not decrement the refcount, which causes
memory leak.

This commit adds the missing phy_device_free() call to decrement the
refcount via put_device() to balance the refcount.

Fixes: 771089c2a485 ("net: dsa: bcm_sf2: Ensure that MDIO diversion is used")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v2:
- Add a Fixes tag.
---
 drivers/net/dsa/bcm_sf2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index ed1e6560df25..0e663ec0c12a 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -675,8 +675,10 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 			of_remove_property(child, prop);
 
 		phydev = of_phy_find_device(child);
-		if (phydev)
+		if (phydev) {
 			phy_device_remove(phydev);
+			phy_device_free(phydev);
+		}
 	}
 
 	err = mdiobus_register(priv->user_mii_bus);
-- 
2.34.1


