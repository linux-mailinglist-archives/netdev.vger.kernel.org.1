Return-Path: <netdev+bounces-249783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACACD1DBF1
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ACC53025704
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658D53803C0;
	Wed, 14 Jan 2026 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G8rrXUTF"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928F3806B7
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384604; cv=fail; b=tLBVGi8Oq69t4RITmctAmJ62ce67MKtjsgnflLNLGmjCfpYwkcs6/yel0hCh6dVfYEShOwMgovvzat7zS7OnaaexaZo5IBU+HOwdkdmP28VsCUm3/61DvdYHmKm5R3vUlIBIfTQwU697ILsaqCKd5U0nm82ITOw6LZFL7VZrggQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384604; c=relaxed/simple;
	bh=ZqW5G95FD9gHlBiCXuowPRDrGp38gSop9lk0RvllY30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHhCbnrK7VETx/IFB4/y99oqOeK9vfm0fhTOlvQywLomR2aQpfnYX+hMstrr5W0JQnhSDK1PNHdJD9wU2iAIHbJu/r2NFTu01XsoSrWYta332FaaC0K6xYP1ZPEOtWoYHo3S8+8OZJif4Tb3xvEOw05I75prJPpiF7dfri+iNT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G8rrXUTF; arc=fail smtp.client-ip=52.101.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVTIDDakOh9J3PLmWwO+Jqhx6Wwz5tGvdbFhtWzKWJba6XAdYAEUWMv++RAzsxtKCowaUXBDe9OUGDgXpYzuLt2CoT+MfJpAxGUZe24GolG3iMfT71HQJwHYafCX60w5Hx/dNtmHm2l0SnwqkeO9RGctfIhjno59nFdLoE/E2ZmuttRBlGj9ndvSmgdZ+4RfdoPCIPjAA984iU6nfziV4w8LJn9ucowN4MNUerIQ351nXdzPHP9PeqhWXQ9is0+lovTqicglQf723gbUTxQBowCxTWDLAHVq9E2kUlvlhxZoeonO2FwOAdf3QAmh1D7AApjFYTtTMuPyZ5ZBI0ADjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nDDn8u+JEeLQwdjdXslIX5WcEIPBtK8XpYXgXfpFv8=;
 b=owoWkrRujeGFTAqQWwaZXWhwd8pF4P2Jslfex2JKpzcG5eq1T5gais16r4n3bpFOctJ7avb2lt5qPFeQbO3i1Jma6xY5PRad3nDb4L6KwNYJr3rOcOhC0SaZfoDJL7v/OmvZ6jdzuC7kDUNlJhvay3dFjTeuLN//bePvzA4r9QAFYEgz9cbBOpcnqnHzaGdrGHhwHiRHg/nrmAGhVpkVaM4UFXgc8YCzeL0zF2Sb0Z8Isb3NwKRnqflcofnyF1hwarTpvGwdTkjiWDM6fv1lSvlq8az6qEKVsmkdvnLdohZPmZVlO8krmZGhZencFJaMaPTtciQwT642iuJW1dMcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nDDn8u+JEeLQwdjdXslIX5WcEIPBtK8XpYXgXfpFv8=;
 b=G8rrXUTFneoiWoX8DYjUhgkowxPgodBO8Fp2R30Am1IInyVyXOPlrJzSE+Ll+Nnb7rC2aXnoYi74RaI8v3oB9VMytNV6Lsjf2OqYp03eUyj3BDnCF/lJKS3bo/bvLpgNL/e4rcfHjhKyNI1Z8a0yozRa4Tffd4bYGk7Adgj0/YuiOXDgNgTd0Y88a3o6dcbvMu3spxjMQezn1E53bq3SwqzzHPaYPQN8NgitSszA6AHwTd3NbBLa/WJPKYTPSBR66vxG/BGAzEJA71G9e8zPni5EDAZuxRcpk3t+KL2vTkJOCjO66YQAwXPi8L1z6e6vZX8ZH7ldssz4R5V0JNxuSA==
Received: from SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::29)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 09:56:39 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::57) by SA9P221CA0024.outlook.office365.com
 (2603:10b6:806:25::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 09:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:56:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 01:56:22 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 14 Jan 2026 01:56:16 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>,
	"Francesco Ruggeri" <fruggeri@arista.com>, Stephen Hemminger
	<stephen@networkplumber.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 8/8] net: core: neighbour: Make another netlink notification atomically
