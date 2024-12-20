Return-Path: <netdev+bounces-153820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14C9F9C78
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0441B189034B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60A0227B8C;
	Fri, 20 Dec 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="RbBP63bH"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14141227567
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734731555; cv=none; b=Oc4YAq3DQt0vti4qY3/GaEfJOFqBuzbb2g4AhbCNndiiskQbMDB8xMyowMKS8Ztsklvsh4V3nuNUYMPJ1xC8TW/KhDn6bqGDwpLAI/g6fBOsEYc3yy8+UC3ij1YCKEcAeBw8eM8QcCcb3ymPia9+ECUe1JNQesay6ZFSu1YvLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734731555; c=relaxed/simple;
	bh=QzqODc2yYFu5IqkEV2LuefBllbBxuQeUrTCk6sDnI/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3t09rYnsOuaAe8hPTclFhUHSEZRAUdw8/1zByMbeS1d3VScG9pNHPFc3Gw3EvNXzhfRmDloZb7U0K4CN9GgRm2lv5X00+MVSnejVM0GCEZKpKJy3hrUZyP/7EawLJb+4xCn7/YQV/z3IsTp4vnrPArBGEEJhTJPE4YK+awiZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=RbBP63bH; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2543; q=dns/txt; s=iport;
  t=1734731554; x=1735941154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lnjinSy/aS7zRu5fiK4HVq2lup4kqm6HcWbCh/R+te4=;
  b=RbBP63bHILpHylBIDVDLilFShGPa5Alp8Kfd4YcUSwuV3JD/tiovd7Rw
   F3fdj23HCFWFVhiU7Xm+vBV6gcLzrGkDu90GQydor1TDZwN48v3bp3Jy7
   /Jry0L0kTagvk2oR5DaG4sRY58W7vMmdfTHbN2UGpIX2BSE3gexA97Gl4
   Y=;
X-CSE-ConnectionGUID: zcwFNjLzSkKwyHd3AhHGsQ==
X-CSE-MsgGUID: 9mDQr/r5RC6Tsw4ku2HNrw==
X-IPAS-Result: =?us-ascii?q?A0ATAADu5WVnj47/Ja1aHQEBAQEJARIBBQUBgX8IAQsBh?=
 =?us-ascii?q?BlDSIxyX6cNFIERA1YPAQEBD0QEAQGFBwKKbAImNAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBBQEBAQIBBwUUAQEBAQEBOQVJhgiGWwIBAycLATQSEFErK?=
 =?us-ascii?q?wcSgwGCZQOwKYF5M4EB3jOBbYFIAYVqh19whHcnG4FJRIJQgT5vhCpmhXcEi?=
 =?us-ascii?q?ReeTkiBIQNZLAFVEw0KCwcFgTk6AyIMCwwLFBwVAoEegQEBFAYVBIELRT2CS?=
 =?us-ascii?q?mlJNwINAjaCICRYgk2FGIRhhFeCSVWCfIIXfIEdgXFAAwsYDUgRLDcGDhsGP?=
 =?us-ascii?q?m4HnFBGg28BgQ58pzKhA4QkgWOfYxozqlKYeyKjOmmEZoFnOoFbMxoIGxWDI?=
 =?us-ascii?q?lIZD44qAw0JunolMjwCBwsBAQMJkSsBAQ?=
IronPort-Data: A9a23:fxo1IKjBfBUsqBVEKed+4hPuX161hBAKZh0ujC45NGQN5FlHY01je
 htvWzuOOP+KamunetgjO4/jo0xTsJCEyIVqTAps/n83ECxjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSFULOZ82QsaD5Nsfjb8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUK8flZJ2Nq5
 8cbCy8cThzYruKW76mCH7wEasQLdKEHPasFsX1miDWcBvE8TNWbHuPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZg1/5JEWxI9EglH9dD1epFuRqII84nPYy0p6172F3N/9JoTaFJ0OwBrEz
 o7A1zX8LigAc8bC8xHbzmmz2uzSxwPdQp1HQdVU8dYx3QXMnTZMYPEMbnO3qOe0j2ayUsxSL
 kgT9DZoq6UunGSmQsT4Vg+1vFaLuRkTX9cWGOo/gCmO16DdywWUHG4JSnhGctNOnMYwSSYny
 RyPks/lCCJHtKCTTzSW9t+8tTq4NC4UBXUPaS8NUU0O5NyLiIc+kh7CUP59H6OvyN74Azf9x
 3aNtidWulkIpdQA26P++RXMhCih48CUCAU0/Q7QGGmi62uVebJJeaS64kf1y/RkPr2abUaQn
 HRfssi+w/s3WMTleDO2fM0BG7Sg5vCgOTLagEJyE5RJy9hL0yD5FWy3yG8nTHqFIvo5lSnVj
 Fg/UD69BaO/3lP3NMebgKroV6zGKJQM8/y+C5g4ifIVOfBMmPevpn0GWKJp9zmFfLIQua8+I
 4yHVs2nEGwXD69qpBLvGLxBj+RwnH1gnz+LLXwe8/hB+efBDJJyYepVWGZikshjtstoXS2Mq
 Y4EbZPSo/mheLCgP3WHmWLsEbz6BSNmXc+t8ZM/mh+rKQt9E2ZpEO7K3b4kYMRkma8T/tokD
 VnjMnK0PGHX3CWdQS3TMygLQOq2Df5X8ylhVQRyZgnA5pTWSdr0hEvpX8dsJeF/nAGipNYoJ
 8Q4lzKoWK0SGm2bqm1HMfEQbuVKLXyWuO5HBAL9CBBXQnKqb1WhFgPMFuc3yBQzMw==
