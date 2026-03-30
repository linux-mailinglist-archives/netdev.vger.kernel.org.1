Return-Path: <netdev+bounces-273168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ15BEV2ymnZ9AUAu9opvQ
	(envelope-from <netdev+bounces-273168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:10:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4BB35BACD
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3735A3007E23
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6153D3486;
	Mon, 30 Mar 2026 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UD40qDqF"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15013D3480;
	Mon, 30 Mar 2026 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875741; cv=fail; b=S1oz/8j2DNnFSgTeNZYSCFAMu4o3lk8Z+gJ0OsfXX+WQAc/asOiH9N+A3ZN4Mh9RAzg/Rk9JbEcvpR4npv6wu/4MEFO3hI/8+OiQK65k/+1ePxB1DdEsWAPWjQ9E685YK1b/6c8ewyfAAxSbykD5G2N6xKFdDduYCDzbGc5P43g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875741; c=relaxed/simple;
	bh=riAeqPD0CinXO0w34lADv1ZMpan+TdiZ2z48wrp73XE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lIcAIichIF8G8m1BzRUORp4nrZqzCAu9AGT1dEObaF2cRuWxAOwovEdlgcD92gKM3OeAy26Vm+aSpTwaqBQRpyNwIw0xKhyqucQfs0GG0ILGtVurqMswAsCq06b1Q3G3boP/HL8a7nDG83F+c1M34DqKRIotmHn9AB0Z+zrBr0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UD40qDqF; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xr1tb3diQumRPkdllKtD5MPYfyh3XJ4pTTd9CwJCQ7jt0FHROqesKkJNIXD2/8ysE+wOV0Zm0UWQzqR8orkyAk1qCc6u4OwWWKVF6ooOCjXNN2OKXrljOHVqncjZ7EEWjyoNDrjnopBmCs/M/SVEXc0JNUcsOCjBEZBeV0BSPZUWiiOHCCcwvyXF6SZPtcXq9USurDULjSgLZfD74KfUhcKEeLUHs+zZhR7b8Wft+QAYfJOJdEoctuaxnDXjSoMdlumV8qcx850Wmyr+NYTAUUomap1dbCTmtOK2RHi3inhn0uIMpHMTk2lFR0ZymyYXEjPJAY7qnToH06u3yfaKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b5chQdY/froVV7yon+yuAdVJwXVCbP0lPeqykPaG/Y=;
 b=n+tDT1NPyusKs5HK8uomJymG0I9BKjlDH7wqbL9oTjiBjhJrg3+4/H1viRAtsPQSYqN5tIziGOGPMVxDkSkmwZQ3MUludTjqVAEg/vGXr0g3Zk0WEld/0MjF+/y3+ESUoKLh+feLbqoiC0TEN+T7UKlFDAgGic0WO+qVBYOykgWx/Zm6JTzGHKKCOmTm3wjeWA/qcMnuwZwkWkNDsfpB96IY6LeSMgDWveOFabo/Um2gPCWL4ZDmPVWzjxkTD/jOnboIV0FYQOVNDoyUQ2k8epb4qceRGRtDho7f4/il04ep5WVLqnQyJMV6a74wkfID707ywkC2Bhjg+7XialQcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b5chQdY/froVV7yon+yuAdVJwXVCbP0lPeqykPaG/Y=;
 b=UD40qDqF/S344/uAxA2mK/sXiHRPDZjK2T79TQDb9A5dqwTySJIbzXNSsvV5096dPWUYVTPGNvB9xxxAB72jYrB4vMgHaUY398aA0tAbLB+4ScOUbzKQssC4sDru0Mxhn8RRJlggiuy2K8IZEY0spiitCST7hGEBoO6sGa4Wsd36coFmBfIRwLTaCY1+pNvu/F82s8ZZPuWnivGssbuQJ8Y6BZlXwLdnBO1OqsX3gGkz2gNyA7ZH08gFXmQ9PNwZsRI4MrguNVtSgOK0WrZdeRTUMRloHdr1uQem5zh969mo5BjMkefRD7Bs7KWZoZc10WV50QmusH5kz0qSkQ4KkA==
Received: from BYAPR11CA0044.namprd11.prod.outlook.com (2603:10b6:a03:80::21)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:02:15 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:80:cafe::5f) by BYAPR11CA0044.outlook.office365.com
 (2603:10b6:a03:80::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 13:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 13:02:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 06:01:55 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 06:01:51 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v6 0/4] macsec: Add support for VLAN filtering in offload mode
