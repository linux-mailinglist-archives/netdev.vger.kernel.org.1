Return-Path: <netdev+bounces-84170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04AD895DE8
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 22:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3738AB2862C
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218CC15DBD8;
	Tue,  2 Apr 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FBEbNgcr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2138.outbound.protection.outlook.com [40.107.243.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DD15D5CA
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090419; cv=fail; b=eJciH7RxNa3jcxi4mYgeLlwlQRxA+ySROBa1vVnPZzgdgd+9hIvwa1zp0h5X2trTxuuWkav4TyzZU8QjxcT/+3Lr66ejz/Epi8fanfWoXkw7r2Uy6D1zOl8Y0LFjfd+YOD2mQdU6vmZa7ESxc6Zv84fEXIUmA3di9VKhXY0kUns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090419; c=relaxed/simple;
	bh=CNAzUr4GyhhisfblkF/c2qTSaiAj6DN7DqMBTN+YdJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JEw5wiQG2VuG/A4REt7vffeLxAgRFO29Jmc++njvu8symj8GbCdAJcYOvSRdbqPR7NYf9zBkqz8SKVwjfDE6kHSOqFwEX2B+Sz3ZBMbeWEZwJhSWalibj91wu39WBczftz3SSCue2ZER4yi+Ya8cOOIfCgTHxtTN6VVmmemFQes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FBEbNgcr; arc=fail smtp.client-ip=40.107.243.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK7KjKrWwkTbIVid7XaBYxInIL/ulhX5XDVUeF0gWJrgWWoHCZgYPMpUkABfPjBIc9AMoqR0G7pIsGpHHSfSVMFGJYz/+7IU0CCRLTWz653DaWlQTWoFBuTKm5rZj2YZ1u9VcvrPXzMz7gLRfjKM9u97PvYUahLdbNqwW9LiSXmvVc1skTmba29DcAV1Yk0Z11K6EYZFEQ6RUYYDSTwFE/Nn8GtYgvjYnK3opbkAKWWRIpkfXKw7OUuSlByTxUsBj4Y5AxgGVF4xF/CAZzPUQ5V+hTKB5mBf71T0FqFaaDUA23iBgOps2JiKEakk7ngR34I3SPjQRxd/SGyaPRbEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXZtvN1TXjwbqsyoBsYP95PkqT7reIHbTJbL59LhaDE=;
 b=MDinbpRPI52Qr/UOJwt21TY6Ra7K/v2jcw0AgG0FvfyU65o8WvbSr1nZPHBBr2Qf8D7SURLMBGpo6A4lty88NsJDx7v7wFD9fliuLQeBVdO3yyELKJBj9FUpErhNb79poVw4kfNVDxkOgMWZ2F7VjlCVNkvpMDt9f/Tfiq3IzJT5N5IQvcn0GMyDNIgaMBHkSlDoPYfHd1H21+4Bk7sjutD3o6jCmNa6LshZ0350lp/Fn8T63JOYNuzljj/EXcgPNztp9Gjjhzcs5U3G2N3+rXuj127zEhCIcoWXLbs1h//45ooCS3ETBVSIzIO2xQ2VbeWvrV91pKkEv/m2PiAjvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXZtvN1TXjwbqsyoBsYP95PkqT7reIHbTJbL59LhaDE=;
 b=FBEbNgcrbY+yfQ6W6g+7wDf8w9FV/+uezjYVkH4fv6lMe8HZjFioGjeZjJhnpqVoIC3SilyttmAeXZi1SYQDj6CiJPXBbnBja9s2CXsHP8Bc/pv97TO75kHOUXoOGS1rwLLYDmncMTa2B/tRL2bIbuwGULui7Fb3Wx3W0ZnaHQAM9lIw+xdIokzT8LWmTb11BaNGkFD3zamg5RCUTKZmM+16vrr7oEYfBQGJBTcn1vaS1cxgm73H57AeWV9qIvooDNAKRNz3G2Dk/yVqR68JfIsiP78ntqNKtqZybWhYlkFhLXuw5V/56BEZFYYTtJK0nd/H+CXlxtGUkJBbvUvRog==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 20:40:13 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 20:40:13 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next v1] tools: ynl: ethtool.py: Make tool invokable from any CWD
