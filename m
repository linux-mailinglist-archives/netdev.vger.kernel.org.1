Return-Path: <netdev+bounces-289452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGC/DlVbDGodfwUAu9opvQ
	(envelope-from <netdev+bounces-289452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:45:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B657EF29
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6829D310D5E3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F34DC525;
	Tue, 19 May 2026 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kJRQSiwT"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42974409E16
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194280; cv=fail; b=JmwpXawF6Utw/JCJqfzeKvkRxxVr+POcmTOPbnwWzftvOL++1j1qFf6rQvJCcj+bvwQkldeZVVnwguWUSxTdgH0QCXe34NygiV1F1m1KKvdSEnE7BCv7YjioSwvtFyZjt8B53QRQtsfDXcnvCRdJg2GawXgjq1mS+RaqZD+kLHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194280; c=relaxed/simple;
	bh=EwUfSCOR+MwoBMI+SBbdysZuVEhAEARSaju9nnriN8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azV2MRiRMy+GfrSmUTlyHPVbsQ8+4m+tDY/ImuwyYVrsumB1vfCbklYOEstaWRgbn9DP5dPVO51bNTg77hbx3bfw4Wpmi68AS7zc0IjgiQWeFt0VxGpMP5eYlQJRoo/uKyQHa+H6hO6/HPV+YZe+FOXNcIgJXsd5hsngHtum/xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kJRQSiwT; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgeDRN0C6eXzCoAVeLpAEgRnVvM6YGjO4r4G5tkURoZVjkneT4kc02YfQYuCQgYBblW1OD8/d+gTMc9FdUGSSYQkppAVpGdIvZ71623PT+gc9OCKhc5DoY9qiJL0Y5M5jc22LtoNhu42I9D17Wuja48ioS02tnGT7OM9Ir7U6YFzCDKbSQHeIGxg+RV25bKkQzpUsY0felfxLW0RSlbrVy1BZxIUZasqgckyy+fZ8dpDWLHlYuZraLiqVyXkfPLwZRJ9fRSe+3QSFyaMLhTQ6TEoqg8CsY25tIGcX/4EbsphRsC2KYvIm09WqamcO5Tqh3ebwfdfpfogtXPp1DxVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWAnx3yfP5kBLo8kb5FTLKp9nH9btpKropxMqgQmavo=;
 b=di106TQbLOWMKBTFgFzFHYKdzqT/dFOq2kEVql13hByVTGOoI/cnIFw1Vve7FTCtQF8rxjO3mjEv3vY3SSq33mb5mCro+g112s5ZTREk9+6+9kd8c5lx/X4oDix11kHZbDhbnoQBDnh2gUmSjPaoDpOwNkHdqXKu12nwunfArjgMy4UCDBzcmxqBku6rLDWK0/I4AWOxZUvCOGDHbMsVcqZt9ykkD+lQC+EM6mtfSbP9NP4ELaarwdWZxKPxLc/rk0VUjjVPQoFcaTaaVK3hz7oVT5ypDdfi4cOJFtL0lsIfbB3Jws3tpH5S5to9MbX1N5sH3oESthUuvlqi9OqRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWAnx3yfP5kBLo8kb5FTLKp9nH9btpKropxMqgQmavo=;
 b=kJRQSiwTStpy71j11kScf2GmDnGD7NO6l1HKYlh/+35lO9yWWtZe3i+DGEamINS/KIo2t+SZ5Fzfq3t6Mux+w503nOINFrB2g9Jb3QxlY9zFJCV4Zmj3N7GEoR73ORz9G3dIAX5hgcWY6vKSOocuXViGz842cU+0xEr1L8SYR3yvsBI8sfxsM+yIBt010H4ThKYvrm9tHb1843QQMAlbqInf0sp4TBBG2pNHMTIwliQ9GgShPyYtuqCqyK7TiTdY13BZB10pEluwCBv14t29fDnU/O62/f8yeBqQHD3dZTEvYtTbHLzov4nTa6pWvID9qk6sD7+IoC4Sz1EovnTpYw==
Received: from MN0PR05CA0013.namprd05.prod.outlook.com (2603:10b6:208:52c::7)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 12:37:52 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::9c) by MN0PR05CA0013.outlook.office365.com
 (2603:10b6:208:52c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Tue, 19
 May 2026 12:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 12:37:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 05:37:28 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 19 May 2026 05:37:26 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 5/5] ethtool: Add man page and bash completion for 'pages on|off'
