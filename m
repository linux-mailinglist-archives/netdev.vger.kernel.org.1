Return-Path: <netdev+bounces-212990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B39B22BE4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34324503924
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC85302CB3;
	Tue, 12 Aug 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j0iiufO0"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011067.outbound.protection.outlook.com [40.107.130.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2953C2F5326;
	Tue, 12 Aug 2025 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013377; cv=fail; b=Vz9g6gmqOggvvdCgzrWTdN5sk4Y8/Jpwijuuq+T1Zf/TMwv59DEVP5iEc3v1ie3S8NbezckLyt5jNU2AOH/MfEy2SW+Kny7vogyTUgkWgw+N3ih3znO9T5SAmbGnnvvSpY0i+OGOnWMNu6x7cuJPG+Qdc9amZjzIZVNWIg82fyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013377; c=relaxed/simple;
	bh=IPY0AcUPplTpVUwIq28kY1tK0dxt/AYnRePRB7ePIa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YVWMKpcZRL5l/gafrBVoinpGt3fHUmMplirUCymCgtIAzjd7PV99piiEF1urRornBv7z/g20dGJCYrJlwhCr0Kg1+/5vdjGL2XEnB36l+RK0Aw0ov9USxbqaaGq8DQjIAa/IVMCYxPGDV1WfYHBlCAspMhkTS8I1SylVwr19M8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j0iiufO0; arc=fail smtp.client-ip=40.107.130.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2Rs6utd3foVzXSrTxLR0qs7Z4bAC7Rvj7RmOF/SybAymqNRcZ20AEEzIbtOh68KFGG8pHzz73nX+KSC7FFdst/X2T61K5D0Dh0KjQFDzMn/nz1u/q2iT1IfM2ukC7JLpJQH1svpaD2eKaxNTeAXB3SFgBz9zCcXipHGLoPnCQAl1lqjtDVZ0XUVraa9zbIdgPjFGUAKKHfZhsdxyYKrlYTOSPDiBDdGbg/tM0K8Qe9G5KXX4TWN7x5wH3e3EAR5Tnvhj6AfyO8wimKoEdB7Go026LWonF1AXu2acke/7aLSAVeQcSnrkOc6d0w9aqOqb/zOkIHOO0pUQWsvNPkpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T25k+OMVXC7fZaywpkH8n9y8bRR3MchcX9QgGRqlx9I=;
 b=OBNtHu+eI08O05CMSfPFdri0zQ2nUk30Ubsty4A/nRCgMaPi5/Ss21UOqI3Qf2Eqd2sjtbPcVXhONGauQ5mtera5U/KbuqMYck6u/B8bIzWlvh7kD8uldRmNHsNe7ZLiTqjuENhxTv8w8HCnVJHfOxHhB0UlCFqLLiQlEDtp3kubgp/di5C57sJLMu1X1zZxeM2IkK1IPdcf0rXs7y7JIkJMwxxhR2Cnzyn9LOhLDIezOIG+DwkkN3Rnwrdx7aHWCtiJgwD/nO8eUvIUSEFJ8bARuMKN1V3Wa+X4/qh3jYgeUWfuy7Bw/okuvBFwa8ggfM9bqjE9txmG54koaz3ufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T25k+OMVXC7fZaywpkH8n9y8bRR3MchcX9QgGRqlx9I=;
 b=j0iiufO01715ixdlKtzwWNuHsRiypbC0RXIu7KkICGLNz5K1qahaxtxZGKhw1ZsJC7U/fkL2BegDagqW0Rqw9v2UHQOfyepQbHpsqg4zbLL9VjDU/Ccu4AzRbMqh/c1U0lnYQ0DUKx0E7d9kzizTJ8h5Etn8X8ZuAiYsU21Ey0ZBvz2ieerwLlG+sseqoCv6Ugc4cjT+G6QeNX55YWqFW7VIGd4OcB6mqoN02VMZ/vZXtez8hjenj58sMoWIwEANbyTstxZHCBE6H3DqVhujX//asO+sHpr7jObRg8EDcfVkiSdIqc0rPCALuAGXEmz/3n939H7WArjy3G5s5N4rFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7281.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 15:42:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 15:42:50 +0000
