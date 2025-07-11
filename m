Return-Path: <netdev+bounces-206075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A16B0143E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6481AA2141
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D4E1F0985;
	Fri, 11 Jul 2025 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VAXxa9WF"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5C1EF09B;
	Fri, 11 Jul 2025 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218250; cv=fail; b=dNSg4XSORjd8mYJhhTBbQKEkRYo2NVf8u6LlpkZSJgVgCnsr3mxOSOI90AKThOmX+IvbN5HDzpHZDTFe05T6B+Lh6jE8sdXi63BTiteKgKwmdV85aU3z4kATJmfryNY4RmIpl87E8g9kSBVUh72Aba12DOfw7/AEDx6LUXq7DtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218250; c=relaxed/simple;
	bh=RJkcQk/XSwAEILvmgMRLhGPFavPeFCD1P/IBnKpoyfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sEfXblZ9AgatZMYUvPQbAvTWLnpsrMVN5QhiAj8FTKLAXhTFkDabnZXbuV+xWYcd2k+ck7OP/q4FdQ7wrSj4M83U3erGDKnkyvM4IACskmc1AreZmPyV8jCxEMjkLcAMvLLbLyNhCZRBiUW7/oM5L2sU0OqeuFStzkhyH14Ww5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VAXxa9WF; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFhhR8JRKJ95r5BAg2KdyNhlnyVT5RvM4dsF2vKeKb+Qg5Fv97gJCtRpZ3p5ymN7yvRCA8DIQPfbd3jPFKF2I5GD7rZYl9OUQKVl3KJfy7dzjiyON70MPo8ByZuHmiYmtTpOyJLR/wO/zaDZPsswXenX22u1oTHtoQgyRxjEZZCq3woc0KzhJQJ5vukn3G6oinYsgSlbd0cLwV/rkcvCHIhVb8Kj299rYUOpmKHSZVSK2jNvfRFtzlJYa297F87TTXezcSMXeWETKkT7LWzkE14QtEx3MRgU9ebacinSqAfET0hyJfIufRno0ykcJRe/ra0OlbNtlm79TU8Mc4cPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDGRbE4WvhLUPpNvrr7xHDCMskN6XnmUWFx/hQ+/ot0=;
 b=DJfElXs/UK5SwFEJZeftS56Tc3GDImbJHR4Bg5z81SVmw/42WkymkM+9YsbvI3Meph3II2o7w0ac6AU+jmb0oq8ZzP2gT/VcrKZMxKi3EiKoQ+TbybQxGb1lxh/EAEUZw2vdbEmDY6sM5hPuvhpCvWJcXCYuofl7Mwc54voNVfg0U8eNoLO9VHEedwfqcD/AvlHpSioebz7VygPUtapr6Tu47mJmlsyCTd5Ka3KgzYLnW5ojRUKrR8CoCUi5Jnlzd1715Og2cGM9hl/atQkU8zXSy/1R9BiHDS5aCWrCd9UW6/y9W53z6C7dbeQP9GCUGYYU/1oIPc6boSehwkG8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDGRbE4WvhLUPpNvrr7xHDCMskN6XnmUWFx/hQ+/ot0=;
 b=VAXxa9WFhP4QL7g+K6tRQjvbPkFOspg/tZ/Fua3ARsulmfzwkxE4bX6dXXbV8Ap8sSEcLi3Cyu0P5K/rl2QgmECnUgSWA+vPZnOe9xJKUlXG/gpC4eonb8Q64gvpR6K7tHglw2ofaIDDxgO9VcOWQRnc7DgtIilJhaKvIPgR3gA9I9FEJxNhThmoG2aUsPs4X9zzNSorTX/FoNU0inCDOt0YF9cYKLnL9WcQ1jdR2pGwSgcr/b0sUIM7LUFdWlOGfhxT1mUp8c5q1+eVwJulJzTvnFXFSHTgUmpb7TZxdcTwQ8U7u6Moc4Oh5CiOCBlXb4jOkvC7flLrKrMHe54xVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 07:17:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:17:25 +0000
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
	pabeni@redhat.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 02/12] ptp: netc: add NETC Timer PTP driver support
