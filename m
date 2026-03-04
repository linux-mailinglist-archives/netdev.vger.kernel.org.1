Return-Path: <netdev+bounces-264012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGaNOWOIqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:30:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F7207154
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04E073011C7B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F75D376BD1;
	Wed,  4 Mar 2026 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2LXlLdz2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655434CFC2
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652639; cv=none; b=As1WJQfiONroobC83JdT583u+e246IYGbMGQjjUjt1fvIg47NhzHHkp6iaqUhHuhfjLfF2A+pXfVxB3j9M/YxXGzL6fhpmq5rA//yTtDaZqMFD+XI2Mmpw81XxVF1lmVZZTCQuppBK5cT3VwURd6iqsV+YFM7pa8JrxTP2RAdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652639; c=relaxed/simple;
	bh=KdDrrSPFChkOCvwlE4sINJWAHAXI85/+htnd/gpYJR0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bdrH2btcJv3G6d6leiWv5O0sdlj1R3zRjwmFEOukooinpZyyM/TlaE5AonoTOW5CjbEzIZcq/a8il6ebH3o4BVFqXqPtbTt7yyU04FRrZdUE2577oINT6k8o6HHbXm8CS1QfXAJnOWxIUx4TKhv5raoPPGniDZstNaFS/EP9Kt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2LXlLdz2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae4e20a414so186024905ad.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652637; x=1773257437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zOMLvWDF2e65j8tZFnA/xPLlq5PvNTf2e06WG217hEk=;
        b=2LXlLdz2KUZrjIyUacKmb0oxW2URGXd3kU0WVEmJIJOxhczcWh//VE7uwqXu0qd1zC
         1GSWs7+uiiqwokfz1XkL+cAQAgVM+wvaLNIMAcpYbdR6iunTn+KfWRAPNGSAokCkZHEA
         pZGQ4wR+XH93NZ0jV8/Us3bh1rddubsls37wMVrd/62qPX43o0ys/EPqd94x7FLil5t0
         VLhvOHuoIbrSM/raOp/+TTYSim0LyRRaertqNh9Z9dd7IgPf7q9bBc77Eqbl0jWdqSAJ
         0NCI2WuAZKL30y1KOqQ749KrnH+NLg4IHU3BT/+1/bgGAqzo7ELslsTzCYhGjKGqSV/u
         jIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652637; x=1773257437;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOMLvWDF2e65j8tZFnA/xPLlq5PvNTf2e06WG217hEk=;
        b=dT2QmOF1UKyt39amW05WLtMx+RtzJ1zAoSAFoLRb7+DgcwJS0ceLmizZu7xfJ/jald
         dM1PXPc7AV5aUDYE23vcHLqN/2hWtA+2ebf2FMCqYQzAqz4h7QTEModIFfRr95RNn1sM
         UJSf5cM2901oWpzWOcU0SSMKBlSpOp03q4hq2JucnoNF99mbll857AnqCfsLk1XM1fm1
         JaVid2xmpdn8NLDnBii/Sxbe3PjYuu1au2LnRmAmMnEcbaQJN9ptfWIgXkVbzby7jmJg
         BeQdEKzK3cW7WwRNcBuQ5YTXcCv/IAKtSKNo6S+2afHLgk1242SycOGc6ehiLh1ToDhQ
         Zc7w==
X-Forwarded-Encrypted: i=1; AJvYcCWNXLmVlMHzuRzHSYjPQExWVT/BNucFN6KhhPetwUqywAyOzpnCmQQC6+MVsNAb+gPF8qWQq5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3QzTgQVQ2QEgmxpyEtrQo0Zg3qq5D35Mrzn/vnFEmbqHygua
	r7QOEVSg+alYrT8SxYOCQ0H8zWuNxl6GF6adDNgb/NDU7SbwktdEK2U3kFH4/8IxLKvP6jfLQeF
	gEnvqEw==
X-Received: from ploo12.prod.google.com ([2002:a17:902:e00c:b0:2ae:478e:82bd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fa44:b0:2ae:55eb:f82d
 with SMTP id d9443c01a7336-2ae6aa02142mr22877965ad.1.1772652637412; Wed, 04
 Mar 2026 11:30:37 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 00/15] udp: Retire UDP-Lite.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 611F7207154
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264012-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

In 2023, syzbot found a null-ptr-deref bug triggered when UDP-Lite
attempted to charge an skb after the total memory usage for UDP-Lite
_and_ UDP exceeded a system-wide threshold, net.ipv4.udp_mem[1].

Since this threshold is shared with UDP, the bug would have been
easy to trigger if any real-world applications were using UDP-Lite;
however, only syzbot ever stumbled upon it.

The bug had persisted since 2016, suggesting that UDP-Lite had
remained unused for 7 years at that point.

The bug was fixed in commit ad42a35bdfc6 ("udplite: Fix NULL pointer
dereference in __sk_mem_raise_allocated()."), and we added another
commit be28c14ac8bb ("udplite: Print deprecation notice.") to
announce the deprecation plan.

Since then, no one has complained, so it is time to officially
retire UDP-Lite.

This series first removes IPv6 and IPv4 UDP-Lite sockets, then
gradually cleans up the remaining dead/unnecessary code within
the UDP stack.

By removing a bunch of conditionals for UDP-Lite from the fast
path, udp_rr with 20,000 flows sees a 10% increase in pps
(13.3 Mpps -> 14.7 Mpps)  on an AMD EPYC 7B12 (Zen 2) 64-Core
Processor platform.

[ With FDO, the baseline is much higher and the delta was ~3%,
  20.1 Mpps -> 20.7 Mpps ]

Before:

$ nstat > /dev/null; sleep 1; nstat | grep Udp
Udp6InDatagrams                 14013408           0.0
Udp6OutDatagrams                14013128           0.0

After:

$ nstat > /dev/null; sleep 1; nstat | grep Udp
Udp6InDatagrams                 15491971           0.0
Udp6OutDatagrams                15491671           0.0

$ ./scripts/bloat-o-meter vmlinux.before vmlinux.after
add/remove: 13/75 grow/shrink: 11/75 up/down: 13777/-18401 (-4624)
Function                                     old     new   delta
udp4_gro_receive                             872     866      -6
udp6_gro_receive                             910     903      -7
udp_rcv                                       32    1727   +1695
udpv6_rcv                                     32    1450   +1418
__udp4_lib_rcv                              2045       -   -2045
__udp6_lib_rcv                              2084       -   -2084
udp_unicast_rcv_skb                          160     149     -11
udp6_unicast_rcv_skb                         196     181     -15
__udp4_lib_mcast_deliver                     925     846     -79
__udp6_lib_mcast_deliver                     922     810    -112
__udp4_lib_lookup                            973     969      -4
__udp6_lib_lookup                            940     929     -11
__udp4_lib_lookup_skb                        106     100      -6
__udp6_lib_lookup_skb                         71      66      -5
udp4_lib_lookup_skb                          132     127      -5
udp6_lib_lookup_skb                           87      81      -6
udp_queue_rcv_skb                            326     356     +30
udpv6_queue_rcv_skb                          331     361     +30
udp_queue_rcv_one_skb                       1233     914    -319
udpv6_queue_rcv_one_skb                     1250     930    -320
__udp_enqueue_schedule_skb                  1067     995     -72
udp_rcv_segment                              520     480     -40
udp_post_segment_fix_csum                    120       -    -120
udp_lib_checksum_complete                    200      84    -116
udp_err                                       27    1103   +1076
udpv6_err                                     36    1417   +1381
__udp4_lib_err                              1112       -   -1112
__udp6_lib_err                              1448       -   -1448
udp_recvmsg                                 1149     994    -155
udpv6_recvmsg                               1349    1294     -55
udp_sendmsg                                 2730    2648     -82
udp_send_skb                                 909     681    -228
udpv6_sendmsg                               3022    2861    -161
udp_v6_send_skb                             1214     952    -262
...
Total: Before=18446744073748075501, After=18446744073748070877, chg -0.00%


Kuniyuki Iwashima (15):
  udp: Make udp[46]_seq_show() static.
  ipv6: Retire UDP-Lite.
  ipv6: Remove UDP-Lite support for IPV6_ADDRFORM.
  ipv4: Retire UDP-Lite.
  udp: Remove UDP-Lite SNMP stats.
  smack: Remove IPPROTO_UDPLITE support in security_sock_rcv_skb().
  udp: Remove partial csum code in RX.
  udp: Remove partial csum code in TX.
  udp: Remove UDPLITE_SEND_CSCOV and UDPLITE_RECV_CSCOV.
  udp: Remove struct proto.h.udp_table.
  udp: Remove udp_table in struct udp_seq_afinfo.
  udp: Remove dead check in __udp[46]_lib_lookup() for BPF.
  udp: Don't pass udptable to IPv6 socket lookup functions.
  udp: Don't pass udptable to IPv4 socket lookup functions.
  udp: Don't pass proto to __udp4_lib_rcv() and __udp6_lib_rcv().

 include/linux/udp.h        |  10 +-
 include/net/ipv6.h         |   2 -
 include/net/ipv6_stubs.h   |   7 +-
 include/net/netns/mib.h    |   5 -
 include/net/sock.h         |   5 +-
 include/net/transp_v6.h    |   3 -
 include/net/udp.h          |  86 +++-----
 include/net/udplite.h      |  88 --------
 include/uapi/linux/udp.h   |   1 +
 net/core/filter.c          |   5 +-
 net/ipv4/Makefile          |   2 +-
 net/ipv4/af_inet.c         |  12 --
 net/ipv4/proc.c            |  16 --
 net/ipv4/udp.c             | 426 ++++++++++++-------------------------
 net/ipv4/udp_bpf.c         |   2 -
 net/ipv4/udp_diag.c        | 128 +++--------
 net/ipv4/udp_impl.h        |  27 ---
 net/ipv4/udp_offload.c     |   3 +-
 net/ipv4/udplite.c         | 135 ------------
 net/ipv6/Makefile          |   2 +-
 net/ipv6/af_inet6.c        |  32 +--
 net/ipv6/ip6_checksum.c    |   2 +-
 net/ipv6/ipv6_sockglue.c   |  17 +-
 net/ipv6/proc.c            |  16 --
 net/ipv6/udp.c             | 305 ++++++++++----------------
 net/ipv6/udp_impl.h        |  31 ---
 net/ipv6/udp_offload.c     |   3 +-
 net/ipv6/udplite.c         | 139 ------------
 net/rxrpc/output.c         |   2 -
 security/smack/smack_lsm.c |   4 +-
 30 files changed, 339 insertions(+), 1177 deletions(-)
 delete mode 100644 include/net/udplite.h
 delete mode 100644 net/ipv4/udp_impl.h
 delete mode 100644 net/ipv4/udplite.c
 delete mode 100644 net/ipv6/udp_impl.h
 delete mode 100644 net/ipv6/udplite.c

-- 
2.53.0.473.g4a7958ca14-goog


