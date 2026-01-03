Return-Path: <netdev+bounces-246686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ABFCF060D
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 22:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23A76305CA12
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 21:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF362BD58C;
	Sat,  3 Jan 2026 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LoW23hoA"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755A2BDC05;
	Sat,  3 Jan 2026 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767474307; cv=fail; b=VSLPOHcJEafxKSPztSyRUREvnIrzdAWlcm+VXjv9mTkHFjqa8FwWUpGA0S3IjjqIDqP+sPmzT92VWKryJMhgI+9B3lrkRL8Ol9BC2QDKv2Pv2GCBbeGS/PXowgMZmQ1/JSxCF3omri7oy90QGt6TYYWbhBDOsMd/imMflFjPudM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767474307; c=relaxed/simple;
	bh=uWzDC7aTjn8yJMLl0qA3/0Lh0RlAqLPm+wrTZ7Xk+1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N9yOR1c9GZgSqyKxd6hbUaGm/64F4E1nEEbVcK9YKSbb4z6i54zjQ1RmygV4qE4/h7ewcnKo5FMD0TDzZqwhzoSk9Q/EWvSbODgSkdirSyTkcCpZVYfksTC4Uiqpq7bJfZeRfoayJK695cViywOk2xyNJpq+VnLxH1dfNkDCwsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LoW23hoA; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNb2lMZLFlT3WieKW9lk2VOIh9PD++ro5V9TrNYhvL5WM+W5uYIxwOA9SfefqAey8tIn5Ka78+vY87d2wMIqabQkNPSGJZV40RZnwQd5L4nNULK5oxd85AQwRHul5n9ASdjcml4rW489clvjTdQ0OeYATk5iQTUIxZAWOT5ZB2rdN0ynBeU1vFqACPJyHcsA+kFmJBVD+4+7szrMZRhKhrt+iK+aYQbtjgzA/sB4vH9NoSD2c4vXWF2taehqQaI4MN3YJbIENhYXVBQBYRZpia0FHZm39ioOfaTa8bWbgPbk1r48DWqBTerB511L0Uyima0ZR6FQIG+RagclJs8hww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl6FgsuCeY/OigHwy1S6TV+ByxXFXwXz/Ng1f5nbTpY=;
 b=Zyp2UgZ1+rIdJfplpLjHoob50qKYv7wcUE4nIJpSOVHoAYCsrSbJAz73KcMLlX7JcErX3i4Q1R/zf+2eGuCOJJPUfdRoxepz2Wh9VGRsCNGZqt/cnBCZ/Sr+qPQtfDJkkT9vTuqpkPqSXvtGU0jQsQpOAu9cyTk4B9YUWUIKBRBR+Murc+ReqvMecEocGz+B88Zr3bBistq2KOC5ltjBYviU/aipAle2s7eIbyq1an7DO/eMaL6OiJUpzhzzAHJdkrQISzUoCVxIRxIPw9udj/CZhMLDAB78oDOlL8WNXfGuBHBhThvHhg9n3HwV86ScR5XxfrR9AM3gzTCrfRFlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl6FgsuCeY/OigHwy1S6TV+ByxXFXwXz/Ng1f5nbTpY=;
 b=LoW23hoAIWycaMGOY6J8zhMt0sNVjl6iTCOQhzZx1KpmSQiMiMHZBl6JM9/hrClXpAecoh9o3QyFpmRe90CpKwDJGPe1zHwbl7MfnlFILYNUfywEkZ2ZzQdFBJU1YUOSj23jd3g8oA95q8jlX7Pr5d8EG0Ouvvqfzrc6D8KsZtlriV9Ud8ewpUVzyxWGI+fKuTlo+hjGkcXK6DFwFv/mnCOmowU9OrDDh28K/zCf6eM38hZoWTh3gfqxAutNyyq2tsUJ87DCQlT5JQ2vlY9D74w461qNZXHG+RF35lACBffnCvhgf9yZmBTsAUvbL0bzSEoZV/Q2Zf8hlnpnLF2Bkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 21:05:00 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Sat, 3 Jan 2026
 21:05:00 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 net-next 04/10] dt-bindings: phy-common-props: RX and TX lane polarity inversion
