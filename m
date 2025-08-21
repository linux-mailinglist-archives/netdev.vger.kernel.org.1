Return-Path: <netdev+bounces-215695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B2AB2FE6B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413C3A2043D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE243101B5;
	Thu, 21 Aug 2025 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SbYcpVrz"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9962FB608;
	Thu, 21 Aug 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789698; cv=fail; b=CKRZJjGkeGN0kRw7ZtAkMCTPF4zO0onGnse1ZguCJ9w291jSkKsLJp3G3Ycz2xhG+nsWHLnl9NwTaWRylyfxLCSIRpL7HmNJQUnalYZdbnEksHRG4CjWZXIOyahipPqGk1crqqiOvKLoIeiF4A5Is9710R4L9M71CNJFxZflrPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789698; c=relaxed/simple;
	bh=bUj7wFClVaLjqJ8szJ/DFY0SycrQUC8sT8CTaIVrlF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B1qHsM8kuu/4PkGBuYXDXfX/ww+IgsJ+HESXWv2mj5Y1KR6qNTLLS8i2PiRazZq3YMgAa40j8CAO6ihBY6Wv7ISu1oBIr6Jpki56PHO+Z6kmxoRqEFu2YfdqoYIB/2ktwheAldL8xWqHb6rIOLhE9w09kbf0cAATujklNOWKlAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SbYcpVrz; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxnppGkXNUAJatSrT1ctONRZb7DsA6gk66LRhgQWslPsHLZbdlIfM+risa22i1qW3gTdU0tKK2HIaRAdjaEoiGWGORfCxY0dyU0hI3O67cGOZh95ebrtFfOgooQZ2b8DIHdx/u5bA0j73piT72ehXqAMsfKvr4vPLasN3ZnPkYBT5vtOMZvgn4Fi12EKDiilJ2LFGjqqnvSLj/8TAwbaOt+7JdK2AEljSZcQpvz9/3gRdPrz3vHlD0kRbfIGs1Rpu1mRUFWai2NAvzZHP23HEudhl/lQ0uxEoeaaIe8ZdShA2MeaPW49D00Ixwmq0WFyFZ7DiGtxM80XzvJsD35jJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1YKUsdcrZPdL72/yY3W6BAUkRSX1B9zenVyrmq20Fs=;
 b=Z9RhtswDO+SOBIqgOieFNzBcI1zEGII2ookkWHojF36AB0nfaBJ0hhSbTKLSGmOjxmNZr9JTT5Z4LztPwkNzI6mQwmWe7MHv5ZvptNgvhPvQJM+9LDNNfNPSB+kYXQ+T6ptlG4FfZZidJhpnEXV5gM1C6vzggwtGjmInvOYKmyrO9Jlp4ehrtjMpXJF2KRUH+WNgh8HIAB58+yem+pymPyT53vzAeA8Opxx3X4a4BwQLXBAGEJ1yCrl3T46C9cT8X1Ks02M3LEP+W/3lU+dNGC5z7SX/vUZDjDvWGFMJ1ATLQU3QlQEen3OKw6j1pBPFZV5YDkHKr2Exou5YENnoAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1YKUsdcrZPdL72/yY3W6BAUkRSX1B9zenVyrmq20Fs=;
 b=SbYcpVrzvijvt2wa1UYkAsx0NFypuzi4FUM2tjMuhF6ZGAQTtbgKjydRtLg6nfhCduUwhh1nUYNuzCpuUjruXq/BuNqtVjOZYx7k6itI3SQcg/15vfLvf+PvOZdCTPRZ7xTyev/aulDrbehhOoOxRJU6sIuI7fC3izaTNMyKO0Jfc1t0xMDvHSPzQv2rvnBe9fBvMRdGeNX9B1eorbzVlrxdKu56rckfKVi6Ri2m93y9m3WXpbw0M1eTd3PB2OPJSkgh1fb0hBuFBG91mOwKhzi3zsT3fOYL4wVmBHDYMLs4Apy1dFHKtpVcyFvzIEqYejsgqrjEIKh9JCWT90LyyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:26 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:26 +0000
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
Subject: [PATCH net-next 11/15] net: phy: aquantia: call aqr_gen3_config_init() for AQR112 and AQR412(C)
Date: Thu, 21 Aug 2025 18:20:18 +0300
Message-Id: <20250821152022.1065237-12-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45bad044-b1ca-471c-b571-08dde0c6657e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?65ooBULETI2LB8MTms3+2SGoL3bmm0At5Fl2/dOPz1PrPLt9awiiVrYs+o1v?=
 =?us-ascii?Q?SPEm6ntN/9lL+mCH0L+FCwHfmTPweGP1/Bp3Sgun0lD/LLfTJAwuNzPraxjk?=
 =?us-ascii?Q?gxbXOlOpB8guMXOuRTV3SXRTH5+lg1tb26dOkv77rX28RQePkGoK/TVhj9VF?=
 =?us-ascii?Q?hIE0JLRfvmLkiIK666FbfrvIikNvEQuDFlA4Qfgetkw23WOp+EBkhqp0bTE3?=
 =?us-ascii?Q?kGDqshzMpSVOR4BuujIioVR/th4qkpoMu4H0QlXm6Y8Sw0QKMlYFGbUW7Sr1?=
 =?us-ascii?Q?9iMHyVUFgYusQHr7PmRheqFzAlopGWaUknXWiMSQu1h+ZASVumnvg6na0w5v?=
 =?us-ascii?Q?9suvdTAwcI9e8pocd3854vLVIMTRSoAKdYZVA+v/cC6jOQZ2otrBdpBE2fhj?=
 =?us-ascii?Q?uOYM9phrivvBiO062ssR5m70//AI6+e8plNSilp3PNrf26Ot4B4W4ZB3LLsZ?=
 =?us-ascii?Q?J33CbAlUVTbMBRo4KhkpWGw/dcCKW5VNYcUu90wTVyUXyuRgcd8uyz1rOfQF?=
 =?us-ascii?Q?L+1dV+2E/kqCa5wuYlvDRMd7jUEXyisnOn9qxGvTfyJPW4d0pN3M4POkRnIn?=
 =?us-ascii?Q?NMA3zYtmM1PuYqaGIuPOvFINkX+TKq0c9kS7iXGe7Vg5S7LYPyfv0wYp9Ezp?=
 =?us-ascii?Q?9egKHb6I0p7ORmdUsh500mLp99w6rZqcOUpwaYg00pNcjV0gxuU2znift0WF?=
 =?us-ascii?Q?NB4kgaKyCP3pS6bYAjf/LrtIuLzv0PlhSFSoQZgb5MGjb5blcAGO4Drq5+RI?=
 =?us-ascii?Q?AjzTsl36/M0oIV7oYtjg29CocDz19r+nbp29yZhs/Z/tzNtfNd3zh807Q084?=
 =?us-ascii?Q?mwUeu1CBFG8S1mwetMzlFT2YG5K1KWWSQMJ7qRTBVi/1e8sGxNC9EuCa+FyI?=
 =?us-ascii?Q?Cb36jNBcmFHw0Hw0D5D/3XcAA1ZzRXrdQv+qcyHlO0f+h+j2K79Fqftx36oV?=
 =?us-ascii?Q?CEhFFURopdegmyTHT941tCUxl1E5Uf7G75slYqlHJeJQBvd8Ew2HkCo48nuP?=
 =?us-ascii?Q?p7zU+ashwyIobCw1W0EwOQvhnxK+1Vp4cAmR6jY04pVnG/QJ0aXWMELKJgLL?=
 =?us-ascii?Q?Eyr8FXiYSMMeERMEDmmEigri7O8nTM1XrvxmEGhBKqMr8zF8TgP4eyyaBcLO?=
 =?us-ascii?Q?nwsAPS0pHOqrY2SHteCqFpEFVNgP6MmySGlBWRN4zObnPYbwLdZf4EdXQekN?=
 =?us-ascii?Q?vqiJewa6Pyfbjs4BxozLziFW4SxyssmgnY6rz8wswuWJRHvEHJzZknK8iMDZ?=
 =?us-ascii?Q?58NhGZ30cpxekylPXhXB4qACS5tNzPApNi0CcJp0IANW/AB3J/j4zoKw04Ip?=
 =?us-ascii?Q?8HQ86h3MF2jUvGJjo5Kljt8PJa0yNV7fKLKAoMgF8ma8FqVTqNptKlZaei10?=
 =?us-ascii?Q?S7y+AElW5aqSL2zmoWRMBUrl5Wo0LoXAkxBgc3pSkPZpiSt6kqARX/NIW9fZ?=
 =?us-ascii?Q?VyIE2Ic4wZk2gUZMWGRp+/JiVvid+z9ORMbt7CZRrYy7INeRP5Y/hw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Kw6Z+cA02BDjgtWiuNJf/W3AHV8aJ35J42ryVmdbP2alHNShIowCKqLxAZM0?=
 =?us-ascii?Q?ZyqgEdrbi24YvHlr74+mvZP6TETL1kAN6Ekvv6M+5JfFzPkI2XVg3AHK22fZ?=
 =?us-ascii?Q?fGSFKvq0aLnd7c7RDWj8pud2j3sbbUlMXi8ExyZdpDmEoIjRf7HxEkPHV7fj?=
 =?us-ascii?Q?u1ijINijz3hCF8hJ+5jT2iNMvj5zW+Y0s0qyHzvezdUVfmkGCpJ/TPkkpgwC?=
 =?us-ascii?Q?vMK1HTweVQK6fwqbCy26QatAdjkdwVJa9yHhz16wb9HG2aqTcVGGE/qi5mQO?=
 =?us-ascii?Q?UGij0ctnluVS0zGIOWqezf2MkP3fkXHiht3Rv37JEOrDlGVif8IhiKIwkjiJ?=
 =?us-ascii?Q?GY78qBkraMguJOyshA4TjWWhgYQU55AIrMlYniiASd71t5pwMgW/KBNy9hwK?=
 =?us-ascii?Q?uIhu1sBL/cLKtJXjh+3ujHvqqLqRflgKsPLlSEpMdRgxAe4RhLesoSF1QTlJ?=
 =?us-ascii?Q?5kQrM1Bifr1EyBhuy93neP3IfEKtWr/+Xu/M7ZR0skc/wMIOUgXgq5QK3V0Z?=
 =?us-ascii?Q?3gCKuh6cq2bAPk0z5OfZBCH+f9se4Q21b4jsUOxmS0BLUubL/b1lQX7IJ73X?=
 =?us-ascii?Q?146NroqampWDps2oLThpvJZnP0xEB0/ugaeyGd7ITFU2UtU5Hk127KtcFxMP?=
 =?us-ascii?Q?jQCgfsXkPi1TQ5XysoDSrAeZ6Xy4D5FabO7+43SXgFHz46YpeJPEcaGoXRki?=
 =?us-ascii?Q?P02wrXdrKA+258Tz7W/wYXqqJANSSPzeXaFsuZoUY2J5cKCPe4+vqxewwnGb?=
 =?us-ascii?Q?+iiRZ6WaeT87q56RlFsrhL3JUtb34IheqOYBgDQqbwxklBXrL8E8C644nv0c?=
 =?us-ascii?Q?8s11ZDWjRz9HbLvEL19O/7NjjRo6WISpgBBClj1X+kyjgB0sUrYXTLwCR+Jy?=
 =?us-ascii?Q?vRVj/iBhYmRypfH1UbNYjnUzW3eXH0gCranD0YqrJO/7zqab+iTi1xpGU4RM?=
 =?us-ascii?Q?0qB46G9YwYZpp9fwS16EniSZFEGySiqj4e8fngxw6ZZ3UsuomreC3Iw8ZTiV?=
 =?us-ascii?Q?TEoN+V7cO5v5gvWPoq2tbVe0MBdhGclHtFFzw314CdM6j1tNTZ+/xu60uigg?=
 =?us-ascii?Q?+GZGrPzE7SUyJ1oSzzLDpUcxvZKT+6HY8wgy+MWFF0BHc7Ptaof9Jc99V1r6?=
 =?us-ascii?Q?JwIZCuit1q/lsr6AcUFJvkmKku921DmvioGvtjWmXWQ0pQKtY9ZwoKEPB4t9?=
 =?us-ascii?Q?9z7JY5SLEwn0xzH2NHPPF4WggxEs+gnJL8wcbqeCq0C5FjRrCXc78ihFwHQw?=
 =?us-ascii?Q?S3eLvENXN9sB3KhxjDmFc2wfXk2D0hTwe/FwR7uIYURMPVqHy/U3w+wPv3OZ?=
 =?us-ascii?Q?5lSt3125wVJuviyAYxqSijFqWn9affgpHmiKXjsBsw34UNdNlpddJw20eLua?=
 =?us-ascii?Q?+6PDFVKUFNML1fsFKuwoKyKhHY4nycQNYJ9MSxunzKPWHjxaLVlwCpr355+B?=
 =?us-ascii?Q?uQoFWZyAukRP0GxurMs0YV/dI13FN2FJirbOoBykNjetu5E67qL/7U8aLc7f?=
 =?us-ascii?Q?6ih2XJNgyMA1EC6LlbdZbh6ItyrVOu8YDXAhrw03WOnLdePicEDZtxRSXouU?=
 =?us-ascii?Q?0KINQU4y6T+Dhu7ooAOXht9jceP87dSeedAOHnun?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bad044-b1ca-471c-b571-08dde0c6657e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:26.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTa/mBybEZixsBtQR6VHCxbxd5+378p8KwAhtBRZ/LgSpkia3dwIjcco7i5Imn27qPCpA6P5KO/eV3YNHBrijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

