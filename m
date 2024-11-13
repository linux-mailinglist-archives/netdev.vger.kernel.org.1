Return-Path: <netdev+bounces-144471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F99C77C1
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 16:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F6B4518A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6737DA87;
	Wed, 13 Nov 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aA0PzeKY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4C7080E
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512242; cv=fail; b=jAljUGI8eawwLBtkhPcgpEYb+GP251WinZ41V0G95lNYwltDwvfqSUe47oIr5DqfsF7Y5zDp5zeSxYVRM12+dDEsdkDms3erYcVywJnBFL4oInrxaxYBtmAPZVsMykgfcgQTDUCAFVkmcJrt0PmAv0UvJKxUNz09X8l3Y2Ky5MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512242; c=relaxed/simple;
	bh=u9nHvwOQ+YoFAA+P27D/8Te2SWG8lDnmyWEoxF+r7VI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BPtrdeYrlZ9fZltsSQiVSg8CiF5/jXt/k4WMII9dWufzeW80YsXfpqfqf006ld3kyI5O9iE81KQp4cajcqheS7YL4wZCcgmSMK3mPno+2Bpvf+HxL5WUHl50GNG+DeGWZQyZsLDNh5uKDNgyHyG6hBAU9YBQ9BantUv9hp1PO4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aA0PzeKY; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgdv48yRgQh0ZZ4W0HKtJCLRRiUuRnuLIjOue0LNk1FHUi3ooV+p7HazqXyDFhpybb38AwTihNoPxU4jEdHKqmy2oVv2cmyM0nX+CuPY92oVtngEH/QXmJmWTUPOZZ4jS28af8iJ0XY6Jplf2/gb8saNugtvJiW1+mDGmdjPY6cmdEmeDVoNXH+lK0v6SjkK2akKbXNmI2mh2LVanSrGN2IiIwymo2QoEGUwBGKd+jhnWLJVALECy7k/FtGieJRxaSm22Onl00GwL4sWlrpAUhpHsV0rhCYGb00FlLRA52La8xFGyr64xFLsYVqMs2aosc2uYFRqj96qOxftrSCpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogoxEfA+TUOZmjp+wJm0BUqZG8ID0EjQp+TNGaJsIOE=;
 b=bemy1mqf6gXlooMTmlwSadD7cXix4P0iHjgvRdOHYha1zUtvRZQj7u9RWBQAQXmXGp1irvGyo8Lw44HMS/hTV1+sPQCsI+p+GE6mcqMzhK9MfndkSprdWzJrtghOdIjPdLNLabtHHtpvhGOhG2tU+3KyuytXeKzBJQLEGJcoFvVMu5O/obipfMRisv7KEI5fWkMa+bOmWuZCcp9tVN1WbtlYNSsIX6QD08AUMUhZhMVoU6Yqi6mWUcOoikUtoc3YVmdHaC7WMUzrmtMVUdqUmQSb/e8YFNO0BlfXM6vnRNhjGNeW5RIv2ugXZ5Xh7l5OMwmYH7toj1iu3bEFKwWcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogoxEfA+TUOZmjp+wJm0BUqZG8ID0EjQp+TNGaJsIOE=;
 b=aA0PzeKYaHNcCP8cHTZ5Cz0ysJfuyHD14BQruW/IbXR25h5Ri4ukR/ffCnIt9/hkanlfCE3iftwrS+UhTg/WOTCbqNxaGLlg8ewc47080K170gaeOp2SEscW2yrW5/E4DKC2pwSKTkJeli84QnGeLK264526BX00mL7zKYxzBCvbSiCW7SWq1a06kM6kN2fNseTe8+zUp+B3dtiZYxzFedhGjl7Zu0G/ubnxWRsMkHoL9RrhwCW6YdI5iJykZ+wLqbbYwFAGmxRaJDtUZ0gN6fu8XRferAh4v3BTbrnYucwY6cbFjd3Nwg+eICCSW1WPzj/wj7vRAXRPo59x12a9gg==
Received: from MN0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::23)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 15:37:12 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::34) by MN0P220CA0011.outlook.office365.com
 (2603:10b6:208:52e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 15:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 15:37:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 07:36:52 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 07:36:50 -0800
References: <cover.1731342342.git.petrm@nvidia.com>
 <baf2abd6af2e88f8874d14c97da1554b7e7a710e.1731342342.git.petrm@nvidia.com>
 <20241112142234.7abf2232@kernel.org> <875xorjq37.fsf@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 7/7] selftests: net: fdb_notify: Add a test
 for FDB notifications
