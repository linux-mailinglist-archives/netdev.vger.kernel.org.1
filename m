Return-Path: <netdev+bounces-115281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C3D945BAD
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B2F28275D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EBA1DC489;
	Fri,  2 Aug 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="SUvVxVMu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2138.outbound.protection.outlook.com [40.107.237.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6E91DC475
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592806; cv=fail; b=WjRrKywj/BReCWwmffezAWku/E6DwBBm0dZwqIWIN4EF5VvjHDPtSd0BEb1pkKUjhS+jKlXkK38IO01cU4piEdxa1I9HnHiaQOwq2dxyjcVlXq6ZKYdgoxdYncMB3CgEtVM7JHUMPNPFHOLs5QogMPQbIakBN5i+19k34kET18Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592806; c=relaxed/simple;
	bh=9g+bei231FfMsnjZP2q9vRFreo0hIoBRKDdWdd5fyUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c0zb1As1HCHJWJnCuDTu95QpEK5buS8cOO5tnCdgWGpKQg5sc9GF4uFA2hLsepSR3lisfSOaXV41wpHqBgPo91n2FRsJaK0/aHOkQWMp4W0Gi9dVjRKB8p8zgWCZIXRiKNw9xCh5fSBCNznpFKPNRENKuCHjfOmCR/oKCVxOBRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=SUvVxVMu; arc=fail smtp.client-ip=40.107.237.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQVo1/amV1FAgMkzNaP9Ufr6fW31hdGOw1bwh605CQ8wxelRip/vLOe6Q/0ve1xTbpV1Sb7uWZ1crTYBW8rdZa/KChiySzfPxCMdkVVlW/aGDfpLuILx+u2VTeqF1BomYyy1c1c2AP0y1X7e4YsGtHNJnSgDEaqiAlNC47MqUDkjyqjQF7rz0/n5WK2ceD/9TLZ0koMaCsrdoKvsYIaiBxY++NWFlGf0XiyP0mk9UAfoHJVoI/2U+PGk7W4cET3bK4mS+b+twmJSK+pew+VpK+zCYvSEaO/bL8NvkeDIa1QTZCLxZzgZy07fK9EscUUxVJit6whwFIEYm9QcrKMbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJChGhYuyLPx9nvirlyun4UR5SQv/Wk1hHOfW5SZ4Hc=;
 b=Y4MM1E7ZD9ssBR0voMfISd/f+CxjtxvPFyGsKgsc9mojT/aZYxsqDtZUYHnvnjX5mfABfhbaFz8pd/lISVvEIJR0Rn8qO7cyJXDRx6r1t27ojGzvg3wMW+5bt8urn3sjxuh5k4qXw6x4M/k5Ii99NmhuhLz9eKC2sVzz0qhjPcf6QBqVDdx/oJ2x6L3GwjvFNyFn5WV9l0cqUQleB/X5vXW75n8kAG/gPtMPc63Ub185Jh/7WWKq993HPvZ3dTG0tD2HRU2XTS9dTstc/nFVAS55CfRxbpC+gnUUQReqppGSXx7kVLNhFUR+iWokznzfZBfs8aPHnHonbdchoncwjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJChGhYuyLPx9nvirlyun4UR5SQv/Wk1hHOfW5SZ4Hc=;
 b=SUvVxVMu3wMPBaIVS4G7em2XNxMsXO3r/9yYYfjwE7Beqt28WfnqruB7ENFAO5iCO5ulyoIF1ewY+1nzSEKgwn9BeWVPjgnnC1deyZAk2r1DGEzaZGM118SXOAZLfaftCxhQtfDF/8cDux0nav3YZLSwk4FH0hJfAB5fo7baixc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DS1PR13MB7169.namprd13.prod.outlook.com (2603:10b6:8:215::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 10:00:01 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%5]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 10:00:01 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com,
	Kyle Xu <zhenbing.xu@corigine.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	oss-drivers@corigine.com
