Return-Path: <netdev+bounces-199384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F814AE01C8
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 11:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67041BC2201
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DC021D3E3;
	Thu, 19 Jun 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eTsEU2Zz"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012008.outbound.protection.outlook.com [52.101.126.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C988121D3C0;
	Thu, 19 Jun 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325704; cv=fail; b=T5BfIqOmi08yQ/wRGWawiOxoZ1Og7qJMSozNUWa0B+K34aN9M6CNhCJYis/+8AVL7Q09RmeYEJvIFwzqdMeRAq+EptkJKstmP5SzTxY6cjl16rANdLrVYhCH93BXcMzh7e2CYRHPRSb70+ODyg35ZzcequnA/38FHnCiEXC9TLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325704; c=relaxed/simple;
	bh=HDtkJlrzHWfUN3n5HI2ge7GwdfGLIwVFpsmSsoKIkyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFGsutmJzPOzUUYfOhGkGdPr1A04KYUBlaej+W8sRR4Do6nx9foEu2A+AKNPRtKl0GTuRIZcKbt8RvkEn6tz5/hjqkzP55KgIGM8LwwzA4LVJ9TNzgoTAIgC3gpFpgKHrI/1Ccdhb/r8Ip6bR2kZwE73DBLuAwcZfOtdjmYJteE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eTsEU2Zz; arc=fail smtp.client-ip=52.101.126.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4PL1lrdLJ0Nky3F02ccyl8C55GGpOAV/gvBjXlGJwK/XeXonLbuAXNSIHKkQsQuAlVKril3DBQzOCmnyaiLupXwe6HQ0je3dkRFy9zJU3qMw6HXtBYxzKz8boyqOP1+Te7srw05mMybONR7or31ZdWmOsyUYwsb6EfRTefADuMwJqJE3KGTZOR8D1RGDamukuJgzWObuxrdB8FqxYYDyQRpzRjQ32ZcRr9OHMkAzHqywcvzwbgyVLId6+Lyb4yt79dB/uzt6XULYnVbk6mgaZNp41XJiYlhnmcNNlicoF0SEVY+nZ2wsP7FKgKRBHjo0fTO9qm3E1pd2InXkjr9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=We/n+uSA4V+Y2l7RCyiqAWeuXqAaZIvnxP8AaqI/h+4=;
 b=cZGERHsQXwiLeXtcZbCjLLd75t0k+PPke3rnSqlyuvyifaC32l+EsMKbOE5gx02rJ50RNWv0riJn6atbTssQWjik6g65XdKf4DbecQveTMx5sbsXEfvKqLreyaXk5dEslBS0DXpTm++U+mOuzZoMD2HDzT8yhp7JtUe1X9lkJjn951xM+VOXuQUN4qC3dRLXCApou5tu1Wm4srmVdedYW0KAGq1MaJywGZq2avlLDYLGtw5ji25H088e3Wy/0H2Nh0+fACwAOaQqeRew/d05jhpLxZmJsnzCrBseQERPtEzWm9E5IWLveYSz7m0PTS2LZYYnKZnZmCnxvKW+tN34xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We/n+uSA4V+Y2l7RCyiqAWeuXqAaZIvnxP8AaqI/h+4=;
 b=eTsEU2ZzbtO1YM695rRx3lilyYdCUPOvIS7vCp3GM4VGpAjwjtlvQV+JfT9p+ZfMVO7EHiGwUdY4Pfc1pFnBValYv1cNP8obrsDnX6wj5j7+50nD3meIQjDcsZI+7qReu6cYvt4IJuN8qApjRpoed+FSP6C8Cn3Wvpt7LGUDNxU8VC/DuZthJV/dtwQ43Py4n7Xvm2glQFiR+O3NhWyMFeq95m7TKA9CYOoMSYVcpDqJn5KxHjMRk52dK0N+4eXhuasQDE9Emyq0RX4SBVAsvlVo3XL/XPElRXVUyKpjl+z23fcLIyzhI+4BhlIxuHaLJUvL0SGKw8oR8iq7eSuzpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KUXPR06MB8032.apcprd06.prod.outlook.com (2603:1096:d10:4e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Thu, 19 Jun 2025 09:35:00 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 09:35:00 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH 1/2] nfc: fdp: Use str_yes_no() helper
