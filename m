Return-Path: <netdev+bounces-264839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NTOE4LuqmnNYwEAu9opvQ
	(envelope-from <netdev+bounces-264839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:10:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D074223860
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17A3D301346C
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ADC3A4519;
	Fri,  6 Mar 2026 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CWYU1PE1"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AFA34F498
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809852; cv=fail; b=ZMrPXcBBNRiI/PitMZRYkUPYPmi2CrZASFmi0Zf2tLogYlTiT7Z/kWkRdVS15+JZjWRaPcsiTlwBTFTSj3AeiusLbp0SOrcYwB83oYqugG4hG/KUBUt6sJ/lYVoyWjSp3hMsgCqjztgKzqI7DsLaUFlpWaSpCBLNPejNN6pFN2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809852; c=relaxed/simple;
	bh=d0i6RmOrXNMKn70OWHbo1BmBEMP0wv7J3jSNJSmgysY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NG9T4AuUrvxFMWI2bYnCyUMrnka3jLbYMt+Rgz/HM/ukibiwcCa5Z2Ym8sXuQN7p0LJ/ezMVDqu5NGMbRIo5aYqn8eVQoIvL+dQG5WZ3r7n+MaUmTSalznYYtzdi/hpAbtOtW1WBG1ul37Bje5G1gdtNGH2pVNe5uHl8F2WemoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CWYU1PE1; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zA1C/BnD2p8vY7nDcOaQmoLJfs5f+SB6cOMkkh0DUhvS9DHF9Xut7kJKn3Tyr/e8DqDxGOrDWeXPobPprU+ygcKh/hrohRafhKoHxOWD7+52asKI5U5nMQBj5syxst+M+M+u2qC6z6e4JznfuThn6pTBSMwAkl7fRVXaQ6u1xrkBu05WoClRzhx+uNBzQ/UxJe7z4uq45aStrIZisBjH1eS4HmFf4hFf9K3lR3tMPstAlZgJoTjq3qKBeUxcfuYfLnx8N9SCK/WUSTRQP57qyqA6w8hG6NUyf2SEayy7A2i7JmE0mwoViq7NtCIeWSKilwIyJPoPO5kJ3pUh0dV1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV2oypc8eIMmqeiHnNEvlBJcROJf4qkxjYgkCOtESdE=;
 b=jTS/frrR4T7nOkS5hwgfphdjL3ChLjUm2VtTfp/MxtrizMXWw6EHa0hqWl19bYTfZ6jA+L3cOp5z5toV/2h6PvQAXIr6AS0ZXxfZdaYG6B4EOMH/7P3neBgQYX6E4Ez63KVemReGCBfj9T+36+nGsd1t6IhvxqhVGfbXMnXwyljuzpCFOcay5II2juesrVtlUw1cTMNXITCG3xPxSxZMTtIpmAikHDTR780sSR2zYwNcbF8c0sJj7WIqYalhPmA94R2o9p3XDghn0urqaU8c2hjeJGpYy0iJtjWdtw/qDmFIGKbX+XkdZwPsPm2Gih5qXuOfOFEwcbHOw4xGeOcvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV2oypc8eIMmqeiHnNEvlBJcROJf4qkxjYgkCOtESdE=;
 b=CWYU1PE1HDD+JbTHAQ7XPLoEp7okoXSyQ+Ll//MPdhA5hHc2a7pj1kOjNCfyeu/zku0FjNEEUlYICm2CluIJSOOXy0q7MWgOQ3tpJdD7/YmKSLGp3CyXFGd6MmH9qTiuX4agp4fE5Ui7U9hyp22brApRXUrIuiSuL6Z0TySv3dzYU6f5jFLXcUv+5LPKkS4n9tfY8CJcCAxxmUY8olW17kEza+bTGcmPI1rb1AaI34LVJgxyIfEArr9moqKyVvHogYgHY0JpvWtyUgDTRYdp3x9NSuruNEmlRGnaRyot0QMqtCfM6CFhZApXzuZPAF9j6CIS9kAdtHPsqUMuETwUhA==
Received: from SA9PR10CA0001.namprd10.prod.outlook.com (2603:10b6:806:a7::6)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:10:45 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::77) by SA9PR10CA0001.outlook.office365.com
 (2603:10b6:806:a7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 15:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:10:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 07:10:23 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Mar 2026 07:10:20 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v3 0/3] macsec: Add support for VLAN filtering in offload mode