Subject: [RFC net-next 1/3] nfp: add new devlink "enable_vnet" generic device param
Date: Fri,  2 Aug 2024 11:59:29 +0200
Message-Id: <20240802095931.24376-2-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802095931.24376-1-louis.peens@corigine.com>
References: <20240802095931.24376-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|DS1PR13MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 9597057d-ebed-4cb0-956e-08dcb2d9e024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rOzDiQWjO0UCfweBxn6oWmInlW/I/1mJ5Ps3KuJIWVp484IvNh/rGlD+To+X?=
 =?us-ascii?Q?Ql4VC8fEqLN3manbJ/rY6WAgVwIVvsH9H6saf7+vvpd84UZZOYwSfPu5L1b/?=
 =?us-ascii?Q?LCAWEcY2DX613MFaxNW+VSHMhPHGARLRH6B6vvfiGYQdUpWxv3EMgw6s3Kwr?=
 =?us-ascii?Q?1Sqq+fKrXJxad9zo4fzdXOoTofhVjc3/fqqI5s7mDVnEZV/mIsylvmA9oCdu?=
 =?us-ascii?Q?5MK7LTm4DfGUNjUu0yBqErfO9n53uXOU3yYppRWZl2uRrBz5TPoNyfsX4xe+?=
 =?us-ascii?Q?Buf2gDOEJ8iZLwyK86uuV7vh8qYHCLFv2KtqA42Qd+jAo0ANBUpviCFQvAIn?=
 =?us-ascii?Q?b5tfG+tp9fe90xguEoHp1rQfeXh4/o5svIKQ98rQfZHKqvZaB2btCgbgl+Qd?=
 =?us-ascii?Q?QwUBUFB32CLNboTT20UGM9zDM7Q4rvOyZD910Peeu1weIWSJJJ7XQsAyuWbU?=
 =?us-ascii?Q?F209t8WXDP62eyh66RCMmzapX637I3zvI5oshcjKt+WjgB8tZo9tQARBsSDL?=
 =?us-ascii?Q?cbpsSCWjorKk3OSLvVZCYFODgKG8hUGPH07oVWInhCdgP0kOIlBBQWkfnS0z?=
 =?us-ascii?Q?7F2Qz+K0216+79fdRCtBlU1npDanZAKyJX8JW1c5dqPexxyrqQMawWcdBc/B?=
 =?us-ascii?Q?oTpZgSPb8PtXM1yFKNsqp4SOs2/fYBLuzF9+a8I+vaQS7+SAH0HjBW7OK9RZ?=
 =?us-ascii?Q?7wXRcUI0/j6zN9dxwNLQvzxqE2vvxg/k9g+1Y60nrPJSJ8a7ZeRMG/pbhkzB?=
 =?us-ascii?Q?5uiyWsDg/LcPNWn5v9zcFdiatzBG+SvgLSjah9k5ymtQ+0jnMlW3g/Eo8Xxv?=
 =?us-ascii?Q?dHNw2wHOsBB3+2YCcuM1DNW76srMBe4v3cbNjpGft5MEYnXQIEhMGKc3ac8Z?=
 =?us-ascii?Q?WoSqPTLvg6YWkQq6l5vE9P3nlVa5wKx/LPRhz5uuVzX/h9J+2PJKpFMGqm3e?=
 =?us-ascii?Q?MQXhHKM6akqiV0p7kjZAsOAnEzl2jhbZFezrAYsuhn50K5Ak+1uDZ7GWMU7L?=
 =?us-ascii?Q?OoEM+PG+I2UT7e11Yb/75Rawp4gyw1NFtmxscz/0VneEQqe66n7dEXGK3COD?=
 =?us-ascii?Q?RHNBQ+L/CEsV7DQ1DBDDDVlUzRFeK0lNyfUSBw43x1DLJ6Il1l8o4eWgsFEk?=
 =?us-ascii?Q?QKZx2ZK4lmFs+m3LC54dPL8q0UVEakqHiTSfZoXvWLaD4jue+W7YUMAEvgsy?=
 =?us-ascii?Q?2ICTR1r4gA7cR/ddA//KVVLLD1Dle+rLhVaj7FiCwg/s9KGhbngR1bB9oZi0?=
 =?us-ascii?Q?BiccP6cQVEHPF2CMeC6gYeS00gUdyKeZsnQDtF3ijw+IvYgwwaW2xXK9GY0c?=
 =?us-ascii?Q?mTh4GDi498wWucUZxgVDmZ0zwbqaT8nA1uJk2ghhoXcbpmdGxKLCTC/z7xtP?=
 =?us-ascii?Q?JMAkFr/cyzt3/z+RgV0YEZWbF5VtQhDMmeWiaQSv0bYLHWgFxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dC9UQI7Is6kg/yHy/9Tyr+QqPDRe3vMaMIKk3fjn2VSfc4OMEoIRm0RNdvXl?=
 =?us-ascii?Q?DhlWDqGYn0OdZUsUs5YL8bqZSS+0qiiJPOm2W43SMvfLLFZL1BCJLDJloaoZ?=
 =?us-ascii?Q?gdPOV+PRSSvCMWuHN+BrfBRdgd002Hg33AqhMqJPBAfQU2pOgmHarbfAIe4q?=
 =?us-ascii?Q?5ETdt3/6KwG59alYbClq6FNqd1nCjGPRpPcxZF5baE4a/KkpAms/xCz+IGu8?=
 =?us-ascii?Q?IfucDz5SxGqaIzDlXXozagXHhGYrVtyHWNZOMSIzsgQmVn4GhRULM7YLRWBf?=
 =?us-ascii?Q?P252RE2Q+4WDGkRUapYM1CYreWQfTW4EB2Rxs8l/lKss6gopwLn/pp2eg6ZN?=
 =?us-ascii?Q?gxi0PqELaQvGvCSa8abFCoSq27q+r6kU2iVhDzoDQltPltTVuunCUYwiDPtF?=
 =?us-ascii?Q?siRuTJ3Pl+iu33635PW3CGV8jJpOHjWTpYOALSSbnFt6RmlJp7X6cEhYME0y?=
 =?us-ascii?Q?qn2Mkg0y9kA0HalbMIs+PbAMMxmwK/mstmZpHnYT34JZR2//opP4zF03q+V3?=
 =?us-ascii?Q?TERDBAiH8HrYdG0rNRWLpBjt/AHM2rMa1Ql/AjVCBBcko1bWcX1/y/r6Pz6k?=
 =?us-ascii?Q?Nl1zcXdGaHjh5pobGQ0rwo08pyKo145IdTXceeTyGLurmhe+sDPzfEXqWgwv?=
 =?us-ascii?Q?WJU5x0v7Ze66xxceeN/Uubu71ZsHAHJaQqGsKvdi+iKVIfDR1jndsAlhSBz/?=
 =?us-ascii?Q?M+9ei1t+HHDFNZD8yjaGY4EwKHI9WpeiR7lokSGDBdymDoULSlAz1PlxJ5MR?=
 =?us-ascii?Q?Ug6lytZL4lwb6IbMy6By3lgGdRUb78nKOxbxsTISZA/MuM+CCL5zgWrSjpgy?=
 =?us-ascii?Q?St/Jdm3aScsNJMbYja59zCq5QtHvj75YPB44y5PcPTUFQ7Y7DA76sEbG9fpn?=
 =?us-ascii?Q?bLqNcKHIF03aFJHT/8cNoe2g7SOTyZ4e+4w21wg2pzLLLH2AQ+zWHapBQ/ZQ?=
 =?us-ascii?Q?36w5oTJ7AOSigRyOzDmGH58AlmULV5UJTZFm82QbbJi3fZYCZ2Z/BLgWBzZb?=
 =?us-ascii?Q?sqeDhig5CIav2cp2m4gD/+nkR1qHxhb8JdwKQ2l8PVliSKBrnn++pR9yWfjO?=
 =?us-ascii?Q?FhvxB2cvKOs+QwnwioDJoICWmIbiANU87gCZhKAOapHfMMOtqKZKWgASG1De?=
 =?us-ascii?Q?6AW/ZdIK46HsC4rzCDXWv3CcLEqrFtFx+W6kQG19icIY/ghahByU5BkgON/i?=
 =?us-ascii?Q?WHzuUBS1EfuJCTR/4s61r12iaPn9q9BBs4Z9Il5t/a2j4Ct4p1Q4CPpzI75Z?=
 =?us-ascii?Q?EYrUOW66SsQZ0xK2ozKrs3jjHkASN8NFt9okuc5lHIxr92m+o47nPk74dOFo?=
 =?us-ascii?Q?C7OA4TFzi1ZlX12bd021bBkCoNwhgFnG1huL9HN1DvgyMlpkV0kZwWHfw7V4?=
 =?us-ascii?Q?Rm6n15vHzpOTS5TUsJjvbJdo7CzTLXdC1lo2G4rsLMtiAOWANkzIgj7nT89N?=
 =?us-ascii?Q?/empbXMDKPtwtIuzuYaNmhstGlR9kDWNSbYZWGD/zFWktZu3mLYDlnA8bysu?=
 =?us-ascii?Q?6il3LDG12UENtowAfzHsqr12kHgQTeKVItEphe9O7YltXKuc6ncTzZrtC1yi?=
 =?us-ascii?Q?9n+zRagz20ilI+JFBrtcyiP/Xs/4MskeNfdEH2QtTxWaKeh0BEFKEDrfl3Yx?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9597057d-ebed-4cb0-956e-08dcb2d9e024
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 10:00:01.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HE6cd1UzvqzSblZqB+M0R2X345E/VaAvcZNdCOej/1Zk9yeaZGDDlwjsWdBm/+h7TtzIhQFy4EZvn85QGPdyl5+j5Z6Np1gT84k7AiXQxys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR13MB7169

