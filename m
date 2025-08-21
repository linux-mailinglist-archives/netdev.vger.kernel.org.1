Return-Path: <netdev+bounces-215688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33E9B2FE3B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87C77BAF5A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A35296BC2;
	Thu, 21 Aug 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jdh+K39d"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369EB287276;
	Thu, 21 Aug 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789689; cv=fail; b=UQDwoYsdGyxlaroDzolDQyWgweB0m+P4SkykZ2a1VYVl3erjFVw3bbW/HGhckKXNrUawbxGKI0e+V8+9Am9s26LQ/6NRaufqod7LDE0u9QpXfr2a31MItiFSeE6JRG0u7CUVhNAGTkgEI0vBaubPNMB+n66atmaap/k8sueWwRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789689; c=relaxed/simple;
	bh=Yq6utMtqD2I7IoS25Kq6OcQhwqXwqVkdMSANFc9F8t4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qEOy4gpq1phHBd8YF7PxyXnErtPkBm6sZFA3iwl2IGV7vaz9wVEu3g2Ve7iWlINu/O2Iuv2spIN5DIo5vFewGX+ONHCPgBzlWeBIWYs+zqItoVepIrkFG7lFM3weNWBI3h7gVv0xd24IL+kRKv+FJYTNwP4WvSwQq8oYYAZ8qGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jdh+K39d; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vl7PiR1guB+U3KlMslnTwInaVMjAkWzyLWiKCQriuPpcjn6VDwSq/IhosAI2aXK3VMF91+EFehg9ItusGO7fssZqJuzfP79J7E3Xx/ba19WhhrQU+QrdYsH9mId7Zgk065nKpx4KJdep122JcwaxcqRzE8IYxEFrxq+JxKmxriKn/OXYre5wC2TXa+mmdDbz9rucDrshyE/lslLtRE/xnPvTZTUhlarv71vo5fVnbECEtWw1EyhALP4jjsNSFXAppAl7pT4bMQ82p8k3KfwBhjQosFkM6a4mAtHPtFvsrF4iUbR5XxTCEwMBD5f70aQGBCgVwOLRK5X9s3Wr9kdJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2iw7SVy6qReQ25eTwZv4nA5LhDvLopKvfQ6FFYsdTU=;
 b=pIjtEbpx5TD5HTMf8AdvMipqp0PvcitMAelrkNrQ/fvk0N2uNYGlOsxGFYFyLXY5Q87oxBVbGYWX89tsLHAaLtpv9VStcSFdEmidnz6BxIRPi45txSEQnMqqd1cLcz/RVPy1ig1qsMWgJZmeUL0zFnqB24LYqmcZxSP33QXCEkoe36KleNhyOKXIOuAm4E1WqGZHOnbeUfvGNhw0ujaDESwu4GOqw7prNL3zmfKUOgUSQeLnogcmy2h+/IfSIrzhKyICXOS+G9vjowQwkhQxUeySBERc1/zQoJYhvbbbkQSfo2CJ2g8cJyPSVOA+KbRFcnCDhyoJT4Nl0M517wWqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2iw7SVy6qReQ25eTwZv4nA5LhDvLopKvfQ6FFYsdTU=;
 b=jdh+K39dx2O2TcHK0Q0CD+sbbNnxGE5pN/KMtGf/RKSpIbQ1kKNQwlXZzS4kdwmwOuhcOuVqZvWPPWbIKX2f240rG0Vcvs/SQk4GTznAOZ0Yftrc/MSSBrPY2YhUtyRirGFqxnNAWfeDfRJPF679oxATODrWUGqUyZsupc2QHzRDwL6kYeZ02RhrhEw8BHSlmp9qNoydcF3J1L0Skk3fM1BckghJOLXTjLmo3A7wCdd4hvWfAEBkKwu6+KQ3tvvZoxIsyJB/22rgvIbR/ELldkEtJ2B2gfTQ65ScmGvO1yEWm4T/OId3qLsGJ3YxmGaOotIyN8qoJmqKqJO44k6fVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:19 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:19 +0000
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
Subject: [PATCH net-next 05/15] net: phy: aquantia: fill supported_interfaces for all aqr_gen2_config_init() callers
Date: Thu, 21 Aug 2025 18:20:12 +0300
Message-Id: <20250821152022.1065237-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 940e52e3-c65f-4572-8921-08dde0c6614e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?qr1MV68v0gy7rJjVXmB1qz2Y4ECH6ojzbAiL59ZmMXgUqrPX6JHKXw5tqn37?=
 =?us-ascii?Q?dQ8k7fhUkBwcCMPcJFA9eBfe4AT5JBZXj5Y6Gf+0u74nLxjv0x+7GbTv9cQu?=
 =?us-ascii?Q?bTCNaBZnaTqzl+OEo37CynfNbVbcA9F50zjN+Vid0jXjkbX0vwF+QTcEe1l5?=
 =?us-ascii?Q?VDzlZRJ2rlky4KMqjJ8hLmCkYqCG/U88a0NHU7DZaNd5RDQtu3mcJot57JDL?=
 =?us-ascii?Q?r6TUFoLdxt5fhTgNB3ESHnLnNzqQElcfbAw+zHgMb8Wq0RFtQma2I0U3oz2+?=
 =?us-ascii?Q?wM/A9YQ97Anka9gljWmii3Ehlya7+sQ5PTMZZkvJvXXCyz2GbvJZZk9thoxS?=
 =?us-ascii?Q?c9AO7geI+4wbZ4T7BaXsYhgRIXg9MIyLBlx0F3I+32L5GlIYRHNVQINg/iic?=
 =?us-ascii?Q?G0PUb5Oce9nzkO/TrWnEW9ZGh8Aln/xpDYXQF+LzdqUrbfu73/aHXjyZcpxM?=
 =?us-ascii?Q?jOC31uGKdKdMSdFv26nFLnr0yEY/rKBRA2Im3B5FJkMe/6SxIqyEJpzNlI5c?=
 =?us-ascii?Q?DIcBY8rF9KaonzkDOAEunh+1ABQaSMSpFlEKYz5e/kZz7wELJKx3VdHMRz9Y?=
 =?us-ascii?Q?ICZb25wtvMNF87SyAyjnC/hMa6iMKfCPz/Zt1y5PQQJPU7vqofDqKoI0qepI?=
 =?us-ascii?Q?bY1ZZyasPJNaJGyybwzFW4hOPkxhF+pj/qCxfQ4HmFl8saBrNv079IMJ1kpV?=
 =?us-ascii?Q?Gy+AG5lrwkVQCDzWk3ryS7bKXUkLRRtI54eBXPnq11Y/01DmUqr3L7G1yeEe?=
 =?us-ascii?Q?MXEfay/My5dxmmSMDnaeOI2jyJvtzE/9zp0oJvwAjl1Y37ZSGKyHA1iEMQmD?=
 =?us-ascii?Q?stKhaDZZGfe0keOGvbye1sNyBg0+Xwy0twqoUBif31HGy/icE2lN24DoB54T?=
 =?us-ascii?Q?t/U39wNUEvDWzK6os5xvwnq6GHWhm4jtFxPy2C/FW3+F9H4UJV1G9EMq/OwD?=
 =?us-ascii?Q?9Qa/yIcwFYurHwUY8gwAvXyw5TwS7IUAf5cwHqNFImOJyCQ61u0YI3d76dJH?=
 =?us-ascii?Q?42q0FeGPidSFT69pwabDerkZLfsSkURZKWuwe7K2pUqI9Ao2hpf3LGp2Pakp?=
 =?us-ascii?Q?MOBX0yaf/HGO0w1eGWAKpgn1cjtthw5sUSkdJC0mWkyE8hIEFQJpVtmGjhR7?=
 =?us-ascii?Q?6Ab2ccumDZMEquBc9BgCol5o94gIyga/7dDlNH5m+W5UOlSwF9LrPNo5gr2q?=
 =?us-ascii?Q?5gwjpVQyjxsuka580hwNfrxzEtltb4MhT27ansCKO1ef9txgR9j/nNYKGIaJ?=
 =?us-ascii?Q?P/Lle5kHC3BGADcjjSFUn2oXDZngqpPsHzkSGwrS+r2silyMeqjBxv5WjrPA?=
 =?us-ascii?Q?s4L5oySxq4JG1tyz1f1nSUz5h+ldsHcokpD/rHDgTtIXvEK2MAmh+pGs+9N/?=
 =?us-ascii?Q?860ziGjU/auc/IUtEJ5A2pYn/bcguZXfgvF9Tq27/yzokREFSNbWqFjwannb?=
 =?us-ascii?Q?5Ana5/VTW5a2BAkuFb/sGacWj1GiPJq6QO6IxJm5SGHm8BhxrL7GPg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Q5PKnzHXDdDx7SNn1ApGip2ttQcwNUENo9AWjkNwN4972vzpOUy+byKW1rXR?=
 =?us-ascii?Q?vHwlaSonR3oWRlutvb4t0yAFpV9EU9+5viJLior+8o5GCsBu0pkTWmxLu11x?=
 =?us-ascii?Q?ROnrDWWNReYFzrU6k+3jfM/V6u6biA9/e+AN1lq/N+JGW5MNTO/FDbSqwEiZ?=
 =?us-ascii?Q?zxIdGNAeCIgZOEuyRdeEnZHZPdv85RsPPPKoIlEPOeb9q9M0C1eYsHL9TmUy?=
 =?us-ascii?Q?ClM85eIjHzPKr7rMC3vnLqxLIdMQ8mCJGBARSWAM3j5Ez/XU8zRxMZNr8rKH?=
 =?us-ascii?Q?Ybk1ZqSGcVs31BIQg2+7Pw7AaZq5Qnb19hYnLTzJxfzx9HmODFnDR/NHzBuA?=
 =?us-ascii?Q?3WdezXo+tcUhy4WZsP+iWj1dSyjv9yanAkwjZtLVs1G1+FMxBIUqE+g87+rl?=
 =?us-ascii?Q?OWu0krKXzICfKHfcFHazdhTa6k3fCg2DaIvw1w4Rn1i7k8ry6f/hyVFa6wEp?=
 =?us-ascii?Q?zWy+56TKhHAfO3RUzHs2+fnCjmbu2BmwdpPxP/otTDWiB+dLfhc9RCH0oHV+?=
 =?us-ascii?Q?UhzhsbeVVUtDkyl+ePPj627FsMG8cXaW3774KiFxigZATS+NOlno+kse+lcy?=
 =?us-ascii?Q?z2lQmmIvWRlwogIya/CKuAc7NrlTZzQ2rApLPqwRrOmsB8cLfh9KRQSls9wl?=
 =?us-ascii?Q?PuQ6gQWWJmkmkwlPe1np//ssJ0keRv8w1dApDdHWT1OBwaJpl3QYMk/G4MWw?=
 =?us-ascii?Q?BZYwm/xQgUG2GimalU3mz/1p7cl3jn8Se1IRnNIRabdK0gXUqU6AtnNPg1b9?=
 =?us-ascii?Q?7HxleRbGAatVYAPgRW9FH+PsYC1wFLjTxuwpqShe2/6C8ZjfqONIuC1V8SNE?=
 =?us-ascii?Q?iBy6dL9MMf2I/5AxSoatPOTGariQo8D6mWsthz/s69gQoSbxCtBsEsKaOPyW?=
 =?us-ascii?Q?2Ia5k8gJ3M9Sz0Jb4bSmDKghOQJPQYPeX2SOz1S5QaYnhWR1JTv7XRh5LL/O?=
 =?us-ascii?Q?bkNTltWRWCUu/q3wCQpIbbsG0W5tTnobU+X+7Hr6XR7yOXvmChsFt5+47SfS?=
 =?us-ascii?Q?RtZv/MsmP9SSBRzRXr+h3o3g/yXh7owsNyPlv0VrdSKUEkMjVdxeKrEI0ooS?=
 =?us-ascii?Q?Qfip/pCE0xvksC3JxwXn45lb9UHazcSCU9rjwE/bAs12yMGrVwfyBSddaDM/?=
 =?us-ascii?Q?Ka0ULjjqo6V88C40Rdv2HpFS0RlMsnrOb/6k1Ex7syZ92SpjP0CTM1MKHRNR?=
 =?us-ascii?Q?UHF35PkqQ1ec72N1oRZSrlSf2N1izzDLCwXclNd+f9oMxfmnfzl2vAqaaKOo?=
 =?us-ascii?Q?DpNVL1FCcwaHjgFP2qnuqUwfNaModFqyawfRzCUdLg00gP2ssAZdYwDUioSw?=
 =?us-ascii?Q?yD9oYp7ZPXuYknmHHo5UvXvWpFKQMSR9CkbZYRCO0rT8uSeTY/zfrZiefH3D?=
 =?us-ascii?Q?5LNbzGQMbGROP9jS3OByaiInrki+oZ5IdanXOhZFAEKCmNaq3HiMw9bDjxof?=
 =?us-ascii?Q?iXZ7379Nqq8W7xtgwHasT8Q2w1iGAUR0F28/zGHA0A1VpF6DIeqkUQNaHUF4?=
 =?us-ascii?Q?QAj/US+ymu69Fh1cp2MX0oslJFH0mUuhE5qJLcqTUcUjZWMOBe0Z6/6yT6E2?=
 =?us-ascii?Q?EMsm0D0UkfT++u/WqLbaca8rOwFv/b1AjzA+oyYj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940e52e3-c65f-4572-8921-08dde0c6614e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:19.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zmcOJ8H6Dg4PVNsLW9HUgXu/upEwGLOiK1I7L4pUSy6EPrufoADGdrHKk/a4GxJ/uPM08JciuFdf6QxFCpoAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