Date: Sat,  3 Jan 2026 23:03:57 +0200
Message-Id: <20260103210403.438687-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103210403.438687-1-vladimir.oltean@nxp.com>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::16) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|AS8PR04MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a1724c-7fcb-490d-b0a1-08de4b0bc1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3XpQyoS2VQtpK/+m7LCIODT0E6S+UkYSbEgoSroZFN2DjsF+H3RQhJAYTc92?=
 =?us-ascii?Q?+xYvBihIz1BMrv9b6lZvO3roBGW39iODKmuaTHTqGgfcukGkhQrYt92TtndC?=
 =?us-ascii?Q?sUCfq90AgRyYjMcKHim1skxETlNUSTOMctksm/sd/DLYmPEYpafPx5WwONhs?=
 =?us-ascii?Q?YDBWcYgIRqcf4bw5XY1Q7UNkjC7dLJFB5D3ocWULk1ToJg6i2uygilc4XgtZ?=
 =?us-ascii?Q?KD7/EyS5KpDGrL2zrhJFiRf1xh/VVJIH8gowhlbLBtJ0gkJ+x5/nFaulu8BW?=
 =?us-ascii?Q?WTWoWG3DdDSGfE3IjP3XHh5bYCRXu4un8ZoQHGCjx7Lg4IrPGC3w7GmsFhC8?=
 =?us-ascii?Q?Vyy4ArfD8qP/tYXDqUTXOgGU/xo8vgS2k3SOww630NFRziQ1XYdLCUNkArTb?=
 =?us-ascii?Q?0DdTD7u/teGqpmA5wxMiDRyiTeWrNWuC9zI1HEiros9AuwAKsVQzi235N28E?=
 =?us-ascii?Q?+NJ/nxEJfiw/nHAFCA3HvAlc1yrsytVjqYpzd5DgevQgI38aSbVQb1WxKKfk?=
 =?us-ascii?Q?aCKURoVg5r+3DTLBrYyDebW5jXp392JdEQOxD8BrKnYqWTBa3z8RQZPFjXRW?=
 =?us-ascii?Q?pTK8mwpA1XGge32bzzn7Pjwi8k96oLiW0HkgIAadG5N4D3z9/gf88a9DS/wO?=
 =?us-ascii?Q?RelN/mI5W0Q+cxfQY62ZU5nNNhbkkWuBlprJV6PhX1rSD41kGMKnyWh2kL1j?=
 =?us-ascii?Q?gp87qF4vckWORHO2kuUWOzGKwxYNkl83oVudoR0mtKSWqAUODUViqPJXQnSx?=
 =?us-ascii?Q?63yJb1Z6yH0KLt4oFrNHw2z9eK4dO9LHjzF4U59VDSQDGEUjMQHncHvNQgDj?=
 =?us-ascii?Q?kXiWqnvWip2L2vFWZ0/Pjdz7xssD28G5VMFeOJAIuAz4ihmu1KVPJE3NAnwj?=
 =?us-ascii?Q?meT4QwFYH0sS/jXaNDDx7speCeMpX+IY4NVWH2xptTQhXiLpHiAO+dZMBfuo?=
 =?us-ascii?Q?UuxbLYTKClXiWjbrFDKXd8SzlMCOXpOssbk7zuaOwrXBOGVwQb81KA79MLvY?=
 =?us-ascii?Q?ybXKt5Uv1Mzb3TLi/aDKLiLhFzppSxOR6/UNl+N0VwuMGGJiI8CbzceOXbYh?=
 =?us-ascii?Q?PQgCXL34AzBYaTz8SLIS1jmCZ4zUmOD4ZzVIwVWD8XzpRwsnVn38DZVSNATW?=
 =?us-ascii?Q?cv5HvpQQX/+fySxi1IPngNGvMTo978KmGm/UQnt2r/uO+bxNoAoXOZnAgiwv?=
 =?us-ascii?Q?q1irek//LIVLybg7q1bjU8i/Houp7SuMDszIdQ/fFYKvFEDesNGGHxZk+kiX?=
 =?us-ascii?Q?ibsZHdhtx3MxPky1eflKJ5U/vrmVC3Ntc5PF8DXGcS2NcAGze5HjTTcAvV0T?=
 =?us-ascii?Q?Ll08A6OBgT9jMS1p9fYPeIHWwM2N6s9ggDJIKMdQ6nZWs33XvPV+7Qi3Stsp?=
 =?us-ascii?Q?MeGa4fKWI7/TvHE10v/KnBlNR2l0xBmNSwme01PzPxHaHAKaiARWDS/BNtDn?=
 =?us-ascii?Q?RP766cYmqhYL97Fn2KjX49LiisOU/CjjXCMbqvWDrfKvibqZOJ/A4fmLZNB3?=
 =?us-ascii?Q?duvQV0p8aHHxuKDhGxAbjWmEgGBgUgDdjc+cMkmUB3O7Y7PUXMUJF9QDXQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kMRKKhGa7CsxpY70DSLOjxKzb2RRJjsZZddtxRWwx9CowcsHH6hAj3J632kL?=
 =?us-ascii?Q?iXmnjrTIrNBBqf8LcN9xIxMetUV1TrnLFZAH6NBOYIqCKN4J3xXhFngM4l3E?=
 =?us-ascii?Q?TpWaDxdklq7wP6YmRAjAyfLvqr8qyhvxJ9W/go40xCWe5A1wbCMxiDuVvKJ9?=
 =?us-ascii?Q?ysoba4W7+lEu7KPq8Lvvb+JlgWFCfpiOI10/18ApGBa9Bum0qrsRRvHIHBz7?=
 =?us-ascii?Q?aaL9iXczS7sjN3TYjiqxHVdzS3Vg0LQ7S4hjfUGjp+itUe2gAstcT/eQ17lJ?=
 =?us-ascii?Q?rJXoNvgmFa/4885u0EW5rKjPqmLrMzUtVtyLeBsvpmiy6hvfrYi9XmR+BC/4?=
 =?us-ascii?Q?20frLYyB4Db/Nc1l+qPeW72v2J9ZYGJSdTPzXp9Cp5JpTtldJkpKoGcevpPS?=
 =?us-ascii?Q?C4ayzPK6xSQnXMydzYKtq+UtqRlHIlZR32A/J150EY6J6YrMdWz4TSIbL9O8?=
 =?us-ascii?Q?mTFlgFYehnAhILUSI+vuQ7fUXNoIJf2nGX3daTTIjiGW3NDAjE+UzEpLzXKZ?=
 =?us-ascii?Q?g1Onu01N6vrI/DCEb8YCIYHQ9FAE2mnlhLl+DE2yZdi/VG87H9Po9qCCGY2r?=
 =?us-ascii?Q?elGFo0w5d5yknqM1nkWgb6E1B3uai09SqchbiJINUrOdVaBo0lN8IBwLW5Ng?=
 =?us-ascii?Q?ByMnkAiFEQKb3plW5P5hR6cuevJaFavpAyvmubaYjmhjPYTaVWPxCQSwytab?=
 =?us-ascii?Q?liI/pSWNplE7/ilaIP1Kp+AAQZzScbJntqqni4BhT/+f03j2nKNI36a99r7N?=
 =?us-ascii?Q?19/Q6Cub7q5wmlZ7mJtsBbLy4muMT2M+cml1uUH7rluK7cwsWmyNt5YwDohd?=
 =?us-ascii?Q?l/IYhJtKJngaFnfKdNErSRG+xGQaLXWwyEq27Aor+ks0nhKzlQS69l937SN6?=
 =?us-ascii?Q?ZE4SX8zQhhTa5wJNNPqUzTn3ZvRGqk8uftD5Fay8O3JXZ//2oO1psrKxn9lM?=
 =?us-ascii?Q?vQctsnom5ed+a0elX72XzYLFSG/qrKJGXIRGeoDAn0yZvOzmx1La+phKyCF5?=
 =?us-ascii?Q?rADVpJTO5S+MO2nDo/Rz9D7FEAKQ99/OssQyPWcxAHo0/u2uAUy9Qj6nvDx7?=
 =?us-ascii?Q?dMGmnKzMk8MNcQjasQ3Yrjk0DPO5y1yLiGQ44rmojkm3nusvGr14b2uhJmJp?=
 =?us-ascii?Q?0wkFFtM6F2nRKHiOhfRdI33s1j5QTkz+6S06Z6GS4EYpV9zWaCbEbQd67l82?=
 =?us-ascii?Q?aFewqzPGhMOy7nf8a/wUUIifWhjnd7k2cFNJDxsjSD74QxXhAqLdtdwv6hx5?=
 =?us-ascii?Q?lMdRjoK3Ic6HtY6lxSXFOe3ZuLQcvPZJHK/wS3Mfhg+VQKCXvlYDt1C5TpCL?=
 =?us-ascii?Q?ddtdSjrtrMHPj9DMezbIiIVOVLtZZ6VQDVuIAiGO0dIwZ/9o0SFEwDscOjJm?=
 =?us-ascii?Q?Tx7waFIRCnPBFIzC1Fbnl5UqFyxWzjPzY+rf8g15drAVQQgn64Tw+VoIDa/l?=
 =?us-ascii?Q?lKRpOe/FLvEg38hsNG8Qf1XaGoGWEmL32wopdY4fHoPI2+IrLBG8L82LWz7a?=
 =?us-ascii?Q?Si52H6CFCtLWZibvyavWLyJYKvpjms3mGQSFKm6Oql+gwMhzbv5HlRwQAcBt?=
 =?us-ascii?Q?X0U1cNt/U0u+YfOcrtOXkA1/ZDronKY58HPcmQIKsDD9onFESHblU/z8ogST?=
 =?us-ascii?Q?L+RE9h/K13VYp87NdQQDLTm2KENLwqk307SoIe7clngD7CE21u6mC4+Enq8M?=
 =?us-ascii?Q?OcX7jzzHcdLihrPXlJQg5CP7tILLptDdlTAjTvmY6Ot5q/ucwuOC45MQvyOy?=
 =?us-ascii?Q?E4AoR8LiNMyLEC5vsiXabs55+IS9dKc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a1724c-7fcb-490d-b0a1-08de4b0bc1d8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 21:05:00.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+M8juUItx2bKzVadi5NjgtBMdvKxoT6zUWbn9fTpMe6hXTFeiJ0H7eaNF6Vh5WdJVnVqKkJFd6pgczGbrt5Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

