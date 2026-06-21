Return-Path: <netdev+bounces-300895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7juqE9c1OGo6ZwcAu9opvQ
	(envelope-from <netdev+bounces-300895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 21:04:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6886AB798
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 21:04:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Sn3xR1Hz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300895-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300895-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14C7A300950B
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B5370AF6;
	Sun, 21 Jun 2026 19:04:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3391F151C
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 19:04:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782068692; cv=none; b=AUFO8bvZo6ot06CDhyaE8/2sN9GpF8OUHEmMnsNL8PRga/FylBwml7ec5vkJA90D5Dv3vAonGDKr2kEOVA716nIuU4n2ON+cs5KF+JoMfzaSHteoVa4iRXG46VZ5I1Izm9Zg5HvrzNygHe0ux0C7gkbZiEI2U5f05VMHFp/ImaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782068692; c=relaxed/simple;
	bh=ReISC7zQRSyG1CflbXKLubYBm+/t1fKSOjnrfVmVUjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBSnkfa66gm8d0Gnyy7/z5YHSZJ8Et2bGjOPPUTVRcOnod3G5hTHARqAprB4h3+h6FNbVugTJEZPXJohjkPYv65FFcPXEHMZDP2lQFlFvmvin5Ma4BhI2ynh3REUZ6xFIavg5M7+jRV3jfJhDVzP79ZT5tkVXGfr9c9On409ul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn3xR1Hz; arc=none smtp.client-ip=209.85.208.43
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-695bba79ae1so5009661a12.1
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782068688; x=1782673488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N7bwW2QsthJJoHQh4gtNxVjqWDflzrySaQFr266/3hU=;
        b=Sn3xR1HzeQNi95yLf8QpA8s8KbpTZhFQ1m1rf4d0pdvkwBMFGmaiEPM82bfQN1mPXe
         kwklr27pmcotfHzMb7LSZpRm2uIsVqDzbQH6pw1gb6Vtgd1+fnoeLgrghyjqVWTtvCrr
         vFHKAgqaWh0vY6IT9Go7b8ukijteap18s+QTuXkXN6y6Ih/2h9+xmSlvzy+fEzxmBaZu
         duMYP98flRiISAYR7gKNLTzy0NcfyKzUCTjog2stQLPdIP80lGreaRL4v1+sYGbBBC/9
         x4ObXB7xvrAeVHoIVFLMaVD+iVXVSkw7/O6l/XduLaA1Db7nGu2pFDFi1Ym6EYnJoazJ
         Iy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782068688; x=1782673488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7bwW2QsthJJoHQh4gtNxVjqWDflzrySaQFr266/3hU=;
        b=jBDxVmnrYUZVCU505cl76iUQDBz8m+OfMC431IN7JWNCPxxQGtnCHFdChkWuvVhb4L
         Uo9RNZjmMIlbagaQHMmKLQp23FT6xFFfWv/1+y82Ye/sUSxQCIoQCnmtgRUtLsB8FX0o
         4+8e3nlkpCZftgSvQnhFJj6QgrBHxp6kyCLI/eiJSMRzQ1cktmv7ZDL7xfRZPfcXM+Hw
         8i/sues+kxXyjbaLv/uYzjzKwjfJ0FoClhsAEHApJ1J2U9EVyYp17ZOoHkufSQYHt3A3
         +PD9q1YjHMYOaDw4AE+O49s8rN7Sqh6iRSj+i4oWv/jP8pafsY7uIJ4qqeP4AdVp1n3c
         kAPw==
X-Gm-Message-State: AOJu0YwWB5q73hOWRB+1aLXYIM9aZY3lUdIPI/Gj2F7rH+ye4L8wdKYa
	VNYR0P68uupq5c3HV8/2PPFd6cUFYC58UgiDOxjEnQh7rYbMuFVk7Un/BGlHGmoI
X-Gm-Gg: AfdE7cmSLkhsqucjMXTJVRJnoYv2wHAfbsgCYnCHVrOzaU+62+zcvq/64CUhCaelmk3
	0uA3Vb2Zc3Zg+ClVN0ZRjlUtyhOOh/HK0EACCnM0NHTDBBx5STZpf/jZFCx0ME0+nq3eBvIlL1+
	JjPKVtB3gNyxauYNHsIlnXDIlm2MOVlruk4NHn26dtIly9Mx7/2YIz/wHxcm65tI0M+HFve86ig
	3Zbr+iIN8J46uH+nCXRGLCmJgF+Sl0QjH2w2isRU4nCMfN5hyhnEBPU9XGS2rqkiHTvCD8GjzxT
	Gd1Z9RdaGwXp4I0O5OC5Omp5KoWFMVPEoL84TB0MbrK3ju2e4Z01safl9SfSj98UqGdJvubeyPg
	0mup5Q2JouSYTaprI9W9fzbWCGm7f58i1FVapVAP7reLd0ekJrNYWbjVCOSqhq/3jqR3mnKMTe4
	YRVaZ+20qcXr32HK6AjDEUeNvggoyp5LgW01x38rBdtJMNR00pOk/V7uoVb/5a1VyWAvhKYiTkt
	AOJ8A==
X-Received: by 2002:a17:907:3fa9:b0:bfe:ed35:e854 with SMTP id a640c23a62f3a-c09b9c79152mr523065566b.25.1782068688315;
        Sun, 21 Jun 2026 12:04:48 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.164.115.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99977fsm230558266b.20.2026.06.21.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 12:04:47 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next RESEND v3 0/2] udp: fix FOU/GUE over multicast