Date: Fri, 11 Jul 2025 14:57:38 +0800
Message-Id: <20250711065748.250159-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711065748.250159-1-wei.fang@nxp.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a7d4cc-ef88-4e93-acde-08ddc04afc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ML+c4wxg788LIZfZild/MP0yz4PYco0ZbVUvuFukhrR2ImZVZK1rktT5p8mK?=
 =?us-ascii?Q?hy4Tig7xnERmxdIJMmq+vVK2JNhp2zYDvR8dd0PHI4gouU4ETyq0xT0X9gxA?=
 =?us-ascii?Q?KNzt7ehIAurfXM1ltH5xMYGO2BdPPou7+pjR9jTi8ERgKfVAtFzyrCo82Owa?=
 =?us-ascii?Q?unw/Bk7w82rPkPYIvAqv1ULb5B3/GhIW/5O/bij9fLfSrezS/ScZzEWdE1Ic?=
 =?us-ascii?Q?u7X9hiHX5QTWzRCWTko1pbKjwQpi+N8m6wQji5cEWSymAR3gEs4mdSJ+JVzx?=
 =?us-ascii?Q?WEq9S8qjIHk180zBoiGzQzvUvBcfqH2S4brhZ4DLTvhbWQuxN9oPBJIFTYXU?=
 =?us-ascii?Q?ObUu3ek8tFwbhqmMAOSbd4wVxSjyjPJ3g8+mVUW2GnMpwqAZIHDlocuFcOdq?=
 =?us-ascii?Q?2WWFgpuTRMIBflPiwJaCzuzQHwEQijSrJaPr610wT5RsJW6KKjiXRl89qWY5?=
 =?us-ascii?Q?2dVKVBaReQ9thBCZCpccfa+ZSGkBj75fqGADb3JXsMY8IicBITj6ne2oc5nn?=
 =?us-ascii?Q?GFIorFdd4Wh+NlYfmSp0PDlRlqe8AlL0sPqUS4luqKARyTKzh4LH4YTyA8tG?=
 =?us-ascii?Q?o+uzZVdOHnAg+DaZOcWVfXUlHhUh3lXFGGnIz8BKDnFC0VrDZbd+0x1slaIO?=
 =?us-ascii?Q?AkF3Rt3eYc2PMAj9cN2BpjPI5I/zAoIuMn0pxi193/BV1Jqir8v3VOOVmM83?=
 =?us-ascii?Q?lQ4RXS+F2SRRxDz0iv/JdZ2Yz5b8lwXLHfqhgZxz/x5rej//sGTqQVYJ1unm?=
 =?us-ascii?Q?iIrEBlvl69LAhX54qtmV0kzxkuECRHPRLASYMWmkHT3D3g0JrUK7YFIKlAMT?=
 =?us-ascii?Q?20p1NWCgaMEhIIq/5bPll7urcpUykWyaweBQCBbpxLDPolWNLunEWlscaNii?=
 =?us-ascii?Q?VUGngPQ8w8+X3A2yQPUTXlhKBwVq+fb+mWD4vqTKBOtaLZsrJP/RdBA9Ac5t?=
 =?us-ascii?Q?yiaTig0eYHiRvrGvTyr3woMy1+fD0pt2HDSU+T2XGNxkNX3IK1Kl+FSY/om5?=
 =?us-ascii?Q?0QQ+WDBP+iLol96O80Y8M8kxoZCRJCM9Yo9SyzUvden49crV3pz5uZyLSOzF?=
 =?us-ascii?Q?51MzS29r4TcM0/fiO4kqcztVRFMfBYkNLoA33aY6v/7+9e3IkhRUfYRoGT90?=
 =?us-ascii?Q?FOl5LsBozkQ2d62E6ot1uWLj4W1M7JPBjFNukmKmPASZ5aaUwfpViRH4PWzJ?=
 =?us-ascii?Q?bPesQRJwk9F1xamuQPkH4OE+hS/9oiBLcBnpcxn40Bokpnc16WRy3HdKyfHr?=
 =?us-ascii?Q?zj7I9sZJ6Zr6I4SxofTpCvWoxn+PjSWcayx4LF2iJcBb+VDG0v6DwZmh2E6c?=
 =?us-ascii?Q?ciagSR2RGWIUcqcH+R6/pZqAY2Z4F+1DnZECRWeWLm/Q4AW0PiFLrEGEQHmP?=
 =?us-ascii?Q?8KDnQEvhNpIa+pgn0ahGBjCyKQmGK9cDfsQHjZhOxHM8w9WtMWVDoVW9K0ja?=
 =?us-ascii?Q?jLsHRKnoRr9KCUVZJ36xQ0JtnvqCFvotJTunBUUpXQc4NVZrq4cvrRAMiIh5?=
 =?us-ascii?Q?efceI5tOMwHYMiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hCZwuGaF0wbb9BDZDdbLwudgnKrBOv/4AyLI4zOwXCwYHHt5l0ivcH9KEB6E?=
 =?us-ascii?Q?c50kj0QhEJ8QJFM4fggh60Q1f4VLKAlvwGqv5kV8lNTqwifdhRjYiUFL1YTV?=
 =?us-ascii?Q?9eeeErqbAZ3CEVfX+g0ZwLVhwzbUajpiYtPP6b+Iu8OIM9ioQBfQwQGxgK1F?=
 =?us-ascii?Q?m4wjjlvm9230/u8rup64b1ufh7h2ikzDKipZBzVthssnP77X5nVG2GUT5GQJ?=
 =?us-ascii?Q?pbLn7dbb35rUjcfFkI7nXSicttgAcXzMkOz0sS+vDZCqM1AHJQGThFnHv33x?=
 =?us-ascii?Q?RllzHCzoV6aZAf2pZB7lqFGlfWn631Q21Lb635Aae8XBRLoy8VaYHX6vUa43?=
 =?us-ascii?Q?ZH4ir2Z7UsWMf3KwUP7RQHyVMIjvh3ZBuWxzig8QJdFvsIWCij+HfuMI+Vb6?=
 =?us-ascii?Q?D7Vf8+TcCj0Tot+5c4T7t5O02aJ8VrSb7BQdQW/6EN6tvRds4+4U6jyxjXRJ?=
 =?us-ascii?Q?UqQCOLRkWqf4ttcmF4eh0EYtG42ExTbBb4QwoQyzNaJofXBn9jzw5lOLXiYT?=
 =?us-ascii?Q?AeIz6yoxHAYM3wTxFEmdVL+m+VEs2jKbzfRbERFYlzFNb+12VdoQwE3Jnjfl?=
 =?us-ascii?Q?c9Oju1W43PEe6sbumByEUkeYzLA/TmU5zpVN9kr0NIJZfdVjAzQ/9ow255py?=
 =?us-ascii?Q?ou0NTTDMyGVCjmVyK0KP4LM7MFvOM3WVUqI8fUwSVtg/AQ5rIvO6AhXLJX7F?=
 =?us-ascii?Q?BLlj6r1VnbLapAN05tI1RSRdCLt+HdY1XlgLs3d6864VTOKLDsIIX3nudDdU?=
 =?us-ascii?Q?dz/68vEjDsn7RlAZVJRuhxedql/1sCWhlno/cJHJbVOVSraukEc2r9S1Q25n?=
 =?us-ascii?Q?vhgBPhbjWSdwA/tM8KH/UwmtWZoLO4Hl5b93O5FM6Zfqxdf3bNdD7soyyh8F?=
 =?us-ascii?Q?u+SLTyhLYPPFeX8A0KJanL3m13k6ZcBt98jDayByYWGQcqTKuBsuZ+as5jcr?=
 =?us-ascii?Q?wqDj6L5LGqs1lh4AD4zNHKmfvisB2BaLEkUEd24WYUsR1e8651HzEFPM5+2H?=
 =?us-ascii?Q?D67I7qbdS2XLIohpWg57ElG2EtxU+JTcxyhbP4h4lkbqA3kCWG048QaAVbRs?=
 =?us-ascii?Q?/ICs+Bf87oDTBbBAZC1WCzdZcGe2e+dgZr+8JBcdPHBx/ABz78auS2PUa93E?=
 =?us-ascii?Q?laJL/xNpGDa/GGJNPGa2Rd3IwsW2aLZzbDkhQyc1ozk+4mPM0oRjecJIvCZl?=
 =?us-ascii?Q?WY1pWDeanr6Pw5UAcSNWFTqTbvYpuAWzAALGQq+g+AiSHrl5WCffCUbfndut?=
 =?us-ascii?Q?5uw/4lNx6AUpA+FBUMZZBYWM6UdUYXdwc0TzLIQlmY6RJLKx1x6+P+e3EMDL?=
 =?us-ascii?Q?8+cMoDEwNr5tuoPwbcsbdupguxR6Akvifa5r4k738FmgSLi8XBLPzT93G5cn?=
 =?us-ascii?Q?Wl0+yCM2lg6JKkm6KkKdQnH0vpnwB2Aq79e2inF65v9pya11VVk0wXdnGc8R?=
 =?us-ascii?Q?WHfr42whCpftBuzHyVLTXoUv/4v4lHlq7gMzLeXP7zmwpI8wzabMLxR6+3uS?=
 =?us-ascii?Q?wQfVcUSxM+clD6CyA66STcgXFFlMFvBET6HkDtHvSDjBgrGGrIfRK6dUHJ7E?=
 =?us-ascii?Q?n/K+Ne1dvCBh/TULWrt/9uMbjbnXUNdL3gWnoQxX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a7d4cc-ef88-4e93-acde-08ddc04afc34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:17:25.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhSJ5FUxgmbIY0oW6+M/74vFTcm/Cpi2aATAxn+pKQZHBmLWY7vn7U1ltyDdwnDzipikTXFELQYBse7RwyFrCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451

