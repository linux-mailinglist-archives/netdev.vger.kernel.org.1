Return-Path: <netdev+bounces-282239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPiDE1Kk8WnxjAEAu9opvQ
	(envelope-from <netdev+bounces-282239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:25:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E929E48FBCE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28006302AC39
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B2637B007;
	Wed, 29 Apr 2026 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uj360UCZ"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C061437F72F;
	Wed, 29 Apr 2026 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777443892; cv=fail; b=E5Fm4bOU4WF/0XzxPX9GuNB8XNiKSDypvtpw5C5Tuo611oFTRolClKvtUmk87OwU8BDLOda52XAJ6Jo+sLn8HURJnfLxCSkQqcpFobKaAjb8Tjs7epegl7qceErA9682v9slvXqLE9T44BXunaVp6L9b9s6DS826GsCLy0CMPOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777443892; c=relaxed/simple;
	bh=l96A8Nks6Ig8S6KMF4rfgK+ht/1z2kCNTTFC9huu3GM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=in/3a6QZA8VOSSyYiCSDmdEo3BsAXZ0DRdQa5kC2CnRGOlw6N6mwKiQVmMDpAKb3WoWvXt7EsWCsmJsT049oLmdTNRiLg0Nd2z1Pnh0wvYyeVZ/0VTVD/AESUtKPwQPBWANZI+Q8eNY6teiyoPCUlzAbIBBpIE2zxjuzNE57IWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uj360UCZ; arc=fail smtp.client-ip=40.107.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDmEEclHjEqOd7gzU7WtvVJcVWrtI0qrSJZdROZZuLVF3E0GCFHq5onN1oupmGzsPXVD1yO5dhPbZ68isZrz3AhBkNBAIh8Lg3oda3hzLmedily67AcBMX0FxKBlq/TB9Ghm5ihf1E2vy3GWejR0X59E6r/GxyoFDBULaDj4zNBD5iOLbyLm7mSpyVbEmNybskQp8mkDrIW8sRpwfdJAH1rlfXRNfbLsXspdiynthSkCIcZT8dQsCFuIpcvSD8gBkX16wqQVNGKz5eFeyR8Vv4o8yPBVBat6fAu9/Xi3EJv0JsDHtm5gvn/Rzg7CrFg2ouUdNckd8W5bNHSR7dUy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kha/dDdMCnnc/aSOcpu627ccdMM19jR8fYNL7mhYOmo=;
 b=sRRQfdv3WkVjdhG/tHITGu7IX/2NaPRDpUpxqUaLXh0HgLgnoYWb5C9a8t2VCKd8D+HWIckAsdeXKNqDdWBWwcwPNT014sjRp07azXMAJUQBKdmGvTlWHCWWBG6JSo9LI3Iox/TBOyhGcwVvrkKiEHl0LeXncKon3el2HPWuJbO4c4STIFkVKVI7btDdXr/V+Wv4tS1x8bF5pIRSs01OBjMJWzBOdJbxF91PjYItfnzlZhIZqy+gVWcRjOwiK1l4Y1hiKKPMoGgT2Z6sCjhx925fzSE7YBtbr4DcGm/OwnHGEgu5+HGO80v3o0DmZI5Iu5Eb+q6KOCgAVTdBxviqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kha/dDdMCnnc/aSOcpu627ccdMM19jR8fYNL7mhYOmo=;
 b=Uj360UCZqZt0SyEJfXg5gk4+Wj4Ik2seomw0ZBqVdJEG1wMkfGnNqX9GwwFo94Xl0einDGunOb/V71fBh7DNQ/TxUDYMZw/YgD1GFe5Tb6JhsWyy39PAxB8pqI6wEM7UEVOvCWeA9Vnn7O5rJQE5nHTsUFCnhrZr16WEcc+fNBDprXoc4UVcUbhZCZuuKttJPTVCUHEDbptGiWoMSdlul/lUVKGjGDfxR6zzkI1GTdDSIMLOUFTt4HcZD/2ELiz7uEfbmrDQyyftQV0SgAmC0Dep+TeVel7DXkU6ftFBGMTkLadCFGogns39BSUvObClrdcIr7pt+SfT4wMTddCorQ==
Received: from PH7PR17CA0003.namprd17.prod.outlook.com (2603:10b6:510:324::23)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 06:24:46 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::d2) by PH7PR17CA0003.outlook.office365.com
 (2603:10b6:510:324::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 06:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 06:24:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 23:24:25 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 28 Apr 2026 23:24:21 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <razor@blackwall.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <shuah@kernel.org>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH net-next 0/2] bridge: Do not suppress ARP probes and DAD NS unconditionally
