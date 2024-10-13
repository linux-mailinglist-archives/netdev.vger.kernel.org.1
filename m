Return-Path: <netdev+bounces-134923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6799B923
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 13:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8FA281E8C
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A413AD26;
	Sun, 13 Oct 2024 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ToKkoKRV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E44086A;
	Sun, 13 Oct 2024 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728817566; cv=fail; b=YWfAxdvYWQFzASf3p3+YjJCXYQgK8p+lCOgc3EuYJscfUcdqbNbrUrVw/2QQSGB4GkZrQ06lwXzckPvJuL7qRIVsamPqBNv/X5FQbGrI1asNswXzxRxR8ol5V1MAPznDCYYCiuNPnDlCgLnWQ5Hk2305tPtwLiTYN2Ld/cW1Mp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728817566; c=relaxed/simple;
	bh=2/XSu/wMBIDmgs/Luogmdpuwp+h4rI3FpUV56Bl0ir0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pkzxht/DZapB0jiKpKF5mMTE/c0Ws89y5BieH1PURuIobhthoidcnwjtedR/+4Q/NEC6e6+PUTAs4PXT9y6Wdsb8ectt+VRPZgYd4Yw3yhjIkJ5+fx3uEgyGQFTNc4eCi6pRS3WbEEiGIPYCSAVu4Ba2dkgczWTsclIj0Lolifw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ToKkoKRV; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZMs/jihb4v50zmfAG1pZ1pvGzifUBkjpyNDoWg32CdHs5sL+8WBvNH5PNdcNgc1itj++DRHnMjmCfzTCLyaHmTvNgeg3AaiWj0+dV/m98u2VoTn7ZZu6/pXghgr6CAtwVCSE0x/yaHM8uM+cED1PU0isGus3Y+D7hawEFPiBAciXR9vNXyNDW6PT90Pr1jBwELqSI6Y5riOvbM23wQnRX/tlX+prlFBlh7qQmtI7Pm1k4f8VXAg/grqGSMG+5QwTEvmb/7f/rEosxHDSyDyIMZkiAcO/YrP/yyaboV9TY5KguuaFxpxGtPdnD0uk8xKY+ld+TJhnHYOT6fylscEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xONuipOBpUf3UXaMfky5ppTz+MUlLerS13R1I7Byz7E=;
 b=LAREmj0V+GS9iEBE+ipRk9tXkivEC4WcBusJiUCL0vjuBILIotI+vnR9Jl8MwgS5vRYSHdE5UtzREYPNTkVsda6UP+na2PXEDhKPw5TUHJmaHPDqqpKuDEfshZ4dPiQr5Ug5M/ATATFTM8/UDAQoR6DChqzEs8h/49E5yGANhync6BNPeWSnLdh7K/YCaAThRb83fq2uU78JmhcbO8sLCOIkOvOXUiWHpdSLrS0rQ/QdZZnCVuxbtGPX7wicHsWUwESX3KUJpcj6vdA8mWeNJUq5ahWiB/zhKv5pQjYndOpiXCX96qTR/Ezo+IcyWmc6BUD7Gj4xiYLr3efR9ODx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xONuipOBpUf3UXaMfky5ppTz+MUlLerS13R1I7Byz7E=;
 b=ToKkoKRVvPW2Erd4QyLlLYBQWEtg9Jz7U1lksdpu0mwcQvDPf9g7S3ns8kAfDP3LmpF24VOi0HX/eGzvPR3sCGOfxPuy1bC6mRUwT8HTzu7igHpX2gkWj0e2Dwpi9vBP2LZbr4J8AVqF5RV8HiIcHoH6h8HD7h3ILfhvxdSN9m574oZT18uNstaqmBN3tyZu+fy4wl2FkBtv90cPJRMNA1K9Ak7YfTlFzgqS3/nB0QdgfpZPO0+iXsL1rSGV7/EvLMdamPmzRMltXzxgNK0FnyDcUCt6NPEjHUDprp95EI8p4MvlQKHZQMU/9II4DApZXEKVBfce847Bq123KUn3Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Sun, 13 Oct
 2024 11:05:58 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 11:05:58 +0000
Date: Sun, 13 Oct 2024 14:05:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 04/12] net: vxlan: add skb drop reasons to
 vxlan_rcv()
