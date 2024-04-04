Return-Path: <netdev+bounces-84852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7872F8987FD
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B501F239C8
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF1486AE3;
	Thu,  4 Apr 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CiW5V4HF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2120.outbound.protection.outlook.com [40.107.93.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBAA1292C2
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234257; cv=fail; b=W3JzBiPrmvkSmbOKhtA9t/hg1pRFxhChOedsBIqW1eggMxRF1ykWUFfb8dTzl8i6MbizYudPjm7Zlxt4HNGwmFGeZZZUCdYF5stKFYZlZHML1i3FbDMjQ2lFgDqbZaDZ2FrV1kGlRwIxYQ3QoVu03SZpmcfHX0q27mm2TwGLgCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234257; c=relaxed/simple;
	bh=y5vvTaAv93lieCEY/NX+4TIx5xz9C6lYnUygwMrXSuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=awZoNH9fEZXpdkoDSkwVUfISZxTW/QBsyCGpUxnZ01qwn27VmcjOIG2W8p6XtK3tXBCgDrKbMtdboGzBF/84rH1qxb2tuBtWzlutzNMYLREpJKlTNDHkTZs+kyx15Beb3MultpO1MaHOBShFl94TpaRRk5YRXnTXIjGcbNlqbTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CiW5V4HF; arc=fail smtp.client-ip=40.107.93.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvTK7nD1uR8QDQW2hYWBKSWVcqYO3/bNiPM1Hogy1UWWpQng9o5CID3YnpTKimVt9Qp/+ZancnSjRVqYRpWIdP+K4BugPDYH33/wlAcc1nHU/uNcnZiLcFZnRFQGOi0rtKQam3yvohGD37kMPO7pVj8DL2CG4GaW8uQ0kzZroumq2hOD91bbQLyNBWdkJpDSLHPobDNn1s2+22Fqi1xp//5/ZXLIVIBEEUBapFvqkl8RGy9xaTU8JP5bCawBzUdrh0tkSqSgTmSQvTTG36K/y41Wg5nNTtc2nYGehNfSC90kMY5seZKR+2Ivrm+jMWduklNAUCZg1sRdHNDEiwRicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21nvtCuywOT6Z99L7mtw2CuV4oz8SMdVlmdkVfvN5VU=;
 b=h/QWX8sp2kO3wCrMPWCrxincPK41oYfXizHVRc0WH+d9oWo0JDs9f9Yo1PFh5ctecfcEQFYD4eINFDiQXvnYvRFxK7yvYvAzggOYhKo8UH1N1L55jRjwpvnzyq3JH1OrQYdeotbjB7/9zgFq7KURXjyy0BEKBJ79KRliPkcfGVOqWtWYD4UrcXlGCTxc+7RQz8s37itq5mnwHsdy0snGArxuJXtwO+o/M8EEYssgc081DFeKiS8icHyTaN1XP+ReVWy98LEfXAL67yQ/NccT5wlDwNesku14J6xB7gkuldAv6Alw5+YD374BERBUrdiyF+kj0QvWYImgt+acFA9iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21nvtCuywOT6Z99L7mtw2CuV4oz8SMdVlmdkVfvN5VU=;
 b=CiW5V4HF9141JViWXxIFJOsofp1iWAaU8qzyeWK4x7epwCEu9BNyZaYuaZz6ZFya8X/c/D791hn5oN3Z+94CoVrwNSwhZTervY4yfzttSfixaS6kNN43/5maT38PsNLite+s7+A1m25VE+ni8n1mHQt26qJwRzoE2k8rYRH5qbj+kaBQIKjKnebjLxqrED99CpPe4LSK92rf2a+kBn13XSnzjR3qHPCJpEGICDs7Lt0VOUci8jJsRQXLlxaFUKMOMrcbb0ndg6VuaRB+QhsbKPAbqfJW0RY1GQtktmrzE8G1TzIyd9mUN6cKDRwyXIOMcSi2hzH3/FQgj24tq43wjg==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:37:31 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:37:31 +0000
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
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	jacob.e.keller@intel.com
Subject: [PATCH v24 01/20] net: Introduce direct data placement tcp offload
Date: Thu,  4 Apr 2024 12:36:58 +0000
Message-Id: <20240404123717.11857-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA0PR12MB4384:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z3yvCuSRs8kh7mq8re0r27W78zt7xx33oujE3sSvtlDl5IgXOSE8k4ACLBx7+MIFIpqfN+W6m5gZb3NZ51bkb+u8DuK9lisQSjauNHqmCLSweCVyhDtSVfJLvXObOFVpDAVMzl8AcyOtDkQv93Zgs/rBwSyQx/fvjTgWnF/Qo3F3Rex857smG8uJT5XVZYJxmerILUTMWXJwbZ3mow4nx+V0M8L+Myw82PiNb2qIBQVnDaTJhVkcVfyUKcXoZa+RI/iRhv7w0uOw82neA0cgGzUi58YqkJtDWOJkpdqvdhunST1mU+yUthCMpklDqVa+P31EJxtckXeqBK5QwhBE7THclv1QOQiPKt1n5QFQM4bQgS9n5BxkNHb/fGaaohvwqFjt99m9tQFLBq2Uc9/i6jvZvlRoVUScPR0Nja7Z0uRJua28qIUOIQTwWdQIRUHURccnpXk9PTrhABWZUK220MGoGUBft02AnTbpHhUujKBjJYSr0cfKVGJSdDJ2GiutNNpcWZ8eS2UY0XVAufYDHSm7+wbjcHhIc9NbGcBmqGquW5mMyLoZfeWgGb/XVacAlWjkZlbuXpa4zOV2kuObHiPvjeWycFk4dyRh32zx1+s2eBgkuyg43Ju0wk0ug0aqc5vt4dDch5CekKpH1bTFPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0N3AuzufI/NiH69ydqO3D57yQasTfekrbBQMC463B1OBGx3Y0PgV0VodI1fH?=
 =?us-ascii?Q?bXNw822kRpF91TqwR/Wx8t9igMDGP2eHvenawb9Wifky9ygyONnpspeqDzv3?=
 =?us-ascii?Q?VfOLGb3K0w775UJi2+io+JbMK+puApiN973k66DaaRLzVVWLFuyt3ivOtp/d?=
 =?us-ascii?Q?wZX+jVJQ+yUIi/PHjRzKEUelo14R7PEf8WZDuMuiSCWW97TVuKxE07XPSsi+?=
 =?us-ascii?Q?QJ9bVw2RKn0eRkhbJ/CoRfu02VbiVbfBIBUAB8uYiySHG9FxJJstfxVW8s2f?=
 =?us-ascii?Q?GGe+7I6tMV0aiUv7KxjFTlhK0h1QozCBFbXwZ03qwEFYaO8hwv0T7meYUqUs?=
 =?us-ascii?Q?EwI8l/Je42snFynxeQgm9sw9W9yMKYlW2fE6P8dfXa5HX7KbwgOwPTq8klLz?=
 =?us-ascii?Q?rAqa/M2Uuts0PVXVaRHRTzSETzQKvZUCFOARH70Li6SsmrrUBbLfPlM35vgd?=
 =?us-ascii?Q?YQUPjtwZ3ALMQk/DqFnz2OvBZH3qv0OkVds+BZLqbNaijLUOj9EJHCSg4yMB?=
 =?us-ascii?Q?Wspsl46dW/ym1X3IvT1FPHs6WoTjVAMjfYWB0ivVZOuLx9GiaIazpUtJl0GM?=
 =?us-ascii?Q?0q/XbEio20OpoNBEFbtnZVkwUHqgY5iA0f3p3vMjAHvGwmvksyRRswCwR/yJ?=
 =?us-ascii?Q?oadV/UHN+Q35xyvxUt+ypEjJAs/EyKC98/LBZdu2kcI/SHHXTu4OnAk6dX+L?=
 =?us-ascii?Q?P2mMzf6As/XK4ZB4trzkPjxfmBuxM+wgTkyPbrSHSfkUJLxHIqRqSiT5KqMn?=
 =?us-ascii?Q?35ZPNSxy6ATuw7bTqTemLZUR32SOZiqe9IhzdvWkHNpykRw8zDiH0y81QwJe?=
 =?us-ascii?Q?uQ+V6berJo7IyrsRAKyCCKBfHLFElcP/+TZHibYSKbXciOI9VbucKUcTr4lj?=
 =?us-ascii?Q?jNPjIVhQX6fxI84UU7gZqEbYN/6TrwXj3aDPO4ujU7KncWqcFZlo1AroRQry?=
 =?us-ascii?Q?eKt9LLSA2bqr/2gyh8xrkngEL6aQ/BBrvNMmEuNEaqKM2sf6jZ+vslQcl/3k?=
 =?us-ascii?Q?Y1mt+SSrOv61jhd0QyA2Aj2yOIeZyqpMk+DS68x+LvlvnvXxtx/ErVXC9Cq/?=
 =?us-ascii?Q?6WdykvCkiYCVQUyTO0x/pVaNUevA1Mx9pG+P3GEhWEK72quTBreD0bXxLv25?=
 =?us-ascii?Q?vfx6W9x1PN4ptskFxNdEJWwz6viLrM3bC2YKB3nQcKJ/FpgE8ce/laAlYoeV?=
 =?us-ascii?Q?neuKQue+5KHUUOkd6P/vofBP4JCJAgNO/18YDPwRNlp4quofUGBvay63zwC2?=
 =?us-ascii?Q?tWluhcxtwAxvuVar+T8pYEZW1h7SbaXCcIH6uglGQfZ00fUyxoUti4NBvEOi?=
 =?us-ascii?Q?O9YhaU7gC1z4hcHXGqmcjzshnDkYXM1BYXY9cpLCAtzEqeUgsrVP6Xr9alYg?=
 =?us-ascii?Q?W7syCLgSvLhRTm90lRf8Io5GTVIHv1jReNvyvKLqg8Q0isI9B7x9rtQ8HnHn?=
 =?us-ascii?Q?BNUZ03gcsyZBHBuc1ekykEgDU++N8kdPLrXJDDGNQJasIb+B/6UP1OGY4Ex0?=
 =?us-ascii?Q?oPVRExp67cJKZaDfIHoFNcRpRLT166PQVU1DnLlm/i7UHC+CjcppLzko86yS?=
 =?us-ascii?Q?/D9H2wFV0cqsuFiRtyC0PAeLNpue8ibk8WbBoolE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b142ec73-2b25-4fc6-cede-08dc54a3fee6
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:37:31.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWzuh7aiBlr4Px8UXWBLsXc8I7ha9J7csWSh5RR61Y70Q5CZKmtFAcmdNwSkhw5OvvqI9hplHdYwVT1xe9udOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement (DDP) offload for TCP.

The motivation is saving compute resources/cycles that are spent
to copy data from SKBs to the block layer buffers and CRC
calculation/verification for received PDUs (Protocol Data Units).

The DDP capability is accompanied by new net_device operations that
configure hardware contexts.

There is a context per socket, and a context per DDP operation.
Additionally, a resynchronization routine is used to assist
hardware handle TCP OOO, and continue the offload. Furthermore,
we let the offloading driver advertise what is the max hw
sectors/segments.

The interface includes the following net-device ddp operations:

 1. sk_add - add offload for the queue represented by socket+config pair
 2. sk_del - remove the offload for the socket/queue
 3. ddp_setup - request copy offload for buffers associated with an IO
 4. ddp_teardown - release offload resources for that IO
 5. limits - query NIC driver for quirks and limitations (e.g.
             max number of scatter gather entries per IO)
 6. set_caps - request ULP DDP capabilities enablement
 7. get_caps - request current ULP DDP capabilities
 8. get_stats - query NIC driver for ULP DDP stats

Using this interface, the NIC hardware will scatter TCP payload
directly to the BIO pages according to the command_id.

To maintain the correctness of the network stack, the driver is
expected to construct SKBs that point to the BIO pages.

The SKB passed to the network stack from the driver represents
data as it is on the wire, while it is pointing directly to data
in destination buffers.

As a result, data from page frags should not be copied out to
the linear part. To avoid needless copies, such as when using
skb_condense, we mark the skb->no_condense bit.
In addition, the skb->ulp_crc will be used by the upper layers to
determine if CRC re-calculation is required. The two separated skb
indications are needed to avoid false positives GRO flushing events.

Follow-up patches will use this interface for DDP in NVMe-TCP.

Capability bits stored in net_device allow drivers to report which
ULP DDP capabilities a device supports. Control over these
capabilities will be exposed to userspace in later patches.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h          |   5 +
 include/linux/skbuff.h             |  25 ++-
 include/net/inet_connection_sock.h |   6 +
 include/net/ulp_ddp.h              | 320 +++++++++++++++++++++++++++++
 net/Kconfig                        |  20 ++
 net/core/Makefile                  |   1 +
 net/core/skbuff.c                  |   3 +-
 net/core/ulp_ddp.c                 |  52 +++++
 net/ipv4/tcp_input.c               |  13 +-
 net/ipv4/tcp_ipv4.c                |   3 +
 net/ipv4/tcp_offload.c             |   3 +
 11 files changed, 448 insertions(+), 3 deletions(-)
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0c198620ac93..2fc33d9470e5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1351,6 +1351,8 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ * struct ulp_ddp_dev_ops *ulp_ddp_ops;
+ *	ULP DDP operations (see include/net/ulp_ddp.h)
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1596,6 +1598,9 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
+#if IS_ENABLED(CONFIG_ULP_DDP)
+	const struct ulp_ddp_dev_ops	*ulp_ddp_ops;
+#endif
 };
 
 /**
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 03ea36a82cdd..36e6ebf5e694 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -823,6 +823,8 @@ typedef unsigned char *sk_buff_data_t;
  *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
  *		skb->tstamp has the (rcv) timestamp at ingress and
  *		delivery_time at egress.
+ *	@no_condense: When set, don't condense fragments (DDP offloaded)
+ *	@ulp_crc: CRC offloaded
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -999,7 +1001,10 @@ struct sk_buff {
 #if IS_ENABLED(CONFIG_IP_SCTP)
 	__u8			csum_not_inet:1;
 #endif
-
+#ifdef CONFIG_ULP_DDP
+	__u8                    no_condense:1;
+	__u8			ulp_crc:1;
+#endif
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -5148,5 +5153,23 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize, gfp_t gfp);
 
+static inline bool skb_is_no_condense(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->no_condense;
+#else
+	return 0;
+#endif
+}
+
+static inline bool skb_is_ulp_crc(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->ulp_crc;
+#else
+	return 0;
+#endif
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 20e7b0c0b3d1..c68e3c4bf74c 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -67,6 +67,8 @@ struct inet_connection_sock_af_ops {
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
  * @icsk_clean_acked	   Clean acked data hook
+ * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
+ * @icsk_ulp_ddp_data	   ULP direct data placement private data
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -97,6 +99,10 @@ struct inet_connection_sock {
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
 	void __rcu		  *icsk_ulp_data;
 	void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
+#ifdef CONFIG_ULP_DDP
+	const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
+	void __rcu		  *icsk_ulp_ddp_data;
+#endif
 	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
 	__u8			  icsk_ca_state:5,
 				  icsk_ca_initialized:1,
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
new file mode 100644
index 000000000000..dc5405f37bba
--- /dev/null
+++ b/include/net/ulp_ddp.h
@@ -0,0 +1,320 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ulp_ddp.h
+ *   Author:	Boris Pismenny <borisp@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#ifndef _ULP_DDP_H
+#define _ULP_DDP_H
+
+#include <linux/netdevice.h>
+#include <net/inet_connection_sock.h>
+#include <net/sock.h>
+
+enum ulp_ddp_type {
+	ULP_DDP_NVME = 1,
+};
+
+/**
+ * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+ *
+ * @full_ccid_range:	true if the driver supports the full CID range
+ */
+struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+};
+
+/**
+ * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+ * protocol limits.
+ * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+ *
+ * @type:		type of this limits struct
+ * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+ * @io_threshold:	minimum payload size required to offload
+ * @tls:		support for ULP over TLS
+ * @nvmeotcp:		NVMe-TCP specific limits
+ */
+struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+};
+
+/**
+ * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+ *
+ * @pfv:	pdu version (e.g., NVME_TCP_PFV_1_0)
+ * @cpda:	controller pdu data alignment (dwords, 0's based)
+ * @dgst:	digest types enabled (header or data, see
+ *		enum nvme_tcp_digest_option).
+ *		The netdev will offload crc if it is supported.
+ * @queue_size: number of nvme-tcp IO queue elements
+ */
+struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+};
+
+/**
+ * struct ulp_ddp_config - Generic ulp ddp configuration
+ * Add new instances of ulp_ddp_config in the union below (nvme-tcp, etc.).
+ *
+ * @type:	type of this config struct
+ * @nvmeotcp:	NVMe-TCP specific config
+ * @io_cpu:	cpu core running the IO thread for this socket
+ */
+struct ulp_ddp_config {
+	enum ulp_ddp_type    type;
+	int		     io_cpu;
+	union {
+		struct nvme_tcp_ddp_config nvmeotcp;
+	};
+};
+
+/**
+ * struct ulp_ddp_io - ulp ddp configuration for an IO request.
+ *
+ * @command_id: identifier on the wire associated with these buffers
+ * @nents:	number of entries in the sg_table
+ * @sg_table:	describing the buffers for this IO request
+ * @first_sgl:	first SGL in sg_table
+ */
+struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+};
+
+/**
+ * struct ulp_ddp_stats - ULP DDP offload statistics
+ * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
+ * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared
+ *                           for offloading.
+ * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
+ * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for
+ *                         Direct Data Placement.
+ * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
+ * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
+ * @rx_nvmeotcp_drop: number of PDUs dropped.
+ * @rx_nvmeotcp_resync: number of resync.
+ * @rx_nvmeotcp_packets: number of offloaded PDUs.
+ * @rx_nvmeotcp_bytes: number of offloaded bytes.
+ */
+struct ulp_ddp_stats {
+	u64 rx_nvmeotcp_sk_add;
+	u64 rx_nvmeotcp_sk_add_fail;
+	u64 rx_nvmeotcp_sk_del;
+	u64 rx_nvmeotcp_ddp_setup;
+	u64 rx_nvmeotcp_ddp_setup_fail;
+	u64 rx_nvmeotcp_ddp_teardown;
+	u64 rx_nvmeotcp_drop;
+	u64 rx_nvmeotcp_resync;
+	u64 rx_nvmeotcp_packets;
+	u64 rx_nvmeotcp_bytes;
+
+	/*
+	 * add new stats at the end and keep in sync with
+	 * Documentation/netlink/specs/ulp_ddp.yaml
+	 */
+};
+
+#define ULP_DDP_CAP_COUNT 1
+
+struct ulp_ddp_dev_caps {
+	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
+	DECLARE_BITMAP(hw, ULP_DDP_CAP_COUNT);
+};
+
+struct netlink_ext_ack;
+
+/**
+ * struct ulp_ddp_dev_ops - operations used by an upper layer protocol
+ *                          to configure ddp offload
+ *
+ * @limits:    query ulp driver limitations and quirks.
+ * @sk_add:    add offload for the queue represented by socket+config
+ *             pair. this function is used to configure either copy, crc
+ *             or both offloads.
+ * @sk_del:    remove offload from the socket, and release any device
+ *             related resources.
+ * @setup:     request copy offload for buffers associated with a
+ *             command_id in ulp_ddp_io.
+ * @teardown:  release offload resources association between buffers
+ *             and command_id in ulp_ddp_io.
+ * @resync:    respond to the driver's resync_request. Called only if
+ *             resync is successful.
+ * @set_caps:  set device ULP DDP capabilities.
+ *	       returns a negative error code or zero.
+ * @get_caps:  get device ULP DDP capabilities.
+ * @get_stats: query ULP DDP statistics.
+ */
+struct ulp_ddp_dev_ops {
+	int (*limits)(struct net_device *netdev,
+		      struct ulp_ddp_limits *limits);
+	int (*sk_add)(struct net_device *netdev,
+		      struct sock *sk,
+		      struct ulp_ddp_config *config);
+	void (*sk_del)(struct net_device *netdev,
+		       struct sock *sk);
+	int (*setup)(struct net_device *netdev,
+		     struct sock *sk,
+		     struct ulp_ddp_io *io);
+	void (*teardown)(struct net_device *netdev,
+			 struct sock *sk,
+			 struct ulp_ddp_io *io,
+			 void *ddp_ctx);
+	void (*resync)(struct net_device *netdev,
+		       struct sock *sk, u32 seq);
+	int (*set_caps)(struct net_device *dev, unsigned long *bits,
+			struct netlink_ext_ack *extack);
+	void (*get_caps)(struct net_device *dev,
+			 struct ulp_ddp_dev_caps *caps);
+	int (*get_stats)(struct net_device *dev,
+			 struct ulp_ddp_stats *stats);
+};
+
+#define ULP_DDP_RESYNC_PENDING BIT(0)
+
+/**
+ * struct ulp_ddp_ulp_ops - Interface to register upper layer
+ *                          Direct Data Placement (DDP) TCP offload.
+ * @resync_request:         NIC requests ulp to indicate if @seq is the start
+ *                          of a message.
+ * @ddp_teardown_done:      NIC driver informs the ulp that teardown is done,
+ *                          used for async completions.
+ */
+struct ulp_ddp_ulp_ops {
+	bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+	void (*ddp_teardown_done)(void *ddp_ctx);
+};
+
+/**
+ * struct ulp_ddp_ctx - Generic ulp ddp context
+ *
+ * @type:	type of this context struct
+ * @buf:	protocol-specific context struct
+ */
+struct ulp_ddp_ctx {
+	enum ulp_ddp_type	type;
+	unsigned char		buf[];
+};
+
+static inline struct ulp_ddp_ctx *ulp_ddp_get_ctx(struct sock *sk)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return (__force struct ulp_ddp_ctx *)icsk->icsk_ulp_ddp_data;
+#else
+	return NULL;
+#endif
+}
+
+static inline void ulp_ddp_set_ctx(struct sock *sk, void *ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	rcu_assign_pointer(icsk->icsk_ulp_ddp_data, ctx);
+#endif
+}
+
+static inline int ulp_ddp_setup(struct net_device *netdev,
+				struct sock *sk,
+				struct ulp_ddp_io *io)
+{
+#ifdef CONFIG_ULP_DDP
+	return netdev->netdev_ops->ulp_ddp_ops->setup(netdev, sk, io);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline void ulp_ddp_teardown(struct net_device *netdev,
+				    struct sock *sk,
+				    struct ulp_ddp_io *io,
+				    void *ddp_ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->teardown(netdev, sk, io, ddp_ctx);
+#endif
+}
+
+static inline void ulp_ddp_resync(struct net_device *netdev,
+				  struct sock *sk,
+				  u32 seq)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->resync(netdev, sk, seq);
+#endif
+}
+
+static inline int ulp_ddp_get_limits(struct net_device *netdev,
+				     struct ulp_ddp_limits *limits,
+				     enum ulp_ddp_type type)
+{
+#ifdef CONFIG_ULP_DDP
+	limits->type = type;
+	return netdev->netdev_ops->ulp_ddp_ops->limits(netdev, limits);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline bool ulp_ddp_cap_turned_on(unsigned long *old,
+					 unsigned long *new,
+					 int bit_nr)
+{
+	return !test_bit(bit_nr, old) && test_bit(bit_nr, new);
+}
+
+static inline bool ulp_ddp_cap_turned_off(unsigned long *old,
+					  unsigned long *new,
+					  int bit_nr)
+{
+	return test_bit(bit_nr, old) && !test_bit(bit_nr, new);
+}
+
+#ifdef CONFIG_ULP_DDP
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    struct sock *sk);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr);
+
+#else
+
+static inline int ulp_ddp_sk_add(struct net_device *netdev,
+				 struct sock *sk,
+				 struct ulp_ddp_config *config,
+				 const struct ulp_ddp_ulp_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void ulp_ddp_sk_del(struct net_device *netdev,
+				  struct sock *sk)
+{}
+
+static inline bool ulp_ddp_is_cap_active(struct net_device *netdev,
+					 int cap_bit_nr)
+{
+	return false;
+}
+
+#endif
+
+#endif	/* _ULP_DDP_H */
diff --git a/net/Kconfig b/net/Kconfig
index 3e57ccf0da27..fb1a854523c1 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -516,4 +516,24 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config ULP_DDP
+	bool "ULP direct data placement offload"
+	help
+	  This feature provides a generic infrastructure for Direct
+	  Data Placement (DDP) offload for Upper Layer Protocols (ULP,
+	  such as NVMe-TCP).
+
+	  If the ULP and NIC driver supports it, the ULP code can
+	  request the NIC to place ULP response data directly
+	  into application memory, avoiding a costly copy.
+
+	  This infrastructure also allows for offloading the ULP data
+	  integrity checks (e.g. data digest) that would otherwise
+	  require another costly pass on the data we managed to avoid
+	  copying.
+
+	  For more information, see
+	  <file:Documentation/networking/ulp-ddp-offload.rst>.
+
+
 endif   # if NET
diff --git a/net/core/Makefile b/net/core/Makefile
index 21d6fbc7e884..b7ea11bd9c0b 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
 obj-y += hotdata.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2a5ce6667bbb..8ab25e344d43 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -77,6 +77,7 @@
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
+#include <net/ulp_ddp.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -6752,7 +6753,7 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb))
+		    skb_cloned(skb) || skb_is_no_condense(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/core/ulp_ddp.c b/net/core/ulp_ddp.c
new file mode 100644
index 000000000000..658e67620c0f
--- /dev/null
+++ b/net/core/ulp_ddp.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * ulp_ddp.c
+ *   Author:	Aurelien Aptel <aaptel@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+
+#include <net/ulp_ddp.h>
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops)
+{
+	int ret;
+
+	/* put in ulp_ddp_sk_del() */
+	dev_hold(netdev);
+
+	config->io_cpu = sk->sk_incoming_cpu;
+	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
+	if (ret) {
+		dev_put(netdev);
+		return ret;
+	}
+
+	inet_csk(sk)->icsk_ulp_ddp_ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_add);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    struct sock *sk)
+{
+	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, sk);
+	inet_csk(sk)->icsk_ulp_ddp_ops = NULL;
+	dev_put(netdev);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_del);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
+{
+	struct ulp_ddp_dev_caps caps;
+
+	if (!netdev->netdev_ops->ulp_ddp_ops->get_caps)
+		return false;
+	netdev->netdev_ops->ulp_ddp_ops->get_caps(netdev, &caps);
+	return test_bit(cap_bit_nr, caps.active);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_is_cap_active);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1b6cd3840012..52563f4f35a7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4807,7 +4807,10 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (from->decrypted != to->decrypted)
 		return false;
 #endif
