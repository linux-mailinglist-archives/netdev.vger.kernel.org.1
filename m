Return-Path: <netdev+bounces-239682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0948CC6B58F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 907E135CED6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28842E9726;
	Tue, 18 Nov 2025 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AQOoqykt"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605512E0923;
	Tue, 18 Nov 2025 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492760; cv=fail; b=gPDHgFT1D+CX9KJJKFje2zryZs3x3IiIUuVutFl1NM4tGinhSevgyZw398iAADg3ckN0+ji73XtkwW+ySg+DT6QjidnyWOmCdRD5ya1DdW/PT5oA+RjT6zVWgaE2yNWhYMemp69J+2BaW4woys0ipr7Q/F6sSEoTJAB7r8TIxT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492760; c=relaxed/simple;
	bh=RQFdIK85Y6fQSVZj3M5r9rDDHJxVr1twZSdsTOhRnF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hvNYqqO2B472vhc8yBLNrId4rgwsQG3nCTLL+rvaXjHmnznhq46bcaNurt1+WsZuW/Ac+I/9I5ccuiFM+Y6Wa/Vn9SoX2UIVEOh1Nki/B++dSHY67NQJ2odg2C0fr75jgimswOy21z8ocwDd/QE7CfE2uhNOLvhi9AVLGAUCzfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AQOoqykt; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkvxKM3OYQwhGD3xPT3gtcMSaL5H8FOii+uTORZD3bWMq/Ep//bOY8gZDkqw2PWk85figPqLL7Q6TFsnM2wzJV4oJrM02O//DGv90MaBIVRaesvXxs1wNJSoS1+XSyJnSH2vRM7e0fZb2XjWpWB1hdawAmjN7tvg6cVW+atlmsz9WVUVjLu3+oWLoWLnCiQ73fLaitNm02sdU9Vg4BwPLoRu4k9l/Gtf1hUGnNjdzWhYDhMGjKkBVArtOcsSx2OxCqyVkSNdm3FV1FZxoxAIVKD+t+YLTcYpiXUz4JN0oX2qFiQwtl48kWUu0a3lFnlzr0x8URQGLXI2TxxxrGjc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLTokMySjNCSV+t4RLCGjVixSmha5W0M5N7RG/wdk9Q=;
 b=RAUw6cTZujR5XXa1j/s6erQS8JTBqpQEgZRa6FlArP5MCMeQziKB/5uTLtQIvBKMYYHxtMwCDTdGa2q/AYkBN47T7OL20Ro7Vyfs6zn8oG3zIgPTXADSDHps0IszvHwCiQx4+14/pU/ENyrB+8ayI72XoszFcPdwK2Xkl/xqy0lQuLL7Or7UKIofCFg2PxPrBg4shguAezMnvWPVC1/ZybKPNxQORuNW290UR6eE1fmSUJrweXM/NhmYHd+j5Z2P0nXcAEuSLO3Tpz57iGVu6DQYg+NhrO5jwrluw2HFNBXRndcEzp618NPhoiGnW4W3QFFIg8RFmuoKDt7WYKiLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLTokMySjNCSV+t4RLCGjVixSmha5W0M5N7RG/wdk9Q=;
 b=AQOoqyktvMtYE4R2vyyhbk9kNRcDyGkYtIN0MlGomolHftUCbg5qvKAI3HiWMx2wFo06dyb6j7OnAsOkVKjcedRtgGR4b0bb85RkV5fwBOsiQrqwSRVc5UKp4I6VI4Va0L3eVX02tDoaVpoHCMi1lgn+HHv25xQ5l+gh6xKs36JUa673TqlQdeMeiMc96/xM5GG4DMyg8F+9w5hWQo35gg7WD8SMqr7VuwVEZ8ZO+5aeF+brTM4ZAl8rpUcoonTXrK1bUGDa/h3dwfnqCpbreKnVntbVgxDmjQES6M9nBJaVy6G4phNJoWXZ1WUtHF84VV85FiYCfUsIX15YWHEDcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:05:51 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:05:50 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 03/15] net: mdio: add driver for NXP SJA1110 100BASE-T1 embedded PHYs
Date: Tue, 18 Nov 2025 21:05:18 +0200
Message-Id: <20251118190530.580267-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118190530.580267-1-vladimir.oltean@nxp.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff1332a-eccb-4824-0a5a-08de26d57d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZpOh4eKP5ApDXfenVTPO6cj0VD58/h8B45DyvXWIcWmpmcQBsNCKgKJdIDw?=
 =?us-ascii?Q?Ne+QwzPkf1tH4MzdIl/oYKav2T6tvfrkD+0tMFxxo5LVZawWwKNfDyZD8y3k?=
 =?us-ascii?Q?YPu/uXdA+tmj2zi1m1kTiabYGjRVtbaAIFUx6xdPZ5BV8h1A3BZmXbmwNTFu?=
 =?us-ascii?Q?cxstZo1Vi3SxY/O15acmYrLIEuUsWacrm/c101JZqzyJswnba23/HGpryvYS?=
 =?us-ascii?Q?pfxTulBi9RJCPY7qSra+s1c+kROl2ldk2Cx4DgMmz4u0yrIH3Y2/zknCoPS4?=
 =?us-ascii?Q?9/n7OOBrJWUNjf13s2Ei+03BiHmcs76AzyBXI0617leXF4AdNgwPLuwKC7TB?=
 =?us-ascii?Q?UMLFqq0AuxgSDVD95G2kxv/O2U8X9CurFvOxvl2f7TqeynVxyquz7w/b5rUX?=
 =?us-ascii?Q?11xfpwYBYOrIvQObQVKFqMwIVyLig+9uMD4VfSuoe0o1QX6HAJip/CLT+MNO?=
 =?us-ascii?Q?EPsWOvJOnqDP/z/C8D+6urIZoH6iG7jyVReAsT8678dWhiASP3mLs2DBQk4m?=
 =?us-ascii?Q?qNHMMdTIexKENyHmAeQ/mIpoiJprYZ14UfL51cTOZN0YeJfUH+1XHXH4SGsX?=
 =?us-ascii?Q?WJVYiDLfcEkjHOVWl7MG7T2hmsdUaSSYQRvppYE3OXOb7Is5KEQfYP7J/wdx?=
 =?us-ascii?Q?OneIoNRS3IwLunecncoOMF4bStYztmXD8nR7pkC8alJI7KQz370FUkcmhTTW?=
 =?us-ascii?Q?mmBlzW9YQHBD70g27yP7M6lV43Tnh5GzyF4dCFb/uwx8QSNgZEVm96k6Musa?=
 =?us-ascii?Q?R6irhbC/g+x/bsIVEQR69ND2pxIsOcT4eeRqXx4f6YuUk7vK9lpC5fh69odP?=
 =?us-ascii?Q?HGnfbMCTaS3Tzjc+sdHSTZF10PHDzSlU/fUTK6z29hbJUl107soDR97nSFZB?=
 =?us-ascii?Q?3JtzPF8YldAXBa7kwhRQ1S0C1fyomBUCMm0XQV47f7C22Dq9UVHHh6Yvtqqk?=
 =?us-ascii?Q?DwHA7vpjSgsnBcYA+QveHWzm8BJWImmg6Mxa7mohM+K7+l77NBvbm2/zMmVU?=
 =?us-ascii?Q?qqZNoqmwB9d3hQSZPmMht3HLA94Zgb0gO6nnRefQwa62Ktyvyop5B0nsdMnx?=
 =?us-ascii?Q?IHRU5g/2iCwUB765/0NSIJ4BoDG+BLHn9193Tu/4PIjSoF3mM5C/0HSZFaVs?=
 =?us-ascii?Q?uHOGHHIkfB4iYVLQ5LKExwxDhuQORIQRnJgWSKTc5TAk22oIy59lFJLTmC3n?=
 =?us-ascii?Q?eqx+2Abgg53wNNCVZCw31z4llcIYx3CsUScYzAuYPJ1xYtkfHlC6whwYytzf?=
 =?us-ascii?Q?jPGp5NSOPikRbpVck15ea9aLk+GNlgQAwT0wR4Vt4mCsKNQajpDfo0oAzkvq?=
 =?us-ascii?Q?AyHA//X44k18nIHAtZ3PJXr3plf7zIvrpGgJKyxJJ6Bm/dwK9ptSVu6H4dPA?=
 =?us-ascii?Q?t0Ub3jXSOY2j/nYnMbFTGKTzh1E4Mf7X8eonQRbpEq1XJ8mwPkBYj/iUJZBN?=
 =?us-ascii?Q?hwP7Rh3Q82wag2EekYejqyGR3qrAd9E9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Zp4HDN00rqRcphtaKlxa1lZdTFwUXa5EQtS+9M9V8Z33N7jSnNffZ3+mwFt?=
 =?us-ascii?Q?zGzHH9hDAemZlyXY4olqZVc6X2rTInsjWkUtW4ssMA88PBrbaOcILHEFrjUP?=
 =?us-ascii?Q?N4JSda3KbwFpqvS0cQ/aBhw93EWO07Uj8YYd0WnwcvRb787KPRlCQ9BNCKCe?=
 =?us-ascii?Q?Px/7WN6z+MyaTgrv+ZYLYjz5W2lVP1hNXf8bYFs9cgG6soSiqv2I/egZQwTj?=
 =?us-ascii?Q?Jg5TeC7rDtaIeHHudkkKVlTqGI+1HP9+ovQHpML7hpYfUETwSQ4dNHtICB4N?=
 =?us-ascii?Q?KFlOi4b35iH996/6bGBYlEAd22KJOIRaaW9svT49/OJycvGNUAzZeUjs0hQo?=
 =?us-ascii?Q?k/0TepPxSCHgMt+3FFWPCBGb3RoiLOuPs0ZRFHQ1EpnzpcQmdcOdX63WSqzd?=
 =?us-ascii?Q?iweZa2hX4efVj4fA6huCCFmA9tRIPVOkMldDbLEfzy65jMVLAjYkPcSpKyL4?=
 =?us-ascii?Q?kCvT5TbNj5I9rimX+QJ7USQ+CxuHyMGh/WljI/610GvUhso8oil+bZQCcrhi?=
 =?us-ascii?Q?C+kBrGvdq43PVqHtYhvilMn5GeuHCJxKCu2I2jjwNFxkF0jYGaqY14HypSO6?=
 =?us-ascii?Q?fJbghbD/nCOdWZW+fNf+A+2cPeCchfdj9TXOlTARhie1e9CPRyFAa2xlQ8h2?=
 =?us-ascii?Q?QFRKUnOeTFj1FCi8m8pglNuFjBnfxeSD++zX6D3nWwwi84cIxpvaIQKSbE/Z?=
 =?us-ascii?Q?lLZqfeoE5k/zSr+of9XLVWjEZRSSfMPwXxPKbdRT+4fPIsM4iQNSvE8sLtJm?=
 =?us-ascii?Q?2+Gme6ITpekJJ9mU620X1Rn4FKGsSYJ26nekVfqtR3EergvOF7jntuhScV8a?=
 =?us-ascii?Q?MZzFOVzUBqRPeIWe9Uc/Wnd6CoWO2uD/ahPpfgw4mZMbTwn75m0WXVnWuZmk?=
 =?us-ascii?Q?K0pmxs5rLSZ6k1/DSjCSVMLUB2NeE0+updpZUyHteQVgNzAe3OOO0LZInGXe?=
 =?us-ascii?Q?wi95NUW7ge76a/Od7By/aj+oi3umzm8h4DASCjIkA02OYT0QPFyPjZ42SMLC?=
 =?us-ascii?Q?ax6qMENH3AuQOvQbBxJEPUzK9UujEnnI9ciyBP792b/tly1MRVzl0xsgfDsl?=
 =?us-ascii?Q?NPuOLNkzYgTsVRb+Qr9LBMEWeFxd7R67z+vmx33tqYV4EpX0dPg2PjmNZlDp?=
 =?us-ascii?Q?yHhi76rCro0u0ND0+OIRgvEY/uQTJuib1GwxN6j6lWhkEl5FpyMUnUPggXPD?=
 =?us-ascii?Q?M5pQiYWVZzcQEzAlkhQM8kbkobR+sOZ1LIK5TJlO0HlR/DwKp7jf6TL79Si2?=
 =?us-ascii?Q?ZdJeEAfucCPJfjC5RRpnQKsEsYlZDYKuE4pjMyGM9A49iBOpBQscybEn+5N0?=
 =?us-ascii?Q?DeIbseZjZ0ZMB/CybCUymJfCpXK6tdOsUSrQXMgm940/ktxbC1OWdMsx56/V?=
 =?us-ascii?Q?4elFoEKr47ERPzDlrNnZUXOlAOJAkK5O2iwLeT6C6hs1oUGJBcuXh6T972an?=
 =?us-ascii?Q?lfu6cCs0cKaz2ervBGiTRW40eMEekttVCbzZUOV3x3Y/0qCGLdWg6qdQMN2L?=
 =?us-ascii?Q?u/voLRv7KzYf5MswuwunhZkOCWl62wkhUvPGqloJ2WsWbHhsPPwv2ZYRcySH?=
 =?us-ascii?Q?QN6rzozlPHvuyEEzYvpUyxZr4rQklFGQvV+DjdoJKvVwur9V2V9uSU3Urg2f?=
 =?us-ascii?Q?n5ro9Kl95jLg1CPHO9ASC+A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff1332a-eccb-4824-0a5a-08de26d57d70
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:05:50.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AycRGqhKx3zbxycIxSSxjy6gGOHjYi05mSuCpoDoPB/tizP7uZMeFYIigoMCSIyucvOysS5v+3d47rywJXfltQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

