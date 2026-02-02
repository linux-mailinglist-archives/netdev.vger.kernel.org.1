Return-Path: <netdev+bounces-255941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPnOHyrbgGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:13:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7276CF6D3
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C537E302FEBF
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283103816E0;
	Mon,  2 Feb 2026 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NfgjR4Aj"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794EC37F8A3
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051953; cv=fail; b=QYrxBIWXSe5Nhr0GIBzVKm22y87mxMYXaARVbMIiDa1amk1jyJlpwtCKyrt1T0gC1Fb4ITX/cyyPocnlOggmQ8C9cSJGpvEL+poQ4ZboqjLUKpNZ95jFGgGbGspIPhNHbQyQSAhnvGWHerGKgdNY1cO1/qXO8HLgkpm7YKg+ApE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051953; c=relaxed/simple;
	bh=NX+w3sVHPcn8JvfLRMY5MRWBOZKOz8UDzf6xawVJckw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZcBhgNzcBvdHfwlc8LarVY+UnBV4w1RR5+7gHREMxIrNSeTvohFrvISI7uD0DFQMbo1d3yl3LZ6H8tX6o+2E0PchVtyZY11RzrwvVjFVHspQ1jnje1TPEc9J1wMg7NzdA7Y3dvtn4XVUVNBzKcyptexSIxYf65bOQl9EE4d2mgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NfgjR4Aj; arc=fail smtp.client-ip=52.101.56.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZyc4kwZgaCR9uaGnsBhxsgcHiQDFIUHerQLCDivXBjumiM3TZ1FSb5gPvvWCqhQNWoxv5f2kaKFYIJQrM1Px7RlwN7UhCk0amGlQhgryIMFkyM82m9VwvPiBwgWgjRTtjU/TvhvPaqE72NpWURlQDRC4wKtGOHiYxWOmaHJL6Hd7SPtJzSnn28unAfOo/oLwzlNa+lWTOWmtySwzhT3XnOhIoRuV7Ppt3T4zpdGSf7Z1TrJhVrUZABja80jr4ev+0dOfvI/bKeB+n/ZRp7HWvEA9wJCKj478IQqhLTGT9FcgZLd6tNmXoVO/R+3OuG4tGnOEZWs4CXMDXHIHTvURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZF7/SQCWVZ+D8SUFA2jDYi9yy92BKT04Gt6r16MtvI4=;
 b=XzrMgtl8crdKGmS3t8bnO1Uj+iPi9RtdLfnLr08bDqOSJ+CLfjANdg7BdIMHzKUJIVbSvneqh/eH5/xIH05lND9n2NKeZKY2ASxRzfr98HPv6Etf+xnZRgdvuxGScCVf+ATmLC9y17406eWjdVOs0zWb7AG2qTgRc+U+FSd2tJYz9yw876yOmfd1EYB7p3cCh2qLVkMvp7c25i6jKsDFgBZWQhBUeeMEubdi1+F0QwUjLfxIjL2tLNzEOD7ITtJ8d+NQ+rt8lz5vkNKhSbaug6+nT55xVAs8vlbjfdT2/aiwkDM4hZ/RvqUTe1xBn5KWGXa/mjafHV1r9N2XEzZCgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF7/SQCWVZ+D8SUFA2jDYi9yy92BKT04Gt6r16MtvI4=;
 b=NfgjR4Ajhrdx1VDE4Vnesx71aNzKAkSoqKkZCp0gwIjbAG0SzcmloBgPhVe8odP/aziTOP7lKRebQM2tsLZcv2nCLmE9W3YFDzU3uhWTEbSPDPA7xzdNiA4kHIThUe6IQiQ8SV/IjCOj9BtBqt2Z82zJwEOUAgO29+sT9DyQnWCM2Q8vN6OZPf8RNun0tm6B7zaBKMpHXqj/AIaCbm8s1oJ9vsQp8UWjsOGnKIjWJ5otAMh7/bUpcgBt5tZNtqpAPD4it3bjIpHBQKzS/urez35YG4TcrUG1hB08uzNX7ypG65E7Nvj41B5hxA26hoyiD7EYJePlxDuVLcRvjwElqQ==
