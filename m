Return-Path: <netdev+bounces-302555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0bWRM71HQmoJ3wkAu9opvQ
	(envelope-from <netdev+bounces-302555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:23:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 220826D8DD5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:23:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=ggLBy4V1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302555-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302555-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA74302B0B2
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986D3F9F5C;
	Mon, 29 Jun 2026 10:22:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACEB38F947
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 10:22:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728535; cv=none; b=WhoAk0rUJGHr7FJigiCgRyQv/dHyH1yyiI16gX5usLibWILOTlZ04axkx2GB7L2gf/ethLYOAq0gAFutjLlybsxK6L0h1+IIWMb2gBgH1eQeluktuxfuHH9nk2gL6ojrhL6PQffELuBusDm/GSPc2GsWZ85d4ZpsQTs5xnTV9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728535; c=relaxed/simple;
	bh=jwLgLR3nYwBK3/BuT+gD2ATqKLN7xJeOS1tgrZOALpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eI3rlA91BKJ9ar7ZJfLVaxH/9YiXpFoVTvHJv5FP0djeXmv6auP1AGcnAhDr2fbDUdtHtk5SFaOZkvp4WyQJYteWwPChPHeG3CqGsxyG41Do0yuHKiHA3GyYsroghbTSwXGqhgaTIMl4p5dDOcgSY7kuKgYErM0sJTO5e2/gvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ggLBy4V1; arc=none smtp.client-ip=209.85.219.54
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ee7cd05e24so23284536d6.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782728532; x=1783333332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6OASslZi7YxFlKXAz00T8+s1qFuKwk4pzWc3ZIqweI=;
        b=ggLBy4V1W0LbmCKi/2CazVXEZUlnFpJGI7IpQ8C6hf43LMGWg/y7xDO/AhVIeGzdo1
         dzRfWThPGyMVVqXzjBzn3MXV6fAAhGbtBNGSrW857aOqnM/vmGhwBQGTVuz78M5HnBVE
         NmOVH3a8r94j03HImkuz6qObCE09I1qRiuT+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728532; x=1783333332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6OASslZi7YxFlKXAz00T8+s1qFuKwk4pzWc3ZIqweI=;
        b=WdtcUTcwLl/KvxuDmXbB/B8fhoJYQJY4QIV/4dE4XMLkBzJRbbp2MLOfeY4wLfBg5L
         1yqs0d1Be/WgCkyaPNvEmluwTQGm1gEbLbpucpzSNybACdIki2ImTgnzGFNQLWZUITzi
         x/798EQbVvUe7XYM1ZhlEFmFmptHdXRhLfueXZZgurpfpLjl0mLiXI4OYB4FNsNm619e
         JMhXMFYi4bl3azXlVTdFX757lnECllNz19EZA98eDijODqowMqatbBHb7Bia+cVsNDDq
         BjxTYIQjxRZxtEvkinBzVWrAdgKNUAAmytgKXgkxeQId9rZyf41Rh5GtBLGUzM5gCGua
         1iZQ==
X-Gm-Message-State: AOJu0YyGHRmR6CicuXov2TWtCtRxfIWKBaoxp6cHy/RO3krwMKwNTSmt
	KWgOPOW/a1xIMqj9EGLsGex3SrLbFoDtKpB+LfXFgTGKPsyz3oI4ySkJ0CpE8hcZ81oaFTx1EiO
	Z0EE=
X-Gm-Gg: AfdE7cl86L1vfQIFteVSjytIP4m5b7D65szqmWgNqhX1RAHB3yhb82lMBAbE+2gbcDs
	arDl/32uQRS2qwEUCvt/Rrfla/uwFNKYuyv/VnkPwu1n/PEPUP4OEx4bPJzugLpE4Il9EXR+Xw7
	JgM5qZqtPVHjcjUkeNslOXx4Mi8DQkpuK8AinNIw2m4tg9Y5DcJwKwNDPkheedeSr57tvj1kCNN
	i5OtJ+CJTE563Pc+FrY4Ozmu+7m54ZSe9hftiGHtIi7bXQOZY+/SkLR1xpX2QBjICnaJ1jBWKAT
	K8cPmu5FjZCbAXLFPZKqdIEYIJZbZMLUmL1aXJZlgAd2JQyLhV01ZEtukfxbLxDRsiM6WQRkmEy
	8KC0666FWfseG3SHCp4fSh4s053dTjQkajhm4B53NcZhEybDgZ3xuzw35jVfz5SS7vUeAcR9rPV
	8KFxx5xA==
X-Received: by 2002:a05:6214:194c:b0:8ee:df58:e5c5 with SMTP id 6a1803df08f44-8eedf58e938mr95782096d6.20.1782728532334;
        Mon, 29 Jun 2026 03:22:12 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ef0f2b9df0sm53589236d6.13.2026.06.29.03.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:22:11 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	toke@toke.dk,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Machata <petrm@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 0/3 v2] Fix broken TC_ACT_REDIRECT
