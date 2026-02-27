Return-Path: <netdev+bounces-261890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA70I3i5oWkYwAQAu9opvQ
	(envelope-from <netdev+bounces-261890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:34:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CEC1B9DF5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5804A3004F5D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C205E3F23D8;
	Fri, 27 Feb 2026 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E/U3XnQr"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384633271EA;
	Fri, 27 Feb 2026 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205718; cv=fail; b=DvaT3oy3TlfVMuC5F4RutccL+Z1/M0N9Qb9h9R4BGZkYS53wdjtuBVdzoATdKRkQ8qEp1vkgeVaPGMKTtLWq32rKyFtkNpnqtovl0NA9aISp4iV8yn3n21+7PKvXIYM6DdDnQml1MgZgI4KimEV9ivYunJH2M1ZannYlbqtBhCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205718; c=relaxed/simple;
	bh=JiutV3UHwO72khaD4bAX/jR/hJu6sW2z18WKSrAeVbQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=SFeH3g5HIbDrD9+35GSzTRqgkLqehFvOSdlRERERyRuhHxLOzejBlUgV2dhs6P9uNusLhdnCGrJbZskZAKV1UtUFRwKN8DGvZW5EPBtSReqEnccXDilkBMHNietbIfKJ+luwwgnUbncZz7GeSv1opqz7LmJR2n+i3F/y9SFlr3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E/U3XnQr; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP1peUDWITSMWFnvH+P5a6HQvl4OJEFD+k85Tc1yeU1CA/bL2fWfhLm7+63KT+QPM7cYQwUe8S0RGvjvph4WXHvN208HVJpB/mMk9Uayd/hah6XnHQDFYC26x9dks4rlGfb9Sdrj8q4EkGvXfpbJiHH05sZ4m93VPoQFMf4Cgk9NsVgB8QKmIN8ifpOJd7GGCuhQGCJ2VatMuMiEY5lXZQE1QOkabHqmQGWjw6PZGZsVP5ruhYspJ2vKn+KYrZSn+zdHTRNVhCuejLEdHtWHdGKC8pihZNjew0gngCjudWNJSFrLp3wSpiZJkzbkCOC9f14I+Bfh+humr3JotnblvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeOOZg4wK1CrnDE2ZVe5Nhy28oZpvsckyx9rGp2ty2E=;
 b=jqEVUmtTJu5LiSbxMglWmu1VtesGAk1f8B3P4EJEX+7Q5B9QmB8ph3dE46GndKO0dwIcjc95bWJFtaUqB4qt8HH2umoT40/1BBvqIW+t2v0+TONzK8HP2CY7JWCOfLtZeQbsCpfkhDZadB9OuMJaKg+q3gVd+lBb0Ku4ju52vhstJRcVIRP6vfMmPRqA98QXkyGnBrqADLtm1gy+RdNko1M/saLh9v1uTuDwJ/bMCD3VrTPbG590wrz18cCEZ2uq9i5Y1wpOOiHynICgbg/YWq0jiPGS6mlNmWSnC8I2plxPGxLrh9k/2xog9bgDh/eE6UsNwYyuA250z6uztSeKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeOOZg4wK1CrnDE2ZVe5Nhy28oZpvsckyx9rGp2ty2E=;
 b=E/U3XnQrosTGSy9b7eTUTm4nsR2WmShbisY00Mj1KYI2ONaalCOc6ef/nsdJLLU6ue9hapC1eS/E6q2uYfxbsYed+zR7lcBImZd7mZulO3WGjnR8oKAgXLl5uSIGuT1Kn1af+hmR/yWdGdrloWQ2C+zBP3gYx/PpemNYm9rLjWvSn5tPNGT0R3YPavBE8fOFLflrkdjjPz5fQTrfhAwYDGcFnx+ZlJI5vPjKVDoz64N/mpuojdE1dle7aMYxkTxG4XBcc7WiSpLdUWIF9KAN4tXy4y3QemYjsiTtUIP1qk6BSuW1zf8Y1GoqLIfyyWhg05kRaOcbCG5EKZFcd9Nq2w==
Received: from SJ0PR05CA0087.namprd05.prod.outlook.com (2603:10b6:a03:332::32)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 15:21:45 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::ae) by SJ0PR05CA0087.outlook.office365.com
 (2603:10b6:a03:332::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.14 via Frontend Transport; Fri,
 27 Feb 2026 15:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 15:21:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 07:21:18 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 07:21:14 -0800
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
 <20260226182223.5eb1b10f@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Ioana Ciornei <ioana.ciornei@nxp.com>, <netdev@vger.kernel.org>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S.  Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah
 Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Petr
 Machata" <petrm@nvidia.com>
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Date: Fri, 27 Feb 2026 14:53:06 +0100
In-Reply-To: <20260226182223.5eb1b10f@kernel.org>
Message-ID: <87ms0ufc0p.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: cba2866c-cfd2-456f-aaf8-08de7613eabe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|3122999024;
X-Microsoft-Antispam-Message-Info:
	K/HIOu7FlWCVIC+GJFhftLHTAfQFzc4hhNSB+1IqzDDE5RcZfGys4fnu4URaH0gTIrk4BOw2WpcmqOi8b3KHUewe0IUBwv1mvttSc35hYnmnlppjUw0eYqRVza2uagnyR/rg6yGsvtAbXEu6kO8Re2VChXUFq6RFdGfhd3t+RgjCjqJCDP4kjzKfKPGP8Cgrs5LNX2OxoEBvzVP5SSgfTbw4RjbbPQWytBQfXXLi275vp6+AP0XFMbqYiBsTfCUU31sEOYMir/2IPgrSz+gmpyxw1vEXAEGpj4ioj3U8tEI0wzJMFsSe+JF0e2L3gMqmHRhBJz5zIZ+cFzNNXCS/A4hBHTOTSXre+MU0GBgZDlnYKz6Wq7Pfh4d+mORjI3Zbj/WxOtLpkothJqqpEL80+0RrqYarjEpMSnqszhmQI8RAO+fZmrTVXiGfdurvB5c4IXzIDImngBYHdlLdCRHuTumiabLiurFPZ0Ic5mfV2gAQ5oWjGd7WYNZ+lBlwThS0vZWFavuvL3WviQYeXkxz2LlHw5f9rBX9Q4Uic/JksXWEtN424vpcCECUZPrPt9AvJ3Ttwqz3g7pY4NjD3GLOrTRTKQGOE+xNtVN4wH0CnQuEFeACCzPlc2Zm+IzZgkEosR0CE8gMbaxY9Bb6sssZxB8cTwIIGc9luOwEi/GsdCMeO+XZdYA3Exsw/qA9pvGTwd93bLRhoborqhq05V8XTZ0S8yqqz/HTQFZGTSv8NdUwVGO+FLgXfdLjfrjcwe+RXchf4njfaEFmHp8QJ3GAADdQI81b7UIo5wwMoXv3+o4weqiMSHlTPhmdPCysr17ky5IJ3vjcsfN2HeeMbDgG1A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(3122999024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lr2Xu6UhATEP39O3SZ6whsSgO61Gu6v5Tz5dMnBjhxeWtjnmde1iJpPPPeyH2uKbSdylSNA9PubvwAkCIvPiIhzMxL2XXo6DZ2xioE1EutrGaRXaxbytZp57SCtMDXxx6dLKxltu+4WVZfj6xAHZ5BY4uGqBQrlslpvQ/aV+nW8pK+Bd7LfWaavjrnNpWXlL65S+S5MtyKWkt00rR7bLs1BHnk1HYB1FaOwJ0pbvg26T9u/Zky7KcFpFdf2NOVWtP9i/oys+h8wrK9vth35Ute4CASBz2vdz/n4gRzJtFCTb1dIAfTicuSQLrKzp3IISQWHr3EJbKIDTO2f6BwwjQOtfoKxA6cSImAh23pCczqlzIbOCOszQrfGY0o/iRlzQptYwITE5C1iQ6zBuS5zafAIwXL92RIfz5s5/2E/X051j3NSseCaSg4OhX6zjGooD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:21:44.7702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cba2866c-cfd2-456f-aaf8-08de7613eabe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-261890-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E2CEC1B9DF5
X-Rspamd-Action: no action


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 25 Feb 2026 17:06:48 +0200 Ioana Ciornei wrote:
>> +ALL_TESTS="
>> +	test_eth_ctrl_stats
>> +	test_eth_mac_stats
>> +	test_pause_stats
>> +"
>> +STABLE_MAC_ADDRS=yes
>> +NUM_NETIFS=2
>> +lib_dir=$(dirname "$0")
>> +# shellcheck source=./../../../net/forwarding/lib.sh
>> +source "$lib_dir"/../../../net/forwarding/lib.sh
>
> Argh, at some point we should probably decide whether we have 
> a preference on which "library" / set of env vars we use under 
> drivers/net/hw. Adding Petr to CC.

I think the expectation is that by default, tests written in Bash are
run on one machine without remotes.

I think this fundamentally stems from the fact that running processes in
Python is a bit unwieldy, so it makes sense to have helpers, so
everybody uses them, so you can have helpers grow brains to do things
like over-the-ssh configuration. In Bash, running a traffic generator is
easier than working with arrays. So the helpers tend not to be as useful
and we don't generally have them. At least not in any consistent way.

Eyeing the file, the requirement for the remote interface to be up and
configured with an IP address is a bit surprising to me. I would think a
down state is the most natural, and have the test bring it up and
configure it in a way that it needs. I'm thinking maybe this is to allow
testing a sole interface on like an embedded device?

Anyway, that's a fairly strong differency between how Bash tests are
typically written and the NIC setup. I think basically all existing
tests assume the devices are theirs to tamper with.

> The existing tests under drivers/net/hw which source forwarding/lib.sh
> pre-date the "NIC setup" described in 
> tools/testing/selftests/drivers/net/README.rst
>
> Should we ask "NIC setup" to be used for all tests which only need
> NUM_NETIFS=2 ? These are basically simple tests where one netif is 
> a traffic generator and the other is the DUT. And IIUC the "forwarding
> setup" can't be used when the traffic generator is controlled over SSH?

In principle nothing prevents lib.sh from growing brains to support
these remote shenanigans. I think it's just that so far nobody cared
enough to actually do it.

I think that a helper that in effect does "run this on a machine where
$swp1 is" is mostly what is needed. That and "make sure $swp1 and $swp2
are on the same machine". It's going to be annoying to work with though,
because you need to annotate every single command. I bet there's a nice
syntax to make it not activelly annoying.

If we have this, it might make sense to require tests to make use of it.
(With an explicit opt-out for special cases.) But I do not want every
test to have to reinvent this wheel and cargo-cult snippets from other
tests.

BTW, my guess is that even many multi-port tests that I wrote boil down
to just a bunch of fairly independent loopbacks whose far ends could be
on remote machines. It's not a priori nonsense to me that one would run
a test like this, or whatever magic we'd use:

    ./test.sh ssh://petr@10.1.2.3:eth1 swp1 veth1 ns://foo:veth2

And it just works, because only swp1 and swp2 need to be bridged, the
rest can be remote, and the traffic generation helper knows that to pump
traffic to ssh://10.1.2.3:eth1, obviously you need to ssh there first.
But the library would need to have helpers for this, and the tests would
need to use them.

At least ethtool counters would cause problems obviously.

