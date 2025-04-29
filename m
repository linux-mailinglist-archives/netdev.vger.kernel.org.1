Return-Path: <netdev+bounces-186849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B250AA1BFD
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C28A1BC24CB
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265ED2749FB;
	Tue, 29 Apr 2025 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgwhIlgq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60726FDBB;
	Tue, 29 Apr 2025 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957861; cv=none; b=QlL3Ry12gH8g/nJ5y6edALXcm8LnFsNbgX/f2L6uT8K9Y9w4F57G8LueY7om21HnzgW1GwcFrwWZ7WpbIg70XO5m9JuwgbtGKRDLt56hEjFdJDFV4Usgj774iCQXUCg3nskyzO9Ojo2OMm5vOKMuyL21VP+LgES5b7gNFNr/FCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957861; c=relaxed/simple;
	bh=so66WP6Aaj8gptbBVhszIWMXAn7ZiaCYJOt4hGq8KfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p067m3gCU6IEcDC7lQs3oMkV4Pop5Eff592f1uiJwyYJoHWQbAWkXxJLu885Jl4gDUnMAc4eD/ClOErkJfaPg4v6xVywqSvqwvIwCZiuxQI8lQRF3y5QnjBoI8+l2dSXJL+0A1O6QJp/0fiECBLJFaTwiTdRuHv+TEZrRrryU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgwhIlgq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so11726708a12.2;
        Tue, 29 Apr 2025 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957857; x=1746562657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDK49dhMLFcxQ+vwRz/oOcCQxP4BCt5EiPYfwgbH7bk=;
        b=TgwhIlgq90cF/Z1ekiZF1eRRJXTOetp0fAm58HlwMYdm6smxvox1dGFNpVBYidDNyW
         87kH22i/8SZINZoy62/qY0kNuGYnSeU9g8iMJKZAoV2W324Fg0d04mmKknAeR772lYwb
         CrvGoTrwaP2KSnNCrHvSkMSjUNAEYVfQ+gfrPvfV9QL1lQ1uJReqeMiFc/yCsdRT34zj
         75h58AhHYBB9r3ZSG+Anry1MtU98CTNLy7E+a8sFan35OME039bIwb8dTziTPSzzUJrw
         tggqLdAAP0uAAUqhJ7HbL5D2RI7JUm9i5ioBHp6elJLlTE8RXf/4f3E4D3J3doD8NYls
         +R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957857; x=1746562657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDK49dhMLFcxQ+vwRz/oOcCQxP4BCt5EiPYfwgbH7bk=;
        b=Ho2dXoph0MZblF9t/Ym5VeeVS4qSmHgW9vodoOpMeH1KE/k9yg6GDAcmdUyILAWtHa
         t88QJy/+Kk4s/5dNJgg2Tz3kZA3E7/Rbt3SuQdxcKCs0CI/hrqU7PwBlmSNgHarWNbLI
         jvRe3ZBKE4zkUvXtUfb6izp/9p2HvOaeidkIytGJjlju4K9lZPS1i+/2Y6GXgpebq5u6
         IwJlnaN8uPL7sZvV8YhP6bLp0xkY6bpIyJoLPAc8GO12Cd0W6bnNcsX2laAhNT3SDWxM
         gqGQYe+j2qSAh1sN0Boc3HsjiXg9J14wbOULKmt+UcEcV4bQiaJoB9zVpxb3hgLUaixZ
         vGVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7TyEPf4TYfQmmPrTwNkalsI3Sq+l63UI9Gekjw5ovvIi/raFlPo2dALqh1hD91btNXlGerhqZ@vger.kernel.org, AJvYcCXVecSLw3gfiz2NqI9Z04fjN0wahNWnCx39zLD3C1TK/Vd5Q/94Zc0OlcpnoMoU5gLfgKvYB36G1lOArYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze2/5wiU7JKSKDk8oaazTBajaUfL27gqOZLy+Gqvk5fAIFJJMd
	Da+lqcffBTJ/Xpv2NvnxPFhccaP/VtsWL62oKuGTu19V1fciExxg
X-Gm-Gg: ASbGncuYcKdjKRqWW4cAwEXkAB4Is5x6y1DUG4pWpQAvc9pDSvZL1cFioh6Cw3lwghi
	4GPHu54sFGBR56U4rDaIJrDrVM5wHpHOWTKUWHfiD/HpAS0HS4BmY8lYX5BsBe7WzswDUAtysjE
	8Ly8u+Lg6qgxKR64UsmbyA7CluoxUZgLYBl8RJTj4ipEJPQRmneaAz/90egPVt5WLyfbKLoc4CF
	Gz0EstJFJqPTb32IbMM5svsP5Nrh6GO0sd6uXhts80Dugu1NZ9DLcCOWOzvLvsPPoyCTN6215YB
	CU/vFckw/gJ5KZ2DBRaImzI/IGu6KdcZyCuyeStWKOVc76f2krkhAHj3sVtXGZhmlnAoC//ajwc
	6DLVKuKd2HfRStfJdMNc=
X-Google-Smtp-Source: AGHT+IGszZUFVe/1fddVKVtCKfE/40i3EkrAuwBiACY9MJT5CbfqgtSjDYTyBgYNXiONMne6C6giDA==
X-Received: by 2002:a17:906:1119:b0:acb:bbc4:3344 with SMTP id a640c23a62f3a-acedc5e042cmr54989166b.22.1745957857174;
        Tue, 29 Apr 2025 13:17:37 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c491sm822230866b.34.2025.04.29.13.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:36 -0700 (PDT)
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
Subject: [PATCH net 07/11] net: dsa: b53: do not allow to configure VLAN 0
Date: Tue, 29 Apr 2025 22:17:06 +0200
Message-ID: <20250429201710.330937-8-jonas.gorski@gmail.com>
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

Since we cannot set forwarding destinations per VLAN, we should not have
a VLAN 0 configured, as it would allow untagged traffic to work across
ports on VLAN aware bridges regardless if a PVID untagged VLAN exists.

So remove the VLAN 0 on join, an re-add it on leave. But only do so if
we have a VLAN aware bridge, as without it, untagged traffic would
become tagged with VID 0 on a VLAN unaware bridge.

Fixes: a2482d2ce349 ("net: dsa: b53: Plug in VLAN support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 36 ++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 4871e117f5ef..0b28791cca52 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1544,6 +1544,9 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	if (err)
 		return err;
 
+	if (vlan->vid == 0)
+		return 0;
+
 	b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), &old_pvid);
 	if (pvid)
 		new_pvid = vlan->vid;
@@ -1556,10 +1559,7 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 
 	b53_get_vlan_entry(dev, vlan->vid, vl);
 
-	if (vlan->vid == 0 && vlan->vid == b53_default_pvid(dev))
-		untagged = true;
-
-	if (vlan->vid > 0 && dsa_is_cpu_port(ds, port))
+	if (dsa_is_cpu_port(ds, port))
 		untagged = false;
 
 	vl->members |= BIT(port);
@@ -1589,6 +1589,9 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
 	struct b53_vlan *vl;
 	u16 pvid;
 
+	if (vlan->vid == 0)
+		return 0;
+
 	b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), &pvid);
 
 	vl = &dev->vlans[vlan->vid];
@@ -1935,8 +1938,9 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 		bool *tx_fwd_offload, struct netlink_ext_ack *extack)
 {
 	struct b53_device *dev = ds->priv;
+	struct b53_vlan *vl;
 	s8 cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
-	u16 pvlan, reg;
+	u16 pvlan, reg, pvid;
 	unsigned int i;
 
 	/* On 7278, port 7 which connects to the ASP should only receive
@@ -1945,6 +1949,9 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 	if (dev->chip_id == BCM7278_DEVICE_ID && port == 7)
 		return -EINVAL;
 
+	pvid = b53_default_pvid(dev);
+	vl = &dev->vlans[pvid];
+
 	/* Make this port leave the all VLANs join since we will have proper
 	 * VLAN entries from now on
 	 */
@@ -1956,6 +1963,15 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 		b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, reg);
 	}
 
+	if (ds->vlan_filtering) {
+		b53_get_vlan_entry(dev, pvid, vl);
+		vl->members &= ~BIT(port);
+		if (vl->members == BIT(cpu_port))
+			vl->members &= ~BIT(cpu_port);
+		vl->untag = vl->members;
+		b53_set_vlan_entry(dev, pvid, vl);
+	}
+
 	b53_read16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), &pvlan);
 
 	b53_for_each_port(dev, i) {
@@ -2023,10 +2039,12 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 		b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, reg);
 	}
 
-	b53_get_vlan_entry(dev, pvid, vl);
-	vl->members |= BIT(port) | BIT(cpu_port);
-	vl->untag |= BIT(port) | BIT(cpu_port);
-	b53_set_vlan_entry(dev, pvid, vl);
+	if (ds->vlan_filtering) {
+		b53_get_vlan_entry(dev, pvid, vl);
+		vl->members |= BIT(port) | BIT(cpu_port);
+		vl->untag |= BIT(port) | BIT(cpu_port);
+		b53_set_vlan_entry(dev, pvid, vl);
+	}
 }
 EXPORT_SYMBOL(b53_br_leave);
 
-- 
2.43.0


