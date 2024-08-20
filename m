Return-Path: <netdev+bounces-120133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052819586D8
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F451C210FA
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EBE18FC89;
	Tue, 20 Aug 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yjwodawr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47718A6BC;
	Tue, 20 Aug 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156702; cv=fail; b=K44snJulU+3TzfDtrr0se/az/RoHOAcNnXHuKUmFw+wem0XWVYB82KPP50TOlT4u3dnY952Jx0cgjKFLvMUItFa767WEe3oIwrH+3UfBTG6pzjrz24jQZClRZUHQRjK65YIXR+MW1XjEOA8IB+6uoKk6mlMQu8iHB79WxjNDrSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156702; c=relaxed/simple;
	bh=a/GrVtZPOUWw6jR88qUoywjlijLd1DxTi7euhnVboqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WuenXc526T1z06ywxEB4b6o1eDaBLE6rol/15cLG3KKZ1yKKkpl6Mqfyhc4VZRsm0EO8tvPo6Dp1n3rDA8igB7t8fbJkhozSszlM2sQJKiLCuDI+SAzf2PGtyjoObsFiS3zoeCc5BqWO2eb4eio6PJFaFTrK33DZkkX+WAoa3x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yjwodawr; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3IFb4MW3SOblVFZ1QRhBu97AxhbPHqnUlfQDLNEEs9gAFqAdbyLv2nXfukz7u6+E+Qiy+Rul0WowzNzHjd25RphMpzHUKBmfWWYnPefkk31qyHwgMsklqKVPLR2L1mnwst5eIxWTJu550S90rzJ1nasZeojgkN1KUpml5JG3X4buzT/Sv4sDo7FyXXNcm0SOT0+IuDMJZj6PK/RpCybvGmducBGibbxIksoniwfbpJKQr2wVtd69BC4GrELm5fybwseZ+4q79f4hpn2tkqVMbn7z7UcF5XxIo73463b6kPnaNbuAsifXheuraWcSompMdz4a08fCYdLG69pgiGkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfxBISUtdvP+4sZ+24t+oEmelBZk+FIml+egaKW182w=;
 b=iB/FTmgLVga5sTj7VEcJitD7KEh5jWvRmqVlsFgEbLgI8bnGy+PvqChWqaQWc7qrXOLeQRwnjj64TJrj9RPqXSDWaXF5tbCS7GKlsO/JbgZHGwXlO4DSC77NKULC6jbOeKxGx/bs6gZyhJRv2QtCGhyEESB9I+3B8SLAsvz3CxFfSzWZkSKuQyLXfEhd60YJXIWDBEQMCZKvmOqAsojgRsjJuQ8+wa5rP8eFS06f2Zkayk1Va/dzExOFod3XeSE2oDtf5Y5Xg2gErNv/ikNroyGFXQXaVO+nuWEZKqOQ51+sR9370M11KjAaOXzj2brG1tOFbEevPbxd7Ep1qcPwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfxBISUtdvP+4sZ+24t+oEmelBZk+FIml+egaKW182w=;
 b=YjwodawrZ4bhuZBjHWDxfdcavba1OpAh+CG9X9ysOFZkbEbLVygu5IvwOqa5FyZ8sMewbB2cQEvjuxTRAjrEAcctW5vHYPT9IuAO0qpE60TL8j7DXJJ3fTUJZWIQKoS3rMA7WgzTTKqlKyinsDtCfP2BbCeXkqNqRspFsxytbioIJ+vOmRYXhSgEtslyEYdNj9bWpSPN73xAmG2B8xK7mlgu3LMjA8B4D4NGSXPU1Hf80bVOq12k522mKsWoiirbQ7wwhS+J3RgtxAAHXaLEXyk0DdDVkWBD9aeJA7fXwr196Zob7eqYIUgXdTJaAOXBbGLUY+ZtWu+1uPQypS5Rdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 12:24:51 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 12:24:51 +0000
