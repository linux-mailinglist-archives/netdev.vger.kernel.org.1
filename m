Return-Path: <netdev+bounces-148594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 149389E2AE6
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F553B25C41
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B951F76BD;
	Tue,  3 Dec 2024 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VseXy2I/"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5621F427E
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244497; cv=fail; b=VXLbX+C+jF8338LKasQ4Rb3vv6R7lt0kDsID6kxviaFmYNbl+kDDFXKvWRTk/jqbK3par8xo1+FeoQSORw+D9yIXPRAzcxIhLsW9oAEWmlUwKvuQJFiPQfdjoeBkVkL5RoTTNkTKqO37Yx7/lpHtom+M5m/W4voOqJGZwA892E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244497; c=relaxed/simple;
	bh=siRTFqcIo3pMaFpICgGhLCWagNibdq51Rq88tU6IO3U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WoyKc9/0QnROObF8RTIwhEs2fESNXcKsRx4hCXjQ8zQE14xxWBgrGARwltPacFddS9gXiQS3T2HM3HXlI2ghGeMvKOBfYJVa3ZEZdrLpfLgUbeUUXauJDylKUZSyC9HCjKSdSoKYxYi229PCl4Ci0qN+uhSHNtSf3/wo81EuHCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VseXy2I/; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPnpO6KV22AJMbCgSabXJaFMs+ef3lWvcqjmt7gVrfOTJWK1TkRPN7uOzYY9hT8TMn1UJmDBw6vaS31x54DwWzzbrQUrUT+dXziZnz7uJdN82kaAz+97J3y4yS4bfMDT7n5FeI0Ph43FkbDIqHrQhBQA4LYl2XAl8X5VK9heeCRSKRj73Q88IRcnGTD3DVCjUPnY9btOz69ITyUK98bTg8uWUp+9ay5VNO2TPhJntWz48DHkwiRnnFtdTcREKg9Ns9imZXVBTuRerzb9FUUdELG2ljITQcBRsYfhv64hTalYJA1BAyt2tNPuZE4MC66DHsVMR70/m0pDKq2FyaI7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoNG8XNRxQAfwlz5FcsWS0FcyWm6AbFp1Gt9chi5Bl8=;
 b=HUovsOySzgJU5SZHv6LmjU6cUmCrvr8sBLVmiYK9vsa28uqmF7o4vAtuK5MMy3jWkAAkx5LzEoJfz0+YIS7t2tmTF1cg14KwB/VYApeeZbpAYZF07YGksOT9P7cdamIFkBc9q8QCkmvPM6KJnDkIGKbmsmX6mLg+WEdG0Xi0uW1oEVYLwNkDkQRE1Ryfv8eqDmqBTrvgDEpJp63b0aCYigMe928ZprmW2pfWZuyOCqBxCNUMqkOZutEq5a/94sZhmUAC2WA0UBCW//lacx1HuQvEJNEYM1xaqYM4NfHtx+AxSfEQETtGGV62d5jQnlAqGG6CUaa8hTAXtb7Bo3ZfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoNG8XNRxQAfwlz5FcsWS0FcyWm6AbFp1Gt9chi5Bl8=;
 b=VseXy2I/Z6yzjrbG3KE92h9QOa6dTMo6lfWXSEBP149KXXj5NI+1BgyLd6I8F7E1pIEwJrg1275w7MS5IDCwFRQYB5We9nkJkD7lcsaWC5HI6pGxt4bKpe6g51LZOn2nFOFEQ+pVQ9yVmDVB1Xiy5EB8rC2Xi2QRgdHPWmZom8xDshEh95PKI4mxmCr/t02ddxxvn0EHt9rqZBpKWpSjHCWo55RkqiQW0bGEAPDOPBI3JapOQXrCgaD0dnviHF1CsBm3Rq0XLMq8fJZrVrkCxaq55WGjc7U4L7i3RApQsL4Eefj988hfbZ85qvia8rQema8hYmeJl87+WBCYj+lbhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9551.eurprd04.prod.outlook.com (2603:10a6:20b:4fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 16:48:10 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 16:48:10 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net] net: mscc: ocelot: be resilient to loss of PTP packets during transmission
