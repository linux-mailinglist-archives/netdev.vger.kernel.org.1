Return-Path: <netdev+bounces-269891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KdKIggvvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:27:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 001B52D9878
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC533303388A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FBD39A078;
	Fri, 20 Mar 2026 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ioYMj7xQ"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013049.outbound.protection.outlook.com [40.93.196.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0C39A812;
	Fri, 20 Mar 2026 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006016; cv=fail; b=ADZsuZnyoq4DRVNAiookEC0KC6Ozy7MUBxkAqrTftyRWfNxY+Bxm/L45yenW57Ltd6sIqSkc36edQzjpQvtl97sO03MBSY05VcC2xPnyhZuOAlJJDuFSOvvg9oDfnWN7QMZ5UU9TggAb7wc0wwBAWZkfKGvR8kJ8PtJQTzcdlNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006016; c=relaxed/simple;
	bh=oALv7owQDwvB5pDdpSxeShMBkota3d1dYrJJI75NL/c=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ABG975XQ25iNfpFWbD7badOYVvos55E7/sYpl8JvBUDn4hX+zRuoNj5yHb2C4IuMr07SS5WjIsk8XnN8gUcflBTuu1w6ODfUBMwuh4igY0+e/54VXilCSI2Gv1xe26ie4gPVqFkZpaUhksVdSVAWTlnkt6dFFS3HmnGOhsDD6b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ioYMj7xQ; arc=fail smtp.client-ip=40.93.196.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJAJxFLmxdiqJeOyZ1fTv80Imz9pLZ3ApC5TNidN1ij1S0GNObRuaX0xCGIxx0TQEFdx7TBx7NLqq88T/C2QJMX1ZU/c8t+s4ogeo4xXgGz1UIV+Mm9thBPps9iKfnDjXeeNM+gxXHnzmh5BQtyofpBtDJvpPdRitx1ePRN6CwbC5Rb9um8O09hTH6Yha8y30z2gPk4a2Bq5+FxTvKdUzFH4ntpzso7FGY95Eu2xJ12r1gWZTarUS/JnwW/PfA1vmoq4NRm5SfpVQgZZP06y1PHLg/o28BURS5UzpZCTSKqTkmJed5IpD4cL0HvhH0uk8oflYBtLttPvyijRyaNU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E8sx0nSGdsyv21of26RhrMRF5prWrUWNT0iSLcf7LE=;
 b=W7UEwrCED3qQBITpkntg0NmJIyW5LJ8ZqksNSRADuAatqNHwcYLVx6U1BI8CGMYG7xxRG8fCLUTX36tzw2/s0aQCvSb3LgZ0uBvLQKCyWVe3JX867lda0uN32/gAx9SAYNGVXlzdXzWd1kK+ROYn27ZBXtYLx0FryGXN3BumPSgyZIhkbui2GV6PbTmAqRUNKejxnrBwhpapeg/hT1G72n7hyKBX1tj038jOV60xwEtFJQmmnjSpESGig1GLdfqVln4rwyeHZ4ENoMqPxB0xO2njHJt9/scX8cor2RSmwKPJgn3gIi01LMBjgNCqzzPZVUxYv67u4OnVrlVQRErVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E8sx0nSGdsyv21of26RhrMRF5prWrUWNT0iSLcf7LE=;
 b=ioYMj7xQN6V1UwniymSMBdfg+46rzeBtakxwqYomt5KbY9U7W0u4AJdauk7/p2QhqQLskuByOUglHoT2UpuYfv+ToJYTIUBDbACizbPRc2ZkjaxzBFJajNV3Aph7zRc5zENCyy7A0ddNKYr9A11KLfOwDWvmqIWwm69c1W2zg9wC/0vmY/rmZK6gxj0WyVdSSA5CF53bWuDRA3xWnir6+dUrzQTJ/kjrrCfklqqzSTE71znZQQlcUz7t9CWN6350IUn3Bn5HEophupIHL6GXgjf8pnVA0Ga3vFYXwoS1eXwA0oQjy/WKbp41eiCGCkhw1H9+GKA7mvkyXVCDrl3jFw==
