Return-Path: <netdev+bounces-194212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D706AC7E1E
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82B51C01C03
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0137D1C860C;
	Thu, 29 May 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b="ByFlisuD"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2138.outbound.protection.outlook.com [40.107.20.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489CA194A65;
	Thu, 29 May 2025 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522717; cv=fail; b=rXcaTXK1jMfTLJpuCBptPDc4Ojm9Bl5d5I6BJDJbofCmySOFQOpvmIl8hrzWJs5JM8Jo/jcTSUAXaZRp7HWQ+560VXBFg0b4Y8hMdWYBXyRXPh7Xz/9Q3HuNoYdcy6oWTp8ShOkHfZls+a8TEfKGOblJMHeUh75j4I2xIdZr2uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522717; c=relaxed/simple;
	bh=OsGyXasEVbE0WwYAv8SlTiGVlyxQLqHh6bHU9ms7aEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ljdpCNjSdpDHm46IqRY+Ee5PDk/VUs+Nlw6HCWFrlHs+f0lPWHeLakEmKq94Z2x0msY7r5acr/5IHF9h34NttHRiXO7rfRbAomOCJ17BIhupKEeRVKG2dBs0d7QywOtvqg/MYAsywrETn+oR0gI9SiwjWxozGE+t/Tp2p1QWKgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=ByFlisuD; arc=fail smtp.client-ip=40.107.20.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technica-engineering.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ditju0a488UGLtHlX1GdB7uygsdAJdBBSUM+Y2CdcOsCOq2gfROgMSm6n19/LpUDYT2+nmUK++yVymwaHrFBeXYygLq+WyB0JOqSBCar+O+uBRWlTSt8e2SeMe2by8+T5WCM8heFI30qu06zo1prV1jv0GbkWYAT1KRskxVt0/1yMe2g9ljvnbrht79WgOs8zF4HyGqnho/iuq1f9BnQIQ6hCQJXNMcVrcPj14sq2zQ4Wity+W5TYVKXtMxakQfQcNGgbkpVEiKN4PhLg0d/omlYZ3SUF0GNoZrihdJNbx5cz48WwtCHZDw+rW+RmpzQPamyBCXK44BNSXzmrqV+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTA3fLQ6zkqAD0yZvFTJo1R9tLUuAoq5zM56jKmsiP8=;
 b=kNk+YMolHcAdS/zPr4rkERI9oIDAVbYO1x78hi+qU0UqExts1ky8HTewLQJPkxaiRKNRppr/4Gb1RXh/uG7mESYuUlfF9ES/fwZCViOq+1FqbIz8Yxq8qLnLCDvl3tJHH5Ug6wJTgmCyHJzbGHxnh71HvwBLDFxqZta6oOcadGB9laYXvQ/QkAUrLC/VFXXh4jPGFF/zfKGAuDFnJ7zMWYYIJkrJFmLcE9fD2qBmgEql27BjS5D+1q1J+YHkMrGubI+UNNmkcuYcYoD6Hxt5u5DtSR1fXKqH8Pho/s03c9mvjSfp77DYTr9pglsAYmaP5ytZhCmwClBneVopNrGgcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 2.136.200.136) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=technica-engineering.de; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=technica-engineering.de; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTA3fLQ6zkqAD0yZvFTJo1R9tLUuAoq5zM56jKmsiP8=;
 b=ByFlisuDK8nHAntKjanb/sewEmVzhP69FtqhVE2Wji8OwRa7UdMn9MaHgxoOvaiferKwV/BGdHupeOdk7BuOMIL6L44PcQbE02ZU1HDwXLMsR0flzGEgIFZ6z5sj4PLYVII1I0SfMxjWxiIaH/nSMgCbpGWF6UutI5Sv3IGiaiA=
Received: from AS9PR04CA0078.eurprd04.prod.outlook.com (2603:10a6:20b:48b::25)
 by PA4PR08MB6093.eurprd08.prod.outlook.com (2603:10a6:102:e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 12:45:12 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b:cafe::42) by AS9PR04CA0078.outlook.office365.com
 (2603:10a6:20b:48b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Thu,
 29 May 2025 12:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 2.136.200.136)
 smtp.mailfrom=technica-engineering.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=technica-engineering.de;
