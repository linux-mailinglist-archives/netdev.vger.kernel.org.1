Return-Path: <netdev+bounces-219584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B34B420C0
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD56E7A5A43
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090BD30E828;
	Wed,  3 Sep 2025 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YYM1WWB3"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1F302CDC;
	Wed,  3 Sep 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904893; cv=fail; b=QbJq57wmKgWy2TtpiqQF6wkXD1mRyhah7CBkUNBrOcGJRnvrCFRHZ7wMz5rZrjSvmgwm3Hzy5mwf961E5nmJdrUbUIIp4uKxF4fkzuKTv3DpxisHOHjy1JMiWdCwBbpcVPYfWz9tGD4H+Dhl9RPqwVN5LPdOHPU/FQU22bRcP74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904893; c=relaxed/simple;
	bh=yg+HjEe/IABl83n0z+V8ZKF8/QGGwd8WAVd8DpvNbVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DCxZVTqoj33rZYMBmxfpF5CmzVdNxxrI1tzOLO8zahfjjMzBwpWUqG1OTcJAAfEWmRZJ84U+AgY1gnQxbEDHqykaEYAwkWXeHih9wKq8tuR0fWrw2q3ZqwaKE/ygJTSab2z1HY0i1zsJ3qyNINkI9sDj1ddtqfzT9LPIDllYWtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YYM1WWB3; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nzji+IymRRlqR7H8sryycT6W0LG+8C2DK+yTE4Ad3VlwOoWE8k94ir32nyXsebZ3Nw/FW2oTo+qgxN5589slsKa647fWKxZtv4R9tTNqubqAtgftSNY6qCmsczw7tmlV39v4SEeJNYTjboMElpqIAsbhGBOwG+xBuTtkP6I6MSKnRwGqS7LiY9u5kTZWyy89NTKwcoit3AwxaEbpQLBucRl1ey9e4GuJ6QT6Ww6ytzXNFfz7hc01qwXD47q35cG2ulFZJ+rx1WnYzWtQahda8lnimBOR3lgP4XuyRm0COH9no/8CS+ZZPb9WyJkDtTF8AL8uAyuC3RzE8tVeIHdZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h+EZQ06yPwEDBK6OttNNTqQz9r7LzBnBWIz+0Gflqc=;
 b=NkjEcVsPFDL0A138DwfkKbgN5AB5hL38TayNq4MiifFTD5gNTBW0h5kid7zmEah5QS7clgs8tKbHBPW04hldaI3hzaJUyi75UcLanp31b9HSBMdLSgEY4eqr98pe6FSqHp4JMc4cFf13ctRGckxFutiUv02MJKW/+oIdFA7ZcjYqXGq0Bxwz0MGysRBUfMgKjYK6gn6uVCtH09x5XBkDX02m9NwzMwq+j6v/r23rvYNw815l0d/Bq6IdxsFEvwitQx2VFw2Jw8aJb/M07cFfWGRIzqUk242y3N0ELD0NxTkUxIUFvzDL+FJbUgekUcfEBQcN1Wc3XakXhKRtASKkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h+EZQ06yPwEDBK6OttNNTqQz9r7LzBnBWIz+0Gflqc=;
 b=YYM1WWB3iwEhRI1YuSYwHCtOWRNxQNhNfgWOfqIEtoP+ZWbXAVzX/BMGjS1zPk2Qdq3NBvQfGUY0rMn64INyCAGbMxfclEy24iXG8uiFzlqOvrhxs/TirvfdHAtNGzflPZRPApcu8vYpD5suzJuU5IFVwblHJ+KNJ9hXB7M+Fas80w1ayNXzpMImuM9vw+j7all78CoAxfVvKyoFnkn03lVDFFqEQZDI0tRz5BexCvb6Wq51l3jkABR+MBvTAFg9zB0vi0DwXohQbg/Hky9pHU3BHWKGciYmlcx4EeIbshX04bYw8dyzRncjsQIrxu2/7JLW4yD0qcXqPQNdQ+eorQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10420.eurprd04.prod.outlook.com (2603:10a6:800:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 13:08:02 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 13:08:01 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Luo Jie <quic_luoj@quicinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/6] net: phy: aquantia: create and store a 64-bit firmware image fingerprint
