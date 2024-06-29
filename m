Return-Path: <netdev+bounces-107872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE4391CAF8
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 06:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02094B22D72
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 04:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E037B1EEE3;
	Sat, 29 Jun 2024 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="i7yajGSm"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2184.outbound.protection.outlook.com [40.92.63.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E262BAF3;
	Sat, 29 Jun 2024 04:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719635378; cv=fail; b=WsuTO3wx4CdCpfixRofY8JxjvgqSlHz2bsW0pPFRV22ZyakbJ7QmR59jy2HD53Vfm6LCIKo9NxmCMPvPVTcr75Hrn8CntQ7gTyDmUo4Udxe21uHRduGWRmap+Vz3lNFUfg3tPspY4uxLPnlJ+m9+WlYgmId0AeHoW8OL71CZTrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719635378; c=relaxed/simple;
	bh=J1plKoMwwnIohPlg9IprBwDzk1FbuN9SOg0Pbrfi6dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=auRrmkdBHpYz8f44XzgdR1OjaBshIleIJ4S6LxgGVS+1OwUqfw6OHkpRGImDFObWJzVNEnu7JxzfqaXfENnHBxBT2JEryvcQ8surQUTkO0m9sQn0xmNjD4d9rta81S4GySWDDS5jphXO6IGLT4Zlz1B/eRf/DI3Hz5nUfKt0GF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=i7yajGSm; arc=fail smtp.client-ip=40.92.63.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iY4tXb7noDrP+gvVwPJskZIj3vihlvUB67lw/RCCRwKjVsc3d0i87iOGs3ihg2Q4oWQfQMlnUNYtPUIbB4kZ+pXx4Xgwubi8W3UMetHaysjy1Xp5Q5/7TA4GYQcxaj96lsfgwOv4v5AeCtwgX/+5JmoHih6GeGKOXTZ5YNfp2vWzdAWO4rngRnaiQ0dwOcdyUoxtdIP3BbW7LB8rBK+i+M9c+bf8YbV/Dr53Sqo1hRB+qVD80ZoHK7aCtOlenaKBpOySzwvd1x6JFJ+QF0w0MtYp0uSF2Q+1k4ddTotp6I+OpZ0yoyhxrS3o/HG6y6+8eBw043HKXptJ6FrFfrjx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA1/9qvE6pULtCke8/mcHni7DR6KdO1cfRZalGosODE=;
 b=YzF2Bnz7H0VnIef8Jx7n8I03z+dZ86Uzt0OFollvk4+Z6aEZMd+wXLk1stDlAXr4gM/T2137RirbxEcHUX8zeNfKdTnKvqiTXNYlltAm4E9i1wjKQCmd6Fdo5IdHkX8idyf1yPVawXTUjh58APEKJWeZoVYmcwCt4ipmhHx4ZUE97c4CZf73SN+dJwbJqrVDNMLf9Jm/dv3nTw33x6G1GoC9+IgkeGkzV/3webHQX37CUJSv0M+AR6T40UO72Lw8N4G4c9KltdeX45JFJiBqlbX8w79+rgZ74wuIGggV0rBUou1TRO1nsC0V/eMPNiD/Q7bDEuXvn/rAXCbaKa4AwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA1/9qvE6pULtCke8/mcHni7DR6KdO1cfRZalGosODE=;
 b=i7yajGSmfs8mfuINfQLu8+qpU2dioHRqHLr2qa6ntXt+O76QY5Zz99MhJxPYXIbMJlg8MDSs88StETtHBKFHHNGNmPl8z2FewiYchCggkvJ85Us/BP2dpHv00X0inHf1kqCfyepLc8kJ6TqheIJuKKDRummzPwcgApGIVSeU2cVcGoqsaYrFgpCFbs5TP+6lZGJYLzPjl37y7DQKlz9ZjAnlFmCZODJwNw//ul0JwNk6PO/iIhVBKpQvW7gwiXyrxRz3Lv9Mg43sSnx9+f1j72EbL3UqdlPz51m3iVz1goLTsU/kpYupX6aZ9Tu9J6oJtkvwU1PdJe+PA/E/fLuL7g==
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6) by
 SY4P282MB4160.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1c9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.28; Sat, 29 Jun 2024 04:29:30 +0000
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289]) by SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289%5]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 04:29:30 +0000
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
Subject: [net-next v3 1/2] wwan: core: Add WWAN ADB and MIPC port type
Date: Sat, 29 Jun 2024 12:28:17 +0800
Message-ID:
 <SYBP282MB3528CB846F4A47EB791A4550BBD12@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240629042818.5397-1-songjinjian@hotmail.com>
