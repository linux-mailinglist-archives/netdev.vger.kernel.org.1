Return-Path: <netdev+bounces-215178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BCEB2D768
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74ED5C0B37
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42562DBF7C;
	Wed, 20 Aug 2025 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pz1Lc/fA"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013058.outbound.protection.outlook.com [40.107.44.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92C2DAFD6;
	Wed, 20 Aug 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680289; cv=fail; b=LkhABM90HFBq2tOjQNYWgZPgpYhaQqJV1GL/H3xI3EkS5BdYMMIgDcXUkzm1YNEgUS8GF3dT7/iZLPFjAJ9UqLkVcGAbhhQY66UozqD1g4g65LRox1RENg7Op/+ioIudDbQ1jOzv6QKU8oYTk0LmRSuhLeAM+WLh6RRaPbeo51M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680289; c=relaxed/simple;
	bh=ri2XXQIplpJu8gHIw1pV8r66xrnZ3gbfn90ssFMwF98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BJau2IfDMwltuFAzjJQb+xSSbzkjiN4y6BPjeC8+jCoj4LZt8DDLkHvzdqY9l4sBU0ZjQF27ljddFsk3uIJ81I/0VAGLTcxB+YU1qLmN0GlRw1BGPuOcZvmW7dbU2hVvmaVypp9YwFQkgyiZI9V9W6PsM1G0Gz+3BbIZ8JoM/6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pz1Lc/fA; arc=fail smtp.client-ip=40.107.44.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3Go8S9mc7HaCWU6oQ0so5Q5pJONpFQEHDt6wZ+VC6FORr49N4yyv4Lh3gK25fNhn0bOxnKKOT/HXvyzaTE9o36ebO9BA0HTzQRAgXEhQMVUSz2FpVjtxi4n2A+Of4FsiDSscXa3v6J4e64SZBMjP2cANIRGlrA+nJhbnCce10OMIl/QuUiqOobnl974rO04ctVr0Ayrv/XT9zHgpIEauqkKf1tuOLJOtOOyYwXmb2880d+d5tyUlpAbBloAjYwjXfhUwTulTj/noNIRavUrUet/8spC11PL5dhhS0qxcmeFVllLrKOLVYLWhixX2hSedWRULTMOCR/GQtDEBj1pSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJgy1mp/j/XFOfbSE0Wb6EfdA/0rpXl+Uyn7oZ22gE4=;
 b=xcokg7zaEyeNNdDgtMlxKYeP3ApuzRvYsP64DDiJubjSVVRVti8k/myACSno38XLx/LfyBQOZlMGXHGWWUeBqW7quB+FaYWaWwTXhw/tQAUJrajFAaDz4H7ftDTN3iQfJvzWOjXLYaFRVzIEfyjJUBf1AfArpF1JT1caz6rJwirvEIaPujZu64yeOgSrPVQnwl/1I6oNTVbkcbhYuAo/C1vuN2DqPZSg+DPNvHC8QnpKfbGtCLzyGS0Pqezlb2eRUfOPsnKcGBjxiofkzhCq7XVeJbFo4oWEf0N+kstlGEWeS6OKoAIWX/oF12PS0UON+9KjVMEnJ06LDq7A4lkWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJgy1mp/j/XFOfbSE0Wb6EfdA/0rpXl+Uyn7oZ22gE4=;
 b=pz1Lc/fAqCHTQNkhbQWkaYGz2dcHrPwK7GWuE/UlJ9VvXqgaH/LzAJnQXngErBkZbDQKGydXznq31xOaNHKOnVQaDKpQF5vFtdymiSq6fsKcL1gi8/tWUPcP4VP2e2yWKgXEuVG3zQrSysvB4lKm1Hbj5KCc7xKJnwB/DdqdOnXnaJnbkI26EfUr1yRAC1OcjdqtTWbgFTF/X5ahvIGqIIrREx+u8RviChvh5OMJJth7v+gtDMVq1GiLAwmDHk9qs0AI6hlYR2NVHw5W+mAk1Iqd/3n0TJ+S0CNon43NO7dySjDAwQfnfzaJ7V3URSB5vzPPHJm7YMTVUcKGe58X4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB5664.apcprd06.prod.outlook.com (2603:1096:400:284::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:58:01 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 08:58:01 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:HISILICON NETWORK HIBMCGE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 1/2] net: hibmcge: Remove the use of dev_err_probe()