Received-SPF: Fail (protection.outlook.com: domain of technica-engineering.de
 does not designate 2.136.200.136 as permitted sender)
 receiver=protection.outlook.com; client-ip=2.136.200.136;
 helo=jump.ad.technica-electronics.es;
Received: from jump.ad.technica-electronics.es (2.136.200.136) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server id 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025
 12:45:11 +0000
Received: from dalek.ad.technica-electronics.es (unknown [10.10.2.101])
	by jump.ad.technica-electronics.es (Postfix) with ESMTP id 0A04E4019C;
	Thu, 29 May 2025 14:45:11 +0200 (CEST)
From: carlos.fernandez@technica-engineering.de
To: linux-kernel@vger.kernel.org
Cc: carlos.fernandez@technica-engineering.de,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] macsec: MACsec SCI assignment for ES = 0
Date: Thu, 29 May 2025 14:44:42 +0200
Message-ID: <20250529124455.2761783-1-carlos.fernandez@technica-engineering.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A60:EE_|PA4PR08MB6093:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cc947e84-1f53-4256-9787-08dd9eaea6cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/1IAeI76qdZWQ25HZNMOeTkpcWB66yTJ2ug3ONq8dnyb0Ms6jLlnRXEN1eRU?=
 =?us-ascii?Q?ecn6IhFNf1/whAtpd5QsmBRxeV2Kumi6/yGpF7Ud5T7ASVDjuPH0/aJlXOG9?=
 =?us-ascii?Q?kSQhQC2NuC10gJzdgUgUdwwCdQHR8r7hdUDFVT6e0tJHIUpaQOvn1ewgaWk9?=
 =?us-ascii?Q?FpxMM/7b+p8VHRqjcGTuxRXyMzYA3ND7CBCdTYCqtZH1VzzS+qnEUHtTLNjJ?=
 =?us-ascii?Q?9LDxzOZknDpXcASgHrlaoSsOY7w5Q2YnJJaRG/TBUOrS7SXUfxCMd3xnzn+t?=
 =?us-ascii?Q?jPIQmt3Hhxdv7JBfEi49PvgY+zrDS+b4Rg9fjwoxslp2PpDgWTKiizLrFmTi?=
 =?us-ascii?Q?etcARZ1z71+d8gcXEYzOh0d2doCHEYLk141MZmuUfwJm4f1bKCBU3RRr4xHn?=
 =?us-ascii?Q?XMMDDFQF8ttp4Cq2pK06k4Egzqyitq8WqvJEaSYnreOXC5lYTPwe1uQe1dFZ?=
 =?us-ascii?Q?C7luUmyI1pYI2ajvA8LGBuQAqsRR8aaWyGDwoenrZ2dV3o1ZfpXVNdq6+8U+?=
 =?us-ascii?Q?DC7re25+26evysedHyKmCxh/RY4XQIbkzkeMCM1w5DNQzWptCACUWM7ziWbj?=
 =?us-ascii?Q?kpAxnduWChh0ubG4TBsTF8zOyj5PYi45jhVbkkeI2OTVPhRFkgFU2s108gKp?=
 =?us-ascii?Q?z4SIqpm23BFzrmkX9oJ907uAe4EUZ1xup8dKsb/BmKsH0g4e0QlV8apsYQfP?=
 =?us-ascii?Q?tL+AwKfBtZNmbtALG5xjXjAhLnia1VOXmocqhxBHgiBPOFvJB0euIEJjjeY6?=
 =?us-ascii?Q?Ferpsm/nvs6JJhmmA1pLIO+QYLUd3AS7r1/7K6oybVU6F0nDZjZDax627rjb?=
 =?us-ascii?Q?ptVQwzXA6WKms15ESsfkYFg1qd4diIIjRe8y7WTITPIqwNkXmVw6tf7cnxEm?=
 =?us-ascii?Q?KJ90hZWajL19t6VgFGllmkWTnsS6HLQjaN5DZNMvT3Wa5NXFiDeKivgXMDfO?=
 =?us-ascii?Q?y/ONf7DO2prJlW0CRVHVv8bC1szL5dC4v8p0fjvoTadxwxRyspL9KLTrz9ME?=
 =?us-ascii?Q?41cnE6CMEDLPT3aaAlfyNBfJ8JfsAm+mfd+FPnXnkj5J2N5kyXEC5RFKoZeT?=
 =?us-ascii?Q?FC8J3TmeilEjEfacXVIOO7VfhgPiLK2JVZbq8L6ydK+goxq/WVu7nIAyXlgc?=
 =?us-ascii?Q?F693GgUACI2RrSgSS5qIsKHW3rym+jB2H9Gkn6SKkemKUCw5nJm4IwuiXt4w?=
 =?us-ascii?Q?ffhlkjqp44AS19Q4Q29RALRT29xKw33VhoIE54ofBTq1AXksgPF/ohMEJUTb?=
 =?us-ascii?Q?E0utPgU1O7wjG2/tZwKaeAopcScS3lI+w1fGq2kzzBDjSw6AExdWDzoDgA9I?=
 =?us-ascii?Q?NtNMjxS8y9NRf+6/hYXeAeCw7B9M4w+08l+BGP/kUaK+1TTscqqY/M9Bec+3?=
 =?us-ascii?Q?PEjQ4kjV3UoNa8Yr9I7olygUEBesXobjJqLCKR5MnrR6/YdTAUzLlnZrFUnh?=
 =?us-ascii?Q?WGv4akUImGMOpx9Fusb9IAI8e6b28vSkvKgCq7MPgSVoCXJFDl8KZUDCP5aR?=
 =?us-ascii?Q?EgZjojhTVx8ppPjmBsJqeVf3D5yIepXV/CHM?=
