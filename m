Return-Path: <netdev+bounces-273132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFNnMOpdymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:26:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73F35A387
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67482303ABF1
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20BF3C5542;
	Mon, 30 Mar 2026 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ywy44PIs"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CB3C457B;
	Mon, 30 Mar 2026 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869216; cv=fail; b=SPJIzVTKciXMxZDuZxAzbokcYV7fWNznDVJh0bFzuHDQw2HyjhrR4OXk+j2ELCFs/a4g7UJewyne0Y3Y75JElI//afTONhpHsjbiC9maOaJOiJmBqE/wiQDGJwkAL0pLMpmtCtT4+dFVpmsct78Ou286bQIVbTVb46r/ANjf8EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869216; c=relaxed/simple;
	bh=8VQRONw65fzhk2o5sbfMsYzEtHgWiH5xifk9s4JxYwk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lFL1ylFkjvJ+uyBaXu3DrjvxGUwTv4vatzrPp/qgtKpZn2JQH+LZllXgmYtNl7aAoM1e787wdM3yiyZLkzwbJNmNeYtXwHrNhYI41EF4Gi6454d5w6SjIG6Dfry5C4zPjoxDWsjEOO9ryMcf9ludv0nzf/yw3Mej5PIbq/y6E5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ywy44PIs; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMxHxZM8fKVzsiMX26R7yvEQ22lpjI68DuSpHuQbmGnysGykLJAvCQxUrUYizscnLCi8qFrB5RtL+jM/FEgjTvdXDGfRVN5E3xzKUqe2PtUzPmW6pJA73u+0AOKnjf9vFSSnxhmZo8IpehRtev1U0OIZigaWujMcBAJ3nMLNWh2jEdvyjUw1luf/nN66VrBj70RORdIBCHoH57e8rXHgEZBw9Gv6NEWdwz0SsIMQrSw0BWaljAogx5tjIpjqMbhD8lGRUCrZW36TkRJRAmTkkTaUbxW3nAVsForgpEiXFeFzhS5nm+LbYjinGWRoGlyoUq0XFhN5uvhFjWnx3Sk23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMAn1QimSe+Mdm6Y5C7PqJVtXlx5F/zKAkFfKRAPyFc=;
 b=XMV8J8WRDamtUbqgkfcYEr1/IX9hAOaLFOTlwaVmkXtKvrns7zEYlJeiTMjoiBbsO8CB9MGfh2osN6yemkMSQCQ2qmVLCvW3Gfw8qBwYi763Syl4qk9ZsLsN1SG2f4WhDixzwgCOaRNvucHIpSNM5iLzjQVPDigV9+ZmuAamW+XGsK7KHXa5yDfEA9K0DdpxYCUDS4Y7h3iV8iiKRZd3+DP2k/0FABCA+k1dSTtb7cLszZnJXvZcYkJbDLAZzoeUGKKhd102F0GU8sv6oYrvQhwOtQC90Sn2A//wJ6YQy/x/e+574k6riohsuKRUgN56U4Bbrctl/cpNU+SAt26/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMAn1QimSe+Mdm6Y5C7PqJVtXlx5F/zKAkFfKRAPyFc=;
 b=Ywy44PIsl2TBKTKIHF6IpeNJxcFuxGAQ4dgQ/DUkHuUO1r27hdeiLga/+0vgygqY3NpUNnol+D7JfuZgl91KcZendQ3kL9W3jBHxJUQxjymINbvLSKRxcpG9ug/8U5zqKLaPTooCpxYUiJWrDApkuNhwtO7dMyi9krsNW1NzrMp+LtVahQSjPpnhSm7CBf82MBDwVu7tG1A795MUigo99mxdw52oR/YrF1bIzzGyRHRd0d+IXC/n1O2ovrLbCYWEmZFVKGE9BgLBpUX7TGSnSAJxoH/Ahi1RSbFjW/TFoNvym8rKcBgZzWwEMMDPyFLSLAMHy8rZMT3b1L5rLArYfw==
Received: from MN2PR19CA0001.namprd19.prod.outlook.com (2603:10b6:208:178::14)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 11:13:28 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:178:cafe::f0) by MN2PR19CA0001.outlook.office365.com
 (2603:10b6:208:178::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 11:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Mon, 30 Mar 2026 11:13:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:13:10 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:13:03 -0700
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326120342.6429fbdc@kernel.org>
 <5cuoazp2svgjja5h663zc34dafkuqa2grrm7lzpuunvrjogydf@43mryp77gq2q>
 <20260327172454.6b9bc8f3@kernel.org> <87a4vp61m4.fsf@nvidia.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	<netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
  Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <willemb@google.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4 00/10] selftests: drivers: bash support for
 remote traffic generators
