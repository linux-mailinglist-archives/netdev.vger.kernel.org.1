Return-Path: <netdev+bounces-228818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA981BD4C93
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 459E3502FB2
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEE130FC10;
	Mon, 13 Oct 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebBRRL2c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91830FC1E
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368965; cv=none; b=jjL+eugbmrhQ+QUNybwGslQIcAn1yWIdbwmNxDm63G9Hd0Qx9yRAcFvzZCkP5EUygjGoxrw5TXolZPZlF6p4RjJNBGrstM3JXIy2TqK9pGsoXjXhyvQdEKj3J+Y6CEXX1yfnSmAcHuAAH1ei/yf1Wd/miMXxkGeo1t4YoLsko28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368965; c=relaxed/simple;
	bh=W/FhKPyfUQJb/Ya4MUXFAbT1Kn1iW4GE9BqBVPYLLpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RfecyUFsoNJBSCw4DmV61duVnykZoFM/FXLimBrzKGGwWZ83kjlts3yFYvdDGeqOuK9sUHFs5dt2Xa5OQq9UJjcIerMEukUha11JGjvkIKH8cMP24YEhoGv06TrR2j04nmd5wfgJ3DU6Kbe4vitcpA9jg6IBBwUJGhy2u07Klh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebBRRL2c; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-78ea15d3583so210220686d6.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760368962; x=1760973762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hSenOxfpzGyhimu2TeoZHCz9ukEC8GdZb9vsU+8yLOs=;
        b=ebBRRL2cVcfTktA34nDrzwQJI9FS2beKE/cH3ud+zSYolbQl9KssuYuuHAYx3r+5Ay
         ByEo+SfVSBSx/O0yVwVWZgzlg195VsEGZcsiWN6mM9qK7FUNJL0f4555L4UwRHhj9OUl
         Elm3fQpG6HoZ3MBNM2sqPdvmh7B+aYUVJoM4xLHO4gok7aQJXtPPBlyBThmQaq0uNIZ2
         RIvZghARUhyRSIhlmh/bK49YIaa7PUYfy3yIHRvp2XHeYNk1qtFfJ7BDYPUdOgB0ZQ74
         oLppz6EOSWL+Q5G3gT0ts61SgXUantRuJbb1U9VsqIO0sUe3a3sfxeZ0hrlsCR0dBOZs
         zd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368962; x=1760973762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSenOxfpzGyhimu2TeoZHCz9ukEC8GdZb9vsU+8yLOs=;
        b=Co2rtN2O4Y1rn2x4WFVLXGYzaL9aZ1uKk0fYqo1atB07D4YLERkWpselI08ShqmCDL
         jeP7bsCGGyCBJmcVBhAXHqXcpsBi4EP7anGoBUpf0+rVapQfGVoPgKG+cKrBiQzjJ84t
         8x1+5AhVgOplbu2XujzmBN43KXGthT4pQFPfXvbux+GNNrMLyfNhRcLmyb5Hjlh92h3a
         9CFiEOENRqH07v903Ghjbf4LNv2xlsMFb67VKgXn2hlIZ649voyJCMH29AXWyerFHeFH
         GngwZyUDRETT3bM8dO7r3co8hj9yotKCjETPU3ik+iIV5+58YDygE3UDS1ywVrJ61Jbj
         0AYA==
X-Forwarded-Encrypted: i=1; AJvYcCXxf7Q+cb2k6uEzk8/Mytt8m3+nstWdX6+F2v+Ka9jcLaPwem9DnY0kE1uyQehtCoBNX0IXci4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys9SEKhYjUIGvf9UwJjo6VT7ELhWoSNKByQj8+j+BYT+Of3Yzz
	+v+uoVXshNhVoxsLwIcZ8ekvkQ/Wf7g3EBLa4F3BnECj7Nk/CaA0Mn67i5wo20TvYNa92mAZM0X
	HfXPU5hle82S1zA==
X-Google-Smtp-Source: AGHT+IH9B++kVAn2yoPFF0DDeADQDBaSMUuMeERI1HukXWiY9N0S0GBs4wfoPl976nlcDYnaT0hCq1x2uvNQrQ==
X-Received: from qtnc15.prod.google.com ([2002:ac8:518f:0:b0:4d8:7e57:97d3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5a0a:b0:4ce:dcd9:20ea with SMTP id d75a77b69052e-4e6ead59f50mr321557781cf.57.1760368962576;
 Mon, 13 Oct 2025 08:22:42 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:22:32 +0000
In-Reply-To: <20251013152234.842065-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013152234.842065-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013152234.842065-3-edumazet@google.com>
Subject: [PATCH v1 net-next 2/4] net: control skb->ooo_okay from skb_set_owner_w()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
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
  500 concurrent UDP_RR connected UDP flows, host with 32 TX queues,
  512 cpus, XPS setup.

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
Reviewed-by: Neal Cardwell <ncardwell@google.com>
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
2.51.0.740.g6adb054d12-goog


