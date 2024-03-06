Return-Path: <netdev+bounces-77834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B62F8732B7
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEA91C2145C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00FD5DF29;
	Wed,  6 Mar 2024 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FCVSiHNL"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB885DF1F
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718063; cv=none; b=A6FoExQSPXF8ghxYTqCao/Aubw1Ctjz+gS6QyhxcuCf+DcZIXQRbd9EhnzBUmNMDs3GzBF4muF50lX7uxbAaj5tE4VcCOiDtX4SlcHlMMq9eLnRxr6wxvFSYLAB2plX1U6QIVvCVg+VwzeOXhkdRvxg33gcqCy2lUv3fXCMxZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718063; c=relaxed/simple;
	bh=HuKkNTiZyk4Zd71i9Vg6WLAsDuyNUnnPZnh/6FTXYa0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TIp0wm3rMPTtPebhzXyyGrudR9GjSrAq1+pPdMF5TZpuboQdVbdBSA4B4+2OytyuLF3QaqdyXePZq7uqGGsolNpXPfTMl1LI/GZrQocovTKalr0r5JHXRRtVDhMpbhFLTrZepOeBIKXOFt33tNpFiOOtJyrCz1vRVU4rU+hLrpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FCVSiHNL; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 65FC387B3D;
	Wed,  6 Mar 2024 10:40:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709718053;
	bh=r4vxK5hI9QERuH4Gca4Fpm2D/0m36xecnukYNX+OwaE=;
	h=From:To:Cc:Subject:Date:From;
	b=FCVSiHNLFlxLr4uzSIONjM0XbDCbtKwfc1H/j90OKQ3f9YCwYARB+v5QXUIvAdEwZ
	 0daelvS7MsmivK7W1PVbdHmP/hIBOYZVWpRbFL9ZqNTo/jJ3OhZfIriBydqPnsnlGQ
	 wc1hRI3H+jZLpN/d4AX2ROSByD/n4m6qpvqq4jJUnCKlAQTqfrv5MWKJQUzckNhR3v
	 wLAb34iCg4ytXrI45mZFYdcr6ifWvDOAassgx96Bkwp3lHHWjCB99TfJiGq5zbLvQP
	 t698MRtTtJB86LLMLHewmUP7CQd2UWCDpsf9kpBcsMwM4sMYxpFH1OVrm5Eo3C+ijF
	 HCAB7JxmMbB3Q==
From: Lukasz Majewski <lukma@denx.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2] net: hsr: Use full string description when opening HSR network device
Date: Wed,  6 Mar 2024 10:40:26 +0100
Message-Id: <20240306094026.220195-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Up till now only single character ('A' or 'B') was used to provide
information of HSR slave network device status.

As it is also possible and valid, that Interlink network device may
be supported as well, the description must be more verbose. As a result
the full string description is now used.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- Use const char * instead of char * - to assure that pointed string is
  immutable (.rodata allocated).
---
 net/hsr/hsr_device.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 9d71b66183da..904cd8f8f830 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -142,30 +142,29 @@ static int hsr_dev_open(struct net_device *dev)
 {
 	struct hsr_priv *hsr;
 	struct hsr_port *port;
-	char designation;
+	const char *designation = NULL;
 
 	hsr = netdev_priv(dev);
-	designation = '\0';
 
 	hsr_for_each_port(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
 		case HSR_PT_SLAVE_A:
-			designation = 'A';
+			designation = "Slave A";
 			break;
 		case HSR_PT_SLAVE_B:
-			designation = 'B';
+			designation = "Slave B";
 			break;
 		default:
-			designation = '?';
+			designation = "Unknown";
 		}
 		if (!is_slave_up(port->dev))
-			netdev_warn(dev, "Slave %c (%s) is not up; please bring it up to get a fully working HSR network\n",
+			netdev_warn(dev, "%s (%s) is not up; please bring it up to get a fully working HSR network\n",
 				    designation, port->dev->name);
 	}
 
-	if (designation == '\0')
+	if (!designation)
 		netdev_warn(dev, "No slave devices configured\n");
 
 	return 0;
-- 
2.20.1


