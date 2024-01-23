Return-Path: <netdev+bounces-65001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF19838C81
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 11:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466231F29245
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5325C8FF;
	Tue, 23 Jan 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mlGslHn1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238625C606;
	Tue, 23 Jan 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007003; cv=fail; b=n3EnpyRYAJKjWqIZtIstYmGqdqX9kzfQOqiC8Zsv24HjEFBg/erzDaMpql8fm52n9dJJib6jRkLjF3Ji/AOkj4Wje11AIMYjdpmzfEJz344qfesXzN3BtZcxm9pYOfI5hLGLFLT6pqa9Zmcr60d7/7Hmucaxi1tMIg7+ud7/8ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007003; c=relaxed/simple;
	bh=cMj2pjnXRHHUOadxnGVY1LdoWtTzP04/oztLbnRlJXI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=T+0ZpplivZ9z21heFnv7JF/GUpD0NkefiNF8d4IK3jxX6AOV7w3iE/T3+1BKQDh+tdNKnpkhe4Ul4z0SnpD05fpvno5H1SLn8xcZyUVjcbsSKs0xL2y0RbsQnmvXoEukRvPuP2ihtAMuFUWWZLXjIHa4n5UkHhIisPpLVO3eKrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mlGslHn1; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaxezxhpISHL7nXbGW8aVkxl8vVbOJKW7QemLtVKfq/OXAUGj0Au2c7DEBuo2oDuwjsvAoef2DUNBTHdMyA2b3icFvddya+T46MSNVdCiqGqHhG6iICVBlSrunEszmqyGJTqKeQg7JTcZpqBo0xghIqL3actejf9zLkBQv4pBunj9hHV3HYsLgbWG9Jboiy9dZ4WtIMbnappEO1O8rRM8e7rqZGH7XNmg0l+HSDX2N/OqDeCyYnqjHY0jyDgkX29cJvHl8F0J1AFDYq/0zLZGZs6U+E5lb78vJ6Fgj7h/A/ZiFrgFsNzd/zHF3fhPKAkjJDA9gPsp7n/UwHS5ssB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMPC5DwH/pomLS05xeucO6HqHOUBAxD4GQHPUp40eh0=;
 b=gyMfcMTNy+vg4clKD0azOOqKrfhS0ZH8wvwNaNa0UxHi/mpTVWT5YnvwOaqb9xXSfQW9GFdNooJiAKLqIldKU551oj+qbJzQTRehlWGACEpJxgKhyrSPNp4+LkHFyRQRR/JRiUqnfYccAP1bzd8rfgNd76qV8OZDRrvoHCCGdRt5WEzoez/m123O8e3YiezHrEggO//ldUw+mkoO0tLHgD409dFa+0x7qmGNi43Xv4p47jazPTBD/AIsFNG69iIHLSms0LJVgwFhRxzfbXkvOxgsgNam52tIha/NVBL24ZbE6/+DkVFA5ggkjtIjOkGYo7RsFr9KIIaKAjeHF5fKOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMPC5DwH/pomLS05xeucO6HqHOUBAxD4GQHPUp40eh0=;
 b=mlGslHn1IP+JRaPsYTe0MCSVF8C22Q0tJKvmEpY/JUQDXOjQ63HupA5w0FcMSkOw/9ZkDBMaRt2p+skrzkkdEKFg2tEcPplDxYMNkQyeNytN+lWkAE+Jqk1Qse5hv97GzuZcLyq4lBPtRoAH1gqO0r7SPtUnAM1PHRhfeqqUkDIVeN/uKUf1Ztyh2s+TxRSza1q3b++M0Zoz+mgMJqH/li7PiE+vUYOjxj2JfVqfmmGfWdv8BxqPxsmcONIqOVUpgZJZrPUu9WF5EKHD3ieYa/pAcH6FV9Aq0HgVMICqHh3fGugF3fpcSXzUagtyYqVl80fzV+whKgCgR1nYKAnV+Q==
