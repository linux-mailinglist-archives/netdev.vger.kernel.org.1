Return-Path: <netdev+bounces-273142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L2JLg9lymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:57:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415535AAE9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBBC0306C515
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A913C5DA0;
	Mon, 30 Mar 2026 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DOX29jD0"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822130F547;
	Mon, 30 Mar 2026 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871452; cv=fail; b=anEJ/0t/vsKPTcFlv6WdNudyezOebPnVBErdXQFNP6J6AIBYf+1VkAQk0zX7preBRll0IjlEgMHfoP91D8RE9jxS6dgX0awxbaiuCXc2GzpL60YS9aIOEV78rFkYAq9Jh7hTDttYQWgn5yGUt4X4OtxaNhRyReAYxv0g0Fw0WiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871452; c=relaxed/simple;
	bh=OPtfQtvjizEm76poWJkNAYWJ427BxYYi/iQAH8+VaZo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TsrL9B4C1kKOll1hZj0FmTiiBlX+zRaNLZveY09zZgHtNtf9uvz2SGMDkfRZALCHoppNQCzXTFMzxpF8Fxw01IKP2PDKoyOjESSa0T1OTcqq8iPcfoCzVyr9c7HaNdVkKqVYimUkPu5bpivoE8uBi2YM61NDkP6PLUYTeWAxdI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DOX29jD0; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypwjYMHC9oabCmqmshKeq4/7JKvj9Zi+csgvpp1RpgXX9Vc9G2DnMTK4uow4i44+X36xcUMqJG6KYH+HxvuVIx1Qq7w8JqyQiNFKWR4AuC/raRwE9M7XwwTRqTOw/jXIKI0s9TntH95gPs05hTn5z3KyOnInVRojkjWajOI+nl9JEQ9frWyn1C0Mzz8v+4PqatUzrFtPLk7QAK8NnN9PlGOD4UfwBn8IRDnhSUyt+CvX/A3iSHe0mRouEgHmjQRz76JmW8ORAuQa0eAiibfZzqCHZIn/ZZbJvOj5/fsjmrU4NZsRZm8/VMhbPFq3XKRrlDWq96IJhj0421/sGbf3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYsAhJBh2iIIuK80/NJMrsbbjHWvbJR1adsPd9eDaXc=;
 b=ZUfZYmRqWyGQOknr6lXT/mrl9G+8guv6pCFgDrkz0+ER4KxeKB2T3zClCevH0lTHcOwbkrY/XmZIR3MSaz2bV9Fpc2OsLquYHfqARSHmyry7l7IsCFonPW8/Nd48+FFPbyBp6aNshx/SjqKIL3HV2TWFeAn66+QwmU4fYyjxBB2MiMAzHY1McAxd8sovq//ZWbJzU5jCz9yKjRzQXJqD7QmSN3eMwgvFsINhvnahheaTJGYYmHzY4qmnpQPK2e8lIBUFSFOwF6t1wobFhdkrhn2QUe+j6VCdFjeb2mKU0hedFackmd9hR42f9eDtKqArr4taMWYh7LvrTxdo6+ZkDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYsAhJBh2iIIuK80/NJMrsbbjHWvbJR1adsPd9eDaXc=;
 b=DOX29jD0V7pzQdJdLF6MqDSCrtKUi7NuoWwLKoJEX69ZEKkDCulae9w3W6EiT8aceHaVjEhLEEJBZu7cTZNR0UbFRlPePFkAUTKCPksIez8peM2j3D30+HAn8DeUFSHewOqqcsCZivD5Iql5wJezc1tOcFzhKH2KylTLhISy7FeV0RRuLhoALK9nnxp28bEWsddsHEhVaVd4BUaQe3NF5bwzJHVyIFHKiA6dzN2b8V5XB3LnoxoP/FFrRgm61XEQzcd5JyCkYA0tJdV7Ds3O5cEeYq2OL2okg1zCG1xGHY89/yCDUCToMUUKu5zkzEqQpQCeLER+jy0KPjY67PscRA==
Received: from CYXPR02CA0022.namprd02.prod.outlook.com (2603:10b6:930:cf::26)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 11:50:45 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::62) by CYXPR02CA0022.outlook.office365.com
 (2603:10b6:930:cf::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 11:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 11:50:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:50:28 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:50:22 -0700
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326132828.805703-4-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4 03/10] selftests: net: extend lib.sh to
 parse drivers/net/net.config
