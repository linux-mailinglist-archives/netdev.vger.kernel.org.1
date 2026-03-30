Return-Path: <netdev+bounces-273047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BUFCD3eyWnM3AUAu9opvQ
	(envelope-from <netdev+bounces-273047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:21:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF2B354BFC
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CBAB3002F7C
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 02:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FA7392823;
	Mon, 30 Mar 2026 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E7ubfA8g"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A960391E40;
	Mon, 30 Mar 2026 02:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837280; cv=fail; b=mDGV86EsW0YWWBgCoiOqjNkL1OV3RJShAOk6YELC6ajM83S5cE1sszDFwrgPvi/zl0Bhn3EvTGpV4g1DRCfzkF/AA6cDVskW6eaqQaM01BNwpf1Yumf63F8iALGvRltIsxt15TsfLkxobBpeWA0zZOv3qTs+28GGIosAEw6WqqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837280; c=relaxed/simple;
	bh=5jCkHkfSjmkcxCScj0qC0OeI0UhHSFU2V935Ptpi2hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jt8/eDzzOvgL/3mUHnIuiaGKDx8gY35MDvTvqpLcnLZIayGDTM9GxaXWE2elF8EWCZ06X9nGiLh5TvgVrgKSU6iyfD/1l/aD3rdMKKS08HM1jfaHVzyGqWbTRcyHL9sI20c6MDfX7VTPkP1efUVK+uRZLD6uwvCEtYMZvtgVWDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E7ubfA8g; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUeoJHYt7Jq1A3FE7B9RSxkX4QNoTPocyy7x/84qX47Pr7AV9w43LYrfmkmWOIM3OPKpkCl+iRhIz/6/LWVg153v26skjA3SBtqfzHOoHg4tAVU3AuPV1CK6FVP12+4nNNuFGTS44TNoNMCQZAZ5zhINQ0iV6JEoK0eVQLtcLcAjIekaKUHNAl0c7IcgwiJQ5zAmWa97GMv4WMWWqc3I+TqUQtpeNOMG6kVocUYrsUYGnmD0c7WW8U0SIk9/CHfbVJsPfSOveqZCaxGSxNByEOoGleZSQ6fwWRHS7E2pUKvs/5adJVCi1yI8pxN+tqgrIjfVjitaOQ3JavHW3TGW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWhkJlaLx+gijcnZVU3Eudd72WmH6c0h+KLOfObRjtE=;
 b=UliWCYJRUMR9BRXf11AHaTihcV0fXRLYJekfYILdXGK2i9znV9wl0YSfAOsS2iF0y3TM1HVvWMiD/TGVNJXRQekc/3V2O19AYvqtJkBSPeldfj3hax3meu1bXgoZW/WnL81uCNDuC9NP9X7PRutXaKQQa8IyA+XjMQi4w4s7ul9EosVFP2TtK/rhg5SCw248xnyfJHPG6q1xLToU302kf2mtCGp4Ne9d6Er8/WqKguYz0mPku6TtX8F6OmRX4WWu5lMoArxNynFgXnG3oxbBIcuoNEcqo5nF+0QfbJK5g9Okdt9wtEDB5S/S8UpzQxebJNtsVPEjWeFmWWAltfYh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWhkJlaLx+gijcnZVU3Eudd72WmH6c0h+KLOfObRjtE=;
 b=E7ubfA8glxQ1k2HiULFm4x+65hyqTjLD5rftMNQ0YbVlPfLaEh+MCqgjEmMZZRs3ZvvKfWcYUJvhQMTCX4s6FE8cxM9cJOAKedwofLHPF1pOP8NMTj9+WgePuj+hREbPv8OoxIwVNispQjdOcxslYKlosqtLgC1qTJ8ikKtopCEiB+URkD1d61NfO3Du50k80pMljJRrr3RgvP9xRWZOuNhnfRCDD/AMaJkF4WB1xUyVux8Byfk33C359oVeAwudjqk7XeSgkb3fTwQyP1co8A+nHjpeneFusXhBoyuM6b1NJHczOnHKd/JkIAwzUnNSF/eUWL2k4La+I2LD0Z+gVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 02:21:14 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 02:21:14 +0000
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
	Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH net-next v3 3/3] selftests: net: add bridge STP mode selection test
