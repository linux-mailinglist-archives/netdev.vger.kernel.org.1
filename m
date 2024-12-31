Return-Path: <netdev+bounces-154616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292459FED6C
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 08:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC111161C74
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 07:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E061714A5;
	Tue, 31 Dec 2024 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cs6iEDnc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC82029A9
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735629204; cv=fail; b=KFYUVZXMUPiB5cIjTYfEViuj90vXp10BD9VzZpjx0OUvby+who6qKj1vGXOvgpGkQuYbi7kOjrGCSu20KJj0nsYZ3aEn798Mqx1NxLXAq5ugQElbAHp6U2VCwMCMuoWOpDICganLWYF2FxCJh/qoW9x22xLkyQAK4H3M2Kx3TqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735629204; c=relaxed/simple;
	bh=c4BebXDxzmsw72mfp6xKeaQ5mSg/AY4hw5GVkb50mRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rRsyrXbTbQLVGxo6IrOULUXuZoT7xuoGFTXdTI0nJ+C8ZgSyrfXHWSx5EnbEw8kCKDcHo3q8imBiNV6W5zOjIPRYFETq38fhlZWojL+JuMWSmVwUSo4RzvF1gEAHR3jeJ5rnoj1pvLHzVdeWH6aJp6gApaOWZ7TFuu/ZsbIHGdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cs6iEDnc; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xfr289wVpC098sJ5hl6yzyJAD2zlUJc7mZdmwljYX4s0saNrxzEJYXW0z4Af8azvRWRRvb/WQYYQZz7xsp+bMo8nf8Y7ugqRTMauYxviD2KSjZgFRZrAtng6POyByans9G1HoiF611pXc4rALDSSzaCCmV6C8/HVJnQy8LDHQz0NrI75+Z7BE+rq2IQZQG/m28RMgqeovFt33aR/F3ya9tTyEMr6csRgghEMezwPtB659/9thx52+9lqehEU2ubAJ9Hr37mZBnkQpeK0e8u58uQhT7YiCVCEAbxKBbTtr2HBMbYCL6PdbT6QSu3P0fF2cCA+vcucTU8SKCxc2VFkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdNu8KGZeFsW7Npe04YoE2oWVvFFMr6SxacD4tt4o8w=;
 b=PgHGc0erAgZ/GOpd2cG6zbHMDMJWDZi3hNWe9a2V/A1k84CABqcVcfa98OKvDudX2lHvC6vmCheVmWYcDeroqzGB2eS6Gwz1af3Hu7AqYcwjZplUs1fxQ8aKklFdwaXZ9/ENj6DhrvRGwVg9Dr3yhTgM3BwGPmG3aR3pdyIL9Ju7WpZocM0RZcvCPkZDxLZ3KOAAZ18rj680nATAE7n9QiFFzw+np9UCWKGN6Xt/A2RBqMrWUtcQeh6rjfG8yrWKgndP+lQszGL0fB1WiIXFQoXG29oR5sqWEQT9sRTyO6NiHibzl80jJod/QolywctKZd5LQIHPX9Q2ZuOOZJmpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdNu8KGZeFsW7Npe04YoE2oWVvFFMr6SxacD4tt4o8w=;
 b=cs6iEDncUg2yjb0kBEAT8fynABKj4T3tL4e8s+b8yO3KBtYAbCX1Pc3wClGZkSalhcIDtC7nbzUhdlQieE9/+5o6trD+3Ye5c81EZOO3wFqtzUbFAICvEsh/LL1lQ/Y/lf9BHrBWoSqaPMGupg0Bt2rKdhcxxr8XhzWGym/noMJiJK/yS6P8oh0ZdMfLRk0YWKe1O42cH+UVgwXDWQpB2t3qDvcXLzIMYaTX6mPMEW9wDWLhGZxFhzBQeeSdwQ0hFX9puP8H+T+P50uyfBXwIRkQB1F/Xj1AeoHbmPhs4cLCUqJbCcanjm42VmYOyRdof2Bgj7U+WxjUwitij3ohSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Tue, 31 Dec
 2024 07:13:16 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8293.000; Tue, 31 Dec 2024
 07:13:16 +0000
Date: Tue, 31 Dec 2024 09:13:06 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, petrm@nvidia.com,
	gnault@redhat.com
Subject: Re: [PATCH iproute2-next v2 2/3] ip: route: Add IPv6 flow label
 support
