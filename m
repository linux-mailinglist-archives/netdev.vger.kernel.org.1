Return-Path: <netdev+bounces-299271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jcyCI90UL2r87gQAu9opvQ
	(envelope-from <netdev+bounces-299271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:53:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB31682389
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:53:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="Tb0MwGg/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299271-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299271-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96D7E30071E2
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 20:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A029326923;
	Sun, 14 Jun 2026 20:53:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA473033D6
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 20:53:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470409; cv=fail; b=WYeXBIO4CigxlnkgJul1fW77WxBLc3V9eequGvY5QliEOcgDgQlGZFeL8TaCW+xWnC5ZqrSKujNAKVbJJnX+pg6Esz+t1QZR0NpNRjCHVaCRmyXe4liImaLc3DMWR/E0jH/5y5JX8Bg1rj+lTSbk0WxzK3QTrUktKtKEDAc/2EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470409; c=relaxed/simple;
	bh=f28SFLKdvXXEc3DFHlNNkySmOfCMaI2IxfLVKGbH08E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JXDdGrSYGABysNQgLhwGhDMs0P8X3HOVgkIzaWtrwLKrzWqK3v8UInrwmKeirG35DFdxn9YepvIP8q+Mi4BbgOp2NrsDuoLCzYYPozib/LXRrfX3Yn4F7/Q3cFrsScXvXGwVSlLWtc0ApjJ51MW6Iy7z/KacElZoLrA7kho4RR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tb0MwGg/; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQnTc2DV9tJl2j9f0TiK86Co1TpE0pDkJKGjQU92e5BTzcaVjqShscSrQCPzHWktyCBKTs/j+1UXGEbLx/9rmku4ZAdjYGsC8JOZySAuarx7mvMoSGWdO1Jc1VqDVc1tl+nB2UN11f7ehqEKDXT6pnoEta2WoE1TEF/EGZ3ZS8+V6WAHolWLwwy7eyG4va5A6zc6zkOozTfCk5M48P4jRn9ji9s4cpl+eCk5mJYkUo9IRVtO2nJuGZMptXkM0iP6Jzv16wXVuicE2HCTcyNL/9aKkDIbcCaOlXv5at/dkSJb2DDy7xEuz3GS/MJRTSQqJzaop4is8AucAHvXn1r+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IdXXw0fr0jECbQ/mWMuSjCs1qBieZNeq7jmQ2LgKvg=;
 b=jC4/KN0O8HM4Ao/I1++bGWFveUGzabibRLN4ZC9zFX3CKqlswLhHKGB+Gzq0G2onSUnNxw9+PsDkf6VLLmdvR1PSwLVHS/cXhGvHv82kLpQPEYBx0mQ+pPIPYgPEOq+C1LQs2+5VbO0DndkRm16Cqu9bqbGdxvWQkGC8fDkIATc7P7NZ3YSy66tyOUvItJNDHwPFkn5dDVHye6Kxy4fPCEHcNiFsbyJmZlCWLcli8q4niwtcoZbUq2+Wg6SE+9WHsK9WTlY5/xhaXXbqmLFcJPgcw/OwMrcpi4OGbnv3TSm+KHmc8wMLzWm6SLzwCK/CIEC3+/GVsto108g2OYM5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IdXXw0fr0jECbQ/mWMuSjCs1qBieZNeq7jmQ2LgKvg=;
 b=Tb0MwGg/iPQPonI7wMjts/4Rbxo1NrDtwX7Ls9Ml9A/egh2OT4NgEHUFo3SkaWtFEg0IPI5o4eDmw6V2xvMfBs/5W0qqceWTQerL+tdF+NqgQl846hetxKN6Gv/QKVzpA6GQJ4M4q3K3dficluGxNGu+6f0/6F5TK/nvdOhIurw=
Received: from SJ0PR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:332::23)
 by DS4PR12MB9795.namprd12.prod.outlook.com (2603:10b6:8:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 20:53:24 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::27) by SJ0PR05CA0078.outlook.office365.com
 (2603:10b6:a03:332::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.9 via Frontend Transport; Sun, 14
 Jun 2026 20:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 20:53:24 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 15:53:23 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>, "Nikhil P . Rao"
	<nikhil.rao@amd.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 0/5] ionic: Expose more port stats to ethtool
