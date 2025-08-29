Return-Path: <netdev+bounces-218111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BC9B3B271
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2ED8568570
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714AC233134;
	Fri, 29 Aug 2025 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l2ojq7yU"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D4231C91;
	Fri, 29 Aug 2025 05:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445260; cv=fail; b=KF0kQVGEEBZFkaHcX5FlFWB0ny/RCRm9+d+jARf5wNwS6w0dkm0+gJkpBguyoMcHQZdPsv9NtWpFt4pQip2vX9KkhYcFeztLc46SRZmxKBT4jQDgmcwq0kGPudlARSuTJNf64a14bR8U1ErElFAPP5u3mQUL8ByJO2xOPNjXJMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445260; c=relaxed/simple;
	bh=0NIaQzCxSzZYVi7zOjBB6kwCuKz0YCAqrbQzu5I9fKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RdmMJ541NOBf7QFayYo3BrI6e7eZBUDmZkyQ3iEH7P+6SfBmydG3Md3nKJgZbLYMESb0MpNlZ/SskY/tiSaEQL/sruBAMgJEfPiFnQse0D+9tXtvhvvKMfgop2a0QkSswqcjfT12iJhnOcZmPH6O21uwyYvnmH2MxgXFU+YSpJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l2ojq7yU; arc=fail smtp.client-ip=40.107.130.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5ZTWP2FCF7aAUJMHD73KdxBFASBPoZCgUxM/6cWd0GHz+X7SNqkbTTKl/WU9jZ1RMJaneKfT2MDy1mpo6DBhPJzAq7ZuA2y1MCJ3/bvW2RyGzCAkj5K7oZq1dvhseI32FqOMY+oeYYNqza849iT+oFOScetjGAnsdDZtWKRvW38bmQp5hFep4FMJ0ECpWlBuyJE5UyhnmtXhCC4fRVjEGuXAK/ECE06Y9xCmmc4Opq8JW8o0aAl95Xl7RA3qaLNED9OH2Bg67ibJt7IkBVNYskgRPG4EKYAS3gF7587bDbs5jGqG0Vst9aqDdjDHO5H+TLaxembNhgZb0Doztpm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhzkM+FCHFddd9zy+xiLivBYascmIqaX3cjc3Rd8Rgk=;
 b=fuoAQAdsjBkkFW17A6KIFEeV/NZbzcRmE5N25bUlpvwDo4UCGOUzKY7Hayc1b6quLzK20LFkyl/H16m/5S2k90gurPvqUBEfTkRwnLs6cr7UHA3lM4l6/NjpBcQaAvkGaK6rq9pSrz+zxWYVscNdZVDleQqAvggTryQe60eL0jUbqqz76L9nX9urxlfy4VN+WQFOwtfaRcY2c0ypRoId1GT5AncyaHMokuwD2SJUB0YDX1mCCGYTFbqKULAxN8jRv4j0YmYqutDI4nMEf53Q6wKEgiAdcAm3x1DDjMk+iArtGba2skWVmsyOS9bDzsuZOzWrRehXEV/xxn2AE00BsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhzkM+FCHFddd9zy+xiLivBYascmIqaX3cjc3Rd8Rgk=;
 b=l2ojq7yUfMr02LowbzFQDr/yItwkMs241AQr9JfozH+kPIGGBoz751bCd4tR5kCtvDFwGoL1+jH+BJBi4V5FI9o9zTNk7PmWDep3NsxgoO+nPfQgqzQjC0PtxXdfBz+lddcW8Caq+5x2tX+s3tjwVWBIO2/rh5mcWGOvbev6Ed9iTefpr8e+1yVBHwqWFhRUN1EwsCy2Reuhk5GI0xtUaCQ2biMv1PVlzqS0UIOfo5ZEpVvIk+owWw1KKKjdf3/iQHivyB1lHWCkEQdjdKXC75upA9+aHJIann2v5FUQxSgzE7GVIu9P+B8GZApR7ZGAv3tHWAMEd9YZ+8ueXeXIVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:27:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:27:34 +0000
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
Subject: [PATCH v7 net-next 04/14] ptp: netc: add NETC V4 Timer PTP driver support
Date: Fri, 29 Aug 2025 13:06:05 +0800
Message-Id: <20250829050615.1247468-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
References: <20250829050615.1247468-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b771554-d05c-4775-05a4-08dde6bcc201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sFruwx/f6ecpTYMO4djs9kuKSSxpUaSvc8Jsf2Lmi4GQ4k3N8lyFisOt7whk?=
 =?us-ascii?Q?GlKqYVr3Tk2zJswPhbvRWPiJypnKDNnthjoHpK88o0a+pAD5YdItk2qzry3B?=
 =?us-ascii?Q?hCryVzBBiaWrRwl8uGjDMnBX1zYen55AMYWDmGcQn5WJ+aDoAS0ZFpriSN+W?=
 =?us-ascii?Q?MKvrsoGjeQHXLwvscG7GZp9myZUmCVzrMkXTNmkjOZGBucypFI+6GFSpbvE6?=
 =?us-ascii?Q?N5nmNmYG158Izn5T+5MNxcjzIDgB9TFF/qzTe2Z6PLRm1RsNNopB88KxAz7B?=
 =?us-ascii?Q?wPBuc9HGh+uPvxVJUcMqlbmZBC3j9E2mS4qZc7Rag2wov3AfeHhGsP5ELBOK?=
 =?us-ascii?Q?bATWlgJW1zxA2aOis9eSdTyEckfAq+OxVSv15XBqnOh7zCNuySkfNd4fbrFE?=
 =?us-ascii?Q?lhx3u+pl/IZbPThmKCY58XrJM+aE2xquV5iuA/GxfETWMqRBvCBmoih8w/Y9?=
 =?us-ascii?Q?c8Wkc/j80gAK32COpELBIW8NWaJGo1nVvCfVROk25ob3Nh5R3qopBzSPhm7U?=
 =?us-ascii?Q?J7fZrjLEaVIpEyR1K+1zEw3PsbZC5ltftJSvV8YLfWZr8swXOGq9hxZQdFFV?=
 =?us-ascii?Q?4PtVVG5JuYxq7ogb6WdGhtfnOP1DUn2cM3QU87M2o1M8WvO2FZUjKIJLZKKL?=
 =?us-ascii?Q?nghvm+qIOqhyFGpOrPfEFHatCe3ohLWWI2/oeRp4LuIIVtoGG1zvJq9HX3dN?=
 =?us-ascii?Q?0rq4gfG8tI/i/pa8uMNBnNKjYoajzJV/0LvTUggDpteIud3FnzrHW4akscLb?=
 =?us-ascii?Q?LFdNd9aqQNx5ycsjtns3iz6BSWx22z4n7H/ReOsQqoHelQEGgBdSxhOP4F/p?=
 =?us-ascii?Q?IfvG4bSPUPzbMJv0G4WpynWG/YqvizVtNgcJoh4G+iE68E8HY8lqzdYwvqYc?=
 =?us-ascii?Q?xFrR1PAAw3ndvxcoTG5QMUMYkoRnnzhf7qwAl81EFr/ByymRWNdFf20aR0na?=
 =?us-ascii?Q?8wWrPS9dihDMwcXD/riyi13s8g+jTCN3SXUcTlXRdhZW7Kiq8Lxcpmz7mkWD?=
 =?us-ascii?Q?auuVEgWui1j+zNAWRKsePf9OUQwi0BkE38DQNbS+VYgilULo+w9Utzm2oG4O?=
 =?us-ascii?Q?O5yh9HAqw1S0/AMgqveC/j8tGczQMZiMDPqSVCOXLho1Y9/2qbJTuCJqIKcc?=
 =?us-ascii?Q?kxF8WmkQFmjQjuNnTbUJ0gTwVmr/6kpWYoTepnGYHCzh98qveSpXyxhKpS7f?=
 =?us-ascii?Q?f8S4aKrivb7w5hjD5O6qERhTy8XJYpK5bNPVJOecTdLjmAVBtwACP5SwlnMt?=
 =?us-ascii?Q?pFCuxnRjI6DsenbO434Z2IzP6bE58CZlOYPxwRcVIJyKgd6HsZ4v4grFJr6j?=
 =?us-ascii?Q?Dfr/zK4zkotLR3LEFBcucmSVBmvAKYMJmJ3ET9hojImAnpELOjp9/wCNhhgl?=
 =?us-ascii?Q?C/h+g1oQ8GDtNTGhRwVsgH/fW+3dchXW1IoiynNKGqjfGCMEmLvFC2TBIbQL?=
 =?us-ascii?Q?0yo1ga9SpudB71fGOfbumkPaS5G8SOKU9MrQ4SDvopfoX3/HUhtM0ga9P9RF?=
 =?us-ascii?Q?v6OkmfTcQitmub0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7P4WzXY/MRqMGCmmoffqA3WMNhdmwI3nn5QHy9YyRqN0a1uFNygcZ0hpZODi?=
 =?us-ascii?Q?EPfiUoOQcK9TiXd3aiBOnwXCZljDwtReE/8Q92wXfWQKvzd96E1BHiAJK3FF?=
 =?us-ascii?Q?AfVR+WUaPDecaG2dmB/zks/JeQYn3Y50FZJkCRMoHIBxNHfeGEBaTvF8Le3a?=
 =?us-ascii?Q?4aCTXPds1zWV1/BO6dLpS1kKPZnUwwbv8a390Lb9iJ4SobcvH708TeHsIL2W?=
 =?us-ascii?Q?MkxtxUYc33JAbMPat8p+6HRRIqllU6N/C8gvfKXSnPcmjAMM59YcBnOm8Ew0?=
 =?us-ascii?Q?uqgqcetlBppUblX57k3wM2WndRVOIcyLk8hi5GWJIQkXQvhwdJLMviM0JvY3?=
 =?us-ascii?Q?5F6ft3te+QG7l05A5sY7Ks/ye1TQ7pV3R+5kLkWvOXmls4fiOUd97taRbyu+?=
 =?us-ascii?Q?VplkfmTZiWewnzHioA+4NcANWVZCnaCM633tr88JLGDNLoy7c6zPcajqDCkN?=
 =?us-ascii?Q?DWc0x/kER3GIp36EpfQQZVb8WXTkTqTlXgTRF9MIqnaGZuZaN9H+JPwry5CH?=
 =?us-ascii?Q?3NOujpZoSCPSJdLxqBTXVgKif4kKYxZmCbtcRA3FKRfDCHtk0Wl/ru9chcbo?=
 =?us-ascii?Q?uRRUYnosjdILjSzA58vf2q3HP44K2OJaJ/WnTeSUGXziQahdi//VK0qXZkUP?=
 =?us-ascii?Q?EVKLK8mTCyCXba3zPLGEwWX9jyCLZIbPOCw8+WZWcGzHMO3rBIbxmcAEca1+?=
 =?us-ascii?Q?b57xA2PU2YRTx5KvmUav5Bf8dLRpTTW/VKZIbzgrjJjQFS+WoXekTXSsoueq?=
 =?us-ascii?Q?l/ZTH4nSMzupGnlpDuFjxfCyEZuR5MDNN7TPPC3uADoBeqtyckDOE8b0nwD/?=
 =?us-ascii?Q?1LG7uN3aYcYM8zSl8qsc3wvHaYjXBxO1yv0+AvP7n9qugek76v7O3KDOoAKB?=
 =?us-ascii?Q?MPHnZTxLRxnUnYoHpSIBAniisjK+hjXOq/HwZ09ar6NyrJxqEh46CZ6i0MTY?=
 =?us-ascii?Q?RTY3lKv8bCOt5WC/noOJCCMpqauR0Djoex+xuDI29zlLFiokD+luC1IcQ/tG?=
 =?us-ascii?Q?TrmTmfhZeE3TrzZ1kfJvM5yq06pdIskMmnCpaMSoMzUvXnCtsmOzKrGiLpL/?=
 =?us-ascii?Q?INBjEgjdN0URzK1ekQP3y/G2R9dSFV6EBAkatABw4rM3R/voj/wz8xuKNDC0?=
 =?us-ascii?Q?onwId324A+PU88F4vX1sLBmmtpcV5f6wt0eGBy9N/nEb6tPjHa/nsnrmRqYa?=
 =?us-ascii?Q?KFIUUZUZsBjNG/VN7mc3MKacJX0UHXag475IHLlt0KJmOph4ipwL7LcHYZGG?=
 =?us-ascii?Q?vY39Fep7rjNcPzwB5NsoGk+HsXmy672z0MNYL+tT0VhosdazK7L+9FBgWtyh?=
 =?us-ascii?Q?lavOp5QnuG9ZC8vISFdS3z2223uqIcnP3+y/2TffIRRDLg66KHayNV7SGkxX?=
 =?us-ascii?Q?8GH9uK6R2nd6lPot6AFUzVPLyldjM294L5+cMCMtNx2TzK/KBLt6xflKL1Q8?=
 =?us-ascii?Q?mV6FjmdOWRU7N3n9tq6f47GWxQznwukCud1d8gsw6AJS3zKmLQAlO4rtt00W?=
 =?us-ascii?Q?Zk5GXTuAHwRAAtHV/3NWPzS8TUGSS9vYgP2JEQ5P15GeAIYBqAS2PfovcTAa?=
 =?us-ascii?Q?nIyaJ3WiD0pWgF1QS+ZdWZBfLbdYvKBgUzsSkrbT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b771554-d05c-4775-05a4-08dde6bcc201
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:27:34.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MX5KNrOh3eaibhqDB4ABZ0znH7mHJcMY869UQmt+cIKtS+30kHOGs33tftdMwN/hSNH/eCPdWttX7EkvYZVTqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

NETC V4 Timer provides current time with nanosecond resolution, precise
periodic pulse, pulse on timeout (alarm), and time capture on external
pulse support. And it supports time synchronization as required for
IEEE 1588 and IEEE 802.1AS-2020.

Inside NETC, ENETC can capture the timestamp of the sent/received packet
through the PHC provided by the Timer and record it on the Tx/Rx BD. And
through the relevant PHC interfaces provided by the driver, the enetc V4
driver can support PTP time synchronization.

In addition, NETC V4 Timer is similar to the QorIQ 1588 timer, but it is
not exactly the same. The current ptp-qoriq driver is not compatible with
NETC V4 Timer, most of the code cannot be reused, see below reasons.

1. The architecture of ptp-qoriq driver makes the register offset fixed,
however, the offsets of all the high registers and low registers of V4
are swapped, and V4 also adds some new registers. so extending ptp-qoriq
to make it compatible with V4 Timer is tantamount to completely rewriting
ptp-qoriq driver.

2. The usage of some functions is somewhat different from QorIQ timer,
such as the setting of TCLK_PERIOD and TMR_ADD, the logic of configuring
PPS, etc., so making the driver compatible with V4 Timer will undoubtedly
increase the complexity of the code and reduce readability.

3. QorIQ is an expired brand. It is difficult for us to verify whether
it works stably on the QorIQ platforms if we refactor the driver, and
this will make maintenance difficult, so refactoring the driver obviously
does not bring any benefits.