Received: from DS7PR03CA0215.namprd03.prod.outlook.com (2603:10b6:5:3ba::10)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Tue, 23 Jan
 2024 10:49:59 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::91) by DS7PR03CA0215.outlook.office365.com
 (2603:10b6:5:3ba::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Tue, 23 Jan 2024 10:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Tue, 23 Jan 2024 10:49:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 02:49:38 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 02:49:36 -0800
References: <20240122091612.3f1a3e3d@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org"
	<netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Date: Tue, 23 Jan 2024 10:55:09 +0100
In-Reply-To: <20240122091612.3f1a3e3d@kernel.org>
Message-ID: <87fryonx35.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c5a5dc-c553-4a23-1d03-08dc1c010b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F0JjXPBwhRcMEgfXKxry12h7gycHxIoI9SRjZnOnCiJDlJhL9xR2qFOTHxhireAorDcQYdgYPruTQ7AkvMwOLu2OW/r4l0m5huVSggxR2wx5zL5MtOkGlJSEAT0W1ldGgfgR22t+s4Uwsqg/YyE4bC5UX6q4S0KS7WgenNg83hu+WTuu7iL8D8KaYEvNrA/4w3K0HXtUdvCIuWf7IwIhz+25HjtUgnSdUGD1M8nHW+3H70Pjadj6na3oHCBvC4+4jPlRVlQBumwIkNZL1nwFY2MJU1DUVIy+661u0gkDoC8aR7N9OjEohgnFFtpYM+EYWSCeapmaDO3h1ZCos9MOVijwk/5hjjaawMdbsA8gq0xhATji195gZBmv4B3joDKcnHCUyWJcckGmqtfgzZ6RBdxDDXCNaH6egVFixjI9t0JqSJT2KedRwnST/QyCi4zh6P8KoSNCQushRtj996DyJNWHEkzHcCVCPVKPHegNjNxziI2nB/gZTIi0aI1q1NcwtVL7lCV2XLDm2jUMbefDLgZUcyk5uFI8OW3LmHEQCHUBeucOcbQCSRYH4pErc5MhUaesnh6Pn4uks5ua/5hrgFwtMM4gNRJD5r2xAGfwla95ktc5U+1pzZ5oV+Nzecdja0zVFEy2sXgobwInbmKd4pTDraK+eenmx9Mth0ks4ojNEAev79yOY22XEOI6qjLhvUiiPS2ifwPA9acAn1k1/aLFIRi5CSgWy7t4tybP33WK7e8TtD2DCcACxSCmIw/YhZ4oap/+X/CLVVa0VaVHuw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(2616005)(478600001)(70586007)(966005)(6666004)(4326008)(83380400001)(36756003)(336012)(86362001)(41300700001)(16526019)(8676002)(426003)(8936002)(47076005)(2906002)(6916009)(356005)(36860700001)(5660300002)(316002)(70206006)(82740400003)(54906003)(7636003)(26005)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 10:49:58.8141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c5a5dc-c553-4a23-1d03-08dc1c010b45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515


Jakub Kicinski <kuba@kernel.org> writes:

> If you authored any net or drivers/net selftests, please look around
> and see if they are passing. If not - send patches or LMK what I need
> to do to make them pass on the runner.. Make sure to scroll down to 
> the "Not reporting to patchwork" section.

A whole bunch of them fail because of no IPv6 support in the runner
kernel. E.g. this from bridge-mdb.sh[0]:

    # Error: Rule family not supported.
    # Error: Rule family not supported.
    # sysctl: cannot stat /proc/sys/net/ipv6/conf/all/forwarding: No such file or directory
    # sysctl: cannot stat /proc/sys/net/ipv6/conf/all/forwarding: No such file or directory
    # RTNETLINK answers: Operation not supported

I'm surprised any passed at all, it's super common for tests to validate
their topology by pinging through, but I guess it's often just IPv4. I
think the fix is just this?

    $ scripts/config -k -m CONFIG_IPV6

There are also a bunch of missing qdiscs, e.g. in [1], [2]. To fix:

    $ scripts/config -k -m CONFIG_NET_SCH_TBF
    $ scripts/config -k -m CONFIG_NET_SCH_PRIO
    $ scripts/config -k -m CONFIG_NET_SCH_ETS

Regarding sch_red.sh[3], I worry the test will be noisy, and suspect it
does not make sense to run it in automated fashion. But if you think
it's worth a try:

    $ scripts/config -k -m CONFIG_NET_SCH_RED

Then there are a bunch of missing netdevices. VXLAN[4]:

    $ scripts/config -k -m CONFIG_VXLAN

and GRE [5], which I think needs all of these:

    $ scripts/config -k -m CONFIG_NET_IPIP
    $ scripts/config -k -m CONFIG_IPV6_GRE
    $ scripts/config -k -m CONFIG_NET_IPGRE_DEMUX
    $ scripts/config -k -m CONFIG_NET_IPGRE

And TC actions [6]. I think the following will be necessary for some of
the tests (we enable BPF as well internally).

    $ scripts/config -k -m CONFIG_NET_ACT_GACT
    $ scripts/config -k -m CONFIG_NET_ACT_MIRRED
    $ scripts/config -k -m CONFIG_NET_ACT_SAMPLE
    $ scripts/config -k -m CONFIG_NET_ACT_VLAN
    $ scripts/config -k -m CONFIG_NET_ACT_SKBEDIT
    $ scripts/config -k -m CONFIG_NET_ACT_PEDIT
    $ scripts/config -k -m CONFIG_NET_ACT_POLICE

Hopefully the above should clean up the results a bit, I can take
another sweep afterwards.

[0] https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/14-bridge-mdb-sh/stdout
[1] https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/17-sch-ets-sh/stdout
[2] https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/33-sch-tbf-prio-sh/stdout
[3] https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/21-sch-red-sh/stdout
[4] https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/27-mirror-gre-changes-sh/stdout
[5] https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/18-vxlan-bridge-1d-sh/stdout
[6] https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/42-pedit-l4port-sh/stdout