Date: Wed,  3 Sep 2025 16:07:29 +0300
Message-Id: <20250903130730.2836022-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
References: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10420:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6f25b4-183d-4472-4917-08ddeaeae8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3XnRBCAmtPnxdd9bTBboq+45c0XkUUfBYqkScFHA1/h8gfnwF94bfI/jFzQh?=
 =?us-ascii?Q?nEJPJY44yE64MJaL7r01U4lcvvjZT5d71q0u3D+G9f72HiJMGdgUoFXihn8l?=
 =?us-ascii?Q?AhqPAdJV808aSecFDsHMLDMvv8VQBsdtDHwpVY7nRTOQi3q8tACt9CV2fbdV?=
 =?us-ascii?Q?IIXZU38b4sj62Zj2rJyFirlsF2nTuOlfyhiWzi6rNMR7zkKhQL4NcmsEpid9?=
 =?us-ascii?Q?WUbnF4Jv/dLQiLUP3bux53yne9UxWCGCFaXxVrPb0Z86/mkA9IypTXQZveP4?=
 =?us-ascii?Q?IAJre+09HMqA1uF5fiKmKVS+8+dBgsvv5+lZBHfMGxqtagJQjIPwgT0ONs1b?=
 =?us-ascii?Q?WTmvUYDMGuYEFLGYBFvE19JslUJLRwbJwch2Bf7NjMtozTnEAiiJRg9m6MI9?=
 =?us-ascii?Q?bQ7FHr6MTzu/D/XWzJ9AeaONOLy+LT9PtdU5i9Re6HS/LWnaGK1GbAKzjQIE?=
 =?us-ascii?Q?7/0iKcNiqigyBZQ8rr3lNl+7cQOM+KtoPJo3JDQAf7SM1+iaRs/RC/VsWnLh?=
 =?us-ascii?Q?EgRPpyrleovmLb0HZgRaKhIXZWKG7eGJDwepX18CxySFFVWpS8r/nIvmuvlh?=
 =?us-ascii?Q?T4i36zC1RDWp6g+enLQV8ntsoW9nMs3t5oZtPPdps4Gv6KkJbPJpPxkdk+Lv?=
 =?us-ascii?Q?ExowkYxxeUnbHTgP8rwP9knS0B5j53IXZaGlYCQfu1qqgIGYO1hMV7aRo92H?=
 =?us-ascii?Q?AmYznmK+PYfzPuTl5eXdJ1Dy2BD1qF+kJACixfsCaG4NEAVuj+2RLuBvEJJW?=
 =?us-ascii?Q?E0orfuc1baAigLT78p6bJo2qIOqb8tWR/pTDIb2S0zFEbR3DTOSwg0ODxonk?=
 =?us-ascii?Q?OUiM0RBReDfEeyDuxCqmQ4tsoKoTICa6bFqhwaps09B173VqTb7vwP3ys4fK?=
 =?us-ascii?Q?ryMvWVbgodImMvHkYP0Z9BGmrsAfC7W6DQgbcO9AeMQZPDj9J2LUaLCN8OPu?=
 =?us-ascii?Q?tUvIg/8leCzpkOHNi7kD/iY+ZxWE7KsKo4WOiIY/ngo1NgUsb4h/5+X0Qk//?=
 =?us-ascii?Q?c3acn/49IBSMWlq5Lmk6zVs0jWqUxB9FIvKNUN4WkGUkDmKwSffVpietSh/I?=
 =?us-ascii?Q?BQjNBCy1LQioNopoQ5EnoQZkNSAFL0sEHsq9ex+P7hl+DTrPYmBG8LYeAur6?=
 =?us-ascii?Q?LaJInAOCjzg4jTvklSLQMmX18HAUDhEWLMUwvUpA4cu8bSmHdf4CBQ/QhXdB?=
 =?us-ascii?Q?dCE4q+88GmOmMFjgqNRtLlwbDi4GXO/U5fdMiAaV9fR84r4m45WCC/7e/kLR?=
 =?us-ascii?Q?6TbatBXOLDp1aHCmcJBk/fZ9tIckJXhhvdxwiQON1IhNyI4rL5MsS9uHDF9x?=
 =?us-ascii?Q?A9/D072vrVNNPoteT3Y9ufbv6BDD6cLhZv01awkUb0lOsOyiA0ug4tap253Y?=
 =?us-ascii?Q?WtzbuezXjxLY+0dITHW0KDSn/h1cZOwUUSShH7xqrlEG0qijcu68Rz4OdW7G?=
 =?us-ascii?Q?cMqm5Z/u1W2slvp9o/ESJw7JmmbLsccY8Z/BQm8pZguqR3yawkoCo9IS0A2Y?=
 =?us-ascii?Q?hm7R+PaBGG/ajE4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?128FOB/+uXy7hAJ1d0qLkT/HGPcPCNUkjSie0Ps90+t362PbodyLQ38iPDTc?=
 =?us-ascii?Q?W1D7d8zL/H1wh7OH358+X0DwAmSO1vAspvxt7oN7D3s4mDgVrut14QsKszmy?=
 =?us-ascii?Q?s1V9FMp6FkKWx5uuYxfcIlDiHfw9lFPvkIXFIcQ4FqYsN+gO3tna7FiukqLG?=
 =?us-ascii?Q?vv0TTDWSvPkWjDxKnRprcxnJ1HXeA8F363YRiRNm8ODW7oI0WBKt/SHxsERO?=
 =?us-ascii?Q?I/bE+cjgaThqeczc9y97WgaB48No/unJNkyZqf9i7h728n2NcIr5+eGqw06O?=
 =?us-ascii?Q?J27UC9nDGzaTDVF3fMN8UVBzYxLYM3AXa6Nf+nk7dJNjDejE5pbnjlCVq6p4?=
 =?us-ascii?Q?Ub0E7Xcwt/zlTnI7fBzVHCgfk28PJTMnl6ZjY25nilgerTcAuEFbumdSdMvN?=
 =?us-ascii?Q?kkrlH/wOR3e2q1ceSyUW6ghIbzlLu8dMv6vo//b4q7wVhuBtWKOqSGbq/11w?=
 =?us-ascii?Q?l0MBG6eWyqCjsQXhsiWs/RKaYzWKkby8ny45VUlyoMCdYvLdWh2ZEJ7GU9sl?=
 =?us-ascii?Q?FHRIZBpk8rRWsmA9bCBEf3lwNhGEgQZ1k8Er7J6MfKrL9tDgeDysfpNnUmpW?=
 =?us-ascii?Q?J27svotCJTqXIIWvyNLhu/7HVzwOQp1+Qs5BJKKOdK2ySR0xHF93vRLF5b1S?=
 =?us-ascii?Q?U6nbuMBwg4QuXPyWEMHIZiCWUqQsY8S19+2anrWYp8laUvg8o0yekSOhmTkH?=
 =?us-ascii?Q?PwpYp/iOrKLIUljqiJKl5gHrH7eyJRN7YKCcC4RN7vxdbih/9rMXHvrxnp0v?=
 =?us-ascii?Q?ozisKmVYafE+rWVyJ8iN2ozLVjatKmdU1PekR0FF1ikNQlTeRWDUFe4wbqwR?=
 =?us-ascii?Q?TLmw7w99s/RiLxg2EvEwNCaJvNxaiEzk2l+2hV9lg5r/Ps29U72kFtfVblzM?=
 =?us-ascii?Q?qyeYkbnGqiO/tAS+PlCn05JGVlVHFr8v55qHOLXof4M8ugGqu+RHz0bbueNv?=
 =?us-ascii?Q?bdDdrytYpUbAd34TbJKiY85avRzQIcaiRPrkeu0Qbpkg/xeiFtCDimqaCtWC?=
 =?us-ascii?Q?sAx/6LPXRo0hkXE7mKyuuJzwccr8RLj7qRdnJdxF5x4FT8+LYutt2GYoOg90?=
 =?us-ascii?Q?QPcQ9Y2apLMud3qt8UA6aO91NLZaq2eSnImpbj+jpTnWEvvWmzPfvuXBNMFG?=
 =?us-ascii?Q?CqfDeSGCfjkJpNmhjFJYiHIlXL2dUR9BRgrbtV4PsA+JLoqzrPT44uxJeY6q?=
 =?us-ascii?Q?RthizdK8kORYV1qGvikP5NXLyrntnGeRnwQkxiPuoKe4EEJw5Pe3A/XumVgx?=
 =?us-ascii?Q?QwiK9WxCFlKxUroC0E/HpaEygI5v0lme8IYZKQz8T9oFUtbxlwzvERruvdHW?=
 =?us-ascii?Q?w7BQZCgQ/zL5l9klcEPh+BCPDaD4OnpLSa0SnlXXx88PKELqshT7acqf/Bg7?=
 =?us-ascii?Q?C/m9p8Z6KD3ID7yGH6ygy+LlMM8HHn9JbNwdK7uL3xKoXexFAeDRqWHyemtq?=
 =?us-ascii?Q?blCbw+Id+OwoJLASZRV73ynAc2ewhxvC+pfbhPpfvyTrdZMeG2YqkdHJUd0w?=
 =?us-ascii?Q?7NALAzXHTPPBtlEhdXCBbLShB8JOOcFpfRSk8ai1YtDlIhN5sm6YDCgXn3+U?=
 =?us-ascii?Q?9f0EW75HtAtL1Rw/XP57pYbIfWyJDQBZKkkRccAo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6f25b4-183d-4472-4917-08ddeaeae8d8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:08:00.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNEa5pa/1WEjvHGz38I409t1s2r5jOTaBAM8CESpZKYYcRcgAJq+jPLPnbpMztYsIdTSjj082HZee2W1wpfFHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10420

