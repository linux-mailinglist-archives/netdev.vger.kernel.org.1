Return-Path: <netdev+bounces-107875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B382291CB61
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 08:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D561F23438
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 06:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242822AD04;
	Sat, 29 Jun 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="RG3novky"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2163.outbound.protection.outlook.com [40.92.62.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516952745D;
	Sat, 29 Jun 2024 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719642211; cv=fail; b=Y7Vh7XkzJp0tEdmd9aayafQwU1qE9iTTo4dsalnRmQrEpgNgGlREojnQZ3jX+6nAtoGyroADaC0pfVmy6w7kmaO4Rgdi73ue3TfqCzPh2PbKZSfEpiS3BKLA0lOv4rU9AV6thxF0HhFqGwU5/FnlxFSaTfAbAg1+dW/0KFc1j9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719642211; c=relaxed/simple;
	bh=J1plKoMwwnIohPlg9IprBwDzk1FbuN9SOg0Pbrfi6dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ty2FCV4INs44sJO+VPfBw9fI6ZaHrUHPGijKYax1slSscLYaohT9TOTRRoN5pF1KGEs/HzLlzAUWIiGdJvcb72QqE33s6NAIjUqfmvjVGOsx2FvE9w6L+36wDNARz7MT2kWbRwykQAm9ZVO5qfx1DbT9d9UtkE83rURby70wMV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=RG3novky; arc=fail smtp.client-ip=40.92.62.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k79gRkJPinffX3tWPCDliZRSV2kfSF8x6KyO6okiZegpM2MBMZyOWESoL1+K6dy5pT4+asb2XRY9RR0yIdUWLqOvANqk6RB8Xsvv6HhxrZKnSRkX/TBtawF6h0Z7neD27g1bgrCqkcjyBBz08ACC+9ZAcFLDL/UxWePkQIb7K4LxzdpKiJpWKEXz2hWyc1TpI4TP0EE0id6ywvL5onTezFjzbHIOiNitI7Lp4Kyg2MoZDrAW9qtRQV9WqX1DcFwN0M9JxILW7VqLw5O6PpmnS9Re4mPwj2KS1mLXGezJ/GIa5x7AKdjMWFQafZng8J+Nv0APGbGblCfW1X0FW+QDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA1/9qvE6pULtCke8/mcHni7DR6KdO1cfRZalGosODE=;
 b=oGuDgcORX3QJ8Un8EpPVVbRR2uOLCoZ0RJNQ+JWsGiC4TDOjD763Qh6krxR73dlwm46fNJAt8s+4FzRXXhYVbOTTfzIcz1nntjh6rmkCaFXDESBImtVByAEe80hGRn6PtwBfIvAXnXibHKpZFEVmm6MTWhI9TfJR9dLs6bxbXpk/A8c2bwTGpjIWKro5LA1C3P7PeN6yg1DMYlLyeq4dmvJ6ApuioiYtkif13/oYpuivP2P8xCZQ8tCH3RLh2kzpahojk+M9d8aBTIiC6aZRI69FbNZOGU2CuXZwXdoD2uoK+L5BVCYJA7VnZjN60gt4fs08bqpTYPaE2twUa/SRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA1/9qvE6pULtCke8/mcHni7DR6KdO1cfRZalGosODE=;
 b=RG3novkyidxwRkWQ3GoNwv/yJ5PQPQnJeuj2Yt+mQ7km3qiMpCA5MBHB5EjLpURPyxu1YBa4qABjgCoyxjMknyN9vawrhY89K5L+ghIw4f49exTCsNsGvfGnQ8I2TH4g/wam7WZogrdE82SvimLsJwNmUZFjeCEobOr4KxurK28iyO0PekE+5Phx8tMurnADtrXcud1orxlL7WLWKHfd6q+EltGYFbNISo2+t03AuwXHCsuxDMXsopltL+D3VIXt+ELReFwnjM8/JzVZ2ycT5b4nFCEXpaS5LKo8eIxpYEQt77NEJ3aWdh6nB50Iq3tespKbkxgAeio5QUCDap2Buw==
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6) by
 SY4P282MB1915.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:d1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.28; Sat, 29 Jun 2024 06:23:23 +0000
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289]) by SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289%5]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 06:23:23 +0000
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
Subject: [net-next v4 1/2] wwan: core: Add WWAN ADB and MIPC port type
Date: Sat, 29 Jun 2024 14:22:48 +0800
Message-ID:
 <SYBP282MB3528DA698BC712F49B53BB36BBD12@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240629062249.8299-1-songjinjian@hotmail.com>
