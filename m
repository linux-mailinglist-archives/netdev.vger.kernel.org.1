Return-Path: <netdev+bounces-304301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uEO2Nen9Rmo1gQsAu9opvQ
	(envelope-from <netdev+bounces-304301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:10:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5597B6FD8C5
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:10:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=c1s1PS5F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304301-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304301-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CC2D3029A66
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44BBEAC7;
	Fri,  3 Jul 2026 00:10:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45B38D
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037413; cv=none; b=JzL+OwPJu+qiqfGI10RqQtNsKo7sm4Yiw2SxLFxF40NNtZIkk6HtXLnw1t97q3zkDwugnLfSJT1jvKXiF3ST3e9mVMQYToE8pOCfw/gxcNvetuxan4W8WYsiJ3LaxhOi3+HtvR6fyfm4qbWiUOh9UyqBmcSfmrefkm8k0X2iWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037413; c=relaxed/simple;
	bh=1BvvR4kj2ye/Vt6XiiwxoNwzuvLS1lRmFBVAMKYRrSo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W0QMYotuLM3Sw+kNJW3Y0y9cgxxgXqCiYG8NRkZA/udxllqttBifd7BTOGoh9o3In9a//652SXqhqMXx/217oImLZsZVqdmInFOBUBe3SRut+lBmKO7UsY7IPNeOlz25H5SqO4ih82HB66P7ioMAe11mPuYdVqkjm5ZaaVm4l34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1s1PS5F; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c9541d25af7so1242773a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037411; x=1783642211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tY0l3fGYicnCO2gJZXM2Hel05X5MtSYhKflDUVLKZzA=;
        b=c1s1PS5FbD2OwE5Q0/oU+xaHjuptUh3OtLiDT+k4gkHZiIM0ZV4PHeulYqEEKpStIg
         vKC1wz/Ym0HHcrmdmaHkPW73ugQQSQqv2odJjzL94HMWOwWgHJJj7nDzmla2RJS6e4JL
         kh3zqp+RA2/ZT2JiPaUjKZI00TBCri6zsL4kWFFKTT8pVEMgaXJHlswEDEqvWx++T+A+
         vdgx4W2/7LI1EPBoMyp2yjezo9WgQnrwtAebXMOryjj7PRk5R0HEiRVovtp1Ia9DCF3p
         FMNE4bMx0i3IaGilSRY5KCPcq9JDqIIaVS4kAsobqKngOFxZSOz8ZAyTTztsd8CTSEIs
         bkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037411; x=1783642211;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tY0l3fGYicnCO2gJZXM2Hel05X5MtSYhKflDUVLKZzA=;
        b=drNXwFaNsNxaYyf0CrUKYr7dUHOPfZdbO8WJdIlKLbMl+zDaLAQWC872123XBMYpeq
         ULEuWHVVE9l9xcAu+6zj6pyEc9unzHAbOrBk1FCL+xQB6FnFh5Mwa+qzyPQKHg9rgFKk
         wKh7mt5pNEs+ofE/wka12rz2v0d+RCIZDgOOD11zmu8w4SO0MhQqwitLURlKQ3G8Lcik
         bMB/Fl9/cBnIXaEecveP2ZUSokChXZZ7iO8bi+ECaoeabf7wWamZaU3ULSlhhj5pcK9s
         4vDdujMN2hdFGortjiVsnlaQYNWXif7HJXTLIzLTR0Uy/S8/NvcAOiBdJ9bD/9AtT99A
         /j5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/nW7vxpYtLh/yKE8YAdTFTCj31ihxw2l/P4RNchbRmSlyPYD+rUwRUEr0rLCJO7TbWbH9JQhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDrmDKfZc7Dx47iCLlhpn6ppQmocqqHXJNGOr2L0BiCD+7+2Z/
	H13esSdXcPzlnEMXmFct86syQpaw0WKrgW4oeB09YiLmmn7BjMpDJwTBH9dv6Y5E05UjCwtATlG
	me6wOZQ==
X-Received: from pgjl9.prod.google.com ([2002:a63:da49:0:b0:c8a:5a4f:560f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b02:b0:3b3:21f7:15e0
 with SMTP id adf61e73a8af0-3c01cbf1191mr2171546637.38.1783037411372; Thu, 02
 Jul 2026 17:10:11 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 00/14] net: Support per-netns device unregistration
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304301-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5597B6FD8C5

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


Changes:
  v2:
    * Patch 6
      * Use spin_lock_nested() in unregister_netdevice_move_net()
      * Add kdoc for dev->unreg_list_net
      * Add DEBUG_NET_WARN_ON_ONCE() in unregister_netdevice_queue()
    * Patch 13
      * Add __ipvtap_dellink_ptr for CONFIG_IPVLAN=y and CONFIG_TAP=m

  v1: https://lore.kernel.org/netdev/20260701214334.266991-1-kuniyu@google.com/


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
 drivers/net/ipvlan/ipvlan.h      |  12 ++-
 drivers/net/ipvlan/ipvlan_main.c | 147 ++++++++++++++++++++++++-------
 drivers/net/ipvlan/ipvtap.c      |  25 +++++-
 drivers/net/veth.c               |  34 ++++---
 include/linux/netdevice.h        |  24 +++++
 include/linux/rtnetlink.h        |   8 ++
 include/net/net_namespace.h      |   3 +
 net/core/dev.c                   | 135 +++++++++++++++++++++++++++-
 net/core/net_namespace.c         |   4 +
 net/core/rtnetlink.c             |  57 ++++++++++--
 11 files changed, 429 insertions(+), 63 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog


