Return-Path: <netdev+bounces-198300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B367DADBD1B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C81188E2AC
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20D1E8332;
	Mon, 16 Jun 2025 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jcZaMWsj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C4F221275
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113908; cv=fail; b=Fi9bCMTENDF9z6B65s70qKLLHU02Bd2mGEpeSBFFxxsp4MF5JTUTM/b0PqAUmXNyrcXvkH7n+jYn6sDnYZf7xN/0drO05zlhSdrd4O0vPe/9cLrfB+JCGOcfDO0iplHRErKu822pfDwDm6Ysa0s131bBV+r6xK6ptjdMNIYj9Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113908; c=relaxed/simple;
	bh=CyYTJhz4yD432UBUGIyYrrkEMgjoXafjTAQwq9XcxwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X8QkZz4+E501AZLkMqZQxLnPKZHDvhVlxzXxpWIp3g0RhlPZubE1JD8Okv7DgMCPoFySoYhY9dNaEvCHaQsCGADiT6xRuB70YWG9Kee/N7TwA6eSRx2GNdU5qyuBNNQ/9QcLS3xdzReGEmGt4JZuDdqJkRy2JVsgu1wf4X72I+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jcZaMWsj; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+coj0/4YrWCOmsgawSFaRBsvo1rkF1K8ZbasKfwA97MbaKxWYbfx219+cKpJJo41WE2H8J5h+bMdnIpisDdmoz1pcCA0JZjIu/5nzQX6vF6YrbNfB3tjQSFWfiVm8hBkoIzilFzoWe6fjVuDfH3k7+Y8mLFi6J5uM8ICzvQTWgbDIf3HMA1m2fHmPeaGZ0fXg5FYlgyakMhcVKKD74AGcymtxMP256y/192LZKRE5wspoin/XZRxWLD76LJBwW7JkCuD2wRLgJSaGIOq68KsP/6mIGXbyJf7/llReyQ1Ezab6elymw0y7ECMm4R8F13Etc9ad7E49LX7jT/sEt76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFbFskTi1V0JoyEv4ldPboP5yiJY4oguyV+DrzmOX7U=;
 b=FZvtvsCUGaO93Aqsfim+raaR1c4mVdHgg2A+2xh/kNBeGtLUW8VYsXGgS6TzScxp8vv3YbmjgDYAlHSdIGL8PK9W3eTBFE8SkFBDfjGdjODt9fMD39TaNPfkHgziqC2GWUFV6v04NZbf5b359NlHsoOASIvRWFv8w6M9P5paBuqqSRYCbZRbFds9sOltEkc5nzqMZuSC6hy7fcflyN/mtSZ3mv6GvX6P7REe1W6smjXf+m8QI2hPvRzydscxdldxC5G2Owz12UnBntKRPRo6DYTY6GCd+AAebzxSax2qaufR78ZTTiM92HbA7P2FZMOWqJ0S+PqyZw/j/Fh9EsJD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFbFskTi1V0JoyEv4ldPboP5yiJY4oguyV+DrzmOX7U=;
 b=jcZaMWsj7sSdOsjI6X/Ws5J9jYp0q6jDjuKyey7owElaE7Co+6tZ8jWGjOtiO8mhZwgvxPSzsWvsNYoOZcZhUBOSrs7x0mINuAUF63IAGFZnBb0beCGMjXckfu1ZXTW7BU9hk/yXDll9J8B9Fd8OQwJDNm1KP6qAktawJXUYGfzxICpXm+XBtbd7hXdJK9GntehAKhD02tb7KW6ZKYt0BcAZrrBVAzNK4P15B32OhFLwwAX1ls7yU30U5AaUKjRWwxDcHN5Nc0ye4d9fQk57eKho/I9OKUQnco3JSGvt+JqZ4uE9HQpP3qg0sggBk+Q9sO5VPnaiyxPwgjlsD2i17g==
Received: from SJ2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:a03:505::21)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 22:45:02 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::9d) by SJ2PR07CA0019.outlook.office365.com
 (2603:10b6:a03:505::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 22:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:45:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:44:48 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:44:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v3 00/15] ipmr, ip6mr: Allow MC-routing locally-generated MC packets
