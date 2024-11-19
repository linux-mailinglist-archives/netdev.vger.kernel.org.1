Return-Path: <netdev+bounces-146144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6CD9D21B6
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0521F2287C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22919D07A;
	Tue, 19 Nov 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JWSPF/Lp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368419C54D;
	Tue, 19 Nov 2024 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005586; cv=fail; b=Q8LRO+fL2ZX2BkeJajmE5mlslG/DSLea5FaEPN1KSyNphYBLrBWLwiiChYyFg3KljiIRdi6j2IVoHV3z1e2cTG1d/oQK/XLXraihcInqM8DFD6o8FuPpXRqoks43HorKh4qz7u2FXdCVWPjUrNVj1lWkRhu7yGg0Lqj1NT5eyc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005586; c=relaxed/simple;
	bh=UU637Nz2LmuLNE4XgZHl96yb03Fc84V/j0GwBuGWOFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kMdgmcrBGH8AcA8wkpGtc8Pqsz4n3h4p6kUTilxORMWbJ5qoUAI2pL6jumO5rzLd7aitMRmjr9fKvNQjye0AdoZQ1J/jEcsaAog6zgvjY2dYJBrXXrj1dX1XJi7pxrjZSXoebwYpLVtNeJJv30rLnPdhYeck2W+trT28kh738Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JWSPF/Lp; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLEjnvEgJAn4EpJsNw5VcV9aD+TroC/wCx2lIrwcCD6oSPOyDw1SP9c3pjjWH39gGuPyx9FUTfU0qiBqVzOtI6K6nE6nKiq/gv32Ik4Uqsm9p6uTTqS+jnAILwZZ/OCdl00dO9MHCeGtm23ME9JnmJf/EuhGitxJ8bGcyHsVhTuKivjfsLd+IjB0b7Ovp2A1ggWNKjeBt6+1HKPgZndsycyZWE0TrgHPcDx29/Zeb2N/YoyY5Q5TB7OqxphBH371csKTd9sKrcsJyZLVjc4QQblilAyP8PKHZacB1rhWxFdrgjgZDrIXd6XhCkH6bPCAdw+T+7r9yHotc0TyUbW2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80sbB6jq5JQjpdmh5JVuZ+XbeOHGVV9tbDeXnvJQfRg=;
 b=UGAPt4p4P8s3924JszHwjKCG3B9kgFtYaIuSFvUjHMIMfdU7vnxVgptY82DmdjxrfMEG00loFnR7qfjEIfYzyLiDAHhpTN5SC4NYKIXmrXgjeqU6U4qi5xOVD1G8yYTBzu7Ejf0OxyBbhvfGyWxpXWj7vFaJoNR80D0udnx0Jy3QmXlmSTN4MUDp/6gZRUZrZ6dqVpSaVBn5BJ8y4CEE5rA6LuDcARWnUy681pMt3FyROZQN5kmyBD6ROz18RM1zkpI8SflPW+EUmzsct/NG391Sm6lIx/UDlR3HbZ28jAvobfnoEs2QEgMcL1WBXGHAsAc2VAh6HmIbcqNdvzYHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80sbB6jq5JQjpdmh5JVuZ+XbeOHGVV9tbDeXnvJQfRg=;
 b=JWSPF/LpzrpnhS6IsumY/44XWc048zao9fVaIlbgiq/AKpeIBtOjPNW52YOnvze53ZlWX6lO/IuSVlMpxENhiVZp7EqMKVUASZ3rBcYZNLb1u4MWMS5kh4xpRssm3CJ22iCPuTlLnMvSddwztXNjqfsH1173Epemhhuzyi92YGptxLVBOnwRUfb0KPCWyWvqfSElFHm//I4O7B/4m12YW7UKaICV/2TP6AeyDPIyzSkRmlf/VzlspDpUKVpEiwVkSPj9QnmUK2pTQs7KuZrx/QvrViLIbFPtEypjPfTTCvRDVtre8EKl5jp9wbBHmPcruddvKd0/4oCgVz/B+x9lSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7160.eurprd04.prod.outlook.com (2603:10a6:20b:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:39:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:39:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 1/5] net: enetc: add Rx checksum offload for i.MX95 ENETC
