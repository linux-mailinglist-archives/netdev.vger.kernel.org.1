Return-Path: <netdev+bounces-283362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOFgJARt9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:18:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDEE4B0C83
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0AA83055823
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF9424886E;
	Sat,  2 May 2026 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dshCLLCY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8F28689B
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691672; cv=none; b=CxVvshw2Xzp8T/AjXosC5mS12V5woCKSAqYQ9JQgj613zcwl+jkLw9R+uZCfElr8vdYq/50+XGDZFV/nyW4wDM5VSp1ANOATlanSVum6/m1OXuFGnx5fNvk7U7bytNIUTeerdTwcWMkO0vn5tH4/bGatQFHCQK02PwEs98RMJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691672; c=relaxed/simple;
	bh=wBCq0QpRUbSwLWGC1wjr5Zy46CtInDlz43M6/NbmoSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rMvZmNBqIWeyTX/syKCDik+l/EKxMRlq9iLhNlosTgMnLLPXbJzdjQY+4xp7H5ZMlmhbR18gZKnqHugF7rfdR9ucEy7XgYXJCOZgoPwtweFeF5uHAd3Na951m8bmucQULzjqh/ovaDaucYwqh5yQoka7tEE7WmdaLbChD6GLUvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dshCLLCY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3594620fe97so6508444a91.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691671; x=1778296471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AjodrhmF76GGHJ4mwgPlBR3nW5JSGHvt8OdeAKdUcm0=;
        b=dshCLLCYv/5uVA4cZWzxK2MXRWRtUkaPNYkHeNY/qxjYKyIUQzh9bCVVS7UUpC5DzS
         8ZA0HNpjiO3EgaUiKDMke4Pv+lgCdDsXlvAyv9uDZF/GODmJMevF1+hH5Qu4WGMvD2dm
         BkmPtrzYXAFKu9Gbu0c08l1Zi4dSRJREMlFat/y8Jk4Uy/xj3zisQC8Nk4gAsfU8AYRe
         +0CU3aiHO+kb8ighVSw8gcYVbEukaGmfjhSCInOTSi9PrbsaHiACaWFEfz+VxyorD0OC
         tSEXqOYaplVUIvNJvU3VkGYZ5VtkK/HpvO+8velDyb97vJ/VPQ7f8IKmahFJaApDee7a
         dJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691671; x=1778296471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjodrhmF76GGHJ4mwgPlBR3nW5JSGHvt8OdeAKdUcm0=;
        b=HPmDaNTqFeHY/SksxS+4LKrg6HxMRyz6IYB2ARoCvlsz66foWXnfTyOZARiYMb+MEY
         1XtGI+fiRT6H+bIGmYQj9DTuf1CPAYiYHv+HuZPM1RejqzibiN6J8KvfukKjM5jPH322
         1caKmA8+0KA0MMJhZrByHLVGixqtIVfopRC9YcwwHDHNHxK+kXtrdUuJFMUb92edIvDD
         1Ay4SHzUvaDaVFL7n6PaAsP1pzWGPGMZugO90gcigby1+f2trBgSq5y2pg8j5OJCaxj6
         55d7ZKF0TYmeVi5V/GHRdx0JIhW+NjvppUbyUi6KVMuJtBNUOpmCuO6xoW6t5KdKCdqz
         P7PQ==
X-Forwarded-Encrypted: i=1; AFNElJ96Hzx4QZOXxBadsbd1y/+G6eILUnbw+6sePg4jp/T5gTVOFRBwaZOgiJUMz4rdi4xifDyll1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YznIIyarw4Iz3O+8p9wGwBXuNKULO061zmbU2WKFQluvYQGjt8x
	bWQ/IVgPrXdmwNOKDtfVtH6u3Onhw+MKjcFGOzG2SpzMqVX2NAmsXXnsqWpGF1dU6z25I++alWA
	N/Vj8pg==
X-Received: from pjua2.prod.google.com ([2002:a17:90a:cb82:b0:364:7cf6:fce9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5546:b0:35e:5aa5:ae38
 with SMTP id 98e67ed59e1d1-3650cdd0233mr1702399a91.9.1777691670616; Fri, 01
 May 2026 20:14:30 -0700 (PDT)
Date: Sat,  2 May 2026 03:13:08 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-16-kuniyu@google.com>
Subject: [PATCH v1 net-next 15/15] udp_tunnel: Remove synchronize_rcu() in udp_tunnel_sock_release().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EDDEE4B0C83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283362-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vxlan.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Commit 3cf7203ca620 ("net/tunnel: wait until all sk_user_data
reader finish before releasing the sock") added synchronize_rcu()
in udp_tunnel_sock_release().

This was intended to protect the fast path of a dying vxlan device
from dereferencing vxlan_sock->sock->sk after sock_orphan() has set
sock->sk to NULL.

However, vxlan does not need to access struct socket itself
in the fast path; it only reads struct sock, and struct socket
is only used for tunnel setup and teardown.

This applies to all other UDP tunnel users, and they have been
converted to access struct sock directly.

In addition, each device-specific struct used in their fast paths
is freed after one RCU grace period.  Since this occurs after
udp_tunnel_sock_release(), the struct is guaranteed to be freed
after struct udp_sock.

Therefore, synchronize_rcu() in udp_tunnel_sock_release() is
now redundant.

Let's remove it.

Tested:

A script creating/upping vxlan devices in 4000 netns runs 10x
faster with this change.  We can see the same improvement with
other UDP tunnel devices as well.

  $ cat vxlan.sh
  for i in `seq 1 40`
  do
      (for j in `seq 1 100` ; do
            unshare -n bash -c "ip link add vxlan0 type vxlan id 100 local 127.0.0.1 dstport 4789 && ip link set vxlan0 up";
       done) &
  done
  wait

With bpftrace, we can see vxlan_stop() is significantly faster.

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
  real	0m50.615s
  user	0m8.171s
  sys	1m45.101s

  @duration_us:
  [4K, 8K)            1266 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                   |
  [8K, 16K)           1957 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [16K, 32K)           764 |@@@@@@@@@@@@@@@@@@@@                                |
  [32K, 64K)             6 |                                                    |
  [64K, 128K)            4 |                                                    |
  [128K, 256K)           3 |                                                    |

After:

  # time ./vxlan.sh // without bpftrace
  real	0m5.247s
  user	0m7.956s
  sys	1m47.404s

  @duration_us:
  [16, 32)            3411 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [32, 64)             383 |@@@@@                                               |
  [64, 128)            107 |@                                                   |
  [128, 256)            79 |@                                                   |
  [256, 512)            16 |                                                    |
  [512, 1K)              2 |                                                    |
  [1K, 2K)               2 |                                                    |

Next step is to remove another synchronize_net() in vxlan_stop()
and variants in other devices.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/udp_tunnel_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 44788b95c823..9ab3728f9630 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -194,7 +194,6 @@ void udp_tunnel_sock_release(struct sock *sk)
 	struct socket *sock = sk->sk_socket;
 
 	rcu_assign_sk_user_data(sk, NULL);
-	synchronize_rcu();
 	kernel_sock_shutdown(sock, SHUT_RDWR);
 	sock_release(sock);
 }
-- 
2.54.0.545.g6539524ca2-goog


