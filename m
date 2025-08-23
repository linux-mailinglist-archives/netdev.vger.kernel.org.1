Return-Path: <netdev+bounces-216237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6DB32B89
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B8F9E4623
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C644245014;
	Sat, 23 Aug 2025 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lXMH4Lfc"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261A1E32A2;
	Sat, 23 Aug 2025 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755975725; cv=fail; b=e0aBmcNlNEQCQ5tuIharshJjdW86IXvqATyJiDBFyh3ozIVG8NIU+ur9i1fiX/RMgmb+jWwTmu+6O/gNSnw1oR+Y59mZRgwQWqIZ5EYCW6c+PbSpgtNjyt8EGJ+67Pjs6KL+PF2Yk8tVtNiOdhphJvYhXk9gijqZl6ymk7EsdSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755975725; c=relaxed/simple;
	bh=fsmS1e1A0qJ+8LPfaI6jHuEd8qN+ObhjnBOC6BpWBmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T6zleOsNTmVQCdmA0ojlagIY71WY8L+BlVMsCNPb5aoQgjJ5JI+oq6ZJNPi2FHtwenjvVNW/E00MZvqBn/iM9sOEc1A+J0W+dtzRvRUozD3d19IBRhBzPSoaU0ciHAeMp0OiVtC+2DtnuKQO2f82/0FIS68Q6emBnsDt/qG3BpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lXMH4Lfc; arc=fail smtp.client-ip=52.101.84.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/ZMungnyvi9Xn0NUX4gOKoExlkjHEGN5quGDkoP0tb4hRND0TuXE+qW2b21Xi58LSs9aAzEXgGrLbi2z7fRHHxDEKKkwLtZkQP26oM0ptOyvjTI/4M3lQg1HjEYkUqopbn/cykg15vcnwRTfToezIa5hyH7uweTdrwdQpgZ9CXUjvqAAksSWdXaf/mHOssWodsaghtlQ3g/QHLUqcilqKJ+4bqEnuV9NuOsWOGrjyKnhTMVFYfOTVVFR/qxmPqk8fep+d05LcVKBqd5tg+EYRcKDlE2GvptNfsjK+Z3Ja6UlXECyOwSg/j9XDfFDuzJOD7UoQ51Pz5hzCFKR6d5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqwNsnPDrSosfa1KNFNxuk0CUqmiZZoKLA9d92JHliw=;
 b=wp2vuvaRlnx8a8HOOvvePBogm+E1T+osfXjqgPD33ALpHPSBJmoBwKpd3RglS57sGu/LmrUC2g9zD41e6oqSAPvlp/HnhL1r4gNtVFCToSCpn4eyCohdCehXDxcMKsW4FBPdhU3bPgH/1QqKrIwDfnB9F36IEGJy21lk89PT2B0dU3P4NtSBaQf+nwS8rVV45WB17cuGRsUnWlkoYheI07DWEhz02KgpX9JfIyT5b7FERB6DMPUHjsUiRVj/eQOwzfPnj0bWVyWHacK48QO5nJxSORUWflMH8dzcg5yxJzyLjor0FyiCC39aUHtZrrTSA9yTiBAOWDLMRdMcpXP5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqwNsnPDrSosfa1KNFNxuk0CUqmiZZoKLA9d92JHliw=;
 b=lXMH4Lfcsh6iOnyUyxW97HqfHCAn82N3UUSjoGzhE06+XiZT7+aKpgICXmcDAySj7Gq5NR/xeoGQ/3wyFfOv3cHcYeLlqElNV9I0b4jv8QQIoftEiquxQcwWtJF5GB+ANITG5BDyP5x0ccFodOXMtJQMRyJldp5sDqgjrpe+23RhWbw3Ge/UOYzq7UIZ71u+CoeAaDBApVTh5QjoFRXimQ/Ku31JogQY//kaJsnz4fDbTBrWnlWiUSrK7K0v1LvD5568IJHcohfoBhsR8Y+vb68K1oCMYDg+/F/dlm81xNpXhGSLSXpU/zilzGHiyHdSZUS+wLTc7CugS5noqvGJpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GV1PR04MB10456.eurprd04.prod.outlook.com (2603:10a6:150:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 19:01:57 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 19:01:56 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v3 net-next 2/5] net: fec: add pagepool_order to support variable page size
Date: Sat, 23 Aug 2025 14:01:07 -0500
Message-ID: <20250823190110.1186960-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823190110.1186960-1-shenwei.wang@nxp.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::19) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|GV1PR04MB10456:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcb7096-7573-4f06-a57e-08dde27787c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y8pvFBel/2DrFhwconHu5QmNRSkwwMljAmCjM+tTOVmn+ejg1yiSWCy5u2K1?=
 =?us-ascii?Q?4cUoq8dt8M2jKAsaXF/LWipLeArpcT6jUABO3R1OzeHUbcABE/wRrXIvUgjo?=
 =?us-ascii?Q?vlWe9Jb/7y/4IBrOitt7JBRYwKurAixBuWCBnZieVwcfw6rx32HrXfycpZ6p?=
 =?us-ascii?Q?CgjfJDUNM4Gan6zg9UmcQ3TSkYNeqWKzHX+xJ2AqctKcLR4oe0O4NLOEUhJI?=
 =?us-ascii?Q?v3AlZuPzW4Tg7vmfaPll3TR/RGat5173jsuasCcYH+ghpHp8sv1fnSsXAb/f?=
 =?us-ascii?Q?rTqsb2gYx3I8fKkUW7/k0eIGUMF1F1iydz/d6glNdzZv6HSIAiUvO1mEyGzk?=
 =?us-ascii?Q?YPKAYu6Q6i4zaR1llyV4EP0SrJHESP++q8t8cvfA8v0DjL89NO07yZMuvcbc?=
 =?us-ascii?Q?+6NjGnusW1S459p/pNdINWowSDujPxM4zAxfcRHw4FupE7HPwQNM3aL1Mx5l?=
 =?us-ascii?Q?u2o6HA6EmTBS29Z54/wpvVx1HZ4pJEy2RhCqwbs2hH1YHlQpWXfuR59He9e5?=
 =?us-ascii?Q?mwv1r6Z/CdRYw8O1Rbrv1muQcvrwhgibPY//uPsbE3mh8sUhC8TcjBgbCAfw?=
 =?us-ascii?Q?OKWbBdkTPMrMd8bCwiX+AS+s6tAfMgMSLTjH3apgCttzv7iZjMhiOjhUJHa0?=
 =?us-ascii?Q?E80UTS2vvgrPXEsH/WjiTZ2FQXrvnzriFkyiFSP+E3fH2d4e1ogagWI4zXv0?=
 =?us-ascii?Q?+7k6GCJVK7VYepLIjXO9MoDvX9mQfrvvEPWOXqpWboEUFxJwR6j3uFYMP1Eu?=
 =?us-ascii?Q?w61MR/Ta7vF1lavNzay6KAw/GkqeJtjcs11yYmEHBN0gTMNWS8dmVfNIrH09?=
 =?us-ascii?Q?7cUD7PeR6kUPorFYkyQlFXW+bj6oWu6evamoME+Vk+IEAHLNy7V6SiqsamC1?=
 =?us-ascii?Q?x4gpdF9Cs0e/PiAcx0tGarvfyQr6AtztQEcGpciTh780Dbbnvj1nhNRYTke1?=
 =?us-ascii?Q?64nyqOQHcDhljUS1s+Kxzjqsqkv4L9ljzUgIhrU6zvkAoA5HZQS9jWNFzcMS?=
 =?us-ascii?Q?JBLAw6+FQ4bZsDcB+uapyMkHtXN4mrfwLXlxFql//9U9LUWc5vkoI9KWv27i?=
 =?us-ascii?Q?MN3dQMqtdcb7g5D0fKhEqzAWcwTzF5J2oYcGfmSKbphDgHkRXOI/CRWOhmIj?=
 =?us-ascii?Q?8MlStNTLaatFSRQeAzSTbWnoTO4dh3VqytXPZTE4r/HNmujBYP6W55oDRMEl?=
 =?us-ascii?Q?2rqRiOHm5FAHTRrXjMvV8QwjGBZ4odhiOnvAxzY9nKzBuRRTvKBd1sp3b8WW?=
 =?us-ascii?Q?/uy94IPCtZredBN8NP7RtATprNo0Z/WsfGt59vob3XvrQTdQgeIZqB69BpS7?=
 =?us-ascii?Q?Q8LTD+6fBLF8uDLCRZduPbRz7isj/V7iBQIYZgfQqhEMsYcH92HkrZNPlRmY?=
 =?us-ascii?Q?Qm6XBAByct+tyh+Z6H0oh/twX0HX96SYmdpAJJNj+zdjvIckS1nBQiZ1jmVx?=
 =?us-ascii?Q?xFzhuhJrQLxaOzRnwmVKIzuQ4ICdIWHo2lVGJErYJ1ugnSgna/EtbZcvNSJV?=
 =?us-ascii?Q?uFYKjfibWwmuclM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZAk9ATYsQLOtZMlaXjgZTXy0O85PnV+VYbl9tWHkcNcWuYjt0kQPShWmJYNp?=
 =?us-ascii?Q?tyYxBg0JMBlnafREL5ysu4lNR4B4yNDJZOCfq7vgLM5oM0CZib2Ao2tT3r4e?=
 =?us-ascii?Q?M7bygVpNZ1RrGvaPeUmBRr9+6jrMfN5NwJydDWWaFXfu2dy7uDeBRcJu7eMU?=
 =?us-ascii?Q?4BrjJbsrfekJYtarW63xaa3weqrtWG9Te8460kzKEWO+9I2FKFW+idGd1XTx?=
 =?us-ascii?Q?i71K9IA8Jc0WCu7T4V3Lkg6bF2/N9uQ/UO0VedKVMs6pI1tZUgw3+/XRQua4?=
 =?us-ascii?Q?ofEo3H7Zj8xzQLnQ5SDCvYbmq+QYoJ0M3NmV57l9sIBOxr8f6EIC4VL7xkl6?=
 =?us-ascii?Q?ADKo/qe/ztTJCsjs4Rh7vJEYwRQWdcWzmNSnr3bjnirhbngu2EOWmZEIKdBg?=
 =?us-ascii?Q?UMyepfN4ky68ddD3ULUzZVfjzuoYkszhsF2W5dYrRU/DMVmRxZ5E4iSVFxpJ?=
 =?us-ascii?Q?Td6QcY7BztI5CLLdSTvt7WIjkGBpQLkbDIp0XyNiktX0EhLPvnzYpMd9urt6?=
 =?us-ascii?Q?8Hy+PgAIYW9Nk48l5phJpENzSLf6EK0Cl6JL0TCWYKWZKWjqZ24wBvur8fxz?=
 =?us-ascii?Q?Ptmr71+LLgoGPQoWTnCrD57gW1LTFOPUepxr26v6qdHmzlHiAFzcd22d5XfN?=
 =?us-ascii?Q?nvpXZ/tbib6gioR1rhL6VTAOKkNDfRl4P/3MYPolsITzTr5Q0glCvo4GO2EX?=
 =?us-ascii?Q?V/OyrbZ+YHlLbmOQ1eVik4g/ErIibGbxrUHF81pLadG4/1we7wpnVEVMlAqb?=
 =?us-ascii?Q?S5YKl6T5ZhCj3wL6gp8gD+UDQU9b8gEk8tkaISWmvkND2DtBBmlHV0cJvoZw?=
 =?us-ascii?Q?KAiXhK/9B0j4k0ZauMPdm1SPb03FJHl5rP4LoKA8tJqKWNXy5LHjbRS7gMEJ?=
 =?us-ascii?Q?ZjtH9obabEHSk/VxtqvgsDyangGc4Yo/PQnc2n9V8JUGumbg6CtLJ/4WcEe/?=
 =?us-ascii?Q?/HqkQ3/5s57H2fcyjZ+rmOyx7okIYvS19dr1kUlQr0gVX4S/1QIB3NiisJ9H?=
 =?us-ascii?Q?JnpFHfxOlwUEQ92MgTrQJboNoEMU22IfaHgeJReFFQMxg5xwuZct2c9S2Btv?=
 =?us-ascii?Q?2R6twq3m2+3KvQpdEuY0Kp6EjXfeqhFN85RclVW0LyKVn9gyAmWfUAieeRrp?=
 =?us-ascii?Q?z4ge8lXLVhhZ1oaxMY5S1hdJ+c0YWrakEm14Jaw4pd/AKQiw58ZUwbd/o070?=
 =?us-ascii?Q?X0/hUKVCWMuOr0hEqBbuS5CYYvihk9Gn6jyjpDoAh6LZJN2Kx0QsAqGjOnBC?=
 =?us-ascii?Q?RkeENHIBRAzX9HciGO2I2wXY9bQJ42DiyRzsr4LhH6KvkniTBv1iAy6yJ+Ib?=
 =?us-ascii?Q?Ad49jbzOH+bGAw8VdtMf7VdqW/CIMiy0rQR2DSRpkYPdkEzvJAACEzxNOA5l?=
 =?us-ascii?Q?S1dvcW0SzhxlfBev/MfoLlgUpjWbbCdGzefauwKQCvT7CnE/yXbN5mWcbE0k?=
 =?us-ascii?Q?261Rt9MGRngHxJ7GEGA6O0pKApKDkrI4LKw00fKtHIjKhQHXcv0kAWJiNOBC?=
 =?us-ascii?Q?IZqQ9y8DJ5UnM+AOJabo95a9MA5yOW0NA/13GSF5+0gBkxrl56A5L1oDBRdX?=
 =?us-ascii?Q?UWik+ORp8TpvOpyeWP8rNS+pC80LT+aPygLW+W1q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcb7096-7573-4f06-a57e-08dde27787c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 19:01:56.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pcRFsyrt6PzfECZ0nhnmEVKvD7HCNvKTEf4uZ9xrLgZ7oO+x7OOxc4wEcdU9IbMZvHGv0Vgxk3xNzyB96KW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10456

