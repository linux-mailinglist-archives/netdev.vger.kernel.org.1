Return-Path: <netdev+bounces-275082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEg7Fp3Oz2m50gYAu9opvQ
	(envelope-from <netdev+bounces-275082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:28:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB75F39539D
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCDA0303E487
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28A3C5DDC;
	Fri,  3 Apr 2026 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jGO+OSJG"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013028.outbound.protection.outlook.com [52.101.83.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B293C552F;
	Fri,  3 Apr 2026 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226013; cv=fail; b=QecQ4a8YwXyO7SvNb+yy6o7fD6bYHzWO9Ug1UNfmRJAAgvwwI8TdriVxKaPZkPmyrWOmlXoWiLEGj1anfR3I3LgmyOBnbzzhJXXuJ6astypcoXZjBT2XJag7BI97CGKLdg5A2PDbqvgVmGa1sSFKCCthsfB3fXnql20/pKlsT58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226013; c=relaxed/simple;
	bh=odl7ByppX/Ndzsgy7xI1wyZZcmTboHehdWpZfDHnlNk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LojPWp0WiVDk5elvAZ3U7PTV2dvjshR7NRJt2OWTgT4fHtOvdSQjDiDl6sKsyQLHcj+i16Rqa3xjMi/UCv6KKUB9b2N4yKCLTa8FtFvZSqFW3QLeeaxuLIKvGqHtDRh6rrTleYSRFZJU8pqsjdGsEEPk2PGWZd00nOThiyPfsm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jGO+OSJG; arc=fail smtp.client-ip=52.101.83.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NB7Cxbu2zQfodiCY/5za1nzTuRGdzS5ECJPLcQzB41i5UARS1zbpAnChR1SprDUH92HzTIWB1DIu4RbH4loQ+lXJFGCD5prvAG9hsaI5ASqbMm4tK1Jjn0bhisLZI7o1/jCgzI+hVuLk3cxYMJ+MA9HqvqHFtifKFsnTEkRsz7O/rS+PCnSxABIvJLfmr28Frs61MwgwXXD2qs5ouJr6JZqPAbJHQCZFTxjSM0D3Wbai4btg3IsdFAc/IAfz1jXHUkFpIGxvdQxfdNRRU519kUz5NU1NF3+yzVvO5Gk61fg/LO6j2wYdPvQgEOniQXCxnPIvSSnWiuZLzMTUCwpz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rI8SLYY+HZIJiNrZfzWloQCnW4YP9hmzersuCMR+qao=;
 b=e5ChfvDSKzev51+HBgu8Bka8sb8iK3nP4ptMErj7JcGPFNuopnJHgw1l7KapueT+00SUwDlvEN8cT5rsNmYUiRUss/GlJfs15NJdvrkRAU3FkPYTSy2KgX7/ViWG2QBc+M23LBF+OYrHbEJwEsJDsxBMGVaaNSduOcdlWCO0GOHuTeIU0Ti0pVJ8aVzXT6rk35czCPRtd5GPoQCN8edi4JKxEMrgSr92JaMCqcFk8u4SNZIixRDn6CpxS/UQG4ezscBfTCeszIZe+98yBHFGOPiUZld8dCh4fiAkarRGHOuHWYKlrhGPGbkKTfSwR62zQ+OisjpFReALPbNyKaKprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI8SLYY+HZIJiNrZfzWloQCnW4YP9hmzersuCMR+qao=;
 b=jGO+OSJG23zBzQ9H7D1NSwpShCCrNHKN8kmmDDbm09skAySzfCOki/I4yqjEiVVJ0R1KgZjVsS+yB7ELwQtEwqIB8HknIXLPVaxuwNgB29J8nevByIy7qiSDCTAVr7CYon1PtCfe5cF8t4XmbVbUFxDL/x/2L+GEAdA/qMuGoFtSUp968xVMh2iWI3bXZsEIoiz2wYwDH1IQGdG0PYustDnN9fF2Bjs9gWkWtKwuuIg/3+5bpGykwo0bneZVQ5LHcqbZf9Zn/nBmTUxaz1i2eDkKIgP5X5ahffqO49cGs8f/+AIiFfuvbBa79oXd/Cz+GyoQOkK41Et6ky/dFXf9Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by FRWPR04MB11175.eurprd04.prod.outlook.com (2603:10a6:d10:171::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 14:20:07 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 14:20:07 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: forwarding: lib: rewrite processing of command line arguments
Date: Fri,  3 Apr 2026 17:19:12 +0300
Message-Id: <20260403141912.3825693-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0021.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::15) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|FRWPR04MB11175:EE_
X-MS-Office365-Filtering-Correlation-Id: f5dde869-92e0-4c24-f9e5-08de918c1b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Pg6iXZqTYFYA53nBP9YBpKd5NmkdWju0ee7Hjg+Be+htsC+xCHxXFrhIf938bmP6fzTqnov9Sl7HNQQGcIeVnfgdjEdCUt+eSV6o3wBLhm+6w9yeIDq5XbPr1gDBUzltW8YLhRLVXrQBiRDCLtvhci0gnG8EDCXA06FIrB1S9LsjZjvfw1Ilscp+49XWzvw9Z9DH6quLnmMG+v5IlwSmxTk/dXtNEfk+T9HBadewlhlyX5wCHMdKBmLaMJBab5CuVVRnGN1ddDilqcVyXuX0aKFoNBL1w0U/PRYJVfZhCjwt7bggOrV86UyAHlKPmlf+ALjPvcV9NLf3gmj/XZ711sBU3rIoW3w2oTr/Ry3Y4/HddIJgg9NP1jibDe/h4ghYWmD8FquJbi/yOQEfDM8CfiYHOga85FbeHFCx9N4z3kEckTp1C+3C14hoXHhcmn7jsc+stzBRPxFvGz/sC2+DKWWIkT9IupWOEScfWjKIvNULkSNY2Ww2d1M7GG8fmRlIoadZ9DKnXRGlyfTo16+vhZJqbIJ6csBHioG8i0SHPnChjE7JVb+tO0+1YXINTMIkU4EgzuVDsFluyW1P8E9TQATVWZqQaLQoVtF30OHEp90wBcpasulhoqaAF6khD4trbvcBJHmUOiyKvHjWDC9uaLO02o8UXdAxps8Jsm3BrCN02mTM0MmoGmKIAw1fTi9Rfmb/gANlylqfOxDQtYmUmCJK2X7lNY5VKjOYJI5LTSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CGnxLBGyRr7We2Drmr0vxyT1ekNJV5R5ctYNwCS9wj1dSSdc6jnzUSy1y/7w?=
 =?us-ascii?Q?AsITSjGb3Es0kHgRwQvndpw8D3mjQ2eRSRuckmmZgkxvU/tdOVgFpTQizmoS?=
 =?us-ascii?Q?K73jhLm4ih8+RtXGqS/K7qPrzLbmP7XwUi0K+GRQk6Mbl9ez3dB7IdWA3mc7?=
 =?us-ascii?Q?L2wd8PRDTo36XoDqoYMN3mBkYncQXZVfLKjWfCAh4zIHBz9kKpF9WaBMuPYH?=
 =?us-ascii?Q?mcMJxmDgI/n5Kk9o0dvT9p21gGLPvSM97c/5/uuWTwfrw47NDl1kO4Ai/e7g?=
 =?us-ascii?Q?q4/OCLrOuyoklLWslQnxaF6kFrmWfB/1VAEb98HU21PCZgl2/9PaLHaoXb3X?=
 =?us-ascii?Q?sfnzQ7ylJ1vHJtVRaIyvEyQ2X98h/N4uxaOgW0ZaRfOP8Amifjk2oTUwujnP?=
 =?us-ascii?Q?mVv970G14pZOHhiWJ4SzPn8fJOUH4oOrN/RJolH+XaPFlTtzQCoqQkFJirf8?=
 =?us-ascii?Q?uJ1QTPmnRyerxhmv7p4uBzVkXaDJdI1yhQckVwQF2If/KzcvTR2XQ7barJlT?=
 =?us-ascii?Q?JQH9Z70iXeBy00PHZv02ojFiukBJX+DBOHfl0u9wzOUKEe10t+iv8rH13HVZ?=
 =?us-ascii?Q?U9eqTLtms1F7ckeOIY+dwhj+8W0snTuSOg3KPI2UMgmQXoCneN37a2fgSsBI?=
 =?us-ascii?Q?zznrqRoTjluJTEjqrf4vLzKWpu+uIOaJOXGBEf2lhHvUbA8SSvN182SBm09D?=
 =?us-ascii?Q?FFtU0WXT/XIsUI4Y+RxSpBQe+QGzVFbpg7tP5m2tQG03X/pbZbwjWBdN2Jw8?=
 =?us-ascii?Q?SDJBXjTp0KrepIK4rJtt5bvNH9rHelTjEhgt1yF6fl92t66dM7C/z9IOu09S?=
 =?us-ascii?Q?qTgRMUi0+1FbzNHNkK1cXs5lr5Kv/MPMi8GoraBRPJeG786I+7RDnPqMZSO9?=
 =?us-ascii?Q?SY/CmHCSswMUaK2POkn8cggWKNBDjWBRErtuYcQfb62+qe2x2kp9jFNdcU51?=
 =?us-ascii?Q?mlKbxc5TbAs+3Yz7AAsVJBxBSkReHt7WGS1ksBiQcJWHbTOdUy06/D7syCcn?=
 =?us-ascii?Q?RwyRZiCgp0VMujjvCH9EiAK244GDjgfFYUXqbo2fyl1c8fp7vwIp6nSIcDeZ?=
 =?us-ascii?Q?S7fXpw1izu8bHmqOl2qC6bBwn8UH7EFIT7BE2OX4aD3RzFTaK0M6XW+YR09c?=
 =?us-ascii?Q?Z2hc+1N+PQHtHIY6gB2AllPbvHyRumBvYUEo6bb6mkoixS+e8WGUhTyV+6QZ?=
 =?us-ascii?Q?zCI8bkw1Dp+tuB9tsJK4ZQYXftQgi9vuFqhGgnWn0QbvNZPV3zgId8pzUR74?=
 =?us-ascii?Q?oXHAIKOP9upOG8rscobJVZ9I/QjBpGqquc7keUzh+OXKX3HVcPJaoYKBsjx0?=
 =?us-ascii?Q?s878QUt4qxgGWijGYEt0F+El7IzRYdoNixQJmUwiawW5vPeUtlUTMx+SqB5+?=
 =?us-ascii?Q?z2np0XKm9rfGdkAKCxYDnzk3rgpf0LiniK6sYCURbUf02dgwnW6pDMVkOMGN?=
 =?us-ascii?Q?LGtS+JBbZ2bF5VyVI1A+SgWgS5X7mFUPhTGmGYHUjQEBAThqAK/k4ka/Tj13?=
 =?us-ascii?Q?Y31rLMBNQC5ywbSii7Bd3P26TtFabvsIGxFR2Dxq3y4jbM5WsVsGuKB8Iv+0?=
 =?us-ascii?Q?1YjU/LpCnjXDtZmicVct6kyscmxHHXSX5IiIOKfj0OXdz5VkoijlODpYCnxq?=
 =?us-ascii?Q?UkVLtcfYPnOtNKdCRHOw9ltDK9D59Bcc8GuMl2KIbr52Y463fCjvkKl/uyxY?=
 =?us-ascii?Q?QofXLlQUxg3f4OS2CdlQdPz4vEmoF1hx14ueON5OEaV2xRA9sBh3I/sGx44x?=
 =?us-ascii?Q?1tS6SHCnBg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dde869-92e0-4c24-f9e5-08de918c1b8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 14:20:07.7975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+i/fHt7/p6XNB/ScifhkRrZID4jXt4esg14y1ojfHug1tU3jhL4SgzwJMOuIK1mD1Rz/LB4Y3h2r8d0qDDthQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11175
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275082-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: BB75F39539D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The piece of code which processes the command line arguments and
populates NETIFS based on them is really unobvious. Rewrite it so that
the intention is clear and the code is easy to follow.

Suggested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index d8cc4c64148d..922cdaf2ceb9 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -466,18 +466,18 @@ if [ "${DRIVER_TEST_CONFORMANT}" = "yes" ]; then
 	NETIFS[p2]="$remote_netif"
 	TARGETS[$remote_netif]="$REMOTE_TYPE:$REMOTE_ARGS"
 else
-	count=0
+	# Prime NETIFS from the command line, but retain if none given.
+	if [[ $# -gt 0 ]]; then
+		unset NETIFS
+		declare -A NETIFS
 
-	while [[ $# -gt 0 ]]; do
-		if [[ "$count" -eq "0" ]]; then
-			unset NETIFS
-			declare -A NETIFS
-		fi
-		count=$((count + 1))
-		NETIFS[p$count]="$1"
-		TARGETS[$1]="local:"
-		shift
-	done
+		while [[ $# -gt 0 ]]; do
+			count=$((count + 1))
+			NETIFS[p$count]="$1"
+			TARGETS[$1]="local:"
+			shift
+		done
+	fi
 fi
 
 ##############################################################################
-- 
2.25.1


