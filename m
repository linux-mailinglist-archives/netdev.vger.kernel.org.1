Return-Path: <netdev+bounces-299345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vb7kB7+oL2rwEAUAu9opvQ
	(envelope-from <netdev+bounces-299345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:24:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B706842C7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:24:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=n1s9GKJF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299345-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299345-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 928D63001C58
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB9B3BCD26;
	Mon, 15 Jun 2026 07:24:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD6279792;
	Mon, 15 Jun 2026 07:24:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508282; cv=fail; b=fwa5CKJirnKpLJjLmXJ9ZrCH/2Ig9wks07bRTaGxh95/hwBp8XeNTsi6xx2UDdJT0b8GYMUWeEAovajRbarDXCeRDNeJPrH8aP5BQclQVmq0r90Zki+XgWdeT1sbxI+mnnbG4+U9M2GpjU4xwWrXyj323LMZekh/N1EzF9eVmLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508282; c=relaxed/simple;
	bh=1nQ7UaUkdtTXQ3vKFgV2TBjRQ8huaOhmHVw5E65L8iI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fp9u/wVB2unRIehK/WAwPtgSnrFdApQMgoWjfo91CEIRmKIkYPxf5kM1BMDZkB6//5cGn60I0sudZji98bU2R5jYAfL7HBP3MDpNvm2GirzFkHdEQ0hXqWSHETzOgRMW3jEv9bxmSYXSaERfJejRUukqbo8d0bmRaxDkD3HnwiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=n1s9GKJF; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPE4HzA7H3tFhcshjLsid2HTVTooEung5A2sE2hVzvEC4jJszupJKqPU+jIZ6ZpQDr2sQyNrofezovxaIa6EbOE9/SnZT+ay2GF1+SquFv5Yca2gtIo3qUjv/KHPLNC8TZTxdocmLOLyxNT1g+nzQQjy5lbWdKsswqOvFv2VCSgmQVmxrDeJ/PujCybIfspKvjfl2HCIUaW8IjAy9Dz/4GJyZFbUxOuZO7rokY2LK4uOL0z5K//LIBwnLpy2+Clh6jPbvyNcOXlP5pmD8BevEHzXc5ZWdQC9U7BeLPomBiMVA+sIWWWUUIAiyH/BHu8prFtaIS123qJvbwRYqkmQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QzLVHeg1muNLj42jjICgkMx6QV964jMOA/+g2O6sls=;
 b=wSIgJnfDun5pej2plo4LfigeBIhMEbqRGYcD+aRD+FRAV/mgye5icjFdfVBoFae+Jp5M/IAf2ekh/E2PgmNiFdfRL/6QUmRbzrBvqhxBSJ+CYnZ8W4XoxQ+M73PqdIjq1hnXExK5wZhR34XTMmKSXgU71ooOAJUEwDiiDEZrY7DMPTe66AfIQvazuIYoH1orlJpxBifDc0lbkPIQdB9ctGimGtP4PxHTwmedImWevExZQIg6lZE2mcP5Zce/ZegrZqb7DjSNnXcDZT+QLBg8PvPz0Yt2c9B4TsyDDl+X9XuN2A3uwb3wMBIcGOp9zHvIjbS4B5J7DsvJ9hCs20a/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QzLVHeg1muNLj42jjICgkMx6QV964jMOA/+g2O6sls=;
 b=n1s9GKJF2MyWokek7vi+E98rEVEH3FWFXx489Fvqtve8c/ZP4z5X0AmS3MEahKw9AZWNKw6lRbZ9KCm5siL1iyZ6GhBLOsnL7g+kh8b9dHJGsN2lSDtLlE9pCYGF/s/1dmq8cLRQWII1MRtMDCpGISZFM7H5bpC9sVlDrc7Ut/xLjjnopkcT3oF5scfBtEo9F/1QoCHIHSbAyVWvM/NdIDJphdqUd7e5B1c2EuwlQg2XvyNA28hpNqU1aJ9Xvf0W+qiJfiixYNWNyseJuXCOQDZjTHEvZoK3QkqRXt/DsUutiqSzGuKyqK8jxu5Dq6Yh5zPCqotkIiHkBviG6rn+jA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH8PR03MB989117.namprd03.prod.outlook.com (2603:10b6:510:3a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:24:39 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:24:38 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vladimir.oltean@nxp.com,
	faizal.abdul.rahim@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethtool: mm: Increase FPE verification retry count
Date: Mon, 15 Jun 2026 00:24:36 -0700
Message-ID: <20260615072436.26128-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH8PR03MB989117:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f3ebb0-a95d-4ec1-8f61-08decaaf28a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|55112099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	wL93QonMC00qKq6e8LO3AX0tYpFVjEJ2p8utVkA0mGr1JpRl7oFcJVKKHrlNEZ9o6uS/8NnXIHxxLH6do/DPfJIVw6xjCOTR8fL8IXS2vA0h/9xe2aNQesVonfoFwDM1xMI3zven7lFSiSipZYqQsNk5DWjTDVOInr1c53a9/Q72LBkpIhb0GWJVFrBtC2u2AQKFJwjIacI/etyNofbJiZ8yu0uhPnM6RHv1zo9Ehc49IMJ/+B97u5AOwHtCYE4vW1AZXYp20sTr4XcHcRswtyGhsox8THv8jvqIehYflgsed+7ECtHdgpYeXpCJluGIO+LMlDcjyuGS2L4VgDbR/Ub/A+FU4pNWhxoP3VZ6HuSqf+jZI1LVJEiE3XFTiChpmG5+gvPoS9+VkZQsbx5PKAkmai5XW97W3A968MYvYj7ylmlXxUhpDOOKnFv/YKXsIOBX2+w6PUqmNagdeqkN0tYsLH3SaAlNEfdowNMDfRLPiaFvVx16lAEZf6ghZC+j1x3qeIyDJl+ZQ4ljEDGVZbZhIIun+3asNFU3fY7GPf3sd8myKxfaiKlCmHAU7W8Wz8IvBG+6AbIMSo8StB3zThRycTSptVJfHgcx0ecmf0dtcWY82zuQyPih8aRS6n1sOSmjGg6qG8ZppE6AvgjpSAZyPvZqtVpZYpiLX8pLBx0+uqfoipo7L6vd2D54VSg5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(55112099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZsSHMBYtuPdDitvB8YOGfRwKe8lwPDshDuNnWsWpAlrmSsj3TuCVrtPzYCMi?=
 =?us-ascii?Q?NpIvAMZ2gZX0SyJSCfSiFljuqVjU4EFuYbVDGO7j/SwF9QQJWSom8rWDhpaR?=
 =?us-ascii?Q?dnU6bObX15xChc9hSYSc5fqdhU37+Dn7fniDQ+5wT4OMjsgb1Etm+61QYvN8?=
 =?us-ascii?Q?DUtqFsoo6NxruO12+sRzf1BCNfQSeUBWCjUayZTYq5kcuUbBP53f50FmkzJA?=
 =?us-ascii?Q?PMZ/Hxf/m6LrjXThRi0heWmZQcimP5Jguct/rz9AwYa5uBTkM05T1qgYBE0r?=
 =?us-ascii?Q?p43qM7mtOJab7t3Mi0oP61foVN9fKzivYawmvo/5rXZwap6fwLFIQgVmRAvj?=
 =?us-ascii?Q?yPyiU0ShntbUAqkAHkFpGrjsGs5/Vd1KGPnu3jgr63pSqy8xTPOmlmqB6oxC?=
 =?us-ascii?Q?TN/pyEvBWCQuVd3TF4E+r2UKXPBWclFl00rsc6mdipjOwj1V2ogwY6ts23Pm?=
 =?us-ascii?Q?XY0vFghnWxyh8+dJIjUgj4alhznjuZJ7kltL9B24j6RDNh5uJtF5Ml7sOhHr?=
 =?us-ascii?Q?srGdHqR2dcivI6/3Kg6UJ4flbe35UKc/oUEFI4uIBBW4qcqycSpz2YFO1lHE?=
 =?us-ascii?Q?/xWo/agN+0anz+zjflS9/vygPEcMsuFQKQ6Lx01gr8mJrjVZz101M77kAmBy?=
 =?us-ascii?Q?pOnoaO785/4nXnLAk3CTjwDuiGDeDgxK6Yh8lNDGvDGRaPaN92oneE+EAY/G?=
 =?us-ascii?Q?sxbpFsT4cEfBp6FN4ntFBFqCY7Ok5Pc7T/FIv0erEfF57u978mC7EpLfiSWR?=
 =?us-ascii?Q?vMhHT8f2RXvkrWnRLtryOnfQOHb5FuGbmVaYADC9W/TrcLXRCHjVQ5Zdv+iT?=
 =?us-ascii?Q?WCz8BLcEjQ55/zIh/8hJBaXo/91znVL9e3FIvlS9Mamg8L3D3sylpjwt82lY?=
 =?us-ascii?Q?PSzPDkajyCJvEA4fwkz5kSv7mpRf4VmN8WdHEcCbWAWAOWPIwcgghcmlzkQq?=
 =?us-ascii?Q?XNJJ4PdJaDi1ioLDNpMhGc0Dnpy4LwkSVYyun0k7JwiXN9kfnNtWcIeKDJqV?=
 =?us-ascii?Q?x1ULw19e8wSd5Ul6ymiNjd896WlcqKW9hgtGAlwxFvkG+gOI251/N5FyQ/6C?=
 =?us-ascii?Q?HMWGM/SDjsY/04h9P7XnQZuogjmMJU21OVkGFPYs1JkwOMvEqeJfxLtvQBz4?=
 =?us-ascii?Q?IdaKPsiAa+15d4p8CAILnTAKhM0hjTZgiRF/XK83W4eq2JH7z95N35mhcxsP?=
 =?us-ascii?Q?6tMM9CtZgP7aS2fGLS5A3g9yfVj7tns2pqIQweDNWGtVn/C/NAu+fdH0+20E?=
 =?us-ascii?Q?tOgPt7dNlcTcgk9pmiuXMsjIKq9HsvbQmemxv4+wIcoIciTUFA2l7SFJXgg0?=
 =?us-ascii?Q?eDxzfhRTJaVDemTuHqNmtLXbgaZSlrFglwyyfAQtrg2sLiG7Dd232WB2uKk0?=
 =?us-ascii?Q?9Kn3ajl3p+GosStSsi7WrP6Kdjrt0gPGzgux9dJTs3HcGoBNyJ9DUooLguso?=
 =?us-ascii?Q?E78HLFZNBmxs89A6H7HWho39OQmaS/XubpiwoWmCv3hQM0H4ehXhLh9vFvE7?=
 =?us-ascii?Q?RhQ6C14hlTvcUkhBWbzuYnf3v9Yo2gngAZ7S7QLDq8dx+J/zzjcwUBRmONPr?=
 =?us-ascii?Q?ySTdc/o+o2VHhw42BLUnyAZlNWdVhSQB3iXmhBpMrG7g3/wXw1uMf4DMVQRs?=
 =?us-ascii?Q?AzGc8Dq8GdNhYhv4O3bM6drC2XK6XCTkJFIKPpKorKAVs1ADo4L2+H1eF/7y?=
 =?us-ascii?Q?kPed+ALCyhAQcsXX4eqVYq7mTkQ/SyhtvuKp3kZeqfF2Q9q022YeqqSi6nAY?=
 =?us-ascii?Q?/B/4MeLuG1zYy7iZnBR8M7ZBSFxV/zIqpVGOtec9O4XHWrCu8644AV9uOGyD?=
X-MS-Exchange-AntiSpam-MessageData-1: KOO7PorWwLtqEg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f3ebb0-a95d-4ec1-8f61-08decaaf28a5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:24:38.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P68Sx1Ids64gEva+QeL0OYCv8OUoQlU/ElZxbjgI0clNOSHTutbC6ghAhTXhHE7w3VKm0N9IVcnZzeHX5ug2Lkxh6Tj/fk/BBp5Ps3RO5VekbWjGp5p0zwJAqxsxuVHZa5a6BQHdYFRPEG09xYo/OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB989117
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299345-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:vladimir.oltean@nxp.com,m:faizal.abdul.rahim@linux.intel.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[altera.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88B706842C7

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The current FPE verification retry count is set to 3. However,
the IEEE 802.3br standard does not specify a fixed value for this.
A retry count of 3 may be insufficient when the remote device is
slow to respond during link-up. Increase the retry count to 20 to
improve robustness.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 include/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f51346a6a686..9a1b1f5d37a4 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -23,7 +23,7 @@
 #include <uapi/linux/net_tstamp.h>
 
 #define ETHTOOL_MM_MAX_VERIFY_TIME_MS		128
-#define ETHTOOL_MM_MAX_VERIFY_RETRIES		3
+#define ETHTOOL_MM_MAX_VERIFY_RETRIES		20
 
 struct compat_ethtool_rx_flow_spec {
 	u32		flow_type;
-- 
2.43.7


