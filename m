Return-Path: <netdev+bounces-99472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91978D4FE8
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6339B23779
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C02374C2;
	Thu, 30 May 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bFNkcuFj"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7D3A8D8
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086845; cv=fail; b=XqdBLvwbXGAtHJuFkFs4X2hhif1++MoKlhT0vP9oULVUNg6FPtUiVJa2voCKS8KEbeQNwbXMhMjQUWl8XNFfT9b+ABe/dbwd3X081Qu1IC91VWHQ+NpjzR4cAxtnp0RBXIzfXrGGIral0HiQbJyIvz6QugxoqeoDRRW3rdiFED4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086845; c=relaxed/simple;
	bh=qfW+ye0G3DBgN9LNDQfQCGI2a9v1Xj8X254HCQ7sglQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZ0xEenqtLsai/VzQaPeZj+VJ7y9gRM8GGPfHjuxtkrcowd3fj5W4NKYkaL1zz+VF5R1TPfqaYrqPsMaXtcxqyBRTZiaunY3w4rmHPRrvyF1C1JRPOpwwpMsvY3zgRZHMES06+svKpTtgsKFjr+xN+it5m9lHMgotWUwdykN/Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bFNkcuFj; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H51iMOJPqu2h4FPE/EDG7NQNveT5R11SKllDFiIwceGzxyqqWjORShnWicxqkQWHMIuxsXeiGqyFVWZBctCqRM6evz1e795qT8RUD8kJRfwnUJhQbrZCxdJpNmBmsiqqw8swA0BX+EpyijHBXESmUD6uHwxn0JAK2/4sTgs8ftHzLriEG5WTCupim4pGtfRX0+TKxX1NJ8Os/ZIPL3lFpfoR++CNdJz++9vTeXI8vKfKEiz2Pve14pkz/hCJJQWCy5K47ohsrzeJGeuLWj1zeKY/3cAt95v1AiAZUK7YgRknJEHGtNWHkAxPjQqdsPU+idxj8/gjGi4tRRLZfZy4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC69P7+DJXL0P8flyTJ3LbXGPnwGwgBf0GHiUTClNI8=;
 b=byIohTeYogyoorABHrH8lxfPOxV0/eW/d6zwQZxY/iMLKI071QZaeIwTFs10xSJw9fj66LF0xRpct5TFpxWMEQ6K9l62Laa++Dddzz5kDDkIFu4DAlVM1LcLJEYZ7Pe1WVIYawreVZnWHGnK4A8LLW96Qbjk6ah2bbDRDnuJxIqGzUxifr3fuWXc3ES/0bH6TSUADOdsFvKI4oP/P5GsrFA9AQz92kvG5wU9RFf9/NMHWK9W952l74szd8bdnrAgSlrTLAT6IIWTzVaVTqzMmwkXNDIVstw4WmIccLu8tLMQoV/r/kRamHO8bitc3NDiw9bHEf5pqPTN5JtSAa9OvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC69P7+DJXL0P8flyTJ3LbXGPnwGwgBf0GHiUTClNI8=;
 b=bFNkcuFjsLmCZbHKbHBfCr/pyVX2ioywM1H861oN5nHfXoSWZd6x037WsZeSyyIYzT+eP/S3SZwLX5fkiOGe9qitL57ftnubFgivE0AS+3CmFF/Fr/O0kT0EOzYPyUXb4CCYHSbgmRQw6vWo/lYM7Z6dpuHzEFhLkJe5kepipsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Thu, 30 May 2024 16:33:56 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 16:33:56 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next 6/8] net: dsa: ocelot: use ds->num_tx_queues = OCELOT_NUM_TC for all models
