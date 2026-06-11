Return-Path: <netdev+bounces-298198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nu6hCwrgKmpwygMAu9opvQ
	(envelope-from <netdev+bounces-298198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:19:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 716E6673669
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:19:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=uB3N4YyQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298198-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298198-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B048C30293FB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE4B408601;
	Thu, 11 Jun 2026 16:13:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68523BD63C;
	Thu, 11 Jun 2026 16:13:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194406; cv=fail; b=Zuz1mfIzrrYexAU1lY0vuHXNEXgseL8Etx0jt6AGJTQrphUSfMDfArGYyaMHowAnpxe+lJLSj0PdIcNK0g/CRhLNw7ho1cXWwTRRj4NzsNO1tjZLwjFmJWKdq1PocSUMTUOqU/W4iicmO6MGnJt+AznTM2sS+lQS56wuPl5TuZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194406; c=relaxed/simple;
	bh=ypS8QY7Rj05XFLQ59O3bbJ4RCl9eiVKDeP+g/fz3QXw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J30EAf++RlDRoUaj7hlmmwaOajhQROSMF8Th5vBkqYUAhaujlG75vs29fM3rypLhhHmlSAkyoLWlf170vfjJtF2ivGcxze2dXmDUd3+mSe6+x6LjiMQ3EX3kOcu85iQBQHPMVM8bf2SUmQzJaM7mg0t/39GQST1NJYOr7HlAzTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uB3N4YyQ; arc=fail smtp.client-ip=52.101.48.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPNWCpc00We+B8Ovlun18Mt/vFJM0Z6QSApjMzHp15U7o11UgoUw7n6u99sD2J6Nzzvu+f89SwxuDNA9zL1CXiHOdIYa0aWJjvI81OKzTtv8A/gFeFQzTiaIsX9w+IrR4/l30obktQyhsy2GA8u/Wv5xVYNCCb4p3R+60hnQ9T7dqav1q2CoJ8qMY5q8ReqDP9X3sKE4nSx5z7MQhkf4QkWW2ErLFn4qZmNjUmhJDMtRoTRttVrqXcT2DZWNdhcRBHM+cGhiDZ7KuP9mB/P119r/qXNLxaFXBvPXeJVHWaj8oicvtmUfWHswktHAvYdNTLO8LQfP13txG+U4xBzm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp8Q2PsHnINa7jYLaqC5EbKsp39OFOAQsUCiLN/NfcA=;
 b=BVacjSm3RQv2Ouk+jxRwbDdsldej1VakLYZo07pMa7wb3UqaraXemrdYegOlIVSa3cMbdofgu6TD7nK2inu6q5xJY/7shD7mhD1I/8srAyrX3VT/9QU/wIi72nrO7TSG/nKLeU1nYzepX2tqdJ6XgxvvKRVgo81F4lfcxqYIXjvnCWvPyoLE+VIiq8tcV7ho1UrRAdLYmNwkQOpUtD1hoEP3xx+hjjkoTSlgkEw4dHX0uSfdvbpZZtgHR40/oHqL05JylDRvokuLD1MsE5rTjK1gHHWXpGzQ+7fNexVrdnNkJ4Tz/mz3nopwC3UTJ4t2fMeVKBbIqo+OrSWdMZlq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp8Q2PsHnINa7jYLaqC5EbKsp39OFOAQsUCiLN/NfcA=;
 b=uB3N4YyQhHotG2a2ENBQZjsHJzlKJyoL2ZKG6p4RxM6W8AzZi7Et+/VNQZrUaavkvjpD/QL5mJ/RTqezi0meqrI0fHzy8zlaRDEwukw2v8MyDowFK3GK9hdZe42FEm7UDZXbzkRBI0/nUQe6uBDyDBEnX01JZ2bb21wKVraVoiRxWwkV1ZysSOZm9QM6b4yIBoRHuQQdg1/qXrZ5A9qA+7Dw3TaYcUEoHmxCm+4aSOjjeBiW1NMP2x0vglLdaVgoDW7j/XOrDd3kYCJXXfrpUWoeqynbr8F7FqvUQbl32KNtbFUu81FYaE28Zw4OCFTSUE786DnFDU1b/j5pWT0ryA==
Received: from SJ0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:a03:33e::27)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 16:13:13 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::a0) by SJ0PR03CA0052.outlook.office365.com
 (2603:10b6:a03:33e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 16:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 16:13:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 09:12:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 11 Jun 2026 09:12:51 -0700
Received: from f43.com (10.127.8.9) by mail.nvidia.com (10.126.190.180) with
 Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 11 Jun
 2026 09:12:48 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	<donald.hunter@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <dtatulea@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] netdev: expose page pool order via netlink