This driver is the standalone variant of drivers/net/dsa/sja1105/sja1105_mdio.c.
In terms of differences:

- this one uses regmaps provided by the parent as a method to abstract
  away the sja1105_xfer_u32() calls for register access
- the driver prefix has been changed from sja1105 to sja1110 (this MDIO
  controller is not present on the older SJA1105 family)
- in the sja1105 driver, each memory word has 32 bits, so addresses as
  seen by regmap need to be multiplied by 4. This affects what
  sja1110_base_t1_encode_addr() returns, and is different compared to
  sja1105_base_t1_encode_addr().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 MAINTAINERS                          |   1 +
 drivers/net/mdio/Kconfig             |   7 ++
 drivers/net/mdio/Makefile            |   1 +
 drivers/net/mdio/mdio-sja1110-cbt1.c | 173 +++++++++++++++++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-sja1110-cbt1.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 37f4278db851..c41b9d86c144 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18679,6 +18679,7 @@ M:	Vladimir Oltean <olteanv@gmail.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/net/dsa/sja1105
+F:	drivers/net/mdio/mdio-sja1110-cbt1.c
 F:	drivers/net/pcs/pcs-xpcs-nxp.c
 
 NXP TDA998X DRM DRIVER
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 44380378911b..9819d1dc18de 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -136,6 +136,13 @@ config MDIO_MOXART
 	  This driver supports the MDIO interface found in the network
 	  interface units of the MOXA ART SoC
 