Date: Sun, 21 Jun 2026 22:04:10 +0300
Message-ID: <cover.1782067871.git.littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300895-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD6886AB798

This is a resend of the v3 series originally posted on 2026-05-05,
which did not receive review feedback during the previous net-next
window.  No changes since v3; rebased cleanly on current net-next
(after the net-next-7.2 merge).

v3 archive:
  https://lore.kernel.org/netdev/cover.1777934869.git.littlesmilingcloud@gmail.com/

UDP encapsulation (FOU, GUE) has never worked correctly with multicast
destination addresses. When a FOU-encapsulated packet arrives at a
multicast address, it enters __udp4_lib_mcast_deliver() which calls
consume_skb() on packets that need resubmission to the inner protocol
handler, silently dropping them instead.

The unicast delivery path handles this correctly by returning -ret,
but the multicast path was never updated to support UDP encapsulation
resubmit.

This causes silent packet loss for FOU/GRETAP tunnels configured with
multicast remote addresses. The loss ratio depends on the early demux
cache hit rate - packets that hit early demux bypass the multicast path
and work correctly, masking the issue.

Reproducing the issue:

  ip netns add ns_a && ip netns add ns_b
  ip link add veth0 type veth peer name veth1
  ip link set veth0 netns ns_a && ip link set veth1 netns ns_b

  ip -n ns_a addr add 10.0.0.1/24 dev veth0 && ip -n ns_a link set veth0 up
  ip -n ns_b addr add 10.0.0.2/24 dev veth1 && ip -n ns_b link set veth1 up

  # Multicast routes
  ip -n ns_a route add 239.0.0.0/8 dev veth0
  ip -n ns_b route add 239.0.0.0/8 dev veth1

  # Disable early demux to expose the issue (otherwise it's partially masked)
  ip netns exec ns_b sysctl -w net.ipv4.ip_early_demux=0

  # Join multicast group on receiver
  ip -n ns_b addr add 239.0.0.1/32 dev veth1 autojoin

  # Sender: GRETAP with FOU encap
  ip -n ns_a link add eoudp0 type gretap \
      remote 239.0.0.1 local 10.0.0.1 \
      encap fou encap-sport 4797 encap-dport 4797 key 239.0.0.1
  ip -n ns_a link set eoudp0 up
  ip -n ns_a addr add 192.168.99.1/24 dev eoudp0

  # Receiver: FOU listener + GRETAP
  ip netns exec ns_b ip fou add port 4797 ipproto 47
  ip -n ns_b link add eoudp0 type gretap \
      remote 239.0.0.1 local 10.0.0.2 \
      encap fou encap-sport 4797 encap-dport 4797 key 239.0.0.1
  ip -n ns_b link set eoudp0 up
  ip -n ns_b addr add 192.168.99.2/24 dev eoudp0

  # Static neigh: ARP replies can't traverse unidirectional mcast tunnel
  recv_mac=$(ip -n ns_b link show eoudp0 | awk '/ether/{print $2}')
  ip -n ns_a neigh add 192.168.99.2 lladdr $recv_mac dev eoudp0

  # Test: ping through the FOU/GRETAP tunnel
  ip netns exec ns_a ping -c 100 192.168.99.2
  # -> without this patch: 0 packets received on eoudp0
  # -> with this patch: all packets received on eoudp0

AI assistance (Claude, claude-opus-4-6) was used during root cause
analysis of the kernel source code (tracing the call chain from
udp_queue_rcv_skb through encap_rcv to ip_protocol_deliver_rcu,
comparing unicast/GSO/multicast paths) and during patch and selftest
authoring. The fix approach was identified by observing that the
unicast path (udp_unicast_rcv_skb) already handles encap resubmit
correctly via return -ret, while the multicast path did not.

Changes since v2:
  - Use return -ret instead of calling ip_protocol_deliver_rcu()
    directly, matching the unicast path and avoiding call stack
    growth with nested encapsulations (Kuniyuki Iwashima)
  - Only change the first-socket path; the clone loop is not
    reachable for tunnel sockets (no SO_REUSEADDR/SO_REUSEPORT)
  - Replace Python packet generator with ping through a properly
    configured FOU/GRETAP tunnel in the selftest
  - Add static neighbor entry in the test (ARP replies cannot
    traverse the unidirectional multicast tunnel)

Changes since v1 (RFC):
  - Moved inline Python packet generator into a separate helper
  - Fixed author email typo in Signed-off-by

Anton Danilov (2):
  udp: fix encapsulation packet resubmit in multicast deliver
  selftests: net: add FOU multicast encapsulation resubmit test

 net/ipv4/udp.c                                |   6 +-
 net/ipv6/udp.c                                |   6 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/fou_mcast_encap.sh  | 112 ++++++++++++++++++
 4 files changed, 121 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh

-- 
2.47.3