The AQrate Gen3 PHYs are AQR111(C), AQR112(C), and their multi-port
variants, like AQR411(C), AQR412(C).

Currently, AQR112, AQR412 and AQR412C are Gen3 PHYs supported by the
driver which have no config_init() implementation. I have hardware and
documentation that confirms they are compatible with the operations done
in aqr_gen2_config_init(), a Gen2-level function.

This is needed as a preparation for reading cached registers in
aqr_gen2_read_status(), which is a function that these PHYs already call.
The initial reading is done from:

aqr_gen2_config_init()
-> aqr_gen2_fill_interface_modes()
   -> aqr_gen2_read_global_syscfg()

thus the need for them to also call aqr_gen2_config_init(), in order for
the cached register values to be available.

In expectation of Gen3-specific features, introduce aqr_gen3_config_init()
which calls aqr_gen2_config_init(). Also modify the AQR111 silicon
variants to call their generation-appropriate init function. No
functional change for these, hence the minor mention.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index a7b1862e8a26..00bfbea81b8b 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -886,6 +886,11 @@ static int aqr_gen2_config_init(struct phy_device *phydev)
 	return aqr_gen2_fill_interface_modes(phydev);
 }
 
+static int aqr_gen3_config_init(struct phy_device *phydev)
+{
+	return aqr_gen2_config_init(phydev);
+}
+
 static int aqcs109_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -1161,7 +1166,7 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR111",
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr_gen2_get_rate_matching,
-	.config_init	= aqr_gen2_config_init,
+	.config_init	= aqr_gen3_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -1186,7 +1191,7 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR111B0",
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr_gen2_get_rate_matching,
-	.config_init	= aqr_gen2_config_init,
+	.config_init	= aqr_gen3_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -1218,6 +1223,7 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR112),
 	.name		= "Aquantia AQR112",
 	.probe		= aqr107_probe,
+	.config_init	= aqr_gen3_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -1241,6 +1247,7 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR412),
 	.name		= "Aquantia AQR412",
 	.probe		= aqr107_probe,
+	.config_init	= aqr_gen3_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -1259,6 +1266,7 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR412C),
 	.name		= "Aquantia AQR412C",
 	.probe		= aqr107_probe,
+	.config_init	= aqr_gen3_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-- 
2.34.1


