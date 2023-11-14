Return-Path: <netdev+bounces-47712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CF47EB016
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DB4281248
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64A3FB36;
	Tue, 14 Nov 2023 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X76vHtSB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721843D99C
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:44:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA891A4
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:44:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAo1xFsO+5S6rUUmjpdbucWLWCDOZVa8zNrtbqSb1obu57L2o8rEVOhQqRwseJV7+vGjghPvWw4dJs8whMkC31Cd2d9W7Lf2P0jtuMoWpqhAcGKcudyoAeVxSabawPQkoUKudzxuvfj5ZFycBoqmev6D8qJygnAY7QPJuSxkFOb8J6Qooxr0OLx4yuTp/Pp7e5JIqaQqh9nAPtpFQaeI2pGZMwB8uccIXfEiqVtNDYVnf+c4+bhfdo59lDUvXjuJe4PUzLDgGvEqAI4V0p4vzfs1WZJnDhpQ5sLwbRdk7An6ApmK2Vl7IT63DsX4Hd++12ZtbAw20YjVLoN2al+f2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=dSp4slF0oZ/a33aa/W3UPFPyflr9bBOX4KropJiP3YzV+gNMVsYwSi7U3IIBL5at0lW7FEsJAVwBpR6URfzYeO1NLAu3AyTS+YspSLKDOdqAtaz0q/9F2dLwEYOiTtTzGp3fQEV2r3hqqjnBBuDaAtUPW2OQJVkoIwcsPxj1G5zXbhJWSk3RomvpOC/J0M+Q+Oj1JXHs39KdJppBDJ4u/cOFq2E2x68WTFUNph3P44ZoRD7Zc4MBjVvySvcZFpro1/RSIfohtyVlCfey8p/Bff+6FmOxyeBpQ+GW5MX7znO0p2yeB0Z4Om7r5mYzhsgF+uaTKT2lZnDCc+y1EerXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=X76vHtSBvI/eDHZLxYDsQrtIJK6YStF8jCgB6d+695ic0chJoPuYx1m+jM8m2FYMJLuwscIA2x5DO2SJgRvVrqWQN3e6ARuLQv4bk578oKK5WkdGxLDj70zeygU83f+trbQImNOt34kUdJ42jNkcmIYkrOjCfapShUVw4I9YOkT3z7deVzJs3VGxMxsvEPTogY+ulZTys/6ViON9SNxaXyfqVM2Eq11rxBMOA/3abjiqXVtblUvlEh1MLAO6OsbNwtCH3ltciecvhsqLfZq/VgcN2b7oaQJGZTf5UFGdi5XYyt8eERld0mcpJNJQf3nSrhHs+qQnOc+iyDoSYBaRQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:44:16 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:44:16 +0000
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
	mgurtovoy@nvidia.com