Date: Mon, 29 Jun 2026 06:21:54 -0400
Message-Id: <20260629102157.737306-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302555-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:toke@toke.dk,m:rostedt@goodmis.org,m:petrm@nvidia.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:linux-rt-devel@lists.linux.dev,m:bpf@vger.kernel.org,m:security@kernel.org,m:stable@vger.kernel.org,m:jhs@mojatatu.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,toke.dk,goodmis.org,nvidia.com,iogearbox.net,gmail.com,lists.linux.dev,vger.kernel.org,mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,mojatatu.com:dkim,mojatatu.com:mid,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 220826D8DD5

When sashiko-gemini[1] reviewed commit a8a02897f2b4
("net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle") it
 correctly pointed out the following:

"
This is a pre-existing issue, but does executing a redirect via a qevent
filter cause a NULL pointer dereference?
When tcf_qevent_handle() processes a TC_ACT_REDIRECT, it calls
skb_do_redirect(). This eventually calls bpf_net_ctx_get_ri() which
dereferences the task bpf_net_context:
include/linux/filter.h:bpf_net_ctx_get_ri() {
    ...
    struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
    if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
    ...
}
Since qevents are evaluated during enqueue, which runs within
__dev_queue_xmit() after sch_handle_egress() has already executed and
cleared the bpf_net_context pointer, will this dereference a NULL pointer?
"

That issue is fixed in patch 1. See the commit log for details.

Upon further investigation it turns out that TC_ACT_REDIRECT being returned
from the egress qdiscs never actually worked. When an action returns that
code we would silently loose it and the packet will never be redirected.
After all those years, if nobody complained, my gut feel is it was never
used by anyone with serious need for it.
Patch 2 fixes it by 1) putting a warning out when someone does and 2) asking
the core to drop the packet. At least this would help whoever is
misconfiguring to diagnose the issue much faster.
I had initially attempted to "fix" this and make it work, but unfortunately
it's a bit ugly so i left i didnt think it was worth fixing

Apologies for the shotgun Cc - its what get_maintainer.pl told me to use.


[1] https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojatatu.com

---
Changes since v1 (address 3 sashiko comments):
1)Patch 1: Address pre-existing issue to cover asynchronous qdisc enqueue
  operations in particular if bpf_redirect() is invoked from an attached
   ebpf program (the helper invokes bpf_net_ctx_get_ri())
https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojatatu.com

2)Patch 2: Explain in the commit message that it is actually design intent to
  remove TC_ACT_REDIRECT from tcf_qevent_handle().
https://sashiko.dev/#/patchset/20260626165156.169012-1-jhs@mojatatu.com?part=2

3) Patch 3: be explicit with $EBPFDIR
https://sashiko.dev/#/patchset/20260626165156.169012-1-jhs@mojatatu.com?part=3
---
 net/core/dev.c                                  | 31 +++++++++++++++----
 include/net/pkt_cls.h                            | 13 +++++++
 net/sched/cls_api.c                              |  6 +---
 net/sched/sch_cake.c                             |  2 +-
 net/sched/sch_drr.c                              |  2 +-
 net/sched/sch_dualpi2.c                          |  2 +-
 net/sched/sch_ets.c                              |  2 +-
 net/sched/sch_fq_codel.c                         |  2 +-
 net/sched/sch_fq_pie.c                           |  2 +-
 net/sched/sch_hfsc.c                             |  2 +-
 net/sched/sch_htb.c                              |  2 +-
 net/sched/sch_multiq.c                           |  2 +-
 net/sched/sch_prio.c                             |  2 +-
 net/sched/sch_qfq.c                              |  2 +-
 net/sched/sch_sfb.c                              |  2 +-
 net/sched/sch_sfq.c                              |  2 +-
 tools/testing/selftests/tc-testing/action-ebpf   | Bin 856 -> 9072 bytes
 tools/testing/selftests/tc-testing/action.c      |   5 +++
 .../tc-testing/tc-tests/infra/qdiscs.json        |  32 ++++++++++++++
 19 files changed, 87 insertions(+), 26 deletions(-)