Date: Mon, 30 Mar 2026 13:10:22 +0200
In-Reply-To: <87a4vp61m4.fsf@nvidia.com>
Message-ID: <875x6d605h.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa87b9d-123a-4ca0-9332-08de8e4d5e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oy7BuTbku8Ln4NIidn6CJPfuFzjaFWkPtY7BOXxjXyEW6lMmNWL14K2nhwlrdjptD7kqdV5Cy22DS9tI50uaFt8KbQOHhxuyUFXh06RL3d5BDwUSwsxT+k3ZEnN+RU0rD8OIoAWivnbCsiEXCxhMjLYND6EMKlpobIhogPY20x+QIotrWRW+OxU1vJU9Rwb8MravI4nt7auiATGHjUIWhuX96Kc5ln3lxdvlkSeU9us18DN9e3YHjwi8EGKnkQPWEDT7Cca+cYnAuOxuS5YTpg274UJ6HBKpz+0wqhGxtQiZGTqKFhg4mxfkPgR6xQ0XtCKicXz9WEbcCYG60DVapLZHn88YaddP/tVl10rB99uY+eHaIf1hz7gNUmoOufu6tY9JbZavc+U17xURo18KDmTIH/ILORiO9n/BZRcYf/oS5GgYov8J4JB9cWqUe4RzECzeKDEj30j9JcJOR3ojHwnvlbAepS32cDYIWfqrfaRY2P1mmfXt92HPiV4zT3EyTxpUoIWBwepV+8OQSuZKyntvb33rCGpSRXcPx0kvcYBmpu9SJQYWtFBGp7QCY57xLihRxvX3bgOXInWtV96uAr1w24SEVaHe+X3Uqh37fV3jyDfl9Nlky3CA58ApSRNktOKfRb/ZiAnVcQ2M4tdtkFkVi+nm0oSgzfhgwb4IxFluW/XiT1sBPOK2Rqh14NHF6kxqjAwR/FRjIlcd4zQ64rJUbUdheLWNGBLeN8SF7EmlNBiFsSGIQExkEkyjv4O5ZZ6gjrneRxCylokculsnlA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5e5a3Fzc0RYRPYNaEVlU9D5sgDy8vCHkEWaHR0kVgadAs4oSyjMkzTzQWeUsq3qTqstR2bPE6yhKEI7aEwOyq6ehy0UvsTnkYwVBMsjYd2O+uTdoJ3vc0S5neTE7pZHWYlhiuUhZNR8XRkaVpLFm3t2gIRXpGEgc30GTYn+uTSr5K2j4N9x5bYcUsJqzOuaNuB+qpQVlhWZ2J4fmjUM+uyuUj+3fnZ+gDX7p4640u/SMZUW04oqIDCZs3f+HQUS/ftTVOhiYQZtzrsjuiNoNAPtpuUd4Zs4cai9LJPTm97uNrYaFbL/zsP+5Dq5xGDO3BIfsHXgTDrx64KXKE5VKMSc0rkqnKoxHi58ghvV3SHhmOY0fL/x5KSCjCpLHFZKrcz6u/gaSb02+4sCybRoQd5hzJzjyrEPipoDQAdgGe+rf62OkOUu920wORf91NzGd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:13:27.9283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa87b9d-123a-4ca0-9332-08de8e4d5e70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273132-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,local_termination.sh:url];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CC73F35A387
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Petr Machata <petrm@nvidia.com> writes:

> Jakub Kicinski <kuba@kernel.org> writes:
>
>> On Fri, 27 Mar 2026 09:32:22 +0200 Ioana Ciornei wrote:
>>> On Thu, Mar 26, 2026 at 12:03:42PM -0700, Jakub Kicinski wrote:
>>> > On Thu, 26 Mar 2026 15:28:18 +0200 Ioana Ciornei wrote:  
>>> > > This patch set aims to add the necessary support so that bash written
>>> > > selftests are also able to easily run with a remote traffic generator
>>> > > system, either be it in another netns or one accessible through ssh.
>>> > > 
>>> > > This patch set is a result of the discussion from v1:
>>> > > https://lore.kernel.org/all/20260303084330.340b6459@kernel.org/
>>> > > Even though the python infrastructure is already established, some
>>> > > things are easier in bash and it would be a shame to leave behind the
>>> > > bash tests that we already have.  
>>> > 
>>> > I think this introduces a bunch of regressions, eg:
>>> > 
>>> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/575622/4-local-termination-sh/stdout
>>> > 
>>> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/netdevsim/results/575802/18-netcons-resume-sh/stdout  
>>> 
>>> I cannot reproduce this unfortunately. For example, local_termination.sh
>>> gives me the following result with the exact patches that I submitted.
>>> Any idea on what might be the difference?
>>
>> Hm, the system that runs this on our end is:
>>
>> # cat /etc/redhat-release 
>> Fedora release 43 (Forty Three)
>>
>> And it has this added on top of default install:
>>
>> # cat /etc/systemd/network/99-default.link
>> [Match]
>> OriginalName=*
>>
>> [Link]
>> NamePolicy=keep kernel database onboard slot path
>> AlternativeNamesPolicy=database onboard slot path mac
>> MACAddressPolicy=none
>
> The observed issues are consistent with TARGETS being defined, but not
> an array:
>
> $ declare -A T
> $ T=([a.100]=b)
> $ U=foo
> $ if declare -p T &>/dev/null; then echo "${T[a.100]}"; else echo fail; fi
> b
> $ if declare -p U &>/dev/null; then echo "${U[a.100]}"; else echo fail; fi
> bash: a.100: syntax error: invalid arithmetic operator (error token is ".100")

I'm wondering if there is a shell export of the variable for make to use
for build process, and then it gets inherited by tests launched from
make as well.

Whatever the cause, the test will have to be more careful in how it uses
the variable.

