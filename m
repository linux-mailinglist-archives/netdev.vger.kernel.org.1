Return-Path: <netdev+bounces-168455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B610A3F10E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEB6420780
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA632045A3;
	Fri, 21 Feb 2025 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IAB6ZYtP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04851EF08D
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131655; cv=fail; b=rdHi9Xv1Q/h65J/tHgf9mrsdK0B1taVSWnG9JdC9a029xYoXuG5GbR7Wd3JoNf38yw7Vav3w80EM1lfSG2SXOdL304V6DsKsYMpikYaDx95ldtMy/VL30umdwIJ7tX0LVJCy6WqnBSJaMoTtMsRl/uKmiihRTLokTkll56TQjM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131655; c=relaxed/simple;
	bh=LP/W991KwvVjZxLNerbhUQxJuxSIJzhoG82UwwstnYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jL5JdM12uKBiA6+Jw+6VQzrMo7Vhby0mA7CQ8mff4sw3ElOHcQEe0s3tve34H3/4oRjuWHjkSKrJP2cKKl6N2qJVY9+VMz7VeWXXG00V5Oc9FZAq1FRG3m0Qjy9BWZVwPq7fqNqRmfNhYJkUzYAo0EbtdympAFMdwFYW7A4AD2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IAB6ZYtP; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkjzfPkTswKRHZuBBgSkNhFmu3Hbm93viHMt1I34VoAokZxi/ifTXrzlR/pMIR0tKsy9Lmr5LeFvuHXJI9IwRENHywJvHQKSbQnplkKsI7i7VAWGmU5KYEy9/Qwy229/8rhWlAkpd0I5cgKRJ93Ks5l/Spi3ip39BW9SzhYjkrNQEbzEoZM6CIuHDg0MYYAssRxn051aqZY0Nl0diPfXgAzJz7UOBIsq648G1Wo1hMZvKjUYSzWRlaliBRIAn7qkJVfy+7QYYW6Jan2KPWvQ0GXJ+4/OrpmmfOOeU5/IlqYynzaPOXiEF2TSagipC3dCvU455UAnny8We1e42q/lCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rCKYRRRrJMNZWsE2RAfL87JWgvboe1iLyEwaottWMs=;
 b=wczixyxKYTnHuF6UbG2Xzz/Hh0czpmQ7YJUDPnQtbEm+RchcMD2faWj/FIO6IEWyOMGckFSNQNxO5/DrdFnJ6iSIY9JVHbKtwgnnfZwQ/jhTRCFjsMO1xLhh5qq8KWWSIyFpuJaupCnG7FcyPEbEKjeTDQEYOWsVhrLRA/ir1QmWm4d7d1TO/m03lVN+tMDgEHqzKKfbLacpJIyRA9GiEEhY1KBdpRrtG1EOx7d5K6Dknofh9lL8IW4k2hXI9yQMNhCXyTEmM5Aj08AurUTO8D0/X8hNkWZKf3lzkrZUHM/iVbmQQS9XysPeY3AL+d3VINu14HyhLYVXFNMDIh1meQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rCKYRRRrJMNZWsE2RAfL87JWgvboe1iLyEwaottWMs=;
 b=IAB6ZYtPCofXfkvK1M6B4lM8ifKNyaPQidRLF1X9NFA4WMFMVNTJpLw69ieLSbhhJg0/W1f/kESz3t8ymon0WY8vZGz4btu9NkmPz60pbGOJcWYop6VYGY5moLiESNSLmBqONZY+deMdc8KhsVllHlWg28DJstO1VaXdHqdwi+QWEChtVZsUmWr5I4HBgFFkDQMFyXAZwa2M9E+VqL47O2pHxCGKtDk/BRuosGllnFZ1CuEOnq6uQF6zfpRgVgIaLmkfDbpkQ3m2kkkhcsIey4NcOEN9yUwTkTujFXZrXrDIg03W6OT52SUKsOO2e8tgqWH7p3NDNH6InkqTDjSTlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:54:11 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:54:11 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v26 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Fri, 21 Feb 2025 09:52:22 +0000
