Return-Path: <netdev+bounces-252612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLuVIYHdcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:31:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CC86FA44
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D4BB304C4AC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918643815F0;
	Fri, 23 Jan 2026 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UXIPhv9b"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA438A9C3;
	Fri, 23 Jan 2026 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135090; cv=fail; b=PAW5J2SEzahBICC/wrcU8yvu71TVY5OldeM+dYis6MCmd7blKxFWX5Gz0rnA3LfiX84/zf/PqXBYbX+yWKCkSsard/VidhXDlvIgJlM4sXG7NvRC2wKiws0ffJ/HGX/OZUnH4QaOrFCoO0tuuHOx3/nBHGqgd4YHtoVdRX/Fvjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135090; c=relaxed/simple;
	bh=zrfs4Kb8bpoMWvItAHIuMMURSztlljbbsEL3GSlhXmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j6D+i4d2XclfllZGo0zqfA+TUb6Cmjdpu35X8G8eWnYivr0OXJNfARGOQp6UFT0zBuXB+Qy3EMnvbsv5xxaMXWnz7QKAUY+j3n2fWVVlQet8qW8W+JzcC+EtK5+k96KmPKIBH1TcnoofJ10S+IVo5Lh6oqV7OytToqGZFr9QnGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UXIPhv9b; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JW3Lpy84USH+2vztIYzfy3SVteVea4Yi9ra9ULT3XNs1xtiv9LPfGU7LOIOt9rcX8PmlY52iREWaGbat54xEtfFOsBpFtrZ7oB7ZhWBXXf4x7GLI1aw7hoWKx3xb9ZHu+15yPcMGz2oHzDUu8rKyPuBhMMn2DQLpAb28B97mXOCiz8LLXklL8ja9m07G6CVRXNE4aXNaxWz7CjZMp31z/oBRK2N9XN3+UXQkMoG4lZIwIxJps7Ro0QlBt6rwd8P/Z/uzurLM8DIHEG0cMrxCU7DquIlyp/lEVvnsnmTOU/AkMn34AXKaPipzj8q6UKq/mesmwvhjA0DSe0/vR7mjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbCVF3f0EAWx/wk7by5kl99yGJgBRfUnkDUW7EqZLIs=;
 b=U0oLN1Xl1qU4FwhqCXn3XR4Zc37RlE7TrN2K32xsJZW6XYFhmIKOsRVFM6SUhYkS7ZbFsG0EgzDrv8HBIrnMJog/1a0CwuBHvBUFSXGWfK+MZML3vtzC5ChM7YAydzq3QjCd0Sn+LeRJtMW6AdhztU4QDczfHLEKPj1O2lysE73nVmepOTG2vOrKXC3D7TdaemuGu+Kd9amrdpHr3nVnOsw2dmbLRHTccHGVzg8BDXsOBKuWzQa9yU8tH5rNsgVpMopzhGjp8UqeTbco4+SChJuEusmdHOVtY8zHcpGZozGH+ZlYVXArYK3D3sH0SOOIxy9OaMpFcrcS0FEBgStJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbCVF3f0EAWx/wk7by5kl99yGJgBRfUnkDUW7EqZLIs=;
 b=UXIPhv9bRqsmyYda2CmAWRER7lqgQOAzSpPb86q6umBiix7Y7XLsfjYbirWFBRqzMQf43BwVujVEYUTgQ2PHYOIF0bxC1HpdpI6aFMoLdVncB8gnq0ae3JPWtRtpJCcWRpnXXqm9unxseYL816MvFtNQ783tH2pFeEn25IyQLFz3M36QytWu8Ysdtq0lm+jioPoOG95VC3MmR06Sj17fi31sYWWolkjiE1pStXxp9EMMQxt68MShDLbHYZBTMd0JaT0Bo7/CmyXL0DIlgpUQhbMPHdO22kVjVNJNA8ixucWxgBs9jUblse9ofo3TzmxSM+eagZQXfa0ns0NMq772OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:23:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:23:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v4 net-next 13/15] net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
