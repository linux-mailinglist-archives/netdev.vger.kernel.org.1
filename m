Return-Path: <netdev+bounces-199385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EB2AE01C6
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31FB57ADE69
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF421FF59;
	Thu, 19 Jun 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="idUJOci3"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012044.outbound.protection.outlook.com [52.101.126.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6821D3C0;
	Thu, 19 Jun 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325712; cv=fail; b=X0RWrx8oVyA7jot61XV6Nl5Bz8v9mAoSQAtxyKw4OQLU8PzDiSboSuqTBwTGrdyPa3WsWEWTOldpd0+0ufCcLYAwPCTLGLaZCqzzEeC1STZOPagertzzg6uSR3EyDa5MHCco8dk6lWVNuaa9VX8hJxzcJg3YdTjtqW8r+OS65iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325712; c=relaxed/simple;
	bh=5K1eG/vU3jSOWCLQYsXt+V8c4HVVSK3Pf+Fx5+nlTeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mxAbIPplzRJ4tt6KJURYnCyPIpQXY1oUCO2Q42ft1WqebEN5eATC9oh4Fgh/G5FLKf3c9bNIWPMDeiQg1MvIsvCNrtbE17fxmczrXn+ONO9k3JwMzlUSjrU5qhBZo7WcIPPfvhmo39aLOSd/ECy9Rme34MwwOB33s5VpkMBIxMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=idUJOci3; arc=fail smtp.client-ip=52.101.126.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5qac6KPsuC01tmpDYn2fADcwgOR230p8vnbVAdmYJXlCb8x9qgtAI+cSFatw43FNh9rLtE7YdZqy1OlGMB95DdnNOdwLkIeU3CAB93b6iozoeXytUtrdQKWF1On3IV4OAlv/616omK0xX3SmDb4lvHGsSnHlJ10ay6SI9jIpfM7HL3RfgiHcI7/5G4ULS3dXtUgODArh8jqvZ2+zcZxwwDF5vxEJKw8tEXo1GEggRweny4x9I5X04xtRMaXHfPSle7rG2Ilk6Qq3bJfgWLe59m9TPrbqv1uuUjMboja41Ea2e21XEage15ns5fNOj8HcewC70Modx4J/46ZN4yKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfZvmFU5IdFG4XBjH3MMVahhqT3NaFrP8TaCuc3uEYM=;
 b=evZVnjYwjT5UiZzVuy5RRYkkBMMVaeQVHTdlI7yEeGopEoCKjnLT4zZPCrmbb/Uxj4rgdiKkRPzf/pTYJFKJzTQNNyczLRK4Ju1vi/VcI+RhJdfFbsWc/X7NaNzHtqokGaNO4OtpnRRzypMwQmdeH7JiC5guHrXVoCfQSFgiRcoYLXTdE5ACniSzuAmEpFfXvrWirRYb8hey1lxwTZu5FzVO0KyC/2+4Jlf+q8wQgOhck0wfrPhmwy3RcYQ0SyhifK0zFamx4JhKCyjTVZwDUbTtQjmohvt3BPq+VEM4r8IfGrxVg3RxA0u1yKWvHwZYmMdpXEOYlE8dqInUAvHkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfZvmFU5IdFG4XBjH3MMVahhqT3NaFrP8TaCuc3uEYM=;
 b=idUJOci3qhbce8Vrwm6v7e4JpXhp1LGMDY8bxdJj77ve7V7cxRxxPDnjqRfIJbciOrCPPT9uzxYUDYQIIacPYHBEt8bdTiUI/tILz1Mk610IvEApswsUUVDUPzmMTzVGNE3JvH+SLqSPzRNrKsyR8ZY76InDv5x2qPIn0pjoCqJps4vWaBSH7uW9eY+cGZNQqdE5bhs09k+1v5azTr74mefjF2dt4Ddb7Oca209nAjPFcMPnAXDGVG+UK7vEvlcdJ65dYyon958cJo7VTgiH5FznYJVWOltVtiPtyTKdLza7KD7C/UuwMtFXTEFjqhOWYrSn2Mpbo4rLw+fK+hPBcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KUXPR06MB8032.apcprd06.prod.outlook.com (2603:1096:d10:4e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Thu, 19 Jun 2025 09:35:09 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 09:35:09 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH 2/2] nfc: pn544: Use str_low_high() helper
Date: Thu, 19 Jun 2025 17:34:21 +0800
Message-Id: <20250619093426.121154-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619093426.121154-1-rongqianfeng@vivo.com>
References: <20250619093426.121154-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KUXPR06MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: ed652ea9-d917-4c3b-48c8-08ddaf1494ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CPJIjRHnsCVFY8uoX6MWBtdwfqA6LeOkMCUB8HNkUncZdrvhGsv5iO25o7+c?=
 =?us-ascii?Q?dm5XK/9kWGX1Dd1eMHGoWGIlhYV9hsTg+fC8NzRgUJ/a4nyjetieGYpC08mc?=
 =?us-ascii?Q?kJD7wC3veXliZZRH2AKmRCuU9Z2+zwO+qt3PUKuSU3pcSFDDgTL2E/UBfSMS?=
 =?us-ascii?Q?c8YMWZjE8HNjBWgRWs0ovclEVo2nyBnOAQEwYyLJNEErEJgbB3YM9vjHNkIY?=
 =?us-ascii?Q?YrPBgA18JYf25ZIk1lE9D3jnZ2wLh0koat4NtRUupWo/QESW3ftaCPHwb4eL?=
 =?us-ascii?Q?7V9k4ZD48GilbmBxuM2fBdvBHYLo5gEQq8dXWCHzW9XlDj1EhxwVzqSB0HUW?=
 =?us-ascii?Q?jB4psCw08V0j97Je8oWveK14tdCFkZ9BVZVp0kHiRGMKxlAMBqzTpzxuE3sN?=
 =?us-ascii?Q?WmQdDF2yUJkS5uTKA+x61HbdxG6RRwWPDuFF6Hpfsm4a7i3abqH0tIHH3DUe?=
 =?us-ascii?Q?c0381qa9XVQPX39SbauDJDo8Pw15wahhlHBD3ugJbEl9e+rTdr2sAnffE1mN?=
 =?us-ascii?Q?nMG+WwAJUUKZDXzN/mlctaeKV1xCOQInUkrCHEHE2x14iHG9fCcaghNYK8Pw?=
 =?us-ascii?Q?hJ4nLrhpsRbxFsmBRhwXWHij5SG0pTS5iRxoQyU8UMorGB+50Mjv3BQPu+Dw?=
 =?us-ascii?Q?fmuUUAtVGGxyjP3fPag33iDnMBDdr/z1cSlgye13qjBTFs8TxR9RbXe550K9?=
 =?us-ascii?Q?ZjXZ1XKi4QiCCObyUEvfYx0kLUWDOfg+qwHrYlZr+XpT7SHJUeIjVusRz15c?=
 =?us-ascii?Q?JXMli5o5t4w+Ziy846a+Wmf8F70/yWjnjsz/mmPGTfaThxnY2F7GrZaJ1cGC?=
 =?us-ascii?Q?2ijylxQQBFBGNUQVGIRa+H6+yaHgZFw0EfPDPGNX6dD5eJxHjE4C8xBZr/IK?=
 =?us-ascii?Q?uWfCrlIZl2Q64r4jncuWb9405B3aLQyuQlUgZtqDCbIHgI+KEhp1RLmFtw93?=
 =?us-ascii?Q?03O6Ki1oMT0EWjs0BahgLJIrVjw5fcQuSrKDViypOsrO8p74tROMm0wrMctP?=
 =?us-ascii?Q?Qgqt34a9em4jb7DxGY0jfvknfergxKRGMzTlhwrWNvS3UJPY93xlnRxhY8e8?=
 =?us-ascii?Q?OKoOScrN+++H3ihnJZHfhgU8Q7Z/Uetje81Ix1JoZWM0zcSibMEspe5nxSKN?=
 =?us-ascii?Q?n4jv8FrE7WStoEFpaKsZmZdrLLwB47SkwPXismZsWk//6Ra7PMD7CaG99Fr4?=
 =?us-ascii?Q?BhtID86/n0vWwXNP1mM8of9cnvltQe1tVUyJsb7FxdpxNXn4cuvx9aXq8wJw?=
 =?us-ascii?Q?+72R+b9ppLh+/CAkdTAW26wlOqd7YnMg0jAH/dtToLxCVC6Him2+T76RFsvD?=
 =?us-ascii?Q?ILVBk0mtpD9ztPWNvGYag+2oM9S14FXZTayGdbRQKezS7wwX947af3uYlOq/?=
 =?us-ascii?Q?TsGV064vUfy8r5zmVDOWUnlPKPe2dTmUfvVD+74eto1SY+WwwAo2dusJofba?=
 =?us-ascii?Q?njp8BsNdqWxmLPP+Rgq2qudtCJU5XebYfcX+fakt5BVZ1LJXpiekfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+v5GVFQMKWruXeBm8u+QsL/ipzmvgQabr3MJuEVVKWx/DgKcraSz1v8vPPc?=
 =?us-ascii?Q?lfld2fnysJ+FLmN2UcJXrUn/PY8SRMIwYEXaazG8f8E7RuGX7CLq4uYC7M/W?=
 =?us-ascii?Q?f57vHyri99WVpB00xiFdaDuGG033AxOE3ODmiQpF2EYY75llESHtJWsj3s+C?=
 =?us-ascii?Q?6WYxUT4yaPeP7mxT6pLp9pjfFrQ0iEKH3aCGkyv6udFumfJfgsVSU+lggNyc?=
 =?us-ascii?Q?0kDabGahB3miSmMadMRIpmIpaKbi6pb8hmrCKVFyDWzwnj5agAlwLBnyUa8s?=
 =?us-ascii?Q?aMLkIoL1aYO1o/I0s7xe9WpXWX5kylOZMWhttmcIxwFl/7oYG2rDZ3mFW+04?=
 =?us-ascii?Q?HjkSP2H17HV/FI4zR6Oeb0YGUXGhUud4gSHbPM0pqRvInf048FH5tRPYdo/Z?=
 =?us-ascii?Q?cHKx9lxa9u0olte16g9rdxcfbliKktA0LGrDGnrplXRvSoR3xyN6lKTv5YdL?=
 =?us-ascii?Q?tMFoi/FR66rxdKXzAeLYE58NaukvXYjH97+g6I55bDJ/bb6D9RADHfGok5Nk?=
 =?us-ascii?Q?8MWaGzgcoMyWz19izl550wFSzhL9TleDnznzuNNFFiUV6xEf0AExuyyYHUta?=
 =?us-ascii?Q?F0hSn2iPz7O8R8us5sqsq6Sapm7hvsfsNP+5Fi5VvkAq+POl7kX1Mh7JDI7b?=
 =?us-ascii?Q?QfvT8yx/MHYjx2mj3i/ry4phA4MUy2BmDhUyGzwVSi+ieXKAYjwHc9GGCdhd?=
 =?us-ascii?Q?48orRPQ2mefnMObTdncvz9UZcgFNIcSammbThPrFX3nFV+aNamZgV3bgNVgn?=
 =?us-ascii?Q?/McB/XAkxPakFo3Vk1tOAjAvqvtJUldv7/YvQsWhsF80TYZJ72atF2V63z7f?=
 =?us-ascii?Q?CJ4Kcgkb4Hjc9D2Z/nkuINmwsnLjF0+d9v8+XK3OONSHic5xEeRo09mHn/Gm?=
 =?us-ascii?Q?hoh2MHCw0wRTnQ9NpSdGOu9nd5Ywt3gbR0H0k7Oc+c3gHZOK2nwhkcMIrnsj?=
 =?us-ascii?Q?ZXpQ/1fDWjlEKAtjWZZmYG0fSlbeA9I8IriybppmJm24B6fmG3Ueokfduz0a?=
 =?us-ascii?Q?OJBPh9QNB15hnFmAi0JA4CDBDSasS7PkKgr/YFbk2GpDpyvVldLvTtIPtU9T?=
 =?us-ascii?Q?+sIJVtzYN2m8lBNKyfa8nU1KNVpRNo0ecP1zIKhQM6pg0EpZ1uviR0rEAx2u?=
 =?us-ascii?Q?KhsD6NDKBA3xrqM8y1HKcelSmy8/Vvm5tYLGAr2Ho27i95POYZZhBx4GALt4?=
 =?us-ascii?Q?UqRKDPYJIV+SFhRNCGOjPRcHdphiJHgmKq39xM3r4yuvaPWnytpoAcK6oN5C?=
 =?us-ascii?Q?/hIVhy1GOylu47PrXqFY190PpS+sbew6O3pMZo/iooacqpmyvn1aNbvRPa3Y?=
 =?us-ascii?Q?UceUivqQWELRWL9IOi6Ba5bpjZWQtByW2qHzC3RPjFd1aDDAmtF/LDZD8RCp?=
 =?us-ascii?Q?PGA+Z9qKyq/Bc78ZS8KCwfh78RB3LnEcKE5luFOiVnemkY9nCB+Krb8pXJo4?=
 =?us-ascii?Q?6fOs0fhQy/FDD68SybpZ0pBQYdR6M+qWlxRoS1A5FMOtJ3IfQgPlCVOKbLeE?=
 =?us-ascii?Q?B2c+Y7GRIPTMk9VMoH1MjJ/FNxd7Xp3nES4L1/Gd/gxJZcSoDKOpCMJLT7tx?=
 =?us-ascii?Q?dj1InpVU4Q88wpKa8K27Zq5BXD9zFUwX06SRKy6G?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed652ea9-d917-4c3b-48c8-08ddaf1494ed
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:35:09.0892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GH2re5RFdxbW5xSdvwTXLldlWMOwvnkLVR/il3x6aSob0+tOfrlradm3fFSB/SgoUH0hV3stcplsRsAoxZ23Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8032

Remove hard-coded strings by using the str_low_high() helper
function.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/nfc/pn544/i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index a0dfb3f98d5a..8fc9552b9d30 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -16,7 +16,7 @@
 #include <linux/nfc.h>
 #include <linux/firmware.h>
 #include <linux/gpio/consumer.h>
-
+#include <linux/string_choices.h>
 #include <linux/unaligned.h>
 
 #include <net/nfc/hci.h>
@@ -212,7 +212,7 @@ static void pn544_hci_i2c_platform_init(struct pn544_i2c_phy *phy)
 			if (ret == count) {
 				nfc_info(&phy->i2c_dev->dev,
 					 "nfc_en polarity : active %s\n",
-					 (polarity == 0 ? "low" : "high"));
+					 str_low_high(polarity == 0));
 				goto out;
 			}
 		}
-- 
2.34.1


