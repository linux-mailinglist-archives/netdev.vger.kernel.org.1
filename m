Return-Path: <netdev+bounces-216374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FE6B33551
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C85E3ADFFF
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85959287247;
	Mon, 25 Aug 2025 04:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dExhcY6n"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501BF27C84E;
	Mon, 25 Aug 2025 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096646; cv=fail; b=DwFjh4bKMvPVcHVnbXhxisOvz0TrRAZovs2zbOebVp+P0Y3kwVP/WdU73tJcTVQnx3J5n7AkeaU/XaxtS/v2TzLiU0S+I9b+jORSDNmXvL4YOm0ateIJRuQVDtIkk6P6YE1V3Hd/ZM0Xi6IvlCis7VbupQTnOjhk0YN57NKZVL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096646; c=relaxed/simple;
	bh=38Z0yxZBhs5yWyuG92ncgFhx4bDoz40jUTfEhxUUN84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tWRUmfMrZQ3KeOmge28cvaQ7+1yjdmKUiQu5PNsdi2/M6LbcBc3eMeFvGQ/lVbMeuxgcYiGtLdv1ko2xw2Kw10I6W5/T7uk3AJa7IXSX03I/pufgBE6+1wWF0IkLBrEmJ5BNLxvu7qhZuqZAfOAcltVVKDejeqCXM47lcUe+CME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dExhcY6n; arc=fail smtp.client-ip=52.101.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmG7GmqffDw+Ks584rMv5G6XK+SgeVSUPe5pMDTWp7g9KLjcb3OWzOloDHNBT56vY6SgyKdj3CN6QQlRB6XEfgtiE/84sppI85LTMzLBNumX6p02t5EObf15XWUxQlxrXtkVRbbMkntpcUCcd55QpgNgCuwDxGYDhNi4xJzvqW+2/MQXAWfPkgOJqTKE6ZxISSgwbcbljoB8Isy9vSu4bGCA/nfslc19/+VNHdKHjOJHaIcW9opnXreHhjPnh5neqZLPD1JZmZWgBDBYTedRmAiA37igDsXvzY36Jq+nT8lLlFM+/LjAEKXX26TX6czKy/VLyHpqhsH8gLXXvkQZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt6KRkf0gXwfOGivmY7luvsu/hENg3cVSlJV+2SoKOU=;
 b=sGypju9BBiCenruZSSZU1NQIPO+ijkW08/S1wwws1Y5OJm/0ylIhu8OiMn8Tbjuc+Al7AoZjFKVtGF+mgat6W7YJ4Sy9dycEMt4r23W3ATgQc7WMz6iMLmgiLdgQwvJHVXrpE9leLsEmVH0Ca52EXz0p2GG2XbYzS4q5aawEHqms4Qm3k1ATFYhdwvvoftfWCoknMCSeKa4tK8srEC2JKSeugsczrf4Ag3TXl0ORYaUrzUZpDxxHcPF0bvQ65/SIC5miGVKUR5S846qqr7/EmJt0xnaNmViG5vAnyFyqH637aZdWViEsEHwYGT+ffFrF7hZ6/rOq1P/bziWtH0S7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt6KRkf0gXwfOGivmY7luvsu/hENg3cVSlJV+2SoKOU=;
 b=dExhcY6nVAPW/vqko/Xj9CjK1MH5D486SRzWRK17qDWu9MJjyJcmmPr18dwAjJLlV7/aYkfr75KvlAOebVW6eysGAMpfwkF/52Nwdk7QWrP25DOKkMft6ZOT2EZ84g17ep5Ge5G5+/MSRSU8xCGWw8RCe4uJ2pzkkdHlYTKRQrFESdvXfWdXicClbgS5lFDbq8A1aq+GLqNVuQI+vLbDVI6pzNNmbNlfw9Z/uzu2eZmVq1wYCsomXgzBo+G96ITW7mOfGuIOKrKjtM16Cu6ai2IWyrI9yuoXDv9OQORI/jX/5Y/RB1lRiz/1505aoAlEJK2kfsP9h85kG9x37vskhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:37:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:37:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v5 net-next 09/15] MAINTAINERS: add NETC Timer PTP clock driver section
