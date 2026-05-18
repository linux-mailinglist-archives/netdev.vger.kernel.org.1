Return-Path: <netdev+bounces-289134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPNONwdFC2qsFAUAu9opvQ
	(envelope-from <netdev+bounces-289134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:57:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8560F57150C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4DE53016CE7
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C694963B8;
	Mon, 18 May 2026 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YoGDMmai"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467B49553C;
	Mon, 18 May 2026 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123436; cv=fail; b=VuPzlyIadmt66n0AMexpImLFT0biG/UimV7+azl3JoC1yXYa64SVrCGO1wRwFsMW+NvJbUbuv2+83igaJM7rdL00kFIe6iKywb8pgQA+b1PBttqL9aZRURJX660ILNswJqPuInC4PdrcDoZwD4qkY6etiFXulhS9S75EoVxixlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123436; c=relaxed/simple;
	bh=WB7n1ixxVR8hKLSS3POW46jegQ54eWm42zQCmBCDcLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S3fq8KKt0mQiTafuVAaBTd3I5WdoR7qMz60ga60h2k1/UesjRxEoF1zKQ6lkHvF19KQOgzj2c5m+Sb4Knpz3JG+/KDAsz239QSix1p1/xZLwCTqVNZDCkpVOy2x7lP0hUIz43GbZ8q9iN0ssZpkA8LoN59dl6bXiAUueUg2H3h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YoGDMmai; arc=fail smtp.client-ip=52.101.57.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cshQhh9JUqPueuD3EwBaxueTkxJj6Xai7JKhz5Y+PaZ6MKd6XW9wZUxwcAVEmvgJZJ9C2j8G76fpiOnQGxZNU2r4GOsZWd+57F6tMX1632QG0S9V4monjaapOdMzV2mncBzv1SVDl7geD3s53oRTj/1i2rT70EyzoBYGf6Kz88E4okFmI6uR4ocK+F412dc8EQfd5auHYVADfokDZGgt3PkmhW+LBUEcShpr0hDVjjtNgOtPSO8AbhFuNcmQHbqNnA86UWCXIlAEEhLnneAPdNRPdD2LGtT5gvkjkRfeWrOb1IAgxQVdNDgpwUUznePb3MNr6HqMFkehogkaPyGQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2g74nGbQIqE3BjRdt00rnG64vJoESHiPf9+kTCqK6Y=;
 b=iOBpyr6q/sGmE2npJHVNDwqpw+Z7q8SuSp0h+86subw95i12L4x3mSHNWdyxa8ca2Ak9tfDolEad0OJT/iF702MfZahsuKK+tLNldje/lucY34SihgyHHIIYMwVAfH5hRgZke0G+5x0jo4fyHHxtrekU+4ZDywl0xAkCWWVNtFyfv/Vhto8Pg5dIHJoJ/+Rw7dipeCvJ2jWqv6c1XjINqqamJOJvsV55+4+h4hgYmhwuPtQ2eDt11IVQxcotEJIfGVyeaFS0VsjmrTLjCNN76BLg7zn1z8tMFBDAQRMtiLe76VEBUH8tLFo0SMUfjaeXYc9UeI8LrK2jRkosHjeO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2g74nGbQIqE3BjRdt00rnG64vJoESHiPf9+kTCqK6Y=;
 b=YoGDMmaipP6284OMbDTV6sF66FKKwryU3FjFlBJtw8erbitUcKaF6I3AD1eRz7M0QmYxWFEq7+jS5ObPcvgqpoUDx1HJN4BSMId6ZT/yamvgg9g5SS+AIc/6TLt9meKvgKJSxvzg+l6RjmLmAmKo3Es5tgkmQS/khiKEKbeFz2ztGDc6UyQAM4pOOmIbk5tgOD4RMCoULRLBz35R7igJnhqH6QyENfRpgD17bFH4ZNTK+19cBt1DGBu7zU74XxnVvOpHsvk8SKLwabOlIMGL81Q9nGsU2XD08SmAGNspusl8zJv/been4qSlcE146QKuU6aQMfkba6r2NTpLeVHK7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 16:57:09 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 16:57:09 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Roopa Prabhu <roopa@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Chirag Shah <chirag@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] selftests: net: add vxlan vnifilter notification test
