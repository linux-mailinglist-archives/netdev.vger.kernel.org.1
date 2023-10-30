Return-Path: <netdev+bounces-45345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF6D7DC2F3
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 00:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE91281549
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 23:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B83510A3E;
	Mon, 30 Oct 2023 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selfnet.de header.i=@selfnet.de header.b="Qq/N8Vfi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CFE3C3C
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 23:02:42 +0000 (UTC)
X-Greylist: delayed 324 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 16:02:39 PDT
Received: from mail-1.server.selfnet.de (mail-1.server.selfnet.de [141.70.126.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994C4E1;
	Mon, 30 Oct 2023 16:02:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57C33409E5;
	Mon, 30 Oct 2023 23:57:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selfnet.de; s=selfnet;
	t=1698706627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PCsZTHDftr8v1kPvgW50F/V5olhAwY15OTuwMPbeyYg=;
	b=Qq/N8Vfi3ilbXcQ0xQ061biLwDUoayRiTxIIKKhFDlbJNE1ggo/Bj8/tTmcYqxuNsIZ1l0
	Ryuyet8AFFPCL589Ssga3y8y47IIC6jk7MQWbi8oAgoqEvQlpkitNhxAJQW2c1kSQvWAFi
	pLN2tkFnyjwdvXswIDqcdh2kgLTOP3Ga/trEFSWZ8cz3FBTthlN2SuZFGB/UAzXnlGC6Xz
	WnCredEuDVtZyx8b8DTIVCymPrRzq5MFZjKj4fl+KuCT9Ih9wENe6h76jA+wkcUzBwCGnU
	J+qN3B1iNRIXg1tfkBj/R0O8J/snchKtklHx6cYxTkTlrbWTdP1NKf08BWtkjQ==
From: Marco von Rosenberg <marcovr@selfnet.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Marco von Rosenberg <marcovr@selfnet.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: broadcom: Wire suspend/resume for BCM54612E
Date: Mon, 30 Oct 2023 23:54:45 +0100
Message-ID: <20231030225446.17422-1-marcovr@selfnet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some devices, the bootloader suspends the PHY before booting the OS.
Not having a resume callback wired up is a problem in such situations
since it is then never resumed.
This behavior was observed with a Huawei enterprise WLAN access point.

The BCM54612E ethernet PHY supports IDDQ-SR.
Therefore wire-up the suspend and resume callbacks
to point to bcm54xx_suspend() and bcm54xx_resume().

The same wire-up has been done in commit 38b6a9073007 ("net: phy:
broadcom: Wire suspend/resume for BCM50610 and BCM50610M") for two PHYs
also supporting IDDQ-SR.

Signed-off-by: Marco von Rosenberg <marcovr@selfnet.de>
---
 drivers/net/phy/broadcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 04b2e6eeb195..ac14f223649b 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -1060,6 +1060,8 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	.suspend	= bcm54xx_suspend,
+	.resume		= bcm54xx_resume,
 }, {
 	.phy_id		= PHY_ID_BCM54616S,
 	.phy_id_mask	= 0xfffffff0,
-- 
2.42.0


