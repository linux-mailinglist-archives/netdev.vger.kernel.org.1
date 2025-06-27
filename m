Return-Path: <netdev+bounces-201727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422DFAEAC83
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864CA4A3B20
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648317DFE7;
	Fri, 27 Jun 2025 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ALDetjyV"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3652F1FC4;
	Fri, 27 Jun 2025 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750990124; cv=fail; b=Z7mLy2Qps2cii2FtcSlGsMasALOPnEkRx8e22h658ere1yBDaYx3V3Xz9P/ppdK8op70EWsXnE6Jk6THB3qa2CBCZjmVyMV6DXoSL2e7Sk3xGC81MHP0ra7sCifYeqUXMPQAPwR7O2AQlJkk2g3GWpGjX+WduTWxoljAdE69r4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750990124; c=relaxed/simple;
	bh=Y513o5IqaTas+scJLRs7XUFnJvorDlhe763jwPjnrzw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iHe66RfkQ/w6UyZvTMDV/48FUPvQlviGVb7lNZY+GW5eiNKbSesGSayfbEd8ln+jCwQSUUp8PNE5FDvBHPpyQay4HVcaTCYyFSlUIjdJccVakY0RiQKhsNEldsKvAcbqDkjmjge0sM5mbzBVZGouB1jtBy7HDlZRaLZ0POMQot8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ALDetjyV; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emHouk+N1674gDVfxeKtdsXgRwuCsdOa4YOUiNXhcX2PTqw7wpztzW+sAw+smsmp/3i9cW9sz36RIwiT5uKYOsQN02JF2qNY9B80sF2e5iMFupjNTu4YY+RatdoY3/efrBOJXYY/5BaX2nPIDES4J5HAqf27gyWdkQpW+LUoBdZIjXF5/+N6RCCMhpoxeZ0e0M1P6/sMvvlmy29kBptSmfRO1O7EhX8P8GlBOFI3e18klhtOK18ZIN+Xqf8b47R5FXp21bqyUWUR40f41OZYoRd8lJnB9dUPjiRiycmZJHF+lYi3/rbqCZ/H9LEGufiqn4meVsI0f7CyJR10OnJ97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XMY3pvxvxhqrcZyFkVd4ICV1pncbNmfcqRMKoo+9kc=;
 b=IpLDCUsoLroTtruvDWD1JtJZ9ljPn1pq+Kx2A74wLQbycbSzkS23xk6G2LfJLKDRDMg77KvOj5TKw4sNPR6X295JU4D1QLrPGeLZjxC8LXSnWE9b2v/NL8XRyXjzTfXwMhyyEpDbkyujMu/QpEya8hcVORQwRoMtcC48glWVs+jAQ3WQbNkzqCwIIeWxtvPrEaNZTT+LrM30ObFTTLJMkjpr2Op7/1Y3YKvjlA2924+wgdNYcHZkcAFsrJiBvgbDXr3Zs88VcU9omxt+MpuNqbRm9NAy2LSwFghs0ije+aIrmzkDaUpGrZK4JMVeh6v3NZOlP616b82ScGwuXYOloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XMY3pvxvxhqrcZyFkVd4ICV1pncbNmfcqRMKoo+9kc=;
 b=ALDetjyViWa2+wt1U/lEBNAdTr0jB9FnLr7z+HsaX3vCkURlKpqtb2qv54ZE5Ds/P4H/gaHd3shoBFcLFP5krb4lviPbYj6bhjTz+oyJrJ3896EckNAvK+ejFtCrfyc7eMlLbgnZBWHPbuUG1jZYDXvBYtftO/I4PQHoprzduPaJcKmXj7kPJoQXp0K7R5PAPQJRHxBGUkXSkOB9lkSaq0a58Z1TTaaLeUobztE/m2vt/Z78SO0xQwvwqyoUBuIl8WR22HGvIc4U04qpESzjiJOFVY6h3CdcQVueP5zTNL7baOS6vH2SL1S8Dj2VNDsxfkeGGH8dJfSXJ5VsJBxwpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8377.eurprd04.prod.outlook.com (2603:10a6:10:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 02:08:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 02:08:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 RESEND 0/3] net: enetc: change some statistics to 64-bit
