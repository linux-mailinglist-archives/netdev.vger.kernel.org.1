Return-Path: <netdev+bounces-212975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F154DB22B59
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E523A86FC
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D892EF645;
	Tue, 12 Aug 2025 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a8U0uz5W"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4ACAD51;
	Tue, 12 Aug 2025 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010888; cv=fail; b=rDB/lFQPapPoRiPA9phj4qlY8R/amvcoEg8uR5Nw/q+9+hZ/XYSn41w7wW3EtzMC+8CP2gO2cA8c5ZYxHxVEruDgXVS2pHEPho//Kv3rh1OW0GgLWvvhJKdnzdIf4bMHSW8K8y+tGMWrlsTsNBwnbGcWt6dzN2MaEYx3Xou9q2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010888; c=relaxed/simple;
	bh=+8yifdsZJDgmcx7k7Hr71CnNx+x5KoltYzwhHV5qlUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YlXHxfnNpGC6DbA7LQnISKjsS6rGRGGzczlVzF8VR2J2f7JxIYt6BJFrDdZxuje/o8SJroGzFGyHPlUR3yadoYct4RVhggFW8eh8Mcl4AkXsGfUbWaXvUg5i+AUbudzfjbYevss1VgYou7LXeBraE5pwyWbG68miuZydh+0xuUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a8U0uz5W; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLAoms6rTE99lKW7TS9/n5+03PhgLVsBNV974PQEwgQu0V9W6e/AaYFSmNWOZQisGT/kEVRCqWNDIGWOZk0SxzbwHm/Ukfj2wCT5zQ5f8ixX8OsfUkD27FNtSfDVFO2fLKlZfi/nsZXFp0ps2Yjf/WzcPADAEPgFR+qG1xgajqfwq5oOFQup5hdoFkbKppzizFL3AiuGRjiiDyWU7HLn/nnWsdMRZ1ShRj+RfWXB1iiVjUMEmBCspReYxbX/EENINp/zf72a09haCL6HPH4SxzxWONkFyGnWMcIuZAxyKF8rYrspfYiUYsMFmDjesp56AABGfo8tvjCeR88uVPOlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOuagnQCALSKRfkytCheB1xdm9O0AlZ8AfefZFrlngY=;
 b=urOmbw7glbq6OuW8+qIzG0qPioOZHU9ZwJyqDMsYXDdvd/EpBOWOWtf8AQDzcRFQ7UY3SAX9xAWZmIsqZVaxCoGvvEtBo2vqMfhBf04zsPqQdEX3klPKDXz76Sqd365SYWmT9FVDRz1SGfzv4sjqlSDtEGaaFZZzwLQb51OuEmKKlaAbWH61kxkJrA/gZdYL9AKKHpnTPqaaqLvl0RE5PGWZOk77hluImSSgl86vqrzD4t1omOZwA9/sBh0a20bqrvjmNCJ3gApVhguy2yTBpQvFSXF/E2am7zCjQnvx6VbSofqxVvN74G/MYJxs/qtFrWGR9N2+AGcFKzYqAyMz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOuagnQCALSKRfkytCheB1xdm9O0AlZ8AfefZFrlngY=;
 b=a8U0uz5W6BmBWrh8dENqZ4WVhdf3HufpszglZRoTM8NqecFT5CjcOiZYPFDZ5lU4zj/3YtbAZhgvjhOyHv3uPbdGA4W9zpQGrQIvMbJLnRniBFnQakLdn1a9/CMswSRZlq8aByz4kyAe32AW+yw3k8y+BjFCpY8eSPJfna6e5yEW/iwpggBGAnYcY7td6BNx6pmr6wEBGmlp8zGJybJ/XNBSatNUnX2yQ5Ff1iXvxv2UNcjRs6Pgn3rm33yxW3PtUYPJCU0ToUMHDU1IlhZNoE1oKTrAuJxKttpbOfQfOP64C5qKB3ycLsFHqmGVEku0nyib8dR3cFu/eTfuMfc3ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10898.eurprd04.prod.outlook.com (2603:10a6:150:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 15:01:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 15:01:22 +0000
Date: Tue, 12 Aug 2025 11:01:10 -0400
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
Subject: Re: [PATCH v3 net-next 04/15] ptp: netc: add NETC V4 Timer PTP
 driver support
Message-ID: <aJtXNrndlngzeSm8@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-5-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR11CA0106.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10898:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ad03d5-6456-4e0f-94c0-08ddd9b119e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ecIYly1A+wl9rf3YkGQ7C9gujCoFuk/nGqZP4PRBXR2GiNlF15ZsmWE52lkW?=
 =?us-ascii?Q?fihUj41QHa88iFV4uj8FJkQaz+NHTCI2zpXLzesuYTG6tC/+Wh7YO5G7juhc?=
 =?us-ascii?Q?LNFSorfK5t27cYIKIQNQj4SHJfhio+lLRNpSD7ZOoRLn5N1rb6sXTD17ys6M?=
 =?us-ascii?Q?vhjCDNNz7zhi/dtKPaih6lqpsxCCP/m7v3wiVBox4ALidGlP5CvqQA7hsHhM?=
 =?us-ascii?Q?ah8zHkfSyxLRWsiRQjq0s2GBVrD8JlTcaqd39+32NhwSoxAa13xTxZblhc+E?=
 =?us-ascii?Q?fHAxhFGLfWZFRLlcoBA0EL539VrSBEkG40NBOu59fjHfZCeCa6IVOFH5uxHY?=
 =?us-ascii?Q?N9Z1B7RlgYj3swlufg5Toc2lcfbpVmY+TMZKsvRnbA9l5zQ/SvKmk5OVE5+o?=
 =?us-ascii?Q?6imqpPunGUG01b/x/eKWs6XsyQlZhrXT8arxNag+UzEKjj5MlNXhRLpRaKYw?=
 =?us-ascii?Q?Qk/b7TwQ4Q1dVGnuBWDFxr2qgGn7UNS0YoMdHYBSNX58ZeMSjlhRPI1I3jgn?=
 =?us-ascii?Q?UELEccCZMLHJKYwgrLoB5Cbk20fxY4D5Rj1WqucAkpqdRhR82Iiv+bftKYVS?=
 =?us-ascii?Q?TixNxgPYWFmmJ/ud+PufRYV7rnA27+eDM4UwGzVoU28jsNX1AYBVsCj4lIE3?=
 =?us-ascii?Q?syCzUOQBPaQOZMnXDhYyxUe6D0LWpeOyTCDR5U4c2P9uY/oaybMQxtsc26Zk?=
 =?us-ascii?Q?2/hUanFOddazxMHcG29LEQiapRZ+wNqwkUSKbAMVLjHZvNAwMjDA1mP0QIgy?=
 =?us-ascii?Q?W2TRHCbj0e/QpiEmyB+R6xXeIVEDv7iY7IS+xZWPmsGXDnbTfwcxW1A8nYMD?=
 =?us-ascii?Q?4aaDoNKeFdrqmyJHKBsJH9TojS1ZpbobvvLqlj41gFhk21KSD4JB3L7gRIvX?=
 =?us-ascii?Q?KcLo9G9FnAeDXHOGhisFEHV2Uw51mJ5reYiskW3VlUcpg35tWyraxd1B9XK9?=
 =?us-ascii?Q?ZsxqPdsIduLDE9KDjvTemnli4LyKkRUqm+TukD6IbNDgwgw1KJAOCsDpWC+O?=
 =?us-ascii?Q?NiRoPUnntWiqiDG7IKsl/mYkoNseXdoXCV9wn63hkthWBZ2Tb3bOp8DkKin8?=
 =?us-ascii?Q?gz1m6rnR7smKu9zT8T0WARbf1ZCKy2yrRUT4PxOcWjc6eAlm19K8aOOFM8R1?=
 =?us-ascii?Q?JmBOkfeUuxmtKGBUAM65CtnZNNQzQ4S9OffTTPvXrrJTqvrbeopawgt6EF5N?=
 =?us-ascii?Q?gtd5FcLwxJFRjytoLEdUB1DAc1HAHirmSu0urmFqBVFOymfnck05K36a1vxu?=
 =?us-ascii?Q?9ESlGU5AD3YVRJwbrfuYEzoi7l0yF+KpUuJMKW4B44QBVw4XcJKKVU/H8D5y?=
 =?us-ascii?Q?DdGgxT3TFf88iurLWxbQ3//W54q2GL8NhBLYXAY+t25rXR9UO1i25b0dXHgc?=
 =?us-ascii?Q?g4JZ9Bto9MJktnfipaPnYXSPsKTT/PnzIwXKe0CKU6xCflEofCJqN03yXDl3?=
 =?us-ascii?Q?Q+Y+ttmuIZ+fPMRQKpJH8nAMG8At6a37kgsdc5In6CSaJ6FtufBviA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9O1kzViwIxECkr+RGkTGs07R4oYreJwM91mzqfNHIx22DbIOQJklzdEuv7WT?=
 =?us-ascii?Q?/2TsmxVF+nj1In+ZNgwGR0NCdN/3BTFVLDwC1NDsCdrRaZbakZkv1dEnWPde?=
 =?us-ascii?Q?M1qgCEen0GhjaWfobB0FW67LRIpwDaoVTVCeiGHYKxhHlbzjDEoGhOYHAUG2?=
 =?us-ascii?Q?eSh4CtXaPnouRoZ95vxdtk9lRytx3KpJDJv6fGyBqU01pYaGO+qFQBPyArFC?=
 =?us-ascii?Q?SuARwCnx6eKxb6pzJuMHVt/fM8bnxvwlA/0ZKcMaC4ZLXV3ZeI4ZUQcu68os?=
 =?us-ascii?Q?2qOUt5L8T1DC2s2soeO1wEhNMLN8SmXlJ870quwm6u6jTGPuax8DvoV39Wvn?=
 =?us-ascii?Q?XE+uPyAoJyQt+yStqbupUrpVDAvoSFQwlZLU+T8mZfx7aLfDrosf8i23CaUS?=
 =?us-ascii?Q?KicWH33gyQMc1kMStQxgu4JoT14p+gLeDdvqllPVsWJxiYeN23I7iBJ8u91G?=
 =?us-ascii?Q?m31R1K29ILWPQFK3QZIG/tHTJ8+v6XOUf9h4yNnbJ/rCh5wkwo5PPZxtZ+ZN?=
 =?us-ascii?Q?qu6EODgJZbxr7gEZ+MfmFVllMHunlvKZb4h8OzAmYNgWLbHI2cnWI8ehrju+?=
 =?us-ascii?Q?X7ptMmW5nlIgKzE8tRaK3Lgi9Q+j3GUJmPLcND0DvloMie2C3G7sTKlc6CcC?=
 =?us-ascii?Q?1klzaUkdPgbEVdCDKFARIzR7DV7LrvV1WJMg6DjcKjWDm/lRejzQ/Rh4aLxt?=
 =?us-ascii?Q?HyaVYT88ZnzeCtHVLcqz0u+D5xTyrPPp7Lpao5IPCE0byONf4oniLZ6LMZYj?=
 =?us-ascii?Q?gDwQNUJRVjqQscMqTnGuLIDPQ1+qYFeKj8c+6Io9ApYVlg3vbkPI3Vov5nsm?=
 =?us-ascii?Q?UOSBw2C9VDDSjMMxruW2URZI9EcpVJqnbJ8LHHQlNIOc/mUERcYTCSPfMJuy?=
 =?us-ascii?Q?MIBBYH/fncIIv7aVyU+2DSHx31FxBjp0a46p2Rhw7TGfoe50szmj1Qw2RC3x?=
 =?us-ascii?Q?PsNuQW8CDbPfWRr3+WIxxQF8KOz4OvsIFdDtxDyUYUrj227VbfvOI6is7WgG?=
 =?us-ascii?Q?ALT1ao9JayVgGzJCbNByySZkuZcVdRUAxTBqjEnYy/ma4uogyGNKbQbPQvWx?=
 =?us-ascii?Q?wvuarLfjjU8btkaVydrho4HjkHOtzePpOaDvZAueuAQ+OZPYxdurffNMdLSZ?=
 =?us-ascii?Q?LxnKqjpD84yD+nzeH3V3hJvFQEAJsw8h/VlHqrt5t4+rASxyIY+HsenYtJ3z?=
 =?us-ascii?Q?BJP+HWtiCnCJoMYwMLPcqPEU2pXOMZcdWL07YncdfBQbWYmdM81OWyVfki5K?=
 =?us-ascii?Q?gRTPXP6/30V2WAk1ml2nEwmwnDRPKExtS6Vw5HAtyMOhLpYVXjawswDUbE/a?=
 =?us-ascii?Q?byX9E81r67IRzF8OWWK/U8VSacqB7yPqA9Grs18oQMNhMdV4mRaQXeowVCwk?=
 =?us-ascii?Q?jJFv+Ng5MiRMqrvE03FFNtb7Bsv3vEW2tx/Zyi53lRutkVBmXzgj5ABd5O4n?=
 =?us-ascii?Q?3LOfn5jDV3de256yQVAk24s1haGRenPBWa5Cb8OjxLML7WoF4ghdcaa9QVN+?=
 =?us-ascii?Q?BU5R36J7PTGhAd+hZ1dn1Lmx2b4LXkgd6Dy1fUvOAz8krfRvtDPgXrC50yUE?=
 =?us-ascii?Q?wo6xxeHamuO85hUFqku6/MEihrgmi3ofbCifJR2R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ad03d5-6456-4e0f-94c0-08ddd9b119e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:01:22.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etRP7L0vKKcaxPI63Z/D9iQ/GKgZcfHdSkLBVo2LNG8nlhcTSbiUOzAYvRF9Lshw9hwXNacp50jdFY00QD7gnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10898

On Tue, Aug 12, 2025 at 05:46:23PM +0800, Wei Fang wrote:
> NETC V4 Timer provides current time with nanosecond resolution, precise
> periodic pulse, pulse on timeout (alarm), and time capture on external
> pulse support. And it supports time synchronization as required for
> IEEE 1588 and IEEE 802.1AS-2020.
>
> Inside NETC, ENETC can capture the timestamp of the sent/received packet
> through the PHC provided by the Timer and record it on the Tx/Rx BD. And
> through the relevant PHC interfaces provided by the driver, the enetc V4
> driver can support PTP time synchronization.
>
> In addition, NETC V4 Timer is similar to the QorIQ 1588 timer, but it is
> not exactly the same. The current ptp-qoriq driver is not compatible with
> NETC V4 Timer, most of the code cannot be reused, see below reasons.
>
> 1. The architecture of ptp-qoriq driver makes the register offset fixed,
> however, the offsets of all the high registers and low registers of V4
> are swapped, and V4 also adds some new registers. so extending ptp-qoriq
> to make it compatible with V4 Timer is tantamount to completely rewriting
> ptp-qoriq driver.
>
> 2. The usage of some functions is somewhat different from QorIQ timer,
> such as the setting of TCLK_PERIOD and TMR_ADD, the logic of configuring
> PPS, etc., so making the driver compatible with V4 Timer will undoubtedly
> increase the complexity of the code and reduce readability.
>
> 3. QorIQ is an expired brand. It is difficult for us to verify whether
> it works stably on the QorIQ platforms if we refactor the driver, and
> this will make maintenance difficult, so refactoring the driver obviously
> does not bring any benefits.
>
> Therefore, add this new driver for NETC V4 Timer. Note that the missing
> features like PEROUT, PPS and EXTTS will be added in subsequent patches.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2 changes:
> 1. Rename netc_timer_get_source_clk() to
>    netc_timer_get_reference_clk_source() and refactor it
> 2. Remove the scaled_ppm check in netc_timer_adjfine()
> 3. Add a comment in netc_timer_cur_time_read()
> 4. Add linux/bitfield.h to fix the build errors
> v3 changes:
> 1. Refactor netc_timer_adjtime() and remove netc_timer_cnt_read()
> 2. Remove the check of dma_set_mask_and_coherent()
> 3. Use devm_kzalloc() and pci_ioremap_bar()
> 4. Move alarm related logic including irq handler to the next patch
> 5. Improve the commit message
> 6. Refactor netc_timer_get_reference_clk_source() and remove
>    clk_prepare_enable()
> 7. Use FIELD_PREP() helper
> 8. Rename PTP_1588_CLOCK_NETC to PTP_NETC_V4_TIMER and improve the
>    help text.
> 9. Refine netc_timer_adjtime(), change tmr_off to s64 type as we
>    confirmed TMR_OFF is a signed register.
> ---
>  drivers/ptp/Kconfig             |  11 +
>  drivers/ptp/Makefile            |   1 +
>  drivers/ptp/ptp_netc.c          | 438 ++++++++++++++++++++++++++++++++
>  include/linux/fsl/netc_global.h |  12 +-
>  4 files changed, 461 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/ptp/ptp_netc.c
>
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index 204278eb215e..0ac31a20096c 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -252,4 +252,15 @@ config PTP_S390
>  	  driver provides the raw clock value without the delta to
>  	  userspace. That way userspace programs like chrony could steer
>  	  the kernel clock.
> +
> +config PTP_NETC_V4_TIMER
> +	bool "NXP NETC V4 Timer PTP Driver"
> +	depends on PTP_1588_CLOCK=y
> +	depends on PCI_MSI
> +	help
> +	  This driver adds support for using the NXP NETC V4 Timer as a PTP
> +	  clock, the clock is used by ENETC V4 or NETC V4 Switch for PTP time
> +	  synchronization. It also supports periodic output signal (e.g. PPS)
> +	  and external trigger timestamping.
> +
>  endmenu
> diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
> index 25f846fe48c9..8985d723d29c 100644
> --- a/drivers/ptp/Makefile
> +++ b/drivers/ptp/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
>  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
>  obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
>  obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
> +obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> new file mode 100644
> index 000000000000..cbe2a64d1ced
> --- /dev/null
> +++ b/drivers/ptp/ptp_netc.c
> @@ -0,0 +1,438 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * NXP NETC V4 Timer driver
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/fsl/netc_global.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/ptp_clock_kernel.h>
> +
> +#define NETC_TMR_PCI_VENDOR		0x1131
> +#define NETC_TMR_PCI_DEVID		0xee02

Nit: Like this only use once constant, needn't macro, espcial DEVID.

> +
> +#define NETC_TMR_CTRL			0x0080
> +#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
> +#define  TMR_CTRL_TE			BIT(2)
> +#define  TMR_COMP_MODE			BIT(15)
> +#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> +
> +#define NETC_TMR_CNT_L			0x0098
> +#define NETC_TMR_CNT_H			0x009c
> +#define NETC_TMR_ADD			0x00a0
> +#define NETC_TMR_PRSC			0x00a8
> +#define NETC_TMR_OFF_L			0x00b0
> +#define NETC_TMR_OFF_H			0x00b4
> +
> +#define NETC_TMR_FIPER_CTRL		0x00dc
> +#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
> +#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
> +
> +#define NETC_TMR_CUR_TIME_L		0x00f0
> +#define NETC_TMR_CUR_TIME_H		0x00f4
> +
> +#define NETC_TMR_REGS_BAR		0
> +
> +#define NETC_TMR_FIPER_NUM		3
> +#define NETC_TMR_DEFAULT_PRSC		2
> +
> +/* 1588 timer reference clock source select */
> +#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
> +#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
> +#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
> +
> +#define NETC_TMR_SYSCLK_333M		333333333U
> +
> +struct netc_timer {
> +	void __iomem *base;
> +	struct pci_dev *pdev;
> +	spinlock_t lock; /* Prevent concurrent access to registers */
> +
> +	struct ptp_clock *clock;
> +	struct ptp_clock_info caps;
> +	int phc_index;
> +	u32 clk_select;
> +	u32 clk_freq;
> +	u32 oclk_prsc;
> +	/* High 32-bit is integer part, low 32-bit is fractional part */
> +	u64 period;
> +};
> +
> +#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> +#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
> +#define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
> +
> +static const char *const timer_clk_src[] = {
> +	"ccm_timer",
> +	"ext_1588"
> +};
> +
> +static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
> +{
> +	u32 tmr_cnt_h = upper_32_bits(ns);
> +	u32 tmr_cnt_l = lower_32_bits(ns);
> +
> +	/* Writes to the TMR_CNT_L register copies the written value
> +	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
> +	 * register copies the values written into the shadow TMR_CNT_H
> +	 * register. Contents of the shadow registers are copied into
> +	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
> +	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
> +	 * register first.
> +	 */

Is all other register the same? like OFF_L, OFF_H?

And read have similar behavor?

> +	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
> +	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
> +}
> +
> +static u64 netc_timer_offset_read(struct netc_timer *priv)
> +{
> +	u32 tmr_off_l, tmr_off_h;
> +	u64 offset;
> +
> +	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
> +	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
> +	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
> +
> +	return offset;
> +}
> +
> +static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
> +{
> +	u32 tmr_off_h = upper_32_bits(offset);
> +	u32 tmr_off_l = lower_32_bits(offset);
> +
> +	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
> +	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
> +}
> +
> +static u64 netc_timer_cur_time_read(struct netc_timer *priv)
> +{
> +	u32 time_h, time_l;
> +	u64 ns;
> +
> +	/* The user should read NETC_TMR_CUR_TIME_L first to
> +	 * get correct current time.
> +	 */
> +	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
> +	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
> +	ns = (u64)time_h << 32 | time_l;
> +
> +	return ns;
> +}
> +
> +static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
> +{
> +	u32 fractional_period = lower_32_bits(period);
> +	u32 integral_period = upper_32_bits(period);
> +	u32 tmr_ctrl, old_tmr_ctrl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
> +				    TMR_CTRL_TCLK_PERIOD);
> +	if (tmr_ctrl != old_tmr_ctrl)
> +		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +
> +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +
> +static int netc_timer_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	u64 new_period;
> +
> +	new_period = adjust_by_scaled_ppm(priv->period, scaled_ppm);
> +	netc_timer_adjust_period(priv, new_period);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	unsigned long flags;
> +	s64 tmr_off;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	/* Adjusting TMROFF instead of TMR_CNT is that the timer
> +	 * counter keeps increasing during reading and writing
> +	 * TMR_CNT, which will cause latency.
> +	 */
> +	tmr_off = netc_timer_offset_read(priv);
> +	tmr_off += delta;
> +	netc_timer_offset_write(priv, tmr_off);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
> +				 struct timespec64 *ts,
> +				 struct ptp_system_timestamp *sts)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	unsigned long flags;
> +	u64 ns;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	ptp_read_system_prets(sts);
> +	ns = netc_timer_cur_time_read(priv);
> +	ptp_read_system_postts(sts);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	*ts = ns_to_timespec64(ns);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_settime64(struct ptp_clock_info *ptp,
> +				const struct timespec64 *ts)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	u64 ns = timespec64_to_ns(ts);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	netc_timer_offset_write(priv, 0);
> +	netc_timer_cnt_write(priv, ns);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
> +{
> +	struct netc_timer *priv;
> +
> +	if (!timer_pdev)
> +		return -ENODEV;
> +
> +	priv = pci_get_drvdata(timer_pdev);
> +	if (!priv)
> +		return -EINVAL;
> +
> +	return priv->phc_index;
> +}
> +EXPORT_SYMBOL_GPL(netc_timer_get_phc_index);
> +
> +static const struct ptp_clock_info netc_timer_ptp_caps = {
> +	.owner		= THIS_MODULE,
> +	.name		= "NETC Timer PTP clock",
> +	.max_adj	= 500000000,
> +	.n_pins		= 0,
> +	.adjfine	= netc_timer_adjfine,
> +	.adjtime	= netc_timer_adjtime,
> +	.gettimex64	= netc_timer_gettimex64,
> +	.settime64	= netc_timer_settime64,
> +};
> +
> +static void netc_timer_init(struct netc_timer *priv)
> +{
> +	u32 fractional_period = lower_32_bits(priv->period);
> +	u32 integral_period = upper_32_bits(priv->period);
> +	u32 tmr_ctrl, fiper_ctrl;
> +	struct timespec64 now;
> +	u64 ns;
> +	int i;
> +
> +	/* Software must enable timer first and the clock selected must be
> +	 * active, otherwise, the registers which are in the timer clock
> +	 * domain are not accessible.
> +	 */
> +	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
> +		   TMR_CTRL_TE;
> +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
> +
> +	/* Disable FIPER by default */
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> +		fiper_ctrl |= FIPER_CTRL_DIS(i);
> +		fiper_ctrl &= ~FIPER_CTRL_PG(i);
> +	}
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +
> +	ktime_get_real_ts64(&now);
> +	ns = timespec64_to_ns(&now);
> +	netc_timer_cnt_write(priv, ns);
> +
> +	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
> +	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
> +	 */
> +	tmr_ctrl |= FIELD_PREP(TMR_CTRL_TCLK_PERIOD, integral_period) |
> +		    TMR_COMP_MODE;
> +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> +}
> +
> +static int netc_timer_pci_probe(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct netc_timer *priv;
> +	int err;
> +
> +	pcie_flr(pdev);
> +	err = pci_enable_device_mem(pdev);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to enable device\n");
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
> +	if (err) {
> +		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
> +			ERR_PTR(err));
> +		goto disable_dev;
> +	}
> +
> +	pci_set_master(pdev);
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		err = -ENOMEM;
> +		goto release_mem_regions;
> +	}

