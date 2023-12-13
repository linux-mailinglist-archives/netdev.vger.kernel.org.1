Return-Path: <netdev+bounces-56826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32153810F38
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17331F211E5
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E260D22F0E;
	Wed, 13 Dec 2023 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JRCgCAnz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C4E101
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 03:01:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLWMgdeH3ZQRQrYHnSQm106QKYMUymR0kRUEiSzQsrdNgLXG66MjGKZZTfzY6JGMW7xM0nsTl/MAcu2wxcYMhh29nsH+k2LOBYBniiSYf5BoH5cYTYrRVoe0Wq+ge83Yqa5vJScCEE8aKrcumNoHMzUrz8vGsu4PfvPpGNfn95LAnFtprif1zcfS249Qbemf0fLVqRIsMKlxv2idIBceeHm9MOWNpcR+DqWEgyQFmQhbpGkPoCZxBCRkd/IhrJP6DIvhj0OXTSPbhhRq4MtBHX/S5xRYAFk/3aMvlP1gyRnIOIso0J973c3D8N2WTgtgaShk6E5VlZIYwlOJm1Fqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4PJzffA3P48CTLdQece9ZVVLOv01AZrxrO7WUAzyQI=;
 b=IcnvyEffsR7weA6gG4yhZJnG6XE7lU9bLfG4bU0Fg/hmdRmYAEr0ZU5eswYI4iN5W/A+eEd7FBTjN46EzSLkVKo74HwkHMUY+KBP+IMgKgG0++wUIyVSWIUcA5II55uYtNHpAG/URderZ78ppHnogaJkWCJQD0dQnS5T/QhX1ZST3+cj+sM+hXovT6AMiUr99bRQK+ODK/8ctOlKdR2/0osOrluMIdvBaAqgdpo0jMEmWqbdit+mMFIgNPo0mhp9ImrgNDS6w8a3lh0dBDuT9sUYUamhQFN2IePA59EH0w0gbIdi24wtW7nWFhmnRKeIAruBaMpUe8UuYUD+TjiSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4PJzffA3P48CTLdQece9ZVVLOv01AZrxrO7WUAzyQI=;
 b=JRCgCAnzT76aA98LX6XqhIYxCNJHDKeTIy2RUi7rYAWh4AYOZjQWsZR8sfQV9xX9GHncZNYN3iwsghnYcqykNNab6LqLKSLxOCHPFPhm+mXR7LZYkkKbfbq1Z5AAE8VY5w5sUYz1kWfkZGm0rtA16tVZ5WI+pUUJBCf7RyvAoaMkkoLc5nZhyoQGIc+iuv6obNFWr5EHJmiUNm1NMuhFoyJMhtxGe5lIMrvNsGHicitBHOHX3OKi0D5AZdvSTKLZE70sVsofqQIgYPaJ8xajQF2VuJ3kE52EpONFH6e7g3KQO7tNTRsvPZG/PDBn3KVVrd0ttXDjiyMlCSVqmXHvwg==
