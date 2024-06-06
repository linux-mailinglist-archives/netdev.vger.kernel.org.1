Return-Path: <netdev+bounces-101460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E2A8FF03C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397BEB309AB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9AA199EAA;
	Thu,  6 Jun 2024 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ECQxn0tz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928521E494
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685547; cv=fail; b=rPqes2ZGG6AHMF8pRr///4uOxpBTUbGzpqxyfiQksYwxIQ7OOTCG7MRbPJofihNX8m7xr14LcznKPzHBa2dFBV2sMGF9hZWyvK0wVQyAIEQgV2aPfvzK7L+hj97x39kRwWV7vpxZ8TsPcw8qxvv9Zp1vORXbqxWicf+xsR/ddQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685547; c=relaxed/simple;
	bh=v1XgP0limY1Ica8XNWNJJd3fpPRKVcbm0tocZA3CdYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JE2jk1fsswFWXvqv1MMnzgV68RQE65i5FSmXw5ugFfaMgNuesHR/PttMS0hlWKjGnQxbVy8eCKQ6BdA3I3dGmUHC7w3uUiEJMDmYomM6IsGxDvt5efikJKvP1j2We8dYtWrl+Azz6IlxmRzPKNVNKcKLfF6b/66XRNSXrHHmwOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ECQxn0tz; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH6TfblqH8Lozf1pmRjsoFe1BUdgLlZcTCjV/W01/WRlbrYij7iPn9OUE6KIB3dKH2zS61ok58r3uh+T1x4pczYzfdry9IB8FvP0F1izRYcY5wZ48Kzzfgo7gLfp26ti5xxc7+ZYjd7ev0bEyprdI3rmdha42E/C5+u8um9yVTsPENPJSH8CPHpVSQJhb+CAZ8mC1xEo+QoxtsjNPIjwahUy9u0i2IzzyiSvbZyvKrlvpmijSccqjdOzSmiF4qwMQxcUmnjGTXoddxQiQgAsg/sgk8k/vqUBEsCB/LNvxWwCAyZa8BhbS3rbAPO5TtkN+k6oP/uj2peRgSkdnPberg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHLTahARasNxKguvRip3pidn1kVnJ6ZZ0XL/jsE3qD4=;
 b=IXw/Fimz6QHDlLA+zumn9diDwSu4FVKEoKemaYp19pxTWR+imOaPqpHIKdXbmCyn1y7IPJoloCz7bq/wN343tfDB/udOBoZXiHLeNrnaweHSJAgSVlkHcp1aPs5nsb7edYwa5qwMB8cFYW0h2TKrNp3H/Loml7xlY2XlDElMfKw7vpwCkR5eChzhxdPXk/s/nCBFpyyCbJwbk1AuEySrEQWcuKnp2coiBIK4QMtonUqHskBVDJkKcokr4UxLeQucbfLNMdSf9P4XAle06qEGdvSvBr1ujtCQT7jBLiHA61YbfZ61W2wKdEM56Dl6mTciD33KZJHPFgmjN26ZrfgfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHLTahARasNxKguvRip3pidn1kVnJ6ZZ0XL/jsE3qD4=;
 b=ECQxn0tzXZLM23ffKl2IQAGxR0enBjvRDDW27hhFCh22lEIPUyEZ9fLFGDJjKJr6Uny+tgyMesDZEsMeRf8KeSAHx7W8D/gGFNvDzkRIz1BonmH7brskK8uF4zXCy9KIlyr/4vMxGCHiI7/IALm9+qZ3VxkPQ4tq0LPjayqDibxnVNEMQl0mSLFJl4jJADe/EJp5ntbQBZaSgF2Cyz5tyhCdym7EAXh13EV3ksRHAawdKhp7x5eecinOZwCDAo4BGx2HTxPyLM8Jbs/BuquU8CnRDNhjhnqXN/Y0ize5l1rFAsfUvfCtApYkfQabgoTRlyJpN42dpu70uOLUsoux7A==
Received: from MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20) by
 BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Thu, 6 Jun 2024 14:52:21 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:23f:cafe::54) by MN2PR01CA0051.outlook.office365.com
 (2603:10b6:208:23f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 14:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.0 via Frontend Transport; Thu, 6 Jun 2024 14:52:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:06 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:01 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov
	<green@qrator.net>, <mlxsw@nvidia.com>
Subject: [PATCH net 0/6] mlxsw: ACL fixes
Date: Thu, 6 Jun 2024 16:49:37 +0200
Message-ID: <cover.1717684365.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 14873d7c-75e2-46dd-0795-08dc863844f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IwAZGyoUwiIli+P9eiIkpS0VR5ArbgqD8i+WvYPvIZd4TQS/j4uHkAHwClPs?=
 =?us-ascii?Q?1k8LwzBTGfUsyPGLifp+ZpVOLolUyb1wCkWw7g7oHaRaDWMcLy0dVjUqFcMZ?=
 =?us-ascii?Q?mFjcjz1QCX2dr9RhPeyndD6Tde6880NC0nCHtRV09dxxThDiNuTk7k+j9gFN?=
 =?us-ascii?Q?hA+sdImMhD9wrHlwi78Av2KCerzdZ5Tuu2Wc84BB2l5jC4lIB4blzV9RX5tn?=
 =?us-ascii?Q?AtCStMWLJylagmk6VOS5DGgad/DHyKmGUm1igOMeNNSrg7D6TRcKW+9utkJO?=
 =?us-ascii?Q?8OUM9ZRzoz1PIer3KiuaSJyKMKQAuGP9JsSiZqgmeW40u+FWfhiIzi6Ree77?=
 =?us-ascii?Q?Cw3OnzDtYfFK3SdjdoSF7rU9W6ajuApplved/ulOs4KXi1rqpkqpnwTNtmyM?=
 =?us-ascii?Q?vDlWHd/JE15MXUGEzIlCmwtEUNWMteh6g4HgQNdwsPpKESN/kYiwqpzOAXsx?=
 =?us-ascii?Q?1ndk7yGxMKuSVgzeqpBG5VVdWjDqtFyl5JD8FT9XD6fzfqQnYEOM8UqJlEct?=
 =?us-ascii?Q?Qc9wgQce7MiASRo3/bKuV83VBuawIwFvpiWV5cgfVJr7ecCiVpC/DGkkFGtk?=
 =?us-ascii?Q?NatdmY5UXtJIDKyOEKtGFtu+YoM+KFrrmalgSK7Sh6t1L1stS+l1lN/dNn9R?=
 =?us-ascii?Q?Oa284ISynGNEPkjkvgu3bfHznlJ1ClTkt9gUWrre8SerCEamhroC4sCvQ9G7?=
 =?us-ascii?Q?+HKS6uBycI5s2H6i7vFFm/tOc7WXETBLKet1UoBZDZqyvFr+FJfmEwB3jA74?=
 =?us-ascii?Q?eMCWySC9hJHfwQ4o8s54d263E8VxEjbTmz7fz+4bqYmNglKj3I44pCR2uwbO?=
 =?us-ascii?Q?NoPVHf6LW5UcbYv54KgyQS3GOwgmYRM+aHwTeHgOahIjW3Opq0yq1nE3Km+/?=
 =?us-ascii?Q?MvdwhIWxq6Ycj0MrbNAgybDpX9p7B1HH6iMS/VbUT9/Mm2OlXnN0aC5vUAzu?=
 =?us-ascii?Q?/RDAvtSe4VzfZjcurq/bebw1ZdB2YvQnb/bxAaUuvekFjszFmWjF/19+csz5?=
 =?us-ascii?Q?OPE7uMxEkFpOc7gXlcIDWeDt6A8Tn9HNORPamkFm5pA7TR4AbIbhslMZrHFR?=
 =?us-ascii?Q?RB56+yvd8rxkaF4TiFppy7O+HkUYSY4GzhXmLSDoZ1L3xl4MutYZQepNfIVe?=
 =?us-ascii?Q?tSMDuOwdcYqZU+tqB8UJI3p57SZ+rmUDtyvi2LFnoTvFMsw1MT3CHo7lWcj6?=
 =?us-ascii?Q?8FSMx/wuOAUs3PRLOeEUltdfTxse6TNnuO9L9SD/1/24YgZAFX3Fw0Qj/9bV?=
 =?us-ascii?Q?fK+hM2z9wOy9Fw5BtuFiRpUyLbl1da37Q30zZ1EPT1Ucof9ZSXmOZNJQbGMO?=
 =?us-ascii?Q?4vHwSJG3AxB4yXCwF2Esxrj1p13lJB9jNIvA9WfF3sVlJu3JIN00vWMrEOC4?=
 =?us-ascii?Q?hsCwjEQ180wHjblTGU8xZZSgpYo8kesfG+7uMx21JBpelaoiJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:52:21.1288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14873d7c-75e2-46dd-0795-08dc863844f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569

Ido Schimmel writes:

Patches #1-#3 fix various spelling mistakes I noticed while working on
the code base.

Patch #4 fixes a general protection fault by bailing out when the error
occurs and warning.

Patch #5 fixes the warning.

Patch #6 fixes ACL scale regression and firmware errors.

See the commit messages for more info.

Ido Schimmel (6):
  lib: objagg: Fix spelling
  lib: test_objagg: Fix spelling
  mlxsw: spectrum_acl_atcam: Fix wrong comment
  lib: objagg: Fix general protection fault
  mlxsw: spectrum_acl_erp: Fix object nesting warning
  mlxsw: spectrum_acl: Fix ACL scale regression and firmware errors

 .../mellanox/mlxsw/spectrum_acl_atcam.c       | 20 +++----
 .../mlxsw/spectrum_acl_bloom_filter.c         |  2 +-
 .../mellanox/mlxsw/spectrum_acl_erp.c         | 13 -----
 .../mellanox/mlxsw/spectrum_acl_tcam.h        |  9 +--
 include/linux/objagg.h                        |  1 -
 lib/objagg.c                                  | 20 ++-----
 lib/test_objagg.c                             |  2 +-
 .../drivers/net/mlxsw/spectrum-2/tc_flower.sh | 55 +++++++++++++++++--
 8 files changed, 69 insertions(+), 53 deletions(-)

-- 
2.45.0


