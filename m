Return-Path: <netdev+bounces-217241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646CB37F9D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3853F3B1B14
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FAB33EAFF;
	Wed, 27 Aug 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Xzf49Yxf"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012038.outbound.protection.outlook.com [52.101.126.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03272F49F7;
	Wed, 27 Aug 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289733; cv=fail; b=cb6w058A8LNdolu0pzSiiwanzFgnYyvUqk1iT2E45gytzAsoGWOqGlr3DvnhZ7D1dqEAElErkv1B+gclPpIGMwzyN7mrNf/uGU5woxxKf3mCJhARJx7Cftk9FtuEMd3pgNhp7VGpiwoFg/dWXmKiff2I3P0bXDgLBG5wOtgVTTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289733; c=relaxed/simple;
	bh=M1EAKDuc1XXiQWxJjnW/36QTkYdz5/brBFB9qNILPRI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XmJ6Ju112ZES9gzqTRzl5e8T/o4vvyH/iQ6tNGEkFn/zatimPhj38Ar+lEMfO6hOJd0SNA0rme6pGmk4hu6qJ+K4yZbf1oPVsbkpJ6GfwTFu7A8n+PgYHhSQyDAKz7U/+wcKQs+Kl3xnN/y2iXjtrY52JyAE1duo/XYof4oHPb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Xzf49Yxf; arc=fail smtp.client-ip=52.101.126.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRPmH0sjIv3cbtF3jAyfv3M6kSDJwcmKQHs9UdehrMheQn8NvixBOXn0VL9G3PKtPZCF795X/fM1yw9b7uurZYL8aBenW8EIPNq2gLWAbTIxtTbQnMcM470wO3jweVU6yl7HGKdWEd/1TatH0NTpPLL0oM+tRPVgT3I956/MkySfZYhcngxnNEgz+cqPSudTNdVoarcVbWMrWhsVdhjDG7rQtkhjRKhOy9Lyd3eqMsGgHSNrHECdjj6zxv7bEMziuvPkAeUc/8gb8K2nRyeqbkVGqgJL6ox7uD0cH6ogMkb+zvzCCNHhW5qrX19ZkmdngcBZDRJp2+xDt2J/1YXWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0Ke6beW5/1cVX1HF0slLhBnDdUb8QK3I2K85J4KpD4=;
 b=BumobDtRKjWGC8zSe8vTm4CTK260+q8PR2d1JCxY++bKTm6s5+9slJTrEa5rwM5ZTCZhm0F178ab3TafcekCjRTXAJ+Hkqz0bmZbVJMCaTvOvZZAFLLlBATKZhBNLzMimf8m86tKPC1O+Mqax750uB7EaocHJZcgqP3dZR6PBbwU2c++nuAEnZgT2w6e/bwOG9XofUY8J9DRkQoXRDQdk9UvFiZzqNOs6Brqy2p9ivgxGPKsyejEQfg7hwLhV+3OSwki8qWBz3GVvDqZVr/ktATA17H7K7LVm4KOdZ8J1fMuQTO7KasvRQvYuFKcNyb9UAa976vVloXewLasecN6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0Ke6beW5/1cVX1HF0slLhBnDdUb8QK3I2K85J4KpD4=;
 b=Xzf49YxfEUCCh2lsPki/UO5ar/GRFFDju1PnF4vTbWiN97p11dbPjZuzd6dV6FVZKukG5WU0qMOBN3KnfINjJEopMIHAtewUUfjNirSyIcWlBBBJzGAojVfF1aK1PW7vys9cw14HcIKtoAgkGKghs7VgwOe71UhqGAc2Jq1CB5URHKe9tPhk1TUDiLYjnhF4SED2fPA7YTQ60wdirZC89hBhWyx60BYdMg6rJrDdiDXIWxcEIkda6QpSKOfcs4PZx+ucHV4J1ehDD0iJIKQ8uSe73eog4X0Zrie93ccDa1UPFzz9a3v4AnsCKNF+N0WSmwvzTEcpkG9SMxSUBnnBBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY2PPF7BEC1550B.apcprd06.prod.outlook.com (2603:1096:408::797) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 27 Aug
 2025 10:15:28 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 10:15:28 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:BROADCOM BNX2X 10 GIGABIT ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] bnx2x: Remove redundant ternary operators
