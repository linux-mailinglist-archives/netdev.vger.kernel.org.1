Return-Path: <netdev+bounces-298046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2sQcGAaFKmqMrgMAu9opvQ
	(envelope-from <netdev+bounces-298046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:51:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77478670940
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:51:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=Q+wTZcIC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298046-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298046-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0EDF30588A5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46BC3C4542;
	Thu, 11 Jun 2026 09:50:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC54A2EA154;
	Thu, 11 Jun 2026 09:50:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171445; cv=fail; b=DuEaUuumMi8B6x+4YHM870IQPmE6MhJHVdrLe1EfInFnLJZUydpEXo2x4FsAUNuTzBXM3bsx4M0lnEUNHFK/1FYVX8nGna9QpIc8WbT3btxgRPperNgdtCRnAhVuJLJj+4J0dE8WqDE7aoMIsq9ekP0wuUZnBOtK8/cxKi0ijlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171445; c=relaxed/simple;
	bh=v5kZaZKKAhQgbpNMlQKs04dcugvcpzb+w0VL5MHCKg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dFKh8vplNZccGYZdLMc5DLGVUopJSbPm634JcnByrhoHafgeKcvAZTuuGmxKjsheUPTitmpwKmlQE+AfK25ZwjkUZe25H/XfTN9YCoqnypv5ZCSQiKAhSx3ghhlw+d4UtL57aHe/Bffvaf19jVvM4JvQGM/9QMbrunPIECK7Lp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q+wTZcIC; arc=fail smtp.client-ip=40.107.200.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEDyXIzzdC38rk8RYFhLfNXF5stK3Hmgc/6VdNEOfzZxs1fk7ZwLuO1YlS2q7MZAqdczav0826H/WFbSF21mOc8aDhz73ieYy3lUjelKFHSJDnTiIv3TfK/Cy0Eb+14z1nfJm+zvjTGdABocOJvg23+Hi6lhLVo3/xCtxzK5ZxziL+oRCOoXByDz9MPwJnO9qxlNt4z85DOWMgZLRGGA9fVxd4qD8v2NW2aRWNJlvLYfteDzsilBoj4JB5a1xTeqYv7AXMZxLs1QXftH6X6tpovBo1rWmStrGW+xJxLhgUDuZ3j3CHjEmUpXr/HA8Q/43NygC/vrWvMiPeupryqppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fzo6siJddZi8BRfNQCavodLcs3h/RY3sLkykEjWC5ao=;
 b=MYIRifUQJ7se0ehY5nJC7HboHa4WzJWMS34217ol8skm77j+ub8mk37Y79KIpTUHYfrdz4qf1hVuW8Mz9yECwtMhoCRG4CzilGJnt+mZLMR9IQ7LsItkGvWftiv66JGNfdY719n9Hj3O9TbBYOoluoQyIpgZg65fjG9+bGmI64AVNJPwrtYSsIwRADlnEL6acXdp8ninjcxw2LDsbhoc6o8lwHhZ8xodQVBVPXk1NrBPDyKfZB32j4j/eGnEzC8UMp9D61wnfDTNAVA9NkN4D6VdJqrdtpwqfYOoZoCiYTP7YshLvZORXNCwH7Hz5A/w05apa3Yyp5xiEz54SmGbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fzo6siJddZi8BRfNQCavodLcs3h/RY3sLkykEjWC5ao=;
 b=Q+wTZcICB/r65tAgYa+oIOrCEb+ABAIRzOGP3luLQV+1qvfxD2KOKAldjBdw8l9FfVZnCZcqPa7djXB7ETAQFPsM43vezLt6vq102QqJ8QFiOe/+geL6v81T+WT7wjDA9b49O+mYzFiPhh/aKxDE1f+5YvpOGXJl6DhLTxBH/pg=
Received: from CYZPR02CA0022.namprd02.prod.outlook.com (2603:10b6:930:a1::10)
 by IA1PR10MB6781.namprd10.prod.outlook.com (2603:10b6:208:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 09:50:41 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::2d) by CYZPR02CA0022.outlook.office365.com
 (2603:10b6:930:a1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 09:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 09:50:40 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 04:50:39 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 04:50:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 04:50:39 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65B9od0v1626218;
	Thu, 11 Jun 2026 04:50:39 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 65B9ob1G014455;
	Thu, 11 Jun 2026 04:50:37 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, MD Danish Anwar
	<danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Meghana Malladi <m-malladi@ti.com>, Jacob Keller
	<jacob.e.keller@intel.com>, David Carlier <devnexen@gmail.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>,
	"Markus Elfring" <elfring@users.sourceforge.net>, Hangbin Liu
	<liuhangbin@gmail.com>, Fernando Fernandez Mancera <fmancera@suse.de>, Jan
 Vaclav <jvaclav@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Felix Maurer" <fmaurer@redhat.com>, Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v4 0/3] Add standard stats for HSR/PRP
Date: Thu, 11 Jun 2026 15:20:32 +0530
Message-ID: <20260611095035.852370-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|IA1PR10MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f8cc43-1b7b-4448-9b9a-08dec79ee5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|7416014|376014|36860700016|56012099006|18002099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	E5cbvSOWTn0086juRvqjrfZjMgtpzkF9sKig1PhJIQXxU2FYG08vrydAopu5FfGHbfXC2NJfD3avF+DpM0TvuAOBSnNAFhff7mcvsca8a5hkkSL3HnJh5fv1PnCqmid6Aq4b2vJdn/O1zAqBUDh+EoRP3raqA/CVOwKa5BoSAJKNbLMLAFBt5o/4Hh5teemk8FqDNI5pW42wOsmLWssdZDhXIm+bXWSaSBPmXMYHftrVSuxVlhkf9+JdiezsKIZ97B9+3oFDvjnrw9zBiTqfXy1o98CmeYT7FjXPQKyahEcXU5eRI9S8fyiQOd70khcbYxP47/XLVu/w/74xP+CGat2Jg33lWxPC8CYhKlZ8ose6RyWCscFr0W7hXk7nX2+uMAx8OWO6nmEex+jaOHt+/KQCdy4e0a53zpPays9nsBajP7YdGDyW7ydSJVjQxKyXa+MKrT7aKPDnklS9DIIq5MOMnrC4InDI7yiDtkIGTSRcdK2G435ZWm3UZZtv1pNIZdtjbP1lXxGecFe+TbB6o/ACMGqBRUwha2ZqhHznryh/LpC/lXmA5nw15l6ZH9wb6022H6LzxWWb7XAyqLLJHdgMFNpyHhIimx/obGXXYB+m7eTiyrGe3JeKENrBlEuiWLQAimiv4nZh0SyL6L7SGvDWaGLhUaV7fDtCLk9l74M9aoiHZ9Nb+07vYyC5SYMVOgpf4rPJjSw5xEqiM+oG6x0oEd79DCTyiWJMv+ze8qPv/Y5rwWpD58zj7NXYEvfkGbIj67LK3O+iHwNv75u2Dw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(7416014)(376014)(36860700016)(56012099006)(18002099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j/7hI56omp8kftHaozcQnoZaYb2PdGcCE02AGLSvvEsPhulumYU13M4gp/NvTyOLCzkhzlWTshMoEvFTa+Ez+p+L6O6Ymbhr8h4eO6SvJ+Z5i1FDZ9/U1mC2ApRWAg6SBVU2SuKPcy2OK5QqfniksMyne2OUeAJXm78bnLHfPGmaC0w+ryR+eH3XYYSTLyFSHh8vSYOt+ToOOi+pV5d9LxlEVAGlyInG/+QDCdEKMeYjKWWReO/a2Y6+7IhF9pzt35Vk9r5IHrxu8oIAMc49aeqbQzxazh8oVNzgeVppqUKoO+vfJ/TsKgeqF6vyCC4+IHTLvuZ5vrzux1yPhKQy/lcPKsP06pufuaWVmhITGxRRoxcyIxVyxXFY2txe7RwFBLxbkeGTdz44J2P75L224HVvx3W9Xyy3Ge1EMPjQLSGmpyaiUvo4l69KwZLXKgBt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:50:40.5814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f8cc43-1b7b-4448-9b9a-08dec79ee5c3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6781
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:danishanwar@ti.com,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:m-malladi@ti.com,m:jacob.e.keller@intel.com,m:devnexen@gmail.com,m:vadim.fedorenko@linux.dev,m:haokexin@gmail.com,m:elfring@users.sourceforge.net,m:liuhangbin@gmail.com,m:fmancera@suse.de,m:jvaclav@redhat.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:fmaurer@redhat.com,m:luka.gejak@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,ti.com,lunn.ch,intel.com,gmail.com,linux.dev,users.sourceforge.net,suse.de];
	FORGED_SENDER(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,vger.kernel.org:from_smtp,ti.com:dkim,ti.com:mid,ti.com:from_mime];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298046-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77478670940

Add standard stats for HSR / PRP. This series was initially adding HSR/PRP
related stats for ICSSG driver. Based on maintainers' comments on v2 I am
now adding support to dump standard stats for HSR/PRP.

The drivers which support offload can populate these standard stats.

This series only implements offloaded stats. For software-only interfaces
Felix Maurer had said he will do it later [1]

v3 - v4:
*) Address AI review comments on Patch 1/3 and Patch 3/3. AI review comments
on patch 2/3 were not relevant to this series.

v3 https://lore.kernel.org/all/20260608100930.210149-1-danishanwar@ti.com/
v2 https://lore.kernel.org/all/20260514075605.850674-1-danishanwar@ti.com/
[1] https://lore.kernel.org/all/ag87pBZfOyccPZTc@thinkpad/

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Felix Maurer <fmaurer@redhat.com>
Cc: Luka Gejak <luka.gejak@linux.dev>

MD Danish Anwar (3):
  net: hsr: Add standard LRE stats via RTM_GETSTATS /
    IFLA_STATS_LINK_XSTATS
  net: ti: icssg: Add static_assert to guard stat array counts
  net: ti: icssg: Add HSR offload statistics support

 .../ethernet/ti/icssg_prueth.rst              |  19 +++
 drivers/net/ethernet/ti/icssg/icssg_common.c  |   7 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  10 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  92 +++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  10 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   6 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |  89 +++++++-----
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |  10 ++
 include/linux/if_hsr.h                        |  48 +++++++
 include/uapi/linux/hsr_netlink.h              |  56 ++++++++
 include/uapi/linux/if_link.h                  |   2 +
 net/hsr/hsr_netlink.c                         | 130 ++++++++++++++++--
 tools/include/uapi/linux/if_link.h            |   2 +
 13 files changed, 427 insertions(+), 54 deletions(-)


base-commit: 0068940907d33217ae01217f84910a5cde606c17
-- 
2.34.1