Differential signaling is a technique for high-speed protocols to be
more resilient to noise. At the transmit side we have a positive and a
negative signal which are mirror images of each other. At the receiver,
if we subtract the negative signal (say of amplitude -A) from the
positive signal (say +A), we recover the original single-ended signal at
twice its original amplitude. But any noise, like one coming from EMI
from outside sources, is supposed to have an almost equal impact upon
the positive (A + E, E being for "error") and negative signal (-A + E).
So (A + E) - (-A + E) eliminates this noise, and this is what makes
differential signaling useful.

Except that in order to work, there must be strict requirements observed
during PCB design and layout, like the signal traces needing to have the
same length and be physically close to each other, and many others.

Sometimes it is not easy to fulfill all these requirements, a simple
case to understand is when on chip A's pins, the positive pin is on the
left and the negative is on the right, but on the chip B's pins (with
which A tries to communicate), positive is on the right and negative on
the left. The signals would need to cross, using vias and other ugly
stuff that affects signal integrity (introduces impedance
discontinuities which cause reflections, etc).

So sometimes, board designers intentionally connect differential lanes
the wrong way, and expect somebody else to invert that signal to recover
useful data. This is where RX and TX polarity inversion comes in as a
generic concept that applies to any high-speed serial protocol as long
as it uses differential signaling.

