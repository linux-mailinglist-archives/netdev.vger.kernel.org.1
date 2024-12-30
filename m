Return-Path: <netdev+bounces-154503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EAA9FE3FB
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 09:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E413A1F49
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 08:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEEC1A2388;
	Mon, 30 Dec 2024 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M7ni9mWD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3038319F461
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549173; cv=fail; b=J7dcqrq4aZAC1RgLhyIXba3batWdvf9g3qIUUyLoJluz2HLsJxRawEfl6W7WqcCpZO7irFa/t2ld8rJt2AGROLANka08yGOeDrMhiNk7s4puF+YsVI+Zh8Eq/0bKhXK1iD5k4AgEjluM2hOKUrX6tmKAxWsSEhawwYZJ1x7v6jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549173; c=relaxed/simple;
	bh=y3JatBfhDs6+iLQiOsoxqO6Cn589E+8FhjyHSTDchlo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lMJHQF8UEqtHUBtMO+UL3cOS/OQbxgs6ezUUrn1Ln/C5p5pOeJpHGvYv1ZI6Es85cMKmB9zSGuWKY0jPHVugS0z1SNjYvLWzrEFTXippKXiFAXhMhUWbipXEnNCsYitAkHXfbh/BiQKW7P++V90zouJhEuoXhOsJvd7WZtfJsXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M7ni9mWD; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvBOJsebZ9XppIPb9BRJzVWREXqBNVM+ODYzAhq8uuCdPddaSmXlEpRnPDEe3GR4gD+634qRCJb49nnilM2STgShNAtC1RviXHfnuL69/gLq5obn8TFZd/d/4+E2E8CrOpDQ+cUapIsLNQMXVA9Hh2tzAdfn0K9AS1iGIt36lv8xOGXX/zJIPqxLsBc21IU/tbJqMYoAgyXkoAqmwMZc3069wgAufLphWULV2FrdNTNcnXe793GoKMQvOYhgrXn13ZAa+fZ36JXqUQHQdbNNCyl8X7K2I5w5K46lug9jf88buR2VI/dyoaVoOuJoJVP06/5hXF/uWWKao5Ep4kRFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU+aoEKStVP23+aLThrkp9TdDKTdYn7sA6NVqN4n+rg=;
 b=Ax46RAM5TOzFv960k0kVG+1FJ2bIkBnLHFULqh6yBjUETFe1OA3gt+FHd0sXcIpN/FG7j+lGoyAD4Fcqj6HmCupgnA766hdW2Q0oKJFgI8NonGA0O7REuP2H6DiviRbfVA1LmScHe8IFgnH4KH6O5hNMuIyCcaZG+GLLgeVNG6E9mwQaylBd5UERYc3sd4xViifH72vgg3DMjmmcbGXgscJO0g20FCn6Hiy3PK4hW7v64f9q/kGgLX3PlM8FUvJ45KLUXwZdF3cY0xSaFMxFAKfbkiJSPduKbRjfBimgJsmLDu+KXFQjLmQ+qRRow7R3vaRDj4BBj/heK0S4h23ONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU+aoEKStVP23+aLThrkp9TdDKTdYn7sA6NVqN4n+rg=;
 b=M7ni9mWDAi0lnSOs5/LAvkNzlDACboHf730Yb9oNhfoktWVO20TQIxYaI+H9QYPWqnFQDMSL8mZrXdjL2GMf4Wr30txfkwPZHvJyRzUJiprCipSc+rn2TnN+0GZ/6supKnoE1OciRwmPNiru2DAXkVvRCyzMVBILoJYJAqE704ufF7WqQccivSb9UjcSR3107hu4nGN26njGlYo6K2mGv9k/2oxPaNouVqbgva6B+3xIuucQNUreCSIG6QT2BpDYd4fnd0n0YitVyH3e58RkR6ymd1el41YgRKAk/PiSDvJ7oUoIcSJM83v7ngReS9xbYRMkVwDSrfv2D/oTtFEB5g==
Received: from CH0PR03CA0310.namprd03.prod.outlook.com (2603:10b6:610:118::33)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 08:59:24 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::97) by CH0PR03CA0310.outlook.office365.com
 (2603:10b6:610:118::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 08:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 08:59:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Dec
 2024 00:59:10 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Dec
 2024 00:59:08 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	<gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next v2 0/3] Add flow label support to ip-rule and route get
Date: Mon, 30 Dec 2024 10:58:07 +0200
Message-ID: <20241230085810.87766-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8b6717-9185-406b-ed99-08dd28b041f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZcuygzSCx3aTyFNWI/EWKw01eCyZ6A+5sr4/RTo29WowlATPrVHiFlxhCDlr?=
 =?us-ascii?Q?Sigj73QMClNVTfqnm7Fa3b7dCzamgkUCoAh6WNAFP+j8e1MzEzrj55YLJGOT?=
 =?us-ascii?Q?hTchXJmFRk9jp4VGLypXLNJqMQiWUUl+zkTtgi0bE0cFnpf0CLBviL3/h2p+?=
 =?us-ascii?Q?YvKZpLtxYre4om6AW7j9rKJWDPtRmyZeT/34BXiew+D6dZmetywRn3sVj2FF?=
 =?us-ascii?Q?7cVztWD3O3s4xSUhvWicejpWWYBG3Za1iltDRn7PI7fjLdsS976o4ihdf1E/?=
 =?us-ascii?Q?b0LW9dmv7HHqDX9mJTmxP4Z9qJgYxapi5wm3TZM8MRueDOvWUUuXcmct5U0i?=
 =?us-ascii?Q?HibKeQU5P1x1Hw/GIV8mj3UeNZj1cIhgoPpM366I3SfLjQse3z00hygQewgR?=
 =?us-ascii?Q?oa96eg5vzXbSzXOeyaaPyTej+QrmSUEnvuQFkWqZK1s0y3jDr0u3jG3cniiP?=
 =?us-ascii?Q?fVI4QV6olkMj+REtT2jAUxH+a0QGGOcNW4K0u1R1zMYZ19ERaDtCzgZ8g3LR?=
 =?us-ascii?Q?QDyhY0pMdSpSu2Odkp7MVsm1pB/gC5Fslxeb7kYAtRtB4/M6BmFOGCJdvLw3?=
 =?us-ascii?Q?koi33LejLR8UzHE8X1inQE+TQess8pCBtGXd2jeNu6DR1SvLWOLIP/OhTAJp?=
 =?us-ascii?Q?wo0YDYctUMYWjaUupPNfjVUgukI0tTKCfcL9WwZIVLzTOpiNLzrKDCbBOa7j?=
 =?us-ascii?Q?CwU78Xru3WYoSgXRmYvxyjOfZWWwYhNWM7TzQXZI3/cPd72qLpK7bfZntCuo?=
 =?us-ascii?Q?kobrDeIDIp4rjwC33ZqbnonZhE8d5YZrXtljoZisiggqOAH1xyknoO7/I3AZ?=
 =?us-ascii?Q?5gm3Xv6RYTLmvEfzLA4koPMnYFgX7Mw4nSCST86FS8moprHJqhVm3rxZvwxh?=
 =?us-ascii?Q?qrY0aNcvbO2ab6pd6tnfbixAdZZjtxW5V5uVejhkslhBVIkMlHqYmpTrFNbk?=
 =?us-ascii?Q?fspdw4lSPP7VXAySAnmMSvlo5/y2vCFFCh8tDW7gmbyjHLQE2XfpLWZig66j?=
 =?us-ascii?Q?VmZIlFVJpvalCsFhxlzaRTPS+SsTYV4sFohKoQ39WvLNPy42ciAReNF1LKhJ?=
 =?us-ascii?Q?jkjBdbEdZRN2+gbDXh+VWL1sbwDQUSuzCeWe+Vcls5b3cCtrASt4qpglbcm8?=
 =?us-ascii?Q?Si+TjmJFoxxR9BYDJp16c1x6RFjoFMkRhMIcKIJ+c10+A5VC+HcXGovS6ZLX?=
 =?us-ascii?Q?iYbUTRkMMWApK5ENlvxYXmQDpnKI9+pzLUnhUQHYfh8H9xtuubMwNAbfC3tB?=
 =?us-ascii?Q?yqVSe73/YuQfhEJw2DmKSrCjK0+aME3KcVk+d8lNuxrcJoKQrZy8owfH3Ke2?=
 =?us-ascii?Q?MQ3g5FodzFWsf3xY/cvXKzp3Eq7rvV9ruJz27fJHJHzvK1R7iuJM3+R96TeB?=
 =?us-ascii?Q?5KfJ8VmjRK/SvCP8Owk65gK1nNQ2udNZCKZTwTWYWj2UdtzcRYLncHf4FdYa?=
 =?us-ascii?Q?kV40QCy2sU+s2p98qQWnE2UEZCPzIavqd+QF3vDL3WcinDzEKg8eL1zkijj7?=
 =?us-ascii?Q?RypqIp/C8J9wbuY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 08:59:24.0554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8b6717-9185-406b-ed99-08dd28b041f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945

Add IPv6 flow label support to ip-rule and route get requests following
kernel support that was added in kernel commit 6b3099ebca13 ("Merge
branch 'net-fib_rules-add-flow-label-selector-support'").

v2:
* Remove new line from invarg() invocations.

Ido Schimmel (3):
  Sync uAPI headers
  ip: route: Add IPv6 flow label support
  iprule: Add flow label support

 include/uapi/linux/fib_rules.h |  2 ++
 include/uapi/linux/rtnetlink.h |  1 +
 ip/iproute.c                   | 10 +++++-
 ip/iprule.c                    | 66 +++++++++++++++++++++++++++++++++-
 man/man8/ip-route.8.in         |  8 ++++-
 man/man8/ip-rule.8.in          |  8 ++++-
 6 files changed, 91 insertions(+), 4 deletions(-)

-- 
2.47.1


