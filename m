Return-Path: <netdev+bounces-264163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNZ1AmX0qGmfzgAAu9opvQ
	(envelope-from <netdev+bounces-264163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:11:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D17720A72A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1D2D301724C
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 03:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EB5274B59;
	Thu,  5 Mar 2026 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mIJutNgO"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013025.outbound.protection.outlook.com [52.101.83.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FBD274B2A;
	Thu,  5 Mar 2026 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772680238; cv=fail; b=tcAU3uyp8bxiopM/V3Kh2x0sojdxsQ8JmCod1GtQe1/drWb+fYZfQwQR2c9pBt0QkQml0flwIeYEYKLLJcuDSuH30X6bkLRnyucz4hciEt/LomzuWCxGHGA4IprGC4csYW7V3HempirmT6tB4o89jPKSIvbfB8l2yk110nj1Tnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772680238; c=relaxed/simple;
	bh=tvxptUQ+s1V3K6ZzHpspiMMFH/NA5D9CRbeuc87bD9E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IDpJ5cdb/5tTPGyRt3ciGDEZ/seCMUFx9LHYV7H+MSwVgHxIUji9PMMx0jx6/H+ufbsRGlcafpdb22TNcrWxZ8DuW4iV/P6NmlOzTqWzR4u4EDUfH/O4JJtzOXcB6N51agWP1B2e9Lggg3cvmM/5rBEIcVVZ2v2IhoDPn1PW5Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mIJutNgO; arc=fail smtp.client-ip=52.101.83.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=su7bx6gnqZMvnMDo0hirdia1AXvZdaukouP8KsE+u9NnPDHAAcmCsUawy/f7HQUCI0TBIMZ63GI+ExTq3JuikKezN+nDmYd298pFNsmIECmFJnI6KaAVnTNti8e5N7mSL7IiKTqC1Ua4K0rkTp1f/PIL2McGTvWOIeZ2b66ZfABRJWGUkyer9cmLkOpOcPO0v2ZAdhH3WrMhWmK/htrw+5Z2dp/I1PCKEuVYb/hfPPD3gZSUywJIlfZCKH6c/9ZCu0kOwfqklnWaiV+KNpZe9ZdgN5RM0LWsRqFbbhAe8LNrh/vL2kZN/MYZeaL/DVXCIuz0x6Csbwiw+8Mst37Ojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khKVF3A7weLU0mQDKwwYNu3Znt6Q33jszVco537poU8=;
 b=fg5MguSVYbq3EhfkaR3v65sm9l35jVJMRAytpF/cUf7PimaPdX3tpEHNIgRcfHFUvvWPkllLmLzKqzMx5ckdx+13/nY8g5PhIkiIayHIAOEJU1+1160GLBgLG77jY2DB3TKAYZNecr0tAXCjyK5VUEtZNVI2Nh++eXsZ2xRJwC9EUCw7vUyv8uFMQWi7A/WQxcA6/U82GAsb363u1WQ0J/ptBdIcAv90WTjzwaRPZpWo500+Bp+JQwBZqe4HsAx1LiK/n8icszc/UrrxR5tqBHwJzWfAQma1nxnKxOQxdRWwzoG80eRkcueyXjBB1ZajubKdkroYgOLZiPnFFDmpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khKVF3A7weLU0mQDKwwYNu3Znt6Q33jszVco537poU8=;
 b=mIJutNgOsocwgbYy66xWNDWns85EGqr1XHhYbgvYs4QvpExuV+7yeL853yByD5Nf6z4pOaAwk486hGTjVY6GSunBrvNgfykc0z5E2gfTNML9/NwPFPSuheGKH9aMZhw5panvEouaZuryJGF3Iygox7l/cWMSjvumxH074jv8Y5wNQWy2j5/1ySxwSH8r+CnpFcbVpdMR4g5gUWK3B0I9uQCy7iyT4bK8o6guvjXM1WrFDUU3kbuM5UbqGLg7cSlnnm5nh6lXLtw6mal9ooTvP+LSsejX9DnhS2m8cK5JSR+lF+YVmTIUEj25SeWZ+QVmktC4rm7xp/2rE8Dgf5lDVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB11471.eurprd04.prod.outlook.com (2603:10a6:102:4e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 03:10:33 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 03:10:33 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexander.stein@ew.tq-group.com
Cc: aziz.sellami@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 0/2] net: enetc: fix fallback PHY address handling and do not skip setting for addr 0
Date: Thu,  5 Mar 2026 11:12:09 +0800
Message-Id: <20260305031211.904812-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0069.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB11471:EE_
X-MS-Office365-Filtering-Correlation-Id: db7e7a06-1c8f-45e7-4140-08de7a64c38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	pMMNJSV0Dx5xuu1HKlO1rndGEIjpxxvAb/LkysM015x+53tDOEQF0/E5REOo9ErFaGQFfPmBuDwa+4jvjXNM5NMzKIpz8aTtigPPd1bwUJ+H8D9S80eH+LghQrVOA1R/3ZQkdE3Yv0rocb7YMVD5OLTnDmYUBc/vTyghAUvNWCj2qZDXeejUlPyClafKcDweTWfQJ/DJLeO9hH23yckZVTAgH6OM0LhNu9S5hhPcCFDGgAjcP8FVbEmVks4g7iH6p8XlWswubTxuatksStKhwFJUTQJNylGea3U0Nx8anjSSIvLGZej2XERviM7yv6E6e73x4pZXE+XlQKEzhPUB27X0Eg55OtNQiz8Mus3N5CIfOHm8VkeUT0GsgXwjt7OBGL4009qQ9TQb9aMkajs+RlI034RnNqLv+02G6rGbiWGXDJBwnXvuBIulZUq75iFh1XsT0JcKBMbYdcvab0gRi84+n0KKUx9UzSXFsUblBS7PMVDHc1svtBjDdkYFK6CYycanjQsPJMQ5QAVRlQjV8K/r57c7dPxcvtzN7Sv6METWmNSTrz5dIyq0BiQD04m0shWTQuouS9tuu/GvoKFzJ8jBvPVDl2oXawzwH2g8QchkAyhw8FLR3ZMogaDjK1uC5jxZn3fV0SZ2PgTf7FmLhfi2TVPjSqaHeZxxpgMCdQM49y9WV1oc6njhw2yqiYQ9OBIIcfa8dVYE0rIuDKO43f6Xu02A7C2D+bHAux2vnL07+yiIeBPcga6WaOArVnrAZX/qbaiCnmTMzHaMOQKwb+mwDgWbjxh101usb7MEXh8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gk3MeeNQzqvxjACszb/XYyxy8IE7GsSo5Zrlf8N3bSm61gvKHvlKVhGksRD8?=
 =?us-ascii?Q?QejmpcIigX4GfuU2RhicakTjtgCvIUSOWk9aVWTZ+iiOhZa2ab5ev17Twsau?=
 =?us-ascii?Q?hWCRu2DQ+1Dr325BVCMb/KARipIeYVr9STt/LXKc5/PjK/M+h5iMp0o5hvwB?=
 =?us-ascii?Q?lmkF21r70OmOpwwyznhJrZki4GJtAwXFtOWbtlH/oQE1V/ALucn+GRN7UpOQ?=
 =?us-ascii?Q?VzKyoVrvLPRMoO4X25SWbf9vqTWkwzciAl35vp6g7jM9DW6JZQ+e4a146owM?=
 =?us-ascii?Q?+89js+cey9wrXMtb8oWHjjiNkYaz+Zmf/qHrFRsKNB5u31tB3IQ00T+sfy2N?=
 =?us-ascii?Q?dyl9PqXmEADVxMc/V2LvjCpJq6CFv4uRmbcQYQxUkher5F8haBV42DMP+yVh?=
 =?us-ascii?Q?qJ0lb35kbAiqVsXJdmkIHxO6wKnjKG1bYtw2rLa3GyVUjSdQDKD3uBAm+iz0?=
 =?us-ascii?Q?K+3YuVidCl1K3BvblXOwW5t+qiAqrVuKkP7GRJ1VuiowN1ULejx86NRQx+NL?=
 =?us-ascii?Q?rHm0Enir+2aN1sWWd0hCDE6nRMdTcgoxVI1kUHoIqo5LDkTbQ8agCKWox5fn?=
 =?us-ascii?Q?awoX8TfhptjAE44iJsZMuob33w4thq5RGi09fzl2uI/NILTge5D6WflEknCY?=
 =?us-ascii?Q?yHdF1eT4vpcw1IBZ3dQj/J0k5at16BuelphmYQNmYaRRaTVO4pBN2rAnC+Or?=
 =?us-ascii?Q?XLmimVt7yj4kVmatSfQyLSsGaKUoZN+f/lAq+VL4GyokomQwn4JjVV6F+94A?=
 =?us-ascii?Q?90tvpEVHsIBuiif7qn7hMzy5CkPC4yI0NuxTxKqiq8QMiU0p3hPdfY4P4cma?=
 =?us-ascii?Q?ACB4rZB8e0Qx5bSmWA8N2/isZs/SXcvVAyR9TJ/VEJfl9DDuNrRphOg6Tl1R?=
 =?us-ascii?Q?RUXW7WLSNFrgRnEGGDxL4SZDh3pw96VafrKsx0sBMK6ZjGpNmglyCVyG/6cA?=
 =?us-ascii?Q?+PGYZw7CD+zluxZyc9aUlQFnePV1Bdkk1+wdNcmdoVVDR8SSXyQb5TtRq5CF?=
 =?us-ascii?Q?PTzjtWPj/lRex+y1TymgtZA6EBp63SLLwFo6iNn6nRPz9o1ro+dvV3k7Y6pN?=
 =?us-ascii?Q?9e3txnBqlpCIHkkOD1FUYVTFzTFdmRmq6Y29En9+xFuFrhNpRuXmlhWSx7aI?=
 =?us-ascii?Q?Mb/7IoP8UFQ/5Io0pjAyMnvAMLSYBvFL8GpgGDt6KSjc9HyqTDhV1k5KuWkG?=
 =?us-ascii?Q?xk3N1ymoKeESm9+ux4dHKNoDLyfmeChv7EA3YtogWpDwnSWaUIai58G7d7Dt?=
 =?us-ascii?Q?k9U29zoPu0BuaQM6fFXEdFNkxcRlb7aIGVro7ucOzY0yZDhWp5zwm5znEqjK?=
 =?us-ascii?Q?xpcLsWpZ3cbGvgoO3xeyqlIq1rY+jIcYmd0Ht1mzt83eWj7yzxe0RUbYWZNx?=
 =?us-ascii?Q?S2S81oYawGR/m/Tg/NIDuSdAPPDPzmHBcf4g8G1mdH34czVjFoGoQe39iE7r?=
 =?us-ascii?Q?OS4AbobIEM/CNnstm/B950+019NcNNkA/Nr494bdLq/QI/L9Tmt4Too9nW2h?=
 =?us-ascii?Q?JE7IMz7XC0pp8G8W5fE1I6j71UCwznQj8YfJAGi05Q/h+47owDHPMeUxd+rl?=
 =?us-ascii?Q?VG9VR+mkCGeI8e5eaFVNe6380LiFFDdOf/1Bli+74xuK9y4VkVmoy6Q07PYe?=
 =?us-ascii?Q?RcLsdu/baEHZPDxGMdAAa/qqND3YarDNqfMc6o+Px4u1ZaVty/0IvfiOFuZy?=
 =?us-ascii?Q?JethDKKAo5J4JSJoINDatxojvH2gpsUJRygMh1PyLQZYjb+3UXAVfBwOmy43?=
 =?us-ascii?Q?eIxWA5ZdTA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7e7a06-1c8f-45e7-4140-08de7a64c38f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:10:33.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lw5lnHjiNM9VFqtMuKS8KRy5lvtor4Jr8sckRLcT6JPu7GuKYjOO4SAqGZBI5bfLRFBy3bakf9otHNunEkPzSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11471
X-Rspamd-Queue-Id: 5D17720A72A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264163-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Action: no action

There are two potential issues when PHY address 0 is used on the board,
see the commit messages of the patches for more details.

---
v2:
1. No functional changes, only split the v1 patch into two patches.
2. Collect tags.
v1 link: https://lore.kernel.org/imx/20260303103047.228005-1-wei.fang@nxp.com/
---

Wei Fang (2):
  net: enetc: fix incorrect fallback PHY address handling
  net: enetc: do not skip setting LaBCR[MDIO_PHYAD_PRTAD] for addr 0

 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

-- 
2.34.1


