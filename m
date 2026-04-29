Return-Path: <netdev+bounces-282292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENiWKzzB8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:28:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 247C44912CF
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DC763029606
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221BF3B27C2;
	Wed, 29 Apr 2026 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dQyAdf2Z"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878883A4531;
	Wed, 29 Apr 2026 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451314; cv=fail; b=WZfNFASDTf/9mjimixWd/irhE4wtHG6FYgtxUsgsCreMNlr3l16mLmJkpAKA/vktJJUF9YAHQSxNZLCYoAm3wjdq7nNvQ1qdp9UZ/epB9mv3iZuJ+hqMtWOp9lEhDhdndryR9EBCwBtk6qaG3OCsXDfyHE7VXBSgYh8AdCvJVRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451314; c=relaxed/simple;
	bh=pIUJk0wLG92DIU4ddDL2GO52mGjqo1xRy7WAUv5L4zk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=h5LhK4Ys73xupx94YgeACrsVsg2DBRm4nQ4IvlQOcmT/Fj4CxDv+rtvjGXPXHttR8/gd2lUD1aEqQ2wmWm08w/cMjgM309rmgOZdEKkbJqkkPuDyK30DBlpn0TIAnxTZr+biZEKwXjmcj6tEHdkqGfuGxtMSAqROW4gOv0Doa1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dQyAdf2Z; arc=fail smtp.client-ip=40.107.209.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYOXZMuzYnwRQ+wdxOhJhzLhNkp+7tfahY/mEZnfvFfq6tw9T4Q9+uEB9ky1crNAYcxA+PdDmGWQIcm06XYUsUwyRVwiFJye4JJnqth6jtCh7OT48X8lxV2TvQMTXW6Zk5JnZCGAHp9EIx+Qh49Be3nRjbF5kZ4v9GjAwaGGjmdUCByoF8fs3cE8I/VEX1TwwYj8VmR6rYj4H0YXNJz7PLflmDVs6nvMR5Vxh4Ih20mVUvMa8pj5H5s9qgqtyUhs+OH0TsgD7+KmcWfyl2ogzZ+x+FvFjElrOGHZOLC7717iIkbJul7gZRRrk0kSIWpbsBihLJwwa6EWvvP3jzvGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vw82YlpyET/p7R8ZfzdWPG0dOhtyHWAea8uXfwjtdh4=;
 b=GWqQf3B0yV67EOU/DG5CFhy9JrbGz23dGZ0qzPepFYCqGrRqsu5UR9d7d2n6A6tbW53pQP+LfBhVonCPO83MTbg5pHVqzQ6L0Sl2XdiY6ohrT/K9R2U0oQs5sKgHPNFYGqOEChGZiNvedvQkN30NtGWczVpLIaVMysW+UnbGpBVZ/OZ4Pj0z4TZqND8eY7Qlr1EtTCZm4rGUxwTZMyqEMuAvFNaTfmVUleZfRFceZpdbZGLsmueNqQx1dXo3DEaeXIDVUwLU9Yj+7poMXu6erMOEfQZShcvzdldZ9SHpTp4Widi4w5e513vg0sms0lnZX2bQFhEQlMhsyNYovMyU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw82YlpyET/p7R8ZfzdWPG0dOhtyHWAea8uXfwjtdh4=;
 b=dQyAdf2ZFjJNcbEKn8WTIKGqzKxSf7RwmBFfY3Cnr/UGfS8O/NqUqV+6SRSMkOGpWJ7zLBNhDrFGuyJRhYkvq/b6Z+xKZMJod/aRAIc3QwqjLbm1H4KDnPK038j1WpIPlo+L+O6RoqZU78i1N4TS8UaXBHdRgJpFgggUqcb9XIo=
Received: from MN0P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::34)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 08:28:27 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:52a:cafe::b5) by MN0P221CA0014.outlook.office365.com
 (2603:10b6:208:52a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 08:28:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 08:28:26 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 03:28:25 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net-next 0/6] pds_core: Add PLDM firmware update and host
 backed memory support