Date: Mon, 18 May 2026 09:57:00 -0700
Message-ID: <20260518165700.1975478-4-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518165700.1975478-1-aroulin@nvidia.com>
References: <20260518165700.1975478-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:806:120::32) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd051f8-566b-4d7e-1ecd-08deb4fe7ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	oU1pyJh3M8C0c0hpsESyj+PME4dQRPk/QJMzmtCOVIdbO7UV9pGyjoGCwA5HGi4JVYOe3UP8dGwmKh9l6hWaf0ZupC52TE7vDqPz+OlD0/7IEdhE6SQ/sdNKLYubXLPyLiBq6+p3XuW2LbbRkN2BhabDRFzRWG1mar0ZHUxzz3C1uKqTy6z2XL+tBwCjcpFH5GJfLwJGg1hgaTEbFIgxCoGUIc1NnlkxfXTxlT0fVFLfIwdvBHKJ08p5bodYYRv2pLdQMU8ivwAEHXPaJ3QLCUTPnlS8UNman3UvIew+S4Lf84HvKHnYWa+IwfocflaS/pmdXSaq/21dxwxt6iqUITT3NKc1welYn2QRImebJqmVtW+DrygOfompwuax5V9ZvX0oC7mMVnOJkMsLA7BWdh2v2MOocMVsIxIfI7ILCdg0kblFR6tgXncwXzFSFY5qQvsM1i5KsAZYA1RVurwGh7pEoYrqjqeqNfNI+o4yZvMDbeQFhUrlg0dYRtlz6nY/+SGZ8t87+G4qHarZeJWspf4RnmU8Y3n1SnASXCOWIuH78wSc1Rx0Br/9qIyqZi8FLSkaz27NcN15cQl6t8QH4GqvPM2MK6OmQXm6IHP/IJakSPSWaQ71pck0v+gJ3HO+ywX10bkmKN6SkmnHVFP4qlFbBrJttLtUBZcYqBuS2pRRYzLtluLeu7gvaXXmkSOo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x7Ed6GiyHHkMpAtswe0ULhLs1wxTIMsk6o1ID5gAyJ3Qb/EP0Y/yM9A1bZ9C?=
 =?us-ascii?Q?Ym78ySIGiFdPexExPcnv8JQYZjLE/yjSxmlbe/OQJcOxbf7tdTtzWfYnelRH?=
 =?us-ascii?Q?BTstpVansPNlIWZNWxjrtg3TUv/rZhlnZwoGmPoPgyg+svzulKstYI9wmdUv?=
 =?us-ascii?Q?OFPnGtbRDftQYvAdbN0VO1xrjnFDA2VD9obiwGUFt+gwaX63ZjN5XCSMZtVI?=
 =?us-ascii?Q?F0WmrGp4s4HNPkF2PnyZtqHyZbc8/iCSMS3gi5qqmHrY/u75rjMKgv9ctLkb?=
 =?us-ascii?Q?03Uh4JnfwTEL0V3QST75TvwRruIP3TsCcobQvW5GzkFoDrNxzcSK+ZnVgG6v?=
 =?us-ascii?Q?wuXn+sSrtqEYcGiLlZOn6diEq1QmkQPBpn3FEOLD/7K+FiM30cWargBDO6V6?=
 =?us-ascii?Q?dFgfAFMMeLT3PthSUUmv59iKl8VCcdOnOEXQQJKjs1zVOH+9upUNSWAkJbSa?=
 =?us-ascii?Q?gFVC+4KiCJiw55W4XfONh6H+d+ErxV06b94F+vfNzTbPx0Tv75Pr1rnSFyXf?=
 =?us-ascii?Q?zwUm3HTuAUAgbHFv5xIeL1phrq0LnYAtt1LAx3RGL16uMRAW7tM2lVPW4QG2?=
 =?us-ascii?Q?o+P3DwM7hsRUE1DVGxrWDjmJjytI2Lj3Xt6LTPhS+v1/RCnDyujtRexRY3vi?=
 =?us-ascii?Q?6nvo4ZRplra9u3/RlvYR12UE5eUxXCPeQQj5dzSgAiZR12Ufb6s3Ww6nmz+B?=
 =?us-ascii?Q?sJMdb0q6XsMWRqETNOLdP+5dGNwbkVOE0NblTQEUbbwxaKQweYP1LSZpwIiF?=
 =?us-ascii?Q?2wNdlV1hJvDz8eEgWPS0xP2hTEhyusVDyDbS8V5QjnAFRRaVGKvxHGct96vU?=
 =?us-ascii?Q?ocfpcWQgNhJUqPbXFKHuehozuimfguQFUia9fJ2d2/f2bJBq+gscQ8Z8u/9Z?=
 =?us-ascii?Q?vmvR4b8ugY5t0v3XbbggZ+dycTjr/ibR8Hcxf7VGcViFTdlVsSbk80RBA817?=
 =?us-ascii?Q?qm1cMg2t6Ju+GKW22W12ESq0iRpuyNdOmOUuyMXzCeUpmSZk7QO3XpwjWclg?=
 =?us-ascii?Q?PtpA6e+iKmzSKKMHSGwO7D3y3W/mJKPEmHxrc5egO5sms4BfSFTT6EjZ0Eyn?=
 =?us-ascii?Q?YSxZKu67nlgnAX9jIXe3rw8iGDeISWQPCiYoosCQK/0VfFDBQE1Wn6IxjWYe?=
 =?us-ascii?Q?/6MpwwmJ25TqIboNAbI331cjIvSBhXtO23fB2+7JLgP5ZsLCOt12l/YdykLs?=
 =?us-ascii?Q?Gsf7/8xws/G4oixNTMGKqv1/LAQsXwa+hwCproN7/S+AF+sXwVNaeyGm0Prg?=
 =?us-ascii?Q?acimu6TuL4QYgURzLOfRTEGmZHf7qjIbaXQ/Y2bmvc2em9G0i4Ksk7IymVjH?=
 =?us-ascii?Q?Y818fGrTLiZyZH4t1WwqicQlRvuzEPJRoCbA3f7dhBseF1vZdkrCcxFqHiFi?=
 =?us-ascii?Q?A8F+GM8GqGjTG0veQ0+lBkru34GO/pNyCfiDd+Pcxs3UO6cwlC2QOaYQicpK?=
 =?us-ascii?Q?QSX5vVSYfG/rzPWWROIxuH0HLm6FMtqTxAKdhOWcRT28xTqSZ7BDi8x3Ri0v?=
 =?us-ascii?Q?At9+XurmhiPywMVm3jVAxLQLA3x7K0fS8oXggOuVlDwn2DceS4360I0PcbPf?=
 =?us-ascii?Q?91uvF2BgssQOqFZdWhzI6zT5CwNDsnNlEtIf+BwNXMC57vikFAAIE9Q9pRO0?=
 =?us-ascii?Q?mR7MzlnOFGSPlhwZyvya4jhaaN2nUZxdxb9ecLPeiqdvgO/2AiZTJIiHHeQu?=
 =?us-ascii?Q?bBHE91qTadTFu+U0eIoaNPm43KV7IkeD3AaQwpyGnMbfgUfWkyUWEVPhdRGj?=
 =?us-ascii?Q?Je9cN/ZUMA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd051f8-566b-4d7e-1ecd-08deb4fe7ff0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:57:09.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87P4Xjg+wj05f9c121ALIyJ/14omc/vdbYW/mIp0cRbrodnppbPFRoSZjX4VL6B2JzFTe+rEhwe9bzu1qWvY1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289134-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lib.sh:url]
