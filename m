Return-Path: <netdev+bounces-241998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC0C8B98C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75BB84E774D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F007340A4C;
	Wed, 26 Nov 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nVIUSlsH"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2B833DECA
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185775; cv=fail; b=vBl2cjs4ZXjPjf+Cz+XS7/SRQT1LGeWnfRJ95xdkR70zuXbSw5GynAH9Mw7/DcwtkmJhKEZRjYqIPKut/Wn8Im82FWHeeBfJAGfQodoNw+12q4zUgfGJz2Zu0o+zm6fzYBsvUjnG4lGQtQte3FISANfJVcTnWb2SRxYY6AAEDvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185775; c=relaxed/simple;
	bh=2EvaXMRMpI6cveW2uJBXqzRRsl2wFeWj+SLo4r9iPao=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BnuuRR1RPGFIlZmbyPdpA/G0UC9HIkBB2/6LWNh5venxKfL2Y87c0k9xYkLNmWyS6GDExJ4EjeCFoVlauRAIYwmTMAbIX35cWxs5wK0FdXKEZ+dgu0zfdtsjYIN0Ay43yb9xY9110PbLeqjmKscmX6aFihxa1/rr9pyZ390CCBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nVIUSlsH; arc=fail smtp.client-ip=52.101.85.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgmKshBQZ12S5xGd0PnO13s85xhz03OMIfxJSJVRKFhzf8XlICw9BC8shejDAwION5hZ5R9PB7+5cLqIAM7FfQ2nwREDclY11oH5IN4RrcpWh69ldzyDsAeuAItQhG+Gy04+RQQh7tjZ5fMP5ACei7XrKoKnOmsJSDWZL3dTsoKFvkJVVsav+wt8jLGN3z+1iaz7Y+Blz/kq3NDjNs2fte9LuajVMrZZotWt8sYbhGSU7jwAiD9PYD5GHWAvySw1DBYHYQQsRHX0xKpP9G3y2mRio0UHHqunSUz2fsmfPV8yyCLaPdaz16T+EvrxXXoL6EYxmvTTPxsOfof5YFMopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps7hFcJRvPUsGIZwR/5UEcabvm9iofOmi4rDlg833A8=;
 b=f73cbWhUwZiXGbivxShLXpa7eQ/gsDzSTfDQGcdWhrsXUUAu+jK6se0GgEIUX2xKbGT2bSV6oPbbgTVh987MVdWHAUCqwxjHaGR/P98bI9mDHRr/6wr+hLPGkLXWIhabdXO0eCD3vnJPMEJXE4M4HjkzeKKTXNRbN3+JIBZ+RukS9Lu8jS2AN9hAx7hoTrBtqfX239IOhxpfl2wni1G0RLWHlTIsSX3rcvw/8SYXHCDVwwYUB2Tf0tgsTp8koDbp0AEZzfPvs/Rk7FHwSKI+ohWkJ1E7mLbBj3+Fr3PEPLq5XOubCr5ndm+kRBwlqTvBrRnD5pM8NF91vLAAQMSUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps7hFcJRvPUsGIZwR/5UEcabvm9iofOmi4rDlg833A8=;
 b=nVIUSlsHJaEftyrMNhD9uapavKuFpp7w0EPUhQYKag8psdkkj5rMsT3VXQD3Gp44koOJjeQzWuS+bm3e/LZzotl87OinfpuJ50DNW1qw3kuaRv9fefTejzEYO4S3qRMDkroWiok+OA1on6V1N51GYC18CbdpWiDenb9szwbHRCV+linGTOe1zUK0dq2rPW2lHDJ48RzKzGXkY7aUV/cuMZcihkhxFICvzz1HYFJUxXqJ5DRr8HZ4c4iWdoIhX3hIMvVyReSr+es4HsvSk8X1Mn+V49niJO0cHna+B8gVgTF60jq8SptWMSI5smzMwQHzvTj15dCZgc69s/QdKyGFhA==