Message-ID: <Zwupje6J2_M0Yvj4@shredder.mtl.com>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-5-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009022830.83949-5-dongml2@chinatelecom.cn>
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 894573eb-3d8c-4150-c594-08dceb77040a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dnx61f7HSWGZPU67oE4Eo9jl0d6uLjZbZaSAU601CmTH7O/uVT4M80EUFXba?=
 =?us-ascii?Q?ttEXHMK2pRTi2BJRSQT3Jppu2RW/NfWzugByycxnN4h59EGmK2y2e8O7Tr/y?=
 =?us-ascii?Q?I/Hju929s5AgAvUKt9Rm50Z4y5+B9Qqom/L4D10ltzLJGDxFHrIW08fqSiq5?=
 =?us-ascii?Q?yjQVEo42Qhdk4onKymDzucjF74ez5VFU2VlnVWUme1q6RCJHA67biwt8LaGO?=
 =?us-ascii?Q?Tm8vyYraOutofva+ggXS9Z8laRjG+X1yNr1EOB4NB2NH5AmNdRE9Ogb0/x9p?=
 =?us-ascii?Q?WTMwvdcPitYjxzMwRBhowWwi2I+6xWRRBFrr23AwbsS+MRSO8uPBsZDpo4hk?=
 =?us-ascii?Q?Nuwys5uDWZ34dgN2DEoXJV1dopXDP4SmA72VzH4mT/u/k2RNRzAF2d9shjJJ?=
 =?us-ascii?Q?6klB61InCowJxlkHd90iHqj8HZ7QFsAVFZi7I/M/BtzU3ycBjYSrHS4GH+4V?=
 =?us-ascii?Q?8sIeZ5oLjMIHe1pQDLGOjnOuzEu7FaVJBzZmTKarStEjyU8v2bMfwypIxtiq?=
 =?us-ascii?Q?TqUrrzjjRPgWArxt02CDQ+1mR8oohPCc3BPwe42aQPy5tfIIM/mJ4dQhWF/I?=
 =?us-ascii?Q?H+gpMOrhTQJBEv6ETyb5yvtae5wRH+LZwUaoycOrYScLZnFIbmbUBL57exY1?=
 =?us-ascii?Q?rDiMxXkjBHg/1RwTUJpMwtxVyHEV1GrTJ+taAOyE6dGXT/HJ4HMkI8qDdgUR?=
 =?us-ascii?Q?kY0nF8XJE3Z7+us7AqfJC6YDq+uWOJfF15+gfYIlASr3kmoiZH+yR0fnTX4o?=
 =?us-ascii?Q?qgDvEIMbkFnqXDr/ZWdxhLWq/43ezgj3GrH4nxNSWAbZ9gWtWS/fGXtH2edk?=
 =?us-ascii?Q?mZM4cUZe4gvBuY1o8iKBovUGOQ4iuZjkgmn9qFFtdoaW3mHawnzD3MNCv1YL?=
 =?us-ascii?Q?2+yzV3iKqeoyaFIS1G4W2AxmawjRYtX/LLegB/2R4e2DNnOiObnJllvnX2E1?=
 =?us-ascii?Q?eC6l11LO1Rc+VVn7k1Fu8apKOuL47TYqHrFYGRBA6U2l087bjQP9dIi78Kli?=
 =?us-ascii?Q?eoiRQ9mlBgdZ0UBjXUfqxUL2W7hGySJhdvN77r3u7Ap4xXS92NYiEG4YyY3x?=
 =?us-ascii?Q?TmjsWzw1QNsKUTSHIlx3e0VtU1vedAusTcGLRKn/eJw3KhwMZKCIXIxtOYyi?=
 =?us-ascii?Q?A7uUXaiLDu7mb9gjV9ZPWqLb9wRQ0yK/AUcvzf0nKxKSyeDuf87aNA76WFJS?=
 =?us-ascii?Q?Ti1B0SA/wOJ9BR7TNRHiub30NITOGNmpQ+F8rQwhRVSOSaFP1UGKTgznOS10?=
 =?us-ascii?Q?R0ceY3DWh44dRoo7A1lyKznt7Zs43CCrsRAnWM6r0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kacy9R0lpXe1Why56j/FmGXXbkGikVRPRQQhbgDj2010G80RNzVz4o9yYgkB?=
 =?us-ascii?Q?TYNsg8Cpzagi5sxXVnzIEBiNwpKWUx9LTdPMk/5DORPkFQIsLUvuS2D8i8oE?=
 =?us-ascii?Q?40wPzxXfXOSlvlfBFAeIZPyd1hiMY8qCzlBb4uP5alrXwo9ZTzYrN3MqpD04?=
 =?us-ascii?Q?Iv35l40qshI78uga0UzlJIyw3hdXj3QcCGpNGHIeaW5T347ivIJ6PV7sUzkC?=
 =?us-ascii?Q?vFhc6EH+FbN4NaSCgko/KwDItLWIXnPC7v5GFsmzJNG82s6w0Y6rlSi9NxId?=
 =?us-ascii?Q?2PrXZVjsBG7CkjtGPdYajD4QGyJYPjF0aoMwmst2GijDMGTGhqebV8ShTmub?=
 =?us-ascii?Q?IC6VzGZhwKLCRNPzN8kyYd4kK/Geb7Aw+zI271KIzOpLftnvphlwJLo++iYT?=
 =?us-ascii?Q?t0CRFTvGru/M5lizpUL6uerg2F1Ei9oRsjyJMHiZOtBi7v0sa6sdEF+UaLYV?=
 =?us-ascii?Q?m1Z2/RM0VHDX1r2itJiixUTPcgn8pwGCLf1wgw9jDeTLbndXumS/2QDcLmha?=
 =?us-ascii?Q?kTh98WB8LQ+kXgGpcVsFb9HmOpEhdxDBNRlI3Taglha+HGxYrbcLtHujXeAp?=
 =?us-ascii?Q?gZ6H1N9GfRicDvttmf6MiN+5l9vawO+H5bvRtvWLl/AJ+2CrNFYvXlalbRbd?=
 =?us-ascii?Q?pB/8wJE1dRar9OejqNKMg/6UBTIWFKeOltNzoEQ1LYE+eBkch/ONK4JmrLyW?=
 =?us-ascii?Q?rkhd0u6ufuNrf9/nfJW9KvEY19Wnp4TpnaLcR3MtNvf+8XiwHm+M7Qzmq3n5?=
 =?us-ascii?Q?3Uf4Mj0nHJECyaf9TxJ4HPnkwAEFmrSJypiqb8YKW9GgHOBUW08wWVV5vFjy?=
 =?us-ascii?Q?HdUVOjAIhsZlLxg/kuYL4mR0qoqPlwlnFl7ftyHh7K5Q25n9HHUhxYT106UR?=
 =?us-ascii?Q?9NNyCL9HCwu2ooMqqnYBrOMTiqHnGKkIkrfW36bDO5IRhY9UPw0p2gZ9jJ+R?=
 =?us-ascii?Q?wqTdFgHpzeyaON6ZDnclrNXBidjUzC9tmwGSr1onm2xci6I0PwN2ltqEa3mz?=
 =?us-ascii?Q?X7XasR3xmD7Rl6yOdfAp4IbY9eA70ugKRIgbWcItKAWwD1MRsFJoIteWdckf?=
 =?us-ascii?Q?z725ZSlBlzlvAfl8KB4H9iKghGm/eCL+G2TZiPpAbhgW4+TYoNM6l7MKQizq?=
 =?us-ascii?Q?+5+gVPNlLQUU51CmDjL85BAeycVkGnTzDK7y1yod5vgsz7uXHUrKR50BHjSC?=
 =?us-ascii?Q?lIdA+bCWlN3N7jsDYBlCZv4FoJQAcm9SUxpNsCNIFKfdtouctX9zFRjAoYpf?=
 =?us-ascii?Q?tedamBpd9G3aqKQ+UNixnSzb8RDps4XqT1nv95uVVsGtq9kAxeaDiSQdHsG5?=
 =?us-ascii?Q?KCxOiNa5Ue6zyltBDSULnzTMfmjjyEzTP6Yf3azWZyu6yobdlhNyaXFzFugR?=
 =?us-ascii?Q?fJDNmbupgk/zcl5D8HQhrAM88iMWK6k9N7ZRC5YofmTvhDhWhUSEJwGI/8U0?=
 =?us-ascii?Q?ohAUrOSiSZ7Dl5YOymV0XPWwC/qDPKLVUYp0aodq6guogbVpeNhIVGME6if2?=
 =?us-ascii?Q?0frBa9gDFAuWKdMwDcwVVYemMCopXBejCcu4nOK21ic0SPboQaWzUXVS+Mvk?=
 =?us-ascii?Q?tJ0LVq6CAnWs+Bm14ZCEN+WIWdZn1amCfucAEKoh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894573eb-3d8c-4150-c594-08dceb77040a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 11:05:58.3394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3VLOobxeIyQg2sDUDmJ/0TyS+kaHJemmRPj0g87PV/iXVoZN4stZj3JTou+jbk8EvPHHxZtLppYFQGVzKfiFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989

On Wed, Oct 09, 2024 at 10:28:22AM +0800, Menglong Dong wrote:
> Introduce skb drop reasons to the function vxlan_rcv(). Following new
> drop reasons are added:
> 
>   SKB_DROP_REASON_VXLAN_INVALID_HDR
>   SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND
>   SKB_DROP_REASON_IP_TUNNEL_ECN
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

