Return-Path: <netdev+bounces-228196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44214BC46D0
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 12:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CE53BBF58
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 10:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6312F6566;
	Wed,  8 Oct 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIviolnK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96B2F6183
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920382; cv=none; b=Sh0r6XN0m6yZ6XWSFSpOHZ+iqWLjEJEdu8vbpY9kyspDNh057x4CF4Yw4bkxehH5GXZAaI4SJBoNUx4uMxcmEbOQXgQSB2bCN57NmrOaQyfSAbI709t17jqYfXiDeeV33c+y0MLtUZHzex2liSfnUitDaABTE4iXQVCxMxQ4Rvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920382; c=relaxed/simple;
	bh=jXK9plrnWpdcG1P9wFguvBYw5XCYHL1nqMkUo1NYVe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eqCYYGXovT4zfsRKVKvQl3I5I5/3pB1vI8QZrVy955Sw7YyFASRCNGCVTwRC3YkRX73Mgd427ec3Z4nOLxjGF7fPYLwuiZmx2AIYNblqsmWfBJhk/TWjzlob+hOPssVrhbiNMeJ4wgA/DwjdYAFrOiYNFZaN2RLf2XqKk1Wge18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIviolnK; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-829080582b4so1723227185a.0
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759920380; x=1760525180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mspX0Cndg7foCr8RWp/98mA4nBTHoKbfVmF6ljYPfb0=;
        b=OIviolnK2J7l1Sex7wMsbJvLa7bI7pM0BTgZtK25jejha2tV84PYi1ZZjOqvyIDuL+
         71It5yjTqoTYhSlq08UYzJgenhs/rvETo6Bw0kG7oN/UduFMUiMrMrdOsQLD++Hkv1pm
         nsyVUC+jXcWD0vrxDzQidEE2muqOuWapZeiDJVP9pA/cVEL6Zy0Si93e718u8vIwmrlF
         Qwr9pgBeBi3n5viI72ZvfPiKVpjCmenMvCvVG1wyrAzEE4FN6rf3b9Ijzt7whWMFubKm
         5l66Vpic+Scznzv5ROh4p2j8YCc+kVaMptjnC8Rojwk6+6DPsjKhM7aZRjb5hmd71BrO
         A7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920380; x=1760525180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mspX0Cndg7foCr8RWp/98mA4nBTHoKbfVmF6ljYPfb0=;
        b=WzQd8f1KjWpv3a/3ID4pi5q1PjWocwWTYLp0c9jAVa0y4+YuCEjO8CKUmrg3QN1a8/
         VgnVVKH2xvjtMRl/sSQeCHsWWbm3wKLNdk2y5JAhOudlVrZRtHJMcX6TsKVdNBzPTzdd
         AU49T5nbAUMhAgW4xPfWrYU/TV2nDOdt2pk08ZPVLKlMCKoqzQkJ2qJUa8eiVFlJe2vC
         8TMC9PHoO7LoU9JG+B1DSTbJA+ervqzn1ESXDyHb7Oh87gs70WHHq0nM2exFmLQnjHbU
         fpRd6mR6fn1ObztJELfckAMQhc/QEHdctq+1bq9z2B9os7GopGlvR9ru/b9d7KKn/dYN
         K0/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv6K1kThRqJOpuqyF/gSI6JCC8eIxUdUtRq1tA81otvD6IplTXpQO3TsOTSl6RnWnQ+qrAFcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsh9dlzUg4JpuOZvFs99InHVe5soZ7TB1DdHubCaxxV1dFr+II
	bC7uY/z/t8vJMY+swxhQMLBIrmfuDTIAL7I1Fod/SxOuJ34/q2p8LZFt2yovtJpUkg9weJgds8j
	D/uLEGdojs+GJBQ==
X-Google-Smtp-Source: AGHT+IHcso8YoxHzVghKmHiW0eO+xfx1P9MfU03tT6u88FdTD5cd8xV3XrvSuQWsE0r5x3CUdFFuYoLpSbGH1Q==
X-Received: from qkph19.prod.google.com ([2002:a05:620a:2853:b0:856:f2ec:2971])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a1cc:b0:883:c768:1fff with SMTP id af79cd13be357-883c76827a5mr150182985a.3.1759920378677;
 Wed, 08 Oct 2025 03:46:18 -0700 (PDT)
