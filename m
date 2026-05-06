Return-Path: <netdev+bounces-284762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I+JOy0F+2mbVQMAu9opvQ
	(envelope-from <netdev+bounces-284762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:09:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D19EB4D85AD
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B56213002E45
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 09:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1863E559E;
	Wed,  6 May 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pnvAJaJp"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8043E3174;
	Wed,  6 May 2026 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058532; cv=fail; b=qjzkOOKZCu44XHCu+8BobN6aowQPQl0pBlktzgh9UTLXO68YHYYQ6b6AaPiHT/DYEvEnqIcYI9q9GoBWUm8IAe24ZGKeCWHR7Ne8qUVyaUkzcfAoasAGZK7g+tHLZHuPw3CKNiV8l061JKTOzdGACLV1E0XYm4GsrGrCTR4h504=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058532; c=relaxed/simple;
	bh=tMoKU8X1VIl7mDtDdVLwbM1Da0BgmLL2lJMYhwU5Shw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y6b5O7HEtHxiYgwCVoCWdJ0+xvBceyWGeOv2npe1XFxS1FN/Irpz+2844nltDsHq27MI1XLwTRZC2YeAlbgSnKgO/Y1lsUTzTIwhnFkFFEcmlGaI4AwWcEDKHLXP8m2cR+G0t+jDciIwj6WMOyv01flmI29JqQTrc0f5y4Rlibc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pnvAJaJp; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elVvmq4iPTrCtoFpgYh4CpGfpB4rAX2rW0fL2Gf60l9nvOieCQD0Ng5FSJ20wLv4fDZxoy4n8nwRoiOT0TduDWj7SfsnUTMj5gziS98ax6bMD1/1CrZyIi3GKchmkYJ5Tg/cpMeqcoCGKhqXLV0SFTlmLfXFs985m949GT2znsqSW1dLaf+4ING22m9F5jP6nI8F60Qkm+zGFSgeY58bzF4VJcrBKxYGBxURkEQ8b9A9p6mAwmRxkopljR+lQzcBPH2d3LvYV7sFztWGw3BYTHLztS3O5MfPmwUJNaXiPrwG5PYiZSvQJN6uhcvHbjIoiJwRqBeTseJy7xp9mvXJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GTEMS7QRGmIJUgPMqhS3nU2X2k1ELC81INgvJcC68k=;
 b=WyOoIWmwSjpmn85WEuskUbW/wasQKVZjsRH3Xrxpn5gToqBXQKfvMgi55bnwl+BBdPUegzP4vMH8Ijr0Hn5QihGPdTpmlWRLfj5wCSlKdogzJ7jTXG8JXBO852lQ5LJwVKfGC6enkW4F6aG+5wFqPXvcDMME2GUeSt4gWau8YEq6qgJIAjRKQiY3FFItZ/NoQuRmXIAccHmSOS2b+u9+fNxyWhEUePNkIyDYvyJMHHcF8Di0a83DYnMjmJpPBazgu+YjthDqskw8O40L8BQ2nA62hPWrWk7j8e75Zlv9eYdGwh5IWdZ8P9b8C6ZoXzITMI/YNi333WtqB2jVyhr0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GTEMS7QRGmIJUgPMqhS3nU2X2k1ELC81INgvJcC68k=;
 b=pnvAJaJpIXIwRHxZ5qPwucfiIBGIX85RSFLMw42nIdFTjKP+NHFRzM1/VRQg9GKqeFrANyScrxj9YkdNfgNyJqKXUSW2zn0TYd5YVAZJhleN9kAPiA1a3s470L/D50gi8k56p6PjUU2+YP9+kifFJWYmL32M+Ol+X8l/nyXxx5No9vbpTphwagYzk69OrdKi5K3a7ulfni63sEuG2Lb/NPU1VbfimjmnMjcVpghw7Eq42zm5bhFxBuZj1KLjXqyjzp3msiKm9yedGq2YGxreQscnqEuJ/xASCu+Ib+r7Pq16v/vadV1HUSSnH457AEZAUpz4M0Y66v/YKvdQfWeHsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 09:08:43 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 09:08:43 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: dtatulea@nvidia.com,
	Gal Pressman <gal@nvidia.com>,
	Joe Damato <joe@dama.to>,
	Frederik Deweerdt <fdeweerdt@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Tariq Toukan <tariqt@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: napi: Avoid gro timer misfiring at end of busypoll
Date: Wed,  6 May 2026 09:08:08 +0000
Message-ID: <20260506090808.820559-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0296.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::16) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3257ed-e826-4d72-c79e-08deab4f124d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9rvPM6lf8+zcpuBE6ERy5qYV4RsqizN7sXGzGVsCFWl293f/EUgaiA89mL2I2iSmuEcf84ZvkxlPuOK/iFrj3JWfyLEVYVc8QPOY83fS1w8pUJpxKcSh78FjNY3/DWf/jhSOt8yje8M8c02Jf0fhjET6t4grU882FbKISC0XZrejBlNe/K6J6cc7tkcvKPh8mbBsg885ray7iMGJ9NLNLGgVUPK5F8sh83pnjVroPzYNZtJn7/S9Zjx3avRJSka0vEGra5iEd27qbPdxot2JsHD2uokWSFyebVDQW0nHSRrwDmKqSKTcdlmssVpt5DKSDyR2/6P93DC4d+lVuEUrOzdFonikuVhsaVpdSypPrKI51Ob8qdURsLb025K5kOBffnh8DIISxMDO12/ETRp7Q5nZun1VIaHQ8QrSC2yQDE3kEbcNJptwxYNS4kpYw8htTgIBQWrPjzhIXMrAQlTlye+CQZM4z4J9M4UOxEO2UmHh5lIrUn6r6b814q04ZIqzC+i8XoaX3z7aS30DR8554ZBxpFqsKm+Yc3Sh7cgf4X6AgJdYjstqyxGTVqPfns7532qfGfvYL0Ljo42Etnlu52ZX1f34CGeoxg1K9jOfJocXETXU00VsjhlSyw47Ks0AdFoVhrT5LYT6KmNvpCiZ6z5pAXmCV/OJ6+0BGD0sbWm5BK/YfQ94o9s0eoC2hyqV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?31YV2RJCaAHl8ln7dVHmBkwkW5tz0wo/0VMSH/ZEgTlRjP/d9Z7MsOuz6u7q?=
 =?us-ascii?Q?ywsMpIrBGxEokwUAk4i1Z9+9kgeuKooPSp+efvRWG8DtUno2ek+/J5QQZeXV?=
 =?us-ascii?Q?/MBG+/mnknrfaKZOBmPCmBGOjKBysTsmCOPqgtMuOig8txwfA/2zl1//T6k/?=
 =?us-ascii?Q?lsGoChwgIpVXFaWLpWVJ2rk86w3g6cJsHH8lw8H8f+ysfLSzipsaADzguOw4?=
 =?us-ascii?Q?ELqfonoI8O9uHNdakl8vcCnqkPgXdLbls0Wl07on9n1gcIOG7v4zh9MnCmX/?=
 =?us-ascii?Q?SKNh6/p2Z8/2P0UputSpO/zi6e8FeZkqqqNu9/bVr1mDSrHOKkPnnSnkntC4?=
 =?us-ascii?Q?5aKDmUHZBS4qU1VqZCXjV6dNThfOyXDH9ITeAxXHUPhswMB6Gt/YE1kpRfoc?=
 =?us-ascii?Q?mqckxcLuXfpw2rnUQ1BjMRcOy37qr9Q5cdtbkrKpYQG7bbG3cXQSqykL0ggn?=
 =?us-ascii?Q?MB+AMI22KnhtNor9eDveO0f1jUi48GAKK5VbHbfmqPg7rjpFuufdGkY9e7ts?=
 =?us-ascii?Q?DX+mA94lNGYTkNTe4B8JlDBMMoha0SClGe9IC1vF36h8DBfHY/FGshxA6HNU?=
 =?us-ascii?Q?CGOG+vFgrKK7zudy0xYWupGetSG1A1+/AkQjwlSRPf2vLkL/FqYt3z9LhdiH?=
 =?us-ascii?Q?zJnHppJC6N3F0PgqRWEcsvFwqXZky4gnEFgnSycLUAF+5Jz9TeSKwuqh5tVc?=
 =?us-ascii?Q?ltbNjh74UDvQEz9OVJniPchXdJzA+fWU9gzCUp6TJS0a1pD/pz9ItsVm5hxd?=
 =?us-ascii?Q?aVZ4NESqSs6iMml4b5B/GULQkLVbv1ps7cS2+16yZ+jMdlE7aSqzx8vDfxwO?=
 =?us-ascii?Q?5lwJTG+XbwlwEJZ7J3CD0qzU6nZJKrrkEEeSRaVtX/sVTTeDR0mTjMxHWDJ+?=
 =?us-ascii?Q?7QJYfwfr9wQJ2Jc7kqA3tcBLREB0k95iIv979x+bKtt18JTgNnge8cOuqAzv?=
 =?us-ascii?Q?mwre7p4OBxkkolZF2rjNcGVTflFpCBelKLTKla1TjpYHqT1tudJAQ6Xh+68e?=
 =?us-ascii?Q?/Z9sCt+3QlvtBAEQnbPkKFkLrQFv0a9ZgWdrCLOEYzjpeUEhL2/4z2lrph5+?=
 =?us-ascii?Q?NTdfdh+Y0K2O+uANm5mTE6IQJdlmcb0Rfpm8Hl4sF++9u6Fg0e1/QSAN4/D/?=
 =?us-ascii?Q?agvYM6ILzMTrm58r9F13v54wQ3MkV13lKXXCxnnCLPutj5byCH/YOcEfbhwd?=
 =?us-ascii?Q?WBu417K0JKkw65JZSOJh/VzGpxXc7YLkI2gF6l5n0v3Nk4rn0n+xXqFRdNd5?=
 =?us-ascii?Q?1yDFeAhMQUS1aqbaykvwDGhGh3MMtabqBdi+5juGH31P8SAV0C66OtS2WneC?=
 =?us-ascii?Q?GbdeDqbsGXVtxpE+NgWHQekyAm2FSCL3Cr/mu6GEizuWYF4SwXT0fj7yboGq?=
 =?us-ascii?Q?GdQX0tNGi9QFqzARc3lhBYRhAOMbhflt7zi15WRxIHxz5CSODSRupwYG5Dur?=
 =?us-ascii?Q?Mt7hAAUZMQUMIec/NVuVFif5wT1/Z3fF8RkliWY8/kEVfasdsSgUjIlrfoX5?=
 =?us-ascii?Q?IzmI2eInd8NAIE81fDC4+iEeeS+t0VoxCEj22D/a58xCEBBaONmSPWlskX9/?=
 =?us-ascii?Q?KholpTRbbFjpD5hc9qDQN4xQF3Jzic0h2sKRRRJtJDXHW03SP73RZULK58OB?=
 =?us-ascii?Q?+h+nKS9BhEcfivc2K8p5fqPSsLUJEwX20n8U7I6DciL3uLgLdfJULBsufoCX?=
 =?us-ascii?Q?K0q7HLcdUxU1XaKNi9WdqSw9PayH6p+Nt6o50x104QOKVPIUYD8RrneiaqLS?=
 =?us-ascii?Q?R5R2zcP6xA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3257ed-e826-4d72-c79e-08deab4f124d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 09:08:43.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXRZIAryUWfL/ui3raqYB+oXe/xj18xng7PGHCKlDpJ03uvDlnn+4Vr7vQv/1yiU7fgw8ZHViOk4iAubbAV9Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
