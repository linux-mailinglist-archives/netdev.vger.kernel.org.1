Return-Path: <netdev+bounces-206073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CECB01437
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD5F5A3F48
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1971E5B73;
	Fri, 11 Jul 2025 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DYNei211"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB7E1D9346;
	Fri, 11 Jul 2025 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218240; cv=fail; b=H3Q2sudHrDL1CziiOYo1mfmPL22CSN2gUew7tQY7USeLf//bKVOYotVk++cX0H9iAFrc0qaV77lB9Cl9Ec7RZYn5viBRke+UUDPKF3yxnYl0E4tLLAc2+CkWu2ijDmnlitrPR5JGxIT+fjwCH8bTyplK//Oaikmyy8XU6EuG+Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218240; c=relaxed/simple;
	bh=6hrE7c2KZXmt5Orm2CHAkdyEGpHsZp9TR6EBMFW3jh8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TzY4fNEi51lT3Rg8vEBQ3T4BZ/ZnErZ75VV/Bvd+A59V81pmv69dCvJw8E7UWkKY28jXrWheN1vHs1fIVjGsLhZpsaTyR+A3YrWMLzRr/DqPYZMhpqdJwoaJQDKUbWSfIrxxbyW4I6kDEpqtlI6e2xsFMiWLRu1amhsqbOem+oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DYNei211; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oj3sy0TmPwud3pSpLyk7XTxjBo1d+FAKM4wE74j8ymfTJc4HrSH2AJx+2mFewW4GOJinpQxGAALhJMD+ISp1NB+fJ0HFUG3YzXUiparwNcVi5XUcSrOgVtwEuI9i6NegO9aAfRtjZX9L3lCAirzvBVVU1sJmVrgPZCEg35SN87taDdbHqstxxISMLexq4tzNSLEk4TirY53Pe7xIXOnROg2TDY5rEG0dGqdJE83ZxQL2bgIbdKJTdNjVaAxlDPrxHZdHEPzfMmdq8NY4WDrenGB7/leTwokVD4uvu/u3ScQWnJtWnSS7EMMU+H4CSWqiJpIH8/pZb1+A3xmTb/36ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wioGictUzcRfbtKqKLstJi5bSZ45STKjMiB/s20fIS8=;
 b=J4f9ORT5jcHf97d8F3sylOxIb/bJKlF5jhdI4fOiYXbDK6V7OdtUZn2bqKKJ9s58MXpzB12nh/KADo0fKRu+N5Kzrfanuf5/pGaWdCLs2/htQZSzd6tlIN80QZZuYT2jCPgzSpMc89T4OaDJ1NQtjMyn2YxXiGiCXO2IUkVbAzRdmtm9yxrvWGIUhJko4FOJyNZnEYpTdXwFlhnGbBS5fADpZcPgAwVfpblJP5dnvH42phPtBT+2oN+LAvSUFktM4y+WJTyUFJFJDRuqKGxccK0CMNyN+Yj2DL5C+7QoxIXH4Q3mCxTVN6ELz/lQhduI1wVV92eNX4qiD7JyYuPctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wioGictUzcRfbtKqKLstJi5bSZ45STKjMiB/s20fIS8=;
 b=DYNei211Y//fdQvj+eqJVF477ku9kNCaUzB+ol98FHM93ZgLGxFga/kpbB94g1d8WeBVJBPcrzuC7JeJ3QA1yWuVXuk/+l+tt70/3ksY+H4Af+yf4TO15M37n9jlcavSUey65dP7bUcnbHXVSMwiAQ9DqnH9R51RNANdNq3H+/LanSm/Q2RlcMT3kVRFXg8Q/ixvF5ENY7JDiCKwyXSuFzR4UKST8zCX27ePjP/YCosKuUxuZG/k8ZbqzG2wS7SaEjerbv5FSGQqAFEZTnNjzLNkHLpLgj+cb/BRBZAW2oSsuBMtv6Q00sQAxudxcHKiznrA1M3nuFuynAi/gJ4pPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 07:17:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:17:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 00/12] Add NETC Timer PTP driver and add PTP support for ENETC v4
