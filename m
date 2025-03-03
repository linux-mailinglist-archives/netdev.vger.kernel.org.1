Return-Path: <netdev+bounces-171144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B8A4BB37
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C113C3AAC63
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E731D1F131A;
	Mon,  3 Mar 2025 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sAzGTW0X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308F2033A
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995608; cv=fail; b=TcDlwT0dcuPQqnfYLqQDdqpM9BX7oyt/zh5BxPFqYO/jF7KNP6+Kz1Xe2dwO2zvJ9P+lhBe5fmxIfcbmIOhsL4dHXUbce7zZAYDpGonXUFw//ZvnBUtCKl1Dur+kHGWqoub2bQVVVO7aDWP0GEk6L3VsKHLg/lG4+LPPVzslAP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995608; c=relaxed/simple;
	bh=H4FDxgW3YOkXR7TvXIMAeOHwgVZAbzVMJoKAYkCzeH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qgNWMCXGGCa3SeQA8ejoRWqb2bmBYYn7nJgR+1qccYKANbatSRFgFEI3XTfM0nN8v+kzqiv4TmJLzHw8xjrDJDJ4BXRnDPCN0s3R2+uUyJcIt7CPipBfWkzmN2a/7p3ba090nLw3zHz2WLOzB2R0cjc1a1gUuVHr8HFV286LADc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sAzGTW0X; arc=fail smtp.client-ip=40.107.95.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA4qFduTao5uBKdKfhqtXV84swzQtFUtxS5kr7Gg39v2NINigeS3NjHgzsD5tbV4wKd3nHcPpwx5RpLxieb5JAZ0HMdHj2TZQaKQGA+dkTHjTILW9vF+4tb3XOgQ9lFdCtqrDF2kA4k/3NohWn+aXWZevL+s1RKEjCU94D5m02mWsfvIdOe9S3VhxoNzF7JIPcr/Tbm58qLEvV/Ub1aLOLyqd7g6sNOiWUBjGbklO7qRWwktvUkbB1sEavHmvn4mx6szEy509WHjmlOKMVN2pQSQhh5vtA5/y5jtZ5RyXQNG8sqrqUV7QtQ5KprCnRHnUnVl2VD47HUYhvTD1FDt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaBDqeFxNCRFfhU8wDdqUhdW1sRjlkT1h5s23u6d0nI=;
 b=egQ1Lmrpt93vXBRQhUP7m9n7VUbo2Ep14EsuVji08GUBcdlL68EBMeAjSdePvLaM9wrrOsQ6+R//O6zGENHUb5TB0o0MJQYouZoGtVV66OMUzrPImKbMjhV+7z2ZWCPJsB5l6srdgXW37GOKSFT2uyZAXhFrx5ta45tANqzLWooGKyyFk0LWTB3BOtuZlGhyUSZJvY5M1IraWrVip8KhqeRls5WE9o31RAFBGRXycDcRU+1tHzogc8t6+v09GZzC+XPPSSKasAq1VYVMNihc//PqzgiLpoWbwcv8Ov1pMMLg4CwxBwCSlOhbrUB+mT+zmanJF7Q8L5CQlwiUhOmvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaBDqeFxNCRFfhU8wDdqUhdW1sRjlkT1h5s23u6d0nI=;
 b=sAzGTW0XEJoHDV0nn5fb+g9T9n/k3Wt/GCbQ9HU/lMivxWPCDWFJ+jnNhF7fPBO1gZrGWJWXehj0dlxqbpjosYLiXI1XO8mLXBPITOpLChv5l5HDZlzaMoz6JyDbSXEs6M0fTb/XpgyryYQXEY+2nl68qhbx8EROlYlZlElsoNTwIq1M1HrNEKmkJynF2Io9/xuRU42VTpnS2xkkfOkIOUtErenqujX77z9F/XIoDMzimy/D+c8PUIltolGRa8tLqG++XMGeJGq6CSqBKGaRagHAwbx59ogX9+13EhOTQk0fX2FcEX8L8YG4VmOoCTvlyfzK0W1oyURDRog0XzBdyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:53:21 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:53:21 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	jacob.e.keller@intel.com