Date: Tue, 19 Nov 2024 16:23:40 +0800
Message-Id: <20241119082344.2022830-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119082344.2022830-1-wei.fang@nxp.com>
References: <20241119082344.2022830-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 221591da-3284-4fea-4c1b-08dd0875b5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vSicuHXjZWlSHX+J0mCWb9fqSvi6e5E/cdgXehWXIaB4RzIZOef4sMG4GR51?=
 =?us-ascii?Q?YCiVCJeEdoFqR73y0pj3Id+juj+9aj4OA+qXjUUFIzFtSY7+KyLOKciBwk6H?=
 =?us-ascii?Q?r1VhLg1VOM4+rpOKKl5C84MHmOg8+56VVvLizDiwf7F9zzlZ2evXHrgjqtAa?=
 =?us-ascii?Q?Da3wxahv13/OmdqrDq6zO/hYWhf/5WtidunS9E65y8qSAP2+QnLHtQJxgUSZ?=
 =?us-ascii?Q?2ZgAaXn4KP0MToc/ONBIDdCRNR2NiSkH3jXByeTdYsDbTqcsp/I4q/6EZzxQ?=
 =?us-ascii?Q?BIqVJKX86VQ5LaSy4I+arhowUHaSIU8mn0M1j1jA/uIs43VTCgzMJjRbn8pM?=
 =?us-ascii?Q?3f4vrlhZDOWwebRrymJ9YgJwtquIcPUiMY+5s7x+JwoBQPTknTsxvJ9cGXFP?=
 =?us-ascii?Q?mQO3p4ZsgmFBjgVdTLzff8YxVSeSYcu/RsPXFlCtZxUoy6PTLhROLc81Bujf?=
 =?us-ascii?Q?zluSPDfszyBAf3x8qxh8PXp0JEGSZjdo0s2o57DNQ7Lj4TXJ08dEhGE0z2EF?=
 =?us-ascii?Q?LC8+2+3q8HQhORQrU9TGXmfELIhnrG1cnSXq6FEDlp09dqhBn7q86mrAL/Qr?=
 =?us-ascii?Q?De4XqjjFNoJladflpsezFMySie2v0q5Wtn+lHDJproZnUMgkIDL8ttNOVOCg?=
 =?us-ascii?Q?Vf83EHhof8+Cf+sLMrGg3LeZJnQKOCD4Q6nng7TLDzPeErRtXDdt3uBzSPIr?=
 =?us-ascii?Q?eiSzzS+i4itozQRFmvFERICn10LCuISgrCZO72P0KkIFJU9qPBiBocAlG0eD?=
 =?us-ascii?Q?AA2aMpYScOzykQDiMrJ7yyWas9K9pmdtPJpB5P1+0lfbhxp2SIjsAairOjMW?=
 =?us-ascii?Q?IrtJ7sZmndgk53JMQ1CsWEM6AD0X1Sx19CSHPB97CA0xmXVYo+Ya9Q1i1a8K?=
 =?us-ascii?Q?751WfUDDQcfI892e9brJF5hhjeCpJx/upi5iPjrv+Ofmow2Asxd1Drv9cqC1?=
 =?us-ascii?Q?vAkar1iww8CrOCXYbzNb1/DngHLNuvouhfHI5ukNJI3QL4PrW3Cr2s3f78oW?=
 =?us-ascii?Q?HeQDjIkgcHpA3u+v5RpFjdDTVzEFhT5PrBXQ5XpKFZhIJuPSLRCsa9tpZQXy?=
 =?us-ascii?Q?gzN3SWnRdev4JMjAE6wlf2cBRcYnsR776XT0rgFZXHUbCCFBWiErzQ5yxir4?=
 =?us-ascii?Q?gxwmb3e7iqnVdQKbHFQWGAoDKBQ/K16IpBOQV6IIo90P7thVeGbd83P0adFD?=
 =?us-ascii?Q?06sw+h3nWpENRDT5h5opni1CVv23n4Gv9+ybgMLo0c2T5Lv4XaUijIGJlbN3?=
 =?us-ascii?Q?8DyAJKeC2GIvGbCTHvk4d5bV0dXyA81AuJlPzzYga+F8cslEwrTuVVlUZP1o?=
 =?us-ascii?Q?rlFjH/XMLcqFsijlFFxpY4lo/cW5W89y6gdT6Ls8309OMsjZfhONoSrA/kZR?=
 =?us-ascii?Q?UfWmDBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UPmrhiI6AdsHeuyFoZMsJWuXJ4X58fr0KnEIr3px+cBdYlrj4luQ+szYfA1k?=
 =?us-ascii?Q?T62PJZ5ljHNma4eQDF/XbxPEo76kRfO62p3ejd1edFJtKAn4PPY6347ead4a?=
 =?us-ascii?Q?IOpXaQ7q46uiSyTA70f2TieKY9c5eDVetDSKnFHe7ROCGj231GV5zEY9yVho?=
 =?us-ascii?Q?6q14RRB3b37kSUy4tAV8F+1T21PVX/Q2TK3oqSF7e7mG8AUms3pX3Ehektur?=
 =?us-ascii?Q?hfeu1SUhwOn9xo3ESePiIW9ZC7H6w1dDUptXyXt+ZYgqicAdXQVd2OIgjaMq?=
 =?us-ascii?Q?yz/kkL/v3RvtXc6eLXe9jJK2POaI5J45wU7EsFZkKTaoL2qGwnClTc/gyv5X?=
 =?us-ascii?Q?fDVO8+ij+MGyI9fso9u0QnWfSDuMmNK1SvVFi+RSy6cMSsqJWQfWFAqvXjk3?=
 =?us-ascii?Q?j0mTOijeaMzffRaowqtHrE38DNTU/b5VD/pjZUHxUBsMdh6Idk7H/fDHrDZQ?=
 =?us-ascii?Q?P6DyE3XCLUwjZgkRVNsQNJgrWcWWEqL9eBDbFeEVltTNQrulk3/SFpRsClYL?=
 =?us-ascii?Q?4EHNHjyJRdjFGV3/zP3zY9++UYiRyXUwOdU6oKdprofNDCYz7VMKLHuBTLVS?=
 =?us-ascii?Q?cQHX9v/SBEhCRigb57ixZCEvzaFMllLXsmKclP9kXVSjFJDHlKPDDk2JnqLZ?=
 =?us-ascii?Q?tFZG4feHJ+CT+VHZm/ZmgDfeHQBSQ2ruNFcThXoUVTokjEH9zyZVSgbVe4F+?=
 =?us-ascii?Q?1fKD3rSFdSBnp55ryV/+r0bRm0Lw7xkQ4fOokTSbRtwVYH6Z8aCk+YVSoJB5?=
 =?us-ascii?Q?rWnqGYMsMqO1GfmAegufnEMQCLgZ5Dfpa4Z3QKVCcNZ6W7Xb1qLawcXUGgVH?=
 =?us-ascii?Q?wOPwiBcqtOm7MgyEuVCpvDMpi7frC6gfzZlGCa/pc5jCL8OoHTtnYPFFD1pz?=
 =?us-ascii?Q?dBcpcIBj0E6uTK/CeMqZnTmqGjSLrnJSAi2piAPDKxWp3kID1Vx8lV5oyf8j?=
 =?us-ascii?Q?Djr7Af3EmchkHHPdz3M0GWOSgCYRZcmigT8lpDfmn3buaQmSY8SYZks83g1g?=
 =?us-ascii?Q?9q2naaOMYnMv4xmMYv/mTI7DW9BamAhSgKXyzE4MZaVFlf9saDffykjkfRhB?=
 =?us-ascii?Q?+SjMHfntFz7jJLpVOEoqy/iY3jnNFq/Gup2iWHmqK3SV7pQrXQ7hycY/BoPb?=
 =?us-ascii?Q?SJzhI9hgy+HXZPNttmK1kcX4QDzQ0U01LAcQ0aQRoEXKj1MPJo+lx/aMY7Yi?=
 =?us-ascii?Q?OdDptHnPRHAAmzagEUnom1IqxSn85JJ/HcsEfZVahfTpPdSaCcI5++GTHvNF?=
 =?us-ascii?Q?0Iy2/d3NqybtBwBaGR+Yc+EOMPx4O8nuty8zWxi3WNRhocV3cr6N3ao+DDFw?=
 =?us-ascii?Q?4C5t/VVzmiz5xL68U74NowAU1KwmcYcwt4bOhQu1y+2ZGHjJZ5L+aMb2fxf7?=
 =?us-ascii?Q?873adPZD28KoPgaksqVEDrlF4fB4h9YKwXLaxrVwpdLFLCrDZnyLfiqkXQVo?=
 =?us-ascii?Q?wYgEWtqK94wDc6/3ZXH6kwHOVRniW81AXQ+QDPIHGjp5f6i8ciC7Y1VjVtYH?=
 =?us-ascii?Q?1DSGdTIBKeGJCzf9CgFBirklllAAiGTEAy+72yuknwq6Sp5lb2j7RnefGbdR?=
 =?us-ascii?Q?PTpjtBe22H9lu/pldo0pKN5p7eGFZFCkmnk3luI1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221591da-3284-4fea-4c1b-08dd0875b5d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:39:41.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZveHVtd0RtvIkFv34+f63jMnsQZT07uKKjiJYDb/bsT8+TJDXpv/w2a7/7XOc5nYW3jNxaLv6t+xJqELxt8rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7160

ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the bit
108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since
this capability is not defined in register, the rx_csum bit is added to
struct enetc_drvdata to indicate whether the device supports Rx checksum
offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: no changes
v3: no changes
v4: no changes
v5: no changes
v6: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c       | 14 ++++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h       |  2 ++
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  2 ++
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |  3 +++
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 35634c516e26..3137b6ee62d3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1011,10 +1011,15 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 
 	/* TODO: hashing */
 	if (rx_ring->ndev->features & NETIF_F_RXCSUM) {
-		u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
-
-		skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
-		skb->ip_summed = CHECKSUM_COMPLETE;
+		if (priv->active_offloads & ENETC_F_RXCSUM &&
+		    le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_L4_CSUM_OK) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else {
+			u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
+
+			skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
+			skb->ip_summed = CHECKSUM_COMPLETE;
+		}
 	}
 
 	if (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_VLAN) {
@@ -3281,6 +3286,7 @@ static const struct enetc_drvdata enetc_pf_data = {
 static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
+	.rx_csum = 1,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 72fa03dbc2dd..5b65f79e05be 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -234,6 +234,7 @@ enum enetc_errata {
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
+	u8 rx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -341,6 +342,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBV			= BIT(9),
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
+	ENETC_F_RXCSUM			= BIT(12),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 7c3285584f8a..4b8fd1879005 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -645,6 +645,8 @@ union enetc_rx_bd {
 #define ENETC_RXBD_LSTATUS(flags)	((flags) << 16)
 #define ENETC_RXBD_FLAG_VLAN	BIT(9)
 #define ENETC_RXBD_FLAG_TSTMP	BIT(10)
+/* UDP and TCP checksum offload, for ENETC 4.1 and later */
+#define ENETC_RXBD_FLAG_L4_CSUM_OK	BIT(12)
 #define ENETC_RXBD_FLAG_TPID	GENMASK(1, 0)
 
 #define ENETC_MAC_ADDR_FILT_CNT	8 /* # of supported entries per port */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 0eecfc833164..91e79582a541 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -119,6 +119,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	ndev->priv_flags |= IFF_UNICAST_FLT;
 
+	if (si->drvdata->rx_csum)
+		priv->active_offloads |= ENETC_F_RXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