I've stopped two attempts to introduce more vendor-specific descriptions
of this only in the past month:
https://lore.kernel.org/linux-phy/20251110110536.2596490-1-horatiu.vultur@microchip.com/
https://lore.kernel.org/netdev/20251028000959.3kiac5kwo5pcl4ft@skbuf/

and in the kernel we already have merged:
- "st,px_rx_pol_inv"
- "st,pcie-tx-pol-inv"
- "st,sata-tx-pol-inv"
- "mediatek,pnswap"
- "airoha,pnswap-rx"
- "airoha,pnswap-tx"

and maybe more. So it is pretty general.

One additional element of complexity is introduced by the fact that for
some protocols, receivers can automatically detect and correct for an
inverted lane polarity (example: the PCIe LTSSM does this in the
Polling.Configuration state; the USB 3.1 Link Layer Test Specification
says that the detection and correction of the lane polarity inversion in
SuperSpeed operation shall be enabled in Polling.RxEQ.). Whereas for
other protocols (SGMII, SATA, 10GBase-R, etc etc), the polarity is all
manual and there is no detection mechanism mandated by their respective
standards.

So why would one even describe rx-polarity and tx-polarity for protocols
like PCIe, if it had to always be PHY_POL_AUTO?

Related question: why would we define the polarity as an array per
protocol? Isn't the physical PCB layout protocol-agnostic, and aren't we
describing the same physical reality from the lens of different protocols?

The answer to both questions is because multi-protocol PHYs exist
(supporting e.g. USB2 and USB3, or SATA and PCIe, or PCIe and Ethernet
over the same lane), one would need to manually set the polarity for
SATA/Ethernet, while leaving it at auto for PCIe/USB 3.0+.

