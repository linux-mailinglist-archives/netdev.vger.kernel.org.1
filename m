Return-Path: <netdev+bounces-224032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B286B7F2C2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199317BB053
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5401AA1F4;
	Wed, 17 Sep 2025 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aGxEGVAX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EFB33C773
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115335; cv=none; b=FTjbpOEyAtKzr5HknE6dfv3lp/YadZYm/2ajKZRKs8oTMXiDt9CK83LQ1XONNf6TS0CFfxkD1EaZdEcOqOqI8EpvZ59cHBmzx7mmaPiUZ0afIPawW8lfNCY6RAF7d1n2g8aRLxtuo5NVnvC9iGoSBtSrU3mcRHl0Vrt5223fpyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115335; c=relaxed/simple;
	bh=SskrMhc+baRIk2wshNN8yYA/DUeFmc7xb1EKKQMCh6E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LHewW24T9xzsTEhOOq5BbdnRBzKutqCwKxjcofHpJtpFg5SRtM/cbHXt5FLuFK3F1WbGuvJkyJV5VZjUu2nAc/yYdFn6LmTVPuG5t5OSpb2vbIDgTRw1ilYCT01BivgN/lyIydcvmNTyJcEJTgWzj+MQiJFOYbw7pPs95Us9R7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aGxEGVAX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f277546abso8214986a12.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 06:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758115332; x=1758720132; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MG5mE8BumLZV4RAxNdz/1d3caBAqNcPqIhSFatN8Rng=;
        b=aGxEGVAXKbqiUJWvs5tGrOqQJodleIPHAe+12BxoMF8OM+WShxO4ZR7SvmbMlD8KUQ
         ZM4JMwMsrUbHd+tPwzy3vPGSdwvpW+Fj0vPo/0Hx1VNEj8IcbbnHmK8gRHCUJpj9ez06
         CthOYvdhBX1WaMdw39Zyyu2MGqW2JObgWHZi8bBZdy2dhFS6FJB5o7YYi0Hlfz8D6gWh
         kPeKOAxlHDTm+YfLmqTSaR8UkS25Zs9nKEnyzVLhXIQLn5JD4ZSi+ZKWvEYzCQ5uw3X9
         PgEslm+gNev1Cn6+MCmNxRXvgvdAFzyDTUbXiaAXTgxQZNzH1axVwZpKgWG2ruUWOfTm
         wl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115332; x=1758720132;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MG5mE8BumLZV4RAxNdz/1d3caBAqNcPqIhSFatN8Rng=;
        b=FJaISVpFauQhXHn9ZFbCAG7xLzJFZX41D4+efKZacMsRI8OgS5Hqi3n+Kt7zXh8ai+
         tbiMnOKvwY4B50Dg+h3kuBX0ocGCYiMzHvASNmotxFFw/FDBqXJlwyo/QZo7F6VLYffq
         OuAKxO5DvY6zYPiEIOhjDrpABm/inKTnI76EkKHizivSvpVpgiCui5ya4WaQHn1V2igG
         ffeiKa06/T7VOg7pd840y3FwmJujhtzMKkvCG+NPiQ9kwmVhb8QmPw2axlLZJNfBpqft
         chla+Dwk3Ml1AJRUeKoPa/tpazHI79Gy+78LcQtmJ65fX6fbai+DQ7yZecCyvwE72sFD
         7WLg==
X-Gm-Message-State: AOJu0YwbdfE2TLAtvVyxbAuTaq+Nz9INr4YycOZ5E5d+KUZFiPumR2uW
	pWgzCUn8s5mAgE+tJlmRLGRAX8jix/g1ROvWCNDEqWqXP8Gk+g5rnW+G+3XD1OpB6JCnq39kYbG
	PgQ3a
