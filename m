Return-Path: <netdev+bounces-256127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEqeGGiGgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:23:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A331DD49DA
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED3C308563B
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D04A36605F;
	Tue,  3 Feb 2026 05:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eaLeGKZ6"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44C366062;
	Tue,  3 Feb 2026 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096140; cv=fail; b=uGtbhAkqhCWyLlnT/NEVNbHTCD167uxJ+SFE25iTZcMMGZnfxPehl3km9FGoX/wi+pPQraUaJthgLBo1bijeaOQ6Z4EDUQ+t+JcGLTH0BgMI76e/fzJ8OtMTZTUEkQIoKNwXfO43Z7owiQcEa1SBlPZbnVOneE0YkhjCjoswZEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096140; c=relaxed/simple;
	bh=sqCQ38mGvAMm6ZOOuyOISPSSYRQjiNHIlquukVrdb9k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iTRp38Oa4rPMz1mpMkkcPKRR9JmNrrjcVKhZiAAl9A5rqicE1gPiqL/NIDyfgPif3rvVQtzkiEpVkxog07z92/qt87NY6NmmDGqs9b8nlKd2mnx0zD0g0NryWj9u9w9MxboCmuDBJ8OitgV/w2SeIl2RJ9n7bnAT4gXqowrXJrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eaLeGKZ6; arc=fail smtp.client-ip=52.101.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6jFVHEwrS4CNNMAilRM7aH+NxbOs6HjmuP8tqvaAofrFLP9yFQ+0lYL2YrC/YbhjxUFWts54VkDYpOiDtnM6M14mMfiwAOn31FcWZTTscYLDNL08cSpZsLf+P4ZDvR7dXGcHME+ybKoPwZN3j9MdcKVGeyRl38ScjuFb/BuI0pQkL1a42fXuHT5dxWBOAyGwhT8z/5Gx1QOxtnWtyk7bONF8zWYtwmPJvp55HTdudrIZwSeIMO57+R1NiC88EgDUZo1rI8nXKpcHZsTHmvspwabQ91qsiQn45Y7CpgVUDOnUgBRnMJs7lYQ09AF9mXvKOoZWnmz2qV21EhjwubLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apgnsNs0IiS1sAbQEaFWCVosLjHtw7Tg0qaH5O0Srdk=;
 b=g3JfI1mjP/WcEXaDR+yu/TQK76/7pmNvNqRMi8mWlu3ro0NXQNhL1pN5G4gWX9FIT7OaVQFMiCalPagi6lt2ouukqEMOFdJky+Fbf6TefXnImdhvya94lo7QESaEgpkyTkGXgR+eDk4f4GIo6apCM1+Qy0eri0gbDCfGAqvwIp3kF5KhsCj0dmf9iKoPJXq/BuQCTGP0llpdM+qeouvT6W9U4ahvp5k21S56Cq5zgmDjQubUXpIggO71jLp6BZZfOo65J1vvQg5Scniy8cOBTkV+xlEtB2cgWCtkbPCM3vKb8DOUrP4BKz7hvf/nJrdfN3UHqnRpgBnCVdhWp/8C7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apgnsNs0IiS1sAbQEaFWCVosLjHtw7Tg0qaH5O0Srdk=;
 b=eaLeGKZ6lk1N43znxX8mvkK2+R1ukTrOhV0CuF0Jgc4NiUabsm2MVAxuUyZwKRFM9VZKh3xZmskxxwqnMKpHHModnX5+1msu6meySrmKz8g+lMF7VWlKKk/xGxU3h8XDs5xg1fhkdCD1jAqKXvl1QfcfzY7ZalDSrocnIpTFR5vtYXN5VlwQ56KUgpRfi5wt+4IT9TfbEhYymsBc6bIua+49lqFwaBAkBksrupcUOfwyTSbzcD61MO+90jZ6lADXyBzlH0DUmyclIg3SZEXIAHaGLs5kyT+Gg9Kmrail8s5r0obtid4Mjuzihx/uDCO0yj54lWLZTEQy2VtoBn388A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:22:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:22:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v6 net-next 00/15] net: fec: improve XDP copy mode and add AF_XDP zero-copy support