Date: Wed, 13 Nov 2024 16:11:03 +0100
In-Reply-To: <875xorjq37.fsf@nvidia.com>
Message-ID: <871pzfjgc2.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ad5eb8-e373-4d09-be10-08dd03f90b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hRJP/tj45W4sZdk+glE11r2fH4rufcJcBTwbfqWdExPRPZxYIMsz4LZILcXd?=
 =?us-ascii?Q?Be871AXF3b6G79GTEpNlyETs3kmxlpnPyEF2DTbrns5lj3Rc6c7MW3MwqKSp?=
 =?us-ascii?Q?WT2MmZfLc9Q5ile5C+lSuqTQiso+cYoZ8P7ehbhWb/qwWi8qjM58j/1gjTrB?=
 =?us-ascii?Q?ihBaUHOy6Tl4jXj6iutyMXfbju8dU18QvG1OryUggcFq7lF3IA0pq6eJ7dBW?=
 =?us-ascii?Q?hCDd5rEH8eLQAx9oF2LUI/4Ev5X6Xf5co7SrezYOGCJdLJlB3vh+CT7z0LJ1?=
 =?us-ascii?Q?LEvjTJM0TQ35Vw8F5I0xOQUkC+qTG+ZNc56N0qdLIDnfxHEuGRZU/9Y67k7v?=
 =?us-ascii?Q?YAUb2z0vIW7ICXYq5x8LoWQw8j+3lfo3rPKhGTIcOtlEKhXLZP7SN1FSedvL?=
 =?us-ascii?Q?/BOflBT95XKWBb4Hsz8qBy9EX9EiPjV1qD+6EbAGHTuB8naWrjyukxoAxcea?=
 =?us-ascii?Q?pa0AFJfEVuBaArbzDSA/J5XE5ZWKeGGI/uRGhK1dIWBG1uckLghBbSMaDzUk?=
 =?us-ascii?Q?PZQtHjnHqz7szptGCJU7RHLMVDyY6Qw9p0eItdqPPZbtiwaLgKBz/P/m8lY9?=
 =?us-ascii?Q?c+gDAkouVKORx0y6FidvcrzQom9E6WlMOlIP5xQj3xosv4qstSssB6NzVrHP?=
 =?us-ascii?Q?0Lc3HB8fvkHb78+WQ4W8Pr2eJPWezDbICKUZI0SO/5Wv0tDoZ+cbKZ0KY2ty?=
 =?us-ascii?Q?pQNM0iRg7/3mfA2zWLUDeTaxocJrSLe7HUxjjtRY8Onptmi4D0N1YJu2R88Z?=
 =?us-ascii?Q?yGcHzM2YEmVBRPOXkii4KmjWxBxo3Jhfz3VrDNuTSzSFtNkxgnIuK9pC+LIQ?=
 =?us-ascii?Q?R2nJAzDQ0YHCo85eQNcCU156CdPy/1r6uxTosm6rmUN2efq7wDS9IjVFgOFz?=
 =?us-ascii?Q?EJnyDIt/5dPxIY/i9Xh4kRx8mCygFFW8CnEGZWGMTZqnd/E3zNhW48CtiLgm?=
 =?us-ascii?Q?wd6tX6aEItKapPmDSsucl+QHpFDQc+KmTVKql2j7NmBN4SjapgaCuUvCLH30?=
 =?us-ascii?Q?UprAHMI9gHyae+tq8vcRh+Ce6yVcY2CmmqEbEmdM4gGkewjUpxoqmHw9+N9h?=
 =?us-ascii?Q?Gus5ctlvQGnClt9kqYoR08lfOXg+Ev24Y0e8w9JlDt59p22xSKeOpQ6QsXgT?=
 =?us-ascii?Q?5LT2/K1kuDpUhWYM2Q7HyhLrYMesVz8NFBPFU8ausu6HyDjCLzTLGqZWGRaY?=
 =?us-ascii?Q?qWE4mzijuOSn1azMNQWHZ5AkTa98KHcBJlC0XBy1qdnZcLKY1rDfkiOjIc4b?=
 =?us-ascii?Q?QBDUeVNNlRfTe64dd6yyVHgekdHZ3otbDX23/6mN3er9DMEuuarsSILI3guD?=
 =?us-ascii?Q?RHnzT2bq4Z19Iyoes8YUl6N3cQdnpOatqzTRmQxwnCQoLQsVIWx0ak6k9Sxu?=
 =?us-ascii?Q?S2IV/K6Z3S+MWEtfqQjDm/jAvnfpMjFx26ZQkMJS2HPnq4McGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 15:37:12.3210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ad5eb8-e373-4d09-be10-08dd03f90b25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676


Petr Machata <petrm@nvidia.com> writes:

> Jakub Kicinski <kuba@kernel.org> writes:
>
>> On Mon, 11 Nov 2024 18:09:01 +0100 Petr Machata wrote:
>>> Check that only one notification is produced for various FDB edit
>>> operations.
>>> 
>>> Regarding the ip_link_add() and ip_link_master() helpers. This pattern of
>>> action plus corresponding defer is bound to come up often, and a dedicated
>>> vocabulary to capture it will be handy. tunnel_create() and vlan_create()
>>> from forwarding/lib.sh are somewhat opaque and perhaps too kitchen-sinky,
>>> so I tried to go in the opposite direction with these ones, and wrapped
>>> only the bare minimum to schedule a corresponding cleanup.
>>
>> Looks like it fails about half of the time :(
>>
>> https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=fdb-notify&br-cnt=200
>
> OK, I can't reproduce this. Trying in VM, on an actual HW, debug, no
> debug, no luck. But I see basically two failures:
>
> - A "0 seen, 1 expected", which... I don't know, maybe it could just be
>   a misplaced sleep. I don't see how, but it's a deterministing
>   scenario, there shouldn't be anything racy here, either it emits or it
>   doesn't, so some buffering issue is the only thing I can think of.

I think this really could be just a "bridge monitor" taking a bit more
time to start every now and then. Can I have you test with this extra
chunk, or should I just resend with that change and hope for the best?

diff --git a/tools/testing/selftests/net/fdb_notify.sh b/tools/testing/selftests/net/fdb_notify.sh
index a98047361988..a8e04f08831c 100755
--- a/tools/testing/selftests/net/fdb_notify.sh
+++ b/tools/testing/selftests/net/fdb_notify.sh
@@ -26,6 +26,7 @@ do_test_dup()
 		bridge monitor fdb &> "$tmpf" &
 		defer kill_process $!
 
+		sleep 0.5
 		bridge fdb "$op" 00:11:22:33:44:55 vlan 1 "$@"
 		sleep 0.2
 	defer_scope_pop

> - Deadlocks. E.g. this, which looks like it deadlocked and timed out

Eh, these are ancient. Never mind.

