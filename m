Return-Path: <netdev+bounces-275487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIh4JLvL0mkhbAcAu9opvQ
	(envelope-from <netdev+bounces-275487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 22:53:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C2139FCFE
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 22:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 070C5300B9E6
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 20:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBB43845DB;
	Sun,  5 Apr 2026 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rywx+aKR"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803FE3845A0;
	Sun,  5 Apr 2026 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775422357; cv=fail; b=A6GLLu/yYfuKWCcnTP44Wuq6bdEr4QWUdJ/VGXOgQ95Uj4TITrNRy0w1NCMlPyuj3LhqhntHAOmlUxD5UyfKxQKuRjE3No62bU4zuZk0GuGbHs3Nk2EC5pIokpErb0HwY9GeMnrz4q7jIqGgDvIn88rf51GFg0c8oA/PwFlUUJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775422357; c=relaxed/simple;
	bh=kiJF8N6yjTIobo7AxhdlIaE6hj4pTFW5SynC4Im0fP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MDlnFoCOoiiQQARZIIR6MYPk28OF4CpLeegNdX2tL/1owej9ra7m8DJUVTanCkUfGflyjQK0werVtIZgUzCml0U2nz5WMg/0GLTuw1gpWM4R81C8YRb7blbPREaYCf5lwFfMLCeBfVgv3OIcIabP976EoEq0KpWqHFLiEhYT22g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rywx+aKR; arc=fail smtp.client-ip=52.101.57.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isesC3gAOJ2A5VM5J8KPLSx84LH+aPUzk5DyZc8RBcqRStHPYsebGqUokcdwRxW5bV8zKL8qKoQTCoLToRSsr8xhhTNHylIZrudzz50A7FoUjB58b0pr5X3XCbg06m+2i6UMhdQMJNWwykh7p38+tOkDDRp4USPIaH+zZYM/gnnvTLmPen3mGzbDvWbZTl+SROpAsae+5S7fy1/CmMifD7Np/wb6rX1EkLxY+XBn3jXuWPz5oWzGr2wIed7GcdkPCyEWOYI1Bip9vHgUCuqwtfZ6KO5ThMKKUhZodpDyn8IrDSVrbYQuwydHL0E48rQnJT0+Jn57ZyZZsgSzenlslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Hwtjala+FQOUrzVLlofKalszfgiPzfB7hvaCAlvc9k=;
 b=OR4yFb8rlCaEQEicbfAz+SiN6GFVMJ58Ycg+I5mLlyUfb0yOuhFAFp00DvMb1SiDD6z1i2THyqibS6/w/skrZEKawbeVHdB7L6dxShow2cNhRjsx5JRfXoAmviUpqhCYQBA/hC+FMWjsNWAwj2B7p8d3yTRv/d8dYfTc29zE8YEKIfRRkQTTBtl3kf9Zw05ysqjf4l+VSeWTK09Im7NeKqfkKa/uONfhe0hZ83g8deOPut5LlwPuX+OycPK1zG8Qy5qY6Q8OmjsncV81Q64dLuPF5XqznwSdRI1cIlG9dufcsgzey7zS3aAAnxfnh2LbQF8mr87lhNW6Ja2o7P+1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Hwtjala+FQOUrzVLlofKalszfgiPzfB7hvaCAlvc9k=;
 b=rywx+aKRaAKvLpxfC2LBGW/z6hzsjkEsqkUDuCx6xKpPxPaIWzORV24DWNRBq6d+fAVT8aVSz+yXHBtcDvsDC+nPX6Dww3mnjzPQaIoZxj49DI5T1cTXeVuCz9ZnGGzeIteM+/99xGJ6sLEmazsSVbF+J32DVO/CbFudTxrultje1ErycQoRjEpbTe6qyFYk30Q2qRoIhiaR6AMIaJMaZSpS5/shQcjFQjU2kLrc7IT59hvxfg5qoTKMt5MsfsC6CHTl1/o3qNTZpdzcYUMoPTf+F4QgauKAW+DiAcSIETMBfBThLxWvbQ3lFhMsKoLH3RmAoAECX4xK5YfB3rEQTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sun, 5 Apr
 2026 20:52:31 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.020; Sun, 5 Apr 2026
 20:52:31 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Roulin <aroulin@nvidia.com>,
	Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: [PATCH net-next v4 3/3] selftests: net: add bridge STP mode selection test
Date: Sun,  5 Apr 2026 13:52:24 -0700
Message-ID: <20260405205224.3163000-4-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405205224.3163000-1-aroulin@nvidia.com>
References: <20260405205224.3163000-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::34) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b49b09-1714-42f3-a09e-08de93554149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	oJdsEGmDaYAdSWXd8yrOBMxtvwmRY4moBPgrRVD0a3tatAK43AZWINuudhz7D0eFg62rNs2O0NXVcpcjXtJMJtxlc5wThUpWyhV+Rxqq/zhHYF8rTBCtq/KgYjuD193Khr6EVs2T06idjENPL4u5DlveHpIRS/qeV0n2ij5uIiROXBoYey98diEZYL8/oUkrqYVUyOv6ZhmerOqt9RS/2R9x4csphUJtyX1/o2NqIYJhGqP6FWBvbkxYnj3ru0ZHs1ZSliRMHi19KxPZUJ6TNlMsclv3znvEZ/viFiJ8592shzTANS0OVE4kr75daeJXu7uuPSh/5KtWZQNGqgQw99wOQdImSZocdtw+9ihZW3A1qDDpzoXN7qbPa1zvqLUWhcpRBaNHaXSKJAJWJeNU7P0OeiVWLfA6CG2dwdPd8v7/uQjYLKZlCTj/O4NT7sMZ4jq7f2KeOW3nLu5ml0EhAlu4T0toSy+Sy8yBalirObTjS9Nf4t/pE2rHR9bwLddTkryLtURlLzYSlZclP4+j8oJZynfodfzNNhXzzNFxXjVFTPisEtEahuQFuQyiAh+uLIFMRq6CyRCDu/CGFhGCYw8PKWNtfo0yi5KyX066PP0GsDHQQ0iUZy8djL1sKlROSXkXdbs4UpYmrQQHENzRg+MUR7bhRoswj6cA6lgl1yK46JylMXFS+Xdyz1YOKtUjMM+8Kw9z1fZ4IFlUM/TJoLkIbNfQARW4dstrARO37WI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18092099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+363U8wlQ+liQp1tEBuCe8VCZbIhWu1vJMDhjH/uRwJVh3s2kvcJ8eMjGBR2?=
 =?us-ascii?Q?nMOEQvoKi+pmdVhaHwUfTYVQ45XHMaA5jcC/hBf7SgnQT5WC6iNj7SBb9cfv?=
 =?us-ascii?Q?VKqTOUgu+Q4BlxxRzwtur8Kv4BZoJRaQozzcXC/SY7HB3kp/4IXtlF9JG1eX?=
 =?us-ascii?Q?olRv97n8KhCrLBf64xIMhW2hu9GnYjxOFPTT3UoSugt6SmOWIPNzqgI0AHia?=
 =?us-ascii?Q?RsuejZoH8BY0UPcSPRPYeOFkOEGXxFWkvPFrNDfG1nrlINiEBt8AXcG5Z1nK?=
 =?us-ascii?Q?Jf3cR4bc89L5/3RrvyE4bz83o1yx2YME4LlpdVFFUvNqXrTT7+RCCJi8YrLn?=
 =?us-ascii?Q?Ep5VyJICEBeYAjaIe2TXcH6cysGCl9xzWvppfll0x99pAvJARO2SoGoIMYCL?=
 =?us-ascii?Q?rmza01UITybjBKg0Xg6r11RLlBmW4B36UC0exWqD1FekhSc0Tg6qP6ScNqgq?=
 =?us-ascii?Q?NN2zSjEHnl0SDrABzdRPOVWDHQ0pgjhuu4CE2fw1x81u1HB02xSTP1ZjIUrM?=
 =?us-ascii?Q?sqT5H+LqcVo/RwdOtYmsF4Y1vGe+pNN9Oewv+kvEfq09WMIcSlbOqcAtJYF7?=
 =?us-ascii?Q?WYpyJFCpTz5Fr9mqgysYH0c8FeE9gKLefzyt0HoSiriWVhuoBdhu+ScDSt3+?=
 =?us-ascii?Q?HOsdSKH2Mi/vsGolwY0uijbiqwEGZA42lGZQdhfVpuBZQZIpFwc7BOzH+8z6?=
 =?us-ascii?Q?E+v51ah7rnPDodAXgcMmj6x0dmt4dHYodYlcCbfexc6vEaApaFUKXYaW5UoE?=
 =?us-ascii?Q?C5J9tbPJZi+FdtoX2NWLYWL6+CBj9p9V2GEnvm2vZeZdPjtDyU5Yp9t8FAab?=
 =?us-ascii?Q?g1Pc++q7ug/IiVUXfG7x7dX97KMwE2HPpaJ+VqXOv6P7AX64cbQfh6BSy9Tm?=
 =?us-ascii?Q?PRa113hBg4fiioFJGnv7c/FPup2hND+eWzlRziHAZfDoUvIyIzA3JJ6E+LKE?=
 =?us-ascii?Q?M7QVrChowKVJ0ext2F74fbiZyNPUknxwpUndY3J7hGDkz7ueJh1DxGMAs+OW?=
 =?us-ascii?Q?WtSGOZtEvnNIC1ZAi6Mn4Xk+QmCyzA45iaxXSyhO4dilTs6PgWGybRtxNRJs?=
 =?us-ascii?Q?wbMvwHflNIW3tfaMP2Y90KxOW+NW2y2yhMM5P/HDROSEBuVR6DRFMzuBRQuA?=
 =?us-ascii?Q?fQNACvrg6FmLHOfNqHZVoJVf5R7ATxVQgG9rwW1BeMOuxStXWsWOZofh1yMV?=
 =?us-ascii?Q?OSrewn47DQIwbn34jKf3SpjmIVccq+XQQxJhrfsiGaHXUr3+nuLuXMZD1bQd?=
 =?us-ascii?Q?PDDQiG86BhcEo6wok57ytMuPfw3l7On71q3dC3zlbzgmKfGfTn/8QES4JtBi?=
 =?us-ascii?Q?tJpdZ83IvCUfowhMY4vqIDtdLP/JCTCR7h3mEvvrdMOix9vY4nuQ4VR/vQdY?=
 =?us-ascii?Q?wo2SXW9BRgKHraP/3esWZez5kitNSV09lUK7Ym/Y64QBUBYwudta11BF3VSQ?=
 =?us-ascii?Q?kXjjP148rKLxN+HxAqx0Ytq2mEwZ5uYxSNfC8o8AATzq49+68Loh/IMOfQaQ?=
 =?us-ascii?Q?PtRmPKgB5ZGwQA3BfWhMEYiEd4/cVkOQliWKSSHGgS77J+lD8MrleiJ/aKfv?=
 =?us-ascii?Q?c216+kizhF5rs4Cb2Ph4Ydu6Yg7CDy9ESC5Eov/+TDbHomnADLN9uhwd5ENu?=
 =?us-ascii?Q?yPB4oBdVozQDqjorelxIF/VHipXhbZQQxXbkwFUEO2kv5TnWeYGd2uhnADDq?=
 =?us-ascii?Q?Mqj/DtFRHJ/2g67ySqqZsAe6jm+MlwaUGR+rN/vpsOuvVBzHTvBlgiYYxZc/?=
 =?us-ascii?Q?k6IV0m3zfQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b49b09-1714-42f3-a09e-08de93554149
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 20:52:31.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvDMhVejqHyI5BMExq0Ej683JUyEoDgzJ6o1NjnfTmqpOO5/+YMt8Tzj95E4ed8FfNMIvx35cbqF/rGlwn5M6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275487-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 33C2139FCFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest for the IFLA_BR_STP_MODE bridge attribute that verifies:

1. stp_mode defaults to auto on new bridges
2. stp_mode can be toggled between user, kernel, and auto
3. Changing stp_mode while STP is active is rejected with -EBUSY
4. Re-setting the same stp_mode while STP is active succeeds
5. stp_mode user in a network namespace yields userspace STP (stp_state=2)
6. stp_mode kernel forces kernel STP (stp_state=1)
7. stp_mode auto in a netns preserves traditional fallback to kernel STP
8. stp_mode and stp_state can be set atomically in a single message
9. stp_mode persists across STP disable/enable cycles

Test 5 is the key use case: it demonstrates that userspace STP can now
be enabled in non-init network namespaces by setting stp_mode to user
before enabling STP.

Test 8 verifies the atomic usage pattern where both attributes are set
in a single netlink message, which is supported because br_changelink()
processes IFLA_BR_STP_MODE before IFLA_BR_STP_STATE.

The test gracefully skips if the installed iproute2 does not support
the stp_mode attribute.

Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---

Notes:
    v2:
      * Fix shellcheck CI: add SC2329 suppression.
      * Add idempotent stp_mode test.
    v4:
      * Add disable+mode-change simultaneous test.

 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/bridge_stp_mode.sh  | 288 ++++++++++++++++++
 2 files changed, 289 insertions(+)
 create mode 100755 tools/testing/selftests/net/bridge_stp_mode.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 6bced3ed798b0..053c7b83c76dd 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -15,6 +15,7 @@ TEST_PROGS := \
 	big_tcp.sh \
 	bind_bhash.sh \
 	bpf_offload.py \
