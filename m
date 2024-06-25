Return-Path: <netdev+bounces-106404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F43991618F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFA4287029
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9101494BF;
	Tue, 25 Jun 2024 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="CCwQKowD"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2172.outbound.protection.outlook.com [40.92.63.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FE1494A4;
	Tue, 25 Jun 2024 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305160; cv=fail; b=pgwDTsi1qAGolCgc9fGEpBg7r70ZKjgtqzPz4/SrsIOwiTjkCZ91Hp41PpfrYqST/KKse2EyaSTex4TJyQnyajN/0+vS7JTHbpGGoag4iX0ip5cIRCZ+DsrWLqHt/sjoYqFJIg9+pkziKIfvPU8yhSrDZPhf1fi8rcmPzSEF8XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305160; c=relaxed/simple;
	bh=13WyygAoTtleHJVW/31E0DjzqgBOTGMfg5RCAMEzpk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DPNXa9o7aP9EMQMqimEAtzgoF5WCTmD2w3YSQkLkITT6j6Tqy81A7AImdfTPGOURqLujQ0+g6FekHz6eBX2wshG1mjJssUrUSCFoS+snnElS/snyZArnsZucedMosLOtRmuQz4gk5hUqsGEpFWyamO6c7zkTBk7oc+dD8tjbmAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=CCwQKowD; arc=fail smtp.client-ip=40.92.63.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CombO4IYVe84oyLaXhca65ImL6tuheczffFxeH2nF5tWOLdsJURPYHJKI5hLYpdWGqt/xS1rkgwg58+1T/F4H7Iyzv/SF0x4nRteNmXnH5wVpelnHGoFQFwL/DCbpHLo8mifxJsGPR+bCuwx91rbxvH3P+1OmBpVG+O9bJjfyVgmZDFAQgCDA9MgJ7NCvpdYQABvWf12S1hCEIto1e25ukb5JrFZwmDI/QemlDvuc5NtHf8t7HdrA3jFeK4CU3u1UlcEm16Ya2ioRjO3fcWGs4GMWnqtIhzM6xlI9H1h19by4nRFfrBkoUbxHta1vUpwCayXTtb/XVPyDQirBzyBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0w5KA+Wb4CAl7EA2PrAgtfS5f2ezfrX0Aa/IHcVtW8=;
 b=OFa5KqEuPDVqO/llaYA+dU+EYgo52oaUUBFO9nOPPJ9Leuq3VUXE7JCb3ASbI6Hc3MteLdUCB7RP/y6NNHF/k8kX7FwyWfNmPMidTLl5LFhuTPxgBFLFMBEMq0VVACgbAkFIE/88NUalkizwQa3HmyWRbhK8wUyTQ/m+0M6i0fh2Je80+qzWfs4PGcKtAj7bSVZryqEaOViZoes6QzzsaIwQVZwe58n4RPosIwdMPN2FdXUa5+tQpppvd9ABBNz6rQLkYpVjI4C+uW1o3duENvOpWfrE+KbbyOb5oXh/ViejBUXktY+DeRod5m5VVGM4L6vf1JDVXuaSj9blj2CFdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0w5KA+Wb4CAl7EA2PrAgtfS5f2ezfrX0Aa/IHcVtW8=;
 b=CCwQKowDpS0KfNfJEybH3ceSfC6fVOXWMW7BGhIYpBRqYuEjf4pN4kVg7YGRT/tbonqUuT3slV5twxNb8t64ypACVpXKtyklMI0EpoKzYbY+GFV41gkFSSiE72vO7YaJ65JQMb9A3zUR0mCWlWmv0GNlkKLzdfL1/XVs2UFYmQ7CcG0eRSmalBqWX/OlH0B4bMYMBaATlEkwpJShzX68t+XzG/FoVA0Ky+NmfbtXtMit/hzup6fWjDOS1yKKfYz3RACAX8kk2tYPYucQUDFrQQ7tKnkg4tpIXSBl1bmAWBVSNFmjDwujEnAAP0uIkfApIMJeTgggaOtfHRKFh1K9Jw==
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6) by
 SY7P282MB4874.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:27c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.28; Tue, 25 Jun 2024 08:45:53 +0000
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289]) by SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 08:45:53 +0000
From: Jinjian Song <songjinjian@hotmail.com>
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
	Jinjian Song <songjinjian@hotmail.com>,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v2 1/2] wwan: core: Add WWAN ADB and MIPC port type
