Return-Path: <netdev+bounces-139463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D849B2AFD
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E59B21ED2
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDAB192D70;
	Mon, 28 Oct 2024 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vpm95E5F"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F60192B7A;
	Mon, 28 Oct 2024 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106491; cv=fail; b=uR3RP90VgzCiUwvRZqvvqhOnm5I6xmDbvIDftZR9WrTQA3jjrzV62gGjJiM0ZfFVQeVVI4nZombNmR9A83BmAmEnyiVk6dPktpOOdEEXzJaxp2f6MpDxyGDRFP4mlOyvCeWqpevYXwXYWm3ApyoK4dhzuF4sebDaFweh1jvRUbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106491; c=relaxed/simple;
	bh=5GgFHuwb4sJqRpXWbsAUqxri0laIKklNEQrJaVvGiv8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TP0p9uJIDYfXYh/ze6k1IE+ChZrXrUwKBcLEtgslKwmdEQ7sAycB0mkkJcK3x32HU+L6QH6zhxtpQhkYmFUiclv/CKsuOyCVLH+GUMREcXvg8rSc6tXL/O2If+7+eOtw0hxIpMbYWI9MjkfbIhlvNbxYCVzVMc5R2Vq7s1ip2sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vpm95E5F; arc=fail smtp.client-ip=40.107.103.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP2MZc7M6Qa64TNTO5+hQUltK3rDVcusqxPaJauDqasLUZD96on0rbqh13TR3LzY+1N5Yu9C6fDiZAeu8G9rnwkGojX57R3xg77mGoRqdAZAeubjhHcT1Yo3oOAeSpi+T4WEzQNDaRcHNX1fwSgQ07wFuZFGCkSy47OZpHRhNhsf8TghdqlKumgU9wKEv+76CU3cUgYYuW2P3VSQxyrFgD1eoVsSZXtXezCHJ2HG40i1FRmdHN5UfBnYNasOnqWN17CBMzldsoFPqnepvNaRoaBQqbVIHfNqDoj13Abr9HjujPGe3gAznXfBz7iPeusUqU7OC9AWiwreMsZZebOhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk6ThNSqKzj6ZB65rHIlgg/MRlXL3XwHS/Owh8MvgcA=;
 b=gsJTjKQJABD9Gn+jQaEXRsfNT1GFO2wZWHsE7MG1bVSmh8RBp53IDGXJ8aHMlfzy70N3fbWzcgfGdjgFTNScxL7/0Vrjn79L05vkHJWhhdZRpX8qg9EJt20CWx7KT38Nil5T81JiFGEfqJ+K7d0/u4dlaiKZgs1qdCVURjMBivjbZyN5/XNoal/n2UNUuzIP72TYVFDYchyl9GC92TgGgFeXctthh4yPJvC16o/QU6l9DJ688LfILcCcJmE3pnYoXBDcdfRvI3yVAZuOVT/rCRXABHn1ZWGAclZSCoe2RbKG1VZAbL04F2kbf+STmsghzol++lPFiKJa4Y/Z0gn0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk6ThNSqKzj6ZB65rHIlgg/MRlXL3XwHS/Owh8MvgcA=;
 b=Vpm95E5Fa9umL07Bx6FiTERE9vZSWN4VrgS8OXJpAWgO4V3oWw5lpgeD5g6fKvxJHLT2L3rTO/riOfWI4InKqoUyQ89PpjFNOrvECq/5a+TTs8I5w6qYrNl7z8ET/TNRT7FjxoFujy+DGtfW4sS/dk1/JGIU0tAEWpO/huQ6CFZ4TviHrJu43BXJpdpXNR5U6UeEdvLHnT4LGs/kBQupsfD2acQKyn/dW4VeghE5t0r1DL/Jxj3Cj1c3BE3qeOh8nrvcKrDWw2K1dMkrsBLdsr2U7auwZwhFTQ+H3uIl+sOLLaZlpi9N9/tOJJcdyYdyR5Qj1NDUQOEr9wBMLy+rTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10642.eurprd04.prod.outlook.com (2603:10a6:800:27f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 09:08:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 09:08:05 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] net: enetc: set MAC address to the VF net_device
