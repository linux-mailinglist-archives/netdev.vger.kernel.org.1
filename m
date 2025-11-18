Return-Path: <netdev+bounces-239685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA339C6B5CB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5979341741
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7E432143C;
	Tue, 18 Nov 2025 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nHRDlWpK"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD22E9EA4;
	Tue, 18 Nov 2025 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492764; cv=fail; b=d5rJTktNrrnIEqsB7ZM9V3y9sWJ/E4axLGBJSRDmHQg4wjmrgYooUoTt8MrTyaVkGmjyQTDFXW1PDD+th5VEzdyhR+KlS7uSOBHI2XG7rKcc5chawET5hTuf8a0qWTCQjAG38j1kHcWY9NtGokPsA5tTWmBKuE4Ih1O+gimQlFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492764; c=relaxed/simple;
	bh=TTKzGoiP5Fs3XlRHMEH601GzhezBP7KdmJHWS+vNh+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJbgRqoiv+TzQJXfm5O5lU/ui1T19E6bG0Sfdp+OBueXGwu+c7FarEMcPjNUfXXOChT5RMnKEv8Qz9ppFOLCepxfvIpqz9dFNC/PVcbyBgN0a4iwqRsfq7pxBsoqSldgQT3p+8O570Wnbcj5ddUao5gTBZc0+VdUCnpVPNK9YlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nHRDlWpK; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uN47eEAlRnBvfR4mrQhe8vI0/MCJokRdJb2xwSnEPP+ALp/nQC6Ct/W2ffR9gQimEeg7KvfHaapjUMebLnc7ScfDItlYa8iZXmfPO+2Zf6U4LECUHONMpKM6+J+i3VXM2WG1enuRAwdHAL90mJLPSbPA8V4wUnzcBOF6xNmQh8CWyPo4C+itxWTyNYmXmIf8AmPITfrB+zoWf8Cvbnj3fTIEklPsFhJ0xp0W1ubJ5Gp9qJA/hrT6M9nog8G9b4zS1AVO4cpZQI7ohky+XVwBvAv8NK8RQlKXG7iCpleUNZD2Vu8VBI4kCLwOX2VCCmxs6b8+sxFkEWSUJu62cVeumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2Y9gP1y3C0M+VxsOU50jFyJOi0XVdWxuejgWiIXKCE=;
 b=kis2LiTqU/KJkjdLFGG5qN/2Tq0Ge/MhCW2MDMn8adfPkDIuv4cboTCX8//s6uC5k3gIQjXPPtsqVY6HZDl6QbgvQwj1Su3A5oZzobJc3vVaB+7rkxpEja1zZabjMKncuaGTbQqbYeZlbdaOCCH71MjWVkXL87KowDve0HUxjoRfUybuS8PP8ewXYrQvnRT0ZPkO3caqLmUaJk1TeO8RoZmnkRndpCnXRe6u6UeN5xt/U1aXWrk8bLrrAVGYwHGEcGxnJU2aA/RG1YPWsKPuH+N1GI3R5n4FA0K1KTwU4fHc2XKjURRgtbyaAheM94caF1YZJvKqitipe3Z02YR1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2Y9gP1y3C0M+VxsOU50jFyJOi0XVdWxuejgWiIXKCE=;
 b=nHRDlWpKNhlrihC6exyXLMY7aYdzWNSBGOZQmZMfDjcpR2KqKwrVMQ875I2rNzjiQF4bOwidSgE91zn1iA+vkf34suBFtJniDiQU0V6enucKGjf5DEaeH+QgA5BcF39vJzZMCcFGErCwZ5XY70E7/jbj2Gk19pBkGR7P8OKPYQWcjnzlGhrliPITL5hFdxUsFpSBK0gNHsoxA3D6YaIwdyl15TkQ41nHTHMDC2HUWsNr60hqtzXGhq4jc05NqRf5GZbIjAdrDt2M/1irvIzYBtvRlZDL8WVWng2FsQrogZsiF6SNbYrTAzncsseXyAAuazK5thzaAhtYTjVBB+00SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:05:53 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:05:53 +0000
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
Subject: [PATCH net-next 05/15] net: dsa: sja1105: prepare regmap for passing to child devices
Date: Tue, 18 Nov 2025 21:05:20 +0200
Message-Id: <20251118190530.580267-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ff39b17-ef7d-4899-22dc-08de26d57ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ODn8qMYwhSD+XfHpyofMx2GzfK0kH3d+3jytrVUqxJkPBUhpapYXNSfArOjK?=
 =?us-ascii?Q?rYMggSEkkekLjfIPw+Z+KKS5EZDW99f+ARqSEfUXki7r2hnr2eApbTN7cTY9?=
 =?us-ascii?Q?+99u40GmFHwfCGuoOyMyay3wREljkS1G1RKOxed68g/6QmU1+w/bOEQpcOIv?=
 =?us-ascii?Q?tXQW8y9lahNmAc65iTyJlA9N+ddCniawg5UumwpO7LWtY+v40sHJm12YjBo3?=
 =?us-ascii?Q?HIjT5ldgR/3Vl6Fdj5qmYWtDMWd6TXKyTh96iF80uufJML6AbgMYhOTSyrnc?=
 =?us-ascii?Q?Cd2L7B0aXjBTlLfEkJ+B5BsXEMCyM96iLV9aQGEOqjiynQLe/Fj7uk0+cOk3?=
 =?us-ascii?Q?G/JflAkIq3vYxFDQfozDhgsguMisO12CBwkTVX7YxYTGDYJY8H7OV2D9TXko?=
 =?us-ascii?Q?pUWxRuSRlfW4hiXLvfY9sw1xdxDUe2bxtUzb6D1ZbBiffkXG8lAhdXdC5YyY?=
 =?us-ascii?Q?bpGKeeN0YBcvy85w+TJ29tSN+dJeEI52CjCaCAX9HEUOSmARHfg3cl9qL4DT?=
 =?us-ascii?Q?UQxgz85ItqvgcS/00s0ahS7ovCeIAybGl3sAJry5vmoRnB3IUYhe5Jk5bFJt?=
 =?us-ascii?Q?FEHItT2QqVKy5+tIXA4wn/GiX2Q6s9lRFK+aX/6c0BP8vw5XnenIrRsz4ukq?=
 =?us-ascii?Q?+8SB3WSFf4LsuktEPY+VaWI0iUyczdqZjNZf05ad/syBzdpdwwNhjizrQAap?=
 =?us-ascii?Q?lQHMoQb6ORl+SJesXqMDSLsfkKX1XWpxVLXX7YthgEdKXazpcBe9X2DGpvZS?=
 =?us-ascii?Q?tY33qLsmDH9r7p7PqSqmpzIVKIaM+/xMqpjE/9wq53x+gmrzL6UIoindgwW9?=
 =?us-ascii?Q?AIQPRHfTmqmS6aWfW2MwuWiky1hXyfacGzzOK8ptBTkIjaIYZiZt5UETqJjE?=
 =?us-ascii?Q?KYwuENGzZFJXIjgGUX9eOqd9i8UBX/vZCh3FO/Y0JWZln0hSr4w0/vAK5kkQ?=
 =?us-ascii?Q?hv7K7sCyNRHEd181FRdojd+Ht42/X+RHY1CLG9D6WL6NbtPTfJZeXMRN/U5j?=
 =?us-ascii?Q?PWPF1sGVT+VNby43+cprvHYDx4g8wdTonxZAsQ448rElrBQgunWfqoGfIprr?=
 =?us-ascii?Q?EUlsQJDH7JMM14r3UXwfwmDnvzyqk9Ot+bbaPxCeNm+c+0Umf/rto3WV09pn?=
 =?us-ascii?Q?XNcLPLpXcz2C0cbWsC/S8WPk5gsOdKVMT3I/dGKCgB81s9lMFu83d7o1UwtJ?=
 =?us-ascii?Q?D9CXbdUxLOG5lkCRJjDu8aDh8ZSphjVLeQDnDw0aOxhGBSo7SiRgUmXydUni?=
 =?us-ascii?Q?5JL4aqpizyOYxeno5eymOTntDkG7sU8tR/DyNPZJC6bo/EpwFVbQj2U+blg3?=
 =?us-ascii?Q?iT1qL89l8st2L+P1p4eDZfYbM+jbpqmo5ifkR+ZPWypBZCLjrk7AW2bmfbqd?=
 =?us-ascii?Q?f357sgtiuVLpPG54c5IazlpB1gysybJpSOEz8LvlRDFl5W5pGXo+JiHFClWM?=
 =?us-ascii?Q?5HozqJ9kWn4YXbt/DS68XaSSCMyEJeUk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sg8RYU+zIUx1sKeRbDtfLt5DFlq+b67RZoCsHT3/bO6Di8HfZiDaQjbAzZ6y?=
 =?us-ascii?Q?lHH0oRZtIyV/QQfBnAhtzlh9+nMzMAPT0+jo2q4Nm83HWwYvKoD9JBAWrkFv?=
 =?us-ascii?Q?3GINCFDXXIdKFZlVylTMSrmpCVzP6/68ahBSpdLZOcAaSQ/IINDRL2zgiGk9?=
 =?us-ascii?Q?NjFX26JAFnqQsoGOhfD//CHU1fxeB3lf7PHi9CWnJgSo0gAwNPudRa0qWtFG?=
 =?us-ascii?Q?ocsu5eizk6J7HuIohZC8hn0NJYnpy44YlGFtlm2A67T250txEzVon26899FC?=
 =?us-ascii?Q?ZHWyWGWS9/aAVCXEA7+z4OjvSPQ6gttle1LBfpE1jFo1SdZV2nNic65rhIxM?=
 =?us-ascii?Q?rhldylPUO74X84+uxeNXkDe1x6/x+wOrlrFwAyIbbpbDMWoYgY8V2XQr5kEL?=
 =?us-ascii?Q?XQE8dAwxM3gecmcm/zFbbrSe7lEDBY11PXWvKSdjhD/4ICqYEQVL4si6ne6z?=
 =?us-ascii?Q?I0QjcXSVVvPhthjRYVU5UwdCFIQFQ+1frjUjpryh0NKQvCJftKqAWqePx+/b?=
 =?us-ascii?Q?4ltWv8z+rThPGNu5aWgXUUKBjWLP+CgsmIpRH0IwzXYrgwJqmBIAvsYKgOyE?=
 =?us-ascii?Q?cWX9i2OOEcew6inY9RmguMLtSmywJghH+IvlRqwLco4jCXTiQRGe59DAASqE?=
 =?us-ascii?Q?2NyoeFHDv/ZyIX5xdqLe2rwIZeFFd7yW5Sa70vLwFTB1r909pf6SiUZLeaA6?=
 =?us-ascii?Q?znMEsng5rWVF9xYzd3/Z+i1N/T4OdnWzevVVXVipf1Qmm4FhqVHiU+4zFREL?=
 =?us-ascii?Q?clC8mUs8C7Cmr0CErmT6mDqMYrC6aGTizUoGnjSnSidYQYRYXePQFjc3mh1q?=
 =?us-ascii?Q?G/9IRrSOp4pNIc5weN2Ja0Hk+weDdAMXhYJ7AFNNThh9uI33eYvNL9VHyu1O?=
 =?us-ascii?Q?hMyCDSiFjRcUDW3tfzI1wcy5K+6xITnG0ALtsoUt5lSg6TSRtQnCdaRCJuZu?=
 =?us-ascii?Q?khbkogSiIeoronDeykxQ4Dxea4Ap/wh/wA7gkc+3O+NxSrpckahdVS82iisz?=
 =?us-ascii?Q?KHNHDF8P7nrWMbL20wGTLHt+Aag2aXaTJo8iIodNkwM8aY/OmW6fAyzykwVm?=
 =?us-ascii?Q?WEKYxPN3a2loJ8CglaJ459y209HppOb1q270eCkUT4VQ4uRgwdZcWzyFECJu?=
 =?us-ascii?Q?RqxdMrpiBTFoUUt3y0G3q+2Y8rvj6h+w7QvfhtFl5HfcPMzHRh/iZYMMBOTl?=
 =?us-ascii?Q?/GxchmXBf95yF8MQO+uMQEZVCV0IxuVzYLemBraNXcJz/gGOTnk6OrMG3qlR?=
 =?us-ascii?Q?9FGlin7jD03iB23uvij9GlZgYj9bMiclPlV4RlyX3mCmlLobxjcmPjoWvSdm?=
 =?us-ascii?Q?5sohoqIt79WlWgFNDZgZtT/Y36q53nUODAIRQUNadfUqyKsV25td/gGw+dOm?=
 =?us-ascii?Q?Pp12Zsww84yst3x8qqioppSrkWoRrW8bAvBAxE1HDNwxrvVXnNsHHMhQKzMr?=
 =?us-ascii?Q?btvyHOWm5MgUPe5ejHaXUt8OYrY6cLinb/iny6O7iWFRgzf+TW1G7N4yKEte?=
 =?us-ascii?Q?5xCnxEMYjm3iwQb7ef7pYxxYfZKxQhc1DLDMDj/UrB3jTZmhxfEgvPS+barJ?=
 =?us-ascii?Q?u19Bv9dFtxr8uWxeTlpr7/64W8HzUFJ852G6PVnWvMFh/Qo/HrrEf5+0D4/H?=
 =?us-ascii?Q?c/F0XN+8CQJQpv8v0ifxV18=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff39b17-ef7d-4899-22dc-08de26d57ec2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:05:53.0936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC/xSACRnc5XsS3Gtx5Ea0loq/+YkONG0MAlefVTcutPz8XSolvHDot2fOM04dIR8oD4Xa3Ol3mfSICj41fRrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

