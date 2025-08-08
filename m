Return-Path: <netdev+bounces-212137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A59B1E558
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B501886ABA
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 09:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3CA267B9B;
	Fri,  8 Aug 2025 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="L4ZzXFqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0925484D
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644215; cv=none; b=p9PAigw8E7U2vng0aElznn/LOSk49h96N46UlRtI1iEzMuFFWlMg1FgOCWo9S1F58eT5AXquy/uZjPIcBtwtH1wzTS5anRbKD5t0jzervV5v7zaDyEyCt6azXnaX78PXBwclY44TN7/EC7dYCMOJGKTDloNpXB4A9u4US8o9kjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644215; c=relaxed/simple;
	bh=s11bYWDT411uqYEHnodO5z7alSrx7xe4UlVL6ovHZDQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z6xKT5tdvvQJKwokVMdWOCQNEjFUJKKrRWcT4cZqXn3fQ8K1tgwzIYAdMqPGXgN+If0kPpxdvkeMenplVkcNScg1CqssT0Ls4PFbRHMgMhVN+ySnaDBqWSyfz8fp9702mRy4PCEioT3gGx297d92ZRphw6ip7RBeIKoukyX9IwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=L4ZzXFqr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af9180a11bcso394558666b.0
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 02:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754644212; x=1755249012; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc8TtJ2T+21rKk5sZriubHeBdKoImIF/z2CCu0uA5gs=;
        b=L4ZzXFqrA5qsg4L4ZeXKC95JP40+PMjdBckc4n1ycVzJt8MJldNRz6pS/fYXK2SP8M
         ELAgysOeRM76+bHw7fLRdZ7NHxEG0LEkUqeApo7RsKg5LHwQnW0w/7z7sae2kKTrtl3Z
         uRriYu/kGL+7jL3h4RQIyM6g3ujOKk72AZ1U+dvFvAUyFK2gOJPGD7DrE92r4phZJA5i
         sWZci8gHNGbRwjNimSVYUCZk0d1ppvfezjj9j3MbFU0QSCHixu5ie2SZz57c4j6/XJSG
         AhRD/SJlnxL0Xxw4Rx4GdYsIObaa2vvvD5DySiV8MS+NpRxAM9+iNX9FUAmuBw8HNdDq
         CS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754644212; x=1755249012;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dc8TtJ2T+21rKk5sZriubHeBdKoImIF/z2CCu0uA5gs=;
        b=S3VK9p4Fneou8QJR+PS3DePQ3C7TMNBPtFTyPUlO6Xb33JGBG1f1uoy4WfyZyd1pwz
         7GJJRvafjjb4O5aIjru0veCFiAyu2tlCgDg0icFabkkCDNozYa4qYMvDAd0brYQvFgC7
         R6nSOf7ql6akT+ezOQ9y8keJpDIKvtzpATAkyXkFVf8voHuUsIOjjmaGR8HR+1WkLC0l
         xYPp31zdy7Td0mseqHaVFuIG99jVVvwWz/oTrYnOYMtqbR2aI9EiFZ8l1QoDwZrqR/8t
         wzcQs5OVLfZa4vwKipom3NkUUg/lhveG82tyNZeeWXEV8vS7ChIe+D+JYa1DzoI5tdcG
         Mi1Q==
X-Gm-Message-State: AOJu0YwZH+8z4/RBb2KCl71m9Z7E+mv91noQ2DV2iU+SA0jojdR6P6j3
	cJ8iiiBooyCAwg3CZk+xQRQUffRhGdx6h0dHUMRFYRy7j+0qArQ9PgJJKCLShWueJRQ=
X-Gm-Gg: ASbGncv8s5jxFs/bdoU3nL0PYVYO+j2vIrkX+IQ9l13cjZfdkcwdaisvgN2atQPYUTb
	V+BROR9BqZzCpS3Vb2l3R/5Zj9bV0bYhat+1Vst2IU+fLbXLrbTv4bxi9hh99h+FlzdVx0FY9iT
	XSxz5uioKa4TXQd743VguJK9UxVUjPqIyXmyCJZEVeoJoIuczTvW6muK28za0lkUgFVlqkt19Mj
	cPz+ZW93ueeklTNYTbr8wuQL2ZUgJZxPLow+bIFlDiL6+V2KobPg0KGyHGSYhVnlT/yfzoWHAAM
	VOdOZ40M8fHO9nFfimYv7VFXtjT4S3BXDzaVVLH1NVeBTscw8RpQEXfP3e2CcEVEfdemnWAjQ/x
	P2khxWRrXN08rWwztjuABq/UoYYGTYb382mwtT6pEJe//o10wk+ztWxii3tGRBJVFVMv7vro=
X-Google-Smtp-Source: AGHT+IHXAz4yVTxHvX470uUfwfiOC6JJYvOmiNqhFjtbWc5aLpWrIRr5mnvpc+vNnegq/w1Q93Klfg==
X-Received: by 2002:a17:906:36d7:b0:af9:bfed:fbae with SMTP id a640c23a62f3a-af9bfee01efmr264767666b.10.1754644211795;
        Fri, 08 Aug 2025 02:10:11 -0700 (PDT)
Received: from cloudflare.com (79.184.123.100.ipv4.supernova.orange.pl. [79.184.123.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f385absm12757640a12.29.2025.08.08.02.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 02:10:10 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH RFC net-next 0/2] tcp: Update bind bucket state on port
 release
Date: Fri, 08 Aug 2025 11:10:00 +0200
Message-Id: <20250808-update-bind-bucket-state-on-unhash-v1-0-faf85099d61b@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOi+lWgC/x2NQQrCMBBFrxJm7UAMhla3ggdwKy7SZmoGYVoyi
 RRK7250+T68/zZQykwKF7NBpg8rz9LgeDAwpiAvQo6NwVnnbW87rEsMhXBgiTjU8U0FtfyWWbB
 KCppw6k/OB9+5s4vQjpZME6//yAPut6uRJgmtBZ77/gX2VRPdggAAAA==
X-Change-ID: 20250807-update-bind-bucket-state-on-unhash-f8425a57292d
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com, 
 Lee Valentine <lvalentine@cloudflare.com>
X-Mailer: b4 0.15-dev-07fe9

TL;DR
-----

This is another take on addressing the issue we already raised earlier [1].

This time around, instead of trying to relax the bind-conflict checks in
connect(), we make an attempt to fix the tcp bind bucket state accounting.

The goal of this patch set is to make the bind buckets return to "port
reusable by ephemeral connections" state when all sockets blocking the port
from reuse get unhashed.

Situation
---------

We observe the following scenario in production:

                                                  inet_bind_bucket
                                                state for port 54321
                                                --------------------

                                                (bucket doesn't exist)

// Process A opens a long-lived connection:
s1 = socket(AF_INET, SOCK_STREAM)
s1.setsockopt(IP_BIND_ADDRESS_NO_PORT)
s1.setsockopt(IP_LOCAL_PORT_RANGE, 54000..54500)
s1.bind(192.0.2.10, 0)
s1.connect(192.51.100.1, 443)
                                                tb->fastreuse = -1
                                                tb->fastreuseport = -1
s1.getsockname() -> 192.0.2.10:54321
s1.send()
s1.recv()
// ... s1 stays open.

// Process B opens a short-lived connection:
s2 = socket(AF_INET, SOCK_STREAM)
s2.setsockopt(SO_REUSEADDR)
s2.bind(192.0.2.20, 0)
                                                tb->fastreuse = 0
                                                tb->fastreuseport = 0
s2.connect(192.51.100.2, 53)
s2.getsockname() -> 192.0.2.20:54321
s2.send()
s2.recv()
s2.close()

                                                // bucket remains in this
                                                // state even though port
                                                // was released by s2
                                                tb->fastreuse = 0
                                                tb->fastreuseport = 0

// Process A attempts to open another connection
// when there is connection pressure from
// 192.0.2.30:54000..54500 to 192.51.100.1:443.
// Assume only port 54321 is still available.

s3 = socket(AF_INET, SOCK_STREAM)
s3.setsockopt(IP_BIND_ADDRESS_NO_PORT)
s3.setsockopt(IP_LOCAL_PORT_RANGE, 54000..54500)
s3.bind(192.0.2.30, 0)
s3.connect(192.51.100.1, 443) -> EADDRNOTAVAIL (99)

Problem
-------

We end up in a state where Process A can't reuse ephemeral port 54321 for
as long as there are sockets, like s1, that keep the bind bucket alive. The
bucket does not return to "reusable" state even when all sockets which
blocked it from reuse, like s2, are gone.

The ephemeral port becomes available for use again only after all sockets
bound to it are gone and the bind bucket is destroyed.

Programs which behave like Process B in this scenario - that is, binding to
an IP address without setting IP_BIND_ADDRESS_NO_PORT - might be considered
poorly written. However, the reality is that such implementation is not
actually uncommon. Trying to fix each and every such program is like
playing whack-a-mole.

For instance, it could be any software using Golang's net.Dialer with
LocalAddr provided:

        dialer := &net.Dialer{
                LocalAddr: &net.TCPAddr{IP: srcIP},
        }
        conn, err := dialer.Dial("tcp4", dialTarget)

Or even a ubiquitous tool like dig when using a specific local address:

        $ dig -b 127.1.1.1 +tcp +short example.com

Hence, we are proposing a systematic fix in the network stack itself.

Solution
--------

Please see the description in patch 1.

[1] https://lore.kernel.org/r/20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com

Reported-by: Lee Valentine <lvalentine@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (2):
      tcp: Update bind bucket state on port release
      selftests/net: Test tcp port reuse after unbinding a socket

 include/net/inet_connection_sock.h           |   5 +-
 include/net/inet_hashtables.h                |   2 +
 include/net/inet_sock.h                      |   2 +
 include/net/inet_timewait_sock.h             |   3 +-
 include/net/tcp.h                            |  12 ++
 net/ipv4/inet_connection_sock.c              |  12 +-
 net/ipv4/inet_hashtables.c                   |  31 ++++-
 net/ipv4/inet_timewait_sock.c                |   1 +
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/tcp_port_share.c | 182 +++++++++++++++++++++++++++
 10 files changed, 243 insertions(+), 8 deletions(-)


