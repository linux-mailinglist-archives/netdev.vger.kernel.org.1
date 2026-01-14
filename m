Return-Path: <netdev+bounces-249861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7ADD1FB7F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27ABC30611B4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79DE2BE02A;
	Wed, 14 Jan 2026 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iV+19vzI"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22369397ACB;
	Wed, 14 Jan 2026 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404111; cv=fail; b=G7Y1ZuqRzi8LlciG2UFOMREdqFWvywF0M9gp2Cb7wHII3aUKnXsR/ZuHelBszC8OYjXziWqJVAFPvN7gOz7NlJOaDiA8S7A2fBaIPHV9BXQkamd9jynTlBxDWmhBZhq3hYkVFIKhenPhlpl1KZq/kL4wgvg0SY8zDTb1w1VNh2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404111; c=relaxed/simple;
	bh=ziCNt9EgYlrHmbMbGttT7Kyp/CvXpg9raweDC3ZnArc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rw4WYMtxGmfzSmaWXIeve0sbLH1GQ8pD8ctDOZbb2AqFE0d66b0c6IbS2sV6n8I5SSfjkr/bSBrVIJiQgoZSGSneR1uBQeJ49LlsY7fPt4Jh06rIBL1wi4U+bSnxtSxTzr5ajYmuOg7kbk5HuzTn2y+wV56zbzIhpFrp3cBFNHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iV+19vzI; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Du2VNKTsrtnBDe6rAu5g9S4+vbMRI29hOhYuLAACGWXCpfHdvpHgoYrmy/7W8S3K785xJlyKhhAVUD7bzDzIHnE/pspT/UmBAu7f6hZXO8N0stE9kxMjolHLajt7RfUARZOw/kwvcELkzpypbzStlg3vjBL9HowxlEeoGzz5/f+Zpm1LTXmXF1DHWWsaVv07h3fYg4lIfc7MF2XqNdJ2HtO/uN2wEm4uk8dzp5MMa+p5eIwBoYk51sO8LnXQCli0UN65b9rJDVfrEY8fwmTK8rrEh4moH0V396s9M9W9p2UGq4gTDNASgmXRNfp3llcLz4+vK8D0DIug0KkLCNE3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOHhcVucJAR6CP7FtOkZaJgsLht3DaZGqf4Vu2k/vc8=;
 b=tPeC2weelC/uEO2wfoFEp6Y8M2jhKexYyHB6Kx1+CMogPgI/FktNAYvPH9M6PGHsEWk0tJ1JgNr88Kh0gUzbHqYyO9jW1UcU3emIUWqDt6b6MF7rwGKXCAifmzEg0foOwXriWYkK6BQdYgEticgsy8uRdXXXxcCMJy4tLWhFxZCNRjrmJ4OiF77VJnmKq7uFF1W2owy0xNZqLUZofCXq+5SkDwPyTHAefgZEp3dkJR32JvIUXaiqhvxSEgz2IUoFV1musT9BTxuSz9xfpwhvWnDeY4TrHPGG/llXORdjRJEGG5rMZFC+g3v0vroR0qIj1yc2MfbbFpcrK1Czj1Ou+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOHhcVucJAR6CP7FtOkZaJgsLht3DaZGqf4Vu2k/vc8=;
 b=iV+19vzIWHQ3bYEs+ldT29eoQsMuQRcH320f7XpoWPaG4KngEmtEtYxOpenDgoij+T9XTVolHmFSAmzQ5tB+TSXZy5N17zodeuhGsvO2LqOVbzpzdtQWTaJpfHtPt/0pGzG3XpN7JdE35VkUNGGoTYv0FBOOmWyFRHwREsyDkSSClau4ka7cPqKpb6g9+6OLI8r7MnSEAoWRhKfmJ6vcuhnJfpVKCr5sfdQRMsexgQrViuzm47wkbaJKTR9kzugC0lx4UWDPqBzUfxnoLziW0QLTwgO8iuhZVIJhWtbBSTj9g/yPYrprPh82RGBzo2pF1sTfP0T8XO/Z2ZlozR5R3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:21:25 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 15:21:25 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH phy 4/8] phy: lynx-28g: probe on per-SoC and per-instance compatible strings
