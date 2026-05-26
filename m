Return-Path: <netdev+bounces-291760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FowJQzKFWpEbgcAu9opvQ
	(envelope-from <netdev+bounces-291760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:27:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 221C85D9AE6
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 551DA3211808
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7F736F433;
	Tue, 26 May 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THwnRz23"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432AD30C14C
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809849; cv=none; b=MR0/h1ubYZHK+lj8dKnXA72C8guxru0vJMJv1N6clWO/sK+dBg9DiGGTgs/eVWwgm3S+khkQ9ASVQ3eKsbw3TDHWkWbq2SjDZ1KJF4N8UMkP7bKQG6EUjUwU7RP5BkVpANgZdth0hJKjmoocbG83qptEe7rfBwQ7fxLaK0LmEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809849; c=relaxed/simple;
	bh=SuNCKboR9/qMnKV199RmrKzsF4XnE5gzMhvdzv4lxUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l8Ge+QgB+2h5R4dz23nkVZKVqo/fu99ILk/Jhqa9bCXq2SmG6RCPyK/FknaYg7ZMq4sH3QVEkVx3ZfXKcIH7xDCZ2bD3XSFE85wQKs0cuakniJqqS/Hu+JDAi3qtdeinjVIL6ZbtJ3ihEWK3RCicbfsfOXmDcPy04f1oEQbv8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THwnRz23; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so57432915e9.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779809845; x=1780414645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mEu5haSOg9MswhbLQuLwhfuoJ04JYV0iIkWmF1VBvMA=;
        b=THwnRz23QIb8MlYwi5JtG5bkdDs9Bb1cegJXxDqRk0E6fzuwcgwhOlrRwFvYh8vP4x
         m97WkxMQRiMvArFFI2hH14L6OaPYPHYacb+EydXMq784G9v0pfvZH877tUizrEz9esGV
         qtPTHnIGVoIGgpIXnLWG7FXCb4kZCMnXvC4uy1FCx6sB/bg8tUVlxIOWmeBY9/+T/KHi
         ilKrqekNGIAS/U2m7vIzCIJkkIgl0X8bSlwwkPzd2eh1FFOR8XKHRl1+YV5OexCw/ae1
         b8H1Nk+oRS/hbNAikxPFY0vKOlzlfx7p24qaUcycR1oxzHn75s0PmYRLcBw+/Dtg6rYp
         rGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809845; x=1780414645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEu5haSOg9MswhbLQuLwhfuoJ04JYV0iIkWmF1VBvMA=;
        b=sxcmVNcttyAJaNs97G/wta3jxvCB3Za7qcMAzUQUdI7KxlPYmfurFs2SBeZKrcWMCD
         oIewsf4EHLAnzVUWT83rzIhUhwsOFQITgWcbeIv6Td+mtZvSNgmPo01r21PG0STDKsYs
         L1O2JxhAGXM09olQa4RpyTNS9myTHlnPfUhokiAJAWe1RqVln53kgMblUarj3nntE4jY
         O8zAR9EcbJ6xsO+AELHUTrjUobJhvN13BFZf94oXlX3pfhdbW1f5lNqOSkTYrQbrha0A
         uuKouv9JaPLnmwsoWq8VAIdmOhjZvvkosyMmdItfYIJprYG2T7szp3PkZJZcd9ztE70n
         3wdw==
X-Forwarded-Encrypted: i=1; AFNElJ9vxEuhBrmq6tv3sgA6pQWtMxnrrORBfIvqTAp5HUhSIXPHBVFIPbWXnel7WKW00aSKyP1ZAW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+AwlV61iwUppoq5iycxiNGKzrDmv/qgUAI2bD5pXm05tpga9
	9YPir+6fzmWzDcvM6PNQmYe6qxxpWri9Ko9lQL5V7pM83wz5WASoWsbi
X-Gm-Gg: Acq92OE1FkU+auwIiPUZd7AHlys/RwVU2lgHWHuu1VtSZxoznwfvI/vslT7bVNcWKng
	/X0Gn20qp5hj2/XTIIM0rroWh/gUa6sjqOdkJRWkpO14tNF1Zsp41rIoLP5odHXGXbW8vwvAyHD
	/I4EFDWmu4Xh6jlggqFAgDi2HBRVKlWQCNKLmDnlBf1EpoxMBydiMlqVWkBu+h1WMs/zmDvSf0/
	coXxY3cdJpfJ7XnbESSR/E1iiXVxtn/Yc7moHOHFmG3HevNsT8vs5AJCuBXzW1K9UnP1ga4WIjQ
	SmBguPq7oGC9UB/cK2gWk7fkkBrvh3FxuAgbPaPl5+9IzBt5Y+pnCYELuzgir7YWP4djafagC6q
	kZot2UMu2BXugcttZM0YKTvDdp0d1mrQdjN09ti3eNaccoo1lgJ1W5ivVdufjGK176JqRtKIfX/
	DdzfpWb1NG5/JgRGKU2+0iHNAFs4w=
X-Received: by 2002:a05:600c:8484:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-490426cd8c4mr338065445e9.20.1779809844415;
        Tue, 26 May 2026 08:37:24 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4907df9edeasm1083655e9.9.2026.05.26.08.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:37:23 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v7 0/7] bpf: add icmp_send kfunc