Date: Tue, 17 Jun 2025 00:44:08 +0200
Message-ID: <cover.1750113335.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: ead01d53-be2b-4f28-c314-08ddad276d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ePLvECUs10M0QYviGtolidbKoCSXusHGd+kZ9PwwhYzXC2YiQB2wK0NQ9JDj?=
 =?us-ascii?Q?bekEbk378CuzZjJkruxB3PT8GAga6yZn/RI0Dn7kR0loCahyaBvtLvF9Fa5I?=
 =?us-ascii?Q?B2wQIOA6yDYZV6kh6KLbVHMam4MVlq5PO0rNfwqc4GQ2CG7YF8bxUzYCEsl/?=
 =?us-ascii?Q?flJHrEnuC1ANfTUnGAq9tzp/mgO1lW2qhCjwIZXfxXF+UnFOJjOUSkmDAbg0?=
 =?us-ascii?Q?yoYiJoTZFjmfP4mJ5rGbQfv2gfowU3HQ2677pklrPUrFhW+vATAAxJ1+iQFQ?=
 =?us-ascii?Q?KM4lAfQVsb2/6uO1WqJjujHZs7uiq8JZmqv/Xf9/zrbzlNEHr83ILIlEcf8O?=
 =?us-ascii?Q?TipZ+LjFAsTojfFmM5pYOWkAbEXKmRxdttVxYGnmnCJJ50d/+Quy5QwQlB7D?=
 =?us-ascii?Q?8cmK2my9Rz3nKNixCfXFiEZybMsaeErJC3HdEfyDdCh0i4U0sOP6OcMdgCrq?=
 =?us-ascii?Q?uuIRAeWgBWBL0RMSxiRraNJGp6QtC92BL0I8ceHT2RW6o4QXGO4rzqn+HDyF?=
 =?us-ascii?Q?eMmXXJua+EEXmqBOUJiZlQgoYmYiD+3Y8ds++vjci9S2Xd+3E090Rlbkimrk?=
 =?us-ascii?Q?yANIGawG1F43I+EXXzf/VK1ZGdbuJHQRRfwkb/wkO3dRMLElZ8M2JEQ4hVDz?=
 =?us-ascii?Q?kZ30RfgrT7YU3PXFHtiJpDTqOWzK6CCoejQuxGskOA2XbX152JZc2M5QtALZ?=
 =?us-ascii?Q?YLn17QZh8BKvA70BH7g+0rxVfworizAbTktZaOvzndOAfZVaYKp5fhYJjBRw?=
 =?us-ascii?Q?P+sCR3M34LtsNOXCCAAuRI3Yg95HKE5TBAUcjW48SJeK3jCGhfIiRsWCF5IE?=
 =?us-ascii?Q?IZkooVnCGTMXQh01oG4iznmT3w66b8Q5FcTNn8VDAN3n2TfeBoBnuJT9Wv2W?=
 =?us-ascii?Q?QMb3t7t2bKFaRGzgbTw81IgaTF5CmVTR3ODzUy/x9bG9eggS05AHBhg+S+sg?=
 =?us-ascii?Q?eGHdE7wvw3pCJ8Vn4ZMFWr20msp+2NwpQEQF9od51BzbFsV1D5unx8jdVfOu?=
 =?us-ascii?Q?QQHjPNlEPTaaydVE9/o0+Fj5E5QuNtXXxV09sf5PVxDlxSdp3dQfI4rZWrwK?=
 =?us-ascii?Q?UNSwo9aFA+wq5gEdC4X5q0D/7TqJYgelUCbeMucmJsvrBa9rwu1nycQb70Er?=
 =?us-ascii?Q?UkabKkD99ARnmTdtLD5mb2+qtNIpHVgvj7px9vyncIuoEUmGOx3PlVSy4Kw1?=
 =?us-ascii?Q?oz7fk9q2u0VIWgx1jiBYWLvLjtneC2dO692m8WiqN2OTW64uLsreM3LSzNGl?=
 =?us-ascii?Q?u4JmGIn4ZQnjP3k/X+NNMDm9wwc32wY/69hiQVTPFrFBzTKp/SHpRJL+A94K?=
 =?us-ascii?Q?RuECUIRhZCQ047Y8x2xHlT9UMetA6dbuiAD5gL/T0X/6SQmtpR6GhF1/ia3P?=
 =?us-ascii?Q?6UzTgM3yazLroSy+NhNVJ82fMAbEGtmdhO3vM5Iu861HaYWlwAAUd8NaWJBG?=
 =?us-ascii?Q?A0gANou/nayHUleRQgXHDNZ4LnTB1rvmVUbJP+8qUK/P1o+jCEmMRsteOpQr?=
 =?us-ascii?Q?h0LHsZLSn8AGmST8Gt2xlHCh2rIh10NHD/QG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:45:00.7597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead01d53-be2b-4f28-c314-08ddad276d7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942

