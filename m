Return-Path: <netdev+bounces-215686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA38EB2FE57
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3F51C224EA
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB67027F4E7;
	Thu, 21 Aug 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ceOiCabN"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6827A45C;
	Thu, 21 Aug 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789684; cv=fail; b=hKRJCEBuS8PZnxz4+WXDag5NE19g7wDZm+/OzCoRDWx2CqCzDdc5sq8EQBNppWoaN+50Ig/rqpDURlLIXf3P7ybzPsPgd5JWDuUfGPP1l1Y7WvJoEpFkRkV6XkNMDr2SMtu+M4SulTzDXeR+6O8ho3LiwFHWszVueBYZ8+/t150=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789684; c=relaxed/simple;
	bh=P4jypK0DiN8Iz2CfMfgr9PFEJwiXw3qu2LFOVVLU34Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+HdpzBMVspl0WFxht1mbqKgpZ8VZXmRzX/13yHt4rSTuM8KBpRW8GmUomTd8SOpUHcK6sywJw34W3dm7D0WoUW7QMVx8iy9eQ3j2YdGkh3M3r+UeeCvDFperrH4gX8eCgUzlHqeArUa6Tj8aY1jO8HQao0knjDonwKn1m5Kino=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ceOiCabN; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMhkjjAq3GFR3RQoptGPrqxj4F/B2ANyo9axa479e60jaItkGIAZHc6aBe/tPJnoKvd694BmccgUBIILKLOeEL13mmcSmfjRBhZoGAlyfzsiqUE9mxtbqC1NvIpu+5PYPOfc7tKot/ljEqZPPaxGyEfABCfZPFe645BNaYxZxEdZBj+vdvb9HY1qO9ozvbD8IUs3dHAgiwVHjTqeALg+IQu4kI+phtqUruXP9Q6V0WG12+2KB8V7d2/G7IT1nMINN2r8K9VUoEC9/U7eH4mHh/2OUP0zm/QN11G5jMuEEQZ++GQ18ozYTn7KH8QboQBmmZbmg29hYxNYc4pGh4OtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhN7IDqhCgQ2GWxcpmgRDW1m5EtFI7+4yMI4RrWwGqw=;
 b=LaHDZkqiJv+7Om6a5Fo6ozuXZwefDOHEMrgXLkqa6/zOzhluz6ul8NGfyO6ZW3APmXGuqJkp1tbidnp+8uF7r/ZzQIeWHOnmTO/IOEh9G0//aUSOyZRg4LBekjU2iaBiQEIeieYB1FuifrCuEU9Cy+hbIK5wdb8N3IeQpIyDgYXhHslxsDOqEEawe9JCfQszjgcrls6RYpQtKP8SHKr/lcCYpUXRaWawJ1bXXZpqr7IRxjlbDRfZUgtHY3Gp68vJ9M4CHbHgcTKEqpz4EmQJHP2Yf8BL/2XBJI6936lM03zUjyGUSMp59Xk05N0mGbZm4LT0Bz6TD6VUNO5xaXfAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhN7IDqhCgQ2GWxcpmgRDW1m5EtFI7+4yMI4RrWwGqw=;
 b=ceOiCabNMvJycqnjmK8wcdc68NRY1/kugxfWdYrdQNmENS5v2e9LO6H5tNqyUuU/ieL9YHywhQBDB1h4GbqWtpJsJQLC1VJXvLlPmws2C8eTpv3ufJ6yyi6LFEm5FJmg1mW8r8r6AJh3+2zahVWbtpLxBuZu21vgFgKEvBvsubK5hAWAkMkxSukMdI1FXuJzOoj75hCSt9lHpC+n25v65WoThrVhGTMKtoPs2sUaQWkxMjfbnBk3MnXurCvbOTAxMs+DkVxowuyrTxv8RaA/JUVFyvDmFXX/Qowy4Genz87Y7HMZmSfxJFGzBc3gr+pPyqFg31LcXRg/LD1YnAvatQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:16 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:16 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH net-next 02/15] net: phy: aquantia: merge aqr113c_fill_interface_modes() into aqr107_fill_interface_modes()
