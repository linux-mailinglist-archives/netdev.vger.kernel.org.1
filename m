Return-Path: <netdev+bounces-220118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0375B44800
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB5A1C229B9
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C44028DB49;
	Thu,  4 Sep 2025 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AAQ3gG1j"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161627AC3D;
	Thu,  4 Sep 2025 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019832; cv=fail; b=fnQI/0xPCSiKFtjXQZyrkiFm8ht0vk+5L7Ay2o2fPu4NTBmVJa/gity/7l0CKeMo/UxZ2ja/Ni2o58m2Fs5P1ZdO4+qFPOpGe6AFIIVE7bALzR1SFM1jtEH/bLqk3tdAXrffbi1Falur4h37s74ekR6NanGMmwzuwlvBT0BZIzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019832; c=relaxed/simple;
	bh=bUYIB9zsQA8O2QaeFcBXhuqk8ng1khQdKR8xLEtIXD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RD/ZZyjq5a3E3tuQYNFFxtzx0fNfKMRSYu38VbGP7xaZf2lFOkvw8p9eqoA65CHckEmpYbZUPy5Mfeoo6bXa8APq1aPsX9zdny9zuZMMx1aQHtVkhjekaozMrRrZNjr83womp9+yP/E1K5CHQacF3d2PVQdzQH43gqo77Y6x1RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AAQ3gG1j; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAf1sVwNqWLtKnKPttMU2UpKXGNd2+1aSTiTknfW1NQq4c9L5dLcoG+aeLzWwzPw5xFA334CuzvydyRJG2DzxP1Ca5H8UsyUjMjG9bqG5sbqPgsb7CXdcGPS/peDDrBwiAMR9mZ03vQQl8tLQOvDjJc8p+zxIypT/d3KPjqPXi998hlnxujD+ZC5BwaSS1AQ+HwnwFbeKnLY6N4ohNDM5Dq422RrLwluTdOBOVL2iX1kfAXVdXD5cU3vDJJA/bfTott3kli3Nky/lvO74mr0EEf4la2UGtwLnwIJ3ly2MCg0Gu0o0X1zs5exI7PpvGYm18Kodx3MAc3TV81AlAnaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpCh6tUFYHoTSk6PUZpuOy85t7kk94SQTP3H+G8L5jY=;
 b=by0fBAfNhoQhSiTdTAFNHQm7p+gqzj3m2uD/OhzW9dDuYPNLMBok4R6/f/kupozC0yvHzW7CDIAaObCOxq7DWBgZ1Kjm9zG7cynok88leJXPn0zBbhUXePo/1SrkwHzvSkZeqb5PvqfYfMDcR1LktXMAZAT2fWcZ4rC2Pa+skcfI7rtNaTRwRtTYW4Fdq0/ewtlvHI7qs23HwHuUhHNLHEi+bfY+xmM9eFIOVzoAOsLE4/aBACQQuHarGQmkbso9JXlTwNFRb84EJu+fvi60ndeEDorZZxFNlvIZrIsCQjH1QVS5PCnLCm7oWFNkBV0u25oYMZoKqDlXWz6JrhNqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpCh6tUFYHoTSk6PUZpuOy85t7kk94SQTP3H+G8L5jY=;
 b=AAQ3gG1j70Gl4CTZhNXInG3h6BdlOxVhU3RuDOT0WuwZZum7YtaJ/ZAh4n1ZOatZEskqa0Fw+D2qBKf+uWajZG4ae1qBvGSAUHnerSVlJwqk2DaDkTdr7z7N5HtuP1Y67xofXuKa9Gv6CVB1nlonpDrHK5hEgLEjxxskejcTXfXgR/CGlVLC/GwWTijBcvw6rN+5jEL3BxFU3JIVVgmVDiqow4HDyxsYYppPG+7+ouQgADTFJrbkTYjzS2H+tMqt7t8fCZzLblqvkqsZExIJAd1eVdikP/ioz7yXwrjZrIw2I9cYubHCz/1DflHIk9ZYJlf1z3UVFtEBXg7eWr2GoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10123.eurprd04.prod.outlook.com (2603:10a6:102:403::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 21:03:47 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 21:03:47 +0000
Date: Thu, 4 Sep 2025 17:03:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-imx@nxp.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v5 net-next 2/5] net: fec: add pagepool_order to support
 variable page size
