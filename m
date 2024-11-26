Return-Path: <netdev+bounces-147525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC52D9D9EE8
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 22:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C795281C04
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58E1DFD9B;
	Tue, 26 Nov 2024 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SR5uVoPx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311021DF267
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656851; cv=fail; b=PKoMQtKWMQRETAVIvzY8Pm++3CQEF+uBEPJCVxHHfqIeXxhv6CmQocwjJwgO2OC8ynpYOndh/4MCwixz/zpsSI5EM1Rgq2PipSpICtSxMdmQvuA5puTaZHay2F/lGsq6EabSNp2cgdwgpuxvO6ligz/hk6zRMdW2hDd2goOm+tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656851; c=relaxed/simple;
	bh=AydVqt31YL+3WF7wTRqq2Q5Yx1EL0avl1G3sdO4PFnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SW4ShrfbkcyYB1az9I7QteYE1dL6slrxkHMKeo9WocrCcCPTZaD8NcCPN2Uhgw+OP1BjfocVi6SGtB9x89KHmXjU0q5DHnWtDrJ8cvJjj0u2TN5PJKacR5VWpMEIJlhO2nt7NyEfg2h6fZt3+0lHceBg6k/heURgKV/E9qHqR44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SR5uVoPx; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7NmpogbZAj9YgXrUlR9GPvc61JgGnoQ15vLKdjJww4ds35LYxrbQD8IPJ5WVZ9oONWyl9oNnecAaxxpqHq86SLckmgB8UV1kiXF+E+cVUHxEgDsoBKl08opB6bKdj9pDicZXA1fZE7cewteMqTgyjahHgYyVxhAaP70ox9NR3Hb1WQYd95mGwLYLVLxXlKDCjO/V2KIdCSHQ3oOmyg9TQD4yP766FTcRH4NllonqazB6KKRD4XewOf8TSN88z/fjTx1koKVIytEo07QWCFBIeHTenIzV5FOba5cpg+ltdSW6TWDnb2IfK1fdiwfJ3UkqaddCQLH19Q2xanTWahPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzOdvIkGpy0khqZE3gI2ud5rFjUNbRKpyZ33LUy3yuY=;
 b=b8k85kSj5cvcjjXnRekQ9oLcKOdzzbOhj6ZiSj02mNHwzKjIDCEXuGb+L13vNn7GxfLxkDRDOaOapqLQJjp50wyMW2dOWPjpGAAp4u+h/2M0ecQj/x/G3w3FvnIzrX08V0q0xY4ov2lit8oJbgTVv7W+p/sliYMDdNjm7F2/c3BMAGkHiUDnVNnUBCqo6Y4jn5p7o+j7WRnxmKwrvswpw1u7DYigqcQFaocE01AVASh0+IrJMWZd5R8qU2/YfHljCEK+eum7TwQqmLmGyQmk6FIDALitZlNuuBkA+w8idYn/e9JPIYxdC5Bui1T6p75daDmFwC397jzsaBPCCACN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzOdvIkGpy0khqZE3gI2ud5rFjUNbRKpyZ33LUy3yuY=;
 b=SR5uVoPxjcjm7YTBpYmpcT9RkX5bL5uSUII8RAp1nIoGLeLA/+j9ik6uI0hwCYbFT7QeOH7asSAV/+KQXXvn3UXwY41x3KMB4UMkoaJZ7Euk1WOAP/dTYvtd+W89kdYqDPL9n+hs/n/SaytUoHh++oJZKfHVX+3RPs7gdG1G0NE4Rif7X+VFswb2WR0kr7I2Hl/625ybrFr46gLS1TvSsgnMQqjthJRJCMbfUrM1TGzgzImWWeeIMP8B5F/bBx+pViRW1w5Y67hiO6JvNGE8Hcfs4cv1dt1r343Mk5dwuTLE5m1Rr4ZawYL6paUbm9w60VG4WOoIxzEA47cdlf5yZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 21:34:05 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 21:34:05 +0000
From: Yong Wang <yongwang@nvidia.com>
To: razor@blackwall.org,
	roopa@nvidia.com,
	davem@davemloft.net,
	netdev@vger.kernel.org
Cc: aroulin@nvidia.com,
	idosch@nvidia.com,
	ndhar@nvidia.com
