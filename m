Return-Path: <netdev+bounces-269887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMxYJ4gtvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:20:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF032D96F9
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D92D531B1E1C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B913A4F5C;
	Fri, 20 Mar 2026 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SvFwCAJ6"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0FF3A544E;
	Fri, 20 Mar 2026 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005377; cv=fail; b=h/JdzINM/7YcnOjgOsjjiI5wvDitzfChZ3++9dB6wQZszcgeDMHTU+FbPmQNY0NAyMwaidaccfCKmdGzhhq6mHgiMMKt98xgXwQqZCyP7LHPTOsPOHY1iL0JB5jKcl1RrXTJODpgBtB0Io6MYltaUe09wHlQtXLF/sFjyUg08VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005377; c=relaxed/simple;
	bh=NK/eKxa6hid9H8nbjeFvx6QTx0jrgWWVw0h7Y6v5t9Y=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=P+u6Cn6RLpds6+urQ4TdPFXXyUPmAkz2hVeFvBAO2S6YMV0DDelvdDqW0Ln3RJUCdXVPSrQwbGhKighF2MYiXdJs5qUgt+GnpRQHTMCHUeODRkegxdITB6a3/tze3cmYjDQGyu8ZeL5CwRme0rvQGv0ihMI/xoyB4qKcoa5gaS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SvFwCAJ6; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6ORYsZlaYUJjNtVLPvlcOmD2bl+IMlNXiSGo/p2KLgUOpABRV1N92BG6nk31VzHf5j6vlCAY1BS4QRI+653rqde6K1fy4ks64J7qCbtq918+8Wo1vEgFBU3+oJbxKuke+pNTI++Tatk++KFMXxm/xt8KfgI1Be9Lno8jb82iVHRgBUn0Ad1+q1vZhjvZ0MF30Mt/4TT6wu1DQu/rtZEEER20daSBYjYzLA4sxI87y1LXAPIhq30vrcadAPHHFA/+Ml+oC2cIAFoTY6JMnI/H7HOUyG6sd35EpsBKLntLxE69enQwHv65WrP0SRBGuulIJ0daTQoty7N+WNCzVB/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8akeM5JdSLKM5Rn6ZEDhPEYmQoIk/LPx07EloVYbIm8=;
 b=e98OYXRgk0sW4jmWYFYDSHg5kMWbeehzgggv1wKPLdWmN5WlXePP3CTEfg08C0uQaEGa1lOlGnOX92ghWgVCYt093JWmWiOCrPRxrgUcgESGLnUwu3qjKR8AFkOhBm3tlo2unPjloB2uS5wfYBTA6o4fI+LrRSZHrmxqCOxq76A4ao3HIaO1EHcR7aq3XgDUz47rxIV17KgSoDi8c0PJxbHstKlCgmgJC1p5YxptppgA7y9aVfTkhnjH0mtpOBA4XkMHN2qsAKyxb1V5pPK9SCGFouToD/+qlfjmGr5REIjARP6gdFAlr/wIhQVs58mNxt489gUo4G/RKzrDnvLt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8akeM5JdSLKM5Rn6ZEDhPEYmQoIk/LPx07EloVYbIm8=;
 b=SvFwCAJ6OHEaJVXC3PfBHMwbCGDBLl6+XY4GLwF4qJJTf4TQzcGRLX7E+RTAup08xabHRr1NAVVU3GnEWR2cf0X1uQwMYvZCHI6Y/FQroyN09bwDTwN7Aw3e7ya1Vh0c7qkNvcJbQUwEirRdznnqtt5HLs2AxmhQbI4vru8exfh+85lWrqI4+Z4/+cYwo/R1E7B/MGN2MPvk9l/BsMukPyZTrNpes9IJlNuo3ADBQJg5Sd51hJQERI6lfpkDZ7T5G/BHML05E/1nNgM0CnkEcaZstIzgJw/iSOx19iAS6pPQJaMgj840Ud3K/oEMKcAC5ow2oezMfJ5tUfBemAyPWg==
Received: from PH1PEPF00013302.namprd07.prod.outlook.com (2603:10b6:518:1::11)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Fri, 20 Mar
 2026 11:16:08 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2a01:111:f403:c936::) by PH1PEPF00013302.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 11:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 11:16:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:15:52 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:15:48 -0700
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-3-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>
Subject: Re: [PATCH net-next v3 2/9] selftests: net: add helpers for running
 a command on other targets
