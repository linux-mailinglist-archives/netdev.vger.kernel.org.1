Return-Path: <netdev+bounces-136660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7009A29B9
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0837282AD5
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E8B1E1C0C;
	Thu, 17 Oct 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T7u3pwdC"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54261E0DDD;
	Thu, 17 Oct 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184000; cv=fail; b=M9FVZVqkDVFVG9HB9MxhfimD7kzNTDSYXuGnA1cKlMWVUZ5AbQrcv97S20PTpJsJy76Y1dLYCBgJM5Z2Dq8+Hki/G6Tfzw2AX05RIL2DH8ziN6fpaQPDrz0ZZ5cfypylKO+m8E8XphtYdtWQhgUecZCKH2dWssLLN9RntWU0K38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184000; c=relaxed/simple;
	bh=pp/6Hc+CF4lcRCy0fDbuM11wJ7x1nCijkK5SXkZ/zgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6ETSaQdOwgDoiWGJwACwYBb2/6bcq9lxR2pMBFoHJH3uO+l4/WBGYOxDkxPKEsk/WSvjCANzJB+1dwp4nOJHQDjdmP6zI5jlA5ieDg1roXZuHkmHh78kbGDLLPGtmBVwlJuUNzvjhNix/ORqw+vYTaCPM5zm7AiKfjHQxLe5Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T7u3pwdC; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVy1/ml0eSouyJDAzyp5ZeHN2oSCmqkMGXgs9HhUZe7ebE5HRTVUU+tw8QWqbaTkVtt+wK5mtEp4FNqKdnaEop8pgaNG+eP5/EkXshv9Em6sQu3Cfee815WyZDuVT2q6ClzSKgQf/0wxWvYIGwqcyy9o5a3Iw1vx4zfd9B5Lhm46Oi/kTsO1ExDf1LEVDdo/Mrkkn8u8+IbWdjZuHULZexJq8ePULmecdOLjuoXzvRhRbEp+3pEcnUjKvChw7VMKQNmEZLMcl+kmxcV11Yzi3TGjmNrUIBcFWo4Gpa7ibqA95NFDh0uYzeNSLhOcXii1FUY5JHmpgaBJpsRYmTH93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FbCvt4SDdBMdT39XRoF1F5uTz2UYEJVMtFE5iLC5tM=;
 b=x+KRLk/Zm1k0KNCy2ORWGDguYZgdWEpakT/QJHNKNurAEgSCLYWhoSgwJ7HBPYFnWuj3pOMz2sFdREtW9pr8dLL1jogf3WMvK9bxqIV+/TZyhJLEo/mJiF3wPeR/kR7oD01RdLYaGJu2Sl+n8D5+y+m7B5oNa1oeqi/DfRphMoaLDEdaOXDpXLzgwklhIzmaFdbHLnPVXD6v2nfKLlp+vLQtDACGvYf8TYOoUXWUwDaFc9l4MfcjMqsFZ+LthuRZTv83sutkkJ1g+8YqUJsyt2NBRvdocPtAx7c876I7bJiyAAD5VABqtcZsCFFqOWRFRfRte8axd1Q37ExmGrBFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FbCvt4SDdBMdT39XRoF1F5uTz2UYEJVMtFE5iLC5tM=;
 b=T7u3pwdCjwBvv7OX3EVZe0kpraLSXCvSou86YoTgGLVhH/79CzaB5F/7mjJdpHhPuMX/yjPgoKq1byYzls0qzY4YtG33R6aE6otTadu9fYsEiDlpoYRGhw/FQUfSu5iroT4495GtuRvgt5OY8Xlmd8ME/gaENNPxcVySq7KU+LmpZW6AgUYRToKuwmKYY2CaBbmV1kuEiTEJ3bCN6r3Lbpsq4kVT6adhqJHRmrvjDkJ2qtRhlwMviRYgbZcS+vdehfOPK9K++ApkwTf12XMTSe7CT2CeK2VqojySww7js2dJfia9n78YZ06lprSrWyRmQjy9IKWtyq2at7fJby2Vsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 16:52:49 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:52:49 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 6/6] net: mscc: ocelot: allow tc-flower mirred action towards foreign interfaces
Date: Thu, 17 Oct 2024 19:52:15 +0300
Message-ID: <20241017165215.3709000-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
References: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0259.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 658cc462-abe2-4e46-5bcf-08dceecc222b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GcQrJcVsTqPWSmRHZ1gGL5Rhav5gb4codOflKeA6PYbn33PIhIilUeuxbqfG?=
 =?us-ascii?Q?+6IdZ8Yz02I+tmg+gArCisvIEWths6/aWozeOSMh7dkfOASbSEtIsYu+LamS?=
 =?us-ascii?Q?FFIZoULe2K1pfgPKwHHZfhZYLb83kJVbo8rb9FVq4iUzpppKYHB81HfpGsmg?=
 =?us-ascii?Q?D4jVzrmWgZnZO/ERqQZPXmvaLkaDez7HdBLbDZElFgsMzHZoy9Ex2G+yAwXI?=
 =?us-ascii?Q?oVkv2Gxo4Sfcm3+LV/fxaQREqIlcayRjXZvqXKv6obtr5s8ymJo/FmbV8zUJ?=
 =?us-ascii?Q?/c1SSswcLYMxCc3XPrifGYgFjqu/9DtxZwTtld0/uS3QjEemajmG+1yQ1Wif?=
 =?us-ascii?Q?h3+1QvtqMqFK2LV7Ud17h/XrAUuQ9ElM3hr6v5v2Wu5yKmU6G8XucxdWTVyQ?=
 =?us-ascii?Q?vmc38vBquQZoSCvhgm8BfTo/ypycVgvAExKUZ9jFM9vbZB1HboYZ5uLE0EG1?=
 =?us-ascii?Q?y6d+RFBgNBRygT6Lpo9ojXVq4ja2D/D/oBgseJ+D4Kogv+D7lNCxuhTOgzdS?=
 =?us-ascii?Q?lsvuIvHuubt7ZHlCa+RLAwWDmPI74ZcakCACxKJ5IriHofZ9/PE66tO4PaIo?=
 =?us-ascii?Q?spgcz3o1TAZ3BQZwC7dbTUbElJ/jtZ976dqaXOiHotRHaEkhYYhlceyy/hg8?=
 =?us-ascii?Q?+fJgYkCFJ7oXQpM7lAUpY3Ub5yKMzVJ/MDEIsWW9ymdjUOQsVVMH1Jrz4m94?=
 =?us-ascii?Q?aiCGHfM2bzjnykFGh1GDWAR58ltdbAP6LF/Xm0jAlyYvaNNx2eozVD9PL3JH?=
 =?us-ascii?Q?1Sqg1Zv/O38r1w3HUWmoUn6GDSSMtyKi2xXq0Ym1iEMK1NWtkTqgfIMtog2W?=
 =?us-ascii?Q?rGBjimgZPJXHqG8FhARsMqXZJ8QBxPgtNXxJwIIR7emoCfexf31bGEHBpjpl?=
 =?us-ascii?Q?CbVHReTSO7ca0xEuNc9loSNBa69uDIfkQKnaMVWx3cDupG4yZ5+VtwuhbJwR?=
 =?us-ascii?Q?sRtfjN+hsMM0dTObSbAuiboooWzLkp/M1gsZRoKG6qTpoSWpsC8oHs8io0Ud?=
 =?us-ascii?Q?duE2qKCOlDht6Y71k0HOrWx31yiXRK3NSOtQTaSSuVozXNqlpcgPKr5zmGxY?=
 =?us-ascii?Q?3FiTVOJgWjL4tIkcA9wnN+LheDzk6iW83IjAyRKNvsj9sHoTTSxy/tpKE/Km?=
 =?us-ascii?Q?1nqMzE0K9NbKrlHkjuUVa0OQBPS3l39YyVXhx/zyQmti1BYsz21Y5McuOTY1?=
 =?us-ascii?Q?YfC61tQQIOA1vttibYBjk/t9azDlSgYsL6azePddr2pEe/7MSCrWOmzTFX0W?=
 =?us-ascii?Q?hK2gh6UuXhUOjU7ZaVf3sVEAQEp6NXBc3VDhwZtQvb13/TyKcPGd3GtNwQqD?=
 =?us-ascii?Q?jlV63vCKNCakZcVSVQpLAK0lwUtHWMs3Flme9YqBLBCUjb/UyqT56rQD6LpV?=
 =?us-ascii?Q?LDbPqJk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YSqBdQtUnszXuyHGQETLJEFWn94aJqQY3yTXeOvNzGUaGim2Pab8IG4DVRvS?=
 =?us-ascii?Q?B6tQhWCjCY2ClkEC7R2V4D0Lde+LQ5ABQMCG7nrKG5kYH/uKw2wbQHHnuWN6?=
 =?us-ascii?Q?v5+ztPUQ8x5N5PgzDiYDuLDpal84rdaWmlPeTgPnZ1KQ7LHAhPR8k9D3RAgW?=
 =?us-ascii?Q?MFER/o1gAKBc7gGVgg9D44oBmtCjVEIh2HaYkdtVlCwAU4Nx5svzH8BEmsnt?=
 =?us-ascii?Q?pkJMNYiFBXlGUNvnMRuR/hS50W/Zvoau/Zkj+rslJT6Oeq+4Mgg7ukc9H4f/?=
 =?us-ascii?Q?Zv4tXBzq0fPBU5KebhJvWR4q+SylWoNKwVq88R+7W9nE9NglRZDrs8qzPX8x?=
 =?us-ascii?Q?lakn/UJyWyVz3CrMBnX7VfyBewVCmVkgYCqiY9JFd2l0neCx6ZWOZeNcVNYP?=
 =?us-ascii?Q?KaErxyRZbOcS78ZrANrKwPCiYa3EQUgJnTxoau2QDReXPDRJaX6nedHNuZ/Z?=
 =?us-ascii?Q?k1e5RW0G1JTeVJPUNnkOSwaYNqbw+a4Yd360Zrmp3raP26hO2FKQBqgVeaHk?=
 =?us-ascii?Q?NILRHTQsEAqnn6Rx+R1EhpYBtKDy80fEipIzheCgGSvdP0nyLId0o6t2ZvR+?=
 =?us-ascii?Q?/+F/8koi28ujfCICo8tJuDKuyyhI/LQAUNNGVvCaOEwMc62ZV+/npK+B4D80?=
 =?us-ascii?Q?6lIKGlYhnBFhd8g+Up/jtNv2HPxfwOfnWHexxiJYdtljCcOssUGbqJeeBKII?=
 =?us-ascii?Q?HtKjgHaXc5yjF87vO7/cs9yhc1wVAdbAuUOopfF46wQ0wyoUfsw6ly+LSADQ?=
 =?us-ascii?Q?tO/NRPs0vBMhnw6DeZF+Vbiqk2rLspP9vx1bJiuDqciCiUDuTxrF5I4burs7?=
 =?us-ascii?Q?YF1g2vXwSgVaS2P4l3nrFct+XpkffitxHznhwZ4PUHTotNTIrZ1FwhwxSKzp?=
 =?us-ascii?Q?CGJJNEiWqZCmMElkw6oyLNtEMbDhMNqyg2H0of5kS2VrJU9aW7kBBkqIVSzq?=
 =?us-ascii?Q?5gJDnNXETGv6m0CI3myD/nBCNbuwle3Pbmmk0kHBDLoL0rR1wrF5prquNL+q?=
 =?us-ascii?Q?8rl1sRku+B7bgCUoqnaZNzsiqKRo2h0tO7htiPozwSrJM+Ao7JDEOWIgNvhW?=
 =?us-ascii?Q?niSROqd3Kg1On/g7rt5GRKYim+Cr6mZIVs3Kvv8Z1WKZX+3eAz7teqkuW+mc?=
 =?us-ascii?Q?uXOZPy3WfXiAlsrlveqk+YNg0T/BycZ1RsKVO64vEJpljKUoqRjLrCUhTq/m?=
 =?us-ascii?Q?jJWIz/5no+VFGmQGU8oJWxrH2N3rrkTnLe1RahyOM+MimGLIwtFCDTqDBGwI?=
 =?us-ascii?Q?cRKWFNnSVS5Jzuom2Qa/W75v/VdXqK/OJPdSeJupGDsvTlyvUry5QM8SrG2a?=
 =?us-ascii?Q?oD7iTgAwNAvR+MXgzKjFBO3kjOHSo7dFITZaLvyiqffRlF9wyoP10pzNdYCa?=
 =?us-ascii?Q?OXwK0Wrut+CiY+8kDYESwUILKzrmzK+ybUsoxqtnpr52y412fHeLGcuObLeA?=
 =?us-ascii?Q?xT+3MF4ZKy3HSzwikwAy7Gshq2u/Szy9N34DKSxBv/JSB8D+DuVr7CaKQVpu?=
 =?us-ascii?Q?nUTewSWPcHleLnvIaUXUCMA4WhKeb6kDCXrf+ZTBjEuuY0w+aWMbugwTSqm5?=
 =?us-ascii?Q?60KE9TTf5JgkEGJZuCwNg+AsebvzuBu0TNFLbg1AGVjVhe4JiPEED59XP6ql?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658cc462-abe2-4e46-5bcf-08dceecc222b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:52:49.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2atl3tRqzsMuUzqW4Jg63DTM6ckvccjItkih3oOxcilseEv3HGn7dhueG/PcWTQif085yjCjJGLYBtV8S5N0Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456

