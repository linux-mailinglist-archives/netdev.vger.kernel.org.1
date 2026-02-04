Return-Path: <netdev+bounces-256850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fw0MNnKg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62707ED075
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36BBC300B463
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2B438BF8D;
	Wed,  4 Feb 2026 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YZHFZgaK"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826B38BF64
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244823; cv=fail; b=SQyOWvJvJ5VdngtaYPUbv3DHxdwJ6TuKuoHyvK/cgR0JP2P/2ngSFWYRigO+o6jW/Jqo4dsS3qZvZujC3uaGvdxJdXrOPZn//BqEsZ6/rICjjsmMUW4svtfZ8TXUJ9OyQp11317VjSrJP5YcMby5LqMXa7m/zcgC9OXsJVo0aUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244823; c=relaxed/simple;
	bh=QHoPCuYW0lr++GJ9R8UhUgcgsC4JjflzjT6padZeb64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qc7pGzLfgOnczzv2NRsN63qk+kG/6Ple6jfFY27JcSNNA9vc1skYRlKHOBv3XK7a2IFkzj111B1cvn2zkWeZ4W61gkbC9tqK0Lp2UDJEbAmTL3M2jQ/grkbrOQtIA8Bhm15F3FWQY8UXp/hkQ7xg+bhY64CXk8OPZLAEOb9mGf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YZHFZgaK; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q82zM1NzOCOg4htZC58Sp4tpcZCZPQt6TYJvNRb9ZNlAuQZMMlQx/vkrrBNUIEToNK65MelrcTZBfXZgF0hvoLEwVOj4gwZ0REQWinD3f9CRVQqgVOgdLnvrSLODv9Js+DL4ZjXtbo5oy+9X2VqvxmWEswgHfb+NJGHzwPI+654G5+xHD2PT7LVGurW4gmourhM+cea03oXogTfMOKAEOeMfF317nUHlwkyDZUV/TNHJbY/UbIg2aRfNTfLK86BbYQb52nPtYCuA4e12uGtxTyOxyYsPyu12P6g9fjBY11I57768qtE87wfDnu39Y+tik2l9YumYG3gHObzdmpQCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFJeBwbT5X5iH3D0f/OxC21FduLY2pqdv1klrv6ldOE=;
 b=lt1eAZN2V0wGWpyccyOGVlAfZSZ8sHbA6Ymetw4QbTuMyyaPsvgypkKNxN0yPRnRqv81nQ8LpiuiY/3fdhv49DvI+xsdYdu4vyzDfren8LdZqSZ7v2BgNIW5pT8BeH7qaXoyMA0UrkPmYHFfi9jN5YMRk+9lHFf8/CkCESnUOea6kqRG6kKkyPVrOTwKEqu6swIHVuXavzqEfgGOVlVQsxCVP44IVl+u68eA2JL2YZ0AbDZ7T8s0NWJf97nJyef9+HWCQqdlPQeCAOlAqZ416kRj+3qf+NKR0pUyubJyaM1j+Bb4elFAigstggh2ZqlSkxedsOyIXbdilgwW/LJeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFJeBwbT5X5iH3D0f/OxC21FduLY2pqdv1klrv6ldOE=;
 b=YZHFZgaKnViEzA/CEbgv9Nk0HgTyx99tbM69glGp3EE0/GAm4l4w+28Iamhx+bKOv/NjbmoiKRPHpNDbSR58ToF7FO9T0/x70WIqtPZzeLjCcBjJrjApFvMX3Ciki9zJKag15W97g/0qzGctYwf04N5NgXKiNjjRLTabIXITdRZEYd5FtX4ip9okO9YUXNBUwEXSo2vsF9o1ag47Afi++dujvYfGyq6VTuldlRxt3BNEpd0hLEt1rWaC7Gp1WGaQqKe31ERG022XJp4sU3TZOLZsxIrXoxHH8pbyMgb4hCbstI63dy95NIPU3v3DdCcRCrDEQxpMhXtVFNrKXirsoA==