Subject: [PATCH v27 01/20] net: Introduce direct data placement tcp offload
Date: Mon,  3 Mar 2025 09:52:45 +0000
Message-Id: <20250303095304.1534-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::17) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: e150ce5f-9d4c-4738-d8a1-08dd5a393b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aDkry6SrRh/0wb4ZxDYdbbzj14qckVvNpnXmX43w0i4SxQ5gkL+polUXNdjE?=
 =?us-ascii?Q?1pymQvIOqgXnsNC1G8ijS29p5rJBumL2iXp2xcSAw3OzOZYkXcCQZivnw9+n?=
 =?us-ascii?Q?1JAGCHXSBxYeDfsPsE8Uq5hlPSsSkGB25Np91gVSQ2fhDiHffERlhxKAK5/+?=
 =?us-ascii?Q?ZR7KOYnyJKzKn+I1iUkaSoqjI52RsOkQpJ/GZt21zcTxkffQxTs8LQFUmcsp?=
 =?us-ascii?Q?jJnKG9kZP7eVbyqmr1QNXIp4IZjcvQpUTruedilLu7/2xwr+ScopoWbTFZZi?=
 =?us-ascii?Q?uZwBF8omXdj8geZRQvIR6T+UzavdUqGDa9DPXGikzsPgkFxZ2Hf2dJfKAO31?=
 =?us-ascii?Q?K9xAw7khDsnkZxp29ioehwNDOMHtXOVJGdrYp+owAHfQ8k+Q7enuiZ+lIEbK?=
 =?us-ascii?Q?Du1m/fAfoQnalEQp25TIZU8K/Dtycy7bIUrrs9XgJu/FixrWQSuT0HSHRjkQ?=
 =?us-ascii?Q?XQBeR9iExPMLGc9F5J6AJJDkfYHWAA1v5F3e6GacZD2C2N3/V6qV8p3if8iO?=
 =?us-ascii?Q?xzYsf/b1eQbhu/98oPOQ9mMpVaCQ3fBHkxU3Kjp83+GbjuqBXTIa4wI1PLho?=
 =?us-ascii?Q?CEdJYixiujuozNooY7oL0uJRPUxANIbMvUbOCytu4OUA9lCW0En/IwR51PqI?=
 =?us-ascii?Q?w6irdC+zAg3ddwVrYlmsseRHfoRlhH4FbDCKRjW9NXHSzP9hCMtG/JCzZDOH?=
 =?us-ascii?Q?HKZOHScEB96ca67FIQaEbfcbLm9iKnP6qoy6T0CeiWw5kg8oQYkUP91xv+qC?=
 =?us-ascii?Q?F+DFHgq+XdGR591Wlhzb168sD0a3XFVwmhXPPs24IHk6rtINA9u8WBX8ZZ9T?=
 =?us-ascii?Q?sFIe1qR09m1otReuVoNpoH+jIG3LZt/2ioOp12z6GEVEYHboC8+3WLi3VBfg?=
 =?us-ascii?Q?hSOyLOHmrU26+koIdvogHVJP1lffxaB9p021bDz3vz5VXKahuIiUMsduCXrM?=
 =?us-ascii?Q?DLjid52pmWL7FYakxjc7d2Kjbj9aRvd6Lw9ID6rIoTxNMyYH29eYGRUWX2xC?=
 =?us-ascii?Q?y8+j8tIV+rVVxDSOcKVFi7iH/PjghlyMO3qKoKUeJ8j0fNr6gPVm7WsrFliK?=
 =?us-ascii?Q?yoARu8IcBoqt76iCxisr8gj4LfK7dJgphKjp7DAir8/9oZ1OmkxxZ49hIXQA?=
 =?us-ascii?Q?rNTI4pXoTpr+PxSgZ+gdDr+lvcZSGhOpBdTJJAhXRwVSDddpKkC20F9gR8gB?=
 =?us-ascii?Q?j3hMLZtfMRdNjnrPVDvRplkF4LJ/GP1FY2k9De3JhSed6qP7VJy5cx5mqBq8?=
 =?us-ascii?Q?Ln4FS2lIGeRmwbpup8WVVAVS+2ZnUemOGsrPtIydiRlNtBbWRqFStgrXZzBw?=
 =?us-ascii?Q?/SQaqJmqWPFtxiKi9S9FthEJAJPkm3E+urfmdoAyZPfKSePRLLzp/BdGV8Y/?=
 =?us-ascii?Q?zZzcYDew0tyzGh7aHBKBbOUPejki?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wzoQ+mFlSMA960rY1oFreO6k92r+hf9Pd2+euXiMKk+J2OBFajE4FmbB3SRE?=
 =?us-ascii?Q?7fa9stiK57il7l7blz80e7/n8W7xcJFhfv6utkmsB/i2i4FO3OX9sMylr2P3?=
 =?us-ascii?Q?AomVHpneP6MLILBZMnJilub0faGJ3cmy7uMH2JXc1G1N+GDfUNBjJWaBM1U+?=
 =?us-ascii?Q?quRunMriwM2KdNCcuuBq5RvVtIqM4Bs1h6ld0xoYvmk7Ifvv8Ll4ZDMQeF53?=
 =?us-ascii?Q?Gwoaq8+1JE95SkBC8M+vu2uD1UuhicOru5KLhTtBjrcWKuyOP9pDOulIN+0f?=
 =?us-ascii?Q?JmevBEhc/yDUZWvPFHyw/c/ig9ltjuuEo7BC4/4EUevYtISzBsk9hWYEPJLM?=
 =?us-ascii?Q?6lH1YBOZv20DnlDGJpmzKQ8CRjhaK6/FpMaDudbUCuBeacIAxV3MPaQSk8wK?=
 =?us-ascii?Q?RokzSyV+PDZmqJkTEejCevgopISvMqslohYm3t1ZaNWSi5psNFZMn66dBHOA?=
 =?us-ascii?Q?Cp6O7Zbq5ylNGOHrrA+sIi09LQnwcWWRqmSeRgr24JtWeaDX/M4YLHJxLnkm?=
 =?us-ascii?Q?Usq9Bf8xGyubsPfTKhpQ7DSrAgNRnsw2KYXeD5oTv5HL4aZQZasL6Lz9cu6w?=
 =?us-ascii?Q?fFVIthlkssnrA6ISRkReZl7+7cZEPUGldc/fsEV3SYoK/ulEXdn+4cKxef3+?=
 =?us-ascii?Q?ggC+D/2bdL3F74PeQAuDKoMQTLpW+msVUYhI1M4BNWKjeS3HhDmmDJwlEuNY?=
 =?us-ascii?Q?uX2ej2rEwV8My5omdy4s7nT/t3GVkaN0rJTuGU1XM+EJ0/pZUWETDgNXD8lO?=
 =?us-ascii?Q?4+JK20qMw8iXs7rxFmyaJfjLQDhpTS5vMLOcXy86Rjul0xMnoZ6gn26I888j?=
 =?us-ascii?Q?ITAvYcEgrZlxXaRWUEGWcqwYIjflZU0c+GideF5xsyTM93GDUfY86rau4chJ?=
 =?us-ascii?Q?dozM6rbpv0eyK3S3yg62q1FfiyOoev00e+i21rrw4w1EOglt6+3VW6dPnvF0?=
 =?us-ascii?Q?JKz246l7x4BJZRbFSIEiXq/U6fck6HETFFmpTuLpbhnPkhGVEnp0iMx2G24O?=
 =?us-ascii?Q?1MO6cNXp5SJybUHOkFu+LdHm5njs381osQukXRWriGD07PDV+7ai73txDyt9?=
 =?us-ascii?Q?qDx/V9K+riUcKbvacKXj+2+LFFeL3Ngrr7aM2hkqYL/O4qlpbu9EEwmBhudl?=
 =?us-ascii?Q?a1lCFtv9f5+y5pYqw8FtlN3plAPcriZARy6dmnCN9tB+nOJGJNnLb/PDqpTa?=
 =?us-ascii?Q?TKFHX/w3pGlm7+YXcCeoaF5O8at3Ca87e49u/2S7Utd3yuTcRIT+KCp+M3nd?=
 =?us-ascii?Q?a/XnWbNIsr2MYSxxdYkcvQNiwu+1v5WlvV1v7/98aV3Xks/a9Uk8+vrhCtmD?=
 =?us-ascii?Q?90WEcqUSi3Y9aeInSFOhB2Yvi1+9wyQ2JYOLF7u88gE+KD/lc14Aq9pOIjhJ?=
 =?us-ascii?Q?zD1QEeSr3kc1XnQJSOdj8whHhmoi99BUz6OMccVl6hsi14vrywZb/LJeENL7?=
 =?us-ascii?Q?uMTLTRwLJLrzMYTmNPcLUvC3ttZ2ZuDcT/2IjDjzdZZVyeCeat3eesjTiESH?=
 =?us-ascii?Q?4+vL4mHiycleEjKzaM8Ag0JKYXET0nQJz2Dii3qvaWFb5QDfzYEpW3B24cSn?=
 =?us-ascii?Q?qQLj1MNGifAXdosIL4V+L1ZnmlwiQEgE1bqwiUtR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e150ce5f-9d4c-4738-d8a1-08dd5a393b88
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:53:21.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cizcZB2uJcRDwLGMcYt1sjnCZ2z7Y6s4tjqCRwXMB0Hm5uOm9LNAHosCuc9gA+7nXyKHcX+lcythpHUYkwXdOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement (DDP) offload for TCP.

