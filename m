Return-Path: <netdev+bounces-77615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F387257B
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF152810F9
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286A14265;
	Tue,  5 Mar 2024 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ij0iE5oi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27AE5256
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659000; cv=fail; b=i7jTOxxNRNSovBJzZJ4VK/8hsdTSfn/YkX639hgy3V2VEPLrPRLZlEhYeay2Sc96uO7pZm1ZWk1gZKGd6QUUbtHjy0GEsoLfpUxX9duyyBO1KDU2NVP8zSd0+k2+GPGTD86ppuYVv4E2e3v4bkGdK/0LJpvmJ3H1YtgvXVk1cVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659000; c=relaxed/simple;
	bh=QTlRGM/0LS54yDiui8Cs7FlJyXalGBebHlJJ+0W2zPc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d3/S0dIuIEDIj7FdvB+b7dyoEaStS778K+JGZhhKMAnbsXgYkuRcgwa8IA8zZoswQ3Uf2B6YNd9IxK8Hy5GUef3EGUiLg+xwEbne6KtAZ1pby66JmucX1asYDd0upVUq6s2bVxaFDkG/9klyYOEJL2lWdYxWaEWX2VQmZqWVc2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ij0iE5oi; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeOIBpjaIDhbHw9GGrhLiYRC1WQnFZIgIG6Udv3ISA+EVNqQ7+NmN9GBmJnUArT1Y3iFBCNvYIA2ioenaxklHGpmERWyiExH/aGpbB+EIgRAwidv7ocL4CEF3QkIjYtpoIuY52C4dRCIWSxGSQxVsVFxHYpjoG1qfGE+hl91ECWY6WIaEqNGboVXcB+Hyn7nt/fkjWCkU0PDdNcfiYsrgeGcA8QK87CxVGLxtKhHXY6bEvWU6UhJwnya2qakQZjQyS4OI7lhNHU3yJOyDlf+6UMqKyOsSIP408tT1UXXAOphToBkgwfkFrVPxdJ5BCXbiLf0Dv924OGzvA4Xjjyexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p087UwovzbZm5pthj3inO7MRK9slpzOeoMMfg0l1dfo=;
 b=EFsmsj3dnOCzF2Lw/ZfrCQmd+/Je2Eo/suxxsNJdQhUY5XeE+ATm7zxlzrvmTARgaDO6raIsVN1BsXkZXFYjASzE78gi3koLWovYAVIjPgTqB0Me9GHOqhTPd92XMT/7FYikLO5Q4rtGKa0Wz1ngBTen+Z3KwjHzYCRgBsFTRHywhH84tMN069Ajp5hdI03b5CAMYDDND7nbxh0QqzHZRrbE4TyRH2kOJy+dbIwFyulrIvyqLmwJaaV7RHczJdQAORbnm1Xlp3pDVHRC5UnmOzVpAix7xQFpgr0qZjRSjvWXzhqMcmIfksYClkUyE9S68TTf5kWTwH7tIq4hkZp9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p087UwovzbZm5pthj3inO7MRK9slpzOeoMMfg0l1dfo=;
 b=ij0iE5oixp30EMZTEcDCpJKzz/ZMA7q2NFbhd0CJ0CeGBjhvSKHKfj4krYt4Ll9V4JQVIm02LmaMh9c4z41FX8hHlFp4Dz6gtBjAEKH936O11TK8F3qLTF7rkPbWEG/6Wi0yn3ZL0d+hgu+x6y9DRSJvD+P+mp0/bIexjAW7/rA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Tue, 5 Mar 2024 17:16:31 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 17:16:31 +0000
Message-ID: <406f8592-1b69-496a-b9c1-842f54a45f3d@amd.com>
Date: Tue, 5 Mar 2024 09:16:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ixgbe: avoid sleeping allocation in
 ixgbe_ipsec_vf_add_sa()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 lukasz.czapnik@intel.com, Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Kubiak <michal.kubiak@intel.com>
