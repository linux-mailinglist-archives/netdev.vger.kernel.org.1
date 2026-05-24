Return-Path: <netdev+bounces-291148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id u1WFOgupEmrL2QYAu9opvQ
	(envelope-from <netdev+bounces-291148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:30:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF195C198C
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1E3E3004CB7
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 07:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7B6390214;
	Sun, 24 May 2026 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Keyt6rSv"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635BE38F636;
	Sun, 24 May 2026 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779607813; cv=fail; b=DiHqqzvKUFzYQJtC0siiSIH+EfzaRMDbyeMfCNCEETLSgVfKI4WhuQbOsuphjmhpAWbvdzt+fuvdDbaXIXX+vOrHvcZseXcujfg1EClDgr2hxOj4PHO8f34YBiaxWubk9CKz0Ox+TesNwtZwx/U8oYvOHzAOI59ogU4NYmzN6z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779607813; c=relaxed/simple;
	bh=OqxY+YP86DaRdPF7sMB0z66qrDRty9KWlrcAcURxVHs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Mo2jBpLxwCmRNNIlYosFTxks8XXgryoSplZ0cdBLx9VUPp6OpYi3kBrMts83wLfbuwNUobtMF1qgCDUoXhEUjINQsMlFgBTJ3iH5bQbOnZhw6yE+eGMCxSFWMTHSnKtForndrK7MF567jebTQ37s93J5PpRrEnN7gOlUiZ6BDxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Keyt6rSv; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6x/GgJP6rGOhCcKkNbS2LDGHLG++O9RwV4P3Z6ZZHUFHVBhjfRFkbsqT3gCf0VTDhwqGP+hzbQJiutza/KrVFPOeoGOE1X4wgzW9LRhJae1ox3O3fkgEGFLD9mk9KcmHijOB8PoJRa4hzrgfw9hu17n6MMR4JWdJ3c+sE9e4Le1uEg1IvLSGiTRwz52vyHB8rHpnfA85S/hkZl9O9n9Un5Tr0DCNc97BF11JGfBFPvEiXS+CSiTtESpb4bMlUoIGj+VDYi1AYmYolVPTJerswJeehhfmGhs2R18CIxZdT9Y/vUftocfyFaY9ovD/bYH3KnDJ2zL/CNyZTpcXqft1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frqcSUZ/Qf+pPkcSzwOP1bg+8n0Dko7++QmvKILKwVU=;
 b=i5eKSu/Gd/M2Bip+/NMaiS+jD34S4XfJPKlZMpmnShtqSQMjWnbGQu6iSIfF4l6lCishm4LleLhmXk82917KgwZJ5zo9/cEIWCbrz4Paf1LFRNTyk70n8cNuvZv6xjaqS6ASOxrI3TK46X9GxfOlZw4C1DiT2O/N0/Og/LOWdljmyyrgNnv7IUq3YqoOGFg8rGz8+3Fk2naonplyBLuO3NLgixY/1Tko6AEA7AhixCMB6QXJQaUNcpXHHjK+HpT5zhjwYAbCaW01c0UiVOTQntfRmE3mr2JDPFHMWlRY0yyxYwfHBEEPe/SmSU11M6RwFmC8bnaR4XdK3sgvWpzsfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frqcSUZ/Qf+pPkcSzwOP1bg+8n0Dko7++QmvKILKwVU=;
 b=Keyt6rSvmxWm+WOWX+AiuyKCapYqhBFM9j6SLJ//LRzrIa/e8+mVmobiQL8f5sfUsX4Do3AQPgtMYak0sJiNr5/GXYWvWm4WzxUa+/uNDXRYBDRYqY4k+C3hC27+O+Hg5RlPfeIoFwr0mCszwWhNnnahAzAQzzwXvxSTKGdn2+vBVRu67Q5MLdezMX4pU23ycvsV2xCkVy7tzWRTuIL15ncZTq/a8bWhnYbBlzL/Zi4wjrK2DTnx8p3FE3YvDB9pF/j9dlCtkPUvSANPZpqDDFXCGqXluqaNcSId7nFX0G5qDE3x96aWP80rjctT/45aMV6oDdbphIWl3/aqMbMabw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by VI0PR04MB11784.eurprd04.prod.outlook.com (2603:10a6:800:2ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 07:30:07 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 07:30:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	olteanv@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: netc: fix unmet Kconfig dependencies for NET_DSA_NETC_SWITCH
Date: Sun, 24 May 2026 15:03:10 +0800
Message-Id: <20260524070310.2429819-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|VI0PR04MB11784:EE_
X-MS-Office365-Filtering-Correlation-Id: d265b288-ac42-4894-d927-08deb9664724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Moq8dHK1Zkuq89c5YogWzg5JMpIU+lHSXUWWvYp6Lrii52iBYctT/ap5vKDG1RlS5rXz+zz+zpUDaEbf6UzCQVnepkeo7X/yG1yGXe1Xl9aia6kUtf7mUuQM1POxhn873UZiAdEixiAV5BEqPAkj4Ivj+xWIRcBYsIx9cxEI8EG7IDv6gi/J7m2Ya6Kxc8sGZ5HEHrxdY5qz+mfRNn5AhdbmULSw8OT/9vxmzSoE4T1J8GU+zWA+//wIxdcypRX/iarBVF90hCl7PWA2vdqmyUhlto+g80+b8Gzqx4179kKoyK9nNhlLPMQeN/Qz71A17P65QW07C6VPFdNkbqYzOKpl9abbyDabADGGyrDnXfUwBK6uXWxnjDwIQZQpYFzBUKP3rq1GNmHZJ3LYG5uEPHBzFLIJt4vn+WLRk5sX/oNT8YhavIgSYyQktTlCO97HN6uk4KQEnKeIHYB3m+x208Cg/21jqnaJtcPxsMsDxQIeKk7n0UB2rIaXk3zdowHLZrNmmAziaiAWGZRLHGBb/m7iHE+AKNxtoWryM5/Mhk7megkjAYSNg0TQGcGsSQdIfCy1YUXqugryvJIY5kP8ITb/9Wx5VeSlUgc70TJSLDQ+C68YmyETYuu4eVAgPkSzSYRJTjC2RNpr8vDN6xxN3EPUhjhWvjf0WovSbtniDIyQCKyMVN+ipDGrJxaBnHWoOhczONht5I/gGT3fC7kKyGGBhlL5hHgG49mRV5c2gMKNh2WKk89G2Z93b6BLdSa6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SjUP30OUtBaD82u37IxnrBWbo0zBxL5Mz2YakH/EAIPMr7mcOpOw3+5iCF1J?=
 =?us-ascii?Q?jsWnILfPdB6OpPMQyXiEfnjFhiN+0jY7OCpU05AngO/ZMF42hNNSfDXfr1cQ?=
 =?us-ascii?Q?1mCtmKE+0aBYNJNGp3MAMXy7G5tiP0BjUJ3so5rqkk+yaVv25QsYM+lC97cT?=
 =?us-ascii?Q?KQrT1H49UoGpvBHqo75VEGTip83Xg2dbfJGx1fN6ZclFcTkBjq5LJnEfo5on?=
 =?us-ascii?Q?PEsAM2QwPIJXmWYTs9nVWhMaYTmOvj+dvZKlllhJ61XCBrcJOIN/iHPoq0QE?=
 =?us-ascii?Q?Tp9UuDwJym2sJp8uxQsAwsWVc547K464+0pvdeupKxabuPW1Cgku/S78TX1T?=
 =?us-ascii?Q?ALiT04SxnnqBEl4em53valdtqha13/ohbOuxcmdQzfBmK96/JtMStUej7yEw?=
 =?us-ascii?Q?ZB0VDcq0JVwqND7qJ54V3A6vUOHL2OGPnSdhKTNvJYiQfT0Fbq0HljibDWxT?=
 =?us-ascii?Q?PA5qvtU0jnyWIRzxgpELL/hFj2pvsrPr26lHsjChcOs5wJrvd3hEgTQ+6xps?=
 =?us-ascii?Q?iOFwA7boCj6ZsjECu39zBYUqFrkMlhk1mHRZ5y+2vNZAyYbZiMLMYScGO6MS?=
 =?us-ascii?Q?aN2EmZ0EmbJtoojtqTaspyo71csFX0C3TafaJrsr/SttLWwbdCFKKhXacLyZ?=
 =?us-ascii?Q?YL+f9wIoMeTGLAIfvqEtlQYsbMTGMmc1AZmHD9j+gshPVInJo/4n81GjhfvI?=
 =?us-ascii?Q?v8vryEszG2AnFUDXUiRLT92t01/XUEPHx2g6C+DqoDh9+H97n1rAOA6Tl4tZ?=
 =?us-ascii?Q?CPLID+cImWxneUAHfWIAp8VR1+Ovg7muRoW8w+WGs+DeW/WM84cC629fYv3/?=
 =?us-ascii?Q?cBTQKdTznKXPqWP/2zPw0LckE1RFCv3ijnB6WOO7dnvlpyzfxux75jdhPz2k?=
 =?us-ascii?Q?vpSvfW3p3ddbYosn4MTTN0l0IHL7tpEhPZ+ASk0SU1mA1IdCAgVmzsT0HhsY?=
 =?us-ascii?Q?N+eoaF2/YVwkyzh0IRQc5ArncmKBSI1F61WX9xlASyq6ufBmGwuXXBfLy+aT?=
 =?us-ascii?Q?98cM4C4T+c9ZlcrIlqLDMtLukTJu4RgBtsgt8xp2LhmeasHVcOFfi9T4cFLu?=
 =?us-ascii?Q?felsqbQ3x02rBWH93FxwUYnk1IQCHqk0VHtHBNuj3QN0TL5tejD5yhhub98l?=
 =?us-ascii?Q?wQj6s6RPzKv2II4+seLcMK6MQHN5qoeeVqGjQBsvp52GVTCWDg5igzaKkMYL?=
 =?us-ascii?Q?qVk5dY1RXjyKoCtlN2UPTGbpdRdwzrP+USzvA2ysrQHo6E4nvXs4aNlOaKp+?=
 =?us-ascii?Q?SFXJLHDP0CG77Mda3cbdM9J/gZeqp6b2oWLOzYtut9aqKmfDg8aWT29hewPi?=
 =?us-ascii?Q?ScaXTAWmoTIiOju6W1iFSswJ0WiBY8UTFHoBAWMmAnBfu6BfKQEe99QRuy+b?=
 =?us-ascii?Q?OtohPLf8Zu1HAfRNBmZHHp7WXh40BE8lxEJo0Y8ntfAZ6I43oOASNwgD7PBM?=
 =?us-ascii?Q?KCXwJeAx1/iLb9LW4TJEDohn9R7MRyuWyKAc/FQ/IBw6gqXNHbYlwySIIUra?=
 =?us-ascii?Q?cHtvT4QCuLfcdt7R2jutB81p+1fV4gGzUNIfk8L2Y2HKYs83Y7SKrAcyU5m8?=
 =?us-ascii?Q?BJ8GBEJJuiOCdz5ES7KVw/Uy9tIyeg+9XhYIO6u61shddG12DsbGXb/tCOS5?=
 =?us-ascii?Q?0H+KUtmdnoAre+9JjzAGzNr3j6G65P8L5CgLh+Wz25TNs8GWCcoqGf8iiJQ9?=
 =?us-ascii?Q?1+LUVoVoYfHRvDuDA3GyJE+g9J/A9iWulYzYXNLdzGY6frM78pv4m2gCysHg?=
 =?us-ascii?Q?VKOxcDVIKw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d265b288-ac42-4894-d927-08deb9664724
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 07:30:06.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGyDd3BqEU6P3xNYmSVp4ZYJCBqUTGUA+TEDUTCQSIW/GhD4MSRxOy4MVAuQ40pp61RodFSEwIevLXVH4yv+Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11784
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291148-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DAF195C198C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NET_DSA_NETC_SWITCH selects NXP_NTMP, NXP_NETC_LIB and FSL_ENETC_MDIO,
but these symbols depend on NET_VENDOR_FREESCALE which may not be
enabled. This results in Kconfig warnings and linker errors like:

  undefined reference to `ntmp_bpt_update_entry'
  undefined reference to `ntmp_fdbt_search_port_entry'
  undefined reference to `ntmp_free_cbdr'
  undefined reference to `enetc_hw_alloc'
  ...

Therefore, add "depends on NET_VENDOR_FREESCALE" to NET_DSA_NETC_SWITCH,
ensuring that the selected symbols NXP_NTMP, NXP_NETC_LIB and
FSL_ENETC_MDIO, which all depend on NET_VENDOR_FREESCALE, can only be
selected when that dependency is already satisfied.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605240046.8MvKuOMg-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202605240706.EuGmnrz5-lkp@intel.com/
Fixes: 187fbae024c8 ("net: dsa: netc: introduce NXP NETC switch driver for i.MX94")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
index d2f78d74ac23..793f7691a24f 100644
--- a/drivers/net/dsa/netc/Kconfig
+++ b/drivers/net/dsa/netc/Kconfig
@@ -3,6 +3,7 @@ config NET_DSA_NETC_SWITCH
 	tristate "NXP NETC Ethernet switch support"
 	depends on ARM64 || COMPILE_TEST
 	depends on NET_DSA && PCI
+	depends on NET_VENDOR_FREESCALE
 	select NET_DSA_TAG_NETC
 	select FSL_ENETC_MDIO
 	select NXP_NTMP
-- 
2.34.1


