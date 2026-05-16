Return-Path: <netdev+bounces-288573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGOuHYv5B2qzTAMAu9opvQ
	(envelope-from <netdev+bounces-288573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 06:58:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3E055A3BC
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 06:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 983313013D73
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E551242D6B;
	Sat, 16 May 2026 04:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="cNgPn7gt"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F681B4223;
	Sat, 16 May 2026 04:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778907528; cv=none; b=PcLFX5SyBubC+nnwrPL8RxvXY4IbcXHqZ9Y11PQg4US65nvkeSZFCMRTt5/og56apXx2nXBF/EO84vNoqhpO2GYFe8dP+o3kfjpskIeB2JcehdzjFaABmCFScrieR76UjaYGF6hzm5s+N1LW2xaEFB2597CfRqjeDl0UpPLH0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778907528; c=relaxed/simple;
	bh=nUYAZ0rFSPah3BjlHlAxFlsCVQwW11yoXsPJRBz6ctc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LhEQZ0ow9494SRXsb2VN8jXFQcJfVRuRSPjnIsMKfhtKl6s2dE0du/amAGHaYa0U3YyNbqmwNUc+5IHa7Aedmn0RtvMu8qGXZc0/DGRVNXU/YtFcPyXt308EjgU9ZFKANlXs/HF8AVi9qLJhuGKWfobfnjmJCtfKe9+rnWsIQJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=cNgPn7gt; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 348EAA4FB6;
	Sat, 16 May 2026 06:51:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1778907103; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=zevnhIHZIqSl4SF1Q+T/3/INX8kYjkkagJJKsInp1f4=;
	b=cNgPn7gtyafYRLH8UdmG9eyX5xvJ+VdPjPjE9tJtVuDVDGX8YCbbM/OJOSk/3FzJd3xmvH
	ri2LIIuNl8o02VYcMFHQM8/G5e6tjGUtfJOtsmXhkae/KryK67YY2fIR0pWMLT2WYvt3Oh
	r3fD0MJMWuHrV/xNv2LQNrY7GMq1UNyxSXMejL9mg2v3fGzDT3grOzYso0Ie/BXAdsx+Xr
	zv3qQaz7jSXOWNm7FSiPyVlQH1zPjmtrQIpCt4IK/efVY9jl4B95/DaS/JMCCcQoMs4yJ1
	bCnzRtTJSJyX1d/dRK6wuxr9WWo777wf2acTr9ligTxDIi1ahiYmbaoUR60B7Q==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sat, 16 May 2026 06:51:02 +0200
Subject: [PATCH] net: phy: honor eee_disabled_modes in phy_support_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-devel-phy-support-eee-fix-v1-1-59debc00eda0@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIALX3B2oC/x2M4QpAMBRGX0X3t1sjm3gV+bHswy2xNkTy7paf5
 9Q5D0UEQaQ2eyjglCjbmqDIMxpmu05gcYmpVKVRujDscGJhP98cD++3sDMAHuVi1wyjqpQ1Wte
 Ueh+Q9P/u+vf9ANJVAJRrAAAA
X-Change-ID: 20260516-devel-phy-support-eee-fix-d9cf040a6557
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: CB3E055A3BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-288573-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:dkim]
X-Rspamd-Action: no action

phy_support_eee() copies supported_eee into advertising_eee
unconditionally, overwriting any filtering applied during phy_probe()
based on DT eee-broken-* properties or driver-populated
eee_disabled_modes. MAC drivers that call phy_support_eee() after
probe (e.g. bcmgenet, fec, lan743x, lan78xx, r8169) then cause the PHY
to advertise EEE for modes the user marked as broken.

The symptom is that ethtool --show-eee on the local interface reports
"not supported" (supported & ~eee_disabled_modes is empty) while the
link partner sees EEE negotiated and active.

phy_probe() already filters advertising_eee via eee_disabled_modes
after calling of_set_phy_eee_broken(). Apply the same mask in
phy_support_eee() so the filtering survives the copy.

Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/phy_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c2cdf1ae354249c033445f2d942e07220205b41c..83b074bc4a8f716b3e10c8ff57aff7c7abba0236 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2903,7 +2903,8 @@ EXPORT_SYMBOL_GPL(phy_advertise_eee_all);
  */
 void phy_support_eee(struct phy_device *phydev)
 {
-	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
+	linkmode_andnot(phydev->advertising_eee, phydev->supported_eee,
+			phydev->eee_disabled_modes);
 	phydev->eee_cfg.tx_lpi_enabled = true;
 	phydev->eee_cfg.eee_enabled = true;
 

---
base-commit: aaec7096f9961eb223b5b149abe9495525c205d9
change-id: 20260516-devel-phy-support-eee-fix-d9cf040a6557

Best regards,
-- 
Nicolai Buchwitz <nb@tipi-net.de>