Date: Fri, 20 Mar 2026 11:58:42 +0100
In-Reply-To: <20260319160410.2515105-3-ioana.ciornei@nxp.com>
Message-ID: <87y0jm92fz.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ed8754-a366-49da-1a72-08de867215f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1XHEAwtwA/4PsPX5FMiDihH51U1X/xmiS8AUI25p60xwQfQ7bB2H6K3RTAPOnXoUZ2CZXI4arGFA2YHpalxWsGqY8ETsSKn78O7ALOPqXNbEogZKhu3aS2wrqiEYVCxaLSet180atXfAkq8KGOeLkLyNGm21mLyA7Qf9wS6o2emeIk34c38cdVCPphxM8WJXdAMhrhKJ04AfbvZ9lLGEiem++QSko27zxn9a9obckC/xPZ9dzSmAh03nTmDwGnJdglWAOiF/C3Dn8HOcLUEdoPFCPEJtqvEhsRBGGIYUu+2mglSTZzsHVwhgaG2AG3GOm/zjWzrgQZGX7OHfu+SQtZfcUKSc1RNiotFqGtBF3s7JOUd1sipx7O2N07siLx/YRXgDJ3xsKJzZLITn23zRdDfvcPSzn0GzI43t9L7sK85lpkGZWd6dVyge7+Mns0VkDdU2jALjNZHcB2z0W3Gi69ezDO1v2cyLp0nS/llaxKZ/DbylVjyJaE/jtzHSiC32i7OOHFT1VLyPJNcif5HSlPQ/an+vWzwreE/aconXZxNPjfiO0Jt8X+broPG3SdLYXSwjKpmiAiveIbc8X5puRFZyvhVxF1L+caVvNX81BgKusA3/JwRQuPtPeYdd24wpDT0XTWRl2XnLu4rTkjwZ1xi1/FAtNmKU63D1rDsqayqDSZKtw/MJOuTDMM1VaHEFlhkzMmiXbBwkLJVmHl1pA37BHYTdYFY6QAr/OlL/RwxxXbK9xi1Z3Nuy2oUPfMrxZ48krXfRPDaW2VyohIpLiw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bwnWwhUgyNXz8Izw/i3Apu7gcqD+IT72X75L56ll/EiPizf4d1Zm/Ri2ZLnr+tiIyZaFPlaudAiEHRRBVGzRej8t7q5LhdA3/SEyiK5wNNrrdWEDPpR6xTjvUuWNp+2zU/6mRMyIJY4oR3bbjrRB7BveWkfZkSHJbvwzYEF2lr8xJebVhnkoLG3pTm1+V0sy1x2vewWFaC9Sgsgpgo3gEl7JOkAwd+kRAJ1m83SLUEbmm6fWUDVN5SAaY0RLbgoeyOwqL9ikXmAWqEN++gncFkvkf5RZYL1Ut1SI5YKgQrItEv/njlnUL6tHNmL2qWPLQxKuwDjEWoZpr2iX+n+lip3rM9gBoxJnaVuPxUEDV+sUxb/jaAzhx0Ycy8h+FEqiqNjjWv8qA4J3t2r3EidEYHMPgqwB4UE+3rmlYOUjrqGYZmlA8E+c7K/TqE/AS/EE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:16:08.4723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ed8754-a366-49da-1a72-08de867215f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269887-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,host:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.969];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0CF032D96F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> Add a couple of helpers which can be used by tests which need to run a
> specific bash command on a different target than the local system, be it
> either another netns or a remote system accessible through ssh.
>
> The run_cmd() function decides where to execute the command passed
> through $@ based on the env variable TARGET value while run_on() will
> receive the target through its first argument.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v3:
> - s/TARGET/CUR_TARGET
> - always fallback on running a command locally when either TARGETS is
>   not declared or there is no entry for a specific interface
> Changes in v2:
> - patch is new
>
>  tools/testing/selftests/net/lib.sh | 39 ++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index b40694573f4c..f7c54d05758e 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -28,6 +28,10 @@ EXIT_STATUS=0
>  # Per-test return value. Clear at the beginning of each test.
>  RET=0
>  
> +# If a specific command needs to be executed on another target than local, set
> +# this appropriately before calling run_cmd
> +CUR_TARGET="local:"
> +

These are new functions, they should just expose these parameters as
actual function parameters, not as hidden environment. If it is
desirable that run_cmd() can run local commands, maybe it makes sense to
make the current run_cmd() a helper like __run_cmd(), which takes the
remote-config parameter, and have run_cmd() be a wrapper:

run_cmd()
{
	__run_cmd local: "$@"
}

>  ##############################################################################
>  # Helpers
>  
> @@ -670,3 +674,38 @@ cmd_jq()
>  	# return success only in case of non-empty output
>  	[ ! -z "$output" ]
>  }
> +
> +run_cmd()
> +{
> +	IFS=':' read -r type args <<< "$CUR_TARGET"
> +
> +	case "$type" in
> +		netns)
> +			# Execute command in network namespace
> +			# args contains the namespace name
> +			ip netns exec "$args" "$@"
> +			;;
> +		ssh)
> +			# Execute command via SSH args contains user@host
> +			ssh -n "$args" "$@"
> +			;;
> +		local|*)
> +			# Execute command locally. This is also the fallback
> +			# case in case the CUR_TARGET is not set.
> +			"$@"
> +			;;
> +	esac
> +}
> +
> +run_on()
> +{
> +	local iface=$1; shift
> +
> +	if declare -p TARGETS &>/dev/null; then
> +		CUR_TARGET="${TARGETS[$iface]}"
> +	else
> +		CUR_TARGET="local:"
> +	fi
> +
> +	run_cmd "$@"
> +}


