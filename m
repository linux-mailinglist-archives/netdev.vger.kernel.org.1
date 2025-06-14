Return-Path: <netdev+bounces-197732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B91AD9B31
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BAF168F54
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706B022D4C8;
	Sat, 14 Jun 2025 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5L8Q1uN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454D213E74;
	Sat, 14 Jun 2025 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888027; cv=none; b=nhdqZ/wI0B0ETkV17v+LVgk4Yj/lzawum77285TFAcbTFdSLkEKzjKcK9+ugL622HNR8ugknETNpHrs9Wm5QdkrQf1gpYF8NFOEueHQkASQgbvpwFtZzwvuWkjXKLZQ4Y2p3d4xpQyL9evaG4HRBtftfrZy6+AeJ2gzlc9YhSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888027; c=relaxed/simple;
	bh=7a28u0sKXG3vFOdz3Lc+cqRQFxQheFOFMjSL4DZVfWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIoz2ZqgrhK7PNgQLlTtefPzIjoPfPHK5PEOL/PxSsEg7VFo87bRAbMBohuhBYn2Lf+1nuEeQ13yfjDpKaLAtY7lgE3AGRdzOQcuNrIc9kWoiTNkj+7Im/JQOBQfMD5K+1dAm/8PifSQRjd4x5b0V/GWmYpx2V/FZ408hR7VXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5L8Q1uN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so24620445e9.1;
        Sat, 14 Jun 2025 01:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888024; x=1750492824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPmrqGXQSm3KfbZ3QMibfb2/1EkzzyHSibvqUxxDwrQ=;
        b=k5L8Q1uNgcoZxNro0v2aq3/At8YlL7+cRx76RYssOFBox5xXax5tkgUdgf0e9n4ek0
         0gxPgoEm3Zy0g9AvxWPp2r6XdcMKdQFUNtvS7G8K0rBs4hLdNU0oz9rFSY8nyebuuMsK
         AqGG/kD+yguhjziDQZKopYTvZrq0Zh5Q4CqXdwU9jDnRCcjn8OTWiPQS6SFztU9HQC5t
         YyO+aypjeJpeUeRWe0xI695PoMU21xOvwzQqF45MgY8g87QHwm706Tk8yEsMZhj4dyw9
         qariL36hrV+aoew0ePGtnWckar3CEeEahmV9TO9i4GW0pPGCq+A8rh5jx3wCc0GLj28r
         jfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888024; x=1750492824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPmrqGXQSm3KfbZ3QMibfb2/1EkzzyHSibvqUxxDwrQ=;
        b=nyt7exy2qrj4Qv/Gy6iwGjZfJWGKB8xKuTz9kY1822Ydmuznv0IFj5qPRDBNk8HzIu
         fC4ucAyjSNu6HMrCJqECKn7AZEB6owul+xI/5PfC5Rvtn9z2/FM663r6QApSe90hdR1q
         YH7otK8y18tU9RIk7ELl/iy1r2pDNyPvVwSa2p5IGbMq+TWNz/Y0xXzVgqqvwzZxsQuJ
         llPXU4e1mwIZ0UnHBfH0V2PSJzaNpSm7ReszasdSZoXKAtifAtot8Nu/9/ab24mDMo8B
         f+L2yE+nLlRN8OU2oyc8hhrQVc5jAyLdcN8bG00Jr5qMUp+ubDtKUpMp5ISunq/OOIx8
         J3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeyBWo8xoYwpCZqDgegeeuiVr+QEUIgCeo0e/jvq+E5NX7cx3WJRx6N2G9erva28mYmFjNoUsU@vger.kernel.org, AJvYcCWVkuWZo8+nfciG7BXa1CCetCKuU4tvo8Z4X8rsOG4oAqN8kF+8VudXBbEMkUpJXexqOlMcvGmCeRhQsqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRs1eEk5b+wphCi6+ZQNTlMXtp2dqb+0EowOXU86AUBs1sQEwQ
	ZM04ZVMkwRKXF1rdZdWYWkq33cAHzCYhhlYHZWs3B+u2HC/DFA5XgiV6
