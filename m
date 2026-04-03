Return-Path: <netdev+bounces-274957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJSTIYaDz2mwwwYAu9opvQ
	(envelope-from <netdev+bounces-274957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:08:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC44C392969
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BD2C301DEC2
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912953845C6;
	Fri,  3 Apr 2026 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="JnJtS1st"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4D3859CE;
	Fri,  3 Apr 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207276; cv=none; b=Ca1amWDVZKIG2TUTiTi15qiCeiuTmuQ1NEj6BZ6K/2wQPVHI472JCN52DjT8FFpGyYUP4c6cB8UoS8iXEw5/hI0WB7QGoJbSTpymbQ5AUgImfoZDiB4qQDHccMrwiABBTgF+yszCOr0DER/jvrTflEiYdgM+5QiBIhnVAD+qJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207276; c=relaxed/simple;
	bh=Jil8SCpCHIG8fcwJ6NpAU99pU3A40fanjCMqhBKrx2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbJ++hTP9+PiTwVirhNi1d9jmpiiLmarHI5kA2gmUK1Wjut6tiGHuCC7ppTbOS7ixhlH7+XZjDqgj+NkzljldfVm/8920ZZ7gkFQ+4rMNaRbnK3NHqf4ECBC5qyqQyYrlTflKj/WCioss00lZ2kW44WtXLVy/dhdm152/ZlsuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=JnJtS1st; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3601A11AE;
	Fri,  3 Apr 2026 11:07:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775207257; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=1XfxGKOARUvreYaAqzFmJPO+BFlwSnB7GItiL5w4+g8=;
	b=JnJtS1stn6y37PdmtadanzFNUC669SDnO/qbNZBvqMrIfGFAGZZ6zKjBg8EGfzZYmIsTn7
	IRb1W0s7H/Q+Gm24nkxyHpJAcH5a6fAETEPB4zglGe3o1ukDtJiiQhWFwrc/ROIN+ck7Fn
	taACAxBp+Hjhs2QB/OxtGYQqyG6MsG4KnfzxLRQIiRSwn7OrvBSyL9mwniFV3rO1gq5F/E
	TwE1NG6aaBLgXssJX+EE+Y9MPlzaWzy37Wlru81Ux07BpmIbz0EhWUB6WXq/VSUe2XzAkq
	QZZ620vCsVPBHK9QoYIacTDv+clDlE3oJvX+zn9RiNqKtkTbQ5ENxJtHqgI6hA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 2/3] net: phy: broadcom: implement .disable_autonomous_eee for BCM54xx
Date: Fri,  3 Apr 2026 11:06:52 +0200
Message-ID: <20260403090656.733985-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260403090656.733985-1-nb@tipi-net.de>
References: <20260403090656.733985-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274957-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,broadcom.com,tipi-net.de,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC44C392969
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Disable AutogrEEEn mode on BCM54210E when the MAC indicates EEE support
via phy_support_eee(). In AutogrEEEn mode the PHY manages LPI
autonomously without forwarding LPI signaling to the MAC over the RGMII
interface, which prevents the MAC from controlling TX LPI entry/exit.

Clearing the AutogrEEEn enable bit in MII_BUF_CNTL_0 switches the PHY
to Native EEE mode where the MAC controls TX LPI and the PHY forwards
received LPI on the RGMII interface.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/broadcom.c | 7 +++++++
 include/linux/brcmphy.h    | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index cb306f9e80cc..bf0c6a04481e 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -1452,6 +1452,12 @@ static int bcm54811_read_status(struct phy_device *phydev)
 	return genphy_read_status(phydev);
 }
 
+static int bcm54xx_disable_autonomous_eee(struct phy_device *phydev)
+{
+	return bcm_phy_modify_exp(phydev, BCM54XX_TOP_MISC_MII_BUF_CNTL0,
+				  BCM54XX_MII_BUF_CNTL0_AUTOGREEEN_EN, 0);
+}
+
 static struct phy_driver broadcom_drivers[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_BCM5411),
@@ -1495,6 +1501,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.get_wol	= bcm54xx_phy_get_wol,
 	.set_wol	= bcm54xx_phy_set_wol,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	.disable_autonomous_eee	= bcm54xx_disable_autonomous_eee,
 }, {
 	PHY_ID_MATCH_MODEL(PHY_ID_BCM5461),
 	.name		= "Broadcom BCM5461",
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 115a964f3006..174687c4c80a 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -266,6 +266,9 @@
 #define BCM54XX_TOP_MISC_IDDQ_SD		(1 << 2)
 #define BCM54XX_TOP_MISC_IDDQ_SR		(1 << 3)
 
+#define BCM54XX_TOP_MISC_MII_BUF_CNTL0		(MII_BCM54XX_EXP_SEL_TOP + 0x00)
+#define  BCM54XX_MII_BUF_CNTL0_AUTOGREEEN_EN	BIT(0)
+
 #define BCM54XX_TOP_MISC_LED_CTL		(MII_BCM54XX_EXP_SEL_TOP + 0x0C)
 #define  BCM54XX_LED4_SEL_INTR			BIT(1)
 
-- 
2.51.0


