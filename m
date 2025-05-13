Return-Path: <netdev+bounces-190092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E663AAB5295
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9111019E38EC
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8C8248F59;
	Tue, 13 May 2025 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fbakbQXH"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012039.outbound.protection.outlook.com [52.101.71.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9A2441A0
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131118; cv=fail; b=GInycmCy3hB6j9AEROKUipBKdXxsgj31GlmzqS2aM9pSQic2aD0sNNg4qJkTeHkSlg/pyU3s1i2KOJsEENBEVEAtDmnP54es6oThDCxOD3d7Erh957yPanNrqk2zlUFW/TXpS76DRiY5oATcJMSkKeq4HPahqHyJsTLaJH5tpFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131118; c=relaxed/simple;
	bh=XKurmL2RlJvQLcVnZ+OQdbzt10k7EX7nvmI8j1in6/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ga223xL6Uf76w47+FQYFlwcNyu+7SxhMGAA4vNXXEj0XLqOQGJLbQ8S68DlRGyZ6GcyuZPId9nogOkknK0OE3IXezzmXLKQ7gJcP7mjQ/z1yXHZ9LF14BE4XqB2BeV6Q6AGxowWu6VEjeO39dUU47fWUitfPgR6gXyFSRTGIj8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fbakbQXH; arc=fail smtp.client-ip=52.101.71.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+eT54NtmiqmngjKiyh+wj8KFKphHFmf6Uq5NP0JchDQKWB+JmvHKgY4NjL3VF/qxzB/ORlCRCDXYkqTJM2SGZWmdWAaOKju5NpvdTLaREbeq5JIUjiyrqvi2bfVtBprYVmEae5eVqupmbQa8hLkiOEbXQV4u6s0/ZRgBQs3eRWyAnlo7RQtFJ9JWe5IGSV10YScfXOMookhgE9f5v1nws3w5YWdYyDAiH0eyeJ7xsqwpD7VAq3Q4gWhuf/GZcferR5AzPmTBWj4P35uiJ5wm7OP6SVF9gwnn1xNe6lttoiAmuBZVKtwq6zE7w/JdfypgWWoiDkgZs2lIvhtJDK9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcIbfHvAoaBdkT6+schuUokasYW3jVrjonkSKVY7wl4=;
 b=gUpvxl6BQzsBmb6o+nYBhNncPs4qSHG9EmUi8uFyzA7/nh4UQnRHTpIsF0k9+G3cMnfebh4jWqMw1T1x64gH6f4QhuP7MT6/xcg6LFXvWa1WkBe1OI7c24/nbU6euiprlDTaz5DS/p2N/gyR85WAwvSKuT1m/sNFMg3wIvmHmRaEOBevIlkCXlnFC298h3t74+pgvEInW9IIOVhXKFMELQm+vD66g+SaSmqmLdQ7vgiYa8QiMc2CcGSODkclKNTiA1NbbMY9ShQukDlptLEqpa14DTqXf02dg4inI19tRcPzW6zef7W/qCOXjiUNt489DlO2yvEBQMRbUHJ2G2Rc1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcIbfHvAoaBdkT6+schuUokasYW3jVrjonkSKVY7wl4=;
 b=fbakbQXHDi+ugUa+JE1RpzHIn/KOczgFTEZJ8sviXJ6DA5VPDh6JyrgG0vVnsDmahPBzU/0p5d1Q5WgoaB0vctXo1YbvPFND26ex7L0FmwROz8gIx4WpVxt34nsLQxHY6oecHhd2PR6GZvX0A7lOR5cozQmPf/CCD0pbPUH7Psj6IGfdfh01un+5XYF6PABdmYmNmgPTR30AGi7AGfnTjck4cLCuIFvCg3PnYiZcMf8rtx4SkbzzbqHzDzfiRht+Pw/Qa4Zd27GMy7g80d2Fk8AylwTZNSGERaTF1Y0eo1QUdPVdWbFarV1+vMH1d9p8ERqanP2jVVes8eTwo2L0mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM0PR04MB7105.eurprd04.prod.outlook.com (2603:10a6:208:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 10:11:51 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 10:11:51 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH iwl-next 1/5] ice: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Tue, 13 May 2025 13:11:28 +0300
