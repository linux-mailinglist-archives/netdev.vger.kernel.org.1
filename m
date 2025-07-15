Return-Path: <netdev+bounces-207110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95CB05CEE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8489A4A11B2
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717FF2E49AB;
	Tue, 15 Jul 2025 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GfNk0LNP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905992E49B4
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586119; cv=fail; b=bh4C3irijxgKf+qGX77F6BCuLXSXmVZvXdTHsmtrefVNz5E3nOBGyL/M8h1dIK4JdNfgTyIzsY2RiUVAhLLAl9vXCvrwb4jyXyGS3SdiYxyueyNTfrUpGPHKgegbJT3Bf8U2n3nub2kjQKBGYUmR00ye7E+vl+6H6jB//NB1Xuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586119; c=relaxed/simple;
	bh=Als/sfrYYCXsnKYLDaGAfX70Cxs2E2wTOmyMpm2bWEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mxldaz4z/jpwVbNS0X19+Y1LeLISY67v/Z+L00gbdQhHSr0mJ12RXCcdslbbuVS8kAENn1K/nd2UH6uIgpn+QRh7nI3HsAomge7/qZtcD53r0Lkpu5Vr9kz6sQjJj5dvZflYAKn/9uMBNptiVNR4iavoUu4e2Wk03He2bmmU3PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GfNk0LNP; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jzsr2VwIy94P+fF4IxHQPG5L9YO0f8q7GA28dGl7F+OZLiD5QZWBxh9IDy8HkYef5dFKBbq/zxJyVzB/TVKiWOOqKBw+yffs1mQeNvqMtIX9+xI3ZH9ELHh+QszghTFvUEcphuBRvcx7rJsFfVFssSPJlaMT/E+q2nuf+c2+pGXhvRghil4YvlLjGU+JX+UvQr0Dcw5Z3IWv38pewQkPH2sHDi85Q2PsVD3tHOcbjnQaerh84SPNcIzN6UnMG5/Ikia4wLmtyNF3fKJ3OmTA+gH3oYzq2RaaIdht5jX/GluQqEua0/KPEAyJX3FpiE5x0dzj3yEjp2ZuOEp+tWKzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFa3VlgyU/DRbzv2v8NgT9zC9XCWdw2X1nKO9HCPMBU=;
 b=i07o2A/P/MhKrYp2sdloJchbMR/IsYl5RXBMbd78BERD5G/bzxBx2YIkYxi5EFBgCFYAy4z3OYU7DwKjLfPlLbRSbnAqYyblVqgncHUwXi61xfquM481xrri+emfeJR/JblL1zhUPRaUeaTSJrakJuNEy3S/P7KcfpqwPEzWc4X2bGPdKOTd9Jf1WH78wFMGYwtYaUzSj4Fp03QxErRetvXTcPEbF8v1Df7kehDlyHNipZ6gRsJknW+dJKauSLwdVnvu4/dGqNwnXNxrc6l6c9nOXBdSerBOfUxIHtRoRF/CRmLSOd8sL/rwLapjwJ2q6iNsuYN4rkG9sQo0+DRX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFa3VlgyU/DRbzv2v8NgT9zC9XCWdw2X1nKO9HCPMBU=;
 b=GfNk0LNPK2A+Gv0vbUZ9Af6O4MiQWxnMYMoer/gvKluag2ge5H5Jwz/CYWBBmfsszCakDVVaw03fWvNES2OEQeczhxQosKnLil3gqCphh5vZtpmcJVg6UBXcWrCP1vQH7YqcgbBbgzyKXs4A6yFVP0EPLmeVVysiL0t28zT+J6UBSiC3OlIXu+m4XmPipvwcXJF4S2LQMmJa9Rnun/asv1X5DOt6MlAgNeHjusIz8Xf3wkUzT0efB3veT/DApAoS+r/30DfIC3IbgFJvWUFzhepVL3hQ0tuz5ylHt3ueJgoAIlmJSuhRNXbg9rZi1qDi2yAi5/eOutXDvBqv49zflA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 13:28:34 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:28:34 +0000
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
Subject: [PATCH v30 06/20] nvme-tcp: Add DDP data-path
Date: Tue, 15 Jul 2025 13:27:35 +0000
Message-Id: <20250715132750.9619-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: edbc994f-54fa-40f6-822b-08ddc3a37f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nPK5iBVbn9x2O5t7clFe2n3KJTfJWoi3vR6tjXZUZU9i8Zo1ZsAdQ2zEyLIw?=
 =?us-ascii?Q?BWRu8xQl+QP317/sbwHMjXwf2ZabvMuFwXreqw5Ts4rtkdnSVYBKzwwiBaQP?=
 =?us-ascii?Q?1dUq/2H7cPF8Doo5zZMZjq1iAep6tEePngTHGM25QhCKK8zoaOUvUV0d4qhM?=
 =?us-ascii?Q?sE/TYtaSe6csyVUfJxw3A2mgCEFZuAwF6E9Sk9ExEQ1U/K/OsoCgsnxJz5cH?=
 =?us-ascii?Q?SmS3SMB6dRrw1kKVokt1jwUHy7rt6gLny5XSaCU42TXQrvYOR+Jti4BMfY2f?=
 =?us-ascii?Q?c69iibComiZX5NWoBioJ+4uwmFvUL7x+4X5hwOfDH0UNutr88OyX32cmoHZG?=
 =?us-ascii?Q?1Ci5b/8jUIDZTrYaknwmfWakhg0uDUNGEOXYDHCmyBd6Jz8Z35XNXD0pyge9?=
 =?us-ascii?Q?vwsV0JvmyOw+SWzX1WWVr77GIzBuMbtS0K4vfWjuQ6MVLyYGfn11gOIIYZV9?=
 =?us-ascii?Q?70/wQXE4hzlpvcVdEofKqlgVZT02RtKnqp2YFyoEByitdcQY6cx7kNEpLZwQ?=
 =?us-ascii?Q?0y8k8CHbPq4qsa+xcLajJ5HPM3FzR1t1I+HpMtx51gQSt8EptWS8ceIInz/p?=
 =?us-ascii?Q?8W82PXnHHa99JM6nEGLgCXA02scyPRg9MerqPHMescCee3lGeNAsDNpWgHpI?=
 =?us-ascii?Q?ATi7ZGD8u9LMESfvMz655/mG4gXP+zZU+WsEE+RPKMyVVxHAvueVqsD/nr+2?=
 =?us-ascii?Q?BqW+lRgaP3KVbvZ1M0OzmywkdOdp3gHEXgea5HA4RdRRlvvlSh9tTziDXgW8?=
 =?us-ascii?Q?diSWNl0r1JRzTiIT+D4eQAtEGr2MN9Vh4Rbhafgujx0L1qMoxyxY98TYZNgm?=
 =?us-ascii?Q?H/WVCQDB02+pCGbfsxrct3dyy73IQlFqQawxWVBjigAnClVcmt9lNXu33tiG?=
 =?us-ascii?Q?bxOfYNtI1sWzt8DcTZIUd+YmGlDx+4PujCZ4I/e2wPangRQyuWglS+oWTU2x?=
 =?us-ascii?Q?1ofAKhnUm0kOMF/qd+RBTZg751G6BoeMKo8jw2scYziPGMTKHo0qk6eBuwwQ?=
 =?us-ascii?Q?iqvE8uoAw3sdWpLXXtnDoHgjsNF3V/aV7dPuj03RWGkx2FCHKIf+HT3r6LGw?=
 =?us-ascii?Q?FYbWVGmL8dy3fgkr8EqpGwcIzeCymBvg0xufFiYT9lGSA1E2kSNfHiWz0m2I?=
 =?us-ascii?Q?NYpcffPs8m7wTbjdF2hzYLr0oHZ/o3YDAOmPcLafBHiFS/7juhvBqtX0DdGY?=
 =?us-ascii?Q?eHsBawhbPU0zyPckcSjPP8ubFZbAxCeZ9D/8Pi8PHSh70fzioDnTo12B4kqe?=
 =?us-ascii?Q?1+yAlBYll18Dpe4LVgsnKl/TdYo6WDcpTvG4fEi39wpu9ox2bOLPf7VkBEAU?=
 =?us-ascii?Q?jFmo9sIH4heuR6f318VwxA0SjAxRoIZS4olkZ/RvoBgaSXecVunK5wAF59OO?=
 =?us-ascii?Q?1kKiTG8vhPJGSKZ0oD6ibBxldRAKHpreYjBUQVl1ZPn7PUL5mA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rz/NRFEoQcmXNc4LOt/qddr5OmxG1ZrC+YGRFiFI/ftYzonOqDjcRthgb25i?=
 =?us-ascii?Q?hwLsLT5XmjQfIIdaovYpfGq3h1qR2J4RuGjvbccXZA6UNs11vHkbIswOvXqX?=
 =?us-ascii?Q?EhZNfolG5cJfxCnEDayi58Bdy7lcYKLi2Obs2ctbrWDQj4x6otyGFVJxjiBo?=
 =?us-ascii?Q?Xft+5lU7xM8G4IDBE/1IJyATVws0Gcuj7H5TZuUZMf4cuLdeID6vAYqirQnF?=
 =?us-ascii?Q?kueT9zTzi87IdiuTI/fZ7b+XM1bvrNkVuU4zDkVEbEbwsK+OHg6/9h2VIAhW?=
 =?us-ascii?Q?eCxbbmZn8g1d3BUPOd1GdGt2ayZxVYTZMnkVr/9A4Qc52d8QQ7k6OblFf11W?=
 =?us-ascii?Q?qm+Bkgea7eIPYd4ASeFf8onrkTfhEZtiU0/OYIN86yDs3QEoTmtLttNa33JW?=
 =?us-ascii?Q?qCSYsjaOCzuPmn1pyQafVKek8RLQdplDwlMWFc1PugxbnFOylxPJpvl0z+AR?=
 =?us-ascii?Q?f21KVlcJ+1+IOtP4pZRQ+KRlAAarQe01G/6+XCM0PiwwHU2xMqLmu3rBWqTq?=
 =?us-ascii?Q?kDZSF7bttjDgXEFGYBf8eYfQEz5QR7LttVlPYYde44USlt0bxKZhbuC8qoV4?=
 =?us-ascii?Q?Ant/mN8e+suVpo9AY49bIrHs1aM9rZKvEiQa0BvwI1RC0F3Dq++Xzu407fLG?=
 =?us-ascii?Q?9+nPlHXf0h5eo8gyaxldmuG6JVdWnj+eR89416XPCDb9QWWLkaO1V6fUMB/X?=
 =?us-ascii?Q?w0wkewWi8lZ+S3El8UkO+ShTlp1woGXhVjsTO713pXJquEkwuABaCVwr+WU+?=
 =?us-ascii?Q?M44G/K06J6LGgRBlNE1/mQGnFFddwVJ78Q2jxjzK+oDbRHjiwEfDU9gn0Ycm?=
 =?us-ascii?Q?yhfDCu2LWSJY+cIN9cIyykIZOQ+oDXK9q3am0C9UoK+HkpJFoX8DofPnDtfP?=
 =?us-ascii?Q?/KQGz6f7UBz5k1humNJ0HKNMsdVighDwhDUXcc4gRqti6iDCiYxnbWjozR/0?=
 =?us-ascii?Q?k4psouwPEyQqiKOAU0cklGhJnaJ4pS8RAYIJiQIr0CB+rYNyKub5Jv7yHTJr?=
 =?us-ascii?Q?pNAVxUR6QIWW4d8vQd80QWLvkEAb6kxPhEtXhujJj06ztsOZSHGXGL8d/RC7?=
 =?us-ascii?Q?7SToJkOmZUW+9gQ8WqG0Gv9rwKsVeUvQxK2KtrvXxZCUtJldGf4xXXVnHJEu?=
 =?us-ascii?Q?y2nc2uDgmSNDT+1WU1vtbuhaU8hbBehhtjl7wKHbRsXttq8iw5GaxCBK6nxa?=
 =?us-ascii?Q?m7TnEKN0L3MwmbXQUzs6oZSAz+wpFAR+mwPGlHQBKEozMn74J/3pDzNd1GJr?=
 =?us-ascii?Q?s0m5YKlzNiizXsvTlVjJhfVeHtkR+w5jU04chym7GBzOR5wQ597GI30hnAJE?=
 =?us-ascii?Q?hlv1wuDuxJfsRn3YH/yCW5Yz4aFBDo//GeeRvdSw4k6qO0gvrDXc+/3UeJ/s?=
 =?us-ascii?Q?QjS1+kZ1+NSc5opcre+yb35F9gmK/sFsI3X/wKqobJm/Sf8wloAZQ/Z03mUF?=
 =?us-ascii?Q?qsS45MkyrXxJHOZmylyUJdCjyjybWFqcoEvZDS1AqwH98b8coHbHb7RHUPSb?=
 =?us-ascii?Q?BNyv2w5IlD6d3AkjT8siSmvZlTkTvbCMAnIk1yDuaTMVJ5xZY11fyg3zevGO?=
 =?us-ascii?Q?octTLWi1cyNddF7wpqrtPTBgf45hmaI8BVwfyHun?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbc994f-54fa-40f6-822b-08ddc3a37f82
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:28:34.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPmEiQCw8A/2KSnWniN2It5YZm6eURjIq6QmhcmGCLfKoppPg27kfwv89h+drHBkBDjYtU00FvG/HuSYpaLdZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228

