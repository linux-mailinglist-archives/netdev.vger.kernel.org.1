Return-Path: <netdev+bounces-134924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9552599B929
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB09B20F5E
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 11:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E676F13D24E;
	Sun, 13 Oct 2024 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rwfjLCZw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30B4086A;
	Sun, 13 Oct 2024 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728817927; cv=fail; b=j4GMKbl0Ge81LJuzxsq/+pl7c6mY71B7iIhaXUvVqrrJMlAuwaja5IYHf6y/GzJ7xG9Dn6XlLJ1pc8W9PMq/EIorqVq4TZahpXpdpTqR14CtqBuV8dkbsBysw+rJzmawovlur02AOf08rSSLDQbS0H/NaZ6QIghSvNEhU8ESFdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728817927; c=relaxed/simple;
	bh=7Rq43cXw7uDBd/aWl87XEN9DOmgXa6jXjm1aoHQONM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t4ERiNgmx44OZFLHnRWVBl2mc19Nx3LwPgqrQKQOJRMd3m0u8qkJYRXL1yo/yNT6KfQ/0Zr56/dAkDDQElXR0cc9+/VWode7aQmla1PQuM8xy+RNf+hujWiKb9twId3+t0X7ez5qeHBEk66SZ0EZfxGOBVDwQtoHyK0vOyZ7uos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rwfjLCZw; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPXe2JxNOwTyWFXI4eCPo42Qnzd9l45+ObkZsYBGlj86ptefc1sITHh+5fSZwYkF9zkyZyUZEdAxy+B5QRFDSwPGHzoygxhfVym0/s5T3A7B7jQIWuTw161fkT3LYNe9lEjcoBl2GLl5wE5nXKmtpvS/GnMKXGPKYUTdcIVHrK0HgBJmSd6esh7gQmhRPWa2mllENRkG1UYtKVLC81/gG+Hz0wgtcIS62i3bi3FrIkUKvyVN/ZcigxVZbdHdRpW3f6Xd0VpvdSwAz+NeVyso4oMx5MyyXLZvQZWczFSR/fqWE4BPBt1f6kAyIdRq3HWylsGURx7LLt9Py6U14V6geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfXyJwOaP4rZ2GHyCHR1bNxD/KmGZoN9Yj+F8muEGyc=;
 b=rdknugiLh88b4mVrYUiZCJtlMoH6yr+9G1fMwlPHk6dDpx+Sq5UiPPeKLowlKHsea3/GsmyNO4UVOy8AzzuGi6X3diqFVXDNkHciIsW5QbNhvI/+/nCostoWoUX+stvRCxwY0rRKEiRzQrDofdls2y0jFYVwTVDCpbFyopjCxsVbAwDLlF2uCePiKbWClM/kGVFsAPhVWAR+tQcKWOVjwoe+mv6aWHjVtsv5fs6q0IRnbxdGG+MPDqsfBkKpEskxffsuFBXCgYV0vYHP27KGRFfWIPhyXVvsZqkfr776E1KkjqmLaZocTkCJ5r5RRp/r/Way4fYZczLg04B5n2Kx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfXyJwOaP4rZ2GHyCHR1bNxD/KmGZoN9Yj+F8muEGyc=;
 b=rwfjLCZwfAMOu2i5fLW/llf00WYg0gQVjXba0CQ6FeqshcuIAgewWD7CJPPSdXeevpeUV+q1IfL23Z8TqhdoLVXuvd4hfMHdbC8Kx0vtaNOl5D6DslIH9sAaFM4RTnReWlnjsbvK0W3Eqnevf1ZSAJgQdL7KZPhtonfkgmXwk5DpR7vKj+GDhOvMKuA4dItbfYFu6Mo61ZUVtyaB/DR8YWErl7PmXznmYhG2WXgXv5+pNrdLzLIZopk9ZeHNR5C/t5v2xs7DQKR1/bqlLFXitesJE5EalfHZ+ZzXexH+2rftd8vLhle+kqFA+2YBgoY0ATI3flb/U7P/48QEWTWleA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sun, 13 Oct
 2024 11:12:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 11:12:01 +0000
Date: Sun, 13 Oct 2024 14:11:52 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v7 05/12] net: vxlan: make vxlan_remcsum()
 return drop reasons
