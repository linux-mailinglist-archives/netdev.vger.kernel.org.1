Return-Path: <netdev+bounces-244690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D40CBCB7E
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 07:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2DAF3006599
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 06:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49913016F2;
	Mon, 15 Dec 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LVh94gHo"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E132F290A
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765781989; cv=fail; b=oCZOkaIxpz15LEv2EAWDN4bZ1GhxlILRZtAqPJn2TtAKkWdmcMchs639cE9U7mZBGm8gTOF+h+9tpsMBgzLkknTPmu/giVHVJ2pPAUGffLp+26VCLtoi2w6hocV/LAXlMWvVqaaf2cWqQ+yalGQd64fff0U0bYWsZ27VbUpY9Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765781989; c=relaxed/simple;
	bh=kYNGyKr9OrvOO+nWZK62pBfNuGgNwKro/AlklFXIVTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4J4efkt2BGSTUo+xAzvuwKKIUOcUPsVsDGjM6weQOZLzDbHEA73t6SOQipZLynKxfw71Mrmr45iPswu8K7Fq3tipo7rHhArJKfeQCHn6AAttVBFu9nlm3FcL3yQZcj8pFY09ifGSWpNA6x3x6Abuj8MucjfkRmmq1TcKsbH4wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LVh94gHo; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAMRVZXOh0GYU30pVkJsHWJRf3/n7vzuCgazv8+Uln0Cc1NxwKLxtozZmHUxBW98wcI2TYttAoY8O4hJ24M4Ip89/8moC1x7eAiQLrnL3lMYoVqLcQvxmLJ28EKGgYumCGQnVFtDpvt/het61lkSRRG3MAvAcvQwr1Lv09sx0khbMCH+buUaAPehDsm9u8OVAuaN/pbxq9y+NN4ChDmm6CBVeDqCZeoULVMma3s/sx11yCTaq2gmL/Z5Kzz7/D7t15WTRihLWBGmNR35k4nIE581xW/wUuYJZrnb/PKnJfECMZSglmpQeW9Z3rH6nrY/sUxK6LL+iDElGYD70ADlhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFqox9rftNnE1MpL4XY0kxhB5pUwQLe89jkvsKWNyZE=;
 b=RXQHkjmutfvuL5l+qYfdGT7j8EFp9KJaqwl94Ivjfs9ejGVEqGOzIjFQT+lLPPtVWyJKNMqOn4Xs9UMfYA+xxZIDxBUSXTgxIn3yDLJkOH8aXQPHha47tW29YYqtBk9zyyls0q9g/YSwytobHDZks3X3IN6RSv3vzSeKC1Ykeh2sOAC9K1PanL9z41K3moxsmYcHe8eEOPHzyMCCersXolBIHaedsYdup0fBsa98kfdm9qhSXj5NUXYCUdmjmvUhnI0keQuXeAJ+t/Z1pBjwIE6ylk6vz6GtaptIaeZxA2pOMVZySFakbh86Gl9DG+iUyuLHYBGqPZtmTtXUh3D4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFqox9rftNnE1MpL4XY0kxhB5pUwQLe89jkvsKWNyZE=;
 b=LVh94gHo2bFX8EV1ul3T0e99HfVlbPx6FZ445rP3O/292o5KL2nbBEbsjGDEK899MUvCvJIT9UWjEmq6eRJfph4XjnCRaCbKk7hzLWyY6Ji7GDNcNjFPlrBX+VA7+YIBp5y8oiq5hoYbsiy7rtAxNP7P3HDDgVxEfaxOjJksrCKykkrvPH9oRjWohH3htop6OvMW+dBOMDBcVolEGWHmt5xkwV8RQAYm0LVCob/rCwDx4ItBBA1UC7yRfUnTqwGgxYEV53biOj6wTC4D2E+mjjwtLTIjX7JqTnxAdKNujFO4JBBaIb0yxfhmO+5aCWPiENQDztxRXsSZMp1Z98OrUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PPFC855560D7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 06:59:44 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 06:59:44 +0000
Date: Mon, 15 Dec 2025 08:59:33 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.ord>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: fib_nexthops: Add test case for ipv4
 multi nexthops