Multicast routing is today handled in the input path. Locally generated MC
packets don't hit the IPMR code. Thus if a VXLAN remote address is
multicast, the driver needs to set an OIF during route lookup. In practice
that means that MC routing configuration needs to be kept in sync with the
VXLAN FDB and MDB. Ideally, the VXLAN packets would be routed by the MC
routing code instead.

To that end, this patchset adds support to route locally generated
multicast packets.

However, an installation that uses a VXLAN underlay netdevice for which it
also has matching MC routes, would get a different routing with this patch.
Previously, the MC packets would be delivered directly to the underlay
port, whereas now they would be MC-routed. In order to avoid this change in
behavior, introduce an IPCB/IP6CB flag. Unless the flag is set, the new
MC-routing code is skipped.

All this is keyed to a new VXLAN attribute, IFLA_VXLAN_MC_ROUTE. Only when
it is set does any of the above engage.

In addition to that, and as is the case today with MC forwarding,
IPV4_DEVCONF_MC_FORWARDING must be enabled for the netdevice that acts as a
source of MC traffic (i.e. the VXLAN PHYS_DEV), so an MC daemon must be
attached to the netdevice.

When a VXLAN netdevice with a MC remote is brought up, the physical
netdevice joins the indicated MC group. This is important for local
delivery of MC packets, so it is still necessary to configure a physical
netdevice -- the parameter cannot go away. The netdevice would however
typically not be a front panel port, but a dummy. An MC daemon would then
sit on top of that netdevice as well as any front panel ports that it needs
to service, and have routes set up between the two.

A way to configure the VXLAN netdevice to take advantage of the new MC
routing would be:

 # ip link add name d up type dummy
 # ip link add name vx10 up type vxlan id 1000 dstport 4789 \
	local 192.0.2.1 group 225.0.0.1 ttl 16 dev d mrcoute
 # ip link set dev vx10 master br # plus vlans etc.

With the following MC routes:

 (192.0.2.1, 225.0.0.1) iif=d oil=swp1,swp2 # TX route
 (*, 225.0.0.1) iif=swp1 oil=d,swp2         # RX route
 (*, 225.0.0.1) iif=swp2 oil=d,swp1         # RX route

The RX path has not changed, with the exception of an extra MC hop. Packets
are delivered to the front panel port and MC-forwarded to the VXLAN
physical port, here "d". Since the port has joined the multicast group, the
packets are locally delivered, and end up being processed by the VXLAN
netdevice.

This patchset is based on earlier patches from Nikolay Aleksandrov and
Roopa Prabhu, though it underwent significant changes. Roopa broadly
presented the topic on LPC 2019 [0].

Patchset progression:

- Patches #1 to #4 add ip_mr_output()
- Patches #5 to #10 add ip6_mr_output()
- Patch #11 adds the VXLAN bits to enable MR engagement
- Patches #12 to #14 prepare selftest libraries
- Patch #15 includes a new test suite

[0] https://www.youtube.com/watch?v=xlReECfi-uo

v3:
- Patch #4:
    - Reindent the TTL condition
    - Refold the skb2 = skb_clone() code
