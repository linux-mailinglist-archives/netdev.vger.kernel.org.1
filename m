Return-Path: <netdev+bounces-215697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32385B2FE6E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD0D3B358F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FDC334378;
	Thu, 21 Aug 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JuuZCyyb"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480F310647;
	Thu, 21 Aug 2025 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789700; cv=fail; b=uBprRGXJWmjXfyq1Fa9dKCb9m8prZ1uElS2uSXW0qUzxzTQMmu1cpFsG20j9Kb/NgbigJzQ00CEzicJP4cR3neq8vnYqs0+mBCBkwf3EYfB7S/XuR7zbLmm/nl3kAMJGiggKErWBrAlsRIhseeuY5p9hKtXBFpTxy3y80XJSLFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789700; c=relaxed/simple;
	bh=JQOk6grKQUCErTJeda2e+z6K+YmuN30bjO8vtxJ7KWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d1ekjKNKTt3sBjRuGfkVQeh0cfjMryrc0+vPjxVDXdfjMXRKstPMyYtYJl8B7sduGgjHJuP0L4wDUoy6NJyB+z1ixqUql5J0AZkX63Na6nGKC0TVcHonXgKXhiwsiILmxgHq+H7x0LaiCEdlifLoHuj+ydR+9v0+1eArrrtaWXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JuuZCyyb; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ui25R2CU+1K8PCI9tT11QipGfGJC0rk+2vCCutriHsCgc35AFBGScGGfWaorMpSN8Y8NwAz9+lZW/V5shf+E3n74Y5AERW4P3SNX0gLe3IJO9Osij82s9WN7vh1sdhdCROPgL670V2UcJIFWbxfKOq92j/TbWRGLS72kNwFaB3Oxvyifq35OSAaIWoHSLiP3x7Hrlvz5ufUGnO5yLjzy+krXfmZGcfmVwwtZxvPbfAwy8vlGS8xITtjenSzVQj9Ddhgwek7eB64v38piJeyW2dwk4et+8RDrHLFyGKSQlcNxQ2FneypHN2sg7VHCKGpXIVMXh88+AVAdXpF3ZzOolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSXRj14BPSNOGu+FkY/+il8M77lUqFZJIy2F3oRUTwE=;
 b=UeTLr3e+wcw/RtvjYMkCE2ucGPWokwHqgo/QIm36u8qYwFnB5HVFpP1O8kxObhOHRbLtJcD3g8wxb6fsyTCY8mOjABkd6zSv6NjeQDDY5uXLKnx/KAteOvD9Y4ttVLs7DyddPaYZ0o8Z+9mgy+v0gnLrzWPRDUmfn91dtpVR63pinnttESoklW1rUytBsA7C0b545opVZ/QefnojrSg7o7gI/ZF8jivY5H1zOdUpS1EF+DjDHDJbUO8qbrBwS//VljD9VlYboM+WrcvNJGahUYt0uNiPJHUNrFhvZvcLqb5a/e9JCjSDdTWxTRIss5Sz2tPpgkYHa4nZuYMQ+n3Mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSXRj14BPSNOGu+FkY/+il8M77lUqFZJIy2F3oRUTwE=;
 b=JuuZCyybGDmrsS2f5Lno5FIjVgAkmoMa+Ig3bKdTBipqfx9522armkKYapBEBVnlT14QWjkr7de1gRJ/Bjfuhq6B+7FkB0cOlwBYz6eALXu+qxz8q8cuAgsjizC/f1oll9gMZiIUFoz3KoTBkUJEhxYBnTVQYlVhPULPtFm4xurxwLe94ibpp6uttUXyy+VpVkSTuqXuRw9+5lYcRcUMs4sk7MnE+Op6nqz9uq3nz5hM84v6Ca5ny4PrCtLh5VSHXt7DaGlpu31LxA987e7uRXk81+1Tso/XJgNUi2Kl21ien4XaE+OEOoWb6cBnHQekeljscbmpwYG8aQ0O9uhNLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:28 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:28 +0000
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
Subject: [PATCH net-next 12/15] net: phy: aquantia: reimplement aqcs109_config_init() as aqr_gen2_config_init()
Date: Thu, 21 Aug 2025 18:20:19 +0300
Message-Id: <20250821152022.1065237-13-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3cf13d42-3b92-4953-6680-08dde0c6662c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?PJ3vIDwUVf5kgmAbJN3xEf9iEthFRRXmfVjukiGyQniFYZqLCEPbbP+VboOU?=
 =?us-ascii?Q?5A+N11t+LfVpRiBTzmx4GGacwIOkr1Rvr0PA74RhwqIhjdVS3A4Zvj7wR8E/?=
 =?us-ascii?Q?eg+XdBg3w+G83lhMuA2QP0GRtHR6/8ss6QSP1jeCBG4x4wnaeLB54nf1Kor1?=
 =?us-ascii?Q?BbJDGgs+mle/yMeTgFSwYB2X9k+Zq8xtfpeQ/lnM2nxt8dtQwTlExersrgaF?=
 =?us-ascii?Q?qjsMF4NFzuPTqYy2lyK8Pg0muznvgeFnkNNWuMF7QbHsncd+0s0j27AFrGhy?=
 =?us-ascii?Q?FnvrW1BhyahqRCQMBjYe0pBkiSKQC2loDxXt92GRVcrotkpFqPYry7Gz5+Ny?=
 =?us-ascii?Q?JlTB4ke6TRLFRgNtREUWdL3Z2ZEw5dxq13K9p6tVfyfgigW0AV2M0KCyuJkn?=
 =?us-ascii?Q?MsohLBjOF+DFndS6ais0El49n18P/0qZwyQLP/xVDP8Epx83uUwti/wP/e4e?=
 =?us-ascii?Q?asccl9wvXnDbRxN3aU7p9YTzMqRhPBhkMFRZkT7RCS2fo11/Q6D6karKKEvJ?=
 =?us-ascii?Q?4BSQUTb43N87yxktSdH2qVTh4iowym4d+zyQL6Wy059YOxQexdyyyckmDIRz?=
 =?us-ascii?Q?nAv6KQZOvSCKUxxUYQ0G0UDJl/ZDLuRNrL3EFccegxxCwVvyZ7SK8jgqMekw?=
 =?us-ascii?Q?JjNgGhPyGm8dLS5sLGeKa31KpJVJgEL4wTt5yxxvbh186hFJAnhwmq9YSlht?=
 =?us-ascii?Q?tlZy6O99dNl/o2nAKow0Fpukme0Yhu9AKufSPlyP0Ysz+yX9PmhOq6hw57Tn?=
 =?us-ascii?Q?2L1XPx+d5heA1p+Xcq645Tb8Hl5rX7KmBZfAJWL9tSald5kiFSw+jnrLVzRV?=
 =?us-ascii?Q?m5mhkewdYmuI3tE0+tB4ainmcCV8AuToOHjwOyQzEws8yUnoXKzCkHr+XJYD?=
 =?us-ascii?Q?/wCG6oPXUS7K1f5pGhduFgCf01sRcH/my46zvFW7BhSWaj0bFaMNpXBW+w9z?=
 =?us-ascii?Q?+upxtmuKVZbVdBL/aQW6SI/uh33YiW4WpquxG+IHodT+jJbxUVtaiyP7OYnK?=
 =?us-ascii?Q?uo8/oAxJc1haSroP8amMSikEow7YhAUWf2+J19cZLvtQV7Je0NNsiCNmTm+U?=
 =?us-ascii?Q?kezdcUS0kqSjGtOtNOLNIwAqS2YEv3zC/grqV0bz3QhQ0JlLXMalRsWxzfl2?=
 =?us-ascii?Q?hmNfZY3R+Pc/Rx7aSATcLScGXBV1oVkXPHZJn9OQpPP+j1mziW+ws0HCajvv?=
 =?us-ascii?Q?mHzJ6sJrqTPU5g+uNrj3pP/tScZivs0BI0tuKyHgd9EDCZL5t6xGSl3sZkpx?=
 =?us-ascii?Q?PPsAKVq+DwFW/jKQn8As6iq2rQ7T69kjllFRlY7h54TTlQashyiD0m+dPzfb?=
 =?us-ascii?Q?iY4q2CzgaVn3DAaDNSeWlz73rg4VMi7D21aieUF71FZH3zJJhSK/GhrOLk6+?=
 =?us-ascii?Q?h4Yq7kVwOX77VxXu08moGyqeMWZiZmY8iCnbjE01XkiFubNqmSRj39uisCfQ?=
 =?us-ascii?Q?52VLHzvfRfumf3hH+cQjCDNabQjzI5pGns4nZ7dvQVjsMwrfVYnZHg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?AVtJgg9+Q61coIiyT/Iq3tm5HIfeQfjylWIDGXdlTrT3EYqWOcwegkwIwSSS?=
 =?us-ascii?Q?QD7if9EFp+i3dBQtMqic9siutoESwdjoAoXPS8yM3qlYaE7dIEsQLzk3E6eV?=
 =?us-ascii?Q?uT+q2CIN9CEaurYIz+qxP+39kyeG+EyMx1l0IQzBPmOgZr9EYMroVRqHStDc?=
 =?us-ascii?Q?gnt/yhobSlB6xQgEWaY96morrKX7Qq0iLCNsRr8W2PI6cCV2xJdG6TCP47jQ?=
 =?us-ascii?Q?pMyij2gxy8ysc0FWMAEgAmdvAV8XutVS3YtV64xaW8DLOyaby+ZF90dNoOC5?=
 =?us-ascii?Q?lmDdRoCCEopsgfi2XfrOqiFpaA/9iou7lu5toq4iwgWregc4LKvspeSnjaDs?=
 =?us-ascii?Q?5P72TQVsMGak5YxCksT4TbcSspMGwGna+3MX4rQP9i3jjeRpud4Y2YhiaxtB?=
 =?us-ascii?Q?bKt9z6JiZgT2cGPbeTrQZTYtcVNIiVQhkf4gZqm1PCOmBO9/PXW/g8btiNGW?=
 =?us-ascii?Q?5Va6yUIZDPx0YJXSjZxzjYPkexlRfaxtgGj1evRQIcGhM8kEVUee4hkNaprX?=
 =?us-ascii?Q?vzlrJDIfxPMGZizNx5OTfjTQYWratU36hAIUj2D3K3l6DKkDQOuuahYkUU4d?=
 =?us-ascii?Q?FNs1/elkNskWC3szN0h/brcPKMsL8r8vdlJ6uGUwjjZjNhLt9/unqMuvnibB?=
 =?us-ascii?Q?p5MfemmevjuDa/5JskOIM619uRHS39nO2NdJuLI73ev0/1YgHxqdpaLuTdqV?=
 =?us-ascii?Q?eQCEI8N1O31mC+yzNy6O7Wkv/sf1Nni4bVDSypmloQEK6KQW4sA5iu3q14hq?=
 =?us-ascii?Q?y4itXzT8vVAdU1inmOFzsUekGOE8VwOmwR/dsqDENSPTjVtHb5SM6SHWYvO9?=
 =?us-ascii?Q?JwkcTy3wWy7hULJpg+SV18CnCj0P+9MIA1SNUbKH2b9ABv+JKlj+Q7OSOhdK?=
 =?us-ascii?Q?xP/gGjbZPoDyyG1fh2mv4RIqbZK3fzQV2ocS1bO/Of3uSegRoh7vWPVTVRFg?=
 =?us-ascii?Q?aKsojJ3UaLh5o2pJWL4snSzk1n3xbkq2nZrLljEbdHGlIT+qRruCBjAGH+rG?=
 =?us-ascii?Q?gbBlvawR4ORomsDFTR45tAteznWR7jc4G3Ca4jgTS7mUGLLDVGBn8J8IPPor?=
 =?us-ascii?Q?vPrUQqh/x6s5F/gGVI8w37Y0hXvPWM98FVsnfQuKz7UXW1vRSnEH0kfW74RI?=
 =?us-ascii?Q?JeTWGNeqdX8q0fC3H3Xnq9AFKAoUkfWZJoZU1zkmdJKpLaJAmp/10zrPP7Dz?=
 =?us-ascii?Q?/r92jLxlLILs8n559fT7Cw6bOV2bg1tx6OsvxaFGkLldGsdUUZk4OhplmyRY?=
 =?us-ascii?Q?polEd0ROFjDllySYeM3sEcfDYCEODsp9R6iKwveCxkjQ1Utcl72shbS4Uw5L?=
 =?us-ascii?Q?aTx9LJifcb1GQjQV085iT2YhrJkFfNTT1N3m36AfknyyDEX0WO+yZuc5HTpM?=
 =?us-ascii?Q?RH9Eq23kTo+ki2fKqRfr0XIQSyZALNAQtMhryPg/5Jjwm+R1KpbiZyH0GW9W?=
 =?us-ascii?Q?0zcuLOSzp0PoM21umfYtgxNWZAquOydk5FfBZhD6kwYhm0Hu0nDyWnHFokUf?=
 =?us-ascii?Q?BijrnWzj6W8iWRXyx2a/HU+M8+4KRXjW7S1/OuGEkirgvb71P6vVywndv+Ar?=
 =?us-ascii?Q?jbA8CnQ2yqWJUQcxwVPPB6Loa+Jmabkb9dqjr42W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf13d42-3b92-4953-6680-08dde0c6662c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:28.0395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g70xnCJRoyMPDseo4UAZvfrnS+JikPvA6+1FtIWktlKSKc9fm4089KXQEPW+eT/2brYK0NFQ9YEITLhFwHctFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

