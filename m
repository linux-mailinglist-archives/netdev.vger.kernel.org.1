Return-Path: <netdev+bounces-217179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A15B37AFF
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6D23BDAE5
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9331986E;
	Wed, 27 Aug 2025 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gBukP8n4"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DA431985C;
	Wed, 27 Aug 2025 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277739; cv=fail; b=QxkzbYh98Hn90Tj2zaRVWR3C+yPGeVBaESxoFtwknjVk400MutbuALcPO47zxh0VXq2CldLuYm2XimujkTGQXpkCJj9qbYBzVVEN2cNi4ZCEk3TR0CoUMtW0lnfbZCTIQbBKgqZNVmvIPsUtHGtAEWvXTbuaP6Hgfm0tHByqoWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277739; c=relaxed/simple;
	bh=9u0yytS572U1uzc0taAN0Tt+OxB0SufRr1CkO3oSrRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZedr/nYJoo/RIZv8TdUTWuo1O71NYdDvQmZtBVkUS9UiF/Ue7pFlHbbw5zSxR/3HL5Qkft9PwUfC3VarE0J9vi52QzbYXQjm9XDXYyXrWpF3WMa1nrarrs5T1Xj1wFYP696uCgWKGOInW/YmjAtWYW2+VyweJe5vAHPg8dEQfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gBukP8n4; arc=fail smtp.client-ip=52.101.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tn+dLkzoor0tG2Ch12X6lUCpmjFcaoDYSzh+TTadCYqeUboXff+GshEFJm34kOwcNCvQUjqNumWBXWTG1KVJNL8byBH6ZPIQXvVq/AzkqQSKj6xQFHZF5KpwvbN/ffVeWDmIR9Blx/dqSexG2Ki5yqAaMeeXe96i1Ywrh+4ogJdsJwPCpHy5QPX3KwNqt1zBp5hVEiKVmcRa5ToigvKZ3slcJ2TDsIlpPEgV99hEMtwLiP+JucahCk9Gwp4GGO4B+kOcdwYpSIdE0sxYY/YA2M7PYhLYwCoWmIPjGv7VrhGCxetDvPnW6i7CVPul0TqQRk3BMjpwqniw5PJk8fjVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnogvHmIsSga4MddG/YNWarykOKLv3jxCEVn0Bho6VE=;
 b=xT/HhDP7oRYwGXr6Is2cqq7xXigKH14IDgS/HstvtGnfV6KMkynoaaXxhKYd7LxcFwjX3dEzXkGnaZnc5M1y+9MuMCkSXwYA4Po2jZe4cSAVuHc7V9lvOjlHOQMUMH+lEXqIPRbHYMKSPHX1+/atRFchGDnqHnZjhpX35jlWnfXgEIC4Yds5oknc0SaXYDUe4bVD9/gDkF5bru3JJMYHqWZ6Z7Fga1wOKD4U+uslUPiIhU+ouJZELXo0r9hW6fU3QAx+D1YG+UDm8hwjzFEzZ2HvrjAW9/7GHgRR+OorxW82lIr3SwJ9j5xxLdy63qi3WhK7S/vNjm3s1KFkxm7w7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnogvHmIsSga4MddG/YNWarykOKLv3jxCEVn0Bho6VE=;
 b=gBukP8n4bgcTdkZQ6RUncABVRNJ0+ziF4a0A8wUTW1hzn2zf+AjY1AoH4RVmObtyKr8wtFhVlj4e9Owy+/qRrr6E6uUf0073KBa5y0XTXFTClJwYQS0HvMngLJZXnq8bTCfO+tbUGpzSHZG9U/QyUFKBl3h+gRXKLjsOjKGLruwkpQBMXo3jBgXrfanTfG7aQYcaxOrPUJnnDU0O1IdhgjgSvWewTJvJZzMOOMerifLrM6HTWLv01Nqo7r0RvC9OuYZWoGSiS2ByChFfKGJBT5cGuYsYVxCA7cGc8QJLcQSoqcUgNfnKWy0mIWD8bQd1wfZSHJjFtcDf2ULoDhIMYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:55:33 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:55:33 +0000
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
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 07/17] ptp: netc: add periodic pulse output support
Date: Wed, 27 Aug 2025 14:33:22 +0800
Message-Id: <20250827063332.1217664-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: 707036ca-9785-40ba-986f-08dde536b7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4uX2oenPzLoRD25m4bUwKHNPbkyYEqbU+3+3op4GOb5KL3dRHS00orUV02J0?=
 =?us-ascii?Q?OzihC8U2qJV6/VuNjaq6b1sC8PUIeBFcsTKT06nnGb2QDACx+pju2SZGPC01?=
 =?us-ascii?Q?m6soWHvb//ZJNENhTj95paeDCHFOdfNzFpiNxE9OnPQLbWn/X2pASGqpu/7Z?=
 =?us-ascii?Q?REfv8aes+ElU2jcTjUsnyd2yat1o7HZSCxWqaiM2VclUur/tkf8rThVIzcs9?=
 =?us-ascii?Q?jrWBxvHTO9gO30Naq1QRIGzI/WllzAtUqophM9hx2IWq0np8SrSQuEMKKbtE?=
 =?us-ascii?Q?AfIaZUd4P9cAaGgrMEIF2UgIoHUGodQcZCdxdT+VqKJXmEyHwUoW0jZ4ToCG?=
 =?us-ascii?Q?LGgS0mMFG6s9NabC4j5c69CSJ+f1sttAgX+ju/8SwNKbkXxjXBg33S3VeJ/W?=
 =?us-ascii?Q?OzBd68E5s5C3xf0PyFcxCUl23NEfbCF88hyTS2cQH+Cp5iVCHrniZwnDUT91?=
 =?us-ascii?Q?OXb8FhwN4yJy+XsfOpjECspFYtNVcoqIx+xbUQA0OepuyFXEish6MMDmIK6Y?=
 =?us-ascii?Q?+UbHDXF8wUBXHTRrhsKahDnt0EdZN/peIi5DnWZDgIQdPgoBR2JfGXH5ttbs?=
 =?us-ascii?Q?TCNkrU4cvhSZT/GSzy8APIg36hCzVtEnLNkrF0oRjlehwI5LHnPakdths7Sy?=
 =?us-ascii?Q?RH1mbkLjlK1kMawwHB3E9qmDjQzjx8KGEFOnw0fSdQfVKeX3z+IaNJ088Fyj?=
 =?us-ascii?Q?2PX+gLcspGNK5zvzZ0IIJOFQrFpmRMmizNiwFvXgtVO0KB1n9oJbZg+4IjXr?=
 =?us-ascii?Q?A4fRnU6zf0R+O31epbv+JlL8nKKTI0E26ha0sIAN8gkQ3g7vxe9RRQjbGfOX?=
 =?us-ascii?Q?goJ+NltRgeIDVkUBJaAvsbzcnyL9asFbsXiz2JPU7ofTFMIEBHnY6znRuim/?=
 =?us-ascii?Q?oXp7YJV6l9AJq/h2+Iln5vVCXqvzxadEJHS411mMOxMKLS6LHpO9rLBpguM4?=
 =?us-ascii?Q?yL+p+rYEEV2N6eMZIR6EHZNEKejBQtLsqxqpzyNWe8bK/xHCSZsuwcC7Y2UE?=
 =?us-ascii?Q?RU/l1bdFhefBKaF/2S/oelJ+kCGKvaitk+sDPu/26uzhFSv7apTiA/c4NrjZ?=
 =?us-ascii?Q?XQFdz6ggncOzPliAYKsCqHu1QiTIzAfiZ3Tpm4obGX/wLnoLRmG/vT2jO0hL?=
 =?us-ascii?Q?9EU5EDTkhJrWwB48Q8HswrpLN+ZTblgU/TW+e3Ws48FeI3WUTIjCQ60fVoL+?=
 =?us-ascii?Q?k0tlUOkEMVnEVHq3fJpCBZJS7t+9fB0Xb1M1AeDRMST9pLJKt2rBfgYRByvY?=
 =?us-ascii?Q?BOhyhjRfUVtwfcCvsIKMJBKMtAUbabnm3YYKNwDNTLvCr+kZUvuplkn0ncTt?=
 =?us-ascii?Q?aYlSPtqSDTf+My+6EHNVj26nvf2FQT0uF34t87OdB2TKraXM9nNu3rMe1d+0?=
 =?us-ascii?Q?AuIEDnQ6NJ4X+sV/x3KrEpK9RWXXSXLP4zX6JjHcsUcIBZ5D2evrvbxqDNx+?=
 =?us-ascii?Q?NtQr4PN4LkaX3DGbqwgHB6icq/V3dVSfGHegn1JEyuqPWgPWNjXJUdEDqBu0?=
 =?us-ascii?Q?U5AkNBM8UswzF+U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xf8meMgLB+6aUlai6LfbiDtiFcHtHUIsNYGtVqod3WApHdJ4O1TYso04GcJa?=
 =?us-ascii?Q?g9UCKZRl+/harXwCMmAkw/3jSbrZaVCSO/CKTlqsUTPLGKuIlJDQyIzk2Sk6?=
 =?us-ascii?Q?70A5/ug8Rf+JuZJUESgAyKTvDKZRPS+FtAMQpSubfbcEGmGiFtkzLYkEW4UJ?=
 =?us-ascii?Q?JYlN8+grShkEhGXY0NY6nlna+Fn7a1UYgGETHWgMlCAfeGQCp+wKjwYOceu4?=
 =?us-ascii?Q?VDH98tV/t0RPb28TEg8cxz9m4AVnvwYodl79HNhbGJbYUrk0d+Q4q0FSZRn+?=
 =?us-ascii?Q?ONw80GlqtDMv1bSD6qvmH6BBGufDUBNjgDgCNg1uVJuuX2gemiwEbV3h5EQ2?=
 =?us-ascii?Q?ycWRgN1dNRXg1ZbQ6/KHrOsbyXP/i6T27v5hCib21WY7AvAPhQRC8IV0Dz0/?=
 =?us-ascii?Q?2x9at4KJldNIqsSEYvahy1XsV+jwW8ViajqAJy3PbprplDJUlHbXJr0wWXTS?=
 =?us-ascii?Q?/qZxZSVKLrwK5pGtZRUoQW1+5bCavG7rD37ybRCWvB1Fvfj30NWPG39ZnuWy?=
 =?us-ascii?Q?zWWHsuM99T3K7u94i714aMJ1EuDl97fYeVDwMILvO9yOhiaj6CoiCbyWZdhk?=
 =?us-ascii?Q?QOWCy1uEIomz46+GQ7laINloCp2WG+y+P4NhSHS6CEHVy57hNfOrDNn9nR8n?=
 =?us-ascii?Q?0emjFIwgtblbRH8yPzUu1PRLWO8YRd53C8nq2UShbAFZx4l6QyQFBpyS3xeJ?=
 =?us-ascii?Q?3RapdtrXvFzHf2jXi8C3xWvv20iUvBjnt4yvOEUuv65EI+KzWZUuyeWXIF4P?=
 =?us-ascii?Q?yHJqxVh4P8pNg1wJj8Y4i6jyNbq4NsaVpE4foKhLNuqCTICYXwQClVLPDICw?=
 =?us-ascii?Q?1yps0zWKLHFOwK4LDkOLBJgTeCU5KvCdcqRR6/hd1DT95QYzddyCJ8piAHW4?=
 =?us-ascii?Q?qbU5gRX78hjGyc3uywgzhT+AFaQsaBwHpMiC5e4s6BvVUb5BUf/rz6UqL0ri?=
 =?us-ascii?Q?CzJHrrEI13Ky7u9kOKYIHgXpdUQdeSJz6eqh45LucH4Az5a4ueWPR0jcYfo7?=
 =?us-ascii?Q?vb6fB4qY5n3ob3FPim7fVAwK7KvLqS0CEhlb2XzWGvmopmOUDMoFFBZfdZ4s?=
 =?us-ascii?Q?FWI6eR5o0DJO3crt0XpaYsoyzUgf9urBLp2R95IiSQ+Ljibk6+xFpL2RCC/m?=
 =?us-ascii?Q?U4QtIJsRWMO/FaUTID9aXtUJhtYuWWhQewesnUR+8WpeuIv6AoMakmt6ffDe?=
 =?us-ascii?Q?2et1MSLOocpT/wQUxUbHUA5zs9bgEX/i3ysKA9r7PB3rAj+e3IUG70yfedbQ?=
 =?us-ascii?Q?57t0fwfpzhy89Sg+poxsGaHGKSTVT0LdGrh/mc4LN+ofYqP2m2hfJWvAc2Be?=
 =?us-ascii?Q?8FNDETS6Ubb2KJxvUx14MmoFy1F+VOpnRSNHgRBnKxuoZQ470jvJzeKbEpuP?=
 =?us-ascii?Q?2877iOWL9QjMcldveZIfVsMQVPyxx9Y+NfMwgQo+tJwiosSCg3SH7w46N5Ck?=
 =?us-ascii?Q?O9BqgrAO3aL1en2tqm9grEUjs+P5RihTYYNuNoTTy9MgxSPpdMWow8BFnfeH?=
 =?us-ascii?Q?lqF+4hAIIfcE/ICffC30nXLE+KxOMSbiSj7zgLyTxWdE8VzVKqjGsaae5cVD?=
 =?us-ascii?Q?Z40F3Rj0PEEFJofy2LI6U993M8f3XslZdsUuowiQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707036ca-9785-40ba-986f-08dde536b7da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:55:33.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zDH7pEutzASdgEkNd5mYF/0dqXCI1/S4V9LPnhGbRfQz4LmC6DZDNpMSJKchMzk5tbBPJrLULoIXhPX8+OqlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

NETC Timer has three pulse channels, all of which support periodic pulse
output. Bind the channel to a ALARM register and then sets a future time
into the ALARM register. When the current time is greater than the ALARM
value, the FIPER register will be triggered to count down, and when the
count reaches 0, the pulse will be triggered. The PPS signal is also
implemented in this way.

i.MX95 only has ALARM1 can be used as an indication to the FIPER start
down counting, but i.MX943 has ALARM1 and ALARM2 can be used. Therefore,
only one channel can work for i.MX95, two channels for i.MX943 as most.

In addition, change the PPS channel to be dynamically selected from fixed
number (0) because add PTP_CLK_REQ_PEROUT support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v4:
1. Simplify the commit message
2. Fix dereference unassigned pointer "pp" in netc_timer_enable_pps().
v3 changes:
1. Improve the commit message
2. Add revision to struct netc_timer
3. Use priv->tmr_emask to instead of reading TMR_EMASK register
4. Add pps_channel to struct netc_timer and NETC_TMR_INVALID_CHANNEL
5. Add some helper functions: netc_timer_enable/disable_periodic_pulse(),
   and netc_timer_select_pps_channel()
6. Dynamically select PPS channel instead of fixed to channel 0.
v2: no changes
---
 drivers/ptp/ptp_netc.c | 356 +++++++++++++++++++++++++++++++++++------
 1 file changed, 306 insertions(+), 50 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 2107fa8ee32c..8f3efdf6f2bb 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -53,12 +53,18 @@
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
 #define NETC_TMR_REGS_BAR		0
+#define NETC_GLOBAL_OFFSET		0x10000
+#define NETC_GLOBAL_IPBRR0		0xbf8
+#define  IPBRR0_IP_REV			GENMASK(15, 0)
+#define NETC_REV_4_1			0x0401
 
 #define NETC_TMR_FIPER_NUM		3
+#define NETC_TMR_INVALID_CHANNEL	NETC_TMR_FIPER_NUM
 #define NETC_TMR_DEFAULT_PRSC		2
 #define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
+#define NETC_TMR_ALARM_NUM		2
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -67,6 +73,19 @@
 
 #define NETC_TMR_SYSCLK_333M		333333333U
 
+enum netc_pp_type {
+	NETC_PP_PPS = 1,
+	NETC_PP_PEROUT,
+};
+
+struct netc_pp {
+	enum netc_pp_type type;
+	bool enabled;
+	int alarm_id;
+	u32 period; /* pulse period, ns */
+	u64 stime; /* start time, ns */
+};
+
 struct netc_timer {
 	void __iomem *base;
 	struct pci_dev *pdev;
@@ -82,8 +101,12 @@ struct netc_timer {
 
 	int irq;
 	char irq_name[24];
+	int revision;
 	u32 tmr_emask;
-	bool pps_enabled;
+	u8 pps_channel;
+	u8 fs_alarm_num;
+	u8 fs_alarm_bitmap;
+	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -193,6 +216,7 @@ static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
 static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 				     u32 integral_period)
 {
+	struct netc_pp *pp = &priv->pp[channel];
 	u64 alarm;
 
 	/* Get the alarm value */
@@ -200,7 +224,116 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 	alarm = roundup_u64(alarm, NSEC_PER_SEC);
 	alarm = roundup_u64(alarm, integral_period);
 
-	netc_timer_alarm_write(priv, alarm, 0);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static void netc_timer_set_perout_alarm(struct netc_timer *priv, int channel,
+					u32 integral_period)
+{
+	u64 cur_time = netc_timer_cur_time_read(priv);
+	struct netc_pp *pp = &priv->pp[channel];
+	u64 alarm, delta, min_time;
+	u32 period = pp->period;
+	u64 stime = pp->stime;
+
+	min_time = cur_time + NSEC_PER_MSEC + period;
+	if (stime < min_time) {
+		delta = min_time - stime;
+		stime += roundup_u64(delta, period);
+	}
+
+	alarm = roundup_u64(stime - period, integral_period);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static int netc_timer_get_alarm_id(struct netc_timer *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->fs_alarm_num; i++) {
+		if (!(priv->fs_alarm_bitmap & BIT(i))) {
+			priv->fs_alarm_bitmap |= BIT(i);
+			break;
+		}
+	}
+
+	return i;
+}
+
+static u64 netc_timer_get_gclk_period(struct netc_timer *priv)
+{
+	/* TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz.
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq.
+	 * TMR_GCLK_period = (NSEC_PER_SEC * oclk_prsc) / clk_freq
+	 */
+
+	return div_u64(mul_u32_u32(NSEC_PER_SEC, priv->oclk_prsc),
+		       priv->clk_freq);
+}
+
+static void netc_timer_enable_periodic_pulse(struct netc_timer *priv,
+					     u8 channel)
+{
+	u32 fiper_pw, fiper, fiper_ctrl, integral_period;
+	struct netc_pp *pp = &priv->pp[channel];
+	int alarm_id = pp->alarm_id;
+
+	integral_period = netc_timer_get_integral_period(priv);
+	/* Set to desired FIPER interval in ns - TCLK_PERIOD */
+	fiper = pp->period - integral_period;
+	fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
+			FIPER_CTRL_FS_ALARM(channel));
+	fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
+	fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
+
+	priv->tmr_emask |= TMR_TEVNET_PPEN(channel) |
+			   TMR_TEVENT_ALMEN(alarm_id);
+
+	if (pp->type == NETC_PP_PPS)
+		netc_timer_set_pps_alarm(priv, channel, integral_period);
+	else
+		netc_timer_set_perout_alarm(priv, channel, integral_period);
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_disable_periodic_pulse(struct netc_timer *priv,
+					      u8 channel)
+{
+	struct netc_pp *pp = &priv->pp[channel];
+	int alarm_id = pp->alarm_id;
+	u32 fiper_ctrl;
+
+	if (!pp->enabled)
+		return;
+
+	priv->tmr_emask &= ~(TMR_TEVNET_PPEN(channel) |
+			     TMR_TEVENT_ALMEN(alarm_id));
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl |= FIPER_CTRL_DIS(channel);
+
+	netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, alarm_id);
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), NETC_TMR_DEFAULT_FIPER);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static u8 netc_timer_select_pps_channel(struct netc_timer *priv)
+{
+	int i;
+
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		if (!priv->pp[i].enabled)
+			return i;
+	}
+
+	return NETC_TMR_INVALID_CHANNEL;
 }
 
 /* Note that users should not use this API to output PPS signal on
@@ -211,77 +344,178 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 static int netc_timer_enable_pps(struct netc_timer *priv,
 				 struct ptp_clock_request *rq, int on)
 {
-	u32 fiper, fiper_ctrl;
+	struct device *dev = &priv->pdev->dev;
 	unsigned long flags;
+	struct netc_pp *pp;
+	int err = 0;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-
 	if (on) {
-		u32 integral_period, fiper_pw;
+		int alarm_id;
+		u8 channel;
+
+		if (priv->pps_channel < NETC_TMR_FIPER_NUM) {
+			channel = priv->pps_channel;
+		} else {
+			channel = netc_timer_select_pps_channel(priv);
+			if (channel == NETC_TMR_INVALID_CHANNEL) {
+				dev_err(dev, "No available FIPERs\n");
+				err = -EBUSY;
+				goto unlock_spinlock;
+			}
+		}
 
-		if (priv->pps_enabled)
+		pp = &priv->pp[channel];
+		if (pp->enabled)
 			goto unlock_spinlock;
 
-		integral_period = netc_timer_get_integral_period(priv);
-		fiper = NSEC_PER_SEC - integral_period;
-		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
-		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
-				FIPER_CTRL_FS_ALARM(0));
-		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
-		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
-		priv->pps_enabled = true;
-		netc_timer_set_pps_alarm(priv, 0, integral_period);
+		alarm_id = netc_timer_get_alarm_id(priv);
+		if (alarm_id == priv->fs_alarm_num) {
+			dev_err(dev, "No available ALARMs\n");
+			err = -EBUSY;
+			goto unlock_spinlock;
+		}
+
+		pp->enabled = true;
+		pp->type = NETC_PP_PPS;
+		pp->alarm_id = alarm_id;
+		pp->period = NSEC_PER_SEC;
+		priv->pps_channel = channel;
+
+		netc_timer_enable_periodic_pulse(priv, channel);
 	} else {
-		if (!priv->pps_enabled)
+		/* pps_channel is invalid if PPS is not enabled, so no
+		 * processing is needed.
+		 */
+		if (priv->pps_channel >= NETC_TMR_FIPER_NUM)
 			goto unlock_spinlock;
 
