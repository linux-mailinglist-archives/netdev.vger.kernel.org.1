Return-Path: <netdev+bounces-302763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GtRuApO1QmojAAoAu9opvQ
	(envelope-from <netdev+bounces-302763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:12:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 560936DDF07
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:12:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=SjIl5Cjy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302763-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302763-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D51F302659F
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D3333EB06;
	Mon, 29 Jun 2026 18:12:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3F3EEC0
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:12:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756751; cv=none; b=hRmgPMwWyMFS7n0gc4nOySPS+5JCXg04PQ/VhJdlpy5lsXDzRc37Frs0lRRUzxGTimr+eJ5Mi34q4Y1XupLrkwaJmH8MHehxIdgmRhanPt3y0lqgr8Um5Dq0b+SYBpNG7MyzgEAHfpHJofXzdPrzpmgS6v4t/lzGf065K6/lEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756751; c=relaxed/simple;
	bh=qXi7kUB3Mej4owqMmoz5IVcHy5Y2hLGV57IdSbid1wk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ixhALREFOYghxPAwM8xGucg6/LdsYMxhG0GeZwtYWl+4jxaxoVg6zYp4lPfsywTn9xf1L6/tEjqDkga/dmD4UlhWsRehYzMQLxa8hSPiAJcxnyf2PqbwjQdtdJfkys4oUNKXZ8FbR58ewazt8oluIYEmQdmJ+ZWOB345QfNS9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SjIl5Cjy; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c89956023dbso2138904a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782756750; x=1783361550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iYgbnA2eT3oZNqUt9eUuhmtded3Q13gCFUeiCDYXMOQ=;
        b=SjIl5CjygnzJ5x980A8znDK27R/SaDG31bUUxGik3YzJvUvZ6Am0X014VxzPldtQb4
         CaXBtYtimJO0vGW8lkDvH86lZ73mRoinaWEu+D6Q65SeIV63TFwbpmA9edwyMYl1p1Wu
         jHGI3ubifj6nO5zqTjufvaB1tiZWjodNMp+rvXU/lfrriuqhH80124Uv5JMm+NMqXZuu
         b0sx+nKvyaVdzUePHcyx3/jVuykqR5stkxWt/45F0vXK/FTpaorKg/JPl/h1vqp8Rsby
         GM2vExLAmFbjZROfJA4oZHeEtqG9lFy8cWdKyTSS0py058C+2Xsy7ZuKbP50h5/c3bHV
         77aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756750; x=1783361550;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYgbnA2eT3oZNqUt9eUuhmtded3Q13gCFUeiCDYXMOQ=;
        b=E9enwX560C4qVjHd8m1eUrUw4Gv1hDyqlUJGKIPt6nDSxZ+JIqxA7P86+q4a0LSmTd
         4R+Lz7FLHUycG5FDjA3xmoSktFM+79Re5E+Mnnx7NJHd1cQiTEvpUiq6vkEl6AikV9Rz
         fV/I2x2dOXpdae65i9H27z5UEo8fvSHAk3HNorNe5TqovJBAb4Fc8dphl4uaYnyFU6U7
         tpTAV9WdD7pu16MEaWaV3S8mczaiGNXKDIgUVtmkzO6xTkmsd05ZEVPJzM82Eh9k1g7D
         WUoF6XatV2WLf6aGDLZXFN5N97olYZl+0GP0HyoFH+j3sFZubA1j6fs4EPuJyXp7/nIN
         n9lg==
X-Forwarded-Encrypted: i=1; AFNElJ/mB+tJ3hcVkI2i79/sRH74d2ChgQGpBiDv2eY7zCzpN0ClerZNfIBLa9i3o1gUNvhqEDLYSCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYSvnas71+vAT8GxGvzxekpx1I+mNmbypYlH5jJ/1XhlFyAWyM
	XHxB/fNqHP0eL+021xGUtY1spyMtE93ErbOr/NXQGuN3clDxAsnCsKl+jIcj3+UjBbHdm3DVZ1w
	AqVREsQ==
X-Received: from pgne10.prod.google.com ([2002:a63:744a:0:b0:c96:a7a8:7d35])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:548c:b0:3b4:8f2c:6805
 with SMTP id adf61e73a8af0-3bfc5319007mr485813637.42.1782756749645; Mon, 29
 Jun 2026 11:12:29 -0700 (PDT)
Date: Mon, 29 Jun 2026 18:10:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629181226.1929658-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 00/10] net: fib_rules: RTNL-less RTM_NEWRULE and RTM_DELRULE.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302763-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 560936DDF07

RTM_NEWRULE and RTM_DELRULE acquire rtnl_net_lock(), but this is
only for fib_unmerge() in IPv4.

Since commit d954a67a7dfa ("ipv4: fib_rule: Move fib4_rules_exit()
to ->exit()."), RTM_DELRULE no longer needs RTNL.

fib_unmerge() is one-time event for each netns, so we only need
RTNL for the first IPv4 rule.

This series introduces per-fib_rules_ops mutex and drops RTNL
from fib_rules code except for the first IPv4 RTM_NEWRULE.

The script below creates 1K rules in parallel in 4K netns, and
it got 20x/30x faster for IPv4/IPv6.

  #!/bin/bash
  N=4096
  F=rules.txt

  for i in $(seq $N); do ip netns add ns-$i; done
  printf 'rule add from all table %d\n' {1..1024} > $F

  for v in 4 6; do
        echo "=== IPv${v} ==="
        time { for i in $(seq $N); do nsenter \
        --net=/var/run/netns/ns-$i ip -$v -batch $F & done; wait; }
  done

  for i in $(seq $N); do ip netns del ns-$i; done
  rm -f $F

Without this series:

  # ./test.sh
  === IPv4 ===

  real  0m22.752s
  user  0m7.834s
  sys   92m46.721s
  === IPv6 ===

  real  0m35.181s
  user  0m8.635s
  sys   142m30.479s

With this series:

  # ./test.sh
  === IPv4 ===

  real  0m0.918s
  user  0m5.675s
  sys   2m7.024s
  === IPv6 ===

  real  0m1.214s
  user  0m7.917s
  sys   4m19.489s


Kuniyuki Iwashima (10):
  net: fib_rules: Make fib_rules_ops.delete() return void.
  ipv4: fib_rules: Make the need for fib_unmerge() explicit.
  ipv4: fib: Protect fib_new_table() with spinlock.
  ipv4: fib: Drop RTNL annotation for net->ipv4.fib_table_hash[].
  net: fib_rules: Add fib_rules_ops.lock.
  net: fib_rules: Remove unnecessary EXPORT_SYMBOL.
  net: fib_rules: Drop RTNL assertions.
  net: fib_rules: Use dev_get_by_name_rcu().
  net: fib_rules: Only hold RTNL for the first IPv4 RTM_NEWRULE.
  ipv6: fib_rules: Convert fib6_rules_net_exit_rtnl() to ->exit().

 include/net/fib_rules.h  |  4 +-
 include/net/ip_fib.h     |  3 +-
 include/net/netns/ipv4.h |  1 +
 net/core/fib_rules.c     | 82 +++++++++++++++++++++-------------------
 net/ipv4/fib_frontend.c  | 48 ++++++++++++++++-------
 net/ipv4/fib_rules.c     | 20 ++++++----
 net/ipv4/fib_trie.c      |  3 +-
 net/ipv6/fib6_rules.c    | 17 ++-------
 8 files changed, 101 insertions(+), 77 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog


