Return-Path: <netdev+bounces-282036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPSmFaz08GnUbQEAu9opvQ
	(envelope-from <netdev+bounces-282036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:55:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C5B48A411
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 744F63044A7D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B851C4508FB;
	Tue, 28 Apr 2026 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nTsvUWtK"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8F44E05A;
	Tue, 28 Apr 2026 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398734; cv=fail; b=PgcFVY3pUhHNzmfGyOHhnoHOUGHQiGUbd3l08M3udE/8GBeKRZudt6Fmq1qJv3MHZQkhqe09lMZ7i68ZHHAjh4UGS8QNoSy4kmEjYcHNDAMzMNAI2uYCKjLVID8xgNpBKff9qxYhjRzydwyJWbO/1HuSNOZsN269ZYIxnQ6hRJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398734; c=relaxed/simple;
	bh=s2Ja2bCjYvzKBJOmH05WFeSSalCCfb6qo3Ax+wKGMKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kWZiKH5Crj6vqSgBeTWamIdvSk4eXAKZxHFxIYnG72GJY58gnAhSj7nW3hVja1RFcT1zffKfe6Qn8iz9Rl+bpn48NJ/1ki9UOhBJ3Udjfr5WZBaMjOo8n9YTXfFrIr/PRyQkT38O8zdghSs2i5RXAjA4C47ZgBOj2hmH7YR/OzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nTsvUWtK; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUGF1vEQcSMXRvscyUOAxgP2nPEArqL+Imcu2GJ8++fC+IjTm55kHFz+QbsLE/WG8ZxZOlQx7/6N6ZtcJIaY3TtOfvfAcnztsGt4ASb2hRgAGXWLrCExvWvhMwcI+XKyxzE2g/tn9TfB5Das9ORDbkidU8Wor9/M2VRDbwkLQvlB7+jcnBXPsfdACroiHiIthdYgIiJ+QryECcjrHMUoJHd8YfyYxuW3IcsQu50oLvQlZEksK0E3Yjp1jI7Vy6G09A+Ztog1BMDBVArU7yFp5njnz82bzNd7brhnzrMiKlMJ3E4u+cABSkmoueveU0yPw0EUBmiIVnhGsc0qURUy+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm8ejzYbmmiKnFGOgY4e1Tw6SfXSymtKJLEsFw37OT8=;
 b=FmksQ+A0j9hAAbevCC6YjRdpz8e6Yenk8kLIq+HIQsfxLQUxdpF++XgQ9606OK6V59jpRHRNCR7DaUx2hV9YDwlMy/CszM8OeKl+M8Odj7Y1gAtv1RcETapGqYrW8LIVoziF/DEW7tYJY9EpYHcw/1LQmIF5mwhTuAzugzbFoWjx3NWltzf4dmx10LsduF/2uPpX8iY4ua8fHuBsZBnhYok4eRYiNsoK9fBhey2VhPy2j8ilWJ3JtfekaAYN72jnzAnsZQApy/vDQoMJvpgRvAD6V03n7z/ZLrrcvB5IO8MyFVEC+HRT2QHbLhhWZiCjVmuTHEr6Am6Z0CMlQZSu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm8ejzYbmmiKnFGOgY4e1Tw6SfXSymtKJLEsFw37OT8=;
 b=nTsvUWtKVVzavfFkWuS0i5/G8KOD8W/42hFPTquhg7uZ1VzEpXckkY6hHFIBlWqkAHHuek/8k9/Xh0YDBLYUSya4RqTj3H8/7+yFN5vyOhjFzfTe8uhoeLKQhoe/C7ROU5hP6ZKSrA17Y7gK4Oc9H7L5pnH6/IJR9N28YfrdAEhG4lIXYi3cnaPBo+4qA/kd3IxGJoj3/iLAlCiWs1YvWnzzMB/WQkRdb5szsMYS5Qt6hNNTGmAVMOLtCThgPhX8P7YmMoPaaPh6zyaI+Bj+mtRb7+0zqezwzQQinyVE7TnU5vVM+4KdUu0XjdWWXiFbB30MogsHA+xHwQy2C/99FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by PHXPR12MB999232.namprd12.prod.outlook.com (2603:10b6:510:3cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 17:52:10 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 17:52:10 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	dtatulea@nvidia.com,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Joe Damato <joe@dama.to>,
	Frederik Deweerdt <fdeweerdt@fastly.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 1/2] net: napi: Fix interrupts permanently disabled during busy poll
Date: Tue, 28 Apr 2026 17:51:30 +0000
Message-ID: <20260428175134.1197036-3-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428175134.1197036-2-dtatulea@nvidia.com>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::20) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|PHXPR12MB999232:EE_
X-MS-Office365-Filtering-Correlation-Id: a2026cba-0987-486d-cb60-08dea54edf22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LxGTk210o+hQulHKGRiVyi23bf9qrGRGb+rPrDcmEOp5a2Ho/bOXG6COJEKgBhxykaJ87mKHZCiMFtdjIwAnnDSo/CsCHVcB8K1rQSG7mXkKamNQYCjH3oFwBCRT8E/4NjwOP2f1BKsXvVa+7ARTy4XxkDmi4f2WfwpZx42S93HFW1kF+wR1wzdPbkVk+P3SKO3qWqL5/8q3NkO44DWAeANTGyrj6VxtJ7d4DP0RUhuGDQO7Iyzy36bsyXtSa1H+B3aweCYdrVCYm5j/Ykcu3Vxpu3tRffd4vKqD0ZquVPM5L27fujvNfe3VLPEfRtbhpox3e7Qm8GMTD2i307r2WxzFxcshMwXkt7PCTgBFbJxmakWx96U+gY6GMCppoz39I8PcT8UHVSFgOsLN8yntKEnWXuPiGvDM7mz5WnZPBs0ioFA4ro6lCOVYcBfohxDsslpSya2LLtSFW64j4sECkZG/ediDGq7/E0iQYx2lnrqEbKQ79VDGwtL/0YpQuVftomam9sh0r66qRQF4MZAt1FHzK5k/pdQJytjO0yGp7JBSHAPS/e8+e0v1WoOSha2SEN80VVB7Y/XGKvIIsbX0XwfMgcVUpIam4e7FOjlTmvd9dvg4tsYz/p4DSjnOCiyd+aniljwtzG/JUqBoh6it6x96hKaZLGKvoTKo5yE4z8lcrvCpyzs1mUiuJyTvCPJkKVmZVi/Wurh4dRXmkYiQSCarT6c7tyQuOQtYa8K99wU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1jiYDJwuaOZszibq3At2oP9QqsXVI+i+90qR+9VE3Dl6igOvqFYi9VUIEzPc?=
 =?us-ascii?Q?V/FXHwpJBruo5DyEMUa7IUCWv22MH/BHZoqDocgDh0Hynf8CNkiS8FTTwiee?=
 =?us-ascii?Q?Y6b6NRaQFbwxCMCNGWMDpG+h3f6/yyHlWs2n9OfK1tcjZ1mL3YJePW9sCDUx?=
 =?us-ascii?Q?NAPyVPj4uhCWw3sMX5KQfT0Yf7Qu9oTE8vZvLGZvNpZRXNO9A+GqCI2de/6F?=
 =?us-ascii?Q?k1JX6NeWvd7aguIHNGt1srkwTyvIsB3H7Npfe0apxKSraa1rsbyhKQ0TVTUM?=
 =?us-ascii?Q?zoIVSlaqJt4/F/P89XlJY/HIBR80zVh4WRoika5xnL98So1pGN1qWGFDmToF?=
 =?us-ascii?Q?W5mFDBMeo9fnBxYFty118IKfq0NQZlfbkwFgFoBbSYC43MjR6hF/148wgZGs?=
 =?us-ascii?Q?gWThjALdctiLSBvRF/IZ7TvFmnv112r6rQvVp4z0JHUkYgT6fBPCtbAW12Rp?=
 =?us-ascii?Q?g4mwM30Sgd1CTXmjMYn+Ef1ghoQpePcQ0JGR5/m7LUzz1cCYaCd9kA4jlO+L?=
 =?us-ascii?Q?KaDcmQ19yJxZjE0wiiXPXQtVi6+xkNVqIFcLRMVrIt+mKACPkkFevOt9BbEY?=
 =?us-ascii?Q?8PDAK07lou0pcOJmuEOiDHW7jYvU+63fx6bG9rMMvQ0HGRusoAtTgtU4471H?=
 =?us-ascii?Q?SKHcuFYTaPBwbzI4bRAVGrPMFcs9XEHEObZ0AqRXWWxIJfPtJiujJbwyXE2i?=
 =?us-ascii?Q?uJU1VoyxVhop89MNRfBrFqHpb2cAEGqKAOrV2w4E6yVj8AlNWiRqJ+vtWrbX?=
 =?us-ascii?Q?E4IeSBSMn8+GDBQKtRrlLIcgG1baSbD2pvfHpaWArpbBZpYbZyC5oNmKl8mS?=
 =?us-ascii?Q?gaTc0Q9Q2IFjjjwW4ynlV0FxKA+aKL37hUgNX2M0CAP3AnDrdqPi4wbUurRq?=
 =?us-ascii?Q?DSmTXHH0vjwI66SdlAMpjifEiSS6QC+MN9daQfur2VPIhnjTl417aVQsbyFE?=
 =?us-ascii?Q?cecE9N/K6BQPdzxJeM36XLVbaauB3h43wvabBXwGV6wAUt8HMhuOVUhkaLTO?=
 =?us-ascii?Q?1w4ClN77CCQQhNJ691bN79g/Hprv5RETqOJ3Hzg/5L0NVyu1B9xsBf3ytP33?=
 =?us-ascii?Q?0nP7siABf6ZIw2RxkkHRU1MTYXQfurKhc/LvJOLdk5KETlN39b/vg+8LUmpI?=
 =?us-ascii?Q?6bKKItZb4h1c5NH5Zwnnk7DCzMcic7/Eek28n8GFhSp5wn+9rEFE6UICTe1/?=
 =?us-ascii?Q?aI3kNIFiDQ7jXqQ54ESMZUAfPtgkqlKLjnzAla81suA5xTb1VJUPsfd+vw1J?=
 =?us-ascii?Q?K9OzNIatXtC/N4rIS6AF5DouLFwWyaefZ3yswXGgjYq2v4iindrZsvz//0jL?=
 =?us-ascii?Q?vyv8JPPURNgvwPuCbosxtWY6m0L5uo8RLEgsDyga8kLz//uSkSS+UREZ86Nj?=
 =?us-ascii?Q?+lM573sTXBy4kdutMpt75cGOTgTwDsDAUP+Gx0bm/Ko17WUFzs1Idu9nu41l?=
 =?us-ascii?Q?ZpJ4/aFQ2S2aD98VZmqJsM+TqZ5CHEx/qWPteLMf1uaOHuh7GnoWOcpaYODV?=
 =?us-ascii?Q?gP4FvE65K1GODAKXKkES14CjmBo3W6dD86hrsbUBhueGp5KihF5vJYEypTLm?=
 =?us-ascii?Q?Be+EvVOz6mEJGrxxeuMG5AworCfbiJDbqNLp7bzCbNncAFcY40dRnLrw3z35?=
 =?us-ascii?Q?FPZ2obj2LMpNXBA0B2R2zOwYfdQPWRY0LvEjLEzxlKBQTxAlAURblbjBU0n/?=
 =?us-ascii?Q?gPRDNnCD9jZaKx0O4FUQoh19Za7cmKefmUvGHeO3Q6IOzaMD6uIL/K1c8XqP?=
 =?us-ascii?Q?RRgxxlg0Hg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2026cba-0987-486d-cb60-08dea54edf22
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 17:52:10.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAvFMxTRn1/wNSq1YvJa3kcOnOXhLZW7N+M7nJzeR6wTUIVbAAXwUjBMbwel+x1Y9jqR14Eowy7pP7kJPSpBXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999232
X-Rspamd-Queue-Id: A3C5B48A411
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282036-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]