From: Kyle Xu <zhenbing.xu@corigine.com>

Add new device generic parameter 'enable_vnet' to enable/disable
the vDPA VF instantiation for NFP devices.

This configuration is added to configure how to instantiate the
NFP vf devices, if the 'enable_vnet' is enabled, the VFs will be
initialized as vDPA networking auxiliary devices, otherwise, they
will be initialized as PCI VF devices.

This configuration must be done before VFs are created. It can be
enabled/disabled and checked as following example.
	devlink dev param set pci/0000:01:00.0 \
		name enable_vnet value true cmode runtime
	devlink dev param set pci/0000:01:00.0 \
		name enable_vnet value false cmode runtime
	devlink dev param show pci/0000:01:00.0 name enable_vnet

Signed-off-by: Kyle Xu <zhenbing.xu@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../ethernet/netronome/nfp/devlink_param.c    | 49 +++++++++++++++++++
 drivers/net/ethernet/netronome/nfp/nfp_main.h |  3 ++
 .../net/ethernet/netronome/nfp/nfp_net_ctrl.h |  3 ++
 .../net/ethernet/netronome/nfp/nfp_net_main.c | 10 ++++
 4 files changed, 65 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/devlink_param.c b/drivers/net/ethernet/netronome/nfp/devlink_param.c
