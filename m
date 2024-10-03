Return-Path: <netdev+bounces-131707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3F098F4F9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5C51C209C6
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2B1A7270;
	Thu,  3 Oct 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="Kwpafjwb"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EE1A3033
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975994; cv=none; b=iyNRsjDHedAjzhfaH9OtHUgkRk8/XcYfYt17veijsAz76/xlJ2mGVK0NRZoOKp9iskNToMdNYXgnubQQI0cpTS7tNXLzfpGej586bHdI5Yk0UT0j5YqdxnAJ9bvn9pV+KLBGyu4NED4s80saHqu57z74l7aH++1wYpa+qbbA6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975994; c=relaxed/simple;
	bh=FwJU9T7i0XG2e1er5OYwUXDJRmhVpCexF42p7XuvnCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n+seSqKl9GBkxQc2Oy/eaPGX6Cz3qajsbKT2wIrSeBr6hGvEBce9tLNoOC0NmsqoAXUc9GXtOS2VH1nacJ/VFBl+64vKmi9M9ZGJyxnRXIsE7oZdK9St5QB7PpP/3AUMfuGO2kR5E/SAT/g05YxYAT8eNgN2354IBIZXLmShOuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=Kwpafjwb; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 41019 invoked from network); 3 Oct 2024 19:19:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1727975983; bh=msin+ke69LSUjcC5EkY3t5O6p39FA9nVBIb45aUwfFM=;
          h=From:To:Cc:Subject;
          b=KwpafjwbHSudSOS4+EnaloVJzjggAC2iNM2VeKDo7ENyjXMWE9/XvWtQMoz+XWiZV
           n2ANw1jzSXOhhk9Nj1mvN2AeS/hDhaUIfz5o7xKAsL7dLb8YsAW/lshXKlONY83ZUh
           59koLskliDSbh45S+xMBVpfCXthbkWtjFfl21N4w=
Received: from 83.5.182.107.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.182.107])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <nicolas.ferre@microchip.com>; 3 Oct 2024 19:19:43 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH net-next] net: macb: Adding support for Jumbo Frames up to 10240 Bytes in SAMA5D2
Date: Thu,  3 Oct 2024 19:19:41 +0200
Message-Id: <20241003171941.8814-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 695f0301ca693e107a943fee1033adf9
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [sTNE]                               

As per the SAMA5D2 device specification it supports Jumbo frames.
But the suggested flag and length of bytes it supports was not updated
in this driver config_structure.
The maximum jumbo frames the device supports:
10240 bytes as per the device spec.

While changing the MTU value greater than 1500, it threw error:
sudo ifconfig eth1 mtu 9000
SIOCSIFMTU: Invalid argument

Add this support to driver so that it works as expected and designed.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f06babec04a0..9fda16557509 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4841,10 +4841,11 @@ static const struct macb_config pc302gem_config = {
 };
 
 static const struct macb_config sama5d2_config = {
-	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
+	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
+	.jumbo_max_len = 10240,
 	.usrio = &macb_default_usrio,
 };
 
-- 
2.39.5


