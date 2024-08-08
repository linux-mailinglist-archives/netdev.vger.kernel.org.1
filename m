Return-Path: <netdev+bounces-116797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 947E394BC15
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC46C1F21932
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADA718B472;
	Thu,  8 Aug 2024 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="eB9ZA+lY"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02B18A6DF;
	Thu,  8 Aug 2024 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115909; cv=fail; b=Z0yH3hVZCUIFwRIW3wt+P1ruCFn9frpZ/7WemEOAj0Rt5M1j4taJUwlFUpG5xflUbrWdiB3zx1w2ntsHucGC9JpsrooiXj92ZPWa0b2iKgLVeY/aRMMtsHCGEmkW3zvkQPZToVwyaHyq1tREOUBIfhAxbK8itgmS2LJZPL6pbzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115909; c=relaxed/simple;
	bh=zTMn6c21PgDR5ojxXUz5K9kUIPl2lh9anNVJzccrSTY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aCNDnUTYUxWgWKhlkiBc3TziRu6gv04vHhkVaWA48l8jntHJLwNl/9QR9cr+m6hz3blJ76huT7OjzArWgzcXnzlVUzjfSX0shBmaXHI4P3aVlrneqsvV8vC8HT1Z1aAop/GNZ7+FxlLLie+VTsL8EAzWjtVDicoeUjqu6s65IZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=eB9ZA+lY; arc=fail smtp.client-ip=40.107.255.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hee+BOYqwmiC+01tsQ+5podlpn+YeC5nmwvA7YVElxYf06qXmK7yZ2VXUw/U44Bs6dlfQvjdGamXpq0cb2FbfpskgzBzBFUha2KUZR1lnZvBY8ZNqBQwDfwJPeqk/64ChxYimvFvqSek0OJQL+5QrnIQDERJwCrkk63jouXyu0IscMH71qW4uZ7nkjLGnKIxDHsqbhd8kmaCjnOMzKEbpqU7HNE1kuCSv9HdY0bF52Pc7Qlmt3k6uQrPl2hEB78okUxX4xpPt77qvfWOvNJeLFUUz/nO1NjW8JoZqEQuC1WYJu3Sa6AjbWvE6yDiKvrxkSqmv7ue16azIRSllGWLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKd12kjdaCUNxtdEqEyc6HYe5agEM1Hx/wc58rNAvIk=;
 b=dOn+82W6cdIXOBytkOMBdl/P7Ma7ihNIQ07Myso/IqnwhJWfkHdrxvTpVRxgxXfa6DaWDKG9FNZWHlrY9N5WnBj/VD5EXnOz7Tci+gnaiyvJ/FwcvmKEmTj2PBSvqtsUkZiMmbYmw206AQUkJRr604U9TTGq4UgkIm4cKY0tYL0QowBMvFyJbMyDSqaRQ1X8roteoMtMd68VGbSzjSCoFqbXnWTowEc7nRjDOAkmaCYFuonK5lw6q0VonC2x9YpVPwh+UZMN8qHhEIjYnCkoQ3ksBwasaLTI35jPIpY94tosfoEZ9fqXSwP4gycj/bWmvWjc03muOKsvJtQX/Pyyrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKd12kjdaCUNxtdEqEyc6HYe5agEM1Hx/wc58rNAvIk=;
 b=eB9ZA+lYUCMBLoA3YeGq/JPw7fIIun0G4IwF+rRf4p5KCujshBReEISqXDwgmVw9wBcmMn+aWnNi0wwiH6XIMfcsp7yeEXu1oJNM9GUsRsFHcFqYZ33dGjwOocRLrn04GppYxXaTtxDGGS/Tx/AXOdrchUYiohjXyo9Nmni6pKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEZPR02MB5519.apcprd02.prod.outlook.com (2603:1096:101:48::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 11:18:18 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 11:18:18 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	corbet@lwn.net,
	linux-mediatek@lists.infradead.org,
	danielwinkler@google.com,
	korneld@google.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v1] net: wwan: t7xx: PCIe reset rescan