Date: Wed, 20 Aug 2025 16:57:48 +0800
Message-Id: <20250820085749.397586-2-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820085749.397586-1-zhao.xichao@vivo.com>
References: <20250820085749.397586-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca63545-a5e3-4d9c-b3a1-08dddfc7aad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g5xoeGI1tYIV1E/B+Ita3+xfvOuDV7R6q/6eGJnhVS5HKOYlgofOB+UOFI5G?=
 =?us-ascii?Q?l49DW6NSiF7n+2dtFpzMzFnBKZ8TaedSu68aipKAXd35w3uLiehGnZOthNUJ?=
 =?us-ascii?Q?BFOJ0HyWLqfkf93qUilKhg7TRQ09tpGL0kbqvI0uR0Dg+79p30NpE99ovscC?=
 =?us-ascii?Q?42JEWAkwYS51PJrL+q66fh6YU6+Krjpyr7PIC+RNKDgiTXnlv6cYRTWxhXaM?=
 =?us-ascii?Q?xLI298UNZN4zPrnJPMddBLFExmJ6J+0JXhkKC2OB602kMlc9h+MQ2/nq6gFa?=
 =?us-ascii?Q?MbhpS3TWWsdfCGfEQPCjd32aYnOpDEXFlqhx+89VsgVPY64YTQIoY1mUgrW8?=
 =?us-ascii?Q?ecl5Qx12xfBeoipk2NP7CnAegNoR95ucNHtaxzElKZ4rVk2EX2WuANTjsW6t?=
 =?us-ascii?Q?GXSE9qO+6W9/I+Jo51eQNm/0SxHf7ZKWhp6Fqe0Y59y6DdC55US6p/6OazuG?=
 =?us-ascii?Q?NkJNwYnjpQjztHTGfRp+odq2axUQTtu8sG8P6p0NgpI2Dc/56uSPp2aHnMe0?=
 =?us-ascii?Q?Kn/2MUHNuKhJ5tiWY/nl/tQOER8QihiZVfevNjLRTMgkZ5oFkHN4vVcWb70H?=
 =?us-ascii?Q?G91suv0VZhisehtxGzpyrhm0ZOMSugqkIS07/urZ3X4ikjiQ1Yer1kcoSmSB?=
 =?us-ascii?Q?wMOMK16HnKzjieSklqfYQyq2hsBNojShdfkuGs8ywvcvqJtutpWEDphzLIlv?=
 =?us-ascii?Q?6qLZ4PYQOlEm3exPa74XpOa7vQ6r8qjHhSE0dDRuprPwVu7U3uW4qG82kqw7?=
 =?us-ascii?Q?KBCvuyuC1wak7D+d2MGi7Cl7fV3e0WgRzB5ocNI2Nw3KhszX+e4y7n0rqBGn?=
 =?us-ascii?Q?KemMgEkglVNVqOBGrrXc9xJ2KVbI3jPjxh8xOqMJz4U6YutIhvoeyXAOPReK?=
 =?us-ascii?Q?6Trydv//W3TNtXTEsEEOW3ZtUurfyfEjvlMXl2rpq0errryk8bsdCZ9YX2oB?=
 =?us-ascii?Q?POUeBtpAAMWkSmF8zK7lwy7476GThB06F80jJeqnLyHfVxi7qkZkF/xtvMyC?=
 =?us-ascii?Q?64WGc72Zg2aRYQmCKQxzNydl/iL5TJcqnNSzaPrapVRTJvRcJtDWxV6HYf8D?=
 =?us-ascii?Q?7IiDqQjSLObGXoPnjkZr2WMkWiXMh0hDxacDBm0PEgptJUrLx4XDhM7cqdCS?=
 =?us-ascii?Q?uonXYmcD9f0HfjwAkeN3GelqCzLhb/1sBVvGyNRogNv5ZJjmb5rIzUwG+upa?=
 =?us-ascii?Q?oxFCw/AQMr22U44368s/HfHzdx1UR0w9N/MxH/ZKLlavP3uTjuULwYXVAcWq?=
 =?us-ascii?Q?QcCe0ccX3bb7eMEd2+o0dwYOF6m/hK9g7O1daQsx7aSVxDiDs7WlGbKDlcR+?=
 =?us-ascii?Q?qaF7s10Ev19lO688E9jQh9uA4tCy+agMIskg46F8cKFYBis+44qHiduCUUo4?=
 =?us-ascii?Q?1J1q/P5PgasI3hpR1VsVl5HRxty8b7FBcO7eJLO8GjSA5VFrsh2SxjpUpTNr?=
 =?us-ascii?Q?iQphQOZe6UZvtuDwM8yBeAFyiDVxsixV+iFdo6d7syKQthZbdoAchZiTwC4H?=
 =?us-ascii?Q?RhEcE1jBvhcv2aE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hubBVi0PNY94lXpx6mKcdEMyTumpKqOa70n23YY/5+JlwCyiYm4OxQwjWXrj?=
 =?us-ascii?Q?mQOeInXA6uK/I/17qw20IxEAHn8nDXefeJtEjKbUheEW1SQLv5JxJ6RoF6eq?=
 =?us-ascii?Q?qN50UA6tuFvIzB7WT50ztorcdIAYJDCDOIuvPW5c+2LQSs9g3Ij4ibfDpqZN?=
 =?us-ascii?Q?Vy3uV3hub3dKYCZEwQW33/yyVXgjbRvOX1x8u0fBdp+hbQnRvaLteMA9Md8V?=
 =?us-ascii?Q?vWacOJiD0Fxbief3mPBxbZFLWgNCc5gctZilutpOWjhcD3jlnH0JKy6vx9U7?=
 =?us-ascii?Q?9XfbfjGk8hbcPne1K888jw3vrsuertXgR/PTNia4M/cWWv+6Qyom8d8F7q9k?=
 =?us-ascii?Q?ItnKqkJQA1zmWEQSxtDRrW8cfbHJYFwpxvYzPU7rCJ3NEGPlmMc6Y8JBRvsZ?=
 =?us-ascii?Q?vJO1SvaFigjJTkuam32zjqUU8pBId/EKjV8X8cKBLoGeZXYweFvlzt4KiEC9?=
 =?us-ascii?Q?eBB8xs3GQZBLKY/Zgo4a0H6aP1ZI7Zt5XZPfVpkPKfUEDt7xMFqGIRf5thdL?=
 =?us-ascii?Q?B8NhvdIBnwiieKg1LBtNK+Xg+vFaAvdRqosooyIzHGLiO9Qewrmsl4bqgAPx?=
 =?us-ascii?Q?XMVGA5uh4tzrfO9a4zeRNbGT4NWU38z3qZQyQ5+QxvGFLc7iiLl6JDRUBl1R?=
 =?us-ascii?Q?CC4VoCgxQotUTDfDBfXJ9T/nZTYt2/X8vLEMqZNpBv8sKEbSrWvnroYJ57Gj?=
 =?us-ascii?Q?Vgl3GW2fQMiLzQr94alEeyGcBdzCspa9MVb51ygZvIuExidmkMElPsjd2HQT?=
 =?us-ascii?Q?bXdG4d37NdTOwlvOB+s9NDHs61uPZ6HGy3WH/AlwIWmdSytdQjtEe0repNs0?=
 =?us-ascii?Q?Jz1oEF4ruTKh5qXP8ZloCgkmA+ZdkozkWVPCvuksarEEdI4qBG+R1Er5zWLJ?=
 =?us-ascii?Q?4+8GfXOgK8bR5AoBeXlnML201W76jINwdN0Mhv5LqILCtsOUPiZPzmyO+Fla?=
 =?us-ascii?Q?ucmrqBUD4Sm3XFcYn3WXB/EPENuqCi5tmIpA81Tz4ZOaId+4POtbU4Z/LiJQ?=
 =?us-ascii?Q?Vlp2WvwqznepSAizUyLf5hZC59qX9+71PLMmB2VwD0mNrd/PglFCfxDFcyUb?=
 =?us-ascii?Q?GFVKOJKukOFuGibgswJ14ropFIWbjXmbcBnw8r984ZuZi8ygckGJr+DfvhlY?=
 =?us-ascii?Q?XSyAVkhN5BvnFCvHcr3dvd4ds86s6o0KO3JEifLl62CHg0qHy0iuxRkrje5E?=
 =?us-ascii?Q?oyK9TGNgtab413VMiRqfAsizrVLMWESYTMW35vH1tuF2jsAZlMofGPTYCsDn?=
 =?us-ascii?Q?YATXTt5vSw6VXfz8YIfGot4+ooXuACwRw+TvdNAFDY0QPABdQnTd43cUJxxr?=
 =?us-ascii?Q?xLOpxlfPf9izqp1OoZPjS1j/U1FMIvgD0f1eKqRxdtGIqzoBaFArprBAsRwD?=
 =?us-ascii?Q?FEzH8UjEjIVxOQ9WL5vkFztOa/G9FkiR/kQMJioWinLIFZeGLGxUI90LEPEA?=
 =?us-ascii?Q?s7n1VJph9IvUWKwofAYlv9vqW/nyPre+T3q583RHFnSVF0shIh1qSKsEl+QR?=
 =?us-ascii?Q?dgUZt3bDRMP3FvvdOoNDK+g6s6MO4j0E1oL+LP/ux8sS//PZFsFo4s/CkF8g?=
 =?us-ascii?Q?0LfHfGKK4zqzK5q/y7/3htF5IQr/J5eIrjxsDx55?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca63545-a5e3-4d9c-b3a1-08dddfc7aad4
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:58:01.5489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGUdl0S2iio4+WhRUAoNrLvvFsjy2SJfuch7+MKh4I6VpIbOyGXVGYiPODpxkIKYJaKTyFJYjcB9zEc0D+9Exg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5664

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 2 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 2e64dc1ab355..0b92a2e5e986 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -417,7 +417,7 @@ static int hbg_pci_init(struct pci_dev *pdev)
 
 	priv->io_base = pcim_iomap_table(pdev)[0];
 	if (!priv->io_base)
-		return dev_err_probe(dev, -ENOMEM, "failed to get io base\n");
+		return -ENOMEM;
 
 	pci_set_master(pdev);
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index 8b7b476ed7fb..37791de47f6f 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -278,8 +278,7 @@ int hbg_mdio_init(struct hbg_priv *priv)
 
 	mdio_bus = devm_mdiobus_alloc(dev);
 	if (!mdio_bus)
-		return dev_err_probe(dev, -ENOMEM,
-				     "failed to alloc MDIO bus\n");
+		return -ENOMEM;
 
 	mdio_bus->parent = dev;
 	mdio_bus->priv = priv;
-- 
2.34.1


