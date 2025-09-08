Return-Path: <netdev+bounces-220871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E99B49504
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BDC07AF1FC
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D3F30FC0E;
	Mon,  8 Sep 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V7R6a2v/"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013049.outbound.protection.outlook.com [52.101.83.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B2430F7E9;
	Mon,  8 Sep 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348323; cv=fail; b=oKQ5h+xwdrY8D9qc3rJnrZKlCGGWwhm2cr0cr7eiMcnX31y8laxgWT+8qIVrtinznrjaIBfHJJZ2SE0+4np/GGs1PRabUAvQK7v/EQ2N1TcnFicYkyWmtwuWLiRdZn8VDhFUzom0iokgTfcl71f8x7GBC/e2tmgYt8TVSkaQuCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348323; c=relaxed/simple;
	bh=a/sNtQokyLBs6bmzUlrxLkns4sFzN4xV5/yESDgATYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J6zUysKoI2tu3P/a1+xmHlp50LHLLeQN+jZfpLj0uEwADKjq+Xr/D2hilAq5gqYYrtYrqfdImAAoy3EXfdQq9dC4v9vrrm2x5r6KtiWrE9BtuFs9srM//ZWAPIjo+m3c+yo82/slmEDyVlVnamAfCOOtb1WpNaEjeMMlp9ipoNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V7R6a2v/; arc=fail smtp.client-ip=52.101.83.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4ln0rJbUhFBU0EYt8yvJIMUS611lSNcEmdGDijyv8WbTEuKGu5Qvsq68EIpo6zKxJkMt6ZIhHGLbotzjcbis0RzGGkOsgr1oQXrFv+BYeqXq57dMQaqBcPvrJ/Qe13eVndfDacrFlCn9PrMj/Z8mUiTZg9Wm1gV7A0v1xg8hZAX4CNP6nhLdZCwR0dYpa3dFcitvYmz3mu4aJNIdqi8j6bO7fei2exxyu9vveL8eOkBxbC+XgIz2VIB9otWwo1nuieqhk1jt6X1f56LD2cnl/pI7ErzKtcKC42/7Hx+Nfx1BhN9RVbjU1h4HBqoMl9wuPs8zbVSbe/tOAk99Lt0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajPPmMMAiji1gG1Cv3tcktaakhD5yXwg6GRMCxSrZ9I=;
 b=eL0DhAHHpLlHFYuRtL6OPJM+BJKKXZiBAbSQS7gx6daR/iZiaMcqdILJcc3QH5BagJneO7EUZtJ+1VqEN7cYfhApd529gnJLKkIivWY3lPyZxrrMjdXXaFLnBK5M/PfmG+5J7i9EfB+zNketsMVmdqDHNzH8e+jpSyRr6vJKH228tt8C4xxz3VPwpUZBMOnFChRs2AoHZF7dVMMoUD5OywONb6eZ3hXVTwHGhOGU8QxuDYkkDbmvMEbd9+VmpWug7eXSwel6NHY9SY6A0KAllJlya9GWVtA9osvhCbVq+Vurb+/Z5eX2YGV5LcKWuM0uvaiVLoPo3ik3pW5E36haMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajPPmMMAiji1gG1Cv3tcktaakhD5yXwg6GRMCxSrZ9I=;
 b=V7R6a2v/0CO8ANICg5d2sSUF2/TYnHq+WYfjfFobdzvEJqHRKmGpnGmr4rxs1iK9Tck9dZ9FYpQnXyTzO//7uZzhZ3fq5zhygI5jIn1R7JS+qutgDTegfT/5G1Lc6f235K/XXd3MjM/ZaDk733OoPhDE63TaqTYgsdeXdAmkyI2Iuvl7Qo3pPAFxQfcx0HgkncNqWtS+gtbxVsI3NeKKThz7KEaEd1U9uL0JOdw45AJA7kOPjDbONIfq659Snbc0kwC1EDdDS6ZevzyCjVkqh8KU+XRn0d/0BgqZ9LG+6ZrxB9mLkTIgctlzRg69vM88fP92yPCb0gxIlEVC4jwX+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DU2PR04MB8501.eurprd04.prod.outlook.com (2603:10a6:10:2d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Mon, 8 Sep
 2025 16:18:37 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 16:18:37 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com,
	Andrew Lunn <andrew@lunn.ch>,
	Frank Li <frank.li@nxp.com>
Subject: [PATCH v6 net-next 1/6] net: fec: use a member variable for maximum buffer size
Date: Mon,  8 Sep 2025 11:17:50 -0500
Message-ID: <20250908161755.608704-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908161755.608704-1-shenwei.wang@nxp.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DU2PR04MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 8243c497-a363-4256-33cd-08ddeef35de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T+ITfUPSauLwefww5ubXGdmGhDdrmvd7ac1ssR5n03PjIN8fcyzzmMOVVeuS?=
 =?us-ascii?Q?4OUH3797k1BtB9kyobZaJjFZd7r+UoIg1JnDJJCNZmTv/V+rAAZYi4avu5K4?=
 =?us-ascii?Q?woqV6y4lwQE42MubeCTOaPo+EVqSAOIa8hN7ODIgPuYWtV58Ha2wm8A8W23L?=
 =?us-ascii?Q?moi4xw5z4jhVIgjddMvsR0/oQGOz44avHV8GMGyg42bEcZQqxIuWIpTRPi94?=
 =?us-ascii?Q?25q3wOlNSeoIJP4vXUkSf6GTB4RdGKRPSaJjUUaWjI3YKxoqaP8Eq9+3Ig/M?=
 =?us-ascii?Q?QsRX8V8a23izTnEjGDtEuKQ750LheHmVAts0UeILAMWSPwBXU4PF8XLGfIg8?=
 =?us-ascii?Q?y4LYghCF7PH8LYWrW91GzaShscESIkf/kaXG+qBY+4bnmE4SfxBtsaCb5Iro?=
 =?us-ascii?Q?Zid+vKRqtbbN7slUBvLww+400hKiNebjxTDApKAbbNUii/e/KXM4MQYGYwes?=
 =?us-ascii?Q?gmXee9x/aq5bXCrWH3MquHhotpTNEolDsjcqrqsfDEBUjM3z2cJhawBV0ASi?=
 =?us-ascii?Q?WiDM+9uSgMtOBRDOcin2o5u1jAfLlA/x376iFTUDnya36cJF5mPBy2clgzHQ?=
 =?us-ascii?Q?BAG8g0u6XBXFQe0HlKkwmSegb9G8euc2Sm0NSBCm2/gBVrEI2/qIPd5EIznS?=
 =?us-ascii?Q?sWJsv2ZG6EDluZ8/JAl8woOVZhTONmybpA+A7/jgiG/bGDA8frbKOu2UHD0A?=
 =?us-ascii?Q?6Pd/HBnrpxIFZrsg+xnT1d5lXgK7/NDPXnpsASxQS2w3jP8iK0a/CzyHgVJ2?=
 =?us-ascii?Q?q9czQYNPeAanKeqLM31I66f+ARRG61+9M5tiQ2TbBMBtNrP1I9fYxy20+nW3?=
 =?us-ascii?Q?Vhy5caviQPe2Y5uWDXfcz0ayBj2mf4tsTIxpXGf/C0UCRb8Ro0yzTdyFh0Gt?=
 =?us-ascii?Q?er5kHAamZkKCMPDCiSEMzHKp+9IQLQ4OP3+6Kuv5yF9pthjc4Yx+oKRoO4Fj?=
 =?us-ascii?Q?PVmGeAAFBJtLgmLQNKi5bfHtKq4Gf6YrsJMhldQblHHnTvnkvlib9rc4fAdn?=
 =?us-ascii?Q?c+OliYxCv4mGp0sK0J6LBos0qzBZx3R+7M0Nr+uRPVVAxlM+YpGpwlDAWJjZ?=
 =?us-ascii?Q?KjpkWKmx/JxWlIMHDTd0JLPXhay52VkB5vvJ0pZScrhVxgQb+Igc1T2v9Q+Y?=
 =?us-ascii?Q?Ezk8EWB4JoaUeT047ZR+fOy1N+7QF7qbwY/cEeYIbynSnjz/wvEoWAdPRq4q?=
 =?us-ascii?Q?qyoitzXMwnkKorZ7Xw497IZHfEs68Ct/a7eGoDHEW//s2OXi41K5bis03rDT?=
 =?us-ascii?Q?9P7Kkam7gzjt6Awr/xdmmuGUoC9P8vevcbRm5fhxyiIeJgc8mh7OSRYYusFy?=
 =?us-ascii?Q?2wJgnAK8FkBHGUccWdCuxNEqatQZGrmSdOKGBDUqSr4aQWy2quygSL1reMNB?=
 =?us-ascii?Q?7b12RiIeuAVMRtRaHoTDbof64dfoiB+ovhwtU4aKrTqPcHNRsrU1/ogKuAN8?=
 =?us-ascii?Q?KBTs+JicSycLwYBLj/p4qqDci+hgzKDo21RoR4cwKrhhwth3vbZFF3zpuOHj?=
 =?us-ascii?Q?CSo8Zuh4uDEGslg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FUevkrcyo9syz1mhEAg6ZAgJ49vS0OgLt2g/NHw/kWonjLcZtpXlePtDZlwy?=
 =?us-ascii?Q?7Sfm+R5OMUZkXJXMj3JpSLE82ysqqpg+DBHpkcRxYsgbcI2k/ESgo06+f4xQ?=
 =?us-ascii?Q?0riWpPlywk7cp+/VP+X2AUdwWeyLBiYAQQzgyTF2ME9F5+USnVC9RiyvoXmz?=
 =?us-ascii?Q?aPdlSIDCUMvwhYO4D6ZWjDJUuvaN3KKPBxdNk7e+5sZkFAS+hlUmuAczVwOD?=
 =?us-ascii?Q?McVSf19vTKpw9ONR0pwS/D1WAU+FgZIiaDals6d4ixRQMk0pZJPsvxi49W+x?=
 =?us-ascii?Q?2CiIH19QMaK5RDXP4v0ZrSzTe7KZ0YCpK9rXdOq+87W7ZEE5e81QDKW3bmkL?=
 =?us-ascii?Q?DuVPDxDxkhPgDgmET8u3SggITbxyTesFHXtyuq2d2e/JiBLtGlPyv9t4jVU8?=
 =?us-ascii?Q?+E1pwzQ93gULoCuIuNCRSy6I0U0nhmnPbKoZuwFDpEKrqt5rMo4Qxjw32ACP?=
 =?us-ascii?Q?Iq+7zHP8/p4BxUq5EOHWCPUr8Salr/BUr4HP7PEnmWkghMwbp0fucEo678hg?=
 =?us-ascii?Q?++dmFNq/dJ3afuapKI0BHb/VCYzDi+K3guyZieNkhQEQznkvG7/3FPLxV3tj?=
 =?us-ascii?Q?+xHjv9A55mPR+oZHt2t+9u7sI2Y1op6nuNTrdvefbLT7zGFqO5jD/ukWkbQj?=
 =?us-ascii?Q?BYae4cUgXJmYA6JA2z1QealQwztgZLnRSIF/rl4gRxzkGE2qZlPbXHBbHCUh?=
 =?us-ascii?Q?Ly36yL5ZleKGUAa5uXA0WuImoU7XUvcoDnG+k2UELsdJWB8je0ykhqRfzOjQ?=
 =?us-ascii?Q?W/n8+Gw2sV4EqCm4hHVOuClmNhaA5QGezxlWVAcqrV+3mqjq9KBGYWP2/T56?=
 =?us-ascii?Q?B3IbF8AMrXytX569nLwQ8i/7rb9TkCjz5ol+EBVJnmNvgFyR2fa3txCg+Gk1?=
 =?us-ascii?Q?QcuermpXvCh18YlnRS2zAPB1Ha4XQzpCoDgQ28F3rMOJyqcv/2oabumJ2vTY?=
 =?us-ascii?Q?eBOEi12rgFBDhwa5ABC+mCy+YpGufcQ6yNaO4ycxvosgySxk6cUlYvfc1N4C?=
 =?us-ascii?Q?GAD71D/LrVS2BPIObQbTV/piM2Ms0FAkYHvsF8GJ3G41kIGO67s76AHmC0Na?=
 =?us-ascii?Q?z2A1tQ3KqKZU36P5IGhGQOSYqd16VHvdn5DFkuYxDqzc6lrePj3hOeJN+BO4?=
 =?us-ascii?Q?K6gEe1e1uer3vf62oHZiVzANuZVuv7sbUsvt6F8tCudC/xee6Zy0Tt/W6LdS?=
 =?us-ascii?Q?HG6ggmnLiiql9Ka9KDvvpHF8+4seJ6sVZlaNZYl0QtURTqfpbYJYt1Yyf61u?=
 =?us-ascii?Q?PC/c4gdhD74QJ8RrAd3DrtYgOi3HR5qw+kRAoH4kkM5PQq7LHwKLgmNAYoeb?=
 =?us-ascii?Q?1Rw41RZNsxDsLHKO+6ssLr4Zx7dBjxtBMSj+5SdC1mYhIV51kc4NFaJp5r2P?=
 =?us-ascii?Q?N4CGKyzJ96x0xYWGxJ4+aP0vgR6lpIOibTNVyENNaoIlVE2bZjZLLBXfvBmd?=
 =?us-ascii?Q?kyOb2m8uQ6zpeOsDZ0FQjP3Q8akPfMuR1VBFUAfxCrg+hHSLO+0Z9AC3ugUb?=
 =?us-ascii?Q?mpdOw4/BXbSYTKkNKfobqOTrzZxLDQEOFBcbcsRmPhI+mx3RoVo7zmiaqrtt?=
 =?us-ascii?Q?Fnutb5zjiHYcKru79F8mRHNpAZvRe4DAmaEzFjny?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8243c497-a363-4256-33cd-08ddeef35de1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:18:37.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL/OmLKtpu1zvUj0VsasPphrQgU03HrHPV2V41mniC2V8me2KonWdYu8ccC6fAMaEL8ZAHrWG4u2W3CFft9y3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8501

