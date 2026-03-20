Return-Path: <netdev+bounces-269889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKpAKgEvvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:26:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EE12D9863
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B66EA305C8D4
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EE83A63EB;
	Fri, 20 Mar 2026 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GNOF1+A1"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2D330D25;
	Fri, 20 Mar 2026 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005857; cv=fail; b=ZwWLvbisUnjT2hXUXpN/dF6L3F33LeMEd6rUc7CkL74W4QupInRcf0OGMFLj3kB1BXfRSLnXAxLfWe7fPbH7kPzTEnfDKacwo9xaYsY9houpI5dyG8l0W6DcSNnpTZHz10AJ4NQplRW10SXLH02zv2+gBZSIJRx+gDKdgNmLegw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005857; c=relaxed/simple;
	bh=7zji/UtEfCUVsvL5CzrXE61E33Z0IPKmCqRwOArsCPQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ogq3Sl37Q8eGlfsnPmlHcrMVMKhx6Gngl/6pFz6UWHnSxeHyIesE5m8ZbJ/PwmTuhWVPh1MCwklQ24CtCur0eb/KZVou7tVgxkMRkHl6nBCW5RCZiXWt1P6F1vL12s52zX56Zo7B+ZNa+S1CmH/yKH7agtsD7Ti2ae7cPj0hqd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GNOF1+A1; arc=fail smtp.client-ip=52.101.85.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOuxwAXelxsW9x/oeYA0djABJHSJ8dMnDpXWYf6nGk298gMb6QD0ur3qxM4sDtPsOf5A4xW3ptzdKz+dpI4oSq7B3HxS69noMS8OBR/1Q6aJt5a5Rc3HgHz1Egr7k1R6E57TzqjbbiNH3sK3W2XP+8U2xQ6kJJd5Eg0iaGM2PRfmocgenVXQpPq0fVT5pdCWW+e2LoKVBn2RhofZ1gl7diX22Wvcwz8Ipp4FfkEaFj00G2JWOO4zFGBAr+Ng9PHmmnOZEQDuV0c1t7/d7jqdcsg5phWCNUlzlblNmdCYmCiAIs6K4J2ApmMtPydwt6JMSK58CAuQi6PLFHIFtMMPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgY0MO7v8R6PNTpevcqCYqRGU7WFP7P2AlB/Ey+ahyw=;
 b=nPDn9rFHE6QU1E6rbtuziRzTESWxfGbzj942mbwNfInRlrGJi2WGGkBs1F/n0k6/5+Cc0zTbO/sW+5ipRCH1NNyX183hSX4HUacN++PZm7NUwN2vPWUSHC52Lyoi8b8DcvNj5lHMLfvMLURPl3EYiZL8QcRKb5W+KKhEjscLNyGQLRam6ipjPea5TPV+FKco6ndKGIg3I9A9atibtQutRu15a/kgQXoZPaQs1lSTi3Y+QQEQuNXtREqD/FmY4gDdE+f4ag8WdVHmy39+nnlFO4VMR8ihmRPavw6QiXzCjdwszgOoL21gYVHWSleWgtw06CQaMv4M3RI4M4Q1Mlt51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgY0MO7v8R6PNTpevcqCYqRGU7WFP7P2AlB/Ey+ahyw=;
 b=GNOF1+A14oGJNouo1H3IM+33vENHxqEg+n9kXIh+ySRck08WrEVDr2UTahYwCQlLmp1bChKvypENc+GFCNfCcQrVsgIOAeedPRX6CDcFIHWQZtLjx/N2yC37D3LhByxEcpE8DmVAQOnOfL0PTotr38n6UDIkhhasYVhxfXXsF3DthhHdA+G42jCyN1JUNI2FHPb2mIy4zyc4wjeBF6MT8AO9wA+u9jTT7m3fogQlp5f/4vxZjXCbCJB9xnRGleUXjP/TcPcsb+3DGHc2CIi4Pnmt51K4ur3y09YChi2kiJpdPTs8DpD7cFd0jIFuGBSw6Wl9FoFjfvDL0lPsaJRoWQ==
