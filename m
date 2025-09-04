Return-Path: <netdev+bounces-220104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EF1B4476A
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501285807B3
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E802874F0;
	Thu,  4 Sep 2025 20:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JFSPxkeU"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957A2874E4;
	Thu,  4 Sep 2025 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018161; cv=fail; b=a82NfoVP21QvYWh/lGHVmmEfQ+Q0o/FM7flhSqn/j3W7/3zLuS/uPLkbTRQOGvf2wh/KpA6/sqPkqGcl4t0uPXTNdzztJbaL+Q12yiQXc/h3UE2XnuE9SJ5h8otd59dslULJv9orwEFMWwuN5NmE8OMqQ90z/36UAK4dApIFCz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018161; c=relaxed/simple;
	bh=kVy0DAfq6ngT4ut5gin/k4gdv2zh/9yfeJcPDnVO7a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M7kWvF+J48M92n7RLDDyCWvr+a+sWIcFr7znpQq1mfWIeXDzLl1tslrIzxGhe0w7YFv5pls3JpQqSpyXfqti7cBXvU8hYCFCqLLhKm6OtGBRFPiExzzFsiDOnHU55ASipAtlW+Dr97F1svodNMjfrh754Dvn4OnSIxfH07YWWww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JFSPxkeU; arc=fail smtp.client-ip=52.101.72.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp/jCjGEzmqrnl7WMO7Hoz9XjF9mGlDS8bU6A4R4o86Fcx2EJoXsd6oh4nTAQipKNK2HzKI2ALmiHn0Dpk3rWhHh27zREnqJ403IG75l3n+WqgzvCFcLifxgxDycCA316xTB5g/6g5xC3LL0YVB/RZ95d/tyAxIKHROmkp8eg7n6uvhrBV99RcRW8a37E8ORCiuZjLEzww4ALrygfe6xyzXu5hQDBy8SAV14MGpWeJtsPsEyyjZXZoiYlOoGIRhQr2yc4ZrzJy5mqYLz5FTQ3yTnSZWYExaMjIyUN62MWscL3epqNQ3RIMKG5GCQ0KaoiSoyWj7jlQGlG9PL+6G2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRmEcC/nL0EKn7O0WbPkZFx5GLjdqJmtwU/zwsIRU14=;
 b=uIsey+tQAW4D5rd/nuo5qPxqmYTZLaG09jUx6zyf42GlVyI2sjocZgda3NVaIX/toM38xm5X+0QoUzwMNTkpK08d1dEUCXW4Zr7grSG5K8BtrLhyB0RRLp1M4P5LgGWr26Q2xNgvLl+WWREHDbSFw/8+SjajpQf5JXEt8tXzLEbU3QX6fru1Oyny7KZZnSlN22M+nvihGJZDYskvxc1uc02LRsBnM46zsVv7Y7CEbHFKxLUueUevASBmnl4F0F3GTyhHSC/4p0hW/7phb2bkiXRYS6CfSvoiEnz9PGrqS8tHrTFm6meaobcbDvT96ZXggQJX2rCYVC6Itxlo3Lcqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRmEcC/nL0EKn7O0WbPkZFx5GLjdqJmtwU/zwsIRU14=;
 b=JFSPxkeUKJ5pZyDXF40Bq+EWcrfOeu/pfOgDYVYGRy8Vw917yY7xslHkEQUpZ+2WUAaJF8EjxOvhDve705OkmhW7yDMGvUuEp6Qy26b8FHqIfZGZW2BKQ+m7EKyGTzZdftmREh4R6JEFL2MBrfImLJ4lQSv8xP5O8U8vQTOskWuXX/QcKUmjixu0d//y5OhYAsb1Z0YWnNZdqgAvhID3VKh35A9Ni5OsecETylXoFYi89iFZfZq7NApY9WBW1OLvwKfP8kL7CVIaecesSFUyuhbnJ1tTpqGqs1e90kpUZb7vr43BTJbBeJUKlEeLsMJ1IEXVqsL4M+APgNNNSvmNfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB10027.eurprd04.prod.outlook.com (2603:10a6:800:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 20:35:56 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 20:35:56 +0000
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
Subject: [PATCH v5 net-next 4/5] net: fec: add change_mtu to support dynamic buffer allocation
Date: Thu,  4 Sep 2025 15:35:01 -0500
Message-ID: <20250904203502.403058-5-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904203502.403058-1-shenwei.wang@nxp.com>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::8) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB10027:EE_
X-MS-Office365-Filtering-Correlation-Id: 86262795-53aa-4c7b-d3aa-08ddebf2a669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZWHkeBkUItfWCiQeEA1vZAuQwv49VPxDRjsa7koLqeE324JLYlzGBuTc4Qeh?=
 =?us-ascii?Q?5Hyf6+sNwnXG45qT6HxPILGLD1iLMRvg7lEOwV43GGcsLEduhYCJalHXNOcF?=
 =?us-ascii?Q?m9AeBTKH9KT2LOeIkUrKSelJOJklzIhY0CUWvYI7/+SG1Ir778teG/p6ZO/N?=
 =?us-ascii?Q?r4fhK1fDSGYmwyz+ROQxQjO2vM6PYiESLcrPHcKW0y2KogP0lwDHCxmXZ+sS?=
 =?us-ascii?Q?4UAPlXVdrYdHpgutKYCVxER+qugDwHQB7oMkYL5ToJMBxPTL9+vgz8bcvssu?=
 =?us-ascii?Q?sXa9x3BqBdbDm3j3TahH4vDwcQTP82+a2E2GJoDi6C3p7wq+7i0EqhwOKfC2?=
 =?us-ascii?Q?HbhluzVOSfmu3ZiRkeG+N7szXQRzU37gM3VeSp9kHuIKDq01hIyaKbX+r8sC?=
 =?us-ascii?Q?tOq0G6NvkeiWXGzikwPZO/i6OivD7XkYZzyKp+WL4r6kSg7RDzVm9W96VaqF?=
 =?us-ascii?Q?GkIuLKMM3DdQuIO7pYpRoj3ZeozJqgTNLgcnmu7acJ0YNm68trOWc60DD4mz?=
 =?us-ascii?Q?FQd47sphzSmJFK/lbST8XWqNCw+lBWeJKw7c8amylyd2cmqPW7qmWWsQ97UI?=
 =?us-ascii?Q?ICwFFBOBol+H0bRmUsg9hXpM6YkihRGYmNiICuXuLuYwDdKvIyadUyQ9S+s0?=
 =?us-ascii?Q?wpIwPyqRh+NOVVprnGXMvnevX7GoXKqOv/h+xFxHqNCb1eZH6saGA+2shrzy?=
 =?us-ascii?Q?NA+7lUBusNXUQ1FXvjr8YjrprbhkkIieIStDHo8sDhOTQqtZVMv2gjzMRULy?=
 =?us-ascii?Q?UhtGQ9U3h8eUiLmqUxhEscOQ1JKnR9EZEImtU7weuRDF+vZ3dMy9LXFf7Uf2?=
 =?us-ascii?Q?ZPqPCOc8NhmsiJtPk3JnTRf74zz0IKYpevOCQ+sJi+V9HTMqPqqjAnMMKQ8t?=
 =?us-ascii?Q?JFBQwIAjBh7jfFMjat5LtrtanZbSxslvqL3Z7/0t/1lgi+RnPbCBm23tGzCY?=
 =?us-ascii?Q?P+crxm2VOtH+ZYSzT827SShoNR2680iot8Ays9VVoG/LcMckcRerzGMrb5mp?=
 =?us-ascii?Q?RYfcnNUNI0jFziaqiGH/SDrfrWgS6qQvzPiKh1kq8txy0b7UwSbmgtVICpGS?=
 =?us-ascii?Q?83n3k+osXmFYJgvr21+NiUECCrFifOkj3aa3qs8ljVsV9ufoe5rReTEpnVEk?=
 =?us-ascii?Q?1FvsySXpMXUWgHYiA5VgdQZokZUYqPmowjumgMBINoSeQECI6Ia9cWz3rTqb?=
 =?us-ascii?Q?HpdPg5xM8qsZ4tP4l8O9jxnVSkUr2PLPX9quP1q8qRvKXIn3OP03PG90eZUM?=
 =?us-ascii?Q?rSa5/SbXgYnPCMGbnE/Idst/toF3b+r+5dsPA328dRuVPxYDVQ8a/94BGWD4?=
 =?us-ascii?Q?NN8UoTh7/w2jcw/Szmi9oZG9k1L8oNISBNBC9orvbq4HgxMVs8JD9bIlu7ku?=
 =?us-ascii?Q?EiWpPHgKgPlMaHtgZPCe7yKmIAoQBBMT5z4qEKZXELDZC7qkrnGlCjTV1owX?=
 =?us-ascii?Q?uUEGtQJ5q1FhOUBLhHcJYs+/a38tFXbyd9H1mbMwwdDNL3KDK3aNUlOGk0T3?=
 =?us-ascii?Q?nXzppkkbB9i2K88=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ib2HiPTpB9OoN5HlZSm1Viffjl7MTbiB0nQeuBo+bge8JVfkA/mH0Fcn89GR?=
 =?us-ascii?Q?2Xe1k5nOrJ4qd+CxXfQ8m4GEg4ikG0wpa8lrG1AiqXc8fUzb1UUOSO5sOU6o?=
 =?us-ascii?Q?VG5gnh9gLz/yphGO5yD3H+e6kep5+CZ7pcPvoGXX6/0zIyB0MERJfW2Al/L8?=
 =?us-ascii?Q?93Z/hdBHd+I334qKyBlrZ90GWDKecSFk4DRaLACEaa18QISJQSfMFy/8HFmf?=
 =?us-ascii?Q?fDSe9wVfAwOakUawmAa9kUzowoAHFs6E5w7IQV2gckDlVdyTYQoy7hDdP3tW?=
 =?us-ascii?Q?kXiRgBO2d7Q7UMaq63df0x82gbbd2/amp6zEnXjA6gRULrzMGzqW1kBm1RDR?=
 =?us-ascii?Q?Tw2IbvIW1dv7tbGYZh5GOHWA7OuCIh/3139CjLz828MEynCFwhUCKCmOr5jd?=
 =?us-ascii?Q?o5S0FwzgjWg1gSExqeb3uqZZYJFXktlNeB6qzpEGWxSWmQOsrcTclHoJuNAE?=
 =?us-ascii?Q?IJguW9xApdux3TtRGxdZhJ7pXUr6iZGUv8BOEtAlVGWEj9X5UM7QLs7hFz7B?=
 =?us-ascii?Q?FY6pvu9qVLZyb5eqSjafX26xoO9FYVhSaj64FlESu7BvOsg51NfbK3iwUKRG?=
 =?us-ascii?Q?Yc6X50X5+D0qcUtIi0eXvNU3YQc2BCgwDVJjc7Qz4nDl2YxKkousm7a7mjKh?=
 =?us-ascii?Q?zk+1nQ5XphNg58O+c71fGQNi5zNIyDKhB69Osjb9gwIMsLafmNvbS1/Eoy1R?=
 =?us-ascii?Q?XNDsCZX0910QKFlODlefgbGpw7fhHBEI0uM7i0YbpA65DT3y2B4gaq5UPvh+?=
 =?us-ascii?Q?9LinHd9viIAAb7qtId+w88QdMD6Y7o4XSWHFQdpXAsxbrt9Su95iv9Imck1k?=
 =?us-ascii?Q?kHJa9uG6IuOG+pAe1Nqp8O194Sv0x1RzwW/IfNQ0S0fo9kbOdWT1dGc5kb8Z?=
 =?us-ascii?Q?u8t0g+zlrj1lBfDFhsu0aquEdQbn5N2/eo7+ATvwt6b8kX3cDBlZHrfpQCFr?=
 =?us-ascii?Q?Dtxbbcev0UNCXF83J7Jb6PrphLBNXzLkmi7PBZ+Ofgopg0uPiTQjtt6D5YnQ?=
 =?us-ascii?Q?WOzWaoe1MpAY3vW/8px1O0bOAQ56rYczYMVCHkhIS1VxAh7GAS/aVEqZv1ZG?=
 =?us-ascii?Q?GEBOA0UlcNhWnWLdZsgxx1teaWjyNe3pJqCvY2ElJ60rPwsFxndZ4qBrZG/a?=
 =?us-ascii?Q?wQAKTrWGGZadwj1o57EuUohExOj942YmnnZkBzcJy+g5S3z3ylvW2oEIY6+l?=
 =?us-ascii?Q?AQHix51Q28sEvTa6gbRF9dV/V4Sy6f6aAPEt8lhFNbniiLG+k4CL1e/MDDQx?=
 =?us-ascii?Q?r0iO2Ml2ikIRziSozO5XB/fb5IEEe8plHNgaxWnU/v5toG9rvkfuk5T1zKKW?=
 =?us-ascii?Q?54R9Hgh/w8ybDndlZkgqkbOIuPnkh0jz+RX/ttuA9Ww27d00TNcrdAZIVGN4?=
 =?us-ascii?Q?drqBJXc2swJf/LUmSUnEKGAPmhothILQ4rty+xT2aMdF/e3g1VURCNwhA2Kg?=
 =?us-ascii?Q?FzsULEbw4NUwHjgLa140ItsxQrd7hy/G6tgxLuw0krHTGkGWbxP5LXM/uJVZ?=
 =?us-ascii?Q?haf69e2eflub2HOVZee7iYaD3G5xVKXvEKzUX1rL08UI0ltQEZo4hIWZIiOj?=
 =?us-ascii?Q?ums2M+AwJ29chtrhXcwVuy1j+/mvKa+0mg1L/d+D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86262795-53aa-4c7b-d3aa-08ddebf2a669
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 20:35:56.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaAv5QK5j9pIYhzwK80RFUg7wRtbCc8qBOFnFudT7wDscKQHWvgynSZOwYVpsaWrPsiDJK8UyxTZDJ7vrO8u/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10027