I also investigated from another angle: what if polarity inversion in
the PHY is one layer, and then the PCIe/USB3 LTSSM polarity detection is
another layer on top? Then rx-polarity = <PHY_POL_AUTO> doesn't make
sense, it can still be rx-polarity = <PHY_POL_NORMAL> or <PHY_POL_INVERT>,
and the link training state machine figures things out on top of that.
This would radically simplify the design, as the elimination of
PHY_POL_AUTO inherently means that the need for a property array per
protocol also goes away.

I don't know how things are in the general case, but at least in the 10G
and 28G Lynx SerDes blocks from NXP Layerscape devices, this isn't the
case, and there's only a single level of RX polarity inversion: in the
SerDes lane. In the case of PCIe, the controller is in charge of driving
the RDAT_INV bit autonomously, and it is read-only to software.

So the existence of this kind of SerDes lane proves the need for
PHY_POL_AUTO to be a third state.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- logical change: the bindings refer to the described block's I/O
  signals, not necessarily device pins. This means that a PCS that needs
  to internall invert a polarity to work around an inverting PMA in
  order to achieve normal polarity at the pin needs to be described as
  PHY_POL_INVERT now.
- clarify that default values are undefined.
- fix a checkpatch issue: duplicated "the the" in rx-polarity description

 .../bindings/phy/phy-common-props.yaml        | 49 +++++++++++++++++++
 include/dt-bindings/phy/phy.h                 |  4 ++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-common-props.yaml b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
index 31bf1382262a..b2c709cc1b0d 100644
--- a/Documentation/devicetree/bindings/phy/phy-common-props.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
@@ -94,15 +94,64 @@ properties:
       property. Required only if multiple voltages are provided.
     $ref: "#/$defs/protocol-names"
 
+  rx-polarity:
+    description:
+      An array of values indicating whether the differential receiver's
+      polarity is inverted. Each value can be one of
+      PHY_POL_NORMAL (0) which means the negative signal is decoded from the
+      RXN input, and the positive signal from the RXP input;
+      PHY_POL_INVERT (1) which means the negative signal is decoded from the
+      RXP input, and the positive signal from the RXN input;
+      PHY_POL_AUTO (2) which means the receiver performs automatic polarity
+      detection and correction, which is a mandatory part of link training for
+      some protocols (PCIe, USB SS).
+
+      The values are defined in <dt-bindings/phy/phy.h>. If the property is
+      absent, the default value is undefined.
+
+      Note that the RXP and RXN inputs refer to the block that this property is
+      under, and do not necessarily directly translate to external pins.
+
+      If this property contains multiple values for various protocols, the
+      'rx-polarity-names' property must be provided.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    items:
+      enum: [0, 1, 2]
+
+  rx-polarity-names:
+    $ref: '#/$defs/protocol-names'
+
+  tx-polarity:
+    description:
+      Like 'rx-polarity', except it applies to differential transmitters,
+      and only the values of PHY_POL_NORMAL and PHY_POL_INVERT are possible.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    items:
+      enum: [0, 1]
+
+  tx-polarity-names:
+    $ref: '#/$defs/protocol-names'
+
 dependencies:
   tx-p2p-microvolt-names: [ tx-p2p-microvolt ]
+  rx-polarity-names: [ rx-polarity ]
+  tx-polarity-names: [ tx-polarity ]
 
 additionalProperties: true
 
 examples:
   - |
+    #include <dt-bindings/phy/phy.h>
+
     phy: phy {
       #phy-cells = <1>;
       tx-p2p-microvolt = <915000>, <1100000>, <1200000>;
       tx-p2p-microvolt-names = "2500base-x", "usb-hs", "usb-ss";
+      rx-polarity = <PHY_POL_AUTO>, <PHY_POL_NORMAL>;
+      rx-polarity-names = "usb-ss", "default";
+      tx-polarity = <PHY_POL_INVERT>;
     };
diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 6b901b342348..f8d4094f0880 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -24,4 +24,8 @@
 #define PHY_TYPE_CPHY		11
 #define PHY_TYPE_USXGMII	12
 
+#define PHY_POL_NORMAL		0
+#define PHY_POL_INVERT		1
+#define PHY_POL_AUTO		2
+
 #endif /* _DT_BINDINGS_PHY */
-- 
2.34.1


