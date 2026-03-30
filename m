Return-Path: <netdev+bounces-273244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB+ULUGWymkR+QUAu9opvQ
	(envelope-from <netdev+bounces-273244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:26:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDB635DCE1
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31475306DEFA
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F08033CE86;
	Mon, 30 Mar 2026 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PBMRZk1n"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159933A6E1;
	Mon, 30 Mar 2026 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883670; cv=fail; b=T0CmJz96GCA0ZrTq8X7LJBH179rzZ6Xl37q8G6rDEJIpLjNJ4kauI1AKhiIPgQ9Q/7sIG8YBuRx4Zwrs3oNW833fLXDjMT6zwnVJCndJP5LrBfvox7zJpb7Fl42sJXHGlNLpcUPaUcq+AWH2F/j0kWxxuOByn4iyL8fUt2sr9RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883670; c=relaxed/simple;
	bh=nw2xqc9GcPmCEiCPDgTbdw8QY8lZbUcqO5Rr4z5U9NU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=unfwS9n2vfOCK4NTu5myyKWPwY665J2WkUGyrIXjCxHdWldEDsgaSSEWTJtjSfJWu9jjfhhFwoHt/WmWTfflJg6gNa65X4LVyZ7F1MqOD4oTokeKEmYmj14SX3m+tN2vnhOM6433BHQSixoc5dtKJvms3Vi7ZRTp5FgfvMRdiTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PBMRZk1n; arc=fail smtp.client-ip=52.101.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHogezfAvuqkEsFAaSO55Uwoc/yMoHgLUjMUwfwH2uNZKmkKTZMlUNyrdLYqAj24pO3JGk7cDSo9nxqjpCyQyP48yOUfn+P9EADuRfW7ey9GVZNQNafY5yIAnmfs1+EmD49rXyA7vBTZS5zd0g5frSrnm5PN6qpJ9GFbShxZQl+lypTmUXstzymgZsJI28V+thb6M6sAgTbbGupx5PuTXs93dwykvukzAQBrfysskecTf+9RyVpQqYFVZTX0WytyPBe1ImW17P7vLjKDX8v6nSrX0nk2vkWIbJ7YMDbdVgEelrdwkHNVAWWZVhV4c0ko6l6I5U3amoh4bh1CnPiEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/u+gt8du4GreDjwn78BLz+bE4uGIkPlZPySJjINpvQ=;
 b=CJslTwTvJcH05OH8aIAkHUoopaeRtMLSb621jqBoYGA9aLpDbq0CU8XQEpaL/yx9BBewa6qTfA1V6VrIGM74uVtd8DOzEObrDDF74Y673tSHxu9f2wDXoAW180L9eVkPtbG6pQ99fkmjLAgGdC2UKdaNdmu8WdQA0STy0zdNGFK20bUJGbjDlnC0jUQ31bpqmVgiJpYCKrdi67FtJMbCEtMqJ+DTaqkthBx6f1BxNuWr0TF9pAVz9sOBVJxoKXKEt0M1YlMEMHG8BAShBbpJG1yunki2dokQiLkWt2jZEwzZkElZ5PB4CQ9xbUzO/gY9Go733t9kCLcOVEtN4NtsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/u+gt8du4GreDjwn78BLz+bE4uGIkPlZPySJjINpvQ=;
 b=PBMRZk1nBYxHjg59Gcxhd8vFu75QU6nLolhyge6EQ0/857SuCfcRur3BaqoEZMj0f8/0VsT+1UF4TrAJaFYGvMppVto678jtbB8SlSH2sBqyWq9MJFsm6DFenzT+oSRzqcc/R/oDe4HAbAxxl2HSTKsczf46oP3E1qhOBts9gQnvmIb9y0DJa4ja9i3r7KYvM9VXA05aZ1na2PPIP64Ehb+SoX3Tclxg5jzmvto4eCWIFlK7N0nwCrfHyrvP82Eb1XTZGUJS/Xr90GJoRUrFffAS87z6D+iQ0a9PRsEoCCvy9uF3j0ioGbD5HG1vhk56CxS5p2V9TS44M2dZ3RVCVw==
Received: from PH2PEPF00003855.namprd17.prod.outlook.com (2603:10b6:518:1::75)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 15:14:21 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2a01:111:f403:c936::) by PH2PEPF00003855.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 15:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 15:14:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 08:13:58 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 08:13:52 -0700
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326132828.805703-3-ioana.ciornei@nxp.com>
 <871ph15zip.fsf@nvidia.com> <87se9h4juh.fsf@nvidia.com>
 <mmr6xs4soark6ilc2xymgcvn3wij2yoaeokpuv5i62mxtddvpa@jdyswkdydpon>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S.   Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <willemb@google.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4 02/10] selftests: net: add helpers for
 running a command on other targets
Date: Mon, 30 Mar 2026 16:55:52 +0200
In-Reply-To: <mmr6xs4soark6ilc2xymgcvn3wij2yoaeokpuv5i62mxtddvpa@jdyswkdydpon>
Message-ID: <877bqt4afo.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d12526e-51f7-4f05-f4e9-08de8e6f04b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yF7PqJKapShPl3Zjkgu1X0EP6iuv/mdC4HUxazePNHimMiKtN5Kfewbicx+h3Fodj61HqUwsVtEjXsaeEsVRKFz/oO9KX0+ZUc1Cklm6vNxGY7qf/IT5T1MD3xVHEEV+GyYifTYUUjqyg6sfLyzTLd963QULwXfTMDBjYHGShvNdiA/fTYwPgwjRxW8gJPtyKoqBSxFRAlKO3C+TNfVFg94e0KgB/rXXbPR/YesafaF6W02YBtoc6GSIX8Ozgx515T/T6U4C49V3ut0MGoS/K+R1y8OjeZXr6skmZbKe5u9o11hDXKOeeOhl5HQhYeTB9EdX7NNUU0R7//YneKokN31zxHV6vJDe8y3EQGdul98G17Fm+tGZs6ulRRaS9bcaLPg/prhyXF9cRptQ9m9lzbrUVuv3tASdVxYWgjzlEFzB6qXVH80cDMvH3ngDC7wqDO0re0neJFeWRpq/WYZylxSfq5sEA3sO7Ol9ecwW1ijUCyHW4eXdGdR1VqECqtdb9OJExaEm08eL+DUeP7jQYQO1hWoSMRnBpA7uaWMy77TIDR9LDytM7Zk0rmNd/KyzYbBHradTRa95yGkJ2h6UnqPFHcn2ehprhjm+TLIz1gjuxzPsttP9PZqDNPR+0wq9nz8HEx1wlazVdyBDGACczNPky34ts3yNhrm+iBqpj76Ns1qZndCZOuf05vqVd9QEK0QaXUlLnCmFg2XD+KQ7wFnsW0Vs+YmzsRuKDy6+xGM4LeCxyausbSmzlh1gSVPbjjfdTe0G9nInFgHw+XB8iQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FO4vk40hvjF3v9/TtW+fasvJ7cW3HrCEIIQ0CYQvF9wEsLVufaxnGbRgFI4idVGBaYGnGXDkVi3od9gIMIBWgVhIqzri5iLjRIIabYsYigmOhdpXGWUKx7Z0i5r2JvYGifioobPDsMNO6ujFGOcAI/f9+nvVxRPb+3U7gBos2Ntj343P+K2/scGpki8OVGSTxbCPfEEoc/lb9SBCnIQXHU9tIFfJIi1ZdQd1/nL8j5JDfrsuuLT8EA2nGjHuvS1J0I2UlAUyfbGa5o8IQo/6moVO8fYCijWPGvfI6NefEirmjxWgmQTBm5dt+DApGXwG6dFtyBIoqm/pBdT+2yortzYWF8n+6/ZfQFhf416qamU+I7jVJAJ1kiZqe7CNDA3oMNaDbvX1SKKgLBmEAdWVQLD1RuxT8x9Hu/KVKYJplbtCl69KUe7h5DewX5/M+XYA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:14:20.3874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d12526e-51f7-4f05-f4e9-08de8e6f04b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273244-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,lib.sh:url,nvidia.com:email,nvidia.com:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2DDB635DCE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> On Mon, Mar 30, 2026 at 01:32:41PM +0200, Petr Machata wrote:
>> 
>> Petr Machata <petrm@nvidia.com> writes:
>> 
>> > Ioana Ciornei <ioana.ciornei@nxp.com> writes:
>> >
>> >> +run_on()
>> >> +{
>> >> +	local iface=$1; shift
>> >> +	local target="local:"
>> >> +
>> >> +	if declare -p TARGETS &>/dev/null; then
>> >> +		target="${TARGETS[$iface]}"
>> >
>> > So I think Jakub's runs fail because there's a shell export somewhere
>> > that gets inherited through make to the launched test. I guess it would
>> > be enough for the test to validate that TARGETS is an array, because
>> > those don't get inherited.
>> >
>> > Is there a reason not to reuse DRIVER_TEST_CONFORMANT as a tell though?
>> >
>> >> +	fi
>> >> +
>> >> +	__run_on "$target" "$@"
>> >> +}
>> >
>> > Does the latter helper need to be in net/lib.sh? Since it uses TARGETS,
>> > which are a forwarding/lib.sh concept, it seems misplaced there.
>> 
>> Oh, I see, there's an invocation from mac_get() in net/lib.sh itself.
>> Hummm. Not sure how to tackle this.
>> 
>> I think lib.sh might unset TARGETS explicitly? Or declare -A, but leave
>> empty? Since it's now an API, net/lib.sh needs to set it to a reasonable
>> value (or erase). Then forwarding/lib.sh might in theory rely on
>> existence of that variable and not have to declare it at all.
>> 
>> Or, maybe have a stub run_on() like this to satisfy the run_on() API:
>> 
>> run_on()
>> {
>> 	"$@"
>
>          shift; "$@"

Indeed!

>> }
>> 
>> And have the full-blown thing in forward/lib.sh. All the magic with
>> TARGETS really belongs to forwarding/lib.sh. Bash allows function
>> redefinition just fine, so a user importing just net/lib.sh would get
>> the stub, and forwarding/lib.sh users would get the full thing.
>
> I really like the idea of the stub run_on() in net/lib.sh. This would
> also give me the possibility to check for DRIVER_TEST_CONFORMANT = "yes"
> in the full-blown run_on() without having to move its default
> definition in net/lib.sh.
>
> I quickly changed to this approach and it seems to look good.

Yeah, I like it best as well.

Then I think you don't need to worry about the TARGETS export, because
forwarding/lib.sh will add the "array-ness" to whatever comes from the
outside, if anything, and the function will be able to use like that.

