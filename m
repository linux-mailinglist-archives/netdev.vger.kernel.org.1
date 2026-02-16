Return-Path: <netdev+bounces-258909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLmBC7A4k2mV2gEAu9opvQ
	(envelope-from <netdev+bounces-258909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:33:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A72145A0C
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AF1D3009FA2
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28A32A3C8;
	Mon, 16 Feb 2026 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anWllO5/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B3328B5F;
	Mon, 16 Feb 2026 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255828; cv=none; b=QSygnEK7WdTpwZWQ/wPsRdDeaszyX7oomVqhD18I2xWpwTh+DTVEnLnaL0Ah0PSm7PFEL8vRRNVEvFehag1QsAvHaV4xrV7/5tcDhNUASDO6c9mXoBrx6O1eQvQr4d6Rvf/jY8wdg7G/hXlsLcHa18ksujRN0P0gvNymGjLytuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255828; c=relaxed/simple;
	bh=Q0nzRau4nRHN+ewX6ak9EtbfCs2MmQX+VT8EFugOi5Y=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=EDf66hXP2Oi8NAlTlXSB4SPnld/7AAUwlSwFqLNdtKWkTbYa8PVeL8KPb6VwmLw7MEO9/HKfo9rXSo7SUNnuwCq1qSUsdaCFH84Vexux1ufE1en2W5x96ypsKmsrJIXJFcmm9VgwppLI7eem7e6gJ7bkfW931t5VegztMKGYsrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anWllO5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C29C19423;
	Mon, 16 Feb 2026 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771255828;
	bh=Q0nzRau4nRHN+ewX6ak9EtbfCs2MmQX+VT8EFugOi5Y=;
	h=Subject:From:To:Cc:Date:From;
	b=anWllO5/6uor0WoQegjJWWxaVCM0T5JRVONU67jT+dHvrbQ68vUEydzkwm8UFo3tz
	 GjNO5aBuxgdyCiQ9rYMOki724C/tarGSjX5PqbojhCPd2rXsKMsSN2qiTuzBqofUHM
	 trHfkkrqVXpyxZ+/Watlcb7caMYsJjE/6nUTSyUUdsAlMgE6LNTAO0c4LUvLiQhKWu
	 HT1N8/LZbhyC80Tmb2jOrempn/kR/YUVUZzEhbeWWk7mwHmtq3N+Vdwg09D6grBZLZ
	 pVKMEtpFQ+tzkZYP2X/NvCSF3LUCr+89KbLUnF4T47jOC6ZWdp4ovmy4rFm21QRzo2
	 huvlME2lM+8jA==
Subject: [PATCH net-next v4 0/5] net: sched: refactor qdisc drop reasons into
 dedicated tracepoint
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Mon, 16 Feb 2026 16:30:22 +0100
Message-ID: <177125575993.2500844.8718737675156179479.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258909-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,appspotmail.com:email,linux.dev:url]
X-Rspamd-Queue-Id: 98A72145A0C
X-Rspamd-Action: no action

