Return-Path: <netdev+bounces-257307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFWaLNsJhWmj7gMAu9opvQ
	(envelope-from <netdev+bounces-257307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:21:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8C6F7941
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34BB7300DA78
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8290E32ED54;
	Thu,  5 Feb 2026 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvhXWuSM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4A1F1304;
	Thu,  5 Feb 2026 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326489; cv=none; b=cfVPzL/31IOt91Yd1NPYdiaQjUwWUL+T9UKIT1l1QFYQfx5fDJrtCPfX9mZH0H+1Ia72ygJRsR6O6Q46DMkF+ptWt/cK/jwzs8LgcyasW2fueDyulJs/BlfM3MuCgJtyvDCSlQ6DnjGlwfZ48opzJanUOKsx6yucpP5gXYL0kwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326489; c=relaxed/simple;
	bh=1PNoI7bhktvM3wzSSWLbzCTxNetyB5vQXkVo4AJLmGA=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=PwR0JBlroDnWzBAeaFGPi1DZLHR3Inkp5lVK5ED0ao40TRXQTkmh7U0C8qTiFsmDCOB6FSpvb8s5zFb3EkmsZyfFZvV8/qVffA9wjRuFBxiMY6G0bpr2+KKbDdpQ2D5C8W2MDwYFrgdVEZHvXl5y/Ge+C2ccvapNpKwPHrhbY7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvhXWuSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72B7C4CEF7;
	Thu,  5 Feb 2026 21:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770326488;
	bh=1PNoI7bhktvM3wzSSWLbzCTxNetyB5vQXkVo4AJLmGA=;
	h=Subject:From:To:Cc:Date:From;
	b=XvhXWuSM4iLXI/sGecOkj5C2Xcyd4+Bzdk0j9D6SzMSxXC68vesg6XOV2RHJBuGun
	 Ls9wlGOMU01L+ggB/N6NmPQj+WpThfHlYgyrNQSGebMtFBB+cEFrfBZ1zvh6xqOQez
	 O3k/LS2y1A4lv3Ztj1AipNzG2RN+2gXe4e6NfhnVNZtlghE0vIzo55WEzQshOBxG8o
	 UokP/U2MJdu2CQ4ld4tLF3lT/e9P4D4L3Omu9uP4gE3IqcpCud/hUitQgq8LVCEZi9
	 E9NErAg4bQeVzNmQuEJIUfFuwbtk0tiJg4lQUri6CnvNDKXlXMvmmOjeR4RA0csIc5
	 8/0TIQD1iKnIQ==
Subject: [PATCH net-next v2 0/6] net: sched: refactor qdisc drop reasons into
 dedicated tracepoint
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Thu, 05 Feb 2026 22:21:23 +0100
Message-ID: <177032644012.1975497.16411100029657607833.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257307-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C8C6F7941
X-Rspamd-Action: no action

This series refactors qdisc drop reason handling by introducing a dedicated
enum qdisc_drop_reason and trace_qdisc_drop tracepoint, providing qdisc
layer drop diagnostics with direct qdisc context visibility.

Background:
-----------
Identifying which qdisc dropped a packet via skb_drop_reason is difficult.
Normally, the kfree_skb tracepoint caller "location" hints at the dropping
code, but qdisc drops happen at a central point (__dev_queue_xmit), making
this unusable. As a workaround, commits 5765c7f6e317 ("net_sched: sch_fq:
add three drop_reason") and a42d71e322a8 ("net_sched: sch_cake: Add drop
reasons") encoded qdisc names directly in the drop reason enums.

This series provides a cleaner solution by creating a dedicated qdisc
tracepoint that naturally includes qdisc context (handle, parent, kind).

Solution:
---------
Create a new tracepoint trace_qdisc_drop that builds on top of existing
trace_qdisc_enqueue infrastructure. It includes qdisc handle, parent,
qdisc kind (name), and device information directly.

The existing SKB_DROP_REASON_QDISC_DROP is retained for backwards
compatibility via kfree_skb_reason(). The qdisc-specific drop reasons
(QDISC_DROP_*) provide fine-grained detail via the new tracepoint.
The enum uses subsystem encoding (offset by SKB_DROP_REASON_SUBSYS_QDISC)
to catch type mismatches for debugging purposes.

This implements the alternative approach described in:
https://lore.kernel.org/all/6be17a08-f8aa-4f91-9bd0-d9e1f0a92d90@kernel.org/

Changes since RFC v1:
---------------------
- Renamed QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION (Toke)
- Renamed QDISC_DROP_FQ_BAND_LIMIT to QDISC_DROP_BAND_LIMIT
- Renamed QDISC_DROP_FQ_HORIZON_LIMIT to QDISC_DROP_HORIZON_LIMIT
- Added SKB_DROP_REASON_SUBSYS_QDISC subsystem encoding for enum debugging
- Added WARN_ON_ONCE to catch wrong enum type (skb vs qdisc drop reason)
- Updated SKB_DROP_REASON_QDISC_DROP doc to reference qdisc:qdisc_drop
- Split rename changes into separate patches for clarity

Series overview:
----------------
Patch 1: Introduce the qdisc drop reason infrastructure
  - New enum qdisc_drop_reason with subsystem encoding
  - New trace_qdisc_drop tracepoint with qdisc context
  - WARN_ON_ONCE to catch enum type mismatches
  - Convert FQ, FQ_CoDel, CoDel, SFB, pfifo_fast to use new infrastructure

Patch 2: Convert SFQ as example for reviewers
  - Demonstrates how to convert a flow-based qdisc
  - Adds QDISC_DROP_MAXFLOWS for flow table exhaustion

Patch 3: Fix CAKE to use enum qdisc_drop_reason
  - Change cobalt_should_drop() return type for type correctness

Patch 4: Rename QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION
  - Generic name without embedding qdisc name

Patch 5: Rename QDISC_DROP_FQ_* to generic names
  - QDISC_DROP_FQ_BAND_LIMIT -> QDISC_DROP_BAND_LIMIT
  - QDISC_DROP_FQ_HORIZON_LIMIT -> QDISC_DROP_HORIZON_LIMIT

Patch 6: DualPI2 use qdisc_dequeue_drop() for dequeue drops
  - Demonstrates dequeue-time drop handling with trace_qdisc_drop

---

Jesper Dangaard Brouer (6):
      net: sched: introduce qdisc-specific drop reason tracing
      net: sched: sfq: convert to qdisc drop reasons
      net: sched: sch_cake: use enum qdisc_drop_reason for cobalt_should_drop
      net: sched: rename QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION
      net: sched: rename QDISC_DROP_FQ_* to generic names
      net: sched: sch_dualpi2: use qdisc_dequeue_drop() for dequeue drops


 include/net/dropreason-core.h  |  48 ++-------------
 include/net/dropreason-qdisc.h | 106 +++++++++++++++++++++++++++++++++
 include/net/dropreason.h       |   6 ++
 include/net/sch_generic.h      |  36 +++++++----
 include/trace/events/qdisc.h   |  51 ++++++++++++++++
 net/core/dev.c                 |   8 +--
 net/sched/sch_cake.c           |  26 ++++----
 net/sched/sch_codel.c          |   5 +-
 net/sched/sch_dualpi2.c        |  17 +++---
 net/sched/sch_fq.c             |   7 +--
 net/sched/sch_fq_codel.c       |   4 +-
 net/sched/sch_fq_pie.c         |   4 +-
 net/sched/sch_generic.c        |  22 ++++++-
 net/sched/sch_gred.c           |   4 +-
 net/sched/sch_pie.c            |   4 +-
 net/sched/sch_red.c            |   4 +-
 net/sched/sch_sfb.c            |   4 +-
 net/sched/sch_sfq.c            |   8 +--
 18 files changed, 256 insertions(+), 108 deletions(-)
 create mode 100644 include/net/dropreason-qdisc.h

--


