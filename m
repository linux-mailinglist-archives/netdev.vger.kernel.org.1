Return-Path: <netdev+bounces-107871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139B391CAF6
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 06:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282971C21E8A
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 04:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B86B1EEE3;
	Sat, 29 Jun 2024 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="PWwmzqtH"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2153.outbound.protection.outlook.com [40.92.63.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321051DA53;
	Sat, 29 Jun 2024 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719635363; cv=fail; b=V/YDbAOEN9ySiXH86OdZwrW2IVkuobSZjUq+P//3y4qpdZb9syqI52xQL0ZxBzXW/jzfXX+8eRFFC/UgRRTS4oo+iT7gb+Z8l9hqlgChperhasREJsN7XRx/EXCLCMeLm8K3MNfD1sstQKK73Bmao9cZ0nU/d+mWlt3tOjWi9pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719635363; c=relaxed/simple;
	bh=kJn+7gzy9ComQLF2+WpdP8yI8lkPqhHN4/AW9GVE6Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aac75qMCOGhcfSBTZCJhuEszn7iEAIy/uSYOECzbpVBA6wSvWIKPGWwrPyOAfQXXPUkWlck9e3FcNWi1iSuSPeRamTitLd+Zh1HaSY/viLBez9/SDNqXrBSRslmbn0gNvHknMlVd+TiXcDzzx5GWHLDnEdvxB/m6rpfvSa7J6Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=PWwmzqtH; arc=fail smtp.client-ip=40.92.63.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKaiprfPxuRl/Rx0fuUDExtE3LV6JOmQs9W/1/ub5mdNm8RJMEEYgxe+RJfgvGbMsHjXEsv2RXZSDgVqHQ/WyOoFh1mkDbj5CWcqV+lyew6f7h8z37z80sUoeg8iOcp2HoPjha8EmwvKDb7YtouxSqU/HEx+7PJ3m2IXGm7pw1VTIhytneGXF74qgwT2x/imfjDWnylGLb/tqBl5pa8QUwjOK1XKhek0uyDQxydE++krkxa1eNY9hh1e/wWQgZ68wLHuSbPeY75LOE9Vfnr16iJsYUBTWLRoZBWIRfGWNQEvpP5F5vDnt3s8ecICCd7i+YHcswd/cAzZ87K0TrNA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjfStAl4X5APuJGdHfqLtnXkKQl7kdSwd8Ar5E4YipQ=;
 b=RdpTAfrQMFfsH9cL2zGfmKp/qykREMPUwnux14pBmpHkKCe4Sb96nb01MYkU26tKXU2eY81tEPSjMLlRD88gt3EdVHyT24vaubThZMFXlVY69fDmqncTGBtwN7qu6zz8PWQIgS5D81TcrrF506w94GS4XqLDOK5IhR3L9ceT6OzzH86GEIKHtAOpNaxRN4OGOgBLHppi8tuUZcJ+MMPVhCDEDqkWy6toarbA+boXPsrCoaSMK1+Masq6i8CisgyoBsW/gtYFPvYqyXTP4khnIofPORN4TdV7ARFTOiNCbbcuer2M50Ts1b8pl8cKhdS+PQC64O7ISL/s/T6otLxtTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjfStAl4X5APuJGdHfqLtnXkKQl7kdSwd8Ar5E4YipQ=;
 b=PWwmzqtHMRrpi6ukqsXZbKKVrJy12s6w37W7ss0SJCUXrRqvMhD3lclA8qIIIHD3Odp1mLvys/n89jpTJNTVKyQTt5BnMDzOb9pFZhS2DMEQzamYi0hoeSmU1MrV7r4OxRn5dmva/pK+EGs/yGhXw77zCdZqHql0sL9bkNTDDbfM3ThTKRy4RNOrY/3WXL99XXdUzvl/YglIuK2GyddGh8Qe8YCUuAe7IgLm0fXVV7jTn/HPP+DMFvNJa7bgovgOOczZqsjigjvilWvMMcRJXu2313rTSrZNQ4GBpR3em6II54KdhzgB7Ngwg32c8QPbd62m2easFX8JwvHCunpNHA==
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6) by
 SY4P282MB4160.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1c9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.28; Sat, 29 Jun 2024 04:29:16 +0000
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289]) by SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289%5]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 04:29:16 +0000
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
	Jinjian Song <songjinjian@hotmail.com>