Refactor code to support Jumbo frame functionality by adding a member
variable in the fec_enet_private structure to store PKT_MAXBUF_SIZE.

Remove the OPT_FRAME_SIZE and define a new macro OPT_ARCH_HAS_MAX_FL to
indicate architectures that support configurable maximum frame length.
And update the MAX_FL register value to max_buf_size when
OPT_ARCH_HAS_MAX_FL is defined.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 5c8fdcef759b..2969088dda09 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -619,6 +619,7 @@ struct fec_enet_private {

 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
+	unsigned int max_buf_size;

 	struct	platform_device *pdev;

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1383918f8a3f..9d348a8edf02 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -253,9 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
     defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
     defined(CONFIG_ARM64)
-#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
-#else
-#define	OPT_FRAME_SIZE	0
+#define	OPT_ARCH_HAS_MAX_FL
 #endif

 /* FEC MII MMFR bits definition */
@@ -1083,7 +1081,7 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 	for (i = 0; i < fep->num_rx_queues; i++) {
 		rxq = fep->rx_queue[i];
 		writel(rxq->bd.dma, fep->hwp + FEC_R_DES_START(i));
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_R_BUFF_SIZE(i));
+		writel(fep->max_buf_size, fep->hwp + FEC_R_BUFF_SIZE(i));

 		/* enable DMA1/2 */
 		if (i)
@@ -1145,9 +1143,13 @@ static void
 fec_restart(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 rcntl = OPT_FRAME_SIZE | FEC_RCR_MII;
+	u32 rcntl = FEC_RCR_MII;
 	u32 ecntl = FEC_ECR_ETHEREN;

+#ifdef OPT_ARCH_HAS_MAX_FL
+	rcntl |= fep->max_buf_size << 16;
+#endif
+
 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);

@@ -1191,7 +1193,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
+		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
 	}
 #endif

@@ -4559,7 +4561,8 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);

-	ndev->max_mtu = PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN;
+	fep->max_buf_size = PKT_MAXBUF_SIZE;
+	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;

 	ret = register_netdev(ndev);
 	if (ret)
--
2.43.0


