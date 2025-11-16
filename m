Return-Path: <netdev+bounces-238908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEE8C60EC7
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 02:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEB694E1ADE
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 01:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA12821A453;
	Sun, 16 Nov 2025 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SMtn9UXS"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238C31DE4E0;
	Sun, 16 Nov 2025 01:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763258342; cv=fail; b=ZgCgaA+GOMqRiWSnq61r4QbgDmrFb2TtKNtcUIZ7T7s+9Zg43RHIWKeeAfzf3hzTxs38DWCTE6zPRGWv/y9/BVLe2mC+g/I3YCEs7miLDUtXFDmPYxKwPRXnAM+z2pAGU28vYavWvIa3+PNRSgHfmeWFsdH62XEFYs7Kmsr0feY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763258342; c=relaxed/simple;
	bh=NIjHzQpYaErW3JVdY1kfC45C172tkpw8hjYBPFxj7Is=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PpD7hC+xnUE7bpY0tK+c1Iy0ARoZ5ug/7KObgscQC4AeZryPsbZ9xtBDNyt75c8FYzo+hzVSYNLKUwJHG9hfK8BbRTKUBY+bzl6r+KE1AwLef2ih4q1F5VwxkXDSxb8ZOx3YAn0Ew5p6l2rzw+avkPhbyNuUV1UvTdcrkSHepDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SMtn9UXS; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NilMXHv3EDq3zjvfNN6Onfpc08p8LidMAR5+pELf76QCoUMCSJ4ZhhslUkLrFRsC1c8PM0TF2ItQOcZ7B7YNZeDn3cSCIs6165ls2GtfbdBmc5tLdTypE0fJmxgEYEHrw7V5DXy3jQceu1Q6tGzEfX7NWGk/ty17W3tH/wWVoJMAVSGtZ8nP2QRpr+SW3k6vE7l/xcwcopT4yAXO0sHYwmW9vmJH/RhiG4k0xtmRlmmMl1M/2tkJKyJXiqqaSt4g9amo+VLy1AKm15i9cBvomQm6hX71BkQbyNJoZMeiijRsszRayS23yBQa/9d9a+QEKXvPeI5LuTheHyHfkfbRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zmr9Vjkbd7GYQPZ6UCIQFpKGIWkwYYLrOxtCWr5uSoA=;
 b=LpHwYjkTh0e3YUcdIYPgwnoHgJ6p3rjilTy54E5WopedmYByfeT60g/Wft+6g+ai1AFOgholrVeqI/cpU3Iz8WNXOug5lX3q/r6EWdBwm7LuWwAN9tMWWtf3xWjisrEWoct1iS/zS7PZRMhQDHoB5LN4oTaAhjRwvzJ5p80MJwOqTM84uuRlp/n8ofkdR299edP/bWbuyhuDZFlMbDy3lksjTFtXxb0tWcuf18nfLXRwSzhh4YGNrbJ0pNXtx8RxXG8iCIkoxZW9p4BBniiA/93IieNvapYtYLD2L9TgEnK6fazJ67RaUgD8MP1NV1dqHPB/LkeA5JsCV5FnM7d+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zmr9Vjkbd7GYQPZ6UCIQFpKGIWkwYYLrOxtCWr5uSoA=;
 b=SMtn9UXSFxLnEbZJBkwuokvJrVTDzJ+RZTKlPNs0qlvRm70fJj+OrvYer3KtOGd2nPczqiqQRHtTEyzSgcNTgTx5y5UfAKBHyguFQmUj7C7lWVE4gcBxLa4Juq1AaZV08HAlXXvgG5UXCKT7opvUmFdb66E7bDzqXnyIUbH2ws9jeFRxlYLGfajfBGDBTq3rS0LQxw3AW0oNx5DNLiFYo8vzfx4CpuXSoi0A+TQcGCaiwNTkgTGJPAXxdaSYhs1vegkaoBDlytE0Ew+deFDEOkuYhWZv3hHYWTPTyW42mUPp/XlIhohJwS6wxmCR2pqjsAW2XRZRsXdkWHme0o7ZUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8469.eurprd04.prod.outlook.com (2603:10a6:20b:414::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sun, 16 Nov
 2025 01:58:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.018; Sun, 16 Nov 2025
 01:58:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	richardcochran@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: imx943-evk: add ENETC, EMDIO and PTP Timer support
Date: Sun, 16 Nov 2025 09:35:56 +0800
Message-Id: <20251116013558.855256-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: c9737334-7512-4aed-a4ea-08de24b3b35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h+6u/XnT7n+AuMgV/qd1Cg0IU7g38173yEUGrsaUMzXtlZ85sicH41dECDqU?=
 =?us-ascii?Q?+H0KW57NlWrD9+gLD/HaeVKxW8A5GiaNiTuUG2bp1+nrXR0nAAz0Q/RWVlk4?=
 =?us-ascii?Q?WujJAoQqOVudnchRsP+XwePSa7nIwFadxJygogm01aRDJ4srvx3LSCSeAmjR?=
 =?us-ascii?Q?xBzeXidDGxoZqcThiMRgQZKnm9Uvf+SSaUnYiKgy69IqsqBejD/iGYcY00gh?=
 =?us-ascii?Q?av8xdm9xjZPJCUI2sXvviF5IJcS+qvGPo9w5W4nOrFMUl3YCiKTtHaTohp5v?=
 =?us-ascii?Q?VwL4cHjSX1v2vRKVOVLKoe4CYJNdljthoLemp4xDiYKWu6FrR4B1BDdrEyQh?=
 =?us-ascii?Q?IZE5nOXOF/AdcqLHYJIdE7MX2JrHBsmJhFtXVQxVy35vq0nfFsJ2Kjix1qBp?=
 =?us-ascii?Q?RrqBDv5+DxcalZpRemiNKQoevQorlOniYDqFgyAe6T4jUpVo8lcfcDvYpiPb?=
 =?us-ascii?Q?PbnVoMYl8VSFqnWbXWnOGgcTxKeD8BihbI1Izz+ff49i52yNKXEzfEssplEu?=
 =?us-ascii?Q?Fu2RHpjCFW2s5n5dNR2z0nGjZ3uK0pvB97H5BFK8gRE2db2IDftpY3fK3gSQ?=
 =?us-ascii?Q?/5rpumt+0VgzDtP4CL54FB0TDMiJgmMFGiRHM38t9MSG75PRK6jJMs4NnCpH?=
 =?us-ascii?Q?OcBNqr6p8LpNncLUMUe0AI8DxRUU+Y/aFCoKbXVqC+obzqQM4ppCOl7zZXKa?=
 =?us-ascii?Q?PHP2tRBGKpTasAWIbV8nEZDrxPvayMsqh3h1g00NZO7bvhr4gPJ3mp8YXezh?=
 =?us-ascii?Q?3XoDj2kE1AECZ+YQA4Gig7e96+eFv1F+8FBxLcKHyAQSwshb4+SfXvMrl9+g?=
 =?us-ascii?Q?mDmRLhTz4TLZDt5imhiHBOUZAAwMq5uQSnYcLrqQwhzmilbY85Z0C+NCeQNN?=
 =?us-ascii?Q?3X7BNpmoK0FXEqDGTJFEyRZapvXUcQbXmzSKjlxnVEpzAqVYmtfD7YBFzxv0?=
 =?us-ascii?Q?V/Z42hBHPYHrSx4w6QAmcAJTd+XQ1TKnRT+egld8zFHrljDi4OE/+aOC+mEj?=
 =?us-ascii?Q?dy2nr7jZo1Yay4OF8BrHfgxdgcT0zxaKvHjRpyRn3ZKzTkT+ncEo3yWZEf4u?=
 =?us-ascii?Q?dMIsw7xiZ6Gq3cBX3Z/+ZjEY06Inzxo336pOiE+QAtJsXVuFwNzMVbH9cwqd?=
 =?us-ascii?Q?TUQ0Q0UZcyNU13bvi9H0pguhBtCZifDR17dX5CUB86OXSuArr9Y11FWb5JEx?=
 =?us-ascii?Q?dmkQPc5Gl11hJKths40qD8N7SLFKxSy/d6mKjAoeRyqU4b1sUH4z3uT33ds5?=
 =?us-ascii?Q?QQcCR7jTz4GTtyG8haWBsnyS1hiuoUlQIb9PHtIAcPtiHh1SB5PZQ0SYsM0z?=
 =?us-ascii?Q?t2FR3uSZ7cdOjm+6rWzxtYjSJm4/U+EKdFL6wWuQeg/8vtaQG1g9i1SELAA5?=
 =?us-ascii?Q?UAfRRbckzJhuXeuONj5xh2X66wMg9oTUCwv81D5vvQL37XJmcXcuMRc65P16?=
 =?us-ascii?Q?uoO1+lBJ3LSZtq0yHEUnJypRPfc3q8snG3EOXqlRs5Z0l3fAPSNHjSMM3bc6?=
 =?us-ascii?Q?445YRwAzhSkMi/CLSCv2qr4VUDHosP+D6814?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JSYn4QaH2kqfvl83eMueQsACwNbtB9mVyKGFMF3ibjvpTRzPZ2lNayCsAX2h?=
 =?us-ascii?Q?OqCo7yqRWyyussgywkREGhAbjkVOmXsktW3jJN8hFK36KdkLi3vCGnq3HLkT?=
 =?us-ascii?Q?mq1vQLyAmgzWAL1yvSjL22ceSnVB4xJ6mOH+UPaJe7Lvq2JyeF+hwqmNHKZ+?=
 =?us-ascii?Q?RSZV8PIlF/oj6imT8x04AhB1/mPCBRHJnr3rYklIBEnMz2xkX9zxO4UOhUlM?=
 =?us-ascii?Q?hFvRuKlH0P5TxHY3/srFyLWzXKghi0WW6mBP6Z9YjX1rYonhD9bhht6SQBtB?=
 =?us-ascii?Q?BRV/rnXosj39QzdL0midCcWd2YbcIJ4M0tbXTfmj+XyJf6t2A2M6mdcvRDxk?=
 =?us-ascii?Q?dqCqbT7VORKWJAMwePY77O/d9Gd+65g+8Nm+Wxx/dVUgmXSm28zyjBbs/j3M?=
 =?us-ascii?Q?RnNAvcq4AWrt73kPGwmN1dRqoQ5TDlEBIJQD0m6IY4Fzw7R5nxJ6JTZHNttl?=
 =?us-ascii?Q?K0C4e3T7S+ZrOaiba77LjtydprrnR0SGD7F06Ijv0I3+OaB1P2S8v/FvrKFu?=
 =?us-ascii?Q?giRr8WBGvaHTPRf8+L0tgmff9wpNwS2VLLQj9FnjSfPTOxIY12ALZhROJL7B?=
 =?us-ascii?Q?wRlb7hWsng4T2hR3nP35/PBqrUc6dK9s4aIgkLoUX8/0iJEH2xCgErM8ez84?=
 =?us-ascii?Q?Fsj/iUNm0ZBNMvWw+PZf9lMU4hA2/InGhiNSKGNApkiiklYXNOA5T+iRnFFZ?=
 =?us-ascii?Q?5A14b/v98gHWZk3FXhk+08nUKdpnd2ktJWGZXgijr4Hmd39FiCHGBNGGFYr+?=
 =?us-ascii?Q?3uLAw62ZHYMOz6G/zXbJHGeebiBDl54w34C7P8OCL/TPrDa5a5jbOnlo7+32?=
 =?us-ascii?Q?nABHbqJlncw7UaXbrGABn2D1cP77k2hFnASuNDbzvim8dQ9Puqbn4nHw3cPO?=
 =?us-ascii?Q?wNXg+Blsv2ibD554+wbSlywsq2WGLwGtOJrItIpsNAHXDI8YCtTAnzzgYED1?=
 =?us-ascii?Q?JyAYkfd6oqNW0dYezZGIqL20xGqNiNkhCSAqd6LnTWlxfjCsHSi+R0+xZvn1?=
 =?us-ascii?Q?PCezqXBiZZYzkOIKoChKdrnJ8DD8+s9woKZd+IIQOy0WYyXEWSzPPbNGJjeR?=
 =?us-ascii?Q?lVcwjFLhThar9SfItucbKOYq0hcd7rEdhXSM6tpKXb++mAKD1k2mGOPA9n0Z?=
 =?us-ascii?Q?s1ucI4gVNbAjYbtDHLXyiDFoQeeoBnBbxbuTewKeni/uWi9b/q6RQI1gGbf3?=
 =?us-ascii?Q?s6H45e+v5+8daYfqi1fWC4PZecISUG3/y1cPGAm1+QCFRycE6EAVtVPA9RC0?=
 =?us-ascii?Q?C2ulLTELnvVXKgfBorlq/j4UgKDVXY81f9Zh3io6E2++up7jct+FX5+27sGx?=
 =?us-ascii?Q?EIEYDQq+t5CUX3LvsGnyJZpMy/TlAiIswO1WI7xEUrjVL2HL7DryUopRnnCV?=
 =?us-ascii?Q?u+RKJiBZOdFcCYQItMNLoG0qWCXde/JAx3muW3Q8ZHs/WT59C6YVoftH7kX4?=
 =?us-ascii?Q?3UdK3Onzznh0FJHslNMTxXMJSbmdR8jVnYm5CsNuNToMf3b9bsfLgwIoGXuX?=
 =?us-ascii?Q?DkMi3qP9Lax4/3nW7TmSM6hbeEDjCAsyhILwPM9euWX18g9YPer3sF8gcJKd?=
 =?us-ascii?Q?bpZtlh8QoCvUt4GuZDPtKRsEc/bs3m2qXIECMFYB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9737334-7512-4aed-a4ea-08de24b3b35f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 01:58:56.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9WYYYEG6GwxF/5TRQ96uaj0hLs48WrRVK3nGCPjkY7W32BLs77zAPbLrt/vGPLEGCn8gdqeYk6hjCffmN9tlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8469

This series add ENETC, EMDIO and PTP Timer support for the i.MX943-EVK
board.

Wei Fang (2):
  arm64: dts: imx94: add basic NETC related nodes
  arm64: dts: imx943-evk: add ENETC, EMDIO and PTP Timer support

 arch/arm64/boot/dts/freescale/imx94.dtsi     | 138 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx943-evk.dts | 100 ++++++++++++++
 2 files changed, 238 insertions(+)

-- 
2.34.1