Received: from CH0PR04CA0093.namprd04.prod.outlook.com (2603:10b6:610:75::8)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 22:40:10 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::b1) by CH0PR04CA0093.outlook.office365.com
 (2603:10b6:610:75::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend
 Transport; Wed, 4 Feb 2026 22:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 22:40:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 14:39:54 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 14:39:53 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 14:39:52 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v19 05/12] virtio_net: Query and set flow filter caps
Date: Wed, 4 Feb 2026 16:39:33 -0600
Message-ID: <20260204223940.39581-6-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 5110c7eb-2054-4265-7f9b-08de643e5aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I3rT6pQNNAs6tEjNiboSI+h3iGh4v3K5oOi2r2GqHlZku9Y8qlfUwAE/ZEig?=
 =?us-ascii?Q?qJqik4op/Y/7/0emGA8Dbs5tShEJkGK1jV1d7EEpXpjPnpX3aN2Na4ggeZuo?=
 =?us-ascii?Q?ZjzIttmjhiwyIkDzwCdibklrtqmMdpYrMzqdsAXDqj76pY5ET5o20GeZdL/A?=
 =?us-ascii?Q?Ba3ffRutoBxENILS0r+XksvTCqGOWabCwHKGQES1YBejvieLUsJu1FSv0LzD?=
 =?us-ascii?Q?uienzkLnyGCMpW0GOVwqGFf080UTOobOY9WmXIoqZ89vBE9rGuAOC6PKJ6Z7?=
 =?us-ascii?Q?DHrexDnuVGHwkFe2nWhV+cQcWYbh5BPvtM4Oq0dQUX+w0T70WbX0EnXreRZJ?=
 =?us-ascii?Q?fqF5SBXKcvjnxCPj6RKqdB+NrmKAb+3AjqnmhdwXNXyx+p+FgKEtV/P4N4LN?=
 =?us-ascii?Q?c9kZstLnMmWLchafY+vz7g7DKamKs9NfH6oF/DLPvPtJdE/HfjNVivl3snE/?=
 =?us-ascii?Q?faokTvEumcDdFvGUVxXoTtJ9zfZnwleMR06+tx+/s2yiuLn0bY77CzJmJCoD?=
 =?us-ascii?Q?HGwV99xadJOG6XzvG1Yv8ND456YQZVLUwfsOcc4NrboStR28wuyQWJ7TEthz?=
 =?us-ascii?Q?wBnFZNXSc3kOQ+Rf383haFk68mA3RrOaXIvgiDKxbLYF/ex5tF4bYVfEdCJn?=
 =?us-ascii?Q?JKHcI8tX5thiW22ZLAuVfryZx3WoiGF2GbCqWaVJOl+OfqNk8H2YY5GMLILP?=
 =?us-ascii?Q?kEBIA/0/AjkoHKGYsDfO9z3/z4TDAj2Cw9ewXKTuhlnT9wwv2Wga+vjl7Vtw?=
 =?us-ascii?Q?PoyfXLM9DHOG4fxQAPOz7zDqzBOgHkKX682/IBPTngeFNZKyZeNm46HtJKX0?=
 =?us-ascii?Q?gdZX7s6mJWdSpo/P5EtS7Sm0tFqsrCGC8iixqHanAGJpP+XzGjBiwfC2U2q6?=
 =?us-ascii?Q?eLQsdWFOrRf6IQrtbje3BvIEoI5vvWRIhMyqeHR4DCgqWh5YmmnRzzTNf3m6?=
 =?us-ascii?Q?neusDfy8vY0gUKEdCKqxBR02s2X4RrwMJBwndD1AVeOr/U9RS4+Ibuc5exRf?=
 =?us-ascii?Q?xtG6AwpHH2g9di+Ig+ME8PJbt5Jeet0md31n31+Vo8U6fyVa0YaU1yesRJDX?=
 =?us-ascii?Q?jtR9anIekIV9jVDRSRh9c4EoSLYI5s6Lwvdzcil6mSJpPTSOpoWPW2k6y7C/?=
 =?us-ascii?Q?a6GEP3aGuzbCEnmN1N4K7E0Bq87fFW3TwJKZJXG9m0zneJ6n4EuolAkONtRJ?=
 =?us-ascii?Q?eL6ir7YHhBCKFKupsq3dIDt1YWqIO0b1DpI6Ecnl36zGKJpD1jd0x+eKzZn4?=
 =?us-ascii?Q?0J29dMtTLO3EoIB/JyZelBOgKTjrdTaHUUhTS1NIUZGRt+JBVGETqYvdFzpf?=
 =?us-ascii?Q?r0tMmhjJp3ewSZwdAIUp8XV3BxkU/yiCrhx8GAZa2ogQy5JY5kxW5zc2i9Hd?=
 =?us-ascii?Q?J28JKjmQqtpOGJEKSu5ZZqYAeJGvWVul+vqCoZYVD5QkkV/nETf7k8esferC?=
 =?us-ascii?Q?LC9vdUu1p1h2e6ep7eE8I5J/w4XrLT6sNTlmGhRSgpJhhbBsSA3CloTfPXlZ?=
 =?us-ascii?Q?PSlt7RJzI4iwNplKksxw24OSfO67QIGcn+Fh6k5GTGtCbDckDQepH81wkv2P?=
 =?us-ascii?Q?wJKI5yFKmRnoWSpBvJjOKa4D4ky3IkpbVvEwTAL0qBrI1+VS+IhioULym0up?=
 =?us-ascii?Q?wI/fva+Fl85K+V0l2FP5aZ8NbSr7frkY5V1EGeyBshTgyxmE/y3wfBMt5vM4?=
 =?us-ascii?Q?ayfypA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JjoL9zPXiOn+ihIp6CoB84bM6WeAIzRMiyuJRvAL4/NO8H6emNUbZ5X80+eGGmXb4ym/GQ1Gm4HGjdrrZ95hF9owkcmq6sMz7/ETieW2zuUklNsjEwMpzXXAQrLpzfP5agpko7Kf+6YQtdc5b8Y+TYwilFsvl5BQX0xRTP/Kut5LTxn0JXeTGHAeuQNSaLyjN1ycUHbxgAD+JzcR1vd1zcSlvMGIYI3Vyc7o6vcCsXpgvixQwcyQ0bnGHqzquku2mFFQoPkcP6WVpWdrZ1I165WR2JUzHBwesC8WJlyEYtWLrIYXFaz2sJpK+Cl7agjskLS8U0gdx70Aubmoe0cptikYwC1Nd2H1ut3pwleFthvl1FW41u6XQX2cy9H39l6ZvGBo4yUbZr6KnBGkpoPzPcaCzZpQGTLjsPQkT6vfNedBw6z0e2CZCK608G9UdnnH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:40:10.3487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5110c7eb-2054-4265-7f9b-08de643e5aa8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256850-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 62707ED075