Date: Mon, 25 Aug 2025 12:15:26 +0800
Message-Id: <20250825041532.1067315-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825041532.1067315-1-wei.fang@nxp.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee41898-fe75-4b3e-dbf4-08dde3911480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O+hsUrLgFXomP0JtqoppldAivHzJtlHq6xcXVnaguQ/+pL69VJfuFT/S/8Oc?=
 =?us-ascii?Q?mFltYyXg320pP5u+hNzf6CRisyGDFA38vFhl2o2Dy1oXEdw3oOY55wuxRKSL?=
 =?us-ascii?Q?NlpPj9VZlYFSooXGGzy4RqcPDxUFQw/Lxbd+EKWPq6kWhd9oaGCe8H7tZTaQ?=
 =?us-ascii?Q?bpkayANsmpTnX/1/YOKMvxMBKjyN34Bfg0zqIzxOsZBGwCG7GscOCpad8ayL?=
 =?us-ascii?Q?3BRX4b/M9JYIpyAgz0KAtUYB5WGTcgOcAwM7B3F/dvi6HFmcDquDAb5UQCK6?=
 =?us-ascii?Q?1+ArB6z8bjnirxzkwoxsq/JEidoWoQgf32vS6lE05u+QBEyqZtonI/fEdZcP?=
 =?us-ascii?Q?CvcJ9ypYVWLjimq++ERjUZ6vSU2znxMpq8whSItSnx89cI4bjMW7J0TB1oQ+?=
 =?us-ascii?Q?Nhp2KhsScOc6u+gOoc+LzY89SzQBhgGYBIcwgdoP4qfc4472yT1XWv56s5HU?=
 =?us-ascii?Q?T8nAWkf4WusJKP/kBJ/WLwBiVbmHzUcgztOIBzlkAbTrQwvsiiW+s4ZGjxqX?=
 =?us-ascii?Q?g2Z1JU8n/ixHZ2cMXd/0i7IifkhM/f6db20CJNJ4eCY2fZLnBk2KOQHIh0EF?=
 =?us-ascii?Q?spZ5BOpvJszzisHyOJUU5pqftCywBBrObzMerc/E47IBMh5JRPyKIr8ZaeCi?=
 =?us-ascii?Q?OWGnAcHycW0a7POKFtKlX4Gy7vFdBg42f44ddcUuX5AuEih1gGLso+O5Uwx/?=
 =?us-ascii?Q?NcrNBJH1ZqTbpHk/ZoDS30T9QEPQ3+Ah9N/CtuCLR9eMsU0Il7IsufgmFSgh?=
 =?us-ascii?Q?r9Yl0obrYP6I5bVW8BDJFSW71Y6/kpVBblYKevejRC6KE02Z1xUSnrQJL3kA?=
 =?us-ascii?Q?auqhP89QKU5dA3nGpa1NzBkKlvFGNlOEZ4JQ3KqYid7DZZsqxpIepO/RR55S?=
 =?us-ascii?Q?VueZk6rDSLVFnIT09dKdNmZNkK9xWCFrOEdHIaLMYoUps8F+F/Fr7iMvUb6s?=
 =?us-ascii?Q?TYuS8wZDAWOXmg43K69n5AaGfR9J8U64HfRLxnarrDkelFsyJ7hgSB1z9i+q?=
 =?us-ascii?Q?Lbd/Z/Ishg8vmzChupbdi1nReG2Pgtb2qu1rFgP3Q5DqkEHpb1urXkV3hmZ0?=
 =?us-ascii?Q?jaKIgDgOm1BBboG8PVVIROhaLjqwn6ojkubPCu1G4aZbPDSAbwlI8i3tqxnL?=
 =?us-ascii?Q?HXhA9kE4m522sWDN4DDX5AOzU/xvlNeCmrDwmDP7jWI6lgksv/bBLJgCZ16i?=
 =?us-ascii?Q?RHUc3dgAO1NSIMsm9tOYc0rQUBhUnRjc4EfJhm4wB3yBpsyUhBKDPw9RKX2n?=
 =?us-ascii?Q?/WYjUoT/BOMrRq0KsPub0oVBhFlWynw2vtNUnYdNaKCRAhOt1czaIVYRUAvB?=
 =?us-ascii?Q?0cuU1LV5eXAwFOAGQbIFmYKL9M1qu7Jv2DYuaCa2nxYUkSTejJbyhDNKOrBF?=
 =?us-ascii?Q?a2cWLds6UzAHiLD4VJGJ/rhvD2hkF9cCkS9yJQMjMZz9SNoxEHb+0TQq6YEC?=
 =?us-ascii?Q?spR3+rg8xjtt4ZEutO/0K05fi6COfnhaGKuz6yrYm4+W77Bg4Fuc8VQAqwNJ?=
 =?us-ascii?Q?RB8TYU0VWb/68io=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OeiV48ZxgAnPhe8VjF0j+OvuIwPdx6wT6Yx0jE11wA9/ezeIXUUDr7zhvB84?=
 =?us-ascii?Q?0Uk3ojp071vYrYhP2MUE8rjVDjmnUXgRG7iGdPJCX6y/2QrfoComn21MHccq?=
 =?us-ascii?Q?dwvUccwRYVsRKx6Nza0NCojIPqs6cCbXDtl09x0rCAUbrppgSJRVQjVvmjX7?=
 =?us-ascii?Q?78tYsQft3FJUWdz5qJBz1KgEnkkkfYUaFZ786QzkVwKHPUgw7REcLuQ45CsJ?=
 =?us-ascii?Q?TZt7tmzafG04h4t4R/tb8Xsovnmk7ZBVmdLgp6xukae0CQFu7rrNsXqWAKbs?=
 =?us-ascii?Q?nekZqTvamDTKBIeZOi4ZaStkIRHgK+YeWiEaQiNmXjbdmIHenPqrA/I6dDgm?=
 =?us-ascii?Q?BYCb36x4pJd5FY/E4rOJXN0j+w73A1Hq0sxWeHOEkm6/AB97EMb2sJ8UoCE3?=
 =?us-ascii?Q?oXcKY57dK9r+gfy0q99AlHkGQdyplUeiJgkHCTrsiKgUR0xylH9lwNL/RsV4?=
 =?us-ascii?Q?Dyuf3tk3Yp8ZVoRIaiMXcmXj3Z1kfPkg4cC3+ycCb+HroPifY63fMRkP/eoz?=
 =?us-ascii?Q?iaXT8T4AMWgvxjstcXhyvKIDqIpVzmF9MBJev072cpSqX7ERKL16G3O9MKao?=
 =?us-ascii?Q?TePfhbKjNDuGMbsQ78xJAAliRubkm79zh+XIRKY+slhlRBD5VCwn/XzFix+J?=
 =?us-ascii?Q?iYMGmRrXQUa4YAIQIQqFXJ4Fx18B5LExMGo1wZt3Y8KFpp65a0NfEMWB9IHv?=
 =?us-ascii?Q?fu3QbuGcv5sCAuXcirFM1QeqqdU7ZuN4TNtLRQJav1u8B8SBcLqc2x78s5iw?=
 =?us-ascii?Q?R09y7+dl//SyC3SNZsOPz9oKFoNGO2oTxWwyrv4JMv2LFQPN5jiIz971mfFE?=
 =?us-ascii?Q?bHxIysC/ZBP0jTat/3/8gG+B7xUY8SU0iOqTtJ17ztJ+/zsW4A68NiXVxbBv?=
 =?us-ascii?Q?dBWRplH1+6pT05b2TnBoBPBtoDFS7Zcbxqg0NmF8pRuvL9dm0ldXbbbtLVjL?=
 =?us-ascii?Q?1euiRFkPSyqJdnXDS3+/krQzY+8JpAY4D4d2NGj9feyB1YEHLPD793pMZvHA?=
 =?us-ascii?Q?cOaU8Obl1oXJAE+2NlCFksjcWGTD2//rbJ2L2AIJdXugBfJmqlXQuU7yvZ1P?=
 =?us-ascii?Q?2qHhgq2DepkQgCYyaqq0X99IYVsbKGBtY2sVS93a99IvsvuWmjkYeZ3LqvVV?=
 =?us-ascii?Q?TVny61aGe21iC5/GfL3/Qf8bnwWzx/Ks/Lx4tlYRjnbzmqj8yc5yk04gGjvf?=
 =?us-ascii?Q?e7cy6tE4dUf5WUGLNINVG7TPzX/cLQfkYOPhPIsxfb6zz1yk50hfy78zFrq1?=
 =?us-ascii?Q?yor2RlSBm2pL9KhPn+EDbLycCnBuavHTh+6oGYYaioazQDg8BoPLPLxbpvgj?=
 =?us-ascii?Q?+wQiQ51d9UZ6hNc2zityT8Oxt+9nUid55J96untnS4F/98D0GES7KSsTGQR+?=
 =?us-ascii?Q?+O904gKfhAuW8EGYEsgXBRu5+X0GddScTocbtcwHBfgXfwwkjMYtRzo0QR4f?=
 =?us-ascii?Q?g8cslVoPRRBGqjgibDVWDC/yhnd0nC5nawZJzJzcTGeqWp1i/0TQtS/odAtY?=
 =?us-ascii?Q?iveqPBj3Lpu1xcQp5yz4NVXWRvBBpnaxJY8XpIARv0+6SBaKrnJCjCDvR8+d?=
 =?us-ascii?Q?T10C4xIr4MJSuOfF2gontTh4uOIWObpJgq7Bypdh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee41898-fe75-4b3e-dbf4-08dde3911480
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:37:21.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8pMezm/y/g37DYVUrL2JQki6tHBdnUTcHgrqgOt8LnPOtTlM+oUI0bzxPuIPZMIZ2LLQOLbtvuBqzEgk8sgLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

Add a section entry for NXP NETC Timer PTP clock driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2,v3: no changes, just collect Reviewed-by tag
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bce96dd254b8..eb33acf9e3ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18263,6 +18263,15 @@ F:	Documentation/devicetree/bindings/clock/*imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/*imx*
 
+NXP NETC TIMER PTP CLOCK DRIVER
+M:	Wei Fang <wei.fang@nxp.com>
+M:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
+F:	drivers/ptp/ptp_netc.c
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


