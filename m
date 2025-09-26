Return-Path: <netdev+bounces-226784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C85E9BA534F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1001C043C4
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65BF284672;
	Fri, 26 Sep 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuUoqzr1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33D262FE5
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922175; cv=none; b=nUk2D52geETCZqLOLRpiX/PVeSET3bontuyS+V4pThm2PVf4vZu52JfDlhl1NhDE5ToRIbVA7zRa4RpWln33jv8JHad+Uc93tHhIZkhm7nJrKekr/sGEJu0GBZyFWjle5C2eWfK6Uc6nXgQmeF+VuSd9fMcJZOuxAPu9M4gmEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922175; c=relaxed/simple;
	bh=BC84h/NdZg5DwdRWA+NFTfMbXgDby3fKtXAK78feaZg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q6yH3kzl+SB+M20WlM5bP1w8qCiLMncEZnQJw6VN3iQW8N6Bpzn0BK4sUVOijZCJc51yQ7dr/eWNTevQjyEtXzFutrXIWYqbfZ19sWoC7cbZtIFJHAPNEE0lK8Qau7iDqQ1mFJAMNNpwxP4MBeMFynyTXUqGktdPOnnE9ZOBW5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuUoqzr1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78102ba5966so2469911b3a.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922173; x=1759526973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uXHufpRj8c/L6G34MuU/lpKDx35bZBQubeSQOU6Ugf4=;
        b=nuUoqzr1fxXu6F6S/XBAIIuNrGXgLsNBp97Wt17q7caAaWzR35ONH9e9SABDTAPDcX
         szY+uulC54pzEj4c6M2mNzQx4kK4PAZ9RUsK0V4UAjc1UOQ79lf4R18w/IOs5SlZKVnc
         TtAT3T7IXj6w23dNWncNrDZlr+M3otGwD3SRqp8fDAqk+Sa8kG/98SOCaop4/E+BNTIC
         eGSuY2XMc63i/xqFAajaStYnum2nnUE/L13Fxqo5x3jp9GXu1tm56DVbDFajTCM0w4cR
         6/Lg9f/hmxvzDwfOnB5FsNa519MLJnnb1PBMfA157TJBKXJPCaQj8CndHc4xz+ox4ULJ
         B8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922173; x=1759526973;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXHufpRj8c/L6G34MuU/lpKDx35bZBQubeSQOU6Ugf4=;
        b=QVcdsPshi3KUX5f7LeQp/2tjzpkXdWLq2+U2P8IceHGL623anv1ZIHMVkwizNZBR7M
         ofesDAkGlKNfD19fEcGQC9vwwrp6SOdtgqFWTgVypzHsWd0S9Zi1knaWUylvur+fdbyU
         FTzzTB04kGkyBqFwSB7lJ+Um8i0O81xIk5nNMfNrKVz5VpBZo63JRN7Y1spUPmkQnLXt
         Tvl+6gAztZYEAkwd6CFcxib9RE37q9UOVCsJgwLo0cl4hJTy5uhsUDjhiDtXZmALJy+3
         hS5Gzlo7qy/osqzAUnriFCeWyKSyCwwEdMUZpcNGOWJbeb/c56MLNjoDgmDsZey7534r
         Axxg==
X-Forwarded-Encrypted: i=1; AJvYcCVhBMOt3iE5+JOR8la4n/T6s5R6vOyv8JGM8QCwXC43qr235PoKzk5GjjkMH4cTWNVscz/fbsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyw1xoFE8qjLQynNE9xi5Up5KCys42T1XZrv2yRbfrR9fHlRwJ
	dWM163OrmeA2VFwqL7e/2bmUuCFEXXXb2QmtJT46brJtubqtOtVksxZZu8D113fCtFNE9rr5SAs
	9rOdk2A==
X-Google-Smtp-Source: AGHT+IFnff5qOX6MGMAsWkwlxVGuJbm85AbcnJKhe/OcPZgaYYppE0Q6rxbnpJ47C17AapLt9NVIE/+NIv4=
X-Received: from pfbct10.prod.google.com ([2002:a05:6a00:f8a:b0:77f:6432:dc09])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:98d:b0:77e:7302:dbe7
 with SMTP id d2e1a72fcca58-780fceca7c3mr9359072b3a.27.1758922173475; Fri, 26
 Sep 2025 14:29:33 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:28:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 00/12] selftest: packetdrill: Import TFO server tests.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The series imports 15 TFO server tests from google/packetdrill and
adds 2 more tests.

The repository has two versions of tests for most scenarios; one uses
the non-experimental option (34), and the other uses the experimental
option (255) with 0xF989.

