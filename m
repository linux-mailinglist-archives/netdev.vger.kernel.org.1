Return-Path: <netdev+bounces-294349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PKd3G44nH2rciAAAu9opvQ
	(envelope-from <netdev+bounces-294349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:57:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C109F6313FE
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:57:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=WGO3jken;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294349-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294349-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69218305A8AF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3119639A4CE;
	Tue,  2 Jun 2026 18:51:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626D3998B7;
	Tue,  2 Jun 2026 18:51:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426305; cv=fail; b=H6lVW7YqF1XpfpmE7iqrZxg+Fj6yqrSlrgsinYVaVfg536aMjeEa6H1SQs03WyQdrIAvuuPCmyl9usZ+hcKKVG1YNhg0dxfZnKiJxGNqXR/+L8r41jiXfKByQ5ySgyBpa8cZtgzyzp1QFr7rWQ6j2SrVoqKzG1cn9OlcNdQEJzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426305; c=relaxed/simple;
	bh=f+4wBliM69oWRg9mIICv/LaLSA2jPGXu/8elD0fbSYI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hTAnTYhP9zXZcLyAX6LKl7s88qMyi+4YvzTH84S851ir6QOgPhNbX6VhxnaesiKzayv1t8nPP5BNFxpv8KPZxZ9DPLSI4KY3TkGFh0+bt8I84ZTSRDk86HsiY+mF7pcAlLM1gVHLhCTujau0rW5r/gr18uXVmnuVarvEz9CggJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WGO3jken; arc=fail smtp.client-ip=40.93.196.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDQSoSCkU5SP9XgZq9uvB7mzivzTm6/rHvEDJFREpad+O92sFMpe/fgzOqjPJ63J4jef7TPVa1RtyrbotZMLSEnW+wOxHfkTX16GmLlUxUXW009zUd9pOUyUrBX2h/rMhNd3phF7Z/yqXr8tVlctqeVGY8wJORypEELsgQdO4IEzQVTOC2jP90dB76Z3+1KNJPHDQkYZ8XA2hFR1SRMvmTZvq/LqpE6BbwaGOTGsRSzxlVjTCnh+KXrjoYr4BLMozgVyxYDJ8Z2Ex3Lok2Rj7xPV3e+ypvT8L2epIp4RYRvObzMyNxmrLK1Dvfpx5eUhjn3wfeQAwnk/4V0Pyi9C3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90QRqpZTpquZEK8u7mkDb8kq+/K6mU7vBpjtXFj8vlM=;
 b=ujnicfB7SYeTWjJ8djAmk3s0XavGTelr7VzlQLeRgPWw8T+cAnOadJzIS0f+nHnL7b8E+3OVChmzzDNFed8U6lth+hMHi82Af+ad3EYoaQncOJcECfliefEJxYVpyAv4xenhL5scLwLfKAQnBu3TWf2GXxBO6K6l0IkyHs7MvPrKJxv0XBxK3ghcdy8MXtk0VpuE+64AscmRdIvy+kixnsI3vv/tY7xJ6/HdzXkhsGWuGXcetZ6bRGznv4FSU+JhnBlxIJ6/ijCCt9QgS1ijSAF5mlCyLxfGrVjJf4yAbhPQbgnpNrFHuBWQoJznh3L8aQhtHkHZAlDE87JUz3Bz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90QRqpZTpquZEK8u7mkDb8kq+/K6mU7vBpjtXFj8vlM=;
 b=WGO3jkenRqM1/Pg4dH/B0vhTd0hHQ6vDvvZaJXJ2UZc4SuTpu7ZTqHzxB+Gs2tNdaZQr8XBark11ehALNvWSrjpWKTFHr7t5N0hMQZ+gwHaz/XpmIkBIjs1ADzxx8jSIHihsU17lnPALpQGJj6h6gPIyoi4biHVO42MWWimY9wHC90pJJ+EFgcNt6owCQMyG/eKSYCYnkpIdXhDLhqwJHYfPmTykitUHIrC/knZdMygc7jNO7oy0UdH40IXgdrGMOvJ2YfwBPgef0nmNqEmxRBNXAH0cLRwVvyVzS+PX3eg0rG0pkr6W//gI7xtY2q0V6v4C158ypGiDIycd7jUWiQ==
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 18:51:40 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 18:51:39 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Roopa Prabhu <roopa@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Chirag Shah <chirag@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/3] vxlan: vnifilter: fix VNI add/update notifications
Date: Tue,  2 Jun 2026 11:51:35 -0700
Message-ID: <20260602185138.253265-1-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e222eed-2305-4fac-c3f6-08dec0d7fb00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	h9dZq4A2iE1relgAzsdTCYHA4Gz/Nti5AtbgEibo6ipEVLonhI9pdg9JWICu273S5/6q75HtnY9CsQP/9cGVkURgiaqEeHuFo6OmkCISho7xtSwY6DZiYOBLph7trUMTaAz4AL8oLluXj30DNHNzaCVsndpeV0CIz3xbJdpvwxUV6K+aMjjjkw03B5e74u/OD3mcTRrQcEkUd2qQl043057vlYpEg4BA6lDLtJwJ1wkwE8LQy0xRBzjXD+YTXQE2LZxyA7LmM9u4W4cs3La5FwYtvoT/dRDWc+XgkfDxo27yBgzie1wm/eL9D6MfAczs3ToxYVECn+slsBjYR78bzwvJe5DZtzBFnKJk8tazMS1gobaV3rMlnUr4xJRHw78tQUxPsB2hoV3j/GOQXKvOircaDAnB/QM7A4t0DVwAffkcoihXxpejHrlnCS72ZSkqfsxXzE2yc5ESjTm9bbmwi0RrypXGyA4C1tcImFaIQs6AZlRamRUMaqRLfraVfYOJHiv7QnOSTo3JPSIstulDY9Y/gqeeeRGJj5KLLXSmZeCewKUaaFYYDsH4E/lIQTQ7CcE+B8m4AzGExqDJDc48wLALX64Dqd25GWk9z6uRjDDR1K4YxISYDki/9NSY+DodLMunT3p876puIcAHX6zMvnKu1U8T786K41mRtcMsZ83Hioj5XQibMCwKizdn0Q9lqcLli3q+CI+A3R6+3PQVPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvXbbKOTWzxWn+05Z8TgBqCJq+ijp8cfIpo00H0nH4rKtuNtlmiu+PE7AaG0?=
 =?us-ascii?Q?PvJl0PwXBFUfXEJKBBT8swrdmEp2EcUH/EtIrUbhvhWZy90uvqjegO2wOx/k?=
 =?us-ascii?Q?ZvlvutM4lYH5R7zHnlO6O/6zQAI2ouielRpdU9CG54a3JSdCsmOXIL6+5mSx?=
 =?us-ascii?Q?mzEOf8OX42lFaP6yyMvIDa6RT7KdAlDZklgWarIvog+JKB57Tb3Fcen+zzm8?=
 =?us-ascii?Q?mvzQqwltmqga4au5CKsjJvAg5itA/AwsiV1DtU05FbOEV1s+FfhT3HM2+iMO?=
 =?us-ascii?Q?KeVzEO9fF+sKBaMUfEJeioXHgWFIqoZUW12NabDXrrpTjUlkKMBJ+uovjDSs?=
 =?us-ascii?Q?0BEIQc1KQR8HOvIuF0WC1ZxVheUlUzuW/mf+62qIQKfQEm89VAA7kNHUTSvq?=
 =?us-ascii?Q?fOUflvTYRRfgiIgjjzYK/CDhMAn1jLJpv6Toxk4Y+UoX7/r+mJs9QVYW3aCp?=
 =?us-ascii?Q?gxA68ou4Cw5oxwS8cWvTOewv7iJ7KPQOmmMhf1c2bYpecWCOsNNPQoCJmfzX?=
 =?us-ascii?Q?ENnCQK/DyZJyVfgNy/eAoGq0oliOnUKcLcFqHRSdEtfyLuOHEvroLeNwmQ6C?=
 =?us-ascii?Q?2ys2fkJyI9J1+dh/vDP0qsMsxRPXl27Ivabj/2Q5k606+RXNWfQrPRKYyPgL?=
 =?us-ascii?Q?MwRPVvUCihXR7VB0WKcp9Kqt24dINU7axDHmXZ9Jh6TeufYo7aTxBKT+W0tl?=
 =?us-ascii?Q?BxrvsQaHzvwSgUGQnr7m3AmMK+ffjlKtwqU5Whus7jyUN2waL1hzmU6E/kg+?=
 =?us-ascii?Q?j66ADVIiKNoUI2ZGyE9RPYcD6tndKJP0emce2B4no/qhrvk0YowQ4GE97HvO?=
 =?us-ascii?Q?yErJS/tOsH4ZbrwsxrnEt3yDhpDpAoO4Je5It6Kc1t2iWL/oVXdw3DgD0/0X?=
 =?us-ascii?Q?nGmJZvJto32dGfchc357oHdbxhjCq26PUtPbZyiooDRCFZur1xmUqIAhPxqx?=
 =?us-ascii?Q?64TBtOr3MKdLWqo0/p+GBR3vSuW3/Ui3Q4TAq9Qi5MfAyS+GadZMD4oW+ftb?=
 =?us-ascii?Q?GOlhN8gIs1BnfsGQ1YNzt900ebzCWdLTBj8Kk4kaTNHonqra7Q6+kPPtQzqc?=
 =?us-ascii?Q?lGaCzqJ6DIqjOZGiXG9FQaXCoVdNuZoEIYyjLwItOHbqBeF7FQkny+puCFs0?=
 =?us-ascii?Q?6A1PdmktX6nBpaxKyXsbHeF9hCoAvIgYfyDadbo/p2vAk7Z8p0k6u3fE2O4g?=
 =?us-ascii?Q?Y+xgAgT8TlOIA3BX0RQKtynMvma/4i/gWZz1+z5kLZfTK/htsekKgk2zg6Ny?=
 =?us-ascii?Q?Elc9aY5H1GbVxer1rNG3e3xyZFs8/qFBvw0rNgFbFvredBxMSHu5q3xbSCGv?=
 =?us-ascii?Q?HaRzX25X8y1arPdjp55gCJAWrDUHodlQepJEN2ojs+DeLHh9MMSnTzGYM3l0?=
 =?us-ascii?Q?auihUyxqBqRagHzWpVlo7OrpCi6W1ZueZi3pmIAXSZ8N3fpfQyy75wpkIivV?=
 =?us-ascii?Q?HiiHHcDctkHRLUUmMkKhuPB1Qen+OTUGFJcw/jxgn3efd1jyvsmVcOuGZxMR?=
 =?us-ascii?Q?KMDPNFzT5D2BUed1pCoqDYalt59uYIXuuwuL6mqjd6JsvxCtIaG98uJ3jQq0?=
 =?us-ascii?Q?7h58dY/zkIDhU4cBKEX0bpfxypkfFioNdvJ8ro7wASlKUVWNOAJvll5ps1ZF?=
 =?us-ascii?Q?xY650GLm4beSSczQLNZqrn3xQob1R9rxPO5cvHPWzx9HRpM0pFb7bvJatZl4?=
 =?us-ascii?Q?jccHQfbxoQxSIlb7pvl8RPid/XD3Sy/PgExaQadb6p+57hYLbUYb/DmykxU0?=
 =?us-ascii?Q?DlgItiKG0g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e222eed-2305-4fac-c3f6-08dec0d7fb00
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 18:51:39.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmPEAIg+N6wu5CXO60jmJf+mYZvDNZYeTIvFGOQ2X4BXQgCHFs+8iZt9nOYaUO7hQPKID4tAPx0uFiDiAZ3GgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-294349-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:roopa@nvidia.com,m:petrm@nvidia.com,m:idosch@nvidia.com,m:chirag@nvidia.com,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C109F6313FE

