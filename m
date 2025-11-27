Return-Path: <netdev+bounces-242269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A384C8E351
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422963B412D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4392232E72C;
	Thu, 27 Nov 2025 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Di3tDUtW"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93F32E731
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245390; cv=fail; b=Cu0zME2SRZO8pt36kWd1Z9Tr39Bl1h15nNbR4qhyj1Vb71rgMu9TIMZPxeZQmx5ne9s3sOAVErnbDT6h88I0RsXe5ml3dXUNfoi7VVHgjBfMb6YhHa+39clqWiWcBLm1Jc8SS/jryDO60fnQuEnbibceKEi0rFCRnP1qDAZNPN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245390; c=relaxed/simple;
	bh=brkMq0vCv3HNXT6EG269RjdiMZAvAu9BP0uaIUZT8GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSrBkVceRa0q+AqNkxgRZVBj4TwAaoWQNfkQQTRWW6l6c52sH3pWqBZbO1+4aU99kM0FkX6K8pwJwYWIDz3BdH9+1Zx4OhQXBIRXyfXNQys7W3nhEn6jrHDMu+83DZzY6Pw5uBBO2sU9MWmipbNKq3w/x4Cpph21/LByInTMOlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Di3tDUtW; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRcqszKK/FnyAScuy0zJ3DbQJD1QJ52COH/O69pJG4kj1NgiAH0LX425e1VinJyF14osTsuUQPhCzCJ1pBDQ8Jgsp5tflCvsPubMG6awWhsPWTc/2NDrf5Mb5OqNKnlrlX+3UFuk48z0l4Pnel47JIXIWYRQIjPvyibFpx3mOO9fTDmFCEaky7FKq/UKSuvpE8SXrEfZE8ZEKFtHWmFm7V4jdzyN7y3oVjpeZDOII6E71/12D552avsl7TuYjlEBRI00vIxgyfRf531IJjk5WS0YCP/1n6sWCRV0i410/8AV5IElANkW/0A/ciQ+KQ/27/dbtj0aRSAQHWtg4npxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKnen93waCF4e4Q2ZgUNE8OAqlhOnnj+Wr4aIxERQxs=;
 b=TOLpBIGMcC/g+qLpVx4q0gLQDsb5vWcKK9yYrLvuCsV7dScTnaA7ORtiovoNE5yxeThM1NFn+Jdvi14KxY4dRkzOSf0GKcT8jJhSdNxYiJ9v9N5qRvBCr+Q0WhfGrzo5TVKJBwaWc7Fi1w9lNmpUNBMY+vWbMCsen0C9LseJECLYbxbyVsPdpbiZLPM6F5T9G7e0LRyeUndjzJM1fubQrBowFoXPfxnoKd+DIbjr2RgaX9q0qRfREuj+LjROjHFIxgMSYoIlkjAE3fRZypRFsUj53x+MV7IcF5d73rNqY+dbu3JycgRZA/jVILD3bMNRZXy5sqOZiWW+G6drqmHHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKnen93waCF4e4Q2ZgUNE8OAqlhOnnj+Wr4aIxERQxs=;
 b=Di3tDUtWerT5lV7RCiGpWAec3i9wTGR9Er5RLsRH4ffLIPOZfWw0p4e4e9STitES8r6dvzxxTIu8s4/5M5Vfz7bAqIJ1UkPnQumGzAlXuLPKhJjZ9Dg48YPnB3UrFgyAe1cCfyTu2K3v0zpVxZlf3aDO9TNV4rJbeKPw6+2cwIsViJdB+sGM/mGVJB+LFRnBKoYrFD+Yits5iErUXwi9OJadSz5U7KX53v4TesLHiOVX0DY7SNaE4BhclQKW6CUF3CKM4tTKdVZqomnLzui5h+pFeg/YHEd4PN81PtenlXoexf+mHD43S3yR7gWC8DSiLjGi1UeEB7DNv/wi0jxhmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 12:09:33 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:33 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH net-next 15/15] net: dsa: tag_yt921x: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:09:02 +0200
