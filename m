Return-Path: <netdev+bounces-169456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88EA4403D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C643BE080
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70686268FCD;
	Tue, 25 Feb 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hPjE2+1k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6F20C015
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488924; cv=fail; b=Rs+PyrEbjEXY1DUi+fFXPUagaGYm25Ob2lIcp3loo4mnyIb3C9kgQF+B1kdvMf4De+jV4osItgvrButhYlYhcKVhWR0UQcKi+vmzd2jqnYLNYl573aSfmp38nKTp7XGcatGZsTGlHlRvCQZ0xTVqGoUB5skq6ETMkNFdCuqyruw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488924; c=relaxed/simple;
	bh=0qy6wmpsVaREQUUxqK18ZAJSBp7o3ehlJHupR2Pg8pM=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IOCSXCaUVUh/JUw2MclD+bDfVkbYxI9GnHOnANgcVzVLo/eDWUceFqSYObnrQEKSbrmpxTXURF4oCWXqyITOsz9H2eMk+d/uLs7hPoZ176Lbz6F4yfMfC6ssykcZhwFG+uPbJfw1H2Ja33y4OSZ3KS8pSJClixu0bj7NqZpBbaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hPjE2+1k; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1aHb6lk6QM7xdUG4c8J3txcyOrMRSFcWP3vcqIH+hC1VdJSixRIZXOWRep3R8iblYaBjtIy+PRC86fD0OEGDQEhIPQ8fVYsMB8+2BCNSg3ww42/uxXWMIEUP65LM+xf6CaixSeKL2hSWoKSo3SIvhOdBjW68GFFh6lBTPUhlfR6Xi3+Gj4u3WEfN+eGxlO7FxwlZu43EZnwMMvDKQic1MCkEMBPcIIBNZmI7PpUB0ALjy2n49uBijATFrc8e97GsM4BgJ2iwWF4UClpv01riUH0zPoA3AZoY9v5dR57Jw0xvjBRwXDuqQb2TigUNT/xS9cFcBAXy2fIXNwC3PRdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFlvfsdvrNv4q44H6VjUKcZsBas9Z/+x6ImUeX79bSQ=;
 b=qEPOVKLl5Gws7qEd2u/P8Xkwra8pP0xmvQUsJtrr6u25rKjtXZ7k9TaOir5trtoRNYGzJGRz3THggcFcmhjCeo73DHSK0SbZLpn7i6rOhvT+KDpeI9MUopq4JyrZTK4suobrUO1u3tSabm5e2uWeGj5kiBSM2GXxlfZjG3flMhGs8WmbDK8NAMwDR32aaWSWEquvlYSsxoP6yfUOwHCuD71ARTlbQV5P16emq0CDJpRTnZKN7Qou/+xoBv2ZOiLiPKZABz7BCTOjU/BRyJmI7zZl75V9hFBXeHa5nQtqhzkSHlYQzP10PzBmItlKjb68MpD9hwphdS02bV81bF+rCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFlvfsdvrNv4q44H6VjUKcZsBas9Z/+x6ImUeX79bSQ=;
 b=hPjE2+1kzylWcnN73r4s+2IPoLsfs+/SzQH3GCxw6HD+dmjw1d7m7suWMSHM642zWvJoDWQfHiEBOASqbA8xNP9GuwhoPmcxnHPWTT3BRL0T6hRKVXysl1o0mHwp6Ez9sfmhmja8Zb3IKiupmKqqdmijndt3+k+TnPxA6Y3n/f+HYH7noJsuOfX7kLnzHsFcDgAEEToGsBWHhZRvHr6mjZOBvIHHIenlAKZXwg6t7YOMVsmeu2T5l4iW0+Z6wP8g8tTaA2PhkVOTCXBIgd6A9QgoMyy6wtvi6j9m2+TX59es9OpLfSprFshBmUI6yr2P1QXhazzvm71gpNX2eOeCrw==
