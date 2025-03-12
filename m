Return-Path: <netdev+bounces-174219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A389A5DDD1
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B76188B7B0
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BFE241C80;
	Wed, 12 Mar 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tZ4SfOjN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2564C23F38F;
	Wed, 12 Mar 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785636; cv=fail; b=fQ6sIxW+Htb9H2EM/RKDyCL4N2d/Z9ZasxegoXS8pv34ifB6mPU34RBuVEA9rl28rvGp7x4R6uW+irZcs0zxZRhQyRVdh9KAXtKNYqRwna/e+G1ho94Umlv5Wt/bZeaL70yQlPnBDAWOG7dAHQsCkLX+p+Ltx8LwwzlAIt71Kjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785636; c=relaxed/simple;
	bh=DpLe6Ud3xevf3RUZ3PdXQS1fLxi9P4GKPHqOUzTUdiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=acWmd3ZVzHHfky/4EHWNQtLW+7eyzjUx8itP0IoWFd5vDs58mV3b2rfotttv6sdFIqugNZhfqqm/K3I/dvGbNN/5kvTT36sRuTuhxVQB1i92TYBG7one8gr9DG2nlePwuMY2C4PYkQQMd0FJR7jl9IPqG97zJ5ol+wLRRZ2qaNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tZ4SfOjN; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYV5FxWnbipgErdCtdn+5bkkMlccO2ae7OEqw9cFLW4XOmcg/VBbKHqKbFg4A8FU2grBY6PnI/nSgY7YVzNmph+s+eHqg9AgPjgkVdaG84gU0kh0VcmacvMg/DeZFUzlForOoR0WlF4F9dQ78thHDJC13tkAkLF5NxQ5956UchYiNC1kWJOlPzLLaFZ/ar4S65CF6T9Hha1FwgGrV0dfxkJuJ55lHvj79Jp6LHEDhKF9FqTBpyQZPteJM8Ty9h0QRJKUXqvOGDbuhg4VIZz7tKkWn2KYNTcpZOHHKUwdw0xK5j0/YAsp2Nxc+JDlhJiBti1MphSLqTckxDZA9vuB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6Bkj6JK7YRnG3TUKweBX4iXRUS8pVsLEYyAqz+t1lo=;
 b=K5t6LEcUzUGf3p6FO8VSHOKaCXHYij6aSTYIA1N85SESzb42+rEsPpVsXQOQSB5kmi8JHqPQzWOobV8Hr//Ivgphao3spPc+uoe8BIZBeNe3uxKSsudLn8Sod0HVV6BZnO93+e3HAN+V3Sm4bxcV01ycN38Oyc7ZhiDu2lYu7yjYZFASZN8tFp/Kel4JPaT5ldxu0/yvMhdeZXsPmQ8ovMi6dx/gi+bOUL2nJU5BymhUvA/2g5LqBx3jZYZf4L5nSwqISn2wzr6nRaIIiP3cRSsqxnxAyH+Se1/tivrJXaHd1Vhiik4guZDyCN0llw35k+eNfpq+a1gJ18qdfTNAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6Bkj6JK7YRnG3TUKweBX4iXRUS8pVsLEYyAqz+t1lo=;
 b=tZ4SfOjNn+aax4KPT7dDdaNCz842TKiUi8IcnavP35ed1akkOtx2MF+GyMEX0SLmJ4xULzOReAVNLLaISjg2gwDO+52gix3HREVZmLBcZZ8mnS/idyWfFL859QYR9EPx2ehC7LEJBNRCc+eSBox08CZDEfO6g2HLAZQ0wps4zABPuO99aQVP6q9kJnls4iUDDwsblZQYKSBqzaD7PVyjpRz+e/fJehxA2KTzWRi0twSyPeaGRIFb0ei4c9ri8DFtDVYmae13qCcMIJ79rZrx+1tNKuL1YAc+x3TPP1ASJEeKUEprFpZtDik6cwNi7GipWggKsyCus31Jn6oJiFKukA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 13:20:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 13:20:29 +0000
