Return-Path: <netdev+bounces-150702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E839EB335
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCFD1670F3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239351B4236;
	Tue, 10 Dec 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="M2Hpqv0g"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A841AF0D4
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840792; cv=none; b=YnHJ8Mh97qRWpbgZBIDErfpM1BnzERbCy/4N/1wRPy5rloPfY69AHoldkr43O5nLHOKx3BvREMM5GN699EIiVYSl7bu37igNoC+isIhIlw77fNArzvrDE3YDlsUdu1rcOFBAJFLbzmBqH8FTExBWzo/ewWqncDoLKOeuoMEN4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840792; c=relaxed/simple;
	bh=mOmAUV7MZzW0ms7CgYI2pKwscSPrxGS1mmgv7kNt16E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Uw0jVpFaVfOGBEixVTV73DCrzX5h5tsbSfSQOXuDgkUC1NniNJ4D1BNbSifdPNrPJTugwQHuYJIKC6ajp1+ooZzUpDrUrtyxVf+GTtNY+9WoCMDFiXOFALVN9RcIm7Fp2JAVx2U2RSvNPLknLRyBR6edAlSwXqUpjAtfCgIAmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=M2Hpqv0g; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8eCDYc5wLE97wROsRuo0M5NubJXjSHY7FvadaMmC9eA=; b=M2Hpqv0gQgSfcET/rvJtHpwQmR
	cleZB6E2949BKpOSQXRzF7Z3lTplXyvzZvOfYZEc9PQfQu3nmjNRc7ayM92wIBqNh3D/MjKKZ97Cn
	kB+8Q8uSRCnOZlFzMi42+VJ4FiC3uMgJq3/11FhgIEM2xC9r0Zyyg5TrklqqfZtmIKyzoqn6Cevw/
	Y5qVYe97uuoSVebAFdF9tLTfSf1RJJR6puc1VmRjgXRuSMVpSC4ZjLFJUriNQGyKozjW4n2vApHBx
	kMX/5F8QoSOanhbfWTZftp3nZatN/pwlgVFnxqgloNn0/apX9sjpDqEAm5eT2hhNRGWXKrU9CzDum
	Dan+7vxg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44538 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL1By-0002Xu-0c;
	Tue, 10 Dec 2024 14:26:26 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL1Bw-006cnG-O7; Tue, 10 Dec 2024 14:26:24 +0000
In-Reply-To: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
References: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH RFC net-next 3/7] net: dsa: b53/bcm_sf2: remove
 b53_get_mac_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL1Bw-006cnG-O7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:26:24 +0000

b53_get_mac_eee() is no longer called by the core DSA code. Remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/b53/b53_common.c | 7 -------
 drivers/net/dsa/b53/b53_priv.h   | 1 -
 drivers/net/dsa/bcm_sf2.c        | 1 -
 3 files changed, 9 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0561b60f668f..79dc77835681 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2232,12 +2232,6 @@ bool b53_support_eee(struct dsa_switch *ds, int port)
 }
 EXPORT_SYMBOL(b53_support_eee);
 
-int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
-{
-	return 0;
-}
-EXPORT_SYMBOL(b53_get_mac_eee);
-
 int b53_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
 {
 	struct b53_device *dev = ds->priv;
@@ -2299,7 +2293,6 @@ static const struct dsa_switch_ops b53_switch_ops = {
 	.port_enable		= b53_enable_port,
 	.port_disable		= b53_disable_port,
 	.support_eee		= b53_support_eee,
-	.get_mac_eee		= b53_get_mac_eee,
 	.set_mac_eee		= b53_set_mac_eee,
 	.port_bridge_join	= b53_br_join,
 	.port_bridge_leave	= b53_br_leave,
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 99e5cfc98ae8..9e9b5bc0c5d6 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -385,7 +385,6 @@ void b53_disable_port(struct dsa_switch *ds, int port);
 void b53_brcm_hdr_setup(struct dsa_switch *ds, int port);
 int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy);
 bool b53_support_eee(struct dsa_switch *ds, int port);
-int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e);
 int b53_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e);
 
 #endif
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index a53fb6191e6b..fa2bf3fa9019 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1233,7 +1233,6 @@ static const struct dsa_switch_ops bcm_sf2_ops = {
 	.port_enable		= bcm_sf2_port_setup,
 	.port_disable		= bcm_sf2_port_disable,
 	.support_eee		= b53_support_eee,
-	.get_mac_eee		= b53_get_mac_eee,
 	.set_mac_eee		= b53_set_mac_eee,
 	.port_bridge_join	= b53_br_join,
 	.port_bridge_leave	= b53_br_leave,
-- 
2.30.2


