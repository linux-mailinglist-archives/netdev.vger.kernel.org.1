Return-Path: <netdev+bounces-256846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGaGN9PKg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB7ED06E
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CD3A30160EF
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ACD35F8AE;
	Wed,  4 Feb 2026 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NIL6buXn"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D03389452
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244814; cv=fail; b=hBngYoYYAJAsQ345X9efglgOvoHNasz8AfBww3TFdl1t83D+tP3ohbwBokhYEcg+Vn44OWeA90JCrpaDvW5PRZPEGSwtdwRRuvtj5tEAInKdo1v78MT7B1MZGzHCSWHray8tOKLbfIk1KNbW1DSu2RXFEJlG+0AaDpt6tfI72tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244814; c=relaxed/simple;
	bh=rV+BYBScHZrwQo5VCoLAB9GLWd98W0R5QYE8DpXG300=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDtJXU7C5lqH+VWsXZLxRpYyFLrcUcLiI5bTtXhgygCevoCK6fLyEDosOvDvDRNiip0WSFCxEqrLjym9yRWeajDexNBXmD9aYFL3bJxegtra/JLXOoQ1Ui5m+2lUNeCRNf6G0/DTyEVANl9bW2WnhCQlgnmTwSpVFI+733e/LWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NIL6buXn; arc=fail smtp.client-ip=40.107.200.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHamOUakqZmiJy7m7FnAfA53RHXNWr1ZqJw6cr4KkNU9rsondEGqr89fXRJkdDxGLAAwepsaYGisoOe6sMSS0y2QkXjcF+rT/2qS78gVn5xbibUEEblR0t9EnMzsIhscX9KSCnDPOdjDjwh8eYsIzTrafGfy9iIOrYpVAz03xAZ/hmSQm6tSaXJ16xePZU3qFHJaw6OuTrcI33xbLGmSUGnKb3U6lQf+3YcB+SSQ6LEXHr4q7y3q9E4bRTlMVBEwK5x5w/aB31dreaWQL5q5w0wpeKI66nedhwXRDKdEeQ1lw1jZjprOQ95YPEtwCSaxVke1ldtC+3bkMjG4+WTQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R38e6nZvYGCaJHSLMq/L6GLkbMDDeQI+wiK3nJXoLUI=;
 b=a20RvxJQVe280Lp28JjA3PTbBZAhG+z49u+iawZ3G25Jwk7r6gcpcDqOeshSX++jH8pM4fC5pbhD2uvlYkKe1gzWmmQHX6DJGvyHMFehPrxx4aIoi33DCZWcsf6KMk/1u+ihNMFrTNPmocIUV6K26n5PlDFBtISXL4kOvIJG2fx16IINGfV0Rw15LO7EWzVuzjl5qEHvnag4ARGOHDV3KY+reGbqvFhMBEifwjWI2ozFO+FWgaHjDGmEjOeBJDyeYsnIPp4ZDciuezGNA47lhrACJ8h/9kZwvWwWNHwvx/b0sDoAAMYjKCvinnvII7eQIzLNzhoA+IE/HI6ekxtiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R38e6nZvYGCaJHSLMq/L6GLkbMDDeQI+wiK3nJXoLUI=;
 b=NIL6buXn854Fl2R5gxjvdeZ2FwUugXSmPLrttrr1Aaz1hI+M2V54Au5q2ZVilwWCQyVssIObtz/c6qYqpdgQWKMlqBip2R4JvWDvXbT3wuf8EyEyazl0GsFzsifSnhpLjmvk0C+Mt+j0s2L+UmoNA8ywuVEsODWqZlB3qH0+3etw3UKeDSKTILfVkB/l315mE2TM+Wcajy7JXxV9xJ1VTp/d5jr38EVQCvuXotMfn5fo7s/O3L8E2FdrP4RsX2MXY3AspmiqacnWwIPmxKn8daEDth6d80hFRvACXPXxCwpLsjmGCyNgFFgsmTi6y/wEn/LgiyxUTHvXw/gR4yMAnQ==
Received: from MN0P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::15)
 by DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 4 Feb
 2026 22:40:03 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::d8) by MN0P223CA0013.outlook.office365.com
 (2603:10b6:208:52b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Wed,
 4 Feb 2026 22:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 22:40:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 14:39:48 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 14:39:48 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 14:39:46 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v19 02/12] virtio: Add config_op for admin commands
Date: Wed, 4 Feb 2026 16:39:30 -0600
Message-ID: <20260204223940.39581-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260204223940.39581-1-danielj@nvidia.com>
References: <20260204223940.39581-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 54057860-f688-4072-1a1c-08de643e5638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aNI5ZrJJndm27Oc9H+O7r876NDYdkTfNnG7vXJYPTYHoq3vyMjjzGr+zUk7I?=
 =?us-ascii?Q?mQdUOJAaZ56WJox0TJwKkfMubMnwGTSZLA08Ups1HS0J1/gHGBvOASkbRO4b?=
 =?us-ascii?Q?a/xxUDSBuaUM5pY/9XONS9P3fh4SAyUm/RGNc0W7kiO6ypxatQwHswLO//jT?=
 =?us-ascii?Q?sIAmkhEeqCGnlhpSQ2p4Dn3Gl6bECnEdzUG3n5p51cpaOAEnPOrcFyFfd5Li?=
 =?us-ascii?Q?ZBoHXNPdQo88RhWI1bDIA0PKKVotdWL3IzXJifZ//RjXylaV2r/NMLEXHsnX?=
 =?us-ascii?Q?J8wSxYeUMmYj/H+euGMkaUFRi6RiUkLoS3jnaSBz/al3sqK9ZMXZ2kshUpyP?=
 =?us-ascii?Q?zuksUZOY2EMicEUCY/rRG7F5ozBhXgAoLbrT1ajnEfvaiRSKE4vrphncwP7h?=
 =?us-ascii?Q?mSbC14zo/mBN61hRIbUh0vJTmg/KgcDjjPgPnq9WtdvBiJ0vFzPZqnjXKWqc?=
 =?us-ascii?Q?0SUCHYGVPvpPwhyCp84wyhKIW0Mx/NOIdQWieajp2S+J1btAzNVf/xeers4O?=
 =?us-ascii?Q?oSCSP/Ohj2ncLvafAlQvpA0sq5Tl/UuDQx1yOEtQrtxjA2NGv18mDa4X2bfD?=
 =?us-ascii?Q?rNlz4KO4mT35t5aTXwEqBApvoizLQLUXhllBxtgbGEZwp/wbtQGLDrAV9ZUw?=
 =?us-ascii?Q?PTD38Q4BTprE2Qcy+mMQRrYNdzcNxglhZAm4vCVQdxPZqA6LGSUXRx5g4onb?=
 =?us-ascii?Q?eZ64tIfuRFwAzb41hCp4KxCGTPSpRbtFTF271U34jKi4/GlXR4/rlBj6eSju?=
 =?us-ascii?Q?A/Vu/oX1tASNeoiFi2Oxq+oe0ABTlHn1FFGx8JtBQuVIbWGvyp8OJ0bTexU8?=
 =?us-ascii?Q?8L6+0AOhf2u4GH8fohoqC3rDVFJkHsO2RT259nA6HDFMIDe9QBVATX0xMmjx?=
 =?us-ascii?Q?Z2+0Y8MWMmVbqajI/YmMtX84eLuGYBV2W92iNSn2YWMmixPqJ4VDKQZpm3wd?=
 =?us-ascii?Q?GmPZYJQsYaMeMurDfHJ1aTB7ybWQ3qmdoUZ6Te/C2XqvgfdWrtQTUnyCdUOF?=
 =?us-ascii?Q?GEtMLfWzg9NX2HIieXDjBQRc8nfF09XXQnRvCdMzo3+oy93e1wlKB8MWv79M?=
 =?us-ascii?Q?tNxqS5PApO3ET1+i5NqFyA2SrCX4qrPSrzHN14LfQRaF718b22YiLXhgaUOH?=
 =?us-ascii?Q?C1PK0WBO6hHjcvRNi+/gAd5q4qT+w+Zd3e4hXaQDOZ4Hq9Icvn/7wwcq7Utu?=
 =?us-ascii?Q?wYgnf+UuaeUpTz0lNX6MMKCoMuXTdpRNaDFMJtmlQDFA35phXflVXreYrAvB?=
 =?us-ascii?Q?GFWaConbCV/sMyfJmZR5QuYixWVOlomzxQiZu05Fx9BfTw+ChM8rTLSGyBGt?=
 =?us-ascii?Q?fKDw6YP756q7ykSUpQQfHGL/qD3VgCmes7g9neZcU7Hk0t/Y9RtAfOIzQxrA?=
 =?us-ascii?Q?WclZC7aSjz4iOhQIHD2ZiuphhqmE9n3SknIqiAWrz8O01NCVW9PH9FbT6br8?=
 =?us-ascii?Q?ydPN2xS82u7qh/fsihrbzM1BQ3v0tlTRp26q7/Y2ZQLoQz3CUhdBE4Ll1/O5?=
 =?us-ascii?Q?8xS88SPVEnmUzcjP7HlzzKPBYxMpYyhHIJ5y8+ojyyE1Lj5L5n9kaepZBvUK?=
 =?us-ascii?Q?AEn+Qpp9ZTc3Sd1JdQidZ0nX9EeS6SFE3WiJw5lF3HXxzQlfB3SHRZ6FncbT?=
 =?us-ascii?Q?T6dXV0Mmv+uKSjvxCubiwyd+bmPrEuytht7ZgSAQlu4YHu+KFtfv56Et0d1F?=
 =?us-ascii?Q?xHeGvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z/G09S4YmoKSoySgstWFMUAXPAmNLBzu8H74i9g1vvoh9NbYfkrclHIRt35CCR1nz+S+C1hiWi1xgek+YBk8bqbsH+ecSeN+MHiRgPa5axbS37KAsBqKOEZX76gm7J44sc0r8MvtHI7QhO6QEtf27imI8cnYtJ0dGF2JZ/auXcXj7+bAGPS1edHKA8Fm/2UwKJ3Fc6+SHJGvOvGcxcO6Hmehpw5LLZKtCY+caQRefTp2sndK7GDndtfS4oEdgHDSwdtJNO819lmpQUWkO2gGQOcncZPgogC9FXGCXneX520RJ9lNmNGjG7P+tD1Mv4YBdbnQlrGVCisMehh/zGWYz80jeU4pVTlPqwvi5OeWq2lM00q4zo0FuN6gtD/9KuTa9qvKQwxZblqF+yu7oxyWBfnxtwy8S/GiXPB64eT83ExSMGCppUkVLU+ngcucDnNg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:40:02.9233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54057860-f688-4072-1a1c-08de643e5638
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988
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
	TAGGED_FROM(0.00)[bounces-256846-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A1AB7ED06E
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


