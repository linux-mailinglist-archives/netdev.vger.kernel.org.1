Return-Path: <netdev+bounces-143628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6809D9C365C
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 03:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A261F20F6C
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93D62E630;
	Mon, 11 Nov 2024 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hPuQRxFZ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83193C3C;
	Mon, 11 Nov 2024 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731290882; cv=fail; b=hiGf/ZUbpuwSrNb11BuwhVyF6JuyIPMJK2VtaWj+TWmhIGTPHuUdzJdtUgkfhAmf+HEPbkDmJLJLXJOh8RTPFv0wex1r5MbbTUgKwsm4XRwvFeL3C3MuNDf8Ckrbd0PIZl1SW5D6VXYqSknHysT2BtjDYWEfJIOpmX9n2TqhWdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731290882; c=relaxed/simple;
	bh=fyseDxdf1XFDXTXV2lLmKQ5Ejpft/6eT/nbUBzxrthg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cVIMm0QV6TJfck7AiIrrnQwwMo+PA6xKDvuByP9erUKP42Xxu/HERy4N5Ec2cELPVAfoosJqPn1xVYefLPfHhRHiXFKayqzxIGxjZ1F9npQVfTXrZouxoZ54dtEquVs5Tr9pIzw9J9gPRSO40m480JSNtpAMTpQGzAvwfaEcBms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hPuQRxFZ; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cg5ASjSTFEyoXUO/ZmR3eXgL8Tn6573zSTj+wSWxTVPfIzrV8lwKK224yVaSXIakaoM/fjTTAXeyhRiXYsCIVRXN45r4wGo6K6ZyFOpm1xaRwg6UoHOAqcQWpi46oTkAafP09u1CyaxDJS9eY9oe7ApNO6MN92lLyMWISSOAJQdToWU4y4Mgxchn0MLDwSDgYzUrz3DULfRBuwuDY/3xkvO2PEPnYhmTxHAaYaTz9EXv0kSejxMAK6bEnw+jg7rF5v6XpbiNF8d6Sa7WxGZ2TsF1zCfLqGEX6Ebrm0a/I9DcSd5FvRGixhEPhlsl/1VzhN8Ry/I+psbjCUj/tXV78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHW1vOkm5Swy4eSdky976EolrI3FzsFChXY0atI0SQc=;
 b=vZ8fpSNqqcdqGawrMFg3OamUh1m8cBXn644B5fnQfjy1IjmHMaBmcMCryP1AkeWWeN3VjLV+08/eRmJJy7JmFcBnmFIBDQX1fIjuwAtjfc9BGeNUOoLXnF8X0ikCzJtekzydO/xH8oQcOgokAC/N5+tI0gmCY0fQWjpYjOnJjNoF3POvyZFG5DHRktHMVIfaHkWFKUNPGzmSLNwW9Omena3lnT4cww/2hhEeCBYn+meAWED4crcPRQfWshWU0lbnzlTQhG85/ZOehgrko+e+Ydo+KlgGB0Anau3TcMNuIaB4FcbtpdiBRkGh98kYVCjx1Jv+ag8lzT3pAYsrBcIZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHW1vOkm5Swy4eSdky976EolrI3FzsFChXY0atI0SQc=;
 b=hPuQRxFZA3ckoGT6Iy6n9ax9Mo1+0yASq+IZAemkFpF5hIDpKStKITeXWwbSNsMqqsQaWwterJ5qUosV4N+radYjO03QGsd8h6IUSTYVYGvg5KXyRhWwQLrxriCeWHPQTkFLcnbRZ7wx7vlgLVHhgWsK2Ha+Wql3C0STT5WmZbhNWGatMm0TDQIHCAC8wH2/NsgLsPWj2PsrrZIRNmlXkJ4Vk2Bynth+krM7rp5Kii0ganY7XfVTw/f7qCDbpsw6I1+5jN5lhfeU6I8Z0Hch6tCThmQqoqY2D0HrsZyoyUqQV/Xc5/jurlLUu6MfB5TpQmxbS3vVlxWwZXAhyCwckA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7745.eurprd04.prod.outlook.com (2603:10a6:20b:234::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 02:07:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 02:07:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 0/5] Add more feautues for ENETC v4 - round 1