Date: Fri, 11 Jul 2025 14:57:36 +0800
Message-Id: <20250711065748.250159-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 626461ca-863d-425f-a1db-08ddc04af5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wDRDMe8LPZH5EDunUEEq0GmqcDCFyQ2Fv5TnVqS7NAilZ4xdIm+pbBhhVXOx?=
 =?us-ascii?Q?FBhUZZJmIH9TqnYn7xYkkczGhffS1sx9Q/CuMHXI65v+a7/yMvtziiea5I9/?=
 =?us-ascii?Q?r6H7wGptsoUzKDA493lO/6BKAmCZt+72piWNPuTnTfY22Tb0J4DPZfXG1QyP?=
 =?us-ascii?Q?ypLyVmykL1mQvyI0VnXtxs5pJt3svE+Wvl5HyMbE46WiYzY410ybQHcOzrqP?=
 =?us-ascii?Q?gqDqoJv1dkzb7e8UpbTmlBZUwzhcDG8pmwIHrcAn/YqfKBl3IjbI3t7HIjtG?=
 =?us-ascii?Q?TWHkmFGl0GkDKvRJg1PZqq03ckyICNUQpwdIsKaAC/fgwj4pz/7MdnCaW7mq?=
 =?us-ascii?Q?N3VO6CC577Np7TH/S3Ll0AdVBZKLsneGRQCnwsc7ScIwGdHkiuixz2HgwYq6?=
 =?us-ascii?Q?NEVb2ScHCc0Hw00MtpfreJhiPIOandwHFmv2lRCt/7nt1cutsgF3ZOOD6ZuV?=
 =?us-ascii?Q?k2U+CcwWUwCyz0uwp87qSobt0NEiJ7Jb2QykiosfG1a78KdHz5xfyb9KDlt+?=
 =?us-ascii?Q?rIXtsluju8vvQc6GNP9Z6C9cGU4YGC5nfzSRsfanGuyhZoq33mmoMlWG9XHt?=
 =?us-ascii?Q?AzvLmL/Yai8nbSpvQAyOWMDnW+FKE0GkN7oFBsbP49XtVDzThYoHloN12pZU?=
 =?us-ascii?Q?s6v0zfR1mW9pLZeTShJWlmPBhTC441oStzvdD2r4OGh+HOEiZ7eKJv3NP465?=
 =?us-ascii?Q?FOJwKfFxZ3zBnHX2/yDcyLyTHnGSvbX02nnw6fx9RbG3W+9zezvtjRBUFpTE?=
 =?us-ascii?Q?ykun3/TPeHi3Q/XD/ORxM/RmZTtWO+EMVDu2sEO1EXkLEKUECv/DQgDZGBBL?=
 =?us-ascii?Q?OVSKqvcfB/Ok6B+uQCqlmOnoeopBx01ooU6lT5NwC/H+tbnj2Q0XTzxghNmF?=
 =?us-ascii?Q?lfAAQh2nJcI3jrhli7d17/bvyPUnP67LA7YR1Vw5Wxxwt7QAJZHbYC2agXrE?=
 =?us-ascii?Q?hj4MqVCb3NnbG58Ma1QCjY3S3tHASr14kohYfAu1+yt/HyMpxooKmjMUjOe+?=
 =?us-ascii?Q?Co7A22Be9KLUBojQ/1s+TyukPsH/KAvZZHy0hZ6JFu54RgTHK550/aLMJTOX?=
 =?us-ascii?Q?sRwNe2SrdCqImgkFOtp4orjhsW4moNTS5iHUb3xbpcu/cSggpm1zukW3ywJB?=
 =?us-ascii?Q?+S8WyBplH5YTIupDSUKVGtBXgf0IYIwOv//tf+HdIaua9DBmwg8gRlpwxGrf?=
 =?us-ascii?Q?P/RnKfxj3jt61l0/KHIp7WK92lHg5OiaT7uRyXXt8GUG9Tr9ZW+crMR2dZsO?=
 =?us-ascii?Q?zyn9C/2iz9v393bh3y7Emh8pcGTl7KBrQfxIktCO1H4uWOfRXf0XxoSgRm9o?=
 =?us-ascii?Q?Ub3O4GeeNMxVdmd7M3e2oKTd8KiuDYtvySpUZZIL1uzejIKGNY4gg4HLpNFi?=
 =?us-ascii?Q?MpWyWvQ+lyjWcWiuKtsatMKucLJBsMyAEKt8I6yjKIJRzgIOn9xdPBhFXEaj?=
 =?us-ascii?Q?23QEwMyZHxi5XuK9BfXL4/MiBjB57aCDNWUmDGUC8pVIbfsI8eMlry5ZuTcW?=
 =?us-ascii?Q?Ot7F5hIjbDDPwxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KjN4eaVKZG7U42v+O7hIbG/Vowq+ybAK3fu+BixW4BshF8PLyvzDsanH5BNp?=
 =?us-ascii?Q?fbqQwBWTToDV/QlyXmaQhSUhs4gJL2GRDHMS7kT52exkWT64UdDi7RR0NNnK?=
 =?us-ascii?Q?twM+NDH+aCNSdrj2fA6pCJDQ+DS8rKsbNJCxAQ59c9OxKU/jOmyEMeAlR9FY?=
 =?us-ascii?Q?UaXiKCMP7E1W7soWrZuMcF0KY5217rJEkh2DrfiSekYnabps3WFO9O8zqjqs?=
 =?us-ascii?Q?lMKiveMLl39gru+0E2dbusyBU1KIKCUhMSEVDru4rUL97OSdLfvUvhm/mHmB?=
 =?us-ascii?Q?cgromBY1ctBySwAb7A5YeaxJpf+1F/v7M4Z/Yzxp/cobGGSnDNiIwIsbU44o?=
 =?us-ascii?Q?XWQ5ZY43LT3xWf3APN1fVnSP3eTccB1O3hhgTt1v5s4cTn64wEI8GIw0M/9N?=
 =?us-ascii?Q?tJXdf39uwNBlMFBCOtZ8zSBv2gjSE4QTlBk1/hViiKYkSwwWFQeV/kShSiK7?=
 =?us-ascii?Q?MK51YLZavqq4oXWz44l7zqYA+nsjr1gBtiAcNGRRCLPDqgj01+0nMc3N8TGg?=
 =?us-ascii?Q?tW6EcXokxGnD1nIpJRevvZH1xLAfNGU4H6QXn125kd653BKSwvO6k7of43Lj?=
 =?us-ascii?Q?308gLkkckbrRNReZuxxTRpieLLGXNpUawLKN3ClbkJvbrl5oG5hgDyI5P8nF?=
 =?us-ascii?Q?/uSAVUtPm3X4a4pDbcTAWecVvgBG0DyYlns2v+GdU99GjRFu786Yr/aqpCq6?=
 =?us-ascii?Q?Z5mH/jXocR2pDIRk0Q6zEzIQmxSZseHcO3wRyoqjHZB3Gv4uXvKNZ2jkYCf7?=
 =?us-ascii?Q?a/SbRQusjdNZvlktuNwV4mwxh9XL/JB939c1mZ8v1cAP0vu4rvcXAt/ylR/F?=
 =?us-ascii?Q?Yr7mA6yUWwn2b1qv53Bsnjk6g18aYNYwQo6NFrDPU5QSLFxrNF8ZGbuYdvkp?=
 =?us-ascii?Q?JWbiLqKTOOWaC/buYBwtQR/GWNLnad3X6PzefysbuPGcX6PbHb87AJIMcSYr?=
 =?us-ascii?Q?G5p4jZ8nLroy5Stf1W70W0Qoor8Ak9JhtKHyUMZSSutvufQm4Z/VPMcyhFPn?=
 =?us-ascii?Q?M15lbzYX6PyFEwRCzVIJarzDz1Rc293CnQsCxtvIYG5F7jTgYmgkiseIRfsX?=
 =?us-ascii?Q?T9tXph35H6zvuYMTgPhiFnETUcQQmZh3i7yRJrndjnmugOvOfW1nm+HU9cl3?=
 =?us-ascii?Q?ILwgRTR4sZ3zU/+R2nfKP23+3MscxawA3jzVxD6m30Tsna5rzFEft5hdX9u+?=
 =?us-ascii?Q?aba5R2YFuQjICPVsalTPSiHDi4VTcUZNFSNTEOyO1ZE7A7IzAAmHXgMD8my8?=
 =?us-ascii?Q?sZvAzYuqhG1lyDrqkqqSiIGgDr7/t846LDkDFtHVRMPJu7JJCOpxvmIdy7Hc?=
 =?us-ascii?Q?DOhH5UMHl6zdExU1AOjmYyQ5BmW5d82NqYOMf5fmX7m1kkH9aOVicPE0tO5T?=
 =?us-ascii?Q?QMt4jTZIdiAONvsZjq4sJuKM5XxbpV4CKZfzA0mhda+l6f3gdplwMsa8w2g8?=
 =?us-ascii?Q?jkjaT5cuzCzzs1/snJfngSQbQtRezReU7F8J0lNvaDWrNeiCND6h2PuFhRqK?=
 =?us-ascii?Q?04ylY8nHd++DKAkKNdQ3BFDnSAb53ra/a+Jbb959QUj5O1WTF2LMpM+ilA7g?=
 =?us-ascii?Q?8b8yB2Azl5xLAmz+2C9fe+O24XNBHdUfnEaM4RVY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626461ca-863d-425f-a1db-08ddc04af5c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:17:14.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mow3ANgYIiw1NFyDyrlyzjepmEl/d2Fdp5KV35lQoNBVvUYV3dPNU97oPm0BDN+FQP5+UBgUWOo1aEo/rqNdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451

