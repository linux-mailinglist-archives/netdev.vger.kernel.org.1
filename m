Return-Path: <netdev+bounces-226930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80414BA638B
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D6A3AF57D
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9CC21B9C8;
	Sat, 27 Sep 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHytXqIS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D767E0E4
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008635; cv=none; b=pGgaEnxA7Hcd/prOP8MSezBnZrmJu2MIgwT65jNk+mjMc7oi9mRtNBhBt8zS64AW8JMN2EYU/9lxNRSuzNdAJEkozh+mwnzT3k933b4+IQWt0Q0ycfJ6L7fDrWZeAhd5/8fOsCz548oz+6Gy9+Dd7zZCjr9fMeZ54EjxYbkopGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008635; c=relaxed/simple;
	bh=D+9zFc0FFoHf5i3SDZseWsG59qM1dbdarCJr1SL9x3Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qVUN1O6z7573OFYu73XZ3lHVonGAXxinC/C62F9l+k/1A8sPVLfMcS6jQ25gPasRaF5Qv91LOsJoTS+BB1AlgJrwbYZp3+Npaz0Q6qPDKHjnLtOi5I0WKCWlcY/2xNNnT9tiTneiiA9NZPhit5Xj9UHJPf5IWRb3qcNnDizGmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHytXqIS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3307af9b595so3022312a91.0
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008633; x=1759613433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0nwgYmz3uaXt9rqXGWzHMbVbyGCGN0oxg8g37oSU8zk=;
        b=tHytXqISzdo/ju6WGbNFtkoGFCEt5JQZxTX2KvtecCaHDrTqunOwWurXWlCDiEVb3g
         +RVuaeY5fL9fBPMq98h1j4nG5KHQolPRgK+HcJeTn98vemfXwvVouY6mv9RJRZ/drdtE
         19ALM1Aj0S9qpZ4h8PvpKBxo0QSpBjZuCbBwXVfBjKwKEQ2QVqdT9DyL3Voy5RfFcr5w
         XuXkOaJz6Nq2/NVkyY7wKEBsRoHxovqpJ93yxXMOH0tMAvQcbtztSmn8abGdbwPAJ4f7
         ccqnGpHeR+YqpYS3uLvw2SmJzt4wIe+lQWw0SoKvl2gc8svhunwtmqSUZNyAler8KthS
         xCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008633; x=1759613433;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nwgYmz3uaXt9rqXGWzHMbVbyGCGN0oxg8g37oSU8zk=;
        b=QNvytf+1QWllTYeQ/UYCEiovq80OuVqlOEGW2Fg+EQBGVU6DI5oC0UvtL9uEM2Rlvy
         P/VoCEwa1Cd9CudvcHajW683HMeoEatDzdSNPflD9tUA1bsxFpZCcg3VG9E7xH94PKSi
         6WafXAow7BrlkJm1nHbQ68lsHMIVEjQnDpDvpkfC2+se2fk/CNqMmTkEpRc6LVq/U31v
         62q411Sxgr8QncDBId7SbVWStVcylw7y0KHBxAwMsnCWqqYW9k/tkzjaJSHiflbLYR6z
         vJFikRwznIaZHuhrHkUKnHLvF9GvBvucf+jutPpNb21MCw3TGWUeb5CrLmjYGGuhRzfy
         BpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXwed2m91hZNqkFlH+xJjpOvJocMi2mWujhcPRhVNRyre7a6kwntqsKd+O4a9jT1gyNCKLfoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+XFuz4x+ZiJAR9/H/oxKiXujZ2EuBeajpkXlAuXuLAWCr+em3
	Z4LlNyNzdyCoqschyW+BbXmX59Xi+QFgNSqts0ZFKK2NMcUQ4go+CrQL1EYoZfPaEKGcmRxhjcO
	i31yyfQ==
X-Google-Smtp-Source: AGHT+IGMyrceBHk2j4E6fofUmrMKBlwxCdS/4qeTP9uJfxMchYKhjx5bLGAPsauBcHzpr5QxHdO4+IvGDOg=
X-Received: from pjbnm6.prod.google.com ([2002:a17:90b:19c6:b0:330:5945:699e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a49:b0:32b:a332:7a0a
 with SMTP id 98e67ed59e1d1-3342a242c7cmr11090702a91.1.1759008633011; Sat, 27
 Sep 2025 14:30:33 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 00/13] selftest: packetdrill: Import TFO server tests.
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
cookie, but supporting dualstack requires churn in ksft_runner.sh,
so defered to future series.  Also, sockopt-fastopen-key.pkt covers
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


Changes:
  v2:
    * Add patch 1 for icmp-before-accept.pkt.
    * Patch 2:
      * Keep TFO_CLIENT_ENABLE for
        tcp_syscall_bad_arg_fastopen-invalid-buf-ptr.pkt.

  v1: https://lore.kernel.org/netdev/20250926212929.1469257-1-kuniyu@google.com/


Kuniyuki Iwashima (13):
  selftest: packetdrill: Set ktap_set_plan properly for single protocol
    test.
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
 .../selftests/net/packetdrill/ksft_runner.sh  |  8 +-
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
 20 files changed, 611 insertions(+), 6 deletions(-)
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