X-Rspamd-Action: no action

When probing a virtnet device, attempt to read the flow filter
capabilities. In order to use the feature the caps must also
be set. For now setting what was read is sufficient.

This patch adds uapi definitions virtio_net flow filters define in
version 1.4 of the VirtIO spec.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

---
v4:
    - Validate the length in the selector caps
    - Removed __free usage.
    - Removed for(int.
v5:
    - Remove unneed () after MAX_SEL_LEN macro (test bot)
v6:
    - Fix sparse warning "array of flexible structures" Jakub K/Simon H
    - Use new variable and validate ff_mask_size before set_cap. MST
v7:
    - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abeni
    - Return errors from virtnet_ff_init, -ENOTSUPP is not fatal. Xuan

v8:
    - Use real_ff_mask_size when setting the selector caps. Jason Wang

v9:
    - Set err after failed memory allocations. Simon Horman

v10:
    - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
      Jason/Paolo.

v11:
    - Return -EINVAL if any resource limit is 0. Simon Horman
    - Ensure we don't overrun alloced space of ff->ff_mask by moving the
      real_ff_mask_size > ff_mask_size check into the loop. Simon Horman

v12:
    - Move uapi includes to virtio_net.c vs header file. MST
    - Remove kernel.h header in virtio_net_ff uapi. MST
    - WARN_ON_ONCE in error paths validating selectors. MST
    - Move includes from .h to .c files. MST
    - Add WARN_ON_ONCE if obj_destroy fails. MST
    - Comment cleanup in virito_net_ff.h uapi. MST
    - Add 2 byte pad to the end of virtio_net_ff_cap_data.
      https://lore.kernel.org/virtio-comment/20251119044029-mutt-send-email-mst@kernel.org/T/#m930988a5d3db316c68546d8b61f4b94f6ebda030
    - Cleanup and reinit in the freeze/restore path. MST

v13:
    - Added /* private: */ comment before reserved field. Jakub
    - Change ff_mask validation to break at unkonwn selector type. This
      will allow compatability with newer controllers if the types of
      selectors is expanded. MST

v14:
    - Handle err from virtnet_ff_init in virtnet_restore_up. MST

v15:
    - In virtnet_restore_up only call virtnet_close in err path if
      netif_runnig. AI

v16:
    - Return 0 from virtnet_restore_up if virtnet_init_ff return not
      supported. AI

v17:
    - During restore freeze_down on error during ff_init. AI

v18:
    - Changed selector cap validation to verify size for each type
      instead of just checking they weren't bigger than max size. AI
    - Added __count_by attribute to flexible members in uapi. Paolo A

v19:
    - Fixed ;; and incorrect plural in comment. AI
---
 drivers/net/virtio_net.c           | 231 ++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_net_ff.h |  90 +++++++++++
 2 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/virtio_net_ff.h

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..2cfa37e2f83f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -26,6 +26,11 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
+#include <linux/virtio_admin.h>
+#include <net/ipv6.h>
+#include <net/ip.h>
+#include <uapi/linux/virtio_pci.h>
+#include <uapi/linux/virtio_net_ff.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -281,6 +286,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+struct virtnet_ff {
+	struct virtio_device *vdev;
+	bool ff_supported;
+	struct virtio_net_ff_cap_data *ff_caps;
+	struct virtio_net_ff_cap_mask_data *ff_mask;
+	struct virtio_net_ff_actions *ff_actions;
+};
+
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
 #define VIRTNET_Q_TYPE_CQ 2