Date: Thu, 21 Aug 2025 18:20:09 +0300
Message-Id: <20250821152022.1065237-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0016.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::8) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10809:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8e7ce7-dba4-4e28-88d8-08dde0c65f3d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?F0EbdOYfzO2wtM+7+Lr89EAiYfd6dg5Kfn+tCbuTF8uaFdju3otB7fPIrR2g?=
 =?us-ascii?Q?+E8IvEhtaXsDA8f0Q85G0I6tUHeKXRVJylj4yeYElajzDVK2Fb57M3zFpH7P?=
 =?us-ascii?Q?3KCJsAUPGcat991DZuQ7LR5nPtgnECJ6IvBcCtjf7h0sg1Jzl04n8RnRmFt3?=
 =?us-ascii?Q?Soq9t8xPGfm3iY4gYvHP/1DPa3EOYVowH+be93+hnAWk/z7fSXm8O5lKkfI+?=
 =?us-ascii?Q?kdNF8waDFfdygD5TkduDovo4H75NBfhIw2JAi9YlmTnbwLlbTgqFOcf5Pcfn?=
 =?us-ascii?Q?Y6pHBW/xJfDAOxYK6qSWmTvBi7lUjHFoH1fq+kgM+LHdKmlgSvWYMOfZwvea?=
 =?us-ascii?Q?NbBe8YdLpbg2ntEOSdOh/lyUFRqN6JxWwqsyl/eQz2fEtdEAO3GaVcJT3Wp8?=
 =?us-ascii?Q?Y/8UL3fQwe8wCXO932DiEgwgvb+JO+1zDOxj/nNaf4LeiLvjaEQj09vp9Z+q?=
 =?us-ascii?Q?2a4THFJ3Ak2aKhDPtdeIw/ev43z8jIryz5vsEhNkarZVynOwfjEjnc9GxkLd?=
 =?us-ascii?Q?4ql5vhAd3hTC7/2D1EQv+4LGXLP68fJfT4m6GCoi54Y4zhUuS0BV2lEP+L3l?=
 =?us-ascii?Q?KYvSCkrdDQ5PbND2x19ZG0z1Mv4dC4ctEIPZv6k0CAc/z02gdDVDFtqc8BpH?=
 =?us-ascii?Q?HS3W8pxGac6f+n14dR9vVuL1yEw7s7fI2G4MDW1SaUt3Y4tqw3EEc3qkdGll?=
 =?us-ascii?Q?j6T2gVO+Dfd0QrTLkEMXDWv8b2jJHWw6WJOoPCwVLLxm26vDuF94q3gzRiD0?=
 =?us-ascii?Q?QpnIENBqbfmgxsk2EMEpZpKvb5Sd3wmEGOdIzo4J9faO9EvOcefZ2vKNzrnX?=
 =?us-ascii?Q?Vm0ZvsYMeXRfnK1qnNwnQjGPBoV/Lx0hC0PEnVtP5wgpJfaTGT+o9SZnfTg5?=
 =?us-ascii?Q?eDksuL51Z2CpNcibdJQ0yTONXs+2iNjHARe7xDmJ7U9Mt3YtcHeZLx6Mc0Tk?=
 =?us-ascii?Q?mJ5i5iF1pfSMYe4KxvEXhEp1a5/eeYZUXlY+1r+7TtjsQsvTL256ACByl/6q?=
 =?us-ascii?Q?O4MQR+d/aMzV+dsfM406gnplqE0SlgxJ5Ozr6ZNVx+1zZGS/X5XlOCgmU7iZ?=
 =?us-ascii?Q?Y7guC9xBOwEUuMLg+eaz6+bIjuBW7jAb6X/LF2HdgIt+kU3Ogg2aghm3K0Uu?=
 =?us-ascii?Q?A+H9UwUfvov2s6MSbgtdZiR96aW1yTEFpGJpCEX27K9kKllrBlgazDXKWW3N?=
 =?us-ascii?Q?K14uEEk4rlnBePskrAT5pvv/gIp2MILYo3Fk9Psh68dlsBw1Jq0TiG7rk14R?=
 =?us-ascii?Q?+0oxzNXkLY58OXOKNJrS0xOuQpisJ3AY9n5Ut92+TreuuFb34BtyXykfOfxV?=
 =?us-ascii?Q?ry0Z7wkrZ5ntXOMSZuEmdyGJ28KRmCsstPfCtsAfKQKxxl2nkmFX0TgTrWGA?=
 =?us-ascii?Q?mmDH+6a5SWkXGCW0OT9Zu7lw9Dk6NuJLM1ufBxeH/zMMAeXMtp8SrUT9gaIx?=
 =?us-ascii?Q?4juAFWbgU6CNI9ODrRz+x1I9qGrCCZ47puH6G5d3GtzTXynrNnFdzw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?xEN3XWbGHou/3TQCnaQ4G5wKPd5wajvhq1WUMMpKFCargKb/zw3Nf3+ftsCz?=
 =?us-ascii?Q?yue4xmmHGo4Jl/xh8urn0MZIh1v0kgvjT3CqtW6GBGr0drNSSJPrD/p+krcC?=
 =?us-ascii?Q?IAkB6vY0EwG9XHC5d6ixerG4uel2gMwEBZGtHdOVY5k4EMMLf7RQrtEEQpb6?=
 =?us-ascii?Q?/t5BNQl8Rz55aT4QZhsy0SZ4lldc+/F7AsSuO7a5ZxItJlBBABeoH/RzQIFy?=
 =?us-ascii?Q?EjleZUjj9ak95NH++abQVfjoVps1oDYOBdLqtzU39T+TgWQ24xI6taoBBTqr?=
 =?us-ascii?Q?SpE5BaTLFLuqtkePMKIP7ydzk36D/IaAeJ4sFfnaY69wGVy6O9Le6aInxFyO?=
 =?us-ascii?Q?9xHMxEClPCsmfnkBVkBhU5rDItb/1aZByPtKm7CGpMKVMYc3l+TlGE8MbH/8?=
 =?us-ascii?Q?ItVwjjVYCmbcmeEPJOqgrPq+2eTVunUGiqUEdD57vWw5REf1SPzKHNVAG32B?=
 =?us-ascii?Q?jZR1FWbAdkSDSnlioEBLSAgy/Wyn7xiSRdQt0GDoU0A5heFS+R6rzyOMP/IR?=
 =?us-ascii?Q?gC5HMXadrDn8mdLxN5GWIULRF0A4HBUZJXfMhXP3ga35YEYuld7KEyyd33Gl?=
 =?us-ascii?Q?Bn6Pu4xnGdsskywntiItC8Mso9p3JGEZiRjZTcm/6PzRudhSBx3HE+WEgwg5?=
 =?us-ascii?Q?V2m0/lyUC6dQv/rSFkI4vUpOLPTUCCA7EJKnmAza6uhVJV7ejhPbZUbYkRqv?=
 =?us-ascii?Q?umVqW8piee32Hsi1lTRbKs7Cu1XYss+XDMTm9hEvo+iQydkWmm12qulcJ+eA?=
 =?us-ascii?Q?YxJQ6GSEjN+OtJBDpOXh/ykF0H+MMX4qWkhZl2D7yepz1MtmNdbWT39l81JV?=
 =?us-ascii?Q?ji+NpLdtPwTDoxgsIcAIOJkwUvJLtoa5Qjrdyb4aJSMwGMDvzptfRSIWo+Wp?=
 =?us-ascii?Q?/Wxb2YVXBaNsv0ts82ktdGuK0IO55PPewCZKL4MiJr3aIsI9hfjVXQAUU5dw?=
 =?us-ascii?Q?YlNTyrlF+28TeMiCEh7S1NvQG05GVXbSCExlPK+rV39+IqS8bpDFP+VsKxXD?=
 =?us-ascii?Q?EzROwQrhIpi+fYMzGWigRfXlaZfgdwJnBZrVHhWEG+JjNwSPOxlJpit8/Xtk?=
 =?us-ascii?Q?lKES7z5sWgik/Wq/hNhoG6jaTEGFxvdW811wuy7n7jCem6ZHHpKI+ZEeDl9P?=
 =?us-ascii?Q?aCE9bcNUopVw1Qdc051LiyGXJFoZ0bCXFQrhsOhHziLgy7e59H2IjAO205Va?=
 =?us-ascii?Q?/opytm84/1Hd++mQZgYpAnWXqagC3Ye/41AmLa5HKLhSq8SxJV0IXUz+z91F?=
 =?us-ascii?Q?cEC6FqbxRRmEuCp8jOzdbZnsw4cwKt+VDnDosjWZFWSNwaEvKaPlCH5HxF+L?=
 =?us-ascii?Q?HwUKw/sXwPLQNKLaLFqw3pCj/obK0iAMd0a0Utc/nc49Eq74j6fVxq7657bY?=
 =?us-ascii?Q?GzJcD6ygFj+/trYztH9cbjzpRyBkD2vU/3NVFh5xs+4tNlk3BWq9oPbJ7hcg?=
 =?us-ascii?Q?xbA+FDu5blN5WCpVsi8exK96sorK0D32GpqWofMYd9Dc7jkIyRbSVCGjxfTh?=
 =?us-ascii?Q?A8Jt7HWUEYIdHwTIYNhXKytQSfh85Kk8ney6iHWDjQDlX+rOXb9MA7rWOA9t?=
 =?us-ascii?Q?CqqmBs+WfQYpYcvdAaxjvYxMqNAhCn0idvQcbMZ7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8e7ce7-dba4-4e28-88d8-08dde0c65f3d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:16.3919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Owp0OVdk1w/C6k4dxz69zRuv6I8fE9BejIMDxUsL8wyW56gBIgjHBayiT0PImlABJ5TFXkMkvSfflmg1Ics7kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

