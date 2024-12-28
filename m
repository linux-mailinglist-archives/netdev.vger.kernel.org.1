Return-Path: <netdev+bounces-154398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0F69FD85C
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 01:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FDF3A1DE7
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606D10E5;
	Sat, 28 Dec 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="O6xx1n28"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10EE17C
	for <netdev@vger.kernel.org>; Sat, 28 Dec 2024 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735344660; cv=none; b=KeQh0jwHUFKfzN5MdD7haMRbAzzhMkLkVXqdBCvcrDb54mMqK11D3QIuCGas+8Ot/dV2YLa6IEJRTpGc0ebUiLRd7ghYy1jCZwh7WYgamZdPnPpNMvBdeTMHSKoWzzQ85uQQhT8E/M6DCNyf15ORtVMHMX06ZgxQy9lSHdnTYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735344660; c=relaxed/simple;
	bh=aMI6G4+6bzJb+anyQgEzssfzLmuzvLdakEurw0v5ohs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gq4o4PKD/xhoFZ4y06+E45pX4wXJK99iRqys1dmw+blu1w+lKFfBYUyuyCwGDOHUlkwo23sS8opVV1Q2dJw1Iwg6maY9/WtZbyyI2no/+iQvcOTj93MZaTXdyK+eNiR7JbGqEd7I94W16w0pdbOmnigzE4zgCfIMDn/ahWXwdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=O6xx1n28; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2184; q=dns/txt; s=iport;
  t=1735344659; x=1736554259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oW24QAvEMClDRsFo461Ziss5hE4bi3xly79bpxRN0oc=;
  b=O6xx1n28FZOM6U3Yo0vjQpkWqdAwfPVAkpePATtRpjVTxdfO3+f9s+in
   eNE5DtOHFLMOOsJmjqcstEUIFPCHswUl4ngvKdZbSjkmWuSUT3cYnj3Ct
   1+uSstDoC0L1i2jZgoYlfT5uNdx+JgO+Rg+oZljo96xGhhopRdTH4JhF1
   M=;
X-CSE-ConnectionGUID: DiZQ4zYsS76o09k+1OcmzA==
X-CSE-MsgGUID: l4RUCUNNS0KFAD/CXetQeA==
X-IPAS-Result: =?us-ascii?q?A0AlAQDJQG9nj43/Ja1aHgEBCxIMgggLhBpDSI1Rpw0Ug?=
 =?us-ascii?q?REDVg8BAQEPRAQBAYUHAopuAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBRQBAQEBAQE5BUmGCIZbAgEDJwsBNBIQUSsrBxKDAYJlA7E5g?=
 =?us-ascii?q?XkzgQHeM4FtgUiFa4dfcIR3JxuBSUSCUIE+b4QqZoV3BIkVnnJIgSEDWSwBV?=
 =?us-ascii?q?RMNCgsHBYE5OgMiDAsMCxQcFQKBHoEBARQGFQSBC0U9gkppSTcCDQI2giAkW?=
 =?us-ascii?q?IJNhReEXoRWgklVgnuCF3yBGoIlQAMLGA1IESw3Bg4bBj5uB5xfRoNyAYEOf?=
 =?us-ascii?q?Kc0oQOEJIFjn2MaM6pSmHwioztphGaBZzqBWzMaCBsVgyJSGQ+OLQ0JtSAlM?=
 =?us-ascii?q?jwCBwsBAQMJkTMBAQ?=
