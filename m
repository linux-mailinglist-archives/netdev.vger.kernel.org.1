Return-Path: <netdev+bounces-195170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C485ACEA26
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 08:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE7B7A1B4F
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 06:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7961F1531;
	Thu,  5 Jun 2025 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ID9Cm/NL"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590581EF0B0;
	Thu,  5 Jun 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749104930; cv=fail; b=aN2JbuJ09Ya6m/q75UHDEDukrSqn5gdoxZ0UOJXR9Empb8VSlD1+/W0epy2lz9KgAKJ2PiPk5iqi15/qik8jSlfT89B2OP1a3F4/TosPR9je6ceAHASWmJKzrS1CmtoMB+k4xtvzxaYqiDGIZg86UPZHOO9NL/wkmfn4QUK4/ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749104930; c=relaxed/simple;
	bh=JD0zAGL+Z1cBfSIqB7f0bhPiJD/EDf1C7QgzbyEGbxY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TXk/em2SOO21MC2AxD7Dr54WgcKvwrtrgNAN7EpaX8nIYlEO9ohfTWm8RWRAt9ty2h/9nDGZ17nOuIqwdroN8gAeMSdrmqSsLkLHkdyPthj4SP0K8v/baafBfRTiVxUO1bHLRDJA9fybxBxT4ZjnCAo0JF62FVHpjdv+0Y0FYnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ID9Cm/NL; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs7h1iM0SDBNZyK+z7NlKVD7xg1JOH4XinPBACrLIrSQCSx/AzhqMDyyCtL6AWoGFI7RcemtqJhRYYtoLbRMmJwYdm2GkYMXIBUezmiCj7VWuyCRxqi/HB+jIXlaiXMIqIe1LM6b+Ja5KunBAMGZBr1tg9O9k8URSYZq0aEb1TsWfZgdUBlSI+16N0F7a5TYS5TI2KxIblJtHjrDPWJD1dMFP7a2AL3qzL+EI583dAZRQtPdXlwfMSFISzBpVolyzwKM8oUsI8gCDWEvTkMYEPUJT/JgP3+26mmipypeNjAyEJksN4EYjXIeIhebXEwPBQYx07nSq2eX96axd9tukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX9xU39AsB4lAe0XedJ/qZ/XCEBpWViT2cTzEuYmLLg=;
 b=eBKLFqXI+dnuRSQgBxW+GYICA7DC1uGL9RU2w/zmYIJAbkkRz26wkGX9093UiYb7giqrl/3izhq5wInDjs2JeuA2R5qxe+tsRMV4Ixbcr6x+XlReme/rukufef97MBkbS2iT9nwBmnuz4VOw9gKUUMsh+bPodidpYgAuW/p4OqwiQrP40MAbVbyiUPlZDjT0DesqNWonUsq/4UBoXUUSEZCyro6vb6LV9j5PktwCVjk6uCcRUq1BKvRptk762f+9PcB9cgJ4BeU2KHXxd3UudhUPh9ti5AGBoPoNTzEN6w0tp/SU0VmhzG3kdPK8H739Pofjy1CjkaFFeX/Nx4VLHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX9xU39AsB4lAe0XedJ/qZ/XCEBpWViT2cTzEuYmLLg=;
 b=ID9Cm/NLx0IBEjlI243ypdmUYtJjFpV6thGAe1+7AntJC1QJr3TPArUUkc55yYwlHxY9bR3AAW/x/zUp3NvU0NompRWmpLR4h5XDsHS4mqtljyopBc4Ja3mB1tRFnjYoV0cpVv08mL40ize0MQ3Hm/pM7el619wYarYchxQd3K1hmLN+rz4W+vcneykBh+J/TuXtlBQhJ2fk758WVVJBfTurYHFKhHzl2k5Papftb2GycbWXrfovf05QRPdqg2WLQliWskMJ7ZXsq12xw0lcFQ8jEGRXoaaLX5tanIkAber81Y4cInS4V2qzQ8u6+DCnsoNxyZ3BorQaxA3azYMZXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7529.eurprd04.prod.outlook.com (2603:10a6:10:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Thu, 5 Jun
 2025 06:28:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 06:28:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	arnd@kernel.org
Subject: [PATCH v2] net: enetc: fix the netc-lib driver build dependency
Date: Thu,  5 Jun 2025 14:08:36 +0800
Message-Id: <20250605060836.4087745-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ac3af1-d3b3-4a18-c427-08dda3fa3906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DiVfYKXYTMA+RuuyoBn17fFqAzqoNbRqhYjk7ij9ebISTTYowTkKXQAWoq0/?=
 =?us-ascii?Q?e6B7p7XtyFMDm5BSdyQtlBBXXDfaPzsWtKwFo1MAJGG+163JxrTv+7cw2J5t?=
 =?us-ascii?Q?8aL6i5Mz55rJul3BPYmg6lMAfcoVa3xogeeqx1Y//Y0rwXxt0T2XkUqhDDV3?=
 =?us-ascii?Q?Qor7TjXGH2/YA+5YJTGmiixixUQ5mHnACpDgDb4i1iQPT66P1oynrayQ6Ynh?=
 =?us-ascii?Q?1/j0JWi9RpWbV1vJ8e/PmBzkloJjd0SvlmJxvZC5eAzmaNk2dhEgPG72Nfnx?=
 =?us-ascii?Q?xGmxpM10aRY7vWEiTvdtBNFUDw4KbLSWlfR0ATv6mAHH47wSKj6V+2UmMI8b?=
 =?us-ascii?Q?HWs1687mPrrluKsPYXD0Wbs29Pw9qbFyjX+i1Nbi50v5buvfg+wX7874h7+W?=
 =?us-ascii?Q?iRe14CHF0hNpNAb8Q2+c0R6PZCsxaSouwnsQwBhvoRfopoEKz4Cw4v29s+9/?=
 =?us-ascii?Q?LfjZgblyyL4F59/AiutR4uwF+ulPxtZ1yb6pdkEanGpICz+Zexe+EhxSwY8b?=
 =?us-ascii?Q?cxH9G28BFZ5xhaFouySfUSEf9cS6svJtkFQhL8tpMlY4kjLGyHarQK9LfeDh?=
 =?us-ascii?Q?W59wwgZbfJ8rN8VM7ADg45ukIsGA0xwhjvLXpc01/pexfNCk31/lFkXa++l3?=
 =?us-ascii?Q?08TgSrJieu3fW26k5yG5mtGsVVwTQN2+WiIZsgUYs5Yi75tUUkIW331REpOe?=
 =?us-ascii?Q?87HG295/RdxtKxzOfSgbFNCSHIRGMvbuSUG8rHc+nEitNeXyqH88RZuawvTb?=
 =?us-ascii?Q?0DgDbxXAv/2HQZr8nMAaiA3SZLKA+xbi3O4a24uLJXGZ03tMkNQFXwnY6a05?=
 =?us-ascii?Q?hHWY9hNGqt0wQ/K//gHpYb8erDDzYlaOmpeU/nxZ0xBwYrhq+isyc7VTaeVo?=
 =?us-ascii?Q?zVeBYVLP5z2YNmkN+izQ6XZLHk4l5dxMuCukDChhx3u/eGWzm0h058Ppy5za?=
 =?us-ascii?Q?0DuVLIxKknO7rGWnYO/ISkVIxkQ2vCvfhH9CJNz1ebqgnktqoBAot5Kk9rfk?=
 =?us-ascii?Q?6V/qVgVtWM/hfOwHdjKn6i1QnE2HumM9sf1+BtaoImTd+0DUUlxUYgGydnn4?=
 =?us-ascii?Q?9XsZiZPjhI7rEM6G/yuzIWAd0RjMOqLGTLE79tGOCrt+MQDpoSpgoDigqPya?=
 =?us-ascii?Q?OFNxMEPim2sBG1YEfoRkPDrr3WV9OUcBA9hwdFm2WNdn11kG/tyj5aimmONJ?=
 =?us-ascii?Q?/ru3n2nxwHuWczdNRA4WMS/XkjP2oGv4WD+TxXomqr2dmWOKqHjoR7UmFT3p?=
 =?us-ascii?Q?04XE/nvxvpUJeHGYKOwtn34fY5ylKfIVElNNGfn/RIoMa7uzn/a51hylZVLM?=
 =?us-ascii?Q?zahRLEeW674NCYsBIg5+2utRBk9EIukatgZ0hGGOaxoRuBdVHpVfbInQV+0M?=
 =?us-ascii?Q?gSPByyinOo4OcNjJBoAv8oHi83zYjDhRJ83RsBOZJMELAmycUSXeYLYqy5fW?=
 =?us-ascii?Q?p7ccVwRhXDqHzgmGI3kOy7T9uJyanlU2kbuRedIdPSV/S3YjdEYcKY+9UQ1P?=
 =?us-ascii?Q?B3PkryDJzwFE6x0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0OrGomTZi+Zaj1vc1FiFEd4wPX58XzIPWhiRLl2uOtlNudMufM2NjyDbMqfl?=
 =?us-ascii?Q?IJdNmI9P3pCA3h5vieHx3nVpgSflw+tLPyyOrJOxpoa5DhRBhC+ulIYu4jZS?=
 =?us-ascii?Q?FM4u3sIN6yRrOTJtlWhyQYxNf7DGiPt2LqNhGH9pM9pTUSzISczc2CGZKPGV?=
 =?us-ascii?Q?+5SmwLeMZjBO7mPHqGbdBvAJnsLe6quJ0ef099mzMAfjqWKZAFdtTNzl9OOS?=
 =?us-ascii?Q?LTY6jaELAoLz8EVcmd9Z4PgRCcUo3/3r5ikQy8ntJQ2DiW2IW/PcR2ptiGEw?=
 =?us-ascii?Q?Ve0gWTvWhg8S2CLjJECICSj/4DD/sm0KLJiV0SgpWdIFkRgy4RQrIQbAo07k?=
 =?us-ascii?Q?diPdNtHnpnV5k9V6PV2HJDaIhdBEMPVyfjg+t1ZTfHil5SmQ+GKfOIjmlXy7?=
 =?us-ascii?Q?4zzJ37hOGbJL5dOV6AW1OFiDj0D1kc6g0N5kxjXLR3xoFYeC8bjABopgyFGK?=
 =?us-ascii?Q?re0yD7p2IPHhCAv+RB70Ep4CkMqqti3YL1AUOeL+5ahvsZOQiWXykilxjE03?=
 =?us-ascii?Q?07xMyArs0WLiYwi6XtJYXwCS5NObyyTbZqMkDkeDbBjumehuhz3baWnTF7UD?=
 =?us-ascii?Q?S0AYQEt60rsHSXbbHjHkmaGJ76ciia+cfIxBQXD0WCMmXqkAxyZD1fyEKxd1?=
 =?us-ascii?Q?XMXaT9QPnfKtzM91Dxehv6iO431W+jAHRRu8xOUMsTOGqvwXtiLSD1yvJDoU?=
 =?us-ascii?Q?WbiIFAiKwlKpMDoyhVGVRcM11s7w99JcTh2ruwo1KbxbeInJeVEcaaGqoFqF?=
 =?us-ascii?Q?aEoXCbegdSBccbYZ5AEYXOOOFX+jI7u8qzTtBu2Z2qBLkYiaw2MAReh5jJHR?=
 =?us-ascii?Q?otDbhRzKyQhZGeCZSE1EzRIyiBO+u0kL9mzMQJOX3MQu/nVmvwUhcJj1Oy6J?=
 =?us-ascii?Q?dmSsJgVp0gaJwqju1QHcAFtMa5xUVBBi05IXUGLIjkNFQtplOscCvEXQW/jG?=
 =?us-ascii?Q?alusuSr8VfpL+WlxXGgH2Gr3RVn1p3B28dz7bUB3+RkQynagC0oZW+P/EJv7?=
 =?us-ascii?Q?Vz6oooZcj82JebLiJaAjCShGErOT2EMLHWBYxdSl7RHRjrcuEYTtGG2dKy4a?=
 =?us-ascii?Q?HJ8XdhZpGdQGlJ82KzwqQlxzVqkJ+v/jJz5xsnRaHwgr6Q63iztzMturkJ8y?=
 =?us-ascii?Q?ePamPguUdMwmeSPVfuCfJDGk3xpJEAjN3eFJCWdu00T3re9xakigb/3y/wNz?=
 =?us-ascii?Q?aSEFuQAk5aNF1JdkbXdC03q1maog9uwTMblHxrvwnXWD7eK7AsrmZYMSA7dL?=
 =?us-ascii?Q?dX7Pn8RZ2eeRZ3Nygr6aaETlKjsBizXDAfRIhsR2XNruXxlLxXH42fSDth4B?=
 =?us-ascii?Q?KQJaQ6JbGjjCjdkcFkMq8dtG5YFTojvP1frNfFLl0X9Qcf8Lo+FlPhVdXm57?=
 =?us-ascii?Q?kTo1cvIpFzBsfLiHVov0EYh8GO+9Lhvs2J+xDxRPvXTkLM40KL/5h8rxCYjr?=
 =?us-ascii?Q?FhQcFMBB97u7/wDisR4KCRPGioNCYRH1krfWY9tiwV+Wg0hBofn+XOvpIddf?=
 =?us-ascii?Q?/3EkzjS+n5X7IrHzwo1RlZm1WURSX8qzrYYe0tn9xTtsKI8cdkEhy5DbE17O?=
 =?us-ascii?Q?u0xgC/O27RgUT6t3DDoAkVzfPgpbOEcMqKTL4OWQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ac3af1-d3b3-4a18-c427-08dda3fa3906
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 06:28:45.2866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkA06fgOZktTOeCERlnOiSbx2dE7NAwYws2F2W/7BJpOcqD2Bsl/FV5188N5os210OOoV2YDrp9a1bcBGwf6Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7529

The kernel robot reported the following errors when the netc-lib driver
was compiled as a loadable module and the enetc-core driver was built-in.

ld.lld: error: undefined symbol: ntmp_init_cbdr
referenced by enetc_cbdr.c:88 (drivers/net/ethernet/freescale/enetc/enetc_cbdr.c:88)
ld.lld: error: undefined symbol: ntmp_free_cbdr
referenced by enetc_cbdr.c:96 (drivers/net/ethernet/freescale/enetc/enetc_cbdr.c:96)

Simply changing "tristate" to "bool" can fix this issue, but considering
that the netc-lib driver needs to support being compiled as a loadable
module and LS1028 does not need the netc-lib driver. Therefore, we add a
boolean symbol 'NXP_NTMP' to enable 'NXP_NETC_LIB' as needed. And when
adding NETC switch driver support in the future, there is no need to
modify the dependency, just select "NXP_NTMP" and "NXP_NETC_LIB" at the
same time.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505220734.x6TF6oHR-lkp@intel.com/
Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v1 Link: https://lore.kernel.org/imx/20250603105056.4052084-1-wei.fang@nxp.com/
v2:
1. Add the boolean symbol 'NXP_NTMP' as Arnd suggested and modify
the commit message.
---
 drivers/net/ethernet/freescale/enetc/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index e917132d3714..54b0f0a5a6bb 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config FSL_ENETC_CORE
 	tristate
+	select NXP_NETC_LIB if NXP_NTMP
 	help
 	  This module supports common functionality between the PF and VF
 	  drivers for the NXP ENETC controller.
@@ -22,6 +23,9 @@ config NXP_NETC_LIB
 	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common tc
 	  flower and debugfs interfaces and so on.
 
+config NXP_NTMP
+	bool
+
 config FSL_ENETC
 	tristate "ENETC PF driver"
 	depends on PCI_MSI
@@ -45,7 +49,7 @@ config NXP_ENETC4
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
 	select NXP_ENETC_PF_COMMON
-	select NXP_NETC_LIB
+	select NXP_NTMP
 	select PHYLINK
 	select DIMLIB
 	help
-- 
2.34.1