Debugging certain flows in the offloaded switch data path can be done by
installing two tc-mirred filters for mirroring: one in the hardware data
path, which copies the frames to the CPU, and one which takes the frame
from there and mirrors it to a virtual interface like a dummy device,
where it can be seen with tcpdump.

The effect of having 2 filters run on the same packet can be obtained by
default using tc, by not specifying either the 'skip_sw' or 'skip_hw'
keywords.

Instead of refusing to offload mirroring/redirecting packets towards
interfaces that aren't switch ports, just treat every other destination
for what it is: something that is handled in software, behind the CPU
port.

Usage:

$ ip link add dummy0 type dummy; ip link set dummy0 up
$ tc qdisc add dev swp0 clsact
$ tc filter add dev swp0 ingress protocol ip flower action mirred ingress mirror dev dummy0

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: allow mirroring to the ingress of another ocelot port
        (using software)

 drivers/net/ethernet/mscc/ocelot_flower.c | 54 ++++++++++++++++++-----
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_flower.c b/drivers/net/ethernet/mscc/ocelot_flower.c
index a057ec3dab97..e502226df4e7 100644
--- a/drivers/net/ethernet/mscc/ocelot_flower.c
+++ b/drivers/net/ethernet/mscc/ocelot_flower.c
@@ -228,6 +228,32 @@ ocelot_flower_parse_egress_vlan_modify(struct ocelot_vcap_filter *filter,
 	return 0;
 }
 
