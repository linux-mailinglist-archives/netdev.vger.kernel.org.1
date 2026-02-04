Return-Path: <netdev+bounces-256779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O/WBNx7g2lQnwMAu9opvQ
	(envelope-from <netdev+bounces-256779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:03:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 776ECEABBC
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9086301C976
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C05346FD0;
	Wed,  4 Feb 2026 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZSTMWUd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3640346E5E;
	Wed,  4 Feb 2026 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224575; cv=none; b=t4yohW+fRfnlfCdVoQG9NkqFjx0TxtXo6TcjJ/cKs+fWh860aTkAHWbbJ9e1/f4fZZkUYHeoeS56y1iACd8DzjLPEDeN941lGtasTDTU+1bjo1gFD0+WWsGUge/WP9jylR4Nbf+ldcxZIOxH7EAlYOyZchjXedddsLk6S9s5qNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224575; c=relaxed/simple;
	bh=JqDyRvrLbCuFGB9vb2eyRFjPBLXqEdlHanlYObI8C9k=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=hrdtZajGq5jHB+QkT9nmLhwBcTO0MnEMdIUiFUPG8YyqLnJhiIqxy0TQ4we0pcEEaOKejOQkcGVNyKJCv83eXET/YcqeXRJSXxOJeEYGr2xjy6A9G7qjBhShAWzNEDbw3tkElBtXZhqRX3H6ajlNPcFY1Bqzv2MUHdnXZ+P+5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZSTMWUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3F7C4CEF7;
	Wed,  4 Feb 2026 17:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770224574;
	bh=JqDyRvrLbCuFGB9vb2eyRFjPBLXqEdlHanlYObI8C9k=;
	h=Subject:From:To:Cc:Date:From;
	b=NZSTMWUd8jTWkDxMynhZXmOlFnFJn6AgUxUIs9afEGVuEeHbrnRro/q4lRLihm1sg
	 PME6xE4FrhOezE3aKxt7IGob6sg6A1tOuEpCwC2YZ8Ojep2i2aRi9BNFAhlF42j0gs
	 WDhRfNBDy7CD/ctm+Wy5/gs8i30cFu5Z3UHrvs0Ha5nIIg+0TmSrQVgN8ROynS/CBR
	 b9vj3/tCSq54UHGlFYtq8LaIfoCQvPrBAhr2mcL5kIGM6ovKI0P3zv0gN9ff4eai+T
	 vbc6BzR6+lhbhFoEI6lnqwfL2DsSgKCZAXVd/RVebAsMzizKDjBFFivQza6BXRbvc8
	 ZffM9v+2I5NUA==
Subject: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop reasons
 into dedicated tracepoint
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 carges@cloudflare.com, kernel-team@cloudflare.com
Date: Wed, 04 Feb 2026 18:02:49 +0100
Message-ID: <177022452988.1827734.5121740962985640333.stgit@firesoul>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256779-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,cloudflare.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 776ECEABBC
X-Rspamd-Action: no action

RFC: Seeking feedback on this refactoring approach.

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

This implements the alternative approach described in:
https://lore.kernel.org/all/6be17a08-f8aa-4f91-9bd0-d9e1f0a92d90@kernel.org/

Series overview:
----------------
Patch 1: Introduce the qdisc drop reason infrastructure
  - New enum qdisc_drop_reason in dropreason-qdisc.h
  - New trace_qdisc_drop tracepoint with qdisc context
  - Convert FQ, FQ_CoDel, CoDel, SFB, pfifo_fast to use new infrastructure
  - Remove SKB_DROP_REASON_QDISC_* entries from dropreason-core.h

Patch 2: Convert SFQ as example for reviewers
  - Demonstrates how to convert a flow-based qdisc
  - Adds QDISC_DROP_MAXFLOWS for flow table exhaustion
  - Renames FQ_FLOW_LIMIT to common FLOW_LIMIT (shared by FQ and SFQ)

Patch 3: Fix CAKE to use enum qdisc_drop_reason
  - Change cobalt_should_drop() return type for type correctness

---

Jesper Dangaard Brouer (3):
      net: sched: introduce qdisc-specific drop reason tracing
      net: sched: sfq: convert to qdisc drop reasons
      net: sched: sch_cake: use enum qdisc_drop_reason for cobalt_should_drop


 include/net/dropreason-core.h  | 36 -------------
 include/net/dropreason-qdisc.h | 97 ++++++++++++++++++++++++++++++++++
 include/net/sch_generic.h      | 36 ++++++++-----
 include/trace/events/qdisc.h   | 51 ++++++++++++++++++
 net/core/dev.c                 |  8 +--
 net/sched/sch_cake.c           | 26 ++++-----
 net/sched/sch_codel.c          |  5 +-
 net/sched/sch_dualpi2.c        |  8 ++-
 net/sched/sch_fq.c             |  7 ++-
 net/sched/sch_fq_codel.c       |  4 +-
 net/sched/sch_fq_pie.c         |  4 +-
 net/sched/sch_generic.c        | 20 ++++++-
 net/sched/sch_gred.c           |  4 +-
 net/sched/sch_pie.c            |  4 +-
 net/sched/sch_red.c            |  4 +-
 net/sched/sch_sfb.c            |  4 +-
 net/sched/sch_sfq.c            |  8 +--
 17 files changed, 230 insertions(+), 96 deletions(-)
 create mode 100644 include/net/dropreason-qdisc.h

--


