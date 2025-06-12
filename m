Return-Path: <netdev+bounces-196847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C3AD6B11
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4557A7279
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE3E231A3F;
	Thu, 12 Jun 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+dWj4l0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A923026B;
	Thu, 12 Jun 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717484; cv=none; b=XqmurZGtKwLZWEqsDiiPhzZp99x1w1h/B4rQjuaGiREFASInNNKb0c9QiwLsZHkaW2NkWWdrNee7GEscw/+C9uNXJT+pxQgKw/trbYqROJ3ZdaWWUaHLoNd6aMDP9VGTYfHSgmn0QpPViBcqjKMDTuWvmhg+51Imt09TNeK+2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717484; c=relaxed/simple;
	bh=6Bv9CtWAluSfTpY1MxunvCcX8hhLpM+5VPzaJCnwbUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrXBN8It28lSNaMdkPv1bWuX7sF8QqOWeKS8u8TZGo7+/7pVrjLHOItc7mfoDsvjLBhpNPHfaixqmr2onYob2iZ1wFAfiQDC7pj61EDYNhXWsLkugl5D81FvlaXnIjo/qp70qLPt6BGfdzczthxFaWEVVFKyMPhqsgBLwgYRJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+dWj4l0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so3225675e9.2;
        Thu, 12 Jun 2025 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717481; x=1750322281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVCqFQgBOgpvWr0qP1ve65t/43M5mVqOsj8SRkrVp8A=;
        b=Q+dWj4l01rsoDvw6y/ItQfYXNOzGTFZgq602sizI46OucEmglwZAi9LOMBb9KADzgc
         iOUFfTVwuWDN4gHq1NMrswOH2kf3PFOeui+Ro3Sqn2KiBHYcyfE9w8EB+6o6Gvt2yGM+
         UyhhSpirfHTWObvYjvqWsANR7EN2396Nyx7D9WMNFfh12Dz6WUSaMWS8pDS5XlvTgrEB
         n3FWRQKh37obdZxRdqTsvy3wwxZcBzrM609zhASHtTOZyagIW97tPeyB0TfAEoXT+DEl
         DHGzB+acahuj+oraCR+T5d3lzMSfHbg/BcovWsEWB+kDNrLCF+INkL+mq6ZAJ2AZlhN2
         QHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717481; x=1750322281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVCqFQgBOgpvWr0qP1ve65t/43M5mVqOsj8SRkrVp8A=;
        b=bOQUu2ylXA8vQ2Og2+byQTK+a9BMEmxtDzF2WQGQAB/bsNhgw/nSzanAkZ8xO4Bq7Y
         u3azO5AFv2HEijn6mL640BqweBq7euwbeQXekfDxJnKAmJ3/pDivWMf/LJwNTFq/5MbV
         M37eEb4HIdY5Tvv1i/SNszfumGNUHzBX6KXnEUoWWSlWGY6n5189YkcV3t3WsZV7X/e8
         zX/REha/sDQlomv1feJjJobDjCScS558UUzwM5OrAGyi/HwsWucgYWCyTNqOTHmJ41vs
         9iCcrvzdwCcItWj9Oe9VziH9FjC1sKsJlqK00xKEeBI5VOa2sD647oegqEk4Ga3o2H/A
         TTdA==
X-Forwarded-Encrypted: i=1; AJvYcCUfdM+8+xRUf6SiBd5Ql+71algxRJoHRz6TpO92mVR0j6zLHHe0HJikh6e+gfoYEJj85wm2BDSyxzrXb4o=@vger.kernel.org, AJvYcCWb56HUvASBpxx6PgLbLC/MC8jr0WntYxXqtubgN8hNcXOqwBQBJ3Daz3zrgRyAJ6sSL4/4Kuy6@vger.kernel.org
X-Gm-Message-State: AOJu0YySEtP1FQ58O5H4NpJm/lsdp3TWRU07Upvmmdpt2h8BTSNE/5eU
	7V6AS3oqMrjVffivXbFO6uKA/+ZJ4ebROy578DHERdhtc/8b74F4sVhMXS2aYg==
X-Gm-Gg: ASbGncuwJgWPJlNINasAULZw4u0MLsWhr1twXcqApmET6vw8zrF1wmKXZIACAIZLV0r
	UGe/e62IO62vnXnKTQbrWt7AU9hOdF41kkfTuF2GIUpaMFqDSJbg8/Z2e0k8P4AsVLqQ+qoVci+
	R38OpBsxjgZlbK5rkJeK8DhPKX945HN5HNopdXOZ3Q+YlHAcSnoRnCGHTqdjFWxpgy0AZJE8Ztr
	TDzXvwJPeRoLzcT9+JP3n9YeVhDyCT9GSFBxNTflDzgZdMMGr5hD6IDs5G15W2abYA0vx+fR4sh
	RAeyaqML3wLJcNYQZ3MPJAFUM+QhIeW4d7dtaKY1n2QRM2a9ReKWpSV32hKyHAm44+DbgUYN284
	N1lw6rGDHBuYcleJ+mUgvjm9yM+66OKwgakseN3YeaYC5yJN6dM9e+dPRr8cFN0rCR56MzUlgIM
	7FfQ==
X-Google-Smtp-Source: AGHT+IGhXKZCerwbTJkbV217nr0v6xUWh3J/DJyXNEfoP5GwfsL0KqyN33WOSLrCj6DvIgAGCxkB8A==
X-Received: by 2002:a05:600c:1395:b0:453:cd0:903c with SMTP id 5b1f17b1804b1-4532486b8b0mr63101385e9.2.1749717480301;
        Thu, 12 Jun 2025 01:38:00 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:37:59 -0700 (PDT)
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
Subject: [PATCH net-next v3 08/14] net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
Date: Thu, 12 Jun 2025 10:37:41 +0200
Message-Id: <20250612083747.26531-9-noltari@gmail.com>
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

BCM5325 doesn't implement B53_UC_FWD_EN, B53_MC_FWD_EN or B53_IPMC_FWD_EN.

Fixes: 53568438e381 ("net: dsa: b53: Add support for port_egress_floods callback")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 18 +++++++++++-------
 drivers/net/dsa/b53/b53_regs.h   |  1 +
 2 files changed, 12 insertions(+), 7 deletions(-)

 v3: no changes

 v2: add changes proposed by Jonas:
  - Change function flow.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index b8fe0b24a8341..f898ec1a842fe 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -366,14 +366,18 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
 		b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
 		mgmt |= B53_MII_DUMB_FWDG_EN;
 		b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
-	}
 
-	/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
-	 * frames should be flooded or not.
-	 */
-	b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
-	mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
-	b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+		/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
+		 * frames should be flooded or not.
+		 */
+		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
+		mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
+		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+	} else {
+		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
+		mgmt |= B53_IP_MCAST_25;
+		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+	}
 }
 
 static void b53_enable_vlan(struct b53_device *dev, int port, bool enable,
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 1f15332fb2a7c..896684d7f5947 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -106,6 +106,7 @@
 
 /* IP Multicast control (8 bit) */
 #define B53_IP_MULTICAST_CTRL		0x21
+#define  B53_IP_MCAST_25		BIT(0)
 #define  B53_IPMC_FWD_EN		BIT(1)
 #define  B53_UC_FWD_EN			BIT(6)
 #define  B53_MC_FWD_EN			BIT(7)
-- 
2.39.5