Received: from SJ0PR05CA0106.namprd05.prod.outlook.com (2603:10b6:a03:334::21)
 by LV2PR12MB999098.namprd12.prod.outlook.com (2603:10b6:408:353::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 11:26:45 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::9b) by SJ0PR05CA0106.outlook.office365.com
 (2603:10b6:a03:334::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Fri,
 20 Mar 2026 11:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 11:26:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:26:36 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:26:31 -0700
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-4-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>
Subject: Re: [PATCH net-next v3 3/9] selftests: net: extend lib.sh to parse
 drivers/net/net.config
Date: Fri, 20 Mar 2026 11:19:18 +0100
In-Reply-To: <20260319160410.2515105-4-ioana.ciornei@nxp.com>
Message-ID: <87ldfm91y5.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|LV2PR12MB999098:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c07b846-f955-4f69-d776-08de86739147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4JuvHLjMUd8LtpWmt4RQ27JVTp43OmuvVdPXvSAwR3bdNJ2IlMfR5oyJQJ7XRb4Kk7rxshXGrLZSr/zxWE+egVuXeD8VDTGQRq7txf3cxGl0XGurggWcUMinx6iK4yYRy6eQpUp/oF+2HvTLQ3oQpyCf/me4Tb/p3Hu4w5YONE/h0vskan6CbkuHr6SIuyakCsHOsQJTahe5Y0c28OsNVwxUW2rPsNTpI+N4OpsJno+h12B2yN9LQkLRzVS/5lZYuatW8vSKQ049bbOU54STslStoalS7Ds2tkSt7BJuJ6ok+xcAjjtmXFQsFZEa723wgjqoicXH1KHjmQajpp1qqB5+hzvuJ0NV5F5ygR+kHbJtTSqvnyCM2NDKbJi8SClPrthooksk+UlcibG0RVUv+2ZzUOpzZ8jcrPW+4DLyqAMEdM43q4K4XcADbUpU7hLSQe5cBs7DYZciDsRSWxRZEbI8qIaba3TnvWlhNdiUMgkV+WoFd/NnPHCNxZ4jiWW4xkoTKCVOZWffJ3yOFWbe31iTARGHRdCMTgs3F4Uchr5E9ns/gVqXxcsBn0p16/qEpLtA8rbx3OqlYgfUqyi5h2nlN2kqAAYkSYoO4Zp3BlVKxFOXQgtykCdICjAiYYg62w93+Biop40ZCqO3bRnh6ecMz0LDNpaFoQLP3MrAi1BOXhFJwOJds0hpA0zU3BkmnvAgh8FTn7nQ2GVeh7wxLzgLgq//VPFqO7ennM8PQS885nhrc3v0pSJyc6ipBWDjGgXb3oYXE7viU9KFyu4QjA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HBorQBwVqnK5U+f7dk6WBAXdH1t4NyyYVCRu9ruR7QyHDdX9MRU9+hdlFtlHgASA01ryaClTXq4I2iy2ANZJ4uGh+BWdU7V9ICbgqBKhawEv04wqZ9C7DNrakSFjeqLFK6oCvhOxXCcZ0tC4aqHqFrNQmC8SXc/a9PEtBw5OYanEFMVXJW7+pd+ww0PRK49IW/qrDCe2s8tnHz1PgOeUEfWpCqQAK6amwA+fAngMNzPtu2KiZ44ysXhGng5fCIJa/bxsNnzUxm3ikEEkz32xbV6xAktzn7H/BFK2YBN+DQZbnjlXH2feY/1nzPvalqz/kBlAJQS1FvlN0Yzl1ZsHZrJbC4B8MLWlTNl4B/wsYJ4g9YfLyd2eYL6F2EmMR2aq4/xJ5uFXxK/woQBZdemZrFdyeomsft3rG/rJFX2CzX+GKT3nw7dsee0VdglwOPL2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:26:44.9632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c07b846-f955-4f69-d776-08de86739147
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999098
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269891-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.943];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 001B52D9878
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> Extend lib.sh so that it's able to parse driver/net/net.config and
> environment variables such as NETIF, REMOTE_TYPE, LOCAL_V4 etc described
> in drivers/net/README.rst.
>
> In order to make the transition towards running with a single local
> interface smoother for the bash networking driver tests, beside sourcing
> the net.config file also translate the new env variables into the old
> style based on the NETIFS array. Since the NETIFS array only holds the
> network interface names, also add a new array - TARGETS - which keeps
> track of the target on which a specific interfaces resides - local,
> netns or accesible through an ssh command.
>
> For example, a net.config which looks like below:
>
> 	NETIF=eth0
> 	LOCAL_V4=192.168.1.1
> 	REMOTE_V4=192.168.1.2
> 	REMOTE_TYPE=ssh
> 	REMOTE_ARGS=root@192.168.1.2
>
> will generate the NETIFS and TARGETS arrays with the following data.
>
> 	NETIFS[p1]="eth0"
> 	NETIFS[p2]="eth2"
>
> 	TARGETS[eth0]="local:"
> 	TARGETS[eth2]="ssh:root@192.168.1.2"
>
> The above will be true if on the remote target, the interface which has
> the 192.168.1.2 address is named eth2.
>
> Since the TARGETS array is indexed by the network interface name,
> document a new restriction README.rst which states that the remote
> interface cannot have the same name as the local one.

Isn't this going to be a somewhat common scenario though?

> Also keep the old way of populating the NETIFS variable based on the
> command line arguments. This will be invoked in case NETIF is not
> defined.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v3:
> - s/TARGET/CUR_TARGET
> - this used to be patch #2/9 in v2. Swapped the two patches so that the
>   run_cmd used in this patch is defined earlier, not later.
> Changes in v2:
> - patch is new
>
>  .../testing/selftests/drivers/net/README.rst  |   3 +
>  tools/testing/selftests/net/forwarding/lib.sh | 130 ++++++++++++++++--
>  2 files changed, 124 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
> index c94992acf10b..8d8d9d62e763 100644
> --- a/tools/testing/selftests/drivers/net/README.rst
> +++ b/tools/testing/selftests/drivers/net/README.rst
> @@ -26,6 +26,9 @@ The netdevice against which tests will be run must exist, be running
>  Refer to list of :ref:`Variables` later in this file to set up running
>  the tests against a real device.
>  
> +Also, make sure that if you are using a remote machine for traffic injection,
> +the local and remote interfaces have different names.
> +
>  Both modes required
>  ~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index cf40cb766c68..fb5aa56343e1 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -3,6 +3,7 @@
>  
>  ##############################################################################
>  # Topology description. p1 looped back to p2, p3 to p4 and so on.
> +#shellcheck disable=SC2034 # SC doesn't see our uses of global variables
>  
>  declare -A NETIFS=(
>      [p1]=veth0
> @@ -17,6 +18,26 @@ declare -A NETIFS=(
>      [p10]=veth9
>  )
>  
> +# Array indexed by the network interface name keeping track of the target on
> +# which the interface resides. Values will be strings of the following format -
> +# <type>:<args>.
> +# TARGETS[eth0]="local:" - meaning that the eth0 interface is accessible locally
> +# TARGETS[eth1]="netns:foo" - eth1 is in the foo netns
> +# TARGETS[eth2]="ssh:root@10.0.0.2" - eth2 is accessible through running the
> +# 'ssh root@10.0.0.2' command.
> +declare -A TARGETS=(

This is a helper array for internal use only, not a user interface. It
should just be declared suitably close to where it's actually
initialized. It doesn't even need its own initialization, there's code
down there to initialize it accordingly.

> +    [veth0]="local:"
> +    [veth1]="local:"
> +    [veth2]="local:"
> +    [veth3]="local:"
> +    [veth4]="local:"
> +    [veth5]="local:"
> +    [veth6]="local:"
> +    [veth7]="local:"
> +    [veth8]="local:"
> +    [veth9]="local:"
> +)
> +
>  # Port that does not have a cable connected.
>  : "${NETIF_NO_CABLE:=eth8}"
>  
> @@ -340,17 +361,108 @@ fi
>  ##############################################################################
>  # Command line options handling
>  
> -count=0
> +check_env() {
> +	local vars_needed=("LOCAL_V4,LOCAL_V6"
> +			   "REMOTE_V4,REMOTE_V6"
> +			   "REMOTE_TYPE"
> +			   "REMOTE_ARGS")

Given how much hand-rolled code is needed for cross-checking local x
remote config symmetry anyway, I wonder if this whole thing should just
be very simply:

	if [[ ! (( -n "$LOCAL_V4" && -n "$REMOTE_V4") ||
		 ( -n "$LOCAL_V6" && -n "$REMOTE_V6" )) ]]; then
		echo "SKIP: Invalid environment, missing or inconsistent LOCAL_V4/REMOTE_V4/LOCAL_V6/REMOTE_V6"
                exit "$ksft_skip"
        fi

Then you still need a manual check for REMOTE_TYPE and REMOTE_ARGS, but
that's still just three checks all told like the current code, and we
get rid of the double nested loop that's kinda tricky to understand. It
doesn't look like the generalization really pays off here.

> +	local missing=()
> +	local choice
> +
> +	# If a choice has multiple comma separated options, at least one must
> +	# exist
> +	for choice in "${vars_needed[@]}"; do
> +		IFS=',' read -ra entries <<< "$choice"

Entries should be declared as local.

> +
> +		local found=0
> +		for entry in "${entries[@]}"; do
> +			if [[ -n "${!entry}" ]]; then
> +				found=1
> +				break
> +			fi
> +		done
>  
> -while [[ $# -gt 0 ]]; do
> -	if [[ "$count" -eq "0" ]]; then
> -		unset NETIFS
> -		declare -A NETIFS
> +		if [[ $found -eq 0 ]]; then
> +			missing+=("$choice")
> +		fi
> +	done
> +
> +	# Make sure v4 / v6 configs are symmetric
> +	if [[ (-n "${LOCAL_V6}" && -z "${REMOTE_V6}") || \
> +	      (-z "${LOCAL_V6}" && -n "${REMOTE_V6}") ]]; then
> +		missing+=("LOCAL_V6,REMOTE_V6")
>  	fi
> -	count=$((count + 1))
> -	NETIFS[p$count]="$1"
> -	shift
> -done
> +
> +	if [[ (-n "${LOCAL_V4}" && -z "${REMOTE_V4}") || \
> +	      (-z "${LOCAL_V4}" && -n "${REMOTE_V4}") ]]; then
> +		missing+=("LOCAL_V4,REMOTE_V4")
> +	fi
> +
> +	if [[ ${#missing[@]} -gt 0 ]]; then
> +		echo "SKIP: Invalid environment, missing configuration: ${missing[*]}"
> +		echo "Please see tools/testing/selftests/drivers/net/README.rst"
> +		exit "$ksft_skip"
> +	fi
> +}
> +
> +get_ifname_by_ip()
> +{
> +	local ip_addr=$1; shift
> +
> +	run_cmd ip -j addr show to "$ip_addr" | jq -r '.[].ifname'
> +}
> +
> +# If there is a configuration file, source it
> +if [[ -f $net_forwarding_dir/../../drivers/net/net.config ]]; then
> +	source "$net_forwarding_dir/../../drivers/net/net.config"
> +fi

This is going to impact all tests though, not just those that are meant
to work with this. If I have this file, it sets NETIF, and all my
forwarding tests (presumably) break, because NETIFS doesn't get
configured correctly.

The requirements for driver tests are different from forwarding tests.
In particular, interfaces do not belong to driver tests, the test can't
bring them up or down, reassign addresses etc., merely to use them for
traffic. (Which you know, I'm just stating it for context.) So I think
there needs to be an opt-in variable for this stuff. Like setting
DRIVER_TEST_CONFORMANT=yes before sourcing the library or whatever.

Then NETIF ceases to be a tell and becomes an environment requirement
for check_env to validate like the others.

(Another alternative is to extract a common core from lib.sh and have
both lib.sh and net/driver/lib.sh use that. But that's more of a change
and I'm not even sure it's the right way to slice it.)

> +# In case NETIF is specified, then the test expects to pass the arguments
> +# through the variables specified in drivers/net/README.rst file. If not,
> +# fallback on parsing the script arguments for interface names.
> +if [[ -v NETIF ]]; then
> +	if (( NUM_NETIFS > 2)); then
> +		echo "SKIP: NETIF defined and NUM_NETIFS is bigger than 2"
> +		exit "$ksft_skip"
> +	fi
> +
> +	check_env
> +
> +	# Populate the NETIF and TARGETS arrays automatically based on the
> +	# environment variables
> +	unset NETIFS
> +	declare -A NETIFS
> +
> +	NETIFS[p1]="$NETIF"
> +	TARGETS[$NETIF]="local:"
> +
> +	# Locate the name of the remote interface
> +	if [[ -v REMOTE_V4 ]]; then
> +		remote_netif=$(CUR_TARGET="$REMOTE_TYPE:$REMOTE_ARGS" get_ifname_by_ip "$REMOTE_V4")
> +	else
> +		remote_netif=$(CUR_TARGET="$REMOTE_TYPE:$REMOTE_ARGS" get_ifname_by_ip "$REMOTE_V6")
> +	fi
> +	if [[ ! -n "$remote_netif" ]]; then
> +		echo "SKIP: cannot find remote interface"
> +		exit "$ksft_skip"
> +	fi

This should check that $NETIF != $remote_netif.

> +	NETIFS[p2]="$remote_netif"
> +	TARGETS[$remote_netif]="$REMOTE_TYPE:$REMOTE_ARGS"
> +else
> +	count=0
> +
> +	while [[ $# -gt 0 ]]; do
> +		if [[ "$count" -eq "0" ]]; then
> +			unset NETIFS
> +			declare -A NETIFS
> +		fi
> +		count=$((count + 1))
> +		NETIFS[p$count]="$1"
> +		TARGETS[$1]="local:"
> +		shift
> +	done
> +fi
>  
>  ##############################################################################
>  # Network interfaces configuration