X-Gm-Gg: ASbGncsMYpniYIwH+nC1nocjpsXEDQ+TWplGydtVJ9yJE0Vksf5Wbvkv5KmOOJDagTk
	OswqWK9hc4hyIMU7+Czt3iEdhYWfDtfZqynx8xW9GZcRaz+X8J1HKNDm8ppRTBGhNFV0jr26avL
	qZV071P4O6tvU0QM9pRtZhQTTOFuCw0/NQdxHtRItbSeiQ2I/kXIWWe216K2szwaHPK18tjHh7s
	7c2bjtmwLQXkMggg0c1NZPORZMsdE2dD1Zs2WhyYKFHPgaeOK+P57w0kYaVOib9J92yJP2QGrSe
	Wnms2VUaPMOaMJo0M1VKkBwHru0/OvaOjHQ3qxS6k9sPLM2mJS3t7pYJBV8RxeEI8tPsavzXRvP
	TKZydmPf6YbjQbjBmBxWNoLvNUxCavn5PMGAKFCA0pNBRyVMJNo34hSyNB3VeBejKpD6Nd1je1w
	==
X-Google-Smtp-Source: AGHT+IEhfGlHP+zql732Tqtn/wDmxZs4K4d5mAMoyJ+oqHAOC0ufQkaosT+ghLdgpzXRaYCMBT9F3A==
X-Received: by 2002:a05:600c:35cc:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-4533ca43db6mr23361945e9.7.1749888023794;
        Sat, 14 Jun 2025 01:00:23 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:23 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v4 14/14] net: dsa: b53: ensure BCM5325 PHYs are enabled
Date: Sat, 14 Jun 2025 10:00:00 +0200
Message-Id: <20250614080000.1884236-15-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to the datasheet, BCM5325 uses B53_PD_MODE_CTRL_25 register to
disable clocking to individual PHYs.
Only ports 1-4 can be enabled or disabled and the datasheet is explicit
about not toggling BIT(0) since it disables the PLL power and the switch.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 13 +++++++++++++
 drivers/net/dsa/b53/b53_regs.h   |  5 ++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

 v4: add changes requested by Jonas:
  - Avoid in_range() confusion.
  - Ensure PD_MODE_POWER_DOWN_PORT(0) is cleared.
  - Improve B53_PD_MODE_CTRL_25 register defines.

 v3: add changes requested by Florian:
  - Use in_range() helper.

 v2: add changes requested by Florian:
  - Move B53_PD_MODE_CTRL_25 to b53_setup_port().

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 29f207a69b9c..46978757c972 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -660,6 +660,19 @@ int b53_setup_port(struct dsa_switch *ds, int port)
 	if (dsa_is_user_port(ds, port))
 		b53_set_eap_mode(dev, port, EAP_MODE_SIMPLIFIED);
 
+	if (is5325(dev) &&
+	    in_range(port, 1, 4)) {
+		u8 reg;
+
+		b53_read8(dev, B53_CTRL_PAGE, B53_PD_MODE_CTRL_25, &reg);
+		reg &= ~PD_MODE_POWER_DOWN_PORT(0);
+		if (dsa_is_unused_port(ds, port))
+			reg |= PD_MODE_POWER_DOWN_PORT(port);
+		else
+			reg &= ~PD_MODE_POWER_DOWN_PORT(port);
+		b53_write8(dev, B53_CTRL_PAGE, B53_PD_MODE_CTRL_25, reg);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(b53_setup_port);
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index d6849cf6b0a3..309fe0e46dad 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -103,8 +103,11 @@
 #define   PORT_OVERRIDE_SPEED_2000M	BIT(6) /* BCM5301X only, requires setting 1000M */
 #define   PORT_OVERRIDE_EN		BIT(7) /* Use the register contents */
 
-/* Power-down mode control */
+/* Power-down mode control (8 bit) */
 #define B53_PD_MODE_CTRL_25		0x0f
+#define  PD_MODE_PORT_MASK		0x1f
+/* Bit 0 also powers down the switch. */
+#define  PD_MODE_POWER_DOWN_PORT(i)	BIT(i)
 
 /* IP Multicast control (8 bit) */
 #define B53_IP_MULTICAST_CTRL		0x21
-- 
2.39.5


