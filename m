Return-Path: <netdev+bounces-256843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LylJuPKg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B1ED07C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA18130180AF
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C889366567;
	Wed,  4 Feb 2026 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cLuGoSN9"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010009.outbound.protection.outlook.com [52.101.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BEB318ED3
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244809; cv=fail; b=Bb1WD2AzkqBCzxLX/gOZi1YjHK1ShJgbtrbOv7y2O7i3RGzqx2jxnAM+x+5ITn3hPSd40UjDeczs8zTGAhwkUsaQMeuBHaU5SyAhRTn0kXEusb8cNYaGLHe9uXANxsD9KiZ07zoBuY6cCroAjv0K2Zf9fpiHAAVn200zeHZhwz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244809; c=relaxed/simple;
	bh=wsGUHq5OPVhfOEtt/rMv3q+JFLZAeVhlUX16tLUzxUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vy0pg5BHO+lB/oIhj8Tfw5gqZu/dpAoDjaBoRax6uz/qWIYhiNR1tY152xpBaIDiWfYVuOZrhnnv6tDpsvu/ugxo3ui7pq2xBEt41kwX+CSTSo8kk+YUcF0uQOjqnGHdsDtGPscaS7kcsilYIKfmDLqbmzELTt/OiY+Rm5cCJm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cLuGoSN9; arc=fail smtp.client-ip=52.101.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0H2+RQCtCi1XiMDHlrYu5TxH6bc8FH1Il2Q1sOaNjdilz2RBI5O53US8Vj1CvfGVM5abmaBNPFo8lVgHE293Cn9chZFh442Xwnce8p7tKmDE7pqD3C/MECW3Ug+zZorNPG1e6H4vCSUXRzOVpU3vPDaKrPD9YeCSeF+nMfJCtNnjokxk98LbeqvSOabkNbujHlceJJRJ+LM3z3kk/tvpolZ4Gv6a6QMnA8+CwnNb/vzYBP5SZDRnLo7AYEyNVn6DG7MxvmxsMN/Ypf8pY4Qapz6gEV+fNRXYCrAhV7E1CXTceNPPT7qcFeqIJrkJp5x9snmjWfZ3Xb4hYTO9RPptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=OLDfC6bKeNcrVMMecIoa4e4jMqURD87KCt1nbkzSE9/yh2nIY8mVYj8uIbyd6DUPruHvq6oeu/7WwI4S9TlpBlzuO6upGzoSxXZr4Q1RYUAcOTXFm/4mRRPAjWSaz4jgc5+UnXIjj5H8vO1e21ePeG3/CnlG7MXQDB46Nl0i31kn7VOnp5BMXSNFpM6Baj6A+Ym7Hk5UxP96wqHcT9I1D5x1P30SdSw+KBXPPzucF6woDk3XP/ODHp5Zy2cPufUPwclDcL+ACgkhceBZbYIDd+O034rclbilZdKd87k8Zh1SoDX2Y3WU0TtI5byRQwtA+DRV0kf1pYLlepRYLvm7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=cLuGoSN9HH/qsoD45UdOud9vLwgiOvxOSO+1kL9q7e965Hjh52ZFrUupCJGi6oeocAs/M76y/GF4DO4wuMEuyGQKi91hrGh4LAHZSstGTiXIHQdhSOocZfjZLSlhGeFZG7MlcvXIT1NGAeumy3Za2XaDunMpP8KnLVJT+dHJdsrlkBghncv9p9CvFkRXMBGx8pIfuWWti73EmqIskL9JiSK3+1Mf8phyV+jMid2BOptRq6uvkErZbwM8NutgtxP3YXufbM624Oy7EmLozZQNcP2b5FxKMcIJ8LwoQOTehSr9azOnteN+Xl8z/DNSe9igaPM24/1IRWcoYPczLOLgyg==
Received: from MN0P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::26)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 22:40:00 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::c2) by MN0P223CA0014.outlook.office365.com
 (2603:10b6:208:52b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Wed,
 4 Feb 2026 22:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 22:40:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 14:39:46 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 14:39:46 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 14:39:45 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v19 01/12] virtio_pci: Remove supported_cap size build assert