Date: Fri, 23 Jan 2026 10:21:41 +0800
Message-Id: <20260123022143.4121797-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123022143.4121797-1-wei.fang@nxp.com>
References: <20260123022143.4121797-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3018e5-1cc7-4d34-f4ce-08de5a265655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tgeK+34+RdAtyY+510oDUYAanlTBaOo+wx2TvmCmdDK7out8GitwREDqqBKx?=
 =?us-ascii?Q?mgJd614f4BC6tfWyX5kyKobpojAoek5Nn5fMyjIhoW5rCAMVj+G9F8tfYAZ/?=
 =?us-ascii?Q?8tUtt3SadiqgAs8ZVaFUa7FEzhuSYMcF6ll8VS10pPl88cQZ7zW7Ise5eawo?=
 =?us-ascii?Q?Mz8bPkmdvP7Prwx4fYFDrZfCDV8xVbVgy4aVvPBSB1L63WhoxFW83gJUAK1H?=
 =?us-ascii?Q?00MTMbaI2RF9VsW3bBBxSHg0u+WV/aHCbY6wGzhrKkvV6MGPfClpcvxZxffF?=
 =?us-ascii?Q?S/TNnLnm5je7bUb7vRXF/uyhM6SJ2mYbMxarvoD7yabvzZx5l3kFCgzsVQTV?=
 =?us-ascii?Q?8Kw4PaDWmxBMc9AW4XM7DGGXJvtJPih2t6V8k0vRKHpMm5pJ6oeEuKVeUN2A?=
 =?us-ascii?Q?ISz3ZohVUYIba+ZqOJgLT4tbMctLr/gAWlo6zeneC9AinwY7kNpuPw10t0AW?=
 =?us-ascii?Q?c0rVh6ukWiSU6IPTBG9GlS2m0y7GXC76vQeFbvejGFDSf0c/1ss1Jb2Ox5jb?=
 =?us-ascii?Q?oDIz2gLY1jL8P7ZviR7JzXwvWJ1ACRwuJFM4ewKvozUO1hJyoqU21HZ4gssd?=
 =?us-ascii?Q?ORjTiGPu2TVRiwWnK4hWFTSrxw+OAKdReXssHMMmiQ9MPgb16Fxcxm/DH4oR?=
 =?us-ascii?Q?Ha3w2g9b3vBBLniDDndMENOMlHTWS29iV2d2btww24AUUqg4b94RxOv/jeGI?=
 =?us-ascii?Q?V735nUnOXNi5zedrxArouMRDqlBqUfQAHbIhBNt9vmiZygSDHKfY2LjNSusG?=
 =?us-ascii?Q?cr02PNlGFEzLoCNq3r8ici6nZYK7TMXUYqrukV3pO7U95rAh/t3IB4WaCx2L?=
 =?us-ascii?Q?Z/bdSDy4dpWBr2AJ5UlsQ69Cpz/g2Wc/wZN7DORmOkQQ2MbML6HBbFtamPu3?=
 =?us-ascii?Q?6RUOlAJV5j9zyou8r7p7uj3O/681mIjp0D5Rx31jta4k98Fc9WEhT1T2llf8?=
 =?us-ascii?Q?nSGO4tkbWO8HFfU45Lr0IvHj4CkrogEmrEpIdIHIs9PF6eAyCf0R9ujf6Bcz?=
 =?us-ascii?Q?+9EfXAaJ+Cz17lOBRMYnwiJHyqfVEkrgFYB3eKViYe5yDz2+kpa9aHO+y65D?=
 =?us-ascii?Q?iStyuxbdGlbW1kFRA2in6/ixugxfA8AyumdQ+b5tif5Fx6A8LVkjni4Ag9hf?=
 =?us-ascii?Q?wQ1LMDZ3pEALHFJL83b2lhLedaqexu+xb+5nDL70OpSh5oH7gNCxsJcZ9SBx?=
 =?us-ascii?Q?v1NNl5N6/Taav+2hcBiLJ9nZ9LsdGc4xg7jh6V6+zgG+eqmBIIkCqgV5SJYD?=
 =?us-ascii?Q?QOyYbrk42OzQJKAfA/qcZmDRb9TvXXP+9LyfT9HlI9czSfXGcuk+soGwLOip?=
 =?us-ascii?Q?KPlNKJrQqmRtUIZ4kbEFtH6yOKacM4GFR3G/QoGQ0jrwp7YM3YBQtI0B4p53?=
 =?us-ascii?Q?6gR6JRU93senvQx8G5da3eOc/jhGTLhWmYGYzYsd/jeB4AphLIZ/wpN3v7/P?=
 =?us-ascii?Q?EzRaJfgCkdrTfPKeSHEjaLNZMjo8xk0GR71Jx8kY6df4uQELabg3r9UbrcGz?=
 =?us-ascii?Q?iSsXjukxB2emCG4uLcLyv+byb40EMvinRCDw6aUYw6QY8YIIQrK2QDz4h8vR?=
 =?us-ascii?Q?X/FkkKK7VydG5cE12zz575MJ4QY/avSOA9JTf603pIkTD++Qxh2cJOaadOWg?=
 =?us-ascii?Q?d70+g4F1+csM80X1emS/Mh8K6MeryIUKxzxSem2RsIJ0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FMTKsbp2U1GrHBk4wCDfTuOdA9pYnP2QwpiBBKAySO37RSRomGUjBPYJJPO7?=
 =?us-ascii?Q?vAcQ5Jv3O3nGsphic38H/XoF4cLdy3nt/zmTIYe+NsmVNaKWo5/OBGVXQW7R?=
 =?us-ascii?Q?QOwOL3w9B4fMmPkOjc1hwSOzJ71awYrr1+YJWcLNepZ7u0dbKviQCz5rceYU?=
 =?us-ascii?Q?BuCxJ6G0SlAo0wCO/ceBixjOO3aZuRXKXnoZkFIGgQ9AIzR8RE8J/hf2FtD5?=
 =?us-ascii?Q?GJAUpKg2waYISyTMBYYjndyLfjIQ/aWGhLFnDU+/C8ESXqIeXwvRcwN47jO8?=
 =?us-ascii?Q?fahUT95PD3kQtvvvusFt0pJGX2kiBgj7HqykYzqdar6D/T+bpsi9B6j72NxA?=
 =?us-ascii?Q?zL8QO0c3E8NVurVAGWNEf4P5/mPlHTSjLVzYGVKVjKtJlugAHvtaB+xH6Ij3?=
 =?us-ascii?Q?IeKlRmAz2fefAk3nZ0sl1CQAU6e3Xz5ctjNKWUVHMo8xA0xCVdwLH1Di+Wpv?=
 =?us-ascii?Q?FY4tHUE7sn8AovqZEnUUCaKW37lkPG84eeVB8skeM3gtwsRY1VGaUxp8Ss/W?=
 =?us-ascii?Q?vRJEXPlN+PcYXkm4ZBD8+zNF2j5mh0V3VPpA1T95aEt+AwSIky0lHLDzZH7a?=
 =?us-ascii?Q?D8OyfdK0/E4EhjU9vlLOsIuuqln/jCGWeIAk7Q+5/x7Qdo043PyY/wHhV98b?=
 =?us-ascii?Q?zVHikCo8elEVbyuHwCJkY+rQJbROF8DrlMrvkmqVmMz92f6dTVCG5ZIj8l6/?=
 =?us-ascii?Q?d84+UFO9njHryg4/RWWvsh9tIunb3FsuK+BoU2Na93hPByrPmvS5jEJg6ov/?=
 =?us-ascii?Q?twj3uU8pQeVyatRwOsaj565/uJkoX+Nmzecw7YWgfcouqS3sv2LjRDsWvyXA?=
 =?us-ascii?Q?sNgNFMVQOYq/3aLaSASvw+6iP59UMvgE9D2PFBWOdHGGcAfxLKU57JVsD2uZ?=
 =?us-ascii?Q?nWx195GedhnmZEQEsT+TNXE1y81afqkGu2vL7e/zzvPgIs6Bl8lmxXGsXbZ6?=
 =?us-ascii?Q?XjlYfDwzk32po8e8YJoe38EJTT59Vxrwpev45uI8qYY8skcNh2uw5Ic6t5Z1?=
 =?us-ascii?Q?I1Y38N+xlWikDqh3vHfcRU3qOrwnqq5r4dNRLoCbZR+Xi8e6WF0KEfZAPXQS?=
 =?us-ascii?Q?Kli8LczJPaZLSb4L8DC9B0S2LXJg8KpY+10Qc31qC1kmOVSQTflPdwf7B4JK?=
 =?us-ascii?Q?a0IPRcOf1R2YPKP0z9jnuc9ZTJnd4IHTP77WZDgmhqql10toGYvhZ66nWWDC?=
 =?us-ascii?Q?folZx+esbybuASiTjql/2hsVy//LVEK1iThnqfGuoE4s/7mcculIeSgAbFha?=
 =?us-ascii?Q?oKUsAuN3VItFMhFoYyOO+JDssNnT221W8wiGh1/vuPIaIM9WVusFpBXVOh+J?=
 =?us-ascii?Q?kUsd5djOSeIIP+sSuLxZ5nHDECN2g8XF69k6g4AgYeWBOTyQY/Y+1HMHmCHt?=
 =?us-ascii?Q?Gg8hz8sREy5NgrJC+d644nWdrse9VDK/qKCT7PsBkIKTrfeJfZRwVm2Zsv/W?=
 =?us-ascii?Q?L5a9Uypu1LRDDby8eHUx0pvFCSyIzpk8Rz1RTAILs8B2tiP76zMLo/gXYbmo?=
 =?us-ascii?Q?j2/TsmkVrai9WajS1UhnTyoxCwhdoQ2XwjBMR2WvomY2vpcRe6bj6Gq+Bxv/?=
 =?us-ascii?Q?/tPI17+ktfiCfvuj93ppMHwT2lTb09WMYN6D+uIXZ502wwFikkP8KVm0sT+D?=
 =?us-ascii?Q?ZI2iWxzhyLbaxqAouE4dlhZp0G4PR+L7volC+7G4zXeu5Sqsr9N9sG5Su+H3?=
 =?us-ascii?Q?RKKkcdH3IbPhkul+3UYuyn9EPN5U2/I41CYg4WLGQ1GsmN6FyWhVvfGN46oh?=
 =?us-ascii?Q?M1Gox+zF8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3018e5-1cc7-4d34-f4ce-08de5a265655
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:23:03.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apjblQNzQZkXGLNT9SG1WwPp42MIDVOW95ZInFHcO8cWg6ZUlQrtQgfUUmLH+7sZDLjCdE24HOXpv8QvIMwZYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252612-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35CC86FA44
X-Rspamd-Action: no action

