Return-Path: <netdev+bounces-282376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IWYD0b+8WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:49:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5016494442
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A3630136B9
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8DA3F20FF;
	Wed, 29 Apr 2026 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hDHk9JfR"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC583F0748
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466817; cv=fail; b=GjXk3zGqV9Vqy1kPg1x80P1Z5ysFbjsZhWJettxD9UO64NPnaer3OEFbm8OlMMTqcOyfh/rRyW0JjJNvnyp8qMTdI55RcXsMtNORvb2wfiPT4Ag/bTUDbXhPRUYwc2Y3SrsQ27vohp+ac9k+AkrnwPQcSqU/RCrspthGhcVV0GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466817; c=relaxed/simple;
	bh=Snr+4f68lHEyLgdwrxBbG+hInFux1fXSM79LhNLBdjI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SG2ft1Fru7j9LZbrYkAfG6huqJBpsJvrTBBcUjcS8wM4ODt4RPzxE6K5OqtcP6iZk6hBeRWjuZxDBcErk5mO/2daLARRF5XZwL/EduyPZ3K4aokuPWLvki5fcCAhDge84ZgYEG/xrLp2OA/O9amrzEfmVZQfbEpKykArPsUWXTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hDHk9JfR; arc=fail smtp.client-ip=52.101.85.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+LNi9ADkCWtxQ3vCOTRXhm2bCY/FS+DtlP7uKQ5FTkloBqadVMNb7vbX4ThrKGSM8s99GR89z+pd02HmFIX7mY7JDEZI6mb9g2S9wmGbdE+0EMDgtF2J2heesJzIYbc4RM2sOLnM8tzPH2ohWsJdlpPFSqjtSz/Z5GVUsWmdmw3dUKZwRq+utPrGbeRA8gVI0tNTprt7uzlLBABL8UpO/cws39MbW39xFpqkmfvh0qUu3LBtkZTMOeKWxR7yPEwtgFvroWzAQnliDUcZ5xvFBNLUfVasPrOZ5cNJqrv+gq1/Q07DJKCgcYv+blGGlXoEUO80ztDgBWTKUGyOLtoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwP9FBfLu33rJwQHPz9ISM8oufg2tHmBHbj3KcoaTSs=;
 b=GcL/7/hDAA8r4S8D2UZS/LC484jisGv+/U4EUFBeuV3c0S5DVlYphuJJZGOUt3Lis0nW6KK+AjjnagcEMJXSTMGR7TXzpHX312wDvN/SQLvtExHhAdRHsJgdIKWa4JQHEX8ziPaeD/6PXcepkMckzVDV6SKxJlj65mldBvojdwtHK2Y8LLKlVKlx0MZVztYk1C8Vsl728GBf4fuYNvIekAq7kWvNiDjOqP/gOQSgaDcpQDige3eZTNMtKxpSCHrdaSTk1btwUYh5HnWTLRUHAfUOHHT5RKgtJjEGApYSzz90A5yCsu1fedUIxf13i0LopbnMeGlrH7g5qEAAfqgcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwP9FBfLu33rJwQHPz9ISM8oufg2tHmBHbj3KcoaTSs=;
 b=hDHk9JfR5+pRJQU2zzPdOpCFtjvjkWrxTgs8t8wZaQZgNRIavxdMZNXVAkEA4K9YOLRVB5oGd15xslObZ9g0zenAv3ff/T4ML1ogxlD28yHN597AZIB8TRCD2MBVPshZLJH1mi5jh3nr9kIPRbrByhkL2yB4gufGY9Q8LoaDlkHl6Xlz6K9UcW+nAalALEnEDzNWiPc7/yzmKvZJYuVmq+0I8Ghw11/gpgl6xhiB2UX+MGEiUHlv1UfWGGbAg1gTsFEjMx/732zJgqynvnYuvM21k1aMEzsJ+wAs1vJEf9kQV56EmLZPODRe5cFJTEe9tfB+B6CAw9fEtzGcDY816Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 12:46:52 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 12:46:52 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/3] net: Fix protodown with macvlan
