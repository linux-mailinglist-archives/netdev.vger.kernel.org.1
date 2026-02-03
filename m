Return-Path: <netdev+bounces-256466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FzJLOR2gmm+UwMAu9opvQ
	(envelope-from <netdev+bounces-256466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:29:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E31DDF42C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D32330A7A68
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694ED30FC32;
	Tue,  3 Feb 2026 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dXTRmsjg"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A523D37106D
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157773; cv=fail; b=dQTMEIa+XmjMABfmBiNendBB1ZHnh6w5wfu89TwroZ2GCgc7cQAcSgq5MTZdCXGDGnECsDD4qWXHJOVZ5VO4pSXvksX9oAZ699JlGiPBcH4SaSvjzpqqYutI3fFMjBnejHqNymvKYNdpRfa+dRRWLQbIl0n3nUL4tmjX9MY0/tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157773; c=relaxed/simple;
	bh=XbwDEWXlnAcXpD83JvZT3paTXz7m+LLGyGVNJutiXgE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iqjsOLkoTmQP2VuMKLWZw2fD4xEStcIsYzQObzu0Ym+5Ra3NyrUISR9DuyvmtfOMg13NTmeo6naBooUKJSYOIa6eiC1x0WnX9xyCHkWiWWScxluSHJV3a3+pyWSSTWPrpu4Vd4IepRaU/uyrFP+LhMn1fIGCb6h64PYfTorj31g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dXTRmsjg; arc=fail smtp.client-ip=40.93.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEmiWmj3eIm7FrmpTmX9d3xQnkVhCvMPHFN9uzt+MdIiPsWMUBzrHJabms0gxLkKLO0/8Z02eUFEPnVpyaOIx51tdHyQzhPu1AtLtZU3vHWKo62nFYsYygqTtg/1jNlDxvSMouMAjfhVdivjVXp6MvdtKnnV9VTvG7loaNeikRzDqXopWczpH8A3qJv4EhJM5p1sBj5wY9tTukMaqjUz+dEy/BGUkCOFO263FY00//ULiYVWMrDDP9HttvGEPUFi4Y3jRWEF/+LPr0LjhaMZdFlB760xsKWJ8+Mf5QWiLROtk3cs49raXzmcu1fc0su5rjj7lq6XIwZDPHAtetbPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaHZpNbsWLyXTxO4WsIG/YwWGMXDmR4C1a2JuQtTgtg=;
 b=MUEn/o8uCuI0Cw/fktFWPtbB1CWh3mzGXtMa+Ks2F7lqTdwCNIequAwdJm0OA5zGc/T79yUjPH5NSIyNVaszvHjKr0dr2ZqzPQD7HYrfTEsOD89+pQVxNJ/Q5zH7PCVJWqXVQpu6mIntAD4t3Ne0sBrDYvNNevalD4IgJo3vArg2HMmnvyjBF39V5LXiOB/9LH8wBTiHD92IHvmELlScMGf3dWSC4nCwHMHE+IvBlpA+/jD/ZTfEYnAeEyPJ1zIVkeH6OmS2mJWvA79e7k91YDIbYkqMq8Vc/p3EeAh9IvcDZwGv1IZ932ukiqQE0WhuVeG0Ud7Ge8q4h3MROe3RDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaHZpNbsWLyXTxO4WsIG/YwWGMXDmR4C1a2JuQtTgtg=;
 b=dXTRmsjgP4gYpyl3HIm+xRbK/iM+w/Y+/1c9Bi2aePH8HoTRvEtVX6K4HhSOa13ZX6ztEaPmZQ/xL8Jq2Za49+jX3VDg2VhLytgSp6PgJ2faAIvsUfszBSlGtxPUCXmI3eNkH6+wlLnVv10PrbKGniP9yVBHvdBbUW0qkKNacSfTjCWTRY3Bp00reVhPDB0/xJi5p0L3C+ewdw783fNOXx8PGvPg10v8o9JY2qcymg5/Zcs6gpYcTS2cwdpTvk/BwtrSZ38IILpB+iNEGk7Vv0Q1kPZYCcLTygzHf5og0YeIRIckcPgu48/XfIv+h0sPlAA9s1fWkOTj2gtg2eWgJw==
Received: from CH2PR15CA0002.namprd15.prod.outlook.com (2603:10b6:610:51::12)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 22:29:17 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::d8) by CH2PR15CA0002.outlook.office365.com
 (2603:10b6:610:51::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend
 Transport; Tue, 3 Feb 2026 22:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:03 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:03 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 14:29:01 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v18 00/12] virtio_net: Add ethtool flow rules support
Date: Tue, 3 Feb 2026 16:28:47 -0600
Message-ID: <20260203222859.4219-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 606c7cfa-2ff7-423c-8f6e-08de6373aa95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NIjxljbwVzh+mV+w5w/CXoIfzA8waWfRnWqyoS4m9CsRIYBt1gNvP2WMCzt4?=
 =?us-ascii?Q?AigwQjLhFEJFtARGDAXkDOKceODnlKiDJcGWP9cb9bRyZDfFVk6M41q02ReB?=
 =?us-ascii?Q?MHCLA+C3wGW9/pDYVUdyGAwAdoZXQcqgNq8UfcQx2zJJ8bQUzK8gXaewe7p2?=
 =?us-ascii?Q?Rz+3vX18eHSiemb+F/dakXadMQTFvJUGwUhOPhDXBJ5LPS6RzXGZNkSJ92WD?=
 =?us-ascii?Q?baJV2q4ksZuyDTdbp1IN/eZmLMC7RyU5N2lWg19xYm63FPJ2IsPXAe8fQbDt?=
 =?us-ascii?Q?KDmJqPcDY2XhXRwg2EDilsoHv2QHXWCZ5IQAuCYGj4baJUNEeL1OYcwhvpiQ?=
 =?us-ascii?Q?cMc8oVfFqsIjZvFcZQ1zw8wF3MKSVXBSNACt8VS50dexOzeROK4pbNrC+ujB?=
 =?us-ascii?Q?AXOVr6Xi7VunCPw42+2htimwyoWMb/yIgk8ncy0WgEbS2RQGW/xPe4XBQjo/?=
 =?us-ascii?Q?5TD0/LhNuoja2eHAkC+9kbmKcHPo9NmSz3Ul2EcdBXnZA6t8eagqJpi0Uzto?=
 =?us-ascii?Q?FIhDlTrsgUYo2uTKI1XQM1QNSbtWUe0x2AxjQpXEmQjL0uCOfCabVcddyAq+?=
 =?us-ascii?Q?OT3GAVZ+ZdgzxHWxjB63bL2TI7uqzIqLS3o7ABG+EaPHJhRZPAL0ZsoS06ix?=
 =?us-ascii?Q?yE7URmuErulmuBMmMd1iZCI8r6dkXe/dI7xZsNUXa/pN4l1cl6TdkXL4logD?=
 =?us-ascii?Q?UA5kk43a/DzN65EifLFdJOATS4CtdMyku7SbM2gzPmcwqtPUtPmwT+IQKg9h?=
 =?us-ascii?Q?vEXTPnVSgrrZbiUmmA2EU8uI3E+XT1yV2SIXsGUcqfFgPVAcUSQPvFyV0WFr?=
 =?us-ascii?Q?hByt50dwzqilgc1PGygq6Um3b4cXLWqBGNwZIG8272n3xpmA9bK0Hg1f+YC5?=
 =?us-ascii?Q?v/tFI5ukm/r+MJM8Jr3WaV3yvMo//Fp0M3XDetU82jKl+F9QX0HLklPSRspG?=
 =?us-ascii?Q?gN2R9OxWgtMhkH43AeZUCqV3SJD5a+V8ccZPsXmnrhRGaQTgvxIAwigTzpq2?=
 =?us-ascii?Q?b4ZDsg0HVU9QrwGNuEd5EgMbKqt3cO85u4zcEAeArn7ickyUEdKoH/hAh9C1?=
 =?us-ascii?Q?OggDnL8X3QFK9jU1SDacr9sxg3UeGyfYZfa0W8g67cE+hUQQa1vQnhLtCJ3r?=
 =?us-ascii?Q?ko1kvxRcoVGn3+Eipefryir7ZEQP8S8S3CAbiZUgWQh0IiMz/9GCDQm7x9As?=
 =?us-ascii?Q?Juc1iQ+tZyFLQztDX4BLwnN57ObZntoyMzu5aeNvO3v2/CSkLKstT41+HPNV?=
 =?us-ascii?Q?xWP9BsPG2+dJWoqGfyn+sNlcoZt/V69MIdN+T0v5pQ1UX+TxEJ4YYJ0JzOZg?=
 =?us-ascii?Q?WLdDyCVmMqW5Lp/WCgEXSZvdl/VMordVivZBBcsgG24uhzso+yZ5h3EC4bwP?=
 =?us-ascii?Q?998PcQ1vYnHv3YYbvrOq0pEzFVkNRvwr61B8TUBsc3BLeMPTFER4qKPVXRhv?=
 =?us-ascii?Q?OLWN7D2LqjuCa/LC01oipWg8LLV6jTjEDFvvBpTmUFCDoNUUVPHWZ6Mki9Nb?=
 =?us-ascii?Q?UbyY+kvffeSlEpRZBYnHwv9IVoPjPh5jRDXRYfkeN79UsHaW1hsIVJckVYBs?=
 =?us-ascii?Q?fPOlPE8RnBa3DdqWXpYaIpGSrP0TGw1X/UYGGxBb7TyfN86/gt0G2Dz1NOn0?=
 =?us-ascii?Q?eD++VDqCqD34LW3jGC/EOQVztnr2WYWFdIPtjYac3HezcI5Ak5X45wJUjLpC?=
 =?us-ascii?Q?vULmYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mQDIAloo/uivjLCvG6zwgXAeCg1YeJ5FQxcmnpWPDzincwsB0YaqfmS1YdbUAYDh1ymZ3hddbcAuJuNaK36opaU9KuRYSaZssAaQq7ObhRzcYqzaX/miM6P8IZAAZ0PZO7Rr79HWGXAcP9ku/sPGKLBLC9pzR18boVfCFTpyC794+OfK6we41ADwaFbV8JksZGLn6CCnUZyzq1/Ec+oDSZOMy4wF8WnFFJAV2ByY1f7g0cykqAS5kigpimsstNOAocbiyauOlrX7lxGXSIFDQzTeTx7gGExoyTVNwHBX/WGZuY1NGZHb7aOAXMzjrBIr72n2IiaKtygM54TydT6OuGyRVKiwB1oX8JZZXwf5wwJKvgsEFTA/So/ycMpom3cAofbCTIP0up/5F091q6rimI53vA3sPGjpquacTM9BYFRav4k2H/4XLBR2zIIltDtL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:16.6162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 606c7cfa-2ff7-423c-8f6e-08de6373aa95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256466-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2E31DDF42C
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
  - Added missing includes. MSTA

v18:
  - Validate selector cap lengths, instead of just checking they don't
    exceed a max. AI
  - Add __count_by attribute to flexible arrays in UAPI definitions.
    Paolo A.


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


