Return-Path: <netdev+bounces-286702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPPeGhXxAWpfmgEAu9opvQ
	(envelope-from <netdev+bounces-286702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:09:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7BC510E20
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E93C9307A890
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D375D2DE6F8;
	Mon, 11 May 2026 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g1z8hu7L"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D18B2D738F;
	Mon, 11 May 2026 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511649; cv=fail; b=iQNJnfk8Skpwps22ROBNNyzgyyL2A1C1N5feLepoXmnWQBZXfFo8vmyGj+PoHVJdI7yn8gyzp9UsG1j5NyompyyuMaCfILM1Q4bdat+sdTMNp/KAhcHVngdlk5TFKjL9AjsBx1NDMHWeNSFhA3K4EyM1PglIF1BXynMVneI1osI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511649; c=relaxed/simple;
	bh=LpOWqVqxrtpAz0vxsZKRlbGRI6kBLrJOWnMkh0g0FLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HfleYeMuGu0Zzhqe7kjJWCeLhVHUUKV2M8n/C85j4ERjkYWFBYb8O0YXzogjUCNs4mJik95L07azAg7qQ1Ciby5ATsgsDxPMN6eE8itoeM+M/1pIf9ai6goDMRP2U/VHppR+29JUu4aRMZrtr8XVjm4ElGzf4mtgEKW39da1IAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g1z8hu7L; arc=fail smtp.client-ip=52.101.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p76Q6Osl9hY3tbf9ypgp1rM7RRyxQpbQanG25FBuSb+3nL55ZI2c7TsmqlQTtDuBjVL9jVwhyS84rp48hzQMB6UzkbOj3z6pOIBco0liG62DxihPAnUvrOstHZHlF+sjDGWFe++dugZw+Yhl2gS4tRfBfeYjzSVjJsdoExT2PobJvIz7iiJC4jIbGOh9Oo2zbkSaDz2doCaFUZWYX3j6DW8tJmSdvuJU/ST55TvNWi8FwZdXuPI8bE93s8/t9een62v7ANhPu1Mvw1t0I+iyLbwYmqPRHdFx52tNc+9sGg+LKmejqynf0S320MrwxXQOnQjctWDV/XyYh1tHsUoa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssxnr+Z+OXXeGs8K2+IJj6eKRhPpAfCjpgwdqB9xTe8=;
 b=ipYkRDbdriA4L6f58bQefd+9px05PWdHVycEF+AZCHvWrKV7fqZ9gH7OMphp55o/zTooaDv82JDuGntlY1bzcdnBf/mjyFw1RqPIea+ARz5w/OUYbdkEoho1IaX/fVy5B8REAF/5wBPk+ZNqFC+UMkMbKNFhL4s9xQK3sDTcWVWLXZE3Zvhy9rzxsyM7OVS2Hh+dKBWviWw1JFa7X4h6R+Usj+Lh9r8D+S0hLDWN0CdNL3ipuu7xBvejeOBMCVFyVWDG+W9i0wf6lagVEyE/tUZNyzkcdBn3YOePupVtOxAVo05fSNHWO1Dhgy2ZdJSSR1QZilGVvQAmDas07T7tmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssxnr+Z+OXXeGs8K2+IJj6eKRhPpAfCjpgwdqB9xTe8=;
 b=g1z8hu7Lzu52mCDftt/fYjJ8MgGSMqFvc9FULSzRPVBAi5nZmF3l1HfuuAhv8kwhgHwe4Okhj4BHn3mYx/eRkbzIT7kGPEtweuXtagcVrvvOVVUDJD9j3amP1mA60c2RIzFh9URv9eGNdjvZqPCFIWM1AB02OpT49bkl9k8z3JhJYpJSr3kseRsl71WzEgOIptfgjnm+wc1ovND9zpIXYC4s6beMsX6UljvBJwWs4Tsx73e1N+8ky1jjgz0eN/2Biq3eeNQa+fXRww/MMgxpNeW4gPVWwiwvc9hvDzOnX3sErVB/+3sQKX/a+Tnulctn4aykRwXmnKpM1j74AphCmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:00:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Mon, 11 May 2026
 15:00:40 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy-next 3/5] phy: lynx-28g: require an OF node to probe