Therefore, add this new driver for NETC V4 Timer. Note that the missing
features like PEROUT, PPS and EXTTS will be added in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v5 changes:
1. Remove the changes of netc_global.h and add "linux/pci.h" to
   ptp_netc.c
2. Modify the clock names in timer_clk_src due to we have renamed them
   in the binding doc
3. Add a description of the same behavior for other H/L registers in the
   comment of netc_timer_cnt_write().
v4 changes:
1. Remove NETC_TMR_PCI_DEVID
2. Fix build warning: "NSEC_PER_SEC << 32" --> "(u64)NSEC_PER_SEC << 32"
3. Remove netc_timer_get_phc_index()
4. Remove phc_index from struct netc_timer
5. Change PTP_NETC_V4_TIMER from bool to tristate
6. Move devm_kzalloc() at the begining of netc_timer_pci_probe()
7. Remove the err log when netc_timer_parse_dt() returns error, instead,
   add the err log to netc_timer_get_reference_clk_source()
v3 changes:
1. Refactor netc_timer_adjtime() and remove netc_timer_cnt_read()
2. Remove the check of dma_set_mask_and_coherent()
3. Use devm_kzalloc() and pci_ioremap_bar()
4. Move alarm related logic including irq handler to the next patch
5. Improve the commit message
6. Refactor netc_timer_get_reference_clk_source() and remove
   clk_prepare_enable()
