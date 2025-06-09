Return-Path: <netdev+bounces-195634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E546AD18B0
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 08:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED753AA4D6
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 06:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784011C1F22;
	Mon,  9 Jun 2025 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b="i58SufY4"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11022131.outbound.protection.outlook.com [52.101.71.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089CF4431;
	Mon,  9 Jun 2025 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749451636; cv=fail; b=mQ20EAeBn5eR2TnNraQGfEkyFVGxsvfMBOqUYrZrnfXdOPWIaR9khT6KxpsoYFTSFbO2uuTC9fN1eZrJEdZayIAgl2yBTuU0uJ11GxbIySg5wxEchFCoXE0Q8N23vv4GWR5iXt9tqR1EAeNW+MvcQ3FYfjei1isgsVUJXyhFaGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749451636; c=relaxed/simple;
	bh=nEPZZpgLfMBPqMgEPpiA7hZEwoEhtY16TKz+uoeXWeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=utBmx3bsvYcVcTMDEf9fsLYZRqtXqeTL/Ttv6Wn6LrVlgvTAe4Pn9LTQ8n9LsiH/jnmYKLRihQBQwAoSc5RjlpzaS2sd9Up/RbjkhwA79XGMkmU28Aas7afY6Q+1dOV6KaWIRBcBum5RfNA9jOi9m8PmNJ4PT0t7YKkvFLxgMCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=i58SufY4; arc=fail smtp.client-ip=52.101.71.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technica-engineering.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILp7N2tXCr4tAkr4afC8EP0ltzvEPKgq0SopP8w8rqgcbqqLfwtQ0UPpaqlo9Y01vddTI9QQFN7kSsuI3JyhmJtb6bE0WwYsRGrURCcQ2Y0e6rRzzRWbq1DZodCN0o67vQXMzwoRJuETyJtssYLeb08NcBbn1V2+CrKf3KNhImh5Y2bstnlMAFULxvmv//6/HtDnAGb4z+h3vdR6EqmbBHD0Rv0qSyvGtjBUwq1EzBrpI9XkSXBloEK/zzwJygnevQVRRNKCqCO3kUvDIz08AfQHd6deisO4Z2Z4LME78U00pLPsUTN81GO/OjclS10tmPbxkE2zJB6cGz3csLtF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1ke2S2KXth1TCEjEjafbf2BUbRNsXW5NFSkdvSxcIQ=;
 b=X2CE/AEmNu2xv68O3tx4RYruPdb2i4dmFbTqqAexHZrKG7tSHPCqVnq8Yul9cUYV6/XaszTBjPMLcStymq68GEpHKKrGA7g8PkLG58zFtF13Jf4dIyFP0xPUZBpzMDtvL1xxvo9QZdAoclweFUWpFWI+UOeLCvHuWHUQJlnFiyT3+uaYsUlOHDouCbW1WG+7l8CQ781DmTZF5Xm1mQ5Onj1m33sAc4Ays1qQc+VSbSUi0eVRKXpLJjJQsDgdC+Co20w8VRlcQx5nXsTybFq1DMZTWScAFwxXaQvkUJySbahQxmfwTmVPhhC8UIbBu20K7bC1DrPH3SAMuoCcG4/g4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 2.136.200.136) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=technica-engineering.de; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=technica-engineering.de; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1ke2S2KXth1TCEjEjafbf2BUbRNsXW5NFSkdvSxcIQ=;
 b=i58SufY4px25041xofO/0aM6PHDggQClbsxQsOLCMGwQdotzeb+2hAUSKPwGz85kQjSsReJ3QXy7Kad0avqSi2ywmtfORjVVWfFv8llZ0G3W2nUBQbZ/dOgUu5xLaEjGd5JGtf/lFs4pvMFGBV3XiPlaJP+ixrmCh8VuymO8h3E=
Received: from DUZPR01CA0218.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::21) by PAVPR08MB9089.eurprd08.prod.outlook.com
 (2603:10a6:102:322::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Mon, 9 Jun
 2025 06:47:10 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::2d) by DUZPR01CA0218.outlook.office365.com
 (2603:10a6:10:4b4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 06:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 2.136.200.136)
 smtp.mailfrom=technica-engineering.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=technica-engineering.de;
Received-SPF: Fail (protection.outlook.com: domain of technica-engineering.de
 does not designate 2.136.200.136 as permitted sender)
 receiver=protection.outlook.com; client-ip=2.136.200.136;
 helo=jump.ad.technica-electronics.es;
Received: from jump.ad.technica-electronics.es (2.136.200.136) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server id 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 06:47:08
 +0000
Received: from dalek.ad.technica-electronics.es (unknown [10.10.2.101])
	by jump.ad.technica-electronics.es (Postfix) with ESMTP id 7713340263;
	Mon,  9 Jun 2025 08:47:08 +0200 (CEST)
From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
To:
Cc: carlos.fernandez@technica-engineering.de,
	horms@kernel.org,
	Andreu Montiel <Andreu.Montiel@technica-engineering.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4] macsec: MACsec SCI assignment for ES = 0
Date: Mon,  9 Jun 2025 08:47:02 +0200
Message-ID: <20250609064707.773982-1-carlos.fernandez@technica-engineering.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|PAVPR08MB9089:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0a3132bb-68d0-48ab-8893-08dda72174c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?stZIB5lbLO//HTMVl3XrT+GR9F9E04WgW/m4HDpg+P28IXCQ9h3ksZ8lWEiw?=
 =?us-ascii?Q?zmjiAmbGdMfKOFzQs/s5b/GkZArkr3qO1jKoLc3x/osftu7wBNVR9qEYJn1A?=
 =?us-ascii?Q?PIT+HOlRy+nByGzH1mVEH2xbngc/sw9x+Wumm4jt0is2ONvhQEndOyZJFnx+?=
 =?us-ascii?Q?q/wmf+P8Uk/2Od1E1I2Gjb9bbgDO/a9i+sQ0ZSQwRP3SkIc1bhSDIHXPPHFB?=
 =?us-ascii?Q?4qorsVSef4LIlWxe+opiQAT7lSzStwVouNNIcF6gWfPweknLQ0J7CRkxXVCe?=
 =?us-ascii?Q?tGrCVOZl2jLKLfbfSPPjvZkMXX2isK5j2NfiVXI3vslNXrv9yRaS2lMiMGeT?=
 =?us-ascii?Q?ZHjbi+t/jiIt0TUJnhrZWiBQnW/ABjBS2Rq5Qlv9ry8fTP06F0NfmlS63yjf?=
 =?us-ascii?Q?iul6tnmtTx9zQt/1h4ztSdLehqMfEhbNSmUsD4S4AOn2+eDe6pBaEUW/JOyf?=
 =?us-ascii?Q?2rT46W3lCM0jNbo7JhRRcAlacXHsr620teNUw0pFUrzpJpRh7CfCom1JSzI+?=
 =?us-ascii?Q?GhW1oEvI4KAR8VeeoLAbI0g+N5+f4DlbwObqhnpnkL1MUN8ujsnGSYZ9dFTy?=
 =?us-ascii?Q?Y9a9RzHoQ7Y0P24c/PHPTMxlkCPwsyGSLpfDt8qkbWZO417gx8a3sfwxq+Vf?=
 =?us-ascii?Q?xQS31OfqmZj5ZIfN/yvaVZnOHyUVmc34Rg5IjzpZNemBVDMi25b7eUuTzGpk?=
 =?us-ascii?Q?rOsYYfHw149BCle6fXOUtr6Z9dQOYWQP/QybRgy/eBHe6at264QCtAqr9IRB?=
 =?us-ascii?Q?wu8CWW2H/hoxyKXya6BpPijYQbvAveyRj5R9A+mENN5eItxUG6i2GDyifN9U?=
 =?us-ascii?Q?BkaUU95UFrd/bnZMdnZLlktKyAzEj4mNhShLsJNPob/hA1kstK4yeELa90yI?=
 =?us-ascii?Q?uxiwBXtguaKBqMkJg3UZPdlPl8g/KhyOhJuG+yurQYWufWedCME68z1/uWw6?=
 =?us-ascii?Q?m4/lkF+RW/M7JA2iDrIxSnSecUe5R+nptjOXca6QTmmGYrbvNl9cFWfsrbrB?=
 =?us-ascii?Q?zxDp60Z4ufTKFihLHp3qLKzkB7wYqeWEorQEu74TnbInIs+Ddv0pEIZ/Qhnf?=
 =?us-ascii?Q?FSw2k5B5KocQIlKGI2u+VcC1o+e7+OhJfayIvvGkEc6NiT4uFPV+f4Eo0Sky?=
 =?us-ascii?Q?mVnDEW/EnPBX3GAYUhtRhCL4CVeHdPDs9DrUkjyf2tKgaWX0eujr0nvPQUCy?=
 =?us-ascii?Q?bCzOrhJA/zaf0AI9r3esLd+34JQPNJsykXnN0lWSQd+EBXPfg6oxek888taD?=
 =?us-ascii?Q?PDHMLMSC/Q6OyW0CXrQMKJd1PwYFnWp7boxPjiotDRXlPW1lpPk1jqTKneGs?=
 =?us-ascii?Q?DLuUH5CXC99vZksW+PEFOpzzris2a30AG5oB6Or77yZ+0RSEOOilcNZd3Xad?=
 =?us-ascii?Q?bOHKHUxBMpgPRjQNtKBR7AUZ1evpNFTCry1Aw2mnFp/hcD++YyVUDcl1YynO?=
 =?us-ascii?Q?dnZ5JnEx5uesaN1cEKKzqMrQSFOpz3jW6s0yUMMyc0d/mNgQYQaNXBEBo75Z?=
 =?us-ascii?Q?zanKFqvalea3KxtBTlmWTK8Tk3qWQ5q7NwAu?=
