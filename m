Return-Path: <netdev+bounces-182752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA4A89D43
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5493A4102
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44892951D0;
	Tue, 15 Apr 2025 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aml957F3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECCA2951B8
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719158; cv=fail; b=Grc7BJz5Sh1OQaWst62Z0Lj8EBqaix6KJH4lk+rpZka1JSqT5jiOTQqqmQ2T60OtgrFnFlUK4dMePzS+YkYSHKuXD5DGAgsVjAtCSjscZBvkss4Z/mM4wxC2iJeZne0MVl5kpHKOMRAk4drLIMmVMPAnPWsnRXVRjBBkMqhX9f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719158; c=relaxed/simple;
	bh=9xJaZTA+Uycu+vhc92Anwj1H1SESJTLuP7hqvNkqqpw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8UM6Td3RtAaCz0vvsgTJrbGM1PkxSUtMJj0wjsrWRqaQpQlQktTuLioUPd9YvlSeP3ubIyqkQ7HZVZyCK8tGajR8Db+Zqu4MANSpn/w2LBPnfG/HD9nA+qfwvIHaNbSAOZM0FFVYTkxrehhZqFRn2diKEK0NzBBQaSsbYIE+wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aml957F3; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebMGdeaJZb2bu6uXAICXHrSqIduH3zClrOLYbqTPpSwQPouvYmdw5Ta+rhoRxFxS9KC9RVZT3USgvUQlFFo1LERbB/q6ok7ccDF0HprR3WPvXJ7IkJyGbie73eWZLqZ9Ioi3FuvN3Q1jek+/DAr7l5FcTbGxVmbYYFPv2pFlH0LpBSd/cTzN765KxH3zVt4VQeAVN6NaAZ3NCDyCHebLzMua8TjF2J01tAsbfTFShvBOxf+tuHKTTukzZawCedicAEvrS42U+HAt/nFUqglazSlTpKFcKiwK7cPvZK/DAl2Di3YM+Xbil/t6/XvviF1wUi1Jo8/u0GXa7JOTACggNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klnzXrHYMAFJ2WwIY8A7UNt0DTEAtbegAjNKLaBi79g=;
 b=dawng6Wo12NEf42/yUAqoXMeXCxBwVhTGVeYE3f8RZlfqS8hW3yImtpNInv8rPYkXnJXznZxYe0V8Blti3mKJkZAJpZbckhHu/aOg0Ttrdp0A6NpUowuKLaeJKJeRdy/bErPzNRV13lNhCl9YY7/TnJ81LK56CNDQv8n+BCkMreP5fbvDc5N25s7GgIprWu2tEUNDRu4oPdZ0N1CcgdDo1b7wFFs3Jnao08kSsWRXoIviN7oI/IQj+ncMPcMuPwMJU4sSRs1PnMpGNGBHorZ2+eiw92TXm/2yuzjRNOvn0L4PMkwI9D114mkq0SUWNnQCMocSXHv7mnYhQYcjDgIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klnzXrHYMAFJ2WwIY8A7UNt0DTEAtbegAjNKLaBi79g=;
 b=aml957F3y17ImtfJp77NzSqaiDed2O0ncnL1OZrn9xxPgYy+470NG1HaMcMjPaOvtJ8aT3eOphmKSrIfNn+iKVYSAM+ecUj7DR21ObY+/RjYEPS/nRkZn3ObCqLn5NerX7Ta8CIwsDErmHWVlNmbO66uMiX3D1nL7B/bQruE4UXV4LZ+P17nuRrT7vvsDRVZ1wwYPZ328EzELIyUducq+CT8O20uhaZUqzswaqiGFyT5VWVv14giQNf6jzHXJOpqzZSAeXqCXLWSUlJvIz12eOx39X6nhhjCq3u8WwBZk8opTW2HKSichVA1SMSCX+GV4reEmWoFGCX3Lanc5vcIBg==
Received: from BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::17)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 15 Apr
 2025 12:12:31 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::df) by BL1P221CA0021.outlook.office365.com
 (2603:10b6:208:2c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 12:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:12 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:08 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 03/15] vxlan: Insert FDB into hash table in vxlan_fdb_create()