Under certain conditions a queue can be left out with interrupts
disabled and with the napi re-scheduling timer permanently stopped.
This behaviour is triggered by the napi busy poll path when
gro-flush-timeout and defer-hard-irq are set. Here's a sequence of
operations:

1. Busy poll starts, NAPI_STATE_SCHED is set to avoid rescheduling napi
from the timer.

2. During napi poll, driver disables interrupts due to being in poll
mode (napi_complete_done() returns false because napi->state has
NAPIF_STATE_IN_BUSY_POLL set).

3. At the end of the busy poll (busy_poll_stop()):
  3.1 napi timer is scheduled and skip_schedule is set (due to config)
  3.2 napi->poll() is called:
    - driver poll() processes exactly budget packets
      and exits early => napi not scheduled.
      (interrupts are still disabled at this point)
  3.3 Since napi poll processed budget packets, __busy_poll_stop()
    is called with skip_schedule set => napi is not scheduled here
    either.

4. If the napi timer from 3.1 gets to be triggered due to slow napi poll
or some other reason, the timer will run with no effect (due to
NAPI_STATE_SCHED being set).

5. Busy poll finishes. Interrupts are still disabled and there is no
timer to re-schedule. Unless another busy poll call happens, the queue
will be stuck.

This patch defers the scheduling of the timer to right before
NAPI_STATE_SCHED is cleared. The timer is rescheduled and the
NAPI_STATE_SCHED bit cleared with interrupts disabled to make sure the
timer cannot fire before the bit is cleared, otherwise the
situation described in this bug can reoccur.

