Return-Path: <netdev+bounces-255947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIkUKoPagGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:10:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F57CF672
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69D7D303D9E2
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF355385ECF;
	Mon,  2 Feb 2026 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UfkQ1BJ4"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736163859F4
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051978; cv=fail; b=BFsbmWjODMrzkoFUZFzD+13J/FvhjUUgIthlCnh0m1Ns/SaHBdnN3svCbVFrMif9GoYu0XHKnyPk5qs2JMEYfxtVfSgvxFN3Zj8aYBNgPSPXUrOLjlWY8sh7nC7cwbyhrNg+4IMKUMOlWreQaJYT2ST8sOxNvbz0UXOwhMBbjYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051978; c=relaxed/simple;
	bh=rV+BYBScHZrwQo5VCoLAB9GLWd98W0R5QYE8DpXG300=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZwu2+kVSUMPLHDz4HtHQjRR3/5Dyl3xccLQ07ym1IsTwAJkAQbqRdRV901nOVQhJqM1Z7uVa9UiWYw9V66FrdzXrQ4f2ccZrReLAHgXi0KOgAr/v3PjTiK/5E6+RZVfXhgo/+X7cNSO3Vdhfmy/hamBKBPZJDMUOOKMmd9mV3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UfkQ1BJ4; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uf6Va32I4MXyuREKRn1g1TJnHwY1qxsvyg0V0PXkfYZnO/aWV+JxhzIzfFB79VIclRusCrVRyuTnN5EnwThsNNkBAlAMdsQDVH+hLpgzXP30sgoFGWbVHJ/XiKzNk7aN70XcYwdr8lChfOZCzQX7GGbJl+2wbGO+KG0SdzDlth1Ugn4NAsBpn8e7YPtibkxph8Ha1MYZDQW+CK5ub2tDQ4MX2R9h3WP5FH0kZZ5t9kKG+H4NcJuppxLYCjs8Jcl9aSO1XT/+lgM7oN/AwK1stZ3wwLcYtWWxIeksBZG3S11ulekZ62/nE7rPJuchnNYYfkeb5ttElQPajUMUqwyEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R38e6nZvYGCaJHSLMq/L6GLkbMDDeQI+wiK3nJXoLUI=;
 b=ivwru0YgwbjHI6hc0GB+BLsiReYlhxz56vq0dZYIPh3aVkAO5wrvcEX748S7z4oCt/R2vN+FymERErL9mfj2K9S34X4XWRPNmfjirXPrRYhRcxJfDKz7uc3yK7LkabodO5FyEg252IHtJ7+gUFE1vU2XZyj28kTXPWYKydd98YFzBVotqUZ+fJc1ezR1hJVCoX2PztN597DaFkKi1vKElzXHp5e4ddg1p3q8eg06/176T4JBAHqJezM8qnerB0DTWoWTKUPiNs2ZZK4EX1lq0EPE5dOP6sIddjTbvmXt+yiA2U34rFelTMYAny6QxupfYCdb+ZcyCYF+yVBr3C3mqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R38e6nZvYGCaJHSLMq/L6GLkbMDDeQI+wiK3nJXoLUI=;
 b=UfkQ1BJ4GaoDn1qtYtIWuFneSovUAqKSF5mDlXpvKv8d7n6z4AlIsPhVxeGEx0Q4qCO6lnkR5FJPiZ/+len7Y217IDHASHFT1Z11EVi7kx1jD3Wjm8k0HMfJ1Tp8MvmIGEq+suds3c/kvVSSqCQVVjaepNoYI1WU3fuX7LPNFpVw2t0LNX0OnVhziyLuNk80ePPhkS0zm2SIKjljStbACaaIR+yB2VErFrJEXB6QVcZknfGgLEFRe3sQ772AqADhrqnf79ynWYE2D/EBZkmXXbXLtav0mrTUCyOmv/Llw+yuQ/+TOWQfEs00mJtuNiB87+l+278ZitUcOtfW95hJdQ==
