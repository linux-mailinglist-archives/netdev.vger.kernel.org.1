Return-Path: <netdev+bounces-283347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SdKIHgJs9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:14:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C529C4B0C0C
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1246C3008210
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888BA29AB02;
	Sat,  2 May 2026 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUCUL/KD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD626ADC
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691647; cv=none; b=qlXTsnt5iRZ02X1mH6Iy0QJPoWqfji/ZVSBNvrtoKDDAZfpnLt+eTrh/ZugA96UDW34msgjiJbhbdi+UnP2IMQ2hf5iAyc9fXdZqNBtFDHjaYK+4tc8r1hD6/OS776WiZX+jQlqGbsflYinxgJBk+ULLRpwItFoYdfnjameOuW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691647; c=relaxed/simple;
	bh=wXHririhTYXYZLUvOVH8Q43FuQkss0RRlK0Ot1T+Z5Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UbnOc0XbnCgnjIjxoyrOx+1uckLVkndsk7YXhG/+XmaZvlG+q19z/V1+z8On2ce9aQdwLRw2PhYdmoz79ofj3WFI6QtGx9vqubAQSbo2t8pK15wDHA44c+iWZEFmn2cZ+I5MuclXxN56ySnaxzIGroWlaU0SXFR00q8/BzkcrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUCUL/KD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b24cd2e2b3so24414075ad.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691645; x=1778296445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/RDUFT/CQTwXkTqaq3WQdjOktfvPuvzfvhkFoQo3Wpo=;
        b=LUCUL/KDE45DTA2kO1sme9FBZrozYAD83ou1ir5bXAaD+QtVkYTxcNtpoOUWMzlpt0
         oaiwL7nJgE0346WkT20k9Bk+6hpSBbc01zv3DtQk+NoAG6VYe60yLkEeUStDYDP5P/Sm
         ToGs3d0d6uKL3r9IFNdB6doIZkS9VSzCpl6pfhLhfK8SurnCIqM4hx5MM8rXv5BFqCw+
         CQxFKzONNbS+VOMDLfn60dH5rZZRPEq4pJmDxojYQS864134z4hUv3Lmkf7cdIKcMDOC
         LNcoltekVe37QzMR/dzHSNYBTZ08JjQsr8VrMUeBrAZl2GwlKajc8my0XIghauERqycx
         14Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691645; x=1778296445;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/RDUFT/CQTwXkTqaq3WQdjOktfvPuvzfvhkFoQo3Wpo=;
        b=a75fyiTqUDuUHlyHo9EzfTB8Y/t6EwvrSMqEiPE9LePqRrhqg1kg1Vmn1wLabm8lCP
         JN1ONBW3YCOxrc94YQd+grOMzpcfy1Jzko7ZijoxU9HkebF84UyEJmMlMqALpyTave78
         RheDLerpIhwt8jkwaXT2M4dAYJQ6ppp43CmrgJmoNOHAfNziHmuS4eVdMtTS3xen8rOB
         qGIqJ+IabhOmmmA0OYVvNq3LcovMKruMdzJw9xcCdvZmdZPRhrGFsO/sjSdn/MvRV2+i
         2hSJzxbfGAMthoklbLAnxDbURqJB9EMMNeEnWa4fJzAf2pynQxV3w3cLbraKxyYWBmc6
         y8iQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WaRYFBHoWU5Q9GkzaB2Mgt9sBeO5O7WGN31dDPoaf61bDsHwQweiZpq1gqGGcf2vVaimq4H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbuQMrqhAkrIgvVHWQZX1n+6n73pFD0GNEdqnoBpQ1BPPIaIp7
	SS4D7QNh6fJutkFOCk4lxb4GjplkuVNcCzso2Kg3b7bJNezWwWjeals6N5P4UglCIBgoCxrFcM1
	3/2znMg==
X-Received: from pfbgj12.prod.google.com ([2002:a05:6a00:840c:b0:82f:4d28:b8c5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a803:b0:82f:6b6f:13ec
 with SMTP id d2e1a72fcca58-8352d2b29ebmr1622623b3a.34.1777691645064; Fri, 01
 May 2026 20:14:05 -0700 (PDT)
Date: Sat,  2 May 2026 03:12:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 00/15] udp_tunnel: Speed up UDP tunnel device
 destruction (Part I)
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C529C4B0C0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283347-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vxlan.sh:url]

Most of the UDP tunnel devices call synchronize_rcu() twice
during destruction, for example, vxlan has

  1) synchronize_rcu() in udp_tunnel_sock_release()

  2) synchronize_net() in vxlan_sock_release()

The goal of this series is to remove the former, and another
followup series removes the latter.

