Return-Path: <netdev+bounces-297130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K55NNjQ2KGoBAQMAu9opvQ
	(envelope-from <netdev+bounces-297130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:50:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA0661FD3
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:50:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=RCtmRZGp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297130-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297130-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EFBE30DE2E2
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED6848C3EC;
	Tue,  9 Jun 2026 15:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3743E9C8;
	Tue,  9 Jun 2026 15:28:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018890; cv=none; b=rqO4Zkg0+J7Ngkxf3xcF17rxXiC7EiyICJ4fbxvARcLhtwS/QvgmV23U7SmFJCaNuuMtPyL89t3nRHQ+2FA+eijPNWcqtT3ZCzbEIiTbHh5sO3D/CEpWFE80Xtiz5+gkU1zNgwBtCTMUZ048dSC57xC41yiM2ktpqC/nWoS+X9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018890; c=relaxed/simple;
	bh=0PoyS8TaDySwROS+c9soPDbetkiSCozHg26VGtBAXHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dNLxpbsNFJOAoTzucJL6zpHmh58ZOp9/JN49n6zAQWEkmAIF+y5f05vn0D8FtlXzBqtJ7FlqK30vtogWmJ13bvC1UPHUB8Z4AqvdWXOFw/QK7yNhN0mGejmdsex120eQ6Di9q/DMC56tf6pd96NNsDExWzEFAPX9xEt085eNC04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCtmRZGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC1A5C4AF10;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781018889;
	bh=0PoyS8TaDySwROS+c9soPDbetkiSCozHg26VGtBAXHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RCtmRZGp4ePgUvPcTs84q52ya6MRcLMwAApbgKOFq0JXjfu3pWC/W4sOjcF6ptS7F
	 iJ/y2HWPVFGrYozXW3UKPSgVrktOVvM5AETRwd+thdT19QTteXeoKKgj/V1oWjQ5Zi
	 Cai3v6x41LlCj2pOYlUcLhS8H/bzEPBIsMlCv6ZEe308i37pb3si8bv0IF48cO/htK
	 DDqjoUky37MY++bV1FzOjqT7fSMWOr2DtQCEw2kE+yNqcSJjQXbhdwD5oTqPYk9nSG
	 Gk8i+QQxCuixLNH+BcLXFsCpSHxoafsvFa1FaVPbSbq8LCiMF/YDFk7CloXf9Gat5V
	 YWJM2vh8bDzGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3334CD8CB9;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 18:28:09 +0300
Subject: [PATCH net-next v4 10/13] net: phy: add generic helpers for direct
 C45 MMD access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-adin1140-driver-v4-10-0753e28ee004@analog.com>
References: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
In-Reply-To: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781018886; l=2711;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=3vFOSyANNQzVtl2h405gheiZ2BA6Gw0e9c/c/C0Yj6Q=;
 b=kNKvs/VFFFNxVRCsc0nJ9NcVa/S0gy/Yxyo2sW1fOLc6QfKe/smPHysoIKzacQb4xn+09M4xw
 vt3c2PaHxtGB/3HRadupUa11qKp4jSOsokHIn9Vnx7oywcdX9EJgql3
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297130-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:ciprian.regus@analog.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:email,analog.com:mid,vger.kernel.org:from_smtp,lunn.ch:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FCA0661FD3

From: Ciprian Regus <ciprian.regus@analog.com>

Some PHYs support direct C45 register access but not C22 indirect MMD
access (registers 0xD and 0xE). When discovered via C22, phylib routes
MMD access through the indirect path, which won't work on these
devices.

Add genphy_read_mmd_c45() and genphy_write_mmd_c45() as read_mmd/
write_mmd callbacks that bypass the C22 indirect path and use the bus
C45 accessors directly.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
v4 changelog:
 - no change
v3 changelog:
 - no change
v2 changelog:
 - New patch
---
 drivers/net/phy/phy_device.c | 25 +++++++++++++++++++++++++
 include/linux/phy.h          |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3370eb822017..d33d096e700d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2764,6 +2764,31 @@ int genphy_read_abilities(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_read_abilities);
 
+/* Some PHYs support direct C45 register access but not C22 indirect
+ * MMD access (registers 13 and 14). When discovered via C22, phylib
+ * routes MMD access through the indirect path, which won't work on
+ * these devices. These helpers bypass indirect access and use the bus
+ * C45 accessors directly.
+ */
+int genphy_read_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return __mdiobus_c45_read(bus, addr, devnum, regnum);
+}
+EXPORT_SYMBOL(genphy_read_mmd_c45);
+
+int genphy_write_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum,
+			 u16 val)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return __mdiobus_c45_write(bus, addr, devnum, regnum, val);
+}
+EXPORT_SYMBOL(genphy_write_mmd_c45);
+
 /* This is used for the phy device which doesn't support the MMD extended
  * register access, but it does have side effect when we are trying to access
  * the MMD register via indirect method.
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 199a7aaa341b..432d44188dbc 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2297,6 +2297,9 @@ static inline int genphy_no_config_intr(struct phy_device *phydev)
 {
 	return 0;
 }
+int genphy_read_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum);
+int genphy_write_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum,
+			 u16 val);
 int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad,
 				u16 regnum);
 int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,

-- 
2.43.0



