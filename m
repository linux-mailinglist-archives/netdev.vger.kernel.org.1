Return-Path: <netdev+bounces-170253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20215A47FFA
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D607A627C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB922D7B6;
	Thu, 27 Feb 2025 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nytgn8Jj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E721BF24
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664404; cv=fail; b=hyh9tehmGehC86y4QxYJOMKVnWsSp8XynvSTpV034m0yy7RtHMSrdn9B2CS7ORPaeEL9yl2exYWoVsnmybDwwanRFaeGTQm2qjIL2yv/hnH3VlO7TxJBQ93ocYWfahySh4yOehEbpeH4sKbB3SD3QSKaEFFZBV0HwBO1i/Y7LQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664404; c=relaxed/simple;
	bh=IFEvCxDwUNoxFcIArIqVMdAH1grUlBgtX7V7aNrdpLg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FJgckZjc3WzDfRw4OkY9EVuLUiOAGPSafYfUtRuZKtQ7wZcmGV0nr7bn2klx50qU/ApQWYxB8BDyf6xrqx4zB4uouUAD3CIHxTSZ/TohEoWal1Aapu6Gl5fhvjZGdHTbvUTfkEsXiOOq2QGGmOzmC6CXzIWsVrz6hifdP4+3BXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nytgn8Jj; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL9E/KzcVouI4w2mlO4VYVLnFGUfDbPrvqp7/GoeRK+dZViMvZFPn2LEco3hdjj2zb7CodPQDR6le6aa3KJTDzAl2MHiJND78Xk2BzNeS2F2syDtw72+aP/u3EHr43JoRYD3zq33/WIIXTr9lqdwSJ0pYTltHO7PReI/J+/1de4JE3cau++dcudlzQ8HxrgkBJcDtm47E0awZY4ake0WYHGLIy95mhYdHHADZPGuHmeMtD6Bhs33oRwqcRKrtn0qYlCRPpOnmrnbwGR4Tobno2dlGO+asTLVJQAgqajC3w8FnY7T6J3/2MJMqgfJcfnfC54db2cqaTpOWjNFWTRS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I04brQVVT8p3YQ21L/2X0k/6jq3mH0MbZpfnDmobcSU=;
 b=MhuW3NAO2ocf+S4WvaWFVg4mfjyRF7n2ijrwjJBXpSSaKMxmkCJNRQffDEE6pWqbL90W15KJX6ieErSapVzxd+0Rr1pl/YlyGaiJmdNq+rrphOxqXD3ulhDCzDi/OIwKIjxd3+a9EmGOS4YJhgJtFTnjYzYz28ZdZF9ZZu3LnGg1+KAMkFjeqFMHr84/79Xlsb3P78Daw8N66/H2TZUabisL6G1kHckZzwhkKuEr0eeFea7snSz78cFWwFO29K/eJnKvmOBHGhOiah2kIwAxIHbVK81ztgOXhX13fHmrOasWeCNThiRD89tojJ/SjU/+VsKo0Z/dfKbqD/kvaxOkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=idosch.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I04brQVVT8p3YQ21L/2X0k/6jq3mH0MbZpfnDmobcSU=;
 b=nytgn8JjtawkeJ2AHfMNG0Il6NNsSygQ69/mW8S16GTyEF2fFRQaXwUKtBrvGr596A6K1996PB9Kx8ITpy3pdFzm+mwuHjVN/G3+JKN6PBdsYge9Efwwzy9HkJjo5kIOdOjKQI+HtpbDm53dZbLlzHK2S51A0bkR3ccoApdxfAOsMnycdCUWKknGho/MCfygFVEYWweSHjEckyhNHIxqovzG6WAgjE0cqlDUcKq931KtAZyNhwSoYxWlcwBYROPD6pCD6Lm7I9So4jbZr/Ln3BgYHl2VPFFU19ON2GvE3xBAVZvaBGAB1kxzNUYHRRuyd6R2sJqB2Li60S6I1gVy2Q==
Received: from MW4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:303:16d::9)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 13:53:17 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::a5) by MW4PR02CA0024.outlook.office365.com
 (2603:10b6:303:16d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Thu,
 27 Feb 2025 13:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 13:53:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 05:53:02 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 05:52:58 -0800
References: <cover.1740493813.git.gnault@redhat.com>
 <a05174174b9fa6a79a9c3ee32e7a5c506d8553aa.1740493813.git.gnault@redhat.com>
 <d1e3d6a6-90b8-45bd-a57f-c8175d0bd906@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, David Ahern
	<dsahern@kernel.org>, Antonio Quartulli <antonio@mandelbit.com>, "Ido
 Schimmel" <idosch@idosch.org>
Subject: Re: [PATCH net v3 2/2] selftests: Add IPv6 link-local address
 generation tests for GRE devices.
Date: Thu, 27 Feb 2025 14:13:34 +0100
In-Reply-To: <d1e3d6a6-90b8-45bd-a57f-c8175d0bd906@redhat.com>
Message-ID: <87v7svfqa0.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d6ba3f-31ad-4e7e-97a8-08dd5736160b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BX0a/pvY78qGWJhHAqbM7g5qA2lS07rMWw5AAUXyECsLAKEHnZ5oPxumbv1r?=
 =?us-ascii?Q?bfnTmfPPvzHyO7zILq8Hh1BON/olOC0Ms1F0rggZPwb9rTMyAFSQwKZxgMjl?=
 =?us-ascii?Q?5+nNlGPiVTlmEVoLIV82LwsUXIcjEGCnTvpw+y+7U3bYdFTf2JlxJOUh2eFQ?=
 =?us-ascii?Q?P5XTQERMj05Ic759CGIwaX+z4QZX4sgdX4q7UDhuWW9GlbdIP4elaiwgqmnr?=
 =?us-ascii?Q?MMzKvbu5gJdjAlcp+yaOnN09L29ekBw8day0b28+JPMChbz1cssynyKOCEgh?=
 =?us-ascii?Q?EoV6tKzth//r5gcijVdcFs25p7UnbKqJjL7OkQ35UGh1HR4weR4QqbGB3FDm?=
 =?us-ascii?Q?xYnz6vjXObwT6TeRNm5vuFyHqnrKBQRTH6FASiHoNJ4dZmccOfWxvO1X7xlg?=
 =?us-ascii?Q?0Ih9i1IdysZQiI+9M1LjT6qUF+r7veUrhCM0CWlxtK38ZW6BUZfNKPH7hd2c?=
 =?us-ascii?Q?MOtq/69xfAEfI5GqSMCnKVWSH2EVQwgIf4rujHSm+c4TgoM0+Lc4G7uMfnAV?=
 =?us-ascii?Q?obO6WBGCNzBQl88zB6/WleQ2bf3/nkCgSgsmMHQaiKgB2gHINdWZl1o7EFSY?=
 =?us-ascii?Q?QRNng6f+YfE2liZm6yUDB9uKQWpxEIGlc2pyQ6ioDCzZwwrHx+imYGZK9Vad?=
 =?us-ascii?Q?H5bMI5cNi8q7bZLUSUHM56EbrALPUYCt0jwn2Bu7IYx/n7lVW50oN6uA+EDs?=
 =?us-ascii?Q?AQHM6O19WwkRVLtVZHm7kl1kuFVoatS8r0vokULWOBXx97ileFXnJD4E3xe1?=
 =?us-ascii?Q?FchUczQQP2PdoAP5P+Aq1X9S5PJcNsepDwvBqG4LK0e45gkM2cOZ6krq8a5E?=
 =?us-ascii?Q?ZbYge6NMoKigG2jgM6fMDI+OhRMyLbpdHroAhErD9zfK1rpGOQ8b1eUBB39R?=
 =?us-ascii?Q?ppWeqpsQjH/PO8qfwkz8fl+re6iiV1dIb+JR4Cyu6KIPU6rOcJDPjlxIJN/t?=
 =?us-ascii?Q?LTfBUKjQEVtTpfauf4FpbQ13Erwex7IgHvn03fNmpugU0p8wMlzHfy+gm6BJ?=
 =?us-ascii?Q?UTqHVT4i0uBoxKEpZ5YprMCc44bIm1MTpd9GifOY+DHyviuZYZE3rUihD4vy?=
 =?us-ascii?Q?QnR8luCaSTqvWdoMOBvB2P78yIDg4kssPuwJ+5o9tfVmlhBljc4iCj5wZOFS?=
 =?us-ascii?Q?KQ/o3BKNHRMV108QQQoVleJgRxPYXa6QeGqIUvcKHu7MVT2IlarnNQ31RrLX?=
 =?us-ascii?Q?jtIG5maq0jo/6bkRHYA865uU1XEz1Qxpnkkfdkd4MEyi2UcABJ4Chq5Jun9z?=
 =?us-ascii?Q?6es3FmwpAghZw5nhUAlF/b/Jf53+JjEZ5R2uOqQFFWtvJZZejCQLZ9W9j5vT?=
 =?us-ascii?Q?uJXWWQfyZwZobQJhNp5f+cbDILhD6QbSa+9D5VOieFdEyD6a6gSkhTdg30Pd?=
 =?us-ascii?Q?gT6E1jKwz1pnfTB7/xreYorssNw1MLQa2M/WGgE776aNdE/xFrVogGRYyZyu?=
 =?us-ascii?Q?vQm7HGp130xKiP1tlJoTohRNLj5sZUwODoLKvTOPK/g/g+TMoafVlMXxCxoz?=
 =?us-ascii?Q?iqKyNGRz4qFLrJU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 13:53:16.5093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d6ba3f-31ad-4e7e-97a8-08dd5736160b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154


Paolo Abeni <pabeni@redhat.com> writes:

> On 2/25/25 3:43 PM, Guillaume Nault wrote:
>> diff --git a/tools/testing/selftests/net/gre_ipv6_lladdr.sh b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
>> new file mode 100755
>> index 000000000000..85e40b6df55e
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
>> @@ -0,0 +1,227 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +ERR=4 # Return 4 by default, which is the SKIP code for kselftest
>> +PAUSE_ON_FAIL="no"
>> +
>> +readonly NS0=$(mktemp -u ns0-XXXXXXXX)
>> +
>> +# Exit the script after having removed the network namespaces it created
>> +#
>> +# Parameters:
>> +#
>> +#   * The list of network namespaces to delete before exiting.
>> +#
>> +exit_cleanup()
>> +{
>> +	for ns in "$@"; do
>> +		ip netns delete "${ns}" 2>/dev/null || true
>> +	done
>> +
>> +	if [ "${ERR}" -eq 4 ]; then
>> +		echo "Error: Setting up the testing environment failed." >&2
>> +	fi
>> +
>> +	exit "${ERR}"
>
> I'm sorry for the late feedback, but if you use the helper from lib.sh
> you could avoid some code duplication for ns setup and cleanup.
>
>> +}
>> +
>> +# Create the network namespaces used by the script (NS0)
>> +#
>> +create_namespaces()
>> +{
>> +	ip netns add "${NS0}" || exit_cleanup
>
> Also no need to check for failures at this point. If there is no
> namespace support most/all selftests will fail badly
>
>> +}
>> +
>> +# The trap function handler
>> +#
>> +exit_cleanup_all()
>> +{
>> +	exit_cleanup "${NS0}"
>> +}
>> +
>> +# Add fake IPv4 and IPv6 networks on the loopback device, to be used as
>> +# underlay by future GRE devices.
>> +#
>> +setup_basenet()
>> +{
>> +	ip -netns "${NS0}" link set dev lo up
>> +	ip -netns "${NS0}" address add dev lo 192.0.2.10/24
>> +	ip -netns "${NS0}" address add dev lo 2001:db8::10/64 nodad
>> +}
>> +
>> +# Check if network device has an IPv6 link-local address assigned.
>> +#
>> +# Parameters:
>> +#
>> +#   * $1: The network device to test
>> +#   * $2: An extra regular expression that should be matched (to verify the
>> +#         presence of extra attributes)
>> +#   * $3: The expected return code from grep (to allow checking the abscence of
>> +#         a link-local address)
>> +#   * $4: The user visible name for the scenario being tested
>> +#
>> +check_ipv6_ll_addr()
>> +{
>> +	local DEV="$1"
>> +	local EXTRA_MATCH="$2"
>> +	local XRET="$3"
>> +	local MSG="$4"
>> +	local RET
>> +
>> +	printf "%-75s  " "${MSG}"
>> +
>> +	set +e
>> +	ip -netns "${NS0}" -6 address show dev "${DEV}" scope link | grep "fe80::" | grep -q "${EXTRA_MATCH}"
>> +	RET=$?
>> +	set -e
>> +
>> +	if [ "${RET}" -eq "${XRET}" ]; then
>> +		printf "[ OK ]\n"
>
> You can use check_err / log_test from lib.sh to reduce code duplication
> with other tests and more consistent output.
>
>> +	else
>> +		ERR=1
>> +		printf "[FAIL]\n"
>> +		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
>> +			printf "\nHit enter to continue, 'q' to quit\n"
>> +			read -r a
>> +			if [ "$a" = "q" ]; then
>> +				exit 1
>> +			fi
>> +		fi
>
> I guess something like this could be placed into lib.sh, but that would
> be net-next material

The pause-on-fail bits? lib.sh has them as pause_on_fail(). log_test()
invokes them on FAIL an XFAIL results.

FWIW, this is untested, but with lib.sh, I think it would be:

check_ipv6_ll_addr()
{
	local DEV="$1"
	local EXTRA_MATCH="$2"
	local XRET="$3"
	local MSG="$4"

	RET=0
        set +e
	ip -netns "${NS0}" -6 address show dev "${DEV}" scope link | grep "fe80::" | grep -q "${EXTRA_MATCH}"
        check_err_fail $XRET $? ""
        log_test "${MSG}"
        set -e
}

The set +e domain needs to extend over log_test() as well, because that
at one point calls log_test_result() with one fewer argument, and the
shift in there produces a non-zero exit code.

