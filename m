Return-Path: <netdev+bounces-222774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0286CB55FFC
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 12:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E778A0611C
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5350427A929;
	Sat, 13 Sep 2025 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dandmRlw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501584A3E
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758179; cv=none; b=CRNbgPO11bpTh2SdUOTfw+o4UQM/ReeQAUoaN/0Bge0MvHI4DpoOaRWyPhJlhLltNOwoVmIa4xKZflX1Vpb1JQQh6M82BVixTAOpbTZEou+w/FTXzsnmwV2ThKH02y9ev5xQeB3WRsm9BJ93ybzsaninKaLB0r4UrSI0aUpunCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758179; c=relaxed/simple;
	bh=3EouefFzVlZzpFRAlcUy8lLK/DYzDOIFf2XfrhlIdWY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MxggJviam3derQgtLVlUdk7iKPW8iLw7cJGo8XCi8DLUZwHF6H11gnEi9QHtN3Sxw0bgBoXSGZBY+Swg5of2vb0fTbJOR83WmNZV5COTBEfTWbGRql1P9q87EG6OFBvNAe2Dgnn1OAETgHOETMfBLp2R3NwLV8ozxZ1i3N45kP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dandmRlw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-625e1ef08eeso4617877a12.1
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1757758176; x=1758362976; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6jzVWe4XUQ1yEtOa9IO5roZPL49CUVqGrZpOv3TozI=;
        b=dandmRlwBxSVZ7NobUj/JlySH9JvnvtF3rwQHqxTcoWxuj0g0SwOFuHvblTYCgUu3e
         JYUpPqH76+K54+mf3PoiP5eO3W8vUdvDmclSqEuHS6ebu7dtzZCHW3zjKiiX0z9wj/MB
         I003YrX3juIiW6If2OlatRq45/ZKjX3M7vt/nBK62B8JBc9dudXHeQ66Kw7B4xEDNlHN
         XLcXK5NNE8Ij3KEIOSuEJMa7wB0t9qUPse9Wi5b26HB90bdpLBBpi3YcPciIORbMjwIR
         A7dOZUO5f67uLD6YEeJ5XKPbzrUkNrf8L9f6FamP1WRyAPPxrPbWNmKohTr1r+9MTFNO
         Mfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757758176; x=1758362976;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6jzVWe4XUQ1yEtOa9IO5roZPL49CUVqGrZpOv3TozI=;
        b=nw7pePJeRxBdhaRbhX/Se0CmowiWe1Jh5yGmGpbQ5CVAGN3DAtwFtMUBny2Zez4lMc
         lcKkInov+e+Cc3DUpv7zFCKFJBVMghQVzJGsOLoWTYzV//iVLbugsmGPxFtSkUT0TwkW
         PYpPB+lv69sR6E+thwZde9OVlkHYjqIx2hV0qjUslWrZqMzBBQUYGbDyz5uJZ2zqOyR+
         UR/9jzOQDas8J5DpZEVKfJy9rPYQVECPsJbMy+trLoH2LJMMhIfURmkRWbWRYYC02vyL
         SHXUZ+w3fYSQNVYN9TWecuxvxayppbBW68niZktZyCwL1ltypKlW7fKvssI1iPCvS2S4
         VbYw==
X-Gm-Message-State: AOJu0YzxAvAmatnUMG+0a+Lj4IDzdWHZ0sRCwaidRD32qP8iI4aL+CLo
	W56VbTrDXvdjlf3kbin/vkIjcdEEabNQrzs1Xb/I7aN6lsFlEEfv/YXhEWZMiiwlrhE=
X-Gm-Gg: ASbGnctQyKbr3ovozzOR5uVZ5P92NhvgiJuMUH5KV1h1sYydYdVZxw//A7bGeDcV86Z
	H8EwFR9+v7Qw1t4CzApw3gUU9UONPbU3JMkbh9Juia3OzTI8RgtPP7/yCNA/pm2sr2QTX/VKJ2P
	aMywFVr0hD5OGuE8XQlh1R6jD0jsJVdA68Uu63muGkeNRX4mYjteQVKX1ak7J0w8FWMmCJjoTag
	II587+ghHdz5eXF+6p2yPAqbt9k9SACPqkoPQV/mdbg/Who4e+U2LKSDt3dzL7iDikJtWUldkhT
	PMNVJMXzAnKhUK3nUc8hkof+/Bk6ElCT6z9zBHOSsWp78XFpaF5jEsOOh4D5Gsa97VTO3SrADJU
	2EDwDMvpWiZEc+Ffw0NY1pFiDBMgJ+qmJ0XP0lJXDu3TdgxmyHyP8OfJVhG8A6XZEhaNwD3BklP
	UYH84=
X-Google-Smtp-Source: AGHT+IFtAS0O7nMucSSOwcC0x+0okdZQrppX9G/w9FfR4EtN1k8/m3r5OSqEfDi+lMeG8kz8Ide/Sw==
X-Received: by 2002:a05:6402:2809:b0:61d:cd5:8b72 with SMTP id 4fb4d7f45d1cf-62ed866ac49mr6369253a12.31.1757758175604;
        Sat, 13 Sep 2025 03:09:35 -0700 (PDT)
Received: from cloudflare.com (79.184.140.27.ipv4.supernova.orange.pl. [79.184.140.27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec3410e76sm4916508a12.49.2025.09.13.03.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 03:09:34 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next v4 0/2] tcp: Update bind bucket state on port
 release
Date: Sat, 13 Sep 2025 12:09:27 +0200
Message-Id: <20250913-update-bind-bucket-state-on-unhash-v4-0-33a567594df7@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdCxWgC/43NwW7DIAyA4VepOI8JDKxJT32PagcHzILWQQUk6
 lTl3UejSp20HXK0LX//jRXKgQo77G4s0xxKSLEN+mXH7Ijxg3hwbWYgwIhO7Pl0cViJDyE6Pkz
 2kyov9b5JkU9xxDJy32kwaPbQg2MNumTy4bpGTiy2h0jXyt7bZQylpvy91me53h+hbktollxwj
 74zou/dmxyO9pwm58+Y6dWmr7Uxwy8X5CYXmissCG20QgPwr6uebi/FJlfdXVAW0WskZf+4y7L
 8AJ7595uTAQAA
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
 net/ipv4/inet_hashtables.c                   |  40 ++++-
 net/ipv4/inet_timewait_sock.c                |   1 +
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/tcp_port_share.c | 258 +++++++++++++++++++++++++++
 9 files changed, 318 insertions(+), 8 deletions(-)


