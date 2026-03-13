Return-Path: <netdev+bounces-267360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG9YK2Xds2ktcQAAu9opvQ
	(envelope-from <netdev+bounces-267360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:48:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1D5280BEA
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5B35322B5C9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E538838B;
	Fri, 13 Mar 2026 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jCsHD4T2"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05738838E;
	Fri, 13 Mar 2026 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395110; cv=fail; b=tZajZPZntk9y19SW+cKzK/fdr23OBY/k4t4HVPvN/dzfr6W5qm5GhQte9toxVgTddGOOMMubu9o6gHpr/meI6C93BTcNbvf02xK3IX2WJEtd/E4nZPrYAjNtrMypurP0/3kLrUVMR43o8HnQ0WDmL8V0OfQnayycYx/nBaASZpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395110; c=relaxed/simple;
	bh=c6cUlDRGIyz5IarCUQH0tIk7Qh6J+mKL9Dw7rsfTfBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHqxZR92utzF1yHjQk50tgyMAM9neaZ4HT92dGKHaq36T6UAWeSygdRo3zipm5xG0bmVwTinFxENQgq+jxT95o2ZTN0CQQrzn64JKZhUcgh/NRhdEJnss+hdLmULNiHk4mw7//t2Vow5A7rARCJ6inPsExxbyG31d8cFp3rDD60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jCsHD4T2; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xl18djilMIfioI+BnsbdzbDWU2/Vvt1frOghDoeqpG5RgkXrqWJmn/k/NSswEoJ2Pcd3qI+iXid0vDOZq0MPo1cpt+G6zU9cJ8McQX3aQMna8FWgDWRmjTN3ej9O3jUJKbOzW5Rl33fOnKsREiHOGvXvXahCbGh4JSywLP7EMZy7+Vntl84hluY2ke3BC4W67oPekQQWUWZcc14gagrbGeX+ArMEoqf0AccUI72YDWvr6Pwh+e+pPHfhrNpo6/G+MtgqrsGmxyvC4UNwvre6lz2Q0Hsxt0DUd+vsFWBRjoxNkdPbq7KzX5wtwBqBfbMyASeo43VvbhuM6geQa2zXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wb0kfjedRu93v0vFcwo+17JWk4kxjkg+KYYkI0kaY8=;
 b=GA8lcgs3A/YWJ/9xpa+b8Un4BTf+UPS7S54aXACJIQjPFmEoMa5d26RCuPRKuNpk5UwLJi85NYMN8HkLjQx0oGWU/j8LlEM3VXkz2MPBoxno3DaVKXlqvLQjoybmvlTK6NtlPKkxKSw/HRIHjmzWpju1CpP0sP/P2ZnOZJh69O1EgAMxhcdJCfzmSbEkZep0dkA3DtFQh6bLFRYlTyhmC5Egoxe8mn/daHLl7OlrCYqwCRAOS0RTyOgCVL+4qJFpbVUh6AoBRQt9ffhUpCcgU3Y8fSGHHwkzpdMZTVoVDHIBGWXk+iVVhi40aV6pAKKw94trQBJZWqISPvqa1mJnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wb0kfjedRu93v0vFcwo+17JWk4kxjkg+KYYkI0kaY8=;
 b=jCsHD4T2vASa2PaYdTak0lBOS1ky7S9vy87eO8vrMngzT9enaRkeYEFptYNSmLRiyjdBnor3ZBWEIZcY28S4ctig1bZveS5vEvhSkbWfmGAb+4iOUKQgt3c2Ii9BW2NzKrgXov6dOuKYOUUFp4jVx+uPreiROiTXIXBBBKXtSOPiI5NfP7ndicgZY3u76f9MTruDk5bYreTAuW5AUGT7nU4s5qq4lqDcm1I5+Qx8LOJXVXpT4kO4lcrEVYIXie/R+KoY9ZDG3bJFYo5NhrYhLxY54HcpovZ2nIGAXLDeDpRnuTMFMsHqw0AqY1KPLP4VR2JM+WiXP4yfiKuCg6kPCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB9100.eurprd04.prod.outlook.com (2603:10a6:10:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Fri, 13 Mar
 2026 09:45:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.013; Fri, 13 Mar 2026
 09:45:05 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com,
	horms@kernel.org,
	saikrishnag@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net 3/3] net: enetc: do not access non-existent registers on pseudo MAC
Date: Fri, 13 Mar 2026 17:46:44 +0800
Message-Id: <20260313094644.1132411-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313094644.1132411-1-wei.fang@nxp.com>
References: <20260313094644.1132411-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f47803f-a8f6-4513-9080-08de80e53502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xWOyywGfalRdRl9enIMCG5cOhi/Sp2t1pba0FRb8rIsgG2uScchQ6gzgtdkzSCEaGrpNcer8Yj9DbTE0DWNYEFkWT7P7DfPQPnBXepMoQmHrXeX8BFsopiJ72HHgtsTyzoJGapkcZRwoexCSYdupmmxyXCoz9ZmEzwFLN/9JUOcpCg9jwSTkNss5YEI30DaxTcTpliyw882zLwBLHNHKFW+2Q1MsU1QhblMtDV1KMPLT6fRmKXIz3SbFaXK+oqEIuOhVU8JS2JsFhYX38XRy2iT3mYTCwrikey9jWQqgNKJrt7swKKqdOwMAHR4tSpJePwYyQSrqHv0EGZJfm2rBjEa4PLsRca2GmWQI9lgp3dYxvMFOgIKpwDx6qDlp1SscHOXiFQjsf9CC3Q0Shsgimi1Q8icPOzVTGLyEJF7urVg33N5e0TFTN1ebeOyAul3viTuC23qjA/mZnp5+pEaYOrwnUNRYJ9z5XUOnLYqSi8VDjBlRSAYbQlBckHIb8TT4o4EisoZc9zXXpclnh1n6Ct3eq8JKTgs0TX2KBJ/5QoWRN8Mhs/MsvXKPUx4+gyp0uz+AZlkCOG8hXg5loEVFOyRZ9JBym5PTbtSEspsD86kLwKbNJ5EoObylWUcpLXdq46O4w56pVI77GbaP2ycxV7AKExFLbwOeqqJm6DCHRlSpQEcOCRpfT9mR8B3eKr+kDiBoh6dsPzgshpqzlu6oKmGDA9QyYkifukeiQUXMK2H8IDGedixbpbiB6aLfTJIPNcy5xpoFvbLJ7t679jYXcGCwZFQuHEnq367tb7Lh76jM5esivqdiRfA+zQk3Crt8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r5M7opzv4Jqf85Jm1xzwwc35FdxBBqOXhS/nZmzNSD5GIHsfXjcbLWBMjOrY?=
 =?us-ascii?Q?w4+XR/kqSybRGzCJwvIW9FI9S25Rv0oI8gK7pfn9hMQvFrylwIzMTVm4vnG2?=
 =?us-ascii?Q?2c7gkfgtISwYoO1GopWiXUAYQv5WjyY3anP0U7g65w4vLCKtJA6rFzzhWXey?=
 =?us-ascii?Q?a9vvEXz/yZTYWS2kn/BomyIBRLUs34f0fBgfmLFrGELB4f9sXxY2TvXVjqKp?=
 =?us-ascii?Q?aIKAjcq6Swzew7M4Euup+dl6y5RfrZUrYpVB2IKbke9qrP3WnYDu/Y0YXIkD?=
 =?us-ascii?Q?nNwRm9mr+osgWypUWDXpeGnb1DUbnjuaFGW07gPwaT26JYo0CKLLnvl0yF1M?=
 =?us-ascii?Q?Acic/pmh1/uHMNEiMgGV2ANWfH5VK55U9JEiC2uV2zjfIFPTHe/f6n21dkk/?=
 =?us-ascii?Q?FfOL0xGNpQGa6D56yKdU1+NlhCRQl/NmgiBHk41RiNlyMTzgI7ri30Ab3RIz?=
 =?us-ascii?Q?72zDJ3K2S1n2s/qqzGAFmGEV8LM9bopDCSLaXr4PxjaOJ1q558YnW+MuqXGW?=
 =?us-ascii?Q?PZ4wws6JyD1jkycezhEgaAwjOnVMjoj3FD9t0fj8pXiR0llLkWaPRrQstQfk?=
 =?us-ascii?Q?0UZNyDopH1AamxZtI3rSC/5Z4FOR1U3isNP1qKRtOllBOl11Rv/2j6jhlA4J?=
 =?us-ascii?Q?fF7/g7/UBvV4gFzNzOnFaGpDLVcpKhMhfyqrPCIoxTgorfSrY1h8jfgzU2wC?=
 =?us-ascii?Q?4whB9rZHixIZQNVzG9sd3KQNNHhl0ZRYFOkuPxrTLeVpCUR+rgaCTOK3wPh7?=
 =?us-ascii?Q?g6ii7445cRZFYSEM1xqZD4s8deWb8Q/P+EP0cqkh982RD/yIgGIhMjIxQFuw?=
 =?us-ascii?Q?tf+173T7UDqRDGI7QWNIz56Zd7+s7nXq30HVbtA5YEI/CWTc/Bc66ymElSlj?=
 =?us-ascii?Q?TPkmqYIlQLCK6Ql57ZEd9/0w18puMCoCGhb5SDcwWUscvIYnmtlt2z8FjKeb?=
 =?us-ascii?Q?t4Gn08IT5Dwc3zkEddeyJzwTmgvOzhkVA0ls66bXeV30JFI4RMWGkdJ9jJe6?=
 =?us-ascii?Q?pTAcxcEuyPcoqVv4HnSKUG3JOMmnbczvxnyDfcAQ37GVT+pKHd3tyBM59GJq?=
 =?us-ascii?Q?VZBUzShqNdtumEu1kwRQDTodnSAiypzX/45q3i23dRL5zKKJeOd2nUVII0zk?=
 =?us-ascii?Q?iTPBPHjPJ2rWDGR1hiygSsGTAWzK3nRmD1cy65adQAS6QYaFCkeSKgjq0oos?=
 =?us-ascii?Q?GuPlpwmWucz5adi6gwrDIQdHogHFVpG64e79LU+nfrx0/c+ALWkp8UnsAk3V?=
 =?us-ascii?Q?rJBTzEcv5hSfy/54PAayVcwCa+r5IW+HI2gL+WYGcKPpiVOn4HhM8U2u8Y53?=
 =?us-ascii?Q?OPtktWzmVnMRmiKkwJRqW1kXZdn9UcJUsWnpJuf8mKkNtc2jZ84MEuPRA0e2?=
 =?us-ascii?Q?fv/nSt6NjY1vtYGqP8rPxif5dUhtc8aXURJdnev//5zo0ejNsu8Qii2IEDAY?=
 =?us-ascii?Q?90cXWKisvGab/3OLrhNbeTuqq/SORFJQpjjs8P0k8hcwaIv+Rmq8MW1c+CwX?=
 =?us-ascii?Q?H/h9NHC2cy0fllP2M1opzPHqYMTqK9DrvpRBN1B+J6GKdoKmkh9e8B5rRz1K?=
 =?us-ascii?Q?vPeiT6HfW/CCBi1FavjR4/yhm4nw3hF5/L+uSvXZGZCogE9qL2ru05gM+szA?=
 =?us-ascii?Q?TwW+LXwXNuI/wkiViXj5n6FcUbzyJXPFv0SLQ91zAzTFM98coiuNnuN14BXd?=
 =?us-ascii?Q?6SLzIJEkQor8b8vq2LCGDuAq2o27jSogI+YNZuuO4Hbet7Oc3OuUxyIJCos8?=
 =?us-ascii?Q?g4n5ir4cfA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f47803f-a8f6-4513-9080-08de80e53502
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 09:45:05.9304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nun4xeHQG6KBO9Ecy5w/kd9yuwzeEXNcvIJTlCBxruw5iCuGdlCXEEA2ktXC4UzFmq66GUGJpBL+g9aZKIWnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9100
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267360-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 1B1D5280BEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ENETC4_PM_IEVENT and ENETC4_PM_CMD_CFG registers do not exist on the
ENETC pseudo MAC, so the driver should prevent from accessing them.

Fixes: 5175c1e4adca ("net: enetc: add basic support for the ENETC with pseudo MAC for i.MX94")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
Note that the commit 5175c1e4adca ("net: enetc: add basic support for
the ENETC with pseudo MAC for i.MX94") does not have such issue, this
patch depends on the patch 2 in this patch set.
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 53cecbb23a97..56899f2254aa 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -814,6 +814,9 @@ static void enetc4_mac_tx_graceful_stop(struct enetc_pf *pf)
 	val |= POR_TXDIS;
 	enetc_port_wr(hw, ENETC4_POR, val);
 
+	if (enetc_is_pseudo_mac(si))
+		return;
+
 	enetc4_mac_wait_tx_empty(si, 0);
 	if (si->hw_features & ENETC_SI_F_QBU)
 		enetc4_mac_wait_tx_empty(si, 1);
@@ -856,6 +859,9 @@ static void enetc4_mac_rx_graceful_stop(struct enetc_pf *pf)
 	struct enetc_si *si = pf->si;
 	u32 val;
 
+	if (enetc_is_pseudo_mac(si))
+		goto check_rx_busy;
+
 	if (si->hw_features & ENETC_SI_F_QBU) {
 		val = enetc_port_rd(hw, ENETC4_PM_CMD_CFG(1));
 		val &= ~PM_CMD_CFG_RX_EN;
@@ -868,6 +874,7 @@ static void enetc4_mac_rx_graceful_stop(struct enetc_pf *pf)
 	enetc_port_wr(hw, ENETC4_PM_CMD_CFG(0), val);
 	enetc4_mac_wait_rx_empty(si, 0);
 
+check_rx_busy:
 	if (read_poll_timeout(enetc_port_rd, val,
 			      !(val & PSR_RX_BUSY),
 			      100, 10000, false, hw,
-- 
2.34.1