Date: Mon, 30 Mar 2026 16:01:26 +0300
Message-ID: <20260330130130.989236-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fea0925-2eac-44c5-5ce5-08de8e5c90cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|7416014|1800799024|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xQ25Jn1J1AspIEf63l3TzrDvdC5d/iH5x/+VeeulUcPOVAB5Jtrcr2DxK+ZdTOVFCBMT1v8qZdy7GxvV9AITOYSFObczlFZHo2NbmBAWwkNySzIjkaIsrXxmFxILiTU7rTj643D2X8rHFoLziZXcNPv1pk7/YKG4ggltuRrzuUDjeEC5TbUlhqOhxo940t0b/jNLM9OGBBYS/ku0Edc0tXPdBfeyLhnyp0zRGqd6K5igDFrTiKGjZ0LFVodoR41eyzpqbIlyIH2AdSVz6qto66LyDE4kJRLAX++161f/QqV/MiaROmNUhWe8L0kdbsLqG8Q/R+dbzydYKskk/5YIaBAlmPXs4vcnZckppULEQduri2KxxK4y0JyH3ElAdUD1sMip4gYuauyvIsgOW9Cx/4boq9NOum5TKr6tUgq5eHtFvWqFSQ0NzhXI1QcPH2pyAr7n1kW4j8ZilaRmOjIWk6MKiQA8CAoIBO9cxP4ENcdZXLRV03+I9y1+pjRGZHBt2rsLH+3K+DMGVXnnruI1W9MHR5vo6asgVK67xmkEUy5tfimibzMM/T4P+rwCwbxFx0uGGgm23s6l7I8LKZWI3nz+45GuRzZ9DoXJM6Kusb56Mx+yULtioWRGHRDES/sYKit218Lfuah7FHiTj00aJyUmx36HiUqVp4zJi+c/4L0YWJEzZjFllXEjpJ87KlDmqpkTA3E5CZENovtrO7gzL+L17brmtvBFKdL4bleps35L+FfpxjsNQk1Z1YKN4v8pPziJe+gtDLEuibyPiGy65Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(7416014)(1800799024)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xx2RucOXd1z8UsNTxHsPQXd2/ugAcHMCTSdpsyxGkb2JfHtOyjo7phuy9up1Uiat8dv/mXhdFhA+Bm8WOVkUnMz0rwVS7oMzF0srD0YsHCdWPmsGbtijlIhih+s0BU2f4S+3lhEfMyXFZ/7deUvr+b+ZYQEcFWalcnDm4Qv7w9gxTCOuxS3cBOEs4WS9qNkwvnb+QaGVozSWaPmiuGiGetUtDZxSPTfnkk2XNsTGXcoYASj1qjzE0ULsd5w0pDV2xIhD6KgRUqH6IQ5gT0Dfw2wpcERX/DbJ7fR+OPaDvHMn44A39HpRVIGlvouWY7AqLLcdaxpaHpUkuiBqexydrRyzSc3zu/sjeBA4t2jc/XgokFV6VCMA2/FTqHBa0othwASOHf1xIsswEJHuPBpOFVJ1zBR03wRj686iBc6w4bmtsZ4pbbfXYiMi/qZDBjMP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:02:15.0197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fea0925-2eac-44c5-5ce5-08de8e5c90cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
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
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273168-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6F4BB35BACD
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

V6:
- Resurrected nsim debugfs file for VLAN filters.
- Switched to WARN_ON_ONCE in nsim, which is always compiled in.
- Tweaked tests to check the nsim VLAN filter file on nsim.
- Disabled ping on nsim in offload mode, data plane doesn't work.
- Added CONFIG_VLAN_8021Q to the test config.

V5: https://lore.kernel.org/netdev/20260323123633.756163-1-cratiu@nvidia.com/T/#u
- Merged tests and macsec lib in a single file.
- Fixed Python linter issues.
- Added CONFIG_MACSEC to tools/testing/selftests/drivers/net/config

V4:
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
 tools/testing/selftests/drivers/net/macsec.py | 330 ++++++++++++++++++
 .../selftests/drivers/net/netdevsim/Makefile  |   1 -
 .../drivers/net/netdevsim/macsec-offload.sh   | 117 -------
 9 files changed, 452 insertions(+), 125 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/macsec.py
 delete mode 100755 tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh

-- 
2.53.0


