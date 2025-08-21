Return-Path: <netdev+bounces-215589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D122DB2F5ED
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 762DB7BB2D1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4132130BF76;
	Thu, 21 Aug 2025 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZFiQLjZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3342EA496
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774565; cv=none; b=Sc4as3A0iZnDs2NPyEZUagYc9E16cK8pQWE8qTNswEgVsGAfBvT8+hgM3WfE7VUUBYOeAKnd1RkGwjc7hON8sDOeNrbhdtwEa7iUr6+k6LkzRyhpbmYwYtoEKZmEwDPLtSfMVqdWnTwwQ0GMcLyLsKQ+DFivFPzPjpDqWxpt/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774565; c=relaxed/simple;
	bh=1c+goLExn1eRusLUfa3gP2NQXicYYmfW5NAQGa0fm3M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IfmfGOvPyvTrtouia9xJ+xXfGU9CFMlMei0e1+rUks0cc4yjt0xhRDhT9VAoJpYkk8M+hT24qc57nBRJETLhZNymDHvaca3M9ckZinU0PiheXsNEGNXFH54mSdJ1uduc16vQQU4GTYVLzG1Lf2+JObpD/sw8Lx9gRKLzYtxPQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZFiQLjZu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7acfde3so131184566b.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 04:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755774561; x=1756379361; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DhpFvt6AQ2lDRQvWU+F6twkSMy4Kc9yQ1g1pSNvVd58=;
        b=ZFiQLjZu7wPeBJtlxzd9DBsTpCjUddgPCmzEhxDB2j8y/BWeGmUQBnRpnfOBLWNn7R
         9jx2U2mdrNQrVe/6ibhBBvoi3Rsy84/qreIJl4P5l88Z33z0yfTvQzrfM6i0xQn5xRkK
         iYu90tnAk5dhWsz5avMfXv7JgEex/A/RIiXO0HI70TWarHap7erUATL+YUPSBImXi4F8
         wvsyTOCaKRq5rbfTOUr66BZK7XixWpiokrOA6dJS6J49Mos6M8+ExOz5O8oJo9z7QnOR
         smmT/tVFnoWoHsKynhv2neG85ojNpa6FrhO70BD0im6yH6/QAsbg4XKYTiZirhAio+UR
         Ci5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755774561; x=1756379361;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhpFvt6AQ2lDRQvWU+F6twkSMy4Kc9yQ1g1pSNvVd58=;
        b=ZcmXDbMoWAieeQ61hOQaL/Y7493nEbZTKBelY+uFMBxLNxkw5bBp6Dv5ma0u3TKjFl
         OJexKUg+lt8HNHYbG+olrjG5QxqhnE+VFgNZGgwm7YxIUMJ1P/phNIIFIajdj8ZGSTvi
         7SBwtFN6WTAAU/2IpcJSPxHtiV6Dakp7t5GOrbwvcs2fMN0+bthksl/wFc+otJPOPtOa
         EJkZL9/sLl2vlLJvsSvBVYYcjuLl3z4Xb/c+4Tp06Pu3nTV91vyopggB33FvjAT3oxj1
         FNO2T6rdSuf0i1FbM/C2nhIXJuuOWFtMPEplVknprxigRDwnBiWeYq473E6VfYI0jRJi
         Qy0w==
X-Gm-Message-State: AOJu0YwoBaEwYtFsnWFaLZB1Y9RxJDExOV5cISP06cOUQyDh4qseM0oZ
	6JDnWqshiFWhyFrasBrdeeBvhRGWeWsdTaxud5xxx9KmKj329a1/mAC81fz7mZMN338=
X-Gm-Gg: ASbGncuG8SbSl/RGZ3clZGtr/0xRiCazneR5p2We4G3zPEXF0r1g/SlWT57EPSte67m
	S0XOA6byCoMxXvnI94HHxBJ1cll/FyUSP8lpoNLwSn0HSU0BQh0WLnYlYEh1az0FfhpVSRbMuTp
	gBl7BdSS0dIpf2bnWKzIAU864xUDebV9dAf+GgWCotz3ndB0Uo5fSEDLetJWq68A2MUGmgriSCs
	Ld6iE3RWtL4KEicw0RUeWc6+oYPchQnGYi+eGliTJZVrpt0wJAxwcUMujDupJF/rsZpjVe6YsCD
	xF3IPs8tdkRiwxtTcnYIwsDWQLgmHc6+hwT6TKq2XIYfpwqnnMkqeud7hZjDyg9+VebtxK3A+aP
	AW3hGkYA66UoM+IHYYu2FIIEElfjF7H5sfgM0+44gP9b8KK4bHEii95HB+aS1WWhuLXWKSzhmbr
	VSmrI=
X-Google-Smtp-Source: AGHT+IGX032EmZHZKbeBt1Hjyg1n3INOXQWD9kBFpeA0i9TCEyOrDonvwWNsdnltVbbCFYyz40hhMA==
X-Received: by 2002:a17:906:d54b:b0:ae0:b847:438 with SMTP id a640c23a62f3a-afe07a0acc7mr184114766b.21.1755774561391;
        Thu, 21 Aug 2025 04:09:21 -0700 (PDT)
Received: from cloudflare.com (79.191.55.218.ipv4.supernova.orange.pl. [79.191.55.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdfe05ace0sm214298666b.112.2025.08.21.04.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:09:20 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next v2 0/2] tcp: Update bind bucket state on port
 release
Date: Thu, 21 Aug 2025 13:09:13 +0200
Message-Id: <20250821-update-bind-bucket-state-on-unhash-v2-0-0c204543a522@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFn+pmgC/42NQQ7CIBREr2L+2m8oEdu68h6mCwofIVZogDY1T
 e8uNh7A5ZvJzFshUXSU4HpYIdLskgu+AD8eQFnpH4ROFwbOuGANq3EatcyEvfMa+0k9KWPK3yR
 4nLyVyaJpzlxIUfOWayhHYyTjll1yB18GnpYMXWmsSznE926fq73/iZp/RHOFDI00jWBtqy9Vf
 1NDmLQZZKSTCi/otm37AMkkdAvjAAAA
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
 include/net/inet_sock.h                      |   2 +
 include/net/inet_timewait_sock.h             |   3 +-
 include/net/tcp.h                            |  15 ++
 net/ipv4/inet_connection_sock.c              |  12 +-
 net/ipv4/inet_hashtables.c                   |  32 +++-
 net/ipv4/inet_timewait_sock.c                |   1 +
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/tcp_port_share.c | 258 +++++++++++++++++++++++++++
 10 files changed, 323 insertions(+), 8 deletions(-)


