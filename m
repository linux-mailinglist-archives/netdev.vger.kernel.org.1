Return-Path: <netdev+bounces-257356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPBBKK8ehWla8gMAu9opvQ
	(envelope-from <netdev+bounces-257356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:50:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 533F6F8372
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B47E3304E6E7
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912733376A9;
	Thu,  5 Feb 2026 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1Z4dNMt"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9B3346AD
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331668; cv=fail; b=GiDQGtGhhN442BTms8IGXQi9PEFasgvkjPon4IZMqoH9qNomAseUl70AZ9itZxGViirpj+Gqc03OexC3inPzCO0JLjxysnnjQAni3U5RGBfQGAEHEI2x+SSOqA3iSPx+17F4zVcfAJ+up4myJy+JTevb3W62/1PPLd9nhxD0KHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331668; c=relaxed/simple;
	bh=koIdumn+bsANlWsTTZsp5+kDwwTSl19CxXHOw04niTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0xZoOHI5AeiX6NwozIB656ZCnIWZ4I0OHofvxI9E8KTmscjWdHT9iOMcIzrBu8xxFlr+JBfyEGOl9F/JtYAeufSa9z0DbBQ0lLEUherlxYf9CEacHVR39X7vDNxLbCsKwo4q7CLYaK5fQg7ryGdXI1HeLYLpYEpNSEoWLh8MCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g1Z4dNMt; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQoJm8BBFJ12Lskdi3DUPFeQ+iFOF3EyqwYtsU0gc+0DoGcBQaAIax/xJGkL8MAfgokZMukwKdK2Ze9YW51JHVlptjSCDgbedmTEZoFdXssn/DQOczOWyBhyahPO/991pws1Glo4IQ87n0G1Nj87Tj7moU64nW9YxEyDogb0cwQdSAjfvM9Ys4Bd15YBV42tWE5XAhbE7hWwIsU23duOfTwaIfsj1ZgvtDJlLYxF8NwWX6zpKxpTZvpRcIFVBel4YkuWGwbgdEvC6Hq9JfsLJ00MLYl8Ez0DU8979wEkrdf5KGCQ5jmMOcRiWC9jVZqhw3Omgkrd+KHy5YXKdTaZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddNXhJgFhhMBXON1lOFUvYm/6YkkfuIS5fA87IROJ+4=;
 b=yg13qtOsBPInJ80yaLINL6ugKsnLd/6ww6BcXfL4BkDHSPyi+yvBDJFsCOAzvVkEmIF2fecJh5qCA25YAMUPzAxrmtjo8mWeujG0tasIAQDIGmoaw1bDfKdl0pEriC128MNQQSXboZG2gIHm0L3wmVDxv7bAbh5yIwiYdjQmdpqvSdwEW4tyAqCnT7/o0D/Ky5lcx5fQL9QET8bPAnNUcpA7L5sLG1vLZ9YlSHBFMXfqVI3xAUZqINUGKmuS3Z/HyKJojg6gkzHewJHbGTNRohnQGD7J7EDj0KvgBKb/hQjWqp/vm5CN4FA2j0kk+0zXG+dGPIv+mn0vAuCZ6Vpq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddNXhJgFhhMBXON1lOFUvYm/6YkkfuIS5fA87IROJ+4=;
 b=g1Z4dNMtKY72kj7DmyKKm71t8qlTG9sJiuLpNInPvkHnWx2AUHIa4lFamVlqbazDuCy62gWIx6w2iIRZh7oFV6c7Db2R/KDaiUD+l8YDuc0vailaZn0uLBm9NtMWIlWsI6Jmw9ur1GpeoiMo4GDDFYAeuUpWJIS+7EHSOaTYVDgq34m/t3i+ITqubqoCQHIi1vaowFLhSwDzHnylRsnj2Yb8nfXXc5iGq2O+NRQZBYcn0KIaHen92l+M2yOhNkAJaGk8jJ5UXcbynaDia+H1fjkqKFXKMsyLbv+lLrLrGPsjzd2Ee7oXJTtJAcwUrGzG0Y3mmfHVScy5XgUYoYCuLg==
Received: from SJ0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:33b::26)
 by CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 22:47:42 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1b) by SJ0PR05CA0021.outlook.office365.com
 (2603:10b6:a03:33b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 22:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 22:47:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 14:47:30 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 14:47:29 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 14:47:28 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v20 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Thu, 5 Feb 2026 16:47:05 -0600
Message-ID: <20260205224707.16995-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205224707.16995-1-danielj@nvidia.com>
References: <20260205224707.16995-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CH8PR12MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: a942b6a5-cd88-47ec-0db3-08de65089279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?npQElfJiZZq6D0UC8TR7ho2GRMO7Rtw2TvlfykCMqXp9BfMp1bPWckFNqWCQ?=
 =?us-ascii?Q?T4Fq8ovop3SPKOFS3EuB+JZ7sKD955lmpdaNULXe7fiZg1/R+DmXv1r3gQ54?=
 =?us-ascii?Q?jsoYfpS3iSdnF9tnEJsUmHWhwLZMUFFXMQnOs1INvQae8K+kiMvHMv3UhSdH?=
 =?us-ascii?Q?ylhItEVI0UmFFCO1X8xC6WzambJxUUV7fMFYEWDjssGycPuyNubohzSsUcqo?=
 =?us-ascii?Q?7jGvMYF6B5e19L15Hvg96pOskIEBR7xfTL1/wcWn4gOTR7GcPmxfC5FOj659?=
 =?us-ascii?Q?zvHvvMyUOxc8JVHxVsxIqV3PRyyHq5wPXP33lRGtO3iOaFnqxt7rpfWQThDq?=
 =?us-ascii?Q?EDi21OywnBmKYfiZOK6KVxnBXgZGvBEJqLeuNHnwoKaedrpDo/UZ+XdU66rN?=
 =?us-ascii?Q?zMMOeRdL2iiJSRG8BV4uqIFSA6HeXGjB6TZ6kO9m7mvYE5l8xiBjzv4oD7m5?=
 =?us-ascii?Q?L4ZYoN9Dm21G4HpnxA2N9ZXjMTD5X5LOXxQ5hjtMMpw1y+k4yPwU6H2UqEwG?=
 =?us-ascii?Q?cYSIMOYd1LFxD6zjUDnhqESH0jKoq6jqW8nFZoT/vT1lw9/s/wTGmUlfS7h4?=
 =?us-ascii?Q?mQ9yBTkZCrDOf5Nk2A3r3MH7jOYxnodhNAuvbAPZRR1Ip6wxr9KJVUmB0gpx?=
 =?us-ascii?Q?aOsLWiazX7eIWI3gx51DoN+8xw8QcLu5p6L53RX198mmibomJWAWygJVdTxP?=
 =?us-ascii?Q?5LKd9zJvJjuai1sQI7hTh/OE9L7jLPzBD4ToW5XBH9qWO5F8EvvWouKkTvJH?=
 =?us-ascii?Q?FIVvKUka0VGsSLQh6WGn9izgP+hOBvtOvXRsnhFJdjzhKmlPfCp1E+1rrvfm?=
 =?us-ascii?Q?krR4SZdV0qGHYavdhV5IdhTcZ1/+K49NIzb46mtKG9w3xgDV4pkVXPDVivVu?=
 =?us-ascii?Q?GSMyHp0X8HpYi6txAVi9Th2P0AIn0bL1GJeLBU8PsWqyYBnP0smb/Wk1t9nf?=
 =?us-ascii?Q?iMpN7fmFDyeMq5zUBBBUdMxtdDBaQqhB4FF0vpLKdAoM8tKl+JFFQCq7PQVb?=
 =?us-ascii?Q?Gib5COPD/4w4s116U1hHeA4zgPmb7dbJf6Z1Eq2T5wKctNtdU7/H5cKHVV8p?=
 =?us-ascii?Q?EhYD3ZIi3F8vsqHkg9ADDPNWDDHsxmgnzs94pCYo6jfVJIETzgUeLK67ezWe?=
 =?us-ascii?Q?xb39cCtFXbFod38IZyIYxWKnDe7kxo5W2zj1hYs7ZIziarM1SBwbPc8V6yjQ?=
 =?us-ascii?Q?E8m0k/Cv01aja80NDTiaORPGMS2cUvdqEGsdGAxa3TpsCRet8TyPEU+h4KmS?=
 =?us-ascii?Q?hpkKZupIRr38DUxO2rFAeWpIwVUIhmasVWG5FSpaf5qd1twxAEPp7q9aJ0A8?=
 =?us-ascii?Q?7x2lW8Jo/nVzMcu34fBlydSXdxOI0VvwPSTsr6Fcfr+JveFiu9nLnbSbhI4U?=
 =?us-ascii?Q?Ygy+cPO8jyhH1BNZSIjrqoPQ23HuIts+JUMPF1YVpdS8ZFTxEz16AtzOWyVe?=
 =?us-ascii?Q?Wny2H0LDHLbPaN1GxpxOsho/6A00LMnQ24bQ6RVo72lld5rT5HeFkUhXdk2O?=
 =?us-ascii?Q?E+vLUDVpmUFLeMFl0poBTMl2xkhqfm7Rwmahb3t3Qc6qtgn4qGGIfHhAo9YF?=
 =?us-ascii?Q?5CayBIllG5I8Gym5P5gK7a3mY9y9YTyQa/Z5/TXprBQmEofLuHM+byXQ1MoD?=
 =?us-ascii?Q?DkNaRmroUU7VwRkJemTucaEyDx+7d1ljW5jUEWmsSmrGzg7HnUtA5u4ufDPB?=
 =?us-ascii?Q?05B4Mw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F9kQeG1G0S3cBBrUPVpX16QVFGjqyKmhaRoRfk3kZDnWB/Mf/hss5Vh4R+Fg9KcLznVpWnoRP9DWYuJu0BqD5XpAcyMM2QiSZ5mJjcFZzjsIm5lgGwNLpeWEOi9SUU19FEsUItId92HWcoBfXItkNb2ENnQVlSWWqMdnD228rGmC/yBJxW7jpRL+L7pfHYydIDaksn/+AIRW4/fwS7yiw4zIHvDnRc87xa6WK8yqgWtwBuBhFR6AuNFnkLFZ4qDvQqVJ5yNZoanD8uXFNhzj9YhYC1ik4nb1XKMcJMICc7Z1YMImJcw7r6jKRd1T0TRIoOn8+ljX/iS2GH9FryV8KtRoGri6yWJdznDj/3HfRP26mlZ9YcfwGIT0SV4t4fRGhZoqG2xdbZr9TtG6VeF3EwpCd86dE0J1TAhsQ7O528XY09aRGP9QQTS9VBPkJ4Yz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:47:42.4446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a942b6a5-cd88-47ec-0db3-08de65089279
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9742
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257356-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,alibaba.com:email,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 533F6F8372
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


