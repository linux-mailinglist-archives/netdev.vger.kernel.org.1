Return-Path: <netdev+bounces-285293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMG+AxZ8/GkwQgAAu9opvQ
	(envelope-from <netdev+bounces-285293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:48:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C11964E7B72
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22B8F3016B66
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87A43EBF36;
	Thu,  7 May 2026 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E0blxZKO"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B83ED122
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154501; cv=fail; b=Fk9ipZDORSN9SGtkSDnc1A4Tz/bYwe9b2ISar3nmXkxgeyN16AzdLYq+i7wqc+TeNQrr4ZkxSb9xUDZfbDhR/KOqU5CDntPqH4H1RPUizGE5LTSMz2VsmMKrGcn/UXBUqrx65tnTzyCeiJPrTn+D4G7gPFFJQxh33HhNcvjsubI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154501; c=relaxed/simple;
	bh=iRsiGsoQUGUYDiGty0g+c7vg4avm31wudszR/72nH9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXMiAa0vqcGrqfzEMDlBUcDXd1U2omKr3lCby5CHadVPMJSL5f/niRGcAsFjbPqQFF9ejzo5/zT56X8wpDR1Oh0RL/1ByGWyTSEJox3jeM/lnpId50mGlUNHEaLamM/LKqIppLjkzqEW9TIusi4iD6k1xjsUfArhVLgzIjKtXA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E0blxZKO; arc=fail smtp.client-ip=52.101.57.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQL4QsKwWGyGPJcof1ycP9cvkFFu08F5i13hcFMZ3juy71MttArUDu7yRSdCTPr22HD7yZrGZKUPeCoTksoEtaWYV9MCZrQrer+L95PA1PirqtzJXFjQtH3APYB7MIg1UK/KZYWPMXdZpi9R4S7zr0G+m3ULGwl0ruYNQeqchqlAxXmVZkNJMI8FQfHyACo3rkqssPF9dra864TPzk06UPfCO2uVwjCuXfTqUGFtQaar+I8UAQq7GAKcJhvey/uRNAcZDzBraZaYHvTiJEKQLcfuFkbu2Dpv5aRJNSA4zHqKA5WKp5/L/KDTUofIgGbgbctrz6rPH9kQ47+Mjt/yxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOFcnaZ8lf/OOn3E7nMWMZskyosWu+Pa3xPHEmM/Vqs=;
 b=Y18u9AGafAEBhptOA4T7/rZ/3c5wrJj6L1UEBiPlbcWL0eqeLIK66VwVtMzcNMeXGN2VtawD7bnh9LKsmIbBhAxTgEs+F+v/7+Z81NWeA0+IRypCc7xgY2uzybFA3R8/Ck5OJP5uX1B1UGJX9sy3RTqwfuqqQKHrkmo0YmJ9exROkBYuD/WV7Vyyzu/DmEW0xyHc6eyz34tWKrVd2kFnFWFYVLyXONBnqIq8hDC/PzGLT5iluI2JzYrUC7BuicXe319Rx7h1sNXVYWurKTbx1BfmKdfprZfNjW31//N7Fa2FJlFbjX9wOrCEmin8lOMAy/MGcQGAVbE0K7016wjjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOFcnaZ8lf/OOn3E7nMWMZskyosWu+Pa3xPHEmM/Vqs=;
 b=E0blxZKOmyARs6S3iYPFLxGy+O0pGj6TTpxs8W4Cp2h7sUqhraXKC9CRCiCzcIoxkRlZz34NCT8coyvXUReAP4kvaa4GrcvZw5Yek0zszsjHBCr8c4WwHY+iwoQpUfezPqvTcCE4HiVnP1zU4LuNr2v0pXYEBqXS6nnGF/FRDjq5rLGo72bvF7WSLMwMjSU5r3c3BUTK+7Mg9mhAOiaKzhP5eJUGKea3K9tEENLfgVxa5Q91bSBJlinTHmYRwY2CeIlHYYgjmQ3E8lVkBwY3u7+0/8hkuorhSWW0gvo7HDrX1d+PASLxhT3Wcdreas953Ry7239dhTJNGDSTIETUGw==
Received: from MW4PR03CA0336.namprd03.prod.outlook.com (2603:10b6:303:dc::11)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 11:48:15 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:dc:cafe::a7) by MW4PR03CA0336.outlook.office365.com
 (2603:10b6:303:dc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 11:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 11:48:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 04:47:55 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 04:47:53 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next 5/5] ethtool: Add man page and bash completion for 'pages on|off'
