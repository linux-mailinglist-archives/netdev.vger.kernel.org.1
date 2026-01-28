Return-Path: <netdev+bounces-254404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMQxHopOemnk5AEAu9opvQ
	(envelope-from <netdev+bounces-254404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:59:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A33A75F5
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAF143012B3C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F3736EABF;
	Wed, 28 Jan 2026 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohYl7/BA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB84B36EA8A
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623040; cv=none; b=CE7JIE3Z724uDtr8V3gIuUazVqNo5ZlHPaV6rq7hnOc8g8imdnUv4huVqMBRVNa7/0XgS4DwHSsz080iLaiSw3Qi7fcxVEOYp5sYmPeR+H4aHGgw5EJPLJhABAF0TCffi5gM7kKYFt9D5414aCV8I5RPj3LIfBuLV1nJxhIjYCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623040; c=relaxed/simple;
	bh=3rqEwyrz/gf1v7eYAJaZK2hFSdNbUmzEF70blRfGpWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJcr1oWji2ZohRMC4LTW1u09o2yl6ke8JnoWBf2qP1BKjhdI6CPBHn8vyK4Rg9RVCwUv9t/vmkmNmuJR0LONA7A6SS/SlAFNlhElK9Vrg6ffKt0YIIlkgSHobH5Q5hbb0k3UncHTUrgXJYSe8rknp1bXPcivNQDgdHE4Q/Nn/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohYl7/BA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5702CC4CEF7;
	Wed, 28 Jan 2026 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769623040;
	bh=3rqEwyrz/gf1v7eYAJaZK2hFSdNbUmzEF70blRfGpWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ohYl7/BALLL6zJo9BS9yB8rUakqdx1M6SfqOJdWRnlZLW1CCR20un6BRSbqZ57jC0
	 79xM9IhwE9nUkzxmaEY8ZeC2GrHaLRGi+yXxayWTZEF1JDhyRqcBdibw5klmul9YwK
	 i74TfsF0RrNxfe+HHsU0hbFr3fVnR8fR+fF9Lha3Wua/RFXeqj6iglvD8HDw3NgyVt
	 5ghyR6ElSpIwE9Ji49X9dIvsxPuvE/LDqtMKDgFKmcr9NfnwR66GAjTaMEWer+DyGS
	 PVFzeZkT5YByvYyXSkSduX83ViiplyvyPjuITYJ1HVH5hE51HE0ShrzJ1b/m65PMJi
	 c4OmHX0uD0q4g==
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
Subject: [PATCH net] net: sfp: Fix quirk for Ubiquiti U-Fiber Instant SFP module
Date: Wed, 28 Jan 2026 18:57:14 +0100
Message-ID: <20260128175714.11411-1-kabel@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,gmail.com,lunn.ch];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254404-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kabel@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A0A33A75F5
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
 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 47f095bd91ce..eb6fa98e5d71 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -479,6 +479,8 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 	linkmode_zero(caps->link_modes);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
 			 caps->link_modes);
+	bitmap_zero(caps->interfaces, PHY_INTERFACE_MODE_MAX);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, caps->interfaces);
 }
 
 #define SFP_QUIRK(_v, _p, _s, _f) \
-- 
2.52.0


