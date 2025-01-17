Return-Path: <netdev+bounces-159300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38777A1505C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520323A5D4A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF161FC0FE;
	Fri, 17 Jan 2025 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pFJA5ytP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB825A627
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119889; cv=fail; b=np1P3TlF7fWN1gF3KuAmggHQxPvzCCJXQu/zanHi4dfVf7E8bujgPGZracnvvXSj7cA7YFOYvdh1lBRQvTqVPhHOvj3ee3IQGshlNs4XQ2G/4m2CCATAeGQCYtH4FzXgeg14s5NTcxBLy6i6PKmru5cfMsMTfh9EQT8+MJWlfdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119889; c=relaxed/simple;
	bh=yOS0ssJNE1vKeZdlxFjAvLVW9OFzNIgXvPGPO6GA10s=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OIvfY1RSopBbu7CFN5qY4DZnsd5DHrJz48zvHDGWNbN6HD7d0D9TBTJs+SiaFfaFoZlZ64lXrMv772owl1FJvhvtZPIa3UslvkJl/rwD2I6qUcAJiLRUEVk1NDCE2i/wlvg12gQSefKszt/3XrpTKhZsjPagRkXckbqFzfiP5tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pFJA5ytP; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrl99yFbbR9lcRDN8x6c1D9QN4ZkjpKQu/Mc88FaVBhbC+V1876T47ujGfbHJcrXxh7G5SuOPRviT4ENstFagxMYfoVsolmuUsg4+SjTRQBUuufD2beSHu2vxX4/nT312TE+KaYF1Sc75HH9m9uzho3NA7Ujz8KKTRsQtNk66BmMrdPGc5KpmoyoqBTscUFxHk0dDBm19rGrLOr0y9DLEgJCSizCCUfiw66OTi2eTT8wp6a5r3STryL2ZWzT830M01fEtcpAgcE3yJeS0nlhlU1k3D9lP0J2qCOPnvLWndXru+Ue8egC5FZwr7s/qIt7t3BMH36dPsG/WVqx7pxX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fvh9ys92DEMqXko1AcvoPJcttRmo/SliKqQbifK49I=;
 b=ogLKNwsK0ZlbW+rRwq1b8nKhjsy14qsfq64p9ytJpoCXGqez+zMRwOo5kDaUy2s/JDdjJvjATcfu+Nb85mwohcSDJhfZqdtW/oiZAleAiULjHyQuvKl/SpRQ5b7gt48IdB6i//J/mSkkIAI+dV4okL2XoCPx+3hXDDzoQOFko3BZbHW0CFJY2j6+4kCmAQHDk79yWHtBJx7c1DZdt5EkEqZu1TKyt7168VI7pYr4Emf+McvJyyHGquajBqssM916iBpXfzTVzMkwF2Gt9H7u+jDmuVS2X+AII1uyTsY53QyJHY/v5M5Pi+n+VXtOzrT6nc9nmdxPbrgVPCHS4l/t+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fvh9ys92DEMqXko1AcvoPJcttRmo/SliKqQbifK49I=;
 b=pFJA5ytPxJKUeCw//edNy2z9SbnGBYtLlx3oUSPzKDPubIr8UxuFJltukdREBVc2GXJjojzp9GBl0pF1LvbKWVZCuuFEVOJb8CzKDbj2V9OLF1AfktjPB9IgSR5Q+OSkTqYxBRr+18tdCoI8h8VIU7D5z6NmlErcPq0CLTbuZbZkBtGymx9HuXBrnNe/ZXLVhV9u+io8srWKWWUR6GYHbVgEh345FqSFABGj3PBQxSZdP3TYaYThaFoPEC0qGcDj0qqUtZUA1gx71MKCf75yUWrw2d76LB2sTFrkXOl5jnaxdpnnsEEu2OvHrx7FM//snCTNOCXdEUodvPIcoUBiwg==