-
+#ifdef CONFIG_ULP_DDP
+	if (skb_is_ulp_crc(from) != skb_is_ulp_crc(to))
+		return false;
+#endif
 	if (!skb_try_coalesce(to, from, fragstolen, &delta))
 		return false;
 
@@ -5377,6 +5380,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 #ifdef CONFIG_TLS_DEVICE
 		nskb->decrypted = skb->decrypted;
+#endif
+#ifdef CONFIG_ULP_DDP
+		nskb->no_condense = skb->no_condense;
+		nskb->ulp_crc = skb->ulp_crc;
 #endif
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
@@ -5410,6 +5417,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 #ifdef CONFIG_TLS_DEVICE
 				if (skb->decrypted != nskb->decrypted)
 					goto end;
+#endif
+#ifdef CONFIG_ULP_DDP
+				if (skb_is_ulp_crc(skb) != skb_is_ulp_crc(nskb))
+					goto end;
 #endif
 			}
 		}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1e0a9762f92e..3dc7607660b4 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2049,6 +2049,9 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	    tail->decrypted != skb->decrypted ||
 #endif
 	    !mptcp_skb_can_collapse(tail, skb) ||
+#ifdef CONFIG_ULP_DDP
+	    skb_is_ulp_crc(tail) != skb_is_ulp_crc(skb) ||
+#endif
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index ebe4722bb020..a7a607d4812f 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -268,6 +268,9 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 #ifdef CONFIG_TLS_DEVICE
 	flush |= p->decrypted ^ skb->decrypted;
 #endif
+#ifdef CONFIG_ULP_DDP
+	flush |= skb_is_ulp_crc(p) ^ skb_is_ulp_crc(skb);
+#endif
 
 	if (flush || skb_gro_receive(p, skb)) {
 		mss = 1;
-- 
2.34.1


