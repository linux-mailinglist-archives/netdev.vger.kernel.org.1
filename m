Return-Path: <netdev+bounces-252007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DCAKcwacWmodQAAu9opvQ
	(envelope-from <netdev+bounces-252007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:28:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 480015B424
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71CD99CFEEC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A1531A062;
	Wed, 21 Jan 2026 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jwGC05EI"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013050.outbound.protection.outlook.com [40.107.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470443101D2
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013922; cv=fail; b=cuZ76D4XP/x1zp9505rpwHHS2hl2RLYg5EMLjazSJIlWYvCbgHOF/ZcGMGpACfQdrQ70TetDY5P6AWDzC+Cy+AdC5fCdFKPBaf76IDtvZNixI7ovG4lP2faHUetZ5qrpZ0AuhVa3YvavaQn8/zA0enmrQjQz/lsGkswWi9oevAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013922; c=relaxed/simple;
	bh=V16c1FIL8Lp06WDiAFQM0g8w158VzWW/aXrcVFMmND0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbtK2J+tBpnUIB6CBnpGhSeTEpU/+QC3JacVRQufii+JoGfsFeDU7/4UGOrofKbmziYB7GAxOogZW4fhNb3NrH6lydTOSgx66FxgdSdp0fUDmhduHqAlQlLjOTDY2ml8aidzBT5TlpTUqfjIBC2woZYr0+PZsLsRcoGpPMDQjGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jwGC05EI; arc=fail smtp.client-ip=40.107.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nipGktzMd1l/ERyZ7+gwL/OzyAL8D8olShIp5KNASHCI30+h3yjxDFUqFnEfDjoBpkg7elrr5N5bSbaephbYGmwODWzz1gP8cMiL6avmTIQVqu0u5zn3CpsXtwRurWQ4A6y2p4TUXIvglftfT3NGLkfNQtvVoYxD+hcjLJkNZoNv5Dr7PARPWExcN60lvsP6bcKIVpPKhdAE7Uc1H0BYvGlWDvDoMEx1bpV9BkTpUZwDhtK8EKdBp3MorTEq8rnR3z9JVxSWZsSUgeJX7F10aOit0yWBPJBKCfW+DnhnlteL9o7WUjVly8zGH/yJK1g0el0c/z+zhViTBP4JxokqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+NF09rsWtWDB2OE0BdVfCQ//bvYrIw63SdFEH4Qiqs=;
 b=Scg0PbQfki+55kLXz1Bj0GVlw3fyvA1xoKgNvZ/v6qUt2dm/VFhWpSVqRCst2zpjplSV3pC9t7bzcmPW3EITp14nBG5eOnpAkqw76gaWLQihYcw4lDWxSOw1Dy8HLe2YHJhd1ZK4IyuqBibdN0rzX4bxSGtItglx4JsEIp5OezvqQwEsIP4W8wQtvlhwOQu0qAJ2bUgrXk3VWgjGoxuuMgJBdZ61Cun+xN+jETzcXJjM8CxUjPklaD1INYPMPIMtHD734Z3mr8vYGswiplajuYJRk3ENxaEHNWsQo5DjR0Vz6ksKm1cTlLTV23VtxwKH7zE0O/D//2evDUZIS+c5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+NF09rsWtWDB2OE0BdVfCQ//bvYrIw63SdFEH4Qiqs=;
 b=jwGC05EIMLGFTfwWmZIHBNEXewJxgmlhs/NGDxmwEkVk/DDXiwzc9NSzGM0nR4F4VuKWiLMdO7hg9GNRidHI4EwmeRWvAobyWhqBG8vh3GeyRN31qs8eC3KudBZ8r1je5gi3yvG7FNp6Db2xKoVft1Sm8JgusiGSvruv5Is+QDDJoPgMaNXo455t67iJRYfkbsbq3ZQwJddKkcpAZAcQTQ6gspqhrSpXdlGs4+BsvBAk1hNPCSH2fUnAsmwZBlZFZ8gGA+XN5rfJCUTNVqsTmdL4VUOrZPDD1oW15Wtxrj5kB63QSqz3Rf7n5otDB9i2kLJfkrwAmqs5fuboW05R4g==
Received: from SJ0PR05CA0116.namprd05.prod.outlook.com (2603:10b6:a03:334::31)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Wed, 21 Jan
 2026 16:45:14 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::c7) by SJ0PR05CA0116.outlook.office365.com
 (2603:10b6:a03:334::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.2 via Frontend Transport; Wed,
 21 Jan 2026 16:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 16:45:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 08:44:50 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 08:44:44 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>,
	"Francesco Ruggeri" <fruggeri@arista.com>, Stephen Hemminger
	<stephen@networkplumber.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 8/8] net: core: neighbour: Make another netlink notification atomically
