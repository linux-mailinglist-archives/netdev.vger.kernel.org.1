Return-Path: <netdev+bounces-207109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92353B05CB7
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE821C25640
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A343D2E5411;
	Tue, 15 Jul 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TfakzKCc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A12E49BF
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586115; cv=fail; b=CGFlYTyvz6wsYJLglO+J9AbumbFKquPuhSGoQCHmw2uMtBCatCf2v0Sh2VKR8iQu9cgQKRB7igAgGVJDITJlWj836Ym8Hnt7yEslixJis7OyY+zLiHcQxq1N9JCB/dFisJ+vBk3EZ+X5WmYRtiUOoWzFp6xpub0gavpz4b1DCzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586115; c=relaxed/simple;
	bh=94Ot5LB8iLADONaCb+f90SmDb83n/C4X2o41lZVCCbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bn4JSKhH5rttwyycvSChjNbKg9qhPuYTb5b01hykYXA0TT9PaIRUMK45VqQuphDAajCgr4aILwgmSnlgFPCP6plhbJW4tPAkKSfJ/RuajXcOEFASfKX+a67PJTPGHvt6SKi9SG1r3AZFcZ6n56WGBTIHSIyoXh07CmuLCxhsx8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TfakzKCc; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr+7NdF9+TpIcUI1S+2zJqOXBZXnOOA28cEl49mEB1RuTKESvyx0DnbRa4ip3TNTKyDLRufWvyzHN9xFkPdwUiSVacwCGlTenQam8k1A/hyYFRUySHl/N3CIM0Ci4mplRfEqMM1112GVZjrHMqPoFdlNLXqeYcS5/rXsjJheTIql1TQd16JknBWmOYFzvcUd6Tw/lFwZXQt0LyjL29tDb8y2vqXEkpxOHEdL/W/OjYf7DDW3I7R73W5i7Xse136mO+A33Z7QRHEoR6Tpmo1iOwwWIcqRn9ikDvjhKayjWOLPMaCTzoTHzaJagFevGCijLHtYHL+zFm1RMFjKAt5h/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGIIvJUPBRWpOuq9pAXqdhUsEPpKamhZQ+KYIh+j9EU=;
 b=SGt+bRdoJl4ditsA267ym0EBuLCTeCB6pOOAVUjUbaXJ7eOvBwvueAvxV2cLuXC7z2Fkld34gWSDRmp6OsubGqe63EDRIexD6f5TrkvXtYRpQXiEOnplaG1KCpQR89BWXtqJ84itbqjL5FnItu3mLqkEYzpJIxMUsQyzl555AmDH5NOkpgBg3ppxncw58YxtqfrR4rUZYFEPiwL99IUySe1mR3nEc5qe1vqBUXyilfmZwxuEUG28o8l2MVvmGabBXMp4RDblcCHifD0wEpZVDV4zkroA4XkqqlWCnf8lnclTBp7ZH/idERTTie1g2vvwXshXrhT3qDfOAZlR6Lp8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGIIvJUPBRWpOuq9pAXqdhUsEPpKamhZQ+KYIh+j9EU=;
 b=TfakzKCczsem+oOb0Kli/TcuL0QYRKkvIWRR5i3WylWIFSgncQ4Xa3xk3GaMz+MamnM65pQ/xrChgmDFtSAkmX/Jgi6CvMq5ykG1Kbqb3cfk1XVVKnyXV3VW+0CeK2GomzmeYfsqReTWqhDsrH/HuPtqlqC3BWBE1oLJEOSb8Utf5ifo4JjK0VwvJt0sJRTpaO4WsHJs6sPMygw8wg4/m8fg8LsWkGKmz+WX0itkKCIxFBEZmGMzYG5E4oKpY0x+UdCXnwnJ1tJYNyULiO5uQe9xDsnVLX8gFAsGtIGwmfZEZwRT6GP+rtZpn2WRZbqXyZQ/W++QyrVIf5V0fdulTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 13:28:28 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:28:28 +0000
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
	gus@collabora.com,
	brauner@kernel.org
