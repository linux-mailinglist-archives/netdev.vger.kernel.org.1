Return-Path: <netdev+bounces-95955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6548C3E8F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA9E1C217B5
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC41494A7;
	Mon, 13 May 2024 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XMT3Pls5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981D146D5D
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594661; cv=fail; b=oucgdNemUAmRZhfwBd7Sw70db5rGd8t3zJYBR/hT/SHPbAxk5b3HIWwroHmVO8XoI+rXnB3WpEO4nfBOyvHzU6Zn56rJpM1j32CNwkRKsq4Ad3U+J0Cd4e361xnNGh5OfUrwXw9lvRY/dMNNVKB7rc/VEFVkEvAdVJV+gHRrUD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594661; c=relaxed/simple;
	bh=78xIHZoabkRsmmY7QnDkhR8TTR4rqWCoSihn0ycssAg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bVoHPV1vjdrdkOw8Nv1kd0Xxk7KcoUIjY6agB8fnxD8jhtbgzqvm/VWhWdbY+nqnP0K/D94IpHe8aJibiTXEOwBOQYmbsr4FzdlzQ/O1ZWTcwLw4G3gcHohILAy/gG6UfBFOSmtgiTksFzxj2sco2FUClIsPATq5DwEraO2dvGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XMT3Pls5; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI6n7sq5VXp9oq1JiMCnZQBSG3SiNvffc4kmfPmET3xh3i7dx9nmmTdd4/Q82DkT+qbjvJiptE4tGkHqLIByvmn2AucvRGlRDHq8UfTSHpdOmo1KWuu9rOf1+5JhT8lPHCbfEIqSJoaOuAOCEZS1nXnYEkiqAdXJYIg4qY651WDAFrqNbmtdsiZLTYhZ4h1OfEilPwJE3TpUOqJSmIZ1a+ZXUaZZoTCugEwldYnRVwDcs14WfzHfwM7L62XZ8tGaA8axmqkKVnJlRIgO0z7TOF85dxefCyqK0NHCVtvf9VtfvCXb0xct3pwRXHib+ayHKUz9yYbs32JJECt6lBLJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CBqBgDYTZ+Y9S9HSMVBlbtG80jii4aG3CDyUM4eeaY=;
 b=Ib6sn3GYCCLte3u7gHRX7lgWHUTb8x8H0N3Mfm0asSJZ5HsPaVdDBcr2P03uufHrAOH8iH4NmCFmkbR45joxoS+r1Pk5I9ebTyuITJPuqsTJxFJm9iFhjG6MSXQl1ruC22JZ4RAF/C4Gnvm559RabHbeET2Vh6yt1uZbQQjSPeHpW+VlWZY43+ofGriN272Q/Mjb/QP6w8Q7PWBvUa+UquZbZdHRpLT9ASehh0jZv0zT3h/9rp/k7nHQzNCEAS+bDu6XSdfesiyniU4CfxtCcw3th1utUKo/tnmzJB2oQA37Ub6iI6oi9/qSNCqERIee+l+ET0Z+Y2MLaxyuOw+IUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CBqBgDYTZ+Y9S9HSMVBlbtG80jii4aG3CDyUM4eeaY=;
 b=XMT3Pls5G1suv7pOHv8bbJ1j8bvIx/w9mgg/OTTpmiQm4zZZ3rl644+CVEJx+gwKKvQCk+K3bSM0MLPRWMksjcRNGoLJ/M+cvw9o4QYWOCHrN/WCC0TaJaAn8AO1mmn+FwVBFrSXVZBjny9SB7e9A+Et2uGkKLJ1o76Wbvkdu1MWHvWv8YleVuLl2hWXUq7CTVL7+zy6QxrNETtdru9loZhDJYYR1dYC36ofzkh7/xiivQIStqpwyywrOCq3UAh7V4f+DnksUWSWmdSCx+gd87TNUp6JtvEoNFf4KhF47FkEF2ysjt4fScnd7AmdmbZRz2IxKr77OvROAtbarYcReQ==
