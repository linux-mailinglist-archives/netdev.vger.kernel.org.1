Return-Path: <netdev+bounces-272846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DVdIgOWyGm3ngUAu9opvQ
	(envelope-from <netdev+bounces-272846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 05:01:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2110435083C
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 05:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4F1E304750B
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 02:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA9C26B95B;
	Sun, 29 Mar 2026 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PMhy8NHY"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80495261B8A;
	Sun, 29 Mar 2026 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774753151; cv=fail; b=rGNpmhAyNk3qPf6QUQgEr3TRRUEFjMocjFh/GpF3AzQANzJetAd691Rb9YGE60QAjY0Xf93ddArQ8hGH9TkOF/sJCCnMeyp9rsT4uI+8HqUDxFcjauW1aYeN4ZS4oDVZ6rl27N2ye/d8HoLWmdNpW/5Vkm/Z+99iOQzPKyvj3PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774753151; c=relaxed/simple;
	bh=QYBJzJH65YB8tQo0SMmdHNgsWXD7WG7GicaFpOLQCjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BetPqmOTDZ+6kOwpS41sHN6fjYjdbJE9QEz4GI5GOEive8SDKZxkeNE7nkkNMQRsekxTVb6SJACStQrxYZhVJrfy4cn0Pa0n75E71mQiVDS0dvZYD6+/vdFkkNgDfrqGD5X8rnnh0tBzjaxZqsuR1DxlVMzAZs/r/zNHJiduVFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PMhy8NHY; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0m7ivcSLwaPHRVNskbVtLFGbBW6D0ytOywlhBLvllTdw3H5ppzBTK+j2IqmDgFkHUxmHpkjdjxHo9b9masXII5isVR2mxdmYHQO0nO7FaNCTXohtdccstWwp+FYknOgmfATsHR5YasRIt7uRm/38cZmu1GHypho0hmmd4Q+o31XleGZsNdmRuXD/RHOolitfGTN5GJ4QCrrAo7ZpDIVvW3xKwtcuCgE6D2rx5/hC9cNUtsZyn9P+XUIZSUGBapNp8HCGHSMZzwWsat3Fb4c9yxN4r9lfMTVKCKG8rsWVHj2/P4WFi1loVT2Q1C/oxN3vL3EWqY9Pd0JXwxW3LAnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD8PZjXiC2vGg6dm1rUMnBsWJWEIsOc5KZEgfWkMl2o=;
 b=LHOltTWIT3VAK9bStjyHZJoV2wSOw/Q2ynSNVMxgTzLxMSq6q3eR6L/ttcwU09ShT7R1pfb1Rvuk0ZCMwLfgeQZHZgh61t4JYGpVAnD7YUCxXr1YmKQVMgQo1TYYvsin5r48E0EWU+imhUpr4wPSXkaCCJtX7DPBRH+cFHmwdHen6v3fMDFiSS99NrES8uxTyj1TlcN6fC7KOP5cGSCxjVTO3mwZFGtscZs9eZNOTP3Enr2qNmodoF3NgKderJjCe0BpnB984y37jQZyLRJJc2d7Rdocz9XsfX7tc2Ry7v6eKnFtcxcoJ+8Q+82GkVZSDoj19J1MqvrUMlPZ6YhTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD8PZjXiC2vGg6dm1rUMnBsWJWEIsOc5KZEgfWkMl2o=;
 b=PMhy8NHYP4464n3684Lwkt1LVrH1FHizGpxtS9HQ2ctaStOKCMNd1HX5dsYYZ/PoARtfP9VugXo/OO34xF6vE7XjTAP7PbMvUCXyIf6RLY1XfjUE6POIEezC47P3uiyjxUXw8dGmVrWLNdp0RFvbcaCX6XPUum9K2gB5v+H5weE3vGSreHCNXOTx/C7AaOr9uoNkLK06jvt/FhvGE8nliN5YXdxhYO7+IuD0hWtzrH0oFudgxzz6B9Fj9Ie4vDrBNpuCDUuY/KZ4bwR3mCnSa1D8f47ci1Y/6IEuAV+FicLnCDkGmM+mBBNwHYQU+FaaXG2Z22Pq+U1METtSSYs7wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.14; Sun, 29 Mar 2026 02:59:03 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.014; Sun, 29 Mar 2026
 02:59:03 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH net-next v2 2/3] docs: net: bridge: document stp_mode attribute
Date: Sat, 28 Mar 2026 19:58:57 -0700
Message-ID: <20260329025858.330620-3-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329025858.330620-1-aroulin@nvidia.com>
References: <20260329025858.330620-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b91e3d-7877-42fe-762d-08de8d3f226d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YdskAeT9OP+TOdNDe7NMUqoU6Pjgno1Jv3659PRI+nTplED8R3S7PWlNdc7xPrcIcnEXltPs8FX7XW0S3sjzil0OOdg4rMtux2z5oJl558h8r+VCSxuZtgvW6KECdMMFRCoc71t2xtM8XIJyKqK74bMt2yKsrgzB+VxV8WilZhCtc0J4EUKH/hMtHMsYr6Nl8T5jEU2g/XwBQ9FzSjT2m1HZ/aoAemNcdsKkiA6IqvUP7jgnLCg4GddYEt9RnsT2wofEtsRxDQr2VrwhA2wxnivhPMrFHkltd1GpxrakBI9Cjctt9KCRqQYPpBcol8VRUfRFKuGr8N/qwhwD88GcEAG6TMixn4VO9mZ4AtzHMUiCedLhgegpEeV3cr/pD7oGVqR9NCJaSPufSu6ACee7hWGWwHAtBuWm03354hF3GdOptwyYqLoeONUs4KjkpI4nF1NdID9N0wC753iHRxIKOFuZrzl60ZCTMA09GWaIiwE9/Xde29DqXjoPMY7kL4NURj3PsNM9yYNoYJVe1ysv17ooZtpdmu1Iesz+sLtzcqfjNTJoL/sYStAb1CrmBeW6l/A0cmSVfEJy0G8a/2xlx+O1FFzfiVwQFoDqT4n9GmmZ2M4iuJrvBPOqy/y+tDjnnFZljsApw27PwwCqhd+f7KYerfaSG6pxOZME2nx+YfRiNb2pmI/UtQhy1tek8ndkGUJKd+giuT1P8e+iFWeU5MbN9/FKb1rZ5cVu/S45LCw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ufhVRxkK3xAW4liJB3aYD0tH0vJie8UkNWfu0Bxn6IdYBdCcmBQl8ynk8zyB?=
 =?us-ascii?Q?kHJLOnFUL/BVGnGrZUPz995pxiTM45WswE+Xh7YtKjBnnWzzLX0C0URSqCC0?=
 =?us-ascii?Q?J7rYOB1fg88st123x1LuYfr7E4X5N+KmP0qRhhhNn1XNjqTxkpMXkEFI/HFb?=
 =?us-ascii?Q?3cxQ4dg/H9WxtlkUSty3bY0vf5RrDPw+U1LQIGq1hnYIX1lJIHa5+qMWQtCn?=
 =?us-ascii?Q?aEZ0ZsXrBQL/GigcP0IP071mK5pkKkEnUYsTJBuaqAGDKBS495t/Jt1mlZrf?=
 =?us-ascii?Q?mTq+OZ2Fgj3YuTlfHYBnaqxVe+VBR7Ocisl55KAIw344Qvzvl3pOCXEjRZhx?=
 =?us-ascii?Q?bX8WrpNEnjV/z9bZFsN87Zz8KPpqdP93lcCsryxkMovFGFi9sYuwkxkrnMDT?=
 =?us-ascii?Q?n+U/Yxei9n6YK5+Faw6EhaFHEl4J8/TnbIEq2TjsEo68L7vKWmOAK2CkQ0XG?=
 =?us-ascii?Q?v1rTkWe2+8ElG5wNEYUsU4bKFLKn1dbdw4L0uQYTMtcF/9gJ6JN0OY2vIm/D?=
 =?us-ascii?Q?bIh+dtSpH/Sm2nrcNa3v7fAtVQB9lOEPWzS09sxfpsUU6McYgr9jMzMUkz5p?=
 =?us-ascii?Q?Js5ZOmEthVeUCuJ5ZIMI3PtWDOgSelkGDlf/VtsM/0uBebRxNN/3j0w6uvF+?=
 =?us-ascii?Q?tTfwoVaW4Y5T18uZH8u7/IMIjtMjYNMsscNLnIg7Vf51eWpNSlwj0DmZUK0j?=
 =?us-ascii?Q?YjDiQeB0wadVhjpxVXi8DU80m3moOUQOQ5nj9P1Ak+3raYVt0XGf7kLCYRHm?=
 =?us-ascii?Q?WFOdyE6KZgzjB5/8w/hqIhJTSup3P+8il049lTLFsrcDgQSPedO58sqEwcFF?=
 =?us-ascii?Q?1YCdN1tBhhnMq7+vefcyz67d5HELANzOiVKfAsoBkS+GfmVWTDRYBGZ7q1+s?=
 =?us-ascii?Q?sJjpAZZXjDtLArRIWUGEABY3VWwClYrkx+T+iMBsjiNcamHBhFtoH37rkzZz?=
 =?us-ascii?Q?uNPiaTaWwgSztsFcVDCkIBuh91vVFWTXS2dR0tsEpGrIt9MmFE9wQVlteZ/X?=
 =?us-ascii?Q?gnbSWup+89vMMWCX3BQwuapSV1vCSSONa0dvDFSVgSXJfCQnJ5t60YN8iNbc?=
 =?us-ascii?Q?Gf78EqnDCnxxiRDr+bB+r1zdpFDeb9n29314J6Kncb+5g3OgjZq4uNDekJ2b?=
 =?us-ascii?Q?f2ZvI+HzDF0Owgl4+2uWJU7HF8v4FCnJGwIPUVzLos48zUy7WfYGF3pawhn9?=
 =?us-ascii?Q?B4PpVgm/lxcFi0V6gkQdAYRyU5aNqhkocUvxlwvO4p26bG3SgO9bLKzU18BB?=
 =?us-ascii?Q?JQhU/vfsrg9SqEPjRvmcV0oYaRZdk6eNrhcamMtSHsEZB+FGLmwUSPL/9MR2?=
 =?us-ascii?Q?DxoTNi+OZ8OkMDdzNW6P40c6Q/f118pgRqctQCOfnsXmhv2NBZeIvm7tLhNR?=
 =?us-ascii?Q?SYyL4al/eqKEdgZa61UVjvuXVlDuneozYAzAEWfFjlchEQl+T8wR2G7uyaq+?=
 =?us-ascii?Q?OXboHZJVYg8HuCAW5PTGB2H4Wn6lMw1rO47C4cBal5OGLVDNalht+qO6s7Id?=
 =?us-ascii?Q?UOdkSUj9nNQZc+1jGuSAPctWLxZK4mq8CB8obLCJ+nqzqhmNZCGyEj4CyA+U?=
 =?us-ascii?Q?O+6xGGoC/LAGhqoxif3wffG9ATlxybebIyh/tFKH/RIPB77Vw+FtyYWe+DLa?=
 =?us-ascii?Q?AK50AWFr5jgK4W22QIc03itlDLU40R0i+cSHHomf4tiYKrESoGf9IA+ei/x4?=
 =?us-ascii?Q?OqAYwOWIRefDMW0pSao0Yv6d5hSY/rkME3bpf5pTPyeb8YYO2S1HRy/1b3E9?=
 =?us-ascii?Q?8DwSYGB0/A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b91e3d-7877-42fe-762d-08de8d3f226d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 02:59:03.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9rx2utqRMzPjbWDTWfxkyAYaHBU5SXqYOVv+u+oX2P3TDeY5TibTcytMBEnaRb61WFSV4dmc2slZYg4ddyaBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272846-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2110435083C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add documentation for the IFLA_BR_STP_MODE bridge attribute in the
"User space STP helper" section of the bridge documentation. Reference
the BR_STP_MODE_* values via kernel-doc and describe the use case for
network namespace environments.

Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---
 Documentation/networking/bridge.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index ef8b73e157b26..c1e6ea52c9e59 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -148,6 +148,28 @@ called by the kernel when STP is enabled/disabled on a bridge
 stp_state <0|1>``).  The kernel enables user_stp mode if that command returns
 0, or enables kernel_stp mode if that command returns any other value.
 
+STP mode selection
+------------------
+
+The ``IFLA_BR_STP_MODE`` bridge attribute allows explicit control over how
+STP operates when enabled, bypassing the ``/sbin/bridge-stp`` helper
+entirely for the ``user`` and ``kernel`` modes.
+
+.. kernel-doc:: include/uapi/linux/if_link.h
+   :doc: Bridge STP mode values
+
+The default mode is ``BR_STP_MODE_AUTO``, which preserves the traditional
+behavior of invoking the ``/sbin/bridge-stp`` helper. The ``user`` and
+``kernel`` modes are particularly useful in network namespace environments
+where the helper mechanism is not available, as ``call_usermodehelper()``
+is restricted to the initial network namespace.
+
+Example::
+
+  ip link set dev br0 type bridge stp_mode user stp_state 1
+
+The mode can only be changed while STP is disabled.
+
 VLAN
 ====
 
-- 
2.43.0