X-Gm-Gg: ASbGncunsTqp82f+E6DH1v4FujHrVIETjHFadsqayFOW7DdMetAN9o11OYtCYbmYfbV
	e1QyLd0YG6Qp3JdMjoolz4EgjygBYM8PMJA+E6WosqVGiv2+6jkxC7vtAJtR0UmQzH+L8IuW2J/
	rhyCQuv0Bd9XzDx+Hg9F0qNstDTZfN/HH1S2IBP2iVVW1Dv6UVSapB0uhYgESAkWwOARUJ/Pst/
	zMLacc1bGpGdRZhRZrLbptZlFp4p+dmFeYXQN6+C1nRvQ654zJ5eNwnDXyRWPlPK3h0DutVXm9j
	OH9ew17/vx4H+ZIvaHjGAz5SHt3U323Lm+1Ph+ykGbzF4ksTC87FdithTZxdrqZBgDnXIi5y//G
	rHGKKS0Gca1TW98g=
X-Google-Smtp-Source: AGHT+IHUaxe0AnXph4dBIevozEZnUOcrwvDqIl2g8h8IvDVF4l6egDSUPF8nXc6ljHILalz+X+vDAQ==
X-Received: by 2002:a17:907:3d8e:b0:b09:48c6:b7b0 with SMTP id a640c23a62f3a-b1bc00ff8a1mr275398166b.56.1758115329082;
        Wed, 17 Sep 2025 06:22:09 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:295f::41f:64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07cedd8cdesm1064763366b.24.2025.09.17.06.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:22:08 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next v5 0/2] tcp: Update bind bucket state on port
 release
Date: Wed, 17 Sep 2025 15:22:03 +0200
Message-Id: <20250917-update-bind-bucket-state-on-unhash-v5-0-57168b661b47@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPu1ymgC/43OwW7DIAyA4VepOI8JDDTJTnuPaQcHzILWQQUk6
 lTl3UejSau0HnI0lr+fKyuUAxX2criyTEsoIcU2mKcDsxPGD+LBtZmBACN60fH57LASH0N0fJz
 tJ1Ve6u0lRT7HCcvEfa/BoOlgAMcadM7kw2WLvLHYDiJdKntvmymUmvL3Vl/ktv8N9XtCi+SCe
 /S9EcPgjnJ8tac0O3/CTM82fW2NBe5ckLtcaK6wILTRCg3AQ1f9uYMUu1x1c0FZRK+RlH3o6nt
 X7XJ1c1X76bEzg3a+++eu6/oDHLpYPusBAAA=
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

Changelog
---------
Changes in v5:
- Fix initial port-addr bucket state on saddr update with ip_dynaddr=1
- Add Kuniyuki's tag for tests
- Link to v4: https://lore.kernel.org/r/20250913-update-bind-bucket-state-on-unhash-v4-0-33a567594df7@cloudflare.com

Changes in v4:
- Drop redundant sk_is_connect_bind helper doc comment
- Link to v3: https://lore.kernel.org/r/20250910-update-bind-bucket-state-on-unhash-v3-0-023caaf4ae3c@cloudflare.com

Changes in v3:
- Move the flag from inet_flags to sk_userlocks (Kuniyuki)
- Rename the flag from AUTOBIND to CONNECT_BIND to avoid a name clash (Kuniyuki)
- Drop unreachable code for sk_state == TCP_NEW_SYN_RECV (Kuniyuki)
- Move the helper to inet_hashtables where it's used
- Reword patch 1 description for conciseness
- Link to v2: https://lore.kernel.org/r/20250821-update-bind-bucket-state-on-unhash-v2-0-0c204543a522@cloudflare.com

Changes in v2:
- Rename the inet_sock flag from LAZY_BIND to AUTOBIND (Eric)
- Clear the AUTOBIND flag on disconnect path (Eric)
- Add a test to cover the disconnect case (Eric)
- Link to RFC v1: https://lore.kernel.org/r/20250808-update-bind-bucket-state-on-unhash-v1-0-faf85099d61b@cloudflare.com

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
 include/net/inet_timewait_sock.h             |   3 +-
 include/net/sock.h                           |   4 +
 net/ipv4/inet_connection_sock.c              |  12 +-
 net/ipv4/inet_hashtables.c                   |  44 ++++-
 net/ipv4/inet_timewait_sock.c                |   1 +
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/tcp_port_share.c | 258 +++++++++++++++++++++++++++
 9 files changed, 322 insertions(+), 8 deletions(-)


