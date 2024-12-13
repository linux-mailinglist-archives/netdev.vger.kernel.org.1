Return-Path: <netdev+bounces-151613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160549F0323
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 04:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896E5188B2BD
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3FF165F09;
	Fri, 13 Dec 2024 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="btLpR2SS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E3156F3C
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060961; cv=fail; b=WCFMMqkANlODuKxsIw1UoEsrOMy+v8TSP5G9rHxtsDEsiEvzjQOVde1y1ras3LgRwdNuL/6vu1LQx7aeH4ZlavKA0/uOvd+cl71dQhbN81KoRdiuVVz19wTzLSuyPZqn/E73bkaOJKFBMEO5m8+TNbjKrSsnMVS5IyBMtUlzSF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060961; c=relaxed/simple;
	bh=Il4gHPmG/46J75ufUCVxXs7+3Qs9IIC4Jufsv6ORwuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9ibyj0qoTvEvOSzshOaqk+WK2/KfNU7ZKX7ycuXCom04DU5w2Q4V/Y9ZWODkPuIi/kHJdnsfAcUVQ63FwjuPisS0T9+dgszQfw83eT3h5FcTuw8kLFuxT8vqMpwwQoipYwC6jh1VM6qz6sAAPDVdH/27WY163beBC2jkyKv1oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=btLpR2SS; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMjz2E/QoCHMIB+CwunbsI4iqFhFHoWzT1NNOK9z2jpxr47ke3v91YQIskalIaDDhmLFPOiIPAjNePa8B9gqUAzKy0u8vYFHaUZCA9o94mXwWFA2i7tUEpGVBte2ucTvLn1S2kOq1lsu41iqV+4RU1XlG3IK0WxUv4ZfIwG1Tbrdex9rEkdyoPAddj9Q8orsWEP7RDw/h4HWwtU8xDC1Cwx2ftdZLV1sCl32Pu/pCSsc/PcVMKT96/ZY4sK20OWgAApXwfgAzw0ft44POE4QpmL08JO4Wla96WOzgnyRm21hRpP2oil1pcpN/X81Wq8myFmTkd4jmhcwJE8JkKURzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEBuSF2dViXRdbFMqU7P8ilrpj2whFDLF+S7yAKn/FM=;
 b=tmQVrm5RM+XarHFI2AakuRf9OFcfigdKiFXH2o3Xra2qZKZubY5h0n3g/wZvFNnWVXDwwzZYqgRwRq/OeN+XvU+Yfy4SKInuV7Ek87mLt6k+rdGr71WGqfqRzShwIDpmatXN3Zf7Tkox+qZd2Nqz7GPzVbf+qnenk7Bi1xLDMu2X1GA7LmG5EZ6rz6v2UoO1qXt5Y2WXZj6M+cHCY+mlSQ37O6jjDcaAxzkibssl+18maKQ/qTU5hriuksRS0tKFOURr5WsOopcVV1p7/iAcv11+sUoli9HkWjFQ1h0uR2/t8tnpS8KgMWDEjojIS+UUgOUawV8wvCPiHlOIfkrbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEBuSF2dViXRdbFMqU7P8ilrpj2whFDLF+S7yAKn/FM=;
 b=btLpR2SSSAdAzH1dykkSJwGQLHUBGtY/tMTfqp3f0TJ9Srep4Oo48ebgA5C8GA0VlBC4YTHMUMJTNhf4MXIXfSe37quiPnM+flcm1icaA2FttDetV2EF59v5Jk1qVbNvEqu5DKTMr4tG1JtnUq2F6bj4qED7K/t3hhHVM2pxA0c0cjORACduVYn9FFVyb+tppMgS5gayN29tn6zyfVsQbbStizUrjpyj0lLpSjpVnogpm9ZGF945VEx6pB4mF4S+8rYJMWWhBQgcZiyDHctBa+4WkcLan+A9CocX5WpxzYi5T32MEHu27XHO7FLRB1KRxYwGsiqKkhZ0IFHa8cFg/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 03:35:55 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 03:35:55 +0000
From: Yong Wang <yongwang@nvidia.com>
To: razor@blackwall.org,
	roopa@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: aroulin@nvidia.com,
	idosch@nvidia.com,
	nmiyar@nvidia.com