-		fiper = NETC_TMR_DEFAULT_FIPER;
-		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
-				     TMR_TEVENT_ALMEN(0));
-		fiper_ctrl |= FIPER_CTRL_DIS(0);
-		priv->pps_enabled = false;
-		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+		netc_timer_disable_periodic_pulse(priv, priv->pps_channel);
+		pp = &priv->pp[priv->pps_channel];
+		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
+		memset(pp, 0, sizeof(*pp));
+		priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
 	}
 
-	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
-	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return err;
+}
+
+static int net_timer_enable_perout(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
+{
+	struct device *dev = &priv->pdev->dev;
+	u32 channel = rq->perout.index;
+	unsigned long flags;
+	struct netc_pp *pp;
+	int err = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	pp = &priv->pp[channel];
+	if (pp->type == NETC_PP_PPS) {
+		dev_err(dev, "FIPER%u is being used for PPS\n", channel);
+		err = -EBUSY;
+		goto unlock_spinlock;
+	}
+
+	if (on) {
+		u64 period_ns, gclk_period, max_period, min_period;
+		struct timespec64 period, stime;
+		u32 integral_period;
+		int alarm_id;
+
+		period.tv_sec = rq->perout.period.sec;
+		period.tv_nsec = rq->perout.period.nsec;
+		period_ns = timespec64_to_ns(&period);
+
+		integral_period = netc_timer_get_integral_period(priv);
+		max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
+		gclk_period = netc_timer_get_gclk_period(priv);
+		min_period = gclk_period * 4 + integral_period;
+		if (period_ns > max_period || period_ns < min_period) {
+			dev_err(dev, "The period range is %llu ~ %llu\n",
+				min_period, max_period);
+			err = -EINVAL;
+			goto unlock_spinlock;
+		}
+
+		if (pp->enabled) {
+			alarm_id = pp->alarm_id;
+		} else {
+			alarm_id = netc_timer_get_alarm_id(priv);
+			if (alarm_id == priv->fs_alarm_num) {
+				dev_err(dev, "No available ALARMs\n");
+				err = -EBUSY;
+				goto unlock_spinlock;
+			}
+
+			pp->type = NETC_PP_PEROUT;
+			pp->enabled = true;
+			pp->alarm_id = alarm_id;
+		}
+
+		stime.tv_sec = rq->perout.start.sec;
+		stime.tv_nsec = rq->perout.start.nsec;
+		pp->stime = timespec64_to_ns(&stime);
+		pp->period = period_ns;
+
+		netc_timer_enable_periodic_pulse(priv, channel);
+	} else {
+		netc_timer_disable_periodic_pulse(priv, channel);
+		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
+		memset(pp, 0, sizeof(*pp));
+	}
 
 unlock_spinlock:
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	return 0;
+	return err;
 }
 
-static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
-	u32 fiper_ctrl;
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
 
-	if (!priv->pps_enabled)
-		return;
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		if (!priv->pp[i].enabled)
+			continue;
+
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), NETC_TMR_DEFAULT_FIPER);
+	}
 
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl |= FIPER_CTRL_DIS(0);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 }
 