Date: Wed, 4 Feb 2026 16:39:29 -0600
Message-ID: <20260204223940.39581-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0cd970-d556-4a8b-d570-08de643e54e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3gUKbzC4vI49f5FCh9vyjhqgUE6bdQkABSLLFQXNymPyscJmhwVqqLaEi09S?=
 =?us-ascii?Q?+1qwVurzfKwabOhOYim+E58Wj9gBzb7gXfgfwh3V+BRmR/KlhVv8xFhVqdOP?=
 =?us-ascii?Q?MZjiB3JpuN9J6D8TlHQwi2+oBAhCJMkEnGLezW0W/Ba2mdxufjstpKSzj5WP?=
 =?us-ascii?Q?4BHiARHaB9I1MrdmwLWaGBEKiD9iu9B/M0KtGn2DaY9ZUiFQ84JiIvEWcjhz?=
 =?us-ascii?Q?xdJYfDCptwQIfePYajKBE0o0vJeJvN03aF/EJq5swsObRbOOW/BaN3e5usM0?=
 =?us-ascii?Q?c2zQ/KDpGfJCxWsFxZpy8ZouFw5Uf9LLZHoa3Jg01Nkw91qJCXZJIaJrls/d?=
 =?us-ascii?Q?lRSrDln7G5AzXWdx6kp/q1LnZFtWT4sejbgYeMwbQ9EJ8P8JGoJN4Wonc7kY?=
 =?us-ascii?Q?MccCuEjdnLy0pY/MgmsIDcvjKHOPB1qy1R6SBvITe33T3l0sZO/WP1UPRMfj?=
 =?us-ascii?Q?YTF0Z+qpF9MoK0nmv5Y0nO7964Y5DZfsaqVOrQvlEAIBsQcElt5mf6LjkPZv?=
 =?us-ascii?Q?okPGYZg70FhvXHHTTQloZDCE1va2Tz3xPI1UwHo3xfPzCwwYZTjFcSU3AP63?=
 =?us-ascii?Q?MMninmdQT7oCVkfBOS+JFbatzNoc3MLiaAnJrRvxPnRNmmWlLYqGyYHd5tL2?=
 =?us-ascii?Q?N40kBQY/wjTteV9xq67TOS9vqyoAcCj9MY2J1vvyqFr9ZdPuIMJ90rIx7rvo?=
 =?us-ascii?Q?sIMf+fQRaUiJ2WcMSu9B4a4TB0rOZc8XcAt4y4LbKfxyQaV/A+ho61VCMF2x?=
 =?us-ascii?Q?pz28iH2gT9j2cFkY1viHeb1AL9SZFUb3P/k1akTgTpB7BVNOJwOQ6q0E0JzU?=
 =?us-ascii?Q?jO1OC5v+JTPiLWEkU+5oYfrq3bKMrQW8wu6w6Ay2SV4r/S+W8vP+E6tEzsDh?=
 =?us-ascii?Q?gX7klPsHn1zCfdagIP4F11WY/rzcEtCcLIK0FXbE7OEKjOC6nrmcPpGHgXGz?=
 =?us-ascii?Q?lU3Z+M/gwU8MLyBFQIccSJqeLygqIfT3NceNZyTCqgfMyU+hlYrrbYnFoiuf?=
 =?us-ascii?Q?JHp/jbCxQVqspLKc6XIdk3YgTSbVSrbWO0N72qj1g7Jh6+6GRpcH3lj+x2rQ?=
 =?us-ascii?Q?fNNJhUPxggIfkvXxTpFOC5OLJdR9zLqk633mL0378XzMZ6ZfrQtaTAJnrCnA?=
 =?us-ascii?Q?CnlixoewutHkJz8ofiDwj+HTU1YnYhtMbJl/1m6D0ThPZQEySk1VlcbGBmRn?=
 =?us-ascii?Q?996gv6jqC+VBMFjKirMnqB4+YDebkFqZq5nvKIdPF3Z7Rr1Nmuukd84zge0C?=
 =?us-ascii?Q?qHIA3b85wqc/Hby2B+7D6Nz5Vn92mG2GlVElcaeQIyN3mwo/ST8Tk0TWikbw?=
 =?us-ascii?Q?ablgJwPV2zJrpqYxLXjWcX3i1n8CkLa/CDOUho/CjY2fUxCKOzQNabTHRv3O?=
 =?us-ascii?Q?vpY7tBXwpg1r/9gKutPSwNSQOsOL+RVCr5Ok4OaY3n0eC3EDxwznD2H9rtYj?=
 =?us-ascii?Q?rgiii53kbMZvmpsVpVq9pfGSQ9fl0Lh/pyvvdVAPGpRZzkfFhi3Sj7IDbV6t?=
 =?us-ascii?Q?qlZXmyH+pVdPv3qptcgSmZABjqC/byNhNuAdJYuTZvfFF/SJhSenT/QFquSI?=
 =?us-ascii?Q?QFIbMMpTyBJxr0AY+201idIdb2WGdmdxbvaw5wIZQsWmhLxzi7fQL1x9fA4/?=
 =?us-ascii?Q?LaZI3obAYTu0LWR6fJRNn2LUmFCjK0J4I2MrwHRpOZ4vZ/SH7kaG0Oy0CpOc?=
 =?us-ascii?Q?myqEcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sqK8T887AO71v3EgPAlVOoOPUy7HwJ1JtaD/0R0hAnbRz8vxMfHWHpLz8gGP5zpPxNvlMt9oy0cqOyhZWIgsCkVYn86VVjBZ/0M0KBosLsfKierDBxyr0QqHpui3HLnG6b1o5Efk6BIvEi25U5co84VWgWZllO0FirX5vxpVxAjfGpDQcUIWqcAzGlM4EDeC1GJhQagXfn27QJc1tEhogqG6Ng1/V9JrJKzfzgGm6uaCRyOOqz9+Ujfq8Hs/f1FAYP4mXf0LSC73GixiyM3CJ6CvDnIP/1ZCBXuXKnTOEGt++Xw3abYjGrnbjYycCtOf+Zz4mLQiv+X8GHx3R+qBXwv3SHe0a/CwDSMrPWFggQ9azknngWiQW3jRWuDbuxbP/xWHCIFZbDSA56PGcD3qBZqYz2W/MunsMI/p7j/CuLyMJ2rj/u447z8zW8Y6R34a
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:40:00.6331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0cd970-d556-4a8b-d570-08de643e54e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256843-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 039B1ED07C
X-Rspamd-Action: no action