@@ -488,6 +501,7 @@ struct virtnet_info {
 	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
 		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
 	);
+	struct virtnet_ff ff;
 };
 static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
 	      offsetof(struct virtnet_info, rss_hash_key_data));
@@ -526,6 +540,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize);
 static void virtnet_xsk_completed(struct send_queue *sq, int num);
+static void remove_vq_common(struct virtnet_info *vi);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -5684,6 +5699,192 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
 	.get_base_stats		= virtnet_get_base_stats,
 };
 
+static size_t get_mask_size(u16 type)
+{
+	switch (type) {
+	case VIRTIO_NET_FF_MASK_TYPE_ETH:
+		return sizeof(struct ethhdr);
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return sizeof(struct iphdr);
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return sizeof(struct ipv6hdr);
+	case VIRTIO_NET_FF_MASK_TYPE_TCP:
+		return sizeof(struct tcphdr);
+	case VIRTIO_NET_FF_MASK_TYPE_UDP:
+		return sizeof(struct udphdr);
+	}
+
+	return 0;
+}
+
+static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
+{
+	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
+			      sizeof(struct virtio_net_ff_selector) *
+			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
+	struct virtio_net_ff_selector *sel;
+	unsigned long sel_types = 0;
+	size_t real_ff_mask_size;
+	int err;
+	int i;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
+	if (!cap_id_list)
+		return -ENOMEM;
+
+	err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
+	if (err)
+		goto err_cap_list;
+
+	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_RESOURCE_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_SELECTOR_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_ACTION_CAP))) {
+		err = -EOPNOTSUPP;
+		goto err_cap_list;
+	}
+
+	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
+	if (!ff->ff_caps) {
+		err = -ENOMEM;
+		goto err_cap_list;
+	}
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_RESOURCE_CAP,
+				   ff->ff_caps,
+				   sizeof(*ff->ff_caps));
+
+	if (err)
+		goto err_ff;
+
+	if (!ff->ff_caps->groups_limit ||
+	    !ff->ff_caps->classifiers_limit ||
+	    !ff->ff_caps->rules_limit ||
+	    !ff->ff_caps->rules_per_group_limit) {
+		err = -EINVAL;
+		goto err_ff;
+	}
+
+	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
+	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
+		ff_mask_size += get_mask_size(i);
+
+	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
+	if (!ff->ff_mask) {
+		err = -ENOMEM;
+		goto err_ff;
+	}
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_SELECTOR_CAP,
+				   ff->ff_mask,
+				   ff_mask_size);
+
+	if (err)
+		goto err_ff_mask;
+
+	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
+					VIRTIO_NET_FF_ACTION_MAX,
+					GFP_KERNEL);
+	if (!ff->ff_actions) {
+		err = -ENOMEM;
+		goto err_ff_mask;
+	}
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_ACTION_CAP,
+				   ff->ff_actions,
+				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_RESOURCE_CAP,
+				   ff->ff_caps,
+				   sizeof(*ff->ff_caps));
+	if (err)
+		goto err_ff_action;
+
+	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
+	sel = (void *)&ff->ff_mask->selectors;
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		/* If the selector type is unknown it may indicate the spec
+		 * has been revised to include new types of selectors
+		 */
+		if (sel->type > VIRTIO_NET_FF_MASK_TYPE_MAX)
+			break;
+
+		if (sel->length != get_mask_size(sel->type) ||
+		    test_and_set_bit(sel->type, &sel_types)) {
+			WARN_ON_ONCE(true);
+			err = -EINVAL;
+			goto err_ff_action;
+		}
+		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
+		if (real_ff_mask_size > ff_mask_size) {
+			WARN_ON_ONCE(true);
+			err = -EINVAL;
+			goto err_ff_action;
+		}
+		sel = (void *)sel + sizeof(*sel) + sel->length;
+	}
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_SELECTOR_CAP,
+				   ff->ff_mask,
+				   real_ff_mask_size);
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_ACTION_CAP,
+				   ff->ff_actions,
+				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+	if (err)
+		goto err_ff_action;
+
+	ff->vdev = vdev;
+	ff->ff_supported = true;
+
+	kfree(cap_id_list);
+
+	return 0;
+
+err_ff_action:
+	kfree(ff->ff_actions);
+	ff->ff_actions = NULL;
+err_ff_mask:
+	kfree(ff->ff_mask);
+	ff->ff_mask = NULL;
+err_ff:
+	kfree(ff->ff_caps);
+	ff->ff_caps = NULL;
+err_cap_list:
+	kfree(cap_id_list);
+
+	return err;
+}
+
+static void virtnet_ff_cleanup(struct virtnet_ff *ff)
+{
+	if (!ff->ff_supported)
+		return;
+
+	kfree(ff->ff_actions);
+	kfree(ff->ff_mask);
+	kfree(ff->ff_caps);
+	ff->ff_supported = false;
+}
+
 static void virtnet_freeze_down(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
@@ -5702,6 +5903,10 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
+
+	rtnl_lock();
+	virtnet_ff_cleanup(&vi->ff);
+	rtnl_unlock();
 }
 
 static int init_vqs(struct virtnet_info *vi);