Subject: [PATCH v30 05/20] nvme-tcp: Add DDP offload control path
Date: Tue, 15 Jul 2025 13:27:34 +0000
Message-Id: <20250715132750.9619-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd74d61-9dce-4af4-6a58-08ddc3a37c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w3EcDWOfhdG9u3tx6IG9o7B1Qai0WUZf6lAGtTLfs9FVUy9UudW3nyHkHb34?=
 =?us-ascii?Q?WXzKQkNfeDeBw+wErkUfs0A4Y8k1OnaNHfg79T3ttSU2GXYEGTDMzqWO97sG?=
 =?us-ascii?Q?9Tz3l5LyzO95f45b+h/p3BgCPcy88CCILnTAHZJP0XyGZNSRfp142N1vyxUU?=
 =?us-ascii?Q?GduGNYweXYyMh48prMDzN6rAtbps2TOeBYqGNVv3VvM1RdCdAIfluusoSDTM?=
 =?us-ascii?Q?08BxOzoNu8WhbJ4R2X7nkYh5klYQCfz1Vf7pPlmJlry86jLWYZXX2+X2OSBf?=
 =?us-ascii?Q?jj8Fpwa0uvtrBJDUs5G78sHnA28mcl6k4gBEze9LHkKotDcGTpx7Wfq1Svfy?=
 =?us-ascii?Q?8eVhUSqNQJayf3Qnh/FifhkbPKdLyWilX4tPggjgvWQvs8oOenlC9BpslMVz?=
 =?us-ascii?Q?7roome53P3lhhhL/Avr3ZWxkGc82TP6HO75/g93SbJGR8et/57mme7LBmGtn?=
 =?us-ascii?Q?2TXvFXh6SQNCDI8gCrmdddCwBJffs6NLc22U0vszjgnwgJrtCzN3cxWcNjgU?=
 =?us-ascii?Q?WjF24drSQwumCf5VCViWCygVkUO70/uW1GX9x9WqreCYQzG2hZaEKauI7KaT?=
 =?us-ascii?Q?bJqaeR/2zuDKGuTaEDsH4hbQgILA/tVj4v235mx0fdTaEXArmLbO9+xl4k4J?=
 =?us-ascii?Q?KY9Flk9EDKX3NAuJJHTuv4zg6iI505g33P0CEy4Fe6arNMvc3HIlCP4jijJw?=
 =?us-ascii?Q?tmgmve4J7uNwbp00jYbOFJ/hcmJ/RNpkj7onQnDSIh/WyVWG/M2sZvnkHzrZ?=
 =?us-ascii?Q?aHSrQqvmhctmhHYiFEglgNPQe3afGNViObFOixl2wb54/6tUD5PMkMS4vJLJ?=
 =?us-ascii?Q?d53GVkPlys1K4RvVFUBJxdHXqE+Mph+NLcQrVqWILvIg2RriJYMRVLdYpcgl?=
 =?us-ascii?Q?zU2dXi5VyZIgfUPNf+JWqqCSdmX6cFet+Uc0fTVyRlXKbQOSDC2BAkqQW8tp?=
 =?us-ascii?Q?DW6nVPxJt89VA+gg5xrscT3E+aH3xJ7WDP5AK9l+eDHu8qH7txFRlkbWAcld?=
 =?us-ascii?Q?b0aXpzQb3Sr3GDpSpoLpTgS/jF2ijH7lseFiCGk/ata0jnI8Wep9ubuy3WSc?=
 =?us-ascii?Q?0NJlCv7yXfw/fOhjy4dGKfYNJtpcVtjY4viJAajns/Bne3vFxGZvlegkzpyZ?=
 =?us-ascii?Q?/GlRh+rTMEEwy86T7Q9lUlsGVpweovW3u8dOW2O5UMr0h3catfwiiLaJTjH7?=
 =?us-ascii?Q?ik+jjUuLdLFPMVxxGQDXMUUmEUnyteQ1clJNz4QxSYAXjXrw8OMmZu/YknML?=
 =?us-ascii?Q?yjfnXYHirfvd6NSk5HBsL/Z22WezxsdGFr9YVwCDAAnLDoOxH6xMJ0qxihoc?=
 =?us-ascii?Q?3ue8bmoMMv5wmIYlW3Y1uO7z9veXFyctYaC14X4QxCwJvBLLZL4NZNEyaFnl?=
 =?us-ascii?Q?NxkZcBfTI87gAE82KC7q+ixV7zQABLaBFdnHo5YslKEuxx+E6FRoXpJzBsKR?=
 =?us-ascii?Q?evpiILMPkdU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H9Bx/ZDNq8itDeWvBTWeJyABBQunYRexwKib4Nyf3O3Z5dotI3bagXAqpJn0?=
 =?us-ascii?Q?cu8a2IBCgbKXPNzl29PdnEuPAEWXhwMT6zH5WLiKFbTGap+MX2wmwAGF4Bxa?=
 =?us-ascii?Q?EeIw28TzV+cvoATb20oHnyPQAoxnmVRmSU4ZV8GO7hweLHmBzQGM27NfOTAK?=
 =?us-ascii?Q?1FMSQfGCho+3L63Gld4cyo/XhDRJ7Cb1EQFlJyzZl6FMdGTX6JMu0D8Avuc/?=
 =?us-ascii?Q?EUkd3JttrV+m7srPi6Q9PB0bEB2NliYXXotBdWo3Fb7ciJl7bvAyNqLM5Q9o?=
 =?us-ascii?Q?1Df0SysUxJ4G7d0LiDeGxUnLqDJBRImPxQcuQfXAWN5jDB01po1/ZV5Ct/7s?=
 =?us-ascii?Q?jTV8vfhv+yjka989vczzk0Lp0n2EpoJfHrqKw5bKDiV2kXR/pFsurahS74VQ?=
 =?us-ascii?Q?eIGHzsDt5zOT66wG99sJX+Jhp6vN57LZQrmRs0V95qYy6LCiAzXaxWEZSM0w?=
 =?us-ascii?Q?9kRyOaUBuphYoH7suJwr7DY16Yf7ziy7BZLbiXBrub9Grq2BPDi3wgMPyaQm?=
 =?us-ascii?Q?BI1YKAP8arzvSCOA4GUWE7Kv+H6ADJBI1ENQhrf8NrLRUqi3qXgtdxKoawUD?=
 =?us-ascii?Q?nR6WVjm9f3WrPhqQlRxQ/5H9i0MzJMtDFTwqQlmFRWMwj7V15i2yt7KWO+m8?=
 =?us-ascii?Q?7Gp9ME0yeWp81DUDGxYl83+VSN7/Vu3gE8UEleme0x9WFK0h5IDbc6hoFSkq?=
 =?us-ascii?Q?wRr5ntKRHyfQM+btQG7cK7/lqWFuaOg6lzzr7j1hbsXjpGWYEXV7Hbipn4uF?=
 =?us-ascii?Q?jVzeA5uKl/R4hHilwtuji+UUJYMykToj4cRzNx20Occ9uqA8kbeNPAXZiIbU?=
 =?us-ascii?Q?VXj6SK33MtCCUTopeE3LDW3pSNC1Fw6v6Zj63Crh9PXDX1UD1SOMdOLBBlS1?=
 =?us-ascii?Q?2yr/LhJTcfex4AR5yHa7eYh4yKvFGPG3/gaAplOmdtXbMQo2Z7pcTIwQLFFV?=
 =?us-ascii?Q?jCQvYPVpkpUi9ZGqWqXMot37lZr9lPu+hcn8ufkr7FM0ZT6c13OEFWWoOHo6?=
 =?us-ascii?Q?SyPgeJLlVOv2kcrKJPYbFDuD3Ab1e/a/6pOZU8yYil7I/GYIaC/QFW5d6OdY?=
 =?us-ascii?Q?B1L6hLPcQd3TnLMt62cdj4U8cv2nC2d4U+pBUZKf8eq0uqBu+wWL1T84Ck9f?=
 =?us-ascii?Q?jVwazrIHtvWmboVMFUpJQnt/UVHSBivBOALOw0e8kGcnjxn7IxPpSw0/3SrT?=
 =?us-ascii?Q?EjVHZ3gJLiFCosKWeyXhv5LxwhUwtuRPtVyntrC7tI4cH2DIpnstrkFeR9q0?=
 =?us-ascii?Q?MRc86RKIq3wpL0pnAmKi4P8aEy8VpyBdARiMEIuxYWPwmovAgdWEDzO5MNif?=
 =?us-ascii?Q?dV4UAcizb3n3ZiIQ9u1rTqvXiep7sDjQQY7S/+pcF7xY4TdPgETu2VZm9dEX?=
 =?us-ascii?Q?4lW7cUBcXVQ+HCr1iCbC33RExK4wxYlO8p8oXphDUd0p0KMwj+CiR9AkfiN2?=
 =?us-ascii?Q?PG4JHyTQT6gAXCf4jYg/FVedFDhQPbvLUu+nuBrKA8Jmuabu6+eEh3zEQAXw?=
 =?us-ascii?Q?kEgPJ5K7mrbFPZEJhLd9AUf1kg/MJQ0eXoOBagBtZk2k+UexpnO5RpziMN8O?=
 =?us-ascii?Q?fiQGEVlIer1gYa2iU4Guj5j3oiV9+uFdosRSMdJj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd74d61-9dce-4af4-6a58-08ddc3a37c28
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:28:28.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WiDC8nkJrm7yPdt0IOUyv2gfPPdRsfO/y/9HfRHeWqoRFP/KWnUBxRX2g3ea/LV39BRcN/F+zp9kwAgbvP1Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement offload to NVME
TCP. There is a context per queue, which is established after the
handshake using the sk_add/del NDOs.