References: <20240305160252.68708-1-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240305160252.68708-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0102.namprd07.prod.outlook.com
 (2603:10b6:510:4::17) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: 02426d9f-f59c-4799-4b94-08dc3d38003a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TblSL6p1i40B5cQMe0oxoTH/k5BC3wp19E12537bLx0sErrpZfhqdacEc5mOEhr1IJqJySmcTP6jcYuVwF1eMhGOknwbujO/Lr0OMKDco+/RDcie7MAWQ9Qjpzts1YHXhCXPz30eZ2z2OMJBxLXyS5PdP/3E7nu+GU5GehJ4a5YO+mBif5SzZYFAO7Pmwhm7OsUW2CQErVbE6KhhCmtoA9Qd8USTBK8AMmo5UeUuMNYuG+kT1xN9bVGhId8X83cbMcfMb9S4xAJZJ10Bcc+T2/WgFxu600sshj+gZeyIBXPmhrjf7zKprKRPPAsHE0XgQv2qB282kH6YOOSrbJIz3LWiSEJAKMcDtujPACjeoIgk8IxQ1rrt0+XRCCtpsAaXPk57uUP6eMmCpv0BTr2Q06V9wR6ttBdlbFmJh7O8J/8386EnpZRoZ3a2XdgJHM4863G/0J5D/gP36b/JjJgz7H35Z+opVtUmje/jkH7Vys0tuWSUW0PriGJGTSyOcgkSf9QcB+SKzsDzgRP1j3FO0jOFt2SpzQjnc3lpbsZZ0dkn7vgs1uoUkCyHN83V81TPwegsdBv9SZuehU+1d2a0b0nvOd04EmACB2X0tvI/U3k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXdoSmJZNGpUMzgrRTBUaHZnQ0ZzU21OR1pja0VGZkRMbTY4SVhxR3FCd3hy?=
 =?utf-8?B?cnBhTEpidXVEZGdoQjJtdDN3dksvVHRTR1dMd2tSaXVsZXFtdGdSUXdrL3ND?=
 =?utf-8?B?aUorY3JZTUdBMDM4aTRPYklNVFRtL3g1dEtibS9VY240WnJHZ3ZxZ243Qy9N?=
 =?utf-8?B?bFphOVluL0lKaWZXMkxhU3JoSzZ0dS8vM1hPdUdNVndrd0Vac2s1Nit2Mkhv?=
 =?utf-8?B?NjRHV25mQklSb0NnMlZzeGFoUDl2dVV4NWZEdks1RlBOQytFQUJvbDB4Z0xI?=
 =?utf-8?B?NEYyaHpYMXA2NkFaMkluNW5CT2R2emZ4TWVmbWYyVWtjdEphT3laRGhWVGRX?=
 =?utf-8?B?RHYxK0xxMUNYd09lcmdFSmhjM0oyUzRpWTk3RmpNeE5jeUZjT1NoUjI5WTlG?=
 =?utf-8?B?UndTaXZGV3NtR2w1V2JmY1lna081ZUpubkJRNlRIQjdudTZGbXhzT3hFWTQz?=
 =?utf-8?B?ZG1zNk5IU0FMRXl0K1B5NHhCVkJqZnYrRnF5aCtyb3Y3UzFOMDJzY3Vsd1k4?=
 =?utf-8?B?VEV2TlpsR3pwVEo3SDU3QTYxbTQ4NHBJVWZ3U1dneEhWczRKRjNhbWFXNTBQ?=
 =?utf-8?B?cXVGRGdYUFhhZncvcUVNVGFYdjNwQmZZdmYxWHg4dFVWQ2RIZ01yVU1ONThn?=
 =?utf-8?B?QkVTeDNrRFpnMFBMZzBtZ2lsQ2xjSjlNWXg3SjZSRytTZHVuYUhEWDEwSEt5?=
 =?utf-8?B?cnFSeGQ1eUFjbVc0QkRBNW9LamNBemg4Yng4WkFWeHVXcy9KQ3lQeXQ2UHpz?=
 =?utf-8?B?MmpOS00wajhBSXlmcnlEWDN1dWFNSGNzOFo0SjdJaTYreUZ5K2ZKd24zejV2?=
 =?utf-8?B?RGZLQzk4anRPeXNTcXQrQlMxNkxjSEVsbXJ4RVFqUjAxUHFpWjdPVGVYNGNn?=
 =?utf-8?B?YXJGSlhjZ1lpNk9yay9vRUlWbndSS3FYRFhQU0pXR0xMdnc5dnFybkU0bzdU?=
 =?utf-8?B?eTNCYnMvWnJmY0RSczkzK0RhTE43Y0FZQldidEpoRGd5d3R4MFVtYkpPdWNG?=
 =?utf-8?B?R0xRNUdERE5XVkgvVGlQMVFFL09mZUhHUGFEYmVIM1RxenF6THMwTnZSUE1W?=
 =?utf-8?B?c0F2dkRkT3Y4MDM5c0NHNm10UnJtbGJKMDVodGhEeGxVZWI2S2lHeVFUTkky?=
 =?utf-8?B?alNlWEg0aFdlZlhpdGdUMEpORnBhRlNTRDNwc0pZZWl6T25SNldFUlRva3Z0?=
 =?utf-8?B?U2pMN0orL2NGQ3F2MTVlWlBuNDNCSVB5ODVWUko0bFhOajVTVjRxSWlxVkxL?=
 =?utf-8?B?WGpwWXdNUUFsZ0ZlUncrUUZ6V1NqR0U0RklxaVR0azFZQ25KYlRtc2s4M0JL?=
 =?utf-8?B?THJKN2M1UFdHV0paN2FvelFlOXQ0UlRMVHpuUTZ4SmVjejZWRU1YcUVzV3JU?=
 =?utf-8?B?M2FsNjVlVzVTbHNraEVaYUVtMlRyWTZkdWM4c0d5akd4L01JVDJweUF3ZHJa?=
 =?utf-8?B?aWNoQ3hIN1FDd0Q3QkxlaE5pVlM3eXEzSlZUY0VqbE02MnM5YmdXaU5ES1Rs?=
 =?utf-8?B?dXVvbEs5cEM3RDdtbEM2M1h6RUlMcnNWMk90OTNTV3V2UEdtU0xDN08za2tG?=
 =?utf-8?B?NjVwOEs1U1g2em1Fa201SHg2bm9xSVM3SjhXVjNJK0lHNTdSQ2VQeWpXYmhn?=
 =?utf-8?B?TG1iclE1alh6blV0eTYyOExCS1B2K3RpemdKaVJqcEFOb1ZYdWN5U0FDMzkx?=
 =?utf-8?B?UGhpOHpZSDRVTjRCZWhhVktmeWwyRldoVGdob2JzV0NWcHFVMTZPcHRGYmRK?=
 =?utf-8?B?N3NEdUlGUDB1Y2dCWEQ4SFJiS3BKZWpkUWZueE0vdXBzL05FaURKOWkzbmhs?=
 =?utf-8?B?V2haV3FDK09kV2g4d2hxOWtIUG1LOHI2NjVvN1hmQm9rVTBHRUp6NUl6bFBl?=
 =?utf-8?B?UnRDUldIZTl5cHhsRXU1emgyVmFoUEdud2ttSXl4WFpISWE0Nk1Pd3BEYUps?=
 =?utf-8?B?MUV2LzVLUWFTcFFRak94T3kyb1R1NjlCRVlDSUY1QUExdzFhNWE1TFdOUkpK?=
 =?utf-8?B?WFlQU293b3o0c3RBenN2Q1JIemlYMlBaQVFVMHJ5Uk0vSkY5QmZsejRpb1RP?=
 =?utf-8?B?R29ZVUFxZXFGOUtFSHkwcFdDaE1NOXYxdXdZc2tweVozYVZ6bVdzWXFOSzRa?=
 =?utf-8?Q?PLEyKsGwylMiaEz6DD78xS2Fz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02426d9f-f59c-4799-4b94-08dc3d38003a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 17:16:31.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7r9g83cCIUtwosYfyujDUrJ4G8BlWOxo5YzK4DmReAFzO6XcJzHZkXPxCnkWW2kzGjt+CCuvwuNi0+CYKOBvUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337