Message-ID: <aLn+qtwgVbOJDipt@lizhi-Precision-Tower-5810>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
 <20250904203502.403058-3-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904203502.403058-3-shenwei.wang@nxp.com>
X-ClientProxiedBy: BY3PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::29) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10123:EE_
X-MS-Office365-Filtering-Correlation-Id: 30cad0f9-03c8-4301-eb13-08ddebf68a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|19092799006|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tEVqxVspZeJStdVVRyLzc/MVy2bJZ3xx3rI1IPg5oqSZ2ifCTcH5tYiSrS4H?=
 =?us-ascii?Q?dbOTma7J4p++0Nry8dL1iAj0lOVeOZR3AOBs0bq7MziBy/J1BkyKjBnexj5M?=
 =?us-ascii?Q?d0eS57j6IPY8ZucUCA7X0rZQ+iJULsWBuxDP1og24ZFpncG9mbbL0gl0IvJ5?=
 =?us-ascii?Q?ZXlEi7KE3X6nlbxrDlexVJzzVHdfUubjO/kWC8Ds1KrpksQB2LuwajAEQETA?=
 =?us-ascii?Q?UQX/0VKWF0jw+CjzsJ7RHKvFG3CrVmLswDyBGpuezBnBglTzI3vM2C+sUFoa?=
 =?us-ascii?Q?OhX8YkNW9WvUvWr2MR56X3str9YvVh4aS3hqMT1CLB4hxkAkNhYbTBXz+4mR?=
 =?us-ascii?Q?04YqcRTicFnftmYOeYMacVkuaEQ/XUp511Xhneo/eUUiMWJzxQebGNX735Ya?=
 =?us-ascii?Q?dRqni2Cd4XhNWNtrosdAGVxqEyUK4VxjKGcV6V7gAggaWuNyBRr/sble8TzY?=
 =?us-ascii?Q?Ws0ZTiDRjog80AC/2ddTfKoMbELZzxsYi7OY30Hyr8DZdzNAnw4lEDsGBw4j?=
 =?us-ascii?Q?b+HXOSCr+9Uu4zmCuCvcJ8/NwmIYpWL97SQ1XAI0gv5UAdmd9840mJxlbAhN?=
 =?us-ascii?Q?ryxx7/oZXK20XlpybFMGEDZRPWq412RT7Bwx4fCbV5I8lkw8ifU/i+HiJ7Sy?=
 =?us-ascii?Q?JmOoDkrh9oKxZj50lOei7YJsIAMB7c2mr/kQviXzWupIIiokkHIrAyUUctM5?=
 =?us-ascii?Q?QFcih8yr6X1XTuAw1op3Zv/r0No3uon1jjuWk0tbF/KMosLi9GerxKK2XrB3?=
 =?us-ascii?Q?UPRXzfFyuGmZ0s2Qhiaoj3ZodGGQgCXO/s0ASh8OoFUEZB9R//AquWBBkEVE?=
 =?us-ascii?Q?KnFYdPGaGc99uKhmlKuAOFDU/lnAY0lg+Zm77X9HSHgPwCLmTBkyL31oh4lP?=
 =?us-ascii?Q?gTssDVbeOKKOelQyNQCsnX4JEnVZB+DFfdS7yJB3sZ0gH/xc7jLniSMG9Rer?=
 =?us-ascii?Q?OhJP/0tp7kI32ysYK47/xAWIPQg8sXUImcVOjqze4XVuU6JpfFtD9Ydb+RWi?=
 =?us-ascii?Q?d/r3wlcdAGnD3CJUj8x2k64ex7cTPYQPivH7k7iHVME+5f3A+g3agLaQCU+m?=
 =?us-ascii?Q?Abal8Y1EV1bsDQRdWdqyilZ+8Kht7Hok1YfzvXyoCJeH0fpiQvF9gbkqICTo?=
 =?us-ascii?Q?QmDiaIgWPzy8ObMSUg5zcjyVhu97H5uiezR8UF2JVg7uS29ZvuDdT73j4LWH?=
 =?us-ascii?Q?n/XYcTSQGiv4BNitQenvH9WW3JVHWAIBLH2i128DiwwVn11GA05iHlMR+ysr?=
 =?us-ascii?Q?TtWatX6NYpECyHxGMeuqzTTDhP6UPz8KPloWkJwZFFyccoo8KoS2e11lo6xB?=
 =?us-ascii?Q?xB3Q9dkCv5PeXgJ1hLXZtTEQ0EouVvcMnW659NlRwKWltgTbxw8CZxx6duNd?=
 =?us-ascii?Q?iNSQb/iow6ALvvPg0Ias3XNTR6jC8vcQ0+8j/G6Z2Ud7rLnTiwe9aApdQKSh?=
 =?us-ascii?Q?+Jefo3+D0wypPG39rSxZMwBe3coLvrmBOEDEnWRNzVU+MJXQvm6ukQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(19092799006)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pgwmBx4yvcNXBdp0XfAXEmVBErPakiUiPCtiINL3a+THgwf2jeThPV88NAMg?=
 =?us-ascii?Q?YRoIADhUsPHzQ1WSRGRyLNzUzzG4D2kp/v83zVLUq8bnGZBTLGAJeD4W1r0x?=
 =?us-ascii?Q?6ZQjIcQqAMQ7KJvUYpeIgpMVpCcDteb1jCrY6uXLRHvZT4ekw3f0Iz0iqkvo?=
 =?us-ascii?Q?MXSzq87q0kCinEEhH3JodhWs+JW75vziOzhZVSPyDTHr0AgkUVpTQPmg5i6E?=
 =?us-ascii?Q?rrvpXxAI6DAMg3RIdl5p02wN9bySWz80C5JEajIBRp+QsF7wo+1VjsBZV26U?=
 =?us-ascii?Q?RHkBl297tBe230uWXdTfFdbI+eT/vKTSPQcHEMJBDwzFtF5jXA8bY1XCeM8i?=
 =?us-ascii?Q?DAIiGHkaqUu0UODiFTZPxCxExapPqQcSRcisfvqO+wxEtTEfA1mm862YGZaz?=
 =?us-ascii?Q?i9Ly+FgpA+RMS7c7DOhJqniv3w/jyNzpoh9CjB+HwGkHjfMSDITmzgnCH4Wf?=
 =?us-ascii?Q?pCg3WUXL02RbmJfdAVP3nqFypw2tGDUbVqTZH2ILQUddlwXv+QSB8CHphyuj?=
 =?us-ascii?Q?9hG/e9J/OPb0Nx0yPiu1l3/hujoegOdxTtkJGx/dbr10kdUAkf+WcEdeBlPR?=
 =?us-ascii?Q?1IbZz9fMBGRk1XvHYWfQlEctRcp+CfMsZuKbpOTEDB6JtiPsUcPOBfpCanOm?=
 =?us-ascii?Q?y3N+/vcqp7kXgAlht9pWSHGWOz1TpBTAXX5BUyW38Ydc1GsBDcKs/rC+Mtp7?=
 =?us-ascii?Q?PulzTDUQJXKz43Z0x3Reef5DQWwtJ0ReEKLRjWgatUgHAmPY77/nJnfipjrw?=
 =?us-ascii?Q?foAcSO8W+VW4SYcJbkQPGwu7O9lxFhiJMwYZlr5jrohReo/oUuJID2wOQhIP?=
 =?us-ascii?Q?kKXINmlDkBSQsoaQOQy9/vKNd7gc3jmCcy3eE85vZduBIIlHqUMJDAtlB3i+?=
 =?us-ascii?Q?vxx5hkFMWan6Q2Ua3MkmSJinFLKYtlOnB475QdaDNtc2BJeCxpyRhBf6MZOz?=
 =?us-ascii?Q?czJwjnT/fg1MHmXKgu7JR5hzr/dluY9oZiGSgm3lqs7kvzE+24vDPXCWpcYu?=
 =?us-ascii?Q?KSjoYt5rtRyMvJD+O+Mgul8MMTO8bX8JTTYs+nojmauu1jVbrP+OHZ7whtc+?=
 =?us-ascii?Q?3tU35/LJprQa2SevoPzLVunB6ZWUWh/Nk3Ef1VEZA1uWvSHyFXbb00Xn70qX?=
 =?us-ascii?Q?tfc28EckPBKuc006ZC4UNNABw5m1ioFlXTrlSX9t7kOUraSAaD8W/IRxYM2w?=
 =?us-ascii?Q?KGpp3VxxVwptfRODSnggYd/1CF93x2eKqYFudsjeAL7XPHzbe7+M8XXhgDMT?=
 =?us-ascii?Q?q1q2SBHNo8mgGxVfWVKG+p3Fzt6eWJc9mraRY7EXnueV9ppudIyqeoHaz4mN?=
 =?us-ascii?Q?X+KCsG02V0RABmBJjB+3aiDRjNC8WBW0HWVFvZ0+IrZ95NX973tE+ovLP3/9?=
 =?us-ascii?Q?BRpWFIZ2NaXBh/3L/ihVWnm6Aaq6Vi+vSt7KLID8dA2gPnRja368SzmHa2TZ?=
 =?us-ascii?Q?iqBZACTLpW3R9AIN8jSWBIRDhtz9HleT15ZTSX4swCrhw64nmn5u/Y+0Y2cm?=
 =?us-ascii?Q?CrHd082Po3zSaO+xM9mh/RjraEouXhWt6MjxWSi/kA+S9AIiBVA2+78JqN3g?=
 =?us-ascii?Q?Psdb7SmZ4ZWqsyj3n1kbxiG90C1ITNSYgPeyZhae?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cad0f9-03c8-4301-eb13-08ddebf68a52
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 21:03:47.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uz+Mr6E7ep5z/A5WFQR41gmIqYhsGymoOG0XsIz0e7pQm5eSa569VeDznG2QP9sYb/2Bfn9MQHnJlodwFNY9yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10123