Date: Tue,  2 Apr 2024 13:39:52 -0700
Message-ID: <20240402204000.115081-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA1PR12MB7541:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AfgHNG9rH9bVhlYWzUeIvnMZFmliHx9ify2Shyf7XbjRUmOC89e0knoDpwiHQLRp+Z4fh9zGgXgGImHDGTMt/KlIYTzjG4xbwhKhKoxQMcm45ebhx4OXNfTeqZZJJi4Na/CZAHyA14rZafw8OGUWq/VB8RBpYDmuiCqEfSE5LFk8OR7tnVZrMGZXnXvKs19QNsHnPHohAYi4LpdNhSqdtgGAJAZT5Sw9Leli2r8JymFIWGP7mrsldBpcebKPkNrJeJicidaKoh8sNT1AFAFTYPb2AtjI9pkEU4sG6pGRys12zCB8I6l3W0G4bd1HjYqdKPlNK9e/zaOrfyrkRQUt1b3jcysjEjsC1DMqWI96HaClRwNK9ZZGl1jLezC5HktayOFQUX5gi9ZlD94WPdBc1Bn40WZd85ctRuXo5sJzS7WHhZTantdZ4ZpPtsrHPIHbDWEcM4Z/cSWpH8IzWGfj65U8kWZaFZSyWllUqxCHnpU22sD7FFN/Qs/Y1rEwYUxnjDTrlRSzebqJMGrzaz8HHX80Kn9MUdqkplOcSVVmZpNaRUBjFt5qsYe40fKLzvVVrTL0dDsdZesIq5K+O1PEF2jemIW6kC+dcXGILJ3VlStXFj4/f9cqkHcYLoV9bL/EcdG3M3slel5VFz5f6/Bw01xcQ+EJW98Pmp/DVs3ToCY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kp0Od9EftyduoTISEVGNsyaa7RWMznMP5OchGdUqRRI4mWvy6qeP7SDQZ5Xo?=
 =?us-ascii?Q?/ydb6GiykzdfejSzqFabHyp0/owaPoEjQawkF/iZ5AvNFGrsgBHhFdt3AoAA?=
 =?us-ascii?Q?x/jpZxTLlR7FhkmHIqpmZJl4k6awXRaEDQbMDcKsD05fg1YCeBRjLduJko6A?=
 =?us-ascii?Q?szjiXuHyssf9pF0rELtsDi/BZN57uSZo4lzcl+48pJYU5Nwg66SBMRY+eXkw?=
 =?us-ascii?Q?QYGiutQBh0y1J2dBt+E20taWepCmhSsh5Jf9x7r5QOcWuGOi2HD5y3hlhzIL?=
 =?us-ascii?Q?CWlouU4YHbEyTrJRz/lSrH3c5aJ7GuO22OB9ffDU2t/s285ynU3Q98YbQI7L?=
 =?us-ascii?Q?AGw/SrOk4jY+JUkRQ/2VLB7js7vS+VSKdjLdkpP8Z48UDRo3J48dA2R6iOzQ?=
 =?us-ascii?Q?eUWfkfte/T1Q7V8GRwqinWkRLe5KCECoRoTfBdG7SI6d65dmMtGQyoNjGNxq?=
 =?us-ascii?Q?g8f25gBhc5VE6/jkpUE2PRtZ4+/wIYp2p+j/4MT+y8j3DRtzIAynj8ZHSw4a?=
 =?us-ascii?Q?ldh+IXwvGe55661IQAaIaRVGX4sgJQFSXUspni7wr25wobczxzYz9g7ovifS?=
 =?us-ascii?Q?oTmEjnG5IZQXzQwBc/xKQrXe/1Y+woFCwAMq8Xi8jipnYWX7icV00TYRJLjw?=
 =?us-ascii?Q?EGo12vi+hN7iuUNdVvzbxVpfMWccZjucKhcHSx+04YqmEhhkTO33E1RRs+mu?=
 =?us-ascii?Q?oAvVEbxNJob2xajdLp7hLDQn8rd/W20GO9Ya1cJoIUsaSbufQq1sqf+4ikVo?=
 =?us-ascii?Q?YLUX0fMBjCT098Qoq1nubMmZTSES5B/i9JnvBxNHd9RWTIoDScZ9R7Ih1km4?=
 =?us-ascii?Q?HuxWiMyygnTsAZp/TCumdJP1yiyECkGEpsozLlYjfkTEAnNhIuF7SN8H9nLL?=
 =?us-ascii?Q?rXXtgwkUAWIS7j9n5w7igSwIDD98Ufz1nIWhMgUa84pWEskYG9xPLvAxSoJm?=
 =?us-ascii?Q?ot2yjb7F6+YECBT68LVV6bH3fS3fEDRyHIkkRVkUPUkT0dE/u7ZptQMM+Kab?=
 =?us-ascii?Q?e1g/6L5xtQ2QHhiA9Etqrg3osKUSWbwsvV807em6zqr0IcmhW6dBzOe8QR+/?=
 =?us-ascii?Q?Y5+4zer0WftGbbtagYa9t/rpa/oxFlxqHOjUFEuAVkh+GzrXpJt4sqmFoT4T?=
 =?us-ascii?Q?tXisr07WBpKstVYOUM0U/BtE11WNHjmAvsZVEt5FykPuRlJ/5QJMnDWMRDl8?=
 =?us-ascii?Q?c8Zg0um5fKBpiAf/+PRdLA5mPDXI4tlNFrI4u7fA5XijrQMip/PJMQqiQEJY?=
 =?us-ascii?Q?5UFeAGAFyJw0jtMPUyU9sxpyVAySSWs1fpo/TgKzxYl5jCk+8/q64CphN+y1?=
 =?us-ascii?Q?cjjMzhGVkrrUvuV+gKVrVoKTrtDX6zhutZXWQs3/rX79FoDgrkOAJI5DEtwY?=
 =?us-ascii?Q?zfDNLP7G45Nl0YMjhFPVjU3Ngh1Y39eDPOcyReTbp/Unib5cGk6gPm6BUP5X?=
 =?us-ascii?Q?OzrBEk9j9I789J2+Gc3Hnmo0CGliyi1tuSOeLhNfDjVzvapapqr+l4razdxE?=
 =?us-ascii?Q?1XfsGhrcnpfLmsjgBEyCRE3r/UB+FiVnlvuCAOcl9GzvtFH9jKLOOQTm2pYJ?=
 =?us-ascii?Q?eRRXXEaAb8LxP36BjsUD0GyV45nOOX/k/kM+2wTVJ6BpS4zqUG1wPoN7qj7t?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c850ccf3-ba4e-4478-f4e7-08dc535518b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 20:40:13.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiqp0RoN3Yt7KbY+hSBeP/yL3/b4p3BUzDrSrPBEOdemXxMQwEPbn0e86u0fymsTbvaG67LNC/KtSrlMQuctTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

ethtool.py depends on yml files in a specific location of the linux kernel
tree. Using relative lookup for those files means that ethtool.py would
need to be run under tools/net/ynl/. Lookup needed yml files without
depending on the current working directory that ethtool.py is invoked from.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 tools/net/ynl/ethtool.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/ethtool.py
index 6c9f7e31250c..44ba3ba58ed9 100755
--- a/tools/net/ynl/ethtool.py
+++ b/tools/net/ynl/ethtool.py
@@ -6,6 +6,7 @@ import json
 import pprint
 import sys
 import re
+import os
 
 from lib import YnlFamily
 
@@ -152,8 +153,11 @@ def main():
     global args
     args = parser.parse_args()
 
-    spec = '../../../Documentation/netlink/specs/ethtool.yaml'
-    schema = '../../../Documentation/netlink/genetlink-legacy.yaml'
+    script_abs_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
+    spec = os.path.join(script_abs_dir,
+                        '../../../Documentation/netlink/specs/ethtool.yaml')
+    schema = os.path.join(script_abs_dir,
+                          '../../../Documentation/netlink/genetlink-legacy.yaml')
 
     ynl = YnlFamily(spec, schema)
 
-- 
2.42.0