Received: from SJ0PR13CA0239.namprd13.prod.outlook.com (2603:10b6:a03:2c1::34)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 13:18:02 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::a9) by SJ0PR13CA0239.outlook.office365.com
 (2603:10b6:a03:2c1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Fri,
 17 Jan 2025 13:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 13:18:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 05:17:48 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 05:17:44 -0800
References: <cover.1737044384.git.petrm@nvidia.com>
 <e1c72812-ec53-4547-900e-9c9004098a4a@intel.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Petr Machata <petrm@nvidia.com>, Richard Cochran
	<richardcochran@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 0/5] mlxsw: Move Tx header handling to PCI driver
Date: Fri, 17 Jan 2025 14:12:27 +0100
In-Reply-To: <e1c72812-ec53-4547-900e-9c9004098a4a@intel.com>
Message-ID: <87a5bp4m16.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 06cb183b-73ca-4e8b-3424-08dd36f95ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gXNeNP3t+Os4mrz2Sppwd83ajPORpTZ72X9O56eaI7Qi7QLdvcCYaV1FYVgu?=
 =?us-ascii?Q?y4vb5cy3RvuCPShrf5+Ks/jBCIVKgMJk941zhgbKE81fAwfObKcLIO5VQ46E?=
 =?us-ascii?Q?WhuzZ7uTA84F+F3qJNfFC4H96jkoM2k1EIe3NP9EMXcsl0c4qzNlvCO/Yukg?=
 =?us-ascii?Q?aeHPSockbi6Bf/lDyrdKlgszdEc2wygN6QGhg644rIer+cDJa7p6VYKiDa9j?=
 =?us-ascii?Q?6WvPVr3mgI4cqWiH9GqhWRMjCwatO5W9ey0vd7VXn2nJTiTY2Efb0uf13nPv?=
 =?us-ascii?Q?3VzaGk89vTN13N1T5/tQCDQLNyomtpAuSV72lF4rtbwFDBflraIcIopX/dV8?=
 =?us-ascii?Q?M1rwzSXtwBn3+bbTNNtcglZ8LBNepboatKk9niQYxWOfXgZFIYYH9aPXBHiv?=
 =?us-ascii?Q?rwOfJdrBnNN0WVNyxpyS/luUeS5h1NpsQ8PNspIR/NsrSHgBEN+AAFBw6HHX?=
 =?us-ascii?Q?lG8mKdMpqBHtXUgRTqTAgi/5d11PRWRn7/dPFf3Uk+ZsIPtw/YptPq6ti2O2?=
 =?us-ascii?Q?xxRVH4s2b99LUkhRgdQzl1Rrll22uZcAXkUsWl+SNfCidkpPSz7aZ2GKVhsJ?=
 =?us-ascii?Q?NbzwLGe2PYURAr4RRqClW20uqBCy69Pcr9aV7gUv0R96X+IVl0zuPSxgp2gX?=
 =?us-ascii?Q?wsZ1X4F3s8FL2pMFWBD6zJ23Ah1mC/tiD0jSbCFL9AQ5kn2vuJ0j/J4ssTfT?=
 =?us-ascii?Q?taTYnJnxqzfgowPF0nmBAOEdEhSDI0zrkkahW95asEsR3dHR68If98nwu0bm?=
 =?us-ascii?Q?q3FqbRD7xKArc+kQvIUplq+rzk5q2dORzDF3yTTNqpLlfklVUXobvlTbeGBt?=
 =?us-ascii?Q?I2Xun58Fy45A3SdYOoFoMWjy/M6nCZZ0yZpeQeY9vApF1YLAa/mNf1hMikL+?=
 =?us-ascii?Q?iIUbndhHsH82CL2dSNt2UxRD9D2svW9k/zRtiW5KKbh8T/TWH/ahso9HK426?=
 =?us-ascii?Q?+gbkOXiiB04dEME33VxaoX8+1jLFV5fe5FsulP0L6iuOqBmnKVvipvyeNuei?=
 =?us-ascii?Q?rv2V2tLhh/aBU1RwwRut/YHyolvoIlkgFjTsma3XneSPBsllJxtxdgbJfqcb?=
 =?us-ascii?Q?3cxV9v0hUWQnGDNnxXRhG5ucyW82mnflm1F7HeSCDhwEdItYT1D67NBdUGMf?=
 =?us-ascii?Q?39x69xhnGJVknmQ+MvoDMIkYVCs3hJTxSZLgejkfy73jbng2nLfMHxbYai4D?=
 =?us-ascii?Q?gKS0Gn5b2b2LSngp8wQsMW9WcBI6QLIghw2wCOvim/o93MrZAVEPID0rC7o2?=
 =?us-ascii?Q?x+Z4Ix2gTBdtCWj1sVc2gT9Ec27mzY//FvjhnJtOB+QrEb+hl6yjt5hp8yqo?=
 =?us-ascii?Q?DDoJry1WE68/kv++KpTHfYoW2+G61mIUH5IoY7QbvxMaYH/zdLtjjnP1bXAP?=
 =?us-ascii?Q?JwAgquLoKKqnKB2uFwEjRP+0XwskZtDwTlepG0rZUoT7HbCrx+d5wYz7lf+L?=
 =?us-ascii?Q?nbU0tOJ1KHtRfY88F5lfbq4o9EKGANVSIHfNPUkjG+bCZ21N9RjQgV7Ud9mF?=
 =?us-ascii?Q?V72TM0qhuLGz6fI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 13:18:01.8248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cb183b-73ca-4e8b-3424-08dd36f95ea6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936


