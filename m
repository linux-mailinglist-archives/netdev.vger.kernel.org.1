Return-Path: <netdev+bounces-213006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE472B22CA8
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D604B4E3E31
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722F2F83D2;
	Tue, 12 Aug 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PCBqpIiF"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E32857EA;
	Tue, 12 Aug 2025 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014325; cv=fail; b=ZIF4K7o1/jpT54fMi8fCfBa9OaUGVr+gi3t8oOU+3VdE0ZaqOH7uE2kqPfuU84X7yfctAnlmo7T/Kp53aL3TdQYgNrLWEy71070VV5xIgqjRABldL/7oD4N873AK6DcISMtqqK/v8l1yscOneOLG76Gup4Xny1NDev/b8xKWhI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014325; c=relaxed/simple;
	bh=kKrBYq3SO2BQqSZ+4vWT1HRFfbO9zVpKC966MZaT7Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=axIbZ90fP5bLJuoE0Q0pfy/J+YibbbJGS/avt+IjQtmdE74PSCEAhwNzYBJMJCYn+/eksXMgxMyq0FwxdrvfgjaZjMrBWZrkOwBsJkVSYOaeze8H3kI/5TWi+5Ehkehx4830if5H1gZjISIH+J3dQhqYz+L3qeb/Ziu7+anPAJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PCBqpIiF; arc=fail smtp.client-ip=52.101.84.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXERmWH++M9/YU58YAd9tFv9tXUqgIYKPlmq1GSZy65MQBlYX2tzT+euIhcQ56p6A9GhMT6I0kFJNjJJDM1JOG7am/n3GYtqLeznUiLCtQS+2rU8j5i82oXVs8DMjo0k1vwtnS5LE757Ciz3svJSA9L5AdDIw8p3SrWLQ/cCRyc8gB6PkyGvO+/AQdcH3XVeQQCdwwTYnvxNizC4J8DxQmg403p6ku5lZNaE52cdAB8f+ZhinX4oo+XH6mUJd9eHTVU9ab0H2QZJtBWACStw0uDyO3a5eSBN/VsZ60xptkuTQMDs85G0mNvSul1zT/ZyohrAoCQx9hoyVLlP7U7bhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR0mC2NHCkYNceQmSckca8GsDDniEH4LLsqoneWL+sQ=;
 b=r335zH/2Z7hz9meiPcuPdjZNYb7NL7p2T14GgZhiqOsRRs+u97pV/Pr7dfy9acdeF37iYUGvsghlJ8PbjJRYpUqcZiLuiWiQ5aGA+G340Ao1Pw7BNGeA8u/a2jHRR7kFSbIc9hMJIBpWA3nv8K6dwLFKms73gDoMIL3HB2bwjrkuL1KzjJLcWzhDpQtL2PEN9CauN0ZNg4kHNQ2e2Emg6CEAjJGoWP79z9ppAleBnn2E7goxKkO9fppeM0xevQWV2hcoLh7FKYBeoGhoEOFHMfy1QJ79N6/hf5cpUpLJ5DbrvTOr264PiEtojcFuosQusVrIoUtlla5wrlYffJgwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR0mC2NHCkYNceQmSckca8GsDDniEH4LLsqoneWL+sQ=;
 b=PCBqpIiFkET4BRyyltPIPyX8h0amzf44zak8LQVqK2OIILqDgA79QUdIZgTW/BROUl+4thxBMe6+S9Dplvfq9ncZo3SJ2XlgBVQ+1jOnIvyjnauNiDNNccfUriQD/Z3tQgmGgKIlZXmrVCiACW+kZh3UtbutVb6x8L6IKtk99y6o3vRlRLxdWJfuU/VAZnPPeR4ALAms2D6GUrVyCnN0qx/EIrGS82/WbbP/5a7zKSayMt9miYafyRzWyt0FrcJcKGVLBgwhF2cA13VbrkXlNUf7FjF9a5mtBytfGJeUFE01RG4J/sJdTBZ5tRVETO0rU5rMqEvJkYUph/TxXbAtkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.11; Tue, 12 Aug
 2025 15:58:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 15:58:38 +0000