Date: Tue,  3 Dec 2024 18:47:55 +0200
Message-ID: <20241203164755.16115-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0037.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e6faab-5b70-4cd3-47be-08dd13ba4503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uyuz0Nd7k9QzCEaVypeqj8Jdcwqh4onT0Fs/Ksw5rOlDMNu98z2bSiO3Bv8P?=
 =?us-ascii?Q?5p7YxD7nWIeUCwpVWZieThk8RzLO6vNh8cPQBv2/ldGiIH2sG0gXPk0YqNk9?=
 =?us-ascii?Q?6+iWCVI4gmM/5SZpFQh8Hq41DsUf2O/vy1/QiGxz6ABF6FTI9o0zDXriVDfP?=
 =?us-ascii?Q?nV0X2zmETO1QFn5QFx+XKnUdt2i6F5o3eHjTD5TAqhwu9qTtLZ9wpuntfB0p?=
 =?us-ascii?Q?MK2BNpsfT2y+7lrvNs86d/nQS4yQM827l/IkZsZoYTiClFn0hFHxKM8zOHJ0?=
 =?us-ascii?Q?fLFqkal+5f90qGdpJEXJRjP1YAtF7hqk+c+N27iYP9sOePqp6RDdxeivM3vP?=
 =?us-ascii?Q?UuJGJxRpWXnEcBZ1+G7P1ONapN1F8/rnyP4sAkk2Lp5uBiKmDAWGYO/fGApP?=
 =?us-ascii?Q?RTSqUUawwbzMh+qIkK+iagaDai43GOvpgD5fywAuLlNJm6oH8fXAbWXJRt/Z?=
 =?us-ascii?Q?LPqJhxhroyJvtTi3Yx3Knx57KEdN9YMUQO5kUU4fqXsbwfBv2y3B1ttV1/tp?=
 =?us-ascii?Q?9kKu9BGbRrZyroAV/Bz51CY3zrzYUCGKwjirXbpLoyo3R/S8bxWc5cWCETwC?=
 =?us-ascii?Q?oHW7ZeGgHb55aLmoHE5wsks1V2P6Flc6afkdLEtOd9ILcs7u7+vH1yQTSADf?=
 =?us-ascii?Q?3Z4B+2FjaawbrLCxqFHUK0ZKV4ujFd2hSc2tSoO8G8xovRIyfjxBDl3qrvXB?=
 =?us-ascii?Q?LOKDsRKhp7wjMFTtiUBYQcRxeLd9O3IzaeeQlFAuqv6zurufZ4Jxab0Fzaak?=
 =?us-ascii?Q?CmUd47AaMkJ133/IGgOqAk09SJJLHe1jpHHRjYrEMahnNMSg08RJrHbv3r00?=
 =?us-ascii?Q?WS7z7fmOwtdW68qSKZOiEEh23r8bT9iNv+3jAkeGz9Ac7bkVTZUH5AzMFuVU?=
 =?us-ascii?Q?XGbt9ATZZmkgLk6c67jswdp16zuxcGZHuAmoxFYAj9lMcQEqUfLE6WW27b++?=
 =?us-ascii?Q?2Tv5sKQAkdUIwgoJcGMqDWVJDLMuMfWwMB6Q1ColauEMOzCXI7rPijauVbU/?=
 =?us-ascii?Q?hmyFEWs2kwtaMk5PF7vC/7kkhpoPEusd+e8hagN6S3VXnytl1xYknVxr78zO?=
 =?us-ascii?Q?3L+N0PZd1bpY68FqNjY0N88lgRts3g0eoXsu9jROKhxpxL9pR71w9zsXb3YQ?=
 =?us-ascii?Q?3ioluxNqUljWMuBhBCiiB2e/vz3CoGYRQNJZbzt1dNjKXl0ew74dWpiD7ZPx?=
 =?us-ascii?Q?nvJd+Dv4Qsh1r/R8dOk1uTcvNQyiODpL26a38owKricP12g99nE5dtTjlHGG?=
 =?us-ascii?Q?438TYBAcPOpvzE90/ekOJRoH8VKOjGMR1Cq4yGk+1O5WFlWrF5uOD9Xt5UOP?=
 =?us-ascii?Q?W0uGHgzX/vvoqKynym589ryM2SkieQgBHYQnepUFwUXMEl/8nSTbuX37nkpk?=
 =?us-ascii?Q?2F/X6L/QsuVz9XrrLXf7oeRDTEkZHuB+jFeFQBkvoXa3xmvPrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?joZamcY8L2L8pPVW3rOOyGmXDcxl9jSUGnUDgkOT8VOk7xQ/qiYb4gxD1RVi?=
 =?us-ascii?Q?5cGtvt16bmJhapMbjlmBYGNzFdlDYpWVvIQzj+dCWtNbyLfE4T57qnxODH4j?=
 =?us-ascii?Q?rzGbrss4fwm4FglveLwotVYjXUsMNl9KEFzRYIVodSlt71jz4HtqV1ZzfZYO?=
 =?us-ascii?Q?8jLn/f17Jkf2Ea0yEycIukRQRSkbvYP7kEoN225q1HIfiHRfya+QWjcG2DGu?=
 =?us-ascii?Q?YtFO4QCsyhSPb1b6w8An/yXnTs0gOyKbL5Rw6yrgaHSS9Cetbyl1Br9wUBcQ?=
 =?us-ascii?Q?QK/4p+RSLNASPO6UClk5xFohXkomqzqkmWp8+g0fEio6j7678dLLDqiNgcVH?=
 =?us-ascii?Q?0EwKWjL22ZiRdUlEjOhv1/bdgioAt+ahx3xyy7VkpWNoJlYqD0W/zK4A7RDI?=
 =?us-ascii?Q?aK3vl7CZrDeFe5risObwCntFemESY7FADDiAtHZhxmMpbCqtCrykv7E6ejmv?=
 =?us-ascii?Q?q7anWKiXPTlINnpxnCLnWoZWI2UbGismHpMUWddOBSw+/7reegfPEtx2BTAC?=
 =?us-ascii?Q?j4y0FQSqZC5fPftbn94i+pzN405TeJHH9yg7bSR3oDlN7SjyQv32c0wrfb28?=
 =?us-ascii?Q?5ucO5QBJQTL3ohmRh+AJ89lOXkJF7Tc32umJmvoJnodYaJ06RZuA5MwX/0RE?=
 =?us-ascii?Q?Syje8qYbpG+/qY/PLBOpHPWuwehLtauP+bzvdmkFvnNviO98sHVArnsOZJ5m?=
 =?us-ascii?Q?pp8/6xi02iIz3KJb/VgLfwb4rFUSFbzJO0Z4L3nG0SCTV3jbwiYL5cqI0EXj?=
 =?us-ascii?Q?ebCwhPF7p4aBh6Z0lBVpbnCsPAwBEtjOIMJCOul7J/8UH1V6QoMZqlVApGA5?=
 =?us-ascii?Q?gdxkk+SFPIRzWQyavkZCgZQXGEvCginYy4ZcEafmMXqxjMoqOJ8emBQFDzrY?=
 =?us-ascii?Q?9pNFvyas5YmiPi4uFUUFnwKcKTt9jdQrs22aiHBZMG0cTANfYzbHQUtzO2Ll?=
 =?us-ascii?Q?uuGPPUwbxIWuU+fz8I8DDoBegxtkTyRFvDl5DeRRH5RrbAQX0QVFfdeYiruE?=
 =?us-ascii?Q?yLnX+aVA8+mA8shrw6M+B+7TjZvqOblTfPpEAC0aWlFt5n3G6DRAZQXrjx2m?=
 =?us-ascii?Q?HmGEUAVkC7dg2phJk/0b04Xqqjb3SQi7L0gqrs3GgDVM/JdWQxqmaNslspXy?=
 =?us-ascii?Q?AbAOx/8tSAKceRgN0dCs/mcIYOQjjZqI6Y69gmQPspK2bT0cGfLY2Mn3AjSB?=
 =?us-ascii?Q?3z1tBFYpxlQ+jDV//20wz6JfI1MPfdBzJWpu3DhTAjt4TShI36H3Ea+Nmb6d?=
 =?us-ascii?Q?/v2CHMRJM10yV+PMWlR12BOp/GfXUMYXr32hPV3Y7AaLLnolT+iSTfVaqjt9?=
 =?us-ascii?Q?iUVRPF7Nx1ArUC6d8T4ivPZBA55BjlUc/tr5M3CcxUa3MQSSeAham0/DVffY?=
 =?us-ascii?Q?ulpnhS41xZ1ZQGBgkPputEMFE5aXLnAkb9N3UdDJRgjGvT1d4UUwhIlzE0EW?=
 =?us-ascii?Q?fAx5pbyOTIqrMH9mP/PL60Wag+/mlUg1mTy68Ojr7I9VBAYSyFoKAVUq85++?=
 =?us-ascii?Q?1AmtWHi7ONlz3yM4mZGbV3R+XNQz6Rdsios70s0LUMT/s2LPBbVnAcyO2Dxr?=
 =?us-ascii?Q?MGZ9wlHB5xbM2k6svnAcoH8uvt69m7LxDo81YqADBQP6KDuUKokm2oNCeJTX?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e6faab-5b70-4cd3-47be-08dd13ba4503
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 16:48:10.1389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CTKadS/ekeg2AxxpQbTHSMz/OpLxXXz10iOTHleGTdhTvFswIBddjmi6pMuR/xxIdqxc4XoOjICKS6LQ4lwQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9551