Date: Tue,  3 Feb 2026 13:23:14 +0800
Message-Id: <20260203052329.1085444-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 755c7131-66e5-4ed8-f8db-08de62e4310c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1hqanq7T7iYGnfuqw+m33IljQEYokhL2Te6jPhk6jziZDguxES++YJ985CVU?=
 =?us-ascii?Q?N5Ey51zi9HMHBecnXD4Qa8I30W96fhlQBNg7VEIFgshj6oWkzvFqO8otZtEm?=
 =?us-ascii?Q?YQv1OxmZy1Io/Hy52YGVCNeXVJX+id5eyZGOxUc48+UO2Pj2aJ7k4E/JVPaX?=
 =?us-ascii?Q?unp0B1RqPdIm4SaGr2jJNsBhoHmUfaLWT95UlZl/E/Ck4nV1M1gVzkxQx6OQ?=
 =?us-ascii?Q?I9IyRfnLadubYUSCasbDTcnu0H/AKog5llnCM7tELmStotSoDJ46lIP9V8z3?=
 =?us-ascii?Q?gpiajO4xDlcaS7XqDY8ESI4KTKr34kLUNAeC7w85YW9q+NTLqjc+wmd8v4OK?=
 =?us-ascii?Q?GUm4/1Efp6kwYAXVsAih5GFvccicbqABRfzP9+Tr05JJXjEQ8SxjJvvxpJIl?=
 =?us-ascii?Q?Y9MB+U6SjIPb5+Brc5NpNHA1vkenSDnV/5Mxa0vYVRvaAMeByjoVWNtxMbuA?=
 =?us-ascii?Q?KI3BGJKuW+pYHtqnYzNddMOA4Tl1p0ikpPuxFN5KIDOoI5v5pasPUrlVj7w1?=
 =?us-ascii?Q?z8CO4u32JJo73b03CqkPJINMIEu+Zqw5w/wO1mBje7orlkvRYQUDRd0WjZJP?=
 =?us-ascii?Q?QdC4iom0du9VBwZ86NtHyKkgIeLkj3zMjK4U0t5lxK7SWg9hORZfl1j6QM3F?=
 =?us-ascii?Q?sDJ5gcrWweGavas/4CGux5Kb12nEY/1AVXns7/CEEhFPOwX2K8FwvVkpQGXK?=
 =?us-ascii?Q?t4aLogNYYA++BHjTtHwMQsJLrEuwOKPp2Lw98gmsF4kYsTFeSDfWrLIbSqhQ?=
 =?us-ascii?Q?JaBnlujDX8xZrOfDcqXS+LkhcFNyyTIeEEA1idB/GjrTbayaEjzb/DZBPCMH?=
 =?us-ascii?Q?ElhIhWvwm66wlqKXZ78SIz6JYuAi9XqFmnwCq4NxTsniOi3jNxMeEZFKFojX?=
 =?us-ascii?Q?y9y/vIzUM2per5cVC9+rg+VG6SeABo+HHq34Uvtcm/b39XJkcuUDHciC46n8?=
 =?us-ascii?Q?2llRxxkStzyHrTFtCWU2O1kR3P8Rrg8fOB4ZrKsC9hwXRrAa10diX0soL/1m?=
 =?us-ascii?Q?1cunMNCBKYZSx3Ut5401KHnlH0OjA/eFqp6Xhf5nBRWw+PrWrQQsbXldCtya?=
 =?us-ascii?Q?Q3jRdHcdrMwU3D5jC+cVy+ZbmbpxgsbQ2YRhmxEkRFGokFjhsaPJzufDAHKY?=
 =?us-ascii?Q?asExEP0CUkYFDokqBIZHjOm/NFeIIrju5zEz5R3LZDj9wwpAlEpyepd/mr/K?=
 =?us-ascii?Q?1HZfcDRbM6qMg7kDqSeaoYaueVChe+dWj1IF3mv7x4x2ttePR6PDwryAKTha?=
 =?us-ascii?Q?/bSW//Qxiw4Orv6FkZ9H32OQ0AaUVmoIDp1/Gqhw2oIcbkrHgIA2y+33QbUx?=
 =?us-ascii?Q?QwaBh34ghuFhR42wzVdhCvQhuEaqQtx5PDHgqv5DRRGD2rCGYbEWfhACs3vq?=
 =?us-ascii?Q?hZ3A8hGkgLEvXcC/gUzEjmg/UabrevXZzfRrMO31nvXYz0tSOGicSFHF/FID?=
 =?us-ascii?Q?/4bE6AT4AXU3iaiNk5PzPXNTx4aF3bV54JXWGYPzJRjLflhPBz2pq2Jmw10v?=
 =?us-ascii?Q?CUBTiK4YFUZm9iuDEmXR8k+R6MH2AldbsL7HOqL/hXDb3c6M3wkEBwArXRUZ?=
 =?us-ascii?Q?JdtJbAY5QVXaqw8B/gdNZxfldvZ0VTG1nWg33G8TDgtojT2UzP9jE6whI0IK?=
 =?us-ascii?Q?wFP5Ap5rzvAwP8nz7xtR3DAuSk71GSoYhzw9gcn6P8NB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LGCQZJNCCQc5P+vxB5bWCVPnFpiizPsvcZwBYbMT0/4lytSBv6H1E6QieAqP?=
 =?us-ascii?Q?sqE5t+z/LrKcakg6ZhlzHwR/t3xwaMJdxcisI2WSznTL4F0xyoyj/Fzi0ba+?=
 =?us-ascii?Q?BBtUD9BYnw9xKzmot8CWlkEZa6MQpikEIKnLyMcYDyKvZ9n3Y2AreB6wMVdX?=
 =?us-ascii?Q?/q0BgjMzyXnVh6TgNLilq1N+ojKqOxen0yFLJ82svmO1j5zwJ9OCp0sfQHah?=
 =?us-ascii?Q?cxJf72VRuNHWDTey3UHTp66vleAkhWee0TlEU6/UEe7Ca99QLBRNYzr+Ycu7?=
 =?us-ascii?Q?NQPp1lOyy5k+YZANOKR1EcBecJB9s5feCw3pjxBUdKmPDVSSAM/Km9wJye4h?=
 =?us-ascii?Q?mZ4V61vC6YEvttpUwm7a7rTzTVSak+bwe4kuJ4b+2HM2g4qE6Hl32GIspylM?=
 =?us-ascii?Q?fDYDQa+CvkX4L+YPUk/oPqkOFbWY/PNES2NkLY1iMhjTMBtAU4NV3mNICG6H?=
 =?us-ascii?Q?RljbYSaewV0M/dM7wZttz6zrT0kZIfw8epVgu6A1s/ZgYHfW4OuR8DEG1JMv?=
 =?us-ascii?Q?psfYd+Cji+3EdUon2uoApzlwrhcqa59uisbAQwHQCsFBrBQWJYrgrFQ1HI8/?=
 =?us-ascii?Q?DfemdrkzQZTY2VgxAx9TcneXQtMZWCFgPiobny5WQRIFsLXCWPeRSg7EjFSo?=
 =?us-ascii?Q?BJ6/FVZIfUPHoxtgthIy880WAoFMKOr9wqJUCIRS9jQ5s1D+URIi1iPOY3dc?=
 =?us-ascii?Q?vfvbeNuMzU5e9pRvBeIY5QDZ3JhkfgM9TtWx5hNY1ihB+mGyZHkBeQ57EWot?=
 =?us-ascii?Q?09aMzGmGQgxusMRCp6ltxcza2xeNfTvAcfDAOZFDCajHwakmT2Ad0bcLmLJS?=
 =?us-ascii?Q?vazog6ywb/VZDoy2AmC+LyzC4aHuLWT8LvdatUbhTIUYvNG1lLmgejhof5Oy?=
 =?us-ascii?Q?3Q4/5y83rJeL0bM9RU71L5NdxfnRBxJfrsEAA+s1d30h2g+lvYMhbNq5FMOC?=
 =?us-ascii?Q?DSIA133N28QFICRzBGVdjmo6hiudbMJ/2IyV9PLddFEo6ZdXo5RUUuLVW21+?=
 =?us-ascii?Q?QrmZ+DZFMMT8vtco8/+Kotr5PYywDxoAmg9VgZGwsWLuz59lmVyD35vvRPoZ?=
 =?us-ascii?Q?xbnGbM2uzwBy/4ZbfkrI6EuM/y2AdFkdLyH7U8FL+mgkqwyOPI81hitvNWp/?=
 =?us-ascii?Q?yqrzcEc5RAAK34lgnzUHEgWQ6SBPtcsMheBcDk1PWeJHD4Ayp949GGpu7mHg?=
 =?us-ascii?Q?i7F0Yk5W3q7NdjtwG2SN04NpUZaMHj7aXXrhTyvuF0ZYydVSfabOyGyU0But?=
 =?us-ascii?Q?dKXfQ1luCwjlcOXVKa8RtallP4Zvuz6en99icXybVIPj6NhHmEjaw4uWs4H4?=
 =?us-ascii?Q?VELy3wbBE2TmsrVEM6BxVEo7RfBIPvcjMZoQyEnfnwrXcqeFLUZvhKp8AspC?=
 =?us-ascii?Q?yLS95ZQRwJfrlzRBGNuoBGeoIp7HQ6qyODvx7w1dO8E6BfEvw5BSe54/u7te?=
 =?us-ascii?Q?6p5d7s2iiNIVJZqx9q2EJ86TI5/OGF52vrIDiSJPRmgcg567hgiXamYWSJ95?=
 =?us-ascii?Q?YOC4jft0SWmO12soEQdKVm1ZWJuf4cgO1FIYS7y3nPgwEsB54s6vKT6hReTS?=
 =?us-ascii?Q?qVSNzsZ3huoKkyqbF5glv2xBpXJZ2gkbKbGeSmd2SmcKaReZYPABob0YBuUx?=
 =?us-ascii?Q?5NHrUw1XE/oMyGFL4a4tkxoSg1eSKZ0M7PfvzGPrKegHDCToZJWZhOnrR3bV?=
 =?us-ascii?Q?LD6QWNGCJgIIc5oqq/mib96kOX8MsM2ICVysbFrfn9Fk5p6e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755c7131-66e5-4ed8-f8db-08de62e4310c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:22:15.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HV4EnLy6eFhMeB5LG4KQfKFmHUxSSnkJv8uY9NknmCw7uFNvEYdLojNIw82luh8YiDRUnGKkd8ixbdVRCHjLvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256127-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,imx93evk:email]