Additionally, a resynchronization routine is used to assist
hardware recovery from TCP OOO, and continue the offload.
Resynchronization operates as follows:

1. TCP OOO causes the NIC HW to stop the offload

2. NIC HW identifies a PDU header at some TCP sequence number,
and asks NVMe-TCP to confirm it.
This request is delivered from the NIC driver to NVMe-TCP by first
finding the socket for the packet that triggered the request, and
then finding the nvme_tcp_queue that is used by this routine.
Finally, the request is recorded in the nvme_tcp_queue.

3. When NVMe-TCP observes the requested TCP sequence, it will compare
it with the PDU header TCP sequence, and report the result to the
NIC driver (resync), which will update the HW, and resume offload
when all is successful.

Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
for queue of size N) where the linux nvme driver uses part of the 16
bit CCID for generation counter. To address that, we use the existing
quirk in the nvme layer when the HW driver advertises if the device is
not supports the full 16 bit CCID range.

Furthermore, we let the offloading driver advertise what is the max hw
sectors/segments via ulp_ddp_limits.

A follow-up patch introduces the data-path changes required for this
offload.

Socket operations need a netdev reference. This reference is
dropped on NETDEV_GOING_DOWN events to allow the device to go down in
a follow-up patch.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 268 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 257 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d924008c3949..3ef48731ec84 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -20,6 +20,10 @@
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
+#ifdef CONFIG_ULP_DDP
+#include <net/ulp_ddp.h>
+#endif
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -55,6 +59,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 
 static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
 