Basically, we only import the non-experimental version of tests, and
for the experimental option, tcp_fastopen_server_experimental_option.pkt
is added.


The following tests are not (yet) imported:

  * icmp-baseline.pkt
  * simple1.pkt / simple2.pkt / simple3.pkt

The former is completely covered by icmp-before-accept.pkt.

The later's delta is the src/dst IP pair to generate a different
cookie, but supporting dualstack requires churn in default.sh, so
defered to future series.  Also, sockopt-fastopen-key.pkt covers
the same function.


The following tests have the experimental version only, so converted
to the non-experimental option:

  * client-ack-dropped-then-recovery-ms-timestamps.pkt
  * sockopt-fastopen-key.pkt


For the imported tests, these common changes are applied.

  * Add SPDX header
  * Adjust path to default.sh
  * Adjust sysctl w/ set_sysctls.py
  * Use TFO_COOKIE instead of a raw hex value
  * Use SOCK_NONBLOCK for socket() not to block accept()
  * Add assertions for TCP state if commented
  * Remove unnecessary delay (e.g. +0.1 setsockopt(SO_REUSEADDR), etc)


With this series, except for simple{1,2,3}.pkt, we can remove TFO server
tests in google/packetdrill.


Kuniyuki Iwashima (12):
  selftest: packetdrill: Require explicit setsockopt(TCP_FASTOPEN).
  selftest: packetdrill: Define common TCP Fast Open cookie.
  selftest: packetdrill: Import TFO server basic tests.
  selftest: packetdrill: Add test for TFO_SERVER_WO_SOCKOPT1.
  selftest: packetdrill: Add test for experimental option.
  selftest: packetdrill: Import opt34/fin-close-socket.pkt.
  selftest: packetdrill: Import opt34/icmp-before-accept.pkt.
  selftest: packetdrill: Import opt34/reset-* tests.
  selftest: packetdrill: Import opt34/*-trigger-rst.pkt.
  selftest: packetdrill: Refine
    tcp_fastopen_server_reset-after-disconnect.pkt.
  selftest: packetdrill: Import sockopt-fastopen-key.pkt
  selftest: packetdrill: Import
    client-ack-dropped-then-recovery-ms-timestamps.pkt

 .../selftests/net/packetdrill/defaults.sh     |  3 +-
 .../selftests/net/packetdrill/ksft_runner.sh  |  6 +-
 ..._fastopen_server_basic-cookie-not-reqd.pkt | 32 ++++++++
 ...cp_fastopen_server_basic-no-setsockopt.pkt | 21 ++++++
 ...fastopen_server_basic-non-tfo-listener.pkt | 26 +++++++
 ...cp_fastopen_server_basic-pure-syn-data.pkt | 50 +++++++++++++
 .../tcp_fastopen_server_basic-rw.pkt          | 23 ++++++
 ...tcp_fastopen_server_basic-zero-payload.pkt | 26 +++++++
 ...ck-dropped-then-recovery-ms-timestamps.pkt | 46 ++++++++++++
 ...cp_fastopen_server_experimental_option.pkt | 37 ++++++++++
 .../tcp_fastopen_server_fin-close-socket.pkt  | 30 ++++++++
 ...tcp_fastopen_server_icmp-before-accept.pkt | 49 ++++++++++++
 ...tcp_fastopen_server_reset-after-accept.pkt | 37 ++++++++++
 ...cp_fastopen_server_reset-before-accept.pkt | 32 ++++++++
 ...en_server_reset-close-with-unread-data.pkt | 32 ++++++++
 ...p_fastopen_server_reset-non-tfo-socket.pkt | 37 ++++++++++
 ...p_fastopen_server_sockopt-fastopen-key.pkt | 74 +++++++++++++++++++
 ...pen_server_trigger-rst-listener-closed.pkt | 21 ++++++
 ...fastopen_server_trigger-rst-reconnect.pkt} | 10 ++-
 ..._server_trigger-rst-unread-data-closed.pkt | 23 ++++++
 20 files changed, 610 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-cookie-not-reqd.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-no-setsockopt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-non-tfo-listener.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-pure-syn-data.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-rw.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-zero-payload.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_client-ack-dropped-then-recovery-ms-timestamps.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_experimental_option.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_fin-close-socket.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_icmp-before-accept.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-accept.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-before-accept.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-close-with-unread-data.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-non-tfo-socket.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_sockopt-fastopen-key.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-listener-closed.pkt
 rename tools/testing/selftests/net/packetdrill/{tcp_fastopen_server_reset-after-disconnect.pkt => tcp_fastopen_server_trigger-rst-reconnect.pkt} (66%)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-unread-data-closed.pkt

-- 
2.51.0.536.g15c5d4f767-goog


