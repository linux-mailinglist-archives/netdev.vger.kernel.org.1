Return-Path: <netdev+bounces-273600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GIZHfu3y2kpKAYAu9opvQ
	(envelope-from <netdev+bounces-273600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:03:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B5F369414
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B693E300903E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2F43DE427;
	Tue, 31 Mar 2026 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PZL9Kl/X"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133F3D8902;
	Tue, 31 Mar 2026 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958379; cv=fail; b=Z4B8VmW6fKVlNp4VfdAPoFC9ayVB9ffXwq/7CuLt9t5CX82iIrq30zU4eXRVSgoPQfIiGi1JWxfD7jBJRTR3fFIBMD8IgawbKIg9Ql7TWUV4wNQrMwSVDyAQvV6Mhxf//yZqGj4JWKrRdJ/Ao0aEV4/gDZcEcSh75rW5zHo+zog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958379; c=relaxed/simple;
	bh=6fNvyL3pD5FuquhpWD0dnlt8JOaUqQUzVRe1ajgAR1w=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=i08mFJyeTqg5P+st5TD5ujI1FGKWZUzZpLE21ymykLKZeOMNtb+6L7KVffB/nQeypN2KfkiCg0khovREf7OdCpD3atwmRMVyadb0BGeFJDego6FYsDaq3yf+jCcUgeTT/mF7fs+PfcaDARF0mKxBWoSEU23bGjAdi/VzcOO86Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PZL9Kl/X; arc=fail smtp.client-ip=40.107.200.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwzaNITvQgJli/MQT2Nq1XC4edvukVPMjQM5NI04Tw6l6B3ITiuuILo8cJ6bEWhl+icj/OU6KZ0ovbLCq+dL5mEK3qWN+flNilxSxyBPorLffGatpwijWUX5iEpDJ2HgGIm9gSUapMcs2LcIui2aK6+RHv4aQ+WGvpDAj1aOE83CjgI1BUoYboGH6hIayIvaxYkSKz0EZfSktAnNCNd5Ve/TQWNVZj9Xd2QAlBGLGElGoOJ/TjWU/34GAFXhNBy0b9mBd6uDfT2cJ00GdU30TJ3r9JrF9iA3NGmx83Ic3mDMAlrh4Io8qWi87kNqHxMarfJrpYOZd4q2EwyFbCkinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+cedi+rZgDXST9mJWtXk3xbLFMCRAgxOxGluRXEuWE=;
 b=YVxjGYYSPpI8UIp42CSXO/ErkoqqSXsf4sYMBLuDTnOd45EFT0WGD1tOSrHHgqeeqE2iTqT0YhtRf8G5fLwZ0Bbq3Udfs4WRC7u1LvvZIuXFux9HTAAWxaF2h966IKQuoIfYP+vNjSN8ZuGkU/OqgJiT6qXbgYbx+uWQmfGEdXy+u/0wdYpSjWAHlCSWrKgcN45pv/t+thLwUKMRNm0lOQN36AfHfmJORz7r95viAytzXZo+E/KDFtvapVvXG2+hCDmdJ+aO6smmEzIuDvYD1czP0Q8tUQrqQxVTpzWgDR81U3vIy05tEsXaeU53dT7Uj7IOPCDQ+/8jfx2Mm6o2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+cedi+rZgDXST9mJWtXk3xbLFMCRAgxOxGluRXEuWE=;
 b=PZL9Kl/XuDPzXuZTSfn4qLs9mljn2eFyiblqN0PWSAVoz4jSJLgd//N3vTuj4o2b0LB9v8Mb7pewRYPIAmQDt30ZGa8Jg//dOGL3rqHNV+kRh1ra8DZJeXKLzlQQ00vCSgVa49Vz5Gct+v11nF55K45OsIs+Cq/YKI95h7a7daY7fRWHjWKJ09pXXps8NqrGMUS2HXfJqLJfqhEFZhSjnwfDh4wOtbShNDriPcR5xfpYCMQ7nBA4gZMFoUAE5Q+DRy7o7TyxDhCDV2GnCUZpSqBEuI9+Vuhb0Mse9C03eB9N1chyO/6EVZrXbGen3pQvsJeY3mSeyEmVxgbzvZbcgw==
Received: from PH7P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::17)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 11:59:32 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::93) by PH7P221CA0045.outlook.office365.com
 (2603:10b6:510:33c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 11:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 11:59:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 04:59:12 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 04:59:06 -0700
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326132828.805703-3-ioana.ciornei@nxp.com>
 <871ph15zip.fsf@nvidia.com> <20260330170439.35ef3cac@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	<netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <willemb@google.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4 02/10] selftests: net: add helpers for
 running a command on other targets