Received: from SJ0PR13CA0101.namprd13.prod.outlook.com (2603:10b6:a03:2c5::16)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:05:41 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::9a) by SJ0PR13CA0101.outlook.office365.com
 (2603:10b6:a03:2c5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Mon,
 2 Feb 2026 17:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:05:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:05:23 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 09:05:23 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 09:05:21 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v17 00/12] virtio_net: Add ethtool flow rules support
Date: Mon, 2 Feb 2026 11:05:06 -0600
Message-ID: <20260202170518.9076-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 49031b5c-da61-4d5e-5fa1-08de627d4b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ILQN6zTGs+VEdXvNsgLnDwDHdjvIzFZT4LpLadoIR+2fBHh4xVtzRmBsZv0H?=
 =?us-ascii?Q?5rVcR/YiOy2yP+hVrllzO5i5wVRLMq/zw45NWEncvAmhOBfgFZMxDjFitMcg?=
 =?us-ascii?Q?eDANY0NpyL8aVSsz/KV1NH05s+1tmViG7+3pAKKDRdNc+bd5QjKhvOy6PQF7?=
 =?us-ascii?Q?JOcXrQ+CHpBLp4w6DoJFPlBIdSgDYPPw/HGg4kBHd/PIIufiUwaozy4slAkB?=
 =?us-ascii?Q?5CTEAjrOWsZ7SGVk1wsAkgKp1oNfdoRPDh1J+OPmDL/2Bx2waE8+rf8smXz3?=
 =?us-ascii?Q?dC7CV9M6wgv8LyEaxyUUC3MKOOqz9nYEdhn2JrAseEN7Fh1xmoDE7kTNz4Ru?=
 =?us-ascii?Q?5N6o4s3uVC7aEX0LpHBvptw5TTEXf6xhxMoLa3B21ZYNu3Lcj/74cdjuN4fi?=
 =?us-ascii?Q?P6nc/NMNFHs+/s+Ce4v4YafSC5mNwmN46NBf86AEGFqLaQ++v5bn9usbcVn0?=
 =?us-ascii?Q?ZBsrH2iI5JEvHfAb5UzXeyFh9TBcZhYe4FZAjOSekyz+fgNSR68B+d7WXfRL?=
 =?us-ascii?Q?kVFbJC28wEXOwf31VsottO0qq5Qy4myLf9t9zQEJ2Ky0wjEM+Spwbiih1cFB?=
 =?us-ascii?Q?StOs5aXVZAoJchG86SOFTfHnnNz905X8Kaa7vC17WFTF80eII1kMCy18BfWc?=
 =?us-ascii?Q?MXcGQjgp8ONkhkR+JJAPHlHegCMxMYmXOR5eGD+3vqSnPns7Vi9Ia4f4O2a4?=
 =?us-ascii?Q?mIZzgooAHq/7alp3PHAcJUAdIeyCbFXIYHnH5pp7zuEwU3OlL9NhteiPEFWa?=
 =?us-ascii?Q?8YhsBbbAcv9c6PESn1LHIyGnGViJ3dIyI8qHTbgshwB9aZ1yULljE9NVKdqw?=
 =?us-ascii?Q?3GeaHXybCgYEztlrC48OkPuAmAJibA9j/gj49sUx4wFH5i7gkOqQGUHxDLAE?=
 =?us-ascii?Q?e40uhRChm1DVOkAOayZsX4efatcCEnRff11ADYkALdRLRgqWLrvKXZ+3CgUB?=
 =?us-ascii?Q?08DzTaN0q20RSJ11k/ES3yecvC4MDSYOaYkhJgtcGau0IRC2M1unE9J6Zk9w?=
 =?us-ascii?Q?uMLu08sJNNa9ayXfghKq5g5WLi4ZSiRTEcewXKO7k5DUtVg6q3yOAdxULYoo?=
 =?us-ascii?Q?yrPEJPCAV+HWkqjTG3KNWLxoSEANKi5Mj9x03nTjede1OFM3fqzOg/62Hd31?=
 =?us-ascii?Q?Hx/Lou75ond5rXCaBkg74sFKj17CWPCvzwEMWb/oOFJVoSZPhr4CWriwyF1m?=
 =?us-ascii?Q?K7z2rs/jM+w+exl0dYf+HyStgLFXBVQDu8QUOiRuIUAoPsbV3C2X/Q2dllir?=
 =?us-ascii?Q?x2Kjednge1SYFROwtVQ4YK9kXksMuZWtznws7jz7gjNaiEyLUUXiu6ni02hs?=
 =?us-ascii?Q?vvEXgIHVUnOkr/DHAXdywoTtDN9dZmvSEVKdHtY5LolNLChZP7Uho25p0oSj?=
 =?us-ascii?Q?04olh9NWhCoA6c46ZmLr8UE4tGJNVZ/vmAgj4D/9dvRTHz+nTxxd3Fwdl9ZB?=
 =?us-ascii?Q?Wu1fVI50/UUKCRAdqL0ZRWysfrEFqKcXtJSN0N0iDFU8Lsa7yof8Wsf8lZrK?=
 =?us-ascii?Q?LH/GUcyeD8LvInVcojIOqlfl6gOvNFyCY+Ezi7Pg68MtJPDzAOJBSprdYQwC?=
 =?us-ascii?Q?69BwHMZPcMfyWyVwE41C9RUngMT6zKCLVC6AtbJ4wlhhrWc1SVqdUyxkVTa0?=
 =?us-ascii?Q?lZc9nRER7/hAYHMuzhYfAugdEdPPHqrofYeA4RXy56SskurJh1TD6UlDGwZg?=
 =?us-ascii?Q?XkF64A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QWA6nH+UPUj0W4L2aJkr74wg6NaTGvr7600XGZwSOBRhbZN9LTGeyKa18M9FofIT68B85bcmOwcUXMqQjV3xsa3UDoNCZN+1XAuNV1R/cFoyH0YKpb3HboVu/Jpl+xBdNvVBCfo+U/iNgUacpM2g5WLTusV2HNyvE490OHbAaoP5dPPzTJ/dJNJ53bj1BCDRR1EyUfDNhyp1uOR+3e/Z6Zy5EFKwDL0SO118iiDNbdhdOrh5uSYxTMkPiXqYs8ADd8G1SEwcYcI7f+k4+Nl8+njBCgnZ0H9BXk71+6qopPOjfAYOj6dm9UWx+4f5mATHGY4Zu/zKsTYW6N7Q/24eIi4C1atxsZIidtNpoMotQ1DDKmyBfZbdozflFCdIz0EALpPxH68wuWI+x0ItAyt/gm2HudrTtM4MS8Qi/9uOOIb8nf54IyhWQrK+LUYMtqoo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:05:41.0225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49031b5c-da61-4d5e-5fa1-08de627d4b81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255941-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E7276CF6D3
X-Rspamd-Action: no action

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
    netif_running. AI

v16:
  - Return 0 from virtnet_restore_up if virtnet_init_ff return not
    supported. AI
  - Rebased over removing series to remove delayed refill.

v17:
  - Properly handle unaligned reads/writes. MST
  - Fix use after free if init fails during virtnet_restor. AI
  - Fix memory leak when validating the classifer vs caps fails. AI
  - Added missing includes. MST

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

 drivers/net/virtio_net.c               | 1221 +++++++++++++++++++++++-
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  173 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  121 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  155 +++
 include/uapi/linux/virtio_pci.h        |    6 +-
 9 files changed, 1683 insertions(+), 12 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


