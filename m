Return-Path: <netdev+bounces-85101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C792189979E
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEBB1F222CC
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862114290C;
	Fri,  5 Apr 2024 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="rBJWn4ga"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2121.outbound.protection.outlook.com [40.107.243.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF72142E60
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305024; cv=fail; b=IpsXEfqx7A5PN0dV7/dcDivTHOnAXopmofgTrVcwut9RZaLF4KcWe2UY4nVcaeuRYeHFutwvCU8+8480CaYUOJjsd3uAgigpaoyXwGvOJyyG7XnNBG2syRqEgj1TXPzDAab+wfGd38D2kNZ6idj6ArDubjFrWz2Bqt2SiRnccbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305024; c=relaxed/simple;
	bh=d7sh8/py0WsAC7T9j3jNfy1izgYJpLXoIrUSMeFAUCs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VCXfBAThtg3ff1VpDtXo8rw8IFSbqPw4l6KsvXQaKMaZ/nYKOtTLVA6CdqzNLdC0XTau5zTksPxsU6oYvpz9nTRFdtCDLD0jB8lVrHkeKoT9oscXAKO54eU/fCNZ4XGW0VeQIbmCV2Wsos5RS6npr7nO4M2jMJpWcKarOb1JK7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=rBJWn4ga; arc=fail smtp.client-ip=40.107.243.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtDRg98Jv2qIa0j6BlAOW8pv2YsLJ/8ciRvC8Sn2AT/NqVXuJRLAAu4r5Lw5AwstcDK8zCONKS5OA+FAOeogBOIndVWDJB/dpgWK+NCk2RsqfUn0NoKTPtU6ujsB+lwGWCtdgtDKYUwIFrNYxAnf2togsgGmwA4kqQNK/C4tsn3tInrynEeEYlaWHjwX4MzaBWdZm3Oqq/4pzRzh/0sgxZwly1M/Thj3pTK22G6ztXQ2ADwzdXT5a2Slm0fGLynd9gPdLuv7myxh3rYC4UXhIXvDrF6ZUeTewGKAcOHAx1d+UtbgBvXFcKrB2NOOl+OZgCyn+OcxayHrRxFt6ksklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z78t/G2gyFn+5FBx+3UqDu+ki8TBvMpIJLYoyo7HJcM=;
 b=R0MjvbKiT45m9UGNUy5R75t+yCFdkARgfEDkMTvtmxB9P998GAUAIlvYEZvSYBUdGYJewhen1dehs7dy3SROciOnRKNOSnhTul5iGY+GM73NypYtb7gsPEWonI5e/1QBJ2NPWS8e5suuRqeXtPfXx5pbbGRxNZ70kgcEXsJFlCunlzK3oZ4kQSH+97co+sWtrBjC/EJlZswTWBD0fnKZPx/PsdTVciYb4n2hiFOIwerTRI9tsvhx6/jtOOeH8dt9IdiS9EanJYRNNYHlrDYieTy5LAK5n7ygGivSXmGDBTLxmHAnm6x9+lUQkGYGtL0d2sXhp3TsEo5xuhY1li2HcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z78t/G2gyFn+5FBx+3UqDu+ki8TBvMpIJLYoyo7HJcM=;
 b=rBJWn4gatHBghCjsadM/sxGZMRYnkgx8TgAmmpjcFPBRvFlqOYgFaR6JSKfXpcjEtKkPILP7SKH5O5wOPraLfYYPEx+/cKMNbTq/F0AsOKgqyRvqMlcT4INR3IMmf8pl0dLn0MV3knSCbuUKALGSiUT7uYsR2My35MWvp8x/Eto=
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by SN4PR13MB5678.namprd13.prod.outlook.com (2603:10b6:806:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 08:16:59 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 08:16:58 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v4 0/4] nfp: series of minor driver improvements
Date: Fri,  5 Apr 2024 10:15:43 +0200
Message-Id: <20240405081547.20676-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|SN4PR13MB5678:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W5BbohbJFZs5J5jaTtLPVTZFgnYS1Uk+tE7Y2FB7luoh3hsWorbUGkVLzhpcEM1TVF9e3qIdVCNx+bCuUyK5nSqzqV752ow6wENy6GZAb/5egBC8ER3hMF+Faf+NJWfuXWv4XAyqEkQmfNj3uIGkB8SvsCiXwxfU70CE7S7+vTKbM6FKtVaRoqSP7tVeUpmVEHtqQcxfIw176wCahBxvmg1wXmilv6+eTENCSMtlFRQM3WjWx1qf5vvgOJO3YOy4drEECtNjIz0c0rr14agZ5KGyjS4UI+nC0CrzGWKuyrxLFNL/M4xYFSrwFY9gXXJ5NZesGLOm6J0dtt/6sFcd+PLfD618uIh8w3QzvyweBY4s9FAsPkoGML0P2ncT1c1OR7tOs2dEJX3GMAd/diA33KgkTZKs9+du4WETyN/uh0Ar6CPmx0Ntq/FHoXru18dfm+DhNkC2cLYrEvQruK9gf7UbqVfOKgr363W7BYpLq32ZlGbc+FVW3K+bW6BiN3tTNNq2vuAmNqpNGrgNji+7cerHUcood4W649cw5SaSPjaOW03aBZj+NBYWZ6BDGnipNZS6FQ+vre7iob/CINcOSJtI6PAXixSogNIfp/wdoAh99IYn4a0z8CnIeHxX+/3/ulQRi2ZHJba1dNSEJK+6Vf9btM39VWMKah5/WCGqG17FzNqrPkv6HM2EVQLKM4fQWPHDKZErPVegyOl2iHRUew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n0Raa3cAXDfHgmDgjalsx8AbqtCz7MVqdTBwKpERZNkpWypcVTPX7EW5K5xe?=
 =?us-ascii?Q?GJSYR+Ttfxk652naj6YhjHGLFjnfD5KAnup/UMRDqAuNQtDyZwWISNrzOXTA?=
 =?us-ascii?Q?aXHIdnTSkvXrWzRzNdTR+ZWYPgR4QpCxg6T94TQeQjXJq6NPqKEYsLGsX2je?=
 =?us-ascii?Q?/sS9NOrKA8QdgvhbemH7lIJoz3RiaB9wiLOTGW18BRLKq/qkSFnt23eQJGr5?=
 =?us-ascii?Q?wnlmD40OKeqjY7vZsvK30AEmLnMGklkOotM/rVht8CQ2KoxJTugbXr6lfw01?=
 =?us-ascii?Q?euPEKejbRVCkICZNE+49JfkMJ2hv794MzzETcF6679i0CtcJ4xDG9xYsv2xm?=
 =?us-ascii?Q?WxyzuSUBFdJ61faUyqszHRG6hJILb6n7d86C9dem4gvcJIRBvs+sXdVJ+/Bm?=
 =?us-ascii?Q?1Ss7RDF2A7G4C6g36Amdb6xUtjXDWwsQzgEygfME9+6ZOAfxJqOTCFoD1hWY?=
 =?us-ascii?Q?7kYdLbDiegsXIgmwFwV3VGIsLckViitzvU+ySLpBsYiU2GJb1yv+VP4TSBjj?=
 =?us-ascii?Q?6n8tD7ZlDYdU1zwH0zyHRTDqESoUZju/c3H+Zl/8oTNAsY7Mgs1yVOoSSInC?=
 =?us-ascii?Q?tfiPa2vuJBqgFwnpxd9UOI5It1k28E+lQD2vxKHMg43WqUUUS6Od7qCmPQN4?=
 =?us-ascii?Q?gC9hgIObCDCR3hQhZx4dIGRShrJE6hnjlrqptLHdxOXNl7RQ2Ec1jw6k0wJO?=
 =?us-ascii?Q?OsuSnNplYfFpLlNZBpsripaP8LsElF0Xho01ijYejrYTm4WMUOVSedWjarfF?=
 =?us-ascii?Q?/EMXXmSaxuIgjtCzDkT0YV8OxzbPmWDYJ/zqYDrrUU7uWp50bfGTno/mLkY9?=
 =?us-ascii?Q?jADrnZjm5TzydibmLOS3gDx3js1db8FPfGfUXO0t6jnKydClrbM4semRPKip?=
 =?us-ascii?Q?FZiHe8NvhNOV1YJYAU5kN27E8xXlbSe6OJvkYm/fzl4tfAbefgzzbAiEnU8v?=
 =?us-ascii?Q?Vr2YN+8SRegIi/xQVk5TiAIHcvLD3OMHDFaio7zMtW3LNRG0wbP6nZBySLBp?=
 =?us-ascii?Q?meviUqr23/jYMXeHdmU/AqL6K2A6TFleqUSG9CkYVQsoBKt1Whr0YZh666hc?=
 =?us-ascii?Q?qHfnl21cktkn6wvRIhFUxY7YcFBnBeqO+241Jbli6vo9rfq8gg429/xVFQ9j?=
 =?us-ascii?Q?GPePfuNAHU2HsVn/30l7IOtjR8Wj3LSSIkuC6vKfI0gbIixF6MJH9i44gaaj?=
 =?us-ascii?Q?J2jZpgKGfvU0r8i1cN/VRRhxdjhLwNzowQ4ckPjLpwZDsLpjQ7qX4J/nSX4/?=
 =?us-ascii?Q?2Waomo5svav9CD8Spkh7ZTQIf5SDTT+tAlaBXftgH7UIqV+9haXsVPwJtpjY?=
 =?us-ascii?Q?WKRPbbLcj+Jn6KDQ3LkMadWqr92n7l6HzQcRxrr2nviNeNCqsCjm1GKiKkMM?=
 =?us-ascii?Q?pWxPDlCW0cP/hQ7+Q9jAp+b9crAQICUHfVXVFHTSFhrWD4SG7MUkhKt7/zAq?=
 =?us-ascii?Q?qTFeW4W7zdgxqB7G18Evr6AtJW9T3UB2RVi8bwelYLbFXhYc2JgIqQH3myU6?=
 =?us-ascii?Q?9pHh126sfOJeybe0Ik9fV+UZwNozTGhxTsX/t1ZGzGw6jAYRd3D0edkHP7U3?=
 =?us-ascii?Q?qWrm2V0G9b7TokHIgcqpYNEL7E1LLmInIPsjiewbc0eN22wWuqvccrNCoc5T?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c378747-93c8-4070-278e-08dc5548c390
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 08:16:58.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeLFvra69pTgVHaBWDFQLaQqsqESVoSBpwspdhzinAwtJ3uu5OpIikHiyKH8DXiLQIkQYepVg6mEyUAMZXrtphjhr5GdN+kXrIrtxRCkbC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5678

This short series bundles two unrelated but small updates to the nfp
driver.

Patch1: Add new define for devlink string "board.part_number"
Patch2: Make use of this field in the nfp driver
Patch3: Add new 'dim' profiles
Patch4: Make use of these new profiles in the nfp driver

Changes since V3:
- Fixed: Documentation/networking/devlink/devlink-info.rst:150:
    WARNING: Title underline too short.

Changes since V2:
- After some discussion on the previous series it was agreed that only
  the "board.part_number" field makes sense in the common code. The
  "board.model" field which was moved to devlink common code in V1 is
  now kept in the driver. The field is specific to the nfp driver,
  exposing the codename of the board.
- In summary, add "board.part_number" to devlink, and populate it
  in the the nfp driver.

Changes since V1:
- Move nfp local defines to devlink common code as it is quite generic.
- Add new 'dim' profile instead of using driver local overrides, as this
  allows use of the 'dim' helpers.
- This expanded 2 patches to 4, as the common code changes are split
  into seperate patches.

Fei Qin (4):
  devlink: add a new info version tag
  nfp: update devlink device info output
  dim: introduce a specific dim profile for better latency
  nfp: use new dim profiles for better latency

 .../networking/devlink/devlink-info.rst        |  5 +++++
 Documentation/networking/devlink/nfp.rst       |  5 ++++-
 .../net/ethernet/netronome/nfp/nfp_devlink.c   |  1 +
 .../ethernet/netronome/nfp/nfp_net_common.c    |  4 ++--
 include/linux/dim.h                            |  2 ++
 include/net/devlink.h                          |  4 +++-
 lib/dim/net_dim.c                              | 18 ++++++++++++++++++
 7 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.34.1