Message-ID: <Z3OZgsoGjFLiCxXH@shredder>
References: <20241230085810.87766-1-idosch@nvidia.com>
 <20241230085810.87766-3-idosch@nvidia.com>
 <20241230164958.5f99eb90@pi5>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230164958.5f99eb90@pi5>
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 5450f04c-a90c-4bca-a83b-08dd296a98f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AplhV3CsoIwWR6zPHjPM62BBuBSYcyy/9DZUcQnueyMYwPhgQyjgyA7D4hLN?=
 =?us-ascii?Q?c52R25cdf6wjipHhB5Yza0WxBdBluytl2p6BdLhtJd0qA/CFrQx1QyG6dC7M?=
 =?us-ascii?Q?UCmsfyfWBXswm0UJBulVpq3yVcdlgNe9uS2jCTN08IEBCmNlDUzsgH/Jx7Pg?=
 =?us-ascii?Q?gzQwA4W58CZB09p3YoR6Toq16D/eFXIggNCghrix/7wSTxg3kh0/jCbOdyS/?=
 =?us-ascii?Q?db9YhaR78iR8kQwObZ4QFAMncaktJBmRgZrqBJay4PblnYZDCem/lb8/Rq0i?=
 =?us-ascii?Q?ROBCvfS5kMsmEwT8UAIbSaBqjvx5aoC2G2TrGESX4v2HaU0Pz9I+kw/V++UT?=
 =?us-ascii?Q?Z23+litpqlNsEDTEsZx5pv2xMtU+M9iUs+EjMlcP+ftxjhQSW8eiTaKjhePK?=
 =?us-ascii?Q?zHM8LGlNJZH3ZGKq1FcMcfwv3yiJEyaqUf3HEVYiOsXMb/3tKdG40cD3aS2J?=
 =?us-ascii?Q?7l8zSCTFiSmSWmYr2PRxsGcKTp3tvAV93YgflpLfoGcW5KzQArWjTgjeprJB?=
 =?us-ascii?Q?LsyvdTIMkod1igmKBswaBReeLWhPxWmzhGyr2O7VkVHGrZxTmpLMoK4SrzWn?=
 =?us-ascii?Q?+6BBaXe2F4h54RLKjtPK5xjOkUgGNwLnAe7HhIwEI12UkaZlDRSRbdLEifi2?=
 =?us-ascii?Q?pFMzQvNIR7PAhP8jLgv0YeHrmqUOSyUyWQgjSuFO0NbtJuS9i2EK1BKNLSKd?=
 =?us-ascii?Q?X+MOvRB8dhBKVHW+JbcZ3ftLiQKDuvr8C7qtbrtLy3VYc28qVKn5xxosJ32C?=
 =?us-ascii?Q?CpByMxkbTm82j6w0clRjtVHDUWwdET8m+vZigMWDciBFj5EnsDcWcyw2cNnm?=
 =?us-ascii?Q?LsJAXZcXe0e4ILJ8Ir/bbkQCGfZBpIozf5Sm4yozYElMD6RAUC1WM+udDRWB?=
 =?us-ascii?Q?l54Nv5dUWz+fsoNKzA9MLKZRJaOW1p2ZoZQXz0N+QaiZ5neALabB9+Xrajbj?=
 =?us-ascii?Q?6pz3wEi9nJJe/1lccX2lrJ3N26t6ghiYTfYAwTuz7GZovoJ1iJRH/IoTyVom?=
 =?us-ascii?Q?9PTWqEbwO4s2Jg1qEV+0cwoBPvA/TwN94bz1472bQ04m13ntLyMLKZ6klBSC?=
 =?us-ascii?Q?T2j5IGY8BuPo7sY+soyvVDCFp4WP2HfUOxr+N4ulEziDe33L7/ql1vrre8WF?=
 =?us-ascii?Q?9Mbg/RJSEcgeqK1XQRGUv/FK+nYdh5aRO//e9dSiKGoHdg4+fi7nJxxjjp32?=
 =?us-ascii?Q?QVzmAEpSQNUhhiq1tqkoctTwKYFbxx+fqMRejcoc5+e7UHDCgMbGMdfRUkwL?=
 =?us-ascii?Q?Nr66X7RAaZ0jhF0j9lhSnxm0DDPQ3adaNG+slq7jmYqT1yTjj7VIGnTOpLKH?=
 =?us-ascii?Q?zV4CyYJi+XUEcQREXjyM2AAnJyzWQKQjnZT5enYM8r+Rc2fMnsK3Fy1OUuup?=
 =?us-ascii?Q?4IZhvMPNSeNy4Kv5Q5m/Y2XT1zZd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8VKn4E5puuoyu9I3FTyNFMesXLt3MTnjMzhiuFWNONx8vuZm4XuB3bX06o9W?=
 =?us-ascii?Q?2euajY5DDbooJbiIPyTYZ/O5h4nK6rV5ZOYANNPdt37k93BWgZRwKYxbySlv?=
 =?us-ascii?Q?oxXHLKVbrRdwSrFtk6hftll+KspWk2Xlp+8yOcVxDi8a0byrqE8PBkuMNQZb?=
 =?us-ascii?Q?lFjZofFnHcF4dFuiavY8Utqg9KlkGfvcHIF1a7NGRWWoNkP7t+TH6rGLJ3xh?=
 =?us-ascii?Q?3f0Shz93Mel3DR+selcPaAIIFg3E41Xybrv2RsrnSFWRlvUvTRsFiW3UYeDg?=
 =?us-ascii?Q?sFXdaibBBjnDArZCc5r3WkSWlyliFJUw/NJGE+m5/pxW/40/cdPBoaACOrUU?=
 =?us-ascii?Q?oDGJSyOl+KIBMS+vVqFychewvSey2YDS6v/vKcL5OR0XvW58AotTOOTfoZQ/?=
 =?us-ascii?Q?9fx4ofPP5s+ZETiOoDf64TfN1Wrh7jhjppkQMQvKfe2cK48g6sSV8oeR8u+x?=
 =?us-ascii?Q?qaIb4h+tPHTTFjf8mRIuKLQNvRuX/wPBHRwcH5wwfEyicLrksbVjAHqwlPms?=
 =?us-ascii?Q?h5rAkH1/Rk4NyG8RmTKonQjnYh+w4o3XnRj4YrvEJiJqZs9mBCXbF3Q1lhIS?=
 =?us-ascii?Q?oubksPG3WNSqanWTtFpj+F9nemzOqbO+DtFTE9Hu6BW5Hw4oNyOIcCqnV37j?=
 =?us-ascii?Q?lG85D0bswKZt6U0VI5BVUTajSv2K/AKwT5QO+9twGJKKyNActq9OqrSdplWt?=
 =?us-ascii?Q?MkGGlB2kpHP6/h4EBnYA00oQ1dTBcgwkLUaG+jB6+01OhboGQKyI3MANHyhu?=
 =?us-ascii?Q?VXQF523O6Ih0O0Uu3co+cQrUpW32qxJKKgPbd0WZq0GPUjRsIII4q1tSVrnP?=
 =?us-ascii?Q?B19CnrZW9QEBSAhdCdk6il57uET2tnf/Ss75GDXXdQ9zxl7ykoAJnNvd3ZMc?=
 =?us-ascii?Q?nQpArkBvk3f4EfBPqhgHfAZuUBbIJ/SMSsANic6C/pkPUV02KZCnqbe7vVh0?=
 =?us-ascii?Q?O+EUZdhtvFeXCfL1NGhqMWjI0njk0UQX5PEB8R8ZLGbVHcRDfnonah1rXgDv?=
 =?us-ascii?Q?4gMjGYsaeK/nalmSbESdPO3BjgTwjSDMGJG3ZaM+1hu/KwmBM2q8jYW4bPiV?=
 =?us-ascii?Q?q+WBFo8z93yvgqIFtswoqceK+MTEz91T6KF4jCqNRd/nq9V3Zs2N+mfA7fSB?=
 =?us-ascii?Q?tUvrst0kqLqZb4rui9zieCcZd68T1wGn76w5z7tOLqfbgWLp40wAsMZxycSS?=
 =?us-ascii?Q?nn0J+F/PRdrboPtbRcxhirGnJlTDqywgQgNyCYllOtsX8T3nWnlrjGbm3t2o?=
 =?us-ascii?Q?A3mfaB4YBnXGtgDPQtaToCe9Vy75Br+jJKZsA2b9oJ9VtwXU0juDtgdxPrAP?=
 =?us-ascii?Q?OMC0D1Gep1V5wLie8HAfFTz3EaEqjXEfgNHzaglPI2jvsL9SIvWAaQBB0+PW?=
 =?us-ascii?Q?YJK1Mxv4Gt0r3+0O/Cnj8+rCzt7mK0pKuOlJrONxDZzlfPiq6jyZaMPoNVHw?=
 =?us-ascii?Q?TGAK9hTCgHe1n9IOagtX/MtedLRaQnlEx/Hmmj1IOHcSzIwQhq5t2fDrSp3s?=
 =?us-ascii?Q?qEltzfg+Lo/BBYlBfHMly7OTEV7dDM3UTvMIhhgwOeVo8ikWri3Y4Emk2qMZ?=
 =?us-ascii?Q?CYEmpYqr5t5WXPO/MRD8d9hFVUBfRA1hSQtQfFT8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5450f04c-a90c-4bca-a83b-08dd296a98f8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 07:13:16.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJJxBjGoVIv/nAhwZiV5aXH9PKGQ30MGw3RrAmgdEqsSa9cOmP0JZNxM7fFXTqdoaFlZSwPOwbyPL6vTkbRWKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219

On Mon, Dec 30, 2024 at 04:49:58PM -0800, Stephen Hemminger wrote:
> On Mon, 30 Dec 2024 10:58:09 +0200
> Ido Schimmel <idosch@nvidia.com> wrote:
> 
> > @@ -2129,6 +2129,14 @@ static int iproute_get(int argc, char **argv)
> >  				invarg("Invalid \"ipproto\" value\n",
> >  				       *argv);
> >  			addattr8(&req.n, sizeof(req), RTA_IP_PROTO, ipproto);
> > +		} else if (strcmp(*argv, "flowlabel") == 0) {
> > +			__be32 flowlabel;
> > +
> > +			NEXT_ARG();
> > +			if (get_be32(&flowlabel, *argv, 0))
> > +				invarg("invalid flowlabel", *argv);
> > +			addattr32(&req.n, sizeof(req), RTA_FLOWLABEL,
> > +				  flowlabel);
> >  		} else {
> >  			inet_prefix addr;
> >  
> 
> What about displaying flow label with the ip route command?

The flow label is not a route attribute and it is not present in
RTM_NEWROUTE messages. It is provided as an input to the route lookup
process in RTM_GETROUTE messages.