Message-ID: <aT-x1ZQtu4rsGxgI@shredder>
References: <20251213135849.2054677-1-vadim.fedorenko@linux.dev>
 <20251213135849.2054677-2-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213135849.2054677-2-vadim.fedorenko@linux.dev>
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PPFC855560D7:EE_
X-MS-Office365-Filtering-Correlation-Id: b79a4cd3-e025-40ab-5d4a-08de3ba786e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YOcLnU+rbsoSgHw2HK+JXYxrp3OjjS9TYu+nGTw1qObdTLvDsSb1Ldkqz/kp?=
 =?us-ascii?Q?hPTQ6EBtsHN67XhxX5MAawk2KxNI38e85+Kvq4Z9AFp12KuitoN93CoaYspT?=
 =?us-ascii?Q?wNwS7RMGTLgT97bY79pNCoMzmPuoLMcBPEI1mpzUSSmC+JKqeWZANra72dXC?=
 =?us-ascii?Q?u8Zm4bx6IbMxXvlT4p+qDQAbcf/iDr3GUfR2C2VD0qCWSxlwhh0PgglZcyfx?=
 =?us-ascii?Q?K3GKKyqWjwTr/0YuG98czwsY0EkTDFk8kc6WADo34NnJ2Z7oRCtSMvmGJYTu?=
 =?us-ascii?Q?u/EunKxAubkYw0zD/1AC+GEVkBOmlC71qkhefiW5+rligL718gRDv6VpJr0D?=
 =?us-ascii?Q?UBR2Lfm6E581jlxzg3TNZJi+QVkL5e4tLoN/QtiSNadFhm4l9PJr4xdXGC2B?=
 =?us-ascii?Q?wZcIglBMzUmHuIx0cYbZZxmhkHF2CVQTDb7BmYbkpH6414Fc02mJ4wEGZOTR?=
 =?us-ascii?Q?MxJDDramgarFNq/DvPZE9rFzw/i8rllmVNzfrgPO11vSrHqemsx3FwL76hx8?=
 =?us-ascii?Q?oZ+OwctTD86QwvX2GWHlb6KVB2MTPLHjkR/y9ak+doNm87m0YP4gEARCfbEn?=
 =?us-ascii?Q?Wgvsln876sYnmgqSOKmpw+OHxA6+k2DGwcI+d0ZYl8a5E5mKtXfv7EWYa3Zs?=
 =?us-ascii?Q?PrTONqjH1zMsIZL6//rpIHKNbQdZiu2YutXz3b0KfhDPAUqLt4IQL4r6L35n?=
 =?us-ascii?Q?YuMz243lZ+09RI7qZK0bGy//XTQNZVWMpZsT51Ng7nYnWYTuZkkrV7VlEW8U?=
 =?us-ascii?Q?rCYXSCFVquqNqlfpECX0PJeivUS9TDqIhjkSGerAl/+TclVacew92VU5m4eA?=
 =?us-ascii?Q?IexmKFwryBAZ6iSx3t2GZ89IvcGfHYCp8JyVK/5rQb06nbTYWj6BAO0iIbwJ?=
 =?us-ascii?Q?GA/OA7aBGHtANZX73IfO+dBrqnvYk+6xqgAv9wFBn4r8GDjHD3A/33qIj2rp?=
 =?us-ascii?Q?Wh0wMLtY6yl4n1i6ReCxraRsnxjfBpo27QYlkTiNKsgopIRgOsqSzpC97qcK?=
 =?us-ascii?Q?e/r94zciGHEUxX+VTXnzY3wzjRW+0WZmcGMhttSQqZxur4f15cPuTpAzDPm5?=
 =?us-ascii?Q?JR3ga9i7+SEId40Ibb7ONgvwYFpk+FkB8rRhu1ae9Bz0DAqo9gFBikwKxHh+?=
 =?us-ascii?Q?otqBOsxFfst5NUKO8aTH8wchF6W6X8XUdAgNO9M+MfEs8ZcxxU3P78EQ3Ij6?=
 =?us-ascii?Q?osWrUbmB+P//olnoUgxHe9D+LLLg8cw5RFQPYUR90w6GgTc3W7g4SVT8V6ER?=
 =?us-ascii?Q?7ioaMettSYnnvr9Sm7arbxYktWra6HhdZWokZ0z/VhXnfcsNcm3E9VskxE5q?=
 =?us-ascii?Q?fiYEUL22QfBFHUmcXbZLrNvczRHMuyFi2O/gpudCAUI5oUv/hbCMVkbGb24j?=
 =?us-ascii?Q?vfxOzeF42bRJ89OlnrmlUh6LpB8DRngK4DP9M3jwKoU5k3HOcGi/+hxVy73r?=
 =?us-ascii?Q?RlLKiovjPfye6z47Dxk3ARU8brxC/FrU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6G67Lw3j0AyyxWS/I9OIYjKjFXlOUJsMHGm/jRN8cJWAPhJFUuQ2U9mrfvMP?=
 =?us-ascii?Q?sneXJ0UTZId8j8bgJ6ehpYhEy0xS9zb4ZvRUE+7kwCxk1/+qSKvQaI7L3Hl6?=
 =?us-ascii?Q?LDySOu71jV3uGCsqtiPu2YPTi65GfEYLvq1YiYLypLDEe7mBGz1EjCVkvVf8?=
 =?us-ascii?Q?wk1hCashUdDzEsOhQLtyBWm+zNOcxjNPZjiHDIWxX+4mv+wqYeOnXBHKWiCh?=
 =?us-ascii?Q?ZyphRsBYxs9jaUF6Q1xTmqxH5nSqycVJccWGP+zGxwYRCAftgwcsOIIGHpgk?=
 =?us-ascii?Q?XJwh5YrnTw2C+auDKoaFO6JoJgUvakDP/OU6iPxrrIlL62+kSv3f++HYtoln?=
 =?us-ascii?Q?bHDbISEOyNGifTbM8zXPtUwPl9jwgbzSFf2QQuc8sVOQPxp4mlDLdgr/huHM?=
 =?us-ascii?Q?VwLMW6RyF+isMpAJOoBf+CERCzDLz/OTBquQRgWC8sj7O72AmLYLd9kCHdkJ?=
 =?us-ascii?Q?e3nZ0ZkwvVCynjfbzUmrTkmx35KYHsWsVrLyw766c1yB9q3Uh3/2mGZmVD3x?=
 =?us-ascii?Q?Q5pxDxyg+Zgauzx3MdqM/SHnciR6YD2+6ffv1bq8gkDjXq8bvRW+YeRiDiqH?=
 =?us-ascii?Q?OjtXvYZlFJOzYoy4IoiCmSG/pncqgIdDqJ/FXtDaBiJ6IDeRRHNONXne7UpC?=
 =?us-ascii?Q?PkhmGOMZua5lK7i+bI4lL97bH8/yJ9V917YDEbbD2GG3s1f/QIog6xXxXo4m?=
 =?us-ascii?Q?w6oOEWV/YPedM78uVXh6+zarUNJ5sppC/Zec4VHwxHAfixUdDsNvJ+NNyMhR?=
 =?us-ascii?Q?3WhF7GYSpoEYq+ZquPvqnvrCjO/k7Dm1Z8F4clxbbBYszTA7Ti79+Y8ntuOt?=
 =?us-ascii?Q?HsmvxllkN940eHVavYPrl6qWWU1Jp/ogFSq5FN2+KmdXn3CYbtRqs+Zfl0G0?=
 =?us-ascii?Q?2HzqLT2h6EvOARBWg8ak2fpVSwIPSG44xYAMR8dq/v+QZ2lsn+0n9yuObP6S?=
 =?us-ascii?Q?HqjO/cBFnsEPVVoMJF1Wi96D8xFj5p1TWQyGXeyvhU2bnxP3pStnz2e9WgC8?=
 =?us-ascii?Q?YQqICihMsRvydX76/lVMx70/uZvK0xr4m3zHKC008SWT6hdXkqlsL2hcz3ap?=
 =?us-ascii?Q?aZ3eF0rYFZv9gM7AvXIoPvRdJYLiyiCwVTZCRJP8Jw22KMK5kGX3a3h8sblE?=
 =?us-ascii?Q?7nVM4sODHgqxz7VMhED9ZpvqlvV2gWTrPJAB8uDWUxj0NHH1h4eUmddDCCOW?=
 =?us-ascii?Q?yd3oamrmy2ZWYUId36/ogInwYxJb7igYD/SfJdCnhz+U+aJ4BgD5hNao8BJr?=
 =?us-ascii?Q?zR8yLtGpYLcDdgVSCriv3KFGpGaM7eYaL1a1RazKpRhg6qYOWq8Z72w1mTAs?=
 =?us-ascii?Q?h8/XMPHMSRDmwj2kNi1lR9WC48GisFNT3lwvJ+GDJOQLOsl6+9vv6vBffHlC?=
 =?us-ascii?Q?Ox8VT0u1K8cN8u97b65FR0qemnt0liETqNMbEvdSfomswPn9NMDUZDgIJtkW?=
 =?us-ascii?Q?poYPLUkvxYtkdDKMcIUWrxE5yefnvN7z3R0QeC6KEwmxUh2WdcWq5E6VZMTJ?=
 =?us-ascii?Q?llfa5pRVdDiOThQKJ9D8iJw3/HKXZb1QALrL0KN90JAVxcUEBXxSQfmaOM+1?=
 =?us-ascii?Q?s1O1KzmJMv7gCUChwxu9/9Y7vPCrB9TDIskaW2BY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79a4cd3-e025-40ab-5d4a-08de3ba786e9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 06:59:44.5645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwVzdsfesPqcMrhP9jkgCWGoRjdLPZY0VW1RIpComFgm8K7eL5FO9G5zSgdxO0Jk3VHVGu1KH4XaC9C398g2yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC855560D7

On Sat, Dec 13, 2025 at 01:58:49PM +0000, Vadim Fedorenko wrote:
> diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
> index 2b0a90581e2f..9d6f57399a73 100755
> --- a/tools/testing/selftests/net/fib_nexthops.sh
> +++ b/tools/testing/selftests/net/fib_nexthops.sh
> @@ -31,6 +31,7 @@ IPV4_TESTS="
>  	ipv4_compat_mode
>  	ipv4_fdb_grp_fcnal
>  	ipv4_mpath_select
> +	ipv4_mpath_select_nogrp
>  	ipv4_torture
>  	ipv4_res_torture
>  "
> @@ -375,6 +376,17 @@ check_large_res_grp()
>  	log_test $? 0 "Dump large (x$buckets) nexthop buckets"
>  }
>  
> +get_route_dev_src()
> +{
> +	local pfx="$1"
> +	local src="$2"
> +	local out
> +
> +	if out=$($IP -j route get "$pfx" from "$src" | jq -re ".[0].dev"); then
> +		echo "$out"
> +	fi
> +}
> +
>  get_route_dev()
>  {
>  	local pfx="$1"
> @@ -641,6 +653,79 @@ ipv4_fdb_grp_fcnal()
>  	$IP link del dev vx10
>  }
>  
> +ipv4_mpath_select_nogrp()
> +{
> +	local rc dev match h addr
> +
> +	echo
> +	echo "IPv4 multipath selection no group"
> +	echo "------------------------"
> +	if [ ! -x "$(command -v jq)" ]; then
> +		echo "SKIP: Could not run test; need jq tool"
> +		return $ksft_skip
> +	fi
> +
> +	IP="ip -netns $peer"
> +	# Use status of existing neighbor entry when determining nexthop for
> +	# multipath routes.
> +	local -A gws
> +	gws=([veth2]=172.16.1.1 [veth4]=172.16.2.1)
> +	local -A other_dev
> +	other_dev=([veth2]=veth4 [veth4]=veth2)
> +	local -A local_ips
> +	local_ips=([veth2]=172.16.1.2 [veth4]=172.16.2.2 [veth5]=172.16.100.1)
> +	local -A route_devs
> +	route_devs=([veth2]=0 [veth4]=0)
> +
> +	run_cmd "$IP address add 172.16.100.1/32 dev lo"
> +	run_cmd "$IP ro add 172.16.102.0/24 nexthop via ${gws['veth2']} dev veth2 nexthop via ${gws['veth4']} dev veth4"

fib_nexthops.sh is for tests using nexthop objects: "This test is for
checking IPv4 and IPv6 FIB behavior with nexthop objects".

I suggest moving this to fib_tests.sh. See commit 4d0dac499bf3
("selftests/net: test tcp connection load balancing") that was added as
a test for the blamed commit.

