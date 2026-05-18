Return-Path: <netdev+bounces-289120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF95EQRBC2p5FAUAu9opvQ
	(envelope-from <netdev+bounces-289120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:40:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A0A5710EB
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AD843023366
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACD9480979;
	Mon, 18 May 2026 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eZuSQ4iU"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D945BD6F
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122219; cv=fail; b=cBvnrmBt9n1jKwOhlNNgJzKgm3jh1n/VoeNKLRbYNubYffS1yK1a/oegV21ThNkfpnHSPMlNzsr5fp4GtvOr9Me5qQPjdgzP6PyOj24oXfAu8OtL02/Zh+NfsP7j3Nxmkaizox3pv431XpB3iY0G18iHOqb8/fZPwDmdUbfcZ5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122219; c=relaxed/simple;
	bh=ltGVZEUUq2VzKEBldSmA+5+AnUwKlZZFrhcLAT5K8No=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=igsWW2FLyP8HU/Gpw7sCnFx3HZwdKzuq9gPzmgQaPbJDn6Se+H9ViE3mha9faZE029fA/8ztoAEZFlJybcxmwZD4LeMnbMRhKg0yjnGW2cony0NSjg6YL7biqxn4v8zrMJNLPEKGEcAXyTeU1WTpYc78QUIEuwXgVXFK5X/1rYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eZuSQ4iU; arc=fail smtp.client-ip=40.107.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjveTPDbFH6/oB3LvbRK7yUHepb4UnYY9KQfGYXW7tF4eKzaiKyx939fssxeQeJMhdg3k62tkfc8koZcWoLAKALC+TgxCCT/Eb8oBhht6TUn33AzwdBW6wGtGXWmJyLL1/De3HPEh5UF7k1z8y5W+guPAvLI5a38ERnYGM+vhx8dg183XyLFjomYZMPpZESscVDCOBuCADekQ7PVe2Y7CIv0gqyqc+yryp0C+8+ky/lAZg+mMGOzUCu/bACEAYL5CdJUBokXwqEBlwyokPmYublvHTAiluJ1rX5n9wc+KyQf7AhGFhcLf7ErmUdoNxv2T2Jj84gbK5kQ/7TuvsW4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQDiMIs/bqWuFJYjGGalRi9muoduOi5pg5euWBqnAgc=;
 b=V/KPAu6qsGOFaiVIt5qQS5WyCcmEa1fFFB0Y8VAkkWolVAYwHSASQwkU8AxuH+1TJQMmr05rp/Ey74bXKOD6n+Kg5w+qeRPZM1gzmMzJpRrAKQUW5V+V80aleEwoKNl3EIQhPK6fL2tHtOBJeH4TJffPmhHe8gMraWlaxLxD7q3Mih8fOp0/TQHrwZPaqGhfAGtMC/OuUeWH+5vcWjOclZQPgbSabyjHwEWLkbI7YZJsHArRWDiIKf9TZutk4XgW7F+RVhCbX1+ofklPSn3DxIdHIPdvEQPYXKrrGb4yjB/fpV5C5QqNLF7DB+ijHJdFWGfbOQa1rD5F+OaGmq+gzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQDiMIs/bqWuFJYjGGalRi9muoduOi5pg5euWBqnAgc=;
 b=eZuSQ4iUTN8FQyaKFZQMXhkTWN96mz8E++CBttrX38v/ChaTYFOEs1ln3AOXuEGQMZd8xhLwYmwBxGsXllvqAu28UmLLo0cmVrHmUI9QrSbnZqVxulySkSuKSjh7j7aWYZrcT6ClT1fTfm50N7iyahwURoEnzbMF+6m5waRRARqPWkeo90vJcPRmqrfOlrIbtoi+SypDTW9UrVUc0ktwNzs3Xd+Y7jahI85o2m2jmJCL0ufNOXDT+9xfvQk9TVfFVgHLD4Xx7qeh38sJvKtxHAf9WzeYZ1z1bKDrLFDzWfFjjXT9q74GEBE0YQt3Y3751oKWJhD15+kM8xMKTDQwRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.18; Mon, 18 May 2026 16:36:49 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 16:36:49 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@kernel.org,
	bridge@lists.linux.dev,
	razor@blackwall.org,
	nikolay@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com,
	danieller@nvidia.com,
	Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH iproute2-next] iplink: bridge: add stp_mode support
Date: Mon, 18 May 2026 09:36:47 -0700
Message-ID: <20260518163647.1935156-1-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:806:d0::34) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 983db44f-ec65-4ba8-80ad-08deb4fba8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18092099006|18002099003|3023799003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	dKV89C2L4xFS9AjT4XG33BkQHSiVQHrFxs/QM3Dk6v/Cnjona2gVBYtXMW0cg9HC8/VVsToll3GPkoet5uNqDOR8x7lMLax9TaC7fX0uKmUY1etniQRzn2E6ESVz7WgzLA2+gqg9dlse11/hMjHnh4rfN4gEXQ8ICScIzIrhWED3SAFZJMrs34ysFQLiqKwJUJZ24DVwGuEPt+2n5RF9D4XfZRtA0y7d5uNlNcFqYvigpFi9U2iwJ/3DFwZ/B1+7LVXUAE9RGX6HVGpgWnPPOYIy4wYjLT+y+YZk8bGjTnszyegqyH2OMfneFgj1obgcaQpqByLHN5a0onqp7zgy4/Zo8+KzZzLNzA+HmAWBZ/ptgJ8W7CUQAp+lBXjHf4eKwxv8F66fpDVHW634yk6O7xWb5bdrsR3k7knpLTok6FlScesXkTgF0H7tkSvEo1EC8XKKOt3jbK8Bbj+iZKtsVEQ+psTHAoHTkiddLUO1NBodVzZu4lthw4DfXWIHEA31E23qpsDGFLQRYR3DJNmRkHU84mVCv6qokz79DVx+J4Jpl8cfk24HgdSWsyNVTttdjYoYUgbcS/AB0+60w+VUA1cLEe31f+2y3a7m7SkFckJT/HkQ1VhVvvmBNSJA6O9/lypnd1AyBAIC7mrjd3Q4BpyMVH3zYPrEKYOUlTw61LDiWOwXA9w7ypOAnxzxou0A5hCRddD4ciTHTTEyIRFzuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18092099006)(18002099003)(3023799003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SukhyQ9H9AFG1AkspWSERWLebDqeoHE+6DDHCzp1Z6NpK2+JvluvbkdMCK09?=
 =?us-ascii?Q?Sl6emwcWDBI4ZdSoMYngcgZm7zSUFNB1vWDVf838LUjRDiPDcJrHyjrh7AL2?=
 =?us-ascii?Q?3D+wmWq2g8utqj8/8JgDUSAo84sN01R1ljpet2Z6WI5PYXQgt3StO/pfTVa7?=
 =?us-ascii?Q?xcnG1Jqw3i2xIZ8q7HLJa2WJPf5tLDObUHkQlG5F0gUtyUZkqVSKnz2hV/7x?=
 =?us-ascii?Q?aw1sFJm81EdpDoHVM9CInKmbo0cOBFFnhHmuFFGZxurQrqRRs46SMD0/AfDc?=
 =?us-ascii?Q?dXwGgd2xDcUNijJwBWe7o6pq9FXaIqFxRwZWJIkIe+cl+RpUaMtFvCmPjpr/?=
 =?us-ascii?Q?T888BvEclfFKK1nKYG5RY+i032IOgAbGjQVgSi9IlHxrlHBY5srG22OZDc6w?=
 =?us-ascii?Q?7Q0IvVlVMWWA0XcKR9PbQdoe1pIMM8ldBUonLpJT5xZIAi4MihEMk5Um3VpS?=
 =?us-ascii?Q?6+Cf82QbDdyLA9bvezrKfpN7cPPwrrhdVFFHJQtH6sjx4ku+6rXNpKp7oG0z?=
 =?us-ascii?Q?cPOfzkwDM73PGkn2PpoTQGVrFoCfBTVM58TgfDlcnFxi9vpx5wBfGFY/w07q?=
 =?us-ascii?Q?s+nHFjhJw5BxIDHqwiS/nqX8vbYedx/45Rs0NMeEqHo+081vPa6/A+D/ID94?=
 =?us-ascii?Q?U2nFxX69t/vDevGUepUL1LaQwR8nCni1QuI70L8QoWgoR3YLmV1RxEoAbO+M?=
 =?us-ascii?Q?5xGTYnXvna3Cp5Ch9cFBWLo7Go+igtCu0YDOuLx8qOE2vXJhBR2Jb4rf8RWZ?=
 =?us-ascii?Q?2vyHd55JMNhkOHafpFbTSMVCRim8WlKoCJhV/SskaiiuJm83LGjuIVv0biR0?=
 =?us-ascii?Q?cL9bghWxyzthMIfzlYKSqitjuJQt9xiYUmV8ZAndsegqsQcT+JbwOkISiygs?=
 =?us-ascii?Q?YgwDQRFUFEphhjdURuE6pe3ms13EgaqQEZfydz6uFZhQNJ49V1UlDAzI/0Gk?=
 =?us-ascii?Q?Z6dlGW0oOWxdXW3xt1J0G9wB5UfriyOwfonPqVz4cNbI0HXdrFkrRt1I5+J5?=
 =?us-ascii?Q?ur3n9eeFoZRNf2z13oEUNpVcz8gsRr3nkMfIZZAKK8Vx1cdPpeYg62Hs1lQj?=
 =?us-ascii?Q?ZU9+GFsdPk45vJXKi1vueyShzW2VKv7Jr4xbfWlCg7Fjcnq1WsoTP/ZuPo2n?=
 =?us-ascii?Q?mOKmryIUJmpJxNWsGpdH31isNc06p4mO1CvH6mlpsAZKpr0uQed+ryFpKEzP?=
 =?us-ascii?Q?Jz/K0nAtQ9DHCxYk1weiDEYQyQMIyCnB5YHxhK9yHSeVsnS3hURjTYk0+UYO?=
 =?us-ascii?Q?rLMSm3YQwWUKGDkX6uu8UckVy85EepwlmaVGG87pryr+dd2320Q8MHKrjtBr?=
 =?us-ascii?Q?qOCNJczMwPMCqzenGpky+v0/Lohwi3ZFA2tcpBMDtDaoeBuYhekSZOBHgLwv?=
 =?us-ascii?Q?kD8A3Q+vLlrgLslTTm+tGEUMDN1+8avao4xVF5bBywgn7yfdWKPV/2gGFvRA?=
 =?us-ascii?Q?oe9FM/EsYahnOJoA/0uLBq2zBSVyuJTxQD+jFlJA/ia5ZdX2qd4cDMBizFa5?=
 =?us-ascii?Q?TzRtgHGmphsZDq2PnHtsq7JkRz712//xgzkqgKLDVIZ4n9GwlhZAUQSn2sOv?=
 =?us-ascii?Q?86+HYQkUWM3MYYrunFWX8tFU0Pt0KDsvIK7ltgUhTmpxbaSFlA1+V1qRT605?=
 =?us-ascii?Q?XGe7c7AxwcZXNw9/MGD5S61eGQTXjdTxpMBAKAaMoslAwBVRTSKPVMey7CIm?=
 =?us-ascii?Q?gcxDV8hB8b92nYNo3nL5d1+89tJRkD/YK8HoNxzvFUJIQK3qLNIEMbmK660H?=
 =?us-ascii?Q?43bEBPerEA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983db44f-ec65-4ba8-80ad-08deb4fba8b0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:36:49.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buGTg/yjvG0xz6TuYY3J5VoB6TvfZCBYYDjRNm4k6W3e1lw56wqMEkerSI93DYPggtsEoA6rR+AUSEpfYj6chA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289120-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: A1A0A5710EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the IFLA_BR_STP_MODE bridge attribute that allows
userspace to explicitly select the STP mode:

  - auto (0): default, try /sbin/bridge-stp helper in init_net
  - user (1): directly enable userspace STP without the helper,
    works in any network namespace
  - kernel (2): directly enable kernel STP without the helper

Both string ("auto", "user", "kernel") and numeric values are accepted
when setting the attribute. Display uses string names for known values
with numeric fallback for future extensions.

Example usage:
  ip link set br0 type bridge stp_mode user
  ip link set br0 type bridge stp_state 1

Link: https://lore.kernel.org/netdev/20260405205224.3163000-1-aroulin@nvidia.com/
Assisted-by: Claude:claude-opus-4-7
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---
 ip/iplink_bridge.c    | 30 ++++++++++++++++++++++++++++++
 man/man8/ip-link.8.in | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index df3264c3..d15221b2 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -31,6 +31,7 @@ static void print_explain(FILE *f)
 		"		  [ max_age MAX_AGE ]\n"
 		"		  [ ageing_time AGEING_TIME ]\n"
 		"		  [ stp_state STP_STATE ]\n"
+		"		  [ stp_mode STP_MODE ]\n"
 		"		  [ mst_enabled MST_ENABLED ]\n"
 		"		  [ priority PRIORITY ]\n"
 		"		  [ group_fwd_mask MASK ]\n"
@@ -67,6 +68,7 @@ static void print_explain(FILE *f)
 		"		  [ mdb_offload_fail_notification MDB_OFFLOAD_FAIL_NOTIFICATION ]\n"
 		"\n"
 		"Where: VLAN_PROTOCOL := { 802.1Q | 802.1ad }\n"
+		"       STP_MODE := { auto | user | kernel }\n"
 	);
 }
 