Received: from PH8PR02CA0002.namprd02.prod.outlook.com (2603:10b6:510:2d0::11)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 10:04:16 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::ad) by PH8PR02CA0002.outlook.office365.com
 (2603:10b6:510:2d0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 10:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 10:04:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 May
 2024 03:03:53 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 May
 2024 03:03:53 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 13 May 2024 03:03:51 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <edumazet@google.com>
CC: Jianbo Liu <jianbol@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net] net: drop secpath extension before skb deferral free
Date: Mon, 13 May 2024 13:02:46 +0300
Message-ID: <20240513100246.85173-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: 0800a8d8-3074-4783-e428-08dc73340c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cbNuvRt67sHeqpSoMSb/uSk+q/YN2uNtCq+B1vygngY/7zCL++VCMIDRikiT?=
 =?us-ascii?Q?jTAv37ZDt5Kc5ZvdEdtRQAq7TDiSgMBBuqpVOqaf3qGXZw30WkeP9IxbGmfH?=
 =?us-ascii?Q?SotvJ4XfdglO36Ja8IP9Mzz1OQImMfZoDItbrh97ZMPNXYuGInxqa47W22ew?=
 =?us-ascii?Q?883SAbDqaF+RaeF0chqlEWymfjRE83PDakxixvhF/5UdQ1pi354mrpmSHHSo?=
 =?us-ascii?Q?EWsxQev79HySwN4mZXl/ZOzWQ9Ou+owMediXprBVSa2dH+FNTp3lJvjeYUIr?=
 =?us-ascii?Q?iEfHAk9Nfl+65i7sMKH3gTBL5UoS9Dmq9WhjvxibTKDWzws3rtNAMRBDEkcj?=
 =?us-ascii?Q?0X/GLZ+wMB8J5vplSSZ49/g2VWf1wq92pgObvqXKoiLYgcwy27Gl/QSFt+EK?=
 =?us-ascii?Q?zLam4BzVkxtP2QuFl3d6szErZoBLGKrvhIWxG7DuGorJHDzLObMJaJul25La?=
 =?us-ascii?Q?iK/CipBG57lmQA3SZfNMlM/rHK3BG66tZ0deP84xjNvuXkPb/GnqzqY5JVe1?=
 =?us-ascii?Q?Pm3Gmd3hsYVX34wR0+VFDGhCT4ShG4rvjylTj1mQgJ3pfESJEOC3hJta8p+Z?=
 =?us-ascii?Q?DaASBmMpg+2zAPL/OYupdby2+m5yQGwzKYPOBWbiboXa5QqiqI9LotmRy3Bi?=
 =?us-ascii?Q?WpRGwVyHalXt4ZcyOlJCgvk8PiHH5nsbUuftW/htThZQb4ntNZ8UBPDCyvsY?=
 =?us-ascii?Q?LLrHMFkAHsL5e/VOcgWx+AIDoTa5ruO6bspcJnJA1JRbqy8BydzRafKhmI6Y?=
 =?us-ascii?Q?KIb42ZKWDRe2fLmQdd/8FwynB+5at7jMbywz/VIR0q0PR5gUDTI8E/HQtQYo?=
 =?us-ascii?Q?SdMWQ9xo5VpcuRVNZOQrfbz/GAnnCoWuf3eL81Dl4GiWrXUy9f1rtpUr+M3y?=
 =?us-ascii?Q?lSAHwpObi5sTlE1CAq2W0/oAnWPGHJlYvl1ojBjvQEDXQ+NMmQkmUPsEHFoR?=
 =?us-ascii?Q?sh96ht6TVSwFfQbH2zKoIGPXGtBy3vLGY8cXMX4u/nyz7jh3zUI2v4KqJjGB?=
 =?us-ascii?Q?/ea5lVXkf0ciicS8RbKXB0Ils1hCMECSwoAPYnVaAesKQUTEIBOdfZCeYyN+?=
 =?us-ascii?Q?tRmsxy7SnU1oLLjcykMjHhghu2I0Q1KMpz8cySlAuUIWOY7mtWUnMGqzp49Y?=
 =?us-ascii?Q?CpOack/PYOuvp4rKNzoOWf+HNVKHy7fI44ZG47xZiIuu9xKnSLP25WkUPubv?=
 =?us-ascii?Q?hACzLJfdzwRcSr3zduHe71akeycZLgWPLKQ9Oix5nnmRJ9/k1azRD/lsewLm?=
 =?us-ascii?Q?9FuDnhsjyVxswX1pgLFtiOzOwOmtvTtLYe0k2cz2RCX7fScGtzGgzQJneRKE?=
 =?us-ascii?Q?Xqc84nvg81umlrnCcA2vMMR4pQS7nf+gZQkfFoWlC0bNxQZzbYTGMTgvZwvV?=
 =?us-ascii?Q?ckwgwX7Z7MsIW7SSwbYfzEIHFXhX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 10:04:16.5030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0800a8d8-3074-4783-e428-08dc73340c93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054