Since aqr_gen2_config_init() and aqr_gen2_fill_interface_modes() refer to
the feature set common to the same generation, it means all callers of
aqr_gen2_config_init() also support the Global System Configuration
registers at addresses 1E.31B -> 1E.31F, and these should be read by the
driver to figure out the list of supported interfaces for phylink.

This affects the following PHYs supported by this driver:
- Gen2: AQR107
- Gen3: AQR111, AQR111B0
- Gen4: AQR114C, AQR813.

AQR113C, a Gen4 PHY, has unmodified logic after this change, because
currently, the aqr_gen2_fill_interface_modes() call is chained after
aqr_gen2_config_init(), and after this patch, it is tail-called from the
latter function, leading to the same code flow.

At the same time, move aqr_gen2_fill_interface_modes() upwards of its
new caller, aqr_gen2_config_init(), to avoid a forward declaration.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 168 ++++++++++++-----------
 1 file changed, 85 insertions(+), 83 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 8136f7843a37..21fdbda2a0e0 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -860,9 +860,93 @@ static int aqr_gen1_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static const u16 aqr_global_cfg_regs[] = {
+	VEND1_GLOBAL_CFG_10M,
+	VEND1_GLOBAL_CFG_100M,
+	VEND1_GLOBAL_CFG_1G,
+	VEND1_GLOBAL_CFG_2_5G,
+	VEND1_GLOBAL_CFG_5G,
+	VEND1_GLOBAL_CFG_10G,
+};
+
+static int aqr_gen2_fill_interface_modes(struct phy_device *phydev)
+{
+	unsigned long *possible = phydev->possible_interfaces;
+	struct aqr107_priv *priv = phydev->priv;
+	unsigned int serdes_mode, rate_adapt;
+	phy_interface_t interface;
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
+
+	/* Walk the media-speed configuration registers to determine which
+	 * host-side serdes modes may be used by the PHY depending on the
+	 * negotiated media speed.
+	 */
+	for (i = 0; i < ARRAY_SIZE(aqr_global_cfg_regs); i++) {
+		val = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				   aqr_global_cfg_regs[i]);
+		if (val < 0)
+			return val;
+
+		serdes_mode = FIELD_GET(VEND1_GLOBAL_CFG_SERDES_MODE, val);
+		rate_adapt = FIELD_GET(VEND1_GLOBAL_CFG_RATE_ADAPT, val);
+
+		switch (serdes_mode) {
+		case VEND1_GLOBAL_CFG_SERDES_MODE_XFI:
+			if (rate_adapt == VEND1_GLOBAL_CFG_RATE_ADAPT_USX)
+				interface = PHY_INTERFACE_MODE_USXGMII;
+			else
+				interface = PHY_INTERFACE_MODE_10GBASER;
+			break;
+
+		case VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G:
+			interface = PHY_INTERFACE_MODE_5GBASER;
+			break;
+
+		case VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII:
+			interface = PHY_INTERFACE_MODE_2500BASEX;
+			break;
+
+		case VEND1_GLOBAL_CFG_SERDES_MODE_SGMII:
+			interface = PHY_INTERFACE_MODE_SGMII;
+			break;
+
+		default:
+			phydev_warn(phydev, "unrecognised serdes mode %u\n",
+				    serdes_mode);
+			interface = PHY_INTERFACE_MODE_NA;
+			break;
+		}
+
+		if (interface != PHY_INTERFACE_MODE_NA)
+			__set_bit(interface, possible);
+	}
+
+	return 0;
+}
+
 static int aqr_gen2_config_init(struct phy_device *phydev)
 {
-	return aqr_gen1_config_init(phydev);
+	int ret;
+
+	ret = aqr_gen1_config_init(phydev);
+	if (ret)
+		return ret;
+
+	return aqr_gen2_fill_interface_modes(phydev);
 }
 
 static int aqcs109_config_init(struct phy_device *phydev)