Date: Thu,  8 Aug 2024 19:18:01 +0800
Message-Id: <20240808111801.8514-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0168.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::18) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SEZPR02MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa675c8-3972-479c-adfa-08dcb79bcde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l0xtIxE0ljbTQ8blCYl2jz8DBaVzUttxBQZiF5Ph2bZkzdS1Q8QhXXuLNHD8?=
 =?us-ascii?Q?l83ZGkdI0Gg3LrjD6mazu+mx4fJKJHWFUwiixpNoaW5AQf5WBRQvcHWJXxoe?=
 =?us-ascii?Q?mcLdbYhs4x9qSW/OBrhj3rPQTJOMCq5tlaEJ3uM/IA4Huy851gNbcsNJrOX3?=
 =?us-ascii?Q?2w7sJoJZ/dmxdue/Ht1FpZUk6i6g+f4kHM24NO1BUrew0HWvTtec6y5dYhIA?=
 =?us-ascii?Q?A1EQj8mI/qQ+aS2zcghYRHodUmFy2DBlsZUiEkzdyUnhjXC2NPQBxMdASQ9g?=
 =?us-ascii?Q?vFQInb7reWWH9rpW0GISzPKF1L9iypgAQQe+hqdeMAKezppwCgHIq3D1Bx4T?=
 =?us-ascii?Q?NbZHhtcYDN3MDJ2vCTm2Q7ejSVUwr3bBbrowo/Kk7TlTBoJVrzh45lr3rjvi?=
 =?us-ascii?Q?wWPcOvlUU0AnVG5Ts5lTuGmBLqEvKCh2RZIv/o/c1MalOSyAWCO3+ZHisDOB?=
 =?us-ascii?Q?de7dp4X/g7i1YRN5QTIREircuJD4l3F7KBwS2zw1ZRhvy+cBmRBhK3ytApun?=
 =?us-ascii?Q?ktswUiCEGV6+gQvSr5Kmly6WYb4V5IV/ukHwybeUI4RC8wupcL9R76zD1eLv?=
 =?us-ascii?Q?uqRKq0azGvnUPXloRpr+ByT4/LNJwqrsMNW07b1KsrmwtmuMwGXzo7waaTM1?=
 =?us-ascii?Q?tdJht/3NeKKpm68QwD+Nx+YWDyAFA5owYgt8ef4/yKUl1IqSu0+RxMAvdbYT?=
 =?us-ascii?Q?JiA42ba9QlRNrrlk/6KL4hxQDPnp94YTim3C+RVOTHRvFAr4TKEv4U01NfaO?=
 =?us-ascii?Q?humq8aUVR4doi02JhNsqTQglB7btLEuWpMgwBfbEJLW1toccfCTWx1GEfvHK?=
 =?us-ascii?Q?J1u6V3PZ5oGsPlX7NWn9qib1zY6pzbv95Oad58JYsDzhpixCLmBcAc38yPMP?=
 =?us-ascii?Q?jMou+JzuwxNuR0fjTKiGHQeRagp00+66oOr8nehkSDbLqaQKm+8Z89Up6LFO?=
 =?us-ascii?Q?WV43p8o1lpaR484iAcNLKR9wdpA1+7szupv399pSjAUpaYJltI+SLYKzCrVC?=
 =?us-ascii?Q?Up9T3GQ2mvUnn758pTguOqsFpFSnv1J+l3dr1m/Lrn/whRj7e4dzr1Yrfkmp?=
 =?us-ascii?Q?W6GbH4/NUgvbQnXgev49sg8VUxkvQfBRmxvd6PZKifA/8odpeD8r+jGUk2nE?=
 =?us-ascii?Q?s++rsaA3vgk1DzdbUm+iuo2yZef8hKtDCq6Oj9S5WJVtUG/bUSRJe1N06lfo?=
 =?us-ascii?Q?afvIsy3UJc9QQpcUkMmQSjfBkQCL5FbY0XJIgrClGioKIC6/Lj0drgWzouml?=
 =?us-ascii?Q?O8WwxS1ffX58GkCFxwZSOn1ZIA5IAJ7FpJJxCxoN68HdTBxTxDl3hgVUWVue?=
 =?us-ascii?Q?HvQ8MgX7EJImCN/KrIIqbafPFKQOu95BM7E2EmBWbOwe6uiE0Z+Zbzp8iVCd?=
 =?us-ascii?Q?phmc/ge419XvJjP78Hw/ZtFjHI2c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DXcNwaEVd9VVJ2AZTO9S8EVqSDAW2kSGcLL8/DdVSFGUvFYEQxUbZv8KqYse?=
 =?us-ascii?Q?DgMqCvzK+nslm6wlCqlUH17Q3Zh9jKNYkyvEKsbjMA9exRJqqn0Abnr8EnSj?=
 =?us-ascii?Q?pbwaA0rP4JcDSy9adO0LgylsjUyEfi1+DsmIRwjNBaf4NXi2C6iRmlQIZdv+?=
 =?us-ascii?Q?hoQ3PPK+YFYgww9Hvl0pTZspwiogVI1PhU7cO7jp1DACQgv58XzVa26CqO4j?=
 =?us-ascii?Q?pAhSAlFqlBLxJRRfUUeR2gl/26LNr9NWjyb0rOkfjfb0xb/8Kf7nY81wlzZM?=
 =?us-ascii?Q?ALcLN1AiSeVrZCIoZZCyQj5FMmUPIaAKdntB18ig4TYndPI7QVjN7JMuZw6F?=
 =?us-ascii?Q?3f3jeI5CK/Mio7YA9p7lfEz7AvKq3eMBHjvfHv1u9fh2tonXDYmsL+q1NEbx?=
 =?us-ascii?Q?WeoeCe5Zs9mQrFAOI4AIuTiITa3kX2UjNIsOJFahPz8hxVlPNImwTP8o445M?=
 =?us-ascii?Q?M6+5RluipH1qyZjcQ7uh2NMqJtYFC2tC6nlSJNOyGdun/478C+R1iCVuCH5j?=
 =?us-ascii?Q?33zGzwaJUi8FYBs3StH+tdmOvoFHV1atvxDlP98E4LeJA+p+HvN83EvAiAhe?=
 =?us-ascii?Q?cKlgpshe2O5PJMQG5J89LpN9OSa+vHreiWS3Hmpfmqr+73hKgrtiyx3YO2T2?=
 =?us-ascii?Q?5dQvTBPNn5+5qXZv8Qn27sfP5MVWLzgWok3NwoRBo8SFSunpO0tEPEVTp5PJ?=
 =?us-ascii?Q?DtJZNqyuwk/yMZOODvxxKXWCMWgpIpDL6nHV2mT4+qT9d5/H7U8TMsch8Trz?=
 =?us-ascii?Q?39eHa6xSqOfmzS/DvtWZQIy+cC1ddtaqWeh49ZsnvRsLhY1AJhSAea2RCqND?=
 =?us-ascii?Q?8FX+1kPJ9qKVza36alMMoyy7DhFAUAZ6hp02tZrH4pFcX7ieqiiRDYIkqgaA?=
 =?us-ascii?Q?rP3VkeHGhF5o52ZzwLc3qrlWBrdBMAhlBuGx0DNeanVLyKetGW3z1k8qA+fY?=
 =?us-ascii?Q?rcNIsAn52f24H9bJsS2be3QpF/i1kxiAIeIJlPE//+hx+BEkoNhQ/rO9cZsg?=
 =?us-ascii?Q?oi4dQBgc08P/4JL3xblbF/GMpKD69og3GD2JEC+43X/9FVp/jKrXw7pq4AvZ?=
 =?us-ascii?Q?X/7ZM/+T6XIBXNRVP7z3biDopDoFDbmPExC4Be/c0wxNF4YuU+mACXias4jm?=
 =?us-ascii?Q?2lHsnOn5zsWSdqWjHzzMjKRUulH1OQQxFPIRldAskb1IJ2qomCSG8h2tDfN7?=
 =?us-ascii?Q?cC8u/Nm+9JMrQScLEt81nGG9+MvIXzoCxLxaVimSTCaFS7TnzMPHqFvtoAot?=
 =?us-ascii?Q?y9DNWHWpGXrNzAhk2928kcCR3APKIT2uKguoSpj2hdz+2mzyvAl4iunuzWZa?=
 =?us-ascii?Q?AsVox3PQI5EY3R+qZTj+I9MOGMCc9UiEUX6rNnFKL3Avg1eCtp/59vbqONuv?=
 =?us-ascii?Q?JK+qeBtyMpg8TYhti1br4tl1OSEOBl2AYkwq0e23p1uqqLtA3T+bXwgoiBBj?=
 =?us-ascii?Q?zi3rzg6lxMB/KsPqpH7ihJCszKl1tL6ktoBdZsqDtFCIyYiM9Y3w6JEx+xHZ?=
 =?us-ascii?Q?uWEbxjzwSjN+5DyYTN0EVLx7fkbiTnmN4ldSf3HelrYtn3n5E19FvUcShG76?=
 =?us-ascii?Q?A1m3Hi9Z+0b2U5LzeUlOorKL8nLZGNYGTQ4/MhNQ9nHciqEWL4Dhp7A7cv1m?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa675c8-3972-479c-adfa-08dcb79bcde5
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 11:18:18.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzhinBOX1g4FIUESEoFfmCcJDeRNbyolAz+oX0oOZNwApuh1Fs+/KCyVEQbH2EjypGyHWZtKC5xkFJp9oUnK9cTWop14Li7yl4TKwMTt1s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5519

WWAN device is programmed to boot in normal mode or fastboot mode,
when triggering a device reset through ACPI call or fastboot switch
command.Maintain state machine synchronization and reprobe logic
after a device reset.

Suggestion from Bjorn:
Link: https://lore.kernel.org/all/20230127133034.GA1364550@bhelgaas/

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     | 46 ++++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_modem_ops.h     |  9 +++-
 drivers/net/wwan/t7xx/t7xx_pci.c           | 53 ++++++++++++++++++----
 drivers/net/wwan/t7xx/t7xx_pci.h           |  3 ++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c    |  1 -
 drivers/net/wwan/t7xx/t7xx_port_trace.c    |  1 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 34 +++++---------
 7 files changed, 104 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 8d864d4ed77f..7254032d01ab 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -53,6 +53,7 @@
 
 #define RGU_RESET_DELAY_MS	10
 #define PORT_RESET_DELAY_MS	2000
+#define FASTBOOT_RESET_DELAY_MS	2000
 #define EX_HS_TIMEOUT_MS	5000
 #define EX_HS_POLL_DELAY_MS	10
 
@@ -167,19 +168,51 @@ static int t7xx_acpi_reset(struct t7xx_pci_dev *t7xx_dev, char *fn_name)
 	}
 
 	kfree(buffer.pointer);
