Return-Path: <netdev+bounces-273122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APDQKs1Uymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:47:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A6359A29
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6846330056E9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BD73BD23B;
	Mon, 30 Mar 2026 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hAeJhB3s"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62533BADB5;
	Mon, 30 Mar 2026 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867314; cv=fail; b=XDBxnfPn6ZPZxoiVToxGN219/TaExQ48sTdGMflhhNvjuU70IuqB3gjdwoOlsUC4RE6lPO2dvGI/GqRm86/n/LcLquX5hF7aDyRyFb6TKNAZGDX8aDgp+TVj/cLotKzSToW0ofiF6qRVUZWNcgm/MGrBTjP3BwwjlFgfLHvDFgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867314; c=relaxed/simple;
	bh=bqeThXe217OLY5IA/+mibrhwSvD6JSlHCKSXiSWHw64=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VnONJIrkPkIbNHO7QkWFQPAwV7Q5sm5G99vDSJ4VTgkZsurW6oiutdkZ1WvBcJVdbbrfqTCRmQQY7z3b1uvdlN/so6hRhBuqCfO53P9o98x6g3OETu2JiMQFEiPvG3tEp6i7aXiNCwmWnYrkQIZHw6u1NC+R2/IUxDD2CO2aWrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hAeJhB3s; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2mxVlyCXNsd1lZBQOrsXXU3CduIgT147IuNaF/GvexWXbEQg8UajBWhOGW7Hc+4fqEwM9jPEG6E1r/n3rkWKe9ysCldyP/Ty4TWGCh1QuIX4j6rJV9xF6XjM0WnNWausrFB4Znxc0qxad8np63bK6nAQbnT5RCHdb0LlcHdaBh2I+TK2UX56AHTirPWw6zkYAXv9TYzh9oI3MZnPgrWeC+4amfGNa4+4gIdOEgmbFR3WQ2CatTsAfNmsEOTGWL9yZdyyiMA4QtJhrquEers+167sNKt9VTubt7TkR4Y4vjnHyC0ayeRmbV/wGsdDnyWnnj4SJ9g8vDdkH5aOnYOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfImo6PR/3XuFlnmlnREwcba63+SM1nem2r6PYeFq74=;
 b=ZGcfe8tV2WQ+cQPS0fpCCYg/hr1u3RiFzSmPLWJRkA9vra+fMHFe/3OeX5cqxdMmHYOEW82zqG+kNn6xK8wIBvk7ZR/Q2RIknYWZyExk3ckMs+TKBHj69Ixo+blixQl3j0iGrfQUesR4x53ODkNk0Hzrh3J2zO/yEWe2uzbPQAR4kWr1K4U641TcQHIc72nzcUmddFMmc0yAUHYCqB6EFolb6niCpjf/uYp78s6U9XJz31B2s0yap5Eq07B7A+tki78BgPEEx6hKQWcssK8PcUfAkEGT+VSB5nvFtNas2/9WzVn8gqZWem4PENlaoaZIin2OpzUAqBJ+i8/ljpL7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfImo6PR/3XuFlnmlnREwcba63+SM1nem2r6PYeFq74=;
 b=hAeJhB3sGmLOgZfegHhvAiQNM7Z0p1qtwQqqssB0WhMKY21jYB1vn+ZCMMEkLBwlHZPKwvg04NjmzZitGrzx3Xxm+TQAO2QG+I1xQU0qBtq57cW3mqMEmemENuwzqv8XkDP/O8w8oTsR+3xU06YGL5YYTG54w7hImlc/TemtyYHVYNJRjM3IKhcAaFVZgynN6JaFurP2SfxjbA+0q4RmjV+FoaSaZ7UZsB9sHwFZGnHvCktr4uzpEOtFn6BnBa0skx/6ldWBtUtHmuD7C4Dy98BgpDXQrUcrLFAY3CYWOLwI7r2OoTgEL4UXgZHPStmNm9Oy8OhldqgHiAPPqyJ2NA==
Received: from PH7PR13CA0007.namprd13.prod.outlook.com (2603:10b6:510:174::17)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 10:41:46 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::3e) by PH7PR13CA0007.outlook.office365.com
 (2603:10b6:510:174::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 10:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 10:41:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 03:41:32 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 03:41:27 -0700
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326120342.6429fbdc@kernel.org>
 <5cuoazp2svgjja5h663zc34dafkuqa2grrm7lzpuunvrjogydf@43mryp77gq2q>
 <20260327172454.6b9bc8f3@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Ioana Ciornei <ioana.ciornei@nxp.com>, <netdev@vger.kernel.org>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S.  Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
	<petrm@nvidia.com>, <willemb@google.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4 00/10] selftests: drivers: bash support for
 remote traffic generators
