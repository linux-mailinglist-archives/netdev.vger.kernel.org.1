Return-Path: <netdev+bounces-121778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD7295E804
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 07:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF701F21BE2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 05:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ADC74C1B;
	Mon, 26 Aug 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fXXYa+EB"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379937406F;
	Mon, 26 Aug 2024 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650887; cv=fail; b=RQWxPke3EytMSS4O6E9cvtIdlFXSX5QACqjK3kBekbtW78yrjQLhSD6MhFHBD+q5/LIdP6tRIY5FVaId2IAu7Gq5UuWHrGVnbFeGHn6ulLhvniPOm2ncquiu9Bv+h3ZCVsqss+WEEAvsosb4iwWq93eflMBUEs1OCI8nixadWCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650887; c=relaxed/simple;
	bh=KsKkZlVIRJjpZbMF065kAIn9RX9aHqZoBJN7CGty7GA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dtxWJq4hMIGFzFNwkqcdzIPmB7BBXQy1Sb/aTj63258WwyJJ1GDVoE5Xs/HRU6MqOZBvPyHmYna0TbNSO0L3Q4Bfl9XGvyzLi8eB2b8Zg1fJEC+nUWDtBDTr++6By+p/ZITHSwHIH4Yti5qAZEaWPrJZ0SkkchcMR6REHmNlbNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fXXYa+EB; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RX4Y0fZKbVbavx72fQAZ5WtEVBzPIf5ZIIbZsieRWyNi7tKUTAOsCyowQ/pkQj6bwDl0K1Onq5CciOmv/pPilzhN4EVBS0rdSicpkiIkk9vlCJdublS5mUaX4kKnZSejsLKl9ijdRdayYjD3E8GHn/V/Hk/r8PZv/eJBCrr0G5zuPdbxlIuSg6Mo0DKdG0Kqd3jfU146HzAZy1eX/vUf5kbhakM+1bEQ2LBEMVSgDVjYmZbg1ufaOo+3VqoRHyMKDh801T0lckaYPkk85mVePMR1qh8HvPe2LVqn4EwsFUDfPWoQ2ryDwTr6VAus+ejksRkoE4ZhZZYJ+Z7LwMI7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSB5hqAD3P3Ky71n4MzQ5GBZBrM38F4+x2y5cVSGqck=;
 b=uDIBqKd1TdbfzdZ3MLjPd7LMVAsd4rJYcXb6j+SGRqhfmUn9VpocsEBPW6b9kz3CkZHxGFlRrtTSZR8KSaHcVfw1hvt1sn5XAONYFAi1Vsyz5xLpBukyCFGYMRbLJUxfV2xbj2unk3+uRvU2h0yDFkYoJ4Wn9EvKDgpTObcs/RPzUW0Po319DxbGSyueb4oRwiGOlLqSKeCVq8N1sswIfaVLQ1oorOS6P0zSqH96FVT/n60235UmvDyqKRwLup4zuyHd95CI3C1tPqTksrFfxzlZb2Y9SPxizrHTofzkZ7kMJxrz0n/NDk5cemNCFTYTxBbpCGglWswX6QD4V82iMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSB5hqAD3P3Ky71n4MzQ5GBZBrM38F4+x2y5cVSGqck=;
 b=fXXYa+EBgn7fXrP69HK3ay6NvMtL4KV2Z9N7DJsyPX6ZizOqV+yx9rBy9A5X/B0w8yL22dsLd+QIaIDAOuKm1Sg02RfhRMS303jbMJQZdYcZ+c7lS+lOVLcohzLSWkfbnOsVpWVARNQ2+/+qqbhsWW1fYM1JkpXXZOg2+eLvSDL8PxM6U2/RQi9UmHniBbmKSc4hW1qKXeuSovTMzABX3s5fDm0djRr2fJu23iff8U7BdyOlC4uKdZm7R5OXi9OjyKMnbzpzJ4JrTKX2CIEpwW+IxuPeRWO5zKfc5qG72CiAOdECyWL/5KJUvHVNKP7/7YC7qKfrdZ/TbeNvN/Gtvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 05:41:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 05:41:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andrei.botila@oss.nxp.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 0/2] make PHY output RMII reference clock
