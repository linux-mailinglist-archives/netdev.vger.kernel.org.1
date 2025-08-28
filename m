Return-Path: <netdev+bounces-217614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E18FBB39442
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2021887DB5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 06:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8A72727F4;
	Thu, 28 Aug 2025 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LbVHu9ve"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDF513957E;
	Thu, 28 Aug 2025 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364042; cv=fail; b=jKD8T29G6jx5S6YML9EfMoKJ2xfYqZbfAsXXxwoOsJ9rPCEKgQC3IBu0FBEO26IOMOtkXUsspd9JhMtwVHFsSi35oH0s/2Pio3y+YRXgF/cigVr4zZy5sHfbocyYIpHyOSTh4IV5hhoHw2Xpksgu+F4XaLmJJrBtqtsTUwBM+EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364042; c=relaxed/simple;
	bh=65i+KIHwFrd8o/jlq9hCnJK7tI8aQqoU5NQpNT1J+qg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jsOdM7rLknbUniBqsRJj9i9nVJwuj+Qa0No+udt3JD4yaTLGCLILbYFo+fcfY7xipv/1O3dPHT3YSzALPD/+ecfkEmQjnkZKJWgvlsgc6D36p8iuBmb+UjBkV0oD+Hx51DA4ixF4dbHEuvsL1BexBAAUyN9LV0pXd8sYG50sxuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LbVHu9ve reason="signature verification failed"; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AI4B/yTXEuQEnpVAN4pslxMDno4Gr4AjetqphKr+lpy3SpCTpmvgIY/hEaX8J/yZahr4adhOtvQ4gZe1iGUI9FyWn86Ws6uYvLDlq4d+gZkDvhS1fwnOdxn5Si70gwcO6fBrEEiUK0bXq3ItGAmHjm+k5R9pNgBJoyacAQzzbpVvt7cFASmPriwLRIktpSya0x0BmmshdMWs1j1JKRlmkyN1A/mm0FyRC1/wwEl3WOJm+FMue6vTDVqlcE682MOwjaIqqXsLRAZNvdv6/lbdmGcspsUY+6B2yGhXLa5lNCKFWqeUR9/ta/hYElQr3bhLjiLOskBWWKUWRD96sy+gRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mwhaPOL0Jbc5r/yr2XBi0EbeEL9aS9VCXrCaENq7nk=;
 b=DHUgIVKGNjo7MUGZ6uefu/EItkTjYB2XbuXytGYbwRNCT/bMJvLhEIMqIOp2B+/0WspL1ddskMieXj/6G0yZ5YZ2rKtZad44vxcLzlprp2/jZRQ3Y1TAQ2kXE1/xrn7sKNjGK+GBlGMp18m8yb+uf95iJuaUEJYNR1tzSj3l4avN4MlDZyklae1USkLHqfNsNjPTj9Nj+6mtG+ho5o/DshzNhkhO57DkhYYAXbaIu8D8iA2cN103k9QCsEZc2nTTMZTzZgzVJhhomBEJhV60HOlkxET9EP9X2fbBOPTZ8fYrtHnbT7Yd/pEtR9ahcD38HGoHIFXwBYyPCeHNxYC1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mwhaPOL0Jbc5r/yr2XBi0EbeEL9aS9VCXrCaENq7nk=;
 b=LbVHu9veWdL/wMKaUpXOCRgwx/9UBKYgHBNCJHYFm7Kd0GkhTjY//z+g440/p/cCeizYjoHmqiHAS5FhFAPb8zJwLKeLB/fnr6A8s+mpkXvUFvLODKWZP1ybrO/4kkCZTdU1eqNdAE6cizKnswXqpHR1l2x40ibSa47abhxwDobve6QNmAqb5i4JKYPp7FuE2WmYL9Vz7RV5yv7dmqXVurVw3kHI3d54qqE8Zb/NxUB8qTdXwCjJkGemAfSPQ0xBM7Zj5BcURhnBbs1vRHaSDOmKEqfFrd5wR5sg1Ju8+REavdTzhjN/zhdqwLbM0bHmnsrQp5XdVwuE2kn8/P1P8w==