Date: Fri, 27 Jun 2025 10:11:05 +0800
Message-Id: <20250627021108.3359642-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: f998f1e8-4ff2-4177-f373-08ddb51f8860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GNl2zdA3S5vGXlOVgpp7TIDP6s4xju3WZ3Wipm9/Jug+yktEeTEVL4hS+j5K?=
 =?us-ascii?Q?VN0hUk2Pz9YzESgsDVjlRiyoCaScJFQ4bJ1UqLkKqLZ7REMay4t33u4o0yad?=
 =?us-ascii?Q?rUke6/VeXYnulgFWl5q3tp/WE3ekJCzhjf0Cej5J45QnohVC/h3W4kD0sTRX?=
 =?us-ascii?Q?expg8U2vE4NfiWh+6e+M6CxtWZo9QmaKfhZq+qJAmvziM2pCKY6w7HgTiE3o?=
 =?us-ascii?Q?PB7sCuLmqa7iwh5VkdJ6M1E8LqUOpOulVLSJKC+YCqoA8+Z38DCh9eBAYrcR?=
 =?us-ascii?Q?5APJDJ3kx6xwCeORNzy95rrbKrRfGvjP/baJn/IEBxZk9ljUFqTqRgDoz26R?=
 =?us-ascii?Q?KR33SAUcN2RW7O53usR3ow6iReF7yJyYT9XokIoHA4HQC3zbiQ/Zx/r6xLjT?=
 =?us-ascii?Q?3xkqA2itRSguBCH0k/K2Wz3c3JVX1b499YwLT07cMaVb+Aw+nDT47uU1vYOB?=
 =?us-ascii?Q?2tJDd2+qQDYYmluFSt8KpoLxrfzxKcrOJyCBzjnhFhMMD/wFsB68e8VGd1/B?=
 =?us-ascii?Q?QC49P1B3ZTLrAk5rQMgud+DTw11deNUuEttgdOxhi4KJ8HSstsMebkV8boEX?=
 =?us-ascii?Q?/9ewFRxzIp9ykp1sc03E7mGwuQSjjoGHvjrgJwUYRjra0hYMXNtJN6D23lTf?=
 =?us-ascii?Q?S72mJ19jO7cJXtx+hR2ANsYBbeaMF1iFoPiA4MDTLWkaLt7INbN2uF6/P+Oc?=
 =?us-ascii?Q?mYkAX6tFCTku4RKGigsuiaH1D76g3ByIVKzEmbFsXEn8bNXUCha8YYEddAIO?=
 =?us-ascii?Q?hPf3DJY1JXXTG/lVMeBQmKZKn374ewSVH4wKbUUHHbPS7r/R4d4u/fPH/i6Z?=
 =?us-ascii?Q?oyzBQuUviCzfWY0wX+YtiBl4YzYjiOGq/n4/rsbfgZDR0G/eS+GUR3USq4Wr?=
 =?us-ascii?Q?+5lVBsZBIPdOtHgAJIgjv/VmsotpbTR8OZXLHg8PHh1c6IUhPsCgEOG+3Taa?=
 =?us-ascii?Q?q6Lou89s37DhRPaZNgfc0pXVHTYt3Uhds8vddvb7js0Yr5LFJR/HHiUGfWyu?=
 =?us-ascii?Q?ZBYHXxyDot2T+qN8m+lCtw62ykfx1cF/wEPdLwB0YBtvixtAWIq2PxIixEAq?=
 =?us-ascii?Q?tqZyLSyCxCl6pdT7314kcXS3WtdsAGLmw6RblO+gEqgVbjKeYL1HwVmx1SyH?=
 =?us-ascii?Q?bCOs2ul1+B/LNpp0f59tHcWoXnGnTZsk3OgBIvifgZMw7CYpJhu3cvzbAInz?=
 =?us-ascii?Q?nHokZnVolV1HJDvZXnUfRrt/PfLDz9t7C+4DQMOSTMdXSO16ctwrlkdQOtS+?=
 =?us-ascii?Q?0pH9yxh+GY6D6rtVXpo/TP7v18WdmslH/tINWGmXOryxCYPSDd87AY7qI4js?=
 =?us-ascii?Q?hlofrVJHIun5TIxMW8sVrcd8+x6Ds5niSqMtAPC79yaeFtZhTXnwOjfvJHqe?=
 =?us-ascii?Q?YOfqhnMJt0HRo38ojZggwcm/R/SPFsDNJmHL7QXwoklX1IxfSLjxEkq6Jh2U?=
 =?us-ascii?Q?38EgrQLt4gO1f5rJx6k/trQ5c7f2LRGklqjRMtglZCrNPbcrz/LmAyBzl95S?=
 =?us-ascii?Q?rVrQsiJZBScgTwGnV8bsAypVizIzvNdZrtj5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lf9YXGwrkdqJOE3PtgdZKVeMbk873oC2M+md+35vB71BIN5DMHkUUprXD8US?=
 =?us-ascii?Q?+Hy8R7lq2neVZLq1K4YVvKs+TDqhDmZnK1yiLGWHoPDyi3BmH4RLB1/2JJ9R?=
 =?us-ascii?Q?iWEFz/7s4/hipIWbOSl9+8qP8OIZ3XJoSRpuhJOaPWJUtQK+a1atdlTuw709?=
 =?us-ascii?Q?nmXa4d4VqLI82l8j/IG4jylt35D8PqiUduAXizMSek0XXW1JhbJzwTDYNFZY?=
 =?us-ascii?Q?UzcMlASws4oiCHHd1Whch9wX5+K1gnc5U2xI7RTxAisMEfido6l9HaCWwDoF?=
 =?us-ascii?Q?XFjHIMHMKdD0XPRZ4zIZuVDjSgbniZW8NL0zHlpr17GBQ9gdkPTGGhHBYWuw?=
 =?us-ascii?Q?iI8BW7Crt4excVBrqDVPMFJ0ca6Il3Pze8nqq0NLRlYsASl3CZVO5J82dnnB?=
 =?us-ascii?Q?P/ypYQu17SFWtCHeL8mgFSxXhAXH8luHuBmEtjaUrXwYe6liGN/GCshJb9bo?=
 =?us-ascii?Q?hmylvGva1xshl0056sI/LE77USjAEi2jElFtLlVY5gPcdg5y1pxdm9IcGfJN?=
 =?us-ascii?Q?9SxUpEEGYTcmg6+DBk2r/hfrvQxXBjKtKaHdiQAmvwi7q1eHWzs76UILmdvs?=
 =?us-ascii?Q?T0KF0USr52War3+BuKwdfj7JSEjOEzVxjrNwPzODvScQiQo2iUJO++IVmjB+?=
 =?us-ascii?Q?c96a0Fvn43wa/3Mxe/vz+5wgo9wbYxqlA/2ULIrJ+SGiKN+Z1bcIvbTGdub0?=
 =?us-ascii?Q?UcrLIKg2Rtnm/MuHHX81eB6B22m2iRLqy9aoi+PIjms9cA97XT8WIrp27qm2?=
 =?us-ascii?Q?WwFuEyaU3R6CrCFE7hROV/pCNomQ2WVPl2zYzilxE444o6ZDGIh7nmsRKUeZ?=
 =?us-ascii?Q?DTvtQJ6zmXvv2ife6/1MsTOmdczr7efbagYQDhryrUr6ImBMVY7RdQyRfnLP?=
 =?us-ascii?Q?cv8mbr/RyNECaEh67okMkej8ayHDrKjeBdIcn+Xi3gBTyH6MJcGMacE2ZpYc?=
 =?us-ascii?Q?yG6m2Z8zXp+1gZRdR98LGVkqOrpd0EcsPV3V4qLKblDiWV9tWTwb1XKVWC6M?=
 =?us-ascii?Q?yTiCgNCXgPIdQjjfk2eqJP7Da6eEJcv3hkeCN+hNGxDV6OPf2Xx5I2Gtk09Z?=
 =?us-ascii?Q?1rcvhoSBzEELw63q9a56j26ED3JsrZWWj3WRndQJrkluRbEe14fmS5MCWMIq?=
 =?us-ascii?Q?aKHHvLaYhBit5iRd91VYAkz7N1ws7xvGvZ0WQPsWwjXfuFbJB9pKPdPM8CbM?=
 =?us-ascii?Q?g5Ac3zwRmyLSSWwM+Q45htkGSR/ZLe0m+GKGC4v/QTzsadtd2WJmPgN5sblA?=
 =?us-ascii?Q?DyohOwYq+vib4rwAgXpkloLrF3uGPgrjgCm6yAZH1LxD/UMwdehy/m27ESQJ?=
 =?us-ascii?Q?dvt1i2KS/uTqZQWPCttX6VyUYZZHv1BzT3DuQiTMTvhd9BJUGlIvt4lfBvGZ?=
 =?us-ascii?Q?UwjrpZQHgbDXMQQ6PLbIQYA6wt3CYM0Gb6qQ35+kV3D7TMFFgmtwkn1dHymW?=
 =?us-ascii?Q?L9gRlF/37ehUEVpleci0ySgGnb2s2cZBTU5lB1Ur6uDq9/Y3ocQNKrgqfPlD?=
 =?us-ascii?Q?ie3wmeJyTmZFsSe9NKFiN8LM+WRUJcV+csIQTQo1tr02DP9VX+IcYCB7RK8y?=
 =?us-ascii?Q?IgtU3uE19xBh/jGyh8ksrPGZd49vDZ+KBdqrbQfF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f998f1e8-4ff2-4177-f373-08ddb51f8860
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 02:08:39.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKIxilLNCUbX4XY4dgXR9QZhz5VIm7uK+P2Q0PaR7TNHjBCIQAcbR8/NOAS0XFbmVOWchcjY1C2pt7+bSepURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8377

The port MAC counters of ENETC are 64-bit registers and the statistics
of ethtool are also u64 type, so add enetc_port_rd64() helper function
to read 64-bit statistics from these registers, and also change the
statistics of ring to unsigned long type to be consistent with the
statistics type in struct net_device_stats.

---
v1 link: https://lore.kernel.org/imx/20250620102140.2020008-1-wei.fang@nxp.com/
v2 changes:
1. Improve the commit message of patch 1
2. Collect Reviewed-by tags
v2 link: https://lore.kernel.org/imx/20250624101548.2669522-1-wei.fang@nxp.com/
---

Wei Fang (3):
  net: enetc: change the statistics of ring to unsigned long type
  net: enetc: separate 64-bit counters from enetc_port_counters
  net: enetc: read 64-bit statistics from port MAC counters

 drivers/net/ethernet/freescale/enetc/enetc.h  | 22 ++---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 99 +++++++++++--------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
 3 files changed, 68 insertions(+), 54 deletions(-)

-- 
2.34.1