Subject: [RFC net-next 1/2] net: bridge: multicast: re-implement port multicast enable/disable functions
Date: Tue, 26 Nov 2024 13:34:00 -0800
Message-Id: <20241126213401.3211801-2-yongwang@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126213401.3211801-1-yongwang@nvidia.com>
References: <20241126213401.3211801-1-yongwang@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::35) To CH2PR12MB4858.namprd12.prod.outlook.com
 (2603:10b6:610:67::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4858:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9f534e-5cee-4d94-046c-08dd0e620d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CDqvr5iUaB77xb2OH1vQk+8TDE7HHSKKpPg2f+5zPXQz71lfBndt9gXOcS9v?=
 =?us-ascii?Q?8sfo3hqrTJsTyKLbleuzpw+4S4eImw24pKQhmFr2dKDqV0EMKKjJZI2pi/7K?=
 =?us-ascii?Q?zGB9LHRQ1z2hzyFJO7XJgwYWOn/O/x2NV+89FNE3L7qdbFZ+cqgKnMdeTYhU?=
 =?us-ascii?Q?k/g+ERe+Ll3/BgpU4rJGpJshwb4VrIXiLzz8FutdPLHDLTkFj/Le1gkFcgnV?=
 =?us-ascii?Q?7ZZrHdRG/RO/I66bO1haoJruf0noO3V7HrY1YJWHhEzaEyq+xbuUuPQEzyuC?=
 =?us-ascii?Q?tMOgxdSlEqrzWPDkThTGrl9TcwmYJu5V0nhYSnIQCJZa6RfX9q8EbkVibP3G?=
 =?us-ascii?Q?o/IdlIWI8EmArE1rWp+cDM9NRxY28mJc9oAXzEZjwDmlJeOvDpsp1ACsxedI?=
 =?us-ascii?Q?R3+gYx3OHL4oEJq7HsuICI3/SGzscT9ZnF+fandg6/tC6cOuBTSDIgP+wqrl?=
 =?us-ascii?Q?GfKu6mS1BBePx7fLR6xg3CQPaDMMIZb7d8tKChhk8CCBwuu2TuQnEIGyeNhG?=
 =?us-ascii?Q?A5YD2xl7ewIsLHcQDI7oktBcPahHdCjq2odExTNsoiF9c/mkE+Vudx5B8Mr9?=
 =?us-ascii?Q?A3Uvb/v1IWH/hA0U1CIRMPqThFdd2kEJ9QPgd1uoj+4G59MZsXxgZEEGM4hb?=
 =?us-ascii?Q?XlrPSWb8Mxlu9aewsFpXA3CkAy9GbDVF/dAM/CE6paCpOcBpZyFDhDB64g3u?=
 =?us-ascii?Q?kjsi5h00azeNep/Bye6ccJzyBBUYEW3yySWD1TV4XD2UkUArvj5GTm7xaODP?=
 =?us-ascii?Q?N+AOY8wC5zS45IAXZYjkqied09uQatCxfBEl/W5xT26A0zkyc8HpZsdytK0r?=
 =?us-ascii?Q?O1HSMw2+zxe5Fb6zfUZnmQSKAiNSIHf4v4GN+5MRK58kwkr2JDVxaypMxxB6?=
 =?us-ascii?Q?XCP2wjjKuqvyKJUTSM5AO18ocIbHi7/yHE7GyDxReMOzDYlmRzvFZRG2/gb6?=
 =?us-ascii?Q?PglKMnB0Fdjk4dcNU7ce7GW1ARe2ZEKzEAI+d8ReG6rMF9kFVS/SWmWXSFTh?=
 =?us-ascii?Q?4PG3UfDlVoR7evUA87do6qhAa73e7fwRPPra3gYiDk7VWnY27R3NCsMPZGIb?=
 =?us-ascii?Q?+ha6irK4Un+d7MBxxjgpU5PagQ7VL15Hymqnaeo1Fg1WZV0FEsms59VTn4M7?=
 =?us-ascii?Q?sVhWZFeLp2pi0TeDX8bukdvXvINc13pQSfR+DLIfeoyNEWOliSUw9uregsdK?=
 =?us-ascii?Q?Dbnd5ppmOJcNSJOJdSJvxWkaOeO7l71Dd7ItLVP2YvSNlXCFPYhsr9D1Y8CG?=
 =?us-ascii?Q?WrYoLCTNMoOWHyWXG3etOeqENfd8f3r7+l9w06pSvDQLDLnZBhGK+nYRrkFY?=
 =?us-ascii?Q?14ZSA/ENZGV0x28CR4K6ANAgeIuLoRpLnoqYu9CBXoSS7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EF/sDiBFXtGnoKd88lyRmoDb3u16PFQ+NaMaPQmHZrMZP2S06JrGiDz3cym7?=
 =?us-ascii?Q?7XTzzbd4zdVMMjyqbV4XQ3KfS4gPpw3Q6xD4Kx18gQCwJXOA10EdVplJzipD?=
 =?us-ascii?Q?cSO+cI4+us+xAtBIrV+NASlsdQUV/+4KNx7ohKopgqNf6NR+g6z5i0hwBgE+?=
 =?us-ascii?Q?4L7ecxtPCTorZP43FBChiSv8aTa2IjRJhCCJSvgoj3jYrGV5HRW6UtGLZkLn?=
 =?us-ascii?Q?Ct7EQMzOJreQPzaIzKdp2PzzK/eTuyXlrsGozvW1MH//lIRt+lcX5Pto8Vdn?=
 =?us-ascii?Q?zLtBVAHMchA3R4dMVlqHGKpiA9v6qXPg7b+SP0Pt7ql8meify8hFQ+mYTTIy?=
 =?us-ascii?Q?PKQJzIiPwBVI5s0E2PjaowFkyui2aIj9k5GaiFZKJyPoNrXGkiCSX1aQqxkz?=
 =?us-ascii?Q?BfSbykFoFTMwG2SNLLQmwqkD00etneaHFiHwZFEQtnh8ZDnPDsrSa1q0r7Gk?=
 =?us-ascii?Q?DR63M3NfaEPzGWz50J8pzluYqwNmCSXBX+SogTvpSOEaKWR5KrYrzEJgnUeu?=
 =?us-ascii?Q?iqA+/3lyrtPcwZYddWDg2i9uoC/GBgqKDQPMU5MXNSQlLD758dJwnkgSLYSh?=
 =?us-ascii?Q?4kAoeq9yFRtVGb0KSOPQHND+BjKsHtA1gTH+mhQNy6VKncS5LlMOGlw+eSLL?=
 =?us-ascii?Q?JvQKLr881Eb5T2VLvGdOcfzXcQU544uz4R8h4jgj1fnuj8kjwClK4vrzZopP?=
 =?us-ascii?Q?hBV5bH9zj174aAAUnFv74qfqe1GFFOd4WzBz8UKskbbu8w2VxgZ47nlpOoxj?=
 =?us-ascii?Q?UFU1Zlmm+H3GjtlpRHKSjTsPc7YXMXhTTwzY8/IGnvsd56sNn92Z+8XfEc1v?=
 =?us-ascii?Q?n/0DfPDdNTAhVDJFU5NJzlpeNvllivVd+F6tklxHL/dyVfMmZusKsOL4Jqh8?=
 =?us-ascii?Q?Gp4Qu2jw+1q83hVzfJkQEDnhRvubElq5vBycW09x/eAnZ9a41lcmo/vJFxw3?=
 =?us-ascii?Q?i1fpp0yso5sFJetQWJ5KA7mQhsCGbi/ZkHZa4f5ylfXbNDIY7hY9ONolo4cS?=
 =?us-ascii?Q?uSesAKah6sqTCwD1HfaeRyVTi/ARHnRJjHZd7RNItWSFe0po9CDkgWSAACsE?=
 =?us-ascii?Q?blOVurdQfkcEvEdOuvD11g1LCQEZRM53WHeoRSvYn31y+aXHISQW5tJ63kfY?=
 =?us-ascii?Q?+kKOaBFDcTd6UgKMA5lX7qfXyu1H/iQPthwqyuOYG/Mikg+mYZvmk244gTWV?=
 =?us-ascii?Q?FiHTTVJ+fcvsZh0XZvAHK+vdjvQuFy/51AKKo2ujeoN5UNNDxlD2vmjRgy4/?=
 =?us-ascii?Q?S5L1ed2rQkaJQNXc76gd/4sZQ0idpT73PcNYHw3sD8cFNJYI0e4P5wgikIUQ?=
 =?us-ascii?Q?S2CZAJd+QdVZAmacGVQYEZra76Ymevc3v37AFXLeZudUqSw2rzkzqzOHJYrw?=
 =?us-ascii?Q?nTlOYN4Wa71V8UqpUVhXBuTfoSLyXBg0rPyLu+bpbTZKG+s5IzcvKIKWfj91?=
 =?us-ascii?Q?4D/PW+nHHVsE6PmtZQ61a4ki6+Tr87DrGlnSnYZOJeZVjrUfJp4ovE4abRYy?=
 =?us-ascii?Q?Xgoa1cd1Gpeg5WnL3myAm9hGDJHme/zNtN7sKvEk+5JMU+6sZur4dgHTo6Bf?=
 =?us-ascii?Q?hiU2SqhhPOWm87hYJHdnzv9Ry9DNPpQVeyrfavzq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9f534e-5cee-4d94-046c-08dd0e620d2f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 21:34:04.9132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaBy7CyX3mrl64c8t3fp1ULl9GSX3ubex5mwEEKYySRJ5MHX1jyXLOB3TK2ahouL6tKS8pgqKmR24IqPiFSaeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447

Re-implement br_multicast_enable_port() / br_multicast_disable_port() to
support per vlan multicast context enabling/disabling for bridge ports.
The port state could be changed by STP, that impacts multicast behaviors
like igmp query. The corresponding context should be used for per port
context or per vlan context accordingly.

Signed-off-by: Yong Wang <yongwang@nvidia.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
---
 net/bridge/br_multicast.c | 75 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b2ae0d2434d2..8b23b0dc6129 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2105,15 +2105,45 @@ static void __br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	}
 }
 
