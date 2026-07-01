Return-Path: <netdev+bounces-303889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id syFzMIeeRWoWDAsAu9opvQ
	(envelope-from <netdev+bounces-303889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:11:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AD06F2396
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:11:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Fpz3gJdR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303889-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303889-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EB16302BA6B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 23:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7174139A7F6;
	Wed,  1 Jul 2026 23:10:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1434DB52
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 23:10:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947458; cv=none; b=ijspMEdNWF3e6a7a2K91WBHevV8t3yG/HlXDqXLTQi/gqjf+Qo391uQ0dZUFMIN2KLtDczSxGqYx0GJBmxqirrawrEnMm6RCo9eAdhSc4ejUFt6XAyLgHWsp1Frbb0LKUq1QHz3f7M1kcZ/hYteCiS4EKn+g0WRnhFmUtRzrrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947458; c=relaxed/simple;
	bh=k83TnmWAzHvHC3KVASwPO8YB1Q+fyFuZJU0QKeLyk8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOhBa5XXX13iAmAEBTJgZts9Wx+IFe1IxZs11GVl6q1rEhOnFBX3qTqpOSQmpXlIkQYTf/HEXjUVJ2l1ndN5a3CUa+mF9nO1Po43T7RDf/nJG5F+TcarkImXKx11g9zn3a4p3fktUvDGJKVbNXs0KGOxBNcuMe85zw1gBHj+Nkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fpz3gJdR; arc=none smtp.client-ip=209.85.218.53
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c125ba77577so132493366b.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782947455; x=1783552255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYzWf3P7KpvKQlLi+J/DIqbvJI/jkF9FMNIVS2/7nwo=;
        b=Fpz3gJdR4BxJON1+xTWK7NJSFe24quqYGIuGBTwr7McnF6HEinQfE/Chsi/sXnKK7s
         ayygxsihemTtqdXnpBuhhXINgVARagNSxU59ZqSTp+hKg/yABzBRkG2Y0oTMnxXRYLIK
         RTsEFTF7gE4KEVfB7gwLRySFcaliGdmehKnkM8U7pEMIP+c6qLekOT9zx169M5VAJnvK
         a4FAfJbjTyhwN8o9pJVpY5xcRCANC9diWxyapOckoRNSYaUbtWgL6e4l2DhHqb17SAPk
         C1DxfwaY2cQfWX5dTF0CPcWroYFs/VKJ0zOESzDNpOENxcAh8sneuUxCRAoiDljLvPyq
         G9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782947455; x=1783552255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYzWf3P7KpvKQlLi+J/DIqbvJI/jkF9FMNIVS2/7nwo=;
        b=sniGGkWYboX8Pgo1VuPdowdOkW4ThTRz1o0CvLs92X+qLoVOiMDCwsnBmuRamewk1m
         XNjmRisFlUuiWPJBelydUg3zx8VtzK+LLxi1bTuJrpDNm5NDjnO9PK83tCswdfbRjYd/
         GhrM8SIGsl7rb2gb9IOgbB4nXxLmVHuVasIPnTneZpa3SnwhpATvANbIZv8eaUiev80z
         1BvDb5DpH7X+omhIlYHJdpmXyowAbb5GBl4Smq1gNFSSfkbZtmTQ/BZxh/r87YKxEWQ2
         cRMP8f9PVh0gxOvi2kuP3V9uCRWfn+aV7lnxbVTX4av1naEuotPCXHn5GSvd881Wooed
         gTsg==
X-Gm-Message-State: AOJu0Yx9lM/SydiA6T50E9wgL3hM4o87vV+kIXvzN/glYRlaLU92nKIH
	nYuCPEciT2Szs8PQGQLiA8KtV359GcB4w+tUCgUB9eshyTieYx4uFz50ltWIDby8Xf0=
X-Gm-Gg: AfdE7ckaUpGJ2ICXTlYa1DQdcO9gU6ZEbYLt8885UlRsc7rwDeHWtjI7O/SlqMDkdZy
	ccOh0AzA3ck0spI6LeJLfbyP/174coZJJMuFjVkTngJYqfeKlGmSLgR8gpKmZzA8/EYzBKO6ns1
	nznG34Y+z1PLtmpXrd5XRuZpW/TtK2jLBsDey/On4dDlhWrcf/rJa5OkR0xZPskCiZh2hW7892P
	uWXeAlBl2ZskPXXvprnp+ab0yO53Lg3rz7J7/hM+MhNtYt5Vlic+UFSdcsKBJLLSjCcHO13vWiB
	4+Ff2YWiMFGLTRV74tcgWQ5R5/K6E5/n9MSTg2ohumCfVjuLNJz57bXE2mj2ivP1vXRr+GYi54f
	8zWasI4biKcSRSLJGRcAOFwhPYWSapeUESXfRWhh2n1mW+IyJpCfkEWvqhdwGyv2oAtbsRjpTlc
	K5DNNTCH91L+jgiKojeYDsXsoINYbWtC0qoTeUDg7aA1V/g2K7PANmQ8VjiTKBsMrSYuYz4bsI2
	OP+aA==
X-Received: by 2002:a17:907:a709:b0:bed:9a7:5ed1 with SMTP id a640c23a62f3a-c12ae45c996mr161885666b.5.1782947455206;
        Wed, 01 Jul 2026 16:10:55 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.164.115.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b629a1d4sm30663466b.39.2026.07.01.16.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:10:53 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/2] udp: fix FOU/GUE over multicast
Date: Thu,  2 Jul 2026 02:10:35 +0300
Message-ID: <cover.1782945956.git.littlesmilingcloud@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-303889-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22AD06F2396

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

v4:
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
 .../testing/selftests/net/fou_mcast_encap.sh  | 112 ++++++++++++++++++
 4 files changed, 121 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh

-- 
2.47.3