X-Rspamd-Queue-Id: 8560F57150C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest for VXLAN vnifilter netlink notifications that verifies
RTM_NEWTUNNEL and RTM_DELTUNNEL are sent correctly when VNIs are added,
deleted, or updated, and that no spurious notifications are sent when
a VNI is re-added with the same attributes.

Signed-off-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Assisted-by: Claude:claude-opus-4-6
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../net/test_vxlan_vnifilter_notify.sh        | 175 ++++++++++++++++++
 2 files changed, 176 insertions(+)
 create mode 100755 tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5ca6c557fc3fa..6a190a525a391 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -109,6 +109,7 @@ TEST_PROGS := \
 	test_vxlan_nh.sh \
 	test_vxlan_nolocalbypass.sh \
 	test_vxlan_under_vrf.sh \
+	test_vxlan_vnifilter_notify.sh \
 	test_vxlan_vnifiltering.sh \
 	tfo_passive.sh \
 	traceroute.sh \
diff --git a/tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh b/tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh
new file mode 100755
index 0000000000000..afe1036115fd5
--- /dev/null
+++ b/tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh
@@ -0,0 +1,175 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2034,SC2154,SC2317,SC2329
+#
+# Test for VXLAN vnifilter netlink notifications (RTM_NEWTUNNEL /
+# RTM_DELTUNNEL).
+#
+# Verifies that:
+# - Adding a new VNI sends a notification
+# - Adding a new VNI with a remote sends a notification
+# - Deleting a VNI sends a notification
+# - Re-adding an existing VNI with the same attributes does not send
+#   a spurious notification
+# - Updating an existing VNI's remote sends a notification
+# - Deleting a non-existent VNI does not send a notification
+
+source lib.sh
+
+require_command bridge
+
+VXLAN_DEV=vxlan100
+
+ALL_TESTS="
+	test_vni_add_notify
+	test_vni_add_remote_notify
+	test_vni_del_notify
+	test_vni_readd_no_notify
+	test_vni_update_remote_notify
+	test_vni_del_nonexistent_no_notify
+"
+
+setup_prepare()
+{
+	setup_ns NS1
+	defer cleanup_all_ns
+
+	ip -n "$NS1" link add $VXLAN_DEV type vxlan dstport 4789 \
+		local 10.0.0.1 nolearning external vnifilter
+	ip -n "$NS1" link set $VXLAN_DEV up
+}
+
+# Run bridge monitor in the background, execute a command, then count
+# the notification lines.
+# Usage: vni_notify_check <command> [args...]
+# Sets: NOTIFY_COUNT with the number of notifications observed.
+vni_notify_check()
+{
+	local tmpf
+
+	tmpf=$(mktemp)
+	defer rm "$tmpf"
+
+	defer_scope_push
+		ip netns exec "$NS1" bridge monitor vni > "$tmpf" 2>/dev/null &
+		defer kill_process $!
+
+		sleep 0.1
+		"$@"
+		sleep 0.1
+	defer_scope_pop
+
+	NOTIFY_COUNT=$(grep -c "$VXLAN_DEV" "$tmpf")
+	NOTIFY_COUNT=${NOTIFY_COUNT:-0}
+}
+
+# Adding a brand new VNI should produce a notification.
+test_vni_add_notify()
+{
+	RET=0
+
+	vni_notify_check \
+		bridge -n "$NS1" vni add vni 1000 dev "$VXLAN_DEV"
+	check_err $? "Failed to add VNI"
+
+	[ "$NOTIFY_COUNT" -eq 1 ]
+	check_err $? "Expected 1 notification for VNI add, got $NOTIFY_COUNT"
+
+	bridge -n "$NS1" vni delete vni 1000 dev "$VXLAN_DEV" 2>/dev/null
+
+	log_test "VNI add sends notification"
+}
+
+# Adding a VNI with a remote should produce a notification.
+test_vni_add_remote_notify()
+{
+	RET=0
+
+	vni_notify_check \
+		bridge -n "$NS1" vni add vni 4000 remote 10.0.0.2 dev "$VXLAN_DEV"
+	check_err $? "Failed to add VNI with remote"
+
+	[ "$NOTIFY_COUNT" -eq 1 ]
+	check_err $? "Expected 1 notification for VNI add with remote, got $NOTIFY_COUNT"
+
+	bridge -n "$NS1" vni delete vni 4000 dev "$VXLAN_DEV"
+
+	log_test "VNI add with remote sends notification"
+}
+
+# Deleting a VNI should produce a notification.
+test_vni_del_notify()
+{
+	RET=0
+
+	bridge -n "$NS1" vni add vni 2000 dev "$VXLAN_DEV"
+
+	vni_notify_check \
+		bridge -n "$NS1" vni delete vni 2000 dev "$VXLAN_DEV"
+	check_err $? "Failed to delete VNI"
+
+	[ "$NOTIFY_COUNT" -eq 1 ]
+	check_err $? "Expected 1 notification for VNI del, got $NOTIFY_COUNT"
+
+	log_test "VNI delete sends notification"
+}
+
+# Re-adding an existing VNI with the same attributes should not produce
+# a notification.
+test_vni_readd_no_notify()
+{
+	RET=0
+
+	bridge -n "$NS1" vni add vni 3000 dev "$VXLAN_DEV"
+
+	vni_notify_check \
+		bridge -n "$NS1" vni add vni 3000 dev "$VXLAN_DEV"
+	check_err $? "Failed to re-add VNI"
+
+	[ "$NOTIFY_COUNT" -eq 0 ]
+	check_err $? "Expected 0 notifications for VNI re-add, got $NOTIFY_COUNT"
+
+	bridge -n "$NS1" vni delete vni 3000 dev "$VXLAN_DEV"
+
+	log_test "VNI re-add does not send spurious notification"
+}
+
+# Updating an existing VNI's remote should produce a notification.
+test_vni_update_remote_notify()
+{
+	RET=0
+
+	bridge -n "$NS1" vni add vni 5000 remote 10.0.0.2 dev "$VXLAN_DEV"
+
+	vni_notify_check \
+		bridge -n "$NS1" vni add vni 5000 remote 10.0.0.3 dev "$VXLAN_DEV"
+	check_err $? "Failed to update VNI remote"
+
+	[ "$NOTIFY_COUNT" -eq 1 ]
+	check_err $? "Expected 1 notification for VNI remote update, got $NOTIFY_COUNT"
+
+	bridge -n "$NS1" vni delete vni 5000 dev "$VXLAN_DEV"
+
+	log_test "VNI remote update sends notification"
+}
+
+# Deleting a non-existent VNI should not produce a notification.
+test_vni_del_nonexistent_no_notify()
+{
+	RET=0
+
+	vni_notify_check \
+		bridge -n "$NS1" vni delete vni 9999 dev "$VXLAN_DEV" 2>/dev/null
+
+	[ "$NOTIFY_COUNT" -eq 0 ]
+	check_err $? "Expected 0 notifications for non-existent VNI del, got $NOTIFY_COUNT"
+
+	log_test "Non-existent VNI delete does not send notification"
+}
+
+trap defer_scopes_cleanup EXIT
+
+setup_prepare
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.43.0