+	bridge_stp_mode.sh \
 	bridge_vlan_dump.sh \
 	broadcast_ether_dst.sh \
 	broadcast_pmtu.sh \
diff --git a/tools/testing/selftests/net/bridge_stp_mode.sh b/tools/testing/selftests/net/bridge_stp_mode.sh
new file mode 100755
index 0000000000000..0c81fd029d794
--- /dev/null
+++ b/tools/testing/selftests/net/bridge_stp_mode.sh
@@ -0,0 +1,288 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2034,SC2154,SC2317,SC2329
+#
+# Test for bridge STP mode selection (IFLA_BR_STP_MODE).
+#
+# Verifies that:
+# - stp_mode defaults to auto on new bridges
+# - stp_mode can be toggled between user, kernel, and auto
+# - stp_mode change is rejected while STP is active (-EBUSY)
+# - stp_mode user in a netns yields userspace STP (stp_state=2)
+# - stp_mode kernel forces kernel STP (stp_state=1)
+# - stp_mode auto preserves traditional fallback to kernel STP
+# - stp_mode and stp_state can be set atomically in one message
+# - stp_mode persists across STP disable/enable cycles
+
+source lib.sh
+
+require_command jq
+
+ALL_TESTS="
+	test_default_auto
+	test_set_modes
+	test_reject_change_while_stp_active
+	test_idempotent_mode_while_stp_active
+	test_user_mode_in_netns
+	test_kernel_mode
+	test_auto_mode
+	test_atomic_mode_and_state
+	test_mode_persistence
+"
+
+bridge_info_get()
+{
+	ip -n "$NS1" -d -j link show "$1" | \
+		jq -r ".[0].linkinfo.info_data.$2"
+}
+
+check_stp_mode()
+{
+	local br=$1; shift
+	local expected=$1; shift
+	local msg=$1; shift
+	local val
+
+	val=$(bridge_info_get "$br" stp_mode)
+	[ "$val" = "$expected" ]
+	check_err $? "$msg: expected $expected, got $val"
+}
+
+check_stp_state()
+{
+	local br=$1; shift
+	local expected=$1; shift
+	local msg=$1; shift
+	local val
+
+	val=$(bridge_info_get "$br" stp_state)
+	[ "$val" = "$expected" ]
+	check_err $? "$msg: expected $expected, got $val"
+}
+
+# Create a bridge in NS1, bring it up, and defer its deletion.
+bridge_create()
+{
+	ip -n "$NS1" link add "$1" type bridge
+	ip -n "$NS1" link set "$1" up
+	defer ip -n "$NS1" link del "$1"
+}
+
+setup_prepare()
+{
+	setup_ns NS1
+}
+
+cleanup()
+{
+	defer_scopes_cleanup
+	cleanup_all_ns
+}
+
+# Check that stp_mode defaults to auto when creating a bridge.
+test_default_auto()
+{
+	RET=0
+
+	ip -n "$NS1" link add br-test type bridge
+	defer ip -n "$NS1" link del br-test
+
+	check_stp_mode br-test auto "stp_mode default"
+
+	log_test "stp_mode defaults to auto"
+}
+
+# Test setting stp_mode to user, kernel, and back to auto.
+test_set_modes()
+{
+	RET=0
+
+	ip -n "$NS1" link add br-test type bridge
+	defer ip -n "$NS1" link del br-test
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode user
+	check_err $? "Failed to set stp_mode to user"
+	check_stp_mode br-test user "after set user"
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode kernel
+	check_err $? "Failed to set stp_mode to kernel"
+	check_stp_mode br-test kernel "after set kernel"
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode auto
+	check_err $? "Failed to set stp_mode to auto"
+	check_stp_mode br-test auto "after set auto"
+
+	log_test "stp_mode set user/kernel/auto"
+}
+
+# Verify that stp_mode cannot be changed while STP is active.
+test_reject_change_while_stp_active()
+{
+	RET=0
+
+	bridge_create br-test
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode kernel
+	check_err $? "Failed to set stp_mode to kernel"
+
+	ip -n "$NS1" link set dev br-test type bridge stp_state 1
+	check_err $? "Failed to enable STP"
+
+	# Changing stp_mode while STP is active should fail.
+	ip -n "$NS1" link set dev br-test type bridge stp_mode auto 2>/dev/null
+	check_fail $? "Changing stp_mode should fail while STP is active"
+
+	check_stp_mode br-test kernel "mode unchanged after rejected change"
+
+	# Disable STP, then change should succeed.
+	ip -n "$NS1" link set dev br-test type bridge stp_state 0
+	check_err $? "Failed to disable STP"
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode auto
+	check_err $? "Changing stp_mode should succeed after STP is disabled"
+
+	log_test "reject stp_mode change while STP is active"
+}
+
+# Verify that re-setting the same stp_mode while STP is active succeeds.
+test_idempotent_mode_while_stp_active()
+{
+	RET=0
+
+	bridge_create br-test
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode user stp_state 1
+	check_err $? "Failed to enable STP with user mode"
+
+	# Re-setting the same mode while STP is active should succeed.
+	ip -n "$NS1" link set dev br-test type bridge stp_mode user
+	check_err $? "Idempotent stp_mode set should succeed while STP is active"
+
+	check_stp_state br-test 2 "stp_state after idempotent set"
+
+	# Changing mode while disabling STP in the same message should succeed.
+	ip -n "$NS1" link set dev br-test type bridge stp_mode auto stp_state 0
+	check_err $? "Mode change with simultaneous STP disable should succeed"
+
+	check_stp_mode br-test auto "mode changed after disable+change"
+	check_stp_state br-test 0 "stp_state after disable+change"
+
+	log_test "idempotent and simultaneous mode change while STP active"
+}
+
+# Test that stp_mode user in a non-init netns yields userspace STP
+# (stp_state == 2). This is the key use case: userspace STP without
+# needing /sbin/bridge-stp or being in init_net.
+test_user_mode_in_netns()
+{
+	RET=0
+
+	bridge_create br-test
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode user
+	check_err $? "Failed to set stp_mode to user"
+
+	ip -n "$NS1" link set dev br-test type bridge stp_state 1
+	check_err $? "Failed to enable STP"
+
+	check_stp_state br-test 2 "stp_state with user mode"
+
+	log_test "stp_mode user in netns yields userspace STP"
+}
+
+# Test that stp_mode kernel forces kernel STP (stp_state == 1)
+# regardless of whether /sbin/bridge-stp exists.
+test_kernel_mode()
+{
+	RET=0
+
+	bridge_create br-test
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode kernel
+	check_err $? "Failed to set stp_mode to kernel"
+
+	ip -n "$NS1" link set dev br-test type bridge stp_state 1
+	check_err $? "Failed to enable STP"
+
+	check_stp_state br-test 1 "stp_state with kernel mode"
+
+	log_test "stp_mode kernel forces kernel STP"
+}
+
+# Test that stp_mode auto preserves traditional behavior: in a netns
+# (non-init_net), bridge-stp is not called and STP falls back to
+# kernel mode (stp_state == 1).
+test_auto_mode()
+{
+	RET=0
+
+	bridge_create br-test
+
+	# Auto mode is the default; enable STP in a netns.
+	ip -n "$NS1" link set dev br-test type bridge stp_state 1
+	check_err $? "Failed to enable STP"
+
+	# In a netns with auto mode, bridge-stp is skipped (init_net only),
+	# so STP should fall back to kernel mode (stp_state == 1).
+	check_stp_state br-test 1 "stp_state with auto mode in netns"
+
+	log_test "stp_mode auto preserves traditional behavior"
+}
+
+# Test that stp_mode and stp_state can be set in a single netlink
+# message. This is the intended atomic usage pattern.
+test_atomic_mode_and_state()
+{
+	RET=0
+
+	bridge_create br-test
+
+	# Set both stp_mode and stp_state in one command.
+	ip -n "$NS1" link set dev br-test type bridge stp_mode user stp_state 1
+	check_err $? "Failed to set stp_mode user and stp_state 1 atomically"
+
+	check_stp_state br-test 2 "stp_state after atomic set"
+
+	log_test "atomic stp_mode user + stp_state 1 in single message"
+}
+
+# Test that stp_mode persists across STP disable/enable cycles.
+test_mode_persistence()
+{
+	RET=0
+
+	bridge_create br-test
+
+	# Set user mode and enable STP.
+	ip -n "$NS1" link set dev br-test type bridge stp_mode user
+	ip -n "$NS1" link set dev br-test type bridge stp_state 1
+	check_err $? "Failed to enable STP with user mode"
+
+	# Disable STP.
+	ip -n "$NS1" link set dev br-test type bridge stp_state 0
+	check_err $? "Failed to disable STP"
+
+	# Verify mode is still user.
+	check_stp_mode br-test user "stp_mode after STP disable"
+
+	# Re-enable STP -- should use user mode again.
+	ip -n "$NS1" link set dev br-test type bridge stp_state 1
+	check_err $? "Failed to re-enable STP"
+
+	check_stp_state br-test 2 "stp_state after re-enable"
+
+	log_test "stp_mode persists across STP disable/enable cycles"
+}
+
+# Check iproute2 support before setting up resources.
+if ! ip link add type bridge help 2>&1 | grep -q "stp_mode"; then
+	echo "SKIP: iproute2 too old, missing stp_mode support"
+	exit "$ksft_skip"
+fi
+
+trap cleanup EXIT
+
+setup_prepare
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.43.0