The Felix DSA driver presents unique challenges that make the simplistic
ocelot PTP TX timestamping procedure unreliable: any transmitted packet
may be lost in hardware before it ever leaves our local system.

This may happen because there is congestion on the DSA conduit, the
switch CPU port or even user port (Qdiscs like taprio may delay packets
indefinitely by design).

The technical problem is that the kernel, i.e. ocelot_port_add_txtstamp_skb(),
runs out of timestamp IDs eventually, because it never detects that
packets are lost, and keeps the IDs of the lost packets on hold
indefinitely. The manifestation of the issue once the entire timestamp
ID range becomes busy looks like this in dmesg:

mscc_felix 0000:00:00.5: port 0 delivering skb without TX timestamp
mscc_felix 0000:00:00.5: port 1 delivering skb without TX timestamp

At the surface level, we need a timeout timer so that the kernel knows a
timestamp ID is available again. But there is a deeper problem with the
implementation, which is the monotonically increasing ocelot_port->ts_id.
In the presence of packet loss, it will be impossible to detect that and
reuse one of the holes created in the range of free timestamp IDs.

What we actually need is a bitmap of 63 timestamp IDs tracking which one
is available. That is able to use up holes caused by packet loss, but
also gives us a unique opportunity to not implement an actual timer_list
for the timeout timer (very complicated in terms of locking).