Date: Tue, 19 May 2026 15:37:02 +0300
Message-ID: <4269cb5c66db215704007301e24e45e5250bec91.1779190777.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779190777.git.danieller@nvidia.com>
References: <cover.1779190777.git.danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: df5da5fb-cd5c-4607-df71-08deb5a3719b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|3023799003|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ouoDw+JV+K6FebEKwDfNLq/1ERtZMDL9CxsRVjFfjsAYoiLDfZRaNbALkyHJffHDiZFWXilFfgr2HLMOgtxYWrLFA3nL8QXIFwgkTSnQ3Q0LfcjVlrOb4oSuQmpk+twbEgfN85hmtk9yJKYNICEXFBoVDWG6eXcHIK4Yzmc5K8Mn2IXFDbyOP1mYDFto0hUarBk01uyOstQxlfTpXV3rm3hiXRf8A1fryGv5aJNkgf+wixM2BoAL0lDFhO9497mAPM/tdBQj35sFjbr9dWe9xOEvTNotaszucVn8Q1M+dg9Wosu5+el9zZQttn4C43JcLYerZJT4mMgbNGDqHUsxgb0HKFn2m+m4p38yJxt6H6fLY37WE8RSIUpYB+XM37d3N4tZ1SUMNiTS1cxPAnumHLRESu4Scghd5hw8qBN2vPkHtY7dcaKOmEVO3x3fL2yAInNjNUcgJ6kkIgW0rnDMZmlNwPDDRbTZMBijeo3bRzjwLPu+8l7HTB2Ugg1yxAMGMltlwJ82H/AZaMQriW0NvYXi5V+eR6sduThu4Jsf6Zx5mX7UaKX4Ue1OgtK5Yg8okjDdnVv0hpZHxaTTrnV9sPwukELRJrSHWpCAcgJRUp85uKU1fUk0UsVReERAOcQ9Y9we6Ruq9BgeMUGakjD+b2TtkgOEtaiAHski5mBbnaGNtJlGhKZ5+n/SzFVNw7e50uVeQt/CHhNcOEuagBJ8tBmD8JfwBiRE/HQutunWg7M=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(3023799003)(11063799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B5QUt/N9Q7IAKHkF1ct30k/TdVmMNn1F+3EU68DeOCxxHNWeIti2/lhMuMx3HrA1g5cpd/UBy/o+43D0zh/RWjiFsH0NLy5Hl3W4M8Y91d2dstiOUzRUwKLHxWpeQGrElpFU49xEyK57J8ebqAS8PK1J8l12D+82/M0fKlIKKuX48kAfwnsAIlXa2SILz50CGtsPUICuABBSVEMCq0QIIRt+MJg++P/XRVGr0wHGjsMw9D4QcLa5rFJ/jzMKepG2ys30aYX/gjOK9fsa5CBt5LBBC/P8+CB3/YNBPkAs75+T0zJDdpM7++xxLVbY8l7BKzZrZCGxNpUQ32zk/xhpkCn9QxCtIUxhAick+cV6n0WVcJsTu7gVTtQhQtf9knOJzkx6jiLWp3sUS9nfLH1fuyhItPE9IyU8m0gc9jdi9+01cy3MQpTM5wE1VQ8Dnn6R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:37:52.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df5da5fb-cd5c-4607-df71-08deb5a3719b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289452-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,8.in:url];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: AA5B657EF29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add 'pages on|off' to the bash completion for ethtool -m and the
ethtool man page.

The man page documents that 'pages on' requires 'hex on', describes the
per-page header format, and notes that it cannot be combined with
offset, length, page, bank or i2c parameters.

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 ethtool.8.in                  | 18 ++++++++++++++++++
 shell-completion/bash/ethtool |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 32b971a..d4c4768 100644
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
@@ -1431,6 +1432,23 @@ allowed. In such a case
 and
 .I length
 parameters are treated relatively to EEPROM page boundaries.
+When
+.B hex on pages on
+is specified, dumps all relevant EEPROM pages in hex, organized by page.
+Each page is preceded by a header identifying the page number. For banked pages,
+the bank number is also shown, and for SFP modules, the I2C address is also
+shown, as different parts of the EEPROM memory map are accessible via different
+I2C addresses. The set of pages dumped matches what the pretty-printer reads for
+each module type. This option cannot be combined with
+.I offset, length, page, bank
+or
+.I i2c
+parameters. When combined with
+.BI \-\-json ,
+the output is a JSON object with a "pages" array. Each element is an
+object with the fields "bank", "page", "offset", "length", "i2c_address"
+and "data", emitted unconditionally regardless of module type. "data" is
+an array of lowercase hex strings, one per byte.
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


