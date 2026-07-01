Return-Path: <netdev+bounces-303840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MYwHHxOKRWrPBgsAu9opvQ
	(envelope-from <netdev+bounces-303840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:43:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DF56F1E8C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:43:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VjoPzjWO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303840-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303840-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7173300229E
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF3A3B19D4;
	Wed,  1 Jul 2026 21:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCD4349CC1
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942225; cv=none; b=Zo86JbkQ6hRG1D2Oi0opzse6JTfHSnoV72II3AnYwYI+0CTwIyKUnp3RRNwuTgKri+nd0o5Y2T6Mj++2vx7JILgNZTv7CfGhhxYN0PBMMRhUN4duo1L6294XbfOVsNa+AM+qypNRCwUz7BYvfQe7/kz1GEs/qaXj+OuKsvFBIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942225; c=relaxed/simple;
	bh=vE+AneHjo/A9zmxA//uVh8km4uq6IR1+v7LcB1/a/k4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nbXs8+xHBCsdrVAmPA1EN6LIc++x3IwxLAGktQXvo35so7zVgcaME8QEiyEj4uXvDHAl2XZG6M/SC+xQg7xe40xeP4X5vzl4ESzeMYPgkx8VIdGPFpOCmm6k2bgzYWrp6oCXVg1+XGBb4JrcVCLt1wFTYWuLNhMivg4yj7QvAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjoPzjWO; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37ca4367860so1875528a91.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942223; x=1783547023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WSoiMzB6OZQWRfj9XGgeAY6Zb6r85/yNsZYVMAbhJSE=;
        b=VjoPzjWOpmyY70rzR3Q8q738Ru/eRUdfiJ4fVLIrQvELEJp3CNTI3DfiVBGXnDDYDi
         JtqILigB2GOHYJ2b6s98xOVztW9xQ/ThBslelKE4qNJbvyp6tv+4gx9xcnXdYchBuqaG
         8GzCX89MUTYVkRixXSzGPJCWD3v7v+Ylj34aVyF8/zOyy/2V/nDgdHrJTaKeq4bpzQEe
         LOGe8sO6TUes3v2axXGOcu3K+7WLHG2tJehLDMAvvqMu+HFAHPZDC9zIqbTVN0Q2i8It
         doY2/WrXQOysmcD1lwJ0hrrbvYUp/iiyUhbZnh5B8UWAHqup5JFzwvTvrf3ljOuA2diB
         I4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942223; x=1783547023;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSoiMzB6OZQWRfj9XGgeAY6Zb6r85/yNsZYVMAbhJSE=;
        b=EI01MP1LCdoRDJa3I6nGjTYfz4OJ1Y90UrOe4h2YUHcpHA8PRIfMF73SmizbUYXgcM
         HNPB+yA4tOzEqpd1s6AKlP5pgqC4pZKUJfGM3JTARBojWqzcqqr9OCCq8qjb9U5Q0Oya
         KfRZ3bkDPis75X677wL3kA2lB6DrOx99L8h/M/7cPS618W6FPYSSlp6nyhc0EJ4Ol2xZ
         lxEdfcW9ooipp3krS0jdsAnWH2r+U58uAcc3hSFGFjBl3bgUciLdevDJejpQqb/pdygY
         ozWc7CnVssLa2KDxZ3NVT5Tbviim30E0jJr6tybSkOSSmuT/a7kXJjR+94MNP95QLdN3
         MRYw==
X-Forwarded-Encrypted: i=1; AHgh+RrOQRmlrRuQSUhgV1TCekOx3w62dVu/g4qip97o6PWj6FNwrFImnogr1dtuPb5KS9BJ5Le/WTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcuW8pfciTSFnAwqRDVM6r5UMn57HlC0uP0zg6ZXrsT3/syNO5
	X4AcUpzx8XO+Aw6hyxiXk5mUsxb9U5HLtCOCVnQXTzWOVcAMWfIlBX2Np6VidOq1m4iRxdXKlki
	vApM1CQ==
X-Received: from pjn12.prod.google.com ([2002:a17:90b:570c:b0:37c:aa6a:c642])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1641:b0:37f:9e21:91d8
 with SMTP id 98e67ed59e1d1-380aa20e140mr2788170a91.15.1782942222716; Wed, 01
 Jul 2026 14:43:42 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 00/14] net: Support per-netns device unregistration
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303840-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2DF56F1E8C

The biggest blocker to per-netns RTNL is netdev unregistration.

It starts within a single netns, but it can eventually involve
multiple namespaces.

There are three types of such cross-netns devices:

  1. Paired devices (e.g., netkit, veth, vxcan)
     -> Unregistering one device also deletes its peer, which
        may reside in another netns.

  2. Tunnel devices (e.g., bareudp, geneve, etc)
     -> Destroying a netns removes devices in another netns if
        their backend sockets reside in the dying netns

  3. Stacked devices (e.g., ipvlan, macvlan, etc)
     -> Removing the lower device also removes multiple upper
        devices, each of which may reside in different namespaces.

