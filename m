Return-Path: <netdev+bounces-255954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHoGJxnbgGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:12:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD5CF6CB
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21EFB305A516
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01654385EF8;
	Mon,  2 Feb 2026 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o5r9a4ue"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727BB385531
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052000; cv=fail; b=BFrRm2ptK8EL8UQv29vu4YyZH6aizsubmlS8SEp8Wc+xUxIAX9T3Q/o2WDJMfKHdkiCtiivfCfFsX2bYWS1dixkEYo7oL9IUMpX1Yomj1QPeUvdPEgsKM4ATIKaY7gCsudMDIOWoX3R9i+w1A+6sK+n7yfnzX6OXCes1qHHMHrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052000; c=relaxed/simple;
	bh=ADdsi6ZK9ResnVdtZ/eknU+N9zNASKJS3FoUlhHRy2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxSgP7sSA8b95PASLjN/bISM6lOZs7U9xaiiHRm2QJ7xYI/82dwmVH0ARMycOZmuVMezlCCgnPxsC0yY454sfFQwxw3LWemAnx2DaWNWnTs9BetOHYuCjAlxftXsKugRU6AZFfCWQfSdv1DDsv47LeJ01FLGJpEwKWz1sjPFO9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o5r9a4ue; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAu5QKzA4upvv77Qiiz/bzXwxWuOtEoySzJWFwPXCqa3AphL8QQgm++xDQwyh4oNpvtbHhXMCgmE+k2iM2XlldrQdJ0VQsHR1/LzSs9VAkmoI+r0DYY9IVHYc7mdGf0H4vNRsYJoO/5x8UNoBApdjqrNAI+3YbFLQfasuj8AolWMTPvU6QqjnwvPtUyN2ZrdBAHx/u8El7btQKUH2hUmnoMl96GmXi8f3wxlHUkpgogK+7Cug/NfSB7/Qmc/t3e5fQrssGTaf8LVxh38qi2AFs4vVUowwhQnsiLU58Ay+gSs9YWMAZYCw+Xee4TyLkWoDu+Pk7pD7blfVUQc8znxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWFxMi9tDkZ79AmOgaREjy6d1/vGMj2YmWJkhZoFWKM=;
 b=B539rmPxhDppclwhpOCrxK6W349MrFMsW56uk1mg2awLV4BJqhW3pVF4GST1+uK/tRSKMSil9BPcj7ATPP5492JEEHFZpjDj+/p6IoTyJCCb3fxpcpq4iaCYuumwvq7Mqhb0fO1PTg4GrfEsg2oQQj0CCrxJWlZteMcsE4QmNiRSnG4Bvvb1ehZprac9Dgb2YGbEwIlvfIN4cVDrP7WEBUvwfrREnDmiQM8E/SPqifQzeHxTSN5S5LIH2bgHwARN+SZxra74eE1zEDUpVwHhF682lDjTAF+mB8MCVPASBZFiN5QKJVykcey3aDcD6Bt8PD/ExL8+FplOAIlB3est8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWFxMi9tDkZ79AmOgaREjy6d1/vGMj2YmWJkhZoFWKM=;
 b=o5r9a4ueXf0PbJyBB+KBZTswFRFYJRl0M4TRqY0u8h/ACAT/DnZ9KHVD8qolzG4aK5VqI5L9kYmrCKEJ73xMJ9NUY/m0qfOHA0kgCaBq8tRJQXemBPx1yLT4xoo7DlxVfnhQw0gfH6xj+fTU9OXuaDxN7slAfNQkW/IEM/fhhil7fLv6EUufmbnJqdhY9Sp/QgMb/b3sYTYr/rk/uYmlzYfrttFHKW8BHpZ36RwlrmxKwS8TXBaPyS0Sd6/8P5z5OR0TLRt0cUBIry+8C79YPzC4JjQYDhpiKTs+OfAGUiBGPNM2aLjQkDIdzGV06dDQJfh0/tkvXxV7CI1HQkatuQ==
Received: from BYAPR21CA0020.namprd21.prod.outlook.com (2603:10b6:a03:114::30)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 17:06:18 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::f2) by BYAPR21CA0020.outlook.office365.com
 (2603:10b6:a03:114::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Mon,
 2 Feb 2026 17:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:06:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:05:56 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 09:05:39 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 09:05:38 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v17 08/12] virtio_net: Use existing classifier if possible
Date: Mon, 2 Feb 2026 11:05:14 -0600
Message-ID: <20260202170518.9076-9-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: aeba702a-693c-4f00-0620-08de627d60e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oXEWFlho8O1Wd6+qSw8v/bDWOzvNNBY6ysKl9HCrNL54LJuWQ2bbgm77nusA?=
 =?us-ascii?Q?4uhU/EksvxSBAB0l4EgCD2uobc1CpraoaHzjM/k9iDPIwZ8t5dgdHy4/bM7h?=
 =?us-ascii?Q?q+B0cuOLiPMdDHJqAazRt/VIGzBUWlDX/yc38f1QyETRqrhA367nvSvjPmkU?=
 =?us-ascii?Q?CrK30GG7vPDgWvIENIKYa5Is06YI9qOLgu/eCAFj3t5Gc61ez9Xz0l/9H2Wc?=
 =?us-ascii?Q?pypMm6WdRRtdfbmuqz8M2JgE95E1eH4p6OHGbIBEFWuJfuiZy/aNhvqIVrUz?=
 =?us-ascii?Q?TWptwTlYRr4AItO8eZvvfkU54bWeQiJoFsfiKgrO8inhjpsQiIHdNesIenV9?=
 =?us-ascii?Q?btaVYwMHwJhBWKxHt/Wa9iMvo8PAvvPRpodiP/tsO3mG6AyLBX8hf6Jsr0fS?=
 =?us-ascii?Q?s9hF1TnqHyvDR8mcaeeYbKrg2k0iQIs1AzHRRW+KeE75P1JTnh/lLBR879/j?=
 =?us-ascii?Q?f4DPhNkP6Ql98G1aiiRqVZWTTrqBNTguluYXKtqQk5PtxNLF+t9Lif0/nR3O?=
 =?us-ascii?Q?IE+1QXZFv1/5OKwWE8UDChOuSFGgaykOaWcUDaXVGmHRb2ET6BTm0+Gorqov?=
 =?us-ascii?Q?hfrxh9C1f1XDop+YvraOvJB0anO7Pu876WYtkJO1E9fSWXNWzyEdZvtgErJp?=
 =?us-ascii?Q?0ouxlLLDzKRuHEeuYZRBD3MSQMfyMJXmLGHm/gXKmD0590j8oRJ/E4w2S/fH?=
 =?us-ascii?Q?TnxYCQO8xWkeRdv98BN4PGnztwGEdl5QIFOOzYcFRuPLJDp0kIAVvm63AvOK?=
 =?us-ascii?Q?5wzBs0DvrXKQU5ipsECHS1uMG9hqhaC8zPFZ2LniI+mZUvdAuJQA74XMQlta?=
 =?us-ascii?Q?Ep9on5idny5uGWCoxKuEs+pGvrAV4uLadSZfPTjFA8u4qqFW6PssFEFL2cz0?=
 =?us-ascii?Q?w3wiUMkhZqB7q+CH3fSKQmrImdyTOw7orYQ/tYJnniWDDzAp7ubbFYazgkId?=
 =?us-ascii?Q?W2j8BJLV1LeAT3OJ9y+Fpk/wNfg7sXp8xQoWsgGWfvJhomBf01E35u0E1t61?=
 =?us-ascii?Q?RF3E2rL6akwQPEbdY75lCN2Co1dOCer/8Yu9OU1FsaP86Rz9Qq5yA2zPfYui?=
 =?us-ascii?Q?inSTm5KC0UCiEslXoGW0v8BcLpJUeuQ42LcZqRgG8PPfWQMc7iRiOTQShcQm?=
 =?us-ascii?Q?iXb9mQXybAFmZhkpRQS/oreoJhutKaxFnUYw4PMJI6YSHmXhuxw0LypW39WE?=
 =?us-ascii?Q?iCtimS85VstJ5w4cItkVGS3XezP9fFEml2iN/CKgjlJAFzTFcHqP65DMjOkP?=
 =?us-ascii?Q?aV1pJFdis/32E48MtqXGs1CT3ialEpAdtvNM5roljQpXJidxDBpkf3CAEy5j?=
 =?us-ascii?Q?j6e/nQpd54KqpMfzd/VsYH5A+QkJ7E0zNY63+uBcnlqYhSUa2qD1rzU0dgoX?=
 =?us-ascii?Q?ax4TvKno6LMHyGPoLsr4lxvfyhXlL1bJOVEFg/LbTEoJaAC5T0cs9PR1Eq87?=
 =?us-ascii?Q?f9svC7z9lq/Hmednd+LnoHJBxah1hUVWwkXUmdBGoAI4B1MqRQVU8lkrtLE1?=
 =?us-ascii?Q?6g1j0bzA8LHCqDyv0pEVjn4chpu1JDLE1V14sKEWu9rjYTnKAkuifGn7eR8X?=
 =?us-ascii?Q?8UYyHYRa5JnKU7dfvSBu7l98fy/208CN0VJQzRj6+oXotnQgkKtqNurnJq2c?=
 =?us-ascii?Q?YQih5xH0sxgvED02ChOeRYTigr2QhqDMWNTy4xgz6TDl+MTSU+Peez1pDyHd?=
 =?us-ascii?Q?hkZIEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	96x8EoVKvtMlyJbjIyuel5LesFOsPGfc68ydII/n57/QKHFqxKMGrASF9BNN9ItsWdTH6pFNsopnV0XIQxSBfa/EW3Jxeh0ceMHL7fQ8JcYG7u9sTTQWSdcSUj19mtJVneR6O9P/6m1a4TdBpreDU5TfJEdRbSUdfVqB5eKalWp+zouIrNDktrJswxqyF3NLeyb70bMYA5TMukJUkNtDdCNBUuoSitSpDbctdul0Yfk4GPvnk+H2EWg1M5ogfZJaVBYpK8ESLmwdVFpnK1/lCxIl7fFA09zb7ezorG7+1gCohsvPmdhs7LbK4GEYe/9wrJpK45U02zuP38cylBWWpkwhEXHPtc6tUq9TpJY4otieP0OkrUcVpqTLawhrZIQSiMpzE2cS5kZ6A4n9CtnkETYzFotnmsk5qHss+r5p2O5HMaQuSEGrFXnTLa+d3nkt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:06:16.8946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeba702a-693c-4f00-0620-08de627d60e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255954-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,alibaba.com:email,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3CFD5CF6CB
