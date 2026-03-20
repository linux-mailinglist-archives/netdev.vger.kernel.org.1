Return-Path: <netdev+bounces-269900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN1+CH4yvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:41:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CB02D9BC6
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 379F73018062
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498236683D;
	Fri, 20 Mar 2026 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rCcrJ0rN"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500A53A7F45;
	Fri, 20 Mar 2026 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006905; cv=fail; b=YrANgNu+HH7RAwZoPqXNdmKDaxI0Uu+6u8F1TPDHHg8eaXXkWEm9fjlq9775IynbR5khbDSFuzokumlCzTsLp8CZHdZ0Oh4rma6jyUr56HYH9b0qKdDq+PkdlmllEwYnwKVoTXn0wVDzPgS/8aYXWew6C+lmHn169Fy/k7eSA/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006905; c=relaxed/simple;
	bh=KdStJulG2TN7wejxFHmkrr9oyHmq6joeK/C5pm5Nxds=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Nhvgyr5FdssWnStvGuSrDGw6Q1Xeeus7Brsy6HbR1jHP+AcwBGEqx5rqysHjBoYHpgHFoAFjbINm3oN7Mg/uCACTn6yfGjxI+Fh85dQkxDVUSJUqUrGvX8DqWNy7y4g53Xkqw4wsWoo6yEGTOUBUtcSH53McfE7lTopLRUEV0bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rCcrJ0rN; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDdGf9aBqR0nhsKYRiTs6wrecSrJzT4d23g77HcmPDxbe8e6JovUpAiJ4m8DlJhzucbx8Vc/EYuiljzBnZEwci5ISri/zlbljuGeDE46LZgHT8+09cfunkUK+D8nyY70TslzFC63j2UoMv65x4D0sdb+52e+mVlC6aEZkqCeEHb6FZ24Jix3ujc3RPK/ioswYNCN2l9CsFMrk0ehbmWzeWCGingGBiQAj7FpfY4HFW1KyUtArmnTICYynPbPnHZlLt6W5PNnpa2h3bn44hDu6X2W57/NBDaZkKVk29mdQGOjLQ6tUizc6p6YkBMS20k2SpAkGnKMzZbfxhn5Zm1QYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnJLdkooX5zZnpEm1BijL2y98EE5BYV8TVGa1iEkhU0=;
 b=BejK48eMmDu+MgqMPZTKkoIhmKuPN/emXTpW2SZTcxZIAnVgIAR3bsvnrhF666fjndZGPvGkq1ImwQ4PB/5dt0cpzgOFnNEEAAit8LAKom1T7OnqLEe/NXXKsQXdhRqXMV/cGzG0jvTNim0JvwDazQWmQ5mvMKGPjPWM/viucHiY7B//84N26pgn1yP5H0fUnQbyr4xNoDndLhVnt9/3kd9dySPUhruuCy4wOIvddC98Shv/rtwQDixdnJfInMlbUOfAG5vU+W9Yyx8hQPKqQhe5xz2Z+Gav5sIMZowdHyEXzwH9laaKUsNmcsRDGtNLmxX6kMwRQxD62WBxvnQ9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnJLdkooX5zZnpEm1BijL2y98EE5BYV8TVGa1iEkhU0=;
 b=rCcrJ0rNEqt82N9HN7SYBashLry8xAop1oEmuq0tGYDTbHS5KgS0BKV7BUAC4S3GmDk1/7N6yabwHGI4eufuMbQJ0SBemOa4iFKCkuog+bklq5rnIn35uVgpv0kwtiGT2XSi45TfH3Sre8Y4J5KxJYPTkPAJ5ID4gtZJN6+cCYXklIy/1hidJJQvVTSWXXJSdHSsEk5uYaNSDD+12BPB7/rYw8xgcbfBg2JnVyQnna7f26w1XgNC0HDmmdmyIIQ1Bm3wVRt01oV40qWWmwpBUG9Dl2cPZZJHoUv7muVUqJ2mWa4ayUq55YO41N7TmbyeUazVmWb4sjg6Gbzz4TyQCQ==
