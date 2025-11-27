Return-Path: <netdev+bounces-242267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C83C8E330
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83F1B34CB69
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD932E723;
	Thu, 27 Nov 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k3l/0hc0"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259E432ED4C
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245387; cv=fail; b=U4G2PM1Z8xZgBVefJ6j/C+0g4rfQ4SLOvUMTlTrA9c47P1SuRX/q9ezXp0kIoRcqw7tgejyemGUwwI6Kb+uxS8tUkW5Xc1Y7qV48pvQXQgZtKxIDxsJsQ20RfD7+Bc3wxew/XlvAHYO7l1FGnDP77zTujcWzUDKYkZkpG+H0HSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245387; c=relaxed/simple;
	bh=E+m4fCQC63fdEdgQy90Mkf7p6aylViZV75uodfclvTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMT1zzGZ0Zif/WUkTXDCA/NgkognMAZWmgFAqAQ4APFB5IFKqArT4JBR5C0Gn+itPePHIqkU27J/zi1nwc+/nq58l8te6ZraqkLWALHpGb2wFfPVdTeK7tC3dxfqFTnfiNJFiuRvS72Q2UqhOK8+VmLMT0DamaU511aVV22BUyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k3l/0hc0; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ir0w0hcZ4YXodz5qbKvOXqL8qjuOAHdkiyVT0iPC+wQtf2Fq4bLpe0SWFgGPZpE61pBlQt/WzX5lEwGyMHXSZanTStJfrLjQ1iuMm8mD5UGTaydGaqmOEI/z+zvjHJrMNUCkNvfKXAfZHDIV3dz468GHAfMSkObQwbm6Pz5SlAAAhUbyEdYASq1k0D8BZV0PkrxV76xoInNbkjEd8WzmAXQUuWF6eS5uJOlVEq/gN7L8Yq+nk1bBzRV0Io7zVXIcIj2hyqAXDa6Cqq0hZDwEsxtwQnULpR8I8Ob9iPUf6iInn3nWP7C5qdrkQ6870xiCzW/e54K2YtyZOXMqYVA2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQCw4m3MZeGCkASGOOaVVfRH046TtxHgrLwMNRxm2Iw=;
 b=smO9F7OqaIdu3iRyaFttdhYkmumcDrvni//zcKk69g8MQPF9dtilFoYyYPOZd560BW8fO0WBm4XKx2njoDtTPbPWEUTJgG0nHJ0VVBwB9p4iE5xBpy3rcssyEuzYo2CgFuzW5HLNO7z+vfBOQuJ7udcd7eOaxjieAvtYhI+gjVBYjH5qBI9HBBWUMupbtAf+uvwMu43CQMm6XQad0DKxrA0Lz7DLIW3rKL/Ksxa26ZnboVnlVzPZyxrvKkWQlhhpZQivhqlhCPxd5fanIHi3MFckPtQjBM+GIgZhUXssokXhlLv6TMIH1imO+r0rWnyIkyRuJdOYAGh/WDGRPcsESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQCw4m3MZeGCkASGOOaVVfRH046TtxHgrLwMNRxm2Iw=;
 b=k3l/0hc0Pr8Lw9/ctXwtzV5HVwuFV1u74lHBazxUjnAK8QlW8Kpb9laAg3nrCuVPdh3zYcjsEhqI1ZJRW26SHUi9mctiTJqBNnfU+o0FYPwMR3nvO2qumTlrvgOQ/CqZv93qNQP+2squU0N5XQKSNSw1kPZs9O6yxP7RmUm2oVHvXvi9TAxvufEpVSXLwp4ucdAVvT6QJSRmrA2GhT72ZQrl2QcMD0mHXPV7Bo70JPQo+g5dFpvA+6NIi9+IvGomn6dqTQLOUFsMF1CjjXtkIH2yzcRQIpKGWDDKuC3RvXrePf0W6GG346LimGLFMQShHl1L098LRqZF/M12Zx0Bxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 12:09:32 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:32 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 13/15] net: dsa: tag_trailer: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:09:00 +0200