Message-ID: <20250513101132.328235-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513101132.328235-1-vladimir.oltean@nxp.com>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0019.eurprd05.prod.outlook.com
 (2603:10a6:803:1::32) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM0PR04MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2dc4af-a538-4d11-be4b-08dd9206942b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?deBHnBRmlU2RRqvO0XgpFbkV5EueatZqCKAujIXNy+RiTcpGWItMhywJrqSq?=
 =?us-ascii?Q?OozAySwYMwAybvvjxQYX0tc2YpuoZFCFjdGV1nvaIVjUlI64Le+ibIZ4QH6B?=
 =?us-ascii?Q?3aBfqzjGWI4rUCUqgKVFmh8rJsS8MU2wF84KSqtGgWAw7g7GNpYM9bfDlEL5?=
 =?us-ascii?Q?3HzkLGSxwCxU5OT5tMqJlMx3rkJz3J96NaHbWo+7A3xdGc015oLkdxoosM7s?=
 =?us-ascii?Q?9O7+0tJjIqmfcx/NoUqslL8RRzrHM1ogaFq3YfH98NtTdEwLmBzUf0060V2r?=
 =?us-ascii?Q?D8dhe0HNZevjMwXHXKeDTjp50JFwI5OrjojqObbV7+xL0GjCWjWWFgL0MHNb?=
 =?us-ascii?Q?hWZYQjrXggm/gnETs8Bt5LvCSM8cccbfFixN+bX6z0ORXu5S3ceShRVM60UM?=
 =?us-ascii?Q?YelJ4Y6cHBTs+DV46fWkORofJyaQZhmwUyMDuetLNQRtP/ME2QtiuyGnc6eY?=
 =?us-ascii?Q?pRTRo5Gv6+s+1Me/Da8U3noR+7bPzF86BA/RIeTdhV6qhIJ1+D6Fzqzu/lA2?=
 =?us-ascii?Q?mTfrbzfPYwoyU9tlcC1Y/oXzwmRVTUyg44jvT6YaQLFSITzX3XNnDp2izF/T?=
 =?us-ascii?Q?UiSyQVWsUw1L4llKC4XHKQBynsU7/95vkacBmiYZOAgNl4p51YiwmBRGHHoR?=
 =?us-ascii?Q?6O6wwYw/VGW0Bv0AGUrnvTQdxmQWi45tu7B5kDkoj42wUWI5j4VGOpfwis67?=
 =?us-ascii?Q?i66LCmEj8yjQ9o0+03UdrfANFqtzmUOCNbLk3tShH/68rJHT+FX1Ng0LoVVO?=
 =?us-ascii?Q?ZrKN60XV6+KKjTGYN3k0h8zsyzGPH/eiXFQPdpBSGjhrHR2ngAK6DRVH1mlr?=
 =?us-ascii?Q?PqvvzAb4WtSmutHuyAwIoorPAt/zNlBXYBnifoWZvEULATak1FOyOmSLmcO8?=
 =?us-ascii?Q?BZ6RRZ+J/QQd5T9X9Gkk7RMlYqAuxcHBxgDiwBEkvURMs43HToaIGFVTjMyK?=
 =?us-ascii?Q?YmI30wDigtptctrSg7GCm3Hp/1cKS+lg65G23zWxPyvPoToynKq/tdBMkPFu?=
 =?us-ascii?Q?v2pndB+u5vZbrQ76zp+2u+rSbfE2TWSqnvZjAXUG+B/uJHO8V5IhGma+wqBw?=
 =?us-ascii?Q?Cwa/0tdd7XognkFu0y4c3KF4VtNZSiaKO92Y3MpQEK8I3LK4zscliFaaIDqZ?=
 =?us-ascii?Q?DVitekT+pEdLCzWy/FhOcvdqllDmHae0ojBET7n9KQS/CZBthH53pI7YtvIy?=
 =?us-ascii?Q?MY6il1/QF3ZghKCv6Rf5DwOGRC13uQDEuDMyUK6aacM1mgphst/B0M0i7QSY?=
 =?us-ascii?Q?4L8iOlRgR1WLVpY+V0LBoouHSRPtwtVMPCspM3OutkPDSoBFCaqvI1w2Hh9o?=
 =?us-ascii?Q?YmOMor6XI1cMsQu3FOxL5M1tKwPdkZHjVbYL+TK9OF2Wq4aMN6SHxwbgWhu9?=
 =?us-ascii?Q?Mom6SbOrVureVTYohYUi3IesZbe75+k4B4wBkHvEY3jBp0IVnEOIqnMx6GRw?=
 =?us-ascii?Q?JUd2ZVD6x4ndU/NvwJQ3Eod1+29UBBzuz8c7pH5SjyXrCIRfb5/n+uys4NsP?=
 =?us-ascii?Q?Ad9XzNDT5riq5vY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lKcLQ5buehFdga8brveDbunZvSuHwYIuYDyqpGE9Bjjzti9ET25bT2Jm36A6?=
 =?us-ascii?Q?fQdDcl9cy5KlUYlb4TyHRDcl4H5qvTGR5XBoAmTXJSKvk0FKjWSTmI9BDKHT?=
 =?us-ascii?Q?5I83vQMA22l5rx453Qa8Lg/PDxY2tiMBP0HBfhAaiKwPUMwdLW4QOSuGW+HA?=
 =?us-ascii?Q?SCRSMvdznMFFXJ2Hcg9erY0qNPagisALbf7sVIpMHNkn7bnocbGML2KqKFVf?=
 =?us-ascii?Q?U35CQVDzfqKNm6uLVS5DyGjTct5S+qhRcD6ntxRM56FRKEnMwOurNBIwHee/?=
 =?us-ascii?Q?92cjrj0xsJdXJlHEv/VyZyA7XOysk43X7GqSFruWQ1YOjkW/EvSwYpld76sR?=
 =?us-ascii?Q?Q+2+X1bDWy/fHlNaYAPnUdQRv3h1YeUnFVFTFVJOcGEqNv/OBBmr+WDCZmjJ?=
 =?us-ascii?Q?VyezR9nbJPJSm2P2cCxOQ98pSSxyJL7ubZJ35m10SsKBvMQGXtZSdAeYrX3Z?=
 =?us-ascii?Q?MaLUPpl92Ik2l3kXs1KFlJUwUBbjzH5s9nhp4PlW13bzNe7M7Az9nTTudRDx?=
 =?us-ascii?Q?F7D8jvrhMkcmH8ZhyqRb3K5Zg7FPRHwT1unmMQp7Ko/QNDzcYt7y4nH5n7aI?=
 =?us-ascii?Q?TJ1tJ60KG/2TdDfLEIrqMcFgGuKHND1uwPYhMCG3xeL1q+P+CXNDWaNxNHfo?=
 =?us-ascii?Q?dOby5nF5s/k9hqX48sR14Ztp4c6d/Ul0z5GnbjYSy+Y7GVz1d9cRpqoB/aEI?=
 =?us-ascii?Q?UyVQgHOyXdo+o4gVYAwalqF2GCAH5h7DKsnkw1z74Wz/ailP2RfjYU08Wrnz?=
 =?us-ascii?Q?PjEREG7isQ25iMOA0EAvUCZa3bOnP1kfm5ZotmmRhUbDyHJV6Q1XkBnqRbdC?=
 =?us-ascii?Q?Rf+UMDQWwxCjgth5uA3CAEAdDCNWHLXr5hEnl7bitRDglp0I7+MaIUNYFtoP?=
 =?us-ascii?Q?5UCtAVficLKB14gBc2bdOVUrNINCs8liPQzUyuCXa3HKFPitm3dgtXK6xz8W?=
 =?us-ascii?Q?+t+6wZp3hF8ZMFw5wpHOlszyuAZj68taG/HEsfAFnsPFgwbfxYOEtte35aOc?=
 =?us-ascii?Q?J2DJrJMQwVl18KURg9OSjtQTA49GGCoYcWvN063We0cHZ/SqpubwToKYbHIp?=
 =?us-ascii?Q?uTGvbP+HToLN68zXfHYWH380FQ4jpqV6dgYpcC3r8E6DhihBRyejbK+DIt3K?=
 =?us-ascii?Q?J+f4hlFuyUCozYSXJlUc5RULG/rU6dKWCgN9qyl8veaLL3jaHfWX3kQW6Snb?=
 =?us-ascii?Q?DPkfOsdwwbgKX1XDMClhpE6lyTMCrq+rcURyAetresIMwHQxMQhbu++TtlJ0?=
 =?us-ascii?Q?3IoPdRUUZVAGlN3pxhw8W9AZk+2OfeQSly2CRJM2RQh4fwYJ+tQ0fQxAldIs?=
 =?us-ascii?Q?eF5rzRyh+XnQ3bss630K1ifNvPybmqDk8dMhw9/17LFMKcEhk0CDyf/vsSjM?=
 =?us-ascii?Q?yLQSNrToQblIVL0wu3vjP3FSgCEbvBdJFdNqfFugODjgb2OQ4Kmx5xbKIAZS?=
 =?us-ascii?Q?1q8Lf9NBkK9f4CB6OOuQJ08r1K41h7JfmsF2yg/FLBk2nxf44+W/JDSyzWmF?=
 =?us-ascii?Q?tr6aeEzO+UHLzYZ1OkBYUv9OUQxkyCgUpWTT/oMZQUDRywumW5QLQ4fap70Q?=
 =?us-ascii?Q?2k1+JEC5pF7214DA41YjUe6/aw94wTFswRCQBUK5QvQTm+xFH7f0+NNrqxF/?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2dc4af-a538-4d11-be4b-08dd9206942b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:11:51.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG2CQ9al/hO/u1uVyGPSjE8LPGUIXtysSYasBhNiXJrWgnSTebppqRbncjrt6PvpAEWOQOX20UzMaEIyYXaiOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6.