Message-Id: <20250221095225.2159-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0610.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::12) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec50abd-276e-4e97-9dd0-08dd525db0de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VOxlTIykQEl/LDlJPcj/1TbEWvaQQJUbTkwO+vIJHhqOl6L0LkhlDNPollH+?=
 =?us-ascii?Q?uNcpUytVLlPmDUpLUeYhQYE/KKGcTFhkb/pF4xYcTmVNwSGuGZiASYa2w+UM?=
 =?us-ascii?Q?5uMC92zQSgIq2TfBxkbwgbA/06tC7b2DFOwQcsRf0yXPppSdc6eYTvB5eKrs?=
 =?us-ascii?Q?nHStXN/blQfEb3UCAbj/i+frAgzO9DMYaT10+p0HI7yn/J2/7OCMbfdNRkUT?=
 =?us-ascii?Q?5DeLBxNbTh/E7o4zEZk4gRpvZRToDhCcd4RgwakZBp6h0xi+GUXmwTlfFR+C?=
 =?us-ascii?Q?Gvc81Mmud2xiMt7gFN8RPWGEfNs8pejjIcXuqqN59LO1JHajvkdIyRITMshD?=
 =?us-ascii?Q?9JdKmG77U26T4z4zkm5cwPegYgEHTYVHVJSVGPA/ed8miu6vZBpfKQDLex7L?=
 =?us-ascii?Q?bYUMBWWivw+4CtzeSxoroMHqvtH1BRR5HbiHiXM2CyuLRssmFDIkQ1MLapUI?=
 =?us-ascii?Q?2lO78PZ/S2aZG604clyPwJ/6WBWuWxz7KAKrkOG5WbQ/W/W1QTTHFJ+9keO1?=
 =?us-ascii?Q?Ch4SfqH5NPgl2JgEtYR+E9TnPBrKgT79bzgy0AlAqaSyrWpprSn4PKxGQaO2?=
 =?us-ascii?Q?qJqlFwG99Qi+GwJMQAVcXUURaIwRcoJ/EaiDmonBA1PfRHJX1YRKtlqr1jg4?=
 =?us-ascii?Q?OTzSyeUfS3iF/NxFk+/NNzz6F6br7MxZb4vXvYxWmn2i9mqcx85+8+c7Q7d7?=
 =?us-ascii?Q?hfHo5NNI0ezqsdotT38F2Utmj6/M9O/Rp8yLaKA6FKAgkMcP+QDWRI790x3A?=
 =?us-ascii?Q?qgzWTHmi0R3qG2kwaMq/CKKjOFeMboUvRJTefMZXh6E12zimjZv92ES+qkN3?=
 =?us-ascii?Q?nBDXN2DUdOgMC16E+5z7qDxxgGQ+uXUuWgO7MqtyGV1qySJkmenWwAzd5rpk?=
 =?us-ascii?Q?zEsYAi47Udzustfw3ibjD31zxGPvhns5iW0OX2mUiLWqQcoc3bYmXAJpvsEO?=
 =?us-ascii?Q?KGe1SXZ+A+KDMD7dZNSrRrZk9QiD/5Q9PmQeq4MjgMouJRqxqjoczvi8QZqq?=
 =?us-ascii?Q?+kkYP86xg5i4V1+QtorpXhYRBJmAuLUzGBPFnwknmr7nwgbMrtAiYed/yOhb?=
 =?us-ascii?Q?sbsoIE9E3DLvOwNhnZ6IIbA0FMYAPGDz32v7bDQcqwdtzaldy6bQ/1bn0hyM?=
 =?us-ascii?Q?7ihq4pROvICVT80fEyuKGL9aoSOHyp743gjhbNaIzoNxmyun8fXK21qCAtld?=
 =?us-ascii?Q?HHppSd5N5tq22D7BP8Bg+gC45XKrpDEFw34daUvNsH+dEcsaYm1PK+Konx2l?=
 =?us-ascii?Q?MrQEcGSEAQGKn4Q4X8UAZ11azlAjLvtSTHh3Y+iYp/v3FP4d4bp6zaGp4NDk?=
 =?us-ascii?Q?Nrktn0xg5W8Of29sA8bZ9xXXHJZ+q+eTXFaIxREM6zcAUfMLx2CgkeQsbaKe?=
 =?us-ascii?Q?Pkv9eKDmG1Vk+RS0xcaVPOhtawWL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q9JPDVe/SffWhcZjzLY15RqbbHqxYJTsJmnOz1iwHTw2H+Wd8ZkSbhgfy5EX?=
 =?us-ascii?Q?CzNdyFlwfZPWVBo/zNDQfE+zbP+9ONFCbO/drlSsHgvQ9uatoti2PmcAXNu4?=
 =?us-ascii?Q?nG5J2hrI7/5YEBy0VltczE+r/i2rRJSpznsN++0JEv9vHs+zgB5O4y+KE/Yp?=
 =?us-ascii?Q?6AXi8WXXkPzUNBcXvdm+3g+nhPio7ukVYjG4fneaznFvoH2x/mVZhtnaL8AS?=
 =?us-ascii?Q?Xep4y7ngcOYdB8Ra74xPCowYZ+v6a6x3T2D2DZxsaXI1F5keq6XIANWKF8Zn?=
 =?us-ascii?Q?EXCXqm0x94L4PmxcbNIRCR22sWWB6HNI0aSo7Heh/mDa6uIOdIIhPgh/KBAW?=
 =?us-ascii?Q?kLA+rgmioMYWejj8uOtythhZFOpkVGDt5EUF1GghxCMWIV2ALngWMAZUxABq?=
 =?us-ascii?Q?TioYef8PFT1SS37AqtNmwyzIoXcKC6duHxr0fJ6PjDl3tAb+HQ0v/7V45ILb?=
 =?us-ascii?Q?XVc6NUg3+KAsCzWXMmrVi5PQCEWvU1WCVRZJDNwcosuMV3ycXkKnKCkwMivZ?=
 =?us-ascii?Q?A1Ufq8+AuR9DCtn0zdlzUvONNyNpTrOOrV4ac0erePL8HyEjvNleOoKzds8U?=
 =?us-ascii?Q?Lxv4ue6GCc0uNUKNUhQjVDwXRHZPIhFXJs1wCgFm1/w75qLpC196nRIj3OiK?=
 =?us-ascii?Q?qQZErEwARe0mXmN/vv8jm++9Ys16d1Tz6jtYvJDfV30CAAQhbI4+g4cJ6s97?=
 =?us-ascii?Q?SNXeN8e223MTzh6QiB8v0UwcIcxyXoMilx8BcWygJ5ssr//KsUKg6heWtuaO?=
 =?us-ascii?Q?XKzcGdEc6+myzyQ8n2zgydbOb4eW98jDewA5i1vX8ubOrFo+SpMo7xi5eg/5?=
 =?us-ascii?Q?J3qBgYkAI6sFaGhCpvJFLp6S4Glv3Z2zYjfi6H8wM0jwZe20qtnlnSL+zQmW?=
 =?us-ascii?Q?fjLOmwt7iL3O1hjvDQA+KpZd4eoWosiXm5XfIWDz9QXaQ0YP+r7h7gj4kbWr?=
 =?us-ascii?Q?jTL4aowykYtZqQBmISwNv2RhYTai438nCEDWSt5wdpyTz9FL/4nlQBELc3vq?=
 =?us-ascii?Q?GxfmXUhb2yOf84LNaYDKseq6aWBj4s/8A14KNkI1xe/FgauEbi0R7UPlpUx+?=
 =?us-ascii?Q?XEQuMX4v+wgODb3X83XCPtpc5+syp9+EBvEMBmzegqSYXOehqzSBGHnjhcNt?=
 =?us-ascii?Q?p4UrLhKgyEXRcdHAohXoMnH4PMbZE6negONsf0rqEm5o8ly2XQUk795A8ZYJ?=
 =?us-ascii?Q?r9d4SkYZV5ps8KU91k339g+dWt6pScE38eWK4u9aaykJR+6BOWq7jgI4vI25?=
 =?us-ascii?Q?PbcI23/j19EXahtohuefTGPlzG/ld6Hhb5ewuwuiibv4SNyf2om5u65zX0DM?=
 =?us-ascii?Q?uUe1gXN1qf31USMCmfWKjp5/gnkkcKaJRG9q77QAhACEk9uUmUBZxeItGRiC?=
 =?us-ascii?Q?sc1u+maQSWLuYgu0vq1FRlMPT0rQybUP5xLs3+rKQHly7cy/npEMlgo5DlKX?=
 =?us-ascii?Q?fMCiPfVaO419KbpU8PUlv0hiDVKvD8dQb8yeJC0xwa9Qcf/dQBIL0QIOHC+Q?=
 =?us-ascii?Q?wPtACkokZUZdXweao4vrOciuZuPApXdlzwxt5K36ALbmO2F7fLyT4X5/IPBv?=
 =?us-ascii?Q?MHYeWkO7v2eDEaCwijUi2zGq3MCr1Nbz1tNNR+QD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec50abd-276e-4e97-9dd0-08dd525db0de
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:54:11.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFKrqvmNIVrYPaNgrj+0T+c2cufrxjP/u2NQdxoBelk0EUdAK81z7NnpJnu8oSBT7BjxxO9JKskSBGP3ZScmuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for every NVME request to perform
direct data placement. This is achieved by creating a NIC HW mapping
between the CCID (command capsule ID) to the set of buffers that compose
the request. The registration is implemented via MKEY for which we do
fast/async mapping using KLM UMR WQE.

