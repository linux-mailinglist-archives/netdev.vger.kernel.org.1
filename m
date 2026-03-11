Return-Path: <netdev+bounces-266466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFK0Ipz7sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:20:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F725C5C4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94FFB3077680
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F291DF736;
	Wed, 11 Mar 2026 05:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V/uCQPPT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB038A95E
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206426; cv=none; b=WF73rHYsP6SRzHtkcGvKLlFGM3pWsuAcXXP2mwhActU8ByObNhQMGnpyHVZOERSKOlu/YwW2t7TSjiOa/lZQJpI3Jyw9jN6X3SQwJDSVoqLaKulPhatP0tIxnOvi7L1J/tmSMIEhxxrYpbqegYKts4giIe+AOCcpubRTeBiyMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206426; c=relaxed/simple;
	bh=NGfbsQcGP5MNYzuCaDJqDMjigrmtkPU3rowDKJkdXis=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N1+o9jOa9uBPKRTkTfdzu7B/iZtDlRiV3420L/FeL8QDNLpV9j0gFh1LscOyeygUdeTnDZWqZu2bkr7BvjS5fNnJQnRjzBxrLlWfXsXEV2iqDFd70MHA8ALv/FTYbqFVd7jx7EZkjBai6TeaUxcl4DtKPL2blI9+HvvEvl0aKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V/uCQPPT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae502a1dd9so126077685ad.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206424; x=1773811224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z+82GrTjVrOkmpfwmToBrtZiad6kA0Br2V7vUPhLREM=;
        b=V/uCQPPToZ0BGigej/GAJRi85v9BXKuyD9tigLATp2rE33bJ0ZrF8ZnAiOE7pKr4VF
         IwIo85N1lMUVrGHJdlcCeWkmhofkCL5vyXGXL0LGVMlUhRCcNTrzgeDeWHr9vmFs4EGa
         Th1tKTN/NzY7x2YDuCg5f7CCxuQt4VcXhk122FeXro6+aT3PVzJgJpE5DbyESFb7Rlt8
         1GeW3Q+9uRah1xFOY93UfdwU6c0tUtMNWGJlRXc6W/dJGhwrOdHSbKAfXgCQdIOg57GM
         4wSb6ZnqK0CuYX3B00lRYioZisvO+LyLfFWbBs+AopJjtq819Iap8M1mUQmGe0BH/ODe
         HETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206424; x=1773811224;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+82GrTjVrOkmpfwmToBrtZiad6kA0Br2V7vUPhLREM=;
        b=gzn0MabtciALCpMWo4mWUZNbzgMAp3LWHRQadgLThs55TWj0nzXvq9C45NAurmz/Az
         iuXXe3iYn6g4XmBvaT1PAwg2ldhHa3iLpjb+bdfTJudxb0zarL7ujqUib2KHa9VJZvh6
         MYqGvSZARiCOs36UBEf9e+PD4G2Lv8u75cziNIGPabyHJUaWvHjSI8MLprve3znppCn/
         QY5EgdeBQHzvB3zvGrTiONfzxugVMr7ainYcPKBbNhfbro0JkOC0leqsBgwkYDq5bcZ4
         G7YgwILXdzF/So8H4eCGOJl7V7+UFjKlsBhtbrUu5MFGOqlowPZZRO7Uk/MjHoJGw/Ge
         S2Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVU11qOeRa1nQg4nmryv7foNEJrWtDHmGegmz+YsoW0CFDwW4+4dt8VX5A8XW8NrAQnMCLKg5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgB792ZbwHm8M/A67e/0G5pI5Ur8ms93yu545sWQEPnA4bGWEN
	XpJ+0MRgEe3xbJqTRlvTCy8ZYySgx2vOERSrXpW+xHlysvsE5TGpCkwoQpwuxyrQX0fTqeEMu+M
	Z10DiYw==
X-Received: from plxx2.prod.google.com ([2002:a17:902:e042:b0:2ae:5fe0:d464])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a30:b0:2ae:5628:a170
 with SMTP id d9443c01a7336-2aeae90fa28mr12687755ad.46.1773206423760; Tue, 10
 Mar 2026 22:20:23 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:19:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 00/15] udp: Retire UDP-Lite.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E33F725C5C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266466-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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


Changes:
  v3:
    Patch 7: Correct ulen < skb->len case in __udp4_lib_rcv()

  v2: https://lore.kernel.org/netdev/20260305215013.2984628-1-kuniyu@google.com/
    Patch 4 : Make udp_seq_ops static
    Patch 9 : Add a detailed reason in include/uapi/linux/udp.h

  v1: https://lore.kernel.org/netdev/20260304193034.1870586-1-kuniyu@google.com/


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
 include/uapi/linux/udp.h   |   2 +
 net/core/filter.c          |   5 +-
 net/ipv4/Makefile          |   2 +-
 net/ipv4/af_inet.c         |  12 --
 net/ipv4/proc.c            |  16 --
 net/ipv4/udp.c             | 430 ++++++++++++-------------------------
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
 net/ipv6/udp.c             | 304 ++++++++++----------------
 net/ipv6/udp_impl.h        |  31 ---
 net/ipv6/udp_offload.c     |   3 +-
 net/ipv6/udplite.c         | 139 ------------
 net/rxrpc/output.c         |   2 -
 security/smack/smack_lsm.c |   4 +-
 30 files changed, 342 insertions(+), 1178 deletions(-)
 delete mode 100644 include/net/udplite.h
 delete mode 100644 net/ipv4/udp_impl.h
 delete mode 100644 net/ipv4/udplite.c
 delete mode 100644 net/ipv6/udp_impl.h
 delete mode 100644 net/ipv6/udplite.c

-- 
2.53.0.473.g4a7958ca14-goog


