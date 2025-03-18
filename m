Return-Path: <netdev+bounces-175809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87513A67877
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1BF3BADF4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8806E20F078;
	Tue, 18 Mar 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ca09Rx5f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B457464
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313214; cv=fail; b=BFj8B8wyyBS1Fcn/Xo2+G+oG3Y+pbB9zGjhHY5YnU7QleXD9V0U3093onOEg2CTIozjYEQuU3p+qEppj503PlpAg+er6VSmULiJybO7h96jcrb7McG2vDVEM3dG24hATFgb5al6veoNtiN4zVwku0lFGpZc/+sHgleESnfm0CVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313214; c=relaxed/simple;
	bh=Xwy65l1jXArgLPaPPQ/LAP6i4tAYHjQvEpvlfvwVyKA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dYS0psNxbjqA+P3xcMEsbskEnDEgICILEzcXncPtaylAzY7Jyq5EHAAHactiyPFUrVstxCxrv7EY59AgbN/zIc2ys37wMMZPxtd50rpB23QdjfuJdUjw1uzZf0e2Jm67+pADzOHjOA/VTphgEzhcRXNKNOPYzhhQhqVEcBnhf5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ca09Rx5f; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzxSnCSs5+mk5tnu6Sr7gyHzegww2fMHKvK9q5r1h7tvq4puUa1r1EQfo/KbMKMHFJTOIC3FnK9DNFB4YItNA9vjroJ1qUwWCt1XyjkBdTkl6VipELF5vFBNDK0Bzbqae2anN4j2dkilRGfFeBcfofDb0GSFXq4tK4kkLterzP07U29S7ZE5y9QRgGE5tIoSfg9lixUlUvryGh10OUsKenJzt8rfOFpuTshINruOHRL98u8pNQckmYkxEh8iB207mu4LkSabYQ4S5yC2BcHS3ZoZAbozl73Upi+drJ0Kt+rLhRZXtOUWta0fF+pHWUn54jktq3OVg1wRoPzDemlCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwuFRsfpHjoJE0RCyzKX3A+/NCP5s+NoqAsOHEni12A=;
 b=ly+O0GhacGQEbiRmecC77sEuWvDM5lQPeHQ2lAAn/RAiJmlCmsBrmr1JLyRWi/gBBs2/hHZijSFE6zhCiFf51NObiWXPJdIoyI2wvDxkEhOeFOYX65IEmouxcuoWH9oPSJqw3bxDDIQNn3n6uOr4SO+XoYSPq8dTGWjASADhIKpLymuiih0I2fpY7SzxYJbtjV9Gbhs/J3Ei3L184dwk+s4O5dgHsRJWVevguzYMp6tG5YHALTyAPWn+yJSBBgdLhqmzG3JmUDe4+mtgbLUkC8fXu162k5w4S5sqTacOr9EuJZ1hemSOHq1iXj0muqQw0g1IBRARWFraxwCOkl8PcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwuFRsfpHjoJE0RCyzKX3A+/NCP5s+NoqAsOHEni12A=;
 b=Ca09Rx5f42NNgY6iKFcQoS00eyexBrCQl5W94S7MlZE85ez01JP3RWVo0SBnZJaPezqM8WYe5m4ICsEXugq0P1fR39Nwfi3f2oBT2WKvBRB5LluDMsvNQt2M9HTLZZHpd3riSoLulMV9T5asuIxEpBb5QeRFRucSzVSs4mAJ3cqMosq/AqlnFGcz+bCQR9W7wWCjr2JnDUm/xlHuODRBMwi+bbtl9qbcdwhdDjyx8sdcbIekpH9kocUeWXH08+ewkFFV3A/OqtcrF+FPojmVZIHO5N7ASp6wsh3A1fOprMBJaIBOpkfZNwVSvY6WZvHo85TyMTIP+fLEUiKBhQO2NQ==
Received: from CH0P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::9)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 15:53:26 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::4b) by CH0P221CA0025.outlook.office365.com
 (2603:10b6:610:11d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Tue,
 18 Mar 2025 15:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 15:53:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 08:53:10 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 08:53:06 -0700
References: <472257e02c57.git.pablmart@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Pablo Martin Medrano <pablmart@redhat.com>
CC: <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v3] selftests/net: big_tcp: return xfail on slow
 machines