Date: Wed, 27 Aug 2025 18:15:14 +0800
Message-Id: <20250827101514.444273-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY2PPF7BEC1550B:EE_
X-MS-Office365-Filtering-Correlation-Id: 9509177d-fa94-47e9-fbbc-08dde552a528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Zk/WWS3iXfMrKfCScUU1z6AOBmkPLyHwY7KHmRVkKHH7zq+poZlGxq5MIYL?=
 =?us-ascii?Q?T1Up4awuXr6b/+zAyufzP6cqylDM6a50asZlY66UzaotKHy7e5ljbtthcUNi?=
 =?us-ascii?Q?/9Lw18d884J2h/HgeAueQUyIPBvLSWKEE71MNxqThCI5SZK05bKYgE6K2Whj?=
 =?us-ascii?Q?BysWlJIvb0nIlYr7XjnTPo0ASxIuO2AMbbf7Unvd+vpKNkH6olx9pt6pi4Q2?=
 =?us-ascii?Q?ong60iMVs3ipfuJeXbBSkELttsA20VdjtUaP3NbpcxzQ0PEA5btwNjWhyBRV?=
 =?us-ascii?Q?Uem7dIXWo0uqVFW+qR8MjfsOc/HiId+bdjf1qle7ah+lzA6sD8moQdFqP6tH?=
 =?us-ascii?Q?7S0Nv1xAMugDwvZfbPI69MAPtLOLiefqLMJsjdQI7klOixr+G0m8iprCGyuJ?=
 =?us-ascii?Q?C4sQu7pElUcIDd/zif3LbPMc9SUh3XID5uP7aBK7nZtEJYxDiM6DBv3ALQg9?=
 =?us-ascii?Q?gmC6eQllL3rKJDRa84LIF5bAT299393qmHDXdcgSIB6CDFj1GHmhF9DXe7PS?=
 =?us-ascii?Q?xfzm3C+TwaB+rvhUNfs/Kq2iRg4kqy60CsAD48JUjqWqgNWJ+wOD5XffrxSH?=
 =?us-ascii?Q?LemuELhum+iA+jqpxQEku+vgrEMjZDFYyY3jrHpeqmu4+iJPQ2IPWsT/MTgF?=
 =?us-ascii?Q?EnVrOfkSRTPNX1eymp6wco3TOqriXu/tepU7JW8Rf/D4Xjf20olgncSpqeKZ?=
 =?us-ascii?Q?XaXg2eug4V3mvGaZrmLeLQILudX6c+j5sXN19bGGCDEIbVMhpxCSpZYGE3P6?=
 =?us-ascii?Q?xkF8jjx2N2X+RbkSMsg09tsueTrGvSlixBH/UaalHo13CWktQTqgWNWRBycb?=
 =?us-ascii?Q?gho6V0mVTebWEWklKhSYbpw6MZdyZZ9FRNYpT4iv1yWJmVoC1eO0dyQZKVMd?=
 =?us-ascii?Q?0ZcWi6oAFesXyYuUphdISyMXVmFLFTSoebacYKsG9c4eVtF6Inh6JJTV0b1m?=
 =?us-ascii?Q?Wq/j35PY/MjwQktK/UMp5maN1TVFYDXhuvHsGrXdXMTXremcUsriQFtU6Z8z?=
 =?us-ascii?Q?DpfKkCfhdOHl+t6y526Cn9e8Zi0Mr7HDPWeKO/Q4jSSFhGzDdKMc+3ij7EOm?=
 =?us-ascii?Q?Th2dEe8RT1f9yJ+g1DYiG+DLYcOBIGhNslCReKDarQb9sCmSlxAfJgTrpq9c?=
 =?us-ascii?Q?ZDvUwscvS+Y8lSC7NSVpVvGbgcRL6ihEe1Ar2v+VtkY9+Y38TGSVt+1EcPvW?=
 =?us-ascii?Q?gF+i52iAlXHwJ0/tYRuuiInX9NrtzniUn7aCbtbEp2iKXu50UP1DBTrX7hU4?=
 =?us-ascii?Q?fYo7ipHQNfywPGRVZ3C9m7Oo8hkS8ZFwVGS5AfCyIfWnj6GpHhSY9zA9uOpJ?=
 =?us-ascii?Q?OwFXshdmKRyyn6vzlXZk7pVP59jESGw9Ax10h4BYKRumC9xPfBRyOQUFWSVb?=
 =?us-ascii?Q?iAR0NXzIJ4eBiRoRUc7gD3H2r4FyvGBpsQzkDtZdA3STWtqZ/PvU/pHIjLHT?=
 =?us-ascii?Q?i3SdQjtPccJrVe5gxugdBZ0eFf0zDCqX5Tf2XPuPN6oCZu6oW0+Y1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dvm/8jHJMChXuYP8zMGwCipRK5ZJaOtPWird+8yi1VOyzl1t6uTZL4rmX8/T?=
 =?us-ascii?Q?uJIGof7s3ubtWpG4clVv4cFz3soWqLXS1XQKv+y4HLuYOXOlPPgUd2eREQhw?=
 =?us-ascii?Q?dqYhH5Btt7ghRlAQoF74kZHbUXZ2E7YSEtvfv/fObZB2777inqFHKwZsXMeY?=
 =?us-ascii?Q?+K7puakuri5xaVSEi0uMNShJKB1JGobDngZoD2+h/JTQsE7MNhPpHT+oahay?=
 =?us-ascii?Q?GqPX4TQL7Vj9hhpym078iYA7zh7ToHWxrsBKwWdmXIurrtz7RIJYajfdh4Sg?=
 =?us-ascii?Q?62PXIkSsg8K2t5F1GZW2pQTVQfv7DgAgJfSkbt0XtT762lfdiz6KYGpyg1vu?=
 =?us-ascii?Q?r6XM3vc2zjKkAVg+hkdyHgY7KmE8F2+b7mFqJJinlIzCBr/VUVSnK34UUlYa?=
 =?us-ascii?Q?uTnvmhGrUqb3M4uHlHTztPmk9b3zMe7Ec3j7gI7Pig9IIxhPlJp6JCS7syRO?=
 =?us-ascii?Q?K/LAhmbdOnntj5HXsO2wax9Et85+pJqguSFBoF3U/eq9IgD5VDxSopP6/HKl?=
 =?us-ascii?Q?olSCC+5PRWLjCl+stwbLrYJAJ0iJ9uZGdXOgJY0ddqeZ84A7Vykk6sjSxQoP?=
 =?us-ascii?Q?jJ+kbmKhexd2QcvFjqJ3zv4I0F/8y0rjQ6+YKI1mwK0UGs39hGtzUXsB6w/x?=
 =?us-ascii?Q?sHzq0+p3JZ4yHOHluD10t7SgHOnxH2D44EqRl8YO2hWK+g38SiAJ+rPiKA2h?=
 =?us-ascii?Q?AYYrlkPBuYLy/0uTv7sBvs1+Ixxl5uWMp9/rVy+sp9jy/vjSldxCas7Wp8x5?=
 =?us-ascii?Q?EFgg6v9zEt46ESvSJSCExDbMcWqDM2Vo4kXmQoCHa2hBLKxSlmFqnDUGQijV?=
 =?us-ascii?Q?2SDqpwKDIn11axhcibWChPU+kbZzYzP324LDC1dHYAh+28QIkpyXpB5F4r2o?=
 =?us-ascii?Q?C5WsJCtueHutHofSHZ4IVMN8MqKSjd8qCSlj8yukuZZDAkx1tEMVMmDCjFL0?=
 =?us-ascii?Q?IpYWxKWWJwSgOdSM2/ZkRii6/KnBUgrAEcfLvB/mSlis8M1OCTgXdaWok23G?=
 =?us-ascii?Q?qSSBsN45TGdfBta5/1MWsORNOYDbFqkgmWtzvIvO5TVKWKj+rCMgKECjXKbQ?=
 =?us-ascii?Q?8YGIQ82SEFYb6N0MMdUkyuRYeWUo4Yc6iHeFp7X7qAGO03Ljt4Z2X8VVbmN5?=
 =?us-ascii?Q?L+bmCml0gRPD2Z+vU+Lu5J6JZWko2JXBLHxBgS1hiBPXWIA34up+yURuBAJh?=
 =?us-ascii?Q?giGtZUHNxA2CkijvaJuJazdBeKu5j/mVlPa9HbLZxTiH56zJi42ZSdoiv+XI?=
 =?us-ascii?Q?SMRQkTerKd0+Q2eaPj/DZpA2leb1i1fwW1XRiwvByd9q+FuAemmamMHk1M+1?=
 =?us-ascii?Q?tlslF8Ylgxr4rw3WZI/tPCFQnRIHxtnhjq8NaegbyclxCM844ekixbkzX2up?=
 =?us-ascii?Q?mT+Jjt/XVGBUyBh6zKyFUk07Fu457Lr3wIaCUgHbKXFlw8sgQmjWIjRl3VEf?=
 =?us-ascii?Q?etd4AKEZDBRcnDCjW6ja0hoVFHoCKhbl+eHplKkD2SEj5Al+1G6YbL8ByP8r?=
 =?us-ascii?Q?N9RJ7csO5KbsN9QcFzBzy95TXdjBXeH9XJ/sS4C8jzcBL6QT0pQ17j0G3Kyh?=
 =?us-ascii?Q?uWLP5x47MVdvP4Q9s6Hvr/8eGoGkzN3JIwdUEAr4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9509177d-fa94-47e9-fbbc-08dde552a528
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 10:15:27.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGYKGT8rnC2OBj3CCywvfOaYFYL547D4m94nw3QjwcpHpsuzhjlhLFFrTd3nYFDvfwPgYpS7l3oV3lGqJa627A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF7BEC1550B

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
index 02c8213915a5..f876c59b661e 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
@@ -1052,8 +1052,7 @@ static void bnx2x_set_one_mac_e1x(struct bnx2x *bp,
 	/* 57710 and 57711 do not support MOVE command,
 	 * so it's either ADD or DEL
 	 */
-	bool add = (elem->cmd_data.vlan_mac.cmd == BNX2X_VLAN_MAC_ADD) ?
-		true : false;
+	bool add = elem->cmd_data.vlan_mac.cmd == BNX2X_VLAN_MAC_ADD;
 
 	/* Reset the ramrod data buffer */
 	memset(config, 0, sizeof(*config));
-- 
2.34.1


