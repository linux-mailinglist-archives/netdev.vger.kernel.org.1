Return-Path: <netdev+bounces-128094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6528E977F5D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4ECD1F21144
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF6F1D88B9;
	Fri, 13 Sep 2024 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dgWWwUCb"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2E21C175F
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229565; cv=fail; b=unFS3ya5kim6mZUSBYuQNf0oCHpfjP7kWZym4K2PVFIDmEMVGQOPJz8T3zqnehBsHIiKSH626QYWvQXKttaF2gNUXTJ1He+/v3eqpeX4342dPomU5KaGEU3loqysO+TzJ9O0r29atgGYEkLJ+cP1dc1pigLhPkdhdHrukS/55Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229565; c=relaxed/simple;
	bh=MpA7MtGKxD1+r5SBSd5cTeapk0SmWTsPDv+wbhhJ+p8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nZPOXaZ16umjOQpWgc9OY0nNcNLenyUj2KpM5gkUb8YV96yjWoQAjuL2qD2azf5JNsAjtSI/2f4VvysxWbBjAaBhD+6xmuGcRHOaIU3SQ8PPeILgLTh77BgIZ5S2QvQDb3NTyabXiAV2xSCdsB33m64XrF3u0u5phAgiD6OQFWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dgWWwUCb; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYgzmfy+SYPdC8DL+6egWQa44ARCv5RNL5cuku0jYj/naOhBykBEpST4PYeLR9tpmQ1UKzEruBqY27sjC+kQrwt7BlzFwHcJmCtXEmLxASh0EDbq8Asa390LplECkRb6f0di0iMaJfOK/n73h6WkVM0kpa3NjxM0sYuvuIkaK+RpmK1SVYfAy7JaMYgF3eePYSLTFHhxbTwB3cZ/m9VzFzmO/rLYmGBJoNig3yTy1gM+tUFncgg7NMfbntlMTtRliEo8HZp5RervjXB53uhJolF6ltDQjgEoWGlAgVRpl/n5BmTzxD1wi2Q/30W0FohqwDgCzCKd+OD7/UO6bFJayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B42T+nxTYuZNvb6eLDHSbIIebDsvX4tjxOrdrxp2uw=;
 b=rxFOKIfym5AEloR/NOZHPpP0YNJ8isEbcQ7yoobIEG5kebskm3jL6ehIZwiWQp+nP8mlaCn7uZvgvXQDmHjO/SFen7y0/FvaRW/7+fksd7IVnAaGbIiHCSiDbPhuuu9UgKUoT4jE1YfebVcUtxVP4h8JZGGxaq8dO/UeNpvuTVd7NLJbUMAnSrNyTG/WK889e9Uakn/hprkrMsQXyB69oL4+Mrsf00qOxry2wMHSDjn6ehiamGbVZdqxKxcRY4hluoV2GkO66r/SNoMIlKaw7aAnGEwIHzgJlSZYpHJh62he+3Bu101l7bK0xs95VsWz8YKXerPp5skjBncocqsqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8B42T+nxTYuZNvb6eLDHSbIIebDsvX4tjxOrdrxp2uw=;
 b=dgWWwUCbu9byO/8IQCL+zop1I3AL7VNsbYn/X01jnh4tOPM1w/cj0VWUeKFEpVW+z5xw2RGf6rFYQA0GvrqVchVnlPHhMpBzg/rBGV9fVBx8zMMk6U/Fx3dvBCzOaPrt458whPwQu90LMwI6iN4IYUldHuKyjVJfPcOZjANx6fj6AgQgGsfC8/yct9t+UX9WqbDRMuFmuPk7gmy0/v0P/VRDIlMv73ve2eFntXgnVGV5zoMNUfd0yVWJQS+nEFo2CCxx9oiymUmEMjDMe+OaR9wVXnz72/GNgm1fxFe7M3/jNxu7SosMh0U8av7bxHN4R7W6mvSqemlKOLFqM/HMFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB9884.eurprd04.prod.outlook.com (2603:10a6:800:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 12:12:38 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 12:12:38 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Hans-Frieder Vogt <hfdevel@gmx.net>
Subject: [PATCH net] net: phy: aquantia: fix -ETIMEDOUT PHY probe failure when firmware not present
Date: Fri, 13 Sep 2024 15:12:30 +0300
Message-Id: <20240913121230.2620122-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB9884:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d8f05c-5a9a-4268-b122-08dcd3ed5bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EHWeWo3k8V9RWh7ryzaaajR4wjZs4FCHFBTbdbEyYdZH358iQ7woCt0QpBKH?=
 =?us-ascii?Q?7zVzDg7Hf8VBxzVBc2OO/Yi9QWf9gW0P4aT1DPo6YB1SWiRy5bu03gMd6e3X?=
 =?us-ascii?Q?JlJWV2gbj2lzPBplCFNZaMboeKjmk/6TaFUtfTHNuywTn1YPyP+BDX6pA4nP?=
 =?us-ascii?Q?e3H1h2jByrkw3tXxLlLVAprBXeCqJU0Chg5ffUViuw6cuqX4G1iSV5/kJ7zr?=
 =?us-ascii?Q?aW95Ud0PYYtlyQ+wTsnLhLlgKH8SmKp3N2lZJMvno8aYP5P2wy/i4u3YwUyV?=
 =?us-ascii?Q?REX5SyTp/5srHmB4ZWQiQTUEHHuG8vY9Dr/Ko1elV5WsMN4S7tUrkNBbnRod?=
 =?us-ascii?Q?1lI8OZquW/KZ8WtfFlYPLwHTYzRHLgOsxLDbQdwD1xsqFTq4Su92GAmGwft3?=
 =?us-ascii?Q?Kqn8G4qNya65Yw06eLZl61dLok+A/iykY5G7XGTuT2kLtH/E9xpNgP9f1IP5?=
 =?us-ascii?Q?U89h/MgCSdnUam1xeyeioJe72cNZ/OkVtapM8v+c8djkaHjkWw57lYhOj4sQ?=
 =?us-ascii?Q?sgCvKGQ5LHdzk2UygYFvXA9zICW594sLkGSA4UngKR8pxPIVmjhFjkv7Vn+O?=
 =?us-ascii?Q?0K8SA5Qk8CTY/eF98miMeZGcfbsvdX6bFxGT8B7FGg8xPsEm4cysrKm9Aptw?=
 =?us-ascii?Q?9hn0JzT10wJruFnNG8KT/T2jezcTe0Td06dnkmgw0ciqgz9yAHR6tvE6b8FJ?=
 =?us-ascii?Q?VO1o9SX4qHB4VAYHkQkWOY/z8hqMMp3lKW3iZ3jV1iTinYrssdf0tg8zfvtD?=
 =?us-ascii?Q?WN3MEqyVFvdltl1zI5jwrvImA0Ym2mA7dc7CEGpKJWZ/I4H+FGZOkhUQyOUY?=
 =?us-ascii?Q?BUpQFa4MI/L2EwK2sZHU9+/a9ePYj21jDHrnIE+ko2jFG3anacwD3ekPvRGm?=
 =?us-ascii?Q?ijWDH15Ujncu6zoINjuKIm6ncnJUtDVsu2z/EBA9eirpx+WQNpUYjhxJJEJk?=
 =?us-ascii?Q?HeuMwdesyNcUu/OmL/pga2qoAWkzJdA6IZGCv2dgd9JLeP0kKvQCLyNpJy4M?=
 =?us-ascii?Q?cTxtZEGF8kZK0O+iNEIH9UwPSgUo2g+l0i9yE4vxgD4ENQ9s+mrXIquDQ+Uu?=
 =?us-ascii?Q?edL/KqymXhJjdETWzY/Vp1Le89Gbp5v+M+43KMHDZqgKkjHUroOx/wvCIPQx?=
 =?us-ascii?Q?TYwou+ZigFghE4zkR6OwOyQmm0kOxP+SwnPYANQ7Iq3OzeIskKnwg+1VG8pd?=
 =?us-ascii?Q?I4THMl6oFk+13elufsbRARkIesVEEsUSOOry2q+TgWcAY3xck3GwK3YZsT5q?=
 =?us-ascii?Q?PDqkviJf50MLVau+VJlqu3ctlO7oPfihsJLwzuRf4G2NgE0RGXOcayzLt5tf?=
 =?us-ascii?Q?y2ekcc+3yaa2NoGek/bsDCetLknjVYvr/RKuSLJgt6jBgh63xbjgBn+kITR4?=
 =?us-ascii?Q?au/Rtp/Ct6bjIjPhoWnm+JFtUxU30IUhxhTX2G/48ekVxwQ2vQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5TkkIyXT1mnS31O7uk+N64dYyLuwPRDl1u6PFwBBWSHG60+B1hf/aNuLFnEF?=
 =?us-ascii?Q?H3x6JWPH0xb9Ad0x95F6ryRJ5blLm3eo0drivE/BBNpeaRU/O9bo1FEUCnzk?=
 =?us-ascii?Q?nsqg0uT8C6ONV6Ajc48vyJlJyZfEwnbyNeBUXAWyMeik9DaEJi6abrt9l0MI?=
 =?us-ascii?Q?L+yT28sYgTo8mbosw3f+BPDENn8f0wCjvBJSOoCmS8H3DmZa2KxHHuECf5iK?=
 =?us-ascii?Q?EMr2vFalI63bTvlXkousVY5m8LiModcmcO/wEGLxegzeeloCtIM/NevRwViv?=
 =?us-ascii?Q?vx/MoraAZF1MHba7leye+GXONMhYk31IrExVUXXL2FGMuFCDUVf1b7uPX/+x?=
 =?us-ascii?Q?egAesiMsA3yrZIgwm48yMWzziU6DthnKFOjqEzt1wNQVPUGjU6Byegcuggcb?=
 =?us-ascii?Q?MB3h3oAyYAyGjBp+n5wzSDaSPvqk6G8g+mG77lxoX/wnLOwlP/4Yjd0QB2rQ?=
 =?us-ascii?Q?foQY69/xyk/aJozHRKZUlr6K2Cc7iYvBzzQvfUNNXcnzKCHyY7l8HXt2lrU+?=
 =?us-ascii?Q?QajO8YjTYMvfmZAHlcJvlWFvujUeFpiyorcfVroxKzdmN3JWRkNVn9yr6yJs?=
 =?us-ascii?Q?/s8Ta+NT8XmQWoscT8Zn6bDgO/k0AxeXyHcglR/oOH9OtPuPPeijmqbjvBGm?=
 =?us-ascii?Q?QCOHolz981EhLoR3LNWW9TvMx0cYqaUIn4e1YZTh96WI5nWMx3yxZiHKbe+N?=
 =?us-ascii?Q?iyuKOwh7gEabW6h/YCcamRwdlIH9lBLpRYw5D6OYAMh/HyqQyNGNOuMTJh/a?=
 =?us-ascii?Q?o3ofYu8Z6cDvITJ/yNLOqwoNJiswxIjacLZzKG7Kb2IY45d0TGkEfawQ4HrA?=
 =?us-ascii?Q?6MBsXHQuQEXOP+svTzy9fZxsYNTcyZqRL9GfxQeV8jFLN8POuIgJAhbv3EC7?=
 =?us-ascii?Q?gBs6JIwcuPnaFYcCJCurulAMkpeb/rvMH1TTa+MyeNjiCu0mHC4MmdXpthgT?=
 =?us-ascii?Q?tX+JAyKo6oW11qq44pflGG5CerchtAi6dFnsU3fB4NpKA0g5y/bMl16/asjy?=
 =?us-ascii?Q?2EFeu9BKEyhhVnCQ4YONGsl+I2c540h1XjZUn+yJdHP0zEvg93sHy9j1UEfv?=
 =?us-ascii?Q?7CuhTem+WZuS/cg0M4WRkABMRCHhbotHEZTVZzJ9rcpWtnD0ERRwcwcsB1uE?=
 =?us-ascii?Q?Ua0+2fUwIjDdgcl4/DH5SRrvozjaW0KlZCRfPWp4H1s9j5ks/KotyhvXKwEC?=
 =?us-ascii?Q?DUPTlvPdm7hymr7qrvKPFSq3kWyKl7GJBHAEFhR/+xc5Y+OAiTSga/NK5PTn?=
 =?us-ascii?Q?+41hYnRG+ByXgK/BTRkQx2mpzz7rD/HblZ7arUvp0hlqP2+SY6Ta1KwvFlc0?=
 =?us-ascii?Q?zj1hF/2zqzBVH0Q4G5EZA+mJb7k7pTgCvRSFQ6t/KLQw3YR+Aa0jtvFgtj/B?=
 =?us-ascii?Q?aq8zHBOTVJyYMY+k2qrrCd/PRQBHKl6tLIB+MuzaoUZcgFbZw9OBgg2qBe6U?=
 =?us-ascii?Q?OjUdrgqMAwZew9FT2bOXpvfQfkamK5mUdet/VyEXTKjIrj2eoN78Avqq9TPa?=
 =?us-ascii?Q?rb2MO5gYZoTVsZB2ia5k7cFug7xKLM26YUaqi+jPHPZc/gZJ5s/aE5oqwPNE?=
 =?us-ascii?Q?UjTIEe2/uAHysICx2Vq3fwi6L6K3s+IA1meeWi2MN5lUVz5WuTGAaNJvttHf?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d8f05c-5a9a-4268-b122-08dcd3ed5bf9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 12:12:38.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9JhsbHlVYl/RUwk65SXQVDsfF13u5qxPIq+ihu0nDeUnlTBtkAeuuRkVqj0sKoct+KD2lztr9mBBBUSzQkErw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9884

The author of the blamed commit apparently did not notice something
about aqr_wait_reset_complete(): it polls the exact same register -
MDIO_MMD_VEND1:VEND1_GLOBAL_FW_ID - as aqr_firmware_load().

Thus, the entire logic after the introduction of aqr_wait_reset_complete() is
now completely side-stepped, because if aqr_wait_reset_complete()
succeeds, MDIO_MMD_VEND1:VEND1_GLOBAL_FW_ID could have only been a
non-zero value. The handling of the case where the register reads as 0
is dead code, due to the previous -ETIMEDOUT having stopped execution
and returning a fatal error to the caller. We never attempt to load
new firmware if no firmware is present.

Based on static code analysis, I guess we should simply introduce a
switch/case statement based on the return code from aqr_wait_reset_complete(),
to determine whether to load firmware or not. I am not intending to
change the procedure through which the driver determines whether to load
firmware or not, as I am unaware of alternative possibilities.

At the same time, Russell King suggests that if aqr_wait_reset_complete()
is expected to return -ETIMEDOUT as part of normal operation and not
just catastrophic failure, the use of phy_read_mmd_poll_timeout() is
improper, since that has an embedded print inside. Just open-code a
call to read_poll_timeout() to avoid printing -ETIMEDOUT, but continue
printing actual read errors from the MDIO bus.

Fixes: ad649a1fac37 ("net: phy: aquantia: wait for FW reset before checking the vendor ID")
Reported-by: Clark Wang <xiaoning.wang@nxp.com>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/netdev/8ac00a45-ac61-41b4-9f74-d18157b8b6bf@nvidia.com/
Reported-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Closes: https://lore.kernel.org/netdev/c7c1a3ae-be97-4929-8d89-04c8aa870209@gmx.net/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Only compile-tested. However, my timeout timer expired waiting for
reactions on the thread with Bartosz' original patch, and Hans-Frieder
Vogt wrote a message in his cover letter implying that the patch fixes
the issue for him. Any Tested-by: tags are welcome.

 drivers/net/phy/aquantia/aquantia_firmware.c | 42 +++++++++++---------
 drivers/net/phy/aquantia/aquantia_main.c     | 19 +++++++--
 2 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index 524627a36c6f..dac6464b5fe2 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -353,26 +353,32 @@ int aqr_firmware_load(struct phy_device *phydev)
 {
 	int ret;
 
-	ret = aqr_wait_reset_complete(phydev);
-	if (ret)
-		return ret;
-
-	/* Check if the firmware is not already loaded by pooling
-	 * the current version returned by the PHY. If 0 is returned,
-	 * no firmware is loaded.
+	/* Check if the firmware is not already loaded by polling
+	 * the current version returned by the PHY.
 	 */
-	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_FW_ID);
-	if (ret > 0)
-		goto exit;
-
-	ret = aqr_firmware_load_nvmem(phydev);
-	if (!ret)
-		goto exit;
-
-	ret = aqr_firmware_load_fs(phydev);
-	if (ret)
+	ret = aqr_wait_reset_complete(phydev);
+	switch (ret) {
+	case 0:
+		/* Some firmware is loaded => do nothing */
+		return 0;
+	case -ETIMEDOUT:
+		/* VEND1_GLOBAL_FW_ID still reads 0 after 2 seconds of polling.
+		 * We don't have full confidence that no firmware is loaded (in
+		 * theory it might just not have loaded yet), but we will
+		 * assume that, and load a new image.
+		 */
+		ret = aqr_firmware_load_nvmem(phydev);
+		if (!ret)
+			return ret;
+
+		ret = aqr_firmware_load_fs(phydev);
+		if (ret)
+			return ret;
+		break;
+	default:
+		/* PHY read error, propagate it to the caller */
 		return ret;
+	}
 
-exit:
 	return 0;
 }
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e982e9ce44a5..57b8b8f400fd 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -435,6 +435,9 @@ static int aqr107_set_tunable(struct phy_device *phydev,
 	}
 }
 
