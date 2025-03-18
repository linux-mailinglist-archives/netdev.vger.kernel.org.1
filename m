Return-Path: <netdev+bounces-175630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AFCA66F52
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4733A9220
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A51F63E1;
	Tue, 18 Mar 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aHMffOZu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC242745C;
	Tue, 18 Mar 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289005; cv=fail; b=Bflh1GBZ7W49KjI1bxO00is+9Jb+LNcfWRet23N9fEYhV0mpi7CwnEniq2DWV1jkwU47Q4K+8b0Fz9hsiczY5/Q0SbPS1MSFiBY+UEONEThp2p9BUacd5+tal2xm4rvcdvjMOiAhws/U0UFz7VqhZsoPYJjeOfdYzqpwyMznd24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289005; c=relaxed/simple;
	bh=0m16I20tv8oerk14HCKvKYnTjaIAqqAdDKsd3inJ8iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HmpN8ztZdttSuOhiWzXLVzr7ccBD66BvxLUgqHXD3jLngNAzqp+7s2Mfb0mO0Y8MZZ1ceg1DxSBo7C7XiBmi47dWiw624pqCcJB+tJkp8HspcyppuERHYlbsKYrvL5VxaMgCY5CdBAJE9pKyhiKvGUkUjARBx9w/ahq23OaALoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aHMffOZu; arc=fail smtp.client-ip=40.107.212.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkXhRWsyOmtlXFEbnTPqKuJ7sDU7ZZdsstlfbFaG4MGEY5wH6FhH+HQwCq2x9Ee3ZIc9Pn4ZESG5BS1+V5OL0vAVbW7ydZ3OCzqUBs/0FUa1hmuSIjpvjyeQtpCihHWoXsEzdz/4FZJyou8KaVaJ27k1mLoYddTE2RPO7+b80JmyOpHx+xoamPw/K9xaw6s9/hyEeGQOqNjmFomXiTWF/DLW8UG9V+vAxU7nXUPJXQ7HM5qifWU6p3L+hgKopq4Xz6Qrvzt5a1HtPt15KVG+Hl+NheRUR7NUXppr4TZh7Z1a6LW1L/7xTm6lzr04im61GxSq25Nz7V1DcHRZx7uqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp++TXSarI9372V+OPS1ZE80Igf3pKT+Vc+zSv81pT0=;
 b=SRNDK+kDI+liVnStF+BkepXQtUu1FA+/KYfKHWaSY2JVvDLTL7hQC+P8Lm+vTLOi0xVI234q65B/CFp7U9NgFMhCALxOZ6YdeNx5vXdUuYoxQ+C+wGzH6k60Y41Ji0R6dnoouUFsX+JKCx1h0k72iCrBSZvT7/B5TmveVrcIxnL7auGaZweCjFDSt1xhDj/Dm57qz+F4tYiWqNvdMgaR9JsqUHH9XQqxv7CWpTsRRBmhTkBuffW+Do8C7sX4RiJ/4J2g3/y77OiRO0Jfj5PtivBHIUJ8MdT23EyJvFzj+EhcVtRSJ/5AjkL+W+bYw8bsleeSW6lQ7RWwWFYuY2jIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp++TXSarI9372V+OPS1ZE80Igf3pKT+Vc+zSv81pT0=;
 b=aHMffOZuIyFzJtcBX4KwXmbDR5rvBbgd6fAyborCndnXU3W0wgCW9vzO1av//4cPJIiVTm/CFRoXPSFUTvA60DdifrHNarzuoJdf+vGDXlXuVerDWweyShNvvXBlwF5+/aamjYzbcCR7X+WdWvjdA0obdLkUZSqsR+SNRK7qA1tO0pXH9x0lNkVs0WqAf9DXpx3Q5rwXBOAMi3S7a4v9C78lxLE+VRxYGlhzkN1PckXntgkuWALJsDUiyNdxX+8cJChLEFc3HpGdii1U6vrk3WgWqSk9UNlCKLPF0zONRaRU8x7BFilyaKcFLXJs2QXqy1LgzLlfSC8z2BK+SqnWHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:10:00 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:10:00 +0000
Date: Tue, 18 Mar 2025 11:09:49 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: petrm@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	czj2441@163.com, zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com
Subject: Re: [PATCH net v2] mlxsw: spectrum_acl_bloom_filter: Workaround for
 some LLVM versions
Message-ID: <Z9k4XQUDEKPHHI5k@shredder>
References: <CBD5806B120ADEEE+20250318054803.462085-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBD5806B120ADEEE+20250318054803.462085-1-wangyuli@uniontech.com>
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 63779231-5d1c-43f9-e987-08dd65fca91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FV2a0QkITGbU3bTaFr3DHTPStXfdhHMlM9t7S/dNJ2mBhthhgUGgPWoU9ONT?=
 =?us-ascii?Q?pks7de7WtAVgnil2uFP/88KoZD2duaED8JyxKr86Jm0GHZFaTBroXWlfAOzj?=
 =?us-ascii?Q?Q2gUTG97QdQ0OkbQe20tPTuNb+hYwZ1MH8/SE8eDVIKWcC8fzzyvWuofUKhq?=
 =?us-ascii?Q?vdGfVIwEOehPSQF8IKGAp7dSF/Ly2xIfti3C1kp0+okpL3jx2ptk5rVqvpQm?=
 =?us-ascii?Q?2wE+yJy5WIR0jnURBcr+V3BTYNYwuIHKHzNRNjAwy+c1pqYUyv7HL51EbyUl?=
 =?us-ascii?Q?hXXoTYcNHiChKKrDW5bOj+0mA3j2UaQFExrftwxwcIf42kvJ9qpf4tIvkPCb?=
 =?us-ascii?Q?IiMbag165JsRY3OCWTuaLt4luiD9N+/RQyFcSAEe114U8SEQBdMeRNAhcUNA?=
 =?us-ascii?Q?VPFj05KdXau/K12T5ugMe2VJBi7wJXPK9y0pavUrX8oohuLQCeNe2LJGQeGe?=
 =?us-ascii?Q?PWxr1NbRCT6/8nkajBcgt2WPQQOSx3V6IPmHDPsXj29bP6CKV37HnsJRl9bn?=
 =?us-ascii?Q?8CCJkt1hLbEPBQiXpwXTqgl9tIH6acPrr9G+0PFKMcv+7C9FXaXx4bMCShHi?=
 =?us-ascii?Q?JP+1V0/Go+22WIGI7SxyYI+Sg5TLlBANeXRY+v62Pho5QMrVSM8hIDpYGyGz?=
 =?us-ascii?Q?YKH0sMzW8eMRO2bi7VE2HmW1sgua0VJAVOSTAELxvZIF6+QUl2rR3paMJjHy?=
 =?us-ascii?Q?7KJbRjnDXaHW4jbbOR1OXVuq56bx1z/fAH1XsZve+/JAdlHpxEi2Km+Z1knN?=
 =?us-ascii?Q?FnMb0YXBLcu3JZCOI1xu5JRLQsGVxMMz1O/0CSh/w9oAg/IXJ4m5BMpYa0l0?=
 =?us-ascii?Q?m/Q15EK+Dbe5GZ7Jho2Ffr1+0eIaM/ypIGSpEyFX96xj7AH192vzzC3GP/G7?=
 =?us-ascii?Q?a7PdBAq8CoyzJaA1v336B856kYGcCkMxANvWHdd+vKi6/vaOswvZNkSS1G03?=
 =?us-ascii?Q?s3wknj1A9oIhNKk5mmeph4RfZjGEbzXmFXGRFnKIlVskF62ozh0zUP48X2v3?=
 =?us-ascii?Q?2ww+fKzXnZAI9nbYX0xEiv5nqdYhn/F/6DKcUzyNw34l86TzzlgKD101c+rl?=
 =?us-ascii?Q?oHMmV5CK3OSVyCtSaYiko2nHqCbtCGzWYSviP7ctPTyT0izrwev2wZsBUCny?=
 =?us-ascii?Q?JaJK0WZd344HjW7/XjY6+bVHcXeouKKHu1/MNMT3g5jbifN0fNCJXp63wLiT?=
 =?us-ascii?Q?vkofj98oClWjjDp+xhZ87H2zvtw/8LDHmfpJ0Tc4F291IxUmUxegZdypPo1I?=
 =?us-ascii?Q?oBXeEYa877J2mjhtScqk6/mvle+KifPkTLK+FnQCtWPFJUyq9wkRQLk59wR6?=
 =?us-ascii?Q?plfqiXaaqmADW/znXOgxkMkJr2hsfo/3hvo4WilSKrEonOjDN/gipwvhPZW9?=
 =?us-ascii?Q?3REAum5KTxqfWn1iu6s3Tr7yv05P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G7pFG1tTqk3b08TTI151l6OIUXb3JOBjKipDq9EmXnxmI8eRkzeOX/iAEwHg?=
 =?us-ascii?Q?hYXdpFLTcrKiO/5BppNChgG3H7QYyBggl1dmtzFsrBocpF4wbMr4rfbmUq9K?=
 =?us-ascii?Q?zI54ZvQhoCSf2ElW/xgW8wjBpb8dwS1ZdgCrpJeoBlNZsWsg6u126M+q20ex?=
 =?us-ascii?Q?5TJV4Rd9iWnVpR33gYpyXcso3DTqy4vFcj5893040cplT1hxWgZNvBhQ5Tpz?=
 =?us-ascii?Q?cjv+YR7nuU0DGiZbHA2BQdt+1I3GzC5thph7UdiGuCQago6c2eqPCevBPd02?=
 =?us-ascii?Q?x3LK1MiHKbHqexCWmxvxWX1RsiTE7VL7w5S3n1vf6NkwmgUKKeAR+j0gJYqe?=
 =?us-ascii?Q?7RbBR5GCPD+i5LrDqp/ikeqzik/DxP2asEVypVcGkJATtP6Cxltttfu2SG0t?=
 =?us-ascii?Q?CoHvU026+0ytpnOgjBkC1XAvKYv1K5JQRtv5UEGIT856IjJgT91FN/aA6u0f?=
 =?us-ascii?Q?1ofN32u9xu7o+ygrrOmtEh8QCkNmstxC+hXlgBAjvwmxnSaFp7NJJR0uKWPF?=
 =?us-ascii?Q?c9Phc7rWpyNMWYJqOOTNk/kNVBy2b6CKBNU5UZr6I2IPcki9CYgo3CgKXsXc?=
 =?us-ascii?Q?sUw+cOvNPoYF4sQzRYegVPo3+YL2oJqjZGkyTgTr+7+95ym0MRZdTxsKYfls?=
 =?us-ascii?Q?0Zv8Zy9uy9wkscgPIqoV7FahZBlNF5+BcqpewEBEWEhBgt4Cgbi06XR1CpcP?=
 =?us-ascii?Q?jb41H1wkDpXceSuHqWvHRdxd64lJmoVf+7n4W5OHaGHFoB3V+6UK9cZ3X4/y?=
 =?us-ascii?Q?0B/Gj+xb388vfVA8XOvm187CU2HkFXHZ7ICkWXsC4wMtl3eiYYROyEzrhjGN?=
 =?us-ascii?Q?/+ybRJ+IM2GFH0pyVIyO+WQcGa2irQ1E0Jw5BLtoaKVfhrPsdGgomWbtJhxx?=
 =?us-ascii?Q?xlLRh2y7Ei+NygZyfwG0XEkgQa9CDhLzADiVQpQHsWlqOLDYSnZRqNwaaoDb?=
 =?us-ascii?Q?XjPlnoEEym1V7xkjhOxXYZkJPxW7Q9kLq4Hqxcw2rbeK79Zq9fCfD+rUdKAY?=
 =?us-ascii?Q?OQ+Hayuhup1UG6eJAhr5dogiYOfT6CMR8W7ymbB9b+8+WXFWDu1Pl5HPubrW?=
 =?us-ascii?Q?HfbeZkYMhFpevVuI+zQNVCojUTdnVLlU1XsJ9PcviXJkEpWzJKFcFWR65hdL?=
 =?us-ascii?Q?YC0mq3gGK3XXJ4UxHbN2HKajK2ZLTfUyDt40mwvXqaL4WeyemwZFLoGMUWTA?=
 =?us-ascii?Q?Z2SPbBn7XuHVA1QAIGGsS4M1IZyVK1Nm90vYdSy1T4tLS032dKnqis1iAtJO?=
 =?us-ascii?Q?UQkjSGZJ1vMq4t5IfdP3RNvi3zBY07HUhzgMNmkVt2KL7yv2Bxg9BU5HQc6N?=
 =?us-ascii?Q?pZ7/CtzUtLKpV2QWdC6YXEaQoJU7BoexBx19qoKB/Ee6YDHnJ6+m+oegUI2i?=
 =?us-ascii?Q?frSeKJEMgR0hsSzJ9SVqB8XOJoCHuFn5+BHkhXFN8wjfPMs/BIA4gZjGYOZO?=
 =?us-ascii?Q?o0AfO5++jLCb1+z+MtuR9BRQ6Du+U64V5YDjeW+MXgDnyLdMM767CvIPqJ95?=
 =?us-ascii?Q?tJp9G4AUkYjLAQ2gfC47so4VNAfWCNVWCy1Xj3NsGQyMPZZs4mUZweqLcQ12?=
 =?us-ascii?Q?5BB/AgRBin90Ld9nqqzlogp4+kdqM/g8cMpPj8+i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63779231-5d1c-43f9-e987-08dd65fca91c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:10:00.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6rtc9BOVQmVREkDpay66uUhq4/Iagvilxnfh4002UPUyR5/SF0iYmwLdjgcq8rI3h2UzWr8ecE0LNfkpMSbIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194