Date: Tue, 20 Aug 2024 15:24:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn,
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com,
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 02/10] net: skb: add SKB_DR_RESET
Message-ID: <ZsSLB8pJInb7xbEc@shredder.mtl.com>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
 <20240815124302.982711-3-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815124302.982711-3-dongml2@chinatelecom.cn>
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 632adcd1-d0e5-428c-4faf-08dcc1131700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LJ9EtD8r0Du+azoqKIsPCKqQWTH2xU9SXPFFOIbwsBGC+Qb/gZeldNHVqsMr?=
 =?us-ascii?Q?hOAibq3x2/JbE57hRjHA7iEoEvfIUiv0vSKcR5d9xEcWHiwDjIWbHHx3VJdh?=
 =?us-ascii?Q?5sHg6HYagPjbNrirSDelkQ7x29HUorCYlw4EyaCnn3vGgHlhUE2Mu6ZrWgUL?=
 =?us-ascii?Q?HWXiS5vUCPad9ozcD4mcMVtjduNSSL+NAhEUzf3Ixk+4534fvFOnF7C2kLUE?=
 =?us-ascii?Q?myUdzzdxwD4C9DjqNC4ymxVa4aRTNsCfCeEazzS/NbhD8XqLfPCkqSVbifAB?=
 =?us-ascii?Q?Nz/gnhyoGKr27V/VXK7/9HPq2A5Sg9FttLKccG6msmEa6XQQ9AYq4bPhpErR?=
 =?us-ascii?Q?P2dAV5JBCCDgQaeUajlSyKXBTcSgFtXCmV0742u3xoJEutPmJ4bcAD16sl0z?=
 =?us-ascii?Q?k6+d89hTIXchLs6KyjIAuyN4lCyLjI3yIfxqbQJdtyrbVAfkJ5f33L/dDNBC?=
 =?us-ascii?Q?a+weAVT0GsIYuO3i6q607sRFL2E/ebKFvVyCEi1iFyPt2ZmUAnaw+PtLxNHn?=
 =?us-ascii?Q?qVu+2mGwMAykl+FkBzj0qnJ6uyvyB1RqfFqqW9hT+1wf/QXQ5e7U/uBzzNzO?=
 =?us-ascii?Q?g7maE98oTcwAv0xFcd5Ewdcdp7i90XTGeqyNkxsTNOB6BnZXNYAeCRETwCTD?=
 =?us-ascii?Q?5/wJcDJbMniIs95SD2qqxn3XXvFpZpk9eKHEEI2Z9Qv25FCHrC1AOvCjMbsE?=
 =?us-ascii?Q?i38HbdmV/QIXhKxYiZZpMAZ8Unm6mBe9t8uigrN9R0u2FHcadm5WW9XzlLq/?=
 =?us-ascii?Q?C/iWeKAOORqCNl2um6VcXcDm4LbJURruV07NjifOs3/wRwMuME4+GvoEA+No?=
 =?us-ascii?Q?H0YB2mNr9msxLMda2Up/On3WoS1uBBBVc1LDGHYisHeEb1UCHa/1DsOlHwf5?=
 =?us-ascii?Q?eI8Y7L3YxyPHh1wV9CIhNxikr3yk7CV3QdIA7UFb+Ajk1O7oQuIyKOqkGs7Z?=
 =?us-ascii?Q?LFtcLpSnIR05V0mGSVRuvIg2lyHWTQE9Ya+iOGqL/ggC5TsCfMRNRHPfpWaZ?=
 =?us-ascii?Q?zm7D5jIgCVzuz16n8bGQdRd77MvYMNN8Wt9ZvHBwVxvr5eP2nbFu6mGTt66O?=
 =?us-ascii?Q?JDABoBgQVl8v5kOhI7WqU1mzcAcbAktO44TOcDvyq89JJYo0HwyVxA3BL2Z+?=
 =?us-ascii?Q?u4GW5RQa7p/dekAGwad8Z2++aJuNjNBZe4XmCaC2HAbZnaQN9dMj0pB0xS6u?=
 =?us-ascii?Q?kIU4qyD8r16R/YIAjagG88ds/agoU/NjGTN2An9LzgzocPiZPua0xcr4q38y?=
 =?us-ascii?Q?olOpI1oPxLQV5NJsiBv0n2ZAzxm1+WDgmW4F7VQYCFTKVZS0k27WEW45WqB1?=
 =?us-ascii?Q?XUoFQ7J6M5Z+8Vr5TFFSu8brhf95vDRO/A+8LEsK32RljA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?njL1OTYGTN/KysvIekypVHea/vx9oLXYzm28OAwvhHWRt9IThF0W10Q+Vn9V?=
 =?us-ascii?Q?iX2AyHeMPAsTT3VbEgzTJHnWZEFxEkZt571SEgTLKgKEWNPbL8VGLhonAJ3G?=
 =?us-ascii?Q?GCDkgDN6ttNgbul+/BA8Y8xJpgHWPJy/UMzUBxcfaJwIV4zw1hJyoeRuuFRW?=
 =?us-ascii?Q?X0LXkna/nu4WoX5930iocMkyyV/1v+Ym4t1+YxkOPoC4KIIOEnOuzHMPCrdg?=
 =?us-ascii?Q?A9GmYBifjoSKZrmse5hC2v0tepeHVqTNAg1EaNdgIskBbMhselMaq1ptfZxG?=
 =?us-ascii?Q?xzrZ7nc0YQG0c7bLeyOloasubMrlkTJPw7RLmNvaOr2+Xx/llwJOiIdiRCda?=
 =?us-ascii?Q?fr37ak+BWQSVq9MgElC21UD8TxfZrh+pc/Xc53bxyLcP3qgJy87NkZYmDWFU?=
 =?us-ascii?Q?5WMJrirfMPfS9THEM4vQ/2hJEl0Iyby86waQyrBUbek0eNdAuPoB5UUsKc5F?=
 =?us-ascii?Q?VCkR/4ivUXqaYlM3C3+BNXkG4cYza5YDNfW6DCZWsGZSP84Dqt5+6SVvtLfQ?=
 =?us-ascii?Q?J0r7qZji11iSU2SJi8lc4V7Iad8vcjN4m6thIQWT7odIGhBZ2d00fmtrB2b2?=
 =?us-ascii?Q?nFrLjYYwNSX3dz3a5Xcapku0rXHeqLgZ5M+gJkdkOKhamLd3dDoeTbIfJcTE?=
 =?us-ascii?Q?E3XydW1Ue5Xf3H9mi6+Ldj8FzlogjPu1oNZAoBUgP1su9xu2BSVJkYffPgI4?=
 =?us-ascii?Q?/Bk5jL1+GE1WhJp1ZFXdCT+7gn2Mx1BjcKZ0qTz9RDcH9fxVC0MS3phovmsJ?=
 =?us-ascii?Q?P62TkY2PT1IbvPTBfHZYBL9oJPQ9gta4PZ5WY72VTTHNkJKRjAEorVFBFTFJ?=
 =?us-ascii?Q?HUTmbWhBkcU3cHqSDOVRubkM21xnFdlkDTR2Vk3WdDYOvoaD7HMnTzHfIKEC?=
 =?us-ascii?Q?uJtBGmgHFdtpGW8qtEGRxJ7YAIb4MkkzGRNnDi3TBevV/Gma0CZ+e1LmSCWq?=
 =?us-ascii?Q?8W7fzC85ivGcrbNdT41CoSuvExb7Ucx8EF/bWYENJ0dqiQhF2dpZxElZML50?=
 =?us-ascii?Q?CDkeG3FasoE+HrBe4XNO6dNl7reEJvuMbsFLbd82hjQtPkRWOzrTbpyC+P5g?=
 =?us-ascii?Q?UfI6rM+NAFFopoIQ2OsdmdHkPHjSA+1t7eMNnos891EwMMTxsjcA6qUqpbrl?=
 =?us-ascii?Q?OqFjeaFppxN9rFiNGaI7/LSPUgPMJyy0KPok7bz7P4S7oxXGna7N34FZ9iWy?=
 =?us-ascii?Q?ehzNlu8G0nrCvMt1PrnIAyHLtFFuo2YlQe3MdsjjAoXK4vO42c8RkmeFDvhM?=
 =?us-ascii?Q?dwL0aRQQc7TtQqr7QdvzBejJuqC4mOWkG6bnlfiTgbK2w3tk1Dr5+YCs9BcB?=
 =?us-ascii?Q?U90Jo13qb2aEnG076cDAgk3GqdSqgPsyg51LLlxuWgQXryE/FQJpEBhg7EVj?=
 =?us-ascii?Q?+ICTGB6KDxFlBt7UA257trWS1Wc54LRl7HB95FamG/TOMAT4VJXlwznX9erx?=
 =?us-ascii?Q?q5uH37z3YOO40pW1B++1lgVdW1Nu+j3FEWLADuWNHQ+sFR2JK6fY5CMRq89/?=
 =?us-ascii?Q?VlBwt40Qz18pXETB9A2GuLU6ekqqpQf3Ro3WULopGmc3gc85CsbJwzXtE3Vn?=
 =?us-ascii?Q?i2wkia0GM2ZAKUXV9wKe/mr0pqxoJkWqdq81dnND?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632adcd1-d0e5-428c-4faf-08dcc1131700
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 12:24:51.5294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYjHVTLl5znSMN6Gj5f7BFh77zPfsMEqfBqiJ9o+lMaUsPORgls2vLuaFKf5V9Y6w9DjM2aSuWE7UH/22OdeKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

On Thu, Aug 15, 2024 at 08:42:54PM +0800, Menglong Dong wrote:
> For now, the skb drop reason can be SKB_NOT_DROPPED_YET, which makes the
> kfree_skb_reason call consume_skb.

Maybe I'm missing something, but kfree_skb_reason() only calls
trace_consume_skb() if reason is SKB_CONSUMED. With SKB_NOT_DROPPED_YET
you will get a warning.

> In some case, we need to make sure that
> kfree_skb is called, which means the reason can't be SKB_NOT_DROPPED_YET.
> Introduce SKB_DR_RESET() to reset the reason to NOT_SPECIFIED if it is
> SKB_NOT_DROPPED_YET.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  include/net/dropreason-core.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 9707ab54fdd5..8da0129d1ed6 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -445,5 +445,6 @@ enum skb_drop_reason {
>  		    name == SKB_NOT_DROPPED_YET)		\
>  			SKB_DR_SET(name, reason);		\
>  	} while (0)
> +#define SKB_DR_RESET(name) SKB_DR_OR(name, NOT_SPECIFIED)
>  
>  #endif
> -- 
> 2.39.2
> 