+config MDIO_SJA1110_CBT1
+	tristate "NXP SJA1110 100BASE-T1 MDIO bus"
+	help
+	  This driver supports the MDIO controller embedded in the NXP SJA1110
+	  automotive Ethernet switches, which is used to access the internal
+	  100BASE-T1 PHYs over SPI.
+
 config MDIO_OCTEON
 	tristate "Octeon and some ThunderX SOCs MDIO buses"
 	depends on (64BIT && OF_MDIO) || COMPILE_TEST
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index fbec636700e7..9abf20d1b030 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_MDIO_MVUSB)		+= mdio-mvusb.o
 obj-$(CONFIG_MDIO_OCTEON)		+= mdio-octeon.o
 obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+= mdio-realtek-rtl9300.o
 obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
+obj-$(CONFIG_MDIO_SJA1110_CBT1)		+= mdio-sja1110-cbt1.o
 obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o
 obj-$(CONFIG_MDIO_THUNDER)		+= mdio-thunder.o
 obj-$(CONFIG_MDIO_XGENE)		+= mdio-xgene.o
diff --git a/drivers/net/mdio/mdio-sja1110-cbt1.c b/drivers/net/mdio/mdio-sja1110-cbt1.c
new file mode 100644
index 000000000000..a5f7830a6257
--- /dev/null
+++ b/drivers/net/mdio/mdio-sja1110-cbt1.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2022 NXP
+ *
+ * NXP SJA1110 100BASE-T1 MDIO bus driver
+ */
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct sja1110_base_t1_private {
+	struct regmap *regmap;
+	struct mii_bus *bus;
+	unsigned int base;
+};
+
+enum sja1110_mdio_opcode {
+	SJA1110_C45_ADDR = 0,
+	SJA1110_C22 = 1,
+	SJA1110_C45_DATA = 2,
+	SJA1110_C45_DATA_AUTOINC = 3,
+};
+
+static unsigned int sja1110_base_t1_encode_addr(unsigned int phy,
+						enum sja1110_mdio_opcode op,
+						unsigned int xad)
+{
+	return (phy << 9) | (op << 7) | (xad << 2);
+}
+
+static int sja1110_base_t1_mdio_read_c22(struct mii_bus *bus, int phy, int reg)
+{
+	struct sja1110_base_t1_private *priv = bus->priv;
+	struct regmap *regmap = priv->regmap;
+	unsigned int addr, val;
+	int err;
+
+	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C22, reg & 0x1f);
+
+	err = regmap_read(regmap, priv->base + addr, &val);
+	if (err)
+		return err;
+
+	return val & 0xffff;
+}
+
+static int sja1110_base_t1_mdio_read_c45(struct mii_bus *bus, int phy,
+					 int mmd, int reg)
+{
+	struct sja1110_base_t1_private *priv = bus->priv;
+	struct regmap *regmap = priv->regmap;
+	unsigned int addr, val;
+	int err;
+
+	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_ADDR, mmd);
+	err = regmap_write(regmap, priv->base + addr, reg);
+	if (err)
+		return err;
+
+	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_DATA, mmd);
+	err = regmap_read(regmap, priv->base + addr, &val);
+	if (err)
+		return err;
+
+	return val & 0xffff;
+}
+
+static int sja1110_base_t1_mdio_write_c22(struct mii_bus *bus, int phy, int reg,
+					  u16 val)
+{
+	struct sja1110_base_t1_private *priv = bus->priv;
+	struct regmap *regmap = priv->regmap;
+	unsigned int addr;
+
+	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C22, reg & 0x1f);
+	return regmap_write(regmap, priv->base + addr, val & 0xffff);
+}
+
+static int sja1110_base_t1_mdio_write_c45(struct mii_bus *bus, int phy,
+					  int mmd, int reg, u16 val)
+{
+	struct sja1110_base_t1_private *priv = bus->priv;
+	struct regmap *regmap = priv->regmap;
+	unsigned int addr;
+	int err;
+
+	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_ADDR, mmd);
+	err = regmap_write(regmap, priv->base + addr, reg);
+	if (err)
+		return err;
+
+	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_DATA, mmd);
+	return regmap_write(regmap, priv->base + addr, val & 0xffff);
+}
+
+static int sja1110_base_t1_mdio_probe(struct platform_device *pdev)
+{
+	struct sja1110_base_t1_private *priv;
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	struct resource *res;
+	struct mii_bus *bus;
+	int err;
+
+	if (!dev->of_node || !dev->parent)
+		return -ENODEV;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	bus = mdiobus_alloc_size(sizeof(*priv));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "SJA1110 100base-T1 MDIO bus";
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+	bus->read = sja1110_base_t1_mdio_read_c22;
+	bus->write = sja1110_base_t1_mdio_write_c22;
+	bus->read_c45 = sja1110_base_t1_mdio_read_c45;
+	bus->write_c45 = sja1110_base_t1_mdio_write_c45;
+	bus->parent = dev;
+	priv = bus->priv;
+	priv->regmap = regmap;
+
+	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
+	if (res)
+		priv->base = res->start;
+
+	err = of_mdiobus_register(bus, dev->of_node);
+	if (err)
+		goto err_free_bus;
+
+	priv->bus = bus;
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+err_free_bus:
+	mdiobus_free(bus);
+
+	return err;
+}
+
+static void sja1110_base_t1_mdio_remove(struct platform_device *pdev)
+{
+	struct sja1110_base_t1_private *priv = platform_get_drvdata(pdev);
+
+	mdiobus_unregister(priv->bus);
+	mdiobus_free(priv->bus);
+}
+
+static const struct of_device_id sja1110_base_t1_mdio_match[] = {
+	{ .compatible = "nxp,sja1110-base-t1-mdio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sja1110_base_t1_mdio_match);
+
+static struct platform_driver sja1110_base_t1_mdio_driver = {
+	.probe = sja1110_base_t1_mdio_probe,
+	.remove = sja1110_base_t1_mdio_remove,
+	.driver = {
+		.name = "sja1110-base-t1-mdio",
+		.of_match_table = sja1110_base_t1_mdio_match,
+	},
+};
+
+module_platform_driver(sja1110_base_t1_mdio_driver);
+
+MODULE_DESCRIPTION("NXP SJA1110 100BASE-T1 MDIO bus driver");
+MODULE_AUTHOR("Vladimir Oltean <vladimir.oltean@nxp.com>");
+MODULE_LICENSE("GPL");
-- 
2.34.1