NETC Timer provides current time with nanosecond resolution, precise
periodic pulse, pulse on timeout (alarm), and time capture on external
pulse support. And it supports time synchronization as required for
IEEE 1588 and IEEE 802.1AS-2020. The enetc v4 driver can implement PTP
synchronization through the relevant interfaces provided by the driver.
Note that the current driver does not support PEROUT, PPS and EXTTS yet,
and support will be added one by one in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/Kconfig             |  11 +
 drivers/ptp/Makefile            |   1 +
 drivers/ptp/ptp_netc.c          | 565 ++++++++++++++++++++++++++++++++
 include/linux/fsl/netc_global.h |  12 +-
 4 files changed, 588 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ptp/ptp_netc.c

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 204278eb215e..92eb2ff41180 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -252,4 +252,15 @@ config PTP_S390
 	  driver provides the raw clock value without the delta to
 	  userspace. That way userspace programs like chrony could steer
 	  the kernel clock.
+
+config PTP_1588_CLOCK_NETC
+	bool "NXP NETC Timer PTP Driver"
+	depends on PTP_1588_CLOCK
+	depends on PCI_MSI
+	help
+	  This driver adds support for using the NXP NETC Timer as a PTP
+	  clock. This clock is used by ENETC MAC or NETC Switch for PTP
+	  synchronization. It also supports periodic output signal (e.g.
+	  PPS) and external trigger timestamping.
+
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 25f846fe48c9..d48fe4009fa4 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
 obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
