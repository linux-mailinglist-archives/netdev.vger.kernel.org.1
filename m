Return-Path: <netdev+bounces-279707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKydH+sG5mkIqgEAu9opvQ
	(envelope-from <netdev+bounces-279707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:58:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CA1429AB3
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65466303075B
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB0439C00B;
	Mon, 20 Apr 2026 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqqLys1i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0539A809
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682714; cv=none; b=VxJ/3QvGyvQQN+PxEvn/xRBmRYooKnwg0pJGMGiLdDiodMkvWbQTJj/qrydeZy4dnTYHebU0uI+NmKYDCELjr/W94e1MzW9+FOI83O7LwhQaBmR+gglklJ2N1nzA7qRjT47Cdn47nEJMz7KdS1c4qGqL+TvcIcE+mY+/8RVfCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682714; c=relaxed/simple;
	bh=jeNe6hoVFvSWp1WGUu4CvjQgGHlygFkkp2Jz+ownf9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ck9NbhIWV6Xb/L3FYZS/2939XEMgL/BPC3NZnxdRvo8t2lQmbcQ7RhBh3wcVqknDuYivO2IOwPCaJ3oM27bhay8eZSLozOPTSUOEUuUjJxfB3+3pqDgwETv18N8FeebmY8HVUdCOWGRF6aZLJxCdlyu554xkr3Gk5dHvDlTxUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqqLys1i; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891cd41959so8416295e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776682710; x=1777287510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSip2mFo5UpUa5K/ga6S7Tqbsc6g4uU5VZLY4tip40A=;
        b=TqqLys1iJM4sTOPZfTjaqobStjkvZ/Zpiln+pUcYqaiSTBaK8amwfTrhA5c3N4DP/A
         yqEtJdQ2jnXB8Do28HaagK3G+WSgmqcNdOvZ6jGEqOul3tlAnFtLPTOV7OID865vcU8n
         u641aYqnr7amhEY9t5qBHFtnXWlE88jhRB52ThSCGm1fJ3v5YOf114t4JNabJ0G+pTSX
         DCCy8ajmrI48NF+FQE07lw7UXRKESBeCWDU1OjJ2nqIqHxKeNa2+B2I5gOX5BqzXt/BL
         J1k/XwXmNeO6CmQGksPfr3QbDMphxDIgllEjAXtfSEXCKtqZm5v8h7NE+C0OEcOKmBm9
         PNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776682710; x=1777287510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSip2mFo5UpUa5K/ga6S7Tqbsc6g4uU5VZLY4tip40A=;
        b=HV9nwjMfsnDFWMfl9ZEz48ol5OxrmTpUx1DpVDi1rA+tRKCE6OnfvraZ20XkmGh2J1
         ujsnXAEYtXu8X7YS2Ajd+1u+8Ww30VWDXk8cqrL2SF94GD0x2klwtiNrlwoxWUsXvsCH
         1zmTdfmAa0Ty3vJi6QWBD1F/XAM+otvez+Rtd6jfvFu2pNrQN93oYAdV885WYH9sqj/T
         4MRmP07qiNVG40dYd3mIhk9QFJmj7F7dJ3JH/A4niLCM/MVE6WSIX67CzaNwO7ahOSCk
         sYMulU03h+gRYe84iSPF/lrvvwUlk9MqroVactHlen4rKJoKFT9whGYdwOG25clj1KpE
         ZLKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VaEpNxO8EaBZM90q1hltTet+TZ5YIVNsodI+TKGgPoAI6asRX2MM9kToXOTsSwjBXL7++Y/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza9DgmHvKHCK9HrmDlpZV/yfCDZFIN6hw4mjXDXc5gdZnThzCH
	9wna7/l2e0IpllbOTvQ6idwIAqH7YarlQdOulQCAtZWX5I60vzZmiiG9
X-Gm-Gg: AeBDiesaLQFquRcUEVCSRHYve88PKvLXYEwppdH+4VSryIGW8SyBw3Et1Iq7AP7zdeg
	gYy53RFoBYlZlgTn1b60W7BajQPaP6c8aI1ctKbVY70NYo7R1J9gAakGLMvci3GyrU3lXvFfnnn
	lSYrUF1gCh2Gj3s4oLMXNxPP4QqFe+8sMqGQ5ro4sW5eNH2XlaWYzbC8MPKg2Jqc+NCkx54IwpI
	XBK/jmC9w3kgM48AVPlFb2mdenO85aks9JnR+t+yY7spcgT3iU8HH+Ge/2VnN940mB7OYF8n4+7
	zudTa1fEnQOSRz0V70ya++Hgg7ydY+N+CVPmpLy8t6yXGHRo1tbsqw11qBUwlLoC45sBW+/n5aW
	c4ClAEwrSj++772ysqiPO6REsCTQChMNsczPGjaY8Us+2mBGkWos20O9tcEvzOQo60bTqSwCHv+
	XMCXT/7ubhbnnr3FN/xSU+HlB3khdG+htdqV+6Jw==
X-Received: by 2002:a05:600c:c108:b0:488:a82f:bbb6 with SMTP id 5b1f17b1804b1-488fb78e576mr125872725e9.27.1776682710104;
        Mon, 20 Apr 2026 03:58:30 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm290929495e9.15.2026.04.20.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:58:29 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: mahe.tardy@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	daniel@iogearbox.net,
	fw@strlen.de,
	john.fastabend@gmail.com,
	lkp@intel.com,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: [PATCH bpf-next v4 0/6] bpf: add icmp_send_unreach kfunc
Date: Mon, 20 Apr 2026 10:58:10 +0000
Message-Id: <20260420105816.72168-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aI0MkNvWlE4FXMV8@gmail.com>
References: <aI0MkNvWlE4FXMV8@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,netfilter.org,iogearbox.net,strlen.de,intel.com,linux.dev,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279707-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 16CA1429AB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This is v4 of adding the icmp_send_unreach kfunc, as suggested during
LSF/MM/BPF 2025[^1]. The goal is to allow cgroup_skb programs to
actively reject east-west traffic, similarly to what is possible to do
with netfilter reject target.

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

Initially, this kfunc was added only to cgroup_skb programs, Alexei
suggested not creating its own kfunc set and adding it to the more
global bpf_kfunc_set_skb. Now that recursion is handled and I realized,
thanks to Martin, that fetching the dst route might be only useful in
situation in which the packet was not yet routed, I decided to extend
the kfunc to more program types and route the packet only if needed.

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

[^1]: https://lwn.net/Articles/1022034/

Mahe Tardy (6):
  net: move netfilter nf_reject_fill_skb_dst to core ipv4
  net: move netfilter nf_reject6_fill_skb_dst to core ipv6
  bpf: add bpf_icmp_send_unreach kfunc
  selftests/bpf: add icmp_send_unreach kfunc tests
  selftests/bpf: add icmp_send_unreach kfunc IPv6 tests
  selftests/bpf: add icmp_send_unreach_recursion test

 include/net/ip6_route.h                       |   2 +
 include/net/route.h                           |   1 +
 net/core/filter.c                             |  85 ++++++++
 net/ipv4/netfilter/nf_reject_ipv4.c           |  19 +-
 net/ipv4/route.c                              |  15 ++
 net/ipv6/netfilter/nf_reject_ipv6.c           |  17 +-
 net/ipv6/route.c                              |  18 ++
 .../bpf/prog_tests/icmp_send_unreach_kfunc.c  | 202 ++++++++++++++++++
 .../selftests/bpf/progs/icmp_send_unreach.c   | 100 +++++++++
 9 files changed, 426 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send_unreach.c

--
2.34.1


