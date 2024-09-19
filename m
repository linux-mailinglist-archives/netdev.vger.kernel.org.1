Return-Path: <netdev+bounces-129009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A892D97CEA3
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECE9284B6C
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DC714B064;
	Thu, 19 Sep 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fgjVTz8R"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF813B294
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779706; cv=none; b=pv3FIw6iRq8BjFHeZ8UI1FR1VkhZLKk8C+8V3XSBpcQsJ6YQ36aH6NY1Qc1buwShOkt5ITrfbkde5nee+4n3IfxFC0JYiO5HYFSeYVmsuR0bb/vhBO2vwv6ezVCunrgxQe1MblZXvM929KV1mRrxQ3vR9m5k3Yl/vPEbpdBLO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779706; c=relaxed/simple;
	bh=DdNWBOjtXYY5rNiTUbs/qf21127HTmaFAwbHaMMv8Q8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KvCI7XgMyMUwgpFRXze1k7uTdFirsE73rADlbvYn+zJaqeX4M/eCgark++9gsl02bOZPItpu/KXu3lKIqo5XquEkzxwWDGavlvPxTBdNjhnBmk9ZxYrGXvZoYlu2ty7SLvpMFWRrEzG8tLp1TMwFyPU75A5vN1QxEbCUmZt0M4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fgjVTz8R; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1PBE000564;
	Thu, 19 Sep 2024 16:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726779685;
	bh=r+5xOb5sBwODs1GrwTbXdcYSYcVnHnF9sNGdhAeus8w=;
	h=From:To:CC:Subject:Date;
	b=fgjVTz8RcN04k3ufB3suLgke3Y21L4SUku/87me2n54rgzILuVAaTUfMSyrDDWFov
	 hS3VaLkQfTJsv8E0ACq3qLuXA7rLreOptOpOEdILGOSiJB22xPyzJ2h/2q1UHxdxhy
	 0UaYQNRkD8TXZNvWUyzC7C4seybrWa4mfVrornCY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1PGf008373;
	Thu, 19 Sep 2024 16:01:25 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Sep 2024 16:01:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Sep 2024 16:01:25 -0500
Received: from Linux-002.dhcp.ti.com (linux-002.dhcp.ti.com [10.188.34.182])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1OC4098001;
	Thu, 19 Sep 2024 16:01:24 -0500
From: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <maxime.chevallier@bootlin.com>, <o.rempel@pengutronix.de>,
        <spatton@ti.com>, <r-kommineni@ti.com>, <e-mayhew@ti.com>,
        <praneeth@ti.com>, <p-varis@ti.com>, <d-qiu@ti.com>,
        "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
Subject: [PATCH 0/5] Extending features on DP83TG720 driver
Date: Thu, 19 Sep 2024 14:01:14 -0700
Message-ID: <cover.1726263095.git.a-reyes1@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The DP83TG720S-Q1 device is an IEEE 802.3bp
and Open Alliance compliant automotive Ethernet
physical layer transceiver. It provides all physical layer
functions needed to transmit and receive data over
unshielded/shielded single twisted-pair cables.

Changes include changing Macros Names, adding SGMII support, extending
support to DP83TG721 PHY, and adding the Open Alliance initialization script.

Each of these changes are a separate patch and are meant to
be applied in order.

The following test cases were validated:
PHY detection
PHY link up/down
Speed/Duplex mode
PHY register access
Ping test
Throughput test
SQI test
TDR test
Forced master-slave

Changes in v2:
1. split all changes made into different patches
2. fixed typos in original patch descriptions

Alvaro (Al-vuh-roe) Reyes (5):
  net: phy: dp83tg720: Changed Macro names
  net: phy: dp83tg720: Added SGMII Support
  net: phy: dp83tg720: Extending support to DP83TG721 PHY
  net: phy: dp83tg720: Added OA script
  net: phy: dp83tg720: fixed Linux coding standards issues

 drivers/net/phy/dp83tg720.c | 582 +++++++++++++++++++++++++++++++-----
 1 file changed, 504 insertions(+), 78 deletions(-)

-- 
2.17.1