Received: from BY3PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:39a::25)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 11:41:39 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::7e) by BY3PR03CA0020.outlook.office365.com
 (2603:10b6:a03:39a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 11:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 11:41:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:41:20 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:41:14 -0700
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-9-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>
Subject: Re: [PATCH net-next v3 8/9] selftests: drivers: hw: update
 ethtool_rmon to work with a single local interface
Date: Fri, 20 Mar 2026 12:38:44 +0100
In-Reply-To: <20260319160410.2515105-9-ioana.ciornei@nxp.com>
Message-ID: <874ima919r.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c32aa5-24f3-446d-6a41-08de8675a651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cP/SR7nLxeDnBB8v3k6XSm5TLHQLorCGAGDVCz4NS0SmH8BfYcpwcPeGz1QrOExweLw4nXyK8az0P6jbYSeXsx/HTX2ZYw+g61UCSCSixX2ZJJtBzHvRiM2cUHSLkPQl1SVN5AFsR4j7j41DP0wIs7yKeI/UbhaAM9J7gy1LfoZgwSg4SrcZ/X5cCIPuVpdy8Y11WkP+s8jgX93NCx99QqCqyJ+uYne4225lwGhV40B6M5BR19feMnoDQRd5TnSz26SvV5g+2bEW2iUekH32gwPuOYPB4pynLJ1H+WWaa8Zq3zNo/n+EgU7mbr2b/r5mUZE3Io8jpR9fZm8TWi3CjwABq5fDEfstyzZsFEgCV7CLUuS+PZethgqXjSV4xH/+/C8EYDkJo13MQsrDeJvryY+CVJ54NmnctA9MwdsQxf5yyjJStNHdrHydSqppJ9Ip79FPZEeF6pTmxuU3OheQJ+LaCGovjUcnlujvhWj5D+sWM5CpuHAmy7oV3CyOoJyoGSR+l/G7/IHTMkuRWmKPcSLXv/8looKuPvEbSK3+aCX/ypB+zqF8oGkJgEsK6f4bl+K+3Yc/BnFGflfJN9dj/fhOJokYSIz9UCWtXUsAz29W7o0NrUGHZwm8M9iVe5M2KaZGPAujB7eWpbKZt6XE05JVomLU3uENpueZ75Lf5qfG5N246pPbtuocFh38OJ80v93U4H/hodbj5oBvt1mzn8R+dODh604b98rQ3uD5tG0k2rqd+XdA48CbWbGeJT3bMJILkkCo4NfZrpKHubCHDQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DxRdoN/xJpCKDORCwKouJLbJqhZSVVG/qHA+k5Kxa7b7G8OZtj2yPQaIcVwbTnEn3HGuIpJymImVTp431Mff1Y3TG3JxRDvsyV/3y2meuwCbYDYY2pF9i1AVHsHuBxhSsxd19mum/xd/xD4aYuGlSiKgPjZdFWcRyzsg63NTG08GEWikK7gT51tFYx8MZbBTJP3QHEhmmYAGnEMxHKF0MASTogNlIJVlO0MonKtG4hwdoqrZOvwanljF0+9RFOA4cgeS/EJ3T5z9B3qsNslKM5F2e1Bm2KE1rpnHQsh1ZpYtsc4TPcNnUdQmXT2kuhtJ/HQeFi4OgJv35xwvi9MEYz+uAdWwbXquWnVwEVBdNE8AB8vvwy0SsbehnKwMxHKoDxKJuwfvpfT8+NgE+Zjd21/BqqxWmyXCXqvVwR45lAeCv3hxZlENbY7afNpbcSOi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:41:39.1601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c32aa5-24f3-446d-6a41-08de8675a651
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269900-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.936];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 08CB02D9BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> This patch finalizes the transition to work with a single local
> interface for the ethtool_rmon.sh test. Each 'ip link' and 'ethtool'
> command used by the test is annotated with the necessary run_on in
> order to be executed on the necessary target system, be it local, in
> another network namespace or through ssh.
>
> Since we need NETIF up and running also for control traffic, we now
> expect that the interfaces are up and running and do not touch bring
> them up or down at the end of the test. This is also documented in the
> drivers/net/README.rst.
>
> The ethtool_rmon.sh script can still be used in the older fashion by
> passing two interfaces as command line arguments, the only restriction
> is that those interfaces need to be already up.
>
> As part of the kselftest infrastructure, this test can be run in the
> following manner:
>
>  $ make -C tools/testing/selftests/ TARGETS="drivers/net drivers/net/hw" \
>  install INSTALL_PATH=/tmp/ksft-net-drv
>  $ cd /tmp/ksft-net-drv/
>  $ cat > ./drivers/net/net.config <<EOF
>  NETIF=endpmac17
>  LOCAL_V4=17.0.0.1
>  REMOTE_V4=17.0.0.2
>  REMOTE_TYPE=ssh
>  REMOTE_ARGS=root@192.168.5.200
>  EOF
>
>  $ ./run_kselftest.sh -t drivers/net/hw:ethtool_rmon.sh
>  TAP version 13
>  1..1
>  # timeout set to 0
>  # selftests: drivers/net/hw: ethtool_rmon.sh
>  # TEST: rx-pkts64to64 on endpmac17                                    [ OK ]
>  # TEST: rx-pkts65to127 on endpmac17                                   [ OK ]
>  # TEST: rx-pkts128to255 on endpmac17                                  [ OK ]
>  # TEST: rx-pkts256to511 on endpmac17                                  [ OK ]
>  # TEST: rx-pkts512to1023 on endpmac17                                 [ OK ]
>  # TEST: rx-pkts1024to1518 on endpmac17                                [ OK ]
>  # TEST: rx-pkts1519to10240 on endpmac17                               [ OK ]
>  # TEST: tx-pkts64to64 on endpmac17                                    [ OK ]
>  # TEST: tx-pkts65to127 on endpmac17                                   [ OK ]
>  # TEST: tx-pkts128to255 on endpmac17                                  [ OK ]
>  # TEST: tx-pkts256to511 on endpmac17                                  [ OK ]
>  # TEST: tx-pkts512to1023 on endpmac17                                 [ OK ]
>  # TEST: tx-pkts1024to1518 on endpmac17                                [ OK ]
>  # TEST: tx-pkts1519to10240 on endpmac17                               [ OK ]
>  ok 1 selftests: drivers/net/hw: ethtool_rmon.sh
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> @@ -119,8 +119,8 @@ setup_prepare()
>  	h2=${NETIFS[p2]}
>  
>  	for iface in "$h1" "$h2"; do
> -		netif_mtu["$iface"]=$(ip -j link show dev "$iface" | jq -r '.[0].mtu')
> -		ip link set dev "$iface" up
> +		netif_mtu["$iface"]=$(run_on "$iface" ip -j link show dev "$iface" | \
> +			jq -r '.[0].mtu')

BTW we have mtu_set() / mtu_restore() in forwarding/lib.sh

>  	done
>  }
>  
> @@ -128,10 +128,10 @@ cleanup()
>  {
>  	pre_cleanup
>  
> +	# Do not bring down the interfaces, just configure the initial MTU
>  	for iface in "$h2" "$h1"; do
> -		ip link set dev "$iface" \
> -			mtu "${netif_mtu[$iface]}" \
> -			down
> +		run_on "$iface" ip link set dev "$iface" \
> +			mtu "${netif_mtu[$iface]}"
>  	done
>  }