From: Boris Pismenny <borisp@nvidia.com>

Introduce the NVMe-TCP DDP data-path offload.
Using this interface, the NIC hardware will scatter TCP payload directly
to the BIO pages according to the command_id in the PDU.
To maintain the correctness of the network stack, the driver is expected
to construct SKBs that point to the BIO pages.

The data-path interface contains two routines: setup/teardown.
The setup provides the mapping from command_id to the request buffers,
while the teardown removes this mapping.

For efficiency, we introduce an asynchronous nvme completion, which is
split between NVMe-TCP and the NIC driver as follows:
NVMe-TCP performs the specific completion, while NIC driver performs the
generic mq_blk completion.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 136 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 131 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3ef48731ec84..5ad71185f62f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -129,6 +129,9 @@ struct nvme_tcp_request {
 	struct llist_node	lentry;
 	__le32			ddgst;
 
+	/* ddp async completion */
+	union nvme_result	result;
+
 	struct bio		*curr_bio;
 	struct iov_iter		iter;
 
@@ -136,6 +139,11 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+#ifdef CONFIG_ULP_DDP
+	bool			offloaded;
+	struct ulp_ddp_io	ddp;
+#endif
 };
 
 enum nvme_tcp_queue_flags {
@@ -372,6 +380,25 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 
 #ifdef CONFIG_ULP_DDP
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return req->offloaded;
+}
+
+static int nvme_tcp_ddp_alloc_sgl(struct nvme_tcp_request *req, struct request *rq)
+{
+	int ret;
+
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ret = sg_alloc_table_chained(&req->ddp.sg_table,
+				     blk_rq_nr_phys_segments(rq),
+				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
+	if (ret)
+		return -ENOMEM;
+	req->ddp.nents = blk_rq_map_sg(rq, req->ddp.sg_table.sgl);
+	return 0;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -407,10 +434,68 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 }
 
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
 	.resync_request		= nvme_tcp_resync_request,
+	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
 };
 
+static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				  struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	ulp_ddp_teardown(netdev, queue->sock->sk, &req->ddp, rq);
+	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+}
+
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
+{
+	struct request *rq = ddp_ctx;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (!nvme_try_complete_req(rq, req->status, req->result))
+		nvme_complete_rq(rq);
+}
+
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	int ret;
+
+	if (rq_data_dir(rq) != READ ||
+	    queue->ctrl->ddp_threshold > blk_rq_payload_bytes(rq))
+		return;
+
+	/*
+	 * DDP offload is best-effort, errors are ignored.
+	 */
+
+	req->ddp.command_id = nvme_cid(rq);
+	ret = nvme_tcp_ddp_alloc_sgl(req, rq);
+	if (ret)
+		goto err;
+
+	ret = ulp_ddp_setup(netdev, queue->sock->sk, &req->ddp);
+	if (ret) {
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+		goto err;
+	}
+
+	/* if successful, sg table is freed in nvme_tcp_teardown_ddp() */
+	req->offloaded = true;
+
+	return;
+err:
+	WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
+		  nvme_tcp_queue_id(queue),
+		  nvme_cid(rq),
+		  ret);
+}
+
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
@@ -519,6 +604,11 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return false;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -536,6 +626,14 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {}
 
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{}
+
+static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				  struct request *rq)
+{}
+
 static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
@@ -825,6 +923,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static void nvme_tcp_complete_request(struct request *rq,
+				      __le16 status,
+				      union nvme_result result,
+				      __u16 command_id)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	req->status = status;
+	req->result = result;
+
+	if (nvme_tcp_is_ddp_offloaded(req)) {
+		/* complete when teardown is confirmed to be done */
+		nvme_tcp_teardown_ddp(req->queue, rq);
+		return;
+	}
+
+	if (!nvme_try_complete_req(rq, status, result))
+		nvme_complete_rq(rq);
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -844,10 +962,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
 		req->status = cqe->status;
 
-	if (!nvme_try_complete_req(rq, req->status, cqe->result))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, req->status, cqe->result,
+				  cqe->command_id);
 	queue->nr_cqe++;
-
 	return 0;
 }
 
@@ -1111,10 +1228,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_queue *queue = req->queue;
+	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	union nvme_result res = {};
 
-	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res,
+				  pdu->command_id);
 }
 
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
@@ -2943,6 +3063,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2981,6 +3104,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 	}
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, rq);
+
 	return 0;
 }
 
-- 
2.34.1