Date: Tue, 25 Jun 2024 16:45:17 +0800
Message-ID:
 <SYBP282MB35285A10C24927915FAB42CBBBD52@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625084518.10041-1-songjinjian@hotmail.com>
References: <20240625084518.10041-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [UzTr5lPa28fltpQDqr0/1ttHhNr1QUn9]
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6)
X-Microsoft-Original-Message-ID:
 <20240625084518.10041-2-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB3528:EE_|SY7P282MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: b8bcf98f-3de7-4e51-9a16-08dc94f338b6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|1710799023;
X-Microsoft-Antispam-Message-Info:
	4/wru2TnrUnajx4346HVci76Gmshc3o3Q9lyWBnf3cA3fNUOZlNwV9n9kJyOp4Pt4gYSeckxAAfgDLR6Ao5NL4bUVB7AxDMOBV0CK2xZl1fbvvvHQHDzBusXgpiTDHSVRlUNeXndOZ+TgtJe8qTN5KKlsoHmDr4IUrTFI99YkugqVjhqgsbmIASXDyi6vcLzngqaYs1wk496LlGCYQRRkvplpA0kohVjUQ0Ag77ytdT7DpadCUNH9FU511iADUvKrFlh8aFRkOW67EMkkpQYzW3QFrQhfm48iNalTqNy5l75EhrO0D9GyjfwLQET14QhiiueikWMg3VkKIoYkT+hIHjtaJuIORnOP9x/NERB4xSdhVE+o7pUcW0yCn5Ob2MaDvtT01hh7ajc7QYhBDgPBDoYFUADuaLcgSG4V9iZ3zT+4uh7FlMTciU65OpyOgbwc0mf+3r+0GK4Gbyk03kAX+fjseT5XYHHnjmg+zTvCL83iKu9aNLrfUESx2gvGPDAggaZoGeU/DcdGie0D4epcEISCfd8xLkO8Bl14ZSi8kUptZ/oqtUTnKFK/GuVCv2kSRe+qvJZMulTRkC3Z+aR9iCiXMgKEygi4uckdO1BFqY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?09W7xHNvVDQR1AcGYp0/4PmySXyGzfzaE7l+Fx0RtFQAxQXKXZ1Y2o45lRZQ?=
 =?us-ascii?Q?FAYlFYgGJ3xC4Hz6Oz7UB4YJ2L/fRsF98fZmBDDfjF3cZjIffYbvPFVdt4IB?=
 =?us-ascii?Q?Mck0FnEG3xnueKxUrBTY/QQEnhUkqk8ZUp59X6mOEpnS7pW5VqDLnXP+0kTH?=
 =?us-ascii?Q?64ng8cYl4zi/El1PuuewbR8J0e18RuWW8fg/0J844MjntlZXsC5Mwn5Ot/3S?=
 =?us-ascii?Q?HtcQLIYGiDTBrRXy3Ekzi03GtJLkSUOePkdC4cs+Nlxz7qxfWOn+FjmVWq/T?=
 =?us-ascii?Q?GHyhCaP24yoJVTrPMMyM0FwJp4BqqtScUmvygPlCx8fU1ZjG5GBNaEsKkw++?=
 =?us-ascii?Q?ou0Y0JK1Aand6YhaBi9Q/Uw8Zihk1VQyPIwybbUxONtiDRJjrm769ZbQfVwb?=
 =?us-ascii?Q?R0J9a0inK4T/nGgz0sak3Lr3fL196KxhRrLPMsbz/KSnTFk+1o7mhQlhU1nJ?=
 =?us-ascii?Q?OQp5cuHThm04j/QSFtkbV0+Uic2B9QuKfIweUM0Ne4cmlkolZq3uixo1yMq+?=
 =?us-ascii?Q?lmoF2ma/M1G3vmJBqVKHrx7AyhbIpJBpPdo79WXra5OaC4SMYK8qeX+iqhKK?=
 =?us-ascii?Q?3/bj3wND+likXC22JrNUZCwzuElqEfqY+xnAZiRiP9Geb66HOVWyuEheQMwz?=
 =?us-ascii?Q?JcgHzsHQ7nKlyRLANbrkHGhJ4nBpKG+9JBSqx8mB0mgYdlyiXMy/+KsXo156?=
 =?us-ascii?Q?OJlR3ZO5GmwsJJQXhoA4PhlfI6VOEYrgmrcF17+sxwwabHDljFFs4Lw867Zy?=
 =?us-ascii?Q?OOZFu7qfS1jVv5G5gVa68nwjBKBGAca4ax3EsPIdvHMIIMWw7V8EqjjewJO8?=
 =?us-ascii?Q?X4vEWayCSqrvTRNGxPQ+RD/Xu+xqrfXiG0oycj5gmYWJfjxCyyQ3HHtGeDJe?=
 =?us-ascii?Q?FOfckyfYCG2FIJ9HcjqzcPpNKZdVxUsRp9gaPHUdrs65nY3trVOilkecPt7t?=
 =?us-ascii?Q?73zFWAn4yHYF95bGLyII6UHeHgdpkwj011yErcFwkkleWeOaltDJq+FO4M/j?=
 =?us-ascii?Q?TYfRWoKCELi9f9l2Hp2BvgaVQrK0aRDriPV0LAgV179XDvDlGKuzkAzkaDFl?=
 =?us-ascii?Q?5C2CJ45ExT/tcsCoq5a8HXH2hEHfZn8JHuKhjub9/oO3I5Iv1jeN+PYzcrrS?=
 =?us-ascii?Q?1aa7WEGn2eFqC8uIVAaLpw1dI41itWMMeEIyqj4gJYFx+2+6j2a5U5TTm2XP?=
 =?us-ascii?Q?aAVATngcayGiOAKXE3zoo4nxw3WtO9XT1AegnxeZfOLr7hUDDoQQwyDSyGeN?=
 =?us-ascii?Q?kYh9Sa1XVBDZJi1nf1pD?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bcf98f-3de7-4e51-9a16-08dc94f338b6
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 08:45:53.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4874

