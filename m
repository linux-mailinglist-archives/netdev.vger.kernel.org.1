Return-Path: <netdev+bounces-266099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LrrJjMZsGlAfwIAu9opvQ
	(envelope-from <netdev+bounces-266099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:14:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 353CE24FC99
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD11533AF932
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50283A16AA;
	Tue, 10 Mar 2026 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JGJU7YWa"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91538A710;
	Tue, 10 Mar 2026 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143892; cv=fail; b=ktP+DGAz7dUSWs+vgmt/GXgY2bhlx+YPgtu0Lso1kjlaVHqtI59A6J6dYOFTYYCSVaXohy/9z93gtvqQrcZufVx/Sklrr5FI3MyFylw/PxAP8DpYYEIbOsUySxU2ZFMhXf6C52o2O6YJGpSDPyzx5MxLLQJ4RCnxE9yMY90qR1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143892; c=relaxed/simple;
	bh=8yC++MQkbJTu/HjbRmoayqlEQQJZBfdqsKfrdmjvv1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GIVFPmDugfjNv818LnI9NneGZuoaKxV4o+vq+YOnv0U2ZzYlRGoY7TNaBPscyon1M/rSzZel8K1u42b0sNN0Qvz2zW0D8KakKyluWSdtWFksFhE9TS2u4EqK/e6upPzWBgZwvl4lXgyQy24yKqbOU7ziW5S9nNaemMFtF8TkPyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JGJU7YWa; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdGzL0wzsvPyO/BGcZBuiL7SBJoLdXnArSk+R6CeF4VBpRVVizjWnlYxNFMsf4fj0rlCfdMTYGYUEGODkEK7PfVIfPwGSxISwQR7XN3ZviFFDKbOfrCpEBVJdty7AitYQt6XHNpobZuLSTgejVzfgN2/fVfH2sCFpP73MdMp4tcidBSu+rpODc6mD0ZwDUU650tECVOK7fIBwXYO4JnQGqkEtwIDc3Z0iqBZ/xfr7IK/khP5EuwCT+oTtUdZpnOxGRtcMIB3JQjiUNzUqO4xyUjrOTNuJcY9GpTVKki4ZYGHI2h39aYQkDD19K1sISMFbq0N4LpB9j5+E0dPkk6lWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6Nn/mgL4cRWYJ77/RsNlcn2+gIwIxL1LsQh8+Sg7vs=;
 b=qwkI0KaSk8aHzxvJnh3NdpmS5M0r0Wo+Sn+ZG5PdWUetJpJgHunZOVNok21LTfueLBYSbjIDdEUDh4YNMyCOC/7nvmHVAYkDvD9kP5LAoP4Hurmp13Za6PPkHeBKBZKWV5TMy/cH5IQ+CLtJ1k6q7xyElOLcpJex6H7/Lv80q7h9O05K8e2JtpBoecEOeWmEEdWDwyP3UcM28dOlcNE+DKncembwE1Nyimy1VqD602uEypT647HutVs6YysIt2es7JKx1yqCiGd3OKlrfR1rrVZR4DuDWZdw0+CtlQHF7wa93bffVhxot9ppj/LGdxxTfuIFZwVoL5amOCW46klEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6Nn/mgL4cRWYJ77/RsNlcn2+gIwIxL1LsQh8+Sg7vs=;
 b=JGJU7YWaowPmTIQtOJsu2vBp90kHoy43BgL5KOT/qDbUasInpoVfCt3eCYpQ7Nz93kSvREM+Ws25SaVSBOzHglvox1qjuo3cD/Kz1VhIu9iPQSPO1R/MJ92riOxBjdqn9vT9Mif9pmp65z9Jcm9T3VUF9Lz4RxgdThs6N+SQKWN8pgHgr5en6nWdOO7+xPzCE0J9SZaNH/1WRYZNC4ra0B2VBU/GRXhoI0DmD/JjwP3gxXqxJjxfoHVlTmXEo3ZBNryjkQJUprXsIe7Mkg9ewRLhWDq5viiInBc190+7y0RgNv3/BVck1KHVxFenkcgfD0LI+fJ0cLj6C95QekQjWA==
Received: from SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24)
 by DS2PR12MB9640.namprd12.prod.outlook.com (2603:10b6:8:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:58:05 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::a0) by SN6PR05CA0011.outlook.office365.com
 (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Tue,
 10 Mar 2026 11:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 11:58:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:57:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:57:49 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 10
 Mar 2026 04:57:47 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, "Breno
 Leitao" <leitao@debian.org>, David Wei <dw@davidwei.uk>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next v3 0/2] selftests: net: fix cmd.process() timeout handling
Date: Tue, 10 Mar 2026 13:58:01 +0200
Message-ID: <20260310115803.2521050-1-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DS2PR12MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc7f490-0265-4c70-2d0d-08de7e9c49b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	pFgBNINd2mpBMXG4Al8YSO501GMQtD1DYnvgN8bNdn8Ih4qmPG3RLS4+nZxMKejQQB/6IIn36rf03Lp5zGo9ZQ9e6AqzARVVUFhxXO4ad1g0jLOCC8ky5fi7/Ej8lxpDELeFQdH7N2MzpIdoPbSMKrk61uhH75QU9L82XQZ1e3Xt8xlycCiC4fikvvCZeT4zl6a0S2aL3xLGhZH76rF9e0Q1/Af21K1MmhSeK6kKPIXlJak4WwNXzqSAa/Gw7WMDQnzOmMhCEtGiwyVZt8F00yzrH9gYlfqBWPOM+3LvVI4zCTIhiWCOW8cUgXhkk68yXNb8HUoqRwHU4KiBGmWOLfw7g+xUPCPP3gh8uDGy4Ub73LRAATMyPPtv/8+QZYT6ohsFAaqchqFJN62QDT0+BU9nJ/bYwxI4UGmn35QcDqJNt1BhYmUHvGnktGxu/I3EcG6sZ5ormXNdpGP5/gqYu004JhQGFg9uZnMewaO0grthCARU+MD76lDwwUb/zQtG/qC5p3OxMDMuowfESIMsFNF5yCNVVk4i+eenwwA40HJni+za4oMorSKzTtm74LIh99F8m7s/5IuJiZwMqFgS+GPspBByVuIk1nZN07cRyyR53PEbwanNqOrcHA6KSELTFZMSBy1p4+HshlsqnEAL/P27/zpOaIE7/9m2f4uweWYFE0/h6mT/gHd6YpDLGsxdXSi9PbINcEshzDJDoJBLsPhppuL5nJb1YZoDtjv25Ykblj+80ScJndWSGDMsNJ26iGpRApfqnlgSeSfm6tlKRg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W7PrN+z1a26iAq/U7wVxDNUdu07w+VWYIhEbXh/n73zYePhahaBZFe4hyRPoj8XiRxYJPwI7Z64LEw8+jtRe7Dz3rULg2a+oRCQ8/HPlJcWk54K71cNUEuUURZ23m9vW+CTH1D7eQQERGLXXoa3IlzpP/LbmGBHKwUNVsTeildWs6uHSEiAtZaaEzZpFeFZ6hn5dsSmJHoo+G40pcymJA7uFA6Yf3FvPdHuEuRfamj8pb7N62Jb+pLlHEg7D63+uH6VWk/nd3rOv0SB2E5Ppldy42SFEzjfWghQIfG+921QbNL359MwL9Y7u6M3Hd5Lm+Zjc0sEfCZdfV2XXnJwnP8YU2UyHdpMW75PyN+KH4Ym4OeAZuVEvbP/OwHezWUYa0G6aDlhY1jEwhOHzuBtfWICKP8BdQR6/FxS8oEPisE6+DMUlXkffKDgknQhJh0Ok
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:58:04.8164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc7f490-0265-4c70-2d0d-08de7e9c49b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9640
X-Rspamd-Queue-Id: 353CE24FC99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266099-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Pass the timeout argument correctly in cmd.process().
As Jakub noted, fixing the timeout broke the bpftrace() command in
netpoll_basic.py, so fix it first.

Changelog:
v2->v3: https://lore.kernel.org/all/20260308192126.2490631-1-gal@nvidia.com/
* Resubmit to net-next.

v1->v2: https://lore.kernel.org/all/20260215125149.2106612-1-gal@nvidia.com/
* Add patch #1.

Gal Pressman (2):
  selftests: net: pass bpftrace timeout to cmd()
  selftests: net: fix timeout passed as positional argument to
    communicate()

 tools/testing/selftests/net/lib/py/utils.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.52.0


