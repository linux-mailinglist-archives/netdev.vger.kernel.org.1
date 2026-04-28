Return-Path: <netdev+bounces-281890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPssBUjC8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:20:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5B2486CDD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCBEE308AA46
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E42C421884;
	Tue, 28 Apr 2026 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="PeUAuQm9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9D23504B
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383717; cv=none; b=tBEv4rfuiRHRvmLEkpIfzqG9N7xr8BpHO5L+TtltpSdKKPKIgCef7MCJSB4AbZwdnHPp4wXlzo17jniK3vrlAHrIW0Es9XdlkISO8/FKFR/gltmuEzJnXiuqCI2hjDP7gVsO6gpViaXQj6HD/KgXp655rUAUhZ7lTew9uMt8N+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383717; c=relaxed/simple;
	bh=jqBLOubZ4mXa84mx2wvU/yh4dktQrLifIrEBEEYBwaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K22P9g6fxiakbtTbTdxVHpXqDXcniPWBVXgHGfg9mty9K1OEPGslT692hO/B+eAhW985OlifQ8aGzJTtXUlkx1oVSNTywwblAFftQ82cN75ToYICux8+4wxjZHPmBAhukLOs3dcwIw/QecOC8USNEFgtPhJ5IcjPa7N/KgztRzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=PeUAuQm9; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89fc4147f2eso126705646d6.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1777383712; x=1777988512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TqQCQriovYDSHEdS4S+0Ixb7G/LoMFE2Kp0rbzZf96A=;
        b=PeUAuQm9wN4GtTfHdKXy5iax09XbMHVUpSG2IzKJuMDaq+z0+s4q+h7CPexUcow/SH
         2HVJVxhxlTST5oSh0KhXw0FXsPdBxIR2AZ/u+JojOK5KR8eh7ZlmfJrjSWi23AJj1AAm
         ZUAm81p+A5HRQjEpFnKzFo+iCDfBmPHEX91KV2jM9/2l8AxlLLoFGkztlEHgloPOlBu9
         GgOfHlMTQVJ/IJk1m47Qr1TrtXiIg8CDV0UTJIWmv3a8W4U7lGYwQSU0xW0FlNB52Tbf
         YNC79Gdswyha6kurkepNpTUUbggzhgpg/YVI1NibeIBPVTopk8U1/vobYhuOE/nGLFoh
         zogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383712; x=1777988512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqQCQriovYDSHEdS4S+0Ixb7G/LoMFE2Kp0rbzZf96A=;
        b=VJNVbbYdiN4Udz0Kfqc2FKGaSwq68hT1e25k1ZDiQrU9QO3d/HyF5vXiVEeCqz0DC6
         5Yy6t/YR+DDE4uoYmiq2X4CdBr64YQX0285wOK6BSV7TROcmAK/LL1vIzH//bx7qaFgH
         CU5FduPdPJCSVvspmS0y76dkY0Z3xtNzznHdKf1LZX20o7MTx7wsfRBw+yD9TSZ3v7pI
         +9IGhX45+Cz01OqlOWrWPV2ToJXMXaQIjkLPGLY9UTO2K0ApP12K+Py021tDfl5Gu+zs
         k0W17z9TNJqtOQcxdyptCwCQWKgIF8/kykslSVTauIYh5OTN34rx/5MuOTdl+dRt00JD
         HUHg==
X-Forwarded-Encrypted: i=1; AFNElJ8wlGYhSFne2EftTpnCeBtOvidn1WaJRDNKOwy/jkBHt2ldwsqo6vOJkmZTsdi7NhKCRdMwYB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1F2Hn8RQp46GKKm0XAMOxYU1AzyqiNLD3uSeQdBHIDLuqGzzK
	0z7qV1RSXjMif/QZ7C1TA0ncK/OWPVM9/KlOiz77tjtk3ajTUth/Kot+gYuE9r8HsBU=
X-Gm-Gg: AeBDieugUlXbzuxHcNlfEFqN4EuY0HDGaJsL0a2NlJlTQKKfpAu9WhMzBcX6682H+nW
	up/j0RwefsbeQfy5JMJjgVr2uUPKUyGu6cJ9sg+ZPDIAClbnq/PiKzgcB6Us630b9aHhFT2DvDH
	YVzMKHUAp+C+MfcCXh7cerHPkSzLLue7GskpMcopBqGvlPhKzZ2KGV6D0O6yDsYp/2lDu884Nm6
	CEs+aRZQew2B9bKqcJ0wGwQWHiK3jRK/ng20sFgTKmnPx5PwYT11SPYTrf4NvkD+qvGqi8lQ0BV
	b8P+bVMEhoV1As8roIobbjZeAA6resWlb+ie/ZsmggxqH8ENyETqJuZ8HN1yTvp3ve9ke3PEMGh
	BRksf12JNsZuIXsqtNZiZyP9TfCCG65gBhYKKexIyodTJEzFW7FNzC2bhkXn4OOl+hhu87nBPOl
	QC4CBPMa/4Jk962S+u3ECsPkBa1n6IjpckwrVJPWOG0NJSHSDDHgxeFBJH9/HwYCPvRnAqKdNbv
	ivXBytW9HsYbmuBI5hOGvlIW3tgi/lA+UThWQ==
X-Received: by 2002:a05:6214:29c9:b0:89c:e38f:6b6c with SMTP id 6a1803df08f44-8b3e301a9f9mr45799576d6.3.1777383712343;
        Tue, 28 Apr 2026 06:41:52 -0700 (PDT)
Received: from fedora (d-zg1-128.globalnet.hr. [213.149.36.142])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e28623dasm20732486d6.19.2026.04.28.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:41:51 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Divya.Koppera@microchip.com,
	horatiu.vultur@microchip.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net] net: phy: micrel: fix LAN8814 QSGMII soft reset
Date: Tue, 28 Apr 2026 15:41:01 +0200
Message-ID: <20260428134138.1741253-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D5B2486CDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-281890-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,vger.kernel.org];
	DKIM_TRACE(0.00)[sartura.hr:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sartura.hr:email,sartura.hr:dkim,sartura.hr:mid]

LAN8814 QSGMII soft reset was moved into the probe function to avoid
triggering it for each of 4 PHY-s in the package.

However, that broke QSGMII link between the MAC and PHY on most LAN8814
PHY-s, specificaly for us on the Microchip LAN969x switch.
Reading the QSGMII status registers it was visible that lanes were only
partially synced.

It looks like the reset timing is crucial, so lets move the reset back
into the .config_init function but guard it with phy_package_init_once()
to avoid it being triggered on each of 4 PHY-s in the package.
Change the probe function to use phy_package_probe_once() for coma and PtP
setup.

Fixes: 96a9178a29a6 ("net: phy: micrel: lan8814 fix reset of the QSGMII interface")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/phy/micrel.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 2aa1dedd21b8..e211a523c258 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4548,6 +4548,13 @@ static int lan8814_config_init(struct phy_device *phydev)
 	struct kszphy_priv *lan8814 = phydev->priv;
 	int ret;
 
+	if (phy_package_init_once(phydev))
+		/* Reset the PHY */
+		lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+				       LAN8814_QSGMII_SOFT_RESET,
+				       LAN8814_QSGMII_SOFT_RESET_BIT,
+				       LAN8814_QSGMII_SOFT_RESET_BIT);
+
 	/* Based on the interface type select how the advertise ability is
 	 * encoded, to set as SGMII or as USGMII.
 	 */
@@ -4655,13 +4662,7 @@ static int lan8814_probe(struct phy_device *phydev)
 	priv->is_ptp_available = err == LAN8814_REV_LAN8814 ||
 				 err == LAN8814_REV_LAN8818;
 
-	if (phy_package_init_once(phydev)) {
-		/* Reset the PHY */
-		lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
-				       LAN8814_QSGMII_SOFT_RESET,
-				       LAN8814_QSGMII_SOFT_RESET_BIT,
-				       LAN8814_QSGMII_SOFT_RESET_BIT);
-
+	if (phy_package_probe_once(phydev)) {
 		err = lan8814_release_coma_mode(phydev);
 		if (err)
 			return err;
-- 
2.54.0


