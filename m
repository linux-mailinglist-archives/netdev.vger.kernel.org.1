Return-Path: <netdev+bounces-257349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKEuFyoehWla8gMAu9opvQ
	(envelope-from <netdev+bounces-257349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:48:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B598BF8322
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76E6B301DAE7
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E241339874;
	Thu,  5 Feb 2026 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PzXWyAF1"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020CD339868
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331656; cv=fail; b=d5Q46tbA+7v60dgKSrEvXPm53Id9msCuPms1kh7iYo3qD1ZsJDKKwJeJ9S61CdvbHNcQQXE66x2t1FnYv5FLVN/s/m69DLIaT5490ezRYSxLJCEdDH+Sc6BnqWbe7hsNSS+xqCK3x5nmy+AMPrsRuf+iwNu1PzjUkmnFj7f4X9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331656; c=relaxed/simple;
	bh=wsGUHq5OPVhfOEtt/rMv3q+JFLZAeVhlUX16tLUzxUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYFAyLN3zsHV+Q3lwHb4GIE7NGGmP3iDaHfsklMvxaq8Ivg9CRvNwmEumpXZpgdvjZCxWGFrY+bZg0jefvqnrHt3FVEung2VR3QO3BLXpCyU1VThUq86IJ7A3fH6pXHxl8u1X8OfETmjzqFQTpBXqZQMmNNBXLk8WvKkXOgWN24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PzXWyAF1; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8f3rUThXCafORsuBV+Fa+UPeHiq01EHJdrbEK6g3KLEUPgD9SoZyLU0tnVSdpWLdlj+uNuF6n9eYdRhoyItHqYeoKRfgpDaWM6ds4mYbG9h0q2Hx5wTztEYg3vlG3aOprd7qUOmkYvL1rI9nfFI2MPyOK3yiYU7JLkghCsEl9Qt5FHr7WTY1V3X19yRo0dcsDIiLQMlsyyQTzqPRmGrxVZ6ww5YzjDgfb+s87re3JbBXfenmnp0t13Py+GEbrePCmkAGaszoTKJZMGbnywQkNo8ETnm0yJVXaUTn5tnNOfqpywLiF/2BY12JwWHiXCg2EAc9VhKjioZM14SUFHDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=u85u62FtcRtcbzYzBxaAAAglUjZdUPLswrr/6Vub1r7Oacww57saFdjGKP40OyWgEPs/97a3dVhTbhECIgTvTot5PpGrpmBW1EMJqJ078aQDpf6G/L2FC98+CQRyNx9Rpgcd5XDb6LEyJv0MVTu6UIed/dTU0xwxDpdeCIxljUK8r454+V9uEd7jmQTtYiA2cLhAOpaZOnkiaE2poeNjb3m1r0LU80vHHX4xi6Kw1JYgqU3kSY7cFQM9zMFAe7rKshCFfZ7u9osFWd0ZsYKjJnOUBxHah5GN6TXU7avcaGb+qeIwKfpmJmMauYOTaWL5OzpF5UWsQavk8o3/XTLK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=PzXWyAF1xwkj0ebybzvqNrQSl6/1D9X9/B/uolodxuPDqxA4SZjtv0p7fs6hLKFVnMnHeugMRMBXXaCDT3Dej70uc1NWhLaDj51D+g8k8dwnbFyHre2gT9sT9Bmkf+NoZcGwVSJyNOOptN0TRwieOSxCqxAPl9EX3NT+fxWEzbSfATJ7Jlxg7WptOanJU0UPTNzbGdqbkb+NcJah1zpL+A6uk19jpKo2aaE+PpF3KH/SpM6Yo3wCJo8jfDbzpssmvbDlEGM8Quc+zPl83KHYFqXZJpwcDiWyLphsYQ/PmKDpNzpwle1+I05mhly/sn1G0a3yNhYUZWHhZK4OhYUs4Q==
Received: from SJ0PR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:334::20)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 22:47:28 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::88) by SJ0PR05CA0105.outlook.office365.com
 (2603:10b6:a03:334::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Thu,
 5 Feb 2026 22:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 22:47:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 14:47:13 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 14:47:13 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 14:47:12 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v20 01/12] virtio_pci: Remove supported_cap size build assert