Prepare a single regmap covering the entire SPI address space of the
SJA1105 and SJA1110 switches which can be given to MDIO buses, XPCS,
irqchip drivers etc.

This regmap is zero-based, can access the entire switch address space,
and child devices are supposed to access their respective memory region
with the help of struct resource (IORESOURCE_REG, to be precise).

Nothing is currently done with the regmap, it is just allocated and
added to the device's devres list, so it doesn't need to be freed.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105.h      |  4 ++
 drivers/net/dsa/sja1105/sja1105_main.c |  6 +++
 drivers/net/dsa/sja1105/sja1105_spi.c  | 58 ++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index dceb96ae9c83..e952917b67b6 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -11,6 +11,8 @@
 #include <linux/dsa/8021q.h>
 #include <net/dsa.h>
 #include <linux/mutex.h>
+#include <linux/regmap.h>
+
 #include "sja1105_static_config.h"
 
 #define SJA1105ET_FDB_BIN_SIZE		4
@@ -273,6 +275,7 @@ struct sja1105_private {
 	u8 ts_id;
 	/* Serializes access to the dynamic config interface */
 	struct mutex dynamic_config_lock;
+	struct regmap *regmap;
 	struct devlink_region **regions;
 	struct sja1105_cbs_entry *cbs;
 	struct mii_bus *mdio_base_t1;
@@ -338,6 +341,7 @@ int static_config_buf_prepare_for_upload(struct sja1105_private *priv,
 int sja1105_static_config_upload(struct sja1105_private *priv);
 int sja1105_inhibit_tx(const struct sja1105_private *priv,
 		       unsigned long port_bitmap, bool tx_inhibited);
+int sja1105_create_regmap(struct sja1105_private *priv);
 
 extern const struct sja1105_info sja1105e_info;
 extern const struct sja1105_info sja1105t_info;
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 9f62cc7e1bd1..622264c13fdb 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3318,6 +3318,12 @@ static int sja1105_probe(struct spi_device *spi)
 
 	priv->info = of_device_get_match_data(dev);
 
+	rc = sja1105_create_regmap(priv);
+	if (rc < 0) {
+		dev_err(dev, "Failed to create regmap: %pe\n", ERR_PTR(rc));
+		return rc;
+	}
+
 	/* Detect hardware device */
 	rc = sja1105_check_device_id(priv);
 	if (rc < 0) {
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index 834b5c1b4db0..cfc76af8a65b 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -408,6 +408,64 @@ int sja1105_static_config_upload(struct sja1105_private *priv)
 	return rc;
 }
 
+static int sja1105_regmap_bus_reg_read(void *ctx, unsigned int reg,
+				       unsigned int *val)
+{
+	struct sja1105_private *priv = ctx;
+	u32 tmp;
+	int rc;
+
+	rc = sja1105_xfer_u32(priv, SPI_READ, SJA1110_SPI_ADDR(reg), &tmp,
+			      NULL);
+	if (rc)
+		return rc;
+
+	*val = tmp;
+
+	return 0;
+}
+
+static int sja1105_regmap_bus_reg_write(void *ctx, unsigned int reg,
+					unsigned int val)
+{
+	struct sja1105_private *priv = ctx;
+	u32 tmp = val;
+
+	return sja1105_xfer_u32(priv, SPI_WRITE, SJA1110_SPI_ADDR(reg), &tmp,
+				NULL);
+}
+
+static struct regmap_bus sja1105_regmap_bus = {
+	.reg_read = sja1105_regmap_bus_reg_read,
+	.reg_write = sja1105_regmap_bus_reg_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
+};
+
+/* The primary purpose of this is to pass it to child devices,
+ * not to abstract SPI access for the main driver.
+ */
+int sja1105_create_regmap(struct sja1105_private *priv)
+{
+	struct device *dev = &priv->spidev->dev;
+	struct regmap_config regmap_config = {
+		.name = "switch",
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+	};
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init(dev, &sja1105_regmap_bus, priv,
+				  &regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	priv->regmap = regmap;
+
+	return 0;
+}
+
 static const struct sja1105_regs sja1105et_regs = {
 	.device_id = 0x0,
 	.prod_id = 0x100BC3,
-- 
2.34.1