Message-ID: <20251127120902.292555-16-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127120902.292555-1-vladimir.oltean@nxp.com>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11844:EE_
X-MS-Office365-Filtering-Correlation-Id: e78c310c-d309-4747-9dae-08de2dadd325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|10070799003|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F8hqep4XT8fdnEaR/SHVimGVIt2i3PPT/XsNydvas07+uCISA2tcKOgixYIl?=
 =?us-ascii?Q?RomSgm19v4pRcXgMFGF38znGApv46f14O1hyDUnAM35qXPRkjNjqgC6YBDZj?=
 =?us-ascii?Q?kOnzjV4gyK7kjHX7z+nOLXcJeX1L8XkeKN4TUYAkN5w0fqRZ8nKJ4yceqahM?=
 =?us-ascii?Q?cDgaC0izc0f2Lh8iWo2Zmc0FArXyQ/xaOIhCzEYoJN87vB4I23rMNlolvYgw?=
 =?us-ascii?Q?zN6nSgaqxv6aokHfQN4A20Kst6n/Qv/Otpa9erdj3b2o/hobcM1+9Q+pF6Da?=
 =?us-ascii?Q?QkhRHy+Jsu08i9ta+bfEkau/pvso/C2srW60ephE2E0Ypz30psdlv5zajwvm?=
 =?us-ascii?Q?IwQRWbGuPJGsJ+DpYM/eTPCOqUImNxCBUssqduPyDFGJU1Co9OD4rCd0FZQU?=
 =?us-ascii?Q?NxycK4JVIIkMoJx9oeuqlMFE/zoc0FqzH40LPODQif23U/cYLs/6KBJRiijT?=
 =?us-ascii?Q?EGxd1AJstH+UeFJ/ueMgtiNYvB7wewnwIVbqGKassNYli6SPl5JRwdoNXtJv?=
 =?us-ascii?Q?HRdFiBdB5zVLsl0qv3o+2d3M5XDHkGVs4/S1nbSdNtPYLnoX06OsBXkQCZOM?=
 =?us-ascii?Q?eIrigiVnB1COZ5zjMKvHwxac9pCwsdFdmMZEcMPgjGdF2hk1EOqV0cTTRs3G?=
 =?us-ascii?Q?Lbq5wej7mEqRY0mDEEQdA7VYQLJxpO4hB01SgV+pVCNymi4xA8s+BOd9y1Do?=
 =?us-ascii?Q?ud4LT+0ZutnEG9wN35S6jJEdNRCrCPqlFzwKbFrqVk3ZnymuFHxkTV27haHC?=
 =?us-ascii?Q?YCzUTxcHIIcmmS0kNJRkxmKDLJSawB581l3UJ4QkO4Sg1t7kSrWXoShbiQhR?=
 =?us-ascii?Q?jTGMW0MJK6zmt/5YQhvgFFZu/OuDbhycLyP5fHO1HXyaGND9FHMEH0WHRzB+?=
 =?us-ascii?Q?V4CaMVjzWH6dTbIeb4ooLJSj32Z9kONI272MYezJoN6+nJHfTlIYGZ/adEwo?=
 =?us-ascii?Q?ezi4S8AqqcKtcKvHjEbPNADEOFMCSmXf6bhajOwkRXaeN+R2/uSzeWrW5qoh?=
 =?us-ascii?Q?vulAhlPrusDDRoiSo5aEzsmOlWdpwHrRTnhIhPwBCfO4VtVWNcwSnIMAZ6B6?=
 =?us-ascii?Q?0+jhyAWa/bpX6cwHxsexrlqWtW0rWuAHO6VRiLfIywud+A5ad5ICwpj9ZzIU?=
 =?us-ascii?Q?pJhAPyeehqXsx9UYf+BeTrQ1XfHTewXEbjTVJnDGEy/NeoQrNSAzr9N5hQCx?=
 =?us-ascii?Q?0TuZODNa2lmr8CglA6vjj7wWBUV48bi4T4X0YhseEWedOCn1NPNEvbSuI/2o?=
 =?us-ascii?Q?EBBeFTDRimAuQiGxgtU1lMQdFjQJHxj9XhpJnCFIrShpfscp65qn7AZYcGmC?=
 =?us-ascii?Q?gsFp4tW+PGQDvD1Vnt/MTE/lrESe6/MPxmmIaJCOo0pd01N6V1kkmvIjPx6a?=
 =?us-ascii?Q?QuAbDFslYMIKJNVrLVHVk6dfrynF6WAmcgbS2CfutVWXvCq01Md03abAqdst?=
 =?us-ascii?Q?I+VdGoL4eB3RWxEKdn/XgTobYiJ31Ygb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(10070799003)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ano9q3WYYV1dSN+I6NOuHSL9uBdN5pueSiJyper4kOgXjxGlkogV+FeTlZ57?=
 =?us-ascii?Q?VkZbo46ObG74C7+5LZjUL1J3lC7ZRGJrfJcu7zbl9UUA0HFLZmi0Jlu474s+?=
 =?us-ascii?Q?5Pq135rkHIoWobwBB7hWUXxAG1lThneVLfcxcY7TWGMwXsOtyc4XfO1LfZnr?=
 =?us-ascii?Q?+ZVJ1QXHFxN4GOjgEXV1jY4YqIjNlwGYPhaEDI6AS5jF3aD1RAsH8EXQImwx?=
 =?us-ascii?Q?JJcgAz/1dhZKD9DWKWrkqBEorLsF+9/jJdbY4TG+7eKKprzCG+1FUgtoqr14?=
 =?us-ascii?Q?o+uxGieZ/ojv3zdomKLq0+mTnQJdiYW2tit+48jU+BoSMCNOjBtShN81jYdA?=
 =?us-ascii?Q?A+Prnnp4V9a/ri71LulGfcUjds/ijJqefYCL76Z/G+Yd16+cc4yzLLYhhEAX?=
 =?us-ascii?Q?AusbhqnY+6KLCD+xp/aYeWze+l+Fsk45d4wGQikC+xS8XS/YbWif7kBgkXl4?=
 =?us-ascii?Q?NHBKnnvu3FY0dUyVZLCFyzym9+NJcoALQYf9Cf6oMMJ9w3h0FSKSF31qRQf+?=
 =?us-ascii?Q?XRdgZ5TvtGleA3v/zH8T+xbtmg5dZHjw/LsfxgbK9Ev0bLcHlaFDHrC5YQy/?=
 =?us-ascii?Q?OxgmqqOdupclHn5pEt9JihwMVV76jDNGIlFzsnJIbA0h0LahpJLvstvqcK4k?=
 =?us-ascii?Q?HttlZ+dDLmwL9qb6UlV11qN/lSZy1au8afkj0y+QofaoQKWG/M1YhlPatH5S?=
 =?us-ascii?Q?Ysku6QXhyRuMZCQTGIKgapiI8XpvHGMyAU7f7Wweodw1aRGKtXwU27mTjz5Y?=
 =?us-ascii?Q?cKllHnVQmVpJPOmCx51VHt4RoAGR8F8iDfrNm7FeL3UBicgXWJuVvlhW5TrX?=
 =?us-ascii?Q?w9AXdcNd9dJesdM9UPbXWHHCzkZ7tiv9NoIfcyUnA/w3DTSktdJBg7M35u9z?=
 =?us-ascii?Q?rfQpY3hGU5JYnKOCTqapIH3rQhvkfcuzm5L2LZqyEqKbpbmdVI9DNsvuXW59?=
 =?us-ascii?Q?nuvmeedA78o/2YsrW8Ri90xwXu8oU8lbS1YKYEmAkEN7fEzqSXof/OXKmSlj?=
 =?us-ascii?Q?22Ydxfiv+L8KLuFnnJUmCB1GriQeYXf1JJcU/aW50AqejW73z9e9RIXvz+yk?=
 =?us-ascii?Q?YMTKRb+TDKHRN4C9YDFp+KBv0nMRgGgXQElDTUOyo1Ziue9Q7d99ILWMqIVF?=
 =?us-ascii?Q?dLYLRjvk9TpDosUA3I2ABXLOyeXhKrr/KofmT7HUYo9C4R4OJG6wX9lDgRQz?=
 =?us-ascii?Q?wbL4Z5M3kxSe7eTiVw49LPx50AYizW3MSlPSotHIa+yevUuPkdjW+NehVuoN?=
 =?us-ascii?Q?/RyeqhoBnloDguBAI23kHdWVDyuWyhpl9/DuRUzgvg47sczM7wn9JrzIjjmZ?=
 =?us-ascii?Q?MhOKtxeT10QLQ5E4+mjD1mk7jtmKnYV9kXJxdKfKfc4W0NbzXdO0JCzVRw2F?=
 =?us-ascii?Q?Hf+GVWLl6bmlXU5wYUiL/iymIQ3Dge/e8KhlyUPGJ/5Ixo8gyjOvO2yjl1Ds?=
 =?us-ascii?Q?lbFUk6vfgn2mJJWNAu5ufAt37QgbUvwdDTNvyhXDR6S4NKG5+u3IMbn+vjIB?=
 =?us-ascii?Q?pPxjulW4MWYF5SI6bYJ70dbgJAtFkoYDcfCDuKm+ZBYoCxBjj81ENSX07SCB?=
 =?us-ascii?Q?2FRTDRARneZ5hh/+ebA13EvQS7o/qutUHe2RttwLkrwBIw7AokZVMizIcBZq?=
 =?us-ascii?Q?5EhwyTAfgP6SZCOs3/qQSeKYMsYOR5i7bqIfgE5ztiU/P89HyHdxaHFjLtYr?=
 =?us-ascii?Q?rMEMpA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78c310c-d309-4747-9dae-08de2dadd325
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:32.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RbNxlg+IBGvi4LkErU77n/a9jfcHpS9gW8EIsjHC8VOqdRwcs5DxzkCJ9GwPz/4lQxUeq4fF5j+xz2l+dWczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