On 3/5/2024 8:02 AM, Przemek Kitszel wrote:
> Change kzalloc() flags used in ixgbe_ipsec_vf_add_sa() to GFP_ATOMIC, to
> avoid sleeping in IRQ context.
> 
> Dan Carpenter, with the help of Smatch, has found following issue:
> The patch eda0333ac293: "ixgbe: add VF IPsec management" from Aug 13,
> 2018 (linux-next), leads to the following Smatch static checker
> warning: drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:917 ixgbe_ipsec_vf_add_sa()
>          warn: sleeping in IRQ context
> 
> The call tree that Smatch is worried about is:
> ixgbe_msix_other() <- IRQ handler
> -> ixgbe_msg_task()
>     -> ixgbe_rcv_msg_from_vf()
>        -> ixgbe_ipsec_vf_add_sa()
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/intel-wired-lan/db31a0b0-4d9f-4e6b-aed8-88266eb5665c@moroto.mountain
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Thanks, that should work.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index 13a6fca31004..866024f2b9ee 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -914,7 +914,13 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
>                  goto err_out;
>          }
> 
> -       xs = kzalloc(sizeof(*xs), GFP_KERNEL);
> +       algo = xfrm_aead_get_byname(aes_gcm_name, IXGBE_IPSEC_AUTH_BITS, 1);
> +       if (unlikely(!algo)) {
> +               err = -ENOENT;
> +               goto err_out;
> +       }
> +
> +       xs = kzalloc(sizeof(*xs), GFP_ATOMIC);
>          if (unlikely(!xs)) {
>                  err = -ENOMEM;
>                  goto err_out;
> @@ -930,14 +936,8 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
>                  memcpy(&xs->id.daddr.a4, sam->addr, sizeof(xs->id.daddr.a4));
>          xs->xso.dev = adapter->netdev;
> 
> -       algo = xfrm_aead_get_byname(aes_gcm_name, IXGBE_IPSEC_AUTH_BITS, 1);
> -       if (unlikely(!algo)) {
> -               err = -ENOENT;
> -               goto err_xs;
> -       }
> -
>          aead_len = sizeof(*xs->aead) + IXGBE_IPSEC_KEY_BITS / 8;
> -       xs->aead = kzalloc(aead_len, GFP_KERNEL);
> +       xs->aead = kzalloc(aead_len, GFP_ATOMIC);
>          if (unlikely(!xs->aead)) {
>                  err = -ENOMEM;
>                  goto err_xs;
> 
> base-commit: 9b23fceb4158a3636ce4a2bda28ab03dcfa6a26f
> --
> 2.43.0
> 