Date: Sun, 29 Mar 2026 19:21:07 -0700
Message-ID: <20260330022107.670566-4-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330022107.670566-1-aroulin@nvidia.com>
References: <20260330022107.670566-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::32) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: d9530516-f6a6-4d14-2a93-08de8e030438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	PzssI01CwPE2Etg6xoppH8JOvczb4iti+8lJsLSZQaUbAfVYxJVtxjQXSeF6P/wXpDXXzHj36k+NFUWyhUati3xacFdTl9bFKsq0L6e03JmnQ0gbga1/nTpbS4gAb4NFg28s1/vdR2nAko3D6U3+6iFVAiRa1ODzfp7GtYYazzA3GQC1/dzDmYN4ig+wfnx2Hv5RGFeaqedrvI/jIVmN1tYQ4xn0nDCbdOiDwao4ccHmrh6PDTZ605abBZnp9kKkeO0cb1JFKLA8YzMMysa4QfcTkhBPEVi0/7mYoVQGzc9yKM4jYdmKuaCUbpiZsAD1125qDLhYx+/2TU7/9KGndFFTmpu9XaOBl/BnDqKdRJCNLwlDzpmYth3tlUoQ08c4qQZ2eBOkplti+UPslWbitH6lBrT5O5rLq+nXeCKcxvEd258QcnFpD9+ME3bTsFW1Re8WxZUnMN1ZYBzxJuiSqVw8zBWpgLHLzk8nz1TJrlXP4a3RAtYDYaC2cApsW1XHP+MwpNb49yjUw+BHy4x0gyYFNCLxQ+tYvk3M8FJDS1hYyYsPlnuh/YAW6L5hT+dwK3zvq6gRfaWjp8IEblsH7Vua/2551bv6wbVje54Pwyh4UIJ5sm1mujmtT0Bq285TQeI2oXFwyMHymMsKh2AL398M8vpNU2hsNNyHO4Z3x29xH5xZmZ7CE7PHXaH5LArGuV1I8hl+F4rv8dkOZ555rhlLb5hGEyIjmGfR+5P508k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18092099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IUWpEzoO21Q3cdBlTTXGjGEl8AkeeCKoIuaEVv6a9CMCKsYMnLfJhZCQL+Hs?=
 =?us-ascii?Q?/SGSC4EJ+8iO/dMvBQrOlVGop2yeHJJntVBpSMVsEc7Daq33f5H1H+nGoIsR?=
 =?us-ascii?Q?qq5jQ9JuXlgwPWPJa09vd21lHSy1n5cS81UGV3Vse7BpD/NV2c+dGLxB4npm?=
 =?us-ascii?Q?8RwB2KMThej4DFb2k7FtgRpVc13KbULKLGZf+dBOCIDZkataYnpWP3M5wzQ2?=
 =?us-ascii?Q?5zPT87+LvNjhmOs8TAzCYFG6S/qpvE6Xez21AFi+4cGkWLXINssCnfO3UPtB?=
 =?us-ascii?Q?t4xW7M4wNdQFhRLssHqgEUbUd8X/PAXkVsw+9mKXiqAD8o+jX1qJnTqoDiWA?=
 =?us-ascii?Q?jJfePY4W9yprG4dfoGXuAP5nWhVKUzdKxKHRWTfiwBSZIHmVfxv5pWNkY8Gw?=
 =?us-ascii?Q?e2M8WQXueUvpZRasczqMffph3vjr3BFlPIfUwWaTXH5ttRX5SnXQflk8l62k?=
 =?us-ascii?Q?heSX2Y1IL0/TV4vu+4L9kByWU3I+Ya0XvvQOz5EyhvKxsXxLpgqvUewim/g3?=
 =?us-ascii?Q?cBBsXFnSIx6bOlr8RPhZfXpC0oSGsSUACEP32bNz62xMuXXeDBzUTtCsEgUw?=
 =?us-ascii?Q?oYoOIEndbny6w8AmtekpoW6OiHiEkO86rmNVSWrF3DPBTmO5S5KwEAj4d1j/?=
 =?us-ascii?Q?pHhDNRmvfNZcio3Rtjb7h/a0ih0bTxtAN4P62WrknprGcxxRq8fKyFTyCapl?=
 =?us-ascii?Q?YcUPqmrp683Ioiktu3OWcwiXji5eGeeYkshO9SA8x1X1sNh3ONOvFQbnqevt?=
 =?us-ascii?Q?kMCRWggnVNk7hPyrsPbR3YJMbWZP1Tbq6G5LzEMWYXpCL+zxM9L9Hl1T1ctq?=
 =?us-ascii?Q?I/H1/0lQoyifinpn93drsL3HMyaBvZ9CgJH7HkuE3DAs6CjcjV70oqwNaCle?=
 =?us-ascii?Q?NhjAW/eUIi+zVJAlM6z1Wp25PzMo/fWUnJLeVafZRqWiR2+S7RshaHwxBdjF?=
 =?us-ascii?Q?z9FTI2lSNPPo7Nt8YogLAmCsVdf3bX8v3q+j2owrl7w0850E06GP6DDBOT6M?=
 =?us-ascii?Q?Kr/X3R/6z78JYmtiTopZu/h7XYhMtLHqj3sTogdgMgXYcyZQiPjCSYWZ/lJa?=
 =?us-ascii?Q?cwxhSXAj8lUM5wCFZ6SN2rGtDHczYI0eTPIDh2YoD0yUq3xI9OFzMLdh42RT?=
 =?us-ascii?Q?tcIFBDCZGZOLz2u70hnqmauLO5Ond8V/H4fknJspw48PhGorRNgQy/Ax/8w1?=
 =?us-ascii?Q?kOHUBDNV2p4hu1zb4YtneQt3VTIziArNB6+3hwy2awaH6rP9tELWfaazYYXQ?=
 =?us-ascii?Q?laf+eQWh1LSmlLST1DGtWArU9+9G51HPgKze/Fa0t2/xug/voRsbWtOKDI9j?=
 =?us-ascii?Q?rikAKV/baRDu2N+qq0d6CkHEMPR42IFoRon7k6Dq5CbAtNascVx70Z2UWRXM?=
 =?us-ascii?Q?X0XrediiHQFKBYZkwmT2NFjlQ1H8X3i7ETLdjqknKROc/9o3NZKJcvPOW57r?=
 =?us-ascii?Q?GB1uiFCpE7vKx2Aoor8YrF3o/I4n9NhcveUBP4/N68gog7vLMCM5wkzN4Amx?=
 =?us-ascii?Q?V7Q418RX/y0Y4RHn8BSVKe3r8RWOyVBDFJ1FO2GwR2wWmr3WUdkd73lJgkO1?=
 =?us-ascii?Q?crLgmekgLJGc1vCKAEwonez9khpl30fMj7nLXEVZVSuZzSyL7YELZ6WTbxou?=
 =?us-ascii?Q?7H3+swmOYhwCn9rZG+kvLHWYVxXAJH8LyAFF7Kfq87d/9WN+wIocgwBQSM6u?=
 =?us-ascii?Q?my/muHi/o0Crdzp0hE+GhDRyRVynAdVZZbcrs4skzfKv8fEca166kgE8oXDR?=
 =?us-ascii?Q?0j55+dEXxw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9530516-f6a6-4d14-2a93-08de8e030438
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 02:21:14.1190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laPaWE3MDEn2cZi4p9L1+5nGypAicV+EAulN/KSTLTxySYLVEriWqApEiPK1kOjHASC39CjlxfVbaCpw3EnPlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273047-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,bridge_stp_mode.sh:url,lib.sh:url]
X-Rspamd-Queue-Id: 2CF2B354BFC
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
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---

Notes:
    v2:
      * Fix shellcheck CI: add SC2329 suppression.
      * Add idempotent stp_mode test.

 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/bridge_stp_mode.sh  | 281 ++++++++++++++++++
 2 files changed, 282 insertions(+)
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
index 0000000000000..5737a10f002f0
--- /dev/null
+++ b/tools/testing/selftests/net/bridge_stp_mode.sh
@@ -0,0 +1,281 @@
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
+	log_test "idempotent stp_mode set while STP is active"
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


