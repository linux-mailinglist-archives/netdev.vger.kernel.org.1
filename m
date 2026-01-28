Return-Path: <netdev+bounces-254374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBvrBXFGemkp5AEAu9opvQ
	(envelope-from <netdev+bounces-254374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:25:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABABCA6CFF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E22673038AE8
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689B130FC12;
	Wed, 28 Jan 2026 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENZnNNTq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465D429A9C8
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619650; cv=none; b=fdP0Tl0Srx7p2t/GK8NseDXDaM1u6iedwW2gvmDedFNpsQX/HDs8G2iZHQtBtQ4zgup4HtjJdoYa7XUJujDPUrLj3r589LL/wFnoF9lXkVTz4EeUgOE4i1zLxcdUIYqSW726hreEI9PkkPLwIj4S+SrdIJKmtH7YHUOa8xwgJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619650; c=relaxed/simple;
	bh=rg6AtoBkuEsKAhSf+xlIls5ssn0QYilU2CZz4fWEzrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jLxfpoMmTK2y6UhZYgK7aZMx/jLiJ+vuhQHGby3wboYsxXIpGKlkvDp7ciDLRm1LNNaHK4oF3XYo7dwVMMhixBlPWnEjfEY2xs1WgoHiCj9T15acmtxrmBAFv4dbZ/VOmnSSf0BMOJI7D5iK6IDlEbnbE+Ti49WPr1V1hNm0Ur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENZnNNTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFEEC4CEF1;
	Wed, 28 Jan 2026 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619650;
	bh=rg6AtoBkuEsKAhSf+xlIls5ssn0QYilU2CZz4fWEzrA=;
	h=From:To:Cc:Subject:Date:From;
	b=ENZnNNTqNY/Ogd3Q+DVhK+C6L7+CxJuDJXmeLS2GLe2QcHwLh9PcILKl/w5OjooH4
	 EHIDMB2cKF7fNy/z17Lv+fZ1lu2xdnF2goew2dCWGUv4AbgaGodwCTBz8qZBvnEbFR
	 /z4pGJHmGIBpaFHA09nkqW4anVJ32w8SAqz/EGOx2xS5idxPMSxn2bNjGcYdasrBIQ
	 CxZguk/zBxAeGu+L5w72dOH3bIM4qtbxi7MAOPng6iNuI7KQrHCFt2JfMTkFxTbP7j
	 5Ztx3shejSTZDLRWtaPipZBd+2N2JLg9AT4Ec2YLvjNBqNTdp4c4JRyjZUMh9fOGa2
	 l2t3l0IBV80Fw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next] net: sfp: add quirk for Lantech 8330-265D
Date: Wed, 28 Jan 2026 18:00:44 +0100
Message-ID: <20260128170044.15576-1-kabel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,gmail.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-254374-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kabel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABABCA6CFF
X-Rspamd-Action: no action

Similar to Lantech 8330-262D-E, the Lantech 8330-265D also reports
2500MBd instead of 3125MBd.

Also, all 8330-265D report normal RX_LOS in EEPROM, but some signal
inverted RX_LOS. We therefore need to ignore RX_LOS on these modules.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/sfp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 47f095bd91ce..4746a8af3a8d 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -530,9 +530,13 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault),
 
-	// Lantech 8330-262D-E can operate at 2500base-X, but incorrectly report
-	// 2500MBd NRZ in their EEPROM
+	// Lantech 8330-262D-E and 8330-265D can operate at 2500base-X, but
+	// incorrectly report 2500MBd NRZ in their EEPROM.
+	// Some 8330-265D modules have inverted LOS, while all of them report
+	// normal LOS in EEPROM. Therefore we need to ignore LOS entirely.
 	SFP_QUIRK_S("Lantech", "8330-262D-E", sfp_quirk_2500basex),
+	SFP_QUIRK("Lantech", "8330-265D", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_los),
 
 	SFP_QUIRK_S("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
 
-- 
2.52.0


