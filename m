Return-Path: <netdev+bounces-202464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776ACAEE031
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC76E3A90BC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EEE28B7F4;
	Mon, 30 Jun 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3TgPRrP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AB928C037
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292542; cv=fail; b=d+jYGf5a8Iqe6NU522D6AYXyeAPnI1Ub36cTILSIqO21nnAspb0xb7+vxzaZK9XvzSoc1uBqi+GxAmROA38UzKG+FLh9KDNHFsj50VRgZefjnmvCigaV3yIqbqIRUdC751TenNPcrQZkOIiyYiG5afDIGYHuUaOpNrWvl3fnYGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292542; c=relaxed/simple;
	bh=aRKPpcjTZlDC24qUfnCBgvTtXvGCTZNwYwmC0b1jgMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VDuTq7neCF7optrxNOT4RLKjJp1fKFkm5ULyzocXFtyHye9jcaJTEm/GpLzmEjLdk6eI8eJIzArDUv+766gOK+PylFhPPww8KFFCND+grZqa15tfyrDti4qxLxnQSE4tG04X06MZaKwNamyKv159rVf4LMMWSnkZDYLPgar1sYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3TgPRrP; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTDVtIqkrTXNF95WPTVNayzDUAz+d2iV9EfyfgX8SPmYafdrT0M+MQmM99edVLcu5Xvympf6nNNrnvL/Cp7PsOJ5D/s5Mzg90lmtQwYzAqt0timtEZyTEGKFCGAqqcjizgve+xUtbUHShsA8nAlek+l4PElZYJ7vbbGJb4HugStYpgz4/W2xbCLhVqDNlmbdsj1QAwR4p69CYTBuRyB+drUs+nfnfwaGZLZgeZ4rBzuY9RgWLRzENAy6bKDevIsSP+nZ6Mm+IIPYP8vJz8M27BhSFFdKrk1UenUJk5H4AVC0fZcH0fFwRaW8M8dp6faooT9u1/bSMtzYwrw63JQsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=;
 b=n3Eu/Q3NY2NyjdOhKsOkqwd1bhjQTWBvT2e0B5fTbEldIiIkMKyJd1klH89ZT/pZKH4TDkPxmEbpNqEv5177eJ9gEl6e/NbtTr4K3AtmuA4xuRG2I0/YCS8IdSX0rDtg6QT49oPnzLXZyYHg+aOfhAyUPfTMEw7v7ym+E2XiFGh4Ngs6aTrXQL7rbBoqMoZ+9JbAj3x+clUxfS8eOa45EnB5HLhSXT8TQ2uHoUFgNHHzGf6sRuuC45n5g0Lk4AYtteXxe5HebqMzIL0/2/G3v3K7q/D5zHOwLkxKhqFFGFfv6pubmA/ZSy7J15iWUwfJUBTdsgGmOBH2aZ65UIPzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=;
 b=B3TgPRrPz09Gvo8XhdC8+HIkqXuNIjpuwKa2HO0/opnvEHazznUDiT3DyWe51DoyYYIOIGnq6FBtBkLDi8UzECqtOOmgWaFOIYgIMh+zsdqmkIEPHRQXR5rscM4fJpf5apUfhIkDq2g5CBeZzPnL+CS3oAelZpsbI2YbGOtGwV1LenXdl0DEZKrgLz4N9ULlzTMAaqXeqnFcBHjOmz/FrkR1Y2w7cV+SGCzJbSpSYRfpK4LO7+WK09gaW5eaKudn+CPD2pk9lJF0kW/nCbYrjWKkCSzoqiqOij5M5PJG7IGxBSmurJ+delFwijbqyuAj7lQEOaO0ItvANPxq0M0iCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:08:56 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:08:56 +0000
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
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v29 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Mon, 30 Jun 2025 14:07:31 +0000
Message-Id: <20250630140737.28662-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 211d7c06-4090-42de-4f35-08ddb7dfa6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2b0Eox+vh//1x9MYZhP2Wa3ANR/qAx9U/pIU4wnjcYf5bgieeag7SrASTOD?=
 =?us-ascii?Q?sY8Vj1NU9oOkbQs9LaIg+yy73Nc3uQPcdo+K43xWvyaV/ZxVK/TI4r+OcFy3?=
 =?us-ascii?Q?rK08Sekd9ytEBntZrxLwFA7NjCfjYhc76/+oECOdei352PzzLe0HKwJYqbdI?=
 =?us-ascii?Q?AYPFJQvEujUxfHMfHNhABAHre4GRvlWyJdh0Jl1f+O0jyQlgRgZGKKqYhFMA?=
 =?us-ascii?Q?UwY0INJEX+eAnAzKInlW6rbtQ9oVxVSERKVWolx96PX7mcu/qf9HJTj23Vop?=
 =?us-ascii?Q?QgXV3CCU7aseDJ5N5U6+zbUSv39qxsGrYGqpT/qkg5gCGdo38UPFPQx8IVVm?=
 =?us-ascii?Q?Gw+KV6AeK3oe6Vy739m7ByKC+tRVGha5KbNaBcVArMqauYGCZnS9i+EW8yvj?=
 =?us-ascii?Q?1JynJzi6alkq/qTMVxk6bHyuHZropnGrf2BG0o6SFCxI5abdM3ovamhhzN67?=
 =?us-ascii?Q?1JRfj+T5S/aC8F0uM2rOiNx3d6xNd/SyKQzeXEBF8T59TeMi7vJ4RsuNriD2?=
 =?us-ascii?Q?edts30aCSL+O0KsC1Xdj84/hV3t6Z2M9p6v2+QvsgZaFQinHETFXsKiWmmx7?=
 =?us-ascii?Q?7YyZ/M04qief+NoLicMrBjIlYYKPquvz8VfdYZpnjexgXZd9on+baHqkQG0U?=
 =?us-ascii?Q?KBKCXD4kJjFqBHSTZsi/+WXKp3yJw5mLnREuyINuSAvFeULyWQV6rq2bIu+F?=
 =?us-ascii?Q?wREtAgPcHr0mqDP+9Ulvsz6X0nqHzM9kccA+PMrNxLErTep3/RG72sJvL3ZM?=
 =?us-ascii?Q?5t0lDOEh/BRr6jOKr2DnDjMwlY/QCz5Cz+UqTg2ui86RLY/x9q8lQoiUDpEh?=
 =?us-ascii?Q?5xZ+al0SEljZc6615gV9BRrEQbo4IR0CyJh0FoDqsmQlVUM3MFDHfZNPFvag?=
 =?us-ascii?Q?AQryZsz04Lb4aLdAMWsLYe7Xyi3M1Z7160s10oQe4jQCz3c8qo9O9NtMx2nZ?=
 =?us-ascii?Q?S/tKueAxrUWtRle/+rE37oJcCt+UGnt0xN254k5B0v7JncMzO716rTznjbiT?=
 =?us-ascii?Q?Z2C6DrXIw23nHQQftaG8s5trVvhlDWNjOAUBazV7w1tyCb5O6oxckhNljIpe?=
 =?us-ascii?Q?2hOjLp5AUIhk2L9LHbO5jDCiFMw/tLENq3Awa0OjY3bljZ3yyJI9JKRMATlr?=
 =?us-ascii?Q?RzzFblpoTB5N5zpytZPEMNedw6YuBsaUYrESotuCVOiI3M6dBV26nKG1zaRp?=
 =?us-ascii?Q?K1jEz6clMfz5+kwRggviiy7SLYcFhPAZEU28HHSYLf5fwzh0NNaoAi6lIwt3?=
 =?us-ascii?Q?obybNjLv/Q5jq/BJCqhRU+oB00du4Fi9UtTW0vuYMrFH1lwrWOewCSK1vADJ?=
 =?us-ascii?Q?XCETf2Y6UAAd7sPJVBxcsTPCM4Mw+W+DszY479ltY6jMvT6deqa+J4lG9QtY?=
 =?us-ascii?Q?uVvrioylw15EztxhcK/Kz3iCPPle5SugUruKIH+n5IvenJTJnbh/31BXge9G?=
 =?us-ascii?Q?Oe5wBMvktWk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?peZqiFxzCBDkQvc3HPlAUONakQAOX3f41QyyF9jXLxsKr2XFnpvBvao7i0jg?=
 =?us-ascii?Q?wrEiEV8ozk5hdzQFRGTffAYZeNp02FSOB+yWF0zA0kAMjTIOIdpP4mK2MEo/?=
 =?us-ascii?Q?usZkmbr9CNLpeanJOTBOspw3P/FC39joewvMjqHvHVlvwCMNu1ye+mZKeCjT?=
 =?us-ascii?Q?QUI2T8FYZb6s98CCS1FJSdjkHeC+BV7ud4FiLUafx24ZQjfXMs/HhM3AfhGH?=
 =?us-ascii?Q?KWrwE88kMEyazHxEkJC4mc36HS6+JayqueL0+u+hQ3HZtwPYnneRm25BvVRj?=
 =?us-ascii?Q?QeLCe2e7RggvzLQCDbWiWLEvpsjxFwQUe8r8kSjA+raqgvaKI1bItJmyIAZx?=
 =?us-ascii?Q?n3wLY33tBUchhjbL4f1vAT0YV2JBhvnxJSzsOCZCjF7CFQ6rnH5Du6rpcd0H?=
 =?us-ascii?Q?23O5kY0mjcT7kD2+ceQwDNUinnq/TWjbLm2r9spqIGBk8wr3+CK+rx6qOV1Q?=
 =?us-ascii?Q?uWNa9Vbfy0qr6RXU8iAcOvtjaw0z5NHFFh37eKkNr/DHDGAx+o3pO8JmdqHs?=
 =?us-ascii?Q?50qdTM+lXbFiCY5UJUxRrB73kMn2XrV4xXiKpEaf7OiCFHHfle6yebrw03J+?=
 =?us-ascii?Q?0+mnyU1bw4DalYiFDS1emePcdy1CBXWxsMQNlfKme/Y97QTYGxXwYjE67Rsk?=
 =?us-ascii?Q?3iz/fyOwGvsvmPFdcsy16Ez/D0La2fhw7LHHAuanotys0ehlEtNYZ/Sm1ECb?=
 =?us-ascii?Q?TMxIMbT8o27p4JTkmjMNFbiNSgrdjzDwKnvvYhBv8ZOPO1EnCJ30zeBTtCBO?=
 =?us-ascii?Q?lTxmTDUqbS2XBQbGGhYHpWVZJpXTytrSSOFhqPyAlil1++DAXuZ4FaulKIze?=
 =?us-ascii?Q?giUK9OD9ZrpFVZ5zCOeVC3aY+8dCleo5FbJDADRz6dlDLJa7NFb+aONF0C3V?=
 =?us-ascii?Q?SqaXRMEQ96hOh0Aw1+PzuVW9dRIfwC4/NXiBob6JTHJVPuGSP+GxAlTuCC+S?=
 =?us-ascii?Q?PDMcAwTABvnKbYAhBohsXOjjZpgyeUCBd6ybZwSZrsjH+hk+GuhYkaRk7oi7?=
 =?us-ascii?Q?XMbtd7P0cBCv3IKx872NWJ12Tm67USmOmj216JUfOe02hE+W3F8YE9s2bKug?=
 =?us-ascii?Q?HuwmDQiIwqQ8tNMEmoYtiZFJFUIQXYhdpoPzM+Yzrt+OMz+HnD1LxmmMhRtm?=
 =?us-ascii?Q?5EBzTtiXflvebMwioAkXji85uVELTcAr/6xXz/8FyugCIQd2nQ8qIKrUMDkK?=
 =?us-ascii?Q?CIFUDSx5G7aqnoWJpp4OkIbHc7yFhVB6j+rJTPPCtYbiYbpU8Wr/DFL8zhwj?=
 =?us-ascii?Q?VeRzD8qfAfBR1DopajWaXP3Lmhgrg+KYwN6cji9YBa2JoQhL1XqhSt6BskFj?=
 =?us-ascii?Q?ettxdpA3kUr/kpcPjbH3OsOLSotc8KtHWZBlFy040F/Pi9O5imElKTAJgl85?=
 =?us-ascii?Q?EcRSx1gGvp+s4Xb/l15IeJz9yR7g7OsHKw93Z84IFsJ0fbD9JPpnDjehNi28?=
 =?us-ascii?Q?YBgZbK9i2p6YjgHT6/1vvMO6rzxLQMAWR9p0u1OyalDS+O9//HjBdVuTNq7d?=
 =?us-ascii?Q?G53OGCjfslv2/Xel3SAqhlUT4Vk57GB29u1c82heKq95WPF9cIGYIDBLXFxh?=
 =?us-ascii?Q?ZckR7U9QVGn1EgIXOSFEi7QitEFUokpgBxVy6zuN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211d7c06-4090-42de-4f35-08ddb7dfa6db
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:08:56.3293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qopSkORPrwSLqMcrWZ8GURzR52XJE9ank3E+T8tBorf4Y9ir0NE/17Q+UawVENRk2X5/1YQoTJgzQeNBFsGTMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

From: Boris Pismenny <borisp@nvidia.com>

Both nvme-tcp and tls acceleration require tcp flow steering.
Add reference counter to share TCP flow steering structure.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index 4f83e3172767..f5c67f9cb2f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -14,6 +14,7 @@ enum accel_fs_tcp_type {
 struct mlx5e_accel_fs_tcp {
 	struct mlx5e_flow_table tables[ACCEL_FS_TCP_NUM_TYPES];
 	struct mlx5_flow_handle *default_rules[ACCEL_FS_TCP_NUM_TYPES];
+	refcount_t user_count;
 };
 
 static enum mlx5_traffic_types fs_accel2tt(enum accel_fs_tcp_type i)
@@ -361,6 +362,9 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs)
 	if (!accel_tcp)
 		return;
 
+	if (!refcount_dec_and_test(&accel_tcp->user_count))
+		return;
+
 	accel_fs_tcp_disable(fs);
 
 	for (i = 0; i < ACCEL_FS_TCP_NUM_TYPES; i++)
@@ -372,12 +376,17 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs)
 
 int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs)
 {
-	struct mlx5e_accel_fs_tcp *accel_tcp;
+	struct mlx5e_accel_fs_tcp *accel_tcp = mlx5e_fs_get_accel_tcp(fs);
 	int i, err;
 
 	if (!MLX5_CAP_FLOWTABLE_NIC_RX(mlx5e_fs_get_mdev(fs), ft_field_support.outer_ip_version))
 		return -EOPNOTSUPP;
 
+	if (accel_tcp) {
+		refcount_inc(&accel_tcp->user_count);
+		return 0;
+	}
+
 	accel_tcp = kzalloc(sizeof(*accel_tcp), GFP_KERNEL);
 	if (!accel_tcp)
 		return -ENOMEM;
@@ -393,6 +402,7 @@ int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs)
 	if (err)
 		goto err_destroy_tables;
 
+	refcount_set(&accel_tcp->user_count, 1);
 	return 0;
 
 err_destroy_tables:
-- 
2.34.1