Subject: [net-next v3 0/2] net: wwan: t7xx: Add t7xx debug port
Date: Sat, 29 Jun 2024 12:28:16 +0800
Message-ID:
 <SYBP282MB3528FA887B259274E92320CDBBD12@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [dodufB9GDxcoiWhFZq1b5uer5x5UxWIA]
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6)
X-Microsoft-Original-Message-ID:
 <20240629042818.5397-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB3528:EE_|SY4P282MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: e21570dc-962d-4eac-388f-08dc97f408da
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	rRa4tELIEic3hIQEPrACCUJ5qavr+eZEhju6UE6Z6bdNPERG4lzKi8wlr/5hykpaUPXouaXub4YWVvRlNkKZL8SZhKGj7xmMHcpWNDUO35OOt9s+D72LvsWI2gM+wyhkAC9j8C+SMGkbaDxgtbthHmY8EW2s+KPiZ2MYoXXgwZQIx/7JvorOvTqTjQTkiSCtn8X/x++8WliY0GTcnJmNKNY2SBd0oqTSIy44IjI9u8DjIpC8gZkF3Xh5sMpZHWlKVWdgJfhMEY00sXC0NF/ks6RF8oEt0iykWA2IuyQfTQRq46OQU3CDSdun8zMx/2iop01kUBZrJ9erwBWl/78vVtW5G6V6wfL7kPpyDB3JE8ns0nT8VmcGF93VdMOfQxgdvzPOresbWfn/+ByyT6TFpAxC0XDx9CIvWV8SOQr+k3K4ArHD3Hd1JYaKqlXgRj5ePWqFp/KIdFIWkrcfZKOkI+WzXLEa+ZVsPpUKJy7sdKudE2td0O/+AwPj4O7T2301BEIkurDwX0bVJkJx+A/zFFyPMlDyGiLlMn0RwGckCqk2dBwpbzeOYY4LNcd2DGQ7Y+WPSImmEo8zfMqMQoFFM+MKodU3OAQUFlZBVanp+A+fp3LrU+tRr68442KAK9tcO2ZKss7tG57R60dQdv+M3Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t90rpvu5Zabl2TbGJ4um/ZyLI50W3YtWB0lWanEKpdGBTs61el05bHNEvHwU?=
 =?us-ascii?Q?fC+B9BDZR/5wzC1VbmfxpfOScT34G02tHXlhWQMoTzaloyYDkKsoVaoUvQIN?=
 =?us-ascii?Q?OfWDSXQVKMkNZtB0PkHgGigB0FfWrPY1wy/PA3keRnBB7weqOAelkfxJMgWc?=
 =?us-ascii?Q?S9EeDg2Uo2Qf1mC2Q/TKhAxi5vuKa9aNVdkUitlUTOsQchTunuJIymdOjrns?=
 =?us-ascii?Q?pcqTPbO1amDeDjwSDq4kTobwBL40n/ZN3i6ozRuq579AOTa+yCjvYAWARR4P?=
 =?us-ascii?Q?QqlpX6zo//oeBbXYU+qACC9KTC3zOVnTjsHizTyKxCYEKKGnxK2Oqboq9M3l?=
 =?us-ascii?Q?RPizxqEckONpZNGZNXAwMrGEPD7XSBbYgUjHo2uObuKEMbwfvvuPiYOwm08E?=
 =?us-ascii?Q?IJ1rEZulVjrTLOSa2MoitImPHzRK9XT/QqT9C+paGHzMEjA4+BwINguJ+MMn?=
 =?us-ascii?Q?5iMuCn3sdBFtj6oilhbsPTO3TXnQQpl5iiPPUFZQikL40XnjyQKFOsIsNf0y?=
 =?us-ascii?Q?IWieL/1TuhZTMrZnwWmDPkf2NyxYtHw8O1lGswChPKvc6Lk+mg6Yq0F3Pw3r?=
 =?us-ascii?Q?4JG7+mjZGjY7qdEslPh0l14YH0IHbVr8TBIferTEN3chowWOuVOO2M7+cjuv?=
 =?us-ascii?Q?6qr8pJkcq31S0VvO4AgRo33UWqr6YBh5lllspDjzmZakRWTRXp61k2HDK8Nl?=
 =?us-ascii?Q?glG//qzV4YIwkt7Idwrnm22T96WVHp43siX3H8sGJ8KIVC3bbiO5FkgPS9ha?=
 =?us-ascii?Q?cvOR1XODcP4HKmnY2Bkz5SDHHeVx0e4bljtVDBd80qJdiK7OughMS/wpdFUa?=
 =?us-ascii?Q?kjzA3i9tZGFljDrPDuU0Qe9S6rhcJXs7j3s+07SaLey3qw1KUD0dk4Pbk2IR?=
 =?us-ascii?Q?XfQoKnm8rJqrdemQPNophkXA8SxG9C9emftWxHOhruMViACBYc+639fB08Fs?=
 =?us-ascii?Q?y8w2Bgc2fHg4+IwuRrtQMUnN9mQDq/4ugaZ/L8WPYMVM63SiJ02+28BAuTma?=
 =?us-ascii?Q?kqG7atLu0+LTvG/oyBvUqJH2ohAsbFa5OwMZWhCWigNa0M2my+opBlGALSyB?=
 =?us-ascii?Q?4fXuocHKJl+0LTiMbm91TVDfQ+VqpKPaCnG4yfneTxNeqkJI4bHkb/VcduOf?=
 =?us-ascii?Q?Ft/YBCQprHkb8TLY0uD5x8C/JiiPocwoO+jD4pcnFvpC9/E0LGmTjwmayafk?=
 =?us-ascii?Q?+FZh/WTvaLXW87ngq2ext50W8KMsmVhvitnh9Nm1jYIEYnoLmF/wlezK6Z8B?=
 =?us-ascii?Q?M5fwS5FSKp2cLFBJz4wD?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e21570dc-962d-4eac-388f-08dc97f408da
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 04:29:16.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB4160

Add support for t7xx WWAN device to debug by ADB (Android Debug Bridge)
port and MTK MIPCi (Modem Information Process Center) port.

Application can use ADB (Android Debg Bridge) port to implement
functions (shell, pull, push ...) by ADB protocol commands.

Application can use MIPC (Modem Information Process Center) port
to debug antenna tunner or noise profiling through this MTK modem
diagnostic interface.

Jinjian Song (2):
  wwan: core: Add WWAN ADB and MIPC port type
  net: wwan: t7xx: Add debug port

 .../networking/device_drivers/wwan/t7xx.rst   | 47 +++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.c              | 67 +++++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_pci.h              |  7 ++
 drivers/net/wwan/t7xx/t7xx_port.h             |  3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 44 +++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 ++-
 drivers/net/wwan/wwan_core.c                  |  8 +++
 include/linux/wwan.h                          |  4 ++
 9 files changed, 179 insertions(+), 10 deletions(-)

-- 
2.34.1