Subject: [RFC v2 net-next 2/2] net: bridge: multicast: update multicast contex when vlan state gets changed
Date: Thu, 12 Dec 2024 19:35:51 -0800
Message-Id: <20241213033551.3706095-3-yongwang@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213033551.3706095-1-yongwang@nvidia.com>
References: <20241213033551.3706095-1-yongwang@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To CH2PR12MB4858.namprd12.prod.outlook.com
 (2603:10b6:610:67::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4858:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: d14dabbc-e43b-44a6-677a-08dd1b27407b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HoaySfeUJJjmRxGJhF0mL1mu4hsci/KgB6e9bmjYR+tGvPUiVMcOBZ4P2ava?=
 =?us-ascii?Q?YJ5AE4MtVi8/1YN8hGYA6fXpJzpacLMVYyQ0SqWTyvaT+qTHWTXAX1KQNcrr?=
 =?us-ascii?Q?jI5waoOuyoncmgSp2VpKPXnDe/DZx6hrfUFPHesmHDU51WbJa52SkQIiMk2U?=
 =?us-ascii?Q?C2iimj04gyohySl/D9FP2UwBEIEeHge8jzmaZZXCJMlp2nCmTwLhDXBtrJ+D?=
 =?us-ascii?Q?/CbGC6PDBd1e4HkEgSN89XEzLOqXaFBga6UW2ZPr1SNLLhoD1Ut/nVAnD56K?=
 =?us-ascii?Q?uQ4SA8XsHk6jl+v99Tii5bhHu9r1d7kA+R8T7zhUk7Z5UP5dWj7AsLc6PFjn?=
 =?us-ascii?Q?5HW6raQY2geVxJ1IVXUxfUQ2xjdceJaWLNdXWtkDt7CoUWmF9r9s7Du6T6Qz?=
 =?us-ascii?Q?SfQD9T8wAqd1aAbahxpDY2VqyEm4gtOMAt1kNec6Iqkj5HT8qb5arUm9CI8m?=
 =?us-ascii?Q?wrMggmjcToMq5BuvJBypPU79MoXOMoQliEHUL+mtI71qJcJC6uvyjSIFeufc?=
 =?us-ascii?Q?5z6G3hDBcdFI/AhhM9hQ+rzPFwwDvHPfI+QXsSVmrQP4Bg0TizCUKHtDs1+A?=
 =?us-ascii?Q?AoUcowj+poTEAAPPDlQR1zSk5aFWM+HuM1P7HUir4EOOC++T3eQPI6IHhwpm?=
 =?us-ascii?Q?kQ9II1dazhcD4NfpBaJYArHOytBqXi+XS7B1tRFi80vAWma7RcnSolZImUvi?=
 =?us-ascii?Q?7Qw1cM1HkQeaHn0E+9HnCJxZvig3cWSREz13PKHKSP7mTli8X+N8f4KAc+Vf?=
 =?us-ascii?Q?ImxfZYcq1lUFM1AYClGNVM1XVrpFpW9jMaBzFvHWIMQ7O2yGZHhoomzI7Gfo?=
 =?us-ascii?Q?PKXcfqAfvbXsaNVKbab03FCN45Qo/scFmd4kCzZP9cJMPsAesaqsWwZt3KBH?=
 =?us-ascii?Q?BY8JzpocvCpUO0NH7jklYjok7S7gFR/ygHkTT0jO7pnDRGFnoY93TL/baByY?=
 =?us-ascii?Q?gRfNFyqIue1BJpbQZ08/pvOK6JtYkNGyTTGSo2cFDt5Cfzw10NgunpPZqeSi?=
 =?us-ascii?Q?Rh67hdzZTr3Vl2Dxrx0bxajMG+xEHkTOYHgQcZOWAhAUzuPprRSq+8q71oOW?=
 =?us-ascii?Q?u7NuqXep8yy6hOTqEFvTTp58o9iqnbkNdVYWSSkyq7fbX+GZarQfmtR37qIg?=
 =?us-ascii?Q?z1+QQNW7SiPwIWJ/H1ecQemfhF81wyjaj/WPkvXWDhtOmTq8W3Oz4JBD6TYb?=
 =?us-ascii?Q?ppa7izE4kwff4149us9AgIEiiUQm+zbtGFlt3lefGHikhThs7XsmSmC45vVu?=
 =?us-ascii?Q?tw9OhPp0+Z7o4TMD5s/Adsq2g1v83syQ6o5EylSnH6M9vziqTJNKFf9fj5xB?=
 =?us-ascii?Q?KWTaefGLoM52TOZ1P1/RI+VwQ6zULhfvUq6+prYVVorF3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b2iCpEi1XMs407PMFgXl66soqzAHXmXyMo9xbHHPkiZvO3oOqGgMe5ult4Zb?=
 =?us-ascii?Q?lADhW+BFKqrqrviim9aqCbRmXbx9lMJKF1/P5FT2AbhLU9htxfs1/5gGpvcJ?=
 =?us-ascii?Q?tdXR3dPFzF9Dyt+Iy1b5zcnQ8fwIpNeozJWekC81T8kFk+L+K8wrX2m5yvcN?=
 =?us-ascii?Q?JC5006idRxX4QOuG2YUjnkf2l2f75/B7BfZBbBZaqE14kIxxRnog5TEUpRMZ?=
 =?us-ascii?Q?dBTAwScdE6vGUezlQUsXuyXOGURfJ9R0Dwn6daOYlzj+d1P8xyiyiBCM0aPw?=
 =?us-ascii?Q?dGyB5GwnVf2zPgwsqS+s+KnDoIx0UoLHkLBBxydbXmL9YfpAQtey6hrptnjB?=
 =?us-ascii?Q?FK0Fxp1EChnJ+BFPhb1lwcGgzAIJ/7kuQWhNx5UzPw0relpvITmk5AsjDwLT?=
 =?us-ascii?Q?+np5ITs20RT/L/8jft0iJ4xz2JjNpcDkl2apF6rinkLyCGaxuqbdlMcDRTDA?=
 =?us-ascii?Q?Ef8JU4yWplFh4ILp9qzOCXsO4mQiq6dBiDs1I0w/MJkqqDYBI1+joSHZjRpW?=
 =?us-ascii?Q?LnzJnJKiq9ugeWWAWEVVsuvr740wHPhgHpKQleTmEkIRVhDlJL7kp9rSF+Ca?=
 =?us-ascii?Q?UMPGcFEeHl3JDuXCPkSAtRxtwDlcXkrh1qwvxFno9ohjsTV6zvMco4r+azKW?=
 =?us-ascii?Q?qvNw0WhL7yoKjZVhuIUcC/UdgnQSGojUPDSqifqiCdupb0bevTdp7Z7kKC/9?=
 =?us-ascii?Q?N5E5fLQwqTnZmDAoyLpziXlPPrQmo1Q9GGTuWudcmXYAHfACeiSlkbFSr3M+?=
 =?us-ascii?Q?XbGUOKmXIfG2hT5YNcXUpbmdhS7zOLWc1owSVTfV6PAFzTL47ukkIuiUzNdA?=
 =?us-ascii?Q?Js+JqeSbbGHzmaBdqswdNOxER+qoLBRZogGm2F6DKAMa1yhuDy4jUKS51pxW?=
 =?us-ascii?Q?TF2Zemf/3HTkaPqfnaKEwogBnRQEAnoGUlT8iUJWPwLHGcxo9MtUsJ3tbnuR?=
 =?us-ascii?Q?4Quiws/LYABBxqygag8zMWKEzFuzgo3d+nqlU+fUgfIAQiH6z8VPe9f5CFes?=
 =?us-ascii?Q?rPzODmIZcU+SsLqxCSBAbuqsDWWG9zig/l4N8naLIlRA2WLt96uPhn7JLt6L?=
 =?us-ascii?Q?QhNr+q7OX6VpRcihMIhoj3zSPJCY2PD/JnGoN4LqQ/YKjo8jJwp4hFMeAMov?=
 =?us-ascii?Q?rV5AKRYZbK5uZAzhq5TrEkU1bH1ZcWabsBovJryEyvpj49GK3N0RffOh9m7N?=
 =?us-ascii?Q?UPDFawkf2cdR2nODtR0kAUH68DVPe5Du/IzkavbbaS1RFGXEr/FyrnjA5oVv?=
 =?us-ascii?Q?JLPYo+lBuHcntsIDHydSn5wrjU5Rm1gE67L8GiwuIGQSnfBaAkihGBo16shF?=
 =?us-ascii?Q?jgnU2aZzNRSZaDCBq27OeZfFOitLic1PMLUJYLmEqbKa/sN6iNkU9/odekRD?=
 =?us-ascii?Q?gUSHAHoPXMKRN7DLeUhcG27XuRcBVwurBWSu6xplgdgGD3gAgk7IDblHV0ot?=
 =?us-ascii?Q?9slGP/V6T7TU74+vs09O/umhILKctyyw3KOeh6c/JNVq1ZK0hfE0pK4OgpMk?=
 =?us-ascii?Q?oYhvyBgOUC1iYW16gm2fEle1Jj6kQ7YWp6azBqhJMWXRchAsUSVpZkzqKphR?=
 =?us-ascii?Q?5GccYcQbrbojdky3+cxZSo541spTiRIv9Wn18Lf6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14dabbc-e43b-44a6-677a-08dd1b27407b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 03:35:55.7370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27YVEbgwlMe9SOcqB9CSR3fuD/ASXMFzFZT5zUet5N94h70Wbv5WoA84BpVtRqgU/vVF/ceCyemG85/ewbD4/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890

Update br_vlan_set_state() function to enable the corresponding multicast
context when vlan state gets changed. Similar to port state, vlan state
could impact multicast behaviors such as igmp query. In the scenario,
when bridge is running with userspace STP, vlan state could be manipulated
by "bridge vlan" commands. There's the need to update the corresponding
multicast context to ensure the port query timer to continue when vlan
state gets changed to those "allowed" values like "forwarding" etc.

Signed-off-by: Yong Wang <yongwang@nvidia.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
---
 net/bridge/br_mst.c       |  4 ++--
 net/bridge/br_multicast.c | 24 ++++++++++++++++++++++++
 net/bridge/br_private.h   | 10 +++++++++-
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 1820f09ff59c..3f24b4ee49c2 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -80,10 +80,10 @@ static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
 	if (br_vlan_get_state(v) == state)
 		return;
 
-	br_vlan_set_state(v, state);
-
 	if (v->vid == vg->pvid)
 		br_vlan_set_pvid_state(vg, state);
+
+	br_vlan_set_state(v, state);
 }
 
 int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 67438a75babd..416c2f16cbe4 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4267,6 +4267,30 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 #endif
 }
 