It is time to convert the Intel ice driver to the new API, so that
timestamping configuration can be removed from the ndo_eth_ioctl() path
completely.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
---
Previously submitted as
https://patchwork.kernel.org/project/netdevbpf/patch/20250512160036.909434-1-vladimir.oltean@nxp.com/

 drivers/net/ethernet/intel/ice/ice_main.c | 24 +-----------
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 45 ++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_ptp.h  | 17 ++++++---
 3 files changed, 37 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1fbe13ee93a8..674d90d6a081 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7880,27 +7880,6 @@ int ice_change_mtu(struct net_device *netdev, int new_mtu)
 	return err;
 }
 
-/**
- * ice_eth_ioctl - Access the hwtstamp interface
- * @netdev: network interface device structure
- * @ifr: interface request data
- * @cmd: ioctl command
- */
-static int ice_eth_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
-{
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
-
-	switch (cmd) {
-	case SIOCGHWTSTAMP:
-		return ice_ptp_get_ts_config(pf, ifr);
-	case SIOCSHWTSTAMP:
-		return ice_ptp_set_ts_config(pf, ifr);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
 /**
  * ice_aq_str - convert AQ err code to a string
  * @aq_err: the AQ error code to convert
@@ -9734,7 +9713,6 @@ static const struct net_device_ops ice_netdev_ops = {
 	.ndo_change_mtu = ice_change_mtu,
 	.ndo_get_stats64 = ice_get_stats64,
 	.ndo_set_tx_maxrate = ice_set_tx_maxrate,
-	.ndo_eth_ioctl = ice_eth_ioctl,
 	.ndo_set_vf_spoofchk = ice_set_vf_spoofchk,
 	.ndo_set_vf_mac = ice_set_vf_mac,
 	.ndo_get_vf_config = ice_get_vf_cfg,
@@ -9758,4 +9736,6 @@ static const struct net_device_ops ice_netdev_ops = {
 	.ndo_bpf = ice_xdp,
 	.ndo_xdp_xmit = ice_xdp_xmit,
 	.ndo_xsk_wakeup = ice_xsk_wakeup,
+	.ndo_hwtstamp_get = ice_ptp_hwtstamp_get,
+	.ndo_hwtstamp_set = ice_ptp_hwtstamp_set,
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b79a148ed0f2..45aa65c190a7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2359,23 +2359,24 @@ static int ice_ptp_getcrosststamp(struct ptp_clock_info *info,
 }
 
 /**
- * ice_ptp_get_ts_config - ioctl interface to read the timestamping config
- * @pf: Board private structure
- * @ifr: ioctl data
+ * ice_ptp_hwtstamp_get - interface to read the timestamping config
+ * @netdev: Pointer to network interface device structure
+ * @config: Timestamping configuration structure
  *
  * Copy the timestamping config to user buffer
  */
-int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr)
+int ice_ptp_hwtstamp_get(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config)
 {
-	struct hwtstamp_config *config;
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_pf *pf = np->vsi->back;
 
 	if (pf->ptp.state != ICE_PTP_READY)
 		return -EIO;
 
-	config = &pf->ptp.tstamp_config;
+	*config = pf->ptp.tstamp_config;
 
-	return copy_to_user(ifr->ifr_data, config, sizeof(*config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 /**
@@ -2383,8 +2384,8 @@ int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr)
  * @pf: Board private structure
  * @config: hwtstamp settings requested or saved
  */
-static int
-ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
+static int ice_ptp_set_timestamp_mode(struct ice_pf *pf,
+				      struct kernel_hwtstamp_config *config)
 {
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
@@ -2428,32 +2429,32 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 }
 
 /**
- * ice_ptp_set_ts_config - ioctl interface to control the timestamping
- * @pf: Board private structure
- * @ifr: ioctl data
+ * ice_ptp_hwtstamp_set - interface to control the timestamping
+ * @netdev: Pointer to network interface device structure
+ * @config: Timestamping configuration structure
+ * @extack: Netlink extended ack structure for error reporting
  *
  * Get the user config and store it
  */
-int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
+int ice_ptp_hwtstamp_set(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config,
+			 struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_pf *pf = np->vsi->back;
 	int err;
 
 	if (pf->ptp.state != ICE_PTP_READY)
 		return -EAGAIN;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	err = ice_ptp_set_timestamp_mode(pf, &config);
+	err = ice_ptp_set_timestamp_mode(pf, config);
 	if (err)
 		return err;
 
 	/* Return the actual configuration set */
-	config = pf->ptp.tstamp_config;
+	*config = pf->ptp.tstamp_config;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 3b769a0cad00..da9bfd46d750 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -262,7 +262,7 @@ struct ice_ptp {
 	struct ptp_extts_request extts_rqs[GLTSYN_EVNT_H_IDX_MAX];
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 	u64 reset_time;
 	u32 tx_hwtstamp_skipped;
 	u32 tx_hwtstamp_timeouts;
@@ -294,8 +294,11 @@ struct ice_ptp {
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
 int ice_ptp_clock_index(struct ice_pf *pf);
 struct ice_pf;
-int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr);
-int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr);
+int ice_ptp_hwtstamp_get(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config);
+int ice_ptp_hwtstamp_set(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config,
+			 struct netlink_ext_ack *extack);
 void ice_ptp_restore_timestamp_mode(struct ice_pf *pf);
 
 void ice_ptp_extts_event(struct ice_pf *pf);
@@ -316,12 +319,16 @@ void ice_ptp_init(struct ice_pf *pf);
 void ice_ptp_release(struct ice_pf *pf);
 void ice_ptp_link_change(struct ice_pf *pf, bool linkup);
 #else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
-static inline int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
+
+static inline int ice_ptp_hwtstamp_get(struct net_device *netdev,
+				       struct kernel_hwtstamp_config *config)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr)
+static inline int ice_ptp_hwtstamp_set(struct net_device *netdev,
+				       struct kernel_hwtstamp_config *config,
+				       struct netlink_ext_ack *extack)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.43.0