Date: Thu, 5 Feb 2026 16:46:56 -0600
Message-ID: <20260205224707.16995-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205224707.16995-1-danielj@nvidia.com>
References: <20260205224707.16995-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 90539078-982a-469c-f37d-08de65088a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A+pjIj/1ExS5/Y1rvGP99fZ2Uoy8XqjbRqpKm31UNLLQnQiHinZ9Yo5nILqQ?=
 =?us-ascii?Q?1CrIueqhF9HiftbbQBecc8O3C17gGq0+zwq+TQnaowhzKIMgwLKHPcMQpJKg?=
 =?us-ascii?Q?nA4Cpq+j5/528nEijSxlKESoaOeUoENBbeKsuqiTizm6AJrtpELZSRfXYoGs?=
 =?us-ascii?Q?2YY3XAgIjNJL+Uz8GpKl04dNWC3LbvYgxbIZX0EPFFm+z5loFH3vG51q9YNN?=
 =?us-ascii?Q?8EpaKyC6VZVQ8I9Ae5OKMndGaaa7Gze95mH9j0Ywgm4eLdLcPqFZ2Kk3RmzR?=
 =?us-ascii?Q?fEG5DSb+Vu3qhWuNJnWVCWt6t9fHrh2gvotZb8KAzcatwDte3cdUEINMy5mV?=
 =?us-ascii?Q?V+NrQDBpJHA32lnhbqxu72ZIbWlZnGN4ldNW48UQ2Bc+P1SAnbILrTvMAGSH?=
 =?us-ascii?Q?PBrOwf/Dc2ZQadRhSdYLFwLM4/vWaAmFlcIqDJCLLUZoCK02HAHHO2WoNdHA?=
 =?us-ascii?Q?j4Qk26Wj791PP+j1KlDv9U2BOzVeS9mvbq5+Q/qWtV1uUGu421WXvWa0fOp4?=
 =?us-ascii?Q?60Zw6QKccdC1+/ryLq2awsGK1210trnOKwRNYIdrZ6OK/zXgVd7uq5ZnOM3x?=
 =?us-ascii?Q?LKnhRAwbmwVrzNM2TAWscHFdRwRvR6KQwlaQrkBIz1iUDdmu9WuhyKJL0sPh?=
 =?us-ascii?Q?KLZCC33MecI4erJpoye1FMEHxFgnFJWuCb2uPBrX/t9PuxBpXQI7NdeuOcas?=
 =?us-ascii?Q?kRhV+2dehaq8Vi0sGlzfDDndlm0qbg4ilFl0vYsxp3RVXnRHvJETUjUZVZ0q?=
 =?us-ascii?Q?sTz+IQ20YPsmFFQ6PSrY8lI8RVA57ZmKsggOaxO0lv+xfm0eIN4AQQ8C1uLM?=
 =?us-ascii?Q?Oubad0zAdpd34reGGOPEjSgYxZJYAzOnDz1Zox/rn00Qnr7Hznr4vLIQ0QM7?=
 =?us-ascii?Q?jiCvFAG71FNl1wBTyf9y1c/KWCnURwZf1nsH8BNgrl9iioVpsq8yEbYC97u4?=
 =?us-ascii?Q?ydGWUU4xtXy+taowUR+onG8yc0oPCaPcQ4Q42rmjCqNb0DbvUX17Lqy1OLUN?=
 =?us-ascii?Q?PW17y2ok1S2q+//QzQFvzo/7xkaKXBWkpPRdXMmrlHTrviMUMxGXL7wcFjsl?=
 =?us-ascii?Q?Gsx7UzUFS4pkgnSLrE0LJTqElGMfSIKHJsliUnnmzME26pPhxwii6sV31A+d?=
 =?us-ascii?Q?zEh8EAqtosZpA487sowCfYStPGePojU2yo9sotATBfPf5p8aY8IxEQa7cizO?=
 =?us-ascii?Q?ZYDrdgCCu88GZ6G+/+OVBEbM7/xhmu0SilR9vTAZbCYy7UezwwSMB73WhpFt?=
 =?us-ascii?Q?mFQWkeNu6W8u0/5aQzU3SZkJnRaFNwU1VT3hawNGm5/MXQCnYLqcz52NTwq7?=
 =?us-ascii?Q?V5sA9MCLE4Aw0fTv1FBDrp7YOc1v4UI+7NJy/FdZogo2kiL6KjXFgJj+LU2v?=
 =?us-ascii?Q?eu6kJzFbHkHOr+HQy9Vmkg0dka9XNjeImU+hdmd99h4o3nb1+ID8kEnmoO5u?=
 =?us-ascii?Q?/rZqZqNiw4YmbbwbReOQlnm6FB6x1SuvtINTQTKd7J5KtOy/cREPG0aJueCH?=
 =?us-ascii?Q?PG9zFoUO5lFXBPcvF6+ktuafVzNdEFG5W0RqSfcro4liq9s4laD62jj8XHD6?=
 =?us-ascii?Q?E47xIqc9tUSqjILMZlPq1iXcLtYAgMghP0Bq5yZ94aMGpLnVbi1TA7UwNml2?=
 =?us-ascii?Q?HK7Za3tIxZRQDKkoEdVtZjza24sNsv/LVSM/LgAY0RZRzjeS3U3dBcA+w0Sz?=
 =?us-ascii?Q?/vCUrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z5tWm3Q7CEyCPbm15EMLZgXMYtaXkiidKhQLMFqr00vwaVnM4MVI/oLXpWqRuceqTsODycVIXGvOXSQGuI1fuWxx3pjCp6ABmRn2EbHp77vDtRmTGfqIVG7WG2dwMkyepB1Mh3j7jvKPJbragCNj5pDnnAZrfLouxxO1icYbUrAJiicxzYTbvy+jeCs6a99qztD4FiklHurf2/QlsKPMyz/EtFnmDmNr9vDHkzH/BY6Gwh2mrS8df3vojrLwnB2bpe8jbhjJf+CAx5Ev0DyHlR3PdtGLWW0OOoZqBWK3MP3hkXmPGMkpI2D7JOi7ddfT9GjUjTVqJNHZv72lbcA1Cfj+KT+ZZ2PdqktC46kWOO8townueiYs2Giggx7osh5J6GbI3+5bbFCpyaKN1nOynxwJiugD1+6OL6pUJSBivsldNjvAt2Q6xVI1kfBdG4Ku
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:47:28.2771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90539078-982a-469c-f37d-08de65088a06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257349-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,alibaba.com:email,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B598BF8322
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