Received: from CH2PR05CA0066.namprd05.prod.outlook.com (2603:10b6:610:38::43)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 19:36:08 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::33) by CH2PR05CA0066.outlook.office365.com
 (2603:10b6:610:38::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.3 via Frontend Transport; Wed,
 26 Nov 2025 19:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 19:36:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 11:35:54 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 26 Nov 2025 11:35:54 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 11:35:53 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v13 00/12] virtio_net: Add ethtool flow rules support
Date: Wed, 26 Nov 2025 13:35:27 -0600
Message-ID: <20251126193539.7791-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b46489-a8e6-48c7-fe2f-08de2d230bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hsx0iyuAJvIhy7Tq8ubOTYi8pqJdReojIevOEwtCAXYaqLal6+stLxtGIxqf?=
 =?us-ascii?Q?dUahvZwu48dVzTa+1mZkOloCc/uH3EJvDfGoOJRTH54M4hn/ZLpPkQ9SifSV?=
 =?us-ascii?Q?tOF0+LB8M9HdIyTMyRNTW12TBVi4vAfooy8OiAQEZ2gvLNHjmR5Y1Sx0Rt5C?=
 =?us-ascii?Q?/vVgc3kKtM/TnBrmhnXUI3co1ktauYpmYdnlbwFqLnD2H7RqQ6iyAGBU0El2?=
 =?us-ascii?Q?P+DpUJbjWbxm1Y5BIkT/AAEasoyfEwGNjlR4inpujkr6fBrVvjAl5OKroG4Y?=
 =?us-ascii?Q?5z6OSYVsX/c2eKZMnkKRnWRL66vtyXYhMPydy2Im2nVOE0GkFBeRAOJIB/ZS?=
 =?us-ascii?Q?OfzCND7/m0n/n86/5Huqq+3FuGtQTz+UFGcZQm3jikYBRU+Pi8VcXOowsATi?=
 =?us-ascii?Q?x5cDtuV6uTB27jDy9P92uVKG0RQycs8A2Ns7MX0oLry61KzDrGNFplluEQ7d?=
 =?us-ascii?Q?uxL0ZHpesNeEi4SMVQS/Dxb8QUwjsKxMiqLhmWxExa+8NQFOQVBcx6y7mhQF?=
 =?us-ascii?Q?eMxHGlMffj3+6idsxZrHjrkrM/U5FQxqWmOWazo3JHLT/nHq7NLVx9fTm2TF?=
 =?us-ascii?Q?b42YHJG+fHoYjfd+UKoLJs5yDd3d7IohJmiOew6QetgZbVTAltR15sfMOgN2?=
 =?us-ascii?Q?UpwfRzwiUOKSdPy/q6JdlavU3tfe9RQah9ZRXq/CrWBXtYfaTlD6S6FFBvVJ?=
 =?us-ascii?Q?UXWdgnE6l2b0T6qJZDRH8k6sH0TNsz2eDv7S+jlmu92BQ16oAFq2kl27z1tx?=
 =?us-ascii?Q?I5GhA2AzAthgExmUZxzTjdArm+XTSbPllPjUpUhN7QRMEhBc9oJ7IMZRaMdS?=
 =?us-ascii?Q?9QNl0TgeiiTyTH8yX1F1rVupxUdHhJh13ZL4Bu45SWmRAxAXNTeK0903lQi3?=
 =?us-ascii?Q?kRb0UkhEVSFZWZ/g4U1pkDdyrixMbk81sPHlfr3oewZQf9Csii8P7dDWRBPN?=
 =?us-ascii?Q?N98T57LeDRCNsqQIa+3Jtd/vY4mNQJF5EgyBjBgrlAvKacMfu70CPCqlTLnW?=
 =?us-ascii?Q?2wQ08uv4KtOC4x6ATARNbHO85K8OHLnrxk1y4E4FRs4GAuCOGfbJ86t9O50l?=
 =?us-ascii?Q?0mr1xOA7BvpfRnnq+PbhQV9TrovL9PwRjZHVwberDuFIB1Jl1nG8W4x1bWL5?=
 =?us-ascii?Q?6bZK2ewM3Taii3gNE9stkYAeH/5/L2sdPRAw2/mMns9Xy9UXQIK8Vgzh0rWi?=
 =?us-ascii?Q?JcUSyNwkvogrZgRsxSL2myGjy+vMVIZHEmNuZSqCXeqW+T/NXqMve+9Gxdmf?=
 =?us-ascii?Q?R+e+w2ED1+uTjSZ2dM0yoCdiXzIRFysAwJKH26Ry5TN2mZI1VsUhGD4YfDUX?=
 =?us-ascii?Q?ZIezrQXucu40qa3u/n4v6kgZG0jx8dghLgjc193PjXtQhBehad5QQJEr1FuD?=
 =?us-ascii?Q?+9/2p+jLUDnqBOxAMLs02rjsoUcpPsfUQt10nDFbjk/4Lg+37yDx33WI6Ldo?=
 =?us-ascii?Q?//Q7bXMkzc9YmXaYbwGHRwxfWFr0NzVI7R6FSFJ1/Jx+Y9xGU7faaeyDHJma?=
 =?us-ascii?Q?8jOw/bR6yyH/VN28+A0V8aVov7SybIIPdOc9xGhqrPhErg+6ZJFpXNMRP3Q7?=
 =?us-ascii?Q?HsFDUvZgXlqFg1T84pkv58JjHzyROE0cIZ6J6FYj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 19:36:07.6594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b46489-a8e6-48c7-fe2f-08de2d230bc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690

