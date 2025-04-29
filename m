Return-Path: <netdev+bounces-186850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84766AA1BFF
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C431BC2ACF
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F9A2750F9;
	Tue, 29 Apr 2025 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrINI36P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B662741D3;
	Tue, 29 Apr 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957862; cv=none; b=o/4it400FDjklCArH9IUHvHjQ930c3lbTKJkAhdVBSGpk/GJAobxzw7J2qohAubdfdjD/US4gCishvuvOoHpSVwvklMmyDccrbLFQcgTaSOiTukIIlLiVj1tCRKO3EM0ycbcRxR8FE0A5leBQP9tcJ9TV9tReuSwjlE5aMrmeKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957862; c=relaxed/simple;
	bh=NC6BjIlDW2bse6NI2QYcaBzkHqHpmEvDywCM6E3fajI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9Yq1B3yzIXtJxbcEjbMoCZrfsFq83ABtna9qb9Ey87g9rwTJXnBfr9WTkzBzm/5+qTZlKX10i+H1pyCuXYvkM1XCZsZuee4NaVd2bCcqPFw1OoId9KhQ2DI01/fzv9iGhGJA5dfL6aYy3o5/B9/FTqtBshRbGZ72CZ8oMVxprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrINI36P; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2c663a3daso1284684966b.2;
        Tue, 29 Apr 2025 13:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957858; x=1746562658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FDeoPkfxPm46C6PaSQAiFc6ilbuBJH6D2vRzmLBaXg=;
        b=RrINI36POWixJ8b1ryyma7Bc96Lc9T8pUKUB8lTTi/E7ffDYnr9ywobmeu1b1KFdwc
         t0IV4lwbSIuh4kTfUjKdvlf2dyYIEZep7MTTujxxRHjRihOngngQCF7aAA75dKGCVIHP
         +rMpF56QNlqnUamLJLTBt72PsdJoOTlW3hHXgj/UrrtJe10RzEyv9HRpymOMhMwH9FZx
         DGYslGY47PBwjPQI1kEGlzUSV5a8h+iNorBAvh5TQa3feGwaPcTQhj2AMA3YTauhmxji
         zuwY9hYlnNoS7ulhL9O1hR/Yuviay25pCWS+7jewHNmoL/jK8DkeGhM3nS+L9Z8BhKgz
         d5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957858; x=1746562658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FDeoPkfxPm46C6PaSQAiFc6ilbuBJH6D2vRzmLBaXg=;
        b=ffkxsC4O6nEDyfxpNGND2hRRqs189iaAiZKzux+v5AAcGAk9cfQciOtEpCnlSg4J4c
         N1WV2eFgBHrhU9ZhEpazy94EhKr947Evd4rbeOa+MbfT5XEANKnWHCkVsTjVyZGVaapI
         1KxR6EpRo8vxDVhX2rKztoOUiiZs+OAsjx7REPEYve3TUN3msqZTHi3JdNbfszESHnW7
         Cy2ZEnfyn2cn7GUAoyVipNRBVhBe9m6doJ3nPZozTkXtPtPxQVYZDj9CA6TdUpqDRmZn
         LgGgJaDWzlJlQ8z8ru9kUWuXHsuXcg/TXEdjtHR12Owqg1FbEDQf6ohiv1Ld6oD2Hgyx
         PCvw==
X-Forwarded-Encrypted: i=1; AJvYcCUSFuZ1m+qf9nxz7vpt0C9b48kvVTQ822osF3XTcqFCpR46VCz9hvYSgd+dIK8TluOJarwqjnWGfqeSKoI=@vger.kernel.org, AJvYcCV+nbyeL6j7YK5YVdYMFlUi4lkzJjdsxYUzeEbCjL9h24bAElBuVVn3qz3s99mfdnudEAsi2C5f@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZ/BaYNLMyIijFxrxpwhsOuzEbGxp3FerNruML5VK9lg4O0nC
	wfe93txQoU4HBNpr1SLRKEBnVJEPRd4ZFYMJkwXtkULPR+lCQJb+
