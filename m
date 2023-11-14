Return-Path: <netdev+bounces-47855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AA97EB925
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 23:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DBB1C20403
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA72E82B;
	Tue, 14 Nov 2023 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="pfadFErr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C62E824
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 22:03:49 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF73CD6
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 14:03:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3HuxutDbAIomEQYmWq7URVF/qB2JkeHMz0pt6qwWftHuBQYIS69fjD4i42jDG9easiKWGsCzg7fdTJRiFJAlvwf5Ypl3ZcmEDlV9CyrqADZRVb8D1owEk8LTJ2umbm9nWaFiqgTSFb2DqWMyBZ40qwvS4gDvxLAvZFttzfMpfo8tg/7vhGtjivaZs10kFoM7Ng1iUSaqV7nmuFMSmQ+b7jTtSKxLopx5p/nWjg9cXNOAo7GoUfok+gd9qjORZ2Sx/BtM/dV+L8Ue6+rLVBhQDg3fcf+hfQ9yV9Rxt2jA9IVoLx2qjawzZlyu2IFLBAeVIhCPIun7QH5v+gI1wJvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0xvJYMJtdfuLqOPA/pBIoU99f7V21uB2mZ0vJ9m5Lw=;
 b=h8f0UH221MIXYqcx+cW5h6Rwzho7f3r4ss+MpS8UaG3t0PQEkRrD8IW+EHp+SLSY64mwj0Tux4f2jHYToXjRt7Sqi8XsiyIRZtNVrZr9HR9z0GqYiG0Se9CP3WDn5fgipAQJW0jIqp/oOt/xBQCpNYSngxFZe6bf36+O0MHn+GFRFk7UU2ZDUXDU3a4PuXRkU0ikG0syAtWN4C2odnhn/9dPKZQ5H7AD4YjW873rQVVfGM2FAqw1sbIDqyxiEdXsDI3NnkCfIteMa1tnE1vJt5ul5O4odeUsclGLPwDMsMJGuH/J9bR3ho+rXoYCS/6d1KqgvqbNi5MPh9G1mP4eRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0xvJYMJtdfuLqOPA/pBIoU99f7V21uB2mZ0vJ9m5Lw=;
 b=pfadFErrekm1/QD7M0tWU6PwWVJe2iLV7AE9VuqU1Y0/w6z3RB41xNHPQ0FBSRV+UmtThpa4bAXP5nTAKGTjknZApHJBVhg90vMI8zZQWD4bWE8a9gQJgQ50ftlS+c/SdqcZNx8dY0OoOVgSMv5JSfAVgT4nQX99Xv1GO7AOEQaXJmxqo94Dn0ziRQKsuYA4IKKEz8qDfnibzev9Yc1y/J+HnTlXj/BktXaEthlb+/RZmoDJY3OYiTcOMCg2hLFri3I0iju1EtWpAOdDL5j4nfkhqJ8wq+KlQcVUQ/+ueDa6rg3HQ+Rb2aJcz9ir1FCED1O2HyHSPOkjvlmggdzM2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 22:03:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 22:03:41 +0000
Date: Wed, 15 Nov 2023 06:03:58 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <martineau@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v2 11/15] selftests: mptcp: add
 mptcp_lib_get_counter
