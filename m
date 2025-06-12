Return-Path: <netdev+bounces-196853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7410AD6B18
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEB33AF0C9
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00FE244EA0;
	Thu, 12 Jun 2025 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/FmAibw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2B923D29A;
	Thu, 12 Jun 2025 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717493; cv=none; b=rN9xF7JQw60CBnBcTddkda4yswIdieEsx6bSqz8JFSk+31E6wjh1a6XbFKojaUEOAtVc4AZ/Qli9Xhcdr0AZR/gJ/j0VIvvCdnPYypYf5iYBxyDSIF0d/Blvzvu0ttfDC8QiM/I0o+cINdT+Nab+V+93j1msdzO6PpSzk77MQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717493; c=relaxed/simple;
	bh=kpj3AK5rs+N9TYEtbGrRUGGXrqhAbf8sJlWbuq0dU0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gcj5GHn+CdJRObesuqcgmIcU/wLKRMMrr4tCdqpMqXUyYxnJLdJiJjhOXhPbGAm/mxMSCUuYGmsuO6vsH783CojDrIfMsbzjWsa44C++06QZi9MSIT6ncTnWjY5q5yYCDLyOhDXJi5I/Er+yz0+ZtGk9aKf441TUGSUHpkNVYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/FmAibw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1291035f8f.1;
        Thu, 12 Jun 2025 01:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717490; x=1750322290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjf4q87bTB3LUgZ001uanVcydc8/XjXZX0ocWOFGfQQ=;
        b=W/FmAibwUbSq32whkUEUN7TuWI1Cw8O711oS+XiYLhdTDq2oK5nperBetIIGyLLopr
         O18Q6Av0Mg0KyePYp4WSMm508fCHB9uQGfmA2jyp7KBelAwP/9YYeYQBqKQgczhws3Nh
         ueFpzPwMKd7YeIDVonsdBcSHKR/cw8B16+A/b8vMX7uVrawJoVtniJXmFSX+Q3FNxyeN
         lZEMsJXORFlE2Dg/hEntoRxJeYPoS3PO0xEzdg/k4zFfZxJx+V1iV+dX9xBaNzwD56gM
         v2I5wMAwnIhoV29Sn9qlgZGoj7xDkYJv+VgfxLAYZi0TorlyWHzj6iqTrTIKTcElF9rO
         +nKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717490; x=1750322290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjf4q87bTB3LUgZ001uanVcydc8/XjXZX0ocWOFGfQQ=;
        b=AZXAS1qfpP5n3q2/unKv3lwcuJzOUhddG4DjdGGN9GBTGqNeSqFNuKJCf8twK69Alw
         +NRsKiN9DuFgQJcMkymUGvOsceEkd1ItkVudNoS7Qab0GEQUJkkGAN1sFPWNi/rAWFGC
         B32zk58O1QRuobrI/8Mo0CQ9ybVI6rFfyt6HZnPj0ZFMGafKUahpVSGGrMv0mfy5mGUA
         bac71TTIrhbwkaOgoHHUF6XdWeYv4uaYad9nfhJZYlCuc0fcmYg4hm8HIKLTYFf2B2g2
         kzkqSqFiLv/Kwq/MqynQJzXxB6ulDV9LtgBYk41BXizs3+yGdHUbnK9LpEbMgbxWZ/ds
         asMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEePwg2q6zbVUZF9z5qvR7AA20r7Dhy7UdDB67e/csuECAHKGrb7zWq0gCuifMFbWsSYfsuapuzkpKImk=@vger.kernel.org, AJvYcCVCzy9M59JIOz/5mySOsZec+rdwlDFGH3sosaI2umvNx8UqjzXEglI5VZNngb1e8Ey8gBjVS6MR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4s5iQBrLYgvnF+viMiptYafIKECi/W51VZLX56kV6lF9n0y1O
	tq4539cqNoYIf8Rr0wA+6skp7fOp3THNbNAA7xWYTFZF+I4bc9lSRxDx
X-Gm-Gg: ASbGnctMyojWDofCkCtQIRh4rwLcRn3n7N/rawLBMdFAxNxQHmBaIo4hQWRJHDsfsa5
	yD0ddqk8qPx0KBZGg4cLzWZBNndfzKyxJRC9RX3G+8EphmugbkaMDtVHGPxhfdZU6ZSQSxjuhna
	VCk6qTGiAWBWJM0VTKqobYRbc4AIrkbeKbmf3u4crBGSfrCwf1XMfzzOEl8x3ac5zH2fp5LeI2b
	0aQU7gTjcByI4uR1zKoUxOSP+V21aFFBuzLfMb3di7pw41tjanZbTACHs6bgMpFoJpWp8fWzx3T
	OCfuLt8LmA1xgfyN+GlSM+eiFiGqowMr8kX05ri3miqMU8lgVFaUVDbIOATVOYJcSZmqlYlb8Of
	9Milf4bpYz3vQAYmD4TR33HeLRUxBsgnn+e6+PbqExOOubud/efbwJR1u1sWhJWeraxG6uyGNw0
	XiyA==
X-Google-Smtp-Source: AGHT+IGSTzOzf0ROryRS3ep5kgJSyB0a008xyqqyJ+bk19UPTMzotMcnP5PdEEqK6qqQJ6Wg07DMdQ==
X-Received: by 2002:a05:6000:240d:b0:3a4:d685:3de7 with SMTP id ffacd0b85a97d-3a560778f99mr2248674f8f.8.1749717490349;
        Thu, 12 Jun 2025 01:38:10 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:38:09 -0700 (PDT)
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
Subject: [PATCH net-next v3 14/14] net: dsa: b53: ensure BCM5325 PHYs are enabled
Date: Thu, 12 Jun 2025 10:37:47 +0200
Message-Id: <20250612083747.26531-15-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
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
 drivers/net/dsa/b53/b53_common.c | 12 ++++++++++++
 drivers/net/dsa/b53/b53_regs.h   |  2 ++
 2 files changed, 14 insertions(+)

 v3: add changes requested by Florian:
  - Use in_range() helper.

 v2: add changes requested by Florian:
  - Move B53_PD_MODE_CTRL_25 to b53_setup_port().

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 3503f363e2419..eac40e95c8c53 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -660,6 +660,18 @@ int b53_setup_port(struct dsa_switch *ds, int port)
 	if (dsa_is_user_port(ds, port))
 		b53_set_eap_mode(dev, port, EAP_MODE_SIMPLIFIED);
 
+	if (is5325(dev) &&
+	    in_range(port, B53_PD_MODE_PORT_MIN, B53_PD_MODE_PORT_MAX)) {
+		u8 reg;
+
+		b53_read8(dev, B53_CTRL_PAGE, B53_PD_MODE_CTRL_25, &reg);
+		if (dsa_is_unused_port(ds, port))
+			reg |= BIT(port);
+		else
+			reg &= ~BIT(port);
+		b53_write8(dev, B53_CTRL_PAGE, B53_PD_MODE_CTRL_25, reg);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(b53_setup_port);
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index d6849cf6b0a3a..880c67130a9fc 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -105,6 +105,8 @@
 
 /* Power-down mode control */
 #define B53_PD_MODE_CTRL_25		0x0f
+#define  B53_PD_MODE_PORT_MIN		1
+#define  B53_PD_MODE_PORT_MAX		4
 
 /* IP Multicast control (8 bit) */
 #define B53_IP_MULTICAST_CTRL		0x21
-- 
2.39.5


