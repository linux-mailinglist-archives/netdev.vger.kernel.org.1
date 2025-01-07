Return-Path: <netdev+bounces-155688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2FAA03578
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455383A337F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DA733086;
	Tue,  7 Jan 2025 02:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="KkDnJ4rw"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE90118C0C
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218305; cv=none; b=IjLD4S2CTIZoGdkA/l4AgzkNFmjCjR7H7GqgoRT8GuOpP21fTVSENxjjx7HLjlSrZ+fs2Z4wExMP/5yD0Qt8tzfqErUra5KSkPuMp8dMBri9ORJH9tNVScZ+d7yCt3oYfYoD1oEFHJahjgQlIILhHCARoVmrl4nYD0oh8cPgdIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218305; c=relaxed/simple;
	bh=ZQCjTnrC+eQQwsbIRkFxunZ7IDCq4JWg1FkkSwGz6bU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knCrqL450YPwDDf+64+ofEZMGHo0JOsUEuiSZ664xFQBcZX/PjiB14+ktD5NXmYqPA3WXZryELDpsQkvTN77nie9YzizDen3W/Ta7d5CR1CP6h2XBfwM1QkL2UwVtlNyD9QpAAEqsXiU588G88s9yZq54n42HJxamAWvDUmBlqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=KkDnJ4rw; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2081; q=dns/txt; s=iport;
  t=1736218301; x=1737427901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5oTBSVgdz/mXP/359jvtRWK9RXTfrLMUwJKW4oneDJM=;
  b=KkDnJ4rwmr62qBfkCsi7YLHYrhdVeJ86KZdLRtD/LcdeMSX198SlBoXu
   9isNOFO37L+QMHuFW6gwnSUSHdveqQtIr8QjllEm3gO798kNcrt7fh2hM
   M7P7JH1SEKkqzhfwfEb3dAZHS3i6cb3GYYpiw13Js1oKn1Q9WAX9BbKK2
   o=;
X-CSE-ConnectionGUID: cRIvfhrmQuC5L6H1s0IqJg==
X-CSE-MsgGUID: qtGuCkURSIyIv3UJ+NhFig==
X-IPAS-Result: =?us-ascii?q?A0ANAADjlXxnj5MQJK1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBhBlDSIxyX6cNFIERA1YPAQEBD0QEAQGFBwKKdAImNAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwUUAQEBAQEBOQVJhgiGWwIBAycLA?=
 =?us-ascii?q?TQSEFErKwcSgwGCZQOwP4F5M4EB3jOBbYFIAYVqh19whHcnG4FJRIJQgT5vh?=
 =?us-ascii?q?CpmhXcEh2yddEiBIQNZLAFVEw0KCwcFgTk6AyILCwwLFBwVAhUeARIGFQR0R?=
 =?us-ascii?q?DmCRmlJNwINAjWCHiRYgiuEXIRHhFaCSVWCSIIXfIEagm5AAwsYDUgRLDcGD?=
 =?us-ascii?q?hsGPm4HmmY8g20BgQ41RzWmf6EDhCWBY59jGjOqU5h8IqQlhGaBZzqBWzMaC?=
 =?us-ascii?q?BsVgyJSGQ+OLQ0JuAclMjwCBwsBAQMJkXQBAQ?=