Date: Wed, 14 Jan 2026 17:21:07 +0200
Message-Id: <20260114152111.625350-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114152111.625350-1-vladimir.oltean@nxp.com>
References: <20260114152111.625350-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: ca69446c-d066-413c-ebed-08de538094d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ODr/+Osk4jHPQUlZImd5ZKMkKEi+lYTGoyxED2K0/dxXwFyZevTZWifD41ai?=
 =?us-ascii?Q?DHIUXSaMEuWgZTHqNhXJwboJY2VGhGW6Vwp16fiH4zPIyp0ZBqkxspDLIY79?=
 =?us-ascii?Q?ZkbpS2D87gK1suL1WMylZWl6OpUmw/CyJELXE/kyQrP3VgTqq7ME+kS3w40z?=
 =?us-ascii?Q?RbzFVW21Uydgw+YT+yg2+ZUAfr1lzVOS9OlkK/ZCP5PRN9qC1ZhBwJrae7Zl?=
 =?us-ascii?Q?sBQEOBEy2JFQ7MusWBPpVuRJcC4Aa1T/hXy9US94U8dfWqbkT2KNG5P7jMwU?=
 =?us-ascii?Q?qciZj7Dg0VkelwwoHYY3hhcgYnnLBv6FK1Wl5kxO+tw3+sstkGJe1QSGJL5f?=
 =?us-ascii?Q?+eIsSf1aLCpUn83YbS8KKkCghswW8BBj75g8pwrf/nz6w99K90+fT9OyNB0e?=
 =?us-ascii?Q?C2+tHZVYQGrwzrbnxVv/PGS9E40N4djsddTIfcyWTbyJXsA8ZORkILuk3LGz?=
 =?us-ascii?Q?fNlDG94jID4X4bBOXGx/Xr15+7GGffKVzLaOczq6y0wC0oeRjDg629HZuUB8?=
 =?us-ascii?Q?4FXkGtWxJIQqF1gq8oFnlD1dDQxIOk5OJo7fPyHFR23Ab6QnqnJfwGokhHIC?=
 =?us-ascii?Q?nQwgybd5PqlhaXVu1b/+nMU5z467Pvvx6K/pKWXFNS5NZZ2GSWhFP6IEijx3?=
 =?us-ascii?Q?YQ9Q3BxmRz29NIegPXwup5H5Wbh0TYCO4UXjZq0GUoEnuYkDPVBAHPkwIKwN?=
 =?us-ascii?Q?uE0G7Evaqh/j7DQ1c8K49inThbjKBTXWmN9dutXibKtE7lu2PL6it453NFBj?=
 =?us-ascii?Q?q9I36i8/EwDnRuPZ5hioPD+kF7HREqQGs+/06F3Tsd9731Ym2iqXlZxuNZEZ?=
 =?us-ascii?Q?0i3/5M2koSmt37nVFo1zaW4vNc4wSqcbnTrBOE2l6zXGR+mrnUMWBFu+Lfug?=
 =?us-ascii?Q?JFokU1oCsiYiWsI90TnCDzSS5ihuj11UyR0GqITFn3QcN6og3HNkoAkpFnB9?=
 =?us-ascii?Q?IfL/gf/LF82yxSTCgQBDSLV0Orarf0kQg7d6dBuiUJylSfklZ1TaTzpdERPl?=
 =?us-ascii?Q?b4ah0P0gIlVcvdTHRXXztMizrG3LGDcxMMKvziuh1SeSsFJ7kLxCX9xt8dqw?=
 =?us-ascii?Q?J8q09kOT5cPzzGk9lwx+K+qfip9iD31mgyjobCuWDM8HliFpuktZtozPJV6p?=
 =?us-ascii?Q?tgQ5N2eZrtgZfXTbTO2Mid7zr2VTblATnydNpWNmdcbPrn15ajFwELWoZQww?=
 =?us-ascii?Q?Zob8SwVE42H4gfj/dV2HP4LZsowP1o8uYtr7vQz6fZkdRAm8Dfrc9ZperLs/?=
 =?us-ascii?Q?y8nRa4CSFdsLVpgW8kNvpr/53YegThZfQwg8bfImApYh9JhXY6HD8dKcpYRn?=
 =?us-ascii?Q?9OoZAD3STr7cehf9+SuqlxJje+aC9O5mJWZkrfIjm+KwFtHG6poJx5pJ4lEO?=
 =?us-ascii?Q?YTS5RaGnsHEkYonhYDrDvqRvQl7DsfsehK030MqKJcVMAySUXXhcKNs1u+1O?=
 =?us-ascii?Q?cOUA7/1U6kqSC5NfZ5cCZHCK6hsjPRcOMwWVkpTJ47wzyZf9njtQX2lop9dD?=
 =?us-ascii?Q?lccJbU7ciim71kefZiifEGwtAzox0oMcwayRR8QwpDIRnH6d0mLyWWvWOx5J?=
 =?us-ascii?Q?TD5CAd6hH1o41qhivYt8WC2OYH/DYGMqrKe44AvlmAiR0l5I+OuFTq7uH0Q8?=
 =?us-ascii?Q?HgAJgR5VidUq4G0ja6yFIlk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Q3QjIcB3M90YVkn6sMpZEwToNo2A6wdAsB2+ucoG0S9ljszl+23HE5kg17k?=
 =?us-ascii?Q?X33yJGvIo4BHDygCvVvdUBRunWX9pgRf0M+AlXyxEOIGFB12mm5ozu4gcvND?=
 =?us-ascii?Q?SOvljjyDd92EA9RW5E8g8lkeTIXkmxC0XBc+1nuRUJjy9jl2/uh6R3DoBMwW?=
 =?us-ascii?Q?zQP0XnuJM+9+FClcYH1hT+xbyVacvccjQuA6Od/U5BbxsRi4FCmw1mVr5dr+?=
 =?us-ascii?Q?FZ8ZgPQZiuYJzXrCf02YPPY8YBZyj65eoZimD2Iby+bkTWjk78Q68Rm08EBh?=
 =?us-ascii?Q?6GA+GInNT2K/9zEqChmnJSyrN+YJcCWBo7lvHaPPbXeW2Tm1nZ9+/CuigGkm?=
 =?us-ascii?Q?UcVYZpBtN0sNFRRR3xrvx5fgimSscww0YNMWvucm+/W6WQiyDN4H8JW1cV8T?=
 =?us-ascii?Q?1AasxvLNXE26ZWixEIapDz2E922KJk4qEc9byMzD6ZQmW2PmmqZD+JDRROnB?=
 =?us-ascii?Q?VPx3851ABcMmz9d+xu8pmBSz9JQcSiXc9P+RAeY9uswVytpvHXiATHsqqjqf?=
 =?us-ascii?Q?LsQP8eRxvLHDtLy9MqDy3qACirYl8vF6ucr1EXTkIjK6wqhgTI8GafOaSOXU?=
 =?us-ascii?Q?uUMVbNt90KKpiLmxWmohKgZgIXKc7DjCkR/8gI5Ap90j9EbQSmeo7SFI3Z43?=
 =?us-ascii?Q?qaH8nyQctZ+SRzu/ER7QEx1FofE30meX3FlosQc1BDEn26O8vCliekaxpgt7?=
 =?us-ascii?Q?OiypYSwEiOoF90mukmmP3vC4ldcZHIlDSlChw6Sg0XlaLJc9A1TCf9/CFUVq?=
 =?us-ascii?Q?d4dLUWKOfJqwlvs2SVqPWKToftmTR37DAunK+vjxpFu+klhdNNYlv2BIlCiC?=
 =?us-ascii?Q?F177WoHaRXSXGRFrsqHWXMLRI/fm4ecv81qgWNtjwwE8FLfYCh3CDmWEI9nn?=
 =?us-ascii?Q?jU4PdogNVe7AdxYltEtDmFtWtkfW1RCqB8fYpX0AlqvQutBEkzISO3WvaOOi?=
 =?us-ascii?Q?StqBJl468XqP/HvKFoWbu8tWtaRaoAgiWETFrnhfGZutcvFLxpnH9Dk30EIQ?=
 =?us-ascii?Q?3U23S5JEA7ipSvzw29NcF0dwFprpy453wVfLIu9AZr1PjLuTAVyFbHlgzYL6?=
 =?us-ascii?Q?WXQ+Hw/Bdi7eQBn2UvP7HbY/YzN1PsBcUnJ3QOAt4MMdrF5f2X1HnOyh9qve?=
 =?us-ascii?Q?OjmiTeaKwqZPJ//2hZbmQwgeuwmCxEgrQ9e77TXOJ/rPQ5IoQ7q4eBunorNl?=
 =?us-ascii?Q?iwWyHz5ort4ZW8B1Mf9xdKNOp1HXFLl/jtLp545DaJthzV+Pis/klnQkBoIC?=
 =?us-ascii?Q?bli2i3d55RyOoYMTVJmhpImKu+lOeuB/lI0cb3siIvfH9vgigxaM8Uc+mcwj?=
 =?us-ascii?Q?6WgZdNSSiiEFM54/Yd25OeJ3AEasLmgEwvddGbKneq3QhQZH3rHpC6VNF76+?=
 =?us-ascii?Q?79vwbIVLrs80zBCRfwPi1MXOYj/Jy0fCe1rMJQlAmwGKpudV9tNnUyoaxjbF?=
 =?us-ascii?Q?zjj9RiODjtdcNughgjdWIIEXrcdzy+8YXamLcomO8osGjxs7MNSEDzYeelRp?=
 =?us-ascii?Q?jM0KGK1M3MrFl8sR71ucU5EKPIjrahMh6aMplK+JZYyCA0WVeyIgnoZWSdjl?=
 =?us-ascii?Q?4UUnsTz7tREplvUHZmRJ9lpydUpir7aqyKW8vUzUAfX4zzvTXmKkt615m1rR?=
 =?us-ascii?Q?izU9yvAo6ZKxlHfvcEYDGq3sxQINGSebnXsWoAnnYXMj9V2Jxo5BXiQQs951?=
 =?us-ascii?Q?XWx4CxpgQU1nvR/3YcQeVLvoXy/QMqSsJ15D/F7WrfX5FwiNpXEfHVPH7K2d?=
 =?us-ascii?Q?g3BnYb7an/CdZMlZnQcjAs6qc6RoEbk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca69446c-d066-413c-ebed-08de538094d2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:21:25.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d20U3MrdSZLFpk6w/0X73J06Rrm7B6RRUIATLXApuUqPKM44rFX8Eh0rJintI8C2Jvo048fJZ/UKnFst1ZIC9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