synchronize_rcu() was added in udp_tunnel_sock_release() by
commit 3cf7203ca620 ("net/tunnel: wait until all sk_user_data
reader finish before releasing the sock").

This was intended to protect the fast path of a dying vxlan
from dereferencing vxlan_sock->sock->sk after sock_orphan()
has set sock->sk to NULL.

Most of the UDP tunnel devices store struct socket to its
private struct, but it is NOT needed in the fast paths;
struct sock is used there, but struct socket is only used
for tunnel setup / teardown.

This is probably because UDP tunnel functions accept struct
socket, but even such functions do not need it, except for
udp_tunnel_sock_release(), which can safely access sk->sk_socket.

The overview of the series:

  Patch 1 -  5 : Convert UDP tunnel helper to take struct sock
  Patch 6      : Small fix for 10-years-old bug
  Patch 7 - 14 : Store struct sock in tunnel devices
  Patch 15     : Remove synchronize_rcu() in udp_tunnel_sock_release()

  (I noted bugs of fou and amt, so Sashiko may point out
   such pre-existing issues in fou, amt, .. and pfcp and tipc,
   but they are orthogonal and I can follow up separately.)

With this change, a script creating/upping vxlan in 4000 netns
runs 10x faster.

  $ cat vxlan.sh
  for i in `seq 1 40`
  do
      (for j in `seq 1 100` ; do
            unshare -n bash -c "ip link add vxlan0 type vxlan id 100 local 127.0.0.1 dstport 4789 && ip link set vxlan0 up";
       done) &
  done
  wait

With bpftrace, we can see vxlan_stop() is significantly faster too.

  bpftrace -e '
  kprobe:vxlan_stop {
          @start[tid] = nsecs;
  }

  kretprobe:vxlan_stop /@start[tid]/ {
          @duration_us = hist((nsecs - @start[tid]) / 1000);
          delete(@start[tid]);
  }

  END {
          printf("\nExecution time of vxlan_stop (us):\n");
  }'

Before:

  # time ./vxlan.sh // without bpftrace
  real  0m50.615s
  user  0m8.171s
  sys   1m45.101s

  @duration_us:
  [4K, 8K)            1266 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                   |
  [8K, 16K)           1957 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [16K, 32K)           764 |@@@@@@@@@@@@@@@@@@@@                                |
  [32K, 64K)             6 |                                                    |
  [64K, 128K)            4 |                                                    |
  [128K, 256K)           3 |                                                    |

After:

  # time ./vxlan.sh // without bpftrace
  real  0m5.247s
  user  0m7.956s
  sys   1m47.404s

  @duration_us:
  [16, 32)            3411 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [32, 64)             383 |@@@@@                                               |
  [64, 128)            107 |@                                                   |
  [128, 256)            79 |@                                                   |
  [256, 512)            16 |                                                    |
  [512, 1K)              2 |                                                    |
  [1K, 2K)               2 |                                                    |


Kuniyuki Iwashima (15):
  udp_tunnel: Pass struct sock to udp_tunnel_sock_release().
  udp_tunnel: Pass struct sock to setup_udp_tunnel_sock().
  udp_tunnel: Pass struct sock to udp_tunnel6_dst_lookup().
  udp_tunnel: Pass struct sock to udp_tunnel_{push,drop}_rx_port().
  udp_tunnel: Pass struct sock to udp_tunnel_notify_{add,del}_rx_port().
  vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().
  vxlan: Store struct sock in struct vxlan_sock.
  vxlan: Free vxlan_sock with kfree_rcu().
  geneve: Store struct sock in struct geneve_sock.
  bareudp: Store struct sock in struct bareudp_dev.
  fou: Store struct sock in struct fou.
  amt: Store struct sock in struct amt_dev.
  pfcp: Store struct sock in struct pfcp_dev.
  tipc: Store struct sock in struct udp_bearer.
  udp_tunnel: Remove synchronize_rcu() in udp_tunnel_sock_release().

 drivers/infiniband/sw/rxe/rxe_net.c |  6 +--
 drivers/infiniband/sw/rxe/rxe_ns.c  |  4 +-
 drivers/net/amt.c                   | 80 ++++++++++++++---------------
 drivers/net/bareudp.c               | 51 +++++++++---------
 drivers/net/geneve.c                | 54 +++++++++----------
 drivers/net/gtp.c                   | 10 ++--
 drivers/net/ovpn/udp.c              |  2 +-
 drivers/net/pfcp.c                  | 17 +++---
 drivers/net/vxlan/vxlan_core.c      | 60 ++++++++++++----------
 drivers/net/vxlan/vxlan_multicast.c |  8 +--
 drivers/net/wireguard/socket.c      |  8 +--
 include/net/amt.h                   |  2 +-
 include/net/udp_tunnel.h            | 14 ++---
 include/net/vxlan.h                 |  5 +-
 net/ipv4/fou_core.c                 | 21 ++++----
 net/ipv4/udp_tunnel_core.c          | 23 ++++-----
 net/ipv6/ip6_udp_tunnel.c           |  6 +--
 net/l2tp/l2tp_core.c                |  2 +-
 net/rxrpc/local_object.c            |  2 +-
 net/sctp/protocol.c                 | 10 ++--
 net/tipc/udp_media.c                | 32 +++++++-----
 21 files changed, 209 insertions(+), 208 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog


