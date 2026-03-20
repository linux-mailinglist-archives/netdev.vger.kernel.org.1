Return-Path: <netdev+bounces-269888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGpJGsEtvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:21:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5802D9731
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7CDC300D4D0
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13D639526F;
	Fri, 20 Mar 2026 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sQ63LoRv"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B07387352;
	Fri, 20 Mar 2026 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005689; cv=fail; b=B1gMgP7JTWslaviT1ii5UhvALlnJP/SCHzVwc+eT/VXsL9IAWZjT+csFh6H0z91jhACWSI6bae9oOreZJxDNrgpbfUJskezlfmsElfhErG0BHS7DOX6Wy07Z+mZOuRtYZI4I0K5byLInBXDMUkWgWqDAzDmf0/7TIEItoyNjh/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005689; c=relaxed/simple;
	bh=zKhOjdtfcsHJEqONrf+16N/5r5RRsNH2SU/rFk0Hw7A=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MVFxIuXMvTZG7Qd8Jz5M6sj1si36mEo5z4qi7OOrbrBKVyS01v09eqtTOp+yWlTp7eatc/L4MxI0XztLN0yxXauL5RttWD/zGi/Xy+W26uvhMI58pqoAHe8qRZrIXXPIDDlej34UuT0MwfGXjfHUrj+I8JZnjS4zq4nDxY8waGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sQ63LoRv; arc=fail smtp.client-ip=40.93.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f05S8ADeMTfipQ4NwdWW0XQe+iT4JnSdTFZY2VQvzwjXCT3aKvXWA5sG92U/r3MqmqaoTdjfI2B9rZe/2aQSYqhtMvPDF3SyvdKOHBoNR+ac2DQSPKH+vNxii1TDuNfH0/whzybwIsUMcuIE8Rc3qGmk4q/vNMme1bH5ZV4lLDYO29MLPDK+n30Z95zLsOyJYhJtTXy9xWagY8tLduIYBKMJJk5se4dAucfg9GMOvk3OhYvO203EUFUujx0t09J/uFAwJkJlxGbJZNGSwK8kcj3sRKdAql1XYEe1o4QI5x3v3Y8X8XwJHTGOyY/1LtYgK2XR5s3RNvqIsSQXWIsbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZYHPxE6ImDOtNfs3CHj05aDbvRT3kFQ504MSB70/5s=;
 b=tBD1GC+DISfwHFyLJBqVEJfShJn7FqBCbvBV+KRJonmgC6Yn1tzmnLI/HCrK1fwEpWsK2yVP6aisgLrM8bOvnwYwPSookYdYJ7rNmA9FaCNvcTv1T48IHRHkb3pQqqICVoT0K33pAnrP/i+zs9ehK6/xTXrbJkO5yT4H4cMXXTYftK00yttRqx3Fg1FFxT+aPiB2q/58lti1t5IEQ2IaOp3jLyEeuieqwHpI+b3/H9ugVc9+xvtBL9yxdAWHeCiIZpKbZB8WHtLlKzjHFdzPQJiY0ZKO/0oIfHSCwNbGL1r+HogFvYvk314utH9DyqaAmLT52oAaQ8z6avEUNXV8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZYHPxE6ImDOtNfs3CHj05aDbvRT3kFQ504MSB70/5s=;
 b=sQ63LoRvZE/eIw2/7nq2y0vrKQ0cI1xLgOgcaSrNhK3srdR1gSUf97VMXFiBwvT68vHcn3r9b+Fp8x22UJPoSi23Y0FFMJHDIHS/v3e2Gj5NeqhQDSzUYFx8KbTYf1VFSUKTZCD/tDM3odaI7i0iolZS0pumymnfGiV6dxSxxx2TUAiCyd1Y+pqN2ba8J54w1OoQRaDXUYBxYy1LUr3c/CXJv1+27XaASvbzpws+V/6w7Qf27Ia2gDW5klqzzqYW7/scFncKzCHbN4D6yon21YLL5IAfVHKOCcGpSBVfZmz/vYnNXLrtez08Q3DedNxY0amqAz1ueDXddVF9f/30ag==