Date: Wed, 29 Apr 2026 15:46:21 +0300
Message-ID: <20260429124624.835335-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f1770f-0106-43e8-e2b5-08dea5ed633d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+A2Q8wWlQENZeV9mETlVmPqvHfkLonGhuKmZafSWu06gZSWhdwoc1+uZ15Yb0Fqvu0rj15HKylnZSfHTapEAHXhTsaoHc0qeJhkUebsEigxfXAI/v2GqF7hBHkiJitZCGkX46NZSjLUE4IGSQ6fyKHLFnSERSo2ifpHMCLuOyrSaJ4wlWgDGReSbB5xjDbQc4+EOln4497sLvk3MQPPWvKPKmoKKd1o22acyeCbrfXsTlQkKkOa7GP+a0cbNxPvXjHPQvapTBtYfLskgArBKJb3ZdIL8ktedo6wszD/HwVUSmz28BpybQ9qG2ZJ8fAe7ybqeraa3CODK8Iwj6bT2TL99uRt6hrCn1oRan6HSFf6YPUZ/Z2MDxDqo9//ZirmqCuHy6C+FSg1uI8K8fuwnXemmf4sl5EcQTFFdlRRgNGr5TePwPSsW/S1cxdK/KNuWIRJ14LwNxNPm7Bn78RDWg4i+Ah0uwjoa4y6kVF8E+FER8+2akMgm11VFlNR2U1W1ObvpnIDxbB1annmtFipXwnsKJbBh9UwbyWHQ10L924yv8WNp5w3+/3X+xYDjjo2lnmmzciKlWTNx0g/f+omzwuUDalrccXesV8c+BcVmkyCwAAwbV4DzoitaEKpgza5af6dtJxiPE8NQwDN/LmswaQNokZxvBtztR6XckfBnpFaEIVmRWJiFfJf5Rv6yh4O3DwoSwRMQuHJc4YvEeqcH9AXoNSpYQ5jKQV4cZCm9vGk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jWLLLa/SCKDXgqdgIdT+3miif1gDxUNDFm37TMFaNfq3Abum+HBXVl3WDU2k?=
 =?us-ascii?Q?d6iiE4DYouG29KfhHOGxYwepe3cFPjs7CLdwEvBkz57Vl01XzGuOwf4zzJ76?=
 =?us-ascii?Q?LaGlJqs0i9f1oyBZgYiy5Wrk2SjOvRWi9tCiEwvCIsmv6XR4UMrNRoGfqqMH?=
 =?us-ascii?Q?SRR3ZF+0I0/hH0wL0vWNrh7EPVKQ8RAHU+4v59f7MRUNKHAclk3dLX2An1bW?=
 =?us-ascii?Q?pPqctcH0X/bGT48lsHkHtTLsOjkT7YObPg939Q2iN56nUnNosh2gkqo+5EpT?=
 =?us-ascii?Q?sbwKBL2RyjuerzAjEjD1wvb9hS+ll8c/y9XFx74lyXbcfK7yHuXS5Jjp0+JA?=
 =?us-ascii?Q?utlCB8MQ25Rp/G3uqHhKeTFsnQaLZ4HQPy36SO7LKan6URde5InZs6IPSBD3?=
 =?us-ascii?Q?69wjoHX0TLontTejzb6X9X6CAKGv8P7qu78a0lF3wFZI2+e9qbHlnLICOPUF?=
 =?us-ascii?Q?Xi4/hmFQ8uxLSTh8iYHk1uJXQyYaNNpG+shHxHFS5qBUhTvolLPrRI231pnt?=
 =?us-ascii?Q?XaZFAUofxoNhk+R7QrCRKwrDdUBaMMBcXDTRwvlCSniGZcMmGtOW8AzZ6fQO?=
 =?us-ascii?Q?5X6qXRrm39PZ2AZAxUnxuqzwlQx+4Se07KRKjTSvg+0wPZfx7ioHUQHL27uZ?=
 =?us-ascii?Q?cCE4ufybQdtSfevnzyQrFQzYHrIj8Nj+bhUXPG3Wz3ApcSE0jRwBAsVQIcYp?=
 =?us-ascii?Q?tb42jmMWO4vKtLv35s+j6AwpYzygvdkv2qZUtv1yCaBsLhN5PPl8TySivA/N?=
 =?us-ascii?Q?pGPPvWs1XRXLjRi/S3v5sHaI8RbeBGpFD/cQOagR5U0Z+p1NfNAlJl5UAWgC?=
 =?us-ascii?Q?CfQ+pjap77yiflcbw+I5jW4Z/8W606tuU4ixLD1UDCcYZP0mbj+7GfIccVVl?=
 =?us-ascii?Q?Uv9+Ci8+WZNI/kS9DbjJ+paDnJn5P1k83ZFYGgYbXBTkqVZhEpkMvch594i2?=
 =?us-ascii?Q?xn5xPOcuNyjmLBukBdAgKQcVUdMXTuPQOmT8emsSWMgOtx2mYHd1SeRD/gop?=
 =?us-ascii?Q?+GA5EZlLhzabWAuXKBUy3X9PZG+FVKltYVIu/d7yYqU1mzJRroVQ6H6qRh7J?=
 =?us-ascii?Q?cT9NVM+1saqhca4s7TsGpXDQmJD0v4vE1I6Y73NZVCgc8+g0tZgwYnBJqJgA?=
 =?us-ascii?Q?jwFsTqywemQBMctCUZVglKJ7Ol2fSmsPkBXHQaym59qLDZMUuOl5TjMifd1o?=
 =?us-ascii?Q?OK+GQSTtjblvI96F146tW88nNJ5xzKt7GSvevn1LWlxuaHyvYiLpsVz+sE7j?=
 =?us-ascii?Q?kxTM52EpkecwoMbaNyCz2gZy2O6LUaB36rLaOqIXEcr7YZJBKG3zCl26xxS3?=
 =?us-ascii?Q?ve4b26KDg3TdimidaLJ3bRXBQYSzCsgtD9B/d7EadqnU0rYIUloqt83P2tBt?=
 =?us-ascii?Q?nDrVnl0p6ImjNl3X32Q/YVDzGJnICMK+3T8BVZi++QhYTwz79nKTm6r+PYv8?=
 =?us-ascii?Q?xG7tN6sOj/Y5Z+QTlIOGRYZ07z7UnanSYsyC+M1utM6irT/2S3kx4qbXxkxQ?=
 =?us-ascii?Q?khiT9A7RinbnEIbS/VFGm6Gc2r0BnGDy8B5N+t3myQX4KO60r/1lWk7smk76?=
 =?us-ascii?Q?mQPm2lmy0c6fwMyuJB7zKOx2uEZP7MduH5mqklNSMgJwI/xhP0pwhENzWdsh?=
 =?us-ascii?Q?rDv36J6G1HMp9jh+DxkGKFQefkRvq6kP6Alpi5NCuJQ0RxJWytdLl72Xu33q?=
 =?us-ascii?Q?IYaOnaw+x+7skvh951mVIpO2dKnzSmcqmupcpwhgsuiCvWao?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f1770f-0106-43e8-e2b5-08dea5ed633d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 12:46:52.5470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paXhOdPk0aSjUi/0UjD0rbuysfOcaIwK9FOIRkprBFhwDIk+/1lT7Bw/przp95QX+gsy8iIn5Eeuaw1ufmxFcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372