IronPort-Data: A9a23:Zzbika+sqSbmdNeAASNcDrUDZX6TJUtcMsCJ2f8bNWPcYEJGY0x3z
 zFKX2iDMq3bajH8KIx2bI+xoB8HucDSz99lTlRp/CtEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4E/rauW5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qoyyHjEAX9gWMsazpKs/nrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2k9B6wG9OZtBFhT3
 qE8dhBUdUiinsC5lefTpulE3qzPLeHiOIcZ/3UlxjbDALN/GdbIQr7B4plT2zJYasJmRKmFI
 ZFHL2MxKk2cPHWjOX9PYH46tOWvhn/zejlVgFmUvqEwpWPUyWSd1ZCxaIqJKoXbHJo9ckCwv
 37p4k/6PyshFc2+12G40DGKhsHOknauMG4VPOblrqEx2gL7KnYoIBEfS1a+ifWwlEO7X9VRN
 woS9zZGhaU+6UmiXNThdxK/p3GAs1gXXN84O+4n4gilyafO5QudQG8eQVZpYdoqrsIpBjony
 lOEgfvtGDpp9raVIVqF/72ZqzKaIyUZLWYeIyQDSGMt5dT/rIwtpgzAQ8wlE6OviNDxXzbqz
 Fi3QDMWjrEXi4sPkq68512C2mrqrZnSRQlz7QLSNo640u9nTIWfRpKm6ULe1OtrcaLHbgCa5
 FkducfLuYjiEqqxvCCKRewMGpSg6PCELCDQjDZT838JqW3FF5mLI9w43d1uGHqFJProbtMAX
 aMyhe+zzMILVJdJRfYrC25UNyjM5fKxfTgCfquPBueimrArKGe6ENhGPCZ8JVzFnkk2ir0YM
 pyGa8uqBntyIf04l2TvF7dGied0lnxWKYbvqXbTkkrPPV22OS/9dFv5GAHVBgzExPre+VyLr
 4Y32zWilEUHDLeWjtbrHX47dg1SciNhWvgaWuRcd/WIJUJ9CXo9BvrKibIncMoNokimvrmgw
 51JYWcBkACXrSSecW2iMykzAJuxBswXhSxgYkQR0aOAhyNLjXCHsPxHL8NfkHhO3LAL8MOYu
 NFfIp7aWK0SFGiZk9nfBLGkxLFfmN2QrVrmF0KYjPIXJvaMmyShFgfYQzbS
IronPort-HdrOrdr: A9a23:SImdR6PL6aIdMMBcTsajsMiBIKoaSvp037Dk7S9MoHtuA6ulfq
 +V/cjzuSWYtN9VYgBDpTniAtjlfZqjz/5ICOAqVN/INjUO+lHYSb2KhrGN/9SPIUHDH5ZmpM
 Rdm2wUMqyIMbC85vyKhjWFLw==
X-Talos-CUID: 9a23:RDCtamDb6FJqg/r6EyJd1VAaGtogS2D2kVOOAxajUUdwarLAHA==
X-Talos-MUID: 9a23:iPWkeQQbDONJ9MJdRXT1mB5/H8RV2Z+PGWETyqgk+O+EGy1/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,294,1728950400"; 
   d="scan'208";a="408481917"
Received: from alln-l-core-10.cisco.com ([173.36.16.147])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Jan 2025 02:51:40 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-10.cisco.com (Postfix) with ESMTP id 97BB118000274;
	Tue,  7 Jan 2025 02:51:40 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 67A6F20F2005; Mon,  6 Jan 2025 18:51:40 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next 2/2] enic: Obtain the Link speed only after the link comes up
Date: Mon,  6 Jan 2025 18:51:35 -0800
Message-Id: <20250107025135.15167-3-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250107025135.15167-1-johndale@cisco.com>
References: <20250107025135.15167-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-10.cisco.com

The link speed is obtained in the RX adaptive coalescing function. It
was being called at probe time when the link may not be up. Change the
call to run after the Link comes up.

The impact of not getting the correct link speed was that the low end of
the adaptive interrupt range was always being set to 0 which could have
caused a slight increase in the number of RX interrupts.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 957efe73e41a..49f6cab01ed5 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -109,7 +109,7 @@ static struct enic_intr_mod_table mod_table[ENIC_MAX_COALESCE_TIMERS + 1] = {
 static struct enic_intr_mod_range mod_range[ENIC_MAX_LINK_SPEEDS] = {
 	{0,  0}, /* 0  - 4  Gbps */
 	{0,  3}, /* 4  - 10 Gbps */
-	{3,  6}, /* 10 - 40 Gbps */
+	{3,  6}, /* 10+ Gbps */
 };
 
 static void enic_init_affinity_hint(struct enic *enic)
@@ -466,6 +466,7 @@ static void enic_link_check(struct enic *enic)
 	if (link_status && !carrier_ok) {
 		netdev_info(enic->netdev, "Link UP\n");
 		netif_carrier_on(enic->netdev);
+		enic_set_rx_coal_setting(enic);
 	} else if (!link_status && carrier_ok) {
 		netdev_info(enic->netdev, "Link DOWN\n");
 		netif_carrier_off(enic->netdev);
@@ -3063,7 +3064,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	timer_setup(&enic->notify_timer, enic_notify_timer, 0);
 
 	enic_rfs_flw_tbl_init(enic);
-	enic_set_rx_coal_setting(enic);
 	INIT_WORK(&enic->reset, enic_reset);
 	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
-- 
2.35.2