On Tue, Mar 18, 2025 at 01:48:03PM +0800, WangYuli wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> index a54eedb69a3f..fc8a8cf64ec8 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> @@ -212,7 +212,22 @@ static const u8 mlxsw_sp4_acl_bf_crc6_tab[256] = {
>   * This array defines key offsets for easy access when copying key blocks from
>   * entry key to Bloom filter chunk.
>   */
> -static const u8 chunk_key_offsets[MLXSW_BLOOM_KEY_CHUNKS] = {2, 20, 38};
> +static char *
> +mlxsw_sp_acl_bf_enc_key_get(struct mlxsw_sp_acl_atcam_entry *aentry,
> +			    u8 chunk_index)
> +{
> +		switch (chunk_index) {

There's an extra indentation level here. It's not present in the patch I
shared.

[1] https://lore.kernel.org/all/Z9M1A8lOuXE4UkyR@shredder/

> +		case 0:
> +			return &aentry->ht_key.enc_key[2];
> +		case 1:
> +			return &aentry->ht_key.enc_key[20];
> +		case 2:
> +			return &aentry->ht_key.enc_key[38];
> +		default:
> +			WARN_ON_ONCE(1);
> +			return &aentry->ht_key.enc_key[0];
> +		}
> +}
>  
>  static u16 mlxsw_sp2_acl_bf_crc16_byte(u16 crc, u8 c)
>  {
> @@ -235,9 +250,10 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
>  			     u8 key_offset, u8 chunk_key_len, u8 chunk_len)
>  {
>  	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
> -	u8 chunk_index, chunk_count, block_count;
> +	u8 chunk_index, chunk_count;
>  	char *chunk = output;
>  	__be16 erp_region_id;
> +	u32 block_count;
>  
>  	block_count = mlxsw_afk_key_info_blocks_count_get(key_info);
>  	chunk_count = 1 + ((block_count - 1) >> 2);
> @@ -245,12 +261,12 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
>  				   (aregion->region->id << 4));
>  	for (chunk_index = max_chunks - chunk_count; chunk_index < max_chunks;
>  	     chunk_index++) {
> +		char *enc_key;

Missing blank line here between variable declaration and code (see [1]).

>  		memset(chunk, 0, pad_bytes);
>  		memcpy(chunk + pad_bytes, &erp_region_id,
>  		       sizeof(erp_region_id));
> -		memcpy(chunk + key_offset,
> -		       &aentry->ht_key.enc_key[chunk_key_offsets[chunk_index]],
> -		       chunk_key_len);
> +		enc_key = mlxsw_sp_acl_bf_enc_key_get(aentry, chunk_index);
> +		memcpy(chunk + key_offset, enc_key, chunk_key_len);
>  		chunk += chunk_len;
>  	}
>  	*len = chunk_count * chunk_len;
> -- 
> 2.49.0
> 

