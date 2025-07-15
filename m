Return-Path: <netdev+bounces-207090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4911CB059C9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA4274076E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26D22DE6E4;
	Tue, 15 Jul 2025 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DDbnvt3q"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012050.outbound.protection.outlook.com [40.107.75.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196AE230BC8;
	Tue, 15 Jul 2025 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581869; cv=fail; b=H/BXYBz6zTlEXrgIoXlSBXh40K0byMtNYfPjfrPgDDz3itagpsZpvfCJHmeIwlphDJGo+m0lV87AWxROAPwuoW6qdk7HWx+iklBuRAdvcgn10PFdgPEI2AesIOWUwY/6uDy67O513Wx5+yAQ/kqk06oEiELDZHYns9zQkNvfjjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581869; c=relaxed/simple;
	bh=uWCYp00kqkPIL2OhSzrl1x+MQmWQLv3amJ7F/i16mSU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RlzMCntibXuuj6huyLg7lrMbiM1mG90i1YJeXB87UOnNDbwCKs97nzAx0I6HlRR7Wt4yVDEivmIOLl0dggwOnsXw+wiw959xEiQMH4cZVY2HqY9WWjUcF1wYUWhMOiR3Y6kA/FpN3mBmiXLT1PCWplHCN0smLa3NjfMG+ED/TC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DDbnvt3q; arc=fail smtp.client-ip=40.107.75.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzwOTnl0aoV2+hoJ6t7GqUpHQ0UMnbeNc6d7+LYxJjYZ8YXhjja/AOfE39YTM+hZQEZ4DoXxh3g1JJhbbJLu4ZL07ufdDMsZcWmIrilD5fb1u7cUeZthVU9C8Bp46VQMVu3lAbkrVde5pWhZsWsErdJSYdXDeSdiITAesHwsE5Rkjcj+eIVeiJFBpqKQfG2Cc034qFyeRKfvsIgdeOPd2zQGjNCRDXX2Q4++4zbT5wRO3Raw/5iQHC9dI7u3kLwVOsk3aFuhT0gojn8cluQyIbxsmVVmJF87ewBLpQdHiY6qsx+NGP49ESKEcacqEjd+u9EBd47L7kvHBtrrazkq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75/ZZI17eCJmeascglv2wdbld7FMsi05h5Fi3PdpV90=;
 b=n76roQUVcpOBncbvLOUXNjI+wJSroqBQrxOSxgW9Hg5GKwSyygMKITydwse70jC9GLz8LwOGyRN+pf6+sFVz/qupjosvx6KjdWbFVxfWnCrmr34iKoT5UD1a0+aFNbh6pzEM71SMIpdjOtOpkl9+LXMJtLpmPVEvSpLZ01ph6u6X8HBV43QjYQ6ledS8t3tPPNDwHZaK1p8p+3yBSCZOgruXXhwxegTRbjVYoGu+RZp9dip0PvMs2EXnfW94m8Gz+aZj1dXFj69xOcNdQyszEvup/9PTRBo8q7Axd7gZhUV0MV6HZr99ZRRk++V7Uc7CF5CvMq5l/EkBp1l3eWTjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75/ZZI17eCJmeascglv2wdbld7FMsi05h5Fi3PdpV90=;
 b=DDbnvt3qpgW2hQDAjFihRVqA+UsOOYuY7pVBmTo2w3Ogw7hBB2j3sivzXYtbVeVcD5NfIaEjR67oElGD495t+5bzkTDUJmFYAO1l9iH73APzA4T4c+uJTaoSk/TTVs1L/kWuQ9l9ZH2NEwR4zUO9ESVhxUYCzByVP0M+EpLml2ap8ki8V6H+rpUKGtsRu30QCy28x4cBJMi1YUmUatcgnyQHNMQAZEYSvZE2ZJSmikaXnzjen9R4xfoxEAvF5SDwPkmX47z8UpE+5EbxSnIWo+FrZ4mcQQMt4ZaQ9arTRdXQuf49KDo+sX8gdr1linbDW09isGPRLfNv6d8bZ8CREQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5428.apcprd06.prod.outlook.com (2603:1096:400:219::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 12:17:45 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Tue, 15 Jul 2025
 12:17:45 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Lucas Sanchez Sagrado <lucsansag@gmail.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Hayes Wang <hayeswang@realtek.com>,
	Eric Biggers <ebiggers@google.com>,
	Philipp Hahn <phahn-oss@avm.de>,
	linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/7] net: usb: Use min() to improve code
