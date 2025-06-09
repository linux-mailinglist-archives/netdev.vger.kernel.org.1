Return-Path: <netdev+bounces-195642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C755AD18F7
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 09:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120D53A36DA
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 07:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9DA1D6DC5;
	Mon,  9 Jun 2025 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b="fnfI6xVW"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11022077.outbound.protection.outlook.com [52.101.71.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA827156F3C;
	Mon,  9 Jun 2025 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749454001; cv=fail; b=hh3wZ2+eLOFpTVITUb1mHQxm8FY0d+QG+zY3W/Jyn21FaUapvn/SCc9rUhIV7aJKG/CGwzPFnWRSqFprqbAiADLD9RIrqAh9MXMEe0h+Z4hogZotvtR9qW8OEBkN0imhn0bQsvwgulijEsBlH40FBCt19mTGRCmuSWA3fFYSv8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749454001; c=relaxed/simple;
	bh=orwQWIFrm3tqGCzTyPyC5AxGmw+yGoIClDAwb+iU3Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WcLn+0WhAgJiuI1ATpKR2xSkfICYd+FB353+QReUkDxWV6/XeBzZnLlHKlRwnNe/H3HlDfWff4AWAeVQITIQxPbPaFUC9dkU3m1Oo3L3lXh3/vTID0B2ZFZ3Y434S7HTrSeBrSSa9tQpexhRd/xHel6+UmnIX2RwfHvrbNK8w24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=fnfI6xVW; arc=fail smtp.client-ip=52.101.71.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technica-engineering.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crTXnzuqh3FfSE3AoXFXVtLW6jb6WI8IZKUlR96I68e2Gd3x1HGnueQzpg3+UEm4Y9Fz1eKnO8j11FENSuuNW4h7oRiMm8pcaaou3dcUHC1bnffxxYAGRAKccGX7w0iwlSe7l21/G5FvbVgGKGdW/e1TQoM4bTlUen/923WtSSZRpy7IQa28fc9IFI21Zzk7Jt3wmkfADGhEnYRnexAdGUNhbWyxxH6C3VslWA7TZAGMLvtXn23aOehZE7bOuVMK49kK4STTyB8HjDb2cRHsrNF5lMWH0SonC/eG2M/eXekTlyN/D6Wt5eKGmhHt4l/RLD9+V3njr8e3tIPuovN1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N8qByr239pYC/7TJckYk+O2PbX39Qc7l1uIgfG1U64=;
 b=RdrTQMz2QpvWi/QgJIWx/vW9Hp9xtYY1UaGLdGir3r2GSdv46AuU+S9Js5gZ9dX3Xj6uA82ZSOxIJjG4Jt4VmZ2dV3lmp7SXr0lRZoBhDRL/4VKAjM9kN1A+ZSPDcwDrrpC0PGRn0VuV52Y/nTmDelyQgq6Zo3iY8/L7Hf3CV7LGI/TEPtvaJponMBKsg34PCm63OGAYh4UwkjDQxBy9c7sKVtuMSYoYRAp3Tr6nTrKPamWwVt+YunYoQIxqb5vFCghTZfC+lbosPRwljZaS/rNdSydb2pp9q2M+2EvjgO0BoMtBjXYy57ADKKD3VeCi3+8nT5cOELC3dVNMHZxWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 2.136.200.136) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=technica-engineering.de; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=technica-engineering.de; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N8qByr239pYC/7TJckYk+O2PbX39Qc7l1uIgfG1U64=;
 b=fnfI6xVWZgazSooblIeAMkRs78nEkflWyvLWK4tCz+THtjbf6f5SAy8QBhLKf/lWIIUMrBchII6Gw3OIT1SKjYJ/Lp2xE11ayAhfXe8IyQu1p++IkF1M7R3JcwXXUYCbOAoL9Zuza8J6ha+fxCd5NKFdqcMQvKxc6yAriYSHrN8=