-static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+static void netc_timer_enable_fiper(struct netc_timer *priv)
 {
-	u32 fiper_ctrl, integral_period, fiper;
+	u32 integral_period = netc_timer_get_integral_period(priv);
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
 
-	if (!priv->pps_enabled)
-		return;
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		struct netc_pp *pp = &priv->pp[i];
+		u32 fiper;
 
-	integral_period = netc_timer_get_integral_period(priv);
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
-	fiper = NSEC_PER_SEC - integral_period;
+		if (!pp->enabled)
+			continue;
+
+		fiper_ctrl &= ~FIPER_CTRL_DIS(i);
+
+		if (pp->type == NETC_PP_PPS)
+			netc_timer_set_pps_alarm(priv, i, integral_period);
+		else if (pp->type == NETC_PP_PEROUT)
+			netc_timer_set_perout_alarm(priv, i, integral_period);
+
+		fiper = pp->period - integral_period;
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), fiper);
+	}
 
-	netc_timer_set_pps_alarm(priv, 0, integral_period);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 }
 
@@ -293,6 +527,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 	switch (rq->type) {
 	case PTP_CLK_REQ_PPS:
 		return netc_timer_enable_pps(priv, rq, on);
+	case PTP_CLK_REQ_PEROUT:
+		return net_timer_enable_perout(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -311,9 +547,9 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
 	if (tmr_ctrl != old_tmr_ctrl) {
-		netc_timer_disable_pps_fiper(priv);
+		netc_timer_disable_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
-		netc_timer_enable_pps_fiper(priv);
+		netc_timer_enable_fiper(priv);
 	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
@@ -340,7 +576,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 
 	/* Adjusting TMROFF instead of TMR_CNT is that the timer
 	 * counter keeps increasing during reading and writing
@@ -350,7 +586,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	tmr_off += delta;
 	netc_timer_offset_write(priv, tmr_off);
 
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -387,10 +623,10 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -404,6 +640,7 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_pins		= 0,
 	.n_alarm	= 2,
 	.pps		= 1,
+	.n_per_out	= 3,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -561,6 +798,9 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 	if (tmr_event & TMR_TEVENT_ALMEN(0))
 		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
 
+	if (tmr_event & TMR_TEVENT_ALMEN(1))
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
+
 	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
 		event.type = PTP_CLOCK_PPS;
 		ptp_clock_event(priv->clock, &event);
@@ -604,6 +844,15 @@ static void netc_timer_free_msix_irq(struct netc_timer *priv)
 	pci_free_irq_vectors(pdev);
 }
 
+static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
+{
+	u32 val;
+
+	val = netc_timer_rd(priv, NETC_GLOBAL_OFFSET + NETC_GLOBAL_IPBRR0);
+
+	return val & IPBRR0_IP_REV;
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -616,12 +865,19 @@ static int netc_timer_probe(struct pci_dev *pdev,
 		return err;
 
 	priv = pci_get_drvdata(pdev);
+	priv->revision = netc_timer_get_global_ip_rev(priv);
+	if (priv->revision == NETC_REV_4_1)
+		priv->fs_alarm_num = 1;
+	else
+		priv->fs_alarm_num = NETC_TMR_ALARM_NUM;
+
 	err = netc_timer_parse_dt(priv);
 	if (err)
 		goto timer_pci_remove;
 
 	priv->caps = netc_timer_ptp_caps;
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
 	spin_lock_init(&priv->lock);
 	snprintf(priv->irq_name, sizeof(priv->irq_name), "ptp-netc %s",
 		 pci_name(pdev));
-- 
2.34.1