Date: Wed,  8 Oct 2025 10:46:09 +0000
In-Reply-To: <20251008104612.1824200-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008104612.1824200-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008104612.1824200-3-edumazet@google.com>
Subject: [PATCH RFC net-next 2/4] net: control skb->ooo_okay from skb_set_owner_w()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

15 years after Tom Herbert added skb->ooo_okay, only TCP transport
benefits from it.

We can support other transports directly from skb_set_owner_w().

If no other TX packet for this socket is in a host queue (qdisc, NIC queue)
there is no risk of self-inflicted reordering, we can set skb->ooo_okay.

This allows netdev_pick_tx() to choose a TX queue based on XPS settings,
instead of reusing the queue chosen at the time the first packet was sent
for connected sockets.

Tested:
  500 concurrent UDP_RR connected UDP flows, host with 32 TX queues, XPS setup.

  super_netperf 500 -t UDP_RR -H <host> -l 1000 -- -r 100,100 -Nn &

This patch saves between 10% and 20% of cycles, depending on how
process scheduler migrates threads among cpus.

Using following bpftrace script, we can see the effect on Qdisc/NIC tx queues
being better used (less cache line misses).

bpftrace -e '
k:__dev_queue_xmit { @start[cpu] = nsecs; }
kr:__dev_queue_xmit {
 if (@start[cpu]) {
    $delay = nsecs - @start[cpu];
    delete(@start[cpu]);
    @__dev_queue_xmit_ns = hist($delay);
 }
}
END { clear(@start); }'

Before:
@__dev_queue_xmit_ns:
[128, 256)             6 |                                                    |
[256, 512)        116283 |                                                    |
[512, 1K)        1888205 |@@@@@@@@@@@                                         |
[1K, 2K)         8106167 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    |
[2K, 4K)         8699293 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[4K, 8K)         2600676 |@@@@@@@@@@@@@@@                                     |
[8K, 16K)         721688 |@@@@                                                |
[16K, 32K)        122995 |                                                    |
[32K, 64K)         10639 |                                                    |
[64K, 128K)          119 |                                                    |
[128K, 256K)           1 |                                                    |

After:
@__dev_queue_xmit_ns:
[128, 256)             3 |                                                    |
[256, 512)        651112 |@@                                                  |
[512, 1K)        8109938 |@@@@@@@@@@@@@@@@@@@@@@@@@@                          |
[1K, 2K)        16081031 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2K, 4K)         2411692 |@@@@@@@                                             |
[4K, 8K)           98994 |                                                    |
[8K, 16K)           1536 |                                                    |
[16K, 32K)           587 |                                                    |
[32K, 64K)             2 |                                                    |

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 542cfa16ee125f6c8487237c9040695d42794087..08ae20069b6d287745800710192396f76c8781b4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2694,6 +2694,8 @@ void __sock_wfree(struct sk_buff *skb)
 
 void skb_set_owner_w(struct sk_buff *skb, struct sock *sk)
 {
+	int old_wmem;
+
 	skb_orphan(skb);
 #ifdef CONFIG_INET
 	if (unlikely(!sk_fullsock(sk)))
@@ -2707,7 +2709,15 @@ void skb_set_owner_w(struct sk_buff *skb, struct sock *sk)
 	 * is enough to guarantee sk_free() won't free this sock until
 	 * all in-flight packets are completed
 	 */
-	refcount_add(skb->truesize, &sk->sk_wmem_alloc);
+	__refcount_add(skb->truesize, &sk->sk_wmem_alloc, &old_wmem);
+
+	/* (old_wmem == SK_WMEM_ALLOC_BIAS) if no other TX packet for this socket
+	 * is in a host queue (qdisc, NIC queue).
+	 * Set skb->ooo_okay so that netdev_pick_tx() can choose a TX queue
+	 * based on XPS for better performance.
+	 * Otherwise clear ooo_okay to not risk Out Of Order delivery.
+	 */
+	skb->ooo_okay = (old_wmem == SK_WMEM_ALLOC_BIAS);
 }
 EXPORT_SYMBOL(skb_set_owner_w);
 
-- 
2.51.0.710.ga91ca5db03-goog


