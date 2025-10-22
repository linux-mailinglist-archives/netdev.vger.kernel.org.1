Return-Path: <netdev+bounces-231547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F513BFA5C6
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD2219A26BD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 06:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF802D7DE7;
	Wed, 22 Oct 2025 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="okLr6mI+"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41D2F2606
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116152; cv=fail; b=bQNE89cixwE/JUl2NlJbZpm4qnLym5EU12MxBR0Ndpy4aUm3MJwr7yBQ+iRUmSfSr1IktHOUMQ2TRqku34ZR4D596A89JK1EmDgiPKpgofvKWRhCoWNI0PFCMSuS7EishgqTxuek1yNlf4p/xOqNA5QU8bsGHjmd6SAAoJuXfYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116152; c=relaxed/simple;
	bh=gqkInpkJedEGIOBNLkW1qg7hhLbCeCXe8kJd5EAeHYk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XDx++gqzzWDWKO9QfmRNNA+WXpfPXfUoU+6iO8lsb5YEBDkUkvZHE7jreBSYrWTexGOHaVkEznbPUjMHbkX+CQYglBwmPpPcu4pVvUJ8qpCmsKKkpOftKATt45f1ffL8G7vMpqsxxWNlXeFdQLnSLlAnXhWPFI6FAVJ1gof/vb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=okLr6mI+; arc=fail smtp.client-ip=40.107.208.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq70fRJIxa++l3Qk2rkQkKGVL7ZranZKp64cl2WbhW4TXsOzWZSsgSXYnUggyviwg5tTqB2P5pMHrXOg9HdRkivMiE7pTFe/YFYsCr6nLt5Ocagw9h7swXNWMhbZR5lftpQVIXIAZwBimBZsXqWCWfw9a7YaX3j3O6CUweXG/W/O1d3OtwuBIFKuRLzXdXQT9TJceP2eRssBkhmTiZv0Ac0RERwPh+XHfFwEcamUS/Ssby/19bj/XQXXnhCfIBWMCwdt9W1TG2aT1I0bM9Qder5sCAFbRC6lIW8phWcH9nkksY+GCzOBNgH15diw3GJhDa3qhwMtxPLG7S6ga0GshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqAVFEYK0ijt+ylgRlmfxPS1rkhVR+h7heVPXmHo+jk=;
 b=xC2SQjElHK0Frf8mBgFTZUBcO8dlQ/ycVFOUrhuoEoTpnoaP3fvOvWfjBGzNt7JqHhLKOFPdw85cIXqSsoAPXmRYHCFqYlW4pHDk6G53lXmusRqeJ5ofSC5w2D2R3sQPyc+n1Y7lsA8NgijdD3s8hNoyBwhZN26WWAG/yPkbrWV3nsbn4RQAddeN/KHeCE870tcsDId8ZY3pbTlpn3OcGdqn8IcUXLU8/V7+1JSHM3/QhTlBc9i6L3L3dckg70fzwf/Iv34dgd2CCWHw0ifO17T9LxcXc3y/xzeRI0v4CGcchYBXwtmdeDnAxl1UprCRV+UMazQoTlgxsdaV1B6ugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqAVFEYK0ijt+ylgRlmfxPS1rkhVR+h7heVPXmHo+jk=;
 b=okLr6mI+qz+bwYMB1heIJcyFGko4d9/8++V366L+kiNHakNaJD0mrrNnubdzlEoE/4+oEXRyvAl0KQ3y0f0Ab+9E6A+AlYBmoRlxjXpKJAIpIeWEgQKAFIG1u+gp4eT0Bp+2GbZkyMuJ+yeqeQSiDKVd/OWnJMuMQTZey4hZ1RhFIkHfJ2uWIytT3AgjYQM726ZnWiBIuIaclOwAo6aGeSu2UixmpRGh/nex69fkWL/ywMNUMPxlTXQen8Kr6GbxvVbN6Z6zepNXRMZJjeDBEdIue34Mf2MPHiuqyylxMR6UnivNKJALVnytb0bGB/wASLjMYk+ZoEwWIBgKGvT3AA==
Received: from SN6PR04CA0086.namprd04.prod.outlook.com (2603:10b6:805:f2::27)
 by PH7PR12MB5999.namprd12.prod.outlook.com (2603:10b6:510:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:55:45 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::d) by SN6PR04CA0086.outlook.office365.com
 (2603:10b6:805:f2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Wed,
 22 Oct 2025 06:55:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 06:55:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 21 Oct
 2025 23:55:29 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Oct
 2025 23:55:24 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <dsahern@kernel.org>,
	<petrm@nvidia.com>, <willemb@google.com>, <daniel@iogearbox.net>,
	<fw@strlen.de>, <ishaangandhi@gmail.com>, <rbonica@juniper.net>,
	<tom@herbertland.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/3] icmp: Add RFC 5837 support
Date: Wed, 22 Oct 2025 09:53:46 +0300
Message-ID: <20251022065349.434123-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH7PR12MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 868f3bf1-f100-42e7-61ae-08de11380649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0cG1hctMprKg2VwkxruysJwR9STuUvXBuMFZugCqe2MiGeAkJRqWflr+fcRg?=
 =?us-ascii?Q?wL9U243s0V/55QZSOzQXYLTfaQJdL88jx+f5G1IR7TrvQxA6qAaZbXT+LO9X?=
 =?us-ascii?Q?ZLJq6ShIyTghZ0eTzEaDSrfA65fG54k4UAgp8jEdp8aMrbiJuC5FEKZS377+?=
 =?us-ascii?Q?958MZwROGja8BW6JK49/4oBJN+DGEkK1CLrhqagQtFh+lgnXTHMxCPxvBn55?=
 =?us-ascii?Q?bn67P7LNFe4RbD3KkY248USBkP46YjpkGW8kG6VUTJCVQr4hq7a9Ix0CPvQR?=
 =?us-ascii?Q?66yoHE1PfSHNimYsHJg+haI1UvGSKuHIjRr89s/DQCCmgO8Fv0LRvwQJ+Tpd?=
 =?us-ascii?Q?VKhpdyY+oDUsPVEyIBjmGqk9QFdKydz7cv29sUKNFdAIvtCl3KyhtRGemfz0?=
 =?us-ascii?Q?F5r8ez+uOhjOqDcqhibOUX5M3XOMTUbGqLU1K9kpto3r5Ov6Wz1JvuVAxxkF?=
 =?us-ascii?Q?/AY1MLm/07eZIfCKxxThBVwSr9G+bDWfQn5xLBUJdAMptg9JUaY+bWj42SON?=
 =?us-ascii?Q?OBxzj2b9/ECU7LQGqrM2vhNIb6EBoxat62SjhDNUpEi8oYapJ0+khEUtGEkZ?=
 =?us-ascii?Q?npZNd4acA+N+IeqrO4YzKQHGgmhWnUaaa6TwLl60EkFq2Nbc6rGoI4ZFlIVK?=
 =?us-ascii?Q?YDirVrny/IZ1APBpxvB7Cy6ZeRfLeGGxM1Mf39gXwmx1LRfPupjeNhFIMZhZ?=
 =?us-ascii?Q?1niNHPyIz4T6fwC0wzsEbC202tOK2hFSeDrsxXP/q+4ageCkd8k6BlbllvX9?=
 =?us-ascii?Q?6yna311xS4dSCYqZ8vGOy9wcLJtNjQn8pnlQUIzziMLkRi0xmhFUSHpJCMYV?=
 =?us-ascii?Q?Y5zID/VgVTD6Ps7IkehDaGtUMds7nANON2cW1BW2J580GYPQDr4TbCUxWF2C?=
 =?us-ascii?Q?lQQVAhvJlW+z6ADsLWUB94PTVQq3Up74F+ACrLNcGQ2MkMqmXBlseDHPHh7e?=
 =?us-ascii?Q?DPVbCerrkMKhFwuqN9aoVBQYETntiys3CPuvBS+F92W4e/MsSzgUS1riR/qA?=
 =?us-ascii?Q?pqs2B6d/a8i4R/JwqzAPL4qxve0fU88E4rttbQyojNyUXrKOypdGaQC1PcFf?=
 =?us-ascii?Q?hjDgEslFMTBdN7R9jqYEa9U4NVGXr4HqKqNvoY3yoLwZD0MXd0Vps3nWYINu?=
 =?us-ascii?Q?KakhGlccvSs22sxNFsUDmPvRFheXNckPzB+1ivJaKssya2LsBolCefGvzRvN?=
 =?us-ascii?Q?QRGUHKRL5eX92d2c5qXjlNaFnEYBxgj8YTqeBq1bJg+u6rPKPiyC5alFQZJU?=
 =?us-ascii?Q?Umbm2K0cXyzKmeyRP2CApDKeMECY8khu0MLKxJ2hhX774iHuotoG8+diKL8e?=
 =?us-ascii?Q?FnJpL1b0vvAqYzooYQfpOQ1NsQBE/kAC6pTk0u6umfekAqU2pAMaCGuk6dk5?=
 =?us-ascii?Q?By97MEcIs+YjPn6f+P2gFWBPka+atxbQ1allaEHKJ2Qrt0JmDLafAwqCAG7f?=
 =?us-ascii?Q?XKmvK3uyDZGe17L3iwBZ2g5i3ZhMJXJi/oAUtE38/lzR4cMTQna00VJu9RHP?=
 =?us-ascii?Q?6qKl9WhoT5oFL05PvdQGWei2Eq7a0NZDfx6VvxB8YbJ2kTaDJS9ptVIxhX0c?=
 =?us-ascii?Q?ProIVv0km8SFm6BqCzk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 06:55:45.3103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868f3bf1-f100-42e7-61ae-08de11380649
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5999