Date: Tue, 12 Aug 2025 11:58:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 13/15] net: enetc: add PTP synchronization
 support for ENETC v4
Message-ID: <aJtkpFbFTnmO1rbz@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-14-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-14-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 372e3f93-247f-4fcd-2461-08ddd9b91a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QVSt7Sp3lq5hAW3N2SkHZ4RHkN0SrpmAbm5hFaPht+xBmtTOvCywtSrR7Ck7?=
 =?us-ascii?Q?lzlJg5zK9rUdJfw16JyJCcZ6dRpYMVQBIP/77pouNj64QTx7CZoyd4iSjKnd?=
 =?us-ascii?Q?ME6XHTspHCllKGsICbgY5rXkC2GJSPs+M13Jfg+3R+cz7DFyAt20cYr9cjPv?=
 =?us-ascii?Q?UwiI95ZitFtXIP/BCxn3yLiOyxkgWNeDHUcMQ13rUWRKv7ElH3gQWybAt/Ln?=
 =?us-ascii?Q?8RRKGUcj+FT+BnaW+3332LG8K0YKSApXG1bxnTJ9/SjAC508Jal02JkwtFYj?=
 =?us-ascii?Q?+jCy5GfSB8xDfnVUkk/de352Y1o9xmPyJA7i+V7It3i2Ct5DmmzX7LIOgJ/c?=
 =?us-ascii?Q?LYERzEFKl6aQl1qVlcCO1GB3bltCU+da2OClm1u3vZ3vGL/yD3fdp94fvtOh?=
 =?us-ascii?Q?gpOpmz+ER42niKR8Ty0+/5qq3R9vb2iIOOgWwtOpAx7Lm0rtksPtKwJMv/Q2?=
 =?us-ascii?Q?2f2Ay8pW2dUXGBbeb8wRXpYZRFPeXae8fYyvhcWewyupVRNkzu0qB2URX5X3?=
 =?us-ascii?Q?vqTnUoYaJkPe23Pz7uoiNJNAWmjFiPqxMr62xyseZHNm74hidY3jDxXWsMI+?=
 =?us-ascii?Q?RuRMWupEGqCfHPDjTsVUEtJ6G1n0esVg55Qv+Z7W2pfkQ1uhiJguU8XoBuCG?=
 =?us-ascii?Q?RNFD0ZB0JdaedpaAUZAqxJOX65eROzbEGRaUG95CXpYd73UgKNNE+0mF7alE?=
 =?us-ascii?Q?YMzTIeG6fcBtDXolPb+u+13dIfhwa6cHHibdQWNaCbDsFkaH6sm549jK+vF4?=
 =?us-ascii?Q?g9mIOOPSBtOmnT17JW1maOLJbmRV8FLEEFcDBpSa0H5TLh8tgsf0xqEQItjs?=
 =?us-ascii?Q?ugZTqN6hAKyYtEYAG/rfStE7Wtyg75Wr2IbIReXH/cn7i+uGTEl50cNTPrDR?=
 =?us-ascii?Q?hvrx2qxg9MPxYlJ8Rz6/NFkGQjyjAgTmJCp95+ZULqKb0S1eOU7AaliFl0FI?=
 =?us-ascii?Q?KuXkD6XQfqW0jp+9tNCfUyPTmZiHvarYNntEhoQIrBj+Vvq9bYw26WmsuFFy?=
 =?us-ascii?Q?+UUmxN07jfby4fE004hUvSO7ZaftU4Tt5b5x/iIuP3xeRbWFjpwaPPaMLNE6?=
 =?us-ascii?Q?d1aKGWvLTQQK7gu7G1PY0bN85rlD15npg/iWZipKJsj+0iJPcqzee3sS/LoP?=
 =?us-ascii?Q?D3M+mE7ydgJSqQHHchphaDv6liWUPP5ht/rfOb6xd1GoLNhbBf7V1QZUho2X?=
 =?us-ascii?Q?iPbzzo+iXwqOpuOjhpvXe5d8SfvXKCNxVq8zpi75P1/pYZQsYorMlh2gMXWw?=
 =?us-ascii?Q?mboR/3Af+8azUfra4Lfubm7W1Hpnqg1AZmHhYFY0/1WPMbt41yatRJHwrCx3?=
 =?us-ascii?Q?vZaKK/Xg7QkQoZVZZKFyTegiO7w/9/5d0qSAXBTmdIsbiVBuSY5rasysiFaR?=
 =?us-ascii?Q?PG7KZESktTB9D/lpWNwKkBVSraSQaLFs0CylBzaqPub4MHuCRKrUrhoMHsDp?=
 =?us-ascii?Q?ZRBRGt0/Ef49tGRHdKDvGbb0U5sKMIQWNFbNBDkFvTThINSSTvvRug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNd5i7n5lAjypchAq+Bp4rh2fBVf4qU8LdAvB5ZOXxDtN6bXgTL8kpv4dSgM?=
 =?us-ascii?Q?NRv8sKnm0DHsgcQExuPD0celZnGtkEZkkgOwPnxiS+sETZo4dGe+S1tLStVW?=
 =?us-ascii?Q?voLzzQZAGEHOjpJWzCPSh3AasawPvYp0z5rPuZweWPEszQpeE7j2AHSI4TmM?=
 =?us-ascii?Q?Q9y1B+PMr61X+XotjQX3V1RzcsJ/lYZLBCwGhPBoS1Cet6QcAlwlOmDJuxJn?=
 =?us-ascii?Q?IbgQ47hS7cZS/jMtUpKY+wY+L60jSsxNSEGzebNwamR62g7IGp6m+jTwOwOS?=
 =?us-ascii?Q?dEP4yvG70MNYEA8mHS1TQuEa5ZisZJITwlOQwwkaUdBm24iyKYNLqRldaa+C?=
 =?us-ascii?Q?zkUtM8qPwiGJTFUuq/qyJVXFV1UMMYJGe4AVQsn+LOxjJj2tiMm/dQyrWFA2?=
 =?us-ascii?Q?fK78FQJka1QZlNqWV5CnlIHz7mDX/QcUxEuhIC3fEMZsnd3zVwDqEgin5ZnQ?=
 =?us-ascii?Q?DhKpTwyDJXB1XDmgr7IQy4c1l92fe2TnZcMOSPvBt750KGwnjnVSH9rtNiw1?=
 =?us-ascii?Q?+2FQTdsMG70k6LLYZeFKR+k1Op9kZnY/FJ0KYutweJXEW5wLvFcakvp8hDXO?=
 =?us-ascii?Q?57frPdkegh81Yur1zQupkO5+u0w/juUwn6ndCyg4jSkEUSXe48O8Gwqo3Yxw?=
 =?us-ascii?Q?HTeIpBeWn66Pyxg4tx74M0oUGouQCUs+kyoCaxhfQCMm9rP9P/Yri58zb9v2?=
 =?us-ascii?Q?E9LfZBkLHyUqzuD0f814RNGFFpj+Dl5A4HTiTJRMKSEKRZlhd3As+jPGMrBc?=
 =?us-ascii?Q?V2b178060ZoGIgVEYJmuy7hiOCDLQX7B8VpfT2ry8ADaX7TF9d9xSN1RtMlz?=
 =?us-ascii?Q?TqNNspwX56lbXZ8DBHJ9kt+LmRONZMGXQ9PvazsbpovlfJcTbq/AmZn3XJtE?=
 =?us-ascii?Q?huQ9nBZKoWuRQATHvqu3PbdcNmd75xbDK5g1L1jivDaE6Q/kY0JSDbBY6YW+?=
 =?us-ascii?Q?J/CbJyYF/2UmJrNwpAUuFXFn1WtPKpWv7ZyYS5sLaCuCfZaRLW7Qj1nxzH0M?=
 =?us-ascii?Q?pZYIZ5DA6UsLlc5FzS8gFRWhoTUHv4YE5gizHu3aVSHLOzK86LG8mEWtptPH?=
 =?us-ascii?Q?OPMCT0XkMdLvGJJZocck4lEx+1vsDB/aM/P2B+zTd91/tcZDrRe7K/junT7g?=
 =?us-ascii?Q?Dkw94oLvpzGCDqveLfgx02gbIiz4/7XyfkcI4NKP00ac9WNOES9JpEcIu4ZJ?=
 =?us-ascii?Q?NYfm7ZTCa9FfRd+g676xAgmae9N2w5MWj6vPAcM1CHWS6ZXZa4h4KbMS8oOT?=
 =?us-ascii?Q?BdYqIrWOIwy/dqwykqjGhn/G3t8kYz6TFhjHTo4LD0PpLOwqCBdsEBhc5L6P?=
 =?us-ascii?Q?q6sEpr+ID3zu7Wg73fBi4XA2qwkCUVxoZFSQnECCRF85Q74HKHqYMsDRIoLC?=
 =?us-ascii?Q?4GbURDodNBlV6flOz2abZO533vS9UV6QW4cvov7cYQyD0bb+90VR9n94pMO5?=
 =?us-ascii?Q?taqNhjEs8sSuHuk3XkajvGF1tM9JFUGwlePS/zmh5GDHhxWGN91O7JagxA/f?=
 =?us-ascii?Q?uljYXEGSXWDYPO2VOWwSFjXqnEfGi4SQA723/2Wr/ASo9LhAAKWWlzCwLJWY?=
 =?us-ascii?Q?mj0b4NyO0vMBy8D1QEov8+t5dk8cnzZf9MyTUHVt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372e3f93-247f-4fcd-2461-08ddd9b91a1f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:58:38.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/5NpzIAg2dOg//5SQH8tNzAnz5jjIMbZpw68tCC/nk37XDdEWicXPj/CcGh7SPni/P2/IH+9gmY+jvVdMlKkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113