X-Rspamd-Queue-Id: A331DD49DA
X-Rspamd-Action: no action

This patch set optimizes the XDP copy mode logic as follows.

1. Separate the processing of RX XDP frames from fec_enet_rx_queue(),
and adds a separate function fec_enet_rx_queue_xdp() for handling XDP
frames.

2. For TX XDP packets, using the batch sending method to avoid frequent
MMIO writes.

3. Use the switch statement to check the tx_buf type instead of the
if...else... statement, making the cleanup logic of TX BD ring cleared
and more efficient.

We compared the performance of XDP copy mode before and after applying
this patch set, and the results show that the performance has improved.

Before applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s

After applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   425,778 rx/s                  0 err,drop/s
Summary                   426,042 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   698,351 rx/s                  0 err/s
Summary                   701,882 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   210,348 rx/s                  0 err,drop/s
Summary                   210,016 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                354,407 rx/s                  0 err,drop/s      354,401 xmit/s
eth0->eth0                350,381 rx/s                  0 err,drop/s      350,389 xmit/s

This patch set also addes the AF_XDP zero-copy support, and we tested
the performance on i.MX93 platform with xdpsock tool. The following is
the performance comparison of copy mode and zero-copy mode. It can be
seen that the performance of zero-copy mode is better than that of copy
mode.