Some PHY features cannot be queried through MDIO registers and require
alternative driver detection methods.

One such feature is 10G-QXGMII (4 ports of up to 2.5G multiplexed over
a single SerDes lane), or "MUSX" as it is called by Aquantia/Marvell.
The firmware has provisioning to modify some registers which seem
inaccessible for read or write over MDIO, which configure an internal
mux for MUSX. To the host, over MDIO, the system interface appears
indistinguishable from single-port-per-lane USXGMII.

Marvell FAE Ziang You recommended a detection method for this feature
based on a tuple which should hopefully identify the firmware build
uniquely. Most of the tuple items are already printed by
aqr107_chip_info(), and an extra set is the misc ID (reg 1.c41d) and the
misc version (reg 1.c41e). These are auto-generated by the Marvell
firmware tool for formal builds, and should be unique (not my claim).

In addition, at least for the builds provided to NXP and redistributed
here:
https://github.com/nxp-qoriq/qoriq-firmware-aquantia/tree/master
these registers are part of the name, for example in
AQR-G3_v4.3.C-AQR_NXP_SPF-30841_MUSX_ID40019_VER1198.cld, reg 1.c41d
will contain 40019 and reg 1.c41e will contain 1198.

Note that according to commit 43429a0353af ("net: phy: aquantia: report
PHY details like firmware version"), the "chip may be functional even
w/o firmware image." In that case, we can't construct a fingerprint and
it will remain zero. That shouldn't imact the use case though.

Dereferencing phydev->priv should be ok in all cases: all
aqr_gen1_config_init() callers have also previously called
aqr107_probe().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia.h      | 20 +++++++++++
 drivers/net/phy/aquantia/aquantia_main.c | 42 ++++++++++++++++++++----
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 3fc7044bcdc7..2911965f0868 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -153,6 +153,24 @@
 
 #define AQR_MAX_LEDS				3
 
+/* Custom driver definitions for constructing a single variable out of
+ * aggregate firmware build information. These do not represent hardware
+ * fields.
+ */
+#define AQR_FW_FINGERPRINT_MAJOR		GENMASK_ULL(63, 56)
+#define AQR_FW_FINGERPRINT_MINOR		GENMASK_ULL(55, 48)
+#define AQR_FW_FINGERPRINT_BUILD_ID		GENMASK_ULL(47, 40)
+#define AQR_FW_FINGERPRINT_PROV_ID		GENMASK_ULL(39, 32)
+#define AQR_FW_FINGERPRINT_MISC_ID		GENMASK_ULL(31, 16)
+#define AQR_FW_FINGERPRINT_MISC_VER		GENMASK_ULL(15, 0)
+#define AQR_FW_FINGERPRINT(major, minor, build_id, prov_id, misc_id, misc_ver) \
+	(FIELD_PREP(AQR_FW_FINGERPRINT_MAJOR, major) | \
+	 FIELD_PREP(AQR_FW_FINGERPRINT_MINOR, minor) | \
+	 FIELD_PREP(AQR_FW_FINGERPRINT_BUILD_ID, build_id) | \
+	 FIELD_PREP(AQR_FW_FINGERPRINT_PROV_ID, prov_id) | \
+	 FIELD_PREP(AQR_FW_FINGERPRINT_MISC_ID, misc_id) | \
+	 FIELD_PREP(AQR_FW_FINGERPRINT_MISC_VER, misc_ver))
+
 struct aqr107_hw_stat {
 	const char *name;
 	int reg;
@@ -203,6 +221,7 @@ struct aqr_global_syscfg {
 
 struct aqr107_priv {
 	u64 sgmii_stats[AQR107_SGMII_STAT_SZ];
+	u64 fingerprint;
 	unsigned long leds_active_low;
 	unsigned long leds_active_high;
 	bool wait_on_global_cfg;
@@ -216,6 +235,7 @@ static inline int aqr_hwmon_probe(struct phy_device *phydev) { return 0; }
 #endif
 
 int aqr_firmware_load(struct phy_device *phydev);
+int aqr_firmware_read_fingerprint(struct phy_device *phydev);
 
 int aqr_phy_led_blink_set(struct phy_device *phydev, u8 index,
 			  unsigned long *delay_on,
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index a9bd35b3be4b..5fbf392a84b2 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -88,6 +88,9 @@
 #define MDIO_AN_TX_VEND_INT_MASK2		0xd401
 #define MDIO_AN_TX_VEND_INT_MASK2_LINK		BIT(0)
 
+#define PMAPMD_FW_MISC_ID			0xc41d
+#define PMAPMD_FW_MISC_VER			0xc41e
+
 #define PMAPMD_RSVD_VEND_PROV			0xe400
 #define PMAPMD_RSVD_VEND_PROV_MDI_CONF		GENMASK(1, 0)
 #define PMAPMD_RSVD_VEND_PROV_MDI_REVERSE	BIT(0)
@@ -677,27 +680,46 @@ int aqr_wait_reset_complete(struct phy_device *phydev)
 	return ret;
 }
 
-static void aqr107_chip_info(struct phy_device *phydev)
+static int aqr_build_fingerprint(struct phy_device *phydev)
 {
 	u8 fw_major, fw_minor, build_id, prov_id;
+	struct aqr107_priv *priv = phydev->priv;
+	u16 misc_id, misc_ver;
 	int val;
 
 	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_FW_ID);
 	if (val < 0)
-		return;
+		return val;
 
 	fw_major = FIELD_GET(VEND1_GLOBAL_FW_ID_MAJOR, val);
 	fw_minor = FIELD_GET(VEND1_GLOBAL_FW_ID_MINOR, val);
 
 	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_RSVD_STAT1);
 	if (val < 0)
-		return;
+		return val;
 
 	build_id = FIELD_GET(VEND1_GLOBAL_RSVD_STAT1_FW_BUILD_ID, val);
 	prov_id = FIELD_GET(VEND1_GLOBAL_RSVD_STAT1_PROV_ID, val);
 
-	phydev_dbg(phydev, "FW %u.%u, Build %u, Provisioning %u\n",
-		   fw_major, fw_minor, build_id, prov_id);
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_FW_MISC_ID);
+	if (val < 0)
+		return val;
+
+	misc_id = val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_FW_MISC_VER);
+	if (val < 0)
+		return val;
+
+	misc_ver = val;
+
+	priv->fingerprint = AQR_FW_FINGERPRINT(fw_major, fw_minor, build_id,
+					       prov_id, misc_id, misc_ver);
+
+	phydev_dbg(phydev, "FW %u.%u, Build %u, Provisioning %u, Misc ID %u, Version %u\n",
+		   fw_major, fw_minor, build_id, prov_id, misc_id, misc_ver);
+
+	return 0;
 }
 
 static int aqr107_config_mdi(struct phy_device *phydev)
@@ -745,8 +767,14 @@ static int aqr_gen1_config_init(struct phy_device *phydev)
 	     "Your devicetree is out of date, please update it. The AQR107 family doesn't support XGMII, maybe you mean USXGMII.\n");
 
 	ret = aqr_wait_reset_complete(phydev);
-	if (!ret)
-		aqr107_chip_info(phydev);
+	if (!ret) {
+		/* The PHY might work without a firmware image, so only build a
+		 * fingerprint if the firmware was initialized.
+		 */
+		ret = aqr_build_fingerprint(phydev);
+		if (ret)
+			return ret;
+	}
 
 	ret = aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
 	if (ret)
-- 
2.34.1