Date: Wed, 29 Apr 2026 08:28:16 +0000
Message-ID: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACDB8WkC/22NQQrDIBRErxL+uhY18qld9R4hi0R/G6HRoEFSg
 nevdd3V8BjmzQmJoqME9+6ESNklF3wFcenALJN/EXO2MkgukSup2azY9rbrL+ceBWrSNySEOtg
 iPd3RZAN42pmnY4exNotLe4if9pJF6/8Js2CckepnNFqSQvOYVns1YYWxlPIFbxss0KwAAAA=
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
	<eric.joyner@amd.com>, Vamsi Atluri <Vamsi.Atluri@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df66734-a462-4c11-7d4b-08dea5c94947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EoR4YthWSxiRljn/UZ2LrAWhtoKdyVDpJUfu43k62k6GMl/R1+W7/Z4TZailaVZfbIRezropb4+OegU3rOss88gBclrQiUBzCiHAlbhM3EuIBc8o/vUX0vQrsJK8zTlPU5xIhQcwjBgxYS6WJTE7AFb31BC0hEsSxvPFUzylrn0q52+3q96u33SBKUab9HZrBK5Ot3tR2weuW6NTvOmESbGIIQ4OpmPW90xCsVOggEHS0H7sAjq91C7ratd6MIDIqdL3aLVyVmdUEg1atoOYqmU8fk0sm7zxJIinGDoK8xRTCO+n6F4vUd6RISBtgLOa3DWdDl374tqIqXzSiZIwvEHZ6QT+NaKJ8lXv4onx0qS/3JGl9XGXFq4twVWef+h5Y6KCaZ586UwQT1T4gc4kj7t0xNmecYpdiyPQ32bfbA+GAc233HqFkcTdilzenQ6vcomHE1uDkHZ0XasCE9Zuo3P+JY8Iz6HrvrEqXVoHACXHlkSW6TgQhlK++aGBJqFyFxL6VdYlojo0zmxu9dwU5T2gay2lAY/LJtBQRY7waSbE23s46kCSVhTxYO9FONV17kpGxe2201htr+c5zbYKUnk3vOM4p7tS2Ab9MJU/tu/gmBFHIMeQIIxzgLTvImPQkClBwT7TwuVhBXkPJxili/ajr5FIsGpaWhOheqouyyvJvZgowAoYK5PWvSzFq1XqBDqec6MNWz6Kt1fRo9kTtQXDUCQLDZeqynVM8anvT9sn7BuQA55JYl9bid/2zBhkRoeO91UasCrN49zAe4MmnQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FBlC9bWJNGx43J56CO0W46IoJ8IPCFQn1KAkOGL5LyCKPhd935CZ51gY/34mQZJeBK359eeP4jpCSbjx05gmnbSnZ2DOqPoVKp7FoMrTUuuxESdscGXsItH056HVQW1bGi/ucvfHeyugXchL3JEp6sMqJ/sDLIwH9jc8fYFsAHcqPAwKdjO5ICFCCcNU+AXrV1A5rOqkbThEDQGXbfF44OeyO297g00WXHMnPOVHFWEYOBoES5Jwz6OKUZJowl6LAE62s4pF8B0GP7iMYbLRFjNJ/n6PgR/U5ivFQfXY3ym5JXk6qI/eDjBH5Ik5h7Q6lajZxbPuLQi4duEx6GzsL3zIJPmlxvOoWY6+TB5kqsktirRTrunNADFVypWySyJ8HaE7xKotEOEVoMScL7lkTC8TCYwBAiwYNKeKJRXhP8Laes8z6yOGqNOEFMIiX//e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:28:26.9263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df66734-a462-4c11-7d4b-08dea5c94947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
X-Rspamd-Queue-Id: 247C44912CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282292-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

This series adds PLDM-based firmware update support to the pds_core
driver. PLDM (Platform Level Data Model) is a DMTF standard for firmware
management that provides a vendor-neutral interface for firmware updates.

The implementation uses the kernel's pldmfw library for package parsing
and component matching. Users can update entire firmware packages or
individual components via devlink flash. Component information is
displayed via devlink info, showing firmware versions and update status
for each component.

The series also adds host backed memory support, allowing firmware to
request memory pages from the host for its operations.

Note: Resending with net-next prefix. No code changes from initial submission.

Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
Brett Creeley (4):
      pds_core: add support for quiet devcmd failures
      pds_core: add support for identity version 2
      pds_core: add PLDM firmware update support via devlink flash
      pds_core: add PLDM component info display

Vamsi Atluri (2):
      pds_core: add host backed memory support for firmware
      pds_core: add debugfs support for host backed memory

 drivers/net/ethernet/amd/Kconfig            |   1 +
 drivers/net/ethernet/amd/pds_core/core.c    | 166 +++++++
 drivers/net/ethernet/amd/pds_core/core.h    |  33 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c |  43 ++
 drivers/net/ethernet/amd/pds_core/dev.c     |  86 +++-
 drivers/net/ethernet/amd/pds_core/devlink.c |  77 ++-
 drivers/net/ethernet/amd/pds_core/fw.c      | 699 +++++++++++++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c    |   7 +-
 include/linux/pds/pds_adminq.h              | 132 ++++++
 include/linux/pds/pds_core_if.h             | 381 +++++++++++++++
 10 files changed, 1603 insertions(+), 22 deletions(-)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260429-b4-pldm-b4-b36169e986e6

Best regards,
-- 
Nikhil P. Rao <nikhil.rao@amd.com>


