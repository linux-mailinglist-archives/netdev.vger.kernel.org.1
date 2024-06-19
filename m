Return-Path: <netdev+bounces-104909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4798C90F175
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB18828627C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D9847A48;
	Wed, 19 Jun 2024 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="lUlq23aX"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053E45BEF;
	Wed, 19 Jun 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809122; cv=none; b=QPnPZGhcYgAZiw8L0WEDwzVxWNIXp0ox3YXphcCPbB+DIIbDzWUSmdBHWoxLPfRq2n5dNdEnCUs42UyKXa9J5CY84KXDfHX1A1mO8Yml+8JxcPg8MEzsqEE7i4hgjIay/ZUjif2GyCN8Vuo/hRLiOGuUpVjOuwoHN101h6WH2wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809122; c=relaxed/simple;
	bh=3A8tNm4mUdqA2UjZMX8qJCEPulC5myG0hsApZpXjMF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RWhJoxaSzrpFcF1RTUevGLiNYz1xDTKTHVGH0PdK2OMxRqU4czfC/XVqaW1bAJPV8VhmZj2MKDdFbGDp6oFIOxhtI8dRIzrxEEE1Ijs/OHWUIjAR2ggA7sXRYKd5r8PUrKpUtWFikXmyYqI1+SDSIEcffwaLDR3S7J7bcApfZo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=lUlq23aX; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 02B3C87F5C;
	Wed, 19 Jun 2024 16:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718809118;
	bh=4NK3Rf6LavJcIYEM6Bfx7RzAvMhmAlqM4EjZYgnQG3U=;
	h=From:To:Cc:Subject:Date:From;
	b=lUlq23aXx+D4EQ4BrKFWZBHGbozq/jivQVToOIsdvxG0QNF7TrT70N2nZQT1OK1b5
	 3ghQFDvvnKTa3Jtv0xGtOzSpkxqyspC1foN5TeFN3H9SEk9CkHUK/4BGeH00QVFtX1
	 xwaw4tbv98MFjsUZMNsRtnY0Rs12+kaDV11bWnk6cayokvgjgCVlJW3l1z9HxzWOwi
	 V3lIUsxPi4E72u4KvL9uZw6Dsh5ykWOI+0fCPk7OR6Ps7iUFHuO1P8zrN8f+XcJKxl
	 KZRLJ19sXym+4EFIv28qzLvQ/+FovmCscaBougHNKR7s5oil6XvOEoKfFqsvo7d8jx
	 EbZXaKxBlqe/w==
From: Lukasz Majewski <lukma@denx.de>
To: Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3 net-next] net: dsa: ksz_common: Allow only up to two HSR HW offloaded ports for KSZ9477
Date: Wed, 19 Jun 2024 16:58:09 +0200
Message-Id: <20240619145809.1252915-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The KSZ9477 allows HSR in-HW offloading for any of two selected ports.
This patch adds check if one tries to use more than two ports with
HSR offloading enabled.

The problem is with RedBox configuration (HSR-SAN) - when configuring:
ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 interlink lan3 \
	supervision 45 version 1

The lan1 (port0) and lan2 (port1) are correctly configured as ports, which
can use HSR offloading on ksz9477.

However, when we do already have two bits set in hsr_ports, we need to
return (-ENOTSUPP), so the interlink port (lan3) would be used with
SW based HSR RedBox support.

Otherwise, I do see some strange network behavior, as some HSR frames are
visible on non-HSR network and vice versa.

This causes the switch connected to interlink port (lan3) to drop frames
and no communication is possible.

Moreover, conceptually - the interlink (i.e. HSR-SAN port - lan3/port2)
shall be only supported in software as it is also possible to use ksz9477
with only SW based HSR (i.e. port0/1 -> hsr0 with offloading, port2 ->
HSR-SAN/interlink, port4/5 -> hsr1 with SW based HSR).

Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

---
Changes for v2:
- Add more verbose description with Fixes: tag
- Check the condition earlier and remove extra check if SoC is ksz9477
- Add comment in the source code file

Changes for v3:
- Change 'use' to 'using'
- Adjust commit subject prefix
---
 drivers/net/dsa/microchip/ksz_common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 2818e24e2a51..debb554b60ed 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3906,6 +3906,13 @@ static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
 		return -EOPNOTSUPP;
 	}
 
+	/* KSZ9477 can only perform HSR offloading for up to two ports */
+	if (hweight8(dev->hsr_ports) >= 2) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload more than two ports - using software HSR");
+		return -EOPNOTSUPP;
+	}
+
 	/* Self MAC address filtering, to avoid frames traversing
 	 * the HSR ring more than once.
 	 */
-- 
2.20.1