Date: Tue, 26 May 2026 15:37:01 +0000
Message-Id: <20260526153708.279717-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,vger.kernel.org,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291760-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 221C85D9AE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This is v7 of adding the icmp_send kfunc, as suggested during LSF/MM/BPF
2025[^1]. The goal is to allow cgroup_skb programs to actively reject
east-west traffic, similarly to what is possible to do with netfilter
reject target. Applications can receive early feedback that something
went wrong during the TCP handshake.

The first step to implement this is using ICMP control messages, with
the ICMP_DEST_UNREACH type with various code ICMP_NET_UNREACH,
ICMP_HOST_UNREACH, ICMP_PROT_UNREACH, etc. This is easier to implement
than a TCP RST reply and will already hint the client TCP stack to abort
the connection and not retry extensively.

Note that this is different than the sock_destroy kfunc, that along
calls tcp_abort and thus sends a reset, destroying the underlying
socket.

Caveats of this kfunc design are that a program can call this function N
times, thus send N ICMP unreach control messages and that the program
can return from the BPF filter with pass leading to a potential
confusing situation where the TCP connection was established while the
client received ICMP_DEST_UNREACH messages.

v2 updates:
- fix a build error from a missing function call rename;
- avoid changing return line in bpf_kfunc_init;
- return SK_DROP from the kfunc (similarly to bpf_redirect);
- check the return value in the selftest.

v3 update:
- fix an undefined reference build error.

v4 updates:
- prevent the kfunc to be called recursively and add a test (thanks to
  Martin).
- do not fetch dst route when unnecessary (thanks to Martin).
- extend the test for IPv6 (thanks to Martin).
- use SK_DROP in examples and use non blocking sockets for testing
  (thanks to Martin).
- test when the kfunc returns -EINVAL (thanks to Jordan).
- add the kfunc to bpf_kfunc_set_skb as suggested by Alexei.
- guard the IPv4 parts with IS_ENABLED(CONFIG_INET).
- fix a wrong initial value for client_fd (thanks to Yonghong).
- add documentation to the kfunc.
- to Jordan: I couldn't include <linux/icmp.h> because of redefines from
  <network_helpers.h>.

v5 updates:
- kfunc name is now icmp_send and takes the control message type as
  parameter for future potential extension (daniel)
- drop the net patches to route packet since now the kfunc is limited to
  cgroup_skb and tc progs (daniel & martin)
- linearize skb headers (sashiko)
- zero SKB control block (sashiko)
- bind to port 0 instead of fixed port (sashiko)
- poll to wait for POLLERR event (sashiko)
- do not use ASSERT_EQ in CMSG_NXTHDR loop (sashiko)
- fix comment about byte order (sashiko)
- fix endianness IP address issue (sashiko)
- add forgotten cleanup_cgroup_environment (sashiko)
- let packets pass in recursion test (sashiko)
- clarify evaluation order for recursion test (sashiko)

v6 updates (all from sashiko):
- bring back the net patches to route packet since tc ingress needs it.
- rename the ip_route_reply helpers from fetch to fill.
- call pskb_network_may_pull on the cloned pkt.
- check explicitly that we received one and only one ICMP err ctrl msg.

v7 updates:
- use consume_skb on success path (stanislav)
- replace recursion protection with CPU_ARRAY by checking the nature of
  the sk (daniel, offline)
- use reverse xmas tree in read_icmp_errqueue (jordan)
- use ASSERT_OK_FD instead of ASSERT_GE whenever possible (jordan)
- add a test for tc (jordan)
- better filtering from host cgroup test progs (sashiko)

[^1]: https://lwn.net/Articles/1022034/

Link to v6: https://lore.kernel.org/bpf/20260518122842.218522-1-mahe.tardy@gmail.com/

Mahe Tardy (7):
  net: move netfilter nf_reject_fill_skb_dst to core ipv4
  net: move netfilter nf_reject6_fill_skb_dst to core ipv6
  bpf: add bpf_icmp_send kfunc
  selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
  selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests
  selftests/bpf: add bpf_icmp_send kfunc tc tests
  selftests/bpf: add bpf_icmp_send recursion test

 include/net/ip6_route.h                       |   2 +
 include/net/route.h                           |   1 +
 net/core/filter.c                             | 109 ++++++++
 net/ipv4/netfilter/nf_reject_ipv4.c           |  19 +-
 net/ipv4/route.c                              |  15 ++
 net/ipv6/netfilter/nf_reject_ipv6.c           |  17 +-
 net/ipv6/route.c                              |  18 ++
 .../bpf/prog_tests/icmp_send_kfunc.c          | 243 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c | 172 +++++++++++++
 9 files changed, 563 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c

--
2.34.1