X-Forefront-Antispam-Report:
	CIP:2.136.200.136;CTRY:ES;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jump.ad.technica-electronics.es;PTR:136.red-2-136-200.staticip.rima-tde.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 06:47:08.9794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3132bb-68d0-48ab-8893-08dda72174c1
X-MS-Exchange-CrossTenant-Id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1f04372a-6892-44e3-8f58-03845e1a70c1;Ip=[2.136.200.136];Helo=[jump.ad.technica-electronics.es]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9089

According to 802.1AE standard, when ES and SC flags in TCI are zero,
used SCI should be the current active SC_RX. Current code uses the
header MAC address. Without this patch, when ES flag is 0 (using a
bridge or switch), header MAC will not fit the SCI and MACSec frames
will be discarted.

In order to test this issue, MACsec link should be stablished between
two interfaces, setting SC and ES flags to zero and a port identifier
different than one. For example, using ip macsec tools:

ip link add link $ETH0 macsec0 type macsec port 11 send_sci off I
end_station off
ip macsec add macsec0 tx sa 0 pn 2 on key 01 $ETH1_KEY
ip macsec add macsec0 rx port 11 address $ETH1_MAC
ip macsec add macsec0 rx port 11 address $ETH1_MAC sa 0 pn 2 on key 02
ip link set dev macsec0 up

ip link add link $ETH1 macsec1 type macsec port 11 send_sci off I
end_station off
ip macsec add macsec1 tx sa 0 pn 2 on key 01 $ETH0_KEY
ip macsec add macsec1 rx port 11 address $ETH0_MAC
ip macsec add macsec1 rx port 11 address $ETH0_MAC sa 0 pn 2 on key 02
ip link set dev macsec1 up


Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Co-developed-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
Signed-off-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
---
v4: 
* Added testing info in commit as suggested. 

v3: https://patchwork.kernel.org/project/netdevbpf/patch/20250604123407.2795263-1-carlos.fernandez@technica-engineering.de/
* Wrong drop frame afer macsec_frame_sci
* Wrong Fixes tag in message 

v2: https://patchwork.kernel.org/project/netdevbpf/patch/20250604113213.2595524-1-carlos.fernandez@technica-engineering.de/
* Active sci lookup logic in a separate helper.
* Unnecessary loops avoided. 
* Check RXSC is exactly one for lower device.
* Drops frame in case of error.


v1: https://patchwork.kernel.org/project/netdevbpf/patch/20250529124455.2761783-1-carlos.fernandez@technica-engineering.de/


 drivers/net/macsec.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 3d315e30ee47..7edbe76b5455 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -247,15 +247,39 @@ static sci_t make_sci(const u8 *addr, __be16 port)
 	return sci;
 }
 
-static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present)
+static sci_t macsec_active_sci(struct macsec_secy *secy)
 {
-	sci_t sci;
+	struct macsec_rx_sc *rx_sc = rcu_dereference_bh(secy->rx_sc);
+
+	/* Case single RX SC */
+	if (rx_sc && !rcu_dereference_bh(rx_sc->next))
+		return (rx_sc->active) ? rx_sc->sci : 0;
+	/* Case no RX SC or multiple */
+	else
+		return 0;
+}
+
+static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present,
+			      struct macsec_rxh_data *rxd)
+{
+	struct macsec_dev *macsec;
+	sci_t sci = 0;
 
-	if (sci_present)
+	/* SC = 1 */
+	if (sci_present) {
 		memcpy(&sci, hdr->secure_channel_id,
 		       sizeof(hdr->secure_channel_id));
-	else
+	/* SC = 0; ES = 0 */
+	} else if ((!(hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC))) &&
+		   (list_is_singular(&rxd->secys))) {
+		/* Only one SECY should exist on this scenario */
+		macsec = list_first_or_null_rcu(&rxd->secys, struct macsec_dev,
+						secys);
+		if (macsec)
+			return macsec_active_sci(&macsec->secy);
+	} else {
 		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
+	}
 
 	return sci;
 }
@@ -1109,7 +1133,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	struct macsec_rxh_data *rxd;
 	struct macsec_dev *macsec;
 	unsigned int len;
-	sci_t sci;
+	sci_t sci = 0;
 	u32 hdr_pn;
 	bool cbit;
 	struct pcpu_rx_sc_stats *rxsc_stats;
@@ -1156,11 +1180,14 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 
 	macsec_skb_cb(skb)->has_sci = !!(hdr->tci_an & MACSEC_TCI_SC);
 	macsec_skb_cb(skb)->assoc_num = hdr->tci_an & MACSEC_AN_MASK;
-	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci);
 
 	rcu_read_lock();
 	rxd = macsec_data_rcu(skb->dev);
 
+	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci, rxd);
+	if (!sci)
+		goto drop_nosc;
+
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct macsec_rx_sc *sc = find_rx_sc(&macsec->secy, sci);
 
@@ -1283,6 +1310,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	macsec_rxsa_put(rx_sa);
 drop_nosa:
 	macsec_rxsc_put(rx_sc);
+drop_nosc:
 	rcu_read_unlock();
 drop_direct:
 	kfree_skb(skb);
-- 
2.43.0