@@ -5727,10 +5932,23 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 			return err;
 	}
 
+	/* Initialize flow filters. Not supported is an acceptable and common
+	 * return code
+	 */
+	rtnl_lock();
+	err = virtnet_ff_init(&vi->ff, vi->vdev);
+	if (err && err != -EOPNOTSUPP) {
+		rtnl_unlock();
+		virtnet_freeze_down(vi->vdev);
+		remove_vq_common(vi);
+		return err;
+	}
+	rtnl_unlock();
+
 	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
-	return err;
+	return 0;
 }
 
 static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
@@ -7058,6 +7276,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	/* Initialize flow filters. Not supported is an acceptable and common
+	 * return code
+	 */
+	err = virtnet_ff_init(&vi->ff, vi->vdev);
+	if (err && err != -EOPNOTSUPP) {
+		rtnl_unlock();
+		goto free_unregister_netdev;
+	}
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
@@ -7073,6 +7300,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 free_unregister_netdev:
 	unregister_netdev(dev);
+	virtnet_ff_cleanup(&vi->ff);
 free_failover:
 	net_failover_destroy(vi->failover);
 free_vqs:
@@ -7121,6 +7349,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	virtnet_free_irq_moder(vi);
 
 	unregister_netdev(vi->dev);
+	virtnet_ff_cleanup(&vi->ff);
 
 	net_failover_destroy(vi->failover);
 
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
new file mode 100644
index 000000000000..c967af950b72
--- /dev/null
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+ *
+ * Header file for virtio_net flow filters
+ */
+#ifndef _LINUX_VIRTIO_NET_FF_H
+#define _LINUX_VIRTIO_NET_FF_H
+
+#include <linux/types.h>
+
+#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
+#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
+#define VIRTIO_NET_FF_ACTION_CAP 0x802
+
+/**
+ * struct virtio_net_ff_cap_data - Flow filter resource capability limits
+ * @groups_limit: maximum number of flow filter groups supported by the device
+ * @classifiers_limit: maximum number of classifiers supported by the device
+ * @rules_limit: maximum number of rules supported device-wide across all groups
+ * @rules_per_group_limit: maximum number of rules allowed in a single group
+ * @last_rule_priority: priority value associated with the lowest-priority rule
+ * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
+ */
+struct virtio_net_ff_cap_data {
+	__le32 groups_limit;
+	__le32 classifiers_limit;
+	__le32 rules_limit;
+	__le32 rules_per_group_limit;
+	__u8 last_rule_priority;
+	__u8 selectors_per_classifier_limit;
+	/* private: */
+	__u8 reserved[2];
+};
+
+/**
+ * struct virtio_net_ff_selector - Selector mask descriptor
+ * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
+ * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @length: size in bytes of @mask
+ * @reserved1: must be set to 0 by the driver and ignored by the device
+ * @mask: variable-length mask payload for @type, length given by @length
+ *
+ * A selector describes a header mask that a classifier can apply. The format
+ * of @mask depends on @type.
+ */
+struct virtio_net_ff_selector {
+	__u8 type;
+	__u8 flags;
+	__u8 reserved[2];
+	__u8 length;
+	__u8 reserved1[3];
+	__u8 mask[] __counted_by(length);
+};
+
+#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
+#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
+#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
+#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
+#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
+#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
+
+/**
+ * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
+ * @count: number of entries in @selectors
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @selectors: packed array of struct virtio_net_ff_selector.
+ */
+struct virtio_net_ff_cap_mask_data {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 selectors[] __counted_by(count);
+};
+
+#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
+
+#define VIRTIO_NET_FF_ACTION_DROP 1
+#define VIRTIO_NET_FF_ACTION_RX_VQ 2
+#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
+/**
+ * struct virtio_net_ff_actions - Supported flow actions
+ * @count: number of supported actions in @actions
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
+ */
+struct virtio_net_ff_actions {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 actions[] __counted_by(count);
+};
+#endif
-- 
2.50.1