Date: Mon, 11 Nov 2024 09:52:11 +0800
Message-Id: <20241111015216.1804534-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 438607bb-bb0b-4efa-39be-08dd01f5a92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UOR1fqD5WBp00IlR6gpR8wOQBixnAM9Lv8wWdiftet1sasAdcrMyQfvyQlQE?=
 =?us-ascii?Q?k773lforpBVa3rM651OfXBFJgdpOcYQyL5zQRpCbBR2EMenSyxcsab+atc9O?=
 =?us-ascii?Q?yH9lAIqjPlwAtSCWW+4pokBa639E8KTcX33ixMVpLqOh3DydjXGRAhF59inB?=
 =?us-ascii?Q?8IvQjXRgCC1Daa3XiqXpv7QX4sBaIKNnlYKwKdPOTagGB0mAZipZsZhOqgDD?=
 =?us-ascii?Q?AuwBdpuB0MjLJOuLfLbJJvBmTJDhNDcxKLbtn29mWVamF8sDEOVXX6/qcltU?=
 =?us-ascii?Q?njIGO4hIFIqUhrmpeByNgreQ+pZdixjGsZo71PeKTnFtkFb6M49xnd4W0DMb?=
 =?us-ascii?Q?VvZVu98ULGl184EGX31nG3rLy3AeIzeZqmp0D079/YnM8LhNBS8Mo3isCucN?=
 =?us-ascii?Q?k3dpGlYWhJge65TIifBWo0lAgQ7Zg2Pk3SxhBohWnSXiUitTEoNFGFUcaRPB?=
 =?us-ascii?Q?HO+g7MR5qx70Cfoaq2+IIp55+ljKmPhNX5JeMhGaa6rm2Kl2hseyDPbirrmq?=
 =?us-ascii?Q?+VxjCTmPh3NH6cjGA7wegyJGT30OVN08Hp3ut89OKXRZ0LO4DJo3LkDGjW1y?=
 =?us-ascii?Q?l0/YaUCl2nEhtMWuP5QzoiPFC3D3+CEaDqrSPifYfrbkfjznv6MjYOTTGF13?=
 =?us-ascii?Q?nN42eVpW9GRtvi/k2tudFanFc2Mn2Jpq//gS0ujcBYZtGCAarssm/k7l8Qt+?=
 =?us-ascii?Q?DAvZ/VCRfEfEc7l9SciBNsXM3DYV4Cqo86KjRl3c44Qrwv7KXt3I57Gjv3pe?=
 =?us-ascii?Q?TixXqFB8YGtoX2+kQat6sec3G8E3tvMedYziiCtlve0LWZQQZnGtQjlBZT3n?=
 =?us-ascii?Q?E46qQhpAu4/XW4RnQUwlZvLR1mLgxfVVM7X92scXMNw6qJYgwBNLf5txo3aI?=
 =?us-ascii?Q?boZ7K01t+eQ0DZDtQNy1fBfNm6rJuDdmNjhx5+Umm9jdVNm45YgigiQY7S4q?=
 =?us-ascii?Q?IquiF7/U3/skui/GIEGSg3SZkMbWhwannOAb12d2u7annejfF34Sdw+r+4Ut?=
 =?us-ascii?Q?JbmyP/NX08QsCran8cqvcLe9oFTfxF+UEx3tJEu8xSAENqPYC5hmjLPi8Jnm?=
 =?us-ascii?Q?KTpM7y/WUVs6BGpF0H35qtsSMXDHvXL2hANhZLiyADo5/ylfqfEuPpfNafvP?=
 =?us-ascii?Q?VT+BbOsC/sgcpeoYquFTeJCXytpFYTBnDkZ+i5ZSHfd/GdmQMc/3L/e59QSF?=
 =?us-ascii?Q?uxwZJxoHHnVnIg+6CCBjopnR1hlqnvAzL4nHZmfYhhTTQJvqT5l0WUZ9577W?=
 =?us-ascii?Q?z+JGO7tBzpbP8EXcyjMm51sB8XlNa2j9LckVmBXn6uoVAw8VBPIulj8FwcwL?=
 =?us-ascii?Q?aIGZ2w1QSsxXyA0bBxOWxxfTarhKwDIYw6oP3o3++zhfJoeex00TtnbyMaXk?=
 =?us-ascii?Q?Xm1SbVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b4azrEzFi/bqEKSsiq5YnJb8pILF+ngCouE4I2SEPKFVVTjRsNJN4KKeepro?=
 =?us-ascii?Q?KZWuxgjFNd6CdQ6wgqb7hSARquWQjlhuEhrhW3YXTZszjUqzfABMV2930YMX?=
 =?us-ascii?Q?UPlfddQbkpq/gkLrdTG3sSu0z3P10rVf0iIyw93DPIiq0gZWPX/Ecwvpk93F?=
 =?us-ascii?Q?JnK5noc9o2PMVbkixelgPZZPjzfybdMueaEy8jAm69vAvd0pwN7BS/Q/YJ3Q?=
 =?us-ascii?Q?JeS+EgRIMVg6bPAs6TDAK3AwBms8g6lg/pujIlmvsOQD5c4aJUNYd7TT5EkK?=
 =?us-ascii?Q?+7HYcNGG0/2Qvz3YXs/DdBrmcJWErejl+ojMQpvngy+2creowOYyiriLFb1y?=
 =?us-ascii?Q?mOYz2pHrXO/OJV8sciAqmIbTimzqXLB9yBvFItWuOhdaOVmj+Dphf8FrHJjD?=
 =?us-ascii?Q?DvN1sZGtlD/9wlKqGwRpPRGu4iLrCPPp1+C3lwj5ZKizb6mitty/BVqcwNXV?=
 =?us-ascii?Q?rWhuN5wp29iTsC15zzKvTNGU5e+bPtRer4+2c/6I3Y3pzbBT4Ja8cTwjc+bX?=
 =?us-ascii?Q?eqWEnZtNDFGFKJy1p7g8iHYTwkYaIEoAcXHeliJWtmkm1Pjb57fE1ZAlV+eo?=
 =?us-ascii?Q?7Mw/yQ1hTopT6s/Cu9d7NlSfvvuABR13jowxsEsWbhMl+7/woIFZ4XioblB0?=
 =?us-ascii?Q?2HSU1j0dwcSuLJiQoNnSkQwjrZMnyR050u46JaXC23HnVFWsBRiHLxEa1A7d?=
 =?us-ascii?Q?lu27FvVhPN2Ug5x7x66HyuGjk1fSXDaFyd0PUtNfqpZcPAfNUS4zdvkp8Zoj?=
 =?us-ascii?Q?5tvITS6ruHL7+tf/cAAgAOEe//uqNckENe0I1mtp3cqtF68wj72bKIAyXLg/?=
 =?us-ascii?Q?mvoLO3Le0WpkiwMwQ0kYcLHZ8jDr5WpmZwkFoie8Pd9UTK/fanjCrH0+qptL?=
 =?us-ascii?Q?qbeVRzsZH68kD1cv8rVtUE4MVINCHxeLgm/RF8WTKqMh7383U3kiN4tPLDfj?=
 =?us-ascii?Q?G895MyiXbj0FAPv4Rj/0mT1KISI4rwqJguuYde3Q4gCHi+Q0C7ucQykpx1q5?=
 =?us-ascii?Q?AM8BUfKqz+EW+6QrvKnH/Lqh/1a2hd9qRZbDgMgY9MAVYlsJh2JEBiMD/mJf?=
 =?us-ascii?Q?Fp+nhclvrON0hTI6l4MhdPtuBpQS1Sim3vnJbHxsyYLwI7qCXCnr90QWm1EE?=
 =?us-ascii?Q?+w471BO0A6LK7BsKxwd83omwOoXanj0AFR/kXh+l42ydr1+L5xfUPB3SpQOB?=
 =?us-ascii?Q?/IYQLVKMFTWIPmQ8m6d6MBSVzXJhIK0HCWcpJUWYQZ8MnchENdNtIySbk5yv?=
 =?us-ascii?Q?8dOibKONvL4h8VG8/af1dpadD5WO2BkNfUKy5jPdHI1ErbXeMsIQDps2kmJv?=
 =?us-ascii?Q?cHYiPlNEBR2cr0Rvalh7lFNsMYaroA9luPqKAT2VIXiECaQiv4wJea1xVlla?=
 =?us-ascii?Q?d+hdei7D8ykZv/Fa2lMAmQJMEe2rkz+J8gGc6cSyg7YXxWGxaqHX7dVm6n5g?=
 =?us-ascii?Q?bRV8+De8lo4op+u52zFIN7rsQ/VhdTDswsH71KGNV1JLM/Unl/MhyOldb2IH?=
 =?us-ascii?Q?yZHPuofY7DJc0ncntLm/P3dpn7nbtIUFzQkkAKdedIYq3RYIpM9exh4z4C5a?=
 =?us-ascii?Q?xnngBGUZ0FwtS5aSl9NsEoyeZpu5qXDGyQ7dJXPG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438607bb-bb0b-4efa-39be-08dd01f5a92c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:07:57.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVr2Xvbfjl7Xh24M4DBGjFQ2RJq7uCn5tNOOnjUZqbRCf1uUlUM82xNOTJj4ECQJRDgozPOk1lh8YpSp/vcO2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7745

Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
some features are configured completely differently from v1. In order to
more fully support ENETC v4, these features will be added through several
rounds of patch sets. This round adds these features, such as Tx and Rx
checksum offload, increase maximum chained Tx BD number and Large send
offload (LSO).

---
v1 Link: https://lore.kernel.org/imx/20241107033817.1654163-1-wei.fang@nxp.com/
---

Wei Fang (5):
  net: enetc: add Rx checksum offload for i.MX95 ENETC
  net: enetc: add Tx checksum offload for i.MX95 ENETC
  net: enetc: update max chained Tx BD number for i.MX95 ENETC
  net: enetc: add LSO support for i.MX95 ENETC PF
  net: enetc: add UDP segmentation offload support

 drivers/net/ethernet/freescale/enetc/enetc.c  | 346 ++++++++++++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |  32 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  31 +-
 .../freescale/enetc/enetc_pf_common.c         |  16 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   7 +-
 6 files changed, 420 insertions(+), 34 deletions(-)

-- 
2.34.1