Date: Thu, 19 Jun 2025 17:34:20 +0800
Message-Id: <20250619093426.121154-2-rongqianfeng@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 29381adf-70c5-4d42-4e44-08ddaf148f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?33DSttV9LcQ26lAo2F2OTp9rGXG2R6E5QjXq5jvuJSCXo2F+/P0lW+XLUOpt?=
 =?us-ascii?Q?USa9xe+a28OSrWBnn80RdC9K/AFgBzUds+N50TJIQWnyR+qwkj17swwzj95B?=
 =?us-ascii?Q?njEwYgihg0mn1javhiwEnIXkYGoGiabnMpQBXMGI+Ow6v4Pd1bNBJV3FSLYo?=
 =?us-ascii?Q?TLNozMiWCUyEbdV+JkcMlfOfIP0nLu+T6JxKZqJUtzczT8UU/lGjQukO2RjN?=
 =?us-ascii?Q?sG/gCs7oJskSOR1unNkkJ/Nl1Jh2sBMSIEflR+j1s45X8eQimrM/A5HDP589?=
 =?us-ascii?Q?E7OeS4JibFnZCgDBwurXBu7dl5Otc/Za5xPRB54Ir/AgBf/yjrPmu1zXun3E?=
 =?us-ascii?Q?BbWI0fQDl9kPBS/bSPPWbqCt3VEdzCLdY9qi7/0J4zHdggz/YASE4fjcRFID?=
 =?us-ascii?Q?tT8OpZ/EzFCkgvfse/f721HZxbbzu7hQhN6Htb/X6IyGCsPmC58pk7QxMOwi?=
 =?us-ascii?Q?JLisUgPDCAizVIyKK0AiqO63KWVD3/Fc5Pg4cIAnA8DDRrx4aLGzxUwnXSmN?=
 =?us-ascii?Q?AtloYWXSin7a6KmLmMFXWIsKcdblKry86hEiucdEva3fQV71hvQY6MevPxZd?=
 =?us-ascii?Q?V7/dqqn7Guy3QxdhDiCSzS5jnPeT7akcGNOzfjKXsax1FfXM4gAbrBFUdd8D?=
 =?us-ascii?Q?h28cmtdO/uCPFLULUfv7qWMU8d2NquDGkDr7D1sGxx2E507HzDCfN8UFK7TH?=
 =?us-ascii?Q?pQiwnTi8xbb5aiclMPZzK/dbjDp6pNoLczTL4L+HawDdnCMRzuxiFsPZX+tm?=
 =?us-ascii?Q?x9/OGinlG1D5mKefnaVLCk7+hQMWztc4dzs+5JyLbNWnG+GqTxVyDTRPzPk2?=
 =?us-ascii?Q?2c4RYT3VLPz6JlJ0SOpsOzQTZ02Fy8Q3Vd7W+p1psMJoD1NhLixUplzw5Tr8?=
 =?us-ascii?Q?SCPClSvvIABSq6czHJCAsSwfjviKqKQ0o5viLUNRyftQBNf2NNLAHDc8tfsX?=
 =?us-ascii?Q?/RHII4hK+qAFDRho6HIM/9Dc/WnG2iRSgMYY9K+jcRnSP8d+ZATokgLIWzSd?=
 =?us-ascii?Q?/t1mpbrWRtQfhSlg7CcNtrd9PYJxEF07nA0VoYvBaCNj0IG0CsbaWJsoeTnK?=
 =?us-ascii?Q?rGMYrCBjAawFpFwWqxRMJyjlaxzrNVKKqPJmiqKL1dr9jFIabRtZKxEpqdMT?=
 =?us-ascii?Q?f8t1MHRfCMk2r/VMaUBlRyzYm2HGgfbjMv+Pfvwd/XioAwnEdtcPlo3BZ0Rd?=
 =?us-ascii?Q?r9CkmdmCDL2YBG9XNK3GcYg+3OuQYPfyZsl92ultXmKqzlD0tSlnCnk6Y9HL?=
 =?us-ascii?Q?OzktLOenNQ8aWfWzms5Y/UxDVvkC9ulf7sYo4tmxm9vB5ZCjBvVlAs7Ejk+C?=
 =?us-ascii?Q?4ZsIazvLWeoz+WMxYqLqJUF4tCnXFqz8vsxQKxhbqzfQD0rBl3xcf80LndLM?=
 =?us-ascii?Q?ixwp7ChPmq0w1fMDrFionVvCD9cbQGi+dltjg0bqY1TLW7g4eGZlwf98/MHr?=
 =?us-ascii?Q?ZEelk3V73ZpdibJNT51BnCHYkfsxO9ir4vcXezDybuDqXm2KsEWRHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?REw9Uf0SVnxvk+RXLH8xa/XWaCk3Hq3JicxoixZJl5f4n6QN0APyIZFXbCRv?=
 =?us-ascii?Q?JddyHgRwPJUTmZXMNli8C5hpBg3f00VU+c1myWsNrr33HihX4lSYAqQkwq+p?=
 =?us-ascii?Q?+8gLXZYJMbcUaSSke66HO3sSiANVTwRovxMHc1mwGRAThqGjH2AEPl15QF6F?=
 =?us-ascii?Q?srNrKPOv4oVTb0QCTGANmQYW4fEVXqweCd2ahGIdm6kOUwZz4HY8ztvI6UCc?=
 =?us-ascii?Q?LdIqPqdI9Q27nT3ecrbxhZNUXwX82/oJFOAgy0KoG5dL/pKACLmXNaeTB2c3?=
 =?us-ascii?Q?P7nxiir4MDabpVUqnAD3vTxE7Ti22eZzw1tjPCbYPUH/iAD/QHLnxQUnvPRo?=
 =?us-ascii?Q?6IPoc9Dv1y1zP6ajyqmO3FfcTuBjvF2tUHz90d5LegcEjBye5bHnwWXcWmBF?=
 =?us-ascii?Q?NwCmBs81o8RUXddui/2RajnPg1Z5gAwwvhtDwY1PC+lfI1sLrsn52J7dmKH8?=
 =?us-ascii?Q?9BdNThH8p2FxH9MxmMavY+SIG81AxT65OzgZqkAQC9e87kuCnxEPDXGGEtD8?=
 =?us-ascii?Q?fdJOnex8YfNMMJjhakdQ4yJQYlPf0skDdqeYSKqTWAmP7hTCQZu5dAsSCRCK?=
 =?us-ascii?Q?EQhDTh0/yBxb2qkcIHQl9xDXDqfbjbIQhD9KoMd4AlTYkIsHk2SHJ7V+e45d?=
 =?us-ascii?Q?RUnWOAlN0Tzm8zH7l6IwXYmhfFDwP2tCOxEi8T1xdQuGpC2RpsN21hK9qowp?=
 =?us-ascii?Q?TOKUaHZY1ij02S7RKUurb13tvuoUwMZ9XklyU9xZWa5x6UszhBEvj3OrDy+v?=
 =?us-ascii?Q?VReUHp7jc1tD8w1O6VfeadQvzUFy5fbH3hRQ9MMHY+ma3uC4PcApUQwWDdmT?=
 =?us-ascii?Q?BLSLcrKYtaFeHkTlCFSXOL/CwYZPW4Cme54CC3Vm8CngJoARIQQ7Kq+w2NHk?=
 =?us-ascii?Q?qWmiW1u7fprZditK0uzvgWZtx/SS6ELkcOLg+Vg19sGL20dkiXX1u9wF48eT?=
 =?us-ascii?Q?YxrlS1Vs5FKv7HQ3f0ImoWNNzWmhfdci6XRFmk2EvVqvydrUvp7CAN6q+mH7?=
 =?us-ascii?Q?vfgj7c//70NwZeaQm6KQ1DbvLAb2ovXDQ/t7p71kcU6ekb2TCStidSfE6Ppp?=
 =?us-ascii?Q?M8IOvdvPPrMIzN+Nf2638xdnX6ff/+r7lG5GJHJ7aU/OVl6ffikpyDZt5FNW?=
 =?us-ascii?Q?b5xgUZMO4rzeeVLC8x/GuHpb624KstCNYiKL9B16KZrh7HZJg538Y6ZRzq9f?=
 =?us-ascii?Q?KgcaktCdQYrFUt6vBtALtaLn9ilx20EsKFN5Y5Ursr1SSsFQ1xZuzQH21eaB?=
 =?us-ascii?Q?YmqV199kIO/NOo9xRKQYbYO6YXLPli2Ac3ZhAF3sH/6+ViCn3diHTB9NfZuY?=
 =?us-ascii?Q?ygScLZkPlTXxu8toMXlO+8jql9zwC8qGAkZlW2BIjuGKnA5CIwGSRFdkk+Ub?=
 =?us-ascii?Q?W94LCmg8whDF+YVbEwWOCPONMmD4535SS9ctb6ub3IIAnviQSWXzkI0gJv6i?=
 =?us-ascii?Q?hBc9AsnXIMZOfDT5+N0bos4u9EKoNkHWz1ReTFCL6lInGMlhCvbDJjqXEDV9?=
 =?us-ascii?Q?phnzDnsUxUO+2lIQgfUOWwnRu4WFfbJCxifUJNm1DoIeAdoLTW4EtgqUUCr9?=
 =?us-ascii?Q?BA3/V+uBRUwaVmDnycvp8u4744rlOzZLJHuE695R?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29381adf-70c5-4d42-4e44-08ddaf148f93
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:35:00.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LehS2kDev67DltvV2+zbbvXmXnQaaHr86Lke6UW2MdPTJWGq0u6uNhTf7XB+MmSwJxyy0aiYt1h0Ar28IReog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8032

Remove hard-coded strings by using the str_yes_no() helper
function.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/nfc/fdp/i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index c1896a1d978c..a7c65e9bb5a2 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -12,6 +12,7 @@
 #include <linux/nfc.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/string_choices.h>
 #include <net/nfc/nfc.h>
 #include <net/nfc/nci_core.h>
 
@@ -265,7 +266,7 @@ static void fdp_nci_i2c_read_device_properties(struct device *dev,
 
 alloc_err:
 	dev_dbg(dev, "Clock type: %d, clock frequency: %d, VSC: %s",
-		*clock_type, *clock_freq, *fw_vsc_cfg != NULL ? "yes" : "no");
+		*clock_type, *clock_freq, str_yes_no(*fw_vsc_cfg != NULL));
 }
 
 static const struct acpi_gpio_params power_gpios = { 0, 0, false };
-- 
2.34.1


