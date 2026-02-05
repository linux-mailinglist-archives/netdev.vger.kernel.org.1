Return-Path: <netdev+bounces-257348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD1KERUehWla8gMAu9opvQ
	(envelope-from <netdev+bounces-257348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:47:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9755BF831A
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE4013012C7D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201F233A000;
	Thu,  5 Feb 2026 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sJuP+bco"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1178339874
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331654; cv=fail; b=E9NQIcnWXDsCZUDgP1sBAa2KgU+WPkFrkgV+0dXL4JubOg73rKwefI0Ffb8aTE55oUFuMKaYOJo5BwtHkonvdm0ObAz31P6w+B1Iq4vzCdtvC1QbbBBjlZwURXNzAodkwv9wRKIEJfzjs/Z0m/vmq3t/FruVQx4NHDAKvfkkvcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331654; c=relaxed/simple;
	bh=xPMyYsnTwXf7zv58kcFJZrTxSrZvF0QYGXoKACCChnk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mQV6Dn89ITjRNEVoZRkR/ttiTmcHsMnVyrMLH0DjHNYKsZsiD4ZrL//jHyte0QRlSzcIHlJ3wObcn65ZZ+gSZDlZYnWN6DDNkwaey1xd0e1fYApUicNvOURuSiMy2W+OZrjIqJUlYwK1jyWPtmxjb7gThWK7bQ0xRWOcrVFUgLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sJuP+bco; arc=fail smtp.client-ip=52.101.46.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0kAqpRJNtjnE6F4Hw9Yg15lYGuishjGRM2hmhp10+GJnNaPApwlL7Gdvbdm1kAp//9TVyspNPpF4iwqdRbN+ME0/8q+lOSP3rKipZGDU8VWpPfKD3R0ObHPekEtKmVpcaYFnLcJXh4BENvAdagFBu3ArhGY+l8PwaoXmLgPEfg2nSZ9dDVl5kWLs33gSYeEYRsOsUyUJSJcLnZyt296IkMN6DeB57Q70bcmmVJ1wxfxyfVHvkZQfu6tOy2iyTGgYdp2TzNPHlYaZw4SsnTphYW7WOOOQkJxkqEcj4EKav06tDioHP6KJedEWKjiRgJOXuhuc6wuNOSF0a+xXbXLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmESNJHPBJtE01xV40GvJOf1Um4cShbZw64KCXJRpPE=;
 b=oBR+1BNB26jpqt/Z/DKtsshqiYqVoGtwPDFp+xojCKc13kZxmKSe8csAxIniR8+aWZWnG966A3v4XDbEqtLIg68jt2n4K5sZcBS9LlHxVOv6drKGpccNpDvlO8El8CL3/SU5x2SleBs5duAw9wt/IdUBKl4oSNrhOMfXHcRublw3jDhhFARctyX1Q/19QcSoTZQMB+wZWtlAjnPiX/7fqKcMnhj8MG1rfQobfeGuDkP4XIsbPG91gCw3g+tRnZHNW3YLCrbZ6onRM9FFl48Sax3asjImxprfCjJoLpGcIeNk/u316Y9/iZB16yR4WXSrezinnpWz3zdm3Gf4Piutig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmESNJHPBJtE01xV40GvJOf1Um4cShbZw64KCXJRpPE=;
 b=sJuP+bcoiEIsO0Fa5nCt7Sbmcws6zoOOvRwduCnrIt/fUK8bwucnoAHXEfkMXrCiVIka60X0mDU8UVzxUcxmuQMSUfvHVB+2Us35YrZZPe+IpCkTVGp+UL6gYyz8TCl8WL6yYGKEmukYWZq5EfmK3ADqYCyJOjI6oGXYiRD5hiUUfX5YA09+ueWUuUABT8UUF0px++EwEL2xPuynaf19QewUtSyZYYZ2BFdn/o6A9za56P72/ifEtU+/0oVVLvRqHyWxHlCOC5T5ZL5aefJ6jcRuFIe5hoaoBVBYOZ6N0iZTREwsyZh0os+7G+urkJclK/OKksRLRi50CPhO1irokg==
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 22:47:27 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::c8) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Thu,
 5 Feb 2026 22:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 22:47:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 14:47:12 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 14:47:11 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 14:47:10 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v20 00/12] virtio_net: Add ethtool flow rules support
