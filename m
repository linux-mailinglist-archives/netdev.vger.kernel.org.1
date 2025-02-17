Return-Path: <netdev+bounces-167076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A80A38B4C
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3071188EEF4
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDF421D3F4;
	Mon, 17 Feb 2025 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gRk1ExRZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073227706
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817200; cv=fail; b=aHO6n3o7gwhkQ5pilWNDZ5gLwmACe3yNUFqwtd70B0cQQUVk1m9r7sLvg0c+LUwowLD5fl/074mUk9eSQo0Lx62qjHZuErz497s3k2FQsdYYfUTzYDfG793IDvrUjtlsL7NFRQL9xkTAPIG12jyegtzHhZKgzTRy7EiEEIFO8pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817200; c=relaxed/simple;
	bh=68cpnrPcgHbXLeVPn3ayFMhbG4e/ad6kYmoRgzkEKTM=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Cy+g4JFaAvuF5B1gtlt4WGkuMjW4TqHiHXNbsnbwGOmj17yVQqSnfwJhWCjGA5Wd8UvxIeqChjjSgHKpt0Mifc4szwls0RqjIgJAEjHwkth/zgEAaNtiPM0HyBidjWDWJT1fSR04fZ9DyMOZTX9p2Pb+DTedl3w5t9lINyEo9aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gRk1ExRZ; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGynErp1Yku7Qz9cHu0ByEjXqv+v5/H0cD0WsfuxoOZHQYK4paZ8xUO8jZypnbNatEFIrGqB3rEiQsljbdLsPWJIV7Jd2IMhE0FCuzTgmnkU9KQHA+9GsKdj3JAoxfg8FXq5AgTa9rGkCahZI85iWV0W8MxLSpxhKiYOVYTWGRy/nntdPaqTqgoafD8uC9Vfe3mZNzVvTvPxRCIgXlPOqbax8ubbGo8Qyoc1pfKm7bZ6qx7kar7IFzJcO3EI64GZWmt0vQQgC8CwpYBNqrvyQDRmKM2J4wmEVWPS6F+5lctJQSPOPjbYbH6R1Eur9XrDexnB6XpATOq72XZimRM5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMY53Dgl9NHik6j0BYVB8Na5Xb7NBiHChRTu9jidtOU=;
 b=BR0AOoYgR/bMcjVj3QPeYv1HaLU6TxCvixKHn9QamgZSC2iYO4D0XczQ/Okeg0/r7Ag7Lp8NQyxX4zU9P5bZz1IQX4yWUmoGPqhCa+wJd472MwXOfPtDrbFUUzh3rgTym8rNVW1PsnnFkmA6zMAgzTVcLOXQp2QcGuTztgcBqFzxnFWgSUimPbMywd+bH/V+8xtnP3qzMYCqL4BJUtRB7HX7TlXZv6PCtXVdu0ECTQqyAIYRwROqDpZRIjLsGh1El5C50eVk6fTWObSMN4kn4BtuJLCilLt6OPdvzPpDv3AWOdHwfu/zhtKN9COiMm96IV6hJZL+XDo42Yr65p0SKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMY53Dgl9NHik6j0BYVB8Na5Xb7NBiHChRTu9jidtOU=;
 b=gRk1ExRZRRwijzGAh8CJAs6wISpfkdYZEeWRUBZY6eOZMHiTX6AbRP7KazsXPw0EyBjkHzAVLYbTDL5/4pOObLnF+yVMO4AnTj5qAy2Kr4oOD1nDBORtWaqGqyH1eBfn/iPbNSEzN4Sswsb4Aex+b1F3QLoHLAxJCCsnBt+EEK+++dS8330p0xdn13EpmOmipMLrCwrGhyHpRcfqHIrLW01uyCG3Q5HtCOtkjB5dHfrS2asmrDvDGsDllbXb8CiwNtuktLKP44HJgVFtuaTPAWjJGb5Vkpld5Nc6xykJ/Z79Ggw2aXUuKuVHfQ02WyV3iAvFBKlg8Ltd9TAKwX6KVA==
Received: from BYAPR11CA0078.namprd11.prod.outlook.com (2603:10b6:a03:f4::19)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Mon, 17 Feb 2025 18:33:10 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::d) by BYAPR11CA0078.outlook.office365.com
 (2603:10b6:a03:f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Mon,
 17 Feb 2025 18:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 18:33:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 10:33:02 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 10:32:59 -0800
References: <b800a71479a24a4142542051636e980c3b547434.1739794830.git.pablmart@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Pablo Martin Medrano <pablmart@redhat.com>
CC: <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>
Subject: Re: [PATCH net] selftests/net: big_tcp: longer netperf session on
 slow machines
Date: Mon, 17 Feb 2025 18:50:08 +0100
In-Reply-To: <b800a71479a24a4142542051636e980c3b547434.1739794830.git.pablmart@redhat.com>
Message-ID: <87tt8sfmlk.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: c97ad517-6754-4a5a-03ba-08dd4f8187cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0tmTDByU1M4QzF5ZkxaQTZhYzMzS0YzQ1VESGUyUTR6SURPNEVnOU5BaGRw?=
 =?utf-8?B?TFp3eVpCa1FNbGtWNGdpVlprNko0UVRaR1NRblVzSllJdU9Jc3E5QUlMVDdY?=
 =?utf-8?B?L2RRMGxkWkhDeG5Sc01UWlZKd2ZoUEFhbWt5dDFkSzBZMnhZMWxHVEJoQ2lX?=
 =?utf-8?B?WVl3a2hVM2dFeFI0ejZFb1RTWWh5RHcxU1R5dGRVYm1pNlNNMjhWQnZQWHpr?=
 =?utf-8?B?RFlHS1dCbWV1QUJVNm1uRG1TL2hpR3ExOWZWa01sOXBiUjREUHVaa3E4OWlC?=
 =?utf-8?B?Szh0Qm1mZWEreFVVZFNlcGRLNVhaSHIzYVNsbUYrV2Z3YmxVNG4weTNjL1lr?=
 =?utf-8?B?eERGYjM1V09mL2x0UHNYRklmajlPUGg3aC9VMTZSOVEwZ3JtcXZqU2RYTUE1?=
 =?utf-8?B?Vk5ZbHQ3V2sya2UxNFpPdnRtWmtwVzVJUS85ZVd2dzBJNXNRdzBFdUVoRTRk?=
 =?utf-8?B?UXpiMVVrRTJMYm5rNktRTXNYd1NGcE85Q0FoRDFRRVFRelQzTXM0VnFzbzNJ?=
 =?utf-8?B?VU80TkJYT2hVL29lTHROeE9KRWd0QUI0Vi9DRWgzRTUyWEZnL3FPcHVRdjd0?=
 =?utf-8?B?bElra3hzWXlpb3RjcHk4NzExTERrVDRDbVV0aVNTWExhV1Rqc3M2ZWI0d1kv?=
 =?utf-8?B?MTVqUGlRYmdyTWkwSVdFQ2YvUC8zR0w0WE1id2t6SW5KdEdiQStPeEF2bmhh?=
 =?utf-8?B?QTFTc1ptS3BrS0FCZnY3QjZ2aGFzczhRZUkrL216N3B2Tjdjek4reFVzZGh4?=
 =?utf-8?B?eXV1T2hTbGM3QzMvZ2RwNlZkdEpBWnVERmtvQm94US8zekZEYTZCT0hWeUVP?=
 =?utf-8?B?TWhydFNaZjRicTA0TkVUMDE1RUJyVW9rMDF2cWNrVElqS1g4bEppTFVSTlpi?=
 =?utf-8?B?Znp0RUhTeHRJNVVlZzJydjcwOW9TeXBNRC95SXlrMXpFWTRCVmNQU2dmT1Qy?=
 =?utf-8?B?b1lvdXQrdXEwZ2VlbHRoaEM0Vit0UGFJQkhDN3M5Q0l6YnBJYngwejBVWlpl?=
 =?utf-8?B?emFwUWJ3bFo5MnFVU2EvNTFCaktZQ1FsODByaVd1Ty9mR3ovdVdIZm1IOEho?=
 =?utf-8?B?MktXZFJnNmlJalZJTC9xZ1FpbzZaU3d5WkQwdUtrNmgrRFQ3blJ1MFRzNzlJ?=
 =?utf-8?B?MU8wTC84MExWSmJneTI1Rmt4Vng0TWhNeGpTaTBwNTN4ZG1ZSlZ0REsrUUlu?=
 =?utf-8?B?aGtvK3pmSUYvdGJrc3VTdVQ4WGppNitldXM4cFJaeXgzM2RjRUxLU01EUDNm?=
 =?utf-8?B?dG1nUjQ3RUE0T2p1WkNpeFhTR2lSSDBHRkY1dFhydVRtc0x3eUYvM1pndDhC?=
 =?utf-8?B?ZTl2ZFBRZk1CSzFZK24zTXhnbG1Mdy8vSmtNaG9iUDJjdkhybE1Oajl0WFBP?=
 =?utf-8?B?ZGR0YnppZ0YwVSt4ZDlUVmw5SUpZalJkb21qSkhkekRoMTc0WDZaTXc2Um9j?=
 =?utf-8?B?aUc4TTVnWEZRMG9ycTR4VGo4MnovcENjRzVaTmRaQVQ0Y0FvU3lIbzd5VUpr?=
 =?utf-8?B?bU1hWk41OVBpTlJiYVpLcVlvZkozT1VhbW9rejBQS0JEazBKc09vSzREbXFw?=
 =?utf-8?B?c1ZQNGRxTEZYcVFZMUxya2d0K2lwNXV4T1V2UjdzYjY5clhYMkhhdk1EQjlF?=
 =?utf-8?B?T04xK2Z2aUFJYklTQ3BTUDZmNUNGcllVMVNaRFFiQkdjdlNOc09GcGdrZjNO?=
 =?utf-8?B?TFlheUNtWTM1cDI2RzhVaEgzYmlNSkNKR01PRVZtbEV6WERTUVY1OVdNTXJu?=
 =?utf-8?B?NUJBeUJNRTI5aGJWT2xJTituUXJPQTE1UXdNdzNHWDdzb3g5a2N5aDM2Q3FM?=
 =?utf-8?B?eDdWSTNTdWxoMjc5VG9JWU5pOTRJbUV1c1VHQUUvYitYajFPUFpOVitSaDFm?=
 =?utf-8?B?RVc5QnljMklCZU9Fa2RQakdneEZ4eG0yR29HZDVtWGV1czRWSCtQVGxZRFRv?=
 =?utf-8?B?TnJ0TmlKalVmdEo4TXVzNkdrb0ltdyswaUZLdXBJM1lnZ1JkUEs0YzRrWFJz?=
 =?utf-8?Q?e7GrHQe9XMwKBeQzcxDjmQgv/HMcmo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 18:33:10.3432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97ad517-6754-4a5a-03ba-08dd4f8187cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910


Pablo Martin Medrano <pablmart@redhat.com> writes:

> After debugging the following output for big_tcp.sh on a board:
>
> CLI GSO | GW GRO | GW GSO | SER GRO
> on        on       on       on      : [PASS]
> on        off      on       off     : [PASS]
> off       on       on       on      : [FAIL_on_link1]
> on        on       off      on      : [FAIL_on_link1]
>
> Davide Caratti found that by default the test duration 1s is too short
> in slow systems to reach the correct cwd size necessary for tcp/ip to
> generate at least one packet bigger than 65536 to hit the iptables match
> on length rule the test uses.
>
> This skips (with xfail) the aforementioned failing combinations when
> KSFT_MACHINE_SLOW is set.
> ---
>  tools/testing/selftests/net/big_tcp.sh | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selft=
ests/net/big_tcp.sh
> index 2db9d15cd45f..e613dc3d84ad 100755
> --- a/tools/testing/selftests/net/big_tcp.sh
> +++ b/tools/testing/selftests/net/big_tcp.sh
> @@ -21,8 +21,7 @@ CLIENT_GW6=3D"2001:db8:1::2"
>  MAX_SIZE=3D128000
>  CHK_SIZE=3D65535
>=20=20
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=3D4
> +source lib.sh
>=20=20
>  setup() {
>  	ip netns add $CLIENT_NS
> @@ -157,12 +156,20 @@ do_test() {
>  }
>=20=20
>  testup() {
> -	echo "CLI GSO | GW GRO | GW GSO | SER GRO" && \
> -	do_test "on"  "on"  "on"  "on"  && \
> -	do_test "on"  "off" "on"  "off" && \
> -	do_test "off" "on"  "on"  "on"  && \
> -	do_test "on"  "on"  "off" "on"  && \
> -	do_test "off" "on"  "off" "on"
> +	echo "CLI GSO | GW GRO | GW GSO | SER GRO"
> +	input_by_test=3D(
> +	" on  on  on  on"
> +	" on off  on off"
> +	"off  on  on  on"
> +	" on  on off  on"
> +	"off  on off  on"
> +	)
> +	for test_values in "${input_by_test[@]}"; do
> +		do_test ${test_values[0]}
> +		xfail_on_slow check_err $? "test failed"
> +		# check_err sets $RET with $ksft_xfail or $ksft_fail (or 0)
> +		test $RET =3D 0 || return $RET

This bails out on first failure though, whereas previously it would run
all the tests. Is that intentional?

Looking at the test, it looks like do_test itself could be converted to
lib.sh as follows (sorry, this is a cut-n-paste from the terminal, so
tabs are gone):

@@ -134,3 +133,4 @@ do_test() {
         local ser_gro=3D$4
-        local ret=3D"PASS"
+
+        RET=3D0

@@ -145,7 +145,8 @@ do_test() {

-        if check_counter link1 $ROUTER_NS; then
-                check_counter link3 $SERVER_NS || ret=3D"FAIL_on_link3"
-        else
-                ret=3D"FAIL_on_link1"
-        fi
+        check_counter link1 $ROUTER_NS
+        false
+        check_err $? "fail on link1"
+
+        check_counter link3 $SERVER_NS
+        check_err $? "fail on link3"

@@ -153,5 +154,6 @@ do_test() {
         stop_counter link3 $SERVER_NS
-        printf "%-9s %-8s %-8s %-8s: [%s]\n" \
-                $cli_tso $gw_gro $gw_tso $ser_gro $ret
-        test $ret =3D "PASS"
+
+        log_test "$(printf "%-9s %-8s %-8s %-8s" \
+                            $cli_tso $gw_gro $gw_tso $ser_gro)"
+        :
 }
@@ -159,3 +161,3 @@ do_test() {
 testup() {
-        echo "CLI GSO | GW GRO | GW GSO | SER GRO" && \
+        echo "      CLI GSO | GW GRO | GW GSO | SER GRO" && \
         do_test "on"  "on"  "on"  "on"  && \
@@ -178,2 +177,3 @@ fi
 trap cleanup EXIT
+xfail_on_slow
 setup && echo "Testing for BIG TCP:" && \
@@ -181,2 +181,2 @@ NF=3D4 testup && echo "***v4 Tests Done***" && \
 NF=3D6 testup && echo "***v6 Tests Done***"
-exit $?
+exit $EXIT_STATUS

That way you only really touch the bits that do the actual checks to
port them over to the log_test framework. xfail_on_slow() is usually
called on a per-check basis, but if anything in the test can fail, I
think it's fair to just call it like I show so that it toggles the
condition globally.

Then I'm getting this for slow machine with an injected failure:

bash-5.2# KSFT_MACHINE_SLOW=3Dyes ./big_tcp.sh                             =
                           =E2=94=82
Error: Failed to load TC action module.                                    =
                         =E2=94=82
We have an error talking to the kernel                                     =
                         =E2=94=82
Error: Failed to load TC action module.                                    =
                         =E2=94=82
We have an error talking to the kernel                                     =
                         =E2=94=82
Testing for BIG TCP:                                                       =
                         =E2=94=82
      CLI GSO | GW GRO | GW GSO | SER GRO                                  =
                         =E2=94=82
TEST: on        on       on       on                                [XFAIL]=
                         =E2=94=82
        fail on link1                                                      =
                         =E2=94=82
TEST: on        off      on       off                               [XFAIL]=
                         =E2=94=82
        fail on link1                                                      =
                         =E2=94=82
TEST: off       on       on       on                                [XFAIL]=
                         =E2=94=82
        fail on link1                                                      =
                         =E2=94=82
TEST: on        on       off      on                                [XFAIL]=
                         =E2=94=82
        fail on link1                                                      =
                         =E2=94=82
TEST: off       on       off      on                                [XFAIL]=
                         =E2=94=82
        fail on link1                                                      =
                         =E2=94=82
***v4 Tests Done***                                                        =
                         =E2=94=82
      CLI GSO | GW GRO | GW GSO | SER GRO                                  =
                         =E2=94=82
TEST: on        on       on       on                                [XFAIL]=
                         =E2=94=82
        fail on link1                                                      =
                         =E2=94=82
TEST: on        off      on       off                               [XFAIL]=
                         =E2=94=82
        fail on link1                                                      =
                         =E2=94=82
TEST: off       on       on       on                                [XFAIL]=
                         =E2=94=82
        fail on link1                                                      =
                         =E2=94=82
TEST: on        on       off      on                                [XFAIL]=
                         =E2=94=82
        fail on link1                                                      =
                         =E2=94=82
TEST: off       on       off      on                                [XFAIL]=
                         =E2=94=82
        fail on link1                                                      =
                         =E2=94=82
***v6 Tests Done***                                                        =
                         =E2=94=82
bash-5.2# echo $?                                                          =
                         =E2=94=82
0                                                                          =
                         =E2=94=82

... and for non-KSFT_MACHINE_SLOW, I get FAILs with $? of 1, i.e. what
we are after.

> +	done
>  }
>=20=20
>  if ! netperf -V &> /dev/null; then

