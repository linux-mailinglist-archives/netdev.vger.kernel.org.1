Return-Path: <netdev+bounces-216963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F46B36A99
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A678A46B1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BC835336E;
	Tue, 26 Aug 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VOcJ6F3w"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012067.outbound.protection.outlook.com [40.107.75.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D73F3376BD;
	Tue, 26 Aug 2025 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218137; cv=fail; b=eyWLCEzPcBkXw55fnfwMYG+OrUoJca3gN/c/PntYmf8zF9net1yD6Hj8z+No3tuYuEQSIiIybx99d26bVfXhysoIHdeyTrEDRYCqhoYosyiexwRMc03XnmDwP5djITAnfROXzqzvYZQlslMR6w/+ARK3lLKXcxT3G7vfVT2+x6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218137; c=relaxed/simple;
	bh=1RgtEWmeUCOfzuClZXLYN2BCImKoE7nyvvCOlZl3aLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q/pVokJ4fDSSQxJW2e+U+u1uQyy67drmaOi5YiOzvGbNiHzyLYT4mRG4vF2rN2JNVowjbbsNhsodj39BN4uCUQZwPfq7gbWeD3VJcs8oPK7Ug6Mw0gsokUTzmA29JT7ttJYmfKPVdJsir26GxdQN6bu6BQHB1AV+tdmwTfzRIKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VOcJ6F3w; arc=fail smtp.client-ip=40.107.75.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3aUXjhQfJXgh2b/rFuWTxuIP00iHaGPUi3uNLju8sBDwYhVdjxx8mIU3GQGqEj9VEgDWKXoyBWV4dftWVAe0VNgC068r2UygjBJ6kOK/TA7djWQc9SUZ2bf13H+AouTPBALK6q0SYyp2giyLbBsK0m+tu8n3+Hqsxg8bt6u17YWf+FUSasbmGGR6SMqSjUzSpVvXgFlHFhB29VvJkxkHcr5QWlkLhNV2QG+Oa7liMr9GZGxrUA6jkqmJrQxPyED9+uAddNllQ7rOlMxFEZQtUC2JHxMSavBR1pPCrkuVUjv/Ww9AKqt20PC1e44ROkn6NMczPmz0B59gWMyhh8E1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUmHuLe5xby/xHRzfcPMs+2dDsczvUI4E+V9VPyV5O4=;
 b=NzrPqUhGSQV6Np0JPPlzqmmWm3DkXy9KbD6dNpmGhI+E/p/fHl8/LHVEL2IitoTZ15/3JUOrTXjwdPGrRyffyY8GbEC+w6L9+BodZ4L09bCQGzyfh2u6P8hymvVm8ZRnWsBmYwrLl3dAkYn+rieYiLfZvnjzuHKEzFcHz5u4F49AOWqvk1Fpss6A5NezsgaUza5ySN1TbzcZ2Bf1UUWdRR14CAZuLJm3VirMRtXTXXfRePKfvcR+4hr2+rRTS5WKaeZ1L+aIPeLSnxWT5qSioWDjJBEuFiiXGY7Qu5JQ+LZhBhfPHBOwsNoxH82AIli1uBfagRmjAXB9N85pu9WYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUmHuLe5xby/xHRzfcPMs+2dDsczvUI4E+V9VPyV5O4=;
 b=VOcJ6F3wFgbNps2re33TbAy6fI3xwdehPpWkOIxoPptqIbTlc4ra8ep/cP8Vi9iku0A6iIQ96TAVbliTAixMDNHpF2yqdxt3cinp3QqiU5pWk8fS+FBXCdZ4vk80mFvba9xPIri+xrYzvui9OjCQYWiH0uo/17TFSWaT1uqglaZcjqkzUrwoehyehMfKAS5gffkb4vJF7ddUuubp1V7/clHfHjK27dvAh85WqdOOnIl++3Fvn3bwA14Tdwcyd5VMtHfns3SP6TZrhkXdfUwEp50pKgNnPzAEvWcO16g9/Gp0iVaYP4QXIal+6q9+Z6VvJJK4M5RBur4I7zzVkb8Tww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5128.apcprd06.prod.outlook.com (2603:1096:400:1b3::9)
 by SEYPR06MB5939.apcprd06.prod.outlook.com (2603:1096:101:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 14:22:10 +0000
Received: from TY0PR06MB5128.apcprd06.prod.outlook.com
 ([fe80::cbca:4a56:fdcc:7f84]) by TY0PR06MB5128.apcprd06.prod.outlook.com
 ([fe80::cbca:4a56:fdcc:7f84%3]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 14:22:10 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] amd-xgbe: Use int type to store negative error codes
Date: Tue, 26 Aug 2025 22:21:59 +0800
Message-Id: <20250826142159.525059-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:404:15::34) To TY0PR06MB5128.apcprd06.prod.outlook.com
 (2603:1096:400:1b3::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5128:EE_|SEYPR06MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e858270-0a41-45e7-3589-08dde4abf187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u6LzexTSqsYIkJ+ZNwd5j+tH5HMICVTJ7C9UqV9Qn8jzQT/uUcWAe+QQ/jE1?=
 =?us-ascii?Q?owasvjRwhuzxJUgJBUMowYjRH9DhWclM0MseGmWMm4L9Ig23Jd01cZBRBZND?=
 =?us-ascii?Q?qorbl3RF0ffOmG8JeoBAAj6HCWYvFBA8FU3gRjeGUdeyD9dXsSd3DbyPPEhA?=
 =?us-ascii?Q?eqmQBGP6mBM47g4Qg8+bd3qBKPaXLVDbcKLDHzxw7/OlgNgrGRICNb4wfFZi?=
 =?us-ascii?Q?NGKA8GoCJioowGoFWB5SzSsM0VdedAUG/l/14+SuXjUO+d2/a/0YQpTSWiXI?=
 =?us-ascii?Q?6fuUQ0jtbJZD4Y5WOXXsGUW/WbRP70DeDMSqKITajWcpI8Zb9Je5VelcMkso?=
 =?us-ascii?Q?Efow27r0+7goWlIpCgmusV0v7imejUUkNzgo0YYvDeXub+uKpOXqq1gVi+05?=
 =?us-ascii?Q?qkqHNu0UsFA6e6ojwJyI0IjZgs0orldQN+WE8MkKBe0Z/QUANt71OhuHAZq4?=
 =?us-ascii?Q?osgkUSENZ/cXD3Yok4Rt8s3enWCOL5K7WyxkQBm06gaZ6OXNTo8Jtd5IcTCi?=
 =?us-ascii?Q?klsGHY6PgzWvBAOCMP6muxNau71OIZfcwe2hnph1oMfQG2yjNPSOp36yKmEJ?=
 =?us-ascii?Q?ivXuyfUz2BLbYS27QKO0BQ8FOO+arBELhrhlW9xTa6bxeqS06HbPsaqEmNHI?=
 =?us-ascii?Q?X2+vGGcQstsrJb6dYRitnYZWQpLh4Zv9GmyKPfeJ388ISkdcFust9tuTFlom?=
 =?us-ascii?Q?IgtJ0A2bYGpFtIJil7/uQzix63lG0Df4IBMJFW8cqFehe4VRoZ1gWX5UJCFT?=
 =?us-ascii?Q?giYfMDa2JcCeTE8alT5ziXAgUu6blLGhP4FFS2BI0SO4l7zcrYw63XuQ/bk1?=
 =?us-ascii?Q?X3YewcHbd6+jTEeA2oWZMTrxJABsKPjNAH9J4TFZnMd3epKlrEgsiu9oNAQs?=
 =?us-ascii?Q?Ry5gzaKKL38zYl+9eKH7+7Vcec8MbjFWY1N340BH/kuAmjVz5tSS0Hx7kedi?=
 =?us-ascii?Q?5rIbc6Glqsw3lJitdSJmY2tyCXMIQam7Q0MwOOLBKgWTX59BCv+dJK+EytZg?=
 =?us-ascii?Q?jQd25mR47pxM1caTJ+ibiqPFiCJLZXNUB6Cc+KkVvJcWAOg6Tbz/OkpSKsIf?=
 =?us-ascii?Q?o0mL42hOntF9tyON0kyCo/RXhKKJw1ydk37DdM+bUV7jmv9HpfXSopTAWbrN?=
 =?us-ascii?Q?jxPuSglUVPMQuPicmnEOjgwSl8gq90lCTrl0UhjJ3bZJSlKiEy/3fKtDtax9?=
 =?us-ascii?Q?OL9U1WBCe0824Xqxp19ge3InX6i2KslLqGLILvOlRetARGyijpiK6oSo8S/9?=
 =?us-ascii?Q?YNUCt+sV6sWk4CkB8Nz1q7u+phKa/xzFdPB7uTlX/GfowOmTqRdG4NUjEHdz?=
 =?us-ascii?Q?HXSaPf5IAes3uq/0ue1w4/xUzfgzI4A6jw+U84H3RZ2aLudiaWQL1LILuO9T?=
 =?us-ascii?Q?2oiBDAosjp2ZqVvI9oFoUtYfAuC3QVJDPVdtdmLB8hhA152RuSo05fp217Sh?=
 =?us-ascii?Q?SyPdnF9DliQ5nlaPBlJIuq6y2/IKSshqH/geqEunWKbOUVDVz0vfrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5128.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M8tl3SxQwKjphZ8RQ4PTWdlg2oaB+qSBU7491/P9JUIKqdeIn9cvg1oWmkx1?=
 =?us-ascii?Q?rBsNS53Mi4QOQezWYPzSTbFsSlVF20hGYE/XU49TPbKHCvi9jd8xwCVUeVeR?=
 =?us-ascii?Q?jbqatpli9eswG8xzT9y+6j1QmU3p7SSduufsJACOBp4r5gVIo6JqNDijwJDa?=
 =?us-ascii?Q?qs2BU6dIyN0GniwwfzKRpc/jrAu3aCRT9h4+DnsJgCb17udW9TxvN9oqH3bP?=
 =?us-ascii?Q?YY/SxZlHv0ZxiAzseZG1ZVyJ75dh7locECfQC+87xk9+SB06AL5njM6tMTX2?=
 =?us-ascii?Q?6kQMFZmg66Q9z8qUYNBQ7HDgIfN11whWpUtlN6ZNTotERVySY3KEcpqodoHa?=
 =?us-ascii?Q?8CHuxREBv71r5XJzRyHQer+Dg85Q9e+f0dcDielcYvI2FTjRm8HOpkcOzV8U?=
 =?us-ascii?Q?FE6bcr4XJmfHXds50Ma9eTYOg8ubO2HWFOgLnZgcdPejevEMc/S3mXxf+v1w?=
 =?us-ascii?Q?zOEMgTvHMqnaQKUxE+D1lgp1TdTkiJ+u2uABU2lnVT460FhOy/GUyA3Yo48V?=
 =?us-ascii?Q?6m7BeUIQC3DTHlgcdSIdugSPb+dhATXQ4vSjVJ6zKnmPq3OhTflv5GZvJJXg?=
 =?us-ascii?Q?0ept9K1X5pB8gFpTx517tIkHp91WECMI//dcQsLG23ncBXu2l/JodjGWGTOC?=
 =?us-ascii?Q?4jKqlwgP5avF0AkZwYbd9Y8LVqpSw9DfeVsvkTwdJhKAuPa4gDB4m3fCdYWY?=
 =?us-ascii?Q?cmkrv0w4e5qDzQsJaO60BIX46m3uMPhMZsqrp4BP3+hIcbjoEt62/ZK0Kv6i?=
 =?us-ascii?Q?TmVlbZbFzskvVpi0LyZ8j++DwclyxUH/pl6zli0MC9fjrcNra7hCQCnhu5oX?=
 =?us-ascii?Q?GLsIkljFdI1XgPcbja8n9bB6dlJalCZJzqq7s70Xgpxxjoc9vTwN/2AQhPgH?=
 =?us-ascii?Q?EasBx+f/xd7/ZytBUdgx8eBgbuRKB1q70itI0ao6MrkFT2/Vmv2jIrFzIvpt?=
 =?us-ascii?Q?ej1ty0EODnZgXYyBAL0Pg0qUnMIN6nxs3hRAHcetPUqkhpiPvNXRwoKzPgSK?=
 =?us-ascii?Q?cQCA2bI/Eoxv5KxwbeWXJFqq+Ighv7gnnRpaQ4HF1ixqdvifnUyAMN5YbXch?=
 =?us-ascii?Q?fLBnzKWc9950+sBWXM6RsKwjZp0H16mAyVs2Rm8FmBpBVr+jGKn7Mx60MIzY?=
 =?us-ascii?Q?PzZQDWTDpkc5Mj6eTRgHdOhVRfuRb21zo1lAiCVT0P5bzkaiJjQ1XsBmCdKd?=
 =?us-ascii?Q?AKf9P5gb0yxtIcH3Ll7j7iGkyk60tuklW2c1oZQvIwp5u0OZYqMfZA7rFANk?=
 =?us-ascii?Q?UkTkc+Skdmy23citkBOS5RIQdbOCCet1Ej047/ZExngEujRrjmnniHhti5Tt?=
 =?us-ascii?Q?ElrffolNkRrQKoAgkh7JCQvzI9M7Mc0feuFAPYKJDWsSPDTOvbK7vl7cvvxn?=
 =?us-ascii?Q?F6X4F8KYz2vUoC9RFoTcvtN08rgx18Y3b9CKoB9K+wsWcgXfkki+l23QpbjU?=
 =?us-ascii?Q?Q5k1wMsTTQg6ZPqE778YN93E4D6lYloQFI5xaNC4pB3MjDgm7w4+vSIHySqz?=
 =?us-ascii?Q?usx9x/DC5T5AtoPn/aIs4VXS7/A3iMcuTA495M15XsDZjU9y1azLWeN1Z/vV?=
 =?us-ascii?Q?Z+QrogTeimSYNww4J01VCylUF6qNjeGYK3XZlJL6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e858270-0a41-45e7-3589-08dde4abf187
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5128.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:22:10.3189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKOVosmK9ruE8xGON9IvhC85sYby4fDiLi2gRxqgBTqJfD6+nbONAVltTKRe6XHCIOVb/VjOEmISJS/3Fm2SZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5939

Use int instead of unsigned int for the 'ret' variable to store return
values from functions that either return zero on success or negative error
codes on failure.  Storing negative error codes in an unsigned int causes
no runtime issues, but it's ugly as pants,  Change 'ret' from unsigned int
to int type - this change has no runtime impact.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-i2c.c     | 2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 35d73306a2d6..b6e1b67a2d0e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -464,7 +464,7 @@ static int xgbe_set_rxfh(struct net_device *netdev,
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
-	unsigned int ret;
+	int ret;
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP) {
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c b/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c
index d40011e8ddf2..65eb7b577b65 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c
@@ -70,7 +70,7 @@ static int xgbe_i2c_set_enable(struct xgbe_prv_data *pdata, bool enable)
 
 static int xgbe_i2c_disable(struct xgbe_prv_data *pdata)
 {
-	unsigned int ret;
+	int ret;
 
 	ret = xgbe_i2c_set_enable(pdata, false);
 	if (ret) {
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 23c39e92e783..a56efc1bee33 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -2902,7 +2902,7 @@ static void xgbe_phy_sfp_setup(struct xgbe_prv_data *pdata)
 static int xgbe_phy_int_mdio_reset(struct xgbe_prv_data *pdata)
 {
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
-	unsigned int ret;
+	int ret;
 
 	ret = pdata->hw_if.set_gpio(pdata, phy_data->mdio_reset_gpio);
 	if (ret)
-- 
2.34.1


