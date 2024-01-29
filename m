Return-Path: <netdev+bounces-66674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C448403C7
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 12:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5F1B22EDD
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552F55B5D5;
	Mon, 29 Jan 2024 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sFRXLIu9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C05B5D0
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527657; cv=fail; b=bY/HxlPhh9wFgSc4NZb99jq0gr+68+vgt4Pxxstj377yKJAsNpjvGeV2kzWmBzLkMFOV+wXRgVrrSONARSw24TBp5HXp86hvt2DsGAIjXVSnR+XBb1VuaU+MmM8MDSc3Y/vCLD07jB30it5Cc+Eyu/VxGW2Ij+PWqT2xHnQfEUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527657; c=relaxed/simple;
	bh=8SsEtMaDFVH+LJUaz0cupGRLsfXIY3miT6T8rDyb4f8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=a/eBR+Nm0ATivGN4VbWvMzUq/YHeCY6iooffEV3ccd/981nqZ+1FobJOSDzyRBo2bw+AWNBKqsswWEkgq7LXmxbmWiUuX2BWLf23js/Z8I/WtTSSlvYbayoS4/ilpSsEKINSkR4pKvzGoLxpV9UKkhRG4JHLzs0uRppDUYphCtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sFRXLIu9; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDNcoF9VmPQCxaICbgfo++C//7siuf/vNB5tSIp9wEE/hH8FDT+N0QIvK0mdYIICxNFoHmwZzZjFVMLvr6/Cpg5P6Pxu0w7i/ZXtzRiLsstxg1edA05JHu51SoF6OwdBlVJtU1WbujlVashypwBb4Rf+cwIius65eDPjMtx6RqFnNNnFZfgboFGPNSMgakFPSIMvPZW6NklCrbEbhsbTsInJRM+58+R7t9L35KZNDy1cBfmSO0Rt2wqXCsAyiFGaUL1bpUt68JFIB3b1CCYlPBcOg/AdZupq8ogfIC6lhZviKHlItR09D13wgOBcIONtAgcQOzvzJo2P1CoOZVPssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=571lrR38Kelplnh1zEBfNaB14Yj8OCPOk/dXCZJ46ws=;
 b=fFgpq4dqMK7pC+f5bMHSKWYpfo5xOBs6LS17jy0jJ/3Z7R1pIBR/LZuTJRvDyxP33HFQUCdeD1Sp8YOP+mnUcRpMhQFXRAglwOEchRS+azjJDfhAdoSlnm0oqYtEnMpH9dt0pUfdQ62fMFq1GiboH7BXEtSR5LDFy+krIqK+BQaa9j4AtxOLBbnroYildUhNxP6ySBWIVuRKlt13CoCiE4B2DkYWyLwTrWBgsPnuwMC+lMVixArGcNXQOtjSTlsAgt5g3fqiz6O+lahLaKdV0pd8mOWxaFbKr+rsJRG6Rs98mnciWQVBlCInLa2UMIY9Mz5bkqzf/a8D/IAJXhDS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=571lrR38Kelplnh1zEBfNaB14Yj8OCPOk/dXCZJ46ws=;
 b=sFRXLIu9RfqnqY2i58JklrX+JV9CcrFMC57A18Jg6qA4NP4buXhyIANB5pxFCYXHJAn7goBZPJ+l/6B1dztItGBk1Iigad8QAXHLSN29oo4+DxHOaM1X/qnf45pa0zenytvfm561H23TiwD9L8fSE26cysXQqHngevg+z4Ci4GU6cdt3h2f6B6zSwEmgzVAJ5COPWeF41U5XUXeGAm5ulWIQyl4J0uIp6dQh/00kSxLsPIhxgSLMNiijWgO7vd9tI8CgznajQoWkpu2KmlyfAyoulByac/WuwPbwVeyliMIHVP8K7EHBQ53G4GWqzWDS5o7NiZM0kEnTTFx5JV6+VA==
