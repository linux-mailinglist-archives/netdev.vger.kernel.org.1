Return-Path: <netdev+bounces-215951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5638CB3118E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9498A223B2
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530902EB853;
	Fri, 22 Aug 2025 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBpFapXg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1128DF3A
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850547; cv=none; b=XqvBSKkpUQ79lX5RJwNxQVzlGTOeWVVTyxEw+6s/wBRlQG7cVVw1Kew10quMrduZKgNE690UnFuwhWwiy0K6QguQEHjf1WpKm6LiMxMd48Ib3kbTW/46Mw0SOW7rhsdqNzBx2jr48fI9E5XjcuIvi8aby5TFcIINCrO7StP7wN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850547; c=relaxed/simple;
	bh=QU2AXVSLsLbqgMc3HxNcJcaHAQbVNpzuBBmrdWbLeUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F8FAjzxwbDp6J0kQf5FBFFrjshIHid+a4lZekQHlofEzdz1VXHXgXKMf9G0AlwrUrZr14q043J6sRtdAf2rY1mXvD4oj744qrG/UhEg5oLRBxVXghe/vNV/IbxhH6IXvtCCq1tjR9hOJtFt5t33wB5SOkkQcEeRDWHxsc7ka8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBpFapXg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78d5dcbso272580266b.1
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 01:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755850543; x=1756455343; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2QNoRbQVV/sNhO6ufPoDJN39mA/G9BNyb8jmHOdTWHo=;
        b=LBpFapXgTx7kfun5Kw+n3+ffu5j9kVTlBVleyKK7Ew2iQd0S04OFZdC1webGT7apnr
         qsp0LCs3qBhiXAerO8TTyJzvgIvp+SKlJx/Ni/0vjL8KBVnBeQd6wD2iEAYZzr5eEBeD
         YYcDQfcjVdxiBsYSznOM1YRqWvDHf5+cQpRj776QVigvFoeBLW3sfkBdjQtdmpeJ1zPB
         CyV7Jz7Xw89nAWfofdIc+agvgZovOP3uecMmbbia5JqlJWxZzwPND26w1VfVXND4OJWu
         7+PIbyKqtSCbrFZxeKVGXLbUvLnWEjhdiWkWs+u+Gtj47p0ytkF3OgG2+L1Npq0yJu5m
         RmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850543; x=1756455343;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2QNoRbQVV/sNhO6ufPoDJN39mA/G9BNyb8jmHOdTWHo=;
        b=pVKOK+pwVXoKskRvGdIOZ/XzkU38X8Jnj/s3Y5WXfaL7hQDiMUHYcPv308aR44vBXB
         g+JImIzCkGhZkErx8fxRVo3yAbuTSlIQwe/CAJmtQBeGouvn7aaXDbJQMdUZM5xIHKzW
         +LIF+U7swXHvJSLSBTgovzea/NfiA9buA8tbM3AVXT6DqHW6DxLWOzS2cJULZHh4d+XN
         NRVpZZGaNNIavBhaNqcd1GyDorKbO9B5km+st8Hu7quMkapFs7qRxNGYnUEpdborOMYS
         7sJecGRRRbIgvMd1H6yAeNY39FKrEkcpB+Aw93G7i3xxUQgs6BkvWgoIlxpecCg0aEfO
         wHQA==
X-Gm-Message-State: AOJu0YzDGogcKPBmKI0uOVQHqCVrg6eXVL6MuNWn2uWNVDeKHMmmtPg1
	Y5Q5iHs+XsJQdsOjx8KxESiKxh/0fARBq+cqppr2LB/MWbV0fjSxy/1+R4fzIQ==
X-Gm-Gg: ASbGncvjA3ojMZgS+k7FNW6+7fQDN30OV0MXb3FQlf+A96Sw4lTEvTtP/eL6f9L3eUf
	3uOO+4iNear2BJjKC2GgSqpAV7VqklWk7R629HeDyp+JP8OvwO8Buq2bFH/OBBZZ/Tth8ucqbpU
	Tn/A6u68ZlyvUKCH05gmU8lm+fT8cnLA+aIoHASZW1kBMw6Xt0B6W/+gEkLW+cYq2eJuiReV0Qa
	aCem7O8cT9qEw/e+EzREvNilEGaJz4EWdd6l6ABupqsbj2CrEvOOAtvEwQZUjUfhuD6Y8qYtWNK
	L+Z4dI0I8qJXJBhkpgH3vmYv0xdliWE7KF1FZsDQRejqSWxQgJzJQY+hhq2WfhsAEv7wEEZILih
	GJSAePKmnAj/+omOOET067aPItCJgc8UAo3pJI1z4ylUOfXU=
X-Google-Smtp-Source: AGHT+IFhM12uBGZivhjeaZzM4KVJBaEJQwWtm/QUGH+qwacR3/87+vkGA2aU4T4HzRm+42rsJhRVsw==
X-Received: by 2002:a17:907:6d19:b0:ae3:4f99:a5a5 with SMTP id a640c23a62f3a-afe28f76149mr173092666b.6.1755850543267;
        Fri, 22 Aug 2025 01:15:43 -0700 (PDT)
Received: from bzorp3 (178-164-207-89.pool.digikabel.hu. [178.164.207.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4796f3sm556034666b.61.2025.08.22.01.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:15:42 -0700 (PDT)
Date: Fri, 22 Aug 2025 10:15:41 +0200
From: Balazs Scheidler <bazsi77@gmail.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, pabeni@redhat.com
Subject: [RFC, RESEND] UDP receive path batching improvement
Message-ID: <aKgnLcw6yzq78CIP@bzorp3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There's this patch from 2018:

commit 6b229cf77d683f634f0edd876c6d1015402303ad
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Dec 8 11:41:56 2016 -0800

    udp: add batching to udp_rmem_release()

This patch is delaying updates to the current size of the socket buffer
(sk->sk_rmem_alloc) to avoid a cache ping-pong between the network receive
path and the user-space process.

This change in particular causes an issue for us in our use-case:

+       if (likely(partial)) {
+               up->forward_deficit += size;
+               size = up->forward_deficit;
+               if (size < (sk->sk_rcvbuf >> 2) &&
+                   !skb_queue_empty(&sk->sk_receive_queue))
+                       return;
+       } else {
+               size += up->forward_deficit;
+       }
+       up->forward_deficit = 0;

The condition above uses "sk->sk_rcvbuf >> 2" as a trigger when the update is
done to the counter.  

In our case (syslog receive path via udp), socket buffers are generally
tuned up (in the order of 32MB or even more, I have seen 256MB as well), as
the senders can generate spikes in their traffic and a lot of senders send
to the same port. Due to latencies, sometimes these buffers take MBs of data
before the user-space process even has a chance to consume them.

If we were talking about video or voice streams sent over UDP, the current
behaviour makes a lot of sense: upon the very first drop, also drop
subsequent packets until things recover.  

However in the case of syslog, every message is an isolated datapoint and
subsequent packets are not related at all.

Due to this batching, the kernel always "overestimates" how full the receive
buffer is.

Instead of using 25% of the receive buffer, couldn't we use a different
trigger mechanism? These are my thoughts:
  1) simple packet counter, if the datagrams are small, byte based estimates
     can vary in number of packets (which ultimately drives the overhead here)
  2) limit the byte based limit to 64k-128k or so, is we might be in the MBs
     range with typical buffer sizes.

Both of these solutions should improve UDP syslog data loss on reception and
still amortize the modification overhead (e.g.  cache ping pong) of
sk->sk_rmem_alloc.

Here's a POC patch that implements the 2nd solution, but I think I would
prefer the first one.

Feedback welcome.

diff --git a/include/net/udp.h b/include/net/udp.h
index e2af3bda90c9..222c0267af17 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -284,13 +284,18 @@ INDIRECT_CALLABLE_DECLARE(int udpv6_rcv(struct sk_buff *));
 struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
                                  netdev_features_t features, bool is_ipv6);
 
+static inline int udp_lib_forward_threshold(struct sock *sk)
+{
+       return min(sk->sk_rcvbuf >> 2, 65536);
+}
+
 static inline void udp_lib_init_sock(struct sock *sk)
 {
        struct udp_sock *up = udp_sk(sk);
 
        skb_queue_head_init(&up->reader_queue);
        INIT_HLIST_NODE(&up->tunnel_list);
-       up->forward_threshold = sk->sk_rcvbuf >> 2;
+       up->forward_threshold = udp_lib_forward_threshold(sk);
        set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
 }
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index cc3ce0f762ec..00647213db86 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2953,7 +2953,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
                if (optname == SO_RCVBUF || optname == SO_RCVBUFFORCE) {
                        sockopt_lock_sock(sk);
                        /* paired with READ_ONCE in udp_rmem_release() */
-                       WRITE_ONCE(up->forward_threshold, sk->sk_rcvbuf >> 2);
+                       WRITE_ONCE(up->forward_threshold, udp_lib_forward_threshold(sk));
                        sockopt_release_sock(sk);
                }
                return err;

I am happy to submit a proper patch if this is something feasible. Thank you.

-- 
Bazsi
Happy Logging!

