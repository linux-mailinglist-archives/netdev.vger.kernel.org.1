Return-Path: <netdev+bounces-255945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKMJFFXagGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:09:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A1ECF654
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D73E3025D09
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7469F3859CB;
	Mon,  2 Feb 2026 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FwWooa/n"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44EA37F8AB
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051975; cv=fail; b=PtfuzmLQJizUI8VU/AquM/YVDsrJ0gO5j1YiXzfgPalOC5isV3VVYJOZklGf5uA5lfk/dN7he9GFztSudqr6Iqz56WaHVqL7jJJy5HgUZ5Af3kA6d7Lqlr2sjRvsErAEXo19UJ/GKE/sTQjABXCDTWEYOQLwthbr2cQLYXEx0Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051975; c=relaxed/simple;
	bh=wsGUHq5OPVhfOEtt/rMv3q+JFLZAeVhlUX16tLUzxUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYV5ZW3agOnDK0NUT77BBCorp839WWaTtDHr4+GeLbE7Z6ZsziyZOo27+5dfz0Q/taS1URJnJG+IkmpbaUfdMvmPNEjYQ/rXIy9PgjFqv/+o85TL45OyRMRAdPtHzunuQFrV6OzYjt7ds1HCQx+9bGI24am4k1kcPHhDdAfUS4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FwWooa/n; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVBpQidXi0usEvxsRph+dgxDxTqTu4UH/JTfMVrGvaEALI15Ix0n2JMfbg4lRDdao16/nTLq/WIeAzr8RJD2bDdl/iO4sakyROxYNDmJPRhGC8YKyrD67rD8A/+MSak4766s6IBV2xejSCHuJ1VOo64BmAIZiQSXV2nc+lZ3VfluqpG8DNY/bzUIdMY5jorzaHS1kNUM5jrKKtH89pCvOXV5bv3x74LF0Km9zGbxUepjeaoHMBeyUrSlC7+2GrghDbKbdZZbyxmFfcqpofWuryKpK6aQveLDXvRsUdmN5hbbUV9vzMP2rwiL6ZdGBcsm16zBCC4Y2548U3oMkQetcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=o2oNQDaCkMOkFiyKnREWsaKw1pjzcD+50gAf0ino8aMp8IDwXVV7v7IoPPUkFx2PBZKCXUVtCH7mNia8KUSbo1wKq5uOuZoMllL5P6cuHOWF17chPxtFcOAsOzgcYrpqbI/mAUtrvfdHNfugqMrf9J7XtACaIRpaQnLxNbD3HZoFuGWgckgs630wTSoUPTlYZevpughzUFTxzOMPArirXNxjPEYNhVTez558vZeoUULXSe+oYwOdA5kNWO/zKwWTeLqp4Gf0j4kkBUfqG6wL5+ErIXsxvZzJ9M8vRpq/c0b4BWYd4sTYc9O8BaqouU0bKS3YYoIZc7jW4VgUmbm0YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=FwWooa/nWFVDLpWABON3lXkDskVh8CNnB8jEf317FGimlfW6f41WSpAR4GJ9TFa0deaQ5weDiKFBEDpR3cfELsecyU3SrLoNMRwrDRVu5SJieK/uv4kpX3rGT6QvWnTpz49pxa/Z3vZmSvwv8+XHjd5EeVMWRbebfFfGkm7t5RiNY65kijD63ege+TXA2nnpIZlTIo8YabqdgI4oUDiqhhMSDVM7Ga71CEyU2OCvKpDkv6B3SDk948MbOdef9rjSWxIrFSVc3fwwvsRSsKrxj8AQD0KCat7iriwKULuW9HCu28i67E3iuBfErfh1rAi84Kyj5h5xDk2L7F73z8u0KQ==
Received: from BYAPR21CA0003.namprd21.prod.outlook.com (2603:10b6:a03:114::13)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:06:08 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::c6) by BYAPR21CA0003.outlook.office365.com
 (2603:10b6:a03:114::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Mon,
 2 Feb 2026 17:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:06:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:05:25 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 09:05:24 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 09:05:23 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v17 01/12] virtio_pci: Remove supported_cap size build assert
Date: Mon, 2 Feb 2026 11:05:07 -0600
Message-ID: <20260202170518.9076-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ad6b9a-3855-4b6c-6b7a-08de627d5b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dn2Y8WC2d9HB3ce7rgh5I6W+DxqToyyMQ1fPSTfyjHt0MnK0MjI4EAJh0mHk?=
 =?us-ascii?Q?lbkH27g+FA94XBJTwzRbRS8FzDff0cUl3QvRmz9tITfT/xhGh2Y7XUEXTXUw?=
 =?us-ascii?Q?9dMtwdkUQ5F+LKRJIajgfL6ZC4EW4mmvO7ck+soGATIsdVv/Cs4ta9Bb5bA1?=
 =?us-ascii?Q?YUuSvH/Nv/tz5SIs94gSJp+qYlHGiZE17Yy++gMnMkbEbibvRq6wt70+oRiK?=
 =?us-ascii?Q?OgcN1u+6Hr9TMWGaKsN7lIlYyLrBcvcDV86SMazAAWzdvTpH6k2oZ+YtpPyG?=
 =?us-ascii?Q?+U5sDH6QWX0Kq4pg1BvmJpu/e1YMp97u0gDtVM9PDZesjFcpKWZ8bqeqgaOk?=
 =?us-ascii?Q?GwoxVk5ZtzPvuCkk8JjJF6RJ/llrxPS0o+JsCu83XOyTrnDjexhWQqOiPFIS?=
 =?us-ascii?Q?06K7hf+tkZEdtFROZ/ZBBiwiZcdicZwx1+x2CYjkr1IGUJk2mI/MsHDQPNTf?=
 =?us-ascii?Q?V1me/2YDxAqQm54ku9YIfYQgCxxQLI09LavywCsX5R0oPBtI+OsFI63aE9ut?=
 =?us-ascii?Q?vIdIx+dkdnKBsdg+rSr5vfq+/p//Z+Dq3wE/VxGFIWRUzTcWqc3pcI+PiCZG?=
 =?us-ascii?Q?awMNJE/NruMZPYduPBsbzXBQ7zEqjaZMqFYsR/mJpE5SIxtODi7u7WS4Z2oV?=
 =?us-ascii?Q?vsTNReOxdfhOCuhlcLJlS1VhH/if5nGjmLztAOPzICrbkycSwKC1J/OxvnPw?=
 =?us-ascii?Q?Dp9ET1Wi9T2/sxeben37YuqmHUGXzhsgb83Ly75NEx8yE0XT0VghtYBy9M82?=
 =?us-ascii?Q?bH3S243HRUpQH4w5Tkr36tanNO+8HFoNg7pHnAWwi5jOk6ICs2r77DrRGudW?=
 =?us-ascii?Q?uvxV8KLLLpWcKJswGeFiMfsii2J0DWZwKFwhqkJLnROokea8PpwqtfRyJW8W?=
 =?us-ascii?Q?XspxFozQWMuRwMY5HKFrhoWQVU3q/WjgenFPHPpYXvY5Zdpch2GZwte8LgVn?=
 =?us-ascii?Q?b9UsPgll4SieFBs1wL9Ne+ASiUX2gmieoTmB+Z9L72EicxCjtbooa3hV0+00?=
 =?us-ascii?Q?T/xm3094vUYuhy50hgqhkV930yeHZmH3/xERoBWI1OTlReJN8nVYm66s1kZg?=
 =?us-ascii?Q?IDE5wCPLF7IvhHqMcmW9bGRCNlYinuK5ceJASSh6G10chziLp1Wc0F7z2BpD?=
 =?us-ascii?Q?cbBsH/xnNY4beySYN+yOjEqT8+T7U3tJ0zNbXXD3NjlZL657/yPSNPHrlWth?=
 =?us-ascii?Q?Eu+dWCCJ3yuQLO3L/wfrZ86eWwPa1ZQkgtn5Sqe7lhvHklqU3dye9TjJ/0CC?=
 =?us-ascii?Q?oldxsE20iAlgXKgNTWJiyCsWua/bfLYGRw0yPsJANJDW+2ztapvMAA4/g7kj?=
 =?us-ascii?Q?l7q08PcR7wRS7z1uG3yI6d07r3JMbiv23WtUNdoTZrL7Ya8g3+ijyjxCHoca?=
 =?us-ascii?Q?BZV9I0nxjYqwcUgga1gUqis2fLLOPcIJFU7Qvho8ab1paMa4Ot/qEmbUietM?=
 =?us-ascii?Q?kKQaKzssZrhpOBF2D2BGYnV77KpmRQ9XVnvknkkl06xwPnEdoVsOHXalfq5w?=
 =?us-ascii?Q?BV8lKciGdVWEIhsWFucdt7JRIWKdAjDdBfHv2jOVL/kOb5924sIgTw2A1TXS?=
 =?us-ascii?Q?9l43Je9G6PGCBE5cUxa5xUfHMO4JCOlYO8qq9aQz+mrkUsH+NAhr3m4DW6sQ?=
 =?us-ascii?Q?aI49BXdMOBObTioK0Hb+Kokeift6czGyJCMtl2ZotsxW+YO1BTRMVYuY7Wz5?=
 =?us-ascii?Q?jPZfww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IgS3ncJQTmtn9ca7uV8XBsadmvOE6NaO27RHjMX3WQNGNx3ughbxolzieMfQxl0m/4Uk0hH1Pf/BYmy37Z+yC4MdUXRz2tmlEngOas7WL8h74j/jn+cZvajaG4/r3BCryEOyUx2nBLW3gRp053uGy3+shs369X8XmqIet+BgDl/fM51N2dDDhUNA58ZXJt62tluQyY79ggnvyQlyY0u/DBLe2JE78jdsfPpGIGDylng2fHN+eyTe+WHvcbLg/5lRSJYLEF4khXr/RsYOm/m9bcjUzF0yotuuOcDu6JJbdL2hHnhQXL5WyGBFl4GyW69oplzuWN/qrAX9D4nugEpjdyc6bRTeMQhWj7GrAxyKbUIvFUzZEfVFeF33mah4Kiodwm1Ah9l77tTc7N1hFrqOAzIvrYhI5Cg30F+ZZgpwWb4D1Pkh8miCwrBiX5FDUPT9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:06:07.7939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ad6b9a-3855-4b6c-6b7a-08de627d5b77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
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
	TAGGED_FROM(0.00)[bounces-255945-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,alibaba.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 22A1ECF654
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


