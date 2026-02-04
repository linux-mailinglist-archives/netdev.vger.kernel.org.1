Return-Path: <netdev+bounces-256842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEvPCNPKg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CADED061
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A553013D7E
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4FE34A76B;
	Wed,  4 Feb 2026 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uCQI4QV9"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D88322B81
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244804; cv=fail; b=bKJOux42MhSypCQVkPjLAiWIhiH15dhITzv7kCjvAeR+22FV6g57zSAcc4rRD2JK9wXzpwJ02Po9WcmA74ZAHNfLpQvx1xv2tn8F0KNFWy987s1QNYdgvWBJaP7Adksy4A1PZXyW9vycS/f3ln/zbbchY5BFI//RriY55WW0br0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244804; c=relaxed/simple;
	bh=Qo8w4WkF6/Rq/+yDmINhI8cPltTRCEUOylu+zz6N5c8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eOr1suaOUw8vOGcQddD9Yrz3dtr5rztdpogcx+ffJW3QRK5qHXoyXTp281Tj2UnjbL381vpkNu3yaxINbKLj7EEFFID/AbaWOnwrpWHXk9zDW1+IhKUYuc2Bi2h1LRkkz817hs7Q3w024nAdDnW2Dp7hfqZSsYRQV1RZhpKqosw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uCQI4QV9; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEXcYkWNgEy8FkOk+0OrSXIMGqPZC07kasIXR3c+WPz/EwdFO86emJlGmuVfaEq17ItD48CiLOytEgHoWsD9wn5fRsf9EjkA2JJ/s8XL4lXPxkeeHJzVU+/1Bwy9NU4WnSdaG7UPyStezPfJLTVgMLerkWx2jhTjOXU4PDNwqOfk9fLPm+qn4ZHgB1NXnHN5XpfWPX1tiOKdHPoGH5SpMlTnCOTDgMK9105kqWLIzTC033dqVclZmY7x3VeZF9sZ+8YI/dCwulHaKPY63Ch5ObZkdVuj57tSN0uebo7iqw/1DkRVfkW/c6KJV0T3Hz9N49KSSIukr7wr71mqM+HrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRUTgdKQFp1cA4H1WbqJ/vWdsy1brQtz77q9w3XnoXE=;
 b=Dyt1S2P57m2zObfjseVk46HHmSt/4atyThy3ghSZUeUvTl1P1XzSAHqiw7Aw8h9+r5ZGi7gjwjLbqDM9ebKecK9/34E0ZnqI7BFKAJ2FAKK7cJ/aJHXF0U0tlvQDZ/y5ulo5G2tzrlm63zLCu8Ba6auT4x/VO2NXZJQnmcxXXnHcdOIv9xhnRDqEwVZHwBWs5vrWJpgPZxGEDCojf2r62k3QnytZHPNK6eNW5DknUFKDhSETMEwOeOfU8TmJuIlyGxFAoO5y1hBiX5LVZk1Hr0AdggyasU1pXjvziOeoCHB8elJsjg0dHtErGjnE7vhJ3UrAwz7N7LleADu8Tj2m+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRUTgdKQFp1cA4H1WbqJ/vWdsy1brQtz77q9w3XnoXE=;
 b=uCQI4QV9zEK4RCoJbzGuMo+uwqcafbcBikh3VvfSOilGuF1u1LpchfCnNmtElk1t/cUahcAMZl0OeOruGra8aB1JOB3lsZnvGZ+7XtO4YUdtXo1nL7tEezCXcEyXKQHpCJHHAveStZqK2nBUc3z61+/8utXaY7Vy4TlETZer6ZgaWK8SIjS8x4Miso6W6Q6Ammes21nlTApWIuLxox7pfwCSQ1e6rsul8/6qGARVB/FqZn/vkVyVHcYsayVcFjKDnURmYXrthdh42C4e8ExO1B7pn93iY9lmfd6N1/VfJhwdCQh6Wp+zYJPkKdeTLtVBvNglpwSPjO8xmK4t53b0tA==
