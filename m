Return-Path: <netdev+bounces-138270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0096E9ACBB9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A0328215D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CEB1C9B80;
	Wed, 23 Oct 2024 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jsRC3kJT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77611C82F0;
	Wed, 23 Oct 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691602; cv=fail; b=LH+DGEhhtxlvCPNY5SXIqA7/wd/i8PtW/dULNvebeEYn4WuItKF7YxmedEPYPzVKmX3QkXM4wkUR1F2iGDUH9Ri0LEuyTRi9UmIdpECPKXezdTCEHengUmxSNuBdsl/3UZm46/1cux8yyfJMOOlScSe1xxLSMDa4j/ovLUcvYWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691602; c=relaxed/simple;
	bh=qDQ4/apa5Np7DxGWe6lGoYYxJFhwh5/w/d6B/gN64uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h0Gpxc00UADtrfq+FiUKP96DsrKuMKDUWn1loL9CcWAZcVLBp60m6Gz0WNBgVuWimVBbsF1tE16irVf8QEGQxVI9/GG/aC+D5N631XV76FBSM2X6KjSc/GgMDgc7l82MHN36gUEKhmZ3V+jQKQsVr4oWWu+lzigOBNguzA8+rqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jsRC3kJT; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8XftjDaiDdxLqNCQmM83of4erS2zY5fUtwywEp0GM9B7U0K1EstZPqLIA0MgUtAv3YJHymBXqo3Of3qhF3D+oK43ktNF3iK4ZEbyURCTYABiFcmavteElD+uc5vPTrwT2wqZw8dGPmxWmDLwgbwlP2sYOTBHI8FU1sYary3711BTJOv1OgTcAKf5rHWTCr/CN5ioLqXVvAJ8EaXmCuR1Fun+hE+JCAR6Ghg8cOh6QRSGoPWqAlIgSvYkcT5bJFry1cBypuoE6za+Oi7tmV8Vxi0woLQsg8qt0hhrSmcfA4cjJOEFzdDfIvQOjSxZOafDmPkEaF6tM1p6hJfMASTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJhl1Detx37WtzzPxfRpyz7V2fR+D6VNo/usW0FxOm0=;
 b=YeTJ/YH1/HV8DHlCx7mYY6i4YvPs7+8PyDR/ScC6eIvogD7N4ntfGdblb190hBX9ZK7YiK5eOCkNUGPEz7CEVKsaNsXcnGNCI2Fk+5DeHOS16LOUNPaQjoTdaBQLGGW/WbhdEItCLb7kyc10tv3JCe+KzmGbab3jIFa5gLT8B8QruglyqPbUPCM8uRahlvfRRa0ZATTC5OgDuxuiwgXqJchp0+xG+aBRgigbAlaKTOyJkAeFs4m8CljNisw5LyKku34rq2DB1xIZZ4HL/ErgDNtjDhSVJw3OkrcpoWw4B24WaMVCOH+qCwMXPhxGpeV8SAIlKWdEPA4ds70yLIIeSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJhl1Detx37WtzzPxfRpyz7V2fR+D6VNo/usW0FxOm0=;
 b=jsRC3kJTVpHQrh7eC6+FYPiKniNbK2Q7L+NlIeRm42Ez3ahmrr/96Tvat+RoZxWwoe4PERU3/S7T0/XDiLx+DCDPyU78DCG6InFVhEEZ4QBeGpYmneoQxAAKTATuLT1WchQjdtOsvZrP0OKbPC7MkVaZ8P442Dbr2AbtU6lbvxp8eM/zoG5Z0A4wxagz3r72XrKFnBDcZK8wg13qkHvOs9Wm2+d2rTYRR4UnlcOb/M0bHta+TcWmC+zRMv4tywuS+p7fMhzCy9Nrhcm0sVzfR1/1ZuCW8VhAUaljvm5wmC5vHYqrcY6H6xsmj33M1NsiwihCizjME77LR8YgJXRdMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS1PR04MB9683.eurprd04.prod.outlook.com (2603:10a6:20b:473::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:53:10 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 13:53:10 +0000
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
Subject: [PATCH v3 net-next 6/6] net: mscc: ocelot: allow tc-flower mirred action towards foreign interfaces
Date: Wed, 23 Oct 2024 16:52:51 +0300
Message-ID: <20241023135251.1752488-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
References: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0105.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS1PR04MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b3559d-3226-42f2-5f4a-08dcf36a07cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RrsnBsbfGVqFo0rmpBfg3938QxBRi5rlXYhlV10Jq3Y+btWKrZNLgzzRsx+i?=
 =?us-ascii?Q?NM7q1lgKnJtjDLAhX2zrq/2vVs1xqvHlf1AeoGbkikdWJyNMqwfzvMQL4bS3?=
 =?us-ascii?Q?a3t8TffYNMuop6yhehQoCxVQ9j70PbwQQxKOec3RjoVB1wKWgnoyOorIvMeD?=
 =?us-ascii?Q?GOMnT5y1ODJ9QiAUOxca2lFlmFoHyt1h7clnfMSJTwyiufZtbZ1pq7MhWTIo?=
 =?us-ascii?Q?zsDPD+bUliNu5Zz6dPlrc2KLt1zKRYIt89+IHoNOP1LXAojyNzwaVhL5GKQq?=
 =?us-ascii?Q?U8HCdozZvaSda5ql2XWP8j+kr4yGL4Lpmt07GoAvFNryOw6f31+mpqC1f9K2?=
 =?us-ascii?Q?bnosGp0h5sjppR+x4Gs9y/i09OCIE0HPpk2O+o2VIRdH1tUIA4w/T91bi9h/?=
 =?us-ascii?Q?NrY+9H8Imn9lQDAhAPXZERjwKcVCwQoceXVqh5O3f39/i/efBjou4w0gxZZH?=
 =?us-ascii?Q?2+lvLZ+FVxtfsdOyxiaxF4AOs+LI29wKYm4+83GqyMt0+uhMuRe5q6QHdBrY?=
 =?us-ascii?Q?+tznTblWSbCrnBiArerz0JS//Yz1cRVIMW3JEsMSj5TTONF95EAIhpKe56M0?=
 =?us-ascii?Q?J/sJAX/CxmI9s2FeJep0XT6eBlnLr7K6sUZR1cGlhQ1EuLBpgqbRGp7ueB48?=
 =?us-ascii?Q?CwpIrTUDjXivZMSVEFG861owC0Pjcf1KkoLQsoNgg5lgIoInGq/hyMgDrbTi?=
 =?us-ascii?Q?QEW/BTbJeiVKVdM1swA49mYLpfcumzBqxuK8F6uEFvfD6YbjOTdaHNL/Xyg4?=
 =?us-ascii?Q?AwshmH7NpgWPeFQIqzBJ3VuQM3N9BWEKI2SqFIvNpMuZgwcOx0Vt6g8+uYT8?=
 =?us-ascii?Q?UTwJLcMJpKwF5Yxso1zyZt54gGxbWeT2/D4wmU4wzQs3CHKCP3KlOEe+tBbC?=
 =?us-ascii?Q?OD1PFdspIT2X41XhTnv0lbODT1utLv4gKgJLUr1U30SF8yA0aMBtwWTBgP3q?=
 =?us-ascii?Q?Mrs5tKKS1zzsmMGaPWtR/AMLtHXff4A9xB7umNfp2ekQfsLLpkDRbIzZ5JZF?=
 =?us-ascii?Q?AjTZUF8ZVbcfups92NWBdG3lqE5TM1YtucFzRv8XZMhyY5zm8AxtU9K1W4Op?=
 =?us-ascii?Q?iCkVV8hpbmvxQtgEcUCOP46n4MEPIxA1FfR4qasJuwdIP76szz9eEprBhjQx?=
 =?us-ascii?Q?bEvCLRmftQhhWYR+wz1w/vzi0Ub0mPi6lltStWhCyzC0bw2fKcBqYC3B8ilT?=
 =?us-ascii?Q?I7WnqQNhqdmRWBuMn69co5ohSAEt2d4nwxB9DsQ6+CkP70i5nI+5iHJdhY9B?=
 =?us-ascii?Q?0x51NSs7vsInaM06EPxAX4/fwZRWre9tw8e/XKgIVlLEJLIAMbS3KncGvAC8?=
 =?us-ascii?Q?8nBc23junDcwvi2eiaJmME4vpAyfJeV/RoraEHKSUIp6ueSghb1hXbjVw+72?=
 =?us-ascii?Q?ykWnXeo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6vDxSwcFzfLr4o1LoS+UH2jdiCtwjJQoEnUSCi67e4eDbo4x/a4Q2aFRUV95?=
 =?us-ascii?Q?sC+tAgseWGQf3QWHIgGr6siWL/Td2hQCIuNONKL3UKQB07gGKiX9e5nNqHJ7?=
 =?us-ascii?Q?C81++6I27+FE6ImSM61y0cpip2FuqRc9DLBWpOq7JM7iLPOC9R3HN+8/FelL?=
 =?us-ascii?Q?8uorTfvHgmOomgftaeJkDPNZLb5HcsDAMknMl4/yIbgHJnCJSwmjDXarXKWS?=
 =?us-ascii?Q?CE5bj9vars2MLN5QbxAbpSGvJD1wMhXKyHeLBg0g9hvRciOamdZr9GQsvmeI?=
 =?us-ascii?Q?/iOkzGUT8tguy/E/6zVxbjvOhpUbqDcoDBO7+sPp9Bhr8/B0WIuSxYvGLJNX?=
 =?us-ascii?Q?AsiKuo14CzxiIGbOxoEcTW9OpfxsdS2jJAI4G6bWT0TfkRXXqD3J7mWV8ZnK?=
 =?us-ascii?Q?xcXf6K+O+3LKyoBYpJGp6q3p3LSRVzB7AmgyHT9Jq84cjyAkzMQHetLCYvEK?=
 =?us-ascii?Q?f/YiHwXbew1t3GBcTxit8f9KqF1aV3NGSPmjCaJ9hGK04DN3hFhfqUdCJiLm?=
 =?us-ascii?Q?qyge3a8qL8o9jXDhN9nf9gd8mAsx8baKLLyhwK1hvQO0J4XsrnX7a5BJBHgd?=
 =?us-ascii?Q?sxCyRmb+rn+SSNz3/e6xpJYfReBSWIdJdIQiNhL2+LH3qWpQiYotVNU4U+n2?=
 =?us-ascii?Q?oli1PUWvVc68A5xs429ITwbcEEaAURc0FRBfFEej38qIRyfjMdHQX2wM+IU/?=
 =?us-ascii?Q?4Nzdo1JKOvIofTYTumEURpxQ3jsr+xCik7VIWPELx8H7TCNPLuj4pyfOzJtb?=
 =?us-ascii?Q?rKmeQINojfEU8J/glFuI8oqnNlcACfZmT937pJCeMaavPrMigoigQ1ZOJSt8?=
 =?us-ascii?Q?nJHesf4d5mZk01Q7e+ZQngj3KyOs76S+89Hg7hWzrhZf80E40ur/AqSDUVdo?=
 =?us-ascii?Q?cDkhaUe1Yp13o63msdFJbujHSnT136zYbdBlYp6YA6ThmrPqcsXls3szBkap?=
 =?us-ascii?Q?IgWNttkXiWMJaqUlb3JKGA7CCh6jWmj3zbFtDe0yZHxkWwn6RKdcPMh2egGX?=
 =?us-ascii?Q?T1rIHYNsOSGMKV+fwiflOulujdNoOdMFU8IaIwGWXFWyUMTcwL6tNHp53p09?=
 =?us-ascii?Q?f0LsFrWnnNrt7h8LpoF8kBA68PvlRIYoaMD2T7LAD7fYdC6TdwD2jXg06CFt?=
 =?us-ascii?Q?T2vf6gzeGUNADvkob2nW3+/CK6rjgzDvfAuMPdujvnYWrpp7m0qSbpSzr3NU?=
 =?us-ascii?Q?9oDDq2wUxc27IBnE3r6aR0sOCe8lFnK9vcq4ZAFYo9Dpc6I23c1y89dy13s+?=
 =?us-ascii?Q?B2BYeL7BIi9vei9CnInemgjWa84SdLlrdVL2xhwWKUEywQF/XDnYMc6IhDPU?=
 =?us-ascii?Q?oJwoSnWIhtMZzRpNU/4RJ/MGFZuPpi/Lp0DZP1hrddviftikUp7suUywdnm/?=
 =?us-ascii?Q?wHpm7kgsh5fHbnS/FEtubtretd3lIg/tEug6hLLx+abjoNJydj9KHo6r5MHa?=
 =?us-ascii?Q?4NsDDRI7ONKVkIXDNcXG2lB7FkCKDzXL+UT442dafK4hNrDtsy3eqoyrHI0T?=
 =?us-ascii?Q?fAKQuSkKAPRS1yp/FeV5XvOuhSyrJaw+CB3QFLF7LjKt5Rfuamfb+mMw7/ps?=
 =?us-ascii?Q?/c3dCne0NQtDIXUlFpXYebWaGqwmveWiOmrd+I4HwToADvvzVSBEcd3nNFuc?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b3559d-3226-42f2-5f4a-08dcf36a07cd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:53:10.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HOQmtUmMmRCCF50vUVGIC8Ij+I6/NnwnWCEK+Aa0cWX6FHD4bXRiINuEeSZGTCRSLoOzwm8v3hLkXMbQVxBeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9683

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
v2->v3: s/f->skip_sw/f->common.skip_sw/
v1->v2: allow mirroring to the ingress of another ocelot port
        (using software)

 drivers/net/ethernet/mscc/ocelot_flower.c | 54 ++++++++++++++++++-----
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_flower.c b/drivers/net/ethernet/mscc/ocelot_flower.c
index a057ec3dab97..986b1f150e3b 100644
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
+		if (f->common.skip_sw) {
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


