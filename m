Return-Path: <netdev+bounces-115586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0BB94707F
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 22:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8591F210BA
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 20:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EE6762EB;
	Sun,  4 Aug 2024 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lkf3kIo/"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C2179AE
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722804567; cv=fail; b=mRh3AxxaDGuZoY3N/U4wzIjnRFeiOgPZOjfwEZgFIx9D0jmRoezox4Mseb6ihirMWlGtB3CvQzVzbEY8ZoUB8U46AnzD9ywve3+oDIw4fpFOMub8mPrKb4Z+kJeXgY+amnMMYUzVfa7472MVYs9LQgFJicAn6SdzdtMt5/rTUYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722804567; c=relaxed/simple;
	bh=zHZZU+eMO+FrOY3Oel46Sqe/Wv2yGcs8HjWvaP+IS0w=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ufNcAq2RpfHtt7tKCkVUtqdoC+/8IS+lTTfI82+ACy8ifdutI5wlSwYmrF74EdtBzYKKeoom3D0sTcWS21iNe+9ssqnBdx4OYSQdYgGoZTkajygYZfIt0rfyVfmCFTFMFoUDo/Vn0iLNUIu8dIQATgLL8/HmfxhN5k29UH3a9Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lkf3kIo/; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBezwlk6lLIWQah8DHEyjy6A7bmmOr9pTKB2xk3aLHp/csXcgHA3RrcUg+wxhW0+GlD//5nZXCirHsbWCW9OWpU2Di8WKh6Sd9PwB73lptf9ap0E5qxzygD0bGVLJmag6vC6gszyS8zDRV6xDRSUFFBYpprV1evTgQMx8ZQpWgvW7OiqwZc6qMMbLMwZRTrYSNOHi8Vo+vGjoBIV3s6u2V4X/3moxQjxURY8FSeQ4GvwkEW3KVHvH5dvhuOaFGlYBIYdWwokd4bG1HKtWNdf+mj5poT6tFiaNLYcAUb+o5CQJXAeek7emyTLQswb8vzmvgW6dJorp6JoXGm8JORNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aHwJ1puYs7FtDZRq6sNAQxrReo1YFuZndXmuCqk+DE=;
 b=ZBRFeHifVs9JejlovjLk0AC8izBAcHF0bB4G63edNn6sJ7Z/4awCGRB4wHOl2XqGiDx6oOep+Q2oOBomqz0ELklMx0Glm3nM9QGgcVtIyTUJ6f+U6h6d++iY5maC+2x6h70Zx3CkL5i19NV2WeMteoR+goOpPkzI0IuSaiQhUImCXagy9f6idrdW+K/PIuYSKBjOKED4aMyJ5IwSIIdCdR3Z/Nh2pOPI4XYbIO6UY6ViaxBDdhfw1fnXaRamXF4zaAWKbWNbWX61vxb2VX1e4lCBrtaFTpuWzjIE0TztOgN6XB0R57gzygcB9C2v5u5oB/DwU2FpnSIuOwna5v41+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aHwJ1puYs7FtDZRq6sNAQxrReo1YFuZndXmuCqk+DE=;
 b=lkf3kIo/j9MbCH55x6EA5U4HVFWa/pNb5p7sI1IesiiPT1e8IB9eicvCNXOy7di+5q2+RakPgVTKPRtqyrNShZJb3XbHIwOt0grved47tHfXB4pqsWbBO6/rIV2e8lmN8zltHoWLdXyQaQZOQXWyoWHx4LFDdRTgpfeIlr/JLUE9GIGRygkYxFfNgXLcvL64S3Jg3M6/rJg6VANW4Y29/jLwVztUPwBt6gqtUf7ydUJsHqqMBX7Oq3mJNfHaEyNTdKqCLhzMmnOymGF7C7C/IG7uKK1e4492ps2DHoPcwxSHrWjslkjEfwIXaZobrjvkf1JfuuZJwC0oqOMscK1XEQ==
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by PA4PR04MB7965.eurprd04.prod.outlook.com (2603:10a6:102:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 20:49:20 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27%4]) with mapi id 15.20.7828.024; Sun, 4 Aug 2024
 20:49:20 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Subject: [PATCH 0/6] Add support for Synopsis DWMAC IP on NXP Automotive SoCs