References: <20240629042818.5397-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/r+M+EwL5ef+ErcvkCLojmyq5my08cqC]
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6)
X-Microsoft-Original-Message-ID:
 <20240629042818.5397-2-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB3528:EE_|SY4P282MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: ee283eb0-ea49-4c28-92eb-08dc97f411a6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	+t92Y8sJLD5QNxm73lIEMLTBsaLHABIZEYFPn751BihNCndPI4YTAsWaRdl090DJUeDS1UthrZkmhEUsV7BMa49GI8CHVNeJCtuVFIBEqJ5gYfDeXZTNjIDN4uATpW4LGbXCdGd0JkMGq9ROP41VAb9tjqSUGlTbAScq/oiSaSTWTcuaWcskzvxjqn7+KJzrRnZqaNPjTWPOOrYGG5iNJ0RC9reWlCfvyS+AmiQx15ET8L54dv8UC8uEJgmyi+ecix1K5m5krp7t5v+yC2478WRAXYmSeEYjm57zR29pYMMXfBvaMJ6Jn7yq4Sp2JLlifsEC9Fpd+L2YRiLdv6qwxLDvrAhO+2MVyUFNrE4/h9P080o5mrC1QTPs08bbonhFv4zqXDWbG/+Md86YkUeaZHtZx2wMIWLgcDub2c5MyVcLStRBn4lIJs2sI1rov7O9CHFNphWDEmFwg31pM4IIb0DNKolJmgAtNoA8Uo+srB2VSxOfQ3UW0mSHsWP6g96ONBqX76e5kIPoO+VtfEV99ZatylnvvgZF3xHoONSzmIcWZzrM/K9pFf0uEXuTjIn9px+SbHFFh7T6E6s3qL5LpN93+j5EkRFsNVHYVvZSPaE+UHhS0JJAGVmrTsVomJ6g12rHZoJdI+TmlRx4FyxKoA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a5xxULcl41HtNMUzV9jKzGkLtAjJViSIHmsOH5CyWeSgoXh8BmMd6stk73nl?=
 =?us-ascii?Q?JFaA0h+l1TPPebWsbMFG4oUsFXEUrvn8zIWHnoodHqrud6xdJyPhjVnI+H8j?=
 =?us-ascii?Q?QjnmdxFetXkeoe5kbrBGnfgFxiVCm8ZwmCSu+PfpLxiYQ0utH6E+fLShLq/O?=
 =?us-ascii?Q?dA8/aPt0XOYY+1UgfRwIXzJ4T/qhIIsqFoVBtJqvMw7qD1+csmcoZnJOmtvr?=
 =?us-ascii?Q?SN7/cpQxvdHHWJG78agqOIsbEahxSkPk3CBV8IlhBMK3mF8vhOnCrLLuRqeK?=
 =?us-ascii?Q?4F/qS7W2X48kM+4mqkb2t0iZKWxqlhNIa1mMxhB/bpb0kUcQA13VFmuytpKK?=
 =?us-ascii?Q?p67badsAU0b6HaphNSdlXQK2VdS+nmK+peWJELoPYVpTwB795Nwtaqsg9H3E?=
 =?us-ascii?Q?Gr9I1wO+WBgK9782rMitQ04K1R+xib9h+UbutrkWM8ceK3vAVcWvI7ULzDPX?=
 =?us-ascii?Q?P+p0YbwzUTy7Ym387IYjKvITII51cEydn22TKlqbYQ03bYRX8aLjQScybf/M?=
 =?us-ascii?Q?IHbA3RhwTMxdke+BrXGt4SWUjTMdRsGya3cWAF0tvD06/VYYJ2BzeTXWCaK0?=
 =?us-ascii?Q?zwZygQlWaOgGNpPMvPIJmVLPvbNwQgkqubZKko+GMY7XH5VulJ6FEXCsKNPz?=
 =?us-ascii?Q?q4rWaoOst04MlRYgoZvQJHyVuxdrJFjGovj1gmhbZFW5N7lazqWGWC0GWjS/?=
 =?us-ascii?Q?qplafDKBU5w2YUweAgsneOqx4RFBxgu+1cy20ZCeV3O1Lchd6MYSCzjZDVFX?=
 =?us-ascii?Q?4YkDzY3OjSR6Fg3+cemofGiXs1kkyRT/cH7vK+zfNOWNwX2c5liYQ0K+jnGt?=
 =?us-ascii?Q?jDFAAygyXBawuX8gCi0ChFykta7Of7uDTYvw2Ft2pYUcRyyXQO+/IDETaxxo?=
 =?us-ascii?Q?zIL3zOz/g6kThJA2AhdNPZ7Xi7h5WFdy+Ai6Iaj1gxmh7/GNDliBBHwcFVsI?=
 =?us-ascii?Q?K8gAvG+MUAfnfzczj8lkzVmefDkcrSUvRTGokZ5Lmq6KEHcf7tOME93KlMn/?=
 =?us-ascii?Q?ALf5FaUC+/HMxIwmL3tQSwc88fZt6i5sNB8OYh3PHS9Vf9U12Sg4/EEjtP1I?=
 =?us-ascii?Q?g0lwkzJ1qLmhDwdxYfTBoDnD+Gb+n30kzX9h0iWIE7QMc9g+4ig/IsUrWIXM?=
 =?us-ascii?Q?qVuSreLS59hP0TQRaqU6mXAaJi8TvgnQwTchHap3YPm+SM+08FpDiOvHBJdB?=
 =?us-ascii?Q?zJkNQ/UN51PVHwLVYXlVw/AVjOjU39YPZW3NBGnqZF4yapnL5N0MRazm5ZuI?=
 =?us-ascii?Q?4/tgYJLIFbP1AWT5IQ8M?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ee283eb0-ea49-4c28-92eb-08dc97f411a6
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 04:29:30.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB4160

Add new WWAN ports that connect to the device's ADB protocol interface and MTK
MIPC diagnostic interface.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
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