Received: from CH0PR03CA0389.namprd03.prod.outlook.com (2603:10b6:610:119::28)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 11:24:11 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::b) by CH0PR03CA0389.outlook.office365.com
 (2603:10b6:610:119::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend
 Transport; Fri, 20 Mar 2026 11:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 11:24:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:23:55 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:23:49 -0700
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-5-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>
Subject: Re: [PATCH net-next v3 4/9] selftests: net: update some helpers to
 use run_on
Date: Fri, 20 Mar 2026 12:22:02 +0100
In-Reply-To: <20260319160410.2515105-5-ioana.ciornei@nxp.com>
Message-ID: <87pl4y922n.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: c10cead6-729b-460c-aa24-08de867335a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CzESCNNcPGhqSsJScROOLSKHhA0ubCAnqVbjQGwrG3rc3RvFP4p1HuFtU4+Hmj2Ul8m8cGUCvwsVWENFKwJLFVuvj7ZCOPnUI2yEZI6OgHshyXbYIwLMpLT9GiiCH0fmycXrMqpkMZ3R+8mDbgnfVlM9hj4UJa7Ds0WAdTYEg/PJrQ/teIc5s8Hn0KhFFc4nOn3TsYp1BGsErIelJWiBXNfOae9jGojfhBIdFatv3/0DCz/9uj2gDncgx8drxjDhTleGj+XzF67DBdrFUNuhvRguvU4tvI25B+76YWcAFk3RJ3i/F81oWMLjitm/qF00a0SEnfDpcg176no3rsAE6w9zPJCl5E6wh4V8g89w/U4uIlvbC5FZJmJmA5VYYmvgwIyUiMoUR8by7iA6HGq/Utdp4C3aKEps3L0L5UGzGgQYZhGED+hVDLQKmtYQ8FngxIltWiZ5gq8taPdy9WlgTQgIwK3zTzp8YfAphiXjTplAMm2JUQqSYBS8qPKp2Uu040eYXwpmP8IVtBms4OOmtDEcMR5dJlh8Xm08cdVwLbqqxEWqI0iU2Dhfq05FGpiYbz0AEH+wGuc31Emx/gnuy8DxVt/bbVic++Ai5CVOEa8s+rjuCdWVXpygAFb4MjThR8S/9ix4CZqdV+ktNNiIFGiBWLdbG5S/imsyD8TJ1w3rLkZhTfwnZ+Z8uGDL9w1mQuWjgdSJxXcadxINCG702ht9HmGnNY0dRmw0hrD5icEw5zdkiSE5huPUJhw+IALmUluCOzV2lbi4Kn1Bqsq4qg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5utlEWMNn7IZXhddMNm/Bj5T+XdrpFCea0IzTfSnO01+VaoV8aMw0bVhRBGhmMTeK/8ac0nE5geT/AfenKufRAO6kbOKHUpcqzefA6af6a1ElK9aQMgSaLvM+c+Prr3rGO34l3ojwYx5Hus1hwxZCOrLFzkz/MP54HKTRVsVjNgoAh0dOkaihVzvJJzzXOXTYl7BV6Bg3PFV07eLA6RyhSjFeS6+8xGUq/PzwkdBF+MQCRuOeLxIgvySYAay9CWgpjkRHstj7MAZktiWMtrhcInu7pdKwxj5geZG6irhdkpP9fH3NM0/R706CpnK0mEmWnh0V/MCwJ66IeTJWv82DaCgZTnURCG+IvhXqliKAB8Khh1N5WkJL7J24oeqc1udh6XlfR77n3Bcsnr3PvC1kE6U0LIp93AiOGXO74y+HOJ0Hu8VEsMr8Fn474rHIu5b
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:24:11.1200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c10cead6-729b-460c-aa24-08de867335a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269889-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.945];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 07EE12D9863
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> Update some helpers so that they are capable to run commands on
> different targets than the local one. This patch makes the necesasy
> modification for those helpers / sections of code which are needed for
> the ethtool_rmon.sh test that will be converted in the next patches.
>
> For example, mac_addr_prepare() and mac_addr_restore() used when
> STABLE_MAC_ADDRS=yes need to ensure stable MAC addresses on interfaces
> located even in other namespaces. In order to do that, append the 'ip
> link' commands with a 'run_on $dev' tag.
>
> The same run_on is necessary also when verifying if all the interfaces
> listed in NETIFS are indeed available.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

