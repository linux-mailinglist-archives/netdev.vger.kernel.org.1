Return-Path: <netdev+bounces-127250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02382974C36
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BCB2B23013
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E67314A606;
	Wed, 11 Sep 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sm3thne9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE613C9D4;
	Wed, 11 Sep 2024 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042115; cv=fail; b=qV2cFje/5u2/Ix7hwZRyLuI4bOqOWT44u8BRddYWzD1dn540T9yzuYVEMgU7lxSkI9y5+P5RhBUtStgw3YHn96F8BS9gXld0jXnHPPTwqX+XIcfBaMvq5Gzl/N003RNan9g0hGJB+YsZz/1QFbPYix0ZUT6owPRiVpJAkO3wfoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042115; c=relaxed/simple;
	bh=tA4zhAhZA8IR/XvBdiOm0P11fukvtVYOVD1nNtH5tu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bUURsb3Uq6GG/EcUPWyEy9a4gWMdrrjKd2JvBwhy7RsUhUyyZeuoXylrwFbowf4EMR1DuPziEIsxshuyBtqxVXe+cqTGwpjaqhItrgdGRumsmHWBoLLPVywFnunfJBm7QOkpBtOdU/8+UVZZAae+S/BFdidEm8FMYleuJD5IvY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sm3thne9; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hN0t456BZlJNf9MNAlsCTbI9ScoSgj121crBYdQC0R303YOGFrMSoNYjkTDusp2FnX4RtrLVOaYHElj//UCpKoemGVv2QeiKnEbOZ9XSesG8uwqGu12Klcb7H1JXHvdDnNQS4AquUhuUgxm/72wH6Sq65+CgXs+8pqynO7+TxsLgCWzwMLlgM4hPtNeEynzJKEsW356vLAAcyzuFd24c4Kd02Wf0cK+Wwgu1EInVJkSLyOeDxKtl0cEVYfrozP/C9Qu5slqKb3yrRLTFDsIoBY2wvMw7bRo6nm+SUsQbLe6pAvnTLL3/lO5Lje85s2ZIAeadTS+ZuYjd6ADQMcjaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8ZIl9aYRESON/dPMI2Yjsg47qRkwv5bFiLB8F+1YdU=;
 b=y00ATCetEg3wN1ZyliAKcflrgcnEQt6l1DkfqnGXD/IqvJVaZ0lSExHXgHPdoWCkteUcQjNXH26fciFv80W70ih6ceR1Nsqx4Ty64Ej6KGyD1f8FKLKCB0vFMl8G3348nmMdOloh5ML3PGKVftw7n0OsvhLa/zJJcHi715GJl546AHhhpfFm1Ecx7ZjcRohIavqzMWOtzoNcgE0wpmFsTCkO6hCy5Knsp0s0TqgooGBbKsHbqMnc3ntfPqwzZ5F8RjFboP3GwYzbWSys7tOsm37md4kDQ2HBEJMvs986mT0pwwSAb64dD0S+Q4ZToqxtLZfXe9MvkNp/vpPVWEsW4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8ZIl9aYRESON/dPMI2Yjsg47qRkwv5bFiLB8F+1YdU=;
 b=Sm3thne9bJ7zG80oVf/yL/L5DuF6EQyXn/Bd470AT1lNk7N2LeFq10scaqQS+avicgKEHvevDHvzpR5pUYJrLnScw04mLrw8om11VVGt2U1Bar7qznElBdR2KDJmOiPc1HbCB6Q8od9bH1TReTIpvAUwgQsLvdrV2wMhU90l5qO1gweTxHjctnnvJuDr45NgJu4/1HFPQs4lTB4ug0FQv9G3YUQeibByIusoUTKA7TEduFaN8IHre38d2cjf6oUTWaJgb8elk9Byps4vFJRKluiAH0AAP+bJk4Y7Lc2Wz27GUZ3/dre6KjQdhGMHtLVc79ILw5DYFaIHZT3wMVjrsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 08:08:31 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.7918.024; Wed, 11 Sep 2024
 08:08:30 +0000
Date: Wed, 11 Sep 2024 11:08:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/12] net: vxlan: make vxlan_snoop() return
 drop reasons