X-Gm-Gg: ASbGncsfr6IwqzueXqJmgeDxBR+1XEOJRcsuB4cWTPT8GWzyKiRTsMDprQpqmb7Tgi+
	8WpVyEiEcxus3OGBxmlgJwWguWSuLqM2Uu9b0RWfOafGl2usWLUxufXJR35/F4vW5ESxeje6AdT
	peF5QnJViGdj6j0Y43noSzo5uoEw+evFnlB8nf7C8CFE224mKqOkGNNGWI3PJEKNj1cWBA6ZxO8
	GIUPc7b288Mhp4/oT8z8uNnwDM4GV3QXnKyybrdWjGpcqD5o88fWDidgoi8yLSiJkRznDuYde1Q
	dE/8wWcdp3QNizg2RIaLtHsXwFkUT3t3lfo6Qo9n7giZoK8ksCtpjaamHx7/vaug1cw8GhWOxAJ
	xMh03OQ80Q7MosYOsrG8=
X-Google-Smtp-Source: AGHT+IGzV23esDmkOB0c+h8Ee6nwGnXXnRQitYJLm0wThkRAKFQNz/y8jS045dBMw6ojvBYWMbM9jw==
X-Received: by 2002:a17:907:7206:b0:ace:bf94:2d2c with SMTP id a640c23a62f3a-acedc767e05mr70623066b.54.1745957858199;
        Tue, 29 Apr 2025 13:17:38 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41b0f7sm826145266b.22.2025.04.29.13.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:37 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Kurt Kanzenbach <kurt@linutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 08/11] net: dsa: b53: do not program vlans when vlan filtering is off
Date: Tue, 29 Apr 2025 22:17:07 +0200
Message-ID: <20250429201710.330937-9-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429201710.330937-1-jonas.gorski@gmail.com>
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/networking/switchdev.rst says:

- with VLAN filtering turned off: the bridge is strictly VLAN unaware and its
  data path will process all Ethernet frames as if they are VLAN-untagged.
  The bridge VLAN database can still be modified, but the modifications should
  have no effect while VLAN filtering is turned off.

This breaks if we immediately apply the VLAN configuration, so skip
writing it when vlan_filtering is off.

Fixes: 0ee2af4ebbe3 ("net: dsa: set configure_vlan_while_not_filtering to true by default")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 48 +++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0b28791cca52..ee2f1be62618 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1547,6 +1547,9 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	if (vlan->vid == 0)
 		return 0;
 
+	if (!ds->vlan_filtering)
+		return 0;
+
 	b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), &old_pvid);
 	if (pvid)
 		new_pvid = vlan->vid;
@@ -1592,6 +1595,9 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
 	if (vlan->vid == 0)
 		return 0;
 
+	if (!ds->vlan_filtering)
+		return 0;
+
 	b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), &pvid);
 
 	vl = &dev->vlans[vlan->vid];
@@ -1952,18 +1958,20 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 	pvid = b53_default_pvid(dev);
 	vl = &dev->vlans[pvid];
 
-	/* Make this port leave the all VLANs join since we will have proper
-	 * VLAN entries from now on
-	 */
-	if (is58xx(dev)) {
-		b53_read16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, &reg);
-		reg &= ~BIT(port);
-		if ((reg & BIT(cpu_port)) == BIT(cpu_port))
-			reg &= ~BIT(cpu_port);
-		b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, reg);
-	}
-
 	if (ds->vlan_filtering) {
+		/* Make this port leave the all VLANs join since we will have
+		 * proper VLAN entries from now on
+		 */
+		if (is58xx(dev)) {
+			b53_read16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN,
+				   &reg);
+			reg &= ~BIT(port);
+			if ((reg & BIT(cpu_port)) == BIT(cpu_port))
+				reg &= ~BIT(cpu_port);
+			b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN,
+				    reg);
+		}
+
 		b53_get_vlan_entry(dev, pvid, vl);
 		vl->members &= ~BIT(port);
 		if (vl->members == BIT(cpu_port))
@@ -2030,16 +2038,16 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 	pvid = b53_default_pvid(dev);
 	vl = &dev->vlans[pvid];
 
-	/* Make this port join all VLANs without VLAN entries */
-	if (is58xx(dev)) {
-		b53_read16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, &reg);
-		reg |= BIT(port);
-		if (!(reg & BIT(cpu_port)))
-			reg |= BIT(cpu_port);
-		b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, reg);
-	}
-
 	if (ds->vlan_filtering) {
+		/* Make this port join all VLANs without VLAN entries */
+		if (is58xx(dev)) {
+			b53_read16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, &reg);
+			reg |= BIT(port);
+			if (!(reg & BIT(cpu_port)))
+				reg |= BIT(cpu_port);
+			b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, reg);
+		}
+
 		b53_get_vlan_entry(dev, pvid, vl);
 		vl->members |= BIT(port) | BIT(cpu_port);
 		vl->untag |= BIT(port) | BIT(cpu_port);
-- 
2.43.0


