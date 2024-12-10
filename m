Return-Path: <netdev+bounces-150652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3B99EB1DB
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9558168A86
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6D71A3BC0;
	Tue, 10 Dec 2024 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dBKiOEa8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2060.outbound.protection.outlook.com [40.107.103.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891F1E52D
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837220; cv=fail; b=idYmFhI2xderIXp4FLMl2FBdluJAfxNxWEsLEki2V8K8ZmR50jZNpdYCj9V4AAiwB8QBVVsEdQRQnyqvV4JB3K9B1LTU+USbnO6t46kHoxrhTy3trN6mMtTaaEPgiXfoqBLxP+YqsFmTNDpmtCYF6veKcefyujltRjY4+UVvvLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837220; c=relaxed/simple;
	bh=JgparR+gLt4H0SCjbK5G9IwF1U/srB6m6InzAnYDjkA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m0YfBuX7ySeOcnw/vqcQVXFt85ZKEBbKQQlLBHvwq+g79pA7QJoy8Ea3ATa8O2ejlgFS/la11FHJ0Y8MtINkAQKxwI1874aG2pu6tTCuyLwv2FLTBHgSgvPyPuySsbbijxHvXpePp4+U57Qk9ZjcOFW0dFWSEcObzCAeFneKNhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dBKiOEa8; arc=fail smtp.client-ip=40.107.103.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRJ4TLQXFFDlA/3Qb7iMmWvNPo04rpxBwQGbV7oVEZhSH2JwpaVnY8DnQP2gs17UqZgLLQleMHFyvYx4PXdAANm1KLJR3RvrJZ/quXJdI5dIa9hhd40wHpOlk9UsqmrnFpIb2MWkSE/4o/VXrbwsD78dRXAiXTyuDMJ0Ikv3OqPQoHLvY758fnUnTX91LWkVsRO1OVa//l1cSznH+eO2WoxRxdWL9aJjmxEYumnhjWMR2zgPfa8xLB5qKrw7B/MOtcEJo14a5ro+JlUwVNcpiXEVgGXfWEl28fAsXwnxW1t0KFtli/izSu7AkWCWNZEG1a27nQsX9CEZP4w7ydH8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ+54rt0Gk4f3/o8zCmMqR7AoF64yUUG3mhVHG4TL4k=;
 b=XJoCgWBJw7smZcaZCs+sr3M7eZ+xo93Jm0xC6bWQUHamZ1JzPzX8iDMisE3KUvu+ajve9NktbnAQ2s6z8Zru9VsuSZZJd0AVe99b6EVlpuFk817MgFNbBOF95+9nFgSPgLMNvB7MI65DEydtg/InxEwC1RGbL9UKeeveIhZszWbHC7AEszgKJX1qYDFnpFInwJAbGIKK0iCiVMTANF6YWJxDBzPU2ZGtXEOXRlvlJLRIkklFZQo4M0x3SavaCrea6/aDNN+NWn12NBj/VsDXuvamTXRldhY6Sm+cPBAVncpulL9IQWhJviehRmULlJfUtFLnlcq8/gSTD8tvg7XmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ+54rt0Gk4f3/o8zCmMqR7AoF64yUUG3mhVHG4TL4k=;
 b=dBKiOEa8MRtvOG1y0BOAPZUhKTFarUjZVraZ0V5vIm7/Y3ExjVqK1+beVs3xMKeYSpLYojBv1IaB0obiMTvrxLhmywOOjA9ugrqAkPygpl5PwxgiRk1AJn5wkMDYqOrZiHz9Bc5CVJK/fbIW1/3mDDsZTlVOhoJBO5sSEzNEFtl6nChP3lIOvHTg+J/i7aBu0V++tTpYy9PaxbR2f39mHPr05qlHKDqNWHUHLVarMHNYDgQ+EDr4ZOU61DOzPVEyrWNzZMKLBpgtmj69pfcTcUTRLTiQlCnCRqqqvWFf3dLoCndcrjV/287xnyTWN86PwgCdiFFHdgO9xIMISk09ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB7158.eurprd04.prod.outlook.com (2603:10a6:20b:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 13:26:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 13:26:53 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Radu Bulie <radu-andrei.bulie@nxp.com>,
	Michael Walle <michael@walle.cc>
Subject: [PATCH net] net: dsa: felix: fix stuck CPU-injected packets with short taprio windows
Date: Tue, 10 Dec 2024 15:26:40 +0200
Message-ID: <20241210132640.3426788-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c9a9ab-1201-4750-51b1-08dd191e4fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ly53kqwWoegwPtGGtmCjoMNvPCMuN8JGnJzdGbseGQkg0eGWXDvHKV4SN4Y8?=
 =?us-ascii?Q?RX8+jLGVFLwJJ5wF2fGJQSXOYuOb0OVXmMjwHtXppzYOhnWGZa9cPI8ezMNO?=
 =?us-ascii?Q?D/UL2i3U6sKsg3WGhvxxZUbP8rd38M9tG3c5Bh/7qbqTe2kFJL7r0RPRFgbh?=
 =?us-ascii?Q?/Zln34ecVEuHQI71ArWWgWAj+xiq8daDiwszz4TTCb021pKKDdNlM0m9cTHN?=
 =?us-ascii?Q?mLWKN6CGoJaFw83OJYC4b03R18IneYtalk/XKx4Y9HtF7GLzEHheDyy2+7kX?=
 =?us-ascii?Q?7jFYfRySYaVfBVXCCXKJqAF0JzMUSgEwbQ2ZZ0BpTZMFYPqCpjyoZjdebD1c?=
 =?us-ascii?Q?cqqOAxAwihneNLt5M9Y+GaLAplyyU2IRCQKYs9oWumPhCOVp87pUAHxBxrL/?=
 =?us-ascii?Q?An3HRdpYcI7B2P1BzE6FHg89uz/QzncNBt9Ox9JAyvU1PAarPkn/zBuly2Lu?=
 =?us-ascii?Q?aosBwgXtgZlzEtBlk9iRXFs1JB7I0cCqS5uEW2l03FPtWCIlrJlGUm0SJSLN?=
 =?us-ascii?Q?36u9ErAeE1d5xkoePatGsGTszLykAZRIzuC+I1OF3EwvT0TkSSyAb+fJiy54?=
 =?us-ascii?Q?1uRHHutE74C5VpZELN9D3mXhybPlg1IPj97fYZmUPEHT3YIzQU+98jZJMhrK?=
 =?us-ascii?Q?1cQf50FbDRoBTjZN5vE92pqQnCyQWAyttHBdqlR0HpmHHnPKGFFJ2RZY15c6?=
 =?us-ascii?Q?PB2e2AA1N8MBRXfGZ1MpJ5q2rlbLuFPQLnJWFgYDD39w31GGwtOAUwVg0LsJ?=
 =?us-ascii?Q?uUtKysEegPzGYv7zviAMSV29bgQA11p2kc6J31kj86zLTbgOxUyT5BpJK8sW?=
 =?us-ascii?Q?pQUPz6WjLNjuPxVJ05RGkAoimJnLhg/nfD3hbRSJGeu5/nYpXQZos31bktT9?=
 =?us-ascii?Q?Rsrux8o2c7wKLDcRYR7X7qHtQtUG2g4vRmnH8eOY8au4u0uQpEWaWxXZqK8X?=
 =?us-ascii?Q?L3SrYD9Kzk/BqNAOIQE9bvBjxvfWk13XCEmhSPYkH4QwussYiURwKv+v15h4?=
 =?us-ascii?Q?GxHp+hmNFZCyBQulSWWfsCfr9077J6UoSLZBzfZta2Aijb4lwF3RSzww7EBv?=
 =?us-ascii?Q?9y+JZsZg/RWliJ/yYRsWvK56OLD1UkVL6ZxvqU6SMlEQH8vxcqlfzBg8NOci?=
 =?us-ascii?Q?9+eHiciYf4cBnq5dx/zYeXxQvDR5guU5fV+5IYuhrcd6Z+G1SryUt8YqbBFg?=
 =?us-ascii?Q?jcVqwEnbFYYfJpv0D2GmsNtdRYRT2KYgUfKhwwwPD5R+MiS9jVhOwGjO5XbV?=
 =?us-ascii?Q?mUCNnvzMo5BCRlRQBpGYK1Zj1hsdiKLtrd79rFQmbKBYbNjfxvgAoyZFy1YK?=
 =?us-ascii?Q?CZBBbSAudVzNxZrvzuDdLlwPvQog5qymiCX/DxVgb8bFRz3Sauuc7Ov5Hkyg?=
 =?us-ascii?Q?bze/jfnc4NMibQvfJazuBnnRO4BXxBZfBtRm2dx029DCo3vQVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fZ/Fk6WFfboCQDS+MQw101OGzeSliPnWnDQhqZCgkbIq8PwDkqdEDCHuJn8c?=
 =?us-ascii?Q?4vblBa5Lwq0S8QpT7IDBxE+rkeUydJUnhFEHI+jwdd6C3ovWW3S2MvzwysZf?=
 =?us-ascii?Q?PCsTJPqGXKq0iO1TuWPOCRB3ZOzpZNM7gJeCC/mE8rFhDKlX2T8c6SPds6BP?=
 =?us-ascii?Q?1mqiY/2i0cFNPP5ybMB7t5i61UVvFI70lehzgGV8xiiJGtiye9JDGh7m8MJQ?=
 =?us-ascii?Q?Od/xiyg60xMxqtMfCVh6P20vLcKgcIJw0cxP2/y/ckPWOYVEQ4F9bY6mexcP?=
 =?us-ascii?Q?UynKYEU1+XnDftHMSyMj7tBwN+qVmVbKAiPkn2Z/UxuI/0yqkiVu0uPmR86n?=
 =?us-ascii?Q?nwI7sl8QBEUo9U7BGAtlzcbqJtNDyYmhaiCi4Wd2/qGYFd/7ueSpbAdBocTZ?=
 =?us-ascii?Q?+ggGKVmUdYhr3MQXvmYtSa4zk6woebt8blRE4RtopUg3WhL0zHcDMIaqPYuD?=
 =?us-ascii?Q?UMATcLc3ghMsbHM/cqvm7RY0T1YLF8RvRnnYLwwjluGGbfQZTRaPdaqIHaoY?=
 =?us-ascii?Q?DQ1KycXCZ79eS4NVJ+ebf5J/sbno9Qeiw82+bIkEVnSGwO+rV36Yh8HS9htI?=
 =?us-ascii?Q?R42MD7af2apTIcVcOcdcznKCeXxgu3iF9vKrM00HbH9PbZllS131UOYJj5ZC?=
 =?us-ascii?Q?CJuatKdATkteLtKUsymhiMdKIQjaWoBTX/qHRvxaKZ2A05k9VUfVo4reFHC4?=
 =?us-ascii?Q?Iw+ERK9O/bfUx/ElsVHzJ6kiPUXB6c8mp12hvp0KXhr34POuK8KiaZzzaaAi?=
 =?us-ascii?Q?w+ym/PFAIvxfPbka+BSBBx2ctTvwXG2jmmE2JrMLtiZqSki6RpQks82oZOK9?=
 =?us-ascii?Q?TB5ErxbfPMKBRrK1rfpFsxa6Xn4LkEh87Zsoq+VNnTVvLJlHhRqFemCT0RcO?=
 =?us-ascii?Q?Vb8/HFh2f63hRcjzBPuArAyAfVkxa0d9Tw7S4FZQEqpNOD2/EhFZmnZvtIRZ?=
 =?us-ascii?Q?KsjaPDbMg343YRKRHTmZY0yXwpbLRK/Lp8gDurE8JG3KKF+lldzPjajUCOiR?=
 =?us-ascii?Q?lSdRsWB24gONRn6DPtZw6i85qtvFdjvH2KvLROPAqqbERbf4tzFQlYdLr6vf?=
 =?us-ascii?Q?sGozyi4X6k7XaEo7WnhbvsherPeGFrwSDupaKf/wl/MAbVFFV7kUwdpLtO5N?=
 =?us-ascii?Q?XHGrK0LfatifvhZvLYYw86EeDj5uQYI9VOE05gL8tuLKDrgtYjOufgaHe3/C?=
 =?us-ascii?Q?whInF+bFzSwG7lr/cItMJpEcgqByxUKL4M7HHNt8A5d+YVASI1urvYiRrb0b?=
 =?us-ascii?Q?vjwvXncoYoWQO+TVmTYUnCFU5qu+kFHtq2TY45XQOVhGVqPiZ8A76FFxKP8t?=
 =?us-ascii?Q?FDucFzMIjTKYbbH6putGxKOuRcF4IPvBT7as5bEYkEdLE6RcYx1+5Ro7/6Go?=
 =?us-ascii?Q?/uu74vlIGeKM9vCZZSAXfkeYkF1L33Zn42QzXCpTpvkLxeQUQGZcT/8kCo0k?=
 =?us-ascii?Q?jpcC4FopIZRkJP0x4duWCrDEx4jjzyLMBYg2hAS1O8tmCrbV02U8Sf+kVkeQ?=
 =?us-ascii?Q?/7lNgcnbXhsyyuIxmhOhBgm/N5RYW8YOtbidbl/Qj6sGlIgThD9hlTsDhSw4?=
 =?us-ascii?Q?vYic8OL2TfBfuuzffSK9G55AUtfEtkgYT+g/sYgBsLGt5bz3lLBQKZOurYJM?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c9a9ab-1201-4750-51b1-08dd191e4fa0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 13:26:53.4612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDK/X5i72GAiQmhpQaF4Lbg6iw7g3KjNGe6xQDmcr/LTYMDycziLoduUB25z3PiMPerVpK/W0WAV2JLqeLV/dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7158

With this port schedule:

tc qdisc replace dev $send_if parent root handle 100 taprio \
	num_tc 8 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
	map 0 1 2 3 4 5 6 7 \
	base-time 0 cycle-time 10000 \
	sched-entry S 01 1250 \
	sched-entry S 02 1250 \
	sched-entry S 04 1250 \
	sched-entry S 08 1250 \
	sched-entry S 10 1250 \
	sched-entry S 20 1250 \
	sched-entry S 40 1250 \
	sched-entry S 80 1250 \
	flags 2

ptp4l would fail to take TX timestamps of Pdelay_Resp messages like this:

increasing tx_timestamp_timeout may correct this issue, but it is likely caused by a driver bug
ptp4l[4134.168]: port 2: send peer delay response failed

It turns out that the driver can't take their TX timestamps because it
can't transmit them in the first place. And there's nothing special
about the Pdelay_Resp packets - they're just regular 68 byte packets.
But with this taprio configuration, the switch would refuse to send even
the ETH_ZLEN minimum packet size.

This should have definitely not been the case. When applying the taprio
config, the driver prints:

mscc_felix 0000:00:00.5: port 0 tc 0 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 1 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 2 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 3 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 4 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 5 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 6 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 7 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS

and thus, everything under 132 bytes - ETH_FCS_LEN should have been sent
without problems. Yet it's not.

For the forwarding path, the configuration is fine, yet packets injected
from Linux get stuck with this schedule no matter what.

The first hint that the static guard bands are the cause of the problem
is that reverting Michael Walle's commit 297c4de6f780 ("net: dsa: felix:
re-enable TAS guard band mode") made things work. It must be that the
guard bands are calculated incorrectly.

I remembered that there is a magic constant in the driver, set to 33 ns
for no logical reason other than experimentation, which says "never let
the static guard bands get so large as to leave less than this amount of
remaining space in the time slot, because the queue system will refuse
to schedule packets otherwise, and they will get stuck". I had a hunch
that my previous experimentally-determined value was only good for
packets coming from the forwarding path, and that the CPU injection path
needed more.

I came to the new value of 35 ns through binary search, after seeing
that with 544 ns (the bit time required to send the Pdelay_Resp packet
at gigabit) it works. Again, this is purely experimental, there's no
logic and the manual doesn't say anything.

The new driver prints for this schedule look like this:

mscc_felix 0000:00:00.5: port 0 tc 0 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 1 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 2 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 3 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 4 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 5 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 6 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 7 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS

So yes, the maximum MTU is now even smaller by 1 byte than before.
This is maybe counter-intuitive, but makes more sense with a diagram of
one time slot.

Before:

 Gate open                                   Gate close
 |                                                    |
 v           1250 ns total time slot duration         v
 <---------------------------------------------------->
 <----><---------------------------------------------->
  33 ns            1217 ns static guard band
  useful

 Gate open                                   Gate close
 |                                                    |
 v           1250 ns total time slot duration         v
 <---------------------------------------------------->
 <-----><--------------------------------------------->
  35 ns            1215 ns static guard band
  useful

The static guard band implemented by this switch hardware directly
determines the maximum allowable MTU for that traffic class. The larger
it is, the earlier the switch will stop scheduling frames for
transmission, because otherwise they might overrun the gate close time
(and avoiding that is the entire purpose of Michael's patch).
So, we now have guard bands smaller by 2 ns, thus, in this particular
case, we lose a byte of the maximum MTU.

Fixes: 11afdc6526de ("net: dsa: felix: tc-taprio intervals smaller than MTU should send at least one packet")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 0102a82e88cc..940f1b71226d 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -24,7 +24,7 @@
 #define VSC9959_NUM_PORTS		6
 
 #define VSC9959_TAS_GCL_ENTRY_MAX	63
-#define VSC9959_TAS_MIN_GATE_LEN_NS	33
+#define VSC9959_TAS_MIN_GATE_LEN_NS	35
 #define VSC9959_VCAP_POLICER_BASE	63
 #define VSC9959_VCAP_POLICER_MAX	383
 #define VSC9959_SWITCH_PCI_BAR		4
@@ -1056,11 +1056,15 @@ static void vsc9959_mdio_bus_free(struct ocelot *ocelot)
 	mdiobus_free(felix->imdio);
 }
 
-/* The switch considers any frame (regardless of size) as eligible for
- * transmission if the traffic class gate is open for at least 33 ns.
+/* The switch considers any frame (regardless of size) as eligible
+ * for transmission if the traffic class gate is open for at least
+ * VSC9959_TAS_MIN_GATE_LEN_NS.
+ *
  * Overruns are prevented by cropping an interval at the end of the gate time
- * slot for which egress scheduling is blocked, but we need to still keep 33 ns
- * available for one packet to be transmitted, otherwise the port tc will hang.
+ * slot for which egress scheduling is blocked, but we need to still keep
+ * VSC9959_TAS_MIN_GATE_LEN_NS available for one packet to be transmitted,
+ * otherwise the port tc will hang.
+ *
  * This function returns the size of a gate interval that remains available for
  * setting the guard band, after reserving the space for one egress frame.
  */
@@ -1303,7 +1307,8 @@ static void vsc9959_tas_guard_bands_update(struct ocelot *ocelot, int port)
 			 * per-tc static guard band lengths, so it reduces the
 			 * useful gate interval length. Therefore, be careful
 			 * to calculate a guard band (and therefore max_sdu)
-			 * that still leaves 33 ns available in the time slot.
+			 * that still leaves VSC9959_TAS_MIN_GATE_LEN_NS
+			 * available in the time slot.
 			 */
 			max_sdu = div_u64(remaining_gate_len_ps, picos_per_byte);
 			/* A TC gate may be completely closed, which is a
-- 
2.43.0