On Thu, Sep 04, 2025 at 03:34:59PM -0500, Shenwei Wang wrote:
> Add a new pagepool_order member in the fec_enet_private struct
> to allow dynamic configuration of page size for an instance. This
> change clears the hardcoded page size assumptions.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/net/ethernet/freescale/fec.h      | 1 +
>  drivers/net/ethernet/freescale/fec_main.c | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 2969088dda09..47317346b2f3 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -620,6 +620,7 @@ struct fec_enet_private {
>  	unsigned int total_tx_ring_size;
>  	unsigned int total_rx_ring_size;
>  	unsigned int max_buf_size;
> +	unsigned int pagepool_order;
>
>  	struct	platform_device *pdev;
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 5a21000aca59..f046d32a62fb 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1780,7 +1780,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  	 * These get messed up if we get called due to a busy condition.
>  	 */
>  	bdp = rxq->bd.cur;
> -	xdp_init_buff(&xdp, PAGE_SIZE, &rxq->xdp_rxq);
> +	xdp_init_buff(&xdp, (PAGE_SIZE << fep->pagepool_order), &rxq->xdp_rxq);
>
>  	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
>
> @@ -1850,7 +1850,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		 * include that when passing upstream as it messes up
>  		 * bridging applications.
>  		 */
> -		skb = build_skb(page_address(page), PAGE_SIZE);
> +		skb = build_skb(page_address(page), (PAGE_SIZE << fep->pagepool_order));
>  		if (unlikely(!skb)) {
>  			page_pool_recycle_direct(rxq->page_pool, page);
>  			ndev->stats.rx_dropped++;
> @@ -4559,6 +4559,7 @@ fec_probe(struct platform_device *pdev)
>  	fec_enet_clk_enable(ndev, false);
>  	pinctrl_pm_select_sleep_state(&pdev->dev);
>
> +	fep->pagepool_order = 0;
>  	fep->max_buf_size = PKT_MAXBUF_SIZE;
>  	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
>
> --
> 2.43.0
>

