Return-Path: <netdev+bounces-261770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGM1CgBeoWmksQQAu9opvQ
	(envelope-from <netdev+bounces-261770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:04:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E8C1B4E29
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 293673087E25
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611C838BF64;
	Fri, 27 Feb 2026 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qoPXmVvg"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ECF36BCFA
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182990; cv=fail; b=QZAFzL1QQb2fghiWzztIsAzNQaP5zLs/s01hBkE0J3DCKRZneXHsyJs2hewjUWi52HaeIFFvrToBPmTEmML6sOxGvGUM5vVrATmkY3JQ6djNKYCYqiWpFM2ETLecPCBGVRyujKPHc48Lchex+uUD5eMbv2+/o1AlzQ5xvccu6Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182990; c=relaxed/simple;
	bh=PVhLMmylRGSUJHi7cO/zuAS8enwtCrNFDoHwc0coY/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B3mQBqw+5cj67dl/nXXZ5srdsWY4/aoVVgMWIV0ZogVsDPPDhhc3GxRR8j+ikbZGvuDkN+XB2eQOo/WQJH3YMedA0OHyVUz3VbZYeF5YM/eLU5bfGbPcT/SYjeebU0GZVLA2mefiQ2pwt1Bo9Ay+nvIM49DmnXrCv1oc5PJprFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qoPXmVvg; arc=fail smtp.client-ip=52.101.48.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bagwIOJlXq99o7cE+O4a6WjqeKR4CZJkKakDewRq+SrZDcAayhoWPSOrkHErEhP/QNRViZ4BnCIlNmC7kLuBAaSbu0qawDjRDE+qId1Bejfl8Gvo9HoJvsuVJu9Du81hOcF2RW0pwjgHUGUOPcci/kiyxgO1w51hHqTmya+qBtIyTNN9ugAHeZ3Pgsa6GIIBPV6y9luKsm8ZZI9mLDTwM8bPdMwNEnjPOe9nZV+XQcgnHCyRKoM4uDUDEU9VQjdAcj7eG+AosBEfxPfjroH1b9GhCoFWH6TdiUscpTOIiUj5nkGbCRtx0DfQ6d+lPnSqv9WmJqYN+68941aH7ZalQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2oQbIKIbeqQEiZPehK8/ztRKz0+u7ZvYpSlk10I1SE=;
 b=FXi5HgAdubhvsLn+QU8RX2U+G/MHwNVPG6m9hvXUlsoOfyx8GAaGFJQ4S5ebhpl6AGvw2oMpN9kzo6kAZMVO4LEH8TwSvqIjic0liiAs4RhzQ23r2KxAEQq5Ezi/jJnHGUEKOzUE0oZ9/YrJOroA0ehmWVzojIETht1QtiWrKRYikg2z6pYCLBt+Raf+m92SMFhE8AnvZQldx8Nm9bokX/rUwfG15WLrML81y3m1Tvln/PeD07Id/EeGKCnNyKOBNq/g7RbWOfGwlhSR3rDYVLYJwWheDbImJWRaoOAXvWiojuZCKm0ov71R2dABiLn6e8yQb0oj1/VsI1e4DPdwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2oQbIKIbeqQEiZPehK8/ztRKz0+u7ZvYpSlk10I1SE=;
 b=qoPXmVvgRKxrixg86jxZ2GOJFbYMqXvwJ+BawfvpqDsYBzDCVEWS0A0HSif2YU4PdarR/hRED0ewWwphe/oUI4J+pVrtskxzZj0M3garUgrwwXH/s0M167ZUDAQvORIAn65kgDT+/JcMDB9QM4QPvDyjSIkvTFiNo+Xqb7D7BGrnIHog+Mp7zR8HenkQAJLV0x2JtMqCCG4A92df7znTWNL+MbXZZKpUuWXv8y/BeGwps+5Vag4BB4zQ0r/v/5ZPhA7CHO2YJ7sRvfLirCZjS0k0hHcYOrB83yxjdQeH4J/sx3cPqU0lnQLroA38me1/7px4b24eNrTwfGlyZ5zN9w==
Received: from BL0PR02CA0028.namprd02.prod.outlook.com (2603:10b6:207:3c::41)
 by PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 09:03:02 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::ce) by BL0PR02CA0028.outlook.office365.com
 (2603:10b6:207:3c::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 09:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Fri, 27 Feb 2026 09:03:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 01:02:47 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 27 Feb 2026 01:02:44 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next v2 0/3] macsec: Add support for VLAN filtering in offload mode
