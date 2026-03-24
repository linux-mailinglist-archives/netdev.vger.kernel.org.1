Return-Path: <netdev+bounces-271245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOpaMn3ewmkqnAQAu9opvQ
	(envelope-from <netdev+bounces-271245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:57:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C6B31B240
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BECB313BFF1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3996140F8F6;
	Tue, 24 Mar 2026 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W6B4cxOk"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33A40B6F7;
	Tue, 24 Mar 2026 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378202; cv=fail; b=mgQQ1N/jUjsM3aUj24+rPxZJ/orsqHf0IGaR8WCQS260es9B2iu1OZC/qYUBl0OxWtoQifIgdI6ulSaYrJBce7tOpuj6OwLXR1bPsvtV0+c/jjRP6jDC/i+nHwPHez68YSfikBl4yD7qYgAZzRvveeejXN8NOSXEznxFOLzwPmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378202; c=relaxed/simple;
	bh=OgnlQYm4gdjlqOr7p0P+M5s61pzUzsoB0r8T+STIWZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dxKRr6wWn2uhWlgABc8yHdHuERbbGCur6a6zvMpEinThDbPFxIazFDecAefwUOjBqeTPWyJuyS4r7wAKCQ9ufED9m1KVoZSFAl1uWgNg+uCPfjixjmMHnOFiUkZ84+xFk5L6PKA1E+seJO8JlTFDEl2THj4MPNM0UphkYXQx1yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W6B4cxOk; arc=fail smtp.client-ip=52.101.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zq9yBpMqObRvyGOa4DgLJXaGL7fRIx4vEeAp4iFbFn+/G4qPprvpyIDMnGsEp4Xt51uEwNR8n4yy+AV3n1EgHEQoK1IkAT/xGzOUz/lzfbj3ThnsMM7jera+c8t7il6QqvS/4108zJxcg2tXFWjxAIxW+J087LQyqUsEZGmo67wsAD2auNz4nso5ACP4mp2ikS67UVgMjTv389i13vyRuEU3K71DJ1SHe8Ql/nlgP7adcs5hetrjW1jp01cfNq+9sOT/IpNYhXaPZ03aSxtBsRnmAVQIBkhggwoHJJhjxKiZr1XWszLsPJMWmFMFIu3//AfS2hNxkrnSpungtAJg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlbzheQ8aoWxqWaI9ZU0HhhIOVjMRsQG/CeyfMbcFwI=;
 b=YiXqts7qc/1SdC6q8NvKhPMo4Eyj2EF+VMJD3l9Z912EttHxzoQ5gTOuHaotzXh4w+1Zhal7fCupPcMb5yS6o2eSBu6VvMzxz90MIyUzgy8DXfTI0HJlZ55xIcMBfHVJ+gin19Lra0VfLBl7LmlnM8W92/hnWSOfZPLkU6ilVkVn3NpDOIPO4WDeDOVJafVHt134glWTylXyOVgFrVWCPMUTACDYTzcCjACeTuH8ShLcqkl7uk9ac0uPNdjfXU/uBXXNLVIBF5TunAJgrMbZ37ypK+muCBDuA2GLkvqmsnQ2bG9GKIGMJlp0mKWye52e4/0NVpCCEhihgUhgTbsL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlbzheQ8aoWxqWaI9ZU0HhhIOVjMRsQG/CeyfMbcFwI=;
 b=W6B4cxOkK/1UYVgEt7EINsy37eD1cPuEVQ0d45uggwtaO40u5ePT8e0kD0Do9Rkq/x40EW0A8/9Xm3YyTV3ieVNAYm+zkWRATHx22+3eu7sN3+mn8aY7C7lZxTZ2hLNDeqB5VS52jkFaA13ZqxbUdRL+qcuJ8D3mf7OSmroqfTHii8YVXaB0ERda8PRMVVC34dwVwt/qeOSix8dawOD6XEGVlPObk4QYyNOaaPBVIfcvjJdprk20eBwGUbPqqvHl6+lbUqLy3HmiF3rzpb/QHmXKLAWBBUwiWfyBxIyF25Wq6JOZ7sU0DoCUw1wLYzMe1+nNmwL6fxvvCxrOgRF/+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Tue, 24 Mar 2026 18:49:48 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 18:49:48 +0000
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
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH net-next 3/3] selftests: net: add bridge STP mode selection test
Date: Tue, 24 Mar 2026 11:49:42 -0700
Message-ID: <20260324184942.2828691-4-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324184942.2828691-1-aroulin@nvidia.com>
References: <20260324184942.2828691-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:a03:255::24) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c4f628-efdc-4e39-b7ad-08de89d61faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|18002099003|56012099003|18092099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	xSvWrNHigy0daJP3EcnWNyNKU/NwE5h/gWgVmGUb2BQpK5QUZXeVcqqSmwWVfZFuktyfx6KVb3PVp3XCRq+notqJva0pCj8AQzhFrsGt4YBVxgbpFb/8DYxoXQrrAbQKGo7co4s19qo8k5ec6h2LuNUbnYFOcTRTVmBPQVKpqTZkC6QkKugJN6WOys4lOSldShulCGnrMLO3GKr/O2VmGAPR7Ja1vSDFkBIKljATcnhuP+OOYfgdOFY8A6sYusy6eRvEwVdoVqMkQhfFkCKDyV5bfNgHGLHbu5LSPVg6zT1SVVRfmHb6IwZX4s8GX9SUZE4zUMazy+rRJkgLePUjmwkaDca4rfPDlatW/vCuoFUzyNb5jkI/yzC1GDRMrN6pMi01o4xsldqDW8wVXzBKvWJMOynFF1Q+jkk4xRA5NCsubXJkkSSGdYEPI9oZT108essKzb6HYJucPDk8rIn0N0vGczfd9N0IbdWfAxIMzSqnLkX5BLRyy0m4ib9fK+vmH6Oddx/qBkpyMsng2GH0atsPjHXjfY69tcPkCbmYea6a2xccN08ABNOXfil5nmIYqIsSC4ezm/1GsIiGXGpHps64i+IchLnfKgkJl9/X1NKxBCd5eZg7PMbHN2IveHo00CuuoSaL/yZWu8oYT8dTzkNQCi36+rjQkMJyVuezAruXN5ErEVBgPXI8rqK2RQ3WFX3nT4Ff5bV1Ag7ApNq+fcUgMpY4vjA7rcSuaBuqjaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(56012099003)(18092099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0LgLHUpfef4dBehtfXzQbm0gvfMTvAwqvjlpe94R2Q0ZtrwXKK1Pfi7iamfr?=
 =?us-ascii?Q?rzSxEA5YM06CtGwPc+FvQva1xvu7/1yPCDOyBs9obUVZF+gKRUOPR5zJKTxH?=
 =?us-ascii?Q?JqQWIdJQaUQrv8I8dz90wXXaPJPqkSHcP5Qy3O08aA9LVdjOtUQFPN8KAqfU?=
 =?us-ascii?Q?XAgtKSgc1UNGhRRiMNCBeczjcrmwEOVSK3I01i2Skt8k75LQC7LpaYuRq4rt?=
 =?us-ascii?Q?cO2eANpxp5Zlr7J43Xs3b22qDygnKdq9VtPOcZxmJjFsrjzBLP/s3KxX8/hv?=
 =?us-ascii?Q?FkqmawfYjVhEHJZvpaWp90mOtCseYno5ch67byCbuGsbol3GWFSV+9fOSvZ6?=
 =?us-ascii?Q?TV5085nPbn4BDJPLMMj9TSEDTwT8S71090NWJnfZXCSf3G5zk6spyshLgqir?=
 =?us-ascii?Q?Jg9+A+vXPldCmVCPBtpZ6gRd+d/9JVhOqTkIRlf2aru30CQyy3Qv4NsDjQiF?=
 =?us-ascii?Q?xnURDx0URQqDZL+7QNWgreFci1fvv/KyoQyy6kXcYhdzbxIHJr2UQaG1jdkn?=
 =?us-ascii?Q?cnsRguhZ/sYIlrVaw+DgMYSYb7/aAOmYT3TPKIo0zwv3F0e0VGc9mjVzZXBq?=
 =?us-ascii?Q?ZSiPF4SOQHFPmWO480fbiyNZlGs/9SenCHSc6sGVPGJrXTWMe6gKibPRdAYe?=
 =?us-ascii?Q?zeTe+mX9NMc8uGnDKtTzSrx448EFoJP9WnKiBLWhQzfjIuqbQcMWexHzoZLl?=
 =?us-ascii?Q?oBew5OQg+z052SMHI3tSrUOGX3qyudzTdaUPLAGZ4pwaXGTgY8IcVUF6caN4?=
 =?us-ascii?Q?FU/KV6A4s4cD6CtMpW4IESgSbPsiUzMjUprLuS73Jr6C+F6LP47sZyk42Udf?=
 =?us-ascii?Q?Wok5eHhTUKwcMl428NULiaNTiluDM3gN08GDVV+RqlbEk07S4wioUH0oZDtr?=
 =?us-ascii?Q?KcAyeVSNTF56PmtFLev3se5VaNE3ajTSMVnqaeriwjtG5BB/iyEAoPZOpwt3?=
 =?us-ascii?Q?H7bYO0vAHT/OsLJvyxFKjuj3PLWcNYmGx9Y5f0cdKvxvOMmpsGoqpanAKgUU?=
 =?us-ascii?Q?ADaI1uIKDm1wLGI64RhDrjmatXfPFvU/gBLRab2fMIWDBFzTi8EKG65xSEtX?=
 =?us-ascii?Q?iAAYNDk+WAoWgfYi2R/TbwKVVQUW7mFo6bYTYubc4ISb/TxkcIR7p44zV9SW?=
 =?us-ascii?Q?bRizQCfU6AS+Wd/H1CzaYkHmRVm6WXWcGqSz65u99TJJuo3+XSeKqWWFBKt6?=
 =?us-ascii?Q?3xvtMJ2xm/YCJmrglPAbIQm0944xdfcA7ylxMo6twfY+2/qactDnHQLklULO?=
 =?us-ascii?Q?JQSSfj9fIpn8xblIv5GR/aFpT+HV2R6NPFmBBZCyinq/oXGh5Kq0MvzgU4xf?=
 =?us-ascii?Q?2Q9oEikHPjHPQ+OiO56pwL0DBHkVCeYiACOcgJpTQCmJdEwpLoPq2gVVk5MW?=
 =?us-ascii?Q?eFHXKh98QVrNRPdLfUHL2tz3nrGe+V/+l5rvjOANJyepgsTajLY58Dzi9BAX?=
 =?us-ascii?Q?msu+Ekcf545meVDoN1Yq3VmEDXVIh7mNbqqCoULNbFWNifkBcPaGbWipY44Z?=
 =?us-ascii?Q?a3fXl7ziCZPPCtKAWRKRyIDShUae+4dHT5H4e+0TVVo3ZFahtkB1f99/7zdN?=
 =?us-ascii?Q?XNpLgO2gTHqbVuQb7OGtdY2kOQBNxAfvY5gWdhYKTHlEYMmwpAMX95kt5z4A?=
 =?us-ascii?Q?yfPSCiw794EeMRaYS7EiqJJ09MzswNSZOFdlNWegg/Nm2EzxD2QpFu7jPWuQ?=
 =?us-ascii?Q?UOV5uKOo2enCWVVo4kAkVpr293o3dsPUy2+g/SV3+/C3ochGvCSZKKiVokHL?=
 =?us-ascii?Q?vWTtopKXow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c4f628-efdc-4e39-b7ad-08de89d61faa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 18:49:48.2301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QGDL/9CsgFw7e8Q7ss+iutvqB7Hp7bWm/Whn9DgRNjeO9d2nn1++yXKVT9beCQxNblbTUAzdHEJnkCN7exV+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526
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
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271245-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bridge_stp_mode.sh:url,lib.sh:url]
X-Rspamd-Queue-Id: 23C6B31B240
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest for the IFLA_BR_STP_MODE bridge attribute that verifies:

1. stp_mode defaults to auto on new bridges
2. stp_mode can be toggled between user, kernel, and auto
3. Changing stp_mode while STP is active is rejected with -EBUSY
4. stp_mode user in a network namespace yields userspace STP (stp_state=2)
5. stp_mode kernel forces kernel STP (stp_state=1)
6. stp_mode auto in a netns preserves traditional fallback to kernel STP
7. stp_mode and stp_state can be set atomically in a single message
8. stp_mode persists across STP disable/enable cycles

Test 4 is the key use case: it demonstrates that userspace STP can now
be enabled in non-init network namespaces by setting stp_mode to user
before enabling STP.

Test 7 verifies the atomic usage pattern where both attributes are set
in a single netlink message, which is supported because br_changelink()
processes IFLA_BR_STP_MODE before IFLA_BR_STP_STATE.

The test gracefully skips if the installed iproute2 does not support
the stp_mode attribute.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/bridge_stp_mode.sh  | 261 ++++++++++++++++++
 2 files changed, 262 insertions(+)
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
index 0000000000000..9c99d5b6fd667
--- /dev/null
+++ b/tools/testing/selftests/net/bridge_stp_mode.sh
@@ -0,0 +1,261 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2034,SC2154,SC2317
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


