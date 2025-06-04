Return-Path: <netdev+bounces-195087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD10ACDE10
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 14:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619573A608D
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B428F52C;
	Wed,  4 Jun 2025 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b="Lwzy8AmT"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023117.outbound.protection.outlook.com [40.107.162.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594828ECF1;
	Wed,  4 Jun 2025 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040458; cv=fail; b=kq60PM/69cT+8wVP5/LMNT/LA+xXn9VJbOTmKB3w/4QfhWFBrP5HWj6ktaaNLSigoYn26ObFMSNovxfLjkD46PA1DqLdipb+cERiGZ/FRg8d0eeGGx1abSAMRaELuJ9jbkZcDdnlaI7WfaHeyfHIJznyM29FOtdyoqzk0yigVr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040458; c=relaxed/simple;
	bh=/zdeBRzQXESFvSukdpEyV6Inv8QSONsFOHxqns46bK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PUjq89aHjO3+AMek0LRsTPi/3VeFZ324UE+TrKS8HSUts088Oz9Z35DPYT7wzOh8s+l/auKvHeeBzSuNuZx2xGeHmOK96gTeSgfpICzlGy1BER9pW1Gr+Qdp/pjPwsSFSEBWhDvF6eINf7FUhqqIIbZIQpyiUjWbkGl+PcJs/kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=Lwzy8AmT; arc=fail smtp.client-ip=40.107.162.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technica-engineering.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfaWMcEFjRBt2gy/Q8pKnjkEtpj/mepGWgeVKxA+IPc+t6GZhQzqkjhwGz/25pUiN/mYcCpRd3LCtEsew+Dw7R7T0iS+dV6DhPBz5YChS1ODyN41Ugn84T124n8GY8CYX4ptYsK1lxRsgd8KAMpFZ106i0oEK5D0MJw2um2nf8CRbOFmdfNwfAxorNze54Xj/IZZhCS+v+pabSkieFkGBJynuTgHqlaz/iKxO33k5wPajrfS7HzpeRNhjoZtDm0dq8ojEVpy/3MMnDgjyv8rgWK83iO9sB1uhq6udRxu5yC8ZgDkR/KXJMQAbVSErl2WqstlOaWMqZBLgbtumrD5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3zTbvcd0itzE+wrkAjTVxk03xkbgKE/Fqu0GZG43dk=;
 b=rkDAN1K741CwPuGC/bLmyhCkc6T9FAY2vcT+oMmQ2m0jl0qcJ/K233YnaJ1EZy5lnmJ7N+La5DbrkA1tDv3nPy21BxFyHzmUvZXlw3Of6WNqG6kc/rgYe6HFHnv54gA1K4Jx1a/e/FUP9ACcYxxgcxP5Qxuy8yIZ+4gNIv7nSTPjwWWOkElsJeso7fb6gZmApUjXrOAOjetQJ2PGhJBY84K+byD+tXhT7EytXEuHaPAos7dEluL1ZtioGYxuWNtEhAufcfKQC7zvByR3KcU0RpBQz4SMgzm+RASz2dGKRT66hRP1577pp2FM9xwJyqjmbFwzxg7P5NJL4ic7m6cqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 2.136.200.136) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=technica-engineering.de; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=technica-engineering.de; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3zTbvcd0itzE+wrkAjTVxk03xkbgKE/Fqu0GZG43dk=;
 b=Lwzy8AmT9gjWR7vl5NaZ2jW0FU/n0pyK2T7Ik8TjvLv6wwj+bD4RPEXBSeWDwrwIHyeJ1e7vebCmx/NC4ipxzZ3v4xB/MxCo93OyE+sojPeVxFbh3inTM9RABQWtKN75d3mwHE4u0RCAejWPP6GB2YsWCS8gJIZGB6oi74o1CPI=
Received: from DU2PR04CA0171.eurprd04.prod.outlook.com (2603:10a6:10:2b0::26)
 by VI0PR08MB10488.eurprd08.prod.outlook.com (2603:10a6:800:203::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 12:34:11 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::b5) by DU2PR04CA0171.outlook.office365.com
 (2603:10a6:10:2b0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Wed,
 4 Jun 2025 12:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 2.136.200.136)
 smtp.mailfrom=technica-engineering.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=technica-engineering.de;
Received-SPF: Fail (protection.outlook.com: domain of technica-engineering.de
 does not designate 2.136.200.136 as permitted sender)
 receiver=protection.outlook.com; client-ip=2.136.200.136;
 helo=jump.ad.technica-electronics.es;
Received: from jump.ad.technica-electronics.es (2.136.200.136) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server id 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 12:34:10
 +0000
Received: from dalek.ad.technica-electronics.es (unknown [10.10.2.101])
	by jump.ad.technica-electronics.es (Postfix) with ESMTP id 00F0440296;
	Wed,  4 Jun 2025 14:34:09 +0200 (CEST)
From: carlos.fernandez@technica-engineering.de
To: andreu.montiel@technica-enginnering.de
Cc: carlos.fernandez@technica-engineering.de,
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
Subject: [PATCH net v3] macsec: MACsec SCI assignment for ES = 0
Date: Wed,  4 Jun 2025 14:33:55 +0200
Message-ID: <20250604123407.2795263-1-carlos.fernandez@technica-engineering.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009526:EE_|VI0PR08MB10488:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 138a6405-bf99-4e21-b99d-08dda3641b42
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ewvWkZC95af5RaTJCIF5TPu+rNvDYF9NG3jAjaNko3OPuOAcrNbEytRQy9cc?=
 =?us-ascii?Q?/3wezNVyhUJh1PJnhJyTR8Zz4O91btkjNUAY7spEWF0fFyYtCGEKp3SW68Vo?=
 =?us-ascii?Q?T5iX8sOUVgrgqTjxpi9cTddCXjHNbl7vveVZyIlGr6+1hTx/TzdGmkuAs2Nm?=
 =?us-ascii?Q?6CT83kj8XQY1/NbGBq6uL5MIKKgPwlvZbZJHGBsqoHnyBJ+MAUpWIYSL5uej?=
 =?us-ascii?Q?nSQB9V+dkJBMkctrPQ08e3PsxMtsC1tUEZmtE39t4cRDl2akNWN+OKw5KPSK?=
 =?us-ascii?Q?HSa7+cI37gdxtROe+sXw1CN7wechW923IBwCelUP2OkxFGOnpXy38Q0TRkT2?=
 =?us-ascii?Q?gKfGrG9ekv+ckkyD4dCrEMn04b0o4O4Q08mjEd2nlkeXcOJyFsra6yenGjyN?=
 =?us-ascii?Q?oyKqqwtxqauq+6kj5FzA/0a/1ZLDfCFUkDCm/Q2MIVKorbM7d1bLbOfx9Lhq?=
 =?us-ascii?Q?mgnDzvH16janjAFKqcb5OBd5EjL52Ze6Z9Uu27j85bnCUU5qsk92Oe4yAtas?=
 =?us-ascii?Q?1pYOcqFpBnJ2J0yKDKLCPP8gpljo/9XfLzTyTsBJWR2lLKuFHOIxhWE3g6aO?=
 =?us-ascii?Q?9D2AFQe0wP1DmgDEF9WKql7XNH8nTrU2OF6jtLyvoeI7XUsngs9hPmzqxBH/?=
 =?us-ascii?Q?ZWX6b8ptO+DxaNEeBJXdNoF/ZbC+DbuAXHBpMmgwI7CAnBCc1bTQXxf/H/LF?=
 =?us-ascii?Q?51ipgWLxOBFbI3826mnqe0gcuUbqYIr8si7eaalzok9DjNDO0FFolZJv2E+5?=
 =?us-ascii?Q?tLiafn0UgznRVYh2AGf1I3luhSQyGw22Niqdwbyy6P8hroSd5v6VrAoZIbCm?=
 =?us-ascii?Q?aOsIeJnsD3xC0KJ0XwiGHz54A3WRcPflrQh86m1IBX9zTV3kePQzROorfuax?=
 =?us-ascii?Q?xLjtNhvsxjD9pldAkuzgzwmNH/NsCE2JpsISKg9qsyzoC+R35fx1tz9hH4T9?=
 =?us-ascii?Q?w4wlt5ubzoMPB0tXuh+Ls1Y4MxBOpSs483yxYRog4XX/mMHXzZ+vJ/MkHlJf?=
 =?us-ascii?Q?jJKtKYmvMlh+cDTDYi+aTwKEfoRFSYoVoL5ryx+rxxsC/9J0iiMC/0kcQruQ?=
 =?us-ascii?Q?GHZ+xwk3BRIMEr20UcQ/FUlvSr8piy/7fpQrkMMwtSENIkXAXUipdXehB/r2?=
 =?us-ascii?Q?mc5Zn4QFXuzIw1lwaV5xBMfLPqv6zCoxvJZvWxguIP+/Fpa4Ip7HJgjE5foQ?=
 =?us-ascii?Q?ZPGpd4D8nNxMxJDu2Yccv+5TFlMrwK0eHxoZ1V/eS/Nb/mSteCKA2d/s0MeS?=
 =?us-ascii?Q?hN2fBxM56IYQYkj01ebC1lpXnKppDyDS6K1QAzAPur/VR8ZnLBxm1rgaDyU9?=
 =?us-ascii?Q?nvgCTN8EBD88rxp9Rpl9RAaNpxcZirXu+5lr48GHW5987cm7geJQ2UtHdp/C?=
 =?us-ascii?Q?aVd6jkhcb84ZEsOmd1TSC8TnRPvZq2q/XjrUNjo7IkTlcoyaPt1HLZBIT0JN?=
 =?us-ascii?Q?G6l7XkVlqPz0zuZY7iENXFqadE0MjhNHojNmlmxYA6by2HMn+hLnE8oXFngk?=
 =?us-ascii?Q?c0Bqc7M/KkNSnbY7j5VBYrIeavo+rUxfNnKd574NxHhDgguKSAAVPfMkoA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:2.136.200.136;CTRY:ES;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jump.ad.technica-electronics.es;PTR:136.red-2-136-200.staticip.rima-tde.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:34:10.4619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 138a6405-bf99-4e21-b99d-08dda3641b42
X-MS-Exchange-CrossTenant-Id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1f04372a-6892-44e3-8f58-03845e1a70c1;Ip=[2.136.200.136];Helo=[jump.ad.technica-electronics.es]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10488

From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>

According to 802.1AE standard, when ES and SC flags in TCI are zero,
used SCI should be the current active SC_RX. Current code uses the
header MAC address. Without this patch, when ES flag is 0 (using a
bridge or switch), header MAC will not fit the SCI and MACSec frames
will be discarted.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Co-developed-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
Signed-off-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
---
v3:
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