@@ -984,84 +1068,6 @@ static int aqr_gen1_resume(struct phy_device *phydev)
 	return aqr_gen1_wait_processor_intensive_op(phydev);
 }
 
-static const u16 aqr_global_cfg_regs[] = {
-	VEND1_GLOBAL_CFG_10M,
-	VEND1_GLOBAL_CFG_100M,
-	VEND1_GLOBAL_CFG_1G,
-	VEND1_GLOBAL_CFG_2_5G,
-	VEND1_GLOBAL_CFG_5G,
-	VEND1_GLOBAL_CFG_10G
-};
-
-static int aqr_gen2_fill_interface_modes(struct phy_device *phydev)
-{
-	unsigned long *possible = phydev->possible_interfaces;
-	struct aqr107_priv *priv = phydev->priv;
-	unsigned int serdes_mode, rate_adapt;
-	phy_interface_t interface;
-	int i, val, ret;
-
-	/* It's been observed on some models that - when coming out of suspend
-	 * - the FW signals that the PHY is ready but the GLOBAL_CFG registers
-	 * continue on returning zeroes for some time. Let's poll the 100M
-	 * register until it returns a real value as both 113c and 115c support
-	 * this mode.
-	 */
-	if (priv->wait_on_global_cfg) {
-		ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
-						VEND1_GLOBAL_CFG_100M, val,
-						val != 0, 1000, 100000, false);
-		if (ret)
-			return ret;
-	}
-
-	/* Walk the media-speed configuration registers to determine which
-	 * host-side serdes modes may be used by the PHY depending on the
-	 * negotiated media speed.
-	 */
-	for (i = 0; i < ARRAY_SIZE(aqr_global_cfg_regs); i++) {
-		val = phy_read_mmd(phydev, MDIO_MMD_VEND1,
-				   aqr_global_cfg_regs[i]);
-		if (val < 0)
-			return val;
-
-		serdes_mode = FIELD_GET(VEND1_GLOBAL_CFG_SERDES_MODE, val);
-		rate_adapt = FIELD_GET(VEND1_GLOBAL_CFG_RATE_ADAPT, val);
-
-		switch (serdes_mode) {
-		case VEND1_GLOBAL_CFG_SERDES_MODE_XFI:
-			if (rate_adapt == VEND1_GLOBAL_CFG_RATE_ADAPT_USX)
-				interface = PHY_INTERFACE_MODE_USXGMII;
-			else
-				interface = PHY_INTERFACE_MODE_10GBASER;
-			break;
-
-		case VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G:
-			interface = PHY_INTERFACE_MODE_5GBASER;
-			break;
-
-		case VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII:
-			interface = PHY_INTERFACE_MODE_2500BASEX;
-			break;
-
-		case VEND1_GLOBAL_CFG_SERDES_MODE_SGMII:
-			interface = PHY_INTERFACE_MODE_SGMII;
-			break;
-
-		default:
-			phydev_warn(phydev, "unrecognised serdes mode %u\n",
-				    serdes_mode);
-			interface = PHY_INTERFACE_MODE_NA;
-			break;
-		}
-
-		if (interface != PHY_INTERFACE_MODE_NA)
-			__set_bit(interface, possible);
-	}
-
-	return 0;
-}
-
 static int aqr115c_get_features(struct phy_device *phydev)
 {
 	unsigned long *supported = phydev->supported;
@@ -1098,10 +1104,6 @@ static int aqr113c_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	ret = aqr_gen2_fill_interface_modes(phydev);
-	if (ret)
-		return ret;
-
 	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_TXDIS,
 				 MDIO_PMD_TXDIS_GLOBAL);
 	if (ret)
-- 
2.34.1