+obj-$(CONFIG_PTP_1588_CLOCK_NETC)	+= ptp_netc.o
diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
new file mode 100644
index 000000000000..87d456fcadfd
--- /dev/null
+++ b/drivers/ptp/ptp_netc.c
@@ -0,0 +1,565 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC Timer driver
+ * Copyright 2025 NXP
+ */
+
+#include <linux/clk.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/ptp_clock_kernel.h>
+
+#define NETC_TMR_PCI_VENDOR		0x1131
+#define NETC_TMR_PCI_DEVID		0xee02
+
+#define NETC_TMR_CTRL			0x0080
+#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
+#define  TMR_CTRL_TE			BIT(2)
+#define  TMR_COMP_MODE			BIT(15)
+#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_FS			BIT(28)
+#define  TMR_ALARM1P			BIT(31)
+
+#define NETC_TMR_TEVENT			0x0084
+#define  TMR_TEVENT_ALM1EN		BIT(16)
+#define  TMR_TEVENT_ALM2EN		BIT(17)
+
+#define NETC_TMR_TEMASK			0x0088
+#define NETC_TMR_CNT_L			0x0098
+#define NETC_TMR_CNT_H			0x009c
+#define NETC_TMR_ADD			0x00a0
+#define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_OFF_L			0x00b0
+#define NETC_TMR_OFF_H			0x00b4
+
+/* i = 0, 1, i indicates the index of TMR_ALARM */
+#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
+#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
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
+#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
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
+	struct clk *src_clk;
+	struct ptp_clock *clock;
+	struct ptp_clock_info caps;
+	int phc_index;
+	u32 clk_select;
+	u32 clk_freq;
+	u32 oclk_prsc;
+	/* High 32-bit is integer part, low 32-bit is fractional part */
+	u64 period;
+
+	int irq;
+};
+
+#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
+#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+#define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
+
+static u64 netc_timer_cnt_read(struct netc_timer *priv)
+{
+	u32 tmr_cnt_l, tmr_cnt_h;
+	u64 ns;
+
+	/* The user must read the TMR_CNC_L register first to get
+	 * correct 64-bit TMR_CNT_H/L counter values.
+	 */
+	tmr_cnt_l = netc_timer_rd(priv, NETC_TMR_CNT_L);
+	tmr_cnt_h = netc_timer_rd(priv, NETC_TMR_CNT_H);
+	ns = (((u64)tmr_cnt_h) << 32) | tmr_cnt_l;
+
+	return ns;
+}
+
+static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
+{
+	u32 tmr_cnt_h = upper_32_bits(ns);
+	u32 tmr_cnt_l = lower_32_bits(ns);
+
+	/* The user must write to TMR_CNT_L register first. */
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
+	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
+	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
+	ns = (u64)time_h << 32 | time_l;
+
+	return ns;
+}
+
+static void netc_timer_alarm_write(struct netc_timer *priv,
+				   u64 alarm, int index)
+{
+	u32 alarm_h = upper_32_bits(alarm);
+	u32 alarm_l = lower_32_bits(alarm);
+
+	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
+	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
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
+	if (!scaled_ppm)
+		return 0;
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
+	u64 tmr_cnt, tmr_off;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmr_off = netc_timer_offset_read(priv);
+	if (delta < 0 && tmr_off < abs(delta)) {
+		delta += tmr_off;
+		if (!tmr_off)
+			netc_timer_offset_write(priv, 0);
+
+		tmr_cnt = netc_timer_cnt_read(priv);
+		tmr_cnt += delta;
+		netc_timer_cnt_write(priv, tmr_cnt);
+	} else {
+		tmr_off += delta;
+		netc_timer_offset_write(priv, tmr_off);
+	}
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
+int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
+{
+	struct netc_timer *priv;
+
+	if (!timer_pdev)
+		return -ENODEV;
+
+	priv = pci_get_drvdata(timer_pdev);
+	if (!priv)
+		return -EINVAL;
+
+	return priv->phc_index;
+}
+EXPORT_SYMBOL_GPL(netc_timer_get_phc_index);
+
+static const struct ptp_clock_info netc_timer_ptp_caps = {
+	.owner		= THIS_MODULE,
+	.name		= "NETC Timer PTP clock",
+	.max_adj	= 500000000,
+	.n_alarm	= 2,
+	.n_pins		= 0,
+	.adjfine	= netc_timer_adjfine,
+	.adjtime	= netc_timer_adjtime,
+	.gettimex64	= netc_timer_gettimex64,
+	.settime64	= netc_timer_settime64,
+};
+
+static void netc_timer_init(struct netc_timer *priv)
+{
+	u32 tmr_emask = TMR_TEVENT_ALM1EN | TMR_TEVENT_ALM2EN;
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
+	tmr_ctrl = (priv->clk_select & TMR_CTRL_CK_SEL) | TMR_CTRL_TE;
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
+	tmr_ctrl |= ((integral_period << 16) & TMR_CTRL_TCLK_PERIOD) |
+		     TMR_COMP_MODE | TMR_CTRL_FS;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
+}
+
+static int netc_timer_pci_probe(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err, len;
+
+	pcie_flr(pdev);
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable device\n");
+
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_err(dev, "dma_set_mask_and_coherent() failed, err:%pe\n",
+			ERR_PTR(err));
+		goto disable_dev;
+	}
+
+	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
+	if (err) {
+		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
+			ERR_PTR(err));
+		goto disable_dev;
+	}
+
+	pci_set_master(pdev);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		err = -ENOMEM;
+		goto release_mem_regions;
+	}
+
+	priv->pdev = pdev;
+	len = pci_resource_len(pdev, NETC_TMR_REGS_BAR);
+	priv->base = ioremap(pci_resource_start(pdev, NETC_TMR_REGS_BAR), len);
+	if (!priv->base) {
+		err = -ENXIO;
+		dev_err(dev, "ioremap() failed\n");
+		goto free_priv;
+	}
+
+	pci_set_drvdata(pdev, priv);
+
+	return 0;
+
+free_priv:
+	kfree(priv);
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
+	kfree(priv);
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static void netc_timer_get_source_clk(struct netc_timer *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct device_node *np = dev->of_node;
+	const char *clk_name = NULL;
+	u64 ns = NSEC_PER_SEC;
+
+	if (!np)
+		goto select_system_clk;
+
+	of_property_read_string(np, "clock-names", &clk_name);
+	if (clk_name) {
+		priv->src_clk = devm_clk_get_optional(dev, clk_name);
+		if (IS_ERR_OR_NULL(priv->src_clk)) {
+			dev_warn(dev, "Failed to get source clock\n");
+			priv->src_clk = NULL;
+			goto select_system_clk;
+		}
+
+		priv->clk_freq = clk_get_rate(priv->src_clk);
+		if (!strcmp(clk_name, "system")) {
+			/* There is a 1/2 divider */
+			priv->clk_freq /= 2;
+			priv->clk_select = NETC_TMR_SYSTEM_CLK;
+		} else if (!strcmp(clk_name, "ccm_timer")) {
+			priv->clk_select = NETC_TMR_CCM_TIMER1;
+		} else if (!strcmp(clk_name, "ext_1588")) {
+			priv->clk_select = NETC_TMR_EXT_OSC;
+		} else {
+			dev_warn(dev, "Unknown clock source\n");
+			priv->src_clk = NULL;
+			goto select_system_clk;
+		}
+
+		goto cal_clk_period;
+	}
+
+select_system_clk:
+	priv->clk_select = NETC_TMR_SYSTEM_CLK;
+	priv->clk_freq = NETC_TMR_SYSCLK_333M;
+
+cal_clk_period:
+	priv->period = div_u64(ns << 32, priv->clk_freq);
+}
+
+static void netc_timer_parse_dt(struct netc_timer *priv)
+{
+	netc_timer_get_source_clk(priv);
+}
+
+static irqreturn_t netc_timer_isr(int irq, void *data)
+{
+	struct netc_timer *priv = data;
+	u32 tmr_event, tmr_emask;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmr_event = netc_timer_rd(priv, NETC_TMR_TEVENT);
+	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
+
+	tmr_event &= tmr_emask;
+	if (tmr_event & TMR_TEVENT_ALM1EN)
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+
+	if (tmr_event & TMR_TEVENT_ALM2EN)
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
+
+	/* Clear interrupts status */
+	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static int netc_timer_init_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+	char irq_name[64];
+	int err, n;
+
+	n = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	if (n != 1) {
+		err = (n < 0) ? n : -EPERM;
+		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed\n");
+		return err;
+	}
+
+	priv->irq = pci_irq_vector(pdev, 0);
+	snprintf(irq_name, sizeof(irq_name), "ptp-netc %s", pci_name(pdev));
+	err = request_irq(priv->irq, netc_timer_isr, 0, irq_name, priv);
+	if (err) {
+		dev_err(&pdev->dev, "request_irq() failed\n");
+		pci_free_irq_vectors(pdev);
+		return err;
+	}
+
+	return 0;
+}
+
+static void netc_timer_free_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+
+	disable_irq(priv->irq);
+	free_irq(priv->irq, priv);
+	pci_free_irq_vectors(pdev);
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
+	netc_timer_parse_dt(priv);
+
+	priv->caps = netc_timer_ptp_caps;
+	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	priv->phc_index = -1; /* initialize it as an invalid index */
+	spin_lock_init(&priv->lock);
+
+	err = clk_prepare_enable(priv->src_clk);
+	if (err) {
+		dev_err(dev, "Failed to enable timer source clock\n");
+		goto timer_pci_remove;
+	}
+
+	err = netc_timer_init_msix_irq(priv);
+	if (err)
+		goto disable_clk;
+
+	netc_timer_init(priv);
+	priv->clock = ptp_clock_register(&priv->caps, dev);
+	if (IS_ERR(priv->clock)) {
+		err = PTR_ERR(priv->clock);
+		goto free_msix_irq;
+	}
+
+	priv->phc_index = ptp_clock_index(priv->clock);
+
+	return 0;
+
+free_msix_irq:
+	netc_timer_free_msix_irq(priv);
+disable_clk:
+	clk_disable_unprepare(priv->src_clk);
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
+	ptp_clock_unregister(priv->clock);
+	netc_timer_free_msix_irq(priv);
+	clk_disable_unprepare(priv->src_clk);
+	netc_timer_pci_remove(pdev);
+}
+
+static const struct pci_device_id netc_timer_id_table[] = {
+	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR, NETC_TMR_PCI_DEVID) },
+	{ 0, } /* End of table. */
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
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index fdecca8c90f0..59c835e67ada 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -1,10 +1,11 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2024 NXP
+/* Copyright 2024-2025 NXP
  */
 #ifndef __NETC_GLOBAL_H
 #define __NETC_GLOBAL_H
 
 #include <linux/io.h>
+#include <linux/pci.h>
 
 static inline u32 netc_read(void __iomem *reg)
 {
@@ -16,4 +17,13 @@ static inline void netc_write(void __iomem *reg, u32 val)
 	iowrite32(val, reg);
 }
 
+#if IS_ENABLED(CONFIG_PTP_1588_CLOCK_NETC)
+int netc_timer_get_phc_index(struct pci_dev *timer_pdev);
+#else
+static inline int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif
-- 
2.34.1


