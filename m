Return-Path: <netdev+bounces-256847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OpTGSbLg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:41:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD486ED08B
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 362313014130
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C5372B4D;
	Wed,  4 Feb 2026 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D1ZQu544"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C034C81E
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244821; cv=fail; b=VOmyVdaZ0sY1u0NKPjA5gfyp3apfa/wyHjUMyhvLGUnT9QMSUCZkw06suEi2IBWqYfobvG5BekTdHgXvoCC/gQ/DdW+SSyRdsfWFpDC8m9Wvqu2vJA36OMu72UAiAarkabxGKeF7huijuJI4uiQJmZSmyJJ9w45lx5Sf6w647/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244821; c=relaxed/simple;
	bh=koIdumn+bsANlWsTTZsp5+kDwwTSl19CxXHOw04niTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Njgj/ishu73rv7ErDsy4yAgJDv8c1muqVDwMx18IIUuNk5rKEyfmfVKZJmJK8+YecRvAkkm0tjkFCLYNcWXTkzd6rV1hPGQc1qCy31uceyK91E5y6ZNcBMlALoRJytI9LNFQPnhIPwreMdKw5uH5TwcFhrr1SY4VxvWJH8Sz3fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D1ZQu544; arc=fail smtp.client-ip=40.107.209.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E840/7TYHX0Sjs/8FYmeGyGoz1dHjcje+SkreC4Eb2XtpUTjaqgsMqWgILUrW9jxFryuJ08qK7ZfavdjoiJ6Jl5HUOaBqEpoPG004LKdL1I3z7ZtjP6uDeF6Jnw3OHK1pxVOg1DtmCc8SikgQtiHwGxvSiZn+4Lwr+gJYQvt4Bt3D3vuBoBLH43cQxM/AHz14vOYEQaHTa3uyql5wZdDElaKnhfLzdj/DVbDRn5KsWLQCuX8CvRdSZWxhP5ICsx5UUzSRnnlnBrGhL8aXDDzotfWDAOcH0FiINTt59TYxmMHc4z9ttM+Go8hAbn6aXYgdpsx/unpvKVMhYRbcjXoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddNXhJgFhhMBXON1lOFUvYm/6YkkfuIS5fA87IROJ+4=;
 b=LVWi6+pG/FFafnZXYSuN+I4O6/+WvPl2aH/MFK2iKMDNKHlzkLlunBc6XneGM4PU0EtEiTvZHgB8scAlzWZRsAXaM+DaoCyrx5z8foDMr0CruGtavBK6em2DLJPZMRTVDcKfq7dpzy5FtwZN4CJJ+IYZMp4wrXX392wmroqSd5oygQf3a6vpGxqxPrhbiYaFcbYLwM1U2nvEV+R2NK7sXx3Hrrd1OFkgd0ccSFASkLS46PDrCHp9TrXzp8CF63/F3c3JelBROQBQPUKYZrTgLJ9Bsig9GufEAiYQCtRw1DA5FTNwwNkoiSXCqgUYwHB/DIdUH2h4nbNDuLRfJof7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddNXhJgFhhMBXON1lOFUvYm/6YkkfuIS5fA87IROJ+4=;
 b=D1ZQu544Ng4nOmLyVfTeWPHwhw3C1q36oHr8o+Ny/2epqPdVMLavwHN9nvk1N0kxQVR1UXNDE320881jH4So2mqu9xelvpCO1s7XlcCH44bU7ZRO4qi8tTA8Z3+XiGg9boKhETdGYkBNa6/4azLUzY/AFDlFLb1t/Ku95FSKzrWoyd7SEXytPp2wR31Q48/ePh3Z2VsEKLglu5YGyO3K31m7FpAvvDI19unnYwDyGHsPf1DMj3GpZbCItUPgbXVfyrGX+2eAFaujDkZ7CS0um0PvdjvJ50tnUEVvBZhFhtNNyziaw7GDNO24eAMybSd/Nl2m59qM5HGXAI7vvn0O9g==