- Patch #8:
    - New patch
- Patch #9:
    - Move kfree_skb() to the ip6mr_prepare_xmit() caller, like IPv4.
    - The patch is now structurally so similar to the IPv4
      one that the subject should reflect that. Update.
- Patch #10:
    - kfree_skb() now needs to be in ip6mr_output2()
    - The fallback version of ip6_mr_output(), compiled when
      IPV6_MROUTE is not defined, needs to call ip6_output()
      instead of silently leaking the SKB.
    - Reindent the TTL condition
    - Refold the skb2 = skb_clone() code
- Patch #15:
    - Disable shellchecking apparently-unreachable commands.
      They are actually reachable through tests_run, in_ns, etc.
    - Run setup_wait with an explicit argument to avoid
      shellcheck citation.

v2:
- Patches #11, #13 and #14:
    - Adjust as per shellcheck citations
    - Retain Nik's R-b at patch #13, the changes were very minor.

Petr Machata (15):
  net: ipv4: Add a flags argument to iptunnel_xmit(),
    udp_tunnel_xmit_skb()
  net: ipv4: ipmr: ipmr_queue_xmit(): Drop local variable `dev'
  net: ipv4: ipmr: Split ipmr_queue_xmit() in two
  net: ipv4: Add ip_mr_output()
  net: ipv6: Make udp_tunnel6_xmit_skb() void
  net: ipv6: Add a flags argument to ip6tunnel_xmit(),
    udp_tunnel6_xmit_skb()
  net: ipv6: ip6mr: Fix in/out netdev to pass to the FORWARD chain
  net: ipv6: ip6mr: Make ip6mr_forward2() void
  net: ipv6: ip6mr: Split ip6mr_forward2() in two
  net: ipv6: Add ip6_mr_output()
  vxlan: Support MC routing in the underlay
  selftests: forwarding: lib: Move smcrouted helpers here
  selftests: net: lib: Add ip_link_has_flag()
  selftests: forwarding: adf_mcd_start(): Allow configuring custom
    interfaces
  selftests: forwarding: Add a test for verifying VXLAN MC underlay

 drivers/net/amt.c                             |   9 +-
 drivers/net/bareudp.c                         |   7 +-
 drivers/net/geneve.c                          |   7 +-
 drivers/net/gtp.c                             |  12 +-
 drivers/net/ovpn/udp.c                        |   4 +-
 drivers/net/vxlan/vxlan_core.c                |  23 +-
 drivers/net/wireguard/socket.c                |   4 +-
 include/linux/ipv6.h                          |   1 +
 include/linux/mroute6.h                       |   7 +
 include/net/ip.h                              |   2 +
 include/net/ip6_tunnel.h                      |   3 +-
 include/net/ip_tunnels.h                      |   2 +-
 include/net/udp_tunnel.h                      |  17 +-
 include/net/vxlan.h                           |   5 +-
 include/uapi/linux/if_link.h                  |   1 +
 net/ipv4/ip_tunnel.c                          |   4 +-
 net/ipv4/ip_tunnel_core.c                     |   4 +-
 net/ipv4/ipmr.c                               | 169 +++-
 net/ipv4/route.c                              |   2 +-
 net/ipv4/udp_tunnel_core.c                    |   5 +-
 net/ipv6/ip6_tunnel.c                         |   2 +-
 net/ipv6/ip6_udp_tunnel.c                     |  18 +-
 net/ipv6/ip6mr.c                              | 148 +++-
 net/ipv6/route.c                              |   1 +
 net/ipv6/sit.c                                |   2 +-
 net/sctp/ipv6.c                               |   7 +-
 net/sctp/protocol.c                           |   3 +-
 net/tipc/udp_media.c                          |  12 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 tools/testing/selftests/net/forwarding/lib.sh |  46 ++
 .../net/forwarding/router_multicast.sh        |  35 +-
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh   | 771 ++++++++++++++++++
 tools/testing/selftests/net/lib.sh            |  12 +-
 33 files changed, 1225 insertions(+), 121 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh

-- 
2.49.0