This series implements ethtool flow rules support for virtio_net using the
virtio flow filter (FF) specification. The implementation allows users to
configure packet filtering rules through ethtool commands, directing
packets to specific receive queues, or dropping them based on various
header fields.

The series starts with infrastructure changes to expose virtio PCI admin
capabilities and object management APIs. It then creates the virtio_net
directory structure and implements the flow filter functionality with support
for:

- Layer 2 (Ethernet) flow rules
- IPv4 and IPv6 flow rules  
- TCP and UDP flow rules (both IPv4 and IPv6)
- Rule querying and management operations

Setting, deleting and viewing flow filters, -1 action is drop, positive
integers steer to that RQ:

$ ethtool -u ens9
4 RX rings available
Total 0 rules

$ ethtool -U ens9 flow-type ether src 1c:34:da:4a:33:dd action 0
Added rule with ID 0
$ ethtool -U ens9 flow-type udp4 dst-port 5001 action 3
Added rule with ID 1
$ ethtool -U ens9 flow-type tcp6 src-ip fc00::2 dst-port 5001 action 2
Added rule with ID 2
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action 1
Added rule with ID 3
$ ethtool -U ens9 flow-type ip6 dst-ip fc00::1 action -1
Added rule with ID 4
$ ethtool -U ens9 flow-type ip6 src-ip fc00::2 action -1
Added rule with ID 5
$ ethtool -U ens9 delete 4
$ ethtool -u ens9
4 RX rings available
Total 5 rules

Filter: 0
        Flow Type: Raw Ethernet
        Src MAC addr: 1C:34:DA:4A:33:DD mask: 00:00:00:00:00:00
        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Ethertype: 0x0 mask: 0xFFFF
        Action: Direct to queue 0

Filter: 1
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 0.0.0.0 mask: 255.255.255.255
        TOS: 0x0 mask: 0xff
        Src port: 0 mask: 0xffff
        Dest port: 5001 mask: 0x0
        Action: Direct to queue 3

Filter: 2
        Rule Type: TCP over IPv6
        Src IP addr: fc00::2 mask: ::
        Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
        Traffic Class: 0x0 mask: 0xff
        Src port: 0 mask: 0xffff
        Dest port: 5001 mask: 0x0
        Action: Direct to queue 2

Filter: 3
        Rule Type: Raw IPv4
        Src IP addr: 192.168.51.101 mask: 0.0.0.0
        Dest IP addr: 0.0.0.0 mask: 255.255.255.255
        TOS: 0x0 mask: 0xff
        Protocol: 0 mask: 0xff
        L4 bytes: 0x0 mask: 0xffffffff
        Action: Direct to queue 1

