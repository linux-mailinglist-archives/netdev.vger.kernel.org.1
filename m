Return-Path: <netdev+bounces-247832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1EECFF35B
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B5283017223
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457AE350D44;
	Wed,  7 Jan 2026 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a01OA4iq"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95534FF57
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805495; cv=fail; b=Dzky9IdrhWAb//FXHVckVBTO0IdTJRHKmNXfFUC3e3R5pHrw9ouXvcFX4GKaX24UbJyey2aiMXCzlXeXf1DY4WU1XMRP7cd3eiKgueGYUwARL1FGmHGa/WKGNvF9ewSGTLQsOCYuQo/P+5akU7KOsK/zsgi+8E3qaEkSgzcUmTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805495; c=relaxed/simple;
	bh=NAT4QGIo2qz+9MQcyud3kPOdFxd7xXePgWptE28BDQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cqsCWaIrMIiRpCnLcHV9klebwQ2AVc1u5e936fAltmYlqcysfSbehcQRkxPZv8BBCxVbEnDCa4/X2vl6yyCwFvW9NXrq7IHkPQygawp9ZDIKJZSgeP2pumcxcCkz9G/BbLTKorTqYvacjwmX6rx/5qJqcJhxDGWkECqdoiVhByA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a01OA4iq; arc=fail smtp.client-ip=52.101.62.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOjaPcLk5qFAAe2+Jjde7R/O9LWowvTrzKGYr0lkNuANgcgAZMQ+CUHQn8aMNPXVpliwBaEWCf10+wI2mK6dY52tlYJnAwr54AZggSXIF8L4y9W/3CmF3Sbu9R/TPtF8q1NMAZfrCs3A/mVJkQJxWq/cWTWKJEJq7MC4JmWpFj8Xnn/UuoVBE6dmf2lUqBg88a/SieAY/MFrk/oWFayU2sTzt8O1YCvQx+Li11tdSX6mJFbl4dJ9ZZww6aynzzPAJsvhk3BKS5urPamz32+RWO9mu+xHZYMEJhUfho4HbUw2IEfSzte8B1hr4Ruc6h51wlrGkxI0DDrlJKGxGd3D1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KT9ngOqk01wpAhFbmL4cy3Mc/OVguaETFTIlHWJchwU=;
 b=Dx0svIiNumYBfEW5AEOjccdkkhTiZiVWLriWxcYufZ46SVnZzDznxg/9+tfwXYqrlrw/ak+eb4TgEqKCLBmOutNmyWDx5GkVUm6imq/uMRBaGTv8AXLjQjKnQfvBeJx7+vLgBuVEQQwa0Prp+sKXJG+lrtjh//a23pn20UTnAokdd2NAO1EZwKuK3qA+y4KTNckWSrICoE9qWbY6Xyg+GbX9uGvuodWvsDe/VLvM5ihnCbXyJyedCDWih65W08gC5dgS1xqT62RkY3CWz3hBXnm/4Jn/jTpQ7EKijQi0k4df2Yog4cf8qw/NYAhDwKvm4HqCQW/6PHmlQ+SR2eePYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT9ngOqk01wpAhFbmL4cy3Mc/OVguaETFTIlHWJchwU=;
 b=a01OA4iq912AM5AeaXSv9VC4HLhlXFMJB3TF68pMXKUYRNi6wJEI4+5NaIZcsoOrYVFDaxkigGB47GytZasWEr/WbduIrZ7zxRiHyYW5Nr7V80LLrGy1LcKVpnX5X7vRbTtc0ecg4ysrFz2ztYGQDvJFA62LcliQQCBc+PoVVBNHzZuAx6lSfLnWPt+bjI2HOLEGhoGa9i/oUxw+AeGCXKBQBaGsz1LCgYH2dHUCWoM5SUve6ezu+J7HC/hgHgPJOKfOv5LQd299rgLaydDJD6TB2zLzIBCMGEmIWjbbibwv6rPNH1TTm6UftkjpEdLvz4ywq1BBUMKPcMCryb005A==
Received: from MN2PR22CA0007.namprd22.prod.outlook.com (2603:10b6:208:238::12)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:04:43 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::51) by MN2PR22CA0007.outlook.office365.com
 (2603:10b6:208:238::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed, 7
 Jan 2026 17:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 17:04:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 09:04:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 09:04:27 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 09:04:25 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v15 00/12] virtio_net: Add ethtool flow rules support