X-Rspamd-Queue-Id: D19EB4D85AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284762-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,uwaterloo.ca:email]

When in irq deferral mode (defer-hard-irqs > 0), a short enough
gro-flush timeout can trigger before NAPI_STATE_SCHED is cleared if the
last poll in busy_poll_stop() takes too long. This can have the effect
of leaving the queue stuck with interrupts disabled and no timer armed
which results in a tx timeout if there is no subsequent busypoll cycle.

To prevent this, defer the gro-flush timer arm after the last poll.

Fixes: 7fd3253a7de6 ("net: Introduce preferred busy-polling")
Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
Changes since RFC [1]:
- Sending only fix to net.
- Made commit message clearer and more succint.
- Fixed timer arming to happen after clearing the NAPI_STATE_SCHED bit
- Arm timer after clearing NAPI_STATE_SCHED and drop IRQ disable.

[1] https://lore.kernel.org/all/20260428175134.1197036-3-dtatulea@nvidia.com/
---
 net/core/dev.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 06c195906231..3ebd69988d51 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6862,9 +6862,9 @@ static void skb_defer_free_flush(void)
 
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
-static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
+static void __busy_poll_stop(struct napi_struct *napi, unsigned long timeout)
 {
-	if (!skip_schedule) {
+	if (!timeout) {
 		gro_normal_list(&napi->gro);
 		__napi_schedule(napi);
 		return;
@@ -6874,6 +6874,8 @@ static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 	gro_flush_normal(&napi->gro, HZ >= 1000);
 
 	clear_bit(NAPI_STATE_SCHED, &napi->state);
+	hrtimer_start(&napi->timer, ns_to_ktime(timeout),
+		      HRTIMER_MODE_REL_PINNED);
 }
 
 enum {
@@ -6885,8 +6887,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 			   unsigned flags, u16 budget)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
-	bool skip_schedule = false;
-	unsigned long timeout;
+	unsigned long timeout = 0;
 	int rc;
 
 	/* Busy polling means there is a high chance device driver hard irq
@@ -6906,10 +6907,12 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
 		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		timeout = napi_get_gro_flush_timeout(napi);
-		if (napi->defer_hard_irqs_count && timeout) {
-			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
-			skip_schedule = true;
+		if (napi->defer_hard_irqs_count) {
+			/* A short enough gro flush timeout and long enough
+			 * poll can result in timer firing too early.
+			 * Timer will be armed later if necessary.
+			 */
+			timeout = napi_get_gro_flush_timeout(napi);
 		}
 	}
 
@@ -6924,7 +6927,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	trace_napi_poll(napi, rc, budget);
 	netpoll_poll_unlock(have_poll_lock);
 	if (rc == budget)
-		__busy_poll_stop(napi, skip_schedule);
+		__busy_poll_stop(napi, timeout);
 	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 }
-- 
2.43.0


