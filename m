Return-Path: <netdev+bounces-301184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hH7zHTF4OWqdtwcAu9opvQ
	(envelope-from <netdev+bounces-301184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:00:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C559B6B1A51
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:00:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=SDkhocZe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301184-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301184-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BF31302AC0B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45083438A6;
	Mon, 22 Jun 2026 17:58:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021137.outbound.protection.outlook.com [52.101.65.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A8D3438BA;
	Mon, 22 Jun 2026 17:58:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151118; cv=fail; b=rvt/Gu1oTePkeXeRy3SzrP+EVDE5XBWDrNyYFQ+tebETpLzMGKyk7YfmpM4ZpCyiM0BJvUExOaeHWDHKoPpc/FDcGVveN/rrJ8vAYTbxvux2Hh2UynsXYBs6JRS256I11/SlcZ6fqf/ZCyhKGo1a4nZ9L43VW/xaZLdd/vWdIMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151118; c=relaxed/simple;
	bh=C9BnYOgUzFm8o96j0QhDeuFt00UlMp4DFYfn8eJ7/bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L4rhYnomugTfxO/nwtSVKz2PkHQD2G86AueJZqhPiK4YT42oyodMlGAOirmj4o54SvEH8ywZsYuse7a/APF8Gh3J0kZFXt0zV//8q8jtIWcfCV957JUiU/4A1CiS2TI9eAK00N+hRSloZWNLVmFbGhZfgPq2/HThyaAfzdSLkvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=SDkhocZe; arc=fail smtp.client-ip=52.101.65.137
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxcYFWJ90a530Ekf3K/islBkHREbpJiJZ9tMTEijuuPstsWyq6eqLicgDk4pe8hED5jaIMy1629Z18WhRh6U7k5BmvXxqk/qR/9XPDoMWDbBitV4FLY4aGL2yRbMxJG+OFSnxz45w0M8g5rXXSzG3hal9Q+YnGGC9/s4n+10fQIWm1BVaw6zMqtUAaEh9ot5pdsAyx7HzXArEuWxoTDwrEhgYp7iEcMUBCOfQbJFgdA7in95VsL0EwwF1SKOnnQet7VHWI/M9nw1bL+EurgOC6ItxtoKeju+xYQ7ucvj0RVa3z2Q+PIgzV5pK6VesQAs2TyV7Hzvqw058w3t6Oa2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UBRO2nJM0AGPlR0RftdOpFZsbEtT1RquYhZMFh00vk=;
 b=jw7Qp1f8o4j6isXiTWwqF75CBaTqmzxm8pVjmp2h5toPIJvwkzSxrKr0DrTU6xcGwZRJZr7qw6gBfpQF1DYVP18KBRU3UvIaMGfHPb8EppvtgBhdOPjG9hPvBlSAJbSnx0mp4Mm/nlDcZm79Jw/NBj9aJ/kO6biaKOYP3QtbW/rN9wmBkGu40sRf1MKJWygkBnZF0xDQVkP7FRz4As1GYTOdASIVfGGEx2Nbz8IcE1xHoJKANHlS4CEfbc5rNXhdT96HkIJqHu/iHiS2yeLuzCaRmgHdQD4SOJs+Q4BioBsPM83GPrtCg91ortpc424adBmmlwHQhSuuhfooR/JS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UBRO2nJM0AGPlR0RftdOpFZsbEtT1RquYhZMFh00vk=;
 b=SDkhocZe+S/bFqQls0P9lkwKsisO0DXRdip7ar9VnjlBUnp4xtcJFxHqQcW6GOtDRCLeKsshTlvJQbFgAVN/G/QoNRXCa10Z2fhYoDKEJjseV3g72KYByRrBk49ytrDyNZI2zlWpRYxl3QdXxAta81FhyHa7KHHL7WKM0zW+i3OSVMGRJXWuKYWZqdMGoKHearyOs2K2q9o23JfML83odZZprDLQsyxVz8/ZCUElYXWvXvTh5a75nwqZm9UkL+qr8XpmSI7qfyHM29sYltJlB0ghqU1kawntqvrz518WpQVWXBdSS2rw/IdLFmn3wATUQpRd7NDDieAW3goq7iWEUw==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU2PR08MB7375.eurprd08.prod.outlook.com
 (2603:10a6:10:2f3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Mon, 22 Jun
 2026 17:58:19 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 17:58:19 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com,
	bchaney@akamai.com,
	mark.kanda@oracle.com,
	ptikhomirov@virtuozzo.com,
	den@openvz.org,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 2/4] vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
Date: Mon, 22 Jun 2026 20:58:06 +0300
Message-ID: <20260622175808.508084-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
References: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34f::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU2PR08MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 6236a648-45cb-4087-1c17-08ded087d7b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|7416014|376014|1800799024|18002099003|22082099003|38350700014|56012099006;
X-Microsoft-Antispam-Message-Info:
	AoK6TGoCsDI8su/SMjL4MPtXAm9Qdq4iiX8hDv6rgkTuXGnCZ/p/EVzH6hheQ9QdjKxUigEny8pJTzQMvvWdtiXPHkCLW/IIDmqVKVK++YKEsLkqLO37QXTxfsHGpwpTkuwklGOztb60XyJurveRptu4OnNEghy1NedFHtFDH3Md1QNTWssEv4udLuQhJHSxJiE4VuVz3Ltp8q5tWDJ6MDeXSQ6wyQlbUd+MaEVsEWFXNJaxyN8D+BIY53XlAO+W0H3MRTpptL1STotpDc9kpjLbbR4cQAivJ3aZqa/GcNGe23yH/9mgPA2f+2cx3yvQyJ4ZpRA8HGL8EVmR7SLSV9b8UyYUlr7WrrApC1Lj+TgERLUlgSJtH4IghDZYQ4nD8l7G19meOzaDOG3o6I3NRihTcGvPIzCk2/sEtSmZR6TlwWYVQ3KAZbc8lhRsSrQ32gKh7ISL2jMSw5Q25GJJSGdXm2hntlDfFkYw48p9FFyGp1Q+Zutm4iNeEwiikQk5CTVs94DgBacKKxMgBTtqhpUDxJXgQzvdJKgIc16aMlEty0vKSRmdcd08A3QizhmJ5ZQVB28iQfRlQydFPF1oXrZg9HS95M8EKPFdTupf1OYa34wVfmGeVE3nTXScA4upCeIoOaEwI/nUGIVxTJrSyqn9lnfX7a3wDKTxuBii8JqjcKNsRVPP2Eqr3KcwUMPRIcq5cMAy7SpbfJkZDBSOvp/gCJ+0eQlIZ9po7eF6zzc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38350700014)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FnPvyAi6zfHHyTQFKTXivEO2RfIWJayBqnCBU1XG1jFl3QHOc+bDvDE8LKWB?=
 =?us-ascii?Q?Z54IwNJquMRbOBOP6scQqEX5zP7Hue/w9wugHz8V6gEi2gHJpwAlMxV3Yn1q?=
 =?us-ascii?Q?qCPZCBv/FFNxja/34rl6tcFKKOdENOWTJj400FFNDSuycvJJgv3xP10pu4lx?=
 =?us-ascii?Q?/ayxilmI9PhcUDgNkDw0Y2x/z8Um3moFl+tdPjSPGkdRzXKZS7dc7U9EN4fi?=
 =?us-ascii?Q?Xt0AdVk3OZ7SjLRxlVUt/QEv96RA6FlT3PkS/m+IjQUJpiL6RYhvQSWtsE71?=
 =?us-ascii?Q?RoYc8zvMUpXIUBm3NgOkW7EWHIyjXEaezroJzBwbEtjE3kFf1DJqcszfUEi9?=
 =?us-ascii?Q?KjirXLcMyV+pkbI0th/eHDI41T7jhyikRLwB/OBA+pFQzaqEEZWxAB/97+FL?=
 =?us-ascii?Q?7pq97/AWi52yow3IfYfxB7WqImYF9so1sZzUyF6Ft9v9ngASSwf21FaZ7DWG?=
 =?us-ascii?Q?Y/DGzYo3IGjEZHuRO/1WDLSTmatqEp6TFrEXy4Oy/+/hCeYpw+vwHH1lzUuI?=
 =?us-ascii?Q?ANNEkr8Yg1yNxGuey9A0IBT4xOaYBNcP2MNUEio4ozgtWIA4ZGNWugSuFiHX?=
 =?us-ascii?Q?2Th15rOv+Tvb7oRxkTzEoK19OLoKTiyXFsBpUPjsZ+Edg2GqNeAUNHAS3gni?=
 =?us-ascii?Q?LNz5Oadx40Zy6NzkTs+6pmhtSc/13hWo+XoFPnB1Od3DtGuVI5AXNX0rzP3B?=
 =?us-ascii?Q?fTpmOkd+1uf3154lPWboqvj0S45OAd4F4sqjM8hCCbMA0V6PCfmS0fSpo+xH?=
 =?us-ascii?Q?yuCnbn5QNOR/cb1pnMPtJXRqs77xFW03Hv5pjNtLc5e0QM9ZczG1+BENQ493?=
 =?us-ascii?Q?SB+ylBS4wp4rK8rra6yeo2uZNQyVi7cp/qn4G8U/68ZDh9mqdzXLeaGCyTSs?=
 =?us-ascii?Q?b/Bj7/wk4d8fxtzoghCIIdx6CBcU5rzJFHRo/niT+n48aD3hby5WGHT3mVo8?=
 =?us-ascii?Q?6vKvn/YbkOKpJXGaBZzzjQEL4FvziOwaCl7APGnwR13wy9NyJN2hCwwqScJV?=
 =?us-ascii?Q?wQKmb2ZDWxTAvpKa0ua4zVg40kt2vciuBWHUJDHk0oGW4nia/9WNlmuHwjX9?=
 =?us-ascii?Q?wLbpLRfTDiB7LYo2lYm3VZAvWU276Jc40kY7V2Zir/ZEEyST/99C5hvb7I5Q?=
 =?us-ascii?Q?cPr+pB3omGurGMxmVO9vytHkknu7ii4avIr0be0SuijiTDtD+n6WHE2PdMez?=
 =?us-ascii?Q?MFSOWr9k2U0LsfE4wfkZV5Nqu0HrbEde6cfEAcL59T7k2v9Y+2+0k7omZpCN?=
 =?us-ascii?Q?k8UNuwjhINWBIlR2qsXP5MCmzZ7yJd99OoQUL1WPOlrHK/iQ3abLfOOkSRCo?=
 =?us-ascii?Q?L4OrAvq4f7YndN5t8AeLCnd9D8EMZoe3eYcRXF1hF/GH0xjq9XDf5aWxn6dq?=
 =?us-ascii?Q?ECTTIgRzIFejgc6w3i6yJG2V93GP3ftNvszTnFdZACoag0mYc1VhFiGJzpPF?=
 =?us-ascii?Q?eqLT7TSIUhufz4tRtVoa5hRkIGVHJswbTSdjMDsInSi17boItJjfMfpx8cUQ?=
 =?us-ascii?Q?wqBE9NyTlX9dXZo8dMWPRsolzFfeJI10NrzECUl0GXy8rfR2PqY4NEAM76XC?=
 =?us-ascii?Q?0ki28LVaVP5uP0KsSjmmpBYAO1i6P2o0YXrQfUe8vMPvc47XwZ3pWAbBdEUT?=
 =?us-ascii?Q?ge/GmFeoQDJASk6x8uFbHfUCQVa+/tnQ2CX+NVeWMh/y5EdeD4XXo7N5wZv6?=
 =?us-ascii?Q?ZJiyEpRDTdo94zo2hcKFI1+lmWLm+LCquU3lXLgPJaUJWJaP+fkHE4KxP92K?=
 =?us-ascii?Q?jlXdVyEorhIMGZTWCIry+lC4zAKOx+M=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6236a648-45cb-4087-1c17-08ded087d7b0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 17:58:19.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBca6bJuRQuiacB6/df3j00p+EQDUkXgBU2wgQ12P1ij9ULUxP6Y3pL3qgYIKGh7RpYOO0BOzFNX4/3uFV0zvbSEivGknhXJZNdZDt8hSm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7375
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301184-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C559B6B1A51

Earlier commit bb26ed5f3a8b ("vhost/vsock: Refuse the connection
immediately when guest isn't ready") added a fast-fail in
vhost_transport_send_pkt().  It rejects every host send with -EHOSTUNREACH
until the destination calls SET_RUNNING(1).  The fast-fail condition checks
whether device's backends are dropped, and if they're, the guest is
considered to be not ready.

However, there might be other reasons for backends to be nulled.  In
particular, when QEMU is performing CPR (checkpoint-restore) migration,
device ownership is being RESET and SET again, which leads to backends
drop and reattach.  If we end up connecting during this window, an
AF_VSOCK client gets -EHOSTUNREACH, which is wrong.

Add a 'started' flag which is set once in vhost_vsock_start() and is
never cleared.  The behaviour changes to:

  * When device was never started -> flag is unset -> no listener can
    exist yet -> fast-fail;
  * Once the device starts -> flag is set -> we don't fast-fail ->
    we queue and preserve during any later stop / CPR pause.

Important caveat: after the first start, a connect during any stopped
window is queued instead of fast-failed.  That was the behaviour before
the patch bb26ed5f3a8b, and we're restoring it now.  However we still
keep the behaviour originally intended by that commit (i.e. fast-fail if
there's no real listener yet) while fixing the CPR path.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 drivers/vhost/vsock.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index b12221ce6faf..bec6bcfd885f 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -61,6 +61,7 @@ struct vhost_vsock {
 
 	u32 guest_cid;
 	bool seqpacket_allow;
+	bool started;		/* set on first SET_RUNNING(1); never cleared */
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -302,17 +303,12 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
 		return -ENODEV;
 	}
 
-	/* Fast-fail if the guest hasn't enabled the RX vq yet. Queuing the packet
-	 * and making the caller wait is pointless: even if the guest manages to init
-	 * within the timeout, it'll immediately reply with RST, because there's no
-	 * listener on the port yet.
-	 *
-	 * vhost_vq_get_backend() without vq->mutex is acceptable here: locking
-	 * the mutex would be too expensive in this hot path, and we already have
-	 * all the outcomes covered: if the backend becomes NULL right after the check,
-	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
+	/* Fast-fail until the guest first enables the device (SET_RUNNING(1)).
+	 * Before that there is no listener, so queuing is pointless. 'started'
+	 * is never cleared, so once we're up we keep queuing across later
+	 * stop / CPR-pause windows.
 	 */
-	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
+	if (unlikely(!READ_ONCE(vsock->started))) {
 		rcu_read_unlock();
 		kfree_skb(skb);
 		return -EHOSTUNREACH;
@@ -640,6 +636,11 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 		mutex_unlock(&vq->mutex);
 	}
 
+	/* Set 'started' flag on the first start; never cleared, so send_pkt
+	 * keeps queuing (instead of fast-failing) on later stop / CPR pauses.
+	 */
+	WRITE_ONCE(vsock->started, true);
+
 	/* Some packets may have been queued before the device was started,
 	 * let's kick the send worker to send them.
 	 */
@@ -728,6 +729,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
+	vsock->started = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
-- 
2.47.1