Date: Wed, 29 Apr 2026 09:24:03 +0300
Message-ID: <20260429062405.1386417-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 989206af-beea-43bc-fede-08dea5b80222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U+nlyF58+iuh/TmAPdIg4Q6vNbSFdsqYAbGkOPF8+ANV+tLp0UgYmxAKJPggwyELWer3TVWj8j7VJxkjtjz9yUAWH57mDDpEcgTHYGM2fv2eU9t3p8Rf09Zb8NK0eas8mTAHIMdsG45UY0+U0pXt+qYGntHXhVGIR2X3ERASAXuiHKHuut4+ADGI2jtBIf8UrMnezr4OMALg0XWxC9BrROpm3Naqd17LMwSQKURToAiukptlXQWBqVWaFXpu9XCj7VCxLLSeiM9k8bw4BEsENSeAp3ELFXQXQndfXsQf4PEJ3hBLbBBR1dprnV2zFEb3RL9sFjYyn/tqgkF8oHdGnlqotWBjL9ga8dSQH6stVba/uI0dhZTF06G9rW09FvWXa+ZwKSOJePWhmUYInfE9AwkVA70bvK3ziO69l7Dc9Emognin+elXDowKsrVG3WUtO09tNstYLeweQpJqHnXPLJs60ZjnMzsIwkQYTQMCBgbE2GBRsnTeBUstYwA7HqUsf6NE+/yh166VPtCguWHvW5B+0NB3CbYYJrY0pg0j/pvJKT3bm7dREidZ10sF9LqCGavGfltcEZtFfbYcRFJBHaYPqDOlmQOW/8tu6kaBab1T912p7ghmL3qqVKYWrAsmLUZLKDySVWAmO3MItuwPESZDMB+nLpB6E39kRzgreKuYch+XddbC/Sua9DrMQz+8FsKDa/wiphsd+yK1z2wlyeOlmHv2d3lyjuO73BwOmFQRn7VZLqlHcCO8UclxngDdo7kC96NtcuH/M/wqzqXaJg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aqmIVR+4cckaYwmqK5VacuogVzj/kF0ge9tYvGjF7qda9WA2Mb8Cp30PcwHHpwo9w9og9UvS1ux/UKWpluKvJsY2PtrqiOCIx11p6sizbF/nthMhZGA/vhb1/raUh1LODu5cjlEP9DjAP0yOpP+vaH/8oqK4c/VTYqvVcDF8OY28BcQpklJFJqlF3ZUYkVC7tHxRYYGMdVTCEJ0hRzT5N2gu0M7TpcIPl2dbuT+m58+8X6lrNGd/DFux7GirtBPSgRJRn1p2nXjPQuOxjE4kxpLpqDKnqxDXnXPB+vzbZEaX49tdTainBCnP29dgB0FYG0/gR83Qi/oXGeqaPYp3mAdcMs3mBPQQOHW/rda8ak7tYKNu+Qt1bYzcnel/mPeijbhGnYjJGSdWFAQMm2G79D+qYFxkLIupXJawwfqn5flcxf88DHbeqn7eCR0d6+K6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 06:24:46.0309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 989206af-beea-43bc-fede-08dea5b80222
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
X-Rspamd-Queue-Id: E929E48FBCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282239-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

When using bridge neighbor suppression in EVPN deployments, Duplicate
Address Detection (DAD) is currently broken for both IPv4 (ARP probes)
and IPv6 (DAD Neighbor Solicitations). This prevents proper address
conflict detection across the VXLAN fabric.

The neighbor suppression feature allows the bridge to reply to ARP/NS
messages on behalf of remote hosts when FDB and neighbor entries exist,
suppressing unnecessary flooding over the VXLAN overlay. However, the
current implementation unconditionally suppresses ARP probes and DAD NS,
which breaks DAD.

For DAD to work correctly:
- When the bridge doesn't know the answer:
  flood the probe/DAD packet to allow remote VTEPs to respond.
- When the bridge knows the answer:
  reply to indicate the address is in use.

This series fixes the issue by adjusting the early suppression checks to
exclude ARP probes and DAD NS from unconditional suppression, allowing
them to reach the normal FDB lookup path. Gratuitous ARP and IPv6
unsolicited-NA messages are still suppressed unconditionally as before.

Patchset overview:
Patch #1: Fixes the unconditional suppression.
Patch #2: Adds selftests.

Danielle Ratson (2):
  bridge: Do not suppress ARP probes and DAD NS unconditionally
  selftests: net: Add tests for ARP probe and DAD NS handling

 net/bridge/br_arp_nd_proxy.c                  |  16 ++-
 .../net/test_bridge_neigh_suppress.sh         | 126 ++++++++++++++++++
 2 files changed, 137 insertions(+), 5 deletions(-)

-- 
2.51.0