Add a fec_change_mtu() handler to recalculate the pagepool_order based
on the new_mtu value. It will update the rx_frame_size accordingly if
the pagepool_order is changed.

If the interface is running, it stops RX/TX, and recreate the pagepool
with the new configuration.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  5 +-
 drivers/net/ethernet/freescale/fec_main.c | 57 ++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index f1032a11aa76..0127cfa5529f 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -348,10 +348,11 @@ struct bufdesc_ex {
  * the skbuffer directly.
  */
 
+#define FEC_DRV_RESERVE_SPACE (XDP_PACKET_HEADROOM + \
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 #define FEC_ENET_XDP_HEADROOM	(XDP_PACKET_HEADROOM)
 #define FEC_ENET_RX_PAGES	256
-#define FEC_ENET_RX_FRSIZE	(PAGE_SIZE - FEC_ENET_XDP_HEADROOM \
-		- SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+#define FEC_ENET_RX_FRSIZE	(PAGE_SIZE - FEC_DRV_RESERVE_SPACE)
 #define FEC_ENET_RX_FRPPG	(PAGE_SIZE / FEC_ENET_RX_FRSIZE)
 #define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
 #define FEC_ENET_TX_FRSIZE	2048
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index cf5118838f9c..295420d2b71b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -470,14 +470,14 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 {
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	struct page_pool_params pp_params = {
-		.order = 0,
+		.order = fep->pagepool_order,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = size,
 		.nid = dev_to_node(&fep->pdev->dev),
 		.dev = &fep->pdev->dev,
 		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
 		.offset = FEC_ENET_XDP_HEADROOM,
-		.max_len = FEC_ENET_RX_FRSIZE,
+		.max_len = fep->rx_frame_size,
 	};
 	int err;
 
@@ -4020,6 +4020,58 @@ static int fec_hwtstamp_set(struct net_device *ndev,
 	return fec_ptp_set(ndev, config, extack);
 }
 
+static int fec_change_mtu(struct net_device *ndev, int new_mtu)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int old_mtu, old_order, old_size, order, done;
+	int ret = 0;
+
+	order = get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN + FEC_DRV_RESERVE_SPACE);
+	old_order = fep->pagepool_order;
+	old_size = fep->rx_frame_size;
+	old_mtu = READ_ONCE(ndev->mtu);
+	fep->pagepool_order = order;
+	fep->rx_frame_size = (PAGE_SIZE << order) - FEC_DRV_RESERVE_SPACE;
+
+	if (!netif_running(ndev)) {
+		WRITE_ONCE(ndev->mtu, new_mtu);
+		return 0;
+	}
+
+	/* Stop TX/RX to update MAX_FL based on the new_mtu
+	 * and free/re-allocate the buffers if needs.
+	 */
+	napi_disable(&fep->napi);
+	netif_tx_disable(ndev);
+	read_poll_timeout(fec_enet_rx_napi, done, (done == 0),
+			  10, 1000, false, &fep->napi, 10);
+	fec_stop(ndev);
+
+	WRITE_ONCE(ndev->mtu, new_mtu);
+
+	if (order != old_order) {
+		fec_enet_free_buffers(ndev);
+
+		/* Create the pagepool based on the new mtu.
+		 * Revert to the original settings if buffer
+		 * allocation fails.
+		 */
+		if (fec_enet_alloc_buffers(ndev) < 0) {
+			fep->pagepool_order = old_order;
+			fep->rx_frame_size = old_size;
+			WRITE_ONCE(ndev->mtu, old_mtu);
+			fec_enet_alloc_buffers(ndev);
+			ret = -ENOMEM;
+		}
+	}
+
+	fec_restart(ndev);
+	napi_enable(&fep->napi);
+	netif_tx_start_all_queues(ndev);
+
+	return ret;
+}
+
 static const struct net_device_ops fec_netdev_ops = {
 	.ndo_open		= fec_enet_open,
 	.ndo_stop		= fec_enet_close,
@@ -4029,6 +4081,7 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
+	.ndo_change_mtu		= fec_change_mtu,
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
-- 
2.43.0


