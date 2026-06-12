Return-Path: <netdev+bounces-298424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k5mpI7JdK2qD8AMAu9opvQ
	(envelope-from <netdev+bounces-298424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:15:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 815FF676122
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:15:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="S20/LuN8";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298424-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298424-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C8CA3000598
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C12E7391;
	Fri, 12 Jun 2026 01:15:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A82AE78
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 01:15:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226922; cv=none; b=KSPs6A8vUTUm4MFn7ac6PdiT52rCe2D29QmKMspS/agFBE4IFgIJFCaOUwwUAtBLobaLc/qMnwWXgLdID05jgxgsuUxKgID2U+p/FR1Jl1ppls7g22+5VbXyMUsqzVpMBW8iqGaKCRZioRryZ0223HoXEqAQ/jcSJJdFY7I3flY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226922; c=relaxed/simple;
	bh=V5Ji/NbotjurvNaHKkaocD+v8CNqcnqv7GAUeTEbeKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lwv808ZDIbcUUVP8PMxKh4VvPmzzz7LIqfizS8sG9Y4q2iyE1CXgjR/n3JWqv1FXHMBXY04sEWmdLjK0BjcYzTQ0TUirPXAMinA1ZVIdcsux3fvDZTKho+kEw7NXNALgMA0Nz4zGWQnSoRZ/ErSf5LuIUupwP7OaCAQGi+60tLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S20/LuN8; arc=none smtp.client-ip=74.125.82.41
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-13832028e9fso413943c88.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226920; x=1781831720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lq4yPWnUXbIU2vFF9P4WExiS18HxKoN6rV5qe+S+suM=;
        b=S20/LuN8PPgMvvnqfxT7/IK+q/Cga3NYPnU8pbVahqvR+zZpKnpilHMKvvHoGR6E0C
         gCt+xyEOJc6mDX4BivJlq3slLuSCfYpTVkTaRC+l4rcOwdpBTl8Q9wW+Mmkeqbb5R0G2
         7r22pXT6gag65obcK/9G9GHX5uzkXLiaN0Hn7rNAugs/HCpw/sLq+kpqeDyPKmI683Ph
         Kwu3SONNpLPuFa+LZw8MmAtypuDX7LArdTlS6PXEBQ2/UXxaU75PUCsJnu43JvokPOzf
         91GMioutnhXO2mbuhZnY2vZ2ttk93L3iuPLNj3ui1Z2/R04e+j8LMHfZB7XGOoX6w2Wc
         i1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226920; x=1781831720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lq4yPWnUXbIU2vFF9P4WExiS18HxKoN6rV5qe+S+suM=;
        b=DbcJRqcVHdry7z93RkPTYjfNgRcg5bCnZSgQMmaZTlcxUxZo3J82jCuxN8qUjCDKLe
         x9U5c5RnpQ9DHcNRlMrwLQspf1jrVqxNwYxvhC4SK650eMQ1nlFRWJytdQnGMvBA+t9f
         uBoJEzL7VzTuTyDopPbBix7nZnkRCa/3j4GU3+6tSi2sinn3K1ZepgTOgiitkuLcGEF7
         xvk2aGvhXjp1TtLIxC5yhhXm+fuUQi7fwZpFOD8K5j4Jt6mAU3wyAg9ewvNTIK8HW9AZ
         aLLw5ePgjxdnwvnf4jwXj9v6gAyQN+VHNsJ389tUY7MafuoVKUe3rzifqmfA/zoEKYG4
         EENw==
X-Gm-Message-State: AOJu0Yw3+zIlwB7bBiHfuOKWlAvXsYwxTthxT1Rqxn7PMQ6f2IiL+zQs
	2ROry+9eGVOozSObFn2fTnoUyNGpAUo6T48wjT1gZ5nF9Z08hSR0SW5B4WDgbA==
X-Gm-Gg: Acq92OHqlqhhCBRyrBYE4Asj3299jQanEvm6Tk4Gpzp+VClKdD21AROjvTi11bqLOT0
	QS+xTrdDDKrBhY73gaG09lQxw0MICsOOdL0L0qYZOu8wh7/O16/e12ZuGk0KQnNAwoL5BVjDfVd
	u/27cH1QwiAd7HL7jX33aUOwNS9Q26WNbPtZGpJR3mI5dnRxJzP8ZUDQIv+rIHMNryK7rUbRo89
	RjTYwWdlglTnfrnveTzYzPaHVmBy+4qkg9A6NF926EJABeGm09q9YiGy9u7S98JoiH7gDpSsnzv
	qcEq9IjGartvcaK4t4D0H1P4uZJ+TYoau+atL4b6p06vBjD7YbZlmEcD7zC0Qd9s5ilmixpRYEk
	ZX6ONv0G8VEHO1o+9b8CJKeTsojjzlHAHbJRnHUSVOZozkM6GWDTkA/wJusjk5CMs4WFKYJhMTU
	Kf/5Wzf/utDecVhYLLDGsK3pgiioR67CXo/Pm6SfQEKeUHkoZEmF/RkhQ7kOkUW5Zg8g==
X-Received: by 2002:a05:7022:41a1:b0:136:5c88:d928 with SMTP id a92af1059eb24-1384bb74299mr276844c88.19.1781226919626;
        Thu, 11 Jun 2026 18:15:19 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b975e55sm596257c88.13.2026.06.11.18.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:15:19 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	hemanthmalla@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for BPF-paired sockets
Date: Thu, 11 Jun 2026 18:14:47 -0700
Message-ID: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,linux.dev,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298424-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:hemanthmalla@gmail.com,m:zijianzhang@bytedance.com,m:xiyou.wangcong@gmail.com,m:johnfastabend@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 815FF676122

This series adds an opportunistic "loopback splice" fast path for two
locally-connected TCP sockets that a sock_ops BPF program pairs at
handshake completion. Once paired, sendmsg copies the user payload into
a per-direction in-kernel byte ring and recvmsg drains it on the other
side; both copies happen in their own task's mm, so the fast path incurs
no skb construction, no softirq, and no TCP protocol-state processing.

The underlying TCP connection stays fully real: sequence numbers are
frozen at post-handshake values, so FIN/RST/keepalive keep flowing
through the normal paths and the pair tears down via a regular close.
Pairing is opt-in per flow and fallback is per-message - handshake-style
traffic takes the TCP path, the bulk phase takes the ring, on the same
socket. Nothing leaves the host and applications need no changes: no new
address family, no LD_PRELOAD, no source modification.

The target use cases are co-located endpoints that speak plain TCP:
 - regular TCP loopback (127.0.0.1) between processes on the same host;
 - container sidecar deployments - e.g. a service-mesh sidecar proxy and
   its application in the same pod, talking over loopback or a veth pair -
   where the per-skb veth+bridge cost is exactly what the ring sidesteps.

Highlights (TCP_RR, 1 KB request/response, netperf, pinned CPUs,
baseline TCP vs splice; full tables across message sizes and TCP_STREAM
in patches 1 and 2):

  loopback (127.0.0.1):
    without busy-poll:   105.8k -> 235.1k tps  (2.2x)
    with busy-poll 50us: 106.1k -> 713.0k tps  (6.7x)

  container (netns + veth + bridge):
    without busy-poll:    99.9k -> 233.9k tps  (2.3x)
    with busy-poll 50us: 100.4k -> 704.9k tps  (7.0x)

Synchronous-RPC (TCP_RR) at a 1 KB message wins ~2.2x without busy
polling and ~6.7x with it (the win grows toward smaller messages and
narrows toward 64 KB), because the ring removes the per-cycle kernel TCP
receive-path cost and the receiver can spin on the ring directly -
loopback delivers via the per-CPU backlog and exposes no pollable
napi_id, so the generic sk_busy_loop() is a no-op there. Bulk streaming
is roughly neutral on bare-metal loopback but wins decisively (up to
~6x) container-to-container, where per-skb veth+bridge cost dominates
the path the ring sidesteps.

---
Cong Wang (5):
  tcp_bpf: add bpf_sock_splice_pair kfunc for opportunistic loopback
    splice
  tcp_bpf: busy-poll the splice ring before parking the receiver
  selftests/bpf: add tcp_splice basic round-trip test
  bpf: allow SO_BUSY_POLL in bpf_setsockopt()
  selftests/bpf: set SO_BUSY_POLL from the tcp_splice sockops prog

 include/linux/skmsg.h                         |   9 +
 include/net/tcp.h                             |   8 +
 net/core/filter.c                             |   1 +
 net/core/skmsg.c                              |   3 +
 net/ipv4/tcp_bpf.c                            | 847 +++++++++++++++++-
 .../selftests/bpf/prog_tests/tcp_splice.c     | 206 +++++
 .../selftests/bpf/progs/test_tcp_splice.c     | 125 +++
 7 files changed, 1198 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_splice.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_splice.c


base-commit: 30dee2c176e7954f63d1fa3e52d172f30beb9bfb
-- 
2.43.0