Subject: [PATCH v19 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Tue, 14 Nov 2023 12:42:48 +0000
Message-Id: <20231114124255.765473-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114124255.765473-1-aaptel@nvidia.com>
References: <20231114124255.765473-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::20) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfb5335-d4b3-4f55-36d7-08dbe50f6977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8DFldiXxlJUJPIP2ExHADWPLp11LR0OHfbD7YkBvBV/GuaZtdwHtj2HkMaJbG/hZ0NYnRoeKpqIrzdDJOppn8PauZy6wNHUDjMef4MI0tEHHgW3yrn6aRqpcvhJGm+lsxHbOHsDyGcCbzvY+S4QkeB4ADG8AbCzEhHkk+yBrTo4Diy0Ceu1Ouo0gyV3TeSz3C9ao+BjXQrwRXC6xf96GtPnqNVDAc/81S+Uu56iex5X9mkxiyc07WRdtFa7nsWYTdQT4ZepL+4h7xBCQZS13Xt4YTk7fywWBkUn5jKMFf8bO1PPa1JSnxwOuqM/4E/dlOydGo/cP8CVuDxvxbh/eYL128ETo0Nviny9m5BcbQ8/cq12rcXHkn2FnPqvHokYKN7b9ApDznXC5kvQ/tPsNSt/FDZFg4cBKiZ8wGJHs3ehp9MXJB3TUqO82bx1s2wP5isVCnVe+sy+V9/Qw69x1MScsWa4CDy2ZUqhCNJ5qHnFW7/Ut3rIy8AZQJv/ciHz8od9qofCHbNJL8XfrkfGGGzmJM05Z36h+Ta7xoN1j9MOfBQg+nRbavrnx+t9ERlL1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(1076003)(107886003)(6506007)(6666004)(2616005)(6512007)(83380400001)(8936002)(4326008)(5660300002)(7416002)(41300700001)(8676002)(2906002)(6486002)(478600001)(316002)(66556008)(66946007)(66476007)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c4AA9x06gU32tWiVsdAD2d9xW1wMCGWX8RZIjwHb/313ugE70IheBCmF4o+c?=
 =?us-ascii?Q?iexy8N5owHPA2lHae61cliKCuFpDJJVSXkBa+SKNfO/q7cMUw5Gms9jKPeoK?=
 =?us-ascii?Q?WyKkHi7bOlyqiZgFE8wq7cLvxk4W+N1KxCdMRBfTFa84V9bEk7ioBzuWp+Ms?=
 =?us-ascii?Q?nV202VEsDNx0o9oo15IHShmXiHLC74Fp8p3e7IWBXYKE7jQciD/p/gHGFY/k?=
 =?us-ascii?Q?yZptStDUdOvYCPatI6qKCWqxs6eZapQjHOE4Opics7Zm8fRr93VKmV4bJALy?=
 =?us-ascii?Q?b9Ckn++aIc/ejEivyKFLHRarsX6lHvwbhahPPIKAfQQ0Vr4zSp6KP3g5QRyM?=
 =?us-ascii?Q?mnL5LKKcUPuBH9qEO2ThEjmoHpxYvZDPOSWLVxH+ZCobByVxQaa9uALST8hc?=
 =?us-ascii?Q?mmNrrA44oP2K2yxu/q9uVOnZ+AcfLAbLVvaVKvSgOoo5nv1yeEh12mSUvgR+?=
 =?us-ascii?Q?o0WZPb76MEUvf5YF4cDVqpr0/AXb48bJEwY8g81XwQ6onuEKnVHkQ0XCvCrv?=
 =?us-ascii?Q?c6j6cNSnvFTkxxOMiype8yIGbLqw8BQSYF2WZis9KlalNUn9DNtkXUpp9cE5?=
 =?us-ascii?Q?+NtqLUFHBHg8a53klaFpl8Fd2/djXz6TDyxP12j5UUZGma0I2kUf6U45149z?=
 =?us-ascii?Q?ndqZ0dUcDyFLpyLp1j1DUsunPQyDvIsC2JuoJWiZvefkeJc4LbKVCZc5hEsX?=
 =?us-ascii?Q?x0JepBR+B3v0EgOyDY5Cfs9hhYnXV0nKMtKLIyZyrNFjRj+kgK0RJ8DhgKMs?=
 =?us-ascii?Q?bsmOrYjCmVBNlAfgWTC9qeloqrmUiDB9i1AEonLSadQcUTkWEJWDoiXnkOeY?=
 =?us-ascii?Q?bv9sh+aAhCv2U8CqMe1e7UPJSggjUmmMF49TDWq/JxqHDhKsZmWbNgbUdvdo?=
 =?us-ascii?Q?KLgO52y1qOVl45bxz+g99q7RTGErZyQX/5m21/PlMfdMUXJ/JbrVFS25jIpL?=
 =?us-ascii?Q?X0W4xxenNpuSH33n9UFbZW/X/HEpum7NVL99hBcVR5wpiSRVYVA3yuZauubY?=
 =?us-ascii?Q?zKZS98OZH+GNMrX5QYptDWtQP7YVaP2N3Fr19Di74+HeCy716fYR08YQN7nZ?=
 =?us-ascii?Q?dlO2CM3v9l5XTYJIvRuWi2daNRAUWZKCjEwtCAIw3kFY8NAzumdJnGzjVmJ/?=
 =?us-ascii?Q?PEIkBvamDCqvlIKjY12iXUabwmmwqrn6XzsO0pmY9DtMsqVFGeGEYKJOUrEr?=
 =?us-ascii?Q?5cXYzZdh9M0gHk9r3uD3nciHH0bBG1QLIoReRHoIE7nh7ulBZdqrWgj24S+B?=
 =?us-ascii?Q?IJWFPIlvph4pOfOfundc3ylka6TQJo+p9SkG1JGoyE5MwxccvC0L6p5niUkk?=
 =?us-ascii?Q?aV3alE/xRJSFtgy2PIqmytcX42KK6uo0k0vY415Pyzj6hCC+Qc4TA3D14CfJ?=
 =?us-ascii?Q?vMzT7ySB04fVyg2cfdpu+82i832CEbJ4+8V8gkHZ2bbdg2vGyc9kuVfD8FjZ?=
 =?us-ascii?Q?RwjhorVSgOIczPOTN1U6+5mSNYkEYehv3X6EiBIWWGzDWq60/sHdIOqzN4Qf?=
 =?us-ascii?Q?QWCelTIizloVCt0tdJfs2Kxd3GA4dPcCZxMlDiW77T+nITBf2zW3oDdd81P1?=
 =?us-ascii?Q?KOlKbzqWUpZUc4ey+EH6fncBhbceDMkCi8iQR2lO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfb5335-d4b3-4f55-36d7-08dbe50f6977
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:44:16.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QXzXjfN+V157s235k36cuWuNZhRaWh0RqFBbhwd0ldCZ3A1G8aBJuBEAJpI7tFq+NjeGEpXfuiCNMKXZcxI2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463

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
index c7d191f66ad1..82a9e2a4f58b 100644
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