Received: from MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::8)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 06:53:57 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::23) by MW4P220CA0003.outlook.office365.com
 (2603:10b6:303:115::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Thu,
 28 Aug 2025 06:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 06:53:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 23:53:48 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 23:53:44 -0700
From: Shay Drory <shayd@nvidia.com>
To: <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ozsh@nvidia.com>, <mbloch@nvidia.com>, <tariqt@nvidia.com>,
	<saeedm@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [RFC net-next] net: devlink: add port function attr for vport ↔ eswitch metadata forwarding
Date: Thu, 28 Aug 2025 09:52:29 +0300
Message-ID: <20250828065229.528417-1-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f35b30a-e747-4462-1167-08dde5ffa911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXlhb3lRcTcvRHNuTUFSNVhydDM0WkFCZ2NJZFRRUTNSSlhjckREMlZybS9X?=
 =?utf-8?B?enpJb2xFV2w4RHZLd2NRK01VREFaT20xdnZoSEtBc2duQ2VoZUtTSjFPbFFR?=
 =?utf-8?B?OStkdDZPdmtiSDNEcmcraWRnVFJ4ZktVcFJza29IMHZCdjdKbzdiOEJKUk5T?=
 =?utf-8?B?NUtsbTBtZUZ5aThnZ1NFU204YWR1a3Bvd2FUUFk4T1NybC9COFZlSDkya1RL?=
 =?utf-8?B?bGpmNGJodnlZdms5Z3N0SHRwTUhySWU3a09xU2luYk5zekVncFJZYVg1Q0Er?=
 =?utf-8?B?UHR0QmhCbDBZQUlDRnM2ZHlrSHc0MmhXemk2Z2JLUVZTa1A3aFJOc1ZUZytX?=
 =?utf-8?B?MzVCaFRzMjdPbSsvOTJFbCs1ak9WZ1N4MFBDcHFlbHUrRGJnNzFHbE5SRjU3?=
 =?utf-8?B?aXo0RkQ3MDU3SFFPeGZwVGwwRk1kdCs5YmNZQTNDYmdZaE52cnljdENJOWJO?=
 =?utf-8?B?Q0xpNmVQTWw4akd2cTU1R1NFSkl6RWlHaktNMU9LNFRESnErNU9jcVBPbGxY?=
 =?utf-8?B?M25INTk0RjBybGwycUI0b1NhR0F6NUMwNEFEcGlYVXJlZ1ZPUHAvNWFCODhm?=
 =?utf-8?B?VUlVMXYzbmR0TnE2d2VnSnVJYjdibkU2a1Q1VGRHcWR0akVEaGxSQUgvT0Vw?=
 =?utf-8?B?TGUrVEhiWTZwWVAyT1JwemJqQ2Q4TzNKbUwzMnBBZ0cvU1g0ZUszY0dUUUlw?=
 =?utf-8?B?Sk9kS1lOSHB3ZTFDTU02Rlh0Q2ZPV0djVk9sWThsYzZMQmxRb2FZUmVTTER3?=
 =?utf-8?B?L3U1OUZmMENuOWxvcEhSa2kxYWVOazV1MEVLOFNleWo1YUwwRDVSdW9VdW9w?=
 =?utf-8?B?NzBuZGZJUGt4ejNsanBiZTZBZnNsQVF6TUpSd0ErN043eG1vU01TZzliMGFl?=
 =?utf-8?B?Y05FRUFVS3h1akE5ekQzcmJGeGVEM2JIZFFFRGU2TFJtWk5HYUZNTGthR1ZI?=
 =?utf-8?B?Y0VqZHpaQ0NNdDFmSlgyVDUva1dGajFacGtjQTZjZjBoaTJNaG4vaWtCYW1Z?=
 =?utf-8?B?S1dvWW0yMGVvK1FMYWpuNnFWcThGSG9OZXBtUG9pVzVwanNsN0JzdUNiMmZC?=
 =?utf-8?B?MkxaRUJFTVN2TzEyMExtdjNEZ29Hc1ZwaU1vc29uUWNINDNEbU5ha0pXRHNJ?=
 =?utf-8?B?bXdRWktaR1Nzbk1TM1I3NlpNcks3VmIrNEdJYm56Mm1USTl5R0NaMVNuWkFX?=
 =?utf-8?B?cHU5L1NlWWZUeFdsZnFsbStPK0xTTWZKMGVJQW9lV3BYMGMrbTgwcTZFamN2?=
 =?utf-8?B?TWpqbHhUeWhwWERlQi92TEZEUEpjSmRQS2RmQjQ1ZHByLzlZTHhkNmNnbUlZ?=
 =?utf-8?B?WEVoK0xDTHlGbkpqclY5bUpRWm9EWUs5b1pKYlFySnBibnltZW5ZY0svWEVz?=
 =?utf-8?B?R2l5b3JlTFVWTHlFS2d0WGNRTEI2TXZrSVhkMUVabDFsK3N4THZVN2lxL0lQ?=
 =?utf-8?B?MEJVZjR3cDUxakVjM2MwVWJEMmdtOHV2aE5ZWThhcDFLZzVyanl0cHZzUjJM?=
 =?utf-8?B?dkhTVk42bEIvc3BMdk9xKzVrTU9MQWdFSjNVeS90YnZmWExxZTlEcG93dE03?=
 =?utf-8?B?SjIzTUI5UERWUWdNcTBjM0N0bGxrWnFWY0FPUlEzUmVOaE1UbG04ejJ5NHBW?=
 =?utf-8?B?Z3VFa014RVVnSDNFcFhxWnM1Q0ZCclk4Y0JVNUhnditGUCtPUlhjMDhrZTNH?=
 =?utf-8?B?amw4T0hKVEd2U1VvZHQzTExSN1o3VG5nbTBIcjdKZFdMcnJBWVZNb2RXR1Zu?=
 =?utf-8?B?L0YrMlJvT3JON1JqZkdyODdPcVBGV1VsWUphb1JlN1ZBOVlqQVFpTDlmTHBy?=
 =?utf-8?B?QW53anovSUVsa2E2MnlITnhHc2ZEbUFGYkR5QWNtNXNyODNEQ3dWQ2hCdXVX?=
 =?utf-8?B?ZUhaelZEQkV0OUZVNGJYdGZocVhMazg1SDJLSmVVN2VZdjVzSi9zOHhTdk5j?=
 =?utf-8?B?bGU4ZVIrOUxybTFOVGxGVGc5cGwydS9BK0s4WmhURlVQZkdUb1NsT0FVeUV6?=
 =?utf-8?B?Z3lyUEpkZ1RUZDk2alZ5RmJXN3RJQXU5bkt0bDlyK1lGbzlEUXZJQThPVkxj?=
 =?utf-8?Q?GINgWZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 06:53:57.1325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f35b30a-e747-4462-1167-08dde5ffa911
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456

In some product architectures, the eswitch manager and the exception
handler run as separate user space processes. The eswitch manager uses
the physical uplink device, while the slow path handler uses a virtual
device.

In this architectures, the eswitch manager application program the HW to
send the exception packets to specific vport, and on top this vport
virtual device, the exception application is running and handling these
packets.

Currently, when packets are forwarded between the eswitch and a vport,
no per-packet metadata is preserved. As a result, the slow path handler
cannot implement features that require visibility into the packet's
hardware context.

This RFC introduces two optional devlink port-function attributes. When
these two capabilities are enable for a function of the port, the device
is making the necessary preparations for the function to exchange
metadata with the eswitch.

rx_metadata
When enabled, packets received by the vport from the eswitch will be
prepended with a device-specific metadata header. This allows the slow
path application to receive the full context of the packet as seen by
the hardware.

tx_metadata
When enabled, the vport can send a packet prepended with a metadata
header. The eswitch hardware consumes this metadata to steer the packet.

Together they allow the said app to process slow-path events in
user-space at line rate while still leaving the common fast-path in
hardware.

User-space interface
Enable / disable is done with existing devlink port-function syntax:

$ devlink port function set pci/0000:06:00.0/3 rx_metadata enable
$ devlink port function set pci/0000:06:00.0/3 tx_metadata enable

Querying the state shows the new knobs:

$ devlink port function show pci/0000:06:00.0/3
  pci/0000:06:00.0/3:
   roce enabled rx_metadata enabled tx_metadata enabled

Disabling is symmetrical:

$ devlink port function set pci/0000:06:00.0/3 rx_metadata disable
$ devlink port function set pci/0000:06:00.0/3 tx_metadata disable

Signed-off-by: Shay Drory <shayd@nvidia.com>


-- 
2.38.1