Received: from CH0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:610:77::8)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 11:21:24 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::f2) by CH0PR04CA0033.outlook.office365.com
 (2603:10b6:610:77::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 11:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 11:21:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:21:11 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:21:06 -0700
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-2-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>
Subject: Re: [PATCH net-next v3 1/9] selftests: forwarding: extend
 ethtool_std_stats_get with pause statistics
Date: Fri, 20 Mar 2026 12:20:01 +0100
In-Reply-To: <20260319160410.2515105-2-ioana.ciornei@nxp.com>
Message-ID: <87tsua9276.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c328df-da7a-4fcf-d8ef-08de8672d1f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ihn8bnJLOioTDYALHBePy3x2SRsZxsGhMO/55fuiyej5N+/U9pIt/V6zx1ZUplsrQx1FTZJQKJ8hJMl7LEi9AZwsA2RaXO/xkk1t39ZQMox4pZK7Qe5RuyEkT1Cifq6+2X3quTN2aQS19EuCZogwiIuF/0EGI43dUUHdgGcjl9xbZELdCm1O5qwyekAyshC92jABXNccjIxkf4wglxCcEP+sMIDH50C4OU8DoKaRMG19VR3w5kpbYb09zwOLHmRtVdAvzDPEKNe1kZ7zw4XVOXxXiOXF723T4gcu7XGrtD2R2lKZQPBrgiIU+JG7pBzRBozmd6aw7adUGfztMvN5X0t56eeTrbK9L+iFjj3+Zh88G7mUxIpQBdDcg8xaRb9CsvS8Fg+AjHfSHs00SvzdhGc0ggt55Li2c5ANY8hEQJH6VN8EVx2+Y9yl32NtCmIHKeCiULT6jK7LRoAHCJOjnvKJAX5NGX4QG2j09TodcZe/W379igBgZuy67VQ1ypUCFAQux3VtSH2LQOi9zBxF7ER0hQVa2G0B08rkjjWqa92ceHZsCR1mbgrh74mzIHmBjixKiEBmkMooo6XQdRWKI6XYbLer4TYFDISjd1MOE+kVtUbTkJD7DfhvMTcFNxeAjk0F6okgZgQT1q2ts0cmP7C55TJ39WLp73PxvnNJR14Qk3cPBd/+opAW0Pu+PBiSCpqIan5AeB0Z3E69lw6PBPjYmAr5b9AdjF3GnUYYfN2hGbfyH4eNfMeyiDwJ/dnoG4qeQ19gY4fxJxBxqZVFPA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	61Ydl3HrODFeNl18dvsHDTV39X311DPj7dbIrSiAMAUkkureOU2r0HRfHudxuio2VwDoNejFtWGHRiZrQWYsIavIsCI2vPFUCI91Bca9cIyAc3f5cujtGCnkz0I8ixoDoISkQtvDHUu9Celf22VtQKrL80+ECF9bfZ0Pf2ce/5KKtvKdS0MEy2fNM2DMWpeXprutyMbh26egOyODd1hUcl6IlKaOv90OD3pnrVDSJvjllt9n4G+rVzaAeB4e4wtKkR/hZl9ZDIMdeOhmxj52KedJ5ogKdXcB8MGyLGeXOKK1hbNqng+wFkILJsv+5+82WaUdCpbRQnPkJr3tBPl2HqbBupCW6bAmu53kZAmptd1H+EmE+5YU2fM8RsUll+6PnzmWoXF2tQcke+XoJq4THYNmpzLycTMERAGuigv/3YO8krnNNvPmngI1/raW+w5r
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:21:23.8847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c328df-da7a-4fcf-d8ef-08de8672d1f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269888-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nxp.com:email,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.970];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6C5802D9731
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> Even though pause frame statistics are not exported through the same
> ethtool command, there is no point in adding another helper just for
> them. Extent the ethtool_std_stats_get() function so that we are able to
> interrogate using the same helper all the standard statistics.
>
> And since we are touching the else case, convert that as well to the jq
> --arg form in order to be easier to read.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v3:
> - none
> Changes in v2:
> - convert jq to the --arg usage form
>
>  tools/testing/selftests/net/forwarding/lib.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index a9034f0bb58b..cf40cb766c68 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -831,8 +831,12 @@ ethtool_std_stats_get()
>  	local name=$1; shift
>  	local src=$1; shift
>  
> -	ethtool --json -S $dev --groups $grp -- --src $src | \
> -		jq '.[]."'"$grp"'"."'$name'"'
> +	if [[ "$grp" == "pause" ]]; then
> +		ethtool -I --json -a "$dev" | jq --arg name "$name" '.[].statistics[$name]'

I missed this overlong line. Fold it, please. The R-b applies with this change.

> +	else
> +		ethtool --json -S "$dev" --groups "$grp" -- --src "$src" | \
> +			jq --arg grp "$grp" --arg name "$name" '.[][$grp][$name]'
> +	fi
>  }
>  
>  qdisc_stats_get()


