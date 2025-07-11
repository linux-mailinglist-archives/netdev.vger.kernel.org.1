Return-Path: <netdev+bounces-206084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD298B0145B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23438647DFF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07251F239B;
	Fri, 11 Jul 2025 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AoPjM0zW"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981901F181F;
	Fri, 11 Jul 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218301; cv=fail; b=siMOQmP4ktbx6ASyZywUAZJcNvu3mpto3PrxaSkkB39M64BG0llDUegpWERbDoJOw0AwT/G9AAZuOIRKUoTELN2K2VVKYg0Kq/06Dw7RI+7QBJdt5EUKP80SwQF89iiLJHl5vWBfI1Ic5ILeufeIHk1C369HI4begRqNRiYLc+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218301; c=relaxed/simple;
	bh=gLZNU46evqvMp517cEw+eetTKpVE5myQX4T/LFOUgl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X4AjVWLSRN854a5B3xs4DIFdHWrzr9gmhbQwaiIGf1kX/Une0Ku1Jh1q2KIzW2luQMyJ8w+N1dK15ko8mNKR+R+ro9GUQ252gHB27FyonOkbtWnUHbkl9mLnd2JYUH323rGM3tP7Uzxxt+Cb1Yp89c3DJBFqOODutCCnDDYy39I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AoPjM0zW; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6d22zeFruwMPIonna4VYu1AHeSG/INbtUOiZ0Z3oXkY89dskOX0FiKs4kmIiRKFYYnQhti1gbSHVZpbld/CS/Dk0CDYYkWuOdAUBny803j3BcuXtt3wbWQs/yDT4DS3dRreg0Kbsks/g1HsRCC3/qHhOY/dxid9NrB83I1bsrtoECF4R3g+mQrDBq3W/9B75FLSUiiEeNfTYkKPMjqMCFWjvVxPDlFKTHma7nDzqGSdsuswupeSMtYuhxQxjl8NHZD5Mi2o4+zygu07AALTHG7dEmbwlrXTj8PTtWg84WhGmrsCb9ApZWZrlu8zPXO6Uy1RBmAuR/98G6S1HST7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJG+XTepwikV52ijdIow0dRWYIZTDy/LZopOC0tC71k=;
 b=xi1G4LnbKcBaEDJ+2oP1feFtrmhR07PPFsMDzg/hryZ3/6TrwVly37ZB6/aguvfnrEOfy25gtNMc+doDFDh7W61nOdc4kSbU5OIphXi5qefNigptznmOph1hPE4g8FnxgHaayh9gFqs9Ji8YEn6wJdIx/XZC/ZKOhEoOAzq85zFVEHI7SC6c1JxqcAX6TxSXgGdaX1OKcLCBY7xuTQVRhUw6ZEfYxKNUWMue+LBssWPiY5OAGXTBkbUW8Xxejkcl6ofwKSbdAtcDV1sU1Hmhaiws3y5yXmRfFSwo/hhzS/xYdd1T6uG97XgwNpxMeNb6zdevUyXRPtbZVigv+ef5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJG+XTepwikV52ijdIow0dRWYIZTDy/LZopOC0tC71k=;
 b=AoPjM0zWKqidbJ4CAKyZge4+yL2I9WiWgmMkfmYqX2iRnCDgVP/92Epo1vniMGuFs1mSgUmqFep8D83zO1B/IjdURB05MvJG+8nTlVGykdYVLzX0Yr4+7gFCWgGKhbehvAkEsvGX4Opv9EqZKktwrmc4SZDfQM3xQYoCX0F7p1vXPcW74vNRDxf/ePgyl68DSunGN/DtPq38wS5PHCQFnPZlrHpuLcr4Ycd+sFKNKoBDfoIi4/Ro0zaZBaohZtcpfc+kVEIdzabKeClqRfTeP/Vqz4V04yvkrpG052jJlpgAqpe+5rfGwH1E8LM6XrJpwJmaorNu9FYTR7pTc1Vz8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11361.eurprd04.prod.outlook.com (2603:10a6:10:5cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 07:18:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:18:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 11/12] net: enetc: add PTP synchronization support for ENETC v4