tl;dr
=====

This patchset extends certain ICMP error messages (e.g., "Time
Exceeded") with incoming interface information in accordance with RFC
5837 [1]. This is required for more meaningful traceroute results in
unnumbered networks. Like other ICMP settings, the feature is controlled
via a per-{netns, address family} sysctl. The interface and the
implementation are designed to support more ICMP extensions.

Motivation
==========

Over the years, the kernel was extended with the ability to derive the
source IP of ICMP error messages from the interface that received the
datagram which elicited the ICMP error [2][3][4]. This is especially
important for "Time Exceeded" messages as it allows traceroute users to
trace the actual packet path along the network.

The above scheme does not work in unnumbered networks. In these
networks, only the loopback / VRF interface is assigned a global IP
address while router interfaces are assigned IPv6 link-local addresses.
As such, ICMP error messages are generated with a source IP derived from
the loopback / VRF interface, making it impossible to trace the actual
packet path when parallel links exist between routers.

The problem can be solved by implementing the solution proposed by RFC
4884 [5] and RFC 5837. The former defines an ICMP extension structure
that can be appended to selected ICMP messages and carry extension
objects. The latter defines an extension object called the "Interface
Information Object" (IIO) that can carry interface information (e.g.,
name, index, MTU) about interfaces with certain roles such as the
interface that received the datagram which elicited the ICMP error.

The payload of the datagram that elicited the error (potentially padded
/ trimmed) along with the ICMP extension structure will be queued to the
error queue of the originating socket, thereby allowing traceroute
applications to parse and display the information encoded in the ICMP
extension structure. Example:

 # traceroute6 -e 2001:db8:1::3
 traceroute to 2001:db8:1::3 (2001:db8:1::3), 30 hops max, 80 byte packets
  1  2001:db8:1::2 (2001:db8:1::2) <INC:11,"eth1",mtu=1500>  0.214 ms  0.171 ms  0.162 ms
  2  2001:db8:1::3 (2001:db8:1::3) <INC:12,"eth2",mtu=1500>  0.154 ms  0.135 ms  0.127 ms

 # traceroute -e 192.0.2.3
 traceroute to 192.0.2.3 (192.0.2.3), 30 hops max, 60 byte packets
  1  192.0.2.2 (192.0.2.2) <INC:11,"eth1",mtu=1500>  0.191 ms  0.148 ms  0.144 ms
  2  192.0.2.3 (192.0.2.3) <INC:12,"eth2",mtu=1500>  0.137 ms  0.122 ms  0.114 ms

Implementation
==============

As previously stated, the feature is controlled via a per-{netns,
address} sysctl. Specifically, a bit mask where each bit controls the
addition of a different ICMP extension to ICMP error messages.
Currently, only a single value is supported, to append the incoming
interface information.

Key points:

1. Global knob vs finer control. I am not aware of users who require
finer control, but it is possible that some users will want to avoid
appending ICMP extensions when the packet is sent out of a specific
interface (e.g., the management interface) or to a specific subnet. This
can be accomplished via a tc-bpf program that trims the ICMP extension
structure. An example program can be found here [6].

