Return-Path: <netdev+bounces-215039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEE5B2CD78
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBB37264EB
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 20:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD742C234A;
	Tue, 19 Aug 2025 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vxozNRFD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2121.outbound.protection.outlook.com [40.107.243.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8A2848AA;
	Tue, 19 Aug 2025 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633770; cv=fail; b=XRq3kHnJBAyYMkPni5y49TM2lov+ZvxV9qvsWiVLUIdc1XhIbglvxZEjYfgzTbQ9YyFopvuV6VZ4Xm1JZum1my8SrN98gpfXeSxbrmskz6UtTJ/8VassP2eveFTZ/J9eRiACIrSwhuobQPV0vzmeuYVKtlAM95HoNA4fpN8DyPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633770; c=relaxed/simple;
	bh=PxJpdCrByYfFMp9QyH5BMpUy0pqPeuqJbZJniqm4330=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=otU0Edg9N2CITTDtLSDBamwBDgYUgg4Varvoq9b10kAicIwiuFVO1XLaErz31+EVK5K+OYdcYQ+2tjN/uMFtq2utVsUvRAxoPghBZNj352hqOvtB/40Ex64ZNXWVEccMm09XX8Bmq3RdG92H0fDDBLm8/1ZDW45ktZeQr1oCEec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vxozNRFD; arc=fail smtp.client-ip=40.107.243.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBl+ZLI6aDwbKjzOwPup662mMpvCf7isUaSzAimTQuJ2zun1vnQRQAwRiu4reeyHyKCNYrnXd3huKTzTEFeawAESiHutRUvm/MQx3tlqNZpEW7hh6v/Ietshhu964UjMlXqD1do4qf4k/AE4D8epHH28fBA1k+LTNjdjFOkuZtEkER3ipFuGrS6pycV+ieIYArVykDYF2VQWcNuBWlFE3FEENjnKsftQfQLahjwIGAF9TnOhHdaSkVSJqMFsyWM/qDeGkLtsGvW/mR6KyavdrV8ZvFx+xwIlWei8sV4hS1bq0OXkZO6t0cLTdxglrslTAmKGSGdTFBR2G79p8W0lIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es6F0b8nppw+OV8ID2NhFLh6x3mSLmeQIzZRkH6rJck=;
 b=n1B3gjUwQLQmgnld5qeNGuym37NK9VQIBIRpw5DqApZjsRuWUREiQ+Kl3yp54GLrKRKXEKrUbHRlvP66H8E/b/9LiM4xQmhiuDsy3CqFXdtrRS4rv00kOowht4AMrD3LVw25BO8NFoSRA1gvpuJfqhpnFvnfKaJKDmnrTglpr7DC4qZAjAM+sc71GmXuiCl7xhFZiRfKF1Jkxc7PPM+8IpbQRPHDHPiO586JJ4P+m9de5M7urSWyFIAHUPine8Bsi5JOJn1fld9Li9j5eibpo4e3sA7Mh8r9mIOIx273SFPSaE/V69iII9UE3G9T/4Lp94yWPWiW3uD8PAi6SHUk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es6F0b8nppw+OV8ID2NhFLh6x3mSLmeQIzZRkH6rJck=;
 b=vxozNRFDsOuUSqA+Ke63rPy8r5dp6qz9jWcINSk/qnj79WDY/Jm5heT+RH/8B3MgwzrBNU84wF8/MgwWlWSYkMAYagod1AscR4emnNsWgD/bWlpHqdpeFS1n5/GyVleCwBGLDryuocF3iYweYS2AqZJ3CufIQYy1H3IXpP8TI94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA1PR01MB6542.prod.exchangelabs.com (2603:10b6:806:186::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 20:02:45 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 20:02:44 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v25 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Tue, 19 Aug 2025 16:02:27 -0400
Message-ID: <20250819200229.344858-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819200229.344858-1-admiyo@os.amperecomputing.com>
References: <20250819200229.344858-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:930:11::14) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA1PR01MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 138ae6d2-b371-449f-42b3-08dddf5b5c88
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|52116014|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VW8x/KmF4zRDynvTJ+tOwXoLhvo6y6uSCxPKbRyJgG2ETCbBDvT7jFmwag7M?=
 =?us-ascii?Q?0uZwga0ikQsynT2aF6LuAs3D6ZStyyquPU8pVigrzxCS5JGnR+PSD4HeoBC+?=
 =?us-ascii?Q?RB6qq3LAU2SOVb22rsDoW8KpADCDxbg0pUyV5+ZgEcF2PDOrqGAOBNJqWSn/?=
 =?us-ascii?Q?8QmN2nG/2cHcDNybZCuNe+mG6EGVFlwpie9BwT6rClUj3xN1L6xtfeA5K9RY?=
 =?us-ascii?Q?HMoieiUkZge771UMPIqCmvBWw1rFC0M78Vylc+ed6zubeNzpc5Nrw+01TNLB?=
 =?us-ascii?Q?3VYuEqmaMrzeCWTabV12IlZa5FQVJ7igpSR7xfXElKgJ0/YJThGBCnHm03Hc?=
 =?us-ascii?Q?spFLJUeDoY7LgkGZaZ2twTANAj5A04u6yzH7rRGkmY8jcMfFBHpx9Fbukevs?=
 =?us-ascii?Q?RbPMebVa1U67wgEL00IwfQa5R2RMFoNhS115ULC641a2FwVRan5tpZc+pTcl?=
 =?us-ascii?Q?XIJnLr4A5uMCgJrzqA7rWFkALD+/ayBYnkfZ7lH6fuUckIP7mWzXaeLcEd0t?=
 =?us-ascii?Q?XLZvOxd4IMuAtw7Ko5QC7QnFXzpuytWqpv3IiR0qbyix69gJo4k40RO3PACK?=
 =?us-ascii?Q?+EEeo6nZb+NS1ORd817PIxWte+sL5IN+wC3L3zdNTHseRw7YoRXNDX3nMcUb?=
 =?us-ascii?Q?jSU74NElmmQgUxUbKoB0CCKEgUFReDdn5I4IR1mXIah9dUmp6VXsdWCGOMWx?=
 =?us-ascii?Q?PwuYE4w+fYYGgA7ZNIMPgCp23b1NdIVc1HKvUV/FWd8yVwluj2zFGeNTptJr?=
 =?us-ascii?Q?347yl/i+QgHvbtqnwRvwSQ0cF9IqH7eh3Zt7p7kgT4v5PbSzI3TF8/cGF3pe?=
 =?us-ascii?Q?MOHHO2Hu22XByarTtJWtbdjomDfoN1/UEEQ4+lpqNPKZ/OdMCOvedal0CLCc?=
 =?us-ascii?Q?p4UXM9vTGZpRPegdtOEJywgHXXzhYUZgF3nId3SXZPuigYr6/1nOe8Iflfuf?=
 =?us-ascii?Q?QXi32oYkrh5/3KxT9UKmqsFQcZ453jAjLKeQR0FvokK+R2XiLwjs9c8uR1pS?=
 =?us-ascii?Q?orHciTxccSgWulmSnbuiEzl5/iHorL5Pd7m8XB/OuvR6nBpD9St1Is3cNM4C?=
 =?us-ascii?Q?6L1Fte8VLVeQjTbsKFiTjPiebjkzE1sruXeDFve9Qg2UHI+3e9ckRk5zMEzi?=
 =?us-ascii?Q?TNSaBiPyahjppZdc2HhFUqJoPQW5M0TsE+N0ulOT4hGbQHpjNm6d0mdkLuA2?=
 =?us-ascii?Q?5stQg3MkOiJwQvb8YrTNOse1lV0biPRxnyyj6krIwl+xrqqGg//tEI3rBp5z?=
 =?us-ascii?Q?7LzXr9ZT08J/e+ldzz8x3EztaeETWQ9Q4bSDuyP4eAzZvt7uukopN3z6CRHg?=
 =?us-ascii?Q?byLqgvXiDcR4lar1fDu6S9wL2ImKieaIDfTYqZzGdQxNURVcNU2QjdQ8hloi?=
 =?us-ascii?Q?s0USzc2p6WdKR4zO4zA54dUj0OAz0/kbQUFAiaMjxWxplmb7B7tWRVcgJGzJ?=
 =?us-ascii?Q?ZhiN4ANL2gU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(52116014)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T/5KBghfQ137ggpFJFWkOGvvR+TSfPVbfJygqUnyTDWs2yT2tqwLH02dIb6w?=
 =?us-ascii?Q?7sUrNRrhRAod5B6Z4IZUq6w1heft38FtipGxb/a+34ci66kahs3m97BUpcbN?=
 =?us-ascii?Q?9hYh3sUsYii+j3KcGkeL+risqoelWiOwS+nsRNGHWQPaoAR3OTFfQO9xgUqV?=
 =?us-ascii?Q?igb44vmoUtDFJmL7ne92rV4lUPyNBT875jeRDAYN07/tf3eAem1Pe5lfxjjz?=
 =?us-ascii?Q?NFC4KdUrCsJd6AaVEJkGT5JSQN16FvvD2wU1jz1rwvnGVK2TryLdX5/1QBn9?=
 =?us-ascii?Q?aO2uTbsxDYVgSurS+2wJn49IswsQzERFqJYY+J3IhSWggL2SEhu96WCCO94I?=
 =?us-ascii?Q?j+oa0O+N9SKlIxQiQS1JcIJ3xE9CIkjFL23E75TsAq2tgxGp+sfXsU96jOnR?=
 =?us-ascii?Q?0vrYW+o3sQMA6x8p/vADCi0Ez7oeCvE0Zed8h3ARCliEiNwp1yp+8z1DeaSB?=
 =?us-ascii?Q?HWz8RCUEwaJjljYxMR/udy9xv3Dp5gE6xux1WvxjI7nRiJDGCV5oDHbkgFOI?=
 =?us-ascii?Q?stiWhtz3JV6b+L/vUC4WxMjSqPgXl89pxwbONe9TwXU4Nvt30GsPeTaolk4s?=
 =?us-ascii?Q?OtzjkqsrWiWBZpHim4mws14KTKClf/OX/h6iX+nk6uPHiaFETQi10C8z4i8f?=
 =?us-ascii?Q?sV1tAwiVEefrLnHhCWkZLjRdOkogwTQOhMamDn6juX0f1U6Qqf2mu4rKY0IA?=
 =?us-ascii?Q?/RzAKR5DR1UZCZZhnjvAdWCDPW4gxlK7cVKUv9obGEDOAppZniPZN3+PgAon?=
 =?us-ascii?Q?jPKzBwyIVb3qIgyNup+x0hUwIqvwpM4a6Lc1UQ30QCuM52lxl7Lw8d9ibcve?=
 =?us-ascii?Q?gcmPT5VsFIDrNAftTkRwH9AbEERXMeiiL64YMZo+cbdMMrXwDxZQxnMKJb/O?=
 =?us-ascii?Q?ww/icG5liliRMiLP3ZJnNxE1pGVC0SglhT9QUvAPaAZ5tqpkPN4yLKErvlJ3?=
 =?us-ascii?Q?UBZvINuL6tARsSPwL3rIvyS/BpAYJDBEKNwgaEoukNkVSVvII3ovV/TEDW8l?=
 =?us-ascii?Q?NQzxAIgWdGxbzSk0H1hWR9ImjRuxrf9cADwUkVuYqRxtXqsqSy5HwZ9kqwSk?=
 =?us-ascii?Q?1FL/PgJZF+oyc1RBMZc+edGWCiTVuZefRZlzvSRUmAHbPkgKnw7h3Cyflivj?=
 =?us-ascii?Q?Xphi2VmDjXygKBp6VK9E2nBGVGH4MZ1NYIiUf/343qEtQkBdU8ByEOrc5Yf0?=
 =?us-ascii?Q?E/b4beO3Gq7iGKm8BlCsx3XII2yFkXsRlDHPMWXC9n+tl8Wk3j6dC3ID/k/J?=
 =?us-ascii?Q?lmK0nfDdXGyWuFDHMzMC3vpnuG1FUZ7pUz8+jnjZN2BMYHobvYor34uRbQ/u?=
 =?us-ascii?Q?c55GOA2Yc3axhJaJcWfP2F1DfQpeO5ogLh2td4PDeMXsm9QopeU4KqwuMYoN?=
 =?us-ascii?Q?oJA884lnqPBDhM4ohrc6JctogBhCSQVGZfld/uFlmTb8kzFx8yXqpQIvpjWU?=
 =?us-ascii?Q?zlrMaYVrxplTGcc4hay3SAebXOvnust0QVIrWij+3oN3VmakTJuXDLaKKLY8?=
 =?us-ascii?Q?na4DCj2xRiF2JpTkFBXjuJjSwFP6I07AfGw2ZhmG5Ca2fQ2b0n+3GpCWcxY5?=
 =?us-ascii?Q?0GoEAkb0fbcjwtw/PTgY5N4Wd+QH1ZQrRZ7eESxWRCGiwiD5/Ch9/CXS6U9h?=
 =?us-ascii?Q?2AjcNMC4N88Unot3xkuBU2Qigc8mZE5gnzYKn1XIHMGEjnxC+3sLVgtIWYX8?=
 =?us-ascii?Q?ePkrE6/JCaF5DHDm45FBxiSwtJY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138ae6d2-b371-449f-42b3-08dddf5b5c88
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:02:44.7660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8fRoUmghH7lfa0mT2nyIAj2FU0ObpmY0W7HeeWcDDU04tbelZXXC3x52ewK9PhVuBpKSI8Hfh92a3eK0lhu3dMZ7drRVMgEWEyqY8zPLenbsJGUKhzAVPEb5KzAifIr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6542

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SDST and reference channels specified
in the PCCT.  Messages are sent on a type 3 and
received on a type 4 channel.  Communication with
other devices use the PCC based doorbell mechanism;
a shared memory segment with a corresponding
interrupt and a memory register used to trigger
remote interrupts.

This driver takes advantage of PCC mailbox buffer
management. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox,
already properly formatted  as a PCC message.  The driver
is also responsible for allocating a struct sk_buff that
is then passed to the mailbox and used to record the
data in the shared buffer. It maintains a list of both
outging and incoming sk_buffs to match the data buffers

When the Type 3 channel outbox receives a txdone response
interrupt, it consumes the outgoing sk_buff, allowing
it to be freed.

with the original sk_buffs. This requires a netdevice
specific spinlock.  Optimizing this would require a
change to the mailbox API.

Bringing the interface up and down creates and frees
the channel between the network driver and the mailbox
driver. Freeig the channel also frees any packets that
are cached in the mailbox ringbuffer.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 379 ++++++++++++++++++++++++++++++++++++
 4 files changed, 398 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4dcce7a5894b..984907a41e2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14660,6 +14660,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 L:	maple-tree@lists.infradead.org
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..f69d0237f058 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -57,6 +57,19 @@ config MCTP_TRANSPORT_USB
 	  MCTP-over-USB interfaces are peer-to-peer, so each interface
 	  represents a physical connection to one remote MCTP endpoint.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..2276f148df7c 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..7f5d0245b73b
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024-2025, Ampere Computing LLC
+ *
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/skbuff.h>
+#include <linux/hrtimer.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#include "../../mailbox/mailbox.h"
+
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_MIN_MTU            68
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+	struct sk_buff_head packets;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	/* spinlock to serialize access to queue that holds a copy of the
+	 * sk_buffs that are also in the ring buffers of the mailbox.
+	 */
+	spinlock_t lock;
+	struct net_device *ndev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void *mctp_pcc_rx_alloc(struct mbox_client *c, int size)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *box;
+	struct sk_buff *skb;
+
+	mctp_pcc_ndev =	container_of(c, struct mctp_pcc_ndev, inbox.client);
+	box = &mctp_pcc_ndev->inbox;
+
+	if (size > mctp_pcc_ndev->ndev->mtu)
+		return NULL;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb)
+		return NULL;
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+
+	spin_lock(&mctp_pcc_ndev->lock);
+	skb_queue_head(&box->packets, skb);
+	spin_unlock(&mctp_pcc_ndev->lock);
+
+	return skb->data;
+}
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct pcc_header pcc_header;
+	struct sk_buff *skb = NULL;
+	struct mctp_skb_cb *cb;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	if (!buffer) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	spin_lock(&mctp_pcc_ndev->lock);
+	skb_queue_walk(&mctp_pcc_ndev->inbox.packets, skb) {
+		if (skb->data != buffer)
+			continue;
+		skb_unlink(skb, &mctp_pcc_ndev->inbox.packets);
+		break;
+	}
+	spin_unlock(&mctp_pcc_ndev->lock);
+
+	if (skb) {
+		dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
+		skb_reset_mac_header(skb);
+		skb_pull(skb, sizeof(pcc_header));
+		skb_reset_network_header(skb);
+		cb = __mctp_cb(skb);
+		cb->halen = 0;
+		netif_rx(skb);
+	}
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *box;
+	struct sk_buff *skb = NULL;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	box = container_of(c, struct mctp_pcc_mailbox, client);
+	spin_lock(&mctp_pcc_ndev->lock);
+	skb_queue_walk(&box->packets, skb) {
+		if (skb->data == mssg) {
+			skb_unlink(skb, &box->packets);
+			break;
+		}
+	}
+	spin_unlock(&mctp_pcc_ndev->lock);
+
+	if (skb)
+		dev_consume_skb_any(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct pcc_header *pcc_header;
+	int len = skb->len;
+	int rc;
+
+	rc = skb_cow_head(skb, sizeof(*pcc_header));
+	if (rc) {
+		dev_dstats_tx_dropped(ndev);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	spin_lock(&mpnd->lock);
+	skb_queue_head(&mpnd->outbox.packets, skb);
+	spin_unlock(&mpnd->lock);
+
+	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb->data);
+
+	if (rc < 0) {
+		skb_unlink(skb, &mpnd->outbox.packets);
+		return NETDEV_TX_BUSY;
+	}
+
+	dev_dstats_tx_add(ndev, len);
+	return NETDEV_TX_OK;
+}
+
+static void drain_packets(struct sk_buff_head *list)
+{
+	struct sk_buff *skb;
+
+	while (!skb_queue_empty(list)) {
+		skb = skb_dequeue(list);
+		dev_consume_skb_any(skb);
+	}
+}
+
+static int mctp_pcc_ndo_open(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev =
+	    netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox =
+	    &mctp_pcc_ndev->outbox;
+	struct mctp_pcc_mailbox *inbox =
+	    &mctp_pcc_ndev->inbox;
+	int mctp_pcc_mtu;
+
+	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(outbox->chan))
+		return PTR_ERR(outbox->chan);
+
+	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
+	if (IS_ERR(inbox->chan)) {
+		pcc_mbox_free_channel(outbox->chan);
+		return PTR_ERR(inbox->chan);
+	}
+
+	mctp_pcc_ndev->inbox.chan->rx_alloc = mctp_pcc_rx_alloc;
+	mctp_pcc_ndev->outbox.chan->manage_writes = true;
+
+	/* There is no clean way to pass the MTU to the callback function
+	 * used for registration, so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
+		sizeof(struct pcc_header);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	return 0;
+}
+
+static int mctp_pcc_ndo_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev =
+	    netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox =
+	    &mctp_pcc_ndev->outbox;
+	struct mctp_pcc_mailbox *inbox =
+	    &mctp_pcc_ndev->inbox;
+
+	pcc_mbox_free_channel(outbox->chan);
+	pcc_mbox_free_channel(inbox->chan);
+
+	spin_lock(&mctp_pcc_ndev->lock);
+	drain_packets(&mctp_pcc_ndev->outbox.packets);
+	drain_packets(&mctp_pcc_ndev->inbox.packets);
+	spin_unlock(&mctp_pcc_ndev->lock);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_ndo_open,
+	.ndo_stop = mctp_pcc_ndo_stop,
+	.ndo_start_xmit = mctp_pcc_tx,
+
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	if (ares->type != PCC_DWORD_TYPE)
+		return AE_OK;
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static int mctp_pcc_initialize_mailbox(struct device *dev,
+				       struct mctp_pcc_mailbox *box, u32 index)
+{
+	box->index = index;
+	skb_queue_head_init(&box->packets);
+	box->client.dev = dev;
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	spin_lock_init(&mctp_pcc_ndev->lock);
+
+	/* inbox initialization */
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+					 context.inbox_index);
+	if (rc)
+		goto free_netdev;
+
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	/* outbox initialization */
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto free_netdev;
+
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->ndev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	/* ndev needs to be freed before the iomemory (mapped above) gets
+	 * unmapped,  devm resources get freed in reverse to the order they
+	 * are added.
+	 */
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
+	if (rc)
+		goto free_netdev;
+
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+free_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001" },
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


