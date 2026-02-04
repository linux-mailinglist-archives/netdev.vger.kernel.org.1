Return-Path: <netdev+bounces-256849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FxJKjvLg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:42:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FFAED09C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04113030B0D
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508BD38B99B;
	Wed,  4 Feb 2026 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QN/pfaSs"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED838B9BC
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244823; cv=fail; b=ccOgeDQKLXM60XN2NKIGeQ9KGLAizww5BtepvsJgLOcvPHsk90Y0FIAfahssqQ5nTq1ch8HmInpKE6HAR+IY6SFeLdpIksFHchJZgMV8smCQOIesd63ylVTEHqR887Vmf85g2spywGnr7PNWyO2MxNr1C4/wvDYmEdIt418a5xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244823; c=relaxed/simple;
	bh=RTvFWnCG+6VBz7xiyguZFf0GYXUETnFWA13ivLuiY00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyvyaP08hOeLl8vUUF1qN8pfG92v19ToF8brDe4/MgX+sBBzVNM9iFpkPbOuy499OTrzr56QAtOgZI3HIZyygBX+Kj30tr9eEBpaD8K6GLJ9w6IU4owyOJXdnsOrdSZVDbNkanMdgJx4NR8Z4PBj4Y9xEnEE//nFHBg3JKJXEeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QN/pfaSs; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZQ7EJloxxJqNk4l5w3YPQVE9iYMZuuUUcqolZY78HSGTh1oy06T4tohsIA6SeKlKhb150hEHDkg4LXVA6FI7/tb+jKL/gGGzBSjbFPdLlWlIy+Uv0vUnvZK7De1ojqQkEUAPs7nzdoF542A/hz8aHfpAS9JsYIKYhWO9M1s0zxvMMA1yyM1PUdpHbYmYykGd4x5ym6aPBeUAGrMHgzVJ5l/3Bfm0ywUVw2a0mhKfHPoi7KstnliV6t/7AVbwF8qPd0p7LEyaq183Gc4wKammf54LTHAN7e80etyjvxU5iGVG+ZwXoXxFaLga1Y1TdhKzG+vUCUDWq0gELDsee0Wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eg0QK4WADhUlzrFXROjCGSvksEwJRCHTmthqU3H/DD4=;
 b=USJnPxXB/lD1+0IQmq+etmisZeprVailC0NqryxUIz4LF4Maegt8jcn2c++j/CDYIJ+nV244xgn4u6d4fpzKIHerYp1Gfwq3TbfyJm2jaHP1tmTkZE6HIvcB4XnIiaESp5Vq0ebAx0KC0lS9aNWeoJlbFWtn4h3V1vAS9cUq5DkRTkvrKp/BZV5MDtI/C6TtSZTqpUDwClz3ZcVJI1g3OBB1/glnjN83dJB0H2fma8xKp9XQupw3l0ZKGx6n3BcfJYwI4XtHqvINNN6rG1ZKzXpaD8VY3nZSgkJ/1uXCxsCQ60svx7ExFrolTd/uN6TxwUIP3b9UcNBoRKUzcj1eQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg0QK4WADhUlzrFXROjCGSvksEwJRCHTmthqU3H/DD4=;
 b=QN/pfaSsxOjr1KCzkLpenKdrdU3uueaCjJ+1Nf+7togjtvybnNcpORHZK2DilWpmIMgS2mZVt93hqSeXfIR60j/MeqA++M3Jb3g6S2qz9m449jj4o4FjQ9RU7WxynNi3eMzILwCkWWWSS0zU3wS8ZlN72SchjymXpMoaRdiGVhVQpAHSYyE874S3W+FUvUG5OdUTRaImigc+2JrctY11XgRALZimnVPf5KCU2IDCqUBiLTpGx0hNcusKsx8h8dUZqDBBsCuVnI4EwWleqPan//rYbFjvaYn1mLfZCbTrAHLC7gvcfCw4iohVAYTxRE+iqR0X0i6bD6J+EB5tr/fa/w==
Received: from MN0P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::7)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 22:40:12 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::14) by MN0P223CA0009.outlook.office365.com
 (2603:10b6:208:52b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Wed,
 4 Feb 2026 22:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 22:40:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 14:39:55 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 14:39:55 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 14:39:53 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v19 06/12] virtio_net: Create a FF group for ethtool steering
Date: Wed, 4 Feb 2026 16:39:34 -0600
Message-ID: <20260204223940.39581-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2736d2-d98c-42ee-4153-08de643e5bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zs/Y/1rLp7xBMMjwAl7TKNBq5Eh9rB2/UFzg9MfQIla0DhH04v1NUHe8MiDY?=
 =?us-ascii?Q?nots0VgDmBkIRhXBEg096+BO33mpSWEgzoHeRVZu2NVxm5dhZJz3o7oSi4Gr?=
 =?us-ascii?Q?tTAS6NVooAgfTfWI1QC8VLm6uMX20ZsUXywuHFIdJQ9t9VQ0ZmYmYQF4aUgR?=
 =?us-ascii?Q?CrLvdiEYJAA7cmuJWVPpO2h1qKY6u/oVxU8Q1yZkuIwwrhUa/AcdWfu+OmG+?=
 =?us-ascii?Q?+/gM2ektb55hbmOgLTDE4c3az4CHo5eEq8/tqIuS3YfS3mnaYwREQ3433pid?=
 =?us-ascii?Q?+w8YnHuryvboi3wdxOyC5RDSE3E16GVtgIB17tvssfQ0ssuBjb5Se5qplstV?=
 =?us-ascii?Q?GXJm/V38rDYBhN3DrE0Df/BIyecsvRZB8xBHKyjIpjEgNICktVPy0qDgxEBf?=
 =?us-ascii?Q?azVXaLlA5HW7FQz0ojd0RE8ZiV0DcSCHvOFrGxDMOh99VbwDGeeK+MMtjSml?=
 =?us-ascii?Q?5E6miWCh+XY74/AHy5TwSo5RspA/d3yQRfgraTWcgsjFZmxUX+cjE0ON+zFO?=
 =?us-ascii?Q?XydThAkY4+TxFp5uwDvBzFQD/9b5LRA45zrSJdmlxp7sCH+pML+thw30oAQz?=
 =?us-ascii?Q?QH70BObXzYwIUifR+w+Xxah2m3YqkjJl9wV7Fj3VS+9TOKoNvaqgGza4aYpQ?=
 =?us-ascii?Q?je5qxplOXpUlpcDPJsGRFGAJaCHQ0zp9EBJgimBn6Ot3qtaAC6cULuFuSKzY?=
 =?us-ascii?Q?oF5v9DcUt9vmFff/ooXijqIUDKufWbIjqRSp/e+rcPWz7QdlX3BEsvChwrRg?=
 =?us-ascii?Q?KRh4a7VYgunrSw5S0qx190LgQD2/4mxysCMFP2vGk5Q3kYkPHCMXk5+RPZHk?=
 =?us-ascii?Q?d7vFch4Y1SL34fgLIeCQdjXTfrc4q1FzFI9NEo8KgmRXhtTMjXtgPwTboHEQ?=
 =?us-ascii?Q?dOAh9bQUOlbnJUclk8D5RmevYMk6QhpsYRh5yvDyjV2ktJAT007RUYtkZIc6?=
 =?us-ascii?Q?4dGElOlPaqAp0iIIcuSM+ws1NWZ8dJRWDZowskGSu+ny0HzQS7PycH0DZWhU?=
 =?us-ascii?Q?Tfld8gXYvwDEfbQTl2YRme6sSPyaIPIPt6x2lK2ZACP6w3TULz2DgdiwFrVd?=
 =?us-ascii?Q?6ecgacEPbmkbL3yi17FotRU280Qv/SKDaINYqGMXnVIptVHriA1rCDcNjcvz?=
 =?us-ascii?Q?6+DX4mbuOBOjqbCAmB+euYe75OV8vRmdljkJME3ETC3yJ3PDwNkua4a1rK80?=
 =?us-ascii?Q?Ag4zZ+GMV3D6px6wzRBfWKB73JiAAklUtLRydMs8B1Pz0TgrBxuc0lOQIOvW?=
 =?us-ascii?Q?n+apvlYO4EfEiI8MD7E+8b1NLcy6nWff30XS4tbw/hhitBJVBEvDv2oF4S2z?=
 =?us-ascii?Q?EipYSVxNvyj9AYmyI9WxtW6X1TIUqwp1xFdzDDasyH1U1lbw7ZrXta4NmOta?=
 =?us-ascii?Q?8hm7/GvSGAdNdwZeAMhqCOlwXxv+YXXK5VWTTqYLnVEfEaHYIUNYtOpfNQeG?=
 =?us-ascii?Q?i61/yTd1fTHs+qH2G1eR1Ey4hp9ztBsRKXbZvc8oCiG0ps232yaIPMT0bqAL?=
 =?us-ascii?Q?Pi7e3xM571CAI7UO6dHrqn+yfvAKYRSdD0ggsfuRpk4hsC+JPMaSU6ckImOt?=
 =?us-ascii?Q?fNdynyZ8kZbHmmYzlgOjarXo8x49BcnIWz54sXXDmjy3DeXTU1fhww5mmUdc?=
 =?us-ascii?Q?a1riFHnWYonwL0vtgmdBRHZWGSkSfSGShw98F3HftA/WSvwGCmHcY4EWraJc?=
 =?us-ascii?Q?bGOUQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ygirokZFcSh0VrxJFGv0y48WbxAcFm9CkJlItWnmNqH5O8b6Z/OuN6+lrMA4kCh/ggNAUSEYuwpN/GrxdC0QUXyQwChKGCLJl5GI2teGSl+DJBVKb+IoUrNeqS/q0tpHdzAqYYmVNsc7i3N3KpN0jSjFv8lMA87rLNC2LFEJKBMtxMvUJmhwQRTa6va+27JiYfdqw14MrHTG5a+cBTcYBtJwSfL1ryJYeUi0Gda0Lq6ZW6S1YH8SC4jxIFANPcXCkgv5L23itC2zPkcbLmkx6umM+CNRu3/PxiwxleToRlN6dUc3E1i/yh42+4fgu53t8f/lno9F2s14ZXZ9hnmrg/JtqNXR51fN1t8CSlXCSp0n44l/2G8kW20D6VNG1dach4PvCSyn2+jXaZXBQUreGSI9lK6F57lkF1W7rkrXqKc4Wm+TWC3YMHFBOFCtWbPb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:40:12.1507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2736d2-d98c-42ee-4153-08de643e5bc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348
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
	TAGGED_FROM(0.00)[bounces-256849-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,alibaba.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 53FFAED09C
X-Rspamd-Action: no action

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Documented UAPI
---
---
 drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2cfa37e2f83f..340104b22a59 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -286,6 +286,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
+#define VIRTNET_FF_MAX_GROUPS 1
+
 struct virtnet_ff {
 	struct virtio_device *vdev;
 	bool ff_supported;
@@ -5722,6 +5725,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	unsigned long sel_types = 0;
@@ -5806,6 +5810,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
+		err = -ENOSPC;
+		goto err_ff_action;
+	}
+	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
+
 	err = virtio_admin_cap_set(vdev,
 				   VIRTIO_NET_FF_RESOURCE_CAP,
 				   ff->ff_caps,
@@ -5852,6 +5862,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+
+	/* Use priority for the object ID. */
+	err = virtio_admin_obj_create(vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      &ethtool_group,
+				      sizeof(ethtool_group));
+	if (err)
+		goto err_ff_action;
+
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -5879,6 +5902,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
 	if (!ff->ff_supported)
 		return;
 
+	virtio_admin_obj_destroy(ff->vdev,
+				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				 0);
+
 	kfree(ff->ff_actions);
 	kfree(ff->ff_mask);
 	kfree(ff->ff_caps);
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index c967af950b72..92fbfecd9317 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -11,6 +11,8 @@
 #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
+#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
  * @groups_limit: maximum number of flow filter groups supported by the device
@@ -87,4 +89,17 @@ struct virtio_net_ff_actions {
 	__u8 reserved[7];
 	__u8 actions[] __counted_by(count);
 };
+
+/**
+ * struct virtio_net_resource_obj_ff_group - Flow filter group object
+ * @group_priority: priority of the group used to order evaluation
+ *
+ * This structure is the payload for the VIRTIO_NET_RESOURCE_OBJ_FF_GROUP
+ * administrative object. Devices use @group_priority to order flow filter
+ * groups. Multi-byte fields are little-endian.
+ */
+struct virtio_net_resource_obj_ff_group {
+	__le16 group_priority;
+};
+
 #endif
-- 
2.50.1