2. Split implementation between IPv4 / IPv6. While the implementation is
currently similar, there are some differences between both address
families. In addition, some extensions (e.g., RFC 8883 [7]) are
IPv6-specific. Given the above and given that the implementation is not
very complex, it makes sense to keep both implementations separate.

3. Compatibility with legacy applications. RFC 4884 from 2007 extended
certain ICMP messages with a length field that encodes the length of the
"original datagram" field, so that applications will be able to tell
where the "original datagram" ends and where the ICMP extension
structure starts.

Before the introduction of the IP{,6}_RECVERR_RFC4884 socket options
[8][9] in 2020 it was impossible for applications to know where the ICMP
extension structure starts and to this day some applications assume that
it starts at offset 128, which is the minimum length of the "original
datagram" field as specified by RFC 4884.

Therefore, in order to be compatible with both legacy and modern
applications, the datagram that elicited the ICMP error is trimmed /
padded to 128 bytes before appending the ICMP extension structure.

This behavior is specifically called out by RFC 4884: "Those wishing to
be backward compatible with non-compliant TRACEROUTE implementations
will include exactly 128 octets" [10].

Note that in 128 bytes we should be able to include enough headers for
the originating node to match the ICMP error message with the relevant
socket. For example, the following headers will be present in the
"original datagram" field when a VXLAN encapsulated IPv6 packet elicits
an ICMP error in an IPv6 underlay: IPv6 (40) | UDP (8) | VXLAN (8) | Eth
(14) | IPv6 (40) | UDP (8). Overall, 118 bytes.

If the 128 bytes limit proves to be insufficient for some use case, we
can consider dedicating a new bit in the previously mentioned sysctl to
allow for more bytes to be included in the "original datagram" field.

4. Extensibility. This patchset adds partial support for a single ICMP
extension. However, the interface and the implementation should be able
to support more extensions, if needed. Examples:

* More interface information objects as part of RFC 5837. We should be
  able to derive the outgoing interface information and nexthop IP from
  the dst entry attached to the packet that elicited the error.

* Node identification object (e.g., hostname / loopback IP) [11].

* Extended Information object which encodes aggregate header limits as
  part of RFC 8883.

A previous proposal from Ishaan Gandhi and Ron Bonica is available here
[12].

Testing
=======

The existing traceroute selftest is extended to test that ICMP
extensions are reported correctly when enabled. Both address families
are tested and with different packet sizes in order to make sure that
trimming / padding works correctly.

[1] https://datatracker.ietf.org/doc/html/rfc5837
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1c2fb7f93cb20621772bf304f3dba0849942e5db
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fac6fce9bdb59837bb89930c3a92f5e0d1482f0b
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4a8c416602d97a4e2073ed563d4d4c7627de19cf
[5] https://datatracker.ietf.org/doc/html/rfc4884
[6] https://gist.github.com/idosch/5013448cdb5e9e060e6bfdc8b433577c
[7] https://datatracker.ietf.org/doc/html/rfc8883
[8] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eba75c587e811d3249c8bd50d22bb2266ccd3c0f
[9] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=01370434df85eb76ecb1527a4466013c4aca2436
[10] https://datatracker.ietf.org/doc/html/rfc4884#section-5.3
[11] https://datatracker.ietf.org/doc/html/draft-ietf-intarea-extended-icmp-nodeid-04
[12] https://lore.kernel.org/netdev/20210317221959.4410-1-ishaangandhi@gmail.com/

Ido Schimmel (3):
  ipv4: icmp: Add RFC 5837 support
  ipv6: icmp: Add RFC 5837 support
  selftests: traceroute: Add ICMP extensions tests

 Documentation/networking/ip-sysctl.rst    |  34 +++
 include/linux/icmp.h                      |  32 +++
 include/net/netns/ipv4.h                  |   1 +
 include/net/netns/ipv6.h                  |   1 +
 net/core/dev.c                            |   1 +
 net/ipv4/icmp.c                           | 190 ++++++++++++++-
 net/ipv4/sysctl_net_ipv4.c                |  11 +
 net/ipv6/af_inet6.c                       |   1 +
 net/ipv6/icmp.c                           | 213 +++++++++++++++-
 tools/testing/selftests/net/traceroute.sh | 280 ++++++++++++++++++++++
 10 files changed, 761 insertions(+), 3 deletions(-)

-- 
2.51.0