Date: Tue, 15 Apr 2025 15:11:31 +0300
Message-ID: <20250415121143.345227-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415121143.345227-1-idosch@nvidia.com>
References: <20250415121143.345227-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: f4025b34-c7d5-40a4-7feb-08dd7c16cb06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ebuqkz2uBzGTTmdRxhQHk8lPZWt+24oz90kTFLqgeExvKwJfaUF1Ft4xNv3l?=
 =?us-ascii?Q?uS2Vch+ZhTVINdVnnftuw6BWx7qF9W6JGmT8owejPwqDC5POwglKXezB1UpA?=
 =?us-ascii?Q?uydkPaH0JZ0A8ho1KYngObV08zp7yF+Th9UvYd3jgw8kgI8maDNVDzEKacmX?=
 =?us-ascii?Q?XvMGi6fU3skRcCTNFhUq+NNKGIa5lkO+n115BWvoBxIgLCJOtyjkwxTgeNwo?=
 =?us-ascii?Q?nn4Ff+5S8TnSq4idTes4yQidJIaSEO7EINiGr3y+8mkdds7CuQwccekte/VC?=
 =?us-ascii?Q?Uc1E6bp22Jsut38whyb7w0v0kwbAsTVLv88aehnE+6kj71X+GPt0odPqtj42?=
 =?us-ascii?Q?/U/u1f2KpZj97MQrdCfiKTZ1q3AD5+U0IaecthL8XlSdoyCYq7ceYdx2/kRB?=
 =?us-ascii?Q?Xq0D/VvkrCgqyK7fDfn21ejPlX9pPGW4Kxg8GStQyizzKnkakN5tTjWRzLkm?=
 =?us-ascii?Q?CF7/LgyyVHmNJWOCxi2u+5HcdgU0bdJEGOH/Ut+PbRonhGt15U4/epXCuPLF?=
 =?us-ascii?Q?w2SMcgld4Zcuh1mqNphRmy6wVAvsoYpmszjqa5Phn7TctsmT+oKqch2grK+N?=
 =?us-ascii?Q?a5XBCLAomPWIUzR12vYkP6ri1xvCzZZ7KwZPDJzFzTWvFyUgLAX0rAhZu8vU?=
 =?us-ascii?Q?cp4td5hjji0hxVnlOV1OgxbYI+nOSp+ijPfXG0s+B1gtfhsm/a94bpPQmRSY?=
 =?us-ascii?Q?eWoKwgFcJgSeNx9Fj1tBwGiQFHEahE6cOD/IOX92kC8I3RgohYPzwfBNBWqz?=
 =?us-ascii?Q?g/f+tlaS32D8MCRZwgraICuYZNQpR9cVb4oWHF74/6M/MSe/MEnr+hBeq+d6?=
 =?us-ascii?Q?QQxA40JFhV8zQrfoZIzFfCB4HyJR9MuE8E0r8iilkfmnEuRz4V0N/2TK936e?=
 =?us-ascii?Q?vpkTOsnhgIXyTJsWjH/620sfU7ewMM+sdwDgsc7Ae1S8S+wwiwlm2XTQVrp4?=
 =?us-ascii?Q?LvuGQZU2ro7Vflx0eFb/0CkQKYxdosKH1vU9jbCpstuZE6tgD6QLmol5hghP?=
 =?us-ascii?Q?AdEjku/GQK50CVP7a5tqP4zJarhGiTFpAP1d1RSGj2DaiFFgbqHJ5Do7oHf+?=
 =?us-ascii?Q?vCxvzN/vzuz/KgPo72mDYKjd71HON2HjvlEHH/Z38hy4nmKLTSs0HZxgV996?=
 =?us-ascii?Q?9hm29tndI2ShXrqRtPgitwQ3WovEPgvZDN53WoI1DRHIld3p5QIugfwfPLes?=
 =?us-ascii?Q?c1pGGBD12juAFQXTtlBc0xJuyOktCYSC3T+kbEMGcbn65ul0h1et8yDVWmn6?=
 =?us-ascii?Q?L3GUxri4SBGpv528yHG0JkXOn6hMW1ae/m9SCAlLdoSyLsBin3oSJOiP16VN?=
 =?us-ascii?Q?JA6c7MOUp8gD2SRktnO+JZY87GiqkoE2C0pgvh/IKjDVtTxDCD2FsN25pvvv?=
 =?us-ascii?Q?LMJvZim9Xct3HvxhUJx6Ovf8wZf+q4SenFoeipWI5EEBE0pBiIbf2KfAG4GZ?=
 =?us-ascii?Q?YnwUfxugyl+55ZteRNLv6kU4LRr8dGFb9SA0gd0QLRw1MbL3+DAwbsC+cxdz?=
 =?us-ascii?Q?GTfWzk7r3AAW4mSBs2OR9eyC0A5qn4dwX5U3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:29.2710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4025b34-c7d5-40a4-7feb-08dd7c16cb06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000

Commit 7c31e54aeee5 ("vxlan: do not destroy fdb if register_netdevice()
is failed") split the insertion of FDB entries into the FDB hash table
from the function where they are created.

This was done in order to work around a problem that is no longer
possible after the previous patch. Simplify the code and move the body
of vxlan_fdb_insert() back into vxlan_fdb_create().

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3df86927b1ec..915ce73f0c87 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -816,14 +816,6 @@ static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan, const u8 *mac,
 	return f;
 }
 
-static void vxlan_fdb_insert(struct vxlan_dev *vxlan, const u8 *mac,
-			     __be32 src_vni, struct vxlan_fdb *f)
-{
-	++vxlan->addrcnt;
-	hlist_add_head_rcu(&f->hlist,
-			   vxlan_fdb_head(vxlan, mac, src_vni));
-}
-
 static int vxlan_fdb_nh_update(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
 			       u32 nhid, struct netlink_ext_ack *extack)
 {
@@ -913,6 +905,10 @@ int vxlan_fdb_create(struct vxlan_dev *vxlan,
 	if (rc < 0)
 		goto errout;
 
+	++vxlan->addrcnt;
+	hlist_add_head_rcu(&f->hlist,
+			   vxlan_fdb_head(vxlan, mac, src_vni));
+
 	*fdb = f;
 
 	return 0;
@@ -1101,7 +1097,6 @@ static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
 	if (rc < 0)
 		return rc;
 
-	vxlan_fdb_insert(vxlan, mac, src_vni, f);
 	rc = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH,
 			      swdev_notify, extack);
 	if (rc)
@@ -3994,8 +3989,6 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 	}
 
 	if (f) {
-		vxlan_fdb_insert(vxlan, all_zeros_mac, dst->remote_vni, f);
-
 		/* notify default fdb entry */
 		err = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f),
 				       RTM_NEWNEIGH, true, extack);
-- 
2.49.0