Date: Mon, 30 Mar 2026 13:28:49 +0200
In-Reply-To: <20260326132828.805703-4-ioana.ciornei@nxp.com>
Message-ID: <87wlyt4juu.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7195f7-ad4e-4087-adfd-08de8e5293bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	S59946ceO8uDiqD/h/22g4MpB4oE/PxVuCeq476EeCeDHqCykjFJqrlXKBihV2Xoz4oAP5QBnGvpgOp+EXz148Sfoqq4NyUjl/6jRT2StDSGdZhrQVLeOlyzGnWuHWWzwtEy1VFbwATZKOb+YfROYSh1NuKI/vNc5XQv7PWgaDcbPjk59emOFecsi0y+onMUKjJExLwGlJ2wcMqGt65KiniYibFlGL7hyBnCjMfsmZLl69BQEJ/rjapjTzQVySuTaOIfHUxw3l63j4XV9GF+IBU4GepjefRfPI48bEJlf/XXULDQmjKQbn8yE9DVuVspnILRDuKOj3W2YU8EDES74fAJONhZTVy5Dy05RP+E8XIWWQd9df4cmHHCIu8GQGzXnRKj5JJJbhWQjQIkmBBsRbcfgxpO1D9t5BiMI1hxppFUygCScGaHKgC0j79l17USRrr2Bz+knAHYcx/Y25fQxSswmwGXPcWPe9HzJ4Qfz5bsxSYw2BSJUWYAxE6URPwLfxbL3g8+z4WpMujzrKkxjOo4zVBuud0KT+AM8SgShr6IJwt+Ztn/Dh60vdAC8H0bIL9xGcUqMgA4qqAG7TdEx6O+9teCLJHEnNyUzZdic9sAJupd7IIeme4KWUsM3HFdYZPJfuTniSh8QyBpI9hLdLLWfdjMAbRevTngBmj+vFzgbKgkeXwZEbs5ZqpR48nlYQOwWzSzl8fOgzS4NUx+s5wsiWMrRTc2zYtnZFcgEu3GHj8kLu4ZF4X6INSugDerV0NhKQhXJmWpPUmDiOYPjg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MSxLrVaAfnayIt+/x5CTztcgdkLE/ArOkiEP2r2eed6N+OSLNyO2a5DE/FdyyT9yXUrIzV2wkGRgIQ7zi4vcSwCr8M5KFOSvb9d6N9mKCdxiiV4lJLuAafSJSpwwTWL+0b6Nkahf70UZ/EAjcVo5xkTuFmgiHDvs758GTHu+zDpmjhGRRB1Rkuapn+r1OhzlF5tcAuzjb4Th8eFenOGTHThwuTq3dOu6gB/+cicsRl3qFYW7mITNN6zmvi5Fu5gvF6aKNgMJ6Sb3zyVEHegcv+14fbXDTvd4gXpRricv33LvV/DG2qA7IgjU3WIAyG/++jtH6pV2QLk/X+8yZi8DOE7wfGHS6zrpojMoi5ZeOGkDK30CfHLkUWJl7meI7G33XpQQgflZ+lzRwcfieY9/fFJgqiA4lwmQENQXdx2XTT3xHFWRW/KbefsfcR7Pwwgs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:50:44.9158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7195f7-ad4e-4087-adfd-08de8e5293bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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
	TAGGED_FROM(0.00)[bounces-273142-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,lib.sh:url,nvidia.com:mid,nxp.com:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1415535AAE9
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
>
> Also keep the old way of populating the NETIFS variable based on the
> command line arguments. This will be invoked in case NETIF is not
> defined.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v4:
> - reword the entry in README.rst to mention that the different interface
>   names is only a bash restriction and the python infrastructure does
>   not have the same problem.
> - only declare the TARGETS array when necessary

I guess you mean at the point where it's necessary, instead of it being
a user API. Right now TARGETS is defined always, and I think that's
better than having it only defined sometimes.

> - add a new flags - DRIVER_TEST_CONFORMANT - that needs to be set by the
>   test
> - rework the check_env() function so that its logic is simpler
> - source drivers/net/net.config only if DRIVER_TEST_CONFORMANT == yes
> - check that NETIF and the remote netif have different names and abort
>   test is not
>
> Changes in v3:
> - s/TARGET/CUR_TARGET
> - this used to be patch #2/9 in v2. Swapped the two patches so that the
>   run_cmd used in this patch is defined earlier, not later.
> Changes in v2:
> - patch is new
>
>  .../testing/selftests/drivers/net/README.rst  |   4 +
>  tools/testing/selftests/net/forwarding/lib.sh | 106 ++++++++++++++++--
>  2 files changed, 101 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
> index c94992acf10b..1897aa1583ec 100644
> --- a/tools/testing/selftests/drivers/net/README.rst
> +++ b/tools/testing/selftests/drivers/net/README.rst
> @@ -26,6 +26,10 @@ The netdevice against which tests will be run must exist, be running
>  Refer to list of :ref:`Variables` later in this file to set up running
>  the tests against a real device.
>  
> +The current support for bash tests restricts the use of the same interface name
> +on the local system and the remote one and will bail if this case is
> +encountered.
> +
>  Both modes required
>  ~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 3009ce00c5dc..93b865681840 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -3,6 +3,7 @@
>  
>  ##############################################################################
>  # Topology description. p1 looped back to p2, p3 to p4 and so on.
> +#shellcheck disable=SC2034 # SC doesn't see our uses of global variables

The shellcheck line should be moved elsewhere. The comment is related to
NETIFS, and it's weird there's a shellcheck declaration between a
comment and the thing it's commenting.

>  declare -A NETIFS=(
>      [p1]=veth0
> @@ -85,6 +86,9 @@ declare -A NETIFS=(
>  # e.g. a low-power board.
>  : "${KSFT_MACHINE_SLOW:=no}"
>  
> +# Whether the test is conforming to the requirements and usage described in
> +# drivers/net/README.rst.
> +: "${DRIVER_TEST_CONFORMANT:=no}"

Not sure this makes sense as user API either honestly. Given the
differences between requirements of the two test types I can't imagine a
non-conformant test would be runnable like that. The actual line is OK,
but it should be moved probably above the if check, so as not to
indicate it's usable as a user API.

>  ##############################################################################
>  # Find netifs by test-specified driver name
>  
> @@ -340,17 +344,101 @@ fi
>  ##############################################################################
>  # Command line options handling
>  
> -count=0
> +check_env() {
> +	if [[ ! (( -n "$LOCAL_V4" && -n "$REMOTE_V4") ||
> +		 ( -n "$LOCAL_V6" && -n "$REMOTE_V6" )) ]]; then
> +		echo "SKIP: Invalid environment, missing or inconsistent LOCAL_V4/REMOTE_V4/LOCAL_V6/REMOTE_V6"
> +		echo "Please see tools/testing/selftests/drivers/net/README.rst"
> +		exit "$ksft_skip"
> +	fi
>  
> -while [[ $# -gt 0 ]]; do
> -	if [[ "$count" -eq "0" ]]; then
> -		unset NETIFS
> -		declare -A NETIFS
> +	if [[ -z "$REMOTE_TYPE" ]]; then
> +		echo "SKIP: Invalid environment, missing REMOTE_TYPE"
> +		exit "$ksft_skip"
>  	fi
> -	count=$((count + 1))
> -	NETIFS[p$count]="$1"
> -	shift
> -done
> +
> +	if [[ -z "$REMOTE_ARGS" ]]; then
> +		echo "SKIP: Invalid environment, missing REMOTE_ARGS"
> +		exit "$ksft_skip"
> +	fi
> +}
> +
> +get_ifname_by_ip()
> +{
> +	local target=$1; shift
> +	local ip_addr=$1; shift
> +
> +	__run_on "$target" ip -j addr show to "$ip_addr" | jq -r '.[].ifname'
> +}
> +
> +# Based on DRIVER_TEST_CONFORMANT, decide if to source drivers/net/net.config
> +# or not. In the "yes" case, the test expects to pass the arguments through the
> +# variables specified in drivers/net/README.rst file. If not, fallback on
> +# parsing the script arguments for interface names.
> +if [ "${DRIVER_TEST_CONFORMANT}" = "yes" ]; then
> +	if [[ -f $net_forwarding_dir/../../drivers/net/net.config ]]; then
> +		source "$net_forwarding_dir/../../drivers/net/net.config"
> +	fi
> +
> +	if (( NUM_NETIFS > 2)); then
> +		echo "SKIP: DRIVER_TEST_CONFORMANT=yes and NUM_NETIFS is bigger than 2"
> +		exit "$ksft_skip"
> +	fi
> +
> +	check_env
> +
> +	# Populate the NETIFS and TARGETS arrays automatically based on the
> +	# environment variables. The TARGETS array is indexed by the network
> +	# interface name keeping track of the target on which the interface
> +	# resides. Values will be strings of the following format -
> +	# <type>:<args>.
> +	#
> +	# TARGETS[eth0]="local:" - meaning that the eth0 interface is
> +	# accessible locally
> +	# TARGETS[eth1]="netns:foo" - eth1 is in the foo netns
> +	# TARGETS[eth2]="ssh:root@10.0.0.2" - eth2 is accessible through
> +	# running the 'ssh root@10.0.0.2' command.
> +
> +	unset NETIFS
> +	declare -A NETIFS
> +	declare -A TARGETS
> +
> +	NETIFS[p1]="$NETIF"
> +	TARGETS[$NETIF]="local:"
> +
> +	# Locate the name of the remote interface
> +	remote_target="$REMOTE_TYPE:$REMOTE_ARGS"
> +	if [[ -v REMOTE_V4 ]]; then
> +		remote_netif=$(get_ifname_by_ip "$remote_target" "$REMOTE_V4")
> +	else
> +		remote_netif=$(get_ifname_by_ip "$remote_target" "$REMOTE_V6")
> +	fi
> +	if [[ ! -n "$remote_netif" ]]; then
> +		echo "SKIP: cannot find remote interface"
> +		exit "$ksft_skip"
> +	fi
> +
> +	if [[ "$NETIF" == "$remote_netif" ]]; then
> +		echo "SKIP: local and remote interfaces cannot have the same name"
> +		exit "$ksft_skip"
> +	fi
> +
> +	NETIFS[p2]="$remote_netif"
> +	TARGETS[$remote_netif]="$REMOTE_TYPE:$REMOTE_ARGS"
> +else
> +	count=0

This leg is missing declare -A TARGETS.

Since both legs need to declare it, why not move it up above the if?

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