index 0e1a3800f371..0683e2512b63 100644
--- a/drivers/net/ethernet/netronome/nfp/devlink_param.c
+++ b/drivers/net/ethernet/netronome/nfp/devlink_param.c
@@ -6,6 +6,8 @@
 #include "nfpcore/nfp.h"
 #include "nfpcore/nfp_nsp.h"
 #include "nfp_main.h"
+#include "nfp_net.h"
+#include "nfp_net_ctrl.h"
 
 /**
  * struct nfp_devlink_param_u8_arg - Devlink u8 parameter get/set arguments
@@ -192,6 +194,48 @@ nfp_devlink_param_u8_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int
+nfp_devlink_param_enable_vnet_get(struct devlink *devlink, u32 id,
+				  struct devlink_param_gset_ctx *ctx)
+{
+	struct nfp_pf *pf = devlink_priv(devlink);
+
+	ctx->val.vbool = pf->enable_vnet;
+
+	return 0;
+}
+
+static int
+nfp_devlink_param_enable_vnet_set(struct devlink *devlink, u32 id,
+				  struct devlink_param_gset_ctx *ctx,
+				  struct netlink_ext_ack *extack)
+{
+	struct nfp_pf *pf = devlink_priv(devlink);
+	struct nfp_net *nn;
+	int err;
+
+	nn = list_first_entry(&pf->vnics, struct nfp_net, vnic_list);
+	if (!(nn->cap_w1 & NFP_NET_CFG_CTRL_ENABLE_VNET)) {
+		NL_SET_ERR_MSG_MOD(extack, "NFP_NET_CFG_CTRL_ENABLE_VNET not enabled");
+		return -EOPNOTSUPP;
+	}
+
+	if (pf->num_vfs > 0) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "%d VFs already created. Please remove them first",
+				       pf->num_vfs);
+		return -EBUSY;
+	}
+
+	err = nfp_net_update_enable_vnet(pf, ctx->val.vbool);
+	if (err < 0) {
+		NL_SET_ERR_MSG_MOD(extack, "Write ENABLE_VNET to firmware failed");
+		return err;
+	}
+
+	pf->enable_vnet = ctx->val.vbool;
+	return 0;
+}
+
 static const struct devlink_param nfp_devlink_params[] = {
 	DEVLINK_PARAM_GENERIC(FW_LOAD_POLICY,
 			      BIT(DEVLINK_PARAM_CMODE_PERMANENT),
@@ -203,6 +247,11 @@ static const struct devlink_param nfp_devlink_params[] = {
 			      nfp_devlink_param_u8_get,
 			      nfp_devlink_param_u8_set,
 			      nfp_devlink_param_u8_validate),
+	DEVLINK_PARAM_GENERIC(ENABLE_VNET,
+			      BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			      nfp_devlink_param_enable_vnet_get,
+			      nfp_devlink_param_enable_vnet_set,
+			      NULL),
 };
 
 static int nfp_devlink_supports_params(struct nfp_pf *pf)
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.h b/drivers/net/ethernet/netronome/nfp/nfp_main.h
index 14a751bfe1fe..9e782fe44c39 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.h
@@ -65,6 +65,7 @@ struct nfp_dumpspec {
  * @num_vfs:		Number of SR-IOV VFs enabled
  * @fw_loaded:		Is the firmware loaded?
  * @unload_fw_on_remove:Do we need to unload firmware on driver removal?
+ * @enable_vnet:	Devlink parameter config, instantiate VDPA VF when enabled
  * @ctrl_vnic:		Pointer to the control vNIC if available
  * @mip:		MIP handle
  * @rtbl:		RTsym table
@@ -114,6 +115,7 @@ struct nfp_pf {
 
 	bool fw_loaded;
 	bool unload_fw_on_remove;
+	bool enable_vnet;
 
 	struct nfp_net *ctrl_vnic;
 
@@ -194,4 +196,5 @@ void nfp_devlink_params_unregister(struct nfp_pf *pf);
 
 unsigned int nfp_net_lr2speed(unsigned int linkrate);
 unsigned int nfp_net_speed2lr(unsigned int speed);
+int nfp_net_update_enable_vnet(struct nfp_pf *pf, bool enable_vnet);
 #endif /* NFP_MAIN_H */
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h b/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
index 634c63c7f7eb..f0751015a8cb 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
@@ -150,6 +150,7 @@
 #define   NFP_NET_CFG_UPDATE_MBOX	  (0x1 << 12) /* Mailbox update */
 #define   NFP_NET_CFG_UPDATE_VF		  (0x1 << 13) /* VF settings change */
 #define   NFP_NET_CFG_UPDATE_CRYPTO	  (0x1 << 14) /* Crypto on/off */