Date: Tue, 12 Aug 2025 11:42:40 -0400
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
Subject: Re: [PATCH v3 net-next 08/15] ptp: netc: add debugfs support to loop
 back pulse signal
Message-ID: <aJtg8DSrCxpt6EFz@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-9-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-9-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e8847c-c0d6-433d-17c9-08ddd9b6e515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YfXCpC0eNKxrpjO2Hn+Nw2FUOEmOkMpM1CJ/uV1uhX+03D9ZvyNFi2zBNirn?=
 =?us-ascii?Q?jPOomdZnGLJrJZ9y2gt9rZNHZiPheF+i/aD8PveiAWAhTYKpbsrtYvf5o5Zi?=
 =?us-ascii?Q?rWE1oHua6DaKx9BcV3z8hDX90BnbSvBw+xFOqoajMRerZhlBWzFjJo0cBP+c?=
 =?us-ascii?Q?YdBgFK5odEgtTSxCbDQ2ddGNkB88C6ceP5q8ym0L6Bqd5/23Ki99UmzaSAlu?=
 =?us-ascii?Q?KiVEUaQkKprs9V9NhkEyJlBYisZ8iPawt7AcbSG/FalGwOVHoe6FaHiJLLXo?=
 =?us-ascii?Q?N6kMNpOGWUEXywI4T/cQrp4hvmXlNTS6B/YqR+EPHI/u8CMzTHxBOJXUyqgK?=
 =?us-ascii?Q?RsHG58RmnIpymkd+OOyjsIpPXvR1OjQXtpJiOs8hVeGhW0QGxwO3DTGUKVtK?=
 =?us-ascii?Q?FJ+J/u6DHFqSHIw1HGSQVv5kgjXfn+4LDgi/pE+q68Y9eGvMO7wMAot2TEd4?=
 =?us-ascii?Q?KuQcREvAwVZDp2TFRjDU5B1qv0ndrmv7i/bmCRrUPlVk/waGvEUJ38SLWBQg?=
 =?us-ascii?Q?myrY5jz0juTgICoM4asI/ZrI7Hs92ulo/qLO2sBhvqdThmMar0Bla2LlYyXa?=
 =?us-ascii?Q?jDK9mbq79701o2+D8sax7sO2KsUYocRo+VcgotBj9N1fgaM11YrWEo8XCWqA?=
 =?us-ascii?Q?rG64dyjRlQDhyAGvp1vqzlg/d4xFc6I/T980ALGczh6vJ1bilHT65Ft2/K1H?=
 =?us-ascii?Q?yN7aNcfXXBifW7KdLGd95lOKIF86Lg/M463zRIHVx4a1XF1nZoPL1potmHD7?=
 =?us-ascii?Q?w6OyXOcsZWtmNbfzC7TvOU57THjo8k12p1vfsJTwzfzDWArYh/j+FJjtaBdz?=
 =?us-ascii?Q?erFF+K0rCSFrVP2KLbUCcfHlVSXza68r4aETuW7Shtcda1m88L4rzmkIyWQD?=
 =?us-ascii?Q?51IRNEWPB7fY/AehyU2HiJkNeRw6ZemFxf1+3xUg3xiuKb7YNAILyhuPq06e?=
 =?us-ascii?Q?rRmHKHttcyc/BJyMKM27i2IIAfqr01O8V5FaJZY64OPKZ3ao9iXfUd72KYDI?=
 =?us-ascii?Q?ggmU7i/D5NmcjMjNoyl3JlLjQR7hzs1V1V0IlpZfsmOF4CfrvHWcaBoLFmGx?=
 =?us-ascii?Q?hskMBu5Gpq9KsI23lAbHE6e64VSMCrqdVnMmVRL4qyBBd9iz373T/Ero1wyB?=
 =?us-ascii?Q?bmxSHvhXqp342r9NHiUJX1i8jdU9ipi//o5njlnkfmJmFLXgoYNw0VUqabBO?=
 =?us-ascii?Q?Ni2i6kVuBf0RJpRC6D/QVyIg1zibWDDWu9p3AUpo0aJkbk88MrAkit5W0aCK?=
 =?us-ascii?Q?fGc8Wh2UijpsgJDpeD1s6aTHiULi/0UVnQ9LsR8LuqEXUqcqI96QxazoBDis?=
 =?us-ascii?Q?WhcZ7eTY6SvHQdw+Akht2v3UNJZT6v22I+Nr/SMVbWFZ3nXQi9bFqPFPVJ/d?=
 =?us-ascii?Q?1qGVq+XKMiUAAum50yVQyyU8xKk87D+nI/9pFuAejkarVBBG7xrc7CbcHamt?=
 =?us-ascii?Q?TfVkUmVJ7GTYHXEs8D/Nv3dWSnLzOKs1iP45fM9ZQrRgeYTIzxWA/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7mXMEAWeTmVlCjDkgnnSgHJd6/iF+isxrB2SMptDKTFDvhEnf3gtqUxELwPG?=
 =?us-ascii?Q?wTHGxTBK/P5Rf5Y7LIEgch4MCqwf/Qoy8huahZEbJszrsmdqoOD7mRAsZcXH?=
 =?us-ascii?Q?F3ndtofReimNTJMEY284lJdhCYGSMotdnt06r+7gjyl7ZPxt++2P68ZOVdGt?=
 =?us-ascii?Q?NViEZj25+ilRwMGy0qx2cwMNq+WXX/hbHdO/ncGAYk8pCzbOaGZdDKH01RRK?=
 =?us-ascii?Q?zcUvF/U32yDpo7EvpNwo+IKTQ4a8p9BBSjL9DWf1UkqPA1OC5+V7R6UAiADE?=
 =?us-ascii?Q?nuxDkDpzPnfgbmqYe99FPB0srKA3fFS4WY+aR16Yijm2NNgYOdKfP93ae5Z4?=
 =?us-ascii?Q?S4RSwQaUZj9/3uUWnrkjJBKr/XXoGanPNZFLY+6BvZXtQ4P82xOeppLWrI1i?=
 =?us-ascii?Q?fjyDhj4UbrdTaZHoMUE7wHHlgI4gfVeAZwdgZXk1W1tN3W5Yo8hsECPu/YGY?=
 =?us-ascii?Q?PotpRIPH/OO/Dth0eAvaqCB8mWl76owjGGKpUTohqGAbu/J6E7mPjqZIaJrM?=
 =?us-ascii?Q?j3UcuHdGEgOzNiedYWgO3aEQ8rya7i/vBDgxNmjmkHYCCIQl5zIMunVQwKi9?=
 =?us-ascii?Q?tCoE5YAeCnkd1g7i/E1qMuUr3rRCY2E8TeLGAYYv/1XhMbm7ERw7yRxMJMcP?=
 =?us-ascii?Q?tdwwNhtI7XOOfeRo6HDvtzUgg5cEl+1H6jjTcrLnIX0A/imEWxbpPj0keG2C?=
 =?us-ascii?Q?M3QnVd7UlBoNa1ZNVVmQEgIYxtflNEKYcrJQTojzl2E+Pcbgh2EhVTRkdUau?=
 =?us-ascii?Q?mrkrB7T7C93ycSflu/VAnVd//gbPTtAfYBGmEAwFyorrj0TxRXkHt42JJqeN?=
 =?us-ascii?Q?jXIXq4ZcwZl0kR61HOOiBpTCNZ2aiA9EiGeIH6INBKrFJRsb9xupSs1BVDTm?=
 =?us-ascii?Q?k3nOaashcoU4gKEHLs03d6bNaNga6BCWX/8LfpCrQDwI8kp1Bka0orBOFSuu?=
 =?us-ascii?Q?C5SuCsmJ3+heTff+ASrg8ThH6Q7hSZ7sbSrybLJBsCFrMUeH6vg+n9pCma5C?=
 =?us-ascii?Q?x5FgtIPi71MyVR+9vAD/aJeV89WxK4S8mt+GmlpuYpoG1kBkUCfwj3F7GbnL?=
 =?us-ascii?Q?C3+BZz3e+754bfiqNoufr6kAuyj5qU2lk3YJ0jv8w/D67fDM6yvkYlth391J?=
 =?us-ascii?Q?7l/q7t12nTeh60CWTGPRZbRk/f/nyryzEafhikwNRJ3bL0XYlHc3UyyPnf8o?=
 =?us-ascii?Q?ZArjObB3OEpXmLZ3zAmPVAlhgZ6TNvT6T5TW3HhB16gejLfX1UxHNkB+zvAJ?=
 =?us-ascii?Q?aIXnA5aCauC+wq9xnMjTr19Bmg3eYHJw1eFBcHBKPV/nTTfgs0bBsCcOhwwc?=
 =?us-ascii?Q?mst5o1ZaOBimwfkBD/vKJuDMi0UbbdoSh5cBaCXgpdJ7XA0hHFSxLHBY+nTc?=
 =?us-ascii?Q?Uy3snu4NgVFQgTEiE2YYsDnYWERYtWWfs3J4p+LiIJR4LA8IYbbUxqiOWxAd?=
 =?us-ascii?Q?73T6WQng1DC8qKxyFtP7QCg4drS2pnsO3rF0i0wx/kzGbgsUEZVjOYnALZof?=
 =?us-ascii?Q?NrkczMyqeYN8b7Xzd9JHsvwzYhTO8toK0MlRM21gHVZ9jWOVL5V6ucNNkhZB?=
 =?us-ascii?Q?2vhVfTVsEGyVrQeWh8RUX7UBpSOxrOhys17A+rSn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e8847c-c0d6-433d-17c9-08ddd9b6e515
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:42:50.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3XzKlQvuaKR8kFAm1lagJ4ZlbfBES2iKX8+pIZ5+OtP7lkTMMSIL3zcloRC3M6duZeJ1zdGpguU/lEcfpqLFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7281