Date: Thu, 30 May 2024 19:33:31 +0300
Message-Id: <20240530163333.2458884-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::20) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: 81efcce2-0edd-457a-6c07-08dc80c64ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+nklsUrDctqGpeir4MzqSMLfOtLiuG7CUqZvv6a5J+DhO+1y31PLO6Wdez6?=
 =?us-ascii?Q?WCZlcueiaLhLyuq5Ad/qF4XFlqaF+6b7R6V27FZulOeTD+JNPUF1erSfMURD?=
 =?us-ascii?Q?2DlMAZ6lFuHBRXOn01w0b80LwQmSMRXjTyM8WgX3DxI+3GqSoHztB2ardH3B?=
 =?us-ascii?Q?M3CoFNlTBSJvbC/yci3tmn4tqowim8TVGyrzfyzs/z9IFVHtRpK+sraxopW1?=
 =?us-ascii?Q?zUFClURXP+t1oolLanHhLzAzj7D3/jOeR5FllaB9XuHxQvYxPBX2Hd2U0SGi?=
 =?us-ascii?Q?gL3gtBc3lOLUBT3QzQaNVQYZ5YB+e4jXJbQF1C7r0QJ3d8zcXRtqhUACWaG8?=
 =?us-ascii?Q?CznXkCe56h/mgXPouhdaJOx/k/Okus8cIUZYpw3FtE9t0MKV4pzbSu18qCO7?=
 =?us-ascii?Q?s0w/0faYd8jEkWmnaxK2nfIupzEuFJmRJSKsAoguvPKq6wms8Xiklp4hGyVX?=
 =?us-ascii?Q?drwXinKgsqAN/Im5XridDwuffbG/2pramCM1ulevW/YFX4TGXYm3hl1i+b8y?=
 =?us-ascii?Q?DJM9Tdq47qO9ddnDhw4nWI0tmaWZDX5sPWSbCt0n+u3X362dIf7JoT+qAuBG?=
 =?us-ascii?Q?k3XSlXBB6Mw64d2fAiPC9zeRvSV61uoarnhTBp7Hi+quCM4htatv7dvwMe/Z?=
 =?us-ascii?Q?R5fnVmOjVLIoc7MZeL0Io0Qq/N3VJxJVLe0f0WB05KteUoGc64rFjpY4z65o?=
 =?us-ascii?Q?FkAM6MTnoK0KvoY0A/9BzY7MgUD+OgDdMAWNKNG/CO9sNMuOrEgEm4c7ZwHl?=
 =?us-ascii?Q?8hlhVTDs9Yl6JR5JycsJwmyVvuPcjU3Gyei83qfTkaNnn5x0ap6qs0eILQck?=
 =?us-ascii?Q?MgOx79B615lFI6/084k5lZCe8EujxVyBTNdbZ7lW2DaYDtjHzLdVdqUYqkfo?=
 =?us-ascii?Q?tpzDHdUPbpzw0DMDQR+9UFwjeJYalJur5LtlmGRo4v3dAUzyTPeuj+MDcETT?=
 =?us-ascii?Q?soIWAy0ZJBgxCBWx69/YGfPxrCKorHzj/3EfO6c3U8jH/jAYsn35Y5rGYh99?=
 =?us-ascii?Q?L+JRVR9o1aNiT5jhofQhvN0hgZn/ex9dKcg3JRtTk5/iC0yAOmCPtn+fg7ev?=
 =?us-ascii?Q?I4BGOdBclDBxNpfw0F137bUP92lSE/NNkoigMI8cC0yOu6OhNJguvknqGGux?=
 =?us-ascii?Q?g/ThatAnbEMsmvB8iC+41+zJrQSRFDt2N5oDPGzbXJxxCsaKcq45KwayFWAg?=
 =?us-ascii?Q?vKMwZXRU0pXZGgFMObde0ER95rq8xuXx9tLctfJym9NIj3teTZJ2PAB4hPUL?=
 =?us-ascii?Q?tFV0oBysLVcma73hsHbVKTtqrcEXDxAoMy6/4RLQHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LbIyDc7zlLhsTY5AxEPVx83B3d5kZiS85EJcy/i2ms4vc7lIQHSlEASKO1F+?=
 =?us-ascii?Q?aHd/da72AKaoGpd9Csab8h7MBjYnTZNV8MIE5TwBAKGm/1Le6AgIZzWmnBpY?=
 =?us-ascii?Q?Ffu1sUuCBP/fBtUzUn1kdaxHRRAyV6/i1zQHgzWqgQWR87/agjFj/e6Sz/BV?=
 =?us-ascii?Q?EE/Vj/KmUtvnoiKyuvNI/A7sQFBIKxGPh99dTQH9M7vnTIP4QmueXlqsM1G8?=
 =?us-ascii?Q?pQE97/EqXDh7W1JCM5EdH3CY5ONS5kKT7kZdaMDTVq1+jJff3nivqmNptVUT?=
 =?us-ascii?Q?06h+7xVZNlm/zZT0Gwk7bxLmw4KHW/mUWMsIWqrWcj9j9NPljbqftrvLZpfH?=
 =?us-ascii?Q?OPGDUyj6eHuX1zQq/kqsPARrsmkE6outjhAMuf2sN5xs+PzPVHba8kn65RBB?=
 =?us-ascii?Q?hqweGKP6y7x1p2zyF9boOnuu3AnDW/TKVw1nVwLMM26MiLl9ueXmr4rkooIh?=
 =?us-ascii?Q?n1Dd04RMy7YO1FY4Z21WEjdZ3idKS/077UJuDa7LOxvb9U3o/2F8Qy7QUCVn?=
 =?us-ascii?Q?6963PemP148Z+8mfJaRbj+5hJbuLJrbSrj+iirPsSBtHuZtm8bntesPg7Ez+?=
 =?us-ascii?Q?wYwf0MW4ZWBIXUBH0f/yeOCmQHJBTKKON8QX16xU8jri46OyaKcOifN+vLXH?=
 =?us-ascii?Q?PVahZ8KWbXCcVRUjyVnUDOQ8e9MU4LgnvWTtVTwBIymFawGs3DmwK6YVISHp?=
 =?us-ascii?Q?T/Pp4QxuITufmfSICikEv5zi9vEtmVZXMYlBlPSjDB9NaTfs+btNOyckRUIo?=
 =?us-ascii?Q?HyjPcXTtO0ymSB3j9v5y98dhH/rpjvFUrSZmGZhM/f8ilL18vL+mOvSaoQqk?=
 =?us-ascii?Q?F6tUpBWkX/EPz5shpGTEaV9hHLhS6ZLzKi9MbzRa5R9269CmyF50jSy4pPut?=
 =?us-ascii?Q?A54niBZrb4zeHAOl4OnQZ3/SSHC4FqqNiadTyVMa6r31T43my6+/jp7obz6R?=
 =?us-ascii?Q?15ZBZnc9jIVGAaOvjngwdg3ugx5cExaJQHdNSCaa4TIQfBk93Ltxp0Ef88Xo?=
 =?us-ascii?Q?zUenR7belF7BzYLGcBbOvtrfnjHap7Yj8iriKrL57YfUJ9SA/VqjToforQ6e?=
 =?us-ascii?Q?ERMW1hUeGR9Nc35UbupoulOOCJhTrzs5c93k6SQ+HU6lKhSC4fXeGaeYTKjQ?=
 =?us-ascii?Q?yroigame2Yrpt7YBPyyPKJnQ0CKVgYWogQijgVnUd1Hhn4K0oncfMBElhano?=
 =?us-ascii?Q?V8P6CJAPY+eoJ/hhWJRSuNzFMJcljGFIHcjuSMjZ2fox/Cy+sTyXiaOY88RJ?=
 =?us-ascii?Q?qsoukIK3+EFU08n3Djtd0NpgT8slVCiCA1gtgXlyRfFgelAzN8F+IS90KAcs?=
 =?us-ascii?Q?Q5JCJER4iXfFZ+rUv+a/yFp4nB5OqkVwC2r/xgL/mkzahqrUKfH/l+b45Mi1?=
 =?us-ascii?Q?Bf06+yjYdCWCSssAPfsMfJ63ZQc0UEzRkPfugXL4C0mZ1LS1+kxtZYfPZiEi?=
 =?us-ascii?Q?YhbkYeYLX8COXAPfs/GtobXYw//QThUmQxIMBKCR/O7DZN6bn47v9m9kcnIV?=
 =?us-ascii?Q?0xyyYk1iUap1f2cyc1EjiDlc4RBpUuA9olUgfSP8D6QwVzkzR7wCyb/dRTMN?=
 =?us-ascii?Q?6to4b2j89VF4Rm/DP+53XTGtHJD3mmaROt/oMdseA0DGadib8GoYTBhgcjNT?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81efcce2-0edd-457a-6c07-08dc80c64ce3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:33:56.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJ2eZPncM3HGApiWF9aSSW4Fe9rRw75BvciHhzQdQBF9Uv0M13odnXtTPaNbrx4vCJ2WrwoTaTUeap5+LUFoww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