Filter: 5
        Rule Type: Raw IPv6
        Src IP addr: fc00::2 mask: ::
        Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
        Traffic Class: 0x0 mask: 0xff
        Protocol: 0 mask: 0xff
        L4 bytes: 0x0 mask: 0xffffffff
        Action: Drop

---
v2: https://lore.kernel.org/netdev/20250908164046.25051-1-danielj@nvidia.com/
  - Fix sparse warnings
  - Fix memory leak on subsequent failure to allocate
  - Fix some Typos

v3: https://lore.kernel.org/netdev/20250923141920.283862-1-danielj@nvidia.com/
  - Added admin_ops to virtio_device kdoc.

v4:
  - Fixed double free bug inserting flows
  - Fixed incorrect protocol field check parsing ip4 headers.
  - (u8 *) changed to (void *)
  - Added kdoc comments to UAPI changes.
  - No longer split up virtio_net.c
  - Added config op to execute admin commands.
      - virtio_pci assigns vp_modern_admin_cmd_exec to this callback.
  - Moved admin command API to new core file virtio_admin_commands.c

v5: 
  - Fixed compile error
  - Fixed static analysis warning on () after macro
  - Added missing fields to kdoc comments
  - Aligned parameter name between prototype and kdoc

v6:
  - Fix sparse warning "array of flexible structures" Jakub K/Simon H
  - Use new variable and validate ff_mask_size before set_cap. MST

v7:
  - Change virtnet_ff_init to return a value. Allow -EOPNOTSUPP. Xuan
  - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abini
  - Move for (int i removal hung back a patch. Paolo Abini

v8
  - Removed unused num_classifiers. Jason Wang
  - Use real_ff_mask_size when setting the selector caps. Jason Wang

v9:
  - Set err to -ENOMEM after alloc failures in virtnet_ff_init. Simon H

v10:
  - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
    Jason Wang/Paolo Abeni

v11:
  - Return -EINVAL if any resource limit is 0. Simon Horman
  - Ensure we don't overrun alloced space of ff->ff_mask by moving the
    real_ff_mask_size > ff_mask_size check into the loop. Simon Horman

v12: Many comments by MST, thanks Michael. Only the most significant
     listed here:
  - Fixed leak of key in build_and_insert.
  - Fixed setting ethhdr proto for IPv6.
  - Added 2 byte pad to struct virtio_net_ff_cap_data.
  - Use and set rule_cnt when querying all flows.
  - Cleanup and reinit in freeze/restore path.

v13:
  - Add private comment for reserved field in kdoc. Jakub
  - Serveral comments from MST details in patches. Most significant:
	- Fixed bug in ip4, check l3_mask vs mask when setting addrs.
	- Changed ff_mask cap checking to not break on expanded
	  selector types
	- Changed virtio_admin_obj_destroy to return void.
	- Check tos field for ip4.
	- Don't accept tclass field for ip6.
	- If ip6 only flow check that l4_proto isn't set.


Daniel Jurgens (12):
  virtio_pci: Remove supported_cap size build assert
  virtio: Add config_op for admin commands
  virtio: Expose generic device capability operations
  virtio: Expose object create and destroy API
  virtio_net: Query and set flow filter caps
  virtio_net: Create a FF group for ethtool steering
  virtio_net: Implement layer 2 ethtool flow rules
  virtio_net: Use existing classifier if possible
  virtio_net: Implement IPv4 ethtool flow rules
  virtio_net: Add support for IPv6 ethtool steering
  virtio_net: Add support for TCP and UDP ethtool rules
  virtio_net: Add get ethtool flow rules ops

 drivers/net/virtio_net.c               | 1216 ++++++++++++++++++++++++
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  173 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  121 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  154 +++
 include/uapi/linux/virtio_pci.h        |    6 +-
 9 files changed, 1678 insertions(+), 11 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