Currently, the buffers of RX queue are allocated from the page pool. In
the subsequent patches to support XDP zero copy, the RX buffers will be
allocated from the UMEM. Therefore, extract fec_alloc_rxq_buffers_pp()
from fec_enet_alloc_rxq_buffers() and we will add another helper to
allocate RX buffers from UMEM for the XDP zero copy mode.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 78 ++++++++++++++++-------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c5ba532e00a8..867694d6d54d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3435,6 +3435,24 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
 	}
 }
 
+static void fec_free_rxq_buffers(struct fec_enet_priv_rx_q *rxq)
+{
+	int i;
+
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		struct page *page = rxq->rx_buf[i];
+
+		if (!page)
+			continue;
+
+		page_pool_put_full_page(rxq->page_pool, page, false);
+		rxq->rx_buf[i] = NULL;
+	}
+
+	page_pool_destroy(rxq->page_pool);
+	rxq->page_pool = NULL;
+}
+
 static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3448,16 +3466,10 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		rxq = fep->rx_queue[q];
 
 		fec_xdp_rxq_info_unreg(rxq);
-
-		for (i = 0; i < rxq->bd.ring_size; i++)
-			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
-						false);
+		fec_free_rxq_buffers(rxq);
 
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
-
-		page_pool_destroy(rxq->page_pool);
-		rxq->page_pool = NULL;
 	}
 
 	for (q = 0; q < fep->num_tx_queues; q++) {
@@ -3556,22 +3568,18 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
 	return ret;
 }
 
