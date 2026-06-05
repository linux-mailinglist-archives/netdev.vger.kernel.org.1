Return-Path: <netdev+bounces-295610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aq+qGeVEImosUgEAu9opvQ
	(envelope-from <netdev+bounces-295610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:39:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93498644EB6
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:39:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295610-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295610-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BB553026174
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 03:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B6937756F;
	Fri,  5 Jun 2026 03:36:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2108.outbound.protection.partner.outlook.cn [139.219.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E831E82E;
	Fri,  5 Jun 2026 03:36:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780630594; cv=fail; b=odRKwRwb0U6RmZKv48fEf/ZYGACcqONnOu89JYu4T543tVn79IuaPsVHD1lMT/FoXLeiniZAIye6sclmwWMo5lLsoPcfm7wh61WUTAOAhDfBfJI8335siriwbMW1lbTw4x7YhHPSBY/ANJlAyX6gQ8FWdGMPdZqmc4WNQ6xbge0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780630594; c=relaxed/simple;
	bh=NtSfXT+RwYfyA5GnfTye0dRRy1oHiovh17gtLEq+hAI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NEIe4tUAQrcL/eCe+CQJ1VFer1BJk446jOLvwN6P3o/qKI7aCIFRsD4rwTC7hjQQdI9qTkT94s9mv9J4Mmd1peihO20bTP/3nt1Q5ooaqklUPf5EWozcyB4eRrl/Q9X0h8uT7+9v8IYL/SQ/611wPTpGl9v1pHWOneR0eEFV6Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.108
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkAXypVWDYaCkHXxu2x+PmXTFSGsQo3el2Bz9ZBR6kdEaQ6AiBMQganyRofH3TLdKtmbi96j4IbhuHxT/dvYmKODQgZ4G2dOTMWDJWAODpLYt8nlLJJRdRYFlZlEfrM+nHTLAuxE8n9CCjwr1JFrjKaeKqAyiek7LCcmDGVCG5vyLX/VQFNxfD6m3KlukTeu+i63ufdJiHjr+5Lu7lDE4Wal4vyYnC+mV7yqRN9O7YumAgqy5m/5mJCWi3sqqVZMdoN6BVbwOu2B0CxMjSk8T9QtUlv4bIjiae4DAbvUvMarD2YDRfzGsseE0UQ8K7PnqrcE3WUDxWOeoZK1DwrhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJSAgXjGMYdpvPX6QMxN4tU5TZNkKJDlJnu8N3ABfaw=;
 b=JZO3HTR9KL/b4ZETPrwBiKXhddVbGTV4iK5ybLvy3vcQyWcn4RPllZhCZVVFPqlOXCmXCLgvWhUEBDZ2p8VOY75/jvQIR3drhKBKa8t05xVWD9zg5fw3kHwQRFUA/UzYrbZjoWw8Wu4KSv90ETFKvcCoAGxYBbJaNB735H13ZuQtPuOOQKNoVDHfreC8pTm83gB2aoUroCZPwPUqB46UBi7rNgeILN/Dpgt2fp6B7Br/x2R6b6DAoVnEfB7YzHzxlJnVJwa2tOosTcvIH0hMmfGrawtY/XeMjjYtHIBr65in/nneHRKmr7YncmVfuc6eqjdyyLAWzZ7su2ZptPWYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0640.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 03:36:19 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Fri, 5 Jun 2026 03:36:19 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1] net: ncsi: Set ncsi_stop_dev() to inline while NET_NCSI not enabled
Date: Fri,  5 Jun 2026 11:36:07 +0800
Message-Id: <20260605033607.37630-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0640:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bf5bc8-a50c-4710-b33d-08dec2b39b62
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	AbNk406OcuPgX5i5w2CBE+48ZG1RdGgdxWJvkA4rSkyPbLQW70jtexi7mMV8GVe/JW1f/hztl5bT/6aZKGvG3T1ucRykMU1Rx6kls2yoqpxv6PkRtSvsYWbxoARF9ZO4Dcu/55ZkoY0FWMpteMcR6Xq81fm1g2UfpoEAZnnH5l7bFfgrO58cvoB5cdHbYYOcb0ZJWHS3MDGpt8wVpY0bFidnla6lNbKD73JB//gx8ltJgJt6gITQ+7WDdabElE1Hzf/9B4ozCm5cGoAvdkk18j2b8kriOlTrZWfBfK8jJyEMVnVpQTxCKDlIEo2KmWp1JUbnYqql/dvVpLHNmlCBmwj788JmBswQrUEEDqAR2RCFyBSLztjsgep3vbOKmynqQCsP7IuINK2vGMLMjTLlEr+h+ZaTczHjAwEL1GguwNLfkNKCUDuRAb9zupdsrZxkorEsVQ08/eK+M1gFFL99uC9DKoLR+mhAjRLNxs4VDSO0uSt5X4CF2WuEmzatXIjUlw3vv9G9rR1WN4OOrZiydOPF0BAbvULJW1Pe4UM936KenNUsj96cFnOGF3p+Q1/h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DzWUNsugOaoORUmXK5n3Jd/wGRryLa5AO2ZQ0ekb/ZdH/MdI9hNY+Jnj3rtQ?=
 =?us-ascii?Q?f3SSnwJYrRoXAdYdPf7/TP297agWFufx2c14aFMTotG5u6SOlsvy5wAd1LI8?=
 =?us-ascii?Q?XdClYNECncvYFn0CUqli2vrfoCxEqzxkbGtspL5YOx17akvohdA6XVLB1qHL?=
 =?us-ascii?Q?/X7z3XJ67k0CKH2WTPjveXwcjUAw2NFqv2nCPz0+rGvXjob88WdfA45DFw3w?=
 =?us-ascii?Q?Hz3P+SuFUPXkQlBhydRbGJv3IkIXHUIHMddqwGNgb7bQzfqTdmgXhsmNLF99?=
 =?us-ascii?Q?yPIjin07ky2LtxgcNXs1rJqbQ+j9v6Wajjl1hslGH/YQz8wwwhF4KpRlxEgU?=
 =?us-ascii?Q?37HlFL1FLctcr1hTi5Eiqhhm/BDPVPOu9zMFDxzZK4ioJMddiDATXh9dv5PG?=
 =?us-ascii?Q?pAwpCGLHRIT4VMCahPLnXnBLpv281z1VFD+PMG90es74u5vPjVo6ECuCi69M?=
 =?us-ascii?Q?qSXOgjt6Cg0Xo02RsqAuSKW5kB6jED48jIMPX9LwPrvsM9sniy5B3f662BUc?=
 =?us-ascii?Q?8UB++4ntxAy4aTfewyN05R291S2YpJ3DQ7wHMj0Czq3qHQEpvR6Ek4aYwHaX?=
 =?us-ascii?Q?BPjjTK4Bq84v5zbLQ5zOV+9aNDyHwG0rnJdNb9Ld2+rr2IwBNAcRpVMcSM2J?=
 =?us-ascii?Q?YlIZJ+9G1ywjFpXnCJ8IMvT7J/D6LZnlIoOsLOnfCNu31qljeEx3wEUxQTEH?=
 =?us-ascii?Q?gMobP1FU5ccTlpvqsI0g8PIyy3fBjV9t4AI2osrkj5YO6+oKEjsP/bwO0U9c?=
 =?us-ascii?Q?8Y4LfiIyA6grDCvlbSGYjBVjpb+mfkTRJ0pF4KsRsoaPDbywb1kslIefMr91?=
 =?us-ascii?Q?QavM9vGLfooLB+z+4TN+ODPcisg1bt4U4vAUqzu3E1noV3aS6du0EXiImP3f?=
 =?us-ascii?Q?pxw8XNqueyyNjJsxC4VnwQDjTjc3KJLKtnyingWLEPSqD+b5rAYJBJLJIXyP?=
 =?us-ascii?Q?GqnB2zRa2zH94te6sp16CkJRBqmwHJDVpmZ+wcI0m82xnz9bWfoDdwHpYiX0?=
 =?us-ascii?Q?YN2BsHkApoNqr/wKN222yRFIFK4Uuq1HI3Vseag0H/qZca97/pWDtLRriAL1?=
 =?us-ascii?Q?wWBl6RCwY7UevaW6wF2a2NkL7kJQZn/QJkiLf9RjiD4yDzeWQtvVWl14ZuH5?=
 =?us-ascii?Q?aoTjGMpiD3aVU4ZFDQwMDBTDDqbqFHiGObzavsJQwPQugzoy8BgFXpvqfpRH?=
 =?us-ascii?Q?8MM6TXVw45EYj1W2adlHczcUq8pCLt0rzPJEUoqgTJlOPPg+r37hAQZK0BZE?=
 =?us-ascii?Q?RhHSWYDTT6HIPDy/xJlpJYfwLspgLHVYXtFhtdyj9dkz+s/wYRsboLkePh4U?=
 =?us-ascii?Q?jgLtOtNzY3BHAWCtRtlfTE1Niq+dp7FBN5gOCuAFAXUjTtxNCiDoHZO6upkQ?=
 =?us-ascii?Q?2VTxM1RZsz8nC2QIJoRycUoqATu8MT3aCzYRY4279ahMjgmI/1K8pAM2/cF6?=
 =?us-ascii?Q?Z8vFanBRPoOVpIqzViOHOAjWGGwV/RUJCsTCkRlz6Bv+OJyPl0THZsANZ4rK?=
 =?us-ascii?Q?Mblq4nAVLo7y5OykDpaMnSbOdvbg2l1uv972s53PYNy2LxPdEXsZho7iPLh/?=
 =?us-ascii?Q?fM4XUDftp7rCKQpKXlo7iQQTCWokznIZaBxt+Mz/GCCc6fpCsrXvADm6iIso?=
 =?us-ascii?Q?4+BsCvtGIpIp3/yPQJc2gTKqoSTwe+MUzYAuN/unVzpDXmCI2nXu/vQpyBqA?=
 =?us-ascii?Q?eWXcTCtCio5e+AJ8JGSZJKJrgHWLunCIAo0s4MK0+55gi0WeMCKo9nnqb6Cd?=
 =?us-ascii?Q?oceZKngk3VN3TBDm94Z5j6vcqSu8QGA=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bf5bc8-a50c-4710-b33d-08dec2b39b62
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:36:19.6381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YyLui4EmH39avEr94QrV75FJ/3zRyxZsLorBciW65mKNOgd7wq/bZCBnFbBijUA9R4TDKXt6bUOOhIvSZ+R4MZ9pb/aaj6SlPJz+LjsL/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0640
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295610-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:minda.chen@starfivetech.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93498644EB6

While NET_NCSI not enabled, ncsi_stop_dev() is not inline
and call with it, casue compile waring:

linux/include/net/ncsi.h:63:13: warning: 'ncsi_stop_dev'
defined but not used [-Wunused-function]
   static void ncsi_stop_dev(struct ncsi_dev *nd)

Setting ncsi_stop_dev() to inline like other function to
remove compile warnings.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 include/net/ncsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ncsi.h b/include/net/ncsi.h
index 08a50d9acb0a..e886358207aa 100644
--- a/include/net/ncsi.h
+++ b/include/net/ncsi.h
@@ -60,7 +60,7 @@ static inline int ncsi_start_dev(struct ncsi_dev *nd)
 	return -ENOTTY;
 }
 
-static void ncsi_stop_dev(struct ncsi_dev *nd)
+static inline void ncsi_stop_dev(struct ncsi_dev *nd)
 {
 }
 
-- 
2.17.1