Add driver support for probing on the new, per-instance and per-SoC
bindings, which provide the main benefit that they allow rejecting
unsupported protocols per lane (10GbE on SerDes 2 lanes 0-5), but they
also allow avoiding the creation of PHYs for lanes that don't exist
(LX2162A lanes 0-3).

Implications of the new bindings:

1. Probing on "fsl,lynx-28g" is still supported, but the feature set is
   frozen in time to just 1GbE and 10GbE (essentially the feature set as
   of this change). However, we encourage the user at probe time to
   update the device tree (because of the inability to reject
   unsupported lane protocols, as described above).

2. We have a new priv->info->first_lane, set to 4 for LX2162A SerDes #1
   and to 0 for everybody else.

3. The lynx_28g_supports_lane_mode() function prototype changes. It was
   a SerDes-global function and now becomes per lane, to reflect the
   specific capabilities each instance may have. The implementation goes
   through priv->info->lane_supports_mode().

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
part 1 -> part 2:
- split out lynx_28g_cdr_lock_check() fix into separate patch

Patch made its last appearance in v4 from part 1:
https://lore.kernel.org/linux-phy/20251110092241.1306838-17-vladimir.oltean@nxp.com/

(old) part 1 change log:
v3->v4:
- the introduction of "bool lane_phy_providers" from lynx_28g_probe()
  disappeared, and the whole "is the SerDes a PHY provider, or the
  individual lanes?" question is now handled by "[PATCH v4 phy 03/16]
  phy: lynx-28g: support individual lanes as OF PHY providers"