Date: Fri, 6 Mar 2026 17:10:01 +0200
Message-ID: <20260306151004.2862198-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b93e4f-b895-4a66-a31f-08de7b928a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	L10Wm4+95iRZUBoePGh46cIrNPxJL20McKkPdWEYvixAfbx6sNoJCDfCiRoIxCXan5glzQFuhg64enRQ74Wj5bUTLblIGdc9o7yfcinMwpNbYtyXEmfiNjCmDklcKFhR/0V8uvLu6d99kZzmLLi60oUwN0t2tmHwaGyBDaxkoJ3jF7fd5FyaCEkSR2EowmW4PbJ16jFqbU9BHwxfuBycy1kuvlh5ltdyPRXeOBiLbbJ7k61fbTYg0zsUJXXRsVpgR1ruqYHK7Vg3ZZ/Rc7v9iEVzIFeznx+y0n2kTeJZRGBbVS3smXF/dggxA4fgt2H2ZHf5HT6npMsihj/Qy1eFQMg0r8PHp4+7mubDDz8dBl+1K2goGOQDtYDCJayA5yVD5l6E9Ls1cwlBqXPYVeuAqszPCIaCKy8szvhztPuZZCj6fYsA/mru9oWI4oRDGtiYlrwwZyewJZWPusslr4TaANaGLXsNEvy39dnwgJoXchDrtvjIPmoRce/VodJgMHONO75tkFhBHdCPe1bUBd7xu/rMC7hhPYKKa2VEWpI+el7hQztNfuvhA3xNXrubInuJ4zOUq9mrWYk20ijse0Pp28ka0PbiKYlf/xnhKzazTMuzOT7RIvHTNj1GCystwgTDkDCfMG8Ow4vyi2mmUNfd3KaTmgN2yeoygbVG9/fOYZdauX7brXhTCeSYe2ehCvgGgUYJD3A0OZRDCZfwNXFXaloozsZtRcq6SLqznhy5ew4xtnUQ+7tTpVeClh+8JdYqmU5pZX77cL5CzGaERKOVWw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X/SOvV+WruTPzSn+YxcgcJrgRaTda2whU/XYxgsuRm2qdoYb0YTzabW5rbrlntOVRRSA6HNE7HOEbzLvjKPezA3mDWI+eE3NoOqL1Wn6JD1lNK+RWTkeBBCl8jHk5K2gXYIY2Ml501g6hHS+5tv5zjGwjHX9ZvxKTx43J0AVTaP66U++t2Sngm/oxESFNyWFoA5ortuRKw6Nl1qe85/7kQvZkg/zOJw3t1EFdDb1tHTC0C0g+3d13ECd6Ua8fTPjiDxJ6nyyCX+A2sWu53dMc6JDxIlrPd1oHtmZhWYnWYASrHSHD0rsBQ9VXP/MbX2UcSns0QprJoy2nznFa4mAELfDKX+U/eadZRYTbcAdjXqpmwJ+Cl0q1i7a4eIDaMXgeOPIH/oTMG1fhNHh2JaHigTD+cieuv48NgLoZG/Q/xIRsK9vykvCYVkNPaHO/W9R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:10:45.0691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b93e4f-b895-4a66-a31f-08de7b928a7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
X-Rspamd-Queue-Id: 1D074223860
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264839-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

This short series adds support for VLANs in macsec devices when offload
mode is enabled. This allows VLAN netdevs on top of macsec netdevs to
function, which accidentally used to be the case in the past, but was
broken. This series adds back proper support.

netdevsim was extended to support VLANs and there's also a selftest for
the new functionality.

V3:
- Moved back to net.
- Added proper rollback support for VLAN filters in case of failure.
- Added VLAN as a requirement for the new macsec tests.

V2: https://lore.kernel.org/netdev/20260227090227.1552512-1-cratiu@nvidia.com/
- Sent to net-next instead of net because of apparent complexity.
- Changed VLAN filtering to only function in offload mode.
- Added tests.

V1: https://lore.kernel.org/netdev/20260107104723.2750725-1-cratiu@nvidia.com/

Cosmin Ratiu (3):
  nsim: Add support for VLAN filters
  selftests: Add macsec offload VLAN tests
  macsec: Support VLAN-filtering lower devices

 drivers/net/macsec.c                          | 44 +++++++++++--
 drivers/net/netdevsim/netdev.c                | 65 ++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h             |  8 +++
 .../selftests/drivers/net/netdevsim/config    |  1 +
 .../drivers/net/netdevsim/ethtool-common.sh   |  5 +-
 .../drivers/net/netdevsim/macsec-offload.sh   | 59 +++++++++++++++++
 6 files changed, 173 insertions(+), 9 deletions(-)

-- 
2.49.0