The buffer registration takes place when the ULP calls the ddp_setup op
which is done before they send their corresponding request to the other
side (e.g nvmf target). We don't wait for the completion of the
registration before returning back to the ulp. The reason being that
the HW mapping should be in place fast enough vs the RTT it would take
for the request to be responded. If this doesn't happen, some IO may not
be ddp-offloaded, but that doesn't stop the overall offloading session.

When the offloading HW gets out of sync with the protocol session, a
hardware/software handshake takes place to resync. The ddp_resync op is the
part of the handshake where the SW confirms to the HW that a indeed they
identified correctly a PDU header at a certain TCP sequence number. This
allows the HW to resume the offload.

The 1st part of the handshake is when the HW identifies such sequence
number in an arriving packet. A special mark is made on the completion
(cqe) and then the mlx5 driver invokes the ddp resync_request callback
advertised by the ULP in the ddp context - this is in downstream patch.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 146 +++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 479a2cd03b42..9b107a87789d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -684,19 +684,156 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 	mlx5e_nvmeotcp_put_queue(queue);
 }
 
+static bool
+mlx5e_nvmeotcp_validate_small_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, chunk_size = 0;
+
+	for (i = 1; i < sg_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size - 1;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (sg_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_big_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, j, last_elem, window_idx, window_size = MAX_SKB_FRAGS - 1;
+	int chunk_size = 0;
+
+	last_elem = sg_len - window_size;
+	window_idx = window_size;
+
+	for (j = 1; j < window_size; j++)
+		chunk_size += sg_dma_len(&sg[j]);
+
+	for (i = 1; i <= last_elem; i++, window_idx++) {
+		chunk_size += sg_dma_len(&sg[window_idx]);
+		if (chunk_size < mtu - 1)
+			return false;
+
+		chunk_size -= sg_dma_len(&sg[i]);
+	}
+
+	return true;
+}
+
+/* This function makes sure that the middle/suffix of a PDU SGL meets the
+ * restriction of MAX_SKB_FRAGS. There are two cases here:
+ * 1. sg_len < MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from the first SG element + the rest of the SGL and the remaining
+ * space of the packet will be scattered to the WQE and will be pointed by
+ * SKB frags.
+ * 2. sg_len => MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from middle SG element + 15 continuous SG elements + one byte
+ * from a sequential SG element or the rest of the packet.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int ret;
+
+	if (sg_len < MAX_SKB_FRAGS)
+		ret = mlx5e_nvmeotcp_validate_small_sgl_suffix(sg, sg_len, mtu);
+	else
+		ret = mlx5e_nvmeotcp_validate_big_sgl_suffix(sg, sg_len, mtu);
+
+	return ret;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_sgl_prefix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, tmp_len, chunk_size = 0;
+
+	tmp_len = min_t(int, sg_len, MAX_SKB_FRAGS);
+
+	for (i = 0; i < tmp_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (tmp_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+/* This function is responsible to ensure that a PDU could be offloaded.
+ * PDU is offloaded by building a non-linear SKB such that each SGL element is
+ * placed in frag, thus this function should ensure that all packets that
+ * represent part of the PDU won't exaggerate from MAX_SKB_FRAGS SGL.
+ * In addition NVMEoTCP offload has one PDU offload for packet restriction.
+ * Packet could start with a new PDU and then we should check that the prefix
+ * of the PDU meets the requirement or a packet can start in the middle of SG
+ * element and then we should check that the suffix of PDU meets the requirement.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int max_hole_frags;
+
+	max_hole_frags = DIV_ROUND_UP(mtu, PAGE_SIZE);
+	if (sg_len + max_hole_frags <= MAX_SKB_FRAGS)
+		return true;
+
+	if (!mlx5e_nvmeotcp_validate_sgl_prefix(sg, sg_len, mtu) ||
+	    !mlx5e_nvmeotcp_validate_sgl_suffix(sg, sg_len, mtu))
+		return false;
+
+	return true;
+}
+
 static int
 mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5_core_dev *mdev;
+	int i, size = 0, count = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	mdev = queue->priv->mdev;
+	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+			   DMA_FROM_DEVICE);
+
+	if (count <= 0)
+		return -EINVAL;
 
-	/* Placeholder - map_sg and initializing the count */
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
+		return -ENOSPC;
+
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < count; i++)
+		size += sg_dma_len(&sg[i]);
+
+	nvqt = &queue->ccid_table[ddp->command_id];
+	nvqt->size = size;
+	nvqt->ddp = ddp;
+	nvqt->sgl = sg;
+	nvqt->ccid_gen++;
+	nvqt->sgl_length = count;
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
 
-	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
@@ -719,6 +856,11 @@ static void
 mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
 			  struct sock *sk, u32 seq)
 {
+	struct mlx5e_nvmeotcp_queue *queue =
+		container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	queue->after_resync_cqe = 1;
+	mlx5e_nvmeotcp_rx_post_static_params_wqe(queue, seq);
 }
 
 struct mlx5e_nvmeotcp_queue *
-- 
2.34.1