-void br_multicast_enable_port(struct net_bridge_port *port)
+static void br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 {
-	struct net_bridge *br = port->br;
+	struct net_bridge *br = pmctx->port->br;
 
 	spin_lock_bh(&br->multicast_lock);
-	__br_multicast_enable_port_ctx(&port->multicast_ctx);
+	__br_multicast_enable_port_ctx(pmctx);
 	spin_unlock_bh(&br->multicast_lock);
 }
 
+void br_multicast_enable_port(struct net_bridge_port *port)
+{
+	struct net_bridge *br = port->br;
+
+	if (br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
+		struct net_bridge_vlan_group *vg;
+		struct net_bridge_vlan *vlan;
+
+		rcu_read_lock();
+		vg = nbp_vlan_group_rcu(port);
+		if (!vg) {
+			rcu_read_unlock();
+			return;
+		}
+
+		/* iterate each vlan of the port, enable port_mcast_ctx per vlan
+		 * when vlan is in allowed states.
+		 */
+		list_for_each_entry_rcu(vlan, &vg->vlan_list, vlist) {
+			if ((vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED) &&
+			    br_vlan_state_allowed(br_vlan_get_state(vlan), true))
+				br_multicast_enable_port_ctx(&vlan->port_mcast_ctx);
+		}
+		rcu_read_unlock();
+	} else {
+		/* use the port's multicast context when vlan snooping is disabled */
+		br_multicast_enable_port_ctx(&port->multicast_ctx);
+	}
+}
+
 static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
 {
 	struct net_bridge_port_group *pg;
@@ -2137,11 +2167,40 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	br_multicast_rport_del_notify(pmctx, del);
 }
 
