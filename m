Return-Path: <netdev+bounces-89057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B418A9501
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364DD1F21AC9
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ED514A0BF;
	Thu, 18 Apr 2024 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YOOkZ2sy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9314A0A8
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429044; cv=fail; b=ctR5/+6BBvKn5dw+yjzPm285aDGlZv120Z09hnT3MoRx4wcEPTyuglN6i/mSmT021hmzvK2dC9dmtNwMRHD1LArEPfVT35s26k33VJ0g63aTCB3sA41nt2tJjkC9AhlWACZwXS/orUkVOuKYu0Lgaf/mvwXq8LTdDf4TDDb+CO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429044; c=relaxed/simple;
	bh=9ToJMWPCYIcYW8l/Mmvruuy7OUayYiFS2IFza17ubrc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NvoK/MGR0zx+5usJVjO3IajwDMurgyDN97yIetVW3LhKXlnH76XtN+dllemS77uVsNzYMpEj0YIhSDp07HbKAH7HCCqXkT07/5xBxuMOTdl6wLGLpAG2Rnqozd0XPYyX3VKqBOU+6y36IvPsIyEr97GOA7SQdas7je+A4xSb7c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YOOkZ2sy; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpsFAE1oJegT2BHv2/qVErWLY6YuWNvCDJiCCs7usrlOaSYr/+HCzjy7md6/C9R8lpvFCEtB05ioXjCfkFA7OOv7X+Q9jCBPRbYPmMb1q1Iy7/z9KraVRf4DIhYellfOVX4+GHcjj+hRY/mP1aWnxz6nhfVzXvgPEB6vpiWo/a4PKjX3gfHN0DjgHWJ6rf7kl1NXIwSaNfT4c99BZvT+8g5q6CUGZ/I3qstyquENLLqh8Yqnn17jH6g+u7X+nDKS7rpevgcwtJZFpm67vNQpblB542r7+xd00ArQburIeGuZwOAxIzrx08b+zYYnotJBDEDvq+K/ZPScYoONykEigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Gs7TeDiKMeMjYaOJKrLAM/8oP+DdseUvT55r3vVG5o=;
 b=TtiO9WdNcViL8Kd3PQrn6TeQ9X/V5ADgcp4LQqWnHQoUh3ow5zh6kSs6wp7nzj/MO8NXnVdky76SfPRK8HZeycgxVP3eVyp4i+Ne7t9Bzt0IwZqXp5k9bXvTA3iLgJl8Zitd202jIAfxewGMp2x8fbPPkNIFWl6CoRbmqJXGP8g55/P05nqwi85osx2UvTfcz4bV1WYhIs1mKTe1GY8lrzfwun+EXx/cUgg1P7f99iqd/5wJxsh+lo6uPcYmj8ZXOOGZdu+q2xE9OS3allbIWRt1Q3pvRh4OReEweS3RMxtZPpTJTPrwJJSanWoHG6ZP9lC0EGbIXd1mbwWtCDFUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Gs7TeDiKMeMjYaOJKrLAM/8oP+DdseUvT55r3vVG5o=;
 b=YOOkZ2syqJWJUGD1MlqFPd4EU0KycozSNyRNLB9Utjn2btHXnBqaXDw/jOYsgun6tRPbuz+Bq81x5viw1hTE+O6xbw0xSKPGcK92V44iKGQm3PX7EAQMTUyq63j9nwGl83xgCmJEIBoq+G9TAHbVoZvroYCHW0qVjAdLLSUhe2aR+WrpDRaTzrIKa5q8jQmZ1D88C1eXfm6PJQiLZzMW0S/TTUDs1en7pPa0jN4xEns3qn5+hnItwwEKdIisKjcFnaVH8sddYFudf261HOsIUfDdn3X+wbqlARhnPcaJe+W/6wLDQJvvdvbBfD6GNmFSk31tjHlNexT+qgJsx1vgQw==