Received: from BYAPR21CA0011.namprd21.prod.outlook.com (2603:10b6:a03:114::21)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:06:08 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::f2) by BYAPR21CA0011.outlook.office365.com
 (2603:10b6:a03:114::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Mon,
 2 Feb 2026 17:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:06:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:05:29 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 09:05:26 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 09:05:25 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v17 02/12] virtio: Add config_op for admin commands
Date: Mon, 2 Feb 2026 11:05:08 -0600
Message-ID: <20260202170518.9076-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202170518.9076-1-danielj@nvidia.com>
References: <20260202170518.9076-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ed09d3-54fd-4b3f-d0af-08de627d5bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yG+neebr9XBmPlFICTfev5uMHfgJeTGNKvdPp8bMPNbMaWKKG3I/mmhDvB0d?=
 =?us-ascii?Q?c4/jfwUlHZ6YwNu9jtUT+YMMJ9EwSrXf0IdkZcmLpP2iQThiDlRtlPQWQhhy?=
 =?us-ascii?Q?BufUxTvx32hNUW87bmKuCNt/XBOW7OJLRdRsjCSKb8yuaGYUoqBum/U+rT3h?=
 =?us-ascii?Q?qJtVFc1MKPcfmjaWX4eraLCLrwvz043o+fD+a3+qvqR7kzjiAL1Lij4l6t53?=
 =?us-ascii?Q?LqrEgDc3Mc9CZmmS6w/1jpf3O99xpdVK7niKcV//klsvJ5G1VqjOUHTCQu+/?=
 =?us-ascii?Q?/OhgzaZdsBiPl+HcQjon9A/HQVlDY12SSUNBfySgu9K1MFWOPdH9L2dp37Co?=
 =?us-ascii?Q?ka3qYKn9m0Gwl0IFK6lDs+41nc6EU+5SdZgGhyg9yOjXiYo6Aq2pd2u9jR3M?=
 =?us-ascii?Q?GByIbXUvZ+Zw742IVUyKm1cUS9CtG7rWb2M7616FYeBD3TzTiIGXJwaj5a/b?=
 =?us-ascii?Q?sGy52D0saGNKDvf1DG3IoMRzS8FSL71EEAIBSfwgm113PIl78A1AZg7Q999Y?=
 =?us-ascii?Q?joz30cv2CVB7UBjm4MpG4yzLeQB2d/HoTtHZr/SqDJBjyUKwTepWtDzRi8+l?=
 =?us-ascii?Q?Dt6X2KPsk5S3PIHkUrBjWrTNx2T61UlNtaMHYDisWvAtWzuzZ97T37JbzKuS?=
 =?us-ascii?Q?llaoH31Yjjj0dsTUAmCDpTtIFTowfPOnHHIn63xqLLqz6+/Yo1TBX7ktiNcN?=
 =?us-ascii?Q?A+H2yyfaQhX2ERVbKI5PqYEDoqfk6KG+KbTMrZhdQ6b1y+sI5yWanwD8bM8/?=
 =?us-ascii?Q?+GsAv18qHHG5yXVmSWmq+2w7YRipmf8oe8F6OPfjbHWWvPgbQ0D9rD0x9KRF?=
 =?us-ascii?Q?8Kj8itZVebRQPYEdjin6q4sAHNLDfsfU0Pu0tCq+3MMGrp3Nnvxf8KSU+W/d?=
 =?us-ascii?Q?byCZ7ebT+abpZmjwyS+UrY/zfPCqAYoNOeWnfTdlmDkCVn711e/kvVDUjkhL?=
 =?us-ascii?Q?at2F2eZHomngXo1KOsAbjRR4tfbuXjz5Kmy+JhlvoLPDce1JOs9YBlfgE78n?=
 =?us-ascii?Q?5Uh2Xaag09zwc4t834Mt3qp/Ets/5+8xoJB9nlCR+XNL0fi2GIgAMH1LvaJL?=
 =?us-ascii?Q?hrkayB7ST9veezLAG/u9AhF1kHPTVdJI2ywi7zqBAN1yr/xTI3LQzz3yjxaE?=
 =?us-ascii?Q?5GH11XbZfvNhx/0wtuKbqAUAN0VD10I4CxpHAGZfWwEn6GQ1rpRzpUvE9blg?=
 =?us-ascii?Q?MOO6HEOBxFwyKL7djYsJup/4A5EMMkq/CH4xGf0cdXAZho0HjZKVbbVClwku?=
 =?us-ascii?Q?qlQ1O4feLH8qaRFHaIjAwaIqYI/0b7sMfIT52TJe2eUGyZJBJON/MKSojjfr?=
 =?us-ascii?Q?DOs1PBrYycpYWDEh+XeJ8IPX4B5ALiyxPBrd0oJT/5ibVZoqrZrajPhduPC0?=
 =?us-ascii?Q?qTbRJbciy0RDqslatj+yOGs7/ahEq8E3BtN6reNqSxc5k5SDg45W/9qxziAE?=
 =?us-ascii?Q?kcRl4NuMjEliUJwP8t08qGRYk25xd4/59uTwoyjTtgLe0BQJeAvSm1oqQrjk?=
 =?us-ascii?Q?QiXQohhHUvQ+vOFdgLqcd2JO+tjIdwSsH28t9Zbi9LlMeKCMBnAklbKRAmPM?=
 =?us-ascii?Q?sA1nkQeGXnl99WLRpYAEDHm30s/MuLadoki/yFQg0sis6BTN7zDYqdYU4GKg?=
 =?us-ascii?Q?+5AINcHQalpwjy5W2iIEfTkKl4Ia+c+xzdO7zqOv18iA2kSzP9y/QbFV3Hsx?=
 =?us-ascii?Q?lRI1Bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z5E6OSq8vc1hvSQn+tnSa7JMQfk8VsvTmkTDvSh02vlMd4xEGDXz3WJy+cAkbgmmMkGc5mfkyWTONLiilJQREzWBTLdYpRavWM2vU52gHYjAmV7QVx3DrKdiuIn0P6wfNEWKg9s7JGFYwGZmIY4V2uvorLeXEOExiQOThJ2OPjYh4gyrKd8VlsjRabukR7l/PkJWDMwHrz9TFDMLZ3/75a8Hhx6YKHjpnIuTxTmNJqqGpozgojm75lv3a7SXBbWvM4A00DiO/FGFufLPdPBEWwEBAsyezs0WSY/tJo2zT56CJyT+Y1MUTMys+vjKmzXvddYC45WG7PnJXyEL/6emnabNvfOfAGhAzUpOK3lZw+0W6HvbaeylIs7Iopp4YrEArM45aykQHJgHL6RK9xJMrUt512Ops2RxcDbDNQTXy3OhK0mjHEFApQ5op0FvDE+D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:06:08.4264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ed09d3-54fd-4b3f-d0af-08de627d5bd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255947-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alibaba.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 57F57CF672
X-Rspamd-Action: no action

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: New patch for v4

v12: Add (optional) to admin_cmd_exec field. MST
---
 drivers/virtio/virtio_pci_modern.c | 2 ++
 include/linux/virtio_config.h      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 1675d6cda416..e2a813b3b3fd 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -1236,6 +1236,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -1256,6 +1257,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 /* the PCI probing function */
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 69f84ea85d71..e36a32e0a20c 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -108,6 +108,10 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
+ * @admin_cmd_exec: Execute an admin VQ command (optional).
+ *	vdev: the virtio_device
+ *	cmd: the command to execute
+ *	Returns 0 on success or error status
  */
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -137,6 +141,8 @@ struct virtio_config_ops {
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
+	int (*admin_cmd_exec)(struct virtio_device *vdev,
+			      struct virtio_admin_cmd *cmd);
 };
 
 /**
-- 
2.50.1


