Return-Path: <netdev+bounces-48869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4777EFD5F
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 04:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82A4BB20AAB
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 03:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8D446B9;
	Sat, 18 Nov 2023 03:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a1Y3OLky"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9230D120
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 19:09:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzhlgPiVMeuu/j7Q1hJEZJ4IrlSLV/K2f21q9fE8f35zY5ET8xj8wUZDpW+tEO/9m4oiMMoWsDL1tixIFiAgx9czjUcorbgbEw7NVRDYYNH8ToKiZiuyclOTzbAeSasq9jh53Co7NY6uAfqiydLFZuGGKmvQKUNmZQU4lsuIkpMwTZi8CucHSe/OnymwZRqcjj14sYszyNs95mQxw5MYp7TNLW9lJFz16qDdcrSVz8gGVBrZstGySP8v1k0QQVghk15Ly48rQ3PaH7FJ85bGF5KlmDqxijdll3RFR/kA2LFrJBrzuh2z+9PGod+wgsIrAv22omZU+8VUdQdNQu1rrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifE7hpRjf2YCf2xYcatsRt5WEDCIjNbnMyxXUqbJ0Xo=;
 b=da+QJi82ROVu00SvMQ2KTr9lXpkRtBkI0oZKqapWKplsl52J7EOO9ldyU8kILjV9nnpQTxTlFVIhFM2LTuVIvLKmeKytZ44mIdTiaM+qQ3yK+SfOYyyuS/bgPthMLRtmJ6zf2kmYzHX4KYMyc8D7NRQsya+7t4h88TDi/iSHJb24VocbGSbv4U8qQhSl+Mj98w8+SJ4EK0BeOmm9I+GvNjkzoUIOs0cjJDKWh1CBMfW73ulXRxEyIbsesn2goXwzNy9Nn/n4g39RJpZIBD/cgrzz6SA1NigtxpISxtJCrnRgugOs5T/WFpKz5V2+z+T0iVzzHGbWEgEEaZKLhvSKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifE7hpRjf2YCf2xYcatsRt5WEDCIjNbnMyxXUqbJ0Xo=;
 b=a1Y3OLkyattUrVlhauHmA+rnCUtVxicJ8oX8C/YqR+6OB3LxjpEIwxze6bpKFWW0eTXbGWIh0/m420MmWx3arok9CXFE5YEb83wgjePYnSkLuvlzQtysshFSJMRWzwXqoholPI2L5Tbu8wTK4EEcnxzYRlTYI74JVVZRr9XVPzbEvkP1dITzeN59NpYjPhiK5g0Qs6EZEyXaBspljm4ZdQ2yR3LXC7Hk6kKdqB1b1LB3z8uoGSerShGz6c7jnyi/3WdfubnxPneehdtGOAclMnW4qZtIJ/XM24HRAiWOXgALXpDE+jTR2KO0qGeXG/iuvewyCuRuBzSsmxeqK9kMBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8847.eurprd04.prod.outlook.com (2603:10a6:102:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.11; Sat, 18 Nov
 2023 03:09:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 03:09:04 +0000
Date: Sat, 18 Nov 2023 11:09:16 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <martineau@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v3 03/15] selftests: mptcp: add
 chk_subflows_total helper
