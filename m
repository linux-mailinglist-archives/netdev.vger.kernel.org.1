Return-Path: <netdev+bounces-296467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZEUIMDeXJmoVZQIAu9opvQ
	(envelope-from <netdev+bounces-296467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:19:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48331654FAF
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:19:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=Ubk2aPQR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296467-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296467-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08BC330AC614
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FDB3C585C;
	Mon,  8 Jun 2026 10:09:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A683C3C00;
	Mon,  8 Jun 2026 10:09:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913386; cv=fail; b=ma5Ge0TO43VJ0S6rE2PcvHTom8fuGUsfVUxaLV2DhUH/Qf9NQWZfcrZtDrca1R4S8wVfDEdDc9CfSw9gkwv1HbFC5usN0nd5NzttwzYJhftHAIKt6TxK8uLjCaqzrd2FmyzvljMOVjglz2/7JC27QxwA5egM8wiJMFRFxkb+tUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913386; c=relaxed/simple;
	bh=Cjb0EUJNw8HavnHtDEhb8irI8xapiqbwWAI8/frWQeQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tU19FHtRAzwNHqk/4zM6a94GouMkrCqLIucWeyNXlW6AP4f2mPhSyK/P7+sHRDuBD/+v1QH87PPOBorYy5u/z7qd6mV6q47qsF6lXlBF5Od4T382HW01LfjQCaMcl7u7JKpOQf/IvdLfiZGAecKJzoKEbyWUrF7OZaCLGlO7eRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ubk2aPQR; arc=fail smtp.client-ip=40.93.198.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+2BYBWFI89dPvSCsNc/Ef4eu7PYVI6DkR7XNxkeoZeMYABr4TiCf7UwFvRkuePzVHrOzBwv0d59Kah8yoFQzDvo8S3VZFiWWt8AV7kT2tOOMr+54FyoxEn1AaKmi44xeitNXPqCqMrnkp7+XQkS2K/JKhJkuaobHQ0MCrKTLwfKVFpOZC8L/UsM7CYJ+ykL4xI8+3UnhMBlr/edQHiWBswIrxQQ0WSSqxSzG6SSd7KbSF8dmKonjU6KneYaJ0RJmTOZRcCl3lubERo7rvvv6jPa3+Y8/5f6YY58HndA/TStrWXRjO9oFvS7CGgzypOz1XnyBrBc2sf74gvSslUFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TwgCOHrX/CCMefhBQdSIdz3tGvrM94cLGXsrtRbHkw=;
 b=RROqTAf+YDWsJ4oK+l3waxDu3PPwstY6QKrE9vcfkAJ0wHEuwZOrU5+x7tZ59aq4P3U0gODQC/+tZNeTOTScpKpCTmaZc0JIQkBskkVAyEu5IeStIhd62ec5BltMDN6Sr/tDmkmORNXAAv4cLYjd5bOfo2K7Gqjx4w7zCGdncE1k6Q9hjLfyL2mxKeFLZABZMc0tqRMdTMlHAmFndYevSuN2yzK3ULVUjXCXSNZwSn4PdOwgmEY/ulbUpHalSUbfsf0QMpvOjAd0b4yq82L5ThVGiBz34sJnDQPlg75hFvchEAINiLqA8x20nFWIbB1Hmtnbj0DRGzxEmd2SpTB+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TwgCOHrX/CCMefhBQdSIdz3tGvrM94cLGXsrtRbHkw=;
 b=Ubk2aPQRBQRfZnq0uwEkR9Kk39WHuoXCmiRhMpugyf0roGvQJB8lheSXiI7C48S9hufoHUz2jMfmIcNrLAyn8eT+QDfF/nkutLRqo3UEKSYi19cuEZ09LaY/ovbhnZLDFNR1lq0ngMWUHK6xBOGvPk0OlrKvRLi2y1GhvKgmJEg=
Received: from BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::23)
 by MW4PR10MB5776.namprd10.prod.outlook.com (2603:10b6:303:180::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 10:09:41 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::a8) by BLAP220CA0018.outlook.office365.com
 (2603:10b6:208:32c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 10:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 10:09:40 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 8 Jun
 2026 05:09:39 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 8 Jun
 2026 05:09:33 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 8 Jun 2026 05:09:33 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 658A9XFd3995669;
	Mon, 8 Jun 2026 05:09:33 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 658A9WJI015180;
	Mon, 8 Jun 2026 05:09:33 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, MD Danish Anwar
	<danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>, "Meghana
 Malladi" <m-malladi@ti.com>, David Carlier <devnexen@gmail.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>,
	Himanshu Mittal <h-mittal1@ti.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Markus Elfring <elfring@users.sourceforge.net>, Fernando Fernandez Mancera
	<fmancera@suse.de>, Jan Vaclav <jvaclav@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Felix Maurer" <fmaurer@redhat.com>, Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v3 0/3] Add standard stats for HSR/PRP
Date: Mon, 8 Jun 2026 15:39:27 +0530
Message-ID: <20260608100930.210149-1-danishanwar@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MW4PR10MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2f091d-bb3b-4f64-6d9e-08dec5460e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|6133799003|18002099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	0u15VUqRykb3hM3vpDLu3aHaxP427kwji1WDHu9qH5Ys9LG5V5Jp0RMFFzvRaNe7E9CpmpDhlbnQZrkaO08uSBZHf5pAhXQH5CD/+rRj2AHWivrXkaeaqcM4j/bZJjyNxMYGvMiksaPW6VsSs0wmiPLaTKPAgeEU/fjkYeaExziMFftmPToJjuHArgxOFtcmUgHIZLuaRkXp1/4xpVSblKrqCJMFilejmvRy4Hq2WOtJzWDRokmRxV1HOGsZ/BbDDhSFw1tQ37+u8c5zyQvgQOE4r8uMGg9NE1lXnNPZhgAucvpaqmreGnqqBqJPGsbOh88oXPKhHenHzHRvaOTZKlWdRyTcAcgQFSZjuQMJbvhqWKtRrpN1Gg126aGVZ9dClIooaebdbL3JvbFDZcfoaKn4Dy6dbVCtfUX8ZpiO2Fd3BtniDK+pr/jG5XpVgYVh9o0XRWQdRwSxodv5bRWhwJJU+w+CY3NLLd5/yIkvU5o1e1z6Qt2QWMgJftGbb5dvcW2eeaYyQzSwkKDsUnUnBZg790hSvivX0PQtEFyY9lqaaoWAwdmPeMmbIFaUgBXEZOScMWZaQOjjQHFummWpzdnBdG0hhXxoO307a9tlRN1AQGVUvXaICz/b+WGJqn7v7jYxkvPTiwqMx/YTWlKhJ5U4YN+VFebBC6s/pDrLgEi3jy23qVCDUkvEL9gApseLktHv/QABbhsfHL0TNoRVvDwgRzOgFULHkVCFY9Y6i9Q8w6oT5vsjJrE4IvurVKHYF4CdX/Gx+SxZaobaCtdoFg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(6133799003)(18002099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UBsRBujq+OttRz97z+v1knsgg+t+asVcea6buufXhivCScWe+W/IW0/1+utDoc1yXu9E2fil2sAQKTyMR+fx/rwHrj38lI2m3O8krgRywGfvZTPtOFVqHO8SR2dX6LxufsM4lmWWl/ghHT/2mWKNgTmv2P2/U5g8lm4IJyek/Wxg8ydt8ED6vXW6drKD8yt7F07E/W9w+HKgtf3U35yH0z/lvwVeEQtZtG/JJBW9HeNTdZn1eTbP5+goUjFG2R8OIjCi85LFWjwwqnT7EKZrmQOqt13RfVf20Pu8yM6K0OToO8/H9nGYx7vhd3BtQmiYV4tf2CAEf3kf9LqR+lzK57PCU99o/b2oeZCAMUUrwXw5SWqPs9ryAWORFJ/0cJQ32tM5d59tI+PUb8U45tWhO9Z2VwnEVNXqpy4hXHGmKM1cnZEY/7IVYIx7pJFbTf0i
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 10:09:40.5896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2f091d-bb3b-4f64-6d9e-08dec5460e09
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5776
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
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:danishanwar@ti.com,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:jacob.e.keller@intel.com,m:m-malladi@ti.com,m:devnexen@gmail.com,m:vadim.fedorenko@linux.dev,m:haokexin@gmail.com,m:h-mittal1@ti.com,m:liuhangbin@gmail.com,m:elfring@users.sourceforge.net,m:fmancera@suse.de,m:jvaclav@redhat.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:fmaurer@redhat.com,m:luka.gejak@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,ti.com,lunn.ch,intel.com,gmail.com,linux.dev,users.sourceforge.net,suse.de];
	FORGED_SENDER(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ti.com:mid,ti.com:from_mime,ti.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296467-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 48331654FAF

Add standard stats for HSR / PRP. This series was initially adding HSR/PRP
related stats for ICSSG driver. Based on maintainers' comments on v2 I am
now adding support to dump standard stats for HSR/PRP.

The drivers which support offload can populate these standard stats.

This series only implements offloaded stats. For software-only interfaces
Felix Maurer had said he will do it later [1]

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
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  91 ++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  10 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   6 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |  89 +++++++-----
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |  10 ++
 include/linux/if_hsr.h                        |  48 +++++++
 include/uapi/linux/hsr_netlink.h              |  56 ++++++++
 include/uapi/linux/if_link.h                  |   1 +
 net/hsr/hsr_netlink.c                         | 132 ++++++++++++++++--
 tools/include/uapi/linux/if_link.h            |   1 +
 13 files changed, 426 insertions(+), 54 deletions(-)


base-commit: 4aacf509e537a711fa71bca9f234e5eb6968850e
-- 
2.34.1


