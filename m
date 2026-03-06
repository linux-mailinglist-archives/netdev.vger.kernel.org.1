Return-Path: <netdev+bounces-264747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH3DAtK3qmkiVwEAu9opvQ
	(envelope-from <netdev+bounces-264747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:17:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A02521F8A2
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD2F33018F1A
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE43859D7;
	Fri,  6 Mar 2026 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H6BHV+9I"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3B2386C1D;
	Fri,  6 Mar 2026 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795854; cv=fail; b=KejKoZU7DW3IJaNodfSKnIG3NWEPEIiMw7OlwRX4IkBEI5T+ge2XzWt8kHiuY+5AX53dWlkFJTsrn/tH7gKs8VizRIENWi5aAZcqKOVE2WtXrO8rqPxr6NFDUGqa5Lu0uSBbO69W0QKbeTyM5CRwRQ5GdBag3KbZrTYpVn5W164=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795854; c=relaxed/simple;
	bh=ZGlfOy5XOtaCtNo0NuUiscT1XwdyTn7mbifA1iYZ6Ts=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I8LRJ8fa3kM7TuwvaNsDDFiSVvfhASy7eQdk8HyqqisefVOxNwuIwVrnOssFPPguz/+RK5LZjzjbN5BDqzsChdsz2OKN40qeyNihS61XvG8+GcCxgZB36mTE88fmyzA0DlnUky3NKSAi6ZRPvJjRd3BPaIYF0oiRAbA7V1VasOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H6BHV+9I; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QL+oqZJiH0Kqs++OUA/7C2X2BhyrdMd4nzJSD8Bl8TvnI4PMOJd426/N5cfh4/5hq761ycuLn3HAFkm0sOnYrPn4HwCcvLbDYVOvrVL/X9Pqzl5BXtjCO4jvJCdl5bZHwVoZ5psuUnWcq+E0Rr+Dp3XooHuhi51ynElmTmbTvVZASZmf9Pg/276PLbJ6OYRsacMWyMhApUa6xXjgS5b3/4tsKwhhppnLrBYU0E8tDZzQ0cOcHpOdnkAXyXDyHmgXhSG0f8Afx3TEmlqC6M+1O4X0MsD9zEN1ONeVDAISmOXYe8XCu8y4chUG3s+v3Es4Y31phxZ303QhrGw1CGNDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti0R/Z41wMFSI3+hSRMWqzs0neQees0D6lDV5c6UJjs=;
 b=h21Qyj9moS/CwmtbIy3xDcGSJkGYufHPC1L55Fado5A49ZxBwh81L7UTYXl54HegfcR6pdzIghlJx5WWGsOc5/KnPtJre8fKD5PJLBtQ8c5dpfH/l/t7TmmhyCyPQnsdEUn4aCIaBy5cWPXkE0RX8zgDk/qj1/8HYfvtXQG0H3Da1u2+iek6Re4FbxTE1y46WpleE31gIe/gRed5cjicQGXhlzuRkf75O2WHUudk8sd9pTfqtWw9hG3oZQO5XhYSjB3Vhh+bRy7MoW7J0POqw6sXNcDgtMc+6EecDh5OX3CIhe3fIHxYc3IpZXfWrH9lmp8RiU9Q3JzZev8e7Ac9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti0R/Z41wMFSI3+hSRMWqzs0neQees0D6lDV5c6UJjs=;
 b=H6BHV+9IqFxB5WV5tpaWEDzF5+NIFyK8WCKVHJlmyk3HIBaLEo99z7pl0LxKgbPAuaNKDpqHgeimnRVRcZy/UT2InzfmUO/2dWCV2BJEKSrQVNAPM+6EvzaLgxXwYJD2nyBzkia35FL/i9OLiFlN6XbrbmzgN88hmet7Nik8i3w=
Received: from DM6PR10CA0013.namprd10.prod.outlook.com (2603:10b6:5:60::26) by
 CY1PR12MB9652.namprd12.prod.outlook.com (2603:10b6:930:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 11:17:27 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::b0) by DM6PR10CA0013.outlook.office365.com
 (2603:10b6:5:60::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 11:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 11:17:27 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 05:17:24 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v3 net 0/3] amd-xgbe: RX adaptation and PHY handling fixes
Date: Fri, 6 Mar 2026 16:46:26 +0530
Message-ID: <20260306111629.1515676-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CY1PR12MB9652:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d769360-3204-4d35-cc81-08de7b71f31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	rOT3X7RxWEh7wWnb42Arz51CNDFe5n9PSMLRXOODLPzSee3YVjERUTGAmuHppOFzy+uRJpXlq5PqZD9Pzy+tgM2FK4HzqFTvPPcz/fzNuwecnDkFiaPS86F+mrkak6q2mhapPPtmYtV+zrxMjGpvrI49o9pWRAxlIODzwNlb8lmLgKjOwERkzbs206CmaCJIj11U7kN1ZODDCy7SSHhkrN6JK20A+uISbudNTfM5u6jB5gEStOiA5Dd5l9yiI3xHhuNjUuAtGvbyQlg7sgzL7S/cfJAPQZsAevyol3dY/TdU3/UzmqiMOsHCSVse4BtV07Pzh6ZT7G6W4QBxVBBDiqkn1Nr/kt/5km+tvFVfCHgxc7jGfDfHasDvczCzN/CgiPMqlqMNndf9ybnqn1ob5UlicWrXFFbfJDFXC3WRf22NooqUUfgQY1AgUfgtZsDqoyjBhKoOsBe8oJcwoen2BgYtK2Nvyu+xpjWigU3nwq63Ia0DV3vjnp+Hx1rE2l4/rNorxFi1VlRH2Odv/u2YpHQRUO2tULHMlpHe74+IbIZE7ztt0z9oM06AsU3nHUHRInoUx3ZP41WElXKYR9MjdKyrrDw8bo+LOIHuNRTchuhoH4JwAI1hz8cnLRCxPLkDICDptp8RVR3q93g+d142CZIaW20dR4SIch9k+QYm1+ksdsBfuVl5DtVl8PJkA45W/KzKB26IDROjb/PQD0y7k+kxi5M+ZA5y790ATZMxs365ZkZVt8ejDeL6aR9dFyc6dCvO7lGXl3G66okOlSVc8g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iLnJeZrYUC7r9znyGbNdv4LOB60apBz53z9uO3j5Dc87W30F6FpVu8RPii+gEu3kbxlTO8A0wT8WkxoMWGR7oQdRq7Wx3hgIfDVLLRBlwGctwyb1CxL2Hw2KbW11rn/YGKW/FhGW5W6heHg/YziCmNpP3gsa6PWrqrEMi4YZlzVBu2OPzKXJdLpEWUQbh96V8VzGlDtqPl78r3nMqIin1NbH0I0T5RBAu8zUA5XP0bomu0nS7EQknd0BUTF8TZ6aRbmzkLRkkjlyybbi+HiEfnGPSnZhEIP0+CPaMLaqcGONHUJFU9Cxx5YWitO5/jcnoHXx85rOVlH0CI0SVHUkjVHcG1/k8XS9+QanW19icVYkMGkNOLQbiMkLDf8aDlfGHjwxPBMl6irTlu85hcvXZ8N2sA1fyN33xYWIvhHX1s5107G2XgPns1ez2YJUZS5E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 11:17:27.2900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d769360-3204-4d35-cc81-08de7b71f31e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9652
X-Rspamd-Queue-Id: 7A02521F8A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264747-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This series fixes several issues in the amd-xgbe driver related to RX
adaptation and PHY handling in 10GBASE-KR mode, particularly when
auto-negotiation is disabled.

Patch 1 fixes link status handling during RX adaptation by correctly
reading the latched link status bit so transient link drops are
detected without losing the current state.

Patch 2 prevents CRC errors that can occur when performing RX
adaptation with auto-negotiation turned off. The driver now stops
TX/RX before re-triggering RX adaptation and only re-enables traffic
once adaptation completes and the link is confirmed up, ensuring
packets are not corrupted during the adaptation window.

Patch 3 restores the intended ordering of PHY reset relative to
phy_start(), making sure PHY settings are reset before the PHY is
started instead of afterwards.

Changes since v1:
 - change the data_path_stopped flag to boolean type
   as it is only used as a true/false indicator.

Changes since v2:
 - use the correct fixes tag for the link status handling patch
 - change the data_path_stopped flag to be cleared in phy_start() to
   ensure it is reset on device restart

Raju Rangoju (3):
  amd-xgbe: fix link status handling in xgbe_rx_adaptation
  amd-xgbe: prevent CRC errors during RX adaptation with AN disabled
  amd-xgbe: reset PHY settings before starting PHY

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 19 ++---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 82 +++++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  4 +
 3 files changed, 89 insertions(+), 16 deletions(-)

-- 
2.34.1


