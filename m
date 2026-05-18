Return-Path: <netdev+bounces-288918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SZ1+GFnOCmrv8QQAu9opvQ
	(envelope-from <netdev+bounces-288918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:31:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FA0568D1B
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29333309852D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D703E317B;
	Mon, 18 May 2026 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="VD2FMngE"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB393E1701;
	Mon, 18 May 2026 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092608; cv=none; b=Bi8XAVX9breh9Fj8O72xNTnQ11dBngNmsA+PfAcKpXnuhD/1BChmjneP9lhx8/LIqHxXnbW6bQxdhXlsCk/v+EPatznUa9Y0+r/Bf8hYNFUPw31S3373+4twb39vPhe/xR9DV6i0WEOxwzSXAffkxYVCD2BPSaibcuHD3sXfVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092608; c=relaxed/simple;
	bh=+I23rzg1W1BdTOa/9Lsj69CcgtRcJ5g9YpKlSMdX6A0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WO3Qif66uvrqf+kBdBFm32C8tL0Ntv+66HgmIrV4+dF0z2qJHfw7YSAXKu5loEIT6s328ey3VZ5vJK6/rYUtsL7FoIJsrJR9AtK8QYl16AMiBksybRVOPc8ip6eqyRFedLT8D0WpDwlbIZE5hLLgeMzTd2AmrkE+vkTjzxS4FEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=VD2FMngE; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8A7EA4FBD;
	Mon, 18 May 2026 10:23:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779092597; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YP6KhuJNLz/Nd1TE8cEZQYfvR5G/npigCeJLKAe+Aus=;
	b=VD2FMngEy2ngsv3+p+D3ZGXPH3hnZwgGOGVi4m1/cScOfJQTEYN6ReHMzBi0Mq4vF1+rEB
	oU+MsZzJqqKz9Touxme7p5N9Yl+hg2qRIC4MYyflKoiD91i1nzHLs5eEFPJmaRx/dvZwMW
	4u/6SYhy7s1F6K+gko2IwtdH/KjGqfTNP1lOqup644v8z4i+q3mDfh0TYmrv9biGrwh0m6
	3ceizbvquM7sg5qeO7IqxccWvFMOQd96xqaTpX2AbvECTkLvRHXzajG1NYdUsgJVAfIxnA
	lUSccBd/d4Jn/I8FyGFpME59+ngwIZ0KDTgF0ZaOJhM9gLBsw5PN9AaQMLNLLA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 18 May 2026 10:23:10 +0200
Subject: [PATCH net v2 2/2] net: phy: honor eee_disabled_modes in
 phy_advertise_eee_all()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-devel-phy-support-eee-fix-v2-2-05b52626fa68@tipi-net.de>
References: <20260518-devel-phy-support-eee-fix-v2-0-05b52626fa68@tipi-net.de>
In-Reply-To: <20260518-devel-phy-support-eee-fix-v2-0-05b52626fa68@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: C6FA0568D1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288918-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

phy_advertise_eee_all() copies supported_eee into advertising_eee
unconditionally, overwriting any filtering applied during phy_probe()
based on DT eee-broken-* properties or driver-populated
eee_disabled_modes. genphy_c45_ethtool_set_eee() calls this helper
when user space passes an empty advertisement, undoing the filtering.

Apply the same eee_disabled_modes mask in phy_advertise_eee_all() so
the filtering survives the copy, matching the pattern in phy_probe()
and phy_support_eee().

Fixes: b64691274f5d ("net: phy: add helper phy_advertise_eee_all")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/phy_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 83b074bc4a8f716b3e10c8ff57aff7c7abba0236..3370eb822017b264cfc26881b0eade8a49e1530f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2877,7 +2877,8 @@ EXPORT_SYMBOL(phy_advertise_supported);
  */
 void phy_advertise_eee_all(struct phy_device *phydev)
 {
-	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
+	linkmode_andnot(phydev->advertising_eee, phydev->supported_eee,
+			phydev->eee_disabled_modes);
 }
 EXPORT_SYMBOL_GPL(phy_advertise_eee_all);
 

-- 
2.51.0