Received: from SJ0PR05CA0201.namprd05.prod.outlook.com (2603:10b6:a03:330::26)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 13:08:38 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::2) by SJ0PR05CA0201.outlook.office365.com
 (2603:10b6:a03:330::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 13:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 13:08:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 05:08:24 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 05:08:20 -0800
References: <23340252eb7bbc1547f5e873be7804adbd7ad092.1739983848.git.pablmart@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Pablo Martin Medrano <pablmart@redhat.com>
CC: <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>
Subject: Re: [PATCH net v2] selftests/net: big_tcp: return xfail on slow
 machines
Date: Tue, 25 Feb 2025 14:01:10 +0100
In-Reply-To: <23340252eb7bbc1547f5e873be7804adbd7ad092.1739983848.git.pablmart@redhat.com>
Message-ID: <87zfiagojj.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: febb71d4-6876-4b91-b616-08dd559d84cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lDaFsKnLiE8gliA3sgSLJErablM9RFeLx/a9V1bJvnGhwR1LQeYp4GnCKQG3?=
 =?us-ascii?Q?xfCG6V0WguzJENxDZgA7VjMhmpxBprTcY+ensvRvn9tZvDFBDVo8wXVsD15t?=
 =?us-ascii?Q?xTjGNUUPji/bos4hvQtAg5LtjRKomCL687kAlb4o0dFB9YUSEvbwclTX5bi3?=
 =?us-ascii?Q?ZZHHJi2eTEYhDhc5RQfOKQ/VB6MgFKCV4aNVLt4mj9LeN3KgnpeWzSNlhNTd?=
 =?us-ascii?Q?ydvuhzmS8YVbe/ZFn6d6qGKCkmbJdpUJkE6KDXIMtJofG7MpM8eXW1BuoC0g?=
 =?us-ascii?Q?04RtNHzoSFZtuCN2ULI1YyGIQaKLENACIe3RuOn3REcZg3vVeKuOin8JddSx?=
 =?us-ascii?Q?AX0aqXYVRiZg9zREoIWpE8cx3UkaiFfkRgMnx2CxKDZKL0zkpBZpTwE72+Dt?=
 =?us-ascii?Q?MLK7e05SL28MNi4VqyH/HqG52fFghMQKnKI4z80D/3pnnYvQGxeOIsE9QDTg?=
 =?us-ascii?Q?TkwFIr38D5NEkyXLzGr8BnLLhZFq8Vk7XNyRAY2BtrPIlthRVeuvwkaRb3t+?=
 =?us-ascii?Q?b0AR7BPGRIMq3XMDiCY1kPMm4nbJrA6VvyEtmVHXgbOuWzZw7U9xofaPw4ki?=
 =?us-ascii?Q?QOp0pskEe/cIE+VHAF9SFv7lPmwBlV9DbAL/4OrxA7lXA4R2RYdm7x0pw6W0?=
 =?us-ascii?Q?41mDXX2yJIUk+/M+REqQq+v6hwJBDb/6C+t+xaaHj1m1MAh5hz+1pC98jj7H?=
 =?us-ascii?Q?sM3qsEdWZY6vEL6Gu9h7aniVQSssNxQdW8U1joAEkXAw8SrXQ3qjZjo0/wEB?=
 =?us-ascii?Q?MOv/g8ekr5zwaZ8qO9MuB5jWw3RTWDqtje9NT+0OyGmWl4fa/YRMCeh6tPy9?=
 =?us-ascii?Q?1LDStSS+JB5ZGnGFHhyl5WiFDBmF/IOK4zsNCfAHrlYD8MQo1P9iPBzK+EGn?=
 =?us-ascii?Q?Y5KPedob1Xb9zhC47ur65tjVLS1E78Zf9+eMPCcKTe64Lpu7q2LJOgZsqSzl?=
 =?us-ascii?Q?G5al6hQsrOhGwohf6IEOTOZ2k/dW3/BqvJrsj0j9sJz+iXyUpiD3TnDBqoCy?=
 =?us-ascii?Q?j/m9Aepp/W4jDtM08EOASOlmyIjW0vJ6VmBJ0v+h8R21NRQlZT2YSG+PRT/B?=
 =?us-ascii?Q?Rz4QvBxMwAgHFzuvgawaLTvphSYAAMCgqOlCEbGjOLtEe/6tkOrpC4Jo0fN3?=
 =?us-ascii?Q?BWkyBhe6mFUF0X9rMlx72yxYhV1eBvAk35rDCrUW8qFPQFoStCQkqqbawAIL?=
 =?us-ascii?Q?S7kFGoivtePPS5mGcqIGsV/clERu2KwamOaSzeX53XlmYS+9QTOuNlvpZdfX?=
 =?us-ascii?Q?Cbvn8vqTMWBVD+laVypWnx2/pnyYz3crZwKQ5XoCGoXZSZ7yBMrpMsSLj7kA?=
 =?us-ascii?Q?D0AfifUgLwlYJuCDN5iMUuGD0T58r5Cn2vcTHa3CXNS1lvH/iDDLJgc6O5VS?=
 =?us-ascii?Q?P5iE559GivPSD4i/nM6LUkDfEovbgzy1qHNTRfb0I3vUsLtJI7Zbd6j84tUg?=
 =?us-ascii?Q?D6p4o0NtAKv4jlFPxsaiXlyYvr1leJib07EA/yLaPZARoHWl46lsE2SxhQ4I?=
 =?us-ascii?Q?fSMrTrg1BcYkn80=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:08:38.1685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: febb71d4-6876-4b91-b616-08dd559d84cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429


Pablo Martin Medrano <pablmart@redhat.com> writes:

> diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selftests/net/big_tcp.sh
> index 2db9d15cd45f..dc2ecfd58961 100755
> --- a/tools/testing/selftests/net/big_tcp.sh
> +++ b/tools/testing/selftests/net/big_tcp.sh
> @@ -21,8 +21,7 @@ CLIENT_GW6="2001:db8:1::2"
>  MAX_SIZE=128000
>  CHK_SIZE=65535
>  
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> +source lib.sh
>  
>  setup() {
>  	ip netns add $CLIENT_NS
> @@ -143,21 +142,20 @@ do_test() {

Just a small comment.

In general it is a good hygiene to have a RET=0 for each log_test(). A
test that neglects to set it will get a spurious failure if it comes
after a failing test. Arguably log_test() should do this automatically,
but currently it does not.

Due to all the &&'s peppered down there, do_test() only gets called at
most once, so it's OK in this case.

>  	start_counter link3 $SERVER_NS
>  	do_netperf $CLIENT_NS
>  
> -	if check_counter link1 $ROUTER_NS; then
> -		check_counter link3 $SERVER_NS || ret="FAIL_on_link3"
> -	else
> -		ret="FAIL_on_link1"
> -	fi
> +	check_counter link1 $ROUTER_NS
> +	check_err $? "fail on link1"
> +	check_counter link3 $SERVER_NS
> +	check_err $? "fail on link3"
>  
>  	stop_counter link1 $ROUTER_NS
>  	stop_counter link3 $SERVER_NS
> -	printf "%-9s %-8s %-8s %-8s: [%s]\n" \
> -		$cli_tso $gw_gro $gw_tso $ser_gro $ret
> +	log_test "$(printf "%-9s %-8s %-8s %-8s" \
> +			$cli_tso $gw_gro $gw_tso $ser_gro)"
>  	test $ret = "PASS"
>  }
>  
>  testup() {
> -	echo "CLI GSO | GW GRO | GW GSO | SER GRO" && \
> +	echo "      CLI GSO | GW GRO | GW GSO | SER GRO" && \
>  	do_test "on"  "on"  "on"  "on"  && \
>  	do_test "on"  "off" "on"  "off" && \
>  	do_test "off" "on"  "on"  "on"  && \
> @@ -176,7 +174,8 @@ if ! ip link help 2>&1 | grep gso_ipv4_max_size &> /dev/null; then
>  fi
>  
>  trap cleanup EXIT
> +xfail_on_slow
>  setup && echo "Testing for BIG TCP:" && \
>  NF=4 testup && echo "***v4 Tests Done***" && \
>  NF=6 testup && echo "***v6 Tests Done***"
> -exit $?
> +exit $EXIT_STATUS