Date: Mon, 30 Mar 2026 12:38:54 +0200
In-Reply-To: <20260327172454.6b9bc8f3@kernel.org>
Message-ID: <87a4vp61m4.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 377a77fe-1022-454d-ab6f-08de8e48f0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wQrziNxkR8oJnflaOYCo3QQOLPUJHD5aZjP4WaGhDBTkoyeKIHhZkjBjgDsDinQbr3n4cgzZou2exZRZNq8UKjASgC+Ks0+fhojPRttaFp5Z0k68zA5tCA8PshDcxAWn3QPd+492+k/AUwHHVrgMvQXKo2LlsFi0eqMGFKaYZVdwnCf6OMn44yOOLX2brErbz5PiIfJqhU5ZqYSea9mi0iPUwFJFky1VXC4M0fBFcVIvsfKEVxsICLR8bn9DT4kNCeo9pvsvMBn9H3+ZW2jST7G/iVUMe1G8FAAF6r3i+HiictpRxcIalz7TIUdNG2GuO6KaB/s6qE6Tuv0qEciw9G9hYJ1EAlm27NY/jAzADBbOl1iCfxToFzV5nydyiW57zlk/5wsnYSaNJe96Botxn0aL81Zgb4Yxn/GdCUfxogpCzVdLRzSfFHLIquG19ORF53jnE02w1apFwhjFgbw4px4jwJ8oOff+uLo+Goy0Nob7wOXINumSbeaS1m+enxb2XXZHx2DLO9j7sXdyBOHZPvVljPayLt3jAOApIzzAdg2hMvgxjo8H9fzTpAQe1DaIaGhdPjHL0+Ue6FYYdI7LgIt+rvd7nVpNrlbr/nQaPYENlcCkj+w6jQvaAa54f39GPVxe990jKgNZ9mkMIi2YBnGSuFTI75xIZGyDlKlK81uyNZztIxk+CoFsBqUvzsjwaNC2IBS/bVqLCOPVoKr1tGPpWUhRMmG4H9GOvVYSjl+7hjgRu4O6wc8feYctXQvmxNf3fmJmICL2HUpVSFA4UQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wCDB6sjZAlpYhDlo9eaAQ441hYmM0voW+tWyljvItqOq9i8Y5vwCRoMQI0uNqnQWRgUyRDaelRnBrHRGL2GAkqoWJ0PpKy413j/mJs1E2ovkaY2y+d4HAPHQZNaFVa6c5Y1kWEboD0dHU9RqbfeMvTvRJs2xdDxvTdARaEDBU2qLbzHwh10r202wvcQCzEWCVF9eFrhVFuiH2ibH6YqvM2cF7OuZtz5LBfnQhEtFOWhram9XB1+H7D8UQ+UBC2GrEXwqOOszmRdlA2N2noyAn2enBH7nCXHi7U+3ux4OyTKOyt/sCuhh4RqXx+J+yWYHN5Tujh10ICEvaKXAPHxg+aZhkcSckgjWZaqpWmwAEB1532S5nnPGfPWiXrWHGZPkwvEDbQlHSJZskav/i4z0H56Mo8NclyTky/SaMukhCwlVYb6qtxfgGX74vnKuPN/l
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 10:41:46.0853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 377a77fe-1022-454d-ab6f-08de8e48f0d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724
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
	TAGGED_FROM(0.00)[bounces-273122-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,local_termination.sh:url,linux.dev:url];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 044A6359A29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 27 Mar 2026 09:32:22 +0200 Ioana Ciornei wrote:
>> On Thu, Mar 26, 2026 at 12:03:42PM -0700, Jakub Kicinski wrote:
>> > On Thu, 26 Mar 2026 15:28:18 +0200 Ioana Ciornei wrote:  
>> > > This patch set aims to add the necessary support so that bash written
>> > > selftests are also able to easily run with a remote traffic generator
>> > > system, either be it in another netns or one accessible through ssh.
>> > > 
>> > > This patch set is a result of the discussion from v1:
>> > > https://lore.kernel.org/all/20260303084330.340b6459@kernel.org/
>> > > Even though the python infrastructure is already established, some
>> > > things are easier in bash and it would be a shame to leave behind the
>> > > bash tests that we already have.  
>> > 
>> > I think this introduces a bunch of regressions, eg:
>> > 
>> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/575622/4-local-termination-sh/stdout
>> > 
>> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/netdevsim/results/575802/18-netcons-resume-sh/stdout  
>> 
>> I cannot reproduce this unfortunately. For example, local_termination.sh
>> gives me the following result with the exact patches that I submitted.
>> Any idea on what might be the difference?
>
> Hm, the system that runs this on our end is:
>
> # cat /etc/redhat-release 
> Fedora release 43 (Forty Three)
>
> And it has this added on top of default install:
>
> # cat /etc/systemd/network/99-default.link
> [Match]
> OriginalName=*
>
> [Link]
> NamePolicy=keep kernel database onboard slot path
> AlternativeNamesPolicy=database onboard slot path mac
> MACAddressPolicy=none

The observed issues are consistent with TARGETS being defined, but not
an array:

$ declare -A T
$ T=([a.100]=b)
$ U=foo
$ if declare -p T &>/dev/null; then echo "${T[a.100]}"; else echo fail; fi
b
$ if declare -p U &>/dev/null; then echo "${U[a.100]}"; else echo fail; fi
bash: a.100: syntax error: invalid arithmetic operator (error token is ".100")