Add new WWAN ports that connect to the device's ADB protocol interface and MTK
MIPC diagnostic interface.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 drivers/net/wwan/wwan_core.c | 8 ++++++++
 include/linux/wwan.h         | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 17431f1b1a0c..5ffa70d5de85 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -334,6 +334,14 @@ static const struct {
 		.name = "FASTBOOT",
 		.devsuf = "fastboot",
 	},
+	[WWAN_PORT_ADB] = {
+		.name = "ADB",
+		.devsuf = "adb",
+	},
+	[WWAN_PORT_MIPC] = {
+		.name = "MIPC",
+		.devsuf = "mipc",
+	},
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 170fdee6339c..79c781875c09 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -17,6 +17,8 @@
  * @WWAN_PORT_FIREHOSE: XML based command protocol
  * @WWAN_PORT_XMMRPC: Control protocol for Intel XMM modems
  * @WWAN_PORT_FASTBOOT: Fastboot protocol control
+ * @WWAN_PORT_ADB: ADB protocol control
+ * @WWAN_PORT_MIPC: MTK MIPC diagnostic interface
  *
  * @WWAN_PORT_MAX: Highest supported port types
  * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
@@ -30,6 +32,8 @@ enum wwan_port_type {
 	WWAN_PORT_FIREHOSE,
 	WWAN_PORT_XMMRPC,
 	WWAN_PORT_FASTBOOT,
+	WWAN_PORT_ADB,
+	WWAN_PORT_MIPC,
 
 	/* Add new port types above this line */
 
-- 
2.34.1