X-Rspamd-Action: no action

Classifiers can be used by more than one rule. If there is an existing
classifier, use it instead of creating a new one. If duplicate
classifiers are created it would artifically limit the number of rules
to the classifier limit, which is likely less than the rules limit.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed typo in commit message
    - for (int -> for (

v8:
    - Removed unused num_classifiers. Jason Wang

v12:
    - Clarified comment about destroy_classifier freeing. MST
    - Renamed the classifier field of virtnet_classifier to obj. MST
    - Explained why in commit message. MST

v13:
    - Fixed comment about try_destroy_classifier. MST
---
---
 drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 008deb1959a3..3fc0ecc74a2e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -32,6 +32,7 @@
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
+#include <linux/refcount.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -302,7 +303,6 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
 	struct xarray classifiers;
-	int num_classifiers;
 	struct virtnet_ethtool_ff ethtool;
 };
 
@@ -5740,12 +5740,13 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
-	struct virtio_net_resource_obj_ff_classifier classifier;
+	struct virtio_net_resource_obj_ff_classifier obj;
 };
 
 static_assert(sizeof(struct virtnet_classifier) ==
-	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
+	      ALIGN(offsetofend(struct virtnet_classifier, obj),
 		    __alignof__(struct virtnet_classifier)),
 	      "virtnet_classifier: classifier must be the last member");
 
@@ -5833,11 +5834,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	return false;
 }
 
-static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
+static int setup_classifier(struct virtnet_ff *ff,
+			    struct virtnet_classifier **c)
 {
+	struct virtnet_classifier *tmp;
+	unsigned long i;
 	int err;
 
-	err = xa_alloc(&ff->classifiers, &c->id, c,
+	xa_for_each(&ff->classifiers, i, tmp) {
+		if ((*c)->size == tmp->size &&
+		    !memcmp(&tmp->obj, &(*c)->obj, tmp->size)) {
+			refcount_inc(&tmp->refcount);
+			kfree(*c);
+			*c = tmp;
+			goto out;
+		}
+	}
+
+	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
 		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
 		       GFP_KERNEL);
 	if (err)
@@ -5845,29 +5859,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
 	err = virtio_admin_obj_create(ff->vdev,
 				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
-				      c->id,
+				      (*c)->id,
 				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
 				      0,
-				      &c->classifier,
-				      c->size);
+				      &(*c)->obj,
+				      (*c)->size);
 	if (err)
 		goto err_xarray;
 
+	refcount_set(&(*c)->refcount, 1);
+out:
 	return 0;
 
 err_xarray:
-	xa_erase(&ff->classifiers, c->id);
+	xa_erase(&ff->classifiers, (*c)->id);
 
 	return err;
 }
 
-static void destroy_classifier(struct virtnet_ff *ff,
-			       u32 classifier_id)
+static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
 {
 	struct virtnet_classifier *c;
 
 	c = xa_load(&ff->classifiers, classifier_id);
-	if (c) {
+	if (c && refcount_dec_and_test(&c->refcount)) {
 		virtio_admin_obj_destroy(ff->vdev,
 					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
 					 c->id,
@@ -5891,7 +5906,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -6063,7 +6078,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	}
 
 	c->size = classifier_size;
-	classifier = &c->classifier;
+	classifier = &c->obj;
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
@@ -6073,14 +6088,16 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (err)
 		goto err_classifier;
 
-	err = setup_classifier(ff, c);
+	err = setup_classifier(ff, &c);
 	if (err)
 		goto err_classifier;
 
 	err = insert_rule(ff, eth_rule, c->id, key, key_size);
 	if (err) {
-		/* destroy_classifier will free the classifier */
-		destroy_classifier(ff, c->id);
+		/* try_destroy_classifier will decrement the refcount on the
+		 * classifier and free it if needed.
+		 */
+		try_destroy_classifier(ff, c->id);
 		goto err_key;
 	}
 
-- 
2.50.1


