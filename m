Return-Path: <netdev+bounces-133064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B39994651
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1503E1F25F86
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853131CEEAD;
	Tue,  8 Oct 2024 11:14:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6E518C91B;
	Tue,  8 Oct 2024 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386099; cv=fail; b=CYQ2Y8TCyrcuLuzLgvM2JE1BZHFAxe7pq+vA08Jd5AjVqnu+bisKNEOOHaACtVNeGTH9SWkHvYApMntr+jY+k3VyfoSvhF9mBmME3rpeV51yjSANqKFLdrMGyZjQZsv/b1CooxF+eDvd0BZ6amRB9lUgchCqjNeubm1OEZuICI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386099; c=relaxed/simple;
	bh=2oQR0AavmINpCsu0s6TXmTpO0FW3LmjPUxlNJd29y0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jvXOH2w6nU6EqTCaJ61XftgyXnuGz/N8LlhzwEQ2nohwIc1L9CbJiyQFHAFuOGpirGRQf8O1Nznnw3FXXwGMHtCtWFl/jUC3a3l6zKJnbp+KurcQN/NK3JDTtJPsNaybJ2uGH3uVudgZuIvRuD3PxaVUwnQj0L5EsRjPLaoo5k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INlcg5QIQNOM1tGFpfAy/8DWrBGqskB7TxU/FrqpGJUmqSNRBUajbFQcGV7FvFirE9f81lmelHdAgH0LCgFWI5fny8EA2NN7PcKGUfK85Xi5DwzjNbdUjEzWLn6qWMFqu1LIwG/Z4jeV2hfqNFBqHjK90nxd82xofeHF3+VxcqgWJzDX/qEpty6PeD59AZBkvhW2nxesV34lsdYQQzAQpN74qqtjU90AnQwdwokP/toPqyZhzhT8aGTiwfS8xQ6WFXVAGh5k1hy5Fd2hLOTAtLWPeANd+0Wvv+GCC5NyY5E3574jYfmmQnzgeM0m46bJ/YxLQ8YYFC4VEf/T5IrZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jdt8+2f9OFteckO8x32hLGOtZuJB4TbXJN2FXtkqkus=;
 b=Y9ZiM0M08pHppJxEzniIH0wWlnXNuqKuYN1h1LDBEypSpE4xQmC/Vw/gxhnxce/kgZ95GD3CfJjTQnKIMS8/oB298rUq81LP3q6ikxcX0AaOZLCUQu2FWnWYYTO6DK0rlMJaIhK3H2UouVdTPRiQmlQUWFlxIBkbja02TUZirHgo/pOFnszrjRhBEtjclgtC5GADv7vpM1O5nOmz8FpkWQIih0svibF8zJHSyOGrW7TztrJpkNVxR8cbnsS0aDMGxpW2SxGmjSbxM83wBPe9d475DV3DvIsxb/m6MAxtFcATxYF47jAC1jertciOarUgrB+02mb01NVr8HMZtbVo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0718.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.31; Tue, 8 Oct
 2024 11:14:52 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.8005.031; Tue, 8 Oct 2024 11:14:52 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH net-next v3] net: stmmac: Add DW QoS Eth v4/v5 ip payload error statistics
