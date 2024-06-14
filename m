Return-Path: <netdev+bounces-103542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5E9908855
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3EBBB273CA
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2095619CCEA;
	Fri, 14 Jun 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="w5j2VhAS"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D4B19AD8D
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358419; cv=none; b=dXUm8c7KwZ5jyMUBuAIA4/Pg+4h+truGVso+lV8KszVtdx8y7HXaQYE23X3J6kUpkOqnIat5tdU1IW9WOY7OHjixFGYrgtoTtNLkMV6oYliwYagYzD23gv4OtNxKzAMD6ZsEdI7h/u9MTiEIfZzZ1qolW5etdZiMQMguwb+3RiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358419; c=relaxed/simple;
	bh=Eo85iQJ70v5Ru1vjEBDCz91igHzBqNmGHkw4twhGxUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKbmcS2sZCH+1wOk5AyC4ujRFTck7rKK2jdHI3F7tnbHrKHy+KRPotTmm/iWdCq9k2yz2iYlW/3Ph7MMfznHrzWxTr3d9Cm6QZ8bKxOvmhonlL5nOsslC6HnWn0PYqmPv6WVIek3JSu+Tr0/+fA+hUOVT2rrDyg8hWpt5neXd1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=w5j2VhAS; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id ED7C79C593A;
	Fri, 14 Jun 2024 05:46:54 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id F1YLdgml0ZWc; Fri, 14 Jun 2024 05:46:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3ED489C5625;
	Fri, 14 Jun 2024 05:46:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3ED489C5625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718358414; bh=jR0Pt0CBd2q6lbZEjyMMY3EeGFatgETR9LMBHiZa22M=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=w5j2VhASwDpZk2ywTKxz1CY6w4Y+xKQIp/Ic9claWpwyZgAec757DZIzP8Eb669qV
	 p5/dhvl+jrjym9te5pymV/6RbJlvxnmXbpLC90gzuRb6YLiVNVhADkY/qYikxzcyP0
	 Fl9Hg4W+bzLkM8hH2Dp0BWqpRYnENO1+yJXo7fk/LSQ2Lv0no1zGxSmCojsCCMVvtc
	 eudti06jxcvFmrrSvzP0K3OaQi2fp4QTgYhKGZmTrRF+68ovlLWNTeyPBUJeSt+udp
	 E/tHgDM9Wj6/uOQUiFDzzKH01RYvcsvMPUh6S0DvAQypjMHQ/0VwHhR6lZ7FrpnRmb
	 iq9K76ly2qO9A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id RqWEry4z1mdj; Fri, 14 Jun 2024 05:46:54 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CC03E9C57AA;
	Fri, 14 Jun 2024 05:46:52 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	horms@kernel.org,
	Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	Woojung Huh <Woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Subject: [PATCH net v6 2/3] net: dsa: microchip: use collision based back pressure mode
Date: Fri, 14 Jun 2024 09:46:41 +0000
Message-Id: <20240614094642.122464-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614094642.122464-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240614094642.122464-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Errata DS80000758 states that carrier sense back pressure mode can cause
link down issues in 100BASE-TX half duplex mode. The datasheet also
recommends to always use the collision based back pressure mode.

Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
Reviewed-by: Woojung Huh <Woojung.huh@microchip.com>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
v5:
 - define SW_BACK_PRESSURE_COLLISION
v4: https://lore.kernel.org/all/20240531142430.678198-5-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
 - rebase on net/main
 - add Fixes tag
v3: https://lore.kernel.org/all/20240530102436.226189-5-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
---
 drivers/net/dsa/microchip/ksz9477.c     | 4 ++++
 drivers/net/dsa/microchip/ksz9477_reg.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
index f8ad7833f5d9..c2878dd0ad7e 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1299,6 +1299,10 @@ int ksz9477_setup(struct dsa_switch *ds)
 	/* Enable REG_SW_MTU__2 reg by setting SW_JUMBO_PACKET */
 	ksz_cfg(dev, REG_SW_MAC_CTRL_1, SW_JUMBO_PACKET, true);
=20
+	/* Use collision based back pressure mode. */
+	ksz_cfg(dev, REG_SW_MAC_CTRL_1, SW_BACK_PRESSURE,
+		SW_BACK_PRESSURE_COLLISION);
+
 	/* Now we can configure default MTU value */
 	ret =3D regmap_update_bits(ksz_regmap_16(dev), REG_SW_MTU__2, REG_SW_MT=
U_MASK,
 				 VLAN_ETH_FRAME_LEN + ETH_FCS_LEN);
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/mi=
crochip/ksz9477_reg.h
index f3a205ee483f..fb124be8edd3 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -247,6 +247,7 @@
 #define REG_SW_MAC_CTRL_1		0x0331
=20
 #define SW_BACK_PRESSURE		BIT(5)
+#define SW_BACK_PRESSURE_COLLISION	0
 #define FAIR_FLOW_CTRL			BIT(4)
 #define NO_EXC_COLLISION_DROP		BIT(3)
 #define SW_JUMBO_PACKET			BIT(2)
--=20
2.34.1