+void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
+{
+	struct net_bridge *br;
+
+	if (!br_vlan_should_use(v))
+		return;
+
+	if (br_vlan_is_master(v))
+		return;
+
+	br = v->port->br;
+
+	if (!br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
+		return;
+
+	if (br_vlan_state_allowed(state, true))
+		br_multicast_enable_port_ctx(&v->port_mcast_ctx);
+
+	/* Multicast is not disabled for the vlan when it goes in
+	 * blocking state because the timers will expire and stop by
+	 * themselves without sending more queries.
+	 */
+}
+
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 {
 	struct net_bridge *br;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9853cfbb9d14..b4e484de473e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1052,6 +1052,7 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 				struct net_bridge_vlan *vlan,
 				struct net_bridge_mcast_port *pmctx);
 void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx);
+void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state);
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on);
 int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 				      struct netlink_ext_ack *extack);
@@ -1502,6 +1503,10 @@ static inline void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pm
 {
 }
 
+static inline void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
+{
+}
+
 static inline void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan,
 						bool on)
 {
@@ -1853,7 +1858,9 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 			      const struct net_bridge_vlan *v_opts);
 
-/* vlan state manipulation helpers using *_ONCE to annotate lock-free access */
+/* vlan state manipulation helpers using *_ONCE to annotate lock-free access,
+ * while br_vlan_set_state() may access data protected by multicast_lock.
+ */
 static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
 {
 	return READ_ONCE(v->state);
@@ -1862,6 +1869,7 @@ static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
 static inline void br_vlan_set_state(struct net_bridge_vlan *v, u8 state)
 {
 	WRITE_ONCE(v->state, state);
+	br_multicast_update_vlan_mcast_ctx(v, state);
 }
 
 static inline u8 br_vlan_get_pvid_state(const struct net_bridge_vlan_group *vg)
-- 
2.20.1