(I know net-next is closed[0] until February 23rd, but I want to
 give bots a chance to pickup this patchset for testing/review, and
 I don't think they will do that if I post as RFC
 [0]: https://netdev.bots.linux.dev/net-next.html )

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
to catch type mismatches during debugging.

This implements the alternative approach described in:
https://lore.kernel.org/all/6be17a08-f8aa-4f91-9bd0-d9e1f0a92d90@kernel.org/

Changes since v3:
-----------------
v3: https://lore.kernel.org/all/177039500964.2258217.2989656069254156812.stgit@firesoul/
- Folded patch 3 (CAKE cobalt_should_drop) into patch 1 to avoid
  temporary enum type confusion between patches (Toke, Paolo)
- Split tcf_kfree_skb_list() into inline wrapper + __tcf_kfree_skb_list()
  for fastpath optimization when skb is NULL (Paolo)
- Series is now 5 patches instead of 6
- Added Reviewed-by from Toke Høiland-Jørgensen

Changes since v2:
-----------------
Link v2: https://lore.kernel.org/all/177032644012.1975497.16411100029657607833.stgit@firesoul/
- Patch 1: Fix tcf_kfree_skb_list() to handle TC classifier drop reasons
  - syzbot triggered WARN_ON_ONCE revealing TC classifier's SKB_DROP_REASON_TC_*
    reasons arrive via shared tc_skb_cb->drop_reason storage
  - Use SKB_DROP_REASON_SUBSYS_MASK to distinguish qdisc vs TC classifier reasons
  - Pass TC classifier reasons through to kfree_skb_reason() unchanged
  - Reported-by: syzbot+ci335f183b8446659a@syzkaller.appspotmail.com
- Patch 5 (was 6): Fix compile error - add missing QDISC_DROP_L4S_STEP_NON_ECN
  - Reported-by: kernel test robot <lkp@intel.com>
  - Closes: https://lore.kernel.org/oe-kbuild-all/202602061240.CRDtcOeX-lkp@intel.com/

Changes since RFC v1:
---------------------
Link RFC-v1: https://lore.kernel.org/all/177022452988.1827734.5121740962985640333.stgit@firesoul/
- Added SKB_DROP_REASON_SUBSYS_QDISC subsystem encoding for enum debugging
- Added WARN_ON_ONCE to catch wrong enum type (skb vs qdisc drop reason)
- Renamed QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION (Toke)
- Renamed QDISC_DROP_FQ_BAND_LIMIT to QDISC_DROP_BAND_LIMIT
- Renamed QDISC_DROP_FQ_HORIZON_LIMIT to QDISC_DROP_HORIZON_LIMIT
- Updated SKB_DROP_REASON_QDISC_DROP doc to reference qdisc:qdisc_drop
- Split rename changes into separate patches for clarity

Series overview:
----------------
Patch 1: Introduce the qdisc drop reason infrastructure
  - New enum qdisc_drop_reason with subsystem encoding
  - New trace_qdisc_drop tracepoint with qdisc context
  - tcf_kfree_skb_list() handles both qdisc and TC classifier drop reasons
  - Split into inline wrapper + __tcf_kfree_skb_list() for fastpath
  - Convert qdiscs with drop reasons to use the new infrastructure
  - Fix CAKE cobalt_should_drop() return type for type correctness

Patch 2: Convert SFQ as example for reviewers
  - Demonstrates how to convert a flow-based qdisc
  - Adds QDISC_DROP_MAXFLOWS for flow table exhaustion
  - Rename FQ_FLOW_LIMIT to generic FLOW_LIMIT, now shared by FQ and SFQ

Patch 3: Rename QDISC_DROP_FQ_* to generic names
  - QDISC_DROP_FQ_BAND_LIMIT -> QDISC_DROP_BAND_LIMIT
  - QDISC_DROP_FQ_HORIZON_LIMIT -> QDISC_DROP_HORIZON_LIMIT
  - Remove local FQDR() macro, use full QDISC_DROP_* names

Patch 4: Rename QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION
  - Generic name without embedding qdisc name

Patch 5: DualPI2 use qdisc_dequeue_drop() for dequeue drops
  - Demonstrates dequeue-time drop handling with trace_qdisc_drop
  - Adds QDISC_DROP_L4S_STEP_NON_ECN for L4S step AQM drops

Jesper Dangaard Brouer (5):
  net: sched: introduce qdisc-specific drop reason tracing
  net: sched: sfq: convert to qdisc drop reasons
  net: sched: rename QDISC_DROP_FQ_* to generic names
  net: sched: rename QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION
  net: sched: sch_dualpi2: use qdisc_dequeue_drop() for dequeue drops

---

Jesper Dangaard Brouer (5):
      net: sched: introduce qdisc-specific drop reason tracing
      net: sched: sfq: convert to qdisc drop reasons
      net: sched: rename QDISC_DROP_FQ_* to generic names
      net: sched: rename QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION
      net: sched: sch_dualpi2: use qdisc_dequeue_drop() for dequeue drops


 include/net/dropreason-core.h  |  48 ++------------
 include/net/dropreason-qdisc.h | 114 +++++++++++++++++++++++++++++++++
 include/net/dropreason.h       |   6 ++
 include/net/sch_generic.h      |  43 +++++++++----
 include/trace/events/qdisc.h   |  51 +++++++++++++++
 net/core/dev.c                 |   8 +--
 net/sched/sch_cake.c           |  26 ++++----
 net/sched/sch_codel.c          |   5 +-
 net/sched/sch_dualpi2.c        |  18 +++---
 net/sched/sch_fq.c             |  10 +--
 net/sched/sch_fq_codel.c       |   4 +-
 net/sched/sch_fq_pie.c         |   4 +-
 net/sched/sch_generic.c        |  29 ++++++++-
 net/sched/sch_gred.c           |   4 +-
 net/sched/sch_pie.c            |   4 +-
 net/sched/sch_red.c            |   4 +-
 net/sched/sch_sfb.c            |   4 +-
 net/sched/sch_sfq.c            |   8 +--
 18 files changed, 278 insertions(+), 112 deletions(-)
 create mode 100644 include/net/dropreason-qdisc.h

--


