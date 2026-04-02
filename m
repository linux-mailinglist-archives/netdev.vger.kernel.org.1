Return-Path: <netdev+bounces-274471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCNLMmlQzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:18:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA238834F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D86F30479C5
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E83AC0FB;
	Thu,  2 Apr 2026 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PP4Xq2xT"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16731386453;
	Thu,  2 Apr 2026 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128286; cv=fail; b=F6tYM0CyLke5srXn3w9FzL5ShMMX1IGOBu1tsx6JH+sS+3caqjln9I/TlYtC6YUzJqfBtqg+FgIfC+jk+hopg0koUVVTxNFj2YiSPKPgcE/Hco0XhRdhcTJQ9cmcvV0Yhf9vH/huLt8oVWYl3kpRM8YooSwYwQc7UsRZEKpiPSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128286; c=relaxed/simple;
	bh=fVnvIrRSAlAyBwrQ6pFdjM5aWVzsLbDZ9Mzca7qw2XU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=loMjtusVuM7w5Dyz+jXUXH+ddV/NfNvcepixNHlOdR0SEFShDb6kKftb19SACiR+8vhpZicxeJfyw1oO6e27qeYXcYJcMfWKNFJO8llyA4kXJG+T1QngYyK3jOZJ8HlSE5wHm54MA8TQsOBPBBRyBxzkhFtOnQYaJ/j6XMjqWXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PP4Xq2xT; arc=fail smtp.client-ip=52.101.56.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tplPPCfjp7xHz7/2aQkAhaSZ+iQG9pnXLTrT9P4OgAwK0LhW6LeWr75Sp2QFKVuz25nblj1ErZHa5vNp7pyrwX1pLBSUV3SCR6YmIZz5Ey9kF++ekiFHlV9qEUWNAkjKFyVnD8Hrm6Jw9s12KGvSCYg9TirM4m1Jx/gnG1wOEtI9Cpd7vv6mHtiQD/FyOMmyTiTUDFiRNIF+aPgLuAJA8nnX5JdRldB8UC1Nv7SeOGVrBFZEZM2cpSR7P5uzb5Z0otipKz1ynkGdaPghXTH4NIVgL0lmbXH5lyCzPY03elAcjC56NWPKNTKtmsvr6d2epMRDnqBDUjZi1EQGEEjzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnlmygM/FfERX9rHvfkb8GqaKdH6iW2cgftHmTaB5rQ=;
 b=qJ+W8Bc8zJ/nJZhCH8chsZV/x8M8vKEKvftfhXb3zyYtac/xU2jlqdZzCRUVvJC/ZPu0ePZ1+hVjjrfN50Q0Ub0W29Hg0qY1aYpWZaVOS7E5ULro6o5oOnk3MH1sJWiH4w5dySMJxpevqHWtdQJw2Ds7budy68sCDxebGR/h+bfTa2KLlTeEFV0MArYKqYIQdKSMvUDlFNGYqtB/r7M8ZV0rpaqIRmyQgCS9Fq+UiqcHIGb0wFgMaxkZeBzJPtJ2ztyjAO0lNE4agL3ijDRiOqufxV0pQH2NczAU5zzDioX1oH4HNW2/uHsqq9niMvfaOl6uYEThrt4chK0LAPs6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnlmygM/FfERX9rHvfkb8GqaKdH6iW2cgftHmTaB5rQ=;
 b=PP4Xq2xTOdH2YixQDPtZBtCD0WPEsZgdDlg92IcWyGqiwtPOqZWXWy9uh/hQnuc2bVSM4cHpBgFp0jdbqp6W+50cBDIwM6cUw1w819nEzN7obStRiOYp9EBcMrtZoTClu6AtSz8CisDuWasUD4XFznvpTPJvnOXfUkdZDS8Gg4pHCAMXN1OGn2iEYMuvN0210pgR5fZ72WJCgCvPNdgC5E/04+qnCDeeNKTDTaXWq67VQOnI5fsergzeIAJNXNiEG8VG/Eb3VuQ9EIfj4XLGtidNFbfDTSxpGx+Fdklug8O/MrXc9ClVBbbr3gNBI7eL9yOlxLmRWSsIJAJrA1AKCA==
Received: from BY5PR16CA0027.namprd16.prod.outlook.com (2603:10b6:a03:1a0::40)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 11:11:15 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::b5) by BY5PR16CA0027.outlook.office365.com
 (2603:10b6:a03:1a0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 11:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:11:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 04:10:56 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Apr 2026 04:10:53 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, David Wei
	<dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net v7 0/4] macsec: Add support for VLAN filtering in offload mode
