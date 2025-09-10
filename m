Return-Path: <netdev+bounces-221665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBBBB5179B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FB8546EBC
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBC930CDA5;
	Wed, 10 Sep 2025 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RQxFlvKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34042D6605
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509736; cv=none; b=e5iBeJ9lFtUS6pDwk8uotzSZFm/lDKiR7gf4/myubeTbVbC3kpxXVdtadU6D/D6r6yZ08VCprlkWwyjKjOAVb9FSQdU4vwfV13nRBmL586470fzxip2zCiBHyut5lDJQoqSOWv11cfZhIgD+AwGlT0y7voDQu1ElFAZsmfS+RFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509736; c=relaxed/simple;
	bh=uFRm5bALLHjlbMvB1upzzhDhwRt2USEbXNMNQ4jf0II=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ky8IJVooM4OaWbqDaiLOj9uokoKRjrTOP5KK4NJAM4wTlTbtvDeRFmElNPIXZ+gmQgpBOOPDU3EPmO/0Rv5LI2GLMcx7kUNx+RNbm8tZBo0/zfmr3OWSXjCcYkEpD0Jkye/b5I0u8PQ89F89gBcCc5pZoPI2FPtd7Aim1P3P6L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RQxFlvKQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso11597805a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1757509733; x=1758114533; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NPDVR45PIjcyFAzHdgH1KMo+JNlGnSmQ/7b73jT0cPg=;
        b=RQxFlvKQpuWJZLIRRZxjvogOeeJHY+/ooUybnsWjKLF7Sqcp8np0xkqKgfcFqg0O8B
         71Nt9/T9jbJwVMWD+aHSuF4ZCvEilLFSKo3BLW3FNulC8kIICkcmQ/Sj07zb4KXSIA8c
         8HRxoctxz4WrSrDXhazki0mP0kDQrF4h1dz8vZ/RD8IzIb/gxwx0c+qDct8FLdmOoXOb
         tthMctzCRDIcdvYcx8yJMJ8LUTP4VOcAj+ZUkzONZbgkDskgp9KcYJ0VCZIeFwcf28na
         dgHIFSdnSxmEJDyzVRsWiHNWbmAEXTfjWwQyCKzUoEE1pZQdEj5K97nQjXnh4j2ax6ar
         /n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757509733; x=1758114533;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPDVR45PIjcyFAzHdgH1KMo+JNlGnSmQ/7b73jT0cPg=;
        b=KNqUxbxHGV7IQXLF7b7yCZM2JYQAErLivJAznxKHB6RTDpni52dtHr14QQn0IUZ9Te
         1zlNUED5qcu4WL9NFRXRQF2Dv0mMGQCB5fymEiXgY3xylr6yL+iWwie2cgUoVmgR64aw
         I1UgmH+b1WtnLSLhytPkgl4wP+HaJMtcju2BR697Tf1V+odj0/gHGcJvwrmakWoFiPMJ
         HHkpiAOv/uVGnpwYn4DYgO5Y82iF0lhYJuFo7wIk3baQyYna1bOa25uOffOf5phf1fZD
         j2rKFbPlChAWey7ljCv0K9rHZj1ec0dEgk9r5Z5A2jWR10NpLwRkHAcxjrHNCmM1xwF9
         CadA==
X-Gm-Message-State: AOJu0Yx/NeoNXTQCvXWH5qQkichcnYMu6CxYOd4Apiwbp9tAa5dSEYlT
	TTZgEhXXFdi+baTLopRq4boHQIIZyYY0uNI0Eh2ckJOJLb/Dy22Nnr5dEWb52CQ+pTk=
X-Gm-Gg: ASbGncuCP5VcPcYQLd6+WWOIts1aywI6+x7Ca3OLxcXLiLJHFs7pwbgJtmuKNQj7Mad
	AKabtaHyBKVdsVLvjcBTLlsZeLBzbvpznxkPAjzaLQNn9YiJ6Co8bj9a3GOHloCeKQcmrE1jVkg
	qSx3YxIcAjiX+AtCkF3fXtRn5HvfKnj92n82fckbLoh970HiGHubrDhoG5XayrfRaEgxkg9M9Mg
	L3ZGyVUXwPtYLLnXkkqxyVrS2hieexTEjeLaPvbvub6k39ajUUABhRnbYv2WWkwD7CPtmhqJwkt
	dQJmc2nsQAmo5wkE0Vrc1FORSnJAzq7SIHozF8WK5LeDZJczWGUBH+x2je5VzroVWKb04zNYyWb
	PXF7zDMzt1vznn0EMIdIEA5vGD3lwJsjkZiPdbvFUnNFhepmCOw0gvSetDtAgfFYoUzJ1x6+CxP
	HeXuA=
X-Google-Smtp-Source: AGHT+IEuoDX2S8qftaAf9xDU+VrVt2fiGaYu2LoQjzkTw7lyX49N+sJrsvDEhMIXiTWpQdqlSnL1VQ==
X-Received: by 2002:a05:6402:1eca:b0:627:4ee2:311b with SMTP id 4fb4d7f45d1cf-6274ee234c9mr11998078a12.10.1757509732762;
        Wed, 10 Sep 2025 06:08:52 -0700 (PDT)
Received: from cloudflare.com (79.184.140.27.ipv4.supernova.orange.pl. [79.184.140.27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfe99ffecsm3274970a12.1.2025.09.10.06.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:08:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next v3 0/2] tcp: Update bind bucket state on port
 release
Date: Wed, 10 Sep 2025 15:08:30 +0200
Message-Id: <20250910-update-bind-bucket-state-on-unhash-v3-0-023caaf4ae3c@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE54wWgC/42NQQ6CMBREr0K69pvyoQKuvIdxUdpfadSWtIVoD
 He3EhcmblzOTOa9J4sULEW2L54s0Gyj9S6HalMwNUh3JrA6Z4YcBW95A9OoZSLordPQT+pCCWJ
 6N97B5AYZBzBtjUKKBjvULIPGQMbeV8mRuXxwdE/slJfBxuTDY7XP5bp/RO0/orkEDkaaVvCu0
 7uyP6irn7S5ykBb5W+rY8YvLpZ/cTFzuUJei7qSAvGHuyzLC965RNE7AQAA
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