The "yt921x" tagging protocol populates a bit mask for the TX ports,
so we can use dsa_xmit_port_mask() to centralize the decision of how to
set that field.

Cc: David Yang <mmyangfl@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_yt921x.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index 995da44f0a2a..6bbfd42dc5df 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -38,14 +38,11 @@
 #define  YT921X_TAG_RX_CMD_FORWARDED		0x80
 #define  YT921X_TAG_RX_CMD_UNK_UCAST		0xb2
 #define  YT921X_TAG_RX_CMD_UNK_MCAST		0xb4
-#define YT921X_TAG_TX_PORTS_M		GENMASK(10, 0)
-#define YT921X_TAG_TX_PORTn(port)	BIT(port)
+#define YT921X_TAG_TX_PORTS		GENMASK(10, 0)
 
 static struct sk_buff *
 yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
-	struct dsa_port *dp = dsa_user_to_port(netdev);
-	unsigned int port = dp->index;
 	__be16 *tag;
 	u16 tx;
 
@@ -58,7 +55,8 @@ yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
 	/* VLAN tag unrelated when TX */
 	tag[1] = 0;
 	tag[2] = 0;
-	tx = YT921X_TAG_PORT_EN | YT921X_TAG_TX_PORTn(port);
+	tx = FIELD_PREP(YT921X_TAG_TX_PORTS, dsa_xmit_port_mask(skb, netdev)) |
+	     YT921X_TAG_PORT_EN;
 	tag[3] = htons(tx);
 
 	return skb;
-- 
2.43.0