+static void br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
+{
+	struct net_bridge *br = pmctx->port->br;
+
+	spin_lock_bh(&br->multicast_lock);
+	__br_multicast_disable_port_ctx(pmctx);
+	spin_unlock_bh(&br->multicast_lock);
+}
+
 void br_multicast_disable_port(struct net_bridge_port *port)
 {
-	spin_lock_bh(&port->br->multicast_lock);
-	__br_multicast_disable_port_ctx(&port->multicast_ctx);
-	spin_unlock_bh(&port->br->multicast_lock);
+	struct net_bridge *br = port->br;
+
+	if (br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
+		struct net_bridge_vlan_group *vg;
+		struct net_bridge_vlan *vlan;
+
+		rcu_read_lock();
+		vg = nbp_vlan_group_rcu(port);
+		if (!vg) {
+			rcu_read_unlock();
+			return;
+		}
+
+		/* iterate each vlan of the port, disable port_mcast_ctx per vlan */
+		list_for_each_entry(vlan, &vg->vlan_list, vlist) {
+			if (vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)
+				br_multicast_disable_port_ctx(&vlan->port_mcast_ctx);
+		}
+		rcu_read_unlock();
+	} else {
+		/* use the port's multicast context when vlan snooping is disabled */
+		br_multicast_disable_port_ctx(&port->multicast_ctx);
+	}
 }
 
 static int __grp_src_delete_marked(struct net_bridge_port_group *pg)
@@ -4304,9 +4363,9 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 		__br_multicast_open(&br->multicast_ctx);
 	list_for_each_entry(p, &br->port_list, list) {
 		if (on)
-			br_multicast_disable_port(p);
+			br_multicast_disable_port_ctx(&p->multicast_ctx);
 		else
-			br_multicast_enable_port(p);
+			br_multicast_enable_port_ctx(&p->multicast_ctx);
 	}
 
 	list_for_each_entry(vlan, &vg->vlan_list, vlist)
-- 
2.39.5