Message-ID: <20231114220358.GA3995@bogon>
References: <20231114-send-net-next-2023107-v2-0-b650a477362c@kernel.org>
 <20231114-send-net-next-2023107-v2-11-b650a477362c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-send-net-next-2023107-v2-11-b650a477362c@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYAPR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2dcea8-b8c8-4f86-d01d-08dbe55d8f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vPnEiVf8mBXK248Gj0FyRAntIwj+Ea2Bq00Fw4VyTMpiYJeo7QkO2oVnZguijfgYHXcuhJXnC87vyr1XOB9bN5SPh3merq8XoniBQEyaeqGHJFx6KSgOy3iTfuIPYuU+QC/Bpy3rkVzlWB6+0/1ADBswJXIpZlbCxhydDBsQXZIB/ltqQH0NZPbxDEpKgiC2Cv3bUKMhxBalkm4zjNclSJWZmcjVM//XVnoF75DR4YK1HNL9eodjudVOGMCb2PbnuD2X98EHOq9H9LA8Hy8awfPfuNPMns7rqN1hcvU2BYzYIYOQnZdaafdxVkz7OdCRX30haE8dLCaAWR/J4z7OITMR4n9qyPBqq9OAS7nY1YS0Gjqyw2TAELOrzs0hwlSZ0kcxqG6586Va4UvGJh9bVjvS6jqqSW1if8a2JI9rUvDhNHYP7uMx8j5l76yp6NscLq3ysCZrtc3gp0Ycqol6UANiC7K0Wt3ILp/XcBAmu60PM/nNkKP05Ov3WTpuS8c2rKKSkYbh+ChNg7/Aqpid8JtI/vS88/MYW5724aCZrUk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66946007)(66476007)(66556008)(316002)(2906002)(83380400001)(54906003)(478600001)(6916009)(30864003)(5660300002)(4326008)(8936002)(8676002)(44832011)(1076003)(9686003)(6512007)(6506007)(6666004)(38100700002)(41300700001)(6486002)(966005)(86362001)(33716001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h29yzFslvG9+OWCK1VqCiXrHLN4rMCiMWKIQ7wiW9n7Q3r9uSLb1e4IF+Ige?=
 =?us-ascii?Q?SquYS4eks4n1kSmgFyOxJrpsIc3HAo74a0pxZogrSMKdPBXTQKBTDcjHjVo5?=
 =?us-ascii?Q?owxQ/OKIgOhGZt5LM70XONPMEgIprNq0bpbuSLZx17vYUCUfkHJQYBS/J6Qr?=
 =?us-ascii?Q?YmXOKdhH08/EqzQwCFWXCvq/8mlphgvULOLMJfMa/mgw9LQIAgLLHX2Y7RJp?=
 =?us-ascii?Q?hKjlrwvOtsySHSkA5VLQPRK6ocg4J7H3qZH/7CQhJ85zHsuuD5ok0IAjsvCq?=
 =?us-ascii?Q?eVbUi5gsi5gR/nSs3CAKxvdH7IIKLilMB52XVCT+e89XdO74KOX0NgduznHP?=
 =?us-ascii?Q?BAQWgNjbYEjmP/Yuc+enu4a50UZgDqsknrMHBv25AWJ8ORRGEllFYh+awxi9?=
 =?us-ascii?Q?u/k2heIlr9YeWoD5QgmNMNUntVnUhMf9KAXrA9h3afFgEjthvXCua5Svkbu6?=
 =?us-ascii?Q?uVzz9pktF5D/ypsWkIpkz8zxV4xoyP1Pcu99GGHLpivoQ7HjMJv7V9EqTkQa?=
 =?us-ascii?Q?0VPLF82WolnFV9FIbAQ8hfTCpv7LvonlnlUUj9m6dCuJcI5+1kdKJT8IiTHO?=
 =?us-ascii?Q?2uqRoo6ExWWzc/1bf8o3BddSCWgpkLLCGJH7bIPuCwtlMmAN//hcavsuXqDa?=
 =?us-ascii?Q?C240uG9itpLoSe4BKXhQkro7mGrPME0GkkAITXSBtmR+vttIkxB0lYBPq2GJ?=
 =?us-ascii?Q?N//ybe99m569eVXZwfVJoSzm6wCKs9HqVtlDTk7wavQAB6WMnzf7AlILn7bm?=
 =?us-ascii?Q?vmwrvjil4o9ANR0IzSMoVF3I7nlSDyuKwHiM+sV7OAimQjTXPLuCz9m+gHgc?=
 =?us-ascii?Q?PW0bmQdt2v3ga8NimyDkonLMlVP32tAyYfEHzvS1OL9PPykWJEYhor5XwEzq?=
 =?us-ascii?Q?pbDkvQw9BcTCAT3ikRB9q/9HEMIB16Z2Z7eWel7WTtubaooa+3UcRCmU6Yy4?=
 =?us-ascii?Q?VYS9o3mRb/cIzc4yhWgkze1O87mi+DPBMz8l7tWrZG9UN6w/MAEKMPSRK9vj?=
 =?us-ascii?Q?hty4dqD3g/hrx7iLDNh4kHbtSRymj9H0cHlT/eqPP3R4DJUIwpeoQzAQCqsq?=
 =?us-ascii?Q?ykYDFOUOPyMN73yAofFvQQCnF0Yb9zL+saAzpE1KMsxfk+VRph6iWqbEnP4z?=
 =?us-ascii?Q?P3ZAOomVLRQj5o6i6WIPnX/l7roRmHYSTvIsDVZkUVODQyje1KkLoMOmZPKF?=
 =?us-ascii?Q?MXb6P3hOS8JNoL9u9d6uLGYQByHkzl9HDlvf9myNB6YQexoct0CL9lHmSuod?=
 =?us-ascii?Q?GDs0y3QMoxaqWpAZj2lWQKj4S0al2AbUXJkWvWl8V9a9bAExNvpbEiIK/uUL?=
 =?us-ascii?Q?4haJ5CCl/Mo4BC/SAHnNW/U/LQsAD/qDQT+/xZD7GucjTW977oyYmJRznVgG?=
 =?us-ascii?Q?w2e7Cg1ujaf5e/cYGhkUuTsQRk7AVDShbz0rT0H4YDU8QjHa3Nyi1cmNA9sT?=
 =?us-ascii?Q?oz+LvHTHuLdckE1mUmNxWE24AgIqOhFtRnBMv+/H900/rGOoevHOxBFMrA43?=
 =?us-ascii?Q?L8uHF5//lr51/xK2xwqpshJELEgQdnVxzIp7zj2DRrMW8dIhAxeLk7Glb4KG?=
 =?us-ascii?Q?JIjw1F1yxE0CnfgIILw6ShHm9nhTwR98Boz+RuH1MM4Mz16ajnB33cb/s6LZ?=
 =?us-ascii?Q?m5WTtoUfYu3TdBGVpEUOv++o6PCT7kTKMtAkQA9Z/61ASqAkwQV7IU34YCup?=
 =?us-ascii?Q?WZEK6g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2dcea8-b8c8-4f86-d01d-08dbe55d8f90
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 22:03:41.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dj/CzVZiDQgViBznd2CCKauSSfGdUkEqdHvS12WttGeWG6PGe4bZWLOFBjlXbMfXpL6WV9XVQWWWdxQ3TwoyKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