Date: Mon, 26 Aug 2024 13:26:58 +0800
Message-Id: <20240826052700.232453-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2fe532-b4e8-4e13-a7f9-08dcc591b64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ji7xZbP5VKF2W3eBSANf+iNB6Clx6X9vkT5+rucjTHO8Udch8SR6LspYEI1R?=
 =?us-ascii?Q?9vyqOBMbGa1xFveYryYxPy4KBIFcmYS50WkTkEOcX/Pvew+lkEYdB1ZTHyQ8?=
 =?us-ascii?Q?eJtgTREUwCUSXBHPOI1Hv1T1AdXg3IDXihjl+GAAinNkAag5dXEhzxNoGzPa?=
 =?us-ascii?Q?XQ212LEwcRcW9HoTet9EYCEblN7SCkHAkxCt9ggxSS4osCnr98FWb/MkRRPK?=
 =?us-ascii?Q?WGtzZv+WxdCFKDuy0fUjKZcVrDTXoZHgTblk53JBIoj/5kpJAcFVGvCXGCLb?=
 =?us-ascii?Q?jB0gNoTJ+IshembZtMKvp4Zubr2BIsg1JfOzsuabGF3S1quEUtTf7iVuAj3g?=
 =?us-ascii?Q?PHMAe2ufLqBzCpk59/4OtWkBCjl6t+R9uVaLcbK4ppd4HRrA4tkmt3b0TpIS?=
 =?us-ascii?Q?/vtxOAt77LRsgsYtT421av7F9P7HOpyvANZYdXlM1EHT3ewD2vEUZjfa8grL?=
 =?us-ascii?Q?vDe4LUy88wclVETxDY9P1XuDIoQh34DZej7sH+I6FRjROSHsG24mYzWQgVD6?=
 =?us-ascii?Q?DNIDI66t/TJgnG78wKR8yPQXNZLJ4yzbSvUd8ePCE7FWr75Yw8Vrmkc8BBML?=
 =?us-ascii?Q?U5Wc4w3uJvWNpCI1Vn5uTsa1DDD/yximirZQurt72t2D+dZzY+mPC1oCnVXs?=
 =?us-ascii?Q?o8U9LTW1L2GPlv3cjsk10Xr15Oq/5UY6BNMI9fQmGB2TrRkxbEtOQ1jRvlfG?=
 =?us-ascii?Q?qnzIlDhc/G/MrTbnpmLZpklTvIV4VGJdsdbbdtYMHCzkAe9hnGhfikyN2BNG?=
 =?us-ascii?Q?sMTl8aT/bZUOzwjHQYo30Vswlnrt9Kene+3UMs4Dbw0iiDXSbqnAOYxrCQSL?=
 =?us-ascii?Q?ky0TN1ek899iSVp+4IU9FbXILquUUQHUbv/LxELRzZueeW1yFbtuhI+slyFQ?=
 =?us-ascii?Q?kY77vo7ZJ8claT9W26podMhRGNs96rP0/8aMtBu8kaL9IhxHzmcTLnW55Y+z?=
 =?us-ascii?Q?x1JofwCW5mV35QEhQ9nAt22V53YAhBhrs7UzCydEKMvXGWzixZTn3f/kD+mj?=
 =?us-ascii?Q?GYyEcBPpBD84mhSDuV1NnsoApicjTLYSPwIoi4j8MwJy2KKYk/m5+euZ1Mj3?=
 =?us-ascii?Q?pZizMG4CwktY9himF5IvjCMDNWdFnaUbgwB5ZzjhJ38ad5SOecdxxE88T63b?=
 =?us-ascii?Q?clfLntqDIKyfjfnjiTA8tdB033GzzqPSWpoqXYL0CYyfcqR/3UUbz4ru6S1g?=
 =?us-ascii?Q?cnJhBH6hlZftKQHQK2sFjXhsNEnmz99UXYVtyRvcVnJUg4EtnMauoXOSumag?=
 =?us-ascii?Q?R+SIa+sMTLmazwQIn9naIqGRXTMbNUMm7aPE8prlyAWK2s8JwW350nCe1VSM?=
 =?us-ascii?Q?ljOM/V8aK/Ef/w4rJIWGdNWL5rIFejP0k3R8e6q89e1mEKnzXj4GJ8KLvLku?=
 =?us-ascii?Q?quDhMNW9ue3jmAi/AnYaXnol4oNg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YiVj3pjtzVgUAlHvI0AfBgcNagnUoY9NgbK3ls1Ks7z3Jqh5Mi8deRIY3Lzn?=
 =?us-ascii?Q?PgUTzcZpIEQu8FN++EVlBUHxsreQQmVKg6j03sRGHZnrtom9ecIgt9/uwUs5?=
 =?us-ascii?Q?sCF6P9oc5wmg95RznV1myFOxkdf5LcNlUsz2hIkSoBOijsnmI6CxjCrfdbon?=
 =?us-ascii?Q?50vegBGcUm356Z1CbgAPxCMcsjmJLWKSqoNyUsSTQ81I/f70bPVYg0OZLnUV?=
 =?us-ascii?Q?0TSQgmxhu23UHimVhWHxnLDdXG4ggUbps8CNP98S7o/L2TEU269j/7nC58/L?=
 =?us-ascii?Q?cDiHCAQVO0BiGo76GH8fNh74zw/TgiXJ82XYX+6E7z4xsR+vmmK+Fgll8IQc?=
 =?us-ascii?Q?3IXv70k1dau0EmYvKCtc9uKJ9vgJHAz6u64vQCW3FhJlvVljTE1vpqDJfSX+?=
 =?us-ascii?Q?gN4MsC2Jyrz8pJ4G7673l9b7+Dq8GsodY8KGOb2r9vJ5XADKnGfedJ17f+1t?=
 =?us-ascii?Q?9lXbmz0i3HzGGwp2MSWQm4P+BZurk5EVXn2IPaDUfAhIPIW5ThN3W0xz97mr?=
 =?us-ascii?Q?VyvvZgAGmr5WaX8/uRSbYcQzYr64pmqSbcLb1zLNVDXTUtKcJ8H04eG6u8gT?=
 =?us-ascii?Q?CAPsfisT0qAyERizEbbSvSWgykWOtT0NB5UbpvU9EONlfYrnGz5QHwcjRCrb?=
 =?us-ascii?Q?gz2EEO0SMuaONmBUvpSDrfqg+YNjKAqwwR5mVsZwt1yMtSov9kZA0uD2xA5D?=
 =?us-ascii?Q?Ta8yc9X9Clk38g3Z9/yUZsNQrrhLF3YRcgcwzSpcCZTzMpDWmb2zpXbb1GNY?=
 =?us-ascii?Q?v8cLQc9lJ2cHRmdlxtYw6JAaNbO0y90nTYiPSwqt7wzyKLqW4R45e7o16Vws?=
 =?us-ascii?Q?XMZa3c2mQ4C+W6Faw1FdZG0HmbvUROy13QMaKnm30x8M2/6ytXsNp/agYqMh?=
 =?us-ascii?Q?Q4/3+zE9R5cSMC5Wp85jC0MA5Nuju3fSjEldQCVumccSBoQiYsB41EHKxqOk?=
 =?us-ascii?Q?2tFwxNzeIUMklrDXrIbTZqlqg1VxvcmYPCAzNlFPTZbZf6qLXdF/97ew1wWR?=
 =?us-ascii?Q?B4iXyWPNpjiWcJMQBIN9iPWiWXaBx50b1XEJrQqSgt+60wfwnXDEjigslKOw?=
 =?us-ascii?Q?H8vqoceMXBzFRDkVBJwjsdAUuH9tWYYuQjsgZXG5MopXWa9alu6Yn4RXFGvn?=
 =?us-ascii?Q?gpKKIE85WxOfrsbcxXbd8oZefu6vu2JYGpwiCVjvhCSShzYAmigJpDQl6NO4?=
 =?us-ascii?Q?F6JQj9F5nugs4LB5ka4gkQjVGJhIVESGmDPfEtK41a4xYm6ky5wcmuH27ehr?=
 =?us-ascii?Q?ebwWKSIBM5JwbwLiV+4aqBnfDQbpbIpNTQgVtCrs8BzdcndN3aaI4136rmMH?=
 =?us-ascii?Q?cXVeEZvGFtXRQeTYj8STUAd+DfJB1DXOfAthvdEhbBNcL2dXc/0izqu6vRU8?=
 =?us-ascii?Q?c9N5gUEC9hbgkqHFoN9zbQYdu++kONErBVfqrLICLsxrVV7chH3f16L/q+cB?=
 =?us-ascii?Q?3wQVjaeUGiBm5WZNf0PIUxsI5DKC+n4uxKI5anCCb07Ls+0DH+PbRvd3y8Qm?=
 =?us-ascii?Q?jfM5S/orXcrpim0eCwFQNxkEUB5PtPQ22wMjF4lX5mtA4ktVNo+7RtCO9h9P?=
 =?us-ascii?Q?AL/mNqFcbq1/RqXCeeMRrSqVaIPeVAWKStfEPWjK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2fe532-b4e8-4e13-a7f9-08dcc591b64b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 05:41:20.2108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ag5Da4KMo96Ul38xlzZqXTHcn64w3kNVfQTkRkvYbNPbkTtM/5MGQpsKVKegW0iEjDPfTrlKpAe8ihMQ6JuEMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075

The TJA11xx PHYs have the capability to provide 50MHz reference clock
in RMII mode and output on REF_CLK pin. Therefore, add the new property
"nxp,phy-output-refclk" to support this feature. This property is only
available for PHYs which use nxp-c45-tja11xx driver, such as TJA1103,
TJA1104, TJA1120 and TJA1121.

---
V3 change:
Removed the patch 2 from the V2 patch set.
v2 Link: https://lore.kernel.org/netdev/20240823-jersey-conducive-70863dd6fd27@spud/T/
---

Wei Fang (2):
  dt-bindings: net: tja11xx: add "nxp,phy-output-refclk" property
  net: phy: c45-tja11xx: add support for outputing RMII reference clock

 .../devicetree/bindings/net/nxp,tja11xx.yaml  |  6 ++++
 drivers/net/phy/nxp-c45-tja11xx.c             | 29 +++++++++++++++++--
 drivers/net/phy/nxp-c45-tja11xx.h             |  1 +
 3 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.34.1


