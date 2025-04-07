Return-Path: <netdev+bounces-179518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD6AA7D44F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2414B16E39D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 06:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D775B22539E;
	Mon,  7 Apr 2025 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q65iWaqV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CA221DAB
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007952; cv=fail; b=uqQdBrBZLTsvMD78tlBmJvrFYyqfFpuOAjT3qZUSJE4X3rvuYgehxXW9vwWdZv0+qih/xnNG5phq2ySyF/4tCnchrSFgQBA41DuJ5AjRBM3xVcXUfJj4IQKbIqFEY0auxkMgL+1vDUcNgpsCiMOERAGHVIO5TyG2uFhkDGp/UTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007952; c=relaxed/simple;
	bh=fkXveTUNGpz2HPGaWVyyX3ZQ+n38UO4LLGvZhQHW16g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TkjzwudS7DAqt254XGSXezjqvC92qmiaL/OxwPsWl78AM7q6PlqL1qXVtPbnuobtyzlviukvGAVadk40I5xfCO0e0NtkoIm3VNkl18B1AGyJQOIBfiGCoTCu6FpIUSyLXxkvurp1MhuGT3Qbcn6O0x1ejzuccDryYTbB9uYEYeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q65iWaqV; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYimWoH7QI5Vu6tAyNJ3yNMKW9BLxTXNGLPzl7z1v/PzroQGykQJ2AYX8SLGtsk38yxNGuKDTX760AB4AxX2qVaIBxoQ0R5DoskptzbPRHTIwdoW8ieaS5QRdb2cSUgbJyVJ5QKSyFHuaQOiMRtsNmYHvTy5isaLFPMFTYRgb64OnFunCO+O8SmduHHCp9i2SsUG9gFhYSrgkYSclkwNrAlyjpIwTpXuOzmSJg7UmpyPyz+YLKwmSn/69Q12iCNWtaqX7YZ4d/y2sekOFsPDBA/xTN5R1TF0HQG2ec7Qqo5QexGdCnGtdG00vENwIm9E/ppFLvQJGs0K8edcRqUtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KWn/AlBLK4+KdQQCfIz3MvYia45lvkbgdzH2uI+P7U=;
 b=b9hURdCZGm+ht/vtEup3WcBD82YJf6OOGx4iTTPHQrat44z5zxByRBngvfWOtczz3kiKcTouI3XKcPAInIOhHQg2y2x4cqLX8Ddx3GyzSo30vWpxpVqcYiDjED026BQMjoWahzu/kWdXkfCUhFYy97RHP9S/4PL40yjQ11mIkCd1jY7noE55X7y8Pa7eo8a7jflORSik/7ZOHAgLuUw2MxD6yBSMQg99BFABo3iRtNrAcpy9fbM9gU22cXDM6AkMgLzF8q7ibSAZX30ccZ7ItNIe+mRNDOmCWRl9ICxpNxURLzHZgo9S1Ni+vMSxzDQIMlJI8l0KFity1UrBYe2wHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KWn/AlBLK4+KdQQCfIz3MvYia45lvkbgdzH2uI+P7U=;
 b=q65iWaqV1XykmyTDu4DyEcxyKSQPx8at+F1ux/KxDCPzgmcs6cycFOEBKuk6+wBcNn/IhoZpfu+RIlS+XXGc9BXEa+d6oHZpAwHN33nvNpgUTjhS2sK4pcHrxrH8m2GDJ++ewild/Zl/hK9m4+vyntXMy+K/ysHruTt1cHmw4E/JqDA2qmlrp5T5tqXeqE49rnLz8qGjyQHbG/DLRVyNRQhnme8ssvNmodv/9cEHvuj4CabLWMwXz4Be1tdD38Shtbtq2MOik9rwndoO369uIrQgCqfaRdJWdqsaUKNRzhaHT12tRcHyU/QMA8S+ofL1v9B3sLNbW/3YuIvKBf/SaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 06:39:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 06:39:08 +0000
