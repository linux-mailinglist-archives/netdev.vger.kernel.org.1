Return-Path: <netdev+bounces-256470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMQIAih3gmm+UwMAu9opvQ
	(envelope-from <netdev+bounces-256470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:31:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A1ADF476
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C355D30D0CF8
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11E6376BD5;
	Tue,  3 Feb 2026 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ta+7gi42"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E25369208
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157778; cv=fail; b=kwo/4ud10EFUjb/wpBM3YUZ8+IjGoN/f4jOQqnVHPQej9mIyMoGcYAtIIerSQa1lv0dvOJ7W3VBE4K0xZnXjncpPwuDMyOHCVZ+5EypudhhWXL5jUdTYj0TXGjhJk3UTGwt2knThzzPBo8Ht1FKSPjE876cG23nT4PFRraRt+OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157778; c=relaxed/simple;
	bh=Q7jwogH4HAzXhwKXwOSVgPWx+XlBKLc8CMjdy0U5OTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5bDXKHgrobC+Csp6WGvGxNrxrqt33nmFCmdRFo0KO4wRiQD3Ymir1h0goxd8MQeZ8E81cWmG202jcs96N9Oeur++KQCyviow/NP2fBC3KyjdJTC7ccF6B15yKuTa/tLJu9oVRFW6ITma4YiHjcVOiV0i04FaqYFNqQmdxW1AYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ta+7gi42; arc=fail smtp.client-ip=40.107.209.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Igm6oUxaa8lgrQw5PoUsatXH6cb6eiNqjiB4Xn1+eZ4L78kDYzkw6/LSkVQctK3T4oxVZ8UcILzrd3hx0T4FAtHhzNz7b8I6QfYrBPG60UebZicz9gUFHVRn5apxHfRm7OJBtMExpwFFMYrV0bMYI34J38n3FYgSHq3uOJ7YdAb+jI3iWvQWTxOAZa3qYmZM79Z/go57bKs2tl/tc6NMZa5/i6APitFE8CpA/RfsnS1x48G5+AqYClFLhxgrsLPA7tX6Rsi3AwohvhXmNFQ2J+50RWbAT9voz80rJjksH8nOnHT5LbzjLN18SuzPDdOJT8f8c8W9AKf5WmNiHBGSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlbW643wCuvJ/L7F36TTH8biSEXn73nfPLD5W/3ThCA=;
 b=qD1RLAySkkNj7qUIcH0gQJfDEzleo1nusG46xeYGGZJXZaZTPy8/e9HK2xJWu0f/drJXougyu1/LD+zHTtZ27741KNaXIKW0hySAEFxHdf0CzjBgnY9YPvMS8291WItWt6bX0Mx2R75iTSEu5CF6OlZCQPv6NJP2hM/bHz7m0wt9GmqqMMW6HxSfKW0qOEWDarXJG1G0lxgtg7XDZDCi0ZWEpJFXLvKO4HxHmye4H3ArVislPcApXSA2DvMVSCezl7Niy3J2gd18tD2VS64Rgc7I3xFSHb7/FuBnND9lKFpeQIQfzbvGaLugNqcDgtTaSpjc1fQACOWO++w3QlhaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlbW643wCuvJ/L7F36TTH8biSEXn73nfPLD5W/3ThCA=;
 b=ta+7gi42nepqal0U39vqm+D7fN/NATXdE6DISuk7so5N5ltWi8Jl2vS4Zmcy3lO+M18+EFn4rHJr/rcu9BnOTu8Bk3MUVvG7jhNNkLC48U8nPv8uOKiMiYEpXrd5gyNnmkQ2k04MB+wcUe+2uv92Y4stIiuwEKkQbeWr9ZJJUYamng5zkHUj8yNWgqHoNPlKALeX2J5vgwJ3dBvCY4hCGSg76hM4dlpfN5BZHxYqYOMIAr8TM1pPrZAVi4tLys1MTtJToLQCcoX/wnbfBDq6Km1AEAKfL/WKTPC1sqjbVsRuGm0M+9NMZBwN9Cc1dsAu9cSiZ60RlHn4SvwFWuZwvw==
Received: from CH2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:610:5a::38)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 22:29:30 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::e4) by CH2PR08CA0028.outlook.office365.com
 (2603:10b6:610:5a::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 22:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:11 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:10 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 14:29:09 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v18 04/12] virtio: Expose object create and destroy API
Date: Tue, 3 Feb 2026 16:28:51 -0600
Message-ID: <20260203222859.4219-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203222859.4219-1-danielj@nvidia.com>
References: <20260203222859.4219-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a20004-a9d6-4705-e180-08de6373b254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?93jsdaKOxoVhzW7drVJq6kyv1/ePimJTSKMGz+hw10rKzV/63Gq26QmiLr19?=
 =?us-ascii?Q?O9Hc3RDFYL+AfJPy0z9KAkrZDkE2b9IwphqBevPFyvmpZ7v6qcCd3/P3qZvN?=
 =?us-ascii?Q?SO2e7dAjoMAQeSrMxrFsMyTcDN1gt2j8btfH38Gk1UmU8j5Osi5gR0DxW7k3?=
 =?us-ascii?Q?XRhfcujKTxpZYd3P/n41G5pnqAEAtv5/Qw11ROAh+qo9Ui85FbSlg9aMNOpW?=
 =?us-ascii?Q?bPs/qV7qgNzAxH6tWaxb3C+D1kceFQNu/VS++4zSQJIxN0UOD5AITkkuC5BG?=
 =?us-ascii?Q?pbtT12qvOK2xoV/+VjuceKPQvZjC1QmYLBPpUNsPBz80Qm32ayU4TwdVPNnC?=
 =?us-ascii?Q?1pi0resALLlZkStZ3RtT/2u8+5J32v34SvAbWXj3mryskbE+NC7E+uFUeJ4T?=
 =?us-ascii?Q?D+f2H9Avl8AKzhvcpIDV7PywOCa2L8roSWtx+5+ylMK6xFmBUR66/l1jEwZf?=
 =?us-ascii?Q?z+cjCotCfHJXHiy56KI8bRskMsqrcxm+EsQSMxox+34wVhQ2RNBhiO0zs3jE?=
 =?us-ascii?Q?WSd3MzEmnzzt5u9mDoDj7bExLbCno3ZShTzKMqor9r5Xcopk19376ngEcLP2?=
 =?us-ascii?Q?BFqRRYokrdpRssw03Lj/qLwxkHLussUF0gaU0amcMcax/t74qhVXAOnis+q7?=
 =?us-ascii?Q?nnQjiZcQiKkUXHb3iKJmOqWozV2HJjlqKjlnF3FuEBbTAzt8Ev2ogpSN9hIq?=
 =?us-ascii?Q?e82vKfQPXUgAJhZurql51VPsCJBRWQ1q3KKsm67mzmihWr5wvbmvE/RgqARM?=
 =?us-ascii?Q?rUxlJPD5YL5cF7pPirQttg5Cf40r3Md+SsHVTKEXE7wc4PhjGTVvTagmotM0?=
 =?us-ascii?Q?G5ATAjT2gCx3R32A42Hq7eYPsEiUdfmpVWRiNw8w4uKtCl4mNbSnYr9FLecV?=
 =?us-ascii?Q?bQKBg0uA89DUjsA5g/D6r2r/It3fBfneTEtwIlyInuoiiQZQhIzl36h7ee4k?=
 =?us-ascii?Q?OwiBzElqaqeTBnzvyJYu4XHxyKoelIf7XRSEUp6IzvUPpIwHkCoB7+7ycgpj?=
 =?us-ascii?Q?Ie988Cixd5MvkxWM3tF7vzOi6uK2KiqKQ3Tpq3yEJAmGezi3NSGPtLxmZlKN?=
 =?us-ascii?Q?zFKOX5eam0cWBUApPfzcwE6I/U+Kr+1kn/sMYKnPfnX1XqmZ94NJu2/WwrR4?=
 =?us-ascii?Q?/yZA2yThV38xGft6x5gQpyzgowt7BZzFYlc3o7kUCt+bkmDY811+MyBl5qBF?=
 =?us-ascii?Q?W2o+Fu9TlzWi0v+0ZsSAJrxbOwHxCFpVzW+HYQ4M7ZNiULss7JxZMgxzZtt2?=
 =?us-ascii?Q?jbqNWwZ/W7Lz40pB1XPNkiKVV82hVfcZDVIk1JWG9N+qSE6SlqDv6KaiQeKP?=
 =?us-ascii?Q?vo8Z148OKaI+X+a5zf7Uf0PumKSXt+LPK15K4GYqEVLDfIkK8NgadAQDaeuz?=
 =?us-ascii?Q?+72z2EqUqXXwz/x3TWidu0VQ8Fj1jNMVoZeeRSfJI0lA/OU4EoKme7NtCFjX?=
 =?us-ascii?Q?8CEG7qgr/fdCX3W2Eyt6tKgEiw8jAf1ywHj8cUp1+ctsz+qrPrXtCr8JEXMU?=
 =?us-ascii?Q?7NforVkIZ0vLL99Gq6Y/qqIcz8TF4A0RNvwsYUPsQq5giGiL/d6+y/uIjYMq?=
 =?us-ascii?Q?q3R7JJZzmJoksvjI7MswKeIAXg8eyh8/U4fgHHdXm7/B6y5P6HVWCqIR7oGg?=
 =?us-ascii?Q?Ri3xUw8gJ8tfnuhu+iqZOtMe5I70R08z/9G8YwhWlBdO3R3PO9mIGDnBLYlw?=
 =?us-ascii?Q?FbRISQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uUpoKggqrWAe1gdEeDGbVfxflk8N9a+S+h3opx+GQK/zeXrmykhLFP9P4PU5YEykTxc+5JRLa0K18ivH6kUeeO4KbKK2UG0mujpcb9mqQb4+LDbw02fdvEVyH5Crue5Q2Ki6SnE5/S/pvU2eHXHs2Kq71kEwIuWb/awU+VB1DfPXxi6r19ymrhPxHQS9MErCnWVkFsYaZZ1l7RXWF+HO4UkrVkTT62zKzdkD2+2y7Aq+jH4vCsvZdwgjoMcxdopAopyJokCjV4oZsvhGg+geSKxjiKfgdtuK5MDqTlzQUil4hZJmS3SAnpx7QW63AcGGptL621HWLPU99WiTulwobDuDtXbTRSYr+kl7Hn1fjVDtihVSlN4dhSxhGZM08WKyX4iM9ENDxzcVV40P9nyma28IikX+izQEkDOMpoY2zcDvGpvRnxyxymIwkWJOj3MH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:29.5877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a20004-a9d6-4705-e180-08de6373b254
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
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
	TAGGED_FROM(0.00)[bounces-256470-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 83A1ADF476
X-Rspamd-Action: no action

Object create and destroy were implemented specifically for dev parts
device objects. Create general purpose APIs for use by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.
v5: Added missing params, and synced names in comments (Alok Tiwari)

v13
  - Makek obj_destroy return void. MST
  - Move WARN_ON_ONCE in obj_destroy here, from next patch.
  - check_add_overflow in obj_create MST
---
 drivers/virtio/virtio_admin_commands.c | 77 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 41 ++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
index be9144b25d84..d9b65be2d09b 100644
--- a/drivers/virtio/virtio_admin_commands.c
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -94,3 +94,80 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
+
+int virtio_admin_obj_create(struct virtio_device *vdev,
+			    u16 obj_type,
+			    u32 obj_id,
+			    u16 group_type,
+			    u64 group_member_id,
+			    const void *obj_specific_data,
+			    size_t obj_specific_data_size)
+{
+	size_t data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
+	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	void *data;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	if (check_add_overflow(data_size, obj_specific_data_size, &data_size))
+		return -EOVERFLOW;
+
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	obj_create_data = data;
+	obj_create_data->hdr.type = cpu_to_le16(obj_type);
+	obj_create_data->hdr.id = cpu_to_le32(obj_id);
+	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
+	       obj_specific_data_size);
+	sg_init_one(&data_sg, data, data_size);
+
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
+	cmd.group_type = cpu_to_le16(group_type);
+	cmd.group_member_id = cpu_to_le64(group_member_id);
+	cmd.data_sg = &data_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_create);
+
+void virtio_admin_obj_destroy(struct virtio_device *vdev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id)
+{
+	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	data->type = cpu_to_le16(obj_type);
+	data->id = cpu_to_le32(obj_id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY);
+	cmd.group_type = cpu_to_le16(group_type);
+	cmd.group_member_id = cpu_to_le64(group_member_id);
+	cmd.data_sg = &data_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	WARN_ON_ONCE(err);
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index 4ab84d53c924..1ccdd36299d0 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -77,4 +77,45 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 			 const void *caps,
 			 size_t cap_size);
 
+/**
+ * virtio_admin_obj_create - Create an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to create
+ * @obj_id: ID for the new object
+ * @group_type: administrative group type for the operation
+ * @group_member_id: member identifier within the administrative group
+ * @obj_specific_data: object-specific data for creation
+ * @obj_specific_data_size: size of the object-specific data in bytes
+ *
+ * Creates a new object on the virtio device with the specified type and ID.
+ * The object may require object-specific data for proper initialization.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or object creation, or a negative error code on other failures.
+ */
+int virtio_admin_obj_create(struct virtio_device *vdev,
+			    u16 obj_type,
+			    u32 obj_id,
+			    u16 group_type,
+			    u64 group_member_id,
+			    const void *obj_specific_data,
+			    size_t obj_specific_data_size);
+
+/**
+ * virtio_admin_obj_destroy - Destroy an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to destroy
+ * @obj_id: ID of the object to destroy
+ * @group_type: administrative group type for the operation
+ * @group_member_id: member identifier within the administrative group
+ *
+ * Destroys an existing object on the virtio device with the specified type
+ * and ID.
+ */
+void virtio_admin_obj_destroy(struct virtio_device *vdev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id);
+
 #endif /* _LINUX_VIRTIO_ADMIN_H */
-- 
2.50.1


