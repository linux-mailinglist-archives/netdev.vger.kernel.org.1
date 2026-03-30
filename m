Return-Path: <netdev+bounces-273145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H55KGJmymll8gUAu9opvQ
	(envelope-from <netdev+bounces-273145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:02:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3448335ABE7
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 850143022966
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF83C9ECC;
	Mon, 30 Mar 2026 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZbDAIP11"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB513C943A;
	Mon, 30 Mar 2026 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871739; cv=fail; b=eqGKC8/FlZMvaL7gGjJu+jyKN/RQ80pcmEWwOM5zd09QKF7UnwjFVJ5/QWqQ/wPNp7y1HMfmVRcFK5afGAOr7gGJ0tcTUsWxk9MVWbmRAwVR3x2ATY3eh7bupoKwaMrQTaHLgFaRc1QPl2pxC+AAV/Zqdw6hpIpz9uCstakFHZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871739; c=relaxed/simple;
	bh=OMhcETbCen3PG+TzWoFndJQ+AQBuJhIRHmK5cma8FO0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GOojD8kd6B0WcGcLdq18RiGuf7+RLkuFk7qnioWQPCUrEy6k0xg7lHR3rfLhqj0icQ+4NLIMboR2hNDzuYsME7HLFyLy3wdyr8cCSCb3Dv0bIuvUE/asYNShARuliZ57zXlqaWxeuYZQJA4SSisWGw/uhxOxFUXAsFm3MmMfYts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZbDAIP11; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCYXL98jiDE+dRxKLYDFVQYiKhE4D1nWqhJDxeK+aPyQkQi4uarmlX9cuRfrSWDa+dVHKRIf6Gae9tPC5bJKGT0JfyC8xkpwtIiuTAbpp1XMFYLqK7ZUNqnUicAAmTs5PHJVKXmkxUiRuQskq99ofthdtDAUYH5Kpv4WGQ4zGhHS9nLSaLXtRcRvToVotbuHyev0cLPkXf5InsoKW1jklYeQVtj8jaubcTHo78oKDrDjKhz5Kw8/YjMc9gaz4aZ/aezm0GdX7WY1uU+P9/8vLaSQPqVV3YPQtTjnaQQ9tyINND4pw6DeXDP/WrV5U1D4AqxRv88cLphZYyi5xtI8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x2F10Dsf181OIWZDQHiydsRVgzGuitS8vb5d5uW74c=;
 b=E8vzhWvEqQxxZXIf3m1VmBNvTVwJXgMTrYAregcYYa9FuNDMQAbvtwF86qxqAebB85HLe802raa3+71cOeqC3vwbg3GkLgT2QAZZhGiad/gWZ+HPJySxwYgzGhWN12ZlWyKQ51bETuzxODva0BGnsS4FjMig5AKKeu+g9oCoeYTBST3OjNlbJU+udSQOhIVl9MM+WWDyuSdnRb2mwf2CE2QGCNOEsCRXfynoKefWURysLU0VS/pA4URiyDjQGlOkVzO6QBus1pelpFiCDN/OX28O9hs2n4IZ65ts+yUO/Ca/xFIrZxTjl604BnGoZ0SY09wWaSIB3J6keRmzD5moCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x2F10Dsf181OIWZDQHiydsRVgzGuitS8vb5d5uW74c=;
 b=ZbDAIP11fofP7ZGB3dpiksZDUlNKpdPFyVuWUvQWGTcG6jlZZb4gCu/Zl13hWzdKi+LhRBVjDQBALVo5IVmFUjFlSekHckgUvpmduo+WgPsqyBPtJn6VsuOYGhGM/XxWJJK9liDd2d0Ww/oFDJxBEFslaJS7q1qJkn88GFe50WOoeHaJ5ql7i+A+CQtGb+NEFSb37Oxlhj28STJXAYN0N6PTeJZZXoyLvqp6QGPedLrQpXzI2t5uVfS5qIeWZVb8NxKTOWKgOFYDnlvwmaCmMQSrlG83HKVB8MBtASc9TuEmqbyeAzBwfjTbNYvF4PkDpgSsaNZUq6ACalGHTU8ESg==
Received: from PH7P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::28)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 11:55:33 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::a7) by PH7P221CA0009.outlook.office365.com
 (2603:10b6:510:32a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 11:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 11:55:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:55:17 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:55:11 -0700
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326120342.6429fbdc@kernel.org>
 <5cuoazp2svgjja5h663zc34dafkuqa2grrm7lzpuunvrjogydf@43mryp77gq2q>
 <20260327172454.6b9bc8f3@kernel.org> <87a4vp61m4.fsf@nvidia.com>
 <usxkovboo5jt6vu2jvbwpnsltvewjil27xizt3jjhggu5o4td3@2cgex6op4mzc>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: Petr Machata <petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
  Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <willemb@google.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4 00/10] selftests: drivers: bash support for
 remote traffic generators