On Tue, Aug 12, 2025 at 05:46:27PM +0800, Wei Fang wrote:
> The NETC Timer supports to loop back the output pulse signal of Fiper-n
> into Trigger-n input, so that we can leverage this feature to validate
> some other features without external hardware support. For example, we
> can use it to test external trigger stamp (EXTTS). And we can combine
> EXTTS with loopback mode to check whether the generation time of PPS is
> aligned with an integral second of PHC, or the periodic output signal
> (PTP_CLK_REQ_PEROUT) whether is generated at the specified time. So add
> the debugfs interfaces to enable the loopback mode of Fiper1 and Fiper2.

The NETC Timer supports to loop back the output pulse signal of Fiper-n
into Trigger-n input. Add debugfs interfaces to enable loopback for PTP
feature validation without external hardware support.

See below typical user case:

>
> An example to test the generation time of PPS event.

Test the generation time of PPS event:

>
> $ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
> $ echo 1 > /sys/class/ptp/ptp0/pps_enable
> $ testptp -d /dev/ptp0 -e 3
> external time stamp request okay
> event index 0 at 108.000000018
> event index 0 at 109.000000018
> event index 0 at 110.000000018
>
> An example to test the generation time of the periodic output signal.

Test generation time of the periodic output signal.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> $ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
> $ echo 0 260 0 1 500000000 > /sys/class/ptp/ptp0/period
> $ testptp -d /dev/ptp0 -e 3
> external time stamp request okay
> event index 0 at 260.000000016
> event index 0 at 261.500000015
> event index 0 at 263.000000016
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> 1. Remove the check of the return value of debugfs_create_dir()
> v3 changes:
> 1. Rename TMR_CTRL_PP1L and TMR_CTRL_PP2L to TMR_CTRL_PPL(i)
> 2. Remove switch statement from netc_timer_get_fiper_loopback() and
>    netc_timer_set_fiper_loopback()
> ---
>  drivers/ptp/ptp_netc.c | 94 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index 45d60ad46b68..d483fad51c66 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -6,6 +6,7 @@
>
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
> +#include <linux/debugfs.h>
>  #include <linux/fsl/netc_global.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -21,6 +22,7 @@
>  #define  TMR_ETEP(i)			BIT(8 + (i))
>  #define  TMR_COMP_MODE			BIT(15)
>  #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> +#define  TMR_CTRL_PPL(i)		BIT(27 - (i))
>  #define  TMR_CTRL_FS			BIT(28)
>
>  #define NETC_TMR_TEVENT			0x0084
> @@ -122,6 +124,7 @@ struct netc_timer {
>  	u8 fs_alarm_num;
>  	u8 fs_alarm_bitmap;
>  	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
> +	struct dentry *debugfs_root;
>  };
>
>  #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> @@ -953,6 +956,95 @@ static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
>  	return val & IPBRR0_IP_REV;
>  }
>
> +static int netc_timer_get_fiper_loopback(struct netc_timer *priv,
> +					 int fiper, u64 *val)
> +{
> +	unsigned long flags;
> +	u32 tmr_ctrl;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	*val = (tmr_ctrl & TMR_CTRL_PPL(fiper)) ? 1 : 0;
> +
> +	return 0;
> +}
> +
> +static int netc_timer_set_fiper_loopback(struct netc_timer *priv,
> +					 int fiper, bool en)
> +{
> +	unsigned long flags;
> +	u32 tmr_ctrl;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +	if (en)
> +		tmr_ctrl |= TMR_CTRL_PPL(fiper);
> +	else
> +		tmr_ctrl &= ~TMR_CTRL_PPL(fiper);
> +
> +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_get_fiper1_loopback(void *data, u64 *val)
> +{
> +	struct netc_timer *priv = data;
> +
> +	return netc_timer_get_fiper_loopback(priv, 0, val);
> +}
> +
> +static int netc_timer_set_fiper1_loopback(void *data, u64 val)
> +{
> +	struct netc_timer *priv = data;
> +
> +	return netc_timer_set_fiper_loopback(priv, 0, !!val);
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper1_fops, netc_timer_get_fiper1_loopback,
> +			 netc_timer_set_fiper1_loopback, "%llu\n");
> +
> +static int netc_timer_get_fiper2_loopback(void *data, u64 *val)
> +{
> +	struct netc_timer *priv = data;
> +
> +	return netc_timer_get_fiper_loopback(priv, 1, val);
> +}
> +
> +static int netc_timer_set_fiper2_loopback(void *data, u64 val)
> +{
> +	struct netc_timer *priv = data;
> +
> +	return netc_timer_set_fiper_loopback(priv, 1, !!val);
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper2_fops, netc_timer_get_fiper2_loopback,
> +			 netc_timer_set_fiper2_loopback, "%llu\n");
> +
> +static void netc_timer_create_debugfs(struct netc_timer *priv)
> +{
> +	char debugfs_name[24];
> +
> +	snprintf(debugfs_name, sizeof(debugfs_name), "netc_timer%d",
> +		 priv->phc_index);
> +	priv->debugfs_root = debugfs_create_dir(debugfs_name, NULL);
> +	debugfs_create_file("fiper1-loopback", 0600, priv->debugfs_root,
> +			    priv, &netc_timer_fiper1_fops);
> +	debugfs_create_file("fiper2-loopback", 0600, priv->debugfs_root,
> +			    priv, &netc_timer_fiper2_fops);
> +}
> +
> +static void netc_timer_remove_debugfs(struct netc_timer *priv)
> +{
> +	debugfs_remove(priv->debugfs_root);
> +	priv->debugfs_root = NULL;
> +}
> +
>  static int netc_timer_probe(struct pci_dev *pdev,
>  			    const struct pci_device_id *id)
>  {
> @@ -995,6 +1087,7 @@ static int netc_timer_probe(struct pci_dev *pdev,
>  	}
>
>  	priv->phc_index = ptp_clock_index(priv->clock);
> +	netc_timer_create_debugfs(priv);
>
>  	return 0;
>
> @@ -1010,6 +1103,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
>  {
>  	struct netc_timer *priv = pci_get_drvdata(pdev);
>
> +	netc_timer_remove_debugfs(priv);
>  	ptp_clock_unregister(priv->clock);
>  	netc_timer_free_msix_irq(priv);
>  	netc_timer_pci_remove(pdev);
> --
> 2.34.1
>