1. MAC swap L2 forwarding
1.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -z
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 414715         415455
tx                 414715         415455

1.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -c
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 356396         356609
tx                 356396         356609

2. TX only
2.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -z
 sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 1119573        1126720

2.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -c
sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 406864         407616

---
v6:
1. Remove fec_xdp_drop() from XDP_PASS branch of fec_enet_rx_queue_xdp()
v5 link: https://lore.kernel.org/imx/20260129103447.1893129-1-wei.fang@nxp.com/
v5:
1. Update the commit message of patch 6 and 13.
2. Fix the potential memory leak issue in fec_enet_alloc_rxq_buffers(),
so free the buffers on failure.
3. Only initialize bdp->cbd_bufaddr in fec_alloc_rxq_buffers_pp() because
the other fileds of bdp will be initialized in fec_enet_bd_init(). And
move the initialization of ebdp to fec_enet_bd_init().
4. Refactor fec_alloc_rxq_buffers_zc().
5. Add a check to rxq->rx_buf[index].xdp in fec_enet_rx_queue_xsk(), for
example, for the xdpsock tx only use case, the RX buffers are all NULL.
6. Refactor fec_setup_xsk_pool(), so add some new helpers like
fec_enable_xsk_pool(), fec_disable_xsk_pool(), fec_alloc_new_rxq_xsk(),
fec_alloc_new_rxq_pp() and fec_xsk_restart_napi(). This refactoring
ensures that when fec_setup_xsk_pool() fails, it can revert to the
original rxq configuration.
v4 link: https://lore.kernel.org/netdev/20260123022143.4121797-1-wei.fang@nxp.com/
v4:
1. Remove the unneeded semicolon in fec_enet_bd_init()
v3 link: https://lore.kernel.org/imx/20260121033357.3261464-1-wei.fang@nxp.com/
v3:
1. Fix build warning due to missing break for the FEC_TXBUF_T_XSK_TX
branch in fec_enet_bd_init().
2. Add new patch 7, which is separated from patch 6
3. Collect Reviewed-by tags.
v2 link: https://lore.kernel.org/imx/20260116074027.1603841-1-wei.fang@nxp.com/
v2:
1. Improve the commit message
2. Remove the unused variable dma from fec_enet_rx_queue_xsk() to fix
the build warning
3. Remove fec_txq_trigger_xmit() from fec_enet_xsk_tx_xmit()
4. Separate some new patches, patch 4, 8, 13.
5. Collect Reviewed-by tags.
vl link: https://lore.kernel.org/imx/20260113032939.3705137-1-wei.fang@nxp.com/
---

Wei Fang (15):
  net: fec: add fec_txq_trigger_xmit() helper
  net: fec: add fec_rx_error_check() to check RX errors
  net: fec: add rx_shift to indicate the extra bytes padded in front of
    RX frame
  net: fec: add fec_build_skb() to build a skb
  net: fec: improve fec_enet_rx_queue()
  net: fec: add fec_enet_rx_queue_xdp() for XDP path
  net: fec: add tx_qid parameter to fec_enet_xdp_tx_xmit()
  net: fec: transmit XDP frames in bulk
  net: fec: remove unnecessary NULL pointer check when clearing TX BD
    ring
  net: fec: use switch statement to check the type of tx_buf
  net: fec: remove the size parameter from fec_enet_create_page_pool()
  net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
  net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page
    pool
  net: fec: improve fec_enet_tx_queue()
  net: fec: add AF_XDP zero-copy support

 drivers/net/ethernet/freescale/fec.h      |   14 +-
 drivers/net/ethernet/freescale/fec_main.c | 1640 ++++++++++++++++-----
 2 files changed, 1251 insertions(+), 403 deletions(-)

-- 
2.34.1