Date: Wed, 14 Jan 2026 10:54:51 +0100
Message-ID: <0b26d2a012cf11e990a759f3374585c801c39be5.1768225160.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768225160.git.petrm@nvidia.com>
References: <cover.1768225160.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a48dd9-deb6-42e3-154d-08de535335a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hvsCuaSZT9RvAMqOo3cVziOaI6oFK3z7YjXwja/nHbiq4jIlmgLneB1eBi/k?=
 =?us-ascii?Q?tFEgwqFf9/Cc6yP/kSioucFh4N3uWyUIu+wjBRY/l0WPWMPYpxTYbHDKnI1o?=
 =?us-ascii?Q?lC7MU0m6qtEWuU1CQDJhzuWeVb/FH5I5PovZHmyG8Rhb7j+6zWLUbcyK/7EV?=
 =?us-ascii?Q?6R9aOTKBLgOGyh1EPtOg4RzWCop497cmBKI6dvaEVwPmg+63rrSIbHpdk+2V?=
 =?us-ascii?Q?+oci7oMLJ8Noos3xczsZXbtbYop5y6OeuoYkVPeInc7jMEJL/6w/nd9oqYWC?=
 =?us-ascii?Q?6opXJ3z8imb+CH7xMhbQTWX+s6tTlVR1qOR0R2udl89+cDrJm9epC6tSq6HM?=
 =?us-ascii?Q?sedwbtIv36SNYx/C7iYPuESjaTkn+hnPhhWnpEk10XT4EKPe2n92GazwqcDy?=
 =?us-ascii?Q?7C81EL63askxVnQsZ+U48h1FN/FsQxcF/NYpbWCAFU3dBbsp+4Pw47Q6l50c?=
 =?us-ascii?Q?V4Jv2971iPG6IFuWP2jUNTo+Gfv0Fck6d9FB99jT3XnVlTIu4G9s6xDLdsvc?=
 =?us-ascii?Q?Wbaq5F3pGXErVr7ACNGVmWsvEmQtjxFP1FiSNQpSk1sH3bSgqP8UA0rgEsTK?=
 =?us-ascii?Q?FP8tLxBrlxHmawZq+QpcgKmkQjPqeIr9ftXYINlVSeKXN0gQq58oZJ6RDaLL?=
 =?us-ascii?Q?rAsZAaiPUW4ewiGn9Yc7iJZS/9KuPra0TklhKsbQeW3AhlUvjm2teqwCb4k5?=
 =?us-ascii?Q?juyUnCLKtQch0ovGrvF7mZvIIRzZwF5wTeWQhItupAfjmrmCknfcYXK2GjwV?=
 =?us-ascii?Q?7noAva6weTa/4bBDi27h0PQruxoJPXbSA/gENEcwxyJ+KGkdRodbbGKFI00Z?=
 =?us-ascii?Q?oifRmY40qFce5+i2PJCzrKr0DmvGATaWF6SppSRmMff4GvpOovFl0widWoMy?=
 =?us-ascii?Q?8hXf2kF0qY8unzeVELWFMm6nOsLu20rDJ8lUsIRe0VZtWy06YLDRB5Wvv/Fj?=
 =?us-ascii?Q?Lt1KVTRcVEIKsv3KVMv/GeTSyxF734HpS4gjiJojtdrfN4uc5p+Ywbbk5ax1?=
 =?us-ascii?Q?pT5V61koI4KR5ThwqCrQ9kS/AFdbBq/RVyMUMIp4euHllv+L4XNGmSyCP8U0?=
 =?us-ascii?Q?IJtV7iTxY7HXFvYYkUkdoSLFShX0AkJiZ5mFiQDFVvhEf7gYoPJ+D9Ru7uoF?=
 =?us-ascii?Q?1GmLcXRprlPaYtAbfNSrVjmzebuXPi58BWisML+K1kQjRQpx1iAhHwsrj3pQ?=
 =?us-ascii?Q?x1kIqEMkZ0zOFRfC4GAnihg8kiwHgHI2ju06dU3Bq3MrKJZQV/sn3ZpSOgKp?=
 =?us-ascii?Q?NTRW9pWG4wuIlcP97wn1gRRmpzv9PMhA0rssdA5rhLmJT5jBNBqleTfi46oi?=
 =?us-ascii?Q?S26LCragg2rKBrKlhBbpJsrDfsADCyr5nbkBgZU+ONOzgi2rGequGN6fQJ0k?=
 =?us-ascii?Q?nf8GM4rSZ6mIabnEW0c6FkBkxATWIR445tnrUadKxns+QVMGVEFJb9vOORib?=
 =?us-ascii?Q?vWBpak/8k1Re7Z3qCINnxXrE6vgjP/VD+4VuJP0FIdDQMccOSyEomwbPotZz?=
 =?us-ascii?Q?fHPrlLounAORvrG/U5vPwmJ8B4V56jIl+ayWeG6AQ/NDPRoGLQrSzGxFSqFv?=
 =?us-ascii?Q?uZTgrj6FHuq1eDKgJVo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:56:37.8914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a48dd9-deb6-42e3-154d-08de535335a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424

Similarly to the issue from the previous patch, neigh_timer_handler() also
updates the neighbor separately from formatting and sending the netlink
notification message. We have not seen reports to the effect of this
causing trouble, but in theory, the same sort of issues could have come up:
neigh_timer_handler() would make changes as necessary, but before
formatting and sending a notification, is interrupted before sending by
another thread, which makes a parallel change and sends its own message.
The message send that is prompted by an earlier change thus contains
information that does not reflect the change having been made.

To solve this, the netlink notification needs to be in the same critical
section that updates the neighbor. The critical section is ended by the
neigh_probe() call which drops the lock before calling solicit. Stretching
the critical section over the solicit call is problematic, because that can
then involved all sorts of forwarding callbacks. Therefore, like in the
previous patch, split the netlink notification away from the internal one
and move it ahead of the probe call.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 635d71c6420f..5512dd7035b1 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1180,6 +1180,10 @@ static void neigh_timer_handler(struct timer_list *t)
 		if (!mod_timer(&neigh->timer, next))
 			neigh_hold(neigh);
 	}
+
+	if (notify)
+		__neigh_notify(neigh, RTM_NEWNEIGH, 0, 0);
+
 	if (neigh->nud_state & (NUD_INCOMPLETE | NUD_PROBE)) {
 		neigh_probe(neigh);
 	} else {
@@ -1187,10 +1191,8 @@ static void neigh_timer_handler(struct timer_list *t)
 		write_unlock(&neigh->lock);
 	}
 
-	if (notify) {
-		neigh_notify(neigh, RTM_NEWNEIGH, 0, 0);
+	if (notify)
 		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
-	}
 
 	trace_neigh_timer_handler(neigh, 0);
 
-- 
2.51.1