Add a new pagepool_order member in the fec_enet_private struct
to allow dynamic configuration of page size for an instance. This
change clears the hardcoded page size assumptions.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 2969088dda09..47317346b2f3 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -620,6 +620,7 @@ struct fec_enet_private {
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
 	unsigned int max_buf_size;
+	unsigned int pagepool_order;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 5a21000aca59..f046d32a62fb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1780,7 +1780,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 * These get messed up if we get called due to a busy condition.
 	 */
 	bdp = rxq->bd.cur;
-	xdp_init_buff(&xdp, PAGE_SIZE, &rxq->xdp_rxq);
+	xdp_init_buff(&xdp, (PAGE_SIZE << fep->pagepool_order), &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
@@ -1850,7 +1850,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		 * include that when passing upstream as it messes up
 		 * bridging applications.
 		 */
-		skb = build_skb(page_address(page), PAGE_SIZE);
+		skb = build_skb(page_address(page), (PAGE_SIZE << fep->pagepool_order));
 		if (unlikely(!skb)) {
 			page_pool_recycle_direct(rxq->page_pool, page);
 			ndev->stats.rx_dropped++;
@@ -4559,6 +4559,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
+	fep->pagepool_order = 0;
 	fep->max_buf_size = PKT_MAXBUF_SIZE;
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
-- 
2.43.0