7. Use FIELD_PREP() helper
8. Rename PTP_1588_CLOCK_NETC to PTP_NETC_V4_TIMER and improve the
   help text.
9. Refine netc_timer_adjtime(), change tmr_off to s64 type as we
   confirmed TMR_OFF is a signed register.
v2 changes:
1. Rename netc_timer_get_source_clk() to
   netc_timer_get_reference_clk_source() and refactor it
2. Remove the scaled_ppm check in netc_timer_adjfine()
3. Add a comment in netc_timer_cur_time_read()
4. Add linux/bitfield.h to fix the build errors
---
 drivers/ptp/Kconfig    |  11 ++
 drivers/ptp/Makefile   |   1 +
 drivers/ptp/ptp_netc.c | 419 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 431 insertions(+)
 create mode 100644 drivers/ptp/ptp_netc.c

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 204278eb215e..9256bf2e8ad4 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -252,4 +252,15 @@ config PTP_S390
 	  driver provides the raw clock value without the delta to
 	  userspace. That way userspace programs like chrony could steer
 	  the kernel clock.
+
+config PTP_NETC_V4_TIMER
+	tristate "NXP NETC V4 Timer PTP Driver"
+	depends on PTP_1588_CLOCK
+	depends on PCI_MSI
+	help
+	  This driver adds support for using the NXP NETC V4 Timer as a PTP
+	  clock, the clock is used by ENETC V4 or NETC V4 Switch for PTP time
+	  synchronization. It also supports periodic output signal (e.g. PPS)
+	  and external trigger timestamping.
+
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 25f846fe48c9..8985d723d29c 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
 obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
+obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
new file mode 100644
index 000000000000..defde56cae7e
--- /dev/null
+++ b/drivers/ptp/ptp_netc.c
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC V4 Timer driver
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/ptp_clock_kernel.h>
+
+#define NETC_TMR_PCI_VENDOR_NXP		0x1131
+
+#define NETC_TMR_CTRL			0x0080
+#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
+#define  TMR_CTRL_TE			BIT(2)
+#define  TMR_COMP_MODE			BIT(15)
+#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+
+#define NETC_TMR_CNT_L			0x0098
+#define NETC_TMR_CNT_H			0x009c
+#define NETC_TMR_ADD			0x00a0
+#define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_OFF_L			0x00b0
+#define NETC_TMR_OFF_H			0x00b4
+
+#define NETC_TMR_FIPER_CTRL		0x00dc
+#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
+#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
+
+#define NETC_TMR_CUR_TIME_L		0x00f0
+#define NETC_TMR_CUR_TIME_H		0x00f4
+
+#define NETC_TMR_REGS_BAR		0
+
+#define NETC_TMR_FIPER_NUM		3
+#define NETC_TMR_DEFAULT_PRSC		2
+
+/* 1588 timer reference clock source select */
+#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
+#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
+#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
+
+#define NETC_TMR_SYSCLK_333M		333333333U
+
+struct netc_timer {
+	void __iomem *base;
+	struct pci_dev *pdev;
+	spinlock_t lock; /* Prevent concurrent access to registers */
+
+	struct ptp_clock *clock;
+	struct ptp_clock_info caps;
+	u32 clk_select;
+	u32 clk_freq;
+	u32 oclk_prsc;
+	/* High 32-bit is integer part, low 32-bit is fractional part */
+	u64 period;
+};
+
+#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
+#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+#define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
+
+static const char *const timer_clk_src[] = {
+	"ccm",
+	"ext"
+};
+
+static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
+{
+	u32 tmr_cnt_h = upper_32_bits(ns);
+	u32 tmr_cnt_l = lower_32_bits(ns);
+
+	/* Writes to the TMR_CNT_L register copies the written value
+	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
+	 * register copies the values written into the shadow TMR_CNT_H
+	 * register. Contents of the shadow registers are copied into
+	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
+	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
+	 * register first. Other H/L registers should have the same
+	 * behavior.
+	 */
+	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
+	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
+}
+
+static u64 netc_timer_offset_read(struct netc_timer *priv)
+{
+	u32 tmr_off_l, tmr_off_h;
+	u64 offset;
+
+	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
+	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
+	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
+
+	return offset;
+}
+
+static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
+{
+	u32 tmr_off_h = upper_32_bits(offset);
+	u32 tmr_off_l = lower_32_bits(offset);
+
+	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
+	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
+}
+
+static u64 netc_timer_cur_time_read(struct netc_timer *priv)
+{
+	u32 time_h, time_l;
+	u64 ns;
+
+	/* The user should read NETC_TMR_CUR_TIME_L first to
+	 * get correct current time.
+	 */
+	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
+	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
+	ns = (u64)time_h << 32 | time_l;
+
+	return ns;
+}
+
+static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
+{
+	u32 fractional_period = lower_32_bits(period);
+	u32 integral_period = upper_32_bits(period);
+	u32 tmr_ctrl, old_tmr_ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
+				    TMR_CTRL_TCLK_PERIOD);
+	if (tmr_ctrl != old_tmr_ctrl)
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static int netc_timer_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 new_period;
+
+	new_period = adjust_by_scaled_ppm(priv->period, scaled_ppm);
+	netc_timer_adjust_period(priv, new_period);
+
+	return 0;
+}
+
+static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	unsigned long flags;
+	s64 tmr_off;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	/* Adjusting TMROFF instead of TMR_CNT is that the timer
+	 * counter keeps increasing during reading and writing
+	 * TMR_CNT, which will cause latency.
+	 */
+	tmr_off = netc_timer_offset_read(priv);
+	tmr_off += delta;
+	netc_timer_offset_write(priv, tmr_off);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
+				 struct timespec64 *ts,
+				 struct ptp_system_timestamp *sts)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	unsigned long flags;
+	u64 ns;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	ptp_read_system_prets(sts);
+	ns = netc_timer_cur_time_read(priv);
+	ptp_read_system_postts(sts);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	*ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
+static int netc_timer_settime64(struct ptp_clock_info *ptp,
+				const struct timespec64 *ts)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 ns = timespec64_to_ns(ts);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	netc_timer_offset_write(priv, 0);
+	netc_timer_cnt_write(priv, ns);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static const struct ptp_clock_info netc_timer_ptp_caps = {
+	.owner		= THIS_MODULE,
+	.name		= "NETC Timer PTP clock",
+	.max_adj	= 500000000,
+	.n_pins		= 0,
+	.adjfine	= netc_timer_adjfine,
+	.adjtime	= netc_timer_adjtime,
+	.gettimex64	= netc_timer_gettimex64,
+	.settime64	= netc_timer_settime64,
+};
+
+static void netc_timer_init(struct netc_timer *priv)
+{
+	u32 fractional_period = lower_32_bits(priv->period);
+	u32 integral_period = upper_32_bits(priv->period);
+	u32 tmr_ctrl, fiper_ctrl;
+	struct timespec64 now;
+	u64 ns;
+	int i;
+
+	/* Software must enable timer first and the clock selected must be
+	 * active, otherwise, the registers which are in the timer clock
+	 * domain are not accessible.
+	 */
+	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
+		   TMR_CTRL_TE;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
+
+	/* Disable FIPER by default */
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		fiper_ctrl &= ~FIPER_CTRL_PG(i);
+	}
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+	ktime_get_real_ts64(&now);
+	ns = timespec64_to_ns(&now);
+	netc_timer_cnt_write(priv, ns);
+
+	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
+	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
+	 */
+	tmr_ctrl |= FIELD_PREP(TMR_CTRL_TCLK_PERIOD, integral_period) |
+		    TMR_COMP_MODE;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+}
+
+static int netc_timer_pci_probe(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	pcie_flr(pdev);
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable device\n");
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
+	if (err) {
+		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
+			ERR_PTR(err));
+		goto disable_dev;
+	}
+
+	pci_set_master(pdev);
+
+	priv->pdev = pdev;
+	priv->base = pci_ioremap_bar(pdev, NETC_TMR_REGS_BAR);
+	if (!priv->base) {
+		err = -ENOMEM;
+		goto release_mem_regions;
+	}
+
+	pci_set_drvdata(pdev, priv);
+
+	return 0;
+
+release_mem_regions:
+	pci_release_mem_regions(pdev);
+disable_dev:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void netc_timer_pci_remove(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+
+	iounmap(priv->base);
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct clk *clk;
+	int i;
+
+	/* Select NETC system clock as the reference clock by default */
+	priv->clk_select = NETC_TMR_SYSTEM_CLK;
+	priv->clk_freq = NETC_TMR_SYSCLK_333M;
+
+	/* Update the clock source of the reference clock if the clock
+	 * is specified in DT node.
+	 */
+	for (i = 0; i < ARRAY_SIZE(timer_clk_src); i++) {
+		clk = devm_clk_get_optional_enabled(dev, timer_clk_src[i]);
+		if (IS_ERR(clk))
+			return dev_err_probe(dev, PTR_ERR(clk),
+					     "Failed to enable clock\n");
+
+		if (clk) {
+			priv->clk_freq = clk_get_rate(clk);
+			priv->clk_select = i ? NETC_TMR_EXT_OSC :
+					       NETC_TMR_CCM_TIMER1;
+			break;
+		}
+	}
+
+	/* The period is a 64-bit number, the high 32-bit is the integer
+	 * part of the period, the low 32-bit is the fractional part of
+	 * the period. In order to get the desired 32-bit fixed-point
+	 * format, multiply the numerator of the fraction by 2^32.
+	 */
+	priv->period = div_u64((u64)NSEC_PER_SEC << 32, priv->clk_freq);
+
+	return 0;
+}
+
+static int netc_timer_parse_dt(struct netc_timer *priv)
+{
+	return netc_timer_get_reference_clk_source(priv);
+}
+
+static int netc_timer_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err;
+
+	err = netc_timer_pci_probe(pdev);
+	if (err)
+		return err;
+
+	priv = pci_get_drvdata(pdev);
+	err = netc_timer_parse_dt(priv);
+	if (err)
+		goto timer_pci_remove;
+
+	priv->caps = netc_timer_ptp_caps;
+	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	spin_lock_init(&priv->lock);
+
+	netc_timer_init(priv);
+	priv->clock = ptp_clock_register(&priv->caps, dev);
+	if (IS_ERR(priv->clock)) {
+		err = PTR_ERR(priv->clock);
+		goto timer_pci_remove;
+	}
+
+	return 0;
+
+timer_pci_remove:
+	netc_timer_pci_remove(pdev);
+
+	return err;
+}
+
+static void netc_timer_remove(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+
+	netc_timer_wr(priv, NETC_TMR_CTRL, 0);
+	ptp_clock_unregister(priv->clock);
+	netc_timer_pci_remove(pdev);
+}
+
+static const struct pci_device_id netc_timer_id_table[] = {
+	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR_NXP, 0xee02) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
+
+static struct pci_driver netc_timer_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = netc_timer_id_table,
+	.probe = netc_timer_probe,
+	.remove = netc_timer_remove,
+};
+module_pci_driver(netc_timer_driver);
+
+MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


