Return-Path: <netdev+bounces-48472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CC17EE787
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 20:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0630E1C20430
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 19:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0323C481;
	Thu, 16 Nov 2023 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selfnet.de header.i=@selfnet.de header.b="AFlZnRYf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-1.server.selfnet.de (mail-1.server.selfnet.de [141.70.126.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BAF90;
	Thu, 16 Nov 2023 11:33:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64DE1403A1;
	Thu, 16 Nov 2023 20:33:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selfnet.de; s=selfnet;
	t=1700163191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C/qgsd93til2nE9EEIPcHiiKgfZ+FbrQSgJ2jg4YdJE=;
	b=AFlZnRYfgjfz/zkTsbsV9QcutZLJLzm1wWse1iyQFLsx8FFlsmmV1FGOG5V6TwNArgYlmi
	+vFwwGZTwgnwkyOHeYUmJzNfy+oMGauTl6FT7MwLUeZRsmA32WM0buGks4bcNIl0q+yH59
	dQtb2m9bWw2ygnSxHgPOwyypMTlkoYegYmvI6T073DkGeChpStYXoFO3MriNWtumNp5OBO
	pVZUk41IL7NV0MgmPULvgyUfMIlQ4R6s1m7SW/g3fYTFsNogRYJ0Nfk5GaUzy/ZM3fuFAO
	J08A+m/12WY06Xfy7rGhYS749MvEwJipqCogu5idpGYPI39FSaV6JZ0fWTGOrw==
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
Subject: [PATCH net-next v2] net: phy: broadcom: Wire suspend/resume for BCM54612E
Date: Thu, 16 Nov 2023 20:32:31 +0100
Message-ID: <20231116193231.7513-1-marcovr@selfnet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM54612E ethernet PHY supports IDDQ-SR.
Therefore wire-up the suspend and resume callbacks
to point to bcm54xx_suspend() and bcm54xx_resume().

Signed-off-by: Marco von Rosenberg <marcovr@selfnet.de>
---
Changes in v2:
- Changed commit message
- Rebased on commit 3753c18ad5cf

 drivers/net/phy/broadcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 3a627105675a..312a8bb35d78 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -1135,6 +1135,8 @@ static struct phy_driver broadcom_drivers[] = {
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