Date: Tue, 15 Jul 2025 20:16:47 +0800
Message-Id: <20250715121721.266713-2-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715121721.266713-1-rongqianfeng@vivo.com>
References: <20250715121721.266713-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b17428-b040-4fd6-559b-08ddc3999aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNUB8PAqkQgpLzMHSyktX63IjwD7wAmqksd+ppLXocybwdtTZP+pxwx6ELeB?=
 =?us-ascii?Q?kHTjU8I+5hDE/jYpmTpO55mfe0qMyM/zzG8GkXMFFfZAK4AzBPpcaNWfT5dl?=
 =?us-ascii?Q?9YPMuO1ui7o2JxO/2ALTSMGqMClO36AD+l5Rbw6MVfG+Pj6dGAwdY2lBBqxo?=
 =?us-ascii?Q?Pg0NV3slwvrMHQGEE8Bfa3qyazraIDJ+Cwb0LYNVPMlF4ZROSSLTW029xdtc?=
 =?us-ascii?Q?AZBHOcc7E2/EgUZSMw5kK93Q63sm97/JZcy16ob9Gv2Q54I/Oe58OmzCaNTq?=
 =?us-ascii?Q?FU8GZa0Mn85rbYZrqTxI3DJVDCeEjekNKmTA1o42HTXYkI2QcPx0Wi1Ee8pp?=
 =?us-ascii?Q?hPBbY2B+3JpWWlyuQVxUaffogbXKme99VpNXkd6BL5rvj+NDMWGth0s6go5R?=
 =?us-ascii?Q?/aJtRtaoB0ZfSh/Iy+oRBGGqAsFAxvMr1pP48HtpD5po9pFIBn8rJoUJLpP3?=
 =?us-ascii?Q?pkAQQQi3t0FAAcXlD0L3oVeCiM2TgD6OP/A7WHimw38f2LM2XVB6iPtKODRL?=
 =?us-ascii?Q?s3gw7KSD1KojsFXjLb+QricpAz0sq08yk+55B8yewZE9/lLmecyQM7P/VhAd?=
 =?us-ascii?Q?Z1g/BJAAIthWw6uzDxWBeuA6rCDI11DHvWg4kYl+wFmxqpd6o5B7UhvmaUAb?=
 =?us-ascii?Q?QgexsJk+oZ0FL8Q8P2XLuG247Qt1rjDxd8Th995C4NUflLsDteP3lgHpnJOm?=
 =?us-ascii?Q?uzXVeJ6UzTKSNRoAIBrWcpJQ5BaBt+UOC3wbTh4rxBRQefdO6JWXTP1DNmlr?=
 =?us-ascii?Q?GG1B3eXkab663Cmu9u4I/FMp5GcAx62M7Z+jveTyQwZPMMHQaF9H2lNSBiCc?=
 =?us-ascii?Q?1AEKzIRBmQvDmZQTPOP87VjwUDNJCuzkToN1GqH54VCtuXMQF3qa6dlX6mWK?=
 =?us-ascii?Q?wkoTxsfZTY+z7wXgULclaLKbOqYDJY/vkGa0PMivRBPQmFHWLLVMivCESH5J?=
 =?us-ascii?Q?+OfcE/CCyd5QCpn02xngLAijCo5EgelumhtQKbd5Qe4vmCS+vtZkd0aFGOzH?=
 =?us-ascii?Q?RxdWhI0FfX1qkCMUIZ3noHfv5EIkD21qrd0iFwmk2ojDyYgNGVxdLdRhU+F0?=
 =?us-ascii?Q?Bh05eRnw2JsNC28RgCSRGDC+Ky9UCX2BXBPi9vcAF4Dkhu0HVQMXBAC977x5?=
 =?us-ascii?Q?n4ozoGaoq783mZtodlsj3mS57RtzMXHcQvNVXf+6PnQHelCEIE1XVdAU4Q75?=
 =?us-ascii?Q?ZYItPnUH8HsI+CiOljWNM0M8IJN4i7R/CfoDcexqMxT+Mnpr4mnswdp4jI0A?=
 =?us-ascii?Q?5l7ZjJXQ0r2q2SvRFlxxEkdsWtrmhgrOPaSgCKP7j3THdZTaVx4Ht+nQJhc6?=
 =?us-ascii?Q?3P8JV13gEHjnAeaFw/xo5BmGKW04BYoNb2k91vUZnCyAkmZz70m3n66M2F8E?=
 =?us-ascii?Q?H62hGUiJfTrjmHBBZfxJGOr+e+sMZWZbz3xPzYEHola1N1nXemM+9vBXHWY0?=
 =?us-ascii?Q?h6KdyesI1da9d/spZcKZPmFoI9PLdV56cZNFGhfv9RHlBRRmYMl8pz0MjSwJ?=
 =?us-ascii?Q?l4mC+AcBw3t9dt8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6CQ2yE0caDBWiDdCQOsGeTvIhRAwcbsUni9DI09c3ONTQvIZKxRezmhVfwoN?=
 =?us-ascii?Q?8eZM6DRP1iXewzhjO9B6rNjmr21tk8jNBu9j/D/4Jg15d2GTw6bUrc0y8FZS?=
 =?us-ascii?Q?SJzS+oUvW+Q1X3f+hu0u7FH/CgjB18wBQMfY8PE5g9C3wFwozWSAgkO7Yu0k?=
 =?us-ascii?Q?R/xtAIX68eznF6gLXPVZTc1CRxtUBu1MDcrpMJLIsGeQznG15W0/U0TIAQX/?=
 =?us-ascii?Q?0Xpq7jGu0r07zWAGDdAe3eRFo2LfvixJSopqc159FXqQykGEs8V+nIcsbsRp?=
 =?us-ascii?Q?y+4h8uY2hD2XgMKUm2gHCcAWB0EjfiwXsE+1LdsgYYLriVLeScijmD8O6BLJ?=
 =?us-ascii?Q?7cb5Fxl9lpeuExafG5u1pfdjZ/WmlId0hBu5iJQ4Qql98c+tx1nUOi8gmpLg?=
 =?us-ascii?Q?I2yUPbMDtuVy9R+i1v7YgIOqJ0TPazxJbuWmdzK0TFi7kdssOkfDagE8uDi0?=
 =?us-ascii?Q?11/PcXuwVrabK9/aXIJd8gJP/Wij1FUmndJ2bzauOIypIN7qT0raN9/P8cEj?=
 =?us-ascii?Q?f3q9KrHRObObxCHAsg8VYt8E+VIHb8nwatxEbgG8RARba7OiK+DtvLgzdmq5?=
 =?us-ascii?Q?R0/VP6CTi5/FWt1aja6iHhJ3qOgAT5SmwVTdItznO4dc2d8Wz/nLyHVmPEpM?=
 =?us-ascii?Q?FYj+gwggcW9bMQzRqk6a+12idF0C5PkN7u1k+1JSh4YfNmCDqqapLBOi0xhy?=
 =?us-ascii?Q?hkwGI2lIH9Mn4wT0uyHMycNRCiAQKu4DBjz25rdbfxDFnf7qGIgoaG4iLl87?=
 =?us-ascii?Q?Z8W+6wPAHfzYl8VD8EJags4ZHXKufO//1DLYoGk5WahEUj3q8sdfyaSTcDNF?=
 =?us-ascii?Q?EUNuVTY5UdRsKZH2aiI9JmnmNWcYURqD8JHjPqGov3vIJNA87vALUzGg1ra6?=
 =?us-ascii?Q?jihVuOxH7p4un/t7A4oP0ETR6LFaaLN9nU7wXZTh+abC5ifGv/0yL3BXkjaO?=
 =?us-ascii?Q?8h6kI72s5/bzND5eU3d0U0jZ8MjUBbsh0C2XHhXiSN02uKWkwZ2fhGb+wXZO?=
 =?us-ascii?Q?qbD4j3FQclSCT6SPxDF3LDupmP3trUYVY5RuDBbtL/3r/VvfYpY/BkfKIeCV?=
 =?us-ascii?Q?M7T700HqgAHFUAlbQZKUvq8/d0rXz1iOpbW5nLiqrbNowIwzCwpfuVMG1/27?=
 =?us-ascii?Q?ISL53RPutZqFfrANRV9WJ1BINWxtnEWxNlPDG6KP96IafulTgpTFuxzMTu7T?=
 =?us-ascii?Q?WQPFIqLuc89TvDutLJbKasmHMgP6YgqKoEI3TU7K/Vmxbwq98IquXMezIsy8?=
 =?us-ascii?Q?anAPh5MJIi0o7F3aR2JcIXULSzRt68GUVUhObW5QsYrUIS+D67zOGTQs1s4e?=
 =?us-ascii?Q?f+qcXZFhI+cLQTzVQo4uFLMWVSnMBnYMyzx6ZDM77KLevWMderdY5ykZSF8n?=
 =?us-ascii?Q?Oz0OJO9is5NXelvGo2mcuobhL8/X2EHlXfvoPK14InpD//yFLh2rHcq6Mr10?=
 =?us-ascii?Q?TQs4BIma1UPSVIY0Scm3kZFmHGqeIAipnrlKGq5M+ibfyqtxF1qJ+D9w1Mow?=
 =?us-ascii?Q?ZFJwhDOW2jyQp8AqjnxDH6YbYxMb7AJqIDESN67DLjNX7IuUTDpEkRh/Kuhj?=
 =?us-ascii?Q?LGisdbi1oYL5h8zoYkDaP61mS3MNdG3i1el1gaL8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b17428-b040-4fd6-559b-08ddc3999aef
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:17:45.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isPSQ1ALla05F1vVOhOFjdvdX4EBNlDVmA5zNKS/h/56HnpVVw6MpvKr4wJstoxrOCeRcrWbIz2QKN2ieKB1Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5428

Use min() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/usb/r8152.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 44cba7acfe7d..c81a43da914a 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4949,10 +4949,7 @@ static void rtl_ram_code_speed_up(struct r8152 *tp, struct fw_phy_speed_up *phy,
 		u32 ocp_data, size;
 		int i;
 
-		if (len < 2048)
-			size = len;
-		else
-			size = 2048;
+		size = min(len, 2048);
 
 		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL);
 		ocp_data |= GPHY_PATCH_DONE | BACKUP_RESTRORE;
-- 
2.34.1