-static int
-fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
+				    struct fec_enet_priv_rx_q *rxq)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
+	struct bufdesc *bdp = rxq->bd.base;
 	dma_addr_t phys_addr;
-	struct bufdesc	*bdp;
 	struct page *page;
 	int i, err;
 
-	rxq = fep->rx_queue[queue];
-	bdp = rxq->bd.base;
-
 	err = fec_enet_create_page_pool(fep, rxq);
 	if (err < 0) {
-		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
+		netdev_err(fep->netdev, "%s failed queue %d (%d)\n",
+			   __func__, rxq->bd.qid, err);
 		return err;
 	}
 
@@ -3590,8 +3598,10 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 	for (i = 0; i < rxq->bd.ring_size; i++) {
 		page = page_pool_dev_alloc_pages(rxq->page_pool);
-		if (!page)
-			goto err_alloc;
+		if (!page) {
+			err = -ENOMEM;
+			goto free_rx_buffers;
+		}
 
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
@@ -3601,6 +3611,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 		if (fep->bufdesc_ex) {
 			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
 			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
 		}
 
@@ -3611,15 +3622,34 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
 	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
 
-	err = fec_xdp_rxq_info_reg(fep, rxq);
+	return 0;
+
+free_rx_buffers:
+	fec_free_rxq_buffers(rxq);
+
+	return err;
+}
+
+static int
+fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+	int err;
+
+	rxq = fep->rx_queue[queue];
+	err = fec_alloc_rxq_buffers_pp(fep, rxq);
 	if (err)
-		goto err_alloc;
+		return err;
 
-	return 0;
+	err = fec_xdp_rxq_info_reg(fep, rxq);
+	if (err) {
+		fec_free_rxq_buffers(rxq);
 
- err_alloc:
-	fec_enet_free_buffers(ndev);
-	return -ENOMEM;
+		return err;
+	}
+
+	return 0;
 }
 
 static int
-- 
2.34.1