Przemek Kitszel <przemyslaw.kitszel@intel.com> writes:

> On 1/16/25 17:38, Petr Machata wrote:
>> Amit Cohen writes:
>> Tx header should be added to all packets transmitted from the CPU to
>> Spectrum ASICs. Historically, handling this header was added as a driver
>> function, as Tx header is different between Spectrum and Switch-X.
>>  From May 2021, there is no support for SwitchX-2 ASIC, and all the relevant
>> code was removed.
>> For now, there is no justification to handle Tx header as part of
>> spectrum.c, we can handle this as part of PCI, in skb_transmit().
>> This change will also be useful when XDP support will be added to mlxsw,
>> as for XDP_TX and XDP_REDIRECT actions, Tx header should be added before
>> transmitting the packet.
>> Patch set overview:
>> Patches #1-#2 add structure to store Tx header info and initialize it
>> Patch #3 moves definitions of Tx header fields to txheader.h
>> Patch #4 moves Tx header handling to PCI driver
>> Patch #5 removes unnecessary attribute
>> Amit Cohen (5):
>>    mlxsw: Add mlxsw_txhdr_info structure
>>    mlxsw: Initialize txhdr_info according to PTP operations
>>    mlxsw: Define Tx header fields in txheader.h
>>    mlxsw: Move Tx header handling to PCI driver
>>    mlxsw: Do not store Tx header length as driver parameter
>>   drivers/net/ethernet/mellanox/mlxsw/core.c    |  21 +-
>>   drivers/net/ethernet/mellanox/mlxsw/core.h    |  13 +-
>>   drivers/net/ethernet/mellanox/mlxsw/i2c.c     |   2 +-
>>   drivers/net/ethernet/mellanox/mlxsw/pci.c     |  44 +++-
>>   .../net/ethernet/mellanox/mlxsw/spectrum.c    | 209 ++++--------------
>>   .../net/ethernet/mellanox/mlxsw/spectrum.h    |  11 +-
>>   .../ethernet/mellanox/mlxsw/spectrum_ptp.c    |  44 +---
>>   .../ethernet/mellanox/mlxsw/spectrum_ptp.h    |  28 ---
>>   .../net/ethernet/mellanox/mlxsw/txheader.h    |  63 ++++++
>>   9 files changed, 176 insertions(+), 259 deletions(-)
>> 
>
> Thank you for cleaning this, nice series!
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

BTW, it's not just cleanup. When the cover letter says that it "will
also be useful when XDP support will be added" -- we have four more
patchsets in the pipeline that add that. It's not going to land pre
net-next closure, but the next cycle for sure!

Thanks for the review!