Date: Mon, 7 Apr 2025 09:38:58 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
	gnault@redhat.com, stfomichev@gmail.com
Subject: Re: [PATCH net 1/2] ipv6: Start path selection from the first nexthop
Message-ID: <Z_NzAqmXB4rvKn-G@shredder>
References: <20250402114224.293392-1-idosch@nvidia.com>
 <20250402114224.293392-2-idosch@nvidia.com>
 <67efef607bc41_1ddca82948c@willemb.c.googlers.com.notmuch>
 <Z_KFZ5cm7tOaBvw0@shredder>
 <67f2c83b70eb3_30e359294d4@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f2c83b70eb3_30e359294d4@willemb.c.googlers.com.notmuch>
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4a5d21-82c4-4142-7193-08dd759ee632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CCoIusgx1EZkLHnKETYA6wNzaN6YFcQKyfo2VilNnpLc0jlIEYQqjb2CQAQo?=
 =?us-ascii?Q?gTarf+7cAdZtduiuKmE6JY3HO6juoXygJje3UdAAsVKF9tewbGxJSSIx/xXW?=
 =?us-ascii?Q?+WdSBqmCnK+2wcxWWRfqXfsFglMUoAx//jVqbtXVhnYfQaa7Qdd6smJjbF3F?=
 =?us-ascii?Q?8GTQDhZpL5zNm4bWTGrH+AgYS0+rcqd8EL9dDRbASBR5ckQoM/VE0MBosCUe?=
 =?us-ascii?Q?2mJq8AOR7Z7nudJ9eL6FUSyGUUaBYuVHhOrJuC/lY4KBuJKmH1FbAr34O7lA?=
 =?us-ascii?Q?wwEmxWA9hK3/CvBcHlNYJcDR8uUUg0Tcrr3ni+YogSkySxzNO93hlFf0Qpnw?=
 =?us-ascii?Q?SpF/Vt5VkpqSVd8IMDeSCR7m/qioD6y/GwEvpATSXaVcBv4PwCV7rCEKSa75?=
 =?us-ascii?Q?NKbXP++uRQTC6AMcxbAXVhcLQ1O8asOLcpm7bkNWB/OjoRrHpnvx9iCp+IJp?=
 =?us-ascii?Q?tuX6hC+nFZzPLc3hj70ibSalGYa8fuZ23C3qKW9wLqdkqV3vbdUSWLAytMHf?=
 =?us-ascii?Q?kOOF6rQ1obA9xFAah2YItLdSlFr6bvU7wtohCjIO8sALdSFy9T4ngfywd2jJ?=
 =?us-ascii?Q?Hk+FWNENUNMk38fgG1hwyYSDEykF+qdP/ZT0nYOhExb8U9zTjGPBwBhasLfJ?=
 =?us-ascii?Q?d3w0+9UWRpXx6XRbNpUgM1CXQVtiznqbDuwmMXEx+IU+t9tH/teYlzKGN3FT?=
 =?us-ascii?Q?Maa9UH/Caj7PwuV1z/4Wp0wovcwhfgEIKUzsnSDfy8T/+hlD9WX1HzgFBI2e?=
 =?us-ascii?Q?kaMaBRFFt+1jFq4o4MLEGleM4XVplt/D4MbhB5kARHTARJkGPlAW9jlBr8/d?=
 =?us-ascii?Q?V7nJH/M+Up1muzV3JNylRmL7ahNRQ6sVBgHUQKA3Q2PAU54Ps++U+AZUR4mU?=
 =?us-ascii?Q?XXMNONoNbreG0z+gGmVgpTaGYFyUsI+ZpSSrLHj1TaQr3R+nW0wKrKrSl/4h?=
 =?us-ascii?Q?PD4fny5enyehzKZoTZl8X4B62n8Kb8k0fK2R/jFOdc1axzKFucoEb7wnOZRp?=
 =?us-ascii?Q?NaMItx2Z8YTykDRjZILErzu9h5uzAousNEl5jtJaHDDUhm1VdrG6n7n2VPrI?=
 =?us-ascii?Q?q+P55wHtAWybV+6ROBpU5h9MAigxpF2P1FKDEgp59liLt00e41Bw29tciX28?=
 =?us-ascii?Q?1tqqXu0FOJ3SRJ9hxQVI05A45CA1HhJcBmAZPqQuj0RkrbHEmFz6FPbzuGyX?=
 =?us-ascii?Q?euT0Lm0X4JjUhgVtMTW6/SOiwtjLVLGKrksA5k1urDYlc6DwnmZ4qtJYLaNo?=
 =?us-ascii?Q?RP+1XWKh6em0Yvzj89qaYXv3qn/QCZZc/eEMJsOxHKgBTUpHO2akhQTi/ZnY?=
 =?us-ascii?Q?7ehJaRCpAW9JEgrD3201G34qYEe/M1jpb0PNzy4nmiPnCF5WR6tnjievA+6J?=
 =?us-ascii?Q?2N2zhk45aS12cf1yTyufNd2wI4sm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Zw9Uhs88uzoJU2tkRJbCRSCateTqPltq24JWHy5LNbVPSAFWVVfP9KBk+Ap?=
 =?us-ascii?Q?BzQr85UwCnP5Nf+w3bJ6b9U5TJnYBFq15hM+DoPDGyIdR0/fScvnrR2Hp+TL?=
 =?us-ascii?Q?zQzjfr0F63s/gvCTwGOx6jXyvh+aQRY1Q5/jXIPAIwZokYOv51PpwCX0Z6iS?=
 =?us-ascii?Q?9fhT0thVGEIQehB34A6fWeLXg+a7ybY5rQDu1UQ/Xt2Q/PPBcS96pl5gPXf7?=
 =?us-ascii?Q?US6xuEACf688muc8BOED30U1ydQl5JRK82ct2ExTmQRugkXgpfFPBA37s+Vk?=
 =?us-ascii?Q?nHWAE5ERNB6vK9z/4cfik90xqngWPaU0E5p0n0C+A8vIzGWYquNOtPBY1e40?=
 =?us-ascii?Q?HuPm4G7RCMzRvkk8cpF3nzM7LEPP7XGfQktKPDG2lVTZj3MxvGzkb6oF6tIa?=
 =?us-ascii?Q?w06pQACI5RfsiXaZVg6F82UIwYimPv+tPvEFCNBFGWp4rsVytDBdSSgz4Ttb?=
 =?us-ascii?Q?3cHFZGj1wm0WmgDV78S2BDO55WTHcPnZ2hlAnow/Z8B/Ggbi+cyRa9KuE4T/?=
 =?us-ascii?Q?m5lglY3Cbyb4V5VEffckJZivqlDJfv2Oeo3AtByVBKHDi2ujZh4+xtvRB5Ob?=
 =?us-ascii?Q?4hVQLLRDmoNozwBXdEzbCLsZn0uNU+8QWtvkSgXyHdfS2taG39z24eS9sbvJ?=
 =?us-ascii?Q?UegzVsdYrq7+hac6vjIsY6vQmtXfAb0jrviJKNHsPwD0kumrmntszwr27pCa?=
 =?us-ascii?Q?NwM4ldJkcjJgvebvEUvRGrehoiZEJO1T7wNoPXfVXhLBi27IOfkQmGqkVRMJ?=
 =?us-ascii?Q?6R6SdDrDqmX+hnGP5i9ke5JnplIjVMawx3lVtbo+50z1T08j0344ZVCj2q8V?=
 =?us-ascii?Q?cDhbclEXIYg76XzJKLsJj+HwXOeCX3VtCL2AHeScssLyLsSl1iWYBbBYkSjD?=
 =?us-ascii?Q?gB3+eCLFHag8RwxQWnentQ5qSeqNNB/rPm2YK79uaIxjY76Mol24HANCsANy?=
 =?us-ascii?Q?R6ndQX7WOUu3+fgkOtFtoxqZekAlKnF87QNWWhXYjCHD4ta6JZePzIzQ8LgQ?=
 =?us-ascii?Q?pIrsVQSpvxoJQzH3rjSYt89SNLS/6Pw2K/GBtz4kMIsY/HqjAcy5rOGIDdzu?=
 =?us-ascii?Q?CE/l+gQULht7jVamz2qcVpgiexGm9Le5Ylx7r+uv2BxvvmEsEpaBqO2adTIs?=
 =?us-ascii?Q?/XZvDtNO1fZ/co4TmKV75qaIhvq6P/fq97X7uMX28jj3LfFPbZx5JGy4agV9?=
 =?us-ascii?Q?20zWiYYiGW0lsZGrScLtKYxmeMA2yOIaZpJa6QMy4zTidFwMEb017r0oLISZ?=
 =?us-ascii?Q?aZJutR8CHy73cWgEBEUFQpfndTmGj3FlpQDdGYoHmITdKZcsAJbhuRxMGrsj?=
 =?us-ascii?Q?VgGZmcAE39cCZMMYn7J4VLcRnXY7xjvjZCiQOeBf1Tzniu4V9ZSRKLbZ/7v/?=
 =?us-ascii?Q?dUuPhTzFS37a9rdyNRevaMNQ2gRVdXZ0p3akfD3hO96lM49hnJ0JZnBybwMJ?=
 =?us-ascii?Q?noo+DXtG6jbaKcl/nXz9ViazzHLQxscChwWknBQp0SqVO0xut9/CE8OTRfM3?=
 =?us-ascii?Q?wZ1HXE1ejumwtlPIzLrUv3KTXps+DBrmjvC1i2SWh3/Z4Y2H5c42tcBnqMRL?=
 =?us-ascii?Q?lhhJRODTqpkgu6n2RpqcZCYK9ujQe+iG+sdZ8qco?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4a5d21-82c4-4142-7193-08dd759ee632
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 06:39:08.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouRt2/LwC7sbrJyAttI9nc7sXiHb8p640FST1KauauHFwxKNECuWQGGn9r2gUjJj3fEinPOQABS2CKCZ5ZwV3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117