We could only declare a timestamp ID stale on demand (lazily), aka when
there's no other timestamp ID available. There are pros and cons to this
approach: the implementation is much more simple than per-packet timers
would be, but most of the stale packets would be quasi-leaked - not
really leaked, but blocked in driver memory, since this algorithm sees
no reason to free them.

An improved technique would be to check for stale timestamp IDs every
time we allocate a new one. Assuming a constant flux of PTP packets,
this avoids stale packets being blocked in memory, but of course,
packets lost at the end of the flux are still blocked until the flux
resumes (nobody left to kick them out).

Since implementing per-packet timers is way too complicated, this should
be good enough.

Testing procedure:

Persistently block traffic class 5 and try to run PTP on it:
$ tc qdisc replace dev swp3 parent root taprio num_tc 8 \
	map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
	base-time 0 sched-entry S 0xdf 100000 flags 0x2
[  126.948141] mscc_felix 0000:00:00.5: port 3 tc 5 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
$ ptp4l -i swp3 -2 -P -m --socket_priority 5 --fault_reset_interval ASAP --logSyncInterval -3
ptp4l[70.351]: port 1 (swp3): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[70.354]: port 0 (/var/run/ptp4l): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[70.358]: port 0 (/var/run/ptp4lro): INITIALIZING to LISTENING on INIT_COMPLETE
[   70.394583] mscc_felix 0000:00:00.5: port 3 timestamp id 0
ptp4l[70.406]: timed out while polling for tx timestamp
ptp4l[70.406]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[70.406]: port 1 (swp3): send peer delay response failed
ptp4l[70.407]: port 1 (swp3): clearing fault immediately
ptp4l[70.952]: port 1 (swp3): new foreign master d858d7.fffe.00ca6d-1
[   71.394858] mscc_felix 0000:00:00.5: port 3 timestamp id 1
ptp4l[71.400]: timed out while polling for tx timestamp
ptp4l[71.400]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[71.401]: port 1 (swp3): send peer delay response failed
ptp4l[71.401]: port 1 (swp3): clearing fault immediately
[   72.393616] mscc_felix 0000:00:00.5: port 3 timestamp id 2
ptp4l[72.401]: timed out while polling for tx timestamp
ptp4l[72.402]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[72.402]: port 1 (swp3): send peer delay response failed
ptp4l[72.402]: port 1 (swp3): clearing fault immediately
ptp4l[72.952]: port 1 (swp3): new foreign master d858d7.fffe.00ca6d-1
[   73.395291] mscc_felix 0000:00:00.5: port 3 timestamp id 3
ptp4l[73.400]: timed out while polling for tx timestamp
ptp4l[73.400]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[73.400]: port 1 (swp3): send peer delay response failed
ptp4l[73.400]: port 1 (swp3): clearing fault immediately
[   74.394282] mscc_felix 0000:00:00.5: port 3 timestamp id 4
ptp4l[74.400]: timed out while polling for tx timestamp
ptp4l[74.401]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[74.401]: port 1 (swp3): send peer delay response failed
ptp4l[74.401]: port 1 (swp3): clearing fault immediately
ptp4l[74.953]: port 1 (swp3): new foreign master d858d7.fffe.00ca6d-1
[   75.396830] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 0 which seems lost
[   75.405760] mscc_felix 0000:00:00.5: port 3 timestamp id 0
ptp4l[75.410]: timed out while polling for tx timestamp
ptp4l[75.411]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[75.411]: port 1 (swp3): send peer delay response failed
ptp4l[75.411]: port 1 (swp3): clearing fault immediately
(...)