+#else
+	struct device *dev = &t7xx_dev->pdev->dev;
+	int ret;
 
+	ret = pci_reset_function(t7xx_dev->pdev);
+	if (ret) {
+		dev_err(dev, "Failed to reset device, error:%d\n", ret);
+		return ret;
+	}
 #endif
 	return 0;
 }
 
-int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev)
+static void t7xx_host_event_notify(struct t7xx_pci_dev *t7xx_dev, unsigned int event_id)
 {
-	return t7xx_acpi_reset(t7xx_dev, "_RST");
+	u32 value;
+
+	value = ioread32(IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+	value &= ~HOST_EVENT_MASK;
+	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
+	iowrite32(value, IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
 }
 
-int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev)
+int t7xx_reset_device(struct t7xx_pci_dev *t7xx_dev, enum reset_type type)
 {
-	return t7xx_acpi_reset(t7xx_dev, "MRST._RST");
+	int ret;
+
+	pci_save_state(t7xx_dev->pdev);
+	t7xx_pci_reprobe_early(t7xx_dev);
+	t7xx_mode_update(t7xx_dev, T7XX_RESET);
+
+	if (type == FLDR) {
+		ret = t7xx_acpi_reset(t7xx_dev, "_RST");
+	} else if (type == PLDR) {
+		ret = t7xx_acpi_reset(t7xx_dev, "MRST._RST");
+	} else if (type == FASTBOOT) {
+		t7xx_host_event_notify(t7xx_dev, FASTBOOT_DL_NOTIFY);
+		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
+		msleep(FASTBOOT_RESET_DELAY_MS);
+	}
+
+	pci_restore_state(t7xx_dev->pdev);
+	t7xx_pci_reprobe(t7xx_dev, true);
+
+	return ret;
 }
 
 static void t7xx_reset_device_via_pmic(struct t7xx_pci_dev *t7xx_dev)
@@ -188,16 +221,15 @@ static void t7xx_reset_device_via_pmic(struct t7xx_pci_dev *t7xx_dev)
 
 	val = ioread32(IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
 	if (val & MISC_RESET_TYPE_PLDR)
-		t7xx_acpi_reset(t7xx_dev, "MRST._RST");
+		t7xx_reset_device(t7xx_dev, PLDR);
 	else if (val & MISC_RESET_TYPE_FLDR)
-		t7xx_acpi_fldr_func(t7xx_dev);
+		t7xx_reset_device(t7xx_dev, FLDR);
 }
 
 static irqreturn_t t7xx_rgu_isr_thread(int irq, void *data)
 {
 	struct t7xx_pci_dev *t7xx_dev = data;
 
-	t7xx_mode_update(t7xx_dev, T7XX_RESET);
 	msleep(RGU_RESET_DELAY_MS);
 	t7xx_reset_device_via_pmic(t7xx_dev);
 	return IRQ_HANDLED;
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.h b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
index b39e945a92e0..39ed0000fbba 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.h
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
@@ -78,14 +78,19 @@ struct t7xx_modem {
 	spinlock_t			exp_lock; /* Protects exception events */
 };
 
+enum reset_type {
+	FLDR,
+	PLDR,
+	FASTBOOT,
+};
+
 void t7xx_md_exception_handshake(struct t7xx_modem *md);
 void t7xx_md_event_notify(struct t7xx_modem *md, enum md_event_id evt_id);
 int t7xx_md_reset(struct t7xx_pci_dev *t7xx_dev);
 int t7xx_md_init(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_md_exit(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_clear_rgu_irq(struct t7xx_pci_dev *t7xx_dev);
-int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev);
-int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev);
+int t7xx_reset_device(struct t7xx_pci_dev *t7xx_dev, enum reset_type type);
 int t7xx_pci_mhccif_isr(struct t7xx_pci_dev *t7xx_dev);
 
 #endif	/* __T7XX_MODEM_OPS_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 10a8c1080b10..2398f41046ce 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -67,6 +67,7 @@ static ssize_t t7xx_mode_store(struct device *dev,
 			       struct device_attribute *attr,
 			       const char *buf, size_t count)
 {
+	enum t7xx_mode mode;
 	struct t7xx_pci_dev *t7xx_dev;
 	struct pci_dev *pdev;
 	int index = 0;
@@ -76,12 +77,22 @@ static ssize_t t7xx_mode_store(struct device *dev,
 	if (!t7xx_dev)
 		return -ENODEV;
 
+	mode = READ_ONCE(t7xx_dev->mode);
+
 	index = sysfs_match_string(t7xx_mode_names, buf);
+	if (index == mode)
+		return -EBUSY;
+
 	if (index == T7XX_FASTBOOT_SWITCHING) {
+		if (mode == T7XX_FASTBOOT_DOWNLOAD)
+			return count;
+
 		WRITE_ONCE(t7xx_dev->mode, T7XX_FASTBOOT_SWITCHING);
+		pm_runtime_resume(dev);
+		t7xx_reset_device(t7xx_dev, FASTBOOT);
 	} else if (index == T7XX_RESET) {
-		WRITE_ONCE(t7xx_dev->mode, T7XX_RESET);
-		t7xx_acpi_pldr_func(t7xx_dev);
+		pm_runtime_resume(dev);
+		t7xx_reset_device(t7xx_dev, PLDR);
 	}
 
 	return count;
@@ -446,7 +457,7 @@ static int t7xx_pcie_reinit(struct t7xx_pci_dev *t7xx_dev, bool is_d3)
 
 	if (is_d3) {
 		t7xx_mhccif_init(t7xx_dev);
-		return t7xx_pci_pm_reinit(t7xx_dev);
+		t7xx_pci_pm_reinit(t7xx_dev);
 	}
 
 	return 0;
@@ -481,6 +492,33 @@ static int t7xx_send_fsm_command(struct t7xx_pci_dev *t7xx_dev, u32 event)
 	return ret;
 }
 
+int t7xx_pci_reprobe_early(struct t7xx_pci_dev *t7xx_dev)
+{
+	enum t7xx_mode mode = READ_ONCE(t7xx_dev->mode);
+	int ret;
+
+	if (mode == T7XX_FASTBOOT_DOWNLOAD)
+		pm_runtime_put_noidle(&t7xx_dev->pdev->dev);
+
+	ret = t7xx_send_fsm_command(t7xx_dev, FSM_CMD_STOP);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int t7xx_pci_reprobe(struct t7xx_pci_dev *t7xx_dev, bool boot)
+{
+	int ret;
+
+	ret = t7xx_pcie_reinit(t7xx_dev, boot);
+	if (ret)
+		return ret;
+
+	t7xx_clear_rgu_irq(t7xx_dev);
+	return t7xx_send_fsm_command(t7xx_dev, FSM_CMD_START);
+}
+
 static int __t7xx_pci_pm_resume(struct pci_dev *pdev, bool state_check)
 {
 	struct t7xx_pci_dev *t7xx_dev;
@@ -507,16 +545,11 @@ static int __t7xx_pci_pm_resume(struct pci_dev *pdev, bool state_check)
 		if (prev_state == PM_RESUME_REG_STATE_L3 ||
 		    (prev_state == PM_RESUME_REG_STATE_INIT &&
 		     atr_reg_val == ATR_SRC_ADDR_INVALID)) {
-			ret = t7xx_send_fsm_command(t7xx_dev, FSM_CMD_STOP);
-			if (ret)
-				return ret;
-
-			ret = t7xx_pcie_reinit(t7xx_dev, true);
+			ret = t7xx_pci_reprobe_early(t7xx_dev);
 			if (ret)
 				return ret;
 
-			t7xx_clear_rgu_irq(t7xx_dev);
-			return t7xx_send_fsm_command(t7xx_dev, FSM_CMD_START);
+			return t7xx_pci_reprobe(t7xx_dev, true);
 		}
 
 		if (prev_state == PM_RESUME_REG_STATE_EXP ||
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index 49a11586d8d8..cd8ea17c2644 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -133,4 +133,7 @@ int t7xx_pci_pm_entity_unregister(struct t7xx_pci_dev *t7xx_dev, struct md_pm_en
 void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_pci_pm_exp_detected(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode);
+int t7xx_pci_reprobe(struct t7xx_pci_dev *t7xx_dev, bool boot);
+int t7xx_pci_reprobe_early(struct t7xx_pci_dev *t7xx_dev);
+
 #endif /* __T7XX_PCI_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 7d6388bf1d7c..35743e7de0c3 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -553,7 +553,6 @@ static int t7xx_proxy_alloc(struct t7xx_modem *md)
 
 	md->port_prox = port_prox;
 	port_prox->dev = dev;
-	t7xx_port_proxy_set_cfg(md, PORT_CFG_ID_EARLY);
 
 	return 0;
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_port_trace.c b/drivers/net/wwan/t7xx/t7xx_port_trace.c
index 6a3f36385865..4ed8b4e29bf1 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_trace.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_trace.c
@@ -59,6 +59,7 @@ static void t7xx_trace_port_uninit(struct t7xx_port *port)
 
 	relay_close(relaych);
 	debugfs_remove_recursive(debugfs_dir);
+	port->log.relaych = NULL;
 }
 
 static int t7xx_trace_port_recv_skb(struct t7xx_port *port, struct sk_buff *skb)
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 9889ca4621cf..3931c7a13f5a 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -213,16 +213,6 @@ static void fsm_routine_exception(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comm
 		fsm_finish_command(ctl, cmd, 0);
 }
 
-static void t7xx_host_event_notify(struct t7xx_modem *md, unsigned int event_id)
-{
-	u32 value;
-
-	value = ioread32(IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
-	value &= ~HOST_EVENT_MASK;
-	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
-	iowrite32(value, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
-}
-
 static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int status)
 {
 	struct t7xx_modem *md = ctl->md;
@@ -264,8 +254,14 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 
 static int fsm_stopped_handler(struct t7xx_fsm_ctl *ctl)
 {
+	enum t7xx_mode mode;
+
 	ctl->curr_state = FSM_STATE_STOPPED;
 
+	mode = READ_ONCE(ctl->md->t7xx_dev->mode);
+	if (mode == T7XX_FASTBOOT_DOWNLOAD || mode == T7XX_FASTBOOT_DUMP)
+		return 0;
+
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_STOPPED);
 	return t7xx_md_reset(ctl->md->t7xx_dev);
 }
@@ -284,8 +280,6 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
 {
 	struct cldma_ctrl *md_ctrl = ctl->md->md_ctrl[CLDMA_ID_MD];
 	struct t7xx_pci_dev *t7xx_dev = ctl->md->t7xx_dev;
-	enum t7xx_mode mode = READ_ONCE(t7xx_dev->mode);
-	int err;
 
 	if (ctl->curr_state == FSM_STATE_STOPPED || ctl->curr_state == FSM_STATE_STOPPING) {
 		fsm_finish_command(ctl, cmd, -EINVAL);
@@ -296,21 +290,10 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_TO_STOP);
 	t7xx_cldma_stop(md_ctrl);
 
-	if (mode == T7XX_FASTBOOT_SWITCHING)
-		t7xx_host_event_notify(ctl->md, FASTBOOT_DL_NOTIFY);
-
 	t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
 	/* Wait for the DRM disable to take effect */
 	msleep(FSM_DRM_DISABLE_DELAY_MS);
 
-	if (mode == T7XX_FASTBOOT_SWITCHING) {
-		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
-	} else {
-		err = t7xx_acpi_fldr_func(t7xx_dev);
-		if (err)
-			t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
-	}
-
 	fsm_finish_command(ctl, cmd, fsm_stopped_handler(ctl));
 }
 
@@ -414,7 +397,9 @@ static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
 
 		case T7XX_DEV_STAGE_LK:
 			dev_dbg(dev, "LK_STAGE Entered\n");
+			t7xx_port_proxy_set_cfg(md, PORT_CFG_ID_EARLY);
 			t7xx_lk_stage_event_handling(ctl, status);
+
 			break;
 
 		case T7XX_DEV_STAGE_LINUX:
@@ -436,6 +421,9 @@ static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
 	}
 
 finish_command:
+	if (ret)
+		t7xx_mode_update(md->t7xx_dev, T7XX_UNKNOWN);
+
 	fsm_finish_command(ctl, cmd, ret);
 }
 
-- 
2.34.1