move devm_kzalloc() before pci_enable_device_mem() to reduce a goto

> +
> +	priv->pdev = pdev;
> +	priv->base = pci_ioremap_bar(pdev, NETC_TMR_REGS_BAR);
> +	if (!priv->base) {
> +		err = -ENOMEM;
> +		goto release_mem_regions;
> +	}
> +
> +	pci_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +release_mem_regions:
> +	pci_release_mem_regions(pdev);
> +disable_dev:
> +	pci_disable_device(pdev);
> +
> +	return err;
> +}
> +
> +static void netc_timer_pci_remove(struct pci_dev *pdev)
> +{
> +	struct netc_timer *priv = pci_get_drvdata(pdev);
> +
> +	iounmap(priv->base);
> +	pci_release_mem_regions(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	struct clk *clk;
> +	int i;
> +
> +	/* Select NETC system clock as the reference clock by default */
> +	priv->clk_select = NETC_TMR_SYSTEM_CLK;
> +	priv->clk_freq = NETC_TMR_SYSCLK_333M;
> +
> +	/* Update the clock source of the reference clock if the clock
> +	 * is specified in DT node.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(timer_clk_src); i++) {
> +		clk = devm_clk_get_optional_enabled(dev, timer_clk_src[i]);
> +		if (IS_ERR(clk))
> +			return PTR_ERR(clk);
> +
> +		if (clk) {
> +			priv->clk_freq = clk_get_rate(clk);
> +			priv->clk_select = i ? NETC_TMR_EXT_OSC :
> +					       NETC_TMR_CCM_TIMER1;
> +			break;
> +		}
> +	}
> +
> +	/* The period is a 64-bit number, the high 32-bit is the integer
> +	 * part of the period, the low 32-bit is the fractional part of
> +	 * the period. In order to get the desired 32-bit fixed-point
> +	 * format, multiply the numerator of the fraction by 2^32.
> +	 */
> +	priv->period = div_u64(NSEC_PER_SEC << 32, priv->clk_freq);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_parse_dt(struct netc_timer *priv)
> +{
> +	return netc_timer_get_reference_clk_source(priv);
> +}
> +
> +static int netc_timer_probe(struct pci_dev *pdev,
> +			    const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct netc_timer *priv;
> +	int err;
> +
> +	err = netc_timer_pci_probe(pdev);
> +	if (err)
> +		return err;
> +
> +	priv = pci_get_drvdata(pdev);
> +	err = netc_timer_parse_dt(priv);
> +	if (err) {
> +		if (err != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to parse DT node\n");
> +		goto timer_pci_remove;
> +	}

move netc_timer_parse_dt() before netc_timer_pci_probe()

you can use return dev_err_probe(), which already handle -EPROBE_DEFER
case.


> +
> +	priv->caps = netc_timer_ptp_caps;
> +	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
> +	spin_lock_init(&priv->lock);
> +
> +	netc_timer_init(priv);
> +	priv->clock = ptp_clock_register(&priv->caps, dev);
> +	if (IS_ERR(priv->clock)) {
> +		err = PTR_ERR(priv->clock);
> +		goto timer_pci_remove;
> +	}
> +
> +	priv->phc_index = ptp_clock_index(priv->clock);
> +
> +	return 0;
> +
> +timer_pci_remove:
> +	netc_timer_pci_remove(pdev);
> +
> +	return err;
> +}
> +
> +static void netc_timer_remove(struct pci_dev *pdev)
> +{

use devm_add_action_or_reset() can simpify your error handle.

Frank
> +	struct netc_timer *priv = pci_get_drvdata(pdev);
> +
> +	ptp_clock_unregister(priv->clock);
> +	netc_timer_pci_remove(pdev);
> +}
> +
> +static const struct pci_device_id netc_timer_id_table[] = {
> +	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR, NETC_TMR_PCI_DEVID) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
> +
> +static struct pci_driver netc_timer_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = netc_timer_id_table,
> +	.probe = netc_timer_probe,
> +	.remove = netc_timer_remove,
> +};
> +module_pci_driver(netc_timer_driver);
> +
> +MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
> index fdecca8c90f0..17c19c8d3f93 100644
> --- a/include/linux/fsl/netc_global.h
> +++ b/include/linux/fsl/netc_global.h
> @@ -1,10 +1,11 @@
>  /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> -/* Copyright 2024 NXP
> +/* Copyright 2024-2025 NXP
>   */
>  #ifndef __NETC_GLOBAL_H
>  #define __NETC_GLOBAL_H
>
>  #include <linux/io.h>
> +#include <linux/pci.h>
>
>  static inline u32 netc_read(void __iomem *reg)
>  {
> @@ -16,4 +17,13 @@ static inline void netc_write(void __iomem *reg, u32 val)
>  	iowrite32(val, reg);
>  }
>
> +#if IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER)
> +int netc_timer_get_phc_index(struct pci_dev *timer_pdev);
> +#else
> +static inline int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  #endif
> --
> 2.34.1
>