Remove the blocking condition and see that the port recovers:
$ same tc command as above, but use "sched-entry S 0xff" instead
$ same ptp4l command as above
ptp4l[99.489]: port 1 (swp3): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[99.490]: port 0 (/var/run/ptp4l): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[99.492]: port 0 (/var/run/ptp4lro): INITIALIZING to LISTENING on INIT_COMPLETE
[  100.403768] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 0 which seems lost
[  100.412545] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 1 which seems lost
[  100.421283] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 2 which seems lost
[  100.430015] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 3 which seems lost
[  100.438744] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 4 which seems lost
[  100.447470] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  100.505919] mscc_felix 0000:00:00.5: port 3 timestamp id 0
ptp4l[100.963]: port 1 (swp3): new foreign master d858d7.fffe.00ca6d-1
[  101.405077] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  101.507953] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  102.405405] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  102.509391] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  103.406003] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  103.510011] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  104.405601] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  104.510624] mscc_felix 0000:00:00.5: port 3 timestamp id 0
ptp4l[104.965]: selected best master clock d858d7.fffe.00ca6d
ptp4l[104.966]: port 1 (swp3): assuming the grand master role
ptp4l[104.967]: port 1 (swp3): LISTENING to GRAND_MASTER on RS_GRAND_MASTER
[  105.106201] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.232420] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.359001] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.405500] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.485356] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.511220] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.610938] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.737237] mscc_felix 0000:00:00.5: port 3 timestamp id 0
(...)