In commit 68822bdf76f1 ("net: generalize skb freeing deferral to
per-cpu lists"), skb can be queued on remote cpu list for deferral
free.

The remote cpu is kicked if the queue reaches half capacity. As
mentioned in the patch, this seems very unlikely to trigger
NET_RX_SOFTIRQ on the remote CPU in this way. But that seems not true,
we actually saw something that indicates this: skb is not freed
immediately, or even kept for a long time. And the possibility is
increased if there are more cpu cores.

As skb is not freed, its extension is not freed as well. An error
occurred while unloading the driver after running TCP traffic with
IPsec, where both crypto and packet were offloaded. However, in the
case of crypto offload, this failure was rare and significantly more
challenging to replicate.

 unregister_netdevice: waiting for eth2 to become free. Usage count = 2
 ref_tracker: eth%d@000000007421424b has 1/1 users at
      xfrm_dev_state_add+0xe5/0x4d0
      xfrm_add_sa+0xc5c/0x11e0
      xfrm_user_rcv_msg+0xfa/0x240
      netlink_rcv_skb+0x54/0x100
      xfrm_netlink_rcv+0x31/0x40
      netlink_unicast+0x1fc/0x2c0
      netlink_sendmsg+0x232/0x4a0
      __sock_sendmsg+0x38/0x60
      ____sys_sendmsg+0x1e3/0x200
      ___sys_sendmsg+0x80/0xc0
      __sys_sendmsg+0x51/0x90
      do_syscall_64+0x40/0xe0
      entry_SYSCALL_64_after_hwframe+0x46/0x4e

The ref_tracker shows the netdev is hold when the offloading xfrm
state is first added to hardware. When receiving packet, the secpath
extension, which saves xfrm state, is added to skb by ipsec offload,
and the xfrm state is hence hold by the received skb. It can't be
flushed till skb is dequeued from the defer list, then skb and its
extension are really freed. Also, the netdev can't be unregistered
because it still referred by xfrm state.

To fix this issue, drop this extension before skb is queued to the
defer list, so xfrm state destruction is not blocked.

Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lists")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b99127712e67..d7f5024f3c08 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7025,6 +7025,10 @@ nodefer:	__kfree_skb(skb);
 	if (READ_ONCE(sd->defer_count) >= defer_max)
 		goto nodefer;
 
+#ifdef CONFIG_XFRM
+	skb_ext_del(skb, SKB_EXT_SEC_PATH);
+#endif
+
 	spin_lock_bh(&sd->defer_lock);
 	/* Send an IPI every time queue reaches half capacity. */
 	kick = sd->defer_count == (defer_max >> 1);
-- 
2.38.1


