Return-Path: <netdev+bounces-284072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK1GL4Ej+Wmz5wIAu9opvQ
	(envelope-from <netdev+bounces-284072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:53:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 187D74C496A
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 114583015C80
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 22:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2A6243956;
	Mon,  4 May 2026 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbR+Aan6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4D733DEF2
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935211; cv=none; b=oCTOogZn31sAKxbzxRWnUNJU9YCh1IeJ+4e+8dAdhj3AY2aa6gEvvjE40kO7HTZYptbAkVJQzJUQvrTuDVfRLX2u7iYgVMlpov6TKyursE/NYPjmvJlNm/Q5sEVtS6t7VjWpSbsDyrS4oQs7CPCxy4vVqGnQ6YmHKv9vhKrHLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935211; c=relaxed/simple;
	bh=kl+VKiVcXFJLGz+zh1YjrPpBSIjFpq/0QZXFRB4vlQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcygyQxTpLIF0vT2Pb2VLBf9nylIHg5fdx5xPc9X6HksB8viPYOquwF2WQ+KLmfj+Jm6HFohWonMQ68PBwXetxJ0axDh2SnOVrtjPESCRjJglDY68Uc+i8GmuCifygNYc7q1+33S3WieP+cOB0G3/yyWrGghTW78SkJNVHAm1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbR+Aan6; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-393925cb1baso22601601fa.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777935208; x=1778540008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=po4u7/Rujwbm7uihMqIsA/eo7S1xmgz8pQV0r2hhPeo=;
        b=jbR+Aan6NTM1C9bwGODvJC8obmEzJ3T2agwcKRY4Yu+jfsw6TGxwHJwz88l00iwB8r
         /Gq765gHp6mVwO04u9LDvU/IOPh2pFWnXY4xjXapPRKgxAmLkZvMha7JClIkXETsr2Rf
         n+2gNrIiMxyGFB3RX8hi02ct2IFKj0NhuSnVtGoFDuZhypdOY9QoUZ/+FIrMQPsEby4F
         +LbHpvRrhYA6kOYAM2qccs7KZ+G0Bo1d6dU87D+eh2l7HD3PrjIxaq88bHNOX5RukbVC
         MWSIxaWa2H8i/NAub38P9zgAphw3FaavAF1X4wUrFP/897kbxkmTqDECF5ii0gVTp0xC
         eY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935208; x=1778540008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=po4u7/Rujwbm7uihMqIsA/eo7S1xmgz8pQV0r2hhPeo=;
        b=RBhQk8NwAo4ld7vmadhr0EVoMbvFZzcuQZ0mcaBUaVOmzd0u3CZoMFF5yFnubX7wuT
         yXZQI+jOlNoWtne/mzEbuKXtToBpjtj1HKKB1RJi+ZlaQPNeVgXAjwUjCIG55U/sVaYa
         0rPc6KyOq711JFwDWKoZHB+PwIpMLFPJsk70LoOZ5vQ8bbboNQ6za5ndFhwPcGlI2x5w
         dt3qx9Vc0uc1HttzLcNwJvBGxTHzE079OUXThydiF1H0fWuvUl5P2+G8ZYMKnLdSK+3u
         GY+V0Ks94q89k0RqlZ01YkgigZtV8VuTfQwzx6oeHcRWajWORiKmrEJSpgfBdy/x5NjF
         Bdng==
X-Gm-Message-State: AOJu0Yxlla3p6Jp/0uLVPEF1PACZukdpxphXUUD8Lqrxc1gGaOkOSE7/
	TG9gSYIQGRhRVPCzg1MWwec7EJD4bpeCJsLr8jLnYUydu6gt/d0yUEQe73HLCp6koZw=
X-Gm-Gg: AeBDiets299jivA3Fwu578HIoZxS+yFz0rMd3PkbiAVuPVxnJRDit4XBQ2w/o4AiuaF
	xotSHl0p7ySKl9rmVMNrevjmIr24wLvGNPaKC/a5PxEoYjdl/Q5UBnu4hA5WJBQ8Wmrn72/DhMJ
	PUeiR4RT8AAafhEbJM0IcfVnfTUoI9z5gfgapHxF7KGBAJp0FmZu/7WEbCpi1nlu5NbmbQMCmeN
	ZN598bkEHIKBVbmMB+VNxdkJM4yPGwRbao+tuFlTWoaOTu4gBbgjG2qDodneGvkOLfD7vlOajmS
	Iyu/1lpB8YTpuHu3wsKNyFHqYV2yq4z9Qc5I1X2zrrgPpwUYFfRGsV1N8e5R0IQww+NTXFuBF+P
	RM1Duc9Tr7sisjq35KPst//vWZL0ti2zULa3QEcn8lIukbrPJskDSe2buTtOVxP1w17ZWPmRf6c
	vjar81jorwUhzwawyThAY2GgOBFRcNxIIh4qyCb/6AaScLfoLtgefkL0HnOmemwPFJB1i5nb2Fz
	qRBIwH39qRlvn3STF0xPOYJ
X-Received: by 2002:a05:651c:2116:b0:38a:45d6:c246 with SMTP id 38308e7fff4ca-393783ef512mr45088291fa.8.1777935207897;
        Mon, 04 May 2026 15:53:27 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([46.246.34.10])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3939b43a795sm15774901fa.35.2026.05.04.15.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:53:26 -0700 (PDT)
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
Subject: [RFC PATCH net-next v3 0/2] udp: fix FOU/GUE over multicast
Date: Tue,  5 May 2026 01:53:08 +0300
Message-ID: <cover.1777934869.git.littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ad_dal164gVmImWl@dau-home-pc>
References: <ad_dal164gVmImWl@dau-home-pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 187D74C496A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-284072-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
    growth with nested encapsulations (Eric Dumazet)
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


