Return-Path: <netdev+bounces-65532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1015B83AEFC
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347381C236A7
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED1A7E589;
	Wed, 24 Jan 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="pTm1cz3a"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2163.outbound.protection.outlook.com [40.92.62.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381197E584
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115642; cv=fail; b=D4ge6HPNRI0OmDYUdWb5tF4DHymf+InIXfKAIdhjSPkwxSvkf8bmdhebyCzK0ExCo7ZRlo6kT8lpaTRUKpmYUoympdiEikkaNTKlzHrsgP0+l5XJHliDP3W6SL8NKF6EYyuxQH+GqXo+l5WzJUT592kYdt8f883Vy+4/RBM2UKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115642; c=relaxed/simple;
	bh=87t9y8TOuObWPcTCUB2LOY/WaHy+fZ/CFqGaMYEiSTw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AGhM8sb+H73fWTNR6qVSFBz7CrJDY/hVTKFIou0KSSkdXJRx3wFX0/xCRNl+15QMs4JucOfnnX1dDDwKIx8vhRZceCXo+Mc7CBXikba5wpUw+AAQag6F5UFX7xUIybFNI37O+q8f29JMlB336jeT2rigv2LrVGUDMHzS7OZHK+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=pTm1cz3a; arc=fail smtp.client-ip=40.92.62.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHKY1AZld7x4tl/1bGqqT4emQN3KDTUDvZw6kEjMGgahE1zVHyv/mTyvzqCPaiPkWioghvY6WMLFb+WsvcFoA9dAfaBV9nTFk9rJJtTRgZrTvrkf8I9MUBNCkf/65+2L9sNuNIoEru6VSHH6qV8/ngcBsqw4VBuPir7TSFX5D4nmXmu1xGmMuklL8vigIqKmnIMw1VNVoC3gHiqlmBEa7HvVg2yw7Rw3Z8JHndfmltbP2Cd51QMWoV4dv55NNhN3XABkzbqunFvO0pP63M1+LXrh73NhEMy1uqNmKz6Y87geifkPh6MUpr2dwZEVfxT0772rGvsUj4gjYqEK2U69IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=triBGoNeP4NCo72FOrqzTnzhquL/bqcixTVpLpkBPzE=;
 b=mUQbzbNRSNk5Xvn92ft8VX43ryISZHOxeZTwG/VZZHWX3SES7j0PbKZzPKeUV7upGT1yMKZ63PX9eiB0wzqibr+X5/wvf4j1j6QGFcCS9fx5mDq58Uso/iNig7+OzgHJ96GKSz1tABQIobz+0T3SV3oVNmP/dpwy+yD6AAX+0tlp6hiJBJlhfMclwRF/5IvKJK8fT15t/PhpZjACQDOyzMvhB0ZGlIXCYwaHW95I32zA3DUCjE5QJukoSlaqMsSIeIDNxT5Nl5+DXcAzXQKt6AL0YbAGJstxuEM5MCUxlRhr7uq19M7BnpwLi3kEdJgEPRswMGjQFLJs+Y+CAAXxRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=triBGoNeP4NCo72FOrqzTnzhquL/bqcixTVpLpkBPzE=;
 b=pTm1cz3a/sqyY4D4eZ3+MAum9LsBtccOeMvCqC3KI9i+yCvCDl/Xu3cYQVkWjKBag2DdjXAAbYzZYG22xwWJo2WwHt0OEw43tWSAFcsxoUPUDLT3D4koMhuNciIUoo4j60BZPylC3P+mCwflQtsx5z9vsT2UlBNeE9JndMr/XcEziFgGGREWWFzzhr0CrUhEPxuhKFetUDXFG5gTF0q9z1uDDZFvYhclIVRHkrGfcSCM9siecRUebbjcvH0xSwyOB09Z6eR/6ILBMDFQA2gaOGXhHoEVAyfngGL5xFEFzEjFRGOf/EvXCdY8x/Mn+FDc/AJAPEk3B5BdAp7+TKFkGQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY5P282MB4936.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 17:00:34 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%3]) with mapi id 15.20.7202.031; Wed, 24 Jan 2024
 17:00:34 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
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
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v6 0/4] net: wwan: t7xx: Add fastboot interface
Date: Thu, 25 Jan 2024 01:00:06 +0800
Message-ID:
 <MEYP282MB26974630CAAFEEC42E6DF9E4BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [uADWKLG0N30r+uc7B7gEp1V1zV1CKYPT]
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240124170010.19445-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY5P282MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acb024e-1964-413a-ab73-08dc1cfdfae5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RVOB7CqJafQ3GeWCAMv1RHSp3Krq0KmNObk5kNV1DzRmefqu8QQCfh/MnR0rD3B02qFP8bI/rQ/h1XmTii7Ht+JnyMdpcUdCjO5FJoVEiQNj+uZSbAOQpsXRCtnd8NQ8M0JlWIsI6LzIPVtjJd3nLe2DUrIRgZOe8LLxCkLTdhQXXbbGQeyZuB6AXh/rCbDYz0rKJRA8v7+Dyirhj3OgIOSb38IprRmeiokDvRELbY8WcgO14BI9GFEOVkaPtoJ3GHToSJCzXg0iI9hNu0UOqqlc35VyUxZlmF6pZLsBRQwmTPDzigmiPegNmNm2NtPpuJcXFISsldl94WMLKnFtr1nwWCE8GLzySdHgOL9gFYvROJ27sKYmdZA2vTCT9/btr7xES7Mp1Ui0NKC0p6gYOidxxhDszW1ELHMWst9BujaBRzzi3MyT+Y8zEXzzygvsgOd6gcfyyZ2g48uxCJzrgMxed4QdZH4otdJVr82PYWiql0unqp9SQQX3GYlFQWoy7FbFVxLItCCWCu/vRjKqEvW+MsK9irJDfqNHx3W0Z0k2KwfHooXQybyQ9jsmntnt
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s8DXvog71nZckfD9B2DpyhGqgUc7Y4T8S5T4xlSBSBbBSZFj/7ezk+BfTEpX?=
 =?us-ascii?Q?ryyCdz+7RrMnch5qnzp6gxLhEPlQE2nA6OO3HDxGsRMnDET/yBH/AIT1OBZe?=
 =?us-ascii?Q?KASmM6jqBJeGrgqmZ5X+1LGx/YYDMqd0/iGiUvI6/GFBLGkxRAzpaauJ99at?=
 =?us-ascii?Q?84+tbiQLX7u4H0Tb4hdG8wilZlv2AnrZKdkcKvwnTfGWzBERJXpOTFal4B1t?=
 =?us-ascii?Q?lElHrCrrxyAXXBk1VeUbAshVFQPUjw/TOb2MD6ecl+ExOPGO8uJC7DciQ6ID?=
 =?us-ascii?Q?kevhMU7xRndnIFZ8LtKFNITDf2yrFeJ85wASOLtfIFOD1q2v6IZI3DMA0JV0?=
 =?us-ascii?Q?sjlSsinjuBuFO77pka0dLphP4vi/gdxesxPv7J29ek+kCes4+rcJuDYDiPJ4?=
 =?us-ascii?Q?eXraLdSVNfyZTYY/5LWg9MCTdpmh18hd+5I/Gmte8DiitBq3ivaGDNHnZEoy?=
 =?us-ascii?Q?UoVxkc+glvGIlG3nVi7/TCRrMtbeH0LxdrRB3/4grj/UQ/wlGEABz7A4c/SN?=
 =?us-ascii?Q?DRrxv9QYk8maH2xeZjjpxSRtSHGJgngMrriSPu1t+j5m48JCiLn9OlbSKlPY?=
 =?us-ascii?Q?eKv904orldVVVcuwO8k2XrZ1EO6C4vbfJ5sFZ8PhbwlLJPT9m1Eas8cAwGUc?=
 =?us-ascii?Q?ajIBKcwgyO34lkyyL4aEOQI2USexQW8r6Pp/RNKUl5aoVWr5tqOgvNPcRnzc?=
 =?us-ascii?Q?N6ljgER4eRPgboNeSHbOs6N4ZBPDuOQGLFdO9z6N5PEAvmr+5XKq/bzTrj74?=
 =?us-ascii?Q?btIZNnkSzVnzqEJIg9JKaXmgzGwE1rpIzvpNJZwKNrwULNh1TooH0YNVsbSJ?=
 =?us-ascii?Q?iIq5bUKd3v6HIojTzzaw+sndxpQeqwEU/lml+1nY/bmrgBugEr1fMDnKMHJY?=
 =?us-ascii?Q?MGLmkb/VsfMbsztWx/E/J2wTFgWFVIoE0JIwBkd3RMYnIYAVvK3du0sbPzP/?=
 =?us-ascii?Q?dgBOFz1iACm/UOLvBeSlcCV/vIuUQ7Ldc4J8xye0GiDutL5VNI0BN1unhO6g?=
 =?us-ascii?Q?ywapBlRse8+H4ofb6PdeZStx0nDtMbYqZcyX+RJDJr5VWh1OoziPHEeG+uJi?=
 =?us-ascii?Q?Ao2wKLviQqx5Sq/qTfSH6bBdHDFE9V0iVuMrquwmuuYX0sL+oEQRmPxNtOlg?=
 =?us-ascii?Q?f1IqQbi8lHZG1aPJJ4H47g90EEQlGyewkGp0cmG1qKTnI/+3vBCpfbNahu4o?=
 =?us-ascii?Q?mghYoFLND73LrEP4pFOejnqA49hOXCyjTVgWm0D1YJKuUAmjr8kWc3iBC5I?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acb024e-1964-413a-ab73-08dc1cfdfae5
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:00:34.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4936

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for t7xx WWAN device firmware flashing & coredump collection
using fastboot interface.

Using fastboot protocol command through /dev/wwan0fastboot0 WWAN port to
support firmware flashing and coredump collection, userspace get device
mode from /sys/bus/pci/devices/${bdf}/t7xx_mode.

Jinjian Song (4):
  wwan: core: Add WWAN fastboot port type
  net: wwan: t7xx: Add sysfs attribute for device state machine
  net: wwan: t7xx: Infrastructure for early port configuration
  net: wwan: t7xx: Add fastboot WWAN port

 .../networking/device_drivers/wwan/t7xx.rst   |  42 ++++++
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c        |  47 +++++--
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h        |  18 ++-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |  10 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.h        |   1 +
 drivers/net/wwan/t7xx/t7xx_pci.c              |  98 +++++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.h              |  14 +-
 drivers/net/wwan/t7xx/t7xx_port.h             |   4 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 108 +++++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  10 ++
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        | 115 ++++++++++++----
 drivers/net/wwan/t7xx/t7xx_reg.h              |  24 +++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    | 128 +++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_state_monitor.h    |   1 +
 drivers/net/wwan/wwan_core.c                  |   4 +
 include/linux/wwan.h                          |   2 +
 16 files changed, 542 insertions(+), 84 deletions(-)

-- 
2.34.1