Message-ID: <ZuFP9EAu4MxlY7k0@shredder.lan>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
 <20240909071652.3349294-7-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909071652.3349294-7-dongml2@chinatelecom.cn>
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 4318a151-b72d-4b54-2bae-08dcd238ec5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ORqy9wLp393ykSgCoRr3R+0K+VPmpTEQcwqhzVYZIjjeC0XJQpx4hzywD+cG?=
 =?us-ascii?Q?d8VTiR+NDcf1QOtp/rbAhrvDDaVHH6kn1DWDMsikeSpdWWXA6JLDzSANsO2p?=
 =?us-ascii?Q?akQR0MtoXlzYBNhPt6p+6JeCMx4SK6aV+mw41vHpcn0WUArtDyENSc6cv5lM?=
 =?us-ascii?Q?sVEYnwRqgiZcWFyVOzSqw7tW8e8FjHbDSOUNsqmA+/s1xug0eJ8VsxKFvpQW?=
 =?us-ascii?Q?SO2Qg0wW6RK+/dIpOSon+nKXa2YaGWsMyJd41FuTGUnj2PTOnCyKQlpAhft6?=
 =?us-ascii?Q?EqTw7IcNYR4UFdcGZi7+EtqMNuIm6tbrFzNnX6lWKZxxYgL+S2MEdFV0s5Jz?=
 =?us-ascii?Q?+xptyLLa4FE4BjOTb3OyE0uWhIbjXDTVaoNcItpOuhT/Rwjsl1c2FYbpg/fA?=
 =?us-ascii?Q?QrfAxnbSKprZWofe0QkFn9+pc2iYdKCqXwtteilVuO79BiZHhvMGPJo6YyCD?=
 =?us-ascii?Q?CtEJLNbeK0p1C7ta1vFtnSH3ImotnKicH234aNso2/K+QyGRZST/AKC4g3sW?=
 =?us-ascii?Q?kb2ddalCpeXzpyBgwTUNmSBPTvuNH6AsVynMAhg9PgFCWHNrba41t5GR4LpT?=
 =?us-ascii?Q?dbybMApi4qTrTRN2ZgKOTuIflLZbGqWRfCjSS4piM3WC4xDESZ20tX/LGVzC?=
 =?us-ascii?Q?YZ8xTkNOe5npIBkzzwTjQ1AphuFazlDTaL/VLLrAgpOlQ2N/1Rk5tx/6Of6v?=
 =?us-ascii?Q?RIow6+WNT3iZOFf0PVDf3dI2NN8EGQls6vDAQKf2sjnIHTSuWz5tiT/uhqFe?=
 =?us-ascii?Q?5h1f34BDjlALe99UXLprbulATLlHvoU6idi5oMGo+RPybhwSb2YACf1Q33Ad?=
 =?us-ascii?Q?X1gz/KbIARfVw+HdbNzQIsux6ndHTWTVo/kad1D4hl+2suz1vsW4vrdD0nZw?=
 =?us-ascii?Q?5DwX2jlx3c+Rxcr4ZSNyOwb+tB4ydwjBl1Z+GBHZDVAFaDcqFliMzyJ95h+Y?=
 =?us-ascii?Q?NQJhdrpu5dkZSQ8Z+XOo2n5AE4ZClgMyaJJShuYdZqpPJM9fDuI8nrZmT3YN?=
 =?us-ascii?Q?DCKhOPkHZ/N4Cubp82gnAvi04xYXnWnG64Avr5EdqhpxKCj7w/1QV7VQ2R4q?=
 =?us-ascii?Q?hEBQiCteuN+V9re5EsLdRE8h/7Yv8yAkHQhNkDE86TURGnVZDk3RtAc29y+4?=
 =?us-ascii?Q?xnXt+7NBtXpPBzGX/1mtN+pOlFTEkD6lpjJLy4QPzAZ/dyaq+0j78CGSlP00?=
 =?us-ascii?Q?WvLcI0BHNIUQKZcy8Xy1iU7iJH96wCdfkP3JgSBkHaVep5EuHunUNPQf8yRh?=
 =?us-ascii?Q?i1INv9w5c/MsGDTTB88iwAprqpfirusaqbNrKA0GxE/UXiwaxpQwhNJToWro?=
 =?us-ascii?Q?oq6WOUiCgbylE0Jz4CyjbKOMXMA1tw+3rCxteDRZ/vMJDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nCNWiCxeRIi9Sn/OG/BYoiDZi34tRzRL04+300etXdux7a+8GS1Vx/G6F9Ue?=
 =?us-ascii?Q?fB5NF0yCr8CG5vtaooAXMiPXDdL2Q3jWHHgDFPp02I5/pZdv+0iKlDziygX8?=
 =?us-ascii?Q?rFmfMNeYATcjnrGM6C5xLLbZ8fFWUPIhi/ljombrhdoMSOmAZ2KVCODFbzdr?=
 =?us-ascii?Q?sL828eC0z3EPH2BRq+jYcGPm7KOJohJrn2pWmTv/1sJnYHY/Y4E7g1LTlA8J?=
 =?us-ascii?Q?WvWwoBra4v328hAKO88uW2iptyYN91SjpY8NfGPVSmhRvVN5ecEUIqJWiLhk?=
 =?us-ascii?Q?ILJHCJ12FA+T5NzlcQAhPsotWGaBcCgrNkky8i371+PqbOA/V0MemooFWqpR?=
 =?us-ascii?Q?SEKdHqrCkQZvSyMz9L9kVKlH9DzMFWR9Bama5COOXLvPwdUbX7u4ONuuCqAJ?=
 =?us-ascii?Q?iTI23oGOYrbk1vJdtimn6T5F+uRNaV5YmYGs/DLPqcjvxTWrGSo2nqLJ2mVP?=
 =?us-ascii?Q?lLuates0j6zknCrZYIqhVB+lE7KNGUPspCH3Wa4Yy6WriJzHXwXdoB7xODIK?=
 =?us-ascii?Q?YGfeS4QWCYgvuA6iJH7I+zb5kui4BV6Y2OLEon6TsALmoViwmHusBLHcHguq?=
 =?us-ascii?Q?gQ9mW9QA6t2tN0FUqV1ISlgPBcJ9/8cYXqAKELNq22r8o8WRaASFAFsWC3kJ?=
 =?us-ascii?Q?aq7lRB+zXJp1WHZDA8PmLjYZuZDBQKYRX/R4jaPwzbXZABjCQ12zqL/C3acV?=
 =?us-ascii?Q?2eifccAy3YZ5hq2nh0w/b4cd2ecMOrg8vXKdkptdRM2aDfj7QlF+btYRYeU7?=
 =?us-ascii?Q?7TVYQI+eI/e4/xgER83Ye1CNlGWTSoBrbjnY5nwIYvNI5j/6n7ndfl+l3fhL?=
 =?us-ascii?Q?KM907oKoK51arDpNpx6vxo+DR/EglSjyjQS8u9pcjtXc9mEmLd5s7MlCJTbJ?=
 =?us-ascii?Q?TXFIkH/npAoMHBQQwLn/5TcxZt93u/Q72K3pbb3q9vkZ9NYxYkRoeezcyubd?=
 =?us-ascii?Q?6RiaUlw+BScahVTonkBtcPqmNEdVF8z9SNPnw0BQhVOHeqtLh2D0cntpoqFT?=
 =?us-ascii?Q?mx96edSjaq/qO7Lu4SpC+NGEgjSrUF758WngLKgVCWblyNzuIgcFBvTVDG1D?=
 =?us-ascii?Q?H4FizerRbV/Re5bPmRbVotD5jkt8ww3AT2FlLKdXpBIU/vdHHXp0M/rPrqUY?=
 =?us-ascii?Q?+nqawPvERfJqQW3QpHfYSG7ZBNjHZdqT8NHOxy86yyPcWDkHepL7YObHGz5b?=
 =?us-ascii?Q?EF/IKrlW6rbPGHdyw17bewNE7EyD5HxBv+ESEBvgi6Nbp6/I5ndvz5QV05+G?=
 =?us-ascii?Q?m+MlYHjHFM84Gs91tbmgWUk2lPTvfmjn/x28OTaZJyp1XkPmDuZPzyk9F57/?=
 =?us-ascii?Q?UCHKrddBUfY+lhbLkyDZAUgNGa1vG98szVJe5hjS9GvYzO5jd+tp8iOXagoR?=
 =?us-ascii?Q?T+ktWNDmX/mJklrb8a5/qz/LDxXJzjp6Ohkty0HyRdojQB5+Mw1v+E7EaQ1i?=
 =?us-ascii?Q?RLBGGmRv8wvP8+ueZguMpyxIr2Q8LeXUAe2zBzntUHBGr0v0mOKAhsR+NwCj?=
 =?us-ascii?Q?otzX7AHxkodQkp+4jqeETFXJXVpAjcDAcwJF+UYG9pPKtLwoZ5j+xIYxtAo/?=
 =?us-ascii?Q?OjV2fbLSUHnEux5PcD0RtHck0bpZjc6MeMa+hmHQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4318a151-b72d-4b54-2bae-08dcd238ec5d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 08:08:30.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlTr2U0yFvrRvZbUKjsVMg+eOEYwj+pkJtMGVjQWkUwv9Rgir7OGB3FaobFdd62kxxoLP6NrL0r3gAdCj6g94w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452

On Mon, Sep 09, 2024 at 03:16:46PM +0800, Menglong Dong wrote:
> @@ -1447,7 +1448,7 @@ static bool vxlan_snoop(struct net_device *dev,
>  
>  	/* Ignore packets from invalid src-address */
>  	if (!is_valid_ether_addr(src_mac))
> -		return true;
> +		return SKB_DROP_REASON_VXLAN_INVALID_SMAC;

[...]

> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 98259d2b3e92..1b9ec4a49c38 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -94,6 +94,8 @@
>  	FN(TC_RECLASSIFY_LOOP)		\
>  	FN(VXLAN_INVALID_HDR)		\
>  	FN(VXLAN_VNI_NOT_FOUND)		\
> +	FN(VXLAN_INVALID_SMAC)		\

Since this is now part of the core reasons, why not name it
"INVALID_SMAC" so that it could be reused outside of the VXLAN driver?
For example, the bridge driver has the exact same check in its receive
path (see br_handle_frame()).

> +	FN(VXLAN_ENTRY_EXISTS)		\
>  	FN(IP_TUNNEL_ECN)		\
>  	FNe(MAX)