Received: from MW4PR03CA0186.namprd03.prod.outlook.com (2603:10b6:303:b8::11)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 08:30:39 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::eb) by MW4PR03CA0186.outlook.office365.com
 (2603:10b6:303:b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Thu, 18 Apr 2024 08:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 08:30:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 01:30:20 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 01:30:10 -0700
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-4-jiri@resnulli.us>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <parav@nvidia.com>,
	<mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <liuhangbin@gmail.com>,
	<vladimir.oltean@nxp.com>, <bpoirier@nvidia.com>, <idosch@nvidia.com>,
	<virtualization@lists.linux.dev>
Subject: Re: [patch net-next v3 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Date: Thu, 18 Apr 2024 10:11:12 +0200
In-Reply-To: <20240417164554.3651321-4-jiri@resnulli.us>
Message-ID: <87bk67cbuc.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8ab4d1-34c5-4ad8-3393-08dc5f81d3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8odM6bbB+PEo231rDDzcuLpaDN1+JarifJtrlS4ladSuyZNhbm1gb9Cfk1lf9NEY+ckebS1x6SqVTBzl4ekfaxsANJhpnkukIUgKvxM7T6BSCzI6pI5L7+28/n+7bwGKRvqBptScFKhX41i6BluhjgTzSZmHRoJ8//1SNxAWff4BFuCcsMtaMnWvqmmiJz0jOwS+3EB7tjM3fwq6j8uVl46uZ8mmcWrP8VAf3h8HBI7wu102jkTXEb+cwsL0YxTT0QlM9t0zFFUO87hUnsVYmT429FCkpwHvLVIlYioLlSW81vbjTIqi8Y/cZRT33MXsip9Fjvc0n9R+r2S4YHwT7z3BLXntQjyhzvyvQsEnidU2xDZWpp+XSRxhRN5pAw9QeMOkAmDrRJsdacJoopTkxkBwsbfXxTyk0bO3uuiUZnRGIY67fRW3w3ywLBvYp19bBcgAbgeNHsXmofvQOMIUnODUk2IWNTztyT5TLu0aRryx4QvUXqHYho/yB8UYoUGGw+0YrzXSCz4tq6aTNUmuYdYDuA23GyzNqJd5OJ6pvSFNs7m183NIZMEErXhGK3rxAUIzzGY3iZ8s7d5CIHjK+RAAccvAgq4gXGdm+zhETUPW+MVPfb980bmB6FQRyod/6FZl8nC21Ula660zQAUbaYkx3F8n4nWaJTYsu2ynqKWzMVTryuCP85N57ZTtz6EhBABl+Zhq2bzdVPET+um2Yvyb6mwdhWBxENVhVBvK5gp0ZvdGlOTJGZBrxTpHVd72
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 08:30:38.8769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8ab4d1-34c5-4ad8-3393-08dc5f81d3e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291


Jiri Pirko <jiri@resnulli.us> writes:

> From: Jiri Pirko <jiri@nvidia.com>
>
> Allow driver tests to work without specifying the netdevice names.
> Introduce a possibility to search for available netdevices according to
> set driver name. Allow test to specify the name by setting
> NETIF_FIND_DRIVER variable.
>
> Note that user overrides this either by passing netdevice names on the
> command line or by declaring NETIFS array in custom forwarding.config
> configuration file.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - removed unnecessary "-p" and "-e" options
> - removed unnecessary "! -z" from the check
> - moved NETIF_FIND_DRIVER declaration from the config options
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 2e7695b94b6b..b3fd0f052d71 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -94,6 +94,45 @@ if [[ ! -v NUM_NETIFS ]]; then
>  	exit $ksft_skip
>  fi
>  
> +##############################################################################
> +# Find netifs by test-specified driver name
> +
> +driver_name_get()
> +{
> +	local dev=$1; shift
> +	local driver_path="/sys/class/net/$dev/device/driver"
> +
> +	if [ ! -L $driver_path ]; then
> +		echo ""
> +	else
> +		basename `realpath $driver_path`
> +	fi

This is just:

	if [[ -L $driver_path ]]; then
		basename `realpath $driver_path`
	fi

> +}
> +
> +find_netif()

Maybe name it find_driver_netif? find_netif sounds super generic.

Also consider having it take an argument instead of accessing
environment NETIF_FIND_DRIVER directly.

> +{
> +	local ifnames=`ip -j link show | jq -r ".[].ifname"`
> +	local count=0
> +
> +	for ifname in $ifnames
> +	do
> +		local driver_name=`driver_name_get $ifname`
> +		if [[ ! -z $driver_name && $driver_name == $NETIF_FIND_DRIVER ]]; then
> +			count=$((count + 1))
> +			NETIFS[p$count]="$ifname"
> +		fi
> +	done
> +}
> +
> +# Whether to find netdevice according to the specified driver.
> +: "${NETIF_FIND_DRIVER:=}"

This would be better placed up there in the Topology description
section. Together with NETIFS and NETIF_NO_CABLE, as it concerns
specification of which interfaces to use.

> +
> +if [[ $NETIF_FIND_DRIVER ]]; then
> +	unset NETIFS
> +	declare -A NETIFS
> +	find_netif
> +fi
> +
>  net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
>  
>  if [[ -f $net_forwarding_dir/forwarding.config ]]; then