Date: Tue, 18 Mar 2025 16:49:52 +0100
In-Reply-To: <472257e02c57.git.pablmart@redhat.com>
Message-ID: <87y0x2pc81.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2e4470-9ee1-4272-d946-08dd66350551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TzpYqjjYF8iHy5mBbzy6WWiy7SM3gYbAOB/Bn4SkJxJAFdgxnQgF9h9jNW9p?=
 =?us-ascii?Q?OPLcceN7tAo2X3LFkaVLYnllgXiro5bl6s2E6uYvaJ1dDgNUVJ6tslsxMxtC?=
 =?us-ascii?Q?0MlRCmWFuO4QeWPa/6AUEMaxDrabT2zhBn0ao1Dzh5DyVRA0rwwy0WKXzuCB?=
 =?us-ascii?Q?FDKJ4lgNA6d18CpiTr9+Hi5XpPeAV8sIIbzJ8/nXiEqpSu9rBfIsdUitMdJI?=
 =?us-ascii?Q?hp83Z4pJLF1qyfWgVcsfQBGlxDoIuW9nVeB+EegaZcRLeL+vWw4rjcVh20Vi?=
 =?us-ascii?Q?nnPUZVnCUZBjdn1wfH1Ymmi6g5C+IWLQcrmWnXSohF6EFDCI8Wzki70Cs0+G?=
 =?us-ascii?Q?CmYfjpwthfDCdk8+vlQ3Nz7usr9GhQ7uA41IiDh3Xx/JLCNbGJVRSCRbliym?=
 =?us-ascii?Q?g0B6jVQv7I+KukMbrCVM6k4VkzXsrejptm8IGTNjlLojBsBKu0mmXtrfeMov?=
 =?us-ascii?Q?C/N/NSfuN1Vew02/1C8E7Y6grt/HvCcBwlEBQrl2kjX50ISd8DRScq74MRpp?=
 =?us-ascii?Q?Ekd3qEkkyHJGE6HZ3f6XTwA9ARgoCy9/VNIHsekOVJrqMBqZP1zFaLQSh15R?=
 =?us-ascii?Q?TeGpl4hTZZbWhagoVacZ0fdYj+akFJMifewyfwBp0mOk7H+NaYZ/DvSKH3QC?=
 =?us-ascii?Q?r+fhaSb9bUmrruMFm6TXno6q/d0WS3zXYb9fkx1gOo+rIffF8iBAQDtaM3vj?=
 =?us-ascii?Q?sCGyrL6cm78h8MQSzZ7zv03RFmHlEb7DklCv6nRJAnjzrp51flhpJA3FJ8UZ?=
 =?us-ascii?Q?4zrdb9TUCEM5Fb99vAJkXssdUYydpWNvOH1KVSvKNEAA+XdTI0bFlXzjFoI/?=
 =?us-ascii?Q?cie84OSNcbyoZmcS2C372nzc4kYjragnttfds7CRm59u1lsFzdgs4uoYvGmB?=
 =?us-ascii?Q?k4nsVR1zqfcoCXiG+1jg8x6EVdkAvRInG7M3UeO4myNW/qOdKapry/LwXXjG?=
 =?us-ascii?Q?3qwS+EUaIiFzyouhi8cZaG9POX6xpL+RiDc6eWuz/lZKuD6trilg4o7c64nE?=
 =?us-ascii?Q?GIyWVA2wmRQDXcYVH86CZOE6m2EQ5pyoirrAymTgM4VcdkH5001uzZZwkBqI?=
 =?us-ascii?Q?HZUN2dOR/QIGjJtGCSSmyrapPRGndIl86YcIdiQOjPZtCJJP9IUzZacxOJIg?=
 =?us-ascii?Q?3cHeTUJPtbVtvG08OKIkBeP8h3dIhrHOOwnJfkaMLShtXMMM+e3loFWJ8upC?=
 =?us-ascii?Q?+Gux2S9XllzpBP9tZcNa8yd30JVPemcrO30J0lpnpjCZ0u6aF+Inge4vKSAJ?=
 =?us-ascii?Q?lzK/EzbHLCeNY1HBGzNN6/34cHc383qof1xR+5Q7ffto/YsOQ3qb/xvC2Z06?=
 =?us-ascii?Q?SC7ha1oxJdxjyfJOwMe3hjdGTCwHWUN1XnEobPnEEbon9PwAXCKABcq5dm/L?=
 =?us-ascii?Q?nk1erHkwRDU4EgABCctpBEglFBx5oW4Q03eC2XZcJpdSMwsYzhM/eyHp0pPN?=
 =?us-ascii?Q?QTJM6FxjIkDZWB+yOoVzUCV2XS+i83C8nmDtvv60p1crJOvHh3L77oS6faS+?=
 =?us-ascii?Q?Dyxb2pppZD10yHk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 15:53:26.3465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2e4470-9ee1-4272-d946-08dd66350551
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035


Pablo Martin Medrano <pablmart@redhat.com> writes:

> diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selftests/net/big_tcp.sh
> index 2db9d15cd45f..52b9a76b1c19 100755
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

The local ret="PASS" can now be dropped.

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
> -	test $ret = "PASS"
> +	log_test "$(printf "%-9s %-8s %-8s %-8s" \
> +			$cli_tso $gw_gro $gw_tso $ser_gro)"
> +	test $RET -eq 0
>  }

You can drop the final test. log_test() already ends with a "return
$RET", which has the same effect.

