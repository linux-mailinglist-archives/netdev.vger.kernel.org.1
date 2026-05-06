Return-Path: <netdev+bounces-284696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPtqICTF+mkzSgMAu9opvQ
	(envelope-from <netdev+bounces-284696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:35:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5434D6214
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BA993021BD3
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 04:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21612D63E8;
	Wed,  6 May 2026 04:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cRM49n2m"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C2E239085
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 04:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042144; cv=fail; b=N1Rd54E9CUApcfQ/o4cmP3vW2oA0/eFfvCQuZwVjvn5yPCo3MmIzNiLetGDS/ncoFQWP1+Trem0f5AFhqz5EDXRWSW31ZgaPrBcHpAJ0eUfyHIci1TC3IFQd2MgIU5UxRc4UCRMO+xt3F2xhq7UL307t4TCOr5F7EixwHkFJVyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042144; c=relaxed/simple;
	bh=TO9d6eJbzvYLOLaJRulmP0AZ0TEQYpeftDmz0Ns3Mnk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MFwMWSzlU388hpB3a14M4GmWtcXQWfVBdzjM+BZUZbs0jyUbpMm7aZx+ly7J7FYaTiihwP98wGXmhS6HANaNkWvd/rVuld8fVJrXwAx0pp/AYnqFg34vrlLVaMzXW/4VOYZZL1eMcDywd+oor+4pWVedQ3H5kMr3atagGmAwdao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cRM49n2m; arc=fail smtp.client-ip=40.93.194.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peADcwzFFHRDE4R5hcg5dPNdzeRrTpR1+KGL21fqOp+3x9ugeIuGRnZ7rIr7vLuHwu8OzDo7xOPDX+R3/XbbX74clh9N6WyyUxgetzhFySyKqnm6UFjrDxHz1JoAKVqU2zDw9+6XtFbtorct3Xf6N5+XDu6RANsBxU0RKfH2UleJewSYI3FamUPhqx2txQqq5mxZ5o+/a1D8KO0JCAUXJkPShqUeOpT32PIFN/3gXiQw7Fv+55MKwA30eag7kn4H9YQc7noN+8cT6q72N2f6jmTZLt/yT9u4niNSLN48UfKsaocbcdQdRg9jemfRwTYHD9fUJu9d96u9mvWnyun0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA66L8S8gPqzTQ3oxVsat37DSHSxKlMqlROVNBXlP0M=;
 b=IjbeQGdB1f4Ytd0DhuuAX2PuW5P+fya+EYRohtgDkn1sZxPPyJv87Qlnu1BmMGw1nTxL7gE51UMwEqSS1VH6YmR38xpRl5HZ6SY+Eb8YKmEVqJQkSKM0RYcGP1D6iFHLYb/01ztVHfFxPIT0sW6nB3WTO6oU69I3IpAFURYMA2Y79iWca8zHvgaCpDOfn52tPQOJLucKO+SbTiQ04ZUVmD6R0o3d46WUhMCsH/5WnSa97K8Rlckuyz7fNYveXeXRsWmgwmIFiygd+H54OVdwNqLMjzTUhbORgeYESvY1wiIYYuH6UlPb4gyrZPIT7P7vgyO3lxUbCA6PpZCiPOqRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA66L8S8gPqzTQ3oxVsat37DSHSxKlMqlROVNBXlP0M=;
 b=cRM49n2mDfF9ufWd12bdGwcyn4zrXYeyhUNjoHwBvZS0KZO9LK7t4Rx4uFI2tscGLHiQ4KQqMssUFV15QoQpYKOHtfRLWiWOpg57VZCmRI3P/DkwrMpDW9CUcOKgFRL3UipA2g/WYkek+jw3E/1RrxsRcnA6eLxMO8tldWPBtk0=
Received: from SJ0PR03CA0365.namprd03.prod.outlook.com (2603:10b6:a03:3a1::10)
 by DS5PPF7856D51FE.namprd12.prod.outlook.com (2603:10b6:f:fc00::654) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 6 May
 2026 04:35:39 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::44) by SJ0PR03CA0365.outlook.office365.com
 (2603:10b6:a03:3a1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 04:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 04:35:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 23:35:38 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v2 0/5] Expose more port stats to ethtool
