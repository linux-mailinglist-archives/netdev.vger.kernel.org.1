Return-Path: <netdev+bounces-181506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482E2A85414
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826E19A2F01
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEEB27CCF0;
	Fri, 11 Apr 2025 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="SLPNWgK1";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="HeVoDT9K"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA131EA7FF;
	Fri, 11 Apr 2025 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744352676; cv=pass; b=p3YcW+ER2srvQcxzxEeRSnEl/WsMryn1G5vkh9GgK5u/P2wzU+QQyYoqTgnzSMQB787GlZaGBSTgtUF3A2l5PSvaCjq9SmTbEkq7p0MlhjZQPt0oJ2FgD0muZQaoPMvYTUQ2aQJ6mSmzqIwYBTrF1VY4T146qf/mCOc75NxPYnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744352676; c=relaxed/simple;
	bh=ERCmBantk2LnweUCkk4K2enwOWJamFzqDS/phPXF1bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iz6jjDrVlM86SDZ1jt08k/ATYYXwfqCsIJjJ7yIp8YrFwRizmtn1omHMVpGug7ZrNQemzW4QKr7f/uVaO8xTGqB5XU69EFLCTG20vSM5rZ70xzwIhKNmRV/HsWtnOAhyzexUfCkisQeLmEKx5DVMiSz82d2DUZ/TdJZeN0P0b/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=SLPNWgK1; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=HeVoDT9K; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1744352671; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aodHinYpArFDHwglhAMGu87ZNr1wK/riCjVeXVWz46a+ujJTdww/26d8MfkMpVudQJ
    XPFDN+px2ijLub+evDbDUzx+wyDjSLTdLUX8iu2HZYxj4XT5uxpeOlzaEFNWsM5hVnxy
    ax4O2w+dsoHl8s8Ks0yXTeHmC/UTrvwuEu+rim8HCq4nOLfRgVbXE2xqvfFJC1Y8+8RU
    3O3ggBHAVy0zTi3bJa4mIsUwEa3QYzo9eseDWwjjisXBELQTtKikQg6TD4L+Sv972fyG
    a6kR9u3swHObsml9CPk2jCnLKfUs4E08sslYuHh7bKDTn4e9IjtHaHL27e/RnAiPdF7h
    hCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744352671;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mVD+8eLKgilpbqco4uatsNA+l+zVFBjet++GdBopLxI=;
    b=SJNI27a9vZYvgV/E764dEZ2DpqrXw+lGaubIyhmwaX3JWcQFEOAMh0SWSR+uCC+XXD
    5RIu2vnEuSoUjwi3FQqD/nLtNqKEv2gx8jj6MxtUUaYxmT1RZl6QzcA1mVGA0C1deczg
    uYzLe0pG1G8+D6ZaoYuEd53f5qx+SPOYLHmvBXQ+TTbfW1RQcIDWElsRheBsdagkAywI
    MY2c/hO+Cxg6Z1mL004h8omwKR875bxB0xr9h9r4LcNbMsfdOJ8LaKp846TJWfsnTQDo
    sHH3PK0hCpUU599N/StuR1FQV1UGWXK4HPt+C/0sx1TbSu2W4Vf27qZuhmntvyxIjeoo
    p6tA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744352671;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mVD+8eLKgilpbqco4uatsNA+l+zVFBjet++GdBopLxI=;
    b=SLPNWgK1gOQsrYbBM3sv4E9hzSrC3LOIwxATnJzhzMR3+cHzUgy/K3RjisqBf5XDue
    N0Gliv5GKnIsuuQg2LqWs12s+78aGnirYzVQc/1klBXVYAun9ywCOE8dSsqJtqu+XOR7
    mGDTymvpifcmMK6s4F5dyENxA8p4h6f80HihI5oX4vrLqpmdCeL/CO3r6iMnCI4gHE52
    02EuHry5aiRkXfzuisFB++OTM/aqo7svQJXZBj6tP/DsD8DSi+pP8VXxFRMLF1e2X1Du
    hP0xNUWV6VkCmTfeFGQgnS5QTkI489I0n9hVNyKfQgzbYPQk6fpXxUxtnomhkcFs4IzI
    B8nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744352671;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mVD+8eLKgilpbqco4uatsNA+l+zVFBjet++GdBopLxI=;
    b=HeVoDT9Kcsp0x3lctKc2ry2uLQxQUDzWkOPiP4onwdpYdCAeEhhL1qgzpNJu3S1Lvc
    KrDFyhu86tRPjzwIR3Cw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3513B6OVHaZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 11 Apr 2025 08:24:31 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1u37oU-0000Ms-0U;
	Fri, 11 Apr 2025 08:24:30 +0200