Date: Fri, 27 Feb 2026 11:02:24 +0200
Message-ID: <20260227090227.1552512-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|PH7PR12MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb2d3b1-4a22-4e9a-090a-08de75df02fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	mhT3PyfRYOpZY7nzFknLFnvEhNzAE3tGscBsk9o/MyYyX0YJMvAc77n66lAgzobyFr5FWmgoHsk2AnM8C1UKPCIPIMq4+43m5y0f+Wut6E7ciTzK6t0csdn415Gi5zvpdEGgogj0cysO47mytAVibHxOnkgrXxkvdEAvCTZ/dcPw02bjUrYQT4aB5H/mOrEenBLHCUylcjt61H+KVX60Mk2xbESNC4nL8cGbk4+kIOf0crvJ9qyCIDHVy2PRyy/kipxMhY2T8ZgWalenoGKVDN3MjaSlrgYvBzsEigLgvAeN7DUbk7wmsvt6ewH5qJpRrtShzOdrIKJL0h3Dguc+vgga1aK6nDj51/rHkwN6/EoDSBIa1n8Hd41fHk6AjPc81JbaHYg+zvXI90f+9OtIfSLydjZgotNcL9dHQ4SAHFNgOJ8WylmkNzCjD4D+ioDGluUiP5VZmBbcls7xcylDQ69Vol6w8XPiD0WsYF2DKk1m6z2vxDBqx8delINZYQd86iiZDwwyOYhpz7og/sJk5gux8WdkMKc0vQ5c5+WEltEspGVhYNjVJ7+4oNMe+Pum+eDlb6ctWsIRRCTbBUL/A2t19xsdmJkhO8fhv5zPLby1Zm11r3+NyxdE4ifdf7OLR+CjMyS3gZKdlBnQ6519RamoPBSElgmE/XJ9+wi+gKty1G2eSpUKcRVK3cHBTTp/yKPf2XHr5kg/qRyxoU7ICpcDsdZZRKErtPgFX5JkR+jgZ286MNGvska+8QBySX/1qfmXX1wQQ2dpnFlmDMW/8wuL5my3cdHdbvvFG+tnAzZ+9tUhbd8KiIu2TLfHz+jjVmJ29ll5X+IrMZPUHpmzIQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r8qBTOIcMLh3x3O20vzORN4r96ZZWpLyVa4vmnhJlc2SAHVHwJS9i2Qm40u7WtxTy0q2/t6eFfJTrxssDd2eh6Bw0yClpzW66ojyha7cgVgrL9/mPpb8KSbTwCm6PB2AIimHBcydwfCoGPiwcDFcq8guhEmB/Cu3A+MUNV4044+xkwaC0V+xXSAW3h8yUy07d1N/2/QXSvbihJaCbWCOBuRp7xvCoFyQJJ/+WlkZBiNoqIBm6G1o9RKnFAQlPXf+2vbHo8az+KDBX2LWUh7igdHxgn8FfhzUps4JIFdEw+gLbhCTcTMHXwGXYXfhVy+BdmeXSwkz2aPmIQ63swWcTq0CdicMqVueVYzniKHUjzg35mjD9wwg+xfwQCmA+wZ6lX3V5VMqmZV2XXRaIqKoEY6L/d48A+Gc//CX8PwDeK14Ot1685U0T8YuSDWzKwoB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:03:01.9546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb2d3b1-4a22-4e9a-090a-08de75df02fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261770-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 99E8C1B4E29
X-Rspamd-Action: no action

This short series adds support for VLANs in macsec devices when offload
mode is enabled. This allows VLAN netdevs on top of macsec netdevs to
function, which accidentally used to be the case in the past, but was
broken. This series adds back proper support.

netdevsim was extended to support VLANs and there's also a selftest for
the new functionality.

V1->V2:
- Changed VLAN filtering to only function in offload mode. 
- Added tests.

Cosmin Ratiu (3):
  nsim: Add support for VLAN filters
  selftests: Add macsec offload VLAN tests
  macsec: Support VLAN-filtering lower devices

 drivers/net/macsec.c                          | 38 +++++++++++-
 drivers/net/netdevsim/netdev.c                | 59 ++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h             |  8 +++
 .../drivers/net/netdevsim/ethtool-common.sh   |  5 +-
 .../drivers/net/netdevsim/macsec-offload.sh   | 59 +++++++++++++++++++
 5 files changed, 164 insertions(+), 5 deletions(-)

-- 
2.49.0