Date: Wed, 21 Jan 2026 17:43:42 +0100
Message-ID: <e440118511cbdbe1d88eb0d71c9047116feb96e0.1769012464.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769012464.git.petrm@nvidia.com>
References: <cover.1769012464.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: f7afa1fc-ac20-4a76-d7b6-08de590c7338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QqRceQ4lBXYS/JTuPJ1PrNyaDo0u1GtBFuB3ZI+sVvlmxv6/B3e5df2qgxXD?=
 =?us-ascii?Q?bDCtbrgtxltMNcQldAoWdd6QA0Wx3qYy6lle1IN7D/SggXw882QP7EqNWgU6?=
 =?us-ascii?Q?V1JZGI0aT2acWKa7U/WDK1YDErQ0jF17z6KTfmZBSSssl5k8QkwE6rUvUbsb?=
 =?us-ascii?Q?DHvBoUE6AsF+MPT8+Peag1AO69rdO+vbA9GaaPzvhRfbOmPpcvd8b5kK6F0K?=
 =?us-ascii?Q?cXm/yBykg02PrAmn4sOaKhaF23tIKUcU7lVQVK/BNIZL5XIwCPQeOgjV2JJm?=
 =?us-ascii?Q?4wl798UkyiEm2Pnx0iNDW1MsSBrIYxPNmbMVo/Gc5BI1NdqK9tN1dOJRAh7s?=
 =?us-ascii?Q?jhbmRklykeoBMTTky8PYAl5hGnDDdtEtExESuvvQF7CZFYm+Vpi3sB9aTL5z?=
 =?us-ascii?Q?dRUyTFrjI2PnnL3eUvm+oOl1N8YaqXYFmndM7QZXHBECXcmFbaGPedTTeP05?=
 =?us-ascii?Q?ccvedm8Jgcf/7zR2sVKPJRWTRF/YvxibqwOBUiOTtKiIG8emTkptNByd824v?=
 =?us-ascii?Q?/RfexyW9NoiApYO3L6XthUEeulNHgoJNaJ9FCCC6VukemnMB6+93P0R39Kbe?=
 =?us-ascii?Q?yqu8eHmYh0ZOYlHadfUEQWk9zIFvrq3mmxe+QvsmQZDOS/a5LdMjRBFcmTcf?=
 =?us-ascii?Q?N0L3ZlCk8aL7BFDWUp3sijblmlMhdVhy+5KbkRkTCutAV9aYCsFpFkYXHpsX?=
 =?us-ascii?Q?LLv2Q0UeDee9Dt85Ko9tvzKq/bjDCa2hCarttjwn+KWuoLG2/Q7WdVkyxoM7?=
 =?us-ascii?Q?INBtQhXuwyUpcp+cALgzrig4uSoVazQ3OkTdtpIjSmuLReVFAhnvkMPUfj4Q?=
 =?us-ascii?Q?KbBI4Um1SsM7zr3CaoZVsB3vxtMlxV4bG1YBCfru/4yP7uXGVVF6N3NVNWOg?=
 =?us-ascii?Q?LZuwdhcd9Fe762xZzGkts9ji9/tulhZw3OOPjP+UO8PJGq4dFPyZKvSLrXei?=
 =?us-ascii?Q?cBdsAUMyCqxfV6e7NjKJNOuhrSGdSXiEMxLa93m1gG3OK5wYGdQPU9tc2h1t?=
 =?us-ascii?Q?YbdZvbPWytvDz0wXmnJ7IAuJPZgMtWdS86U0fI7ooIiFrOIFtqXWWE9vCP8M?=
 =?us-ascii?Q?eUmeNzpoycOyBAAUjisnjfuqTztoItwY+f5eax/yzzi7Qx2fkiQLKOcdveqj?=
 =?us-ascii?Q?9+mNKVxRS1elc2Uhn9P/dhdgZQElAKkJtVsGUrLlhbV5zms8BycvOvowMb2k?=
 =?us-ascii?Q?DwvBtIfWu6V9Mb92E3YZLdCwMJEbmxj1yhGVcnkz+tGis7TM0syNJUFBTB0N?=
 =?us-ascii?Q?8Kl2v6XIK28edCTIhn1U4EPZ3Guq1mcGWYlUePloWSjIvIFaL0Wdl2+U0Jqs?=
 =?us-ascii?Q?qmTBZFPiRXXOxN2dHfvMjrZqsJeCzVc/BJb3OEPF3087smD6cVW0iSSQOViW?=
 =?us-ascii?Q?l9P8aUmSt0EL3izTC7AV3gzTKq2vEtknEac01D1COIMCUGPPeyWgakTYjCj3?=
 =?us-ascii?Q?QVCm0YWGTZJg2r2J1YWh2eDjwEzaVe1tjz52uaZBfXsZ3cewUNGoUZSr+qzy?=
 =?us-ascii?Q?+iJDgNHUbrcp+Pfw+qjpAMGZYHf7VgvlD/HIiHL3wyDAelDKEjEdq4R7LI4d?=
 =?us-ascii?Q?UA7jEI8T8TZhhP3GHNHIGoDDHhiUjPi6R1vgyyKKvhtCpbAdq1TgN2SBKk6h?=
 =?us-ascii?Q?bK5aEUuD4ZY6DI4dosnqNyMZUh4fMk7CERH13nu0o7+2iDMP8TxcFWYFn9rl?=
 =?us-ascii?Q?tiNH7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:45:13.9358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7afa1fc-ac20-4a76-d7b6-08de590c7338
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252007-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 480015B424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similarly to the issue from the previous patch, neigh_timer_handler() also
updates the neighbor separately from formatting and sending the netlink
notification message. We have not seen reports to the effect of this
causing trouble, but in theory, the same sort of issues could have come up:
neigh_timer_handler() would make changes as necessary, but before
formatting and sending a notification, is interrupted before sending by
another thread, which makes a parallel change and sends its own message.
The message send that is prompted by an earlier change thus contains
information that does not reflect the change having been made.

To solve this, the netlink notification needs to be in the same critical
section that updates the neighbor. The critical section is ended by the
neigh_probe() call which drops the lock before calling solicit. Stretching
the critical section over the solicit call is problematic, because that can
then involved all sorts of forwarding callbacks. Therefore, like in the
previous patch, split the netlink notification away from the internal one
and move it ahead of the probe call.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    - Do not skip the notification from inside the
      atomic_read(&neigh->probes) >= neigh_max_probes(neigh)
      conditional. Instead set a flag, and goto out after the
      notification if the flag is set.
    - Move the __neigh_notify() call another block up above the
      NUD_IN_TIMER check. That belongs logically together with
      the (NUD_INCOMPLETE | NUD_PROBE) check afterwards, no sense
      to split the two conditionals with the notifier.

 net/core/neighbour.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1d7489f50b21..e0897eb41c8d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1104,6 +1104,7 @@ static void neigh_timer_handler(struct timer_list *t)
 {
 	unsigned long now, next;
 	struct neighbour *neigh = timer_container_of(neigh, t, timer);
+	bool skip_probe = false;
 	unsigned int state;
 	int notify = 0;
 
@@ -1171,9 +1172,15 @@ static void neigh_timer_handler(struct timer_list *t)
 			neigh_invalidate(neigh);
 		}
 		notify = 1;
-		goto out;
+		skip_probe = true;
 	}
 
+	if (notify)
+		__neigh_notify(neigh, RTM_NEWNEIGH, 0, 0);
+
+	if (skip_probe)
+		goto out;
+
 	if (neigh->nud_state & NUD_IN_TIMER) {
 		if (time_before(next, jiffies + HZ/100))
 			next = jiffies + HZ/100;
@@ -1187,10 +1194,8 @@ static void neigh_timer_handler(struct timer_list *t)
 		write_unlock(&neigh->lock);
 	}
 
-	if (notify) {
-		neigh_notify(neigh, RTM_NEWNEIGH, 0, 0);
+	if (notify)
 		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
-	}
 
 	trace_neigh_timer_handler(neigh, 0);
 
-- 
2.51.1


