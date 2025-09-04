Return-Path: <netdev+bounces-219805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3663DB430C8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4685F566840
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141B23A99E;
	Thu,  4 Sep 2025 04:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ja1uZ7XU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E8225A3B;
	Thu,  4 Sep 2025 04:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958758; cv=fail; b=iMbiINsHdGRNj3PWGxEfbwJIVf3i3RwBcYp7JWPM95h4z1kIVd/nnFupdEQTrqHsO0BX4BcJvNKvoQSCGgeTozS8YGjkGBDgmicGJS1fF028U+r2ZHjJ01qqu7+fUtzjE9BMnEgzQp/v9wXVwaqs4aak9ih6Bjk8RMFdQL5jy5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958758; c=relaxed/simple;
	bh=iFEynCTDa24rYNpKwy24/4befh+QEzGGRnD6zgTD4NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=teTaSHADwEFO4kzK2UXvJC+sOsdQyGkOUmiueneRNe0e4DGhSXv7b2DvJ2JGDPVXDmoxPZt2L8aXASWT4pFCp19/bFyy3QIRWYEbt8+9mCuZJJVQTuFfiuvjInAcrQMs5WiYtT06U9AjqUr4BgQJKv27jBD7GXSSomTz2llkEsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ja1uZ7XU; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlrOJ8PsKIybScXib1ETlrpAkZVZpEBoDswqotciZujJS8hJOu/gdIX2gL0FLmGNmic7tv4e/tmbT3xDCZXPx6zZnXMvciGRBETHdwSDs7OJqwIbT59RZ01DtBZP1OS/8+CD7YSR1hPJtso47aoZoQc4yfDP96qBu6RwY/V9gsxO+Z8l8bjn5DLRziQo2EJBTc+Wk777Gv/OPI39hCITwOPqhDEqd+7YYT76/BZhH45g6ba5qpr4bp1TYz/yGJaKP+XCT7H3tgr+Kz08XsKLJmwpazW7Wr9K977meObgLyWTE/P93BM1Hqo6mWwuXzJv/OrFThhLQtDIU7kPxKbSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JGvLCEcoHEKbefs1CK9Co22c0Ce2BS58jM1AXiDLUk=;
 b=shosh1WHc8pr5LAvEpJjVVkUvNkV4/oTX4UtVZ9oLX62PPzQV4r3o+EccdOjyKzgmLT7a0jAyMjVtCCELA+YrTIN5uZukeG5N3Fy0OZH2awdVnxFpsCE7rhwAwRZjuQMaQwF3dC2M0SJ7JGAvdeAaXGryPaGjS9Mx5hmHl1mZLYzd1MbYs2fXFVMzzAYVI+jl2fL9tbAII5rGWulGM3TaOJBg6adLuAe3iOawQJ7UkZeJr95q8COcqpafr0xb0yAgjQK6/2Kix+/0WphoDKmlW+9UyHIexNRVwxXcsZdu7fzrsAcllennpTBUT0ItVqMzcUemH4UUyg8DLSYseDVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JGvLCEcoHEKbefs1CK9Co22c0Ce2BS58jM1AXiDLUk=;
 b=Ja1uZ7XURn9fdGIwPwTpSEnVC2IVts4M2Mh67KBdScz/a9fZl/1m2eYJOjLnmHK9GBGXOAgUNk24r5mIml/VBcs7sMG9VZ4B9gNyqp8i0//Gt1c3BgL9dEUYnVhbEUooPFfGwe5iy2jEvX8eCwopc+Vlqjxr4JnH0LK7PPL/EGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH7PR01MB7559.prod.exchangelabs.com (2603:10b6:510:1e2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Thu, 4 Sep 2025 04:05:54 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 04:05:54 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH net-next v28 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Thu,  4 Sep 2025 00:05:42 -0400
Message-ID: <20250904040544.598469-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904040544.598469-1-admiyo@os.amperecomputing.com>
References: <20250904040544.598469-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:930:a::16) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH7PR01MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 51aaa1b8-b99d-402f-e201-08ddeb6857dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RQmN9DRdtYU8rNK1XtKv408VdsFC1nsCuB+tLVk2u9jayPwUScHNR+YxQO2i?=
 =?us-ascii?Q?AvNb9oMQ8xvDvpU0ZNmNLLc7a8vK4OqFNoYgiuf1jl6b0nT+81jFmPT1i60+?=
 =?us-ascii?Q?4h57Av3rjS7gBpRFpi6uD7UTaBqh9gKLPtC805elNI/Ku2ZQYHy4kF0I5RBY?=
 =?us-ascii?Q?gH+YrKFpzSMKbnI7gUH1gUGaQnPQQyRjYrDz4utvEyupXwYxrxXCV5eanewI?=
 =?us-ascii?Q?2udwqgcsg5XpGcp+VCwTBk01cfK1o6aFVKu6+M8lmzXgSqneO8j7iqTCiIXs?=
 =?us-ascii?Q?AvbXnb+ou5fRE6JIidWIcOqg1/dGvjTBk7sbN5QtzK7BMuWZFdgNmZOGoxGV?=
 =?us-ascii?Q?FmvhC/Po3KP8qyHo5MC1S62LgnsrsycBPmhN1Un3rk5wLMNGZnRFB9sVT1AC?=
 =?us-ascii?Q?lrHbRcgYO73cvHaZmbl6kR7gCyOqRuAwyelFRSAg+3N3iPKFD2J4T/pxXnZp?=
 =?us-ascii?Q?vPt4UzQWLcRe7sWiuvCWgRMhrTgnWl+SptyX7ouRofLtj9/GMECE5/hy510p?=
 =?us-ascii?Q?MfhC/M7UmwSKpL9xIsOOcyMo5uBS1q3eG6lmJZfIyYrOWNZyDgtDElj0yrsy?=
 =?us-ascii?Q?s4idiEY5l/W5XljGpBhEuMp8ePAzpOrqwVHpF8aa9Cnhs9Ct7nyjvI932158?=
 =?us-ascii?Q?mzz3upcn6M0p4X3fg2siGq5NFWNJGzqMyqYzgQ+sevFPDBmaFBtMFe2KAleK?=
 =?us-ascii?Q?Tm+AEs6YRn70qAajh+CAxFNn/yOov5wKzYbqUO8MlGwVxWmGQvtl7W5zTopj?=
 =?us-ascii?Q?w3LtmC7fogzDzxebWU+Fp2SLhBQcZ7pDd2oS6ZVcjdkbRNQsYVnoOuFy2E//?=
 =?us-ascii?Q?DbxrkEoc1aeJ+IwP6NT45njo3Ywjpo9J6d/e/rLhmbB25BX7IQXUIJEun0d4?=
 =?us-ascii?Q?2Cb8kd6FVipxjBFGEZCSvDgO0SxltHO9eHrqRsdIMGVHSNWeOpgtURckuuoO?=
 =?us-ascii?Q?iq33q9sky5NOUGtXEzCxUUIvs1reK41hMlZ62Z2J75l2fZ5eW2EkYTgmwMr1?=
 =?us-ascii?Q?2fcMN5PNaPU5Nu99yLqDJFZIau+OEIr/Z9UPPRfokk8bN1Yxw0+I6mGXgh6r?=
 =?us-ascii?Q?cPgCPLXD8jYo4RwrT1Jeof6Kamq6ugpozmDZ7U2eNKLYPNzqk16hz1i40P0v?=
 =?us-ascii?Q?OeosXkldhHw3Di0CpkC++3bGA9NALVS+GIx5D4mHweviMVLHbFBbzJLcRKM7?=
 =?us-ascii?Q?0onWZ1p1/Am0jHO/nYnsCMfLKuPU+KH8k3Ktdn3Lyt2JXDSwtEZUZYXa4cOF?=
 =?us-ascii?Q?mpVdLEUjVRll8dQ9xK6yXPAYl+EDtgQhmhRa8fs0v/I8DSHxnhk0nGQJz7/M?=
 =?us-ascii?Q?xzCBMJuONDWdQA+zE/d6ydK6JzUc1JUyUaxVLCaquIthc3WA6u3aMOy7KkAY?=
 =?us-ascii?Q?EgNQVjAMT8jm6HODh8ApcxPAh8CllAgS9fRyjwTh0x92kEpRuR/7zAaBMqhe?=
 =?us-ascii?Q?bWJUV85oRYE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i8Df11KihDgOEJCwdDlyvgGDb5zNpTSYmFTXtZcMHwF8P7JYDvWOxaT4VGOQ?=
 =?us-ascii?Q?a9JoRTxObzFKgU3Jb9WzA3mHxQwkTT4soavE5xN7VF62sOWBkTQjs9apMvZv?=
 =?us-ascii?Q?oTiHNU6KEu8Kjhorn7HAH06PZbgC2GNKeXfy+bUWVAmpOmrF4/ogArVEVrLN?=
 =?us-ascii?Q?6AGz6ImLeRO88MH/kuw2Z2PhpvE8wUVz/6uoQVjjucwrhgqHZ3EOcfL6jOLQ?=
 =?us-ascii?Q?6NUOKMQC7Yhn06wG2RBU2uEyvXf7//+XjRnLBUoGKSbwZ/islOM/xeAcy/Jl?=
 =?us-ascii?Q?N4/l4AtZNS0dxKij2mUNNLWXNaIF3ZzzQ5SY0eMzyDnKE2f/oBaFR91M76fP?=
 =?us-ascii?Q?DEES0R43rruNb20VWpEWgz/hG7/I3psQBVPWUpRnlJ2aVETM027OVs+9tZRb?=
 =?us-ascii?Q?Ceha+M2emQFkJM8h2aRLy0/vclbpML2WfKCWVvlVjqb7OZg1VidK6rgGLYh4?=
 =?us-ascii?Q?EmZ5jm97COgECRVkSfxiVZP/jTeaLZntKHANsc+zRG7jMyqLuypSCfQ1a409?=
 =?us-ascii?Q?nn2RUrdR9Ma6318WDiH12EsZidlAQKB0dhmEhR60Qcm8I+PHrGY2cK20CxfS?=
 =?us-ascii?Q?FrC2F+jio5IOTliB+jOdfxEXyvSr6qPktwJXZ0BQ+7uyLAbnjJS73Id1hZwG?=
 =?us-ascii?Q?WexeK2hQnSZAVNudsrOckl2QNtB6nKPOBklxhpiK4mniNMbEVVZcr84eESgc?=
 =?us-ascii?Q?zwX0UYo10cuYR2uRWex5qNfCAoqAMx8lyNhDYHE3db+IqcFi4EsTGHrmiX5Y?=
 =?us-ascii?Q?CdzSVtS6RlXsDq8UkjfiwV4QacVbXZW2gtkNZ45Jlvh0novZ5uy2GW+biVu4?=
 =?us-ascii?Q?y3FqiK7n8TdDXm3sJ2NKCkEeFV4jFu8Fr4gcht45G7Lu8e904VpTgimOA4c6?=
 =?us-ascii?Q?ahVbtGPiVQV69Dw0WxyTE7ydO0bSfrs8u4ckuK+mYlBBC2og+gs5UXBAQLis?=
 =?us-ascii?Q?6O2guWxbrahM78VhvEQxxXtWWJSmhdJH57qB3BYNYM0LwUgv56Mn5PlAu1kI?=
 =?us-ascii?Q?JFTmY6csyaEBpSc7ft0zVLRdQO2ISonzCxWxwPoBnpu3hBQTxtdj4oHhuC/j?=
 =?us-ascii?Q?dNISYqmieB1Ja9AIWfbKutOMFipQNduIUU90xy0IX3LVIIMZF2rToQLAp9JL?=
 =?us-ascii?Q?ri7HaylDO9dFD3ffuujpqZ6jdJn4uCfNAFARmVTmUCEMAuu9+y6CcxvVn5jR?=
 =?us-ascii?Q?mcIjJM1t55BNLuwdge6cpHhP29LEFu3AABZ2l/RQXPQSc4HidFREVmCVc+jZ?=
 =?us-ascii?Q?ATpCNCrg37yPp+B7BMOvY+AxgUQGRyuzUroBUoJdSLuF1Iv7yLcmwiqiK7xL?=
 =?us-ascii?Q?rPvzc+QolX4HCMnkP7SCrlmxjErcn+lmxxia72eQbq19aS4LihKysZpZqDdH?=
 =?us-ascii?Q?efwZMA9RrfIxnFTrMGPMtoC2dy1DNAeRG9nWRvOCve/aQMGgBwt2g3eIBbS0?=
 =?us-ascii?Q?mYDeLAl+xK2+YQhPE4H18QjArrH4FjUqeREE2HsBvYXxF27Vn0JcQTC3hEz9?=
 =?us-ascii?Q?/yW+pUXBpIxkb+xzsSw5HBRFVjAV0mz3n5PtM54MqoYqwxBETm6noTUoHiJT?=
 =?us-ascii?Q?qi/2dee/euB24Mz9tSDfq6zBsiXDEpZwTYCNxeijL9NC97NwWxfNPqLpu5mO?=
 =?us-ascii?Q?ueHdd4L6TbHIzC+H9Ml3MRjZeVsUPAnLuYZuv6Sj0QOQQerjLNAw29n9eUd/?=
 =?us-ascii?Q?c8wF1JhRGBd7DCglWBAG2ssbv8U=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51aaa1b8-b99d-402f-e201-08ddeb6857dd
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:05:54.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4KykSjIm862KV7Hn2YGR5tDOekf7D4VLIsQ5Oc34FjOsLqi0Y3BM9yyP3G5re5B/WzwLcWPs5QHduQ5KWTXo+e/aa1pFT/LBP+Y1VWDRDT6tAwcjbYvQa/l4AxUUU0X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7559

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

If the mailbox ring buffer is full, the driver stops the
incoming packet queues until a message has been sent,
freeing space in the ring buffer.

When the Type 3 channel outbox receives a txdone response
interrupt, it consumes the outgoing sk_buff, allowing
it to be freed.

Bringing up an interface creates the channel between the
network driver and the mailbox driver.  This enables
communication with the remote endpoint, to include the
receipt of new messages. Bringing down and interface
removes the channel, and no new messages can be delivered.
Stopping the interface also frees any packets that are
cached in the mailbox ringbuffer.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 367 ++++++++++++++++++++++++++++++++++++
 4 files changed, 386 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bce96dd254b8..de359bddcb2f 100644
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
index 000000000000..8c8e718d456c
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,367 @@
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
+#include <linux/mailbox_client.h>
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
+	skb_queue_head(&box->packets, skb);
+
+	return skb->data;
+}
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *curr_skb = NULL;
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
+	spin_lock(&mctp_pcc_ndev->inbox.packets.lock);
+	skb_queue_walk(&mctp_pcc_ndev->inbox.packets, curr_skb) {
+		if (curr_skb->data != buffer)
+			continue;
+		skb = curr_skb;
+		__skb_unlink(skb, &mctp_pcc_ndev->inbox.packets);
+		break;
+	}
+	spin_unlock(&mctp_pcc_ndev->inbox.packets.lock);
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
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = NULL;
+	struct sk_buff *curr_skb;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	outbox = container_of(c, struct mctp_pcc_mailbox, client);
+	spin_lock(&outbox->packets.lock);
+	skb_queue_walk(&outbox->packets, curr_skb) {
+		if (curr_skb->data == mssg) {
+			skb = curr_skb;
+			__skb_unlink(skb, &outbox->packets);
+			break;
+		}
+	}
+	spin_unlock(&outbox->packets.lock);
+	if (skb)
+		dev_consume_skb_any(skb);
+	netif_wake_queue(mctp_pcc_ndev->ndev);
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
+	skb_queue_head(&mpnd->outbox.packets, skb);
+
+	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb->data);
+
+	if (rc < 0) {
+		netif_stop_queue(ndev);
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
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+	mctp_pcc_ndev->outbox.chan->manage_writes = true;
+
+	return 0;
+}
+
+static int mctp_pcc_ndo_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
+	drain_packets(&mctp_pcc_ndev->outbox.packets);
+	drain_packets(&mctp_pcc_ndev->inbox.packets);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_ndo_open,
+	.ndo_stop = mctp_pcc_ndo_stop,
+	.ndo_start_xmit = mctp_pcc_tx,
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
+static void mctp_pcc_initialize_mailbox(struct device *dev,
+					struct mctp_pcc_mailbox *box, u32 index)
+{
+	box->index = index;
+	skb_queue_head_init(&box->packets);
+	box->client.dev = dev;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static int initialize_MTU(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox;
+	int mctp_pcc_mtu;
+
+	outbox = &mctp_pcc_ndev->outbox;
+	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	mctp_pcc_mtu = outbox->chan->shmem_size - sizeof(struct pcc_header);
+	if (IS_ERR(outbox->chan))
+		return PTR_ERR(outbox->chan);
+
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
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
+	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+
+	mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+				    context.inbox_index);
+	mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+				    context.outbox_index);
+	if (rc)
+		goto free_netdev;
+
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->ndev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	initialize_MTU(ndev);
+
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