Date: Mon, 28 Oct 2024 16:52:42 +0800
Message-Id: <20241028085242.710250-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10642:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c69b3b0-90fb-4dd8-5fea-08dcf7300879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3XqrXoQcq+0RITuvdErYdy5+ZDYrBHKK8/B1WCksdYUlNnycrKk8zBXQ/AuL?=
 =?us-ascii?Q?9YmNWqkMeAMuxAmes62cYOn7ORp2I00dPftE7zXaHVAKE6AL9oqo7OuEE3n8?=
 =?us-ascii?Q?U/33EGHBh48L2ATpVXFJ+Oai1Cth2XzczG6O7fYJd2T8D4ulIyw+YsKzxpco?=
 =?us-ascii?Q?SeMjViXqP3iUOxgKDGCHvYXiQEf2sEEbohG4BhzOH8kxZygEjgjj3CD5H8lR?=
 =?us-ascii?Q?SYqKbI24XYIOh1AFIrEoZCnEsPboZEbf/DzectF9YHcTylknMhgxzXCIfltR?=
 =?us-ascii?Q?ofCM7dn4O7khY2Ul655mmVA/CWPfcSHIm+IR11blECvdCPmsCQz59iFEdGfx?=
 =?us-ascii?Q?cbKnP7bC5cQ9WtYTtxsXkdy7byfOu/fJFlgTYkQ/0ByaMgR4rZl1Tr9Iv8HH?=
 =?us-ascii?Q?r4Yi85QVoTUm0BZAEpzI0dfHndyqq9KvhnWwik8fvekE5gcAqgMckWHt5TWE?=
 =?us-ascii?Q?C55vfeg9o0fREZW0jfcSh8d5rmaA/dT3DkPVNf28DCFt7oCvyTNnoUsDw+dH?=
 =?us-ascii?Q?SLg10Qc1OVKKCXYF1bpR6V4UIN/r3xHJ4mNCd6pxon5QrMgv3AEVmmG9GzYP?=
 =?us-ascii?Q?fdJG7v9wRIQGe39RjelLHsqlpoLZpNTuGJ99eeDv70fZmKUIIWWv7Xqm42UX?=
 =?us-ascii?Q?dFOwDoUbWaccdv4fEtvC6gtcfmnSwXlSAlECAkV7AE1ZLT0i17r0uCjn36Ht?=
 =?us-ascii?Q?HmbzlnIJOO1kgG1mphytKc/lHa0chvx/MQunQRzOVtHJDnvZzMKjBnYnqLzq?=
 =?us-ascii?Q?xb476PMFDOq3DT/5BlvjPp9Z3uvSIa1sFaAYX7jIGUtMI7VE6qP2qMRXrGRk?=
 =?us-ascii?Q?Q1ZbH2FjcAm1Ot8Y1nwcL+2EXjQ79EJWTPLVaNsIzwcJ43gHLgBU/NoelXwG?=
 =?us-ascii?Q?Egx2+B8+aLf1VVarzGVBaX7xb7lodJTf4NBjxzehH+uFFuKEBGWpohtwXdZK?=
 =?us-ascii?Q?Gb6wEAowW214xfKRawY0+voArwVLDXye7cXYrh0O9RSrlxugeFy4TgIAizwq?=
 =?us-ascii?Q?wHRDNClq7kF5fT9jS48Rs4n3Mfd2ixhdE66WF/QrQVg2v1M9cLJOmAPey3dH?=
 =?us-ascii?Q?4xkK8ptCEiEBPr5SE58IrryV0VoHUDLyli31oZkB2dRTim1iCthoW3Qoa3s9?=
 =?us-ascii?Q?nTTUAIRlA35Hb5VL8RNviJ3/1lh6DWNHOvsczAMP+AacVpckZuR/lileIfvz?=
 =?us-ascii?Q?BzCHLUpQMM4vR2enwE4jXGVqzttsjP6SGv4zwRUIge2rl04MyrH+f+J4GxTD?=
 =?us-ascii?Q?ljYrRtPz51x8FSixlrzB3sS9Bagbgzc6+2M4IS2ULNBwFsPJZTaUXrJ/QwXy?=
 =?us-ascii?Q?6RDredDRSs6V1K+X0nCIWo5F3BUR1VBSTrmy6rVHHBc7AC07h4K+qyZvligm?=
 =?us-ascii?Q?InC0bT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?udBH5vXinPz6Ma0lQLiyojt7HjqeOwkFNIRVQ38Lbe2cN/YdauVPOiNnpNBn?=
 =?us-ascii?Q?tb4Lw3x0h/VyO+5gexQ24diSR5zZsY1WIL7tYDr+0N+GofCFAxaeFayTHMJ+?=
 =?us-ascii?Q?K3I5p3FA8ijIMaAIGITSIEnJ6sxJm/tl9u0qF8QIIyQ1+MLQ+H177fDtEceM?=
 =?us-ascii?Q?XGEIjAst1tWw8HIW9HTa7GOQajSw5zKoUGzENV9tCbpYEDAdByERb3CiiGrs?=
 =?us-ascii?Q?5n2/P4+Gh/SYRiwXYD+l974RFsqQJtXsiA4mCewPrUGqljl5ieRLbEYpZ6x4?=
 =?us-ascii?Q?NtLWbHAmzZ9+fCuJmS/EFTZoJ0CEyH2bu7u1JceFL17FZVJuzt3udorO4/SK?=
 =?us-ascii?Q?2oskuXWa+L4s/099SqY98YDOyZ56hCoUmVhV5U+ntV79h+6AZLGEWEXu8zrf?=
 =?us-ascii?Q?afevtQT0WmcLUsTMFUnDFXo73q+fosdO8lpA7C8X7kGtqZ8unGPNeXap7J/O?=
 =?us-ascii?Q?u/AllvBBBFTFdXO4Yncu968pBTi5emRzCogprlYVFXEEv3R4hUItDPQDVbUq?=
 =?us-ascii?Q?d6IoGfFr0LVBe4Vlb1qtNGr1pxLOttMSSUDtCNW7AHc0ZOSox1KB2aFY4rXC?=
 =?us-ascii?Q?VUCy62yl5EfJcpblAyh6IRrcn7Xjna0mWuT9uht7AI/QvXl2wqig4Kj3Dpxk?=
 =?us-ascii?Q?wcQK7Z/mSQ1/Y4P7KUvzdF+Rbjw5NkeFrjBP3pEdDzIwsSAwHTJcTiNGQMF7?=
 =?us-ascii?Q?5qBFf+RamygdxEFWnammOVFdIzv+zYk5NSm4zbWGrxchZen4z+XPhVrxaALt?=
 =?us-ascii?Q?Qwlsp1/F9FxnC2/DYrD1iyxnGT6UyFl16B0oqp2saRwaX2MTX6lxuNAwYNrW?=
 =?us-ascii?Q?xAClOLEr9L4LIXDbp7Owz7o9UhfY5yZwSftUiugDiyxg/tlgFo7nvtkoc1Hs?=
 =?us-ascii?Q?ZylBq6t5i8gpxPdxmYn3+R4wZjjBZ4jsi06Iet3odgseR70h/Mg9RW3gR2kN?=
 =?us-ascii?Q?NPkm7G1vOEFzeSvW/B+d91TJnw78RSZS1D7XwhxZ6O5w8eFHn2O+xPBi8fpb?=
 =?us-ascii?Q?dZhfwuEBzvAEanO4Xo5e9mdbNEKY5ESlYuu1ivQcwIrXiCwPeCqVC2Jh05c+?=
 =?us-ascii?Q?ZPWvbZw6dlnrcF/ekTMuLsaQ0TDD2syL94Ve6Dqgk49yR8ZytSHrk+x+g7CV?=
 =?us-ascii?Q?a/eCYwkeUN5o4JkEomxbuM7dYgrKiCPYg/a43DubS3SkEyTTqm38vLSM3+qP?=
 =?us-ascii?Q?+pQxktJi6Sk5lb42exPjJGjnNjTj4PXm1U90y6cKXpTQDdIKhfj7cHf9ZAFn?=
 =?us-ascii?Q?qh/9a6evC6iQiEBqqVHzvSyF0oCWSbhm0GUEiTh+CV3VtmU4EME0pK6CZcgu?=
 =?us-ascii?Q?nMB7/ERrAjqgAL2yVKXVcikYH2JjovDplwWc10FJeKxNTTkQrD5JHCblk9G1?=
 =?us-ascii?Q?KmctpntbJEh+FRut6mA3HtPu99MIpOMb7aoSHvyPkpW8zPywtyNYKR9cyUza?=
 =?us-ascii?Q?1fu9lB9AH/fFSMfReLXyeE3pzp1dftpriDdVonlI5WxtoqeLJSTBqC4ycGUE?=
 =?us-ascii?Q?4I+RJbIBbQKn7pUbAQIBjlMzxIucei/s5DOolOgVP0a6LAUQwSRpDw21tBcB?=
 =?us-ascii?Q?JmphQP6kU4OYXrvGsepjYPBhGktIZKvTj6GjYh3W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c69b3b0-90fb-4dd8-5fea-08dcf7300879
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:08:05.4701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98UGRf3Uz2MkRMTww3Bm7t0MLADRkjWtnph2vNoWVCuh4/rTD1KUD2vUNxIKR/oRQhUm6dcNcH/1l5RE3vnndg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10642

The MAC address of VF can be configured through the mailbox mechanism of
ENETC, but the previous implementation forgot to set the MAC address in
net_device, resulting in the SMAC of the sent frames still being the old
MAC address. Since the MAC address in the hardware has been changed, Rx
cannot receive frames with the DMAC address as the new MAC address. The
most obvious phenomenon is that after changing the MAC address, we can
see that the MAC address of eno0vf0 has not changed through the "ifconfig
eno0vf0" commandand the IP address cannot be obtained .

root@ls1028ardb:~# ifconfig eno0vf0 down
root@ls1028ardb:~# ifconfig eno0vf0 hw ether 00:04:9f:3a:4d:56 up
root@ls1028ardb:~# ifconfig eno0vf0
eno0vf0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 66:36:2c:3b:87:76  txqueuelen 1000  (Ethernet)
        RX packets 794  bytes 69239 (69.2 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11  bytes 2226 (2.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index dfcaac302e24..b15db70769e5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -78,11 +78,18 @@ static int enetc_vf_set_mac_addr(struct net_device *ndev, void *addr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct sockaddr *saddr = addr;
+	int err;
 
 	if (!is_valid_ether_addr(saddr->sa_data))
 		return -EADDRNOTAVAIL;
 
-	return enetc_msg_vsi_set_primary_mac_addr(priv, saddr);
+	err = enetc_msg_vsi_set_primary_mac_addr(priv, saddr);
+	if (err)
+		return err;
+
+	eth_hw_addr_set(ndev, saddr->sa_data);
+
+	return 0;
 }
 
 static int enetc_vf_set_features(struct net_device *ndev,
-- 
2.34.1