Date: Thu, 2 Apr 2026 14:10:30 +0300
Message-ID: <20260402111034.1494714-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 908eba36-e7e0-4bcc-4a99-08de90a88e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+5rjucn1lorQilDJkEsjS1MJLd4TbGkZHHlZxfVrCZ4UEzDb5iXp9j0buGuqW099ElDh6cK1eakN9hqoDlDIcuUEyEnjBAhXtOfaagjQLVkwgMYDeli9SF+M5W2X0s11UwSSD3ogkJzE5r8G5hAgIjXJELzb2LeUth+E1F8CnngWMtSMmLYjLqMu0/3H72DgqFQiARgJHJxMew1skxj/ShoIzEFLgtb1ainAsEnEZVF63q78Z/UpNKtX2AS0qw3Uqz86MU6u8h1Yw7zJCJiUSdlpfW65iuRhBrPioSOWFhU/YWoSDkub98NejXqDc0TDjfQ+dadfimOfnksP29VKZiNSx+DkkUK68ff3/4oXHNl7MFL7Oj+gKuilgHXNlDHNE9iYPUqXU+24cKMfXKHgnKHmuiWFNU48aWtwBjK2PZvFVyyVc5867gSPrzWhZlj6hhibkPCf1NwL9V09Bq/q3/xKC4eRnFp1phJJOp+Llhy2aEUbIkdVF5qtE7Bt4/3F1oLolGE+nhqRAeSn6RhIx+lNYo0jwVxk0PuQHXSxJV2TEPawC532g8g2KcLAhXKofIrUMYIIC/cSLRo4XS7CRiOyRuKBXEkpDJdNDfFpSdNKi5MIMKeJdcK+PbKqw6Sy6RGOhA81yTSJ9FpVPm1VzmnkIDm0ptM6YxS+TtHHR6hxRte/+1XAn/gZvJZ8inWarvLjGQtHvWTaAAQSUHS2LdwGUV6KN7cMvYgffWqoDaTwzC99nuguLczIg+ivzVyL8/dlbae0dPW4DCKeGXnufw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kMuBuSxZS7fzyDhGld8ZZZFH+zg0T1FbBe21NwCYZUNW0a93E5EuGwxt0CTlc4nWS9OlG6Yk2eDqJguHoRmJsGWSru7JtkzpFgBSjc7vhZHhIdmqnjx9DyGFPaX3Y7ES33rchdUcvBJSKGMVtSCoGl1qBkhBscFOwpV85oZRkDVHsUepFF5ViJmcvt27nuYJKRXKXP9kh6tC3ohX4xvydDwLd/ZorYvHyh1j65PKBUjfUkdtndggcHNvnlNZc3MRW3VGPZD0zS3Mg9s6nCY3ajg995XmuEs/Poq8pk7c4g8GAzB2kdf75mlX0JYILFA2rexXaTRnuy6YaokXyYntGwkxaUGi7y5Jc+18fGWB3itcXJX/oCwy4Cwkj6YC5y6zCkIEYH1YtSElI4OgBrMYJ+nzH9quYeI/RcsNUw86AGGGsPWGon5dH0/RHy+9FH5S
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:11:14.8701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 908eba36-e7e0-4bcc-4a99-08de90a88e57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274471-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6EBA238834F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This short series adds support for VLANs in MACsec devices when offload
mode is enabled. This allows VLAN netdevs on top of MACsec netdevs to
function, which accidentally used to be the case in the past, but was
broken. This series adds back proper support.

As part of this, the existing nsim-only MACsec offload tests were
translated to Python so they can run against real HW and new
traffic-based tests were added for VLAN filter propagation, since
there's currently no uAPI to check VLAN filters.

---

V7: 
- Added missing ethtool feature checks.

V6: https://lore.kernel.org/netdev/20260330130130.989236-1-cratiu@nvidia.com/T/#u
- Resurrected nsim debugfs file for VLAN filters.
- Switched to WARN_ON_ONCE in nsim, which is always compiled in.
- Tweaked tests to check the nsim VLAN filter file on nsim.
- Disabled ping on nsim in offload mode, data plane doesn't work.
- Added CONFIG_VLAN_8021Q to the test config.

V5: https://lore.kernel.org/netdev/20260323123633.756163-1-cratiu@nvidia.com/T/#u
- Merged tests and macsec lib in a single file.
- Fixed Python linter issues.
- Added CONFIG_MACSEC to tools/testing/selftests/drivers/net/config

V4: https://lore.kernel.org/netdev/20260313105227.1884391-1-cratiu@nvidia.com/T/#u
- Migrated nsim-only macsec tests to Python, usable against real hw.
- Ran these tests against both nsim and mlx5.
- Gave up on nsim patches since the tests no longer use them.

V3: https://lore.kernel.org/netdev/20260306151004.2862198-1-cratiu@nvidia.com/t/#u
- Moved back to net.
- Added proper rollback support for VLAN filters in case of failure.
- Added VLAN as a requirement for the new macsec tests.

V2: https://lore.kernel.org/netdev/20260227090227.1552512-1-cratiu@nvidia.com/
- Sent to net-next instead of net because of apparent complexity.
- Changed VLAN filtering to only function in offload mode.
- Added tests.

V1: https://lore.kernel.org/netdev/20260107104723.2750725-1-cratiu@nvidia.com/

Cosmin Ratiu (4):
  selftests: Migrate nsim-only MACsec tests to Python
  nsim: Add support for VLAN filters
  selftests: Add MACsec VLAN propagation traffic test
  macsec: Support VLAN-filtering lower devices

 drivers/net/macsec.c                          |  44 ++-
 drivers/net/netdevsim/netdev.c                |  65 +++-
 drivers/net/netdevsim/netdevsim.h             |   8 +
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/config    |   2 +
 .../selftests/drivers/net/lib/py/env.py       |   9 +
 tools/testing/selftests/drivers/net/macsec.py | 343 ++++++++++++++++++
 .../selftests/drivers/net/netdevsim/Makefile  |   1 -
 .../drivers/net/netdevsim/macsec-offload.sh   | 117 ------
 9 files changed, 465 insertions(+), 125 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/macsec.py
 delete mode 100755 tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh

-- 
2.53.0