Date: Wed, 7 Jan 2026 11:04:10 -0600
Message-ID: <20260107170422.407591-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 610c3f28-8265-48bf-fcc2-08de4e0eda99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?42r3AZyNuCLQScb2BJRy2YBA7JReiF48l+9moN69yzeDcTlvJt/mc/UCmRTF?=
 =?us-ascii?Q?xkNWppJHlyYgSmE2iuYZoN2w/z4TZ5VACcF56LAfs5Rl+VJFBvDQJhxzGJWf?=
 =?us-ascii?Q?7R4Um6YOyh/n0c8zburoMUL5EQFGqigiK3p3843WUOWl+aXLUF0grvK6H4+G?=
 =?us-ascii?Q?LeXyS1gIh2k3i6+Je6DtssgvDwJKepBVdvGwcyvjo1/JCZnovNhsNoujiwn9?=
 =?us-ascii?Q?4ZlbhIYsLqXMnQZiQAeY0kiYtIKkYFc/4GUJ0gunpJZEm/4SH3cbtRqocf1j?=
 =?us-ascii?Q?vouNKjDu9+OZQJP8vnQvwONhyxhAAp6Rz4LJx5PQ5buxt8EMj9/LuLPylu/F?=
 =?us-ascii?Q?SsvGnu+fyzkWQM9Vr0J09Ig2H8pCiHF7uUIhcXdquswxQ9CX61/zgbjLCQ/u?=
 =?us-ascii?Q?oBrL3ovS5C18T7/sH6zUDzAwS+bBDj+e0BHOh2CUVU5g1vyRG3zZSD3fk+S+?=
 =?us-ascii?Q?ghwxVFqBKFV2Q8baJRCbp6JLT3+jA0AXw8UdhOaRIoyQzPPtZ+ffZj1qAzIP?=
 =?us-ascii?Q?rny2spIqJ6OLxREn6ekR7Gws3Vp+Qrq+G9VN9kPF2Oq9Ql6F1/tHHlX+p9Ko?=
 =?us-ascii?Q?BHXF6lx0BogwiX75tbUA/m/2aTlzCgIdk9ctqLJv9auoE81wi4iD/6sAcGoG?=
 =?us-ascii?Q?UwEvWtrS8JOm53si0pUH6wKhiyNbJjK1XgYiBcLNMCpjsvR22p0/fc/Dv+qG?=
 =?us-ascii?Q?xpjknvQ9xCXq9JBmTav3ihR6xrDTLXxktwrqurf/I179g/F1XiTLIBTKjzyR?=
 =?us-ascii?Q?AUNzqZ5Q4Oq2hmJSBs6IBd+wgds7yTKBJ4elQy3gE2x5TckiAyqVOtYfLsLq?=
 =?us-ascii?Q?Qa5E16/fGYv5trzs5P29DOXhVayoLQsiimBmSMnynhBjI7dBKV/QDujOntpe?=
 =?us-ascii?Q?QP8L8OW7AM1f3mrJw5tmDKWS6JJU14M6Wjm0TrihUx1uH6iThLKZIiWG7TBz?=
 =?us-ascii?Q?P88PD3iHQ3xFB+YEbKVF0V7/wstuEIhUpfygkpbOsLuwXuceQl+j6eHbU6uz?=
 =?us-ascii?Q?KK2uMJEW0dgCYas851gh4lDLd7cioC4tE+LsxhcxtApFb9jCM8UM4m6PRqL6?=
 =?us-ascii?Q?bqA1fL2BC7L6sBccyHCX06riela2d0xSuvxUJmS/HvzW9MjUAR1vqitrWO7T?=
 =?us-ascii?Q?S1gRyC67Wup6zx80uImA4G2tfI6A9uL0g+VWa4jgPW0WYUu9edGhgZdyoe2j?=
 =?us-ascii?Q?6svaTVFHDLdEiXQyST3Ru8QNOuo9ON0cOkuUBZYmAGnUiRJyaUn9FIm1EmsH?=
 =?us-ascii?Q?SnTYcymelMfobjIjrzRRiXnE4BraLSfX81Pi9z6ACo8sKyOd5CkmBfIs4q0e?=
 =?us-ascii?Q?pjR8XnPQ2xnWOIyHDIWiwx4UluiZrPpoJJJFNbb1y/rXZ38nb3uvoIvWT7lt?=
 =?us-ascii?Q?um0A4zymj82yty02p9naxSznxKSN+D3YTDv11kpT33L+ZxHSNH2I/OSXRvi4?=
 =?us-ascii?Q?3HRGxsORHVxrSsWwgp0CPEuBBzjNaX5kumoEeOslZ6yALcVLgrrn6kP2D9lS?=
 =?us-ascii?Q?kpH1t1+NkkYTrGwmOsUY5l8wCgi9ibQ3eKg1QQuew15Az5dHyj/2mAsP9JCl?=
 =?us-ascii?Q?Mx18RduDadABGvHEYTQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:04:43.5476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610c3f28-8265-48bf-fcc2-08de4e0eda99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507

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

v14:
  - Handle virtio_ff_init errors in freeze/restore. MST
  - Don't set proto in parse_ip4/6. The casted struct may not have that
    field, and the proto field was set explicitly anyway. Simon H/AI.

v15:
  - In virtnet_restore_up only call virtnet_close in err path if
    netif_runnig. AI

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

 drivers/net/virtio_net.c               | 1220 ++++++++++++++++++++++++
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  171 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  121 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  155 +++
 include/uapi/linux/virtio_pci.h        |    6 +-
 9 files changed, 1681 insertions(+), 11 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


