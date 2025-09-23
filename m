Return-Path: <netdev+bounces-225635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84E5B96304
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6633AAF3D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FBF246BC6;
	Tue, 23 Sep 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jQHnEl/n"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E5A23D7FF
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637199; cv=fail; b=SaR4o8yPzp8jQP6RBeqNIKUGcckk2n5cs2yvl0OfGdUoL37xi3TynoJKWx3c0CtjMCtrMAFCLrBHfm7c+OqM6N4D4r7nhsOrptnOyRl5SGT1ZSYAs5G7LB/Y7jjJMfPFRqso2Zxgudg+puVD0rU1Z3Cc9x/ImfAXWTJwUKzlAQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637199; c=relaxed/simple;
	bh=jlV4B7KWFY4lNfPFFBl6sa7qXRC2XQtu996oj2zwMSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZMrHh2kC/hGZJpzz8evcgJYdxmGDG6Zap0goZ71vzH4/E0K2XEW9oSFtGq/35q203Qv3xImRnBogBUG7O3aOyVwUskpcVxEA7UmkGN6K3URtMuLeV2pIeJMe6PBnq8Gi30a3gM0EFbUgCTlcCiw0HYTAfrrsjXmDBTxWUYDRbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jQHnEl/n; arc=fail smtp.client-ip=52.101.57.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkUmQF4z7vOiA8IXkEiprwRXZrjP74bL0SW94EXtxa2Enae+0MfvdC5xJCz0haj7ae4X+BykiRjg3urL3izd6rG+7DnoP+sHsbYXSOh0LSTep3FTXUcX2qgkwDsdtNZl09FQzQjSPjY7lcxTzPrIqD1vQuG/Ogj8gHYDRR28zMC0zk62kqBY+8FxxPocjcSsGfxDbgraBvg6P4oqLPfbk9L9GRz+uYMkMm1MS3YtWekmN2mjJgCN+GaOpKi9Pb+ghqQpcbTLRsc9kl8Qb0MietcS7ReTxUXP+aXgrDFgYn3DrEi1VlBdd1EgzIsz1+PTeNu1taSdEe7nBki7Jw1T5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0Fw6AGfsBtVITTYoxHxKCWNP8e4mfC/FKeRGvyCsc0=;
 b=qhAtX805/RYumqREodWEQSnOCM4JBh4rYYGLvVtQsN4pYSeA4WqxqYXPGljx818OeRwCwWcaq2kjdFHfbc15wSyzESt594q9mYe6SMdK9z+3YP+JjkZAoqiDZhM4bLjYM4S+JDNtFG4AgAhVXYQxis09e0yHhpLRxdv3zDPWEWjsAlqFbclRf+P47PWMZZR96W9b2/JjgpedRzpqrn+HXjoOlZZAa+fv56sMHZoP7glQ4nKQh22SPxvGLAmr+pDPOY2oC2PppAGaWlqkGOUSuJwj08Xy4QOR3a/i9lpJxtcggvDJvmp9c3KSMqhPAyLbqMixL/9NN9FMi6TMsB/qYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0Fw6AGfsBtVITTYoxHxKCWNP8e4mfC/FKeRGvyCsc0=;
 b=jQHnEl/nXLdb+O5JA0rqjU3rvSmT3nelxCw/knAtZ3FuLoBnkCi/3J0EpLLIvo0RxIy5w6GjfsXaYqb7+jd12UsOw7Yxsg/mlZx7JUT3WaQt7Myf91F8tx2z4qVCbBQocZd41papuOzOzvq1veZGzLSCQchSa54e+tofR9I4ODjYJulXPrLOHxUmM01dM141Z4t4EiPveBN+abDTkOrs9XuNXITP+U6Q20UvU4C/OlCyPNNOnIfLnS5dFo3JCylhb0oNfhIw4KaeQf98y1RhVqakSZWy0FDv8Sq40Y5lYX3TCEk2QJRHOZtP9mofFTI0eSQ71HhKQfZ0QfXEz3iyaQ==
Received: from SJ0PR05CA0131.namprd05.prod.outlook.com (2603:10b6:a03:33d::16)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 14:19:51 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::f8) by SJ0PR05CA0131.outlook.office365.com
 (2603:10b6:a03:33d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 14:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 14:19:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 07:19:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 07:19:38 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:19:36 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v3 04/11] virtio_net: Query and set flow filter caps