Thread-Topic: [PATCH 0/6] Add support for Synopsis DWMAC IP on NXP Automotive
 SoCs
Thread-Index: Adrmrz+4BcZlv1cLQ5CYyuBA6jKoHg==
Date: Sun, 4 Aug 2024 20:49:20 +0000
Message-ID:
 <AM9PR04MB85069DF52F196CDB53C79396E2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|PA4PR04MB7965:EE_
x-ms-office365-filtering-correlation-id: 27bacc57-9168-45dc-5b83-08dcb4c6ea14
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VEtYejFtUeTzjNt/Jc8tngBucJ3SvIA5v2QcMMSC2MD7rGT1IwfuAUDT2qNr?=
 =?us-ascii?Q?tkeFK/3y0YUhKINXQpYpMR4lxTxkwh2hR8HMgNnnDEdhbEtYoJnxq0uue5ES?=
 =?us-ascii?Q?iICUF8jm04WQPwIiKBdFEbSPJNRU5ZiesQgdAqOETb5BUpdSKME69D0UaJw+?=
 =?us-ascii?Q?hzQ+wHiqgDhiz4g5BmURe6Cnir7efQb07JrKxsS36E6q1rwd5LW7uFTc53av?=
 =?us-ascii?Q?AOewqKMSpjIfMSEzkZ9vFDp8kjW7BoN86zox+7FRpCE9F2QPqTvgISNBMj8i?=
 =?us-ascii?Q?e2joh5Fv6JXmwLH6F9XdYk6crRjTBl6vCHsLwnW71dfg74M5aE8Cj+3GMl0R?=
 =?us-ascii?Q?yCOQaJHIWRBYo/wMH5hfpIkkwcn6zxbsJSUaqvF9cNqd4JyXJsjnlaMPWgAK?=
 =?us-ascii?Q?+b2tIVSlw2VMf64MTBotLMNKOx/nXj11iCIV1FThhAQpzXcoyYhdXEV78QYm?=
 =?us-ascii?Q?TFUM1malifEimC4LGXWLkLXV26rO/TO+oBW6NKWQWCbAMM1klwJLd6FrvNfw?=
 =?us-ascii?Q?Nu9DuKxz+La4YCQRrnUpGR0x67AkTukeNipe2FcrJAF0sot572r1Biw4qAbz?=
 =?us-ascii?Q?//phn4g9IyzQCOyGfmyydPk04DxoGZdHko+wnFGC7nPlk9Znj3J7kKW59F2N?=
 =?us-ascii?Q?IRrrmyD6uXFp2AnNXUh5dIQMGtcht3wH2jFa21KdLAIHt5Ipb1XJ3HCNVsPG?=
 =?us-ascii?Q?p4lQsJggRwgD/Bh609dkHPmxfJRX22fLjCQomIFmvNLH+1DYIM0CwO0ji0iZ?=
 =?us-ascii?Q?ontdxXQ1m/AI1gYWW4RTFxTx0pQPh3wg/z+lU0SaQSnkmzHmOAnHjI7NFZqP?=
 =?us-ascii?Q?bjXH/io35qqZLMYlnqwrQhKXwRypmdOnBI+zuosLFCy2wGk3C2VpvSL5fhXG?=
 =?us-ascii?Q?Ocz+eaEfoWg3TbBHl/GJjQuGZKt5BgNFlEWluP2gpp9bpmJ+BBVVu2Wz1xcO?=
 =?us-ascii?Q?ue8yOfmIBML9dxUldMkf4qglckrsUZB+UAp2p2c5pKj3dn+M3sG22lHdLjxm?=
 =?us-ascii?Q?LQFC8GWshFcnVQNCwABTAzP/3JpExCi1lbi+v5qRr8A6j7VJOSHadE2VBvpl?=
 =?us-ascii?Q?TdFJtBUvc2TNzHVHEZABdDYOpUwAmTLGQyjyInRqyOJZTmX5Sj4dD1hLdMOV?=
 =?us-ascii?Q?MjjzYw/NCL9TK3uH8ATL7je79EybIyLBPa5PyV8Ct1k3kVr/CgL1dIf5GObl?=
 =?us-ascii?Q?xy4uGKO7bySVWwT29CMFe4vd+TzwSjJPe21qfq4oJqQTYVXWhkrWpqJve9SS?=
 =?us-ascii?Q?s15j2HPwGgL4VXA6Z5fK5VV8Gxgn84G6xpy9i3FbiXnVV2ZAYh3FWXU0weOX?=
 =?us-ascii?Q?lzhPg7BWdYciY0V0AlbnCugUpaE+e+kmy+bof+YYFmfv3LeAcefXJpeFP4Zf?=
 =?us-ascii?Q?JTkdUFw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3R9Lw84eGFGSfX61FpxzpYnpqAO1zYILSdXbI/IUg8xNdjOuWdlxxe9boLU0?=
 =?us-ascii?Q?GxRY0x0g7wqycq3W8C5YvZJvzinHBfnPuhiY073DibLsEO9kowTV2nwJd3Bt?=
 =?us-ascii?Q?IIaKC8G8TceLg8D/TF2oG+DtZ85A4PFpLcEppO5MOqsbvGg3QqxQ7PC249W/?=
 =?us-ascii?Q?5GTBoBO4lRYMiIEyW2p4/WRI1z/Z8A3vCqdw4ujIVa7a1aYvs6TXUUprCDwD?=
 =?us-ascii?Q?UMcKYQicy9l5SvvOfRHcoALoVtCvQeCCeo/VDgEm7iPEcra5dLLS9RmnWyPi?=
 =?us-ascii?Q?wvh5tNItxbxb8FORCNJHt3hwW5T4fv4ghPspMZ80gsJHsouM3Pp02I9AwmYW?=
 =?us-ascii?Q?OeIzgJcm/Ztizfwp4J+lP+GGrqyg/IbRqLoq9YfykOIBshrJ8+fdmEaDxJ5+?=
 =?us-ascii?Q?TbLLiefuFlvwRQ2RTHjf2sa8+dmjaAt70ey7mdMHnLuXhs//HxWO7AyQr37q?=
 =?us-ascii?Q?Qlk+BF80iUj3BaCNPg3t6Wntut8Qtbto7CQHfOXYMXzvRjmSgXmv7UssbjQO?=
 =?us-ascii?Q?/GJwTadq6Fkknlq9tqdVUpSCQOTKhz81yt1opxfp6S2qysDfGtqmVwDW8CvY?=
 =?us-ascii?Q?nwY3aU4OMujfa+m0HKkMZaAm3Q0/5W2GOr32HBkIO0/ZawDQvjXnBNByxqfo?=
 =?us-ascii?Q?3Vs+mWuP18O1OdQfn7QwlbbbVXppVWk/qztnDj8WGltxihAdwgSEhqgOqgof?=
 =?us-ascii?Q?hSclqqqrH963FBfnGtGVcfYxDO12vGqAh4P59c9q4PqJ1Ovm2j+7eOW8VKpD?=
 =?us-ascii?Q?pHqvczp+7I5BH9vU41UPAWqV0Q6Q40Aa0UxVOg6V4jQTXARdVDjRD9ceDuKw?=
 =?us-ascii?Q?h/v2keuDhRY2F1jDXCmHVw+JeWSk4UoOOeT0D5ibK1J1BFO1Gqruy5524IQ7?=
 =?us-ascii?Q?d28y44PiPX4fdjQ79EOMU1cJz+YyoQcYShcE5ePXVpNh4eTHq66zm1pGZNrF?=
 =?us-ascii?Q?YwS0pd+l9/nGRNMPjBIfzUDPYih8aW2GOm+4WAbDkWRW8jVm5l6ME9qTskYC?=
 =?us-ascii?Q?cnGLWQ6/1WT9ubcYR0HXEUWQdUlLzhrZ5I+2rncRlz/coj6P++sNJVhAMleW?=
 =?us-ascii?Q?6e6uxb47ithh1+Tjsgxd5FOXLy4sbykPNknCvemwQxcyNe3qQV1yF5HHf86c?=
 =?us-ascii?Q?f0posLjgr5OWf1UeQjUytDhPuYpP6t8svYQrui3TuPOOo2EyQKga5RqM531u?=
 =?us-ascii?Q?UyZMYV12YAXQgaSg5vYPTGzS1kSRrYtysFaNgqBl6WUgVdCM/EbPEpBljv64?=
 =?us-ascii?Q?Iq1ocNFzrXNxXHOFKsI0CZm/z2aP0XjzYO1L5WDwgUGhqutTeO+0XeJaUCq7?=
 =?us-ascii?Q?kuYChAwuWdP0erDBloAOj2spHdS/JZo+rKLMeWvkQ6e05BRlHthL+F+G+Njs?=
 =?us-ascii?Q?qi+PEQx61Gmc8L5aBOBhAwDfa6xFySN8cZPS6iz67EayaHnsCnIjbPU3W22r?=
 =?us-ascii?Q?G2C97TDBW3XsoKplVPBMQ5f/fkZfKG3kN57XsdKMyqmV+ewf6rhAYjoU1gIc?=
 =?us-ascii?Q?M2FQ2la94BAd6tw5ysJ6uN3RA0983lSGIaylR0yyTl7r0Q9dDea3xkAssajG?=
 =?us-ascii?Q?v4Vqcm2sRjMgEYSUu+QaGR1DX/++0ChpCmpJ/Xyi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8506.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bacc57-9168-45dc-5b83-08dcb4c6ea14
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2024 20:49:20.3355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MtBuJehXAL/7hsa8i3VJKVwgqgGVIv0Oe708CO2IyRR/LVM2l5VmnFYENFrdXnqO/Xzl/OuHNy34sxG72UkpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7965