IronPort-HdrOrdr: A9a23:/Y5yyKNBT+w6AMBcTsajsMiBIKoaSvp037Dk7S9MoHtuA6ulfq
 +V/cjzuSWYtN9VYgBDpTniAtjlfZqjz/5ICOAqVN/INjUO+lHYSb2KhrGN/9SPIUHDH5ZmpM
 Rdm2wUMqyIMbC85vyKhjWFLw==
X-Talos-CUID: 9a23:jVw2126gSEzyeHwLOtss5kULNOYnVm/mz1TPMm+0Uk9paJKOcArF
X-Talos-MUID: 9a23:0ocZ/wU7HYCgcKrq/G7pqAh4c9012Y/wNFsSzZYb4emiLzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,251,1728950400"; 
   d="scan'208";a="408903644"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 20 Dec 2024 21:51:25 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTP id 99E971800022C;
	Fri, 20 Dec 2024 21:51:25 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 75B2420F2003; Fri, 20 Dec 2024 13:51:25 -0800 (PST)
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
Subject: [PATCH net-next 5/5] enic: Obtain the Link speed only after the link comes up
Date: Fri, 20 Dec 2024 13:50:58 -0800
Message-Id: <20241220215058.11118-6-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241220215058.11118-1-johndale@cisco.com>
References: <20241220215058.11118-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-05.cisco.com

The link speed that is used to index the table of minimum RX adaptive
coalescing values is incorrect because the link speed was being checked
before the link was up. Change the adaptive RX coalescing setup function
to run after the Link comes up.

There could be a minor bandwidth impact when adaptive interrupts were
enabled. The low end of the adaptive interrupt range was being set to 0
for all packets instead of 3us for packets less the 1000 bytes and 6us
for larger packet for link speeds greater

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 5bfd89749237..7c2bfe4b7997 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -84,6 +84,8 @@ MODULE_AUTHOR("Scott Feldman <scofeldm@cisco.com>");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, enic_id_table);
 
+static void enic_set_rx_coal_setting(struct enic *enic);
+
 #define ENIC_MAX_COALESCE_TIMERS		10
 /*  Interrupt moderation table, which will be used to decide the
  *  coalescing timer values
@@ -109,7 +111,7 @@ static struct enic_intr_mod_table mod_table[ENIC_MAX_COALESCE_TIMERS + 1] = {
 static struct enic_intr_mod_range mod_range[ENIC_MAX_LINK_SPEEDS] = {
 	{0,  0}, /* 0  - 4  Gbps */
 	{0,  3}, /* 4  - 10 Gbps */
-	{3,  6}, /* 10 - 40 Gbps */
+	{3,  6}, /* 10+ Gbps */
 };
 
 static void enic_init_affinity_hint(struct enic *enic)
@@ -436,6 +438,7 @@ static void enic_link_check(struct enic *enic)
 	if (link_status && !carrier_ok) {
 		netdev_info(enic->netdev, "Link UP\n");
 		netif_carrier_on(enic->netdev);
+		enic_set_rx_coal_setting(enic);
 	} else if (!link_status && carrier_ok) {
 		netdev_info(enic->netdev, "Link DOWN\n");
 		netif_carrier_off(enic->netdev);
@@ -3016,7 +3019,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	timer_setup(&enic->notify_timer, enic_notify_timer, 0);
 
 	enic_rfs_flw_tbl_init(enic);
-	enic_set_rx_coal_setting(enic);
 	INIT_WORK(&enic->reset, enic_reset);
 	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
-- 
2.35.2