Message-ID: <20231118030916.GA3271@bogon>
References: <20231115-send-net-next-2023107-v3-0-1ef58145a882@kernel.org>
 <20231115-send-net-next-2023107-v3-3-1ef58145a882@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115-send-net-next-2023107-v3-3-1ef58145a882@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCP286CA0347.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c0f63f-e482-438a-47bb-08dbe7e3b7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yzX7eS48rnWuUuXaC+fE5pzK/FFMXtmPwwe/Li/Dm2bFAy9GeJfCy3saZFEQ4F/dEKLTS/FO6FnedO4O+5MfdqNIYXGjogGcDLd16wiU+kvGduSdxr9IRXbZGarsCnHtYEYJzstnCQbJd366rm7y1/M/ktnO1WPZMB9easGXuIf8vqz4cJ0DgMc+d8QcpH08zdvke7kYAvsfw7vDjqlVK9JjVzKgNwMpdLEWNLyHQX9mBHCDWwWu7WjfY4atikb3AxwbmxfavpwMpXs2eQJSi/PHVR/pZpG7Uag0hDoUPladwcdLNfdNw0QpYwoKKqaIvXzTD27607JyoKcEvQlzbO64hXq/8mkHR7zdC9QHM2+sPsx/jzmoR/v1Pvylkg6KXs0p8KVIgMtO7jCvzJq4OOhOjFLoNrr5aldrPVV02PSWSTMq6R4TVwglUpNz2ZTQp0SnH0VRxmYQgvmTsVWu8KJIaWedAGHtkaZJwqqmv0KRbr7KLaMKEgq/00sV22kj1nlsJzdEetoqHdrGsThlpa2JxSTXUs5aURMB1C8BH5VocqB3Ycv2aOINoikqhXCLcMrBjlW1kJkWzPFpPzQK9aQCAu6hNmyf+16LMjjEXTw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(1076003)(5660300002)(86362001)(2906002)(44832011)(8936002)(4326008)(8676002)(33656002)(41300700001)(33716001)(83380400001)(26005)(66556008)(66476007)(54906003)(316002)(6916009)(6666004)(66946007)(6506007)(478600001)(6486002)(6512007)(9686003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6NOWEcCa1HuIHTJRANVhQ8kFlE09qgxSrgv+9zharH9CBWdmm+ujzCCreiej?=
 =?us-ascii?Q?d7vaRF907iXQNFHoexTMqa5XMkmFmGZTsaO+zdTfLsHmkF73oCb00FMlmyAT?=
 =?us-ascii?Q?vdHQ87fI5yHuHfGbLV1Rxkv/9PFaOC7RGIWjDBnoNKlGIhpFdpVriMwuadnd?=
 =?us-ascii?Q?GGoZZxK1ZwVeHYVNNS3i5xCxuuqfDLzNSLv6QIgk9EkC5opzjz5qttUmDota?=
 =?us-ascii?Q?A+BEXUHUgCyJ+7qoteTFoPgme6e8pffezqaSD50q+A4d4/xOrrBsVpbbluDM?=
 =?us-ascii?Q?k1Qzt9vr9LUj+lRQbTxVsXmLrq2mh3REoMKyUbRZl3fxW0178WssSDCaE4UY?=
 =?us-ascii?Q?2rOLaEB2k1c2LQfo6egtKjqyRHU9Dkg2MMjDmJbq/jUSplYRwS/9gI+OG2Dt?=
 =?us-ascii?Q?r0yWXjnxGLvItEfLigpmgt7mB6fWBoVTfpNCkq6xk6yQRLU7U8F/FwtEPKkm?=
 =?us-ascii?Q?8/7ND4VCYLcy7PvZsuF4Jj+9MEwwbyj6QbiEwjnpHhj5ZMyJA7VQqLOoQJLc?=
 =?us-ascii?Q?8JI4xfzFCPgjSwwrOdQIkSZzi0IoVOQ7CWk/BfvPul757ncPmOIPF9UO6fM2?=
 =?us-ascii?Q?bUekABZgTJ23CFS4CayMYeQ0foaL4HWUYrm9c/rY2j0OOp1A1PiB0aNcRA1U?=
 =?us-ascii?Q?NQFsd9EyzZfnyGloDBU4qvYqZ4m6QgkO2v2yx96L4a3XjjriAiO1mjBdlOUf?=
 =?us-ascii?Q?ISiFF+cnpj+rVhIZ08+AknAPk4ObuaLaq/kl0Vvpvu0YlXsBT2cEhfAChOFg?=
 =?us-ascii?Q?+jBnrC/yncWySeTnIJgzhsuXhJKmj7lsMyXRd2LuOi96sOqRO2/0ARJp4sdC?=
 =?us-ascii?Q?xuCM+ueqtMUK/PMmuflCwIRPEzf3dLOOpyBw/ewshv8gqApdvq2ZS6KUiXyh?=
 =?us-ascii?Q?gBj+wsfILgjAnHsk3z+5NxoLhawQqE94H2SFATE2Lkpgj6StzFoCWDHFC5HM?=
 =?us-ascii?Q?vSsdVnz+v/R81gsWn1aiKRFz+FOGP8sWM6frrfXfUk+VzdxAZNmMU/49iTTH?=
 =?us-ascii?Q?lm1wxDBU78R4Ia1nWVb5A33jldpUEAAnJhWFc7CcDHRWdpV41XxIApDzWYhc?=
 =?us-ascii?Q?VJflE1T8gFM7hWlyskHCrMknTCW9Q2UHabFPagEMNohd4aOn5FuvXavqh+3m?=
 =?us-ascii?Q?YpAm1migxdfN62Fo8avcHVjQcde8+bal9qk2sejEPiiuKSXCqFAWQM99kBg/?=
 =?us-ascii?Q?0vibguodTkZ0rs/qxAU56SO9ZJtKMQDHRYW0XZssJhu9ir3H5biWLpoVxbkF?=
 =?us-ascii?Q?au6difrShoCtQn4fJ6N0lDQRBPFbOn35xT+QaUKayl6kRrk6HDn76C7aAAvS?=
 =?us-ascii?Q?AWsIOIiz2M6ez81Ni00Qi+TqwvnSzyolXZGRHjPmOkJr6j7rlykV9XHR+3Y3?=
 =?us-ascii?Q?VpINeKFuJOgrW7IZhiLE8+eb4cDVJ7Ut94TIXvm7wGC0sHcnqImNmj4f8Dmg?=
 =?us-ascii?Q?x1q+eLcFXj3BFAkGCqeoqiM9dx8twl92NzxDM6fLwe2VROy6xXdfDcCFdTMW?=
 =?us-ascii?Q?bm3KQwpI6ucG82DjGcHZrQ2nb2rP9eEkOIg9QCUCA7Vah0vqT8cmnWPIsdRV?=
 =?us-ascii?Q?SCCcePJsG7KoMZqTLl2X/tzj5d5QPTZ6xNO5U9yB/Dom4HrD/tBCJ8yWI99E?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c0f63f-e482-438a-47bb-08dbe7e3b7ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 03:09:03.7335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lfm8CD/2PZcjed+oZV+Av5zi1cfWRKVn4Fx5SYsafDwbiTeH4OB99LqLeoASorsYRwMeept9ug+4u+/Wni0U0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8847

Hi Mat,

On Wed, Nov 15, 2023 at 04:31:31PM -0800, Mat Martineau wrote:
> From: Geliang Tang <geliang.tang@suse.com>
> 
> This patch adds a new helper chk_subflows_total(), in it use the newly
> added counter mptcpi_subflows_total to get the "correct" amount of
> subflows, including the initial one.
> 
> To be compatible with old 'ss' or kernel versions not supporting this
> counter, get the total subflows by listing TCP connections that are
> MPTCP subflows:
> 
>     ss -ti state state established state syn-sent state syn-recv |
>         grep -c tcp-ulp-mptcp.
> 
> Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 41 ++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f064803071f1..2130e3b7790f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1867,7 +1867,7 @@ chk_mptcp_info()
>  	local cnt2
>  	local dump_stats
>  
> -	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
> +	print_check "mptcp_info ${info1:0:15}=$exp1:$exp2"
>  
>  	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
>  	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
> @@ -1888,6 +1888,41 @@ chk_mptcp_info()
>  	fi
>  }
>  
> +# $1: subflows in ns1 ; $2: subflows in ns2
> +# number of all subflows, including the initial subflow.
> +chk_subflows_total()
> +{
> +	local cnt1
> +	local cnt2
> +	local info="subflows_total"

Sorry, this line should be added here:

	local dump_stats

Otherwise, no place to set 0 to dump_stats, if a test fails. Then
unexpected dump infos will be showed in all the subsequent outputs
of chk_subflows_total().

I'll send a squash-to patch to fix this.

Thanks,
-Geliang


> +
> +	# if subflows_total counter is supported, use it:
> +	if [ -n "$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value $info $info)" ]; then
> +		chk_mptcp_info $info $1 $info $2
> +		return
> +	fi
> +
> +	print_check "$info $1:$2"
> +
> +	# if not, count the TCP connections that are in fact MPTCP subflows
> +	cnt1=$(ss -N $ns1 -ti state established state syn-sent state syn-recv |
> +	       grep -c tcp-ulp-mptcp)
> +	cnt2=$(ss -N $ns2 -ti state established state syn-sent state syn-recv |
> +	       grep -c tcp-ulp-mptcp)
> +
> +	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
> +		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
> +		dump_stats=1
> +	else
> +		print_ok
> +	fi
> +
> +	if [ "$dump_stats" = 1 ]; then
> +		ss -N $ns1 -ti
> +		ss -N $ns2 -ti
> +	fi
> +}
> +
>  chk_link_usage()
>  {
>  	local ns=$1
> @@ -3431,10 +3466,12 @@ userspace_tests()
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
>  		chk_mptcp_info subflows 1 subflows 1
> +		chk_subflows_total 2 2
>  		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
>  		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
>  		chk_rm_nr 1 1 invert
>  		chk_mptcp_info subflows 0 subflows 0
> +		chk_subflows_total 1 1
>  		kill_events_pids
>  		wait $tests_pid
>  	fi
> @@ -3451,9 +3488,11 @@ userspace_tests()
>  		userspace_pm_add_sf 10.0.3.2 20
>  		chk_join_nr 1 1 1
>  		chk_mptcp_info subflows 1 subflows 1
> +		chk_subflows_total 2 2
>  		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
>  		chk_rm_nr 1 1
>  		chk_mptcp_info subflows 0 subflows 0
> +		chk_subflows_total 1 1
>  		kill_events_pids
>  		wait $tests_pid
>  	fi
> 
> -- 
> 2.41.0
> 