Message-ID: <20251127120902.292555-14-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93ef48fb-0d3e-42b5-3266-08de2dadd22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|10070799003|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A4JLhInVEDMV2guYHGpWvh0xjEbI5+9OPzuuWAPZbfnJ3KKnifYBsK/sAKsy?=
 =?us-ascii?Q?wFl1A+a1FP3O/lpCr+8GsvY+POTfpXBRwbU/sF5OnKy11o3nJPh9FBb4Hy3o?=
 =?us-ascii?Q?GJ9iKLwyBul7g+/5sM8DqEtkvLqV3jaRMbq1uhMG0QDoApEksHjLAb3ihMVb?=
 =?us-ascii?Q?474U7kAOztX/lJfkaLsWt/L+Nns0QfoI3x+iCNYoU2kINxfAMvQ84u4hNzSV?=
 =?us-ascii?Q?pFqd2phr7Zsz5ftCW67DTNqPLbCzsHLQVVPHUAf/W6jm9tuuEU43n3MVCvQu?=
 =?us-ascii?Q?rOdSA6I2YBmty21MsMgQwG6eXxMi7qysLhn47sMIttnCznQv7UJ8hdqeqrG/?=
 =?us-ascii?Q?5GHNQTnxiGBtdXkIQkhmY2O+qjy9DIVzvI10mGwaSLaYoXjsCNCLWrmbrnaG?=
 =?us-ascii?Q?crFJD0NLKqLO+vzZeD2Cvfm4jYKF27Unca/f+2+Rv++JgRl7sbFDGzhad0RP?=
 =?us-ascii?Q?SRb/E0ms1z41+8yeEO7dW1x0z7nijzYXqe/UZW52J2b7WbnUuHQQWcT524rv?=
 =?us-ascii?Q?6TUuKDegMt36BChEWLc9FLDmPG0jdfufAFOo4dMqIEuvAPJWbKA8Yn42MCCQ?=
 =?us-ascii?Q?ALalfLGmEbXZa4yWxgq/yiFmXaKXHRj1pAhTHRvE2RlQnDbxL428985EhAt6?=
 =?us-ascii?Q?EH8H7tZ9ZvWkOIqNHGeAfYxVnOj3jEULzxQnyxJTCI+epkyw0OR92+jWpDg7?=
 =?us-ascii?Q?N1T4rM2OLc/7N6MbYeB5txVUICw8pYx9JdD1rdfS5Lp6GtafjUww7A7Hlw41?=
 =?us-ascii?Q?ozmfPT0W54AJ40SZA8ybjXMpRV0GhO3Eh8gN1Wjzi9hjcBUDoMGIZkXdTn22?=
 =?us-ascii?Q?eEfuZOErCXaaRZh8TEMDM3W8Em7486IDK9C/SjTyxCjJv8Z3lFWPFpJ+jcY4?=
 =?us-ascii?Q?YAR4xRTEvsyf6GXspKfhqO/H1XrH0LXH/GFy7MBmPDdd6SPTFVppnWCnDs1M?=
 =?us-ascii?Q?ki2TkwBcXa6U8AkVcJhaPOq6c060j61s7Wi4RfEc6hVXyNsYPYzwAUjN52cQ?=
 =?us-ascii?Q?6bp3CGCzerNMJ7f+M5rjxZC7MktexlPKTwAO6jFDc3uUxUNwF6y31aqzYATe?=
 =?us-ascii?Q?P/zHIeFqb1l+eOeHsM2OYQDMZSvO4O9PS2yIkVVs/JHjGnd9/gWSNzMoT2Jr?=
 =?us-ascii?Q?ISsUQpyJJeTZvzQb0bpo3+wK1GipVuaE++zNqIN3bGkqKZ8UiSlKUdqPW3sp?=
 =?us-ascii?Q?Q3n/+EFpRQWOTyy2ZqivnXgMT3pILBUdZAH13bBGpmRiFIxG7QAsVX+bhvrf?=
 =?us-ascii?Q?yr62LtjCcvDW+SXjTxd4YESGFYqpzg9tNYcl7XT3D1yRSzJYNBcrGH/vofm6?=
 =?us-ascii?Q?mIbVi5mtxJEYW/V1BN2w5xlz5A1TqbDQBIBR/9p65fVvqMCk7Vt9hhQKRPJZ?=
 =?us-ascii?Q?dEJ/ygCKmL98KBFNeADa4DEpHhZXaFWX2kL+tX9FlNr4zSREGEEc98CkIQtP?=
 =?us-ascii?Q?Nx0Py6duVojw37hXGQIcbKYOSxHu5buH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(10070799003)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wxLMKCivy1yZCw3sAYbORMoxW1gXXTdtUXxt0XMaDXtgwcpdsUwJfLBd07zU?=
 =?us-ascii?Q?g2ZdxNhYRmdTATIkahJdxb0jNlSKKraagIWJK1Nijbd+eioLY9Lao9QeH3L0?=
 =?us-ascii?Q?BUfefCyxIwl1QYb5f3TWyuLyULbunlEe601n/nBBID8Waa+1d/luBQUZJMHh?=
 =?us-ascii?Q?XtTLZB+Ntpnp1p13J6jRImovHTHbnt8xd/obBgicI0eIOf+QwqaiPTaNE5Ip?=
 =?us-ascii?Q?KwiTX0pE78UOKXqyOXQ47x3iEFNaQqmgo8tgor04UOh4RRY6mskVjBrLzu4h?=
 =?us-ascii?Q?iUo6HUBrfFywfTMAmo9iFbrvgOGGnFvu6H8/lpGDdpQOPhU3tN+J0zSJvmiP?=
 =?us-ascii?Q?BfuL8JLyTzcyIQAXK2ZD38SRaK0/SBKDjQd/hUhA1Q+gQAyr+P0uy8K7l6Iq?=
 =?us-ascii?Q?6udR7Jp33F1Gmff8VQi9iSeddY+VCSW0iq4xzmthC8KI2VQbyz3k8CJmqYo7?=
 =?us-ascii?Q?p8Dnjz7xoSmFNQc3IO65FbHRa5FmBuo9OJc6GoSmJtiKZvQVke6LEECf8DDT?=
 =?us-ascii?Q?zfA10DIfyoJsZmtcTNikqhMwK841zpuyjweR2I6CcY3Zhqh7n9DHclskPOXI?=
 =?us-ascii?Q?KxxhxKXHsN5msCdAweVxwREUFJBIpkE6y3JACCVHzId2Mkkd0oQbD+PzeJYu?=
 =?us-ascii?Q?cxy9EHhTBnsStyeXvS7HxOQpI2pZE8LhpiswsMCrK0fPWAyGmgWJDmZzESjx?=
 =?us-ascii?Q?tB+i9Rx/lgppLwQ5i9mGf01bshVrjMi+dEDybeCKcCRhHflP86yx2eEPZDpH?=
 =?us-ascii?Q?usdjPp3hublavDOslioKGCScwES0F/75sNX1vBh/mspL6yfAbx3clRQbGSm7?=
 =?us-ascii?Q?lDuU5Hta0i8GPKtjwG+jh76gJqXrQKKEdFBdrq8rNeVdY4vaK9mmX2Z06JHw?=
 =?us-ascii?Q?lVK14Jipc0u46rbYZDagcN61skhAhyBytFBQFyU4RIhAzEuRVhkadLxijaCs?=
 =?us-ascii?Q?gVsyPOWsHIm+MEbxepAqU8UM1D1khQkUgTT3hlqPV6atYcm9b6hDqx2Rkh1Q?=
 =?us-ascii?Q?7smTwpG7XtL7WOBN1fSj8c+IbBM++OxS5Fki7JWdY7n9ysTFEFwRRCFTnQsr?=
 =?us-ascii?Q?Nnvhnw4Cqr8OAkgmvF7w72Q/nZi41ytrxlJ+D1n9TXEEtbNGACil+QPgyXoG?=
 =?us-ascii?Q?lxoGmu5UQ2T1akAvmJURVCpni2aYLCyQe7Jo7S7TwkDFcVd4iDSHNC0sX/0j?=
 =?us-ascii?Q?RoC27cstq5TF9fjCg5CJbz83TSERFxtU7ufD2pdKAFyLTVXywzhDkr5/5++U?=
 =?us-ascii?Q?cjRWjy8ppdaViPy3dttDj/vwG4r73ms3QbBFOo/Q7naHRdTjKaOm1k7UFUP5?=
 =?us-ascii?Q?ZgrlvleUGGYVACiBgetDFJy8t/mge5D13D7BZgGvE2mJA7DXhZaAc0zUgDg0?=
 =?us-ascii?Q?//T7pxh62kGTW2xZDIjnsZMQqXAgJbdAywXZ1oBM7DJO8F5bDdWBMFOHb6sW?=
 =?us-ascii?Q?UQjg1Yn7diSkAsEsDsgtQCpdKDZKCdo0Suc5X8gwLSkgGeU9AdvlkM3KMFRJ?=
 =?us-ascii?Q?LtaVC4Qj7/4LXH5hXFEAiTu2kwKUEShITpa0AVIeOD54i1iNtwAMXoeUBYi5?=
 =?us-ascii?Q?sSm2CgrNPBvRhZtred9/l9yrD3hTSentsUSPOX0lWKR8lRbk536aoc/s83hc?=
 =?us-ascii?Q?+9VTBnwP5Ya5zALChoJk5c9eMv791sllNfM7Tqcogi4Jzn6302NoBMkWYz0R?=
 =?us-ascii?Q?nIMZFw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ef48fb-0d3e-42b5-3266-08de2dadd22e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:31.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsyy36PQeRvB5cf2bvpbl3t/JvYqmpOjctx4yoXgEIRoVQ8uBAKiYkgkQzAy/HxgDFujXJz8ifiE49XP5bSK2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

The "trailer" tagging protocol populates a bit mask for the TX ports, so
we can use dsa_xmit_port_mask() to centralize the decision of how to set
that field.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_trailer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/dsa/tag_trailer.c b/net/dsa/tag_trailer.c
index 22742a53d6f4..4dce24cfe6a7 100644
--- a/net/dsa/tag_trailer.c
+++ b/net/dsa/tag_trailer.c
@@ -14,12 +14,11 @@
 
 static struct sk_buff *trailer_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
 	u8 *trailer;
 
 	trailer = skb_put(skb, 4);
 	trailer[0] = 0x80;
-	trailer[1] = 1 << dp->index;
+	trailer[1] = dsa_xmit_port_mask(skb, dev);
 	trailer[2] = 0x10;
 	trailer[3] = 0x00;
 
-- 
2.43.0