Date: Thu, 11 Jun 2026 19:12:32 +0300
Message-ID: <20260611161235.3807332-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 1759f52c-b6ef-4fe5-fdd0-08dec7d456ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	AhlL89+5UIhhb55VWLh/zEvt+ApBQEIJGH1613f9FUa6q+9EoRIGp4dxzztvR8hcyATkdJiaIWFfqPWlESWURrh6sc/kBccJYGViDFvByyxaJaAy9DTz70NGtb1K9di2fUqzrWuYY/lIpM9kz0IXhxRAS3cFNcI0hYV0dU9TFPB7DC0VnrpW/bSDrhxSGi/PgSwHExB1xOMjQrLsBYm5hLLThHWU+tG8sI4o/BQvBxt1Sip/o4pkNygyVkGvHyrRJdyrs0vADlep0ac80OPrE1L8bvZ7pogGXaoHwaSPOhYCLbLMJPSXOzRzulpgJDCpgLHm7K+XSke6Xz9XO7AYZQy22c4XPCDa66VMXVtCdsA9j4N+03BpgtgWW4toVApFfQ/ajkwAyrcBLzErEdAzS5Je8ylaN5+cgeH2/ROgMXdr5oo1/onK+YL0Scs0gn7Ds/qE6fDdCNLKZp5bKoCjupXUMKj1l4VTX02z/GWA8A2xwj4hC3OJJpOug8hD5uwtLHbByQ26DDIj1buDW1soocUCJ2V1JxnvZ+Tu1KMn1ppEtxE9XPsi4b+6Zo4k4sEOLq2b7oJMnAKmXC1tjRUitkIl7yxsfeWFHZF3ps2C5QW/evrcnq+RxTJzT7D/Whm43cc5CODzPDK5L8otSjiGU2nhBFKhI5joFb3q6C0IH/fpXoUUP0f7AivV4XNNB/kmLWM4g+rk4dGUuUSNPP+B1u8M0BTxE3IPeoHxQpHDkmY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c0tmLus1LGJWmBmhjSdl5zj2cc1K/+o9EFyAqwYA7zwYVx/v27EgQv3t34PRsuRHhGFHFPDaQFDAf6WPEqrC2l5LiQ+YdlhPjZrLks3yOd2t0mThDFAelJdXpuEiByiZiL63RwUmwHtaMSR854JLKYEfc0C3D5FybIadRJO4MUH/IgChGThVgX/PVXjTgrL9rcGOhpV/bNmbJ+zZSIm2a434fTLP8MVm7UbjxSI3KhHifq8SMaQE3Qiq2lHQ6zndaW/sGTPGfpfczsrG3yePNDdYN7A1QjIlEvw56tmQ03T3UNt5AOOuw/Mw8j8D2kQxx8u51sDOpqU+xrFNBv9XUdaMMufWisvihPmq5KDIdv+o86LL9CjgNrAXPtX91HX4iWV8W8jQkbeTt2urhadIBaKm02aDkP5hC5OsnSUtP+16zgwHmYhHlQOkmQoP+TmL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:13:13.5041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1759f52c-b6ef-4fe5-fdd0-08dec7d456ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:donald.hunter@gmail.com,m:andrew+netdev@lunn.ch,m:dtatulea@nvidia.com,m:ychemla@nvidia.com,m:tariqt@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298198-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lunn.ch];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 716E6673669

Add a new 'order' attribute to the page-pool netlink interface to expose
the page pool's allocation order (power of 2 page count).

This adds observability for the latest io_uring rx-buf-len configuration
for high order pages for zerocopy rx.

The order is added to the queue attribute instead of the nested io_uring
attribute as it can be useful to see high order page_pools for other
cases as well.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

---
 Documentation/netlink/specs/netdev.yaml | 5 +++++
 include/uapi/linux/netdev.h             | 1 +
 net/core/page_pool_user.c               | 3 +++
 tools/include/uapi/linux/netdev.h       | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 49862b666d7d..6d8032b64bbf 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -190,6 +190,10 @@ attribute-sets:
         doc: io-uring memory provider information.
         type: nest
         nested-attributes: io-uring-provider-info
+      -
+        name: order
+        type: u32
+        doc: Page pool order (power of 2 page count per allocation).
   -
     name: page-pool-info
     subset-of: page-pool
@@ -648,6 +652,7 @@ operations:
             - detach-time
             - dmabuf
             - io-uring
+            - order
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 7df1056a35fd..4c2e6df2e954 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -110,6 +110,7 @@ enum {
 	NETDEV_A_PAGE_POOL_DETACH_TIME,
 	NETDEV_A_PAGE_POOL_DMABUF,
 	NETDEV_A_PAGE_POOL_IO_URING,
+	NETDEV_A_PAGE_POOL_ORDER,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index ef4261c0e8ea..9536b79074bb 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -276,6 +276,9 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, napi_id))
 		goto err_cancel;
 
+	if (nla_put_u32(rsp, NETDEV_A_PAGE_POOL_ORDER, pool->p.order))
+		goto err_cancel;
+
 	inflight = page_pool_inflight(pool, false);
 	refsz =	PAGE_SIZE << pool->p.order;
 	if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT, inflight) ||
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 7df1056a35fd..4c2e6df2e954 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -110,6 +110,7 @@ enum {
 	NETDEV_A_PAGE_POOL_DETACH_TIME,
 	NETDEV_A_PAGE_POOL_DMABUF,
 	NETDEV_A_PAGE_POOL_IO_URING,
+	NETDEV_A_PAGE_POOL_ORDER,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
-- 
2.54.0