The cap ID list can be more than 64 bits. Remove the build assert. Also
remove caching of the supported caps, it wasn't used.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: New patch for V4
v5:
   - support_caps -> supported_caps (Alok Tiwari)
   - removed unused variable (test robot)

v12
   - Change supported_caps check to byte swap the constant. MST
---
 drivers/virtio/virtio_pci_common.h | 1 -
 drivers/virtio/virtio_pci_modern.c | 8 +-------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..fc26e035e7a6 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
 	/* Protects virtqueue access. */
 	spinlock_t lock;
 	u64 supported_cmds;
-	u64 supported_caps;
 	u8 max_dev_parts_objects;
 	struct ida dev_parts_ida;
 	/* Name of the admin queue: avq.$vq_index. */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index dd0e65f71d41..1675d6cda416 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -304,7 +304,6 @@ virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
 
 static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
 	struct virtio_admin_cmd_query_cap_id_result *data;
 	struct virtio_admin_cmd cmd = {};
 	struct scatterlist result_sg;
@@ -323,12 +322,7 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 	if (ret)
 		goto end;
 
-	/* Max number of caps fits into a single u64 */
-	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
-
-	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
-
-	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
+	if (!(data->supported_caps[0] & cpu_to_le64(1 << VIRTIO_DEV_PARTS_CAP)))
 		goto end;
 
 	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
-- 
2.50.1