Date: Fri, 11 Jul 2025 14:57:47 +0800
Message-Id: <20250711065748.250159-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711065748.250159-1-wei.fang@nxp.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11361:EE_
X-MS-Office365-Filtering-Correlation-Id: e02b827c-4aaa-451f-ae5e-08ddc04b1a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Je+k4cnW8WoxfQ6yeO5LbgXcYFviOstJ3+0dhL5y6U+u+z0jmtSO31Y5VTY8?=
 =?us-ascii?Q?7P1csOjjSnECS3+EPaDG9Tvw+DuEKdWsWJ/btX2aEhqWVz2r0nzxS11ITkV2?=
 =?us-ascii?Q?l4IoxJlJvC8tDU1e5TgcH5YVqmGaj88+lAMp9VF1028Wb367ySyRNyjcXRNN?=
 =?us-ascii?Q?xQ4FRVFAOcFImviKU2FyNGSM+wfdBVQ7cPWYe2IidK9a0pSDCfvsTs2LBS0/?=
 =?us-ascii?Q?T/WlURaADvWhd0HT6vX+JUnsjOzeSq735KitdDvZzxY3hJaaL6cNoT9QQNsN?=
 =?us-ascii?Q?66TGRo60F1Xys2nNLui5KEwTNKD15ptql0ydF1BRAPS77WRd+yQUn4j/V8qN?=
 =?us-ascii?Q?RDMq3ukMDaZtenZP5JvU8OukO08ec1oalVdzVAks95QOcoGU3weSDFn/+TYo?=
 =?us-ascii?Q?pghtqWS24J/mRclFF8EmGaQ7Z6i8LdWMYHXuf4+A9sZbeC2jMJ+v1GMn3G0E?=
 =?us-ascii?Q?Ck5LrgdVe/xuLXKjwFZea9p6V5mZK3frpIxzU2W1zcrBALeeCkzcOCabmUTK?=
 =?us-ascii?Q?jIFt/GRdT+Z33Mz00D0VS1Es24ymHQPO6O8tX8Dq0I6BbE05WfPxI/M+rWtB?=
 =?us-ascii?Q?V0ct1QBQp2Q13Via29baEFyR0ZZbQZam8k5EpbjqzuwIjNWAPOuDYBCReMG1?=
 =?us-ascii?Q?77TncoMOHTj7QQCVcp+NgPfSFUmLP39Q0yyTOhNQUmPLsiN5oB6rn//MyhBr?=
 =?us-ascii?Q?xgg1W9TuthAkQvArEtWs/PeoAsAP/ZCRxXmKkjtfejiBsShpVf74T21/l6g3?=
 =?us-ascii?Q?0klFFAX+x8VrsxzaC7E1RfIqEShe2NzITZLgoZjYtUmlR7APFB7qlFRU0TXe?=
 =?us-ascii?Q?S+l/bXeLBm8VNlUGwf81WVQy7vr3Vli1w6qHUG+tUwQYYp6N/B5iDnb23wpb?=
 =?us-ascii?Q?Ye2RioYVaaAWEhzsiXlsH9gYlqIbkWRMYJtDJwuKfdcXoq4EQOBUT58DMyEC?=
 =?us-ascii?Q?DwQPRfiZh8wXcGUjg3GcnXGgaWrSVXPgLFv40LJi6UH6qxW7b/ncJs9idH5d?=
 =?us-ascii?Q?cGc/G2nzT6iMKg1fr5Vq38tS+bTGCYtaOA1AsAZdUMwPHdHnB1F0v1hRepHh?=
 =?us-ascii?Q?CxRoLFsuNClNqrIIXv2J0DvYgWMVxeYjj7ShtFp1jGFF969A+WKd02uhUMoU?=
 =?us-ascii?Q?fp3nlRUqqqBS3AOpp6Ubiv4inOeRaIeJNl6EHk16UXWUYrjo/tlA/PlhGOYQ?=
 =?us-ascii?Q?zFxb08H2MqkAXaylpxqzc6fFS0uOEDU4vD3zBK+05P5M+fgCakUxZMbVXNK1?=
 =?us-ascii?Q?EL9rRS3j5bAzzSuSopXs3xllsIDiY3ForNK6Z0LZl6U3AZm7eD2bPWZTa/Y/?=
 =?us-ascii?Q?5UVwAhZn3P7jmIv237kuM3BJ+Mjcb0tqifaCcCzAAm+2Kdw0oCY7HVxXedUN?=
 =?us-ascii?Q?QVYuWR+bT/RxNv+Hz/KBHrL5tI4k6cQRHl4BmMNv8g2Zqi0KzfoaKkBTBG0U?=
 =?us-ascii?Q?vpZ1frh4egORRzVd+wGt5wy6Is8Y1vdI4SHE4BaJ3SdS3oSXo3QmyjhGOK8c?=
 =?us-ascii?Q?GNQOvZaHJ9TrwxM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mCPsmBzPWfbfRi9IAYYSEZdKrP06WZUm6arcEiYKZ1v7DttwgO43uHic+gEV?=
 =?us-ascii?Q?toM7R0lodCYBBmV1gwu+eiot32JNOE+iZn61N5TSqIJpbRAB1+awl+H8nHo2?=
 =?us-ascii?Q?XU+cloDwRd2Rs9cyFrhKq0OV+9kwfXC5zCsi12gJ7TUnj4qGMwdl56OSj6Rk?=
 =?us-ascii?Q?Bi5fWRM8h+RwfzfCcE2er+ylTWaIX9oFKwNSTof2qjQIQY06Oljl/6rN20f4?=
 =?us-ascii?Q?+zOgW2YIZRkekGkpG54s7gu18buZyHlGaywiqZ04Xatn3jlqs1CCKwDycjHN?=
 =?us-ascii?Q?cFvuw2SMKl5Fd8fMy5veM8vLWSz0ea8C+dAsvdxdRQ3fbOVPp5AVPz2P8BOi?=
 =?us-ascii?Q?824NM5WqKpkdp8oeAuSiPzTEPPv2sJKsfov/SCxyA75RA1m66Kh7ljsX9j8w?=
 =?us-ascii?Q?UAjT+CSxJrp4p2LkXY5lEaBjKNFJJDxa3zzVohPLFAucAOokfBIHPkkmuQU4?=
 =?us-ascii?Q?WD0x+YMcH1mYMc5i/hhNeFv/u42T1P/3fJF350xjOGXppDdu0dSAjxd1hdsM?=
 =?us-ascii?Q?zUbRiD+eb1VQlkmrjtSZaQm93kK/HXKPaVLHEq3PXrH+kB9d5F6aARji9ueV?=
 =?us-ascii?Q?Y94SHwzTpuFCPVoWuBlPjMnMDOhtIk2SF9+elNdDB5a9kRVXE87mcnFUn/4X?=
 =?us-ascii?Q?Ku8w1dACQvhrIr+8xTTdVuL3i3gK72NED9y96sJ4P33o7235U236JLrqpeRN?=
 =?us-ascii?Q?9G7SFtQraXbuRz4p2XRd4RcaXz0D/pI9djWOzJ0fEqdM/wb9CN5y2/TpXyrL?=
 =?us-ascii?Q?fyMWe829Sf1Uoi/Vk9diLAlQqfmFYQap1pRFt4DYuA81GWR2cnrj+yyRlHCk?=
 =?us-ascii?Q?Q4jkKO7C+dnX0Pr8aQ5QjkfEmFLjwZ+sEDFFzpjAmOLhMnp79IslrMaC81fX?=
 =?us-ascii?Q?Vu/Hj+G4VTmPcIQIPOLwTrsA+QIUN30JojmNUaAHFU/d+uVv47gFRaAqkQoc?=
 =?us-ascii?Q?157OkpOLLyESy42a5fTDBwn87kcdtN+0VQgCXckGFVsi/VR8YwqvvKEM8tjW?=
 =?us-ascii?Q?SoU+vOnAdo77Rf0z4uRvlkF4eXnUPrQP5HfRFXlOUcq/h2dHu14Aq7jyWzuX?=
 =?us-ascii?Q?qqOXaodHGjRS1HWfrppkd2u/VLllz5UdpByIbMZqN8zRzqD3InUklh9GRkdv?=
 =?us-ascii?Q?h7xAFP85zimVEyWQ856WKlwlB4IrcFu4Mzbwg0jczhUaN+CrWVhQh8mZNbpD?=
 =?us-ascii?Q?9yHgsG5Hw5Zhttt3YPRp1jqp/+1+kHNvbPGiLI67kDFPG66AWaq73acZybZZ?=
 =?us-ascii?Q?zBx88YL6CEHm5qBc+O1v+KCZ8h6RdzXIxPreF7sesOREvFMXl/ZLj3gpmHyP?=
 =?us-ascii?Q?tsa7WtH7/ciufs3lh66mcSjJS31pqO3PEisDZVTirpZFCWTj1Fdx3XIUxecP?=
 =?us-ascii?Q?ENN0ayhfpPG7QBpmLjg9K2mkWLUioKIkXHlog5olE+wnmSFYKgzhtuyd/xz1?=
 =?us-ascii?Q?OHAKKild64ziIkk5/hHuj65OXTLXZ7Vpx7OwjGb2yqhxFgYZ9CaCBdrNs68Q?=
 =?us-ascii?Q?alpds9VHWB5S157RDemDWI1nNTTMl0hdSxLlakY4LlpdqdIgU1BbUNcDO1YZ?=
 =?us-ascii?Q?j9+MvphKr3amo71fMlhCx4MA4JjIwqTVpnn9hoyW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02b827c-4aaa-451f-ae5e-08ddc04b1a18
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:18:15.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsskHTfiY/FejQ31vqtIH11ZxhslNvlUuj8PJxosof1g2lUfdzBOpF8z4T9dLAeeYk1vS4esrKTrVJXkrtFFPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11361

Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
mainly as follows.

1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
different from LS1028A. Therefore, enetc_get_ts_info() has been modified
appropriately to be compatible with ENETC v1 and v4.

2. The hardware of ENETC v4 does not support "dma-coherent", therefore,
to support PTP one-step, the PTP sync packets must be modified before
calling dma_map_single() to map the DMA cache of the packets. Otherwise,
the modification is invalid, the originTimestamp and correction fields
of the sent packets will still be the values before the modification.

3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
register offset, but also some register fields. Therefore, two helper
functions are added, enetc_set_one_step_ts() for ENETC v1 and
enetc4_set_one_step_ts() for ENETC v4.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 55 ++++++++++-----
 drivers/net/ethernet/freescale/enetc/enetc.h  |  8 +++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 69 +++++++++++++++----
 5 files changed, 112 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 4325eb3d9481..6e04dd825a95 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = ENETC_PM0_SINGLE_STEP_EN;
+
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
+	if (udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	/* the "Correction" field of a packet is updated based on the
+	 * current time and the timestamp provided
+	 */
+	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);
+}
+
+static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = PM_SINGLE_STEP_EN;
+
+	val |= PM_SINGLE_STEP_OFFSET_SET(offset);
+	if (udp)
+		val |= PM_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val);
+}
+
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 				     struct sk_buff *skb)
 {
@@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	u32 lo, hi, nsec;
 	u8 *data;
 	u64 sec;
-	u32 val;
 
 	lo = enetc_rd_hot(hw, ENETC_SICTR0);
 	hi = enetc_rd_hot(hw, ENETC_SICTR1);
@@ -279,12 +303,10 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 	/* Configure single-step register */
-	val = ENETC_PM0_SINGLE_STEP_EN;
-	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-	if (enetc_cb->udp)
-		val |= ENETC_PM0_SINGLE_STEP_CH;
-
-	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+	if (is_enetc_rev1(si))
+		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
+	else
+		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
 
 	return lo & ENETC_TXBD_TSTAMP;
 }
@@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	unsigned int f;
 	dma_addr_t dma;
 	u8 flags = 0;
+	u32 tstamp;
 
 	enetc_clear_tx_bd(&temp_bd);
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -327,6 +350,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 	}
 
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+		do_onestep_tstamp = true;
+		tstamp = enetc_update_ptp_sync_msg(priv, skb);
+	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
+		do_twostep_tstamp = true;
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	count++;
 
 	do_vlan = skb_vlan_tag_present(skb);
-	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
-		do_onestep_tstamp = true;
-	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
-		do_twostep_tstamp = true;
-
 	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
 	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
 	tx_swbd->check_wb = tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
@@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
-
 			/* Configure extension BD */
 			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
@@ -3314,7 +3337,7 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err, new_offloads = priv->active_offloads;
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	switch (config->tx_type) {
@@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index c65aa7b88122..879bc6466e8b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -611,6 +611,14 @@ int enetc_psfp_init(struct enetc_ndev_priv *priv);
 int enetc_psfp_clean(struct enetc_ndev_priv *priv);
 int enetc_set_psfp(struct net_device *ndev, bool en);
 
+static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
+
+	return IS_ENABLED(CONFIG_PTP_1588_CLOCK_NETC);
+}
+
 static inline void enetc_get_max_cap(struct enetc_ndev_priv *priv)
 {
 	struct enetc_hw *hw = &priv->si->hw;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index aa25b445d301..a8113c9057eb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -171,6 +171,12 @@
 /* Port MAC 0/1 Pause Quanta Threshold Register */
 #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
 
+#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
+#define  PM_SINGLE_STEP_CH		BIT(6)
+#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
+#define   PM_SINGLE_STEP_OFFSET_SET(o)  FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
+#define  PM_SINGLE_STEP_EN		BIT(31)
+
 /* Port MAC 0 Interface Mode Control Register */
 #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index b3dc1afeefd1..107f59169e67 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_set_features	= enetc4_pf_set_features,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
+	.ndo_eth_ioctl		= enetc_ioctl,
+	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
+	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 961e76cd8489..cf33b405e76c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -2,6 +2,7 @@
 /* Copyright 2017-2019 NXP */
 
 #include <linux/ethtool_netlink.h>
+#include <linux/fsl/netc_global.h>
 #include <linux/net_tstamp.h>
 #include <linux/module.h>
 #include "enetc.h"
@@ -877,23 +878,28 @@ static int enetc_set_coalesce(struct net_device *ndev,
 	return 0;
 }
 
-static int enetc_get_ts_info(struct net_device *ndev,
-			     struct kernel_ethtool_ts_info *info)
+static struct pci_dev *enetc4_get_timer_pdev(struct enetc_si *si)
 {
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	int *phc_idx;
-
-	phc_idx = symbol_get(enetc_phc_index);
-	if (phc_idx) {
-		info->phc_index = *phc_idx;
-		symbol_put(enetc_phc_index);
+	struct pci_bus *bus = si->pdev->bus;
+	int domain = pci_domain_nr(bus);
+	int bus_num = bus->number;
+	int devfn;
+
+	switch (si->revision) {
+	case ENETC_REV_4_1:
+		devfn = PCI_DEVFN(24, 0);
+		break;
+	default:
+		return NULL;
 	}
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
-		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
+	return pci_dev_get(pci_get_domain_bus_and_slot(domain, bus_num, devfn));
+}
 
-		return 0;
-	}
+static void enetc_get_ts_generic_info(struct net_device *ndev,
+				      struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
@@ -908,6 +914,42 @@ static int enetc_get_ts_info(struct net_device *ndev,
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
+}
+
+static int enetc_get_ts_info(struct net_device *ndev,
+			     struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+	struct pci_dev *timer_pdev;
+	int *phc_idx;
+
+	if (!enetc_ptp_clock_is_enabled(si))
+		goto timestamp_tx_sw;
+
+	if (is_enetc_rev1(si)) {
+		phc_idx = symbol_get(enetc_phc_index);
+		if (phc_idx) {
+			info->phc_index = *phc_idx;
+			symbol_put(enetc_phc_index);
+		}
+	} else {
+		timer_pdev = enetc4_get_timer_pdev(si);
+		if (!timer_pdev)
+			goto timestamp_tx_sw;
+
+		info->phc_index = netc_timer_get_phc_index(timer_pdev);
+		pci_dev_put(timer_pdev);
+		if (info->phc_index < 0)
+			goto timestamp_tx_sw;
+	}
+
+	enetc_get_ts_generic_info(ndev, info);
+
+	return 0;
+
+timestamp_tx_sw:
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	return 0;
 }
@@ -1296,6 +1338,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
 	.get_rxfh = enetc_get_rxfh,
 	.set_rxfh = enetc_set_rxfh,
 	.get_rxfh_fields = enetc_get_rxfh_fields,
+	.get_ts_info = enetc_get_ts_info,
 };
 
 void enetc_set_ethtool_ops(struct net_device *ndev)
-- 
2.34.1