Russell King points out that seville_vsc9953 populates
felix->info->num_tx_queues = 8, but this doesn't make it all the way
into ds->num_tx_queues (which is how the user interface netdev queues
get allocated) [1].

[1]: https://lore.kernel.org/all/20240415160150.yejcazpjqvn7vhxu@skbuf/

When num_tx_queues=0 for seville, this is implicitly converted to 1 by
dsa_user_create(), and this is good enough for basic operation for a
switch port. The tc qdisc offload layer works with netdev TX queues,
so for QoS offload we need to pretend we have multiple TX queues. The
VSC9953, like ocelot_ext, doesn't export QoS offload, so it doesn't
really matter. But we can definitely set num_tx_queues=8 for all
switches.

The felix->info->num_tx_queues construct itself seems unnecessary.
It was introduced by commit de143c0e274b ("net: dsa: felix: Configure
Time-Aware Scheduler via taprio offload") at a time when vsc9959
(LS1028A) was the only switch supported by the driver.

8 traffic classes, and 1 queue per traffic class, is a common
architectural feature of all switches in the family. So they could
all just set OCELOT_NUM_TC and be fine.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.h           | 1 -
 drivers/net/dsa/ocelot/felix_vsc9959.c   | 4 ++--
 drivers/net/dsa/ocelot/ocelot_ext.c      | 3 +--
 drivers/net/dsa/ocelot/seville_vsc9953.c | 3 ++-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
index e67a25f6f816..e0bfea10ff52 100644
--- a/drivers/net/dsa/ocelot/felix.h
+++ b/drivers/net/dsa/ocelot/felix.h
@@ -32,7 +32,6 @@ struct felix_info {
 	const u32			*port_modes;
 	int				num_mact_rows;
 	int				num_ports;
-	int				num_tx_queues;
 	struct vcap_props		*vcap;
 	u16				vcap_pol_base;
 	u16				vcap_pol_max;
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 20563abd617f..ec8b124e8f61 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -2658,7 +2658,6 @@ static const struct felix_info felix_info_vsc9959 = {
 	.vcap_pol_max2		= 0,
 	.num_mact_rows		= 2048,
 	.num_ports		= VSC9959_NUM_PORTS,
-	.num_tx_queues		= OCELOT_NUM_TC,
 	.quirks			= FELIX_MAC_QUIRKS,
 	.quirk_no_xtr_irq	= true,
 	.ptp_caps		= &vsc9959_ptp_caps,
@@ -2711,7 +2710,8 @@ static int felix_pci_probe(struct pci_dev *pdev,
 
 	ds->dev = dev;
 	ds->num_ports = felix->info->num_ports;
-	ds->num_tx_queues = felix->info->num_tx_queues;
+	ds->num_tx_queues = OCELOT_NUM_TC;
+
 	ds->ops = &felix_switch_ops;
 	ds->phylink_mac_ops = &felix_phylink_mac_ops;
 	ds->priv = ocelot;
diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
index c893f3ee238b..9cd24f77dc49 100644
--- a/drivers/net/dsa/ocelot/ocelot_ext.c
+++ b/drivers/net/dsa/ocelot/ocelot_ext.c
@@ -57,7 +57,6 @@ static const struct felix_info vsc7512_info = {
 	.vcap				= vsc7514_vcap_props,
 	.num_mact_rows			= 1024,
 	.num_ports			= VSC7514_NUM_PORTS,
-	.num_tx_queues			= OCELOT_NUM_TC,
 	.port_modes			= vsc7512_port_modes,
 	.phylink_mac_config		= ocelot_phylink_mac_config,
 	.configure_serdes		= ocelot_port_configure_serdes,
@@ -90,7 +89,7 @@ static int ocelot_ext_probe(struct platform_device *pdev)
 
 	ds->dev = dev;
 	ds->num_ports = felix->info->num_ports;
-	ds->num_tx_queues = felix->info->num_tx_queues;
+	ds->num_tx_queues = OCELOT_NUM_TC;
 
 	ds->ops = &felix_switch_ops;
 	ds->phylink_mac_ops = &felix_phylink_mac_ops;
diff --git a/drivers/net/dsa/ocelot/seville_vsc9953.c b/drivers/net/dsa/ocelot/seville_vsc9953.c
index e63247d3dfdb..83bd0e1ee692 100644
--- a/drivers/net/dsa/ocelot/seville_vsc9953.c
+++ b/drivers/net/dsa/ocelot/seville_vsc9953.c
@@ -963,7 +963,6 @@ static const struct felix_info seville_info_vsc9953 = {
 	.quirks			= FELIX_MAC_QUIRKS,
 	.num_mact_rows		= 2048,
 	.num_ports		= VSC9953_NUM_PORTS,
-	.num_tx_queues		= OCELOT_NUM_TC,
 	.mdio_bus_alloc		= vsc9953_mdio_bus_alloc,
 	.mdio_bus_free		= vsc9953_mdio_bus_free,
 	.port_modes		= vsc9953_port_modes,
@@ -1002,6 +1001,8 @@ static int seville_probe(struct platform_device *pdev)
 
 	ds->dev = dev;
 	ds->num_ports = felix->info->num_ports;
+	ds->num_tx_queues = OCELOT_NUM_TC;
+
 	ds->ops = &felix_switch_ops;
 	ds->phylink_mac_ops = &felix_phylink_mac_ops;
 	ds->priv = ocelot;
-- 
2.34.1