[Resend patch 0/6 to netdev as it was forgotten in original mail]

The SoC series S32G2xx and S32G3xx feature one DWMAC instance,
the SoC S32R45 has two instances. The devices can use RGMII/RMII/MII
interface over Pinctrl device or the output can be routed
to the embedded SerDes for SGMII connectivity.

The provided stmmac glue code implements only basic functionality,
interface support is restricted to RGMII only.

This patchset adds stmmac glue driver based on downstream NXP git [0].

[0] https://github.com/nxp-auto-linux/linux


Jan Petrous (OSS) (6):
  net: driver: stmmac: extend CSR calc support
  net: stmmac: Expand clock rate variables
  dt-bindings: net: Add DT bindings for DWMAC on NXP S32G/R SoCs
  net: stmmac: dwmac-s32cc: add basic NXP S32G/S32R glue driver
  MAINTAINERS: Add Jan Petrous as the NXP S32G/R DWMAC driver maintainer
  net: stmmac: dwmac-s32cc: Read PTP clock rate when ready

 .../bindings/net/nxp,s32cc-dwmac.yaml         | 127 +++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 drivers/net/ethernet/stmicro/stmmac/common.h  |   2 +
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-s32cc.c | 248 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   4 +
 .../ethernet/stmicro/stmmac/stmmac_platform.c |   2 +-
 include/linux/stmmac.h                        |  10 +-
 11 files changed, 409 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,s32cc-dwmac.y=
aml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c

--=20
2.45.2