+#define AQR_FW_WAIT_SLEEP_US	20000
+#define AQR_FW_WAIT_TIMEOUT_US	2000000
+
 /* If we configure settings whilst firmware is still initializing the chip,
  * then these settings may be overwritten. Therefore make sure chip
  * initialization has completed. Use presence of the firmware ID as
@@ -444,11 +447,19 @@ static int aqr107_set_tunable(struct phy_device *phydev,
  */
 int aqr_wait_reset_complete(struct phy_device *phydev)
 {
-	int val;
+	int ret, val;
+
+	ret = read_poll_timeout(phy_read_mmd, val, val != 0,
+				AQR_FW_WAIT_SLEEP_US, AQR_FW_WAIT_TIMEOUT_US,
+				false, phydev, MDIO_MMD_VEND1,
+				VEND1_GLOBAL_FW_ID);
+	if (val < 0) {
+		phydev_err(phydev, "Failed to read VEND1_GLOBAL_FW_ID: %pe\n",
+			   ERR_PTR(val));
+		return val;
+	}
 
-	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
-					 VEND1_GLOBAL_FW_ID, val, val != 0,
-					 20000, 2000000, false);
+	return ret;
 }
 
 static void aqr107_chip_info(struct phy_device *phydev)
-- 
2.34.1


