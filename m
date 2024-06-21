Return-Path: <netdev+bounces-105574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04845911E04
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82DD9B24A97
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5421E171074;
	Fri, 21 Jun 2024 08:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D017083B
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956931; cv=none; b=GE0zdoyeKpMU5ZuQstaX3FCDbH3ppseoDC0BDt0MQfGSR8Z587HZPlcmmxPU69h0x0Dun1xW0CGgh6LYNxjXNhxgwcvYrS6gZHQQQNT1SrLwYYJtw0HipZX7h+0PqT05SmvKApJJ2ltys8fVUifNUH/Yyt3EnXkEADsf58pqk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956931; c=relaxed/simple;
	bh=E+13Nn0ffTfbFMRmJ25z1lyNg6HGXln7TOTVSXz5P+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6DjmThR34tZVQUifdTZVawZ48RdGyDM9oqAJo46yCRC8yoj286jSYo56MeSjbr+3XY3tGMtWYvpDsNdRao+DtfTMGd4lX6SkmMMtsllfVr8/37FVaeb8qM+QTMBk0YJaRX5kk+l//kc5tll1HzETk/WHIbmoTG46flcpcQe4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDj-0003y6-3f
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:07 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDh-003tGs-1t
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id AE41B2EE3CD
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C3A0B2EE38E;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 122e7dfa;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/24] can: sja1000: plx_pci: Reuse predefined CTI subvendor ID
Date: Fri, 21 Jun 2024 09:48:22 +0200
Message-ID: <20240621080201.305471-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is predefined PCI_SUBVENDOR_ID_CONNECT_TECH, use it in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20240502123852.2631577-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/plx_pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index 5de1ebb0c6f0..67e5316c6372 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -122,7 +122,6 @@ struct plx_pci_card {
 #define TEWS_PCI_VENDOR_ID		0x1498
 #define TEWS_PCI_DEVICE_ID_TMPC810	0x032A
 
-#define CTI_PCI_VENDOR_ID		0x12c4
 #define CTI_PCI_DEVICE_ID_CRG001	0x0900
 
 #define MOXA_PCI_VENDOR_ID		0x1393
@@ -358,7 +357,7 @@ static const struct pci_device_id plx_pci_tbl[] = {
 	{
 		/* Connect Tech Inc. CANpro/104-Plus Opto (CRG001) card */
 		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
-		CTI_PCI_VENDOR_ID, CTI_PCI_DEVICE_ID_CRG001,
+		PCI_SUBVENDOR_ID_CONNECT_TECH, CTI_PCI_DEVICE_ID_CRG001,
 		0, 0,
 		(kernel_ulong_t)&plx_pci_card_info_cti
 	},
-- 
2.43.0