This series adds NETC Timer PTP clock driver, which supports precise
periodic pulse, time capture on external pulse and PTP synchronization.
It also adds PTP support to the enetc v4 driver, and also optimizes the
PTP-related code in the enetc driver.

F.S. Peng (1):
  ptp: netc: add external trigger stamp support

Wei Fang (11):
  dt-bindings: ptp: add bindings for NETC Timer
  ptp: netc: add NETC Timer PTP driver support
  ptp: netc: add PPS support
  ptp: netc: add periodic pulse output support
  ptp: netc: add debugfs support to loop back pulse signal
  MAINTAINERS: add NETC Timer PTP clock driver section
  net: enetc: save the parsed information of PTP packet to skb->cb
  net: enetc: Add enetc_update_ptp_sync_msg() to process PTP sync packet
  net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
  net: enetc: add PTP synchronization support for ENETC v4
  net: enetc: don't update sync packet checksum if checksum offload is
    used

 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml |   67 +
 MAINTAINERS                                   |    9 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  209 +--
 drivers/net/ethernet/freescale/enetc/enetc.h  |   21 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |    6 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |    3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   69 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |    1 +
 drivers/ptp/Kconfig                           |   11 +
 drivers/ptp/Makefile                          |    1 +
 drivers/ptp/ptp_netc.c                        | 1209 +++++++++++++++++
 include/linux/fsl/netc_global.h               |   12 +-
 12 files changed, 1516 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
 create mode 100644 drivers/ptp/ptp_netc.c

-- 
2.34.1