References: <20240629062249.8299-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ogNmYuuNfcBWq7CdvgSACM/DOw24q5FP]
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6)
X-Microsoft-Original-Message-ID:
 <20240629062249.8299-2-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB3528:EE_|SY4P282MB1915:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc8b739-1c5d-4728-89d3-08dc9803fa3b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	s8CiI5t0d07eQrovZtVJztz97kab7gCXFBTj7yIKDJ+hrIEoqG1WSsOxG23WFMSSAj1npE1SK9UuYiwhJIGOcQb42Xdynhn4fWmhGS5IcswVEfNScESqp2i1E8fLw3eEudeVwMMbk1bjXd7/exCeOZYTqg2Pc8h73H/OMTFGq8HbqQBNz3e+cMrO6m7J5Mjog4hROgnfhmijvhKatMpvRFcN5jU/gV9dmHxRfcTsnaiC62jqPSUf0AFVKduGbpiT+oG5kMZaEBHaRu9mC2fJBB8b3uV1o0Xgw904H38qpzBJqNA+EHK9AzqaHNBykF7zchsrSuOm/w86K0/BkiswL7EDbFDXdRc2FGwRgG/6htd7gyIUGS5/ke4rbDiBMN7w5Rvh67RubbZAi24XuvbPZE4RcwV2uOlLKIiTko9W5O6YZ30awTap0I3IUlbmonedIv8uRDY7qkOp+dn1efKs5qs57T1CK/y/wh3MVPNDafyvjTKgnzjLb1mVLCtDNkIcmJfb1db6wCd0mfu58z1sU5Hc5gIt3ewnrkAdyrSnph7bjF4GHZk9W5FI4DZgRxT+YlVyF4p8XgynJ1xXSU/nINq5rSDLzrVQbGjOwTUIGQVVUYo6ApTI01rI72ZfMeHG9KzwSNLYPnp8fiVosWuyZg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+EDgPPuAC0n0fIQEAoyXFYzIroU/NA4VOFuU5sCetMu5ASyO7fGvzqbbDuk?=
 =?us-ascii?Q?i+JVQsTCoTbEWNlgjJ24OXDJrwWNsTf4feloQLSFTBDNHZkPrQJ+eCW6Lfns?=
 =?us-ascii?Q?hkDFc7Mnhav605U9nAks+8l7HqjpSS56NdcMoCpOcW8EJ4aWi47CwStkpcV1?=
 =?us-ascii?Q?RXwLhCncdsWfC9WhqbrNCWldA+WTdwclZBysmXNvsP1OA0gwUS5kNr43VmYk?=
 =?us-ascii?Q?zpxmrTpOQtRXzfAtJZk8N4u31hC9fSTEJHYXNvhjH3ide8kund47/k/40csi?=
 =?us-ascii?Q?TwNSoD7rw8AE7I4TSAjggbrn1r+0nvzUHbSzpfMPBVRbrwAjTFpbwiw0ucHi?=
 =?us-ascii?Q?UZMWFOCrqYeoAf9QvvGtI9qIKGvK4A3tvV2Xx5Bw/bsoi3Le2LV7EI7L6/Mp?=
 =?us-ascii?Q?7xn4XhnCs9QKfKob2eL02shpT3e7mKqbkIQvtLO6O1ioK5OYQl5iOS9tTI41?=
 =?us-ascii?Q?dCR2euViX6D3X+Qwlg6gUzzKX8btDDetI0Di/CmODDsRgXuvneHiD5fMOVe9?=
 =?us-ascii?Q?5MDHgL9LS8uqUWg6t/PO9/Cis6aPH3Sgp3FOl+tEztShD/wLm2Lgd+VCOtFr?=
 =?us-ascii?Q?03MdUdNFx9+0A9jhR1GeN6T2DeJ3KvMrT/SBqMA7Fq5dWc6fPl/Ms5QfMoqq?=
 =?us-ascii?Q?K3V5pog+qiinmFuE+II+NoThBG/Oj6ygyBg1Ri/LwD4PWP5t/bMLNbtBFQT8?=
 =?us-ascii?Q?ZNV3XC1WrHYKlONco1n8FmF7c7JH+iNARdNHsRI3xq178Uw7dcJcfzQB7HYm?=
 =?us-ascii?Q?eBLoPQ22Fq8ldO51R+CaFqKP/CwsDXFjWV/VFGY3XckldjP69TuWHNpBt9J1?=
 =?us-ascii?Q?f3KsP4ayxrGmCZwn9d1+BvnFVAOS+5T5/g/hyDG2nbdWvjig/Bez7fh9T7iG?=
 =?us-ascii?Q?V7ytW3PUUb44xDGeDTjEqnMDyHIqpiYZ7Thn+wmuw8IGtJ23pM9pJxbPq8d9?=
 =?us-ascii?Q?x9JEPPAZhCjvrNUU3BN0rRXSGkGgzsVd2cFMU2qWasMNzLCN775deBG/OaFu?=
 =?us-ascii?Q?qvMy8jHOt7omB7L9NTZCZYyr7z3uN6b+jffZWh4mMJW2ku4ODDzWJageKJUE?=
 =?us-ascii?Q?9YGLQvmfXaYNllLnKV+dMhyglV51F/NQApo/B+QF81DcdSPJl7uP14sTykHv?=
 =?us-ascii?Q?035whkqc016MYP6pM1x4Eq1ywlFzmNacxOByMpBrS/YclBC2bfgW1Gym+rxb?=
 =?us-ascii?Q?wVp4CRW7HFPHeTES8YeeG9IA7nx+5zSwsr9U0YM1Ew57o2p38rFEDIV5sWBR?=
 =?us-ascii?Q?K7YoKScJf+mqY2gqZ+f/?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc8b739-1c5d-4728-89d3-08dc9803fa3b
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 06:23:23.4355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1915

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


