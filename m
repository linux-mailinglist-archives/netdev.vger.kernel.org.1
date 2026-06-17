Return-Path: <netdev+bounces-300127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ceqKNFqAMmrn0wUAu9opvQ
	(envelope-from <netdev+bounces-300127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:09:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46096698D5C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:09:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=MYP7wBAi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300127-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300127-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50D7A31DB121
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BA23F58FB;
	Wed, 17 Jun 2026 10:44:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82A3DB64A
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:44:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693071; cv=fail; b=RRSJ3CMFFPrG9LWeJrbiU5m1tcGzBxgXKv4h3x/O0yEYFBBOZrU/OKyPnBd3GajHJ6++dhXp3bqRMhrTzkQbru4Y0y5TGaeSjdOS9bRM09uQaaW96t7fWrr+b46ZOE1rXJZhZWkbBk9xS91hDagJD0uqIl0ZXTr+zsCIe/wHeW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693071; c=relaxed/simple;
	bh=dskcT1V9TLMY4ZxojLZ6y+ubQj7qiJuoJn8UyLZBdgo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hr+0s1MUdVwuQR60dJD0vKmXBYM1wQNxEVft+URxMa9LfjMGEYBEvyoRQ8of1hjzD1ivqsUnGYZxEy8eeh5mtoATwmnXLu/nJwQpwyMBkgwLs45hwWwkccS2jTzR+QUpQnilHaY9uhfbfu3m8EPIqAHN+wwWKCHWZEUMIH3bGl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MYP7wBAi; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILlCkJK9glpUFpWa+IGsJ2wssAky0fOVoxpJVQPSUwf8ZonDpp2XqHQA2FjplCaTt2YmZZERvqtuLue3Hm0UVTPNGAk4DjF/0ENU3W3wt5TAvTrIsgHMoSsX3bw5ZR2TDE2m3KJXbFyXd3VxgVeg/RXDcn7SFohr+Uc/FG8WVcH94i2XQSgSaePBbnSS8Zoz8dXQzQKEK9fBcgSYJkU0jGtqiecLRrm/FE8nIM67uJB2IMXziAcHakU+N27kK5blaNmW7eSer1SysnKLHhWk7hzAhLyCTX+HNsukzTtvw6nwIS9yZz0eO+Rp73gzn3OEzOAtcMbZqMS9ElM6u5P3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfFpsvP6XiXSiU8WkQLNX4Y/iSvDjU0rriBnX2+Mgfs=;
 b=trTFuqXyE9aMgwjGP7vXUxVx3+ESQbh39PEBchgbsKn7j6UHNy7G8e5/Rq9awlFmuuhSOm74MBs6bAhNz5Q8T/1trD7lfuBc0dNALDNCwaX45Ozmw//pAwL2envQwpBHS2b1xcY7TOQ6ZJhSdhwWi/TO1HiSR+tQjOIe+gVwoA99pe4rd8DlSXGRI8+W5wutb16VutCl/f4lsn7i2eGrp3JscdnAkJgbqVfZ1eLGJCT9hNVPSugJZ2+X/lZ1QZI9jCKNHgb7JtQba2tmz+FAsk/Aw5Jr2sxS8tln7dIccGk+OIkpGEKElddW4sK+Jd22SBfbwx6Beaf2isR3+zJHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfFpsvP6XiXSiU8WkQLNX4Y/iSvDjU0rriBnX2+Mgfs=;
 b=MYP7wBAi5wepZ1NjA9L1d2J1sRKP50mGAAPyxKFtyGta254RpsVOMWbim0UuGNIeq1DTr/XuaeJfs4urW7CNT8Wyzn3yr4V/0D9sZRio5DsZe8Q8jqO0aGziGG83W2nVS6e6GN2D8goDEsowpwMsARdUAzXu33kgfI+C4eDzZd/nPZwg7OIEWejXcA67Q7rhJ2FqSOEdAxJ43KJAuR0PbhPbnIpVpBXPTiRBrh8MLd1gRYHW6XlvpbYNRzk3dJVCrx8dPahMB8NJ8r5IH7iOfCTeIJtYZ2c8vNjpr4LDS9CuJvwb1TukDh5TVVuh3cALB78z3ChaH0+1qCAQIfF4lw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DSWPR12MB999175.namprd12.prod.outlook.com (2603:10b6:8:36f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Wed, 17 Jun
 2026 10:44:26 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 10:44:26 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	petrm@nvidia.com,
	horms@kernel.org,
	razor@blackwall.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] selftests: vlan_bridge_binding: Fix flaky operational state check
Date: Wed, 17 Jun 2026 13:43:23 +0300
Message-ID: <20260617104323.1069457-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DSWPR12MB999175:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdac810-b1ec-4c77-ccf7-08decc5d6686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dNt4sQSzcIeMvTovXK3vDQcTS/xmgra9HQMAkyv8NQXxs9hpTKn9fnVTn2+PZ8sFXpW14OjMTE/RAbqpcnq/FW4ILS/bH88MSKUgIWEzRzs/w/DCcOnG+eJbYPbMEEn1hPOv2YmoykeyIezO7RuCcAG8DLM9y0ML3HAvPc4jfeuDPMt44iNcJ/pw9r/Qeo8Yg6ZScjIRTmJhLH1tEF15LSjPPkWJsfUPRkDXdq19jl1tc7MxVCYaF/6PvCldDP9hEXPkrO0AZWnNsl807/F32DO2i4pvrRNydZxhhrCChrv/oexJRe3Z1ARGS8LF3vniPe3hQThE0D0m14Q/IOOkAsq89TfyvKbUstyN+ZxH2Bxhk/A76OYCvKoJ/R9vIt+b2yi4TL0ip0cYfZ6lRXsBb4n0Po0Ttt11SBz5PfKuHjZKyH1KdwKnIGfj/LiyGpTMUFCGPRBZsHpqKGF9mFFHX6fhxpK6fnaxgDApxFWmh+q4PH1GH24plDDSnxtzEasZHGEgE9o/1/T4M9gJ0ePLrMPbYNuHf+XV/cVeqvJfmGFHd0TcibIMip+b3W6mnAE8kQxEX29fDBaQUxzs9leaR1xHXGMUPBdEcRYEpXKwkPykjTuU+BAkaOGkqxoyxbU5GjEwPfMjqnJ5O/QGU34l9gq1J2VnTKW6Z9gEcZpYYWAJzhJY9KAJUssj24fSlTE+2zop8Rt2gem7dPLF6f1SHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E9rdieIrJRNuPRfqLNLE8GL5K1B8mEw5+/otzUd+/bwW8fYXq61ZqfUCN2T+?=
 =?us-ascii?Q?sUmzjOzMq+dlMKtAVrOHIO6ystwW8jVVf0UvIXfqRGbupWtkLGBVfWOMPnjy?=
 =?us-ascii?Q?JO31KToJdUTgLeVvfo8Q5NQcGOaO13dlTe5jjM2a4n8pHmAVmHE5N8eLA5Dw?=
 =?us-ascii?Q?FC8dAil2lKkZP74qKkV7IGegbyibqTcbNCral5rgiyy8I+Jfnz9fasZaxUD8?=
 =?us-ascii?Q?UppARCq8TBkJ/K4lImbyRmKKPaYN7Alo5LEpQE6Cy/RDV0fl7Vt1D1btBw+h?=
 =?us-ascii?Q?E+D/yk2y4MDCfiBdMl3/YsFqNBJQhKBEZeKpKHmnMg1R4xp3FJ4Qf1EelbDs?=
 =?us-ascii?Q?fmTt1X6Hml7C5/E03+emEpiBBNOnHNdxhkaWlW36HVFNstHMNf7wEOdKLc2q?=
 =?us-ascii?Q?9p4PyXRpdW2Wh2/fh8eaJQce3jW2i63gAzmB6dXEJVvMDJgNeerDJ4DzTxiZ?=
 =?us-ascii?Q?NsV8H7ejin1xZBR8EN48mj7WD4FyypezPdhhWhsHIHs4zkesqVjKZy7JpXRf?=
 =?us-ascii?Q?5ffpBNgX4gkIzCiQcCvsyLkmEbWEvH1WCF0EOb/iX8sa/aj5nUU5+uHM3rsp?=
 =?us-ascii?Q?v9/4iNz2I+swwfi7BBuMAEhhkY0C4htqxspFjQMv069zPNBwEfc3JbNJhdRP?=
 =?us-ascii?Q?/fZWI8/H4x1Km1fz0xbxOHrKwn/DvceZr4Uiz0eAHabUVaOKRxQVAkvfjYcr?=
 =?us-ascii?Q?CU5b2IYSb55QQz21pODRcyrgP3x6PtZpn+e4L4/7Gb2RY/1uNU/F1f0Hhlrm?=
 =?us-ascii?Q?+vpX/DbtY+7K85ErVqCnQ+KDTvuBonieRoGTtFLkckjNZx8fY5DaoCvRxVKJ?=
 =?us-ascii?Q?GuHTW461qzZL6S5xdChrgt/P2DRa9nRHY9r+NimzdlNZWwCcPgRqfpOOZzrW?=
 =?us-ascii?Q?Z/7KvfmseENNFQPWaiCj6dzk6xtOr2O6q8mmZUb5Kic0Tpv3mjSkfrXIW8SR?=
 =?us-ascii?Q?Ad5w3ccrLt355YWrzKqlubMlnZmJGf9zHhAlFsCIheRaM1JxmNrkNnt1o2sB?=
 =?us-ascii?Q?ipU4bJpQ2GK7YXHDoTNjcjRLdRUinvoDacNAR0ljyHLsi2kaXZyAx7woF79v?=
 =?us-ascii?Q?H0XxN+b6I9kRLMmb66EYkBhzQFYREuxBTBg5n7iFzbvrWIzL9oleUGmsaV5m?=
 =?us-ascii?Q?qlGRWQn8aAftX7xalt9IKlbobYTiMgwG95h0EhAE3OJSUqeOMQRnTIx4h+Es?=
 =?us-ascii?Q?c1xJGyXM3/S6uvNRMCEk9qGx4G9F1QWH16NLet/Y4+w8+ys6NM8dc30Ky4SZ?=
 =?us-ascii?Q?Zi5Fra92gmzSWk+tMlsQV6zHRnl+QiaAWQiTZ8ZYWN9TPFVI9lrFHb25j2/E?=
 =?us-ascii?Q?3wk2nnmQ/7T+wqdi0FPz4jaL/31WQjQ8lukRAFiR1ab7fT2h67ZujDk1mu8x?=
 =?us-ascii?Q?zvuCqGlrVIdA1FMJJFg0mOJrc0Ss+ZL9eDy6d7OzX/f/Gnmxh+PQH35SnoyN?=
 =?us-ascii?Q?2XCK7bCseGrrG+8HG1rHrv4UfhBTEC6JKiUHyB9iEJUWb02KV4AD3sWcliqa?=
 =?us-ascii?Q?sFjHqCwxVkbZGZ49Kdgsh7uMNVfw3d4deyvEmKQIBuKvDtC33v2J9tICHAtZ?=
 =?us-ascii?Q?h2FXQmoaLy7lHPQpsUdu30kAUEHBvekSY5doO1utM2fB5rW6gIXtnrvxLwTc?=
 =?us-ascii?Q?yRHs4N59OT4c0igPxbNIXjYAeP9F9QuPX4AtjbPPx/PUFHXfYKa/KnM56OvK?=
 =?us-ascii?Q?e53ReWtqsxUgds0+mDJfIzsl28qJ+wFr8FNqoz0daV2PSBT2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdac810-b1ec-4c77-ccf7-08decc5d6686
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:44:26.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttKyYYEEHPbTiaATDy9bcR+1jS8TIww+nTG7v1XZr3OPP6bsKJfONe3Te7iXbm2zsjog7ISl+52GZ/dKFKQkjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300127-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:petrm@nvidia.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46096698D5C

check_operstate() busy waits for up to one second for the operational
state to change to the expected state. This is not enough since carrier
loss events can be delayed by the kernel for up to one second (see
__linkwatch_run_queue()), leading to sporadic failures.

Fix by increasing the busy wait period to two seconds.

Fixes: dca12e9ab760 ("selftests: net: Add a VLAN bridge binding selftest")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20260616092733.3a31be4d@kernel.org/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/vlan_bridge_binding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
index e8c02c64e03a..d04caa14202d 100755
--- a/tools/testing/selftests/net/vlan_bridge_binding.sh
+++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
@@ -64,7 +64,7 @@ check_operstate()
 	local expect=$1; shift
 	local operstate
 
-	operstate=$(busywait 1000 \
+	operstate=$(busywait 2000 \
 			operstate_is "$dev" "$expect")
 	check_err $? "Got operstate of $operstate, expected $expect"
 }
-- 
2.54.0