Date: Mon, 30 Mar 2026 13:52:06 +0200
In-Reply-To: <usxkovboo5jt6vu2jvbwpnsltvewjil27xizt3jjhggu5o4td3@2cgex6op4mzc>
Message-ID: <87o6k54jms.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9d10f6-7d3b-4d27-cffe-08de8e533f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	rtRc3N+OAm/wLp1/+6Y7USX0gJ7exeKY2l9Xtt4nn0+1T6FIjCRFH3k3+2WApUvO1tlkx0nehy9/RHmDEhquEw8lrgWt2nGl9pn6F20aqqndPa53yKtkHMjJtbWYoIXYNMqrSkPbJFyGhzxSLi6K1RtvhYWUHfC38ql4bhdagEnvDRfS+zeRYDT4G/6Vt+XhHzEuhJlzegfD54q5OpBoK6hG/5OYR6V81iGxM0rM9ESer2W9v9TtbXUadaYKbQkeJ4u+bIWm6wxbvGhKAmvUeIW9LejEcONtpBoWgFSKpVu932SR6DXAy6Hk15GsOYjXbVwJ/yVNgqseiu+BNC8U2nfpdtTj2lI5j3guzv9/Pbq19DXwmm/wRsHwUW+F3Wpr8FMGkeqEEfHybWSAQ5Eogmlw6oOd1ZiYYRpRwcEFnn+PvkstAQ3mcUW+1neAGHw432krxFJ/Grg2YKo5bwFungd6gIHL7brmkIKVg3TZe47mlxn5SarJUUYNydmcH+KcCoasGp93YbgpbJGJTXKU2TgamErQr39g/kBjlwbfIbWLv+hp07QUKNTGCmSV5rQBS0JltIZ0gpRBTydRpcmUcvO4WrCpaoLCHpihyGBs0CBRpBeDoLQj4/AHC9am3aXIDPBn4m2S/aNOqfegv4gS2iYn5gO1hveOHxQK5GE0pT3FRnt/4P5vs/BP/jYzVOWRX01RipA5nmr8WWDmZhI9dQU/xWhCwe1O3S75OlQ8m7IhF6QOzKQeAIbnf7Nz7Y1/KvwEoeD1dsEl/FUnyyGpiA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+E+h4qLLVzmwn//D2XuP3V0y5XHkUUGFCKiJU+78h6rIlSK4VhSe9UBnnGrz9JD7XXDHM/grVs0bq7dB+pqLBW3FA9OPH4re539n3jwzSxZc7tFo6B0lRdqUW+p2s7LBdMkspsNWjfM5gZJc0ocEzRcmWvXDyBKKhlPdBQNCad4kYrHhhFcLazj/0XJRWgKv6JH41s7hWWvCl1YzF4ef+YbJUwlKA00hqvV4vk+k4HDOOxOFRLZvhC//CwHpMXhiEMIsP8Qe7aKl7U03WY/4bHoY6q8VFqof+IpZzdCkrj/cp430xFLxb7Ogg+XrMywjm/xOBYhDxJmbRc+31epDXSHTW3mlUtrxUvac7pnVIVDewq+XULK+iENtwJ88AMByESysla3B8vdjF/QTk7I09WDlSm44fTU35KZeTApYZG5md39IvrIVHpwSauwkH+Ja
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:55:32.5148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9d10f6-7d3b-4d27-cffe-08de8e533f28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273145-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,netcons_resume.sh:url,Nvidia.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3448335ABE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> On Mon, Mar 30, 2026 at 12:38:54PM +0200, Petr Machata wrote:
>> 
>> Jakub Kicinski <kuba@kernel.org> writes:
>> 
>> > On Fri, 27 Mar 2026 09:32:22 +0200 Ioana Ciornei wrote:
>> >> On Thu, Mar 26, 2026 at 12:03:42PM -0700, Jakub Kicinski wrote:
>> >> > On Thu, 26 Mar 2026 15:28:18 +0200 Ioana Ciornei wrote:  
>> >> > > This patch set aims to add the necessary support so that bash written
>> >> > > selftests are also able to easily run with a remote traffic generator
>> >> > > system, either be it in another netns or one accessible through ssh.
>> >> > > 
>> >> > > This patch set is a result of the discussion from v1:
>> >> > > https://lore.kernel.org/all/20260303084330.340b6459@kernel.org/
>> >> > > Even though the python infrastructure is already established, some
>> >> > > things are easier in bash and it would be a shame to leave behind the
>> >> > > bash tests that we already have.  
>> >> > 
>> >> > I think this introduces a bunch of regressions, eg:
>> >> > 
>> >> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/575622/4-local-termination-sh/stdout
>> >> > 
>> >> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/netdevsim/results/575802/18-netcons-resume-sh/stdout  
>> >> 
>> >> I cannot reproduce this unfortunately. For example, local_termination.sh
>> >> gives me the following result with the exact patches that I submitted.
>> >> Any idea on what might be the difference?
>> >
>> > Hm, the system that runs this on our end is:
>> >
>> > # cat /etc/redhat-release 
>> > Fedora release 43 (Forty Three)
>> >
>> > And it has this added on top of default install:
>> >
>> > # cat /etc/systemd/network/99-default.link
>> > [Match]
>> > OriginalName=*
>> >
>> > [Link]
>> > NamePolicy=keep kernel database onboard slot path
>> > AlternativeNamesPolicy=database onboard slot path mac
>> > MACAddressPolicy=none
>> 
>> The observed issues are consistent with TARGETS being defined, but not
>> an array:
>> 
>> $ declare -A T
>> $ T=([a.100]=b)
>> $ U=foo
>> $ if declare -p T &>/dev/null; then echo "${T[a.100]}"; else echo fail; fi
>> b
>> $ if declare -p U &>/dev/null; then echo "${U[a.100]}"; else echo fail; fi
>> bash: a.100: syntax error: invalid arithmetic operator (error token is ".100")
>
> Totally agree, that's what it looks like.
>
> On the other hand, I don't see any other use of the TARGETS variable in
> tools/testing/selftests. The only way I can trigger that kind of error
> is by setting and exporting TARGETS before running the test.
>
>  root@localhost:~/ksft-net-drv# export TARGETS=test
>  root@localhost:~/ksft-net-drv# ./run_kselftest.sh -t drivers/net/netconsole:netcons_resume.sh
>  [ 1895.134633] kselftest: Running tests in drivers/net/netconsole
>  TAP version 13
>  1..1
>  # timeout set to 45
>  # selftests: drivers/net/netconsole: netcons_resume.sh
>  # Running with bind mode: ifname
>  # /root/ksft-net-drv/drivers/net/lib/sh/../../../../net/lib.sh: line 707: eni497np1: unbound variable
>  not ok 1 selftests: drivers/net/netconsole: netcons_resume.sh # exit=1
>
> So this means that TARGETS is used by the netdev testing
> infrastructure, I presume.

I think Jakub has the export for make to pick up, and then tests inherit
it.

> Anyhow, I can change the variable name to avoid this. Something like
> NETIF_TARGETS?

I sent some thoughts about how to fix the issue in my review of 02/10,
so let's move the discussion there.

