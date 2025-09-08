Return-Path: <netdev+bounces-220833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A5AB48FEF
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 251577A2340
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC6930B52F;
	Mon,  8 Sep 2025 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d6cclSH5"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC5A30AD05;
	Mon,  8 Sep 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339012; cv=fail; b=RC5fKl26Rkn8fenZfeVCQcMkE8LoER9aJNpPcR84vN9AJUVCymip6EYPfuefFkMUPkWbBKyhge/47qbNz3DDWQM5KD9Ya832GyoX4O22fHNFTTBPbLbuCL0GCRBvGGHL8gLD6FNuaZArMp1syTHGExHhUzVTqRNUgpM/v5c+5bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339012; c=relaxed/simple;
	bh=x0zBJfGnAK48ENlsVVggy2Ec6X6bC31erSEKlAIbYW8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=okrJMYECSBSQgToToIxE5YiLXkNLS0g/J9nGTDR1dX3Kn3FvRpKvSukwlCPrBQP5I19SYhsPs4fGpigq5AGz9g2zlOfrTrWDuuNFkJOy9guIDmkNsgxDyrxq0KexBaNaDMHciEzO6LJeEVLmLu7OZEIxsd1TUt9xRb16gHc63PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d6cclSH5; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDID8QkCoDsxRq+u6lDliZRmjE7RtsOYzieyRQGMytryUYXpYqqLVXi2yvrz2uoCAPiA2Mi8e7QiukSCX1rkWrIQVDG8lG4yeehd1gQGAGG16CqX6CR/+y/AJzqhJmg3dIX9K3yAmXeo1WcC9sijAodyY0iGMopOB2UAELBFmoZ+syzw05n4qnRsufkyTcCNU4yeByBVn7HPyaHp9lYzQJLYNZfBA6MGOoHW91FaysrZiZ+dteWiCNrx4WIdyd814iH2JghU7UI3Ny8Sdiu41C5KZSR6nEc5O/GSvuSQd9nRO5dq4lyRqZLfpyWE5WISk7phrhFHu7HfcsTnc+ZMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVOXPdcamEddBB8rBSmg+nCA/+QGWXyVtxcV8y1Kgfs=;
 b=N/9JyIiwYglNmbwY5cgIRZMkoEPfzWFkOM6GyFIM+etFdSZs1JUxbFtlBEqGqmxAmvMcvvGct2j08qjzXU5KOLd4PzvBNc9Vr3N4Gvsl8wgN+x7tndtYtY2z2ji7xX0WsLsZ7QGV0z2r1uknctj89fYeyI1TFMEmxtMqhCok/zWHxgKfcerbPK2MWBEHvoLgWwLrH+9ClsUhqWFqjV/N/Gnahcya4CdTmVukpUkfMbT5OMNtKvqu/O5omSFL+YxwAZQyMRIX8MOurODwZiSXGZdGPbH4LjJijFSDTfSlnlMXrrTd7vbYJFDyg0ZkmMCmB18yvRxTaGwJms5ay+fZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVOXPdcamEddBB8rBSmg+nCA/+QGWXyVtxcV8y1Kgfs=;
 b=d6cclSH5ghqbRe4/ZIcZbxMsp/MyrOo6kIzZGtmu+FVSeDXfdHIk/Q53qxHGmRn3HaatnrHpQTnwySvsDuUSYG36MPpmlj8oFNxh6taEGSBDhzDagk4LkJCHWiEDX/bp1uiGP9FDO6VyXkAqG4PdmwBkAPhDaTs+7p5EqHTo/Dk6dMc9JmxKYogpMsma+ki7S7Z+tuCjMMGog5+WygGvWcmubsznvEZ9vM5nw1i06Gd45dXzBMyDHZKUayAtKtLvGDqwBUANRgLFnAM0VeHyhkXx6141rile8PGudW1YlILakLggvdsmJc3zITnxoZIP1o+O1q+/vWR3YI/BLlVAsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AS8PR04MB7799.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.10; Mon, 8 Sep
 2025 13:43:26 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 13:43:26 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: aquantia: delete aqr_firmware_read_fingerprint() prototype
Date: Mon,  8 Sep 2025 16:43:13 +0300
Message-Id: <20250908134313.315406-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::26) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AS8PR04MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c612825-406b-43f0-6eb6-08ddeeddb006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N9m3n7zPdnGYIbPVAT90kWpEtPUTAMXFDgrkNK1XiLrDGGnpj9xMm9+t5T5y?=
 =?us-ascii?Q?mZUqgubstjOfEt/q+Fuvz8GsnRFi75wggbDaQTu/UgWuUjsIQ8Y3Kz6XuUr4?=
 =?us-ascii?Q?Xb0K5Tm9NyI9u9FVtAkSxnYYR5Rp8XubGXmYuBemXYxEZ4miKntHura8HrVj?=
 =?us-ascii?Q?V6VNOWaK2ybv+jQiGKAfk/FFLCKVoGoweqztDxOgiSCcDIrRHt8Zd8LH36/O?=
 =?us-ascii?Q?nBHVnRUB8VA7a+hGvWaHKOM8oKuXNUhtXQR6gznlX3gugrhEfMlR5AfXugfp?=
 =?us-ascii?Q?UlpoQDFeI++r/5PJmayM2JMGZqcNyEd/aI3Yw8F/SmDQkmtw3jleSSZMIJF8?=
 =?us-ascii?Q?khNKXxfAbMRrGq094AH15aT9pWEQQFtq+lhEUnKFeBWncHPzIk6xj5haOLyv?=
 =?us-ascii?Q?gMeqn0x4KFGpC+K2peDH3MzHLLsu4l0GQI1YgSBQmAuUJpxX9t2FGAhKnIsO?=
 =?us-ascii?Q?gQt1pffjdrdXeEQqBdNDyk3vNrsvhOQsEeLHYPSjGVKGtGQ7uSHLgr7rl3+8?=
 =?us-ascii?Q?6U0zwmGQKFeNA0KKGQVx2rv//ljVrx0q/wiyZQr9saVtY64v3zCJ0fopi9MG?=
 =?us-ascii?Q?ZhTHBVby9GCSF34bBzeucpDQYcZzBDNnN5a8fAMwMCZ8CH6L8Bj9DRccidsi?=
 =?us-ascii?Q?74XCxo4CjREKm1cVtekRT0ggcsS7Uo3KZbjThUWnCnRz0NEMIpl1nBvmNLLq?=
 =?us-ascii?Q?2gA0b+czGjnQ2us4jHvWDr+FMwGRG9GsK/yHqTF2QdIhGCzOBK66Iyz7h41Q?=
 =?us-ascii?Q?j4VIk1F0flLSqWyzDEF0sZCazeWCXl7el0adHqg9F1CfGhpBab/iy7eUrDPL?=
 =?us-ascii?Q?C5jZYrDlnyt0CG1Mn0KVR0GyFuH4dObVTbC8ret+EppBvI0wnW1+W7/YDTwF?=
 =?us-ascii?Q?KJn1wg0yycENKCTrW0NsTJSF0CT+/bW1JjKNm1I3GRX6MJXidm5wH5rZrBrz?=
 =?us-ascii?Q?MIoQnVyNLI/D9wQqwwGZEpvNVuITo9QKfHu9dHLON7qQcRYrGTSK04dr9aMs?=
 =?us-ascii?Q?vgSERQAKj1gsapZpA9zVfJ9B1f/RNgeY8TWiPKfKDFhpXPxXxJBUY/5FHsZn?=
 =?us-ascii?Q?M2v9Ia1J1KN0iNaP0/2trVi3Jk8xp3dYaMfLQAq/lN8xemeqGj1XnBscgQKs?=
 =?us-ascii?Q?Ms62Bg+JodS6lWe3Woelnv8tTQ/Bc4v+0qVtNnePKXCuktcCYobHQMW4sOSj?=
 =?us-ascii?Q?0A95+0ZWkTeHSe4nXOhBC7mlwtanFKT3DcIz9SqgcBPpX5JoareQQYSb73Ks?=
 =?us-ascii?Q?6vVglIAFCfbETyJAHtz8CW4K1WLIA3ittRk+Yav9FJEqhNfBDqs9Odq+8eCL?=
 =?us-ascii?Q?NcZfdc9vZMhq8GUJr8gITdOlBzCMBblLJvSntBP8K13tK+IYBjpO8qX46Gbo?=
 =?us-ascii?Q?+EDh+aEdFe3LOQrKQZi7JGoINfGbGc0Vkvgw2JKAF5Pj0ElicKdIyHmbnico?=
 =?us-ascii?Q?mBak7ImUOF8Ods4FO6DfC9ZtrW0Jc73aB90zvNxakpic1WdEEgdCKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z4y1EJUSLVf7cicGSnJpKvSUbN1KIxmmBXpo1AZjVk4uui5cRAd6urMw9PYM?=
 =?us-ascii?Q?rKiOSUFA73Ee3IpHs6qXidDxlK7O5d+xLpSji/2dmQabGwObsVrPb1WzlQx9?=
 =?us-ascii?Q?54Nes1h0z73rN/o6Pgzqj/l7N0Uys6HCkm25MpPUD+LXnaOGEdqgbU/sOfyn?=
 =?us-ascii?Q?ZYWML/mezUzWJ+u8dcZPtyH+XEN+k7OXBCXY9NEoREpMH65XKSD7Sv7HPuwW?=
 =?us-ascii?Q?eOKVsG7neZ6Tpj1ngdZ0Dy3XrR8criFRlg/dh6LDkzM2Q9AUb8Hz6q9Fwl/p?=
 =?us-ascii?Q?+SuqwuPEofg4K4awh3xjnHkXLsqVvgzJcS+OxaevXzUQ+UhDKPWCMlUyQCQm?=
 =?us-ascii?Q?nVnd79NwvzFVIEER7smyB0QplQyl6+zrJtyCZ6gv57ZXkV4mhZ0QHvb2eDiS?=
 =?us-ascii?Q?/tpvIYfaUstag5JLPfTrlzt6jYnMQMhY+Wi7c92OKThVOm5jN5xHUAA8+s4J?=
 =?us-ascii?Q?Kt4j9fcjlRQicGOkxenpGGPr6Ft7KcZ40Z+opFVTuwfatPd8ziQoKd8AFvnV?=
 =?us-ascii?Q?q7+I0+XJx1NDwQgt/F4f+D6E9WObKNBH1bjiVpXK2zm2f/HqnYEz5yejUWuy?=
 =?us-ascii?Q?+zHMShtwD9/Lp61yS5Rm+7bqtM+sD+TTtbGauSsVQgZiipPFPOpihcxLj6vT?=
 =?us-ascii?Q?ZErS79HZyB9psuDCYK9xfffIuMj6w3luzcXR009ZtyJAzW5p898rqRPLlTY+?=
 =?us-ascii?Q?APnRYMNnzFCO1RkpRuX0vCFHrwWv7O4B0K0cVTKpw71mObl2mR6DmTIdm1vj?=
 =?us-ascii?Q?tah/PPZWhk1G8n9kzdMETsHRnkZOoJricMrGfjHvLsTU7hEElN6I7u18VaUW?=
 =?us-ascii?Q?jyhnJzDsZOuj5c/d8T3kvQGUpkGml77PQgABOnH1HHS0qYofqu3azIaLs34O?=
 =?us-ascii?Q?sSzA8An8rIry4Ra70sOFeOgms7d0hZld7XFInGTqkp40mCmvNS759dWY4Dpz?=
 =?us-ascii?Q?jMIXO7Ba5RLYrEJIVMhxpAI1mOYS5jUZC5HcvH0il3FrEUQrADljxsr0RUHR?=
 =?us-ascii?Q?w/acoFJFSQqB2nl9f8C5KcHNz802cgbwnaVKGEDrd8++zIuEkR4CmxInaa9S?=
 =?us-ascii?Q?EvqnO1E2S+QI5YkNxqP+YgHbl/3Ah585eKS+GIwh+GvxnyiDEncl7FSJiUvi?=
 =?us-ascii?Q?U8ZQS0nNGGU4Iub6oruB3hdKxk18Uq2EU4pS2X9w8FTBfUjW6adCuf2qfNZ0?=
 =?us-ascii?Q?5HM/lddKN0RTQ/GI+rkxmC8r0HGrolIzWC0MkgtlDfaQGO7wH/HCXBPEgiFp?=
 =?us-ascii?Q?r1Wy61WLAf5ujeCZ2w/OJoTyyZXZsO6HP9/talPbB4jKxld30NWewtW0fry6?=
 =?us-ascii?Q?49lo/v5jicMl1KzfAdpmQAp82RmrPU57SRRJkI86nyjt+e74f9wNwP57KFF6?=
 =?us-ascii?Q?HH9yCMSi19X9ZtzILZTUReR/zVWe1T/F6aZHhtTtw+K7O1s39djAZC0Rvc/F?=
 =?us-ascii?Q?wAabyLts5Q/E3elLDt2pPiDd7IpOMFAShEelVnz1/zYWc+HEFgRvJ32CWhBL?=
 =?us-ascii?Q?89au9YBXsmUioQAaFtzii8cla/ktmTMI4yaBOmr3lsJoisGX8H2k+C1lGfIX?=
 =?us-ascii?Q?ySfmWbtofGoOmpelwmQlNscY9XGx3YeOeyyMCjSDuxEKGPAXNjaGGVPNmevs?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c612825-406b-43f0-6eb6-08ddeeddb006
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:43:26.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yztReoiHnjpZgLkRt4ELlxa8eYJDewFNS7ERPwNDQeXH9DFAr1/M5dkU98byZz1piMYqve8gwbGRxqisEL7Erg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7799

This is a development artifact of commit a76f26f7a81e ("net: phy:
aquantia: support phy-mode = "10g-qxgmii" on NXP SPF-30841 (AQR412C)").
This function name isn't used. Instead we have aqr_build_fingerprint()
in aquantia_main.c.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index a70c1b241827..31427ee343e3 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -239,7 +239,6 @@ static inline int aqr_hwmon_probe(struct phy_device *phydev) { return 0; }
 #endif
 
 int aqr_firmware_load(struct phy_device *phydev);
-int aqr_firmware_read_fingerprint(struct phy_device *phydev);
 
 int aqr_phy_led_blink_set(struct phy_device *phydev, u8 index,
 			  unsigned long *delay_on,
-- 
2.34.1


