Return-Path: <netdev+bounces-152327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1F29F372B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFB318916A7
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230902063F4;
	Mon, 16 Dec 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aqFXM+mK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F87206292
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369206; cv=fail; b=J1cy7PhkSe8d2x0dxdVfJ1vvzsKKQ1NlOY/ASae7SAeqinKHn2dRVcW8IlPI4PdqMWwtZ+SeM9kiajICVt8JFU+snqIJE/jlmGZ3cdvVFH6+xj5dhgBa/SZrE74Dh8OYlq7qMfQIngHFpUBY1XXFwNzvGQtmVaO093we/kOgfO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369206; c=relaxed/simple;
	bh=+EH8B1bEiH88T1asQBjmvUCQNb1aGQT/LcZq651M2pI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmwOTTr4XQ91r/kvHfGjnlb6Eyw3oqLN/QHa2laPIq0mvo/7SVaAcIVcGNOpJt2to5Gre/05c0dCfT0pd5pJWSNkpwka6YTsfRIbjOZAcK8pkWZgM5zG5X1i0SYKStJHT/7idAM4El/eoFEz2OyDEmL+MssP4jSW4GpHG6BZ1r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aqFXM+mK; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvDemVpoUYLWhhH5etMIrQnp2ATP3aHnw4k2fjsTqBcjPblU0jtIB74FeEANrhDEQBVCuOqju/0xO3UyIPa2CR1CHhLzj6oqUpdLSfwf7dfgCr7/clgxDQ7DOlB7/hEkcpIHrXN6ITFRXciJ7g6azs7PnSm+NEKrGJwdcdwl8otFytbWwwfOpMllRzn3uCuWOcs3OwqLo+NpxmFkTPhdl/xZBQkOBAzi6LNbRnOkrGQfDURmMhjnW7psgeibSONC/KtwBe8g2Zwg2MkfRhBmMOpm1wnf/OOzw8Wkolc3djrP814bF8Kpw/JFvnDA912PH86pOpdfWVTIfLmuMzpIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbaMKS3G4OJOOwecvBBQMlqy4pfM8eOpax37LXaHE7M=;
 b=mjQyavDBG404tvy1S0PV0x9Fn9D91VxQlPhsj6zPzY328thuJKMoHE5LnON1yy7RXDWW/uRLTSrDNGouCmcqiOwrhNf+dN6YOEADpZM9hQZKUkGIprsnoH+8R4bLUVhkM4AEaq2twjTJeCev08AUwyVJ6RKy0CryofFkhW0eYnwEem0Wd5Pfk6EmmvZunmLVEMeijXtfHax4AqQEBabaiXYJlNMUleCk9NDerCmOP1sq++MMBiLYcz9jpUyTeolSKXqiPjHZ84iXaiIwrNk9GOP/HWVOQfVo1T3HRJbCrt1Kr877ydY8CVJTS6lreuS6SXf6pYCtt5FTeY4APWSF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbaMKS3G4OJOOwecvBBQMlqy4pfM8eOpax37LXaHE7M=;
 b=aqFXM+mKgG3EeJZXwKUhsMyhaNFfIHW+9ZATFhgjCgQ5D4Tb09QWE8lwEvTwVnc6ZkHiwwQiNa+zRUTF0z9zeUFe4Kiqw4rSHyAhlUSUKLuPSiyZjyzPEciWJYPvvbVxgN2Pg2pFtrC+cVjQZDiBhKONqeu29O8wiHTk1xpIQVNaSZLGOIpmwcbdXNk7nWQZQNWIcDUiVq87B7vur837Jl6QqObO1p85LcgsUh6Qd7LLjU/K3ygHDkqQXpI8TPSnP44cwF9m/uCTPCCA6i9QyifahFWpQvVlwE6mXCGIuRbx6zcw61su0Cg5I/b+BR/dyl73P7XZn3y0HHIHs9ugmw==