Date: Thu, 7 May 2026 14:47:21 +0300
Message-ID: <20260507114721.3409128-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507114721.3409128-1-danieller@nvidia.com>
References: <20260507114721.3409128-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e899c11-a546-4606-d8c8-08deac2e862a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	3ZGQdWnPdsrslr7UC9nuosg/u6LNrHGWpmepUfLJzmBfaLxy2KsKtoqtJeq6f5YOTMq5h5LXvXz7ehn1VwV/POpT6u04dAsGmWcemzdE87MkRXTxICwxoNkpzkS5Uu/tx7b79+Jy7UYg84z3qZgJrKKMBdcEb6DmPmnqVyfbRgZl/0SGIgJ+jv245t3a84RjoBNRQN1imgv0du6h7miFKVDqPIKrSy3jgmnAA8iMXtOO3mZ8aM/BYxq1tC4en1Osu+MWAVb8GnUW7rsB6yOMjTm3sn8/Tw9zTO8g4YKUPmNgqrrBc68Alkzpq7jmqzrF5CuqTWy+IV91h2uYwKEZ0+5yov1UacSW3z7v/E/bYvJszFsc1rKJ4dtlUVdvx2yYdMT94rAd20NCGzyWLGecjvRrIToVaKfP+cyx4Bv+CWuCwVwPO4IPCBEFSSj+Jpu8wwFrVnzxfrcdWrCZ+qyopCkOLsm3ZzzchcJuxjcaPzO35pJgWi5Rk61zzqI8CpgZb8GgUcZcl3xa+9/11ybiQEZiVoFXQTscU/XTnmEHsfz+wfQ94+h10h9OAmYQXhOZbMXgfTxdNuU1iCMiMrCr3Yex5ROQ3g27wfx7tWPNfvIqLy2wMykXj0eGgQRui9G22Z0/P6rpX/K6/IXLZ0MCE3aXHcOXhQoDb/YbMk0D2C3Cijed7Iv97EPtPJ6Io1s/gSEWzAKxoxiKSokNc54jArGdY7xNmTB3IqI4ioxI3Bs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eFvVMpzpsL1od9bcigMtTSkyzblFoOGseFqi1gQfEa0bfaox/p/ZHOZgsCZHyyTCiFyHZ1ycYcbRdb5FLg3nJNnMB6b+4TFvBPTHQdMrEpkRAynfvcbwX/UmpjkftGIfqOn+gYkrmLHD9vOBeQsGbOCdb6Lq6CeUwgZJUoShtU5+SgdfvGf7uBGe6+WR+zPp2uPAOtFREYzJXzBoEvBOkaO1EvqbnLnjGjEcrQH6JzCHZpE+nkoGuB6hHvm/4MIDmeXOsKuGyCN8e3+89Lbt8xLGV1su0CsWrd/Kg5IuKSIVvhQHF87UYlgmceyJJp8Wcr2ZVe5AqYK+mawgOp9yh6Q3PGNojMjvcdp1yGq1QhRzfTwdpV412aazWbcUOgXEGO2d6r0eY0BICTxqI9hEkJDKyJ1yOIGWLw70S38qYuB1qW+mRqxN8+eWzJ/crGfB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:48:15.1238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e899c11-a546-4606-d8c8-08deac2e862a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
X-Rspamd-Queue-Id: C11964E7B72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285293-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,8.in:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Add 'pages on|off' to the bash completion for ethtool -m and the
ethtool man page.

The man page documents that 'pages on' requires 'hex on', describes the
per-page header format, and notes that it cannot be combined with
offset, length, page, bank or i2c parameters.

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 ethtool.8.in                  | 14 ++++++++++++++
 shell-completion/bash/ethtool |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 32b971a..2cea2bc 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -403,6 +403,7 @@ ethtool \- query or control network driver and hardware settings
 .I devname
 .B2 raw on off
 .B2 hex on off
+.B2 pages on off
 .BN offset
 .BN length
 .BN page
@@ -1431,6 +1432,19 @@ allowed. In such a case
 and
 .I length
 parameters are treated relatively to EEPROM page boundaries.
+When
+.B hex on pages on
+is specified, dumps all relevant EEPROM pages in hex, organized by page.
+Each page is preceded by a header identifying the page number and, for
+banked pages, the bank number. For SFP modules, the header shows the
+I2C address instead, as different parts of the EEPROM memory map are
+accessible via different I2C addresses. The set of pages dumped matches
+what the pretty-printer reads for each module type. This option cannot be
+combined with
+.I offset, length, page, bank
+or
+.I i2c
+parameters.
 .TP
 .B \-\-show\-priv\-flags
 Queries the specified network device for its private flags.  The
diff --git a/shell-completion/bash/ethtool b/shell-completion/bash/ethtool
index 57c39c4..7a319a9 100644
--- a/shell-completion/bash/ethtool
+++ b/shell-completion/bash/ethtool
@@ -671,11 +671,13 @@ _ethtool_module_info()
 		[hex]=1
 		[length]=1
 		[offset]=1
+		[pages]=1
 		[raw]=1
 	)
 
 	case "$prev" in
 		hex|\
+		pages|\
 		raw)
 			COMPREPLY=( $( compgen -W 'on off' -- "$cur" ) )
 			return ;;
-- 
2.51.0