I'm unsure whether intentionate or not, but I think the (partially
observed) naming convention in this driver is that function prefixes
denote the earliest generation when a feature is available. In case of
aqr107_fill_interface_modes(), that means that the GLOBAL_CFG registers
are a Gen2 feature. Supporting evidence: the AQR105, a Gen1 PHY, does
not have these registers, thus the function is not named aqr105_*.

Based on this inferred naming scheme, I am proposing a refinement of
commit a7f3abcf6357 ("net: phy: aquantia: only poll GLOBAL_CFG regs on
aqr113, aqr113c and aqr115c") which introduced aqr113c_fill_interface_modes(),
suggesting this may be a Gen4 PHY feature.

The long-term goal is for aqr107_config_init() to tail-call
aqr107_fill_interface_modes(), such that the latter function is also
called by AQR107 itself, and many other PHY drivers. Currently it can't,
because aqr113c_config_init() calls aqr107_config_init() and then
aqr113c_fill_interface_modes(). So this would lead to a duplicate call
to aqr107_fill_interface_modes() for AQR113C.

Centralize the reading of GLOBAL_CFG registers in the AQR107 method, and
create a boolean, set to true by AQR113C, which tests whether waiting
for a non-zero value in the GLOBAL_CFG_100M register is necessary.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia.h      |  1 +
 drivers/net/phy/aquantia/aquantia_main.c | 41 ++++++++++++------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 0c78bfabace5..67ec6f7484af 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -178,6 +178,7 @@ struct aqr107_priv {
 	u64 sgmii_stats[AQR107_SGMII_STAT_SZ];
 	unsigned long leds_active_low;
 	unsigned long leds_active_high;
+	bool wait_on_global_cfg;
 };
 
 #if IS_REACHABLE(CONFIG_HWMON)
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 52facd318c83..b9b58c6ce686 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -991,9 +991,24 @@ static const u16 aqr_global_cfg_regs[] = {
 static int aqr107_fill_interface_modes(struct phy_device *phydev)
 {
 	unsigned long *possible = phydev->possible_interfaces;
+	struct aqr107_priv *priv = phydev->priv;
 	unsigned int serdes_mode, rate_adapt;
 	phy_interface_t interface;
-	int i, val;
+	int i, val, ret;
+
+	/* It's been observed on some models that - when coming out of suspend
+	 * - the FW signals that the PHY is ready but the GLOBAL_CFG registers
+	 * continue on returning zeroes for some time. Let's poll the 100M
+	 * register until it returns a real value as both 113c and 115c support
+	 * this mode.
+	 */
+	if (priv->wait_on_global_cfg) {
+		ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+						VEND1_GLOBAL_CFG_100M, val,
+						val != 0, 1000, 100000, false);
+		if (ret)
+			return ret;
+	}
 
 	/* Walk the media-speed configuration registers to determine which
 	 * host-side serdes modes may be used by the PHY depending on the
@@ -1042,25 +1057,6 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
 	return 0;
 }
 
-static int aqr113c_fill_interface_modes(struct phy_device *phydev)
-{
-	int val, ret;
-
-	/* It's been observed on some models that - when coming out of suspend
-	 * - the FW signals that the PHY is ready but the GLOBAL_CFG registers
-	 * continue on returning zeroes for some time. Let's poll the 100M
-	 * register until it returns a real value as both 113c and 115c support
-	 * this mode.
-	 */
-	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
-					VEND1_GLOBAL_CFG_100M, val, val != 0,
-					1000, 100000, false);
-	if (ret)
-		return ret;
-
-	return aqr107_fill_interface_modes(phydev);
-}
-
 static int aqr115c_get_features(struct phy_device *phydev)
 {
 	unsigned long *supported = phydev->supported;
@@ -1088,8 +1084,11 @@ static int aqr111_get_features(struct phy_device *phydev)
 
 static int aqr113c_config_init(struct phy_device *phydev)
 {
+	struct aqr107_priv *priv = phydev->priv;
 	int ret;
 
+	priv->wait_on_global_cfg = true;
+
 	ret = aqr107_config_init(phydev);
 	if (ret < 0)
 		return ret;
@@ -1103,7 +1102,7 @@ static int aqr113c_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return aqr113c_fill_interface_modes(phydev);
+	return aqr107_fill_interface_modes(phydev);
 }
 
 static int aqr107_probe(struct phy_device *phydev)
-- 
2.34.1