Date: Tue, 31 Mar 2026 13:53:52 +0200
In-Reply-To: <20260330170439.35ef3cac@kernel.org>
Message-ID: <87se9g2os9.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: eabf478d-76bc-474f-35f2-08de8f1cf814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1wjbpIkQSUK7FwWjvrjDO8yntiFvJN/cKgz5we4XxyEk7OYlNZVRdcVeEBndeqhAgU2pbG6+FQyZ9igqN2kgMa/K9loL3OLJgRGV9N3KfBysNablP4yUtDn30Fq08w2UtJj2MnIqJMX/LCGQVby0lCwj7t3KQs9HizAnj5LzRf1VcsQlQhBngkw7mV3IJ4XpFXbZk7m0uVozsMdcTUgSacs9SgQKo7iZdQ3rVDTYGFEePt81bZLw9TrOBqKk2rgYnfnEswIj34ceOzrce+KCeF7Nkii77nI4t75mXy2ekAJSONLC6AbPeWeO8KXmQ/9th8w6J8uY6sgqu+6X/1u3UcBpDabOfHb486ycUfg/kcGlFmTabFpet5z0zsOxQQS5cTa827KHL3ac3KSatVP0bQivTMsTk2PGf8qWCtHkAQ7nC60xOoOUneySZMnUXQap7S9zV/KO1rZW+uPmsQKaDkA8DD+g5XI0sgVcLtFoZGt2mqUfj+esNrgKCFulI7jkDSGhdk6ryi3ehn6sy1B7ZFUkq+C+MKpAuWj+PV7dQiyJ8OZBpJTqpnBvRbxdrOgJrG08oBPuap6ITbADE52g3gQ+qLZVIYIANJGCADZtaoOt4tRyKIMrG3m6bPvBTwB+6ocWOTlvYM8Rmca5CStRO+APJ3AIOihW05lS/BNDXXtXIe/EfYPEJJjHDYizsJSUaVpSi6il7gqJrmfOWNEthj1eJYTXybig+1945OMpXNicXxLiL1HIUmOialtuZYAWit5qTNC3N3MMudqXQBDt1Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FTS0C57tPZrfff62niGLGD0jVdc6zu3sLzanU6oW2Z3262Yoiu9matBTUL2wumpXyaVGGqq+COU/bP4SetCA8RSgctJrmg6lDqeTa2pKgMEmtWeaMMiFJW1Jsfj2K9j1W/EiGf2Fxkjzq4Te6EsPITh471lvrF/WhsDAljKsPH5v6Ple/1/pCpH0KmzgZX65mmR8dHXqmXuJjYbMU3TG3ImiNP+M8C8XkY5BcSxQDPzfcQ30goork22SiJT0T1g1Byr058tpEZXXmPXhKtzjBfWgP9pVezGNBBaOz/s+fY5GmA2csQszlglKLrkcOfcwG+109TPKSWjboKV+icTr/PP3BVT8lVHSLTXiJATAD9LbvbZh5ngiYkGUnel5htN6OIY5VCxLJjAmz2Nw30VnoGdFROv5a1MUWUROi9AhDPX93i0fpaWWBzK+0fZuCRiQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:59:31.5819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eabf478d-76bc-474f-35f2-08de8f1cf814
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273600-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foo.mk:url,Nvidia.com:dkim,nvidia.com:mid,x.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E0B5F369414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 30 Mar 2026 13:02:12 +0200 Petr Machata wrote:
>> > +run_on()
>> > +{
>> > +	local iface=$1; shift
>> > +	local target="local:"
>> > +
>> > +	if declare -p TARGETS &>/dev/null; then
>> > +		target="${TARGETS[$iface]}"  
>> 
>> So I think Jakub's runs fail because there's a shell export somewhere
>> that gets inherited through make to the launched test. I guess it would
>> be enough for the test to validate that TARGETS is an array, because
>> those don't get inherited.
>
> Great catch, FWIW. Yes TARGETS is what ksft makefiles use to define
> the group of tests. We do 
>
>   make ... TARGETS=drivers/net ... run_tests

That'll do it. I thought the make command line-defined variables don't
get inherited, which is why I said shell exports, but indeed they do:

$ cat foo.mk
all:
	echo TARGETS=$(TARGETS)
	bash x.sh

$ cat x.sh
echo $TARGETS

$ make TARGETS=TARGETS -f foo.mk
echo TARGETS=TARGETS
TARGETS=TARGETS
bash x.sh
TARGETS