Received: from BL6PEPF0001640E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:15) by LV8PR12MB9418.namprd12.prod.outlook.com
 (2603:10b6:408:202::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 22:39:58 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2a01:111:f403:f902::3) by BL6PEPF0001640E.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 4 Feb 2026 22:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 22:39:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 14:39:45 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 14:39:44 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 14:39:43 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v19 00/12] virtio_net: Add ethtool flow rules support
Date: Wed, 4 Feb 2026 16:39:28 -0600
Message-ID: <20260204223940.39581-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: e94efc41-7453-46a0-381a-08de643e5330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VXCFvPXwO5P2f3yHF+8FVJNTPWHL/NnKKH8k7Nis1VQA5vSk/6suPFCX3ttJ?=
 =?us-ascii?Q?QA7woZ/DcF6lS2J7ASinr3Aizil3bHXv218ttZuqMgvUcecKLm5iKEON2QKt?=
 =?us-ascii?Q?i67IwRQuQweJCyBlnPQ4ZpBOfjZTpqij/XLI/wgFbqw+q/GQdKcWmBRmSRVM?=
 =?us-ascii?Q?7cWRbDFsgb2Cx9S5oIoNv42KDIM4zJ5PPZIWG1KMqkm+iIvuwmOpEDlPUKzN?=
 =?us-ascii?Q?0zh6hz+vqDtHUoo9DVcVRfHs34udiw5toTbp+XFGoY+ShcWbqiJtgSFRmhsx?=
 =?us-ascii?Q?XGoGXNOgyudmCy1FaB2vVzynmvxGyggWL3zpYelRz4i/3DV4p0TRRW8IplIQ?=
 =?us-ascii?Q?ELSufY2VMbCfQKyez1hO7b6Cc4d45L6ey6kLKl7yEGsjZ7QZKNCi4VV3s9oQ?=
 =?us-ascii?Q?LR1PiFKmuTMSl32iWBlJPa8bXFwlubHfVIi2g37HPGuH0TVlYLM+NTMaXOBA?=
 =?us-ascii?Q?UW6wEmRKajqzqWJN1BsP+874e7bnVc0cBe9YAiYqJUpKEKvb//TPb/pdvObV?=
 =?us-ascii?Q?sfvkKwisTzJbXclXDS5s3TXceMb6BvxPnUa+32sj3oYgAjItoCxnTslkGN1t?=
 =?us-ascii?Q?BCieIxsL7OTSxodIkKygHHY2jzNZRLp20KvccsEChMU0zb6aleNHC1ZBGhpH?=
 =?us-ascii?Q?RfEfSCITmZZO6Z063eZNzVGnVYOueIWiicsdLQ73yTRszXZeOEEqoULJuJOu?=
 =?us-ascii?Q?S88nXjF08JapDVhiXFo/sOVTKQ79phdXSYTw04veArZ3Vc4xvRsGQRTmjHGL?=
 =?us-ascii?Q?t5rfnFD+Zzj+Tw0IcxP9oXl0IUdlTpEhGqxA0li39FoZtiocw4H2YNxVxFI1?=
 =?us-ascii?Q?KC7tTHno7mKRiB8QrcXMfb0DnyvYTUygTM07ku8JAo6SaNfXewbYN8k8InvK?=
 =?us-ascii?Q?GW64yoGs2FVAaLj/43uJg2rq2sUnf0JhiUTrRrfW7krRPCt4ftn9IZ8WMUL0?=
 =?us-ascii?Q?3iWCTQFf/QZPIAIotq40gBpSUG7vJsmlYe5duGdfeR4NzVlSYDDRMxT5BVVK?=
 =?us-ascii?Q?htXupGQqx0BnkQnMX3wrCdRXc+ncK0I42HgjV7eCPbEGJjlLJ9U0tX6rFxmU?=
 =?us-ascii?Q?N5r1a9ieJhug1mXmiJ/9NxFbFVC6r5VYdyqMBT2n5uZw+7z4tyXmiUJzulq2?=
 =?us-ascii?Q?HNQlJep9rmc8sLF+1nOFJ0rgQMWZrPoIkuKk4xyraynRc+4roBOIKMqRmQ7b?=
 =?us-ascii?Q?xqVTRjHLyEbTnscu2++XQn8DeDLK8oYVpA6spV+B3qiHmb+VCloB0RiYi8m4?=
 =?us-ascii?Q?hBgU7kx4EXzjwdaFQcKFBkR5UYtwdBMYRGKH+YQv6vYexeKca0Zuv/+R42e+?=
 =?us-ascii?Q?70cCJrcmHtgQGTVNkQ4FVey0YXo385u5myzewxUQCxpgWeSYwFjqKst/wgZl?=
 =?us-ascii?Q?4a74dCh/PqPo7FaHvEWXEBjOFNJElvNCNpXAhCXnJINCxe74k2L+VuUF2Od7?=
 =?us-ascii?Q?5OWCzdYs39ws5qTFLRKutTy8Fi/pKk/F27raMGh2OjPtUgpmiAREY34j2x/q?=
 =?us-ascii?Q?Iv/0N04/hqVpaEzcIWed6P2XBp2t3XOnKI/ecP+T33MVxQ84GGzDdHhThgDl?=
 =?us-ascii?Q?BNOXsEGCG8RXA1cceGPPQJgfL5nwSm+OwpXsmpe30WNqPksBK7myhZl/b6pF?=
 =?us-ascii?Q?Uj5bvOaib4Ipkz4VI3UibkAeScTtJsR4WxuBaGcOfkVjWaAPptwuf4f1sxig?=
 =?us-ascii?Q?mhG50A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8J0hX40UttPhq/VcAkSMpUrDxp9QHCNn/A7TPcawI7ZUtApqTA/NO2AeA5JkRwiLjszatfseTD7c7MhFkuEzJIKKDFoXuRSYnb/7y9wNMiO8AW8wuS4kUjS+8v9oCYVZR72i78bZ/idtiYVQlzvq9bArYy/Ap+SfZXLDtn5Eug/6eOBKw+V87gS2PHMN5ZlVV0UJPqK7fMz9U75dX9qKBzqikos1YptkdTO1Gk1BFuGiFUASXLoL9J3FCe+5LO0A5yRFU8TGgs47oJVgeLGX24st7sVGNraUUGVT+lyqp5dFkXOlIKUU9gkdT5cCwp87E7FlNpDVM+qz8VUuQrxyn2Ud7+H5qPO4b2LwA/s3PWKLsJ5WpDb2rx2L7KOSqMnNRbh37oUD7n5WZeHTZbWDWAGb/AvZ0nfh/dz4g8Xwn+YkIHIxhozEWIcNNi9i9n0p
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:39:57.7973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e94efc41-7453-46a0-381a-08de643e5330
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256842-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 92CADED061
X-Rspamd-Action: no action

This series implements ethtool flow rules support for virtio_net using the
virtio flow filter (FF) specification. The implementation allows users to
configure packet filtering rules through ethtool commands, directing
packets to specific receive queues, or dropping them based on various
header fields.

The series starts with infrastructure changes to expose virtio PCI admin
capabilities and object management APIs. It then creates the virtio_net
directory structure and implements the flow filter functionality with
support for:

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
    netif_running. AI

v16:
  - Return 0 from virtnet_restore_up if virtnet_init_ff return not
    supported. AI
  - Rebased over removing series to remove delayed refill.

v17:
  - Properly handle unaligned reads/writes. MST
  - Fix use after free if init fails during virtnet_restor. AI
  - Fix memory leak when validating the classifer vs caps fails. AI
  - Added missing includes. MSTA

v18:
  - Validate selector cap lengths, instead of just checking they don't
    exceed a max. AI
  - Add __count_by attribute to flexible arrays in UAPI definitions.
    Paolo A.

v19:
  - Style fixes. AI

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

 drivers/net/virtio_net.c               | 1219 +++++++++++++++++++++++-
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  173 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  121 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  155 +++
 include/uapi/linux/virtio_pci.h        |    6 +-
 9 files changed, 1681 insertions(+), 12 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


