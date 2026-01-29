Return-Path: <netdev+bounces-254639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAz3MGIbe2msBQIAu9opvQ
	(envelope-from <netdev+bounces-254639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:33:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FDFAD89F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EE41300BC72
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA60371057;
	Thu, 29 Jan 2026 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJzaSpDK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E537AA8B
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674953; cv=none; b=n/lquASWGk4H1VM5loHhpa79mYmwM4kxFfPTam+iga9GfJHvTHRpk6rAWjPH9s1sRwbJ610zdqdyEvcEzaZMI/LZLiB+hgBraHlxGf8snthiFPzFnJq5a3JXrXhpLu8rj37zJP+ImvsyjxWmEH00zXLciqy1x8XyPZD/Lk9C97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674953; c=relaxed/simple;
	bh=YXCtiwa9C2wGUaspOUjpItsoFUGm860r9oGZUJ8W+Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pa80rJMt9EmpZhQyDHvyFPq6skBYPEltwOBGyltZSDIiyadrp6TD+iO1kWJAugbGAV+oix3Aqth4e5G7Z6mv7ByKRl/FWp8r49aElthjU/7a1OKOpfZbPP5wMohTPAV7LMrZBtunCwMGb3vEv24OcKQ0Bz9ggE20HBOjGHrU36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJzaSpDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24ADC4CEF7;
	Thu, 29 Jan 2026 08:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674952;
	bh=YXCtiwa9C2wGUaspOUjpItsoFUGm860r9oGZUJ8W+Ow=;
	h=From:To:Cc:Subject:Date:From;
	b=rJzaSpDK9VK1Z+sQeg21LBOSwJdqP9Ntmm3zuUdWUADSCA1BTSowbEQn6q7rTVpCg
	 EVyj9tMrPwc/kD+FMBNg/EJn+3EwG8ck+szQlqK08ltzbQTPbulKwVmfDEn7jXBstr
	 YhbpOvKEEk2j+txf68/WNGgaFZ596NuU7BmNGmQSI/GLlH+jGKMdKjSZzf6xMJnDDp
	 Nl5nyTReTdXhXNhCRKzROdDMAQhkKFeqRHTMPWeUHQiX/gEKynZB1O9Qb5m2CXFHp4
	 4j/PiS0pQdjuJ8DNibTnD1ckTIZ70NN3JXFMLKETbpYNA+plTOTICY3NCaJ6eGpFNr
	 695Jx5zttosgg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net v2] net: sfp: Fix quirk for Ubiquiti U-Fiber Instant SFP module
Date: Thu, 29 Jan 2026 09:22:27 +0100
Message-ID: <20260129082227.17443-1-kabel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,gmail.com,lunn.ch,bootlin.com];
	TAGGED_FROM(0.00)[bounces-254639-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kabel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6FDFAD89F
X-Rspamd-Action: no action

Commit fd580c9830316eda ("net: sfp: augment SFP parsing with
phy_interface_t bitmap") did not add augumentation for the interface
bitmap in the quirk for Ubiquiti U-Fiber Instant.

The subsequent commit f81fa96d8a6c7a77 ("net: phylink: use
phy_interface_t bitmaps for optical modules") then changed phylink code
for selection of SFP interface: instead of using link mode bitmap, the
interface bitmap is used, and the fastest interface mode supported by
both SFP module and MAC is chosen.

Since the interface bitmap contains also modes faster than 1000base-x,
this caused a regression wherein this module stopped working
out-of-the-box.

Fix this.

Fixes: fd580c9830316eda ("net: sfp: augment SFP parsing with phy_interface_t bitmap")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
Changes since v1:
- use phy_interface_zero() instead of bitmap_zero(), as per Maxime's suggestion
---
 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 47f095bd91ce..3e023723887c 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -479,6 +479,8 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 	linkmode_zero(caps->link_modes);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
 			 caps->link_modes);
+	phy_interface_zero(caps->interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, caps->interfaces);
 }
 
 #define SFP_QUIRK(_v, _p, _s, _f) \
-- 
2.52.0


