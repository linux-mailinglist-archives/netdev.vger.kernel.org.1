Return-Path: <netdev+bounces-304745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k3eFJC/DSWrq6gAAu9opvQ
	(envelope-from <netdev+bounces-304745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 04:36:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1592708CF6
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 04:36:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TXlnEXjn;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304745-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304745-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60DC8300EF5E
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 02:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957FF1A9F8D;
	Sun,  5 Jul 2026 02:36:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671B84039
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 02:36:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783218987; cv=none; b=WittboAEAbiaaMmuzikIydIlKfTtHPeCrR1tiKlEz46qN+W/2l8HSyKyfsqLEQlRRXh8sUJdofIBOb4WschLNkWr4rC2E9GvDeZoj4VCFpZEIkwe1vqJ1R934A7kyiFiFr3ozOWtzJrNzmvkRAAUl3bByAbQiIPizaAn32+u+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783218987; c=relaxed/simple;
	bh=FVnq+QFxh+qLqKfpYnn4iEE5oE+A+Of8H4mc623bJ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVDjEuHOFHLoX0V+WIJseJ9OBB5diygRfSfkll8GTuvAym/2XJB5vIOBqHOE82l7aIueXX/NCe0aQXsmEh6QZSEWci+Yj/JDMlYLKGThXPjsP3mnB827IjH8LEJJZcBmuLZlBxZ9+y3IPcLfk0y9JoLU6xWpMGKUj+fKNHOUKls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXlnEXjn; arc=none smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so3156521a12.1
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 19:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783218984; x=1783823784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ci/3PhCLxwaAMpB1SnTOw+fEBBoxsM4i+VO38xxMJM=;
        b=TXlnEXjn479kcST5Csb3dKpx8k/I8MEHSD8Q4wbea5XA6Xw849lGn2pC+o4QWyV76r
         ZcM922ZD4QPnq+cFvVa0lOMUL+wr2CsWj97Ss/yzxE0RpfRYKJxfCNtdXJvbbExEkSt9
         egfIxrUD8zVKBXzDz6puHNtDw+VsthmZmKpWv/0/7M5oggOqUpvULKsDD+94kPOX6Dhl
         JIZr1CScsv/5vR44aijipieo4r/lgjh1jkqMBcaGN1fn7OCCTEObI6e+s1/w1Ezj63sM
         zWw5ccxJGqB1gQdP4dAw8IOUkbty20AmdACc303JfC8HyZFHq1pfVXgKtvfqOwtkqWo8
         dZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783218984; x=1783823784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ci/3PhCLxwaAMpB1SnTOw+fEBBoxsM4i+VO38xxMJM=;
        b=o72hT0MTGwG1nbu8USKCGhIZAWSgNlMayZx4/48gAhjwqAXD30Uky+FuieQ3p4THyz
         KNH9pjX9vVBtRZanfg9yMtwjItg36OLTKgM+iBmR2utmNFc/4a2NSqiW47vGiKuCGpVl
         cxl4EfIAvUJNvMNmW6l+zfc4ug41j4HtFyOoCwoiCEn2Uz0885TjaOXzAKjhUxAgNh3V
         6BLp1paugIoiujKqF+XPhtjKB1CFafI9euAR1rbIpGJ9Zc39oNxcYxfYdaqcriho87Wn
         fCP3E1NzNDrYZJOvQs0CryqleCU1h2l8AsxTaZhe6AEkJoScJbO2kUkZK7mNC2YrNzk2
         7Tqw==
X-Gm-Message-State: AOJu0Yy3Xc+4xx2Q0oAUFbMNPmwdD/+vc/N3qQ5WOFLpcN4qm3m+0sG/
	Vl4kgMqgbeBhLvBVWL1lNIFcb7svrR4I/Z9sU3YhmZzEiHgc3npSsGxsD+liBsL8
X-Gm-Gg: AfdE7clnFQZjbm5AF7NxYiRSV/UX/afpyaIMJ68ejlEaeA36V7z/mmpIFyM4R2MN1CZ
	cNl7a6cypORmqw713aRXr3wGnavHngCYgzxjeX3d8jggoc77lZNU8sR4+ykeeqkR4hsDfFNhNGv
	h0xjk2z6EOjiaSALA46D3GSQIbBg/uLXX5AUsYDeVTRoWC/uizCs63dPrzjf6aBZDfCEfRbhNDK
	M2qAn+wC9NWVDNGYUUnM2PNRRWtkugIk/jNqqI74vCTNZVLlIg7GlkXcWqS34AVpTWKD1wc77bC
	mLeJuVFNldCmJ+1gizZ7LCTkLHBWa95qkBLRp3rzvjsM53W+AC2I6rWgcp/W0PrA0ZF2ZMJqOvt
	uVhmBUxTTE4MEFApqHn8W6s7phAwfeL0RqrL4UqRjpb5DVEv9MQZ0qIGPFS6FQ5/KkExJexpcvD
	vdYQKaiju2Zs3C1ARFvuWrdSZFwnlw51GnRA1z62p4biiwirEKf+8LMM36AA==
X-Received: by 2002:a17:907:f814:b0:c12:8c27:e2e1 with SMTP id a640c23a62f3a-c12c9d3de15mr350524266b.5.1783218984349;
        Sat, 04 Jul 2026 19:36:24 -0700 (PDT)
Received: from dau-home-pc.. ([95.164.115.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12bc53e065sm463082166b.46.2026.07.04.19.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 19:36:22 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v5 0/2] udp: fix FOU/GUE over multicast
Date: Sun,  5 Jul 2026 05:36:02 +0300
Message-ID: <cover.1783218197.git.littlesmilingcloud@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304745-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1592708CF6

UDP encapsulation (FOU, GUE) has never worked correctly with multicast
destination addresses. When a FOU-encapsulated packet arrives at a
multicast address, it enters __udp4_lib_mcast_deliver() /
__udp6_lib_mcast_deliver() which call consume_skb() on packets that
need resubmission to the inner protocol handler, silently dropping
them instead.

The unicast delivery paths handle this correctly by propagating the
return value up to ip[6]_protocol_deliver_rcu() for resubmission, but
the multicast paths were never updated to support UDP encapsulation
resubmit.

This causes silent packet loss for FOU/GRETAP tunnels configured with
multicast remote addresses (both IPv4 and IPv6).

Reproducing the issue (IPv4):

  ip netns add ns_a && ip netns add ns_b
  ip link add veth0 netns ns_a type veth peer name veth1 netns ns_b

  ip -n ns_a addr add 10.0.0.1/24 dev veth0 && ip -n ns_a link set veth0 up
  ip -n ns_b addr add 10.0.0.2/24 dev veth1 && ip -n ns_b link set veth1 up

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

IPv6 (using fou6 + ip6gretap) exhibits the same silent drop with a
different fix (see 1/2 for the sign-of-ret difference between
ip_protocol_deliver_rcu() and ip6_protocol_deliver_rcu()).

AI assistance (Claude, claude-opus-4-6) was used during root cause
analysis of the kernel source code (tracing the call chain from
udp[6]_queue_rcv_skb through encap_rcv to ip[6]_protocol_deliver_rcu,
comparing unicast/GSO/multicast paths) and during patch and selftest
authoring.

v5:
  - Fix IPv6 patch: return ret, not -ret (Willem de Bruijn)
  - selftest: add IPv6 test case
  - selftest: create the veth pair inside the namespaces
    (Willem de Bruijn)
v4: https://lore.kernel.org/netdev/cover.1782945956.git.littlesmilingcloud@gmail.com/
  - Promoted from RFC to PATCH; no functional changes since v3.
    v3 was posted as RFC and consequently dropped from patchwork,
    which explains the lack of review feedback.
v3: https://lore.kernel.org/netdev/cover.1777934869.git.littlesmilingcloud@gmail.com/
  - Use return -ret instead of calling ip_protocol_deliver_rcu()
    directly, matching the unicast path and avoiding call stack
    growth with nested encapsulations (Kuniyuki Iwashima)
  - Only change the first-socket path; the clone loop is not
    reachable for tunnel sockets (no SO_REUSEADDR/SO_REUSEPORT)
  - Replace Python packet generator with ping through a properly
    configured FOU/GRETAP tunnel in the selftest
  - Add static neighbor entry (ARP replies cannot traverse the
    unidirectional multicast tunnel)
v2: https://lore.kernel.org/netdev/ad_dal164gVmImWl@dau-home-pc/
  - Moved inline Python packet generator into a separate helper
  - Fixed author email typo in Signed-off-by
v1 (RFC): https://lore.kernel.org/netdev/ad7MsSJOuUU6EGwS@dau-home-pc/

Anton Danilov (2):
  udp: fix encapsulation packet resubmit in multicast deliver
  selftests: net: add FOU multicast encapsulation resubmit test

 net/ipv4/udp.c                                |   6 +-
 net/ipv6/udp.c                                |   6 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/fou_mcast_encap.sh  | 177 ++++++++++++++++++
 4 files changed, 186 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh

-- 
2.47.3