On Sun, Apr 06, 2025 at 02:30:19PM -0400, Willem de Bruijn wrote:
> Ido Schimmel wrote:
> > Hi Willem,
> > 
> > Thanks for taking a look
> > 
> > On Fri, Apr 04, 2025 at 10:40:32AM -0400, Willem de Bruijn wrote:
> > > Ido Schimmel wrote:
> > > > Cited commit transitioned IPv6 path selection to use hash-threshold
> > > > instead of modulo-N. With hash-threshold, each nexthop is assigned a
> > > > region boundary in the multipath hash function's output space and a
> > > > nexthop is chosen if the calculated hash is smaller than the nexthop's
> > > > region boundary.
> > > > 
> > > > Hash-threshold does not work correctly if path selection does not start
> > > > with the first nexthop. For example, if fib6_select_path() is always
> > > > passed the last nexthop in the group, then it will always be chosen
> > > > because its region boundary covers the entire hash function's output
> > > > space.
> > > > 
> > > > Fix this by starting the selection process from the first nexthop and do
> > > > not consider nexthops for which rt6_score_route() provided a negative
> > > > score.
> > > > 
> > > > Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
> > > > Reported-by: Stanislav Fomichev <stfomichev@gmail.com>
> > > > Closes: https://lore.kernel.org/netdev/Z9RIyKZDNoka53EO@mini-arch/
> > > > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > > > ---
> > > >  net/ipv6/route.c | 38 +++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 35 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > > > index c3406a0d45bd..864f0002034b 100644
> > > > --- a/net/ipv6/route.c
> > > > +++ b/net/ipv6/route.c
> > > > @@ -412,11 +412,35 @@ static bool rt6_check_expired(const struct rt6_info *rt)
> > > >  	return false;
> > > >  }
> > > >  
> > > > +static struct fib6_info *
> > > > +rt6_multipath_first_sibling_rcu(const struct fib6_info *rt)
> > > > +{
> > > > +	struct fib6_info *iter;
> > > > +	struct fib6_node *fn;
> > > > +
> > > > +	fn = rcu_dereference(rt->fib6_node);
> > > > +	if (!fn)
> > > > +		goto out;
> > > > +	iter = rcu_dereference(fn->leaf);
> > > > +	if (!iter)
> > > > +		goto out;
> > > > +
> > > > +	while (iter) {
> > > > +		if (iter->fib6_metric == rt->fib6_metric &&
> > > > +		    rt6_qualify_for_ecmp(iter))
> > > > +			return iter;
> > > > +		iter = rcu_dereference(iter->fib6_next);
> > > > +	}
> > > > +
> > > > +out:
> > > > +	return NULL;
> > > > +}
> > > 
> > > The rcu counterpart to rt6_multipath_first_sibling, which is used when
> > > computing the ranges in rt6_multipath_rebalance.
> > 
> > Right
> > 
> > > 
> > > > +
> > > >  void fib6_select_path(const struct net *net, struct fib6_result *res,
> > > >  		      struct flowi6 *fl6, int oif, bool have_oif_match,
> > > >  		      const struct sk_buff *skb, int strict)
> > > >  {
> > > > -	struct fib6_info *match = res->f6i;
> > > > +	struct fib6_info *first, *match = res->f6i;
> > > >  	struct fib6_info *sibling;
> > > >  
> > > >  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
> > > > @@ -440,10 +464,18 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
> > > >  		return;
> > > >  	}
> > > >  
> > > > -	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
> > > > +	first = rt6_multipath_first_sibling_rcu(match);
> > > > +	if (!first)
> > > >  		goto out;
> > > >  
> > > > -	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
> > > > +	if (fl6->mp_hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
> > > > +	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
> > > > +			    strict) >= 0) {
> > > 
> > > Does this fix address two issues in one patch: start from the first
> > > sibling, and check validity of the sibling?
> > 
> > The loop below will only choose a nexthop ('match = sibling') if its
> > score is not negative. The purpose of the check here is to do the same
> > for the first nexthop. That is, only choose a nexthop when calculated
> > hash is smaller than the nexthop's region boundary and the nexthop has a
> > non negative score.
> > 
> > This was not done before for 'match' because the caller already chose
> > 'match' based on its score.
> > 
> > > The behavior on negative score for the first_sibling appears
> > > different from that on subsequent siblings in the for_each below:
> > > in that case the loop breaks, while for the first it skips?
> > > 
> > >                 if (fl6->mp_hash > nh_upper_bound)
> > >                         continue;
> > >                 if (rt6_score_route(nh, sibling->fib6_flags, oif, strict) < 0)
> > >                         break;
> > >                 match = sibling;
> > >                 break;
> > > 
> > > Am I reading that correct and is that intentional?
> > 
> > Hmm, I see. I think it makes sense to have the same behavior for all
> > nexthops. That is, if nexthop fits in terms of hash but has a negative
> > score, then fallback to 'match'. How about the following diff?
> 
> That unifies the behavior.
> 
> Is match guaranteed to be an acceptable path, i.e., having a positive
> score?

It can be negative (-1) if there isn't a neighbour associated with the
nexthop which isn't necessarily a bad sign. Even if this is the case,
it's the nexthop the kernel chose after evaluating the others.

> Else just the first valid sibling after the matching, but invalid,
> sibling, may be the most robust solution.

AFAICT, the kernel has been falling back to 'match' upon a negative
sibling score since 2013, so my preference would be to keep this
behavior.