The timer is no longer scheduled when the napi poll returns < budget
because napi_complete_done() will re-enable the interrupts or scheduled
another napi.

Fixes: 7fd3253a7de6 ("net: Introduce preferred busy-polling")
Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/core/dev.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e59f6025067c..1487d4946dcf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6869,9 +6869,11 @@ static void skb_defer_free_flush(void)
 
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
-static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
+static void __busy_poll_stop(struct napi_struct *napi, unsigned long timeout)
 {
-	if (!skip_schedule) {
+	unsigned long flags;
+
+	if (!timeout) {
 		gro_normal_list(&napi->gro);
 		__napi_schedule(napi);
 		return;
@@ -6880,7 +6882,11 @@ static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 	/* Flush too old packets. If HZ < 1000, flush all packets */
 	gro_flush_normal(&napi->gro, HZ >= 1000);
 
+	local_irq_save(flags);
+	hrtimer_start(&napi->timer, ns_to_ktime(timeout),
+		      HRTIMER_MODE_REL_PINNED);
 	clear_bit(NAPI_STATE_SCHED, &napi->state);
+	local_irq_restore(flags);
 }
 
 enum {
@@ -6892,8 +6898,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 			   unsigned flags, u16 budget)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
-	bool skip_schedule = false;
-	unsigned long timeout;
+	unsigned long timeout = 0;
 	int rc;
 
 	/* Busy polling means there is a high chance device driver hard irq
@@ -6913,10 +6918,13 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
 		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		timeout = napi_get_gro_flush_timeout(napi);
-		if (napi->defer_hard_irqs_count && timeout) {
-			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
-			skip_schedule = true;
+		if (napi->defer_hard_irqs_count) {
+			/* Timer will be scheduled after napi poll to avoid
+			 * firing during a slow poll which could cause the
+			 * queue to get stuck with interrupts disabled and no
+			 * scheduled timer.
+			 */
+			timeout = napi_get_gro_flush_timeout(napi);
 		}
 	}
 
@@ -6931,7 +6939,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
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