Received: from AM0PR02CA0197.eurprd02.prod.outlook.com (2603:10a6:20b:28e::34)
 by AS8PR08MB8972.eurprd08.prod.outlook.com (2603:10a6:20b:5b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Mon, 9 Jun
 2025 07:26:34 +0000
Received: from AM3PEPF0000A797.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::95) by AM0PR02CA0197.outlook.office365.com
 (2603:10a6:20b:28e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.33 via Frontend Transport; Mon,
 9 Jun 2025 07:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 2.136.200.136)
 smtp.mailfrom=technica-engineering.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=technica-engineering.de;
Received-SPF: Fail (protection.outlook.com: domain of technica-engineering.de
 does not designate 2.136.200.136 as permitted sender)
 receiver=protection.outlook.com; client-ip=2.136.200.136;
 helo=jump.ad.technica-electronics.es;
Received: from jump.ad.technica-electronics.es (2.136.200.136) by
 AM3PEPF0000A797.mail.protection.outlook.com (10.167.16.102) with Microsoft
 SMTP Server id 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 07:26:33
 +0000
Received: from dalek.ad.technica-electronics.es (unknown [10.10.2.101])
	by jump.ad.technica-electronics.es (Postfix) with ESMTP id 05A2640220;
	Mon,  9 Jun 2025 09:26:33 +0200 (CEST)
From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
To:
Cc: carlos.fernandez@technica-engineering.de,
	sbhatta@marvell.com,
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
Subject: [PATCH net v5] macsec: MACsec SCI assignment for ES = 0
Date: Mon,  9 Jun 2025 09:26:26 +0200
Message-ID: <20250609072630.913017-1-carlos.fernandez@technica-engineering.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A797:EE_|AS8PR08MB8972:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 165ea880-3369-4332-9338-08dda726f612
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYF0Ob7VK0D2HuE6fo0ONMwnOoQPlzMVGrVb0Mv5/92S1gFv61kDtRg5OeFU?=
 =?us-ascii?Q?oM2/1Xex7/GlEBPo6+UPu+O6Y96N2YQOSin5ArC1/dxr8Y85+iBMOvFySrWW?=
 =?us-ascii?Q?7SjwHo4BBgNsC2FwNKq7yIzLa8FOTjdJEuHqV7PtrcTaZrppnFwIDfZCL1Vh?=
 =?us-ascii?Q?I4Z7LyI1/OjcOK0YxnoKjmoCgRnZUJ25wg0mSs0EFr6Lm4YByYPmlyrELnZq?=
 =?us-ascii?Q?UuZb76VQoBZFVjT8KC3a+jG0o5KdeQAoWTjwIu5QgZinotbnluLQk6Y3Dgjn?=
 =?us-ascii?Q?xtUrfpH7PE1K1Mta/pd9raQSR/h0CnbYUifhyqKfguroPY3RXDuyoqrkGXRR?=
 =?us-ascii?Q?kWHslo6q1AMI/DssAhW394ogwIXygTnBuH3uIKOyKXQ6ggejRnlBNgGZgghn?=
 =?us-ascii?Q?NbbTOA1SAOu8yIICDUXNUdkq9+7x8j1norKN1VgO/sWXqkMkARldlcKcMe5W?=
 =?us-ascii?Q?swLtVezwPT0LZ7k6wW8BgRb6PkNI6BZRaHCx0TYLH2cUxD9ELiAF6gLLgPeF?=
 =?us-ascii?Q?gZha+iKAHgEARysJJkD5oiGQda+Ez3c6VRF3Qzh/6h/RCJdUtz/3zXzzrkek?=
 =?us-ascii?Q?7q+MYp25X8db4JCKxnjIhNsPWyGHY5exg72La9SWdBmnQs8aB02ORg9rNZs9?=
 =?us-ascii?Q?dHRNvVnczC60zlKgbW3IlJptKyuo6uxXo5O6pVa1MOSAsyaD568ELY82Rolg?=
 =?us-ascii?Q?aefsK+EYnkzQfm1408PwQZKOnlF1YICM6p2VFnJu1xeRQuSKilYEsrDJMmbt?=
 =?us-ascii?Q?7SYAeVNOci7Gd/8fyZZLh0EDnuxkSWlwVKm/jpfCgtbhonmiiKlMTY7/ucG5?=
 =?us-ascii?Q?jooKjGCl3R4TzU2hS/r55CgnfBMS+F17OZ3GqpWUxRqo50GqyjQIO5L82w1/?=
 =?us-ascii?Q?J+p5FhX2vKpDThXkG7V8Jt/yfXftEOMMHi+ll07bXfbUAtc0dltVmpzyNXA8?=
 =?us-ascii?Q?Wtjxkct8763qzeishW9/OP+fuyVjGvQX7kR9zwmK5FMcD7Ae6bnf+mfwcOH5?=
 =?us-ascii?Q?FeQGRcCIq8oeCyYRDbraUHUrGzGgOSFGU9Coq8qVISOQcYJOZe8GG0RxaAHO?=
 =?us-ascii?Q?Ra4fMUjVJenCeJ8YGX6nkhONfT8RHLkX82xbnjn+5xzRJqG2CO3fstW7Kv4K?=
 =?us-ascii?Q?2JqYaXvJA88RXRH2WSM+EA1gjAYcXpFcF4iwtJUQmdtdAAEwgXEkvYvXr4A+?=
 =?us-ascii?Q?QyhgyYMOuU+c/EdyjRS+pgT+5t8rKSv2GlRyX1LeTfBl7GGhawJ5c/SyFdU5?=
 =?us-ascii?Q?NdgyyRel/vUNaCCxxpbYP7aDmdxyUM8jC+bep6zU1KNzGJsvwxTW7g2EWDQf?=
 =?us-ascii?Q?VNVY+h28Z+mWlhXcdMEbSNcIKuTZE092JeG5OSUgBFpeNKhpMC8cUG+LZ6V9?=
 =?us-ascii?Q?6mGfUqa4sA/SQNavQbcGnrfYBWdxRdjRsmVWJQfPqIKeugQ1+e+1TDWaWztK?=
 =?us-ascii?Q?rKhkRjeYYVV3rk2hAgTlun5H1SAOFXT4J0jRS0CJNAJwH+IksTl6Dpggq3Ic?=
 =?us-ascii?Q?3weQF/u3ejHxR24l16CZsba7ieDqgZGz0AtJskTEPDsOHtxyKp/2Vvoe4w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:2.136.200.136;CTRY:ES;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jump.ad.technica-electronics.es;PTR:136.red-2-136-200.staticip.rima-tde.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:26:33.4324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 165ea880-3369-4332-9338-08dda726f612