Received: from BL6PEPF0001640F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:16) by LV8PR12MB9617.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 22:40:16 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2a01:111:f403:f902::3) by BL6PEPF0001640F.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 4 Feb 2026 22:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 22:40:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 14:40:03 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 14:40:02 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 14:40:01 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v19 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Wed, 4 Feb 2026 16:39:38 -0600
Message-ID: <20260204223940.39581-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260204223940.39581-1-danielj@nvidia.com>
References: <20260204223940.39581-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 9480aaa9-7b14-4ade-d8da-08de643e5e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w3E+ootkdgcov7ibK5P56pBrPJVAakW2PzM3HPj/bA917PTPnVyxDqMsVaCN?=
 =?us-ascii?Q?LYbC7gwagSyn12OLruyrmFOciQjb5uZarJzT8ZyZUwuHMjFjeRdSBDZ6F742?=
 =?us-ascii?Q?LvAtGkbGYS2dTFEsKW0jUCzky+uaWGxNhS9IeCWbUHreGpL2cANf9phlTBxv?=
 =?us-ascii?Q?AkN7TyUdTKTCh53zSRWodnZJ2KfJgzDHGyj6Y0APrhrypK0Wx4MNDO2JseMU?=
 =?us-ascii?Q?sgfs/BBkxk/TNX21RDYtbXU0TJcIvVbr6CgtGLxwXLO05tRhlkoZ3feXlMH/?=
 =?us-ascii?Q?qpIcd50WVh94o3eXEB08j5IWnu9Fj+v+NNa3MuEcHd107PMmmJ3x3lkME2sx?=
 =?us-ascii?Q?RTXpBEd4rKwLWeQbNbi6k9gaBXAMllfDb/cFk8P+r1Sy2ZDluYCLQXlLmKb7?=
 =?us-ascii?Q?wPceGX/t0qCkf1MDTLejr4Edf1CokOyh/Vlafw9I+qvRQJBw3m766OucXd6B?=
 =?us-ascii?Q?Wv8fDPxdhXpwEEQXbv/Kdad83W/ZbEaIe4f3MF4kJn8jqu9J+s4dMWxh7PBg?=
 =?us-ascii?Q?ZGWGkjVcowF5a+kFnw7Q3PtTn3EM4y8737K4xopNI+fmLmHg0f5iDFaxMw0N?=
 =?us-ascii?Q?9wg0IWRb1b6CkIGqIV1pbRbhi2y44W+L1ex4EumKae0uIpfvmK/ipLuyX/fS?=
 =?us-ascii?Q?0N147CY77G3DBCzA0Id7qjMkDzIWnJxQ5N1Oimg7qburMa7o+iW9Hw/1FBEf?=
 =?us-ascii?Q?F9Igt7JFebZWPfR1gqcKy9ZpadA7MQVDbyCs5THawMWA4Ajb0fOlvCORgqD3?=
 =?us-ascii?Q?lXi2m8zvUFGgd5ZgzlDJpFtC2JX7b1w9Kn/ZnvcBV41MYCO+1idHXu25eS/s?=
 =?us-ascii?Q?PTxlgVQSTpyA2wlgykbgZB9j5sl3lNjMOqrNkr2DWrfL2kMUBKrxTi/+EZn/?=
 =?us-ascii?Q?y9GfTVELhG+R0peXcas2xmKbEBW3KdxR/ZteiJkaKiDVQJrtjlDM5/Ri3u21?=
 =?us-ascii?Q?CBLVWfzq2O+orWlt++ruCHwaHq2rlhWvAe7CJD8Dp1ZmtHQURZUbJcyt42C2?=
 =?us-ascii?Q?pQUcStBK+dQcPOTPC0Gkk46O+77gVB2wIxQuBWXITLd44yG1i+JlO2o+npFK?=
 =?us-ascii?Q?sT3bHPfOwhROq42QzGJEBXItm8lXquqs1DD983vLU6BemZHz9sq4wYFgbAsZ?=
 =?us-ascii?Q?fhuQYb8FX8jL74awM28wBnIB4Ey3pueNJaaebT+6uJH6bUy+CHS1sAxYYi3e?=
 =?us-ascii?Q?naIQUTewkvhyj5OOuU6dxTPBt2w2EGM8RvqCQicIAJMFf89uNlWOIvqdFiYv?=
 =?us-ascii?Q?qTADOtmq00Hi8fL1Z0elaGws5sBkAz7OVDMhCm2djxP4CevXJ4QWl11LX2FE?=
 =?us-ascii?Q?wbD/KnueDJgiiwzJ6NYmAdcnEOVls0W9FnAlbss3cKTxPkNeU0wIbKbTfZqY?=
 =?us-ascii?Q?KxsWGRj8d3JxWSQ42/cFPIAFzaB8HDgoDg3m5l1EsofiXxQ4nlHKyYLUuLJA?=
 =?us-ascii?Q?phOLQycJZIlTzlXawaLWv2+wSOK+RDXPtJDcfVejQ9ap1CArMW3Vt4S3CzcW?=
 =?us-ascii?Q?OliKH54U90o+Iv6PdwOSUUpfmVei29WhgWgqw4+cSdTpqY9h24R2BaManhJz?=
 =?us-ascii?Q?19mdxFWa2sGfJ5JhlHBWvRZKDJngLtV4lCC2myNnNR06CD2a2DiGq9CR57mw?=
 =?us-ascii?Q?nGt0q/LBrgP62iaoaBzikRjvHXJl66fFvxAHaXqZviJqQ8UfzRXqBQc59ZrX?=
 =?us-ascii?Q?rq3Wmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2yMUSJNZxvCvNJzAJxMMvZLUzCarE8GafPaaEpzZ5CakWLIjuPC35myDy3tUmtV7eHRzC7amtXyWwzTw0MiqJCxVS/BQRXQWz+VuzC2vhHsyBHq9y/Y47TcVG7pXQmRobcRtH4AF4Cs3Wlb3ZvxL4Eqd3VXYaM0Pb7WZeCJQzVyLMKrbMQ+ceCOMcJ+kV0i/ILx8yvpXvPal05WG9f1kMrn9mmCw7YJrh2EyXyCcvHk3QgaiyHzp1foeuBjwOZJ9Nc5UFHDoxURCHAIbqMhw+X4FVcEBHyZN90QcoEXlz6+PPXLWGPPPD0K7ZoD/vB/lXytvRLXbFM7Jw9HrMQ2lADRXAVe9sDlXdIczmWiKAsrhswkWyBoeJwcuX7ftNe5oaLhol4TqLfcb6+NtwppgGKTA3QFWjoRBWW6tjiLbCGmPuauyDIfjOaMwjyQlMoJk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:40:16.3772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9480aaa9-7b14-4ade-d8da-08de643e5e44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256847-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BD486ED08B