Received: (nullmailer pid 8869 invoked by uid 502);
	Fri, 11 Apr 2025 06:24:30 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v6 1/4] net: phy: realtek: Group RTL82* macro definitions
Date: Fri, 11 Apr 2025 08:24:23 +0200
Message-Id: <20250411062426.8820-2-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411062426.8820-1-michael@fossekall.de>
References: <20250411062426.8820-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Group macro definitions by chip number in lexicographic order.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 drivers/net/phy/realtek/realtek_main.c | 31 +++++++++++++-------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 893c82479671..f6e402bf78bf 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -17,6 +17,16 @@
 
 #include "realtek.h"
 
+#define RTL8201F_IER				0x13
+
+#define RTL8201F_ISR				0x1e
+#define RTL8201F_ISR_ANERR			BIT(15)
+#define RTL8201F_ISR_DUPLEX			BIT(13)
+#define RTL8201F_ISR_LINK			BIT(11)
+#define RTL8201F_ISR_MASK			(RTL8201F_ISR_ANERR | \
+						 RTL8201F_ISR_DUPLEX | \
+						 RTL8201F_ISR_LINK)
+
 #define RTL821x_PHYSR				0x11
 #define RTL821x_PHYSR_DUPLEX			BIT(13)
 #define RTL821x_PHYSR_SPEED			GENMASK(15, 14)
@@ -31,6 +41,10 @@
 #define RTL821x_EXT_PAGE_SELECT			0x1e
 #define RTL821x_PAGE_SELECT			0x1f
 
+#define RTL8211E_CTRL_DELAY			BIT(13)
+#define RTL8211E_TX_DELAY			BIT(12)
+#define RTL8211E_RX_DELAY			BIT(11)
+
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_CLKOUT_EN			BIT(0)
@@ -47,6 +61,8 @@
 #define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
 #define RTL8211F_LEDCR_SHIFT			5
 
+#define RTL8211F_LED_COUNT			3
+
 #define RTL8211F_TX_DELAY			BIT(8)
 #define RTL8211F_RX_DELAY			BIT(3)
 
@@ -54,19 +70,6 @@
 #define RTL8211F_ALDPS_ENABLE			BIT(2)
 #define RTL8211F_ALDPS_XTAL_OFF			BIT(12)
 
-#define RTL8211E_CTRL_DELAY			BIT(13)
-#define RTL8211E_TX_DELAY			BIT(12)
-#define RTL8211E_RX_DELAY			BIT(11)
-
-#define RTL8201F_ISR				0x1e
-#define RTL8201F_ISR_ANERR			BIT(15)
-#define RTL8201F_ISR_DUPLEX			BIT(13)
-#define RTL8201F_ISR_LINK			BIT(11)
-#define RTL8201F_ISR_MASK			(RTL8201F_ISR_ANERR | \
-						 RTL8201F_ISR_DUPLEX | \
-						 RTL8201F_ISR_LINK)
-#define RTL8201F_IER				0x13
-
 #define RTL822X_VND1_SERDES_OPTION			0x697a
 #define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)
 #define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII		0
@@ -112,8 +115,6 @@
 #define RTL_8221B_VN_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
 
-#define RTL8211F_LED_COUNT			3
-
 MODULE_DESCRIPTION("Realtek PHY driver");
 MODULE_AUTHOR("Johnson Leung");
 MODULE_LICENSE("GPL");
-- 
2.39.5