While the first two device types require at most two rtnl_net_lock()s,
the stacked type has no upper limit.  This makes it impossible to
freeze all necessary namespaces in advance.

This series introduces per-netns work, initially suggested at
NetConf 2024, to delegate the unregistration of such cross-netns
devices.

  https://netdev.bots.linux.dev/netconf/2024/kuniyu.pdf#page=62

The first half of the series wraps NETDEV_UNREGISTER (in core) with
per-netns RTNL, adds a helper for per-netns device unregistration,
and forces per-netns device unregistration in the core code when
CONFIG_DEBUG_NET_SMALL_RTNL=y.

The latter half picks out one from each type (veth, bareudp, ipvlan)
and converts them to support per-netns device unregistration,
although the operations are **still serialised under RTNL** for now.

Please note that this series focuses only on the device unregistration
paths.  For example, there are ASSERT_RTNL() left in other paths, and
Sashiko may point it out, but they are out of scope.

This is just the first step, and we need more incremental changes to
completely remove RTNL anyway.

Now, we can see that unregistering a lower device (veth0 below)
removes upper devices (ipvl2, ipvl3) in different namespaces using
per-netns work with a different PID.  The lower device (veth0) is
freed only after all upper ipvlan devices have called netdev_put()
in ipvlan_uninit().

  # ip netns add ns1
  # ip netns add ns2
  # ip netns add ns3
  # ip -n ns1 link add veth0 type veth peer veth1
  # ip -n ns2 link add ipvl2 link veth0 link-netns ns1 type ipvlan mode l2
  # ip -n ns3 link add ipvl3 link veth0 link-netns ns1 type ipvlan mode l2
  # ip -n ns1 link del veth0

  # bpftrace -e '#include <linux/netdevice.h>
  kprobe:ipvlan_uninit,
  kprobe:veth_dellink,
  kprobe:free_netdev {
      $dev = (struct net_device *)arg0;
      printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
  }'

  PID: 2010 | DEV: veth0
          veth_dellink+5
          rtnl_dellink+1213
          rtnetlink_rcv_msg+1791
  ...
  PID: 440 | DEV: ipvl2
          ipvlan_uninit+5
          unregister_netdevice_many_notify+7129
          unregister_netdevice_many_net+1050
          rtnl_net_work_func+136
  ...
  PID: 440 | DEV: ipvl2
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
  ...
  PID: 440 | DEV: ipvl3
          ipvlan_uninit+5
          unregister_netdevice_many_notify+7129
          unregister_netdevice_many_net+1050
          rtnl_net_work_func+136
          process_scheduled_works+2538
  ...
  PID: 2010 | DEV: veth0
          free_netdev+5
          netdev_run_todo+4798
          rtnl_dellink+1507
          rtnetlink_rcv_msg+1791
  ...
  PID: 440 | DEV: ipvl3
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
  ...


Kuniyuki Iwashima (14):
  rtnetlink: Lock sock_net(skb->sk) in rtnl_newlink().
  rtnetlink: Call unregister_netdevice_many() only once in
    rtnl_link_unregister().
  rtnetlink: Add per-netns rtnl_work.
  net: Wrap default_device_exit_net() with __rtnl_net_lock().
  net: Hold __rtnl_net_lock() in netdev_wait_allrefs_any().
  net: Add per-netns netdev unregistration infra.
  net: Call unregister_netdevice_many() per netns.
  veth: Support per-netns device unregistration.
  bareudp: Protect bareudp_list with mutex.
  bareudp: Support per-netns netdev unregistration.
  ipvlan: Convert ipvl_port.count to refcount_t.
  ipvlan: Synchronise ipvlan_init() and ipvlan_uninit() for the same
    lower dev.
  ipvlan: Protect ipvl_port.ipvlans with mutex.
  ipvlan: Support per-netns netdev unregistration.

 drivers/net/bareudp.c            |  43 ++++++++-
 drivers/net/ipvlan/ipvlan.h      |  18 +++-
 drivers/net/ipvlan/ipvlan_main.c | 153 +++++++++++++++++++++++++------
 drivers/net/ipvlan/ipvtap.c      |  16 ++--
 drivers/net/veth.c               |  34 ++++---
 include/linux/netdevice.h        |  22 +++++
 include/linux/rtnetlink.h        |   8 ++
 include/net/net_namespace.h      |   3 +
 net/core/dev.c                   | 129 +++++++++++++++++++++++++-
 net/core/net_namespace.c         |   4 +
 net/core/rtnetlink.c             |  57 ++++++++++--
 11 files changed, 418 insertions(+), 69 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog


