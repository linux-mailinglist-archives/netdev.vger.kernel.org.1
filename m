Return-Path: <netdev+bounces-75573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A616186A945
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A97B2897F4
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A2D25577;
	Wed, 28 Feb 2024 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="Z678qvqo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2117.outbound.protection.outlook.com [40.107.96.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545225567
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106743; cv=fail; b=pmm4htoI5NyghqdBSVcTw+RsFz68QMGfLXq7gESXy2sB+g8n2LXo5Ywox4C/QPCUU2xUeBJcyBL1ti7bOmTs2RyhxvIHCrPebYVS+is1cErdwBIi++rvrsdItpkPMvtDtybOEeR8WrQA9h7RCZprbvE3OusK3aUp/CYZ+7u+X70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106743; c=relaxed/simple;
	bh=Pn5aFOiLd9Eq8Ht3L2mifGiMF/UIS39oV+AWjDLQoMg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=p5pdXGUCjzXO2VN+FeUPQaoEvLjt3+FGVZekPLmOAgESdqgPogRNUJSh5PEhzsU8Q6ShC73d9gmiIcgQ9OB8gd6/bLOBqTCiB860R/AieeJKZbte63Na03vf0neyb4rPoc2uCVVFJgTSxR1hHsOxr47phdkQ0GKmP09ebknfYAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=Z678qvqo; arc=fail smtp.client-ip=40.107.96.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6CoVxJuK/N1mOw0SxbLt6eiexgaBawv+D5Xg2G8gRNtveaAyryb93Xf7n4EZPu2gUHLyKJ/xcZsv0O6wOpGxIqbHHOKrHHYuoqVsQoOy9VKuE6a3eC+ABX//CcPFyR+eF+j3N6acz5txnp5QaTrWMyXO+wNf5OhJNxx4hpFTKlKi4FegeNBbPz4aNR+HIgBJpSnlKZtpH9H1ItKmItHOPzwf/9NvXqT5AZ2dJnf4q1omOMoW2Ddc2wBmq3QwQ1e1mn/ozupYqwaeom7PebnLsVfV3m/KdGhPbRRzvY1iSsyl3uGcfMl4wYxzbP1rw+xaIUywIZpDxarwBKt/7+sww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1FGnnAd+yPz/N9Djok/CVM4Yzrh8j5PT71rbMkPspE=;
 b=U+RXP6B0Q568Ec8vWhd6bBeV073iByYyffd3O31Z8ro9Y1lcT2j/hwDvItm/KtItP0JUY6C/0HfjrnpaNDR5xuyqEdt6sh+PNQv9uMGHx6O9J06GfUUT8JBJELq35VYwpADxb5vWzD7yf/IeeFEjQ/yrJ51pYg5UoFFp76iIO5x/naP+LZZV+YoONcL1APXoi8Z+bP8GUZe+MIZcU0oqbuRJEF/LsHVxvGdyjREIyoXBPvmJ+qoOZZMZUqnwJj0blDliXDDLhH3BNTREUfqAoJ4p4LvtwEcnN7Pu0WTp9aGDX8TNQvvmXwhktag8AM2MrGCxFN86XgG6Uair/yHhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1FGnnAd+yPz/N9Djok/CVM4Yzrh8j5PT71rbMkPspE=;
 b=Z678qvqoB4UBpO+5icU3hridtiYymfjgOVNBhdnqrCGWe3ZBCMnoJsNGAkCbEvoTrtum6OXf0zx4WViOqVnDJhvURzWlzrqn4p39ULAjZQ/7/UvX8VklmFQV25xABKSdR3tke0uM9iN4XGTSeaVKnr5D0VjW/+q9uwgfBS5jwDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DM6PR13MB4496.namprd13.prod.outlook.com (2603:10b6:5:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Wed, 28 Feb
 2024 07:52:17 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 07:52:17 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 0/4] nfp: series of minor driver improvements
Date: Wed, 28 Feb 2024 09:51:36 +0200
Message-Id: <20240228075140.12085-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|DM6PR13MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f64407-ac55-4aae-1887-08dc38322f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j4ZAEOgsXTUmADTNDTOn8ZGnmjRafcfbV4+X27OHdu2vTd0effDugoVzt2/y7kx8I8oHDKFJ+xO5rLde8XAM/Dh+ksPrVDo3HTYWZjp3Gx9WAAAfxtOvXSHUoTWQ6TqlWfqNijasJj43NFLGcHehGfYjoyGjh1uiSiACPNr2NS1QqoVMXUSxU7iPFyien/pb4f0i8wMzABcDts11bQx6pULyDAzEDyiC4QdTeTlpV6X8uOunzkC21b9dKwYopP5YGY8eDxGz+pRQsHvx8dSmLcIkcetQxYa17MfSYJqhdfPT4ZZ11vEJYw4A7FEl0+sUwU0M0dDchPWjOKxj1IYkSTHrob7SPwauONTEish5bch/5sYJdK5yT+Az3BzR8X0B1XvedZB7vJVg7WrYWC272vd9rmVZ79auLRiqBKB4SSiAykkG8RjZPlRXWIgNi6NYc/x+abCxedA1y9Cr+vww4LhP5uQaVqERUM88MDcP7Hr3ti/t0/+W85M+HJbOP5jl9eCpgZPQYeXpJ+6QLlMTiYqSXKUnynqSxJGOibchXrXi+3qHMF6EYuLdVDgpuModZeScCtjVzR6ik19oqeJ+YWlkqL5DThyXh8b2sRoxQO0gKSrESuAxj9RgvI/lfOfYVhmnJCa3cQfc6/AF/VUfH73G+12ZuMjuIhoTgZNp0O18pw11Ol+KvA6QhpAtIutRnjt4ijaaA4zMadlSm3Gdbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hhEG2MfMmAM6G/c+JZ2P31MAxCznN805InrEqiBvOwLkNgej7zDs0GDKbVBc?=
 =?us-ascii?Q?HbKwr/pzMdWeWaGysJhV+q3qu++p8ekFDlRNO+AOMQaKZCMjbc1BICw/VkLV?=
 =?us-ascii?Q?k84nl4xMmO4Ts+0EjrVtqBRFlp3EiNiuDP7I4Iko3P09UnxreJiGpEm0WJJl?=
 =?us-ascii?Q?sqZEV9pF3zIKUjjmQPRGVOIruti+qZqat3cfYYGmH00RMLGdl7KL1k1yJ5Gs?=
 =?us-ascii?Q?XnHQAHCNvDXbu7Xri7VZAuGzarwV8Txsdj6Gm+JhZv7rn+KoLwO3CafPpQ0K?=
 =?us-ascii?Q?yGhNgEq13tEI3MZXNumN1xKD1A9jlqJhH5LWYWTddv3mHFgftfwTeqSqe3XJ?=
 =?us-ascii?Q?iHRD5D90jwgPO4bvaPYPlrxsrAUNMJWZqmeJQjW7ed4vFl8ATK6iBZAcJiAs?=
 =?us-ascii?Q?J2uN132e3cjWLM6cD7HCv+yNc7ssxXYHf1hcHc2gJ6u1BRxwu8XJOKSbRMtv?=
 =?us-ascii?Q?V+7psmm6L1HKV9nbwjJICEWNgj3xNQGsN43tPSDSamQ4d3jn+7hipd97QQwQ?=
 =?us-ascii?Q?dVsPeJQCM2tkMuEIufqlMuM/eocBB0CCIRpk6TDaNl4thr6QaarJ8/nByXEl?=
 =?us-ascii?Q?wOe3qYc5nNoGInjYEw8mC8Ud++hGIHuh5NG8z4uY4pgKvzQ02XhIsq8K0G4H?=
 =?us-ascii?Q?PNyqc8kB9kji4ehRxfp/2qyRWqcADTW9/H17POfdYgnHfR0U2smkoqMObjeA?=
 =?us-ascii?Q?So+bbr1PGR5oukInyXC9sTbjXH5LvtcP9/KNtyP8iyiNyPyuLFZKvu907h9v?=
 =?us-ascii?Q?Qa4uH1nMCXuVy2sF7LTCsF7SVra1ZtF0np1aJjLRdyeKloX9gd1wWoWkPnOp?=
 =?us-ascii?Q?Qx33K08OkaZzSu+ImzX73RUfp+1Pt6w8HvuqOUwigGwFoB+8gOBrbsxHDRGO?=
 =?us-ascii?Q?tOzrzJ5mztvE2/qUx1NZXlGjyIVoNyVAV+/fGC57sndxTESIho36Q6DqN6Of?=
 =?us-ascii?Q?mU2EvYeNw5qXIqVtPeLVuaQbgYNwI4aoLS9q6w3Zk7TMzJxAQw+pUtsUGDDs?=
 =?us-ascii?Q?nm6vMtvqXAgo+QUnifyZQFdWv+ougJJIfIoo1mzpduS9vIVxf9Uo785248yq?=
 =?us-ascii?Q?FjUkIXQ9oVa1aEKCzL442Y3hrO5hdXCEomlt1EoFWzMBslAYE8Iuvf39eKMj?=
 =?us-ascii?Q?1loNkt5XW1nkvJBvFCPqSUxJhgLjZ9Zb4R6eZQ0yckmPBa9OJomLtwlBldNE?=
 =?us-ascii?Q?eaVrneZciQVXO8xgjFl1b3Pyuj+9IbM7gQpJOmY4yDLOtzuVD5DQBVCh1Y3P?=
 =?us-ascii?Q?7h1JZ5wQ2m4igqCvFvOkZr/WFO6QDDECYE7CphrT99MRrsR/cLrkqVzM4Wdd?=
 =?us-ascii?Q?iFdkM8G9OG9+kafZtlkROANdePapi8aXCCSbd6QU8pEuZh+cHciAkgXwcwNc?=
 =?us-ascii?Q?Pfy1fx/GWFxfbjJVVMa7Y1jBmoF1+SVxvg15/AzKL1dW3NdY8W6XFak6dtUN?=
 =?us-ascii?Q?Tc5V7jSoETbNOEvXNjwILxgj3fvTds3RJsupGyU28FcEOjzOWEGoEuROI3EF?=
 =?us-ascii?Q?ywFwopJSWwPS8ZeKcEYa9XSMJ8nHCZdHp+1WzY7/RRiFTh1k1eP2c4zWJ+6f?=
 =?us-ascii?Q?CXF83oxUyWVMf9x4zgoxcf3MvJtKRkWPdzKt1wAiPq2WxvEpfzsg1Yfg2zg+?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f64407-ac55-4aae-1887-08dc38322f4b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 07:52:17.6325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tu5zRyfu5b1rCDjlTKBHnYud/L0OKn19Zm1Czazpt6RctnWWG+N7n/JnEDpIq6nSNWiOandqbR6vFmQTpXj5t3F6ZtnOrb417i0uZUgkeW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4496