Date: Sun, 14 Jun 2026 13:52:58 -0700
Message-ID: <20260614205303.48088-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|DS4PR12MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: 5903d3e3-6840-4044-3b38-08deca56f9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xilhO7fgXqGjBrPyc+3j62K4DLZNFfnwS3X5Bh0MEQq5ecWskZLrWJqZcuCawSbDFR7vHEzzywFB9sbxVqQQTtmB+kL2DCfa2607itn9OaCXzSVLzGKn4OunKYafDbMSs7QLXOH/Ok9OhGFS+tcKzxbPGK7vQjHSm0/Xm5mQxEDMjPKUIR+O5tgFLH8gxweyqjOwCKFZunSiRDRhJxEhFJL+ijeH7/1fMQLfcpzZKivcLBrOFtnn9AFcNQHE++7sOv+RMAKExsDMFeqi2hxcOivdZMaHXUagxPEtZelw0RJvif8qmlS7q2hxrCh+CMJX75xwLlm3JMsqOt+FYEQ6err+aIXDGpAUhkqDxYmt61K3OLW/tSkZzOyIuMqdMKcz0EXrHbgm3r1oeh51/UQkDExD6AzWVSu9YGcu+5NhB9GUhk6AZiYNO8Pt83ZAJrBycjYF5KLuA5oFUnFQCj9qds6PM+6xhii9lFagbcVqEJeTBxfqrFb5cUCMedeeg1dVGjsNKJ+cRuPyY6Tnvrk6Ena45Q1KwZaczlVRu81jIoIhUK6S1Q9UCXqYRk1aA9Fm6/YzXpN+qWa1D3BP9ASehhA981A2TNqykFwpvC+MQUCsCRzeskX8PtnbvxP1vSIwBzoaGOBE/qkQ9oZ3UBLpJI5Pu8bxzHt490fHFba2ss6SMX1tJIfMVaF8ef19y+7ZGMWjka2zq6OSp6uiKTBL0AZT0jGht/gLVQLKAcf1BDM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cbQBeN06qDnEFXA0t7dN7XgBSJdh1QvV8LRXBTYcmdsxzGbDC/XyLebInq0lJ52WSAGgFdR2SFTnCggJ/FWlfw4wNJtG5QHbycevbkDPfI0pd7cQhoIktjYGEtEWFnYLbc5LSrQ/L4APxGydlDWWso/lfiLmLa/FwoksuCh0ItYdJY8w5aRmoiMYcq+mMVXKwJKpfddqPb76bDwbjl92jKa8R5upMem4CK4mVj9e2xRHkTbMHZV3NUMDh4s61yPcUsHR66Cn2r1stvi7P+FALD9BMCg8UIPm5OyNSn/0CxHRNJNyfqNWkHtA3RAT5Fyg1g+KoL3Xtjt/nFzGcWXVtdboecPrMYESynamIcX/KeEkNLtQ3b/1Tj8GPhqwbWPFE+a2tld8B4TyMtNyXaaHNUsWP3qMABEurf7+6MVw14OzBx4W+QppaEjcOVRGHTb8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 20:53:24.0873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5903d3e3-6840-4044-3b38-08deca56f9ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9795
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299271-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:nikhil.rao@amd.com,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFB31682389

The primary aim of this patchset is to support the reporting of new port
statistics (and one old one) that firmware sends to the driver; these
include general FEC codeword stats and the FEC histogram. A scheme for
these extra stats is introduced in order to prevent devices that don't
support these new statistics from unconditionally setting them or
reporting them in ethtool.

---
v5:
Address new Sashiko AI comments and previous feedback
patch 2:
- Remove additional unused enums that were only used by struct
  ionic_port_pb_stats
- Change IONIC_STAT_INVALID to use (~0ULL) instead of ((__le64)-1) to
  avoid sparse warnings (and moved to patch 3)
patch 4:
- Change ethtool link_down_events count to use firmware-derived value;
  handle overflow and set count to zero on driver load and resets. Finally
  drop the driver-calculated value and ethtool general stat counter and
  only report count in the ethtool extended link stat structure.
patch 5:
- Add check for NULL port_info in .get_fec_stats() callback in order to
  prevent a potential NULL pointer dereference, similar to other ethtool
  callbacks.

v4:
- A big addition is a new scheme where the driver will only report the
  new statistics supported by firmware if the firmware sets the statistic
  value to something that isn't invalid; more details in patch 3, and this
  is used in patch 5 to prevent FEC stats from being unconditionally
  reported on devices/firmware versions that don't support these stats.
- The link_down_count from firmware mentioned in v2 was moved back to an
  entry in the general ethtool statistics; the existing driver-calculated
  value for the ethtool ext link is more appropriate due to the firmware
  value being a small size and not resetting between driver loads.
- Add netdev_err_once() call recommended by Sashiko for ethtool handler
- Drop devcmd retry logic patch from previous versions for now;
  explicitly include Brett's patch from another patchset to fix the
  ionic_get_link_ext_stats() PF/VF check

v3:
Address issues mostly found by Sashiko:
- Fix potential return of uninitialized variable in __ionic_dev_cmd_wait()
- Fix bounds of wait in __ionic_dev_cmd_wait() to prevent function from
  giving up prematurely now that the wait period has changed
- Add NULL check to ionic_get_link_ext_stats(), following the example set by
  ionic_get_link_ksettings()
- Add missing le16_to_cpu() when copying link_down_count from firmware

v2:
- Add missing cpu_to_le64() to FEC histogram stat assignment
- Remove unused pb_stats field that's replaced by the new FEC/extra stats
- Replace ethtool ext link stat with firmware stat instead of adding
  the firmware stat to general ethtool statistics; remove old driver
  calculated stat
- Add explanation for what EAGAIN return value could be used for in
  commit message

Brett Creeley (1):
  ionic: Fix check in ionic_get_link_ext_stats

Eric Joyner (4):
  ionic: Update ionic_if.h with new extra port stats
  ionic: Report "rx_bits_phy" stat to ethtool
  ionic: Get "link_down_count" ext link stat from firmware
  ionic: Add .get_fec_stats ethtool handler

 .../net/ethernet/pensando/ionic/ionic_dev.c   |  10 ++
 .../net/ethernet/pensando/ionic/ionic_dev.h   |   6 +
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 104 +++++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_if.h    |  64 ++---------
 .../net/ethernet/pensando/ionic/ionic_lif.c   |   4 +-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   1 -
 .../net/ethernet/pensando/ionic/ionic_main.c  |   8 ++
 .../net/ethernet/pensando/ionic/ionic_stats.c |  65 ++++++++++-
 .../net/ethernet/pensando/ionic/ionic_stats.h |   2 +
 9 files changed, 206 insertions(+), 58 deletions(-)


base-commit: 93790c374b9d77f3db15786d7d432872d92751cf
-- 
2.17.1