Date: Mon, 11 May 2026 18:00:21 +0300
Message-Id: <20260511150023.1903577-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0028.eurprd03.prod.outlook.com
 (2603:10a6:205:2::41) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: bfef3ddf-3eb1-4089-dc76-08deaf6e1164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|3023799003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AV7fQpOKYeBhhHv595R6HpJUvR0jn++WMqjO7QG9iykCXXTlxs+oUxqZtTRWVY6Ygkf6N4+GBjnzQi7gOY7xdV1L+qROyoEmIsRgnAu513kVkLH9fPc/LMF94PYPGyi0+HShl3mzVUj2XlgOHDCkdewe2lfPOzYMFx8EiUauG8ZaERctvvR3O2d/Zd5AU8YsbvvYPSO5H6WZ27MBE7xBA2p3kgI4hjfHTyBcpzblM2Tu7MfESl/AlqKJafZIj2FWIboNeRa+lnj31Ts9JG+cmBCRvrwJVmQketl8SoKesBzeiVgwnoXhNBzHH/X4DjfkzvYUbro7xAUdpRVxLtGvtzs2DczAKofybKRneRXlfqU0Sdi9Sh1h5qRuhCG/Qhut7+2DQ1GNGHnqlAFrOnbsOpCWgpW4M8lYPBHBfGN4Gx2mRklYUUllWCanqbO2lHBv7wzVPIvGFRjgIVT2fjrsz2uVMImFJNIhit2gTi/opETBTlErvhCOOLBNbqa9HEuuuNKoBQFF/mskf/YTIpcgA46Mfa5DkEfMorRGhn+t5CiXq83D8ZGfVy56h8GycLL6/TrgP3COwJ9b36ATfCFoMAj4oKw9f+3jdGq4UNhdXFDe15zv/4hrQHvvTiWXlT0FkXzv0OzH7AmeAYlcX3HXfWxgLmPKlnwyN3lu23CQgUXWCwO1Puw/bJ/D4mN77t7K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(3023799003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wz8wgRGODD2xX1+rHBl/P9+jZhn983w6XFwC3VPpLXthfHt0GS2CoOlUhLz9?=
 =?us-ascii?Q?7B9cy8Ru9A7A9LZGu5V1QhxE3k987hWUi6iTqvwywwxi26WP5xkEDr4uj9un?=
 =?us-ascii?Q?DvOrrSxMN1aKg2EJ+tDA9CbwfT9dJIwSxAcQtA9T+RPQHcqyZzvxePXXXqZX?=
 =?us-ascii?Q?5QotHRmPfTkUpgxegk2ehB8MVN9aSxednIhDn7XVEKJDdMgn0ikYBqALbR49?=
 =?us-ascii?Q?PqcbiR+tRmBAh6H+oMnxj/65FYrB6TNxIWDDK/83XvgeR1cjtK8JtTY1ibUH?=
 =?us-ascii?Q?mA04oXbBJS64Vetcg/4q9bGv2VkkhVzw9HAlcGnSferQX5n+s3ECNXvMLVV+?=
 =?us-ascii?Q?AFANhmNWmZSkrE7HoP3cyHqV1OYmf4KeO9MB2lEp/yUQR2aZOl6X+Ilogrk/?=
 =?us-ascii?Q?nUwZRf1+umDTX36aGCHP67Wqob2I6VVTPTYbuZKWzVbohE/g3Yf0uxedVjRw?=
 =?us-ascii?Q?jOh09MQi6dkXd9DkUxA2j8rqfNvihfIQbCIb9EPVZALrItmm2nVgPxUiBZwn?=
 =?us-ascii?Q?jSBiSSSqvfdo4OAEPmvv7fsZqXgn45Tis3gkBIkwhTV/0Oi4IevbfGaJfbfx?=
 =?us-ascii?Q?MsiTCmlUIoS+gA6L+cHlmlauxYqNvKrEf4kcTy/NsFJS6lKt7vGd2XpehNU8?=
 =?us-ascii?Q?e4tWL8KXeB8tArjJZ/BMUeYckUgn9hP+6JmN0guv4snj38lK8nD0Sd9tzDRJ?=
 =?us-ascii?Q?zSLRqaAYw7Xdoqyl8kA9I9uLUo/boZuf4JwSioiE1CyhHw/7Y2T8EYbhvV7e?=
 =?us-ascii?Q?rKDt5ipgIbeCJWYTAASD48/tJt6xy7gAQbnnoeISD/Q3ZEmWtcDQqbKS3FdH?=
 =?us-ascii?Q?Fc0k7FLy7YK/Spz5C5BpOt5kXuMJgaJ04HLMgHEb56NX3quJlSzCmHOOLm1j?=
 =?us-ascii?Q?WOgo0svhdxwX8BeJrrnteoY98/iWtLMHiLfdVUquE5KpmHtDYDhuEoldTOnC?=
 =?us-ascii?Q?YYooRhShw96w74DGc6y4801rgbQKD5GTBN92ri3ls07c1gLK+kh4u6hJzmCw?=
 =?us-ascii?Q?s4jwQrAAepAZS64oEfRezCWiBdhuEYhZf3jOzFhHXNYl71ZS4rMx5Rfxdsl8?=
 =?us-ascii?Q?WUZjJynSgjOjAtPEsiEl1/BuWNkBQnxph87YleFw74tT7Q/BORfjVWg4KW/v?=
 =?us-ascii?Q?HnL52LOXFjpSRsksHJ27LkdGexI/LbdSp2TsfcH6LQyaDpSPP+bX0KTaLuNl?=
 =?us-ascii?Q?eh/5WxPkNaQuPUIGP6FJQ+MeSCPGROg+aK5avTJtx+yjOKZFvG7PcRmoNxlv?=
 =?us-ascii?Q?FsiibmMtZ+43nLfSCsCM8Gkv38VMDl1ItZXanFHszhoMSNhNxT8wf4hwjI8x?=
 =?us-ascii?Q?prsqgq+ZBNoE6sVlxnMa4ofZ6TQ0JIZcyl7ipyMSi9Ks5l4uIPYfroCjXEDp?=
 =?us-ascii?Q?0ioOT1tEDSGkxCGG6+1jXAS3Gs8FjvZE25vXT5w44lvquVNpJ2BKOCjo/6Q/?=
 =?us-ascii?Q?RS1hSTkp+e86hYyPy1o0bRCQ8ewQ8hb69Itvg6asQgVjuZWUy/5NV4OLkWkV?=
 =?us-ascii?Q?avOTLHSQkWJjLu9/2JfKUvslOyLNv/2JT6uF7v1OqQeLRzMVrIiSJkdz3ItD?=
 =?us-ascii?Q?i6acLzxbGg9Ls9mIdnminr4mQuV8Guy8gTnEun6s4/1XNkhINLAiNE4D813h?=
 =?us-ascii?Q?uxsYzRWYt2kgBtwfNkCztUeS1ny5z79X22qJ5fen8ZsUUzOPmVbvgPMI7Oys?=
 =?us-ascii?Q?LG8aFuS1UuTP1iFX3Q56qh1lcVaJjgc0pYkTTH1qZZ5bfkE4wdD+MGOfTezv?=
 =?us-ascii?Q?8QQol0NkzA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfef3ddf-3eb1-4089-dc76-08deaf6e1164
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:00:40.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tpfm9ji8i8jvJhxVSFO9m4IL3veA2PACZ5ubIvpOqRFZxeD+CkA1G5y7kEAv6onLAAHXJmp0cLrhzhx4mhnojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976
X-Rspamd-Queue-Id: CA7BC510E20
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286702-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

The driver will gain support for variants in an upcoming change, and
will use of_device_get_match_data() to deduce the running variant from
the compatible string.

Currently, the driver expects the schema at phy/fsl,lynx-28g.yaml, and
OF-based consumers, but doesn't enforce this. And it is possible for
user space to force-bind the driver to a device without OF node using
the driver_override sysfs.

To avoid future surprise crashes for an unsupported configuration,
explicitly test for the presence of an OF node and fail probing if
found.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Change is new.
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 4ec3fb7a0d69..6d0c395d20e5 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1286,6 +1286,12 @@ static int lynx_28g_probe(struct platform_device *pdev)
 	struct device_node *dn;
 	int err;
 
+	dn = dev_of_node(dev);
+	if (!dn) {
+		dev_err(dev, "Device requires an OF node\n");
+		return -EINVAL;
+	}
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -1301,7 +1307,6 @@ static int lynx_28g_probe(struct platform_device *pdev)
 
 	lynx_28g_pll_read_configuration(priv);
 
-	dn = dev_of_node(dev);
 	if (of_get_child_count(dn)) {
 		struct device_node *child;
 
-- 
2.34.1