@@ -120,6 +122,20 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("invalid stp_state", *argv);
 
 			addattr32(n, 1024, IFLA_BR_STP_STATE, val);
+		} else if (strcmp(*argv, "stp_mode") == 0) {
+			__u32 stp_mode;
+
+			NEXT_ARG();
+			if (strcmp(*argv, "auto") == 0)
+				stp_mode = BR_STP_MODE_AUTO;
+			else if (strcmp(*argv, "user") == 0)
+				stp_mode = BR_STP_MODE_USER;
+			else if (strcmp(*argv, "kernel") == 0)
+				stp_mode = BR_STP_MODE_KERNEL;
+			else if (get_u32(&stp_mode, *argv, 0))
+				invarg("invalid stp_mode", *argv);
+
+			addattr32(n, 1024, IFLA_BR_STP_MODE, stp_mode);
 		} else if (matches(*argv, "priority") == 0) {
 			__u16 prio;
 
@@ -512,6 +528,20 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "stp_state %u ",
 			   rta_getattr_u32(tb[IFLA_BR_STP_STATE]));
 
+	if (tb[IFLA_BR_STP_MODE]) {
+		static const char *stp_modes[] = {
+			"auto", "user", "kernel"
+		};
+		__u32 mode = rta_getattr_u32(tb[IFLA_BR_STP_MODE]);
+
+		if (mode < ARRAY_SIZE(stp_modes))
+			print_string(PRINT_ANY, "stp_mode",
+				     "stp_mode %s ", stp_modes[mode]);
+		else
+			print_uint(PRINT_ANY, "stp_mode",
+				   "stp_mode %u ", mode);
+	}
+
 	if (tb[IFLA_BR_PRIORITY])
 		print_uint(PRINT_ANY,
 			   "priority",
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index ef45fe08..802dd739 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1719,6 +1719,8 @@ the following additional arguments are supported:
 ] [
 .BI stp_state " STP_STATE "
 ] [
+.BI stp_mode " STP_MODE "
+] [
 .BI mst_enabled " MST_ENABLED "
 ] [
 .BI priority " PRIORITY "
@@ -1828,6 +1830,36 @@ or off
 .RI ( STP_STATE " == 0). "
 for this bridge.
 
+.BI stp_mode " STP_MODE "
+- set the STP mode for this bridge. This controls how the bridge
+selects between userspace and kernel STP when STP is enabled via
+.BR stp_state .
+.I STP_MODE
+can be one of:
+.in +8
+.sp
+.B auto
+(default) - invoke the
+.B /sbin/bridge-stp
+helper to hand the bridge to a userspace STP daemon. Only attempted in
+the initial network namespace; in other namespaces this falls back to
+kernel STP.
+
+.B user
+- directly enable userspace STP without invoking the helper. Works in
+any network namespace. The caller is responsible for registering the
+bridge with the userspace STP daemon.
+
+.B kernel
+- directly enable kernel STP without invoking the helper.
+.in -8
+
+Can only be changed while STP is disabled. Both
+.B stp_mode
+and
+.B stp_state
+can be set in a single command.
+
 .BI mst_enabled " MST_ENABLED "
 - turn multiple spanning tree (MST) support on
 .RI ( MST_ENABLED " > 0) "
-- 
2.43.0