v2->v3:
- reword commit message
- add some comments regarding the "fsl,lynx-28g" fallback mechanism
- skip CDR lock workaround for lanes with no PHY (disabled in the device
  tree in the new binding)
v1->v2:
- remove priv->info->get_pccr() and priv->info->get_pcvt_offset().
  These were always called directly as lynx_28g_get_pccr() and
  lynx_28g_get_pcvt_offset().
- Add forgotten priv->info->lane_supports_mode() test to
  lynx_28g_supports_lane_mode().
- Rename the "fsl,lynx-28g" drvdata as lynx_info_compat rather than
  lynx_info_lx2160a_serdes1, to reflect its treatment as less featured.
- Implement a separate lane probing path for the #phy-cells = <0> case.

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 126 +++++++++++++++++++++--
 1 file changed, 116 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 63427fc34e26..9e154313c99b 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -433,9 +433,15 @@ struct lynx_28g_lane {
 	enum lynx_lane_mode mode;
 };
 
+struct lynx_info {
+	bool (*lane_supports_mode)(int lane, enum lynx_lane_mode mode);
+	int first_lane;
+};
+
 struct lynx_28g_priv {
 	void __iomem *base;
 	struct device *dev;
+	const struct lynx_info *info;
 	/* Serialize concurrent access to registers shared between lanes,
 	 * like PCCn
 	 */
@@ -500,11 +506,18 @@ static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
 	}
 }
 