Date: Wed, 12 Mar 2025 15:20:19 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: andrew+netdev@lunn.ch, chenlinxuan@uniontech.com, czj2441@163.com,
	davem@davemloft.net, edumazet@google.com, guanwentao@uniontech.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, niecheng1@uniontech.com, pabeni@redhat.com,
	petrm@nvidia.com, zhanjun@uniontech.com
Subject: Re: [PATCH net 1/2] mlxsw: spectrum_acl_bloom_filter: Expand
 chunk_key_offsets[chunk_index]
Message-ID: <Z9GKE-mP3qbmK9cL@shredder>
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
 <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
X-ClientProxiedBy: FR4P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c79cb6b-bdb5-4211-3db1-08dd6168a8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tCzzZ6dPvD9dFHliH5kh5JAqSmSJbf7QhNr6FkOEM3au1bCA98nVUKTNS6CO?=
 =?us-ascii?Q?uXCyr8q1TDzax7khzNATJUjccTi04pFl1g7KmglwWG+CePV6qa08s8pqgb1E?=
 =?us-ascii?Q?Li+SAe0rLs+As5yOhtWoJ4435g2smUMzTZtwKs5JakDZmJUktYAVoc7JSArN?=
 =?us-ascii?Q?CYQDfU5/QobDSHVWdL/KNNC8CalQinxzyXXPZxarZSLDnpHIm7fyPL3vJJvT?=
 =?us-ascii?Q?cLSw0iDkmbeNNlr17dCaEtGFIz9Mp2zRsn3EYbIq+aplBypLN9mIfHoI+k75?=
 =?us-ascii?Q?7e1D7lYtix2rtM7i83PCKmbbWJKb2V7BP1W8kffIFMfeBmCdbzsF+tcnemQ6?=
 =?us-ascii?Q?SBMywNVd1kko/X5vtLnZ6QEr4uNJ8HSZBK1bBle7gFojZLgJMN44u2GAoJBL?=
 =?us-ascii?Q?ZEdOwMOXk8tPVnkVwOE0K2d4I1W62sJUjfRO0uDqSghiKSBPCbriaao+p+yA?=
 =?us-ascii?Q?SsHMVNCYTfkzMp0AQ7cvKNbU2y/zoZoqFDm2+ujp3ZJgg4Zo7pZ9dzTHC7+W?=
 =?us-ascii?Q?IyNp2GgzB7kBHk9chF10h1iTVjLUiW/q/0NS1BfWxNjc8VEdQBsjkJeM0Pmp?=
 =?us-ascii?Q?bPI9I4v6o74q8XSFQSl8IQCJBue339oCSfxVcdfN3Rb7CqWmrkNUb0cNAiGC?=
 =?us-ascii?Q?sDf7GCOaXS1JJkkQLgoPRrGsmgNOOw7T40oR/X0Lp6HefBOeETDX3dS1LrTk?=
 =?us-ascii?Q?XXrLQoZePEASIkMGQO+k2H0sFhWnaVCZixjKpukslqOGI3lBzQHTfAcJzKW1?=
 =?us-ascii?Q?ndFQMBpM1JJd7vcEtHIxdMidWuvf7OMvuLwceH9qMVQsHEhbn/O5x4oFl4Yo?=
 =?us-ascii?Q?NQFxG/30VOyHjD+W+bJdclwmbscSpeaBGcPBynrmZNQR4W0+fRQnmDoq+/OV?=
 =?us-ascii?Q?YGLhBG45nwiY6DOOlOhEd/qUL2uRWgTKUdkyjbz/rjBamjI7u+KOZvA/Mvk0?=
 =?us-ascii?Q?sNcP7+/mKaETvUoWZl9HH0yg89CuNXNsXYgTlGMBXndJv6USApt5PtJdoEhk?=
 =?us-ascii?Q?KtDoFaGVHoDmlfScVdzfipeYGsjCOcb/Zly2SQbiSo0JqRbWS1BBSO5NhsGH?=
 =?us-ascii?Q?Ga5Io5uls/UB5hD0Mm0fnWZMoZoYf1kgvoD09d3UPrsrt5rUVOL85mKH8Wh+?=
 =?us-ascii?Q?BdGg0v9eUqvShAeiLE+cT/+kKph6L11HMAZRuP4FtUgwmOM66RfXMkztFvrJ?=
 =?us-ascii?Q?gRi4mjXKIw0BgwaHyvquKnkh+dcXOZE0l4nHR1fySz4DIprVbdDEtcl3RQ92?=
 =?us-ascii?Q?4l5p44zU0WnYAVJv7tRYv8YOw2rCry46lx+jk3fKrQSSkB27h8RleS3FNMpr?=
 =?us-ascii?Q?2wys63Yk3ofeBa+fIIJWEmjp70C1DZw76ebuiIcT8BVY4zOzWEzwcmdcklnV?=
 =?us-ascii?Q?lLcIj0V6dF1hLSXzmum8Tj6QM1Ml?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TIAJCjcw1/GPeMmzoYTqwPJRiq4zMVEg0JSX5PZ9LpMTtcy/H49X5YkJGDMA?=
 =?us-ascii?Q?iIBwt4oPvYAI73NGIvjdi7lcfLTnmuHJEiEY2kIVrfM8a+g2S68P1ztgw/dI?=
 =?us-ascii?Q?D4Q1FrP7yV4Kq45MuDCYgSTw/IDKm9YfMtFt0TRhIRi6Lf+6suJLEifEt6RZ?=
 =?us-ascii?Q?0kBrJyf8bbI4D7r5XcTjhMLdfWLG6v5yTqr4RxyMBaUCag25GfDPCWA56Aox?=
 =?us-ascii?Q?pjNtKRk/pqzsighTzmZBymPUrC7lh1vH3atYDBAXHqre8MdiIVKW7OPB2JKP?=
 =?us-ascii?Q?XjlHlDUKpDgR37US/3z+XikwZ++h4QbGLHQudDaSS7dnZpoDjew08D6UHZIX?=
 =?us-ascii?Q?/EvcUFmat5inrW5Yzxs6C/XXwFYuU+tpoJrfsCegY7R50b+RAvoigB/ZiUHz?=
 =?us-ascii?Q?un+ZTzAZc60bb99cGgUwgKwkaJzMi19sJfMLnimFKZoGQdGEMQ3cPCLVhStt?=
 =?us-ascii?Q?4YXV5JEcfUAvx4C5Kd0sxQVTsNqtYkvA9A8+hu1Ah7dnJQ5+RTl0BP+irzrn?=
 =?us-ascii?Q?U8JJXFf4AOhQIQ0oWUzhOiSzGmE+lxmPyVDbM/0UTDOF/O1rBobu6smSJq/w?=
 =?us-ascii?Q?QoYdiAC5yptKcKNw7UxlNxaVNC6DHElWpEWmUBCI8hZN9uhVJPMt4Tpi2sf9?=
 =?us-ascii?Q?aez+EKrqFPTRZc4qh3czdBHG0S0NXrsR31zGRQ/+D/evnyrHo6CHLKaTIh2I?=
 =?us-ascii?Q?ZXz+jcjuzJjiueisDRcfw5INFUwMFHqSGkj4vkIG7cpBZK3LmwiA2FjNnLEf?=
 =?us-ascii?Q?o8fVNyYJ2P9qzHqBXdrRkih1pDWvIlwbIYvth1YfYA21lDrC71yJYhQq5GU7?=
 =?us-ascii?Q?+GsEk8AlaQ8PHV0RtUu3CBuvZN5ScXjZ4gQadisdhO2necogWT3f8EJihVDz?=
 =?us-ascii?Q?el0dxTgrbt83tBJSnX4ddFVImVtHT/X1E850rGQWy2I101h37GUPJLsVXeLW?=
 =?us-ascii?Q?GGlJlVNeNsBHabU2MLavhf/9Y/hVwbwGm0agqHWjjrHu85URj2lISeEbXpzf?=
 =?us-ascii?Q?l07l95Vl1ZbG9oQ6sj+plhsYSHzEYLw/ltu/tDCLP3V/KpEXJqhmES9OjM4r?=
 =?us-ascii?Q?7VtwyaqKbU4jinjV5E/KbQcJRHQ/gZ20zN8Rui0SL4FG8KyzXzhwSDTf1y06?=
 =?us-ascii?Q?ZDVyf0BQrCmAVTEw14XWKHeQOThy+Fw72/EHegwudtze7T0sqzyBlF1lceWL?=
 =?us-ascii?Q?Kw6azNdEGkypIkqDq0iDppV7qmvLbteU9+zjzba/k0WaKTa4hpgCZ2AFfRjX?=
 =?us-ascii?Q?E/x9NxAlvpSlvFM2NjWWZkl623UoIMxrlY69ghpBV2r8/ZtEimtcnVFoHwr1?=
 =?us-ascii?Q?T6XSOlsTIHV+IjY1d1rj8bBWre7eGZQygc9LWFJW7QgRdVRNQ6nc9gK4A2mg?=
 =?us-ascii?Q?WwZQdGZofdwns8aPbCGxDJGErSUsItHEYpv4qozEPmNLks50wP+zQqqPQoDD?=
 =?us-ascii?Q?INcksrMn4DBPvpqnIXUUfxwU3o3kwI3OFhaBDBomVn6LEDkbdoM8dPCrw7Js?=
 =?us-ascii?Q?GUQBLMnyYozmkwyK87qi+BYLCJWIz1VlzqW0CGG2A1PO6Srckfw9BwuqCqgx?=
 =?us-ascii?Q?4PHQ4ZxX1Ooj9Q8u0Lyz7OFtRlKJkql9qTcCgfrb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c79cb6b-bdb5-4211-3db1-08dd6168a8e8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 13:20:29.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuhHG1NIZpKtK83PQYyzZ19z7S10+rvzmlXQcucNTEo4b1iq4uMCBBBENij/UEekNLGlaVTygeEaxTxdhfu4hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

On Tue, Mar 11, 2025 at 10:17:00PM +0800, WangYuli wrote:
> This is a workaround to mitigate a compiler anomaly.
> 
> During LLVM toolchain compilation of this driver on s390x architecture, an
> unreasonable __write_overflow_field warning occurs.
> 
> Contextually, chunk_index is restricted to 0, 1 or 2. By expanding these
> possibilities, the compile warning is suppressed.

I'm not sure why the fix suppresses the warning when the warning is
about the destination buffer and the fix is about the source. Can you
check if the below helps? It removes the parameterization from
__mlxsw_sp_acl_bf_key_encode() and instead splits it to two variants.

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index a54eedb69a3f..3e1e4be72da2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -110,7 +110,6 @@ static const u16 mlxsw_sp2_acl_bf_crc16_tab[256] = {
  * +-----------+----------+-----------------------------------+
  */
 
-#define MLXSW_SP4_BLOOM_CHUNK_PAD_BYTES 0
 #define MLXSW_SP4_BLOOM_CHUNK_KEY_BYTES 18
 #define MLXSW_SP4_BLOOM_KEY_CHUNK_BYTES 20
 
@@ -229,10 +228,9 @@ static u16 mlxsw_sp2_acl_bf_crc(const u8 *buffer, size_t len)
 }
 
 static void
-__mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
-			     struct mlxsw_sp_acl_atcam_entry *aentry,
-			     char *output, u8 *len, u8 max_chunks, u8 pad_bytes,
-			     u8 key_offset, u8 chunk_key_len, u8 chunk_len)
+mlxsw_sp2_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
+			    struct mlxsw_sp_acl_atcam_entry *aentry,
+			    char *output, u8 *len)
 {
 	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
 	u8 chunk_index, chunk_count, block_count;
@@ -243,30 +241,17 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 	chunk_count = 1 + ((block_count - 1) >> 2);
 	erp_region_id = cpu_to_be16(aentry->ht_key.erp_id |
 				   (aregion->region->id << 4));
-	for (chunk_index = max_chunks - chunk_count; chunk_index < max_chunks;
-	     chunk_index++) {
-		memset(chunk, 0, pad_bytes);
-		memcpy(chunk + pad_bytes, &erp_region_id,
+	for (chunk_index = MLXSW_BLOOM_KEY_CHUNKS - chunk_count;
+	     chunk_index < MLXSW_BLOOM_KEY_CHUNKS; chunk_index++) {
+		memset(chunk, 0, MLXSW_SP2_BLOOM_CHUNK_PAD_BYTES);
+		memcpy(chunk + MLXSW_SP2_BLOOM_CHUNK_PAD_BYTES, &erp_region_id,
 		       sizeof(erp_region_id));
-		memcpy(chunk + key_offset,
+		memcpy(chunk + MLXSW_SP2_BLOOM_CHUNK_KEY_OFFSET,
 		       &aentry->ht_key.enc_key[chunk_key_offsets[chunk_index]],
-		       chunk_key_len);
-		chunk += chunk_len;
+		       MLXSW_SP2_BLOOM_CHUNK_KEY_BYTES);
+		chunk += MLXSW_SP2_BLOOM_KEY_CHUNK_BYTES;
 	}
-	*len = chunk_count * chunk_len;
-}
-
-static void
-mlxsw_sp2_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
-			    struct mlxsw_sp_acl_atcam_entry *aentry,
-			    char *output, u8 *len)
-{
-	__mlxsw_sp_acl_bf_key_encode(aregion, aentry, output, len,
-				     MLXSW_BLOOM_KEY_CHUNKS,
-				     MLXSW_SP2_BLOOM_CHUNK_PAD_BYTES,
-				     MLXSW_SP2_BLOOM_CHUNK_KEY_OFFSET,
-				     MLXSW_SP2_BLOOM_CHUNK_KEY_BYTES,
-				     MLXSW_SP2_BLOOM_KEY_CHUNK_BYTES);
+	*len = chunk_count * MLXSW_SP2_BLOOM_KEY_CHUNK_BYTES;
 }
 
 static unsigned int
@@ -375,15 +360,24 @@ mlxsw_sp4_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 			    char *output, u8 *len)
 {
 	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
-	u8 block_count = mlxsw_afk_key_info_blocks_count_get(key_info);
-	u8 chunk_count = 1 + ((block_count - 1) >> 2);
-
-	__mlxsw_sp_acl_bf_key_encode(aregion, aentry, output, len,
-				     MLXSW_BLOOM_KEY_CHUNKS,
-				     MLXSW_SP4_BLOOM_CHUNK_PAD_BYTES,
-				     MLXSW_SP4_BLOOM_CHUNK_KEY_OFFSET,
-				     MLXSW_SP4_BLOOM_CHUNK_KEY_BYTES,
-				     MLXSW_SP4_BLOOM_KEY_CHUNK_BYTES);
+	u8 chunk_index, chunk_count, block_count;
+	char *chunk = output;
+	__be16 erp_region_id;
+
+	block_count = mlxsw_afk_key_info_blocks_count_get(key_info);
+	chunk_count = 1 + ((block_count - 1) >> 2);
+	erp_region_id = cpu_to_be16(aentry->ht_key.erp_id |
+				   (aregion->region->id << 4));
+	for (chunk_index = MLXSW_BLOOM_KEY_CHUNKS - chunk_count;
+	     chunk_index < MLXSW_BLOOM_KEY_CHUNKS; chunk_index++) {
+		memcpy(chunk, &erp_region_id, sizeof(erp_region_id));
+		memcpy(chunk + MLXSW_SP4_BLOOM_CHUNK_KEY_OFFSET,
+		       &aentry->ht_key.enc_key[chunk_key_offsets[chunk_index]],
+		       MLXSW_SP4_BLOOM_CHUNK_KEY_BYTES);
+		chunk += MLXSW_SP4_BLOOM_KEY_CHUNK_BYTES;
+	}
+	*len = chunk_count * MLXSW_SP4_BLOOM_KEY_CHUNK_BYTES;
+
 	mlxsw_sp4_bf_key_shift_chunks(chunk_count, output);
 }

> 
> Fix follow error with clang-19 when -Werror:
>   In file included from drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c:5:
>   In file included from ./include/linux/gfp.h:7:
>   In file included from ./include/linux/mmzone.h:8:
>   In file included from ./include/linux/spinlock.h:63:
>   In file included from ./include/linux/lockdep.h:14:
>   In file included from ./include/linux/smp.h:13:
>   In file included from ./include/linux/cpumask.h:12:
>   In file included from ./include/linux/bitmap.h:13:
>   In file included from ./include/linux/string.h:392:
>   ./include/linux/fortify-string.h:571:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>     571 |                         __write_overflow_field(p_size_field, size);
>         |                         ^
>   1 error generated.
> 
> Co-developed-by: Zijian Chen <czj2441@163.com>
> Signed-off-by: Zijian Chen <czj2441@163.com>
> Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  .../mlxsw/spectrum_acl_bloom_filter.c         | 39 ++++++++++++-------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> index a54eedb69a3f..96105bab680b 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> @@ -203,17 +203,6 @@ static const u8 mlxsw_sp4_acl_bf_crc6_tab[256] = {
>  0x2f, 0x02, 0x18, 0x35, 0x2c, 0x01, 0x1b, 0x36,
>  };
>  
> -/* Each chunk contains 4 key blocks. Chunk 2 uses key blocks 11-8,
> - * and we need to populate it with 4 key blocks copied from the entry encoded
> - * key. The original keys layout is same for Spectrum-{2,3,4}.
> - * Since the encoded key contains a 2 bytes padding, key block 11 starts at
> - * offset 2. block 7 that is used in chunk 1 starts at offset 20 as 4 key blocks
> - * take 18 bytes. See 'MLXSW_SP2_AFK_BLOCK_LAYOUT' for more details.
> - * This array defines key offsets for easy access when copying key blocks from
> - * entry key to Bloom filter chunk.
> - */
> -static const u8 chunk_key_offsets[MLXSW_BLOOM_KEY_CHUNKS] = {2, 20, 38};
> -
>  static u16 mlxsw_sp2_acl_bf_crc16_byte(u16 crc, u8 c)
>  {
>  	return (crc << 8) ^ mlxsw_sp2_acl_bf_crc16_tab[(crc >> 8) ^ c];
> @@ -237,6 +226,7 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
>  	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
>  	u8 chunk_index, chunk_count, block_count;
>  	char *chunk = output;
> +	char *enc_key_src_ptr;
>  	__be16 erp_region_id;
>  
>  	block_count = mlxsw_afk_key_info_blocks_count_get(key_info);
> @@ -248,9 +238,30 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
>  		memset(chunk, 0, pad_bytes);
>  		memcpy(chunk + pad_bytes, &erp_region_id,
>  		       sizeof(erp_region_id));
> -		memcpy(chunk + key_offset,
> -		       &aentry->ht_key.enc_key[chunk_key_offsets[chunk_index]],
> -		       chunk_key_len);
> +/* Each chunk contains 4 key blocks. Chunk 2 uses key blocks 11-8,
> + * and we need to populate it with 4 key blocks copied from the entry encoded
> + * key. The original keys layout is same for Spectrum-{2,3,4}.
> + * Since the encoded key contains a 2 bytes padding, key block 11 starts at
> + * offset 2. block 7 that is used in chunk 1 starts at offset 20 as 4 key blocks
> + * take 18 bytes. See 'MLXSW_SP2_AFK_BLOCK_LAYOUT' for more details.
> + * This array defines key offsets for easy access when copying key blocks from
> + * entry key to Bloom filter chunk.
> + *
> + * Define the acceptable values for chunk_index to prevent LLVM from failing
> + * compilation in certain circumstances.
> + */
> +		switch (chunk_index) {
> +		case 0:
> +			enc_key_src_ptr = &aentry->ht_key.enc_key[2];
> +			break;
> +		case 1:
> +			enc_key_src_ptr = &aentry->ht_key.enc_key[20];
> +			break;
> +		case 2:
> +			enc_key_src_ptr = &aentry->ht_key.enc_key[38];
> +			break;
> +		}
> +		memcpy(chunk + key_offset, enc_key_src_ptr, chunk_key_len);
>  		chunk += chunk_len;
>  	}
>  	*len = chunk_count * chunk_len;
> -- 
> 2.47.2
> 