Received: from CYZPR12CA0024.namprd12.prod.outlook.com (2603:10b6:930:8b::23)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 11:27:33 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::28) by CYZPR12CA0024.outlook.office365.com
 (2603:10b6:930:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 11:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 11:27:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 29 Jan
 2024 03:27:21 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 29 Jan
 2024 03:27:19 -0800
References: <025abded7ff9cea5874a7fe35dcd3fd41bf5e6ac.1706286755.git.petrm@nvidia.com>
 <20240126112538.2a4f8710@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: forwarding: Add missing config entries
Date: Mon, 29 Jan 2024 11:45:07 +0100
In-Reply-To: <20240126112538.2a4f8710@kernel.org>
Message-ID: <87le88l6qz.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: f81be653-9c52-4a0b-7320-08dc20bd4948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nym67shuQeJUBCF6tUPSlAXLUl+pnFCe5iEQf5QtnW5kMuz7f+NaHmBGmg8P6rjBkKmsx9zCXEPr4CsVkh8cPAWdJFJ/yK/uGTSVwL2FdNJK74cUmJ47YwoN2cia4GfNq3rdygME8i3bkeCJrjS5EhDMZp7avDPoDH48C676eLURJKqm3hBVHYGt1XzurQJs+In+ckDSAnfAoPAR98ZuIEQV6FmpCpNmCNmUWdKEKqrg+la4keyghsoDe14fKcRR+QaPQzCLk9jWKgoRFv8UvNAi9pE6bLswmGxVPg6mtTDQWGKFo/zcq9cs4WEG3uxzECRwg7mlS6bvDrPhIhLHm36e9rZlfB4svcf008vcw1176C/JKoCTVCGnkc657JGPFTusU0ZQBthQRLa1d99+nSWKCZjDqAYgYb2rnDLT6lQIsN8M2vjoSZ4kJBsCMINvmeaWajmuhyuqeP7yvOBhCziK6jdXSMdk8CfmR7lAC0E6gG4d4X71OIqFYLeGAj8+TbtjXyA5m6xU1bvlIRlQyO4zkhiefZJW4K5hFf1yLoyis5BwLzQTjFSy4mujQbvc197qkcOrwtLy1oBcgvWDoH17lQIXd1sPWPq7KijzlaVBErJlMrkPi3TRPFZdGXJImtMd3ekXVIL6TNXty6bHscuvvls+o70yCvHwazF1WEyn6AuAEASNOyWLSrn9HxyfsjMZZy8VFptjds/Ji3vrNpFkXQl/QIVZnAxQ+Rslor+1Iu+PUoQQvTKisgS/QCOcqBZcEcieBNZC5YpV+E1xbsHjJOUPc5nglBa4j3Zuz8EpC8xk28R8QRDN1xS0tJcf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(47076005)(83380400001)(6666004)(40460700003)(40480700001)(36860700001)(966005)(5660300002)(356005)(336012)(426003)(2616005)(66574015)(478600001)(26005)(16526019)(82740400003)(7636003)(4326008)(8936002)(8676002)(36756003)(41300700001)(2906002)(316002)(6916009)(70206006)(86362001)(70586007)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 11:27:32.9066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f81be653-9c52-4a0b-7320-08dc20bd4948
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 26 Jan 2024 17:36:16 +0100 Petr Machata wrote:
>> The config file contains a partial kernel configuration to be used by
>> `virtme-configkernel --custom'. The presumption is that the config file
>> contains all Kconfig options needed by the selftests from the directory.
>> 
>> In net/forwarding/config, many are missing, which manifests as spurious
>> failures when running the selftests, with messages about unknown device
>> types, qdisc kinds or classifier actions. Add the missing configurations.
>> 
>> Tested the resulting configuration using virtme-ng as follows:
>> 
>>  # vng -b -f tools/testing/selftests/net/forwarding/config
>>  # vng --user root
>>  (within the VM:)
>>  # make -C tools/testing/selftests TARGETS=net/forwarding run_tests
>
> Thanks a lot for fixing this stuff! The patch went into the
> net-next-2024-01-26--18-00 branch we got: pass 94 / skip 2 / fail 15
>
> https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-01-26--18-00&executor=vmksft-forwarding&pw-y=0
>
> Clicking thru a handful of the failures it looks like it's about a 50/50
> split between timeouts and perf mismatch. 

Looking at some recent runs. A number of failures are probably due to
the system failing to oversubscribe the interface with the tested
qdiscs. That's sch_ets, sch_tbf_ets, sch_tbf_prio, sch_tbf_root,
tc_police.

Not sure what to do about it. Maybe separate out heavy traffic tests,
and add a make run_lotraf_tests?


tc_actions started getting a passible deadlocking warning between Jan 27
00:37 and Jan 28 18:27:

    https://netdev-2.bots.linux.dev/vmksft-forwarding/results/438201/108-tc-actions-sh/
    https://netdev-2.bots.linux.dev/vmksft-forwarding/results/438566/109-tc-actions-sh/

So either something landed that broke it, or the host kernel now has
more debugging enabled, so it now gives a citation.


ip6gre_inner_v6_multipath is just noisy? It failed the last run, but
passed several before.


router_multicast and router get a complaint about a missing control
socket. I think at first approximation they need:

    # mkdir -p /usr/local/var/run

But even then I'm getting a fail. This and the others seem to all be in
IPv6 multicast.