X-Rspamd-Queue-Id: C5016494442
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282376-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]

When protodown is enabled on a macvlan, two bugs cause the macvlan to
incorrectly report an UP operational state:

1. Toggling protodown on and then off on the macvlan while the lower
device has no carrier causes the macvlan to report UP instead of
LOWERLAYERDOWN, since netif_change_proto_down() unconditionally turns
the carrier on.

2. Toggling the lower device's carrier while protodown is enabled on the
macvlan causes the macvlan to inherit the UP operational state,
effectively bypassing the protodown mechanism.

Patch #1 solves the first problem by introducing a new NDO that allows
different drivers to react differently to protodown being cleared. For
macvlan it is implemented by transferring the operational state from the
lower device. For vxlan (the other driver that supports protodown) it
continues to be implemented by turning on the carrier.

Patch #2 prevents a macvlan with protodown enabled from inheriting the
operational state of its lower device.

Patch #3 adds a selftest covering both bugs and the basic protodown
functionality.

Targeting at net-next since these are not regressions (i.e., never
worked).

Ido Schimmel (3):
  net: Do not unconditionally turn on carrier when clearing protodown
  macvlan: Do not transfer operational state when protodown is enabled
  selftests: net: Add protodown tests

 .../networking/net_cachelines/net_device.rst  |   1 -
 drivers/net/macvlan.c                         |  12 +-
 drivers/net/vxlan/vxlan_core.c                |   8 +-
 include/linux/netdevice.h                     |   6 +-
 net/core/dev.c                                |   4 +-
 net/core/rtnetlink.c                          |   2 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/protodown.sh      | 160 ++++++++++++++++++
 8 files changed, 185 insertions(+), 9 deletions(-)
 create mode 100755 tools/testing/selftests/net/protodown.sh

-- 
2.53.0