Notice that in this new usage pattern, a non-congested port should
basically use timestamp ID 0 all the time, progressing to higher numbers
only if there are unacknowledged timestamps in flight. Compare this to
the old usage, where the timestamp ID used to monotonically increase
modulo OCELOT_MAX_PTP_ID.

In terms of implementation, this simplifies the bookkeeping of the
ocelot_port :: ts_id and ptp_skbs_in_flight. Since we need to traverse
the list of two-step timestampable skbs for each new packet anyway, the
information can already be computed and does not need to be stored.
Also, ocelot_port->tx_skbs is always accessed under the switch-wide
ocelot->ts_id_lock IRQ-unsafe spinlock, so we don't need the skb queue's
lock and can use the unlocked primitives safely.

This problem was actually detected using the tc-taprio offload, and is
causing trouble in TSN scenarios, which Felix (NXP LS1028A / VSC9959)
supports but Ocelot (VSC7514) does not. Thus, I've selected the commit
to blame as the one adding initial timestamping support for the Felix
switch.

Fixes: c0bcf537667c ("net: dsa: ocelot: add hardware timestamping support for Felix")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_ptp.c | 140 +++++++++++++++----------
 include/linux/dsa/ocelot.h             |   1 +
 include/soc/mscc/ocelot.h              |   2 -
 3 files changed, 83 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index e172638b0601..5b7cc1d80a1d 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -14,6 +14,8 @@
 #include <soc/mscc/ocelot.h>
 #include "ocelot.h"
 