-static bool lynx_28g_supports_lane_mode(struct lynx_28g_priv *priv,
+/* A lane mode is supported if we have a PLL that can provide its required
+ * clock net, and if there is a protocol converter for that mode on that lane.
+ */
+static bool lynx_28g_supports_lane_mode(struct lynx_28g_lane *lane,
 					enum lynx_lane_mode mode)
 {
+	struct lynx_28g_priv *priv = lane->priv;
 	int i;
 
+	if (!priv->info->lane_supports_mode(lane->id, mode))
+		return false;
+
 	for (i = 0; i < LYNX_28G_NUM_PLL; i++) {
 		if (PLLnRSTCTL_DIS(priv->pll[i].rstctl))
 			continue;
@@ -687,6 +700,87 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 	}
 }
 
+static bool lx2160a_serdes1_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return true;
+}
+
+static bool lx2160a_serdes2_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		return true;
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
+		return lane == 6 || lane == 7;
+	default:
+		return false;
+	}
+}
+
+static bool lx2160a_serdes3_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	/*
+	 * Non-networking SerDes, and this driver supports only
+	 * networking protocols
+	 */
+	return false;
+}
+
+static bool lx2162a_serdes1_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return true;
+}
+
+static bool lx2162a_serdes2_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return lx2160a_serdes2_lane_supports_mode(lane, mode);
+}
+
+/* Feature set is not expected to grow for the deprecated compatible string */
+static bool lynx_28g_compat_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct lynx_info lynx_info_compat = {
+	.lane_supports_mode = lynx_28g_compat_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes1 = {
+	.lane_supports_mode = lx2160a_serdes1_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes2 = {
+	.lane_supports_mode = lx2160a_serdes2_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes3 = {
+	.lane_supports_mode = lx2160a_serdes3_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2162a_serdes1 = {
+	.lane_supports_mode = lx2162a_serdes1_lane_supports_mode,
+	.first_lane = 4,
+};
+
+static const struct lynx_info lynx_info_lx2162a_serdes2 = {
+	.lane_supports_mode = lx2162a_serdes2_lane_supports_mode,
+};
+
 static int lynx_pccr_read(struct lynx_28g_lane *lane, enum lynx_lane_mode mode,
 			  u32 *val)
 {
@@ -939,7 +1033,6 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	struct lynx_28g_priv *priv = lane->priv;
 	int powered_up = lane->powered_up;
 	enum lynx_lane_mode lane_mode;
 	int err = 0;
@@ -951,7 +1044,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 		return -EOPNOTSUPP;
 
 	lane_mode = phy_interface_to_lane_mode(submode);
-	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
+	if (!lynx_28g_supports_lane_mode(lane, lane_mode))
 		return -EOPNOTSUPP;
 
 	if (lane_mode == lane->mode)
@@ -984,14 +1077,13 @@ static int lynx_28g_validate(struct phy *phy, enum phy_mode mode, int submode,
 			     union phy_configure_opts *opts __always_unused)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	struct lynx_28g_priv *priv = lane->priv;
 	enum lynx_lane_mode lane_mode;
 
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
 	lane_mode = phy_interface_to_lane_mode(submode);
-	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
+	if (!lynx_28g_supports_lane_mode(lane, lane_mode))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -1067,7 +1159,7 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 	u32 rrstctl;
 	int i;
 
-	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
+	for (i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
 		lane = &priv->lane[i];
 		if (!lane->phy)
 			continue;
@@ -1129,7 +1221,8 @@ static struct phy *lynx_28g_xlate(struct device *dev,
 
 	idx = args->args[0];
 
-	if (WARN_ON(idx >= LYNX_28G_NUM_LANE))
+	if (WARN_ON(idx >= LYNX_28G_NUM_LANE ||
+		    idx < priv->info->first_lane))
 		return ERR_PTR(-EINVAL);
 
 	return priv->lane[idx].phy;
@@ -1167,10 +1260,18 @@ static int lynx_28g_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->dev = dev;
+	priv->info = of_device_get_match_data(dev);
 	dev_set_drvdata(dev, priv);
 	spin_lock_init(&priv->pcc_lock);
 	INIT_DELAYED_WORK(&priv->cdr_check, lynx_28g_cdr_lock_check);
 
+	/*
+	 * If we get here it means we probed on a device tree where
+	 * "fsl,lynx-28g" wasn't the fallback, but the sole compatible string.
+	 */
+	if (priv->info == &lynx_info_compat)
+		dev_warn(dev, "Please update device tree to use per-device compatible strings\n");
+
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
@@ -1194,7 +1295,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 				return -EINVAL;
 			}
 
-			if (reg >= LYNX_28G_NUM_LANE) {
+			if (reg < priv->info->first_lane || reg >= LYNX_28G_NUM_LANE) {
 				dev_err(dev, "\"reg\" property out of range for %pOF\n", child);
 				of_node_put(child);
 				return -EINVAL;
@@ -1207,7 +1308,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 			}
 		}
 	} else {
-		for (int i = 0; i < LYNX_28G_NUM_LANE; i++) {
+		for (int i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
 			err = lynx_28g_probe_lane(priv, i, NULL);
 			if (err)
 				return err;
@@ -1233,7 +1334,12 @@ static void lynx_28g_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id lynx_28g_of_match_table[] = {
-	{ .compatible = "fsl,lynx-28g" },
+	{ .compatible = "fsl,lx2160a-serdes1", .data = &lynx_info_lx2160a_serdes1 },
+	{ .compatible = "fsl,lx2160a-serdes2", .data = &lynx_info_lx2160a_serdes2 },
+	{ .compatible = "fsl,lx2160a-serdes3", .data = &lynx_info_lx2160a_serdes3 },
+	{ .compatible = "fsl,lx2162a-serdes1", .data = &lynx_info_lx2162a_serdes1 },
+	{ .compatible = "fsl,lx2162a-serdes2", .data = &lynx_info_lx2162a_serdes2 },
+	{ .compatible = "fsl,lynx-28g", .data = &lynx_info_compat }, /* fallback, keep last */
 	{ },
 };
 MODULE_DEVICE_TABLE(of, lynx_28g_of_match_table);
-- 
2.34.1