I lack documentation for AQCS109, but from commit 99c864667c9f ("net:
phy: aquantia: add support for AQCS109"), it is known that "From
software point of view, it should be almost equivalent to AQR107."

Based on further conjecture of the device numbering scheme, I am
treating it as similar to AQR109 (a Gen2 PHY capable of to 2.5G).

Its current instructions are also present in other init sequences as
below:
- aqr_wait_reset_complete() ... aqr107_chip_info() as well as
  aqr107_set_downshift() are in aqr_gen1_config_init()
- aqr_gen2_fill_interface_modes() is in aqr_gen2_config_init()

So it would be good to centralize this implementation by just calling
aqr_gen2_config_init().

In practice this completes support for the following features, which are
present on AQR109 already:
- Potentially reverse MDI lane order via "marvell,mdi-cfg-order"
- Restore polarity of active-high and active-low LEDs after reset.

Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 00bfbea81b8b..52d434283a32 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -893,22 +893,12 @@ static int aqr_gen3_config_init(struct phy_device *phydev)
 
 static int aqcs109_config_init(struct phy_device *phydev)
 {
-	int ret;
-
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
 	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX)
 		return -ENODEV;
 
-	ret = aqr_wait_reset_complete(phydev);
-	if (!ret)
-		aqr107_chip_info(phydev);
-
-	ret = aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
-	if (ret)
-		return ret;
-
-	return aqr_gen2_fill_interface_modes(phydev);
+	return aqr_gen2_config_init(phydev);
 }
 
 static void aqr107_link_change_notify(struct phy_device *phydev)
-- 
2.34.1