X-MS-Exchange-CrossTenant-Id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1f04372a-6892-44e3-8f58-03845e1a70c1;Ip=[2.136.200.136];Helo=[jump.ad.technica-electronics.es]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8972

According to 802.1AE standard, when ES and SC flags in TCI are zero,
used SCI should be the current active SC_RX. Current code uses the
header MAC address. Without this patch, when ES flag is 0 (using a
bridge or switch), header MAC will not fit the SCI and MACSec frames
will be discarted.

In order to test this issue, MACsec link should be stablished between
two interfaces, setting SC and ES flags to zero and a port identifier
different than one. For example, using ip macsec tools:

ip link add link $ETH0 macsec0 type macsec port 11 send_sci off
end_station off
ip macsec add macsec0 tx sa 0 pn 2 on key 01 $ETH1_KEY
ip macsec add macsec0 rx port 11 address $ETH1_MAC
ip macsec add macsec0 rx port 11 address $ETH1_MAC sa 0 pn 2 on key 02
ip link set dev macsec0 up

ip link add link $ETH1 macsec1 type macsec port 11 send_sci off
end_station off
ip macsec add macsec1 tx sa 0 pn 2 on key 01 $ETH0_KEY
ip macsec add macsec1 rx port 11 address $ETH0_MAC
ip macsec add macsec1 rx port 11 address $ETH0_MAC sa 0 pn 2 on key 02
ip link set dev macsec1 up


Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Co-developed-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
Signed-off-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v5: 
* Corrected typo in commit.
* Added Reviewed-by.

v4: https://patchwork.kernel.org/project/netdevbpf/patch/20250609064707.773982-1-carlos.fernandez@technica-engineering.de/
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