Date: Thu, 5 Feb 2026 16:46:55 -0600
Message-ID: <20260205224707.16995-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a2f8ef-c668-40d3-7c16-08de65088935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L9Ec15KEWiz/DmZ6MqS9MTkHQImc+y/wfrlT+4APja7MIfaISMMMJx2hbTKA?=
 =?us-ascii?Q?D+aO2u/Kj4YFWxErkNs4Ae+i93fO597w/QTyY0MuyV0c5X974ifd6h2u39UP?=
 =?us-ascii?Q?1gK43UxJdAuKQeiMt7AcOHZjbu8niy0yId24vdiyxIDlks1d3K4u3iJXgZq4?=
 =?us-ascii?Q?PoxGnKYOiG/HSO2QzEfKDn3JcvotCm+j49Wh8dB6QfTBTT75EMSJyyHq3S7k?=
 =?us-ascii?Q?mYQD9YFsL+7QHhLRq/MC86VCy4/qIprjN5dqHWFW1D11JGs8xF9+L5d7jjyg?=
 =?us-ascii?Q?uHuszMt5Rwb2aR3RxVbeY+V7rGsbIpcnOa8M1DkQ7DgUe5ej8mwaMR+O4xpl?=
 =?us-ascii?Q?49oMuOhgOMc2/oeLNr2PgHEqWkEYkHLKtO7mAKjXe4oXR+Yq/qZv4O06+sGV?=
 =?us-ascii?Q?sK+yM6e5gpGXAq3ZbGAXYDH0Ld/9imud6RuUlhEROq0YUCU/EO8Cu2tdi4gf?=
 =?us-ascii?Q?+tVXy/I1UXVNtvhMqI0LU7Z93nyPhKsVIdD/Fd27eCpG/S2g99XRn1OHsfJ7?=
 =?us-ascii?Q?FEgfhOnQJ/q0hsfuphxWTv5H5mQp4h9KoG717hk+pLqkulNT1L6BalHm8Hy0?=
 =?us-ascii?Q?9U7eyjsGVBtCmFPkGKjvBOSdBLMyccXkr/IOjzuh5w1hlHjBiaJBItciKkhR?=
 =?us-ascii?Q?HAv9dnN7idRjZvMlKs1yYpad5WJOcYLJ7gwhxEJC6o7q02CIq/UwwbdqLf3O?=
 =?us-ascii?Q?XM+w2V64p7JDopQx89/+N2NRI5Gz3ilyzw/7IXGv54/FOMGQTM4nDyvG42/c?=
 =?us-ascii?Q?9yjqd9+0L9M2ztYMBY8xIS4OtbudzRSKSb3fHqDDnibIhTtl31jdyWD+0I7+?=
 =?us-ascii?Q?Ao8hLy7I9cZq85qyoKCeYvG9e2TXaGIAbMhq940Gw1TY3D7i63qmNR1xfQTZ?=
 =?us-ascii?Q?v2f74PRkZcu39rIVbSVZAziB0k/+XBpMtjtSWxUGhZWIvo3eq7Y7UAKRAWAz?=
 =?us-ascii?Q?SYD6c8LHpVHLvPK++Zdh6k3UywYNsTdo891kC7jpW/rgdprsEc75utxes+HO?=
 =?us-ascii?Q?85eBsYZj4ymdEedE4xBqztHrloSCsaF69WQCcKvungUGP1hCQv0jvyJmBXZI?=
 =?us-ascii?Q?SvmkgYcY8zZVavEcUp0c+7k9Q2Dzh5lCIfKRuNrsSLT9G9+K6sqY62CyNj8e?=
 =?us-ascii?Q?xf+ilHu4pGH3NP0MyZ2rijbg/Z1R3dZ8gSbSkXUg8cEdRe/fINiVvnnn55Vu?=
 =?us-ascii?Q?sOH2gdRS/uAAPWdR/VBsohqXCnfMOVsnzTPKjapZK1289MueFIIz29OFb/xR?=
 =?us-ascii?Q?uTvLRmmZTJeXJ3aujhv1Go9uSqcPDr82jwqcJAaZDWqv9CcOvLejen74IKpq?=
 =?us-ascii?Q?SElWYfoRJoOB7tGHsDZyIXuBTtHfuwddM9hL0JuOKy5h1T0P066PCp1fXT6L?=
 =?us-ascii?Q?Qes+GYbNa/gRGUJVAWCa0ulLgXj1JHYTFbFdhendD3xB2KsdhFHdb862VwuS?=
 =?us-ascii?Q?u1oFSAMwzOEpfOYxWt6JHa36TH+eeW/D1Teeji+pMLbclXCYyB3WbcPOwpZi?=
 =?us-ascii?Q?iQqcVOExxGy3mO2xl0ATOHtAyGSmvH/Ocz43XKDjEWJKzp8C8siREtABdpyM?=
 =?us-ascii?Q?YsrprPeAwyezfoc8KvZv+D8Bb8hKDHH4jwv3ey07P2yAVl974lQH5SR3F5yT?=
 =?us-ascii?Q?PgRvOh+TBBcrw5KP37sKc/BopY/qN4Xa8P4EuKmykLWxLx0ZHg7vnVOmHZcM?=
 =?us-ascii?Q?8R7BPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	emwQ6aZrbJG8v00Ib4qr47jjnY7Ki3ojNaouDIn5lzKS6QRvrE8x5Qyu3QJC96out+8uGsPTPcp9F3Q++FWPr15NK2iOXVaIM/0Mw3t3kH2LaFLiRDYQiwxDgE1x6kBovnHYJapvFSzufq7/IBlp1QhACnNTnT0nbHQy+pFqlV0Tagx/NFRmhkdxYqImRwHN0N2HOkqKLbQj6aGZA5XVzBJAImNfWwmcyZZJ8M4LynabjKymskFB2A4nrlyRCbV0SHjAMJQb6BFHB9lCWuB04iJZRK2C8ZRSOgLmAaAD9BWLPA3VvYaGhxsUxyEcPpyxT1c5NrVHc17XD9b5EfRjAk3NMMXUXQcBvF3OB0YBrduHvxiYDOxnDEOiiQoU70bMFj0tbY5qnBYzXO/0TdKf6S8cIh3XtFBq3OOcITwCOKDc32X37ZJFBJ1lq9J0ucKB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:47:26.9176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a2f8ef-c668-40d3-7c16-08de65088935
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462
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
	TAGGED_FROM(0.00)[bounces-257348-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9755BF831A
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

v20:
  - Added missing include

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
 include/uapi/linux/virtio_net_ff.h     |  156 +++
 include/uapi/linux/virtio_pci.h        |    6 +-
 9 files changed, 1682 insertions(+), 12 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