+#define OCELOT_PTP_TX_TSTAMP_TIMEOUT		(5 * HZ)
+
 int ocelot_ptp_gettime64(struct ptp_clock_info *ptp, struct timespec64 *ts)
 {
 	struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
@@ -603,35 +605,89 @@ int ocelot_get_ts_info(struct ocelot *ocelot, int port,
 }
 EXPORT_SYMBOL(ocelot_get_ts_info);
 
-static int ocelot_port_add_txtstamp_skb(struct ocelot *ocelot, int port,
+static struct sk_buff *ocelot_port_dequeue_ptp_tx_skb(struct ocelot *ocelot,
+						      int port, u8 ts_id,
+						      u32 seqid)
+{
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
+	struct ptp_header *hdr;
+
+	spin_lock(&ocelot->ts_id_lock);
+
+	skb_queue_walk_safe(&ocelot_port->tx_skbs, skb, skb_tmp) {
+		if (OCELOT_SKB_CB(skb)->ts_id != ts_id)
+			continue;
+
+		/* Check that the timestamp ID is for the expected PTP
+		 * sequenceId. We don't have to test ptp_parse_header() against
+		 * NULL, because we've pre-validated the packet's ptp_class.
+		 */
+		hdr = ptp_parse_header(skb, OCELOT_SKB_CB(skb)->ptp_class);
+		if (seqid != ntohs(hdr->sequence_id))
+			continue;
+
+		__skb_unlink(skb, &ocelot_port->tx_skbs);
+		ocelot->ptp_skbs_in_flight--;
+		skb_match = skb;
+		break;
+	}
+
+	spin_unlock(&ocelot->ts_id_lock);
+
+	return skb_match;
+}
+
+static int ocelot_port_queue_ptp_tx_skb(struct ocelot *ocelot, int port,
 					struct sk_buff *clone)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	DECLARE_BITMAP(ts_id_in_flight, OCELOT_MAX_PTP_ID);
+	struct sk_buff *skb, *skb_tmp;
 	unsigned long flags;
+	unsigned long n;
 
 	spin_lock_irqsave(&ocelot->ts_id_lock, flags);
 
-	if (ocelot_port->ptp_skbs_in_flight == OCELOT_MAX_PTP_ID ||
-	    ocelot->ptp_skbs_in_flight == OCELOT_PTP_FIFO_SIZE) {
+	/* To get a better chance of acquiring a timestamp ID, first flush the
+	 * stale packets still waiting in the TX timestamping queue. They are
+	 * probably lost.
+	 */
+	skb_queue_walk_safe(&ocelot_port->tx_skbs, skb, skb_tmp) {
+		if (time_before(OCELOT_SKB_CB(skb)->ptp_tx_time +
+				OCELOT_PTP_TX_TSTAMP_TIMEOUT, jiffies)) {
+			dev_warn_ratelimited(ocelot->dev,
+					     "port %d invalidating stale timestamp ID %u which seems lost\n",
+					     port, OCELOT_SKB_CB(skb)->ts_id);
+			__skb_unlink(skb, &ocelot_port->tx_skbs);
+			dev_kfree_skb_any(skb);
+			ocelot->ptp_skbs_in_flight--;
+		} else {
+			__set_bit(OCELOT_SKB_CB(skb)->ts_id, ts_id_in_flight);
+		}
+	}
+
+	if (ocelot->ptp_skbs_in_flight == OCELOT_PTP_FIFO_SIZE) {
 		spin_unlock_irqrestore(&ocelot->ts_id_lock, flags);
 		return -EBUSY;
 	}
 
-	skb_shinfo(clone)->tx_flags |= SKBTX_IN_PROGRESS;
-	/* Store timestamp ID in OCELOT_SKB_CB(clone)->ts_id */
-	OCELOT_SKB_CB(clone)->ts_id = ocelot_port->ts_id;
-
-	ocelot_port->ts_id++;
-	if (ocelot_port->ts_id == OCELOT_MAX_PTP_ID)
-		ocelot_port->ts_id = 0;
+	n = find_first_zero_bit(ts_id_in_flight, OCELOT_MAX_PTP_ID);
+	if (n == OCELOT_MAX_PTP_ID) {
+		spin_unlock_irqrestore(&ocelot->ts_id_lock, flags);
+		return -EBUSY;
+	}
 
-	ocelot_port->ptp_skbs_in_flight++;
+	/* Found an available timestamp ID, use it */
+	OCELOT_SKB_CB(clone)->ts_id = n;
+	OCELOT_SKB_CB(clone)->ptp_tx_time = jiffies;
 	ocelot->ptp_skbs_in_flight++;
-
-	skb_queue_tail(&ocelot_port->tx_skbs, clone);
+	__skb_queue_tail(&ocelot_port->tx_skbs, clone);
 
 	spin_unlock_irqrestore(&ocelot->ts_id_lock, flags);
 
+	dev_dbg_ratelimited(ocelot->dev, "port %d timestamp id %lu\n", port, n);
+
 	return 0;
 }
 
@@ -687,10 +743,12 @@ int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
 		if (!(*clone))
 			return -ENOMEM;
 
-		err = ocelot_port_add_txtstamp_skb(ocelot, port, *clone);
+		/* Store timestamp ID in OCELOT_SKB_CB(clone)->ts_id */
+		err = ocelot_port_queue_ptp_tx_skb(ocelot, port, *clone);
 		if (err)
 			return err;
 
+		skb_shinfo(*clone)->tx_flags |= SKBTX_IN_PROGRESS;
 		OCELOT_SKB_CB(skb)->ptp_cmd = ptp_cmd;
 		OCELOT_SKB_CB(*clone)->ptp_class = ptp_class;
 	}
@@ -726,28 +784,15 @@ static void ocelot_get_hwtimestamp(struct ocelot *ocelot,
 	spin_unlock_irqrestore(&ocelot->ptp_clock_lock, flags);
 }
 
-static bool ocelot_validate_ptp_skb(struct sk_buff *clone, u16 seqid)
-{
-	struct ptp_header *hdr;
-
-	hdr = ptp_parse_header(clone, OCELOT_SKB_CB(clone)->ptp_class);
-	if (WARN_ON(!hdr))
-		return false;
-
-	return seqid == ntohs(hdr->sequence_id);
-}
-
 void ocelot_get_txtstamp(struct ocelot *ocelot)
 {
 	int budget = OCELOT_PTP_QUEUE_SZ;
 
 	while (budget--) {
-		struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
 		struct skb_shared_hwtstamps shhwtstamps;
 		u32 val, id, seqid, txport;
-		struct ocelot_port *port;
+		struct sk_buff *skb_match;
 		struct timespec64 ts;
-		unsigned long flags;
 
 		val = ocelot_read(ocelot, SYS_PTP_STATUS);
 
@@ -762,36 +807,15 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		txport = SYS_PTP_STATUS_PTP_MESS_TXPORT_X(val);
 		seqid = SYS_PTP_STATUS_PTP_MESS_SEQ_ID(val);
 
-		port = ocelot->ports[txport];
-
-		spin_lock(&ocelot->ts_id_lock);
-		port->ptp_skbs_in_flight--;
-		ocelot->ptp_skbs_in_flight--;
-		spin_unlock(&ocelot->ts_id_lock);
-
 		/* Retrieve its associated skb */
-try_again:
-		spin_lock_irqsave(&port->tx_skbs.lock, flags);
-
-		skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
-			if (OCELOT_SKB_CB(skb)->ts_id != id)
-				continue;
-			__skb_unlink(skb, &port->tx_skbs);
-			skb_match = skb;
-			break;
-		}
-
-		spin_unlock_irqrestore(&port->tx_skbs.lock, flags);
-
-		if (WARN_ON(!skb_match))
-			continue;
-
-		if (!ocelot_validate_ptp_skb(skb_match, seqid)) {
-			dev_err_ratelimited(ocelot->dev,
-					    "port %d received stale TX timestamp for seqid %d, discarding\n",
-					    txport, seqid);
-			dev_kfree_skb_any(skb);
-			goto try_again;
+		skb_match = ocelot_port_dequeue_ptp_tx_skb(ocelot, txport, id,
+							   seqid);
+		if (!skb_match) {
+			dev_warn_ratelimited(ocelot->dev,
+					     "port %d received TX timestamp (seqid %d, ts id %u) for packet previously declared stale\n",
+					     txport, seqid, id);
+			dev_kfree_skb_any(skb_match);
+			goto next_ts;
 		}
 
 		/* Get the h/w timestamp */
@@ -802,7 +826,7 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		shhwtstamps.hwtstamp = ktime_set(ts.tv_sec, ts.tv_nsec);
 		skb_complete_tx_timestamp(skb_match, &shhwtstamps);
 
-		/* Next ts */
+next_ts:
 		ocelot_write(ocelot, SYS_PTP_NXT_PTP_NXT, SYS_PTP_NXT);
 	}
 }
diff --git a/include/linux/dsa/ocelot.h b/include/linux/dsa/ocelot.h
index 6fbfbde68a37..620a3260fc08 100644
--- a/include/linux/dsa/ocelot.h
+++ b/include/linux/dsa/ocelot.h
@@ -15,6 +15,7 @@
 struct ocelot_skb_cb {
 	struct sk_buff *clone;
 	unsigned int ptp_class; /* valid only for clones */
+	unsigned long ptp_tx_time; /* valid only for clones */
 	u32 tstamp_lo;
 	u8 ptp_cmd;
 	u8 ts_id;
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 462c653e1017..2db9ae0575b6 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -778,7 +778,6 @@ struct ocelot_port {
 
 	phy_interface_t			phy_mode;
 
-	unsigned int			ptp_skbs_in_flight;
 	struct sk_buff_head		tx_skbs;
 
 	unsigned int			trap_proto;
@@ -786,7 +785,6 @@ struct ocelot_port {
 	u16				mrp_ring_id;
 
 	u8				ptp_cmd;
-	u8				ts_id;
 
 	u8				index;
 
-- 
2.43.0