+#define   NFP_NET_CFG_UPDATE_VF_VIRTIO	  (0x1 << 16) /* VF virtio enable change */
 #define   NFP_NET_CFG_UPDATE_ERR	  (0x1 << 31) /* A error occurred */
 #define NFP_NET_CFG_TXRS_ENABLE		0x0008
 #define NFP_NET_CFG_RXRS_ENABLE		0x0010
@@ -270,7 +271,9 @@
 #define   NFP_NET_CFG_CTRL_MCAST_FILTER	  (0x1 << 2) /* Multicast Filter */
 #define   NFP_NET_CFG_CTRL_FREELIST_EN	  (0x1 << 6) /* Freelist enable flag bit */
 #define   NFP_NET_CFG_CTRL_FLOW_STEER	  (0x1 << 8) /* Flow steering */
+#define   NFP_NET_CFG_CTRL_VIRTIO	  (0x1 << 10) /* Virtio service flag */
 #define   NFP_NET_CFG_CTRL_USO		  (0x1 << 16) /* UDP segmentation offload */
+#define   NFP_NET_CFG_CTRL_ENABLE_VNET	  (0x1 << 18) /* vDPA networking device enable */
 
 #define NFP_NET_CFG_CAP_WORD1		0x00a4
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
index cbe4972ba104..43bc9d40f755 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
@@ -684,6 +684,16 @@ int nfp_net_refresh_eth_port(struct nfp_port *port)
 	return ret;
 }
 
+int nfp_net_update_enable_vnet(struct nfp_pf *pf, bool enable_vnet)
+{
+	struct nfp_net *nn;
+
+	nn = list_first_entry(&pf->vnics, struct nfp_net, vnic_list);
+	nn_writel(nn, NFP_NET_CFG_CTRL_WORD1, enable_vnet ? NFP_NET_CFG_CTRL_ENABLE_VNET : 0);
+
+	return nfp_net_reconfig(nn, NFP_NET_CFG_UPDATE_VF_VIRTIO);
+}
+
 /*
  * PCI device functions
  */
-- 
2.34.1