Date: Tue, 23 Sep 2025 09:19:13 -0500
Message-ID: <20250923141920.283862-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250923141920.283862-1-danielj@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 28473d74-9a1d-4f5b-4840-08ddfaac428b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkKsRC9eDja65yuD8JZcGY2MYP2OgX9g52e7LVlw29jkeW29n+LrnQDKI880?=
 =?us-ascii?Q?h9y3mcEVQSKA70iB4xrLo1iO0JJCbwe9kCezv9167bFfDdyMJgD06aay8L6B?=
 =?us-ascii?Q?OVSUek7a5/gdV3q7BHqm7kcm19EMyn3uuBquJhtg0efRbTYNODuvPvdv4yXU?=
 =?us-ascii?Q?0D8AY53wV2ibibK8B6EebMhB7881Ht4SbtQBa4cFz9ILPJPjXCNasc+688Yu?=
 =?us-ascii?Q?/UP/7eT8sR/prE6dD/LyIF4/cdV5bzy7pXFigeBSHuGQN/wteIXSyY+VuGXQ?=
 =?us-ascii?Q?2yKOGLsRL+fo47r/HmEfZ5h6xczWoooemgO5xd5MRDpIFzo0KkBGH12tAAxL?=
 =?us-ascii?Q?wjRnyyBtVCEqFF/RIquwdxwufipaAbPwLkgQljOfqym2PHDTkC0b1YWMhxeN?=
 =?us-ascii?Q?zJmsHkkMLDuo5VevFs3ZWP4g/Sq/tm6fyqRXuvlpr68SwuS3GyChAL9nqqOj?=
 =?us-ascii?Q?s+9uE1Bf3pyO2XKncvcnK0ACJ2p1GbvDNYuz4L1pbR/7OFQ72mTCPgOfdDas?=
 =?us-ascii?Q?2jtYPKPbsmGGlXnJcd9wpqRHV6nmh2OYh3WQvnf5YF2jrGoSFZCMx+eChjmf?=
 =?us-ascii?Q?TfVnPmGnqzmpQmLPPqlkoWJ+iQbFpOAY5S1+NP6mhfTc0S/RYnnxS3pLBlNs?=
 =?us-ascii?Q?4fbJvPyAQog5ht3IJdGKSmX7OHlRLp4oJGmU1EErwtVocGy3T5/fPyf9VUqA?=
 =?us-ascii?Q?X8Y6u1exjEkFprqi+P89B/D7RPJiqET2+aDzaKBDALMYY9jSRtM5BGKUXWIp?=
 =?us-ascii?Q?aDWS6RICrgQ9Euftio0Sm6WrlmLaw57T+HFnSPpR7LiRz14ATqfpF0ruvEpS?=
 =?us-ascii?Q?rl5WtFOuE3kET9aaqcs85UvPfSa1tugR/G0coJ0PSFcDw6JNV9n3lr5J8Iqs?=
 =?us-ascii?Q?3A9x19mHOi/zbl4H/JKU9J6FkfjjMUOLT5xQIdC25kkSa9MRgC9mYKL845pL?=
 =?us-ascii?Q?Ei2rLe8TkTkaS/nP+ZFnxWDNLxLbRVIG56Z34t3//ZXl2JWxWKNIc/T/v34r?=
 =?us-ascii?Q?gEwck1CLO7J4zGhEjSWX5hPW2FOl+bZCGfC4vy7fakfB//B4Mfa/vaHZ2aV1?=
 =?us-ascii?Q?BzXh/QA2zeFiwC418eKCGlw0YCs+6CZX4GT3S4JsLeQx54oKOrGdTjCXTPdy?=
 =?us-ascii?Q?fUjbcZzYtvBGpsIbqIiUx2AUFGyPOlVVsbiy52+CKtSGmSmj3+Mzxg6JU80u?=
 =?us-ascii?Q?5W/MUJRVBMQhDOXMut2TyquYZu8T9afuP6d2wcSifzWmyD6KKxR1Et0QNMhO?=
 =?us-ascii?Q?GPrPevr8Gwdj45EVFYljckCTiBlOFB4YzYBb/udcLhP+oQKSqeoZPNAMyMsG?=
 =?us-ascii?Q?MgzQcBrlWJhSpSm26oFIg+OZcpPNEuzz25keOeXhuQN9Exn1L1nE6LfEqRjT?=
 =?us-ascii?Q?Lit7Ug20jjpnkkkAd34NdQMv4gcLoVfj8CZSgYIKomqCA7+Fw6FI2qKerV0f?=
 =?us-ascii?Q?fmdfwf2y0g/yC8djhrOynTL3yY82oGFL9XL5JaJXL57w1PdodDH55G7dat5U?=
 =?us-ascii?Q?vQgzHtL2e0F0gQGpGY+UZMD3oMcOgQsEMjCu?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:19:51.4053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28473d74-9a1d-4f5b-4840-08ddfaac428b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813