Date: Tue, 5 May 2026 21:35:20 -0700
Message-ID: <20260506043526.64301-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DS5PPF7856D51FE:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c1ff80-07ff-4bc8-4608-08deab28ecc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wBY2/iRMvpI6L9kpnu8hb2DFHiR5uqUeNCHIN+zz6G7oDaarRrKBZ0iJPTDAgWzsTwhNM0ymr71Tv/8qk03ORLhjshtK3LvqlpJZeCmzxyY0Vcu7hBMzm+r31E6fZZYTp+ZtmyVO68waJrcTsC0BHBJAJVDv2mIleRFp0FTSUj21EtcX+phaBSZx3gpE3/rX9YIrlsG//Pzu+2UNH80vAhTROnXoLIma2NXnmZu/6tE7vfdG4YK+iprUdBfpZ9bsAke2pAaEuVWDX10yqZoM9wSPqWlSqy0tA5bjkHWB3dcYpHTPEo2eE+TeLae8XLZMzIdro5/EzmLDnOv0vbKbfVpQIeBPMl717/2r/aBNFMf2x95pHXe6TtONKwYYiiIWuHUmEAeJ5No4j7NLg020uG1hyhFL0yW2NzHND27WJhcIxPShh4aaCi9TvLhIJXkqPJT4nsXaftfFYoQCbguwB7gIjyWJUHC1LZ6fFGOd6izBFbzzoHIwXYbO2DPcLDycv2R5jYZWPxcfA7Oa1x3BFnlKhBtfqW9vEMzR8kzRdWffKu/eEg9y2hHSDW2+OuggCBHPCdwtKQTgfl3Y6ub61qhgwaMx1Z7PV0k9awjol2uA1/zFlE57NSv57b31SkJ/lv01AKIqXm/LAwtTljuBZyyNJftCbt25e7Fql/IrPx+arnnPCV810PcN+Lzgr/eo8bTwm98iMGACggULDhxwAYYpBBIX6t3Sdtfh+P8Tr2A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	giWa7xEMBI0WsXp38uYw4NnnkY1cnj24kXNe9aEfHbdNA00PL6YQaeZyZG/zl0YSGiX3q/UkIezqiOd1hRc7B4mMY5z0dLuxm7TpQ21W+93+RGEzmAKFacFMtskWW/JYKbMookWjwxfzPk5eGMCJcp3bM9xQJRp7lGo/s+2KBwqryRbOZ27TbH4aAUrQvPXKrrBjo0Ir0kuj19Mp1C2eHtLUgjeCY+aUGhqMwAG6ofXzjZkv3jLQwqxVjj3UIb8DvjN0vS0Fm93xsPN449lpPdPXVaUeqegeXPHVj9ad9h7TMRd5T8eh0OV6ot8ZWVCL4evRK3OEyuiFw/gULrHQKxnkl56RcrooSKykDJ8BlCk0nDqZ0LGahTKFQLHiCrUXVJ2Z483A/tCOHhnz9O+8fTMQ5fSg/0S4GTqo8V+4p/ymJfSLy/LBSVB0En9fytEE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:35:39.1212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c1ff80-07ff-4bc8-4608-08deab28ecc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7856D51FE
X-Rspamd-Queue-Id: 0C5434D6214
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284696-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Newer hardware collects a lot more FEC statistics than older hardware;
these include FEC histograms and corrected/uncorrected word and bit
totals. This patchset adds plumbing to pass these through to ethtool
along with another link_down_count stat that is another port-level stat.
That link_down_count was already being sent to the driver by the
firmware; it just wasn't used.

Brett's patch is a small unrelated improvement to devcmd handling that's
still nice to have and will help enable deferred probe functionality.

---
v2:
- Add missing cpu_to_le64() to FEC histogram stat assignment
- Remove unused pb_stats field that's replaced by the new FEC/extra stats
- Replace ethtool ext link stat with firmware stat instead of adding
  the firmware stat to general ethtool statistics; remove old driver
  calculated stat
- Add explanation for what EAGAIN return value could be used for in
  commit message

Brett Creeley (1):
  ionic: Small improvements in devcmd retry logic

Eric Joyner (4):
  ionic: Get "link_down_count" ext link stat from firmware
  ionic: Update ionic_if.h with new extra port stats structure
  ionic: Report rx_bits_phy stat to ethtool
  ionic: Add .get_fec_stats ethtool handler

 .../ethernet/pensando/ionic/ionic_ethtool.c   | 55 ++++++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_if.h    | 36 ++++--------
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  1 -
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  1 -
 .../net/ethernet/pensando/ionic/ionic_main.c  |  7 ++-
 .../net/ethernet/pensando/ionic/ionic_stats.c | 15 ++++-
 6 files changed, 84 insertions(+), 31 deletions(-)


base-commit: 8c699be3dad7bba87cdda485dc099226cfc2f706
-- 
2.17.1


