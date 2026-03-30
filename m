Return-Path: <netdev+bounces-273137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCmzJyhgymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:36:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF5135A5D1
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01F90304753D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F47C3BF695;
	Mon, 30 Mar 2026 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ND+PfICy"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4C277C9D;
	Mon, 30 Mar 2026 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870030; cv=fail; b=WpwVqeCl+4gwSwgNqOjbgQBMajCszTvXJRggH833utVVYBLY6srsdRR4n8T5RkJHinW+bONZ6RHixBfom8ZT7503FNqmdhVuqiKZIfuDyTXSTVTB5vLVTHeUMMgM1RL0atOiAfFK1bHLmooxdK/0qu8UxY7GynMRFJ1uhjCJiow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870030; c=relaxed/simple;
	bh=bI6p2o0I2WuW2s4NganUt/EbOC1yFCMXtZTEPK5E7jc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=erEu88iumDbdBbg41bRLhSTY5KdSocznfF26BCnsIbBgkszJdzyEz43d8CffAkatIQKh9R/hE7hR/ZxKSd8PhGubLY47vh+8yW3D+3mH4nUoL9fpzo1H1TduXIh0NsAXBHPv6SK6Z1LjdX2cyT0Fv6k7cz45PJ+KugIJBYwGUws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ND+PfICy; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmlnkYUuBseEsu0J3brAaMHiV4jMYn97waREcwvXz6wf2YYnARbE7KJw2rsBGtouqTU22B7ERwDxnqWNLNUqj1gsqOwC5k7fSpfD2o7jZscaTonKH9+afrgDo4QcRSddRwxvkybvuB+S9S5AxYD1n+ZkhyT0d3Dq3dlxmvmQAzoxIa6o37UwndAXp2j9ns07lJEKBlBD2a5Ydnxr3/Tp8VdaEMd+V/faFc/TPN5o7mORGvhrvUvnXUxd+jQUt2WapHy5nasbniFzhKxLf4d4uhPU5+EwmMG4rWdNPSiMIlGynQxI8bsA9GSTqhqg/4Hfz6e8/zSo/rw5J7b/CBsOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtNn+nwHHEqexHQyhEH3PVbRRi0/Ch4LrXVRNYwVExk=;
 b=uegla/IDSQRrltGGtalBjZ4xdXl1u8MRPP1hWWF7yvkCjoWTTmsBFr985YxdM3XkXvNDFfoL8TZXnn8ZYgjs1aBgwJaQeoIwIE0c7zSC7Ogv5LszAoq1BaszpdGgPQpJ2/8mdaehUQMs8muIWWMSRf0Nxl196aQUxCRDXiHJzrDQyJCmtEEcw0+2GycANJLF/kGo5AU4/Nn143lL0kX/tjdwEFQZJvvjAWJSV6AHukywjtPq1Bth7YuYmgpUpqZKVsN4WyJzcK1DzfNG+9sgQwXZEY+YOAzJR1RTFSrOTpMUhffNeqYx+LH4SxA5BQ5osqL1VvZvvDyaIQxUwIaXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtNn+nwHHEqexHQyhEH3PVbRRi0/Ch4LrXVRNYwVExk=;
 b=ND+PfICygUFUZdEPDteeTxPFdeYqaunyC+WAN3sqnFcdPaa2wmjIZ/8ZwpX0PCb/EL8tXwMUkuPry1Mw2a44zbMHEgi9TpbBDJm3q1rANeOstEOQdQKHlt8/NUaa3IraXAE/eLwoVNQaaP6wxOvOaAbbVMtEYTBWTNfSa2aDTMb4k7v1Fh3fLbCDZqPQads4TaZPMkn+sxa+zcV2+G8DGag78mv6dXVRJn5dlQf/QsI01Aus8pv6FZ+/BHh3Q1nWTFWsdXqxLoXcF2yosBZASCgOyADMAZV1GT9Bi6+fp4YQDoFHUoNAAhAde44v6KCsnyw8poerfAEV0EYKtrK/YA==
Received: from CH2PR18CA0028.namprd18.prod.outlook.com (2603:10b6:610:4f::38)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 11:27:03 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::53) by CH2PR18CA0028.outlook.office365.com
 (2603:10b6:610:4f::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 11:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 11:27:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:26:48 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:26:43 -0700
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326132828.805703-3-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4 02/10] selftests: net: add helpers for
 running a command on other targets
Date: Mon, 30 Mar 2026 13:02:12 +0200
In-Reply-To: <20260326132828.805703-3-ioana.ciornei@nxp.com>
Message-ID: <871ph15zip.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f58ec1d-4647-452b-8e91-08de8e4f44ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	A49Ves1P6d3/qWYS/9VI5XUJzLbs9oTZWdKqbLtMteQX5qkkQP1ZlMReFDNX2TUXg3DrdWaQsJuP87pcmKH7Isp4nQvOq8UOlS3+ee6Qbgl270j0y4X5nFUMY1CoSQYKEaWm6pjUtnkc0UsV2d2OomGLmbxsI5fpKyrzLkcNS79JRpavVeJiUq6uMRy6Evxv6uIAYBjVb2nL4o72gtGX0FVaaZjd1UFKPxaOlCcBy+E5DEpp7fl6iIsu9WEsxs4+LI+OU9k9ll8LY34bqr0WpTAwyUqbeo8k+lv8pFyF5waUcpRkErxGImAnDVjFrf85r18QHzSJREQmx0ZI7KwhNsaMt4AXmWB2oTpP6o47TTBxHAi7avDDlAzdaokoNzjpN0MFJCXQMao/cEhnhRgmdGPUPnKD+c4SqwWHPi6JYa+PvczJU9xMZsLr0qPnAici9eqyhCn/r/Klzr9lURFxkEcziRqwUz2jbkgfzVcrn9fA1czRRQLt1CAdCFP7uWm8dcX3vk1E4o2ejWcC1RqAgE70lPw4cU89VbnMQWB7Vtyj3WKs6YKJpuWhouSRiWXN1r3oUtJksWmbQsHh3kbBdto3DBxWv+X4lf+uyceYXWGzzCS8tLBgkAWXTdKs0shrU7YohnomaXRgEqI1BXV7k98LE95AUsYIWit86Zxm+43moQhrXBH1vUhmWXo5B3DMUpiFLwHulIdM0S4IXE7AWAMhMDVI9hc2Ze8anEkqFz3+2PftDImBPpRfvEDPQU58E0TyFLPOfpRmQxKAbGUiKw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sL703S5rRl+jQh30Wogt+kZNrgnrmaVmIeaDvsH2jX9bYyHlzaWErWdFeIAq3JuEnL4hvkMViKpdWX3PRJfa4EF/kC/zTnINhD/+VtNDZY8B1rShG+hWWT8TCIVSItyx1sF8u6sx3ko3/WjXRjLI8o5MBd3AVu+FrVyYgXgkq7WK2ahYINPixDqJRC+bHjvoUnWf1/k/lzGtSfq5HN+PlXIAmWVnWO6/4thW9f/9qpnZU44zug2N882NHyZOng8271y5V+YTQnjOVOIAfTH8Ikx05Z+8jT19WmmU/9zT/d7q2cK2+aK1u63LBDpfiljwkpmbJscJFJnjacZNLSQiYBd0mpP1cn5vwSMxsqyka7OSADQjyl/mPLSU1WXV09EQBUxDFinDDkG2Y+2Klc8WvIK/OTLG2uQDZ4DJlCEyXSHY8jE9v0NQuGoiPqWkNMzd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:27:03.7100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f58ec1d-4647-452b-8e91-08de8e4f44ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273137-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,host:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3AF5135A5D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> Add a couple of helpers which can be used by tests which need to run a
> specific bash command on a different target than the local system, be it
> either another netns or a remote system accessible through ssh.
>
> The __run_on() function is passed through $1 the target on which the
> command should be executed while run_on() is passed the name of the
> interface that is then used to retrieve the target from the TARGETS
> array.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v4:
> - reworked the helpers so that no global variable is used and
>   information is passed only through parameters
> Changes in v3:
> - s/TARGET/CUR_TARGET
> - always fallback on running a command locally when either TARGETS is
>   not declared or there is no entry for a specific interface
> Changes in v2:
> - patch is new
>
>  tools/testing/selftests/net/lib.sh | 38 ++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index b40694573f4c..6c0d613a4de5 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -670,3 +670,41 @@ cmd_jq()
>  	# return success only in case of non-empty output
>  	[ ! -z "$output" ]
>  }
> +
> +__run_on()
> +{
> +	local target=$1; shift
> +	local type args
> +
> +	IFS=':' read -r type args <<< "$target"
> +
> +	case "$type" in
> +	netns)
> +		# Execute command in network namespace
> +		# args contains the namespace name
> +		ip netns exec "$args" "$@"
> +		;;
> +	ssh)
> +		# Execute command via SSH args contains user@host
> +		ssh -n "$args" "$@"
> +		;;
> +	local|*)
> +		# Execute command locally. This is also the fallback
> +		# case for when the interface's target is not found in
> +		# the TARGETS array.
> +		"$@"
> +		;;
> +	esac
> +}
> +
> +run_on()
> +{
> +	local iface=$1; shift
> +	local target="local:"
> +
> +	if declare -p TARGETS &>/dev/null; then
> +		target="${TARGETS[$iface]}"

So I think Jakub's runs fail because there's a shell export somewhere
that gets inherited through make to the launched test. I guess it would
be enough for the test to validate that TARGETS is an array, because
those don't get inherited.

Is there a reason not to reuse DRIVER_TEST_CONFORMANT as a tell though?

> +	fi
> +
> +	__run_on "$target" "$@"
> +}

Does the latter helper need to be in net/lib.sh? Since it uses TARGETS,
which are a forwarding/lib.sh concept, it seems misplaced there.