+#ifdef CONFIG_ULP_DDP
+/* NVMeTCP direct data placement and data digest offload will not
+ * happen if this parameter false (default), regardless of what the
+ * underlying netdev capabilities are.
+ */
+static bool ddp_offload;
+module_param(ddp_offload, bool, 0644);
+MODULE_PARM_DESC(ddp_offload, "Enable or disable NVMeTCP direct data placement support");
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -129,6 +143,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_OFF_DDP	= 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -156,6 +171,18 @@ struct nvme_tcp_queue {
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
 
+#ifdef CONFIG_ULP_DDP
+	/*
+	 * resync_tcp_seq is a speculative PDU header tcp seq number (with
+	 * an additional flag in the lower 32 bits) that the HW send to
+	 * the SW, for the SW to verify.
+	 * - The 32 high bits store the seq number
+	 * - The 32 low bits are used as a flag to know if a request
+	 *   is pending (ULP_DDP_RESYNC_PENDING).
+	 */
+	atomic64_t		resync_tcp_seq;
+#endif
+
 	/* send state */
 	struct nvme_tcp_request *request;
 
@@ -197,6 +224,14 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct net_device	*ddp_netdev;
+	netdevice_tracker	netdev_tracker;
+	netdevice_tracker	netdev_ddp_tracker;
+	u32			ddp_threshold;
+#ifdef CONFIG_ULP_DDP
+	struct ulp_ddp_limits	ddp_limits;
+#endif
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -335,6 +370,178 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_ULP_DDP
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	struct net_device *netdev;
+	int ret;
+
+	if (!ddp_offload)
+		return NULL;
+
+	rtnl_lock();
+	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
+	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk, &ctrl->netdev_tracker, GFP_KERNEL);
+	rtnl_unlock();
+	if (!netdev) {
+		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
+		return NULL;
+	}
+
+	if (!ulp_ddp_is_cap_active(netdev, ULP_DDP_CAP_NVME_TCP))
+		goto err;
+
+	ret = ulp_ddp_get_limits(netdev, &ctrl->ddp_limits, ULP_DDP_NVME);
+	if (ret)
+		goto err;
+
+	if (nvme_tcp_tls_configured(&ctrl->ctrl) && !ctrl->ddp_limits.tls)
+		goto err;
+
+	return netdev;
+err:
+	netdev_put(netdev, &ctrl->netdev_tracker);
+	return NULL;
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
+	.resync_request		= nvme_tcp_resync_request,
+};
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	int ret;
+
+	config.affinity_hint = queue->io_cpu == WORK_CPU_UNBOUND ?
+		queue->sock->sk->sk_incoming_cpu : queue->io_cpu;
+	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
+	config.nvmeotcp.cpda = 0;
+	config.nvmeotcp.dgst =
+		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
+	config.nvmeotcp.dgst |=
+		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
+	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
+
+	ret = ulp_ddp_sk_add(queue->ctrl->ddp_netdev,
+			     &queue->ctrl->netdev_ddp_tracker,
+			     GFP_KERNEL,
+			     queue->sock->sk,
+			     &config,
+			     &nvme_tcp_ddp_ulp_ops);
+	if (ret)
+		return ret;
+
+	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{
+	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	ulp_ddp_sk_del(queue->ctrl->ddp_netdev,
+		       &queue->ctrl->netdev_ddp_tracker,
+		       queue->sock->sk);
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	ctrl->ctrl.max_segments = ctrl->ddp_limits.max_ddp_sgl_len;
+	ctrl->ctrl.max_hw_sectors =
+		ctrl->ddp_limits.max_ddp_sgl_len << (NVME_CTRL_PAGE_SHIFT - SECTOR_SHIFT);
+	ctrl->ddp_threshold = ctrl->ddp_limits.io_threshold;
+
+	/* offloading HW doesn't support full ccid range, apply the quirk */
+	ctrl->ctrl.quirks |=
+		ctrl->ddp_limits.nvmeotcp.full_ccid_range ? 0 : NVME_QUIRK_SKIP_CID_GEN;
+}
+
+/* In presence of packet drops or network packet reordering, the device may lose
+ * synchronization between the TCP stream and the L5P framing, and require a
+ * resync with the kernel's TCP stack.
+ *
+ * - NIC HW identifies a PDU header at some TCP sequence number,
+ *   and asks NVMe-TCP to confirm it.
+ * - When NVMe-TCP observes the requested TCP sequence, it will compare
+ *   it with the PDU header TCP sequence, and report the result to the
+ *   NIC driver
+ */
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{
+	u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_PENDING;
+	u64 resync_val;
+	u32 resync_seq;
+
+	resync_val = atomic64_read(&queue->resync_tcp_seq);
+	/* Lower 32 bit flags. Check validity of the request */
+	if ((resync_val & ULP_DDP_RESYNC_PENDING) == 0)
+		return;
+
+	/*
+	 * Obtain and check requested sequence number: is this PDU header
+	 * before the request?
+	 */
+	resync_seq = resync_val >> 32;
+	if (before(pdu_seq, resync_seq))
+		return;
+
+	/*
+	 * The atomic operation guarantees that we don't miss any NIC driver
+	 * resync requests submitted after the above checks.
+	 */
+	if (atomic64_cmpxchg(&queue->resync_tcp_seq, pdu_val,
+			     pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
+			     atomic64_read(&queue->resync_tcp_seq))
+		ulp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
+{
+	struct nvme_tcp_queue *queue = sk->sk_user_data;
+
+	/*
+	 * "seq" (TCP seq number) is what the HW assumes is the
+	 * beginning of a PDU.  The nvme-tcp layer needs to store the
+	 * number along with the "flags" (ULP_DDP_RESYNC_PENDING) to
+	 * indicate that a request is pending.
+	 */
+	atomic64_set(&queue->resync_tcp_seq, (((uint64_t)seq << 32) | flags));
+
+	return true;
+}
+
+#else
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	return NULL;
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{}
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{}
+
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{}
+
+#endif
+
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
@@ -835,6 +1042,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1918,6 +2128,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
@@ -1963,6 +2175,19 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	nvme_tcp_wait_queue(nctrl, qid);
 }
 
+static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+
+	nvme_tcp_stop_queue(nctrl, 0);
+
+	/*
+	 * We are called twice by nvme_tcp_teardown_admin_queue()
+	 * Set ddp_netdev to NULL to avoid putting it twice
+	 */
+	netdev_put(ctrl->ddp_netdev, &ctrl->netdev_tracker);
+	ctrl->ddp_netdev = NULL;
+}
 
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 {
@@ -1993,17 +2218,35 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	if (idx) {
 		nvme_tcp_set_queue_io_cpu(queue);
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	} else
+		if (ret)
+			goto err;
+
+		if (ctrl->ddp_netdev) {
+			ret = nvme_tcp_offload_socket(queue);
+			if (ret) {
+				dev_info(nctrl->device,
+					 "failed to setup offload on queue %d ret=%d\n",
+					 idx, ret);
+			}
+		}
+	} else {
 		ret = nvmf_connect_admin_queue(nctrl);
+		if (ret)
+			goto err;
+
+		ctrl->ddp_netdev = nvme_tcp_get_ddp_netdev_with_limits(ctrl);
+		if (ctrl->ddp_netdev)
+			nvme_tcp_ddp_apply_limits(ctrl);
 
-	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
-	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
-			__nvme_tcp_stop_queue(queue);
-		dev_err(nctrl->device,
-			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
+
+	set_bit(NVME_TCP_Q_LIVE, &queue->flags);
+	return 0;
+err:
+	if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		__nvme_tcp_stop_queue(queue);
+	dev_err(nctrl->device,
+		"failed to connect queue: %d ret=%d\n", idx, ret);
 	return ret;
 }
 
@@ -2261,7 +2504,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 out_cleanup_tagset:
 	if (new)
@@ -2276,7 +2519,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove) {
 		nvme_unquiesce_admin_queue(ctrl);
@@ -2621,7 +2864,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
-	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
+	if (nvme_tcp_admin_queue(req->queue))
+		nvme_tcp_stop_admin_queue(ctrl);
+	else
+		nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	nvmf_complete_timed_out_request(rq);
 }
 
-- 
2.34.1


