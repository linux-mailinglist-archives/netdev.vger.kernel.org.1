Return-Path: <netdev+bounces-200196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ECFAE3B71
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4240188853F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E168623A9AD;
	Mon, 23 Jun 2025 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CIkf2quS"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F612192E1;
	Mon, 23 Jun 2025 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672779; cv=fail; b=DkMpdvpPhF4bymgt9JLhfZoQEyP9u0oBZUriypl6Y26JOfdNChJYGe5Iksmcx74x9y0mscOTCAh2yCq9pzrNeScGfiUvckgCrCI5Fl4gui5TLEnWFLbSd1vENzp9BD7wHzqsc2/LorXOr1ybwCvTyXmB/9mSpeE+pOzCR3hyRMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672779; c=relaxed/simple;
	bh=1JFatNYGPUp9gJEE4XILsJao76a0lDEx0xvW1L8VZDo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UMnrLNdq6I/KdccUF1btbEhEYSSca/GHzZnArJQLCdXGZwIacnKgkJFYW4wSQTSysSk+R3JNLZEepq7RIcz3k8BYI75LQQlBHCqFyS4HnSKtIS2vLYbDswZve2IvTsDuPlG+uYHV8ZYfgw8Moh1K2jFp+1VHNE4qjUyYAzIhMdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CIkf2quS; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk/SyRmPPmSQW/WgrtBBFOibCDfEnxTl2rtq947S+zQFKdBZYu24PnYrA/oZF/k+uWhmbNS2eG3VDmXL+gc7yoZ3p9CSABVx4+i4bM72b1ZGHWguTGchzkSRzJQBzb3eQ+Ce8d03lXJxMcObsUkhn072HYsPA0D6p6Xr2skYqaKjE8Q4LJYuWgRh7SkTb89XbixTMxXUED9rgFbsMrFxgoG5F81kvWp70IKAUVRj4ZSi1ajXhlCTrr2rUdFg1OaW6Kh3KgM0bhQruizHVDkgUBTNUpXwcIbyIIbQnENm+dej1Jmvqmzk0d6VdXq2Obvl6RmC2ced442g7AUmOFUl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC7BSjVXnJYqGh4kk0pGl4ER7Z7YcO6i9YEeQRSGH34=;
 b=Az/4mQVYtO6hDmLAsBbike69vGaMK38KXqz9BA9SH80jNAPCBATVMs3bgxrt2DvgZofHnbAY2lOnVRpbzcM0cwwkpgSV835kobZIFRoHE2M81HQ6JwOu9fynYYWuiB9WH88OwoXS/OK2UkKQeEAWLu0NN2iegn1Y9+tCfvPE4YT7scWM9lA/JHjUUi1aWvuLRMowalAJy4FE4YLYf0nQHbTo6RrbUIxGDe1G1nl6n64uJoD7VYTyMNdSIHj5iso0ccFqlPFX1mw3pgHQi31HLeqRXHoWbrgvf7Atc/ho5mTQOUdwsqCwIFqALJfe9N9gTWfb3yqZ3y988uUovbJdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC7BSjVXnJYqGh4kk0pGl4ER7Z7YcO6i9YEeQRSGH34=;
 b=CIkf2quSycE7wQxKCS2OTeI92S7Q8j3Eh9ZWtM6vRqSogWq6kWcjOYtOfm+Rf0lzpZY1p05KVH0KIBJqyBOEKdiyE8TXTOlzIdzPLE/jQd2RnK1g/BJ8SsL/u2a0VE7kI711N7NPD6KTJTGqcVL1Nka648hP2ojAMQ6Jedbrl3+vizuf3gGlQORZyWV5SCL+O1ly22i4eGLntzsk7amNF63gp7Mt8NbeEWDPCFwVIM7aH6PDErt0KnouqFhxyItwR95AycGz4rV3cRtvOdi66NRwCSq8OObLISHNaBwGxuuxlmMKxcF9nWeFH3gFFIl1ff2/F4ZlhAL6632RoCessw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA1PR04MB10841.eurprd04.prod.outlook.com (2603:10a6:102:487::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 09:59:35 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 09:59:35 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	ulf.hansson@linaro.org,
	richardcochran@gmail.com,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-pm@vger.kernel.or,
	frank.li@nxp.com,
	ye.li@nxp.com,
	ping.bai@nxp.com,
	aisheng.dong@nxp.com
Subject: [PATCH v6 0/9] Add i.MX91 platform support
Date: Mon, 23 Jun 2025 17:57:23 +0800
Message-Id: <20250623095732.2139853-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PA1PR04MB10841:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd0a83c-196d-44b4-9e25-08ddb23ca83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qh9iEELPguU/UER+JlwNwv83jaKGVo4yhuNfPQHpx08vzhAnC6Ye1U3iD3pa?=
 =?us-ascii?Q?5xAet9Vyxgy0kPJHnDm4aiNuZyn656xBT5vcSByjiAfCbp+GTw9SSLWuoIDa?=
 =?us-ascii?Q?6GduyrJx1GE/0isDmiWVoNpzPF+Z3M3EyngL3tVPoSY8xlAi7qxn7Raw4og1?=
 =?us-ascii?Q?GMgfhpBoTBvYYujwbVQ26Z2yqKmZG+t257borZK/Y2T8gdPjp/QL7wW7pbuq?=
 =?us-ascii?Q?Rs571TVntAtU09dFSMbo/3Ojny8LsND9abVo4+NOO+FxVnLIlnFvs23Ku3nL?=
 =?us-ascii?Q?eat1r7QKRGg4TssMfC4Zpofs+KQsRSSa/KLgBJDVcGPcZ/aTLdul8YKShdqo?=
 =?us-ascii?Q?2WVR39CeBAzSPDBHnRyOlVDNT6vsNl16G8XjG/K9VoM4GA2RNlvzM++cnLeW?=
 =?us-ascii?Q?PDGAPEEhcRtGCf+jk0k1eU0USVjjT+bCdgkAJxqkOc00aYWOXIrWEotWB0mP?=
 =?us-ascii?Q?Ip77c3w1lDZiQ+/lFL/yNCYQQqym95M7zxGVLZT2fft6zUDvCa3dk60yvF4E?=
 =?us-ascii?Q?O4tGiIfGQioyAWma64mzMIRiUroyOgpWs2ir00vTP3PgfyZB9ZrEAhJikJ3U?=
 =?us-ascii?Q?gl9PpOuZsL5TcUHMpAG6WbwATWPGjjcGXt+IIw3eU3XRIwQ2/Y8QqIhKCejr?=
 =?us-ascii?Q?/dmlEdQ6XpkYrrxMgwePV8lhF/OcWeDafEv/kGMvXih0WTep5t08op9UTZf4?=
 =?us-ascii?Q?LmEbkSsf/ugNyofWWWzsCiMkVtt9AFJJ5B+tqz4kGWzAulDrSHi1DkAamEl8?=
 =?us-ascii?Q?Nv7rS4gITZ9QuUI7XsD4JGBCsaQtXcDFPYCuivOzeaqQzSefuRIPareSZSXe?=
 =?us-ascii?Q?s5fN/4C2T5Pnz8aXEWZpMyejM4c08T0yEm4bqcjKiLyEHt7DMGRSSo+UDepI?=
 =?us-ascii?Q?xSe6uKxrfD+tAvjYkX6q1SxF6ITJzZXCeJ+gJdDQtK4Y3PtmfdcjJNAYHqU9?=
 =?us-ascii?Q?q1jPN8wza21KdXAFTT5YZF7UEoAdFv2aronvvtMTSvuc+fPJVGinSnBuB2PV?=
 =?us-ascii?Q?RYn78TScjWDlW7YCopBUH5EIcs+hbQTx3T88VxYdqfql/5nj7yvy8QrhlbLS?=
 =?us-ascii?Q?Jq2CdXEwX4DGMid7XQsByv5IIDGSptataEXtBB1V0+WczDda52PxTAr1pV5r?=
 =?us-ascii?Q?EYrN4P9X5YhpzsdgxCcm5k66+f8Bb4nXQyurgtZtBAaROiP5+kRbXDdmTaHL?=
 =?us-ascii?Q?uBmde4M+tx2cZQsHEElI8lSUYJtfBaBPhk6MiOE4ubJxHqbC2FJieF1bVNBz?=
 =?us-ascii?Q?S/zN7Jpyk0FLOIjgd6Vz1hA+RQH1RI5+eLraSeQJsN0jVP30fDkUYvj8ohGx?=
 =?us-ascii?Q?De1iJdLL5yRRRK9sWC7u2kqQUfmaFzZORfTshppypNtSScvAU6kI5uG5KUOF?=
 =?us-ascii?Q?KNlxk0qxqIM0WvtPzsD3Z4fH5NrOgM6sMeDTFsOrNDXZ/rh7t5tnramP7iRU?=
 =?us-ascii?Q?cFu/H4s1iGWU94y0kt8ETLjN5jISdg81VEc5mMcLdmti7Q3/xpe8TgPQuImI?=
 =?us-ascii?Q?E/Ncn91LOgXaE0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3diwTFitjiOpIy+gqb3koHoDlq7uGZ3YX3sAAi2AvU62CKCGP49yUbZsb0e+?=
 =?us-ascii?Q?Xj+j4ZmwZox93bZEMYl6MgxvYqAofRTuz0ZkJaRfv6GQoXsF/fyCkZ4uRPXz?=
 =?us-ascii?Q?6d506NxaRkOIQk4OQq/25wsk74b2HPNQUbRt5YYWfZ8oGYQkD0w4IY0KDOc+?=
 =?us-ascii?Q?WwipW1ep79KUa7utaFEb2W423pNRX4BJeVCs8INsDsk0clskRvOsJNizeKzU?=
 =?us-ascii?Q?3g+21EmOs60b1koROUx30gkJ8NvxpUTDMOqPmriKAJIVmsLrTn+aGH5F9F1v?=
 =?us-ascii?Q?4UtGNf2YnFskkcrjTQI2DnBnMnBnDvxJUldP1G8BKrHAdAI2zKtZTtNFPe+d?=
 =?us-ascii?Q?W/nUfJDl1GdJU1S/ic5i/xHaEyw4irynWEKvyrcsahu4NDpY2EUsfdBOfKPD?=
 =?us-ascii?Q?GmdaH34LZXQ4e4xBuRYdOxvBDXhjOmO84MrX9MBjx1utp+/QQ0eoBEt0Y06G?=
 =?us-ascii?Q?WtC0dgWv7lzri8y9vSr7Q7Uw7gabljkqv3aroxQIzXtPzAWYFmi7l7VP3Ybr?=
 =?us-ascii?Q?g+DLkxntWvq67dGTdvm2lOOHmIS7pE6EydI5zXRDXy1nyHc8m1QdYnaUg89u?=
 =?us-ascii?Q?0m5xDExTvEMVN0tG4KIeTTbTLVAk5yIre8nFUX2bPpE67B5x5cnN4aGXvx+f?=
 =?us-ascii?Q?NzJiRQg24VMov8OGr2E00fprIzLOAX5DltogQM+BgEAn4Q7T64hjJX83i1ME?=
 =?us-ascii?Q?WGzk10xMOP9i57kX+vz/eavpcsQOdYZ5cq0qJW0EWJ+Elq3GDcgR8KYioUds?=
 =?us-ascii?Q?8oHjUGH20RyrW7wqQ8iv/OmHAp8RVX0IJDUa3ejzGhqN/7ParVm3kWP4whYN?=
 =?us-ascii?Q?gv/eZhy3DCErX9rw245ZDaFJ5O5qHEoTgIoYh2K/faihxeFBnHyxdkYzsFbb?=
 =?us-ascii?Q?XM0iV8Gj8QCApPkHafDD6auSAiTauqMbhLeKTbDTUSGAxfU0+cwF5k1YI3ci?=
 =?us-ascii?Q?JqMHewiZCK30x8d4Qr8h0fVw6vkN6NKwrs5cuvPUFwt1oGOk7xvvBGHvOPB0?=
 =?us-ascii?Q?8TDHhJr315/tnvtRG+Vv0wJWSU9CBUf35XB2KVBsHg7XWRQxmAdjVnAZUk+O?=
 =?us-ascii?Q?dorBBTK7h2fpEPV0coPIdjZbX+DcVt8jzQZP5eyVwmTRaBYRB7jZBEkfpFOd?=
 =?us-ascii?Q?DM0+raqMJW5np7uMoBDAwzB6lXq+Ta2+SEfnIEU+H2kS2zfym2LVfTkTYPLF?=
 =?us-ascii?Q?yLn0w3Kbt4p+gmjwaM4kseplaQpHu/2qQE0YKHRXf0eadq+ExF6DaazVH8dN?=
 =?us-ascii?Q?v/5xkSPHy7UgyHL+hLu7BrCbvKXSyP731td6+SUDZBBvM/52bVhZZ0xJEOOn?=
 =?us-ascii?Q?OxfV3LcqEjSi5JG0+DZlWlZeupwoNeQWYRvtpm6pA3LTIUqPyfY9+AnEuyUa?=
 =?us-ascii?Q?139LclC/xIIvYpxtjcxKanqXvTaUcif6L5yyTN2fYnLqjbC8FgZO1nnyRiYf?=
 =?us-ascii?Q?6tIDqfIWGYNn3umwX36eh1ZTubDiI2/gvWHVtjJztVujlAm0q3npniLzwDif?=
 =?us-ascii?Q?dceI6wciWxotEpZezt1RmOc9UP2Zffmr2B3xgLSe0kWGacZRH79+rS/8aJiP?=
 =?us-ascii?Q?qngpFzDkfEYGitn942MXt4afINdMs2p0M6wAsVaa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd0a83c-196d-44b4-9e25-08ddb23ca83e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:59:34.8853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ys0qxQ3AvN7qmKgRkADgPCK2lqbI3rv/REdZtahciB6+jG0DMzfqOLWyggEtb5+c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10841

The design of i.MX91 platform is very similar to i.MX93.
Extracts the common parts in order to reuse code.

The mainly difference between i.MX91 and i.MX93 is as follows:
- i.MX91 removed some clocks and modified the names of some clocks.
- i.MX91 only has one A core.
- i.MX91 has different pinmux.
- i.MX91 has updated to new temperature sensor same with i.MX95.

---
Changes for v6:
- add changelog in per patch.
- correct commit message spell for patch #1.
- merge rename imx93.dtsi to imx91_93_common.dtsi and move i.MX93
  specific part from imx91_93_common.dtsi to imx93.dtsi for patch #3.
- modify the commit message for patch #3.
- restore copyright time and add modification time for common dtsi for patch #3.
- remove unused map0 label in imx91_93_common.dtsi for patch #3.
- remove tmu related node for patch #4.
- remove unused regulators and pinctrl settings for patch #5.
- add new modification for aliases change patch #6.

Changes for v5:
- rename imx93.dtsi to imx91_93_common.dtsi.
- move imx93 specific part from imx91_93_common.dtsi to imx93.dtsi.
- modify the imx91.dtsi to use imx91_93_common.dtsi.
- add new the imx93-blk-ctrl binding and driver patch for imx91 support.
- add new net patch for imx91 support.
- change node name codec and lsm6dsm into common name audio-codec and
  inertial-meter, and add BT compatible string for imx91 board dts.

Changes for v4:
- Add one imx93 patch that add labels in imx93.dtsi
- modify the references in imx91.dtsi
- modify the code alignment
- remove unused newline
- delete the status property
- align pad hex values

Changes for v3:
- Add Conor's ack on patch #1
- format imx91-11x11-evk.dts with the dt-format tool
- add lpi2c1 node

Changes for v2:
- change ddr node pmu compatible
- remove mu1 and mu2
- change iomux node compatible and enable 91 pinctrl
- refine commit message for patch #2
- change hex to lowercase in pinfunc.h
- ordering nodes with the dt-format tool

Joy Zou (8):
  dt-bindings: soc: imx-blk-ctrl: add i.MX91 blk-ctrl compatible
  arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi and
    modify them
  arm64: dts: imx91: add i.MX91 dtsi support
  arm64: dts: freescale: add i.MX91 11x11 EVK basic support
  arm64: dts: freescale: move aliases from imx91_93_common.dtsi to board
    dts
  arm64: defconfig: enable i.MX91 pinctrl
  pmdomain: imx93-blk-ctrl: mask DSI and PXP PD domain register on
    i.MX91
  net: stmmac: imx: add i.MX91 support

Pengfei Li (1):
  dt-bindings: arm: fsl: add i.MX91 11x11 evk board

 .../devicetree/bindings/arm/fsl.yaml          |    6 +
 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |   55 +-
 arch/arm64/boot/dts/freescale/Makefile        |    1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    |  679 ++++++++
 arch/arm64/boot/dts/freescale/imx91-pinfunc.h |  770 +++++++++
 arch/arm64/boot/dts/freescale/imx91.dtsi      |   71 +
 .../{imx93.dtsi => imx91_93_common.dtsi}      |  176 +-
 .../boot/dts/freescale/imx93-11x11-evk.dts    |   19 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 1512 ++---------------
 arch/arm64/configs/defconfig                  |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   |    2 +
 drivers/pmdomain/imx/imx93-blk-ctrl.c         |   15 +
 12 files changed, 1771 insertions(+), 1536 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
 copy arch/arm64/boot/dts/freescale/{imx93.dtsi => imx91_93_common.dtsi} (90%)
 rewrite arch/arm64/boot/dts/freescale/imx93.dtsi (97%)

-- 
2.37.1