IronPort-Data: A9a23:bltvRas4fkZx0CgsMDkQkebSkefnVLJeMUV32f8akzHdYApBsoF/q
 tZmKTzVbvveNDDyKtB1aI+/oU0E757cmIQ3SwY++38wF3wRgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav656yEhjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGYjdJ5xYuajhIsvjZ90sz1BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw1udFOD1cx
 Ocjd24KNkGAxLuRy7epY7w57igjBJGD0II3oHpsy3TdSP0hW52GG/mM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwtOYH49tL/Aan3XcTpYrl6coacf6GnIxws327/oWDbQUoDSGJ0Jwx3I9
 woq+Uz9XisnH+G57wHd0VyFqqjkrS7nYY87QejQGvlC2wDLmTdJV3X6T2CTrfCnh0uWV9tBJ
 kkQ/SQy664/6CSDQ9XgWhSqrWKssRkbVN5dVeY97Wmlybfe6i6aC3ICQzoHb8Yp3Oc/QzAw2
 0DKmd71CTFxmLmIT3Tb/bf8hSu7MyUTLEcYaCMERBdD6N7myKk1gw7DQ8hLDqG4lJv2FCv2z
 jTMqzIx74j/luYR3Km9uFSCiDW2q92REkg+5x7cWSSu6QYRiJOZi5KAxVnp1KpSHZ2iEQeG5
 CkH2JG55+UcJMTY/MCSe9klELas7veDFTTTh19zApUsnwhBHVb9Jui8BxkgeC9U3tY4RNP/X
 KPEVepsCH5v0JmCMPUfj2GZUphCIU3c+TLNCqu8gj1mOcQZSeN/1HsyDXN8Jki0+KTWrYkxO
 I2AbeGnBmsABKJswVKeHrhGjOVwmXBvnjKOHfgXKihLN5LAPRZ5rp9YYDOzghwRtvjsTPj9q
 owGbpDbkX2zrsWjPXWIreb/0mzm3VBgWMip8JYIHgJyCgFnA2omQ+TA2q8sfpctnqJe0I/1E
 oKVBCdlJK7ErSSfc22iMyk7AJu2BMYXhSxgZ0QEYw33s0XPlK7zt8/zgbNrJuF/rISODJdcE
 5E4Ril3Kq0fEGqaompENMaVQU4LXE3DuD9i9hGNOFAXF6OMjSSTkjM4VmMDLBUzMxc=
IronPort-HdrOrdr: A9a23:1/DW166pnua7aGC5vgPXwM/XdLJyesId70hD6qm+c3Nom6uj5q
 eTdZsgtCMc5Ax9ZJhko6HjBEDiewK5yXcK2+ks1N6ZNWGM0ldAbrsSiLcKqAePJ8SRzIJgPN
 9bAstD4BmaNykCsS48izPIdeod/A==
X-Talos-CUID: 9a23:AGQzpW8k9palSwl3uyOVv2IVKPl5YEzG9yiOJBfpCiUwb7aQW3bFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AYhYhaA948rwQmScaHmmWgeOQf8M02ZmFNWYrqs0?=
 =?us-ascii?q?lleCocgdANiukgR3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,269,1728950400"; 
   d="scan'208";a="405045389"
Received: from rcdn-l-core-04.cisco.com ([173.37.255.141])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Dec 2024 00:10:57 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-04.cisco.com (Postfix) with ESMTP id D0EFA18000194;
	Sat, 28 Dec 2024 00:10:57 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 961C320F2009; Fri, 27 Dec 2024 16:10:57 -0800 (PST)
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
Subject: [PATCH net-next v3 6/6] enic: Obtain the Link speed only after the link comes up
Date: Fri, 27 Dec 2024 16:10:55 -0800
Message-Id: <20241228001055.12707-7-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241228001055.12707-1-johndale@cisco.com>
References: <20241228001055.12707-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-04.cisco.com

The link speed was being checked before the link was actually up and so
it was always set to 0. Change the adaptive RX coalescing setup function
to run after the Link comes up so that it gets the correct link speed.

The link speed is used to index a table to get the minimum time for the
range used for adaptive RX. Prior to this fix, the incorrect link speed
would select 0us for the low end of the range regardless of actual link
speed which could cause slightly more interrupts.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 21cbd7ed7bda..12678bcf96a6 100644
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
@@ -3016,7 +3017,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	timer_setup(&enic->notify_timer, enic_notify_timer, 0);
 
 	enic_rfs_flw_tbl_init(enic);
-	enic_set_rx_coal_setting(enic);
 	INIT_WORK(&enic->reset, enic_reset);
 	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
-- 
2.35.2