Received: from BYAPR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:e0::49)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 17:13:19 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::cd) by BYAPR05CA0108.outlook.office365.com
 (2603:10b6:a03:e0::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 17:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 17:13:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:13:09 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:13:06 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <donald.hunter@gmail.com>,
	<horms@kernel.org>, <gnault@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 8/9] tracing: ipv6: Add flow label to fib6_table_lookup tracepoint
Date: Mon, 16 Dec 2024 19:12:00 +0200
Message-ID: <20241216171201.274644-9-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216171201.274644-1-idosch@nvidia.com>
References: <20241216171201.274644-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 53bbef68-925f-4087-8749-08dd1df4efff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evU+V2l7kjrQSEgoiXaaMl0UOmGAdkIDODXiAaYbwZlFDkQoarusyYQjLlV6?=
 =?us-ascii?Q?bmBDbSZGcbc29UH4pqk+hTjnGDTJGaqH/vyU6sslJLPqQpcgmqUkFbUYXDt1?=
 =?us-ascii?Q?19ls/IPsYOu5CbGg2pmT6OFupIHy6PaZwBp/MeFfwWKD2+zPDJxKbO0lqmbn?=
 =?us-ascii?Q?atvFmRryqbB/6poNuK3dHYCAX81nBHTHc2kU1NU88JJKUZ+wwcPtJ52o0jFS?=
 =?us-ascii?Q?0DrVBzmF54hm8qWM66vRpSzvnBfyneZwgwaxYeGCn7UHRaCPcBx36725nadl?=
 =?us-ascii?Q?jqtlg2gWLHcNnqoQZBS2vVWmZpUPn4w7cqnb/5Jmet+JTmvWvYdE3sT/TaRb?=
 =?us-ascii?Q?w4KqGfOb2UYJJixXbxxM8+LyqUP4dxwa0bleSAjeDeBbZ7axDePlxjhs9/+k?=
 =?us-ascii?Q?JZ9GJor/FHz1M5T4Ez2ymCpieBbQNM3bNQDqOr5EFXiDTYbAbMQEMJwNuSxg?=
 =?us-ascii?Q?d6Tne0Xa3pspCQCVTYn3wmkjSnS7lnCGOzbsecfJSW4wl8kqVEA2c05/W/aE?=
 =?us-ascii?Q?IU+ef7+JQOPObndZpOvdNmdhKJ2fMAGaigZGYqXGtKtANwv3YGLjxtQCRewC?=
 =?us-ascii?Q?ZpGZPNRMjQdV/m+a/92I/vRyc5sY7kBGvpGu/kb4mzq5yfQPraJhiDMac8bX?=
 =?us-ascii?Q?Xr7OXD72bWi4dIzErQ4nWwI1Xxd0bEZShPxa7tWYp5IY1F4JF0QEqqeefYdu?=
 =?us-ascii?Q?c3tStD73wdNx7sS6XHpDR+7LeetXBv8WluvKXrFhQJzcrzt1ll9+JWAokajE?=
 =?us-ascii?Q?eyXPma04KLPJLTOZuQ5I75w2oO6wxtZdp2fwoGrq5i4VK+qRT3WLrbEt96de?=
 =?us-ascii?Q?vpbgg3PsiNlMn/xaZmdzdQtcTsYfxWPhbiyhr9NtZuSo0J9c0qqRBOR2G/cN?=
 =?us-ascii?Q?yE4nGZlwgEgVU4+1uxq+KTZi2x+5N2l2i11VjgWUF6vmVj7owGHhtRTeKaIq?=
 =?us-ascii?Q?M3XuFPTAASD6KOhQwW5Z9VMDEeQ/BrFvTEIqrAOoaQNB394mfyMov5lz8Kfj?=
 =?us-ascii?Q?s1A5jd1AAMEryRcqDntMdCBRXk//1y3SaucPacyRGsRdaIH5AbGx7XeWgHAi?=
 =?us-ascii?Q?Il4nDyXbef0viJQ0c4foNVJdSAstbo5pZQ5mX54gRfOvW0Q3KXdkYHG03D+8?=
 =?us-ascii?Q?wcR4t0rpjLCp8D+NQYORGAidYhDgdtnaqLGjl91Qze1ZjnwdbskOUlV7co3D?=
 =?us-ascii?Q?9XV98UK1CkG+FzFHErXzHk7krq5oP5asog4eT7gjsWKJkGXsJax5oHXuXhWq?=
 =?us-ascii?Q?yckgIL7ZBGrZBuaXkQxX4JXmqOjcM4CHq3yhrVkHl7TCVc5F8la2mULFi1Xc?=
 =?us-ascii?Q?k8g6B/w8/Vd4La4hdaZIev02u0K1tcRaldg9PXQiMx4MFqL2KVkKn2cOSrM2?=
 =?us-ascii?Q?8D5MFAUHRfHpdVw1QlakpTgc2xd0so+bpodzJqTS830FaJ0VdhsRqfCXFNAz?=
 =?us-ascii?Q?s40AQOuX21AsqS7ErzNIJ8c0MQznyfeW+T/NokvsVmygRLidvGwywGt+Jqxq?=
 =?us-ascii?Q?k7wImYO2GamcNBE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:13:19.0955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bbef68-925f-4087-8749-08dd1df4efff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686