When a vxlan device has vnifilter enabled, userspace observers
(e.g., bridge monitor vni) miss VNI add events and see spurious
notifications on no-op VNI re-adds.

Patch 1 fixes the missing notification on VNI add: vxlan_vni_add()
guarded the notification on a 'changed' flag that vxlan_vni_update_group()
only sets when a multicast group or remote is supplied, so VNIs added
without a group (e.g., L3 VXLAN) were silently created.

Patch 2 fixes the spurious notification on VNI update: vxlan_vni_update()
tested 'if (changed)' against a bool pointer instead of dereferencing it,
so every re-add produced a notification regardless of whether anything
actually changed.

Patch 3 adds a selftest covering both bugs along with a few related
cases (add with remote, remote update, delete-nonexistent).

Changes since v1:
- Retarget to net.
- Patch 3: improved vni_notify_check helper based on review by
  sashiko.dev:
  * Bump pre-cmd sleep 0.1s -> 0.5s.
  * Add /proc/$monitor_pid liveness check and ksft_skip if
    iproute2 doesn't support 'bridge monitor vni'.
  * Capture and propagate "$@"'s exit status so check_err $?
    actually validates the bridge command's return.

v1: https://lore.kernel.org/netdev/20260518165700.1975478-1-aroulin@nvidia.com/

Andy Roulin (3):
  vxlan: vnifilter: send notification on VNI add
  vxlan: vnifilter: fix spurious notification on VNI update
  selftests: net: add vxlan vnifilter notification test

 drivers/net/vxlan/vxlan_vnifilter.c           |   5 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../net/test_vxlan_vnifilter_notify.sh        | 184 ++++++++++++++++++
 3 files changed, 187 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh

-- 
2.43.0