This short series bundles two unrelated but small updates to the nfp
driver.

Patch1: Add new defines for devlink string paramaters
Patch2: Make use of these two fields in the nfp driver
Patch3: Add new 'dim' profiles
Patch4: Make use of these new profiles in the nfp driver

Changes since V1:
- Move nfp local defines to devlink common code as it is quite generic.
- Add new 'dim' profile instead of using driver local overrides, as this
  allows use of the 'dim' helpers.
- This expanded 2 patches to 4, as the common code changes are split
  into seperate patches.

Fei Qin (4):
  devlink: add two info version tags
  nfp: update devlink device info output
  dim: introduce a specific dim profile for better latency
  nfp: use new dim profiles for better latency

 .../networking/devlink/devlink-info.rst        | 10 ++++++++++
 Documentation/networking/devlink/nfp.rst       |  3 +++
 .../net/ethernet/netronome/nfp/nfp_devlink.c   |  3 ++-
 .../ethernet/netronome/nfp/nfp_net_common.c    |  4 ++--
 include/linux/dim.h                            |  2 ++
 include/net/devlink.h                          |  5 +++++
 lib/dim/net_dim.c                              | 18 ++++++++++++++++++
 7 files changed, 42 insertions(+), 3 deletions(-)

-- 
2.34.1


