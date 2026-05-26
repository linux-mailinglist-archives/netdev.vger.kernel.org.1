Return-Path: <netdev+bounces-291945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDOLAg4XFmrOhQcAu9opvQ
	(envelope-from <netdev+bounces-291945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:56:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BDC5DCFF3
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81D61308444C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A5C3CB2C7;
	Tue, 26 May 2026 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao96Z2//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A63C3C10;
	Tue, 26 May 2026 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832340; cv=none; b=VRPSy4nkInN3T8ZnuZ01A0kVxJLiWV1LfQwgGkMT8TJAH06oBpAmLSvU/yaGzO3i7LaYCLHmqWS5xXAcS3WG6PaLUhxo0HPyRCUWUkZ6NsQZEcsTIFZPerMA15Bn350IvvzTdmBRqtHHNrohn7kXPPM0CTuRhZPxYVR+ZS6sxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832340; c=relaxed/simple;
	bh=xY9q0pRRYwa9q25bCkjPTw/GQUB2n+PKZ0TiKQRf6Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJQmTe8/5nKjsolpL2Fzmn/FLuAUg3jVT+QBj7rJBsAjM+8di5n2laWgTl+I/UNoBM+IImH6RDd9ilH2jFnvSXY4KXIoj7UmAJnUjcKU4PscZg9vth7nt5hzL7SBWaRYiUOfjePGBDE9tseMhBeV2FNhhKPGgLJIJ1ZjSGaDZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao96Z2//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2839BC2BCB3;
	Tue, 26 May 2026 21:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779832340;
	bh=xY9q0pRRYwa9q25bCkjPTw/GQUB2n+PKZ0TiKQRf6Rg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ao96Z2//q3yWxRDKVrJomnm0R0+q+IX3Me4JxIsFsG8CvnhkMNwss40GV7KULmg9u
	 npkv6H9qfp2osMHWz7okAVM0HUbcoi4TGKhc0hM1YnqgwwBGbdQ+KfHlpLJrlCxX4j
	 W5gSi1ljNyfXuWcrzMRpoMq7OrBfn/7Kmf3WFGhehia+xSvivM0ISLNmOv6PaN5MBU
	 DUWfxJ9N48WpKihfB2klmp3cCvDlAogNN36MfeAtZ5NBec8sGyl5xFwjaWDiRzp7Ah
	 yuFdu8oHzD+q1cE+vMUrAhNax8aK0Jbu80m4SnIGmuY/wkb4qgmb0kM2RdEDUkQRjP
	 V63GLW0j2bKbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F626CD6E41;
	Tue, 26 May 2026 21:52:20 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Wed, 27 May 2026 00:51:53 +0300
Subject: [PATCH net-next v2 08/10] net: phy: microchip-t1s: use generic C45
 MMD access helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-adin1140-driver-v2-8-37e5c8d4e0a0@analog.com>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
In-Reply-To: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779832338; l=2543;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=G25PvlzDzFteb9EPaVnGGuMAZ1Q1HnMvb5P4glW7CCc=;
 b=l+I90Erxm8QGOJR8yiMjbfm0bFCklvd8Msn8vzD/x5jkpkWg8DwoUlv6iwu83u0e2XZvlSd8F
 g+F+1xa1gHuD9hID6+VyielMSbIQMzF887m3L86p4sPkAdUP5EaEPhr
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291945-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:mid,analog.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 63BDC5DCFF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Regus <ciprian.regus@analog.com>

Replace the driver specific lan865x_phy_read_mmd() and
lan865x_phy_write_mmd() with the shared genphy_read_mmd_c45() and
genphy_write_mmd_c45() helpers.

No functional change.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

---
v2 changelog:
 - New patch
---
 drivers/net/phy/microchip_t1s.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index e601d56b2507..73c23d311d72 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -506,34 +506,6 @@ static int lan86xx_read_status(struct phy_device *phydev)
 	return 0;
 }
 
-/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
- * C45 registers space. If the PHY is discovered via C22 bus protocol it assumes
- * it uses C22 protocol and always uses C22 registers indirect access to access
- * C45 registers. This is because, we don't have a clean separation between
- * C22/C45 register space and C22/C45 MDIO bus protocols. Resulting, PHY C45
- * registers direct access can't be used which can save multiple SPI bus access.
- * To support this feature, set .read_mmd/.write_mmd in the PHY driver to call
- * .read_c45/.write_c45 in the OPEN Alliance framework
- * drivers/net/ethernet/oa_tc6.c
- */
-static int lan865x_phy_read_mmd(struct phy_device *phydev, int devnum,
-				u16 regnum)
-{
-	struct mii_bus *bus = phydev->mdio.bus;
-	int addr = phydev->mdio.addr;
-
-	return __mdiobus_c45_read(bus, addr, devnum, regnum);
-}
-
-static int lan865x_phy_write_mmd(struct phy_device *phydev, int devnum,
-				 u16 regnum, u16 val)
-{
-	struct mii_bus *bus = phydev->mdio.bus;
-	int addr = phydev->mdio.addr;
-
-	return __mdiobus_c45_write(bus, addr, devnum, regnum, val);
-}
-
 static struct phy_driver microchip_t1s_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1),
@@ -584,8 +556,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan865x_revb_config_init,
 		.read_status        = lan86xx_read_status,
-		.read_mmd           = lan865x_phy_read_mmd,
-		.write_mmd          = lan865x_phy_write_mmd,
+		.read_mmd           = genphy_read_mmd_c45,
+		.write_mmd          = genphy_write_mmd_c45,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,

-- 
2.43.0