+static int
+ocelot_flower_parse_egress_port(struct ocelot *ocelot, struct flow_cls_offload *f,
+				const struct flow_action_entry *a, bool mirror,
+				struct netlink_ext_ack *extack)
+{
+	const char *act_string = mirror ? "mirror" : "redirect";
+	int egress_port = ocelot->ops->netdev_to_port(a->dev);
+	enum flow_action_id offloadable_act_id;
+
+	offloadable_act_id = mirror ? FLOW_ACTION_MIRRED : FLOW_ACTION_REDIRECT;
+
+	/* Mirroring towards foreign interfaces is handled in software */
+	if (egress_port < 0 || a->id != offloadable_act_id) {
+		if (f->skip_sw) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Can only %s to %s if filter also runs in software",
+					   act_string, egress_port < 0 ?
+					   "CPU" : "ingress of ocelot port");
+			return -EOPNOTSUPP;
+		}
+		egress_port = ocelot->num_phys_ports;
+	}
+
+	return egress_port;
+}
+
 static int ocelot_flower_parse_action(struct ocelot *ocelot, int port,
 				      bool ingress, struct flow_cls_offload *f,
 				      struct ocelot_vcap_filter *filter)
@@ -356,6 +382,7 @@ static int ocelot_flower_parse_action(struct ocelot *ocelot, int port,
 			filter->type = OCELOT_VCAP_FILTER_OFFLOAD;
 			break;
 		case FLOW_ACTION_REDIRECT:
+		case FLOW_ACTION_REDIRECT_INGRESS:
 			if (filter->block_id != VCAP_IS2) {
 				NL_SET_ERR_MSG_MOD(extack,
 						   "Redirect action can only be offloaded to VCAP IS2");
@@ -366,17 +393,19 @@ static int ocelot_flower_parse_action(struct ocelot *ocelot, int port,
 						   "Last action must be GOTO");
 				return -EOPNOTSUPP;
 			}
-			egress_port = ocelot->ops->netdev_to_port(a->dev);
-			if (egress_port < 0) {
-				NL_SET_ERR_MSG_MOD(extack,
-						   "Destination not an ocelot port");
-				return -EOPNOTSUPP;
-			}
+
+			egress_port = ocelot_flower_parse_egress_port(ocelot, f,
+								      a, false,
+								      extack);
+			if (egress_port < 0)
+				return egress_port;
+
 			filter->action.mask_mode = OCELOT_MASK_MODE_REDIRECT;
 			filter->action.port_mask = BIT(egress_port);
 			filter->type = OCELOT_VCAP_FILTER_OFFLOAD;
 			break;
 		case FLOW_ACTION_MIRRED:
+		case FLOW_ACTION_MIRRED_INGRESS:
 			if (filter->block_id != VCAP_IS2) {
 				NL_SET_ERR_MSG_MOD(extack,
 						   "Mirror action can only be offloaded to VCAP IS2");
@@ -387,12 +416,13 @@ static int ocelot_flower_parse_action(struct ocelot *ocelot, int port,
 						   "Last action must be GOTO");
 				return -EOPNOTSUPP;
 			}
-			egress_port = ocelot->ops->netdev_to_port(a->dev);
-			if (egress_port < 0) {
-				NL_SET_ERR_MSG_MOD(extack,
-						   "Destination not an ocelot port");
-				return -EOPNOTSUPP;
-			}
+
+			egress_port = ocelot_flower_parse_egress_port(ocelot, f,
+								      a, true,
+								      extack);
+			if (egress_port < 0)
+				return egress_port;
+
 			filter->egress_port.value = egress_port;
 			filter->action.mirror_ena = true;
 			filter->type = OCELOT_VCAP_FILTER_OFFLOAD;
-- 
2.43.0