The different parameters affecting the IPv6 route lookup are printed to
the trace buffer by the fib6_table_lookup tracepoint. Add the IPv6 flow
label for better observability as it can affect the route lookup both in
terms of multipath hash calculation and policy based routing (FIB
rules). Example:

 # echo 1 > /sys/kernel/tracing/events/fib6/fib6_table_lookup/enable
 # ip -6 route get ::1 flowlabel 0x12345 ipproto udp sport 12345 dport 54321 &> /dev/null
 # cat /sys/kernel/tracing/trace_pipe
               ip-358     [010] .....    44.897484: fib6_table_lookup: table 255 oif 0 iif 1 proto 17 ::/12345 -> ::1/54321 flowlabel 0x12345 tos 0 scope 0 flags 0 ==> dev lo gw :: err 0

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/trace/events/fib6.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
index 5d7ee2610728..8d22b2e98d48 100644
--- a/include/trace/events/fib6.h
+++ b/include/trace/events/fib6.h
@@ -22,6 +22,7 @@ TRACE_EVENT(fib6_table_lookup,
 		__field(	int,	err		)
 		__field(	int,	oif		)
 		__field(	int,	iif		)
+		__field(	u32,	flowlabel	)
 		__field(	__u8,	tos		)
 		__field(	__u8,	scope		)
 		__field(	__u8,	flags		)
@@ -42,6 +43,7 @@ TRACE_EVENT(fib6_table_lookup,
 		__entry->err = ip6_rt_type_to_error(res->fib6_type);
 		__entry->oif = flp->flowi6_oif;
 		__entry->iif = flp->flowi6_iif;
+		__entry->flowlabel = ntohl(flowi6_get_flowlabel(flp));
 		__entry->tos = ip6_tclass(flp->flowlabel);
 		__entry->scope = flp->flowi6_scope;
 		__entry->flags = flp->flowi6_flags;
@@ -76,11 +78,11 @@ TRACE_EVENT(fib6_table_lookup,
 		}
 	),
 
-	TP_printk("table %3u oif %d iif %d proto %u %pI6c/%u -> %pI6c/%u tos %d scope %d flags %x ==> dev %s gw %pI6c err %d",
+	TP_printk("table %3u oif %d iif %d proto %u %pI6c/%u -> %pI6c/%u flowlabel %#x tos %d scope %d flags %x ==> dev %s gw %pI6c err %d",
 		  __entry->tb_id, __entry->oif, __entry->iif, __entry->proto,
 		  __entry->src, __entry->sport, __entry->dst, __entry->dport,
-		  __entry->tos, __entry->scope, __entry->flags,
-		  __entry->name, __entry->gw, __entry->err)
+		  __entry->flowlabel, __entry->tos, __entry->scope,
+		  __entry->flags, __entry->name, __entry->gw, __entry->err)
 );
 
 #endif /* _TRACE_FIB6_H */
-- 
2.47.1