On Tue, Nov 14, 2023 at 11:56:53AM -0800, Mat Martineau wrote:
> From: Geliang Tang <geliang.tang@suse.com>
> 
> To avoid duplicated code in different MPTCP selftests, we can add
> and use helpers defined in mptcp_lib.sh.
> 
> The helper get_counter() in mptcp_join.sh and get_mib_counter() in
> mptcp_connect.sh have the same functionality, export get_counter() into
> mptcp_lib.sh and rename it as mptcp_lib_get_counter(). Use this new
> helper instead of get_counter() and get_mib_counter().
> 
> Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 41 ++++------
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 88 +++++++++-------------
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 16 ++++
>  3 files changed, 65 insertions(+), 80 deletions(-)

Sorry Mat, this patch needs to be updated. A squash-to patch [1] has been
merged into it last week.

Thanks,
-Geliang

[1] https://patchwork.kernel.org/project/mptcp/patch/a345cc5ff04729307b7b5b3a26f81e4e653dbefb.1699408002.git.geliang.tang@suse.com/

> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 4cf62b2b0480..3b971d1617d8 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -335,21 +335,6 @@ do_ping()
>  	return 0
>  }
>  
> -# $1: ns, $2: MIB counter
> -get_mib_counter()
> -{
> -	local listener_ns="${1}"
> -	local mib="${2}"
> -
> -	# strip the header
> -	ip netns exec "${listener_ns}" \
> -		nstat -z -a "${mib}" | \
> -			tail -n+2 | \
> -			while read a count c rest; do
> -				echo $count
> -			done
> -}
> -
>  # $1: ns, $2: port
>  wait_local_port_listen()
>  {
> @@ -435,12 +420,12 @@ do_transfer()
>  			nstat -n
>  	fi
>  
> -	local stat_synrx_last_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
> -	local stat_ackrx_last_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
> -	local stat_cookietx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
> -	local stat_cookierx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
> -	local stat_csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
> -	local stat_csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
> +	local stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
> +	local stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
> +	local stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
> +	local stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
> +	local stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
> +	local stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
>  
>  	timeout ${timeout_test} \
>  		ip netns exec ${listener_ns} \
> @@ -503,11 +488,11 @@ do_transfer()
>  	check_transfer $cin $sout "file received by server"
>  	rets=$?
>  
> -	local stat_synrx_now_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
> -	local stat_ackrx_now_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
> -	local stat_cookietx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
> -	local stat_cookierx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
> -	local stat_ooo_now=$(get_mib_counter "${listener_ns}" "TcpExtTCPOFOQueue")
> +	local stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
> +	local stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
> +	local stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
> +	local stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
> +	local stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
>  
>  	expect_synrx=$((stat_synrx_last_l))
>  	expect_ackrx=$((stat_ackrx_last_l))
> @@ -536,8 +521,8 @@ do_transfer()
>  	fi
>  
>  	if $checksum; then
> -		local csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
> -		local csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
> +		local csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
> +		local csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
>  
>  		local csum_err_s_nr=$((csum_err_s - stat_csum_err_s))
>  		if [ $csum_err_s_nr -gt 0 ]; then
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 1f0a6c09e605..4cb6ca72f164 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -605,25 +605,9 @@ wait_local_port_listen()
>  	done
>  }
>  
> -# $1: ns ; $2: counter
> -get_counter()
> -{
> -	local ns="${1}"
> -	local counter="${2}"
> -	local count
> -
> -	count=$(ip netns exec ${ns} nstat -asz "${counter}" | awk 'NR==1 {next} {print $2}')
> -	if [ -z "${count}" ]; then
> -		mptcp_lib_fail_if_expected_feature "${counter} counter"
> -		return 1
> -	fi
> -
> -	echo "${count}"
> -}
> -
>  rm_addr_count()
>  {
> -	get_counter "${1}" "MPTcpExtRmAddr"
> +	mptcp_lib_get_counter "${1}" "MPTcpExtRmAddr"
>  }
>  
>  # $1: ns, $2: old rm_addr counter in $ns
> @@ -643,7 +627,7 @@ wait_rm_addr()
>  
>  rm_sf_count()
>  {
> -	get_counter "${1}" "MPTcpExtRmSubflow"
> +	mptcp_lib_get_counter "${1}" "MPTcpExtRmSubflow"
>  }
>  
>  # $1: ns, $2: old rm_sf counter in $ns
> @@ -666,11 +650,11 @@ wait_mpj()
>  	local ns="${1}"
>  	local cnt old_cnt
>  
> -	old_cnt=$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
> +	old_cnt=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPJoinAckRx")
>  
>  	local i
>  	for i in $(seq 10); do
> -		cnt=$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
> +		cnt=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPJoinAckRx")
>  		[ "$cnt" = "${old_cnt}" ] || break
>  		sleep 0.1
>  	done
> @@ -1272,7 +1256,7 @@ chk_csum_nr()
>  	fi
>  
>  	print_check "sum"
> -	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
> +	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
>  	if [ "$count" != "$csum_ns1" ]; then
>  		extra_msg="$extra_msg ns1=$count"
>  	fi
> @@ -1285,7 +1269,7 @@ chk_csum_nr()
>  		print_ok
>  	fi
>  	print_check "csum"
> -	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
> +	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
>  	if [ "$count" != "$csum_ns2" ]; then
>  		extra_msg="$extra_msg ns2=$count"
>  	fi
> @@ -1329,7 +1313,7 @@ chk_fail_nr()
>  	fi
>  
>  	print_check "ftx"
> -	count=$(get_counter ${ns_tx} "MPTcpExtMPFailTx")
> +	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
>  	if [ "$count" != "$fail_tx" ]; then
>  		extra_msg="$extra_msg,tx=$count"
>  	fi
> @@ -1343,7 +1327,7 @@ chk_fail_nr()
>  	fi
>  
>  	print_check "failrx"
> -	count=$(get_counter ${ns_rx} "MPTcpExtMPFailRx")
> +	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
>  	if [ "$count" != "$fail_rx" ]; then
>  		extra_msg="$extra_msg,rx=$count"
>  	fi
> @@ -1376,7 +1360,7 @@ chk_fclose_nr()
>  	fi
>  
>  	print_check "ctx"
> -	count=$(get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
> +	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$fclose_tx" ]; then
> @@ -1387,7 +1371,7 @@ chk_fclose_nr()
>  	fi
>  
>  	print_check "fclzrx"
> -	count=$(get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
> +	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$fclose_rx" ]; then
> @@ -1417,7 +1401,7 @@ chk_rst_nr()
>  	fi
>  
>  	print_check "rtx"
> -	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
> +	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPRstTx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	# accept more rst than expected except if we don't expect any
> @@ -1429,7 +1413,7 @@ chk_rst_nr()
>  	fi
>  
>  	print_check "rstrx"
> -	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
> +	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPRstRx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	# accept more rst than expected except if we don't expect any
> @@ -1450,7 +1434,7 @@ chk_infi_nr()
>  	local count
>  
>  	print_check "itx"
> -	count=$(get_counter ${ns2} "MPTcpExtInfiniteMapTx")
> +	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtInfiniteMapTx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$infi_tx" ]; then
> @@ -1460,7 +1444,7 @@ chk_infi_nr()
>  	fi
>  
>  	print_check "infirx"
> -	count=$(get_counter ${ns1} "MPTcpExtInfiniteMapRx")
> +	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtInfiniteMapRx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$infi_rx" ]; then
> @@ -1489,7 +1473,7 @@ chk_join_nr()
>  	fi
>  
>  	print_check "syn"
> -	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynRx")
> +	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinSynRx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$syn_nr" ]; then
> @@ -1500,7 +1484,7 @@ chk_join_nr()
>  
>  	print_check "synack"
>  	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
> -	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
> +	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$syn_ack_nr" ]; then
> @@ -1517,7 +1501,7 @@ chk_join_nr()
>  	fi
>  
>  	print_check "ack"
> -	count=$(get_counter ${ns1} "MPTcpExtMPJoinAckRx")
> +	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$ack_nr" ]; then
> @@ -1550,8 +1534,8 @@ chk_stale_nr()
>  
>  	print_check "stale"
>  
> -	stale_nr=$(get_counter ${ns} "MPTcpExtSubflowStale")
> -	recover_nr=$(get_counter ${ns} "MPTcpExtSubflowRecover")
> +	stale_nr=$(mptcp_lib_get_counter ${ns} "MPTcpExtSubflowStale")
> +	recover_nr=$(mptcp_lib_get_counter ${ns} "MPTcpExtSubflowRecover")
>  	if [ -z "$stale_nr" ] || [ -z "$recover_nr" ]; then
>  		print_skip
>  	elif [ $stale_nr -lt $stale_min ] ||
> @@ -1588,7 +1572,7 @@ chk_add_nr()
>  	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
>  
>  	print_check "add"
> -	count=$(get_counter ${ns2} "MPTcpExtAddAddr")
> +	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtAddAddr")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	# if the test configured a short timeout tolerate greater then expected
> @@ -1600,7 +1584,7 @@ chk_add_nr()
>  	fi
>  
>  	print_check "echo"
> -	count=$(get_counter ${ns1} "MPTcpExtEchoAdd")
> +	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtEchoAdd")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$echo_nr" ]; then
> @@ -1611,7 +1595,7 @@ chk_add_nr()
>  
>  	if [ $port_nr -gt 0 ]; then
>  		print_check "pt"
> -		count=$(get_counter ${ns2} "MPTcpExtPortAdd")
> +		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtPortAdd")
>  		if [ -z "$count" ]; then
>  			print_skip
>  		elif [ "$count" != "$port_nr" ]; then
> @@ -1621,7 +1605,7 @@ chk_add_nr()
>  		fi
>  
>  		print_check "syn"
> -		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
> +		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
>  		if [ -z "$count" ]; then
>  			print_skip
>  		elif [ "$count" != "$syn_nr" ]; then
> @@ -1632,7 +1616,7 @@ chk_add_nr()
>  		fi
>  
>  		print_check "synack"
> -		count=$(get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
> +		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
>  		if [ -z "$count" ]; then
>  			print_skip
>  		elif [ "$count" != "$syn_ack_nr" ]; then
> @@ -1643,7 +1627,7 @@ chk_add_nr()
>  		fi
>  
>  		print_check "ack"
> -		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
> +		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
>  		if [ -z "$count" ]; then
>  			print_skip
>  		elif [ "$count" != "$ack_nr" ]; then
> @@ -1654,7 +1638,7 @@ chk_add_nr()
>  		fi
>  
>  		print_check "syn"
> -		count=$(get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
> +		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
>  		if [ -z "$count" ]; then
>  			print_skip
>  		elif [ "$count" != "$mis_syn_nr" ]; then
> @@ -1665,7 +1649,7 @@ chk_add_nr()
>  		fi
>  
>  		print_check "ack"
> -		count=$(get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
> +		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
>  		if [ -z "$count" ]; then
>  			print_skip
>  		elif [ "$count" != "$mis_ack_nr" ]; then
> @@ -1687,7 +1671,7 @@ chk_add_tx_nr()
>  	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
>  
>  	print_check "add TX"
> -	count=$(get_counter ${ns1} "MPTcpExtAddAddrTx")
> +	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	# if the test configured a short timeout tolerate greater then expected
> @@ -1699,7 +1683,7 @@ chk_add_tx_nr()
>  	fi
>  
>  	print_check "echo TX"
> -	count=$(get_counter ${ns2} "MPTcpExtEchoAddTx")
> +	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtEchoAddTx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$echo_tx_nr" ]; then
> @@ -1737,7 +1721,7 @@ chk_rm_nr()
>  	fi
>  
>  	print_check "rm"
> -	count=$(get_counter ${addr_ns} "MPTcpExtRmAddr")
> +	count=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmAddr")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$rm_addr_nr" ]; then
> @@ -1747,13 +1731,13 @@ chk_rm_nr()
>  	fi
>  
>  	print_check "rmsf"
> -	count=$(get_counter ${subflow_ns} "MPTcpExtRmSubflow")
> +	count=$(mptcp_lib_get_counter ${subflow_ns} "MPTcpExtRmSubflow")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ -n "$simult" ]; then
>  		local cnt suffix
>  
> -		cnt=$(get_counter ${addr_ns} "MPTcpExtRmSubflow")
> +		cnt=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmSubflow")
>  
>  		# in case of simult flush, the subflow removal count on each side is
>  		# unreliable
> @@ -1782,7 +1766,7 @@ chk_rm_tx_nr()
>  	local rm_addr_tx_nr=$1
>  
>  	print_check "rm TX"
> -	count=$(get_counter ${ns2} "MPTcpExtRmAddrTx")
> +	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtRmAddrTx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$rm_addr_tx_nr" ]; then
> @@ -1799,7 +1783,7 @@ chk_prio_nr()
>  	local count
>  
>  	print_check "ptx"
> -	count=$(get_counter ${ns1} "MPTcpExtMPPrioTx")
> +	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioTx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$mp_prio_nr_tx" ]; then
> @@ -1809,7 +1793,7 @@ chk_prio_nr()
>  	fi
>  
>  	print_check "prx"
> -	count=$(get_counter ${ns1} "MPTcpExtMPPrioRx")
> +	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioRx")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$mp_prio_nr_rx" ]; then
> @@ -1942,7 +1926,7 @@ wait_attempt_fail()
>  	while [ $time -lt $timeout_ms ]; do
>  		local cnt
>  
> -		cnt=$(get_counter ${ns} "TcpAttemptFails")
> +		cnt=$(mptcp_lib_get_counter ${ns} "TcpAttemptFails")
>  
>  		[ "$cnt" = 1 ] && return 1
>  		time=$((time + 100))
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 447292cad33c..718c79dda2b3 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -231,3 +231,19 @@ mptcp_lib_kill_wait() {
>  mptcp_lib_is_v6() {
>  	[ -z "${1##*:*}" ]
>  }
> +
> +# $1: ns, $2: MIB counter
> +mptcp_lib_get_counter() {
> +	local ns="${1}"
> +	local counter="${2}"
> +	local count
> +
> +	count=$(ip netns exec "${ns}" nstat -asz "${counter}" |
> +		awk 'NR==1 {next} {print $2}')
> +	if [ -z "${count}" ]; then
> +		mptcp_lib_fail_if_expected_feature "${counter} counter"
> +		return 1
> +	fi
> +
> +	echo "${count}"
> +}
> 
> -- 
> 2.41.0
> 