This looks good, but I'm unhappy with some overlong lines again :)

> ---
> Changes in v3:
> - added some more double quotes
> Changes in v2:
> - patch is new
>
>  tools/testing/selftests/net/forwarding/lib.sh | 17 ++++++++++-------
>  tools/testing/selftests/net/lib.sh            |  2 +-
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index fb5aa56343e1..f76de37d0caf 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -530,10 +530,10 @@ mac_addr_prepare()
>  		dev=${NETIFS[p$i]}
>  		new_addr=$(printf "00:01:02:03:04:%02x" $i)
>  
> -		MAC_ADDR_ORIG["$dev"]=$(ip -j link show dev $dev | jq -e '.[].address')
> +		MAC_ADDR_ORIG["$dev"]=$(run_on "$dev" ip -j link show dev "$dev" | jq -e '.[].address')

Here.

>  		# Strip quotes
>  		MAC_ADDR_ORIG["$dev"]=${MAC_ADDR_ORIG["$dev"]//\"/}
> -		ip link set dev $dev address $new_addr
> +		run_on "$dev" ip link set dev "$dev" address $new_addr
>  	done
>  }
>  
> @@ -543,7 +543,7 @@ mac_addr_restore()
>  
>  	for ((i = 1; i <= NUM_NETIFS; ++i)); do
>  		dev=${NETIFS[p$i]}
> -		ip link set dev $dev address ${MAC_ADDR_ORIG["$dev"]}
> +		run_on "$dev" ip link set dev "$dev" address ${MAC_ADDR_ORIG["$dev"]}

And here.

>  	done
>  }
>  
> @@ -556,7 +556,9 @@ if [[ "$STABLE_MAC_ADDRS" = "yes" ]]; then
>  fi
>  
>  for ((i = 1; i <= NUM_NETIFS; ++i)); do
> -	ip link show dev ${NETIFS[p$i]} &> /dev/null
> +	int="${NETIFS[p$i]}"
> +
> +	run_on "$int" ip link show dev "$int" &> /dev/null
>  	if [[ $? -ne 0 ]]; then
>  		echo "SKIP: could not find all required interfaces"
>  		exit $ksft_skip
> @@ -639,7 +641,7 @@ setup_wait_dev_with_timeout()
>  	local i
>  
>  	for ((i = 1; i <= $max_iterations; ++i)); do
> -		ip link show dev $dev up \
> +		run_on "$dev" ip link show dev "$dev" up \
>  			| grep 'state UP' &> /dev/null
>  		if [[ $? -ne 0 ]]; then
>  			sleep 1
> @@ -944,9 +946,10 @@ ethtool_std_stats_get()
>  	local src=$1; shift
>  
>  	if [[ "$grp" == "pause" ]]; then
> -		ethtool -I --json -a "$dev" | jq --arg name "$name" '.[].statistics[$name]'
> +		run_on "$dev" ethtool -I --json -a "$dev" | \
> +			jq --arg name "$name" '.[].statistics[$name]'

Oh, I see, you fold it here. Um, would be better in 1/9 though :)

>  	else
> -		ethtool --json -S "$dev" --groups "$grp" -- --src "$src" | \
> +		run_on "$dev" ethtool --json -S "$dev" --groups "$grp" -- --src "$src" | \
>  			jq --arg grp "$grp" --arg name "$name" '.[][$grp][$name]'

This needs to be folded as well.

>  	fi
>  }
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index f7c54d05758e..14f262a593c9 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -518,7 +518,7 @@ mac_get()
>  {
>  	local if_name=$1
>  
> -	ip -j link show dev $if_name | jq -r '.[]["address"]'
> +	run_on "$if_name" ip -j link show dev "$if_name" | jq -r '.[]["address"]'
>  }
>  
>  kill_process()