When probing a virtnet device, attempt to read the flow filter
capabilities. In order to use the feature the caps must also
be set. For now setting what was read is sufficient.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net/Makefile          |   2 +-
 drivers/net/virtio_net/virtio_net_ff.c   | 145 +++++++++++++++++++++++
 drivers/net/virtio_net/virtio_net_ff.h   |  22 ++++
 drivers/net/virtio_net/virtio_net_main.c |   7 ++
 include/linux/virtio_admin.h             |   1 +
 include/uapi/linux/virtio_net_ff.h       |  55 +++++++++
 6 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/virtio_net/virtio_net_ff.c
 create mode 100644 drivers/net/virtio_net/virtio_net_ff.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

diff --git a/drivers/net/virtio_net/Makefile b/drivers/net/virtio_net/Makefile
index c0a4725ddd69..c41a587ffb5b 100644
--- a/drivers/net/virtio_net/Makefile
+++ b/drivers/net/virtio_net/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 
-virtio_net-objs := virtio_net_main.o
+virtio_net-objs := virtio_net_main.o virtio_net_ff.o
diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
new file mode 100644
index 000000000000..61cb45331c97
--- /dev/null
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/virtio_admin.h>
+#include <linux/virtio.h>
+#include <net/ipv6.h>
+#include <net/ip.h>
+#include "virtio_net_ff.h"
+
+static size_t get_mask_size(u16 type)
+{
+	switch (type) {
+	case VIRTIO_NET_FF_MASK_TYPE_ETH:
+		return sizeof(struct ethhdr);
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return sizeof(struct iphdr);
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return sizeof(struct ipv6hdr);
+	case VIRTIO_NET_FF_MASK_TYPE_TCP:
+		return sizeof(struct tcphdr);
+	case VIRTIO_NET_FF_MASK_TYPE_UDP:
+		return sizeof(struct udphdr);
+	}
+
+	return 0;
+}
+
+void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
+{
+	struct virtio_admin_cmd_query_cap_id_result *cap_id_list __free(kfree) = NULL;
+	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
+			      sizeof(struct virtio_net_ff_selector) *
+			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_ff_selector *sel;
+	int err;
+	int i;
+
+	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
+	if (!cap_id_list)
+		return;
+
+	err = virtio_device_cap_id_list_query(vdev, cap_id_list);
+	if (err)
+		return;
+
+	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_RESOURCE_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_SELECTOR_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_ACTION_CAP)))
+		return;
+
+	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
+	if (!ff->ff_caps)
+		return;
+
+	err = virtio_device_cap_get(vdev,
+				    VIRTIO_NET_FF_RESOURCE_CAP,
+				    ff->ff_caps,
+				    sizeof(*ff->ff_caps));
+
+	if (err)
+		goto err_ff;
+
+	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
+	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
+		ff_mask_size += get_mask_size(i);
+
+	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
+	if (!ff->ff_mask)
+		goto err_ff;
+
+	err = virtio_device_cap_get(vdev,
+				    VIRTIO_NET_FF_SELECTOR_CAP,
+				    ff->ff_mask,
+				    ff_mask_size);
+
+	if (err)
+		goto err_ff_mask;
+
+	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
+					VIRTIO_NET_FF_ACTION_MAX,
+					GFP_KERNEL);
+	if (!ff->ff_actions)
+		goto err_ff_mask;
+
+	err = virtio_device_cap_get(vdev,
+				    VIRTIO_NET_FF_ACTION_CAP,
+				    ff->ff_actions,
+				    sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_device_cap_set(vdev,
+				    VIRTIO_NET_FF_RESOURCE_CAP,
+				    ff->ff_caps,
+				    sizeof(*ff->ff_caps));
+	if (err)
+		goto err_ff_action;
+
+	ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
+	sel = &ff->ff_mask->selectors[0];
+
+	for (int i = 0; i < ff->ff_mask->count; i++) {
+		ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
+		sel = (struct virtio_net_ff_selector *)((u8 *)sel + sizeof(*sel) + sel->length);
+	}
+
+	err = virtio_device_cap_set(vdev,
+				    VIRTIO_NET_FF_SELECTOR_CAP,
+				    ff->ff_mask,
+				    ff_mask_size);
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_device_cap_set(vdev,
+				    VIRTIO_NET_FF_ACTION_CAP,
+				    ff->ff_actions,
+				    sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+	if (err)
+		goto err_ff_action;
+
+	ff->vdev = vdev;
+	ff->ff_supported = true;
+
+	return;
+
+err_ff_action:
+	kfree(ff->ff_actions);
+err_ff_mask:
+	kfree(ff->ff_mask);
+err_ff:
+	kfree(ff->ff_caps);
+}
+
+void virtnet_ff_cleanup(struct virtnet_ff *ff)
+{
+	if (!ff->ff_supported)
+		return;
+
+	kfree(ff->ff_actions);
+	kfree(ff->ff_mask);
+	kfree(ff->ff_caps);
+}
diff --git a/drivers/net/virtio_net/virtio_net_ff.h b/drivers/net/virtio_net/virtio_net_ff.h
new file mode 100644
index 000000000000..4aac0bd08b63
--- /dev/null
+++ b/drivers/net/virtio_net/virtio_net_ff.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Header file for virtio_net flow filters
+ */
+#include <linux/virtio_admin.h>
+
+#ifndef _VIRTIO_NET_FF_H
+#define _VIRTIO_NET_FF_H
+
+struct virtnet_ff {
+	struct virtio_device *vdev;
+	bool ff_supported;
+	struct virtio_net_ff_cap_data *ff_caps;
+	struct virtio_net_ff_cap_mask_data *ff_mask;
+	struct virtio_net_ff_actions *ff_actions;
+};
+
+void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev);
+
+void virtnet_ff_cleanup(struct virtnet_ff *ff);
+
+#endif /* _VIRTIO_NET_FF_H */
diff --git a/drivers/net/virtio_net/virtio_net_main.c b/drivers/net/virtio_net/virtio_net_main.c
index 7da5a37917e9..ebf3e5db0d64 100644
--- a/drivers/net/virtio_net/virtio_net_main.c
+++ b/drivers/net/virtio_net/virtio_net_main.c
@@ -26,6 +26,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
+#include "virtio_net_ff.h"
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -493,6 +494,8 @@ struct virtnet_info {
 	struct failover *failover;
 
 	u64 device_stats_cap;
+
+	struct virtnet_ff ff;
 };
 
 struct padded_vnet_hdr {
@@ -7116,6 +7119,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	virtnet_ff_init(&vi->ff, vi->vdev);
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
@@ -7131,6 +7136,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 free_unregister_netdev:
 	unregister_netdev(dev);
+	virtnet_ff_cleanup(&vi->ff);
 free_failover:
 	net_failover_destroy(vi->failover);
 free_vqs:
@@ -7180,6 +7186,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	virtnet_free_irq_moder(vi);
 
 	unregister_netdev(vi->dev);
+	virtnet_ff_cleanup(&vi->ff);
 
 	net_failover_destroy(vi->failover);
 
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index cc6b82461c9f..f8f1369d1175 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -3,6 +3,7 @@
  * Header file for virtio admin operations
  */
 #include <uapi/linux/virtio_pci.h>
+#include <uapi/linux/virtio_net_ff.h>
 
 #ifndef _LINUX_VIRTIO_ADMIN_H
 #define _LINUX_VIRTIO_ADMIN_H
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
new file mode 100644
index 000000000000..a35533bf8377
--- /dev/null
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+ *
+ * Header file for virtio_net flow filters
+ */
+#ifndef _LINUX_VIRTIO_NET_FF_H
+#define _LINUX_VIRTIO_NET_FF_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
+#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
+#define VIRTIO_NET_FF_ACTION_CAP 0x802
+
+struct virtio_net_ff_cap_data {
+	__le32 groups_limit;
+	__le32 classifiers_limit;
+	__le32 rules_limit;
+	__le32 rules_per_group_limit;
+	__u8 last_rule_priority;
+	__u8 selectors_per_classifier_limit;
+};
+
+struct virtio_net_ff_selector {
+	__u8 type;
+	__u8 flags;
+	__u8 reserved[2];
+	__u8 length;
+	__u8 reserved1[3];
+	__u8 mask[];
+};
+
+#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
+#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
+#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
+#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
+#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
+#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
+
+struct virtio_net_ff_cap_mask_data {
+	__u8 count;
+	__u8 reserved[7];
+	struct virtio_net_ff_selector selectors[];
+};
+#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
+
+#define VIRTIO_NET_FF_ACTION_DROP 1
+#define VIRTIO_NET_FF_ACTION_RX_VQ 2
+#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
+struct virtio_net_ff_actions {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 actions[];
+};
+#endif
-- 
2.45.0