Date: Tue,  8 Oct 2024 19:14:43 +0800
Message-Id: <20241008111443.81467-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0718:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f03d98f-429e-4317-ca48-08dce78a6e5d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	ZFBbELpTRizk7ivNWeED2qixav0vhP9fnCTYHQmz/IkmLkdN616LuUh0zeFIDofDoh14FwK1x9xbliBylIaNJikogvVx9dhkrw8cK2rdL7h2kXK37gxcrBWwUSOnVtPZWIfJ67m9g+6cM4q/Ujax3oypwUgA0sBUQhG9SmM9Nf0cU01p5wdaGi0RZirVqh+qmoPFnzlvOMn7ISVpPMB7GhBYDa0q9yLeCEVW1qhy7zK/OqSr9E9l53BkkxNEq44lZo411jnOYMSg+sts32Ui8R2yuVSexVN04aSz9S0FA+ZFktiwpOzHYKwaJAs/6XTZu89To9WKqRfmGfSZspRisVhNWlp60xPAKCdIZN00xAFKypNPK+Gz2H+j3leBsnBpnfMjq1OBlvCddnSxMSvWBXLJfxHBWvpkikuk9qgCKwMY7W9erRMkWOnUmaKMvVJwZaPHtrXcnCQ8qzrEwrHJ/mKb/iwwmnzlUe2TEslzvSCQgt2CbYyEO+etqc58k3Lc+ksCzjrRKMTROdpebFcNrr2uHH4f50AiFcb3g48uarr6BfydvJyhCaJiVJnX7RlRt81WhE5zt5kFd9twdgxlbn2H/ILtPt9x6wAxKMp++bgstntscTEhN0jLyyMUP3Fs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ezEbAHGIeJPGsEWYbIOtha9e0t8z5lMBUYyae7c5V8VO8ka2L5o4m8h/Abmc?=
 =?us-ascii?Q?fFENjLmNRn7HqTNQ2hU/sAtlRoaHaPv4jjxhpHFLjbczpgc+gjsQyuYtiuB4?=
 =?us-ascii?Q?abiGHiDvF02HGt4niFCmLNWUI51lalsaZCPAJNEL8L+NTArAG/JXR/PuvFnX?=
 =?us-ascii?Q?ltQxXilQjmm7mmn55YPogXFakrbcag2n6SbINSg4+025+a36oIAJGnrvq5Gy?=
 =?us-ascii?Q?e+V3KblZauJBAxs4DNGQbCPKncraw/oTtRQaijs4fsHImDugrhkwiH7zCa49?=
 =?us-ascii?Q?xHFCImULUUHOT/WtFsQBg/A5Gy6ojTunurHCb3DxDXOzZksDP5i2RM4GFRIk?=
 =?us-ascii?Q?oIMa/NF8OZmUbrd8mc/cXFfJrrGNXWrq2nsxhemtFplzS7w64+5LzPNDKLpC?=
 =?us-ascii?Q?MQz5zC4HfhyY3HN0UVZofGiTEs2ngXwYRjYK7K3lWh7/TzEWiNIoqgEf67ep?=
 =?us-ascii?Q?4fMj5sFXwdmbB5qMguLmlQIeVwn70OVmHCdu1mPd9T/DEh5bWe5lN30hbbTZ?=
 =?us-ascii?Q?ixTf9b2Z5HBYK8qbZAMDD7KxeZQ6mmh/bm2gkTbGjKnc513eRVle/AIFfe9+?=
 =?us-ascii?Q?EDY9Vh0gix1vR0GLpqxaPGFPpdOP/HLt6uPnfxH69OUzbUy5xEhSH7D2Ro9l?=
 =?us-ascii?Q?Mg92nEbqxguK9Gh10qHqMFn7flQSwxLUvzgHuFke1+Z+uxRGVpncO0Q2WgX/?=
 =?us-ascii?Q?trl7jw6c+gefQjE3YXPhK+iQF+4ljUw6HvTRip/6kczmWUpz4BugQf34Ozac?=
 =?us-ascii?Q?74dm1JtxNuZvVd9jTxpih6IFgKl8R0I5u56+R2xclwauFceHatxDpj7uy8NA?=
 =?us-ascii?Q?nLprIIQINbalgnS0GBgtkmMPQ4xV0tiBySUD43RO0mdBIxPVa50LczOE+00v?=
 =?us-ascii?Q?SODw314+ElW1lYZXZ7fTwhfqzKrSHVhmrgstAKJvjrcNMyXvD9zIoQoBK6QH?=
 =?us-ascii?Q?VQqXuGl3hl6lJbruZmZkAMAvAfqstw1XCz6s4HqnSEn7aaob2tHeLXITzNxY?=
 =?us-ascii?Q?CpwffaKGVLWGBxlORvyxGKhrMAcxJVxgIFgg/iPUO5xeAXsY3DIFPtRikt18?=
 =?us-ascii?Q?llk+lXCAJRoHLcTYTAEr9EUHzPh4DSOGa4QKXD1oT30LIF2uy7q99op1G4F7?=
 =?us-ascii?Q?B0gYxyhGBeJKxS4lgu7hGlEH7OWQ07SnbztUOpYeIzlgk6kYfQ+McGcXnJ5v?=
 =?us-ascii?Q?aS9ukB53wx8O5f/JAI8WitwXHwxrf3/DcV0Gr5644KHUPoA9XxdP47JtBrer?=
 =?us-ascii?Q?HaqvyFRyYfZ6G+ZXBJnP9BcVl2Ui3jeP5/56ZzYGoYL3ZYpHu5rk/ZEjTWYl?=
 =?us-ascii?Q?afpPC37atQQ/2MCwL4gM3+xkOhAyCzL/NrAVQBtZIz/1gBVcAR/As+tgQ/JN?=
 =?us-ascii?Q?z5I3w3WQaJYYPYqYE5WaDeCNItHNTic4Xw8VQGXAtZ68JMWVqQaW5NSR0zz1?=
 =?us-ascii?Q?sdMo7Qjr5/elbJi6YYkAROTvCPRR9MHKNJAjMQm0jfXXBTh4y0P1dv3marzD?=
 =?us-ascii?Q?ADmKauZ9GU6VUy30d/kB+RBwgPOGJ0CIUIDGdI11uyNaqRKfM7RaVJEWPp4O?=
 =?us-ascii?Q?wbQ5IXNMEnODw4EO2E/neTIKfiA0IQlR7POmucgoQtow+qXqI3E84abLVxYA?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f03d98f-429e-4317-ca48-08dce78a6e5d
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 11:14:52.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MclU9HpPgnw6MtJU4z3SKkWbK4tNCsvC0pqJe/aerAJy7vxjtf3x7gtZQ+gtudd/VXYIffLOOEktSJzfV55wltmsn+Ftu7h8UmiIEW+KAqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0718

Add DW QoS Eth v4/v5 ip payload error statistics, and rename descriptor
bit macro because v4/v5 descriptor IPCE bit claims ip checksum
error or TCP/UDP/ICMP segment length error.

Here is bit description from DW QoS Eth data book(Part 19.6.2.2)

bit7 IPCE: IP Payload Error
When this bit is programmed, it indicates either of the following:
1).The 16-bit IP payload checksum (that is, the TCP, UDP, or ICMP
   checksum) calculated by the MAC does not match the corresponding
   checksum field in the received segment.
2).The TCP, UDP, or ICMP segment length does not match the payload
   length value in the IP  Header field.
3).The TCP, UDP, or ICMP segment length is less than minimum allowed
   segment length for TCP, UDP, or ICMP.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index e99401bcc1f8..a5fb31eb0192 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -118,6 +118,8 @@ static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
 		x->ipv4_pkt_rcvd++;
 	if (rdes1 & RDES1_IPV6_HEADER)
 		x->ipv6_pkt_rcvd++;
+	if (rdes1 & RDES1_IP_PAYLOAD_ERROR)
+		x->ip_payload_err++;
 
 	if (message_type == RDES_EXT_NO_PTP)
 		x->no_ptp_rx_msg_type_ext++;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
index 6da070ccd737..1ce6f43d545a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
@@ -95,7 +95,7 @@
 #define RDES1_IPV4_HEADER		BIT(4)
 #define RDES1_IPV6_HEADER		BIT(5)
 #define RDES1_IP_CSUM_BYPASSED		BIT(6)
-#define RDES1_IP_CSUM_ERROR		BIT(7)
+#define RDES1_IP_PAYLOAD_ERROR		BIT(7)
 #define RDES1_PTP_MSG_TYPE_MASK		GENMASK(11, 8)
 #define RDES1_PTP_PACKET_TYPE		BIT(12)
 #define RDES1_PTP_VER			BIT(13)
-- 
2.17.1