X-Forefront-Antispam-Report:
	CIP:2.136.200.136;CTRY:ES;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jump.ad.technica-electronics.es;PTR:136.red-2-136-200.staticip.rima-tde.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:45:11.5199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc947e84-1f53-4256-9787-08dd9eaea6cc
X-MS-Exchange-CrossTenant-Id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1f04372a-6892-44e3-8f58-03845e1a70c1;Ip=[2.136.200.136];Helo=[jump.ad.technica-electronics.es]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6093

From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>

According to 802.1AE standard, when ES and SC flags in TCI are zero, used
SCI should be the current active SC_RX but current code uses the header
MAC address.

Without this patch, when ES flag is 0 (using a bridge or switch), header
MAC will not be equal to the SCI and MACSec frames will be discarted.

Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
---
 drivers/net/macsec.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 3d315e30ee47..9a743aee2cea 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -247,15 +247,29 @@ static sci_t make_sci(const u8 *addr, __be16 port)
 	return sci;
 }
 
-static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present)
+static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present,
+			      struct macsec_rxh_data *rxd)
 {
-	sci_t sci;
+	struct macsec_dev *macsec_device;
+	sci_t sci = 0;
 
-	if (sci_present)
+	if (sci_present) {
 		memcpy(&sci, hdr->secure_channel_id,
 		       sizeof(hdr->secure_channel_id));
-	else
+	} else if (!(hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC))) {
+		list_for_each_entry_rcu(macsec_device, &rxd->secys, secys) {
+			struct macsec_secy *secy = &macsec_device->secy;
+			struct macsec_rx_sc *rx_sc;
+
+			for_each_rxsc(secy, rx_sc) {
+				rx_sc = rx_sc ? macsec_rxsc_get(rx_sc) : NULL;
+				if (rx_sc && rx_sc->active)
+					sci = rx_sc->sci;
+			}
+		}
+	} else {
 		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
+	}
 
 	return sci;
 }
@@ -1156,11 +1170,12 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 
 	macsec_skb_cb(skb)->has_sci = !!(hdr->tci_an & MACSEC_TCI_SC);
 	macsec_skb_cb(skb)->assoc_num = hdr->tci_an & MACSEC_AN_MASK;
-	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci);
 
 	rcu_read_lock();
 	rxd = macsec_data_rcu(skb->dev);
 
+	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci, rxd);
+
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct macsec_rx_sc *sc = find_rx_sc(&macsec->secy, sci);
 
-- 
2.43.0