Received: from SN7PR04CA0085.namprd04.prod.outlook.com (2603:10b6:806:121::30)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 11:01:21 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:121:cafe::39) by SN7PR04CA0085.outlook.office365.com
 (2603:10b6:806:121::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 11:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 11:01:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Dec
 2023 03:01:07 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Dec
 2023 03:01:04 -0800
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1> <87fs07mi0w.fsf@nvidia.com>
 <ZXi_veDs_NMDsFrD@d3> <877climn45.fsf@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <me@pmachata.org>
CC: Benjamin Poirier <benjamin.poirier@gmail.com>, Petr Machata
	<petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	Shuah Khan <shuah@kernel.org>, <mlxsw@nvidia.com>, Jonathan Toppins
	<jtoppins@redhat.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Date: Wed, 13 Dec 2023 11:31:50 +0100
In-Reply-To: <877climn45.fsf@nvidia.com>
Message-ID: <87y1dyl635.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 752ef38a-a5bd-439e-d044-08dbfbcad6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wG1u9g8itA7KakGnXH/FmMxOAk7vjn7QwweXz6KwScSjBQusefqaLTanksS0oMlZS4KuOixA8l9hIDX9LT4FCdq5K22yIUf0em2BruDyVM2wmqFjfhkI4snWDMRnaUtS4rsw7OONge8vwf4FOA6UOIWxjnO0/+RDsDngAWTeuyYBCUyrWV5TbOv85P49J1DqjK9xjFJ4Sqm9g3ZWozIPu4M4Ri7u6NK/sllVjULv6QGwZ88X676hftMWhSIIpu4s0k/PXQEslD8A/PJeFZhRIZFvBzsZXruXWYoDRJZSwtIolfFwwf0/mNitw3DXc4RDPLb9NUihQlQyyBh62HJT5sEKgUHVJAI8VseIbat8NRWSANYTDcDOTU2o5BAu29Vlr6q91hxy8uzm3au9uErhugGpRqHE4XkGwM8hMRSji9+lU3iSmRcp4LoOKbdNlACrnCEPOHEcHwORo+qLHj8tKBzJhjjER4jRskvmgf7k7vbquVNuB9r0DCcSwAE2jt8aSMsF22KuLicYUVixFw5YlEljP6GYyletdfSN54gvHu5ygtssMAuTyfWDQ53ZJDFXta+s4rT4dSk5jOO/804VT+uWKvS8sdgoDTMXeCI0DvUYXcQaHE13zBRm60O9n4CxJdcRnkHF+5PhDfRqUu9x9DcJm8PiFw0DgNz5e5m7uDydX8OIpCYBYKbq8pIi2XAbRTRBlBnu3aKXSYvWaTifzrdzlYqCkCA6OvzFUOXgFulrltCMAFsgkOrZbpDIofJ/xQllS23/p6btSbT5jJQN2/mvArPPJurDNjKlUyuEfZI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(7636003)(53546011)(478600001)(47076005)(16526019)(6666004)(2616005)(26005)(966005)(336012)(36860700001)(7416002)(4326008)(4001150100001)(5660300002)(70586007)(2906002)(426003)(8676002)(54906003)(70206006)(6916009)(41300700001)(316002)(8936002)(82740400003)(86362001)(356005)(36756003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 11:01:20.8411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 752ef38a-a5bd-439e-d044-08dbfbcad6dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099


Petr Machata <me@pmachata.org> writes:

> Benjamin Poirier <benjamin.poirier@gmail.com> writes:
>
>> On 2023-12-12 18:22 +0100, Petr Machata wrote:
>>> 
>>> Hangbin Liu <liuhangbin@gmail.com> writes:
>>> 
>>> > On Mon, Dec 11, 2023 at 01:01:06PM +0100, Petr Machata wrote:
>>> >
>>> >> @@ -38,7 +38,7 @@ if [[ -f $relative_path/forwarding.config ]]; then
>>> >>  	source "$relative_path/forwarding.config"
>>> >>  fi
>>> >>  
>>> >> -source ../lib.sh
>>> >> +source ${lib_dir-.}/../lib.sh
>>> >>  ##############################################################################
>>> >>  # Sanity checks
>>> >
>>> > Hi Petr,
>>> >
>>> > Thanks for the report. However, this doesn't fix the soft link scenario. e.g.
>>> > The bonding tests tools/testing/selftests/drivers/net/bonding add a soft link
>>> > net_forwarding_lib.sh and source it directly in dev_addr_lists.sh.
>>> 
>>> I see, I didn't realize those exist.
>>> 
>>> > So how about something like:
>>> >
>>> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>>> > index 8f6ca458af9a..7f90248e05d6 100755
>>> > --- a/tools/testing/selftests/net/forwarding/lib.sh
>>> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
>>> > @@ -38,7 +38,8 @@ if [[ -f $relative_path/forwarding.config ]]; then
>>> >         source "$relative_path/forwarding.config"
>>> >  fi
>>> >
>>> > -source ../lib.sh
>>> > +forwarding_dir=$(dirname $(readlink -f $BASH_SOURCE))
>>> > +source ${forwarding_dir}/../lib.sh
>>> 
>>> Yep, that's gonna work.
>>> I'll pass through our tests and send later this week.
>>
>> There is also another related issue which is that generating a test
>> archive using gen_tar for the tests under drivers/net/bonding does not
>> include the new lib.sh. This is similar to the issue reported here:
>> https://lore.kernel.org/netdev/40f04ded-0c86-8669-24b1-9a313ca21076@redhat.com/
>>
>> /tmp/x# ./run_kselftest.sh
>> TAP version 13
>> [...]
>> # timeout set to 120
>> # selftests: drivers/net/bonding: dev_addr_lists.sh
>> # ./net_forwarding_lib.sh: line 41: ../lib.sh: No such file or directory
>> # TEST: bonding cleanup mode active-backup                            [ OK ]
>> # TEST: bonding cleanup mode 802.3ad                                  [ OK ]
>> # TEST: bonding LACPDU multicast address to slave (from bond down)    [ OK ]
>> # TEST: bonding LACPDU multicast address to slave (from bond up)      [ OK ]
>> ok 4 selftests: drivers/net/bonding: dev_addr_lists.sh
>> [...]
>
> The issue is that the symlink becomes a text file during install, and
> readlink on that file then becomes a nop. Maybe the bonding tests should
> include net/forwarding/lib.sh through a relative path like other tests
> in drivers/, instead of this symlink business?

Or wait, the goal is for make install in the bonding directory to
produce a working install, right?

Hmm.

This worked before exactly because the symlink became a text file.
It does not work in general, but it did work for bonding.

I don't have ideas how to solve this elegantly honestly.

Maybe have bonding tests set $net_lib_dir and forwarding/lib.sh then
source net/lib.sh through that path if set; have bonding symlink
net/lib.sh in addition to forwarding/lib.sh, and set net_lib=.?
It's ugly as sin, but... should work?

Hmm, maybe we could side-step the issue? I suspect that vast majority of
what bonding uses are just generic helpers. log_test, check_err, that
sort of stuff. Unless I missed something, all of them set NUM_NETIFS=0.
Those things could all be in the generic net/lib.sh. So long-term it
might be possible for bonding to do the trick with symlinking, except
with just net/lib.sh, not both libs.

I think that most of forwarding/lib.sh actually belongs to net/lib.sh.
We reinvent a lot of that functionality in various net/ tests, because,
presumably, people find it odd to source forwarding/lib.sh. If it all
lived in net/, we could reuse all these tools instead of cut'n'pasting
them from one test to the other. Stuff like the mcast_packet_test,
start/stop_traffic, etc., would probably stay in forwarding.

So that's long-term. And short-term we can live with the ugly-as-sin
workaround that I propose?

Ideas? Comments?