The motivation is saving compute resources/cycles that are spent
to copy data from SKBs to the block layer buffers and CRC
calculation/verification for received PDUs (Protocol Data Units).

The DDP capability is accompanied by new net_device operations that
configure hardware contexts.

There is a context per socket, and a context per DDP operation.
Additionally, a resynchronization routine is used to assist
hardware handle TCP OOO, and continue the offload. Furthermore,
we let the offloading driver advertise what is the max hw
sectors/segments.

The interface includes the following net-device ddp operations:

 1. sk_add - add offload for the queue represented by socket+config pair
 2. sk_del - remove the offload for the socket/queue
 3. ddp_setup - request copy offload for buffers associated with an IO
 4. ddp_teardown - release offload resources for that IO
 5. limits - query NIC driver for quirks and limitations (e.g.
             max number of scatter gather entries per IO)
 6. set_caps - request ULP DDP capabilities enablement
 7. get_caps - request current ULP DDP capabilities
 8. get_stats - query NIC driver for ULP DDP stats

Using this interface, the NIC hardware will scatter TCP payload
directly to the BIO pages according to the command_id.

To maintain the correctness of the network stack, the driver is
expected to construct SKBs that point to the BIO pages.

The SKB passed to the network stack from the driver represents
data as it is on the wire, while it is pointing directly to data
in destination buffers.

As a result, data from page frags should not be copied out to
the linear part. To avoid needless copies, such as when using
skb_condense, we mark the skb->no_condense bit.
In addition, the skb->ulp_crc will be used by the upper layers to
determine if CRC re-calculation is required. The two separated skb
indications are needed to avoid false positives GRO flushing events.

Follow-up patches will use this interface for DDP in NVMe-TCP.

Capability bits stored in net_device allow drivers to report which
ULP DDP capabilities a device supports. Control over these
capabilities will be exposed to userspace in later patches.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h          |   5 +
 include/linux/skbuff.h             |  50 +++++
 include/net/inet_connection_sock.h |   6 +
 include/net/tcp.h                  |   3 +-
 include/net/ulp_ddp.h              | 326 +++++++++++++++++++++++++++++
 net/Kconfig                        |  20 ++
 net/core/Makefile                  |   1 +
 net/core/skbuff.c                  |   3 +-
 net/core/ulp_ddp.c                 |  54 +++++
 net/ipv4/tcp_input.c               |   2 +
 net/ipv4/tcp_offload.c             |   1 +
 11 files changed, 469 insertions(+), 2 deletions(-)
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 26a0c4e4d963..ceba93aeed5a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1396,6 +1396,8 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ * struct ulp_ddp_dev_ops *ulp_ddp_ops;
+ *	ULP DDP operations (see include/net/ulp_ddp.h)
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1651,6 +1653,9 @@ struct net_device_ops {
 	 */
 	const struct net_shaper_ops *net_shaper_ops;
 #endif
+#if IS_ENABLED(CONFIG_ULP_DDP)
+	const struct ulp_ddp_dev_ops *ulp_ddp_ops;
+#endif
 };
 
 /**
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 14517e95a46c..3843e27fa3c4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -848,6 +848,8 @@ enum skb_tstamp_type {
  *	@slow_gro: state present at GRO time, slower prepare step required
  *	@tstamp_type: When set, skb->tstamp has the
  *		delivery_time clock base of skb->tstamp.
+ *	@no_condense: When set, don't condense fragments (DDP offloaded)
+ *	@ulp_crc: CRC offloaded
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -1025,6 +1027,10 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 	__u8			unreadable:1;
+#ifdef CONFIG_ULP_DDP
+	__u8                    no_condense:1;
+	__u8			ulp_crc:1;
+#endif
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -5274,5 +5280,49 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize, gfp_t gfp);
 
+static inline bool skb_is_no_condense(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->no_condense;
+#else
+	return 0;
+#endif
+}
+
+static inline bool skb_is_ulp_crc(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->ulp_crc;
+#else
+	return 0;
+#endif
+}
+
+static inline bool skb_cmp_ulp_crc(const struct sk_buff *skb1,
+				   const struct sk_buff *skb2)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb1->ulp_crc != skb2->ulp_crc;
+#else
+	return 0;
+#endif
+}
+
+static inline void skb_copy_no_condense(struct sk_buff *to,
+					const struct sk_buff *from)
+{
+#ifdef CONFIG_ULP_DDP
+	to->no_condense = from->no_condense;
+#endif
+}
+
+static inline void skb_copy_ulp_crc(struct sk_buff *to,
+				    const struct sk_buff *from)
+{
+#ifdef CONFIG_ULP_DDP
+	to->ulp_crc = from->ulp_crc;
+#endif
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index d9978ffacc97..1e88149d88ac 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -67,6 +67,8 @@ struct inet_connection_sock_af_ops {
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
  * @icsk_clean_acked	   Clean acked data hook
+ * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
+ * @icsk_ulp_ddp_data	   ULP direct data placement private data
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -98,6 +100,10 @@ struct inet_connection_sock {
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
 	void __rcu		  *icsk_ulp_data;
 	void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
+#ifdef CONFIG_ULP_DDP
+	const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
+	void __rcu		  *icsk_ulp_ddp_data;
+#endif
 	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
 	__u8			  icsk_ca_state:5,
 				  icsk_ca_initialized:1,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9745c7f18170..06e1b752612b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1099,7 +1099,8 @@ static inline bool tcp_skb_can_collapse_rx(const struct sk_buff *to,
 					   const struct sk_buff *from)
 {
 	return likely(mptcp_skb_can_collapse(to, from) &&
-		      !skb_cmp_decrypted(to, from));
+		      !skb_cmp_decrypted(to, from) &&
+		      !skb_cmp_ulp_crc(to, from));
 }
 
 /* Events passed to congestion control interface */
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
new file mode 100644
index 000000000000..7b32bb9e2a08
--- /dev/null
+++ b/include/net/ulp_ddp.h
@@ -0,0 +1,326 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ulp_ddp.h
+ *   Author:	Boris Pismenny <borisp@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#ifndef _ULP_DDP_H
+#define _ULP_DDP_H
+
+#include <linux/netdevice.h>
+#include <net/inet_connection_sock.h>
+#include <net/sock.h>
+
+enum ulp_ddp_type {
+	ULP_DDP_NVME = 1,
+};
+
+/**
+ * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+ *
+ * @full_ccid_range:	true if the driver supports the full CID range
+ */
+struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+};
+
+/**
+ * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+ * protocol limits.
+ * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+ *
+ * @type:		type of this limits struct
+ * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+ * @io_threshold:	minimum payload size required to offload
+ * @tls:		support for ULP over TLS
+ * @nvmeotcp:		NVMe-TCP specific limits
+ */
+struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+};
+
+/**
+ * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+ *
+ * @pfv:	pdu version (e.g., NVME_TCP_PFV_1_0)
+ * @cpda:	controller pdu data alignment (dwords, 0's based)
+ * @dgst:	digest types enabled (header or data, see
+ *		enum nvme_tcp_digest_option).
+ *		The netdev will offload crc if it is supported.
+ * @queue_size: number of nvme-tcp IO queue elements
+ */
+struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+};
+
+/**
+ * struct ulp_ddp_config - Generic ulp ddp configuration
+ * Add new instances of ulp_ddp_config in the union below (nvme-tcp, etc.).
+ *
+ * @type:	type of this config struct
+ * @nvmeotcp:	NVMe-TCP specific config
+ * @affinity_hint:	cpu core running the IO thread for this socket
+ */
+struct ulp_ddp_config {
+	enum ulp_ddp_type    type;
+	int		     affinity_hint;
+	union {
+		struct nvme_tcp_ddp_config nvmeotcp;
+	};
+};
+
+/**
+ * struct ulp_ddp_io - ulp ddp configuration for an IO request.
+ *
+ * @command_id: identifier on the wire associated with these buffers
+ * @nents:	number of entries in the sg_table
+ * @sg_table:	describing the buffers for this IO request
+ * @first_sgl:	first SGL in sg_table
+ */
+struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+};
+
+/**
+ * struct ulp_ddp_stats - ULP DDP offload statistics
+ * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
+ * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared
+ *                           for offloading.
+ * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
+ * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for
+ *                         Direct Data Placement.
+ * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
+ * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
+ * @rx_nvmeotcp_drop: number of PDUs dropped.
+ * @rx_nvmeotcp_resync: number of resync.
+ * @rx_nvmeotcp_packets: number of offloaded PDUs.
+ * @rx_nvmeotcp_bytes: number of offloaded bytes.
+ */
+struct ulp_ddp_stats {
+	u64 rx_nvmeotcp_sk_add;
+	u64 rx_nvmeotcp_sk_add_fail;
+	u64 rx_nvmeotcp_sk_del;
+	u64 rx_nvmeotcp_ddp_setup;
+	u64 rx_nvmeotcp_ddp_setup_fail;
+	u64 rx_nvmeotcp_ddp_teardown;
+	u64 rx_nvmeotcp_drop;
+	u64 rx_nvmeotcp_resync;
+	u64 rx_nvmeotcp_packets;
+	u64 rx_nvmeotcp_bytes;
+
+	/*
+	 * add new stats at the end and keep in sync with
+	 * Documentation/netlink/specs/ulp_ddp.yaml
+	 */
+};
+
+#define ULP_DDP_CAP_COUNT 1
+
+struct ulp_ddp_dev_caps {
+	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
+	DECLARE_BITMAP(hw, ULP_DDP_CAP_COUNT);
+};
+
+struct netlink_ext_ack;
+
+/**
+ * struct ulp_ddp_dev_ops - operations used by an upper layer protocol
+ *                          to configure ddp offload
+ *
+ * @limits:    query ulp driver limitations and quirks.
+ * @sk_add:    add offload for the queue represented by socket+config
+ *             pair. this function is used to configure either copy, crc
+ *             or both offloads.
+ * @sk_del:    remove offload from the socket, and release any device
+ *             related resources.
+ * @setup:     request copy offload for buffers associated with a
+ *             command_id in ulp_ddp_io.
+ * @teardown:  release offload resources association between buffers
+ *             and command_id in ulp_ddp_io.
+ * @resync:    respond to the driver's resync_request. Called only if
+ *             resync is successful.
+ * @set_caps:  set device ULP DDP capabilities.
+ *	       returns a negative error code or zero.
+ * @get_caps:  get device ULP DDP capabilities.
+ * @get_stats: query ULP DDP statistics.
+ */
+struct ulp_ddp_dev_ops {
+	int (*limits)(struct net_device *netdev,
+		      struct ulp_ddp_limits *limits);
+	int (*sk_add)(struct net_device *netdev,
+		      struct sock *sk,
+		      struct ulp_ddp_config *config);
+	void (*sk_del)(struct net_device *netdev,
+		       struct sock *sk);
+	int (*setup)(struct net_device *netdev,
+		     struct sock *sk,
+		     struct ulp_ddp_io *io);
+	void (*teardown)(struct net_device *netdev,
+			 struct sock *sk,
+			 struct ulp_ddp_io *io,
+			 void *ddp_ctx);
+	void (*resync)(struct net_device *netdev,
+		       struct sock *sk, u32 seq);
+	int (*set_caps)(struct net_device *dev, unsigned long *bits,
+			struct netlink_ext_ack *extack);
+	void (*get_caps)(struct net_device *dev,
+			 struct ulp_ddp_dev_caps *caps);
+	int (*get_stats)(struct net_device *dev,
+			 struct ulp_ddp_stats *stats);
+};
+
+#define ULP_DDP_RESYNC_PENDING BIT(0)
+
+/**
+ * struct ulp_ddp_ulp_ops - Interface to register upper layer
+ *                          Direct Data Placement (DDP) TCP offload.
+ * @resync_request:         NIC requests ulp to indicate if @seq is the start
+ *                          of a message.
+ * @ddp_teardown_done:      NIC driver informs the ulp that teardown is done,
+ *                          used for async completions.
+ */
+struct ulp_ddp_ulp_ops {
+	bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+	void (*ddp_teardown_done)(void *ddp_ctx);
+};
+
+/**
+ * struct ulp_ddp_ctx - Generic ulp ddp context
+ *
+ * @type:	type of this context struct
+ * @buf:	protocol-specific context struct
+ */
+struct ulp_ddp_ctx {
+	enum ulp_ddp_type	type;
+	unsigned char		buf[];
+};
+
+static inline struct ulp_ddp_ctx *ulp_ddp_get_ctx(struct sock *sk)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return (__force struct ulp_ddp_ctx *)icsk->icsk_ulp_ddp_data;
+#else
+	return NULL;
+#endif
+}
+
+static inline void ulp_ddp_set_ctx(struct sock *sk, void *ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	rcu_assign_pointer(icsk->icsk_ulp_ddp_data, ctx);
+#endif
+}
+
+static inline int ulp_ddp_setup(struct net_device *netdev,
+				struct sock *sk,
+				struct ulp_ddp_io *io)
+{
+#ifdef CONFIG_ULP_DDP
+	return netdev->netdev_ops->ulp_ddp_ops->setup(netdev, sk, io);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline void ulp_ddp_teardown(struct net_device *netdev,
+				    struct sock *sk,
+				    struct ulp_ddp_io *io,
+				    void *ddp_ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->teardown(netdev, sk, io, ddp_ctx);
+#endif
+}
+
+static inline void ulp_ddp_resync(struct net_device *netdev,
+				  struct sock *sk,
+				  u32 seq)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->resync(netdev, sk, seq);
+#endif
+}
+
+static inline int ulp_ddp_get_limits(struct net_device *netdev,
+				     struct ulp_ddp_limits *limits,
+				     enum ulp_ddp_type type)
+{
+#ifdef CONFIG_ULP_DDP
+	limits->type = type;
+	return netdev->netdev_ops->ulp_ddp_ops->limits(netdev, limits);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline bool ulp_ddp_cap_turned_on(unsigned long *old,
+					 unsigned long *new,
+					 int bit_nr)
+{
+	return !test_bit(bit_nr, old) && test_bit(bit_nr, new);
+}
+
+static inline bool ulp_ddp_cap_turned_off(unsigned long *old,
+					  unsigned long *new,
+					  int bit_nr)
+{
+	return test_bit(bit_nr, old) && !test_bit(bit_nr, new);
+}
+
+#ifdef CONFIG_ULP_DDP
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   netdevice_tracker *tracker,
+		   gfp_t gfp,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    netdevice_tracker *tracker,
+		    struct sock *sk);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr);
+
+#else
+
+static inline int ulp_ddp_sk_add(struct net_device *netdev,
+				 netdevice_tracker *tracker,
+				 gfp_t gfp,
+				 struct sock *sk,
+				 struct ulp_ddp_config *config,
+				 const struct ulp_ddp_ulp_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void ulp_ddp_sk_del(struct net_device *netdev,
+				  netdevice_tracker *tracker,
+				  struct sock *sk)
+{}
+
+static inline bool ulp_ddp_is_cap_active(struct net_device *netdev,
+					 int cap_bit_nr)
+{
+	return false;
+}
+
+#endif
+
+#endif	/* _ULP_DDP_H */
diff --git a/net/Kconfig b/net/Kconfig
index c3fca69a7c83..bf09e302007b 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -538,4 +538,24 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config ULP_DDP
+	bool "ULP direct data placement offload"
+	help
+	  This feature provides a generic infrastructure for Direct
+	  Data Placement (DDP) offload for Upper Layer Protocols (ULP,
+	  such as NVMe-TCP).
+
+	  If the ULP and NIC driver supports it, the ULP code can
+	  request the NIC to place ULP response data directly
+	  into application memory, avoiding a costly copy.
+
+	  This infrastructure also allows for offloading the ULP data
+	  integrity checks (e.g. data digest) that would otherwise
+	  require another costly pass on the data we managed to avoid
+	  copying.
+
+	  For more information, see
+	  <file:Documentation/networking/ulp-ddp-offload.rst>.
+
+
 endif   # if NET
diff --git a/net/core/Makefile b/net/core/Makefile
index d9326600e289..767ed5186d4d 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 obj-y += net-sysfs.o
 obj-y += hotdata.o
 obj-y += netdev_rx_queue.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f12815f9c83d..ebf0583c6776 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -79,6 +79,7 @@
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
+#include <net/ulp_ddp.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -6912,7 +6913,7 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb) || !skb_frags_readable(skb))
+		    skb_cloned(skb) || !skb_frags_readable(skb) || skb_is_no_condense(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/core/ulp_ddp.c b/net/core/ulp_ddp.c
new file mode 100644
index 000000000000..f8ebd729e119
--- /dev/null
+++ b/net/core/ulp_ddp.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * ulp_ddp.c
+ *   Author:	Aurelien Aptel <aaptel@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+
+#include <net/ulp_ddp.h>
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   netdevice_tracker *tracker,
+		   gfp_t gfp,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops)
+{
+	int ret;
+
+	/* put in ulp_ddp_sk_del() */
+	netdev_hold(netdev, tracker, gfp);
+
+	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
+	if (ret) {
+		dev_put(netdev);
+		return ret;
+	}
+
+	inet_csk(sk)->icsk_ulp_ddp_ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_add);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    netdevice_tracker *tracker,
+		    struct sock *sk)
+{
+	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, sk);
+	inet_csk(sk)->icsk_ulp_ddp_ops = NULL;
+	netdev_put(netdev, tracker);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_del);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
+{
+	struct ulp_ddp_dev_caps caps;
+
+	if (!netdev->netdev_ops->ulp_ddp_ops)
+		return false;
+	netdev->netdev_ops->ulp_ddp_ops->get_caps(netdev, &caps);
+	return test_bit(cap_bit_nr, caps.active);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_is_cap_active);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d22ad553b45b..4cb00c475df7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5482,6 +5482,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 		skb_copy_decrypted(nskb, skb);
+		skb_copy_no_condense(nskb, skb);
+		skb_copy_ulp_crc(nskb, skb);
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
 			__skb_queue_before(list, skb, nskb);
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5..cc129af92296 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -346,6 +346,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 
 	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
 	flush |= skb_cmp_decrypted(p, skb);
+	flush |= skb_cmp_ulp_crc(p, skb);
 
 	if (unlikely(NAPI_GRO_CB(p)->is_flist)) {
 		flush |= (__force int)(flags ^ tcp_flag_word(th2));
-- 
2.34.1