On Tue, Aug 12, 2025 at 05:46:32PM +0800, Wei Fang wrote:
> Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
> mainly as follows.
>
> 1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
> different from LS1028A. Therefore, enetc_get_ts_info() has been modified
> appropriately to be compatible with ENETC v1 and v4.
>
> 2. The hardware of ENETC v4 does not support "dma-coherent", therefore,
> to support PTP one-step, the PTP sync packets must be modified before
> calling dma_map_single() to map the DMA cache of the packets. Otherwise,
> the modification is invalid, the originTimestamp and correction fields
> of the sent packets will still be the values before the modification.

In patch, I have not find dma_map_single(), is it in enetc_map_tx_buffs()?

This move should be fix, even dma-coherent, it also should be before
dma_map_single().  just hardware dma-coherent hidden the problem.

Frank
>
> 3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
> register offset, but also some register fields. Therefore, two helper
> functions are added, enetc_set_one_step_ts() for ENETC v1 and
> enetc4_set_one_step_ts() for ENETC v4.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2 changes:
> 1. Move the definition of enetc_ptp_clock_is_enabled() to resolve build
> errors.
> 2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
> Timer.
> v3 changes:
> 1. Change CONFIG_PTP_1588_CLOCK_NETC to CONFIG_PTP_NETC_V4_TIMER
> 2. Change "nxp,netc-timer" to "ptp-timer"
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 55 +++++++----
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  8 ++
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
>  .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
>  .../ethernet/freescale/enetc/enetc_ethtool.c  | 92 ++++++++++++++++---
>  5 files changed, 135 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 4325eb3d9481..6dbc9cc811a0 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
>  	}
>  }
>
> +static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
> +{
> +	u32 val = ENETC_PM0_SINGLE_STEP_EN;
> +
> +	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
> +	if (udp)
> +		val |= ENETC_PM0_SINGLE_STEP_CH;
> +
> +	/* The "Correction" field of a packet is updated based on the
> +	 * current time and the timestamp provided
> +	 */
> +	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);
> +}
> +
> +static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
> +{
> +	u32 val = PM_SINGLE_STEP_EN;
> +
> +	val |= PM_SINGLE_STEP_OFFSET_SET(offset);
> +	if (udp)
> +		val |= PM_SINGLE_STEP_CH;
> +
> +	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val);
> +}
> +
>  static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
>  				     struct sk_buff *skb)
>  {
> @@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
>  	u32 lo, hi, nsec;
>  	u8 *data;
>  	u64 sec;
> -	u32 val;
>
>  	lo = enetc_rd_hot(hw, ENETC_SICTR0);
>  	hi = enetc_rd_hot(hw, ENETC_SICTR1);
> @@ -279,12 +303,10 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
>  	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
>
>  	/* Configure single-step register */
> -	val = ENETC_PM0_SINGLE_STEP_EN;
> -	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> -	if (enetc_cb->udp)
> -		val |= ENETC_PM0_SINGLE_STEP_CH;
> -
> -	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> +	if (is_enetc_rev1(si))
> +		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
> +	else
> +		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
>
>  	return lo & ENETC_TXBD_TSTAMP;
>  }
> @@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	unsigned int f;
>  	dma_addr_t dma;
>  	u8 flags = 0;
> +	u32 tstamp;
>
>  	enetc_clear_tx_bd(&temp_bd);
>  	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> @@ -327,6 +350,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  		}
>  	}
>
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +		do_onestep_tstamp = true;
> +		tstamp = enetc_update_ptp_sync_msg(priv, skb);
> +	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
> +		do_twostep_tstamp = true;
> +	}
> +
>  	i = tx_ring->next_to_use;
>  	txbd = ENETC_TXBD(*tx_ring, i);
>  	prefetchw(txbd);
> @@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	count++;
>
>  	do_vlan = skb_vlan_tag_present(skb);
> -	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> -		do_onestep_tstamp = true;
> -	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
> -		do_twostep_tstamp = true;
> -
>  	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
>  	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
>  	tx_swbd->check_wb = tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
> @@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  		}
>
>  		if (do_onestep_tstamp) {
> -			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
> -
>  			/* Configure extension BD */
>  			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
>  			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
> @@ -3314,7 +3337,7 @@ int enetc_hwtstamp_set(struct net_device *ndev,
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  	int err, new_offloads = priv->active_offloads;
>
> -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> +	if (!enetc_ptp_clock_is_enabled(priv->si))
>  		return -EOPNOTSUPP;
>
>  	switch (config->tx_type) {
> @@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>
> -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> +	if (!enetc_ptp_clock_is_enabled(priv->si))
>  		return -EOPNOTSUPP;
>
>  	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index c65aa7b88122..815afdc2ec23 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct enetc_si *si, int size,
>  void enetc_reset_ptcmsdur(struct enetc_hw *hw);
>  void enetc_set_ptcmsdur(struct enetc_hw *hw, u32 *queue_max_sdu);
>
> +static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)
> +{
> +	if (is_enetc_rev1(si))
> +		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
> +
> +	return IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER);
> +}
> +
>  #ifdef CONFIG_FSL_ENETC_QOS
>  int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
>  int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> index aa25b445d301..a8113c9057eb 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> @@ -171,6 +171,12 @@
>  /* Port MAC 0/1 Pause Quanta Threshold Register */
>  #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
>
> +#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
> +#define  PM_SINGLE_STEP_CH		BIT(6)
> +#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
> +#define   PM_SINGLE_STEP_OFFSET_SET(o)  FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
> +#define  PM_SINGLE_STEP_EN		BIT(31)
> +
>  /* Port MAC 0 Interface Mode Control Register */
>  #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
>  #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index b3dc1afeefd1..107f59169e67 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops = {
>  	.ndo_set_features	= enetc4_pf_set_features,
>  	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
>  	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
> +	.ndo_eth_ioctl		= enetc_ioctl,
> +	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
> +	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
>  };
>
>  static struct phylink_pcs *
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> index 961e76cd8489..b6014b1069de 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> @@ -2,8 +2,11 @@
>  /* Copyright 2017-2019 NXP */
>
>  #include <linux/ethtool_netlink.h>
> +#include <linux/fsl/netc_global.h>
>  #include <linux/net_tstamp.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +
>  #include "enetc.h"
>
>  static const u32 enetc_si_regs[] = {
> @@ -877,23 +880,49 @@ static int enetc_set_coalesce(struct net_device *ndev,
>  	return 0;
>  }
>
> -static int enetc_get_ts_info(struct net_device *ndev,
> -			     struct kernel_ethtool_ts_info *info)
> +static struct pci_dev *enetc4_get_default_timer_pdev(struct enetc_si *si)
>  {
> -	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> -	int *phc_idx;
> -
> -	phc_idx = symbol_get(enetc_phc_index);
> -	if (phc_idx) {
> -		info->phc_index = *phc_idx;
> -		symbol_put(enetc_phc_index);
> +	struct pci_bus *bus = si->pdev->bus;
> +	int domain = pci_domain_nr(bus);
> +	int bus_num = bus->number;
> +	int devfn;
> +
> +	switch (si->revision) {
> +	case ENETC_REV_4_1:
> +		devfn = PCI_DEVFN(24, 0);
> +		break;
> +	default:
> +		return NULL;
>  	}
>
> -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
> -		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
> +	return pci_dev_get(pci_get_domain_bus_and_slot(domain, bus_num, devfn));
> +}
>
> -		return 0;
> -	}
> +static struct pci_dev *enetc4_get_timer_pdev(struct enetc_si *si)
> +{
> +	struct device_node *np = si->pdev->dev.of_node;
> +	struct fwnode_handle *timer_fwnode;
> +	struct device_node *timer_np;
> +
> +	if (!np)
> +		return enetc4_get_default_timer_pdev(si);
> +
> +	timer_np = of_parse_phandle(np, "ptp-timer", 0);
> +	if (!timer_np)
> +		return enetc4_get_default_timer_pdev(si);
> +
> +	timer_fwnode = of_fwnode_handle(timer_np);
> +	of_node_put(timer_np);
> +	if (!timer_fwnode)
> +		return NULL;
> +
> +	return pci_dev_get(to_pci_dev(timer_fwnode->dev));
> +}
> +
> +static void enetc_get_ts_generic_info(struct net_device *ndev,
> +				      struct kernel_ethtool_ts_info *info)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>
>  	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
>  				SOF_TIMESTAMPING_RX_HARDWARE |
> @@ -908,6 +937,42 @@ static int enetc_get_ts_info(struct net_device *ndev,
>
>  	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
>  			   (1 << HWTSTAMP_FILTER_ALL);
> +}
> +
> +static int enetc_get_ts_info(struct net_device *ndev,
> +			     struct kernel_ethtool_ts_info *info)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_si *si = priv->si;
> +	struct pci_dev *timer_pdev;
> +	int *phc_idx;
> +
> +	if (!enetc_ptp_clock_is_enabled(si))
> +		goto timestamp_tx_sw;
> +
> +	if (is_enetc_rev1(si)) {
> +		phc_idx = symbol_get(enetc_phc_index);
> +		if (phc_idx) {
> +			info->phc_index = *phc_idx;
> +			symbol_put(enetc_phc_index);
> +		}
> +	} else {
> +		timer_pdev = enetc4_get_timer_pdev(si);
> +		if (!timer_pdev)
> +			goto timestamp_tx_sw;
> +
> +		info->phc_index = netc_timer_get_phc_index(timer_pdev);
> +		pci_dev_put(timer_pdev);
> +		if (info->phc_index < 0)
> +			goto timestamp_tx_sw;
> +	}
> +
> +	enetc_get_ts_generic_info(ndev, info);
> +
> +	return 0;
> +
> +timestamp_tx_sw:
> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
>
>  	return 0;
>  }
> @@ -1296,6 +1361,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
>  	.get_rxfh = enetc_get_rxfh,
>  	.set_rxfh = enetc_set_rxfh,
>  	.get_rxfh_fields = enetc_get_rxfh_fields,
> +	.get_ts_info = enetc_get_ts_info,
>  };
>
>  void enetc_set_ethtool_ops(struct net_device *ndev)
> --
> 2.34.1
>

