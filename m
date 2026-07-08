Return-Path: <netdev+bounces-305626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W0ODKkubTWpF2wEAu9opvQ
	(envelope-from <netdev+bounces-305626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 02:35:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A02B720A68
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 02:35:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aKS4NB4H;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305626-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305626-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 246813017247
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 00:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88387357CFB;
	Wed,  8 Jul 2026 00:35:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B70348C54
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 00:35:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783470920; cv=none; b=W6wlVlvJFhADHO25qsHTWWwEmDox9tlK5X7/EDxKqTtw3ST1hO2BRAnJ72WP6fN2OVjE+i7CXmHGOmzcwWcEKBQtq9uNj85F3/SNIuxRlrbQsPh0YcqCPvbWGWvE467/yD0XpuCDeFkYUcOg4F/ZK+tZex2jMHkAgqvBJ8IUNGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783470920; c=relaxed/simple;
	bh=wE80HFXVS6gE6NCftxK7/wkblCU0qQfZy8JtjREzIzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ya88/+W9VOIN5OQnxjKHlsqwWUeyV0h2GItELQZ5TXJEovHGmszB/fJUMPaQbtA7ij1q8hAgG2JV19z7Fp+6IJW7t1oHhxBfaYs5f7cy5kqRsrGeLJ5SxQxF9xFeL7szX50HPYFc1uhIty/BtlOPyG3vFhiKmsbXDJwd8b8xSM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKS4NB4H; arc=none smtp.client-ip=209.85.167.50
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeba09900bso86155e87.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 17:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783470914; x=1784075714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/YjhnuuQIuAnyjd3cyhNurxxO1PKF/cEV7P1mXkplQ=;
        b=aKS4NB4HMNGGx065gJKx+bqwtqDevf6pw6cqVQVrnXfN6md6IJwzqABgIFxMxDR9dn
         F6cSt1vGdttAsG1dWNyPfohmB58WGslGivoq0XqQWECJFQktV8XMKoqHYwfSIcs3gotz
         JkaiQiwD0A0o5cJR3FmkFBw7Gqj4Fxmc3wl9+SCMUGvOvhvGYomL6oRw9Et+dNwETQ+p
         RIHqQc/62expsGylgK4vyAoKVg+migEEgR7RXhkd56/4aULUz0cUVR3f7v/tBEwdLtEd
         X8SI8uGe5hxKjBg7HMkEUUAsluX3FAgPXK0bZJxVwT3CF4U1iQJtYtzhYaXbI2aXZD75
         xqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783470914; x=1784075714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/YjhnuuQIuAnyjd3cyhNurxxO1PKF/cEV7P1mXkplQ=;
        b=g5+Ow0ib7noKHXYc5vxSXmjSqDJ2wHblXmtBEQG8j67lvlmDy8ZGYpqzwbAN/TZzos
         bdf9rtFIOGTFjtAlPLfNudQGtmk0diVAy/4V87VZ1O3esY7/gTSlybZgbp3JvrOS4rH9
         iW/WNo85toNCKqMgQViulog09B86gwHc8kPB7ScpfMHuVcX+23CKnuGzILLGQ6ghUlp5
         nGBl2A+mFNASId6ZrronTvuWkcrNG7AF0SltsW3hGVsfBHZJF+R0iCz8weTKkQ3XVQw8
         14TB2YZB1ajlXEVxVO/02OQ5OtJK7IV6v6ODGO876GdGOshuf+rX1ZVKes69CVcDUUUm
         uj6Q==
X-Gm-Message-State: AOJu0YxbCWClDbQHF24vk9f/b2qEeVk80IfsL7r1qyuKjN25k9u6FCst
	kBQDv73IJ4W8IkOHd19zgU010TMlnK14euOvJjLk5x7puD1aBQH8YfFVwjsBuUp92XS4Rg==
X-Gm-Gg: AfdE7clpOBqGeS/SzfFNNZMt8S0b0zb6DQZpe5Tri48y+ddqBD8AKdzShPAKzzu9RXQ
	XllpixVzKdYUKTy7yUPB/W1MfB0xdbfvp9vCotsH49dVPaOp93Xef955OXpz9SanSJsGr/Vh0eg
	Rf7GR504ywtuJhua4RzspZG77HqNp66/u2vUUij8RxltUr37UAojF6BTICtsE61yjwE+wH6GpFI
	eryvBtgolOR6yvtSBmF3uE5vdIPDSov+O3aXMJP8kHpEeFTsXmYyOUAo4JdQuqYdFmYEJOJjaxm
	ut0k7fAA5vDMMyAsDL0/qO5Nr8diTwRZmM1TWL+R3SLZD2NK8AZw9qiOhtDW4O1yMOaPM7fGSnC
	8mlhYlAn+o6drtm+NToJZj9ULbVExP165qOVc/i5bts7acGcfqZlxFt/IJM/VIFz+qr2yZUpIbM
	UKPj8fM8KhXY5Qwi8UMYCKG/vZKMLt4uNrVVEmxc6/seoeSlipvAfFyj/WmNNzoWETjbDdUQEt5
	bgE
X-Received: by 2002:a05:6512:2398:b0:5ae:ba93:9116 with SMTP id 2adb3069b0e04-5b0114381b4mr65019e87.2.1783470913891;
        Tue, 07 Jul 2026 17:35:13 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.139.182.77])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed136f8dcsm4083867e87.11.2026.07.07.17.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:35:11 -0700 (PDT)
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
Subject: [PATCH net-next v6 0/2] udp: fix FOU/GUE over multicast
Date: Wed,  8 Jul 2026 03:35:02 +0300
Message-ID: <cover.1783372173.git.littlesmilingcloud@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305626-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lib.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A02B720A68

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

v6:
  - selftest: use the lib.sh ktap helpers (log_test / log_test_skip)
    so the IPv6-unavailable case reports KSFT_SKIP properly (Willem
    de Bruijn)
  - selftest: add CONFIG_IPV6_FOU / CONFIG_IPV6_FOU_TUNNEL to
    tools/testing/selftests/net/config (Willem de Bruijn)
  - selftest: speed up the ping loop with -i 0.01
v5: https://lore.kernel.org/netdev/cover.1783218197.git.littlesmilingcloud@gmail.com/
  - Fix IPv6 patch: return ret, not -ret (Willem de Bruijn)
  - selftest: add IPv6 test case
  - selftest: create the veth pair inside the namespaces (Willem de Bruijn)
v4: https://lore.kernel.org/netdev/cover.1782945956.git.littlesmilingcloud@gmail.com/
  - Promoted from RFC to PATCH; no functional changes since v3.
v3: https://lore.kernel.org/netdev/cover.1777934869.git.littlesmilingcloud@gmail.com/
  - Use return -ret instead of calling ip_protocol_deliver_rcu()
    directly, matching the unicast path (Kuniyuki Iwashima)
  - Replace Python packet generator with ping through a real
    FOU/GRETAP tunnel in the selftest
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
 tools/testing/selftests/net/config            |   2 +
 .../testing/selftests/net/fou_mcast_encap.sh  | 172 ++++++++++++++++++
 5 files changed, 183 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh

-- 
2.47.3