X-Rspamd-Action: no action

Implement support for IPV6_USER_FLOW type rules.

Example:
$ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
Added rule with ID 0

The example rule will forward packets with the specified source and
destination IP addresses to RX ring 3.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: commit message typo

v12:
  - refactor calculate_flow_sizes. MST
  - Move parse_ip6 l3_mask check to TCP/UDP patch. MST
  - Set eth proto to ipv6 as needed. MST
  - Also check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
  - Remove tclass check in setup_ip_key_mask. If it's not suppored it
    will be caught in validate_classifier_selectors.  MST
  - Changed error return in setup_ip_key_mask to -EINVAL

v13:
  - Verify nexthdr unset for ip6. MST
  - Return -EINVAL if tclass is set. It's available in the struct.

v17:
  - Fixed portability bugs for unaligned reads and writes. MST

---
---
 drivers/net/virtio_net.c | 105 +++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 92e34f51737c..a4e46b767553 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5852,6 +5852,40 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip6_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct in6_addr tmp;
+	struct ipv6hdr *cap, *mask;
+
+	cap = (struct ipv6hdr *)&sel_cap->mask;
+	mask = (struct ipv6hdr *)&sel->mask;
+
+	/* mask->saddr/daddr may be unaligned; copy to aligned tmp for
+	 * ipv6_addr_any().
+	 */
+	memcpy(&tmp, &mask->saddr, sizeof(tmp));
+	if (!ipv6_addr_any(&tmp) &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(cap->saddr), partial_mask))
+		return false;
+
+	memcpy(&tmp, &mask->daddr, sizeof(tmp));
+	if (!ipv6_addr_any(&tmp) &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(cap->daddr), partial_mask))
+		return false;
+
+	if (mask->nexthdr &&
+	    !check_mask_vs_cap(&mask->nexthdr, &cap->nexthdr,
+			       sizeof(cap->nexthdr), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5866,6 +5900,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -5893,11 +5930,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 	}
 }
 
+static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
+	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
+
+	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
+		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
+		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
+	}
+
+	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
+		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
+		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
+	}
+}
+
 static bool has_ipv4(u32 flow_type)
 {
 	return flow_type == IP_USER_FLOW;
 }
 
+static bool has_ipv6(u32 flow_type)
+{
+	return flow_type == IPV6_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -6034,6 +6093,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -6073,6 +6133,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		++(*num_hdrs);
 		if (has_ipv4(fs->flow_type))
 			size += sizeof(struct iphdr);
+		else if (has_ipv6(fs->flow_type))
+			size += sizeof(struct ipv6hdr);
 	}
 
 	BUG_ON(size > 0xff);
@@ -6100,7 +6162,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 	if (num_hdrs > 1) {
 		eth_m->h_proto = cpu_to_be16(0xffff);
-		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+		if (has_ipv4(fs->flow_type))
+			eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+		else
+			eth_k->h_proto = cpu_to_be16(ETH_P_IPV6);
 	} else {
 		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
 		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
@@ -6111,20 +6176,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
 			     const struct ethtool_rx_flow_spec *fs)
 {
+	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct ipv6hdr *v6_k = (struct ipv6hdr *)key;
 	struct iphdr *v4_k = (struct iphdr *)key;
 
-	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
-	selector->length = sizeof(struct iphdr);
+	if (has_ipv6(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
+		selector->length = sizeof(struct ipv6hdr);
+
+		/* exclude tclass, it's not exposed properly struct ip6hdr */
+		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip6_spec.tclass ||
+		    fs->m_u.usr_ip6_spec.tclass ||
+		    fs->h_u.usr_ip6_spec.l4_proto ||
+		    fs->m_u.usr_ip6_spec.l4_proto)
+			return -EINVAL;
 
-	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
-	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->m_u.usr_ip4_spec.ip_ver ||
-	    fs->m_u.usr_ip4_spec.proto)
-		return -EINVAL;
+		parse_ip6(v6_m, v6_k, fs);
+	} else {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+		selector->length = sizeof(struct iphdr);
+
+		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
+		    fs->m_u.usr_ip4_spec.ip_ver ||
+		    fs->m_u.usr_ip4_spec.proto)
+			return -EINVAL;
 
-	parse_ip4(v4_m, v4_k, fs);
+		parse_ip4(v4_m, v4_k, fs);
+	}
 
 	return 0;
 }
@@ -6194,7 +6277,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
-	if (has_ipv4(fs->flow_type)) {
+	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
 		selector = next_selector(selector);
 
 		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
-- 
2.50.1