Message-ID: <Zwuq-B2tw39ZiA87@shredder.mtl.com>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-6-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009022830.83949-6-dongml2@chinatelecom.cn>
X-ClientProxiedBy: LO4P123CA0627.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: b859f49b-3301-4faf-57f3-08dceb77dc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JPKNCYhxCfCz6fEvJGjCzn3drWx/ypzCTaL9l0OL50D7hShuI62gath8Zy+s?=
 =?us-ascii?Q?/X1aOVJpKjzngf1uuVrUPYasM3BnzXWCOGnefRlTuWXmz+A6CqB9DfLqBXlj?=
 =?us-ascii?Q?V4uQElPEn7EZCQkJ7XIMs8l5YT2op9gN0fwBpIxwP0Ws+1nfxmR/icu/2Dj2?=
 =?us-ascii?Q?/EJW+22zh4ah+EhSrhzQ3RN1g+vAwQ3y3YFzeml4y2ZMx2aDacPlxZDPTLHa?=
 =?us-ascii?Q?/jef3kytlYAnBlAiBmzTL7X2T9eDmQeVs7hcxbHtOg4uHCkTCwrl0bb6OGEi?=
 =?us-ascii?Q?BBmw4f1//JfexyOM/ELN+0z61OR8UnLo+EeuYX6GiSe8Anq/N1bbapnndvGb?=
 =?us-ascii?Q?1q75Fr6H2MqaCOCZ94FZ/OkB/2XcuRJaIfYw8QIscdOR2ljzr+5tS2dZzPsV?=
 =?us-ascii?Q?7jgo/PdD/ZwL1ZtbSmmJo42ryUBkeaASaqqGyVe9clcw3T1Ikk0D5JM/EQFY?=
 =?us-ascii?Q?9E2XtOwWJnd/8ASSYYLMExUE51WFQcCwV0HYLR7TWgovBYfj78Uw3NimeiqJ?=
 =?us-ascii?Q?p1R1vskB4ry1EzIyaGNgigjImqMrsV5sERAG6KVZVinKwVPmP+DUX6abXYCO?=
 =?us-ascii?Q?sg91kEOjmBZ7JkEoXErX29gJ0OLZeTh253sdDqwItahYKIJc1BIQXPgcMgyO?=
 =?us-ascii?Q?fWOzr7gRZVE8DoJm/N1Lk+/AAS7Ltbq4I5CO30nvA7L4t23N5m4psMa+Eefh?=
 =?us-ascii?Q?ABwmJLINP33GaBrQX3XsWZBOz3zKd05rgCmSIhaKUR/yBSrFjmTkWB0ViqkJ?=
 =?us-ascii?Q?t7qdqgm+Kgo8AARrDXkKm8oN5MJkDy8zOm7/VSqT6fD3v3mBMtUyKauWSedr?=
 =?us-ascii?Q?Fc7Dc3o51dsTT71aaf6wUDlaxqgDogWzwwgBtziVPCu9uIf+juYIk/t4qxla?=
 =?us-ascii?Q?tDADFr1N6iRC/cA03vxoZzvs2zB+F8EpY0DDByquFv2HXTNn/uO/MePJCoia?=
 =?us-ascii?Q?xih+SHwSmUw4bP+2uGa4Qmh9WOmYE8qocCNbmTjp5AeDmfKz55xnZDL1db9w?=
 =?us-ascii?Q?+B+R2DyFfsWvt8P1Kh3lzVRkg4H9IH1DWDfW9rANoEAsHTsWhWEr5Kx9SzOw?=
 =?us-ascii?Q?4poXA8uf6Hbsvl+oJzEUDgx3ApHKHXhynTy/6UZ150TkLj1UZS5Y3neuISrj?=
 =?us-ascii?Q?dHKpgsFl6dy/DatgC5a7qDit6sOWYSQbHVwba/cgO5woFUd/6p2ihb1ToHFV?=
 =?us-ascii?Q?TCSWGuZzgKURjj112V4W8TuqdboIIbzspDcS1VUb5kw7g5cvPyEGgM0pczUE?=
 =?us-ascii?Q?O6V9S/T1DIe2x5mN+X3UpAE7NaoZGuRa5QFFqhAMYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PSOXI4yWDA9/AGUL/NHe4fsaFKzztLZBWRixwAgAmPlwd7FPfV8eNK6kT5mu?=
 =?us-ascii?Q?XqR94zetaDfYe+nnSBZkt4gvcMlzB9OvnKwWIOKWBhdbgnVkRzmqugbxPDBX?=
 =?us-ascii?Q?7ZTLv2uZp35ebRSYuQzwhI4b4PV1YXTxT/Ei8JqWAicv+bCTdQWLB2A/lsZV?=
 =?us-ascii?Q?sC8ehzxVAGdpjrV3rjcXMpwxJ7ymoMPTQbWGSWmEVyXq/hgsvWKsrMduUbA7?=
 =?us-ascii?Q?9LNIEG8st4wECFT2/hgRpOeMLB/HShWFxlNN3AZrGnqTp8umVFJF7lHnpZYK?=
 =?us-ascii?Q?Sy6q/s7ySZMwOuqkWB1DoQGYTugPwEutVpGGzl0+dO1xlpxL2e95VDxI4b+S?=
 =?us-ascii?Q?qkyBW0nVODd4ow0nyajs4FZktQWU9MY091yMgw0Q4u1vvqIsvZXK7lmnCoS5?=
 =?us-ascii?Q?/z0Zq8PbOxVYzZpC25a6MoWDVz9uqXqSRHklO3i3Ge6wiUzu2Kc7TvV+/Yod?=
 =?us-ascii?Q?Ber6+6yXkODoi1UaSqFOIbybwSVzpp/2NmgmebJNeMOTRgakqMqOpT2e0wRF?=
 =?us-ascii?Q?VnY+cAM89YtsFxFmSmJMnqxdAsYi2e2VIEL9d6kFTiEapEO9kUb0m/NK9WOV?=
 =?us-ascii?Q?n1Nd/+JKv8zWq0pWGK2dvrgi2o0sYXWAUdVxfz2Hxg7vdm58VLcRllcISB0c?=
 =?us-ascii?Q?ve8J9zjU7fOVBWTLXWdHFlOBe2rD7aQFVFGW1T7Y7A+gtFDesfK4eg8zSssR?=
 =?us-ascii?Q?wIMX3bY+nJ/ivRg5GCQSpdy43/DwQ6sje2ctTo0KWfxS7y42c4nF1rgz1ehB?=
 =?us-ascii?Q?0137oZaulToi0q/AUq5C+ndTKenroqJkQAMfxwmTL/ONVGLMVrNS/9n0JcGd?=
 =?us-ascii?Q?8gveLnbkPOQ34INwrPNftJup1PxvHQMC1u4boKVjfmtZC4zTiz7cuxItGc87?=
 =?us-ascii?Q?Yi1lCGW9VuonmcYXDNBI7is47Xiof3Aa4anMjtwGE6TsvdPq6Yn2936ZFfBw?=
 =?us-ascii?Q?d+1IjsfsECVxmCN86Nm9rwJiRbrC23+nJqLnl3Wu9Ub355TNpROdRr4eRelc?=
 =?us-ascii?Q?QvYQvzn9cL78nFuJXOS4UhMe3W0Gqz/RIFYvuhyq1dtjnEsRMQgZodsypuR+?=
 =?us-ascii?Q?QzF5N6u+EuCf2il78ihTEDYKBoWj4YTE4gBnuquSoXEPdrDUBtbqrv1XzRWW?=
 =?us-ascii?Q?Joc3qBqHKdq202rWn2KMLxD9s3bs94dZbTa7caBOZiOxL+S/dLR1VhxlqhOf?=
 =?us-ascii?Q?znnt0MEHcMRtj3AoSoQlkFOmSDkYIBC6qGq9KTQnnaiLMR1cuEArBSKCRK05?=
 =?us-ascii?Q?3cE394PjChT5KnVjC5nvzUlXQvYdII5lUP1F7b3wBvkuCHnbP2QbVy45H7ej?=
 =?us-ascii?Q?nP0UNyqCaVvuT4nok6CZVUeiPd78jZl7jHt4wEKSntkZErER5une3WSwSoYU?=
 =?us-ascii?Q?zxrvKhgVjCPRVF8K7U22x4AICIyeeyeuZQ0341GAxlKE3VY7Sgb8iovbszy0?=
 =?us-ascii?Q?tfVB/ySmCAyeDqzNb528Qq+kZNgHD6cm3wNh6WAAACkXaGqMgVGDPwJYB48Q?=
 =?us-ascii?Q?vlcGAgdNjU3u9QsN0U2Nk+rN8bsuWb18RbmvplEhDquIrdz2hRxo5sCBhrwd?=
 =?us-ascii?Q?7R/uy+O3UsS49GQsoG+IBmreGxtOSMgCbElDZLBG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b859f49b-3301-4faf-57f3-08dceb77dc7d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 11:12:01.3400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvZXSJO122CI9gy5wGS01Q1a3l2I7ii/eDf8avICsc0dDSGcXwtt5SVbqx3eY2kU8LzFW6LxkdyEQloY8DQHXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274

On Wed, Oct 09, 2024 at 10:28:23AM +0800, Menglong Dong wrote:
> Make vxlan_remcsum() support skb drop reasons by changing the return
> value type of it from bool to enum skb_drop_reason.
> 
> The only drop reason in vxlan_remcsum() comes from pskb_may_pull_reason(),
> so we just return it.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

