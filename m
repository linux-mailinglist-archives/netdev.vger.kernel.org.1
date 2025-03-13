Return-Path: <netdev+bounces-174638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E8A5F9C5
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D161719C1F4E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D77926982F;
	Thu, 13 Mar 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jpjchw6N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2DD268FCF;
	Thu, 13 Mar 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879534; cv=fail; b=qtcKdVi5abhWtioRzInkJXwQu1S71TI9YnqpHxQrWOV6MQj5Di/O7tC/f3ONa6Mr5G6W6Xa4Bz6X+ZxIGoxZPPZY0bv+ZodXWyrBggKLOhgKRxp7Gl8gAjG+NPB1YtGhUQG/2N7p+5BDAHETayo8sBCnxh2mIa1D2EFWZgW1rw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879534; c=relaxed/simple;
	bh=ieTD1yHrpwykN+6JxMMNQWxQQGLbYZ7hBEZjDYWofI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R3oMt5HYFSdjEB/buFeWNXJ2hAn69xM/1mzneUYBcPPOLMR30AdfccTGUIrcGNE40u9D7n9MhD1EEK+l+/Cd305/wnCIDGGS/sESRaB+zsrfAVjkMZ/rX5s1Mxu2/kVDM8x8eZBhiE9jTeVXbbIBWJaW2auDQJo3D+Ss56aWqMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jpjchw6N; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKLp+sQXWWdpa7QFmAHlQpGoONdsoPDBU2Q2tCQH2JvFFOt96cE4azJPxFkMlwoc71qTaJkUxi4Au+7ioxBn+zj467ucQki+JOZFIUkoP40jEIVLut16gkOzgwknfZATJSXbBfVZn5PScMbpl8MAt49XogsbX1CB3nqbUDV31DvC3+rlFbIYB23ttOHhAxpsAl6PLdBQLr+WSM4J+S2sHumZcoAtp3UWA+PsU8a+aRLCwj1jUOwixbO+4Zcpyf35IFpnuQHK3tPr6t6HzMvtV1GcYtunLQg/6otR0Dnqwf6vmaFGDWK3Ql5nwCkbVmPAN1SeCWUgvZWaUtd5rJdWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gm2j19uYJ6fneNoEbHfy6SJx4zSvkFYpq3Q2Pjf1zkI=;
 b=LIfVSY3YqP0urfBFHsB1FimmEMQr64+AZETJUnjgAycCEhT9qtF6C8SSFXnTJ9XhDNUvIH/ri79s+KXbsbFRu0c9IET7AKyNKcidw38s3GrWh+m/k+eBgJgvJ198m8KhX3AwyuYU0dhsPKFEPYQBHj6pt0noJDklr9+YDZywuWZmlCPz1EdYzPFsNQS8UAqdbCuf6d+dFebT9qaLXI5XIFIO4EGLm6VPor0XVQCnYaUHlmFJs4MSfJbMz7eEy0+VofAzU7w3cq2LjUcqn0HasNN2BJGvFO0uC291dodGnJdlLhZDWgGuo6jf6OXgUCro74R5zcCjw2bAXEC5jlMtZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm2j19uYJ6fneNoEbHfy6SJx4zSvkFYpq3Q2Pjf1zkI=;
 b=Jpjchw6N/mibHULbb9KnldDGcJs5VtPG+z5rGPbGxF6JxLZ8eC4fSzbptyNXHvl2qw3ZKmNbiTRhxdNkomacA/AylChN3lgbmIQ35zfjxK3JveRvqKKeNvlR0SK8t1R01aW6PSA+vmHDj4iPPjtCE4F27yCB5erTVJpTbXPcnrBjo1DbRlR7eNSV0623PKIXKUCTS+uVrJKZvGygikSeTE2Kkwkdbe4zsQYqHkK4WWbqqj274vsZqa/jMvNb21i4eFafIVMk2yxM5LdrFZDXK4TgVWQPPG4Aa1CsjhlDByZ7XN0L3GMjuzLtAgDzdxrVNpAdMp2o4v5xNmXmXoDRAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8332.namprd12.prod.outlook.com (2603:10b6:610:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 15:25:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 15:25:29 +0000
Date: Thu, 13 Mar 2025 17:25:19 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>, wangyuli@uniontech.com
Cc: andrew+netdev@lunn.ch, chenlinxuan@uniontech.com, czj2441@163.com,
	davem@davemloft.net, edumazet@google.com, guanwentao@uniontech.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, niecheng1@uniontech.com, petrm@nvidia.com,
	zhanjun@uniontech.com
Subject: Re: [PATCH net 1/2] mlxsw: spectrum_acl_bloom_filter: Expand
 chunk_key_offsets[chunk_index]
Message-ID: <Z9L43xpibqHZ07vW@shredder>
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
 <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
 <Z9GKE-mP3qbmK9cL@shredder>
 <70a2fa44-c0cf-4dd4-8c17-8cc7abf1fbce@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70a2fa44-c0cf-4dd4-8c17-8cc7abf1fbce@redhat.com>
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: f048662d-e873-4ac4-0e32-08dd6243498b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TvB72EC4c1L3uvHpqZQZu6uJ3NzGKXdLic3ZRdOgoeZiclyM1iyiEJvehogM?=
 =?us-ascii?Q?hAkLjAYzz9wMzgqGHaKWZnOHDz98pIDyye5iHRCB+GEYmueA2NEaIaqC/cTv?=
 =?us-ascii?Q?wKNASMvnqMU/wcMbjpJuq+C9PuiBTOEFu7BExGXw1iJFHru1X9f5O1YTn3cW?=
 =?us-ascii?Q?Kk8N3h//nG2pccue81W2dJZ4CXG1RBSc1ZmeF4MlIw8ht2WdFtxfbWmqpDW3?=
 =?us-ascii?Q?iZ2SjyKj1IuOcqFY1r7yv8FFNMqMVG7HgK5LHAPg2Oks5+lZcfMjNCwtkTEr?=
 =?us-ascii?Q?8aOK5rUVEja9VUMhFMmisRi0nY5vwK5c7jeojIcwpsln5K9d1rL7N3Gx7pox?=
 =?us-ascii?Q?xr2GWGouLmguO4d2Sc6uvB3QPsynE4XEqLKLmhwJk+JUFhMYlpLLgSUagKyN?=
 =?us-ascii?Q?tu50K1KjXOFa1Uv1V5i3rpN07dGgVmwhF9pGoe8zv9kdWt3a2ZdopO+n/34V?=
 =?us-ascii?Q?sBbAaSMHfszgynCcxX7O7jiBsSZWbMQWMctM1rbU7SByj2qkN+acIQoaXRq+?=
 =?us-ascii?Q?3gY7s2NK1KqDwYojAZ1AgQdGoqk4G/+ZJDjK+PVRQCH0mZNVwTGRkdClPVau?=
 =?us-ascii?Q?kiV4EGJjr0+U0JPxxQZ399kzeWSUlBmIrOwYxH/sREGM/AdCxYvSHHNRN8QB?=
 =?us-ascii?Q?s4pYqBgyQ56Hk/TkA3ZPnRmPHp04/yx6H4af5/HA+1FAECejKLY160g1jXAi?=
 =?us-ascii?Q?QW4W+/5Y3sPYyuFH4jUEz9R3vCwJR81yTzqA4feYMokFtDOizzJhSfQAqfYA?=
 =?us-ascii?Q?bUZJGZNzslVQfGh88yNSBqDFSl168BmZwXtrRez9hAJdV+Y8HQLnadw8DR5g?=
 =?us-ascii?Q?phBA3U+BGBbJighDWY0ObwNG/gP+bV4iEJ3q4JzX6FM7QtTigDWySXTgTKEW?=
 =?us-ascii?Q?Tudq7czHB10W7gOiusKuLCfrPrX7/7VKadEGXGoencwEmC7OFzIkh9vORKFa?=
 =?us-ascii?Q?GbcIJQnZdB7eU4fRWXdpx8/X9QfFC+t/tb9JmNejuEVc5ofxajJZ/U6fo593?=
 =?us-ascii?Q?nI/sNUva+C7v0rRDFqvo4JFJTZgOAjBuLEBJv1h+atT7ZVuhD0s9mOHqWfH3?=
 =?us-ascii?Q?TVgGx9N+c+2bEl8gFXHZdHYI4J3VHbnbpb/ze1KpTC/XRle+Lud5wJW77Y6S?=
 =?us-ascii?Q?RzYa2zKd8ETAvKTf6r7NYlm/MIkWVcec2RS7L8gkVG9mg4vruqazHqMRhrB/?=
 =?us-ascii?Q?j3iU182z8FIyg45VHigT6DL4/fijux8IK982nX+bmhi21GUHPDcQZOkBpEbQ?=
 =?us-ascii?Q?hEVX8O54Zjmf768SxcFhgW3JKc1tj46pYMgOIGiDs8yNvBaNdmiUZOECIURb?=
 =?us-ascii?Q?Qi8cSRItDMLiovjcnZoeWMbIu6QQAhDiWKS9/yCRqUYYS+HkF4N1K3Z/x3Hi?=
 =?us-ascii?Q?Q5GY3vtVPKVqXVkfJBvzGCQUCmHD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6YxJ+F5NRQpqksw45+JwKvsMRNt5Qy9+M6RwqCC5D7xiHwFh7PRH+QfEAJZL?=
 =?us-ascii?Q?+EaD/JBDb/umrW4EGrnsRauR+KCRk+NdqTHHZgPUQ9x5sH4sxnWX6haSCV70?=
 =?us-ascii?Q?IwxgoJJ3Voe8DVQ9OLmhdCTvuGaZPLs0CLcQPRVCDamWzzNXWP15HzU7Acoo?=
 =?us-ascii?Q?YcSkFC25OYOCSXKsBhbPDRJS8dpruK8mVmgUXuUDux1C83ZwoE8La8W4JSEZ?=
 =?us-ascii?Q?9XuyeRal0XsUjOFOby4u/x7gTchHH4PZ/utGrH7oxcdcwivq/uJ+Di3oF9VE?=
 =?us-ascii?Q?wxLIDANzwxYfcUthzY0jxZgM2RAVvkpcWwrdLuFIsAdgC8IvN+kBGNPbPhHO?=
 =?us-ascii?Q?E/kZqIQ4L2y0e1vjP8QNQQvEJxaZ/Z/K2Ym9qP+HfSfH+RDHyQ7c1VSwXVQH?=
 =?us-ascii?Q?AfOoUY9VvhlNSz/fwe5oqsQA/9hTz3Q9dYnje1cty4glYU7ejtUFXOG3ZbnX?=
 =?us-ascii?Q?ub/4DmUrltHaXNWHTcKiPut0MKAagtAoJviA5oph1lpRAIilKuqcVAfmFfkO?=
 =?us-ascii?Q?HuU0BxAJy5qRREk4tPEoOvzyPBcFy3fspFryLVarl3hhtB9gU62/E7fL9QSi?=
 =?us-ascii?Q?Q1jqcUTOItdNnoPnTmg+wvHzcruANdojiO01qi6c0J2nnuBJQlky5o7LxtLF?=
 =?us-ascii?Q?VmPYazIIdgTy2QTbq03fYfLnPvhSaXBSMDbQMzjmb3KLucx4Zvx8lAvUoHZ6?=
 =?us-ascii?Q?L1ESD63ovOY7xQ2ClrhBkf82DGmfIpxip+UQSx4UwRlW0r06pclhvxtaP5aW?=
 =?us-ascii?Q?LvMRPFk33kfNB+XRCBUk/bs4I3aQjEulAYYe1seZyTdaGSl/GQAcLXZgEJAH?=
 =?us-ascii?Q?LzSg7yMKA2UrT8+2C44Xg9ll7dOWj+Y1z6p36Wtxee7sYkwsd/FiR59QlIfs?=
 =?us-ascii?Q?dOWnb4XKU7oJw9cXOrlpTGd1NzI9IX7QmDLvNqKTJTcs5sg5rUQx0A5loXVB?=
 =?us-ascii?Q?DOTlzs6w3k6V/YEx9pp4bx6QV867EKgldZMwXJbtHVP8BXcURXO7pIrwbYb7?=
 =?us-ascii?Q?UY4uXsqTm8F+BvNm/7+aNLgBXwnuAolGt34j2tqXnb8L0LF3lUV/ZNULyP/1?=
 =?us-ascii?Q?IyB05Lh9Z2CMX4jV1tIa0El5FuMWU8lt+O4LKROyXx08WW9VF9VT/Pxzu+ig?=
 =?us-ascii?Q?v6itdgGTf43znWrZ1i/CqVFzleY9BqqYIC/XH0BnOtEWtfn8SgAvy1HfBgHM?=
 =?us-ascii?Q?lnAiNQiiq3Fmvi0z+wgMQuDXMZK04scU37XGCRrtZHAIs9H/HSa2Atdo9Qxg?=
 =?us-ascii?Q?upMMJ/0826XNR00Ize7/oNN+KkERK6hMIm22C053E9MiBrUxcMu4E/Icd9aS?=
 =?us-ascii?Q?ofJNFXtsUVDP1BClhFYsO8aqeUjHx6yMIaiC29hXqiQkMqjZWQBlnPXZOLoY?=
 =?us-ascii?Q?Vi0mI+B4rvOrEuzMQHQtUKwxQJNY3MxqfmhUC2CqmAcsT3Xs2QCpPq+qdCPs?=
 =?us-ascii?Q?U+ueADwzYyXtBnAWNakUJxPXN/HNNXIWZsyGgV7U3OXCDhx2mcWHBxyctrxX?=
 =?us-ascii?Q?YErjwPGA0XkvVQTP4dH9Xe3oOQD+MKJzREsYj1n1CiLyBbqbVg68noBlaV45?=
 =?us-ascii?Q?qTDEh15MDRKsS4vFePCD6cTtDHQe7n/+oiru0X8D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f048662d-e873-4ac4-0e32-08dd6243498b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:25:29.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agdBm8/SRJKATDajBdluXyLuuwCX4YrTXUqm/frBQW0Vs8npce+Aop3/c3i5AgrFU3aiwUr8XPh8MRme5dJGAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8332

On Thu, Mar 13, 2025 at 02:52:11PM +0100, Paolo Abeni wrote:
> On 3/12/25 2:20 PM, Ido Schimmel wrote:
> > On Tue, Mar 11, 2025 at 10:17:00PM +0800, WangYuli wrote:
> >> This is a workaround to mitigate a compiler anomaly.
> >>
> >> During LLVM toolchain compilation of this driver on s390x architecture, an
> >> unreasonable __write_overflow_field warning occurs.
> >>
> >> Contextually, chunk_index is restricted to 0, 1 or 2. By expanding these
> >> possibilities, the compile warning is suppressed.
> > 
> > I'm not sure why the fix suppresses the warning when the warning is
> > about the destination buffer and the fix is about the source. Can you
> > check if the below helps? It removes the parameterization from
> > __mlxsw_sp_acl_bf_key_encode() and instead splits it to two variants.
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> > index a54eedb69a3f..3e1e4be72da2 100644
> > --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> > +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> > @@ -110,7 +110,6 @@ static const u16 mlxsw_sp2_acl_bf_crc16_tab[256] = {
> >   * +-----------+----------+-----------------------------------+
> >   */
> >  
> > -#define MLXSW_SP4_BLOOM_CHUNK_PAD_BYTES 0
> >  #define MLXSW_SP4_BLOOM_CHUNK_KEY_BYTES 18
> >  #define MLXSW_SP4_BLOOM_KEY_CHUNK_BYTES 20
> >  
> > @@ -229,10 +228,9 @@ static u16 mlxsw_sp2_acl_bf_crc(const u8 *buffer, size_t len)
> >  }
> >  
> >  static void
> > -__mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
> > -			     struct mlxsw_sp_acl_atcam_entry *aentry,
> > -			     char *output, u8 *len, u8 max_chunks, u8 pad_bytes,
> > -			     u8 key_offset, u8 chunk_key_len, u8 chunk_len)
> > +mlxsw_sp2_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
> > +			    struct mlxsw_sp_acl_atcam_entry *aentry,
> > +			    char *output, u8 *len)
> >  {
> >  	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
> >  	u8 chunk_index, chunk_count, block_count;
> > @@ -243,30 +241,17 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
> >  	chunk_count = 1 + ((block_count - 1) >> 2);
> >  	erp_region_id = cpu_to_be16(aentry->ht_key.erp_id |
> >  				   (aregion->region->id << 4));
> > -	for (chunk_index = max_chunks - chunk_count; chunk_index < max_chunks;
> > -	     chunk_index++) {
> > -		memset(chunk, 0, pad_bytes);
> > -		memcpy(chunk + pad_bytes, &erp_region_id,
> > +	for (chunk_index = MLXSW_BLOOM_KEY_CHUNKS - chunk_count;
> > +	     chunk_index < MLXSW_BLOOM_KEY_CHUNKS; chunk_index++) {
> 
> Possibly the compiler is inferring chunck count can be greater then
> MLXSW_BLOOM_KEY_CHUNKS?

I think so.

> 
> something alike:
> 
> 	chunk_index = min_t(0, MLXSW_BLOOM_KEY_CHUNKS - chunk_count, u8);
> 
> Could possibly please it?

I would like to get a warning if 'chunk_count' is larger than
'MLXSW_BLOOM_KEY_CHUNKS' since it should never happen.

I was able to reproduce the build failure and the following patch seems
to solve it for me. It removes the 'max_chunks' argument since it's
always 'MLXSW_BLOOM_KEY_CHUNKS' (3) and verifies that the number of
chunks that was calculated is never greater than it.

WangYuli, can you please test it?
Also, if you want it in net.git (as opposed to net-next.git), then it
needs a Fixes tag:

Fixes: 7585cacdb978 ("mlxsw: spectrum_acl: Add Bloom filter handling")

And I don't think we need patch #2.

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index a54eedb69a3f..a1ab5b09a6c5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -231,7 +231,7 @@ static u16 mlxsw_sp2_acl_bf_crc(const u8 *buffer, size_t len)
 static void
 __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 			     struct mlxsw_sp_acl_atcam_entry *aentry,
-			     char *output, u8 *len, u8 max_chunks, u8 pad_bytes,
+			     char *output, u8 *len, u8 pad_bytes,
 			     u8 key_offset, u8 chunk_key_len, u8 chunk_len)
 {
 	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
@@ -241,10 +241,14 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 
 	block_count = mlxsw_afk_key_info_blocks_count_get(key_info);
 	chunk_count = 1 + ((block_count - 1) >> 2);
+	if (WARN_ON_ONCE(chunk_count > MLXSW_BLOOM_KEY_CHUNKS)) {
+		*len = 0;
+		return;
+	}
 	erp_region_id = cpu_to_be16(aentry->ht_key.erp_id |
 				   (aregion->region->id << 4));
-	for (chunk_index = max_chunks - chunk_count; chunk_index < max_chunks;
-	     chunk_index++) {
+	for (chunk_index = MLXSW_BLOOM_KEY_CHUNKS - chunk_count;
+	     chunk_index < MLXSW_BLOOM_KEY_CHUNKS; chunk_index++) {
 		memset(chunk, 0, pad_bytes);
 		memcpy(chunk + pad_bytes, &erp_region_id,
 		       sizeof(erp_region_id));
@@ -262,7 +266,6 @@ mlxsw_sp2_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 			    char *output, u8 *len)
 {
 	__mlxsw_sp_acl_bf_key_encode(aregion, aentry, output, len,
-				     MLXSW_BLOOM_KEY_CHUNKS,
 				     MLXSW_SP2_BLOOM_CHUNK_PAD_BYTES,
 				     MLXSW_SP2_BLOOM_CHUNK_KEY_OFFSET,
 				     MLXSW_SP2_BLOOM_CHUNK_KEY_BYTES,
@@ -379,7 +382,6 @@ mlxsw_sp4_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 	u8 chunk_count = 1 + ((block_count - 1) >> 2);
 
 	__mlxsw_sp_acl_bf_key_encode(aregion, aentry, output, len,
-				     MLXSW_BLOOM_KEY_CHUNKS,
 				     MLXSW_SP4_BLOOM_CHUNK_PAD_BYTES,
 				     MLXSW_SP4_BLOOM_CHUNK_KEY_OFFSET,
 				     MLXSW_SP4_BLOOM_CHUNK_KEY_BYTES,

